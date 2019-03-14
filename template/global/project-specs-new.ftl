<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#-- DWR def -->
<head>

   
</head>

<#assign synchroUserNames = statics['com.grail.synchro.util.SynchroPermHelper'].getSynchroUserNames() />
<script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>

<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/commons.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/form-data-persist-handler.js?version=1" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/project-sticky-header.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.MultiFile.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ajaxfileupload.js'/>"></script>
 
<link rel="stylesheet" href="${themePath}/style/multi-select.css" type="text/css" media="all" />
<script src="${themePath}/js/synchro/second.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/autosearch2.js" type="text/javascript"></script>

<script>
	var methodologyMultipleMessageText='<@s.text name="project.methodology.multiple.message"/>';
	var currencyChangeMessageText='<@s.text name="project.currency.change.message"/>';
	var currencyChangeMessage = false;
</script>

<#assign fieldCategoryId = ''/>

<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
<#assign isLegalApprover = statics['com.grail.synchro.util.SynchroPermHelper'].isLegaUserType() />
<#assign isSynchroSystemOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner() />
<#assign canEditStage = statics['com.grail.synchro.util.SynchroPermHelper'].canEditProject(project) />

<#assign methodologyProperties = statics['com.grail.synchro.SynchroGlobal'].getAllMethodologyProperties() />
<#assign methBriefException ="" /> 
<#assign agencyWaiverException ="" /> 
<#assign counter =0 />
	<#list project.methodologyDetails as md>
		<#if counter==0>
		<#if methodologyProperties.get(md?int).isProposalException() >
			<#assign methBriefException ="yes" /> 
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
    AUTO_SAVE.register({form:$j("#project-specs-form"), projectID:${projectID?c}});
   /* PROJECT_STAGE_NAVIGATOR.initialize({
    <#if projectID??>
        projectId:${projectID?c},
    </#if>
        activeStage:2
    });*/
    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#project-specs-form"),form:$j("#email-notification-form"), projectID:${projectID?c}});
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

<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
						
					<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
						
					<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID?? >
						
					<#else>
	
					$j("#initiateKantarWaiver").trigger('close');
					closeDialog();
					var p = $j('#pitWindow').is(":visible");
					if(!p){
						$j('.custom_overlay').remove();
					}
	/*
	dialog({
			title:"Confirmation",
			html:"<i class='warningErr positionSet'></i><p>Are you sure you want to close without saving details?</p>",
			nonCloseActionButtons:['YES'],
			buttons:{
				"YES":function() {
					$j("#initiateKantarWaiver").trigger('close');
					closeDialog();
					var p = $j('#pitWindow').is(":visible");
					if(!p){
						$j('.custom_overlay').remove();
					}
				},
				"NO": function() {
					$j("#initiateKantarWaiver").trigger('close');
				}
			},
			closeActionButtonsClickHander:function() {
				$j("#initiateKantarWaiver").show();
				closeDialog();
			}
		});
		relPos();
		*/
  </#if>
		
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
	
	FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#project-specs-form"),form:$j("#synchro-pit-form"), projectID:${projectID?c}})
    $j("#pitWindow").lightbox_me({centered:true,closeEsc:false,closeClick:false,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7}});
	
     initiateRTE('description', 1500, true);
	 initiateRTE('brief', 2700, true);
	 initiateRTE('proposal', 5000, true);
	
	
	<#assign i18CustomPITText><@s.text name="logger.project.pit.view.text" /></#assign>
	var projName = "${project.name?js_string}";
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_IN_PROGRESS.getId()}, "${i18CustomPITText}", projName, ${projectID?c}, ${user.ID?c});
	
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
    <#--FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#project-specs-form"),form:$j("#waiver-form"), projectID:${projectID?c}});-->
    $j("#initiateWaiver").lightbox_me({centered:true,closeEsc:false,closeClick:false,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7}});
    initiateRTE('methodologyDeviationRationale', 2500, false);
    initiateRTE('methodologyApproverComment', 2500, false);
	
	
	<#if !(pibMethodologyWaiver?? && pibMethodologyWaiver.methodologyApprover??)>
		<#assign waiverBtnClickText><@s.text name="logger.project.waiver.btn.click" /></#assign>
		var projName = "${project.name?js_string}";		
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].ADD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_IN_PROGRESS.getId()}, "${waiverBtnClickText}", projName, ${projectID?c}, ${user.ID?c});
	</#if>
}
function closeWaiverWindow()
{
	<#if pibMethodologyWaiver?? && pibMethodologyWaiver.status?? && pibMethodologyWaiver.status==0>
		$j("#initiateWaiver").trigger('close');
		closeDialog();
	<#elseif !canEditStage>	
		$j("#initiateWaiver").hide();
		$j("#initiateWaiver").trigger('close');
		closeDialog();
	<#elseif pibMethodologyWaiver?? && pibMethodologyWaiver.isApproved?? && (pibMethodologyWaiver.isApproved==1 || pibMethodologyWaiver.isApproved==2)>
		$j("#initiateWaiver").hide();
		$j("#initiateWaiver").trigger('close');
		closeDialog();
	<#else>
	    $j("#initiateWaiver").hide();
	    
	    $j("#initiateWaiver").trigger('close');
	    closeDialog();
		
		/*
		dialog({
	        title:"",
			html:"<i class='warningErr positionSet'></i><p>Are you sure you want to close without saving details?</p>",
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
		relPos();
		*/
    </#if>
}
function closePITWindow()
{	$j('.confirm-msg').hide();
    $j("#pitWindow").hide();
	$j('#overViewDiv').show();
	$j("#confirmProject").val('');
	
	<#if !canEditStage>	
		$j("#pitWindow").hide();
		$j("#pitWindow").trigger('close');
		closeDialog();
	<#else>	
		dialog({
			title:"",
			html:"<i class='warningErr positionSet'></i><p>Are you sure you want to close without saving details?</p>",
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
		});
		relPos();
	</#if>

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

               	$j('#proposedMethodology option').prop('selected', true);
                $j("#messageBody").val(messageBody);
                $j("#email-notification-form").submit();
            },
            async: true
        });
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
        html: '<i class="warningErr positionSet"></i><p>Please upload a new '+attachmentField+' before removing the existing one </p>',
        buttons:{
            "OK":function() {
               closeDialog();
            }
        },
				create:function () {
			$j(this).closest(".ui-dialog")
            .find(".ui-button:last")
            .addClass("textorange-btn");
    }
    });
	 orangeBtn();
	 relPos();

}

