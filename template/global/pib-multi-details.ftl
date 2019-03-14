<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#-- DWR def -->
<head>
   <#-- <script type="text/javascript" src="<@s.url value='/dwr/engine.js' />"></script>
    <script type="text/javascript" src="<@s.url value='/dwr/interface/ProjectReadTracker.js' />"></script>
    <script type="text/javascript" src="<@s.url value='/dwr/interface/InviteUserUtil.js' />"></script>
    <script type="text/javascript" src="<@s.url value='/dwr/interface/FieldMappingUtil.js' />"></script>
    <script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>-->
</head>

<@resource.template file="/soy/userpicker/userpicker.soy" />
<!-- PIB Import Utility JS-->
<script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/commons.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/form-data-persist-handler.js?version=1" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/project-sticky-header.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.MultiFile.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ajaxfileupload.js'/>"></script>

<#assign defaultCurrency = statics['com.grail.synchro.util.SynchroUtils'].getDefaultCurrencyByProject(projectID) />

<#assign fieldCategoryId = ''/>
<!-- Setting locale to EN US for numeric formats -->
<#setting locale="en_US">

<script type="text/javascript">
var defaultCurrency = ${defaultCurrency?c};

$j(document).ready(function(){
    AUTO_SAVE.register({form:$j("#pib-form"), projectID:${projectID?c}});
    PROJECT_STAGE_NAVIGATOR.initialize({
    <#if projectID??>
        projectId:${projectID?c},
    </#if>
        activeStage:2
    });
    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#email-notification-form"), projectID:${projectID?c}});
    PROJECT_STICKY_HEADER.initialize();

});

function closeEmailNotification()
{
    $j("#emailNotification").trigger('close');
}
function closeAttachmentWindow()
{
    attachmentWindow.close();
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

function openInitiateWaiverWindow()
{
    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#waiver-form"), projectID:${projectID?c}});
    $j("#initiateWaiver").lightbox_me({centered:true,closeEsc:false,closeClick:false,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7}});
    initiateRTE('methodologyDeviationRationale', 2500, false);
    initiateRTE('methodologyApproverComment', 2500, false);
	<!-- Audit Logs -->
	<#if !(pibMethodologyWaiver?? && pibMethodologyWaiver.methodologyApprover??)>
		<#assign waiverBtnClickText><@s.text name="logger.project.waiver.btn.click" /></#assign>
		var projName = "${project.name?js_string}";
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].ADD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PIB.getId()}, "${waiverBtnClickText}", projName, ${projectID?c}, ${user.ID?c});
	</#if>
}
function closeWaiverWindow()
{
    $j("#initiateWaiver").hide();
    dialog({
        title:"Confirmation",
        html:"Are you sure you want to close with out saving details?",
        nonCloseActionButtons:['YES'],
        buttons:{
            "YES":function() {
                $j("#initiateWaiver").hide();
                $j("#initiateWaiver").trigger('close');
                closeDialog();
            },
            "NO": function() {
                $j("#initiateWaiver").show();
            }
        },
        closeActionButtonsClickHander:function() {
            $j("#initiateWaiver").show();
            closeDialog();
        }
    });
}

