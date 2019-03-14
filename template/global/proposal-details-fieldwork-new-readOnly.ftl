
<form name="proposal-form-fieldwork" action="/new-synchro/proposal-details-fieldwork!execute.jspa" method="POST"  id="proposal-form-fieldwork" class="research_pib pib" >
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
	
	<#--
	<div id="expenseDetailsContainer" class="expense-details">
				<label>Cost Details</label>
					<div class="border-box">
					
					<#if projectCostDetailsList?? && projectCostDetailsList?size gt 0 >
						<#assign projectCostCounter = 0 />
						<#list projectCostDetailsList as projectCostDetail>
					
						<#assign projectCostCounter =  projectCostCounter + 1/>
						
					
						<div class="expense_row">
							
							
					
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
							<@renderCostComponent name="costComponents" value="${projectCostDetail.getCostComponent()?default('-1')}" id='costComponent' readonly=true/>
							<span class='jive-error-message costComponentdynamicError'  style='display:none'>Please Select Cost Component</span> 
						</div> 
						<div class="region-inner">
							
							<@renderCurrenciesFieldNew name='currencies' value="${projectCostDetail.getCostCurrency()?default(-1)}"  disabled=true id='currency' />
							<span class='jive-error-message costCurrencytdynamicError'  style='display:none'>Please Select Cost Currency</span>
						</div>

						
						<div class="region-inner">
							
							<div class="form-select_div">
								<div class="pit-estimate-cost">
							

									<input type="text"  id="enter_cost" name="agencyCosts"  firstRow="yes" Placeholder="Enter Cost" disabled class="text_field longField total-expense" value="${projectCostDetail.getEstimatedCost()}" />
								<span class="jive-error-message agencyCostsError" style="display: none;">Please Enter Agency Cost</span>
								</div>
								
							</div>

						</div>
					</div>
					</#list>
					
					
					
						<div class="expense_row">
					     
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
					
							<div class="form-select_div">
								<div class="pit-estimate-cost">
					

								<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" Placeholder="Enter Cost" disabled class="text_field longField total-expense" value="" />
								<span class="jive-error-message agencyCostsError" style="display: none;">Please Enter Agency Cost</span>
								</div>
								
							</div>

						</div>
					</div>
					
				
					
					
					
					<#else>
					
					<div class="expense_row">
					    
						<div class="region-inner">
							
						
							<div id="agencyMain">
						  
							
								<select data-placeholder="Select Research Agency" class="chosen-select  appended-agency researchAgency" disabled id = "agency" name='agencies' >
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
				
							<div class="form-select_div">
								<div class="pit-estimate-cost">
				

								<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" disabled Placeholder="Enter Cost" class="text_field longField total-expense" value="" />
								<span class="jive-error-message agencyCostsError" style="display: none;">Please Enter Agency Cost</span>
								</div>
								
							</div>

						</div>
					</div>
					</#if>

					<div class="region-inner total-cost">
				
						<div class="form-select_div">
							<div class="pit-estimate-cost">
								<label>Total Cost(GBP)</label>
								<#if project.totalCost??> 
									<input type="text"   Placeholder="0" name="totalCost" class="text_field longField" disabled value="${project.totalCost?round}" />
								<#else>
									<input type="text"   Placeholder="0" name="totalCost" class="text_field longField" disabled value="" />
								</#if>
								
								<input type="hidden"  name="totalCostHidden"  id="totalCostHidden" value="" />
							<#assign error_msg><@s.text name="project.error.cost"/></#assign>
							<@macroCustomFieldErrors msg=error_msg class="numeric-error"/>
							</div>
							
						</div>
 
					</div>
					<div id="nonKantarAgencyMessage" style="display:none">This project requires a waiver for using non-Kantar agency. You can initiate a waiver once a project is created.
					</div>
					</div>
				</div>
	
	-->
	
	<div class="region-inner">
		<div class="form-select_div">
		<label>Is the project a fieldwork component of an above market study?</label>
		<@fieldworkstudyField name='fieldWorkStudyO' value=project.fieldWorkStudy?default('-1') readonly=true/>
		<#assign error_msg><@s.text name='project.error.brand' /></#assign>
		<@macroCustomFieldErrors msg=error_msg />
		</div>
	
	
	<div class="form-select_div reference-code">
		<label>Reference Synchro Code <#-- </br><span class="tooltip-wrap"><span class="tip-ico"></span><div class="bubble">Provide the Synchro Code for the market study associated with this project.If you have not received the project code, reach out to the market contact for details. <div class="bubble-arrow"></div></div>
							</span>  --></label>
		
		<input type="text"  name="refSynchroCode" placeholder="Enter Synchro Code" disabled <#if project.refSynchroCode?? && project.refSynchroCode gt 0>value="${project.refSynchroCode?c}" <#else>value=""</#if>id="refSynchroCode"  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter Synchro Code' "/>
		
		<span class="jive-error-message" id="referenceCodeError" style="display:none">Please enter Numeric Value</span>
	</div>
	</div>
	
	<#if agencyWaiverException=="yes">				
	<#else>
		<div id="agencyWaiverDiv" class="statusPending">
			<div class="project_waiver_rqst"  >
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
		
    
		
		<select data-placeholder="Select" class="chosen-select" id = "deviationFromSM" name="deviationFromSM" disabled   onchange="checkMethDeviation()">
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
                    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#proposal-form-fieldwork"),form:$j("#waiver-form"), projectID:${projectID?c}});
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
       
    </div>
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



