<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>

<#-- DWR def -->
<head>
    <#--<script type="text/javascript" src="<@s.url value='/dwr/engine.js' />"></script>
    <script type="text/javascript" src="<@s.url value='/dwr/interface/ProjectReadTracker.js' />"></script>
    <script type="text/javascript" src="<@s.url value='/dwr/interface/InviteUserUtil.js' />"></script>
    <script type="text/javascript" src="<@s.url value='/dwr/interface/FieldMappingUtil.js' />"></script>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>-->
   
	
</head>
<@resource.template file="/soy/userpicker/userpicker.soy" />
 <script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>
    <script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
    <script src="${themePath}/js/synchro/commons.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
	<script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>
<script src="${themePath}/js/synchro/form-data-persist-handler.js?version=1" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/project-sticky-header.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.MultiFile.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ajaxfileupload.js'/>"></script>

<script type="text/javascript">
    $j(document).ready(function(){
        AUTO_SAVE.register({form:$j("#project-specs-form"), projectID:${projectID?c}});
        PROJECT_STAGE_NAVIGATOR.initialize({
        <#if projectID??>
            projectId:${projectID?c},
        </#if>
            activeStage:4
        });

        FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#project-specs-form"),form:$j("#email-notification-form"), projectID:${projectID?c}});
        PROJECT_STICKY_HEADER.initialize();
        $j("#fwStartDateLatest").click(function() {
            $j("#fwStartDateLatest_button").click();
        });

        $j("#fwEndDateLatest").click(function() {
            $j("#fwEndDateLatest_button").click();
        });

    });

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

    function openFieldWorkWindow()
    {
       <#-- FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#project-specs-form"),form:$j("#fieldwork-form-popup"), projectID:${projectID?c}});-->
        $j("#fieldWorkWindow").lightbox_me({centered:true,closeEsc:false,closeClick:false,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7},onClose:function(){$j(".calendar").remove()}});
		initiateRTE('latestFWComments', 1500);	
		initiateRTE('finalCostComments', 1500);
    }
    function closeFieldWorkWindow()
    {
        $j("#fieldWorkWindow").hide();
        dialog({
            title:"Confirmation",
            html:"Are you sure you want to close with out saving details?",
            nonCloseActionButtons:['YES'],
            buttons:{
                "YES":function() {
                    var closePITPopup = true;
                    $j("#fieldWorkWindow").trigger('close');
                    $j("#fieldWorkWindow").hide();
                    closeDialog();
                },
                "NO": function() {
                    var closePITPopup = false;
                    $j("#fieldWorkWindow").show();
                }
            },
            closeActionButtonsClickHander:function() {
                $j("#fieldWorkWindow").show();
                closeDialog();
            }

        });
        //$j("#fieldWorkWindow").trigger('close');
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
	
    function setMethodologyWaiverApprove()
    {
        $j("#methodologyWaiverAction").val('Approve');

    }
    function setMethodologyWaiverReject()
    {
        $j("#methodologyWaiverAction").val('Reject');
    }
    function setMethodologyWaiverSendforInfo()
    {
        $j("#methodologyWaiverAction").val('Send for Information');

    }
    function setMethodologyWaiverReqMoreInfo()
    {
        $j("#methodologyWaiverAction").val('Request more Information');
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
    function checkMethDeviation()
    {
        if($j("#deviationFromSM").val()==0)
        {
            $j("#initiateWaiverButton").hide();
        }
        else
        {
            $j("#initiateWaiverButton").show();
        }

    }
    function confirmDelete(attachmentId, fieldID, attachmentName) {
        location.href="/synchro/project-specs!removeAttachment.jspa?projectID=${projectID?c}&attachmentId="+attachmentId+"&attachmentFieldID="+fieldID+"&attachmentName="+attachmentName;
        /*
        $j.ajax({
            url: "<@s.url value='/synchro/project-specs!removeAttachment.jspa'/>",
            type: 'POST',
            data:  "attachmentId="+attachmentId,
            success: onRemoveSuccess,
            error: onRemoveFailure
        });
        */
    }
    function onRemoveSuccess(response, textStatus, jqXHR) {
        $j("#jive-file-list").hide();
    }
    function onRemoveFailure(jqXHR, textStatus, errorThrown) {

    }
</script>
<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/form-message.ftl" />


<#assign bussinessQuestionID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].BUSINESS_QUESTION.getId()/>
<#assign researchObjectiveID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].RESEARCH_OBJECTIVE.getId()/>
<#assign actionStandardID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].ACTION_STANDARD.getId()/>
<#assign researchDesignID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].RESEARCH_DESIGN.getId()/>
<#assign sampleProfileID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].SAMPLE_PROFILE.getId()/>
<#assign stimulusMaterialID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].STIMULUS_MATERIAL.getId()/>
<#assign stimulusMaterialShippedID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].STIMULUS_MATERIAL_SHIPPED.getId()/>
<#assign otherReportingRequirementID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].OTHER_REPORTING_REQUIREMENT.getId()/>
<#assign othersID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].OTHERS.getId()/>
<#assign screenerID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].SCREENER.getId()/>
<#assign cccAgreementID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].CCC_AGREEMENT.getId()/>
<#assign questionnaireID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].QUESTIONNAIRE.getId()/>
<#assign discussionGuideID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].DISCUSSION_GUIDE.getId()/>

<!-- Setting locale to EN US for numeric formats -->
<#setting locale="en_US">

<!-- Page container -->
<div class="container">

<div class="project_names">


<div class="project_name_div">
<h2>Project Specs <label style="font-size: 12px;">(<span class="red">*</span>Indicates the mandatory details needed to complete the stage)</label></h2>
<h2>${project.name?html} (${generateProjectCode('${projectID?c}')}) </h2>
<div class="print-btn">
    <input type="button" value="PRINT" class="j-btn-callout">
</div>

<#if showMandatoryFieldsError?? && showMandatoryFieldsError>
<div id="jive-error-box" class="jive-error-box  warning" >
    <div>
    <#--<span class="jive-icon-med jive-icon-redalert"></span>-->
        <span><@s.text name="project.mandatory.error"/></span>
    </div>
</div>

</#if>

<#assign isExternalAgencyUser = statics['com.grail.synchro.util.SynchroPermHelper'].isExternalAgencyUser(projectID,endMarketDetails.get(0).getEndMarketID()) />
<#assign isMethAppUser = statics['com.grail.synchro.util.SynchroPermHelper'].isMethodologyApproverUser() />
<#assign isProjectOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectOwner(projectID) />
<#assign isSPIContactUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSPIContactUser(projectID,endMarketDetails.get(0).getEndMarketID()) />
<#assign isProjectCreator = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectCreator(projectID) />
<#assign isProcurementUser = statics['com.grail.synchro.util.SynchroPermHelper'].isProcurementUser(projectID,endMarketDetails.get(0).getEndMarketID()) />
<#assign isCommunicationAgencyUser = statics['com.grail.synchro.util.SynchroPermHelper'].isCommunicationAgencyUser(projectID,endMarketDetails.get(0).getEndMarketID()) />
<#assign isLegalUser = statics['com.grail.synchro.util.SynchroPermHelper'].isLegalUser(projectID,endMarketDetails.get(0).getEndMarketID()) />
<#assign isProcUser = statics['com.grail.synchro.util.SynchroPermHelper'].isProcurementUser(projectID,endMarketDetails.get(0).getEndMarketID()) />
<#assign projectContactHasReadonlyAccess = statics['com.grail.synchro.util.SynchroPermHelper'].hasReadOnlyProjectAccess(projectID) />
<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
<#assign isCommunicationAgencyAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroCommunicationAgencyAdmin() />

<#assign defaultCurrency = statics['com.grail.synchro.util.SynchroUtils'].getDefaultCurrencyByProject(projectID) />

<#if project.multiMarket >
    <#assign endMarketId = endMarketIds.get(0) />
<#else>
    <#assign endMarketId = endMarketDetails.get(0).getEndMarketID() />
</#if>
<#assign projectInitiation = jiveContext.getSpringBean("pibManager").getPIBDetails(projectID).get(0) />
<#assign canEditProject = statics['com.grail.synchro.util.SynchroPermHelper'].canEditProjectByStatus(projectID) />
<#if !isAdminUser && projectSpecsInitiation.status ?? && projectSpecsInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROJECT_SPECS_COMPLETED.ordinal() >
    <#include "/template/global/project-specs-readonly.ftl" />
    
<#--
<#elseif projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1 >
    <#include "/template/global/project-specs-readonly.ftl" />
-->
<#elseif isProcurementUser || isCommunicationAgencyUser || isCommunicationAgencyAdminUser>
    <#include "/template/global/project-specs-readonly.ftl" />
<#elseif !canEditProject>
    <#include "/template/global/project-specs-readonly.ftl" />
<#elseif projectContactHasReadonlyAccess>
    <#include "/template/global/project-specs-readonly.ftl" />	
<#else>
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
            <#if isAdminUser>
            	<@renderBrandField name='brand' value=projectSpecsInitiation.brand?default('-1') readonly=false/>
            <#else>
            	<@renderBrandField name='brand' value=projectSpecsInitiation.brand?default('-1') readonly=true/>
            </#if>
            <#assign error_msg><@s.text name='project.error.brand' /></#assign>
            <@macroCustomFieldErrors msg=error_msg />
        </div>



        <div class="pib-select_div">
            <label>Country</label>
           
            <#if isAdminUser>
            	<@renderEndMarketSingleSelectFld name='updatedSingleMarketId' value=projSpecsEndMarketId?default('-1')  disabled=false/>
            <#else>
            	<@renderEndMarketSingleSelectFld name='updatedSingleMarketId' value=projSpecsEndMarketId?default('-1')  disabled=true/>
            </#if>	
           
            <#assign error_msg><@s.text name='project.error.endmarket' /></#assign>
            <@macroCustomFieldErrors msg=error_msg />
        </div>

        <div class="project_owner_names">
            <label>Project Owner</label>
            <#if project.projectOwner &gt; 0>
                <#assign ownerUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner) />
				 <input type="hidden" name="projectOwnerOri" value="${project.projectOwner?c}">
            <#else>
                <#assign ownerUserName="" />
            </#if>
        <#--<#if isExternalAgencyUser>
            <input type="text" name="projectOwnerRead" id="projectOwnerRead"  value="${ownerUserName}" disabled />
        <#else>
            <input type="text" tabindex="1" name="projectOwner" id="projectOwner" class="j-user-autocomplete j-ui-elem" srole="20" />
        </#if>-->
            
            <#if isAdminUser>
            	<input type="text" tabindex="1" name="projectOwner" id="projectOwner" value="${ownerUserName}" class="j-user-autocomplete j-ui-elem resize" srole="20" />
            <#else>
               <input type="text" name="projectOwnerRead" id="projectOwnerRead"  value="${ownerUserName}" disabled />
            </#if>

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
                <#assign spiContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(spiContact) />
				<input type="hidden" name="spiContactOri" value="${spiContact?c}">
            <#else>
                <#assign spiContactName="" />
            </#if>

        <#--  <#if isExternalAgencyUser>
           <input type="text" name="briefCreator" id="briefCreator"  value="${spiContactName}" disabled />
       <#else>
           <input type="text" tabindex="1" name="spiContact" id="spiContact" class="j-user-autocomplete j-ui-elem" value="${spiContactName}" srole="1" autocomplete="off" />
       </#if> -->
             <#if isAdminUser>
            	<input type="text" tabindex="1" name="spiContact" id="spiContact" class="j-user-autocomplete j-ui-elem resize" value="${spiContactName}" srole="1" autocomplete="off" />
            <#else>
                <input type="text" name="briefCreator" id="briefCreator"  value="${spiContactName}" disabled />
            </#if>
           
        </div>


        <div class="form-date_div">
            <label>Project Start (Commissioning)</label>
	        
	        <#if isAdminUser>
		       <#-- <@jiveform.datetimepicker id="startDate" name="startDate" value="" readonly=true disablePrevDates=false/>-->
				<@synchrodatetimepicker id="startDate" name="startDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
		     	<#assign error_msg><@s.text name='project.error.startdate' /></#assign>
		     	<@macroCustomFieldErrors msg=error_msg />
		    <#else> 
                <input type="text" name="startDate" id="startDate"  value="<#if projectSpecsInitiation.startDate?? >${projectSpecsInitiation.startDate?string('dd/MM/yyyy')}</#if>" disabled />
            </#if>
        </div>

        <div class="form-date_div">
            <label>Project End <br/>(Results)</label>
        	<#if isAdminUser>
	        	<#--<@jiveform.datetimepicker id="endDate" name="endDate" value="" readonly=true disablePrevDates=false/>-->
				<@synchrodatetimepicker id="endDate" name="endDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
	     		<#assign error_msg><@s.text name='project.error.enddate' /></#assign>
	     		<@macroCustomFieldErrors msg=error_msg /> 
	     	<#else>
            	<input type="text" name="endDate" id="endDate"  value="<#if projectSpecsInitiation.endDate?? >${projectSpecsInitiation.endDate?string('dd/MM/yyyy')}</#if>" disabled />
            </#if>
        </div>
    </div>

    <div class="pib_right">
        <h3 class="pib_right_heading">Other Information</h3>



        <div class="region-inner">

            <label>Category Type</label>

            
             <#if isAdminUser>
    			<#if projectSpecsInitiation.categoryType?? && projectSpecsInitiation.categoryType?size gt 0 >
    				<@renderAllSelectedCategoryTypeFieldAdmin name='categoryType' value=projectSpecsInitiation.categoryType?default(-1) multiselect=true readonly=false />
    			<#else>
    				<@renderAllSelectedCategoryTypeFieldAdmin name='categoryType' value=project.categoryType?default(-1) multiselect=true readonly=false />
    			</#if>	
    		<#else>
    			<#if projectSpecsInitiation.categoryType?? && projectSpecsInitiation.categoryType?size gt 0 >
    				<@renderAllSelectedCategoryTypeField name='categoryType' value=projectSpecsInitiation.categoryType?default(-1) readonly=true />
    			<#else>
    				<@renderAllSelectedCategoryTypeField name='categoryType' value=project.categoryType?default(-1) readonly=true />
    			</#if>	
    	
    		</#if>
            <#assign error_msg><@s.text name='project.error.category' /></#assign>
            <@macroCustomFieldErrors msg=error_msg />
        </div>

        <div class="form-select_div">
            <label><@s.text name="project.initiate.project.methodology"/></label>
            <#if isAdminUser>
            	<@renderMethodologyField name='methodologyType' value=projectSpecsInitiation.methodologyType?default('-1') readonly=true  />
            <#else>
            	<@renderMethodologyField name='methodologyType' value=projectSpecsInitiation.methodologyType?default('-1') readonly=true  />
            </#if>
            <#assign error_msg><@s.text name='project.error.methodology' /></#assign>
            <@macroCustomFieldErrors msg=error_msg />
        </div>
        <div class="form-select_div">
            <label><@s.text name="project.initiate.project.methodologygroup"/></label>
            <#if isAdminUser>
            	<@renderMethodologyGroupField name='methodologyGroup' value=projectSpecsInitiation.methodologyGroup?default('-1') readonly=false  />
            <#else>
            	<@renderMethodologyGroupField name='methodologyGroup' value=projectSpecsInitiation.methodologyGroup?default('-1') readonly=true  />
            </#if>
            <#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
            <@macroCustomFieldErrors msg=error_msg />
        </div>
        <div class="region-inner proposed-region">
            <label><@s.text name="project.initiate.project.methodologyproposed"/></label>
            <#assign defaultPMethodologyID = JiveGlobals.getJiveIntProperty("grail.synchro.default.proposedmethodology", -1) />
            <#--<@displayProposedMethodologyMultiSelect name='proposedMethodology' value=projectSpecsInitiation.proposedMethodology?default([defaultPMethodologyID]) />-->
            <#if isAdminUser>
    			<@displayProposedMethodologyMultiSelectAdmin name='proposedMethodology' value=projectSpecsInitiation.proposedMethodology?default('-1') multiselect=true readonly=false />
    		<#else>
    			<@displayProposedMethodologyMultiSelect name='proposedMethodology' value=projectSpecsInitiation.proposedMethodology?default([defaultPMethodologyID]) />
    		</#if>
        </div>
        <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
        <#if !(isExternalAgencyUser || synchroPermHelper.isExternalAgencyUser(user))>
            <div class="form-text_div pib_initial_cost">
                <label>Estimated Cost</label>
                <#if isAdminUser>
	                <input type="text" name="estimatedCost" value="${endMarketDetails.get(0).initialCost}" size="30" class="form-text-div numericfield numericformat longField" >
	                <@renderCurrenciesField name='estimatedCostType' value=endMarketDetails.get(0).initialCostCurrency?default(defaultCurrency) disabled=false/>
	            <#else>
	            	<input type="text" name="name" value="${endMarketDetails.get(0).initialCost}" size="30" class="form-text-div numericfield numericformat longField" disabled="true">
	                <@renderCurrenciesField name='estimatedCostType' value=endMarketDetails.get(0).initialCostCurrency?default(defaultCurrency) disabled=true/>
	            </#if>
            </div>

            <div class="form-text_div pib_initial_cost">
                <label>Latest Estimate</label>
                <#if isAdminUser>
	                <input type="text" name="latestEstimate" <#if projectInitiation.latestEstimate?? > value="${projectInitiation.latestEstimate}" <#else> value="" </#if> size="30" class="form-text-div numericfield numericformat longField" >
	                <@renderCurrenciesField name='latestEstimateType' value=projectInitiation.latestEstimateType?default(defaultCurrency) disabled=false/>
	             <#else>
	             	<input type="text" name="latestEstimate-display" disabled <#if projectInitiation.latestEstimate?? > value="${projectInitiation.latestEstimate}" <#else> value="" </#if> size="30" class="form-text-div numericfield numericformat longField" >
                	<@renderCurrenciesField name='latestEstimateType' value=projectInitiation.latestEstimateType?default(defaultCurrency) disabled=true/>
	             </#if>
            </div>
        </#if>
        <div class="form-text_div pib_initial_cost">
            <label>Final Cost</label>
            <input type="text" name="finalCostTotal" disabled <#if projectSpecsEMDetails.finalCost?? > value="${projectSpecsEMDetails.finalCost}" <#else> value="" </#if> size="30" class="form-text-div" title="If the project has a fieldwork tendering process then the final cost does not include the fieldwork cost">
            <@renderCurrenciesField name='finalCostTypeTotal' value=projectSpecsEMDetails.finalCostType?default(defaultCurrency) disabled=true/>
        </div>

        <div class="form-text_div npi-number">
            <label>NPI Number <br/>(if appropriate)</label>
            <#if isAdminUser>
            	<input type="text" name="npiReferenceNo" value="${projectSpecsInitiation.npiReferenceNo?default('')?html}" size="30" class="form-text-div numericfield nonformatfield"  >
            <#else>
            	<input type="text" name="npiReferenceNo" value="${projectSpecsInitiation.npiReferenceNo?default('')?html}" size="30" class="form-text-div numericfield nonformatfield" disabled >
            </#if>
            <@macroCustomFieldErrors msg="" class='numeric-error'/>
        </div>
        <div class="form-select_div select-div">
            <label>Request for Methodology Waiver</label>
            <select name="deviationFromSM" id="deviationFromSM" class="form-select" onchange="checkMethDeviation()">
                <option value="0" <#if projectSpecsInitiation.deviationFromSM?? && projectSpecsInitiation.deviationFromSM==0 > selected </#if>>No</option>
                <option value="1" <#if projectSpecsInitiation.deviationFromSM?? && projectSpecsInitiation.deviationFromSM==1 > selected </#if>>Yes</option>
            </select>

            <script type="text/javascript">
                var initiateWaiverWindow = null;
                $j(document).ready(function(){
                    initiateWaiverWindow = new LIGHT_BOX($j("#initiateWaiver"),{title:'Request for Methodology Waiver',confirmOnClose:true})
                    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#project-specs-form"),form:$j("#waiver-form"), projectID:${projectID?c}})
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
            <#if !isExternalAgencyUser >
                <input type="text" name="poNumber" value="${projectSpecsInitiation.poNumber?default('')?html}" size="30" class="form-text-div numericfield nonformatfield" >
            <#else>
                <input type="text" name="poNumber" disabled value="${projectSpecsInitiation.poNumber?default('')?html}" size="30" class="form-text-div numericfield nonformatfield" >
            </#if>
            <@macroCustomFieldErrors msg='' class='numeric-error' />
        </div>
        <div class="form-text_div po-number">
            <label>PO Number</label>
            <#if !isExternalAgencyUser >
                <input type="text" id="poNumber1" name="poNumber1" value="${projectSpecsInitiation.poNumber1?default('')?html}" size="30" class="form-text-div nonformatfield" >
            <#else>
                <input type="text" id="poNumber1" name="poNumber1" disabled value="${projectSpecsInitiation.poNumber1?default('')?html}" size="30" class="form-text-div nonformatfield" >
            </#if>
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
            <@macroCustomFieldErrors msg='' class='numeric-error' />
        </div>
    </div>
</div>

<div class="region-inner">
<label class='rte-editor-label'>Project Description</label>
    <div class="form-text_div">
		<#if isAdminUser>
			<textarea id="description" name="description" rows="15" cols="30">${projectSpecsInitiation.description?default('')?html}</textarea>
			<@macroCustomFieldErrors msg="Please enter description" class='textarea-error-message'/>
		<#else>	
			<textarea id="description" name="description" disabled rows="15" cols="30" >${projectSpecsInitiation.description?default('')?html}</textarea>
		</#if>           
    </div>   
</div>

    <#assign synchroUtils = jiveContext.getSpringBean("synchroUtils") />


<!-- ATTACHMENT WINDOW STARTS -->
<script type="text/javascript">
    var attachmentWindow = null;
    $j(document).ready(function(){
        attachmentWindow = new SYNCHRO_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/synchro/project-specs!addAttachment.jspa'/>",
            projectID:${projectID?c},
            endMarketID:${projSpecsEndMarketId?c},
            parentForm:$j("#project-specs-form"),
            items:[
            <#--{id:${bussinessQuestionID?c},name:'Business Question'},
           {id:${researchObjectiveID?c},name:'Research Objective(s)'},
           {id:${actionStandardID?c},name:'Action Standard(s)'},
           {id:${researchDesignID?c},name:'Methodology Approach and Research design'},
           {id:${sampleProfileID?c},name:'Sample Profile (Research)'},
           {id:${stimulusMaterialID?c},name:'Stimulus Material'},
           {id:${stimulusMaterialShippedID?c},name:'Stimulus Material to be shipped to'},
           {id:${otherReportingRequirementID?c},name:'Other Reporting Requirements'},
           {id:${othersID?c},name:'Other Comments'},-->
                {id:${screenerID?c},name:'Screener'},
                {id:${cccAgreementID?c},name:'Consumer contract and Confidentiality agreement'},
                {id:${questionnaireID?c},name:'Questionnaire/Discussion guide'},
                {id:${discussionGuideID?c},name:'Actual Stimulus Material'}
            ]

        });

        <#if !isAdminUser>
	        <#if projectSpecsInitiation.proposedMethodology??>
	            $j("#proposedMethodology").val("${projectSpecsInitiation.proposedMethodology}");
	        </#if>
	    </#if>

       $j("#fileAttachBtn").bind('click',function(){
            attachmentWindow.show();
        });

        <#if !isAdminUser>
	        <#if projectSpecsInitiation.proposedMethodology??>
	            $j("#proposedMethodology").val("${projectSpecsInitiation.proposedMethodology}");
	        </#if>
	    </#if>

    });

    function showAttachmentPopup(fieldId) {
        attachmentWindow.show(fieldId);
    }
</script>
<!-- ATTACHMENT WINDOW ENDS -->



<#-- BEGIN SYNCHRO-- Check whether existing user is External Agency or not -->
<div class="region-inner">
<label class='rte-editor-label'>Business Question</label>
    <div class="form-text_div">        
        <#if isAdminUser>
        	<textarea id="bizQuestion" name="bizQuestion" rows="10" cols="20" class="form-text-div">${projectSpecsInitiation.bizQuestion?default('')?html}</textarea>
	        <@macroCustomFieldErrors msg="Please enter Business Question" class='textarea-error-message'/>
        <#else>
	        <textarea id="bizQuestion" name="bizQuestion" rows="10" cols="20" class="form-text-div" disabled>${projectSpecsInitiation.bizQuestion?default('')?html}</textarea>
	        <@macroCustomFieldErrors msg="Please enter Business Question" class='textarea-error-message'/>
	    </#if>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#-- <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${bussinessQuestionID?c})" ></span>-->
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
        <#if isAdminUser>
	        <textarea id="researchObjective" name="researchObjective" rows="10" cols="20" class="form-text-div">${projectSpecsInitiation.researchObjective?default('')?html}</textarea>
	        <@macroCustomFieldErrors msg="Please enter Research Objectives(s)" class='textarea-error-message'/>
	    <#else>
	    	<textarea id="researchObjective" name="researchObjective" rows="10" cols="20" disabled class="form-text-div">${projectSpecsInitiation.researchObjective?default('')?html}</textarea>
			<@macroCustomFieldErrors msg="Please enter Research Objectives(s)" class='textarea-error-message'/>
	    </#if> 
	    
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#-- <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${researchObjectiveID?c})" ></span> -->
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


<div class="region-inner">
	<label class='rte-editor-label'>Action Standard(s)</label>
    <div class="form-text_div">       
        <#if isAdminUser>
	        <textarea id="actionStandard" name="actionStandard" rows="10" cols="20"  class="form-text-div">${projectSpecsInitiation.actionStandard?default('')?html}</textarea>
	        <@macroCustomFieldErrors msg="Please enter Action Standard(s)" class='textarea-error-message'/>
	    <#else>
	    	<textarea id="actionStandard" name="actionStandard" rows="10" cols="20" disabled class="form-text-div">	${projectSpecsInitiation.actionStandard?default('')?html}</textarea>
			<@macroCustomFieldErrors msg="Please enter Action Standard(s)" class='textarea-error-message'/>
	    </#if>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#-- <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${actionStandardID?c})" ></span> -->
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

<div class="region-inner">
	<label class='rte-editor-label'>Methodology Approach and Research Design</label>
    <div class="form-text_div">       
        <#if isAdminUser>
	        <textarea id="researchDesign" name="researchDesign" rows="10" cols="20" class="form-text-div form-text-div-large">${projectSpecsInitiation.researchDesign?default('')?html}</textarea>
	        <@macroCustomFieldErrors msg="Please enter Methodology Approach and Research Design" class='textarea-error-message'/>
	    <#else>
	    	<textarea id="researchDesign" name="researchDesign" rows="10" cols="20" disabled class="form-text-div form-text-div-large">${projectSpecsInitiation.researchDesign?default('')?html}</textarea>
	        <@macroCustomFieldErrors msg="Please enter Methodology Approach and Research Design" class='textarea-error-message'/>
	    </#if>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#-- <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${researchDesignID?c})" ></span> -->
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

<div class="region-inner">
	<label class='rte-editor-label'>Sample Profile (Research)</label>
    <div class="form-text_div">       
        <#if isAdminUser>
	        <textarea id="sampleProfile" name="sampleProfile" rows="10" cols="20" class="form-text-div">${projectSpecsInitiation.sampleProfile?default('')?html}</textarea>
	        <@macroCustomFieldErrors msg="Please enter Sample Profile (Research)" class='textarea-error-message'/>
	   <#else>
	   		<textarea id="sampleProfile" name="sampleProfile" rows="10" cols="20" disabled class="form-text-div">${projectSpecsInitiation.sampleProfile?default('')?html}</textarea>
	        <@macroCustomFieldErrors msg="Please enter Sample Profile (Research)" class='textarea-error-message'/>
	   </#if>
	   
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#-- <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${sampleProfileID?c})" ></span> -->
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

<div class="region-inner">
	<label class='rte-editor-label'>Stimulus Material</label>
    <div class="form-text_div">       
        <#if isAdminUser>
	        <textarea id="stimulusMaterial" name="stimulusMaterial" rows="10" cols="20"  class="form-text-div">${projectSpecsInitiation.stimulusMaterial?default('')?html}</textarea>
	        <@macroCustomFieldErrors msg="Please enter Stimulus Material" class='textarea-error-message'/>
	    <#else>
	    	<textarea id="stimulusMaterial" name="stimulusMaterial" rows="10" cols="20" disabled class="form-text-div">${projectSpecsInitiation.stimulusMaterial?default('')?html}</textarea>
	        <@macroCustomFieldErrors msg="Please enter Stimulus Material" class='textarea-error-message'/>
	    </#if>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#-- <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${stimulusMaterialID?c})" ></span> -->
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
<div class="region-inner">
	<label class='rte-editor-label'>Stimulus Material to be shipped to</label>
    <div class="form-text_div">       
        <#if isAdminUser>
		    <textarea id="stimulusMaterialShipped" name="stimulusMaterialShipped" rows="10" cols="20" class="form-text-div">${projectSpecsInitiation.stimulusMaterialShipped?default('')?html}</textarea>
		    <@macroCustomFieldErrors msg="Please enter Stimulus Material to be shipped to" class='textarea-error-message'/>
		<#else>
			<textarea id="stimulusMaterialShipped" name="stimulusMaterialShipped" disabled rows="10" cols="20" class="form-text-div">${projectSpecsInitiation.stimulusMaterialShipped?default('')?html}</textarea>
		    <@macroCustomFieldErrors msg="Please enter Stimulus Material to be shipped to" class='textarea-error-message'/>
		</#if>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#-- <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${stimulusMaterialShippedID?c})"></span> -->
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
        <#if isAdminUser>
	        <textarea id="others" name="others" rows="10" cols="20" class="form-text-div">${projectSpecsInitiation.others?default('')?html}</textarea>
	        <@macroCustomFieldErrors msg="Please enter Other Comments" class='textarea-error-message'/>
	    <#else>
	    	<textarea id="others" name="others" rows="10" cols="20" disabled class="form-text-div">${projectSpecsInitiation.others?default('')?html}</textarea>
	        <@macroCustomFieldErrors msg="Please enter Other Comments" class='textarea-error-message'/>
	    </#if>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#-- <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${othersID?c})" ></span> -->
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
      <#if isAdminUser>
      	<#--<@jiveform.datetimepicker id="stimuliDate" name="stimuliDate" value="" readonly=true disablePrevDates=false/>-->
		<@synchrodatetimepicker id="stimuliDate" name="stimuliDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
 		<@macroCustomFieldErrors msg='' />
 	  <#else> 
        <input type="text" name="stimuliDate" id="stimuliDate"  value="<#if projectSpecsInitiation.stimuliDate?? >${projectSpecsInitiation.stimuliDate?string('dd/MM/yyyy')}</#if>" disabled />
      </#if>
    </div>
</div>

<div class="pib-report-requirement">
    <label>Reporting Requirement</label>
    <table class="report_requirement_list">
        <tbody>
        <tr>
            <#if isAdminUser>
            	<td><@renderReportingCheckBox label='' name='topLinePresentation' isChecked=projectSpecsReporting.topLinePresentation?default(false) disable=false /></td>
            <#else>
            	<td><@renderReportingCheckBox label='' name='topLinePresentation' isChecked=projectSpecsReporting.topLinePresentation?default(false) disable=true /></td>
            </#if>
            <td class="view-row-first">Top Line Presentation</td>
        </tr>
        <tr class="color-row">
            <#if isAdminUser>
            	<td><@renderReportingCheckBox label='' name='presentation' isChecked=projectSpecsReporting.presentation?default(false) disable=false /></td>
            <#else>
            	<td><@renderReportingCheckBox label='' name='presentation' isChecked=projectSpecsReporting.presentation?default(false) disable=true /></td>
            </#if>
            <td class="view-row-first">Presentation</td>
        </tr>
        <tr>
            <#if isAdminUser>
            	<td><@renderReportingCheckBox label='' name='fullreport' isChecked=projectSpecsReporting.fullreport?default(false) disable=false /></td>
            <#else>
            	<td><@renderReportingCheckBox label='' name='fullreport' isChecked=projectSpecsReporting.fullreport?default(false) disable=true /></td>
            </#if>
            <td class="view-row-first">Full Report</td>
        </tr>

        </tbody>
    </table>

    <@macroCustomFieldErrors msg="Please select reporting requirement"/>

</div>
<div class="region-inner">
	<label class='rte-editor-label'>Other Reporting Requirements</label>
    <div class="form-text_div">        
        <#if isAdminUser>
	        <textarea id="otherReportingRequirements" name="otherReportingRequirements" rows="10"  cols="20" class="form-text-div">${projectSpecsReporting.otherReportingRequirements?default('')?html}</textarea>
	        <@macroCustomFieldErrors msg="Please enter Other Reporting Requirements" class='textarea-error-message'/>
	    <#else>
	    	<textarea id="otherReportingRequirements" name="otherReportingRequirements" rows="10" disabled cols="20" class="form-text-div">${projectSpecsReporting.otherReportingRequirements?default('')?html}</textarea>	        	   
	    </#if>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
    <#-- <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${otherReportingRequirementID?c})" ></span> -->
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



<div class="region-inner">
	<label class='rte-editor-label'>Screener</label>
    <div class="form-text_div small-textarea">        
        <textarea id="screener" name="screener" rows="10" cols="20" class="form-text-div form-text-div-small">${projectSpecsInitiation.screener?default('Enter text and/or attach documents')?html}</textarea>
        <@macroCustomFieldErrors msg="Please enter Screener" class='textarea-error-message'/>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
        <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${screenerID?c})" ></span>
        <#if attachmentMap?? && attachmentMap.get(screenerID)?? >
            <div id="jive-file-list" class="jive-attachments">
                <#list attachmentMap.get(screenerID) as attachment>
                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                        <span class="jive-icon-med jive-icon-attachment"></span>
                        <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                            <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${screenerID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
                        </#if>
                        <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                        ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})  </a>
                    </div>
                </#list>
            </div>
        </#if>
    </div>
    <!-- ATTACHMENT DISPLAY ENDS -->
