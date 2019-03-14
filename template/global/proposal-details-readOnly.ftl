
<form name="proposal" id="proposal-form" action="/synchro/proposal-details!execute.jspa" method="POST" name="form-create" class="research_pib pib" >
<div class="research_content">
<input type="hidden" name="projectID" value="${projectID?c}">

<input type="hidden" name="isSave" value="${save?string}">
<input type="hidden" name="agencyID" value="${agencyID?c}">

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
        <@renderBrandField name='brand' value=proposalInitiation.brand?default('-1') readonly=true/>
        <#assign error_msg><@s.text name='project.error.brand' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>



        <div class="pib-select_div">
            <label>Country</label>
        <@renderEndMarketSingleSelectFld name='updatedSingleMarketId' value=proposalEndMarketId?default('-1') disabled=true/>
        <#assign error_msg><@s.text name='project.error.endmarket' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>

        <div class="project_owner_names">
            <label>Project Owner</label>
        <#if project.projectOwner &gt; 0>
            <#assign ownerUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner) />
        <#else>
            <#assign ownerUserName="" />
        </#if>
            <input type="text" name="projectOwnerRead" id="projectOwnerRead"  value="${ownerUserName}" disabled="disabled" />
        </div>

        <div class="project_owner_brief">
            <label>PIT Creator</label>

        <#if project.briefCreator &gt; 0>
        <#--<#assign briefCreatorName = jiveContext.getSpringBean("userManager").getUser(project.briefCreator).getName() />-->
            <#assign briefCreatorName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.briefCreator) />
        <#else>
            <#assign briefCreatorName="" />
        </#if>
            <input type="text" name="briefCreator" id="briefCreator"  value="${briefCreatorName}" disabled="disabled" />

        </div>

        <div class="project_owner_contact">
            <label>SP&I Contact</label>
        <#assign spiContact = endMarketDetails.get(0).getSpiContact() />
        <#if spiContact &gt; 0>
            <#assign spiContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(spiContact) />
        <#else>
            <#assign spiContactName="" />
        </#if>
            <input type="text" name="briefCreator" id="briefCreator"  value="${spiContactName}" disabled="disabled" />
        </div>
        
        <div class="form-date_div">
            <label>Estimated Project Start</label>
            <input type="text" name="startDate" id="startDate"  value="<#if proposalInitiation.startDate?? >${proposalInitiation.startDate?string('dd/MM/yyyy')}</#if>" disabled="disabled" />
        </div>

        <div class="form-date_div">
            <label>Estimated Project End</label>
            <input type="text" name="endDate" id="endDate"  value="<#if proposalInitiation.endDate?? >${proposalInitiation.endDate?string('dd/MM/yyyy')}</#if>" disabled="disabled" />
        </div>
    </div>

    <div class="pib_right">
        <h3 class="pib_right_heading">Other Information</h3>



        <div class="region-inner">

            <label>Category Type</label>

        <@renderAllSelectedCategoryTypeField name='categoryType' value=project.categoryType?default(-1) readonly=true/>
        <#assign error_msg><@s.text name='project.error.category' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>

        <div class="form-select_div">
            <label><@s.text name="project.initiate.project.methodology"/></label>
        <@renderMethodologyField name='methodologyType' value=proposalInitiation.methodologyType?default('-1')  readonly=true/>
        <#assign error_msg><@s.text name='project.error.methodology' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>
        <div class="form-select_div">
            <label><@s.text name="project.initiate.project.methodologygroup"/></label>
        <@renderMethodologyGroupField name='methodologyGroup' value=proposalInitiation.methodologyGroup?default('-1')  readonly=true/>
        <#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>

		<div class="region-inner proposed-region">
			<label><@s.text name="project.initiate.project.methodologyproposed"/></label>
			<#assign defaultPMethodologyID = JiveGlobals.getJiveIntProperty("grail.synchro.default.proposedmethodology", -1) />
			<@displayProposedMethodologyMultiSelect name='proposedMethodology' value=proposalInitiation.proposedMethodology?default([defaultPMethodologyID]) />				
		</div>
			
        <div class="form-text_div npi-number">
            <label>NPI Number <br/>(if appropriate)</label>
        <#if proposalInitiation.npiReferenceNo?? && !proposalInitiation.npiReferenceNo.equals("") >
            <input type="text" name="npiReferenceNo" value="${proposalInitiation.npiReferenceNo?default('')?html}" size="30" class="form-text-div numericfield" disabled="disabled">
        <#else>
            <input type="text" name="npiReferenceNo" value="${projectInitiation.npiReferenceNo?default('')?html}" size="30" class="form-text-div numericfield" disabled="disabled">
        </#if>
        </div>

        <div class="form-select_div select-div">
            <label>Request for Methodology Waiver</label>
            <select name="deviationFromSM" id="deviationFromSM" class="form-select" onchange="checkMethDeviation()" disabled="disabled">
                <option value="1" <#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==1 > selected </#if>>Yes</option>
                <option value="0" <#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==0 > selected </#if>>No</option>
            </select>
        </div>
		<#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==1>
			<div class="form-select_div select-div methodology-status">
				<label>Status of Waiver</label>
				<#if proposalMethodologyWaiver?? && proposalMethodologyWaiver.isApproved?? && proposalMethodologyWaiver.isApproved==1>
					<span>Approved</span>
				<#elseif proposalMethodologyWaiver?? && proposalMethodologyWaiver.isApproved?? && proposalMethodologyWaiver.isApproved==2>
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
			<textarea id="description" name="description" rows="15" cols="30" disabled="disabled">${project.description?html}</textarea>
		</div>   
	</div>

