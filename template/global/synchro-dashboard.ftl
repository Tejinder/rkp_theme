<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>
<#--<script src="${themePath}/js/jquery.tablesorter.js" type="text/javascript"></script>-->
<script src="${themePath}/js/jquery.paginate.js" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/table-height-handler.js" type="text/javascript"></script>
<link rel="stylesheet" href="${themePath}/style/drop-down.css" type="text/css" />
<style>

    .jqbar.horizontal span {
        margin-left: 0px;
    }
    .jqbar.horizontal span.bar-level{
    <#--behavior: url("${themePath}/pie/PIE.htc");-->
    }
    .jqbar.horizontal .bar-level-wrapper{
        position:relative;
        z-index:0;
    }
    .site_search input.search_box{
    <#--behavior: url("${themePath}/pie/PIE.htc");-->
    }
</style>
<div class="container-sub">

<#--<div class="dashboard-breadcrumbs-menu">-->
<#--<div class="dropdown my-dashboard-dropdown">-->
<#--<a class="account my-dashboard">My Dashboard</a>-->
<#--<div id="my-dashboard-submenu" class="submenu">-->
<#--<ul class="root">-->
<#--<li><a href="<@s.url value='/synchro/waiver-catalogue.jspa'/>">View My Viewer</a></li>-->
<#--<li><a href="<@s.url value='/synchro/pending-acitivities.jspa'/>">My Pending Activities</a></li>-->
<#--<li><a href="<@s.url value='/synchro/history.jspa'/>">My History</a></li>-->
<#--&lt;#&ndash;<li><a href="#">View Project Chatter</a></li>&ndash;&gt;-->
<#--</ul>-->
<#--</div>-->
<#--&lt;#&ndash;<a class="account">My Stuff</a>&ndash;&gt;-->
<#--&lt;#&ndash;<div class="submenu">&ndash;&gt;-->
<#--&lt;#&ndash;<ul class="root">&ndash;&gt;-->
<#--&lt;#&ndash;<#if createProject?? && createProject>&ndash;&gt;-->
<#--&lt;#&ndash;<li><a href="<@s.url value='wizard-options!input.jspa'/>">Initiate a Project</a></li>&ndash;&gt;-->
<#--&lt;#&ndash;<#else>&ndash;&gt;-->
<#--&lt;#&ndash;<li><a class="disabled" href="javascript:void(0);'/>">Initiate a Project</a></li>&ndash;&gt;-->
<#--&lt;#&ndash;</#if>&ndash;&gt;-->
<#--&lt;#&ndash;<#if createWaiver?? && createWaiver>&ndash;&gt;-->
<#--&lt;#&ndash;<li ><a href="<@s.url value='initiate-waiver!input.jspa'/>" >Initiate a Waiver</a></li>&ndash;&gt;-->
<#--&lt;#&ndash;<#else>&ndash;&gt;-->
<#--&lt;#&ndash;<li ><a class="disabled" href="javascript:void(0);" >Initiate a Waiver</a></li>&ndash;&gt;-->
<#--&lt;#&ndash;</#if>			 		&ndash;&gt;-->
<#--&lt;#&ndash;<li><a href="<@s.url value='reports.jspa'/>">Generate Reports</a></li>			&ndash;&gt;-->
<#--&lt;#&ndash;</ul>&ndash;&gt;-->
<#--&lt;#&ndash;</div>	&ndash;&gt;-->
<#--</div>-->
<#--<div class="dropdown initiate-new-dropdown">-->
<#--<a class="account initiate-new">Initiate Project</a>-->
<#--<div id="initiate-new-submenu" class="submenu">-->
<#--<ul class="root">-->
<#--<#if createProject?? && createProject>-->
<#--<li><a href="<@s.url value='/synchro/create-project!input.jspa'/>">Single Market Project</a></li>-->
<#--<#else>-->
<#--<li><a class="disabled" href="javascript:void(0);">Single Market Project</a></li>-->
<#--</#if>-->
<#--<#if createProject?? && createProject>-->
<#--&lt;#&ndash;<li><a href="<@s.url value='/synchro/create-project!input.jspa'/>">Multi Market Project</a></li>&ndash;&gt;-->
<#--<li><a class="disabled" href="javascript:void(0);">Multi Market Project</a></li>-->
<#--<#else>-->
<#--<li><a class="disabled" href="javascript:void(0);">Multi Market Project</a></li>-->
<#--</#if>-->
<#--&lt;#&ndash;<#if createWaiver?? && createWaiver>&ndash;&gt;-->
<#--&lt;#&ndash;<li><a href="<@s.url value='initiate-waiver!input.jspa'/>">Waiver</a></li>&ndash;&gt;-->
<#--&lt;#&ndash;<#else>&ndash;&gt;-->
<#--&lt;#&ndash;<li><a class="disabled" href="javascript:void(0);">Single Market Project</a></li>&ndash;&gt;-->
<#--&lt;#&ndash;</#if>&ndash;&gt;-->
<#--&lt;#&ndash;<#if createProject?? && createProject>&ndash;&gt;-->
<#--&lt;#&ndash;&lt;#&ndash;<li><a href="<@s.url value='/synchro/create-project!input.jspa'/>">Multi Market Project</a></li>&ndash;&gt;&ndash;&gt;-->
<#--&lt;#&ndash;<li><a class="disabled" href="javascript:void(0);">Multi Market Project</a></li>&ndash;&gt;-->
<#--&lt;#&ndash;<#else>&ndash;&gt;-->
<#--&lt;#&ndash;<li><a class="disabled" href="javascript:void(0);">Multi Market Project</a></li>&ndash;&gt;-->
<#--&lt;#&ndash;</#if>&ndash;&gt;-->
<#--&lt;#&ndash;&lt;#&ndash;<#if createWaiver?? && createWaiver>&ndash;&gt;&ndash;&gt;-->
<#--&lt;#&ndash;&lt;#&ndash;<li><a href="<@s.url value='initiate-waiver!input.jspa'/>">Waiver</a></li>&ndash;&gt;&ndash;&gt;-->
<#--&lt;#&ndash;&lt;#&ndash;<#else>&ndash;&gt;&ndash;&gt;-->
<#--&lt;#&ndash;&lt;#&ndash;<li><a class="disabled" href="javascript:void(0);">Waiver</a></li>&ndash;&gt;&ndash;&gt;-->
<#--&lt;#&ndash;&lt;#&ndash;</#if>&ndash;&gt;&ndash;&gt;-->
<#--&lt;#&ndash;</ul>&ndash;&gt;-->
<#--&lt;#&ndash;</div>&ndash;&gt;-->
<#--&lt;#&ndash;</div>&ndash;&gt;-->
<#--&lt;#&ndash;<a href="<@s.url value='/synchro/reports.jspa'/>">Generate Reports</a>&ndash;&gt;-->
<#--&lt;#&ndash;<a href="<@s.url value='/synchro/my-library.jspa'/>">My Library</a>&ndash;&gt;-->
<#--&lt;#&ndash;&lt;#&ndash;<a href="<@s.url value='/people/'/>${user.username}">My Profile</a>&ndash;&gt;&ndash;&gt;-->
<#--&lt;#&ndash;&lt;#&ndash;<#if changeStatus?? && changeStatus>&ndash;&gt;&ndash;&gt;-->
<#--&lt;#&ndash;&lt;#&ndash;<a href="<@s.url value='status-dashboard.jspa'/>">Change Status</a>&ndash;&gt;&ndash;&gt;-->
<#--&lt;#&ndash;&lt;#&ndash;<#else>&ndash;&gt;&ndash;&gt;-->
<#--&lt;#&ndash;&lt;#&ndash;<a href="javascript:void(0);" class="disabled">Change Status</a>&ndash;&gt;&ndash;&gt;-->
<#--&lt;#&ndash;&lt;#&ndash;</#if>		&ndash;&gt;&ndash;&gt;-->
<#--&lt;#&ndash;</div>&ndash;&gt;-->

    <div class="project_view">
        <div class="project_dashboard_header">
           <#-- <div class="synchro-breadcrumb">
                <span>My Dashboard</span>
                <span class="separator">My Projects</span>
            </div>
          -->
            <h2>My Dashboard</h2><br>
            <div class="report-menus" xmlns="http://www.w3.org/1999/html">
                <ul class="project_name_menu">
                    <li><a href="<@s.url value='/synchro/dashboard.jspa'/>" class="active">All Projects</a></li>
                    <li><a href="<@s.url value='/synchro/draft-dashboard.jspa'/>">Draft Projects</a></li>
                </ul>
            </div>

            <div class="site_search">
            <#--<h2>My Catalogue</h2>-->
                <form id="search-box">
                    <input type="text" name="q" size="31" id="search_box" class="search_box" placeholder="Search"/>
                    <input type="button"  name="" value="" class="search_icon" />
                </form>
            <#include "/template/global/synchro-catalogue-search-tag.ftl"/>
            </div>
        </div>
    <#--<div>-->

    <#--<input id="singleMarketCB" type="checkbox" name="singleMarket" checked="true">-->
    <#--<label for="singleMarketCB">Single Market</label>-->
    <#--<input id="multiMarketCB" type="checkbox" name="multiMarket" checked="true">-->
    <#--<label for="multiMarketCB">Multi-Market</label>-->
    <#--</div>-->
        <div id="table-main">
        </div>
    <#--<div id="dashboard_menu" class="dashboard_menu mt_stuff">-->
    <#--<h2>My Stuff</h2>-->
    <#--<ul>-->
    <#--<li>-->
    <#--<#if accessWaiverCatalogue?? && accessWaiverCatalogue>-->
    <#--<a href="<@s.url value='waiver-catalogue.jspa'/>">-->
    <#--Project <br>Waiver-->
    <#--</a>-->
    <#--<#else>-->
    <#--<a href="javascript:void(0);" class="disabled">-->
    <#--Project <br>Waiver-->
    <#--</a>-->
    <#--</#if>-->

    <#--</li>-->
    <#--<li>-->
    <#--<a href="<@s.url value='pending-acitivities.jspa'/>">-->
    <#--Pending <br>Activity-->
    <#--</a>-->
    <#--</li>-->
    <#--<li>-->
    <#--<a href="<@s.url value='history.jspa'/>">-->
    <#--History-->
    <#--</a>-->
    <#--</li>-->
    <#--<li class="last">-->
    <#--<a href="<@s.url value='discussion-Forums.jspa'/>">-->
    <#--DISCUSSION <br>FORUM-->
    <#--</a>-->
    <#--</li>-->
    <#--</ul>-->
    <#--</div>-->
        <div id="overlay">
            <img src="${themePath}/images/bigrotation.gif"
                 id="img-load" />
        </div>
    </div>


