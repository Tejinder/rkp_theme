
<form name="pib" action="/synchro/pib-multi-details!execute.jspa" method="POST"  name="form-create" id="pib-form" class="research_pib pib" >

<div class="research_content">
<input type="hidden" name="projectID" value="${projectID?c}">
<input type="hidden" name="endMarketId" value="${endMarketId?c}">

<input type="hidden" name="isSave" value="${save?string}">

<div class="pib_inner_main">
<div class="pib_left">
   
    <div class="pib-select_div">
        <label><@s.text name="project.initiate.project.brand"/></label>
        <#if isAboveMarket>
            <@renderBrandField name='brand' value=project.brand?default('-1') readonly=true />

            <#assign error_msg><@s.text name='project.error.brand' /></#assign>
            <@macroCustomFieldErrors msg=error_msg />
        <#else>
            <@renderBrandField name='brand' value=project.brand?default('-1') readonly=true/>
            <#assign error_msg><@s.text name='project.error.brand' /></#assign>
            <@macroCustomFieldErrors msg=error_msg />
        </#if>

    </div>

    <div class="pib-select_div">
        <label>Countries</label>

        <@renderMultiEndMarketField name='updatedSingleMarketId1' value=emIds?default('-1') readonly=true />

       
        <#assign error_msg><@s.text name='project.error.endmarket' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
    </div>

    <div class="project_owner_names">
        <#if isAboveMarket>
            <label>SP&I Contact</label>
        <#else>
        	<label>Project Owner</label>
        </#if>
        <#if project.projectOwner &gt; 0>

            <#assign ownerUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner) />

        <#else>
            <#assign ownerUserName="" />
        </#if>
        <#if isAboveMarket>
            <#-- <input type="text" tabindex="1" name="projectOwner" id="projectOwner" class="j-user-autocomplete j-ui-elem" srole="20" autocomplete="off" /> -->
             <input type="text" name="projectOwnerRead" id="projectOwnerRead"  value="${ownerUserName}" disabled />
        <#else>
              <#if endMarketProjectOwner &gt; 0>
           		<#assign endMarketProjectOwnerUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(endMarketProjectOwner) />
           	  <#else>
            	<#assign endMarketProjectOwnerUserName="" />
        	  </#if>
           
            <input type="text" name="projectOwnerRead" id="projectOwnerRead"  value="${endMarketProjectOwnerUserName}" disabled />
        </#if>

    </div>

    <div class="project_owner_brief">
        <label>PIT Creator</label>

        <#if project.briefCreator &gt; 0>
            <#assign briefCreatorName = jiveContext.getSpringBean("userManager").getUser(project.briefCreator).getName() />
        <#else>
            <#assign briefCreatorName="" />
        </#if>
        <input type="text" name="briefCreator" id="briefCreator"  value="${briefCreatorName}" disabled />

    </div>

     <div class="project_owner_contact">
        
        <#if isAboveMarket>
        	<label>Project Owner</label>
        <#else>
        	<label>SP&I Contact</label>
        </#if>
        
        <#assign globalProjectContact = -1 />
        <#assign regionalProjectContact = -1 />
        <#assign areaProjectContact = -1 />
        <#assign countryProjectContact = -1 />
        
         <#assign displayNotifySPI = false>
         
        <#if isAboveMarket>
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
	           <#if user.ID == globalProjectContact>
	           		 <#assign displayNotifySPI = true>
	           </#if>
	        <#elseif regionalProjectContact &gt; 0>
	           <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(regionalProjectContact) />
	           <#if user.ID == regionalProjectContact>
	           		 <#assign displayNotifySPI = true>
	           </#if>
	        <#elseif areaProjectContact &gt; 0>
	           <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(areaProjectContact) />
	           <#if user.ID == areaProjectContact>
	           		 <#assign displayNotifySPI = true>
	           </#if>
	       <#-- <#elseif countryProjectContact &gt; 0>
	           <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(countryProjectContact) />-->
	         <#else>
	            <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner) />
	            <#assign aboveMarketProjectContactEmail = statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(project.projectOwner) />
	            <#if user.ID == project.projectOwner>
	           		 <#assign displayNotifySPI = true>
	           </#if>
	        </#if>
	    <#else>
	    	<#--
	    	<#list fundingInvestments as fundingInvestment>
	            <#if fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].COUNTRY.getId() && fundingInvestment.fieldworkMarketID == endMarketId>
	                <#assign countryProjectContact = fundingInvestment.projectContact />    
	            <#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].GlOBAL.getId()>
	                <#assign globalProjectContact = fundingInvestment.projectContact />
	            <#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].REGION.getId()>
	                <#assign regionalProjectContact = fundingInvestment.projectContact />
	            <#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].AREA.getId()>
	                <#assign areaProjectContact = fundingInvestment.projectContact />
	              
	            </#if>
	        </#list>
	        
	        <#if countryProjectContact &gt; 0>
	           <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(countryProjectContact) />
	        <#elseif globalProjectContact &gt; 0>
	           <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(globalProjectContact) />
	        <#elseif regionalProjectContact &gt; 0>
	           <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(regionalProjectContact) />
	        <#elseif areaProjectContact &gt; 0>
	           <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(areaProjectContact) />
	        <#else>
	            <#assign projectContactName="" />
	        </#if>
	        -->
	    </#if>


       
        
        <#if isAboveMarket>
          <#--  <input type="text" tabindex="1" name="spiContact" id="spiContact" class="j-user-autocomplete j-ui-elem" value="${spiContactName}" srole="1" autocomplete="off" />-->
          <input type="text" name="briefCreator" id="briefCreator"  value="${projectContactName}" disabled />
        <#else>
             <#if endMarketProjectContact &gt; 0>
           		<#assign endMarketProjectContactUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(endMarketProjectContact) />
           <#else>
            	<#assign endMarketProjectContactUserName="" />
        	</#if>
            <input type="text" name="briefCreator" id="briefCreator"  value="${endMarketProjectContactUserName}" disabled />
        </#if>
    </div>


   
    <div>
        <div class="form-date_div">
            <label>Estimated Project Start</label>
            <#if isAboveMarket>
                 <input type="text" name="startDate" id="startDate"  value="${project.startDate?string('dd/MM/yyyy')}" disabled />
            <#else>
                <input type="text" name="startDate" id="startDate"  value="${project.startDate?string('dd/MM/yyyy')}" disabled />
            </#if>
        </div>
        <@macroCustomFieldErrors msg=error_msg />
    </div>

    <div>
        <div class="form-date_div">
            <label>Estimated Project End</label>
            <#if isAboveMarket>
                 <input type="text" name="endDate" id="endDate"  value="${project.endDate?string('dd/MM/yyyy')}" disabled />
            <#else>
                <input type="text" name="endDate" id="endDate"  value="${project.endDate?string('dd/MM/yyyy')}" disabled />
            </#if>

        </div>
        <@macroCustomFieldErrors msg=error_msg />
    </div>