function openInitiateKantarWaiverWindow()
{
    $j("#initiateKantarWaiver").show();
}
function closeKantarWaiverWindow()
{
    $j("#initiateKantarWaiver").hide();
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

function setKantarMethodologyWaiverApprove()
{
    $j("#kantarMethodologyWaiverAction").val('Approve');

}
function setKantarMethodologyWaiverReject()
{
    $j("#kantarMethodologyWaiverAction").val('Reject');
}
function setKantarMethodologyWaiverSendforInfo()
{
    $j("#kantarMethodologyWaiverAction").val('Send for Information');

}
function setKantarMethodologyWaiverReqMoreInfo()
{
    $j("#kantarMethodologyWaiverAction").val('Request more Information');
}

function openMarketAmendmentWindow(marketAmendmentType)
{
    if(marketAmendmentType=="ActionStandard")
    {
        // FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"), form:$j("#as-form"), projectID:${projectID?c}});
        var ma = new LIGHT_BOX($j("#actionStandardMarketAmendmentWindow"),{title:'Market Amendments - Action Standard(s)'});
        ma.show();
        initiateRTE('actionStandard1', 900, true);

    }
    if(marketAmendmentType=="ResearchDesign")
    {
        //  FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"), form:$j("#rd-form"), projectID:${projectID?c}});
        var ma = new LIGHT_BOX($j("#resDesMarketAmendmentWindow"),{title:'Market Amendments - Methodology Approach and Research Design'});
        ma.show();
        initiateRTE('researchDesign1', 900, true);
    }
    if(marketAmendmentType=="SampleProfile")
    {
        // FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"), form:$j("#sp-form"), projectID:${projectID?c}});
        var ma = new LIGHT_BOX($j("#sampleProfileMarketAmendmentWindow"),{title:'Market Amendments - Sample Profile (Research)'});
        ma.show();
        initiateRTE('sampleProfile1', 900, true);
    }
    if(marketAmendmentType=="StimulusMaterial")
    {
        //   FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"), form:$j("#sm-form"), projectID:${projectID?c}});
        var ma = new LIGHT_BOX($j("#stimulusMaterialMarketAmendmentWindow"),{title:'Market Amendments - Stimulus Material'});
        ma.show();
        initiateRTE('stimulusMaterial1', 900, true);
    }
}

function openAddChangeCountryWindow()
{
    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"), form:$j("#update-end-markets-form"), projectID:${projectID?c}});
    var ma = new LIGHT_BOX($j("#addChangeCountryWindow"),{title:'Add/Change Countries'});
    ma.show();
}
function openViewCostApprovalsWindow()
{
    var ma = new LIGHT_BOX($j("#viewCostApprovalsWindow"),{title:'View Cost Approvals'});
    ma.show();
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
    location.href="/synchro/pib-multi-details!removeAttachment.jspa?projectID=${projectID?c}&endMarketId=${endMarketId?c}&attachmentId="+attachmentId+"&attachmentFieldID="+fieldID+"&attachmentName="+attachmentName;
    /* $j.ajax({
   url: "<@s.url value='/synchro/pib-multi-details!removeAttachment.jspa'/>",
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


<#assign bussinessQuestionID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].BUSINESS_QUESTION.getId()/>
<#assign researchObjectiveID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].RESEARCH_OBJECTIVE.getId()/>
<#assign actionStandardID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].ACTION_STANDARD.getId()/>
<#assign researchDesignID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].RESEARCH_DESIGN.getId()/>
<#assign sampleProfileID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].SAMPLE_PROFILE.getId()/>
<#assign stimulusMaterialID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].STIMULUS_MATERIAL.getId()/>
<#assign otherReportingRequirementID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].OTHER_REPORTING_REQUIREMENT.getId()/>
<#assign othersID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].OTHERS.getId()/>

<!-- Page container -->
<div class="container">
<div class="project_names">
<div class="project_name_div">
<h2>PIB <label style="font-size: 12px;">(<span class="red">*</span>Indicates the mandatory details needed to complete the stage)</label></h2>
<h2>${project.name?html} (${generateProjectCode('${projectID?c}')}) </h2>
<div class="print-btn">
    <input type="button" value="PRINT" class="j-btn-callout">
</div>
<div id="jive-error-box" class="jive-error-box warning" <#if showMandatoryFieldsError?? && showMandatoryFieldsError>style="display:block;"<#else>style="display:none"</#if>>
    <div>
        <span><@s.text name="project.mandatory.error"/></span>
    </div>
</div>

<#assign isExternalAgencyUser = statics['com.grail.synchro.util.SynchroPermHelper'].isExternalAgencyUser(projectID,statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID) />
<#assign isCommAgencyUser = statics['com.grail.synchro.util.SynchroPermHelper'].isCommunicationAgencyUser(projectID,statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID) />
<#assign isProjectOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectOwner(projectID) />

<#assign isSPIContactUser = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectOwner(projectID) />

<#assign isMethAppUser = statics['com.grail.synchro.util.SynchroPermHelper'].isMethodologyApproverUser() />
<#assign isKantarMethAppUser = statics['com.grail.synchro.util.SynchroPermHelper'].isKantarMethodologyApproverUser() />
<#assign isLegalUser = statics['com.grail.synchro.util.SynchroPermHelper'].isLegalUser(projectID,statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID) />
<#assign isProcUser = statics['com.grail.synchro.util.SynchroPermHelper'].isProcurementUser(projectID,statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID) />
<#assign isProductUser = statics['com.grail.synchro.util.SynchroPermHelper'].isProductUser(projectID,statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID) />
<#assign isGlobalProjectContactUser = statics['com.grail.synchro.util.SynchroPermHelper'].isGlobalProjectContactUser(projectID) />
<#assign isProjectCreator = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectCreator(projectID) />
<#assign isCommunicationAgencyAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroCommunicationAgencyAdmin() />

<#assign canEditProject = statics['com.grail.synchro.util.SynchroPermHelper'].canEditProjectByStatus(projectID) />
<#assign endMarketId = endMarketId />

<#assign isCountryProjectContact = statics['com.grail.synchro.util.SynchroPermHelper'].isCountryProjectContact(projectID,endMarketId) />
<#assign isCountrySPIContact = statics['com.grail.synchro.util.SynchroPermHelper'].isCountrySPIContact(projectID,endMarketId) />
<#assign isAboveMarketProjectContactUser = statics['com.grail.synchro.util.SynchroPermHelper'].isAboveMarketProjectContact(projectID) />
<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
<#assign isGlobalSuperUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroGlobalSuperUser(user) />
<#--
<#assign isRegionalSuperUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroRegionalSuperUser(user) />
<#assign isAreaSuperUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAreaSuperUser(user) />
-->
<#assign isEndMarketSuperUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroEndmarketSuperUser(user,endMarketId) />

<div class="main-sub-menus-div endmarket-menus">
    <ul class="main-sub-menus">
        <li><a href="/synchro/pib-multi-details!input.jspa?projectID=${projectID?c}" <#if (!endMarketId?exists) || (endMarketId &lt;= 0)>class="active"</#if>>Above Market</a></li>
    <#list endMarketDetails as emd>
        <#if !statics['com.grail.synchro.util.SynchroPermHelper'].isMarketDeleted(projectID, emd.getEndMarketID()) >
            <li><a href="/synchro/pib-multi-details!input.jspa?projectID=${projectID?c}&endMarketId=${emd.getEndMarketID()}" <#if endMarketId?exists && endMarketId == emd.getEndMarketID()>class="active"</#if>>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emd.getEndMarketID()?int)}</a></li>
        </#if>
    </#list>
    </ul>
</div>

<!-- Project Contact access to PIB check based on role hierarchies -->
<#assign projectContactHasReadonlyAccessToPIB = statics['com.grail.synchro.util.SynchroPermHelper'].hasReadonlyAccessToPIBMultiMarket(projectID) />

<#if project.projectOwner &gt; 0>

    <#assign ownerUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner) />
	<input type="hidden" name="projectOwnerOri" value="${project.projectOwner?c}">

<#else>
    <#assign ownerUserName="" />
</#if>

<#assign PIBReadonly = false />

<#--<#if (isExternalAgencyUser || isCommAgencyUser || isLegalUser || isProcUser || isCommunicationAgencyAdminUser ) >-->
<#if !(isAdminUser) && (isCommAgencyUser || isLegalUser || isProcUser || isCommunicationAgencyAdminUser ) >

    <#assign PIBReadonly = true />
    <#include "/template/global/pib-multi-details-readonly.ftl" />
<#elseif !canEditEM>

    <#assign PIBReadonly = true />
    <#include "/template/global/pib-multi-details-readonly.ftl" />
<#elseif projectContactHasReadonlyAccessToPIB && !isExternalAgencyUser>

    <#assign PIBReadonly = true />
    <#include "/template/global/pib-multi-details-readonly.ftl" />
<#elseif !(isAboveMarketProjectContactUser || isProjectOwner || isCountryProjectContact || isCountrySPIContact || isAdminUser || isExternalAgencyUser) >

    <#assign PIBReadonly = true />
    <#include "/template/global/pib-multi-details-readonly.ftl" />
<#elseif !(isAboveMarket) && !(isCountryProjectContact || isCountrySPIContact || isAdminUser || isProjectOwner) >
    <#assign PIBReadonly = true />
    <#include "/template/global/pib-multi-details-readonly.ftl" />
<#else>
<form name="pib" action="/synchro/pib-multi-details!execute.jspa" method="POST"  name="form-create" id="pib-form" class="research_pib pib" >

<div class="research_content">
<input type="hidden" name="projectID" value="${projectID?c}">
<input type="hidden" name="endMarketId" value="${endMarketId?c}">
<input type="hidden" name="pitUpdateOnly" id="pitUpdateOnly" value="false">
<#if project.projectOwner &gt; 0>
	<input type="hidden" name="projectOwnerOri" value="${project.projectOwner?c}">
</#if>

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
    <#if isAboveMarket>
        <@renderBrandField name='brand' value=project.brand?default('-1')/>

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

    <@renderMultiEndMarketField name='updatedSingleMarketId1' value=emIds?default('-1')/>

    <#if isAboveMarket>
        <a href="javascript:void(0);" onclick="javascript:openAddChangeCountryWindow()" class="pib-multi-country">Add/Change Country</a>
    </#if>
    <#assign error_msg><@s.text name='project.error.endmarket' /></#assign>
    <@macroCustomFieldErrors msg=error_msg />
</div>

<div class="project_owner_names">


    <#if isAboveMarket>
        <label>SP&I Contact</label>
        <input type="text" tabindex="1" name="projectOwner" id="projectOwner" value="${ownerUserName}" class="j-user-autocomplete j-ui-elem resize" srole="20" autocomplete="off" />
    <#else>
        <label>Project Owner</label>
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

    <#assign aboveMarketProjectContactEmail = "" />
    <#assign displayNotifySPI = false>

    <#if isAboveMarket>
        <#list fundingInvestments as fundingInvestment>
            <#if fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].GlOBAL.getId()>
                <#assign globalProjectContact = fundingInvestment.projectContact />
            <#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].REGION.getId()>
                <#assign regionalProjectContact = fundingInvestment.projectContact />
            <#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].AREA.getId()>
                <#assign areaProjectContact = fundingInvestment.projectContact />
            <#--<#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].COUNTRY.getId()>
                       <#assign countryProjectContact = fundingInvestment.projectContact />-->
            </#if>
        </#list>

        <#if globalProjectContact &gt; 0>
            <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(globalProjectContact) />
            <#assign aboveMarketProjectContactEmail = statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(globalProjectContact) />
            <#if user.ID == globalProjectContact>
                <#assign displayNotifySPI = true>
            </#if>
        <#elseif regionalProjectContact &gt; 0>
            <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(regionalProjectContact) />
            <#assign aboveMarketProjectContactEmail = statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(regionalProjectContact) />
            <#if user.ID == regionalProjectContact>
                <#assign displayNotifySPI = true>
            </#if>
        <#elseif areaProjectContact &gt; 0>
            <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(areaProjectContact) />
            <#assign aboveMarketProjectContactEmail = statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(areaProjectContact) />
            <#if user.ID == areaProjectContact>
                <#assign displayNotifySPI = true>
            </#if>
        <#--<#elseif countryProjectContact &gt; 0>
                 <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(countryProjectContact) />
                 <#assign aboveMarketProjectContactEmail = statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(countryProjectContact) />-->
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


<#--
<div class="pib-select_div">
    <label><@s.text name="project.initiate.project.methodologyproposed"/></label>
    <#assign defaultPMethodologyID = JiveGlobals.getJiveIntProperty("grail.synchro.default.proposedmethodology", -1) />
    <#if project.proposedMethodology?? && project.proposedMethodology[0]??>
        <#assign defaultPMethodologyID = project.proposedMethodology[0] />
    </#if>
    <#if isAboveMarket>
        <@renderProposedMethodologyGroupField name='proposedMethodology' value=defaultPMethodologyID /> .
        <#assign error_msg><@s.text name='project.error.proposedmethodologygroup' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
    <#else>
        <@renderProposedMethodologyGroupField name='proposedMethodology' value=defaultPMethodologyID readonly=true/>
        <#assign error_msg><@s.text name='project.error.proposedmethodologygroup' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
    </#if>

</div>
-->
<div>
    <div class="form-date_div">
        <label>Estimated Project Start</label>
        <#if isAboveMarket>
           <#-- <@jiveform.datetimepicker id="startDate" name="startDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/> -->
			<@synchrodatetimepicker id="startDate" name="startDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
            <#assign error_msg><@s.text name='project.error.startdate' /></#assign>
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
            <#--<@jiveform.datetimepicker id="endDate" name="endDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
			<@synchrodatetimepicker id="endDate" name="endDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
            <#assign error_msg><@s.text name='project.error.enddate' /></#assign>
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

        <@renderAllSelectedCategoryTypeField name='categoryTypeSelected' value=project.categoryType?default(-1) />
        <#assign error_msg><@s.text name='project.error.category' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
    </div>


    <div class="form-select_div">
        <label><@s.text name="project.initiate.project.methodology"/></label>
        <#if isAboveMarket>
            <@renderMethodologyField name='methodologyType' value=project.methodologyType?default('-1') readonly=true/>
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
            <@renderMethodologyGroupField name='methodologyGroup' value=project.methodologyGroup?default('-1')/>
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

        <#if isAboveMarketProjectContactUser || isProjectOwner || isAdminUser  || isProjectCreator || isGlobalSuperUser>
            <div class="form-text_div pib_initial_cost">
                <label>Total Cost</label>
                <input type="text" name="name" value="${project.totalCost?default('')}" size="30" class="form-text-div numericfieldpib numericformat longField" disabled="true">
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
                    <input type="text" name="latestEstimate-display" autocomplete="off" title="The latest estimate is copied by default from the Total Cost and should be changed, if required." onchange="latestEstimateChange()"

                        <#if projectInitiation.latestEstimate?? > value="${projectInitiation.latestEstimate}" <#else> value="" </#if> size="30" class="form-text-div numericfieldpib numericformat longField" >
                    <@renderCurrenciesField name='latestEstimateType' value=projectInitiation.latestEstimateType?default(defaultCurrency) disabled=false/>
                    <@macroCurrencySelectError msg="Please select currency" />
                    <@macroCustomFieldErrors msg='Please enter latest estimate' />
                    <@macroCustomFieldErrors msg="Please enter numeric value" class='numeric-error'/>
                    <input type="hidden" name="latestEstimate" <#if projectInitiation.latestEstimate?? > value="${projectInitiation.latestEstimate?c}" <#else> value="" </#if> >

                </div>
            </#if>
		<#elseif !PIBReadonly>
			<a href="javascript:void(0);" onclick="javascript:openViewCostApprovalsWindow()" class="pib-multi-country pib-multi-cost">View Cost Approvals</a>
        </#if>
    </#if>

    <#if !(isExternalAgencyUser || synchroPermHelper.isExternalAgencyUser(user) || isCommAgencyUser || synchroPermHelper.isCommunicationAgencyUser(user)) >
        <!-- SVN-18822 Fieldwork has Tendering Process Field-->
        <div class="form-select_div">
            <label>Fieldwork has Tendering Process</label>
            <select name="hasTenderingProcess" id="hasTenderingProcess" class="form-select" onchange="toggleFieldworkCostField()">
                <option value="1" <#if projectInitiation.hasTenderingProcess?? && projectInitiation.hasTenderingProcess==1>selected="selected"</#if>>Yes</option>
                <option value="0" <#if !projectInitiation.hasTenderingProcess?? || (projectInitiation.hasTenderingProcess?? && projectInitiation.hasTenderingProcess==0)>selected="selected"</#if>>No</option>
            </select>
            <#assign error_msg>Please select fieldwork has tendering process</#assign>
            <@macroCustomFieldErrors msg=error_msg />
        </div>

        <!-- SVN-18822 Fieldwork Cost Field-->
        <div class="form-text_div pib_initial_cost" id="pib-fieldworkcost-field" <#if projectInitiation.hasTenderingProcess?? && projectInitiation.hasTenderingProcess==1>style="display:block;"<#else>style="display:none;"</#if> >
            <label class="synchro-help-label" title="Please enter the final cost from the winning bid resulting from any fieldwork tender process.">Fieldwork Cost<span class="synchro-help-icon" title="Please enter the final cost from the winning bid resulting from any fieldwork tender process.">help</span></label>

            <input type="text" name="fieldworkCost-display" onchange="javascript:fieldworkCostChange();" <#if projectInitiation.fieldworkCost?? > value="${projectInitiation.fieldworkCost}" <#else> value="" </#if> size="30" class="form-text-div numericfieldpib numericformat longField">
            <@renderCurrenciesField name='fieldworkCostCurrency' value=projectInitiation.fieldworkCostCurrency?default(defaultCurrency) disabled=false/>
            <@macroCustomFieldErrors msg='' class='numeric-error' />
            <input type="hidden" name="fieldworkCost" <#if projectInitiation.fieldworkCost?? > value="${projectInitiation.fieldworkCost?c}" <#else> value="" </#if> >
            <script type="text/javascript">
                function toggleFieldworkCostField()
                {
                    if($j("#hasTenderingProcess").val()=="0")
                    {
                        $j("#pib-fieldworkcost-field").hide();
                    }
                    else
                    {
                        $j("#pib-fieldworkcost-field").show();
                    }
                }
                function fieldworkCostChange() {
                    var val = Number($j("input[name=fieldworkCost-display]").val().replace(/\,/g,''));
                    if(val>=0) {
                        $j("input[name=fieldworkCost]").val(val);
                    } else {
                        $j("input[name=fieldworkCost]").val("");
                    }
                }
            </script>
        </div>
    </#if>

    <div class="form-text_div npi-number">
        <label>NPI Number <br/> (if appropriate)</label>
        <input type="text" name="npiReferenceNo" autocomplete="off" value="${projectInitiation.npiReferenceNo?default('')?html}" size="30" class="form-text-div numericfieldpib nonformatfield" >
        <@macroCustomFieldErrors msg='' class='numeric-error' />
    </div>


    <div class="form-select_div select-div">
        <label>CAP Rating</label>
        <@renderCAPRatingField name='capRating' value=project.capRating?default(-1) readonly=false/>
    </div>
    <div class="form-select_div select-div">
        <label>Request for Methodology Waiver</label>
        <#if isAboveMarket>
            <select name="deviationFromSM" id="deviationFromSM" class="form-select" onchange="checkMethDeviation()">
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
             <#--   var initiateWaiverWindow = null;
                $j(document).ready(function(){
                    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#waiver-form"), projectID:${projectID?c}});
                    initiateWaiverWindow = new LIGHT_BOX($j("#initiateWaiver"),{title:'Request for Methodology Waiver',confirmOnClose:true});
                });

			-->
            </script>
            <#assign showWaiverBtn = 'none' />
            <#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==1>
                <#assign showWaiverBtn = 'block' />
            </#if>
            <#if isAboveMarket>
                <ul class="right-sidebar-list">
                    <li id="initiateWaiverButton" style='display:${showWaiverBtn?string}'><a onclick="javascript:openInitiateWaiverWindow();" href="javascript:void(0);"><#if pibMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Initiate a Waiver</#if></a></li>
                </ul>
            </#if>
        </#if>
    </div>
    <#if projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==1 && pibMethodologyWaiver?? && pibMethodologyWaiver.projectID??>
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
            <textarea id="description" name="description" rows="10" cols="20" class="form-text-div">${project.description?default('')?html}</textarea>
            <@macroCustomFieldErrors msg="Please enter the Project description" class='textarea-error-message'/>
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
            parentForm:$j("#pib-form"),
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


        $j("#endMarketIdAS").change(function(event) {

            var val = $j('#endMarketIdAS option:selected').val();
            console.log(val)
            if($j("#actionStandard-"+val).html()) {
                if(tinymce && tinymce.get('actionStandard1')) {
                    tinymce.get('actionStandard1').setContent($j("#actionStandard-"+val).html());
                } else {
                    $j("#actionStandard1").val($j("#actionStandard-"+val).html());
                }
            } else {
                if(tinymce && tinymce.get('actionStandard1')) {
                    tinymce.get('actionStandard1').setContent("");
                } else {
                    $j("#actionStandard1").val("");
                }

            }

        });
        $j("#endMarketIdAS").trigger("change");

        $j("#endMarketIdRD").change(function(event) {
            var val = $j('#endMarketIdRD option:selected').val();
            if($j("#researchDesign-"+val).html()) {
                if(tinymce && tinymce.get('researchDesign1')) {
                    tinymce.get('researchDesign1').setContent($j("#researchDesign-"+val).html());
                } else {
                    $j("#researchDesign1").val($j("#researchDesign-"+val).html());
                }
            } else {
                if(tinymce && tinymce.get('researchDesign1')) {
                    tinymce.get('researchDesign1').setContent("");
                } else {
                    $j("#researchDesign1").val("");
                }
            }
        });
        $j("#endMarketIdRD").trigger("change");

        $j("#endMarketIdSP").change(function(event) {
            var val = $j('#endMarketIdSP option:selected').val();
            if($j("#sampleProfile-"+val).html()) {
                if(tinymce && tinymce.get('sampleProfile1')) {
                    tinymce.get('sampleProfile1').setContent($j("#sampleProfile-"+val).html());
                } else {
                    $j("#sampleProfile1").val($j("#sampleProfile-"+val).html());
                }
                //$j("#sampleProfile1").val($j("#sampleProfile-"+val).html())
            } else {
                if(tinymce && tinymce.get('sampleProfile1')) {
                    tinymce.get('sampleProfile1').setContent("");
                } else {
                    $j("#sampleProfile1").val("");
                }
                //$j("#sampleProfile1").val("");
            }
            //  $j("#sampleProfile1").val(sp);
        });
        $j("#endMarketIdSP").trigger("change");

        $j("#endMarketIdSM").change(function(event) {
            var val = $j('#endMarketIdSM option:selected').val();
            if($j("#stimulusMaterial-"+val).html()) {
                if(tinymce && tinymce.get('stimulusMaterial1')) {
                    tinymce.get('stimulusMaterial1').setContent($j("#stimulusMaterial-"+val).html());
                } else {
                    $j("#stimulusMaterial1").val($j("#stimulusMaterial-"+val).html());
                }
            } else {
                if(tinymce && tinymce.get('stimulusMaterial1')) {
                    tinymce.get('stimulusMaterial1').setContent("");
                } else {
                    $j("#stimulusMaterial1").val("");
                }
            }
            //$j("#stimulusMaterial1").val(sm);
        });
        $j("#endMarketIdSM").trigger("change");

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
            <textarea id="bizQuestion" name="bizQuestion" rows="10" cols="20" class="form-text-div">${projectInitiation.bizQuestion?default('')?html}</textarea>
            <@macroCustomFieldErrors msg="Please enter Business Question" class='textarea-error-message'/>
        <#else>
            <textarea id="bizQuestion" name="bizQuestion" rows="10" cols="20" class="form-text-div" disabled>${projectInitiation.bizQuestion?default('')?html}</textarea>
        </#if>
    </div>
    <textarea style="display:none;" id="bizQuestionText" name="bizQuestionText">${projectInitiation.bizQuestionText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
        <#if isAboveMarket>
            <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${bussinessQuestionID?c})" ></span>
        </#if>
        <#if attachmentMap?? && attachmentMap.get(bussinessQuestionID)?? >
            <div id="jive-file-list" class="jive-attachments">
                <#list attachmentMap.get(bussinessQuestionID) as attachment>
                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                        <span class="jive-icon-med jive-icon-attachment"></span>

                        <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                            <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${bussinessQuestionID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
            <textarea id="researchObjective" name="researchObjective" rows="10" cols="20" class="form-text-div">${projectInitiation.researchObjective?default('')?html}</textarea>
            <@macroCustomFieldErrors msg="Please enter Research Objectives(s)" class='textarea-error-message'/>
        <#else>
            <textarea id="researchObjective" name="researchObjective" rows="10" cols="20" class="form-text-div" disabled>${projectInitiation.researchObjective?default('')?html}</textarea>
        </#if>
    </div>

    <textarea style="display:none;" id="researchObjectiveText" name="researchObjectiveText">${projectInitiation.researchObjectiveText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
        <#if isAboveMarket>
            <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${researchObjectiveID?c})" ></span>
        </#if>
        <#if attachmentMap?? && attachmentMap.get(researchObjectiveID)?? >
            <div id="jive-file-list" class="jive-attachments">
                <#list attachmentMap.get(researchObjectiveID) as attachment>
                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                        <span class="jive-icon-med jive-icon-attachment"></span>
                        <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                            <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${researchObjectiveID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
    <label class='rte-editor-label'>Action Standard(s)
        <#if isAboveMarket>
            <a href="javascript:void(0);" onclick="javascript:openMarketAmendmentWindow('ActionStandard')">Market Amendments</a>
        </#if></label>
    <div class="form-text_div">
        <textarea id="actionStandard" name="actionStandard" rows="10" cols="20" class="form-text-div">${projectInitiation.actionStandard?default('')?html}</textarea>
        <@macroCustomFieldErrors msg="Please enter Action Standard(s)" class='textarea-error-message'/>
    </div>
    <textarea style="display:none;" id="actionStandardText" name="actionStandardText">${projectInitiation.actionStandardText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
        <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${actionStandardID?c})" ></span>
        <#if attachmentMap?? && attachmentMap.get(actionStandardID)?? >
            <div id="jive-file-list" class="jive-attachments">
                <#list attachmentMap.get(actionStandardID) as attachment>
                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                        <span class="jive-icon-med jive-icon-attachment"></span>

                        <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                            <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${actionStandardID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
    <label class='rte-editor-label'>Methodology Approach and Research Design <#if isAboveMarket>
        <a href="javascript:void(0);" onclick="javascript:openMarketAmendmentWindow('ResearchDesign')">Market Amendments</a>
    </#if>
    </label>
    <div class="form-text_div">
        <textarea id="researchDesign" name="researchDesign" rows="10" cols="20" class="form-text-div form-text-div-large">${projectInitiation.researchDesign?default('')?html}</textarea>
        <@macroCustomFieldErrors msg="Please enter Methodology Approach and Research Design" class='textarea-error-message'/>
    </div>

    <textarea style="display:none;" id="researchDesignText" name="researchDesignText">${projectInitiation.researchDesignText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
        <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${researchDesignID?c})" ></span>
        <#if attachmentMap?? && attachmentMap.get(researchDesignID)?? >
            <div id="jive-file-list" class="jive-attachments">
                <#list attachmentMap.get(researchDesignID) as attachment>
                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                        <span class="jive-icon-med jive-icon-attachment"></span>
                        <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                            <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${researchDesignID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
    <label class='rte-editor-label'>Sample Profile (Research)
        <#if isAboveMarket>
            <a href="javascript:void(0);" onclick="javascript:openMarketAmendmentWindow('SampleProfile')">Market Amendments</a>
        </#if>
    </label>
    <div class="form-text_div">
        <textarea id="sampleProfile" name="sampleProfile" rows="10" cols="20" class="form-text-div">${projectInitiation.sampleProfile?default('')?html}</textarea>
        <@macroCustomFieldErrors msg="Please enter Sample Profile (Research)" class='textarea-error-message'/>
    </div>
    <textarea style="display:none;" id="sampleProfileText" name="sampleProfileText">${projectInitiation.sampleProfileText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
        <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${sampleProfileID?c})" ></span>
        <#if attachmentMap?? && attachmentMap.get(sampleProfileID)?? >
            <div id="jive-file-list" class="jive-attachments">
                <#list attachmentMap.get(sampleProfileID) as attachment>
                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                        <span class="jive-icon-med jive-icon-attachment"></span>
                        <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                            <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${sampleProfileID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
        <#if isAboveMarket>
            <a href="javascript:void(0);" onclick="javascript:openMarketAmendmentWindow('StimulusMaterial')">Market Amendments</a>
        </#if>

    </label>
    <div class="form-text_div">
        <textarea id="stimulusMaterial" name="stimulusMaterial" rows="10" cols="20" class="form-text-div">${projectInitiation.stimulusMaterial?default('')?html}</textarea>
        <@macroCustomFieldErrors msg="Please enter Stimulus Material" class='textarea-error-message'/>
    </div>
    <textarea style="display:none;" id="stimulusMaterialText" name="stimulusMaterialText">${projectInitiation.stimulusMaterialText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
        <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${stimulusMaterialID?c})" ></span>
        <#if attachmentMap?? && attachmentMap.get(stimulusMaterialID)?? >
            <div id="jive-file-list" class="jive-attachments">
                <#list attachmentMap.get(stimulusMaterialID) as attachment>
                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                        <span class="jive-icon-med jive-icon-attachment"></span>
                        <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                            <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${stimulusMaterialID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
        <textarea id="others" name="others" rows="10" cols="20" class="form-text-div">${projectInitiation.others?default('')?html}</textarea>
        <@macroCustomFieldErrors msg="Please enter Other Comments" class='textarea-error-message'/>
    </div>
    <textarea style="display:none;" id="othersText" name="othersText">${projectInitiation.othersText?default('')?html}</textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
        <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${othersID?c})" ></span>
        <#if attachmentMap?? && attachmentMap.get(othersID)?? >
            <div id="jive-file-list" class="jive-attachments">
                <#list attachmentMap.get(othersID) as attachment>
                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                        <span class="jive-icon-med jive-icon-attachment"></span>
                        <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                            <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${othersID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
        <@macroCustomFieldErrors msg="Please enter date in correct format"/>

    </div>
</div>


<div class="pib-report-requirement">
    <label>Reporting Requirement</label>
    <table class="report_requirement_list">
        <tbody>
            <#if pibReporting?? >

            <tr>

                <td><@renderReportingCheckBox label='' name='topLinePresentation' isChecked=pibReporting.topLinePresentation?default(false)/></td>
                <td class="view-row-first">Full Report – Global Presentation</td>
            </tr>
            <tr class="color-row">
                <td><@renderReportingCheckBox label='' name='presentation' isChecked=pibReporting.presentation?default(false)/></td>
                <td class="view-row-first">Full Report – EM Presentation</td>
            </tr>
            <tr>
                <td><@renderReportingCheckBox label='' name='fullreport' isChecked=pibReporting.fullreport?default(false)/></td>
                <td class="view-row-first">Summary Report</td>
            </tr>
            <tr>
                <td><@renderReportingCheckBox label='' name='globalSummary' isChecked=pibReporting.globalSummary?default(false)/></td>
                <td class="view-row-first">Summary for IRIS</td>
            </tr>
            <#else>
            <tr>

                <td><@renderReportingCheckBox label='' name='topLinePresentation' isChecked=false/></td>
                <td class="view-row-first">Full Report – Global Presentation</td>
            </tr>
            <tr class="color-row">
                <td><@renderReportingCheckBox label='' name='presentation' isChecked=false/></td>
                <td class="view-row-first">Full Report – EM Presentation</td>
            </tr>
            <tr>
                <td><@renderReportingCheckBox label='' name='fullreport' isChecked=false/></td>
                <td class="view-row-first">Summary Report</td>
            </tr>
            <tr>
                <td><@renderReportingCheckBox label='' name='fullreport' isChecked=false/></td>
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
        <textarea id="otherReportingRequirements" name="otherReportingRequirements" rows="10" cols="20" class="form-text-div"><#if pibReporting?? >${pibReporting.otherReportingRequirements?default('')?html}</#if></textarea>
        <@macroCustomFieldErrors msg="Please enter Other Reporting Requirements" class='textarea-error-message'/>
    </div>
    <textarea style="display:none;" id="otherReportingRequirementsText" name="otherReportingRequirementsText"><#if pibReporting?? >${pibReporting.otherReportingRequirementsText?default('')?html}</#if></textarea>
    <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
        <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${otherReportingRequirementID?c})" ></span>
        <#if attachmentMap?? && attachmentMap.get(otherReportingRequirementID)?? >
            <div id="jive-file-list" class="jive-attachments">
                <#list attachmentMap.get(otherReportingRequirementID) as attachment>
                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                        <span class="jive-icon-med jive-icon-attachment"></span>
                        <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                            <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${otherReportingRequirementID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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

    <#if pibStakeholderList?? &&  pibStakeholderList.agencyContact1Optional?? && pibStakeholderList.agencyContact1Optional &gt; 0>
        <#assign agency1OptionalUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact1Optional) />
    <#elseif pibAboveMarketStakeholderList?? && pibAboveMarketStakeholderList.agencyContact1Optional?? && pibAboveMarketStakeholderList.agencyContact1Optional &gt; 0>
        <#assign agency1OptionalUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibAboveMarketStakeholderList.agencyContact1Optional) />
    <#else>
        <#assign agency1OptionalUserName="" />
    </#if>


    <#if pibStakeholderList?? &&  pibStakeholderList.agencyContact2Optional?? && pibStakeholderList.agencyContact2Optional &gt; 0>
        <#assign agency2OptionalUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact2Optional) />
    <#elseif pibAboveMarketStakeholderList?? && pibAboveMarketStakeholderList.agencyContact2Optional?? && pibAboveMarketStakeholderList.agencyContact2Optional &gt; 0>
        <#assign agency2OptionalUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibAboveMarketStakeholderList.agencyContact2Optional) />
    <#else>
        <#assign agency2OptionalUserName="" />
    </#if>


    <#if pibStakeholderList?? &&  pibStakeholderList.agencyContact3Optional?? && pibStakeholderList.agencyContact3Optional &gt; 0>
        <#assign agency3OptionalUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact3Optional) />
    <#elseif pibAboveMarketStakeholderList?? && pibAboveMarketStakeholderList.agencyContact3Optional?? && pibAboveMarketStakeholderList.agencyContact3Optional &gt; 0>
        <#assign agency3OptionalUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibAboveMarketStakeholderList.agencyContact3Optional) />
    <#else>
        <#assign agency3OptionalUserName="" />
    </#if>

    <#if pibStakeholderList?? &&  pibStakeholderList.globalLegalContact?? && pibStakeholderList.globalLegalContact &gt; 0>
        <#assign globalLegalContactUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.globalLegalContact) />
		<input type="hidden" name="globalLegalContactOri" value="${pibStakeholderList.globalLegalContact?c}">
    <#else>
        <#assign globalLegalContactUserName="" />
    </#if>

    <#if pibStakeholderList?? &&  pibStakeholderList.globalProcurementContact?? && pibStakeholderList.globalProcurementContact &gt; 0>
        <#assign globalProcurementContactUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.globalProcurementContact) />
		<input type="hidden" name="globalProcurementContactOri" value="${pibStakeholderList.globalProcurementContact?c}">
    <#else>
        <#assign globalProcurementContactUserName="" />
    </#if>


    <#if pibStakeholderList?? &&  pibStakeholderList.productContact?? && pibStakeholderList.productContact &gt; 0>
        <#assign productContactUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.productContact) />
		<input type="hidden" name="productContactOri" value="${pibStakeholderList.productContact?c}">
    <#else>
        <#assign productContactUserName="" />
    </#if>

    <#if pibStakeholderList?? &&  pibStakeholderList.globalCommunicationAgency?? && pibStakeholderList.globalCommunicationAgency &gt; 0>
        <#assign globalCommunicationAgencyUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.globalCommunicationAgency) />
		<input type="hidden" name="globalCommunicationAgencyOri" value="${pibStakeholderList.globalCommunicationAgency?c}">
    <#else>
        <#assign globalCommunicationAgencyUserName="" />
    </#if>

<div class="ld-div">
	
	
	<#if isAboveMarket>
		<#--<i style="color:black">(Please make your selection)</i></br> -->
		Please select the agency below which will be involved in the project for waiver process <span class="red">*</span></br> </br> 
		<#if projectInitiation.nonKantar?? && projectInitiation.nonKantar==1>
			<#--<input type="checkbox" name="nonKantar" id="nonKantar" onclick="changeAgencyUsers();" value="true" checked="true"  />&nbsp;&nbsp;Non-Kantar<br><i style="color:red">(Please select the checkbox for Non-Kantar related projects)</i>-->
			<input type="radio" name="kantar" id="kantar" value="true" onclick="changeAgencyUsersKantar();" checked="true" />&nbsp;&nbsp;Kantar
			 <br/>
			 <input type="radio" name="nonKantar" id="nonKantar" value="true" onclick="changeAgencyUsersNonKantar();" style="float:left;margin-top:8px;" checked="false" /><label style="float:left;" >&nbsp;&nbsp;Non-Kantar</label>
			 <script type="text/javascript">
			 
	               $j("input[name=nonKantar]").removeAttr('checked');
	       	 </script>
		<#elseif projectInitiation.nonKantar?? && projectInitiation.nonKantar==2>
		<#-- <input type="checkbox" name="nonKantar" id="nonKantar" onclick="changeAgencyUsers();" value="false"  />&nbsp;&nbsp;Non-Kantar<br><i style="color:red">(Please select the checkbox for Non-Kantar related projects)</i>-->
		
		 <input type="radio" name="kantar" id="kantar" value="true"  onclick="changeAgencyUsersKantar();" checked="false" />&nbsp;&nbsp;Kantar
		 <br/>
		 <input type="radio" name="nonKantar" id="nonKantar" value="true"  style="float:left;margin-top:8px;" onclick="changeAgencyUsersNonKantar();" checked="true" /><label style="float:left;" >&nbsp;&nbsp;Non-Kantar</label> 
		  <script type="text/javascript">
		 
               $j("input[name=kantar]").removeAttr('checked');
       	 </script>
		<#else>
			 <input type="radio" name="kantar" id="kantar" value="true"  onclick="changeAgencyUsersKantar();" checked="false" />&nbsp;&nbsp;Kantar
			 <br/>
			 <input type="radio" name="nonKantar" id="nonKantar" value="true" onclick="changeAgencyUsersNonKantar();" style="float:left;margin-top:8px;" checked="false" /><label style="float:left;" >&nbsp;&nbsp;Non-Kantar</label>
			
			 <script type="text/javascript">
			 
	               $j("input[name=nonKantar]").removeAttr('checked'); 
	           <#--    $j("input[name=kantar]").removeAttr('checked'); -->
	
	    	 </script>
		</#if>
		
		<script type="text/javascript">
	            var initiateKantarWaiverWindow = null;
	            $j(document).ready(function(){
	                initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request Waiver for using Non-Kantar Agency',confirmOnClose:true});
	                FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#kantar-waiver-form"), projectID:${projectID?c}});
	            });
	
	     </script>
	     
	   
	        <ul class="right-sidebar-list" style="float:right;margin: -20px 0 0px 0;">
	        	
	            <li id="initiateKantarWaiverButton" <#if !(projectInitiation.nonKantar?? && projectInitiation.nonKantar==2)>style="display:none"</#if>><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Initiate a Waiver</#if></a></li>
	        </ul>
	        
	        <#-- <#if projectInitiation.nonKantar && pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??> -->
		      
		        <div class="form-select_div select-div methodology-status" id="nonKantarWaiverStatus" <#if projectInitiation.nonKantar??&& projectInitiation.nonKantar==2 && pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>style="display:block;" <#else> style="display:none;"</#if>>
		            
		            <#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
	                <label>Status of Waiver</label>
	                <span>Approved</span>
		            <#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
		                <label>Status of Waiver</label>
		                <span>Rejected</span>
		            <#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID?? >
		                <label>Status of Waiver</label>
		                <span>Pending</span>
		            <#else>
		            </#if>
		            <br/>
		        </div>
		  <#--  </#if> -->
		  
		   <div id="nonKantarError" class="jive-error-message" style="display:none; float:left; width:748px; margin: 10px 0 5px 0px;font-size: 11px !important;font-weight:normal; " >
		    	Please select Kantar option
		   </div><br/>
	
	 	<div id="kantarMessage" class="jive-error-box" <#if !(projectInitiation.nonKantar?? && projectInitiation.nonKantar==2)>style="display:none; width:748px; margin: 20px 0 0 0px; background:lightgreen;" <#else> style="width:748px; margin: 20px 0 0 0px; background:lightgreen;"</#if>>
	    	Please get a waiver approved for using a Non-Kantar Agency. For the process to move forward kindly raise a waiver and add a BAT contact as your Agency Contact.
	   	</div>
	 </#if>


<!-- DETAILED STAKEHOLDER LIST STARTS -->
   <#-- <#if !(isExternalAgencyUser || isCommAgencyUser) >-->
    <#if !(isCommAgencyUser) >
    <h3 class="pib_sub_heading">Detailed Stakeholder List</h3>
    <div class="pib_detail_st_list">
        <div class="form-select_div">
            <label>BAT Contact<span class="red">*</span></label>

            <#if isAboveMarket>
                <ul>
                    <li>
                        <#if isAdminUser>
                           <#-- <span class="view_nums">1.</span><input type="text" tabindex="1" name="agencyContact1" id="agencyContact1" class="j-user-autocomplete j-ui-elem" srole="6" autocomplete="off" /> -->
                            <div id="agencyContact1Div" <#if projectInitiation.nonKantar?? && projectInitiation.nonKantar==2>style="display:none"</#if>>
                   		     	<#--<span class="view_nums">1.</span><input type="text" tabindex="1" name="agencyContact1" id="agencyContact1" class="j-user-autocomplete j-ui-elem" srole="6" autocomplete="off" />-->
                   		     	<span class="view_nums">1.</span><input type="text" tabindex="1" name="agencyContact1" id="agencyContact1" value="${agency1UserName}" class="j-user-autocomplete j-ui-elem" srole="21" autocomplete="off" title="Please select a BAT Contact who will run the process." />
                       		</div>
                       		<div id="agencyContact1BATDiv" <#if projectInitiation.nonKantar?? && (projectInitiation.nonKantar==0 || projectInitiation.nonKantar==1)>style="display:none"</#if>>
                             	<#--<span class="view_nums">1.</span><input type="text" tabindex="1" name="agencyUserBATContact1" id="agencyUserBATContact1"  class="j-user-autocomplete j-ui-elem" srole="20" autocomplete="off" />-->
                             	<span class="view_nums">1.</span><input type="text" tabindex="1" name="agencyUserBATContact1" id="agencyUserBATContact1" value="${agency1UserName}"  class="j-user-autocomplete j-ui-elem" srole="21" autocomplete="off" title="Please select a BAT Contact who will run the process." />
                       		</div>
                        <#elseif isProposalAwarded?? && isProposalAwarded>
                            <span class="view_nums">1.</span> <input type="text" name="ag1" id="ag1"  value="${agency1UserName}" disabled />
                        <#else>
                            <div id="agencyContact1Div" <#if projectInitiation.nonKantar?? && projectInitiation.nonKantar==2>style="display:none"</#if>>
                   		     	<#--<span class="view_nums">1.</span><input type="text" tabindex="1" name="agencyContact1" id="agencyContact1" class="j-user-autocomplete j-ui-elem" srole="6" autocomplete="off" />-->
                   		     	<span class="view_nums">1.</span><input type="text" tabindex="1" name="agencyContact1" id="agencyContact1" value="${agency1UserName}" class="j-user-autocomplete j-ui-elem" srole="21" autocomplete="off" title="Please select a BAT Contact who will run the process." />
                       		</div>
                        	<div id="agencyContact1BATDiv" <#if projectInitiation.nonKantar?? && (projectInitiation.nonKantar==0 || projectInitiation.nonKantar==1)>style="display:none"</#if>>
                             	<#--<span class="view_nums">1.</span><input type="text" tabindex="1" name="agencyUserBATContact1" id="agencyUserBATContact1"  class="j-user-autocomplete j-ui-elem" srole="20" autocomplete="off" />-->
                             	<span class="view_nums">1.</span><input type="text" tabindex="1" name="agencyUserBATContact1" id="agencyUserBATContact1" value="${agency1UserName}"  class="j-user-autocomplete j-ui-elem" srole="21" autocomplete="off" title="Please select a BAT Contact who will run the process." />
                        	</div>
                        </#if>

                    </li>
                    <li class="view_field_row">

                        <#if isAdminUser>
                                                      
                        <li class="view_field_row" id="agencyContact1OptionalDiv" <#if projectInitiation.nonKantar?? && projectInitiation.nonKantar==2>style="display:none"</#if>>
                           <#-- <input type="text" tabindex="1" name="agencyContact1Optional" id="agencyContact1Optional" class="j-user-autocomplete j-ui-elem" srole="6" autocomplete="off" /> -->
                            <input type="text" tabindex="1" name="agencyContact1Optional" id="agencyContact1Optional" value="${agency1OptionalUserName}" class="j-user-autocomplete j-ui-elem" srole="21" autocomplete="off" />
                        </li>
                    
                       	<li class="view_field_row" id="agencyContact1OptionalBATDiv" <#if projectInitiation.nonKantar?? && (projectInitiation.nonKantar==0 || projectInitiation.nonKantar==1)>style="display:none"</#if>>
                           <#-- <input type="text" tabindex="1" name="agencyUserBATContact1Optional" id="agencyUserBATContact1Optional"  class="j-user-autocomplete j-ui-elem" srole="20" autocomplete="off" /> -->
                           <input type="text" tabindex="1" name="agencyUserBATContact1Optional" id="agencyUserBATContact1Optional"  value="${agency1OptionalUserName}" class="j-user-autocomplete j-ui-elem" srole="21" autocomplete="off" />
                        </li>
                        <#elseif isProposalAwarded?? && isProposalAwarded>
                            <input type="text" name="ag1Optional" id="ag1Optional"  value="${agency1OptionalUserName}" disabled />
                        <#else>
                            <li class="view_field_row" id="agencyContact1OptionalDiv" <#if projectInitiation.nonKantar?? && projectInitiation.nonKantar==2>style="display:none"</#if>>
                            	<#--<input type="text" tabindex="1" name="agencyContact1Optional" id="agencyContact1Optional" class="j-user-autocomplete j-ui-elem" srole="6" autocomplete="off" /> -->
                            	<input type="text" tabindex="1" name="agencyContact1Optional" id="agencyContact1Optional"  value="${agency1OptionalUserName}" class="j-user-autocomplete j-ui-elem" srole="21" autocomplete="off" />
                            </li>
                    
	                       	<li class="view_field_row" id="agencyContact1OptionalBATDiv" <#if projectInitiation.nonKantar?? && (projectInitiation.nonKantar==0 || projectInitiation.nonKantar==1)>style="display:none"</#if>>
	                            <#-- <input type="text" tabindex="1" name="agencyUserBATContact1Optional" id="agencyUserBATContact1Optional"  class="j-user-autocomplete j-ui-elem" srole="20" autocomplete="off" />-->
	                            <input type="text" tabindex="1" name="agencyUserBATContact1Optional" id="agencyUserBATContact1Optional"   value="${agency1OptionalUserName}" class="j-user-autocomplete j-ui-elem" srole="21" autocomplete="off" />
	                        </li>
                        </#if>
                        <span  class="jive-field-message">(Optional)</span>
                    </li>
                    
                    <#--
                    <li id="agencyContact2Section" <#if projectInitiation.nonKantar>style="display:none"</#if>>
                        <#if isAdminUser>
                            <span class="view_nums">2.</span><input type="text" tabindex="1" name="agencyContact2" id="agencyContact2" class="j-user-autocomplete-1 j-ui-elem" srole="6" autocomplete="off" />
                        <#elseif isProposalAwarded?? && isProposalAwarded>
                            <span class="view_nums">2.</span><input type="text" name="ag2" id="ag2"  value="${agency2UserName}" disabled />
                        <#else>
                            <span class="view_nums">2.</span><input type="text" tabindex="1" name="agencyContact2" id="agencyContact2" class="j-user-autocomplete-1 j-ui-elem" srole="6" autocomplete="off" />
                        </#if>

                        <span  class="jive-field-message">(Optional)</span>

                    </li>
                    <li class="view_field_row" id="agencyContact2SectionOptional" <#if projectInitiation.nonKantar>style="display:none"</#if>>
                        <#if isAdminUser>
                            <input type="text" tabindex="1" name="agencyContact2Optional" id="agencyContact2Optional" class="j-user-autocomplete j-ui-elem" srole="6" autocomplete="off" />
                        <#elseif isProposalAwarded?? && isProposalAwarded>
                            <input type="text" name="ag2Optional" id="ag2Optional"  value="${agency2OptionalUserName}" disabled />

                        <#else>
                            <input type="text" tabindex="1" name="agencyContact2Optional" id="agencyContact2Optional" class="j-user-autocomplete j-ui-elem" srole="6" autocomplete="off" />
                        </#if>

                        <span  class="jive-field-message">(Optional)</span>
                    </li>
                   
					<li id="agencyContact3Section" <#if projectInitiation.nonKantar>style="display:none"</#if>>
                        <#if isAdminUser>
                            <span class="view_nums">3.</span><input type="text" tabindex="1" name="agencyContact3" id="agencyContact3" class="j-user-autocomplete-1 j-ui-elem" srole="6" autocomplete="off" />
                        <#elseif isProposalAwarded?? && isProposalAwarded>
                            <span class="view_nums">3.</span><input type="text" name="ag3" id="ag3"  value="${agency3UserName}" disabled />

                        <#else>
                            <span class="view_nums">3.</span><input type="text" tabindex="1" name="agencyContact3" id="agencyContact3" class="j-user-autocomplete-1 j-ui-elem" srole="6" autocomplete="off" />
                        </#if>

                        <span  class="jive-field-message">(Optional)</span>

                    </li>
                    <li class="view_field_row" id="agencyContact3SectionOptional" <#if projectInitiation.nonKantar>style="display:none"</#if>>
                        <#if isAdminUser>
                            <input type="text" tabindex="1" name="agencyContact3Optional" id="agencyContact3Optional" class="j-user-autocomplete j-ui-elem" srole="6" autocomplete="off" />
                        <#elseif isProposalAwarded?? && isProposalAwarded>
                            <input type="text" name="ag3Optional" id="ag3Optional"  value="${agency3OptionalUserName}" disabled />
                        <#else>
                            <input type="text" tabindex="1" name="agencyContact3Optional" id="agencyContact3Optional" class="j-user-autocomplete j-ui-elem" srole="6" autocomplete="off" />
                        </#if>

                        <span  class="jive-field-message">(Optional)</span>
                    </li> -->
                </ul>
            <#else>
                <ul>
                    <li>
                        <span class="view_nums">1.</span> <input type="text" name="ag1" id="ag1"  value="${agency1UserName}" disabled />

                    </li>
                    <li class="view_field_row">
                        <input type="text" name="ag1Optional" id="ag1Optional"  value="${agency1OptionalUserName}" disabled />
                        <span  class="jive-field-message">(Optional)</span>
                    </li>
                   <#-- <li class="optional-field">
                        <span class="view_nums">2.</span><input type="text" name="ag2" id="ag2"  value="${agency2UserName}" disabled />
                        <span  class="jive-field-message">(Optional)</span>

                    </li>

                    <li class="view_field_row">
                        <input type="text" name="ag2Optional" id="ag2Optional"  value="${agency2OptionalUserName}" disabled />
                        <span  class="jive-field-message">(Optional)</span>
                    </li>

                    <li class="optional-field">
                        <span class="view_nums">3.</span><input type="text" name="ag3" id="ag3"  value="${agency3UserName}" disabled />
                        <span  class="jive-field-message">(Optional)</span>

                    </li>

                    <li class="view_field_row">
                        <input type="text" name="ag3Optional" id="ag3Optional"  value="${agency3OptionalUserName}" disabled />
                        <span  class="jive-field-message">(Optional)</span>
                    </li> -->
                </ul>
            </#if>
        </div>
        <span id="agencyContactError" class="jive-error-message" style="display:none">Please select atleast one Agency</span>
    </div>


    <div class="pib_detail_st_list">

        <div class="form-select_div">
            <#if isAboveMarket>
                <label>Above Market Legal Contact</label>
            <#else>
                <label>Legal Contact</label>
            </#if>
            <ul>
                <li class="view_field_row">
                    <input type="text" tabindex="1" name="globalLegalContact" id="globalLegalContact" value="${globalLegalContactUserName}" class="j-user-autocomplete j-ui-elem"  srole="4" autocomplete="off" />
                </li>
            </ul>
        </div>
        <br/>
        <br/>
        <br/>
        <span id="globalLegalContactError" class="jive-error-message" style="display:none">Please select Legal Contact</span>

        <div class="form-select_div">
            <#if isAboveMarket>
                <label>Above Market Product Contact</label>
            <#else>
                <label>Product Contact</label>
            </#if>

            <ul>
                <li class="view_field_row">
                    <input type="text" tabindex="1" name="productContact" id="productContact" value="${productContactUserName}" class="j-user-autocomplete-1 j-ui-elem" srole="20" autocomplete="off" />
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
                    <input type="text" tabindex="1" name="globalProcurementContact" id="globalProcurementContact" value="${globalProcurementContactUserName}" class="j-user-autocomplete-1 j-ui-elem" srole="5" autocomplete="off" />
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
                    <input type="text" tabindex="1" name="globalCommunicationAgency"  id="globalCommunicationAgency" value="${globalCommunicationAgencyUserName}"  class="j-user-autocomplete-1 j-ui-elem" srole="7" autocomplete="off" />
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

<!-- PROJECT CONTACT STAKEHOLDER STARTS -->
    <#if isAboveMarket>
    <div>
        <label class="label_b">Project Contact Stakeholders</label>
        <table class="multi-stakeholders">
            <#list fundingInvestments as fundingInvestment>
                <#if fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].GlOBAL.getId()>
                    <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(fundingInvestment.projectContact) />
                    <tr class="${getStakeholdersClass(fundingInvestment_index)}"><td>GLOBAL</td><td>${projectContactName}</td></tr>
                </#if>
                <#if fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].REGION.getId()>
                    <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(fundingInvestment.projectContact) />
                    <tr class="${getStakeholdersClass(fundingInvestment_index)}"><td>REGIONAL</td><td>${projectContactName}</td></tr>
                </#if>
                <#if fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].AREA.getId()>
                    <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(fundingInvestment.projectContact) />
                    <tr class="${getStakeholdersClass(fundingInvestment_index)}"><td>AREA</td><td>${projectContactName}</td></tr>
                </#if>
                <#if fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].COUNTRY.getId()>
                    <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(fundingInvestment.projectContact) />
                    <tr class="${getStakeholdersClass(fundingInvestment_index)}"><td>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(fundingInvestment.fieldworkMarketID?int)}</td><td>${projectContactName}</td></tr>
                </#if>
            </#list>
        </table>
    </div>
    </#if>
<!-- PROJECT CONTACT STAKEHOLDER ENDS -->

<div class="buttons">
    <#if editStage >
        <br>
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
<#-- ELSE BLOCK ENDS in case the user is not External Agency or communication Agency -->

</#if>


<!-- SYNCHRO BEGIN -->
<!-- EMAIL NOTIFICATION WINDOW -->
<div id="emailNotification" style="display:none">
    <form id="email-notification-form" action="<@s.url value="/synchro/pib-multi-details!sendNotification.jspa"/>" method="post" enctype="multipart/form-data" class="j-form-popup">
        <a href="javascript:void(0);" class="close" onclick="closeEmailNotification();"></a>
        To <input type="text" id="recipients" name="recipients" value="" />
        <span class="jive-error-message" style="display:none" id="inviteEmail_error"><@s.text name="invite.email.error"/></span>
        Subject <input type="text" id="subject" name="subject" value="" />
        <span class="jive-error-message" style="display:none" id="inviteSubject_error"><@s.text name="invite.subject.error"/></span>
        Body
        <div id="messageBodyDiv" name="messageBodyDiv" contenteditable></div>
        <textarea id="messageBody" name="messageBody" style="display:none;"></textarea>
        <span class="jive-error-message" style="display:none" id="inviteMessageBody_error"><@s.text name="invite.body.error"/></span>
        <!-- Attachments code -->
    <#assign maxMailAttachs = JiveGlobals.getJiveIntProperty("grail.synchro.max.email.attachment", 5) />
        <input type="file" name="mailAttachment" id="mailAttachment" multiple />
        <ul id="mailAttachmentFileList">
            <!-- The file list will be shown here -->
        </ul>
        <input type="hidden" id="projectID" name="projectID" value="${projectID?c}" />
        <input type="hidden" id="notificationTabId" name="notificationTabId" value="" />
        <input type="hidden" id="stageId" name="stageId" value="" />
        <input type="hidden" id="docID" name="docID" value="" />
        <input type="hidden" id="approve" name="approve" value="" />
        <input type="hidden" name="endMarketId" value="${endMarketId?c}">
        <input class="j-btn-callout" type="button" name="doPost" id="postButton" onclick="return notificationVal();" value="Submit" style="font-weight: bold;" />

    </form>
</div>

<!-- MOVE TO NEXT STAGE FORM STARTS -->
<form method="POST" name="moveToNextStageForm" id="moveToNextStageForm" action="/synchro/pib-multi-details!moveToNextStage.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
    <input type="hidden" name="endMarketId" value="${endMarketId?c}">
</form>
<!-- MOVE TO NEXT STAGE FORM ENDS -->
<#--<#include "/template/global/include/synchro-invite-user.ftl" />-->

<!-- Import Document functionality-->
<#include "/template/global/include/import-doc-form.ftl" />


<!-- INITIATE WAIVER WINDOW STARTS -->
<div id="initiateWaiver" style="display:none;">
    <script type="text/javascript">
        $j(document).ready(function(){
            if($j("#initiateWaiver").parent().hasClass('light-box'))
            {
                $j("#initiateWaiver").parent().prepend($j("#success-msg-waiver"));
            }
        });
    </script>
    <div class="popup-waiver">
    


        <form id="waiver-form" action="<@s.url value="/synchro/pib-multi-details!updateWaiver.jspa"/>" method="post" class="j-form-popup">
        
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
		    
		    <div class="light-box-title" style="font-size: 15px; font-family: texgyreadventorregular\0, avantgarde; font-weight: bold !important; padding-bottom: 8px; border-bottom: 1px solid #ddd;"><h4><b>Request for Methodology Waiver</b></h4></div>
            <a href="javascript:void(0);" class="close" onclick="closeWaiverWindow();"></a>
            
            <label class='rte-editor-label'>Methodology Deviation Rationale</label>
            <div class="pib_view_popup form-text_div">


            <#if isAdminUser>
                <textarea id="methodologyDeviationRationale" name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>

            <#elseif (isMethAppUser || isProcUser || isProductUser) && !(isProjectOwner || isSPIContactUser || isProjectCreator)>
                <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            <#elseif  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            <#else>
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

            <#if isAdminUser>
                <@renderMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibMethodologyWaiver.methodologyApprover?default(-1)?c}"/>
            <#elseif (isMethAppUser || isProcUser || isProductUser) && !(isProjectOwner || isSPIContactUser || isProjectCreator)>
                <@renderMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibMethodologyWaiver.methodologyApprover?default(-1)?c}" readonly=true/>
            <#else>
                <@renderMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibMethodologyWaiver.methodologyApprover?default(-1)?c}"/>
            </#if>

                <!-- Current User is either Project Owner or SPI User-->

            <#if isAdminUser>
                <input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
                <input  id="send-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="SEND FOR INFORMATION" style="font-weight: bold;" />
            <#elseif isProjectOwner || isSPIContactUser || isProjectCreator>
                <#if  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                    <input type="button" class="g-btn"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
                    <input type="button" class="g-btn"  name="doPost" id="postButton"  value="SEND FOR INFORMATION" style="font-weight: bold;cursor:default;" />
                <#else>
                    <input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
                    <input  id="send-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="SEND FOR INFORMATION" style="font-weight: bold;" />

                </#if>

            <#elseif isMethAppUser || isProcUser || isProductUser>
                <input type="button" class="g-btn"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
                <input type="button" class="g-btn"  name="doPost" id="postButton"  value="SEND FOR INFORMATION" style="font-weight: bold;cursor:default;" />
            </#if>

            </div>

            <div class="pib_view_popup">
                <label>Methodology Approver Comment</label>

                <!-- Current User is Methodology User and is also Project Methodology Approver -->
            <#if isAdminUser>
                <textarea id="methodologyApproverComment" name="methodologyApproverComment" placeholder="Methodology Approver Comments">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>

            <#elseif isMethAppUser && pibMethodologyWaiver.methodologyApprover?? && user.ID==pibMethodologyWaiver.methodologyApprover>
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

        <#if isAdminUser>
            <input id="request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
            <input id="approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
            <input id="reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />

        <#elseif isMethAppUser && pibMethodologyWaiver.methodologyApprover?? && user.ID==pibMethodologyWaiver.methodologyApprover>

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



            <!-- Current User is NOT Methodology Approver User -->
        <#else>
            <input type="button" class="g-btn r-more"  name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium"  name="doPost" id="postButton" value="Approve" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />
        </#if>
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" name="endMarketId" value="${endMarketId?c}">
            <input type="hidden" id="methodologyWaiverAction" name="methodologyWaiverAction" value="">
        </form>
    </div>
</div>
<!-- INITIATE WAIVER WINDOW ENDS -->

<!-- INITIATE KANTAR WAIVER WINDOW STARTS -->
<div id="initiateKantarWaiver" style="display:none;">
    <script type="text/javascript">
        $j(document).ready(function(){
            if($j("#initiateKantarWaiver").parent().hasClass('light-box'))
            {
                $j("#initiateKantarWaiver").parent().prepend($j("#success-msg-waiver-kantar"));
            }
        });
    </script>
    <div class="popup-waiver">
    <#--<div id="success-msg-waiver" class="success-msg-waiver"-->
    <#--<#if pibMethodologyWaiver.isApproved?? && (pibMethodologyWaiver.isApproved==1 || pibMethodologyWaiver.isApproved==2)>style="display: block;"<#else>style="display: none;"</#if>>-->
    <#if  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
        <div id="success-msg-waiver-kantar" class="approve-msg-waiver">
            <span class="waiver-icon"></span>
            <span class="waiver-msg">Waiver is Approved.</span>
        </div>
    <#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
        <div id="success-msg-waiver-kantar" class="reject-msg-waiver">
            <span class="waiver-icon"></span>
            <span class="waiver-msg waiver-rejected">Waiver is Rejected.</span>
        </div>
    </#if>


        <form id="kantar-waiver-form" action="<@s.url value="/synchro/pib-multi-details!updateKantarWaiver.jspa"/>" method="post">
            <label class='rte-editor-label'>Rationale for using Non-Kantar Agency</label>
            <div class="pib_view_popup form-text_div">


            <#if isAdminUser>
                <textarea id="methodologyDeviationRationaleKantar" name="methodologyDeviationRationale" placeholder="Methodology Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>

            <#elseif (isKantarMethAppUser || isProcUser || isProductUser) && !(isProjectOwner || isSPIContactUser || isProjectCreator)>
                <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            <#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            <#else>
                <textarea id="methodologyDeviationRationaleKantar" name="methodologyDeviationRationale" placeholder="Methodology Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            </#if>
            </div>
            <div class="pib_view_popup">
                <label class="synchro-help-waiver-label" title="Consumer Based Research- Taina Vauhkonen
Trade Measurement Research (including Retail Measurement Service)- Tim Carey"> Approver<span style="margin: -16px 1px 2px 70px;" title="Consumer Based Research- Taina Vauhkonen
Trade Measurement Research (including Retail Measurement Service)- Tim Carey">help</span></label>

            <#if isAdminUser>
                <@renderKantarMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibKantarMethodologyWaiver.methodologyApprover?default(-1)?c}"/>
            <#elseif (isMethAppUser || isProcUser || isProductUser) && !(isProjectOwner || isSPIContactUser || isProjectCreator)>
                <@renderKantarMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibKantarMethodologyWaiver.methodologyApprover?default(-1)?c}" readonly=true/>
            <#else>
                <@renderKantarMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibKantarMethodologyWaiver.methodologyApprover?default(-1)?c}"/>
            </#if>

                <!-- Current User is either Project Owner or SPI User-->

            <#if isAdminUser>
                <input id="kantar-send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
                <input  id="kantar-send-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="SEND FOR INFORMATION" style="font-weight: bold;" />
            <#elseif isProjectOwner || isSPIContactUser || isProjectCreator>
                <#if  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                    <input type="button" class="g-btn"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
                    <input type="button" class="g-btn"  name="doPost" id="postButton"  value="SEND FOR INFORMATION" style="font-weight: bold;cursor:default;" />
                <#else>
                    <input id="kantar-send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
                    <input  id="kantar-send-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="SEND FOR INFORMATION" style="font-weight: bold;" />

                </#if>

            <#elseif isKantarMethAppUser || isProcUser || isProductUser>
                <input type="button" class="g-btn"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
                <input type="button" class="g-btn"  name="doPost" id="postButton"  value="SEND FOR INFORMATION" style="font-weight: bold;cursor:default;" />
            </#if>

            </div>

            <div class="pib_view_popup">
                <label>Approver's Comment</label>

                <!-- Current User is Methodology User and is also Project Methodology Approver -->
            <#if isAdminUser>
                <textarea id="methodologyApproverCommentKantar" name="methodologyApproverComment" placeholder="Methodology Approver Comments">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>

            <#elseif isKantarMethAppUser && pibKantarMethodologyWaiver.methodologyApprover?? && user.ID==pibKantarMethodologyWaiver.methodologyApprover>
                <#if pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                    <textarea id="methodologyApproverCommentKantar"  disabled name="methodologyApproverComment">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
                <#else>
                    <textarea id="methodologyApproverCommentKantar" name="methodologyApproverComment" placeholder="Methodology Approver Comments">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
                </#if>

                <!-- Current User is NOT Methodology Approver User -->
            <#else>
                <textarea id="methodologyApproverCommentKantar"  disabled name="methodologyApproverComment">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
            </#if>
            </div>

            <!-- Current User is Methodology User and is also Project Methodology Approver -->

        <#if isAdminUser>
            <input id="kantar-request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
            <input id="kantar-approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
            <input id="kantar-reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />

        <#elseif isKantarMethAppUser && pibKantarMethodologyWaiver.methodologyApprover?? && user.ID==pibKantarMethodologyWaiver.methodologyApprover>

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



            <!-- Current User is NOT Methodology Approver User -->
        <#else>
            <input type="button" class="g-btn r-more"  name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium"  name="doPost" id="postButton" value="Approve" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />
        </#if>
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" name="endMarketId" value="${endMarketId?c}">
            <input type="hidden" id="kantarMethodologyWaiverAction" name="kantarMethodologyWaiverAction" value="">
        </form>
    </div>
</div>
<!-- INITIATE KANTAR WAIVER WINDOW ENDS -->

<!-- ACTION STANDARD MARKET AMENDMENT WINDOW STARTS -->

<div id="actionStandardMarketAmendmentWindow" style="display:none">
    <div class="popup-waiver">
        <form id="as-form" class="ammendment-form" action="<@s.url value="/synchro/pib-multi-details!marketAmendment.jspa"/>" method="post">

            <div class="pib_view_popup">
                <label>Country</label>
                <select name="endMarketId" id="endMarketIdAS" class="form-select">
                <#list endMarketDetails as emd>
                <#--<#if actionStandardMap.get(emd.endMarketID)?? >-->
                <#--<option  value="${emd.endMarketID}" as="${actionStandardMap.get(emd.endMarketID)}" >${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emd.getEndMarketID()?int)}</option>-->
                <#--<#else>-->
                    <option  value="${emd.endMarketID}" as="" >${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emd.getEndMarketID()?int)}</option>
                <#--</#if>-->
                </#list>
                </select>
            </div>
            <label class='rte-editor-label'>Action Standard(s)</label>
            <div class="pib_view_popup form-text_div">
                <textarea id="actionStandard1" name="actionStandard" rows="10" cols="20" class="form-text-div"></textarea>
            <@macroCustomFieldErrors msg="Please enter comments" class='textarea-error-message'/>
            </div>
            <textarea id="actionStandard1Text" name="actionStandardText" style="display:none;"></textarea>

        <#list endMarketDetails as emd>
            <#if actionStandardMap.get(emd.endMarketID)?? >
                <div id="actionStandard-${emd.endMarketID}" style="display:none">${actionStandardMap.get(emd.endMarketID)}</div>
            </#if>
        </#list>

            <input class="j-btn-callout" type="button" name="doPost" id="amendmentPostButton-as" value="Save" style="font-weight: bold;" >
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" id="marketAmendmentType" name="marketAmendmentType" value="ActionStandard">

        </form>
    </div>
</div>

<!-- ACTION STANDARD MARKET AMENDMENT WINDOW ENDS -->

<!-- RESEARCH DESIGN MARKET AMENDMENT WINDOW STARTS -->

<div id="resDesMarketAmendmentWindow" style="display:none">
    <div class="popup-waiver">
        <form id="rd-form" class="ammendment-form" action="<@s.url value="/synchro/pib-multi-details!marketAmendment.jspa"/>" method="post">

            <div class="pib_view_popup">
                <label>Country</label>
                <select name="endMarketId" id="endMarketIdRD" class="form-select">
                <#list endMarketDetails as emd>
                <#--<#if researchDesignMap.get(emd.endMarketID)?? >-->
                <#--<option  value="${emd.endMarketID}" as="${researchDesignMap.get(emd.endMarketID)}" >${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emd.getEndMarketID()?int)}</option>-->
                <#--<#else>-->
                    <option  value="${emd.endMarketID}" as="" >${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emd.getEndMarketID()?int)}</option>
                <#--</#if>-->
                </#list>
                </select>

            </div>
            <label class='rte-editor-label'>Methodology Approach and Research Design</label>
            <div class="pib_view_popup form-text_div">
                <textarea id="researchDesign1" name="researchDesign" rows="10" cols="20" class="form-text-div"></textarea>
            <@macroCustomFieldErrors msg="Please enter Methodology Approach and Research Design" class='textarea-error-message'/>
            </div>
            <textarea id="researchDesign1Text" name="researchDesignText" style="display:none;"></textarea>
        <#list endMarketDetails as emd>
            <#if researchDesignMap.get(emd.endMarketID)?? >
                <div id="researchDesign-${emd.endMarketID}" style="display:none">${researchDesignMap.get(emd.endMarketID)}</div>

            </#if>
        </#list>
            <input class="j-btn-callout" type="button" name="doPost" id="amendmentPostButton-rd" value="Save" style="font-weight: bold;" />
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" id="marketAmendmentType" name="marketAmendmentType" value="ResearchDesign">

        </form>
    </div>
</div>

<!-- RESEARCH DESIGN  MARKET AMENDMENT WINDOW ENDS -->

<!-- SAMPLE PROFILE MARKET AMENDMENT WINDOW STARTS -->

<div id="sampleProfileMarketAmendmentWindow" style="display:none">
    <div class="popup-waiver">
        <form id="sp-form" class="ammendment-form" action="<@s.url value="/synchro/pib-multi-details!marketAmendment.jspa"/>" method="post">

            <div class="pib_view_popup">
                <label>Country</label>
                <select name="endMarketId" id="endMarketIdSP" class="form-select">
                <#list endMarketDetails as emd>
                <#--<#if sampleProfileMap.get(emd.endMarketID)?? >-->
                <#--<option  value="${emd.endMarketID}" as="${sampleProfileMap.get(emd.endMarketID)}" >${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emd.getEndMarketID()?int)}</option>-->
                <#--<#else>-->
                    <option  value="${emd.endMarketID}" as="" >${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emd.getEndMarketID()?int)}</option>
                <#--</#if>-->
                </#list>
                </select>
            </div>
            <label class='rte-editor-label'>Sample Profile (Research)</label>
            <div class="pib_view_popup form-text_div">
                <textarea id="sampleProfile1" name="sampleProfile" rows="10" cols="20" class="form-text-div"></textarea>
            <@macroCustomFieldErrors msg="Please enter Sample Profile (Research)" class='textarea-error-message'/>
            </div>
            <textarea id="sampleProfile1Text" name="sampleProfileText" style="display:none;"></textarea>
        <#list endMarketDetails as emd>
            <#if sampleProfileMap.get(emd.endMarketID)?? >
                <div id="sampleProfile-${emd.endMarketID}" style="display:none">${sampleProfileMap.get(emd.endMarketID)}</div>
            </#if>
        </#list>
            <input class="j-btn-callout" type="button" name="doPost" id="amendmentPostButton-sp" value="Save" style="font-weight: bold;" />
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" id="marketAmendmentType" name="marketAmendmentType" value="SampleProfile">

        </form>
    </div>
</div>

<!-- SAMPLE PROFILE  MARKET AMENDMENT WINDOW ENDS -->

<!-- STIMULUS MATERIAL MARKET AMENDMENT WINDOW STARTS -->

<div id="stimulusMaterialMarketAmendmentWindow" style="display:none">
    <div class="popup-waiver">
        <form id="sm-form" class="ammendment-form" action="<@s.url value="/synchro/pib-multi-details!marketAmendment.jspa"/>" method="post">

            <div class="pib_view_popup">
                <label>Country</label>
                <select name="endMarketId" id="endMarketIdSM" class="form-select">
                <#list endMarketDetails as emd>
                <#--<#if stimulusMaterialMap.get(emd.endMarketID)?? >-->
                <#--<option  value="${emd.endMarketID}" as="${stimulusMaterialMap.get(emd.endMarketID)}" >${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emd.getEndMarketID()?int)}</option>-->
                <#--<#else>-->
                    <option  value="${emd.endMarketID}" as="" >${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emd.getEndMarketID()?int)}</option>
                <#--</#if>-->
                </#list>
                </select>
            </div>
            <label class='rte-editor-label'>Stimulus Material</label>
            <div class="pib_view_popup form-text_div">
                <textarea id="stimulusMaterial1" name="stimulusMaterial" rows="10" cols="20" class="form-text-div"></textarea>
            <@macroCustomFieldErrors msg="Please enter Stimulus Material" class='textarea-error-message'/>
            </div>
            <textarea id="stimulusMaterial1Text" name="stimulusMaterialText" style="display:none;"></textarea>
        <#list endMarketDetails as emd>
            <#if stimulusMaterialMap.get(emd.endMarketID)?? >
                <div id="stimulusMaterial-${emd.endMarketID}" style="display:none">${stimulusMaterialMap.get(emd.endMarketID)}</div>
            <#--<input type="hidden" id="stimulusMaterial-${emd.endMarketID}" value="${stimulusMaterialMap.get(emd.endMarketID)}">-->
            </#if>
        </#list>
            <input class="j-btn-callout" type="button" name="doPost" id="amendmentPostButton-sm" value="Save" style="font-weight: bold;" />
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" id="marketAmendmentType" name="marketAmendmentType" value="StimulusMaterial">

        </form>
    </div>
</div>

<!-- STIMULUS MATERIAL MARKET AMENDMENT WINDOW ENDS -->

<!-- ADD/CHANGE COUNTRY WINDOW STARTS -->

<div id="addChangeCountryWindow" style="display:none">

    <form id="update-end-markets-form" action="<@s.url value="/synchro/pib-multi-details!updateEndMarkets.jspa"/>" method="post">
        <div class="form-select_div_main">
            <!-- End Markets Multiselect -->
        <@showUpdatedEndMarketFieldSection name='updatedEndMarkets' value=emIds?default('-1') label='End Markets' validate=true />
        <#assign error_msg><@s.text name='project.error.endmarket' /></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>
        <input class="j-btn-callout" type="submit" name="doPost" id="postButton" value="Save" style="font-weight: bold;" />
        <input type="hidden" name="projectID" value="${projectID?c}">
    </form>

</div>

<!-- ADD/CHANGE COUNTRY WINDOW ENDS -->


<!-- VIEW COST APPROVALS WINDOW STARTS -->

<div id="viewCostApprovalsWindow" style="display:none">

    <table id="investment-details" class="investment-details-table">
        <thead>
        <tr>
            <th>
                Investment
            </th>
            <th>
                Market (Fieldwork)
            </th>
            <th>
                Market (Funding)
            </th>
            <th>
                Project Contact
            </th>
            <th>
                Estimated Cost
            </th>
            <th>
                Currency
            </th>
            <th>
                Approved
            </th>

        </tr>
        </thead>
        <tbody>
        
       <#list fundingInvestments as fundingInvestment>
        
        <#if endMarketId==statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID >
	        <tr>
				
	            <#if fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].GlOBAL.getId()>
	                <td>${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].GlOBAL.getDescription()}</td>
	            <#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].REGION.getId()>
	                <td>${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].REGION.getDescription()}</td>
	            <#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].AREA.getId()>
	                <td>${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].AREA.getDescription()}</td>
	            <#else>
	                <td>${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].COUNTRY.getDescription()}</td>
	
	            </#if>
	            <#if fundingInvestment.investmentType!=statics['com.grail.synchro.SynchroGlobal$InvestmentType'].COUNTRY.getId()>
	                <td></td>
	                <td></td>
	            <#else>
	                <#if fundingInvestment.fieldworkMarketID??>
	                    <td>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(fundingInvestment.fieldworkMarketID?int)}</td>
	                <#else>
	                    <td></td>
	                </#if>
	                <#if fundingInvestment.fundingMarketID??>
	                    <td>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(fundingInvestment.fundingMarketID?int)}</td>
	                <#else>
	                    <td></td>
	                </#if>
	            </#if>
	            <#if fundingInvestment.projectContact?? && fundingInvestment.projectContact gt 0>
	                <#assign pCName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(fundingInvestment.projectContact) />
	                <td>${pCName}</td>
	            <#else>
	                <td></td>
	            </#if>
	            <td>${fundingInvestment.estimatedCost}</td>
	            <#if fundingInvestment.estimatedCostCurrency??>
	                <td>${statics['com.grail.synchro.SynchroGlobal'].getCurrencies().get(fundingInvestment.estimatedCostCurrency?int)}</td>
	            <#else>
	                <td></td>
	            </#if>
	            <#if fundingInvestment.approvalStatus?? && fundingInvestment.approvalStatus>
	                <td>Yes</td>
	            <#elseif fundingInvestment.approvalStatus?? && !fundingInvestment.approvalStatus>
	                <td>No</td>
	            <#else>
	                <td>Waiting</td>
	            </#if>
	
	
	        </tr>
	    <#elseif endMarketId==fundingInvestment.fieldworkMarketID>
	    		<tr>
				
	            <#if fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].GlOBAL.getId()>
	                <td>${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].GlOBAL.getDescription()}</td>
	            <#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].REGION.getId()>
	                <td>${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].REGION.getDescription()}</td>
	            <#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].AREA.getId()>
	                <td>${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].AREA.getDescription()}</td>
	            <#else>
	                <td>${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].COUNTRY.getDescription()}</td>
	
	            </#if>
	            <#if fundingInvestment.investmentType!=statics['com.grail.synchro.SynchroGlobal$InvestmentType'].COUNTRY.getId()>
	                <td></td>
	                <td></td>
	            <#else>
	                <#if fundingInvestment.fieldworkMarketID??>
	                    <td>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(fundingInvestment.fieldworkMarketID?int)}</td>
	                <#else>
	                    <td></td>
	                </#if>
	                <#if fundingInvestment.fundingMarketID??>
	                    <td>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(fundingInvestment.fundingMarketID?int)}</td>
	                <#else>
	                    <td></td>
	                </#if>
	            </#if>
	            <#if fundingInvestment.projectContact?? && fundingInvestment.projectContact gt 0>
	                <#assign pCName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(fundingInvestment.projectContact) />
	                <td>${pCName}</td>
	            <#else>
	                <td></td>
	            </#if>
	            <td>${fundingInvestment.estimatedCost}</td>
	            <#if fundingInvestment.estimatedCostCurrency??>
	                <td>${statics['com.grail.synchro.SynchroGlobal'].getCurrencies().get(fundingInvestment.estimatedCostCurrency?int)}</td>
	            <#else>
	                <td></td>
	            </#if>
	            <#if fundingInvestment.approvalStatus?? && fundingInvestment.approvalStatus>
	                <td>Yes</td>
	            <#elseif fundingInvestment.approvalStatus?? && !fundingInvestment.approvalStatus>
	                <td>No</td>
	            <#else>
	                <td>Waiting</td>
	            </#if>
	
	
	        </tr>
	    </#if>
        </#list>
        </tbody>
    </table>


</div>

<!-- VIEW COST APPROVALS WINDOW ENDS -->

<#assign allowPITSave = true />
<#if isAdminUser >
    <#assign allowPITSave = true />
<#elseif projectInitiation.status?? && projectInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PIB_COMPLETED.ordinal() && !isBudgetApprover>
    <#assign allowPITSave = false />
<#elseif !canEditProject>
    <#assign allowPITSave = false />
<#else>
    <#assign allowPITSave = true />
</#if>
<div id="pitWindow" style="display:none">
<script src="${themePath}/js/synchro/project-form.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<!-- PIT WINDOW STARTS -->
<script type="text/javascript">

    function openPITWindow() {
    <#if !PIBReadonly >
        FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#synchro-pit-form"), projectID:${projectID?c}});
    </#if>

        $j("#pitWindow").lightbox_me({centered:true,closeEsc:false,closeClick:false,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7},
            onLoad:function() {
                showInvestments();
            }
        });
    <#if project.brand??>
        $j("#brand").val("${project.brand}");
    </#if>
	
	<!-- Audit Logs-->
	<#assign i18CustomPITText><@s.text name="logger.project.pit.view.text" /></#assign>	
	var projName = "${project.name?js_string}";
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PIB.getId()}, "${i18CustomPITText}", projName, ${projectID?c}, ${user.ID?c});
    }
    function closePITWindow() {
        var closePITPopup = false;
        $j("#pitWindow").hide();
		
        dialog({
            title:"Confirmation",
            html:"Are you sure you want to close with out saving details?",
            nonCloseActionButtons:['YES'],
            buttons:{
                "YES":function() {
                    var closePITPopup = true;
                    $j("#pitWindow").trigger('close');
                    $j("#pitWindow").hide();
                    $j(".lb_overlay").remove();
		    closeDialog();
                },
                "NO": function() {
                    var closePITPopup = false;
                    $j("#pitWindow").show();
                }
            },
            closeActionButtonsClickHander:function() {
                $j("#pitWindow").show();
		 closeDialog();
            }

        });
    }

    function savePIT() {
    
        if(validatePITFields()) {
            //Set Flag for PIT Update
            $j("input[name=pitUpdateOnly]").val("true");
            
            appendInvestmentFieldstoForm();
            return true;
        }
        return false;
    }

    function validatePITFields() {
        var error = false;
        showLoader('Please wait...');
        var initialCost = $j("#synchro-pit-form input[name=totalCost]");
         
        
        if (initialCost!=undefined && initialCost.val()!=undefined)
        {
	        if(initialCost.val()=="")
	        {
	        	
	        }
	        else if (initialCost && !numericFormat(initialCost, true)) {
	           
	            var val = $j(initialCost).val().replace(/\,/g, '');
	       
	            if(allnumeric(initialCost, val)) {
	                initialCost.parent().find("span").text("Please enter number in 000,000 format");
	            }
	            else {
	                initialCost.parent().find("span").text("Please enter numeric value");
	            }
	         
	            initialCost.parent().find("span").show();
	            error = true;
	        } else {
	         
	            initialCost.val(initialCost.val().replace(/\,/g, ''));
	            initialCost.parent().find("span").hide();
	        }
	    }
	
        var categoryType = $j("#synchro-pit-form select[name=categoryType]");
        var ctOptions = $j(categoryType).find('option');
        if(ctOptions.length <= 0) {
            $j(categoryType).parent().parent().find("span").show();
            error = true;
        } else {
           // $j("#synchro-pit-form select[name=categoryType] option").attr('selected','selected');
			$j('#synchro-pit-form select[name=categoryType] option').prop('selected', true);
            $j(categoryType).parent().find("span").hide();
        }
		
	
        var proposedMethodology = $j("#synchro-pit-form select[name=proposedMethodology]");
        var pmOptions = $j(proposedMethodology).find('option');
        if(pmOptions.length <= 0) {
            $j(proposedMethodology).parent().parent().find("span").show();
            error = true;
        } else {
           // $j("#synchro-pit-form select[name=proposedMethodology] option").attr('selected','selected');
			$j('#synchro-pit-form select[name=proposedMethodology] option').prop('selected', true);
            $j(proposedMethodology).parent().find("span").hide();
        }
    
        if(error)
            hideLoader();

        return !error;
    }

    function exportToPDFPIT(projectId) {
        window.location.href = "/synchro/pib-multi-details!exportToPDFPIT.jspa?projectID="+projectId;
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

    var investmentPopup = null;
    $j("#pitWindow").ready(function(){
        $j("#add-investment-popup #pageType").val('pib');
        investmentPopup = new LIGHT_BOX($j("#add-investment-popup"),{title:'Add Investment',
            onClose:function(){
                $j("#pitWindow").show();
                $j(".lb_overlay").show();
            },
            onShow:function() {
                $j("#pitWindow").hide();
            }
        });
    });

    function showInvestments() {
        $j("#pitWindow .investment-details-table tbody").empty();
       
    <#list fundingInvestments as fundingInvestment>
       
      <#if !statics['com.grail.synchro.util.SynchroPermHelper'].isMarketDeleted(projectID, fundingInvestment.fieldworkMarketID) >
        <#assign projectContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(fundingInvestment.projectContact) />
        <#assign currencyName = statics['com.grail.synchro.SynchroGlobal'].getCurrencies().get(fundingInvestment.estimatedCostCurrency?int)/>
        <#assign investmentTypeName = statics['com.grail.synchro.SynchroGlobal$InvestmentType'].getById(fundingInvestment.investmentType)/>

        var data = {
            investmentType:${fundingInvestment.investmentType?c},
            investmentTypeName:"${investmentTypeName}",
            projectContactID:${fundingInvestment.projectContact?c},
            projectContactName:"${projectContactName}",
            currencyName:"${currencyName}",
            currency:${fundingInvestment.estimatedCostCurrency?c},
            cost:$j.formatNumber(${fundingInvestment.estimatedCost?c}),
            investmentID:${fundingInvestment.investmentID?c},
            approved:"${fundingInvestment.approved?string}",
        approvalStatus:<#if fundingInvestment.approvalStatus??>"${fundingInvestment.approvalStatus?string}"<#else>null</#if>,
            editMode:true
        };
        <#if fundingInvestment.investmentID??>
            data["investmentID"] = ${fundingInvestment.investmentID?c};
        </#if>

        <#--<#if isProjectOwner || user.ID==fundingInvestment.projectContact || isGlobalProjectContactUser || isAdminUser>-->
        <#if  user.ID==fundingInvestment.projectContact || isAdminUser>
            <#if isProposalAwarded?? && isProposalAwarded>
            	data["canModify"] = "false";
            <#else>
            	data["canModify"] = "true";
            </#if>
        <#else>
            data["canModify"] = "false";
        </#if>
        
        <#if  user.ID==fundingInvestment.projectContact || isAdminUser || isAboveMarketProjectContactUser || isProjectOwner || isProjectCreator>
            data["canView"] = "true";
        <#else>
            data["canView"] = "false";
        </#if>
		
		
        <#if isAdminUser>
            data["isAdminUser"] = "true";
        <#else>
            data["isAdminUser"] = "false";
        </#if>

        <#if fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].REGION.getId()>
            <!-- Entry Type REGIONAL -->
            data["regionType"] = ${fundingInvestment.investmentTypeID?c};
            data["regionTypeName"] = "${statics['com.grail.synchro.SynchroGlobal'].getRegions().get(fundingInvestment.investmentTypeID?int)}";
        <#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].AREA.getId()>
            <!-- Entry Type Area -->
            data["areaType"] = ${fundingInvestment.investmentTypeID?c};
            data["areaTypeName"] = "${statics['com.grail.synchro.SynchroGlobal'].getAreas().get(fundingInvestment.investmentTypeID?int)}";
        <#elseif fundingInvestment.investmentType==statics['com.grail.synchro.SynchroGlobal$InvestmentType'].COUNTRY.getId()>
            <!-- Entry Type Country -->
           <#-- <#if user.ID==fundingInvestment.spiContact> -->
           <#-- Fixed as part of QUICK FIX for MM -->
            <#if user.ID==fundingInvestment.spiContact || isAboveMarketProjectContactUser || isProjectOwner || isProjectCreator>
                
                <#if isProposalAwarded?? && isProposalAwarded>
            		data["canModify"] = "false";
            	<#else>
            		data["canModify"] = "true";
            	</#if>
            </#if>
            <#if isAdminUser || user.ID==fundingInvestment.spiContact || user.ID==fundingInvestment.projectContact || isAboveMarketProjectContactUser || isProjectOwner || isProjectCreator>
            	data["canView"] = "true";
            	
            <#else>
            	data["canView"] = "false";
            </#if>
            data['spiContactID'] =  ${fundingInvestment.spiContact?c};
            data['spiContactName'] = "${statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(fundingInvestment.spiContact)}";
            data['fieldworkType'] = ${fundingInvestment.fieldworkMarketID?c};
            data['fieldwork'] = "${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(fundingInvestment.fieldworkMarketID?int)}";
            data['fundingType'] = ${fundingInvestment.fundingMarketID?c};
            data['funding'] = "${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(fundingInvestment.fundingMarketID?int)}";
        </#if>

        showInvestmentDetails(data);
      </#if>
    </#list>
    }

    function validateAddInvestmentLink() {
//        var size = $j('select#endMarkets_pitPopup option').length;
//        if(size > 0) {
//            $j(".project_addfunding_btn").removeAttr("disabled", "disabled");
//        } else {
//            $j(".project_addfunding_btn").attr( "disabled", "disabled" );
//        }
    }
</script>

<div class="view_edit_pib">
    <form id="synchro-pit-form" action="<@s.url value="/synchro/pib-multi-details!updatePIT.jspa"/>" method="post" class="j-form-popup">
        <a href="javascript:void(0);" class="close" onclick="closePITWindow();"></a>
        <div class="pib_view_popup">
            <label>Project Name </label>
        <#if  isAdminUser >
            <input type="text" id="projectName" name="projectName" value="${project.name?html}" />
        <#else>
            <input type="text" id="projectName" name="projectName" value="${project.name?html}" disabled/>
        </#if>
        </div>
    <#--<div class="pib_view_popup">
        <label>Project Description</label>
        <textarea id="description" name="description"  disabled >${project.description?html}</textarea>
    </div>-->
        <label style="float:none;" class="pit-description-label">Project Description</label>
        <div id="descriptionpit-div"></div>
        <div class="pib_view_popup">
            <label class="label_b">Category Type</label>
            <div class="form-select_div_main">
           <#if isProposalAwarded?? && isProposalAwarded>
           		
           		 <@renderAllSelectedCategoryTypeField name='categoryType' value=project.categoryType?default(-1) />
           <#else>
           		<@renderCategoryTypeField name='categoryType' value=project.categoryType?default("1") />
           </#if>
            
				<#assign error_msg><@s.text name='project.error.category' /></#assign>
				<#--<@macroCustomFieldErrors msg=error_msg /> -->
				 <span class="jive-error-message" style="display:none; position:static">${error_msg?html}</span>
            </div>
        </div>

        <div class="pib_band_view">
            <ul>
                <li>
                    <label>Brand/Non-Branded</label>
                <@renderBrandField name='brand' value=project.brand?default('-1') readonly=true />
                </li>
                <li class="popup-view-row-right">
                    <label>Methodology Type</label>
                <@renderMethodologyField name='methodologyType' value=project.methodologyType?default('-1') readonly=true/>
                </li>
                <li>
                    <label>Methodology Group</label>
                <@renderMethodologyGroupField name='methodologyGroup' id="pit" value=project.methodologyGroup?default('-1') readonly=true/>
                </li>

            </ul>

        <#if isAboveMarketProjectContactUser || isProjectOwner || isAdminUser >
            <div class="pib_view_popup">
                <div class="region-inner">
                    <label class="label_b"><@s.text name="project.initiate.project.methodologyproposed"/></label>
                    <div class="form-select_div_main">
                        <#assign defaultPMethodologyID = JiveGlobals.getJiveIntProperty("grail.synchro.default.proposedmethodology", -1) />
						<#if isProposalAwarded?? && isProposalAwarded>
							<@renderProposedMethodologyGroupField name='proposedMethodology' value=defaultPMethodologyID readonly=true/>
						<#else>
							<@renderSelectedProposedMethodologyMultiSelect name='proposedMethodology' methodologyGroup=project.methodologyGroup?default('-1') id="pit" value=project.proposedMethodology?default([defaultPMethodologyID])/>
						</#if>
						<#assign error_msg><@s.text name='project.error.proposedmethodologygroup' /></#assign>
						<#--<@macroCustomFieldErrors msg=error_msg /> -->
						<span class="jive-error-message" style="display:none; position:static">${error_msg?html}</span>
                    </div>
                </div>
            </div>
        <#else>
            <div class="pib_view_popup multi-end-location">
                <label class="label_b"><@s.text name="project.initiate.project.methodologyproposed"/></label>
                <div class="form-select_div_main">
                    <#assign defaultPMethodologyID = JiveGlobals.getJiveIntProperty("grail.synchro.default.proposedmethodology", -1) />
							<@renderProposedMethodologyGroupField name='proposedMethodology' value=defaultPMethodologyID readonly=true/>
            				<#assign error_msg><@s.text name='project.error.proposedmethodologygroup' /></#assign>
            				<@macroCustomFieldErrors msg=error_msg />
                </div>
            </div>

        </#if>
            <div class="pib_view_popup multi-end-location">
                <!-- End Markets Multiselect -->
                <label><@s.text name="project.initiate.endmarkets"/> (Location/Fieldwork):</label>
            <@renderMultiEndMarketField name='updatedSingleMarketId2' value=emIds?default('-1') readonly=true/>
            </div>
            <ul>
                <li>
                    <label>Project Start (Commissioning)</label>
                    <input type="text"  name="sd" value="${project.startDate?string('dd/MM/yyyy')}" disabled />
                </li>
                <li class="popup-view-row-right">
                    <label>Project End (Results)</label>
                    <input type="text" name="ed" value="${project.endDate?string('dd/MM/yyyy')}" disabled />
                </li>
            </ul>

            <ul>
                <li>
                    <label>Above Market SP&I Contact</label>
                    <input type="text"  name="pouname" value="${ownerUserName}" disabled />
                </li>
            </ul>
            <ul>
                <li>
                <#if statics['com.grail.synchro.SynchroGlobal'].getProjectTypes().containsKey(project.capRating?int)>
                    <#assign capRatingType = statics['com.grail.synchro.SynchroGlobal'].getProjectTypes().get(project.capRating?int) />
                <#else>
                    <#assign capRatingType = 'None' />
                </#if>
                    <label><@s.text name="project.initiate.project.caprating"/></label>
                    <input type="text"  name="capRating" value="${capRatingType}" disabled />
                </li>
            </ul>



            <ul class="pib_initial_div">
                <li class="last">
                    
                <#if  isAdminUser >
                    <label>Total Cost</label>
                    <input type="text" id="totalCost" name="totalCost" <#if project.totalCost?? > value="${project.totalCost?c}" <#else>value=""</#if> size="30" class="form-text-div numericfieldpib numericformat longField">
                    <@renderCurrenciesField name='totalCostCurrency' value=project.totalCostCurrency?default(defaultCurrency) disabled=false/>
                    <br/><br/>
                    <@macroCustomFieldErrors msg='' class='numeric-error' />
                <#elseif isAboveMarketProjectContactUser || isProjectOwner || isProjectCreator>
                	<label>Total Cost</label>
	                <#if projectInitiation.status?? && projectInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PIB_COMPLETED.ordinal() >
	                    <input type="text" name="totalCost" <#if project.totalCost?? > value="${project.totalCost?c}" <#else>value=""</#if> size="30" disabled class="form-text-div">
	                    <@renderCurrenciesField name='totalCostType' value=project.totalCostCurrency?default(defaultCurrency) disabled=true/>
	                <#elseif !(isAboveMarketProjectContactUser || isProjectOwner ) >
	                    <input type="text" name="totalCost" <#if project.totalCost?? > value="${project.totalCost?c}" <#else>value=""</#if>  size="30" disabled class="form-text-div">
	                    <@renderCurrenciesField name='totalCostType' value=project.totalCostCurrency?default(defaultCurrency) disabled=true/>
	                <#else>
	                    <input type="text" id="totalCost" name="totalCost" <#if project.totalCost?? > value="${project.totalCost?c}" <#else>value=""</#if>  size="30" class="form-text-div numericfieldpib numericformat longField">
	                    <@renderCurrenciesField name='totalCostCurrency' value=project.totalCostCurrency?default(defaultCurrency) disabled=false/>
	                    <br/><br/>
	                    <@macroCustomFieldErrors msg='' class='numeric-error' />
	                </#if>
				</#if>
                </li>
            </ul>
            <ul>
                <li>
                  <#--<#assign allowPITSave = false/>-->
                <#if allowPITSave?? && allowPITSave>
                    <@projectBudgetYearField name="budgetYear" value=project.budgetYear/>
                <#else>
                    <@projectBudgetYearField name="budgetYear" value=project.budgetYear readonly=true/>
                </#if>

                </li>
            </ul>
            <ul>
                <li>
                    <label>Confidential Project</label>
                    <#if isProposalAwarded?? && isProposalAwarded>
                    	<div class="inner_div confidential-radio-btn">
	                        <input type="radio" id="confidential1" disabled name="confidential" value="1" <#if project.confidential?? && project.confidential == true>checked="true"</#if>>
	                        <span>Yes</span>
	                        <input type="radio" id="confidential2" disabled name="confidential" value="0" <#if project.confidential?? && project.confidential == false>checked="true"</#if>>
	                        <span>No</span>
                    	</div>
                    <#else>
	                    <div class="inner_div confidential-radio-btn">
	                        <input type="radio" id="confidential1" name="confidential" value="1" <#if project.confidential?? && project.confidential == true>checked="true"</#if>>
	                        <span>Yes</span>
	                        <input type="radio" id="confidential2" name="confidential" value="0" <#if project.confidential?? && project.confidential == false>checked="true"</#if>>
	                        <span>No</span>
	                    </div>
	                </#if>
                </li>
            </ul>

            <div class="add-investment-button">
            <#if isAboveMarketProjectContactUser || isProjectOwner  || isAdminUser >
                <#if isProposalAwarded?? && isProposalAwarded>
                <#else>
                	<input  type="button" class="project_addfunding_btn" onclick="openAddInvestmentDetails();" value="<@s.text name='project.initiate.project.addfund.label'/>" />
                </#if>
            </#if>
            </div>
        <#include "/template/global/include/investment-funding.ftl" />
        <#assign isBudgetApprover = statics['com.grail.synchro.util.SynchroPermHelper'].isBudgetApprover(project.projectID) />


        <#if  isAdminUser >
            <div class="region-inner-pib">
                <input class="j-btn-callout" type="submit" name="doPost" id="postButton" onclick="return savePIT();" value="Save" style="font-weight: bold;" />

                <ul class="right-sidebar-list">
                </ul>
            </div>
        <#elseif projectInitiation.status?? && projectInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PIB_COMPLETED.ordinal() && !isBudgetApprover>
        <#else>
            <div class="region-inner-pib">
                <#if isProposalAwarded?? && isProposalAwarded>
                <#else>
                	<input class="j-btn-callout" type="submit" name="doPost" id="postButton" onclick="return savePIT();" value="Save" style="font-weight: bold;" />
                </#if>

                <ul class="right-sidebar-list">
                    <!-- Commented by Bhaskar -->
                <#--<li><a  href="javascript:void(0);"  onclick="javascript:exportToPDFPIT(${projectID?c});">Export To PDF</a></li>-->
                </ul>
            </div>
        </#if>
        </div>
    <#--<div class="style:hidden" id="append-investment-div">-->
    <#--</div>-->
        <input type="hidden" name="projectID" value="${projectID?c}">
        <input type="hidden" name="endMarketId" value="${endMarketId?c}">

    </form>
</div>
</div>
<!-- PIT WINDOW ENDS -->

</div>
<!-- SYNCHRO ENDS -->
</div>

<form method="POST" enctype="multipart/form-data" action="/synchro/generate-pdf.jspa" id="pdf_img_screen_form">
    <input type="hidden" name="pdfImageDataURL" id="pdf_img_screen" value="" />
    <input type="hidden" name="projectId" id="projectId" value="${projectID?c}" />
    <input type="hidden" name="pdfFileName" id="pdfFileName" value="" />
    <input type="hidden" name="redirectURL" id="redirectURL" value="" />
    <input type="hidden" id="report-token" name="token" value="pib-token-${user.ID?c}" />
    <input type="hidden" id="report-token-cookie" name="tokenCookie" value="pdfcookie" />
</form>

</div>
<script type="text/javascript">
$j(document).ready(function() {
    handleUserPickers();
    handleAgencyContactSelection();

    /*Load start and end dates*/
    var _startDate = "${project.startDate?string('dd/MM/yyyy')}";

    var _endDate = "${project.endDate?string('dd/MM/yyyy')}";
    $j("#startDate").val(_startDate);
    $j("#endDate").val(_endDate);
<#if projectInitiation.stimuliDate??>
    var _stimuliDate = "${projectInitiation.stimuliDate?string('dd/MM/yyyy')}";
    $j("#stimuliDate").val(_stimuliDate);
</#if>

<#if !(projectInitiation.deviationFromSM?? && projectInitiation.deviationFromSM==1) >
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

        var agencyContact2 = $j("input[name=agencyContact2]");
        var agencyContact3 = $j("input[name=agencyContact3]");

        var agencyContact2Optional = $j("input[name=agencyContact2Optional]");
        var agencyContact3Optional = $j("input[name=agencyContact3Optional]");

        var agencyContact1 = undefined;
        var agencyContact1Optional = undefined;
    <#if projectInitiation.nonKantar?? && projectInitiation.nonKantar==2>
        agencyContact1 = $j("input[name=agencyUserBATContact1]");
        agencyContact1Optional = $j("input[name=agencyUserBATContact1Optional]");
    <#else>
        agencyContact1 = $j("input[name=agencyContact1]");
        agencyContact1Optional = $j("input[name=agencyContact1Optional]");
    </#if>


        if(businessDescription.val() != null && $j.trim(businessDescription.val())=="")
        {
            //   businessDescription.focus();
        <#if attachmentMap?? && attachmentMap.get(bussinessQuestionID)?? >
        <#else>
            businessDescription.next().show();
            error = true;
        </#if>
        }



        if(latestEstimate.val() != null && $j.trim(latestEstimate.val())=="")
        {
            //    latestEstimate.focus();
            latestEstimate.parent().find("span:first").show();
            error = true;
        }


        if(researchObjective.val() != null && $j.trim(researchObjective.val())=="")
        {
            //   researchObjective.focus();
        <#if attachmentMap?? && attachmentMap.get(researchObjectiveID)?? >
        <#else>
            researchObjective.next().show();
            error = true;
        </#if>
        }
        if(actionStandard.val() != null && $j.trim(actionStandard.val())=="")
        {
            //   actionStandard.focus();
        <#if attachmentMap?? && attachmentMap.get(actionStandardID)?? >
        <#else>
            actionStandard.next().show();
            error = true;
        </#if>
        }
        if(researchDesign.val() != null && $j.trim(researchDesign.val())=="")
        {
            //    researchDesign.focus();
        <#if attachmentMap?? && attachmentMap.get(researchDesignID)?? >
        <#else>
            researchDesign.next().show();
            error = true;
        </#if>
        }
        if(sampleProfile.val() != null && $j.trim(sampleProfile.val())=="")
        {
            //   sampleProfile.focus();
        <#if attachmentMap?? && attachmentMap.get(sampleProfileID)?? >
        <#else>
            sampleProfile.next().show();
            error = true;
        </#if>
        }
        if(stimulusMaterial.val() != null && $j.trim(stimulusMaterial.val())=="")
        {
            //   stimulusMaterial.focus();
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
            //   $j("#topLinePresentation_display").focus();
            $j(".pib-report-requirement").find("span").show();
            error = true;
        }

        var stimuliDate = $j("input[name=stimuliDate]");
        if($j.trim(stimuliDate.val())=="")
        {
            //	stimuliDate.focus();
            stimuliDate.parent().find("span").show();
            stimuliDate.parent().find("span").text("Please enter Stimuli Date");
            error = true;
        }
        if(globalLegalContact.val() != null && $j.trim(globalLegalContact.val())=="")
        {

            globalLegalContactError.show();
            error = true;

        }
        console.log("====")
        console.log(agencyContact1)
        if((agencyContact1.val() == undefined || $j.trim(agencyContact1.val())=="" || Number($j.trim(agencyContact1.val())) == 0)
                && (agencyContact1Optional.val() == undefined || $j.trim(agencyContact1Optional.val())==""  || Number($j.trim(agencyContact1Optional.val())) == 0))
        {

            $j("#agencyContactError").show();
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
        
        <#if projectInitiation.nonKantar?? && projectInitiation.nonKantar==0 && isAboveMarket>
			var nonKantarError = $j("#nonKantarError");
			nonKantarError.show();
			error = true;
		</#if>
        return error;
    }

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
    
     $j("#kantar-send-for-approval").click(function() {
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
        showLoader('Please wait...');
        setKantarMethodologyWaiverReqMoreInfo();
        var form = $j("#kantar-waiver-form");
        form.submit();
    });
    $j("#kantar-approve-waiver-btn").click(function() {
        showLoader('Please wait...');
        setKantarMethodologyWaiverApprove();
        var form = $j("#kantar-waiver-form");
        form.submit();
    });
    $j("#kantar-reject-waiver-btn").click(function() {
        showLoader('Please wait...');
        setKantarMethodologyWaiverReject();
        var form = $j("#kantar-waiver-form");
        form.submit();
    });

    /** Change EndMarket onsubmit handler**/
    $j( "#update-end-markets-form" ).submit(function( event ) {
        showLoader('Please wait...');
        $j( ".jive-error-message" ).each(function( index ) {
            if(!$j(this).hasClass('numeric-error'))
            {
                $j(this).hide();
            }
        });

        var endMarkets = $j("#updatedEndMarkets");
        var endMarketsSize = $j("#updatedEndMarkets option").size();
        if(endMarketsSize < 1)
        {
            endMarkets.next().show();
            endMarkets.focus();
            hideLoader();
            return false;
        }

        $j('#updatedEndMarkets option').attr('selected', 'selected');

    });

    $j("input[id^=amendmentPostButton]").click(function( event ) {
        showLoader('Please wait...');
        $j( ".jive-error-message" ).each(function( index ) {
            if(!$j(this).hasClass('numeric-error'))
            {
                $j(this).hide();
            }
        });

        var $form = $j(this).closest('form');
        var textComment = $form.find('textarea');
        if($j.trim(textComment.val())=='')
        {
            textComment.next().show();
            hideLoader();
            return;
        }
        $form.submit();
    });

    $j("#descriptionpit-div").html($j("#description").text());

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

   <#-- initializeUserPicker({$input:$j("#projectOwner"),name:'projectOwner',value:projectOwner,defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});-->
    initializeUserPicker({$input:$j("#projectOwner"),name:'projectOwner',defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});

<#if isReference && project.projectOwner??>
    $j('input[name=projectOwner]').val("${project.projectOwner?c}");
    <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner) />
    $j("#projectOwner").val("${userDisplayName}");
    <#assign isReference = false />
</#if>


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


    var agencyContact1 = -1;

<#if pibStakeholderList?? && pibStakeholderList.agencyContact1?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(pibStakeholderList.agencyContact1)>
    agencyContact1 = ${pibStakeholderList.agencyContact1?c};
<#else>
    <#assign isReference = true />
    agencyContact1 = -1;
</#if>
      
    <#-- initializeUserPicker({$input:$j("#agencyContact1"),name:'agencyContact1',value:agencyContact1,
        defaultFilters:{'role':21,'roleEnabled':false, 'hideInvite':true}});
    initializeUserPicker({$input:$j("#agencyUserBATContact1"),name:'agencyUserBATContact1',value:agencyContact1,defaultFilters:{'role':21, 'roleEnabled':true, 'hideInvite':true, 'ownerfield': true}});-->
	
	 initializeUserPicker({$input:$j("#agencyContact1"),name:'agencyContact1',
        defaultFilters:{'role':21,'roleEnabled':false, 'hideInvite':true}});
    initializeUserPicker({$input:$j("#agencyUserBATContact1"),name:'agencyUserBATContact1',defaultFilters:{'role':21, 'roleEnabled':true, 'hideInvite':true, 'ownerfield': true}});

