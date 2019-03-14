<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#-- DWR def -->
<head>

   
</head>


<script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>

<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/commons.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/form-data-persist-handler.js?version=1" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/project-sticky-header.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.MultiFile.js'/>"></script>

<script type="text/javascript" src="${themePath}/js/scripts/multifile.js"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ajaxfileupload.js'/>"></script>
 
<link rel="stylesheet" href="${themePath}/style/multi-select.css" type="text/css" media="all" />
<script src="${themePath}/js/synchro/second.js" type="text/javascript"></script>



<#assign fieldCategoryId = ''/>


<#setting locale="en_US">

<script type="text/javascript">
$j(document).ready(function(){
    AUTO_SAVE.register({form:$j("#pib-form"), projectID:${projectID?c}});
   /* PROJECT_STAGE_NAVIGATOR.initialize({
    <#if projectID??>
        projectId:${projectID?c},
    </#if>
        activeStage:2
    });*/
    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#email-notification-form"), projectID:${projectID?c}});
    PROJECT_STICKY_HEADER.initialize();
	$j("#new-page-wrapper").show();
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

function openPITWindow()
{
   
<#--	FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#synchro-pit-form"), projectID:${projectID?c}}) -->
    $j("#pitWindow").lightbox_me({centered:true,closeEsc:false,closeClick:false,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7}});
	
     initiateRTE('description', 1500, true);
	 initiateRTE('brief', 1500, true);
	 initiateRTE('proposal', 1500, true);
	 initiateRTE('documentation', 1500, true);
	
	<#assign i18CustomPITText><@s.text name="logger.project.pit.view.text" /></#assign>
	var projName = "${project.name?js_string}";
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].TPD_SUMMARY.getId()}, "${i18CustomPITText}", projName, ${projectID?c}, ${user.ID?c});
	AddCostDetailTitle();
	AddPITFieldTitle();
}

function openInitiateWaiverWindow()
{
    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#waiver-form"), projectID:${projectID?c}});
    $j("#initiateWaiver").lightbox_me({centered:true,closeEsc:false,closeClick:false,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7}});
    initiateRTE('methodologyDeviationRationale', 2500, false);
    initiateRTE('methodologyApproverComment', 2500, false);
	
	
	<#if !(pibMethodologyWaiver?? && pibMethodologyWaiver.methodologyApprover??)>
		<#assign waiverBtnClickText><@s.text name="logger.project.waiver.btn.click" /></#assign>
		var projName = "${project.name?js_string}";		
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].ADD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].TPD_SUMMARY.getId()}, "${waiverBtnClickText}", projName, ${projectID?c}, ${user.ID?c});
	</#if>
}
function closeWaiverWindow()
{
   /* $j("#initiateWaiver").hide();
    dialog({
        title:"Confirmation",
        html:"Are you sure you want to close saving details?",
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
    });*/
	
	$j("#initiateWaiver").hide();
    $j("#initiateWaiver").trigger('close');
    closeDialog();
}
function closePITWindow()
{
   /* $j("#pitWindow").hide();
    dialog({
        title:"Confirmation",
        html:"Are you sure you want to close saving details?",
        nonCloseActionButtons:['YES'],
        buttons:{
            "YES":function() {
                $j("#pitWindow").hide();
                $j("#pitWindow").trigger('close');
                closeDialog();
            },
            "NO": function() {
                $j("#pitWindow").show();
            }
        },
        closeActionButtonsClickHander:function() {
            $j("#pitWindow").show();
            closeDialog();
        }
    });*/
	
	  $j("#pitWindow").hide();
      $j("#pitWindow").trigger('close');
      closeDialog();

}

function closetpdStatusPopup()
{
	$j("#tpdStatusPopup").hide();
    $j("#tpdStatusPopup").trigger('close');
	$j('.custom_overlay').remove();
    closeDialog();
	
}
function checkMethDeviation()
{
    if($j("#deviationFromSM").val()!=1)
    {
        $j("#initiateWaiverButton").hide();
    }
    else
    {
        $j("#initiateWaiverButton").show();
    }
    if($j("#methWaiverReq").val()!=1)
    {
        $j("#initiateWaiverButtonPIT").hide();
    }
    else
    {
        $j("#initiateWaiverButtonPIT").show();
    }

}



function removeAttachment(attachmentId, fieldID, attachmentName) {
    dialog({
        title: '',
        html: '<i class="warningErr positionSet"></i><p>Are you sure you want to remove the attachment </p>',
        buttons:{
            "DELETE":function() {
                confirmDelete(attachmentId, fieldID, attachmentName);
            },
            "CANCEL": function() {
                closeDialog();
            }
        }
    });
	relPos();

}