</div>

<div class="region-inner">
	<label class='rte-editor-label'>Consumer Contract and Confidentiality Agreement</label>
    <div class="form-text_div small-textarea">        
        <textarea id="consumerCCAgreement" name="consumerCCAgreement" rows="10" cols="20" class="form-text-div form-text-div-small">${projectSpecsInitiation.consumerCCAgreement?default('Enter text and/or attach documents')?html}</textarea>
        <@macroCustomFieldErrors msg="Please enter Consumer Contract and Confidentiality Agreement" class='textarea-error-message'/>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
        <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${cccAgreementID?c})" ></span>
        <#if attachmentMap?? && attachmentMap.get(cccAgreementID)?? >
            <div id="jive-file-list" class="jive-attachments">
                <#list attachmentMap.get(cccAgreementID) as attachment>
                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                        <span class="jive-icon-med jive-icon-attachment"></span>
                        <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                            <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${cccAgreementID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
	 <label class='rte-editor-label'>Questionnaire/Discussion guide</label>
    <div class="form-text_div small-textarea">       
        <textarea id="questionnaire" name="questionnaire" rows="10" cols="20" class="form-text-div form-text-div-small">${projectSpecsInitiation.questionnaire?default('Enter text and/or attach documents')?html}</textarea>
        <@macroCustomFieldErrors msg="Please enter Questionnaire/Discussion guide" class='textarea-error-message'/>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
        <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${questionnaireID?c})" ></span>
        <#if attachmentMap?? && attachmentMap.get(questionnaireID)?? >
            <div id="jive-file-list" class="jive-attachments">
                <#list attachmentMap.get(questionnaireID) as attachment>
                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                        <span class="jive-icon-med jive-icon-attachment"></span>
                        <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                            <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${questionnaireID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
	<label class='rte-editor-label'>Actual Stimulus Material</label>
    <div class="form-text_div small-textarea">        
        <textarea id="discussionguide" name="discussionguide" rows="10" cols="20" class="form-text-div form-text-div-small">${projectSpecsInitiation.discussionguide?default('Enter text and/or attach documents')?html}</textarea>
        <@macroCustomFieldErrors msg="Please enter Actual Stimulus Material" class='textarea-error-message'/>
    </div>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
        <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${discussionGuideID?c})" ></span>
        <#if attachmentMap?? && attachmentMap.get(discussionGuideID)?? >
            <div id="jive-file-list" class="jive-attachments">
                <#list attachmentMap.get(discussionGuideID) as attachment>
                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                        <span class="jive-icon-med jive-icon-attachment"></span>
                        <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                            <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${discussionGuideID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
<div class="end_market_details" style="display:block;">
<#-- <#list endMarketDetails as endMarketDetail> -->
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
        <script type="text/javascript">
            function totalCostChange() {
                var val = Number($j("input[name=totalCost-display]").val().replace(/\,/g,''));
                if(val) {
                    $j("input[name=totalCost]").val(val);
                } else {
                    $j("input[name=totalCost]").val("");
                }
            }
        </script>
        <#if isAdminUser>
	        <input type="text" name="totalCost-display"  onchange="totalCostChange()" <#if projectSpecsEMDetails.totalCost?? > value="${projectSpecsEMDetails.totalCost?default('')}" <#else> value="" </#if> class="form-text-div numericfield numericformat longField" >
	        <@renderCurrenciesField name='totalCostType' value=projectSpecsEMDetails.totalCostType?default(defaultCurrency) disabled=false />
	    <#else>
	    	<input type="text" name="totalCost-display" disabled onchange="totalCostChange()" <#if projectSpecsEMDetails.totalCost?? > value="${projectSpecsEMDetails.totalCost?default('')}" <#else> value="" </#if> class="form-text-div numericfield numericformat longField" >
	        <@renderCurrenciesField name='totalCostType' value=projectSpecsEMDetails.totalCostType?default(defaultCurrency) disabled=true />
	    </#if>
        <@macroCurrencySelectError msg="Please select currency" />
        <@macroCustomFieldErrors msg='Please enter Total Cost' />
        <@macroCustomFieldErrors msg="" class='numeric-error'/>
        <input type="hidden" name="totalCost" <#if projectSpecsEMDetails.totalCost?? > value="${projectSpecsEMDetails.totalCost?c}" <#else> value="" </#if> >
    </div>
    <#assign internation_management_cost_display = 'none' />
    <#if projectSpecsInitiation.methodologyType!=4 >
        <#assign internation_management_cost_display = 'block' />
    </#if>

    <div id="internation_management_cost_div" style='display:${internation_management_cost_display};'>

        <div class="form-select_div">
            <label>International Management Cost - Research Hub Cost</label>
            <script type="text/javascript">
                function inititalMgmtCostChange() {
                    var val = Number($j("input[name=intMgmtCost-display]").val().replace(/\,/g,''));
                    if(val) {
                        $j("input[name=intMgmtCost]").val(val);
                    } else {
                        $j("input[name=intMgmtCost]").val("");
                    }
                }
            </script>
            <#if isAdminUser>
	            <input type="text" name="intMgmtCost-display" onchange="inititalMgmtCostChange()" <#if projectSpecsEMDetails.intMgmtCost??  > value="${projectSpecsEMDetails.intMgmtCost?default('')}" <#else> value="" </#if> class="form-text-div numericfield numericformat longField" >
	            <@renderCurrenciesField name='intMgmtCostType' value=projectSpecsEMDetails.intMgmtCostType?default(defaultCurrency) disabled=false/>
	        <#else>
	        	<input type="text" name="intMgmtCost-display" disabled onchange="inititalMgmtCostChange()" <#if projectSpecsEMDetails.intMgmtCost??  > value="${projectSpecsEMDetails.intMgmtCost?default('')}" <#else> value="" </#if> class="form-text-div numericfield numericformat longField" >
	            <@renderCurrenciesField name='intMgmtCostType' value=projectSpecsEMDetails.intMgmtCostType?default(defaultCurrency) disabled=true/>
	        </#if>
            <@macroCurrencySelectError msg="Please select currency" />
            <@macroCustomFieldErrors msg='Please enter International Management Cost - Research Hub Cost' />
            <@macroCustomFieldErrors msg="Please enter International Management Cost - Research Hub Cost" class='numeric-error'/>
            <input type="hidden" name="intMgmtCost" <#if projectSpecsEMDetails.intMgmtCost?? > value="${projectSpecsEMDetails.intMgmtCost?c}" <#else> value="" </#if> >
        </div>
        <div class="form-select_div">
            <label>Local Management Cost</label>
            <script type="text/javascript">
                function localMgmtCostChange() {
                    var val = Number($j("input[name=localMgmtCost-display]").val().replace(/\,/g,''));
                    if(val) {
                        $j("input[name=localMgmtCost]").val(val);
                    } else {
                        $j("input[name=localMgmtCost]").val("");
                    }
                }
            </script>
            <#if isAdminUser>
	            <input type="text" name="localMgmtCost-display" onchange="localMgmtCostChange()" <#if projectSpecsEMDetails.localMgmtCost??  > value="${projectSpecsEMDetails.localMgmtCost?default('')}" <#else> value="" </#if>  class="form-text-div numericfield numericformat longField" >
	            <@renderCurrenciesField name='localMgmtCostType' value=projectSpecsEMDetails.localMgmtCostType?default(defaultCurrency) disabled=false/>
	        <#else>
	        	<input type="text" name="localMgmtCost-display" disabled onchange="localMgmtCostChange()" <#if projectSpecsEMDetails.localMgmtCost??  > value="${projectSpecsEMDetails.localMgmtCost?default('')}" <#else> value="" </#if>  class="form-text-div numericfield numericformat longField" >
            	<@renderCurrenciesField name='localMgmtCostType' value=projectSpecsEMDetails.localMgmtCostType?default(defaultCurrency) disabled=true/>
	        </#if>
            <@macroCurrencySelectError msg="Please select currency" />
            <@macroCustomFieldErrors msg='Please enter Local Management Cost' />
            <@macroCustomFieldErrors msg="Please enter Local Management Cost" class='numeric-error'/>
            <input type="hidden" name="localMgmtCost" <#if projectSpecsEMDetails.localMgmtCost?? > value="${projectSpecsEMDetails.localMgmtCost?c}" <#else> value="" </#if> >
        </div>

        <div class="form-select_div">
            <label>Fieldwork Cost</label>
            <script type="text/javascript">
                function fieldWorkCostChange() {
                    var val = Number($j("input[name=fieldworkCost-display]").val().replace(/\,/g,''));
                    if(val) {
                        $j("input[name=fieldworkCost]").val(val);
                    } else {
                        $j("input[name=fieldworkCost]").val("");
                    }
                }
            </script>
            <#if isAdminUser>
		        <input type="text" name="fieldworkCost-display" onchange="fieldWorkCostChange()"  <#if projectSpecsEMDetails.fieldworkCost??  > value="${projectSpecsEMDetails.fieldworkCost?default('')}" <#else> value="" </#if>  class="form-text-div numericfield numericformat longField" >
		        <@renderCurrenciesField name='fieldworkCostType' value=projectSpecsEMDetails.fieldworkCostType?default(defaultCurrency) disabled=false/>
		    <#else>
		    	<input type="text" name="fieldworkCost-display" onchange="fieldWorkCostChange()" disabled <#if projectSpecsEMDetails.fieldworkCost??  > value="${projectSpecsEMDetails.fieldworkCost?default('')}" <#else> value="" </#if>  class="form-text-div numericfield numericformat longField" >
		        <@renderCurrenciesField name='fieldworkCostType' value=projectSpecsEMDetails.fieldworkCostType?default(defaultCurrency) disabled=true/>
		    </#if>
            <@macroCurrencySelectError msg="Please select currency" />
            <@macroCustomFieldErrors msg='Please enter Fieldwork Cost' />
            <@macroCustomFieldErrors msg="Please enter Fieldwork Cost" class='numeric-error'/>
            <input type="hidden" name="fieldworkCost" <#if projectSpecsEMDetails.fieldworkCost?? > value="${projectSpecsEMDetails.fieldworkCost?c}" <#else> value="" </#if> >
        </div>

		<div class="form-select_div">
            <label>Operational Hub Cost</label>
            <script type="text/javascript">
                function operationalHubCostChange() {
                    var val = Number($j("input[name=operationalHubCost-display]").val().replace(/\,/g,''));
                    if(val) {
                        $j("input[name=operationalHubCost]").val(val);
                    } else {
                        $j("input[name=operationalHubCost]").val("");
                    }
                }
            </script>
            <#if isAdminUser>
		        <input type="text" name="operationalHubCost-display" onchange="operationalHubCostChange()"  <#if projectSpecsEMDetails.operationalHubCost??  > value="${projectSpecsEMDetails.operationalHubCost}" <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat longField" >
		        <@renderCurrenciesField name='operationalHubCostType' value=projectSpecsEMDetails.operationalHubCostType?default(defaultCurrency) disabled=false />
		    <#else>
		    	<input type="text" name="operationalHubCost-display" onchange="operationalHubCostChange()" disabled <#if projectSpecsEMDetails.operationalHubCost??  > value="${projectSpecsEMDetails.operationalHubCost}" <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat longField" >
		        <@renderCurrenciesField name='operationalHubCostType' value=projectSpecsEMDetails.operationalHubCostType?default(defaultCurrency) disabled=true />
		    </#if>
            <@macroCurrencySelectError msg="Please select currency" />
            <@macroCustomFieldErrors msg='Please enter Operational Hub Cost' />
            <@macroCustomFieldErrors msg="Please enter Operational Hub Cost" class='numeric-error'/>
            <input type="hidden" name="operationalHubCost" <#if projectSpecsEMDetails.operationalHubCost?? > value="${projectSpecsEMDetails.operationalHubCost?c}" <#else> value="" </#if> >
        </div>

        <div class="form-select_div">
            <label>Other Cost</label>
            <script type="text/javascript">
                function otherCostChange() {
                    var val = Number($j("input[name=otherCost-display]").val().replace(/\,/g,''));
                    if(val) {
                        $j("input[name=otherCost]").val(val);
                    } else {
                        $j("input[name=otherCost]").val("");
                    }
                }
            </script>
            <#if isAdminUser>
	            <input type="text" name="otherCost-display" onchange="otherCostChange()"  <#if projectSpecsEMDetails.otherCost??  > value="${projectSpecsEMDetails.otherCost}" <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat longField" >
	            <@renderCurrenciesField name='otherCostType' value=projectSpecsEMDetails.otherCostType?default(defaultCurrency) disabled=false />
	        <#else>
	        	<input type="text" name="otherCost-display" onchange="otherCostChange()" disabled <#if projectSpecsEMDetails.otherCost??  > value="${projectSpecsEMDetails.otherCost}" <#else> value="" </#if> size="20" class="form-text-div numericfield numericformat longField" >
           	 	<@renderCurrenciesField name='otherCostType' value=projectSpecsEMDetails.otherCostType?default(defaultCurrency) disabled=true />
	        </#if>
            <@macroCurrencySelectError msg="Please select currency" />
            <@macroCustomFieldErrors msg='Please enter Other Cost' />
            <@macroCustomFieldErrors msg="Please enter Other Cost" class='numeric-error'/>
            <input type="hidden" name="otherCost" <#if projectSpecsEMDetails.otherCost?? > value="${projectSpecsEMDetails.otherCost?c}" <#else> value="" </#if> >
        </div>

        <div class="form-text_div">
            <label>Name of Proposed Fieldwork Agencies</label>
            <#if isAdminUser>
            	<input type="text" name="proposedFWAgencyNames" value="${projectSpecsEMDetails.proposedFWAgencyNames?default('')}" class="form-text-div" >
            <#else>
            	<input type="text" name="proposedFWAgencyNames" disabled value="${projectSpecsEMDetails.proposedFWAgencyNames?default('')}" class="form-text-div" >
            </#if>
            <@macroCustomFieldErrors msg="Please enter Proposed Fieldwork Agencies"/>
        </div>
        <div class="form-text_div">
            <label>Estimated Fieldwork Start</label>
            <#if isAdminUser>
	            <#--<@jiveform.datetimepicker id="fwStartDate" name="fwStartDate" value=projectSpecsEMDetails.fwStartDate?default('') readonly=true/>-->
				<@synchrodatetimepicker id="fwStartDate" name="fwStartDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
	     		<#assign error_msg><@s.text name='project.error.fwstartdate' /></#assign>
	     		<@macroCustomFieldErrors msg=error_msg />
	     	<#else> 
            	<input type="text" name="fwStartDate" value="<#if projectSpecsEMDetails.fwStartDate?? >${projectSpecsEMDetails.fwStartDate?string('dd/MM/yyyy')}</#if>" disabled class="form-text-div" >
            </#if>
        </div>
        <div class="form-text_div">
            <label>Estimated Fieldwork Completion</label>
         	<#if isAdminUser>
         		<#--<@jiveform.datetimepicker id="fwEndDate" name="fwEndDate" value=projectSpecsEMDetails.fwEndDate?default('') readonly=true/>-->
				<@synchrodatetimepicker id="fwEndDate" name="fwEndDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
     			<#assign error_msg><@s.text name='project.error.fwenddate' /></#assign>
     			<@macroCustomFieldErrors msg=error_msg /> 
     		<#else>
            	<input type="text" name="fwEndDate" value="<#if projectSpecsEMDetails.fwEndDate?? >${projectSpecsEMDetails.fwEndDate?string('dd/MM/yyyy')}</#if>" disabled class="form-text-div" >
            </#if>
        </div>

    	<#if isAdminUser>
		    <div class="form-select_div_main">
		        <#assign dataCollectionIndex = emid?c/>
		        <@showDataCollectionFieldSection name='dataCollectionMethod' value=projectSpecsEMDetails.dataCollectionMethod?default('-1') selectedIndex=dataCollectionIndex />
		
		        <@macroFieldErrors name="collectionMethod"/>
		        <span id="dataCollectionError" class="jive-error-message" style="display:none">Please select Data Collection Method(s)</span>
		    </div>
  		<#else>
	        <div class="region-inner">
	            <label>Data Collection Methods</label>
	            <#assign dataCollectionIndex = emid?c/>
	            <@renderDataCollectionSelected name='dataCollectionMethod' value=projectSpecsEMDetails.dataCollectionMethod?default('-1') multiselect=true class='form-multi-select' readonly=true id='dataCollectionMethod'/>
	            <@macroFieldErrors name="collectionMethod"/>
	
	        </div>
	    </#if>

    </div>
</div>
<div class="pib-qualitative">
    <#assign quantitative_display = 'none' />
    <#if projectSpecsInitiation.methodologyType==1 || projectSpecsInitiation.methodologyType==3 >
        <#assign quantitative_display = 'block' />
    </#if>

    <div id="quantitative_div" style="display:${quantitative_display};">

        <h2 class="pib_sub_heading">Quantitative</h2>
        <p class="induction_text">(If any of fields are not relevant, please put '0' in it.)</p>
        <ul>
            <li>
                <div class="form-text_div">
                    <label>Total Number of Interviews</label>
                    <#if isAdminUser>
                    	<input type="text" name="totalNoInterviews-display" <#if projectSpecsEMDetails.totalNoInterviews?? && projectSpecsEMDetails.totalNoInterviews gt -1 > value="${projectSpecsEMDetails.totalNoInterviews}" <#else> value="" </#if>  class="form-text-div numericfield numericformat  no-decimal shortField" >
                    <#else>
                    	<input type="text" name="totalNoInterviews-display" disabled <#if projectSpecsEMDetails.totalNoInterviews?? && projectSpecsEMDetails.totalNoInterviews gt -1 > value="${projectSpecsEMDetails.totalNoInterviews}" <#else> value="" </#if>  class="form-text-div numericfield numericformat  no-decimal shortField" >
                    </#if>
                    <@macroCustomFieldErrors msg='Please enter Total number of Interviews' />
                    <@macroCustomFieldErrors msg="Please enter Total number of Interviews" class='numeric-error'/>
                    <input type="hidden" name="totalNoInterviews" <#if projectSpecsEMDetails.totalNoInterviews?? && projectSpecsEMDetails.totalNoInterviews gt -1 > value="${projectSpecsEMDetails.totalNoInterviews?c}" <#else> value="" </#if> >
                </div>
            </li>
            <li>
                <div class="form-text_div">
                    <label>Total Number of Visits per Respondent</label>
                    <#if isAdminUser>
                    	<input type="text" name="totalNoOfVisits-display" <#if projectSpecsEMDetails.totalNoOfVisits?? && projectSpecsEMDetails.totalNoOfVisits gt -1 > value="${projectSpecsEMDetails.totalNoOfVisits}" <#else> value="" </#if> class="form-text-div numericfield numericformat no-decimal shortField" >
                    <#else>
                    	<input type="text" name="totalNoOfVisits-display" disabled <#if projectSpecsEMDetails.totalNoOfVisits?? && projectSpecsEMDetails.totalNoOfVisits gt -1 > value="${projectSpecsEMDetails.totalNoOfVisits}" <#else> value="" </#if> class="form-text-div numericfield numericformat no-decimal shortField" >
                    </#if>
                    <@macroCustomFieldErrors msg='Please enter Total no of visits per respondent' />
                    <@macroCustomFieldErrors msg="Please enter Total no of visits per respondent" class='numeric-error'/>
                    <input type="hidden" name="totalNoOfVisits" <#if projectSpecsEMDetails.totalNoOfVisits?? && projectSpecsEMDetails.totalNoOfVisits gt -1 > value="${projectSpecsEMDetails.totalNoOfVisits?c}" <#else> value="" </#if> >
                </div>
            </li>
            <li>
                <div class="form-text_div">
                    <label>Average Interview Duration (in minutes)</label>
                    <#if isAdminUser>
                    	<input type="text" name="avIntDuration-display"  <#if projectSpecsEMDetails.avIntDuration?? && projectSpecsEMDetails.avIntDuration gt -1 > value="${projectSpecsEMDetails.avIntDuration}" <#else> value="" </#if>  class="form-text-div numericfield numericformat no-decimal shortField" >
                    <#else>
                    	<input type="text" name="avIntDuration-display" disabled <#if projectSpecsEMDetails.avIntDuration?? && projectSpecsEMDetails.avIntDuration gt -1 > value="${projectSpecsEMDetails.avIntDuration}" <#else> value="" </#if>  class="form-text-div numericfield numericformat no-decimal shortField" >
                    </#if>
                    <@macroCustomFieldErrors msg='Please enter Average Interview Duration' />
                    <@macroCustomFieldErrors msg="Please enter Average Interview Duration" class='numeric-error'/>
                    <input type="hidden" name="avIntDuration" <#if projectSpecsEMDetails.avIntDuration?? && projectSpecsEMDetails.avIntDuration gt -1 > value="${projectSpecsEMDetails.avIntDuration?c}" <#else> value="" </#if> >
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
                    <#if isAdminUser>
                    	<td><@renderRadioBox label='' name='geoSpread' id='geoSpreadNational' value='geoSpreadNational' isChecked=projectSpecsEMDetails.geoSpreadNational?default(false) disable=false /></td>
                    <#else>
                    	<td><@renderRadioBox label='' name='geoSpread' id='geoSpreadNational' value='geoSpreadNational' isChecked=projectSpecsEMDetails.geoSpreadNational?default(false) disable=true /></td>
                    </#if>
                    <td class="view-row-first">National</td>
                </tr>
                <tr class="color-row">
                    <#if isAdminUser>
                    	<td><@renderRadioBox label=''  name='geoSpread' id='geoSpreadUrban' value='geoSpreadUrban' isChecked=projectSpecsEMDetails.geoSpreadUrban?default(false) disable=false /></td>
                    <#else>
                    	<td><@renderRadioBox label=''  name='geoSpread' id='geoSpreadUrban' value='geoSpreadUrban' isChecked=projectSpecsEMDetails.geoSpreadUrban?default(false) disable=true /></td>
                    </#if>
                    <td class="view-row-first">Non-National</td>
                </tr>
                </tbody>
            </table>
        </div>

    <#--  Display cities section only when the Gerographical spread is Urban -->

        <div class="form-text_div" id="cities">
            <label>Please Define Geography</label>
            <#if isAdminUser>
            	<input type="text" name="cities"  value="${projectSpecsEMDetails.cities?default('')}"  class="form-text-div" >
            <#else>
            	<input type="text" name="cities"  value="${projectSpecsEMDetails.cities?default('')}" disabled class="form-text-div" >
            </#if>
        </div>
    </div>

    </div>
    <#assign qualitative_display = 'none' />
    <#if projectSpecsInitiation.methodologyType==2 || projectSpecsInitiation.methodologyType==3 >
        <#assign qualitative_display = 'block' />
    </#if>

    <div id="qualitative_div" style="display:${qualitative_display};">

        <h2 class="pib_sub_heading">Qualitative</h2>
        <p class="induction_text">(If any of fields are not relevant, please put '0' in it.)</p>
        <div class="form-text_div">
            <label>Total No of Groups/In-Depth Interviews</label>
            <#if isAdminUser>
            	<input type="text" name="totalNoOfGroups-display" <#if projectSpecsEMDetails.totalNoOfGroups?? && projectSpecsEMDetails.totalNoOfGroups gt -1 > value="${projectSpecsEMDetails.totalNoOfGroups}" <#else> value="" </#if>  class="form-text-div numericfield numericformat no-decimal shortField" >
            <#else>
            	<input type="text" name="totalNoOfGroups-display" disabled <#if projectSpecsEMDetails.totalNoOfGroups?? && projectSpecsEMDetails.totalNoOfGroups gt -1 > value="${projectSpecsEMDetails.totalNoOfGroups}" <#else> value="" </#if>  class="form-text-div numericfield numericformat no-decimal shortField" >
            </#if>
            <@macroCustomFieldErrors msg='Please enter Total No of Groups' />
            <@macroCustomFieldErrors msg="Please enter Total No of Groups" class='numeric-error'/>
            <input type="hidden" name="totalNoOfGroups" <#if projectSpecsEMDetails.totalNoOfGroups?? && projectSpecsEMDetails.totalNoOfGroups gt -1 > value="${projectSpecsEMDetails.totalNoOfGroups?c}" <#else> value="" </#if> >
        </div>
        <div class="form-text_div">
            <label>Group/In-Interview Duration (in minutes)</label>
            <#if isAdminUser>
            	<input type="text" name="interviewDuration-display" <#if projectSpecsEMDetails.interviewDuration?? && projectSpecsEMDetails.interviewDuration gt -1 > value="${projectSpecsEMDetails.interviewDuration}" <#else> value="" </#if>  class="form-text-div numericfield numericformat no-decimal shortField" >
            <#else>
            	<input type="text" name="interviewDuration-display" disabled <#if projectSpecsEMDetails.interviewDuration?? && projectSpecsEMDetails.interviewDuration gt -1 > value="${projectSpecsEMDetails.interviewDuration}" <#else> value="" </#if>  class="form-text-div numericfield numericformat no-decimal shortField" >
            </#if>
            <@macroCustomFieldErrors msg='Please enter Group/In-Interview Duration' />
            <@macroCustomFieldErrors msg="Please enter Group/In-Interview Duration" class='numeric-error'/>
            <input type="hidden" name="interviewDuration" <#if projectSpecsEMDetails.interviewDuration?? && projectSpecsEMDetails.interviewDuration gt -1 > value="${projectSpecsEMDetails.interviewDuration?c}" <#else> value="" </#if> >
        </div>
        <div class="form-text_div">
            <label>Number of Respondents per Group</label>
            <#if isAdminUser>
            	<input type="text" name="noOfRespPerGroup-display" <#if projectSpecsEMDetails.noOfRespPerGroup?? && projectSpecsEMDetails.noOfRespPerGroup gt -1 > value="${projectSpecsEMDetails.noOfRespPerGroup}" <#else> value="" </#if>  class="form-text-div numericfield numericformat no-decimal shortField" >
            <#else>
            	<input type="text" name="noOfRespPerGroup-display" disabled <#if projectSpecsEMDetails.noOfRespPerGroup?? && projectSpecsEMDetails.noOfRespPerGroup gt -1 > value="${projectSpecsEMDetails.noOfRespPerGroup}" <#else> value="" </#if>  class="form-text-div numericfield numericformat no-decimal shortField" >
            </#if>
            <@macroCustomFieldErrors msg='Please enter Number of Respondents per Group' />
            <@macroCustomFieldErrors msg="Please enter Number of Respondents per Group" class='numeric-error'/>
            <input type="hidden" name="noOfRespPerGroup" <#if projectSpecsEMDetails.noOfRespPerGroup?? && projectSpecsEMDetails.noOfRespPerGroup gt -1 > value="${projectSpecsEMDetails.noOfRespPerGroup?c}" <#else> value="" </#if> >
        </div>
    </div>
    

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
<#--</#list> -->
</div>
<!-- END MARKET FIELDS ENDS -->


<div class="ld-div">

    <div class="buttons">
        <#if editStage >

            <input type="submit" name="save pib" onclick="return validatePIBFormFields();" value="Save" class="save"/>
        </#if>
    </div>
<#-- END SYNCHRO-- Ending the else block for External Agency -->

</div>

</div>



<!-- BEGIN sidebar column -->
<div id="jive-body-sidebarcol-container" class="j-column j-column-s j-content-extras">
    <#include "/template/docs/synchro-doc-sidebar.ftl" />
</div>
<!-- END sidebar column -->
</form>

<#-- ELSE Block STARTS in case the project specs is not readonly -->
</#if>

<!-- SYNCHRO BEGIN -->
<!-- EMAIL NOTIFICATION WINDOW -->
<div id="emailNotification" style="display:none">
    <form id="email-notification-form" action="<@s.url value="/synchro/project-specs!sendNotification.jspa"/>" method="post" enctype="multipart/form-data" class="j-form-popup">
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
        <input type="hidden" id="approve" name="approve" value="" />
        <input class="j-btn-callout" type="button" name="doPost" id="postButton" onclick="return notificationVal();" value="Submit" style="font-weight: bold;" />

    </form>
</div>

<!-- MOVE TO NEXT STAGE FORM STARTS -->
<form method="POST" name="moveToNextStageForm" id="moveToNextStageForm" action="/synchro/project-specs!moveToNextStage.jspa"  >

    <input type="hidden" name="projectID" value="${projectID?c}">
    <input type="hidden" name="endMarketId" value="${endMarketId?c}">
    <input type="hidden" id="approve" name="approve" value="approve" />
</form>
<!-- MOVE TO NEXT STAGE FORM ENDS -->


<#--<!-- ATTACHMENT WINDOW STARTS &ndash;&gt;-->
<#--<div id="attachmentWindow" style="display:none">-->
<#--<div class="j-form-popup-main">-->
<#---->
<#--<form id="add-document-form" action="<@s.url value='/synchro/project-specs!addAttachment.jspa'/>" method="post" enctype="multipart/form-data" class="j-form-popup">-->
<#--<a href="javascript:void();" class="close" onclick="closeAttachmentWindow();"></a> -->
<#--<input type="file" id="attachFile" name="attachFile" class="form-text" onchange="inputChange(this)">-->
<#---->
<#--<div class="views-field">-->
<#--<input type="radio" id="fieldCategoryId" name="fieldCategoryId" value="${bussinessQuestionID?c}" />-->
<#--<label>Business Question</label>-->
<#--</div>-->
<#--<div class="views-field">		        -->
<#--<input type="radio" id="fieldCategoryId" name="fieldCategoryId" value="${researchObjectiveID?c}" />-->
<#--<label>Research Objective(s)</label>-->
<#--</div>-->
<#--<div class="views-field">-->
<#--<input type="radio" id="fieldCategoryId" name="fieldCategoryId" value="${actionStandardID?c}" />-->
<#--<label>Action Standard(s)</label>-->
<#--</div>-->
<#--<div class="views-field">-->
<#--<input type="radio" id="fieldCategoryId" name="fieldCategoryId" value="${researchDesignID?c}" />-->
<#--<label>Methodology Approach and Research design</label>-->
<#--</div>-->
<#--<div class="views-field">-->
<#--<input type="radio" id="fieldCategoryId" name="fieldCategoryId" value="${sampleProfileID?c}" />-->
<#--<label>Sample Profile (Research</label>-->
<#--</div>-->
<#--<div class="views-field">-->
<#--<input type="radio" id="fieldCategoryId" name="fieldCategoryId" value="${stimulusMaterialID?c}" />-->
<#--<label>Stimulus Material</label>-->
<#--</div>-->
<#--<div class="views-field">-->
<#--<input type="radio" id="fieldCategoryId" name="fieldCategoryId" value="${otherReportingRequirementID?c}" />-->
<#--<label>Other Reporting Requirements</label>-->
<#--</div>-->
<#--<div class="views-field">-->
<#--<input type="radio" id="fieldCategoryId" name="fieldCategoryId" value="${othersID?c}" />-->
<#--<label>Others</label>-->
<#--</div>-->
<#--<div class="views-field">-->
<#--<input type="radio" id="fieldCategoryId" name="fieldCategoryId" value="${screenerID?c}" />-->
<#--<label>Screener</label>-->
<#--</div>-->
<#--<div class="views-field">-->
<#--<input type="radio" id="fieldCategoryId" name="fieldCategoryId" value="${cccAgreementID?c}" />-->
<#--<label>Consumer contract and Confidentiality agreement</label>-->
<#--</div>-->
<#--<div class="views-field">-->
<#--<input type="radio" id="fieldCategoryId" name="fieldCategoryId" value="${questionnaireID?c}" />-->
<#--<label>Questionnaires</label>-->
<#--</div>-->
<#--<div class="views-field">-->
<#--<input type="radio" id="fieldCategoryId" name="fieldCategoryId" value="${discussionGuideID?c}" />-->
<#--<label>Discussion guide</label>-->
<#--</div>-->
<#--<input type="hidden" name="projectID" value="${projectID?c}">-->
<#--<input type="hidden" name="endMarketId" value="${endMarketId?c}">-->
<#--<div class="views-field">-->
<#--<input class="j-btn-callout cancel-btn" type="cancel" name="doPost" id="postButton"  value="cancel" style="font-weight: bold;" onclick="closeAttachmentWindow();"/> -->
<#--<input class="j-btn-callout add-btn" type="submit" name="doPost" id="postButton"  value="add" style="font-weight: bold;" onclick="return validateAttachmentWindow();"/>-->
<#--</div>  -->
<#--</form>-->
<#--</div>-->
<#--</div>-->
<!-- ATTACHMENT WINDOW ENDS -->



<!-- INITIATE WAIVER WINDOW STARTS -->
<div id="initiateWaiver" style="display:none">
    <script type="text/javascript">
        $j(document).ready(function(){
		if($j("#initiateWaiver").parent().hasClass('light-box'))
		{
			$j("#initiateWaiver").parent().prepend($j("#success-msg-waiver"));
		}          
        });
    </script>
<div class="popup-waiver">
    <#--<div id="success-msg-waiver" class="success-msg-waiver">-->
    <#--<#if pibMethodologyWaiver.isApproved?? && (pibMethodologyWaiver.isApproved==1 || pibMethodologyWaiver.isApproved==2)>style="display: block;"<#else>style="display: none;"</#if>>-->
    <#if  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
        <div id="success-msg-waiver" class="approve-msg-waiver">
            <span class="waiver-icon"></span>
            <span class="waiver-msg">Waiver is Approved.</span>
        </div>
    <#elseif  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==2>
        <div id="success-msg-waiver" class="reject-msg-waiver">
            <span class="waiver-icon"></span>
            <span class="waiver-msg waiver-rejected">Waiver is Rejected.</span>
        </div>
    </#if>
    <#--</div>-->
    
    <#if isAdminUser>
    	
    	<form id="waiver-form" action="<@s.url value="/synchro/project-specs!updateWaiver.jspa"/>" method="post">
			<label class='rte-editor-label'>Methodology Deviation Rationale</label>	
            <div class="pib_view_popup form-text_div">                
                <textarea id="methodologyDeviationRationale" name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>                    
            </div>
            <div class="pib_view_popup">
                <label class="synchro-help-waiver-label" title="Centrally Managed Brands - Premium - SebnemUner
Centrally Managed Brands - Non Premium - Sarah Harris 
Oracle Methodologies (exc. Product) - TainaVauhkonen
Product Methodologies - Mark Barnes
Non Combustibles Research (excHnB) - Ankur Tomar 
Non Combustibles Research - HnB - Zoltan Haas
Regionally Managed Brands - EEMEA and WER - SebnemUner
Regionally Managed Brands - ASPAC and AMERICAS - Mark Barnes
Other - TainaVauhkonen">Methodology Approver<span title="Centrally Managed Brands - Premium - SebnemUner
Centrally Managed Brands - Non Premium - Sarah Harris 
Oracle Methodologies (exc. Product) - TainaVauhkonen
Product Methodologies - Mark Barnes
Non Combustibles Research (excHnB) - Ankur Tomar 
Non Combustibles Research - HnB - Zoltan Haas
Regionally Managed Brands - EEMEA and WER - SebnemUner
Regionally Managed Brands - ASPAC and AMERICAS - Mark Barnes
Other - TainaVauhkonen">help</span></label>
                
                <@renderMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibMethodologyWaiver.methodologyApprover?default(-1)?c}"/>
                
				<input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
                <input  id="send-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="SEND FOR INFORMATION" style="font-weight: bold;" />
				
				
               
            </div>

            <div class="pib_view_popup">
                <label>Methodology Approver Comment</label>

                <textarea id="methodologyApproverComment" name="methodologyApproverComment" placeholder="Methodology Approver Comments">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>                
           
           </div>
           
           <input id="request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
		   <input id="approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
           <input id="reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />	
			
            
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" name="endMarketId" value="${projSpecsEndMarketId?c}">
            <input type="hidden" id="methodologyWaiverAction" name="methodologyWaiverAction" value="">
        </form>
    
    <#elseif projectSpecsInitiation.status ?? && projectSpecsInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROJECT_SPECS_COMPLETED.ordinal() >

        <label class='rte-editor-label'>Methodology Deviation Rationale</label>
        <div class="pib_view_popup form-text_div">
            <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
        </div>
        <div class="pib_view_popup">
             <label class="synchro-help-waiver-label" title="Centrally Managed Brands - Premium - SebnemUner
