


<form name="project-specs" action="/new-synchro/project-specs!execute.jspa" method="POST"  id="project-specs-form" class="research_pib pib" >
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

				<li id="initiateKantarWaiverButton" ><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status!=-1>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>
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
		
    
		
		<select data-placeholder="Select" class="chosen-select" id = "deviationFromSM" name="deviationFromSM" disabled  onchange="checkMethDeviation()">
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
                    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#project-specs-form"),form:$j("#waiver-form"), projectID:${projectID?c}});
                });
				-->
            </script>
            <#assign showWaiverBtn = 'none' />
			
            <#if project.methWaiverReq?? && project.methWaiverReq==1>
                <#assign showWaiverBtn = 'block' />
            </#if>

            <ul class="right-sidebar-list">
                <li id="initiateWaiverButton" style='display:${showWaiverBtn?string}'><a onclick="javascript:openInitiateWaiverWindow();" href="javascript:void(0);"><#if pibMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>
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
	
    <label class='rte-editor-label'>Documentation (if any) </label>
    <div class="form-text_div">
        <textarea id="documentation" name="documentation" disabled placeholder="Add notes, if any" rows="10" cols="20" class="form-text-div">${projectSpecsInitiation.documentation?default('')?html}</textarea>
		<i>(e.g. Screener, Questionnaire/Discussion guide etc.)</i>
        <@macroCustomFieldErrors msg="Please enter the Project Documentation" class='textarea-error-message'/>
    </div>
    <textarea style="display:none;" id="documentationText" name="documentationText">${projectSpecsInitiation.documentationText?default('')?html}</textarea>
	 <!-- ATTACHMENT DISPLAY STARTS -->
   <div class="field-attachments">
   
		
			<#if attachmentMap?? && attachmentMap.get(documentationID)?? >
				<div id="jive-file-list" class="jive-attachments">
					<#list attachmentMap.get(documentationID) as attachment>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
						
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
						</div>
					</#list>
				</div>
			</#if>
	
    </div>
    <!-- ATTACHMENT DISPLAY ENDS -->
</div>

    <#assign synchroUtils = jiveContext.getSpringBean("synchroUtils") />

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

        FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#project-specs-form"),form:$j("#kantar-waiver-form"), projectID:${projectID?c}});
    });

</script>


 <div class="right">
	 <a href="javascript:void(0);" style="margin-left: 10px;" onclick="return validatePIBFormFields('');" class="publish-details disabled">Save</a>	
		
		
		<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" onclick="return continueProject();" class="publish-details disabled">Project Completed</a>
	 </div>

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
  
   
		
        <form id="waiver-form" action="<@s.url value='/new-synchro/project-specs!updateWaiver.jspa'/>" method="post" class="j-form-popup">
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