</div>

<div class="pib_right">
    <h3 class="pib_right_heading">Other Information</h3>

    <div class="region-inner">

        <label>Category Type</label>

        <@renderAllSelectedCategoryTypeField name='categoryTypeSelected' value=project.categoryType?default(-1) readonly=true />
        <#assign error_msg><@s.text name='project.error.category' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
    </div>


    <div class="form-select_div">
        <label><@s.text name="project.initiate.project.methodology"/></label>
        <#if isAboveMarket>
            <@renderMethodologyField name='methodologyType' value=project.methodologyType?default('-1') readonly=true />
            <#assign error_msg><@s.text name='project.error.methodology' /></#assign>
            <@macroCustomFieldErrors msg=error_msg />
        <#else>
            <@renderMethodologyField name='methodologyType' value=project.methodologyType?default('-1') readonly=true/>
            <#assign error_msg><@s.text name='project.error.methodology' /></#assign>
            <@macroCustomFieldErrors msg=error_msg />
        </#if>
    </div>
    <div class="form-select_div">
        <label><@s.text name="project.initiate.project.methodologygroup"/></label>
        <#if isAboveMarket>
            <@renderMethodologyGroupField name='methodologyGroup' value=project.methodologyGroup?default('-1') readonly=true />
            <#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
            <@macroCustomFieldErrors msg=error_msg />
        <#else>
            <@renderMethodologyGroupField name='methodologyGroup' value=project.methodologyGroup?default('-1') readonly=true/>
            <#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
            <@macroCustomFieldErrors msg=error_msg />
        </#if>
    </div>
    
    <div class="region-inner proposed-region">
            <label><@s.text name="project.initiate.project.methodologyproposed"/></label>
			<#assign defaultPMethodologyID = JiveGlobals.getJiveIntProperty("grail.synchro.default.proposedmethodology", -1) />
            <@displayProposedMethodologyMultiSelect name='proposedMethodology-display' value=project.proposedMethodology?default([defaultPMethodologyID]) />            
        </div>
    <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
    <#if !(isExternalAgencyUser || synchroPermHelper.isExternalAgencyUser(user) || isCommAgencyUser || synchroPermHelper.isCommunicationAgencyUser(user)) >
    	<#if isAboveMarketProjectContactUser || isProjectOwner || isProjectCreator || isGlobalSuperUser || isEndMarketSuperUser>
	        <div class="form-text_div pib_initial_cost">
	            <label>Total Cost</label>
	            <input type="text" name="name" value="${project.totalCost?default('')}" size="30" class="form-text-div numericfieldpib numericformat" disabled="true">
	            <@renderCurrenciesField name='intMgmtCostType' value=project.totalCostCurrency?default(defaultCurrency) disabled=true/>
	            <@macroCustomFieldErrors msg='' class='numeric-error' />
	            <#if isAboveMarket>
	                <a href="javascript:void(0);" onclick="javascript:openViewCostApprovalsWindow()" class="pib-multi-country pib-multi-cost">View Cost Approvals</a>
	            </#if>
	        </div>
	
	        <#if isAboveMarket>
	            <div class="form-text_div pib_initial_cost">
	                <label>Latest Estimate</label>
	                <script type="text/javascript">
	                    function latestEstimateChange() {
	                        var val = Number($j("input[name=latestEstimate-display]").val().replace(/\,/g,''));
	                        if(val) {
	                            $j("input[name=latestEstimate]").val(val);
	                        } else {
	                            $j("input[name=latestEstimate]").val("");
	                        }
	                    }
	                </script>
	                <input type="text" name="latestEstimate-display" autocomplete="off" disabled onchange="latestEstimateChange()"
	
	                    <#if projectInitiation.latestEstimate?? > value="${projectInitiation.latestEstimate}" <#else> value="" </#if> size="30" class="form-text-div numericfieldpib numericformat" >
	                <@renderCurrenciesField name='latestEstimateType' value=projectInitiation.latestEstimateType?default(defaultCurrency) disabled=true/>
	                <@macroCurrencySelectError msg="Please select currency" />
	                <@macroCustomFieldErrors msg='Please enter latest estimate' />
	                <@macroCustomFieldErrors msg="Please enter numeric value" class='numeric-error'/>
	                <input type="hidden" name="latestEstimate" <#if projectInitiation.latestEstimate?? > value="${projectInitiation.latestEstimate?c}" <#else> value="" </#if> >
	
	            </div>
	        </#if>
	     </#if>
    </#if>
	
	<#if !(isExternalAgencyUser || synchroPermHelper.isExternalAgencyUser(user) || isCommAgencyUser || synchroPermHelper.isCommunicationAgencyUser(user)) >
		 <#if isAboveMarketProjectContactUser || isProjectOwner || isCountryProjectContact || isCountrySPIContact>
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
				<input type="text" name="fieldworkCost-display" disabled <#if projectInitiation.fieldworkCost?? > value="${projectInitiation.fieldworkCost}" <#else> value="" </#if> size="30" class="form-text-div numericfieldpib numericformat longField">
				<@renderCurrenciesField name='fieldworkCostCurrency' value=projectInitiation.fieldworkCostCurrency?default(defaultCurrency) disabled=true/>	
				<input type="hidden" name="fieldworkCost" <#if projectInitiation.fieldworkCost?? > value="${projectInitiation.fieldworkCost?c}" <#else> value="" </#if> >			
			</div>
		 </#if>
	</#if>

    <div class="form-text_div npi-number">
        <label>NPI Number <br/> (if appropriate)</label>
        <input type="text" name="npiReferenceNo" autocomplete="off" disabled value="${projectInitiation.npiReferenceNo?default('')?html}" size="30" class="form-text-div numericfieldpib" >
        <@macroCustomFieldErrors msg='' class='numeric-error' />
    </div>


    <div class="form-select_div select-div">
        <label>CAP Rating</label>
        <@renderCAPRatingField name='capRating' value=project.capRating?default(-1) readonly=true/>
    </div>
    <div class="form-select_div select-div">
        <label>Request for Methodology Waiver</label>
        <#if isAboveMarket>
            <select name="deviationFromSM" id="deviationFromSM" class="form-select" onchange="checkMethDeviation()" disabled>
                <option value="0" <#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==0 > selected </#if>>No</option>
                <option value="1" <#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==1 > selected </#if>>Yes</option>
            </select>
        <#else>
            <select name="deviationFromSM" id="deviationFromSM" class="form-select" onchange="checkMethDeviation()" disabled>
                <option value="0" <#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==0 > selected </#if>>No</option>
                <option value="1" <#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==1 > selected </#if>>Yes</option>
            </select>
        </#if>

        <#if !(isExternalAgencyUser || isCommAgencyUser) >
            <script type="text/javascript">
                var initiateWaiverWindow = null;
                $j(document).ready(function(){
                    initiateWaiverWindow = new LIGHT_BOX($j("#initiateWaiver"),{title:'Request for Methodology Waiver'});

                });

            </script>
            <#assign showWaiverBtn = 'none' />
            <#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==1>
                <#assign showWaiverBtn = 'block' />
            </#if>
            <#if isAboveMarket>
                <ul class="right-sidebar-list">
                    <li id="initiateWaiverButton" style='display:${showWaiverBtn?string}'><a onclick="javascript:showInitiateWaiverWindow();" href="javascript:void(0);"><#if pibMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Initiate a Waiver</#if></a></li>
                </ul>
            </#if>
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
		<#if isAboveMarket>
			<textarea name="description" id="description" cols="30" rows="15"  disabled>${project.description?default('')?html}</textarea>  
			<@macroCustomFieldErrors msg="Please enter the Project description"/>      
		<#else>
			<textarea name="description" id="description" cols="30" rows="15"  disabled>${project.description?default('')?html}</textarea>
		</#if>        
    </div>  
	<textarea style="display:none;" id="descriptionText" name="descriptionText">${project.descriptionText?default('')?html}</textarea>
