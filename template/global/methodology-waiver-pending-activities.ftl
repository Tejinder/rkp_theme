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
			<i> Click on a project from the list below to view details. </i>
			<div class="report-menus" xmlns="http://www.w3.org/1999/html">
                <ul class="project_name_menu">
					<#--<li><a href="<@s.url value='/new-synchro/pending-activities.jspa'/>" >Projects</a></li>-->
                    <li><a href="<@s.url value='/new-synchro/process-waiver-pending-activities.jspa'/>" >Business Waivers</a></li>
                    <li><a href="<@s.url value='/new-synchro/methodology-waiver-pending-activities.jspa'/>" class="active">Methodology Waivers</a></li>
					<li><a href="<@s.url value='/new-synchro/agency-waiver-pending-activities.jspa'/>" >Agency Waivers</a></li>
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
		<img src="${themePath}/images/bigrotation.gif" id="img-load" />
	</div>
	<form method="POST" name="waiverApprovalForm" id="waiverApprovalForm" action="/new-synchro/methodology-waiver-pending-activities-pagination!approveMethodologyWaiver.jspa"  >
		<input type="hidden" name="projectID" id="projectID" value="">
	</form>
	
<form method="POST" name="multiWaiverApprovalForm" id="multiWaiverApprovalForm" action="/new-synchro/methodology-waiver-pending-activities-pagination!approveMultipleMethWaiver.jspa"  >
		<input type="hidden" name="multipleProjectIds" id="multipleProjectIds" value="">
	</form>

	<form method="POST" name="multiWaiverRejectForm" id="multiWaiverRejectForm" action="/new-synchro/methodology-waiver-pending-activities-pagination!rejectMultipleMethWaiver.jspa"  >
		<input type="hidden" name="multipleRejectProjectIds" id="multipleRejectProjectIds" value="">
	</form>
	
	<form method="POST" name="updateWaiverForm" id="updateWaiverForm" action="/new-synchro/methodology-waiver-pending-activities-pagination!updateWaiver.jspa"  >
		<input type="hidden" name="updateWaiverProjectID" id="updateWaiverProjectID" value="">
		<input type="hidden" id="methodologyWaiverAction" name="methodologyWaiverAction" value="">
		<input type="hidden" id="methodologyApproverComment" name="methodologyApproverComment" value="">
	</form>
	
<script type="text/javascript">
    
var xhr;
$j(document).ready(function() {
	currPage = 1;
	processPaginationRequest(currPage, "", 10);
	$j("#project-methodology-filter").hide();	
	$j("#project-projectactivity-filter").hide();
	$j("#project-projectsupplier-filter").hide();
	$j(".result-form-popup .project_start_date .year select").css('width','340px');

});
	
