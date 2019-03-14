<form name="project-Specs" id="project-specs-form" action="/synchro/project-specs!execute.jspa" method="POST" name="form-create" class="research_pib pib" >
<div class="research_content">
<input type="hidden" name="projectID" value="${projectID?c}">

<input type="hidden" name="isSave" value="${save?string}">
<div class="pib_inner_main">
    <div class="pib_left">
       
       <#--
        <div class="form-text_div">
            <label>Project Code</label>
            <input type="text" name="projectID" value="${project.projectID?c}" class="form-text-div" disabled="true">
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
        <@renderBrandField name='brand' value=projectSpecsInitiation.brand?default('-1') readonly=true/>
        <#assign error_msg><@s.text name='project.error.brand' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>



        <div class="pib-select_div">
            <label>Country</label>
        <@renderEndMarketSingleSelectFld name='updatedSingleMarketId' value=projSpecsEndMarketId?default('-1') disabled=true/>
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
            <input type="text" name="briefCreator" id="briefCreator"  value="${spiContactName}" disabled />
        </div>

   
        <div class="form-date_div">
            <label>Project Start (Commissioning)</label>
            <input type="text" name="startDate" id="startDate"  value="<#if projectSpecsInitiation.startDate?? >${projectSpecsInitiation.startDate?string('dd/MM/yyyy')}</#if>" disabled />
        </div>

        <div class="form-date_div">
            <label>Project End <br/>(Results)</label>
            <input type="text" name="endDate" id="endDate"  value="<#if projectSpecsInitiation.endDate?? >${projectSpecsInitiation.endDate?string('dd/MM/yyyy')}</#if>" disabled />
        </div>
    </div>

    <div class="pib_right">
        <h3 class="pib_right_heading">Other Information</h3>


        <div class="region-inner">

            <label>Category Type</label>

        
        <#if projectSpecsInitiation.categoryType?? && projectSpecsInitiation.categoryType?size gt 0 >
    		<@renderAllSelectedCategoryTypeField name='categoryType' value=projectSpecsInitiation.categoryType?default(-1) readonly=true />
    	<#else>
    		<@renderAllSelectedCategoryTypeField name='categoryType' value=project.categoryType?default(-1) readonly=true />
    	</#if>	
        <#assign error_msg><@s.text name='project.error.category' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>

        <div class="form-select_div">
            <label><@s.text name="project.initiate.project.methodology"/></label>
        <@renderMethodologyField name='methodologyType' value=projectSpecsInitiation.methodologyType?default('-1') readonly=true/>
        <#assign error_msg><@s.text name='project.error.methodology' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>
        <div class="form-select_div">
            <label><@s.text name="project.initiate.project.methodologygroup"/></label>
        <@renderMethodologyGroupField name='methodologyGroup' value=projectSpecsInitiation.methodologyGroup?default('-1') readonly=true/>
        <#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>
       <div class="region-inner proposed-region">
			<label><@s.text name="project.initiate.project.methodologyproposed"/></label>
			<#assign defaultPMethodologyID = JiveGlobals.getJiveIntProperty("grail.synchro.default.proposedmethodology", -1) />
			<@displayProposedMethodologyMultiSelect name='proposedMethodology' value=projectSpecsInitiation.proposedMethodology?default([defaultPMethodologyID]) />				
		</div>