function confirmDelete(attachmentId, fieldID, attachmentName) {
    location.href="/new-synchro/project-specs!removeAttachment.jspa?projectID=${projectID?c}&attachmentId="+attachmentId+"&attachmentFieldID="+fieldID+"&attachmentName="+attachmentName;
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


<div class="container">
<div class="project_names">


<div class="project_name_div">

<h2>${project.name?html} (${generateProjectCode('${projectID?c}')}) </h2>
<#if canEditStage >
			
		<a class="view-edit" href="javascript:void(0);" onclick="javascript:openPITWindow()">Click here to view/edit more details</a>
		<#else>
		<a class="view-edit" href="javascript:void(0);" onclick="javascript:openPITWindow()">Click here to view more details</a>
		</#if>
		

<#if !isLegalApprover >
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





<#assign isMethAppUser = statics['com.grail.synchro.util.SynchroPermHelper'].isMethodologyApproverUser() />
<#assign isKantarMethAppUser = statics['com.grail.synchro.util.SynchroPermHelper'].isKantarMethodologyApproverUser() />



<#assign isProjectCreator = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectCreatorNew(projectID) />




<#assign defaultCurrency = -1/>




 <#assign endMarketId = endMarketDetails.get(0).getEndMarketID() />




<#if !canEditStage>	
	<#include "/template/global/project-specs-new-readOnly.ftl" />
<#else>
<form name="project-specs" action="/new-synchro/project-specs!execute.jspa" method="POST"  id="project-specs-form" class="research_pib pib" >
<div class="research_content">
<input type="hidden" name="projectID" value="${projectID?c}">
<input type="hidden" name="isSave" value="${save?string}">
  <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
<div class="pib_inner_main">
<div class="pib_left">
	<!-- <a class="view-edit" href="javascript:void(0);" onclick="javascript:openPITWindow()">View/Edit PIT</a> -->
	<div>
        <div class="form-select_div">
            <label>Project Start Date</label>
		<@synchrodatetimepicker id="startDate" name="startDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false dateCompareStart=true/>
		 
             <#assign error_msg>Please select Project Start Date</#assign>
			<@macroCustomFieldErrors msg=error_msg />
        </div>
    </div>

    <div>
        <div class="form-select_div">
            <label>Project End Date</label>
          <@synchrodatetimepicker id="endDate" name="endDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false dateCompareEnd=true/>
		 
            <#assign error_msg>Please select Project End Date</#assign>
			 <@macroCustomFieldErrors msg=error_msg />
        </div>
    </div>
	
	 <div class="project_owner_brief">
        <label>Total Cost</label>
		<div class="total-cost-details">
        
		
		<#if project.totalCost??>
			<input type="text"  name="totalCost" id="totalCost" value="${project.totalCost?round} GBP" disabled/>
			
			<#if statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user))?? >

				<#if statics['com.grail.synchro.util.SynchroUtils'].getPreferredCurrenyTotalCost(project,user)?? >
					<input type="text"  name="totalCost" id="totalCost" value="${statics['com.grail.synchro.util.SynchroUtils'].getPreferredCurrenyTotalCost(project,user)?round} ${statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user))}" disabled/>
					
				<#else>
					<input type="text"  name="totalCost" id="totalCost" value="" disabled/>
				</#if>
			</#if>
				
			<#if totalCosts??>
				<#assign totalCostsKeySet = totalCosts.keySet() />
				<#list totalCostsKeySet as key>
					
					<#if JiveGlobals.getJiveIntProperty("grail.default.currency",87)!=key>
						<#if statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user)?? > 		
							<#if statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user)!=key >
								<#if statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(key)?? >
									<input type="text"  name="totalCost" id="totalCost" value="${totalCosts.get(key)?round} ${statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(key)}" disabled/>
								<#else>
									<input type="text"  name="totalCost" id="totalCost" value="${totalCosts.get(key)?round}" disabled/>
								</#if>		
							</#if>
						<#else>
							<#if statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(key)?? >
								<input type="text"  name="totalCost" id="totalCost" value="${totalCosts.get(key)?round} ${statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(key)}" disabled/>
							<#else>
								<input type="text"  name="totalCost" id="totalCost" value="${totalCosts.get(key)?round}" disabled/>
							</#if>	
						</#if>	
					</#if>
					
				</#list>
			</#if>
		<#else>
			<input type="text"  name="totalCost" id="totalCost" value="" disabled/>
			
		</#if>
		</div>
    </div>
	
	<!--amit-->
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
	 <div class="form-text_div reference-project-details"   id="ReferenceProjectDetailsDiv">
				  
		   
		    
			  <h3><span>Research End Market</span><span>SynchrO Code</span></h3>
			  
			  <div id="dynamicReferenceProjectDetailsDiv">
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
				   for(i=0;i<euMarkertValues.length;i++)
					  {
							if(showEndMarket[i]=="yes")
							{
							  var div = $j("<div/>");
							   div.html(dynamicReferenceProjectDetailsComponents(i));  
							   $j("#dynamicReferenceProjectDetailsDiv").append(div);
								//$j(".chosen-select").chosen();
							}
						   }
						   
						   
						 function dynamicReferenceProjectDetailsComponents(val)
							  {
						   var comp="";
						  comp= "<div class='float-left'><select  class='chosen-select' id='referenceEndMarkets' name='referenceEndMarkets'><option value='"+euMarkertValues[val]+"'>"+euMarketText[val]+"</option></select></div>&nbsp&nbsp&nbsp&nbsp";
	
			
						var content=comp+'<div class="float-left synchroCode_row"><input   name ="referenceSynchroCodes" type="text"   id="referenceSynchroCodes" placeholder="Enter SynchrO Code" onChange="return isNumber()"  onfocus="this.placeholder = \'\'" onblur="this.placeholder = \'Enter SynchrO Code\'"  class="text_field  longField total-expense" value='+refSynCode[val]+'><span class="jive-error-message synchroCodeError" style="display: none;">Please enter numeric value</span></div>'
	
						 return content;      
						}		
		  
				   </script>
		  
			  </div>
		</#if>
	</#if>
	<!--amit-->
	
	<#if agencyWaiverException=="yes">
	<#else>
		<div id="agencyWaiverDiv" class="statusPending">
			<div class="project_waiver_rqst" >
			<label>Agency Waiver Request</label>
			<ul class="right-sidebar-list">

				<li id="initiateKantarWaiverButton" ><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status!=-1>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>
			</ul>
			<div class="form-select_div select-div methodology-status" id="nonKantarWaiverStatus" <#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>style="display:block;" <#else> style="display:none;"</#if>>

				<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
					<label>Status:</label>
					<span class="approvedStatus">Approved</span>
				<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
					<label>Status:</label>
					<span class="rejectedStatus">Rejected</span>
				<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID?? >
					<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_APP_PENDING.ordinal()>
					<label>Status:</label>
					<span class="pendingStatus">Pending</span>
					</#if>
				<#else>
				</#if>

				<br/>
			</div>
			</div>


			
		</div>
	</#if>	

	
	
	
	 <div class="form-select_div select-div statusPending">
        <label>Will a methodology waiver be required?</label>
		
		<#if isAdminUser || isSynchroSystemOwner>
			<select data-placeholder="Select" class="chosen-select" id = "deviationFromSM" name="deviationFromSM" <#if project.methWaiverReq?? && project.methWaiverReq==1 && pibMethodologyWaiver?? && pibMethodologyWaiver.projectID?? >disabled</#if>   onchange="checkMethDeviation()">
		<#else>
			<select data-placeholder="Select" class="chosen-select" id = "deviationFromSM" name="deviationFromSM" disabled   onchange="checkMethDeviation()">
		</#if>
		
		
			<option  value="-1" <#if project.methWaiverReq?? && project.methWaiverReq==-1 > selected </#if>></option>
			<option  value="1" <#if project.methWaiverReq?? && project.methWaiverReq==1 > selected </#if>>Yes</option>
			<option  value="2" <#if project.methWaiverReq?? && project.methWaiverReq==2 > selected </#if>>No</option>
			<option  value="3" <#if project.methWaiverReq?? && project.methWaiverReq==3 > selected </#if>>I don’t know yet</option>
		</select>
		<span class="jive-error-message" id="deviationFromSMError" style="display:none">Please select Will a methodology waiver be required?</span>
		

		
       
            <script type="text/javascript">
                <#--
                var initiateWaiverWindow = null;
                $j(document).ready(function(){
                    initiateWaiverWindow = new LIGHT_BOX($j("#initiateWaiver"),{title:'Request for Methodology Waiver',confirmOnClose:true});
                    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#project-specs-form"),form:$j("#waiver-form"), projectID:${projectID?c}});
                });
				-->
            </script>
            <#assign showWaiverBtn = 'none' />
			
            <#if project.methWaiverReq?? && project.methWaiverReq==1>
                <#assign showWaiverBtn = 'block' />
            </#if>

            <ul class="right-sidebar-list">
                <li id="initiateWaiverButton" style='display:${showWaiverBtn?string}'><a onclick="javascript:openInitiateWaiverWindow();" href="javascript:void(0);"><#if pibMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>
            </ul>
       <#if project.methWaiverReq?? && project.methWaiverReq==1 && pibMethodologyWaiver?? && pibMethodologyWaiver.projectID?? >
        <div class="form-select_div select-div methodology-status">
            <label>Status:</label>
            <#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                <span class="approvedStatus">Approved</span>
            <#elseif pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==2>
                <span class="rejectedStatus">Rejected</span>
            <#else>
                <span class="pendingStatus">Pending</span>
            </#if>
        </div>
    </#if>
    </div>
    
   

   
</div>



<div class="region-inner attachment-text">
	
    <label class='rte-editor-label'>Documentation (if any) </label>
    <div class="form-text_div  textarea__fix">
        <textarea id="documentation" name="documentation" placeholder="Add notes, if any" rows="10" cols="20" class="form-text-div">${projectSpecsInitiation.documentation?default('')?html}</textarea>
		<i>(e.g. Screener, Questionnaire/Discussion guide etc.)</i>
        <@macroCustomFieldErrors msg="Please enter the Project Documentation" class='textarea-error-message'/>
    </div>
    <textarea style="display:none;" id="documentationText" name="documentationText">${projectSpecsInitiation.documentationText?default('')?html}</textarea>
	 <!-- ATTACHMENT DISPLAY STARTS -->
   <div class="field-attachments">
   
		<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${documentationID?c})" ></span>
			<#if attachmentMap?? && attachmentMap.get(documentationID)?? >
				<div id="jive-file-list" class="jive-attachments">
					<#list attachmentMap.get(documentationID) as attachment>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser || isSynchroSystemOwner) >
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

    <#assign synchroUtils = jiveContext.getSpringBean("synchroUtils") />

