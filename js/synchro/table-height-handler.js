var TABLE_HEIGHT_HANDLER = {
    initialize:function() {
        var mainContainerHeight = DYNAMIC_HEIGHT_LOADER.getMainContainerHeight();
        var bannerHeight = $j("#j-header-wrap").outerHeight();
        var dashboardHeaderHeight = $j(".project_dashboard_header").outerHeight();
        var tableHeaderHeight = $j(".scrollable-table.project_status_table thead").outerHeight();
        var paginationHeight = $j(".jPaginate").outerHeight();
        var footerHeight = $j(".footer_main").outerHeight();
        var availableHeight = mainContainerHeight - (bannerHeight + dashboardHeaderHeight + tableHeaderHeight + paginationHeight + footerHeight + 10);
        var tableBodyMinHeight = 0;
        if($j(".scrollable-table.project_status_table tbody").css("min-height")) {
            tableBodyMinHeight = Number($j(".scrollable-table.project_status_table tbody").css("min-height").replace("px",""));
        }
        if(availableHeight > 50) {
            $j(".scrollable-table.project_status_table tbody").css('max-height', availableHeight+"px");
            $j(".table-vscroll").css('height', availableHeight+"px");
            $j('.scrollable-table.project_status_table tbody').bind('mousewheel DOMMouseScroll', function(e){
                var scrollTop = $j(".scrollable-table.project_status_table tbody").scrollTop();
                if(e.wheelDelta) {
                    if(e.wheelDelta > 0) {
                        scrollTop = scrollTop - 25;
                    } else {
                        scrollTop = scrollTop + 25;
                    }
                } else if(e.detail) {
                    if(e.detail > 0) {
                        scrollTop = scrollTop + 25;
                    } else {
                        scrollTop = scrollTop - 25;
                    }
                }
                $j(".scrollable-table.project_status_table tbody").scrollTop(scrollTop);
                $j(".table-vscroll").scrollTop(scrollTop);
            });
        }
        if($j(".table-vscroll .scollinner").height() > $j(".table-vscroll").height()) {
            $j(".table-vscroll").css("overflow-y","scroll");
        } else {
            $j(".table-vscroll").css("overflow-y","auto");
        }
    }


}