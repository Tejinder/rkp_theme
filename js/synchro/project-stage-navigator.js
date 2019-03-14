var PROJECT_STAGE_NAVIGATOR = {
    currentStage:2,
    stageLabel:'',
    options:{},
    projectId:null,
    stages:[],
    activeStage:-1,
    initialize:function(opts) {
        var that = this;
        if(opts) {
            this.options = opts;
        }

        if(this.options.currentStage) {
            this.currentStage = this.options.currentStage;
        }

        if(this.options.projectId) {
            this.projectId = this.options.projectId;
        }

        if(this.options.activeStage) {
            this.activeStage = this.options.activeStage;
        }

        ProjectStageNavigatorHelperService.getStages(this.projectId, function(stages){
            that.stages = stages;
            that.setCurrentStage();
//            that.activeStage = 6;
            that.generateStageNavigator();
            $j.event.trigger("projectStageNavigatorCreationComplete");
        });
    },

    setCurrentStage:function(){
        for(var i = 0;i < this.stages.length; i++) {
            var stage = this.stages[i];
//            if(i == 5) {
//                this.stages[i].currentStage = true;
//                stage.currentStage = true;
//            } else {
//                this.stages[i].currentStage = false;
//                stage.currentStage = false;
//            }
            if(stage.currentStage) {
                this.currentStage = stage.stageNumber;
                break;
            }
        }
    },

    generateStageNavigator:function() {
        var that = this;
        var parDiv = $j(this.getDivTag('stage-navigator','stage-navigator'));
        this.generateStages($j(parDiv));
        /*ProjectStageNavigatorHelperService.canChangeProjectStatus(this.projectId,function(canChange){
         if(canChange) {
         var changeStatusSpan = "<a class='change-status' href='/synchro/project-status!input.jspa?projectID="+that.projectId+"'>Project Status</a>";
         $j(changeStatusSpan).appendTo($j(parDiv));
         }
         });*/

        $j(parDiv).prependTo("#main-container");
    },

    generateStages:function(parent) {
        var ul = $j("<ul class='progressbar'></ul>");

        for(var i = 0; i < this.stages.length; i++) {

            var stage = this.stages[i];
            var li = $j("<li id='stage-"+stage.stageNumber+"' label='"+stage.stageName+"' data='"+stage.stageNumber+"'><span>"+stage.stageName+"</span></li>");


            if(stage.hasAccess) {
                $j(li).addClass("enabled");
                if(this.activeStage != stage.stageNumber) {
                    this.stageClickHandler($j(li), stage);
                }
            } else {
                $j(li).addClass("disabled");
            }

            if(stage.stageNumber <= this.currentStage) {
                $j(li).addClass("fill");
            }

            if(stage.projectEvaluationStage) {
                if(stage.projectEvaluationCompleted) {
                    $j(li).addClass("completed");
                } else if(stage.projectCompleted && !stage.projectEvaluationCompleted) {
                    $j(li).addClass("not-completed");
                }
            }

            if(stage.currentStage) {
                $j(li).addClass("current");
            }


            if(this.activeStage == stage.stageNumber) {
                $j(li).addClass("active tooltip");
                $j(li).find("span").html("");
            }

            if(i == 0) {
                $j(li).addClass("first");
            } else if(i == (this.stages.length -1)) {
                $j(li).addClass("last");
            }

            $j(li).appendTo($j(ul));
        }
        $j(ul).appendTo($j(parent));


    },

    generateStage:function(parent, stage) {
        var that = this;
        var stageNum = stage.stageNumber;
        if($j(parent)) {
            var className = "stage";

            if(stageNum == 1) {
                className += " first";
            } else if(stageNum == this.stages.length) {
                className += " last";
            }

            if(stageNum <= this.currentStage) {
                className += " fill";
            }
            if(stageNum == this.currentStage) {
                className += " current";
            }



            if(this.activeStage == stageNum) {
                className += " active tooltip";
            }

            var liTag = $j(this.getLiTag("stage-"+stageNum, className));

            if(stageNum > 1) {
                this.generateStageSeparator(parent, stageNum);
            }
            $j(liTag).attr("data", stage.stageName);
            $j(liTag).appendTo($j(parent));

            that.stageClickHandler($j(liTag), stage);
        }
    },

    generateStageSeparator:function (parent, stageNum) {
        var className = "separator";
        if(stageNum <= this.currentStage) {
            className += " fill"
        }
        $j("<li class='"+className+"'></li>").appendTo($j(parent));
    },

    stageClickHandler:function(target, stage) {
        var that = this;
        var stageNum = stage.stageNumber;
        this.stageClickResponseAction(target, stage.hasAccess, stage.stageURL)

    },

    stageClickResponseAction:function(target, hasAccess, stageUrl) {
        if(hasAccess && stageUrl) {
            $j(target).bind("click",function(e) {
                window.location.href = stageUrl;
            });
        }
    },

    generateStageLabel:function(parent, stage) {
        var that = this;
        var stageNum = stage.stageNumber;
        if($j(parent)) {
            var className = "stage-label-"+stageNum;

            if(stageNum == 1) {
                className += " first";
            } else if(stageNum == this.stages.length) {
                className += " last";
            }

            var liTag = $j(this.getLiTag("stage-label-"+stage.stageName, className, stage.stageName, stage.stageURL));
            if(this.activeStage == stageNum) {
                $j(liTag).find("span").addClass("active");
            }
            that.stageClickHandler($j(liTag), stage);
            $j(parent).append($j(liTag));

        }
    },
    generateStageNumber:function(parent, stage) {
        if($j(parent)) {
            var stageNum = stage.stageNumber;
            var className = "stage-number";

            if(stageNum == 1) {
                className += " first";
            } else if(stageNum == this.stages.length) {
                className += " last";
            }

            if(this.currentStage == stageNum) {
                className += " active";
            }
            $j(parent).append(this.getLiTag("stage-number-"+stageNum, className,stageNum));
        }
    },

    getUlTag:function(id, className) {
        var ul = "<ul";
        if(className) {
            ul += " class='"+className+"'";
        }
        ul += "></ul>";
        return ul;
    },

    getLiTag:function(id, className, content) {
        var li = "<li";
        if(className) {
            li += " class='"+className+"'";
        }
        li += ">";

        if(content) {
            li += "<span>"+content+"</span>";
        }
        li += "</li>";

        return li;
    },

    getDivTag:function(id, className, style) {
        var div = "<div";
        if(id) {
            div += " id='"+id+"'";
        }
        var cls = "";
        if(className) {
            cls += " " + className;
        }
        div += " class='"+cls+"'";
        if(style) {
            div += " style='"+style+"'";
        }
        div += "></div>";
        return div;
    }
};