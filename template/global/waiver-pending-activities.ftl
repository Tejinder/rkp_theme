<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<#--<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>-->
<script src="${themePath}/js/jquery.paginate.js" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/table-height-handler.js" type="text/javascript"></script>

<div class="container">
    <div class="project_view">
        <div class="project_dashboard_header">
            <h2>PENDING ACTIVITIES</h2>
            <div class="site_search_changestatus">
                <h2 class="pending-activity">PLEASE CLICK ON THE LINKS UNDER PENDING ACTIVITY LINK TO VIEW PENDING ACTIVITIES</h2>
            </div>
            <div class="report-menus" xmlns="http://www.w3.org/1999/html">
                <ul class="project_name_menu">
                    <li><a href="<@s.url value='/synchro/pending-activities.jspa'/>">Projects</a></li>
                    <li><a href="<@s.url value='/synchro/waiver-pending-activities.jspa'/>" class="active">Process Waivers</a></li>
                </ul>
            </div>
            <div class="site_search">
                <form id="search-box">
                    <input type="text" name="q" size="31" id="search_box" class="search_box" placeholder="Search"/>
                    <input type="button"  name="" value="" class="search_icon" />
                </form>
            <#--<#include "/template/global/synchro-catalogue-search-tag.ftl"/>-->
            </div>
        </div>
        <div id="table-main">
        </div>
    </div>
</div>

<div id="overlay">
    <img src="${themePath}/images/bigrotation.gif" id="img-load" />
</div>

<script type="text/javascript">
    $j(document).ready(function () {
        currPage = 1;
        processPaginationRequest(currPage,"");
        /** Hide other elements of advanced result filter **/
        $j("#project-region-filter").hide();
        $j("#project-endmarket-filter").hide();
        $j("#project-methodology-filter").hide();
        $j("#project-projectstatus-filter").hide();
        $j("#project-projectsupplier-filter").hide();
        $j(".result-form-popup .project_start_date .year select").css('width','340px');

    });

    // Search based on project name, owner, and project status
    var timer;
   // $j("#search_box").keyup(function(){
   $j("#search_box").on("keyup mouseup",function(){
        currPage = 1;
        clearTimeout(timer);
        timer = setTimeout(function(){
            var value = $j("#search_box").val();
            if($j.trim(value) != "")
            {
                processPaginationRequest(1, $j.trim(value));
            }
            else
            {
                processPaginationRequest(1, "");
            }
        }, 300 );

        //Sort Fields
        $j("#sortField").val("");
        $j("#ascendingOrder").val("");


    });

    $j("#search-box").submit(function( event ) {
        //$j("#search_box").keyup();
        event.preventDefault();
    });

    //Pagination
    var xhr;
    function processPaginationRequest(page,keyword)
    {
        currPage = page;
        var url = '/synchro/waiver-pending-activities-pagination.jspa';
        if(xhr != null)
            xhr.abort();
        selectAllFilterBoxes();
        var filterForm = $j("#result-filter-form");
        xhr = $j.ajax({
            url: url,
            type: 'POST',
            data: filterForm.serialize() + '&keyword='+ keyword+"&page="+page,
            beforeSend: function() {
                $j("#overlay").show();
            },
            complete: function() {
                $j("#overlay").hide();
            },
            success: function(result) {
                xhr = null;
                $j('#table-main').html(result);
//                docH = $j(document).height();
//                $j('body').css({height: docH});
                adjustTableBodySize();
                TABLE_HEIGHT_HANDLER.initialize();
            }
        });
    }
    function adjustTableBodySize() {
        $j(".table-vscroll .scollinner").height($j(".project_status_table tbody").height() + 15);
        $j(".table-vscroll").css("top",($j($j(".project_status_table thead")[0]).height()) + 1 + "px");
    }
	
	function auditLogs()
	{	
		<#assign i18CustomAdvSearchText><@s.text name="logger.project.pending.search.text" /></#assign>
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DASHBOARDPENDINGACTV.getId()}, "${i18CustomAdvSearchText}", "", -1, ${user.ID?c});
	}
	
</script>

<script type="text/javascript">
<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.pending.waivers.text" /></#assign>	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DASHBOARDPENDINGACTV.getId()}, "${i18CustomText}", "", -1, ${user.ID?c});
</script>