<div id="initiateKantarWaiver" class="j-form-popup"  style="display:none">
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

  

        <form id="kantar-waiver-form" action="<@s.url value='/new-synchro/project-specs!updateKantarWaiver.jspa'/>" method="post">
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
			<#-- <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${agencyWaiverID?c})" ></span> -->
			
			<#if isAdminUser || isSynchroSystemOwner>
               <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${agencyWaiverID?c})" ></span>
        
            <#elseif canEditStage>
                <#if  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                   
				
				<#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
                     <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${agencyWaiverID?c})" ></span>
				
				<#elseif  pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status==0>
                   		
					
                <#else>
                   <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${agencyWaiverID?c})" ></span>
              
                </#if>

            <#else>
               
              
            </#if>
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
	
        <form id="synchro-pit-form" action="<@s.url value='/new-synchro/project-specs!updatePIT.jspa'/>" method="post" class="j-form-popup">
		 <a href="javascript:void(0);" class="close" onclick="closePITWindow();"></a>
		  <div class="popup-title-overlay"></div>
		  <div class="pop-upinner-scroll">
		    <div class="pop-upinner-content">
			<div class="confirm-msg"><i>Please confirm all the project details as you will not be able to edit any information after the project is completed.</i></div>
            <div id="overViewDiv">
			<h3>Project Details Overview</h3>
			</div>
			
            <div class="pib_view_popup region-inner">
                <label>Project Name </label>
            <#if isAdminUser>
				<input type="text" id="projectName" name="projectName" value="${project.name?html}" class="pit_window_field_width"/>
			<#else>
				<input type="text" id="projectName" name="projectName" disabled value="${project.name?html}" class="pit_window_field_width" />
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
				
					<span class="jive-error-message" id="categoryTypeError" style="display:none">Please select Category Type</span>
					
				
				</div>
			</div>
			
			<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId()) >
			<#else>
				<div class="region-inner">
					
					<div class="form-select_div">
						
						<label>Is the project a fieldwork component of an above market study?</label>
					
					<@fieldworkstudyField name='fieldWorkStudy' value=project.fieldWorkStudy?default('-1') readonly=true />
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
				
						<select data-placeholder="" class="chosen-select" id = "endMarkets" name='endMarkets' multiple disabled >
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
						<select data-placeholder="" class="chosen-select" id = "endMarkets" disabled name='endMarkets' >
					
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
					
					   
					<input type="text"  name="projectManagerName" disabled  value="${project.projectManagerName}" id="projectManagerName"  />

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
							<select data-placeholder="" class="chosen-select" id = "methodologyDetails" disabled name = "methodologyDetails" >
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
						<label> Methodology Type</label>
				
					<@renderMethodologyField name='methodologyType' value=project.methodologyType?default('-1') readonly=true/>
					<@macroCustomFieldErrors msg="Please select Methodology Type" />
					
					</div>
					
				</div>
				
				<div class="region-inner">
					
					<div class="form-select_div">
						<label>Will a methodology waiver be required?</label>
					
					<#--<@renderMethodologyWaiverField name='methWaiverReq' value=project.methWaiverReq?default('-1') />-->
					
					<select data-placeholder="Select" class="chosen-select" id = "methWaiverReq" name="methWaiverReq" disabled   onchange="checkMethDeviation()">
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
						<li id="initiateWaiverButtonPIT" style='display:${showWaiverBtn?string}'><a onclick="javascript:openInitiateWaiverWindow();" href="javascript:void(0);"><#if pibMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>
					</ul>
					
					 <#if project.methWaiverReq?? && project.methWaiverReq==1 && pibMethodologyWaiver?? && pibMethodologyWaiver.projectID?? >
						<div class="waiver_methodology">
							
							<#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
								<span>Status: <sapn class="status-txt approvedStatus">Approved</span></span>
							<#elseif pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==2>
								<span>Status: <sapn class="status-txt rejectedStatus">Rejected</span></span>
							<#else>
								<span>Status: <sapn class="status-txt pendingStatus">Pending</span></span>
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
									
									<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
									<#assign endMarketsKeySet = endMarkets.keySet() />
									
									<#list endMarketsKeySet as key>
										<option  value="${key}" <#if project.budgetLocation==key> selected </#if>>${endMarkets.get(key?int)}</option>
									</#list>
								</#if>
								
								
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
							<@renderCostComponent name="costComponents" value="" id='costComponent' readonly=true />
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

								<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" disabled Placeholder="Enter Cost" class="text_field longField total-expense" value="" />
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
										<input type="text" placeholder="0" name="prefCost" id="prefCost" class="longField" value="${statics['com.grail.synchro.util.SynchroUtils'].getPreferredCurrenyTotalCost(project,user)?round}" disabled />
									<#else>
										<input type="text" placeholder="0" name="prefCost" id="prefCost" class="longField" value="" disabled />
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

						<li id="initiateKantarWaiverButtonPIT" ><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status!=-1>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>
					</ul>
					
					<div  class="agency_methodology" id="nonKantarWaiverStatus" <#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>style="display:block;" <#else> style="display:none;"</#if>>

						<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
							<span>Status: <span class="status-txt approvedStatus">Approved</span></span>
						<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
							<span>Status: <span class="status-txt rejectedStatus">Rejected</span></span>
						<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID?? >
							<span>Status: <span class="status-txt pendingStatus">Pending</span></span>
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
							<@renderEndMarketFundingField name='endMarketFunding' value=project.endMarketFunding?default('-1') readonly=true />
					<#else>
							<@renderEndMarketFundingField name='endMarketFunding' value=-1 readonly=true/>
					</#if>
				
				</div>
				
				<div class="form-select_div second-column" id="fundingMarketsDiv" <#if project.endMarketFunding?? && project.endMarketFunding==1> style="display:block" <#else>style="display:none"</#if>>
					<label>Select the end market which will carry out the fieldwork</label>
				
					<#if project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId()>
						<select data-placeholder="Select end-market" class="chosen-select" id = "fundingMarkets" name="fundingMarkets" multiple disabled >
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
					
						<select data-placeholder="Select end-market" class="chosen-select" id = "fundingMarkets" name="fundingMarkets" disabled >
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
						<span class="approval-status popTpd">TPD Status: <span class="status-txt">Does not have to be Submitted</span></span>
					</#if>
				</#if>
				
				<#if project.processType?? && project.processType !=  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId()>
				
					<!--<div class="form-select_div form-select_div_project_completion region-inner">
						
						<label>Legal Approver's Name</label>
						<div>
							<#if projectInitiation?? && projectInitiation.briefLegalApprover??>
								<#assign legalApproverName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(projectInitiation.briefLegalApprover) />
							<#else>
								<#assign legalApproverName = '' />
							</#if>
							<input type="text"  name="legalApproverName" value="${legalApproverName}" id="legalApproverName"  disabled />
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
				</div>  -->
				<div class="form-select_div form-select_div_project_completion region-inner">
					
					<label>Legal Approver's Name</label>
					<div class="legalAppAttach">
					   <#if projectInitiation.getBriefLegalApproverOffline()??>
								<input type="text"  id="legalApproverName" placeholder="Select Legal Approver" name="briefLegalApproverOffline"  value="${projectInitiation.getBriefLegalApproverOffline()}"  disabled/>
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
								<input type="text" id="legalApproverName" placeholder="Select Legal Approver" name="briefLegalApproverOffline"  value=""  />
								
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
					
				</#if>	
				</#if>	
				
				<#if methBriefException == "yes">
					<#if projectInitiation?? && projectInitiation.legalSignOffRequired?? && projectInitiation.legalSignOffRequired==1>
						<div id="legal-checkbox" class="region-inner"><input type="checkbox" name="legalsignoffreqdisable" disabled id="legalsignoffreqdisable" <#if projectInitiation?? && projectInitiation.legalSignOffRequired?? && projectInitiation.legalSignOffRequired==1> checked="true"</#if> >This project does not require legal sign-off on Brief.<br></div>
					</#if>
				</#if>
				
				
				
				<div class="region-inner">
					<label class="pit-description-label">Proposal</label>
				   
					  
					<div class="form-text_div">
						<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
						<textarea id="proposal" name="proposal" disabled rows="10" cols="20" class="form-text-div">${proposalInitiation.proposal?default('')?html}</textarea>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
						<#else>
							<textarea id="proposal" name="proposal" rows="10" cols="20" disabled class="form-text-div">${proposalInitiation.proposal?default('')?html}</textarea>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
						</#if>
					</div>
					<textarea style="display:none;" id="proposalText" name="proposalText">${proposalInitiation.proposalText?default('')?html}</textarea>
					 <!-- ATTACHMENT DISPLAY STARTS -->
						<div class="field-attachments">
					   
					   <#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
							
							
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
					   
					   <#elseif proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
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
						<#elseif proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus gt 0)  >
	
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
				
				<#if proposalInitiation?? && proposalInitiation.legalSignOffRequired?? && proposalInitiation.legalSignOffRequired==1> 
				<#else>
				
					<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId())>
					
						<#if proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
							<span class="approval-status popTpd">TPD Status: <span class="status-txt">Pending</span></span>
						<#elseif proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus == 1)  >
							<span class="approval-status popTpd">TPD Status: <span class="status-txt">May have to be TPD Submitted</span></span>
						<#elseif proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus==2)  >
							<span class="approval-status popTpd">TPD Status: <span class="status-txt">Does not have to be Submitted</span></span>
						</#if>
					</#if>
					
					<#if project.processType?? && project.processType !=  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId()>
					<!--	<div class="form-select_div form-select_div_project_completion region-inner">
							
							<label>Legal Approver's Name</label>
							<div>
								<#if proposalInitiation?? && proposalInitiation.proposalLegalApprover??>
									<#assign legalApproverName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(proposalInitiation.proposalLegalApprover) />
								<#else>
									<#assign legalApproverName = '' />
								</#if>
								<input type="text"  name="legalApproverName" value="${legalApproverName}" id="legalApproverName"  disabled />
								
								<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
									<sub>Attach Approval E-mail</sub>
									<#if attachmentMap?? && attachmentMap.get(proposalLegalApprovalID)?? >
										<div id="jive-file-list" class="attachmentsNew jive-attachments">
											<#list attachmentMap.get(proposalLegalApprovalID) as attachment>
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
						</div>-->
						
						<div class="form-select_div form-select_div_project_completion region-inner">
					
					<label>Legal Approver's Name</label>
					<div class="legalAppAttach">
					   <#if proposalInitiation.getProposalLegalApproverOffline()??>
								<input type="text"  id="legalApproverName" placeholder="Select Legal Approver" name="briefLegalApproverOffline"  value="${proposalInitiation.getProposalLegalApproverOffline()}"  disabled/>
							<#else>
							    <!-- Amit Change   for Online process  drop down appear-->
							    <#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId())>
								
								
								   
								<select data-placeholder="Select Legal Approver"  disabled class="chosen-select" id = "briefLegalApprover" name='briefLegalApprover'><span class="jive-error-message full-width" id="legalApproverError" style="display:none">Please select Legal Approver's Name</span>
							
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
								
								 <#else>
								<input type="text" id="legalApproverName" placeholder="Select Legal Approver" name="briefLegalApproverOffline"  value=""  />
								
								 </#if>
								
							</#if>	
						
						<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
							<sub>Attach Approval E-mail</sub>
							<#if attachmentMap?? && attachmentMap.get(proposalLegalApprovalID)?? >
								<div id="jive-file-list" class="attachmentsNew jive-attachments">
									<#list attachmentMap.get(proposalLegalApprovalID) as attachment>
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
				</div>
						
						
						<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
					
						 <div class="region-inner">
							<div class="form-select_div">
								<label>TPD Status</label>
								<#if proposalInitiation?? && proposalInitiation.legalApprovalStatus?? >
									<@renderLegalApprovalStatusFields name='legalApprovalStatusPit' value="${proposalInitiation.legalApprovalStatus}" readonly=true/>
								<#else>
									<@renderLegalApprovalStatusFields name='legalApprovalStatusPit' value="-1" readonly=true/>
								</#if>
							</div>
						</div>
						
						
						<div class="form-select_div form-select_div_project_completion region-inner">
						
							<label>Date of Legal Approval</label>
							<div>
								<#if proposalInitiation?? && proposalInitiation.legalApprovalDate??>
								<input type="text"  name="legalApproverDatePit" value="${proposalInitiation.legalApprovalDate?string('dd/MM/yyyy')}" id="legalApproverDatePit"  disabled />
								<#else>
									<input type="text"  name="legalApproverDatePit" value="" id="legalApproverDatePit"  disabled />
								</#if>
								
								
							</div>
						</div>
						
					</#if>
				</#if>	
				</#if>	
				<#if methBriefException == "yes">
		
					<#if proposalInitiation?? && proposalInitiation.legalSignOffRequired?? && proposalInitiation.legalSignOffRequired==1> 
						<div id="legal-checkbox" class="region-inner"><input type="checkbox" name="legalsignoffreqdisable" disabled id="legalsignoffreqdisable" <#if proposalInitiation?? && proposalInitiation.legalSignOffRequired?? && proposalInitiation.legalSignOffRequired==1> checked="true"</#if> >This project does not require legal sign-off on Proposal.<br></div>
					</#if>
				</#if>
				
				
           </div> 
           </div>
		    </div>
        </form>
    </div>
