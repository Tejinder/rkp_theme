<div>
	<#assign agencyWaiverID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].AGENCY_WAIVER.getId()/>
    <table id="project_waiver_catalogue_table_body" class="scrollable-table project_status_table table-sorter">
        <thead>
        <tr>
            <th id="waiver-id-header" class="waiver-code-col sortable"><span id="id">Project Code</span></th>
            <th id="waiver-name-header" class="waiver-name-col sortable"><span id="name">Project Name</span></th>
            <th id="waiver-initiator-header" class="waiver-owner-col"><span id="owner">Research End market(s)</span></th>
			<th id="waiver-initiator-header" class="waiver-owner-col sortable"><span id="methodologydetails">Methodology</span></th>
            <th id="waiver-year-header" class="waiver-year-col sortable"><span id="budgetyear">Budget Year</span></th>
            <th id="waiver-region-header" class="waiver-catalogue-region-col sortable" ><span id="methodologyApprover">Approver Name</span></th>
            <th id="waiver-country-header" class="waiver-catalogue-country-col sortable" ><span id="status">Status</span></th>
			<th id="waiver-country-header" class="waiver-catalogue-country-col " ><span id="waiverSummary">Waiver Document</span></th>
			<th id="waiver-country-header" class="waiver-catalogue-country-col" ><span id="action">Action</span></th> 
            
        </tr>
        </thead>
        <tbody>
        <#list pibMethodologyWaiverList as pibWaiver>
        <tr <#if (pibWaiver_index % 2) == 0> class="last"</#if>>
            <td class="waiver-code-col">${pibWaiver.projectID?c}</td>
         
            <td class="waiver-name-col"><a href="${pibWaiver.stageURL}&agencyWaiver=true" target="_blank">${pibWaiver.projectName?default('')}</a></td>
            <td class="waiver-owner-col">${pibWaiver.endMarketName}</td>
			<td class="waiver-owner-col">${pibWaiver.methodology}</td>
            <td class="waiver-year-col">${pibWaiver.budgetYear?c}</td>
            <td class="waiver-catalogue-region-col">${pibWaiver.approverName}</td>
            <td class="waiver-catalogue-country-col"><#if pibWaiver.isApproved?? && pibWaiver.isApproved==1>Approved<#elseif pibWaiver.isApproved?? && pibWaiver.isApproved==2>Rejected<#else>Pending</#if></td>
			<td class="waiver-catalogue-country-col">
				<#if pibWaiver.attachmentMap?? && pibWaiver.attachmentMap.get(agencyWaiverID)?? >
					<div id="jive-file-list" class="jive-attachments">
						<#list pibWaiver.attachmentMap.get(agencyWaiverID) as attachment>
							<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
								<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
								${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
							</div>
						</#list>
					</div>
				</#if>
			 
			</td>
			
			 <td class="waiver-catalogue-country-col"><a href="javascript:void(0);" class="show-waiver-icon" onclick="showWaiverDetails('${pibWaiver.projectID?c}');"></a></td>
			 
			 <div id="waiverDetailsPopUp_${pibWaiver.projectID?c}" class="light-box j-form-popup">
				<!-- popup -->
				<a href="javascript:void(0);" class="close" onclick="closeWaiverPopUp('${pibWaiver.projectID?c}');"></a>
				<div class="popup-title-overlay"></div>
				<div class="pop-upinner-scroll">
				<div class="pop-upinner-content">
               
				
					<h3>Request for Agency Waiver</h3>
					
				
					<label class='rte-editor-label'>Agency Deviation Rationale</label>
					<div class="pib_view_popup form-text_div">
						<textarea id="methodologyDeviationRationale_${pibWaiver.projectID?c}" name="methodologyDeviationRationale_${pibWaiver.projectID?c}" disabled ><#if pibWaiver.methodologyDeviationRationale??>${pibWaiver.methodologyDeviationRationale}</#if></textarea>
					</div>
					
					
					<div class="pib_view_popup">
					<div class="waiver-summary">
	
						<p>Waiver Document</p> 

					</div>
					<#if pibWaiver.attachmentMap?? && pibWaiver.attachmentMap.get(agencyWaiverID)?? >
						<div id="jive-file-list" class="jive-attachments">
							<#list pibWaiver.attachmentMap.get(agencyWaiverID) as attachment>
								<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
									<span class="jive-icon-med jive-icon-attachment"></span>
									
									<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
									${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
								</div>
							</#list>
						</div>
					</#if>
					</div>
					
					<div class="pib_view_popup">
						<label>Agency Approver Comment</label>
						
						<textarea id="methodologyApproverComment_${pibWaiver.projectID?c}" name="methodologyApproverComment_${pibWaiver.projectID?c}" disabled ><#if pibWaiver.methodologyApproverComment??>${pibWaiver.methodologyApproverComment}</#if></textarea>
						
					</div>
					
					
				</div>
				<!-- popup -->
			</div>
			</div>
			</div>
            
        </tr>

        </#list>
        </tbody>
    </table>
	
	<!-- Items code-->
	<select name="project-limit" id="project-limit" onchange="loadLimit()">
		<option value="10">10</option>
		<option value="15">15</option>
		<option value="20">20</option>
		<option value="50">50</option>
		<option value="100">100</option>
	</select>
	<span id="project-limit-text">items per page</span>

    
</div>
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
	
function showWaiverDetails(projectId)
{
	
	
	//$j("#methodologyDeviationRationale_"+projectId+"_ifr body").text("asdasd");
	$j("#waiverDetailsPopUp_"+projectId).lightbox_me({centered:true,closeEsc:false,closeClick:true,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7}});
	initiateRTE("methodologyDeviationRationale_"+projectId, 2500, false);
    initiateRTE("methodologyApproverComment_"+projectId, 2500, false);
}

function closeWaiverPopUp(projectId)
{
	//$j(".light-box").trigger('close');
	//$j(".light-box").hide();
	$j("#waiverDetailsPopUp_"+projectId).trigger('close');
}

</script>
<script src="${themePath}/js/pagination.custom.js" type="text/javascript"></script>