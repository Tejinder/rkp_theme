<form name="pib" id="pib-form" action="/synchro/pib-details!execute.jspa" method="POST" name="form-create" class="research_pib pib" >
<div class="research_content">
<input type="hidden" name="projectID" value="${projectID?c}">

<input type="hidden" name="isSave" value="${save?string}">

<div class="pib_inner_main">
    <div class="pib_left">
       <#--
        <div class="form-text_div">
            <label>Project Code</label>
            <input type="text" name="projectID" value="${project.projectID?c}" class="form-text-div" disabled>
        </div>


        <div class="form-text_div">
            <label>Project Name</label>
        
            <input type="hidden" name="name" value="${project.name?default('')}">
        
            <div class="project_name_field">
                <div class="project_name_input">
                    <p>${project.name?default('')}</p>
                </div>
            </div>
        </div>
        -->

        <div class="pib-select_div">
            <label><@s.text name="project.initiate.project.brand"/></label>
        <@renderBrandField name='brand' value=project.brand?default('-1') readonly=true/>
        <#assign error_msg><@s.text name='project.error.brand' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>

        <div class="pib-select_div">
            <label>Country</label>
        <@renderEndMarketSingleSelectFld name='updatedSingleMarketId' value=endMarketId?default('-1') disabled=true/>
        <#assign error_msg><@s.text name='project.error.endmarket' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>

        <div class="project_owner_names">
            <label>Project Owner</label>
        <#if project.projectOwner &gt; 0>
        <#--<#assign ownerUserName = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getName() />-->
            <#assign ownerUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner) />
        <#else>
            <#assign ownerUserName="" />
        </#if>
            <input type="text" name="projectOwnerRead" id="projectOwnerRead"  value="${ownerUserName}" disabled />
        </div>

        <div class="project_owner_brief">
            <label>PIT Creator</label>

        <#if project.briefCreator &gt; 0>
        <#--<#assign briefCreatorName = jiveContext.getSpringBean("userManager").getUser(project.briefCreator).getName() />-->
            <#assign briefCreatorName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.briefCreator) />
        <#else>
            <#assign briefCreatorName="" />
        </#if>
            <input type="text" name="briefCreator" id="briefCreator"  value="${briefCreatorName}" disabled />

        </div>

        <div class="project_owner_contact">
            <label>SP&I Contact</label>
        <#assign spiContact = endMarketDetails.get(0).getSpiContact() />
        <#if spiContact &gt; 0>
        <#--<#assign spiContactName = jiveContext.getSpringBean("userManager").getUser(spiContact).getName() />-->
            <#assign spiContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(spiContact) />
        <#else>
            <#assign spiContactName="" />
        </#if>
            <input type="text" name="spiContactRead" id="spiContactRead"  value="${spiContactName}" disabled />
            <input type="hidden" name="spiContact" id="spiContactRR"  value="${spiContact}"  />
        </div>

	<#--
        <div class="pib-select_div">
            <label><@s.text name="project.initiate.project.methodologyproposed"/></label>
        <@renderProposedMethodologyGroupField name='proposedMethodology' value=project.proposedMethodology?default(-1) readonly=true/>
        <#assign error_msg><@s.text name='project.error.proposedmethodologygroup' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>
        -->
        <div class="form-date_div">
            <label>Estimated Project Start</label>
            <input type="text" name="startDate" id="startDate"  value="${project.startDate?string('dd/MM/yyyy')}" disabled />
        </div>

        <div class="form-date_div">
            <label>Estimated Project End</label>
            <input type="text" name="endDate" id="endDate"  value="${project.endDate?string('dd/MM/yyyy')}" disabled />
        </div>
    </div>

    <div class="pib_right">
        <h3 class="pib_right_heading">Other Information</h3>


        <div class="region-inner">

            <label>Category Type</label>

        <@renderAllSelectedCategoryTypeField name='categoryTypeSelected' value=project.categoryType?default(-1) readonly=true/>
        <#assign error_msg><@s.text name='project.error.category' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>


        <div class="form-select_div">
            <label><@s.text name="project.initiate.project.methodology"/></label>
        <@renderMethodologyField name='methodologyType' value=project.methodologyType?default('-1') readonly=true/>
        <#assign error_msg><@s.text name='project.error.methodology' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>
        <div class="form-select_div">
            <label><@s.text name="project.initiate.project.methodologygroup"/></label>
        <@renderMethodologyGroupField name='methodologyGroup' value=project.methodologyGroup?default('-1') readonly=true/>
        <#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>
        
       <div class="region-inner proposed-region">
            <label><@s.text name="project.initiate.project.methodologyproposed"/></label>
			<#assign defaultPMethodologyID = JiveGlobals.getJiveIntProperty("grail.synchro.default.proposedmethodology", -1) />
            <@displayProposedMethodologyMultiSelect name='proposedMethodology-display' value=project.proposedMethodology?default([defaultPMethodologyID]) />            
        </div>
    <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
    <#if !(isExternalAgencyUser || synchroPermHelper.isExternalAgencyUser(user) || isCommAgencyUser || synchroPermHelper.isCommunicationAgencyUser(user)) >
       <#if !(isCommunicationAgencyAdminUser || synchroPermHelper.isSynchroCommunicationAgencyAdmin())>
	        <div class="form-text_div pib_initial_cost">
	            <label>Estimated Cost</label>
	            <input type="text" name="name" value="${endMarketDetails.get(0).initialCost}" size="30" class="form-text-div" disabled="true">
	            <@renderCurrenciesField name='intMgmtCostType' value=endMarketDetails.get(0).initialCostCurrency?default(defaultCurrency) disabled=true/>
	        </div>
	
	        <div class="form-text_div pib_initial_cost">
	            <label>Latest Estimate</label>
	            <input type="text" name="latestEstimate-display" disabled="true" <#if projectInitiation.latestEstimate?? > value="${projectInitiation.latestEstimate}" <#else> value="" </#if> size="30" class="form-text-div numericfield numericformat" >
	            <@renderCurrenciesField name='latestEstimateType' value=projectInitiation.latestEstimateType?default(defaultCurrency) disabled=true/>
	            <input type="hidden" name="latestEstimate" <#if projectInitiation.latestEstimate?? > value="${projectInitiation.latestEstimate?c}" <#else> value="" </#if> >
	        </div>
	   </#if>
		
			<!-- SVN-18822 Fieldwork has Tendering Process Field-->
			<div class="form-select_div">
				<label>Fieldwork has Tendering Process</label>
				<select name="hasTenderingProcess" id="hasTenderingProcess" class="form-select" disabled>		
					<option value="1" <#if projectInitiation.hasTenderingProcess?? && projectInitiation.hasTenderingProcess==1>selected="selected"</#if>>Yes</option>
					<option value="0" <#if !projectInitiation.hasTenderingProcess?? || (projectInitiation.hasTenderingProcess?? && projectInitiation.hasTenderingProcess==0)>selected="selected"</#if>>No</option>					
				</select>				
			</div>
			
			<!-- SVN-18822 Fieldwork Cost Field-->
			<div class="form-text_div pib_initial_cost" id="pib-fieldworkcost-field" <#if projectInitiation.hasTenderingProcess?? && projectInitiation.hasTenderingProcess==1>style="display:block;"<#else>style="display:none;"</#if> >
                <label class="synchro-help-label" title="Please enter the final cost from the winning bid resulting from any fieldwork tender process.">Fieldwork Cost<span title="Please enter the final cost from the winning bid resulting from any fieldwork tender process.">help</span></label>
                <input type="text" name="fieldworkCost" disabled <#if projectInitiation.fieldworkCost?? > value="${projectInitiation.fieldworkCost}" <#else> value="" </#if> size="30" class="form-text-div numericfield numericformat longField">
                <@renderCurrenciesField name='fieldworkCostCurrency' value=projectInitiation.fieldworkCostCurrency?default(defaultCurrency) disabled=true/>
            </div>
    </#if>

        <div class="form-text_div npi-number">
            <label>NPI Number <br/>(if appropriate)</label>
            <input type="text" name="npiReferenceNo" value="${projectInitiation.npiReferenceNo?default('')?html}" size="30" class="form-text-div" disabled>
        </div>

        <div class="form-select_div select-div">
            <label>Request for Methodology Waiver</label>
            <select name="deviationFromSM" id="deviationFromSM" class="form-select" onchange="checkMethDeviation()" disabled>
                <option value="0" <#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==0 > selected </#if>>No</option>
                <option value="1" <#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==1 > selected </#if>>Yes</option>
            </select>
        <#--<#if !(isExternalAgencyUser || isCommAgencyUser) >-->
        
         <script type="text/javascript">
                    var initiateWaiverWindow = null;
                    $j(document).ready(function(){
                        initiateWaiverWindow = new LIGHT_BOX($j("#initiateWaiver"),{title:'Request for Methodology Waiver'})
                    });

         </script>
            <#if !(isExternalAgencyUser || isCommAgencyUser) >
            <#assign showWaiverBtn = 'block' />
            <#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==0>
                <#assign showWaiverBtn = 'none' />
            </#if>
            <ul class="right-sidebar-list">
                
                <li id="initiateWaiverButton" style='display:${showWaiverBtn?string}'><a onclick="javascript:showInitiateWaiverWindow();" href="javascript:void(0);"><#if pibMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Initiate a Waiver</#if></a></li>
            </ul>
        </#if> 
        </div>
		<#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==1>
			<div class="form-select_div select-div methodology-status">
				<label>Status of Waiver</label>
				<#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
					<span>Approved</span>
				<#elseif pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==2>
					<span>Rejected</span>
				<#else>
					<span>Pending</span>
				</#if>
		</div>
		</#if>
    </div>