</div>


</div>


</div>


<form method="POST" name="cancelProj" id="cancelProj" action="/new-synchro/project-specs!cancelProject.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
</form>

<form method="POST" name="enableProj" id="enableProj" action="/new-synchro/project-specs!enableProject.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
</form>
</div>
  <script type="text/javascript">
     $j(document).ready(function() {
       // $j('.chosen-select').chosen();
       // $j('.chosen-select-deselect').chosen({ allow_single_deselect: true });
	   $j('.chosen-select').chosen({ allow_single_deselect: true });
		$j('#confirmProjectEnable').click(function(){
			$j('.confirm-msg').show();
			$j('#overViewDiv').hide();
			
		});
      });
	  
	  </script>
<script type="text/javascript">
var selectedCategoryList = {};
var selectedProposedMethList = {};
$j(document).ready(function() {
    handleUserPickers();
 

    /*Load start and end dates*/
    var _startDate = "${project.startDate?string('dd/MM/yyyy')}";
    var _endDate = "${project.endDate?string('dd/MM/yyyy')}";
    $j("#startDate").val(_startDate);
    $j("#endDate").val(_endDate);
	$j("#startDate1").val(_startDate);
    $j("#endDate1").val(_endDate);


<#if !(project.methWaiverReq?? && project.methWaiverReq==1) >
    $j("#initiateWaiverButton").hide();
</#if>

<#if project.proposedMethodology?? && project.proposedMethodology[0]??>
    $j("#proposedMethodology").val("${project.proposedMethodology[0]}");
</#if>

<#if project.brand??>
    $j("#brand").val("${project.brand}");
</#if>

    /*Mandatory Field Validations Starts */
<#if showMandatoryFieldsError?? && showMandatoryFieldsError>
    pibFormErrors();
</#if>

if(window.location.href.indexOf("legalApprover") > -1) 
{
	$j("#legalApprover").focus();
}


    function pibFormErrors() {
        var error = false;
        var businessDescription = $j("textarea[name=bizQuestion]");
        var researchObjective = $j("textarea[name=researchObjective]");
        var actionStandard = $j("textarea[name=actionStandard]");
        var researchDesign = $j("textarea[name=researchDesign]");
        var sampleProfile = $j("textarea[name=sampleProfile]");
        var stimulusMaterial = $j("textarea[name=stimulusMaterial]");
        var latestEstimate = $j("input[name=latestEstimate-display]");
        var latestEstimateType = $j("#latestEstimateType");
        var globalLegalContact = $j("input[name=globalLegalContact]");

       

        if(businessDescription.val() != null && $j.trim(businessDescription.val())=="")
        {
          
        <#if attachmentMap?? && attachmentMap.get(bussinessQuestionID)?? >
        <#else>
            businessDescription.next().show();
            error = true;
        </#if>
        }



        if(latestEstimate.val() != null && $j.trim(latestEstimate.val())=="")
        {
         
            latestEstimate.parent().find("span:first").show();
            error = true;
        }


        if(researchObjective.val() != null && $j.trim(researchObjective.val())=="")
        {
         
        <#if attachmentMap?? && attachmentMap.get(researchObjectiveID)?? >
        <#else>
            researchObjective.next().show();
            error = true;
        </#if>
        }
        if(actionStandard.val() != null && $j.trim(actionStandard.val())=="")
        {
         
        <#if attachmentMap?? && attachmentMap.get(actionStandardID)?? >
        <#else>
            actionStandard.next().show();
            error = true;
        </#if>
        }
        if(researchDesign.val() != null && $j.trim(researchDesign.val())=="")
        {
          
        <#if attachmentMap?? && attachmentMap.get(researchDesignID)?? >
        <#else>
            researchDesign.next().show();
            error = true;
        </#if>
        }
        if(sampleProfile.val() != null && $j.trim(sampleProfile.val())=="")
        {
          
        <#if attachmentMap?? && attachmentMap.get(sampleProfileID)?? >
        <#else>
            sampleProfile.next().show();
            error = true;
        </#if>
        }
        if(stimulusMaterial.val() != null && $j.trim(stimulusMaterial.val())=="")
        {
           
        <#if attachmentMap?? && attachmentMap.get(stimulusMaterialID)?? >
        <#else>
            stimulusMaterial.next().show();
            error = true;
        </#if>
        }
        var reportRequirementSelected = false;
        $j(".pib-report-requirement").find('input[type="checkbox"]:checked').each(function(){
            reportRequirementSelected = true;
        });

        if(!reportRequirementSelected)
        {
           
            $j(".pib-report-requirement").find("span").show();
            error = true;
        }

        var stimuliDate = $j("input[name=stimuliDate]");
        if($j.trim(stimuliDate.val())=="")
        {
          
            stimuliDate.parent().find("span").show();
            stimuliDate.parent().find("span").text("Please enter Stimuli Date");
            error = true;
        }
        if(globalLegalContact.val() != null && $j.trim(globalLegalContact.val())=="")
        {

            globalLegalContactError.show();
            error = true;

        }

     

        $j(".textarea-error-message").each(function(){
            if($j(this).css('display') != 'none') {
                console.log($j(this).parent())
                $j(this).parent().parent().find(".field-attachments").addClass('required');
            } else {
                $j(this).parent().parent().find(".field-attachments").removeClass('required');
            }
        });

    <#if projectInitiation.nonKantar?? && projectInitiation.nonKantar==0>
        nonKantarError.show();
        error = true;
    </#if>
        return error;
    }

    $j("#send-for-approval").click(function() {
        
		//var methodologyDeviationRationale = $j("#methodologyDeviationRationale").val(); 
		var methodologyDeviationRationale = $j("#methodologyDeviationRationale_ifr").contents().find("p").text();
		if(methodologyDeviationRationale.trim()=="")
		{
			$j("#methDeviationError").show();
			return false;
		}
		showLoader('Please wait...');
        var form = $j("#waiver-form");
        form.submit();
    });

    $j("#send-for-information").click(function() {
        showLoader('Please wait...');
        setMethodologyWaiverSendforInfo();
        var form = $j("#waiver-form");
        form.submit();
    });

    $j("#request-for-information").click(function() {
	 var methodologyApproverComment = $j("#methodologyApproverComment").val(); 
		if(methodologyApproverComment=="")
		{
			$j("#methWaiverError").show();
			return false;
		}
        showLoader('Please wait...');
        setMethodologyWaiverReqMoreInfo();
        var form = $j("#waiver-form");
        form.submit();
    });
    $j("#approve-waiver-btn").click(function() {
	 var methodologyApproverComment = $j("#methodologyApproverComment").val(); 
		if(methodologyApproverComment=="")
		{
			$j("#methWaiverError").show();
			return false;
		}
        showLoader('Please wait...');
        setMethodologyWaiverApprove();
        var form = $j("#waiver-form");
        form.submit();
    });
    $j("#reject-waiver-btn").click(function() {
	 var methodologyApproverComment = $j("#methodologyApproverComment").val(); 
		if(methodologyApproverComment=="")
		{
			$j("#methWaiverError").show();
			return false;
		}
        showLoader('Please wait...');
        setMethodologyWaiverReject();
        var form = $j("#waiver-form");
        form.submit();
    });

    $j("#kantar-send-for-approval").click(function() {
       // var methodologyDeviationRationaleKantar = $j("#methodologyDeviationRationaleKantar").val(); 
	   var methodologyDeviationRationaleKantar = $j("#methodologyDeviationRationaleKantar_ifr").contents().find("p").text();
		if(methodologyDeviationRationaleKantar.trim()=="")
		{
			$j("#agencyDeviationError").show();
			return false;
		}
		
		showLoader('Please wait...');
        var form = $j("#kantar-waiver-form");
        form.submit();
    });

    $j("#kantar-send-for-information").click(function() {
        showLoader('Please wait...');
        setKantarMethodologyWaiverSendforInfo();
        var form = $j("#kantar-waiver-form");
        form.submit();
    });

    $j("#kantar-request-for-information").click(function() {
	var methodologyApproverCommentKantar = $j("#methodologyApproverCommentKantar").val(); 
		if(methodologyApproverCommentKantar=="")
		{
			$j("#methKantarWaiverError").show();
			return false;
		}
        showLoader('Please wait...');
        setKantarMethodologyWaiverReqMoreInfo();
        var form = $j("#kantar-waiver-form");
        form.submit();
    });
    $j("#kantar-approve-waiver-btn").click(function() {
	var methodologyApproverCommentKantar = $j("#methodologyApproverCommentKantar").val(); 
		if(methodologyApproverCommentKantar=="")
		{
			$j("#methKantarWaiverError").show();
			return false;
		}
        showLoader('Please wait...');
        setKantarMethodologyWaiverApprove();
        var form = $j("#kantar-waiver-form");
        form.submit();
    });
    $j("#kantar-reject-waiver-btn").click(function() {
	var methodologyApproverCommentKantar = $j("#methodologyApproverCommentKantar").val(); 
		if(methodologyApproverCommentKantar=="")
		{
			$j("#methKantarWaiverError").show();
			return false;
		}
        showLoader('Please wait...');
        setKantarMethodologyWaiverReject();
        var form = $j("#kantar-waiver-form");
        form.submit();
    });

    <#--$j("#descriptionpit-div").html($j("#description").text());-->

});

