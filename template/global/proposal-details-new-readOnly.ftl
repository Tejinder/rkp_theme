

<form name="proposal" action="/new-synchro/proposal-details!execute.jspa" method="POST"  id="proposal-form" class="research_pib pib" >
<div class="research_content">
<input type="hidden" name="projectID" value="${projectID?c}">
<input type="hidden" name="isSave" value="${save?string}">
  <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
<div class="pib_inner_main">
<div class="pib_left">
	<!-- <a class="view-edit" href="javascript:void(0);" onclick="javascript:openPITWindow()">View/Edit PIT</a> -->
	<div>
         <div class="form-select_div">
            <label>Project Start Date</label>
			<input type="text" id="startDate1" name="startDate" value="" disabled>
        </div>
    </div>

    <div>
         <div class="form-select_div">
            <label>Project End Date</label>
			<input type="text" id="endDate1" name="endDate" value="" disabled>
        </div>
    </div>
	
	<div class="project_owner_brief">
        <label>Total Cost</label>
		<div class="total-cost-details">
        
		
		<#if project.totalCost??>
			<input type="text"  name="totalCost" id="totalCost" value="${project.totalCost?round} GBP" disabled/>
			
			<#if statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user))?? >

				<#if statics['com.grail.synchro.util.SynchroUtils'].getPreferredCurrenyTotalCost(project,user)?? >
					<input type="text"  name="totalCost" id="totalCost" value="${statics['com.grail.synchro.util.SynchroUtils'].getPreferredCurrenyTotalCost(project,user)?round} ${statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user))}" disabled/>
					
				<#else>
					<input type="text"  name="totalCost" id="totalCost" value="" disabled/>
				</#if>
			</#if>
				
			<#if totalCosts??>
				<#assign totalCostsKeySet = totalCosts.keySet() />
				<#list totalCostsKeySet as key>
					
					<#if JiveGlobals.getJiveIntProperty("grail.default.currency",87)!=key>
						<#if statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user)?? > 		
							<#if statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user)!=key >
								<#if statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(key)?? >
									<input type="text"  name="totalCost" id="totalCost" value="${totalCosts.get(key)?round} ${statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(key)}" disabled/>
								<#else>
									<input type="text"  name="totalCost" id="totalCost" value="${totalCosts.get(key)?round}" disabled/>
								</#if>		
							</#if>
						<#else>
							<#if statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(key)?? >
								<input type="text"  name="totalCost" id="totalCost" value="${totalCosts.get(key)?round} ${statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(key)}" disabled/>
							<#else>
								<input type="text"  name="totalCost" id="totalCost" value="${totalCosts.get(key)?round}" disabled/>
							</#if>	
						</#if>	
					</#if>
					
				</#list>
			</#if>
		<#else>
			<input type="text"  name="totalCost" id="totalCost" value="" disabled/>
			
		</#if>
		</div>
    </div>
	

	
	<!--amit-->
	 <#if project.processType?? && project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId()>
	<#assign showRefProjectMessage="" />
	  <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
	  <#assign endMarketTypeMap = statics['com.grail.synchro.SynchroGlobal'].getEndmarketMarketTypeMap() />
	  <#if endMarketIds?? >
	  <#list endMarketIds as eId>
		<#if endMarketTypeMap.get(eId?int)==1>
			<#assign showRefProjectMessage="yes" />
		<#else>
			
		</#if>
	  </#list>
	  </#if>
	  
	<#--<#if showRefProjectMessage=="yes">-->
	<#if showRefProjectMessage=="yes" && project?? && project.euMarketConfirmation?? && project.euMarketConfirmation==1 >
	<label class="label_b"> Reference Project Details</label>
	 <div class="form-text_div reference-project-details"   id="ReferenceProjectDetailsDiv">
				  
		   
		    
			  <h3><span>Research End Market</span><span>SynchrO Code</span></h3>
			  
			  <div id="dynamicReferenceProjectDetailsDiv">
			  </div>
			  
				  <script>
				  
				  var euMarkertValues=[];
				  var  euMarketText=[];
				  var  refSynCode=[];
				  var  showEndMarket=[];
	
				<#list endMarketDetails as emd >
				  <#if emd?? >
					  var emId = "${emd.getEndMarketID()}";
					  euMarkertValues.push(emId);
					  var emText = "${endMarkets.get(emd.getEndMarketID()?int)}";
					  euMarketText.push(emText);
					  <#if emd.getReferenceSynchroCode()?? && emd.getReferenceSynchroCode() gt 0 >
						var rSCode = "${emd.getReferenceSynchroCode()?c}";
						refSynCode.push(rSCode);
					  <#else>
						refSynCode.push("");
					  </#if>
					  
					  <#if endMarketTypeMap.get(emd.getEndMarketID()?int)==1>
						showEndMarket.push("yes");
					  <#else>
						showEndMarket.push("no");
					  </#if>
				  </#if>
				</#list>
				  
					var i=0;
				   for(i=0;i<euMarkertValues.length;i++)
					  {
							if(showEndMarket[i]=="yes")
							{
							  var div = $j("<div/>");
							   div.html(dynamicReferenceProjectDetailsComponents(i));  
							   $j("#dynamicReferenceProjectDetailsDiv").append(div);
								//$j(".chosen-select").chosen();
							}
						   }
						   
						   
						function dynamicReferenceProjectDetailsComponents(val)
						{
						   var comp="";
						  comp= "<div class='float-left'><select  class='chosen-select' id='referenceEndMarkets' name='referenceEndMarkets'><option value='"+euMarkertValues[val]+"'>"+euMarketText[val]+"</option></select></div>&nbsp&nbsp&nbsp&nbsp";
	
			
						 var content=comp+'<div class="float-left synchroCode_row"><input   name ="referenceSynchroCodes" type="text"   id="referenceSynchroCodes" placeholder="Enter SynchrO Code" onChange="return isNumber()"  onfocus="this.placeholder = \'\'" onblur="this.placeholder = \'Enter SynchrO Code\'"  class="text_field  longField total-expense" value='+refSynCode[val]+'><span class="jive-error-message synchroCodeError" style="display: none;">Please enter numeric value</span></div>'
	
						 return content;      
						}		
					
					function validateReferenceSynchroCodes()
					{
						 var isEmptyRefCode="no";
						/* for(i=0;i<refSynCode.length;i++)
						 {
							if(refSynCode[i]=="")
							{
								isEmptyRefCode="yes";
							}
						 }
						 return isEmptyRefCode;
						 */
						 
						 $j("#dynamicReferenceProjectDetailsDiv #referenceSynchroCodes").each(function(){
							var element = $j(this).val(); 
							if(element=="")
							{
								isEmptyRefCode="yes";
							}
						});
						return isEmptyRefCode;
					}
				   </script>
		  
			  </div>
		</#if>
	</#if>
	<!--amit-->
	
	<#if agencyWaiverException=="yes">
	<#else>
		<div id="agencyWaiverDiv" class="statusPending">
			<div class="project_waiver_rqst" >
			<label>Agency Waiver Request</label>
			<ul class="right-sidebar-list">

				<#--<li id="initiateKantarWaiverButton" ><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>-->
				
				<li id="initiateKantarWaiverButton" >
					<#if pibKantarMethodologyWaiver.methodologyApprover?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status!=-1>
						<a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);">View/Approve Waiver</a>
					<#else>
						<input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Click to Initiate Waiver" style="font-weight: bold;cursor:default;">
					</#if>
				</li>	
			</ul>
				<div class="form-select_div select-div methodology-status" id="nonKantarWaiverStatus" <#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>style="display:block;" <#else> style="display:none;"</#if>>

				<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
					<label>Status:</label>
					<span class="approvedStatus">Approved</span>
				<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
					<label>Status:</label>
					<span class="rejectedStatus">Rejected</span>
				<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID?? >
					<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_APP_PENDING.ordinal()>
					<label>Status:</label>
					<span class="pendingStatus">Pending</span>
					</#if>
				<#else>
				</#if>

				
			</div>
			</div>


		
		</div>
	</#if>	

	
	
	
	 <div class="form-select_div select-div statusPending">
        <label>Will a methodology waiver be required?</label>
		
    
		
		<select data-placeholder="Select" class="chosen-select" disabled id = "deviationFromSM" name="deviationFromSM"   onchange="checkMethDeviation()">
			<option  value="-1" <#if project.methWaiverReq?? && project.methWaiverReq==-1 > selected </#if>></option>
			<option  value="1" <#if project.methWaiverReq?? && project.methWaiverReq==1 > selected </#if>>Yes</option>
			<option  value="2" <#if project.methWaiverReq?? && project.methWaiverReq==2 > selected </#if>>No</option>
			<option  value="3" <#if project.methWaiverReq?? && project.methWaiverReq==3 > selected </#if>>I don’t know yet</option>
		</select>
		
		<span class="jive-error-message" id="deviationFromSMError" style="display:none">Please select Will a methodology waiver be required?</span>

		
       
            <script type="text/javascript">
                <#--
                var initiateWaiverWindow = null;
                $j(document).ready(function(){
                    initiateWaiverWindow = new LIGHT_BOX($j("#initiateWaiver"),{title:'Request for Methodology Waiver',confirmOnClose:true});
                    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#proposal-form"),form:$j("#waiver-form"), projectID:${projectID?c}});
                });
				-->
            </script>
            <#assign showWaiverBtn = 'none' />
			
            <#if project.methWaiverReq?? && project.methWaiverReq==1>
                <#assign showWaiverBtn = 'block' />
            </#if>

            <ul class="right-sidebar-list">
               <#-- <li id="initiateWaiverButton" style='display:${showWaiverBtn?string}'><a onclick="javascript:openInitiateWaiverWindow();" href="javascript:void(0);"><#if pibMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li> -->
			   
			   <li id="initiateWaiverButton" style='display:${showWaiverBtn?string}'> 
					<#if pibMethodologyWaiver.methodologyApprover??>
						<a onclick="javascript:openInitiateWaiverWindow();" href="javascript:void(0);">View/Approve Waiver</a>
					<#else>
						<input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Click to Initiate Waiver" style="font-weight: bold;cursor:default;">
					</#if>
				</li>	
            </ul>
       <#if project.methWaiverReq?? && project.methWaiverReq==1 && pibMethodologyWaiver?? && pibMethodologyWaiver.projectID?? >
        <div class="form-select_div select-div methodology-status">
            <label>Status:</label>
            <#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                <span class="approvedStatus">Approved</span>
            <#elseif pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==2>
                <span class="rejectedStatus">Rejected</span>
            <#else>
                <span class="pendingStatus">Pending</span>
            </#if>
        </div>
    </#if>
   
    </div>
    

   