</div>

<#assign synchroUtils = jiveContext.getSpringBean("synchroUtils") />
<!-- ATTACHMENT WINDOW STARTS -->
<script type="text/javascript">
    var attachmentWindow = null;
    $j(document).ready(function(){
        attachmentWindow = new SYNCHRO_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/synchro/pib-multi-details!addAttachment.jspa'/>",
            projectID:${projectID?c},
            endMarketID:${endMarketId?c},
            items:[
                <#if isAboveMarket>
                    {id:${bussinessQuestionID?c},name:'Business Question'},
                    {id:${researchObjectiveID?c},name:'Research Objective(s)'},
                </#if>
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

//        $j("#endMarketIdAS").change(function(event) {
//            var as = $j('#endMarketIdAS option:selected').attr('as');
//            $j("#actionStandard1").val(as);
//        });
//        $j("#endMarketIdAS").trigger("change");
//
//        $j("#endMarketIdRD").change(function(event) {
//            var rd = $j('#endMarketIdRD option:selected').attr('as');
//            $j("#researchDesign1").val(rd);
//        });
//        $j("#endMarketIdRD").trigger("change");
//
//        $j("#endMarketIdSP").change(function(event) {
//            var sp = $j('#endMarketIdSP option:selected').attr('as');
//            $j("#sampleProfile1").val(sp);
//        });
//        $j("#endMarketIdSP").trigger("change");
//
//        $j("#endMarketIdSM").change(function(event) {
//            var sm = $j('#endMarketIdSM option:selected').attr('as');
//            $j("#stimulusMaterial1").val(sm);
//        });
//        $j("#endMarketIdSM").trigger("change");

    });

    function showAttachmentPopup(fieldId) {
        attachmentWindow.show(fieldId);
    }
</script>
<!-- ATTACHMENT WINDOW ENDS -->

<div class="region-inner">
	<label class='rte-editor-label'>Business Question</label>
    <div class="form-text_div">        
        <#if isAboveMarket>
            <textarea id="bizQuestion" name="bizQuestion" rows="10" cols="20" disabled class="form-text-div">${projectInitiation.bizQuestion?default('')?html}</textarea>
        <#else>
            <textarea id="bizQuestion" name="bizQuestion" rows="10" cols="20" class="form-text-div" disabled>${projectInitiation.bizQuestion?default('')?html}</textarea>
        </#if>
    </div>
	<textarea style="display:none;" id="bizQuestionText" name="bizQuestionText">${projectInitiation.bizQuestionText?default('')?html}</textarea>
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
	<label class='rte-editor-label'>Research Objectives(s)</label>
    <div class="form-text_div">        
        <#if isAboveMarket>
            <textarea id="researchObjective" name="researchObjective" rows="10" disabled cols="20" class="form-text-div">${projectInitiation.researchObjective?default('')?html}</textarea>          
        <#else>
            <textarea id="researchObjective" name="researchObjective" rows="10" cols="20" class="form-text-div" disabled>${projectInitiation.researchObjective?default('')?html}</textarea>
        </#if>
    </div>

<textarea style="display:none;" id="researchObjectiveText" name="researchObjectiveText">${projectInitiation.researchObjectiveText?default('')?html}</textarea>
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
                        ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})</a>
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
        <textarea id="actionStandard" name="actionStandard" rows="10" cols="20" disabled class="form-text-div">${projectInitiation.actionStandard?default('')?html}</textarea>       
    </div>