function handleUserPickers() {
    var projectOwner = -1;
    var isReference = false;
<#assign isReference = false />
<#if project?? && project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
    projectOwner = ${project.projectOwner?c};
<#else>
    <#assign isReference = true />
    projectOwner = -1;
</#if>
  <#--  initializeUserPicker({$input:$j("#projectOwner"),name:'projectOwner',value:projectOwner,defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});-->
  
  
  initializeUserPicker({$input:$j("#projectOwner"),name:'projectOwner',defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});
 <#--  initializeUserPicker({$input:$j("#briefLegalApprover"),name:'briefLegalApprover',defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});-->



<#if isReference && project.projectOwner??>
    $j('input[name=projectOwner]').val("${project.projectOwner?c}");
    <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner) />
    $j("#projectOwner").val("${userDisplayName}");
    <#assign isReference = false />
</#if>

  

}

/*Code to track read status of the document for current user and project */
<#assign effectiveUser = statics['com.grail.synchro.util.SynchroPermHelper'].getEffectiveUser() />



function validatePITFields()
{
	
    showLoader('Please wait...');
    $j(".jive-error-box").hide();
    $j( ".jive-error-message" ).each(function( index ) {
        if(!$j(this).hasClass('numeric-error'))
        {
            $j(this).hide();
        }
    });
	var error = false;
	/*Project Start and End Dates check*/
		var startDate = $j("input[name=startDate1]");
		if(startDate.val() != null && $j.trim(startDate.val())=="")
		{
			if(!error)
				startDate.focus();
			startDate.parent().parent().find("span").show();
			error = true;
		}
		else if(!isDateformat(startDate.val()))
		{
			if(!error)
				startDate.focus();
			startDate.parent().parent().find("span").show();
			startDate.parent().parent().find("span").text("Project start date should be in dd/mm/yyyy format");
			error = true;
		}


		var endDate = $j("input[name=endDate1]");
		if(endDate.val() != null && $j.trim(endDate.val())=="")
		{
			if(!error)
				endDate.focus();
			endDate.parent().parent().find("span").show();
			error = true;
		}
		else if(!isDateformat(endDate.val()))
		{
			if(!error)
				endDate.focus();
			endDate.parent().parent().find("span").show();
	endDate.parent().parent().find("span").text("Project Completion date should be in dd/mm/yyyy format");
			error = true;
		}

		if(isDateformat(startDate.val()) && isDateformat(endDate.val()) && !compareDate(startDate.val(), endDate.val()))
		{
			if(!error)
				startDate.focus();
			startDate.parent().parent().find("span").show();
			startDate.parent().parent().find("span").text("Project Start date should be less than end date");
			error = true;
		}
		/*Project Start and End Dates check ends*/
		
		var categoryType = $j("#categoryType");
	if(categoryType.val() != null)
	{
	}
	else
	{
		$j("#categoryTypeError").show();
		$j(document).scrollTop(200);
		error = true;
	}
	
	var projectManagerName = $j("input[name=projectManagerName]");
    if(projectManagerName.val() != null && $j.trim(projectManagerName.val())=="")
    {
        projectManagerName.parent().find("span").show();
       // projectManagerName.focus();
        error = true;
    }
	
	var methodologyDetails = $j("#methodologyDetails");
	
	if(methodologyDetails.val() != null && methodologyDetails.val()!="")
	{
	}
	else
	{
		$j("#methodologyDetails").parent().find("span").show();
	     $j("#methodologyDetails").focus();
        error = true;
	}
	var methodologyType = $j('select[name="methodologyType"] option:selected').val();
	
    if(methodologyType < 1)
    {
   		$j("#methodologyType").parent().find("span").show();
	     $j("#methodologyType").focus();
        error = true;
    }
	else if(methodologyType==undefined)
	{
		$j("#methodologyType").parent().find("span").show();
	     $j("#methodologyType").focus();
        error = true;
	}
	
	var methWaiverReq = $j('select[name="methWaiverReq"] option:selected').val();
	
    if(methWaiverReq < 1)
    {
        
		$j("#methWaiverReq").parent().find("span").show();
	     $j("#methWaiverReq").focus();
        error = true;
    }
	var brandSpecificStudy = $j('select[name="brandSpecificStudy"] option:selected').val();
	
    if(brandSpecificStudy < 1)
    {
        
		$j("#brandSpecificStudyError").show();
        error = true;
    }
	else if (brandSpecificStudy==undefined)
	{
		$j("#brandSpecificStudyError").show();
        error = true;
	}
	
	var brandSpecificStudyType = $j('select[name="brandSpecificStudyType"] option:selected').val();
	
    if(brandSpecificStudy=="2" && brandSpecificStudyType < 1)
    {
        
		$j("#brandSpecificStudyTypeError").show();
        error = true;
    }
	var brand = $j('select[name="brand"] option:selected').val();
    
	if(brandSpecificStudy=="1" && brand < 1)
    {
        
		$j("#brandError").show();
        error = true;
    }
	
	var budgetLocation = $j("#budgetLocation");
	if(budgetLocation.val() == null)
	{
		$j("#budgetLocationError").show();
		error = true;
	}
	else if(budgetLocation.val()=="")
	{
		$j("#budgetLocationError").show();
		error = true;
	}
	
	var budgetYear = $j('select[name="budgetYear"] option:selected').val();

    if(budgetYear < 1)
    {
    	 $j("#budgetYearError").show();
        error = true;
    }
    if(validateProjectCostDetails())
	{
		if(error)
		{
			hideLoader();
			return false;
		}
		else
		{
			var pitForm = jQuery("#synchro-pit-form");
			pitForm.submit();
		}
	}

	else
	{
		hideLoader();
		return false;
	}
    
  
	


}
function exportToPDFPIT(projectId)
{

    window.location.href = "/new-synchro/pib-details!exportToPDFPIT.jspa?projectID="+projectId;
}