</div>



<div class="region-inner attachment-text">
	
    <label class='rte-editor-label'>Proposal</label>
    <div class="form-text_div">
        <#if proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
		<textarea id="proposal" disabled name="proposal" rows="10" cols="20" class="form-text-div">${proposalInitiation.proposal?default('')?html}</textarea>
        <i>(In case there are multiple proposals, please attach all of them)</i>
		<@macroCustomFieldErrors msg="Please attach the Proposal" class='textarea-error-message'/>
		 <#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId()) && proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus gt 0)  >
			<textarea id="proposal" disabled name="proposal" rows="10" cols="20" class="form-text-div">${proposalInitiation.proposal?default('')?html}</textarea>
			<i>(In case there are multiple proposals, please attach all of them)</i>
		
		<#else>
			<textarea id="proposal" disabled placeholder="Add notes, if any" name="proposal" rows="10" cols="20" class="form-text-div">${proposalInitiation.proposal?default('')?html}</textarea>
			<i>(In case there are multiple proposals, please attach all of them)</i>
        <@macroCustomFieldErrors msg="Please attach the Proposal" class='textarea-error-message'/>
		</#if>
    </div>
    <textarea style="display:none;" id="proposalText" name="proposalText">${proposalInitiation.proposalText?default('')?html}</textarea>
	 <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
   <#if proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
		<#if attachmentMap?? && attachmentMap.get(proposalID)?? >
				<div id="jive-file-list" class="jive-attachments">
					<#list attachmentMap.get(proposalID) as attachment>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
						</div>
					</#list>
				</div>
			</#if>
   <#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId()) && proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus gt 0)  >
	
		<#if attachmentMap?? && attachmentMap.get(proposalID)?? >
				<div id="jive-file-list" class="jive-attachments">
					<#list attachmentMap.get(proposalID) as attachment>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
						</div>
					</#list>
				</div>
			</#if>
   
   <#else>
		
			<#if attachmentMap?? && attachmentMap.get(proposalID)?? >
				<div id="jive-file-list" class="jive-attachments">
					<#list attachmentMap.get(proposalID) as attachment>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
						</div>
					</#list>
				</div>
			</#if> 
			<!--change-->
			 
			<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId())>
			
			 <#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId())>
			   
			 <#else>
			   
			<br/>
			<br/>
			<br/>
		   <div class="right">	
	     	<a href="javascript:void(0);" style="margin-left: 10px;" onclick="return validatePIBFormFields('');" class="publish-details disabled">Save</a>	
		
		
		    <a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" onclick="return continueProject();" class="publish-details disabled">Continue</a>
         </div>
			
			</#if>
			
	</#if>
    </div>
    <!-- ATTACHMENT DISPLAY ENDS -->
</div>

    <#assign synchroUtils = jiveContext.getSpringBean("synchroUtils") />




<!-- END Market EU Online Process Starts--> 

<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId())>


<#if isLegalApprover>
	
		
		<div class="project_status_div">
		   <label>Classify for TPD Submission</label>
		   <div class="status_right_group">
		   
		   <#if (proposalInitiation?? && proposalInitiation.legalApprovalDate??) || ( proposalInitiation?? && proposalInitiation.needsDiscussion?? && proposalInitiation.needsDiscussion==1 )>
			   <#if proposalInitiation?? && proposalInitiation.legalApprovalStatus??>
					
					<@renderLegalApprovalStatusFields name='legalApprovalStatusO' value="${projectInitiation.legalApprovalStatus}"  readonly=true/>
				  <#else>	
				  
				  <@renderLegalApprovalStatusFields name='legalApprovalStatusO' value=""  readonly=true/>
				  
				</#if>
			
		   
			    <input type="button" id="confirmButtonDisable" name="" value="Approved for project to Proceed" onclick="confirmLegalApprovalSubmission();" class="save approval-btn btn-blue disabled"/>
				
			   <span>OR</span>
			  
				<input type="button" name="" id="needsDiscussionButtonDisable"  onclick="updateNeedDiscussion();" value="Needs Discussion" class="save btn-blue disabled"  />
				
			
			    <div class="buttons legalappr_btmmrgin"  id="approverContinueButton">
    
	  
	       <#else>
		        <#if proposalInitiation?? && proposalInitiation.legalApprovalStatus??>
					
					<@renderLegalApprovalStatusFields name='legalApprovalStatusO' value="${projectInitiation.legalApprovalStatus}"  readonly=true/>
				  <#else>	
				  
				  <@renderLegalApprovalStatusFields name='legalApprovalStatusO'  value=""  readonly=true/>
				  
				</#if>
			
		   
			    <input type="button" id="confirmButtonDisable" name="" value="Approved for project to Proceed" onclick="confirmLegalApprovalSubmission();" class="save approval-btn btn-blue disabled"/>
				
			   <span>OR</span>
			  
				<input type="button" name="" id="needsDiscussionButtonDisable"  onclick="updateNeedDiscussion();" value="Needs Discussion" class="save btn-blue disabled"  />
				
			
			    <div class="buttons legalappr_btmmrgin"  id="approverContinueButton">
		   
		   
		     
	 </#if>
        <br>
        
			
			<!--<a href="javascript:void(0);" style="margin-left: 10px;" onclick="return resetPIB();" class="publish-details disabled">Reset Brief</a>	-->
		
		
		
		
		
		<a href="javascript:void(0);" style="margin-left: 10px;" onclick="return validatePIBFormFields('');" class="publish-details disabled">Save</a>	
		
		
		<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" onclick="return continueProject();" class="publish-details disabled">Continue</a>
		
		 </div>
		
		</div>
		
		</div>

		
	  <#else>


	<#if !isProposalLegalApprover>
	 
	
	 <div class="project_owner_names">
			<label>Legal Approver's Name</label>
			
			
			<#if proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
				<select data-placeholder="Select Legal Approver" disabled class="chosen-select" id = "briefLegalApprover" name='briefLegalApprover' >
			<#elseif proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus == 1 || proposalInitiation.legalApprovalStatus == 2)  >
				<select data-placeholder="Select Legal Approver" disabled class="chosen-select" id = "briefLegalApprover" name='briefLegalApprover' >
			<#else>
				<select data-placeholder="Select Legal Approver"  disabled class="chosen-select" id = "briefLegalApprover" name='briefLegalApprover' >
			</#if>
			  <option value=""></option>
				  
				   <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
				   <#assign endMarketApproversKeySet = endMarketLegalApprovers.keySet() />
				   <#list endMarketApproversKeySet as key>
						<optgroup label="${endMarkets.get(key?int)}">
						<#list endMarketLegalApprovers.get(key) as legalUser >
							<#if proposalInitiation?? && proposalInitiation.proposalLegalApprover?? && proposalInitiation.proposalLegalApprover == legalUser.ID>
								<option value="${legalUser.ID?c}" selected>${legalUser.name}</option>
							<#else>
								<option value="${legalUser.ID?c}">${legalUser.name}</option>
							</#if>
						</#list>
						</optgroup>
				   </#list>
						
			</select>
			 
			 <span class="jive-error-message full-width" id="briefLegalApproverError" style="display:none">Please Select Brief Legal Approver</span>
			
		<#if proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
			<div class="reminder-wrapper">
			<input type="button" name=""  onclick="updateSendReminder();" value="Send Reminder" class="save approval-btn btn-blue disabled"/>
			<#if proposalInitiation?? && proposalInitiation.sendReminderDate??>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="g-btn g-btn-medium disabled" value="Send Reminder" style="font-weight: bold;cursor:default;"/>
			<p>Reminder Sent On ${projectInitiation.sendReminderDate?string('dd/MM/yyyy')}</p>
			</#if>
			</div>
			<span class="approval-status">TPD Status: Pending</span>
		<#elseif proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus == 1)  >
			<span class="approval-status">TPD Status: May have to be TPD Submitted</span>
		<#elseif proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus==2)  >
			<span class="approval-status">TPD Status: Does not have to be TPD Submitted</span>
		<#else>
			
			<a href="javascript:void(0);"  style="margin-left: 10px;" class="publish-details disabled">Send For TPD Approval</a>	
			
			 
		</#if>

	 </div>
	        
	 <div class="right">
	 <a href="javascript:void(0);" style="margin-left: 10px;" onclick="return validatePIBFormFields('');" class="publish-details disabled">Save</a>	
		
		
		<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" onclick="return continueProject();" class="publish-details disabled">Continue</a>
	 </div>
	 
	 
		
		
	</#if>	
	
	</#if>




	
	
</#if>

<!-- END Market EU Online Process Ends--> 

<!-- END Market EU Offline Process Starts--> 

