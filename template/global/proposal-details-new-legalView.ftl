

<form name="pib-form" action="/new-synchro/pib-details!execute.jspa" method="POST"  id="pib-form" class="research_pib pib" >
<div class="research_content">
<input type="hidden" name="projectID" value="${projectID?c}">
<input type="hidden" name="isSave" value="${save?string}">
  <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
<div class="pib_inner_main">
<div class="pib_left">
	<!-- <a class="view-edit" href="javascript:void(0);" onclick="javascript:openPITWindow()">View/Edit PIT</a> -->
	<div>
        <div class="form-date_div">
            <label>Project Start Date</label>
			
			<input type="text" id="startDate1" name="startDate" value="" disabled>
			
        </div>
        
    </div>

    <div>
        <div class="form-date_div">
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
	
	
	
	<#if agencyWaiverException=="yes">
	<#else>
		<div id="agencyWaiverDiv" class="statusPending">
			<div class="project_waiver_rqst">
			<label>Agency Waiver Request</label>
			<ul class="right-sidebar-list">

			<#--	<li id="initiateKantarWaiverButton" ><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li> -->
			
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
		
        <select name="deviationFromSM" id="deviationFromSM" class="form-select" onchange="checkMethDeviation()" disabled>
           <option  value="-1" <#if project.methWaiverReq?? && project.methWaiverReq==-1 > selected </#if>></option>
			<option  value="1" <#if project.methWaiverReq?? && project.methWaiverReq==1 > selected </#if>>Yes</option>
			<option  value="2" <#if project.methWaiverReq?? && project.methWaiverReq==2 > selected </#if>>No</option>
			<option  value="3" <#if project.methWaiverReq?? && project.methWaiverReq==3 > selected </#if>>I don’t know yet</option>
        </select>
		
		

		
       
            <script type="text/javascript">
                <#--
                var initiateWaiverWindow = null;
                $j(document).ready(function(){
                    initiateWaiverWindow = new LIGHT_BOX($j("#initiateWaiver"),{title:'Request for Methodology Waiver',confirmOnClose:true});
                    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#waiver-form"), projectID:${projectID?c}});
                });
				-->
            </script>
            <#assign showWaiverBtn = 'none' />
			
            <#if project.methWaiverReq?? && project.methWaiverReq==1>
                <#assign showWaiverBtn = 'block' />
            </#if>

            <ul class="right-sidebar-list">
               <#-- <li id="initiateWaiverButton" style='display:${showWaiverBtn?string}'><a onclick="javascript:openInitiateWaiverWindow();" href="javascript:void(0);"><#if pibMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>
				-->
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



<div class="region-inner">
	
    <label class='rte-editor-label'>Proposal</label>
    <div class="form-text_div">
        <textarea id="proposal" name="proposal" rows="10" cols="20" disabled class="form-text-div">${proposalInitiation.proposal?default('')?html}</textarea>
        <@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
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
	</#if>
    </div>
    <!-- ATTACHMENT DISPLAY ENDS -->
</div>

    <#assign synchroUtils = jiveContext.getSpringBean("synchroUtils") />

<script type="text/javascript">
    var attachmentWindow = null;
    $j(document).ready(function(){
        attachmentWindow = new SYNCHRO_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/new-synchro/proposal-details!addAttachment.jspa'/>",
            projectID:${projectID?c},
            endMarketID:${endMarketId?c},
            parentForm:$j("#pib-form"),
            items:[
                {id:${bussinessQuestionID?c},name:'Business Question'},
                {id:${researchObjectiveID?c},name:'Research Objective(s)'},
                {id:${actionStandardID?c},name:'Action Standard(s)'},
                {id:${researchDesignID?c},name:'Methodology Approach and Research design'},
                {id:${sampleProfileID?c},name:'Sample Profile (Research)'},
                {id:${stimulusMaterialID?c},name:'Stimulus Material'},
                {id:${otherReportingRequirementID?c},name:'Other Reporting Requirements'},
                {id:${othersID?c},name:'Other Comments'}
            ]

        });

        $j("#fileAttachBtn").bind('click',function(){
            attachmentWindow.show();
        });
    });

    function showAttachmentPopup(fieldId) {
      
		attachmentWindow.show(fieldId);
    }