<div class="region-inner">
	<label class='rte-editor-label'>Business Question</label>
    <div class="form-text_div">        
        <textarea id="bizQuestion" name="bizQuestion" rows="10" cols="20" class="form-text-div" disabled="disabled">${proposalInitiation.bizQuestion?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="bizQuestionText" name="bizQuestionText">${proposalInitiation.bizQuestionText?default('')?html}</textarea>
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
        <textarea id="researchObjective" name="researchObjective" rows="10" cols="20" disabled="disabled" class="form-text-div">${proposalInitiation.researchObjective?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="researchObjectiveText" name="researchObjectiveText">${proposalInitiation.researchObjectiveText?default('')?html}</textarea>
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
        <textarea id="actionStandard" name="actionStandard" rows="10" cols="20" disabled="disabled" class="form-text-div">${proposalInitiation.actionStandard?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="actionStandardText" name="actionStandardText">${proposalInitiation.actionStandardText?default('')?html}</textarea>
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
        <textarea id="researchDesign" name="researchDesign" rows="10" cols="20" disabled="disabled" class="form-text-div form-text-div-large">${proposalInitiation.researchDesign?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="researchDesignText" name="researchDesignText">${proposalInitiation.researchDesignText?default('')?html}</textarea>
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
        <textarea id="sampleProfile" name="sampleProfile" rows="10" cols="20" class="form-text-div" disabled="disabled">${proposalInitiation.sampleProfile?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="sampleProfileText" name="sampleProfileText">${proposalInitiation.sampleProfileText?default('')?html}</textarea>
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
        <textarea id="stimulusMaterial" name="stimulusMaterial" rows="10" cols="20" disabled="disabled" class="form-text-div">${proposalInitiation.stimulusMaterial?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="stimulusMaterialText" name="stimulusMaterialText">${proposalInitiation.stimulusMaterialText?default('')?html}</textarea>
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
        <textarea id="stimulusMaterialShipped" name="stimulusMaterialShipped" rows="10" cols="20" disabled="disabled" class="form-text-div">${proposalInitiation.stimulusMaterialShipped?default('')?html}</textarea>
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
        <textarea id="others" name="others" rows="10" cols="20" class="form-text-div" disabled="disabled">${proposalInitiation.others?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="othersText" name="othersText">${proposalInitiation.othersText?default('')?html}</textarea>
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
        <input type="text" name="stimuliDate" id="stimuliDate"  value="<#if proposalInitiation.stimuliDate?? >${proposalInitiation.stimuliDate?string('dd/MM/yyyy')}</#if>" disabled />
    </div>
</div>

<div class="pib-report-requirement">
    <label>Reporting Requirement</label>
    <table class="report_requirement_list" id="report_requirement_list_id">
        <tbody>
        <tr>
            <td><@renderCheckBox label='' name='topLinePresentation' isChecked=proposalReporting.topLinePresentation?default(false) disable=true/></td>
            <td class="view-row-first">Topline Presentation</td>
        </tr>
        <tr class="color-row">
            <td><@renderCheckBox label='' name='presentation' isChecked=proposalReporting.presentation?default(false) disable=true/></td>
            <td class="view-row-first">Presentation</td>
        </tr>
        <tr>
            <td><@renderCheckBox label='' name='fullreport' isChecked=proposalReporting.fullreport?default(false) disable=true/></td>
            <td class="view-row-first">Full Report</td>
        </tr>

        </tbody>
    </table>
</div>
<div class="region-inner">
	<label class='rte-editor-label'>Other Reporting Requirements</label>
    <div class="form-text_div">        
        <textarea id="otherReportingRequirements" name="otherReportingRequirements" rows="10" cols="20" disabled="disabled" class="form-text-div">${proposalReporting.otherReportingRequirements?default('')?html}</textarea>
    </div>
	<textarea style="display:none;" id="otherReportingRequirementsText" name="otherReportingRequirementsText">${proposalReporting.otherReportingRequirementsText?default('')?html}</textarea>
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

<!-- END MARKET FIELDS STARTS -->
<div class="end_market_details" style="display:block;">
<#-- <#list endMarketDetails as endMarketDetail> -->
<#assign emid = proposalEndMarketId />
    <div class="">
        <h3 id="block_header_${emid}" onclick="javascript:toggleEndmarketBlock(${emid});">${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emid?int)}
            <a id="legend_${emid}" href="javascript:void(0);" class="close-form"></a>
        </h3>
        <div id="endMarket_${emid}" class="pib_angola" >


            <div class="pib_angola_left">


                <div class="form-select_div">
                    <p class="induction_text">If any of fields are not relevant, please put '0' in it.</p>
                    <label>Total Cost</label>
                    <input type="text" name="totalCost-display" <#if proposalEMDetails.totalCost?? > value="${proposalEMDetails.totalCost}" <#else> value="" </#if> size="20" disabled="disabled" class="form-text-div numericfield numericformat" >
                <@renderCurrenciesField name='totalCostType' value=proposalEMDetails.totalCostType?default(defaultCurrency) disabled=true/>
                <#assign error_msg><@s.text name="project.error.cost"/></#assign>
                <@macroCustomFieldErrors msg=error_msg />
                    <input type="hidden" name="totalCost" <#if proposalEMDetails.totalCost?? > value="${proposalEMDetails.totalCost?c}" <#else> value="" </#if> >
                </div>
            <#if proposalInitiation.methodologyType!=4 >
                <div class="form-select_div">
                    <label>International Management Cost - Research Hub Cost</label>
                    <input type="text" name="intMgmtCost-display" <#if proposalEMDetails.intMgmtCost?? > value="${proposalEMDetails.intMgmtCost}" <#else> value="" </#if> size="20" disabled="disabled" class="form-text-div numericfield numericformat" >
                    <@renderCurrenciesField name='intMgmtCostType' value=proposalEMDetails.intMgmtCostType?default(defaultCurrency) disabled=true/>
                    <#assign error_msg><@s.text name="project.error.cost"/></#assign>
                    <@macroCustomFieldErrors msg=error_msg />
                    <input type="hidden" name="intMgmtCost" <#if proposalEMDetails.intMgmtCost?? > value="${proposalEMDetails.intMgmtCost?c}" <#else> value="" </#if> >
                </div>
                <div class="form-select_div">
                    <label>Local Management Cost</label>
                    <input type="text" name="localMgmtCost-display" <#if proposalEMDetails.localMgmtCost?? > value="${proposalEMDetails.localMgmtCost}" <#else> value="" </#if> size="20" disabled="disabled" class="form-text-div numericfield numericformat" >
                    <@renderCurrenciesField name='localMgmtCostType' value=proposalEMDetails.localMgmtCostType?default(defaultCurrency) disabled=true/>
                    <#assign error_msg><@s.text name="project.error.cost"/></#assign>
                    <@macroCustomFieldErrors msg=error_msg />
                    <input type="hidden" name="localMgmtCost" <#if proposalEMDetails.localMgmtCost?? > value="${proposalEMDetails.localMgmtCost?c}" <#else> value="" </#if> >
                </div>

                <div class="form-select_div">
                    <label>Fieldwork Cost</label>
                    <input type="text" name="fieldworkCost-display" <#if proposalEMDetails.fieldworkCost?? > value="${proposalEMDetails.fieldworkCost}" <#else> value="" </#if> size="20" disabled="disabled" class="form-text-div numericfield numericformat" >
                    <@renderCurrenciesField name='fieldworkCostType' value=proposalEMDetails.fieldworkCostType?default(defaultCurrency) disabled=true/>
                    <#assign error_msg><@s.text name="project.error.cost"/></#assign>
                    <@macroCustomFieldErrors msg=error_msg />
                    <input type="hidden" name="fieldworkCost" <#if proposalEMDetails.fieldworkCost?? > value="${proposalEMDetails.fieldworkCost?c}" <#else> value="" </#if> >
                </div>
                <div class="form-select_div">
                    <label>Operational Hub Cost</label>
                    <input type="text" name="operationalHubCost-display" <#if proposalEMDetails.operationalHubCost?? > value="${proposalEMDetails.operationalHubCost}" <#else> value="" </#if> size="20" disabled="disabled" class="form-text-div numericfield numericformat" >
                    <@renderCurrenciesField name='operationalHubCostType' value=proposalEMDetails.operationalHubCostType?default(defaultCurrency) disabled=true/>
                    <#assign error_msg><@s.text name="project.error.cost"/></#assign>
                    <@macroCustomFieldErrors msg=error_msg />
                    <input type="hidden" name="operationalHubCost" <#if proposalEMDetails.operationalHubCost?? > value="${proposalEMDetails.operationalHubCost?c}" <#else> value="" </#if> >
                </div>
                 <div class="form-select_div">
                    <label>Other Cost</label>
                    <input type="text" name="otherCost-display" <#if proposalEMDetails.otherCost?? > value="${proposalEMDetails.otherCost}" <#else> value="" </#if> size="20" disabled="disabled" class="form-text-div numericfield numericformat" >
                    <@renderCurrenciesField name='otherCostType' value=proposalEMDetails.otherCostType?default(defaultCurrency) disabled=true/>
                    <#assign error_msg><@s.text name="project.error.cost"/></#assign>
                    <@macroCustomFieldErrors msg=error_msg />
                    <input type="hidden" name="fieldworkCost" <#if proposalEMDetails.otherCost?? > value="${proposalEMDetails.otherCost?c}" <#else> value="" </#if> >
                </div>

                <div class="form-text_div">
                    <label>Name of Proposed Fieldwork Agencies</label>
                    <input type="text" name="proposedFWAgencyNames" value="${proposalEMDetails.proposedFWAgencyNames?default('')}" disabled="disabled" class="form-text-div" >
                </div>
                <div class="form-text_div">
                    <label>Estimated Fieldwork Start</label>
                    <input type="text" name="fwStartDate" value="<#if proposalEMDetails.fwStartDate?? >${proposalEMDetails.fwStartDate?string('dd/MM/yyyy')}</#if>" disabled="disabled" class="form-text-div" >
                </div>
                <div class="form-text_div">
                    <label>Estimated Fieldwork Completion</label>
                    <input type="text" name="fwEndDate" value="<#if proposalEMDetails.fwEndDate?? >${proposalEMDetails.fwEndDate?string('dd/MM/yyyy')}</#if>" disabled="disabled" class="form-text-div" >
                </div>

                <div class="form-select_div_main">
                    <label class="label_b">Data Collection Methods</label>

                    <@renderDataCollectionSelected name='dataCollectionMethod' value=proposalEMDetails.dataCollectionMethod?default('-1') multiselect=true class='form-multi-select' readonly=true id='dataCollectionMethod' />
                    <@macroFieldErrors name="collectionMethod"/>
                </div>
            </#if>
            </div>
            <div class="pib-qualitative">
            <#if proposalInitiation.methodologyType==1 || proposalInitiation.methodologyType==3 >
                <h2 class="pib_sub_heading">Quantitative</h2>
                <p class="induction_text">(If any of fields are not relevant, please put '0' in it.)</p>
                <ul>
                    <li>
                        <div class="form-text_div">
                            <label>Total Number of Inteviews</label>
                            <input type="text" name="totalNoInterviews" disabled="disabled" <#if proposalEMDetails.totalNoInterviews?? && proposalEMDetails.totalNoInterviews gt -1> value="${proposalEMDetails.totalNoInterviews?c}" <#else> value="" </#if> class="form-text-div" >
                        </div>
                    </li>
                    <li>
                        <div class="form-text_div">
                            <label>Total Number of Visits per Respondent</label>
                            <input type="text" name="totalNoOfVisits" <#if proposalEMDetails.totalNoOfVisits?? && proposalEMDetails.totalNoOfVisits gt -1> value="${proposalEMDetails.totalNoOfVisits?c}" <#else> value="" </#if>  disabled="disabled" class="form-text-div" >
                        </div>
                    </li>
                    <li>
                        <div class="form-text_div">
                            <label>Average Interview Duration (in minutes)</label>
                            <input type="text" name="avIntDuration" <#if proposalEMDetails.avIntDuration?? && proposalEMDetails.avIntDuration gt -1> value="${proposalEMDetails.avIntDuration?c}" <#else> value="" </#if>  disabled="disabled" class="form-text-div" >
                        </div>
                    </li>
                </ul>
            </#if>
            
             <#assign geographical_spread_display = 'none' />
            <#if proposalInitiation.methodologyType==1 ||  proposalInitiation.methodologyType==3 >
                <#assign geographical_spread_display = 'block' />
            </#if>
                <div id="geographical_spread_div" style="display:${geographical_spread_display};">
                    <div class="pib-report-requirement">
                        <label>Geographical Spread</label>
                        <table class="report_requirement_list">
                            <tbody>
                            <tr>

                                <td><@renderRadioBox label='' name='geoSpread' id='geoSpreadNational' value='geoSpreadNational' isChecked=proposalEMDetails.geoSpreadNational?default(false) disable=true/></td>
                                <td class="view-row-first">National</td>
                            </tr>
                            <tr class="color-row">

                                <td><@renderRadioBox label=''  name='geoSpread' id='geoSpreadUrban' value='geoSpreadUrban' isChecked=proposalEMDetails.geoSpreadUrban?default(false) disable=true/></td>
                                <td class="view-row-first">Non-National</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            <#--  Display cities section only when the Gerographical spread is Urban -->

            <#if proposalInitiation.methodologyType==1 || proposalInitiation.methodologyType==3 >
                <div class="form-text_div" id="cities" >
                    <label>Please Define Geography</label>
                    <input type="text" name="cities"  value="${proposalEMDetails.cities?default('')}" disabled="disabled" class="form-text-div" >
                </div>
            </#if>

            <#if proposalInitiation.methodologyType==2 || proposalInitiation.methodologyType==3 >
                <h2 class="pib_sub_heading">Qualitative</h2>
                <p class="induction_text">(If any of fields are not relevant, please put '0' in it.)</p>
                <div class="form-text_div">
                    <label>Total No of Groups/In-Depth Interviews</label>
                    <input type="text" name="totalNoOfGroups" <#if proposalEMDetails.totalNoOfGroups?? && proposalEMDetails.totalNoOfGroups gt -1> value="${proposalEMDetails.totalNoOfGroups?c}" <#else> value="" </#if>  disabled="disabled" class="form-text-div" >
                </div>
                <div class="form-text_div">
                    <label>Group/In-Interview Duration (in minutes)</label>
                    <input type="text" name="interviewDuration" <#if proposalEMDetails.interviewDuration?? && proposalEMDetails.interviewDuration gt -1> value="${proposalEMDetails.interviewDuration?c}" <#else> value="" </#if> disabled="disabled" class="form-text-div" >
                </div>
                <div class="form-text_div">
                    <label>Number of Respondents per Group</label>
                    <input type="text" name="noOfRespPerGroup" <#if proposalEMDetails.noOfRespPerGroup?? && proposalEMDetails.noOfRespPerGroup gt -1> value="${proposalEMDetails.noOfRespPerGroup?c}" <#else> value="" </#if>  disabled="disabled" class="form-text-div" >
                </div>
            </#if>
           

            </div>

        </div>
    </div>

    <script type="text/javascript">
        $j(document).ready(function() {
        <#if proposalEMDetails.geoSpreadUrban?? && proposalEMDetails.geoSpreadUrban >
            $j("#cities").show();
        <#else>
            $j("#cities").hide();
        </#if>
        });
    </script>
<#--  </#list> -->
</div>
<!-- END MARKET FIELDS ENDS -->
<div class="region-inner">
	<label class='rte-editor-label'>Proposal and Cost Template</label>
    <div class="form-text_div">        
        <textarea id="proposalCostTemplate" name="proposalCostTemplate" rows="10" cols="20" disabled="disabled">${proposalInitiation.proposalCostTemplate?default('Enter text and/or attach documents')?html}</textarea>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#if attachmentMap?? && attachmentMap.get(propCostTemplateID)?? >
        <div id="jive-file-list" class="jive-attachments">
            <#list attachmentMap.get(propCostTemplateID) as attachment>
                <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                    <span class="jive-icon-med jive-icon-attachment"></span>
                    <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" ${attachment.objectID?c}>
                    ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                    </a>
                </div>
            </#list>
        </div>
    </#if>
    </div>
    <!-- ATTACHMENT DISPLAY ENDS -->
</div>

<div class="ld-div">
</div>
</div>
<!-- BEGIN sidebar column -->
<div id="jive-body-sidebarcol-container" class="j-column j-column-s j-content-extras">
<#include "/template/docs/synchro-doc-sidebar.ftl" />
</div>
<!-- END sidebar column -->
</form>
