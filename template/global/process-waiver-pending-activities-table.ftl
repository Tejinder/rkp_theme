<#assign isSynchroSystemOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner() />
<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/error-macros.ftl" />

<#if waiverPendingActivities?? && (waiverPendingActivities?size > 0)>

<input type="checkbox" name="selectall"  id="selectall" ><label for="selectall"></label><span class="select-all-label">Select All</span>
<div id="agencyWaiversDiv">
   <table id="project_waiver_catalogue_table_body" class="scrollable-table project_status_table table-sorter">
        <thead>
        <tr>
            <th id="waiver-id-header" class="waiver-code-col sortable"><span id="id"><@s.text name="waiver.catalogue.table.header.waiver.id"/></span></th>
            <th id="waiver-name-header" class="waiver-name-col sortable"><span id="name"><@s.text name="waiver.catalogue.table.header.waiver.name"/></span></th>
            <th id="waiver-initiator-header" class="waiver-owner-col sortable"><span id="owner"><@s.text name="waiver.catalogue.table.header.initiator"/></span></th>
             <th id="waiver-country-header" class="waiver-catalogue-country-col">Research End market(s)</th>
           
             <th id="waiver-approver-header" class="waiver-approver-col sortable"><span id="approver">Approver Name</span></th>
            <th id="waiver-link-header" class="waiver-catalogue-country-col">Action</th>
        </tr>
        </thead>
        <tbody>

            <#list waiverPendingActivities as waiver>
            <tr <#if (waiver_index % 2) == 0> class="last"</#if>>
                <td class="waiver-code-col"><input type="checkbox" name="${waiver.waiverID?c}"  id="${waiver.waiverID?c}" ><label for="${waiver.waiverID?c}"></label>${waiver.waiverID?c}</td>
                <td class="waiver-name-col"><a href="<@s.url value='/new-synchro/project-waiver!input.jspa?projectWaiverID=${waiver.waiverID?c}'/>" target="_blank">
				<#if waiver.waiverName??>${waiver.waiverName}</#if></a></td>
                <td class="waiver-owner-col">${waiver.initiator}</td>
                <td class="waiver-catalogue-country-col">${waiver.country}</td>
				
				<td class="waiver-approver-col">${waiver.approver}</td>
                <td class="waiver-catalogue-country-col"><a href="javascript:void(0);" class="show-waiver-icon" onclick="showWaiverDetails('${waiver.waiverID?c}');"></a><a href="javascript:void(0);" class="approve-waiver-icon" onclick="approveWaiver('${waiver.waiverID?c}');"></a></td>
    
			<div id="waiverDetailsPopUp_${waiver.waiverID?c}" class="light-box j-form-popup research_pib">
			<a href="javascript:void(0);" class="close" onclick="closeWaiverPopUp('${waiver.waiverID?c}');"></a>
				<div class="popup-title-overlay"></div>
			<div class="pop-upinner-scroll">
				<div class="pop-upinner-content">
			<h3>Business Waiver</h3>
				<!-- popup -->
				
				<div class="popup-waiver view_edit_pib">
             
			
					
					
					<div class="region-inner">
						<label>Waiver ID</label>
						<div class="form-text_div">
							<input type="text" name="projectWaiverID" value="${waiver.waiverID?c}" class="form-text" readonly="true">
						</div>
					</div>
					<div class="region-inner">
						<label>Waiver Name</label>
						<div class="form-text_div">
							<input type="text" name="projectWaiverName" <#if waiver.waiverName??>value="${waiver.waiverName}"</#if> class="form-text" readonly="true">
						</div>
					</div>
					<div class="region-inner">
						<label>Waiver Description</label>
						<div class="form-text_div">
						
							<textarea id="methodologyDeviationRationale_${waiver.waiverID?c}" name="methodologyDeviationRationale_${waiver.waiverID?c}" disabled ><#if waiver.summary??>${waiver.summary?default('')?html}</#if></textarea>
						</div>
					</div>
					
					<div class="region-inner">
						<label>Brand / Non-Branded</label>
						<div class="form-text_div">
							<@renderBrandField name='brand' value=waiver.brandPopUp?default('-1') readonly=true />
						</div>
					</div>
					
					<div class="region-inner">
                 <!-- Waiver End Markets Multiselect -->
				   <label class="label_b"><@s.text name="waiver.initiate.endmarkets"/></label>
					<div class="pit-category form-text_div">
					
					<@displayEndMarketField name='endMarkets' value=waiver.endMarkets?default('-1') />		
					</div>
					</div>
					 <!-- attachment -->
					 <div id="waiver-preapprovals" class="region-inner">
				<div class="form-textarea_div">
					<div>
						<label>Pre Approval<span>*</span></label><br/>
					</div>
					<div class="waiver-preapproval">
						<span>All projects will require pre approval by the following people in each market</span>
						<ul class="preapproval-list">
							<li>System Owner</li>				
						</ul>
					</div>
				</div>
			</div>
			
			<div id="waiver-attachments" class="form-text_div">
				<div class="form-textarea_div">
					<#if waiver.attachments??>
						<@synchroWaiverAttachements attachments=waiver.attachments canAttach=false maxAttachCount=30 attachmentCount=10  />					
					</#if>
				</div>
			</div>
			
			<div class="region-inner">
				<label class='rte-editor-label-waiver'>Approver Comments<span></span></label>
					<div class="form-text_div">		
					
					<#if isSynchroSystemOwner>
						<textarea name="approverComments_${waiver.waiverID?c}" id="approverComments_${waiver.waiverID?c}" cols="60" rows="5" class="form-textarea" placeholder="Approver Comments"><#if waiver.approverComments??>${waiver.approverComments?default('')?html}</#if></textarea>
					<#else>		
						<textarea name="approverComments_${waiver.waiverID?c}" id="approverComments_${waiver.waiverID?c}" cols="60" rows="5" disabled class="form-textarea" placeholder="Approver Comments"><#if waiver.approverComments??>${waiver.approverComments?default('')?html}</#if></textarea>
					</#if>	
					<span class="jive-error-message" id="processWaiverError_${waiver.waiverID?c}" style="display:none">Please enter Approver Comments</span>
					
			
					</div>	
			</div>	
			
					<#if isSynchroSystemOwner>

						<input id="approve-waiver-btn" type="button" onclick="approveUpdateWaiver('${waiver.waiverID?c}')" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
						<input id="reject-waiver-btn" type="button" onclick="rejectUpdateWaiver('${waiver.waiverID?c}')" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />
						

						
						
					</#if>
					
				</div>
				</div>
				
				</div>
				<!-- popup -->
			</div>            </tr>
            </#list>

        </tbody>

    </table>

    
