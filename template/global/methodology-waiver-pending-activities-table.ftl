<#assign isSynchroSystemOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner() />
<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />

<input type="checkbox" name="selectall"  id="selectall" ><label for="selectall"></label><span class="select-all-label">Select All</span>
<div id="agencyWaiversDiv">

    <table id="project_waiver_catalogue_table_body" class="scrollable-table project_status_table table-sorter">
        <thead>
        <tr>
            <th id="waiver-id-header" class="waiver-code-col sortable"><span id="id">Project Code</span></th>
            <th id="waiver-name-header" class="waiver-name-col sortable"><span id="name">Project Name</span></th>
            <th id="waiver-initiator-header" class="waiver-owner-col"><span id="owner">Research End market(s)</span></th>
            <th id="waiver-year-header" class="waiver-year-col sortable"><span id="budgetyear">Budget Year</span></th>
            <th id="waiver-region-header" class="waiver-catalogue-region-col sortable" ><span id="methodologyApprover">Approver Name</span></th>
            <th id="waiver-country-header" class="waiver-catalogue-country-col" ><span id="status">Action</span></th>
            
        </tr>
        </thead>
        <tbody>
        <#list pibMethodologyWaiverList as pibWaiver>
        <tr <#if (pibWaiver_index % 2) == 0> class="last"</#if>>
            <td class="waiver-code-col"><input type="checkbox" name="${pibWaiver.projectID?c}"  id="${pibWaiver.projectID?c}" ><label for="${pibWaiver.projectID?c}"></label>${pibWaiver.projectID?c}</td>
         
            <td class="waiver-name-col"><a href="${pibWaiver.stageURL}&methWaiver=true" target="_blank">${pibWaiver.projectName?default('')}</a></td>
            <td class="waiver-owner-col">${pibWaiver.endMarketName}</td>
            <td class="waiver-year-col">${pibWaiver.budgetYear?c}</td>
            <td class="waiver-catalogue-region-col">${pibWaiver.approverName}</td>
            <td class="waiver-catalogue-country-col"><a href="javascript:void(0);" class="show-waiver-icon" onclick="showWaiverDetails('${pibWaiver.projectID?c}');"></a><a href="javascript:void(0);" class="approve-waiver-icon" onclick="approveWaiver('${pibWaiver.projectID?c}');"></a></td>
    
			<div id="waiverDetailsPopUp_${pibWaiver.projectID?c}" class="light-box j-form-popup">
				<!-- popup -->
				<a href="javascript:void(0);" class="close" onclick="closeWaiverPopUp('${pibWaiver.projectID?c}');"></a>
				<div class="popup-title-overlay"></div>
		<div class="pop-upinner-scroll">
				<div class="pop-upinner-content">
               
				
					<h3>Request for Methodology Waiver</h3>
					<div class="top-heading-Waiver">
					  <label class='rte-editor-label'>Methodology Deviation Rationale</label>
					</div>
					<div class="pib_view_popup form-text_div">
						<textarea id="methodologyDeviationRationale_${pibWaiver.projectID?c}" name="methodologyDeviationRationale_${pibWaiver.projectID?c}" disabled ><#if pibWaiver.methodologyDeviationRationale??>${pibWaiver.methodologyDeviationRationale}</#if></textarea>
					</div>
					<div class="pib_view_popup">
					   
						<label>Methodology Approver Comment</label>
						<#if isAdminUser || isSynchroSystemOwner>
							<textarea id="methodologyApproverComment_${pibWaiver.projectID?c}" name="methodologyApproverComment_${pibWaiver.projectID?c}" ><#if pibWaiver.methodologyApproverComment??>${pibWaiver.methodologyApproverComment}</#if></textarea>
						<#else>
							<textarea id="methodologyApproverComment_${pibWaiver.projectID?c}" name="methodologyApproverComment_${pibWaiver.projectID?c}" disabled ><#if pibWaiver.methodologyApproverComment??>${pibWaiver.methodologyApproverComment}</#if></textarea>
						</#if>
						<span class="jive-error-message" id="methWaiverError_${pibWaiver.projectID?c}" style="display:none">Please enter Methodology Approver Comments</span>
					</div>
					
					<div class="pib_view_popup">
					 <#if isAdminUser || isSynchroSystemOwner>

            
						<input id="request-for-information" onclick="requestMoreInfo('${pibWaiver.projectID?c}')" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
            
						<input id="approve-waiver-btn" type="button" onclick="approveUpdateWaiver('${pibWaiver.projectID?c}')" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
						<input id="reject-waiver-btn" type="button" onclick="rejectUpdateWaiver('${pibWaiver.projectID?c}')" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />
						
						
					</#if>
					</div>
				</div>
            	</div>
				<!-- popup -->
			</div>
        </tr>

        </#list>
        </tbody>
    </table>
   
