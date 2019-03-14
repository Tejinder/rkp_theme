<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#-- DWR def -->
<head>
    <script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>
	<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
    <script src="${themePath}/js/synchro/commons.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
	
</head>
<script src="${themePath}/js/synchro/form-data-persist-handler.js?version=1" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/project-sticky-header.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.MultiFile.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ajaxfileupload.js'/>"></script>

<#assign canEditProject = statics['com.grail.synchro.util.SynchroPermHelper'].canEditProjectByStatus(projectID) />
<#assign isExternalAgencyUser = statics['com.grail.synchro.util.SynchroPermHelper'].isExternalAgencyUser(projectID,statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID) />
<#assign isGlobalSuperUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroGlobalSuperUser(user) />
<#--
<#assign isRegionalSuperUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroRegionalSuperUser(user) />
<#assign isAreaSuperUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAreaSuperUser(user) />
-->

<script type="text/javascript">
    $j(document).ready(function(){
        AUTO_SAVE.register({form:$j("#proposal-form"), projectID:${projectID?c}});
        PROJECT_STICKY_HEADER.initialize();
    })
    <#if !isExternalAgencyUser || (proposalInitiation.isAwarded?? && proposalInitiation.isAwarded) || (proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted) || (isProposalAwarded?? && isProposalAwarded)>
    
    <#elseif !canEditProject>
    <#else>
	    $j(document).ready(function(){
	        FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#proposal-form"),form:$j("#email-notification-form"), projectID:${projectID?c}});
	    });
	</#if>

    function closeEmailNotification()
    {
        $j("#emailNotification").trigger('close');
    }
    function closeAttachmentWindow()
    {
        $j("#attachmentWindow").hide();
    }
    function validateAttachmentWindow()
    {
        if($j("#attachFile").val()=="")
        {
            dialog({title:"Message",html:"Please select attachment"});
            return false;
        }
        if(!$j("input:radio[name=fieldCategoryId]").is(":checked"))
        {
            dialog({title:"Message",html:"Please select option"});
            return false;
        }
        return true;
    }

   function notificationVal()
    {
       $j(".jive-error-message").each(function(index) {		
			$j(this).hide();			
		});
		
		showLoader('Please wait...');
        if($j.trim($j("#recipients").val())=='')
        {
			$j("#recipients").next().show();           
			hideLoader();
            return;
        }
		else
		{
		InviteUserUtil.validateEmailRegex($j("#recipients").val(), {
				callback: function(result) {				
					if(result!="")
					{
						$j("#recipients").next().show();
						$j("#recipients").next().text(result);
						$j("#recipients").focus();
						hideLoader();
						return;	
					}
					else
					{
						$j("#recipients").next().hide();	
					}					
					if($j.trim($j("#subject").val())=='')
					{
						$j("#subject").next().show();           
						hideLoader();
						return;
					}
					var messageBody = $j("#messageBodyDiv").html();		
					if($j.trim(messageBody)=='')
					{
						$j("#messageBody").next().show();           
						hideLoader();
						return;
					}					
					$j('#proposedMethodology option').attr('selected', 'selected');
					$j("#messageBody").val(messageBody);					
					$j("#email-notification-form").submit();
				},
				async: true
			});
		}		
    }
	
    function removeAttachment(attachmentId, fieldID, attachmentName) {
        dialog({
            title: 'Confirm Delete',
            html: '<p>Are you sure you want to remove the attachment </p>',
            buttons:{
                "DELETE":function() {
                    confirmDelete(attachmentId, fieldID, attachmentName);
                },
                "CANCEL": function() {
                    closeDialog();
                }
            }
        });

    }

    function confirmDelete(attachmentId, fieldID, attachmentName) {
        location.href="/synchro/proposal-multi-details!removeAttachment.jspa?projectID=${projectID?c}&attachmentId="+attachmentId+"&attachmentFieldID="+fieldID+"&attachmentName="+attachmentName;
        /*$j.ajax({
            url: "<@s.url value='/synchro/proposal-multi-details!removeAttachment.jspa'/>",
            type: 'POST',
            data:  "attachmentId="+attachmentId,
            success: onRemoveSuccess,
            error: onRemoveFailure
        });*/
    }
    function onRemoveSuccess(response, textStatus, jqXHR) {
        $j("#jive-file-list").hide();
    }
    function onRemoveFailure(jqXHR, textStatus, errorThrown) {

    }
</script>
<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/form-message.ftl" />
<@resource.template file="/soy/userpicker/userpicker.soy" />

<#assign bussinessQuestionID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].BUSINESS_QUESTION.getId()/>
<#assign researchObjectiveID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].RESEARCH_OBJECTIVE.getId()/>
<#assign actionStandardID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].ACTION_STANDARD.getId()/>
<#assign researchDesignID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].RESEARCH_DESIGN.getId()/>
<#assign sampleProfileID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].SAMPLE_PROFILE.getId()/>
<#assign stimulusMaterialID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].STIMULUS_MATERIAL.getId()/>
<#assign stimulusMaterialShippedID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].STIMULUS_MATERIAL_SHIPPED.getId()/>
<#assign otherReportingRequirementID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].OTHER_REPORTING_REQUIREMENT.getId()/>
<#assign othersID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].OTHERS.getId()/>
<#assign propCostTemplateID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].PROP_COST_TEMPLATE.getId()/>

<#assign defaultCurrency = statics['com.grail.synchro.util.SynchroUtils'].getDefaultCurrencyByProject(projectID) />

<!-- Setting locale to EN US for numeric formats -->
<#setting locale="en_US">

<!-- Page container -->
<div class="container">

<div class="project_names">


<div class="project_name_div">
<h2>Proposal <label style="font-size: 12px;">(<span class="red">*</span>Indicates the mandatory details needed to complete the stage)</label></h2>
<h2>${project.name?html} (${generateProjectCode('${projectID?c}')}) </h2>
<div class="print-btn">
    <input type="button" value="PRINT" class="j-btn-callout">
</div>
<#--<@renderProjectStagesTab projectID=projectID stageId=stageId />-->

<#if showMandatoryFieldsError?? && showMandatoryFieldsError>
<#--<span class="warning-msg"><span></span>Proposal cannot be completed until all the mandatory fields have not been filled.</span>-->
<div id="jive-error-box" class="jive-error-box warning" >
    <div>
        <#--<span class="jive-icon-med jive-icon-redalert"></span>-->
        <span><@s.text name="project.mandatory.proposal.error"/></span>
    </div>
</div>
</#if>


<#if agencyMap.size() gt 0 >

   
    <#--<#assign isSPIContactUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSPIContactUser(projectID,endMarketDetails.get(0).getEndMarketID()) />-->
    <#assign isProjectOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectOwner(projectID) />
    <#assign isAboveMarketProjectContact = statics['com.grail.synchro.util.SynchroPermHelper'].isAboveMarketProjectContact(projectID) />
    <#assign isRegionalProjectContact = statics['com.grail.synchro.util.SynchroPermHelper'].isRegionalProjectContact(projectID) />
    <#assign isAreaProjectContact = statics['com.grail.synchro.util.SynchroPermHelper'].isAreaProjectContact(projectID) />
  
   
    <#assign projectInitiation = jiveContext.getSpringBean("pibManager").getPIBDetails(projectID).get(0) />
	
	<#if proposalInitiation?? && proposalInitiation.endMarketID?? && (proposalInitiation.endMarketID>0)>
		<#assign projectInitiationByMarket = jiveContext.getSpringBean("pibManager").getPIBDetails(projectID, proposalInitiation.endMarketID).get(0) />
	<#else>
		<#assign projectInitiationByMarket = jiveContext.getSpringBean("pibManager").getPIBDetails(projectID, statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID).get(0) />
	</#if>
	
    <#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
    
<div class="main-sub-menus-div">
    <ul class="main-sub-menus">
        <#if agencyMap.get("Agency1")?? >
            <li><a href="/synchro/proposal-multi-details!input.jspa?projectID=${projectID?c}&agencyID=${agencyMap.get("Agency1")?c}" <#if agencyID == agencyMap.get("Agency1") >class="active"</#if>>${agencyDeptMap.get("Agency1")}</a></li>
        </#if>
        <#if agencyMap.get("Agency2")?? >
            <li><a href="/synchro/proposal-multi-details!input.jspa?projectID=${projectID?c}&agencyID=${agencyMap.get("Agency2")?c}" <#if agencyID == agencyMap.get("Agency2")>class="active"</#if>>${agencyDeptMap.get("Agency2")}</a></li>
        </#if>
        <#if agencyMap.get("Agency3")?? >
            <li><a href="/synchro/proposal-multi-details!input.jspa?projectID=${projectID?c}&agencyID=${agencyMap.get("Agency3")?c}" <#if agencyID == agencyMap.get("Agency3")>class="active"</#if>>${agencyDeptMap.get("Agency3")}</a></li>
        </#if>
    </ul>