<#if isReference && pibStakeholderList?? && pibStakeholderList.agencyContact1??>
    $j('input[name=agencyContact1]').val("${pibStakeholderList.agencyContact1?c}");
    <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact1) />
    $j("#agencyContact1").val("${userDisplayName}");
    <#assign isReference = false />
</#if>

    var agencyContact1Optional = -1;

<#if pibStakeholderList?? && pibStakeholderList.agencyContact1Optional?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(pibStakeholderList.agencyContact1Optional)>
    agencyContact1Optional = ${pibStakeholderList.agencyContact1Optional?c};
<#else>
    <#assign isReference = true />
    agencyContact1Optional = -1;
</#if>

   <#-- initializeUserPicker({$input:$j("#agencyContact1Optional"),name:'agencyContact1Optional',value:agencyContact1Optional,
        defaultFilters:{'role':21,'roleEnabled':false, 'hideInvite':true}});
    initializeUserPicker({$input:$j("#agencyUserBATContact1Optional"),name:'agencyUserBATContact1Optional',value:agencyContact1Optional,defaultFilters:{'role':21, 'roleEnabled':true, 'hideInvite':true, 'ownerfield': true}});-->
	
	 initializeUserPicker({$input:$j("#agencyContact1Optional"),name:'agencyContact1Optional',defaultFilters:{'role':21,'roleEnabled':false, 'hideInvite':true}});
    initializeUserPicker({$input:$j("#agencyUserBATContact1Optional"),name:'agencyUserBATContact1Optional',defaultFilters:{'role':21, 'roleEnabled':true, 'hideInvite':true, 'ownerfield': true}});