</div>
<!-- Items code-->
<select name="project-limit" id="project-limit" onchange="loadLimit()">
	<option value="10">10</option>
	<option value="15">15</option>
	<option value="20">20</option>
	<option value="50">50</option>
	<option value="100">100</option>
</select>
<span id="project-limit-text">items per page</span>
<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" onclick="return rejectMultipleWaivers();" class="publish-details">Reject Selected</a>
<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" onclick="return approverMultipleWaivers();" class="publish-details">Approve Selected</a>

<#if pages?? && (pages > 1)>
<div id="pagination"></div>
</#if>
<script type="text/javascript">
<#if plimit??>
	$j("#project-limit").val(${plimit});
</#if>
    <#if pages?? && (pages>0)>
    var pages = ${pages};
    <#else>
    var pages = 1;
    </#if>
    <#if pibMethodologyWaiverList?? && (pibMethodologyWaiverList?size<1) >
    $j("a#continue").hide();
    </#if>
	$j(document).ready(function(){
		/* select all checkbox */
	$j('#selectall').change(function(){
		if( $j("#selectall").prop('checked') == true ) 
		{
		$j('.waiver-code-col input[type="checkbox"]').prop('checked', true);
		}
		else{
		$j('.waiver-code-col input[type="checkbox"]').prop('checked', false);
		}
	});
	});

/*	show waiver lightbox */
function showWaiverDetails(projectId){
	
	
	//$j("#methodologyDeviationRationale_"+projectId+"_ifr body").text("asdasd");
	$j("#waiverDetailsPopUp_"+projectId).lightbox_me({centered:true,closeEsc:false,closeClick:true,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7}});
	initiateRTE("methodologyDeviationRationale_"+projectId, 2500, false);
    initiateRTE("methodologyApproverComment_"+projectId, 2500, false);
}

function closeWaiverPopUp(projectId){
	//$j(".light-box").trigger('close');
	//$j(".light-box").hide();
	$j("#waiverDetailsPopUp_"+projectId).trigger('close');
}

	var url = window.location.href;
	var storageData =localStorage.getItem("clickSearch_box");
	if(url.indexOf("approve") > 0)
	{

	     if(storageData==1) 
		  {
           localStorage.setItem("clickSearch_box",0);
		   dialog({
					title:"",
					html:"<i class='positionSet'></i><p>Selected waiver(s) has been approved.</p>",

				});
				orangeBtn();
				 relPos();
				
		  }
				
	}

	if(url.indexOf("reject=true") > 0)
	{ 
	 if(storageData==1) 
		  {
           localStorage.setItem("clickSearch_box",0);
	  
			dialog({
					title:"",
					html:"<i class='positionSet'></i><p>Selected waiver(s) has been rejected.</p>",

				});
				orangeBtn();
				 relPos();
		 }
				
	}
	
	if(url.indexOf("reqMoreInfo=true") > 0)
	{
		dialog({
					title:"",
					html:"<i class='positionSet'></i><p>The waiver has been requested for more information.</p>",

				});
				orangeBtn();
				 relPos();
				
	}
	
	
	
	if(url.indexOf("waiverApp=true") > 0)
	{
		dialog({
					title:"",
					html:"<i class='positionSet'></i><p>The waiver has been approved.</p>",
					 buttons:{
                
                "Ok": function() {
                      closeDialog();
					  return false;
                }
            }

				});
				orangeBtn();
				 relPos();
				
	}
	
	if(url.indexOf("waiverRej=true") > 0)
	{
		dialog({
					title:"",
					html:"<i class='positionSet'></i><p>The waiver has been rejected.</p>",

				});
				orangeBtn();
				 relPos();
				
	}
	
	
	
</script>
<script src="${themePath}/js/pagination.custom.js" type="text/javascript"></script>