</script>


<!-- END Market EU Online Process Starts--> 

<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId())>
	<#if !isProposalLegalApprover>
	 <div class="project_owner_names">
			<label>Legal Approval's Name</label>
			
			
			<select data-placeholder="Select Legal Approver" class="chosen-select" id = "proposalInitiation" name='proposalInitiation'  >
			  <option value=""></option>
				  
				   <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
				   <#assign endMarketApproversKeySet = endMarketLegalApprovers.keySet() />
				   <#list endMarketApproversKeySet as key>
						<optgroup label="${endMarkets.get(key?int)}">
						<#list endMarketLegalApprovers.get(key) as legalUser >
							<#if proposalInitiation?? && projectInitiation.proposalInitiation?? && proposalInitiation.proposalLegalApprover == legalUser.ID>
								<option value="${legalUser.ID?c}" selected>${legalUser.name}</option>
							<#else>
								<option value="${legalUser.ID?c}">${legalUser.name}</option>
							</#if>
						</#list>
						</optgroup>
				   </#list>
						
			</select>
			 
			 <span class="jive-error-message" id="briefPropsoalApproverError" style="display:none">Please Select Proposal Legal Approver</span>
			
			

	 </div>
	 
		<#if proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
			<input type="button" name=""  onclick="updateSendReminder();" value="Send Reminder" class="save need-discussion btn-blue"/>
			<span class="approval-status">TPD Status: Pending</span>
		<#elseif proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus == 1)  >
			<span class="approval-status">TPD Status: May have to be TPD Submitted</span>
		<#elseif proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus==2)  >
			<span class="approval-status">TPD Status: Does not have to be TPD Submitted</span>
		<#else>
			<input type="button" name="" onclick="updateSendForApproval();" value="Send For TPD Approval" class="save approval-btn btn-blue"/>
		</#if>
		<div class="date-approval"><label>Date of Legal Approval</label> <input type="text"  name="legalApprovalDate" id="legalApprovalDate" <#if proposalInitiation?? && proposalInitiation.legalApprovalDate??> value="${proposalInitiation.legalApprovalDate?string('dd/MM/yyyy')}" <#else>value="" </#if> disabled />
		</div>
	</#if>	
	<#if isProposalLegalApprover >
		<div class="project_status_div">
		   <label>Classify for TPD Submission </label>
		   <div class="status_right_group">
		   
		
		   <#if (proposalInitiation?? && proposalInitiation.legalApprovalDate??) || ( proposalInitiation?? && proposalInitiation.needsDiscussion?? && proposalInitiation.needsDiscussion==1 )>
			   <#if proposalInitiation?? && proposalInitiation.legalApprovalStatus??>
					
					<@renderLegalApprovalStatusFields name='legalApprovalStatusO' value="${proposalInitiation.legalApprovalStatus}"  readonly=true/>
				</#if>
			
		   
			    <input type="button" id="confirmButtonDisable" name="" value="Approved for project to proceed" onclick="confirmLegalApprovalSubmission();" class="save approval-btn btn-blue disabled"/>
				
			   <span>OR</span>
			  
				<input type="button" name="" id="needsDiscussionButtonDisable"  onclick="updateNeedDiscussion();" value="Needs Discussion" class="save btn-blue disabled"/>
				
				 <div class="buttons legalappr_btmmrgin"  id="approverContinueButton">
    
               <br>
        
			
			<!--<a href="javascript:void(0);" style="margin-left: 10px;" onclick="return resetPIB();" class="publish-details disabled">Reset Brief</a>	  -->
		
		
		
		
		
		<a href="javascript:void(0);" style="margin-left: 10px;" onclick="return validatePIBFormFields('');" class="publish-details disabled">Save</a>	
		
		
		<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" onclick="return continueProject();" class="publish-details disabled">Continue</a>
		
		 </div>
			
			
			<#else>
				<#if proposalInitiation?? && proposalInitiation.legalApprovalStatus??>
					
					<@renderLegalApprovalStatusFields name='legalApprovalStatusO' value="${proposalInitiation.legalApprovalStatus}" />
				</#if>
				<input type="button" id="confirmButtonEnable" style="display:none" name="" onclick="confirmLegalApprovalSubmission();" value="Approved for project to proceed" class="save confirm btn-yellow"/>
			   <input type="button" id="confirmButtonDisable" name="" value="Approved for project to proceed" onclick="confirmLegalApprovalSubmission();" class="save approval-btn btn-blue disabled"/>
				
			   <span>OR</span>
			   
			  
				<input type="button" name="" id="needsDiscussionButtonDisable" style="display:none" onclick="updateNeedDiscussion();" value="Needs Discussion" class="save btn-blue disabled"/>
				
				<input type="button" name="" id="needsDiscussionButtonEnable"  onclick="updateNeedDiscussion();" value="Needs Discussion" class="save need-discussion btn-blue"/>
				
				 <div class="buttons legalappr_btmmrgin"  id="approverContinueButton">
    
              <br>
        
			
		<!--	<a href="javascript:void(0);" style="margin-left: 10px;" onclick="return resetPIB();" class="publish-details disabled">Reset Brief</a>	 -->
		
		
		
		
		
		<a href="javascript:void(0);" style="margin-left: 10px;" onclick="return validatePIBFormFields('');" class="publish-details disabled">Save</a>	
		
		
		<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" onclick="return continueProject();" class="publish-details disabled">Continue</a>
		
		 </div>
				
			</#if>
		   </div>
		   </div>
		</div>
	</#if>