</div>
    
    <#--<#if !isExternalAgencyUser && !isProjectOwner && !isAboveMarketProjectContact && !isAdminUser || (proposalInitiation.isAwarded?? && proposalInitiation.isAwarded && !isAdminUser) || (proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && !isAdminUser) || (isProposalAwarded?? && isProposalAwarded && !isAdminUser)>-->
    <#if !isExternalAgencyUser && !isProjectOwner && !isAboveMarketProjectContact && !isAdminUser || (proposalInitiation.isAwarded?? && proposalInitiation.isAwarded && !isAdminUser) || (isProposalAwarded?? && isProposalAwarded && !isAdminUser)>
    
        <#include "/template/global/proposal-multimarket-details-readonly.ftl" />
    <#elseif !canEditProject>
        <#include "/template/global/proposal-multimarket-details-readonly.ftl" />
    <#-- ELSE Block STARTS in case the user is External Agency User -->
    <#else>
    <form name="proposal" id="proposal-form" action="/synchro/proposal-multi-details!execute.jspa" method="POST" name="form-create" class="research_pib pib" >
    <div class="research_content">
    <input type="hidden" name="projectID" value="${projectID?c}">

    <input type="hidden" name="isSave" value="${save?string}">
    <input type="hidden" name="agencyID" value="${agencyID?c}">

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
                <@renderBrandField name='brand' value=proposalInitiation.brand?default('-1') />
                <#assign error_msg><@s.text name='project.error.brand' /></#assign>
                <@macroCustomFieldErrors msg=error_msg />
            </div>



            <div class="pib-select_div">
                <label>Countries</label>
                
                 <@renderMultiEndMarketField name='updatedSingleMarketId1' value=activeEndMarketIds?default('-1')/>
                <#assign error_msg><@s.text name='project.error.endmarket' /></#assign>
                <@macroCustomFieldErrors msg=error_msg />
            </div>

            <div class="project_owner_names">
               
            	<label>SP&I Contact</label>
        		
            <#-- <#if proposalInitiation.projectOwner?? && proposalInitiation.projectOwner &gt; 0>

    <#else>
        <#assign ownerUserName="" />
    </#if>
    <input type="text" tabindex="1" name="projectOwner" id="projectOwner" class="j-user-autocomplete j-ui-elem" srole="20" />-->

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

                <#--<@jiveform.datetimepicker id="startDate" name="startDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
				<@synchrodatetimepicker id="startDate" name="startDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
                <#assign error_msg><@s.text name='project.error.startdate' /></#assign>
                <@macroCustomFieldErrors msg=error_msg />
            </div>

            <div class="form-date_div">
                <label>Estimated Project End</label>
                <#--<@jiveform.datetimepicker id="endDate" name="endDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
				<@synchrodatetimepicker id="endDate" name="endDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
                <#assign error_msg><@s.text name='project.error.enddate' /></#assign>
                <@macroCustomFieldErrors msg=error_msg />
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
                <@renderMethodologyField name='methodologyType' value=proposalInitiation.methodologyType?default('-1') readonly=true/>
                <#assign error_msg><@s.text name='project.error.methodology' /></#assign>
                <@macroCustomFieldErrors msg=error_msg />
            </div>

            <div class="form-select_div">
                <label><@s.text name="project.initiate.project.methodologygroup"/></label>
                <@renderMethodologyGroupField name='methodologyGroup' value=proposalInitiation.methodologyGroup?default('-1')/>
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
                    <input type="text" name="npiReferenceNo" value="${proposalInitiation.npiReferenceNo?default('')?html}" size="30" class="form-text-div numericfield nonformatfield" >
                <#else>
                    <input type="text" name="npiReferenceNo" value="${projectInitiation.npiReferenceNo?default('')?html}" size="30" class="form-text-div numericfield nonformatfield" >
                </#if>
                <@macroCustomFieldErrors msg='' class='numeric-error' />
            </div>

			<div class="form-select_div select-div">
		 		<label>CAP Rating</label>
		 		<@renderCAPRatingField name='capRating' value=proposalInitiation.capRating?default(-1) readonly=false/>
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
            
           <#-- <#if !isExternalAgencyUser>-->
            <#if isAdminUser || isAboveMarketProjectContact || isGlobalSuperUser>
            	<#if !isExternalAgencyUser>
		             <div class="form-text_div pib_initial_cost">
			            <label>Total Cost</label>
			            <input type="text" name="name" value="${project.totalCost?default('')}" size="30" class="form-text-div numericfield numericformat longField" disabled="disabled">
			            <@renderCurrenciesField name='intMgmtCostType' value=project.totalCostCurrency?default(defaultCurrency) disabled=true/>
			            <@macroCustomFieldErrors msg='' class='numeric-error' />
			           
		      	     </div>
	      	     </#if>
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
            <textarea id="bizQuestion" name="bizQuestion" rows="10" cols="20" class="form-text-div">${proposalInitiation.bizQuestion?default('')?html}</textarea>
            <@macroCustomFieldErrors msg="Please enter Business Question" class='textarea-error-message'/>
        </div>
		<textarea style="display:none;" id="bizQuestionText" name="bizQuestionText">${proposalInitiation.bizQuestionText?default('')?html}</textarea>
		<textarea style="display:none;" id="bizQuestionPIBText" name="bizQuestionPIBText">${projectInitiationByMarket.bizQuestionText?default('')?html}</textarea>
        <!-- ATTACHMENT DISPLAY STARTS -->
        <div class="field-attachments">
            <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${bussinessQuestionID?c})"></span>
            <#if attachmentMap?? && attachmentMap.get(bussinessQuestionID)?? >
                <div id="jive-file-list" class="jive-attachments">
                    <#list attachmentMap.get(bussinessQuestionID) as attachment>
                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                            <span class="jive-icon-med jive-icon-attachment"></span>
                             <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${bussinessQuestionID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
            <textarea id="researchObjective" name="researchObjective" rows="10" cols="20" class="form-text-div">${proposalInitiation.researchObjective?default('')?html}</textarea>
            <@macroCustomFieldErrors msg="Please enter Research Objectives(s)" class='textarea-error-message'/>
        </div>
		<textarea style="display:none;" id="researchObjectiveText" name="researchObjectiveText">${proposalInitiation.researchObjectiveText?default('')?html}</textarea>
		<textarea style="display:none;" id="researchObjectivePIBText" name="researchObjectivePIBText">${projectInitiationByMarket.researchObjectiveText?default('')?html}</textarea>
        <!-- ATTACHMENT DISPLAY STARTS -->
        <div class="field-attachments">
            <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${researchObjectiveID?c})"></span>
            <#if attachmentMap?? && attachmentMap.get(researchObjectiveID)?? >
                <div id="jive-file-list" class="jive-attachments">
                    <#list attachmentMap.get(researchObjectiveID) as attachment>
                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                            <span class="jive-icon-med jive-icon-attachment"></span>
                            
                            <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${researchObjectiveID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
	            <textarea id="actionStandard_${proposalIniList.endMarketID}" name="actionStandard_${proposalIniList.endMarketID}" rows="10" cols="20" class="form-text-div">${proposalIniList.actionStandard?default('')?html}</textarea>
	            <@macroCustomFieldErrors msg="Please enter Action Standard(s)" class='textarea-error-message'/>
	        </div>
			<textarea style="display:none;" id="actionStandardText_${proposalIniList.endMarketID}" name="actionStandardText_${proposalIniList.endMarketID}">${proposalIniList.actionStandardText?default('')?html}</textarea>
			
			<#if jiveContext.getSpringBean("pibManager").getPIBDetails(projectID, proposalIniList.endMarketID).size() gt 0 >
				<#assign projectInitiationByIteration = jiveContext.getSpringBean("pibManager").getPIBDetails(projectID, proposalIniList.endMarketID).get(0) />
			</#if>
			
			<textarea style="display:none;" id="actionStandardPIBText_${proposalIniList.endMarketID}" name="actionStandardPIBText_${proposalIniList.endMarketID}"><#if projectInitiationByIteration?? && projectInitiationByIteration.actionStandardText??>${projectInitiationByIteration.actionStandardText?default('')?html}</#if></textarea>
	        <!-- ATTACHMENT DISPLAY STARTS -->
	        <div class="field-attachments">
	            <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${actionStandardID?c})"></span>
	            <#if attachmentMap?? && attachmentMap.get(actionStandardID)?? >
	                <div id="jive-file-list" class="jive-attachments">
	                    <#list attachmentMap.get(actionStandardID) as attachment>
	                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
	                            <span class="jive-icon-med jive-icon-attachment"></span>
	                            
	                             <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
	                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${actionStandardID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
	            <textarea id="researchDesign_${proposalIniList.endMarketID}" name="researchDesign_${proposalIniList.endMarketID}" rows="10" cols="20" class="form-text-div form-text-div-large">${proposalIniList.researchDesign?default('')?html}</textarea>
	            <@macroCustomFieldErrors msg="Please enter Methodology Approach and Research Design" class='textarea-error-message'/>
	        </div>
			<textarea style="display:none;" id="researchDesignText_${proposalIniList.endMarketID}" name="researchDesignText_${proposalIniList.endMarketID}">${proposalIniList.researchDesignText?default('')?html}</textarea>
			
			<#if jiveContext.getSpringBean("pibManager").getPIBDetails(projectID, proposalIniList.endMarketID).size() gt 0 >
				<#assign projectInitiationByIteration = jiveContext.getSpringBean("pibManager").getPIBDetails(projectID, proposalIniList.endMarketID).get(0) />
			</#if>
			<textarea style="display:none;" id="researchDesignPIBText_${proposalIniList.endMarketID}" name="researchDesignPIBText_${proposalIniList.endMarketID}"><#if projectInitiationByIteration?? && projectInitiationByIteration.researchDesignText??>${projectInitiationByIteration.researchDesignText?default('')?html}</#if></textarea>
	        <!-- ATTACHMENT DISPLAY STARTS -->
	        <div class="field-attachments">
	            <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${researchDesignID?c})"></span>
	            <#if attachmentMap?? && attachmentMap.get(researchDesignID)?? >
	                <div id="jive-file-list" class="jive-attachments">
	                    <#list attachmentMap.get(researchDesignID) as attachment>
	                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
	                            <span class="jive-icon-med jive-icon-attachment"></span>
	                            
	                             <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
	                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${researchDesignID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
	            <textarea id="sampleProfile_${proposalIniList.endMarketID}" name="sampleProfile_${proposalIniList.endMarketID}" rows="10" cols="20" class="form-text-div">${proposalIniList.sampleProfile?default('')?html}</textarea>
	            <@macroCustomFieldErrors msg="Please enter Sample Profile (Research)" class='textarea-error-message'/>
	        </div>
			<textarea style="display:none;" id="sampleProfileText_${proposalIniList.endMarketID}" name="sampleProfileText_${proposalIniList.endMarketID}">${proposalIniList.sampleProfileText?default('')?html}</textarea>
			
			<#if jiveContext.getSpringBean("pibManager").getPIBDetails(projectID, proposalIniList.endMarketID).size() gt 0 >
				<#assign projectInitiationByIteration = jiveContext.getSpringBean("pibManager").getPIBDetails(projectID, proposalIniList.endMarketID).get(0) />
			</#if>
			<textarea style="display:none;" id="sampleProfilePIBText_${proposalIniList.endMarketID}" name="sampleProfilePIBText_${proposalIniList.endMarketID}"><#if projectInitiationByIteration?? && projectInitiationByIteration.sampleProfileText??>${projectInitiationByIteration.sampleProfileText?default('')?html}</#if></textarea>
	        <!-- ATTACHMENT DISPLAY STARTS -->
	        <div class="field-attachments">
	            <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${sampleProfileID?c})"></span>
	            <#if attachmentMap?? && attachmentMap.get(sampleProfileID)?? >
	                <div id="jive-file-list" class="jive-attachments">
	                    <#list attachmentMap.get(sampleProfileID) as attachment>
	                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
	                            <span class="jive-icon-med jive-icon-attachment"></span>
	                            
	                             <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
	                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${sampleProfileID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
	            <textarea id="stimulusMaterial_${proposalIniList.endMarketID}" name="stimulusMaterial_${proposalIniList.endMarketID}" rows="10" cols="20" class="form-text-div">${proposalIniList.stimulusMaterial?default('')?html}</textarea>
	            <@macroCustomFieldErrors msg="Please enter Stimulus Material" class='textarea-error-message'/>
	        </div>
			<textarea style="display:none;" id="stimulusMaterialText_${proposalIniList.endMarketID}" name="stimulusMaterialText_${proposalIniList.endMarketID}">${proposalIniList.stimulusMaterialText?default('')?html}</textarea>
			
			
			<#if jiveContext.getSpringBean("pibManager").getPIBDetails(projectID, proposalIniList.endMarketID).size() gt 0 >
				<#assign projectInitiationByIteration = jiveContext.getSpringBean("pibManager").getPIBDetails(projectID, proposalIniList.endMarketID).get(0) />
			</#if>
			<textarea style="display:none;" id="stimulusMaterialPIBText_${proposalIniList.endMarketID}" name="stimulusMaterialPIBText_${proposalIniList.endMarketID}"><#if projectInitiationByIteration?? && projectInitiationByIteration.stimulusMaterialText??>${projectInitiationByIteration.stimulusMaterialText?default('')?html}</#if></textarea>
	        <!-- ATTACHMENT DISPLAY STARTS -->
	        <div class="field-attachments">
	            <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${stimulusMaterialID?c})"></span>
	            <#if attachmentMap?? && attachmentMap.get(stimulusMaterialID)?? >
	                <div id="jive-file-list" class="jive-attachments">
	                    <#list attachmentMap.get(stimulusMaterialID) as attachment>
	                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
	                            <span class="jive-icon-med jive-icon-attachment"></span>
	                            
	                             <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
	                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${stimulusMaterialID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
            <textarea id="stimulusMaterialShipped" name="stimulusMaterialShipped" rows="10" cols="20" class="form-text-div">${proposalInitiation.stimulusMaterialShipped?default('')?html}</textarea>
            <@macroCustomFieldErrors msg="Please enter Stimulus Material to be shipped to" class='textarea-error-message'/>
        </div>
        <!-- ATTACHMENT DISPLAY STARTS -->
        <div class="field-attachments">
            <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${stimulusMaterialShippedID?c})"></span>
            <#if attachmentMap?? && attachmentMap.get(stimulusMaterialShippedID)?? >
                <div id="jive-file-list" class="jive-attachments">
                    <#list attachmentMap.get(stimulusMaterialShippedID) as attachment>
                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                            <span class="jive-icon-med jive-icon-attachment"></span>
                            
                            <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${stimulusMaterialShippedID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
            <textarea id="others" name="others" rows="10" cols="20" class="form-text-div">${proposalInitiation.others?default('')?html}</textarea>
            <@macroCustomFieldErrors msg="Please enter Other Comments" class='textarea-error-message'/>
        </div>
		<textarea style="display:none;" id="othersText" name="othersText">${proposalInitiation.othersText?default('')?html}</textarea>
		<textarea style="display:none;" id="othersPIBText" name="othersPIBText">${projectInitiationByMarket.othersText?default('')?html}</textarea>
        <!-- ATTACHMENT DISPLAY STARTS -->
        <div class="field-attachments">
            <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${othersID?c})"></span>
            <#if attachmentMap?? && attachmentMap.get(othersID)?? >
                <div id="jive-file-list" class="jive-attachments">
                    <#list attachmentMap.get(othersID) as attachment>
                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                            <span class="jive-icon-med jive-icon-attachment"></span>
                            
                             <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${othersID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
           <#-- <@jiveform.datetimepicker id="stimuliDate" name="stimuliDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
		   <@synchrodatetimepicker id="stimuliDate" name="stimuliDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
            <@macroCustomFieldErrors msg='' />

        </div>
    </div>

    <div class="pib-report-requirement">
        <label>Reporting Requirement</label>
        <table class="report_requirement_list" id="report_requirement_list_id">
            <tbody>
            <tr>
                <td><@renderReportingCheckBox label='' name='topLinePresentation' isChecked=proposalReporting.topLinePresentation?default(false)/></td>
                <td class="view-row-first">Global Top Line Presentation</td>
            </tr>
            <tr class="color-row">
                <td><@renderReportingCheckBox label='' name='presentation' isChecked=proposalReporting.presentation?default(false)/></td>
                <td class="view-row-first">Global Presentation/Report</td>
            </tr>
            <tr>
                <td><@renderReportingCheckBox label='' name='fullreport' isChecked=proposalReporting.fullreport?default(false)/></td>
                <td class="view-row-first">EM Presentation/Report(s)</td>
            </tr>
            <tr>
                <td><@renderReportingCheckBox label='' name='globalSummary' isChecked=proposalReporting.globalSummary?default(false)/></td>
                <td class="view-row-first">Global Summary</td>
            </tr>

            </tbody>
        </table>

        <@macroCustomFieldErrors msg="Please select reporting requirement"/>

    </div>

    <div class="region-inner">
		<label class='rte-editor-label'>Other Reporting Requirements</label>
        <div class="form-text_div">            
            <textarea id="otherReportingRequirements" name="otherReportingRequirements" rows="10" cols="20" class="form-text-div">${proposalReporting.otherReportingRequirements?default('')?html}</textarea>
            <@macroCustomFieldErrors msg="Please enter Other Reporting Requirements" class='textarea-error-message'/>
        </div>
		<textarea style="display:none;" id="otherReportingRequirementsText" name="otherReportingRequirementsText">${proposalReporting.otherReportingRequirementsText?default('')?html}</textarea>
		<textarea style="display:none;" id="otherReportingRequirementsPIBText" name="otherReportingRequirementsPIBText">${pibReportingByMarket.otherReportingRequirementsText?default('')?html}</textarea>
        <!-- ATTACHMENT DISPLAY STARTS -->
        <div class="field-attachments">
            <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${otherReportingRequirementID?c})"></span>
            <#if attachmentMap?? && attachmentMap.get(otherReportingRequirementID)?? >
                <div id="jive-file-list" class="jive-attachments">
                    <#list attachmentMap.get(otherReportingRequirementID) as attachment>
                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                            <span class="jive-icon-med jive-icon-attachment"></span>
                            
                             <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${otherReportingRequirementID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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



    <!-- END MARKET FIELDS STARTS -->  <#list activeEndMarketIds as emid> 
    <div class="end_market_details" style="display:block;">
   
        <#-- <#assign emid = endMarketDetail.endMarketID /> -->
        <div class="">
            <h3 id="block_header_${emid}" onclick="javascript:toggleEndmarketBlock(${emid});">${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emid?int)}
                <a id="legend_${emid}" href="javascript:void();" class="close-form"></a>
            </h3>
            <div id="endMarket_${emid}" class="pib_angola" >
                <div class="pib_angola_left">

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
                        <#--<input type="text" name="totalCost-display_${emid}" onchange="totalCostChange('${emid}')" <#if proposalEMDetails.totalCost?? > value="${proposalEMDetails.totalCost}" <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat longField" >-->
                        <input type="text" name="totalCost-display_${emid}" onchange="totalCostChange('${emid}')" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getTotalCost()?? > value="${proposalEMDetailsMap.get(emid).getTotalCost()}" <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat longField" >
                        
                        <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getTotalCostType()?? > 
                        	<@renderCurrenciesField name='totalCostType_${emid}' value=proposalEMDetailsMap.get(emid).getTotalCostType() disabled=false/>
                        <#else>
                        	<@renderCurrenciesField name='totalCostType_${emid}' value=defaultCurrency disabled=false/>
                        </#if>
                        <@macroCurrencySelectError msg="Please select currency" />
                        <@macroCustomFieldErrors msg='Please enter Total Cost' />
                        <@macroCustomFieldErrors msg="" class='numeric-error'/>
                        <input type="hidden" name="totalCost_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getTotalCost()?? > value="${proposalEMDetailsMap.get(emid).getTotalCost()}" <#else> value="" </#if> >
                    </div>
                    <#assign internation_management_cost_display = 'none' />
                    <#if proposalInitiation.methodologyType?? && proposalInitiation.methodologyType!=4 >
                        <#assign internation_management_cost_display = 'block' />
                    </#if>

                    <div id="internation_management_cost_div_${emid}" style='display:${internation_management_cost_display};'>
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
                            <input type="text" name="intMgmtCost-display_${emid}" onchange="inititalMgmtCostChange('${emid}')" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getIntMgmtCost()?? > value="${proposalEMDetailsMap.get(emid).getIntMgmtCost()}" <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat longField" >
                            <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getIntMgmtCostType()?? > 
                        		<@renderCurrenciesField name='intMgmtCostType_${emid}' value=proposalEMDetailsMap.get(emid).getIntMgmtCostType() disabled=false/>
                        	<#else>
                        		<@renderCurrenciesField name='intMgmtCostType_${emid}' value=defaultCurrency disabled=false/>
                        	</#if>
                            <@macroCurrencySelectError msg="Please select currency" />
                            <@macroCustomFieldErrors msg='Please enter International Management Cost - Research Hub Cost' />
                            <@macroCustomFieldErrors msg="Please enter International Management Cost - Research Hub Cost" class='numeric-error'/>
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
                            <input type="text" name="localMgmtCost-display_${emid}" onchange="localMgmtCostChange('${emid}')" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getLocalMgmtCost()?? > value="${proposalEMDetailsMap.get(emid).getLocalMgmtCost()}"  <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat longField" >
                            
                            
                             <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getLocalMgmtCostType()?? > 
                        		<@renderCurrenciesField name='localMgmtCostType_${emid}' value=proposalEMDetailsMap.get(emid).getLocalMgmtCostType() disabled=false/>
                        	<#else>
                        		<@renderCurrenciesField name='localMgmtCostType_${emid}' value=defaultCurrency disabled=false/>
                        	</#if>
                        	
                            <@macroCurrencySelectError msg="Please select currency" />
                            <@macroCustomFieldErrors msg='Please enter Local Management Cost' />
                            <@macroCustomFieldErrors msg="Please enter Local Management Cost" class='numeric-error'/>
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
                            <input type="text" name="fieldworkCost-display_${emid}" onchange="fieldWorkCostChange('${emid}')" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getFieldworkCost()?? > value="${proposalEMDetailsMap.get(emid).getFieldworkCost()}"  <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat longField" >
                           
                             <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getFieldworkCostType()?? > 
                        		<@renderCurrenciesField name='fieldworkCostType_${emid}' value=proposalEMDetailsMap.get(emid).getFieldworkCostType() disabled=false/>
                        	<#else>
                        		<@renderCurrenciesField name='fieldworkCostType_${emid}' value=defaultCurrency disabled=false/>
                        	</#if>
                            <@macroCurrencySelectError msg="Please select currency" />
                            <@macroCustomFieldErrors msg='Please enter Fieldwork Cost' />
                            <@macroCustomFieldErrors msg="Please enter Fieldwork Cost" class='numeric-error'/>
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
                            <input type="text" name="operationalHubCost-display_${emid}" onchange="operationalHubCostChange('${emid}')" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getOperationalHubCost()?? > value="${proposalEMDetailsMap.get(emid).getOperationalHubCost()}" <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat longField" >
                           
                            
                            <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getOperationalHubCostType()?? > 
                        		<@renderCurrenciesField name='operationalHubCostType_${emid}' value=proposalEMDetailsMap.get(emid).getOperationalHubCostType() disabled=false/>
                        	<#else>
                        		<@renderCurrenciesField name='operationalHubCostType_${emid}' value=defaultCurrency disabled=false/>
                        	</#if>
                        	
                            <@macroCurrencySelectError msg="Please select currency" />
                            <@macroCustomFieldErrors msg='Please enter Operational Hub Cost' />
                            <@macroCustomFieldErrors msg="Please enter Operational Hub Cost" class='numeric-error'/>
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
                            <input type="text" name="otherCost-display_${emid}" onchange="otherCostChange('${emid}')" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getOtherCost()?? > value="${proposalEMDetailsMap.get(emid).getOtherCost()}" <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat longField" >
                           
                            
                            <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getOtherCostType()?? > 
                        		<@renderCurrenciesField name='otherCostType_${emid}' value=proposalEMDetailsMap.get(emid).getOtherCostType() disabled=false/>
                        	<#else>
                        		<@renderCurrenciesField name='otherCostType_${emid}' value=defaultCurrency disabled=false/>
                        	</#if>
                        	
                            <@macroCurrencySelectError msg="Please select currency" />
                            <@macroCustomFieldErrors msg='Please enter Other Cost' />
                            <@macroCustomFieldErrors msg="Please enter Other Cost" class='numeric-error'/>
                            <input type="hidden" name="otherCost_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid) ?? && proposalEMDetailsMap.get(emid).getOtherCost()?? > value="${proposalEMDetailsMap.get(emid).getOtherCost()}" <#else> value="" </#if> >
                        </div>

                        <div class="form-text_div">
                            <label>Name of Proposed Fieldwork Agencies</label>
                            <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getProposedFWAgencyNames()?? > 
                            	<input type="text" name="proposedFWAgencyNames_${emid}" value="${proposalEMDetailsMap.get(emid).getProposedFWAgencyNames()}" class="form-text-div" >
                            <#else>
                            	<input type="text" name="proposedFWAgencyNames_${emid}" value="" class="form-text-div" >
                            </#if>
                            <@macroCustomFieldErrors msg="Please enter Proposed Fieldwork Agencies"/>
                        </div>
                        <div class="form-text_div">
                            <label>Estimated Fieldwork Start</label>
                           
                           <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getFwStartDate()?? >
                              <#-- <@jiveform.datetimepicker id="fwStartDate_${emid}" name="fwStartDate_${emid}" value=proposalEMDetailsMap.get(emid).getFwStartDate()?default('') readonly=true disablePrevDates=false defaultDateTimePicker=false defaultDateTimePicker=false/>-->
							  <@synchrodatetimepicker id="fwStartDate_${emid}" name="fwStartDate_${emid}" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
                           <#else>	
                           	   <#--<@jiveform.datetimepicker id="fwStartDate_${emid}" name="fwStartDate_${emid}" value='' readonly=true disablePrevDates=false/> -->
							   <@synchrodatetimepicker id="fwStartDate_${emid}" name="fwStartDate_${emid}" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
                           </#if>
                            <#assign error_msg><@s.text name='project.error.fwstartdate' /></#assign>
                            <@macroCustomFieldErrors msg=error_msg />
                        </div>
                        <div class="form-text_div">
                            <label>Estimated Fieldwork Completion</label>
                         
                           
                           <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getFwEndDate()?? >
                              <#-- <@jiveform.datetimepicker id="fwEndDate_${emid}" name="fwEndDate_${emid}" value=proposalEMDetailsMap.get(emid).getFwEndDate()?default('') readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
							   <@synchrodatetimepicker id="fwEndDate_${emid}" name="fwEndDate_${emid}" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
                           <#else>	
                           	  <#-- <@jiveform.datetimepicker id="fwEndDate_${emid}" name="fwEndDate_${emid}" value='' readonly=true disablePrevDates=false defaultDateTimePicker=false/> -->
							  
							  <@synchrodatetimepicker id="fwEndDate_${emid}" name="fwEndDate_${emid}" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
                           </#if>
                            <#assign error_msg><@s.text name='project.error.fwenddate' /></#assign>
                            <@macroCustomFieldErrors msg=error_msg />
                        </div>
						
                        <div class="form-select_div_main">
                            <#assign dataCollectionIndex = emid?c/>
                            <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getDataCollectionMethod()?? >
                            	<@showDataCollectionFieldSection name='dataCollectionMethod' value=proposalEMDetailsMap.get(emid).getDataCollectionMethod()?default('-1') selectedIndex=dataCollectionIndex />
                            <#else>
                            	<@showDataCollectionFieldSection name='dataCollectionMethod' value='-1' selectedIndex=dataCollectionIndex />
                            </#if>
                            <@macroFieldErrors name="collectionMethod"/>
                            <span id="dataCollectionError_${emid}" class="jive-error-message" style="display:none">Please select Data Collection Method(s)</span>
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
                                    <input type="text" name="totalNoInterviews-display_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getTotalNoInterviews()?? && proposalEMDetailsMap.get(emid).getTotalNoInterviews() gt -1 >  value="${proposalEMDetailsMap.get(emid).getTotalNoInterviews()}" <#else> value="" </#if>  class="form-text-div numericfield numericformat no-decimal shortField" >
                                    <@macroCustomFieldErrors msg='Please enter Total number of Interviews' />
                                    <@macroCustomFieldErrors msg="Please enter Total number of Interviews" class='numeric-error'/>
									<input type="hidden" name="totalNoInterviews_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getTotalNoInterviews()?? && proposalEMDetailsMap.get(emid).getTotalNoInterviews() gt -1 >  value="${proposalEMDetailsMap.get(emid).getTotalNoInterviews()?c}" <#else> value="" </#if> >
                                </div>
                            </li>
                            <li>
                                <div class="form-text_div">
                                    <label>Total Number of Visits per Respondent</label>
                                    <input type="text" name="totalNoOfVisits-display_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getTotalNoOfVisits()?? && proposalEMDetailsMap.get(emid).getTotalNoOfVisits() gt -1 >  value="${proposalEMDetailsMap.get(emid).getTotalNoOfVisits()}" <#else> value="" </#if> class="form-text-div numericfield numericformat no-decimal shortField" >
                                    <@macroCustomFieldErrors msg='Please enter Total no of visits per respondent' />
                                    <@macroCustomFieldErrors msg="Please enter Total no of visits per respondent" class='numeric-error'/>
									<input type="hidden" name="totalNoOfVisits_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getTotalNoOfVisits()?? && proposalEMDetailsMap.get(emid).getTotalNoOfVisits() gt -1 >  value="${proposalEMDetailsMap.get(emid).getTotalNoOfVisits()?c}" <#else> value="" </#if> >
                                </div>
                            </li>
                            <li>
                                <div class="form-text_div">
                                    <label>Average Interview Duration (in minutes)</label>
                                    <input type="text" name="avIntDuration-display_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getAvIntDuration()?? && proposalEMDetailsMap.get(emid).getAvIntDuration() gt -1 > value="${proposalEMDetailsMap.get(emid).getAvIntDuration()}" <#else> value="" </#if>  class="form-text-div numericfield numericformat no-decimal shortField" >
                                    <@macroCustomFieldErrors msg='Please enter Average Interview Duration' />
                                    <@macroCustomFieldErrors msg="Please enter Average Interview Duration" class='numeric-error'/>
									<input type="hidden" name="avIntDuration_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getAvIntDuration()?? && proposalEMDetailsMap.get(emid).getAvIntDuration() gt -1 > value="${proposalEMDetailsMap.get(emid).getAvIntDuration()?c}" <#else> value="" </#if> >
                                </div>
                            </li>
                        </ul>
                        
                         <#assign geographical_spread_display = 'none' />
                    <#if proposalInitiation.methodologyType?? && (proposalInitiation.methodologyType==1 || proposalInitiation.methodologyType==3) >
                        <#assign geographical_spread_display = 'block' />
                    </#if>
                    <div id="geographical_spread_div_${emid}" style="display:${geographical_spread_display};">
                        <div class="pib-report-requirement">
                            <label>Geographical Spread</label>
                            <table class="report_requirement_list">
                                <tbody>
                                <tr>
                                    <#--<td><@renderRadioBox label='' name='geoSpread' id='geoSpreadNational' value='geoSpreadNational' isChecked=proposalEMDetails.geoSpreadNational?default(false)/></td>-->
                                    <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getGeoSpreadNational()?? >
                                    	<td><@renderRadioBoxMultiMarket label='' name='geoSpread_${emid}' id='geoSpreadNational_${emid}' value='geoSpreadNational' isChecked=proposalEMDetailsMap.get(emid).getGeoSpreadNational()?default(false) selectedIndex=emid?c /></td>
                                    <#else>
                                    	<td><@renderRadioBoxMultiMarket label='' name='geoSpread_${emid}' id='geoSpreadNational_${emid}' value='geoSpreadNational' isChecked=false selectedIndex=emid?c /></td>
                                    </#if>
                                    <td class="view-row-first">National</td>
                                </tr>
                                <tr class="color-row">
                                    <#--<td><@renderRadioBox label=''  name='geoSpread' id='geoSpreadUrban' value='geoSpreadUrban' isChecked=proposalEMDetails.geoSpreadUrban?default(false)/></td>-->
                                   <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getGeoSpreadUrban()?? >
                                    	<td><@renderRadioBoxMultiMarket label=''  name='geoSpread_${emid}' id='geoSpreadUrban_${emid}' value='geoSpreadUrban' isChecked=proposalEMDetailsMap.get(emid).getGeoSpreadUrban()?default(false) selectedIndex=emid?c /></td>
                                   <#else>
                                   		<td><@renderRadioBoxMultiMarket label=''  name='geoSpread_${emid}' id='geoSpreadUrban_${emid}' value='geoSpreadUrban' isChecked=false selectedIndex=emid?c/></td>
                                   </#if>
                                    
                                    <td class="view-row-first">Non-National</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    <#--  Display cities section only when the Gerographical spread is Urban -->
                        <div class="form-text_div" id="cities_${emid}" style="display:${geographical_spread_display};">
                            <label>Please Define Geography</label>
                            <#--<input type="text" name="cities"  value="${proposalEMDetails.cities?default('')}" class="form-text-div" >-->
                            <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getCities()?? >
                            	<input type="text" name="cities_${emid}" id="cities_${emid}"  value="${proposalEMDetailsMap.get(emid).getCities()?default('')}" class="form-text-div" >
                            <#else>
                            	<input type="text" name="cities_${emid}" id="cities_${emid}"  value="" class="form-text-div" >
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
                            <input type="text" name="totalNoOfGroups-display_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getTotalNoOfGroups()?? && proposalEMDetailsMap.get(emid).getTotalNoOfGroups() gt -1 > value="${proposalEMDetailsMap.get(emid).getTotalNoOfGroups()}" <#else> value="" </#if>  class="form-text-div numericfield numericformat no-decimal shortField" >
                            <@macroCustomFieldErrors msg='Please enter Total No of Groups' />
                            <@macroCustomFieldErrors msg="Please enter Total No of Groups" class='numeric-error'/>
							<input type="hidden" name="totalNoOfGroups_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getTotalNoOfGroups()?? && proposalEMDetailsMap.get(emid).getTotalNoOfGroups() gt -1 > value="${proposalEMDetailsMap.get(emid).getTotalNoOfGroups()?c}" <#else> value="" </#if> >
                        </div>
                        <div class="form-text_div">
                            <label>Group/In-Interview Duration (in minutes)</label>
                            <input type="text" name="interviewDuration-display_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getInterviewDuration()?? && proposalEMDetailsMap.get(emid).getInterviewDuration() gt -1 > value="${proposalEMDetailsMap.get(emid).getInterviewDuration()}" <#else> value="" </#if> class="form-text-div numericfield numericformat no-decimal shortField" >
                            <@macroCustomFieldErrors msg='Please enter Group/In-Interview Duration' />
                            <@macroCustomFieldErrors msg="Please enter Group/In-Interview Duration" class='numeric-error'/>
							<input type="hidden" name="interviewDuration_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getInterviewDuration()?? && proposalEMDetailsMap.get(emid).getInterviewDuration() gt -1 > value="${proposalEMDetailsMap.get(emid).getInterviewDuration()?c}"  <#else> value="" </#if> >
                        </div>
                        <div class="form-text_div">
                            <label>Number of Respondents per Group</label>
                            <input type="text" name="noOfRespPerGroup-display_${emid}" <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getNoOfRespPerGroup()?? && proposalEMDetailsMap.get(emid).getNoOfRespPerGroup() gt -1 > value="${proposalEMDetailsMap.get(emid).getNoOfRespPerGroup()}" </#if> class="form-text-div numericfield numericformat no-decimal shortField" >
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
		<label class='rte-editor-label'>Proposal and Cost Template<span class="red">*</span></label><p class="induction_text">(Please attach a proposal and click on the right icon to download the agency cost template.)</p>
       <div class="standard-report-download-link" style="top:-12px;">
              <a href="<@s.url value="/file/download/AgencyCostDetails-MultiMarketTemplate.xlsx"/>"></a>
         </div>
        <div class="form-text_div">            
            <textarea id="proposalCostTemplate" name="proposalCostTemplate" rows="10" cols="20">${proposalInitiation.proposalCostTemplate?default('Enter text and/or attach documents')?html}</textarea>
            <@macroCustomFieldErrors msg="Please enter Proposal Cost Template" class='textarea-error-message'/>
        </div>
        <!-- ATTACHMENT DISPLAY STARTS -->
        <div class="field-attachments">
            <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${propCostTemplateID?c})"></span>
            <#if attachmentMap?? && attachmentMap.get(propCostTemplateID)?? >
                <div id="jive-file-list" class="jive-attachments">
                    <#list attachmentMap.get(propCostTemplateID) as attachment>
                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                            <span class="jive-icon-med jive-icon-attachment"></span>
                            
                             <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${propCostTemplateID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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

        <div class="buttons">
            <#if editStage >

                <input type="submit" name="save pib" onclick="return validatePIBFormFields();" value="Save" class="save"/>
            </#if>
        </div>


    </div>

    </div>



    <!-- BEGIN sidebar column -->
    <div id="jive-body-sidebarcol-container" class="j-column j-column-s j-content-extras">
        <#include "/template/docs/synchro-doc-sidebar.ftl" />
    </div>
    <!-- END sidebar column -->
    </form>

    </#if>
<#-- ELSE Block ENDs in case the user is External Agency User -->

<!-- SYNCHRO BEGIN -->
<!-- EMAIL NOTIFICATION WINDOW -->
<div id="emailNotification" style="display:none">
    <form id="email-notification-form" action="<@s.url value="/synchro/proposal-multi-details!sendNotification.jspa"/>" method="post" enctype="multipart/form-data" class="j-form-popup">
        <a href="javascript:void(0);" class="close" onclick="closeEmailNotification();"></a>
        To <input type="text" id="recipients" name="recipients" value="" />
		<span class="jive-error-message" style="display:none" id="inviteEmail_error"><@s.text name="invite.email.error"/></span>
        Subject <input type="text" id="subject" name="subject" value="" />
		<span class="jive-error-message" style="display:none" id="inviteSubject_error"><@s.text name="invite.subject.error"/></span>
        Body <!--<textarea id="messageBody" name="messageBody" rows="15" cols="30" ></textarea>-->
        <div id="messageBodyDiv" name="messageBodyDiv" contenteditable></div>
        <textarea id="messageBody" name="messageBody" style="display:none;"></textarea>
		<span class="jive-error-message" style="display:none" id="inviteMessageBody_error"><@s.text name="invite.body.error"/></span>
		<!-- Attachments code -->		
		<#assign maxMailAttachs = JiveGlobals.getJiveIntProperty("grail.synchro.max.email.attachment", 5) />		
			<input type="file" name="mailAttachment" id="mailAttachment" multiple />
			  <ul id="mailAttachmentFileList">
				<!-- The file list will be shown here -->
			  </ul>
        <input type="hidden" id="projectID" name="projectID" value="" />
        <input type="hidden" id="notificationTabId" name="notificationTabId" value="" />
        <input type="hidden" id="stageId" name="stageId" value="" />
        <input type="hidden" id="docID" name="docID" value="" />
        <input type="hidden" id="approve" name="approve" value="" />

        <input type="hidden" name="agencyID" value="${parentAgencyID?c}">
      <#--  <input type="hidden" name="endMarketId" value="${proposalEndMarketId?c}"> -->

        <input class="j-btn-callout" type="button" name="doPost" id="postButton" onclick="return notificationVal();" value="Submit" style="font-weight: bold;" />

    </form>
</div>

<!-- ATTACHMENT WINDOW STARTS -->
<script type="text/javascript">
    var attachmentWindow = null;
    $j(document).ready(function(){
        attachmentWindow = new SYNCHRO_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/synchro/proposal-multi-details!addAttachment.jspa'/>",
            projectID:${projectID?c},
         <#--   endMarketID:${proposalEndMarketId?c}, -->
         	endMarketID:${statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID},
            parentForm:$j("#proposal-form"),
            items:[
                {id:${bussinessQuestionID?c},name:'Business Question'},
                {id:${researchObjectiveID?c},name:'Research Objective(s)'},
                {id:${actionStandardID?c},name:'Action Standard(s)'},
                {id:${researchDesignID?c},name:'Methodology Approach and Research design'},
                {id:${sampleProfileID?c},name:'Sample Profile (Research)'},
                {id:${stimulusMaterialID?c},name:'Stimulus Material'},
                {id:${stimulusMaterialShippedID?c},name:'Stimulus Material to be shipped to'},
                {id:${otherReportingRequirementID?c},name:'Other Reporting Requirements'},
                {id:${othersID?c},name:'Other Comments'},
                {id:${propCostTemplateID?c},name:'Proposal and Cost Template'}
            ]
        });

        $j("#fileAttachBtn").bind('click',function(){
            attachmentWindow.show();
        });

        $j("#methodologyType").change(function(event) {

            var $methodologyType = $j("#methodologyType").val();
           
           <#list activeEndMarketIds as emid> 
        <#-- <#assign emid = endMarketDetail.endMarketID /> -->
	            if($methodologyType==4)
	            {
	                $j("#internation_management_cost_div_${emid}").hide();
	            }
	            else
	            {
	                $j("#internation_management_cost_div_${emid}").show();
	            }
	
	            if($methodologyType==1 || $methodologyType==3)
	            {
	                $j("#quantitative_div_${emid}").show();
	            }
	            else
	            {
	                $j("#quantitative_div_${emid}").hide();
	            }
	
	            if($methodologyType==2 || $methodologyType==3)
	            {
	                $j("#qualitative_div_${emid}").show();
	
	            }
	            else
	            {
	                $j("#qualitative_div_${emid}").hide();
	
	            }
	            if($methodologyType==1 || $methodologyType==3)
	            {
	                $j("#geographical_spread_div_${emid}").show();
	            }
	            else
	            {
	                $j("#geographical_spread_div_${emid}").hide();
	            }
	        </#list>
        });
        $j("#methodologyType").trigger("change");

        <#if proposalInitiation.proposedMethodology??>
            $j("#proposedMethodology").val("${proposalInitiation.proposedMethodology}");
        </#if>
        
    });

    function showAttachmentPopup(fieldId) {
        attachmentWindow.show(fieldId);
    }