Centrally Managed Brands - Non Premium - Sarah Harris 
Oracle Methodologies (exc. Product) - TainaVauhkonen
Product Methodologies - Mark Barnes
Non Combustibles Research (excHnB) - Ankur Tomar 
Non Combustibles Research - HnB - Zoltan Haas
Regionally Managed Brands - EEMEA and WER - SebnemUner
Regionally Managed Brands - ASPAC and AMERICAS - Mark Barnes
Other - TainaVauhkonen">Methodology Approver<span title="Centrally Managed Brands - Premium - SebnemUner
Centrally Managed Brands - Non Premium - Sarah Harris 
Oracle Methodologies (exc. Product) - TainaVauhkonen
Product Methodologies - Mark Barnes
Non Combustibles Research (excHnB) - Ankur Tomar 
Non Combustibles Research - HnB - Zoltan Haas
Regionally Managed Brands - EEMEA and WER - SebnemUner
Regionally Managed Brands - ASPAC and AMERICAS - Mark Barnes
Other - TainaVauhkonen">help</span></label>
            <@renderMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibMethodologyWaiver.methodologyApprover?default(-1)?c}" readonly=true/>
            <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold; cursor:default;" />
            <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton"  value="SEND FOR INFORMATION" style="font-weight: bold; cursor:default;" />
        </div>

        <div class="pib_view_popup">
            <label>Methodology Approver Comment</label>
            <textarea id="methodologyApproverComment"  disabled name="methodologyApproverComment">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
        </div>
        <input type="button" class="g-btn r-more" name="doPost" id="postButton"  value="REQUEST MORE INFORMATION" style="font-weight: bold; cursor:default;" />
        <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton"  value="Approve" style="font-weight: bold; cursor:default;" />
        <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold; cursor:default;" />


    <#else>

        <form id="waiver-form" action="<@s.url value="/synchro/project-specs!updateWaiver.jspa"/>" method="post">
			<label class='rte-editor-label'>Methodology Deviation Rationale</label>
            <div class="pib_view_popup form-text_div">
               
                <#if isMethAppUser && !(isProjectOwner || isSPIContactUser || isProjectCreator)>
                    <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
                <#elseif  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                    <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
                <#else>
                    <#--<textarea id="methodologyDeviationRationale" name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>    
					-->
				<textarea id="methodologyDeviationRationale" name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>                    
                </#if>
            </div>
            <div class="pib_view_popup">
                <label class="synchro-help-waiver-label" title="Centrally Managed Brands - Premium - SebnemUner