<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId())>
	
	
	<#if !isProposalLegalApprover>
	 
	<#if proposalInitiation?? && proposalInitiation.legalSignOffRequired?? && proposalInitiation.legalSignOffRequired==1>	
	
	 <!--amit code-->
	    <div class="project_owner_names legal_approval_dropdown_height">
			<label>Legal Approver's Name</label>
			
		<#--	<#if isSynchroSystemOwner>
				<select data-placeholder="Select Legal Approver"  disabled class="chosen-select" id = "proposalLegalApprover" name='proposalLegalApprover' >
			<#elseif proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
				<select data-placeholder="Select Legal Approver" disabled class="chosen-select" id = "proposalLegalApprover" name='proposalLegalApprover' >
			<#else>
				<select data-placeholder="Select Legal Approver" disabled  class="chosen-select" id = "proposalLegalApprover" name='proposalLegalApprover' >
			</#if>
			  <option value=""></option>
				  
				   <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
				   <#assign endMarketApproversKeySet = endMarketLegalApprovers.keySet() />
				   <#list endMarketApproversKeySet as key>
						<optgroup label="${endMarkets.get(key?int)}">
						<#list endMarketLegalApprovers.get(key) as legalUser >
							<#if proposalInitiation?? && proposalInitiation.proposalLegalApprover?? && proposalInitiation.proposalLegalApprover == legalUser.ID>
								<option value="${legalUser.ID?c}" selected>${legalUser.name}</option>
							<#else>
								<option value="${legalUser.ID?c}">${legalUser.name}</option>
							</#if>
						</#list>
						</optgroup>
				   </#list>
						
			</select>
			-->
			
			<#if isSynchroSystemOwner>
				<input type="text" id="proposalLegalApprover" placeholder="Select Legal Approver" name="proposalLegalApproverOffline"  disabled value=""  />	
			<#elseif proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
				<input type="text" id="proposalLegalApprover" disabled placeholder="Select Legal Approver" name="proposalLegalApproverOffline"  disabled value=""  />	
			<#else>
				<input type="text" id="proposalLegalApprover" disabled placeholder="Select Legal Approver" name="proposalLegalApproverOffline"  disabled value=""  />	
			</#if>
			
			<#if isSynchroSystemOwner>
			<#else>
				<div id="attachApprovalMailDiv">	
					<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${proposalLegalApprovalID?c})" ></span>
				</div>
				<sub>Attach Approval E-mail</sub>
			</#if>	
			<#if attachmentMap?? && attachmentMap.get(proposalLegalApprovalID)?? >
				<div id="jive-file-list" class="attachmentsNew jive-attachments">
					<#list attachmentMap.get(proposalLegalApprovalID) as attachment>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser || isSynchroSystemOwner) >
								<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${proposalLegalApprovalID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
							</#if>
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
						</div>
					</#list>
				</div>
			</#if>
			
			 <span class="jive-error-message full-width" id="proposalLegalApproverError" style="display:none">Please select Legal Approver’s Name</span>
			 <span class="full-width jive-error-message" id="attachApprovalEmailError" style="display:none">Please attach approval e-mail</span>
			

	 </div>
		 
		 <div class="region-inner">
		<div class="form-select_div">
			<label>TPD Status</label>
			<#if proposalInitiation?? && proposalInitiation.legalApprovalStatus?? >
				<#if isSynchroSystemOwner>
					<@renderLegalApprovalStatusFields name='legalApprovalStatusO' value="" readonly=true/>
				<#else>
					<@renderLegalApprovalStatusFields name='legalApprovalStatusO' value="" readonly=true/>
				</#if>	
			<#else>
				
				<#if isSynchroSystemOwner>
					<@renderLegalApprovalStatusFields name='legalApprovalStatusO' value="-1" readonly=true/>
				<#else>
					<@renderLegalApprovalStatusFields name='legalApprovalStatusO' value="-1" />
				</#if>
			</#if>
						<span class="full-width jive-error-message" id="TPDStatusError" style="display:none">Please select TPD Status</span>
		</div>
	</div>
		 
		<#if isSynchroSystemOwner>
			<div class="date-approval"><label>Date of Legal Approval</label> 
			<#if proposalInitiation?? && proposalInitiation.legalApprovalDate?? >		
				
				<input type="text" id="legalApprovalDate1" name="legalApprovalDate1" value="${proposalInitiation.legalApprovalDate?string('dd/MM/yyyy')}" disabled>
			<#else>
				<input type="text" id="legalApprovalDate1" name="legalApprovalDate1" value="" disabled>
			
			</#if>	
		<#else>
		
			<div class="date-approval"><label>Date of Legal Approval</label> <input type="text" id="legalApprovalDate1" name="legalApprovalDate1" value="" placeholder="Enter Legal Approval Date"  disabled>
		</#if>	
		<span class="full-width jive-error-message" id="legalApprovalDateError" style="display:none">Please select Legal Approval Date</span>

		
		
	<#else>
	 <div class="project_owner_names legal_approval_dropdown_height">
			<label>Legal Approver's Name</label>
			
		<#--	<#if isSynchroSystemOwner>
				<select data-placeholder="Select Legal Approver"  class="chosen-select" id = "proposalLegalApprover" name='proposalLegalApprover' >
			<#elseif proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
				<select data-placeholder="Select Legal Approver" disabled class="chosen-select" id = "proposalLegalApprover" name='proposalLegalApprover' >
			<#else>
				<select data-placeholder="Select Legal Approver"  class="chosen-select" id = "proposalLegalApprover" name='proposalLegalApprover' >
			</#if>
			  <option value=""></option>
				  
				   <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
				   <#assign endMarketApproversKeySet = endMarketLegalApprovers.keySet() />
				   <#list endMarketApproversKeySet as key>
						<optgroup label="${endMarkets.get(key?int)}">
						<#list endMarketLegalApprovers.get(key) as legalUser >
							<#if proposalInitiation?? && proposalInitiation.proposalLegalApprover?? && proposalInitiation.proposalLegalApprover == legalUser.ID>
								<option value="${legalUser.ID?c}" selected>${legalUser.name}</option>
							<#else>
								<option value="${legalUser.ID?c}">${legalUser.name}</option>
							</#if>
						</#list>
						</optgroup>
				   </#list>
						
			</select>
			-->
			
			<#if isSynchroSystemOwner>
				<#if proposalInitiation.getProposalLegalApproverOffline()??>
					<input type="text" id="proposalLegalApprover" disabled placeholder="Select Legal Approver" name="proposalLegalApproverOffline"  value="${proposalInitiation.getProposalLegalApproverOffline()}"  />
				<#else>
					<input type="text" id="proposalLegalApprover"  disabled placeholder="Select Legal Approver" name="proposalLegalApproverOffline"  value=""  />
				</#if>	
			<#elseif proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
			
				<#if proposalInitiation.getProposalLegalApproverOffline()??>
					<input type="text" id="proposalLegalApprover" placeholder="Select Legal Approver" name="proposalLegalApproverOffline" disabled value="${proposalInitiation.getProposalLegalApproverOffline()}"  />
				<#else>
					<input type="text" id="proposalLegalApprover" placeholder="Select Legal Approver" name="proposalLegalApproverOffline" disabled value=""  />
				</#if>	
			<#else>
				<#if proposalInitiation.getProposalLegalApproverOffline()??>
					<input type="text" disabled id="proposalLegalApprover" placeholder="Select Legal Approver" name="proposalLegalApproverOffline"  value="${proposalInitiation.getProposalLegalApproverOffline()}"  />
				<#else>
					<input type="text" id="proposalLegalApprover" disabled placeholder="Select Legal Approver" name="proposalLegalApproverOffline"  value=""  />
				</#if>	
			</#if>
			
			
			<#if isSynchroSystemOwner || isAdminUser>
		         		<div id="attachApprovalMailDiv">	
					<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${proposalLegalApprovalID?c})" ></span>
				</div>
				<sub>Attach Approval E-mail</sub>
				
				
			
			<#else>
				
				<br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Attach Approval E-mail
				
			
			</#if>	
			<#if attachmentMap?? && attachmentMap.get(proposalLegalApprovalID)?? >
				<div id="jive-file-list" class="attachmentsNew jive-attachments">
					<#list attachmentMap.get(proposalLegalApprovalID) as attachment>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser || isSynchroSystemOwner) >
								<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${proposalLegalApprovalID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
							</#if>
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
						</div>
					</#list>
				</div>
			</#if>
			
			 <span class="full-width  jive-error-message" id="proposalLegalApproverError" style="display:none">Please enter Legal Approver's Name</span>
			<span class="full-width jive-error-message" id="attachApprovalEmailError" style="display:none">Please attach Approval E-mail</span>
			

	 </div>
	 <div class="region-inner">
		<div class="form-select_div">
			<label>TPD Status</label>
			<#if proposalInitiation?? && proposalInitiation.legalApprovalStatus?? >
				<#if isSynchroSystemOwner || isAdminUser>
					<@renderLegalApprovalStatusFields name='legalApprovalStatusO' value="${proposalInitiation.legalApprovalStatus}"  />
				<#else>
					<@renderLegalApprovalStatusFields name='legalApprovalStatusO' value="${proposalInitiation.legalApprovalStatus}"  readonly=true/>
				</#if>	
			<#else>
				
				<#if isSynchroSystemOwner>
					<@renderLegalApprovalStatusFields name='legalApprovalStatusO' value="-1" />
				<#else>
					<@renderLegalApprovalStatusFields name='legalApprovalStatusO' value="-1" readonly=true/>
				</#if>
			</#if>
			<span class="full-width jive-error-message" id="TPDStatusError" style="display:none">Please select TPD Status</span>
		</div>
	</div>
	 
		<div class="date-approval"><label>Date of Legal Approval</label> 
		<#if proposalInitiation?? && proposalInitiation.legalApprovalDate?? >		
					
					<input type="text" id="legalApprovalDate1" name="legalApprovalDate1" value="${proposalInitiation.legalApprovalDate?string('dd/MM/yyyy')}" disabled/>
				<#else>
					<input type="text" id="legalApprovalDate1" name="legalApprovalDate1" value="Enter Legal Approval Date" disabled/>
				</#if>	
		
		</div>
			
		</div>
	</#if>	
	
	<div class="right">
     <a href="javascript:void(0);" style="margin-left: 10px;" onclick="return validatePIBFormFields('');" class="publish-details disabled">Save</a>	
		
		
		<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" onclick="return continueProject();" class="publish-details disabled">Continue</a>
		</div>
	</#if>	
	
</#if>

<!-- END Market EU Offline Process Ends--> 

<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId())>
<#if !isProposalLegalApprover>
	
	 <#assign methodologyProperties = statics['com.grail.synchro.SynchroGlobal'].getMethodologyProperties() />
	 <#assign methBriefException ="" /> 
	 <#assign counter =0 />
	 <#list project.methodologyDetails as md>
	 <#if counter==0>
		 <#if methodologyProperties.get(md?int).isProposalException() >
			 <#assign methBriefException ="yes" /> 
		 </#if>
	</#if>
	<#assign counter = counter + 1 />
	 </#list>
	 
	 <#if methBriefException == "yes">
		
		<#if (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId())>
			<div class="legal-checkbox" id="legal-checkbox"><input disabled type="checkbox" name="legalsignoffreq" id="legalsignoffreq" <#if proposalInitiation?? && proposalInitiation.legalSignOffRequired?? && proposalInitiation.legalSignOffRequired==1> checked="true"</#if> >This project does not require legal sign-off on Proposal.<br></div>
		<#elseif proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
		<div class="legal-checkbox" id="legal-checkbox"><input type="checkbox" name="legalsignoffreq" disabled id="legalsignoffreq" <#if proposalInitiation?? && proposalInitiation.legalSignOffRequired?? && proposalInitiation.legalSignOffRequired==1> checked="true"</#if> >This project does not require legal sign-off on Proposal.<br></div>
		<#elseif proposalInitiation?? && proposalInitiation.needsDiscussion?? && proposalInitiation.needsDiscussion==1 >
			<div class="legal-checkbox" id="legal-checkbox"><input type="checkbox" disabled name="legalsignoffreq" id="legalsignoffreq"  <#if proposalInitiation?? && proposalInitiation.legalSignOffRequired?? && proposalInitiation.legalSignOffRequired==1> checked="true"</#if>>This project does not require legal sign-off on Proposal.<br></div>
		<#elseif proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && proposalInitiation.legalApprovalStatus gt 0>
			<div class="legal-checkbox" id="legal-checkbox"><input type="checkbox" name="legalsignoffreq" disabled id="legalsignoffreq" <#if proposalInitiation?? && proposalInitiation.legalSignOffRequired?? && proposalInitiation.legalSignOffRequired==1> checked="true"</#if> >This project does not require legal sign-off on Proposal.<br></div>
		<#else>
			<div class="legal-checkbox" id="legal-checkbox"><input type="checkbox" disabled name="legalsignoffreq" id="legalsignoffreq"  <#if proposalInitiation?? && proposalInitiation.legalSignOffRequired?? && proposalInitiation.legalSignOffRequired==1> checked="true"</#if>>This project does not require legal sign-off on Proposal.<br></div>
		</#if>
		
		<input type="hidden" id="legalSignOffReqValue" name="legalSignOffReqValue" value="" />
	 </#if>
	
	<!-- <div class="right"> -->