function changeAgencyUsersKantar()
{

    agencyContact1Div.show();
    agencyContact1BATDiv.hide();
    agencyContact1OptionalDiv.show();
    agencyContact1OptionalBATDiv.hide();
    $j("input[name=kantar]").val("true");
    document.getElementById('kantar').checked = true;
    $j("input[name=nonKantar]").val("false");
    document.getElementById('nonKantar').checked = false;
    initiateKantarWaiverButton.hide();

    /* agencyContact2Section.hide();
          agencyContact2SectionOptional.hide();
          agencyContact3Section.hide();
          agencyContact3SectionOptional.hide(); */

    kantarMessage.hide();
    nonKantarWaiverStatus.hide();


    /*if (document.getElementById('nonKantar').checked)
    {
         agencyContact1Div.hide();
         agencyContact1BATDiv.show();
         agencyContact1OptionalDiv.hide();
          agencyContact1OptionalBATDiv.show();
         $j("input[name=nonKantar]").val("true");
         document.getElementById('nonKantar').checked = true;
         initiateKantarWaiverButton.show();

         agencyContact2Section.hide();
         agencyContact2SectionOptional.hide();
         agencyContact3Section.hide();
         agencyContact3SectionOptional.hide();
         kantarMessage.show();
         nonKantarWaiverStatus.show();
    }
    else
    {
        agencyContact1Div.show();
        agencyContact1BATDiv.hide();
        agencyContact1OptionalDiv.show();
         agencyContact1OptionalBATDiv.hide();
        $j("input[name=nonKantar]").val("false");
        document.getElementById('nonKantar').checked = false;
        initiateKantarWaiverButton.hide();
        agencyContact2Section.show();
        agencyContact2SectionOptional.show();
        agencyContact3Section.show();
        agencyContact3SectionOptional.show();
        kantarMessage.hide();
        nonKantarWaiverStatus.hide();
    }*/
}