</#if>

<!-- END Market EU Online Process Ends--> 
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
		<div class="legal-checkbox" id="legal-checkbox"><input type="checkbox" name="vehicle" value="Bike">This project does not require legal sign-off.<br></div>
	 </#if>
	
	
	
									
</#if>



<script type="text/javascript">
    var initiateKantarWaiverWindow = null;
    $j(document).ready(function(){
        initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request for Agency Waiver',confirmOnClose:false});
        FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#kantar-waiver-form"), projectID:${projectID?c}});
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

           
            <#elseif  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            <#else>
                <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            </#if>
            </div>
            <div class="pib_view_popup">
                

                
            <#if isAdminUser>
                <input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
             

            <#elseif  isProjectCreator>
                <#if  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                    <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
                    <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton"  value="SEND FOR INFORMATION" style="font-weight: bold;cursor:default;" />
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

            <#elseif pibMethodologyWaiver.methodologyApprover?? && user.ID==pibMethodologyWaiver.methodologyApprover>
                <#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                    <textarea id="methodologyApproverComment"  disabled name="methodologyApproverComment">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
                <#else>
                    <textarea id="methodologyApproverComment" name="methodologyApproverComment" disabled placeholder="Methodology Approver Comments">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
              
                </#if>

                
            <#else>
                <textarea id="methodologyApproverComment"  disabled name="methodologyApproverComment">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
            </#if>
            </div>

            <div class="pib_view_popup">
        <#if isAdminUser>
            <input id="request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
            <input id="approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
            <input id="reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />

        <#elseif pibMethodologyWaiver.methodologyApprover?? && user.ID==pibMethodologyWaiver.methodologyApprover>

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



<div id="initiateKantarWaiver" style="display:none">
    <script type="text/javascript">
        $j(document).ready(function(){
            if($j("#initiateKantarWaiver").parent().hasClass('light-box'))
            {
                $j("#initiateKantarWaiver").parent().prepend($j("#success-msg-waiver-kantar"));
            }
        });
    </script>
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
                <textarea id="methodologyDeviationRationaleKantar" name="methodologyDeviationRationale" placeholder="Methodology Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>

            <#elseif !(isProjectCreator) >
                <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            <#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            <#else>
                <textarea id="methodologyDeviationRationaleKantar" name="methodologyDeviationRationale" placeholder="Methodology Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            </#if>
            </div>
			
			
			<div class="pib_view_popup ">
			<div class="waiver-summary">
						
			<a href='${JiveGlobals.getJiveProperty("synchro.agency.waiver.template.path"," /file/download/AgencyCostDetails-SingleMarketTemplate.xlsx")}'>Download Agency Waiver Summary Template</a>
			
			<p>Waiver Summary</p> 
			
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

            <#elseif  pibKantarMethodologyWaiver.methodologyApprover?? && user.ID==pibKantarMethodologyWaiver.methodologyApprover>
                <#if pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                    <textarea id="methodologyApproverCommentKantar"  disabled name="methodologyApproverComment">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
                <#else>
                    <textarea id="methodologyApproverCommentKantar" name="methodologyApproverComment" placeholder="Agency Approver's Comments">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
                <#--<div class="character-limit" >You have <input readonly type="text" id="methodologyApproverCommentcountdown" name="countdown" size="3" value="2500" style="margin-top:7px;"> characters left</div>-->
                </#if>

                
            <#else>
                <textarea id="methodologyApproverCommentKantar"  disabled name="methodologyApproverComment">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
            </#if>
            </div>
		
		<div class="pib_view_popup ">
            
        <#if isAdminUser>
            <input id="kantar-request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
            <input id="kantar-approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
            <input id="kantar-reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />

        <#elseif pibKantarMethodologyWaiver.methodologyApprover?? && user.ID==pibKantarMethodologyWaiver.methodologyApprover>

            <#if pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                <input type="button" class="g-btn r-more" name="doPost" id="postButton"  value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
            <#else>
                <input id="kantar-request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
            </#if>
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
        <form id="synchro-pit-form" action="<@s.url value='/new-synchro/pib-details!updatePIT.jspa'/>" method="post" class="j-form-popup">
		 <a href="javascript:void(0);" class="close" onclick="closePITWindow();"></a>
		  <div class="popup-title-overlay"></div>
		  <div class="pop-upinner-scroll">
		  <div class="pop-upinner-content">
            <h3>Project Details Overview</h3>
			
            <div class="pib_view_popup region-inner">
                <label>Project Name </label>
<input type="text" id="projectName" name="projectName" disabled value="${project.name?html}" class="pit_window_field_width"/>
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
			  
					<select data-placeholder="" disabled class="chosen-select" id = "categoryType" name="categoryType" multiple >
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
				
					<span class="jive-error-message" id="categoryTypeError" style="display:none">Please enter CategoryType</span>
					
				
				</div>
			</div>
			
			<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId()) >
			<#else>
				<div class="region-inner">
					
					<div class="form-select_div">
						<#--<label><@s.text name="project.initiate.project.brand"/></label>-->
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
					</select>
					<span class="jive-error-message" id="endMarketError" style="display:none"><@s.text name='project.error.endmarket' /></span>
				
				</div>
			</div>
			
			
			<#if project?? && project.globalOutcomeEUShare?? && (project.globalOutcomeEUShare==1 || project.globalOutcomeEUShare==2 ) >
				<div class="region-inner">
					<div class="form-select_div">
						
					<label>Will the outcome be shared with the respective EU market?</label>
					
					<@globalOutcomeEUShare name='globalOutcomeEUShare' value=project.globalOutcomeEUShare?default(-1) readonly=true/>
					<span class="jive-error-message" id="globalOutcomeEUShareError" style="display:none">Will the outcome be shared with the respective EU market?</span>
					</div>
				</div>
			</#if>
			
			<div class="region-inner">
					
				<div class="form-select_div start_date">
					<label>Project Start Date</label>
			   
				
				<input type="text" name="startDate" id="startDate" value="" disabled/>
				<#assign error_msg><@s.text name='project.error.startdate' /></#assign>
				<@macroCustomFieldErrors msg=error_msg />
				<@macroFieldErrors name="startDate"/>
				</div>
			</div>	
			<div class="region-inner">
				<div class="form-select_div form-select_div_project_completion">
					<label>Project End Date</label>
					 
				
				<input type="text" name="endDate" id="endDate" value="" disabled/>
				<#assign error_msg><@s.text name='project.error.enddate' /></#assign>
				<@macroCustomFieldErrors msg=error_msg />
				<@macroFieldErrors name="endDate"/>
				</div>
			</div>
			
			<div class="region-inner">
				
				
				<div class="form-select_div">
					<#--<label><@s.text name="project.initiate.project.owner"/></label>-->
					<label>Project Manager</label>
					<div>
					
					   
					<input type="text"  name="projectManagerName" value="${project.projectManagerName}" id="projectManagerName" disabled  />

					<#assign error_msg><@s.text name="project.error.owner"/></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
				</div>

				<!-- Project SP&I Contact -->
		
				<div class="form-select_div form-select_div_project_completion">
					
					<label>Project Initiator</label>
					<div>
						<input type="text"  name="projectInitiator" value="${user.name}" id="projectInitiator"  disabled />
					
					<#assign error_msg><@s.text name="project.error.spi"/></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
				</div>

			</div>
			
			<div class="region-inner">
					
					<label class="label_b">Methodology</label>
					<div class="col-lg-6">
				  
						
						<#if isAdminUser>
							<select data-placeholder="" class="chosen-select" id = "methodologyDetails" name = "methodologyDetails" multiple disabled >
						<#else>
							<select data-placeholder="" class="chosen-select" id = "methodologyDetails" name = "methodologyDetails" disabled >
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
														<option lessFrequent="yes" value="${methkey?c}" <#if project.methodologyDetails?seq_contains(methkey)> selected</#if>>${methodologies.get(methkey)}</option>
													<#else>
														<option lessFrequent="no" value="${methkey?c}" <#if project.methodologyDetails?seq_contains(methkey)> selected</#if>>${methodologies.get(methkey)}</option>
													</#if>
												 </#list>
											</optgroup>	 
										</#list>
									</#if>
						</select>
						<span class="jive-error-message" id="endMarketError" style="display:none"><@s.text name='project.error.endmarket' /></span>
					
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
					
					<#--<@renderMethodologyWaiverField name='methWaiverReq' value=project.methWaiverReq?default('-1') readonly=true/>-->
					
					<select data-placeholder="Select" class="chosen-select" id = "methWaiverReq" name="methWaiverReq"  disabled onchange="checkMethDeviation()">
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
						<#--<li id="initiateWaiverButtonPIT" style='display:${showWaiverBtn?string}'><a onclick="javascript:openInitiateWaiverWindow();" href="javascript:void(0);"><#if pibMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>-->
						
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
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
					<div id="waiverMessage" style="display:none">You will be able to initiate waiver through the system once the project is created</div>
				</div>
				
				<div class="region-inner">
					
					<div class="form-select_div">
						<label>Is this a brand specific study?</label>
					
					<@renderBrandSpecificStudy name='brandSpecificStudy' value=project.brandSpecificStudy?default('-1') readonly=true/>
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					
					<div id="brandSpecific" style="display:none">
					
					<div class="form-select_div">
						
					
					<@renderBrandFieldNew name='brand' value=project.brand?default('-1') readonly=true/>
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
					
					</div>
					<div id="brandSpecificStudyType">
					
					
										
					<@renderBrandSpecificStudyType name='brandSpecificStudyType' value=project.brandSpecificStudyType?default('-1') readonly=true/>
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
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
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
				</div>

				<div class="region-inner">
				<@projectBudgetYearFieldNew name="budgetYear" value=project.budgetYear readonly=true/>
					<@macroCustomFieldErrors msg="Please enter Budget Year" />
					<span class="jive-error-message" id="budgetYearError" style="display:none">Please enter Budget Year</span>
				</div>
				
				<div id="expenseDetailsContainer" class="region-inner">
				<label>Cost Details</label>
					<div class="border-box pit_window_field_width border-inputradius">
					
					<#assign projectCostCounter = 0 />
					<#list projectCostDetailsList as projectCostDetail>
					
					<#assign projectCostCounter =  projectCostCounter + 1/>
					<div class="expense_row expense_row_readonly">
					
					<#if projectCostCounter gt 1 >
						<#--<input type="button" value="duplicate" class="duplicate"/>
						 <input type="button" value="Remove" class="remove" />-->
					</#if>
					<div class="region-inner">
						
						
					
					<div id="agencyMain">
				  
						<select data-placeholder=" " disabled class="chosen-select  appended-agency" id = "agency" name='agency' >
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
						<span class="jive-error-message" id="endMarketError" style="display:none"><@s.text name='project.error.endmarket' /></span>
					
					</div>
					</div>
					
					<div class="region-inner">
						<@renderCostComponent name="costComponent" value="${projectCostDetail.getCostComponent()?default('-1')}" readonly=true/>
					</div>
					<div class="region-inner">
			
						<@renderCurrenciesFieldNew name='currency' value="${projectCostDetail.getCostCurrency()?default(-1)}" disabled=true/>
					</div>

					
					<div class="region-inner">
						<!-- Project Initial Cost Field -->
						<div class="form-select_div">
							<div class="pit-estimate-cost">
								<!-- <label><@s.text name="project.initiate.project.cost"/></label> -->

							<input type="text"  id="enter_cost" name="agencyCost"  Placeholder="Enter Cost" class="text_field numericfield longField" value="${projectCostDetail.getEstimatedCost()}" disabled />
							<#assign error_msg><@s.text name="project.error.cost"/></#assign>
							<@macroCustomFieldErrors msg=error_msg class="numeric-error"/>
							</div>
							
						</div>

					</div>
					</div>
					
					</#list>
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
					<div class="project_waiver_rqst region-inner statusPending">
					<label>Agency Waiver Request</label>
					<ul class="right-sidebar-list">

						<#--<li id="initiateKantarWaiverButtonPIT" ><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>-->
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
				
			<div class="region-inner">
					<label class="pit-description-label">Brief</label>
				   
					  
					<div class="form-text_div">
						<textarea id="brief" name="brief" disabled rows="10" cols="20" class="form-text-div">${projectInitiation.brief?default('')?html}</textarea>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
					</div>
					<textarea style="display:none;" id="briefText" name="briefText">${projectInitiation.briefText?default('')?html}</textarea>
					 <!-- ATTACHMENT DISPLAY STARTS -->
						<div class="field-attachments">
					   <#if projectInitiation?? && projectInitiation.sendForApproval?? && projectInitiation.sendForApproval==1 >
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
												<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
												</#if>
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
				
				
				
				<div class="form-select_div form-select_div_project_completion region-inner statusPending">
					
					<label>Legal Approval's Name</label>
					<div>
						<#if projectInitiation?? && projectInitiation.briefLegalApprover??>
							<#assign legalApproverName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(projectInitiation.briefLegalApprover) />
						<#else>
							<#assign legalApproverName = '' />
						</#if>
						<input type="text"  name="legalApproverName" value="${legalApproverName}" id="legalApproverName"  disabled />
					<@macroCustomFieldErrors msg=error_msg />
					</div>
					<#if projectInitiation?? && projectInitiation.sendForApproval?? && projectInitiation.sendForApproval==1 >
					<span class="approval-status">TPD Status: <span class="status-txt">Pending</span></span>
				<#elseif projectInitiation?? && projectInitiation.legalApprovalStatus?? && (projectInitiation.legalApprovalStatus == 1)  >
					<span class="approval-status">TPD Status: <span class="status-txt">May have to be TPD Submitted</span></span>
				<#elseif projectInitiation?? && projectInitiation.legalApprovalStatus?? && (projectInitiation.legalApprovalStatus==2)  >
					<span class="approval-status">TPD Status: <span class="status-txt">Does not have to be TPD Submitted</span></span>
				</#if>
				</div>
            </div>
			</div>
			</div>
        </form>
    </div>
</div>


</div>


</div>

<script>

function enableConfirmButton()
{

	if($j('#legalApprovalStatusO').val()=="")
	{
		$j("#confirmButtonDisable").show();
		$j("#confirmButtonEnable").hide();
		$j("#needsDiscussionButtonDisable").hide();
		$j("#needsDiscussionButtonEnable").show();
	}
	else
	{
		$j("#confirmButtonDisable").hide();
		$j("#confirmButtonEnable").show();
		$j("#needsDiscussionButtonDisable").show();
		$j("#needsDiscussionButtonEnable").hide();
	}
	/*
	if($j("#briefLegalApprover").val()!=1)
    {
        $j("#confirmButtonDisable").hide();
		$j("#confirmButtonEnable").show();
		$j("#needsDiscussionButtonDisable").show();
		$j("#needsDiscussionButtonEnable").hide();
		
    }*/
}
</script>