<#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
    <#if !isExternalAgencyUser && !synchroPermHelper.isExternalAgencyUser(user) && !projectContactHasReadonlyAccess && !isCommunicationAgencyAdminUser && !synchroPermHelper.isSynchroCommunicationAgencyAdmin()>
        <div class="form-text_div pib_initial_cost">
            <label>Estimated Cost</label>
            <input type="text" name="name" value="${endMarketDetails.get(0).initialCost}" size="30" class="form-text-div numericfield numericformat" disabled="true">
            <@renderCurrenciesField name='estimatedCostType' value=endMarketDetails.get(0).initialCostCurrency?default(defaultCurrency) disabled=true/>
        </div>

        <div class="form-text_div pib_initial_cost">
            <label>Latest Estimate</label>
            <input type="text" name="latestEstimate-display" disabled <#if projectInitiation.latestEstimate?? > value="${projectInitiation.latestEstimate}" <#else> value="" </#if> size="30" class="form-text-div numericfield numericformat" >
            <@renderCurrenciesField name='latestEstimateType' value=projectInitiation.latestEstimateType?default(defaultCurrency) disabled=true/>
        </div>
    </#if>
    
    <#if !(isCommunicationAgencyAdminUser || synchroPermHelper.isSynchroCommunicationAgencyAdmin()) >
        <div class="form-text_div pib_initial_cost">
            <label>Final Cost</label>
            <input type="text" name="finalCostTotal" disabled <#if projectSpecsEMDetails.finalCost?? > value="${projectSpecsEMDetails.finalCost}" <#else> value="" </#if> size="30" class="form-text-div" title="If the project has a fieldwork tendering process then the final cost does not include the fieldwork cost">
        <@renderCurrenciesField name='finalCostTypeTotal' value=projectSpecsEMDetails.finalCostType?default(defaultCurrency) disabled=true/>
        </div>
	</#if>
	
        <div class="form-text_div npi-number">
            <label>NPI Number <br/>(if appropriate)</label>
            <input type="text" name="npiReferenceNo" disabled value="${projectSpecsInitiation.npiReferenceNo?default('')?html}" size="30" class="form-text-div" >
        </div>

        <div class="form-select_div select-div">
            <label>Request for Methodology Waiver</label>
            <select name="deviationFromSM" id="deviationFromSM" class="form-select" onchange="checkMethDeviation()" disabled>
                <option value="1" <#if projectSpecsInitiation.deviationFromSM?? && projectSpecsInitiation.deviationFromSM==1 > selected </#if>>Yes</option>
                <option value="0" <#if projectSpecsInitiation.deviationFromSM?? && projectSpecsInitiation.deviationFromSM==0 > selected </#if>>No</option>
            </select>

            <script type="text/javascript">
                var initiateWaiverWindow = null;
                $j(document).ready(function(){
                    initiateWaiverWindow = new LIGHT_BOX($j("#initiateWaiver"),{title:'Request for Methodology Waiver'})
                });

            </script>

        <#assign showWaiverBtn = 'none' />
        <#if projectSpecsInitiation.deviationFromSM?? && projectSpecsInitiation.deviationFromSM==1>
            <#assign showWaiverBtn = 'block' />
        </#if>

            <ul class="right-sidebar-list">
                <li id="initiateWaiverButton" style='display:${showWaiverBtn?string}'><a onclick="javascript:showInitiateWaiverWindow();" href="javascript:void(0);"><#if pibMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Initiate a Waiver</#if></a></li>
            </ul>
        </div>
		<#if projectSpecsInitiation.deviationFromSM?? && projectSpecsInitiation.deviationFromSM==1>
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

        <div class="form-text_div po-number">
            <label>PO Number</label>
            <input type="text" name="poNumber" disabled value="${projectSpecsInitiation.poNumber?default('')?html}" size="30" class="form-text-div numericfield nonformatfield" >
        </div>

        <div class="form-text_div po-number">
            <label>PO Number</label>
            <input type="text" id="poNumber1" name="poNumber1" disabled value="${projectSpecsInitiation.poNumber1?default('')?html}" size="30" class="form-text-div nonformatfield" >

            <span id="poNumber1_msg" style="display: none;" class="jive-error-message multiple-po-num">In case of multiple POs use a comma separated list.</span>
            <script type="text/javascript">
                $j(document).ready(function(){
                    $j("#poNumber1").focusin(function(){
                        $j("#poNumber1_msg").show();
                    });

                    $j("#poNumber1").focusout(function(){
                        $j("#poNumber1_msg").hide();
                    });
                });
            </script>
        </div>
    </div>
</div>

<div class="region-inner">
<label class='rte-editor-label'>Project Description</label>
    <div class="form-text_div">
		<textarea id="description" name="description" disabled rows="15" cols="30" >${projectSpecsInitiation.description?default('')?html}</textarea>
    </div>   
</div>