<#if isReference && pibStakeholderList?? && pibStakeholderList.agencyContact1Optional??>
    $j('input[name=agencyContact1Optional]').val("${pibStakeholderList.agencyContact1Optional?c}");
    <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact1Optional) />
    $j("#agencyContact1Optional").val("${userDisplayName}");
    <#assign isReference = false />
</#if>

    var agencyContact2 = -1;

<#if pibStakeholderList?? && pibStakeholderList.agencyContact2?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(pibStakeholderList.agencyContact2)>
    agencyContact2 = ${pibStakeholderList.agencyContact2?c};
<#else>
    <#assign isReference = true />
    agencyContact2 = -1;
</#if>

   <#-- initializeUserPicker({$input:$j("#agencyContact2"),name:'agencyContact2',value:agencyContact2,
        defaultFilters:{'role':6,'roleEnabled':false, 'hideInvite':true}}); -->
		
    initializeUserPicker({$input:$j("#agencyContact2"),name:'agencyContact2', defaultFilters:{'role':6,'roleEnabled':false, 'hideInvite':true}});

<#if isReference && pibStakeholderList?? && pibStakeholderList.agencyContact2??>
    $j('input[name=agencyContact2]').val("${pibStakeholderList.agencyContact2?c}");
    <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact2) />
    $j("#agencyContact2").val("${userDisplayName}");
    <#assign isReference = false />