function changeAgencyUsersNonKantar()
{

    agencyContact1Div.hide();
    agencyContact1BATDiv.show();
    agencyContact1OptionalDiv.hide();
    agencyContact1OptionalBATDiv.show();
    $j("input[name=kantar]").val("false");
    document.getElementById('kantar').checked = false;
    $j("input[name=nonKantar]").val("true");
    document.getElementById('nonKantar').checked = true;


    initiateKantarWaiverButton.show();

    kantarMessage.show();
    nonKantarWaiverStatus.show();


}
function validatePIBFormFields()
{
	var datesError = false;
	datesError = validatePIBDates();
	if(!datesError)
	{
		return false;
	}
	
	var error = false;
console.log("validatePIBFormFields");
    showLoader('Please wait...');
    

    /** Code to be placed before hiding all previous error messages **/
    /*Check of there is numeric field error before submitting*/
    $j(".numericfield").each(function(){
        $j(this).parent().find("span").each(function(spanIndex) {
            if($j(this).hasClass('numeric-error') && $j(this).is(":visible"))
            {
                error = true;
            }
        });
    });

    /*Check of there is exceeded text size error for textareas before submitting*/
    $j("textarea").each(function(){
        var $that = $j(this);
        $j(this).parent().parent().find("span").each(function(spanIndex) {
            if($j(this).hasClass('numeric-error') && $j(this).is(":visible"))
            {
                error = true;
            
                $that.next().contents().find("body").focus();
            }
        });
    });

    $j(".jive-error-box").hide();
    $j( ".jive-error-message" ).each(function( index ) {
        if(!$j(this).hasClass('numeric-error'))
        {
            $j(this).hide();
        }
    });

    
	
	  var documentation = $j("textarea[name=documentation]");
	


  
    /*Project latest estimate check ends*/


   

    /* Starts : Validation of Text fields*/

  /*  if(documentation.val() != null && $j.trim(documentation.val())=="")
    {
        if(!error)
            documentation.focus();
        error = true;
        documentation.parent().parent().find('.jive-error-message').show();

    }
*/
	
    /* Ends : Validation of Text fields*/

     
	

    if(error)
	{
        hideLoader();
		return false;
	}
	else
	{
		var psForm = jQuery("#project-specs-form");
		$j("#confirmProject").val('confirmProject');
		psForm.submit();
	}
	return true;
}

$j("#startDate").click(function() {
    $j("#startDate_button").click();
});
$j("#endDate").click(function() {
    $j("#endDate_button").click();
});





/*Code to track read status
of the document for current user and project */
ProjectReadTracker.setReadTrackInfo(${projectID?c}, ${user.ID?c}, 1);

function showInitiateWaiverWindow()
{
    initiateWaiverWindow.show();
    initiateRTE('methodologyDeviationRationale', 2500, false);
    initiateRTE('methodologyApproverComment', 2500, false);
}
function showInitiateKantarWaiverWindow()
{
    initiateKantarWaiverWindow.show();
    initiateRTE('methodologyDeviationRationaleKantar', 2500, false);
    initiateRTE('methodologyApproverCommentKantar', 2500, false);
	
	
	<#if !(pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.methodologyApprover??)>
		<#-- <#assign kantarBtnClickText><@s.text name="logger.project.kantar.btn.click" /></#assign> -->
		
		
		<#assign i18CustomText>View In Progress</#assign>
		var projName = "${project.name?js_string}";
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].ADD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_IN_PROGRESS.getId()}, "${i18CustomText}", projName, ${projectID?c}, ${user.ID?c});
	</#if>
}

/* Initialization of Editor */
$j(document).ready(function () {
    
	initiateRTE('documentation', 2500, true);
	
});

</script>

<script type="text/javascript">

	<#-- <#assign i18CustomText><@s.text name="logger.project.pib.view.text" /></#assign>	-->
	<#assign i18CustomText>View In Progress</#assign>
	var projName = "${project.name?js_string}";	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_IN_PROGRESS.getId()}, "${i18CustomText}", projName, ${projectID?c}, ${user.ID?c});
