var PROJECT_STICKY_HEADER = {
     initialize:function() {
         $j("body").bind("projectStageNavigatorCreationComplete", function(){

             $j("#j-header-wrap").css("position","fixed");
             $j("#j-header-wrap").css("z-index","1000");
             $j("#j-header-wrap").css("left",$j(".project_names").parent().offset().left);

             $j("#stage-navigator").css("position","fixed");
             $j("#stage-navigator").css("z-index","1001");
             $j("#stage-navigator").css("left",$j(".project_names").parent().offset().left);
             $j("#stage-navigator").css("top",$j("#j-header-wrap").height() + "px");

             $j("#j-main").css("padding-top",$j("#j-header-wrap").height() + $j("#stage-navigator").height());
         });
     }
}
