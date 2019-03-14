<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.paginate.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/table-height-handler.js" type="text/javascript"></script>

<div class="container">
    <div class="waiver-catalogue project_view">
        <div class="project_dashboard_header">
         		
			<#--<h2><@s.text name="waiver.catalogue.header"/></h2>-->
			<i> Click on a waiver from the list below to view details. </i>
			<div class="report-menus" xmlns="http://www.w3.org/1999/html">
                <ul class="project_name_menu">
                    <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
					<#if synchroPermHelper.isGlobalUserType() || synchroPermHelper.isRegionalUserType()>
						
					<#else>	
						<li><a href="<@s.url value='/new-synchro/process-waiver-dashboard.jspa'/>" >Business Waivers</a></li>
					</#if>	
                    <li><a href="<@s.url value='/new-synchro/methodology-waiver-dashboard.jspa'/>" class="active">Methodology Waivers</a></li>
					<li><a href="<@s.url value='/new-synchro/agency-waiver-dashboard.jspa'/>">Agency Waivers</a></li>
                </ul>
            </div>
			
			<#--<div class="dashboard-download"><div class="standard-report-download-link">
				<a href="javascript:void(0);" onclick="openDownloadReportWindow()"></a>
			</div><a href="javascript:void(0);" onclick="openDownloadReportWindow()">Download in Excel</a>
			</div>-->
			
			<div class="dashboard-download">
				<div class="standard-report-download-link">
					<a href="javascript:void(0);" onclick="downloadReport()"></a>
				</div>
				<a href="javascript:void(0);" onclick="downloadReport()">Download in Excel</a>
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
		<img src="${themePath}/images/bigrotation.gif" id="img-load" />
	</div>

<div id="project-download-options" style="display:none">
	<i>Select the view you would like to have:</i>
	<br>
	<label><input type='radio' name='downloadReportTypeOption' id="projectSummaryType" value='ProjectSummary'>Projects Summary</label>
	<br>
	<label><input type='radio' name='downloadReportTypeOption' id="projectStatusType" value='ProjectStatus'>Project Status</label>
	
</div>

<script type="text/javascript">
    
var xhr;
$j(document).ready(function() {
	currPage = 1;
	//processPaginationRequest(currPage, "");	
	processPaginationRequest(currPage, "",10);	
	$j("#project-methodology-filter").hide();	
	$j("#project-projectactivity-filter").hide();
	$j("#project-projectsupplier-filter").hide();
	$j(".result-form-popup .project_start_date .year select").css('width','340px');

});
	
// Search based on project name, owner, and project status
var timer;
//$j("#search_box").keyup(function(){
$j("#search_box").on("keyup",function(){
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
	$j("#sortField").val("");
	$j("#ascendingOrder").val("");
});

function processPaginationRequest(page, keyword, plimit) {
	currPage = page;
	if(xhr != null) {
		xhr.abort();
	}
	var url = '/new-synchro/methodology-waiver-dashboard-pagination.jspa';
	selectAllFilterBoxes();
	var filterForm = $j("#result-filter-form");
    
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
		url : url,
		type: 'POST',
		data: filterForm.serialize() + '&keyword='+ keyword+"&page="+page+"&plimit="+plimit,
		beforeSend: function() {
			$j("#overlay").show();
		},
		complete: function() {
			//$j("#overlay").hide();
		},
		success: function(result) {
			xhr = null;
			$j("#overlay").hide();
			$j('#table-main').html(result);
			
                HeightSet();			
			//$j('body').css({height: $j(document).height()});
           // adjustTableBodySize();
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
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DASHBOARDWAIVER.getId()}, "${i18CustomAdvSearchText}", "", -1, ${user.ID?c});
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

function downloadReport(downloadReportType)
{	
	var value = $j("#search_box").val();
	if($j.trim(value) != "")
	{
		var plimit = $j("#project-limit").val();
		processDownloadRequest(currPage, $j.trim(value), plimit, downloadReportType);
	}
	else
	{
		var plimit = $j("#project-limit").val();
		processDownloadRequest(currPage, "", plimit, downloadReportType);
	}	
}
function openDownloadReportWindow()
{
	$j('input[name="downloadReportTypeOption"]').prop('checked', false);
	
   $j("#project-download-options").dialog({
			modal: true,
			width: 450
		});
}

$j("#projectSummaryType").click(function() {
		
		downloadReport('ProjectSummary');
		
});  

$j("#projectStatusType").click(function() {
		
		downloadReport('ProjectStatus');
		
}); 

function processDownloadRequest(page, keyword, plimit, downloadReportType) {
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
	
	$j("#downloadReportType").val(downloadReportType);
	$j("#result-filter-form").prop("action", "/new-synchro/methodology-waiver-dashboard-pagination!downloadReport.jspa");
	var filterForm = $j("#result-filter-form");
	
	filterForm.submit();
	
    		
}
</script>

<script type="text/javascript">
<!-- Audit Logs -->
	<#assign i18CustomText>Methodology Waivers</#assign>
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DASHBOARDWAIVER.getId()}, "${i18CustomText}", "", -1, ${user.ID?c});
</script>