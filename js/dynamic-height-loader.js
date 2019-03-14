$j(document).ready(function(){
    DYNAMIC_HEIGHT_LOADER.initialize();
});
var DYNAMIC_HEIGHT_LOADER = {
    initialize:function() {
        var target = null;
        if($j(".maindiv").length) {
            target = $(".maindiv");
        } else if($j("#j-main").length) {
            target = $j("#j-main");
        }
        $j(target).css("min-height", this.getMainContainerHeight());

    },
    getMainContainerHeight:function() {
        var footerHeight = 0;
        var headerHeight = 0;
        var mainPadding = 0;

        if($j("#j-footer").length) {
            footerHeight += document.getElementById('j-footer').clientHeight;
        } else if($j(".footer_main").length) {
            footerHeight += $j(".footer_main").height();
            if($j(".footer_main").css("padding-top")) {
                footerHeight += Number($j(".footer_main").css("padding-top").replace("px",""))
            }
            if($j(".footer_main").css("padding-bottom")) {
                footerHeight += Number($j(".footer_main").css("padding-bottom").replace("px",""))
            }
        }

        if($j(".maindiv").length) {
            if($j(".maindiv").css("padding-bottom")) {
                mainPadding += Number($j(".maindiv").css("padding-bottom").replace("px",""))
            }
            if($j(".maindiv").css("padding-top")) {
                mainPadding += Number($j(".maindiv").css("padding-top").replace("px",""))
            }
        } else if($j("#j-main").length) {

            if($j("#j-main").css("padding-bottom")) {
                mainPadding += Number($j("#j-main").css("padding-bottom").replace("px",""))
            }

            if($j("#j-main").css("padding-top")) {
                mainPadding += Number($j("#j-main").css("padding-top").replace("px",""));
            }

            if($j("#j-main.portal-options").css("padding-top")) {
                mainPadding -= (Number($j("#j-main").css("padding-top").replace("px","")) * 3);
            }

            headerHeight = document.getElementById("j-header-wrap").clientHeight + 5;
        }

        var windowHeight = $j(window).height();
        var totalHeight = windowHeight - (mainPadding + headerHeight + footerHeight);
        return totalHeight;
    },
    setVerticalCenter:function(target) {
        if(target) {
            $j(target).hide();
            var targetHeight = $j(target).height();
            var totalHeight = this.getMainContainerHeight();
            if(totalHeight > targetHeight) {
                var padding = totalHeight - targetHeight;
                $j(target).css('margin-top', padding/3);
            }
            $j(target).show();
        }
    }
};