<div class="region-inner">
	<label class='rte-editor-label'>Business Question</label>
    <div class="form-text_div">        
        <textarea id="bizQuestion" name="bizQuestion" disabled rows="10" cols="20" class="form-text-div">${projectSpecsInitiation.bizQuestion?default('')?html}</textarea>
    </div>
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
	<label class='rte-editor-label'>Research Objectives(s)</label>
    <div class="form-text_div">        
        <textarea id="researchObjective" name="researchObjective" disabled rows="10" cols="20" class="form-text-div">${projectSpecsInitiation.researchObjective?default('')?html}</textarea>
    </div>
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
    </div>
    <!-- ATTACHMENT DISPLAY ENDS -->
</div>


<div class="region-inner">
	<label class='rte-editor-label'>Action Standard(s)</label>
    <div class="form-text_div">        
        <textarea id="actionStandard" name="actionStandard" disabled rows="10" cols="20" class="form-text-div">${projectSpecsInitiation.actionStandard?default('')?html}</textarea>
    </div>
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
        <textarea id="researchDesign" name="researchDesign" rows="10" disabled cols="20" class="form-text-div form-text-div-large">${projectSpecsInitiation.researchDesign?default('')?html}</textarea>
    </div>
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
        <textarea id="sampleProfile" name="sampleProfile" rows="10" cols="20" disabled class="form-text-div">${projectSpecsInitiation.sampleProfile?default('')?html}</textarea>
    </div>
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
        <textarea id="stimulusMaterial" name="stimulusMaterial" rows="10" cols="20" disabled class="form-text-div">${projectSpecsInitiation.stimulusMaterial?default('')?html}</textarea>
    </div>
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
	<label class='rte-editor-label'>Stimulus Material to be shipped to</label>
    <div class="form-text_div">        
        <textarea id="stimulusMaterialShipped" name="stimulusMaterialShipped" rows="10" cols="20" disabled class="form-text-div">${projectSpecsInitiation.stimulusMaterialShipped?default('')?html}</textarea>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#if attachmentMap?? && attachmentMap.get(stimulusMaterialShippedID)?? >
        <div id="jive-file-list" class="jive-attachments">
            <#list attachmentMap.get(stimulusMaterialShippedID) as attachment>
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
        <textarea id="others" name="others" rows="10" cols="20" class="form-text-div" disabled>${projectSpecsInitiation.others?default('')?html}</textarea>
    </div>
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
        <input type="text" name="stimuliDate" id="stimuliDate"  value="<#if projectSpecsInitiation.stimuliDate?? >${projectSpecsInitiation.stimuliDate?string('dd/MM/yyyy')}</#if>" disabled />

    </div>
</div>

<div class="pib-report-requirement">
    <label>Reporting Requirement</label>
    <table class="report_requirement_list">
        <tbody>
        <tr>
            <td><@renderCheckBox label='' name='topLinePresentation' isChecked=projectSpecsReporting.topLinePresentation?default(false) disable=true /></td>
            <td class="view-row-first">Top Line Presentation</td>
        </tr>
        <tr class="color-row">
            <td><@renderCheckBox label='' name='presentation' isChecked=projectSpecsReporting.presentation?default(false) disable=true /></td>
            <td class="view-row-first">Presentation</td>
        </tr>
        <tr>
            <td><@renderCheckBox label='' name='fullreport' isChecked=projectSpecsReporting.fullreport?default(false) disable=true /></td>
            <td class="view-row-first">Full Report</td>
        </tr>

        </tbody>
    </table>
</div>

<div class="region-inner">
	<label class='rte-editor-label'>Other Reporting Requirements</label>
    <div class="form-text_div">        
        <textarea id="otherReportingRequirements" name="otherReportingRequirements" rows="10" disabled cols="20" class="form-text-div">${projectSpecsReporting.otherReportingRequirements?default('')?html}</textarea>
    </div>
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