Centrally Managed Brands - Non Premium - Sarah Harris 
Oracle Methodologies (exc. Product) - TainaVauhkonen
Product Methodologies - Mark Barnes
Non Combustibles Research (excHnB) - Ankur Tomar 
Non Combustibles Research - HnB - Zoltan Haas
Regionally Managed Brands - EEMEA and WER - SebnemUner
Regionally Managed Brands - ASPAC and AMERICAS - Mark Barnes
Other - TainaVauhkonen">Methodology Approver<span title="Centrally Managed Brands - Premium - SebnemUner
Centrally Managed Brands - Non Premium - Sarah Harris 
Oracle Methodologies (exc. Product) - TainaVauhkonen
Product Methodologies - Mark Barnes
Non Combustibles Research (excHnB) - Ankur Tomar 
Non Combustibles Research - HnB - Zoltan Haas
Regionally Managed Brands - EEMEA and WER - SebnemUner
Regionally Managed Brands - ASPAC and AMERICAS - Mark Barnes
Other - TainaVauhkonen">help</span></label>
                <#if isMethAppUser && !(isProjectOwner || isSPIContactUser || isProjectCreator)>
                    <@renderMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibMethodologyWaiver.methodologyApprover?default(-1)?c}" readonly=true/>
                <#else>
                    <@renderMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibMethodologyWaiver.methodologyApprover?default(-1)?c}"/>
                </#if>

                <!-- Current User is either Project Owner or SPI User-->
                <#if isProjectOwner || isSPIContactUser || isProjectCreator>
                    <#if  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                        <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold; cursor:default;" />
                        <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton"  value="SEND FOR INFORMATION" style="font-weight: bold; cursor:default;" />
                    <#else>
                        <input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
                        <input  id="send-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="SEND FOR INFORMATION" style="font-weight: bold;" />

                    </#if>

                <#elseif isMethAppUser>
                    <input type="button" class="g-btn"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold; cursor:default;" />
                    <input type="button" class="g-btn"  name="doPost" id="postButton"  value="SEND FOR INFORMATION" style="font-weight: bold; cursor:default;" />
                </#if>
            </div>

            <div class="pib_view_popup">
                <label>Methodology Approver Comment</label>

                <!-- Current User is Methodology User and is also Project Methodology Approver -->
                <#if isMethAppUser && pibMethodologyWaiver.methodologyApprover?? && user.ID==pibMethodologyWaiver.methodologyApprover>
                    <#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                        <textarea id="methodologyApproverComment"  disabled name="methodologyApproverComment">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
                    <#else>
                        <textarea id="methodologyApproverComment" name="methodologyApproverComment" placeholder="Methodology Approver Comments">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>                        
                    </#if>
                    <!-- Current User is NOT Methodology Approver User -->
                <#else>
                    <textarea id="methodologyApproverComment"  disabled name="methodologyApproverComment">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
                </#if>
            </div>

            <!-- Current User is Methodology User and is also Project Methodology Approver -->
            <#if isMethAppUser && pibMethodologyWaiver.methodologyApprover?? && user.ID==pibMethodologyWaiver.methodologyApprover>

                <#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                    <input type="button" class="g-btn r-more" name="doPost" id="postButton"  value="REQUEST MORE INFORMATION" style="font-weight: bold; cursor:default;" />
                <#else>
                    <input id="request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
                </#if>
                <#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                    <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton"  value="Approve" style="font-weight: bold; cursor:default;" />
                    <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold; cursor:default;" />
                <#--
                <#elseif projectSpecsInitiation.status?? && projectSpecsInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROJECT_SPECS_METH_WAIV_APP_PENDING.ordinal()>
                    <input id="approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
                    <input id="reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />
                <#elseif projectSpecsInitiation.status?? && projectSpecsInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROJECT_SPECS_METH_WAIV_MORE_INFO_REQ.ordinal()>
                    <input id="approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
                    <input id="reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />
				-->
				
				<#elseif pibMethodologyWaiver.status?? && pibMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_APP_PENDING.ordinal()>
	                <input id="approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
	                <input id="reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />
	            <#elseif pibMethodologyWaiver.status?? && pibMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_MORE_INFO_REQ.ordinal()>
	                <input id="approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
	                <input id="reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />
                <#else>
                    <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton"  value="Approve" style="font-weight: bold; cursor:default;" />
                    <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold; cursor:default;" />
                </#if>



                <!-- Current User is NOT Methodology Approver User -->
            <#else>
                <input type="button" class="g-btn r-more"  name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold; cursor:default;" />
                <input type="button" class="g-btn g-btn-medium"  name="doPost" id="postButton" value="Approve" style="font-weight: bold; cursor:default;" />
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold; cursor:default;" />
            </#if>
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" name="endMarketId" value="${projSpecsEndMarketId?c}">
            <input type="hidden" id="methodologyWaiverAction" name="methodologyWaiverAction" value="">
        </form>
    </#if>
    </div>