</#if>


    var agencyContact2Optional = -1;

<#if pibStakeholderList?? && pibStakeholderList.agencyContact2Optional?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(pibStakeholderList.agencyContact2Optional)>
    agencyContact2Optional = ${pibStakeholderList.agencyContact2Optional?c};
<#else>
    <#assign isReference = true />
    agencyContact2Optional = -1;
</#if>

    <#--initializeUserPicker({$input:$j("#agencyContact2Optional"),name:'agencyContact2Optional',value:agencyContact2Optional,
        defaultFilters:{'role':6,'roleEnabled':false, 'hideInvite':true}}); -->
	initializeUserPicker({$input:$j("#agencyContact2Optional"),name:'agencyContact2Optional', defaultFilters:{'role':6,'roleEnabled':false, 'hideInvite':true}});

<#if isReference && pibStakeholderList?? && pibStakeholderList.agencyContact2Optional??>
    $j('input[name=agencyContact2Optional]').val("${pibStakeholderList.agencyContact2Optional?c}");
    <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact2Optional) />
    $j("#agencyContact2Optional").val("${userDisplayName}");
    <#assign isReference = false />

</#if>
    var agencyContact3 = -1;
<#if pibStakeholderList?? && pibStakeholderList.agencyContact3?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(pibStakeholderList.agencyContact3)>
    agencyContact3 = ${pibStakeholderList.agencyContact3?c};