<!--	<a href="javascript:void(0);" style="margin-right:0px" onclick="return validatePIBFormFields('');" class="publish-details disabled">Save</a>	
		
		
		<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" onclick="return continueProject();" class="publish-details disabled">Continue</a>
	</div> -->
	
									
</#if>
</#if>


<script type="text/javascript">
    var initiateKantarWaiverWindow = null;
    $j(document).ready(function(){
	<#--	<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && (pibKantarMethodologyWaiver.isApproved==1 || pibKantarMethodologyWaiver.isApproved==2)>
		initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request for Agency Waiver',confirmOnClose:false});
		<#elseif  pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status==0>
			initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request for Agency Waiver',confirmOnClose:false});
		<#else>

			initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request for Agency Waiver',confirmOnClose:true});
		</#if>-->
      <#--  FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#proposal-form"),form:$j("#kantar-waiver-form"), projectID:${projectID?c}}); -->
    });

</script>



</div>
</div>
</div>

</form>







<#include "/template/global/include/import-doc-form.ftl" />



<div id="initiateWaiver" style="display:none">
    <script type="text/javascript">
        $j(document).ready(function(){
            if($j("#initiateWaiver").parent().hasClass('light-box'))
            {
                $j("#initiateWaiver").parent().prepend($j("#success-msg-waiver"));
            }
        });
    </script>
    <div class="">
  
   
		
        <form id="waiver-form" action="<@s.url value='/new-synchro/proposal-details!updateWaiver.jspa'/>" method="post" class="j-form-popup">
        	 <a href="javascript:void(0);" class="close" onclick="closeWaiverWindow();"></a>
			<div class="popup-title-overlay"></div>
			<div class="pop-upinner-scroll"> 
			<div class="pop-upinner-content">
			
			 <#if  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
		        <div id="success-msg-waiver" class="approve-msg-waiver margtop15">
		            <span class="waiver-icon"></span>
		            <span class="waiver-msg">Waiver is Approved.</span>
		        </div>
		    <#elseif  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==2>
		        <div id="success-msg-waiver" class="reject-msg-waiver margtop15">
		            <span class="waiver-icon"></span>
		            <span class="waiver-msg waiver-rejected">Waiver is Rejected.</span>
		        </div>
		    <#elseif pibMethodologyWaiver.status?? && pibMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_MORE_INFO_REQ.ordinal()>
				<div id="success-msg-waiver" class="req-more-info-msg-waiver margtop15">
		            <span class="waiver-icon"></span>
		            <span class="waiver-msg waiver-rejected">More information is required on this waiver.</span>
		        </div>
			</#if>
			
			
        	 <h3>Request for Methodology Waiver</h3>
            <div class="pib_view_popup form-text_div">
            <#if isAdminUser>
                <textarea id="methodologyDeviationRationale" name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>

			<#elseif !(isProjectCreator) >
                <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            
           
            <#elseif  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
				
			<#elseif  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==2>
                <textarea id="methodologyDeviationRationale" name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
				
			<#elseif pibMethodologyWaiver?? && pibMethodologyWaiver.status?? && pibMethodologyWaiver.status==0>
				<textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>		
				
            <#else>
                <textarea id="methodologyDeviationRationale" name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            </#if>
			<span class="jive-error-message" id="methDeviationError" style="display:none">Please enter Methodology Deviation Rationale</span>
            </div>
            <div class="pib_view_popup">
                

                
            <#if isAdminUser>
                <input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
             

            <#elseif  isProjectCreator>
                <#if  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                    <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
                    
                 <#elseif  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==2>
<input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
				
				<#elseif  pibMethodologyWaiver.status?? && pibMethodologyWaiver.status==0>
                      <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
				
				<#else>
                    <input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
             
                </#if>

            <#else>
                <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
             
            </#if>

            </div>

            <div class="pib_view_popup">
                <label>Methodology Approver Comment</label>

                
            <#if isAdminUser>
                <textarea id="methodologyApproverComment" name="methodologyApproverComment" placeholder="Methodology Approver Comments">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
	<span class="jive-error-message" id="methWaiverError" style="display:none">Please enter Methodology Approver Comments</span>

            <#elseif isSynchroSystemOwner>
                <#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                    <textarea id="methodologyApproverComment"  disabled name="methodologyApproverComment">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
	<span class="jive-error-message" id="methWaiverError" style="display:none">Please enter Methodology Approver Comments</span>
                <#else>
                    <textarea id="methodologyApproverComment" name="methodologyApproverComment" placeholder="Methodology Approver Comments">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
<span class="jive-error-message" id="methWaiverError" style="display:none">Please enter Methodology Approver Comments</span>
               
                </#if>

                
            <#else>
                <textarea id="methodologyApproverComment"  disabled name="methodologyApproverComment">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
	<span class="jive-error-message" id="methWaiverError" style="display:none">Please enter Methodology Approver Comments</span>
            </#if>
            </div>
	
		 <div class="pib_view_popup">
            
        <#if isAdminUser>
            <input id="request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
            <input id="approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
            <input id="reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />

        <#elseif isSynchroSystemOwner>

            <#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                <input type="button" class="g-btn r-more" name="doPost" id="postButton"  value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
            <#else>
                <input id="request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
            </#if>
            <#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton"  value="Approve" style="font-weight: bold;cursor:default;" />
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />
            <#elseif pibMethodologyWaiver.status?? && pibMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_APP_PENDING.ordinal()>
                <input id="approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
                <input id="reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />
            <#elseif pibMethodologyWaiver.status?? && pibMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_MORE_INFO_REQ.ordinal()>
                <input id="approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
                <input id="reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />
            <#else>
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton"  value="Approve" style="font-weight: bold;cursor:default;" />
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />
            </#if>



            
        <#else>
            <input type="button" class="g-btn r-more"  name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium"  name="doPost" id="postButton" value="Approve" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />
        </#if>
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" name="endMarketId" value="${endMarketId?c}">
            <input type="hidden" id="methodologyWaiverAction" name="methodologyWaiverAction" value="">
		</div>	
        </form>
    </div>
</div>



<div id="initiateKantarWaiver" class="j-form-popup" style="display:none">
    <script type="text/javascript">
        $j(document).ready(function(){
            if($j("#initiateKantarWaiver").parent().hasClass('light-box'))
            {
                $j("#initiateKantarWaiver").parent().prepend($j("#success-msg-waiver-kantar"));
            }
        });
    </script>
