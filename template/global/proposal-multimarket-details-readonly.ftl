
    <form name="proposal" id="proposal-form" action="/synchro/proposal-multi-details!execute.jspa" method="POST" name="form-create" class="research_pib pib" >
    <div class="research_content">
    <input type="hidden" name="projectID" value="${projectID?c}">

    <input type="hidden" name="isSave" value="${save?string}">
    <input type="hidden" name="agencyID" value="${agencyID?c}">

    <div class="pib_inner_main">
        <div class="pib_left">
          
         
            <div class="pib-select_div">
                <label><@s.text name="project.initiate.project.brand"/></label>
                <@renderBrandField name='brand' value=proposalInitiation.brand?default('-1') readonly=true />
                <#assign error_msg><@s.text name='project.error.brand' /></#assign>
                <@macroCustomFieldErrors msg=error_msg />
            </div>



            <div class="pib-select_div">
                <label>Countries</label>
                
                 <@renderMultiEndMarketField name='updatedSingleMarketId1' value=activeEndMarketIds?default('-1') readonly=true/>
                <#assign error_msg><@s.text name='project.error.endmarket' /></#assign>
                <@macroCustomFieldErrors msg=error_msg />
            </div>

            <div class="project_owner_names">
               
            		<label>SP&I Contact</label>
        		

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
              
                    <#assign briefCreatorName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.briefCreator) />
                <#else>
                    <#assign briefCreatorName="" />
                </#if>
                <input type="text" name="briefCreator" id="briefCreator"  value="${briefCreatorName}" disabled="disabled" />

            </div>

            <div class="project_owner_contact">
          	 
        	<label>Project Owner</label>
        	
             <#assign globalProjectContact = -1 />
       		 <#assign regionalProjectContact = -1 />
             <#assign areaProjectContact = -1 />
             <#assign countryProjectContact = -1 />
              <#list fundingInvestments as fundingInvestment>
	            <#if fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].GlOBAL.getId()>
	                <#assign globalProjectContact = fundingInvestment.projectContact />
	            <#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].REGION.getId()>
	                <#assign regionalProjectContact = fundingInvestment.projectContact />
	            <#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].AREA.getId()>
	                <#assign areaProjectContact = fundingInvestment.projectContact />
	           <#-- <#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].COUNTRY.getId()>
	                <#assign countryProjectContact = fundingInvestment.projectContact /> -->    
	            </#if>
	        </#list>
	        
	        <#if globalProjectContact &gt; 0>
	           <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(globalProjectContact) />
	        <#elseif regionalProjectContact &gt; 0>
	           <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(regionalProjectContact) />
	        <#elseif areaProjectContact &gt; 0>
	           <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(areaProjectContact) />
	        <#elseif countryProjectContact &gt; 0>
	           <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(countryProjectContact) />
	        <#else>
	            <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner) />
	        </#if>
	        
	         <input type="text" name="briefCreator" id="briefCreator"  value="${projectContactName}" disabled="disabled" />
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

                <@renderAllSelectedCategoryTypeField name='categoryType' value=project.categoryType?default(-1) readonly=true />
                <#assign error_msg><@s.text name='project.error.category' /></#assign>
                <@macroCustomFieldErrors msg=error_msg />
            </div>

            <div class="form-select_div">
                <label><@s.text name="project.initiate.project.methodology"/></label>
                <@renderMethodologyField name='methodologyType' value=proposalInitiation.methodologyType?default('-1') readonly=true />
                <#assign error_msg><@s.text name='project.error.methodology' /></#assign>
                <@macroCustomFieldErrors msg=error_msg />
            </div>

            <div class="form-select_div">
                <label><@s.text name="project.initiate.project.methodologygroup"/></label>
                <@renderMethodologyGroupField name='methodologyGroup' value=proposalInitiation.methodologyGroup?default('-1') readonly=true />
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
                <@macroCustomFieldErrors msg='' class='numeric-error' />
            </div>

			<div class="form-select_div select-div">
		 		<label>CAP Rating</label>
		 		<@renderCAPRatingField name='capRating' value=proposalInitiation.capRating?default(-1) readonly=true/>
		 	</div>
		 
            <div class="form-select_div select-div">
                <label>Request for Methodology Waiver</label>
                <select name="deviationFromSM" id="deviationFromSM" class="form-select" onchange="checkMethDeviation()" disabled="disabled">
                    <option value="1" <#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==1 > selected </#if>>Yes</option>
                    <option value="0" <#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==0 > selected </#if>>No</option>
                </select>
            </div>
			<#if proposalMethodologyWaiver?? && projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==1>
				<div class="form-select_div select-div methodology-status">
					<label>Status of Waiver</label>
					<#if proposalMethodologyWaiver.isApproved?? && proposalMethodologyWaiver.isApproved==1>
						<span>Approved</span>
					<#elseif proposalMethodologyWaiver.isApproved?? && proposalMethodologyWaiver.isApproved==2>
						<span>Rejected</span>
					<#else>
						<span>Pending</span>
					</#if>
				</div>
			</#if>
            
           <#if isAdminUser || isAboveMarketProjectContact || isGlobalSuperUser>
             <div class="form-text_div pib_initial_cost">
	            <label>Total Cost</label>
	            <input type="text" name="name" value="${project.totalCost?default('')}" size="30" class="form-text-div numericfield numericformat" disabled="disabled">
	            <@renderCurrenciesField name='intMgmtCostType' value=project.totalCostCurrency?default(defaultCurrency) disabled=true/>
	            <@macroCustomFieldErrors msg='' class='numeric-error' />
	           
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