</div>
<!-- INITIATE WAIVER WINDOW ENDS -->


<!-- CHANGE FIELDWORK WINDOW STARTS -->
<div id="fieldWorkWindow" style="display:none">
    <div class="popup-waiver">
        <div class="pro-chg-field">
            <form id="fieldwork-form-popup" action="<@s.url value="/synchro/project-specs!updateFielwork.jspa"/>" method="post" class="j-form-popup fieldwork-form-popup">
                <a href="javascript:void(0);" class="close" onclick="closeFieldWorkWindow();"></a>
            <#-- <#list endMarketDetails as endMarketDetail> -->
            <#assign emid = projSpecsEndMarketId />
                <h3 id="block_header_${emid}" >${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emid?int)}
                    <a id="legend_${emid}" href="javascript:void(0);" class="close-form"></a>
                </h3>
                <div class="pro-planned-dates">
                    <div class="pib_view_popup">
                        <div class="form-date_div">
                            <h2 class="pib_sub_heading label_b">Planned Project End Date</h2>
                            <label>Project End<br/>(Results)</label>
                            <input type="text" name="cities" disabled value="<#if projectSpecsEMDetails.projectEndDate?? >${projectSpecsEMDetails.projectEndDate?string('dd/MM/yyyy')}</#if>" class="form-text-div" >
                        </div>
                        <div class="form-date_div right">
                            <h2 class="pib_sub_heading label_b">Estimated Project End Date</h2>
                            <label>Project End<br/>(Results)</label>
                        <#--<@jiveform.datetimepicker id="projectEndDateLatest" name="projectEndDateLatest" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
						<@synchrodatetimepicker id="projectEndDateLatest" name="projectEndDateLatest" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
                        <@macroCustomFieldErrors msg='' />
                        </div>

                    </div>

                <#if projectSpecsInitiation.methodologyType!=4 >
                    <div class="pib_view_popup">
                        <h2 class="pib_sub_heading label_b">Planned Fieldwork Dates</h2>
                        <div class="form-date_div">
                            <label>Fieldwork Begin</label>
                            <input type="text" name="cities" disabled value="<#if projectSpecsEMDetails.fwStartDate?? >${projectSpecsEMDetails.fwStartDate?string('dd/MM/yyyy')}</#if>" class="form-text-div" >
                        </div>
                        <div class="form-date_div right">
                            <label>Fieldwork  End</label>
                            <input type="text" name="cities"  disabled value="<#if projectSpecsEMDetails.fwEndDate?? >${projectSpecsEMDetails.fwEndDate?string('dd/MM/yyyy')}</#if>" class="form-text-div" >
                        </div>
                    </div>
                    <div class="pib_view_popup">
                        <h2 class="pib_sub_heading label_b">Latest Fieldwork Estimate</h2>
                        <div class="form-date_div">
                            <label>Fieldwork Begin</label>
                            <#--<@jiveform.datetimepicker id="fwStartDateLatest" name="fwStartDateLatest" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
								<@synchrodatetimepicker id="fwStartDateLatest" name="fwStartDateLatest" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
                            <@macroCustomFieldErrors msg='' />
                        </div>
                        <div class="form-date_div right">
                            <label>Fieldwork  End</label>
                           <#-- <@jiveform.datetimepicker id="fwEndDateLatest" name="fwEndDateLatest" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
							<@synchrodatetimepicker id="fwEndDateLatest" name="fwEndDateLatest" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
                            <@macroCustomFieldErrors msg='' />
                        </div>
                    </div>
                </#if>
                </div>
				<label class="label_b">Fieldwork&nbsp;change&nbsp;comments</label>
                <div class="pib_view_popup pro-latest-field">                    
                    <textarea id="latestFWComments" name="latestFWComments">${projectSpecsEMDetails.latestFWComments?default('')}</textarea>                    
                </div>

                <div class="pib_view_popup pro-latest-field last">
                    <label>Original Cost</label>
                    <input type="text" name="originalfinalCost-display" value="${projectSpecsEMDetails.originalFinalCost?default('')}" disabled class="form-text-div numericfield numericformat longField" >
                <@renderCurrenciesField name='originalfinalCostType'  value=projectSpecsEMDetails.originalFinalCostType?default(defaultCurrency) disabled=true/>
                </div>

                <div class="pib_view_popup pro-latest-field last">
                    <label>Final Cost</label>
                    <script type="text/javascript">
                        function finalCostChange() {
                            var val = Number($j("input[name=finalCost-display]").val().replace(/\,/g,''));
                            if(val) {
                                $j("input[name=finalCost]").val(val);
                            } else {
                                $j("input[name=finalCost]").val("");
                            }
                        }
                    </script>
                <input type="text" name="finalCost-display" onchange="finalCostChange()" value="${projectSpecsEMDetails.finalCost?default('')}" class="form-text-div numericfield numericformat longField" title="If the project has a fieldwork tendering process then the final cost does not include the fieldwork cost" >
                <@renderCurrenciesField name='finalCostType'  value=projectSpecsEMDetails.finalCostType?default(defaultCurrency) disabled=false/>
                <@macroCurrencySelectError msg="Please select currency" />
                <@macroCustomFieldErrors msg='Please enter final cost' />
                <@macroCustomFieldErrors msg='' class='numeric-error' />
                    <input type="hidden" name="finalCost"  value="<#if projectSpecsEMDetails.finalCost??>${projectSpecsEMDetails.finalCost?c}</#if>" />
                </div>
				<label class="label_b">Cost change comments</label>
                <div class="pib_view_popup pro-latest-field last">                    
                    <textarea id="finalCostComments" name="finalCostComments">${projectSpecsEMDetails.finalCostComments?default('')}</textarea>
					<@macroCustomFieldErrors msg='Please enter comments' />                    
                </div>
                <div>
                    <input class="j-btn-callout" type="submit" name="doPost" onclick="return dateValidations();" id="postButton"  value="Save" style="font-weight: bold;" />
                <#-- </#list> -->
                    <input type="hidden" name="projectID" value="${projectID?c}">
                </div>

            </form>
        </div>
    </div>