</div>
<#else>
<script>
    if($j.trim($j("#search_box").val())!="")
    {
        $j(".no-content").html("No results matching the criteria");
    }
    else
    {
        if(!isfilterSet())
        {
            $j("#search_box").hide();
        }
    }
</script>
<div class="no-content">No Pending Activity</div>
</#if>
<!-- Items code-->
<select name="project-limit" id="project-limit" onchange="loadLimit()">
	<option value="10">10</option>
	<option value="15">15</option>
	<option value="20">20</option>
	<option value="50">50</option>
	<option value="100">100</option>
</select>

<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" onclick="return rejectMultipleWaivers();" class="publish-details">Reject Selected</a>
<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" onclick="return approverMultipleWaivers();" class="publish-details">Approve Selected</a>

<#if pages?? && (pages>1)>
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
function showWaiverDetails(waiverId){

	$j("#waiverDetailsPopUp_"+waiverId).lightbox_me({centered:true,closeEsc:false,closeClick:true,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7}});
	initiateRTE("methodologyDeviationRationale_"+waiverId, 2500, false);
    initiateRTE("approverComments_"+waiverId, 2500, false);
}

function closeWaiverPopUp(waiverId){
	//$j(".light-box").trigger('close');
	//$j(".light-box").hide();
	$j("#waiverDetailsPopUp_"+waiverId).trigger('close');
}

  
	var url = window.location.href;
	   
	    
		var storageData =localStorage.getItem("clickSearch_box");
		
	if(url.indexOf("approve") > 0)
	{
           if(storageData==1)  // change 533
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
	
	       if(storageData==1)  // change 533
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
</script>
<script src="${themePath}/js/pagination.custom.js" type="text/javascript"></script>