<script type="text/javascript">
    var attachmentWindow = null;
	var attachmentPITWindow = null;
	var attachmentWindowAgencyWaiver = null;
	
    $j(document).ready(function(){
        attachmentWindow = new SYNCHRO_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/new-synchro/project-specs!addAttachment.jspa'/>",
            projectID:${projectID?c},
            endMarketID:${endMarketId?c},
            parentForm:$j("#project-specs-form"),
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
            formUrl:"<@s.url value='/new-synchro/project-specs!addAttachment.jspa'/>",
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

	$j(document).ready(function(){
        attachmentPITWindow = new SYNCHRO_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/new-synchro/project-specs!addAttachment.jspa'/>",
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

        $j("#fileAttachBtn").bind('click',function(){
            attachmentPITWindow.show();
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
	function showAttachmentPopupPIT(fieldId) {
      
		attachmentPITWindow.show(fieldId);
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
<#--	<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && (pibKantarMethodologyWaiver.isApproved==1 || pibKantarMethodologyWaiver.isApproved==2)>
		initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request for Agency Waiver',confirmOnClose:false});
	<#elseif  pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status==0>
			initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request for Agency Waiver',confirmOnClose:false});
	<#else>
		initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request for Agency Waiver',confirmOnClose:true});
	</#if>-->
        FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#project-specs-form"),form:$j("#kantar-waiver-form"), projectID:${projectID?c}});
    });

</script>





<div class="buttons">
     <#if canEditStage || isAdminUser || isSynchroSystemOwner || isProjectCreator  >
        <br>
        
		<#--<input type="submit" name="save pib" onclick="return validatePIBFormFields();" value="Save" class="save"/>
		<input type="button" name="save pib" onclick="return continueProject();" value="Project Completed" class="save continue"/>-->
		
		<a href="javascript:void(0);" style="margin-left: 10px;" onclick="return validatePIBFormFields('');" class="publish-details">Save</a>
		<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" onclick="return continueProject();" class="publish-details">PROCEED TO UPLOAD REPORTS</a>	
    </#if>
</div>

</div>
</div>
</div>

</form>




<div id="emailNotification" style="display:none">
    <form id="email-notification-form" action="<@s.url value="/new-synchro/project-specs!sendNotification.jspa"/>" method="post" enctype="multipart/form-data" class="j-form-popup">
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
  
   
		
        <form id="waiver-form" action="<@s.url value='/new-synchro/project-specs!updateWaiver.jspa'/>" method="post" class="j-form-popup">
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
        </form>
    </div>
</div>



<div id="initiateKantarWaiver" class="j-form-popup"  style="display:none">
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

  

        <form id="kantar-waiver-form" action="<@s.url value='/new-synchro/project-specs!updateKantarWaiver.jspa'/>" method="post">
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
			<#-- <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${agencyWaiverID?c})" ></span> -->
			
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
	
	 
	
        <form id="synchro-pit-form" action="<@s.url value='/new-synchro/project-specs!updatePIT.jspa'/>" method="post" class="j-form-popup">
		  <a href="javascript:void(0);" class="close" onclick="closePITWindow();"></a>
		  <div class="popup-title-overlay"></div>
		 <div class="pop-upinner-scroll">
		 <div class="pop-upinner-content">
			<div class="confirm-msg"><h3>Please confirm all the project details as you will not be able to edit any information after the project is completed.</h3></div>
            <div id="overViewDiv">
			<h3>Project Details Overview</h3>
			</div>
			
            <div class="pib_view_popup region-inner">
                <label>Project Name </label>
            <#if (isAdminUser || isSynchroSystemOwner)>
				<input type="text" id="projectName" name="projectName" value="${project.name?html}" maxlength="250" class="pit_window_field_width"/>
			<#else>
				<input type="text" id="projectName" name="projectName" disabled value="${project.name?html}" class="pit_window_field_width"/>
			</#if>
            </div>
			<div class="region-inner">
            <label class="pit-description-label">Project Description</label>
           
			  
			<div class="form-text_div">
				<textarea id="description" name="description" rows="10" cols="20" class="form-text-div">${project.description?default('')?html}</textarea>
				<@macroCustomFieldErrors msg="Please enter the Project description" class='textarea-error-message'/>
			</div>
			<textarea style="display:none;" id="descriptionText" name="descriptionText">${project.description?default('')?html}</textarea>
             </div>
            
			
			<div class="region-inner">
				
				<label class="label_b"><@s.text name="project.initiate.project.category"/></label>
				<div class="col-lg-6">
			  
					<select data-placeholder="Select Category" class="chosen-select" id = "categoryType" name="categoryType" multiple >
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
				
					<span class="jive-error-message" id="categoryTypeErrors" style="display:none">Please select Category</span>
					
				
				</div>
			</div>
			
			<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId()) >
			<#else>
				<div class="region-inner">
					
					<div class="form-select_div">
						
						<label>Is the project a fieldwork component of an above market study?</label>
					
					<@fieldworkstudyField name='fieldWorkStudy' value=project.fieldWorkStudy?default('-1')/>
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
									<#assign endMarketRegionsKeySet = endMarketRegions.keySet() />
									<#if (endMarketRegions?has_content)>
										<#list endMarketRegionsKeySet as key>
											<#assign region = endMarketRegions.get(key) />
											 <optgroup label="${regions.get(key)}">
												 <#assign endMarketKeySet = endMarketRegions.get(key).keySet() />
												 <#list endMarketKeySet as endMarketkey>
													<#if endMarketTypeMap.get(endMarketkey)?? && endMarkets.get(endMarketkey)?? >
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
										<#assign endMarketRegionsKeySet = endMarketRegions.keySet() />
										<#if (endMarketRegions?has_content)>
											<#list endMarketRegionsKeySet as key>
												<#assign region = endMarketRegions.get(key) />
												 <optgroup label="${regions.get(key)}">
													 <#assign endMarketKeySet = endMarketRegions.get(key).keySet() />
													 <#list endMarketKeySet as endMarketkey>
														<#if endMarketTypeMap.get(endMarketkey)?? && endMarkets.get(endMarketkey)?? >
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
							<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets' disabled>
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
						   
						   
						 function dynamicReferenceProjectDetailsComponents(val)
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
			   
					<@synchrodatetimepicker id="startDate1" name="startDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false dateCompareStartPIT=true/>
				<#assign error_msg>Please select Project Start Date</#assign>
				<@macroCustomFieldErrors msg=error_msg />
				</div>
			</div>	
			<div class="region-inner">
				<div class="form-select_div form-select_div_project_completion">
					<label>Project End Date</label>
					 
				<@synchrodatetimepicker id="endDate1" name="endDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false dateCompareEndPIT=true/>
				<#assign error_msg>Please select Project End Date</#assign>
				<@macroCustomFieldErrors msg=error_msg />
				</div>
			</div>
			
			<div class="region-inner">
				
				
				<div class="form-select_div">
					
					<label>SP&I Contact</label>
					<div>
					
					   
					<input type="text"  name="projectManagerName" value="${project.projectManagerName}" id="projectManagerName"  />

					<#assign error_msg>Please select SP&I Contact</#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
				</div>

				<!-- Project SP&I Contact -->
		
				<#--<div class="form-select_div form-select_div_project_completion">
					
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
							<select data-placeholder="Select Methodology" disabled class="chosen-select" id = "methodologyDetails" name = "methodologyDetails" >
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
														<option lessFrequent="yes" value="${methkey?c}" brandSpecific="${methodologyProperties.get(methkey).getBrandSpecific()}" <#if project.methodologyDetails?seq_contains(methkey)> selected</#if>>${methodologies.get(methkey)}</option>
													<#else>
														<option lessFrequent="no" value="${methkey?c}" brandSpecific="${methodologyProperties.get(methkey).getBrandSpecific()}" <#if project.methodologyDetails?seq_contains(methkey)> selected</#if>>${methodologies.get(methkey)}</option>
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
						<label>Methodology Type</label>
				
					<@renderMethodologyField name='methodologyType' value=project.methodologyType?default('-1') readonly=false/>
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
						<select data-placeholder="Select" class="chosen-select" id = "methWaiverReq" name="methWaiverReq" disabled   onchange="checkMethDeviation()">
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
					<span class="jive-error-message" id="methodologyWaiverError" style="display:none">Please select Will a methodology waiver be required?</span>
					</div>
					<div id="waiverMessage" style="display:none">You will be able to initiate waiver through the system once the project is created</div>
				</div>
				
			<div class="region-inner">
					
					<div class="form-select_div">
						<label>Is this a brand specific study?</label>
					
					<@renderBrandSpecificStudy name='brandSpecificStudy' value=project.brandSpecificStudy?default('-1')/>
					<span class="jive-error-message" id="brandSpecificStudyError" style="display:none">Please select Is this a brand specific study?</span>
					<div id="brandSpecific" style="display:none">
					
					<div class="form-select_div">
						
					
					<@renderBrandFieldNew name='brand' value=project.brand?default('-1')/>
					<span class="jive-error-message" id="brandError" style="display:none">Please select Brand</span>
					</div>
					
					</div>
					<div id="brandSpecificStudyType">
					
					
										
					<@renderBrandSpecificStudyType name='brandSpecificStudyType' value=project.brandSpecificStudyType?default('-1')/>
					<span class="jive-error-message" id="brandSpecificStudyTypeError" style="display:none">Please select Study Type</span>
					
					</div>
					</div>
					
						<!--change  536-->
					<div class="form-select_div MultibrandTextDivPitPosition" id="MultibrandTextDiv"   style="display:none">
						
							

							<div>
								   
								<input type="text"  name="multiBrandStudyText" placeholder="Enter the Brands"" id="multiBrandStudyText"  onfocus="this.placeholder='' " <#if project?? && project.multiBrandStudyText??> value="${project.multiBrandStudyText}" </#if> onblur="this.placeholder = 'Enter the Brands' "/>
								<span class="jive-error-message" id="MultibrandTextError" style="display:none">Please enter Brands </span>
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
									<#--<#if statics['com.grail.synchro.util.SynchroPermHelper'].isRegionalUserType()>
										<#assign userRegionBudgetLocation = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationRegions(user) />
										<#list userRegionBudgetLocation as uRegionBugLoc>
											<#if project?? && project.budgetLocation?? && project.budgetLocation==uRegionBugLoc>
												<option  value="${uRegionBugLoc}" selected >${regions.get(uRegionBugLoc?int)}</option>
											<#else>
												<option  value="${uRegionBugLoc}" >${regions.get(uRegionBugLoc?int)}</option>
											</#if>
										</#list>
									</#if>-->
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
									<#--<#if userBudgetLocation?? && userBudgetLocation?size gt 0 >
								
										<#list userBudgetLocation as ubugLoc>
										<option  value="${ubugLoc}" <#if project.budgetLocation?int==ubugLoc?int> selected </#if>>${endMarkets.get(ubugLoc?int)}</option>
										</#list>
									</#if> -->
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
				<span class="jive-error-message" id="budgetLocationError" style="display:none">Please select Budget Location</span>
					</div>
				</div>

				<div class="region-inner">
				<@projectBudgetYearFieldNewForPIT name="budgetYear" value=project.budgetYear/>
					
				</div>
				
				<div id="expenseDetailsContainer" class="region-inner">
				<label>Cost Details</label>
					<div class="border-box pit_window_field_width border-inputradius">
					
					<#assign projectCostCounter = 0 />
						<#assign showAgencyWaiver=""/>
						
						<#assign savedAgencies =""/>
					<#list projectCostDetailsList as projectCostDetail>
					
					<#assign projectCostCounter =  projectCostCounter + 1/>
					
					
					<#if !isAdminUser>
						<div class="expense_row blank">
					<#else>
						<div class="expense_row">
						<input type="button" value="duplicate" id="firstDuplicate" class="duplicate"/>
						<input type="button" value="Remove" id="firstRemove" class="remove" />
					</#if>
					<div class="region-inner">
						
						
					
					<div id="agencyMain">
					
						<#--<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>
							<#assign savedAgencies =  savedAgencies + "," + projectCostDetail.getAgencyId()/>
							<select data-placeholder="Research Agency" disabled title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
						<#else>
							<select data-placeholder="Research Agency" title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
						</#if>-->
						
						<#if !isAdminUser>
							<#assign savedAgencies =  savedAgencies + "," + projectCostDetail.getAgencyId()/>
							<select data-placeholder="Research Agency" disabled title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
						<#else>
							<select data-placeholder="Research Agency" title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
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
							<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" Placeholder="Enter Cost" class="text_field  longField total-expense" value="${projectCostDetail.getEstimatedCost()}" onfocus="this.placeholder = ''"   onblur="this.placeholder = 'Enter Cost'" />
							
							<span class="jive-error-message agencyCostsError" style="display: none;">Please Enter Agency Cost</span>
							</div>
							
						</div>

					</div>
					</div>
					
					</#list>
					
					
					
					<#--<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>-->
					
					<#if !isAdminUser>
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

									<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" Placeholder="Enter Cost" class="text_field longField total-expense" value="" onfocus="this.placeholder = ''"   onblur="this.placeholder = 'Enter Cost'"  />
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
										<input type="text" placeholder="0" name="prefCost" id="prefCost" class="longField" value="${statics['com.grail.synchro.util.SynchroUtils'].getPreferredCurrenyTotalCost(project,user)?round}" disabled />
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
				
			
			<#if agencyWaiverException=="yes">
			<#else>
				<div class="project_waiver_rqst region-inner statusPending" id="agencyWaiverDivPIT">
					<label>Agency Waiver Request</label>
					<ul class="right-sidebar-list">

						<li id="initiateKantarWaiverButtonPIT" ><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover?? && pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status!=-1>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>
					</ul>
					
					<div  class="agency_methodology" id="nonKantarWaiverStatus" <#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>style="display:block;" <#else> style="display:none;"</#if>>

						<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
							<span>Status: <span class="status-txt approvedStatus">Approved</span></span>
						<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
							<span>Status: <span class="status-txt rejectedStatus">Rejected</span></span>
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
					<label>Is an end market involved in this project?</label>
				
					<#if project.endMarketFunding??>
							<@renderEndMarketFundingField name='endMarketFunding' value=project.endMarketFunding?default('-1') /> <span class='jive-error-message endmarketfunding_alignment' id='endMarketFundingErrors' style='display: none;'>Please select is an end market involved in this project? </span>
					<#else>
							<@renderEndMarketFundingField name='endMarketFunding' value=-1/>
					</#if>
				
				</div>
				
				<div class="form-select_div second-column" id="fundingMarketsDiv" <#if project.endMarketFunding?? && project.endMarketFunding==1> style="display:block" <#else>style="display:none"</#if>>
					<label>Select the end market(s) which will carry out the fieldwork</label>
				<div class="pitfundMsg__fix">
					<#if project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId()>
						<select data-placeholder="Select end market" class="chosen-select" id = "fundingMarkets" name="fundingMarkets" multiple >
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
					
						<select data-placeholder="Select end market" class="chosen-select" id = "fundingMarkets" name="fundingMarkets" >
							<option value=""></option>
							<#if endMarketDetails??>
							    <#list endMarketDetails as emd >
								    <#if emd?? && emd.getIsFundingMarket()?? && emd.getIsFundingMarket()>
									    <option value="${emd.getEndMarketID()}" selected>${endMarkets.get(emd.getEndMarketID()?int)}</option>
									<#else>
										<#if emd?? && endMarkets.get(emd.getEndMarketID()?int)??>
											<option value="${emd.getEndMarketID()}">${endMarkets.get(emd.getEndMarketID()?int)}</option>
										</#if>
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
						
						<#if (isAdminUser || isSynchroSystemOwner)>
							<textarea id="brief" name="brief" rows="10" cols="20" class="form-text-div">${projectInitiation.brief?default('')?html}</textarea>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
							
						<#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
							<textarea id="brief" name="brief" rows="10" cols="20" class="form-text-div">${projectInitiation.brief?default('')?html}</textarea>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
						<#else>
						<textarea id="brief" name="brief" rows="10" cols="20" disabled class="form-text-div">${projectInitiation.brief?default('')?html}</textarea>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
						</#if>
					</div>
					<textarea style="display:none;" id="briefText" name="briefText">${projectInitiation.briefText?default('')?html}</textarea>
					 <!-- ATTACHMENT DISPLAY STARTS -->
						<div class="field-attachments">
						
						
					 <#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
						<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupPIT(${briefID?c})" ></span>
					
						<#if attachmentMap?? && attachmentMap.get(briefID)?? >
							<div id="jive-file-list" class="jive-attachments">
								<#list attachmentMap.get(briefID) as attachment>
									<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
										<span class="jive-icon-med jive-icon-attachment"></span>
										<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser || isSynchroSystemOwner) >
											<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
										</#if>
										<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
										${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
									</div>
								</#list>
							</div>
						</#if>
						
					   <#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() ||  project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId())>
							<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupPIT(${briefID?c})" ></span>
						
							<#if attachmentMap?? && attachmentMap.get(briefID)?? >
								<div id="jive-file-list" class="jive-attachments">
									<#list attachmentMap.get(briefID) as attachment>
										<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
											<span class="jive-icon-med jive-icon-attachment"></span>
											<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID)  || (isAdminUser || isSynchroSystemOwner) >
												<#if (attachmentMap.get(briefID)?size == 1)>
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Brief');"><@s.text name="global.remove" /></a>
												<#elseif (attachmentMap.get(briefID)?size gt 1)>
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
												</#if>
											</#if>
											<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
											${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
										</div>
									</#list>
								</div>
							</#if>
					   
					   
					   <#elseif projectInitiation?? && projectInitiation.sendForApproval?? && projectInitiation.sendForApproval==1 >
							<#if (isAdminUser || isSynchroSystemOwner)>
								<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupPIT(${briefID?c})" ></span>
							</#if>
							<#if attachmentMap?? && attachmentMap.get(briefID)?? >
									<div id="jive-file-list" class="jive-attachments">
										<#list attachmentMap.get(briefID) as attachment>
											<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
												<span class="jive-icon-med jive-icon-attachment"></span>
												<#if (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(briefID)?size gt 1 >
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
												<#elseif (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(briefID)?size == 1 >
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Brief');"><@s.text name="global.remove" /></a>
												</#if>
												<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
												${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
											</div>
										</#list>
									</div>
								</#if>
						<#elseif projectInitiation?? && projectInitiation.legalApprovalStatus?? && (projectInitiation.legalApprovalStatus gt 0)  >
							<#if (isAdminUser || isSynchroSystemOwner)>
								<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupPIT(${briefID?c})" ></span>
							</#if>
							<#if attachmentMap?? && attachmentMap.get(briefID)?? >
									<div id="jive-file-list" class="jive-attachments">
										<#list attachmentMap.get(briefID) as attachment>
											<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
												<span class="jive-icon-med jive-icon-attachment"></span>
												<#if (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(briefID)?size gt 1 >
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
												<#elseif (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(briefID)?size == 1 >
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Brief');"><@s.text name="global.remove" /></a>
												</#if>
												<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
												${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
											</div>
										</#list>
									</div>
								</#if>
					   <#else>
							
								<#if (isAdminUser || isSynchroSystemOwner)>
								<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupPIT(${briefID?c})" ></span>
								</#if>
								<#if attachmentMap?? && attachmentMap.get(briefID)?? >
									<div id="jive-file-list" class="jive-attachments">
										<#list attachmentMap.get(briefID) as attachment>
											<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
												<span class="jive-icon-med jive-icon-attachment"></span>
												<#--<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser || isSynchroSystemOwner) >
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
												</#if>-->
												<#if (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(briefID)?size gt 1 >
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
												<#elseif (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(briefID)?size == 1 >
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Brief');"><@s.text name="global.remove" /></a>
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
				
					<#if (isAdminUser || isSynchroSystemOwner)>
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
				
				<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
				
					<div class="form-select_div form-select_div_project_completion region-inner">
						
						<label>Legal Approver's Name</label>
						<div>
							<#if (isAdminUser || isSynchroSystemOwner) || (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
							<#--	<select data-placeholder="Select Legal Approver"  class="chosen-select" id = "briefLegalApprover" name='briefLegalApprover' >
								
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
										
								</select> -->
								
								<#if projectInitiation.getBriefLegalApproverOffline()??>
									<input type="text" id="legalApproverName" placeholder="Select Legal Approver" name="briefLegalApproverOffline"  value="${projectInitiation.getBriefLegalApproverOffline()}"  />
									
									
							 <#else>		
									
								<!-- Amit Change   for Online process  drop down appear-->
							    <#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId())>
								
								
								   
								<select data-placeholder="Select Legal Approver"  class="chosen-select" id = "briefLegalApprover" name='briefLegalApprover'><span class="jive-error-message full-width" id="legalApproverError" style="display:none">Please select Legal Approver's Name</span>
							
								<option value=""></option>
								<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
								<#assign endMarketApproversKeySet = endMarketLegalApprovers.keySet() />
								
								<#--
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
								-->
								
								<#if projectInitiation?? && projectInitiation.briefLegalApprover?? && projectInitiation.briefLegalApprover?int == 3767>
								   <#list endMarketApproversKeySet as key>
										<#if endMarkets.get(key?int)??>
											<optgroup label="${endMarkets.get(key?int)}">
											<#list endMarketLegalApprovers.get(key) as legalUser >
												<#if projectInitiation?? && projectInitiation.briefLegalApprover?? && projectInitiation.briefLegalApprover == legalUser.ID>
													<option value="${legalUser.ID?c}" selected>${legalUser.name}</option>
												<#else>
													<option value="${legalUser.ID?c}">${legalUser.name}</option>
												</#if>
											</#list>
											</optgroup>
										</#if>	
								   </#list>
								<#elseif projectInitiation?? && projectInitiation.briefLegalApprover?? && projectInitiation.briefLegalApprover?int gt  0>
									 <#list endMarketApproversKeySet as key>
										<#if endMarkets.get(key?int)??>
											<optgroup label="${endMarkets.get(key?int)}">
											<#list endMarketLegalApprovers.get(key) as legalUser >
												<#if legalUser.ID?int == 3767>
												<#else>
													<#if projectInitiation?? && projectInitiation.briefLegalApprover?? && projectInitiation.briefLegalApprover == legalUser.ID>
														<option value="${legalUser.ID?c}" selected>${legalUser.name}</option>
													<#else>
														<option value="${legalUser.ID?c}">${legalUser.name}</option>
													</#if>
												</#if>
											</#list>
											</optgroup>
										</#if>	
								   </#list>
								
								<#else>
									  <#list endMarketApproversKeySet as key>
										<#if endMarkets.get(key?int)??>
											<optgroup label="${endMarkets.get(key?int)}">
											<#list endMarketLegalApprovers.get(key) as legalUser >
												<#if legalUser.ID?int == 3767>
												<#else>
													<#if projectInitiation?? && projectInitiation.briefLegalApprover?? && projectInitiation.briefLegalApprover == legalUser.ID>
														<option value="${legalUser.ID?c}" selected>${legalUser.name}</option>
													<#else>
														<option value="${legalUser.ID?c}">${legalUser.name}</option>
													</#if>
												</#if>
											</#list>
											</optgroup>
										</#if>	
								   </#list>
								</#if>	
									
							</select>
								
								 <#else>
								<input type="text" id="legalApproverName" placeholder="Select Legal Approver" name="briefLegalApproverOffline"  value=""  />
								
								 </#if>
								 
								 
								</#if>	
								 <span class="jive-error-message full-width" id="briefLegalApproverError" style="display:none">Please select Brief Legal Approver's Name</span>
							<#else>
							
								<#if projectInitiation?? && projectInitiation.briefLegalApprover??>
									<#assign legalApproverName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(projectInitiation.briefLegalApprover) />
								<#else>
									<#assign legalApproverName = '' />
								</#if>
								<input type="text"  name="legalApproverName" value="${legalApproverName}" id="legalApproverName"  disabled />
							</#if>
							<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
								<div class="field-attachments popup-attachment">
								<#if (isAdminUser || isSynchroSystemOwner) || (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
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
							
							<#--<#if isAdminUser>
								<#if projectInitiation?? && projectInitiation.legalApprovalStatus?? >
									<@renderLegalApprovalStatusFields name='legalApprovalStatusPitBrief' value="${projectInitiation.legalApprovalStatus}"/>
								<#else>
									<@renderLegalApprovalStatusFields name='legalApprovalStatusPitBrief' value="-1"/>
								</#if>
							<#else>
								<#if projectInitiation?? && projectInitiation.legalApprovalStatus?? >
									<@renderLegalApprovalStatusFields name='legalApprovalStatusPit' value="${projectInitiation.legalApprovalStatus}" readonly=true/>
								<#else>
									<@renderLegalApprovalStatusFields name='legalApprovalStatusPit' value="-1" readonly=true/>
								</#if>
							</#if>-->
							<#if projectInitiation?? && projectInitiation.legalApprovalStatus?? >
								<@renderLegalApprovalStatusFields name='legalApprovalStatusPitBrief' value="${projectInitiation.legalApprovalStatus}"/>
							<#else>
								<@renderLegalApprovalStatusFields name='legalApprovalStatusPitBrief' value="-1"/>
							</#if>
							<span class="jive-error-message full-width" id="briefLegalApprovalStatusError" style="display:none">Please select TPD Status</span>
						</div>
					</div>
					
					
					<div class="form-select_div form-select_div_project_completion region-inner">
					
						<label>Date of Legal Approval</label>
						<#--<#if isAdminUser>
							<div>
							<@synchrodatetimepicker id="legalApprovalDateBrief" name="legalApprovalDateBrief" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder='Enter Legal Approval Date'/>
		

							</div>
						<#else>
						
							<div>
								<#if projectInitiation?? && projectInitiation.legalApprovalDate??>
								<input type="text"  name="legalApproverDatePit" value="${projectInitiation.legalApprovalDate?string('dd/MM/yyyy')}" id="legalApproverDatePit"  disabled />
								<#else>
									<input type="text"  name="legalApproverDatePit" value="" id="legalApproverDatePit"  disabled />
								</#if>
								
								
							</div>
						</#if>-->
						<div>
							<@synchrodatetimepicker id="legalApprovalDateBrief" name="legalApprovalDateBrief" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder='Enter Legal Approval Date'/>
		

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
						<#if (isAdminUser || isSynchroSystemOwner)>
							<textarea id="proposal" name="proposal" rows="10" cols="20" class="form-text-div">${proposalInitiation.proposal?default('')?html}</textarea>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
						
						<#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
						<textarea id="proposal" name="proposal" rows="10" cols="20" class="form-text-div">${proposalInitiation.proposal?default('')?html}</textarea>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
						<#else>
							<textarea id="proposal" name="proposal" rows="10" cols="20" disabled class="form-text-div">${proposalInitiation.proposal?default('')?html}</textarea>
							<@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
						</#if>
					</div>
					<textarea style="display:none;" id="proposalText" name="proposalText">${proposalInitiation.proposalText?default('')?html}</textarea>
					 <!-- ATTACHMENT DISPLAY STARTS -->
						<div class="field-attachments">
					   
					    <#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
							<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupPIT(${proposalID?c})" ></span> 
							
								<#if attachmentMap?? && attachmentMap.get(proposalID)?? >
									<div id="jive-file-list" class="jive-attachments">
										<#list attachmentMap.get(proposalID) as attachment>
											<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
												<span class="jive-icon-med jive-icon-attachment"></span>
																								
												<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID)  || (isAdminUser || isSynchroSystemOwner) >
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
					   
					   <#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() ||  project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId())>
							<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupPIT(${proposalID?c})" ></span> 
							
								<#if attachmentMap?? && attachmentMap.get(proposalID)?? >
									<div id="jive-file-list" class="jive-attachments">
										<#list attachmentMap.get(proposalID) as attachment>
											<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
												<span class="jive-icon-med jive-icon-attachment"></span>
												
												
												<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID)  || (isAdminUser || isSynchroSystemOwner) >
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
					   
					   <#elseif proposalInitiation?? && proposalInitiation.sendForApproval?? && proposalInitiation.sendForApproval==1 >
							<#if (isAdminUser || isSynchroSystemOwner)>
								<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupPIT(${proposalID?c})" ></span> 
							</#if>
							<#if attachmentMap?? && attachmentMap.get(proposalID)?? >
									<div id="jive-file-list" class="jive-attachments">
										<#list attachmentMap.get(proposalID) as attachment>
											<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
												<span class="jive-icon-med jive-icon-attachment"></span>
												<#if (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(proposalID)?size gt 1>
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${proposalID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
												<#elseif (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(proposalID)?size == 1>
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Proposal');"><@s.text name="global.remove" /></a>	
												</#if>
												<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
												${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
											</div>
										</#list>
									</div>
								</#if>
						<#elseif proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus gt 0)  >
	
							<#if (isAdminUser || isSynchroSystemOwner)>
								<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupPIT(${proposalID?c})" ></span> 
							</#if>
							<#if attachmentMap?? && attachmentMap.get(proposalID)?? >
								<div id="jive-file-list" class="jive-attachments">
									<#list attachmentMap.get(proposalID) as attachment>
										<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
										<span class="jive-icon-med jive-icon-attachment"></span>
										<#if (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(proposalID)?size gt 1>
											<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${proposalID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
										<#elseif (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(proposalID)?size == 1>
											<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Proposal');"><@s.text name="global.remove" /></a>	
										</#if>
										<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
										${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
										</div>
									</#list>
								</div>
							</#if>
					   <#else>
								
								<#if (isAdminUser || isSynchroSystemOwner)>
									<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopupPIT(${proposalID?c})" ></span> 
								</#if>
								<#if attachmentMap?? && attachmentMap.get(proposalID)?? >
									<div id="jive-file-list" class="jive-attachments">
										<#list attachmentMap.get(proposalID) as attachment>
											<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
												<span class="jive-icon-med jive-icon-attachment"></span>
												<#--<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser || isSynchroSystemOwner) >
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${proposalID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
												</#if>-->
												<#if (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(proposalID)?size gt 1>
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${proposalID?c}, '${attachment.name?replace("'", "")}');"><@s.text name="global.remove" /></a>
												<#elseif (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(proposalID)?size == 1>
													<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachmentMessage('Proposal');"><@s.text name="global.remove" /></a>	
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
				
				<#if proposalInitiation?? && proposalInitiation.legalSignOffRequired?? && proposalInitiation.legalSignOffRequired==1> 
				<#else>
				
					<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId())>
					
						<#if (isAdminUser || isSynchroSystemOwner)>
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
					
					<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
					
						<div class="form-select_div form-select_div_project_completion region-inner">
							
							<label>Legal Approver's Name</label>
							<div>
								<#if (isAdminUser || isSynchroSystemOwner) || (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId()) >
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
											

                                     
									</select> -->
									
									 <!-- check here offline or online....  -->
									 <#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId())>
								
								
								   
								<select data-placeholder="Select Legal Approver"  class="chosen-select" id = "proposalLegalApprover" name='proposalLegalApprover' >  
                                         
								
										<option value=""></option>
										<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
										<#assign endMarketApproversKeySet = endMarketLegalApprovers.keySet() />
										
										<#--
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
											
										-->
										
										 <#if proposalInitiation?? && proposalInitiation.proposalLegalApprover?? && proposalInitiation.proposalLegalApprover?int == 3767>
											   <#list endMarketApproversKeySet as key>
													<#if endMarkets.get(key?int)??>
														<optgroup label="${endMarkets.get(key?int)}">
														<#list endMarketLegalApprovers.get(key) as legalUser >
															<#if proposalInitiation?? && proposalInitiation.proposalLegalApprover?? && proposalInitiation.proposalLegalApprover == legalUser.ID>
																<option value="${legalUser.ID?c}" selected>${legalUser.name}</option>
															<#else>
																<option value="${legalUser.ID?c}">${legalUser.name}</option>
															</#if>
														</#list>
														</optgroup>
													</#if>	
											   </#list>
											<#elseif proposalInitiation?? && proposalInitiation.proposalLegalApprover?? && proposalInitiation.proposalLegalApprover?int gt  0>
												 <#list endMarketApproversKeySet as key>
													<#if endMarkets.get(key?int)??>
														<optgroup label="${endMarkets.get(key?int)}">
														<#list endMarketLegalApprovers.get(key) as legalUser >
															<#if legalUser.ID?int == 3767>
															<#else>
																<#if proposalInitiation?? && proposalInitiation.proposalLegalApprover?? && proposalInitiation.proposalLegalApprover == legalUser.ID>
																	<option value="${legalUser.ID?c}" selected>${legalUser.name}</option>
																<#else>
																	<option value="${legalUser.ID?c}">${legalUser.name}</option>
																</#if>
															</#if>
														</#list>
														</optgroup>
													</#if>	
											   </#list>
											
											<#else>
												  <#list endMarketApproversKeySet as key>
													<#if endMarkets.get(key?int)??>
														<optgroup label="${endMarkets.get(key?int)}">
														<#list endMarketLegalApprovers.get(key) as legalUser >
															<#if legalUser.ID?int == 3767>
															<#else>
																<#if proposalInitiation?? && proposalInitiation.proposalLegalApprover?? && proposalInitiation.proposalLegalApprover == legalUser.ID>
																	<option value="${legalUser.ID?c}" selected>${legalUser.name}</option>
																<#else>
																	<option value="${legalUser.ID?c}">${legalUser.name}</option>
																</#if>
															</#if>
														</#list>
														</optgroup>
													</#if>	
											   </#list>
											</#if>	
												
                                     
									</select>
								
								 <#else>
								    <#if proposalInitiation.getProposalLegalApproverOffline()??>
										<input type="text" id="proposalLegalApprover" placeholder="Select Legal Approver" name="proposalLegalApproverOffline"  value="${proposalInitiation.getProposalLegalApproverOffline()}"  />
										
									<#else>
										<input type="text" id="proposalLegalApprover" placeholder="Select Legal Approver" name="proposalLegalApproverOffline"  value=""  />
									</#if>
								
								
								 </#if>
									
									
								<#--	<#if proposalInitiation.getProposalLegalApproverOffline()??>
										<input type="text" id="proposalLegalApprover" placeholder="Select Legal Approver" name="proposalLegalApproverOffline"  value="${proposalInitiation.getProposalLegalApproverOffline()}"  />
										
									<#else>
										<input type="text" id="proposalLegalApprover" placeholder="Select Legal Approver" name="proposalLegalApproverOffline"  value=""  />
									</#if>	-->
									
									
									<span class="full-width  jive-error-message" id="proposalLegalApproverError" style="display:none">Please select Proposal Legal Approver's Name</span>
									
								<#else>
									<#if proposalInitiation?? && proposalInitiation.proposalLegalApprover??>
										<#assign legalApproverName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(proposalInitiation.proposalLegalApprover) />
									<#else>
										<#assign legalApproverName = '' />
									</#if>
									<input type="text"  name="legalApproverName" value="${legalApproverName}" id="legalApproverName"  disabled />
								</#if>
								
								<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
									<div class="field-attachments popup-attachment">
									<#if (isAdminUser || isSynchroSystemOwner) || (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId())>
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
													<#if (isAdminUser || isSynchroSystemOwner) && attachmentMap.get(proposalLegalApprovalID)?size == 1>
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
								
								<#--<#if isAdminUser>
									<#if proposalInitiation?? && proposalInitiation.legalApprovalStatus?? >
										<@renderLegalApprovalStatusFields name='legalApprovalStatusPitProposal' value="${proposalInitiation.legalApprovalStatus}" />  
									<#else>
										<@renderLegalApprovalStatusFields name='legalApprovalStatusPitProposal' value="-1" />
									</#if>
								<#else>
									<#if proposalInitiation?? && proposalInitiation.legalApprovalStatus?? >
										<@renderLegalApprovalStatusFields name='legalApprovalStatusPit' value="${proposalInitiation.legalApprovalStatus}" readonly=true/>
									<#else>
										<@renderLegalApprovalStatusFields name='legalApprovalStatusPit' value="-1" readonly=true/>
									</#if>
								</#if>-->
								
								<#if proposalInitiation?? && proposalInitiation.legalApprovalStatus?? >
									<@renderLegalApprovalStatusFields name='legalApprovalStatusPitProposal' value="${proposalInitiation.legalApprovalStatus}" />
								<#else>
									<@renderLegalApprovalStatusFields name='legalApprovalStatusPitProposal' value="-1" />
								</#if>
								<span class="full-width  jive-error-message" id="proposalLegalApprovalStatusError" style="display:none">Please select TPD Status</span>
								
							</div>
						</div>
						
						
						<div class="form-select_div form-select_div_project_completion region-inner">
						
							<label>Date of Legal Approval</label>
							<#--<#if isAdminUser>
								<div>
								<@synchrodatetimepicker id="legalApprovalDateProposal" name="legalApprovalDateProposal" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false placeholder='Enter Legal Approval Date'/>
			
								</div>
							<#else>
							<div>
								<#if proposalInitiation?? && proposalInitiation.legalApprovalDate??>
								<input type="text"  name="legalApproverDatePit" value="${proposalInitiation.legalApprovalDate?string('dd/MM/yyyy')}" id="legalApproverDatePit"  disabled />
								<#else>
									<input type="text"  name="legalApproverDatePit" value="" id="legalApproverDatePit"  disabled />
								</#if>
							</div>
							</#if>-->
							
							<div>
							<@synchrodatetimepicker id="legalApprovalDateProposal" name="legalApprovalDateProposal" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false dateCompareProposalLegal=true placeholder='Enter Legal Approval Date'/>
		
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
				
				
            
            <div class="pib_band_view">
            
                <div >
				
				<#if (isAdminUser || isSynchroSystemOwner) &&  project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId())>
					<a href="javascript:void(0);" onclick="return resetPIB();" class="popup-reset">Reset Brief</a>
					<a href="javascript:void(0);" onclick="return resetProposal();" class="popup-reset">Reset Proposal</a>
			
			</#if>
                    <input class="j-btn-callout" type="button" name="doPost" id="postButton" onclick="return validatePITFields();" value="Save" style="font-weight: bold;" />
                    
                </div>
            </div>
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" name="endMarketId" value="${endMarketId?c}">
			<input type="hidden" id="confirmProject" name="confirmProject" value="" />
			</div>
        </form>
    </div>
	</div>
</div>


</div>


</div>

</#if>
<!-- READ ONLY ELSE ENDS HERE-->

<form method="POST" name="cancelProj" id="cancelProj" action="/new-synchro/project-specs!cancelProject.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
</form>

<form method="POST" name="enableProj" id="enableProj" action="/new-synchro/project-specs!enableProject.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
</form>

<form method="POST" name="resetProposalForm" id="resetProposalForm" action="/new-synchro/project-specs!resetProposal.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
</form>

<form method="POST" name="resetPIBForm" id="resetPIBForm" action="/new-synchro/project-specs!resetPIB.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
</form>

</div>
  <script type="text/javascript">
     $j(document).ready(function() {
       // $j('.chosen-select').chosen();
       // $j('.chosen-select-deselect').chosen({ allow_single_deselect: true });
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
		  
		  
		  var pitPopupTrue = localStorage.getItem("pitPopupTrue");
		  if(pitPopupTrue){
		   openPITWindow();
		  }
		  $j('#pitWindow .close').click(function(){
			   localStorage.removeItem("pitPopupTrue");
		  });
		  $j('#pitWindow .jive-icon-attachment').click(function(){
			  pitPopupTrue = "true";
				localStorage.setItem("pitPopupTrue", pitPopupTrue);
		  });
		  $j('#pitWindow  #jive-file-list .j-remove-file').click(function(){
		   pitPopupTrue = "true";
		   localStorage.setItem("pitPopupTrue", pitPopupTrue);
		  });
		  
		  
		$j('#confirmProjectEnable').click(function(){
			$j('.confirm-msg').show();
			$j('#overViewDiv').hide();
			
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

    <#if projectInitiation.nonKantar?? && projectInitiation.nonKantar==0>
        nonKantarError.show();
        error = true;
    </#if>
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
 <#--  initializeUserPicker({$input:$j("#briefLegalApprover"),name:'briefLegalApprover',defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});-->



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
			startDate.parent().parent().find("span").text("Project Start date should be in dd/mm/yyyy format");
			error = true;
		}


		var endDate = $j("input[name=endDate1]");
		if(endDate.val() != null && $j.trim(endDate.val())=="")
		{
			if(!error)
			   {
				endDate.focus();
			endDate.parent().parent().find("span").show();
			error = true;
			}
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

  // done

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
 //done


	
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

 // done
	
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

	
	var endMarketFunding = $j('select[name="endMarketFunding"] option:selected').val();

 //alert(endMarketFunding);
if(endMarketFunding==-1)
	{
         
           $j("#endMarketFundingErrors").show();
		   error = true;
       }
     else if(endMarketFunding==1) 
       {
    
      var fundingMarkets = $j('select[name="fundingMarkets"] option:selected').val();
     
     
    if(fundingMarkets==undefined||fundingMarkets=="")
      {
         
       $j(".fundingMarketsError").show();
       error = true;

     }

  }

    
  var status  =  $j('select[name="legalApprovalStatusPitBrief"] option:selected').val();
  
         if(status==undefined)
           { 
           
            }
           else if(status=="")
            {
                 
                    error=true;
              $j("#statusError").show();

             }

  var LegalApprover  =  $j('select[name="briefLegalApprover"] option:selected').val();
  
     if(LegalApprover==undefined)
         {}
        else   if(LegalApprover=="" ||LegalApprover==null)
           {
            
            $j("#briefLegalApproverError").show();
             error=true;
          }

	 var briefLegalApproverOffline = $j("input[name=briefLegalApproverOffline]");
   

	  if(briefLegalApproverOffline.val()==undefined )
         {}
        else   if(briefLegalApproverOffline.val()=="" ||briefLegalApproverOffline.val()==null)
           {
            
            $j("#briefLegalApproverError").show();
             error=true;
			  
          }	 

		 

		

 var proposalLegalApproverOffline = $j("input[name=proposalLegalApproverOffline]");
   

	  if(proposalLegalApproverOffline.val()==undefined )
         {}
        else   if(proposalLegalApproverOffline.val()=="" ||proposalLegalApproverOffline.val()==null)
           {
            
            $j("#proposalLegalApproverError").show();
             error=true;
			  
          }		
		  
		  
		  
var  legalApprovalStaPitProposal  =  $j('select[name="legalApprovalStatusPitProposal"] option:selected').val();
       if(legalApprovalStaPitProposal==undefined)
           {}
              else  if(legalApprovalStaPitProposal=="" ||legalApprovalStaPitProposal==null)
              {
                      error=true; 
                $j("#statusProposalError").show();
              }
                
    
var  proposalLeApprover  =  $j('select[name="proposalLegalApprover"] option:selected').val();

      if(proposalLeApprover==undefined)
          {}
           else  if(proposalLeApprover=="" ||proposalLeApprover==null)
               { 
                 error=true; 
                 $j("#proposalLegalApproverError").show();

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
	var MultibrandText = $j("input[name=MultibrandText]"); 
	
	 if(MultibrandText.val()!="")
	 {
		 $j("#MultibrandTextError").hide();
		 
	 }
 });
function exportToPDFPIT(projectId)
{

    window.location.href = "/new-synchro/pib-details!exportToPDFPIT.jspa?projectID="+projectId;
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

    /* agencyContact2Section.hide();
          agencyContact2SectionOptional.hide();
          agencyContact3Section.hide();
          agencyContact3SectionOptional.hide(); */

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
function validatePIBFormFields()
{
	var datesError = false;
	datesError = validatePIBDates();
	if(!datesError)
	{
		return false;
	}
	
	var error = false;
console.log("validatePIBFormFields");
    showLoader('Please wait...');
    

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

    
	
	  var documentation = $j("textarea[name=documentation]");
	


  
    /*Project latest estimate check ends*/


   

    /* Starts : Validation of Text fields*/

  /*  if(documentation.val() != null && $j.trim(documentation.val())=="")
    {
        if(!error)
            documentation.focus();
        error = true;
        documentation.parent().parent().find('.jive-error-message').show();

    }
*/
	
    /* Ends : Validation of Text fields*/

     
	

    if(error)
	{
        hideLoader();
		return false;
	}
	else
	{
		var psForm = jQuery("#project-specs-form");
		$j("#confirmProject").val('confirmProject');
		psForm.submit();
	}
	return true;
}

$j("#startDate").click(function() {
    $j("#startDate_button").click();
});
$j("#endDate").click(function() {
    $j("#endDate_button").click();
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
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].ADD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_IN_PROGRESS.getId()}, "${kantarBtnClickText}", projName, ${projectID?c}, ${user.ID?c});
	</#if>
}

/* Initialization of Editor */
$j(document).ready(function () {
    
	initiateRTE('documentation', 2500, true);
	
});

</script>

<script type="text/javascript">

	<#--<#assign i18CustomText><@s.text name="logger.project.specs.view.text" /></#assign>	-->
	<#assign i18CustomText>View In Progress</#assign>
	var projName = "${project.name?js_string}";	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_IN_PROGRESS.getId()}, "${i18CustomText}", projName, ${projectID?c}, ${user.ID?c});
</script>

  <script src="${themePath}/js/synchro/project-cost-details.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script> 
  <script type="text/javascript">
  

  
  
  function continueProject()
  {
	var datesError = validatePIBDates();
	if(!datesError)
	{
		return false;
	}
	if($j("#deviationFromSM").val()=="-1")
	{
		$j("#deviationFromSMError").show();
		return false;
	}
	{
		/*dialog({
					title:"",
					html:"<p>It is mandatory to initiate the required waiver(s) before project confirmation.</p><p>Please initiate the required waiver(s) to continue.</p><p>It is mandatory to confirm if a methodology waiver is required in the project.</p><p>Please select Yes/No from the options given in ‘Will there be a methodology waiver required?'</p>",
					buttons:{
					"OK":function() {
						var psForm = jQuery("#project-specs-form");
						var error = validatePIBFormFields();
						if(error)
						{
							$j("#confirmProject").val('confirmProject');
							psForm.submit();
						}
						else
						{	
							return false;		
						}
						
					}
				},

				});*/
			$j("#confirmProject").val('confirmProject');
			openPITWindow();
				
	}
	
	
  }
  
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
	
	<#if (isAdminUser || isSynchroSystemOwner) && project.projectType?? && project.projectType==3>
	<#elseif (isAdminUser || isSynchroSystemOwner)>
	<#else>
		$j("select[name='endMarkets']").change(function() {
			/*	dialog({
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

					}); */
				//$j('select[name="endMarkets"] select').val(endMarket);
				//$j('#endMarkets_chosen span').text(endMarketText);
				
		});
	</#if>
	
	
	
	var fieldWorkStudy = $j('select[name="fieldWorkStudy"] option:selected').val();
	var fieldWorkStudyText = $j('select[name="fieldWorkStudy"] option:selected').text();
	
	
	$j("#fieldWorkStudy").change(function() {
			
		
			dialog({
					title:"",
					html:"<p>You are trying to change 'Is the project a fieldwork component of an above market study?'. This cannot be updated!</p><p>You need to cancel the project and setup it up as a new project on SynchrO with the correct information.</p>",
					buttons:{
					"OK":function() {
					
					
					
					$j('select[name="fieldWorkStudy"]').val(fieldWorkStudy);
					$j('#fieldWorkStudy_chosen span').text(fieldWorkStudyText);
						
						fieldWorkStudy=fieldWorkStudy;
						fieldWorkStudyText = fieldWorkStudyText;		
						
						$j('select[name="fieldWorkStudy"]').val(fieldWorkStudy).trigger('chosen:updated');
						return false;		
					}
				},
				
				closeActionButtonsClickHander:function() {
					
					$j('select[name="fieldWorkStudy"]').val(fieldWorkStudy);
					$j('#fieldWorkStudy_chosen span').text(fieldWorkStudyText);
						
						fieldWorkStudy=fieldWorkStudy;
						fieldWorkStudyText = fieldWorkStudyText;		
						
						$j('select[name="fieldWorkStudy"]').val(fieldWorkStudy).trigger('chosen:updated');
						return false;	
				}

			});
			orangeBtn();
			
	});
	
	function cancelProject()
  {
	
	{
		dialog({
					title:"",
					html:"<i class='warningErr positionSet'></i><p>Once you cancel the project, it will no longer be accessible.</p><p>Are you sure you want to cancel the project?</p>",
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
				relPos();
				
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
		 
		  $j( function() {
			   var arr = []; 
			 
			   <#list synchroUserNames as usname >
			   <#if usname??>
				 var userName = "${usname}";
				 arr.push(userName);
			   </#if>
			   </#list>
			  
			 $j("#projectManagerName").autocomplete({
				source: arr
			  }); 
			});
	});
<#if showAgencyWaiver?? && showAgencyWaiver=="yes">
	<#else>
		
		  $j("#agencyWaiverDiv").hide();
		  $j("#agencyWaiverDivPIT").hide();
		  
	</#if>
	
$j("#brand").change(function() {
			AddPITFieldTitle();
		
		});
		
		$j("#brandSpecificStudyType").change(function() {
			  AddPITFieldTitle();
		
		});
	
    // change 473	
	$j("#endMarketFunding").change(function() {
			

			var endMarketFunding = $j('#endMarketFunding').val();
              
			if(endMarketFunding==1)
			 {

               
				 $j("#fundingMarketsDiv").show();
                 $j("#endMarketFundingErrors").hide();   
                    
               }
		    	else if(endMarketFunding==2)
			     {
                   $j("#endMarketFundingErrors").hide(); 
                     $j("#fundingMarketsDiv").hide();
                  
                 }
                else if(endMarketFunding==-1)
                   {
                       $j("#fundingMarketsDiv").hide();
                       $j("#endMarketFundingErrors").hide();  
                   }
                  else
                  { }
               });


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


function dateCompare()
	{
		
		var legalApprovalDate = $j("#legalApprovalDateProposal").val();
		var legalApproverDatePit = $j("#legalApprovalDateBrief").val();
		if(!compareDate(legalApproverDatePit, legalApprovalDate))
		{
		  
		 dialog({
				title:"",
				html:"<i class='warningErr'></i><p>Please check the date you have selected.</p><p> Proposal Legal Approved Date cannot be prior to the date of approval on Brief.</p>",
				buttons:{
				"OK":function() {
					$j("#legalApprovalDateProposal").val('');
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
					html:"<i class='warningErr'></i><p>Please check the date you have selected.</p><p>Project end cannot be prior to the Project Start.</p>",
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
	
	
	
	
	$j('body').click(function() {
      var endDate = $j("#endDate").val();
	       if(endDate==null ||endDate=="")
		     {
			 }
			 else
			 {
			  
			  setTimeout(function(){
		 
		  if($j('body').find(".calendar").length==0)
		     {
			 dateCompareEnd()
			 
			 }
			 else
			 {}
		  
		  
		  }, 100);
        }
	});
	
	
	   function  checkVisiblty()
	   {
	     setTimeout(function(){
		 
		  if($j('body').find(".calendar").length==0)
		     {
			dateCompareEnd()
			 
			 }
			 else
			 {}	  
		  }, 100);
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
					html:"<i class='warningErr'></i><p>Please check the date you have selected.</p><p>Project end cannot be prior to the Project Start.</p>",
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
			else
			{
			
			  $j("#endDate").next().next("span").hide(); 
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
					html:"<i class='warningErr'></i><p>Please check the date you have selected.</p><p>Project end cannot be prior to the Project Start.</p>",
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
					html:"<i class='warningErr'></i><p>Please check the date you have selected.</p><p>Project end cannot be prior to the Project Start.</p>",
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
	
	function validatePIBDates()
	{
		
		var error = false;
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
			startDate.parent().parent().find("span").text("Project Start date should be in dd/mm/yyyy format");
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
			startDate.parent().parent().find("span").text("Project Start date should be less than end date");
			error = true;
		}
		if(error)
		{	
			return false;
		}
		else
		{
			return true;
		}
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

//  new change
   $j("#legalApproverName").change(  function()
   {
  
   var briefLegalApproverOffline = $j("input[name=briefLegalApproverOffline]");
     if(legalApproverName==undefined)
         {}
        else   if(briefLegalApproverOffline.val()=="" ||briefLegalApproverOffline.val()==null)
           {}
           
		  else
		  {
		   $j("#briefLegalApproverError").hide();
		  }
   
   });
	  
	  
	  $j("#proposalLegalApprover").change(function ()
	  {
	   var proposalLegalApproverOffline = $j("input[name=proposalLegalApproverOffline]");
   

	    if(proposalLegalApproverOffline.val()==undefined )
         {}
        else   if(proposalLegalApproverOffline.val()=="" ||proposalLegalApproverOffline.val()==null)
           {}
		   else
		   {
		   $j("#proposalLegalApproverError").hide();
		   }
           	
	  
	  
	  });
	  
	 	
		if(legalApproverName==undefined)
         {}
        else   if(briefLegalApproverOffline.val()=="" ||briefLegalApproverOffline.val()==null)
           {}
           
		  else
		  {
		   $j("#briefLegalApproverError").hide();
		  }
		
	  
	  
  </script>
  

  
  
  
  
  
  
