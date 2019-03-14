<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<#--<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>-->
<script src="${themePath}/js/jquery.paginate.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/table-height-handler.js" type="text/javascript"></script>


<div class="container">
    <div class="project_view">
        <div class="project_dashboard_header">
            <#--<h2>PENDING ACTIVITIES</h2>
            <div class="site_search_changestatus">
                <h2 class="pending-activity">PLEASE CLICK ON THE LINKS UNDER PENDING ACTIVITY LINK TO VIEW PENDING ACTIVITIES</h2>
            </div>-->
			<i> Click on a project from the list below to view details. </i>
            <div class="report-menus" xmlns="http://www.w3.org/1999/html">
                <ul class="project_name_menu">
                    <li><a href="<@s.url value='/new-synchro/pending-activities.jspa'/>" class="active">Pending Approvals</a></li>
                    <#if statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner()>
						
						<li><a href="<@s.url value='/new-synchro/process-waiver-pending-activities.jspa'/>">Business Waivers</a></li>
						<li><a href="<@s.url value='/new-synchro/methodology-waiver-pending-activities.jspa'/>" >Methodology Waivers</a></li>
						<li><a href="<@s.url value='/new-synchro/agency-waiver-pending-activities.jspa'/>" >Agency Waivers</a></li>
					</#if>
                </ul>
            </div>
			<div class="dashboard-download"><div class="standard-report-download-link">
				<a href="javascript:void(0);" onclick="downloadReport()"></a>
			 </div><a href="javascript:void(0);" onclick="downloadReport()">Download in Excel</a>
			</div>
            <div class="site_search">
                <form id="search-box">
                   
					<input type="text" name="q" size="31" id="search_box" class="search_box" placeholder="Search" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Search' "/>
                    <input type="button"  name="" value="" class="search_icon" />
                </form>
            <#include "/template/global/synchro-catalogue-search-tag-new.ftl"/>
            </div>
        </div>
        <div id="table-main">
        </div>
    </div>



</div>
<div id="overlay">
    <img src="${themePath}/images/bigrotation.gif"
         id="img-load" />
</div>

<script type="text/javascript">
    $j(document).ready(function () {
        currPage = 1;
        processPaginationRequest(currPage,"",10);
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
   $j("#search_box").on("keyup",function(){
        currPage = 1;
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
    function processPaginationRequest(page,keyword, plimit)
    {
        currPage = page;
        var url = '/new-synchro/pending-activities-pagination.jspa';
        if(xhr != null)
            xhr.abort();
        selectAllFilterBoxes();
        var filterForm = $j("#result-filter-form");
	var limit = plimit;
		if(plimit!=null && plimit!=undefined)
		{
			//limit = plimit;
		}
		else
		{
			plimit = $j("#project-limit").val();
		}
		
		if(plimit==undefined)
		{
			plimit=10;
		}
        xhr = $j.ajax({
            url: url,
            type: 'POST',
            data: filterForm.serialize() + '&keyword='+ keyword+"&page="+page+"&plimit="+plimit,
            beforeSend: function() {
                $j("#overlay").show();
            },
            complete: function() {
                $j("#overlay").hide();
            },
            success: function(result) {
                xhr = null;
                $j('#table-main').html(result);
				HeightSet();
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
</script>

<script type="text/javascript">
$j(document).ready(function() {
   function captureAuditLog()
   {
	alert("log");
   }
});

function auditLogs()
	{	
		<#assign i18CustomAdvSearchText><@s.text name="logger.project.pending.search.text" /></#assign>
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DASHBOARDPENDINGACTV.getId()}, "${i18CustomAdvSearchText}", "", -1, ${user.ID?c});
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

function downloadReport()
{	
	var value = $j("#search_box").val();
	if($j.trim(value) != "")
	{
		var plimit = $j("#project-limit").val();
		processDownloadRequest(currPage, $j.trim(value), plimit);
	}
	else
	{
		var plimit = $j("#project-limit").val();
		processDownloadRequest(currPage, "", plimit);
	}	
}


function processDownloadRequest(page, keyword, plimit) {
	currPage = page;
	if(xhr != null) {
		xhr.abort();
	}

		
	if(plimit!=null && plimit!=undefined)
	{
		//limit = plimit;
	}
	else
	{
		plimit = $j("#project-limit").val();
	}
	
	if(plimit==undefined)
	{
		plimit=10;
	}
	
	$j("#downloadReportKeyword").val(keyword);
	$j("#downloadReportPage").val(page);
	$j("#plimit").val(plimit);
	
	$j("#result-filter-form").prop("action", "/new-synchro/pending-activities-pagination!downloadReport.jspa");
	var filterForm = $j("#result-filter-form");
	
	filterForm.submit();
	
    		
}

<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.pending.view.text" /></#assign>	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DASHBOARDPENDINGACTV.getId()}, "${i18CustomText}", "", -1, ${user.ID?c});
</script>