</div>
<!-- CHANGE FIELDWORK WINDOW ENDS -->

</div>

<!-- SYNCHRO ENDS -->

</div>

<form method="POST" enctype="multipart/form-data" action="/synchro/generate-pdf.jspa" id="pdf_img_screen_form">	
    <input type="hidden" name="pdfImageDataURL" id="pdf_img_screen" value="" />
	<input type="hidden" name="projectId" id="projectId" value="${projectID?c}" />
	<input type="hidden" name="pdfFileName" id="pdfFileName" value="" />
	<input type="hidden" name="redirectURL" id="redirectURL" value="" />
	<input type="hidden" id="report-token" name="token" value="projectspecs-token-${user.ID?c}" />
	<input type="hidden" id="report-token-cookie" name="tokenCookie" value="pdfcookie" />
</form>

</div>
<script type="text/javascript">
var selectedCategoryList = {};
var selectedProposedMethList = {};
$j(document).ready(function() {
    /*Initialize Project Owner Field*/
    var projectOwner = -1;
	var isReference = false;
	
<#assign isReference = false />
<#if project?? && project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
    projectOwner = ${project.projectOwner?c};
<#else>
    <#assign isReference = true />
    projectOwner = -1;
</#if>
    <#--initializeUserPicker({$input:$j("#projectOwner"),name:'projectOwner',value:projectOwner,defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});-->
	initializeUserPicker({$input:$j("#projectOwner"),name:'projectOwner',defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});

<#if isReference && project.projectOwner??>
    $j('input[name=projectOwner]').val("${project.projectOwner?c}");
    <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner) />
    $j("#projectOwner").val("${userDisplayName}");
    <#assign isReference = false />
</#if>

    /*Initialize Spi Contact Field*/
    var spiContact = -1;
<#if spiContact?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(spiContact) >
    spiContact = ${spiContact?c};
<#else>
    <#assign isReference = true />
    spiContact = -1;
</#if>
    <#--initializeUserPicker({$input:$j("#spiContact"),name:'spiContact',value:spiContact,defaultFilters:{'role':1,'roleEnabled':false}});-->
	initializeUserPicker({$input:$j("#spiContact"),name:'spiContact',defaultFilters:{'role':1,'roleEnabled':false}});

<#if isReference && spiContact??>
    $j('input[name=spiContact]').val("${spiContact?c}");
    <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(spiContact) />
    $j("#spiContact").val("${userDisplayName}");
    <#assign isReference = false />
</#if>

    /*Load start and end dates*/
var _startDate = <#if projectSpecsInitiation.startDate?? >"${projectSpecsInitiation.startDate?string('dd/MM/yyyy')}";<#else>"";</#if>
var _endDate = <#if projectSpecsInitiation.endDate?? >"${projectSpecsInitiation.endDate?string('dd/MM/yyyy')}";<#else>"";</#if>
var _stimuliDate = <#if projectSpecsInitiation.stimuliDate?? >"${projectSpecsInitiation.stimuliDate?string('dd/MM/yyyy')}";<#else>"";</#if>
var _fwStartDate = <#if projectSpecsEMDetails.fwStartDate?? >"${projectSpecsEMDetails.fwStartDate?string('dd/MM/yyyy')}";<#else>"";</#if>
var _fwEndDate = <#if projectSpecsEMDetails.fwEndDate?? >"${projectSpecsEMDetails.fwEndDate?string('dd/MM/yyyy')}";<#else>"";</#if>

var _fwStartDateLatest = <#if projectSpecsEMDetails.fwStartDateLatest?? >"${projectSpecsEMDetails.fwStartDateLatest?string('dd/MM/yyyy')}";<#else>"";</#if>
var _fwEndDateLatest = <#if projectSpecsEMDetails.fwEndDateLatest?? >"${projectSpecsEMDetails.fwEndDateLatest?string('dd/MM/yyyy')}";<#else>"";</#if>
var _projectEndDateLatest = <#if projectSpecsEMDetails.projectEndDateLatest?? >"${projectSpecsEMDetails.projectEndDateLatest?string('dd/MM/yyyy')}";<#else>"";</#if>

    $j("#startDate").val(_startDate);
    $j("#endDate").val(_endDate);
    $j("#stimuliDate").val(_stimuliDate);

<#if projectSpecsInitiation.methodologyType!=4 >
    $j("#fwStartDate").val(_fwStartDate);
    $j("#fwEndDate").val(_fwEndDate);
    $j("#fwStartDateLatest").val(_fwStartDateLatest);
    $j("#fwEndDateLatest").val(_fwEndDateLatest);
</#if>

    $j("#projectEndDateLatest").val(_projectEndDateLatest);

<#if projectSpecsInitiation.deviationFromSM?? && projectSpecsInitiation.deviationFromSM==1 >
    $j("#initiateWaiverButton").show();
<#else>
    $j("#initiateWaiverButton").hide();
</#if>

    /*Mandatory Fields Validation Start */
<#if showMandatoryFieldsError?? && showMandatoryFieldsError>
    var businessQuestion = $j("textarea[name=bizQuestion]");
    var researchObjective = $j("textarea[name=researchObjective]");
    var actionStandard = $j("textarea[name=actionStandard]");
    var researchDesign = $j("textarea[name=researchDesign]");

    var sampleProfile = $j("textarea[name=sampleProfile]");
    var stimulusMaterial = $j("textarea[name=stimulusMaterial]");
    var stimulusMaterialShipped = $j("textarea[name=stimulusMaterialShipped]");

    var screener = $j("textarea[name=screener]");
    var consumerCCAgreement = $j("textarea[name=consumerCCAgreement]");
    var questionnaire = $j("textarea[name=questionnaire]");
    var discussionguide = $j("textarea[name=discussionguide]");


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
    var stimuliDate = $j("input[name=stimuliDate]");

    if(businessQuestion.val() != null && $j.trim(businessQuestion.val())=="")
    {
        // businessQuestion.focus();
        <#if attachmentMap?? && attachmentMap.get(bussinessQuestionID)?? >
        <#else>
            businessQuestion.next().show();
        </#if>
    }
    if(researchObjective.val() != null && $j.trim(researchObjective.val())=="")
    {
        //  researchObjective.focus();
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
        //researchDesign.focus();
        <#if attachmentMap?? && attachmentMap.get(researchDesignID)?? >
        <#else>
            researchDesign.next().show();
        </#if>
    }
    if(sampleProfile.val() != null && $j.trim(sampleProfile.val())=="")
    {
        //  sampleProfile.focus();
        <#if attachmentMap?? && attachmentMap.get(sampleProfileID)?? >
        <#else>
            sampleProfile.next().show();
        </#if>
    }
    if(stimulusMaterial.val() != null && $j.trim(stimulusMaterial.val())=="")
    {
        //stimulusMaterial.focus();
        <#if attachmentMap?? && attachmentMap.get(stimulusMaterialID)?? >
        <#else>
            stimulusMaterial.next().show();
        </#if>
    }
    if(stimulusMaterialShipped.val() != null && $j.trim(stimulusMaterialShipped.val())=="")
    {
        //stimulusMaterialShipped.focus();
        <#if attachmentMap?? && attachmentMap.get(stimulusMaterialShippedID)?? >
        <#else>
            stimulusMaterialShipped.next().show();
        </#if>
    }
    if(screener.val() != null && $j.trim(screener.val())=="")
    {
        //screener.focus();
        <#if attachmentMap?? && attachmentMap.get(screenerID)?? >
        <#else>
            screener.next().show();
        </#if>
    }
    if(consumerCCAgreement.val() != null && $j.trim(consumerCCAgreement.val())=="")
    {
        //consumerCCAgreement.focus();
        <#if attachmentMap?? && attachmentMap.get(cccAgreementID)?? >
        <#else>
            consumerCCAgreement.next().show();
        </#if>
    }
    if(questionnaire.val() != null && $j.trim(questionnaire.val())=="")
    {
        //  questionnaire.focus();
        <#if attachmentMap?? && attachmentMap.get(questionnaireID)?? >
        <#else>
            questionnaire.next().show();
        </#if>
    }
    if(discussionguide.val() != null && $j.trim(discussionguide.val())=="")
    {
        //discussionguide.focus();
        <#if attachmentMap?? && attachmentMap.get(discussionGuideID)?? >
        <#else>
            discussionguide.next().show();
        </#if>
    }
    if($j.trim(stimuliDate.val())=="")
    {
        //stimuliDate.focus();
        stimuliDate.parent().find("span").show();
        stimuliDate.parent().find("span").text("Please enter stimuli date");

    }
    var reportRequirementSelected = false;
    $j(".pib-report-requirement").find('input[type="checkbox"]:checked').each(function(){
        reportRequirementSelected = true;
    });

    if(!reportRequirementSelected)
    {
        //$j("#topLinePresentation_display").focus();
        $j(".pib-report-requirement").find("span").show();
    }
    if(totalCost.val() != null && $j.trim(totalCost.val())=="")
    {
        // totalCost.focus();
        totalCost.parent().find("span:first").show();
    }

    if(intMgmtCost.val() != null && $j.trim(intMgmtCost.val())=="")
    {
        // intMgmtCost.focus();
        intMgmtCost.parent().find("span:first").show();
    }

    if(localMgmtCost.val() != null && $j.trim(localMgmtCost.val())=="")
    {
        //   localMgmtCost.focus();
        localMgmtCost.parent().find("span:first").show();
    }
    if(fieldworkCost.val() != null && $j.trim(fieldworkCost.val())=="")
    {
        //fieldworkCost.focus();
        fieldworkCost.parent().find("span:first").show();
    }

    if(proposedFWAgencyNames.val() != null && $j.trim(proposedFWAgencyNames.val())=="")
    {
        //proposedFWAgencyNames.focus();
        proposedFWAgencyNames.next().show();
    }

    if(totalNoInterviews.val() != null && $j.trim(totalNoInterviews.val())=="")
    {
        //totalNoInterviews.focus();
        totalNoInterviews.next().show();
    }
    if(totalNoOfVisits.val() != null && $j.trim(totalNoOfVisits.val())=="")
    {
        //totalNoOfVisits.focus();
        totalNoOfVisits.next().show();
    }
    if(avIntDuration.val() != null && $j.trim(avIntDuration.val())=="")
    {
        //avIntDuration.focus();
        avIntDuration.next().show();
    }

    if(totalNoOfGroups.val() != null && $j.trim(totalNoOfGroups.val())=="")
    {
        //totalNoOfGroups.focus();
        totalNoOfGroups.next().show();
    }
    if(interviewDuration.val() != null && $j.trim(interviewDuration.val())=="")
    {
        // interviewDuration.focus();
        interviewDuration.next().show();
    }
    if(noOfRespPerGroup.val() != null && $j.trim(noOfRespPerGroup.val())=="")
    {
        // noOfRespPerGroup.focus();
        noOfRespPerGroup.next().show();
    }

    <#if projectSpecsEMDetails.dataCollectionMethod?? && projectSpecsEMDetails.dataCollectionMethod.size() gt 0 >
    <#else>
        dataCollectionError.show();
    </#if>
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

	if(window.location.href.indexOf("legalApprover") > -1) 
	{
		$j("#legalApproverStimulus").focus();
	}

    /*Methodology Waiver Events*/

    $j("#send-for-approval").click(function() {
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
		showLoader('Please wait...');
        setMethodologyWaiverReqMoreInfo();
        var form = $j("#waiver-form");
        form.submit();
    });
    $j("#approve-waiver-btn").click(function() {
		showLoader('Please wait...');
        setMethodologyWaiverApprove();
        var form = $j("#waiver-form");
        form.submit();
    });
    $j("#reject-waiver-btn").click(function() {
		showLoader('Please wait...');
        setMethodologyWaiverReject();
        var form = $j("#waiver-form");
        form.submit();
    });


    $j( "#fieldwork-form-popup" ).submit(function( event ) {
        showLoader('Please wait...');
        $j( ".jive-error-message" ).each(function( index ) {
            if(!$j(this).hasClass('numeric-error'))
            {
                $j(this).hide();
            }
        });

        var error= false;

        /* Fieldwork Start and End Dates check */
    <#if projectSpecsInitiation.methodologyType!=4 >

        var fwStartDateLatest = $j("input[name=fwStartDateLatest]");
        if(fwStartDateLatest.val() != null && $j.trim(fwStartDateLatest.val())=="")
        {
            if(!error)
                fwStartDateLatest.focus();
            fwStartDateLatest.parent().parent().find("span").text("Please select fieldwork begin date");
            fwStartDateLatest.parent().parent().find("span").show();
            error = true;
        }
        else if(!isDateformat(fwStartDateLatest.val()))
        {
            if(!error)
                fwStartDateLatest.focus();
            fwStartDateLatest.parent().parent().find("span").show();
            fwStartDateLatest.parent().parent().find("span").text("Project start date should be in dd/mm/yyyy format");
            error = true;
        }


        var fwEndDateLatest = $j("input[name=fwEndDateLatest]");
        if(fwEndDateLatest.val() != null && $j.trim(fwEndDateLatest.val())=="")
        {
            if(!error)
                fwEndDateLatest.focus();
            fwEndDateLatest.parent().parent().find("span").text("Please select fieldwork end date");
            fwEndDateLatest.parent().parent().find("span").show();
            error = true;
        }
        else if(!isDateformat(fwEndDateLatest.val()))
        {
            if(!error)
                fwEndDateLatest.focus();
            fwEndDateLatest.parent().parent().find("span").show();
            fwEndDateLatest.parent().parent().find("span").text("Project end date should be in dd/mm/yyyy format");
            error = true;
        }

        if(isDateformat(fwStartDateLatest.val()) && isDateformat(fwEndDateLatest.val()) && !compareDate(fwStartDateLatest.val(), fwEndDateLatest.val()))
        {
            if(!error)
                fwStartDateLatest.focus();
            fwStartDateLatest.parent().parent().find("span").show();

            fwStartDateLatest.parent().parent().find("span").text("Project start date should be less than end date");
            error = true;
        }
        var projectEndDateLatest = $j("input[name=projectEndDateLatest]");
        if(isDateformat(projectEndDateLatest.val()) && isDateformat(fwEndDateLatest.val()) && !compareDate(fwEndDateLatest.val(), projectEndDateLatest.val()))
        {
            if(!error)
                projectEndDateLatest.focus();
            projectEndDateLatest.parent().parent().find("span").show();

            projectEndDateLatest.parent().parent().find("span").text("Project End (Results) date should be after the Fieldwork End Date");
            error = true;
        }

        /* Validation for fieldwork Start and End Dates check ends*/

        $j("#fieldwork-form-popup .numericfield").each(function(){
            $j(this).parent().find("span").each(function(spanIndex) {
                if($j(this).hasClass('numeric-error') && $j(this).is(":visible"))
                {
                    error = true;
                }
            });
        });
    </#if>

        var finalCost = $j("input[name=finalCost-display]");
        var finalCostVal = $j("input[name=finalCost-display]").val().replace(/\,/g, '');
        var finalCostVal_prev = "<#if projectSpecsEMDetails.finalCost??>${projectSpecsEMDetails.finalCost?c}<#else></#if>";

        if(finalCostVal!=finalCostVal_prev && !error)
        {
            if($j.trim(finalCostVal)=="")
            {
                if(!error)
                    finalCost.focus();
                error = true;
                finalCost.parent().find("span:first").show();
            }

            if(!error)
            {
                var finalCostCurrency = $j("#finalCostType");
                if(finalCostCurrency.val() < 0)
                {
                    error = true;
                    finalCostCurrency.focus();
                    finalCostCurrency.parent().find("p").show();
                }
            }
            if(!error)
            {
                var finalCostComments = $j("#finalCostComments");
                if(finalCostComments.val() != null && $j.trim(finalCostComments.val())=="")
                {
                    error = true;
                    finalCostComments.focus();
                    finalCostComments.next().show();
                }
            }
        }

        if(!error)
        {
            $j("input[name=finalCost]").val($j("input[name=finalCost-display]").val().replace(/\,/g, ''));
        }
        else
        {
            hideLoader();
        }

        if(error)
            return false;
    });

/** Load default hidden fields for User Picker selection **/
<#if projectSpecsInitiation.spiContact?? && projectSpecsInitiation.spiContact &gt; 0>
$j("input[name=spiContact]").val("${projectSpecsInitiation.spiContact?c}");
</#if>

    $j("#methodologyType").change(function(event) {

        var $methodologyType = $j("#methodologyType").val();
        if($methodologyType==4)
        {
            $j("#internation_management_cost_div").hide();
        }
        else
        {
            $j("#internation_management_cost_div").show();

        }


        if($methodologyType==1 || $methodologyType==3)
        {
            $j("#quantitative_div").show();
        }
        else
        {
            $j("#quantitative_div").hide();
        }

        if($methodologyType==2 || $methodologyType==3)
        {
            $j("#qualitative_div").show();

        }
        else
        {
            $j("#qualitative_div").hide();

        }
        if($methodologyType==1 || $methodologyType==3)
        {
            $j("#geographical_spread_div").show();
        }
        else
        {
            $j("#geographical_spread_div").hide();
        }
    });

    $j("#methodologyType").trigger("change");

});