</script>
<!-- ATTACHMENT WINDOW ENDS -->



<!-- SUBMIT PROPOSAL FORM STARTS -->
<form name="submit-proposal-form" id="submit-proposal-form" action="<@s.url value='/synchro/proposal-multi-details!submitProposal.jspa'/>" method="post" >
    <input type="hidden" name="projectID" value="${projectID?c}">
    <input type="hidden" name="agencyID" value="${agencyID?c}">
    
</form>
<!-- SUBMIT PROPOSAL FORM ENDS -->

<!-- AWARD AGENCY FORM STARTS -->
<form name="awardAgency-form" id="awardAgency-form" action="<@s.url value='/synchro/proposal-multi-details!awardAgency.jspa'/>" method="post" >
    <input type="hidden" name="projectID" value="${projectID?c}">
    <input type="hidden" name="agencyID" value="${parentAgencyID?c}">
   <#-- <input type="hidden" name="endMarketId" value="${proposalEndMarketId?c}"> -->
</form>
<!-- AWARD AGENCY FORM ENDS -->

<!-- REJECT AGENCY FORM STARTS -->
<form name="rejectAgency-form" id="rejectAgency-form" action="<@s.url value='/synchro/proposal-multi-details!rejectAgency.jspa'/>" method="post" >
    <input type="hidden" name="projectID" value="${projectID?c}">
    <input type="hidden" name="agencyID" value="${parentAgencyID?c}">
 <#--  <input type="hidden" name="endMarketId" value="${proposalEndMarketId?c}"> -->