<#else>
    <#assign isReference = true />
    agencyContact3 = -1;
</#if>
    <#--initializeUserPicker({$input:$j("#agencyContact3"),name:'agencyContact3',value:agencyContact3,
        defaultFilters:{'role':6,'roleEnabled':false, 'hideInvite':true}});
		-->
	initializeUserPicker({$input:$j("#agencyContact3"),name:'agencyContact3',defaultFilters:{'role':6,'roleEnabled':false, 'hideInvite':true}});	

<#if isReference && pibStakeholderList?? && pibStakeholderList.agencyContact3??>
    $j('input[name=agencyContact3]').val("${pibStakeholderList.agencyContact3?c}");
    <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact3) />
    $j("#agencyContact3").val("${userDisplayName}");
    <#assign isReference = false />
</#if>


    var agencyContact3Optional = -1;

<#if pibStakeholderList?? && pibStakeholderList.agencyContact3Optional?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(pibStakeholderList.agencyContact3Optional)>
    agencyContact3Optional = ${pibStakeholderList.agencyContact3Optional?c};
<#else>
    <#assign isReference = true />
    agencyContact3Optional = -1;
</#if>

    <#--initializeUserPicker({$input:$j("#agencyContact3Optional"),name:'agencyContact3Optional',value:agencyContact3Optional,
        defaultFilters:{'role':6,'roleEnabled':false, 'hideInvite':true}});-->
	initializeUserPicker({$input:$j("#agencyContact3Optional"),name:'agencyContact3Optional',
        defaultFilters:{'role':6,'roleEnabled':false, 'hideInvite':true}});

