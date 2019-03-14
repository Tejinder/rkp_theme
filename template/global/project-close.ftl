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
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ajaxfileupload.js'/>"></script>
 
<link rel="stylesheet" href="${themePath}/style/multi-select.css" type="text/css" media="all" />
<script src="${themePath}/js/synchro/second.js" type="text/javascript"></script>



<#assign fieldCategoryId = ''/>

<#assign methodologyProperties = statics['com.grail.synchro.SynchroGlobal'].getAllMethodologyProperties() />
<#assign methBriefException ="" /> 
<#assign methProposalException ="" /> 
<#assign methRepSummaryException ="" /> 
<#assign agencyWaiverException ="" /> 

<#assign counter =0 />
	<#list project.methodologyDetails as md>
		<#if counter==0>
			<#if methodologyProperties.get(md?int).isBriefException() >
				<#assign methBriefException ="yes" /> 
			</#if>
			<#if methodologyProperties.get(md?int).isProposalException() >
				<#assign methProposalException ="yes" /> 
			</#if>
			<#if methodologyProperties.get(md?int).isRepSummaryException() >
				<#assign methRepSummaryException ="yes" /> 
			</#if>
			<#if methodologyProperties.get(md?int).isAgencyWaiverException() >
				<#assign agencyWaiverException ="yes" /> 
			</#if>
	</#if>
	<#assign counter = counter + 1 />
	</#list>


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
	 $j("#initiateKantarWaiver").trigger('close');
		closeDialog();
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
     var windowHeight=$j(window).height()-150;
   $j(".pop-upinner-scroll").css("height",windowHeight+"px");
   $j(window).resize(function(){
 var windowHeight=$j(window).height()-150;
   $j(".pop-upinner-scroll").css("height",windowHeight+"px");
});
<#--	FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#synchro-pit-form"), projectID:${projectID?c}}) -->
    $j("#pitWindow").lightbox_me({centered:true,closeEsc:false,closeClick:false,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7}});
	
     initiateRTE('description', 1500, true);
	 initiateRTE('brief', 2700, true);
	 initiateRTE('proposal', 5000, true);
	 initiateRTE('documentation', 2500, true);
	
	<#assign i18CustomPITText><@s.text name="logger.project.pit.view.text" /></#assign>
	var projName = "${project.name?js_string}";
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_CLOSE.getId()}, "${i18CustomPITText}", projName, ${projectID?c}, ${user.ID?c});
	AddCostDetailTitle();
	AddPITFieldTitle();
	
		//issue #309
    var statusVisible= $j("#nonKantarWaiverStatus").is(':visible');
	if(statusVisible==true)
	{  
         $j("#nonKantarAgencyMessage").css({'visibility':'hidden'});
		
     }	
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
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].ADD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_CLOSE.getId()}, "${waiverBtnClickText}", projName, ${projectID?c}, ${user.ID?c});
	</#if>
}
function closeWaiverWindow()
{
   /* $j("#initiateWaiver").hide();
    dialog({
        title:"Confirmation",
        html:"Are you sure you want to close without saving details?",
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
        html:"Are you sure you want to close without saving details?",
        nonCloseActionButtons:['YES'],
        buttons:{
            "YES":function() {
                $j("#pitWindow").hide();
                $j("#pitWindow").trigger('close');
                closeDialog();
			$j('.custom_overlay').remove();
            },
            "NO": function() {
                $j("#pitWindow").show();
            }
        },
        closeActionButtonsClickHander:function() {
            $j("#pitWindow").show();
            closeDialog();
				$j('.custom_overlay').remove();
        }
    });*/
	
	  $j("#pitWindow").hide();
      $j("#pitWindow").trigger('close');
      closeDialog();
		$j('.custom_overlay').remove();

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
        html: '<i class="warningErr positionSet"></i><p>Are you sure you want to remove the attachment? </p>',
        buttons:{
            "YES":function() {
                confirmDelete(attachmentId, fieldID, attachmentName);
            },
            "NO": function() {
                closeDialog();
            }
        }
    });
	relPos();

}

function removeAttachmentMessage(attachmentField) {
    dialog({
        title: '',
        html: '<i class="positionSet"></i><p>Please upload a new '+attachmentField+' before removing the existing one </p>',
        buttons:{
            "OK":function() {
               closeDialog();
            }
        }
    });
	relPos();
	orangeBtn();
}