<div class="region-inner">
	<label class='rte-editor-label'>Screener</label>
    <div class="form-text_div">        
        <textarea id="screener" name="screener" rows="10" cols="20" disabled class="form-text-div form-text-div-small" >${projectSpecsInitiation.screener?default('Enter text and/or attach documents')?html}</textarea>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#if attachmentMap?? && attachmentMap.get(screenerID)?? >
        <div id="jive-file-list" class="jive-attachments">
            <#list attachmentMap.get(screenerID) as attachment>
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
	<label class='rte-editor-label'>Consumer Contract and Confidentiality Agreement</label>
    <div class="form-text_div">        
        <textarea id="consumerCCAgreement" name="consumerCCAgreement" disabled rows="10" cols="20" class="form-text-div form-text-div-small">${projectSpecsInitiation.consumerCCAgreement?default('Enter text and/or attach documents')?html}</textarea>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#if attachmentMap?? && attachmentMap.get(cccAgreementID)?? >
        <div id="jive-file-list" class="jive-attachments">
            <#list attachmentMap.get(cccAgreementID) as attachment>
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
	<label class='rte-editor-label'>Questionnaire/Discussion guide</label>
    <div class="form-text_div">        
        <textarea id="questionnaire" name="questionnaire" rows="10" cols="20" disabled class="form-text-div form-text-div-small" >${projectSpecsInitiation.questionnaire?default('Enter text and/or attach documents')?html}</textarea>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#if attachmentMap?? && attachmentMap.get(questionnaireID)?? >
        <div id="jive-file-list" class="jive-attachments">
            <#list attachmentMap.get(questionnaireID) as attachment>
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
	<label class='rte-editor-label'>Actual Stimulus Material</label>
    <div class="form-text_div">        
        <textarea id="discussionguide" name="discussionguide" rows="10" cols="20" disabled class="form-text-div form-text-div-small">${projectSpecsInitiation.discussionguide?default('Enter text and/or attach documents')?html}</textarea>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#if attachmentMap?? && attachmentMap.get(discussionGuideID)?? >
        <div id="jive-file-list" class="jive-attachments">
            <#list attachmentMap.get(discussionGuideID) as attachment>
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



