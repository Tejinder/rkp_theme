var AUTO_SAVE = {
    form:null,
    delayTime:-1,
    intervalId:null,
    projectID:null,
    isFormDirty:false,
    autoSaveEnabled:false,
    register:function(options) {
        if(this.autoSaveEnabled) {
            var that = this;
            if(options) {
                if(options.form) {
                    this.form = options.form;
                }

                if(options.projectID) {
                    this.projectID = options.projectID;
                }
                console.log("Registering auto-save...");
                this.attachListeners();
            } else {
                throw new Error("Unable to register Auto save.")
            }
        }
    },

    attachListeners:function() {
        var that = this;
        this.resetTimeOut();

        $j(this.form).submit(function(event){
            that.resetTimeOut();
        });


        $j("body").bind("projectStageNavigatorCreationComplete",function(event){
            $j(".stage-navigator .progressbar li").bind("click",function(e){
                if(that.isFormDirty) {
                    that.saveFormData();
                }
            });
        });

        $j("#j-header a").bind("click",function(e){
            var self = this;
            e.preventDefault();
            if(that.isFormDirty) {
                that.saveFormData(function(){
                    window.location.href = $j(self).attr('href');
                });
            } else {
                window.location.href = $j(self).attr('href');
            }
        });

        $j(".main-sub-menus a").bind("click",function(e){
            var self = this;
            e.preventDefault();
            if(that.isFormDirty) {
                that.saveFormData(function(){
                    window.location.href = $j(self).attr('href');
                });
            } else {
                window.location.href = $j(self).attr('href');
            }
        });




//        $j(window).bind("beforeunload",function(event){
//            console.log("Hello....::" + that.isFormDirty)
//            if(that.isFormDirty) {
//                return "You have unsaved details.";
//            }
//        });
        setTimeout(function(){
            $j(that.form).find("input:hidden, input:text, input[type='checkbox'],input[type='radio'], textarea").each(function(){
                if(that.isUserPicker(this)) {
                    $j(this).bind("userUpdated",function(){that.isFormDirty = true});
                } else if(that.isDatePicker(this)) {
                    $j(this).bind("dateUpdate input change",function(){that.isFormDirty = true});
                } else {

                    $j(this).bind("input change tinyMCETextAreaChange",function(){that.isFormDirty = true});
                }
            });

            $j(that.form).find("select").each(function(){
                if($j(this).attr("multiple")) {
                    $j(this).bind("click change",function(){that.isFormDirty = true});
                } else {
                    $j(this).bind("change",function(){that.isFormDirty = true});
                }
            });
            $j(that.form).find(':reset,:submit').bind('click',function(event) { that.isFormDirty = false })
        },1500);

    },

    isUserPicker:function(target) {
        return $j(target).next().hasClass("j-people-list");
    },

    isDatePicker:function(target) {
        var bool = false;
        $j(".j-form-datepicker").each(function(){
            if(this == target) {
                bool = true;
                return;
            }
        });
        return bool;
    },

    resetTimeOut:function() {
        //this.delayTime = 6000;
        var that = this;
        if(this.intervalId !== null) {
            this.clearTimeout();
        }

        if(this.intervalId === null) {
            this.intervalId = setTimeout(function(){that.timeOutHandler()}, that.delayTime)
        }
    },

    clearTimeout:function() {
        clearTimeout(this.intervalId);
        this.intervalId = null;
    },

    timeOutHandler:function() {

        if(this.isFormDirty) {
            this.saveFormData();
        } else {
            console.log("No change in form data..")
            this.resetTimeOut();
        }
    },

    saveFormData:function(successFunc) {

        //Update Parent form CK Editor TextAreas manually for AJAX request
        /*for (var i in CKEDITOR.instances) {
         var name = CKEDITOR.instances[i].name;
         if($j("textarea[name="+name+"]").length>0)
         {
         $j("textarea[name="+name+"]").text(CKEDITOR.instances[i].getData());
         }
         }*/

        var that = this;
        var formData = this.getFormData(this.form);
        var formURL = $j(this.form).attr("action");
        console.log("Saving form details..." + that.delayTime);
        $j.ajax({
            url: formURL + "?projectID=" +this.projectID + '&autoSave=true' ,
            type: 'POST',
            data: formData,
            success: function(data, test) {
                that.isFormDirty = false;
                that.resetTimeOut();
                console.log("Data saved successfully..")
                if(successFunc != undefined && successFunc != null) {
                    successFunc();
                }
            },
            error: function() {
                that.resetTimeOut();
                console.log("Error on saving details..")
            }
        });

    },

    getFormData:function(form) {
        $j(form).find('select').each(function(){
            var isMultiple = $j(this).attr("multiple");
            if(isMultiple) {
                $j(this).find("option").attr("selected","true");
            }
        });
        $j(form).find('input').each(function(){
            var name = $j(this).attr("name");
            var type = $j(this).attr("type");
            if(name && name.indexOf("-display") != -1) {
                if(type == 'checkbox' || type == 'radio') {
                    if($j(this).is(":checked")) {
                        $j("input[name="+name.replace("-display",'')+"]").val(true);
                    } else {
                        $j("input[name="+name.replace("-display",'')+"]").val(false);
                    }
                } else {
                    var inputVal = $j("input[name="+name+"]").val();
                    if(inputVal) {
                        var val = Number($j("input[name="+name+"]").val().replace(/\,/g,''));
                        $j("input[name="+name.replace("-display",'')+"]").val(val);
                    } else {
                        $j("input[name="+name.replace("-display",'')+"]").val("");
                    }
//                    var val = Number($j("input[name="+name+"]").val().replace(/\,/g,''));
//                    if(val || val == 0) {
//                        $j("input[name="+name.replace("-display",'')+"]").val(val);
//                    } else {
//                        $j("input[name="+name.replace("-display",'')+"]").val("");
//                    }
                }
            }
        });
        var pFormData = $j(form).serializeArray();
        $j(form).find('select').each(function(){
            var isMultiple = $j(this).attr("multiple");
            if(isMultiple) {
                $j(this).find("option").removeAttr("selected");
            }
        });

        return pFormData;
    },

    setDelayTime:function(val) {
        if(isNaN(val)) {
            this.delayTime = val;
        } else {
            this.delayTime = 300000;
        }
    },

    setAutoSaveEnable:function(val) {
        this.autoSaveEnabled = (val.toString() == 'true');
    },

    setFormDirty:function(val) {
        this.isFormDirty = val;
    }
}