<div class="region-inner attachment-text">
	<label class='rte-editor-label'>Proposal</label>
    <div class="form-text_div">
      
		<textarea id="proposal"  placeholder="Add notes, if any" name="proposal" disabled rows="10" cols="20" class="form-text-div">${proposalInitiation.proposal?default('')?html}</textarea>
        <i>(In case there are multiple proposals, please attach all of them)</i>
		<@macroCustomFieldErrors msg="Please attach the Proposal" class='textarea-error-message'/>
		
    </div>
    <textarea style="display:none;" id="proposalText" name="proposalText">${proposalInitiation.proposalText?default('')?html}</textarea>
	 <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
   
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
        <#--FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#proposal-form-fieldwork"),form:$j("#kantar-waiver-form"), projectID:${projectID?c}});-->
    });

</script>


<div class="buttons">
    <#if editStage && !isBriefLegalApprover  >
        <br>
        <input type="hidden" id="confirmProject" name="confirmProject" value="" />
		<a href="javascript:void(0);" style="margin-left: 10px;" disabled class="publish-details disabled">Save</a>	
		<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" disabled class="publish-details disabled">Proceed To Project Evaluation</a>	
		
		
		  
	
	  
    </#if>
	</div>



</div>
</div>
</div>

</form>








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
  
   
		
        <form id="waiver-form" action="<@s.url value='/new-synchro/proposal-details-fieldwork!updateWaiver.jspa'/>" method="post" class="j-form-popup">
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

  

        <form id="kantar-waiver-form" action="<@s.url value='/new-synchro/proposal-details-fieldwork!updateKantarWaiver.jspa'/>" method="post">
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

            <div class="pib_view_popup"> 
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
        <form id="synchro-pit-form" action="<@s.url value='/new-synchro/proposal-details-fieldwork!updatePIT.jspa'/>" method="post" class="j-form-popup">
			<a href="javascript:void(0);" class="close" onclick="closePITWindow();"></a>
		  <div class="popup-title-overlay"></div>
		  <div class="pop-upinner-scroll">
		   <div class="pop-upinner-content">
            <h3>Project Details Overview</h3>
			
			
            <div class="pib_view_popup region-inner">
                <label>Project Name </label>
            <#if isAdminUser>
				<input type="text" id="projectName" name="projectName" value="${project.name?html}" />
			<#else>
				<input type="text" id="projectName" name="projectName" disabled value="${project.name?html}" />
			</#if>
            </div>
			<div class="region-inner">
            <label class="pit-description-label">Project Description</label>
           
			  
			<div class="form-text_div">
				<textarea id="description" name="description" rows="10" cols="20" disabled class="form-text-div">${project.description?default('')?html}</textarea>
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
			
			<div class="region-inner">
				
				<div class="form-select_div">
					<#--<label><@s.text name="project.initiate.project.brand"/></label>-->
					<label>Is the project a fieldwork component of an above market study?</label>
				
				<@fieldworkstudyField name='fieldWorkStudy' value=project.fieldWorkStudy?default('-1') readonly=true/>
				<#assign error_msg><@s.text name='project.error.brand' /></#assign>
				<@macroCustomFieldErrors msg=error_msg />
				</div>
				
				<div class="reference-code reference-custom">
					<label>Reference Synchro Code </label>
					<input type="text"  name="refSynchroCode" disabled placeholder="Enter Synchro Code"  <#if project.refSynchroCode?? && project.refSynchroCode gt 0>value="${project.refSynchroCode?c}" <#else>value=""</#if> id="refSynchroCodePit"  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter Synchro Code' "/>
					
					<span class="jive-error-message" id="referenceCodeErrorPit1" style="display:none">Please enter  the  Reference Synchro Code</span>
                    <span class="jive-error-message" id="referenceCodeErrorPit" style="display:none">Please enter Numeric Value</span>

				</div>


			</div>
			
			<div class="region-inner">
				<#assign selectedEndMarket="" />
				<#if endMarketDetails?? && endMarketDetails?size gt 0 >
				<#assign selectedEndMarket= endMarketDetails.get(0).endMarketID />
				</#if>
				<label class="label_b">Research End Market</label>
				
				<div class="">
			  
					<select data-placeholder="" class="chosen-select" disabled id = "endMarkets" name='endMarkets' >
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
			</div>
			<#--
			<div class="region-inner">
				
		
				<div class="form-select_div form-select_div_project_completion">
				
					<label>Project Initiator</label>
					<div>
						<input type="text"  name="projectInitiator" value="${user.name}" id="projectInitiator"  disabled />
					
					<#assign error_msg><@s.text name="project.error.spi"/></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
				</div>

			</div>
			-->
			<div class="region-inner">
					
					<label class="label_b">Methodology</label>
					<div class="col-lg-6">
				  
						
						<#if isAdminUser>
							<select data-placeholder="" class="chosen-select" disabled id = "methodologyDetails" name = "methodologyDetails" multiple  >
						<#else>
							<select data-placeholder="" class="chosen-select" disabled id = "methodologyDetails" name = "methodologyDetails"  >
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
					
					<select data-placeholder="Select" class="chosen-select" id = "methWaiverReq" name="methWaiverReq"  disabled  onchange="checkMethDeviation()">
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
					
					<@renderBrandSpecificStudy name='brandSpecificStudy' value=project.brandSpecificStudy?default('-1') readonly=true />
					<span class="jive-error-message" id="brandSpecificStudyError" style="display:none">Please select Is this a brand specific study?</span>
					<div id="brandSpecific" style="display:none">
					
					<div class="form-select_div">
						
					
					<@renderBrandFieldNew name='brand' value=project.brand?default('-1') readonly=true />
					<span class="jive-error-message" id="brandError" style="display:none">Please select Brand</span>
					</div>
					
					</div>
					<div id="brandSpecificStudyType">
					
					
										
					<@renderBrandSpecificStudyType name='brandSpecificStudyType' value=project.brandSpecificStudyType?default('-1') readonly=true />
					<span class="jive-error-message" id="brandSpecificStudyTypeError" style="display:none">Please select Study Type</span>
					
					</div>
					</div>
					
					
				</div>
				
				
				<div class="region-inner">
					
					<div class="form-select_div">
						<label>Budget Location</label>
					
					<#assign userBudgetLocation = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationEndMarkets(user) />
					
					<select data-placeholder="Select the Budget Location" class="chosen-select" disabled id = "budgetLocation" name="budgetLocation" >
						<#if userBudgetLocation?? && userBudgetLocation?size gt 0 >
							<option value=""></option>
							<#list userBudgetLocation as ubugLoc>
							<option  value="${ubugLoc}" <#if project.budgetLocation==ubugLoc>  selected </#if>>${endMarkets.get(ubugLoc?int)}</option>
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
				
				<!-- Add the Expense Details Here Start-->
			<#if isAdminUser || isSynchroSystemOwner>
					<div id="expenseDetailsContainer" class="region-inner view-edit-expense-details">
				<label>Cost Details</label>
					<div class="border-box">
					
					<#assign projectCostCounter = 0 />
					<#assign showAgencyWaiver=""/>
					<#list projectCostDetailsList as projectCostDetail>
					
					<#assign projectCostCounter =  projectCostCounter + 1/>
					<div class="expense_row">
					
					<input type="button" value="duplicate" id="firstDuplicate" class="duplicate"/>
					<input type="button" value="Remove" id="firstRemove" class="remove" />
					<div class="region-inner">
						
						
					
					<div id="agencyMain">
					
						<select data-placeholder="Select Research Agency" title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
						
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
						
						<@renderCostComponent name="costComponents"  value="${projectCostDetail.getCostComponent()?default('-1')}" id="costComponent"/>
						<span class='jive-error-message costComponentdynamicError'  style='display:none'>Please Select Cost Component</span> 
						
					</div>
					<div class="region-inner">
						<@renderCurrenciesFieldNew name='currencies' value="${projectCostDetail.getCostCurrency()?default(-1)}" disabled=false id="currency" />
						<span class='jive-error-message costCurrencytdynamicError'  style='display:none'>Please Select Cost Currency</span>
					</div>

					
					<div class="region-inner">
						<!-- Project Initial Cost Field -->
						<div class="form-select_div">
							<div class="pit-estimate-cost">
								<!-- <label><@s.text name="project.initiate.project.cost"/></label> -->
							<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" Placeholder="Enter Cost" class="text_field  longField total-expense" value="${projectCostDetail.getEstimatedCost()}" onfocus="this.placeholder = ''"   onblur="this.placeholder = 'Enter Cost'"  />
							
							<span class="jive-error-message agencyCostsError" style="display: none;">Please Enter Agency Cost</span>
							</div>
							
						</div>

					</div>
					</div>
					
					</#list>
					
					<#-- Adding a Blank Row Starts-->
					
						<div class="expense_row blank">
					     <input type="button" value="duplicate" class="duplicate" id="firstDuplicate" style="display:none"/>
						 <input type="button" value="Remove" class="remove" id="firstRemove" style="display:none"/>
						<div class="region-inner">
							
						
							<div id="agencyMain">
						  
							
								<select data-placeholder="Select Research Agency" title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
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
							<@renderCostComponent name="costComponents" value="" id='costComponent'/>
							<span class='jive-error-message costComponentdynamicError'  style='display:none'>Please Select Cost Component</span> 
						</div>
						<div class="region-inner">
							<@renderCurrenciesFieldNew name='currencies' value='-1' disabled=false id='currency'/>
							<span class='jive-error-message costCurrencytdynamicError'  style='display:none'>Please Select Cost Currency</span>
						</div>

						
						<div class="region-inner">
							<!-- Project Initial Cost Field -->
							<div class="form-select_div">
								<div class="pit-estimate-cost">
									<!-- <label><@s.text name="project.initiate.project.cost"/></label> -->

								<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" Placeholder="Enter Cost" class="text_field longField total-expense" value="" onfocus="this.placeholder = ''"   onblur="this.placeholder = 'Enter Cost'" />
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
							<div id="nonKantarAgencyMessagePit" style="display:none">This project requires a waiver for using non-Kantar agency. You can initiate a waiver once a project is created.
							</div>		
						</#if>
					</#if>
					</div>
				</div>
				<#else>
					<div id="expenseDetailsContainer" class="region-inner">
						<label>Cost Details</label>
						<div class="border-box">
						
						<#assign projectCostCounter = 0 />
							<#assign showAgencyWaiver=""/>
						<#list projectCostDetailsList as projectCostDetail>
						
						<#assign projectCostCounter =  projectCostCounter + 1/>
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
								<span class='jive-error-message researchAgencydynamicError'  style='display:none'>Please select Research Agency</span>
						
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
								<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" Placeholder="Enter Cost" class="text_field  longField total-expense" disabled value="${projectCostDetail.getEstimatedCost()}" />
								
								<span class="jive-error-message agencyCostsError" style="display: none;">Please Enter Agency Cost</span>
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
										<input type="text" placeholder="0" name="totalCost" class="longField" value="${statics['com.grail.synchro.util.SynchroUtils'].getPreferredCurrenyTotalCost(project,user)?round}" disabled />
									<#else>
										<input type="text" placeholder="0" name="totalCost" class="longField" value="" disabled />
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
							<div id="nonKantarAgencyMessage" style="display:none">This project requires a waiver for using non-Kantar agency. You can initiate a waiver once a project is created.
							</div>
						</#if>	
						
						</div>
					</div>
				</#if>	
				<!-- Add the Expense Details Here Ends-->
				
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
							<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_APP_PENDING.ordinal()>
								<span>Status: <span class="status-txt pendingStatus">Pending</span></span>
							</#if>	
						<#else>
						</#if>

					
					</div>
				</div>
			</#if>	
				
		 <div class="pib_band_view">
            
                <div class="region-inner-pib">
                    <input class="j-btn-callout"   disabled type="button" name="doPost" id="postButton"  value="Save" style="font-weight: bold;" />
                    
                </div>
            </div>
            
            
        </form>
    </div>
</div>


</div>


</div>

  
  