<!-- END MARKET FIELDS STARTS -->
<div class="end_market_details" style="display:block;">
<#--	<#list endMarketDetails as endMarketDetail> -->
<#assign emid = projSpecsEndMarketId />
    <div class="">
        <h3 id="block_header_${emid}" onclick="javascript:toggleEndmarketBlock(${emid});">${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emid?int)}
            <a id="legend_${emid}" href="javascript:void(0);" class="close-form"></a>
        </h3>
        <div id="endMarket_${emid}" class="pib_angola" >
            <div class="pib_angola_left">
                <div class="form-select_div">
                <p class="induction_text">If any of fields are not relevant, please put '0' in it.</p>
                    <label>Total Cost</label>
                    <input type="text" name="totalCost" <#if projectSpecsEMDetails.totalCost?? > value="${projectSpecsEMDetails.totalCost?default('')}" <#else> value="" </#if>  disabled class="form-text-div" >
                <@renderCurrenciesField name='totalCostType' value=projectSpecsEMDetails.totalCostType?default(defaultCurrency) disabled=true/>
                <@macroCustomFieldErrors msg="Please enter Total Cost and Currency"/>

                </div>
            <#if projectSpecsInitiation.methodologyType!=4 >
                <div class="form-select_div">
                    <label>International Management Cost - Research Hub Cost</label>
                    <input type="text" name="intMgmtCost" <#if projectSpecsEMDetails.intMgmtCost?? > value="${projectSpecsEMDetails.intMgmtCost?default('')}" <#else> value="" </#if> disabled class="form-text-div" >
                    <@renderCurrenciesField name='intMgmtCostType' value=projectSpecsEMDetails.intMgmtCostType?default(defaultCurrency) disabled=true />
                    <@macroCustomFieldErrors msg="Please enter Internation Management Cost and Currency"/>
                </div>
                <div class="form-select_div">
                    <label>Local Management Cost</label>
                    <input type="text" name="localMgmtCost" <#if projectSpecsEMDetails.localMgmtCost?? > value="${projectSpecsEMDetails.localMgmtCost?default('')}" <#else> value="" </#if> disabled class="form-text-div" >
                    <@renderCurrenciesField name='localMgmtCostType' value=projectSpecsEMDetails.localMgmtCostType?default(defaultCurrency) disabled=true />
                    <@macroCustomFieldErrors msg="Please enter Local Management Cost and Currency"/>
                </div>

                <div class="form-select_div">
                    <label>Fieldwork Cost</label>
                    <input type="text" name="fieldworkCost" <#if projectSpecsEMDetails.fieldworkCost??  > value="${projectSpecsEMDetails.fieldworkCost?default('')}" <#else> value="" </#if> disabled class="form-text-div" >
                    <@renderCurrenciesField name='fieldworkCostType' value=projectSpecsEMDetails.fieldworkCostType?default(defaultCurrency) disabled=true />
                    <@macroCustomFieldErrors msg="Please enter Fieldwork Cost and Currency"/>
                </div>
                 
				<div class="form-select_div">
                    <label>Operational Hub Cost</label>
                    <input type="text" name="operationalHubCost" <#if projectSpecsEMDetails.operationalHubCost??  > value="${projectSpecsEMDetails.operationalHubCost?default('')}" <#else> value="" </#if> disabled class="form-text-div" >
                    <@renderCurrenciesField name='operationalHubCostType' value=projectSpecsEMDetails.operationalHubCostType?default(defaultCurrency) disabled=true />
                    <@macroCustomFieldErrors msg="Please enter Operational Hub Cost"/>
                </div>
				
                 <div class="form-select_div">
                    <label>Other Cost</label>
                    <input type="text" name="otherCost" <#if projectSpecsEMDetails.otherCost??  > value="${projectSpecsEMDetails.otherCost?default('')}" <#else> value="" </#if> disabled class="form-text-div" >
                    <@renderCurrenciesField name='otherCostType' value=projectSpecsEMDetails.otherCostType?default(defaultCurrency) disabled=true />
                    <@macroCustomFieldErrors msg="Please enter Other Cost and Currency"/>
                </div>
                
             
                <div class="form-text_div">
                    <label>Name of Proposed Fieldwork Agencies</label>
                    <input type="text" name="proposedFWAgencyNames" value="${projectSpecsEMDetails.proposedFWAgencyNames?default('')}" disabled class="form-text-div" >
                    <@macroCustomFieldErrors msg="Please enter Proposed Fieldwork Agencies"/>
                </div>
                <div class="form-text_div">
                    <label>Estimated Fieldwork Start</label>
                    <input type="text" name="fwStartDate" value="<#if projectSpecsEMDetails.fwStartDate?? >${projectSpecsEMDetails.fwStartDate?string('dd/MM/yyyy')}</#if>" disabled class="form-text-div" >
                </div>
                <div class="form-text_div">
                    <label>Estimated Fieldwork Completion</label>
                    <input type="text" name="fwEndDate" value="<#if projectSpecsEMDetails.fwEndDate?? >${projectSpecsEMDetails.fwEndDate?string('dd/MM/yyyy')}</#if>" disabled class="form-text-div" >
                </div>
                <div class="region-inner">
                    <label>Data Collection Methods</label>
                    <#assign dataCollectionIndex = emid?c/>
                    <@renderDataCollectionSelected name='dataCollectionMethod' value=projectSpecsEMDetails.dataCollectionMethod?default('-1') multiselect=true class='form-multi-select' readonly=true id='dataCollectionMethod' />
                    <@macroFieldErrors name="collectionMethod"/>

                </div>
            </#if>
            </div>
            <div class="pib-qualitative">
            <#if projectSpecsInitiation.methodologyType==1 || projectSpecsInitiation.methodologyType==3 >
                <h2 class="pib_sub_heading">Quantitative</h2>
                <p class="induction_text">(If any of fields are not relevant, please put '0' in it.)</p>
                <ul>
                    <li>
                        <div class="form-text_div">
                            <label>Total Number of Interviews</label>
                            <input type="text" name="totalNoInterviews" <#if projectSpecsEMDetails.totalNoInterviews?? && projectSpecsEMDetails.totalNoInterviews gt -1 > value="${projectSpecsEMDetails.totalNoInterviews?c}" <#else> value="" </#if> disabled class="form-text-div" >
                            <@macroCustomFieldErrors msg="Please enter Total number of Interviews"/>
                        </div>
                    </li>
                    <li>
                        <div class="form-text_div">
                            <label>Total Number of Visits per Respondent</label>
                            <input type="text" name="totalNoOfVisits" <#if projectSpecsEMDetails.totalNoOfVisits?? && projectSpecsEMDetails.totalNoOfVisits gt -1 > value="${projectSpecsEMDetails.totalNoOfVisits?c}" <#else> value="" </#if> disabled class="form-text-div" >
                            <@macroCustomFieldErrors msg="Please enter Total no of visits per respondent"/>
                        </div>
                    </li>
                    <li>
                        <div class="form-text_div">
                            <label>Average Interview Duration (in minutes)</label>
                            <input type="text" name="avIntDuration" <#if projectSpecsEMDetails.avIntDuration?? && projectSpecsEMDetails.avIntDuration gt -1 > value="${projectSpecsEMDetails.avIntDuration?c}" <#else> value="" </#if> disabled class="form-text-div" >
                            <@macroCustomFieldErrors msg="Please enter Average Interview Duration"/>
                        </div>
                    </li>
                </ul>
                
                <#assign geographical_spread_display = 'none' />
            <#if projectSpecsInitiation.methodologyType==1 || projectSpecsInitiation.methodologyType==3 >
                <#assign geographical_spread_display = 'block' />
            </#if>
                <div id="geographical_spread_div" style="display:${geographical_spread_display};">
                    <div class="pib-report-requirement">
                        <label>Geographical Spread</label>
                        <table class="report_requirement_list">
                            <tbody>
                            <tr>

                                <td><@renderRadioBox label='' name='geoSpread' id='geoSpreadNational' value='geoSpreadNational' isChecked=projectSpecsEMDetails.geoSpreadNational?default(false) disable=true/></td>
                                <td class="view-row-first">National</td>
                            </tr>
                            <tr class="color-row">

                                <td><@renderRadioBox label=''  name='geoSpread' id='geoSpreadUrban' value='geoSpreadUrban' isChecked=projectSpecsEMDetails.geoSpreadUrban?default(false) disable=true/></td>
                                <td class="view-row-first">Non-National</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            <#--  Display cities section only when the Gerographical spread is Urban -->

                <div class="form-text_div" id="cities">
                    <label>Please Define Geography</label>
                    <input type="text" name="cities"  value="${projectSpecsEMDetails.cities?default('')}" disabled class="form-text-div" >
                </div>
                
            </#if>

            <#if projectSpecsInitiation.methodologyType==2 || projectSpecsInitiation.methodologyType==3 >
                <h2 class="pib_sub_heading">Qualitative</h2>
                <p class="induction_text">(If any of fields are not relevant, please put '0' in it.)</p>
                <div class="form-text_div">
                    <label>Total No of Groups/In-Depth Interviews</label>
                    <input type="text" name="totalNoOfGroups" <#if projectSpecsEMDetails.totalNoOfGroups?? && projectSpecsEMDetails.totalNoOfGroups gt -1 > value="${projectSpecsEMDetails.totalNoOfGroups?c}" <#else> value="" </#if> disabled class="form-text-div" >
                    <@macroCustomFieldErrors msg="Please enter Total No of Groups"/>
                </div>
                <div class="form-text_div">
                    <label>Group/In-Interview Duration (in minutes)</label>
                    <input type="text" name="interviewDuration" <#if projectSpecsEMDetails.interviewDuration?? && projectSpecsEMDetails.interviewDuration gt -1 > value="${projectSpecsEMDetails.interviewDuration?c}" <#else> value="" </#if> disabled class="form-text-div" >
                    <@macroCustomFieldErrors msg="Please enter Group/In-Interview Duration"/>
                </div>
                <div class="form-text_div">
                    <label>Number of Respondents per Group</label>
                    <input type="text" name="noOfRespPerGroup" <#if projectSpecsEMDetails.noOfRespPerGroup?? && projectSpecsEMDetails.noOfRespPerGroup gt -1 > value="${projectSpecsEMDetails.noOfRespPerGroup?c}" <#else> value="" </#if> disabled class="form-text-div" >
                    <@macroCustomFieldErrors msg="Please enter Number of Respondents per Group"/>
                </div>
            </#if>

            

            </div>
        </div>
    </div>
    <script type="text/javascript">
        $j(document).ready(function() {
            $j("#addDataCollectionBtn_"+${emid}).click();
        <#if projectSpecsEMDetails.geoSpreadUrban?? && projectSpecsEMDetails.geoSpreadUrban >
            $j("#cities").show();
        <#else>
            $j("#cities").hide();
        </#if>
        });
    </script>
<#--  </#list> -->
</div>
<!-- END MARKET FIELDS ENDS -->

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