</div>

<div class="region-inner">
<label class='rte-editor-label'>Project Description</label>
    <div class="form-text_div">		
        <textarea id="description" name="description" rows="15" cols="30" disabled>${project.description?html}</textarea>   
    </div>   
	<textarea style="display:none;" id="descriptionText" name="descriptionText">${project.descriptionText?default('')?html}</textarea>
</div>

<div class="region-inner">
	<label class='rte-editor-label'>Business Question</label>
    <div class="form-text_div">        
        <textarea id="bizQuestion" name="bizQuestion" rows="10" cols="20" class="form-text-div" disabled>${projectInitiation.bizQuestion?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="bizQuestionText" name="bizQuestionText">${projectInitiation.bizQuestionText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#if attachmentMap?? && attachmentMap.get(bussinessQuestionID)?? >
        <div id="jive-file-list" class="jive-attachments">
            <#list attachmentMap.get(bussinessQuestionID) as attachment>
                <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                    <span class="jive-icon-med jive-icon-attachment"></span>
                    <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                    ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                    </a>

                </div>
            </#list>
        </div>
    </#if>
    </div>
    <!-- ATTACHMENT DISPLAY ENDS -->
</div>

<div class="region-inner">
	<label class='rte-editor-label'>Research Objective(s)</label>
    <div class="form-text_div">        
        <textarea id="researchObjective" name="researchObjective" rows="10" cols="20" class="form-text-div" disabled>${projectInitiation.researchObjective?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="researchObjectiveText" name="researchObjectiveText">${projectInitiation.researchObjectiveText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#if attachmentMap?? && attachmentMap.get(researchObjectiveID)?? >
        <div id="jive-file-list" class="jive-attachments">
            <#list attachmentMap.get(researchObjectiveID) as attachment>
                <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                    <span class="jive-icon-med jive-icon-attachment"></span>
                    <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                    ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                    </a>
                </div>
            </#list>
        </div>
    </#if>
        <!-- ATTACHMENT DISPLAY ENDS -->
    </div>
</div>


<div class="region-inner">
	<label class='rte-editor-label'>Action Standard(s)</label>
    <div class="form-text_div">        
        <textarea id="actionStandard" name="actionStandard" rows="10" cols="20" class="form-text-div" disabled>${projectInitiation.actionStandard?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="actionStandardText" name="actionStandardText">${projectInitiation.actionStandardText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#if attachmentMap?? && attachmentMap.get(actionStandardID)?? >
        <div id="jive-file-list" class="jive-attachments">
            <#list attachmentMap.get(actionStandardID) as attachment>
                <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                    <span class="jive-icon-med jive-icon-attachment"></span>
                    <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                    ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                    </a>
                </div>
            </#list>
        </div>
    </#if>
    </div>
    <!-- ATTACHMENT DISPLAY ENDS -->
</div>

<div class="region-inner">
	<label class='rte-editor-label'>Methodology Approach and Research Design</label>
    <div class="form-text_div">        
        <textarea id="researchDesign" name="researchDesign" rows="10" cols="20" class="form-text-div" disabled>${projectInitiation.researchDesign?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="researchDesignText" name="researchDesignText">${projectInitiation.researchDesignText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#if attachmentMap?? && attachmentMap.get(researchDesignID)?? >
        <div id="jive-file-list" class="jive-attachments">
            <#list attachmentMap.get(researchDesignID) as attachment>
                <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                    <span class="jive-icon-med jive-icon-attachment"></span>
                    <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                    ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                    </a>
                </div>
            </#list>
        </div>
    </#if>
    </div>
    <!-- ATTACHMENT DISPLAY ENDS -->
</div>

<div class="region-inner">
	<label class='rte-editor-label'>Sample Profile (Research)</label>
    <div class="form-text_div">        
        <textarea id="sampleProfile" name="sampleProfile" rows="10" cols="20" class="form-text-div" disabled>${projectInitiation.sampleProfile?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="sampleProfileText" name="sampleProfileText">${projectInitiation.sampleProfileText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#if attachmentMap?? && attachmentMap.get(sampleProfileID)?? >
        <div id="jive-file-list" class="jive-attachments">
            <#list attachmentMap.get(sampleProfileID) as attachment>
                <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                    <span class="jive-icon-med jive-icon-attachment"></span>
                    <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                    ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                    </a>
                </div>
            </#list>
        </div>
    </#if>
    </div>
    <!-- ATTACHMENT DISPLAY ENDS -->
</div>

<div class="region-inner">
	<label class='rte-editor-label'>Stimulus Material</label>
    <div class="form-text_div">        
        <textarea id="stimulusMaterial" name="stimulusMaterial" rows="10" cols="20" class="form-text-div" disabled>${projectInitiation.stimulusMaterial?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="stimulusMaterialText" name="stimulusMaterialText">${projectInitiation.stimulusMaterialText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#if attachmentMap?? && attachmentMap.get(stimulusMaterialID)?? >
        <div id="jive-file-list" class="jive-attachments">
            <#list attachmentMap.get(stimulusMaterialID) as attachment>

                <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                    <span class="jive-icon-med jive-icon-attachment"></span>
                    <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                    ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                    </a>
                </div>
            </#list>
        </div>
    </#if>
    </div>
    <!-- ATTACHMENT DISPLAY ENDS -->
</div>


<div class="region-inner">
	<label class='rte-editor-label'>Other Comments</label>
    <div class="form-text_div">        
        <textarea id="others" name="others" rows="10" cols="20" class="form-text-div" disabled>${projectInitiation.others?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="othersText" name="othersText">${projectInitiation.othersText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#if attachmentMap?? && attachmentMap.get(othersID)?? >
        <div id="jive-file-list" class="jive-attachments">
            <#list attachmentMap.get(othersID) as attachment>
                <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                    <span class="jive-icon-med jive-icon-attachment"></span>
                    <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                    ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                    </a>
                </div>
            </#list>
        </div>
    </#if>
    </div>
    <!-- ATTACHMENT DISPLAY ENDS -->
</div>

<div class="form-text_div">
    <h2 class="pib_sub_heading">Estimated Research Timelines </h2>
    <div class="pib_research_time">
        <label>Date Stimuli Available (in Research Agency)</label>
        <input type="text" name="stimuliDate" id="stimuliDate"  value="<#if projectInitiation.stimuliDate??>${projectInitiation.stimuliDate?string('dd/MM/yyyy')}</#if>" disabled />
    </div>
</div>


<div class="pib-report-requirement">
    <label>Reporting Requirement</label>
    <table class="report_requirement_list">
        <tbody>
        <tr>

            <td><@renderCheckBox label='' name='topLinePresentation' isChecked=pibReporting.topLinePresentation?default(false) disable=true/></td>
            <td class="view-row-first">Topline Presentation</td>
        </tr>
        <tr class="color-row">
            <td><@renderCheckBox label='' name='presentation' isChecked=pibReporting.presentation?default(false) disable=true/></td>
            <td class="view-row-first">Presentation</td>
        </tr>
        <tr>
            <td><@renderCheckBox label='' name='fullreport' isChecked=pibReporting.fullreport?default(false) disable=true/></td>
            <td class="view-row-first">Full Report</td>
        </tr>

        </tbody>
    </table>

</div>
<div class="region-inner">
	<label class='rte-editor-label'>Other Reporting Requirements</label>
    <div class="form-text_div">        
        <textarea id="otherReportingRequirements" name="otherReportingRequirements" rows="10" cols="20" disabled class="form-text-div">${pibReporting.otherReportingRequirements?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="otherReportingRequirementsText" name="otherReportingRequirementsText">${pibReporting.otherReportingRequirementsText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#if attachmentMap?? && attachmentMap.get(otherReportingRequirementID)?? >
        <div id="jive-file-list" class="jive-attachments">
            <#list attachmentMap.get(otherReportingRequirementID) as attachment>
                <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                    <span class="jive-icon-med jive-icon-attachment"></span>
                    <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                    ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                    </a>
                </div>
            </#list>
        </div>
    </#if>
    </div>
    <!-- ATTACHMENT DISPLAY ENDS -->
</div>
<#--<@macroCustomFieldErrors msg="Please enter Reporting Requirements"/>-->
<span id="reportingReqError" class="jive-error-message" style="display:none">Please enter Reporting Requirements</span>




<#if pibStakeholderList?? && pibStakeholderList.agencyContact1?? && pibStakeholderList.agencyContact1 &gt; 0>
<#--<#assign agency1UserName = jiveContext.getSpringBean("userManager").getUser(pibStakeholderList.agencyContact1).getName() />-->
    <#assign agency1UserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact1) />
<input type="hidden" name="agencyContact1" value="${pibStakeholderList.agencyContact1?c}">
<#else>
    <#assign agency1UserName="" />
</#if>

<#if pibStakeholderList?? &&  pibStakeholderList.agencyContact2?? && pibStakeholderList.agencyContact2 &gt; 0>
<#--<#assign agency2UserName = jiveContext.getSpringBean("userManager").getUser(pibStakeholderList.agencyContact2).getName() />-->
    <#assign agency2UserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact2) />
<input type="hidden" name="agencyContact2" value="${pibStakeholderList.agencyContact2?c}">
<#else>
    <#assign agency2UserName="" />
</#if>

<#if pibStakeholderList?? &&  pibStakeholderList.agencyContact3?? && pibStakeholderList.agencyContact3 &gt; 0>
<#--<#assign agency3UserName = jiveContext.getSpringBean("userManager").getUser(pibStakeholderList.agencyContact3).getName() />-->
    <#assign agency3UserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact3) />
<input type="hidden" name="agencyContact3" value="${pibStakeholderList.agencyContact3?c}">
<#else>
    <#assign agency3UserName="" />
</#if>

<#if pibStakeholderList?? &&  pibStakeholderList.globalLegalContact?? && pibStakeholderList.globalLegalContact &gt; 0>
<#--<#assign globalLegalContactUserName = jiveContext.getSpringBean("userManager").getUser(pibStakeholderList.globalLegalContact).getName() />-->
    <#assign globalLegalContactUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.globalLegalContact) />
<input type="hidden" name="globalLegalContact" value="${pibStakeholderList.globalLegalContact?c}">
<#else>
    <#assign globalLegalContactUserName="" />
</#if>

<#if pibStakeholderList?? &&  pibStakeholderList.globalProcurementContact?? && pibStakeholderList.globalProcurementContact &gt; 0>
<#--<#assign globalProcurementContactUserName = jiveContext.getSpringBean("userManager").getUser(pibStakeholderList.globalProcurementContact).getName() />-->
    <#assign globalProcurementContactUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.globalProcurementContact) />
<input type="hidden" name="globalProcurementContact" value="${pibStakeholderList.globalProcurementContact?c}">
<#else>
    <#assign globalProcurementContactUserName="" />
</#if>

<#if pibStakeholderList?? &&  pibStakeholderList.productContact?? && pibStakeholderList.productContact &gt; 0>
    <#assign productContactUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.productContact) />
	<input type="hidden" name="productContact" value="${pibStakeholderList.productContact?c}">
<#else>
    <#assign productContactUserName="" />
</#if>

<#if pibStakeholderList?? &&  pibStakeholderList.globalCommunicationAgency?? && pibStakeholderList.globalCommunicationAgency &gt; 0>
<#--<#assign globalCommunicationAgencyUserName = jiveContext.getSpringBean("userManager").getUser(pibStakeholderList.globalCommunicationAgency).getName() />-->
    <#assign globalCommunicationAgencyUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.globalCommunicationAgency) />
<input type="hidden" name="globalCommunicationAgency" value="${pibStakeholderList.globalCommunicationAgency?c}">
<#else>
    <#assign globalCommunicationAgencyUserName="" />
</#if>

<div class="ld-div">

	<#--<i style="color:black">(Please make your selection)</i></br> -->
	<#if projectInitiation.nonKantar?? && projectInitiation.nonKantar==1>
		<#--<input type="checkbox" name="nonKantar" id="nonKantar" disabled value="true" checked="true"  />&nbsp;&nbsp;Non-Kantar<br><i style="color:red">(Please select the checkbox for Non-Kantar related projects)</i>-->
		 <input type="radio" name="kantar" id="kantar" value="true" disabled checked="true" />&nbsp;&nbsp;Kantar
		 <br/>
		 <input type="radio" name="nonKantar" id="nonKantar" value="false" disabled style="float:left;margin-top:8px;" checked="false" /><label style="float:left;" >&nbsp;&nbsp;Non-Kantar</label>
		 <script type="text/javascript">
		 
               $j("input[name=nonKantar]").removeAttr('checked');
       	 </script>
	<#elseif projectInitiation.nonKantar?? && projectInitiation.nonKantar==2>
		<#-- <input type="checkbox" name="nonKantar" id="nonKantar" onclick="changeAgencyUsers();" value="false"  />&nbsp;&nbsp;Non-Kantar<br><i style="color:red">(Please select the checkbox for Non-Kantar related projects)</i>-->
		
		 <input type="radio" name="kantar" id="kantar" value="true"  disabled checked="false" />&nbsp;&nbsp;Kantar
		 <br/>
		 <input type="radio" name="nonKantar" id="nonKantar" value="false"  style="float:left;margin-top:8px;" disabled checked="true" /><label style="float:left;" >&nbsp;&nbsp;Non-Kantar</label> 
		  <script type="text/javascript">
		 
               $j("input[name=kantar]").removeAttr('checked');
       	 </script>
	<#else>
		 <input type="radio" name="kantar" id="kantar" value="true"  disabled checked="false" />&nbsp;&nbsp;Kantar
		 <br/>
		 <input type="radio" name="nonKantar" id="nonKantar" value="false" disabled style="float:left;margin-top:8px;" checked="false" /><label style="float:left;" >&nbsp;&nbsp;Non-Kantar</label>
		
		 <script type="text/javascript">
		 
               $j("input[name=nonKantar]").removeAttr('checked'); 
             <#--  $j("input[name=kantar]").removeAttr('checked'); -->

    	 </script>
	</#if>

	 <script type="text/javascript">
                var initiateKantarWaiverWindow = null;
                $j(document).ready(function(){
                    initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request Waiver for using Non-Kantar Agency',confirmOnClose:false});
                    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#kantar-waiver-form"), projectID:${projectID?c}});
                });

     </script>
     
   
        <ul class="right-sidebar-list" style="float:right;margin: -20px 0 0px 0;">
        	
             <li id="initiateKantarWaiverButton" <#if !(projectInitiation.nonKantar?? && projectInitiation.nonKantar==2)>style="display:none"</#if>><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Initiate a Waiver</#if></a></li>
        </ul>
		
		  <#if projectInitiation.nonKantar??&& projectInitiation.nonKantar==2 && pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>
	        <div class="form-select_div select-div methodology-status" id="nonKantarWaiverStatus">
	            <label>Status of Waiver</label>
	            <#if pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
	                <span>Approved</span>
	            <#elseif pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
	                <span>Rejected</span>
	            <#else>
	                <span>Pending</span>
	            </#if>
	            <br/>
	        </div>
	    </#if>
    
    <div id="kantarMessage" class="jive-error-box" <#if !(projectInitiation.nonKantar?? && projectInitiation.nonKantar==2)>style="display:none; width:748px; margin: 20px 0 0 0px; background:lightgreen;" <#else> style="width:748px; margin: 20px 0 0 0px; background:lightgreen;"</#if>>
    	Please get a waiver approved for using a Non-Kantar Agency. For the process to move forward kindly raise a waiver and add a BAT contact as your Agency Contact.
   	</div>


    <!-- DETAILED STAKEHOLDER LIST STARTS -->
<#if !(isExternalAgencyUser || isCommAgencyUser) >
    <h3 class="pib_sub_heading">Detailed Stakeholder List</h3>
    <div class="pib_detail_st_list">
        <div class="form-select_div">
            <label>BAT Contact</label>
            <ul>
                <li>
                    <span class="view_nums">1.</span> <input type="text" name="ag1" id="ag1"  value="${agency1UserName}" disabled />
                </li>
              <#--  <li class="optional-field">
                    <span class="view_nums">2.</span><input type="text" name="ag2" id="ag2"  value="${agency2UserName}" disabled />
                    <span  class="jive-field-message">(Optional)</span>
                </li>
                <li class="optional-field">
                    <span class="view_nums">3.</span><input type="text" name="ag3" id="ag3"  value="${agency3UserName}" disabled />
                    <span  class="jive-field-message">(Optional)</span>
              -->
            </ul>
        </div>

    </div>

    <div class="pib_detail_st_list">

        <div class="form-select_div">
            <label>Legal Contact</label>
            <ul>
                <li class="view_field_row">
                    <input type="text" name="gl" id="gl"  value="${globalLegalContactUserName}" disabled />
                </li>
            </ul>
        </div>
		<div class="form-select_div">
            <label>Product Contact</label>
            <ul>
                <li class="view_field_row">
                    <input type="text" name="gpr" id="gpr"  value="${productContactUserName}" disabled />
                    <span  class="jive-field-message">(Mandatory for all the product tests)</span>
                </li>

            </ul>
        </div>
        <div class="form-select_div">
            <label>Procurement Contact</label>
            <ul>
                <li class="view_field_row">
                    <input type="text" name="gp" id="gp"  value="${globalProcurementContactUserName}" disabled />
                    <span  class="jive-field-message">(Optional)</span>
                </li>

            </ul>
        </div>
        <div class="form-select_div">
            <label>Communication Agency</label>
            <ul>
                <li class="view_field_row">
                    <input type="text" name="gc" id="gc"  value="${globalCommunicationAgencyUserName}" disabled />
                    <span  class="jive-field-message">(Optional)</span>
                </li>

            </ul>
        </div>
        
        <div class="form-select_div">
            <label>Other BAT</label>
            <ul>
                <li class="view_field_row">
                    <input type="text" name="gc" id="gc"  value="${otherBATUsers?default('')}" disabled />
                </li>

            </ul>
        </div>
    </div>
</#if>
    <!-- DETAILED STAKEHOLDER LIST ENDS -->

</div>

</div>
<!-- BEGIN sidebar column -->
<div id="jive-body-sidebarcol-container" class="j-column j-column-s j-content-extras">
<#include "/template/docs/synchro-doc-sidebar.ftl" />
</div>
<!-- END sidebar column -->
</form>

<script type="text/javascript">
function showInitiateWaiverWindow()
{
	initiateWaiverWindow.show();	
	setTimeout(
	function() 
	{
		$j("textarea").each(function(i) {
			var textHeight = $j(this)[0].scrollHeight;
			var textboxHeight = $j(this).height();		
			  if (this.clientHeight < this.scrollHeight) {
				$j(this).height( $j(this)[0].scrollHeight-10);
			  }
			  else
			  {
				var DEFAULT_VALUES = ["Enter text and/or attach documents"];
				if($j(this).val()!=null && $j.trim($j(this).val())!="" && !contains(DEFAULT_VALUES, $j.trim($j(this).val())))
				{
					$j(this).height(0);
					var scrollval = $j(this)[0].scrollHeight-10;
					$j(this).height(scrollval);
				}		
			  }	
			  $j(this).elastic();
			  
		});
	}, 400);	
}
</script>

<script type="text/javascript">
<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.pib.view.text" /></#assign>	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PIB.getId()}, "${i18CustomText}", "${project.name}", ${projectID?c}, ${user.ID?c});
</script>