</script>

  <script src="${themePath}/js/synchro/project-cost-details.js" type="text/javascript"></script> 
  <script type="text/javascript">
  

  
  
  function continueProject()
  {
	var datesError = validatePIBDates();
	if(!datesError)
	{
		return false;
	}
	
	{
		/*dialog({
					title:"Message",
					html:"<p>It is mandatory to initiate the required waiver(s) before project confirmation.</p><p>Please initiate the required waiver(s) to continue.</p><p>It is mandatory to confirm if a methodology waiver is required in the project.</p><p>Please select Yes/No from the options given in ‘Will there be a methodology waiver required?'</p>",
					buttons:{
					"OK":function() {
						var psForm = jQuery("#project-specs-form");
						var error = validatePIBFormFields();
						if(error)
						{
							$j("#confirmProject").val('confirmProject');
							psForm.submit();
						}
						else
						{	
							return false;		
						}
						
					}
				},

				});*/
			$j("#confirmProject").val('confirmProject');
			openPITWindow();
				
	}
	
	
  }
  
  $j("#brandSpecificStudy").change(function() {
			
			 var brandSpecificStudy = $j('select[name="brandSpecificStudy"] option:selected').val();
			 if(brandSpecificStudy=="2")
			 {
				$j("#brandSpecificStudyType").show();
				$j("#brandSpecific").hide();
			 }
			 if(brandSpecificStudy=="1")
			 {
				  $j("#brandSpecific").show();
				  $j("#brandSpecificStudyType").hide();
			 }
			 if(brandSpecificStudy=="-1")
				 {
					  $j("#brandSpecific").hide();
					  $j("#brandSpecificStudyType").hide();
				 }
			
	});
	var endMarketO = $j('select[name="endMarkets"] option:selected').val();
	var endMarketText = $j('select[name="endMarkets"] option:selected').text();
	
	$j("select[name='endMarkets']").change(function() {
			dialog({
					title:"Message",
					html:"<p>You are trying to change 'Research End Market'. This cannot be updated!</p><p>You need to cancel the project and setup it up as a new project on SynchrO with the correct information.</p>",
					buttons:{
					"OK":function() {
					
					$j('select[name="endMarkets"]').val(endMarketO);
					$j('#endMarkets_chosen span').text(endMarketText);
						
						endMarketO=endMarketO;
						endMarketText = endMarketText;		
						
						$j('select[name="endMarkets"]').val(endMarketO).trigger('chosen:updated');
						
						
						
						
						
						return false;		
					}
				},

				});
			//$j('select[name="endMarkets"] select').val(endMarket);
			//$j('#endMarkets_chosen span').text(endMarketText);
			
	});
	
	
	
	
	var fieldWorkStudy = $j('select[name="fieldWorkStudy"] option:selected').val();
	var fieldWorkStudyText = $j('select[name="fieldWorkStudy"] option:selected').text();
	
	
	$j("#fieldWorkStudy").change(function() {
			
		
			dialog({
					title:"Message",
					html:"<p>You are trying to change 'Is the project a fieldwork component of an above market study?'. This cannot be updated!</p><p>You need to cancel the project and setup it up as a new project on SynchrO with the correct information.</p>",
					buttons:{
					"OK":function() {
					
					
					
					$j('select[name="fieldWorkStudy"]').val(fieldWorkStudy);
					$j('#fieldWorkStudy_chosen span').text(fieldWorkStudyText);
						
						fieldWorkStudy=fieldWorkStudy;
						fieldWorkStudyText = fieldWorkStudyText;		
						
						$j('select[name="fieldWorkStudy"]').val(fieldWorkStudy).trigger('chosen:updated');
						return false;		
					}
				},

				});
			
	});
	
	function cancelProject()
  {
	
	{
		dialog({
					title:"Message",
					html:"<p>Once you cancel the project, it will no longer be accessible.</p><p>Are you sure you want to cancel the project</p>",
					buttons:{
					"YES":function() {
						var cancelProjForm = jQuery("#cancelProj");
						cancelProjForm.submit();
					},
					"NO": function() {
						return false;
					}
				},

				});
				
	}
	
	
  }
 function enableProject()
  {
	
	{
		dialog({
					title:"Message",
					html:"<p>Are you sure you want to enable the project</p>",
					buttons:{
					"YES":function() {
						var enableProjForm = jQuery("#enableProj");
						enableProjForm.submit();
					},
					"NO": function() {
						return false;
					}
				},

				});
				
	}
	
	
  }

 
	$j(document).ready(function() {
		 var brandSpecificStudy = $j('select[name="brandSpecificStudy"] option:selected').val();
		 if(brandSpecificStudy=="2")
		 {
			$j("#brandSpecificStudyType").show();
			$j("#brandSpecific").hide();
		 }
		 if(brandSpecificStudy=="1")
		 {
			  $j("#brandSpecific").show();
			  $j("#brandSpecificStudyType").hide();
		 }
		 
		  $j( function() {
			   var arr = []; 
			 
			   <#list synchroUserNames as usname >
			   <#if usname??>
				 var userName = "${usname}";
				 arr.push(userName);
			   </#if>
			   </#list>
			  
			 $j("#projectManagerName").autocomplete({
				source: arr
			  }); 
			});
	});
<#if showAgencyWaiver=="yes">
	<#else>
		
		  $j("#agencyWaiverDiv").hide();
		  $j("#agencyWaiverDivPIT").hide();
		  
	</#if>
	