<textarea style="display:none;" id="actionStandardText" name="actionStandardText">${projectInitiation.actionStandardText?default('')?html}</textarea>
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

<div class="region-inner">
	<label class='rte-editor-label'>Methodology Approach and Research Design</label>
    <div class="form-text_div">        
        <textarea id="researchDesign" name="researchDesign" rows="10" cols="20" disabled class="form-text-div form-text-div-large">${projectInitiation.researchDesign?default('')?html}</textarea>       
    </div>
<textarea style="display:none;" id="researchDesignText" name="researchDesignText">${projectInitiation.researchDesignText?default('')?html}</textarea>
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

<div class="region-inner">
<label class='rte-editor-label'>Sample Profile (Research)</label>
    <div class="form-text_div">        
        <textarea id="sampleProfile" name="sampleProfile" rows="10" cols="20" disabled class="form-text-div">${projectInitiation.sampleProfile?default('')?html}</textarea>       
    </div>
<textarea style="display:none;" id="sampleProfileText" name="sampleProfileText">${projectInitiation.sampleProfileText?default('')?html}</textarea>
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

<div class="region-inner">
 <label class='rte-editor-label'>Stimulus Material
       
        
        </label>
    <div class="form-text_div">       
        <textarea id="stimulusMaterial" name="stimulusMaterial" rows="10" cols="20" disabled class="form-text-div">${projectInitiation.stimulusMaterial?default('')?html}</textarea>
      
    </div>