/*Code to track read status of the document for current user and project */
<#assign effectiveUser = statics['com.grail.synchro.util.SynchroPermHelper'].getEffectiveUser() />

function validatePIBFormFields()
{
    showLoader('Please wait...');
    var error = false;

    /*Check of there is numeric field error before submitting*/
    $j(".numericfield").each(function(){
        if($j(this).parent().find("span").is(":visible"))
        {
            error = true;
        }
    });

    $j(".jive-error-box").hide();
    $j( ".jive-error-message" ).each(function( index ) {
        if(!$j(this).hasClass('numeric-error'))
        {
            $j(this).hide();
        }
    });

    /* This is done for keeping the values in dataCollectionMethod select box as selected*/
    $j('#dataCollectionMethod_${projSpecsEndMarketId} option').attr('selected', 'selected');


    var businessDescription = $j("textarea[name=bizQuestion]");
    var background = $j("textarea[name=background]");
    var bizSteps = $j("textarea[name=bizSteps]");
    var researchObjective = $j("textarea[name=researchObjective]");
    var actionStandard = $j("textarea[name=actionStandard]");
    var researchDesign = $j("textarea[name=researchDesign]");
    var otherComments = $j("textarea[name=otherComments]");
    var payArrangement = $j("textarea[name=payArrangement]");
    var stimulusError = $j("#stimulusError");
    var topDebriefLocation = $j("input[name=topDebriefLocation]");
    var fullDebriefLocation = $j("input[name=fullDebriefLocation]");
    var topReportLocation = $j("input[name=topReportLocation]");
    var fullreportLocation = $j("input[name=fullreportLocation]");
    var datatablesLocation = $j("input[name=datatablesLocation]");
    var reportingReqError = $j("#reportingReqError");

    var totalCost = $j("input[name=totalCost-display]");
    var totalCostType = $j("#totalCostType");

    var intMgmtCost = $j("input[name=intMgmtCost-display]");
    var intMgmtCostType = $j("#intMgmtCostType");
    var localMgmtCost = $j("input[name=localMgmtCost-display]");
    var localMgmtCostType = $j("#localMgmtCostType");
    var fieldworkCost = $j("input[name=fieldworkCost-display]");
    var fieldworkCostType = $j("#fieldworkCostType");

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

    /*  var proposedMethodology = $j("#proposedMethodology");
        if(proposedMethodology.val()==null || proposedMethodology.val()<0)
        {
            if(!error)
                proposedMethodology.focus();
            proposedMethodology.next().show();
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
    /*  if(totalCost.val() != null && $j.trim(totalCost.val())!="" && $j.trim(totalCost.val())=="0")
     {
         totalCost.parent().find("span:first").show();
         error = true;
     } */
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

    /*  if(intMgmtCost.val() != null && $j.trim(intMgmtCost.val())!="" && $j.trim(intMgmtCost.val())=="0")
     {
         intMgmtCost.parent().find("span:first").show();
         error = true;
     }*/

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

    /*   if(localMgmtCost.val() != null && $j.trim(localMgmtCost.val())!="" && $j.trim(localMgmtCost.val())=="0")
     {
         localMgmtCost.parent().find("span:first").show();
         error = true;
     } */

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

    /*  if(fieldworkCost.val() != null && $j.trim(fieldworkCost.val())!="" && $j.trim(fieldworkCost.val())=="0")
     {
         fieldworkCost.parent().find("span:first").show();
         error = true;
     }
     */
    /** Project stimuliDate date format check**/
    var stimuliDate = $j("input[name=stimuliDate]");
    if($j.trim(stimuliDate.val())!="" && !isDateformat(stimuliDate.val()))
    {
        stimuliDate.parent().find("span").show();
        stimuliDate.parent().find("span").text("Project start date should be in dd/mm/yyyy format");
        error = true;
    }

    /** Project start date and end date validations **/
    var startDate = $j("input[name=startDate]");
    if(startDate.val() != null && $j.trim(startDate.val())=="")
    {
        startDate.parent().find("span").show();
        error = true;
    }
    else if(!isDateformat(startDate.val()))
    {
        startDate.parent().find("span").show();
        startDate.parent().find("span").text("Project start date should be in dd/mm/yyyy format");
        error = true;
    }


    var endDate = $j("input[name=endDate]");
    if(endDate.val() != null && $j.trim(endDate.val())=="")
    {
        endDate.parent().find("span").show();
        error = true;
    }
    else if(!isDateformat(endDate.val()))
    {
        endDate.parent().find("span").show();
        endDate.parent().find("span").text("Project end date should be in dd/mm/yyyy format");
        error = true;
    }

    if(isDateformat(startDate.val()) && isDateformat(endDate.val()) && !compareDate(startDate.val(), endDate.val()))
    {
        startDate.parent().find("span").show();
        startDate.parent().find("span").text("Project start date should be less than end date");
        error = true;
    }

    /** Project FieldWork start date and end date validations **/
    var fwStartDate = $j("input[name=fwStartDate]");
    if($j.trim(fwStartDate.val())!="" && !isDateformat(fwStartDate.val()))
    {
        fwStartDate.parent().find("span").show();
        fwStartDate.parent().find("span").text("Project start date should be in dd/mm/yyyy format");
        error = true;
    }


    var  fwEndDate= $j("input[name=fwEndDate]");
    if($j.trim(fwEndDate.val())!="" && !isDateformat(fwEndDate.val()))
    {
        fwEndDate.parent().find("span").show();
        fwEndDate.parent().find("span").text("Project end date should be in dd/mm/yyyy format");
        error = true;
    }

    if(fwStartDate.val()!=null && $j.trim(fwStartDate.val())!="" && fwEndDate.val()!=null && $j.trim(fwEndDate.val())!="")
    {
        if(!compareDate(fwStartDate.val(), fwEndDate.val()))
        {
            fwStartDate.parent().find("span").show();
            fwStartDate.parent().find("span").text("Fieldwork start date should be less than end date");
            error = true;
        }
    }

    var endMarkets = new Array();
<#--	endMarkets = ${project.endMarkets}; -->
    var targetSegmentError = $j("#targetSegmentError");
    var smokerGroupError = $j("#smokerGroupError");
    var referenceBrandError = $j("#referenceBrandError");

    /* if(businessDescription.val() != null && $j.trim(businessDescription.val())=="")
    {
        error = true;
        businessDescription.next().show();
    }

    if(bizSteps.val() != null && $j.trim(bizSteps.val())=="")
    {
        error = true;
        bizSteps.next().show();
    }
    if(researchObjective.val() != null && $j.trim(researchObjective.val())=="")
    {
        error = true;
        researchObjective.next().show();
    }
    if(actionStandard.val() != null && $j.trim(actionStandard.val())=="")
    {
        error = true;
        actionStandard.next().show();
    }
    if(researchDesign.val() != null && $j.trim(researchDesign.val())=="")
    {
        error = true;
        researchDesign.next().show();
    }


    if((topDebriefLocation.val() != null && $j.trim(topDebriefLocation.val())=="") && (fullDebriefLocation.val() != null && $j.trim(fullDebriefLocation.val())=="") && (topReportLocation.val() != null && $j.trim(topReportLocation.val())=="") && (fullreportLocation.val() != null && $j.trim(fullreportLocation.val())=="") && (datatablesLocation.val() != null && $j.trim(datatablesLocation.val())==""))
    {
        error = true;
        reportingReqError.show();
    }*/

    if(!error)
    {
        $j("input[name=totalCost]").val($j("input[name=totalCost-display]").val().replace(/\,/g, ''));
        $j("input[name=intMgmtCost]").val($j("input[name=intMgmtCost-display]").val().replace(/\,/g, ''));
        $j("input[name=localMgmtCost]").val($j("input[name=localMgmtCost-display]").val().replace(/\,/g, ''));
        $j("input[name=fieldworkCost]").val($j("input[name=fieldworkCost-display]").val().replace(/\,/g, ''));

        $j("input[name=totalNoInterviews]").val($j("input[name=totalNoInterviews-display]").val().replace(/\,/g, ''));
        $j("input[name=totalNoOfVisits]").val($j("input[name=totalNoOfVisits-display]").val().replace(/\,/g, ''));
        $j("input[name=avIntDuration]").val($j("input[name=avIntDuration-display]").val().replace(/\,/g, ''));
        $j("input[name=totalNoOfGroups]").val($j("input[name=totalNoOfGroups-display]").val().replace(/\,/g, ''));
        $j("input[name=interviewDuration]").val($j("input[name=interviewDuration-display]").val().replace(/\,/g, ''));
        $j("input[name=noOfRespPerGroup]").val($j("input[name=noOfRespPerGroup-display]").val().replace(/\,/g, ''));
        
        <#if !isAdminUser>
	        $j('#proposedMethodology option').attr('selected', 'selected');
	        if($j('#proposedMethodology option').size()!=null && $j('#proposedMethodology option').size()==0)
	        {
	            var input = $j("<input>")
	                    .attr("type", "hidden")
	                    .attr("name", "proposedMethodology").val("-1");
	            console.log("apending "+$j(input).html());
	            $j('.research_pib').append($j(input));
	        }
	    </#if>
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
$j("#fwStartDate").click(function() {
    $j("#fwStartDate_button").click();
});
$j("#fwEndDate").click(function() {
    $j("#fwEndDate_button").click();
});

/*Brand ID - Name MAP*/
var brandFieldMap = {};
<#assign brandsMap = statics['com.grail.synchro.SynchroGlobal'].getBrands() />
<#list brandsMap.keySet() as brandMap>
brandFieldMap[${brandMap}] = "${brandsMap.get(brandMap)}";
</#list>


<#if projectSpecsInitiation?? && projectSpecsInitiation.categoryType?? && (projectSpecsInitiation.categoryType?size>0)>
	<#assign selectedCategoryObjList = projectSpecsInitiation.categoryType />
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

<#if projectSpecsInitiation?? && projectSpecsInitiation.proposedMethodology?? && (projectSpecsInitiation.proposedMethodology?size>0)>
	<#assign selectedProposedMethObjList = projectSpecsInitiation.proposedMethodology />
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
ProjectReadTracker.setReadTrackInfo(${projectID?c}, ${user.ID?c}, 3);

function showInitiateWaiverWindow()
{	
	initiateWaiverWindow.show();	
	initiateRTE('methodologyDeviationRationale', 2500);	
	initiateRTE('methodologyApproverComment', 2500);	
	
	<!-- Audit Logs-->
	<#if !(pibMethodologyWaiver?? && pibMethodologyWaiver.methodologyApprover??)>
		<#assign waiverBtnClickText><@s.text name="logger.project.waiver.btn.click" /></#assign>
		var projName = "${project.name?js_string}";
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].ADD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_SPECS.getId()}, "${waiverBtnClickText}", projName, ${projectID?c}, ${user.ID?c});
	</#if>
}