$j("#brand").change(function() {
			AddPITFieldTitle();
		
		});
		
		$j("#brandSpecificStudyType").change(function() {
			  AddPITFieldTitle();
		
		});
		
	$j("#endMarketFunding").change(function() {
			
			var endMarketFunding = $j('#endMarketFunding').val();
			if(endMarketFunding=="1")
			{
				$j("#fundingMarketsDiv").show();
			}
			else
			{
				$j("#fundingMarketsDiv").hide();
			}
		});	
	$j("#methodologyDetails").change(function() {
			
			var methodogyDetails = $j("#methodologyDetails").val();
			
			
			
			
            
			var element = $j(this).find('option:selected'); 
			
			var lessFrequent = element.attr("lessFrequent");
			var methName = $j("#methodologyDetails option:selected" ).text();
			
			
          /*Logic for autopopulating of MethodologType and other fields Starts*/
		 
		  if($j.trim(methodogyDetails).indexOf(",")>-1)
		  {
				$j('#methodologyType').val('').trigger('chosen:updated');
				$j('#brandSpecificStudy').val('').trigger('chosen:updated');
				$j('#brand').val('').trigger('chosen:updated');	
				
				$j("#brandSpecificStudyType").hide();
			    $j("#brandSpecific").hide();	
		  }
		  else
		  {
			  FieldMappingUtil.getMethodologyTypeByMethodology(parseInt(methodogyDetails), {
					callback: function(result) {
		
					  if(result > -1)
					  {
						  $j('#methodologyType').val(result).trigger('chosen:updated');
					  }
					  else
					  {
						 
						  $j('#methodologyType').val('').trigger('chosen:updated');
						  $j('#brandSpecificStudy').val('').trigger('chosen:updated');
						  $j('#brand').val('').trigger('chosen:updated');	
						  $j("#brandSpecificStudyType").hide();
						  $j("#brandSpecific").hide();	
					  }
					},
					async: false,
					timeout: 20000
				});
				var brandSpecific = element.attr("brandSpecific");
				
				if(brandSpecific=="1")
				{
					$j('#brandSpecificStudy').val('1').trigger('chosen:updated');
					 $j("#brandSpecific").show();
					$j("#brandSpecificStudyType").hide();
				}
				else if(brandSpecific=="2")
				{
					$j('#brandSpecificStudy').val('2').trigger('chosen:updated');
					$j("#brandSpecificStudyType").show();
					$j("#brandSpecific").hide();
				}
		  }
		
		
		  /*Logic for autopopulating of MethodologType and other fields Ends*/
		  
		});
function dateCompare()
	{
		
		var legalApprovalDate = $j("#legalApprovalDate").val();
		var legalApproverDatePit = $j("#legalApproverDatePit").val();
		if(!compareDate(legalApproverDatePit, legalApprovalDate))
		{
		  
		 dialog({
				title:"Message",
				html:"<p>Please check the date you have selected.</p><p> Proposal Legal Approved Date cannot be prior to the date of approval on Brief.</p>",
				buttons:{
				"OK":function() {
					$j("#legalApprovalDate").val('');
					return false;		
				}
			},

			});
		   error = true;
		}
	}	
	function dateCompareStart()
	{
		var endDate = $j("#endDate").val();
		var startDate = $j("#startDate").val();
		if(endDate!=null && endDate!=undefined && endDate!="")
		{
			if(!compareDate(startDate, endDate))
			{
			  
			 dialog({
					title:"Message",
					html:"<p>Please check the date you have selected.</p><p>Project Completion cannot be prior to the Project Start.</p>",
					buttons:{
					"OK":function() {
						$j("#startDate").val('');
						return false;		
					}
				},

				});
			   error = true;
			}
		}	
	}
	function dateCompareEnd()
	{
		var endDate = $j("#endDate").val();
		var startDate = $j("#startDate").val();
		
		if(startDate!=null && startDate!=undefined && startDate!="")
		{
			if(!compareDate(startDate, endDate))
			{
			  
			 dialog({
					title:"Message",
					html:"<p>Please check the date you have selected.</p><p>Project Completion cannot be prior to the Project Start.</p>",
					buttons:{
					"OK":function() {
						$j("#endDate").val('');
						return false;		
					}
				},

				});
			   error = true;
			}
		}
	}
	
	function dateCompareStartPIT()
	{
		var endDate = $j("#endDate1").val();
		var startDate = $j("#startDate1").val();
		if(endDate!=null && endDate!=undefined && endDate!="")
		{
			if(!compareDate(startDate, endDate))
			{
			  
			 dialog({
					title:"Message",
					html:"<p>Please check the date you have selected.</p><p>Project Completion cannot be prior to the Project Start.</p>",
					buttons:{
					"OK":function() {
						$j("#startDate1").val('');
						return false;		
					}
				},

				});
			   error = true;
			}
		}	
	}
	function dateCompareEndPIT()
	{
		var endDate = $j("#endDate1").val();
		var startDate = $j("#startDate1").val();
		
		if(startDate!=null && startDate!=undefined && startDate!="")
		{
			if(!compareDate(startDate, endDate))
			{
			  
			 dialog({
					title:"Message",
					html:"<p>Please check the date you have selected.</p><p>Project Completion cannot be prior to the Project Start.</p>",
					buttons:{
					"OK":function() {
						$j("#endDate1").val('');
						return false;		
					}
				},

				});
			   error = true;
			}
		}
	}
	
	function validatePIBDates()
	{
		
		var error = false;
		var startDate = $j("input[name=startDate]");
		if(startDate.val() != null && $j.trim(startDate.val())=="")
		{
			if(!error)
				startDate.focus();
			startDate.parent().parent().find("span").show();
			error = true; 
		}
		else if(!isDateformat(startDate.val()))
		{
			if(!error)
				startDate.focus();
			startDate.parent().parent().find("span").show();
			startDate.parent().parent().find("span").text("Project Start date should be in dd/mm/yyyy format");
			error = true;
		}


		var endDate = $j("input[name=endDate]");
		if(endDate.val() != null && $j.trim(endDate.val())=="")
		{
			if(!error)
				endDate.focus();
			endDate.parent().parent().find("span").show();
			error = true;
		}
		else if(!isDateformat(endDate.val()))
		{
			if(!error)
				endDate.focus();
			endDate.parent().parent().find("span").show();
			endDate.parent().parent().find("span").text("Project Completion date should be in dd/mm/yyyy format");
			error = true;
		}

		if(isDateformat(startDate.val()) && isDateformat(endDate.val()) && !compareDate(startDate.val(), endDate.val()))
		{
			if(!error)
				startDate.focus();
			startDate.parent().parent().find("span").show();
			startDate.parent().parent().find("span").text("Project Start date should be less than end date");
			error = true;
		}
		if(error)
		{	
			return false;
		}
		else
		{
			return true;
		}
	}
  </script>
  

  
  
  
  
  
  