<textarea style="display:none;" id="stimulusMaterialText" name="stimulusMaterialText">${projectInitiation.stimulusMaterialText?default('')?html}</textarea>
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


<div class="region-inner">
<label class='rte-editor-label'>Other Comments</label>
    <div class="form-text_div">        
        <textarea id="others" name="others" rows="10" cols="20" disabled class="form-text-div">${projectInitiation.others?default('')?html}</textarea>     
    </div>
<textarea style="display:none;" id="othersText" name="othersText">${projectInitiation.othersText?default('')?html}</textarea>
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
        
         <input type="text" name="stimuliDate" id="stimuliDate"  value="<#if projectInitiation.stimuliDate??>${projectInitiation.stimuliDate?string('dd/MM/yyyy')}</#if>" disabled />

    </div>
</div>


<div class="pib-report-requirement">
    <label>Reporting Requirement</label>
    <table class="report_requirement_list">
        <tbody>
            <#if pibReporting?? >

            <tr>

                <td><@renderReportingCheckBox label='' name='topLinePresentation' isChecked=pibReporting.topLinePresentation?default(false) disable=true /></td>
                <td class="view-row-first">Full Report – Global Presentation</td>
            </tr>
            <tr class="color-row">
                <td><@renderReportingCheckBox label='' name='presentation' isChecked=pibReporting.presentation?default(false) disable=true /></td>
                <td class="view-row-first">Full Report – EM Presentation</td>
            </tr>
            <tr>
                <td><@renderReportingCheckBox label='' name='fullreport' isChecked=pibReporting.fullreport?default(false) disable=true /></td>
                <td class="view-row-first">Summary Report</td>
            </tr>
            <tr>
                <td><@renderReportingCheckBox label='' name='globalSummary' isChecked=pibReporting.globalSummary?default(false) disable=true /></td>
                <td class="view-row-first">Summary for IRIS</td>
            </tr>
            <#else>
            <tr>

                <td><@renderReportingCheckBox label='' name='topLinePresentation' isChecked=false disable=true /></td>
                <td class="view-row-first">Full Report – Global Presentation</td>
            </tr>
            <tr class="color-row">
                <td><@renderReportingCheckBox label='' name='presentation' isChecked=false disable=true /></td>
                <td class="view-row-first">Full Report – EM Presentation</td>
            </tr>
            <tr>
                <td><@renderReportingCheckBox label='' name='fullreport' isChecked=false disable=true /></td>
                <td class="view-row-first">Summary Report</td>
            </tr>
            <tr>
                <td><@renderReportingCheckBox label='' name='fullreport' isChecked=false disable=true /></td>
                <td class="view-row-first">Summary for IRIS</td>
            </tr>
            </#if>

        </tbody>
    </table>
    <@macroCustomFieldErrors msg="Please select reporting requirement"/>