<#if isReference && pibStakeholderList?? && pibStakeholderList.agencyContact3Optional??>
    $j('input[name=agencyContact3Optional]').val("${pibStakeholderList.agencyContact3Optional?c}");
    <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.agencyContact3Optional) />
    $j("#agencyContact3Optional").val("${userDisplayName}");
    <#assign isReference = false />
</#if>


    var globalLegalContact = -1;
<#if pibStakeholderList?? && pibStakeholderList.globalLegalContact?? && pibStakeholderList.agencyContact3?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(pibStakeholderList.globalLegalContact)>
    globalLegalContact = ${pibStakeholderList.globalLegalContact?c};
<#else>
    <#assign isReference = true />
    globalLegalContact = -1;
</#if>
    <#--initializeUserPicker({$input:$j("#globalLegalContact"),name:'globalLegalContact',value:globalLegalContact,
        defaultFilters:{'role':4,'roleEnabled':false}});-->
	
	initializeUserPicker({$input:$j("#globalLegalContact"),name:'globalLegalContact',
        defaultFilters:{'role':4,'roleEnabled':false}});

<#if isReference && pibStakeholderList?? && pibStakeholderList.globalLegalContact??>
    $j('input[name=globalLegalContact]').val("${pibStakeholderList.globalLegalContact?c}");
    <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.globalLegalContact) />
    $j("#globalLegalContact").val("${userDisplayName}");
    <#assign isReference = false />