function confirmDelete(attachmentId, fieldID, attachmentName) {
    location.href="/new-synchro/tpd-summary!removeAttachment.jspa?projectID=${projectID?c}&attachmentId="+attachmentId+"&attachmentFieldID="+fieldID+"&attachmentName="+attachmentName;
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

<#assign briefID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].PIB_BRIEF.getId()/>
<#assign agencyWaiverID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].AGENCY_WAIVER.getId()/>
<#assign briefLegalApprovalID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].PIB_BRIEF_LEGAL_APPROVAL.getId()/>
<#assign proposalID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].PROPOSAL.getId()/>
<#assign proposalLegalApprovalID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].PROPOSAL_LEGAL_APPROVAL.getId()/>
<#assign documentationID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].DOCUMENTATION.getId()/>

<#assign fullReportID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].FULL_REPORT.getId()/>

<#assign topLineReportID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].TOP_LINE_REPORT.getId()/>
<#assign executivePresentationReportID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].EXECUTIVE_PRESENTATION_REPORT.getId()/>
<#assign irisSummaryReportID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].IRIS_SUMMARY_REPORT.getId()/>
<#assign tpdSummaryReportID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].TPD_SUMMARY_REPORT.getId()/>

<#assign tpdSummaryLegalApprovalID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].TPD_SUMMARY_LEGAL_APPROVAL.getId()/>
<#assign tpdSummarySKUDetailsID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].TPD_SUMMARY_SKU_DETAILS.getId()/>

<#--
<div class="new-page-wrapper">
	<div class="new-page-nav">
	<hr></hr>
	<ul>
	
	
	<#if project.status?? && (project.status == statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].BRIEF_IN_PLANNING.ordinal() || project.status == statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].PROPOSAL_IN_PLANNING.ordinal()) >
		<li><div class="nav-select">1</div><span>in planning</span></li>
		<li class="disable"><div class="nav-select">2</div><span>in progress</span></li>
		<li class="disable"><div class="nav-select">3</div><span>complete</span></li>
		<li class="disable"><div class="nav-select">4</div><span>close</span></li>
	<#elseif project.status?? && (project.status == statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].IN_PROGRESS.ordinal()) >
		<li><div class="nav-select">1</div><span>in planning</span></li>
		<li><div class="nav-select">2</div><span>in progress</span></li>
		<li class="disable"><div class="nav-select">3</div><span>complete</span></li>
		<li class="disable"><div class="nav-select">4</div><span>close</span></li>
	<#elseif project.status?? && (project.status == statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].COMPLETE_REPORT.ordinal() || project.status == statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].COMPLETE_PROJECT_EVAL.ordinal()) >
		<li><div class="nav-select">1</div><span>in planning</span></li>
		<li><div class="nav-select">2</div><span>in progress</span></li>
		<li><div class="nav-select">3</div><span>complete</span></li>
		<li class="disable"><div class="nav-select">4</div><span>close</span></li>
	<#else>
		<li><div class="nav-select">1</div><span>in planning</span></li>
		<li><div class="nav-select">2</div><span>in progress</span></li>
		<li><div class="nav-select">3</div><span>complete</span></li>
		<li><div class="nav-select">4</div><span>close</span></li>
	</#if>
	
	</ul>
	</div>
</div>
-->

<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
<#assign isSynchroSystemOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner() />
	
<div class="container">
<div class="project_names">


<div class="project_name_div">
<h2>${project.name?html} (${generateProjectCode('${projectID?c}')}) </h2>

	<#if isAdminUser || isSynchroSystemOwner>
		<a class="view-edit" href="javascript:void(0);" onclick="javascript:openPITWindow()">Click here to view project details</a>
	<#elseif project.projectType?? && project.projectType == 1>
		<#if statics['com.grail.synchro.util.SynchroPermHelper'].isGlobalUserType()>
			<a class="view-edit" href="javascript:void(0);" onclick="javascript:openPITWindow()">Click here to view project details</a>
		</#if>
	<#elseif project.projectType?? && project.projectType == 2> 
		<#if statics['com.grail.synchro.util.SynchroPermHelper'].isGlobalUserType() || statics['com.grail.synchro.util.SynchroPermHelper'].isRegionalUserType()>
			<a class="view-edit" href="javascript:void(0);" onclick="javascript:openPITWindow()">Click here to view project details</a>
		</#if>
	<#elseif project.projectType?? && project.projectType == 3>
		<#if statics['com.grail.synchro.util.SynchroPermHelper'].isGlobalUserType() || statics['com.grail.synchro.util.SynchroPermHelper'].isRegionalUserType() || statics['com.grail.synchro.util.SynchroPermHelper'].isEndMarketUserType()>
			<a class="view-edit" href="javascript:void(0);" onclick="javascript:openPITWindow()">Click here to view project details</a>
		</#if>
	</#if>
	

	<#if statics['com.grail.synchro.util.SynchroPermHelper'].getLatestTPDStatus(projectID) == -1 >
		<p class="tpdNoteStaus">This project has not received a TPD status yet.</p>
	</#if>	
   	
	 



<#-- <span class="warning-msg"><span></span>PIB cannot be completed until all the mandatory PIB fields have not been filled.</span> -->
<div id="jive-error-box" class="jive-error-box warning" <#if showMandatoryFieldsError?? && showMandatoryFieldsError>style="display:block;"<#else>style="display:none"</#if>>
    <div>
    <#--<span class="jive-icon-med jive-icon-redalert"></span>-->
        <span><@s.text name="project.mandatory.error"/></span>
    </div>
</div>
<#--</#if>-->





<#assign isMethAppUser = statics['com.grail.synchro.util.SynchroPermHelper'].isMethodologyApproverUser() />
<#assign isKantarMethAppUser = statics['com.grail.synchro.util.SynchroPermHelper'].isKantarMethodologyApproverUser() />



<#assign isProjectCreator = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectCreatorNew(projectID) />


<#assign canEditTpdSummary = statics['com.grail.synchro.util.SynchroPermHelper'].canEditTPDSummary() />

<#assign tpdSummaryReportID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].TPD_SUMMARY_REPORT.getId()/>
<#assign defaultCurrency = -1/>




    <#assign endMarketId = endMarketDetails.get(0).getEndMarketID() />
	
	<#assign tpdSKUCounter = 1 />
		
		<#assign tpdSKURowId = 1 />
<#assign tpdCounter = 0 />
<#if statics['com.grail.synchro.util.SynchroPermHelper'].getLatestTPDStatus(projectID) == -1 >
	
<#else>
	


<form name="tpd-summary" action="/new-synchro/tpd-summary!execute.jspa" method="POST"  id="tpd-summary-form" class="research_pib pib tpd-summary" >
<div class="research_content">
<input type="hidden" name="projectID" value="${projectID?c}">
<input type="hidden" name="isSave" value="${save?string}">
<input type="hidden" id="isRowSave" name="isRowSave" value="">
<input type="hidden" id="sameAsPrevSubmittedHidden" name="sameAsPrevSubmittedHidden" value="">
  <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>

  <#assign showPrevSubmittedCheckBox  = "no" />
<#assign showTpdSubmissionDiv = "" />
  
  <#if statics['com.grail.synchro.util.SynchroPermHelper'].getLatestTPDStatus(project.getProjectID()) == 1>
		<#assign showTpdSubmissionDiv = "yes" />
	</#if>
	
<div class="pib_inner_main">



	<!-- Report Summary Starts -->
	<div class="region-inner">
		
		<div class="table">
		<div class="tr table-header">
			<div class="th">Report Type</div>
			<div class="th">Legal Approval Provided By</div>
			<div class="th">Attached Report</div>
		</div>
		
		
		<#if reportSummaryDetailsList?? && reportSummaryDetailsList?size gt 0 >
		
		<#assign reportTypeCounter = 0 />
		<#assign irisCounter = 0 />
		<#assign tpdCounter = 0 />
		<#assign maxReportOrderId = 0 />
		
		<#list reportSummaryDetailsList as reportSummaryDetails>
			<#assign maxReportOrderId = reportSummaryDetails.getReportOrderId() />
			<#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT.getId()>
			<#assign reportTypeCounter =  reportTypeCounter + 1/>
			<#assign attachIds =""	/>
			<div class="tr">
			<div class="td"><div class="disabled-box border-inputradius">Full Report</div></div>
			<#if  reportTypeCounter gt 1>
				<input type="hidden" name="reportTypes" id="reportType" value="${reportSummaryDetails.getReportType()}" />	
			<#else>
				<input type="hidden" name="reportType" id="reportType" value="${reportSummaryDetails.getReportType()}" />
			</#if>
		 <#--	<div class="td"><div class="disabled-box">${reportSummaryDetails.getLegalApprover()}</div></div> -->
			
			<div class="td">
				<#if reportSummaryDetails.getLegalApprover()??> 
					<input type="text" disabled placeholder="Add Legal Approver's  Name" name="reportTypeLegalApproverShow" id="reportTypeLegalApproverShow" value="${reportSummaryDetails.getLegalApprover()}" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's  Name' "/>
						
					<#if  reportTypeCounter gt 1>
						<input type="hidden" name="reportTypeLegalApprovers" id="reportTypeLegalApprover" value="${reportSummaryDetails.getLegalApprover()}" />
					<#else>
						<input type="hidden" name="reportTypeLegalApprover" id="reportTypeLegalApprover" value="${reportSummaryDetails.getLegalApprover()}" />
					</#if>
				<#else>
					<input type="text" disabled placeholder="Add Legal Approver's  Name" name="reportTypeLegalApprover" id="reportTypeLegalApprover" value="" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's Name' "/>
				</#if>
			
			</div>
			
			<div class="td" id="attachmentDiv">
			<#if attachmentMap?? && attachmentMap.get(fullReportID)?? >
				<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
				<div id="jive-file-list" class="jive-attachments">
				
					
					<#list attachmentMap.get(fullReportID) as attachment>
						<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
						</div>
						<#assign attachIds = attachIds+","+attachment.ID?c />
						</#if>
					</#list>
				</div>
				</#if>
				
				<#if  reportTypeCounter gt 1>
					<input type="hidden" name="reportTypeAttachments" id="reportTypeAttachment" value="${attachIds}" />
				<#else>
					<input type="hidden" name="reportTypeAttachment" id="reportTypeAttachment" value="${attachIds}" />
				</#if>
			</#if>
			</div>
			</div>
			<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TOP_LINE_REPORT.getId()>
			<#assign reportTypeCounter =  reportTypeCounter + 1/>
			<#assign attachIds =""	/>
			<div class="tr">
			<div class="td"><div class="disabled-box border-inputradius">Top Line Report</div></div>
			<#if  reportTypeCounter gt 1>
				<input type="hidden" name="reportTypes" id="reportType" value="${reportSummaryDetails.getReportType()}" />	
			<#else>
				<input type="hidden" name="reportType" id="reportType" value="${reportSummaryDetails.getReportType()}" />
			</#if>
			<div class="td">
				<#if reportSummaryDetails.getLegalApprover()??>
					<input type="text" disabled placeholder="Add Legal Approver's Name" name="reportTypeLegalApproverShow" id="reportTypeLegalApproverShow" value="${reportSummaryDetails.getLegalApprover()}"  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's Name' "/>
					
					<#if  reportTypeCounter gt 1>
						<input type="hidden" name="reportTypeLegalApprovers" id="reportTypeLegalApprover" value="${reportSummaryDetails.getLegalApprover()}" />
					<#else>
						<input type="hidden" name="reportTypeLegalApprover" id="reportTypeLegalApprover" value="${reportSummaryDetails.getLegalApprover()}" />
					</#if>
				<#else>
					<input type="text" disabled placeholder="Add Legal Approver's Name" name="reportTypeLegalApprover" id="reportTypeLegalApprover" value="" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's Name' "/>
				</#if>
			
			</div>
			<div class="td" id="attachmentDiv">
			<#if attachmentMap?? && attachmentMap.get(fullReportID)?? >
				<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
				<div id="jive-file-list" class="jive-attachments">
				
				
					<#list attachmentMap.get(fullReportID) as attachment>
						<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
						</div>
						<#assign attachIds = attachIds+","+attachment.ID?c />
						</#if>
					</#list>
				</div>
				</#if>
			</#if>
			
			<#if  reportTypeCounter gt 1>
				<input type="hidden" name="reportTypeAttachments" id="reportTypeAttachment" value="${attachIds}" />
			<#else>
				<input type="hidden" name="reportTypeAttachment" id="reportTypeAttachment" value="${attachIds}" />
			</#if>
			</div>
			</div>
			<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].EXECUTIVE_PRESENTATION.getId()>
			<#assign reportTypeCounter =  reportTypeCounter + 1/>
			<#assign attachIds =""	/>
			<div class="tr">
			<div class="td"><div class="disabled-box border-inputradius">Executive Presentation</div></div>
			<#if  reportTypeCounter gt 1>
				<input type="hidden" name="reportTypes" id="reportType" value="${reportSummaryDetails.getReportType()}" />	
			<#else>
				<input type="hidden" name="reportType" id="reportType" value="${reportSummaryDetails.getReportType()}" />
			</#if>
			<div class="td">
				<#if reportSummaryDetails.getLegalApprover()??>
					<input type="text" disabled placeholder="Add Legal Approver's Name" name="reportTypeLegalApproverShow" id="reportTypeLegalApproverShow" value="${reportSummaryDetails.getLegalApprover()}"  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's Name' "/>
					
					<#if  reportTypeCounter gt 1>
						<input type="hidden" name="reportTypeLegalApprovers" id="reportTypeLegalApprover" value="${reportSummaryDetails.getLegalApprover()}" />
					<#else>
						<input type="hidden" name="reportTypeLegalApprover" id="reportTypeLegalApprover" value="${reportSummaryDetails.getLegalApprover()}" />
					</#if>					
				<#else>
					<input type="text" disabled placeholder="Add Legal Approver's Name" name="reportTypeLegalApprover" id="reportTypeLegalApprover" value=""  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's Name' "/>
				</#if>
			
			</div>
			<div class="td" id="attachmentDiv">
			<#if attachmentMap?? && attachmentMap.get(fullReportID)?? >
				
				<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
				<div id="jive-file-list" class="jive-attachments">
				
					
					<#list attachmentMap.get(fullReportID) as attachment>
						<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
						</div>
						<#assign attachIds = attachIds+","+attachment.ID?c />
						</#if>
					</#list>
				</div>
				</#if>
			</#if>
			
			<#if  reportTypeCounter gt 1>
				<input type="hidden" name="reportTypeAttachments" id="reportTypeAttachment" value="${attachIds}" />
			<#else>
				<input type="hidden" name="reportTypeAttachment" id="reportTypeAttachment" value="${attachIds}" />
			</#if>
			</div></div>
			<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT_BLANK.getId()>
			<#assign reportTypeCounter =  reportTypeCounter + 1/>
			<#assign attachIds =""	/>
			<div class="tr">
			<div class="td"><div class="disabled-box border-inputradius"></div></div>
			<#if  reportTypeCounter gt 1>
				<input type="hidden" name="reportTypes" id="reportType" value="${reportSummaryDetails.getReportType()}" />	
			<#else>
				<input type="hidden" name="reportType" id="reportType" value="${reportSummaryDetails.getReportType()}" />
			</#if>
			<div class="td">
				<#if reportSummaryDetails.getLegalApprover()??>
					<input type="text" disabled placeholder="Add Legal Approver's Name" name="reportTypeLegalApproverShow" id="reportTypeLegalApproverShow" value="${reportSummaryDetails.getLegalApprover()}"  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's Name' "/>
					
					<#if  reportTypeCounter gt 1>
						<input type="hidden" name="reportTypeLegalApprovers" id="reportTypeLegalApprover" value="${reportSummaryDetails.getLegalApprover()}" />
					<#else>
						<input type="hidden" name="reportTypeLegalApprover" id="reportTypeLegalApprover" value="${reportSummaryDetails.getLegalApprover()}" />
					</#if>					
				<#else>
					<input type="text" disabled placeholder="Add Legal Approver's Name" name="reportTypeLegalApprover" id="reportTypeLegalApprover" value=""  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's Name' "/>
				</#if>
			
			</div>
			<div class="td" id="attachmentDiv">
			<#if attachmentMap?? && attachmentMap.get(fullReportID)?? >
		
				<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
				<div id="jive-file-list" class="jive-attachments">
				
					
					<#list attachmentMap.get(fullReportID) as attachment>
						<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
						</div>
						<#assign attachIds = attachIds+","+attachment.ID?c />
						</#if>
					</#list>
				</div>
				</#if>
			</#if>
			
			<#if  reportTypeCounter gt 1>
				<input type="hidden" name="reportTypeAttachments" id="reportTypeAttachment" value="${attachIds}" />
			<#else>
				<input type="hidden" name="reportTypeAttachment" id="reportTypeAttachment" value="${attachIds}" />
			</#if>
			</div>
			</div>
			<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].IRIS_SUMMARY.getId()>
			<#assign irisCounter =  irisCounter + 1/>
			<#assign irisAttachIds =""	/>
			<div class="tr">
			<div class="td"><div class="disabled-box border-inputradius">IRIS Summary</div></div>
			<div class="td">
			<#if reportSummaryDetails.getLegalApprover()??>
				<input type="text" disabled placeholder="Add Legal Approver's Name" name="irisSummaryLegalApproverShow" id="irisSummaryLegalApproverShow" value="${reportSummaryDetails.getLegalApprover()}"  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's Name' "/>
					
				<#if  irisCounter gt 1>
					<input type="hidden" name="irisSummaryLegalApprovers" id="irisSummaryLegalApprover" value="${reportSummaryDetails.getLegalApprover()}" />
				<#else>
					<input type="hidden" name="irisSummaryLegalApprover" id="irisSummaryLegalApprover" value="${reportSummaryDetails.getLegalApprover()}" />
				</#if>					
			<#else>
				<input type="text" disabled placeholder="Add Legal Approver's Name" name="irisSummaryLegalApprover" id="irisSummaryLegalApprover" value="" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's Name' "/>
			</#if>
			
			</div>
			
			<div class="td">
			
			<#if attachmentMap?? && attachmentMap.get(irisSummaryReportID)?? >
				<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
				<div id="jive-file-list" class="jive-attachments">
				
				
					<#list attachmentMap.get(irisSummaryReportID) as attachment>
						<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
						</div>
						<#assign irisAttachIds = irisAttachIds+","+attachment.ID?c />
						</#if>
					</#list>
				</div>
				</#if>
			</#if>
	
			<#if  irisCounter gt 1>
				<input type="hidden" name="irisAttachments" id="irisAttachment" value="${irisAttachIds}" />
			<#else>
				<input type="hidden" name="irisAttachment" id="irisAttachment" value="${irisAttachIds}" />
			</#if>
				
			</div>
			</div>
			<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TPD_SUMMARY.getId()>
			
			<#if showTpdSubmissionDiv == "yes" >
			<#assign tpdCounter =  tpdCounter + 1/>
			<div class="tr tpdtr" id="mainTPDSummaryTypeDiv">
				<#--<div class="tr">
				<div class="td"><div class="disabled-box border-inputradius">TPD Summary</div></div>-->
				
				<#if tpdCounter gt 1>
					<div class="td dynamic-row"><div class="iris_summery_box_align tpd-disabled-box">TPD Summary </div></div>
					<#if reportSummaryDetails.getLegalApprover()??>
						<#if canEditTpdSummary>
							<div class="td"><input type="text" name="tpdSummaryLegalApprovers" id="tpdSummaryLegalApprover_${tpdCounter}" placeholder="Add Legal Approver's Name" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's Name' " value="${reportSummaryDetails.getLegalApprover()}" />
						<#else>
							<div class="td"><input type="text" name="tpdSummaryLegalApprovers" id="tpdSummaryLegalApprover_${tpdCounter}" disabled placeholder="Add Legal Approver's Name" value="${reportSummaryDetails.getLegalApprover()}" />
						</#if>	
					<#else>
						<#if canEditTpdSummary>
							<div class="td"><input type="text" name="tpdSummaryLegalApprovers" id="tpdSummaryLegalApprover_${tpdCounter}" onblur="this.placeholder = 'Add Legal Approver's Name' " placeholder="Add Legal Approver's Name" onfocus="this.placeholder = '' " value="" />
						<#else>
							<div class="td"><input type="text" name="tpdSummaryLegalApprovers" disabled id="tpdSummaryLegalApprover_${tpdCounter}" placeholder="Add Legal Approver's Name" value="" />
						</#if>	
					</#if>	
					<span class="jive-error-message full-width" id="tpdSummaryLegalApproverError_${tpdCounter}" style="display:none">Please Enter Legal Approver</span>
				<#else>
					<div class="td">
						<#if canEditTpdSummary>	
							<input type="button" value="duplicate" class="duplicate add-icon" id="mainTPDSummaryType">
						</#if>	
					<div class="iris_summery_box_align tpd-disabled-box">TPD Summary</div>
					</div>
					<#if reportSummaryDetails.getLegalApprover()??>
						<#if canEditTpdSummary>
							<div class="td"><input type="text" name="tpdSummaryLegalApprover" onfocus="this.placeholder = '' " id="tpdSummaryLegalApprover" placeholder="Add Legal Approver's Name" onblur="this.placeholder = 'Add Legal Approver's Name' " value="${reportSummaryDetails.getLegalApprover()}" />
						<#else>
							<div class="td"><input type="text" name="tpdSummaryLegalApprover" disabled id="tpdSummaryLegalApprover" placeholder="Add Legal Approver's Name" value="${reportSummaryDetails.getLegalApprover()}" />
						</#if>	
					<#else>
						<#if canEditTpdSummary>
							<div class="td"><input type="text" name="tpdSummaryLegalApprover" onblur="this.placeholder = 'Add Legal Approver's Name' " onfocus="this.placeholder = '' " id="tpdSummaryLegalApprover" placeholder="Add Legal Approver's Name" value="" />
						<#else>
							<div class="td"><input type="text" name="tpdSummaryLegalApprover" disabled id="tpdSummaryLegalApprover" placeholder="Add Legal Approver's Name" value="" />
						</#if>	
					</#if>
					
					<span class="jive-error-message full-width" id="tpdSummaryLegalApproverError" style="display:none">Please Enter Legal Approver</span>
				</#if>	
				
				<#--<#if reportSummaryDetails.getLegalApprover()??>
					<div class="td"><input type="text" placeholder="Add Legal Approver's  Name" name="tpdSummaryLegalApprover" id="tpdSummaryLegalApprover" value="${reportSummaryDetails.getLegalApprover()}"  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's Name' "/>
				<#else>
					<div class="td"><input type="text" placeholder="Add Legal Approver's  Name" name="tpdSummaryLegalApprover" id="tpdSummaryLegalApprover" value=""  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's Name' "/>
				</#if>
				
				<@synchrodatetimepicker id="tpdSummaryDate" name="tpdSummaryDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder="Enter Date of Legal Approval"/>
			
					<#if reportSummaryDetails.getLegalApprovalDate()??>
					<script type="text/javascript">
					var _tpdSummaryDate = "${reportSummaryDetails.getLegalApprovalDate()?string('dd/MM/yyyy')}";
					$j("#tpdSummaryDate").val(_tpdSummaryDate);
					</script>
					</#if>
				-->
				
				<#if tpdCounter gt 1 >
											
					<#if canEditTpdSummary>
						<@synchrodatetimepicker id="tpdSummaryDate_${tpdCounter}" name="tpdSummaryDates" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder="Enter Date of Legal Approval" tpdDate=true/>
						<#if reportSummaryDetails.getLegalApprovalDate()??>
							<script type="text/javascript">
							var _tpdSummaryDate = "${reportSummaryDetails.getLegalApprovalDate()?string('dd/MM/yyyy')}";
							$j("#tpdSummaryDate_${tpdCounter}").val(_tpdSummaryDate);
							</script>
						</#if>
					<#else>
						<#if reportSummaryDetails.getLegalApprovalDate()??>
							<input type="text" name="tpdSummaryDates" disabled id="tpdSummaryDate_${tpdCounter}" value="${reportSummaryDetails.getLegalApprovalDate()?string('dd/MM/yyyy')}"  />
						<#else>
							<input type="text" disabled name="tpdSummaryDates" id="tpdSummaryDate_${tpdCounter}" value=""  />
						</#if>
					</#if>	
					
					<span class="jive-error-message full-width" id="tpdSummaryDatesError_${tpdCounter}" style="display:none">Please Enter Date of Legal Approver</span>
				<#else>
					
					<#if canEditTpdSummary>
						<@synchrodatetimepicker id="tpdSummaryDate" name="tpdSummaryDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder="Enter Date of Legal Approval" tpdDate=true/>
				
						<#if reportSummaryDetails.getLegalApprovalDate()??>
						<script type="text/javascript">
						var _tpdSummaryDate = "${reportSummaryDetails.getLegalApprovalDate()?string('dd/MM/yyyy')}";
						$j("#tpdSummaryDate").val(_tpdSummaryDate);
						</script>
						</#if>
					<#else>
						<#if reportSummaryDetails.getLegalApprovalDate()??>
							<input type="text" name="tpdSummaryDate" disabled id="tpdSummaryDate" value="${reportSummaryDetails.getLegalApprovalDate()?string('dd/MM/yyyy')}"  />
						<#else>
							<input type="text" disabled name="tpdSummaryDate" id="tpdSummaryDate" value=""  />
						</#if>
					</#if>	
					
					<span class="jive-error-message full-width" id="tpdSummaryDatesError" style="display:none">Please Enter Date of Legal Approver</span>
		
				</#if>
			</div>
			<div class="td" id="attachmentDiv">
			
			<#assign tdpAttachIds =""	/>
			
			<#if canEditTpdSummary>
				<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupNew(${tpdSummaryReportID?c},${reportSummaryDetails.getReportType()},${reportSummaryDetails.getReportOrderId()})" ></span>
				
				<#if tpdCounter gt 1>
					<input type="button" value="Remove" class="removeRS" id="removeLink">
				<#else>
				</#if>
				<span class="jive-error-message full-width" id="attachmentError" style="display:none">Please attach the TPD Summary</span>
			</#if>	

			
			
												
			<#if attachmentMap?? && attachmentMap.get(tpdSummaryReportID)?? >
				<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
				<div id="jive-file-list" class="jive-attachments">
				
				
					<#list attachmentMap.get(tpdSummaryReportID) as attachment>
						
						<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
						
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							
							<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID && canEditTpdSummary) || (isAdminUser || isSynchroSystemOwner ) >
								<#if (reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?size == 1)>
									<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('TPD Summary');"><@s.text name="global.remove" /></a>
								<#else>
									<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${tpdSummaryReportID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
								</#if>
							
							</#if>
							
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
							
							<#assign tdpAttachIds = tdpAttachIds+","+attachment.ID?c />
							
						</div>
						</#if>
					</#list>
				</div>
				</#if>
			</#if>
			
			
			<#if tdpAttachIds!="">
				 <#assign showPrevSubmittedCheckBox  = "yes" />
			<#else>
				<#assign hasTPDAttachment  = "no" />
			</#if>
			
			<#if  tpdCounter gt 1>
				<input type="hidden" name="tpdAttachments" id="tpdAttachment" value="${tdpAttachIds}" />
			<#else>
				<input type="hidden" name="tpdAttachment" id="tpdAttachment" value="${tdpAttachIds}" />
			</#if>
			
			</div>
			</div>
			</#if>
			</#if>
			
			
		</#list>
		
		<#-- This logic has been written in the status has been changed on TPD Dashboard from Doesn't have to be submitted to May have to be submitted once the Report Summary has been saved. -->
		
		<#if tpdCounter gt 0>
		<#else>
			<#if  (project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId()) && proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus == 1))  || ((project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId()) && project?? && project.globalOutcomeEUShare?? && project.globalOutcomeEUShare==1 && proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && proposalInitiation.legalApprovalStatus == 1))>
				<div class="tr" id="mainTPDSummaryTypeDiv">
				<div class="td">
					<#if canEditTpdSummary>	
						<input type="button" value="duplicate" class="duplicate add-icon" id="mainTPDSummaryType">
					</#if>	
				<div class="iris_summery_box_align">TPD Summary</div>
				</div>

				<#if canEditTpdSummary>
					<div class="td"><input type="text" name="tpdSummaryLegalApprover" onblur="this.placeholder = 'Add Legal Approver's Name' " onfocus="this.placeholder = '' " id="tpdSummaryLegalApprover" placeholder="Add Legal Approver's Name" value="" />
				<#else>
					<div class="td"><input type="text" name="tpdSummaryLegalApprover" disabled id="tpdSummaryLegalApprover" placeholder="Add Legal Approver's Name" value="" />
				</#if>	

				
				<span class="jive-error-message full-width" id="tpdSummaryLegalApproverError" style="display:none">Please Enter Legal Approver</span>	

				
				
				<@synchrodatetimepicker id="tpdSummaryDate" name="tpdSummaryDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder="Enter Date of Legal Approval" tpdDate=true/>
			
				<span class="jive-error-message full-width" id="tpdSummaryDatesError" style="display:none">Please Enter Date of Legal Approver</span>
				</div>
				
				
				<div class="td" id="attachmentDiv">
				
				
				
				<#if canEditTpdSummary>
					<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupNew(${tpdSummaryReportID?c},5,${maxReportOrderId+1})" ></span>
					<span class="jive-error-message full-width" id="attachmentError" style="display:none">Please attach the TPD Summary</span>
				
				</#if>
				
				</div>
				</div>
				
			</#if>	
		</#if>	
		
		<div class="tr" id="mainTPDSummaryTypeDivLast" >
			</div>
		<#else>
			<div class="tr">
				<div class="td"><div class="disabled-box border-inputradius"></div></div>
				<div class="td"><div class="disabled-box border-inputradius"></div></div>
				<div class="td" id="attachmentDiv"></div>
			</div>
			
			<div class="tr">
				<div class="td"><div class="disabled-box border-inputradius">IRIS Summary</div></div>
				<div class="td"><div class="disabled-box border-inputradius"></div></div>
				<div class="td"></div>
			</div>
			
			<#--<div class="tr">
			<div class="td"><div class="disabled-box border-inputradius">TPD Summary</div></div>
			-->
			<#if showTpdSubmissionDiv == "yes" >

			<div class="tr tpdtr" id="mainTPDSummaryTypeDiv">
			<div class="td">
			<#if canEditTpdSummary>
				<input type="button" value="duplicate" class="duplicate add-icon" id="mainTPDSummaryType">
			</#if>	
			<div class="iris_summery_box_align">TPD Summary</div></div>
			
			
			
			
			<div class="td">
			<#if canEditTpdSummary>
				<input type="text"  placeholder="Add Legal Approver's  Name" name="tpdSummaryLegalApprover" id="tpdSummaryLegalApprover" value=""   onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's  Name' " />
			<#else>
				<input type="text" disabled placeholder="Add Legal Approver's  Name" name="tpdSummaryLegalApprover" id="tpdSummaryLegalApprover" value=""   onfocus="this.placeholder = '' " onblur="this.placeholder = 'Add Legal Approver's  Name' " />
			</#if>	
			<span class="jive-error-message full-width" id="tpdSummaryLegalApproverError" style="display:none">Please Enter Legal Approver</span>
			<div>
			
			<#if canEditTpdSummary>
				<@synchrodatetimepicker id="tpdSummaryDate" name="tpdSummaryDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder="Enter Date of Legal Approval"/>
			<#else>
				<input type="text" disabled name="tpdSummaryDate" id="tpdSummaryDate" value=""  />
			</#if>	
			
			<span class="jive-error-message full-width" id="tpdSummaryDatesError" style="display:none">Please Enter Date of Legal Approver</span>

			</div>
			</div>
			
			
			
			<div class="td" id="attachmentDiv">
				<div class="td">
				<#if canEditTpdSummary>
					<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupNew(${tpdSummaryReportID?c},5,3)" ></span>
				</#if>	
				<span class="jive-error-message full-width" id="attachmentError" style="display:none">Please attach the TPD Summary</span>
			</div>
			</div>
			
			</#if>
	
		</#if>
		
		
	</div>
	
	<div class="tr" id="mainTPDSummaryTypeDivLast" >
			</div>
	
	
	</div>
	<!-- Report Summary Ends -->


	<!-- start project status  -->
	<div class="project-status-div clearfix">
	<p><i>Please enter the following information</i></p>
	
	
	<div class="region-inner">
		<div class="form-select_div">
			<label>TPD Status</label>
			

			<#--<#if proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && project.status gt statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].BRIEF_IN_PLANNING.ordinal()>
				<@renderLegalApprovalStatusFieldsTPDScreen name='legalApprovalStatusPit' value="${proposalInitiation.legalApprovalStatus}" readonly=true/>
				<#if proposalInitiation.legalApprovalStatus == 1>
					<#assign showTpdSubmissionDiv = "yes" />
				</#if>
			<#elseif projectInitiation?? && projectInitiation.legalApprovalStatus?? && (project.status == statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].BRIEF_IN_PLANNING.ordinal() || project.status gt statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].BRIEF_IN_PLANNING.ordinal())>
				<@renderLegalApprovalStatusFieldsTPDScreen name='legalApprovalStatusPit' value="${projectInitiation.legalApprovalStatus}" readonly=true/>
				<#if projectInitiation.legalApprovalStatus == 1>
					<#assign showTpdSubmissionDiv = "yes" />
				</#if>
			<#else>
				<@renderLegalApprovalStatusFieldsTPDScreen name='legalApprovalStatusPit' value="-1" readonly=true/>
			</#if>
			-->
			
			
			
			<@renderLegalApprovalStatusFieldsTPDScreen name='legalApprovalStatusPit' value="${statics['com.grail.synchro.util.SynchroPermHelper'].getLatestTPDStatus(project.getProjectID())}" readonly=true/>
			<#if canEditTpdSummary>
				<a href="javascript:void(0);" onclick="openTpdStatusPopup();" class="changeTpD blueButton">Change TPD Status</a>	
			</#if>
		</div>
	</div>
	
	<div class="form-select_div form-select_div_project_completion region-inner">
		
		<label>Legal Approval Provided By</label>
		<div>
			<#assign legalApproverName = statics['com.grail.synchro.util.SynchroPermHelper'].getLatestTPDLegalApprover(project.getProjectID()) />
			<#--<#if proposalInitiation?? && proposalInitiation.proposalLegalApprover?? && project.status gt statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].BRIEF_IN_PLANNING.ordinal()>
				<#if project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId()>
					<#if proposalInitiation.proposalLegalApproverOffline??>
						<#assign legalApproverName = proposalInitiation.proposalLegalApproverOffline />
					</#if>	
				<#else>
					<#assign legalApproverName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(proposalInitiation.proposalLegalApprover) />
				</#if>	
			<#elseif projectInitiation?? && projectInitiation.briefLegalApprover?? && (project.status == statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].BRIEF_IN_PLANNING.ordinal() || project.status gt statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].BRIEF_IN_PLANNING.ordinal())>
			
					<#if project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId()>
					<#assign legalApproverName = projectInitiation.briefLegalApproverOffline />
				<#else>
						<#assign legalApproverName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(projectInitiation.briefLegalApprover) />	
				</#if>	
			<#else>
				<#assign legalApproverName = '' />
			</#if> -->
			<input type="text"  name="legalApproverName" value="${legalApproverName}" id="legalApproverName"  disabled />
		</div>
	</div>
	
	<div class="form-select_div form-select_div_project_completion region-inner">
							
		<label>Date of Legal Approval</label>
		<div>
			<#if statics['com.grail.synchro.util.SynchroPermHelper'].getLatestTPDLegalApprovalDate(project.getProjectID())?? >
				<input type="text"  name="legalApproverDatePit" value="${statics['com.grail.synchro.util.SynchroPermHelper'].getLatestTPDLegalApprovalDate(project.getProjectID())?string('dd/MM/yyyy')}" id="legalApproverDatePit"  disabled />
			<#else>
				<input type="text"  name="legalApproverDatePit" value="" id="legalApproverDatePit"  disabled />
			</#if>
			
			<#--
			<#if proposalInitiation?? && proposalInitiation.legalApprovalDate?? && project.status gt statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].BRIEF_IN_PLANNING.ordinal()>
			<input type="text"  name="legalApproverDatePit" value="${proposalInitiation.legalApprovalDate?string('dd/MM/yyyy')}" id="legalApproverDatePit"  disabled />
				<#elseif projectInitiation?? && projectInitiation.legalApprovalDate?? && (project.status == statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].BRIEF_IN_PLANNING.ordinal() || project.status gt statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].BRIEF_IN_PLANNING.ordinal())>
			<input type="text"  name="legalApproverDatePit" value="${projectInitiation.legalApprovalDate?string('dd/MM/yyyy')}" id="legalApproverDatePit"  disabled />
			<#else>
				<input type="text"  name="legalApproverDatePit" value="" id="legalApproverDatePit"  disabled />
			</#if>
			-->
		</div>
	</div>

	</div>
	
	
	
	<!-- project status end-->
	
	
	<div class="region-inner">
		<label>Research Done On</label>
		<div class="form-text_div">	
			<#if tpdSummary.researchDoneOn??>
				<#if canEditTpdSummary>
					<@renderTpdResearchDoneOn name='researchDoneOn' value="${tpdSummary.researchDoneOn}"/>
				<#else>
					<@renderTpdResearchDoneOn name='researchDoneOn' value="${tpdSummary.researchDoneOn}" readonly=true/>
				</#if>
			<#else>
				<#if canEditTpdSummary>
					<@renderTpdResearchDoneOn name='researchDoneOn' value="-1"/>
				<#else>
					<@renderTpdResearchDoneOn name='researchDoneOn' value="-1" readonly=true/>
				</#if>
			</#if>	
		</div>
	</div>
	
	<div class="region-inner">
	
		<label class='rte-editor-label'>Product Description </label>
		<div class="form-text_div">
			<#if canEditTpdSummary>
				<textarea id="productDescription" name="productDescription" placeholder="Enter Product Description" rows="10" cols="20" class="form-text-div">${tpdSummary.productDescription?default('')?html}</textarea>
			<#else>
				<textarea id="productDescription" name="productDescription" disabled placeholder="Enter Product Description" rows="10" cols="20" class="form-text-div">${tpdSummary.productDescription?default('')?html}</textarea>
			</#if>	
			
			<@macroCustomFieldErrors msg="Please enter the Product Description" class='textarea-error-message'/>
		</div>
		<textarea style="display:none;" id="documentationText" name="documentationText">${tpdSummary.productDescriptionText?default('')?html}</textarea>
	
	</div>
	
	<#--<div class="region-inner">
		<div class="form-select_div">
			<label>Has the Product Modification Happened Yet?</label>
			
			<#if tpdSummary.researchDoneOn??>
				<#if canEditTpdSummary>
					<@renderTpdProductModification name='hasProductModification' value="${tpdSummary.hasProductModification}"/>
				<#else>
					<@renderTpdProductModification name='hasProductModification' value="${tpdSummary.hasProductModification}" readonly=true />
				</#if>	
			<#else>
				<#if canEditTpdSummary>
					<@renderTpdProductModification name='hasProductModification' value="-1"/>
				<#else>
					<@renderTpdProductModification name='hasProductModification' value="-1" readonly=true />
				</#if>	
			</#if>	
		</div>
	</div>
	
	 <div class="region-inner">
        <div class="form-select_div">
            <label>Date Of Modification</label>
		<#if canEditTpdSummary>
			<@synchrodatetimepicker id="tpdModificationDate" name="tpdModificationDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  placeholder="Select Date" />
		<#else>
			
			<#if tpdSummary?? && tpdSummary.tpdModificationDate??>
				<input type="text"  name="tpdModificationDate" value="${tpdSummary.tpdModificationDate?string('dd/MM/yyyy')}" id="tpdModificationDate"  disabled />
			<#else>
					<input type="text"  name="tpdModificationDate" value="" id="tpdModificationDate"  disabled />
			
			</#if>
		</#if>
		 
             <#assign error_msg>Please select Project Start</#assign>
			<@macroCustomFieldErrors msg=error_msg />
        </div>
    </div>
	
	
	<div class="project_owner_brief region-inner">
        <label>TAO Code</label>
        <#if tpdSummary.taoCode??>
			<#if canEditTpdSummary>
				<input type="text"  name="taoCode" id="taoCode" value="${tpdSummary.taoCode}" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter TAO Code' " placeholder="Enter TAO Code"/>		
			<#else>
				<input type="text"  name="taoCode" id="taoCode" disabled value="${tpdSummary.taoCode}" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter TAO Code' " placeholder="Enter TAO Code"/>		
			</#if>	
		<#else>
			<#if canEditTpdSummary>
				<input type="text"  name="taoCode" id="taoCode" value="" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter TAO Code' " placeholder="Enter TAO Code"/>		
			<#else>
				<input type="text"  disabled name="taoCode" id="taoCode" value="" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter TAO Code' " placeholder="Enter TAO Code"/>		
			</#if>	
		</#if>
    </div>
	
	-->
	
	<!-- start dynamic sku section -->
	<div class="region-inner" id="tpdSubmissionDiv">
	<div class="dynamic-sku-section">
	<div class="table tpd-summary-table">
		<div class="tr table-header ">
			<div class="th">Submission Date</div>
			<div class="th">TAO Code</div>
			<div class="th">TPD Summary</div>
			
		</div>
		
		<#assign canEditTpdSummary = statics['com.grail.synchro.util.SynchroPermHelper'].canEditTPDSummary() />
		
		<#if tpdSKUDetails?? && tpdSKUDetails?size gt 0>
			
			<#list tpdSKUDetails as tpdSKU>
			
			
				
				<input type="hidden"  name="skuRowSave" <#if tpdSKU?? && tpdSKU.getIsRowSaved()> value="yes" <#else> value="" </#if> id="skuRowSave" />
				
				<input type="hidden"  name="savedRowIds" <#if tpdSKU?? && tpdSKU.getIsRowSaved()> value="${tpdSKU.rowId}" <#else> value="" </#if> id="savedRowIds" />
				
				
				<div class="tr">
					<div class="td">
						<div class="form-select_div start_date">
							
							<#--<@synchrodatetimepicker id="submissionDate_${tpdSKUCounter}" name="submissionDates" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder="Enter Date" />-->
							<#if tpdSKU.getSubmissionDate()??>
								
								<#if canEditTpdSummary>
									<#if isAdminUser || isSynchroSystemOwner>
										<@synchrodatetimepicker id="submissionDate${tpdSKUCounter}" name="submissionDates" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder="Select Date" tpdSubmissionDate=true/>
										
											<script type="text/javascript">
											var subDate = "${tpdSKU.getSubmissionDate()?string('dd/MM/yyyy')}";
											$j("#submissionDate${tpdSKUCounter}").val(subDate);
											</script>
									
									<#elseif tpdSKU?? && !tpdSKU.getIsRowSaved()>			
										<@synchrodatetimepicker id="submissionDate${tpdSKUCounter}" name="submissionDates" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder="Select Date" tpdSubmissionDate=true/>
										
											<script type="text/javascript">
											var subDate = "${tpdSKU.getSubmissionDate()?string('dd/MM/yyyy')}";
											$j("#submissionDate${tpdSKUCounter}").val(subDate);
											</script>
									<#else>
										<#--<input type="text"  name="submissionDatesO" id="submissionDates" disabled value="${tpdSKU.getSubmissionDate()?string('dd/MM/yyyy')}" /> -->
										
										<input type="text"  name="submissionDates" id="submissionDate${tpdSKUCounter}" disabled  value="${tpdSKU.getSubmissionDate()?string('dd/MM/yyyy')}" />
									</#if>
								<#else>
									<input type="text"  name="submissionDates" id="submissionDate${tpdSKUCounter}" disabled  value="${tpdSKU.getSubmissionDate()?string('dd/MM/yyyy')}" />
								</#if>	
								
								
					
					
							<#else>
								<#if canEditTpdSummary>
									<#if isAdminUser || isSynchroSystemOwner>
										<@synchrodatetimepicker id="submissionDate${tpdSKUCounter}" name="submissionDates" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder="Select Date" tpdSubmissionDate=true/>
									<#elseif tpdSKU?? && !tpdSKU.getIsRowSaved()>			
										<@synchrodatetimepicker id="submissionDate${tpdSKUCounter}" name="submissionDates" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder="Select Date" tpdSubmissionDate=true/>
									<#else>
										<#--<input type="text"  name="submissionDatesO" id="submissionDates" disabled value="" />-->
										<input type="text"  name="submissionDates" id="submissionDate${tpdSKUCounter}" disabled value="" />
									</#if>	
								<#else>
									<input type="text"  name="submissionDates" id="submissionDate${tpdSKUCounter}" disabled value="" />
								</#if>		
							</#if>
							
								
							<span class="jive-error-message" id="submissionDateError${tpdSKUCounter}" style="display:none">Please enter Submission Date</span>
							
							
						</div>
					</div>
					
					
					<div class="td">
						<#if tpdSKU.taoCode??>
							<#if canEditTpdSummary>
								<#if isAdminUser || isSynchroSystemOwner>
									<input type="text"  name="taoCodes" id="taoCodes${tpdSKUCounter}" value="${tpdSKU.taoCode}"  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter TAO Code' " placeholder="Enter TAO Code"/>
								<#elseif tpdSKU?? && !tpdSKU.getIsRowSaved()>
									<input type="text"  name="taoCodes" id="taoCodes${tpdSKUCounter}" value="${tpdSKU.taoCode}"  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter TAO Code' " placeholder="Enter TAO Code"/>
								<#else>
									<input type="text"  name="taoCodes" id="taoCodes${tpdSKUCounter}" value="${tpdSKU.taoCode}" disabled onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter TAO Code' " placeholder="Enter TAO Code"/>
								</#if>
							<#else>
								<input type="text"  name="taoCodes" id="taoCodes${tpdSKUCounter}" value="${tpdSKU.taoCode}" disabled onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter TAO Code' " placeholder="Enter TAO Code"/>
							</#if>	
							
							
						<#else>
							<#if canEditTpdSummary>
								<#if isAdminUser || isSynchroSystemOwner>
									<input type="text"  name="taoCodes" id="taoCodes${tpdSKUCounter}" value="" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter TAO Code' " placeholder="Enter TAO Code"/>
								<#elseif tpdSKU?? && !tpdSKU.getIsRowSaved()>
									<input type="text"  name="taoCodes" id="taoCodes${tpdSKUCounter}" value=""  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter TAO Code' " placeholder="Enter TAO Code"/>
								<#else>
									<input type="text"  name="taoCodes" id="taoCodes${tpdSKUCounter}" value="" disabled onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter TAO Code' " placeholder="Enter TAO Code"/>
								</#if>
							<#else>
								<input type="text"  name="taoCodes" id="taoCodes${tpdSKUCounter}" value="" disabled onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter TAO Code' " placeholder="Enter TAO Code"/>
							</#if>	
							
						</#if>	
						<span class="jive-error-message" id="taoCodeError${tpdSKUCounter}" style="display:none">Please enter TAO Code</span>
						
					</div>
					
					
					
					<div class="td">
						<div class="form-select_div start_date">
						
						
						<#if tpdSKUCounter == 1>
							<#assign tpdSKURowId = tpdSKU.rowId />
						</#if>
							<#if tpdSKU?? && tpdSKU.sameAsPrevSubmitted?? && tpdSKU.sameAsPrevSubmitted>
								<#if canEditTPDSummary>
									<span style="display:none" class="jive-icon-med jive-icon-attachment j-link" id="attachment-icon-${tpdSKU.rowId}" onclick="showAttachmentPopupTPDSKUDetails(${tpdSummarySKUDetailsID?c},${tpdSKU.rowId})" ></span>
								<#else>
									
								</#if>	
							<#else>
								<#if canEditTPDSummary?? && canEditTPDSummary>
									<#if isAdminUser || isSynchroSystemOwner>
										<span class="jive-icon-med jive-icon-attachment j-link" id="attachment-icon-${tpdSKU.rowId}" onclick="showAttachmentPopupTPDSKUDetails(${tpdSummarySKUDetailsID?c},${tpdSKU.rowId})" ></span>
									<#elseif tpdSKU?? && !tpdSKU.getIsRowSaved() >
										<span class="jive-icon-med jive-icon-attachment j-link" id="attachment-icon-${tpdSKU.rowId}" onclick="showAttachmentPopupTPDSKUDetails(${tpdSummarySKUDetailsID?c},${tpdSKU.rowId})" ></span>
									</#if>
								<#else>
								
								</#if>	
							</#if>
							
							<#if tpdSKUAttachmentMap?? && tpdSKUAttachmentMap.get(tpdSKU.rowId)?? >
								<div id="jive-file-list" class="jive-attachments">
									<#list tpdSKUAttachmentMap.get(tpdSKU.rowId) as attachment>
										<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
											<span class="jive-icon-med jive-icon-attachment"></span>
											
												<#if canEditTPDSummary>
													<#if isAdminUser || isSynchroSystemOwner>
														<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${tpdSummarySKUDetailsID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
													<#elseif tpdSKU?? && !tpdSKU.getIsRowSaved() >
														<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${tpdSummarySKUDetailsID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
													</#if>	
												</#if>	
											
											<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
											${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
										</div>
									</#list>
								</div>
							</#if>
							<span class="jive-error-message" id="tpdSummaryAttachmentError${tpdSKUCounter}" style="display:none">Please attach TPD Summary</span>
							
							<#if showPrevSubmittedCheckBox =="yes" >
						
								<#if statics['com.grail.synchro.util.SynchroPermHelper'].canEditTPDSummary() >
									<#if tpdSKU?? && !tpdSKU.getIsRowSaved() >
										<div class="legal-checkbox" id="legal-checkbox">
										<input type="checkbox" name="sameAsPrevSubmitted" onclick="removeAttachmentIcon(${tpdSKU.rowId}, this)" id="sameAsPrevSubmitted-${tpdSKU.rowId}" <#if tpdSKU?? && tpdSKU.sameAsPrevSubmitted?? && tpdSKU.sameAsPrevSubmitted> checked="true"</#if> >Same as original TPD summary.</div>
									<#else>
										<div class="legal-checkbox" id="legal-checkbox">
										
										<#if isAdminUser || isSynchroSystemOwner>
											<input type="checkbox" name="sameAsPrevSubmitted"  onclick="removeAttachmentIcon(${tpdSKU.rowId}, this)" id="sameAsPrevSubmitted-${tpdSKU.rowId}" <#if tpdSKU?? && tpdSKU.sameAsPrevSubmitted?? && tpdSKU.sameAsPrevSubmitted> checked="true"</#if> >Same as original TPD summary.</div>
										<#else>	
											<input type="checkbox" name="sameAsPrevSubmitted" readonly="true" onclick="return false;" id="sameAsPrevSubmitted-${tpdSKU.rowId}" <#if tpdSKU?? && tpdSKU.sameAsPrevSubmitted?? && tpdSKU.sameAsPrevSubmitted> checked="true"</#if> >Same as original TPD summary.</div>
										</#if>	
									</#if>
								<#else>
									<div class="legal-checkbox" id="legal-checkbox">
										<input type="checkbox" name="sameAsPrevSubmitted" readonly="true" onclick="return false;" id="sameAsPrevSubmitted-${tpdSKU.rowId}" <#if tpdSKU?? && tpdSKU.sameAsPrevSubmitted?? && tpdSKU.sameAsPrevSubmitted> checked="true"</#if> >Same as original TPD summary.
									</div>
								</#if>
							
							<#elseif tpdSKU?? && tpdSKU.getIsRowSaved() >
								<#if statics['com.grail.synchro.util.SynchroPermHelper'].canEditTPDSummary() >
									<#if showPrevSubmittedCheckBox =="yes" >
										<div class="legal-checkbox" id="legal-checkbox">
											<#if isAdminUser || isSynchroSystemOwner>
												<input type="checkbox" name="sameAsPrevSubmitted" onclick="removeAttachmentIcon(${tpdSKU.rowId}, this)" id="sameAsPrevSubmitted-${tpdSKU.rowId}" <#if tpdSKU?? && tpdSKU.sameAsPrevSubmitted?? && tpdSKU.sameAsPrevSubmitted> checked="true"</#if> >Same as original TPD summary.
											<#else>
												<input type="checkbox" name="sameAsPrevSubmitted" readonly="true"  onclick="return false;" onclick="removeAttachmentIcon(${tpdSKU.rowId}, this)" id="sameAsPrevSubmitted-${tpdSKU.rowId}" <#if tpdSKU?? && tpdSKU.sameAsPrevSubmitted?? && tpdSKU.sameAsPrevSubmitted> checked="true"</#if> >Same as original TPD summary.
											</#if>	
										</div>
									<#else>
										<#if tpdSKU?? && tpdSKU.sameAsPrevSubmitted?? && tpdSKU.sameAsPrevSubmitted> 
											<div class="legal-checkbox" id="legal-checkbox">
											<#if isAdminUser || isSynchroSystemOwner>
												<input type="checkbox" name="sameAsPrevSubmitted"  onclick="removeAttachmentIcon(${tpdSKU.rowId}, this)" id="sameAsPrevSubmitted-${tpdSKU.rowId}" <#if tpdSKU?? && tpdSKU.sameAsPrevSubmitted?? && tpdSKU.sameAsPrevSubmitted> checked="true"</#if> >Same as original TPD summary.
											<#else>
												<input type="checkbox" name="sameAsPrevSubmitted" readonly="true"  onclick="return false;" onclick="removeAttachmentIcon(${tpdSKU.rowId}, this)" id="sameAsPrevSubmitted-${tpdSKU.rowId}" <#if tpdSKU?? && tpdSKU.sameAsPrevSubmitted?? && tpdSKU.sameAsPrevSubmitted> checked="true"</#if> >Same as original TPD summary.
											</#if>
											</div>
										</#if>
									</#if>	
								<#else>
									<div class="legal-checkbox" id="legal-checkbox">
										<input type="checkbox" name="sameAsPrevSubmitted" readonly="true"  onclick="return false;" onclick="removeAttachmentIcon(${tpdSKU.rowId}, this)" id="sameAsPrevSubmitted-${tpdSKU.rowId}" <#if tpdSKU?? && tpdSKU.sameAsPrevSubmitted?? && tpdSKU.sameAsPrevSubmitted> checked="true"</#if> >Same as original TPD summary.
									</div>
								</#if>	
							</#if>	
							
							<#--<#if tpdSKU.getTpdModificationDate()??>
								<#if isAdminUser || isSynchroSystemOwner>
									<@synchrodatetimepicker id="tpdModificationDate_${tpdSKUCounter}" name="tpdModificationDates" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  placeholder="Select Date" />
									
									<script type="text/javascript">
										var modDate = "${tpdSKU.getTpdModificationDate()?string('dd/MM/yyyy')}";
										$j("#tpdModificationDate_${tpdSKUCounter}").val(modDate);
									</script>
								<#else>
									<input type="text"  name="tpdModDate" id="tpdModDates" disabled value="${tpdSKU.getTpdModificationDate()?string('dd/MM/yyyy')}" />
								</#if>	
							<#else>
								<#if isAdminUser || isSynchroSystemOwner>
									<@synchrodatetimepicker id="tpdModificationDate" name="tpdModificationDates" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  placeholder="Select Date" tpdSubmissionDate=true/>
								<#else>
									<input type="text"  name="tpdModDate" id="tpdModDates" disabled value="" />
								</#if>	
							</#if>
							-->
							<#if statics['com.grail.synchro.util.SynchroPermHelper'].canEditTPDSummary()>
								<input type="button" value="duplicate" class="duplicate" id="firstDuplicate" style="display: block;" onclick="duplicateSku();">
								<#if isAdminUser || isSynchroSystemOwner>
									<input type="button" value="Remove" class="remove enable" id="firstRemove" style="display: block;" onclick="deleteSku(this,'${tpdSKU.rowId}');">
								<#--<#elseif tpdSKU?? && !tpdSKU.getIsRowSaved() && tpdSKUCounter gt 1 > -->
								<#elseif tpdSKU?? && tpdSKU.getIsRowSaved() >
									<input type="button" value="Remove" class="remove disable" id="firstRemove" style="display: block;" >
								<#else>
									
									<input type="button" value="Remove" class="remove enable" id="firstRemove" style="display: block;" onclick="deleteSku(this,'${tpdSKU.rowId}');">
								</#if>	
							</#if>
							
						</div>
					</div>
					
					<input type="hidden"  name="rowIds" value="${tpdSKU.rowId}" id="rowIds" />
				</div>	
				<#assign tpdSKUCounter = tpdSKUCounter + 1 />
			</#list>	
		
		<#else>
			<div class="tr">
				<div class="td">
					<div class="form-select_div start_date">
						
						<#if statics['com.grail.synchro.util.SynchroPermHelper'].canEditTPDSummary()>
							<@synchrodatetimepicker id="submissionDate" name="submissionDates" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder="Select Date" tpdSubmissionDate=true/>
						<#else>
							<input type="text"  name="submissionDates" id="submissionDate" disabled value="" />
						</#if>	
								
							<span class="jive-error-message" id="submissionDateError" style="display:none">Please enter Submission Date</span>
					</div>
				</div>
				
				<div class="td">
					
					<#if statics['com.grail.synchro.util.SynchroPermHelper'].canEditTPDSummary()>
						<input type="text"  name="taoCodes" id="taoCode" value="" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter TAO Code' " placeholder="Enter TAO Code"/>
					<#else>
						<input type="text"  disabled name="taoCodes" id="taoCode" value="" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter TAO Code' " placeholder="Enter TAO Code"/>
					</#if>
					
					
					<span class="jive-error-message" id="taoCodeError" style="display:none">Please enter TAO Code</span>
				</div>
				
				
				
				<div class="td">
					<div class="form-select_div start_date">
							<#if statics['com.grail.synchro.util.SynchroPermHelper'].canEditTPDSummary()>
								<span class="jive-icon-med jive-icon-attachment j-link" id="attachment-icon-1" onclick="showAttachmentPopupTPDSKUDetails(${tpdSummarySKUDetailsID?c},1)" ></span>
							</#if>	
							
							<#if showPrevSubmittedCheckBox =="yes" >
								<div class="legal-checkbox" id="legal-checkbox"><input type="checkbox" name="sameAsPrevSubmitted" onclick="removeAttachmentIcon(1, this)" id="sameAsPrevSubmitted-1" >Same as original TPD summary.</div>
							</#if>	
							
							<span class="jive-error-message" id="tpdSummaryAttachmentError" style="display:none">Please attach TPD Summary</span>
						<#--<#if canEditTpdSummary>
							<@synchrodatetimepicker id="tpdModificationDate" name="tpdModificationDates" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  placeholder="Select Date" />
						<#else>
							
							<#if tpdSummary?? && tpdSummary.tpdModificationDate??>
								<input type="text"  name="tpdModificationDates" value="${tpdSummary.tpdModificationDate?string('dd/MM/yyyy')}" id="tpdModificationDate"  disabled />
							<#else>
								<input type="text"  name="tpdModificationDates" value="" id="tpdModificationDate"  disabled />
							
						</#if>
							</#if>
						-->
						<#if statics['com.grail.synchro.util.SynchroPermHelper'].canEditTPDSummary()>
							<input type="button" value="duplicate" class="duplicate" id="firstDuplicate" style="display: block;" onclick="duplicateSku2('2');">
							<input type="button" value="Remove" class="remove enable" id="firstRemove" style="display: block;" onclick="deleteSku(this,1);">
						</#if>
						<span class="jive-error-message" id="tpdModificationDateError" style="display:none">Please enter Date of Launch/Modification</span>
				
					</div>
				</div>
				
				
				<input type="hidden"  name="rowIds" value="1" id="rowIds" />
				
			</div>	
		</#if>	
		
	</div>
	</div>
	</div>
	<!-- end dynamic sku section -->
	
	<#if statics['com.grail.synchro.util.SynchroPermHelper'].canEditTPDSummary()>
		<input type="hidden"  name="rowId" value="" id="rowId" />
		<#if tpdSummary?? && tpdSummary.legalApprovalStatus?? && tpdSummary.legalApprovalStatus == 2>
			<a href="javascript:void(0);" style="margin-left: 10px;" onclick="return saveTPDSummaryFormDontHaveSub();" class="publish-details">Save</a>	
		<#else>	
			<a href="javascript:void(0);" style="margin-left: 10px;" onclick="return saveTPDSummaryForm();" class="publish-details">Save</a>	
		</#if>	
	</#if>
    <#assign synchroUtils = jiveContext.getSpringBean("synchroUtils") />

<script type="text/javascript">
    var attachmentWindow = null;
	var attachmentTPDStatusWindow = null;
	
    $j(document).ready(function(){
        attachmentWindow = new SYNCHRO_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/new-synchro/tpd-summary!addAttachment.jspa'/>",
            projectID:${projectID?c},
            endMarketID:${endMarketId?c},
            parentForm:$j("#tpd-summary-form"),
            items:[
                {id:${bussinessQuestionID?c},name:'Business Question'},
                {id:${researchObjectiveID?c},name:'Research Objective(s)'},
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
    });
	
	$j(document).ready(function(){
        attachmentTPDStatusWindow = new SYNCHRO_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/new-synchro/tpd-summary!addAttachment.jspa'/>",
            projectID:${projectID?c},
            endMarketID:${endMarketId?c},
            parentForm:$j("#tpd-proposal-form"),
            items:[
                {id:${bussinessQuestionID?c},name:'Business Question'},
                {id:${researchObjectiveID?c},name:'Research Objective(s)'},
                {id:${actionStandardID?c},name:'Action Standard(s)'},
                {id:${researchDesignID?c},name:'Methodology Approach and Research design'},
                {id:${sampleProfileID?c},name:'Sample Profile (Research)'},
                {id:${stimulusMaterialID?c},name:'Stimulus Material'},
                {id:${otherReportingRequirementID?c},name:'Other Reporting Requirements'},
                {id:${othersID?c},name:'Other Comments'}
            ]

        });

        $j("#fileAttachBtn").bind('click',function(){
            attachmentTPDStatusWindow.show();
        });
    });

    function showAttachmentPopup(fieldId) {
      
	
		attachmentWindow.show(fieldId);
		var p = $j('.j-form-popup').is(":visible");	
			if(p){
				if($j('.custom_overlay').length < 1){
					$j('body').append("<div class='custom_overlay'></div>");
				}
				$j('.js_lb_overlay').remove();
			}
    }
	
	function showAttachmentPopupTPDSKUDetails(fieldId,rowId) {
      
	   var sameAsPrevSubmittedHiddenParamAtt = "";
	   var rowCounter = 1;
		$j('.tpd-summary-table .tr').each(function(){ 
			
			var attachment = $j(this).find('.jive-attach-item').length;  
			if(rowCounter==1)
			  {
			     rowCounter++;
			  
			  }
			 else
			 {
				var sameAsPrevSubmitted = $j(this).find('input[type="checkbox"]').is(':checked'); 
				
				if(sameAsPrevSubmitted)
				{
					if(sameAsPrevSubmittedHiddenParamAtt=="")
					{
						sameAsPrevSubmittedHiddenParamAtt="yes";
					}
					else
					{
						sameAsPrevSubmittedHiddenParamAtt=sameAsPrevSubmittedHiddenParamAtt+",yes";
					}
				}
				else
				{	
					if(sameAsPrevSubmittedHiddenParamAtt=="")
					{
						sameAsPrevSubmittedHiddenParamAtt="no";
					}
					else
					{
						sameAsPrevSubmittedHiddenParamAtt=sameAsPrevSubmittedHiddenParamAtt+",no";
					}
				}  
			 }			
			 });
				
									
						$j("#sameAsPrevSubmittedHidden").val(sameAsPrevSubmittedHiddenParamAtt);

		
		attachmentWindow.show(fieldId,'TITLE', -1, -1, rowId );
		var p = $j('.j-form-popup').is(":visible");	
			if(p){
				if($j('.custom_overlay').length < 1){
					$j('body').append("<div class='custom_overlay'></div>");
				}
				$j('.js_lb_overlay').remove();
			}
    }
	
	function showAttachmentPopupNew(fieldId, reportType, reportOrderId) {
      	
	
	
		var sameAsPrevSubmittedHiddenParamAtt = "";
	   var rowCounter = 1;
		$j('.tpd-summary-table .tr').each(function(){ 
			
			var attachment = $j(this).find('.jive-attach-item').length;  
			if(rowCounter==1)
			  {
			     rowCounter++;
			  
			  }
			 else
			 {
				var sameAsPrevSubmitted = $j(this).find('input[type="checkbox"]').is(':checked'); 
				
				if(sameAsPrevSubmitted)
				{
					if(sameAsPrevSubmittedHiddenParamAtt=="")
					{
						sameAsPrevSubmittedHiddenParamAtt="yes";
					}
					else
					{
						sameAsPrevSubmittedHiddenParamAtt=sameAsPrevSubmittedHiddenParamAtt+",yes";
					}
				}
				else
				{	
					if(sameAsPrevSubmittedHiddenParamAtt=="")
					{
						sameAsPrevSubmittedHiddenParamAtt="no";
					}
					else
					{
						sameAsPrevSubmittedHiddenParamAtt=sameAsPrevSubmittedHiddenParamAtt+",no";
					}
				}  
			 }			
			 });
				
									
						$j("#sameAsPrevSubmittedHidden").val(sameAsPrevSubmittedHiddenParamAtt);
		attachmentWindow.show(fieldId,'TITLE', reportType, reportOrderId);
    }
	
	function showAttachmentTPDStatus(fieldId) {
      	
		attachmentTPDStatusWindow.show(fieldId);
    }
</script>


 


<script type="text/javascript">
    var initiateKantarWaiverWindow = null;
    $j(document).ready(function(){
       <#-- initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request for Agency Waiver',confirmOnClose:false});
        FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#kantar-waiver-form"), projectID:${projectID?c}}); -->
    });

</script>






</div>
</div>


</form>

</#if>

<!-- tpd pop-up -->
	<div id="tpdStatusPopup" style="display:none;" class="wellLayoutPop	 view_edit_pib">
	
	<form id="tpd-proposal-form" action="<@s.url value='/new-synchro/tpd-summary!updateProposalDetails.jspa'/>" method="post" class="j-form-popup clearfix" enctype="multipart/form-data">
		<a href="javascript:void(0);" class="close" onclick="closetpdStatusPopup();"></a>
		 
			 <div class="popup-title-overlay"></div>
			  <div class="pop-upinner-scroll">
			  <div class="pop-upinner-content">
		
		<#--<i>Changing the status and approver will overwrite the existing status and approver name</i>-->
		<div class="region-inner">
			<div class="form-select_div">
				<label>TPD Status</label>
				<#if tpdSummary?? && tpdSummary.legalApprovalStatus?? >
					<@renderLegalApprovalStatusFieldsTPDScreen name='legalApprovalStatusTPD' value="${tpdSummary.legalApprovalStatus}" />
				<#else>
					<@renderLegalApprovalStatusFieldsTPDScreen name='legalApprovalStatusTPD' value="-1" />
				</#if>
				<span class="jive-error-message custom-error-msg" id="legalApprovalStatusTPDError" style="display:none">Please select TPD Status</span>
			</div>
		</div>
		
		<div class="form-select_div form-select_div_project_completion region-inner">
		
			<label>Legal Approval Provided By</label>
			<div>
				
				<#if project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId()>
				
					<#if tpdSummary.legalApproverOffline??>
						<input type="text" id="proposalLegalApprover" placeholder="Enter Legal Approver’s Name" name="legalApproverOffline"  value="${tpdSummary.legalApproverOffline}"    onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter Legal Approver’s Name'"/>
					<#else>
						<input type="text"  id="proposalLegalApprover" placeholder="Enter Legal Approver’s Name" name="legalApproverOffline"  value=""  onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter Legal Approver’s Name'"/>
					</#if>	
				<#else>
				
					<select data-placeholder="Select Legal Approver"  class="chosen-select" id = "proposalLegalApprover" name='proposalLegalApprover' >
					<option value=""></option>
					  
					   <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
					   <#assign endMarketApproversKeySet = endMarketLegalApprovers.keySet() />
					   <#list endMarketApproversKeySet as key>
							<optgroup label="${endMarkets.get(key?int)}">
							<#list endMarketLegalApprovers.get(key) as legalUser >
								<#if tpdSummary?? && tpdSummary.legalApprover?? && tpdSummary.legalApprover == legalUser.ID>
									<option value="${legalUser.ID?c}" selected>${legalUser.name}</option>
								<#else>
									<option value="${legalUser.ID?c}">${legalUser.name}</option>
								</#if>
							</#list>
							</optgroup>
					   </#list>
							
					</select>
				</#if>	
				<span class="jive-error-message custom-error-msg" id="proposalLegalApproverError" style="display:none">Please enter Legal Approver’s Name</span>
			</div>
		</div>
		
		<div class="region-inner">
			<label>E-mail Approval</label>
			<div class="form-text_div">
				<div class="field-attachments">
					
					<@synchroTPDSummaryAttachements attachments=tpdSummaryLegalApproverAtt  canAttach=true maxAttachCount=30 attachmentCount=3  />	
					<#--<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentTPDStatus(${tpdSummaryLegalApprovalID})"></span>
					
					<#if attachmentMap?? && attachmentMap.get(tpdSummaryLegalApprovalID)?? >
						<div id="jive-file-list" class="attachmentsNew jive-attachments">
							<#list attachmentMap.get(tpdSummaryLegalApprovalID) as attachment>
								<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
									<span class="jive-icon-med jive-icon-attachment"></span>
									<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
										<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${tpdSummaryLegalApprovalID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
									</#if>
									
									<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
									${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
								</div>
							</#list>
						</div>
					</#if>-->
					<span class="jive-error-message" id="tpdSummaryLegalApproverAttError" style="display:none">Please attach E-Mail Approval</span>
				</div>
				
				
			</div>
		</div>
		
		<div class="form-select_div form-select_div_project_completion region-inner">
							
			<label>Date of Legal Approval</label>
			<div>
				
			<@synchrodatetimepicker id="tpdLegalApprovalDate" name="tpdLegalApprovalDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  placeholder="Select Date"  />
			
			<span class="jive-error-message" id="tpdLegalApprovalDateError" style="display:none">Please select Date of Legal Approval</span>
				
			</div>
		</div>
		

		<div id="tpdSummaryRSFields" style="display:none">
			<div class="region-inner">
				<div class="form-select_div form-select_div_project_completion region-inner">
					<label>TPD Summary Legal Approver</label>
					
						<input type="text" id="tpdSummaryRSLegalApprover" placeholder="Select Legal Approver" name="tpdSummaryRSLegalApprover"  value=""  />
						<span class="jive-error-message custom-error-msg" id="tpdSummaryRSLegalApproverError" style="display:none">Please enter TPD Summary Legal Approver</span>
					
				</div>
			</div>
			
			<div class="region-inner">
				<div class="form-select_div">
					<label>TPD Summary Date Legal Approver</label>
					
						<@synchrodatetimepicker id="tpdSummaryRSLegalApprovalDate" name="tpdSummaryRSLegalApprovalDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  placeholder="Select Date"  />
						<span class="jive-error-message custom-error-msg" id="tpdSummaryRSLegalApprovalDateError" style="display:none">Please enter TPD Summary Date Legal Approver</span>	
					
					
				</div>
				
			</div>
			
			<div class="region-inner">
				<div class="form-select_div">
					<label>TPD Summary Attachment</label>
					<@synchroTPDSummaryRSAttachements attachments=tpdSummaryRSLegalApproverAtt  canAttach=true maxAttachCount=30 attachmentCount=3  />	
					<span class="jive-error-message custom-error-msg" id="tpdSummaryRSLegalApproverAttError" style="display:none">Please attach TPD Summary Attachment</span>
				</div>
			</div>
		</div>
		
		<div class="region-inner">
			<a id="tpdPublish" href="javascript:void(0);" style="margin-left: 10px;"  onclick="saveProposalDetails();" class="publish-details btn">Save</a>
			<a href="javascript:void(0);" onclick="closetpdStatusPopup();" style="margin-left: 10px;" class="btn-blue btn cancel-btn">Cancel</a>
		</div>
		<input type="hidden" id="projectID" name="projectID" value="${projectID?c}" />
	</div>
	</div>
	</div>
	</form>
	</div>
	<!-- tpd pop-up -->









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
    <div class="popup-waiver">
  
   
		
        <form id="waiver-form" action="<@s.url value="/new-synchro/tpd-summary!updateWaiver.jspa"/>" method="post" class="j-form-popup">
        	
        	 
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
		    </#if>
			
        	 <h3>Request for Methodology Waiver</h3>
          
		    
		    
           
            <div class="top-heading-Waiver"><label class='rte-editor-label'>Methodology Deviation Rationale</label></div>
            <div class="pib_view_popup form-text_div resetpadd-marg">
            <#if isAdminUser>
                <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>

			<#elseif !(isProjectCreator) >
                <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            
           
           
            <#elseif  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
				
			<#elseif  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==2>
                <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
				
			<#elseif pibMethodologyWaiver?? && pibMethodologyWaiver.status?? && pibMethodologyWaiver.status==0>
				<textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>		
				
            <#else>
                <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            </#if>
			<span class="jive-error-message" id="methDeviationError" style="display:none">Please enter Methodology Deviation Rationale</span>
            </div>
            <div class="pib_view_popup">
                

                
            <#if isAdminUser>
               <#-- <input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />-->
			   
			   <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
             

            <#elseif  isProjectCreator>
                <#if  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                    <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
                   
                <#elseif  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==2>
                   <#--   <input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
				-->
				
				<input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
				
				<#elseif  pibMethodologyWaiver.status?? && pibMethodologyWaiver.status==0>
                      <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
				
				
				
				<#else>
                  <#--  <input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />-->
				  
				  <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
             
                </#if>

            <#else>
                <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
             
            </#if>

            </div>

            <div class="pib_view_popup">
                <label>Methodology Approver Comment</label>

                
            <#if isAdminUser>
                <textarea id="methodologyApproverComment" name="methodologyApproverComment" disabled placeholder="Methodology Approver Comments">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
		<span class="jive-error-message" id="methWaiverError" style="display:none">Please enter Methodology Approver Comments</span>

            <#elseif isSynchroSystemOwner>
                <#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                    <textarea id="methodologyApproverComment"  disabled name="methodologyApproverComment">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
			<span class="jive-error-message" id="methWaiverError" style="display:none">Please enter Methodology Approver Comments</span>
                <#else>
                    <textarea id="methodologyApproverComment" disabled name="methodologyApproverComment" placeholder="Methodology Approver Comments">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
			<span class="jive-error-message" id="methWaiverError" style="display:none">Please enter Methodology Approver Comments</span>
               
                </#if>

                
            <#else>
                <textarea id="methodologyApproverComment"  disabled name="methodologyApproverComment">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
		<span class="jive-error-message" id="methWaiverError" style="display:none">Please enter Methodology Approver Comments</span>
            </#if>
            </div>

            
        <#if isAdminUser>
          <#--  <input id="request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
            <input id="approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
            <input id="reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />
			-->
			
			  <input type="button" class="g-btn r-more" name="doPost" id="postButton"  value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
			   <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton"  value="Approve" style="font-weight: bold;cursor:default;" />
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />

        <#elseif isSynchroSystemOwner>

			<#--
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

			-->
			
			 <input type="button" class="g-btn r-more" name="doPost" id="postButton"  value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
			   <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton"  value="Approve" style="font-weight: bold;cursor:default;" />
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />

            
        <#else>
            <input type="button" class="g-btn r-more"  name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium"  name="doPost" id="postButton" value="Approve" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />
        </#if>
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" name="endMarketId" value="${endMarketId?c}">
            <input type="hidden" id="methodologyWaiverAction" name="methodologyWaiverAction" value="">
        </div>
			
			</div>
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

  

        <form id="kantar-waiver-form" action="<@s.url value='/new-synchro/tpd-summary!updateKantarWaiver.jspa'/>" method="post">
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
			</#if>
		     <div class="pop-upinner-content">
            <h3>Agency Deviation Rationale</h3>
            <div class="pib_view_popup form-text_div">
            <label class='rte-editor-label'>Agency Deviation Rationale</label>
            <div class="pib_view_popup form-text_div">
            <#if isAdminUser>
                <textarea id="methodologyDeviationRationaleKantar" name="methodologyDeviationRationale" disabled placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>

            <#elseif !(isProjectCreator) >
                <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            <#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
				
			<#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
                <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>

			<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status==0>
				<textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>		
				
            <#else>
                <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            </#if>
			<span class="jive-error-message" id="agencyDeviationError" style="display:none">Please enter Agency Deviation Rationale</span>
            </div>
			
			

			<div class="waiver-summary">
			
			<a href='${JiveGlobals.getJiveProperty("synchro.agency.waiver.template.path"," /file/download/AgencyCostDetails-SingleMarketTemplate.xlsx")}'>Download Agency Waiver Summary Template</a>
			
			<p>Waiver Summary</p> 
		<#--	<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${agencyWaiverID?c})" ></span> -->
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
               <#-- <input id="kantar-send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />-->
			   
			    <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
				
               

            <#elseif isProjectCreator>
                <#if  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                    <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
				
				<#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
                   <#--  <input id="kantar-send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" /> -->
				   
				    <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
				
				
				<#elseif  pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status==0>
                      <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
				
					
                <#else>
                   <#-- <input id="kantar-send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" /> -->
				   
				    <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
				
              
                </#if>

            <#else>
                <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
              
            </#if>

            </div>

            <div class="pib_view_popup">
                <label>Approver's Comment</label>

                
            <#if isAdminUser>
                <textarea id="methodologyApproverCommentKantar" disabled name="methodologyApproverComment" placeholder="Methodology Approver Comments">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
		<span class="jive-error-message" id="methKantarWaiverError" style="display:none">Please enter Methodology Approver Comments</span>

            <#elseif  isSynchroSystemOwner>
                <#if pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                    <textarea id="methodologyApproverCommentKantar"  disabled name="methodologyApproverComment">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
		    <span class="jive-error-message" id="methKantarWaiverError" style="display:none">Please enter Methodology Approver Comments</span>
                <#else>
                    <textarea id="methodologyApproverCommentKantar" disabled name="methodologyApproverComment" placeholder="Methodology Approver Comments">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
              <span class="jive-error-message" id="methKantarWaiverError" style="display:none">Please enter Methodology Approver Comments</span>
                </#if>

                
            <#else>
                <textarea id="methodologyApproverCommentKantar"  disabled name="methodologyApproverComment">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
		<span class="jive-error-message" id="methKantarWaiverError" style="display:none">Please enter Methodology Approver Comments</span>
            </#if>
            </div>

            
        <#if isAdminUser>
        <#--    <input id="kantar-request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
            <input id="kantar-approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
            <input id="kantar-reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" /> -->
			
			 <input type="button" class="g-btn r-more"  name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium"  name="doPost" id="postButton" value="Approve" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />

        <#elseif isSynchroSystemOwner>

           <#-- 
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
            </#if> -->
			
			 <input type="button" class="g-btn r-more"  name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium"  name="doPost" id="postButton" value="Approve" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />

	    <#if pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                <input type="button" class="g-btn r-more" name="doPost" id="postButton"  value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
            <#else>
              <#--  <input id="kantar-request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" /> -->
			  
			  <input type="button" class="g-btn r-more" name="doPost" id="postButton"  value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
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
			</div>
        </form>
    </div>
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
			  <h3>Project Details Overview</h3>
			  
            <div class="pib_view_popup region-inner">
                <label>Project Name </label>
            <input type="text" id="projectName" disabled name="projectName" value="${project.name?html}" class="pit_window_field_width"/>
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
				
					<span class="jive-error-message" id="categoryTypeError" style="display:none">Please enter CategoryType</span>
					
				
				</div>
			</div>
			
			<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId()) >
			<#else>
				<div class="region-inner">
					
					<div class="form-select_div">
						
						<label>Is the project a fieldwork component of an above market study?</label>
					
					<@fieldworkstudyField name='fieldWorkStudy' value=project.fieldWorkStudy?default('-1') readonly=true/>
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
				
						<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets' multiple disabled >
						<option value=""></option>
					    <#assign endMarketRegions = statics['com.grail.synchro.SynchroGlobal'].getRegionEndMarketsMapping() />
					    <#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
					    <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
						 <#assign endMarketTypeMap = statics['com.grail.synchro.SynchroGlobal'].getEndmarketMarketTypeMap() />
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
						<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets' disabled >
					
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
					</#if>					</select>
					<span class="jive-error-message" id="endMarketError" style="display:none"><@s.text name='project.error.endmarket' /></span>
				
				</div>
			</div>
			
			<div class="region-inner">
					
				<div class="form-select_div start_date">
					<label>Project Start</label>
			   
				<input type="text"  name="startDate" value="" disabled id="startDate"  />
				<#assign error_msg><@s.text name='project.error.startdate' /></#assign>
				<@macroCustomFieldErrors msg=error_msg />
				<@macroFieldErrors name="startDate"/>
				</div>
			</div>	
			<div class="region-inner">
				<div class="form-select_div form-select_div_project_completion">
					<label>Project Completion</label>
					 
				
				<input type="text"  name="endDate" value="" disabled id="endDate"  />
				<#assign error_msg><@s.text name='project.error.enddate' /></#assign>
				<@macroCustomFieldErrors msg=error_msg />
				<@macroFieldErrors name="endDate"/>
				</div>
			</div>
			
			<div class="region-inner">
				
				
				<div class="form-select_div">
					<label>SP&I Contact</label>
					<div>
					
					   
					<input type="text"  name="projectManagerName" value="${project.projectManagerName}" disabled id="projectManagerName"  />

					<#assign error_msg><@s.text name="project.error.owner"/></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
				</div>

				<!-- Project SP&I Contact -->
		
				<#--
				<div class="form-select_div form-select_div_project_completion">
					
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
							<select data-placeholder="Select Methodology" class="chosen-select" id = "methodologyDetails" name = "methodologyDetails" multiple disabled >
						<#else>
							<select data-placeholder="Select Methodology" class="chosen-select" id = "methodologyDetails" name = "methodologyDetails" disabled >
						</#if>
						  <option value=""></option>
							   <#assign methMethGroupMapping = statics['com.grail.synchro.SynchroGlobal'].getMethodologyMapping() />
							   <#assign methGroup = statics['com.grail.synchro.SynchroGlobal'].getMethodologyGroups(true, 0) />
							   <#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getMethodologies() />
							   <#assign methodologyProperties = statics['com.grail.synchro.SynchroGlobal'].getMethodologyProperties() />
									<#assign methMethGroupKeySet = methMethGroupMapping.keySet() />
									<#if (methMethGroupMapping?has_content)>
										<#list methMethGroupKeySet as key>
											 <optgroup label="${methGroup.get(key)}">
												 <#assign methKeySet = methMethGroupMapping.get(key).keySet() />
												 <#list methKeySet as methkey>
													<#if methodologyProperties.get(methkey).isLessFrequent() >
														<option lessFrequent="yes" value="${methkey?c}" <#if project.methodologyDetails?seq_contains(methkey)> selected</#if>>${methodologies.get(methkey)}</option>
													<#else>
														<option lessFrequent="no" value="${methkey?c}" <#if project.methodologyDetails?seq_contains(methkey)> selected</#if>>${methodologies.get(methkey)}</option>
													</#if>
												 </#list>
											</optgroup>	 
										</#list>
									</#if>
						</select>
						<span class="jive-error-message" id="endMarketError" style="display:none"><@s.text name='project.error.endmarket' /></span>
					
					</div>
				</div>

				<div class="region-inner">
					<!-- Methodology Group -->
					<div class="form-select_div">
						<label>Methodology Type</label>
				
					<@renderMethodologyField name='methodologyType' value=project.methodologyType?default('-1') readonly=true/>
					<@macroCustomFieldErrors msg="Please select Methodology Type" />
					
					</div>
					
				</div>
				
				<div class="region-inner">
					
					<div class="form-select_div">
						<label>Will a methodology waiver be required?</label>
					
					<#--<@renderMethodologyWaiverField name='methWaiverReq' value=project.methWaiverReq?default('-1') />-->
					
					<select data-placeholder="Select" class="chosen-select" id = "methWaiverReq" name="methWaiverReq"  disabled onchange="checkMethDeviation()">
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
								<span>Status: <span class="status-txt approvedStatus">Approved</span></span>
							<#elseif pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==2>
								<span>Status: <span class="status-txt rejectedStatus">Rejected</span></span>
							<#else>
								<span>Status: <span class="status-txt pendingStatus">Pending</span></span>
							</#if>
						</div>
					</#if>
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
					<div id="waiverMessage" style="display:none">You will be able to initiate waiver through the system once the project is created</div>
				</div>
				
				<div class="region-inner">
					
					<div class="form-select_div">
						<label>Is this a brand specific study?</label>
					
					<@renderBrandSpecificStudy name='brandSpecificStudy' value=project.brandSpecificStudy?default('-1') readonly=true/>
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					<div id="brandSpecific" style="display:none">
					
					<div class="form-select_div">
						
					
					<@renderBrandFieldNew name='brand' value=project.brand?default('-1') readonly=true/>
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
					
					</div>
					<div id="brandSpecificStudyType">
					
					
										
					<@renderBrandSpecificStudyType name='brandSpecificStudyType' value=project.brandSpecificStudyType?default('-1') readonly=true/>
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					
					</div>
					</div>
					
					
				</div>
				
				
				<div class="region-inner">
					
					<div class="form-select_div">
						<label>Budget Location</label>
					
					<#if isAdminUser>
					
						<select data-placeholder="Select the Budget Location" disabled class="chosen-select" id = "budgetLocation" name="budgetLocation" >
							<option value=""></option>
								<#if project.projectType?? && project.projectType==1>
									<option  value="-1" <#if project.budgetLocation==-1> selected </#if> >Global</option>
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
					<#else>
						
						
						<#assign userBudgetLocation = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationEndMarkets(user) />
						
						<select data-placeholder="Select the Budget Location" class="chosen-select" disabled id = "budgetLocation" name="budgetLocation" >
							<option value=""></option>
								<#if project.projectType?? && project.projectType==1>
									<#if statics['com.grail.synchro.util.SynchroPermHelper'].isGlobalUserType()>
										<option  value="-1" <#if project.budgetLocation==-1> selected </#if> >Global</option>
									</#if>
								<#elseif project.projectType?? && project.projectType==2>
									<#if statics['com.grail.synchro.util.SynchroPermHelper'].isRegionalUserType()>
										<#assign userRegionBudgetLocation = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationRegions(user) />
										<#list userRegionBudgetLocation as uRegionBugLoc>
											<#if project?? && project.budgetLocation?? && project.budgetLocation==uRegionBugLoc>
												<option  value="${uRegionBugLoc}" selected >${regions.get(uRegionBugLoc?int)}</option>
											<#else>
												<option  value="${uRegionBugLoc}" >${regions.get(uRegionBugLoc?int)}</option>
											</#if>
										</#list>
									</#if>
								<#else>	
									<#--<#if userBudgetLocation?? && userBudgetLocation?size gt 0 >
								
										<#list userBudgetLocation as ubugLoc>
										<option  value="${ubugLoc}" <#if project.budgetLocation?int==ubugLoc?int> selected </#if>>${endMarkets.get(ubugLoc?int)}</option>
										</#list>
									</#if>
									-->
									<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
									<#assign endMarketsKeySet = endMarkets.keySet() />
									
									<#list endMarketsKeySet as key>
										<option  value="${key}" <#if project.budgetLocation==key> selected </#if>>${endMarkets.get(key?int)}</option>
									</#list>
								</#if>
								
								<#--<#if statics['com.grail.synchro.util.SynchroPermHelper'].isGlobalUserType()>
									<option  value="-1" <#if project.budgetLocation==-1> selected </#if> >Global</option>
								</#if>
								
								<#if statics['com.grail.synchro.util.SynchroPermHelper'].isRegionalUserType()>
									<#assign userRegionBudgetLocation = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationRegions(user) />
									<#list userRegionBudgetLocation as uRegionBugLoc>
										<#if project?? && project.budgetLocation?? && project.budgetLocation==uRegionBugLoc>
											<option  value="${uRegionBugLoc}" selected >${regions.get(uRegionBugLoc?int)}</option>
										<#else>
											<option  value="${uRegionBugLoc}" >${regions.get(uRegionBugLoc?int)}</option>
										</#if>
									</#list>
								</#if>
							
								<#if userBudgetLocation?? && userBudgetLocation?size gt 0 >
									
									<#list userBudgetLocation as ubugLoc>
									<option  value="${ubugLoc}" <#if project.budgetLocation==ubugLoc> selected </#if>>${endMarkets.get(ubugLoc?int)}</option>
									</#list>
								</#if>-->
						</select>
					</#if>	
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
				</div>

				<div class="region-inner">
				<@projectBudgetYearFieldNew name="budgetYear" value=project.budgetYear readonly=true/>
					<@macroCustomFieldErrors msg="Please enter Budget Year" />
					<span class="jive-error-message" id="budgetYearError" style="display:none">Please enter Budget Year</span>
				</div>
				
				<div id="expenseDetailsContainer" class="region-inner">
					<label>Cost Details</label>
					<div class="border-box pit_window_field_width border-inputradius">
					
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
							<div class="pit-estimate-cost gbp-costalignment">
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
									<input type="text" placeholder="0" name="totalCost" class="text_field numericfield longField" value="${project.totalCost}" disabled />
								  <#else>
									<input type="text" placeholder="0" name="totalCost" class="text_field numericfield longField" value="" disabled />
								  </#if>

							<#assign error_msg><@s.text name="project.error.cost"/></#assign>
							<@macroCustomFieldErrors msg=error_msg class="numeric-error"/>
							</div>
							
						</div>
	 
					</div>
					<div id="nonKantarAgencyMessage" style="display:none">This project requires a waiver for using non-Kantar agency. You can initiate a waiver once a project is created.
					</div>
					</div>
				</div>
				
			<div class="project_waiver_rqst region-inner" id="agencyWaiverDivPIT">
				<label>Agency Waiver Request</label>
				<ul class="right-sidebar-list">

					<li id="initiateKantarWaiverButtonPIT" ><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>
				</ul>
				
				<div  class="agency_methodology" id="nonKantarWaiverStatus" <#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>style="display:block;" <#else> style="display:none;"</#if>>

					<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
						<span class="approvedStatus">Status: Approved</span>
					<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
						<span class="rejectedStatus">Status: Rejected</span>
					<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID?? >
						<span class="pendingStatus">Status: Pending</span>
					<#else>
					</#if>

				
				</div>
			</div>
			
		<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
			
			<#-- two column row code replace-->
			
			<div class="region-inner two-column">
					
				<div class="form-select_div">
					<label>Would this project need end market funding?</label>
				
					<#if project.endMarketFunding??>
							<@renderEndMarketFundingField name='endMarketFunding' value=project.endMarketFunding?default('-1') readonly=true/>
					<#else>
							<@renderEndMarketFundingField name='endMarketFunding' value=-1 readonly=true/>
					</#if>
				
				</div>
				
				<div class="form-select_div second-column" id="fundingMarketsDiv" <#if project.endMarketFunding?? && project.endMarketFunding==1> style="display:block" <#else>style="display:none"</#if>>
					<label>Select markets participating in the funding</label>
				
					<#if project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId()>
						<select data-placeholder="Select end market" class="chosen-select" disabled id = "fundingMarkets" name="fundingMarkets" multiple >
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
					
						<select data-placeholder="Select end market" class="chosen-select" disabled id = "fundingMarkets" name="fundingMarkets" >
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

					
					</#if>
				</div>
			</div>			
			</#if>	
				
			<div class="region-inner">
					<label class="pit-description-label">Brief</label>
				   
					  
					<div class="form-text_div">
						<textarea id="brief" name="brief" rows="10" cols="20" disabled class="form-text-div">${projectInitiation.brief?default('')?html}</textarea>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
					</div>
					<textarea style="display:none;" id="briefText" name="briefText">${projectInitiation.briefText?default('')?html}</textarea>
					 <!-- ATTACHMENT DISPLAY STARTS -->
						<div class="field-attachments">
					   <#if projectInitiation?? && projectInitiation.sendForApproval?? && projectInitiation.sendForApproval==1 >
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
						<span class="approval-status popTpd">TPD Status: <span class="status-txt">May have to be Submitted</span></span>
					<#elseif projectInitiation?? && projectInitiation.legalApprovalStatus?? && (projectInitiation.legalApprovalStatus==2)  >
						<span class="approval-status popTpd">TPD Status: <span class="status-txt">Does not have to be Submitted</span></span>
					</#if>
				</#if>
				
				<#if project.processType?? && project.processType !=  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId()>
				
					<div class="form-select_div form-select_div_project_completion region-inner">
						
						<label>Legal Approver's Name</label>
						<div>
							
							<#if projectInitiation?? && projectInitiation.getBriefLegalApproverOffline()??>
								<#assign legalApproverName = projectInitiation.getBriefLegalApproverOffline() />
							<#elseif projectInitiation?? && projectInitiation.briefLegalApprover??>
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
				</div>
				
				<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
				
					 <div class="region-inner">
						<div class="form-select_div">
							<label>TPD Status</label>
							<#if projectInitiation?? && projectInitiation.legalApprovalStatus?? >
								<@renderLegalApprovalStatusFieldsTPDScreen name='legalApprovalStatusPit' value="${projectInitiation.legalApprovalStatus}" readonly=true/>
							<#else>
								<@renderLegalApprovalStatusFieldsTPDScreen name='legalApprovalStatusPit' value="-1" readonly=true/>
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
				
				<#if project.status?? && (project.status gt statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].BRIEF_IN_PLANNING.ordinal()) >
				
				<div class="region-inner">
					<label class="pit-description-label">Proposal</label>
				   
					  
					<div class="form-text_div">
						<textarea id="proposal" name="proposal" rows="10" cols="20" disabled class="form-text-div">${proposalInitiation.proposal?default('')?html}</textarea>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
					</div>
					<textarea style="display:none;" id="proposalText" name="proposalText">${proposalInitiation.proposalText?default('')?html}</textarea>
					 <!-- ATTACHMENT DISPLAY STARTS -->
						<div class="field-attachments">
					   <#if proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
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
						<#--	<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${proposalID?c})" ></span> -->
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
								<span class="approval-status popTpd">TPD Status: <span class="status-txt">May have to be Submitted</span></span>
							<#elseif proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus==2)  >
								<span class="approval-status popTpd">TPD Status: <span class="status-txt">Does not have to be Submitted</span></span>
							</#if>
						</#if>
						
						<#if project.processType?? && project.processType !=  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId()>
							<div class="form-select_div form-select_div_project_completion region-inner">
								
								<label>Legal Approver's Name</label>
								<div>
									
									<#if proposalInitiation?? && proposalInitiation.getProposalLegalApproverOffline()??>
										<#assign legalApproverName = proposalInitiation.getProposalLegalApproverOffline() />
									<#elseif proposalInitiation?? && proposalInitiation.proposalLegalApprover??>
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
							</div>
							
							<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
						
							 <div class="region-inner">
								<div class="form-select_div">
									<label>TPD Status</label>
									<#if proposalInitiation?? && proposalInitiation.legalApprovalStatus?? >
										<@renderLegalApprovalStatusFieldsTPDScreen name='legalApprovalStatusPit' value="${proposalInitiation.legalApprovalStatus}" readonly=true/>
									<#else>
										<@renderLegalApprovalStatusFieldsTPDScreen name='legalApprovalStatusPit' value="-1" readonly=true/>
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
				
				</#if>

				<#if project.status?? && (project.status gt statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].PROPOSAL_IN_PLANNING.ordinal()) >

				<div class="region-inner">
					<label class="pit-description-label">Documentation</label>
				   
					  
						<div class="form-text_div">
						<textarea id="documentation" name="documentation" rows="10" cols="20" disabled class="form-text-div">${projectSpecsInitiation.documentation?default('')?html}</textarea>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
					</div>
					<textarea style="display:none;" id="documentationText" name="documentationlText">${projectSpecsInitiation.documentationText?default('')?html}</textarea>
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
				
				</#if>

				<#if project.status?? && (project.status gt statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].IN_PROGRESS.ordinal()) >
				
				<!-- Report Summary Starts -->
				<div class="region-inner">
					<label class="pit-description-label">Project Reports</label>
					<div class="table">
					<div class="tr table-header ">
						<div class="th">Report Type</div>
						<div class="th">Legal Approval Provided By</div>
						<div class="th">Attached Report</div>
					</div>
					
					
					
					
					
					<#if reportSummaryDetailsList?? && reportSummaryDetailsList?size gt 0 >
					<#list reportSummaryDetailsList as reportSummaryDetails>
						<#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT.getId()>
						<div class="tr">
						<div class="td"><div class="disabled-box border-inputradius">Full Report</div></div>
						<div class="td"><div class="disabled-box border-inputradius">${reportSummaryDetails.getLegalApprover()}</div></div>
						
						<div class="td" id="attachmentDiv">
						<#if attachmentMap?? && attachmentMap.get(fullReportID)?? >
							<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
							<div id="jive-file-list" class="jive-attachments">
							
							
							 	<#list attachmentMap.get(fullReportID) as attachment>
									<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
									<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
										<span class="jive-icon-med jive-icon-attachment"></span>
										
										<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
										${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
									</div>
									</#if>
								</#list>
							</div>
							</#if>
						</#if>
						</div>
						</div>
						<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TOP_LINE_REPORT.getId()>
						<div class="tr">
						<div class="td"><div class="disabled-box border-inputradius">Top Line Report</div></div>
						<div class="td"><div class="disabled-box border-inputradius">${reportSummaryDetails.getLegalApprover()}</div></div>
						<div class="td" id="attachmentDiv">
						<#if attachmentMap?? && attachmentMap.get(fullReportID)?? >
							<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
							<div id="jive-file-list" class="jive-attachments">
							
							
							 	<#list attachmentMap.get(fullReportID) as attachment>
									<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
									<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
										<span class="jive-icon-med jive-icon-attachment"></span>
										
										<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
										${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
									</div>
									</#if>
								</#list>
							</div>
							</#if>
						</#if>
						</div>
						</div>
						<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].EXECUTIVE_PRESENTATION.getId()>
						<div class="tr">
						<div class="td"><div class="disabled-box border-inputradius">Executive Presentation</div></div>
						<div class="td"><div class="disabled-box border-inputradius">${reportSummaryDetails.getLegalApprover()}</div></div>
						<div class="td" id="attachmentDiv">
						<#if attachmentMap?? && attachmentMap.get(fullReportID)?? >
							<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
							<div id="jive-file-list" class="jive-attachments">
							
							
							 	<#list attachmentMap.get(fullReportID) as attachment>
									<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
									<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
										<span class="jive-icon-med jive-icon-attachment"></span>
										
										<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
										${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
									</div>
									</#if>
								</#list>
							</div>
							</#if>
						</#if>
						</div></div>
						<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT_BLANK.getId()>
						<div class="tr">
						<div class="td"><div class="disabled-box border-inputradius"></div></div>
						<div class="td"><div class="disabled-box border-inputradius"><#if reportSummaryDetails.getLegalApprover()?? >${reportSummaryDetails.getLegalApprover()}</#if></div></div>
						<div class="td" id="attachmentDiv">
						<#if attachmentMap?? && attachmentMap.get(fullReportID)?? >
							<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
							<div id="jive-file-list" class="jive-attachments">
							
							
							 	<#list attachmentMap.get(fullReportID) as attachment>
									<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
									<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
										<span class="jive-icon-med jive-icon-attachment"></span>
										
										<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
										${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
									</div>
									</#if>
								</#list>
							</div>
							</#if>
						</#if>
						</div>
						</div>
						<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].IRIS_SUMMARY.getId()>
						<div class="tr">
						<div class="td"><div class="disabled-box border-inputradius">IRIS Summary</div></div>
						<div class="td"><div class="disabled-box border-inputradius"><#if reportSummaryDetails.getLegalApprover()??>${reportSummaryDetails.getLegalApprover()}</#if></div></div>
						
						<div class="td">
						
						<#if attachmentMap?? && attachmentMap.get(irisSummaryReportID)?? >
							<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
							<div id="jive-file-list" class="jive-attachments">
							
							
								<#list attachmentMap.get(irisSummaryReportID) as attachment>
									<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
									<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
										<span class="jive-icon-med jive-icon-attachment"></span>
										<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
										${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
									</div>
									</#if>
								</#list>
							</div>
							</#if>
						</#if>
				
						</div>
						</div>
						<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TPD_SUMMARY.getId()>
						<div class="tr">
						<div class="td"><div class="disabled-box border-inputradius">TPD Summary</div></div>
						<div class="td"><div class="disabled-box border-inputradius"><#if reportSummaryDetails.getLegalApprover()??>${reportSummaryDetails.getLegalApprover()}</#if></div>
						<#if reportSummaryDetails.getLegalApprovalDate()??>
							<div class="disabled-box border-inputradius">${reportSummaryDetails.getLegalApprovalDate()?string('dd/MM/yyyy')}</div>
						</#if></div>
						<div class="td" id="attachmentDiv">
						<#if attachmentMap?? && attachmentMap.get(tpdSummaryReportID)?? >
							<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
							<div id="jive-file-list" class="jive-attachments">
							
							
								<#list attachmentMap.get(tpdSummaryReportID) as attachment>
									<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
									<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
										<span class="jive-icon-med jive-icon-attachment"></span>
										
										<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
										${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
									</div>
									</#if>
								</#list>
							</div>
							</#if>
						</#if>
						</div>
						</div>
						</#if>
						
					</#list>
					</#if>
					
				</div>
				
				<#if methBriefException == "yes">
		
					<div id="legal-checkbox" class="region-inner"><input type="checkbox" name="legalsignoffreqdisable" disabled id="legalsignoffreqdisable" <#if reportSummaryInitiation?? && reportSummaryInitiation.legalSignOffRequired?? && reportSummaryInitiation.legalSignOffRequired==1> checked="true"</#if> >This project does not require Report/IRIS Summary.<br></div>
				</#if>
				
				</div>
				<!-- Report Summary Ends -->
				</#if>		
	
				<#if project.status?? && (project.status gt statics['com.grail.synchro.SynchroGlobal$ProjectStatusNew'].COMPLETE_REPORT.ordinal()) >
				
				<!--Project Evaluation Starts -->
				<#if initiationList?? && initiationList?size gt 0>
				<div class="region-inner">
					<label class="pit-description-label">Project Evaluation</label>
					
					<div class="border-box project-eval-container">
					<#list initiationList as projEvaluation>
						<div class="form-text_div project-eval-div">
						<div class="col-md-5">
<div class="boxinnerContainer">
						<#if projectCostDetailsList?? && projectCostDetailsList?size gt 0 >
							<#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getResearchAgency() />
							<select name="agency" id="eval-agency" data-placeholder="Select Agency" disabled class="chosen-select form-select" >
								<option value=""></option>
								
								<#list projectCostDetailsList as projectCostDetail>
									<option value="${projectCostDetail.getAgencyId()}" <#if projEvaluation.getAgencyId()==projectCostDetail.getAgencyId()> selected</#if>>${researchAgencies.get(projectCostDetail.getAgencyId()?int)}</option>
								</#list>
							</select>
							<span class="jive-error-message full-width" id="evalAgencyError" style="display:none">Please Select Agency</span>
						</#if>
						</div>
						<div class="boxinnerContainer">
						<select name="rating" id="rating" data-placeholder="Select Rating" disabled class="chosen-select form-select" >
						<option value=""></option>
						<option value="1"  <#if projEvaluation.getAgencyRating()==1> selected</#if>>1-Poor</option>
						<option value="2" <#if projEvaluation.getAgencyRating()==2> selected</#if>>2-Unsatisfactory</option>
						<option value="3" <#if projEvaluation.getAgencyRating()==3> selected</#if>>3-Satisfactory</option>
						<option value="4" <#if projEvaluation.getAgencyRating()==4> selected</#if>>4-Good</option>
						<option value="5" <#if projEvaluation.getAgencyRating()==5> selected</#if>>5-Excellent</option>
						</select>
						<span class="jive-error-message full-width" id="ratingError" style="display:none">Please Select Rating</span>
						</div>
						</div>
						<div class="col-md-7" id="commentDiv">
							<textarea id="comment" name="comment"  rows="5" cols="20" disabled class="form-text-div">${projEvaluation.getAgencyComments()}</textarea>
							<span class="jive-error-message full-width" id="commentError" style="display:none">Please Enter Comment</span>	
						</div>
						</div>
					</#list>
					</div>
					
					</div>
				</#if>
				</#if>
				<!--Project Evaluation Ends -->
            
            
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" name="endMarketId" value="${endMarketId?c}">
			</div>
        </form>
    </div>
</div>


</div>


</div>




</div>
  <script type="text/javascript">
     $j(document).ready(function() {
        $j('.chosen-select').chosen();
        $j('.chosen-select-deselect').chosen({ allow_single_deselect: true });
		
		var popupTrue = localStorage.getItem("popupTrue");
		  if(popupTrue){
		   openTpdStatusPopup();
		  }
		  $j('#tpdStatusPopup .close').click(function(){
			   localStorage.removeItem("popupTrue");
		  });
		  $j('#tpdStatusPopup .jive-icon-attachment').click(function(){
			  popupTrue = "true";
		   localStorage.setItem("popupTrue", popupTrue);
		  });
		  $j('#tpdStatusPopup  #jive-file-list .j-remove-file').click(function(){
		   popupTrue = "true";
		   localStorage.setItem("popupTrue", popupTrue);
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
	
	<#if tpdSummary?? && tpdSummary.tpdModificationDate?? >
		var _tpdModificationDate = "${tpdSummary.tpdModificationDate?string('dd/MM/yyyy')}";
		$j("#tpdModificationDate").val(_tpdModificationDate);
	</#if>
	
	<#if tpdSummary?? && tpdSummary.legalApprovalDate?? >
		var _tpdLegalApprovalDate = "${tpdSummary.legalApprovalDate?string('dd/MM/yyyy')}";
		$j("#tpdLegalApprovalDate").val(_tpdLegalApprovalDate);
	</#if>
	
	

				
				

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
		
		var methodologyApproverComment_ifr = $j("#methodologyApproverComment_ifr").contents().find("p").text();
		if(methodologyApproverComment_ifr.trim()=="")
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
		
		var methodologyApproverComment_ifr = $j("#methodologyApproverComment_ifr").contents().find("p").text();
		if(methodologyApproverComment_ifr.trim()=="")
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
		
		var methodologyApproverCommentKantar_ifr = $j("#methodologyApproverCommentKantar_ifr").contents().find("p").text();
		if(methodologyApproverCommentKantar_ifr.trim()=="")
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
		var methodologyApproverCommentKantar_ifr = $j("#methodologyApproverCommentKantar_ifr").contents().find("p").text();
		if(methodologyApproverCommentKantar_ifr.trim()=="")
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

    
  
	


}
function validatePIBFormFields()
{
console.log("validatePIBFormFields");
    showLoader('Please wait...');
    var error = false;

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

    
	
	

    /* Ends : Validation of Text fields*/

     

    

    if(error)
        hideLoader();

	if(error)
	console.log("error");
	else
	console.log("No error");
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
    <#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && (pibKantarMethodologyWaiver.isApproved==1 || pibKantarMethodologyWaiver.isApproved==2)>
		$j("#initiateKantarWaiver").lightbox_me({centered:true,closeEsc:false,closeClick:false,overlayCSS:{background: 'black', opacity: .7}});
	
	<#elseif  pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status==0>
		$j("#initiateKantarWaiver").lightbox_me({centered:true,closeEsc:false,closeClick:false,overlayCSS:{background: 'black', opacity: .7}});
	<#else>
		$j("#initiateKantarWaiver").lightbox_me({centered:true,closeEsc:false,closeClick:false,overlayCSS:{background: 'black', opacity: .7}});
	</#if>
	$j(window).scrollTop(0);
	
	//initiateKantarWaiverWindow.show();
    initiateRTE('methodologyDeviationRationaleKantar', 2500, false);
    initiateRTE('methodologyApproverCommentKantar', 2500, false);
	
	
	<#if !(pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.methodologyApprover??)>
		<#assign kantarBtnClickText><@s.text name="logger.project.kantar.btn.click" /></#assign>
		var projName = "${project.name?js_string}";
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].ADD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].TPD_SUMMARY.getId()}, "${kantarBtnClickText}", projName, ${projectID?c}, ${user.ID?c});
	</#if>
}

/* Initialization of Editor */
$j(document).ready(function () {
    
	initiateRTE('productDescription', 1500, true);
	
});

</script>

<script type="text/javascript">

	<#--<#assign i18CustomText><@s.text name="logger.project.pib.view.text" /></#assign>	-->
	<#assign i18CustomText>View TPD Submission</#assign>
	var projName = "${project.name?js_string}";	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].TPD_SUMMARY.getId()}, "${i18CustomText}", projName, ${projectID?c}, ${user.ID?c});
</script>


  <script type="text/javascript">
  
	
	 $j("#legalApprovalStatusTPD").change(function() {
			
			<#if showTPDSummaryFields>
				 var legalApprovalStatusTPD = $j('select[name="legalApprovalStatusTPD"] option:selected').val();
				 if(legalApprovalStatusTPD=="2")
				 {
					$j("#tpdSummaryRSFields").hide();
					
				 }
				 if(legalApprovalStatusTPD=="1")
				 {
			
					$j("#tpdSummaryRSFields").show();
					  
				 }
			<#else>
				
				
			</#if>	 
			
	});
	
	
  
  
  
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
			
	});
	$j("#endMarkets").change(function() {
			
			dialog({
					title:"",
					html:"<p>You are trying to change 'Research End Market'. This cannot be updated!</p><p>You need to cancel the project and setup it up as a new project on SynchrO with the correct information.</p>",
					buttons:{
					"OK":function() {
						return false;		
					}
				},

				});
			
	});
	
	$j("#fieldWorkStudy").change(function() {
			
			dialog({
					title:"",
					html:"<p>You are trying to change 'Is the project a fieldwork component of an above market study?'. This cannot be updated!</p><p>You need to cancel the project and setup it up as a new project on SynchrO with the correct information.</p>",
					buttons:{
					"OK":function() {
						return false;		
					}
				},

				});
			
	});
	
	function cancelProject()
  {
	
	{
		dialog({
					title:"",
					html:"<p>Are you sure you want to cancel the project</p>",
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
	});
	var mainReportTypecounter = 1;
	$j("#mainReportType").bind("click", function () {
		var value = $j(this).val();
		
		mainReportTypecounter++;
		
		var div = $j("<div class='tr'/>");
		 div.html(addMainReportType(""));
		$j("#mainReportTypeDiv").after(div);
	    $j('.new-report-type').chosen();
		
		  });
		  
	/*	  
	$j("#mainTPDSummaryType").bind("click", function () {
		
		var value = $j(this).val();
		var div = $j("<div class='tr'/>");
		 div.html(addTPDSummaryType(""));
		$j("#mainTPDSummaryTypeDiv").after(div);
	    $j('.new-report-type').chosen();
		
	});
	*/
	
	$j("#mainTPDSummaryType").bind("click", function () {
		var value = $j(this).val();
		tpdReportTypecounter++;
		var div = $j("<div class='tr tpdtr'/>");
		 div.html(addTPDSummaryType(""));
		$j("#mainTPDSummaryTypeDivLast").before(div);
	    $j('.new-report-type').chosen();
		
		
		
		
		
	});
	
	$j("#mainIrisSummaryType").bind("click", function () {
		var value = $j(this).val();
		var div = $j("<div class='tr'/>");
		 div.html(addMainSummaryType(""));
		$j("#mainIrisSummaryTypeDiv").after(div);
		
		  });
		  
		  
		  
		
		/*   this is for remove button */
		
		$j("body").on("click", "#removeLink", function () {
			$j(this).parent().parent().remove();
			mainReportTypecounter--;
			deleteReportRow();
		});
		
		function deleteReportRow()
		{
			var tpdForm = jQuery("#tpd-summary-form");
			tpdForm.submit();
		}
		
	var tpdReportTypecounter = 1;
	function addMainReportType(value) 
	{
    	 
		 
	     var reportType  = "<div class='td' id='reportType'><select data-placeholder=' '  class='chosen-select form-select new-report-type'         id='reportType' name='reportTypes'>"+$j('#reportType').clone(true).html()+"</select></div>";
		 
	
		
		 
 		// var legalApprover = "<div class='td'>"+$j('#legalApproverDiv').clone(true).html()+"</div>";
		 var legalApprover = "<div class='td' id='legalApproverDiv'><input type='text' name='reportTypeLegalApprovers' value='' /></div>";
		 //var attachmentDiv = "<div class='td'>"+$j('#attachmentDiv').clone(true).html();
		 var attachmentDiv = "<div class='td' id='attachmentDiv'><span class='jive-icon-med jive-icon-attachment j-link' onclick='showAttachmentPopupNew(${fullReportID?c},1,"+mainReportTypecounter+")' ></span><span class='jive-error-message full-width' id='attachmentError' style='display:none'>Please attach the TPD Summary</span>";
		 var removeLink = "<input type='button' value='Remove' class='remove' id='removeLink'>"+"</div>";
	
	
		var comment = $j('#commentDiv').clone(true).html();
		var content=  reportType  +  legalApprover + attachmentDiv  + removeLink;
				
		return content;       
	}
	
	function addMainSummaryType(value){
		var summaryType  = "<div class='td'>IRIS Summary</div>";
		//var legalApprover = "<div class='td'>"+$j('#legalApproverDiv').clone(true).html()+"</div>";
		var legalApprover = "<div class='td'><input type='text' name='irisSummaryLegalApprovers' value='' /></div>";
		//var attachmentDiv = "<div class='td'>"+$j('#attachmentDiv').clone(true).html();
		var attachmentDiv = "<div class='td' id='attachmentDiv'><span class='jive-icon-med jive-icon-attachment j-link' onclick='showAttachmentPopup(${irisSummaryReportID?c})' ></span>";
		var removeLink = "<input type='button' value='Remove' class='remove' id='removeLink'>"+"</div>";
		var content=  summaryType  +  legalApprover + attachmentDiv  + removeLink;
		return content;  
	}
	function addTPDSummaryType_OLD(value){
		var summaryType  = "<div class='td'>TPD Summary</div>";
		/*var legalApprover = "<div class='td'>"+$j('#legalApproverDiv').clone(true).html()+"<input type='text' class='jive-form-textinput-variable j-form-datepicker' id='reportSummarystartDate1' name='tpdSummaryDate' readonly='true'></div>";*/
		
		var legalApprover = "<div class='td'><input type='text' name='tpdSummaryLegalApprovers' value='' /><input type='text' class='jive-form-textinput-variable j-form-datepicker' id='reportSummarystartDate1' name='tpdSummaryDate' readonly='true'></div>";
		
		//var attachmentDiv = "<div class='td'>"+$j('#attachmentDiv').clone(true).html();
		var attachmentDiv = "<div class='td' id='attachmentDiv'><span class='jive-icon-med jive-icon-attachment j-link' onclick='showAttachmentPopup(${tpdSummaryReportID?c})' ></span>";
		var removeLink = "<input type='button' value='Remove' class='remove' id='removeLink'>"+"</div>";
		var content=  summaryType  +  legalApprover + attachmentDiv  + removeLink;
		return content;  
	}
	var globaltpdCounter = ${tpdCounter};
	
	function addTPDSummaryType(value){
		globaltpdCounter = globaltpdCounter + 1;
		var summaryType  = "<div class='td dynamic-row'><div class='iris_summery_box_align'>TPD Summary</div></div>";
		/*var legalApprover = "<div class='td'>"+$j('#legalApproverDiv').clone(true).html()+"<input type='text' class='jive-form-textinput-variable j-form-datepicker' id='reportSummarystartDate1' name='tpdSummaryDate' readonly='true'></div>";*/
		
		/*var legalApprover = "<div class='td'><input type='text' name='tpdSummaryLegalApprovers' value='' /><input type='text' class='jive-form-textinput-variable j-form-datepicker' id='reportSummarystartDate1' name='tpdSummaryDate' readonly='true'></div>";*/
		
		var id = "tpdSummaryDate_"+globaltpdCounter;
		var buttonId = "tpdSummaryDate_"+globaltpdCounter+"_button";
		var tpdSummaryDateErrorId = "tpdSummaryDatesError_"+globaltpdCounter;
		
		var tpdLegalAppId = "tpdSummaryLegalApprover_"+globaltpdCounter;
		var tpdLegalAppErrorId = "tpdSummaryLegalApproverError_"+globaltpdCounter;
		
		var tpdLegalAppId = "tpdSummaryLegalApprover_"+globaltpdCounter;
		var tpdLegalAppErrorId = "tpdSummaryLegalApproverError_"+globaltpdCounter;
		
		
		
		
		
		
		var legalApprover = "<div class='td'><input type='text'  name='tpdSummaryLegalApprovers' onchange='hideTPDLegalApproverError(this);' id='"+tpdLegalAppId+"' value='' onfocus=\"this.placeholder = '' \" placeholder='Add Legal Approver's  Name' onblur='this.placeholder = \"Add Legal Approver's  Name\"'/> <span class='jive-error-message full-width' id='"+tpdLegalAppErrorId+"' style='display:none'>Please Enter Legal Approver</span> <div class='reports-tpd-summary reports-tpd-summary-dynamic'><input type='text' class='jive-form-textinput-variable j-form-datepicker' id='"+id+"' name='tpdSummaryDates' readonly='true' placeholder='Enter Date of Legal Approval' onchange='dateSelected(this);'><a href='#' id='"+buttonId+"' onmouseover='tpdSummarydateClicked("+globaltpdCounter+")' onClick='tpdSummarydateClicked("+globaltpdCounter+")' class='j-form-datepicker-btn' ><img src='${themePath}/images/synchro/calendar.png' encode='false' width='19' height='19' border='0' /></a></div><span class='jive-error-message full-width' id='"+tpdSummaryDateErrorId+"' style='display:none'>Please Enter Date of Legal Approver</span></div>";
		
	
		
		
		//var attachmentDiv = "<div class='td'>"+$j('#attachmentDiv').clone(true).html();
		var attachmentDiv = "<div class='td' id='attachmentDiv'><span class='jive-icon-med jive-icon-attachment j-link' onclick='showAttachmentPopupNew(${tpdSummaryReportID?c},5,-1)' ></span><span class='jive-error-message full-width' id='attachmentError' style='display:none'>Please attach the TPD Summary</span>";
		var removeLink = "<input type='button' value='Remove' class='removeRS' id='removeLink'>"+"</div>";
		var content=  summaryType  +  legalApprover + attachmentDiv  + removeLink;
		$j('#confirmProjectEnable').addClass("disabled");	
		return content;  
	}
	
<#if showAgencyWaiver=="yes">
	<#else>
		
	
		  $j("#agencyWaiverDivPIT").hide();
		  
	</#if>
	
	 function AddCostDetailTitle(){
			$j('.expense_row .region-inner .chosen-select').each(function(){
				var TitleValue = $j('option:selected',this).text();
				if(TitleValue)$j(this).parent().find('.chosen-container').attr("title",TitleValue);
			});
		}
		
	function AddPITFieldTitle()
	{
		var brandvalue=$j("#brand option:selected").text();
		$j("#brand_chosen").attr("title",brandvalue);
		var brandvalue=$j("#brand option:selected").text();
		if(brandvalue.length>20)
		{
			$j("#brand_chosen").attr("title",brandvalue);
		}
		else
		{
		   $j("#brand_chosen").attr("title","");
		}
		var brandSpecificStudyTypeValue=$j("#brandSpecificStudyType option:selected").text();
			
		if(brandSpecificStudyTypeValue.length>20)
		{
			$j("#brandSpecificStudyType_chosen").attr("title",brandSpecificStudyTypeValue);
		}
		else
		{
		   $j("#brandSpecificStudyType_chosen").attr("title","");
		}
	}
	
	var dynamicSubmissionDate = ${tpdSKUCounter};
	
	var rowId = ${tpdSKURowId};
	
	
	
	/* duplicate/dynamic sku */
	function duplicateSku(curr){
		
		rowId = rowId + 1;
		var id = "submissionDate"+dynamicSubmissionDate;
		var buttonId = "submissionDate"+dynamicSubmissionDate+"_button";
		
		var tpdModificationDateId = "tpdModificationDate"+ dynamicSubmissionDate;
		var tpdModificationButtonId = "tpdModificationDate"+dynamicSubmissionDate+"_button";

		var hasProductLaunch = "<div class='td'><div class='form-select_div start_date'><select data-placeholder='Select' title='Select' class='chosen-select hasProductLaunch' id = 'hasProductModifications"+dynamicSubmissionDate+"' name='hasProductModifications' ><option  value='' ></option><option  value='1' >Launch</option><option  value='2' >Modification</option><option  value='3' >None</option></select></div><span class='jive-error-message' id='tpdProductModificationError"+dynamicSubmissionDate+"' style='display:none'>Please select Has the Product Launch/Modification Happened Yet</span></div>";
		
		
		var sameAsPrevSubmitted="";					
		<#if showPrevSubmittedCheckBox?? && showPrevSubmittedCheckBox =="yes" >
			sameAsPrevSubmitted = "<div class='td'><div class='form-select_div start_date'><span class='jive-icon-med  jive-icon-attachment j-link'  id='attachment-icon-"+rowId+"' onclick='showAttachmentPopupTPDSKUDetails(${tpdSummarySKUDetailsID?c},"+rowId+")' ></span><div class='legal-checkbox' id='legal-checkbox'><input type='checkbox' name='sameAsPrevSubmitted' id='sameAsPrevSubmitted-"+rowId+"' onclick='removeAttachmentIcon("+rowId+",this)' >Same as original TPD summary.</div><span class='jive-error-message' id='tpdSummaryAttachmentError"+dynamicSubmissionDate+"' style='display:none'>Please attach TPD Summary</span></div>"
		<#else>
			sameAsPrevSubmitted = "<div class='td'><div class='form-select_div start_date'><span class='jive-icon-med  jive-icon-attachment j-link'  id='attachment-icon-"+rowId+"' onclick='showAttachmentPopupTPDSKUDetails(${tpdSummarySKUDetailsID?c},"+rowId+")' ></span><span class='jive-error-message' id='tpdSummaryAttachmentError"+dynamicSubmissionDate+"' style='display:none'>Please attach TPD Summary</span></div>"
		</#if>
		
		var currRow = "<div class='tr'><div class='td'><div class='form-select_div start_date'><input type='text'  name='submissionDates' class='jive-form-textinput-variable j-form-datepicker' value='' placeholder='Select Date' readonly='true' id='"+id+"'><a href='#' id='"+buttonId+"'  onmouseover='dateClicked("+dynamicSubmissionDate+")' onClick='dateClicked("+dynamicSubmissionDate+")' class='j-form-datepicker-btn' ><img src='${themePath}/images/synchro/calendar.png' encode='false' width='19' height='19' border='0' /></a></div><span class='jive-error-message' id='submissionDateError"+dynamicSubmissionDate+"' style='display:none'>Please enter Submission Date</span></div><div class='td'>  <input type='text'  name='taoCodes' onchange='hideTPDLegalApproverError(this);' id='taoCodes"+dynamicSubmissionDate+"' value='' onfocus=\"this.placeholder = '' \" placeholder='Enter TAO Code' onblur='this.placeholder = \"Enter TAO Code\"'><span class='jive-error-message' id='taoCodeError"+dynamicSubmissionDate+"' style='display:none'>Please enter TAO Code</span></div>"+sameAsPrevSubmitted+" <input type='button' value='duplicate' class='duplicate' id='firstDuplicate' style='display: block;' onclick='duplicateSku();'><input type='button' value='Remove' class='remove' onclick='deleteSku(this,"+rowId+");' id='firstRemove' style='display: block;'></div></div><input type='hidden'  name='rowIds' value='"+rowId+"' id='rowIds' /> <input type='hidden'  name='skuRowSave' value='no' id='skuRowSave' />";
		
		$j(".dynamic-sku-section .table-header").after(currRow);
		$j('.hasProductLaunch').chosen();
		
		dynamicSubmissionDate = dynamicSubmissionDate + 1;
	}
	
	function duplicateSku2(curr){
		
		rowId = rowId + 1;
		
		var id = "submissionDate"+dynamicSubmissionDate;
		var buttonId = "submissionDate"+dynamicSubmissionDate+"_button";
		
		var tpdModificationDateId = "tpdModificationDate"+ dynamicSubmissionDate;
		var tpdModificationButtonId = "tpdModificationDate"+dynamicSubmissionDate+"_button";

		var hasProductLaunch = "<div class='td'><div class='form-select_div start_date'><select data-placeholder='Select' title='Select' class='chosen-select hasProductLaunch' id = 'hasProductModifications"+dynamicSubmissionDate+"' name='hasProductModifications' ><option  value='' ></option><option  value='1' >Launch</option><option  value='2' >Modification</option><option  value='3' >None</option></select></div><span class='jive-error-message' id='tpdProductModificationError"+dynamicSubmissionDate+"' style='display:none'>Please select Has the Product Launch/Modification Happened Yet</span></div>";
		
		
		var sameAsPrevSubmitted="";					
		<#if showPrevSubmittedCheckBox?? && showPrevSubmittedCheckBox =="yes" >
			sameAsPrevSubmitted = "<div class='td'><div class='form-select_div start_date'><span class='jive-icon-med  jive-icon-attachment j-link'  id='attachment-icon-"+rowId+"' onclick='showAttachmentPopupTPDSKUDetails(${tpdSummarySKUDetailsID?c},"+rowId+")' ></span><div class='legal-checkbox' id='legal-checkbox'><input type='checkbox' name='sameAsPrevSubmitted' id='sameAsPrevSubmitted-"+rowId+"' onclick='removeAttachmentIcon("+rowId+",this)' >Same as original TPD summary.</div><span class='jive-error-message' id='tpdSummaryAttachmentError"+dynamicSubmissionDate+"' style='display:none'>Please attach TPD Summary</span></div>"
		<#else>
			sameAsPrevSubmitted = "<div class='td'><div class='form-select_div start_date'><span class='jive-icon-med  jive-icon-attachment j-link'  id='attachment-icon-"+rowId+"' onclick='showAttachmentPopupTPDSKUDetails(${tpdSummarySKUDetailsID?c},"+rowId+")' ></span><span class='jive-error-message' id='tpdSummaryAttachmentError"+dynamicSubmissionDate+"' style='display:none'>Please attach TPD Summary</span></div>"
		</#if>
		
		var currRow = "<div class='tr'><div class='td'><div class='form-select_div start_date'><input type='text'  name='submissionDates' class='jive-form-textinput-variable j-form-datepicker' value='' placeholder='Select Date' readonly='true' id='"+id+"'><a href='#' id='"+buttonId+"' onmouseover='dateClicked("+dynamicSubmissionDate+")' onClick='dateClicked("+dynamicSubmissionDate+")' class='j-form-datepicker-btn' ><img src='${themePath}/images/synchro/calendar.png' encode='false' width='19' height='19' border='0' /></a></div><span class='jive-error-message' id='submissionDateError"+dynamicSubmissionDate+"' style='display:none'>Please enter Submission Date</span></div><div class='td'><input type='text'  name='taoCodes' onchange='hideTPDLegalApproverError(this);' id='taoCodes"+dynamicSubmissionDate+"' value='' onfocus=\"this.placeholder = '' \" placeholder='Enter TAO Code' onblur='this.placeholder = \"Enter TAO Code\"'><span class='jive-error-message' id='taoCodeError"+dynamicSubmissionDate+"' style='display:none'>Please enter TAO Code</span></div>"+sameAsPrevSubmitted+"<input type='button' value='duplicate' class='duplicate' id='firstDuplicate' style='display: block;' onclick='duplicateSku2();'><input type='button' value='Remove' class='remove enable' onclick='deleteSku(this,"+rowId+");' id='firstRemove' style='display: block;'></div></div><input type='hidden'  name='rowIds' value='"+rowId+"' id='rowIds' /> <input type='hidden'  name='skuRowSave' value='no' id='skuRowSave' />";
		
		
		
		
		$j(".dynamic-sku-section .table-header").after(currRow);
		
		$j('.hasProductLaunch').chosen();
		dynamicSubmissionDate = dynamicSubmissionDate + 1;
	}
	
	function deleteSku(curr, rowId){
		
		var currRow = $j(curr).parents('.tr').remove();
		deleteTPDSKUDetailRow(rowId);
		
	}
	function openTpdStatusPopup(){
		$j("#tpdStatusPopup").lightbox_me({centered:true,closeEsc:false,closeClick:false,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7}});
		$j(window).scrollTop(0);
	}
	/*
	function saveTPDSummaryForm()
	{
		
		var submissionDate = $j("#submissionDate").val();
		var taoCode = $j("#taoCode").val();
		var hasProductModification = $j("#hasProductModifications").val();
		var tpdModificationDate = $j("#tpdModificationDate").val();
		
		var error = false;
	
		
		
		
		if(submissionDate != null && $j.trim(submissionDate)=="")
		{
			$j("#submissionDateError").show();
			error=true;
		}
		else
		{
			$j("#submissionDateError").hide();
		}
		
		if(hasProductModification != null && $j.trim(hasProductModification)=="")
		{
			$j("#tpdProductModificationError").show();
			error=true;
		}
		else
		{
			$j("#tpdProductModificationError").hide();
		}
		
		if(hasProductModification=="3")
		{
			$j("#tpdModificationDateError").hide();
			$j("#taoCodeError").hide();
		}
		else
		{
			if(tpdModificationDate != null && $j.trim(tpdModificationDate)=="")
			{
				$j("#tpdModificationDateError").show();
				error=true;
			}
			else
			{
				$j("#tpdModificationDateError").hide();
			}
			
			if(taoCode != null && $j.trim(taoCode)=="")
			{
				$j("#taoCodeError").show();
				error=true;
			}
			else
			{
				$j("#taoCodeError").hide();
			}
		}	
		
		if(dynamicSubmissionDate > 1 )
		{
			for(var i=1; i < dynamicSubmissionDate; i++)
			{
				var submissionDate1 = $j("#submissionDate"+i).val();
				if(submissionDate1 != null && $j.trim(submissionDate1)=="")
				{
					$j("#submissionDateError"+i).show();
					error=true;
				}
				else
				{
					$j("#submissionDateError"+i).hide();
				}
				
				var hasProductModifications1 = $j("#hasProductModifications"+i).val();
				
				if(hasProductModifications1 != null && $j.trim(hasProductModifications1)=="")
				{
					$j("#tpdProductModificationError"+i).show();
					error=true;
				}
				else
				{
					$j("#tpdProductModificationError"+i).hide();
				}
				
				if(hasProductModifications1=="3")
				{
					$j("#tpdModificationDateError"+i).hide();
					$j("#taoCodeError"+i).hide();
				}
				else
				{
					var tpdModificationDate1 = $j("#tpdModificationDate"+i).val();
					
					if(tpdModificationDate1 != null && $j.trim(tpdModificationDate1)=="")
					{
						$j("#tpdModificationDateError"+i).show();
						error=true;
					}
					else
					{
						$j("#tpdModificationDateError"+i).hide();
					}
					
					var taoCodes1 = $j("#taoCodes"+i).val();
					if(taoCodes1 != null && $j.trim(taoCodes1)=="")
					{
						$j("#taoCodeError"+i).show();
						error=true;
					}
					else
					{
						$j("#taoCodeError"+i).hide();
					}
				}
			}
			
		}
		
		if(error)
		{
			return false;
		}
		
		dialog({
			title: '',
			html: '<i class="warningErr positionSet"></i><p>Details cannot be changed once saved.Are you sure you want to continue? </p>',
			buttons:{
				"YES":function() {
					showLoader('Please wait...');
					var tpdForm = jQuery("#tpd-summary-form");
					tpdForm.submit();
					hideLoader();
				},
				"NO": function() {
					closeDialog();
				}
			}
		});
		relPos();
		
		//showLoader('Please wait...');
		//var tpdForm = jQuery("#tpd-summary-form");
		//tpdForm.submit();
		//hideLoader();
	}
	
	*/
	
	/*Amit's code ...*/
	
	var sameAsPrevSubmittedHiddenParam="";
	function saveTPDSummaryForm()
	{
		var firtError = false;
		var error = false;
	
	    var tpdCounterLocal = ${tpdCounter};
		
		var showTPD = "";
		<#if showTpdSubmissionDiv == "yes">
			showTPD = "yes";
		</#if>
		if((tpdCounterLocal > 0) || (showTPD=="yes"))
		{
			
			
			var submissionDate = $j("#submissionDate").val();
			var taoCode = $j("#taoCode").val();
			
			var tpdSummaryLegalApprover = $j("#tpdSummaryLegalApprover").val();
			
			var tpdSummaryDate = 	$j("#tpdSummaryDate").val();
			
		
			
			var flag = attachment_errorMessage();
			
			if(flag)
			{
				firtError=true;
			}
			
			
			
			if(tpdSummaryLegalApprover != null && $j.trim(tpdSummaryLegalApprover)=="")
			{
				$j("#tpdSummaryLegalApproverError").show();
				firtError=true;
			}
			else
			{
				$j("#tpdSummaryLegalApproverError").hide();
			}
			
			if(tpdSummaryDate != null && $j.trim(tpdSummaryDate)=="")
			{
				$j("#tpdSummaryDatesError").show();
				firtError=true;
			}
			else
			{
				$j("#tpdSummaryDatesError").hide();
			}
			
			//var tpdCount = ${tpdCounter};
			for(var m=0; m <= globaltpdCounter; m++)
			{
				var tpdSummaryLegalApproverM = $j("#tpdSummaryLegalApprover_"+m).val();
				
				var tpdSummaryDateM = $j("#tpdSummaryDate_"+m).val();
				
				if(tpdSummaryLegalApproverM != null && $j.trim(tpdSummaryLegalApproverM)=="")
				{
					$j("#tpdSummaryLegalApproverError_"+m).show();
					firtError=true;
				}
				else
				{
					$j("#tpdSummaryLegalApproverError_"+m).hide();
				}
				
				if(tpdSummaryDateM != null && $j.trim(tpdSummaryDateM)=="")
				{
					$j("#tpdSummaryDatesError_"+m).show();
					firtError=true;
				}
				else
				{
					$j("#tpdSummaryDatesError_"+m).hide();
				}
			}
			if(!firtError)
			{
				if(submissionDate != null && $j.trim(submissionDate)=="" && taoCode != null && $j.trim(taoCode)=="")
				{
					showLoader('Please wait...');
					error = true;
					$j("#isRowSave").val("no");
					var tpdForm = jQuery("#tpd-summary-form");
					tpdForm.submit();
					hideLoader();
				}
			}
			
			/* Last Fix added by Tejinder on 13-NOV-2017
			*/
			if(dynamicSubmissionDate > 1 )
			{
				var tpdSkuRows = 0;
				var firstErrorMultiple = false;
				for(var i=1; i < dynamicSubmissionDate; i++)
				{
					tpdSkuRows = tpdSkuRows + 1;
				}
				for(var i=1; i < dynamicSubmissionDate; i++)
				{
					var submissionDate1 = $j("#submissionDate"+i).val();
					var taoCodes1 = $j("#taoCodes"+i).val();
					if(tpdSkuRows==1 && submissionDate1 != null && $j.trim(submissionDate1)=="" && taoCodes1 != null && $j.trim(taoCodes1)=="")
					{
						firtError=true;
						firstErrorMultiple=true;
					}
				}
				
				if(firstErrorMultiple && tpdSkuRows==1)
				{
				
						showLoader('Please wait...');
						error = true;
						$j("#isRowSave").val("no");
						var tpdForm = jQuery("#tpd-summary-form");
						tpdForm.submit();
						hideLoader();
				
				}
			}
			
			
		}
		
		if(!firtError && !error)
		{
			
			error = false;
			var counter=1;
			
			
		
		   $j('.tpd-summary-table .tr').each(function(){ 
				
				
				var attachment = $j(this).find('.jive-attach-item').length;  
				if(attachment==0 && counter==1)
				  {
					 counter++;
				  
				  }
				 else
			   {			 
				  
				  
				  if(counter>1 && attachment>0)
				  {
					
					
					var submissionDate = $j("#submissionDate").val();
			
					var submissionDate_1=$j("#submissionDate_1").val();
			 
					var taoCode = $j("#taoCode").val();
					var hasProductModification = $j("#hasProductModifications").val();
					var tpdModificationDate = $j("#tpdModificationDate").val();
					
					var tpdSummaryLegalApprover = $j("#tpdSummaryLegalApprover").val();
			
					var tpdSummaryDate = 	$j("#tpdSummaryDate").val();
					
					if(tpdSummaryLegalApprover != null && $j.trim(tpdSummaryLegalApprover)=="")
					{
						$j("#tpdSummaryLegalApproverError").show();
						firtError=true;
					}
					else
					{
						$j("#tpdSummaryLegalApproverError").hide();
					}
					
					if(tpdSummaryDate != null && $j.trim(tpdSummaryDate)=="")
					{
						$j("#tpdSummaryDatesError").show();
						firtError=true;
					}
					else
					{
						$j("#tpdSummaryDatesError").hide();
					}
					
					//var tpdCount = ${tpdCounter};
					for(var m=0; m <= globaltpdCounter; m++)
					{
						var tpdSummaryLegalApproverM = $j("#tpdSummaryLegalApprover_"+m).val();
						
						var tpdSummaryDateM = $j("#tpdSummaryDate_"+m).val();
						
						if(tpdSummaryLegalApproverM != null && $j.trim(tpdSummaryLegalApproverM)=="")
						{
							$j("#tpdSummaryLegalApproverError_"+m).show();
							firtError=true;
						}
						else
						{
							$j("#tpdSummaryLegalApproverError_"+m).hide();
						}
						
						if(tpdSummaryDateM != null && $j.trim(tpdSummaryDateM)=="")
						{
							$j("#tpdSummaryDatesError_"+m).show();
							firtError=true;
						}
						else
						{
							$j("#tpdSummaryDatesError_"+m).hide();
						}
					}
					
					if(submissionDate_1=="")
					{
						$j("#submissionDateError").show();
					   
						error = true;
					}
					else
					{
						$j("#submissionDateError").hide();
					}
			
					if(submissionDate != null && $j.trim(submissionDate)=="")
					{
						$j("#submissionDateError").show();
						error=true;
					}
					/*else
					{
						$j("#submissionDateError").hide();
						
						  
					}  */
					
					if(hasProductModification != null && $j.trim(hasProductModification)=="")
					{
						$j("#tpdProductModificationError").show();
						error=true;
					}
					else
					{
						$j("#tpdProductModificationError").hide();
					}
					
					if(hasProductModification=="3")
					{
						$j("#tpdModificationDateError").hide();
						$j("#taoCodeError").hide();
					}
					else
					{
						if(tpdModificationDate != null && $j.trim(tpdModificationDate)=="")
						{
							$j("#tpdModificationDateError").show();
							error=true;
						}
						else
						{
							$j("#tpdModificationDateError").hide();
						}
						
						if(taoCode != null && $j.trim(taoCode)=="")
						{
							$j("#taoCodeError").show();
							error=true;
						}
						else
						{
							$j("#taoCodeError").hide();
						}
					}	
				
					if(dynamicSubmissionDate > 1 )
					{
						
						for(var i=1; i < dynamicSubmissionDate; i++)
						{
							var submissionDate1 = $j("#submissionDate"+i).val();
							
							if(submissionDate1 != null && $j.trim(submissionDate1)=="")
							{
								$j("#submissionDateError"+i).show();
								error=true;
							}
							else
							{
								$j("#submissionDateError"+i).hide();
							}
							
							var hasProductModifications1 = $j("#hasProductModifications"+i).val();
							
							if(hasProductModifications1 != null && $j.trim(hasProductModifications1)=="")
							{
								$j("#tpdProductModificationError"+i).show();
								error=true;
							}
							else
							{
								$j("#tpdProductModificationError"+i).hide();
							}
							
							if(hasProductModifications1=="3")
							{
								$j("#tpdModificationDateError"+i).hide();
								$j("#taoCodeError"+i).hide();
							}
							else
							{
								var tpdModificationDate1 = $j("#tpdModificationDate"+i).val();
								
								if(tpdModificationDate1 != null && $j.trim(tpdModificationDate1)=="")
								{
									$j("#tpdModificationDateError"+i).show();
									error=true;
								}
								else
								{
									$j("#tpdModificationDateError"+i).hide();
								}
								
								var taoCodes1 = $j("#taoCodes"+i).val();
								if(taoCodes1 != null && $j.trim(taoCodes1)=="")
								{
									$j("#taoCodeError"+i).show();
									error=true;
								}
								else
								{
									$j("#taoCodeError"+i).hide();
								}
							}
						}
				
					}
					
					var sameAsPrevSubmitted = $j(this).find('input[type="checkbox"]').is(':checked'); 
					if(sameAsPrevSubmitted)
					{
						if(sameAsPrevSubmittedHiddenParam=="")
						{
							sameAsPrevSubmittedHiddenParam="yes";
						}
						else
						{
							sameAsPrevSubmittedHiddenParam=sameAsPrevSubmittedHiddenParam+",yes";
						}
					}
					else
					{	
						if(sameAsPrevSubmittedHiddenParam=="")
						{
							sameAsPrevSubmittedHiddenParam="no";
						}
						else
						{
							sameAsPrevSubmittedHiddenParam=sameAsPrevSubmittedHiddenParam+",no";
						}
					}   
			
				}
				else
				{
					
					
					//error=true;
					var sameAsPrevSubmitted = $j(this).find('input[type="checkbox"]').is(':checked'); 
				
					
					if(sameAsPrevSubmitted)
					{
						//error=false;
						if(sameAsPrevSubmittedHiddenParam=="")
						{
							sameAsPrevSubmittedHiddenParam="yes";
						}
						else
						{
							sameAsPrevSubmittedHiddenParam=sameAsPrevSubmittedHiddenParam+",yes";
						}
					}
					else
					{	
						if(sameAsPrevSubmittedHiddenParam=="")
						{
							sameAsPrevSubmittedHiddenParam="no";
						}
						else
						{
							sameAsPrevSubmittedHiddenParam=sameAsPrevSubmittedHiddenParam+",no";
						}
						error=true;
						//dialog({title:"Message",html:"Please attach the TPD Summary attachment"});
						
						
						//$j("#tpdSummaryAttachmentError").show();
						
						if($j("#sameAsPrevSubmitted").is(':checked'))
						{	
							$j("#tpdSummaryAttachmentError").hide();
						}
						else
						{
							$j("#tpdSummaryAttachmentError").show();
						}
						
						var submissionDate = $j("#submissionDate").val();
						var submissionDate_1=$j("#submissionDate_1").val();
						var taoCode = $j("#taoCode").val();
						
						var tpdSummaryLegalApprover = $j("#tpdSummaryLegalApprover").val();
			
			
			
					if(tpdSummaryLegalApprover != null && $j.trim(tpdSummaryLegalApprover)=="")
					{
						$j("#tpdSummaryLegalApproverError").show();
						error=true;
					}
					else
					{
						$j("#tpdSummaryLegalApproverError").hide();
					}
					
					//var tpdCount = ${tpdCounter};
					for(var m=0; m <= globaltpdCounter; m++)
					{
						var tpdSummaryLegalApproverM = $j("#tpdSummaryLegalApprover_"+m).val();
						if(tpdSummaryLegalApproverM != null && $j.trim(tpdSummaryLegalApproverM)=="")
						{
							$j("#tpdSummaryLegalApproverError_"+m).show();
							error=true;
						}
						else
						{
							$j("#tpdSummaryLegalApproverError_"+m).hide();
						}
					}
					
						if(submissionDate_1=="")
						{
							$j("#submissionDateError").show();
						   
							error = true;
						}
						else
						{
							$j("#submissionDateError").hide();
						}
				
						if(submissionDate != null && $j.trim(submissionDate)=="")
						{
							$j("#submissionDateError").show();
							error=true;
						}
						
						if(taoCode != null && $j.trim(taoCode)=="")
						{
							$j("#taoCodeError").show();
							error=true;
						}
						else
						{
							$j("#taoCodeError").hide();
						}
						
						if(dynamicSubmissionDate > 1 )
					{
						
						for(var i=1; i < dynamicSubmissionDate; i++)
						{
							var submissionDate1 = $j("#submissionDate"+i).val();
							
							if(submissionDate1 != null && $j.trim(submissionDate1)=="")
							{
								$j("#submissionDateError"+i).show();
								error=true;
							}
							else
							{
								$j("#submissionDateError"+i).hide();
							}
							
							var hasProductModifications1 = $j("#hasProductModifications"+i).val();
							
							if(hasProductModifications1 != null && $j.trim(hasProductModifications1)=="")
							{
								$j("#tpdProductModificationError"+i).show();
								error=true;
							}
							else
							{
								$j("#tpdProductModificationError"+i).hide();
							}
							
							if(hasProductModifications1=="3")
							{
								$j("#tpdModificationDateError"+i).hide();
								$j("#taoCodeError"+i).hide();
							}
							else
							{
								var tpdModificationDate1 = $j("#tpdModificationDate"+i).val();
								
								if(tpdModificationDate1 != null && $j.trim(tpdModificationDate1)=="")
								{
									$j("#tpdModificationDateError"+i).show();
									error=true;
								}
								else
								{
									$j("#tpdModificationDateError"+i).hide();
								}
								
								var taoCodes1 = $j("#taoCodes"+i).val();
								if(taoCodes1 != null && $j.trim(taoCodes1)=="")
								{
									$j("#taoCodeError"+i).show();
									error=true;
								}
								else
								{
									$j("#taoCodeError"+i).hide();
								}
							}
							
							if($j("#sameAsPrevSubmitted-"+i).is(':checked'))
							{	
								$j("#tpdSummaryAttachmentError"+i).hide();
							}
							else
							{
								$j("#tpdSummaryAttachmentError"+i).show();
							}
						}
				
					}
						return false;
					}   

					var submissionDate = $j("#submissionDate").val();
			
					var submissionDate_1=$j("#submissionDate_1").val();
					
					var tpdSummaryLegalApprover = $j("#tpdSummaryLegalApprover").val();
			
			
			
					if(tpdSummaryLegalApprover != null && $j.trim(tpdSummaryLegalApprover)=="")
					{
						$j("#tpdSummaryLegalApproverError").show();
						error=true;
					}
					else
					{
						$j("#tpdSummaryLegalApproverError").hide();
					}
					
					//var tpdCount = ${tpdCounter};
					for(var m=0; m <= globaltpdCounter; m++)
					{
						var tpdSummaryLegalApproverM = $j("#tpdSummaryLegalApprover_"+m).val();
						if(tpdSummaryLegalApproverM != null && $j.trim(tpdSummaryLegalApproverM)=="")
						{
							$j("#tpdSummaryLegalApproverError_"+m).show();
							error=true;
						}
						else
						{
							$j("#tpdSummaryLegalApproverError_"+m).hide();
						}
					}
					
			 
					var taoCode = $j("#taoCode").val();
					var hasProductModification = $j("#hasProductModifications").val();
					var tpdModificationDate = $j("#tpdModificationDate").val();
			
					if(submissionDate_1=="")
					{
						$j("#submissionDateError").show();
					   
						error = true;
					}
					else
					{
						$j("#submissionDateError").hide();
					}
			
					if(submissionDate != null && $j.trim(submissionDate)=="")
					{
						$j("#submissionDateError").show();
						error=true;
					}
					
					
					if(hasProductModification != null && $j.trim(hasProductModification)=="")
					{
						$j("#tpdProductModificationError").show();
						error=true;
					}
					else
					{
						$j("#tpdProductModificationError").hide();
					}
					
					if(hasProductModification=="3")
					{
						$j("#tpdModificationDateError").hide();
						$j("#taoCodeError").hide();
					}
					else
					{
						if(tpdModificationDate != null && $j.trim(tpdModificationDate)=="")
						{
							$j("#tpdModificationDateError").show();
							error=true;
						}
						else
						{
							$j("#tpdModificationDateError").hide();
						}
						
						if(taoCode != null && $j.trim(taoCode)=="")
						{
							$j("#taoCodeError").show();
							error=true;
						}
						else
						{
							$j("#taoCodeError").hide();
						}
					}	
					if(dynamicSubmissionDate > 1 )
					{
						
						for(var i=1; i < dynamicSubmissionDate; i++)
						{
							var submissionDate1 = $j("#submissionDate"+i).val();
							
							if(submissionDate1 != null && $j.trim(submissionDate1)=="")
							{
								$j("#submissionDateError"+i).show();
								error=true;
							}
							else
							{
								$j("#submissionDateError"+i).hide();
							}
							
							var hasProductModifications1 = $j("#hasProductModifications"+i).val();
							
							if(hasProductModifications1 != null && $j.trim(hasProductModifications1)=="")
							{
								$j("#tpdProductModificationError"+i).show();
								error=true;
							}
							else
							{
								$j("#tpdProductModificationError"+i).hide();
							}
							
							if(hasProductModifications1=="3")
							{
								$j("#tpdModificationDateError"+i).hide();
								$j("#taoCodeError"+i).hide();
							}
							else
							{
								var tpdModificationDate1 = $j("#tpdModificationDate"+i).val();
								
								if(tpdModificationDate1 != null && $j.trim(tpdModificationDate1)=="")
								{
									$j("#tpdModificationDateError"+i).show();
									error=true;
								}
								else
								{
									$j("#tpdModificationDateError"+i).hide();
								}
								
								var taoCodes1 = $j("#taoCodes"+i).val();
								if(taoCodes1 != null && $j.trim(taoCodes1)=="")
								{
									$j("#taoCodeError"+i).show();
									error=true;
								}
								else
								{
									$j("#taoCodeError"+i).hide();
								}
							}
						}
				
					}
			
				}
		
			}
		
		
		
		 });
			
			
			
			if(error)
			{
				sameAsPrevSubmittedHiddenParam="";
				return false;
			}
			else
			{
			
				dialog({
					title: '',
					html: '<i class="warningErr positionSet"></i><p>Details cannot be changed once saved.Are you sure you want to continue? </p>',
					buttons:{
						"YES":function() {
							showLoader('Please wait...');
							var tpdForm = jQuery("#tpd-summary-form");
							
							
							$j("#sameAsPrevSubmittedHidden").val(sameAsPrevSubmittedHiddenParam);
							$j("#isRowSave").val("yes");
							tpdForm.submit();
							hideLoader();
						},
						"NO": function() {
							sameAsPrevSubmittedHiddenParam="";
							closeDialog();
						}
					}
				}); 
				relPos();
			}
			
			/* showLoader('Please wait...');
			var tpdForm = jQuery("#tpd-summary-form");
			tpdForm.submit();
			hideLoader(); */	
			
		}
	}
	  
	
	
	
	
	function saveTPDSummaryFormDontHaveSub()
	{
		showLoader('Please wait...');
		var tpdForm = jQuery("#tpd-summary-form");
		tpdForm.submit();
		hideLoader();
	}
	function dateClicked(id)
	{
		
		var date_id = "submissionDate"+id;
		
		var buttonId = "submissionDate"+id+"_button";
		
	
		
		
			<!--  to hide script contents from old browsers
			Zapatec.Calendar.setup({
				inputField     :    date_id,     // id of the input field
				ifFormat       :    "%d/%m/%Y",     // format of the input field
				button         :    buttonId,  // What will trigger the popup of the calendar
				showsTime      :     false      //don't show time, only date
			});
			// end hiding contents from old browsers  -->
	}
	
	function tpdSummarydateClicked(id)
	{
			var date_id = "tpdSummaryDate_"+id;
		
			var buttonId = "tpdSummaryDate_"+id+"_button";
			
			<!--  to hide script contents from old browsers
			Zapatec.Calendar.setup({
				inputField     :    date_id,     // id of the input field
				ifFormat       :    "%d/%m/%Y",     // format of the input field
				button         :    buttonId,  // What will trigger the popup of the calendar
				showsTime      :     false      //don't show time, only date
			});
			// end hiding contents from old browsers  -->
	}
	
	function tpddateClicked(id)
	{
		var date_id = "tpdModificationDate"+id;
		
		var buttonId = "tpdModificationDate"+id+"_button";
		
			<!--  to hide script contents from old browsers
			Zapatec.Calendar.setup({
				inputField     :    date_id,     // id of the input field
				ifFormat       :    "%d/%m/%Y",     // format of the input field
				button         :    buttonId,  // What will trigger the popup of the calendar
				showsTime      :     false      //don't show time, only date
			});
			// end hiding contents from old browsers  -->
	}
	
	function saveProposalDetails()
	{
		var error = false;
		var legalApprovalStatusTPD = $j("#legalApprovalStatusTPD").val();
		
		if(legalApprovalStatusTPD!=null && legalApprovalStatusTPD!="")
		{
			$j("#legalApprovalStatusTPDError").hide();
		}
		else
		{
					
			$j("#legalApprovalStatusTPDError").show();
			error = true;
		}
			
		<#if attachmentMap?? && attachmentMap.get(tpdSummaryLegalApprovalID)?? >
			if($j('#tpdSummary-file-list').find('.jive-attach-item').length >0)
			{
				$j("#tpdSummaryLegalApproverAttError").hide();	
			}
			else
			{
				//dialog({title:"Message",html:"Please attach E-mail Approval"});
				//return false;
				$j("#tpdSummaryLegalApproverAttError").show();
				error = true;
			}
		<#else>
			if($j('#tpdSummary-file-list').find('.jive-attach-item').length >0)
			{
				$j("#tpdSummaryLegalApproverAttError").hide();	
			}
			else
			{
				//dialog({title:"Message",html:"Please attach E-mail Approval"});
				//return false;
				$j("#tpdSummaryLegalApproverAttError").show();
				error = true;
			}
		</#if>
		
		var proposalLegalApprover = $j("#proposalLegalApprover").val();
		if(proposalLegalApprover!=null && proposalLegalApprover!="")
		{
			$j("#proposalLegalApproverError").hide();
		}
		else
		{
			//dialog({title:"Message",html:"Please select Legal Approval Provided By"});
			//return false;
			
			$j("#proposalLegalApproverError").show();
			error = true;
		}
		
		var tpdLegalApprovalDate = $j("#tpdLegalApprovalDate").val();
		if(tpdLegalApprovalDate!=null && tpdLegalApprovalDate!="")
		{
			$j("#tpdLegalApprovalDateError").hide();
		}
		else
		{
			//dialog({title:"Message",html:"Please select Date of Legal Approval"});
			//return false;
			$j("#tpdLegalApprovalDateError").show();
			error = true;
		}
		
		if(legalApprovalStatusTPD==1)
		{
			<#if showTPDSummaryFields>
			
				<#if attachmentMap?? && attachmentMap.get(tpdSummaryReportID)?? >
					if($j('#tpdSummary-rs-file-list').find('.jive-attach-item').length >0){
						$j("#tpdSummaryRSLegalApproverAttError").hide();
					}
					else{
					//dialog({title:"Message",html:"Please attach TPD Summary E-mail Approval"});
					
						$j("#tpdSummaryRSLegalApproverAttError").show();
						error = true;
					
					}
				<#else>
					if($j('#tpdSummary-rs-file-list').find('.jive-attach-item').length >0){
						
					}
					else{
					//dialog({title:"Message",html:"Please attach TPD Summary E-mail Approval"});
					$j("#tpdSummaryRSLegalApproverAttError").show();
						error = true;
					
					}
					
					
				</#if>
				
				var tpdSummaryRSLegalApprover = $j("#tpdSummaryRSLegalApprover").val();
				if(tpdSummaryRSLegalApprover!=null && tpdSummaryRSLegalApprover!="")
				{
					$j("#tpdSummaryRSLegalApproverError").hide();
				}
				else
				{
					
					$j("#tpdSummaryRSLegalApproverError").show();
					error = true;
					//dialog({title:"Message",html:"Please select TPD Summary Legal Approval Provided By"});
					
				}
				
				var tpdSummaryRSLegalApprovalDate = $j("#tpdSummaryRSLegalApprovalDate").val();
				if(tpdSummaryRSLegalApprovalDate!=null && tpdSummaryRSLegalApprovalDate!="")
				{
					$j("#tpdSummaryRSLegalApprovalDateError").hide();
				}
				else
				{
					$j("#tpdSummaryRSLegalApprovalDateError").show();
					//dialog({title:"Message",html:"Please select TPD Summary Legal Approval Date "});
				
				}
			</#if>	
			
		}
		
		if(error)
			{
				return false;
			}
			
			dialog({
				title: '',
				html: "<p>By clicking on the 'Save' button the TPD status will be changed & you will be navigated out of this stage. </p><p><i>Are you sure that you would like to make this change?</p>",
				buttons:{
					"Yes":function() {
						var tpdForm = jQuery("#tpd-proposal-form");
						localStorage.removeItem("popupTrue");
						tpdForm.submit();
					},
					"No": function() {
						return false;
					}
				}
			});
			relPos();
		/*if (legalApprovalStatusTPD==1)
		{

			var tpdForm = jQuery("#tpd-proposal-form");
			localStorage.removeItem("popupTrue");
			tpdForm.submit();
		}*/
		
		/*showLoader('Please wait...');
		var tpdForm = jQuery("#tpd-proposal-form");
		localStorage.removeItem("popupTrue");
		tpdForm.submit();
		hideLoader();*/
		
	}
	
	<#if showTpdSubmissionDiv?? && showTpdSubmissionDiv=="yes" >
		
		$j("#tpdSubmissionDiv").show();
	<#else>
		$j("#tpdSubmissionDiv").hide();
	</#if>
	
	function dateSelected(curr)
	{
		
	}
	
	
	// Amit's Code
	function dateTPDSelected(curr)
	{
	$j(curr).parent().find('.jive-error-message').hide();
	}
	
	function removeAttachmentIcon(rowId, curr)
	{
		
		if($j("#sameAsPrevSubmitted-"+rowId).is(':checked'))
		{
			
			$j("#attachment-icon-"+rowId).hide();
			
			
			
		/*	if(rowId==1)
			{
				$j("#tpdSummaryAttachmentError").hide();
			}
			else
			{
				$j("#tpdSummaryAttachmentError"+(rowId-1)).hide();
			}	
			*/
		}
		else
		{
			
			$j("#attachment-icon-"+rowId).show();
		}
		//$j(curr).parent().find('.jive-error-message').hide();
		$j(curr).parent().parent().find('.jive-error-message').hide();
		
	}
	
	function deleteTPDSKUDetailRow(rowId)
	{
		
		
		if(rowId!=undefined && rowId >= 0)
		{
			
			var sameAsPrevSubmittedHiddenParamAtt = "";
		   var rowCounter = 1;
			$j('.tpd-summary-table .tr').each(function(){ 
				
				var attachment = $j(this).find('.jive-attach-item').length;  
				if(rowCounter==1)
				  {
					 rowCounter++;
				  
				  }
				 else
				 {
					var sameAsPrevSubmitted = $j(this).find('input[type="checkbox"]').is(':checked'); 
					
					if(sameAsPrevSubmitted)
					{
						if(sameAsPrevSubmittedHiddenParamAtt=="")
						{
							sameAsPrevSubmittedHiddenParamAtt="yes";
						}
						else
						{
							sameAsPrevSubmittedHiddenParamAtt=sameAsPrevSubmittedHiddenParamAtt+",yes";
						}
					}
					else
					{	
						if(sameAsPrevSubmittedHiddenParamAtt=="")
						{
							sameAsPrevSubmittedHiddenParamAtt="no";
						}
						else
						{
							sameAsPrevSubmittedHiddenParamAtt=sameAsPrevSubmittedHiddenParamAtt+",no";
						}
					}  
				 }			
				 });
					
										
				$j("#sameAsPrevSubmittedHidden").val(sameAsPrevSubmittedHiddenParamAtt);
			
			
			$j("#rowId").val(rowId);
			
			var tpdForm = jQuery("#tpd-summary-form");
			tpdForm.submit();
		}
	}
	
	
	/*...Amit' Code  ..*/
	 $j("input:text[name=taoCodes]").change(function()
	  
	  {
	     
		  if($j(this).val()!="")
		  {
		    $j(this).next().hide();
		  }
	  });
	  
	function removeAttachmentMessage(attachmentField) {
    dialog({
        title: '',
        html: '<i class="warningErr positionSet"></i><p>Please upload a new '+attachmentField+' before removing the existing one </p>',
        buttons:{
            "OK":function() {
               closeDialog();
            }
        }
    });
	relPos();
	
	
	  
	} 
	
	$j("input:text[name=tpdSummaryLegalApprover]").change(function()
	 
	  {
     
		 if($j(this).val()!="")
		  {
		    $j(this).next().hide();
		  }
	  });
	  
	  $j("input:text[name=tpdSummaryLegalApprovers]").change(function()
	 
	  {
     
		 
		 if($j(this).val()!="")
		  {
		    $j(this).next().hide();
		  }
	  });
	  
	  function hideTPDLegalApproverError(curr)
	  {
		 
		 if($j(curr).val()!="")
		  {
		    $j(curr).next().hide();
		  }
	  }
	  var attachment_errorMessage= function(){
	  
	  var flag = false;
	   $j('#tpd-summary-form .table .tpdtr').each(function(index) {
			
			 
			
				   var attachment = $j(this).find('.jive-attach-item').length;
			       
			
			    //  write logic here...
				 var attachment = $j(this).find('.jive-attach-item').length; 
				     
					
				    if(attachment==0)
				   {
						
						$j(this).find('#attachmentError').show();
						flag=true;
					}
				   else
				   {
				   $j(this).find('#attachmentError').hide();
				   }
				 
			
			 
    
           });
		   return flag;
	  }
  </script>
  

  
  
  
  
  
  

