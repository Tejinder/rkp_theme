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
                    <li><a href="<@s.url value='/new-synchro/dashboard.jspa'/>" class="active">All Projects</a></li>
                    <li><a href="<@s.url value='/new-synchro/draft-dashboard.jspa'/>">Draft Projects</a></li>
					<li><a href="<@s.url value='/new-synchro/em-dashboard.jspa'/>">End-Market Projects</a></li>
					<li><a href="<@s.url value='/new-synchro/global-dashboard.jspa'/>" >Global Projects</a></li>
					<li><a href="<@s.url value='/new-synchro/regional-dashboard.jspa'/>">Regional Projects</a></li>
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
    

    
        <div id="table-main">
        </div>
    
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
        processPaginationRequest(currPage,"", 10);
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
				var plimit = $j("#project-limit").val();
                processPaginationRequest(1, $j.trim(value), plimit);
            }
            else
            {
				var plimit = $j("#project-limit").val();
                processPaginationRequest(1, "", plimit);
            }
        }, 300);
        //Sort Fields
//        $j("#sortField").val("");
//        $j("#ascendingOrder").val("");
    });

    //Pagination
    var xhr;
    function processPaginationRequest(page,keyword, plimit)
    {	
		
        currPage = page;
        var url = '/new-synchro/dashboard-pagination.jspa'
        if(xhr != null)
            xhr.abort();
        selectAllFilterBoxes();
        var filterForm = $j("#result-filter-form");
//        var isSingleMarketSelected = $j("#singleMarketCB").attr('checked');
//        var isMultiMarketSelected = $j("#multiMarketCB").attr('checked');
//        console.log(isSingleMarketSelected + " :: " + isMultiMarketSelected);	

		if(plimit!=null && plimit!=undefined)
		{
			//limit = plimit;
		}
		else
		{
			plimit = $j("#project-limit").val();
		}	
        xhr = $j.ajax({
            url: url,
            type: 'POST',
            data: filterForm.serialize() + '&keyword='+ keyword+"&page="+page+"&plimit="+plimit,
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
	
function loadLimit()
{	
	var value = $j("#search_box").val();
	if($j.trim(value) != "")
	{
		var plimit = $j("#project-limit").val();
		
		processPaginationRequest(1, $j.trim(value), plimit);
	}
	else
	{
		var plimit = $j("#project-limit").val();
		
		processPaginationRequest(1, "", plimit);
	}	
}
</script>
<script type="text/javascript">
<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.dashboard.view.text" /></#assign>
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DASHBOARD.getId()}, "${i18CustomText}", "", -1, ${user.ID?c});
</script>