<#assign synchroUtils = jiveContext.getSpringBean("synchroUtils") />

    <div class="region-inner">
		<label class='rte-editor-label'>Business Question</label>
        <div class="form-text_div">            
            <textarea id="bizQuestion" name="bizQuestion" rows="10" cols="20" disabled="disabled" class="form-text-div">${proposalInitiation.bizQuestion?default('')?html}</textarea>
        </div>
		<textarea style="display:none;" id="bizQuestionText" name="bizQuestionText">${proposalInitiation.bizQuestionText?default('')?html}</textarea>
        <!-- ATTACHMENT DISPLAY STARTS -->
        <div class="field-attachments">
           
            <#if attachmentMap?? && attachmentMap.get(bussinessQuestionID)?? >
                <div id="jive-file-list" class="jive-attachments">
                    <#list attachmentMap.get(bussinessQuestionID) as attachment>
                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                            <span class="jive-icon-med jive-icon-attachment"></span>
                            <#if attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID >
                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c});"><@s.text name="global.remove" /></a>
                            </#if>
                            <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                            ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
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
                            <#if attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID >
                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c});"><@s.text name="global.remove" /></a>
                            </#if>
                            <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                            ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
                        </div>
                    </#list>
                </div>
            </#if>
        </div>
        <!-- ATTACHMENT DISPLAY ENDS -->
    </div>


    <#list proposalInitiationList as proposalIniList>
    		<div class="region-inner">
			<label class='rte-editor-label'>Action Standard(s) : <#if proposalIniList.endMarketID == statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID> Above Market <#else>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(proposalIniList.endMarketID?int)}</#if></label>
	        <div class="form-text_div">	            
	            <textarea id="actionStandard_${proposalIniList.endMarketID}" name="actionStandard_${proposalIniList.endMarketID}" rows="10" cols="20" disabled="disabled" class="form-text-div">${proposalIniList.actionStandard?default('')?html}</textarea>
	        </div>
			<textarea style="display:none;" id="actionStandardText" name="actionStandardText">${proposalIniList.actionStandardText?default('')?html}</textarea>
	        <!-- ATTACHMENT DISPLAY STARTS -->
	        <div class="field-attachments">
	      
	            <#if attachmentMap?? && attachmentMap.get(actionStandardID)?? >
	                <div id="jive-file-list" class="jive-attachments">
	                    <#list attachmentMap.get(actionStandardID) as attachment>
	                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
	                            <span class="jive-icon-med jive-icon-attachment"></span>
	                            <#if attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID >
	                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c});"><@s.text name="global.remove" /></a>
	                            </#if>
	                            <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
	                            ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
	                        </div>
	                    </#list>
	                </div>
	            </#if>
	        </div>
	        <!-- ATTACHMENT DISPLAY ENDS -->
	    </div>
    </#list>
   

    <#list proposalInitiationList as proposalIniList>
		<div class="region-inner">
		<label class='rte-editor-label'>Methodology Approach and Research Design : <#if proposalIniList.endMarketID ==  statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID> Above Market <#else>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(proposalIniList.endMarketID?int)}</#if></label>
	        <div class="form-text_div">	            
	            <textarea id="researchDesign_${proposalIniList.endMarketID}" name="researchDesign_${proposalIniList.endMarketID}" rows="10" cols="20" disabled="disabled" class="form-text-div form-text-div-large">${proposalIniList.researchDesign?default('')?html}</textarea>
	        </div>
			<textarea style="display:none;" id="researchDesignText" name="researchDesignText">${proposalIniList.researchDesignText?default('')?html}</textarea>
	        <!-- ATTACHMENT DISPLAY STARTS -->
	        <div class="field-attachments">
	           
	            <#if attachmentMap?? && attachmentMap.get(researchDesignID)?? >
	                <div id="jive-file-list" class="jive-attachments">
	                    <#list attachmentMap.get(researchDesignID) as attachment>
	                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
	                            <span class="jive-icon-med jive-icon-attachment"></span>
	                            <#if attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID >
	                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c});"><@s.text name="global.remove" /></a>
	                            </#if>
	                            <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
	                            ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
	                        </div>
	                    </#list>
	                </div>
	            </#if>
	        </div>
	        <!-- ATTACHMENT DISPLAY ENDS -->
	    </div>
	 </#list>
	 
	<#list proposalInitiationList as proposalIniList>
	
	    <div class="region-inner">
			<label class='rte-editor-label'>Sample Profile (Research) : <#if proposalIniList.endMarketID == statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID> Above Market <#else>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(proposalIniList.endMarketID?int)}</#if></label>
	        <div class="form-text_div">	            
	            <textarea id="sampleProfile_${proposalIniList.endMarketID}" name="sampleProfile_${proposalIniList.endMarketID}" rows="10" cols="20" disabled="disabled" class="form-text-div">${proposalIniList.sampleProfile?default('')?html}</textarea>
	        </div>
			<textarea style="display:none;" id="sampleProfileText" name="sampleProfileText">${proposalIniList.sampleProfileText?default('')?html}</textarea>
	        <!-- ATTACHMENT DISPLAY STARTS -->
	        <div class="field-attachments">
	            
	            <#if attachmentMap?? && attachmentMap.get(sampleProfileID)?? >
	                <div id="jive-file-list" class="jive-attachments">
	                    <#list attachmentMap.get(sampleProfileID) as attachment>
	                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
	                            <span class="jive-icon-med jive-icon-attachment"></span>
	                            <#if attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID >
	                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c});"><@s.text name="global.remove" /></a>
	                            </#if>
	                            <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
	                            ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
	                        </div>
	                    </#list>
	                </div>
	            </#if>
	        </div>
	        <!-- ATTACHMENT DISPLAY ENDS -->
	    </div>
	</#list>


	<#list proposalInitiationList as proposalIniList>
	    <div class="region-inner">
			<label class='rte-editor-label'>Stimulus Material : <#if proposalIniList.endMarketID == statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID> Above Market <#else>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(proposalIniList.endMarketID?int)}</#if></label>
	        <div class="form-text_div">	            
	            <textarea id="stimulusMaterial_${proposalIniList.endMarketID}" name="stimulusMaterial_${proposalIniList.endMarketID}" rows="10" cols="20" disabled="disabled" class="form-text-div">${proposalIniList.stimulusMaterial?default('')?html}</textarea>
	        </div>
			<textarea style="display:none;" id="stimulusMaterialText" name="stimulusMaterialText">${proposalIniList.stimulusMaterialText?default('')?html}</textarea>
	        <!-- ATTACHMENT DISPLAY STARTS -->
	        <div class="field-attachments">
	          
	            <#if attachmentMap?? && attachmentMap.get(stimulusMaterialID)?? >
	                <div id="jive-file-list" class="jive-attachments">
	                    <#list attachmentMap.get(stimulusMaterialID) as attachment>
	                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
	                            <span class="jive-icon-med jive-icon-attachment"></span>
	                            <#if attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID >
	                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c});"><@s.text name="global.remove" /></a>
	                            </#if>
	                            <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
	                            ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
	                        </div>
	                    </#list>
	                </div>
	            </#if>
	        </div>
	        <!-- ATTACHMENT DISPLAY ENDS -->
	    </div>
	 </#list>

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
                            <#if attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID >
                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c});"><@s.text name="global.remove" /></a>
                            </#if>
                            <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                            ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
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
            <textarea id="others" name="others" rows="10" cols="20" class="form-text-div" disabled="disabled">${proposalInitiation.others?default('')?html}</textarea>                </div>
		<textarea style="display:none;" id="othersText" name="othersText">${proposalInitiation.othersText?default('')?html}</textarea>
        <!-- ATTACHMENT DISPLAY STARTS -->
        <div class="field-attachments">
       
            <#if attachmentMap?? && attachmentMap.get(othersID)?? >
                <div id="jive-file-list" class="jive-attachments">
                    <#list attachmentMap.get(othersID) as attachment>
                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                            <span class="jive-icon-med jive-icon-attachment"></span>
                            <#if attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID >
                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c});"><@s.text name="global.remove" /></a>
                            </#if>
                            <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                            ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
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
           
            <input type="text" name="stimuliDate" id="stimuliDate"  value="<#if proposalInitiation.stimuliDate?? >${proposalInitiation.stimuliDate?string('dd/MM/yyyy')}</#if>" disabled="disabled" />

        </div>
    </div>

    <div class="pib-report-requirement">
        <label>Reporting Requirement</label>
        <table class="report_requirement_list" id="report_requirement_list_id">
            <tbody>
            <tr>
                <td><@renderReportingCheckBox label='' name='topLinePresentation' isChecked=proposalReporting.topLinePresentation?default(false) disable=true /></td>
                <td class="view-row-first">Global Top Line Presentation</td>
            </tr>
            <tr class="color-row">
                <td><@renderReportingCheckBox label='' name='presentation' isChecked=proposalReporting.presentation?default(false) disable=true /></td>
                <td class="view-row-first">Global Presentation/Report</td>
            </tr>
            <tr>
                <td><@renderReportingCheckBox label='' name='fullreport' isChecked=proposalReporting.fullreport?default(false) disable=true /></td>
                <td class="view-row-first">EM Presentation/Report(s)</td>
            </tr>
            <tr>
                <td><@renderReportingCheckBox label='' name='globalSummary' isChecked=proposalReporting.globalSummary?default(false) disable=true /></td>
                <td class="view-row-first">Global Summary</td>
            </tr>

            </tbody>
        </table>

        <@macroCustomFieldErrors msg="Please select reporting requirement"/>

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
                            <#if attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID >
                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c});"><@s.text name="global.remove" /></a>
                            </#if>
                            <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                            ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
                        </div>
                    </#list>
                </div>
            </#if>
        </div>
        <!-- ATTACHMENT DISPLAY ENDS -->
    </div>



    <!-- END MARKET FIELDS STARTS -->
	<#list activeEndMarketIds as emid> 
    <div class="end_market_details" style="display:block;">
    
        <#-- <#assign emid = endMarketDetail.endMarketID /> -->
        
        <#assign isCountryProjectContact = statics['com.grail.synchro.util.SynchroPermHelper'].isCountryProjectContact(projectID,emid) />
		<#assign isCountrySPIContact = statics['com.grail.synchro.util.SynchroPermHelper'].isCountrySPIContact(projectID,emid) />
		<#assign isEndMarketSuperUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroEndmarketSuperUser(user,emid) />
		
        <div class="">
            <h3 id="block_header_${emid}" onclick="javascript:toggleEndmarketBlock(${emid});">${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emid?int)}
                <a id="legend_${emid}" href="javascript:void();" class="close-form"></a>
            </h3>
            <div id="endMarket_${emid}" class="pib_angola" >
                <div class="pib_angola_left">

				  <#if isAboveMarketProjectContact || isProjectOwner || isCountryProjectContact || isCountrySPIContact || isGlobalSuperUser || isEndMarketSuperUser>
	                    <div class="form-select_div">
	                    <p class="induction_text">If any of fields are not relevant, please put '0' in it.</p>
	                        <label>Total Cost</label>
	                        <script type="text/javascript">
	                            function totalCostChange(eId) {
	                                var val = Number($j("input[name=totalCost-display_"+eId+"]").val().replace(/\,/g,''));
	                                
	                                if(val) {
	                                    $j("input[name=totalCost_"+eId+"]").val(val);
	                                } else {
	                                    $j("input[name=totalCost_"+eId+"]").val("");
	                                }
	                            }
	                        </script>
	                      
	                        <input type="text" name="totalCost-display_${emid}" onchange="totalCostChange('${emid}')" disabled="disabled" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getTotalCost()?? > value="${proposalEMDetailsMap.get(emid).getTotalCost()}" <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat" >
	                        
	                        <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getTotalCostType()?? > 
	                        	<@renderCurrenciesField name='totalCostType_${emid}' value=proposalEMDetailsMap.get(emid).getTotalCostType() disabled=true/>
	                        <#else>
	                        	<@renderCurrenciesField name='totalCostType_${emid}' value=defaultCurrency disabled=true/>
	                        </#if>
	                      
	                        <input type="hidden" name="totalCost_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getTotalCost()?? > value="${proposalEMDetailsMap.get(emid).getTotalCost()}" <#else> value="" </#if> >
	                    </div>
	                   
					</#if>
					 <#assign internation_management_cost_display = 'none' />
	                    <#if proposalInitiation.methodologyType?? && proposalInitiation.methodologyType!=4 >
	                        <#assign internation_management_cost_display = 'block' />
	                    </#if>
	                    <div id="internation_management_cost_div_${emid}" style='display:${internation_management_cost_display};'>
	                        
	                        <#if isAboveMarketProjectContact || isProjectOwner || isCountryProjectContact || isCountrySPIContact || isGlobalSuperUser || isEndMarketSuperUser>
	                        <div class="form-select_div">
	                            <label>International Management Cost - Research Hub Cost</label>
	                            <script type="text/javascript">
	                                function inititalMgmtCostChange(eId) {
	                                    var val = Number($j("input[name=intMgmtCost-display_"+eId+"]").val().replace(/\,/g,'')) ;
	                                    if(val) {
	                                        $j("input[name=intMgmtCost_"+eId+"]").val(val);
	                                    } else {
	                                        $j("input[name=intMgmtCost_"+eId+"]").val("");
	                                    }
	                                }
	                            </script>
	                            <input type="text" name="intMgmtCost-display_${emid}" onchange="inititalMgmtCostChange('${emid}')" disabled="disabled" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getIntMgmtCost()?? > value="${proposalEMDetailsMap.get(emid).getIntMgmtCost()}" <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat" >
	                            <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getIntMgmtCostType()?? > 
	                        		<@renderCurrenciesField name='intMgmtCostType_${emid}' value=proposalEMDetailsMap.get(emid).getIntMgmtCostType() disabled=true/>
	                        	<#else>
	                        		<@renderCurrenciesField name='intMgmtCostType_${emid}' value=defaultCurrency disabled=true/>
	                        	</#if>
	                          
	                            <input type="hidden" name="intMgmtCost_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getIntMgmtCost()?? > value="${proposalEMDetailsMap.get(emid).getIntMgmtCost()}"  <#else> value="" </#if> >
	                        </div>
	                        <div class="form-select_div">
	                            <label>Local Management Cost</label>
	                            <script type="text/javascript">
	                                function localMgmtCostChange(eId) {
	                                    var val = Number($j("input[name=localMgmtCost-display_"+eId+"]").val().replace(/\,/g,''));
	                                    if(val) {
	                                        $j("input[name=localMgmtCost_"+eId+"]").val(val);
	                                    } else {
	                                        $j("input[name=localMgmtCost_"+eId+"]").val("");
	                                    }
	                                }
	                            </script>
	                            <input type="text" name="localMgmtCost-display_${emid}" onchange="localMgmtCostChange('${emid}')" disabled="disabled" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getLocalMgmtCost()?? > value="${proposalEMDetailsMap.get(emid).getLocalMgmtCost()}"  <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat" >
	                            
	                            
	                             <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getLocalMgmtCostType()?? > 
	                        		<@renderCurrenciesField name='localMgmtCostType_${emid}' value=proposalEMDetailsMap.get(emid).getLocalMgmtCostType() disabled=true/>
	                        	<#else>
	                        		<@renderCurrenciesField name='localMgmtCostType_${emid}' value=defaultCurrency disabled=true/>
	                        	</#if>
	                        	
	                          
	                            <input type="hidden" name="localMgmtCost_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getLocalMgmtCost()?? > value="${proposalEMDetailsMap.get(emid).getLocalMgmtCost()}"  <#else> value="" </#if> >
	                        </div>
	
	                        <div class="form-select_div">
	                            <label>Fieldwork Cost</label>
	                            <script type="text/javascript">
	                                function fieldWorkCostChange(eId) {
	                                    var val = Number($j("input[name=fieldworkCost-display_"+eId+"]").val().replace(/\,/g,''));
	                                    if(val) {
	                                        $j("input[name=fieldworkCost_"+eId+"]").val(val);
	                                    } else {
	                                        $j("input[name=fieldworkCost_"+eId+"]").val("");
	                                    }
	                                }
	                            </script>
	                            <input type="text" name="fieldworkCost-display_${emid}" onchange="fieldWorkCostChange('${emid}')" disabled="disabled" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getFieldworkCost()?? > value="${proposalEMDetailsMap.get(emid).getFieldworkCost()}"  <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat" >
	                           
	                             <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getFieldworkCostType()?? > 
	                        		<@renderCurrenciesField name='fieldworkCostType_${emid}' value=proposalEMDetailsMap.get(emid).getFieldworkCostType() disabled=true/>
	                        	<#else>
	                        		<@renderCurrenciesField name='fieldworkCostType_${emid}' value=defaultCurrency disabled=true/>
	                        	</#if>
	                          
	                            <input type="hidden" name="fieldworkCost_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getFieldworkCost()?? > value="${proposalEMDetailsMap.get(emid).getFieldworkCost()}" <#else> value="" </#if> >
	                        </div>
	                         <div class="form-select_div">
	                            <label>Operational Hub Cost</label>
	                            <script type="text/javascript">
	                                function operationalHubCostChange(eId) {
	                                    var val = Number($j("input[name=operationalHubCost-display_"+eId+"]").val().replace(/\,/g,''));
	                                    if(val) {
	                                        $j("input[name=operationalHubCost_"+eId+"]").val(val);
	                                    } else {
	                                        $j("input[name=operationalHubCost_"+eId+"]").val("");
	                                    }
	                                }
	                            </script>
	                            <input type="text" name="operationalHubCost-display_${emid}" onchange="operationalHubCostChange('${emid}')" disabled="disabled" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getOperationalHubCost()?? > value="${proposalEMDetailsMap.get(emid).getOperationalHubCost()}" <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat" >
	                           
	                            
	                            <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getOperationalHubCostType()?? > 
	                        		<@renderCurrenciesField name='operationalHubCostType_${emid}' value=proposalEMDetailsMap.get(emid).getOperationalHubCostType() disabled=true/>
	                        	<#else>
	                        		<@renderCurrenciesField name='operationalHubCostType_${emid}' value=defaultCurrency disabled=true/>
	                        	</#if>
	                        	
	                           
	                            <input type="hidden" name="operationalHubCost_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getOperationalHubCost()?? > value="${proposalEMDetailsMap.get(emid).getOperationalHubCost()}" <#else> value="" </#if> >
	                        </div>
	                        <div class="form-select_div">
	                            <label>Other Cost</label>
	                            <script type="text/javascript">
	                                function otherCostChange(eId) {
	                                    var val = Number($j("input[name=otherCost-display_"+eId+"]").val().replace(/\,/g,''));
	                                    if(val) {
	                                        $j("input[name=otherCost_"+eId+"]").val(val);
	                                    } else {
	                                        $j("input[name=otherCost_"+eId+"]").val("");
	                                    }
	                                }
	                            </script>
	                            <input type="text" name="otherCost-display_${emid}" onchange="otherCostChange('${emid}')" disabled="disabled" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getOtherCost()?? > value="${proposalEMDetailsMap.get(emid).getOtherCost()}" <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat" >
	                           
	                            
	                            <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getOtherCostType()?? > 
	                        		<@renderCurrenciesField name='otherCostType_${emid}' value=proposalEMDetailsMap.get(emid).getOtherCostType() disabled=true/>
	                        	<#else>
	                        		<@renderCurrenciesField name='otherCostType_${emid}' value=defaultCurrency disabled=true/>
	                        	</#if>
	                        	
	                           
	                            <input type="hidden" name="otherCost_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getOtherCost()?? > value="${proposalEMDetailsMap.get(emid).getOtherCost()}" <#else> value="" </#if> >
	                        </div>
						
						</#if>
						
                        <div class="form-text_div">
                            <label>Name of Proposed Fieldwork Agencies</label>
                            <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getProposedFWAgencyNames()?? > 
                            	<input type="text" name="proposedFWAgencyNames_${emid}" value="${proposalEMDetailsMap.get(emid).getProposedFWAgencyNames()}" disabled="disabled" class="form-text-div" >
                            <#else>
                            	<input type="text" name="proposedFWAgencyNames_${emid}" value="" disabled="disabled" class="form-text-div" >
                            </#if>
                            <@macroCustomFieldErrors msg="Please enter Proposed Fieldwork Agencies"/>
                        </div>
                        <div class="form-text_div">
                            <label>Estimated Fieldwork Start</label>
                          
                           <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getFwStartDate()?? >
                               <#--<@jiveform.datetimepicker id="fwStartDate_${emid}" name="fwStartDate_${emid}" value=proposalEMDetailsMap.get(emid).getFwStartDate()?default('') readonly=true disablePrevDates=false/>-->
                               <input type="text" id="fwStartDate_${emid}" name="fwStartDate_${emid}" value="" disabled="disabled" class="form-text-div" >
                           <#else>	
                           	   <#--<@jiveform.datetimepicker id="fwStartDate_${emid}" name="fwStartDate_${emid}" value='' readonly=true disablePrevDates=false/>-->
                           	   <input type="text" id="fwStartDate_${emid}" name="fwStartDate_${emid}" value="" disabled="disabled" class="form-text-div" >
                           </#if>
                            <#assign error_msg><@s.text name='project.error.fwstartdate' /></#assign>
                            <@macroCustomFieldErrors msg=error_msg />
                        </div>
                        <div class="form-text_div">
                            <label>Estimated Fieldwork Completion</label>
                           <#-- <@jiveform.datetimepicker id="fwEndDate" name="fwEndDate" value=proposalEMDetails.fwEndDate?default('') readonly=true disablePrevDates=false/>-->
                           
                           <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getFwEndDate()?? >
                               <#-- <@jiveform.datetimepicker id="fwEndDate_${emid}" name="fwEndDate_${emid}" value=proposalEMDetailsMap.get(emid).getFwEndDate()?default('') readonly=true disablePrevDates=false/> -->
                                <input type="text" id="fwEndDate_${emid}" name="fwEndDate_${emid}" value="" disabled="disabled" class="form-text-div" >
                           <#else>	
                           	   <#-- <@jiveform.datetimepicker id="fwEndDate_${emid}" name="fwEndDate_${emid}" value='' readonly=true disablePrevDates=false/> -->
                           	   <input type="text" id="fwEndDate_${emid}" name="fwEndDate_${emid}" value="" disabled="disabled" class="form-text-div" >
                           </#if>
                            <#assign error_msg><@s.text name='project.error.fwenddate' /></#assign>
                            <@macroCustomFieldErrors msg=error_msg />
                        </div>
				
                        
                        <div class="form-select_div_main">
		                    <label class="label_b">Data Collection Methods</label>
		 					<#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getDataCollectionMethod()?? >
		                    	<@renderDataCollectionSelected name='dataCollectionMethod' value=proposalEMDetailsMap.get(emid).getDataCollectionMethod()?default('-1') multiselect=true class='form-multi-select' readonly=true id="dataCollectionMethod_${emid?c}"/>
		                     <#else>
                            	<@renderDataCollectionSelected name='dataCollectionMethod' value='-1' multiselect=true class='form-multi-select' readonly=true/>
                            </#if>
		                    <@macroFieldErrors name="collectionMethod"/>
		                </div>
                    </div>

                </div>
                <div class="pib-qualitative">
                    <#assign quantitative_display = 'none' />
                    <#if proposalInitiation.methodologyType?? && (proposalInitiation.methodologyType==1 || proposalInitiation.methodologyType==3) >
                        <#assign quantitative_display = 'block' />
                    </#if>

                    <div id="quantitative_div_${emid}" style="display:${quantitative_display};">
                        <h2 class="pib_sub_heading">Quantitative</h2>
                        <p class="induction_text">(If any of fields are not relevant, please put '0' in it.)</p>
                        <ul>
                            <li>
                                <div class="form-text_div">
                                    <label>Total Number of Interviews</label>
                                    <input type="text" name="totalNoInterviews-display_${emid}" disabled="disabled" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getTotalNoInterviews()?? && proposalEMDetailsMap.get(emid).getTotalNoInterviews() gt -1 >  value="${proposalEMDetailsMap.get(emid).getTotalNoInterviews()}" <#else> value="" </#if>  class="form-text-div numericfield numericformat no-decimal" >
                                    <@macroCustomFieldErrors msg='Please enter Total number of Interviews' />
                                    <@macroCustomFieldErrors msg="Please enter Total number of Interviews" class='numeric-error'/>
									<input type="hidden" name="totalNoInterviews_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getTotalNoInterviews()?? && proposalEMDetailsMap.get(emid).getTotalNoInterviews() gt -1>  value="${proposalEMDetailsMap.get(emid).getTotalNoInterviews()?c}" <#else> value="" </#if> >
                                </div>
                            </li>
                            <li>
                                <div class="form-text_div">
                                    <label>Total Number of Visits per Respondent</label>
                                    <input type="text" name="totalNoOfVisits-display_${emid}" disabled="disabled" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getTotalNoOfVisits()?? && proposalEMDetailsMap.get(emid).getTotalNoOfVisits() gt -1 >  value="${proposalEMDetailsMap.get(emid).getTotalNoOfVisits()}" <#else> value="" </#if> class="form-text-div numericfield numericformat no-decimal" >
                                    <@macroCustomFieldErrors msg='Please enter Total no of visits per respondent' />
                                    <@macroCustomFieldErrors msg="Please enter Total no of visits per respondent" class='numeric-error'/>
									<input type="hidden" name="totalNoOfVisits_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getTotalNoOfVisits()?? && proposalEMDetailsMap.get(emid).getTotalNoOfVisits() gt -1 >  value="${proposalEMDetailsMap.get(emid).getTotalNoOfVisits()?c}" <#else> value="" </#if> >
                                </div>
                            </li>
                            <li>
                                <div class="form-text_div">
                                    <label>Average Interview Duration (in minutes)</label>
                                    <input type="text" name="avIntDuration-display_${emid}" disabled="disabled" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getAvIntDuration()?? && proposalEMDetailsMap.get(emid).getAvIntDuration() gt -1 > value="${proposalEMDetailsMap.get(emid).getAvIntDuration()}" <#else> value="" </#if>  class="form-text-div numericfield numericformat no-decimal" >
                                    <@macroCustomFieldErrors msg='Please enter Average Interview Duration' />
                                    <@macroCustomFieldErrors msg="Please enter Average Interview Duration" class='numeric-error'/>
									<input type="hidden" name="avIntDuration_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getAvIntDuration()?? && proposalEMDetailsMap.get(emid).getAvIntDuration() gt -1 > value="${proposalEMDetailsMap.get(emid).getAvIntDuration()?c}" <#else> value="" </#if> >
                                </div>
                            </li>
                        </ul>
                        
                         <#assign geographical_spread_display = 'none' />
                    <#if proposalInitiation.methodologyType?? && (proposalInitiation.methodologyType==1 || proposalInitiation.methodologyType==2 || proposalInitiation.methodologyType==3) >
                        <#assign geographical_spread_display = 'block' />
                    </#if>
                    <div id="geographical_spread_div_${emid}" style="display:${geographical_spread_display};">
                        <div class="pib-report-requirement">
                            <label>Geographical Spread</label>
                            <table class="report_requirement_list">
                                <tbody>
                                <tr>
                                    
                                    <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getGeoSpreadNational()?? >
                                    	<td><@renderRadioBoxMultiMarket label='' name='geoSpread_${emid}' id='geoSpreadNational_${emid}' value='geoSpreadNational' isChecked=proposalEMDetailsMap.get(emid).getGeoSpreadNational()?default(false) disable=true selectedIndex=emid?c /></td>
                                    <#else>
                                    	<td><@renderRadioBoxMultiMarket label='' name='geoSpread_${emid}' id='geoSpreadNational_${emid}' value='geoSpreadNational' isChecked=false disable=true selectedIndex=emid?c /></td>
                                    </#if>
                                    <td class="view-row-first">National</td>
                                </tr>
                                <tr class="color-row">
                                   
                                   <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getGeoSpreadUrban()?? >
                                    	<td><@renderRadioBoxMultiMarket label=''  name='geoSpread_${emid}' id='geoSpreadUrban_${emid}' value='geoSpreadUrban' isChecked=proposalEMDetailsMap.get(emid).getGeoSpreadUrban()?default(false) disable=true selectedIndex=emid?c /></td>
                                   <#else>
                                   		<td><@renderRadioBoxMultiMarket label=''  name='geoSpread_${emid}' id='geoSpreadUrban_${emid}' value='geoSpreadUrban' isChecked=false disable=true selectedIndex=emid?c/></td>
                                   </#if>
                                    
                                    <td class="view-row-first">Non-National</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    <#--  Display cities section only when the Gerographical spread is Urban -->
                        <div class="form-text_div" id="cities_${emid}" style="display:${geographical_spread_display};">
                            <label>Please Define Geography</label>
                          
                            <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getCities()?? >
                            	<input type="text" name="cities_${emid}" id="cities_${emid}"  disabled="disabled" value="${proposalEMDetailsMap.get(emid).getCities()?default('')}" class="form-text-div" >
                            <#else>
                            	<input type="text" name="cities_${emid}" id="cities_${emid}" disabled="disabled" value="" class="form-text-div" >
                            </#if>
                        </div>
                    </div>
                    </div>
                    <#assign qualitative_display = 'none' />
                    <#if proposalInitiation.methodologyType?? && (proposalInitiation.methodologyType==2 || proposalInitiation.methodologyType==3) >
                        <#assign qualitative_display = 'block' />
                    </#if>

                    <div id="qualitative_div_${emid}" style="display:${qualitative_display};">
                        <h2 class="pib_sub_heading">Qualitative</h2>
                        <p class="induction_text">(If any of fields are not relevant, please put '0' in it.)</p>
                        <div class="form-text_div">
                            <label>Total No of Groups/In-Depth Interviews</label>
                            <input type="text" name="totalNoOfGroups-display_${emid}" disabled="disabled" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getTotalNoOfGroups()?? && proposalEMDetailsMap.get(emid).getTotalNoOfGroups() gt -1 > value="${proposalEMDetailsMap.get(emid).getTotalNoOfGroups()}" <#else> value="" </#if>  class="form-text-div numericfield numericformat no-decimal" >
                            <@macroCustomFieldErrors msg='Please enter Total No of Groups' />
                            <@macroCustomFieldErrors msg="Please enter Total No of Groups" class='numeric-error'/>
							<input type="hidden" name="totalNoOfGroups_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getTotalNoOfGroups()?? && proposalEMDetailsMap.get(emid).getTotalNoOfGroups() gt -1 > value="${proposalEMDetailsMap.get(emid).getTotalNoOfGroups()?c}" <#else> value="" </#if> >
                        </div>
                        <div class="form-text_div">
                            <label>Group/In-Interview Duration (in minutes)</label>
                            <input type="text" name="interviewDuration-display_${emid}" disabled="disabled" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getInterviewDuration()?? && proposalEMDetailsMap.get(emid).getInterviewDuration() gt -1 > value="${proposalEMDetailsMap.get(emid).getInterviewDuration()}" <#else> value="" </#if> class="form-text-div numericfield numericformat no-decimal" >
                            <@macroCustomFieldErrors msg='Please enter Group/In-Interview Duration' />
                            <@macroCustomFieldErrors msg="Please enter Group/In-Interview Duration" class='numeric-error'/>
							<input type="hidden" name="interviewDuration_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getInterviewDuration()?? && proposalEMDetailsMap.get(emid).getInterviewDuration() gt -1 > value="${proposalEMDetailsMap.get(emid).getInterviewDuration()?c}"  <#else> value="" </#if> >
                        </div>
                        <div class="form-text_div">
                            <label>Number of Respondents per Group</label>
                            <input type="text" name="noOfRespPerGroup-display_${emid}" disabled="disabled" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getNoOfRespPerGroup()?? && proposalEMDetailsMap.get(emid).getNoOfRespPerGroup() gt -1 > value="${proposalEMDetailsMap.get(emid).getNoOfRespPerGroup()}" </#if> class="form-text-div numericfield numericformat no-decimal" >
                            <@macroCustomFieldErrors msg='Please enter Number of Respondents per Group' />
                            <@macroCustomFieldErrors msg="Please enter Number of Respondents per Group" class='numeric-error'/>
							<input type="hidden" name="noOfRespPerGroup_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getNoOfRespPerGroup()?? && proposalEMDetailsMap.get(emid).getNoOfRespPerGroup() gt -1 > value="${proposalEMDetailsMap.get(emid).getNoOfRespPerGroup()?c}" <#else> value="" </#if> >
                        </div>
                    </div>
                   
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $j(document).ready(function() {
                $j("#addDataCollectionBtn_"+${emid}).click();
              
                 <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getGeoSpreadUrban()?? && proposalEMDetailsMap.get(emid).getGeoSpreadUrban() >
                    $j("#cities_"+${emid}).show();
                <#else>
                    $j("#cities_"+${emid}).hide();
                </#if>
            });
        </script>
    
    </div>
	</#list> 
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
                            <#if attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID >
                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c});"><@s.text name="global.remove" /></a>
                            </#if>
                            <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                            ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
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