</div>

<div class="region-inner">
	<label class='rte-editor-label'>Other Reporting Requirements</label>
    <div class="form-text_div">
        <textarea id="otherReportingRequirements" name="otherReportingRequirements" disabled rows="10" cols="20" class="form-text-div"><#if pibReporting?? >${pibReporting.otherReportingRequirements?default('')?html}</#if></textarea> 
    </div>
<textarea style="display:none;" id="otherReportingRequirementsText" name="otherReportingRequirementsText"><#if pibReporting?? >${pibReporting.otherReportingRequirementsText?default('')?html}</#if></textarea>
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


    <#if pibStakeholderList?? && pibStakeholderList.agencyContact1?? && pibStakeholderList.agencyContact1 &gt; 0>
        <#assign agency1UserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact1) />
    <#elseif pibAboveMarketStakeholderList?? && pibAboveMarketStakeholderList.agencyContact1?? && pibAboveMarketStakeholderList.agencyContact1 &gt; 0>

        <#assign agency1UserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibAboveMarketStakeholderList.agencyContact1) />

    <#else>
        <#assign agency1UserName="" />
    </#if>

    <#if pibStakeholderList?? &&  pibStakeholderList.agencyContact2?? && pibStakeholderList.agencyContact2 &gt; 0>
        <#assign agency2UserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact2) />
    <#elseif pibAboveMarketStakeholderList?? && pibAboveMarketStakeholderList.agencyContact2?? && pibAboveMarketStakeholderList.agencyContact2 &gt; 0>
        <#assign agency2UserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibAboveMarketStakeholderList.agencyContact2) />
    <#else>
        <#assign agency2UserName="" />
    </#if>

    <#if pibStakeholderList?? &&  pibStakeholderList.agencyContact3?? && pibStakeholderList.agencyContact3 &gt; 0>
        <#assign agency3UserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact3) />
    <#elseif pibAboveMarketStakeholderList?? && pibAboveMarketStakeholderList.agencyContact3?? && pibAboveMarketStakeholderList.agencyContact3 &gt; 0>
        <#assign agency3UserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibAboveMarketStakeholderList.agencyContact3) />
    <#else>
        <#assign agency3UserName="" />
    </#if>

    <#if pibStakeholderList?? &&  pibStakeholderList.globalLegalContact?? && pibStakeholderList.globalLegalContact &gt; 0>
        <#assign globalLegalContactUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.globalLegalContact) />
    <#else>
        <#assign globalLegalContactUserName="" />
    </#if>

    <#if pibStakeholderList?? &&  pibStakeholderList.globalProcurementContact?? && pibStakeholderList.globalProcurementContact &gt; 0>
        <#assign globalProcurementContactUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.globalProcurementContact) />
    <#else>
        <#assign globalProcurementContactUserName="" />
    </#if>
	
	<#if pibStakeholderList?? &&  pibStakeholderList.productContact?? && pibStakeholderList.productContact &gt; 0>
		<#assign productContactUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.productContact) />		
	<#else>
		<#assign productContactUserName="" />
	</#if>

    <#if pibStakeholderList?? &&  pibStakeholderList.globalCommunicationAgency?? && pibStakeholderList.globalCommunicationAgency &gt; 0>
        <#assign globalCommunicationAgencyUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.globalCommunicationAgency) />
    <#else>
        <#assign globalCommunicationAgencyUserName="" />
    </#if>