</div>



<script type="text/javascript">

    $j(document).ready(function () {
        CustomDropDown.init($j('#my-dashboard-submenu'),$j('.my-dashboard'));
        CustomDropDown.init($j('#initiate-new-submenu'),$j('.initiate-new'));
        currPage = 1;
        processPaginationRequest(currPage,"");
        view = getURLParameter('view');
        if(view!=null && view=="filter")
        {
            toggle();
        }
        setTimeout( function(){$j(".warning-msg").fadeOut(1000);} , 4000);
        $j("#project-projectactivity-filter").hide();
        $j("#project-initiator-filter").hide();
        $j("#project-projectsupplier-filter").hide();
        if(!$j("#sortField").val()) {
            $j("#sortField").val("status");
        }

        if(!$j("#ascendingOrder").val()) {
            $j("#ascendingOrder").val("0");
        }


    });

    // Search based on project name, owner, and project status
    var timer;
    $j("#search_box").keyup(function(){
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
        }, 300);
        //Sort Fields
//        $j("#sortField").val("");
//        $j("#ascendingOrder").val("");
    });

    //Pagination
    var xhr;
    function processPaginationRequest(page,keyword)
    {
        currPage = page;
        var url = '/synchro/dashboard-pagination.jspa'
        if(xhr != null)
            xhr.abort();
        selectAllFilterBoxes();
        var filterForm = $j("#result-filter-form");
//        var isSingleMarketSelected = $j("#singleMarketCB").attr('checked');
//        var isMultiMarketSelected = $j("#multiMarketCB").attr('checked');
//        console.log(isSingleMarketSelected + " :: " + isMultiMarketSelected)
        xhr = $j.ajax({
            url: url,
            type: 'POST',
            data: filterForm.serialize() + '&keyword='+ keyword+"&page="+page,
            beforeSend: function() {
                // $j("#overlay").show();
            },
            complete: function() {
                // $j("#overlay").hide();
            },
            success: function(result) {
                xhr = null;
                $j('#table-main').html(result);
                generateGraphBars();
                updateTableRowHeight();
                adjustTableBodySize();
                TABLE_HEIGHT_HANDLER.initialize();
//                docH = $j(document).height();
//                $j('body').css({height: docH});

            }
        });
    }

    $j("#search-box").submit(function( event ) {
        //$j("#search_box").keyup();
        event.preventDefault();
    });
    function adjustTableBodySize() {
        $j(".table-vscroll .scollinner").height($j(".project_status_table tbody").height() + 15);
        $j(".table-vscroll").css("top",($j($j(".project_status_table thead")[0]).height()) + 1 + "px");
    }

	function auditLogs()
	{	
		<#assign i18CustomAdvSearchText><@s.text name="logger.project.pending.search.text" /></#assign>
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DASHBOARD.getId()}, "${i18CustomAdvSearchText}", "", -1, ${user.ID?c});
	}
</script>
<script type="text/javascript">
<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.dashboard.view.text" /></#assign>
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DASHBOARD.getId()}, "${i18CustomText}", "", -1, ${user.ID?c});
</script>