</form>
<!-- REJECT AGENCY FORM ENDS -->

</div>

<!-- SYNCHRO ENDS -->

<#else>
There are no Agencies selected for this project.
</#if>

</div>

<form method="POST" enctype="multipart/form-data" action="/synchro/generate-pdf.jspa" id="pdf_img_screen_form">	
    <input type="hidden" name="pdfImageDataURL" id="pdf_img_screen" value="" />
	<input type="hidden" name="projectId" id="projectId" value="${projectID?c}" />
	<input type="hidden" name="pdfFileName" id="pdfFileName" value="" />
	<input type="hidden" name="redirectURL" id="redirectURL" value="" />
	<input type="hidden" id="report-token" name="token" value="proposal-token-${user.ID?c}" />
	<input type="hidden" id="report-token-cookie" name="tokenCookie" value="pdfcookie" />
</form>


</div>
<script type="text/javascript">
$j(document).ready(function() {
    $j(document).ready(function(){
        PROJECT_STAGE_NAVIGATOR.initialize({
        <#if projectID??>
            projectId:${projectID?c},
        </#if>
            activeStage:3
        });
    });

    var projectOwner = -1;
<#if proposalInitiation?? && proposalInitiation.projectOwner??>
        projectOwner = ${proposalInitiation.projectOwner?c}
</#if>

      <#--  initializeUserPicker({$input:$j("#projectOwner"),name:'projectOwner',value:projectOwner,defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});-->
	    initializeUserPicker({$input:$j("#projectOwner"),name:'projectOwner',defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});


    /** Load User Pickers**/
    var spiContact = -1;
<#if proposalInitiation?? && proposalInitiation.spiContact??>
        spiContact = ${proposalInitiation.spiContact?c}
</#if>

      <#--  initializeUserPicker({$input:$j("#spiContact"),name:'spiContact',value: spiContact ,defaultFilters:{'role':1,'roleEnabled':false}});-->
	    initializeUserPicker({$input:$j("#spiContact"),name:'spiContact',defaultFilters:{'role':1,'roleEnabled':false}});

    /*Load start and end dates*/

var _startDate = <#if proposalInitiation?? && proposalInitiation.startDate?? >"${proposalInitiation.startDate?string('dd/MM/yyyy')}";<#else>"";</#if>
var _endDate = <#if proposalInitiation?? && proposalInitiation.endDate?? >"${proposalInitiation.endDate?string('dd/MM/yyyy')}";<#else>"";</#if>
var _stimuliDate = <#if proposalInitiation?? && proposalInitiation.stimuliDate?? >"${proposalInitiation.stimuliDate?string('dd/MM/yyyy')}";<#else>"";</#if>
	$j("#startDate").val(_startDate);
	$j("#endDate").val(_endDate);
	 $j("#stimuliDate").val(_stimuliDate);

<#list activeEndMarketIds as emid> 
        <#-- <#assign emid = endMarketDetail.endMarketID /> -->
                
		var _fwStartDate = <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getFwStartDate()?? >"${proposalEMDetailsMap.get(emid).getFwStartDate()?string('dd/MM/yyyy')}";<#else>"";</#if>
		var _fwEndDate = <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)?? && proposalEMDetailsMap.get(emid).getFwEndDate()?? >"${proposalEMDetailsMap.get(emid).getFwEndDate()?string('dd/MM/yyyy')}";<#else>"";</#if>
        $j("#fwStartDate_${emid}").val(_fwStartDate);
    	$j("#fwEndDate_${emid}").val(_fwEndDate);
</#list>

    /*Mandatory Fields Validation Start */
<#if showMandatoryFieldsError?? && showMandatoryFieldsError>
    var businessQuestion = $j("textarea[name=bizQuestion]");
    var researchObjective = $j("textarea[name=researchObjective]");
    var actionStandard = $j("textarea[name=actionStandard]");
    var researchDesign = $j("textarea[name=researchDesign]");
    var sampleProfile = $j("textarea[name=sampleProfile]");
    var stimulusMaterial = $j("textarea[name=stimulusMaterial]");
    var stimulusMaterialShipped = $j("textarea[name=stimulusMaterialShipped]");
    var proposalCostTemplate = $j("textarea[name=proposalCostTemplate]");
    
    var stimuliDate = $j("input[name=stimuliDate-display]");

    if(businessQuestion.val() != null && $j.trim(businessQuestion.val())=="")
    {
        //  businessQuestion.focus();

        <#if attachmentMap?? && attachmentMap.get(bussinessQuestionID)?? >
        <#else>
            businessQuestion.next().show();
        </#if>
    }
    if(researchObjective.val() != null && $j.trim(researchObjective.val())=="")
    {
        // researchObjective.focus();
        <#if attachmentMap?? && attachmentMap.get(researchObjectiveID)?? >
        <#else>
            researchObjective.next().show();
        </#if>
    }
    if(actionStandard.val() != null && $j.trim(actionStandard.val())=="")
    {
        // actionStandard.focus();
        <#if attachmentMap?? && attachmentMap.get(actionStandardID)?? >
        <#else>
            actionStandard.next().show();
        </#if>
    }
    if(researchDesign.val() != null && $j.trim(researchDesign.val())=="")
    {
        // researchDesign.focus();
        <#if attachmentMap?? && attachmentMap.get(researchDesignID)?? >
        <#else>
            researchDesign.next().show();
        </#if>
    }
    if(sampleProfile.val() != null && $j.trim(sampleProfile.val())=="")
    {
        // sampleProfile.focus();
        <#if attachmentMap?? && attachmentMap.get(sampleProfileID)?? >
        <#else>
            sampleProfile.next().show();
        </#if>
    }
    if(stimulusMaterial.val() != null && $j.trim(stimulusMaterial.val())=="")
    {
        //  stimulusMaterial.focus();
        <#if attachmentMap?? && attachmentMap.get(stimulusMaterialID)?? >
        <#else>
            stimulusMaterial.next().show();
        </#if>
    }
    if(stimulusMaterialShipped.val() != null && $j.trim(stimulusMaterialShipped.val())=="")
    {
        //  stimulusMaterialShipped.focus();
        <#if attachmentMap?? && attachmentMap.get(stimulusMaterialShippedID)?? >
        <#else>
            stimulusMaterialShipped.next().show();
        </#if>
    }
    if($j.trim(stimuliDate.val())=="")
    {
        // stimuliDate.focus();
        stimuliDate.parent().find("span").show();
        stimuliDate.parent().find("span").text("Please enter stimuli date");

    }
    var reportRequirementSelected = false;
    $j(".pib-report-requirement").find('input[type="checkbox"]:checked').each(function(){
        reportRequirementSelected = true;
    });

    if(!reportRequirementSelected)
    {
        // $j("#topLinePresentation_display").focus();
        $j(".pib-report-requirement").find("span").show();
    }
   
    if(proposalCostTemplate.val() != null && $j.trim(proposalCostTemplate.val())=="")
    {
        //  proposalCostTemplate.focus();
        <#if attachmentMap?? && attachmentMap.get(propCostTemplateID)?? >
        <#else>
            proposalCostTemplate.next().show();
        </#if>
    }


   
   <#list activeEndMarketIds as emid> 
        <#-- <#assign emid = endMarketDetail.endMarketID /> -->     
        
	   
	    var totalCost = $j("input[name=totalCost-display_${emid}]");
    	var totalCostType = $j("#totalCostType_${emid}");
    	var intMgmtCost = $j("input[name=intMgmtCost-display_${emid}]");
    	var intMgmtCostType = $j("#intMgmtCostType_${emid}");
    	var localMgmtCost = $j("input[name=localMgmtCost-display_${emid}]");
    	var localMgmtCostType = $j("#localMgmtCostType_${emid}");
    	var fieldworkCost = $j("input[name=fieldworkCost-display_${emid}]");
    	var fieldworkCostType = $j("#fieldworkCostType_${emid}");
    	var proposedFWAgencyNames = $j("input[name=proposedFWAgencyNames_${emid}]");
    	var totalNoInterviews = $j("input[name=totalNoInterviews-display_${emid}]");
    	var totalNoOfVisits = $j("input[name=totalNoOfVisits-display_${emid}]");
    	var avIntDuration = $j("input[name=avIntDuration-display_${emid}]");
    	var totalNoOfGroups = $j("input[name=totalNoOfGroups-display_${emid}]");
    	var interviewDuration = $j("input[name=interviewDuration-display_${emid}]");
    	var noOfRespPerGroup = $j("input[name=noOfRespPerGroup-display_${emid}]");
	    var fwStartDate = $j("input[name=fwStartDate_${emid}");
    	var  fwEndDate= $j("input[name=fwEndDate_${emid}]");
    
		
		if(totalCost.val() != null && $j.trim(totalCost.val())=="")
	    {
	      totalCost.parent().find("span:first").show();
	    }
	
	    if(intMgmtCost.val() != null && $j.trim(intMgmtCost.val())=="")
	    {
	      intMgmtCost.parent().find("span:first").show();
	    }
	
	    if(localMgmtCost.val() != null && $j.trim(localMgmtCost.val())=="")
	    {
	       localMgmtCost.parent().find("span:first").show();
	    }
	    if(fieldworkCost.val() != null && $j.trim(fieldworkCost.val())=="")
	    {
	       fieldworkCost.parent().find("span:first").show();
	    }
	
	    if(proposedFWAgencyNames.val() != null && $j.trim(proposedFWAgencyNames.val())=="")
	    {
	        proposedFWAgencyNames.next().show();
	    }
	
	    if(totalNoInterviews.val() != null && $j.trim(totalNoInterviews.val())=="")
	    {
	       totalNoInterviews.next().show();
	    }
	    if(totalNoOfVisits.val() != null && $j.trim(totalNoOfVisits.val())=="")
	    {
	        totalNoOfVisits.next().show();
	    }
	    if(avIntDuration.val() != null && $j.trim(avIntDuration.val())=="")
	    {
	       avIntDuration.next().show();
	    }
	
	    if(totalNoOfGroups.val() != null && $j.trim(totalNoOfGroups.val())=="")
	    {
	       totalNoOfGroups.next().show();
	    }
	    if(interviewDuration.val() != null && $j.trim(interviewDuration.val())=="")
	    {
	       interviewDuration.next().show();
	    }
	    if(noOfRespPerGroup.val() != null && $j.trim(noOfRespPerGroup.val())=="")
	    {
	       noOfRespPerGroup.next().show();
	    }
	   if($j.trim(fwStartDate.val())=="")
    	{
            fwStartDate.parent().find("span").show();
	        fwStartDate.parent().find("span").text("Please enter Estimated Fieldwork Start Date");
	    }
	    if($j.trim(fwEndDate.val())=="")
    	{
           fwEndDate.parent().find("span").show();
           fwEndDate.parent().find("span").text("Please enter Estimated Fieldwork Completion Date");
	    }
	    
	    <#if proposalEMDetailsMap?? && proposalEMDetailsMap.get(emid)??  && proposalEMDetailsMap.get(emid).getDataCollectionMethod()?? && proposalEMDetailsMap.get(emid).getDataCollectionMethod().size() gt 0 >
	    <#else>
	        dataCollectionError_${emid}.show();
	    </#if>
	</#list>

    $j(".textarea-error-message").each(function(){
        if($j(this).css('display') != 'none') {
            console.log($j(this).parent())
            $j(this).parent().parent().find(".field-attachments").addClass('required');
        } else {
            $j(this).parent().parent().find(".field-attachments").removeClass('required');
        }
    });
</#if>
    /*Mandatory Fields Validation Ends */


/** Load default hidden fields for User Picker selection **/
<#if proposalInitiation?? && proposalInitiation.spiContact?? && proposalInitiation.spiContact &gt; 0>
$j("input[name=spiContact]").val("${proposalInitiation.spiContact?c}");
</#if>

});

