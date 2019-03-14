<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<#--<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>-->
<script src="${themePath}/js/jquery.paginate.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/table-height-handler.js" type="text/javascript"></script>



<div class="container">
    <div class="waiver-catalogue project_view">
        <div class="project_dashboard_header">
            <#--<h2>PENDING ACTIVITIES</h2>
            <div class="site_search_changestatus">
                <h2 class="pending-activity">PLEASE CLICK ON THE LINKS UNDER PENDING ACTIVITY LINK TO VIEW PENDING ACTIVITIES</h2>
            </div>-->
			
			<i> Click on a waiver from the list below to view details. </i>
            <div class="report-menus" xmlns="http://www.w3.org/1999/html">
                <ul class="project_name_menu">
                    
					<#--<li><a href="<@s.url value='/new-synchro/pending-activities.jspa'/>" >Projects</a></li>-->
                    <li><a href="<@s.url value='/new-synchro/process-waiver-pending-activities.jspa'/>" class="active">Business Waivers</a></li>
					<li><a href="<@s.url value='/new-synchro/methodology-waiver-pending-activities.jspa'/>" >Methodology Waivers</a></li>
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

	<form method="POST" name="waiverApprovalForm" id="waiverApprovalForm" action="/new-synchro/process-waiver-pending-activities-pagination!approveProcessWaiver.jspa"  >
		<input type="hidden" name="projectWaiverID" id="projectWaiverID" value="">
	</form>
	
<form method="POST" name="multiWaiverApprovalForm" id="multiWaiverApprovalForm" action="/new-synchro/process-waiver-pending-activities-pagination!approveMultipleProcessWaiver.jspa"  >
		<input type="hidden" name="multipleWaiverIds" id="multipleWaiverIds" value="">
	</form>
	
	<form method="POST" name="multiWaiverRejectForm" id="multiWaiverRejectForm" action="/new-synchro/process-waiver-pending-activities-pagination!rejectMultipleProcessWaiver.jspa"  >
		<input type="hidden" name="multipleRejectWaiverIds" id="multipleRejectWaiverIds" value="">
	</form>
	
	<form method="POST" name="updateWaiverForm" id="updateWaiverForm" action="/new-synchro/process-waiver-pending-activities-pagination!updateWaiver.jspa"  >
		<input type="hidden" name="updateWaiverID" id="updateWaiverID" value="">
		<input type="hidden" id="processWaiverAction" name="processWaiverAction" value="">
		<input type="hidden" id="approverComment" name="approverComment" value="">
	</form>
	
<script type="text/javascript">
    $j(document).ready(function () {
        currPage = 1;
        processPaginationRequest(currPage,"", 10);
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
       
	        localStorage.setItem("clickSearch_box",0);
  
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
        var url = '/new-synchro/process-waiver-pending-activities-pagination.jspa';
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
	
	$j("#result-filter-form").prop("action", "/new-synchro/process-waiver-pending-activities-pagination!downloadReport.jspa");
	var filterForm = $j("#result-filter-form");
	
	filterForm.submit();
	
    		
}

function approveWaiver(projectWaiverID)
{
	
	// change 533
	dialog({
            title: '',
            html: '<i class="warningErr positionSet"></i><p>Do you really want to approve this waiver?</p>',
            buttons:{
                "Yes":function() {
					showLoader('Please wait...');
					localStorage.setItem("clickSearch_box",1);  
                    var waiverApprovalForm = jQuery("#waiverApprovalForm");
					$j("#projectWaiverID").val(projectWaiverID);
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
                     $j("#multipleWaiverIds").val(selected);
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
					html:"<i class='positionSet'></i><p>Please select a Waiver(s) to approve.</p>",

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
                    $j("#multipleRejectWaiverIds").val(selected);
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

function approveUpdateWaiver(waiverId)
{
	var comment = $j("#approverComments_"+waiverId).val();
	
	if(comment=="")
	{
		$j("#processWaiverError_"+waiverId).show();
		return false;
	}
	
	var approverComment_ifr = $j("#approverComments_"+waiverId+"_ifr").contents().find("p").text();
	if(approverComment_ifr.trim()=="")
	{
		$j("#processWaiverError_"+waiverId).show();
		return false;
	}
	
	$j("#approverComment").val(comment);
	$j("#updateWaiverID").val(waiverId);
	$j("#processWaiverAction").val('Approve');
	var form = $j("#updateWaiverForm");
	form.submit();
	
}

function rejectUpdateWaiver(waiverId)
	{
		var comment = $j("#approverComments_"+waiverId).val();
	
	if(comment=="")
	{
		$j("#processWaiverError_"+waiverId).show();
		return false;
	}
	
	var approverComment_ifr = $j("#approverComments_"+waiverId+"_ifr").contents().find("p").text();
	if(approverComment_ifr.trim()=="")
	{
		$j("#processWaiverError_"+waiverId).show();
		return false;
	}
	
	$j("#approverComment").val(comment);
	$j("#updateWaiverID").val(waiverId);
	$j("#processWaiverAction").val('Reject');
	var form = $j("#updateWaiverForm");
	form.submit();
		
	}

</script>

<script type="text/javascript">
<!-- Audit Logs -->
	<#assign i18CustomText>Pending Process Waivers</#assign>
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DASHBOARDPENDINGACTV.getId()}, "${i18CustomText}", "", -1, ${user.ID?c});
	
	
</script>