</#if>


    var globalProcurementContact = -1;
<#if pibStakeholderList?? && pibStakeholderList.globalProcurementContact?? && pibStakeholderList.globalProcurementContact?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(pibStakeholderList.globalProcurementContact)>
    globalProcurementContact = ${pibStakeholderList.globalProcurementContact?c};
<#else>
    <#assign isReference = true />
    globalProcurementContact = -1;
</#if>

    <#--initializeUserPicker({$input:$j("#globalProcurementContact"),name:'globalProcurementContact',value:globalProcurementContact,
        defaultFilters:{'role':5,'roleEnabled':false}});-->
	initializeUserPicker({$input:$j("#globalProcurementContact"),name:'globalProcurementContact',
        defaultFilters:{'role':5,'roleEnabled':false}});

<#if isReference && pibStakeholderList?? && pibStakeholderList.globalProcurementContact??>
    $j('input[name=globalProcurementContact]').val("${pibStakeholderList.globalProcurementContact?c}");
    <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.globalProcurementContact) />
    $j("#globalProcurementContact").val("${userDisplayName}");
    <#assign isReference = false />
</#if>


    var globalCommunicationAgency = -1;
<#if pibStakeholderList?? && pibStakeholderList.globalCommunicationAgency?? && pibStakeholderList.globalCommunicationAgency?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(pibStakeholderList.globalCommunicationAgency)>
    globalCommunicationAgency = ${pibStakeholderList.globalCommunicationAgency?c};
<#else>
    <#assign isReference = true />
    globalCommunicationAgency = -1;
</#if>

    <#--initializeUserPicker({$input:$j("#globalCommunicationAgency"),name:'globalCommunicationAgency',value:globalCommunicationAgency,
        defaultFilters:{'role':7,'roleEnabled':false}});-->
	initializeUserPicker({$input:$j("#globalCommunicationAgency"),name:'globalCommunicationAgency',
        defaultFilters:{'role':7,'roleEnabled':false}});

<#if isReference && pibStakeholderList?? && pibStakeholderList.globalCommunicationAgency??>
    $j('input[name=globalCommunicationAgency]').val("${pibStakeholderList.globalCommunicationAgency?c}");
    <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.globalCommunicationAgency) />
    $j("#globalCommunicationAgency").val("${userDisplayName}");
    <#assign isReference = false />
</#if>

    var productContact = -1;
<#if pibStakeholderList?? && pibStakeholderList.productContact?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(pibStakeholderList.productContact)>
    productContact = ${pibStakeholderList.productContact?c};
<#else>
    <#assign isReference = true />
    productContact = -1;
</#if>
    <#--initializeUserPicker({$input:$j("#productContact"),name:'productContact',value:productContact,
        defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});-->
	initializeUserPicker({$input:$j("#productContact"),name:'productContact',defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});

<#if isReference && pibStakeholderList?? && pibStakeholderList.productContact??>
    $j('input[name=productContact]').val("${pibStakeholderList.productContact?c}");
    <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(pibStakeholderList.productContact) />
    $j("#productContact").val("${userDisplayName}");
    <#assign isReference = false />
</#if>

}

function handleAgencyContactSelection() {
    enableDisableOptionalAgencyContacts();
    $j("input[type=hidden][name=agencyContact1],input[type=hidden][name=agencyContact2],input[type=hidden][name=agencyContact3],input[type=hidden][name=agencyContact1Optional],input[type=hidden][name=agencyContact2Optional],input[type=hidden][name=agencyContact3Optional]")
            .bind("userUpdated",function(){
                enableDisableOptionalAgencyContacts();
            });
}

function enableDisableOptionalAgencyContacts() {
    var acontact1 = $j("input[type=hidden][name=agencyContact1]").val();
    var acontact2 = $j("input[type=hidden][name=agencyContact2]").val();
    var acontact3 = $j("input[type=hidden][name=agencyContact3]").val();

    var acontact1Optional = $j("input[type=hidden][name=agencyContact1Optional]").val();
    var acontact2Optional = $j("input[type=hidden][name=agencyContact2Optional]").val();
    var acontact3Optional = $j("input[type=hidden][name=agencyContact3Optional]").val();


    if(acontact1 && acontact2) {

        $j("#agencyContact2").removeAttr("disabled");
        $j("#agencyContact2").css("background-color","");
        $j("#agencyContact2").next().show();

        $j("#agencyContact2Optional").removeAttr("disabled");
        $j("#agencyContact2Optional").css("background-color","");
        $j("#agencyContact2Optional").next().show();

        $j("#agencyContact3").removeAttr("disabled");
        $j("#agencyContact3").css("background-color","");
        $j("#agencyContact3").next().show();

        $j("#agencyContact3Optional").removeAttr("disabled");
        $j("#agencyContact3Optional").css("background-color","");
        $j("#agencyContact3Optional").next().show();

    } else if(acontact1) {
        $j("#agencyContact2").removeAttr("disabled");
        $j("#agencyContact2").next().show();
        $j("#agencyContact2").css("background-color","");

        $j("#agencyContact1Optional").removeAttr("disabled");
        $j("#agencyContact1Optional").next().show();
        $j("#agencyContact1Optional").css("background-color","");

        $j("#agencyContact3").attr("disabled",true);
        $j("#agencyContact3").css("background-color","#ECECEC");
        $j("#agencyContact3").next().hide();
    } else {
        $j("#agencyContact2").attr("disabled",true);
        $j("#agencyContact2").css("background-color","#ECECEC");
        $j("#agencyContact2").next().hide();

        $j("#agencyContact2Optional").attr("disabled",true);
        $j("#agencyContact2Optional").css("background-color","#ECECEC");
        $j("#agencyContact2Optional").next().hide();

        $j("#agencyContact3").attr("disabled",true);
        $j("#agencyContact3").css("background-color","#ECECEC");
        $j("#agencyContact3").next().hide();

        $j("#agencyContact3Optional").attr("disabled",true);
        $j("#agencyContact3Optional").css("background-color","#ECECEC");
        $j("#agencyContact3Optional").next().hide();
    }

}


/*Code to track read status of the document for current user and project */
<#assign effectiveUser = statics['com.grail.synchro.util.SynchroPermHelper'].getEffectiveUser() />


function validatePIBFormFields()
{
    showLoader('Please wait...');
    var error = false;

    /** Code to be placed before hiding all previous error messages **/
    /*Check of there is numeric field error before submitting*/

    $j(".numericfieldpib").each(function(){
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

    var businessDescription = $j("textarea[name=bizQuestion]");
    var researchObjective = $j("textarea[name=researchObjective]");
    var actionStandard = $j("textarea[name=actionStandard]");
    var researchDesign = $j("textarea[name=researchDesign]");
    var sampleProfile = $j("textarea[name=sampleProfile]");
    var stimulusMaterial = $j("textarea[name=stimulusMaterial]");
    var others = $j("textarea[name=others]");
    var otherReportingRequirements = $j("textarea[name=otherReportingRequirements]");
    var agencyContact2 = $j("input[name=agencyContact2]");
    var agencyContact3 = $j("input[name=agencyContact3]");

    var agencyContact2Optional = $j("input[name=agencyContact2Optional]");
    var agencyContact3Optional = $j("input[name=agencyContact3Optional]");

    var agencyContact1 = undefined;
    var agencyContact1Optional = undefined;
    if($j("input[name=kantar]").is(":checked")) {
        agencyContact1 = $j("input[name=agencyContact1]");
        agencyContact1Optional = $j("input[name=agencyContact1Optional]");
    } else if($j("input[name=nonKantar]").is(":checked")) {
        agencyContact1 = $j("input[name=agencyUserBATContact1]");
        agencyContact1Optional = $j("input[name=agencyUserBATContact1Optional]");
    }
//    var agencyContact1Ori = $j("input[name=agencyContact1Ori]");
//    var agencyContact2Ori = $j("input[name=agencyContact2Ori]");
//    var agencyContact3Ori = $j("input[name=agencyContact3Ori]");
    var latestEstimate = $j("input[name=latestEstimate-display]");
    var latestEstimateType = $j("#latestEstimateType");
    var globalLegalContact = $j("input[name=globalLegalContact]");

    /**.
     ** Please add validations in same sequence as in the PIB form. This helps in focus at top most error while validating the form during submit/save
     **/

    /*Project latest estimate check starts*/
    /*
    if(latestEstimate.val() != null && $j.trim(latestEstimate.val())=="")
    {
        if(!error)
            latestEstimate.focus();
        latestEstimate.parent().find("span:first").show();
        error = true;
    }
	*/
    if(latestEstimate.val() != null && $j.trim(latestEstimate.val())!="" && latestEstimateType.val()!= null && latestEstimateType.val()==-1)
    {
        if(!latestEstimate.parent().find("span:first").is(":visible"))
        {
            latestEstimate.parent().find("p").show();
        }
        if(!error)
        {
            latestEstimateType.focus();
        }
        error = true;
    }

    /*Project latest estimate check ends*/


    /*Project Start and End Dates check*/
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
        startDate.parent().parent().find("span").text("Project start date should be in dd/mm/yyyy format");
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
        endDate.parent().parent().find("span").text("Project end date should be in dd/mm/yyyy format");
        error = true;
    }

    if(isDateformat(startDate.val()) && isDateformat(endDate.val()) && !compareDate(startDate.val(), endDate.val()))
    {
        if(!error)
            startDate.focus();
        startDate.parent().parent().find("span").show();
        startDate.parent().parent().find("span").text("Project start date should be less than end date");
        error = true;
    }
    /*Project Start and End Dates check ends*/

    /* Starts : Validation of Text fields*/
    /*
    if(businessDescription.val() != null && $j.trim(businessDescription.val())=="")
    {
        if(!error)
            businessDescription.focus();
        error = true;
        businessDescription.next().show();

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
    /* Ends : Validation of Text fields*/

    /* Stimuli Date check */
    //TODO Validation is not required when date is entered via calender only
    /* var stimuliDate = $j("input[name=stimuliDate]");
    if($j.trim(stimuliDate.val())!="" && !isDateformat(stimuliDate.val()))
    {
		if(!error)
			stimuliDate.focus();
        stimuliDate.parent().find("span").show();
        stimuliDate.parent().find("span").text("Project start date should be in dd/mm/yyyy format");
        error = true;
    }
	*/
    /* Stimuli Date check ends*/

    /* Validations for reporting requirement*/

    /*
    var reportRequirementSelected = false;
    $j(".pib-report-requirement").find('input[type="checkbox"]:checked').each(function(){
        reportRequirementSelected = true;
    });

    if(!reportRequirementSelected)
    {
        if(!error)
            $j("#topLinePresentation_display").focus();
        error = true;
        $j(".pib-report-requirement").find("span").show();
    }
    if(otherReportingRequirements.val() != null && $j.trim(otherReportingRequirements.val())=="")
    {
        if(!error)
            otherReportingRequirements.focus();
        error = true;
        otherReportingRequirements.next().show();
    }
    */
    /* Validations for reporting requirement ends*/
    var agencyContactError = $j("#agencyContactError");
    /* if(agencyContact1.val() != null && $j.trim(agencyContact1.val())=="" && agencyContact2.val() != null && $j.trim(agencyContact2.val())=="" && agencyContact3.val() != null && $j.trim(agencyContact3.val())=="")
    {
        if(agencyContact1.val()==undefined && agencyContact2.val()==undefined && agencyContact3.val()==undefined)
        {
            error = true;
            agencyContactError.text("Please select atleast one Agency");
            agencyContactError.show();

        }
        if(agencyContact1.val() != null && $j.trim(agencyContact1.val())=="" && agencyContact2.val() != null && $j.trim(agencyContact2.val())=="" && agencyContact3.val() != null && $j.trim(agencyContact3.val())=="")
        {
            error = true;
            agencyContactError.text("Please select atleast one Agency");
            agencyContactError.show();
        }
    }*/
    var duplicateAgency = false;
    if(agencyContact1.val() != undefined && agencyContact1Optional.val() != undefined
            && $j.trim(agencyContact1.val()) != "" && $j.trim(agencyContact1Optional.val()) != ""
            && agencyContact1.val() == agencyContact1Optional.val()) {
        duplicateAgency = true;
    }
//    if(agencyContact1.val()!=undefined && agencyContact2.val()!=undefined && agencyContact1.val()==agencyContact2.val() && agencyContact2.val()!="")
//    {
//        duplicateAgency = true;
//    }
//    else if(agencyContact1.val()!=undefined && agencyContact3.val()!= undefined && agencyContact1.val()==agencyContact3.val() && agencyContact1.val()!="")
//    {
//        duplicateAgency = true;
//    }
//    else if(agencyContact2.val()!=undefined && agencyContact3.val()!= undefined && agencyContact2.val()==agencyContact3.val() && agencyContact2.val()!="")
//    {
//        duplicateAgency = true;
//    }
//    else if(agencyContact1.val()!=undefined && agencyContact1Optional.val()!= undefined && agencyContact1.val()==agencyContact1Optional.val() && agencyContact1Optional.val()!="")
//    {
//        duplicateAgency = true;
//    }
//    else if(agencyContact2.val()!=undefined && agencyContact2Optional.val()!= undefined && agencyContact2.val()==agencyContact1Optional.val() && agencyContact2Optional.val()!="")
//    {
//        duplicateAgency = true;
//    }
//    else if(agencyContact3.val()!=undefined && agencyContact3Optional.val()!= undefined && agencyContact3.val()==agencyContact3Optional.val() && agencyContact3Optional.val()!="")
//    {
//        duplicateAgency = true;
//    }

    if(duplicateAgency)
    {
        error = true;
        $j("#agencyContactError").html("Please select different agencies");
        $j("#agencyContactError").show();
    }
    /*   if(globalLegalContact.val() != null && $j.trim(globalLegalContact.val())=="")
    {
        error = true;
        globalLegalContactError.show();
       
    }*/

    if(!error)
    {
        $j("input[name=latestEstimate]").val($j("input[name=latestEstimate-display]").val().replace(/\,/g, ''));
        $j("input[name=fieldworkCost]").val($j("input[name=fieldworkCost-display]").val().replace(/\,/g, ''));
    }



    if(error)
        hideLoader();

    return !error;
}

$j("#startDate").click(function() {
    $j("#startDate_button").click();
});
$j("#endDate").click(function() {
    $j("#endDate_button").click();
});

$j("#stimuliDate").click(function() {
    $j("#stimuliDate_button").click();
});

/*Brand ID - Name MAP*/
var brandFieldMap = {};
<#assign brandsMap = statics['com.grail.synchro.SynchroGlobal'].getBrands() />
<#list brandsMap.keySet() as brandMap>
brandFieldMap[${brandMap}] = "${brandsMap.get(brandMap)}";
</#list>

/* EndMarket-Region Mapping */
var endMarketRegionMap = {};
<#assign endMarketRegionMap = statics['com.grail.synchro.SynchroGlobal'].getEndMarketRegionMap() />
<#list endMarketRegionMap.keySet() as endMarketRegionMapKey>
endMarketRegionMap[${endMarketRegionMapKey}] = "${endMarketRegionMap.get(endMarketRegionMapKey)}";
</#list>


/* EndMarket-Area Mapping */
var endMarketAreaMap = {};
<#assign endMarketAreaMap = statics['com.grail.synchro.SynchroGlobal'].getEndMarketAreaMap() />
<#list endMarketAreaMap.keySet() as endMarketAreaMapKey>
endMarketAreaMap[${endMarketAreaMapKey}] = "${endMarketAreaMap.get(endMarketAreaMapKey)}";
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
<#if project?? && project.proposedMethodology?? && (project.proposedMethodology?size>0)>
    <#assign selectedProposedMethObjList = project.proposedMethodology />
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

/*Code to track read status
of the document for current user and project */
ProjectReadTracker.setReadTrackInfo(${projectID?c}, ${user.ID?c}, 1);

var userID = ${user.ID?c};

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
	
	<!-- Audit Logs -->
	<#if !(pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.methodologyApprover??)>
		<#assign kantarBtnClickText><@s.text name="logger.project.kantar.btn.click" /></#assign>
		var projName = "${project.name?js_string}";
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].ADD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PIB.getId()}, "${kantarBtnClickText}", projName, ${projectID?c}, ${user.ID?c});
	</#if>
}


/* Initialization of Editor */
$j(document).ready(function () {
    initiateRTE('description', 1500, true);
    initiateRTE('bizQuestion', 900, true);
    initiateRTE('researchObjective', 900, true);
    initiateRTE('actionStandard', 900, true);
    initiateRTE('sampleProfile', 900, true);
    initiateRTE('stimulusMaterial', 900, true);
    initiateRTE('others', 900, true);
    initiateRTE('otherReportingRequirements', 900, true);
    initiateRTE('researchDesign', 2500, true);
});
</script>

<#function getStakeholdersClass index>
    <#if (index % 2) == 0>
        <#return "first" />
    <#else>
        <#return "" />
    </#if>
</#function>

<script type="text/javascript">
<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.pib.view.text" /></#assign>	
	var projName = "${project.name?js_string}";
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PIB.getId()}, "${i18CustomText}", projName, ${projectID?c}, ${user.ID?c}, ${endMarketId?c});
</script>