/*Code to track read status of the document for current user and project */
<#assign effectiveUser = statics['com.grail.synchro.util.SynchroPermHelper'].getEffectiveUser() />


function validatePIBFormFields()
{
	showLoader('Please wait...');
    var error = false;
    /*Check of there is numeric field error before submitting*/
    $j(".numericfield").each(function(){
        $j(this).parent().find("span").each(function(spanIndex) {
            if($j(this).hasClass('numeric-error') && $j(this).is(":visible"))
            {
                error = true;
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

    /* This is done for keeping the values in dataCollectionMethod select box as selected*/
<#if endMarketId?? >
   // $j('#dataCollectionMethod_${proposalEndMarketId} option').attr('selected', 'selected');
	$j('#dataCollectionMethod_${proposalEndMarketId} option').prop('selected', true);
</#if>


    var businessQuestion = $j("textarea[name=bizQuestion]");
    var researchObjective = $j("textarea[name=researchObjective]");
    var actionStandard = $j("textarea[name=actionStandard]");
    var researchDesign = $j("textarea[name=researchDesign]");

    var sampleProfile = $j("textarea[name=sampleProfile]");
    var stimulusMaterial = $j("textarea[name=stimulusMaterial]");
    var others = $j("textarea[name=others]");
    var otherReportingRequirements = $j("textarea[name=otherReportingRequirements]");
    var proposalCostTemplate = $j("textarea[name=proposalCostTemplate]");

    var globalPresentation = $j("input[name=globalPresentation]");
    var emPresentationWebex = $j("input[name=emPresentationWebex]");
    var emPresentationF2F = $j("input[name=emPresentationF2F]");
    var globalReport = $j("input[name=globalReport]");
    var emReport = $j("input[name=emReport]");

    var totalCost = $j("input[name=totalCost-display]");
    var totalCostType = $j("#totalCostType");
    var intMgmtCost = $j("input[name=intMgmtCost-display]");
    var intMgmtCostType = $j("#intMgmtCostType");
    var localMgmtCost = $j("input[name=localMgmtCost-display]");
    var localMgmtCostType = $j("#localMgmtCostType");
    var fieldworkCost = $j("input[name=fieldworkCost-display]");
    var fieldworkCostType = $j("#fieldworkCostType");

    var proposedFWAgencyNames = $j("input[name=proposedFWAgencyNames]");
    var totalNoInterviews = $j("input[name=totalNoInterviews-display]");
    var totalNoOfVisits = $j("input[name=totalNoOfVisits-display]");
    var avIntDuration = $j("input[name=avIntDuration-display]");
    var totalNoOfGroups = $j("input[name=totalNoOfGroups-display]");
    var interviewDuration = $j("input[name=interviewDuration-display]");
    var noOfRespPerGroup = $j("input[name=noOfRespPerGroup-display]");

    /**
     * Mandatory field check for Methodology, Methodology Group and Proposed Methodology
     **/
//    var methodologyType = $j("#methodologyType");
//    if(methodologyType.val()==null || methodologyType.val()<0)
//    {
//        if(!error)
//            methodologyType.focus();
//        methodologyType.next().show();
//        error = true;
//    }

    var methodologyGroup = $j("#methodologyGroup");
    if(methodologyGroup.val()==null || methodologyGroup.val()<0)
    {
        if(!error)
            methodologyGroup.focus();
        methodologyGroup.next().show();
        error = true;
    }

  

    /** Project start date and end date validations start **/
    var startDate = $j("input[name=startDate]");
    if(startDate.val() != null && $j.trim(startDate.val())=="")
    {
        if(!error)
            startDate.focus();
        startDate.parent().find("span").show();
        error = true;
    }
    else if(!isDateformat(startDate.val()))
    {
        if(!error)
            startDate.focus();
        startDate.parent().find("span").show();
        startDate.parent().find("span").text("Project start date should be in dd/mm/yyyy format");
        error = true;
    }


    var endDate = $j("input[name=endDate]");
    if(endDate.val() != null && $j.trim(endDate.val())=="")
    {
        if(!error)
            endDate.focus();
        endDate.parent().find("span").show();
        error = true;
    }
    else if(!isDateformat(endDate.val()))
    {
        if(!error)
            endDate.focus();
        endDate.parent().find("span").show();
        endDate.parent().find("span").text("Project end date should be in dd/mm/yyyy format");
        error = true;
    }

    if(isDateformat(startDate.val()) && isDateformat(endDate.val()) && !compareDate(startDate.val(), endDate.val()))
    {
        if(!error)
            startDate.focus();
        startDate.parent().find("span").show();
        startDate.parent().find("span").text("Project start date should be less than end date");
        error = true;
    }
    /** Project start date and end date validations ends **/

    /** Validations for PIB Text Fields starts**/
    /*
    if(businessQuestion.val() != null && $j.trim(businessQuestion.val())=="")
    {
        if(!error)
            businessQuestion.focus();
        error = true;
        businessQuestion.next().show();
    }
    if(researchObjective.val() != null && $j.trim(researchObjective.val())=="")
    {
        if(!error)
            researchObjective.focus();
        error = true;
        researchObjective.next().show();
    }
    if(actionStandard.val() != null && $j.trim(actionStandard.val())=="")
    {
        if(!error)
            actionStandard.focus();
        error = true;
        actionStandard.next().show();
    }
    if(researchDesign.val() != null && $j.trim(researchDesign.val())=="")
    {
        if(!error)
            researchDesign.focus();
        error = true;
        researchDesign.next().show();
    }
    if(sampleProfile.val() != null && $j.trim(sampleProfile.val())=="")
    {
        if(!error)
            sampleProfile.focus();
        error = true;
        sampleProfile.next().show();
    }
    if(stimulusMaterial.val() != null && $j.trim(stimulusMaterial.val())=="")
    {
        if(!error)
            stimulusMaterial.focus();
        error = true;
        stimulusMaterial.next().show();
    }
    if(others.val() != null && $j.trim(others.val())=="")
    {
        if(!error)
            others.focus();
        error = true;
        others.next().show();
    }
    */
    /** Validations for PIB Text Fields ends**/

    /** Project stimuliDate date format check starts**/
    var stimuliDate = $j("input[name=stimuliDate]");
    if($j.trim(stimuliDate.val())!="" && !isDateformat(stimuliDate.val()))
    {
        if(!error)
            stimuliDate.focus();
        stimuliDate.parent().find("span").show();
        stimuliDate.parent().find("span").text("Project start date should be in dd/mm/yyyy format");
        error = true;
    }
    /** Project stimuliDate date format check ends**/

    /* End Market Proposal Details starts*/

    /* if(totalCost.val() != null && $j.trim(totalCost.val())=="")
     {
         
         if(!error)
             totalCost.focus();
         totalCost.parent().find("span:first").show();
         error = true;
     }
     */

    if(totalCost.val() != null && $j.trim(totalCost.val())!="" && totalCostType.val()!= null && totalCostType.val()==-1)
    {
        if(!totalCost.parent().find("span:first").is(":visible"))
        {
            totalCost.parent().find("p").show();
        }
        if(!error)
        {
            totalCostType.focus();
        }
        error = true;
    }
    
    if(intMgmtCost.val() != null && $j.trim(intMgmtCost.val())!="" && intMgmtCostType.val()!= null && intMgmtCostType.val()==-1)
    {
        if(!intMgmtCost.parent().find("span:first").is(":visible"))
        {
            intMgmtCost.parent().find("p").show();
        }
        if(!error)
        {
            intMgmtCostType.focus();
        }
        error = true;
    }
  
    if(localMgmtCost.val() != null && $j.trim(localMgmtCost.val())!="" && localMgmtCostType.val()!= null && localMgmtCostType.val()==-1)
    {
        if(!localMgmtCost.parent().find("span:first").is(":visible"))
        {
            localMgmtCost.parent().find("p").show();
        }
        if(!error)
        {
            localMgmtCostType.focus();
        }
        error = true;
    }
   
    if(fieldworkCost.val() != null && $j.trim(fieldworkCost.val())!="" && fieldworkCostType.val()!= null && fieldworkCostType.val()==-1)
    {
        if(!fieldworkCost.parent().find("span:first").is(":visible"))
        {
            fieldworkCost.parent().find("p").show();
        }
        if(!error)
        {
            fieldworkCostType.focus();
        }
        error = true;
    }

    
    /** Project FieldWork start date and end date validations starts **/
    <#list activeEndMarketIds as emid> 
        <#-- <#assign emid = endMarketDetail.endMarketID /> -->
    var fwStartDate = $j("input[name=fwStartDate_${emid}]");
    var  fwEndDate= $j("input[name=fwEndDate_${emid}]");
    
    if($j.trim(fwStartDate.val())!="" && !isDateformat(fwStartDate.val()))
    {
        if(!error)
            fwStartDate.focus();
        fwStartDate.parent().find("span").show();
        fwStartDate.parent().find("span").text("Project start date should be in dd/mm/yyyy format");
        error = true;
    }
	
    if($j.trim(fwEndDate.val())!="" && !isDateformat(fwEndDate.val()))
    {
        if(!error)
            fwEndDate.focus();
        fwEndDate.parent().find("span").show();
        fwEndDate.parent().find("span").text("Project end date should be in dd/mm/yyyy format");
        error = true;
    }
	
    if(fwStartDate.val()!=null && $j.trim(fwStartDate.val())!="" && fwEndDate.val()!=null && $j.trim(fwEndDate.val())!="")
    {
        if(!compareDate(fwStartDate.val(), fwEndDate.val()))
        {
            if(!error)
                fwStartDate.focus();
            fwStartDate.parent().find("span").show();
            fwStartDate.parent().find("span").text("Fieldwork start date should be less than end date");
            error = true;
        }
    }
	
    if(fwStartDate.val()!=null && $j.trim(fwStartDate.val())!="" && startDate.val()!=null && $j.trim(startDate.val())!="")
    {
        if(!compareDate(startDate.val(), fwStartDate.val()))
        {
            if(!error)
                fwStartDate.focus();
            fwStartDate.parent().find("span").show();
            fwStartDate.parent().find("span").text("Fieldwork start date should fall within Project Start (Commissioning) and Project End (Results) dates");
            error = true;
        }
    }
    
    if(fwEndDate.val()!=null && $j.trim(fwEndDate.val())!="" && endDate.val()!=null && $j.trim(endDate.val())!="")
    {
        if(!compareDate(fwEndDate.val(), endDate.val()))
        {
            if(!error)
                fwEndDate.focus();
            fwEndDate.parent().find("span").show();
            fwEndDate.parent().find("span").text("Fieldwork start date should fall within Project Start (Commissioning) and Project End (Results) dates");
            error = true;
        }
    }
    
 </#list>
    /** Project FieldWork start date and end date validations starts **/
    
    /* End Market Proposal Details ends*/



    /** If no error in validation, then display formatted values for numeric fields are replaced to plain Integers for Struts Action Binding**/
    if(!error)
    {
        <#list activeEndMarketIds as emid> 
        <#-- <#assign emid = endMarketDetail.endMarketID /> -->
       
	        $j("input[name=totalCost_${emid}]").val($j("input[name=totalCost-display_${emid}]").val().replace(/\,/g, ''));
	        $j("input[name=intMgmtCost_${emid}]").val($j("input[name=intMgmtCost-display_${emid}]").val().replace(/\,/g, ''));
	        $j("input[name=localMgmtCost_${emid}]").val($j("input[name=localMgmtCost-display_${emid}]").val().replace(/\,/g, ''));
	        $j("input[name=fieldworkCost_${emid}]").val($j("input[name=fieldworkCost-display_${emid}]").val().replace(/\,/g, ''));
			$j("input[name=operationalHubCost_${emid}]").val($j("input[name=operationalHubCost-display_${emid}]").val().replace(/\,/g, ''));
			$j("input[name=otherCost_${emid}]").val($j("input[name=otherCost-display_${emid}]").val().replace(/\,/g, ''));
			//$j("input[name=otherCost]").val($j("input[name=otherCost-display]").val().replace(/\,/g, ''));
			$j("input[name=totalNoInterviews_${emid}]").val($j("input[name=totalNoInterviews-display_${emid}]").val().replace(/\,/g, ''));
			$j("input[name=totalNoOfVisits_${emid}]").val($j("input[name=totalNoOfVisits-display_${emid}]").val().replace(/\,/g, ''));
			$j("input[name=avIntDuration_${emid}]").val($j("input[name=avIntDuration-display_${emid}]").val().replace(/\,/g, ''));
			$j("input[name=totalNoOfGroups_${emid}]").val($j("input[name=totalNoOfGroups-display_${emid}]").val().replace(/\,/g, ''));
			$j("input[name=interviewDuration_${emid}]").val($j("input[name=interviewDuration-display_${emid}]").val().replace(/\,/g, ''));
			$j("input[name=noOfRespPerGroup_${emid}]").val($j("input[name=noOfRespPerGroup-display_${emid}]").val().replace(/\,/g, ''));	
			
			
			//$j('#dataCollectionMethod_${emid} option').attr('selected', 'selected');
			$j('#dataCollectionMethod_${emid} option').prop('selected', true);
			if($j('#dataCollectionMethod_${emid} option').size()!=null && $j('#dataCollectionMethod_${emid} option').size()==0)
			{	
				var input = $j("<input>").attr("type", "hidden").attr("name", "dataCollectionMethod_${emid}").val("-1");
				
				$j('#proposal-form').append($j(input));
			}
				
		</#list>
    }
	
if(error)
		hideLoader();
	
    return !error;
}

function toggleEndmarketBlock(id){
    var endMarketBlock = $j('#endMarket_'+id);
    endMarketBlock.toggle();
    // Expanded view
    if(endMarketBlock.css('display') == "block"){
        $j('#block_header_'+id).css('border-bottom', '1px solid #c9c9c9');
        $j('#legend_'+id).removeClass('open-form');
        $j('#legend_'+id).addClass('close-form');
    }
    // Closed/Minimized view
    else{
        $j('#block_header_'+id).css('border-bottom', 'none');
        $j('#legend_'+id).addClass('open-form');
        $j('#legend_'+id).removeClass('close-form');
    }
}

function sendNotificationFormat(recipients,subject,body,notificationTabId)
{
    return sendNotification(recipients,subject.replace(/"""/g ,"'"),body.replace(/"""/g ,"'"),notificationTabId);
}
function sendNotification(recipients,subject,body,notificationTabId)
{
    $j("#emailNotification").lightbox_me({centered:true,closeEsc:false,overlayCSS:{background: 'black', opacity: .7}});

    $j("#recipients").val(recipients);

    $j("#subject").val(subject);
    

	if(window.location.href.indexOf("https://preportal.bat.net") > -1) {
    
	   body = body.replace(/\/synchro_rkp/g,"https://preportal.bat.net");
       body = body.replace(/\preportal.bat.net/g,"irkpinsightstest.batgen.com");
    }
    if(window.location.href.indexOf("https://portal.bat.net") > -1) {
    
	   body = body.replace(/\/synchro_rkp/g,"https://portal.bat.net");
	   body = body.replace(/\portal.bat.net/g,"irkpinsights.batgen.com");
    }
    $j("#messageBodyDiv").html(body);
    $j("#projectID").val('${projectID?c}');
    $j("#notificationTabId").val(notificationTabId);
    $j("#stageId").val('${stageId}');

    $j("#agencyID").val('${agencyID?c}');
  <#--  $j("#endMarketId").val('${proposalEndMarketId?c}'); -->


    return false;
}

/*Auto Date Picker Events*/
$j("#startDate").click(function() {
    $j("#startDate_button").click();
});
$j("#endDate").click(function() {
    $j("#endDate_button").click();
});
$j("#stimuliDate").click(function() {
    $j("#stimuliDate_button").click();
});

$j("input[id^=fwStartDate]").click(function() {
	$j(this).next().next().click();    
});

$j("input[id^=fwEndDate]").click(function() {
    $j(this).next().next().click();
});

/*Brand ID - Name MAP*/
var brandFieldMap = {};
<#assign brandsMap = statics['com.grail.synchro.SynchroGlobal'].getBrands() />
<#list brandsMap.keySet() as brandMap>
brandFieldMap[${brandMap}] = "${brandsMap.get(brandMap)}";
</#list>

var selectedCategoryList = {};
var selectedProposedMethList = {};

<#if project?? && project.categoryType?? && (project.categoryType?size>0)>
	<#assign selectedCategoryObjList = project.categoryType />
	<#assign categoryTypesMap = statics['com.grail.synchro.SynchroGlobal'].getProductTypes() />
	var listCounter = 0;
	<#assign categoryTypeKeySet = categoryTypesMap.keySet() />
	<#list selectedCategoryObjList as selectedCategoryObj>
	<#if (categoryTypesMap?has_content)>
        <#list categoryTypeKeySet as key>
		<#if key?c == selectedCategoryObj?c>
            <#assign categoryType = categoryTypes.get(key) />			
			selectedCategoryList[listCounter] = "${categoryType}";
		</#if>	
        </#list>
    </#if>		
	listCounter = listCounter + 1;	
	</#list>   
</#if>
<#if proposalInitiation?? && proposalInitiation.proposedMethodology?? && (proposalInitiation.proposedMethodology?size>0)>
	<#assign selectedProposedMethObjList = proposalInitiation.proposedMethodology />
	<#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getMethodologies() />
	
	var listCounter = 0;
	<#assign methodologiesKeySet = methodologies.keySet() />
	<#list selectedProposedMethObjList as selectedProposedMethObj>	
	<#if (methodologies?has_content)>
        <#list methodologiesKeySet as key>
		<#if key?c == selectedProposedMethObj?c>
            <#assign proposedMethodology = methodologies.get(key) />			
			selectedProposedMethList[listCounter] = "${proposedMethodology}";
		</#if>	
        </#list>
    </#if>		
	listCounter = listCounter + 1;	
	</#list>   
</#if>

/*Code to track read status of the document for current user and project */
ProjectReadTracker.setReadTrackInfo(${projectID?c}, ${user.ID?c}, 2);


/* Initialization of Editor */
$j(document).ready(function () {
	initiateRTE('description', 1500, true, false);
	initiateRTE('bizQuestion', 900, true, true);
	initiateRTE('researchObjective', 900, true, true);
	
	
	<#list proposalInitiationList as proposalIniList>		
		initiateRTE("actionStandard_${proposalIniList.endMarketID}", 900, true, true);
		initiateRTE("sampleProfile_${proposalIniList.endMarketID}", 900, true, true);
		initiateRTE("stimulusMaterial_${proposalIniList.endMarketID}", 900, true, true);
		initiateRTE("researchDesign_${proposalIniList.endMarketID}", 2500, true, true);		
	</#list>	
	
	initiateRTE('others', 900, true, true);
	initiateRTE('stimulusMaterialShipped', 900, false, false);	
	initiateRTE('proposalCostTemplate', 900, false, false);	
	initiateRTE('otherReportingRequirements', 900, true, true);	
	
	//Change Events
	//Change Events
	$j( "#brand" ).change(function() {
		var pibBrand = "<#if project.brand??>${project.brand?c}<#else></#if>"; 
		var proposalBrand = $j(this).val();		
		if(pibBrand==proposalBrand)
		{
			if($j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).removeClass('proposal-highlighted-textbox');
			}
		}
		else
		{			
			if(!$j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).addClass('proposal-highlighted-textbox');
			}
		}
	});
	
	//TODO
	$j( "#updatedSingleMarketId" ).change(function() {
		var pibCountryID= "<#if endMarketId??>${endMarketId?c}<#else></#if>"; 
		var proposalCountryID = $j(this).val();		
		if(pibCountryID==proposalCountryID)
		{
			if($j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).removeClass('proposal-highlighted-textbox');
			}
		}
		else
		{			
			if(!$j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).addClass('proposal-highlighted-textbox');
			}
		}
	});
	
	
	
	$j( "#methodologyType" ).change(function() {
		var pibMethodologyType = "<#if project.methodologyType??>${project.methodologyType?c}<#else></#if>"; 
		var proposalMethodologyType = $j(this).val();		
		if(pibMethodologyType==proposalMethodologyType)
		{
			if($j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).removeClass('proposal-highlighted-textbox');
			}
		}
		else
		{			
			if(!$j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).addClass('proposal-highlighted-textbox');
			}
		}
	});
	
	$j( "#methodologyGroup" ).change(function() {
		var pibMethodologyGroup = "<#if project.methodologyGroup??>${project.methodologyGroup?c}<#else></#if>"; 
		var proposalMethodologyGroup = $j(this).val();		
		if(pibMethodologyGroup==proposalMethodologyGroup)
		{
			if($j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).removeClass('proposal-highlighted-textbox');
			}
		}
		else
		{			
			if(!$j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).addClass('proposal-highlighted-textbox');
			}
		}
	});
	
	$j("input[name=npiReferenceNo]").change(function() {		
		var pibNPIRefNo = "<#if projectInitiationByMarket?? && projectInitiationByMarket.npiReferenceNo??>${projectInitiationByMarket.npiReferenceNo}<#else></#if>";		
		var proposalNPIRefNo = $j(this).val();		
		if(pibNPIRefNo==proposalNPIRefNo)
		{
			if($j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).removeClass('proposal-highlighted-textbox');
			}
		}
		else
		{			
			if(!$j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).addClass('proposal-highlighted-textbox');
			}
		}
	});

	$j("#startDate").change(function() {
		var pibStartDate = "<#if project?? && project.startDate??>${project.startDate?string('dd/MM/yyyy')}<#else></#if>";
		var proposalStartDate = $j(this).val();		
		if(pibStartDate==proposalStartDate)
		{
			if($j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).removeClass('proposal-highlighted-textbox');
			}
		}
		else
		{			
			if(!$j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).addClass('proposal-highlighted-textbox');
			}
		}	
	});
	
	$j("#endDate").change(function() {
		var pibEndDate = "<#if project?? && project.endDate??>${project.endDate?string('dd/MM/yyyy')}<#else></#if>";
		var proposalEndDate = $j(this).val();		
		if(pibEndDate==proposalEndDate)
		{
			if($j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).removeClass('proposal-highlighted-textbox');
			}
		}
		else
		{			
			if(!$j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).addClass('proposal-highlighted-textbox');
			}
		}	
	});
	
	
	$j("#stimuliDate").change(function() {
		var pibStimuliDate = "<#if projectInitiationByMarket?? && projectInitiationByMarket.stimuliDate??>${projectInitiationByMarket.stimuliDate?string('dd/MM/yyyy')}<#else></#if>";
		var proposalStimuliDate = $j(this).val();		
		if(pibStimuliDate==proposalStimuliDate)
		{
			if($j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).removeClass('proposal-highlighted-textbox');
			}
		}
		else
		{			
			if(!$j(this).hasClass('proposal-highlighted-textbox'))
			{
				$j(this).addClass('proposal-highlighted-textbox');
			}
		}	
	});
	
	$j(".pib-report-requirement .check-field input[type=checkbox]").change(function() {					
			var showHighlighted = false;
			//topLinePresentation
			var pibTopLinePresentation = "<#if pibReportingByMarket.topLinePresentation??>${pibReportingByMarket.topLinePresentation?string}<#else>false</#if>"
			var checked = "false";
			var proposalTopLinePresentation = $j("input[name=topLinePresentation_display]");
			if(proposalTopLinePresentation.attr("checked"))
			{
				var checked = "true";				
			}
			var reportingTableElement = $j(".report_requirement_list ");			
			if(pibTopLinePresentation!=checked)
			{
				showHighlighted = true;
			}			
			
			//presentation
			var pibPresentation = "<#if pibReportingByMarket.presentation??>${pibReportingByMarket.presentation?string}<#else>false</#if>"
			var checked = "false";
			var proposalPresentation = $j("input[name=presentation_display]");
			if(proposalPresentation.attr("checked"))
			{
				var checked = "true";				
			}
			var reportingTableElement = $j(".report_requirement_list ");			
			if(pibPresentation!=checked)
			{
				showHighlighted = true;
			}
			
			//fullreport
			var pibFullreport = "<#if pibReportingByMarket.fullreport??>${pibReportingByMarket.fullreport?string}<#else>false</#if>"
			var checked = "false";
			var proposalFullreport = $j("input[name=fullreport_display]");
			if(proposalFullreport.attr("checked"))
			{
				var checked = "true";				
			}
			var reportingTableElement = $j("#report_requirement_list_id ");			
			if(pibFullreport!=checked)
			{
				showHighlighted = true;
			}

			//Global Summary 
			var pibGlobalSummary = "<#if pibReportingByMarket.globalSummary??>${pibReportingByMarket.globalSummary?string}<#else>false</#if>"
			var checked = "false";
			var proposalGlobalSummary = $j("input[name=globalSummary_display]");
			if(proposalGlobalSummary.attr("checked"))
			{
				var checked = "true";				
			}
			var reportingTableElement = $j(".report_requirement_list ");			
			if(pibGlobalSummary!=checked)
			{
				showHighlighted = true;
			}				
			
			if(showHighlighted)
			{
				if(!reportingTableElement.hasClass('proposal-highlighted-textbox'))
				{
					reportingTableElement.addClass('proposal-highlighted-textbox');
				}
			}
			else
			{
				if(reportingTableElement.hasClass('proposal-highlighted-textbox'))
				{
					reportingTableElement.removeClass('proposal-highlighted-textbox');
				}
			}			
		
	});	
});

	
function comparePIBProposal()
{
	var higlightItems = [];
	var higlightItemsIndex = 0;
	
	//Brand compare
	<#if project?? && project.brand?? && proposalInitiation.brand!=project.brand>
		higlightItems[higlightItemsIndex++] = 'brand';
	</#if>
	
	<#--<#if endMarketId?? && endMarketId!=proposalEndMarketId>
		higlightItems[higlightItemsIndex++] = 'updatedSingleMarketId';
	</#if>
	-->
	
	//Project start and end dates compare
	var project_startDate = <#if project?? && project.startDate?? >"${project.startDate?string('dd/MM/yyyy')}";<#else>"";</#if>	
    var project_endDate = <#if project?? && project.endDate?? >"${project.endDate?string('dd/MM/yyyy')}";<#else>"";</#if>
	var proposal_startDate = <#if proposalInitiation?? && proposalInitiation.startDate?? >"${proposalInitiation.startDate?string('dd/MM/yyyy')}";<#else>"";</#if>
	var proposal_endDate = <#if proposalInitiation?? && proposalInitiation.endDate?? >"${proposalInitiation.endDate?string('dd/MM/yyyy')}";<#else>"";</#if>
	if(project_startDate!=proposal_startDate)
	{
		higlightItems[higlightItemsIndex++] = 'startDate';
	}
	if(project_endDate!=proposal_endDate)
	{
		higlightItems[higlightItemsIndex++] = 'endDate';
	}
	
	//Methodology Type compare
	<#if project?? && project.methodologyType?? && project.methodologyType!=proposalInitiation.methodologyType>		
		higlightItems[higlightItemsIndex++] = 'methodologyType';
	</#if>
	
	//Methodology Group Type compare
	<#if project?? && project.methodologyGroup?? && project.methodologyGroup!=proposalInitiation.methodologyGroup>		
		higlightItems[higlightItemsIndex++] = 'methodologyGroup';
	</#if>
	
	//NPI Reference Number compare
	<#if projectInitiationByMarket?? && projectInitiationByMarket.npiReferenceNo?? && proposalInitiation.npiReferenceNo?? && projectInitiationByMarket.npiReferenceNo!=proposalInitiation.npiReferenceNo>		
		higlightItems[higlightItemsIndex++] = 'npiReferenceNo';
	</#if>
	
	//Stimuli Date Compare
	var project_stimulidate = <#if projectInitiationByMarket?? && projectInitiationByMarket.stimuliDate?? >"${projectInitiationByMarket.stimuliDate?string('dd/MM/yyyy')}";<#else>"";</#if>
	var proposal_stimulidate = <#if proposalInitiation?? && proposalInitiation.stimuliDate?? >"${proposalInitiation.stimuliDate?string('dd/MM/yyyy')}";<#else>"";</#if>

	if(project_stimulidate!=proposal_stimulidate)
	{
		higlightItems[higlightItemsIndex++] = 'stimuliDate';
	}
	
	<#if proposalReporting.topLinePresentation?? && pibReportingByMarket.topLinePresentation?? && pibReportingByMarket.topLinePresentation?string!=proposalReporting.topLinePresentation?string>
		higlightItems[higlightItemsIndex++] = 'report_requirement_list_id';
	<#elseif proposalReporting.presentation?? && pibReportingByMarket.presentation?? && pibReportingByMarket.presentation?string!=proposalReporting.presentation?string>
		higlightItems[higlightItemsIndex++] = 'report_requirement_list_id';
	<#elseif proposalReporting.fullreport?? && pibReportingByMarket.fullreport?? && pibReportingByMarket.fullreport?string!=proposalReporting.fullreport?string>
		higlightItems[higlightItemsIndex++] = 'report_requirement_list_id';
	</#if>
	
	<#if projectInitiationByMarket?? && projectInitiationByMarket.bizQuestionText?? && proposalInitiation.bizQuestionText?? && proposalInitiation.bizQuestionText!=projectInitiationByMarket.bizQuestionText>		
		higlightItems[higlightItemsIndex++] = 'bizQuestion';
	</#if>
	
	<#if projectInitiationByMarket?? && projectInitiationByMarket.researchObjectiveText?? && proposalInitiation.researchObjectiveText?? && proposalInitiation.researchObjectiveText!=projectInitiationByMarket.researchObjectiveText>		
		higlightItems[higlightItemsIndex++] = 'researchObjective';
	</#if>
	
	<#list proposalInitiationList as proposalIniList>
			<#if jiveContext.getSpringBean("pibManager").getPIBDetails(projectID, proposalIniList.endMarketID).size() gt 0 >
				<#assign projectInitiationByIteration = jiveContext.getSpringBean("pibManager").getPIBDetails(projectID, proposalIniList.endMarketID).get(0) />
			</#if>
		<#-- <#assign projectInitiationByIteration = jiveContext.getSpringBean("pibManager").getPIBDetails(projectID, proposalIniList.endMarketID).get(0) /> -->
		<#if proposalIniList.actionStandardText?? && projectInitiationByIteration?? && projectInitiationByIteration.actionStandardText?? && proposalIniList.actionStandardText!=projectInitiationByIteration.actionStandardText>
			higlightItems[higlightItemsIndex++] = 'actionStandard_${proposalIniList.endMarketID}';
		</#if>
		
		<#if proposalIniList.researchDesignText?? && projectInitiationByIteration?? && projectInitiationByIteration.researchDesignText?? && proposalIniList.researchDesignText?? && proposalIniList.researchDesignText!=projectInitiationByIteration.researchDesignText>
			higlightItems[higlightItemsIndex++] = 'researchDesign_${proposalIniList.endMarketID}';
		</#if>
		
		<#if proposalIniList.sampleProfileText?? && projectInitiationByIteration?? && projectInitiationByIteration.sampleProfileText?? &&proposalIniList.sampleProfileText?? && proposalIniList.sampleProfileText!=projectInitiationByIteration.sampleProfileText>
			higlightItems[higlightItemsIndex++] = 'sampleProfile_${proposalIniList.endMarketID}';
		</#if>
		
		<#if proposalIniList.stimulusMaterialText?? && projectInitiationByIteration?? && projectInitiationByIteration.stimulusMaterialText?? && proposalIniList.stimulusMaterialText?? && proposalIniList.stimulusMaterialText!=projectInitiationByIteration.stimulusMaterialText>
			higlightItems[higlightItemsIndex++] = 'stimulusMaterial_${proposalIniList.endMarketID}';
		</#if>		
	</#list>
	
	<#if projectInitiationByMarket?? && projectInitiationByMarket.othersText?? && proposalInitiation.othersText?? && proposalInitiation.othersText!=projectInitiationByMarket.othersText>		
		higlightItems[higlightItemsIndex++] = 'others';
	</#if>
	
	<#if pibReportingByMarket?? && pibReportingByMarket.otherReportingRequirementsText?? && proposalReporting.otherReportingRequirementsText?? && proposalReporting.otherReportingRequirementsText!=pibReportingByMarket.otherReportingRequirementsText>		
		higlightItems[higlightItemsIndex++] = 'otherReportingRequirements';
	</#if>
	
	for(var i=0; i<higlightItems.length; i++)
	{
		console.log("Item - " + higlightItems[i]);
		if($j("#"+higlightItems[i]).prev().length>0 && $j("#"+higlightItems[i]).prev().hasClass('mce-container') && !$j("#"+higlightItems[i]).prev().hasClass('proposal-highlighted-textbox'))
		{
			$j("#"+higlightItems[i]).prev().addClass('proposal-highlighted-textbox');
		}
		else if($j("#"+higlightItems[i]).length>0 && !$j("#"+higlightItems[i]).hasClass('proposal-highlighted-textbox'))
		{
			$j("#"+higlightItems[i]).addClass('proposal-highlighted-textbox');
		}		
		else if($j("input[name="+higlightItems[i]+"]").length>0 && !$j("input[name="+higlightItems[i]+"]").hasClass('proposal-highlighted-textbox'))
		{
			$j("input[name="+higlightItems[i]+"]").addClass('proposal-highlighted-textbox');
		}
	}
}