<div class="ld-div">

	<#if isAboveMarket>
		<#--<i style="color:black">(Please make your selection)</i></br> -->
		<#if projectInitiation.nonKantar?? && projectInitiation.nonKantar==1>
			<#--<input type="checkbox" name="nonKantar" id="nonKantar" value="true" checked="true" disabled  />&nbsp;&nbsp;Non-Kantar<br><i style="color:red">(Please select the checkbox for Non-Kantar related projects)</i> -->
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
	       <#--        $j("input[name=kantar]").removeAttr('checked'); -->
	
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
	        	
	           <#-- <li id="initiateKantarWaiverButton" <#if !projectInitiation.nonKantar>style="display:none"</#if>><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Initiate a Waiver</#if></a></li> -->
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
	 </#if>
	 

 <#if !(isExternalAgencyUser || isCommAgencyUser) >
    <!-- DETAILED STAKEHOLDER LIST STARTS -->
   
        <h3 class="pib_sub_heading">Detailed Stakeholder List</h3>
        <div class="pib_detail_st_list">
            <div class="form-select_div">
                <label>BAT Contact</label>

                <#if isAboveMarket>
                    <ul>
                        <li>
                            <span class="view_nums">1.</span> <input type="text" name="ag1" id="ag1"  value="${agency1UserName}" disabled />
                        </li>
                    <#--   <li class="optional-field">
                            <span class="view_nums">2.</span><input type="text" name="ag2" id="ag2"  value="${agency2UserName}" disabled />
                            <span  class="jive-field-message">(Optional)</span>
                        </li>
                        <li class="optional-field">
                            <span class="view_nums">3.</span><input type="text" name="ag3" id="ag3"  value="${agency3UserName}" disabled />
                            <span  class="jive-field-message">(Optional)</span>
                        </li> -->
                    </ul>
                <#else>
                    <ul>
                        <li>
                            <span class="view_nums">1.</span> <input type="text" name="ag1" id="ag1"  value="${agency1UserName}" disabled />
                        </li>
                  <#--      <li class="optional-field">
                            <span class="view_nums">2.</span><input type="text" name="ag2" id="ag2"  value="${agency2UserName}" disabled />
                            <span  class="jive-field-message">(Optional)</span>
                        </li>
                        <li class="optional-field">
                            <span class="view_nums">3.</span><input type="text" name="ag3" id="ag3"  value="${agency3UserName}" disabled />
                            <span  class="jive-field-message">(Optional)</span>
                        </li> 
                        -->
                    </ul>
                </#if>
            </div>

        </div>
        <span id="agencyContactError" class="jive-error-message" style="display:none">Please select atleast one Agency</span>

        <div class="pib_detail_st_list">

            <div class="form-select_div">
                <#if isAboveMarket>
                    <label>Above Market Legal Contact</label>
                <#else>
                    <label>Legal Contact</label>
                </#if>
                <ul>
                    <li class="view_field_row">
                       
                        <input type="text" name="gl" id="gl"  value="${globalLegalContactUserName}" disabled />
                    </li>
                </ul>
            </div>
            <span id="globalLegalContactError" class="jive-error-message" style="display:none">Please select Legal Contact</span>

		  <div class="form-select_div">
                <#if isAboveMarket>
                    <label>Above Market Product Contact</label>
                <#else>
                    <label>Product Contact</label>
                </#if>

                <ul>
                    <li class="view_field_row">
	                    <input type="text" name="gpr" id="gpr"  value="${productContactUserName}" disabled />
	                    <span  class="jive-field-message">(Mandatory for all the product tests)</span>
             	   </li>

                </ul>
           </div>
			
            <div class="form-select_div">
                <#if isAboveMarket>
                    <label>Above Market Procurement Contact</label>
                <#else>
                    <label>Procurement Contact</label>
                </#if>

                <ul>
                    <li class="view_field_row">
	                    <input type="text" name="gp" id="gp"  value="${globalProcurementContactUserName}" disabled />
	                    <span  class="jive-field-message">(Optional)</span>
             	   </li>

                </ul>
            </div>
            <div class="form-select_div">
                <#if isAboveMarket>
                    <label>Above Market Communication Agency</label>
                <#else>
                    <label>Communication Agency</label>
                </#if>

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
  
    <!-- DETAILED STAKEHOLDER LIST ENDS -->

    <!-- PROJECT CONTACT STAKEHOLDER STARTS -->
    <#if isAboveMarket>
        <div>
            <label class="label_b">Project Contact Stakeholders</label>
            <table class="multi-stakeholders">
                <#list fundingInvestments as fundingInvestment>
                    <#if fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].GlOBAL.getId()>

                        <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(fundingInvestment.projectContact) />
                        <tr><td>GLOBAL</td><td>${projectContactName}</td></tr>
                    </#if>
                    <#if fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].REGION.getId()>
                        <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(fundingInvestment.projectContact) />
                        <tr><td>REGIONAL</td><td>${projectContactName}</td></tr>
                    </#if>
                    <#if fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].AREA.getId()>
                        <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(fundingInvestment.projectContact) />
                        <tr><td>AREA</td><td>${projectContactName}</td></tr>
                    </#if>
                    <#if fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].COUNTRY.getId()>
                        <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(fundingInvestment.projectContact) />
                        <tr><td>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(fundingInvestment.fieldworkMarketID?int)}</td><td>${projectContactName}</td></tr>
                    </#if>

                </#list>
            </table>
        </div>
    </#if>
    <!-- PROJECT CONTACT STAKEHOLDER ENDS -->

     </#if>

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