<a href="javascript:void(0);" class="close" onclick="closeKantarWaiverWindow();"></a>
     <div class="">

  

        <form id="kantar-waiver-form" action="<@s.url value='/new-synchro/proposal-details!updateKantarWaiver.jspa'/>" method="post">
		<div class="popup-title-overlay"></div>
		
		   <div class="pop-upinner-scroll"> 
		       <#if  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
				<div id="success-msg-waiver-kantar" class="approve-msg-waiver margtop15">
					<span class="waiver-icon"></span>
					<span class="waiver-msg">Waiver is Approved.</span>
				</div>
			<#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
				<div id="success-msg-waiver-kantar" class="reject-msg-waiver margtop15">
					<span class="waiver-icon"></span>
					<span class="waiver-msg waiver-rejected">Waiver is Rejected.</span>
				</div>
			<#elseif pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_MORE_INFO_REQ.ordinal()>
				<div id="success-msg-waiver-kantar" class="req-more-info-msg-waiver margtop15">
		            <span class="waiver-icon"></span>
		            <span class="waiver-msg waiver-rejected">More information is required on this waiver.</span>
		        </div>
			</#if>
		    
			<div class="pop-upinner-content">
            <h3>Agency Deviation Rationale</h3>
            <div class="pib_view_popup form-text_div">
            <#if isAdminUser>
                <textarea id="methodologyDeviationRationaleKantar" name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>

            <#elseif !(isProjectCreator) >
                <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            <#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            
			<#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
                <textarea id="methodologyDeviationRationaleKantar" name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>

			<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status==0>
				<textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>	
				
			<#else>
                <textarea id="methodologyDeviationRationaleKantar" name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            </#if>
			<span class="jive-error-message" id="agencyDeviationError" style="display:none">Please enter Agency Deviation Rationale</span>
            </div>
			
			
			<div class="pib_view_popup ">
			<div class="waiver-summary">
			
			<a href='${JiveGlobals.getJiveProperty("synchro.agency.waiver.template.path"," /file/download/AgencyCostDetails-SingleMarketTemplate.xlsx")}'>Download Agency Waiver Summary Template</a>
			
			<p>Waiver Summary</p> 
			<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${agencyWaiverID?c})" ></span>
			</div>
			</div>
			
			<#if attachmentMap?? && attachmentMap.get(agencyWaiverID)?? >
				<div id="jive-file-list" class="jive-attachments">
					<#list attachmentMap.get(agencyWaiverID) as attachment>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
								<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${agencyWaiverID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
							</#if>
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
						</div>
					</#list>
				</div>
			</#if>

			 
            <div class="pib_view_popup">
               
                
            <#if isAdminUser>
                <input id="kantar-send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
               

            <#elseif isProjectCreator>
                <#if  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                    <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
				
				<#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
                     <input id="kantar-send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
				
				<#elseif  pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status==0>
                      <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
				
				
                <#else>
                    <input id="kantar-send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
              
                </#if>

            <#else>
                <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
              
            </#if>

            </div>

            <div class="pib_view_popup">
                <label>Approver's Comment</label>

                
            <#if isAdminUser>
                <textarea id="methodologyApproverCommentKantar" name="methodologyApproverComment" placeholder="Agency Approver's Comments">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
<span class="jive-error-message" id="methKantarWaiverError" style="display:none">Please enter Agency Approver's Comments</span>

            <#elseif  isSynchroSystemOwner>
                <#if pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                    <textarea id="methodologyApproverCommentKantar"  disabled name="methodologyApproverComment">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
	<span class="jive-error-message" id="methKantarWaiverError" style="display:none">Please enter Agency Approver's Comments</span>
                <#else>
                    <textarea id="methodologyApproverCommentKantar" name="methodologyApproverComment" placeholder="Agency Approver's Comments">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
                <span class="jive-error-message" id="methKantarWaiverError" style="display:none">Please enter Agency Approver's Comments</span>
                </#if>

                
            <#else>
                <textarea id="methodologyApproverCommentKantar"  disabled name="methodologyApproverComment">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
<span class="jive-error-message" id="methKantarWaiverError" style="display:none">Please enter Agency Approver's Comments</span>
            </#if>
            </div>

        <div class="pib_view_popup ">
		
        <#if isAdminUser>
            <input id="kantar-request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
            <input id="kantar-approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
            <input id="kantar-reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />

        <#elseif isSynchroSystemOwner>

           
            <#if pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton"  value="Approve" style="font-weight: bold;cursor:default;" />
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />
            <#elseif pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_APP_PENDING.ordinal()>
                <input id="kantar-approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
                <input id="kantar-reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />
            <#elseif pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_MORE_INFO_REQ.ordinal()>
                <input id="kantar-approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
                <input id="kantar-reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />
            <#else>
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton"  value="Approve" style="font-weight: bold;cursor:default;" />
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />
            </#if>

	    <#if pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                <input type="button" class="g-btn r-more" name="doPost" id="postButton"  value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
            <#else>
                <input id="kantar-request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
            </#if>


       
        <#else>
            <input type="button" class="g-btn r-more"  name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium"  name="doPost" id="postButton" value="Approve" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />
        </#if>
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" name="endMarketId" value="${endMarketId?c}">
            <input type="hidden" id="kantarMethodologyWaiverAction" name="kantarMethodologyWaiverAction" value="">
		 </div>	
        </form>
    </div>
</div>



<div id="pitWindow" style="display:none">
    <div class="view_edit_pib">
        <form id="synchro-pit-form" action="<@s.url value='/new-synchro/proposal-details!updatePIT.jspa'/>" method="post" class="j-form-popup">
		 <a href="javascript:void(0);" class="close" onclick="closePITWindow();"></a>
		  <div class="popup-title-overlay"></div>
		  <div class="pop-upinner-scroll">
		   <div class="pop-upinner-content">
            <h3>Project Details Overview</h3>
		
            <div class="pib_view_popup region-inner">
                <label>Project Name </label>
            
		<#if isAdminUser>
			<input type="text" id="projectName" name="projectName" value="${project.name?html}" class="pit_window_field_width"/>
		<#else>
			<input type="text" id="projectName" name="projectName" disabled value="${project.name?html}" lass="pit_window_field_width"/>
		</#if>
            </div>
			<div class="region-inner">
            <label class="pit-description-label">Project Description</label>
           
			  
			<div class="form-text_div">
				<textarea id="description" name="description" disabled rows="10" cols="20" class="form-text-div">${project.description?default('')?html}</textarea>
				<@macroCustomFieldErrors msg="Please enter the Project description" class='textarea-error-message'/>
			</div>
			<textarea style="display:none;" id="descriptionText" name="descriptionText">${project.description?default('')?html}</textarea>
             </div>
            
			
			<div class="region-inner">
				
				<label class="label_b"><@s.text name="project.initiate.project.category"/></label>
				<div class="col-lg-6">
			  
					<select data-placeholder="" class="chosen-select" disabled id = "categoryType" name="categoryType" multiple >
					  <option value=""></option>
						   <#assign categoryTypes = statics['com.grail.synchro.SynchroGlobal'].getProductTypes() />
								<#assign categoryTypeKeySet = categoryTypes.keySet() />
								<#if (categoryTypes?has_content)>
									<#list categoryTypeKeySet as key>
										<#assign categoryType = categoryTypes.get(key) />
										 <option value="${key?c}" <#if project.categoryType?seq_contains(key)> selected</#if> >${categoryType}</option>
									</#list>
								</#if>
						</select>
				
					<span class="jive-error-message" id="categoryTypeError" style="display:none">Please Select Category </span>
					
				
				</div>
			</div>
			
			<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId()) >
			<#else>
				<div class="region-inner">
					
					<div class="form-select_div">
						
						<label>Is the project a fieldwork component of an above market study?</label>
					
					<@fieldworkstudyField name='fieldWorkStudy' value=project.fieldWorkStudy?default('-1') readonly=true/>
					<#assign error_msg><@s.text name='project.error.brand' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>


				</div>
			</#if>

			
			<div class="region-inner">
				<#assign selectedEndMarket="" />
				<#if endMarketDetails?? && endMarketDetails?size gt 0 >
				<#assign selectedEndMarket= endMarketDetails.get(0).endMarketID />
				</#if>
				<#if project.processType?? && project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId()>
						<label class="label_b">Research End Market(s)</label>
				
						<div class="">
				
						<select data-placeholder="" disabled class="chosen-select" id = "endMarkets" name='endMarkets' multiple disabled >
						<option value=""></option>
					    <#assign endMarketRegions = statics['com.grail.synchro.SynchroGlobal'].getRegionEndMarketsMapping() />
					    <#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
					    <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getNonEUEndMarkets() />
							<#assign endMarketRegionsKeySet = endMarketRegions.keySet() />
							<#if (endMarketRegions?has_content)>
								<#list endMarketRegionsKeySet as key>
									<#assign region = endMarketRegions.get(key) />
									 <optgroup label="${regions.get(key)}">
										 <#assign endMarketKeySet = endMarketRegions.get(key).keySet() />
										 <#list endMarketKeySet as endMarketkey>
											<#if endMarketIds?? && endMarketIds?size gt 0>
												<option value="${endMarketkey?c}" eu="${endMarketTypeMap.get(endMarketkey)}" <#if endMarketIds?seq_contains(endMarketkey)> selected </#if>>${endMarkets.get(endMarketkey)}</option>
												
												
												<#else>
													<option value="${endMarketkey?c}" eu="${endMarketTypeMap.get(endMarketkey)}" >${endMarkets.get(endMarketkey)}</option>
												</#if>
											
										 </#list>
									</optgroup>	 
								</#list>
							</#if>

					<#else>
						<label class="label_b">Research End Market</label>
				
						<div class="">
						<select data-placeholder="" disabled class="chosen-select" id = "endMarkets" name='endMarkets' >
					
					    <option value=""></option>
					    <#assign endMarketRegions = statics['com.grail.synchro.SynchroGlobal'].getRegionEndMarketsMapping() />
					    <#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
					    <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
							<#assign endMarketRegionsKeySet = endMarketRegions.keySet() />
							<#if (endMarketRegions?has_content)>
								<#list endMarketRegionsKeySet as key>
									<#assign region = endMarketRegions.get(key) />
									 <optgroup label="${regions.get(key)}">
										 <#assign endMarketKeySet = endMarketRegions.get(key).keySet() />
										 <#list endMarketKeySet as endMarketkey>
											<option value="${endMarketkey?c}" <#if selectedEndMarket==endMarketkey> selected </#if>>${endMarkets.get(endMarketkey)}</option>
										 </#list>
									</optgroup>	 
								</#list>
							</#if>
					</#if>

					</select>
					<span class="jive-error-message" id="endMarketError" style="display:none"><@s.text name='project.error.endmarket' /></span>
				
				</div>
			</div>
			
			<div class="region-inner">
					
				<div class="form-select_div start_date">
					<label>Project Start Date</label>
			   
				<input type="text" name="startDate" id="startDate" value="" disabled/>
			
				</div>
			</div>	
			<div class="region-inner">
				<div class="form-select_div form-select_div_project_completion">
					<label>Project End Date</label>
					 
				<input type="text" name="endDate" id="endDate" value="" disabled/>
			
				</div>
			</div>
			
			<div class="region-inner">
				
				
				<div class="form-select_div">
					
					<label>SP&I Contact</label>
					<div>
					
					   
					<input type="text"  name="projectManagerName" disabled value="${project.projectManagerName}" id="projectManagerName"  />

					<#assign error_msg>Please select SP&I Contact</#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
				</div>

				<!-- Project SP&I Contact -->
		
				<#--<div class="form-select_div form-select_div_project_completion">
				
					<label>Project Initiator</label>
					<div>
						<input type="text"  name="projectInitiator" value="${user.name}" id="projectInitiator"  disabled />
					
					<#assign error_msg><@s.text name="project.error.spi"/></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
				</div>
				-->
				
			</div>
			
			<div class="region-inner">
					
					<label class="label_b">Methodology</label>
					<div class="col-lg-6">
				  
						<#if isAdminUser>
							<select data-placeholder="" class="chosen-select" id = "methodologyDetails" name = "methodologyDetails" multiple >
						<#else>
							<select data-placeholder="" class="chosen-select" disabled id = "methodologyDetails" name = "methodologyDetails" >
						</#if>
						  <option value=""></option>
							   <#assign methMethGroupMapping = statics['com.grail.synchro.SynchroGlobal'].getMethodologyMapping() />
							   <#assign methGroup = statics['com.grail.synchro.SynchroGlobal'].getMethodologyGroups(true, 0) />
							   <#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getMethodologies() />
							   <#assign methodologyProperties = statics['com.grail.synchro.SynchroGlobal'].getMethodologyProperties() />
							   
							   <#if project.methodologyDetails?? && !statics['com.grail.synchro.util.SynchroPermHelper'].isActiveMethodologyDetails(project.getMethodologyDetails())>
										<#assign methMethGroupMapping = statics['com.grail.synchro.SynchroGlobal'].getAllMethodologyMapping() />
										<#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getAllMethodologies() />
										<#assign methodologyProperties = statics['com.grail.synchro.SynchroGlobal'].getAllMethodologyProperties() />
								</#if>
								
									<#assign methMethGroupKeySet = methMethGroupMapping.keySet() />
									<#if (methMethGroupMapping?has_content)>
										<#list methMethGroupKeySet as key>
											 <optgroup label="${methGroup.get(key)}">
												 <#assign methKeySet = methMethGroupMapping.get(key).keySet() />
												 <#list methKeySet as methkey>
													<#if methodologyProperties.get(methkey).isLessFrequent() >
														<option lessFrequent="yes" value="${methkey?c}" brandSpecific="${methodologyProperties.get(methkey).getBrandSpecific()}" <#if project.methodologyDetails?seq_contains(methkey)> selected</#if>>${methodologies.get(methkey)}</option>
													<#else>
														<option lessFrequent="no" value="${methkey?c}" brandSpecific="${methodologyProperties.get(methkey).getBrandSpecific()}" <#if project.methodologyDetails?seq_contains(methkey)> selected</#if>>${methodologies.get(methkey)}</option>
													</#if>
												 </#list>
											</optgroup>	 
										</#list>
									</#if>
						</select>
						<span class="jive-error-message" id="methodologyDetailsError" style="display:none">Please select Methodology</span>
					
					</div>
				</div>

				<div class="region-inner">
					<!-- Methodology Group -->
					<div class="form-select_div">
						<label>Methodology Type</label>
				
					<@renderMethodologyField name='methodologyType' value=project.methodologyType?default('-1') readonly=true/>
					<@macroCustomFieldErrors msg="Please select Methodology Type" />
					
					</div>
					
				</div>
				
				<div class="region-inner">
					
					<div class="form-select_div">
						<label>Will a methodology waiver be required?</label>
					
					<#--<@renderMethodologyWaiverField name='methWaiverReq' value=project.methWaiverReq?default('-1') />-->
					
					<select data-placeholder="Select" class="chosen-select" id = "methWaiverReq" name="methWaiverReq" disabled  onchange="checkMethDeviation()">
						<option  value="-1" <#if project.methWaiverReq?? && project.methWaiverReq==-1 > selected </#if>></option>
						<option  value="1" <#if project.methWaiverReq?? && project.methWaiverReq==1 > selected </#if>>Yes</option>
						<option  value="2" <#if project.methWaiverReq?? && project.methWaiverReq==2 > selected </#if>>No</option>
						<option  value="3" <#if project.methWaiverReq?? && project.methWaiverReq==3 > selected </#if>>I don’t know yet</option>
					</select>
					
					<#assign showWaiverBtn = 'none' />
			
					<#if project.methWaiverReq?? && project.methWaiverReq==1>
						<#assign showWaiverBtn = 'block' />
					</#if>

					<ul class="right-sidebar-list">
					<#--	<li id="initiateWaiverButtonPIT" style='display:${showWaiverBtn?string}'><a onclick="javascript:openInitiateWaiverWindow();" href="javascript:void(0);"><#if pibMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li> -->
					
						<li id="initiateWaiverButtonPIT" style='display:${showWaiverBtn?string}'> 
							<#if pibMethodologyWaiver.methodologyApprover??>
								<a onclick="javascript:openInitiateWaiverWindow();" href="javascript:void(0);">View/Approve Waiver</a>
							<#else>
								<input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Click to Initiate Waiver" style="font-weight: bold;cursor:default;">
							</#if>
						</li>	
					</ul>
					
					 <#if project.methWaiverReq?? && project.methWaiverReq==1 && pibMethodologyWaiver?? && pibMethodologyWaiver.projectID?? >
						<div class="waiver_methodology">
							
							<#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
								<span>Status: <span class="status-txt approvedStatus">Approved</span></span>
							<#elseif pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==2>
								<span>Status: <span class="status-txt rejectedStatus">Rejected</span></span>
							<#else>
								<span>Status: <span class="status-txt pendingStatus">Pending</span></span>
							</#if>
						</div>
					</#if>
					<span class="jive-error-message" id="methodologyWaiverError" style="display:none">Please select Will a methodology waiver be required?</span>
					</div>
					<div id="waiverMessage" style="display:none">You will be able to initiate waiver through the system once the project is created</div>
				</div>
				
				<div class="region-inner">
					
					<div class="form-select_div">
						<label>Is this a brand specific study?</label>
					
					<@renderBrandSpecificStudy name='brandSpecificStudy' value=project.brandSpecificStudy?default('-1') readonly=true/>
					<span class="jive-error-message" id="brandSpecificStudyError" style="display:none">Please select Is this a brand specific study?</span>
					<div id="brandSpecific" style="display:none">
					
					<div class="form-select_div">
						
					
					<@renderBrandFieldNew name='brand' value=project.brand?default('-1') readonly=true/>
					<span class="jive-error-message" id="brandError" style="display:none">Please select Brand</span>
					</div>
					
					</div>
					<div id="brandSpecificStudyType">
					
					
										
					<@renderBrandSpecificStudyType name='brandSpecificStudyType' value=project.brandSpecificStudyType?default('-1') readonly=true/>
					<span class="jive-error-message" id="brandSpecificStudyTypeError" style="display:none">Please select Study Type</span>
					
					</div>
					</div>
					
					
				</div>
				
				
				<div class="region-inner">
					
					<div class="form-select_div">
						<label>Budget Location</label>
					
					<#assign userBudgetLocation = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationEndMarkets(user) />
						
					<select data-placeholder="Select the Budget Location" class="chosen-select" disabled id = "budgetLocation" name="budgetLocation" >
							<option value=""></option>
								<#if project.projectType?? && project.projectType==1>
									<option  value="-1" <#if project.budgetLocation?? && project.budgetLocation?int==-1> selected </#if> >Global</option>
								<#elseif project.projectType?? && project.projectType==2>
									<#--<#if statics['com.grail.synchro.util.SynchroPermHelper'].isRegionalUserType()>
										<#assign userRegionBudgetLocation = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationRegions(user) />
										<#list userRegionBudgetLocation as uRegionBugLoc>
											<#if project?? && project.budgetLocation?? && project.budgetLocation==uRegionBugLoc>
												<option  value="${uRegionBugLoc}" selected >${regions.get(uRegionBugLoc?int)}</option>
											<#else>
												<option  value="${uRegionBugLoc}" >${regions.get(uRegionBugLoc?int)}</option>
											</#if>
										</#list>
									</#if>-->
									<#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
									<#assign regionsKeySet = regions.keySet() />
									<#list regionsKeySet as key>
										<#if project?? && project.budgetLocation?? && project.budgetLocation==key>
											<option  value="${key}" selected >${regions.get(key?int)}</option>
										<#else>
											<option  value="${key}" >${regions.get(key?int)}</option>
										</#if>
									</#list>
								<#else>	
									<#--<#if userBudgetLocation?? && userBudgetLocation?size gt 0 >
								
										<#list userBudgetLocation as ubugLoc>
										<option  value="${ubugLoc}" <#if project.budgetLocation?int==ubugLoc?int> selected </#if>>${endMarkets.get(ubugLoc?int)}</option>
										</#list>
									</#if> -->
									<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
									<#assign endMarketsKeySet = endMarkets.keySet() />
									
									<#list endMarketsKeySet as key>
										<option  value="${key}" <#if project.budgetLocation==key> selected </#if>>${endMarkets.get(key?int)}</option>
									</#list>
								</#if>
								
								<#--<#if statics['com.grail.synchro.util.SynchroPermHelper'].isGlobalUserType()>
									<option  value="-1" <#if project.budgetLocation==-1> selected </#if> >Global</option>
								</#if>
								
								<#if statics['com.grail.synchro.util.SynchroPermHelper'].isRegionalUserType()>
									<#assign userRegionBudgetLocation = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationRegions(user) />
									<#list userRegionBudgetLocation as uRegionBugLoc>
										<#if project?? && project.budgetLocation?? && project.budgetLocation==uRegionBugLoc>
											<option  value="${uRegionBugLoc}" selected >${regions.get(uRegionBugLoc?int)}</option>
										<#else>
											<option  value="${uRegionBugLoc}" >${regions.get(uRegionBugLoc?int)}</option>
										</#if>
									</#list>
								</#if>
							
								<#if userBudgetLocation?? && userBudgetLocation?size gt 0 >
									
									<#list userBudgetLocation as ubugLoc>
									<option  value="${ubugLoc}" <#if project.budgetLocation==ubugLoc> selected </#if>>${endMarkets.get(ubugLoc?int)}</option>
									</#list>
								</#if>-->
						</select>
					<span class="jive-error-message" id="budgetLocationError" style="display:none">Please select Budget Location</span>
					</div>
				</div>

				<div class="region-inner">
				<@projectBudgetYearFieldNew name="budgetYear" value=project.budgetYear readonly=true/>
				<span class="full-width"><span class="jive-error-message" id="budgetYearError" style="display:none">Please select Budget Year</span></span>
				</div>
				
				<div id="expenseDetailsContainer" class="region-inner">
				<label>Cost Details</label>
					<div class="border-box pit_window_field_width border-inputradius">
					
					<#assign projectCostCounter = 0 />
						<#assign showAgencyWaiver=""/>
					<#list projectCostDetailsList as projectCostDetail>
					
					<#assign projectCostCounter =  projectCostCounter + 1/>
					<div class="expense_row expense_row_readonly">
					
					
					<div class="region-inner">
						
						
					
					<div id="agencyMain">
				
						<select data-placeholder="Select Research Agency" title="Select Research Agency" disabled class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
						
						  <option value=""></option>
							   <#assign researchAgencyMapping = statics['com.grail.synchro.SynchroGlobal'].getResearchAgencyMapping() />
							   <#assign researchAgencyGroups = statics['com.grail.synchro.SynchroGlobal'].getResearchAgencyGroup() />
							   <#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getResearchAgency() />
							   
							    <#if !statics['com.grail.synchro.util.SynchroPermHelper'].isActiveResearchAgency(projectID)>
									<#assign researchAgencyMapping = statics['com.grail.synchro.SynchroGlobal'].getAllResearchAgencyMapping() />
									<#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getAllResearchAgency() />
								</#if>
								
									<#assign researchAgencyMappingKeySet = researchAgencyMapping.keySet() />
									<#if (researchAgencyMapping?has_content)>
										<#list researchAgencyMappingKeySet as key>
											<#assign researchAgnecyGroup = researchAgencyMapping.get(key) />
											 <optgroup label="${researchAgencyGroups.get(key)}">
												 <#assign researchAgencyKeySet = researchAgencyMapping.get(key).keySet() />
												 <#list researchAgencyKeySet as researchAgencykey>
													
													<#if researchAgencyGroups.get(key) =="Non-Kantar" >
														<option isNonKantar="yes" value="${researchAgencykey?c}" <#if projectCostDetail.getAgencyId()==researchAgencykey> selected </#if>>${researchAgencies.get(researchAgencykey)}</option>
														<#if projectCostDetail.getAgencyId()==researchAgencykey>
														<#assign showAgencyWaiver="yes"/>
														</#if>
													<#else>
														<option isNonKantar="no" value="${researchAgencykey?c}" <#if projectCostDetail.getAgencyId()==researchAgencykey> selected </#if>>${researchAgencies.get(researchAgencykey)}</option>
														
													</#if>
												 </#list>
											</optgroup>	 
										</#list>
									</#if>
						</select>
							<span class='jive-error-message researchAgencydynamicError'  style='display:none'>Please Select Research Agency</span>
					
					</div>
					</div>
					
					<div class="region-inner">
						
						<@renderCostComponent name="costComponents"  value="${projectCostDetail.getCostComponent()?default('-1')}" id="costComponent" readonly=true/>
						<span class='jive-error-message costComponentdynamicError'  style='display:none'>Please Select Cost Component</span> 
						
					</div>
					<div class="region-inner">
						<@renderCurrenciesFieldNew name='currencies' value="${projectCostDetail.getCostCurrency()?default(-1)}" disabled=true id="currency" />
						<span class='jive-error-message costCurrencytdynamicError'  style='display:none'>Please Select Cost Currency</span>
					</div>

					
					<div class="region-inner">
						<!-- Project Initial Cost Field -->
						<div class="form-select_div">
							<div class="pit-estimate-cost">
								<!-- <label><@s.text name="project.initiate.project.cost"/></label> -->
							<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" Placeholder="Enter Cost" disabled class="text_field  longField total-expense" value="${projectCostDetail.getEstimatedCost()}" />
							
							<span class="jive-error-message agencyCostsError" style="display: none;">Please Enter Agency Cost</span>
							</div>
							
						</div>

					</div>
					</div>
					
					</#list>
					
					<#-- Adding a Blank Row Starts-->
					
						<div class="expense_row blank">
					 
						<div class="region-inner">
							
						
							<div id="agencyMain">
						  
							
								<select data-placeholder="Select Research Agency" title="Select Research Agency" disabled class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
								  <option value=""></option>
									   <#assign researchAgencyMapping = statics['com.grail.synchro.SynchroGlobal'].getResearchAgencyMapping() />
									   <#assign researchAgencyGroups = statics['com.grail.synchro.SynchroGlobal'].getResearchAgencyGroup() />
									   <#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getResearchAgency() />
									   
									    <#if !statics['com.grail.synchro.util.SynchroPermHelper'].isActiveResearchAgency(projectID)>
											<#assign researchAgencyMapping = statics['com.grail.synchro.SynchroGlobal'].getAllResearchAgencyMapping() />
											<#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getAllResearchAgency() />
										</#if>
											<#assign researchAgencyMappingKeySet = researchAgencyMapping.keySet() />
											<#if (researchAgencyMapping?has_content)>
												<#list researchAgencyMappingKeySet as key>
													<#assign researchAgnecyGroup = researchAgencyMapping.get(key) />
													 <optgroup label="${researchAgencyGroups.get(key)}">
														 <#assign researchAgencyKeySet = researchAgencyMapping.get(key).keySet() />
														 <#list researchAgencyKeySet as researchAgencykey>
															<#if researchAgencyGroups.get(key) =="Non-Kantar" >
																<option isNonKantar="yes" value="${researchAgencykey?c}">${researchAgencies.get(researchAgencykey)}</option>
															<#else>
																<option isNonKantar="no" value="${researchAgencykey?c}">${researchAgencies.get(researchAgencykey)}</option>
															</#if>
														 </#list>
													</optgroup>	 
												</#list>
											</#if>
								</select>
								
								
								<span class='jive-error-message researchAgencydynamicError'  style='display:none'>Please Select Research Agency</span>
							   
							</div>
						</div>
						
						<div class="region-inner">
							<@renderCostComponent name="costComponents" value="" id='costComponent' readonly=true/>
							<span class='jive-error-message costComponentdynamicError'  style='display:none'>Please Select Cost Component</span> 
						</div>
						<div class="region-inner">
							<@renderCurrenciesFieldNew name='currencies' value='-1' disabled=true id='currency'/>
							<span class='jive-error-message costCurrencytdynamicError'  style='display:none'>Please Select Cost Currency</span>
						</div>

						
						<div class="region-inner">
							<!-- Project Initial Cost Field -->
							<div class="form-select_div">
								<div class="pit-estimate-cost">
									<!-- <label><@s.text name="project.initiate.project.cost"/></label> -->

								<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" Placeholder="Enter Cost" disabled class="text_field longField total-expense" value="" />
								<span class="jive-error-message agencyCostsError" style="display: none;">Please Enter Agency Cost</span>
								</div>
								
							</div>

						</div>
					</div>
					
					<#-- Adding a Blank Row Ends-->
						<div class="region-inner total-cost">
						<!-- Project Initial Cost Field -->
						<div class="form-select_div">
							<div class="pit-estimate-cost gbp-costalignment">
								<label>Total Cost (GBP)</label>
								 <#if project.totalCost??>
									<input type="text" placeholder="0" name="totalCost" class="text_field numericfield longField" value="${project.totalCost?round}" disabled />
								  <#else>
									<input type="text" placeholder="0" name="totalCost" class="text_field numericfield longField" value="" disabled />
								  </#if>

								 <input type="hidden"  name="totalCostHidden"  id="totalCostHidden" value="" />	
							<#assign error_msg><@s.text name="project.error.cost"/></#assign>
							<@macroCustomFieldErrors msg=error_msg class="numeric-error"/>
							</div>
							
							<!--Code for Displaying the cost in Preferred currency -->
							<#if statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user)?? && JiveGlobals.getJiveIntProperty("grail.default.currency",87)==statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user)>
							<#else>
								<div class="pit-estimate-cost gbp-costalignment">
								
								<#if statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user))?? >
									<label>Total Cost (${statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user))})</label>
								
									<#if statics['com.grail.synchro.util.SynchroUtils'].getPreferredCurrenyTotalCost(project,user)?? >
										<input type="text" placeholder="0" id="prefCost" name="prefCost" class="longField" value="${statics['com.grail.synchro.util.SynchroUtils'].getPreferredCurrenyTotalCost(project,user)?round}" disabled />
									<#else>
										<input type="text" placeholder="0" id="prefCost" name="prefCost" class="longField" value="" disabled />
									</#if>
								  
								</#if>  

								<#assign error_msg><@s.text name="project.error.cost"/></#assign>
								<@macroCustomFieldErrors msg=error_msg class="numeric-error"/>
								</div>
							</#if>	
							
						</div>
	 
					</div>
					<#if agencyWaiverException=="yes">
					<#else>
						<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status != -1>
						<#else>
							<div id="nonKantarAgencyMessage" style="display:none">This project requires a waiver for using non-Kantar agency. You can initiate a waiver once a project is created.
							</div>
						</#if>
					</#if>	
					</div>
				</div>
				
			<#if agencyWaiverException=="yes">
			<#else>
				<div class="project_waiver_rqst region-inner statusPending" id="agencyWaiverDivPIT">
					<label>Agency Waiver Request</label>
					<ul class="right-sidebar-list">

					<#--	<li id="initiateKantarWaiverButtonPIT" ><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li> -->
					
					<li id="initiateKantarWaiverButtonPIT" >
						<#if pibKantarMethodologyWaiver.methodologyApprover?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status!=-1>
							<a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);">View/Approve Waiver</a>
						<#else>
							<input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Click to Initiate Waiver" style="font-weight: bold;cursor:default;">
						</#if>
					</li>	
					</ul>
					<div  class="agency_methodology" id="nonKantarWaiverStatus" <#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>style="display:block;" <#else> style="display:none;"</#if>>

						<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
							<span>Status: <span class="status-txt approvedStatus">Approved</span></span>
						<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
							<span>Status: <span class="status-txt rejectedStatus">Rejected</span></span>
						<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID?? >
							<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_APP_PENDING.ordinal()>
								<span>Status: <span class="status-txt pendingStatus">Pending</span></span>
							</#if>	
						<#else>
						</#if>
					</div>
				</div>
			</#if>	
				
			<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
			
			<#-- two column row code replace-->
			
			<div class="region-inner two-column">
					
				<div class="form-select_div">
					<label>Is an end market involved in this project?</label>
				
					<#if project.endMarketFunding??>
							<@renderEndMarketFundingField name='endMarketFunding' value=project.endMarketFunding?default('-1') readonly=true/>
					<#else>
							<@renderEndMarketFundingField name='endMarketFunding' value=-1/>
					</#if>
				
				</div>
				
				<div class="form-select_div second-column" id="fundingMarketsDiv" <#if project.endMarketFunding?? && project.endMarketFunding==1> style="display:block" <#else>style="display:none"</#if>>
					<label>Select the end market which will carry out the fieldwork</label>
				
					<#if project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId()>
						<select data-placeholder="Select end market" class="chosen-select" id = "fundingMarkets" disabled name="fundingMarkets" multiple >
							<option value=""></option>
							<#if endMarketDetails??>
							    <#list endMarketDetails as emd >
								    <#if emd?? && emd.getIsFundingMarket()?? && emd.getIsFundingMarket()>
									    <option value="${emd.getEndMarketID()}" selected>${endMarkets.get(emd.getEndMarketID()?int)}</option>
									<#else>
										<option value="${emd.getEndMarketID()}">${endMarkets.get(emd.getEndMarketID()?int)}</option>
									</#if>
								</#list>
							</#if>
							
						</select>	

					<#else>
					
						<select data-placeholder="Select end market" class="chosen-select" disabled id = "fundingMarkets" name="fundingMarkets" >
							<option value=""></option>
							<#if endMarketDetails??>
							    <#list endMarketDetails as emd >
								    <#if emd?? && emd.getIsFundingMarket()?? && emd.getIsFundingMarket()>
									    <option value="${emd.getEndMarketID()}" selected>${endMarkets.get(emd.getEndMarketID()?int)}</option>
									<#else>
										<option value="${emd.getEndMarketID()}">${endMarkets.get(emd.getEndMarketID()?int)}</option>
									</#if>
								</#list>
							</#if>
						</select>	

					<!--	<script type="text/javascript">
							var endMarketO=$j('#endMarkets').val();
							var endMarketText = $j('select[name="endMarkets"] option:selected').text();
							$j("#fundingMarkets option").val(endMarketO).text(endMarketText);
							$j('#fundingMarkets').val(endMarketO).trigger('chosen:updated');
						</script>					-->
					</#if>
				</div>
			</div>			
			</#if>	
			
			<div class="region-inner">
					<label class="pit-description-label">Brief</label>
				   
					  
					<div class="form-text_div">
						
						<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
							<textarea id="brief" name="brief" rows="10" cols="20" disabled class="form-text-div">${projectInitiation.brief?default('')?html}</textarea>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
						<#else>
						<textarea id="brief" name="brief" rows="10" cols="20" disabled class="form-text-div">${projectInitiation.brief?default('')?html}</textarea>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
						</#if>	
					</div>
					<textarea style="display:none;" id="briefText" name="briefText">${projectInitiation.briefText?default('')?html}</textarea>
					 <!-- ATTACHMENT DISPLAY STARTS -->
						<div class="field-attachments">
					   
					   <#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
							
						
							<#if attachmentMap?? && attachmentMap.get(briefID)?? >
								<div id="jive-file-list" class="jive-attachments">
									<#list attachmentMap.get(briefID) as attachment>
										<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
											<span class="jive-icon-med jive-icon-attachment"></span>
											
											<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
											${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
										</div>
									</#list>
								</div>
							</#if>
					   
					   
					   <#elseif projectInitiation?? && projectInitiation.sendForApproval?? && projectInitiation.sendForApproval==1 >
							<#if attachmentMap?? && attachmentMap.get(briefID)?? >
									<div id="jive-file-list" class="jive-attachments">
										<#list attachmentMap.get(briefID) as attachment>
											<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
												<span class="jive-icon-med jive-icon-attachment"></span>
												<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
												${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
											</div>
										</#list>
									</div>
								</#if>
						<#elseif projectInitiation?? && projectInitiation.legalApprovalStatus?? && (projectInitiation.legalApprovalStatus gt 0)  >
							<#if attachmentMap?? && attachmentMap.get(briefID)?? >
									<div id="jive-file-list" class="jive-attachments">
										<#list attachmentMap.get(briefID) as attachment>
											<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
												<span class="jive-icon-med jive-icon-attachment"></span>
												<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
												${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
											</div>
										</#list>
									</div>
								</#if>
					   <#else>
							
								<#if attachmentMap?? && attachmentMap.get(briefID)?? >
									<div id="jive-file-list" class="jive-attachments">
										<#list attachmentMap.get(briefID) as attachment>
											<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
												<span class="jive-icon-med jive-icon-attachment"></span>
												<#--<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
												</#if>-->
												<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
												${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
											</div>
										</#list>
									</div>
								</#if>
						</#if>
						</div>
						<!-- ATTACHMENT DISPLAY ENDS -->
  			    </div>
				
				<#if projectInitiation?? && projectInitiation.legalSignOffRequired?? && projectInitiation.legalSignOffRequired==1> 
				<#else>
				
				<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId())>
				
					<#if projectInitiation?? && projectInitiation.sendForApproval?? && projectInitiation.sendForApproval==1 >
						<span class="approval-status popTpd">TPD Status: <span class="status-txt">Pending</span></span>
					<#elseif projectInitiation?? && projectInitiation.legalApprovalStatus?? && (projectInitiation.legalApprovalStatus == 1)  >
						<span class="approval-status popTpd">TPD Status: <span class="status-txt">May have to be TPD Submitted</span></span>
					<#elseif projectInitiation?? && projectInitiation.legalApprovalStatus?? && (projectInitiation.legalApprovalStatus==2)  >
						<span class="approval-status popTpd">TPD Status: <span class="status-txt">Does not have to be TPD Submitted</span></span>
					</#if>
				</#if>
				<#if project.processType?? && project.processType !=  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() && project.processType !=  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId()>

				<div class="form-select_div form-select_div_project_completion region-inner">
					
					<label>Legal Approver's Name</label>
					<div class="legalAppAttach">
					   <#if projectInitiation.getBriefLegalApproverOffline()??>
								<input type="text"  id="legalApproverName" disabled placeholder="Select Legal Approver" name="briefLegalApproverOffline"  value="${projectInitiation.getBriefLegalApproverOffline()}"  disabled/>
							<#else>
							    <!-- Amit Change   for Online process  drop down appear-->
							    <#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId())>
								
								
								   
								<select data-placeholder="Select Legal Approver" disabled class="chosen-select" id = "briefLegalApprover" name='briefLegalApprover'><span class="jive-error-message full-width" id="legalApproverError" style="display:none">Please select Legal Approver's Name</span>
							
								<option value=""></option>
								<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
								<#assign endMarketApproversKeySet = endMarketLegalApprovers.keySet() />
								<#list endMarketApproversKeySet as key>
									<optgroup label="${endMarkets.get(key?int)}">
										<#list endMarketLegalApprovers.get(key) as legalUser >
										<#if projectInitiation?? && projectInitiation.briefLegalApprover?? && projectInitiation.briefLegalApprover == legalUser.ID>
											<option value="${legalUser.ID?c}" selected>${legalUser.name}</option>
										<#else>
											<option value="${legalUser.ID?c}">${legalUser.name}</option>
										</#if>
										</#list>
									</optgroup>
								</#list>
									
							</select>
								
								 <#else>
								<input type="text" id="legalApproverName" disabled placeholder="Select Legal Approver" name="briefLegalApproverOffline"  value=""  />
								
								 </#if>
								
							</#if>	
						
						<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
							<sub>Attach Approval E-mail</sub>
							<#if attachmentMap?? && attachmentMap.get(briefLegalApprovalID)?? >
								<div id="jive-file-list" class="attachmentsNew jive-attachments">
									<#list attachmentMap.get(briefLegalApprovalID) as attachment>
										<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
											<span class="jive-icon-med jive-icon-attachment"></span>
											
											<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
											${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
										</div>
									</#list>
								</div>
							</#if>
						</#if>
					</div>
						<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
				
					 <div class="region-inner">
						<div class="form-select_div">
							<label>TPD Status</label>
							<#if projectInitiation?? && projectInitiation.legalApprovalStatus?? >
								<@renderLegalApprovalStatusFields name='legalApprovalStatusPit' value="${projectInitiation.legalApprovalStatus}" readonly=true/>
							<#else>
								<@renderLegalApprovalStatusFields name='legalApprovalStatusPit' value="-1" readonly=true/>
							</#if>
						</div>
					</div>
					
					
					<div class="form-select_div form-select_div_project_completion region-inner">
					
						<label>Date of Legal Approval</label>
						<div>
							<#if projectInitiation?? && projectInitiation.legalApprovalDate??>
							<input type="text"  name="legalApproverDatePit" value="${projectInitiation.legalApprovalDate?string('dd/MM/yyyy')}" id="legalApproverDatePit"  disabled />
							<#else>
								<input type="text"  name="legalApproverDatePit" value="" id="legalApproverDatePit"  disabled />
							</#if>
							
							
						</div>
					</div>
					
				</#if>
				</div>
				
			
				 </#if>
				 </#if>
				<#if methBriefException?? && methBriefException == "yes">
		
					<#if projectInitiation?? && projectInitiation.legalSignOffRequired?? && projectInitiation.legalSignOffRequired==1> 
						<div id="legal-checkbox" class="region-inner"><input type="checkbox" name="legalsignoffreqdisable" disabled id="legalsignoffreqdisable" <#if projectInitiation?? && projectInitiation.legalSignOffRequired?? && projectInitiation.legalSignOffRequired==1> checked="true"</#if> >This project does not require legal sign-off on Brief.<br></div>
					</#if>
					
				</#if>
				
				
            
            <div class="pib_band_view">
            
                
            </div>
            </div>
			</div>
			</div>
        </form>
    </div>
</div>


</div>


</div>

  
  
  
  
  
  