function compareContent(that)
{
	if(that)
	{			
		var name= that.id;			
		if(name!=null && name=='bizQuestion')
		{
			var pibBizQuestion = $j("#bizQuestionPIBText").text();				
			if($j("#hidden-textarea-content-div").length<1)
			{
				var domElement ="<div id='hidden-textarea-content-div' style='display:none;'></div>";
				$j("body").append(domElement);
			}		
			var dom = $j("#hidden-textarea-content-div");
			
			var bizQuestionHTML=that.getContent();
			dom.html(bizQuestionHTML);		
			var proposalBizQuestion = dom.text();				
			if($j.trim(pibBizQuestion)!=$j.trim(proposalBizQuestion))
			{					
				if($j("#"+name).prev().length>0 && !$j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{						
					$j("#"+name).prev().addClass('proposal-highlighted-textbox');
				}					
			}
			else
			{			
				if($j("#"+name).prev().length>0 && $j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().removeClass('proposal-highlighted-textbox');
				}	
			}			
		}
					
		if(name!=null && name=='researchObjective')
		{				
			var pibResearchObjective = $j("#researchObjectivePIBText").text();
			if($j("#hidden-textarea-content-div").length<1)
			{
				var domElement ="<div id='hidden-textarea-content-div' style='display:none;'></div>";
				$j("body").append(domElement);
			}		
			var dom = $j("#hidden-textarea-content-div");				
			var researchObjectiveHTML=that.getContent();
			dom.html(researchObjectiveHTML);		
			var proposalResearchObjective = dom.text();				
			if($j.trim(pibResearchObjective)!=$j.trim(proposalResearchObjective))
			{
				if($j("#"+name).prev().length>0 && !$j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().addClass('proposal-highlighted-textbox');
				}					
			}
			else
			{					
				if($j("#"+name).prev().length>0 && $j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().removeClass('proposal-highlighted-textbox');
				}	
			}				
		}
		<#list proposalInitiationList as proposalIniList>
		if(name!=null && name=='actionStandard_${proposalIniList.endMarketID}')
		{				
			var pibActionStandard = $j("#actionStandardPIBText_${proposalIniList.endMarketID}").text();
			if($j("#hidden-textarea-content-div").length<1)
			{
				var domElement ="<div id='hidden-textarea-content-div' style='display:none;'></div>";
				$j("body").append(domElement);
			}		
			var dom = $j("#hidden-textarea-content-div");
			
			var actionStandardHTML=that.getContent();
			dom.html(actionStandardHTML);		
			var proposalActionStandard = dom.text();
			if($j.trim(pibActionStandard)!=$j.trim(proposalActionStandard))
			{
				if($j("#"+name).prev().length>0 && !$j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().addClass('proposal-highlighted-textbox');
				}					
			}
			else
			{					
				if($j("#"+name).prev().length>0 && $j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().removeClass('proposal-highlighted-textbox');
				}	
			}				
		}			
		
		if(name!=null && name=='researchDesign_${proposalIniList.endMarketID}')
		{	
			var pibResearchDesign = $j("#researchDesignPIBText_${proposalIniList.endMarketID}").text();
			if($j("#hidden-textarea-content-div").length<1)
			{
				var domElement ="<div id='hidden-textarea-content-div' style='display:none;'></div>";
				$j("body").append(domElement);
			}		
			var dom = $j("#hidden-textarea-content-div");
			
			var researchDesignHTML=that.getContent();
			dom.html(researchDesignHTML);		
			var proposalResearchDesign = dom.text();				
			if($j.trim(pibResearchDesign)!=$j.trim(proposalResearchDesign))
			{
				if($j("#"+name).prev().length>0 && !$j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().addClass('proposal-highlighted-textbox');
				}					
			}
			else
			{					
				if($j("#"+name).prev().length>0 && $j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().removeClass('proposal-highlighted-textbox');
				}	
			}				
		}
		if(name!=null && name=='sampleProfile_${proposalIniList.endMarketID}')
		{
			var pibSampleProfile = $j("#sampleProfilePIBText_${proposalIniList.endMarketID}").text();
			if($j("#hidden-textarea-content-div").length<1)
			{
				var domElement ="<div id='hidden-textarea-content-div' style='display:none;'></div>";
				$j("body").append(domElement);
			}		
			var dom = $j("#hidden-textarea-content-div");
			
			var sampleProfileHTML=that.getContent();
			dom.html(sampleProfileHTML);		
			var proposalSampleProfile = dom.text();				
			if($j.trim(pibSampleProfile)!=$j.trim(proposalSampleProfile))
			{
				if($j("#"+name).prev().length>0 && !$j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().addClass('proposal-highlighted-textbox');
				}					
			}
			else
			{					
				if($j("#"+name).prev().length>0 && $j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().removeClass('proposal-highlighted-textbox');
				}	
			}				
		}
		if(name!=null && name=='stimulusMaterial_${proposalIniList.endMarketID}')
		{
			var pibStimulusMaterial = $j("#stimulusMaterialPIBText_${proposalIniList.endMarketID}").text();
			if($j("#hidden-textarea-content-div").length<1)
			{
				var domElement ="<div id='hidden-textarea-content-div' style='display:none;'></div>";
				$j("body").append(domElement);
			}		
			var dom = $j("#hidden-textarea-content-div");
			
			var stimulusMaterialHTML=that.getContent();
			dom.html(stimulusMaterialHTML);		
			var proposalStimulusMaterial = dom.text();			
			if($j.trim(pibStimulusMaterial)!=$j.trim(proposalStimulusMaterial))
			{
				if($j("#"+name).prev().length>0 && !$j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().addClass('proposal-highlighted-textbox');
				}					
			}
			else
			{					
				if($j("#"+name).prev().length>0 && $j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().removeClass('proposal-highlighted-textbox');
				}	
			}				
		}
		</#list>
		
		if(name!=null && name=='others')
		{
			var pibOthers = $j("#othersPIBText").text();
			if($j("#hidden-textarea-content-div").length<1)
			{
				var domElement ="<div id='hidden-textarea-content-div' style='display:none;'></div>";
				$j("body").append(domElement);
			}		
			var dom = $j("#hidden-textarea-content-div");
			
			var othersHTML=that.getContent();
			dom.html(othersHTML);		
			var proposalOthers = dom.text();				
			if($j.trim(pibOthers)!=$j.trim(proposalOthers))
			{
				if($j("#"+name).prev().length>0 && !$j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().addClass('proposal-highlighted-textbox');
				}					
			}
			else
			{					
				if($j("#"+name).prev().length>0 && $j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().removeClass('proposal-highlighted-textbox');
				}	
			}				
		}
		//Other Reporting Requirements
		if(name!=null && name=='otherReportingRequirements')
		{
			var pibOtherReportingRequirements = $j("#otherReportingRequirementsPIBText").text();				
							
			if($j("#hidden-textarea-content-div").length<1)
			{
				var domElement ="<div id='hidden-textarea-content-div' style='display:none;'></div>";
				$j("body").append(domElement);
			}		
			var dom = $j("#hidden-textarea-content-div");
			
			var otherReportingRequirementsHTML=that.getContent();
			dom.html(otherReportingRequirementsHTML);		
			var proposalOtherReportingRequirements = dom.text();				
			if($j.trim(pibOtherReportingRequirements)!=$j.trim(proposalOtherReportingRequirements))
			{
				if($j("#"+name).prev().length>0 && !$j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().addClass('proposal-highlighted-textbox');
				}					
			}
			else
			{					
				if($j("#"+name).prev().length>0 && $j("#"+name).prev().hasClass('proposal-highlighted-textbox'))
				{
					$j("#"+name).prev().removeClass('proposal-highlighted-textbox');
				}	
			}				
		}
		
	}
}

</script>

<script type="text/javascript">
<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.proposal.view.text" /></#assign>
	var projName = "${project.name?js_string}";
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROPOSAL.getId()}, "${i18CustomText}", projName, ${projectID?c}, ${user.ID?c});
</script>