function confirmDelete(attachmentId, fieldID, attachmentName) {
    location.href="/new-synchro/report-summary!removeAttachment.jspa?projectID=${projectID?c}&attachmentId="+attachmentId+"&attachmentFieldID="+fieldID+"&attachmentName="+attachmentName;
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


<#assign isMethAppUser = statics['com.grail.synchro.util.SynchroPermHelper'].isMethodologyApproverUser() />
<#assign isKantarMethAppUser = statics['com.grail.synchro.util.SynchroPermHelper'].isKantarMethodologyApproverUser() />



<#assign isProjectCreator = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectCreatorNew(projectID) />
<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
<#assign isLegalApprover = statics['com.grail.synchro.util.SynchroPermHelper'].isLegaUserType() />
<#assign isSynchroSystemOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner() />
<#assign canEditStage = statics['com.grail.synchro.util.SynchroPermHelper'].canEditProject(project) />


<#assign defaultCurrency = -1/>




    <#assign endMarketId = endMarketDetails.get(0).getEndMarketID() />
	
<#--	
<div class="new-page-wrapper">
	<div class="new-page-nav">
	<hr></hr>
	<ul>
	
	<li><div class="nav-select">1</div><span>in planning</span></li>
	<li><div class="nav-select">2</div><span>in progress</span></li>
	<li><div class="nav-select">3</div><span>complete</span></li>
	<li><div class="nav-select">4</div><span>close</span></li>
	</ul>
	</div>
</div>
-->
	
<div class="container">
<div class="project_names">


<div class="project_name_div">

<h2>${project.name?html} (${generateProjectCode('${projectID?c}')}) </h2>

<#if (isAdminUser || isSynchroSystemOwner)>
	<#if (isAdminUser || isSynchroSystemOwner) && project.isCancel>
		<a class="cancel-project view-edit" href="javascript:void(0);" onclick="javascript:enableProject()">Enable Project</a>
	<#else>
		<#if canEditStage >
			<a class="cancel-project view-edit" href="javascript:void(0);" onclick="javascript:cancelProject()">Cancel Project</a>
		</#if>	
	</#if>
</#if>	

<#if isAdminUser || isSynchroSystemOwner> 
	<a class="cancel-project view-edit" href="/new-synchro/log-dashboard.jspa?projectID=${projectID?c}" >View Logs</a>
</#if>


<#-- <span class="warning-msg"><span></span>PIB cannot be completed until all the mandatory PIB fields have not been filled.</span> -->
<div id="jive-error-box" class="jive-error-box warning" <#if showMandatoryFieldsError?? && showMandatoryFieldsError>style="display:block;"<#else>style="display:none"</#if>>
    <div>
    <#--<span class="jive-icon-med jive-icon-redalert"></span>-->
        <span><@s.text name="project.mandatory.error"/></span>
    </div>
</div>
<#--</#if>-->






<form method="POST" name="resetProposalForm" id="resetProposalForm" action="/new-synchro/project-eval!resetProposal.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
</form>

<form method="POST" name="resetPIBForm" id="resetPIBForm" action="/new-synchro/project-eval!resetPIB.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
</form>

<form name="report-summary" action="/new-synchro/report-summary!execute.jspa" method="POST"  id="report-summary-form" class="research_pib pib" >
<div class="research_content">
<input type="hidden" name="projectID" value="${projectID?c}">
<input type="hidden" name="isSave" value="${save?string}">
  <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>

  
<div class="pib_inner_main">

<#-- Report Summary Code Starts  -->
<span><i>This project is now closed. </i></span> <a class="closeonloadPopup" href="javascript:void(0);" onclick="javascript:openPITWindow()">Click here to view details.</a>




    <#assign synchroUtils = jiveContext.getSpringBean("synchroUtils") />

<script type="text/javascript">
    var attachmentWindow = null;
	var attachmentWindowAgencyWaiver = null;
	
    $j(document).ready(function(){
        attachmentWindow = new SYNCHRO_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/new-synchro/project-close!addAttachment.jspa'/>",
            projectID:${projectID?c},
            endMarketID:${endMarketId?c},
           parentForm:$j("#synchro-pit-form"),
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
		
		attachmentWindowAgencyWaiver = new SYNCHRO_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/new-synchro/project-close!addAttachment.jspa'/>",
            projectID:${projectID?c},
            endMarketID:${endMarketId?c},
            parentForm:$j("#kantar-waiver-form"),
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
	function showAttachmentPopupNew(fieldId, reportType, reportOrderId) {
      	
	
		
		attachmentWindow.show(fieldId,'TITLE', reportType, reportOrderId);
    }
	function showAttachmentPopupNewReport(fieldId, curr, reportOrderId) {
		var reportType = $j(curr).parent().parent().find(".report-type-attach").val();
		
		if(reportType!=null && reportType!="")
		{
			attachmentWindow.show(fieldId,'TITLE', reportType, reportOrderId);
		}
		else{
			attachmentWindow.show(fieldId,'TITLE', 0, reportOrderId);
		}
	}
	
	function showAgenyWaiverAttachmentPopup(fieldId)
	{
		$j("#kantarMethodologyWaiverAction").val('Waiver Attachment');
		var p = $j('.j-form-popup').is(":visible");	
			if(p){
				if($j('.custom_overlay').length < 1){
					$j('body').append("<div class='custom_overlay'></div>");
				}
				$j('.js_lb_overlay').remove();
			}
		attachmentWindowAgencyWaiver.show(fieldId);
	}
</script>


 


<script type="text/javascript">
    var initiateKantarWaiverWindow = null;
    $j(document).ready(function(){
       <#-- initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request for Agency Waiver',confirmOnClose:false});
        FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#kantar-waiver-form"), projectID:${projectID?c}});-->
    });

</script>





<div class="buttons">
    <#if editStage  >
        <br>
        <input type="hidden" id="confirmProject" name="confirmProject" value="" />
		<input type="submit" name="save pib" onclick="return validatePIBFormFields();" value="Save" class="save"/>
		<input type="button" name="save pib" onclick="return confirmProject();" value="Proceed to Project Evaluation" class="save continue"/>
    </#if>
</div>

</div>
</div>


</form>
<#-- ELSE BLOCK ENDS in case the user is not External Agency or communication Agency -->









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
     <div class="">
  
   
		
        <form id="waiver-form" action="<@s.url value='/new-synchro/project-close!updateWaiver.jspa'/>" method="post" class="j-form-popup">
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
			<div class="pop-upinner-content">
        	 <h3>Request for Methodology Waiver</h3>
          
		    
		    
           
            <div class="top-heading-Waiver"><label class='rte-editor-label'>Methodology Deviation Rationale</label></div>
            <div class="pib_view_popup form-text_div resetpadd-marg">
			
            <#if isAdminUser || isSynchroSystemOwner>
                <textarea id="methodologyDeviationRationale" name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
			
			<#elseif isSynchroSystemOwner>
				 <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
			
			<#elseif !(canEditStage) >
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
                

                
            <#if isAdminUser || isSynchroSystemOwner>
                <input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
             
			<#elseif isSynchroSystemOwner>	
				<input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
			
            <#elseif  canEditStage>
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

                
            <#if isAdminUser || isSynchroSystemOwner>
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
        <#if isAdminUser || isSynchroSystemOwner>
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

  

        <form id="kantar-waiver-form" action="<@s.url value='/new-synchro/project-close!updateKantarWaiver.jspa'/>" method="post">
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
            <#if isAdminUser || isSynchroSystemOwner>
                <textarea id="methodologyDeviationRationaleKantar" name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
			
			<#elseif isSynchroSystemOwner>
				 <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
			
            <#elseif !(canEditStage) >
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
			<a href='${JiveGlobals.getJiveProperty("synchro.agency.waiver.template.path"," /file/download/AgencyCostDetails-SingleMarketTemplate.xlsx")}'>Download Agency Waiver Template</a>
			
			<p>Waiver Document</p> 
			<#-- <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAgenyWaiverAttachmentPopup(${agencyWaiverID?c})" ></span> -->
			
			<#if isAdminUser || isSynchroSystemOwner>
               <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAgenyWaiverAttachmentPopup(${agencyWaiverID?c})" ></span>
        
            <#elseif canEditStage>
                <#if  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                   
				
				<#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
                     <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAgenyWaiverAttachmentPopup(${agencyWaiverID?c})" ></span>
				
				<#elseif  pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status==0>
                   		
					
                <#else>
                   <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAgenyWaiverAttachmentPopup(${agencyWaiverID?c})" ></span>
              
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
							<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser || isSynchroSystemOwner) >
								
								<#if isAdminUser || isSynchroSystemOwner>
									<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${agencyWaiverID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
								<#else>
									<#if  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
									<#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
										<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${agencyWaiverID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
									<#elseif  pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status==0>
									<#else>
										<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${agencyWaiverID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
									</#if>
								</#if>
							</#if>
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
						</div>
					</#list>
				</div>
			</#if>

			 <span class="jive-error-message" id="waiverAttachmentError" style="display:none">Please upload the Waiver Document</span>
			 
            <div class="pib_view_popup">
               
                
            <#if isAdminUser || isSynchroSystemOwner>
                <input id="kantar-send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
               
			<#elseif isSynchroSystemOwner>
				<input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
			
            <#elseif canEditStage>
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

                
            <#if isAdminUser || isSynchroSystemOwner>
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
        <#if isAdminUser || isSynchroSystemOwner>
            
            <input id="kantar-approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
            <input id="kantar-reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />
			<input id="kantar-request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />

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
            
            <input type="button" class="g-btn g-btn-medium"  name="doPost" id="postButton" value="Approve" style="font-weight: bold;cursor:default;" />
            <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />
			<input type="button" class="g-btn r-more"  name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
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
	
	
        <form id="synchro-pit-form" action="<@s.url value='/new-synchro/project-close!updatePIT.jspa'/>" method="post" class="j-form-popup">
		 <a href="javascript:void(0);" class="close" onclick="closePITWindow();"></a>
		 <div class="popup-title-overlay"></div>
		 <div class="pop-upinner-scroll">
		  <div class="pop-upinner-content">
            <h3>Project Details Overview</h3>
			
            <div class="pib_view_popup region-inner">
                <label>Project Name </label>
           
		<#if isAdminUser || isSynchroSystemOwner>
			<input type="text" id="projectName" name="projectName" value="${project.name?html}"  maxlength="250" class="pit_window_field_width"/>
		<#else>
			<input type="text" id="projectName" name="projectName" disabled value="${project.name?html}" maxlength="250" class="pit_window_field_width"/>
		</#if>
            </div>
			<div class="region-inner">
            <label class="pit-description-label">Project Description</label>
           
			  
			<div class="form-text_div">
				<#if isAdminUser || isSynchroSystemOwner>
					<textarea id="description" name="description" rows="10" cols="20" class="form-text-div">${project.description?default('')?html}</textarea>
					<@macroCustomFieldErrors msg="Please enter the Project description" class='textarea-error-message'/>
				<#else>
					<textarea id="description" disabled name="description" rows="10" cols="20" class="form-text-div">${project.description?default('')?html}</textarea>
					<@macroCustomFieldErrors msg="Please enter the Project description" class='textarea-error-message'/>
				</#if>	
				<@macroCustomFieldErrors msg="Please enter the Project description" class='textarea-error-message'/>
			</div>
			<textarea style="display:none;" id="descriptionText" name="descriptionText">${project.description?default('')?html}</textarea>
             </div>
            
			
			<div class="region-inner">
				
				<label class="label_b"><@s.text name="project.initiate.project.category"/></label>
				<div class="col-lg-6">
			  
					<#if isAdminUser || isSynchroSystemOwner>
						<select data-placeholder="Select Category Type" class="chosen-select" id = "categoryType" name="categoryType" multiple >
					<#else>
						<select data-placeholder="Select Category Type" class="chosen-select" id = "categoryType" name="categoryType" disabled multiple >
					</#if>
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
				
					<span class="jive-error-message" id="categoryTypeErrors" style="display:none">Please enter CategoryType</span>
					
				
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
						
						<#assign globalEndMarketId = JiveGlobals.getJiveIntProperty("synchro.global.endmarketId",1) />
						
						<#if endMarketIds?? && endMarketIds?size gt 0 && endMarketIds?seq_contains(globalEndMarketId) >
						
							<label class="label_b">Research End Market</label>
					
							<div class="col-lg-6">
					
							<#if isAdminUser || isSynchroSystemOwner>	
								<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets'  >
							<#else>
								<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets' disabled >
							</#if>		
							<option value=""></option>
							
							<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getGlobalEndMarket() />
							<#list endMarkets.keySet() as endMarketkey>
								<option value="${endMarketkey?c}" selected>${endMarkets.get(endMarketkey)}</option>
							</#list>
							
						<#elseif project.projectType?? && project.projectType==2 && project.onlyGlobalType?? && project.onlyGlobalType==1>	
							<label class="label_b">Research End Market(s)</label>
								<div class="col-lg-6">
							<#if isAdminUser || isSynchroSystemOwner>	
								<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets'  >
							<#else>
								<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets' disabled >
							</#if>	
								<#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
								<#assign regionsKeySet = regions.keySet() />
								<#list regionsKeySet as key>
									
									<#if regions.get(key?int) == "Global">
									<#else>
										<#if endMarketIds?seq_contains(key)>
											<option  value="${key}" selected >${regions.get(key?int)}</option>
										<#else>
											<option  value="${key}" >${regions.get(key?int)}</option>
										</#if>
									</#if>	
													
								</#list>	
								
						<#else>
						
							<label class="label_b">Research End Market(s)</label>
					
							<div class="col-lg-6">
					
							<#if isAdminUser || isSynchroSystemOwner>	
								<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets' multiple >
							<#else>
								<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets' multiple disabled >
							</#if>
							<option value=""></option>
							<#assign endMarketRegions = statics['com.grail.synchro.SynchroGlobal'].getRegionEndMarketsMapping() />
							<#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
							<#if project.globalOutcomeEUShare?? && (project.globalOutcomeEUShare == 1 || project.globalOutcomeEUShare == 2) >
								<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEUEndMarkets() />
								 <#assign endMarketTypeMap = statics['com.grail.synchro.SynchroGlobal'].getEndmarketMarketTypeMap() />
									<#assign endMarketRegionsKeySet = endMarketRegions.keySet() />
									<#if (endMarketRegions?has_content)>
										<#list endMarketRegionsKeySet as key>
											<#assign region = endMarketRegions.get(key) />
											 <optgroup label="${regions.get(key)}">
												 <#assign endMarketKeySet = endMarketRegions.get(key).keySet() />
												 <#list endMarketKeySet as endMarketkey>
													<#if endMarketTypeMap?? && endMarketTypeMap.get(endMarketkey)?? && endMarkets.get(endMarketkey)?? >
														<#if endMarketIds?? && endMarketIds?size gt 0>
															<option value="${endMarketkey?c}" eu="${endMarketTypeMap.get(endMarketkey)}" <#if endMarketIds?seq_contains(endMarketkey)> selected </#if>>${endMarkets.get(endMarketkey)}</option>
														<#else>
															<option value="${endMarketkey?c}" eu="${endMarketTypeMap.get(endMarketkey)}" >${endMarkets.get(endMarketkey)}</option>
														</#if>
													</#if>	
													
												 </#list>
											</optgroup>	 
										</#list>
									</#if>
							<#else>
								<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getNonEUEndMarkets() />
								 <#assign endMarketTypeMap = statics['com.grail.synchro.SynchroGlobal'].getEndmarketMarketTypeMap() />
									<#assign endMarketRegionsKeySet = endMarketRegions.keySet() />
									<#if (endMarketRegions?has_content)>
										<#list endMarketRegionsKeySet as key>
											<#assign region = endMarketRegions.get(key) />
											 <optgroup label="${regions.get(key)}">
												 <#assign endMarketKeySet = endMarketRegions.get(key).keySet() />
												 <#list endMarketKeySet as endMarketkey>
													<#if endMarketTypeMap?? && endMarketTypeMap.get(endMarketkey)?? && endMarkets.get(endMarketkey)?? >
														<#if endMarketIds?? && endMarketIds?size gt 0>
															<option value="${endMarketkey?c}" eu="${endMarketTypeMap.get(endMarketkey)}" <#if endMarketIds?seq_contains(endMarketkey)> selected </#if>>${endMarkets.get(endMarketkey)}</option>
														<#else>
															<option value="${endMarketkey?c}" eu="${endMarketTypeMap.get(endMarketkey)}" >${endMarkets.get(endMarketkey)}</option>
														</#if>
													</#if>	
													
												 </#list>
											</optgroup>	 
										</#list>
									</#if>
							</#if>	
						</#if>
					
					<#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId())>
						<label class="label_b">Research End Market</label>
						
						<div class="col-lg-6">
						
						<#if isAdminUser || isSynchroSystemOwner>
							<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets' >
						<#else>
							<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets' disabled >
						</#if>
					
					    <option value=""></option>
					    <#assign endMarketRegions = statics['com.grail.synchro.SynchroGlobal'].getRegionEndMarketsMapping() />
					    <#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
					    <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEUEndMarkets() />
							<#assign endMarketRegionsKeySet = endMarketRegions.keySet() />
							<#if (endMarketRegions?has_content)>
								<#list endMarketRegionsKeySet as key>
									<#assign region = endMarketRegions.get(key) />
									 <optgroup label="${regions.get(key)}">
										 <#assign endMarketKeySet = endMarketRegions.get(key).keySet() />
										 <#list endMarketKeySet as endMarketkey>
											<#if endMarkets?? && endMarkets.get(endMarketkey)??>
												<option value="${endMarketkey?c}" <#if selectedEndMarket==endMarketkey> selected </#if>>${endMarkets.get(endMarketkey)}</option>
												</#if>
											
														
														
										 </#list>
									</optgroup>	 
								</#list>
							</#if>
						
					<#else>
						<label class="label_b">Research End Market</label>
				
						<div class="col-lg-6">
						<#if isAdminUser || isSynchroSystemOwner>
							<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets' >
						<#else>
							<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets' disabled >
						</#if>
					
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
					</#if>	
					</select>
					<span class="jive-error-message" id="endMarketError" style="display:none"><@s.text name='project.error.endmarket' /></span>
				
				</div>
			</div>
			
				<!--amit Reference Project Details-->
	 <#if project.processType?? && project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId()>
	<#assign showRefProjectMessage="" />
	  <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
	  <#assign endMarketTypeMap = statics['com.grail.synchro.SynchroGlobal'].getEndmarketMarketTypeMap() />
	  <#if endMarketIds?? >
	  <#list endMarketIds as eId>
		<#if endMarketTypeMap?? && (endMarketTypeMap.get(eId?int))?? && endMarketTypeMap.get(eId?int)==1>
			<#assign showRefProjectMessage="yes" />
		<#else>
			
		</#if>
	  </#list>
	  </#if>
	  
	  
	  
	  
	  
	<#--<#if showRefProjectMessage=="yes">-->
	<#if showRefProjectMessage=="yes" && project?? && project.euMarketConfirmation?? && project.euMarketConfirmation==1 >
	<label class="label_b"> Reference Project Details</label>
	 <div class="form-text_div reference-project-details"   id="ReferenceProjectDetailsDiv1">
				  
		   
		    
			  <h3><span>Research End Market</span><span>SynchrO Code</span></h3>
			  
			  <div id="dynamicReferenceProjectDetailsDiv1">
			  </div>
			  
				  <script>
				  
				  var euMarkertValues=[];
				  var  euMarketText=[];
				  var  refSynCode=[];
				  var  showEndMarket=[];
	
				<#list endMarketDetails as emd >
				  <#if emd?? >
					  var emId = "${emd.getEndMarketID()}";
					  euMarkertValues.push(emId);
					  var emText = "${endMarkets.get(emd.getEndMarketID()?int)}";
					  euMarketText.push(emText);
					  <#if emd.getReferenceSynchroCode()?? && emd.getReferenceSynchroCode() gt 0 >
						var rSCode = "${emd.getReferenceSynchroCode()?c}";
						refSynCode.push(rSCode);
					  <#else>
						refSynCode.push("");
					  </#if>
					  
					  <#if endMarketTypeMap.get(emd.getEndMarketID()?int)==1>
						showEndMarket.push("yes");	
					  <#else>
						showEndMarket.push("no");
					  </#if>
				  </#if>
				</#list>
				  
					var i=0;
				    <#if (isAdminUser || isSynchroSystemOwner) >
						for(i=0;i<euMarkertValues.length;i++)
						{
							if(showEndMarket[i]=="yes")
							{
								var div = $j("<div/>");
								div.html(dynamicReferenceProjectDetailsComponentsEnabled(i));  
								$j("#dynamicReferenceProjectDetailsDiv1").append(div);
									//$j(".chosen-select").chosen();
							}
					   }
				   <#else>
				   
						for(i=0;i<euMarkertValues.length;i++)
						{
							if(showEndMarket[i]=="yes")
							{
								var div = $j("<div/>");
								div.html(dynamicReferenceProjectDetailsComponents(i));  
								$j("#dynamicReferenceProjectDetailsDiv1").append(div);
									//$j(".chosen-select").chosen();
							}
					   }
				   </#if>
				   
						   
						   
						 function dynamicReferenceProjectDetailsComponents(val)
							  {
						   var comp="";
						  comp= "<div class='custom'><select  disabled class='chosen-select' id='referenceEndMarkets' name='referenceEndMarkets'><option value='"+euMarkertValues[val]+"'>"+euMarketText[val]+"</option></select></div>&nbsp&nbsp&nbsp&nbsp";
	
			
						 var content=comp+'<div class="float-left synchroCode_row"><input disabled  name ="referenceSynchroCodes" type="text"   id="referenceSynchroCodes" placeholder="Enter SynchrO Code" onChange="return isNumber()"  onfocus="this.placeholder = \'\'" onblur="this.placeholder = \'Enter SynchrO Code\'"  class="text_field  longField total-expense" value='+refSynCode[val]+'><span class="jive-error-message synchroCodeError" style="display: none;">Please enter numeric value</span></div>'
	
						 return content;      
						}	

						 function dynamicReferenceProjectDetailsComponentsEnabled(val)
							  {
						   var comp="";
						  comp= "<div class='custom'><select  class='chosen-select' id='referenceEndMarkets' name='referenceEndMarkets'><option value='"+euMarkertValues[val]+"'>"+euMarketText[val]+"</option></select></div>&nbsp&nbsp&nbsp&nbsp";
	
			
						 var content=comp+'<div class="float-left synchroCode_row"><input   name ="referenceSynchroCodes" type="text"   id="referenceSynchroCodes" placeholder="Enter SynchrO Code" onChange="return isNumber()"  onfocus="this.placeholder = \'\'" onblur="this.placeholder = \'Enter SynchrO Code\'"  class="text_field  longField total-expense" value='+refSynCode[val]+'><span class="jive-error-message synchroCodeError" style="display: none;">Please enter numeric value</span></div>'
	
						 return content;      
						}		
		  
				   </script>
		  
			  </div>
		</#if>
	</#if>
	<!--amit-->
			
			<#if project?? && project.globalOutcomeEUShare?? && (project.globalOutcomeEUShare==1 || project.globalOutcomeEUShare==2 ) >
				<div class="region-inner">
					<div class="form-select_div">
						
					<label>Will the outcome be shared with the respective EU market?</label>
					
					<@globalOutcomeEUShare name='globalOutcomeEUShare' value=project.globalOutcomeEUShare?default(-1) readonly=true/>
					<span class="jive-error-message" id="globalOutcomeEUShareError" style="display:none">Will the outcome be shared with the respective EU market?</span>
					</div>
				</div>
			</#if>
			
			<div class="region-inner">
					
				<div class="form-select_div start_date">
					<label>Project Start Date</label>
			   
				<#if isAdminUser || isSynchroSystemOwner>
					<@synchrodatetimepicker id="startDate1" name="startDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false dateCompareStartPIT=true/>
				<#else>
					<input type="text"  name="startDate" value="${project.startDate?string('dd/MM/yyyy')}" disabled id="startDate"  />
				</#if>
				<#assign error_msg><@s.text name='project.error.startdate' /></#assign>
				<@macroCustomFieldErrors msg=error_msg />
				<@macroFieldErrors name="startDate"/>
				</div>
			</div>	
			<div class="region-inner">
				<div class="form-select_div form-select_div_project_completion">
					<label>Project End Date</label>
					 
				<#if isAdminUser || isSynchroSystemOwner>
					<@synchrodatetimepicker id="endDate1" name="endDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false dateCompareEndPIT=true/>
				<#else>
					<input type="text"  name="endDate" value="${project.endDate?string('dd/MM/yyyy')}" disabled id="endDate"  />
				</#if>
				<#assign error_msg><@s.text name='project.error.enddate' /></#assign>
				<@macroCustomFieldErrors msg=error_msg />
				<@macroFieldErrors name="endDate"/>
				</div>
			</div>
			
			<div class="region-inner">
				
				
				<div class="form-select_div">

					<label>SP&I Contact</label>
					<div>
					
					   
					<#if isAdminUser || isSynchroSystemOwner>   
						<input type="text"  name="projectManagerName" value="${project.projectManagerName}" id="projectManagerName"  />
					<#else>
						<input type="text"  name="projectManagerName" value="${project.projectManagerName}" disabled id="projectManagerName"  />
					</#if>

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
				  
						<#if isAdminUser || isSynchroSystemOwner>
							<select data-placeholder="Select Methodology" class="chosen-select" id = "methodologyDetails" name = "methodologyDetails" multiple >
						<#else>
							<select data-placeholder="Select Methodology" class="chosen-select" id = "methodologyDetails" name = "methodologyDetails" disabled >
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
														<option lessFrequent="yes" value="${methkey?c}" <#if project.methodologyDetails?seq_contains(methkey)> selected</#if>>${methodologies.get(methkey)}</option>
													<#else>
														<option lessFrequent="no" value="${methkey?c}" <#if project.methodologyDetails?seq_contains(methkey)> selected</#if>>${methodologies.get(methkey)}</option>
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
				
					<#if isAdminUser || isSynchroSystemOwner>
						<@renderMethodologyField name='methodologyType' value=project.methodologyType?default('-1') readonly=false/>
					<#else>
						<@renderMethodologyField name='methodologyType' value=project.methodologyType?default('-1') readonly=true/>
					</#if>
					<@macroCustomFieldErrors msg="Please select Methodology Type" />
					
					</div>
					
				</div>
				
					<div class="region-inner">
					
					<div class="form-select_div">
						<label>Will a methodology waiver be required?</label>
					
					<#--<@renderMethodologyWaiverField name='methWaiverReq' value=project.methWaiverReq?default('-1') />-->
					
					<#if isAdminUser || isSynchroSystemOwner>
						<select data-placeholder="Select" class="chosen-select" id = "methWaiverReq" name="methWaiverReq" <#if project.methWaiverReq?? && project.methWaiverReq==1 && pibMethodologyWaiver?? && pibMethodologyWaiver.projectID?? >disabled</#if>   onchange="checkMethDeviation()">
					<#else>
						<select data-placeholder="Select" class="chosen-select" id = "methWaiverReq" name="methWaiverReq" disabled  onchange="checkMethDeviation()">
					</#if>
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
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
					<div id="waiverMessage" style="display:none">You will be able to initiate waiver through the system once the project is created</div>
				</div>
				
				<div class="region-inner">
					
					<div class="form-select_div">
						<label>Is this a brand specific study?</label>
					
					<#if isAdminUser || isSynchroSystemOwner>
						<@renderBrandSpecificStudy name='brandSpecificStudy' value=project.brandSpecificStudy?default('-1') readonly=false/>
                       <span class="jive-error-message" id="brandSpecificStudyError" style="display:none">Please select Is this a brand specific study?</span>
					<#else>
						<@renderBrandSpecificStudy name='brandSpecificStudy' value=project.brandSpecificStudy?default('-1') readonly=true/>
					</#if>
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					<div id="brandSpecific" style="display:none">
					
					<div class="form-select_div">
						
					
					<#if isAdminUser || isSynchroSystemOwner>
						<@renderBrandFieldNew name='brand' value=project.brand?default('-1') readonly=false/>
						<span class="jive-error-message" id="brandError" style="display:none">Please select Brand</span>   
					<#else>
						<@renderBrandFieldNew name='brand' value=project.brand?default('-1') readonly=true/>
						<span class="jive-error-message" id="brandError" style="display:none">Please select Brand</span>   
					</#if>
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
					
					</div>
					<div id="brandSpecificStudyType">
					
					
										
					<#if isAdminUser || isSynchroSystemOwner>					
						<@renderBrandSpecificStudyType name='brandSpecificStudyType' value=project.brandSpecificStudyType?default('-1') readonly=false/>
						<span class="jive-error-message" id="brandSpecificStudyTypeError" style="display:none">Please select Study Type</span>
					<#else>
						<@renderBrandSpecificStudyType name='brandSpecificStudyType' value=project.brandSpecificStudyType?default('-1') readonly=true/>
						<span class="jive-error-message" id="brandSpecificStudyTypeError" style="display:none">Please select Study Type</span>
					</#if>
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					
					</div>
					</div>
					
						<!--change  536-->
					<div class="form-select_div MultibrandTextDivPitPosition" id="MultibrandTextDiv"   style="display:none">
						
							

							<div>
								   
									<!-- new change  536  -->
                                 <#if isAdminUser || isSynchroSystemOwner>
			                       <input type="text"  name="multiBrandStudyText" placeholder="Enter the Brands"" id="multiBrandStudyText"  onfocus="this.placeholder='' " <#if project?? && project.multiBrandStudyText??> value="${project.multiBrandStudyText}" </#if> onblur="this.placeholder = 'Enter the Brands' "/>
								<span class="jive-error-message" id="MultibrandTextError" style="display:none">Please enter Brands</span>
								<#else>
								   <input type="text"  name="multiBrandStudyText" placeholder="Enter the Brands"" id="multiBrandStudyText"  onfocus="this.placeholder='' " <#if project?? && project.multiBrandStudyText??> value="${project.multiBrandStudyText}" </#if> onblur="this.placeholder = 'Enter the Brands' "    disabled/>
								   <span class="jive-error-message" id="MultibrandTextError" style="display:none">Please enter Brands </span>
								
								
								  </#if>
							</div>
						</div>
					
				</div>
				
				
			<div class="region-inner">
					
					<div class="form-select_div">
						<label>Budget Location</label>
					
					<#if isAdminUser || isSynchroSystemOwner>
					
						<select data-placeholder="Select the Budget Location" class="chosen-select" id = "budgetLocation" name="budgetLocation" >
							<option value=""></option>
								<#if project.projectType?? && project.projectType==1 && endMarketIds?? && endMarketIds?size gt 0 && endMarketIds?seq_contains(globalEndMarketId)>
									<option  value="-1" <#if project.budgetLocation?? && project.budgetLocation?int==-1> selected </#if> >Global</option>
									<#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
									<#assign regionsKeySet = regions.keySet() />
									<#list regionsKeySet as key>
										<#if regions.get(key?int) == "Global">
										<#else>
											<#if project?? && project.budgetLocation?? && project.budgetLocation==key>
												<option  value="${key}" selected >${regions.get(key?int)}</option>
											<#else>
												<option  value="${key}" >${regions.get(key?int)}</option>
											</#if>
										</#if>	
									</#list>
								<#elseif project.projectType?? && project.projectType==1>
									<option  value="-1" <#if project.budgetLocation?? && project.budgetLocation?int==-1> selected </#if> >Global</option>
								<#elseif project.projectType?? && project.projectType==2>
									<#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
									<#assign regionsKeySet = regions.keySet() />
									<#list regionsKeySet as key>
										
										<#if regions.get(key?int) == "Global">
										<#else>
											<#if project?? && project.budgetLocation?? && project.budgetLocation==key>
												<option  value="${key}" selected >${regions.get(key?int)}</option>
											<#else>
												<option  value="${key}" >${regions.get(key?int)}</option>
											</#if>
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
									<option  value="-1" <#if project.budgetLocation?? && project.budgetLocation?int==-1> selected </#if> >Global</option>
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
					</#if>	
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
				</div>

				<div class="region-inner">
				<#if isAdminUser || isSynchroSystemOwner>
					<@projectBudgetYearFieldNewForPIT name="budgetYear" value=project.budgetYear readonly=false/>
				<#else>
					<@projectBudgetYearFieldNewForPIT name="budgetYear" value=project.budgetYear readonly=true/>
				</#if>
					<#--<@macroCustomFieldErrors msg="Please enter Budget Year" />
					<span class="jive-error-message" id="budgetYearError" style="display:none">Please enter Budget Year</span> -->
				</div>
				
				<#if isAdminUser || isSynchroSystemOwner>
					<div id="expenseDetailsContainer" class="region-inner">
					<label>Cost Details</label>
					<div class="border-box pit_window_field_width border-inputradius">
					
					<#assign projectCostCounter = 0 />
						<#assign showAgencyWaiver=""/>
						
						<#assign savedAgencies =""/>
					<#list projectCostDetailsList as projectCostDetail>
					
					<#assign projectCostCounter =  projectCostCounter + 1/>
					<#--<div class="expense_row"> -->
					
					<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>
						<div class="expense_row blank">
					<#else>
						<div class="expense_row">
					</#if>
					
					<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>
					<#else>
						<input type="button" value="duplicate" id="firstDuplicate" class="duplicate"/>
						<input type="button" value="Remove" id="firstRemove" class="remove" />
					</#if>
					<div class="region-inner">
						
						
					
					<div id="agencyMain">
					
						<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>
							<#assign savedAgencies =  savedAgencies + "," + projectCostDetail.getAgencyId()/>
							
							<#if isAdminUser>
								<select data-placeholder="Select Research Agency" title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
							<#else>
								<select data-placeholder="Select Research Agency" disabled title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
							</#if>	
						<#else>
							<select data-placeholder="Select Research Agency" title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
						</#if>
						
						
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
														
														<#if project.isMigrated?? && project.isMigrated >
															<option isNonKantar="no" value="${researchAgencykey?c}" <#if projectCostDetail.getAgencyId()==researchAgencykey> selected </#if>>${researchAgencies.get(researchAgencykey)}</option>
														<#else>
															<#if researchAgencykey==131>
															<#else>
																<option isNonKantar="no" value="${researchAgencykey?c}" <#if projectCostDetail.getAgencyId()==researchAgencykey> selected </#if>>${researchAgencies.get(researchAgencykey)}</option>
															</#if>	
														</#if>
														
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
					
					
					
					<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>
						<input type="hidden" name="hiddenAgencies" value="${savedAgencies}">
					<#else>
						<#-- Adding a Blank Row Starts-->
						
							<div class="expense_row blank">
							 <input type="button" value="duplicate" class="duplicate" id="firstDuplicate" style="display:none"/>
							 <input type="button" value="Remove" class="remove" id="firstRemove" style="display:none"/>
							<div class="region-inner">
								
							
								<div id="agencyMain">
							  
								
									<select data-placeholder="Research Agency" title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
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
																	
																	<#if project.isMigrated?? && project.isMigrated >
																		<option isNonKantar="no" value="${researchAgencykey?c}">${researchAgencies.get(researchAgencykey)}</option>
																	<#else>
																		<#if researchAgencykey==131>
																		<#else>
																			<option isNonKantar="no" value="${researchAgencykey?c}">${researchAgencies.get(researchAgencykey)}</option>
																		</#if>	
																	</#if>	
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

									<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" Placeholder="Enter Cost" class="text_field longField total-expense" value=""  onfocus="this.placeholder = ''"   onblur="this.placeholder = 'Enter Cost'"  />
									<span class="jive-error-message agencyCostsError" style="display: none;">Please Enter Agency Cost</span>
									</div>
									
								</div>

							</div>
						</div>
					</#if>	
					
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
										<input type="text" placeholder="0" name="prefCost" id="prefCost" class="text_field numericfield longField" value="${statics['com.grail.synchro.util.SynchroUtils'].getPreferredCurrenyTotalCost(project,user)?round}" disabled />
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
							<div id="nonKantarAgencyMessage" style="display:none">This project requires a waiver for using non-Kantar agency. You can initiate a waiver once a project is created.
							</div>
						</#if>
					</#if>
					</div>
				</div>
				<#else>
				
				
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
						
							<select data-placeholder="Research Agency" title="Select Research Agency" disabled class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
							
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
							<div class="pit-estimate-cost gbp-costalignment">
							
							<#if statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user))?? >
								<label>Total Cost (${statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user))})</label>
							
								<#if statics['com.grail.synchro.util.SynchroUtils'].getPreferredCurrenyTotalCost(project,user)?? >
									<input type="text" placeholder="0" name="totalCost" class="text_field numericfield longField" value="${statics['com.grail.synchro.util.SynchroUtils'].getPreferredCurrenyTotalCost(project,user)?round}" disabled />
								<#else>
									<input type="text" placeholder="0" name="totalCost" class="text_field numericfield longField" value="" disabled />
								</#if>
							  
							</#if>  

							<#assign error_msg><@s.text name="project.error.cost"/></#assign>
							<@macroCustomFieldErrors msg=error_msg class="numeric-error"/>
							</div>
								
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
				
				<#if agencyWaiverException=="yes">
				<#else>
					<div class="project_waiver_rqst region-inner statusPending" id="agencyWaiverDivPIT">
					<label>Agency Waiver Request</label>
					<ul class="right-sidebar-list">

						<li id="initiateKantarWaiverButtonPIT" ><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status!=-1>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>
					</ul>
					
					<div  class="agency_methodology" id="nonKantarWaiverStatus" <#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>style="display:block;" <#else> style="display:none;"</#if>>

						<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
							<span>Status: <sapn class="status-txt approvedStatus">Approved</span></span>
						<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
							<span>Status: <sapn class="status-txt rejectedStatus">Rejected</span></span>
						<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID?? >
							<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_APP_PENDING.ordinal()>
								<span>Status: <span class="status-txt pendingStatus">Pending</span></span>
							</#if>
						<#else>
						</#if>

					
					</div>
					</div>
				</#if>	
				
				<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
			
			<#-- two column row code replace-->
			
			<div class="region-inner two-column">
					
				<div class="form-select_div">
					<label>Is an end market involved in this project</label>
				
					<#if isAdminUser || isSynchroSystemOwner>
						<#if project.endMarketFunding??>
								<@renderEndMarketFundingField name='endMarketFunding' value=project.endMarketFunding?default('-1') />
						<#else>
								<@renderEndMarketFundingField name='endMarketFunding' value=-1 />
						</#if>
					<#else>
					
						<#if project.endMarketFunding??>
								<@renderEndMarketFundingField name='endMarketFunding' value=project.endMarketFunding?default('-1') readonly=true/>
						<#else>
								<@renderEndMarketFundingField name='endMarketFunding' value=-1 readonly=true/>
						</#if>
					</#if>
				
				</div>
				
				<div class="form-select_div second-column" id="fundingMarketsDiv" <#if project.endMarketFunding?? && project.endMarketFunding==1> style="display:block" <#else>style="display:none"</#if>>
					<label>Select the end market(s) which will carry out the fieldwork</label>
				
				<div class="pitfundMsg__fix">
					<#if project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId()>
						<#if isAdminUser || isSynchroSystemOwner>
							<select data-placeholder="Select end-market" class="chosen-select" id = "fundingMarkets" name="fundingMarkets" multiple >
						<#else>
							<select data-placeholder="Select end-market" class="chosen-select" disabled id = "fundingMarkets" name="fundingMarkets" multiple >
						</#if>
							<option value=""></option>
							<#if project.projectType?? && project.projectType==2 && project.onlyGlobalType?? && project.onlyGlobalType==1>
								
								<#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
								<#assign regionsKeySet = regions.keySet() />
								
								
								
								<#if endMarketDetails??>
									<#list endMarketDetails as emd >
										<#if emd?? && emd.getIsFundingMarket()?? && emd.getIsFundingMarket() && (regions.get(emd.getEndMarketID()?int))??>
											<option value="${emd.getEndMarketID()}" selected>${regions.get(emd.getEndMarketID()?int)}</option>
										<#else>
										   <#if (regions.get(emd.getEndMarketID()?int))??>
												<option value="${emd.getEndMarketID()}">${regions.get(emd.getEndMarketID()?int)}</option>
											</#if>	
										</#if>
									</#list>
								</#if>
							<#else>
								<#if endMarketDetails??>
									<#list endMarketDetails as emd >
										<#if emd?? && emd.getIsFundingMarket()?? && emd.getIsFundingMarket() && (endMarkets.get(emd.getEndMarketID()?int))??>
											<option value="${emd.getEndMarketID()}" selected>${endMarkets.get(emd.getEndMarketID()?int)}</option>
										<#else>
										   <#if (endMarkets.get(emd.getEndMarketID()?int))??>
												<option value="${emd.getEndMarketID()}">${endMarkets.get(emd.getEndMarketID()?int)}</option>
											</#if>	
										</#if>
									</#list>
								</#if>
							</#if>	
							
						
						</select>	
						  <span class='jive-error-message fundingMarketsError pop_fundErr__fix '  style='display: none;'>Please select the end market(s) which will carry out the fieldwork</span>

					<#else>
					
						<#if isAdminUser || isSynchroSystemOwner>
							<select data-placeholder="Select end-market" class="chosen-select" id = "fundingMarkets" name="fundingMarkets" >
						<#else>
							<select data-placeholder="Select end-market" class="chosen-select" disabled id = "fundingMarkets" name="fundingMarkets" >
						</#if>
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

						<span class='jive-error-message fundingMarketsError pop_fundErr__fix'  style='display: none;'>Please select the end market which will carry out the fieldwork</span>
					<!--	<script type="text/javascript">
							var endMarketO=$j('#endMarkets').val();
							var endMarketText = $j('select[name="endMarkets"] option:selected').text();
							$j("#fundingMarkets option").val(endMarketO).text(endMarketText);
							$j('#fundingMarkets').val(endMarketO).trigger('chosen:updated');
						</script>					-->
					</#if>
				</div>
				 </div>
			</div>			
			</#if>	
			
				
				<div class="region-inner">
					<label class="pit-description-label">Brief</label>
				   
					  
					<div class="form-text_div">
						<#if isAdminUser || isSynchroSystemOwner>
							<textarea id="brief" name="brief" rows="10" cols="20" class="form-text-div">${projectInitiation.brief?default('')?html}</textarea>
						<#else>
							<textarea id="brief" name="brief" disabled rows="10" cols="20" class="form-text-div">${projectInitiation.brief?default('')?html}</textarea>
						</#if>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
					</div>
					<textarea style="display:none;" id="briefText" name="briefText">${projectInitiation.briefText?default('')?html}</textarea>
					 <!-- ATTACHMENT DISPLAY STARTS -->
						<div class="field-attachments">
						<#if isAdminUser || isSynchroSystemOwner>
							<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${briefID?c})" ></span>
						</#if>
					   <#if projectInitiation?? && projectInitiation.sendForApproval?? && projectInitiation.sendForApproval==1 >
							<#if attachmentMap?? && attachmentMap.get(briefID)?? >
									<div id="jive-file-list" class="jive-attachments">
										<#list attachmentMap.get(briefID) as attachment>
											<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
												<span class="jive-icon-med jive-icon-attachment"></span>
												<#if isAdminUser || isSynchroSystemOwner >
													<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
													 
														<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
														
													<#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId())>
														<#if (attachmentMap.get(briefID)?size == 1)>
															<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Brief');"><@s.text name="global.remove" /></a>
														<#elseif (attachmentMap.get(briefID)?size gt 1)>
															<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
														</#if>
													
													<#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId())>
													
														<#if (attachmentMap.get(briefID)?size == 1)>
															<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Brief');"><@s.text name="global.remove" /></a>
														<#elseif (attachmentMap.get(briefID)?size gt 1)>
															<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
														</#if>
													
													</#if>
												</#if>
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
												<#if isAdminUser || isSynchroSystemOwner >
													<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
													 
														<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
														
													<#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId())>
														<#if (attachmentMap.get(briefID)?size == 1)>
															<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Brief');"><@s.text name="global.remove" /></a>
														<#elseif (attachmentMap.get(briefID)?size gt 1)>
															<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
														</#if>
													
													<#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId())>
													
														<#if (attachmentMap.get(briefID)?size == 1)>
															<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Brief');"><@s.text name="global.remove" /></a>
														<#elseif (attachmentMap.get(briefID)?size gt 1)>
															<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
														</#if>
													
													</#if>
												</#if>
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
					
						<#if isAdminUser || isSynchroSystemOwner>
							<div class="region-inner">
								<div class="form-select_div">
									<label>TPD Status</label>
									<#if projectInitiation?? && projectInitiation.legalApprovalStatus?? >
										<@renderLegalApprovalStatusFields name='legalApprovalStatusPitBrief' value="${projectInitiation.legalApprovalStatus}"/>
										<span class="jive-error-message full-width" id="statusError" style="display:none">Please select TPD Status</span>
									<#else>
										<@renderLegalApprovalStatusFields name='legalApprovalStatusPitBrief' value="-1"/>
									</#if>
								</div>
							</div>	
						<#else>
							<#if projectInitiation?? && projectInitiation.sendForApproval?? && projectInitiation.sendForApproval==1 >
								<span class="approval-status popTpd">TPD Status: <span class="status-txt">Pending</span></span>
							<#elseif projectInitiation?? && projectInitiation.legalApprovalStatus?? && (projectInitiation.legalApprovalStatus == 1)  >
								<span class="approval-status popTpd">TPD Status: <span class="status-txt">May have to be Submitted</span></span>
							<#elseif projectInitiation?? && projectInitiation.legalApprovalStatus?? && (projectInitiation.legalApprovalStatus==2)  >
								<span class="approval-status popTpd">TPD Status: <span class="status-txt">Does not have to be Submitted</span></span>
							</#if>
						</#if>
					</#if>
					
					
					<#if project.processType?? && project.processType !=  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() && project.processType !=  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId()>
					
						<div class="form-select_div form-select_div_project_completion region-inner">
							
							<label>Legal Approver's Name</label>
							<div>
								<#if (isAdminUser || isSynchroSystemOwner) && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
								
								<#--
								<select data-placeholder="Select Legal Approver"  class="chosen-select" id = "briefLegalApprover" name='briefLegalApprover' >
								
									<option value=""></option>
									<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
									<#assign endMarketApproversKeySet = endMarketLegalApprovers.keySet() />
									<#list endMarketApproversKeySet as key>
										<optgroup label="${endMarkets.get(key?int)}">
											<#list endMarketLegalApprovers.get(key) as legalUser >
											<#if projectInitiation?? && projectInitiation.briefLegalApprover?? && projectInitiation.briefLegalApprover == legalUser.ID>
												<option value="${legalUser.ID?c}" selected>${legalUser.name}</option>
											<#else>
												<option value="${legalUser.ID?c}">${legalUser.name}</option>
											</#if>
											</#list>
										</optgroup>
									</#list>
										
								</select>
								-->
								
								<#if projectInitiation.getBriefLegalApproverOffline()??>
									<input type="text" placeholder="Select Legal Approver" name="briefLegalApproverOffline"  value="${projectInitiation.getBriefLegalApproverOffline()}"  />
								<#else>
									<input type="text" placeholder="Select Legal Approver" name="briefLegalApproverOffline"  value=""  />
								</#if>	
								 <span class="jive-error-message full-width" id="briefLegalApproverError" style="display:none">Please select Brief Legal Approver</span>
							<#else>
								<#if project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId()>
									<#if projectInitiation.getBriefLegalApproverOffline()??>
										<input type="text" placeholder="Select Legal Approver" name="briefLegalApproverOffline" disabled value="${projectInitiation.getBriefLegalApproverOffline()}"  />
									<#else>
										<input type="text" placeholder="Select Legal Approver" name="briefLegalApproverOffline" disabled value=""  />
									</#if>
								<#else>
									<#if projectInitiation?? && projectInitiation.briefLegalApprover??>
										<#assign legalApproverName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(projectInitiation.briefLegalApprover) />
									<#else>
										<#assign legalApproverName = '' />
									</#if>
									<input type="text"  name="legalApproverName" value="${legalApproverName}" id="legalApproverName"  disabled />
								</#if>	
								
							</#if>
						<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
								<div class="field-attachments popup-attachment">
								<#if (isAdminUser || isSynchroSystemOwner) && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
								<div id="attachApprovalMailDiv">	
									<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${briefLegalApprovalID?c})" ></span>
								</div>
								</#if>
								<sub>Attach Approval E-mail</sub>
								<#if attachmentMap?? && attachmentMap.get(briefLegalApprovalID)?? >
									<div id="jive-file-list" class="attachmentsNew jive-attachments">
										<#list attachmentMap.get(briefLegalApprovalID) as attachment>
											<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
												<span class="jive-icon-med jive-icon-attachment"></span>
												<#if (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(briefLegalApprovalID)?size == 1 >
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Brief Approval');"><@s.text name="global.remove" /></a>	
												<#elseif (isAdminUser || isSynchroSystemOwner) || attachmentMap.get(briefLegalApprovalID)?size gt 1 >
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefLegalApprovalID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
												</#if>
												
												<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
												${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
											</div>
										</#list>
									</div>
								</#if>
							</div>
							</#if>
						</div>
					</div>
					
					<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
					
						 <div class="region-inner">
							<div class="form-select_div">
								<label>TPD Status</label>
								<#if isAdminUser || isSynchroSystemOwner>
									<#if projectInitiation?? && projectInitiation.legalApprovalStatus?? >
										<@renderLegalApprovalStatusFields name='legalApprovalStatusPitBrief' value="${projectInitiation.legalApprovalStatus}" />
									<#else>
										<@renderLegalApprovalStatusFields name='legalApprovalStatusPitBrief' value="-1" />
									</#if>
								<#else>
									<#if projectInitiation?? && projectInitiation.legalApprovalStatus?? >
									<@renderLegalApprovalStatusFields name='legalApprovalStatusPit' value="${projectInitiation.legalApprovalStatus}" readonly=true/>
									<#else>
										<@renderLegalApprovalStatusFields name='legalApprovalStatusPit' value="-1" readonly=true/>
									</#if>
									<span class="jive-error-message full-width" id="briefLegalApprovalStatusError" style="display:none">Please select TPD Status</span>
								</#if>
							</div>
						</div>
						
						
						<div class="form-select_div form-select_div_project_completion region-inner">
						
							<label>Date of Legal Approval</label>
							<div>
								<#if isAdminUser || isSynchroSystemOwner>
									<@synchrodatetimepicker id="legalApprovalDateBrief" name="legalApprovalDateBrief" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder='Enter Legal Approval Date'/>
								<#else>
									<#if projectInitiation?? && projectInitiation.legalApprovalDate??>
									<input type="text"  name="legalApproverDatePit" value="${projectInitiation.legalApprovalDate?string('dd/MM/yyyy')}" id="legalApproverDatePit"  disabled />
									<#else>
										<input type="text"  name="legalApproverDatePit" value="" id="legalApproverDatePit"  disabled />
									</#if>
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
				
				
				
				<div class="region-inner">
					<label class="pit-description-label">Proposal</label>
				   
					  
					<div class="form-text_div">
						<#if isAdminUser || isSynchroSystemOwner>
							<textarea id="proposal" name="proposal" rows="10" cols="20" class="form-text-div">${proposalInitiation.proposal?default('')?html}</textarea>
						<#else>
							<textarea id="proposal" name="proposal" rows="10" cols="20" disabled class="form-text-div">${proposalInitiation.proposal?default('')?html}</textarea>
						</#if>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
					</div>
					<textarea style="display:none;" id="proposalText" name="proposalText">${proposalInitiation.proposalText?default('')?html}</textarea>
					 <!-- ATTACHMENT DISPLAY STARTS -->
						<div class="field-attachments">
						<#if isAdminUser || isSynchroSystemOwner>
							<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${proposalID?c})" ></span>
						</#if>
					   <#if proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
							<#if attachmentMap?? && attachmentMap.get(proposalID)?? >
									<div id="jive-file-list" class="jive-attachments">
										<#list attachmentMap.get(proposalID) as attachment>
											<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
												<span class="jive-icon-med jive-icon-attachment"></span>
												<#if isAdminUser || isSynchroSystemOwner>
													<#if (attachmentMap.get(proposalID)?size == 1)>
														<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Proposal');"><@s.text name="global.remove" /></a>
													<#elseif (attachmentMap.get(proposalID)?size gt 1)>
														<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${proposalID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
													</#if>
												</#if>
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
										<#if isAdminUser || isSynchroSystemOwner>
											<#if (attachmentMap.get(proposalID)?size == 1)>
												<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Proposal');"><@s.text name="global.remove" /></a>
											<#elseif (attachmentMap.get(proposalID)?size gt 1)>
												<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${proposalID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
											</#if>
										</#if>
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
												<#if isAdminUser || isSynchroSystemOwner>
													<#if (attachmentMap.get(proposalID)?size == 1)>
														<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Proposal');"><@s.text name="global.remove" /></a>
													<#elseif (attachmentMap.get(proposalID)?size gt 1)>
														<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${proposalID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
													</#if>
												</#if>
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
				
				<!--TPD SUMMARY LEGAL DETAILS START -->
				<#if tpdSummary?? && tpdSummary.legalApprovalStatus??>
					<div class="region-inner">
						<div class="form-select_div">
							<label>TPD Summary Status</label>
							<#if tpdSummary?? && tpdSummary.legalApprovalStatus?? >
								<@renderLegalApprovalStatusFields name='legalApprovalStatusTpd' value="${tpdSummary.legalApprovalStatus}" readonly=true/>
							<#else>
								<@renderLegalApprovalStatusFields name='legalApprovalStatusTpd' value="-1" readonly=true/>
							</#if>
						</div>
					</div>
					
					<div class="form-select_div form-select_div_project_completion region-inner">
									
						<label>TPD Summary Legal Approver's Name</label>
						<div>
							<#if tpdSummary?? && tpdSummary.legalApprover??>
								<#assign legalApproverName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(tpdSummary.legalApprover) />
							<#else>
								<#assign legalApproverName = '' />
							</#if>
							<input type="text"  name="legalApproverName" value="${legalApproverName}" id="legalApproverName"  disabled />
							
							
								<div class="field-attachments popup-attachment">
									<sub>Attach Approval E-mail</sub>
									<#if attachmentMap?? && attachmentMap.get(tpdSummaryLegalApprovalID)?? >
										<div id="jive-file-list" class="attachmentsNew jive-attachments">
											<#list attachmentMap.get(tpdSummaryLegalApprovalID) as attachment>
												<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
													<span class="jive-icon-med jive-icon-attachment"></span>
													
													<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
													${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
												</div>
											</#list>
										</div>
									</#if>
								</div>
							
						</div>
					</div>
					
					<div class="form-select_div form-select_div_project_completion region-inner">
								
						<label>TPD Summary Date of Legal Approval</label>
						<div>
							
							<#if tpdSummary?? && tpdSummary.legalApprovalDate??>
							<input type="text"  name="legalApproverDatePit" value="${tpdSummary.legalApprovalDate?string('dd/MM/yyyy')}" id="legalApproverDatePit"  disabled />
							<#else>
								<input type="text"  name="legalApproverDatePit" value="" id="legalApproverDatePit"  disabled />
							</#if>
							
						</div>
					</div>
				</#if>
				<!--TPD SUMMARY LEGAL DETAILS END -->
				
				
				
				<#if proposalInitiation?? && proposalInitiation.legalSignOffRequired?? && proposalInitiation.legalSignOffRequired==1>
				<#else>
						<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId())>
						
							<#if isAdminUser || isSynchroSystemOwner>
								<div class="region-inner">
									<div class="form-select_div">
										<label>TPD Status</label>
										<#if proposalInitiation?? && proposalInitiation.legalApprovalStatus?? >
											<@renderLegalApprovalStatusFields name='legalApprovalStatusPitProposal' value="${proposalInitiation.legalApprovalStatus}" />
											 <span class="jive-error-message full-width" id="statusProposalError" style="display:none">Please select TPD Status</span>
										<#else>
											<@renderLegalApprovalStatusFields name='legalApprovalStatusPitProposal' value="-1" />
										</#if>
									</div>
								</div>
							<#else>
								<#if proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
									<span class="approval-status popTpd">TPD Status: <span class="status-txt">Pending</span></span>
								<#elseif proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus == 1)  >
									<span class="approval-status popTpd">TPD Status: <span class="status-txt">May have to be Submitted</span></span>
								<#elseif proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus==2)  >
									<span class="approval-status popTpd">TPD Status: <span class="status-txt">Does not have to be Submitted</span></span>
								</#if>
							</#if>
						</#if>
						
						
						<#if project.processType?? && project.processType !=  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() && project.processType !=  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId()>
							<div class="form-select_div form-select_div_project_completion region-inner">
								
								<label>Legal Approver's Name</label>
								<div>
									<#if (isAdminUser || isSynchroSystemOwner) && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
									<#--	<select data-placeholder="Select Legal Approver"  class="chosen-select" id = "proposalLegalApprover" name='proposalLegalApprover' >
										
											<option value=""></option>
											<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
											<#assign endMarketApproversKeySet = endMarketLegalApprovers.keySet() />
											<#list endMarketApproversKeySet as key>
												<optgroup label="${endMarkets.get(key?int)}">
													<#list endMarketLegalApprovers.get(key) as legalUser >
													<#if proposalInitiation?? && proposalInitiation.proposalLegalApprover?? && proposalInitiation.proposalLegalApprover == legalUser.ID>
														<option value="${legalUser.ID?c}" selected>${legalUser.name}</option>
													<#else>
														<option value="${legalUser.ID?c}">${legalUser.name}</option>
													</#if>
													</#list>
												</optgroup>
											</#list>
												
										</select>
										-->
										
										<#if proposalInitiation.getProposalLegalApproverOffline()??>
											<input type="text" placeholder="Select Legal Approver" name="proposalLegalApproverOffline"  value="${proposalInitiation.getProposalLegalApproverOffline()}"  />
										<#else>
											<input type="text" placeholder="Select Legal Approver" name="proposalLegalApproverOffline"  value=""  />
										</#if>	
										
										<span class="full-width  jive-error-message" id="proposalLegalApproverError" style="display:none">Please select Proposal Legal Approver</span>
									<#else>
										<#if project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId()>
											<#if proposalInitiation.getProposalLegalApproverOffline()??>
												<input type="text" placeholder="Select Legal Approver" name="proposalLegalApproverOffline" disabled value="${proposalInitiation.getProposalLegalApproverOffline()}"  />
											<#else>
												<input type="text" placeholder="Select Legal Approver" name="proposalLegalApproverOffline" disabled value=""  />
											</#if>
										<#else>

											<#if proposalInitiation?? && proposalInitiation.proposalLegalApprover??>
												<#assign legalApproverName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(proposalInitiation.proposalLegalApprover) />
											<#else>
												<#assign legalApproverName = '' />
											</#if>
											<input type="text"  name="legalApproverName" value="${legalApproverName}" id="legalApproverName"  disabled />
										</#if>	
										
									</#if>
									
									<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
										<div class="field-attachments popup-attachment">
											<#if (isAdminUser || isSynchroSystemOwner) && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
											<div id="attachApprovalMailDiv">	
												<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${proposalLegalApprovalID?c})" ></span>
											</div>
											</#if>
											<sub>Attach Approval E-mail</sub>
											<#if attachmentMap?? && attachmentMap.get(proposalLegalApprovalID)?? >
												<div id="jive-file-list" class="attachmentsNew jive-attachments">
													<#list attachmentMap.get(proposalLegalApprovalID) as attachment>
														<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
															<span class="jive-icon-med jive-icon-attachment"></span>
															
															
															<#if (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(proposalLegalApprovalID)?size == 1 >
																<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Proposal Approval');"><@s.text name="global.remove" /></a>	
															<#elseif (isAdminUser || isSynchroSystemOwner) || attachmentMap.get(proposalLegalApprovalID)?size gt 1 >
																<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${proposalLegalApprovalID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
															</#if>
															<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
															${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
														</div>
													</#list>
												</div>
											</#if>
										</div>
									</#if>
								</div>
							</div>
							
							<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
						
							 <div class="region-inner">
								<div class="form-select_div">
									<label>TPD Status</label>
									<#if isAdminUser || isSynchroSystemOwner>
										<#if proposalInitiation?? && proposalInitiation.legalApprovalStatus?? >
											<@renderLegalApprovalStatusFields name='legalApprovalStatusPitProposal' value="${proposalInitiation.legalApprovalStatus}"/>
										<#else>
											<@renderLegalApprovalStatusFields name='legalApprovalStatusPitProposal' value="-1"/>
										</#if>
									<#else>
										<#if proposalInitiation?? && proposalInitiation.legalApprovalStatus?? >
											<@renderLegalApprovalStatusFields name='legalApprovalStatusPit' value="${proposalInitiation.legalApprovalStatus}" readonly=true/>
										<#else>
											<@renderLegalApprovalStatusFields name='legalApprovalStatusPit' value="-1" readonly=true/>
										</#if>
									</#if>
									<span class="full-width  jive-error-message" id="proposalLegalApprovalStatusError" style="display:none">Please select TPD Status</span>
								</div>
							</div>
							
							
							<div class="form-select_div form-select_div_project_completion region-inner">
							
								<label>Date of Legal Approval</label>
								<div>
									<#if isAdminUser || isSynchroSystemOwner>
										<@synchrodatetimepicker id="legalApprovalDateProposal" name="legalApprovalDateProposal" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder='Enter Legal Approval Date'/>
									<#else>
										<#if proposalInitiation?? && proposalInitiation.legalApprovalDate??>
										<input type="text"  name="legalApproverDatePit" value="${proposalInitiation.legalApprovalDate?string('dd/MM/yyyy')}" id="legalApproverDatePit"  disabled />
										<#else>
											<input type="text"  name="legalApproverDatePit" value="" id="legalApproverDatePit"  disabled />
										</#if>
									</#if>
									
									
								</div>
							</div>
							
						</#if>
					</#if>
				</#if>

				<#if methProposalException == "yes">
					<#if proposalInitiation?? && proposalInitiation.legalSignOffRequired?? && proposalInitiation.legalSignOffRequired==1>
						<div id="legal-checkbox" class="region-inner"><input type="checkbox" name="legalsignoffreqdisable" disabled id="legalsignoffreqdisable" <#if proposalInitiation?? && proposalInitiation.legalSignOffRequired?? && proposalInitiation.legalSignOffRequired==1> checked="true"</#if> >This project does not require legal sign-off on Proposal.<br></div>
					</#if>
				
				</#if>

				<div class="region-inner">
					<label class="pit-description-label">Documentation</label>
				   
					  
						<div class="form-text_div">
						<#if isAdminUser || isSynchroSystemOwner>
							<textarea id="documentation" name="documentation" rows="10" cols="20" class="form-text-div">${projectSpecsInitiation.documentation?default('')?html}</textarea>
						<#else>
							<textarea id="documentation" name="documentation" disabled rows="10" cols="20" class="form-text-div">${projectSpecsInitiation.documentation?default('')?html}</textarea>
						</#if>	
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
					</div>
					<textarea style="display:none;" id="documentationText" name="documentationlText">${projectSpecsInitiation.documentationText?default('')?html}</textarea>
					 <!-- ATTACHMENT DISPLAY STARTS -->
						 <div class="field-attachments">
								<#if isAdminUser || isSynchroSystemOwner>
									<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${documentationID?c})" ></span> 
								</#if>
							
								<#if attachmentMap?? && attachmentMap.get(documentationID)?? >
									<div id="jive-file-list" class="jive-attachments">
										<#list attachmentMap.get(documentationID) as attachment>
											<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
												<span class="jive-icon-med jive-icon-attachment"></span>
												<#if (isAdminUser || isSynchroSystemOwner)>
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${documentationID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
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
				
				<!-- Report Summary Starts -->
				<div class="region-inner">
					<label class="pit-description-label">Project Reports</label>
				

					<#if isAdminUser || isSynchroSystemOwner>
					<div class="table project-reports pit_window_field_width border-inputradius">
						<div class="tr">
							<div class="th">Report Type</div>
							<div class="th">Legal Approval Provided By</div>
							<div class="th">Attached Report</div>
						</div>
						<#assign hasReportAttachment  = "yes" />
						<#assign hasIRISAttachment = "yes" />
						<#assign hasTPDAttachment = "yes" />
						
						<#if reportSummaryDetailsList?? && reportSummaryDetailsList?size gt 0 >
								<#assign reportTypeCounter = 0 />
								<#assign irisCounter = 0 />
								<#assign tpdCounter = 0 />
				
								<#list reportSummaryDetailsList as reportSummaryDetails>
									<#assign reportTypeLegalApproverName =""/>
									<#assign irisLegalApproverName =""/>
									<#assign tpdLegalApproverName =""/>
									
									<#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT.getId()>
										<#if reportSummaryDetails.getLegalApprover()??>
											<#assign reportTypeLegalApproverName = reportSummaryDetails.getLegalApprover()/>
										<#else>
											<#assign reportTypeLegalApproverName = ""/>
										</#if>
										<#assign reportTypeCounter =  reportTypeCounter + 1/>
									<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TOP_LINE_REPORT.getId()>
										<#assign reportTypeLegalApproverName = reportSummaryDetails.getLegalApprover()/>
										<#assign reportTypeCounter =  reportTypeCounter + 1/>
									<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].EXECUTIVE_PRESENTATION.getId()>
										<#assign reportTypeLegalApproverName = reportSummaryDetails.getLegalApprover()/>
										<#assign reportTypeCounter =  reportTypeCounter + 1/>
									<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT_BLANK.getId()>
										<#if reportSummaryDetails.getLegalApprover()??>
											<#assign reportTypeLegalApproverName = reportSummaryDetails.getLegalApprover()/>
										<#else>
											<#assign reportTypeLegalApproverName = ""/>
										</#if>
										<#assign reportTypeCounter =  reportTypeCounter + 1/>
									<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].IRIS_SUMMARY.getId()>
										<#if reportSummaryDetails.getLegalApprover()??>
											<#assign irisLegalApproverName = reportSummaryDetails.getLegalApprover()/>
										<#else>
											<#assign reportTypeLegalApproverName = ""/>
										</#if>	
										<#assign irisCounter =  irisCounter + 1/>
									<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TPD_SUMMARY.getId()>
										<#if reportSummaryDetails.getLegalApprover()??>
											<#assign tpdLegalApproverName = reportSummaryDetails.getLegalApprover()/>
										<#else>
											<#assign reportTypeLegalApproverName = ""/>
										</#if>	
										<#assign tpdCounter =  tpdCounter + 1/>
									</#if>
									
									<#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT.getId() || reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TOP_LINE_REPORT.getId() || reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].EXECUTIVE_PRESENTATION.getId() || reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT_BLANK.getId()>
									<div class="tr" id="mainReportTypeDiv">
										<#if  reportTypeCounter gt 1>
											<div class="td dynamic-row">
										<#else>
											<div class="td">
										</#if>
											<#if  reportTypeCounter gt 1>
												<select name="reportTypes" id="reportType" data-placeholder="Select Report Type" class="chosen-select form-select rt report-type-attach" >
											<#else>
												<input type="button" value="duplicate" class="duplicate add-icon" id="mainReportType">
												<select name="reportType" id="reportType" data-placeholder="Select Report Type" class="chosen-select form-select report-type-attach" >
												
											</#if>
											
											<option value=""></option>
											<option value="1" <#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT.getId()> selected </#if>>Full Report</option>
											<option value="2" <#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TOP_LINE_REPORT.getId()> selected </#if>>Top Line Report</option>
											<option value="3" <#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].EXECUTIVE_PRESENTATION.getId()> selected </#if>>Executive Presentation</option>
											
											</select>
											<span class="jive-error-message full-width" id="reportTyperError" style="display:none">Please Select Report Type</span>
										</div>
									
										<div class="td" id="legalApproverDiv">
											<#if  reportTypeCounter gt 1>
												<input type="text" name="reportTypeLegalApprovers" id="reportTypeLegalApprover" placeholder="Add Legal Approver Name" value="${reportTypeLegalApproverName}" />
											<#else>
												<input type="text" name="reportTypeLegalApprover" id="reportTypeLegalApprover" placeholder="Add Legal Approver Name" value="${reportTypeLegalApproverName}" />
												<span class="jive-error-message full-width" id="reportTypeLegalApproverError" style="display:none">Please Enter Legal Approver</span>
											</#if>
											
										</div>
											<div class="td" id="attachmentDiv"><span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupNewReport(${fullReportID?c},this,${reportSummaryDetails.getReportOrderId()})" ></span>
											<#if reportTypeCounter gt 1>
													<input type="button" value="Remove" class="removeRS" id="removeLink">
												<#else>
													
												</#if>
												<#assign attachIds =""	/>
												<#if attachmentMap?? && attachmentMap.get(fullReportID)?? >
													<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
													<div id="jive-file-list" class="jive-attachments">
													
												
														<#list attachmentMap.get(fullReportID) as attachment>
															<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
															<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
																<span class="jive-icon-med jive-icon-attachment"></span>
																<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser || isSynchroSystemOwner) >
																															
																	<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${fullReportID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
																</#if>
																<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
																${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
															<#--	<#assign hasReportAttachment  = "yes" />-->
																
																<#assign attachIds = attachIds+","+attachment.ID?c />
							
															</div>
															</#if>
															
														</#list>
														
														
													</div>
												</#if>
												
												<#if attachIds!="">
												<#else>
													<#assign hasReportAttachment  = "no" />
												</#if>	
											<#if  reportTypeCounter gt 1>
												<input type="hidden" name="reportTypeAttachments" id="reportTypeAttachment" value="${attachIds}" />
											<#else>
												<input type="hidden" name="reportTypeAttachment" id="reportTypeAttachment" value="${attachIds}" />
											</#if>
												
												</#if>
												
												
										
											</div>
										</div>
									</#if>
									
									<#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].IRIS_SUMMARY.getId()>
								
								<div class="tr" id="mainIrisSummaryTypeDiv">
									
									<#if  irisCounter gt 1>
										<div class="td dynamic-row"><div class="iris_summery_box_align">IRIS Summary</div></div>
									
										<div class="td"><input type="text" name="irisSummaryLegalApprovers" id="irisSummaryLegalApprover" placeholder="Add Legal Approver Name" value="${irisLegalApproverName}" /></div>
									<#else>
										<div class="td"><input type="button" value="duplicate" class="duplicate add-icon" id="mainIrisSummaryType"><div class="iris_summery_box_align">IRIS Summary</div><div class="download-link-wrapper"><div class="standard-report-download-link" >
				
											
										 </div></div></div>
										
											<div class="td">
											<input type="text" name="irisSummaryLegalApprover" id="irisSummaryLegalApprover" placeholder="Add Legal Approver Name" value="${irisLegalApproverName}" />
											<span class="jive-error-message full-width" id="irisSummaryLegalApproverError" style="display:none">Please Enter Legal Approver</span>
											</div>
									</#if>
									<#assign irisAttachIds =""	/>
									<div class="td"><span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupNew(${irisSummaryReportID?c},${reportSummaryDetails.getReportType()},${reportSummaryDetails.getReportOrderId()})" ></span>
										
										<#if irisCounter gt 1>
											<input type="button" value="Remove" class="removeRS" id="removeLink">
										<#else>
										
										</#if> 
										<#if attachmentMap?? && attachmentMap.get(irisSummaryReportID)?? >
											<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
											<div id="jive-file-list" class="jive-attachments">
											
											
												<#list attachmentMap.get(irisSummaryReportID) as attachment>
													<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
													<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
														<span class="jive-icon-med jive-icon-attachment"></span>
														<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser || isSynchroSystemOwner) >
															<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${irisSummaryReportID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
														</#if>
														<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
														${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
														
														<#assign irisAttachIds = irisAttachIds+","+attachment.ID?c />
														
														<#--<#assign hasIRISAttachment = "yes" />-->

													</div>
													</#if>
												</#list>
											</div>
											</#if>
										</#if>
										
										<#if irisAttachIds!="">
											<#else>
												<#assign hasIRISAttachment  = "no" />
										</#if>	

										<#if  irisCounter gt 1>
											<input type="hidden" name="irisAttachments" id="irisAttachment" value="${irisAttachIds}" />
										<#else>
											<input type="hidden" name="irisAttachment" id="irisAttachment" value="${irisAttachIds}" />
										</#if>
												
									
										
										
									</div>
								</div>
								</#if>
								
								<#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TPD_SUMMARY.getId()>
								<div class="tr" id="mainTPDSummaryTypeDiv">
									
									<#if tpdCounter gt 1>
										<div class="td dynamic-row"><div class="iris_summery_box_align">TPD Summary</div></div>
										<div class="td"><input type="text" name="tpdSummaryLegalApprovers" id="tpdSummaryLegalApprover" placeholder="Add Legal Approver Name" value="${tpdLegalApproverName}" />
									<#else>
										<div class="td"><input type="button" value="duplicate" class="duplicate add-icon" id="mainTPDSummaryType"><div class="iris_summery_box_align">TPD Summary</div></div>
										<div class="td"><input type="text" name="tpdSummaryLegalApprover" id="tpdSummaryLegalApprover" placeholder="Add Legal Approver Name" value="${tpdLegalApproverName}" />
										<span class="jive-error-message full-width" id="tpdSummaryLegalApproverError" style="display:none">Please Enter Legal Approver</span>
									</#if>	
									<div class="reports-tpd-summary">
									
									<#assign tdpAttachIds =""	/>
									
									<#if tpdCounter gt 1 >
										
										<@synchrodatetimepicker id="tpdSummaryDate_${tpdCounter}" name="tpdSummaryDates" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder="Enter Date of Legal Approval" tpdDate=true/>
										<#if reportSummaryDetails.getLegalApprovalDate()??>
											<script type="text/javascript">
											var _tpdSummaryDate = "${reportSummaryDetails.getLegalApprovalDate()?string('dd/MM/yyyy')}";
											$j("#tpdSummaryDate_${tpdCounter}").val(_tpdSummaryDate);
											</script>
										</#if>
										
									<#else>
										<@synchrodatetimepicker id="tpdSummaryDate" name="tpdSummaryDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder="Enter Date of Legal Approval" tpdDate=true/>
								
										<#if reportSummaryDetails.getLegalApprovalDate()??>
										<script type="text/javascript">
										var _tpdSummaryDate = "${reportSummaryDetails.getLegalApprovalDate()?string('dd/MM/yyyy')}";
										$j("#tpdSummaryDate").val(_tpdSummaryDate);
										</script>
										</#if>
							
									</#if>
									<span class="jive-error-message full-width" id="tpdSummaryDateError" style="display:none">Please Enter Legal Approver Date</span>
									
									</div>
									</div>
									<div class="td"><span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupNew(${tpdSummaryReportID?c},${reportSummaryDetails.getReportType()},${reportSummaryDetails.getReportOrderId()})" ></span>
									<#if tpdCounter gt 1>
										<input type="button" value="Remove" class="removeRS" id="removeLink">
									<#else>
										
									</#if>
									<#if attachmentMap?? && attachmentMap.get(tpdSummaryReportID)?? >
										<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
										<div id="jive-file-list" class="jive-attachments">
										
										
											<#list attachmentMap.get(tpdSummaryReportID) as attachment>
												<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
												<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
													<span class="jive-icon-med jive-icon-attachment"></span>
													<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser || isSynchroSystemOwner) >
														<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${tpdSummaryReportID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
													</#if>
													<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
													${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
													
							
												<#--	<#assign hasTPDAttachment = "yes" />-->
													
													<#assign tdpAttachIds = tdpAttachIds+","+attachment.ID?c />
												</div>
												</#if>
												
											</#list>
										</div>
										</#if>
									</#if>
									
									<#if tdpAttachIds!="">
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
								</#list>
								
								<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
									<div class="tr" id="mainTPDSummaryTypeDiv" style="display:none"></div>
									
								<#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId()) && proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus == 1)>
								
								<#else>
									<div class="tr" id="mainTPDSummaryTypeDiv" style="display:none"></div>
								
								</#if>
						</#if>
					</div>
					
					<#else>	
						<div class="table pit_window_field_width border-inputradius">
						<div class="tr">
							<div class="th">Report Type</div>
							<div class="th">Legal Approval Provided By</div>
							<div class="th">Attached Report</div>
						</div>
						
						
						
						
						
						<#if reportSummaryDetailsList?? && reportSummaryDetailsList?size gt 0 >
						<#list reportSummaryDetailsList as reportSummaryDetails>
							
							<#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT.getId()>
							<div class="tr">
							<div class="td"><div class="disabled-box">Full Report</div></div>
							<div class="td"><div class="disabled-box">${reportSummaryDetails.getLegalApprover()}</div></div>
							
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
							<div class="td"><div class="disabled-box">Top Line Report</div></div>
							<div class="td"><div class="disabled-box">${reportSummaryDetails.getLegalApprover()}</div></div>
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
							<div class="td"><div class="disabled-box">Executive Presentation</div></div>
							<div class="td"><div class="disabled-box">${reportSummaryDetails.getLegalApprover()}</div></div>
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
							<div class="td"><div class="disabled-box"></div></div>
							<div class="td"><div class="disabled-box">${reportSummaryDetails.getLegalApprover()}</div></div>
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
							<div class="td"><div class="disabled-box">IRIS Summary</div></div>
							<div class="td"><div class="disabled-box"><#if reportSummaryDetails.getLegalApprover()??>${reportSummaryDetails.getLegalApprover()}</#if></div></div>
							
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
							<div class="td"><div class="disabled-box">TPD Summary</div></div>
							<div class="td"><div class="disabled-box"><#if reportSummaryDetails.getLegalApprover()??>${reportSummaryDetails.getLegalApprover()}</#if></div>
							<#if reportSummaryDetails.getLegalApprovalDate()??>
								<div class="disabled-box">${reportSummaryDetails.getLegalApprovalDate()?string('dd/MM/yyyy')}</div>
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
				</#if>	
				
				
				<#if methRepSummaryException == "yes">
		
					<div id="legal-checkbox" class="region-inner"><input type="checkbox" name="legalsignoffreqdisable" disabled id="legalsignoffreqdisable" <#if reportSummaryInitiation?? && reportSummaryInitiation.legalSignOffRequired?? && reportSummaryInitiation.legalSignOffRequired==1> checked="true"</#if> >This project does not require Report/IRIS Summary.<br></div>
				</#if>
				
				</div>
				<!-- Report Summary Ends -->
				
				<!--Project Evaluation Starts -->
				
				<#if isAdminUser || isSynchroSystemOwner>
				
					<div class="region-inner">
					<label class="pit-description-label">Project Evaluation</label>
					<#if initiationList?? && initiationList?size gt 0>
					<div class="border-box project-eval-container border-inputradius">
					<#assign projectEvalCounter = 0 />
					
					<#list initiationList as projEvaluation>
						<div class="form-text_div project-eval-div">
						<div class="col-md-5">
						<div class="boxinnerContainer">

						<#if uniqueAgencyId?? && uniqueAgencyId?size gt 0 >
							<#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getResearchAgency() />
							
							<#if !statics['com.grail.synchro.util.SynchroPermHelper'].isActiveResearchAgency(projectID)>
								<#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getAllResearchAgency() />
							</#if>
							
							<#if projectEvalCounter gt 0>
								<select name="project-eval-agencies" id="eval-agency" data-placeholder="Select Agency" class="chosen-select form-select agency-select" >
							<#else>
								<select name="project-eval-agency" id="eval-agency" data-placeholder="Select Agency" class="chosen-select form-select agency-select" >
							</#if>
								<option value=""></option>
								
								<#list uniqueAgencyId as agencyId>
									<option value="${agencyId}" <#if projEvaluation.getAgencyId()==agencyId> selected</#if>>${researchAgencies.get(agencyId?int)}</option>
								</#list>
							</select>
							<span class="jive-error-message full-width" id="evalAgencyError" style="display:none">Please Select Agency</span>
						</#if>
						</div>
						<div class="boxinnerContainer">
						<#if projectEvalCounter gt 0>
							<select name="ratings" id="rating" data-placeholder="Select Rating" class="chosen-select form-select" >
						<#else>
							<select name="rating" id="rating" data-placeholder="Select Rating" class="chosen-select form-select" >
						</#if>
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
							<#if projectEvalCounter gt 0>
								<#if projEvaluation.getAgencyComments()?? >
									<textarea id="comment" name="comments"  rows="5" cols="20" placeholder="Comments" class="form-text-div">${projEvaluation.getAgencyComments()}</textarea>
								<#else>	
									<textarea id="comment" name="comments"  rows="5" cols="20" placeholder="Comments" class="form-text-div"></textarea>
								</#if>
							<#else>
								<#if projEvaluation.getAgencyComments()?? >
									<textarea id="comment" name="comment"  rows="5" cols="20" placeholder="Comments" class="form-text-div">${projEvaluation.getAgencyComments()}</textarea>
								<#else>
									<textarea id="comment" name="comment"  rows="5" cols="20" placeholder="Comments" class="form-text-div"></textarea>
								</#if>
							</#if>
							<span class="jive-error-message full-width" id="commentError" style="display:none">Please Enter Comment</span>	
						</div>
						</div>
						<#assign projectEvalCounter = projectEvalCounter + 1 />
					</#list>
					</div>
					</#if>
					
				<#else>
				
					<div class="region-inner">
						<label class="pit-description-label">Project Evaluation</label>
						<#if initiationList?? && initiationList?size gt 0>
						<div class="border-box project-eval-container border-inputradius">
						<#list initiationList as projEvaluation>
							<div class="form-text_div project-eval-div border-inputradius">
						<div class="col-md-5">
<div class="boxinnerContainer">
							<#if projectCostDetailsList?? && projectCostDetailsList?size gt 0 >
								<#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getResearchAgency() />
								<#if !statics['com.grail.synchro.util.SynchroPermHelper'].isActiveResearchAgency(projectID)>
									<#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getAllResearchAgency() />
								</#if>
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
						</#if>
						</div>
					</#if>
				
				
				<!--Project Evaluation Ends -->
            
            <div class="pib_band_view">
				 <#if isAdminUser || isSynchroSystemOwner>
					<div >
						<#if isAdminUser &&  project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId())>
								<a href="javascript:void(0);" onclick="return resetPIB();" class="popup-reset">Reset Brief</a>
								<a href="javascript:void(0);" onclick="return resetProposal();" class="popup-reset">Reset Proposal</a>
						
						</#if>
						<input class="j-btn-callout" type="button" name="doPost" id="postButton" onclick="return validatePITFields();" value="Save" style="font-weight: bold;" />
					</div>
				</#if>
               
            </div>
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" name="endMarketId" value="${endMarketId?c}">
			</div>
			</div>
        </form>
    </div>
</div>


</div>


</div>


<form method="POST" name="cancelProj" id="cancelProj" action="/new-synchro/project-close!cancelProject.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
</form>

<form method="POST" name="enableProj" id="enableProj" action="/new-synchro/project-close!enableProject.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
</form>

</div>
  <script type="text/javascript">
     $j(document).ready(function() {
        $j('.chosen-select').chosen();
        $j('.chosen-select-deselect').chosen({ allow_single_deselect: true });
		$j('.chosen-select').chosen({ allow_single_deselect: true });
	var popupTrue = localStorage.getItem("popupTrue");
		  if(popupTrue){
		   $j('#initiateKantarWaiverButton a').trigger('click');
		  }
		  $j('#initiateKantarWaiver .close').click(function(){
			   localStorage.removeItem("popupTrue");
		  });
		  $j('#initiateKantarWaiver .jive-icon-attachment').click(function(){
			  popupTrue = "true";
		   localStorage.setItem("popupTrue", popupTrue);
		  });
		  $j('#initiateKantarWaiver  #jive-file-list .j-remove-file').click(function(){
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

	<#if projectInitiation?? && projectInitiation.legalApprovalDate?? >		
		var _legalApprovalDateBrief = "${projectInitiation.legalApprovalDate?string('dd/MM/yyyy')}";
		$j("#legalApprovalDateBrief").val(_legalApprovalDateBrief);
	</#if>
	
	<#if proposalInitiation?? && proposalInitiation.legalApprovalDate?? >		
		var _legalApprovalDateProposal = "${proposalInitiation.legalApprovalDate?string('dd/MM/yyyy')}";
		$j("#legalApprovalDateProposal").val(_legalApprovalDateProposal);
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
		
		<#if attachmentMap?? && attachmentMap.get(agencyWaiverID)?? >
	    <#else>
		
		 $j("#waiverAttachmentError").show();
         return false;
	   </#if>
		
		
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
	var error = false;
	/*Project Start and End Dates check*/
		var startDate = $j("input[name=startDate1]");
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


		var endDate = $j("input[name=endDate1]");
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
			startDate.parent().parent().find("span").text("Project Start date should be less than end date");
			error = true;
		}
		/*Project Start and End Dates check ends*/
		
		var categoryType = $j("#categoryType");
	if(categoryType.val() != null)
	{
	}
	else
	{
		$j("#categoryTypeErrors").show();
		$j(document).scrollTop(200);
		error = true;
	}
	
	var projectManagerName = $j("input[name=projectManagerName]");
    if(projectManagerName.val() != null && $j.trim(projectManagerName.val())=="")
    {
        projectManagerName.parent().find("span").show();
       // projectManagerName.focus();
        error = true;
    }
	
	var methodologyDetails = $j("#methodologyDetails");
	
	if(methodologyDetails.val() != null && methodologyDetails.val()!="")
	{
	}
	else
	{
		$j("#methodologyDetails").parent().find("span").show();
	     $j("#methodologyDetails").focus();
        error = true;
	}
	var methodologyType = $j('select[name="methodologyType"] option:selected').val();
	
    if(methodologyType < 1)
    {
   		$j("#methodologyType").parent().find("span").show();
	     $j("#methodologyType").focus();
        error = true;
    }
	else if(methodologyType==undefined)
	{
		$j("#methodologyType").parent().find("span").show();
	     $j("#methodologyType").focus();
        error = true;
	}
	
	var methWaiverReq = $j('select[name="methWaiverReq"] option:selected').val();
	
    if(methWaiverReq < 1)
    {
        
		$j("#methWaiverReq").parent().find("span").show();
	     $j("#methWaiverReq").focus();
        error = true;
    }
	var brandSpecificStudy = $j('select[name="brandSpecificStudy"] option:selected').val();
	
    if(brandSpecificStudy < 1)
    {
        
		$j("#brandSpecificStudyError").show();
        error = true;
    }
	else if (brandSpecificStudy==undefined)
	{
		$j("#brandSpecificStudyError").show();
        error = true;
	}
	
	var brandSpecificStudyType = $j('select[name="brandSpecificStudyType"] option:selected').val();

	//536
	 var MultibrandText = $j("input[name=multiBrandStudyText]").val();
	 if(brandSpecificStudy==2 && brandSpecificStudyType==1 && MultibrandText=="")
	 {
	 $j("#MultibrandTextError").show();	 
	 error=true;
	 }
	
    if(brandSpecificStudy=="2" && (brandSpecificStudyType < 1 || brandSpecificStudyType==undefined))
    {
        
		$j("#brandSpecificStudyTypeError").show();
        error = true;
    }
	var brand = $j('select[name="brand"] option:selected').val();
    
	if(brandSpecificStudy=="1" && (brand < 1 || brand==undefined))
    {
        
		$j("#brandError").show();
        error = true;
    }
	
	var budgetLocation = $j("#budgetLocation");
	if(budgetLocation.val() == null)
	{
		$j("#budgetLocationError").show();
		error = true;
	}
	else if(budgetLocation.val()=="")
	{
		$j("#budgetLocationError").show();
		error = true;
	}
	
	var budgetYear = $j('select[name="budgetYear"] option:selected').val();

    if(budgetYear < 1)
    {
    	 $j("#budgetYearError").show();
        error = true;
    }
	
	var endMarkets = $j("#endMarkets").val();
	if(endMarkets == null)
	{
		$j("#endMarketError").show();
		 error = true;
	}
	if(endMarkets != null && $j.trim(endMarkets)=="")
	{
		$j("#endMarketError").show();
		 error = true;
	}
	
	<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
		var briefLegalApprover = $j("#briefLegalApprover");
		if(briefLegalApprover.val() != null && $j.trim(briefLegalApprover.val())=="")
		{
			$j("#briefLegalApproverError").show();
			error = true;
		}
		
		var legalApprovalStatusPitBrief = $j("#legalApprovalStatusPitBrief");
		if(legalApprovalStatusPitBrief.val() != null && $j.trim(legalApprovalStatusPitBrief.val())=="")
		{
			$j("#briefLegalApprovalStatusError").show();
			error = true;
		}
		
		var proposalLegalApprover = $j("#proposalLegalApprover");
		if(proposalLegalApprover.val() != null && $j.trim(proposalLegalApprover.val())=="")
		{
			$j("#proposalLegalApproverError").show();
			error = true;
		}
		
		var legalApprovalStatusPitProposal = $j("#legalApprovalStatusPitProposal");
		if(legalApprovalStatusPitProposal.val() != null && $j.trim(legalApprovalStatusPitProposal.val())=="")
		{
			$j("#proposalLegalApprovalStatusError").show();
			error = true;
		}
		
	</#if>	

	
			//amit change	
var endMarketFunding = $j('select[name="endMarketFunding"] option:selected').val();
if(endMarketFunding==1)
	{
	var k= $j('select[name="fundingMarkets"] option:selected').text();
	
	
      if(k=="")
       {
		   
           $j(".fundingMarketsError").parent().find("span").show();
		   error = true;
       }
    }
    if(validateProjectCostDetails())
	{
		if(error)
		{
			hideLoader();
			return false;
		}
		else
		{
			var pitForm = jQuery("#synchro-pit-form");
			pitForm.submit();
		}
	}

	else
	{
		hideLoader();
		return false;
	}
    
  
	


}


//change 536
 $j("input[name=multiBrandStudyText]").change(function()
 {
	var MultibrandText = $j("input[name=multiBrandStudyText]"); 
	
	 if(MultibrandText.val()!="")
	 {
		 $j("#MultibrandTextError").hide();
		 
	 }
 });
 
//change  473
    $j("#methodologyDetails").change(function() {
			
			var methodogyDetails = $j("#methodologyDetails").val();
			
			var pibdetailvaluevalue=$j("#methodologyDetails option:selected").text();
           
              // change 473
              if(pibdetailvaluevalue!=null && pibdetailvaluevalue!="")
               {
                $j("#methodologyDetailsError").hide();
                }
      var methodologyType1 = $j("#methodologyType").val();
     
          if(methodologyType1=="" || methodologyType1==undefined )
               {
                $j("#methodologyType").parent().find("span.jive-error-message").hide();
                }




         	  if(pibdetailvaluevalue.length>20)
			  {
				$j("#methodologyDetails_chosen").attr("title",pibdetailvaluevalue);
			  }
			else
			 {
			   $j("#methodologyDetails_chosen").attr("title","");
			 }
			
			
			
            
			var element = $j(this).find('option:selected'); 
			
			var lessFrequent = element.attr("lessFrequent");
			var methName = $j("#methodologyDetails option:selected" ).text();
			
			$j('#brand').val('').trigger('chosen:updated');	
			
			$j('select[name="brandSpecificStudyType"]').val('').trigger('chosen:updated');
			
          /*Logic for autopopulating of MethodologType and other fields Starts*/
		 
		  if($j.trim(methodogyDetails).indexOf(",")>-1)
		  {
				$j('#methodologyType').val('').trigger('chosen:updated');
				$j('#brandSpecificStudy').val('').trigger('chosen:updated');
				$j('#brand').val('').trigger('chosen:updated');	
				
				$j("#brandSpecificStudyType").hide(); 
			    $j("#brandSpecific").hide();	
				// change  536				
				$j("#MultibrandTextDiv").hide();
				$j("#MultibrandTextError").hide();
		  }
		  else
		  {
			  FieldMappingUtil.getMethodologyTypeByMethodology(parseInt(methodogyDetails), {
					callback: function(result) {
		
					  if(result > -1)
					  {
						  $j('#methodologyType').val(result).trigger('chosen:updated');
                             
					  }
					  else
					  {
						 
						  $j('#methodologyType').val('').trigger('chosen:updated');
						  $j('#brandSpecificStudy').val('').trigger('chosen:updated');
						  $j('#brand').val('').trigger('chosen:updated');	
						  $j("#brandSpecificStudyType").hide();
						  $j("#brandSpecific").hide();	
					  }
					},
					async: false,
					timeout: 20000
				});
				var brandSpecific = element.attr("brandSpecific");
				
				if(brandSpecific=="1")
				{
					$j('#brandSpecificStudy').val('1').trigger('chosen:updated');
					 $j("#brandSpecific").show();
					$j("#brandSpecificStudyType").hide();
                     $j("#brandSpecificStudyError").hide();  // 473
				}
				else if(brandSpecific=="2")
				{
					$j('#brandSpecificStudy').val('2').trigger('chosen:updated');
					$j("#brandSpecificStudyType").show();
					$j("#brandSpecific").hide();
                    $j("#brandSpecificStudyError").hide();  // 473
				}
					// change 536
				$j("#MultibrandTextDiv").hide();
				$j("#MultibrandTextError").hide();
		  }
		
		
		  /*Logic for autopopulating of MethodologType and other fields Ends*/
		  
		});



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
				/* lightbox new */
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
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].ADD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_CLOSE.getId()}, "${kantarBtnClickText}", projName, ${projectID?c}, ${user.ID?c});
	</#if>
}

/* Initialization of Editor */
$j(document).ready(function () {
    
	//initiateRTE('documentation', 1500, true);
	
});

</script>

<script type="text/javascript">

	<#-- <#assign i18CustomText><@s.text name="logger.project.close.view.text" /></#assign>	-->
	<#assign i18CustomText>View Close</#assign>
	var projName = "${project.name?js_string}";	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_CLOSE.getId()}, "${i18CustomText}", projName, ${projectID?c}, ${user.ID?c});
</script>

<script src="${themePath}/js/synchro/project-cost-details.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script> 
  <script type="text/javascript">
  
	
	
	
	
  
  
   //change  473
  $j("#brandSpecificStudy").change(function() {
			
			 var brandSpecificStudy = $j('select[name="brandSpecificStudy"] option:selected').val();
			   // change 536
			  var brandSpecificStudyType= $j('select[name="brandSpecificStudyType"] option:selected').val();
			  
			 
			  
			  if(brandSpecificStudyType==1)
				   {
					   $j("#MultibrandTextDiv").show();
					   
				   }
			 if(brandSpecificStudy=="2")
			 {
				$j("#brandSpecificStudyType").show();
                 $j("#brandSpecificStudyError").hide();
				$j("#brandSpecific").hide();
				 if(brandSpecificStudyType=="1")
				   {
					   $j("#MultibrandTextDiv").show();
					   
				   }
			 }
			 if(brandSpecificStudy=="1")
			 {
				  $j("#brandSpecific").show();
				  $j("#brandSpecificStudyType").hide();
                 $j("#brandSpecificStudyError").hide();
				 $j("#MultibrandTextDiv").hide();
			 }
			  if(brandSpecificStudy=="-1")
				 {
					  $j("#brandSpecific").hide();
					  $j("#brandSpecificStudyType").hide();
					   $j("#MultibrandTextDiv").hide();  // change 536
					  $j("#MultibrandTextError").hide();
				 }
			
	});
	var endMarketO = $j('select[name="endMarkets"] option:selected').val();
	var endMarketText = $j('select[name="endMarkets"] option:selected').text();
	
	<#if (isAdminUser || isSynchroSystemOwner)  && project.projectType?? && project.projectType==3>
	<#elseif (isAdminUser || isSynchroSystemOwner)>
	<#else>
		$j("select[name='endMarkets']").change(function() {
				dialog({
						title:"",
						html:"<p>You are trying to change 'Research End Market'. This cannot be updated!</p><p>You need to cancel the project and setup it up as a new project on SynchrO with the correct information.</p>",
						buttons:{
						"OK":function() {
						
							$j('select[name="endMarkets"]').val(endMarketO);
						$j('#endMarkets_chosen span').text(endMarketText);
							
							endMarketO=endMarketO;
							endMarketText = endMarketText;		
							
							$j('select[name="endMarkets"]').val(endMarketO).trigger('chosen:updated');
							
							
							
							
							
							return false;		
						}
					},

					});
					 orangeBtn();
				//$j('select[name="endMarkets"] select').val(endMarket);
				//$j('#endMarkets_chosen span').text(endMarketText);
				
		});
	</#if>	
	
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
				 orangeBtn();
			
	});
	
	function cancelProject()
  {
	
	{
		dialog({
					title:"",
					html:'<i class="warningErr positionSet"></i><p>Once you cancel the project, it will no longer be accessible.</p><p>Are you sure you want to cancel the project?</p>',
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
  
   function enableProject()
  {
	
	{
		dialog({
					title:"",
					html:"<i class='warningErr positionSet'></i><p>Are you sure you want to enable the project?</p>",
					buttons:{
					"YES":function() {
						var enableProjForm = jQuery("#enableProj");
						enableProjForm.submit();
					},
					"NO": function() {
						return false;
					}
				},

				});
				relPos();
				
	}
	
	
  }

	$j(document).ready(function() {
		 var brandSpecificStudy = $j('select[name="brandSpecificStudy"] option:selected').val();
		 if(brandSpecificStudy=="2")
		 {
			$j("#brandSpecificStudyType").show();
			if($j('select[name="brandSpecificStudyType"] option:selected').val()=="1")
            {
                $j("#MultibrandTextDiv").show();
            }
			$j("#brandSpecific").hide();
		 }
		 if(brandSpecificStudy=="1")
		 {
			  $j("#brandSpecific").show();
			  $j("#brandSpecificStudyType").hide();
		 }
	});
	
		
	

	
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
	
	function dateCompare()
	{
		
		var legalApprovalDate = $j("#legalApprovalDate").val();
		var legalApproverDatePit = $j("#legalApproverDatePit").val();
		if(!compareDate(legalApproverDatePit, legalApprovalDate))
		{
		  
		 dialog({
				title:"",
				html:"<p>Please check the date you have selected.</p><p> Proposal Legal Approved Date cannot be prior to the date of approval on Brief.</p>",
				buttons:{
				"OK":function() {
					$j("#legalApprovalDate").val('');
					return false;		
				}
			},

			});
			orangeBtn();
		   error = true;
		}
	}	
	function dateCompareStart()
	{
		var endDate = $j("#endDate").val();
		var startDate = $j("#startDate").val();
		if(endDate!=null && endDate!=undefined && endDate!="")
		{
			if(!compareDate(startDate, endDate))
			{
			  
			 dialog({
					title:"",
					html:"<i class='warningErr'></i><p>Please check the date you have selected.</p><p>Project end date cannot be prior to the Project Start.</p>",
					buttons:{
					"OK":function() {
						$j("#startDate").val('');
						return false;		
					}
				},

				});
				orangeBtn();
			   error = true;
			}
		}	
	}
	function dateCompareEnd()
	{
		var endDate = $j("#endDate").val();
		var startDate = $j("#startDate").val();
		
		if(startDate!=null && startDate!=undefined && startDate!="")
		{
			if(!compareDate(startDate, endDate))
			{
			  
			 dialog({
					title:"",
					html:"<i class='warningErr'></i><p>Please check the date you have selected.</p><p>Project end date cannot be prior to the Project Start.</p>",
					buttons:{
					"OK":function() {
						$j("#endDate").val('');
						return false;		
					}
				},

				});
				orangeBtn();
			   error = true;
			}
		}
	}
	
	function dateCompareStartPIT()
	{
		var endDate = $j("#endDate1").val();
		var startDate = $j("#startDate1").val();
		if(endDate!=null && endDate!=undefined && endDate!="")
		{
			if(!compareDate(startDate, endDate))
			{
			  
			 dialog({
					title:"",
					html:"<i class='warningErr'></i><p>Please check the date you have selected.</p><p>Project end date cannot be prior to the Project Start.</p>",
					buttons:{
					"OK":function() {
						$j("#startDate1").val('');
						return false;		
					}
				},

				});
				orangeBtn();
			   error = true;
			}
		}	
	}
	
	
	
	
	$j('body').click(function() {
      var endDate = $j("#endDate1").val();
	       if(endDate==null ||endDate=="")
		     {
			 }
			 else
			 {
			  
			  setTimeout(function(){
		 
		  if($j('body').find(".calendar").length==0)
		     {
			 dateCompareEndPIT();
			 
			 }
			 else
			 {}
		  
		  
		  }, 100);
        }
	});
	
	
	
	 function  dateCompareEndPITVisibiliity()
	   {
	     setTimeout(function(){
		 
		  if($j('body').find(".calendar").length==0)
		     {
			dateCompareEndPIT();
			 
			 }
			 else
			 {}	  
		  }, 100);
	   }
	
	
	
	
	function dateCompareEndPIT()
	{
		var endDate = $j("#endDate1").val();
		var startDate = $j("#startDate1").val();
		
		if(startDate!=null && startDate!=undefined && startDate!="")
		{
			if(!compareDate(startDate, endDate))
			{
			  
			 dialog({
					title:"",
					html:"<i class='warningErr'></i><p>Please check the date you have selected.</p><p>Project end date cannot be prior to the Project Start.</p>",
					buttons:{
					"OK":function() {
						$j("#endDate1").val('');
						return false;		
					}
				},

				});
				orangeBtn();
			   error = true;
			}
			else
			{
			   $j("#endDate1").parent().parent().find("span").hide();
			}
			
			
		}
	}
	 function resetProposal()
  {
	dialog({
			title:"",
			html:"<i class='warningErr positionSet'></i><p>Are you sure you want to reset the Proposal?</p>",
			buttons:{
			"YES":function() {
				var resetProposalForm = jQuery("#resetProposalForm");
				resetProposalForm.submit();
			},
			"NO": function() {
				return false;
			}
		},

		});
		relPos();
  
  }
  
  function resetPIB()
  {
	dialog({
			title:"",
			html:"<i class='warningErr positionSet'></i><p>Are you sure you want to reset the Brief?</p>",
			buttons:{
			"YES":function() {
				var resetPIBForm = jQuery("#resetPIBForm");
				resetPIBForm.submit();
			},
			"NO": function() {
				return false;
			}
		},

		});
		relPos();
  
  }
  
  
  var methWaiverUrl = window.location.href;
	if(methWaiverUrl.indexOf("methWaiver") > 0)
	{
		openInitiateWaiverWindow();
	}
	
	var agencyWaiverUrl = window.location.href;
	if(agencyWaiverUrl.indexOf("agencyWaiver") > 0)
	{
		showInitiateKantarWaiverWindow();
	}
	$j("#endMarketFunding").change(function() {
			
			var endMarketFunding = $j('#endMarketFunding').val();
			if(endMarketFunding=="1")
			{
				$j("#fundingMarketsDiv").show();
			}
			else
			{
				$j("#fundingMarketsDiv").hide();
			}
		});	
	<!-- Changes for Report Summary Start -->
	
	var mainReportTypecounter = 1;
	var tpdReportTypecounter = 1;
	
	$j("#mainReportType").bind("click", function () {
		var value = $j(this).val();
		
		mainReportTypecounter++;
		
		var div = $j("<div class='tr'/>");
		 div.html(addMainReportType(""));
		$j("#mainIrisSummaryTypeDiv").before(div);
	    $j('.new-report-type').chosen();
		
		div.find('.new-report-type').val('').trigger('chosen:updated');
		
		// This is done as part of http://redmine.nvish.com/redmine/issues/509
		
		var legalSignOffRequired=$j("#legalsignoffreq").prop("checked");
		if(legalSignOffRequired)
		{	
			enableProjectEvaluationCheckBox('no');
		}
	
		
		  });
		  
		  
	$j("#mainTPDSummaryType").bind("click", function () {
		var value = $j(this).val();
		tpdReportTypecounter++;
		var div = $j("<div class='tr'/>");
		 div.html(addTPDSummaryType(""));
		$j(".project-reports").append(div);
	    $j('.new-report-type').chosen();
		
		// This is done as part of http://redmine.nvish.com/redmine/issues/509
		
		var legalSignOffRequired=$j("#legalsignoffreq").prop("checked");
		if(legalSignOffRequired)
		{	
			enableProjectEvaluationCheckBox('no');
		}
		
	});
	
	$j("#mainIrisSummaryType").bind("click", function () {
		var value = $j(this).val();
		var div = $j("<div class='tr'/>");
		 div.html(addMainSummaryType(""));
		$j("#mainTPDSummaryTypeDiv").before(div);
		
		
		// This is done as part of http://redmine.nvish.com/redmine/issues/509
		
		var legalSignOffRequired=$j("#legalsignoffreq").prop("checked");
		if(legalSignOffRequired)
		{	
			enableProjectEvaluationCheckBox('no');
		}
		
		  });
		  
		  
		  
		
		/*   this is for remove button */
		
		$j("body").on("click", "#removeLink", function () {
			showLoader('Please wait...');
			$j(this).parent().parent().remove();
			mainReportTypecounter--;
			deleteReportRow();

		});
		
		
		
		function addMainReportType(value) 
	{
    	 
		 
	     var reportType  = "<div class='td dynamic-row' id='reportType'><select data-placeholder='Select Report Type'  class='chosen-select form-select new-report-type report-type-attach rt'         id='reportType' name='reportTypes'>"+$j('#reportType').clone(true).html()+"</select></div>";
		 
	
		
		 
 		// var legalApprover = "<div class='td'>"+$j('#legalApproverDiv').clone(true).html()+"</div>";
		 var legalApprover = "<div class='td' id='legalApproverDiv'><input type='text' placeholder= 'Add Legal Approver Name' name='reportTypeLegalApprovers' value='' /></div>";
		 //var attachmentDiv = "<div class='td'>"+$j('#attachmentDiv').clone(true).html();
		 var attachmentDiv = "<div class='td' id='attachmentDiv'><span class='jive-icon-med jive-icon-attachment j-link' onclick='showAttachmentPopupNewReport(${fullReportID?c},this,-1)' ></span>";
		 var removeLink = "<input type='button' value='Remove' class='removeRS' id='removeLink'>"+"</div>";
	
	
		var comment = $j('#commentDiv').clone(true).html();
		var content=  reportType  +  legalApprover + attachmentDiv  + removeLink;
		$j('#confirmProjectEnable').addClass("disabled");			
		return content;       
	}
	
	function addMainSummaryType(value){
		var summaryType  = "<div class='td dynamic-row'><div class='iris_summery_box_align'>IRIS Summary</div></div>";
		//var legalApprover = "<div class='td'>"+$j('#legalApproverDiv').clone(true).html()+"</div>";
		var legalApprover = "<div class='td'><input type='text' placeholder= 'Add Legal Approver Name' name='irisSummaryLegalApprovers' value='' /></div>";
		//var attachmentDiv = "<div class='td'>"+$j('#attachmentDiv').clone(true).html();
		var attachmentDiv = "<div class='td' id='attachmentDiv'><span class='jive-icon-med jive-icon-attachment j-link' onclick='showAttachmentPopupNew(${irisSummaryReportID?c},4,-1)' ></span>";
		var removeLink = "<input type='button' value='Remove' class='removeRS' id='removeLink'>"+"</div>";
		var content=  summaryType  +  legalApprover + attachmentDiv  + removeLink;
		$j('#confirmProjectEnable').addClass("disabled");	
		return content;  
	}
	function addTPDSummaryType(value){
		var summaryType  = "<div class='td dynamic-row'><div class='iris_summery_box_align'>TPD Summary</div></div>";
		/*var legalApprover = "<div class='td'>"+$j('#legalApproverDiv').clone(true).html()+"<input type='text' class='jive-form-textinput-variable j-form-datepicker' id='reportSummarystartDate1' name='tpdSummaryDate' readonly='true'></div>";*/
		
		/*var legalApprover = "<div class='td'><input type='text' name='tpdSummaryLegalApprovers' value='' /><input type='text' class='jive-form-textinput-variable j-form-datepicker' id='reportSummarystartDate1' name='tpdSummaryDate' readonly='true'></div>";*/
		
		var id = "reportSummarystartDate"+tpdReportTypecounter;
		
		var buttonId = "reportSummarystartDate"+tpdReportTypecounter+"_button";
		
		var legalApprover = "<div class='td'><input type='text' placeholder= 'Add Legal Approver Name' name='tpdSummaryLegalApprovers' value='' /><div class='reports-tpd-summary reports-tpd-summary-dynamic'><input type='text' class='jive-form-textinput-variable j-form-datepicker' id='"+id+"' name='tpdSummaryDates' readonly='true' placeholder='Enter Date of Legal Approval' onchange='dateSelected(this);'><a href='#' id='"+buttonId+"' onmouseover='dateClicked("+tpdReportTypecounter+")' onClick='dateClicked("+tpdReportTypecounter+")' class='j-form-datepicker-btn' ><img src='${themePath}/images/synchro/calendar.png' encode='false' width='19' height='19' border='0' /></a></div></div>";
		
	
		
		
		//var attachmentDiv = "<div class='td'>"+$j('#attachmentDiv').clone(true).html();
		var attachmentDiv = "<div class='td' id='attachmentDiv'><span class='jive-icon-med jive-icon-attachment j-link' onclick='showAttachmentPopupNew(${tpdSummaryReportID?c},5,-1)' ></span>";
		var removeLink = "<input type='button' value='Remove' class='removeRS' id='removeLink'>"+"</div>";
		var content=  summaryType  +  legalApprover + attachmentDiv  + removeLink;
		$j('#confirmProjectEnable').addClass("disabled");	
		return content;  
	}
	
	
	function dateClicked(id)
	{
			var date_id = "reportSummarystartDate"+id;
		
			var buttonId = "reportSummarystartDate"+id+"_button";
			
			<!--  to hide script contents from old browsers
			Zapatec.Calendar.setup({
				inputField     :    date_id,     // id of the input field
				ifFormat       :    "%d/%m/%Y",     // format of the input field
				button         :    buttonId,  // What will trigger the popup of the calendar
				showsTime      :     false      //don't show time, only date
			});
			// end hiding contents from old browsers  -->
	}
	function deleteReportRow()
	{
		
		var peForm = jQuery("#synchro-pit-form");
		peForm.submit();
	}
	<!-- Changes for Report Summary Ends -->	
	
	$j(document).ready(function() {
	  var popupTrue = localStorage.getItem("popupTrue");
		  if(popupTrue){
		   $j('.project_name_div .closeonloadPopup').trigger('click');
		   
		  }
		  $j('#pitWindow .close').click(function(){
			   localStorage.removeItem("popupTrue");
		  });
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
		 

$( document ).on( "click", ".removeRS", function() {
            popupTrue = "true";
		   localStorage.setItem("popupTrue", popupTrue);
			});
		  $j('#pitWindow .j-remove-file,#pitWindow .jive-icon-attachment ').click(function(){
		
		   popupTrue = "true";
		   localStorage.setItem("popupTrue", popupTrue);
		  });
		
	});
	// issues 473  change
    $j("#categoryType").change(function()
      {

         
       var categoryType = $j("#categoryType");
       if(categoryType.val() != null)
	   {
         $j("#categoryTypeErrors").hide();
	   }
	     
   });



    $j("#endMarkets").change(function()
      {
          
var endMarkets = $j("#endMarkets").val();         
    
	if(endMarkets != null && $j.trim(endMarkets)!="")
	{
		$j("#endMarketError").hide();
		 error = true;
	}     
   });


$j("#projectManagerName").change(function()
{
    var projectManagerName = $j("input[name=projectManagerName]");
    if(projectManagerName.val() != null && $j.trim(projectManagerName.val())!="")
    {
        projectManagerName.parent().find("span").hide();
       
    }
});


$j("#methodologyType").change(function()
{

 var methodologyType1 = $j("#methodologyType").val();
     
          if(methodologyType1!=null || methodologyType1!=undefined )
               {
                $j("#methodologyType").parent().find("span.jive-error-message").hide();
                }
 });

$j("#methWaiverReq").change(function()
{
var methWaiverReq = $j('select[name="methWaiverReq"] option:selected').val();
	
    
    if(methWaiverReq >=1)
    {
        
		$j("#methodologyWaiverError").hide();
	    
    }

});

  $j("#brand").change(function()
   {
 
 var brand = $j('select[name="brand"] option:selected').val();
     
    if( brand > 1 )
    {
        
		$j("#brandError").hide();
        
    }
	
  });
	
$j("#brandSpecificStudyType").change(function()
   {
    

 var brandSpecificStudyType= $j('select[name="brandSpecificStudyType"] option:selected').val();
     
	 // new change..issue...536
	
	  

			 if(brandSpecificStudyType==1)
			  {
			  $j("#MultibrandTextDiv").show();
			  
			  }
			  else
			  {
			  $j("#MultibrandTextDiv").hide();
			  $j("#MultibrandTextError").hide();
			    
			  }
    if( brandSpecificStudyType >= 1 )
    {
        
		$j("#brandSpecificStudyTypeError").hide();
        
    }
	
  });







$j("#budgetLocation").change(function()
{
var budgetLocation = $j("#budgetLocation");
	if(budgetLocation.val() != null && budgetLocation.val()!="")
	{
		$j("#budgetLocationError").hide();
		error = true;
	}
	

});

$j("#budgetYear").change(function()
{
var budgetYear = $j('select[name="budgetYear"] option:selected').val();

    if(budgetYear >=1)
    {
    	 $j("#budgetYearError").hide();
        
    }
});

$j("#fundingMarkets").change(function()
 {
       
          $j(".fundingMarketsError").hide();
  
});


$j("#legalApprovalStatusPitBrief").change(function()
 {
     
     var status  =  $j('select[name="legalApprovalStatusPitBrief"] option:selected').val();
 
   
  if( status!=""  && status>=1 )
     {
      $j("#statusError").hide();
	  $j("#briefLegalApprovalStatusError").hide();
     }
    });




$j("#briefLegalApprover").change(function()
 {
     var LegalApprover  =  $j('select[name="briefLegalApprover"] option:selected').val();
     
    
   $j("#briefLegalApproverError").hide();


  });


$j("#legalApprovalStatusPitProposal").change(function()
   {
   var  legalApprovalStaPitProposal  =  $j('select[name="legalApprovalStatusPitProposal"] option:selected').val();
     if(legalApprovalStaPitProposal!="" && legalApprovalStaPitProposal>=1)
       {
    
   $j("#statusProposalError").hide();
    $j("#proposalLegalApprovalStatusError").hide();
   }
  });


    $j("#proposalLegalApprover").change(function()
     {
        var  proposalLeApprover  =  $j('select[name="proposalLegalApprover"] option:selected').val();

      if(proposalLeApprover==undefined)
          {}
           else  if(proposalLeApprover!="" ||proposalLeApprover>1)
               { 
                 
                 $j("#proposalLegalApproverError").hide();

               }

      });

	
  </script>
  

  
  
  
  
  
  