// Search based on project name, owner, and project status
var timer;
//$j("#search_box").keyup(function(){
$j("#search_box").on("keyup",function(){
      localStorage.setItem("clickSearch_box",0);
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
	var url = '/new-synchro/methodology-waiver-pending-activities-pagination.jspa';
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
	xhr = $j.ajax({
		url : url,
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
			//$j('body').css({height: $j(document).height()});
            //adjustTableBodySize();
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
function approveWaiver(projectId)
{
	// change 533
	dialog({
            title: '',
            html: '<i class="warningErr positionSet"></i><p>Do you really want to approve this waiver?</p>',
            buttons:{
                "Yes":function() {
				      localStorage.setItem("clickSearch_box",1);  
					showLoader('Please wait...');
					var waiverApprovalForm = jQuery("#waiverApprovalForm");
					$j("#projectID").val(projectId);
					waiverApprovalForm.submit();  
					
                },
                "No": function() {
                    closeDialog();
					 return false;
                }
            }
       });
	
	relPos();
	
}

function approverMultipleWaivers()
{
	
	
	var selected = [];
	$j('#agencyWaiversDiv input:checked').each(function() {
		selected.push($j(this).attr('name'));
	
	});
	
	
	if(selected.length>0)
	{
	
	// change 533
	dialog({
            title: '',
            html: '<i class="warningErr positionSet"></i><p>Do you really want to approve the waiver(s)?</p>',
            buttons:{
                "Yes":function() {
				        localStorage.setItem("clickSearch_box",1);
					showLoader('Please wait...');
                     $j("#multipleProjectIds").val(selected);
						var multiWaiverApprovalForm = jQuery("#multiWaiverApprovalForm");
						multiWaiverApprovalForm.submit();     
					
                },
                "No": function() {
                    closeDialog();
					 return false;
                }
            }
       });
	relPos();
		
	}
	else
	{
		dialog({
					title:"",
					html:"<i class='positionSet'></i><p>Please select a Waiver to approve.</p>",

				});
				 orangeBtn();
				 relPos();
		return false;
	}
	
	
}

function rejectMultipleWaivers()
{
	
	
	var selected = [];
	$j('#agencyWaiversDiv input:checked').each(function() {
		selected.push($j(this).attr('name'));
	
	});
	
	
	if(selected.length>0)
	{
	
	// change 533
	dialog({
            title: '',
            html: '<i class="warningErr positionSet"></i><p>Do you really want to reject the waiver(s)?</p>',
            buttons:{
                "Yes":function() {
				     localStorage.setItem("clickSearch_box",1);
					showLoader('Please wait...');
                    $j("#multipleRejectProjectIds").val(selected);
					var multiWaiverRejectForm = jQuery("#multiWaiverRejectForm");
					multiWaiverRejectForm.submit();   
					
                },
                "No": function() {
                      closeDialog();
					  return false;
                }
            }
       });
		relPos();
	}
	else
	{
		dialog({
					title:"",
					html:"<i class='positionSet'></i><p>Please select a Waiver to reject.</p>",

				});
				 orangeBtn();
				 relPos();
		return false;
	}
	
	
}


	function requestMoreInfo(projectId)
	{
	
		var comment = $j("#methodologyApproverComment_"+projectId).val();
		
		
		if(comment=="")
		{
			$j("#methWaiverError_"+projectId).show();
			return false;
		}
		
		var methodologyApproverComment_ifr = $j("#methodologyApproverComment_"+projectId+"_ifr").contents().find("p").text();
		if(methodologyApproverComment_ifr.trim()=="")
		{
			$j("#methWaiverError_"+projectId).show();
			return false;
		}
		
		$j("#methodologyApproverComment").val(comment);
		$j("#updateWaiverProjectID").val(projectId);
		$j("#methodologyWaiverAction").val('RequestMoreInformation');
		var form = $j("#updateWaiverForm");
		form.submit();
		
	}
	
	function approveUpdateWaiver(projectId)
	{
		var comment = $j("#methodologyApproverComment_"+projectId).val();
		
		if(comment=="")
		{
			$j("#methWaiverError_"+projectId).show();
			return false;
		}
		
		var methodologyApproverComment_ifr = $j("#methodologyApproverComment_"+projectId+"_ifr").contents().find("p").text();
		if(methodologyApproverComment_ifr.trim()=="")
		{
			$j("#methWaiverError_"+projectId).show();
			return false;
		}
		
		$j("#methodologyApproverComment").val(comment);
		$j("#updateWaiverProjectID").val(projectId);
		$j("#methodologyWaiverAction").val('Approve');
		var form = $j("#updateWaiverForm");
		form.submit();
		
	}
	
	function rejectUpdateWaiver(projectId)
	{
		var comment = $j("#methodologyApproverComment_"+projectId).val();
		
		if(comment=="")
		{
			$j("#methWaiverError_"+projectId).show();
			return false;
		}
		
		var methodologyApproverComment_ifr = $j("#methodologyApproverComment_"+projectId+"_ifr").contents().find("p").text();
		if(methodologyApproverComment_ifr.trim()=="")
		{
			$j("#methWaiverError_"+projectId).show();
			return false;
		}
		
		$j("#methodologyApproverComment").val(comment);
		$j("#updateWaiverProjectID").val(projectId);
		$j("#methodologyWaiverAction").val('Reject');
		var form = $j("#updateWaiverForm");
		form.submit();
		
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
	
	$j("#result-filter-form").prop("action", "/new-synchro/methodology-waiver-pending-activities-pagination!downloadReport.jspa");
	var filterForm = $j("#result-filter-form");
	
	filterForm.submit();
	
    		
}

</script>

<script type="text/javascript">
<!-- Audit Logs -->
	<#assign i18CustomText>Pending Methodology Waivers</#assign>
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DASHBOARDWAIVER.getId()}, "${i18CustomText}", "", -1, ${user.ID?c});
</script>