/* Initialization of Editor */
$j(document).ready(function () {
	initiateRTE('description', 1500);
	initiateRTE('bizQuestion', 900);
	initiateRTE('researchObjective', 900);
	initiateRTE('actionStandard', 900);
	initiateRTE('sampleProfile', 900);
	initiateRTE('stimulusMaterial', 900);
	initiateRTE('stimulusMaterialShipped', 900);
	initiateRTE('others', 900);
	initiateRTE('otherReportingRequirements', 900);
	initiateRTE('screener', 500);
	initiateRTE('consumerCCAgreement', 500);
	initiateRTE('questionnaire', 500);
	initiateRTE('discussionguide', 500);
	initiateRTE('researchDesign', 2500);
});

/* Function for date validations for Change Fieldwork/ Cost Status window */

function dateValidations()
{
	var error = false;
	var fwEndDateLatest = $j("input[name=fwEndDateLatest]");
	var fwStartDateLatest = $j("input[name=fwStartDateLatest]");
	<#if projectSpecsInitiation.methodologyType!=4 >
        if(fwEndDateLatest.val() != null && $j.trim(fwEndDateLatest.val())=="")
        {
            if(!error)
                fwEndDateLatest.focus();
            fwEndDateLatest.parent().parent().find("span").text("Please select fieldwork end date");
            fwEndDateLatest.parent().parent().find("span").show();
            error = true;
        }
        else if(!isDateformat(fwEndDateLatest.val()))
        {
            if(!error)
                fwEndDateLatest.focus();
            fwEndDateLatest.parent().parent().find("span").show();
            fwEndDateLatest.parent().parent().find("span").text("Project end date should be in dd/mm/yyyy format");
            error = true;
        }

        if(isDateformat(fwStartDateLatest.val()) && isDateformat(fwEndDateLatest.val()) && !compareDate(fwStartDateLatest.val(), fwEndDateLatest.val()))
        {
            if(!error)
                fwStartDateLatest.focus();
            fwStartDateLatest.parent().parent().find("span").show();

            fwStartDateLatest.parent().parent().find("span").text("Project start date should be less than end date");
            error = true;
        }
     </#if>   
        var projectEndDateLatest = $j("input[name=projectEndDateLatest]");
        if(isDateformat(projectEndDateLatest.val()) && isDateformat(fwEndDateLatest.val()) && !compareDate(fwEndDateLatest.val(), projectEndDateLatest.val()))
        {
            if(!error)
                projectEndDateLatest.focus();
            projectEndDateLatest.parent().parent().find("span").show();

            projectEndDateLatest.parent().parent().find("span").text("Project End (Results) date should be after the Fieldwork End Date");
            error = true;
        }
        
        
        return !error;
}
</script>

<script type="text/javascript">
<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.specs.view.text" /></#assign>	
	var projName = "${project.name?js_string}";
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_SPECS.getId()}, "${i18CustomText}", projName, ${projectID?c}, ${user.ID?c});
</script>