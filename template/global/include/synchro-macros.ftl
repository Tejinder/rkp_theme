<#include "/template/global/include/jive-macros.ftl" />

<script type="text/javascript">

    function geoSpreadChanged(currentInput, geoSpreadName){

        var geoSpreadUrban = jQuery("input[name=geoSpreadUrban]");
        var geoSpreadNational = jQuery("input[name=geoSpreadNational]");

        if((geoSpreadName.id=="geoSpreadUrban" && geoSpreadNational.val()=="false") || (geoSpreadName.id=="geoSpreadNational" && geoSpreadUrban.val()=="false"))
        {

            jQuery('#'+geoSpreadName.id).val(currentInput.checked);
            if(geoSpreadName.id=="geoSpreadUrban")
            {
                if(!currentInput.checked)
                {
                    jQuery("#cities").hide();
                }
                else
                {
                    jQuery("#cities").show();
                }
            }
        }
        else
        {
            if(geoSpreadName.id=="geoSpreadUrban")
            {

                jQuery('input:checkbox[name=geoSpreadUrban_display]').attr('checked',false);

            }
            else
            {

                jQuery('input:checkbox[name=geoSpreadNational_display]').attr('checked',false);
            }
        }
    }
    function geoSpreadRadioChanged(currentInput, geoSpreadName){


        if(jQuery("input[type='radio'][name='geoSpread']:checked").val()=="geoSpreadUrban")
        {
            jQuery("#cities").show();
        }
        else
        {
            jQuery("#cities").hide();
        }
    }
    function geoSpreadRadioChangedMultiMarket(currentInput, geoSpreadName, selectedIndex){
        var radioBoxSelected = "geoSpread_"+selectedIndex;

        if(jQuery("input[type='radio'][name="+radioBoxSelected+"]:checked").val()=="geoSpreadUrban")
        {

            jQuery("#cities_"+selectedIndex).show();
        }
        else
        {

            jQuery("#cities_"+selectedIndex).hide();
        }
    }
    function reportingChanged(currentInput, geoSpreadName){

        jQuery('#'+geoSpreadName.id).val(currentInput.checked);

    }
    function pibLegalCheckbox(currentInput, legalCheckBox){

        jQuery('#'+legalCheckBox.id).val(currentInput.checked);
        var legalApprovalRcvd = jQuery("input[name=legalApprovalRcvd]");
        var legalApprovalNotReq = jQuery("input[name=legalApprovalNotReq]");
        if(legalCheckBox.id=="legalApprovalRcvd" && currentInput.checked)
        {
            if(legalApprovalNotReq.val()=="true")
            {
                dialog({title:"Message",html:"Both Legal Approval for PIB received from and Legal Approval not required on PIB Check boxes should not be checked"});
                jQuery('input:checkbox[name=legalApprovalRcvd_display]').attr('checked',false);
                jQuery("input[name=legalApprovalRcvd]").val("false");

            }

        }
        if(legalCheckBox.id=="legalApprovalNotReq" && currentInput.checked)
        {
            if(legalApprovalRcvd.val()=="true")
            {
                dialog({title:"Message",html:"Both Legal Approval for PIB received from and Legal Approval not required on PIB Check boxes should not be checked"});
                jQuery('input:checkbox[name=legalApprovalNotReq_display]').attr('checked',false);
                jQuery("input[name=legalApprovalNotReq]").val("false");
            }

        }
    }

</script>

<#macro renderProjectStagesTab projectID=-1 stageId=1>
<ul class="project_name_menu">
    <li><a href="/synchro/pib-details!input.jspa?projectID=${projectID?c}" <#if stageId == 1>class="active"</#if>>PIB</a></li>
    <#assign proposalStage = statics['com.grail.synchro.util.SynchroPermHelper'].canViewStage(projectID,2) />
    <#if proposalStage>
        <li><a href="/synchro/proposal-details!input.jspa?projectID=${projectID?c}" <#if stageId == 2>class="active"</#if>>Proposal</a></li>
    <#else>
        <li class="disable-menu">Proposal</li>
    </#if>
    <#assign projSpecsStage = statics['com.grail.synchro.util.SynchroPermHelper'].canViewStage(projectID,3) />
    <#if projSpecsStage>
        <li><a href="/synchro/project-specs!input.jspa?projectID=${projectID?c}" <#if stageId == 3>class="active"</#if>>Project Specs</a></li>
    <#else>
        <li class="disable-menu">Project Specs</li>
    </#if>
    <#assign repSummaryStage = statics['com.grail.synchro.util.SynchroPermHelper'].canViewStage(projectID,4) />
    <#if repSummaryStage>
        <li><a href="/synchro/report-summary!input.jspa?projectID=${projectID?c}" <#if stageId == 4>class="active"</#if>>Report/Summary</a></li>
    <#else>
        <li class="disable-menu">Report/Summary</li>
    </#if>
    <#assign projectEvaluationStage = statics['com.grail.synchro.util.SynchroPermHelper'].canViewStage(projectID,5) />
    <#if projectEvaluationStage>
        <li><a href="/synchro/project-eval!input.jspa?projectID=${projectID?c}" <#if stageId == 5>class="active"</#if>>Project Evaluation</a></li>
    <#else>
        <li class="disable-menu">Project Evaluation</li>
    </#if>
    <#assign canEdit = statics['com.grail.synchro.util.SynchroPermHelper'].canEditproject(user, projectID) />
    <#if canEdit?? && canEdit>
        <li><a href="/synchro/project-status!input.jspa?projectID=${projectID?c}" <#if stageId == 7>class="active"</#if>>Change Project Status</a></li>
    </#if>
</ul>
</#macro>




<#macro renderProjectActionStages stageToDoList stageId='' projectID=-1 disable=false>
<script type="text/javascript">
function approve(stageId, approve,recipients,subject,body,notificationTabId)
{
    if(stageId  == 4) {
        <#if project.multiMarket?? && project.multiMarket>
           <#-- <#if allProjectSpecsArroved?? && !allProjectSpecsArroved>
                dialog({title:"Message",html:"Project Spec(s) for one or more end markets is not approved. You will be able to approve the Report as soon as approval is received on Project Specs."});
                return false;
            </#if >

            <#if legalApprovalRequired?? && legalApprovalRequired>
                if(jQuery("#legalApproval").val() == "false" || jQuery("#legalApprover").val() == "")
                {
                    <#if isAboveMarket>
                        dialog({title:"Message",html:"Please provide legal approval details to be able to approve."});
                        return false;
                    <#elseif ((reportSummaryInitiation?? && reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport) || (reportSummaryInitiation?? && reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS)) >
                        dialog({title:"Message",html:"Please provide legal approval details to be able to approve."});
                        return false;
                    </#if>
                }
          
          
            <#else>
                if(jQuery("#legalApproval").val() == "false" || jQuery("#legalApprover").val() == "")
                {
                    <#if isAboveMarket>
                        dialog({title:"Message",html:"Please provide legal approval details to be able to approve."});
                        return false;
                    <#elseif ((reportSummaryInitiation?? && reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport) || (reportSummaryInitiation?? && reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS)) >
                        dialog({title:"Message",html:"Please provide legal approval details to be able to approve."});
                        return false;
                    </#if>
                }
           
            </#if>-->
            
            if(jQuery("#legalApproval").val() == "false") {
                dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
            }
            if(jQuery("#legalApprover").val() == "") {
                dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
            }
           
            <#if reportSummaryInitiation?? && reportSummaryInitiation.fullReport?? && !reportSummaryInitiation.fullReport >
        	    dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
	        </#if>
	        <#if reportSummaryInitiation?? && reportSummaryInitiation.summaryForIRIS?? && !reportSummaryInitiation.summaryForIRIS >
        	    dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
	        </#if>

        <#else>
            if(jQuery("#legalApproval").val() == "false") {
                dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
            }
            if(jQuery("#legalApprover").val() == "") {
                dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
            }
           
            <#if reportSummaryInitiation?? && reportSummaryInitiation.fullReport?? && !reportSummaryInitiation.fullReport >
        	    dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
	        </#if>
	        <#if reportSummaryInitiation?? && reportSummaryInitiation.summaryForIRIS?? && !reportSummaryInitiation.summaryForIRIS >
        	    dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
	        </#if>
        </#if>
    }
    if(stageId  == 3) {

        <#if project.multiMarket?? && project.multiMarket  >

          <#--  if(jQuery("#legalApprovalStimulus").val() == "false" || jQuery("#legalApprovalScreener").val() == "false" || jQuery("#legalApprovalCCCA").val() == "false" || jQuery("#legalApprovalQuestionnaire").val() == "false" || jQuery("#legalApprovalDG").val() == "false" || jQuery("#legalApproverStimulus").val() == "" || jQuery("#legalApproverScreener").val() == "" || jQuery("#legalApproverCCCA").val() == "" || jQuery("#legalApproverQuestionnaire").val() == "" || jQuery("#legalApproverDG").val() == "")
            {
                <#if isAboveMarket>
                    dialog({title:"Message",html:"Please capture Legal Approval to be able to approve. In Case legal approval is not relevant for a specific document, select the check-box and enter 'Not Applicable' in the corresponding text-box."});
                    return false;
                <#else>
                    dialog({title:"Message",html:"Please capture Legal Approval to be able to approve. In Case legal approval is not relevant for a specific document, select the check-box and enter 'Not Applicable' in the corresponding text-box."});
                    return false;
                </#if>
            }
	-->
        <#--
              <#if allEndMarketLegalApprovalSaved?? && allEndMarketLegalApprovalSaved >
                   if(jQuery("#legalApprovalStimulus").val() == "false" || jQuery("#legalApprovalScreener").val() == "false" || jQuery("#legalApprovalCCCA").val() == "false" || jQuery("#legalApprovalQuestionnaire").val() == "false" || jQuery("#legalApprovalDG").val() == "false" || jQuery("#legalApproverStimulus").val() == "" || jQuery("#legalApproverScreener").val() == "" || jQuery("#legalApproverCCCA").val() == "" || jQuery("#legalApproverQuestionnaire").val() == "" || jQuery("#legalApproverDG").val() == "")
                   {
                      <#if isAboveMarket>
                          dialog({title:"Message",html:"Please capture Legal Approval to be able to approve. In Case legal approval is not relevant for a specific document, select the check-box and enter 'Not Applicable' in the corresponding text-box. Legal Approval is pending at <br> - Above Market <br> ${legalApproverEndMarkets?default('')}"});
                          return false;
                      <#else>
                          dialog({title:"Message",html:"Please capture Legal Approval to be able to approve. In Case legal approval is not relevant for a specific document, select the check-box and enter 'Not Applicable' in the corresponding text-box. Legal Approval is pending at <br> - ${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(endMarketId?int)} ${legalApproverEndMarkets?default('')}"});
                          return false;
                      </#if>
                   }
              <#else>
                  if(jQuery("#legalApprovalStimulus").val() == "false" || jQuery("#legalApprovalScreener").val() == "false" || jQuery("#legalApprovalCCCA").val() == "false" || jQuery("#legalApprovalQuestionnaire").val() == "false" || jQuery("#legalApprovalDG").val() == "false" || jQuery("#legalApproverStimulus").val() == "" || jQuery("#legalApproverScreener").val() == "" || jQuery("#legalApproverCCCA").val() == "" || jQuery("#legalApproverQuestionnaire").val() == "" || jQuery("#legalApproverDG").val() == "")
                  {
                      <#if isAboveMarket>
                          dialog({title:"Message",html:"Please capture Legal Approval to be able to approve. In Case legal approval is not relevant for a specific document, select the check-box and enter 'Not Applicable' in the corresponding text-box. Legal Approval is pending at <br> - Above Market <br> ${legalApproverEndMarkets?default('')}"});
                          return false;
                      <#else>
                          dialog({title:"Message",html:"Please capture Legal Approval to be able to approve. In Case legal approval is not relevant for a specific document, select the check-box and enter 'Not Applicable' in the corresponding text-box. Legal Approval is pending at <br> - ${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(endMarketId?int)} ${legalApproverEndMarkets?default('')}"});
                          return false;
                      </#if>
                  }
                  else
                  {
                      dialog({title:"Message",html:"Please capture Legal Approval to be able to approve. In Case legal approval is not relevant for a specific document, select the check-box and enter 'Not Applicable' in the corresponding text-box. Legal Approval is pending at <br> ${legalApproverEndMarkets?default('')}"});
                      return false;
                  }
              </#if>
              -->
        <#else>

          <#--  if(jQuery("#legalApprovalStimulus").val() == "false" || jQuery("#legalApprovalScreener").val() == "false" || jQuery("#legalApprovalCCCA").val() == "false" || jQuery("#legalApprovalQuestionnaire").val() == "false" || jQuery("#legalApprovalDG").val() == "false") {
                dialog({title:"Message",html:"Please capture Legal Approval to be able to approve. In Case legal approval is not relevant for a specific document, select the check-box and enter 'Not Applicable' in the corresponding text-box."});
                return false;
            }

            if(jQuery("#legalApproverStimulus").val() == "" || jQuery("#legalApproverScreener").val() == "" || jQuery("#legalApproverCCCA").val() == "" || jQuery("#legalApproverQuestionnaire").val() == "" || jQuery("#legalApproverDG").val() == "") {
                dialog({title:"Message",html:"Please capture Legal Approval to be able to approve. In Case legal approval is not relevant for a specific document, select the check-box and enter 'Not Applicable' in the corresponding text-box."});
                return false;
            }
            -->
        </#if>

    }
    dialog({
        title:"Message",
        html:"Are you sure you want to approve? You will not be able to undo this action later.",
        buttons:{
            "OK":function() {
                jQuery("#approve").val(approve);
                sendNotification(recipients,subject.replace(/"""/g ,"'"),body.replace(/"""/g ,"'"),notificationTabId);
            },
            "Cancel":function() {
                closeDialog();
            }
        }
    });
//    var proceed = confirm("Are you sure you want to approve? You will not be able to undo this action later.");
//    if(proceed)
//    {
//        jQuery("#approve").val(approve);
//        sendNotification(recipients,subject.replace(/"""/g ,"'"),body.replace(/"""/g ,"'"),notificationTabId);
//        //return true;
//    }
    return false;

}
function approveNotEnable(bean)
{

    dialog({title:"Message",html:"Please select the Legal Approval From checkbox before proceeding for approval."});
    return false;

}
function sendNotificationFormat(recipients,subject,body,notificationTabId)
{

    if(notificationTabId == 1) {

        <#if project.multiMarket?? && project.multiMarket  >

         <#--   <#if allEndMarketLegalApprovalSaved?? && allEndMarketLegalApprovalSaved  >

                if(jQuery("#legalApprovalRcvd").val() == "false" && jQuery("#legalApprovalNotReq").val() == "false") {
                    dialog({title:"Message",html:"Please provide legal approval details in order to be able to send PIB to an agency. Legal Approval is pending at <br> - Above Market"});
                    return false;
                }

                if(jQuery("#legalApprover").val() == "") {
                    if(jQuery("#legalApprovalRcvd").val() == "true" && jQuery("#legalApprovalNotReq").val() == "false")
                    {
                        dialog({title:"Message",html:"Please provide legal approval details in order to be able to send PIB to an agency. Legal Approval is pending at <br> - Above Market"});
                        return false;
                    }
                }
            <#else>
            
                if(jQuery("#legalApprovalRcvd").val() == "false" && jQuery("#legalApprovalNotReq").val() == "false") {
                    dialog({title:"Message",html:"Please provide legal approval details in order to be able to send PIB to an agency. Legal Approval is pending at <br> - Above Market <br> ${legalApproverEndMarkets?default('')}"});
                    return false;
                }


                if(jQuery("#legalApprover").val() == "") {
                    if(jQuery("#legalApprovalRcvd").val() == "true" && jQuery("#legalApprovalNotReq").val() == "false")
                    {
                        dialog({title:"Message",html:"Please provide legal approval details in order to be able to send PIB to an agency. Legal Approval is pending at <br> - Above Market <br> ${legalApproverEndMarkets?default('')}"});
                        return false;
                    }
                }
                dialog({title:"Message",html:"Please provide legal approval details in order to be able to send PIB to an agency. Legal Approval is pending at <br> ${legalApproverEndMarkets?default('')}"});
                return false;

            </#if>
			-->
			
			if(jQuery("#agencyContact1").val()=="" && jQuery("#agencyUserBATContact1").val()=="")
			{
				dialog({title:"Message",html:"Please provide Agency details in order to be able to move to next stage."});
                return false;
			}

        <#else>
			if(jQuery("#agencyContact1").val()=="" && jQuery("#agencyUserBATContact1").val()=="")
			{
				dialog({title:"Message",html:"Please provide Agency details in order to be able to move to next stage."});
                return false;
			}
			
            <#--if(jQuery("#legalApprovalRcvd").val() == "false" && jQuery("#legalApprovalNotReq").val() == "false") {
                dialog({title:"Message",html:"Please provide legal approval details in order to be able to send PIB to an agency."});
                return false;
            }

            if(jQuery("#legalApprover").val() == "") {
                if(jQuery("#legalApprovalRcvd").val() == "true" && jQuery("#legalApprovalNotReq").val() == "false")
                {
                    dialog({title:"Message",html:"Please provide legal approval details in order to be able to send PIB to an agency."});
                    return false;
                }
            }-->
        </#if>

       <#-- jQuery("#jive-error-box").hide();
        if(pibFormErrors()) {
            jQuery("#jive-error-box").show();
            return false;
        }-->
    }
    jQuery(".MultiFile-remove").each(function(index) {
        jQuery(this).click();
    });

    return sendNotification(recipients,subject.replace(/"""/g ,"'"),body.replace(/"""/g ,"'"),notificationTabId);
}

jQuery(document).ready(function()
{
	jQuery("#pibmovetonextstage").click(function(event) 
	{
		moveToNextStage('1');
	});
	jQuery("#psmovetonextstage").click(function(event) 
	{
		moveToNextStage('3');
	});
	jQuery("#rsmovetonextstage").click(function(event) 
	{
		moveToNextStage('4');
	});
});
function moveToNextStage(notificationTabId)
{

    if(notificationTabId == 1) 
    {
        <#if project.multiMarket?? && project.multiMarket  >
			if(jQuery("#agencyContact1").val()=="" && jQuery("#agencyUserBATContact1").val()=="")
			{
				dialog({title:"Message",html:"Please provide a BAT Contact who will run the process."});
                return false;
			}
			FORM_DATA_PERSIST_HANDLER.handle({parentForm:jQuery("#pib-form"),form:jQuery("#moveToNextStageForm"), projectID:${projectID}});
			var mNSForm = jQuery("#moveToNextStageForm");
            mNSForm.submit();
        <#else>
			if(jQuery("#agencyContact1").val()=="" && jQuery("#agencyUserBATContact1").val()=="")
			{
				dialog({title:"Message",html:"Please provide a BAT Contact who will run the process."});
                return false;
			}
			
			FORM_DATA_PERSIST_HANDLER.handle({parentForm:jQuery("#pib-form"),form:jQuery("#moveToNextStageForm"), projectID:${projectID}})
			var mNSForm = jQuery("#moveToNextStageForm");
            mNSForm.submit();
        </#if>
    }
    if(notificationTabId == 3) 
    {
    	
		var mNSForm = jQuery("#moveToNextStageForm");
        mNSForm.submit();
    }
    if(notificationTabId == 4) 
    {
    	
    	<#if project.multiMarket?? && project.multiMarket>
            if(jQuery("#legalApproval").val() == "false") {
                dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
            }
            if(jQuery("#legalApprover").val() == "") {
                dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
            }
           
            <#if reportSummaryInitiation?? && reportSummaryInitiation.fullReport?? && !reportSummaryInitiation.fullReport >
        	    dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
	        </#if>
	        <#if reportSummaryInitiation?? && reportSummaryInitiation.summaryForIRIS?? && !reportSummaryInitiation.summaryForIRIS >
        	    dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
	        </#if>
	        
	        if(jQuery("#irisSummaryRequired").is(":checked"))
            {
	      	 	<#if attachmentMap?? && attachmentMap.get(summaryForIRISID)?? && (attachmentMap.get(summaryForIRISID)?size>0) >
	      	 	<#else>
	      	 		 dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                	 return false;
	      	 	</#if>
	      	}
	      	else if(jQuery("#irisSummaryNotRequired").is(":checked") && jQuery("#irisOptionRationale").val()=="")
	      	{
	      	 	dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
	      	}

        <#else>
            if(jQuery("#legalApproval").val() == "false") {
                dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
            }
            if(jQuery("#legalApprover").val() == "") {
                dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
            }
           
            <#if reportSummaryInitiation?? && reportSummaryInitiation.fullReport?? && !reportSummaryInitiation.fullReport >
        	    dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
	        </#if>
	        <#if reportSummaryInitiation?? && reportSummaryInitiation.summaryForIRIS?? && !reportSummaryInitiation.summaryForIRIS >
        	    dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
	        </#if>

			
	        if(jQuery("#irisSummaryRequired").is(":checked"))
            {
	      	 	<#if attachmentMap?? && attachmentMap.get(summaryForIRISID)?? && (attachmentMap.get(summaryForIRISID)?size>0) >
	      	 	<#else>
	      	 		 dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                	 return false;
	      	 	</#if>
	      	}
	      	else if(jQuery("#irisSummaryNotRequired").is(":checked") && jQuery("#irisOptionRationale").val()=="")
	      	{
	      	 	dialog({title:"Message",html:"Please attach full report,IRIS Summary and advise legal approval to approve.In case, full report is not applicable for your project, please contact assistance@batinsights.com"});
                return false;
	      	}

        </#if>
    	var mNSForm = jQuery("#moveToNextStageForm");
        mNSForm.submit();
    }
}

function pibFormErrors() {
    var error = false;
    var description = jQuery("textarea[name=description]");
    var businessDescription = jQuery("textarea[name=bizQuestion]");
    var researchObjective = jQuery("textarea[name=researchObjective]");
    var actionStandard = jQuery("textarea[name=actionStandard]");
    var researchDesign = jQuery("textarea[name=researchDesign]");
    var sampleProfile = jQuery("textarea[name=sampleProfile]");
    var stimulusMaterial = jQuery("textarea[name=stimulusMaterial]");
    var latestEstimate = jQuery("input[name=latestEstimate-display]");
    var latestEstimateType = jQuery("#latestEstimateType");
    var globalLegalContact = jQuery("input[name=globalLegalContact]");

    var agencyContact1 = jQuery("input[name=agencyContact1]");
    var agencyContact2 = jQuery("input[name=agencyContact2]");
    var agencyContact3 = jQuery("input[name=agencyContact3]");

    if(description.val() != null && jQuery.trim(description.val())=="") {
        description.next().show();
        error = true;
    } else {
        description.next().hide();
    }

    if(businessDescription.val() != null && jQuery.trim(businessDescription.val())=="")
    {
        //   businessDescription.focus();
    <#--<#if attachmentMap?? && attachmentMap.get(bussinessQuestionID)?? >-->
    <#--<#else>-->
        var attachments = jQuery(jQuery(businessDescription).parent().next().next()[0]).find(".jive-attachments");
        if(attachments && attachments.length <= 0) {
            businessDescription.next().show();
            error = true;
        } else {
            businessDescription.next().hide();
        }

    <#--</#if>-->
    } else {
        businessDescription.next().hide();
    }



    if(latestEstimate.val() != null && jQuery.trim(latestEstimate.val())=="")
    {
        //    latestEstimate.focus();
        latestEstimate.parent().find("span:first").show();
        error = true;
    } else {
        latestEstimate.parent().find("span:first").hide();
    }


    if(researchObjective.val() != null && jQuery.trim(researchObjective.val())=="")
    {
        //   researchObjective.focus();
    <#--<#if attachmentMap?? && attachmentMap.get(researchObjectiveID)?? >-->
    <#--<#else>-->
        var attachments = jQuery(jQuery(researchObjective).parent().next().next()[0]).find(".jive-attachments");
        if(attachments && attachments.length <= 0) {
            researchObjective.next().show();
            error = true;
        } else {
            researchObjective.next().hide();
        }
    <#--</#if>-->
    } else {
        researchObjective.next().hide();
    }
    if(actionStandard.val() != null && jQuery.trim(actionStandard.val())=="")
    {
        //   actionStandard.focus();
    <#--<#if attachmentMap?? && attachmentMap.get(actionStandardID)?? >-->
    <#--<#else>-->
        var attachments = jQuery(jQuery(actionStandard).parent().next().next()[0]).find(".jive-attachments");
        if(attachments && attachments.length <= 0) {
            actionStandard.next().show();
            error = true;
        } else {
            actionStandard.next().hide();
        }
    <#--</#if>-->
    } else {
        actionStandard.next().next().hide();
    }
    if(researchDesign.val() != null && jQuery.trim(researchDesign.val())=="")
    {
        //    researchDesign.focus();
    <#--<#if attachmentMap?? && attachmentMap.get(researchDesignID)?? >-->
    <#--<#else>-->
        var attachments = jQuery(jQuery(researchDesign).parent().next().next()[0]).find(".jive-attachments");
        if(attachments && attachments.length <= 0) {
            researchDesign.next().show();
            error = true;
        } else {
            researchDesign.hide();
        }
    <#--</#if>-->
    } else {
        researchDesign.next().hide();
    }
    if(sampleProfile.val() != null && jQuery.trim(sampleProfile.val())=="")
    {
        //   sampleProfile.focus();
    <#--<#if attachmentMap?? && attachmentMap.get(sampleProfileID)?? >-->
    <#--<#else>-->
        var attachments = jQuery(jQuery(sampleProfile).parent().next().next()[0]).find(".jive-attachments");
        if(attachments && attachments.length <= 0) {
            sampleProfile.next().show();
            error = true;
        } else {
            sampleProfile.next().hide();
        }
    <#--</#if>-->
    } else {
        sampleProfile.next().hide();
    }
    if(stimulusMaterial.val() != null && jQuery.trim(stimulusMaterial.val())=="")
    {
        //   stimulusMaterial.focus();
    <#--<#if attachmentMap?? && attachmentMap.get(stimulusMaterialID)?? >-->
    <#--<#else>-->
        var attachments = jQuery(jQuery(stimulusMaterial).parent().next().next()[0]).find(".jive-attachments");
        if(attachments && attachments.length <= 0) {
            stimulusMaterial.next().show();
            error = true;
        } else {
            stimulusMaterial.next().hide();
        }
    <#--</#if>-->
    } else {
        stimulusMaterial.next().hide();
    }
    var reportRequirementSelected = false;
    jQuery(".pib-report-requirement").find('input[type="checkbox"]:checked').each(function(){
        reportRequirementSelected = true;
    });

    if(!reportRequirementSelected)
    {
        //   jQuery("#topLinePresentation_display").focus();
        jQuery(".pib-report-requirement").find("span").show();
        error = true;
    } else {
        jQuery(".pib-report-requirement").find("span").hide();
    }

    var stimuliDate = jQuery("input[name=stimuliDate]");
    if(jQuery.trim(stimuliDate.val())=="")
    {
        //	stimuliDate.focus();
        stimuliDate.parent().find("span").show();
        stimuliDate.parent().find("span").text("Please enter Stimuli Date");
        error = true;
    } else {
        stimuliDate.parent().find("span").hide();
    }
    if(globalLegalContact.val() != null && jQuery.trim(globalLegalContact.val())=="")
    {

        jQuery("#globalLegalContactError").show();
        error = true;
    } else {
        jQuery("#globalLegalContactError").hide();
    }

    if(agencyContact1.val() != null && jQuery.trim(agencyContact1.val())=="" && agencyContact2.val() != null && jQuery.trim(agencyContact2.val())=="" && agencyContact3.val() != null && jQuery.trim(agencyContact3.val())=="")
    {
        if(agencyContact1.val()==undefined && agencyContact2.val()==undefined && agencyContact3.val()==undefined)
        {
            jQuery("#agencyContactError").show();
            error = true;
        } else {
            jQuery("#agencyContactError").hide();
        }
        if(agencyContact1.val() != null && jQuery.trim(agencyContact1.val())=="" && agencyContact2.val() != null && jQuery.trim(agencyContact2.val())=="" && agencyContact3.val() != null && jQuery.trim(agencyContact3.val())=="")
        {
            jQuery("#agencyContactError").show();
            error = true;
        } else {
            jQuery("#agencyContactError").hide();
        }
    } else {
        jQuery("#agencyContactError").hide();
    }
    return error;
}
function sendNotification(recipients,subject,body,notificationTabId)
{

    jQuery("#emailNotification").lightbox_me({centered:true,closeEsc:false,overlayCSS:{background: 'black', opacity: .7}});

    jQuery("#recipients").val(recipients);
    jQuery("#subject").val(subject);

    if(window.location.href.indexOf("https://preportal.bat.net") > -1) {

        body = body.replace(/\/synchro_rkp/g,"https://preportal.bat.net");
        body = body.replace(/\preportal.bat.net/g,"irkpinsightstest.batgen.com");
    }
    if(window.location.href.indexOf("https://portal.bat.net") > -1) {

        body = body.replace(/\/synchro_rkp/g,"https://portal.bat.net");
        body = body.replace(/\portal.bat.net/g,"irkpinsights.batgen.com");
    }
    jQuery("#messageBodyDiv").html(body);

    jQuery("#projectID").val('${projectID}');
    jQuery("#notificationTabId").val(notificationTabId);
    jQuery("#stageId").val('${stageId}');

    jQuery(".MultiFile-remove").each(function(index) {
        jQuery(this).click();
    });

    return false;
}
function approveScreener(projectId)
{
    dialog({
        title:"Message",
        html:"Are you sure you want to Approve? You will not be able to undo this action later.",
        buttons:{
            "OK":function() {
                window.location.href = "/synchro/project-specs!approveScreener.jspa?projectID="+projectId;
            },
            "Cancel":function() {
                closeDialog();
            }
        }
    });
//    var proceed = confirm("Are you sure you want to Approve? You will not be able to undo this action later.");
//    if(proceed)
//    {
//        window.location.href = "/synchro/project-specs!approveScreener.jspa?projectID="+projectId;
//    }
    return false;
}
function rejectScreener(projectId)
{
    dialog({
        title:"Message",
        html:"Are you sure you want to Reject? You will not be able to undo this action later.",
        buttons:{
            "OK":function() {
                window.location.href = "/synchro/project-specs!rejectScreener.jspa?projectID="+projectId;
            },
            "Cancel":function() {
                closeDialog();
            }
        }
    });
//    var proceed = confirm("Are you sure you want to Reject? You will not be able to undo this action later.");
//    if(proceed)
//    {
//        window.location.href = "/synchro/project-specs!rejectScreener.jspa?projectID="+projectId;
//    }
    return false;
}
function approveQDG(projectId)
{
    dialog({
        title:"Message",
        html:"Are you sure you want to Approve? You will not be able to undo this action later.",
        buttons:{
            "OK":function() {
                window.location.href = "/synchro/project-specs!approveQDG.jspa?projectID="+projectId
            },
            "Cancel":function() {
                closeDialog();
            }
        }
    });
//    var proceed = confirm("Are you sure you want to Approve? You will not be able to undo this action later.");
//    if(proceed)
//    {
//        window.location.href = "/synchro/project-specs!approveQDG.jspa?projectID="+projectId;
//    }
    return false;
}
function rejectQDG(projectId)
{
    dialog({
        title:"Message",
        html:"Are you sure you want to Reject? You will not be able to undo this action later.",
        buttons:{
            "OK":function() {
                window.location.href = "/synchro/project-specs!rejectQDG.jspa?projectID="+projectId;
            },
            "Cancel":function() {
                closeDialog();
            }
        }
    });
//    var proceed = confirm("Are you sure you want to Reject? You will not be able to undo this action later.");
//    if(proceed)
//    {
//        window.location.href = "/synchro/project-specs!rejectQDG.jspa?projectID="+projectId;
//    }
    return false;
}

</script>

<#--<#if stageId==3 >
	<ul class="required-actions" id="synchro-todo-action-box">
        <li><h4>Required Actions</h4></li>
		<#list stageToDoList as stageToDoBean >
	        
				<#if stageToDoBean.getToDoAction() == 'SEND FOR LEGAL APPROVAL' >
					<#if stageToDoBean.isActive()>
						<li><a onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="" class="o-btn">${stageToDoBean.getToDoAction()}</a></li>
					<#else>
						<li ><span class="approve">${stageToDoBean.getToDoAction()}</span></li>
					</#if>
				</#if>
				<#if stageToDoBean.getToDoAction() == 'SCREENER/CONSUMER APPROVE' >
					<li>Project Specs, Screener, and Consumer contract</li>	
					<li class="view_row_field">
					<#if stageToDoBean.isActive() && projectSpecsInitiation.isScreenerCCApproved?? && projectSpecsInitiation.isScreenerCCApproved==1 && projectSpecsInitiation.screenerCCApprover?? >
						<span class="b-btn">Approve</span>
					<#elseif stageToDoBean.isActive()>
						<a  onclick="javascript:approveScreener('${projectID}');" href="javascript:void(0);"  class="o-btn">Approve</a>
					<#elseif projectSpecsInitiation.isScreenerCCApproved?? && projectSpecsInitiation.isScreenerCCApproved==1 && projectSpecsInitiation.screenerCCApprover?? >
						<span class="b-btn">Approve</span>
					<#else>
						<span class="approve">Approve</span>
					</#if>
				</#if>
				<#if stageToDoBean.getToDoAction() == 'SCREENER/CONSUMER REJECT' >
				
					<#if stageToDoBean.isActive() && projectSpecsInitiation.isScreenerCCApproved?? && projectSpecsInitiation.isScreenerCCApproved==1 && projectSpecsInitiation.screenerCCApprover?? >
						<span class="b-btn b-right">Reject</span>
					<#elseif stageToDoBean.isActive() && projectSpecsInitiation.isScreenerCCApproved?? && projectSpecsInitiation.isScreenerCCApproved==2 >
						<span class="b-btn b-right">Reject</span>
					<#elseif stageToDoBean.isActive()>
					
						<a  onclick="javascript:rejectScreener('${projectID}');" href="javascript:void(0);" class="o-btn">Reject</a>
					<#elseif projectSpecsInitiation.isScreenerCCApproved?? && projectSpecsInitiation.isScreenerCCApproved==1 && projectSpecsInitiation.screenerCCApprover?? >
						<span class="b-btn b-right">Reject</span>	
					<#else>
						<span class="reject">Reject</span>
					</#if>
					</li>
				</#if>	
				<#if stageToDoBean.getToDoAction() == 'Q/DG APPROVE' >
					<li>Q&DG</li>	
					<li class="view_row_field">
					<#if stageToDoBean.isActive() && projectSpecsInitiation.isQDGApproved?? && projectSpecsInitiation.isQDGApproved==1 && projectSpecsInitiation.qdgApprover?? >
						<span class="b-btn">Approve</span>
					<#elseif stageToDoBean.isActive()>
						<a  onclick="javascript:approveQDG('${projectID}');" href="javascript:void(0);" class="o-btn">Approve</a>
					<#elseif projectSpecsInitiation.isQDGApproved?? && projectSpecsInitiation.isQDGApproved?? && projectSpecsInitiation.isQDGApproved==1 && projectSpecsInitiation.qdgApprover??>
						<span class="b-btn">Approve</span>
					<#else>
						<span class="approve">Approve</span>
					</#if>
				</#if>
				<#if stageToDoBean.getToDoAction() == 'Q/DG REJECT' >
					<#if stageToDoBean.isActive() && projectSpecsInitiation.isQDGApproved?? && projectSpecsInitiation.isQDGApproved==1 && projectSpecsInitiation.qdgApprover?? >
						<span class="b-btn b-right">Reject</span>
					<#elseif stageToDoBean.isActive() && projectSpecsInitiation.isQDGApproved?? && projectSpecsInitiation.isQDGApproved==2 >
						<span class="b-btn b-right">Reject</span>
					<#elseif stageToDoBean.isActive()>
						
						<a  onclick="javascript:rejectQDG('${projectID}');" href="javascript:void(0);" class="o-btn">Reject</a>
						
					<#elseif projectSpecsInitiation.isQDGApproved?? && projectSpecsInitiation.isQDGApproved?? && projectSpecsInitiation.isQDGApproved==1 && projectSpecsInitiation.qdgApprover??>
						<span class="b-btn b-right">Reject</span>
					<#else>
						<span class="reject">Reject</span>
					</#if>
					</li>
				</#if>
				<#if stageToDoBean.getToDoAction() == 'APPROVE' >
					<#if stageToDoBean.isActive() && projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved==1 && projectSpecsInitiation.approver?? >
						<li ><span class="b-btn b-btn-large">${stageToDoBean.getToDoAction()}</span></li>
					<#elseif stageToDoBean.isActive()>	
						<#if (projectSpecsInitiation.isQDGApproved?? && projectSpecsInitiation.isQDGApproved==2)||(projectSpecsInitiation.isScreenerCCApproved?? && projectSpecsInitiation.isScreenerCCApproved==2)>
							<li ><span class="approve">${stageToDoBean.getToDoAction()}</span></li>
						<#else>
							<li><a class="o-btn" onclick="return approve('approve','${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
						</#if>	
					<#elseif projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved==1 && projectSpecsInitiation.approver?? >	
						<li ><span class="b-btn b-btn-large">${stageToDoBean.getToDoAction()}</span></li>
					<#else>
						<li ><span class="approve">${stageToDoBean.getToDoAction()}</span></li>
					</#if>
				</#if>
				<#if stageToDoBean.getToDoAction() == 'NOTIFY EXTERNAL AGENCY' >
					<#if stageToDoBean.isActive()>
						<li><a onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="" class="o-btn">${stageToDoBean.getToDoAction()}</a></li>
					<#else>
						<li ><span class="approve">${stageToDoBean.getToDoAction()}</span></li>
					</#if>
				</#if>
	
	    </#list>
		</ul> -->

    <#if stageId==3 && project.multiMarket?? && project.multiMarket >

    <#-- Admin User Starts -->

        <#if isAdminUser  >
        <ul class="required-actions" id="synchro-todo-action-box">
            <li><h4>Required Actions</h4></li>

            <#if isAboveMarket>

                <#assign notUser = "" />
                <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
                    <#assign notUser = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
                <#else>
                    <#assign notUser = "Stakeholder Requested" />
                </#if>

            <#else>
                <#assign notUser = jiveContext.getSpringBean("userManager").getUser(endMarketProjectContact).getEmail() />
            </#if>
            <li><a onclick="return sendNotificationFormat('${notUser}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND FOR APPROVAL');" href="" class="o-btn">NOTIFY SP&I CONTACT</a></li>
            <#assign defaultAgency="">

            <#if isAboveMarket>

                <#if projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1>

                    <li><a onclick="return sendNotificationFormat('${awardedExternalAgency?default(defaultAgency)}','${subjectReqForClarification.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyReqForClarification.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','Request for Clarification');" href="" class="o-btn">Request for Clarification / Partial Approvals</a></li>
                <#else>
                    <li ><span class="approve">Request for Clarification / Partial Approvals</span></li>
                </#if>


             <#--   <#if projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1>
                    <#assign approveNotUsers = awardedExternalAgency?default(defaultAgency) />
                    <li><a class="o-btn" onclick="return approve(${stageId}, 'approve','${approveNotUsers}','${subjectFinalApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyFinalApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE');" href="">FINAL APPROVAL</a></li>
                <#else>
                    <li ><span class="approve">FINAL APPROVAL</span></li>
                </#if>
                -->
                 <#assign approveNotUsers = awardedExternalAgency?default(defaultAgency) />
                <#-- <li><a class="o-btn" style="background:green;" onclick="return approve(${stageId}, 'approve','${approveNotUsers}','${subjectFinalApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyFinalApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE');" href="">MOVE TO NEXT STAGE</a></li>-->
                  <li><a class="o-btn" id="psmovetonextstage" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>

            <#else>

                <#assign pOwner = "" />
                <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
                    <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
                <#else>
                    <#assign pOwner = "Stakeholder Requested" />
                </#if>

                <li><a onclick="return sendNotificationFormat('${pOwner}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_ABOVE_MARKET_SPI_CONTACT');" href="" class="o-btn">NOTIFY ABOVE MARKET SP&I CONTACT</a></li>


                <#if projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1>
                    <li><a onclick="return sendNotificationFormat('${awardedExternalAgency?default(defaultAgency)}','${subjectReqForClarification.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyReqForClarification.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','Request for Clarification');" href="" class="o-btn">Request for Clarification / Partial Approvals</a></li>
                <#else>
                    <li ><span class="approve">Request for Clarification / Partial Approvals</span></li>
                </#if>

                <#if projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1 && aboveMarketApproved>
                    <#assign approveNotUsers = awardedExternalAgency?default(defaultAgency) />
                    <li><a class="o-btn" onclick="return approve(${stageId}, 'approve','${approveNotUsers}','${subjectFinalApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyFinalApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE');" href="">FINAL APPROVAL</a></li>
                <#else>
                    <li ><span class="approve">FINAL APPROVAL</span></li>
                </#if>
            </#if>
        </ul>
        </#if>
    <#-- Admin User Ends -->

       <#-- <#if isExternalAgencyUser  >-->
       
        <#if isExternalAgencyUser && !isProjectOwner && !isAboveMarketProjectContactUser && !isAdminUser >

        <ul class="required-actions" id="synchro-todo-action-box">
            <li><h4>Required Actions</h4></li>

            <#if !(isAboveMarket) && endMarketStatus?? && endMarketStatus==statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].CANCEL.ordinal() >
                <li ><span class="approve">NOTIFY SP&I CONTACT</span></li>
            <#elseif projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved==1 && projectSpecsInitiation.approver?? >

                <li ><span class="approve">NOTIFY SP&I CONTACT</span></li>
            <#elseif allEndMarketSaved?? && allEndMarketSaved>
                <#if isAboveMarket>

                    <#assign notUser = "" />
                    <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
                        <#assign notUser = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
                    <#else>
                        <#assign notUser = "Stakeholder Requested" />
                    </#if>
                <#else>
                    <#assign notUser = jiveContext.getSpringBean("userManager").getUser(endMarketProjectContact).getEmail() />
                </#if>
                <#if projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1 >
                    <li><a onclick="return sendNotificationFormat('${notUser}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND FOR APPROVAL');" href="" class="o-btn">NOTIFY SP&I CONTACT</a></li>
                <#else>
                    <li><a onclick="return sendNotificationFormat('${notUser}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND FOR APPROVAL');" href="" class="o-btn">NOTIFY SP&I CONTACT</a></li>
                </#if>
            <#else>
                <li ><span class="approve">NOTIFY SP&I CONTACT</span></li>
            </#if>
            
            <#if projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved==1 && projectSpecsInitiation.approver?? >
                <li ><span class="approve">MOVE TO NEXT STAGE</span></li>
            <#elseif projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1>
                <#assign approveNotUsers = awardedExternalAgency />
                <li><a class="o-btn" id="psmovetonextstage" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
            <#else>
            
                <#assign approveNotUsers = awardedExternalAgency />
                <li><a class="o-btn" id="psmovetonextstage" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
            </#if>
            
            
        </ul>
        </#if>

      
        <#if (isProjectOwner || isAboveMarketProjectContactUser) && isAboveMarket && !isAdminUser>
       
       
	        <ul class="required-actions" id="synchro-todo-action-box">
	           <li><h4>Required Actions</h4></li>
		
            <#if isProjectOwner>
	            <#if projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved==1 && projectSpecsInitiation.approver?? >
	            <#-- <li class="b-btn"><span>Request for Clarification / Partial Approvals</span></li> -->
	                <li ><span class="approve">Request for Clarification / Partial Approvals</span></li>
	            <#elseif projectSpecsInitiation.isReqClariModification?? && projectSpecsInitiation.isReqClariModification>
	                <li><a onclick="return sendNotificationFormat('${awardedExternalAgency}','${subjectReqForClarification.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyReqForClarification.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','Request for Clarification');" href="" class="o-btn">Request for Clarification / Partial Approvals</a></li>
	            <#elseif projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1>
	                <li><a onclick="return sendNotificationFormat('${awardedExternalAgency}','${subjectReqForClarification.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyReqForClarification.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','Request for Clarification');" href="" class="o-btn">Request for Clarification / Partial Approvals</a></li>
	            <#else>
	                <li ><span class="approve">Request for Clarification / Partial Approvals</span></li>
	            </#if>
	        </#if>

			<#if isProjectOwner || isAboveMarketProjectContactUser>
	
	        <#--  <#if isAboveMarket> -->
	            <#if projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved==1 && projectSpecsInitiation.approver?? >
	               <#-- <li ><span class="approve">FINAL APPROVAL</span></li>-->
	                <li ><span class="approve">MOVE TO NEXT STAGE</span></li>
	            <#elseif projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1>
	            <#--<#assign approveNotUsers = aboveMarketProjectContact?default(statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(project.projectOwner))+","+awardedExternalAgency /> -->
	                <#assign approveNotUsers = awardedExternalAgency />
	                <#--<li><a class="o-btn" onclick="return approve(${stageId}, 'approve','${approveNotUsers}','${subjectFinalApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyFinalApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE');" href="">FINAL APPROVAL</a></li>-->
	                  <li><a class="o-btn" id="psmovetonextstage" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
	            <#else>
	               <#-- <li ><span class="approve">FINAL APPROVAL</span></li>-->
	                <#assign approveNotUsers = awardedExternalAgency />
	                <#--<li><a class="o-btn" style="background:green;" onclick="return approve(${stageId}, 'approve','${approveNotUsers}','${subjectFinalApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyFinalApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE');" href="">MOVE TO NEXT STAGE</a></li>-->
	                  <li><a class="o-btn" id="psmovetonextstage" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
	            </#if>
	         </#if>

        <#-- </#if> -->
      
        </ul>
      
        </#if>

       
        <#if (isCountryProjectContact || isCountrySPIContact || isProjectOwner ) && !(isAboveMarket)>
        <ul class="required-actions" id="synchro-todo-action-box">
            <li><h4>Required Actions</h4></li>
            <#if !(isAboveMarket) && endMarketStatus?? && endMarketStatus==statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].CANCEL.ordinal() >
                <li ><span class="approve">NOTIFY ABOVE MARKET SP&I CONTACT</span></li>
            <#elseif projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved==1 && projectSpecsInitiation.approver?? >
                <li ><span class="approve">NOTIFY ABOVE MARKET SP&I CONTACT</span></li>
            <#else>

                <#assign pOwner = "" />
                <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
                    <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
                <#else>
                    <#assign pOwner = "Stakeholder Requested" />
                </#if>
            <#--	<li><a onclick="return sendNotificationFormat('${aboveMarketProjectContact?default(pOwner)}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_ABOVE_MARKET_SPI_CONTACT');" href="" class="o-btn">NOTIFY ABOVE MARKET SP&I CONTACT</a></li> -->
                <li><a onclick="return sendNotificationFormat('${pOwner}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_ABOVE_MARKET_SPI_CONTACT');" href="" class="o-btn">NOTIFY ABOVE MARKET SP&I CONTACT</a></li>
            </#if>

            <#if !(isAboveMarket) && endMarketStatus?? && endMarketStatus==statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].CANCEL.ordinal() >
                <li ><span class="approve">Request for Clarification / Partial Approvals</span></li>
            <#elseif projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved==1 && projectSpecsInitiation.approver?? >
                <li ><span class="approve">Request for Clarification / Partial Approvals</span></li>
            <#elseif projectSpecsInitiation.isReqClariModification?? && projectSpecsInitiation.isReqClariModification>
                <li><a onclick="return sendNotificationFormat('${awardedExternalAgency}','${subjectReqForClarification.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyReqForClarification.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','Request for Clarification');" href="" class="o-btn">Request for Clarification / Partial Approvals</a></li>
            <#elseif projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1>
                <li><a onclick="return sendNotificationFormat('${awardedExternalAgency}','${subjectReqForClarification.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyReqForClarification.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','Request for Clarification');" href="" class="o-btn">Request for Clarification / Partial Approvals</a></li>
            <#else>
                <li ><span class="approve">Request for Clarification / Partial Approvals</span></li>
            </#if>

            <#if !(isAboveMarket) && endMarketStatus?? && endMarketStatus==statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].CANCEL.ordinal() >
                <li ><span class="approve">FINAL APPROVAL</span></li>
            <#elseif projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved==1 && projectSpecsInitiation.approver?? >
                <li ><span class="approve">FINAL APPROVAL</span></li>
            <#elseif projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1 && aboveMarketApproved>
                <#assign approveNotUsers = awardedExternalAgency />
                <li><a class="o-btn" onclick="return approve(${stageId}, 'approve','${approveNotUsers}','${subjectFinalApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyFinalApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE');" href="">FINAL APPROVAL</a></li>
            <#else>
                <li ><span class="approve">FINAL APPROVAL</span></li>
            </#if>

        </ul>
        </#if>
    <#elseif stageId==3 && stageToDoList?? && (stageToDoList?size>0) >
    <ul class="required-actions"  id="synchro-todo-action-box">
        <li><h4>Required Actions</h4></li>
        <#list stageToDoList as stageToDoBean >

            <#if stageToDoBean.getToDoAction() == 'SEND FOR APPROVAL' >
                <#if isAdminUser>
                    <li><a onclick="return sendNotificationFormat('${adminNotifySPIRecipents}','${subjectAdminNotifySPI.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageAdminNotifySPI.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="" class="o-btn">NOTIFY SP&I</a></li>
                <#elseif projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved==1 && projectSpecsInitiation.approver?? >
                <#--<li class="b-btn"><span>NOTIFY SP&I</span></li>-->
                    <li ><span class="approve">NOTIFY SP&I</span></li>
                <#elseif stageToDoBean.isActive()>
                    <#if projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1 >
                        <li><a onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="" class="o-btn">NOTIFY SP&I</a></li>
                    <#else>
                        <li><a onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="" class="o-btn">NOTIFY SP&I</a></li>
                    </#if>
                <#else>
                    <li ><span class="approve">NOTIFY SP&I</span></li>
                </#if>
            </#if>
            <#if stageToDoBean.getToDoAction() == 'REQUEST FOR CLARIFICATION' >
                <#if isAdminUser>
                    <li><a onclick="return sendNotificationFormat('${adminReqForClatrificationRecipents}','${subjectAdminReqForClatrification.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageAdminReqForClatrification.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="" class="o-btn">Request for Clarification / Partial Approvals</a></li>
                <#elseif projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved==1 && projectSpecsInitiation.approver?? >
                <#--<li class="b-btn"><span>Request for Clarification / Partial Approvals</span></li>-->
                    <li ><span class="approve">Request for Clarification / Partial Approvals</span></li>
                <#elseif stageToDoBean.isActive() && projectSpecsInitiation.isReqClariModification?? && projectSpecsInitiation.isReqClariModification>

                <#-- <li class="b-btn"><a class="active" onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="" >Request for Clarification / Partial Approvals</a></li>-->
                    <li><a onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="" class="o-btn">Request for Clarification / Partial Approvals</a></li>

                <#elseif stageToDoBean.isActive() && projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1>
                    <li><a onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="" class="o-btn">Request for Clarification / Partial Approvals</a></li>
                <#else>
                    <li ><span class="approve">Request for Clarification / Partial Approvals</span></li>
                </#if>
            </#if>
            <#if stageToDoBean.getToDoAction() == 'APPROVE' >
                <#--<#if isAdminUser && projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1>-->
				
                <#if isAdminUser>
                   <#-- <li><a class="o-btn" style="background:green;" onclick="return approve(${stageId}, 'approve','${adminFinalApprovalRecipents}','${subjectAdminFinalApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageAdminFinalApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">MOVE TO NEXT STAGE</a></li>-->
                   <li><a class="o-btn" id="psmovetonextstage" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>

                <#elseif projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved==1 && projectSpecsInitiation.approver?? >
                    <li ><span class="approve">MOVE TO NEXT STAGE</span></li>
                <#--<#elseif stageToDoBean.isActive() && projectSpecsInitiation.isSendForApproval?? && projectSpecsInitiation.isSendForApproval==1>-->
                	<#elseif stageToDoBean.isActive()>
                   <#-- <li><a class="o-btn" style="background:green;" onclick="return approve(${stageId}, 'approve','${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">MOVE TO NEXT STAGE</a></li>-->
                   <li><a class="o-btn" id="psmovetonextstage" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
                <#else>
                    <li ><span class="approve">MOVE TO NEXT STAGE</span></li>
                </#if>
            </#if>
	

        </#list>
    </ul>
    


    <#elseif stageId==4 && project.multiMarket?? && project.multiMarket >
    <#-- Admin user changes start -->

        <#if isAdminUser>


        <ul class="right-sidebar-list required-actions" id="synchro-todo-action-box">
            <li><h4>Required Actions</h4></li>


            <#if isAboveMarket>
                <#if reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport && reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS >

                    <#assign pOwner = "" />
                    <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
                        <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
                    <#else>
                        <#assign pOwner = "Stakeholder Requested" />
                    </#if>
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${pOwner}','${subjectSendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND FOR APPROVAL');" href="">SEND FOR APPROVAL</a></li>
                <#else>
                    <li class="disableToDoTab">SEND FOR APPROVAL</li>
                </#if>
            </#if>

            <#if !isAboveMarket>
                <#if ((reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport) || (reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS)) >
                    <#assign notUser = jiveContext.getSpringBean("userManager").getUser(endMarketProjectContact).getEmail() + "," + jiveContext.getSpringBean("userManager").getUser(endMarketProjectOwner).getEmail() />
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${notUser}','${subjectSendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND FOR APPROVAL');" href="">SEND FOR APPROVAL</a></li>
                <#else>
                    <li class="disableToDoTab">SEND FOR APPROVAL</li>
                </#if>
            </#if>

            <#if reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval >
                <li><a class="o-btn" onclick="return sendNotificationFormat('${awardedExternalAgency}','${subjectNeedsRevision.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyNeedsRevision.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NEEDS REVISION');" href="">NEEDS REVISION</a></li>
            <#elseif reportSummaryInitiation.needRevision?? && reportSummaryInitiation.needRevision >
                <li><a class="o-btn" onclick="return sendNotificationFormat('${awardedExternalAgency}','${subjectNeedsRevision.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyNeedsRevision.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NEEDS REVISION');" href="">NEEDS REVISION</a></li>
            <#else>
                <li class="disableToDoTab">NEEDS REVISION</li>
            </#if>




            <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                <li class="disableToDoTab"><span>SEND TO PROJECT OWNER</span></li>
            <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval >
                <li><a class="o-btn" onclick="return sendNotificationFormat('${aboveMarketProjectContact?default(statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(project.projectOwner))}','${subjectSendToProjectContact.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjectContact.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND TO PROJECT CONTACT');" href="">SEND TO PROJECT OWNER</a></li>
            <#else>
                <li class="disableToDoTab"><span>SEND TO PROJECT OWNER</span></li>
            </#if>

            <#if !isAboveMarket>
                <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                    <li class="disableToDoTab"><span>APPROVE</span></li>
                <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval  && ((reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport) || (reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS)) >
                    <#assign appNotUsers = aboveMarketProjectContact?default(statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(project.projectOwner)) +"," + awardedExternalAgency>
                    <li><a class="o-btn" onclick="return approve(${stageId},'approve','${appNotUsers}','${subjectApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE');" href="">APPROVE</a></li>
                <#else>
                    <li class="disableToDoTab"><span>APPROVE</span></li>
                </#if>
            </#if>

            <#if isAboveMarket>
               <#-- <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                    <li class="disableToDoTab"><span>APPROVE</span></li>
                <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval  && (reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport && reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS) >
                    <#assign appNotUsers = aboveMarketProjectContact?default(statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(project.projectOwner)) +"," + awardedExternalAgency>
                    <li><a class="o-btn" onclick="return approve(${stageId},'approve','${appNotUsers}','${subjectApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE');" href="">APPROVE</a></li>
                <#else>
                    <li class="disableToDoTab"><span>APPROVE</span></li>
                </#if>
                -->
                <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                    <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                <#else>
                    <#assign appNotUsers = aboveMarketProjectContact?default(statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(project.projectOwner)) +"," + awardedExternalAgency>
                    <#--<li><a class="o-btn" style="background:green;" onclick="return approve(${stageId},'approve','${appNotUsers}','${subjectApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE');" href="">MOVE TO NEXT STAGE</a></li>-->
                    <li><a class="o-btn" id="rsmovetonextstage" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
                </#if>
            </#if>




            <#if isAboveMarket>

                <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                    <#assign uploadToIrisEmail = JiveGlobals.getJiveProperty("upload.iris.admin.email", synchroAdminUsers) />
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${uploadToIrisEmail}','${subjectUploadToIris.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyUploadToIris.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','UPLOAD TO IRIS');" href="">UPLOAD TO IRIS</a></li>
                <#else>
                    <li class="disableToDoTab"><span>UPLOAD TO IRIS</span></li>
                </#if>



                <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                    <#assign uploadToCPSIDatabaseEmail = JiveGlobals.getJiveProperty("upload.cpsi.database.admin.email", synchroAdminUsers) />
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${uploadToCPSIDatabaseEmail}','${subjectUploadToCPSIDatabase.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyUploadToCPSIDatabase.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','UPLOAD TO C-PSI DATABASE');" href="">UPLOAD TO C-PSI DATABASE</a></li>
                <#else>
                    <li class="disableToDoTab"><span>UPLOAD TO C-PSI DATABASE</span></li>
                </#if>

            </#if>

            <#if isSystemAdmin && isAboveMarket>
                <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                    <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
                    <#-- <li class="b-btn">SUMMARY UPLOADED TO IRIS</li> -->
                        <li class="disableToDoTab"><span>SUMMARY UPLOADED TO IRIS</span></li>
                    <#else>

                        <#assign pOwner = "" />
                        <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
                            <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
                        <#else>
                            <#assign pOwner = "Stakeholder Requested" />
                        </#if>
                        <#assign notUsers = pOwner + "," + aboveMarketProjectContact?default(statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(project.projectOwner)) +"," + awardedExternalAgency>
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${notUsers}','${subjectSummaryUploadIris.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySummaryUploadIris.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SUMMARY UPLOADED TO IRIS');" href="">SUMMARY UPLOADED TO IRIS</a></li>
                    </#if>
                <#else>
                    <li class="disableToDoTab"><span>SUMMARY UPLOADED TO IRIS</span></li>
                </#if>
            </#if>


        </ul>

        </#if>

    <#-- Admin user changes ends -->

        <#if (isExternalAgencyUser || isProjectOwner || isAboveMarketProjectContact  || isCountryProjectContact || isCountrySPIContact) && !(isAdminUser)>

            <#if isAboveMarket>
            <ul class="right-sidebar-list required-actions" id="synchro-todo-action-box">
                <li><h4>Required Actions</h4></li>
            </#if>

            <#if isExternalAgencyUser && isAboveMarket>
                <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                <#--<li class="b-btn"><span>SEND FOR APPROVAL</span></li> -->
                    <li class="disableToDoTab">SEND FOR APPROVAL</li>
                <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval >
                <#--  <li class="r-btn"><span>SEND FOR APPROVAL</span></li> -->

                    <#assign pOwner = "" />
                    <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
                        <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
                    <#else>
                        <#assign pOwner = "Stakeholder Requested" />
                    </#if>
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${pOwner}','${subjectSendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND FOR APPROVAL');" href="">SEND FOR APPROVAL</a></li>
                <#elseif reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport && reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS >

                    <#assign pOwner = "" />
                    <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
                        <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
                    <#else>
                        <#assign pOwner = "Stakeholder Requested" />
                    </#if>
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${pOwner}','${subjectSendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND FOR APPROVAL');" href="">SEND FOR APPROVAL</a></li>
                <#else>
                    <li class="disableToDoTab">SEND FOR APPROVAL</li>
                </#if>
            </#if>

            <#if isExternalAgencyUser && !isAboveMarket>
                <ul class="right-sidebar-list required-actions" id="synchro-todo-action-box">
                    <li><h4>Required Actions</h4></li>

                    <#if !(isAboveMarket) && endMarketStatus?? && endMarketStatus==statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].CANCEL.ordinal() >
                        <li class="disableToDoTab">SEND FOR APPROVAL</li>
                    <#--<#elseif reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>-->
                    <#elseif reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved>
                        <li class="disableToDoTab">SEND FOR APPROVAL</li>
                    <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval >
                    <#-- <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() /> -->
                        <#assign notUser = jiveContext.getSpringBean("userManager").getUser(endMarketProjectContact).getEmail() + "," + jiveContext.getSpringBean("userManager").getUser(endMarketProjectOwner).getEmail() />
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${notUser}','${subjectSendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND FOR APPROVAL');" href="">SEND FOR APPROVAL</a></li>
                    <#elseif ((reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport) || (reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS)) >
                        <#assign notUser = jiveContext.getSpringBean("userManager").getUser(endMarketProjectContact).getEmail() + "," + jiveContext.getSpringBean("userManager").getUser(endMarketProjectOwner).getEmail() />
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${notUser}','${subjectSendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND FOR APPROVAL');" href="">SEND FOR APPROVAL</a></li>
                    <#else>
                    <#--  <li class="disableToDoTab">SEND FOR APPROVAL</li> -->

                        <#assign notUser = jiveContext.getSpringBean("userManager").getUser(endMarketProjectContact).getEmail() + "," + jiveContext.getSpringBean("userManager").getUser(endMarketProjectOwner).getEmail() />
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${notUser}','${subjectSendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND FOR APPROVAL');" href="">SEND FOR APPROVAL</a></li>
                    </#if>
                </ul>
            </#if>

            <#if isProjectOwner || isCountryProjectContact || isCountrySPIContact>
                <#if !isAboveMarket>
                <ul class="right-sidebar-list required-actions" id="synchro-todo-action-box">
                    <li><h4>Required Actions</h4></li>
                </#if>

                <#if isProjectOwner>
                    <#if !(isAboveMarket) && endMarketStatus?? && endMarketStatus==statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].CANCEL.ordinal() >
                        <li class="disableToDoTab"><span>NEEDS REVISION</span></li>
                    <#--<#elseif reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>-->
                    <#elseif reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved >
                        <li class="disableToDoTab"><span>NEEDS REVISION</span></li>
                    <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval >
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${awardedExternalAgency}','${subjectNeedsRevision.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyNeedsRevision.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NEEDS REVISION');" href="">NEEDS REVISION</a></li>
                    <#elseif reportSummaryInitiation.needRevision?? && reportSummaryInitiation.needRevision >
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${awardedExternalAgency}','${subjectNeedsRevision.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyNeedsRevision.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NEEDS REVISION');" href="">NEEDS REVISION</a></li>
                    <#else>
                        <li class="disableToDoTab">NEEDS REVISION</li>
                    </#if>
                </#if>
            </#if>
            <#if isProjectOwner || isCountryProjectContact || isCountrySPIContact>
                <#if isProjectOwner>
                    <#if !(isAboveMarket) && endMarketStatus?? && endMarketStatus==statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].CANCEL.ordinal() >
                        <li class="disableToDoTab"><span>SEND TO PROJECT OWNER</span></li>
                    <#--<#elseif reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>-->
                    <#elseif reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved>
                        <li class="disableToDoTab"><span>SEND TO PROJECT OWNER</span></li>
                    <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval >
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${aboveMarketProjectContact?default(statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(project.projectOwner))}','${subjectSendToProjectContact.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjectContact.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND TO PROJECT CONTACT');" href="">SEND TO PROJECT OWNER</a></li>
                    <#else>
                        <li class="disableToDoTab"><span>SEND TO PROJECT OWNER</span></li>
                    </#if>
                </#if>

                <#if !isAboveMarket && (isCountryProjectContact || isCountrySPIContact || isProjectOwner)>
                    <#if !(isAboveMarket) && endMarketStatus?? && endMarketStatus==statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].CANCEL.ordinal() >
                        <li class="disableToDoTab"><span>APPROVE</span></li>
                    <#--<#elseif reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>-->
                    <#elseif reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved>
                        <li class="disableToDoTab"><span>APPROVE</span></li>

                    <#-- <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval  && ((reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport) || (reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS)) > -->
                    <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval   >
                        <#assign appNotUsers = aboveMarketProjectContact?default(statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(project.projectOwner)) +"," + awardedExternalAgency>
                        <li><a class="o-btn" onclick="return approve(${stageId},'approve','${appNotUsers}','${subjectApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE');" href="">APPROVE</a></li>
                    <#else>
                        <li class="disableToDoTab"><span>APPROVE</span></li>
                    </#if>
                </#if>

                <#if !isAboveMarket>
                </ul>
                </#if>
            </#if>

            <#if (isProjectOwner || isAboveMarketProjectContact || isExternalAgencyUser) && isAboveMarket>
              <#--  <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                     <li class="disableToDoTab"><span>APPROVE</span></li>
                <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval  && (reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport && reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS) >
                    <#assign appNotUsers = aboveMarketProjectContact?default(statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(project.projectOwner)) +"," + awardedExternalAgency>
                    <li><a class="o-btn" onclick="return approve(${stageId},'approve','${appNotUsers}','${subjectApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE');" href="">APPROVE</a></li>
                <#else>
                    <li class="disableToDoTab"><span>APPROVE</span></li>
                </#if> -->
                
                 <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                     <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                <#else>
                    <#assign appNotUsers = aboveMarketProjectContact?default(statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(project.projectOwner)) +"," + awardedExternalAgency>
                    <#--<li><a class="o-btn" style="background:green;" onclick="return approve(${stageId},'approve','${appNotUsers}','${subjectApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE');" href="">MOVE TO NEXT STAGE</a></li>-->
                    <li><a class="o-btn" id="rsmovetonextstage" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
                </#if>
            </#if>




            <#if isAboveMarket>
                <#if isProjectOwner || isExternalAgencyUser || isAboveMarketProjectContact>
                    <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                        <#assign uploadToIrisEmail = JiveGlobals.getJiveProperty("upload.iris.admin.email", synchroAdminUsers) />
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${uploadToIrisEmail}','${subjectUploadToIris.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyUploadToIris.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','UPLOAD TO IRIS');" href="">UPLOAD TO IRIS</a></li>
                    <#else>
                        <li class="disableToDoTab"><span>UPLOAD TO IRIS</span></li>
                    </#if>
                </#if>

                <#if isProjectOwner || isExternalAgencyUser || isAboveMarketProjectContact>
                    <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                        <#assign uploadToCPSIDatabaseEmail = JiveGlobals.getJiveProperty("upload.cpsi.database.admin.email", synchroAdminUsers) />
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${uploadToCPSIDatabaseEmail}','${subjectUploadToCPSIDatabase.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyUploadToCPSIDatabase.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','UPLOAD TO C-PSI DATABASE');" href="">UPLOAD TO C-PSI DATABASE</a></li>
                    <#else>
                        <li class="disableToDoTab"><span>UPLOAD TO C-PSI DATABASE</span></li>
                    </#if>
                </#if>
            </#if>

        <#--<#if isSystemAdmin && isAboveMarket>
                      <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                          <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>

                              <li class="disableToDoTab"><span>SUMMARY UPLOADED TO IRIS</span></li>
                          <#else>
                              <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
                              <#assign notUsers = pOwner + "," + aboveMarketProjectContact?default(statics['com.grail.synchro.util.SynchroUtils'].getUserEmail(project.projectOwner)) +"," + awardedExternalAgency>
                              <li><a class="o-btn" onclick="return sendNotificationFormat('${notUsers}','${subjectSummaryUploadIris.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySummaryUploadIris.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SUMMARY UPLOADED TO IRIS');" href="">SUMMARY UPLOADED TO IRIS</a></li>
                          </#if>
                      <#else>
                          <li class="disableToDoTab"><span>SUMMARY UPLOADED TO IRIS</span></li>
                      </#if>
                  </#if>
                  -->

            <#if isAboveMarket>
            </ul>
            </#if>
        </#if>
    <#elseif stageId==4 && stageToDoList?? && (stageToDoList?size>0) >

    <ul class="right-sidebar-list required-actions" id="synchro-todo-action-box">
        <li><h4>Required Actions</h4></li>
        <#list stageToDoList as stageToDoBean >
        <#-- Admin user changes Starts -->
            <#if isAdminUser>
                <#if stageToDoBean.getToDoAction() == 'UPLOAD TO IRIS' >
                    <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                        <#assign uploadToIrisEmail = JiveGlobals.getJiveProperty("upload.iris.admin.email", stageToDoBean.getNotificationRecipients()) />
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${uploadToIrisEmail}','${subjectAdminUploadToIris.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageAdminUploadToIris.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                    <#else>
                        <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                    </#if>
                <#elseif stageToDoBean.getToDoAction() == 'UPLOAD TO C-PSI DATABASE' >
                    <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                        <#assign uploadToCPSIDatabaseEmail = JiveGlobals.getJiveProperty("upload.cpsi.database.admin.email", stageToDoBean.getNotificationRecipients()) />
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${uploadToCPSIDatabaseEmail}','${subjectAdminUploadToCPSIDatabase.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageAdminUploadToCPSIDatabase.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                    <#else>
                        <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                    </#if>
                <#elseif stageToDoBean.getToDoAction() == 'SUMMARY UPLOADED TO IRIS' >
                    <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                        <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
                            <li><a class="o-btn" onclick="return sendNotificationFormat('${adminSummaryUploadToIrisRecipents}','${subjectAdminSummaryUploadToIris.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageAdminSummaryUploadToIris.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                        <#else>
                            <li><a class="o-btn" onclick="return sendNotificationFormat('${adminSummaryUploadToIrisRecipents}','${subjectAdminSummaryUploadToIris.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageAdminSummaryUploadToIris.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                        </#if>

                    <#else>
                        <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                    </#if>
                <#else>
                    <#if stageToDoBean.getToDoAction() == 'SEND FOR APPROVAL' >

                        <#if !(reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport && reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS)>
                            <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                        <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval >
                            <li><a class="o-btn" onclick="return sendNotificationFormat('${adminSendForApprovalRecipents}','${subjectAdminSendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageAdminSendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                        <#else>
                            <li><a class="o-btn" onclick="return sendNotificationFormat('${adminSendForApprovalRecipents}','${subjectAdminSendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageAdminSendForApproval.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                        </#if>
                    <#elseif stageToDoBean.getToDoAction() == 'NEEDS REVISION' >

                        <#if reportSummaryInitiation.needRevision?? && reportSummaryInitiation.needRevision >
                            <li><a class="o-btn" onclick="return sendNotificationFormat('${adminNeedsRevisionRecipents}','${subjectAdminNeedsRevision.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageAdminNeedsRevision.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                        <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval >
                            <li><a class="o-btn" onclick="return sendNotificationFormat('${adminNeedsRevisionRecipents}','${subjectAdminNeedsRevision.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageAdminNeedsRevision.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>

                        <#else>
                            <li class="disableToDoTab">${stageToDoBean.getToDoAction()}</li>
                        </#if>
                    <#elseif stageToDoBean.getToDoAction() == 'SEND TO PROJECT OWNER' >

                        <#if reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval >
                            <li><a class="o-btn" onclick="return sendNotificationFormat('${adminSendToProjectOwnerRecipents}','${subjectAdminSendToProjectOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageAdminSendToProjectOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                        <#else>
                            <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                        </#if>
                    <#elseif stageToDoBean.getToDoAction() == 'APPROVE' >
							
							<#--<li><a class="o-btn" style="background:green;" onclick="return approve(${stageId},'approve','${adminAdminApproveRecipents}','${subjectAdminApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageAdminApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">MOVE TO NEXT STAGE</a></li>-->
							<li><a class="o-btn" id="rsmovetonextstage" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
                        <#--<#if reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval && (reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport && reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS) >

                            <li><a class="o-btn" style="background:green;" onclick="return approve(${stageId},'approve','${adminAdminApproveRecipents}','${subjectAdminApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageAdminApprove.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">MOVE TO NEXT STAGE</a></li>
                        <#else>
                            <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                        </#if>-->
                    <#else>
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                    </#if>
	
                </#if>
            <#-- Admin user changes Ends -->
            <#elseif stageToDoBean.isActive()>
                <#if stageToDoBean.getToDoAction() == 'UPLOAD TO IRIS' >
                    <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                        <#assign uploadToIrisEmail = JiveGlobals.getJiveProperty("upload.iris.admin.email", stageToDoBean.getNotificationRecipients()) />
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${uploadToIrisEmail}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                    <#else>
                        <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                    </#if>
                <#elseif stageToDoBean.getToDoAction() == 'UPLOAD TO C-PSI DATABASE' >
                    <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                        <#assign uploadToCPSIDatabaseEmail = JiveGlobals.getJiveProperty("upload.cpsi.database.admin.email", stageToDoBean.getNotificationRecipients()) />
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${uploadToCPSIDatabaseEmail}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                    <#else>
                        <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                    </#if>
                <#elseif stageToDoBean.getToDoAction() == 'SUMMARY UPLOADED TO IRIS' >
                    <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                        <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
                            <li class="b-btn">${stageToDoBean.getToDoAction()}</li>
                        <#else>
                            <li><a class="o-btn" onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                        </#if>

                    <#else>
                        <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                    </#if>
                <#else>
                    <#if stageToDoBean.getToDoAction() == 'SEND FOR APPROVAL' >
                        <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>

                            <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                        <#-- <#elseif !(reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport && reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS)>-->
                        <#elseif !(reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport && reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS)>
                            <#if synchroToIRIS.irisSummaryRequired?? && synchroToIRIS.irisSummaryRequired==1 && !reportSummaryInitiation.summaryForIRIS>
                                <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                            <#--<#elseif synchroToIRIS.irisSummaryRequired?? && synchroToIRIS.irisSummaryRequired==2 && synchroToIRIS.irisOptionRationale?? && synchroToIRIS.irisOptionRationale!="" >
                            	  <li><a class="o-btn" onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                            -->
                            <#else>
                                <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                            </#if>
                        <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval >

                            <li><a class="o-btn" onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                        <#else>
                            <li><a class="o-btn" onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                        </#if>
                    <#elseif stageToDoBean.getToDoAction() == 'NEEDS REVISION' >
                        <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                        <#--<li class="b-btn"><span>${stageToDoBean.getToDoAction()}</span></li> -->
                            <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                        <#elseif reportSummaryInitiation.needRevision?? && reportSummaryInitiation.needRevision >
                        <#--<li class="r-btn"><span>${stageToDoBean.getToDoAction()}</span></li> -->
                        <#--    <li class="b-btn"><a class="active" onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li> -->
                            <li><a class="o-btn" onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                        <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval >
                            <li><a class="o-btn" onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>

                        <#else>
                            <li class="disableToDoTab">${stageToDoBean.getToDoAction()}</li>
                        </#if>
                    <#elseif stageToDoBean.getToDoAction() == 'SEND TO PROJECT OWNER' >
                        <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                        <#-- <li class="b-btn"><span>${stageToDoBean.getToDoAction()}</span></li> -->
                            <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                        <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval >
                            <li><a class="o-btn" onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                        <#else>
                            <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                        </#if>
                    <#elseif stageToDoBean.getToDoAction() == 'APPROVE' >
                        <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>

                            <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                        
                        <#--
                        <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval && (reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport && synchroToIRIS.irisSummaryRequired?? && synchroToIRIS.irisSummaryRequired==2 && synchroToIRIS.irisOptionRationale?? && synchroToIRIS.irisOptionRationale!="" ) >

                            <li><a class="o-btn" onclick="return approve(${stageId},'approve','${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">MOVE TO NEXT STAGE</a></li>

                        <#elseif reportSummaryInitiation.sendForApproval?? && reportSummaryInitiation.sendForApproval && (reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport && reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS) >

                            <li><a class="o-btn" onclick="return approve(${stageId},'approve','${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">MOVE TO NEXT STAGE</a></li>-->
                        <#else>
                           <#-- <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>-->
                         <#--  <li><a class="o-btn" style="background:green;"  onclick="return approve(${stageId},'approve','${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">MOVE TO NEXT STAGE</a></li>-->
                         <li><a class="o-btn" id="rsmovetonextstage" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
                        </#if>
                    <#else>
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                    </#if>

                </#if>
            <#else>
                <#if stageToDoBean.getToDoAction() == 'SUMMARY UPLOADED TO IRIS' && reportSummaryInitiation.status?? && reportSummaryInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
                <#--<li class="b-btn"><span>${stageToDoBean.getToDoAction()}</span></li> -->
                    <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                <#elseif stageToDoBean.getToDoAction() == 'APPROVE' && reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                <#-- <li class="b-btn"><span>${stageToDoBean.getToDoAction()}</span></li> -->
                    <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                <#elseif stageToDoBean.getToDoAction() == 'SEND FOR APPROVAL' && reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                <#-- <li class="b-btn"><span>${stageToDoBean.getToDoAction()}</span></li>-->
                    <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
				
				<#elseif stageToDoBean.getToDoAction() == 'UPLOAD TO IRIS' >
                    <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                        <#assign uploadToIrisEmail = JiveGlobals.getJiveProperty("upload.iris.admin.email", stageToDoBean.getNotificationRecipients()) />
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${uploadToIrisEmail}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                    <#else>
                        <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                    </#if>
                
                <#elseif stageToDoBean.getToDoAction() == 'UPLOAD TO C-PSI DATABASE' >
                    <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval>
                        <#assign uploadToCPSIDatabaseEmail = JiveGlobals.getJiveProperty("upload.cpsi.database.admin.email", stageToDoBean.getNotificationRecipients()) />
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${uploadToCPSIDatabaseEmail}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getToDoAction()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                    <#else>
                        <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                    </#if>
                <#else>
                    <li class="disableToDoTab"><span>${stageToDoBean.getToDoAction()}</span></li>
                </#if>

            </#if>

        </#list>
    </ul>
    <#elseif stageId==1 && project.multiMarket?? && project.multiMarket >


        <#if isAboveMarket>

           <#-- <#if isProjectOwner || isGlobalProjectContactUser || isProjectOwner || isAboveMarketProjectContactUser || isAdminUser>-->
            <#if isProjectOwner || isGlobalProjectContactUser || isProjectOwner || isAboveMarketProjectContactUser || isAdminUser || isExternalAgencyUser>
            <ul class="right-sidebar-list required-actions" id="synchro-todo-action-box">
                <li><h4>Required Actions</h4></li>

                <#if isProjectOwner || isAdminUser || isExternalAgencyUser || isAboveMarketProjectContactUser>
                    <#if allEndMarketSaved?? && allEndMarketSaved>
                        <#if isAdminUser>
                            <#--<li><a class="o-btn" onclick="return sendNotificationFormat('${pibCompleteNotifyAgencyRecipents}','${pibCompleteNotifyAgencySubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibCompleteNotifyAgencyMessageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','1');" href="">PIB COMPLETE - <br/>NOTIFY AGENCY(S)</a></li>-->
                        <#--    <li><a class="o-btn" style="background:green;" onclick="return sendNotificationFormat('${pibCompleteNotifyAgencyRecipents}','${pibCompleteNotifyAgencySubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibCompleteNotifyAgencyMessageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','1');" href="">MOVE TO NEXT STAGE</a></li> -->
                               <li><a id="pibmovetonextstage" class="o-btn" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
                            <li><a class="o-btn" onclick="return sendNotificationFormat('${pibNotifyAgencyRecipents}','${pibNotifyAgencySubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibNotifyAgencyMessageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_AGENCY');" href="">NOTIFY AGENCY</a></li>
                        <#elseif isProposalAwarded?? && isProposalAwarded>
                            <#--<li class="view-field-btn disableToDoTab"><span>PIB COMPLETE - <br/>NOTIFY AGENCY(S)</span></li>-->
                            <li class="view-field-btn disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                            <li class="view-field-btn disableToDoTab"><span>NOTIFY AGENCY</span></li>
                        <#else>
                           <#-- <li><a class="o-btn" onclick="return sendNotificationFormat('${pibCompleteNotifyAgencyRecipents}','${pibCompleteNotifyAgencySubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibCompleteNotifyAgencyMessageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','1');" href="">PIB COMPLETE - <br/>NOTIFY AGENCY(S)</a></li>-->
                           <#-- <li><a class="o-btn" style="background:green;" onclick="return sendNotificationFormat('${pibCompleteNotifyAgencyRecipents}','${pibCompleteNotifyAgencySubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibCompleteNotifyAgencyMessageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','1');" href="">MOVE TO NEXT STAGE</a></li> -->
                              <li><a id="pibmovetonextstage" class="o-btn" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
                            <#if projectInitiation.isEndMarketChanged?? && projectInitiation.isEndMarketChanged>
                                <li><a class="o-btn" onclick="return sendNotificationFormat('${pibNotifyAgencyRecipents}','${pibNotifyAgencySubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibNotifyAgencyMessageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_AGENCY');" href="">NOTIFY AGENCY</a></li>
                            <#else>
                            <#-- <li class="view-field-btn disableToDoTab"><span>NOTIFY AGENCY</span></li> -->
                            </#if>
                        </#if>

                    <#else>
                        <#--<li class="view-field-btn disableToDoTab"><span>PIB COMPLETE - <br/>NOTIFY AGENCY(S)</span></li>-->
                        
                        <#--  <li><a class="o-btn"  style="background:green;"  onclick="return sendNotificationFormat('${pibCompleteNotifyAgencyRecipents}','${pibCompleteNotifyAgencySubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibCompleteNotifyAgencyMessageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','1');" href="">MOVE TO NEXT STAGE</a></li> -->
                           <li><a id="pibmovetonextstage" class="o-btn" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
                        <#if isAdminUser>
                            <li class="view-field-btn disableToDoTab"><span>NOTIFY AGENCY</span></li>
                        </#if>
                    </#if>
                </#if>

                <#if isAdminUser>

                    <#assign pOwner = "" />
                    <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
                        <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
                    <#else>
                        <#assign pOwner = "Stakeholder Requested" />
                    </#if>

                    <li><a class="o-btn" onclick="return sendNotificationFormat('${pOwner}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_PROJECT_OWNER');" href="">NOTIFY SP&I CONTACT</a></li>
                <#elseif isGlobalProjectContactUser || displayNotifySPI>
                    <#if isProposalAwarded?? && isProposalAwarded>
                        <li class="view-field-btn disableToDoTab"><span>NOTIFY SP&I CONTACT</span></li>
                    <#else>
                        <#assign pOwner = "" />
                        <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
                            <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
                        <#else>
                            <#assign pOwner = "Stakeholder Requested" />
                        </#if>
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${pOwner}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_PROJECT_OWNER');" href="">NOTIFY SP&I CONTACT</a></li>
                    </#if>
                </#if>

                <#assign defaultEndMarketUser="" />
                <#if isAdminUser>
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${aboveMarketProjectContactEmail}','${subjectSendToProjectContact.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjectContact.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_PROJECT_CONTACT');" href="">NOTIFY PROJECT OWNER</a></li>
                <#elseif isProjectOwner>
                    <#if isProposalAwarded?? && isProposalAwarded>
                    <#-- <li class="view-field-btn b-btn"><span>NOTIFY PROJECT OWNER</span></li> -->
                        <li class="view-field-btn disableToDoTab"><span>NOTIFY PROJECT OWNER</span></li>

                    <#else>
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${aboveMarketProjectContactEmail?default(defaultEndMarketUser)}','${subjectSendToProjectContact.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjectContact.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_PROJECT_CONTACT');" href="">NOTIFY PROJECT OWNER</a></li>
                    </#if>
                </#if>


                <#if isAdminUser>
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${endMarketProjectUsers?default(defaultEndMarketUser)}','${subjectNotifyEndMarketContacts.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageNotifyEndMarketContacts.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_END_MARKET_CONTACTS');" href="">NOTIFY END MARKET CONTACTS</a></li>
                <#elseif isAboveMarketProjectContactUser || isProjectOwner>
                    <#if isProposalAwarded?? && isProposalAwarded>
                        <li class="view-field-btn disableToDoTab"><span>NOTIFY END MARKET CONTACTS</span></li>
                    <#else>
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${endMarketProjectUsers?default(defaultEndMarketUser)}','${subjectNotifyEndMarketContacts.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageNotifyEndMarketContacts.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_END_MARKET_CONTACTS');" href="">NOTIFY END MARKET CONTACTS</a></li>
                    </#if>
                </#if>

            </ul>
            </#if>

        <#else>
            <#if isCountryProjectContact || isCountrySPIContact || isProjectOwner || isAdminUser>
            <ul class="right-sidebar-list required-actions" id="synchro-todo-action-box">
                <li><h4>Required Actions</h4></li>
                <#if isCountryProjectContact || isCountrySPIContact || isAdminUser>
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${pibNotifyAboveMarketRecipents}','${pibNotifyAboveMarketSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibNotifyAboveMarketMessageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_ABOVE_MARKET_CONTACTS');" href="">NOTIFY ABOVE MARKET CONTACTS</a></li>
                </#if>
                <#if isAdminUser>
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${pibApproveChangesRecipents}','${pibApproveChangesSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibApproveChangesMessageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE_CHANGES');" href="">APPROVE CHANGES</a></li>
                </#if>
                <#if projectInitiation.status?? && projectInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PIB_COMPLETED.ordinal() >

                    <#if projectInitiation.isEndMarketChanged?? && projectInitiation.isEndMarketChanged>
                    <#--<li><a class="o-btn" onclick="return sendNotificationFormat('${pibNotifyAboveMarketRecipents}','${pibNotifyAboveMarketSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibNotifyAboveMarketMessageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_ABOVE_MARKET_CONTACTS');" href="">NOTIFY ABOVE MARKET CONTACTS</a></li>-->
                        <#if isProjectOwner>
                            <#if projectInitiation.notifyAboveMarketContacts?? && projectInitiation.notifyAboveMarketContacts>
                                <li><a class="o-btn" onclick="return sendNotificationFormat('${pibApproveChangesRecipents}','${pibApproveChangesSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibApproveChangesMessageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE_CHANGES');" href="">APPROVE CHANGES</a></li>
                            <#else>
                                <li class="view-field-btn disableToDoTab"><span>APPROVE CHANGES</span></li>
                            </#if>
                        </#if>
                    <#else>
                    <#-- <li class="view-field-btn disableToDoTab"><span>NOTIFY ABOVE MARKET CONTACTS</span></li>-->
                        <#if isProjectOwner>
                            <li class="view-field-btn disableToDoTab"><span>APPROVE CHANGES</span></li>
                        </#if>
                    </#if>
                <#else>
                <#-- <li class="view-field-btn disableToDoTab"><span>NOTIFY ABOVE MARKET CONTACTS</span></li> -->
                    <#if isProjectOwner>
                        <li class="view-field-btn disableToDoTab"><span>APPROVE CHANGES</span></li>
                    </#if>
                </#if>
            </ul>
            </#if>
        </#if>



    <#elseif stageId==1 && ((stageToDoList?? && (stageToDoList?size>0)) || isProjectOwner || isAdminUser || isExternalAgencyUser || isSPIContactUser) >
    
    <ul class="right-sidebar-list required-actions" id="synchro-todo-action-box">
        <li><h4>Required Actions</h4></li>
        <#list stageToDoList as stageToDoBean >

            <#if isAdminUser && projectInitiation.status?? && (projectInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PIB_COMPLETED.ordinal() || projectInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PIB_SAVED.ordinal())>
               <#-- <li><a class="o-btn" onclick="return sendNotificationFormat('${adminPIBCompleteRecipents}','${subjectAdminPIBComplete.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodyAdminPIBComplete.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">PIB COMPLETE - <br/>NOTIFY AGENCY(S)</a></li>-->
               <li><a id="pibmovetonextstage" class="o-btn" style="background:green;"  href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
            <#elseif stageToDoBean.isActive() && !disable>

               <#-- <li><a class="o-btn" onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">PIB COMPLETE - <br/>NOTIFY AGENCY(S)</a></li>-->
                <li><a id="pibmovetonextstage" class="o-btn" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
            <#elseif projectInitiation.status?? && projectInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PIB_COMPLETED.ordinal() && !disable>
                <#if isProposalAwarded?? && isProposalAwarded>
                   <#-- <li class="view-field-btn disableToDoTab"><span>PIB COMPLETE - <br/>NOTIFY AGENCY(S)</span></li> -->
                    <li class="view-field-btn disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                <#else>
                  <#--  <li><a class="o-btn" style="background:green;" onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">PIB COMPLETE - <br/>NOTIFY AGENCY(S)</a></li>-->
                    <li><a id="pibmovetonextstage" class="o-btn" style="background:green;" href="javascript:void(0)">MOVE TO NEXT STAGE</a></li>
                </#if>

            <#else>
                <#-- <li class="view-field-btn disableToDoTab"><span>PIB COMPLETE - <br/>NOTIFY AGENCY(S)</span></li> -->
                <li class="view-field-btn disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
            </#if>

        </#list>
        <#if isAdminUser>
            <#assign pOwner = "" />
            <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
                <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
            <#else>
                <#assign pOwner = "Stakeholder Requested" />
            </#if>
            <li><a class="o-btn" onclick="return sendNotificationFormat('${pOwner}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_PROJECT_OWNER');" href="">NOTIFY PROJECT OWNER</a></li>

        <#elseif isSPIContactUser >
        <#-- <#if  !disable && projectInitiation.status?? && projectInitiation.status gt statics['com.grail.synchro.SynchroGlobal$StageStatus'].PIB_STARTED.ordinal()> -->
            <#if isProposalAwarded?? && isProposalAwarded>
            <#--<li class="view-field-btn b-btn"><span>NOTIFY PROJECT OWNER</span></li> -->
                <li class="view-field-btn disableToDoTab"><span>NOTIFY PROJECT OWNER</span></li>
            <#elseif  !disable >
                <#assign pOwner = "" />
                <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
                    <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
                <#else>
                    <#assign pOwner = "Stakeholder Requested" />
                </#if>
                <#if projectInitiation.notifyPO?? && projectInitiation.notifyPO>
                <#--<li class="b-btn"><a class="active" onclick="return sendNotificationFormat('${pOwner}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_PROJECT_OWNER');" href="">NOTIFY PROJECT OWNER</a></li>-->
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${pOwner}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_PROJECT_OWNER');" href="">NOTIFY PROJECT OWNER</a></li>
                <#else>
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${pOwner}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_PROJECT_OWNER');" href="">NOTIFY PROJECT OWNER</a></li>
                </#if>
            <#else>
                <li class="view-field-btn disableToDoTab"><span>NOTIFY PROJECT OWNER</span></li>
            </#if>
        </#if>

        <#if isAdminUser>

            <#assign spiUser = "" />
            <#if spiContact?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(spiContact) >
                <#assign spiUser = jiveContext.getSpringBean("userManager").getUser(spiContact).getEmail() />
            <#else>
                <#assign spiUser = "Stakeholder Requested" />
            </#if>

            <li><a class="o-btn" onclick="return sendNotificationFormat('${spiUser}','${subjectSendToSPI.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToSPI.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_SPI');" href="">NOTIFY SP&I</a></li>
        <#elseif isProjectOwner >
        <#--    <#if  !disable && projectInitiation.status?? && projectInitiation.status gt statics['com.grail.synchro.SynchroGlobal$StageStatus'].PIB_STARTED.ordinal()>-->

            <#if isProposalAwarded?? && isProposalAwarded>
            <#--<li class="view-field-btn b-btn"><span>NOTIFY SP&I</span></li> -->
                <li class="view-field-btn disableToDoTab"><span>NOTIFY SP&I</span></li>
            <#elseif  !disable >
                <#assign spiUser = jiveContext.getSpringBean("userManager").getUser(spiContact).getEmail() />
                <#if projectInitiation.notifySPI?? && projectInitiation.notifySPI>
                <#-- <li class="b-btn"><a class="active" onclick="return sendNotificationFormat('${spiUser}','${subjectSendToSPI.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToSPI.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_SPI');" href="">NOTIFY SP&I</a></li> -->
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${spiUser}','${subjectSendToSPI.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToSPI.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_SPI');" href="">NOTIFY SP&I</a></li>
                <#else>
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${spiUser}','${subjectSendToSPI.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToSPI.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_SPI');" href="">NOTIFY SP&I</a></li>
                </#if>

            <#else>
                <li class="view-field-btn disableToDoTab"><span>NOTIFY SP&I</span></li>
            </#if>
        </#if>

    </ul>

    <#elseif stageToDoList?? && (stageToDoList?size>0) >
    <ul class="right-sidebar-list required-actions" id="synchro-todo-action-box">
        <li><h4>Required Actions</h4></li>
        <#list stageToDoList as stageToDoBean >
            <#if stageToDoBean.isActive()>

                <#if stageToDoBean.getToDoAction() == 'APPROVE' >
                    <li><a onclick="return approve(${stageId},'approve','${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                <#elseif stageToDoBean.getToDoAction() == 'APPROVE FUNDING' >
                    <li><a onclick="return approve(${stageId},'approve-funding','${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                <#else>
                    <li><a onclick="return sendNotificationFormat('${stageToDoBean.getNotificationRecipients()}','${stageToDoBean.getSubject().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getMessageBody().replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${stageToDoBean.getId()}');" href="">${stageToDoBean.getToDoAction()}</a></li>
                </#if>
            <#else>
                <li class="disableToDoTab">${stageToDoBean.getToDoAction()}</li>
            </#if>

        </#list>
    </ul>
    <#else>
    </#if>

</#macro>

<#macro renderCurrenciesField name='currency' value=-1?number disabled=disabled display=true>
    <#local defaultCurrency = JiveGlobals.getJiveIntProperty("grail.default.currency", -1) />
    <#assign currencies = statics['com.grail.synchro.SynchroGlobal'].getCurrencies() />
<select <#if !display>style="display:none;"</#if> name="${name}" id="${name}" <#if disabled>disabled</#if> <#if multiselect?? && multiselect>multiple="yes"</#if> class="select_field sortList">
<#--<option value=-1>Select</option>-->
    <#if (currencies?has_content)>
        <#list currencies.keySet() as key>
            <#assign currency = currencies.get(key) />
                <option value=${key?c} <#if value?? && value?is_number && key?c == value?c>selected="true"<#elseif value?? && value?is_number && value == -1 && defaultCurrency?c == key?c>selected="true"</#if>>${currency}</option>
        </#list>
    </#if>
</select>
    <#if display>
    <script type="text/javascript">
        jQuery(".sortList").removeClass("sortList");
        if(jQuery('#${name} option[value=-1]').length < 1)
        {
            jQuery("#${name}").prepend("<option disabled value=-1 >Select</option>");
        }
            <#if  value?? && value?is_number && value != -1 >
            jQuery("#${name}").val("${value}");
            <#else>
            jQuery("#${name}").val("${defaultCurrency}");

            </#if>
    </script>
    </#if>
</#macro>



<#macro renderCurrenciesFieldNew name='currency' value=0 disabled=disabled display=true id=''>
  
	
 <#assign currencies = statics['com.grail.synchro.util.SynchroUtils'].getAllCurrencyFieldsNew(user) />
 

 <#assign userLocalCurrency = statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user) />
 

<select data-placeholder="Cost Currency" title = "Select Currency" <#if !display>style="display:none;"</#if> name="${name}" id="${id}" <#if disabled>disabled</#if> <#if multiselect?? && multiselect>multiple="yes"</#if> class="chosen-select select_field sortList currency">
<option value=-1></option>
    <#if (currencies?has_content)>
        <#assign currencyCounter = 0>
		<#assign userCurrencyGlobal = "no">
		
		<#assign prefCurrExchangeRate = statics['com.grail.synchro.util.SynchroUtils'].getCurrencyExchangeRateString(statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user)) />
		
		<#list currencies.keySet() as key>
            <#assign currency = currencies.get(key).getName() />
			<#assign currencyDescription = currencies.get(key).getDescription() />
			
			<#assign gbpExchangeRate = statics['com.grail.synchro.util.SynchroUtils'].getCurrencyExchangeRateString(key) />
			
			
			<#if currencies.get(key).isGlobal() >
                <option value=${key?c} isGlobal="yes" gbpExchangeRate="${gbpExchangeRate}" prefCurrExchangeRate="${prefCurrExchangeRate}" <#if value?? &&  key?c == value>selected="true"</#if>>${currency} (${currencyDescription})</option>
				<#if userLocalCurrency==key>
					<#assign userCurrencyGlobal = "yes">
				</#if>
			<#else>
				<#if userLocalCurrency==key>
					<option value=${key?c} isGlobal="yes"  gbpExchangeRate="${gbpExchangeRate}" prefCurrExchangeRate="${prefCurrExchangeRate}" <#if value?? && key?c == value>selected="true"</#if>>${currency} (${currencyDescription})</option>
					<optgroup label="-------------------------------">
				<#elseif userLocalCurrency==-1 && currencyCounter==0>
					<optgroup label="-------------------------------">
					 <#assign currencyCounter = currencyCounter+1>
					 
					
						<option value=${key?c} isGlobal="no"  gbpExchangeRate="${gbpExchangeRate}" prefCurrExchangeRate="${prefCurrExchangeRate}" <#if value?? && key?c == value>selected="true"</#if>>${currency} (${currencyDescription})</option>
					 
				<#elseif userCurrencyGlobal=="yes" && currencyCounter==0>
					<optgroup label="-------------------------------">
					 <#assign currencyCounter = currencyCounter+1>
					 
					 <option value=${key?c} isGlobal="no"  gbpExchangeRate="${gbpExchangeRate}" prefCurrExchangeRate="${prefCurrExchangeRate}" <#if value?? && key?c == value>selected="true"</#if>>${currency} (${currencyDescription})</option>
				<#else>	
					<option value=${key?c} isGlobal="no"  gbpExchangeRate="${gbpExchangeRate}" prefCurrExchangeRate="${prefCurrExchangeRate}" <#if value?? && key?c == value>selected="true"</#if>>${currency} (${currencyDescription})</option>
				</#if>
				
			</#if>
					
        </#list>
		</optgroup>		
    </#if>
</select>
    <#if display>
    
    </#if>
</#macro>

<#macro showSelectedEndMarketSelectionField name='' value=[] label='' readonly=false id=''>
    <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
    <#assign endMarketKeySet = endMarkets.keySet() />


<div class="form-select_div">
    <label>List of End Markets</label>
    <#if readonly>
        <select size="3" name="availableEndMarkets" id="availableEndMarkets<#if id?? && id != ''>_${id}</#if>" disabled multiple="yes" class="" > </select>
    <#else>
        <select size="3" name="availableEndMarkets" id="availableEndMarkets<#if id?? && id != ''>_${id}</#if>" multiple="yes" class=""></select>
    </#if>

    <div class="action_buttons">
        <a id="endmarkets-reload<#if id?? && id != ''>_${id}</#if>" href="javascript:void(0);"></a>
        <input id="addEndMarketBtn<#if id?? && id != ''>_${id}</#if>" type="button" value='>>' class="left_arrow">
        <input id="removeEndMarketBtn<#if id?? && id != ''>_${id}</#if>" type="button" value='<<' class="right_arrow" >
    </div>
</div>
<div class="form-select_div_brand">
    <label>Selected List of End Markets</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}<#if id?? && id != ''>_${id}</#if>" disabled multiple="yes" class="" ></select>
    <#else>
        <select size="3" name="${name}" id="${name}<#if id?? && id != ''>_${id}</#if>" multiple="yes" class=""></select>
    </#if>
    <#attempt>
        <@macroCustomFieldErrors msg="Please choose End Markets"/>
        <#recover>
    </#attempt>

</div>

<script type="text/javascript">

    var selectedList = {};
    var unSelectedList = {};

    jQuery(document).ready(function() {
        updateSelection();
        validateAddInvestmentLink();
        jQuery("#addEndMarketBtn<#if id?? && id != ''>_${id}</#if>, #removeEndMarketBtn<#if id?? && id != ''>_${id}</#if>").bind('click',function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addEndMarketBtn<#if id?? && id != ''>_${id}</#if>" ? "availableEndMarkets<#if id?? && id != ''>_${id}</#if>" : "endMarkets<#if id?? && id != ''>_${id}</#if>";
            var moveTo = (id == "addEndMarketBtn<#if id?? && id != ''>_${id}</#if>") ? "endMarkets<#if id?? && id != ''>_${id}</#if>" : "availableEndMarkets<#if id?? && id != ''>_${id}</#if>";
            var selectedItems = jQuery("select[id="+selectFrom + "] option:selected").toArray();
            jQuery("#"+moveTo).append(selectedItems);
            jQuery("#"+moveTo).sortOptions();
            validateAddInvestmentLink();
        });
    });


    function updateSelection() {
        <#if (endMarkets?has_content)>
            <#list endMarketKeySet as key>
                <#assign endMarket = endMarkets.get(key) />
                <#if value?? && value?is_sequence && value?seq_contains(key)>
                    selectedList[${key?c}] = "${endMarket}";
                <#else>
                    unSelectedList[${key?c}] = "${endMarket}";
                </#if>
            </#list>

        </#if>
        jQuery("#availableEndMarkets<#if id?? && id != ''>_${id}</#if>").empty();
        jQuery.each(unSelectedList, function(k, v){
            jQuery("#availableEndMarkets<#if id?? && id != ''>_${id}</#if>").append("<option value='"+k+"'>"+v+"</option>")
        });
        jQuery("#${name}<#if id?? && id != ''>_${id}</#if>").empty();
        jQuery.each(selectedList,function(k, v){
            jQuery("#${name}<#if id?? && id != ''>_${id}</#if>").append("<option value='"+k+"'>"+v+"</option>")
        });
    }

    jQuery("#endmarkets-reload").click(function() {
        jQuery("#endMarkets<#if id?? && id != ''>_${id}</#if> option").each(function()
        {
            jQuery("#availableEndMarkets<#if id?? && id != ''>_${id}</#if>").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#availableEndMarkets<#if id?? && id != ''>_${id}</#if>").sortOptions();
        });
        validateAddInvestmentLink();
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>
</#macro>


<!-- Multiple End Market Macro starts -->
<#macro showEndMarketFieldSection name='' value=0 label='' readonly=false validate=false >
<div class="form-select_div">
    <label>List of End Markets</label>
    <@renderEndMarketField name='availableEndMarkets' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="endmarketsMM-reload" href="javascript:void(0);"></a>
        <input id="addEndMarketMMBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeEndMarketMMBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>Selected List of End Markets</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class="" ></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
    <#attempt>
        <@macroCustomFieldErrors msg="Please choose End Markets"/>
        <#recover>
    </#attempt>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addEndMarketMMBtn, #removeEndMarketMMBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addEndMarketMMBtn" ? "#availableEndMarkets" : "#endMarkets";
            var moveTo = (id == "addEndMarketMMBtn") ? "#endMarkets" : "#availableEndMarkets";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            if(id == "addEndMarketMMBtn")
            {
                var maxCountryCount = ${JiveGlobals.getJiveIntProperty("grail.multimarket.country.limit", 10)?c};
                var items = jQuery("#endMarkets option").size();
                var newItems = selectedItems.length;
                if((items + newItems)>maxCountryCount)
                {
                    dialog({
                        title: 'Message',
                        html: '<p>MAXIMUM '+ maxCountryCount +' endmarkets are allowed </p>'
                    });
                }
                else
                {
                    jQuery(moveTo).append(selectedItems);
                    jQuery(moveTo).sortOptions();
                    <#if validate>
                        validateAddInvestmentLink();
                    </#if>
                }
            }
            else
            {
                <#if validate>
                    if(checkInvestmentGrid(selectedItems))
                    {
                        jQuery(moveTo).append(selectedItems);
                        jQuery(moveTo).sortOptions();
                        validateAddInvestmentLink();
                    }
                    else
                    {
                        dialog({
                            title: 'Message',
                            html: '<p>Please remove the relevant entry from the investment grid to be able to remove the end market(s) </p>'
                        });
                    }

                <#else>
                    jQuery(moveTo).append(selectedItems);
                    jQuery(moveTo).sortOptions();
                </#if>
            }
        });
        jQuery("#addEndMarketMMBtn").click();
        jQuery("#availableEndMarkets").sortOptions();

    });

    jQuery("#endmarketsMM-reload").click(function() {

        var allItems = jQuery("#endMarkets option").toArray();

        <#if validate>
            if(checkInvestmentGrid(allItems))
            {
                jQuery("#endMarkets option").each(function()
                {
                    jQuery("#availableEndMarkets").append(new Option(jQuery(this).text(), jQuery(this).val()));
                    jQuery(this).remove();
                });
                jQuery("#availableEndMarkets").sortOptions();
            }
            else
            {
                dialog({
                    title: 'Message',
                    html: '<p>Please remove the relevant entry from the investment grid to be able to remove the end market(s) </p>'
                });
            }
        <#else>
            jQuery("#endMarkets option").each(function()
            {
                jQuery("#availableEndMarkets").append(new Option(jQuery(this).text(), jQuery(this).val()));
                jQuery(this).remove();
            });
            jQuery("#availableEndMarkets").sortOptions();
        </#if>

        <#if validate>
            validateAddInvestmentLink();
        </#if>
    });

    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>
</#macro>

<!-- Multiple Updated End Market Macro starts -->
<#macro showUpdatedEndMarketFieldSection name='' value=0 label='' readonly=false validate=false>
<div class="form-select_div">
    <label class="label_b"><#if label!=''><@s.text name=label/><#else>Research End Markets</#if><span>*</span></label> <span class="list">List of End Markets</span>
<#-- <@renderEndMarketField name='availableEndMarketsAll' value=value multiselect=true readonly=readonly/>-->
    <@renderNotDisplaySelectedEndMarketField name='availableEndMarketsAll' value=value multiselect=true readonly=readonly/>

    <div class="action_buttons">
        <a id="endmarkets-reload" href="javascript:void(0);"></a>
        <input id="addEndMarketBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeEndMarketBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label><span class="list">Selected List of End Markets</span></label>
    <#if readonly>
    <#--<select size="3" name="${name}" id="${name}" disabled multiple="yes" class="" ></select>-->
        <@renderSelectedEndMarketField name=name value=value multiselect=true readonly=readonly/>

    <#else>
    <#--<select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>-->
        <@renderSelectedEndMarketField name=name value=value multiselect=true readonly=readonly/>
    </#if>
    <#attempt>
        <@macroCustomFieldErrors msg="Please choose End Markets"/>
        <#recover>
    </#attempt>

</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addEndMarketBtn, #removeEndMarketBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addEndMarketBtn" ? "#availableEndMarketsAll" : "#updatedEndMarkets";
            var moveTo = (id == "addEndMarketBtn") ? "#updatedEndMarkets" : "#availableEndMarketsAll";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            if(id == "addEndMarketBtn")
            {
                var maxCountryCount = ${JiveGlobals.getJiveIntProperty("grail.multimarket.country.limit", 10)?c};
                var items = jQuery("#updatedEndMarkets option").size();
                var newItems = selectedItems.length;
                if((items + newItems)>maxCountryCount)
                {
                    dialog({
                        title: 'Message',
                        html: '<p>MAXIMUM '+ maxCountryCount +' endmarkets are allowed </p>'
                    });
                }
                else
                {
                    jQuery(moveTo).append(selectedItems);
                    jQuery(moveTo).sortOptions();
                }
            }
            else
            {
                <#if validate>
                    if(checkInvestmentGrid(selectedItems))
                    {
                        jQuery(moveTo).append(selectedItems);
                        jQuery(moveTo).sortOptions();
                    }
                    else
                    {
                        dialog({
                            title: 'Message',
                            html: '<p>Please remove the relevant entry from the investment grid to be able to remove the end market(s) </p>'
                        });
                    }

                <#else>
                    jQuery(moveTo).append(selectedItems);
                    jQuery(moveTo).sortOptions();
                </#if>
            }
        });
        jQuery("#availableEndMarketsAll").sortOptions();
    });

    jQuery("#endmarkets-reload").click(function() {
        var allItems = jQuery("#updatedEndMarkets option").toArray();

        <#if validate>
            if(checkInvestmentGrid(allItems))
            {
                jQuery("#updatedEndMarkets option").each(function()
                {
                    jQuery("#availableEndMarketsAll").append(new Option(jQuery(this).text(), jQuery(this).val()));
                    jQuery(this).remove();
                });
                jQuery("#availableEndMarketsAll").sortOptions();
            }
            else
            {
                dialog({
                    title: 'Message',
                    html: '<p>Please remove the relevant entry from the investment grid to be able to remove the end market(s) </p>'
                });
            }
        <#else>
            jQuery("#updatedEndMarkets option").each(function()
            {
                jQuery("#availableEndMarketsAll").append(new Option(jQuery(this).text(), jQuery(this).val()));
                jQuery(this).remove();
            });
            jQuery("#availableEndMarketsAll").sortOptions();
        </#if>

    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>
</#macro>

<#macro renderEndMarketField name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'endMarkets'/>
    <#else>
        <#assign name = 'endMarket'/>
    </#if>
    <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
    <#assign endMarketKeySet = endMarkets.keySet() />
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#if (endMarkets?has_content)>
        <#list endMarketKeySet as key>
            <#assign endMarket = endMarkets.get(key) />
            <option value="${key?c}" <#if value?? && value?is_sequence && value?seq_contains(key)>selected="true"</#if>>${endMarket}</option>
        </#list>
    </#if>
</select>
</#macro>

<#macro displayEndMarketField name='' value='-1' label=''>
<div class="form-select_div_brand">
    <select size="3" name="${name}" id="${name}" disabled multiple="yes" class="">
        <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
        <#assign endMarketKeySet = endMarkets.keySet() />

        <#if (endMarkets?has_content)>
            <#list endMarketKeySet as key>
                <#assign endMarket = endMarkets.get(key) />
                <#if value?? && value?is_sequence && value?seq_contains(key)><option value="${key?c}">${endMarket}</option></#if>
            </#list>
        </#if>
    </select>
</div>
</#macro>


<#macro renderSelectedEndMarketField name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'endMarkets'/>
    <#else>
        <#assign name = 'endMarket'/>
    </#if>
    <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
    <#assign endMarketKeySet = endMarkets.keySet() />
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#if (endMarkets?has_content)>
        <#list endMarketKeySet as key>
            <#assign endMarket = endMarkets.get(key) />
            <#if value?? && value?is_sequence && value?seq_contains(key)> <option value="${key?c}" >${endMarket}</option></#if>
        </#list>
    </#if>
</select>
</#macro>

<#macro renderNotDisplaySelectedEndMarketField name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'endMarkets'/>
    <#else>
        <#assign name = 'endMarket'/>
    </#if>
    <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
    <#assign endMarketKeySet = endMarkets.keySet() />
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#if (endMarkets?has_content)>
        <#list endMarketKeySet as key>
            <#assign endMarket = endMarkets.get(key) />
            <#if value?? && value?is_sequence && value?seq_contains(key)> <#else><option value="${key?c}" >${endMarket}</option></#if>
        </#list>
    </#if>
</select>
</#macro>

<!-- Multiple End Market Macro ends -->
<#macro renderSelectOwnerField name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Project Owner</#if></label>
    <@renderProjectFieldSection name='allOwners' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="owner-reload" href="javascript:void(0);"></a>
        <input id="addOwnerBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeOwnerBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addOwnerBtn, #removeOwnerBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addOwnerBtn" ? "#allOwners" : "#ownerfield";
            var moveTo = (id == "addOwnerBtn") ? "#ownerfield" : "#allOwners";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allOwners").sortOptions();
    });

    jQuery("#owner-reload").click(function() {
        jQuery("#ownerfield option").each(function()
        {
            jQuery("#allOwners").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allOwners").sortOptions();
        });
    });

    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<#macro renderProjectFieldSection name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allOwners'/>
    <#else>
        <#assign name = 'allOwners	'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#list jiveContext.getSpringBean("synchroUtils").getProjectOwnerUsers() as user>
        <#if user.enabled?? && user.enabled>
            <option value="${user.ID?c}">${user.name?string}</option>
        </#if>
    </#list>
</select>
</#macro>

<#macro renderMethodologyGroupField name='' id="" value='' multiselect=false readonly=false>
    <#if ! name?exists>
        <#assign name = 'methodologyGroup'/>
    <#else>
        <#assign name = 'methodologyGroups'/>
    </#if>
    <#if ! value??>
        <#assign value = "0"/>
    </#if>

    <#assign methodologyGroups = statics['com.grail.synchro.SynchroGlobal'].getMethodologyGroups(true, 1) />
    <#if readonly>
    <select name="${name}" id="${name}<#if id?? && id != ''>_${id}</#if>" disabled class="form-select">
    <#else>
    <select name="${name}" id="${name}<#if id?? && id != ''>_${id}</#if>" class="form-select">
    </#if>
    <option value="-1">-- None --</option>
    <#if (methodologyGroups?has_content)>
        <#list methodologyGroups.keySet() as key>
            <#assign methodologyGroup = methodologyGroups.get(key)/>
            <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${methodologyGroup}</option>
        </#list>
    </#if>
</select>
</#macro>

<#macro renderProposedMethodologyGroupField name='' value='' readonly=false>
    <#if !name?exists>
        <#assign name = 'proposedMethodology'/>
    </#if>
    <#if !value??>
        <#assign value = "-1" />
    </#if>

    <#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getMethodologies() />
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled class="endmarket-multiple-select">
    <#else>
    <select size="3" name="${name}" id="${name}" class="endmarket-multiple-select">
    </#if>
    <option value="-1">-- None --</option>
    <#if (methodologies?has_content)>
        <#list methodologies.keySet() as key>
            <#assign methodology = methodologies.get(key)/>
            <option value="${key?c}" <#if value?number == key?number>selected</#if>>${methodology}</option>
        </#list>
    </#if>

    <#if value?? && value?is_sequence>
        <#assign inActiveMethodogies = statics['com.grail.synchro.SynchroGlobal'].getSelectedInActiveMethodologyFields(value) />
        <#if (inActiveMethodogies?has_content)>
            <#assign inActiveMethodologyKeySet = inActiveMethodogies.keySet() />
            <#list inActiveMethodologyKeySet as key1>
                <#assign inActiveMethodolgyType = inActiveMethodogies.get(key1) />
                <option value="${key1?c}" disabled>${inActiveMethodolgyType}</option>
            </#list>
        </#if>
    </#if>
</select>
<script type="text/javascript">
    jQuery(document).ready(function(){
        jQuery("#${name}").sortOptions();

    });

    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>
</#macro>

<!-- Multi-select Proposed Methodology Starts -->
<#macro renderSelectedProposedMethodologyMultiSelect name='' id='' value=[] label='' methodologyGroup='' readonly=false>
    <#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getMethodologiesByGroup(false,methodologyGroup) />
    <#assign methodologyKeySet = methodologies.keySet() />


<div class="form-select_div">
    <label class="proposal-label"><#if label!=''>${label}<#else><@s.text name="project.initiate.project.proposed.list"/></#if></label>
<#--<@renderAllProposedMethodologyField name='allProposedMethodologyFields' value=value multiselect=true readonly=readonly />-->
    <#if readonly>
    <select size="3" name="allProposedMethodologyFields" id="allProposedMethodologyFields<#if id?? && id != ''>_${id}</#if>" disabled multiple="yes" class="">
    <#else>
    <select size="3" name="allProposedMethodologyFields" id="allProposedMethodologyFields<#if id?? && id != ''>_${id}</#if>" multiple="yes" class="">
    </#if>
</select>
    <div class="action_buttons">
        <a id="proposedMethodologyFields-reload<#if id?? && id != ''>_${id}</#if>" href="javascript:void(0);"></a>
        <input id="addProposedMethodologyfieldsBtn<#if id?? && id != ''>_${id}</#if>" type="button" value='>>' class="left_arrow" />
        <input id="removeProposedMethodologyfieldsBtn<#if id?? && id != ''>_${id}</#if>" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label class="proposal-label"><@s.text name="project.initiate.project.proposed.selected"/></label>
    <#if readonly>
    <select size="3" name="${name}" id="${name}<#if id?? && id != ''>_${id}</#if>" disabled multiple="yes" class="">
    <#else>
    <select size="3" name="${name}" id="${name}<#if id?? && id != ''>_${id}</#if>" multiple="yes" class="">
    </#if>

</select>
    <script type="text/javascript">
        var selectedList = {};
        var unSelectedList = {};
        jQuery(function() {
            jQuery("#addProposedMethodologyfieldsBtn<#if id?? && id != ''>_${id}</#if>, #removeProposedMethodologyfieldsBtn<#if id?? && id != ''>_${id}</#if>").click(function(event) {
                var id = jQuery(event.target).attr("id");
                var selectFrom = id == "addProposedMethodologyfieldsBtn<#if id?? && id != ''>_${id}</#if>" ? "#allProposedMethodologyFields<#if id?? && id != ''>_${id}</#if>" : "#proposedMethodology<#if id?? && id != ''>_${id}</#if>";
                var moveTo = (id == "addProposedMethodologyfieldsBtn<#if id?? && id != ''>_${id}</#if>") ? "#proposedMethodology<#if id?? && id != ''>_${id}</#if>" : "#allProposedMethodologyFields<#if id?? && id != ''>_${id}</#if>";
                var selectedItems = jQuery(selectFrom + " :selected").toArray();
                jQuery(moveTo).append(selectedItems);
            });
            updateProposedMethodologySelection();
        });

        function updateProposedMethodologySelection() {
            <#if (methodologies?has_content)>
                <#list methodologyKeySet as key>
                    <#assign methodology = methodologies.get(key) />
                    <#if value?? && value?is_sequence && value?seq_contains(key)>
                        selectedList[${key?c}] = "${methodology}";
                    <#else>
                        unSelectedList[${key?c}] = "${methodology}";
                    </#if>
                </#list>

            </#if>

            <#if value?? && value?is_sequence>
                <#assign inActiveMethodogies = statics['com.grail.synchro.SynchroGlobal'].getSelectedInActiveMethodologyFields(value) />
                <#if (inActiveMethodogies?has_content)>
                    <#assign inActiveMethodologyKeySet = inActiveMethodogies.keySet() />
                    <#list inActiveMethodologyKeySet as key1>
                        <#assign inActiveMethodolgyType = inActiveMethodogies.get(key1) />
                        selectedList[${key1?c}] = "${inActiveMethodolgyType}";
                    </#list>
                </#if>
            </#if>
            jQuery("#allProposedMethodologyFields<#if id?? && id != ''>_${id}</#if>").empty();
            jQuery.each(unSelectedList, function(k, v){
                jQuery("#allProposedMethodologyFields<#if id?? && id != ''>_${id}</#if>").append("<option value='"+k+"'>"+v+"</option>")
            });
            jQuery("#${name}<#if id?? && id != ''>_${id}</#if>").empty();
            jQuery.each(selectedList,function(k, v){
                jQuery("#${name}<#if id?? && id != ''>_${id}</#if>").append("<option value='"+k+"'>"+v+"</option>")
            });
        }

        jQuery(document).ready(function(){
            jQuery("#${name}").sortOptions();
        });

        jQuery("#proposedMethodologyFields-reload<#if id?? && id != ''>_${id}</#if>").click(function() {

            jQuery('#proposedMethodology<#if id?? && id != ''>_${id}</#if> option').attr('selected', 'selected');
            var selectedItems = jQuery("#proposedMethodology<#if id?? && id != ''>_${id}</#if> :selected").toArray();
            jQuery("#allProposedMethodologyFields<#if id?? && id != ''>_${id}</#if>").append(selectedItems);
        });
        jQuery.fn.sortOptions = function(){
            jQuery(this).each(function(){
                var op = jQuery(this).children("option");
                op.sort(function(a, b) {
                    return a.text > b.text ? 1 : -1;
                })
                return jQuery(this).empty().append(op);
            });
        }
    </script>
</div>


</#macro>

<!-- Multi-select Proposed Methodology Starts -->
<#macro renderProposedMethodologyMultiSelect name='' value='-1' label='' readonly=false>
<div class="form-select_div">
    <label class="proposal-label"><#if label!=''>${label}<#else><@s.text name="project.initiate.project.proposed.list"/></#if></label>
    <@renderAllProposedMethodologyField name='allProposedMethodologyFields' value=value multiselect=true readonly=readonly />
    <div class="action_buttons">
        <a id="proposedMethodologyFields-reload" href="javascript:void(0);"></a>
        <input id="addProposedMethodologyfieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeProposedMethodologyfieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label class="proposal-label"><@s.text name="project.initiate.project.proposed.selected"/></label>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled multiple="yes" class="">
    <#else>
    <select size="3" name="${name}" id="${name}" multiple="yes" class="">
    </#if>
    <#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getMethodologies() />
    <#assign methodologyKeySet = methodologies.keySet() />
    <#if (methodologies?has_content)>
        <#list methodologyKeySet as key>
            <#assign methodologyType = methodologies.get(key) />
            <#if value?? && value?is_sequence && value?seq_contains(key)><option value="${key?c}" selected="false">${methodologyType}</option></#if>
        </#list>
    </#if>
    <#if value?? && value?is_sequence>
        <#assign inActiveMethodogies = statics['com.grail.synchro.SynchroGlobal'].getSelectedInActiveMethodologyFields(value) />
        <#if (inActiveMethodogies?has_content)>
            <#assign inActiveMethodologyKeySet = inActiveMethodogies.keySet() />
            <#list inActiveMethodologyKeySet as key1>
                <#assign inActiveMethodolgyType = inActiveMethodogies.get(key1) />
                <option value="${key1?c}">${inActiveMethodolgyType}</option>
            </#list>
        </#if>
    </#if>
</select>

</div>

<script type="text/javascript">
    jQuery(document).ready(function(){
        jQuery("#${name}").sortOptions();
    });
    jQuery(function() {
        jQuery("#addProposedMethodologyfieldsBtn, #removeProposedMethodologyfieldsBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addProposedMethodologyfieldsBtn" ? "#allProposedMethodologyFields" : "#proposedMethodology";
            var moveTo = (id == "addProposedMethodologyfieldsBtn") ? "#proposedMethodology" : "#allProposedMethodologyFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
        });
    });

    jQuery("#proposedMethodologyFields-reload").click(function() {

      //  jQuery('#proposedMethodology option').attr('selected', 'selected');
	    jQuery('#proposedMethodology option').prop('selected', true);
        var selectedItems = jQuery("#proposedMethodology :selected").toArray();
        jQuery("#allProposedMethodologyFields").append(selectedItems);
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }

    jQuery("#allProposedMethodologyFields").attr("selectedIndex", -1);
    jQuery("#${name}").attr("selectedIndex", -1);

</script>
</#macro>

<#macro renderAllProposedMethodologyField name='' value=[] multiselect=false readonly=false>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getMethodologies() />
    <#assign methodologyKeySet = methodologies.keySet() />

    <#if (methodologies?has_content)>
        <#list methodologyKeySet as key>
            <#assign methodologyType = methodologies.get(key) />
            <#if !(value?? && value?is_sequence && value?seq_contains(key))> <option value="${key?c}">${methodologyType}</option></#if>
        </#list>
    </#if>
</select>
</#macro>

<#macro displayProposedMethodologyMultiSelect name='' value='-1' label=''>
<select size="3" name="${name}" id="${name}" disabled multiple="yes" class="">
    <#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getMethodologies() />
    <#assign methodologyKeySet = methodologies.keySet() />
    <#if (methodologies?has_content)>
        <#list methodologyKeySet as key>
            <#assign methodologyType = methodologies.get(key) />
            <#if value?? && value?is_sequence && value?seq_contains(key)><option value="${key?c}">${methodologyType}</option></#if>
        </#list>
    </#if>
    <#if value?? && value?is_sequence>
        <#assign inActiveMethodogies = statics['com.grail.synchro.SynchroGlobal'].getSelectedInActiveMethodologyFields(value) />
        <#if (inActiveMethodogies?has_content)>
            <#assign inActiveMethodologyKeySet = inActiveMethodogies.keySet() />
            <#list inActiveMethodologyKeySet as key1>
                <#assign inActiveMethodolgyType = inActiveMethodogies.get(key1) />
                <option value="${key1?c}"  disabled>${inActiveMethodolgyType}</option>
            </#list>
        </#if>
    </#if>
</select>
<script type="text/javascript">
    jQuery("#${name}").attr("selectedIndex", -1);
    jQuery(document).ready(function(){
        jQuery("#${name}").sortOptions();
    });

    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>
</#macro>




<#macro displayProposedMethodologyMultiSelectAdmin name='' value=[] multiselect=false readonly=false>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getMethodologies() />
    <#assign methodologyKeySet = methodologies.keySet() />
    <#if (methodologies?has_content)>
        <#list methodologyKeySet as key>
            <#assign methodologyType = methodologies.get(key) />
            <option value="${key?c}" <#if value?? && value?is_sequence && value?seq_contains(key)> selected="true" </#if> >${methodologyType}</option>
        </#list>
    </#if>
    <#if value?? && value?is_sequence>
        <#assign inActiveMethodogies = statics['com.grail.synchro.SynchroGlobal'].getSelectedInActiveMethodologyFields(value) />
        <#if (inActiveMethodogies?has_content)>
            <#assign inActiveMethodologyKeySet = inActiveMethodogies.keySet() />
            <#list inActiveMethodologyKeySet as key1>
                <#assign inActiveMethodolgyType = inActiveMethodogies.get(key1) />
                <option value="${key1?c}" selected disabled>${inActiveMethodolgyType}</option>
            </#list>
        </#if>
    </#if>
</select>
<script type="text/javascript">
    jQuery(document).ready(function(){
        jQuery("#${name}").sortOptions();
    });

    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<!-- Multi-select Proposed Methodology Ends -->

<#macro renderProposedMethodologyGroupFieldPIB name='' value='' multiselect=false readonly=false methGroup=''>
    <#if !name?exists>
        <#assign name = 'proposedMethodology'/>
    </#if>
    <#if !value??>
        <#assign value = "-1" />
    </#if>

    <#attempt>
        <#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getMethodologyMapping().get(methGroup?int) />
        <#recover>
    </#attempt>
    <#if readonly>
    <select name="${name}" id="${name}" disabled class="form-select">
    <#else>
    <select name="${name}" id="${name}" class="form-select">
    </#if>
    <option value="-1">None of These</option>
    <#if methodologies?? && methodologies?has_content>
        <#list methodologies.keySet() as key>
            <#assign methodology = methodologies.get(key)/>
            <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${methodology}</option>
        </#list>
    </#if>
</select>
</#macro>

<#macro renderBrandField name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
    <#if !name?exists>
        <#assign name = 'brand'/>
    <#else>
        <#assign name = 'brands'/>
    </#if>
    <#if readonly>
    <select name="${name}" id="${name}" disabled <#if waiver>class="form-select waiver-readonly" <#else>class="form-select" </#if> <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select name="${name}" id="${name}" class="form-select" <#if multiselect>multiple="yes"</#if>>
    </#if>

    <option  value="-1" <#if !selectNone>disabled </#if>>Select Brand</option>
    <#assign brands = statics['com.grail.synchro.SynchroGlobal'].getAllBrands() />
    <#if (brands?has_content)>
        <#list brands.keySet() as key>
            <#assign brand = brands.get(key)/>
            <option value="${key?c}" <#if value?number == key?number>selected="selected"</#if>>${brand}</option>
        </#list>
    </#if>
</select>
</#macro>


<#macro renderBrandFieldPWNew name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
  
	<#if !name?exists>
        <#assign name = 'brand'/>
    <#else>
        <#assign name = 'brands'/>
    </#if>
	<select title="" data-placeholder="Select the Brand" class="chosen-select" id = "${name}" name='${name}' <#if readonly>disabled</#if>>
	<option value="-1"></option>
	
	<#assign brands = statics['com.grail.synchro.SynchroGlobal'].getAllBrands() />
    <#if (brands?has_content)>
        <#list brands.keySet() as key>
            <#assign brand = brands.get(key)/>
            <option value="${key?c}" <#if value?number == key?number>selected="selected"</#if>>${brand}</option>
        </#list>
    </#if>
	</select>
</#macro>

<#macro renderMethodologyApproverField name='approver' value=-1 id=id readonly=false>
    <#assign methodologyApprovers = jiveContext.getSpringBean("synchroUtils").getSynchroMethodologyApprovers() />
    <#if readonly>
    <select disabled name="${name}" id="${id}" class="form-select">
    <#else>
    <select name="${name}" id="${id}" class="form-select">
    </#if>

    <option email="" value="" disabled>- None -</option>
    <#if (methodologyApprovers?has_content)>
        <#list methodologyApprovers as methodologyApprover>
            <option email="${methodologyApprover.getEmail()}" value="${methodologyApprover.ID?c}" <#if value == methodologyApprover.ID?c>selected="true"</#if>>${methodologyApprover.name}</option>
        </#list>
    </#if>
</select>
</#macro>

<#macro renderKantarMethodologyApproverField name='approver' value=-1 id=id readonly=false>
    <#assign methodologyApprovers = jiveContext.getSpringBean("synchroUtils").getSynchroKantarMethodologyApprovers() />
    <#if readonly>
    <select disabled name="${name}" id="${id}" class="form-select">
    <#else>
    <select name="${name}" id="${id}" class="form-select">
    </#if>

    <option email="" value="" disabled>- None -</option>
    <#if (methodologyApprovers?has_content)>
        <#list methodologyApprovers as methodologyApprover>
            <option email="${methodologyApprover.getEmail()}" value="${methodologyApprover.ID?c}" <#if value == methodologyApprover.ID?c>selected="true"</#if>>${methodologyApprover.name}</option>
        </#list>
    </#if>
</select>
</#macro>

<#-- Begin PIB Related Macros -->

<#macro renderCheckBox label='' name='' isChecked=false disable=false>
<div class="check-field" >
    <input type="checkbox" name="${name}_display"  onclick="geoSpreadChanged(this, ${name});" id="${name}_display" <#if disable>disabled="true"</#if> <#if isChecked> checked="true"</#if> /> <label for="${name}_display">${label}</label>
    <input type="hidden" name="${name}" id="${name}" <#if isChecked> value="true" <#else> value="false" </#if> />
</div>
</#macro>

<#macro renderReportingCheckBox label='' name='' isChecked=false disable=false>
<div class="check-field" >
    <input type="checkbox" name="${name}_display"  onclick="reportingChanged(this, ${name});" id="${name}_display" <#if disable>disabled="true"</#if> <#if isChecked> checked="true"</#if> /> <label for="${name}_display">${label}</label>
    <input type="hidden" name="${name}" id="${name}" <#if isChecked> value="true" <#else> value="false" </#if> />
</div>
</#macro>

<#macro renderLegalPIBCheckBox label='' name='' isChecked=false disable=false isMandatory=false>
<div class="check-field checkbox-pib" >
    <input type="checkbox" name="${name}_display"  onclick="pibLegalCheckbox(this, ${name});" id="${name}_display" <#if disable>disabled="true"</#if> <#if isChecked> checked="true"</#if> /> <label for="${name}_display">${label}<#if isMandatory><span class="red">*</span></#if></label>
    <input type="hidden" name="${name}" id="${name}" <#if isChecked> value="true" <#else> value="false" </#if> />
</div>
</#macro>

<#macro renderLegalCheckBox label='' name='' isChecked=false disable=false>
<div class="check-field checkbox-pib" >
    <input type="checkbox" name="${name}_display"  onclick="reportingChanged(this, ${name});" id="${name}_display" <#if disable>disabled="true"</#if> <#if isChecked> checked="true"</#if> /> <label for="${name}_display">${label}</label>
    <input type="hidden" name="${name}" id="${name}" <#if isChecked> value="true" <#else> value="false" </#if> />
</div>
</#macro>

<#macro renderChangeStatusAction label='' projectID=-1 multimarket=false changeStatus=true>
<ul class="right-sidebar-list required-actions">
    <#if multimarket>
        <li class="view-field-btn"><a class="o-btn" href="/synchro/current-status-multi!input.jspa?projectID=${projectID?c}&prevStage=${stageId?c}">View Current Status</a></li>
    <#else>
        <li class="view-field-btn"><a class="o-btn" href="/synchro/current-status!input.jspa?projectID=${projectID?c}&prevStage=${stageId?c}">View Current Status</a></li>
    </#if>
    <#if changeStatus>
        <li class="view-field-btn"><a class="o-btn" href="/synchro/project-status!input.jspa?projectID=${projectID?c}">Change Project Status</a></li>
    </#if>
    <#assign canAccessActivityLogs = statics['com.grail.synchro.util.SynchroPermHelper'].canAccessActivityLogs(projectID) />
    <#if canAccessActivityLogs?? && canAccessActivityLogs>
        <li class="view-field-btn"><a class="o-btn" href="/synchro/log-dashboard.jspa?projectID=${projectID?c}">View Activity Log</a></li>
    </#if>
</ul>
</#macro>

<#macro renderRadioBox label='' name='' id='' value='' isChecked=false disable=false>
<div class="check-field" >
    <input type="radio" name="${name}" id="${id}" value="${value}" onclick="geoSpreadRadioChanged(this, ${name});" <#if disable>disabled="true"</#if> <#if isChecked> checked="true"</#if> /> <label for="${id}">${label}</label>

</div>
</#macro>

<#macro renderRadioBoxMultiMarket label='' name='' id='' value='' isChecked=false disable=false selectedIndex=0>
<div class="check-field" >
    <input type="radio" name="${name}" id="${id}" value="${value}" onclick="geoSpreadRadioChangedMultiMarket(this, ${name}, ${selectedIndex});" <#if disable>disabled="true"</#if> <#if isChecked> checked="true"</#if> /> <label for="${id}">${label}</label>

</div>
</#macro>

<#macro renderLegalRadioBox label='' name='' id='' value='' isChecked=false disable=false>
<div class="check-field checkbox-pib" >
    <input type="radio" name="${name}" id="${id}" value="${value}"  <#if disable>disabled="true"</#if> <#if isChecked> checked="true"</#if> /> <label for="${id}">${label}</label>
</div>


</#macro>

<#-- End PIB Related Macros -->

<#macro renderSupplierGroupField name='' value=0 multiselect=false >
<select name="${name}" id="${name}" class="form-select sortList" <#if multiselect>multiple="yes"</#if> onchange=javascript:changeSuppliers(${caID?c});>
    <option value="-1" disabled>-- None --</option>
    <#assign supplierGroups = statics['com.grail.synchro.SynchroGlobal'].getSupplierGroup() />
    <#if (supplierGroups?has_content)>
        <#list supplierGroups.keySet() as key>
            <#assign supplierGroup = supplierGroups.get(key)/>
            <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${supplierGroup}</option>
        </#list>
    </#if>
</select>

<script type="text/javascript">
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
    jQuery(".sortList").sortOptions();
    jQuery(".sortList").removeClass("sortList");
</script>
</#macro>




<#macro showDataCollectionFieldSection name='' value=0 label='' readonly=false selectedIndex=0 >
<div class="form-select_div data-collection-all-div">
    <label class="label_b"><#if label!=''><@s.text name=label/><#else>Data Collection Methods</#if> <span class="list">List of Data Collection Methods</span></label>
    <@renderDataCollection name='availableDataCollection' value=value multiselect=true readonly=readonly id='availableDataCollection_${selectedIndex}'/>
    <div class="action_buttons">
        <a id="dataCollection-reload_${selectedIndex}" href="javascript:void(0);"></a>
        <input id="addDataCollectionBtn_${selectedIndex}" type="button" value='>>' class="left_arrow" />
        <input id="removeDataCollectionBtn_${selectedIndex}" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;<span class="list">Selected List of Data Collection Methods</span></label>
    <#if readonly>
    <select size="3" name="${name}" id="${name}_${selectedIndex}" disabled multiple="yes" class="large">
    <#else>
    <select size="3" name="${name}_${selectedIndex}" id="${name}_${selectedIndex}" multiple="yes" class="large">
    </#if>
    <#assign dataCollections = statics['com.grail.synchro.SynchroGlobal'].getDataCollections() />
    <#assign dataCollectionsKeySet = dataCollections.keySet() />
    <#if (dataCollections?has_content)>
        <#list dataCollectionsKeySet as key>
            <#assign dataCollection = dataCollections.get(key) />
            <#if value?? && value?is_sequence && value?seq_contains(key)><option value="${key?c}">${dataCollection}</option></#if>
        </#list>
    </#if>
</select>
    <#attempt>
        <@macroCustomFieldErrors msg="Please choose Data Collection Method"/>
        <#recover>
    </#attempt>

</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addDataCollectionBtn_${selectedIndex}, #removeDataCollectionBtn_${selectedIndex}").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addDataCollectionBtn_${selectedIndex}" ? "#availableDataCollection_${selectedIndex}" : "#dataCollectionMethod_${selectedIndex}";
            var moveTo = (id == "addDataCollectionBtn_${selectedIndex}") ? "#dataCollectionMethod_${selectedIndex}" : "#availableDataCollection_${selectedIndex}";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            //jQuery(moveTo).sortOptions();
        });
        // jQuery("#availableDataCollection_${selectedIndex}").sortOptions();
    });

    jQuery("#dataCollection-reload_${selectedIndex}").click(function() {
        jQuery("#dataCollectionMethod_${selectedIndex} option").each(function()
        {
            jQuery("#availableDataCollection_${selectedIndex}").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            //  jQuery("#availableDataCollection_${selectedIndex}").sortOptions();
        });
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>
<#macro renderDataCollection name='' value=[] multiselect=false class='' readonly=false id=''>
    <#assign dataCollections = statics['com.grail.synchro.SynchroGlobal'].getDataCollections() />

    <#if readonly>
    <select name="${name}" id="${id}" disabled <#if multiselect?? && multiselect>multiple="yes"</#if> <#if class!="">class="${class}"<#else>class="select_field large"</#if>>
    <#else>
    <select name="${name}" id="${id}" <#if multiselect?? && multiselect>multiple="yes"</#if> <#if class!="">class="${class}"<#else>class="select_field large"</#if>>
    </#if>
    <option value="-1" disabled>-- None --</option>
<#--<#if (dataCollections?has_content)>
    <#list dataCollections.keySet() as key>
        <#assign dataCollection = dataCollections.get(key) />
        <option value="${key?c}" <#if value?is_sequence && value?seq_contains(key)>selected="true"</#if>>${dataCollection}</option>
    </#list>
</#if>-->
    <#assign dataCollectionsKeySet = dataCollections.keySet() />
    <#if (dataCollections?has_content)>
        <#list dataCollectionsKeySet as key>
            <#assign dataCollection = dataCollections.get(key) />
            <#if !(value?? && value?is_sequence && value?seq_contains(key))> <option value="${key?c}">${dataCollection}</option></#if>
        </#list>
    </#if>
</select>
</#macro>

<#macro macroCustomFieldErrors msg='' class=''>
    <#if class==''>
    <span class="jive-error-message" style="display:none">${msg?html}</span>
    <#else>
    <span class="jive-error-message ${class}" style="display:none">${msg?html}</span>
    </#if>
</#macro>

<#macro macroCurrencySelectError msg='' class=''>
    <#if class==''>
    <p class="jive-error-message" style="display:none">${msg?html}</p>
    <#else>
    <p class="jive-error-message ${class}" style="display:none">${msg?html}</p>
    </#if>
</#macro>

<#-- Macro for Attachment Upload -->
<#macro synchroWaiverAttachements attachments canAttach=false attachmentCount=0 maxAttachCount=30>
    <#if (attachments?? && (attachments?size>0)) || (maxAttachCount > 0) >
        <@macroFieldErrors name="attachFile" />
    <div id="jive-add-attachment" class="clearfix">
        <div class="waiver-attach-text">
            <span class="jive-compose-attach"><span class="jive-icon-med jive-icon-attachment"></span><#if canAttach><@s.text name="post.attach_files.gtitle"/><#else><@s.text name="post.attached_files.gtitle"/></#if></span>
            <#if (canAttach)>
                <span id="jive-attach-maxsize" class="jive-compose-directions font-color-meta-light"><@s.text name="attach.maxSize.text" /><@s.text name="global.colon" /> ${statics['com.jivesoftware.util.ByteFormat'].getInstance().formatKB(jiveContext.attachmentManager.maxAttachmentSize)}
                    , <#if (jiveContext.attachmentManager.allowAllByDefault)><#if (!jiveContext.attachmentManager.disallowedTypes.empty)><@s.text name="doc.create.flTypesNotAllwd.text" /><@s.text name="global.colon" />&nbsp;<#list jiveContext.attachmentManager.disallowedTypesAsFileExtensions as extension>${extension?html}<#if extension_has_next>, </#if></#list><#else><@s.text name="attach.allTypesAllowed.text" /></#if><#else><@s.text name="doc.create.flTypesAllowed.text" /><@s.text name="global.colon" />&nbsp;<#if (!jiveContext.attachmentManager.allowedTypes.empty)><#list jiveContext.attachmentManager.allowedTypesAsFileExtensions as extension>${extension?html}<#if extension_has_next><@s.text name="global.comma" />&nbsp;</#if></#list><#else><@s.text name="doc.create.noFlTypesAllwd.text" /></#if></#if>
                    </span>
            </#if>
            <span id="jive-attach-maxfiles" class="jive-compose-directions font-color-meta-light" style="display: none;"><@s.text name="post.attach_files_max.label"><@s.param>${maxAttachCount}</@s.param></@s.text></span>
        </div>

        <!-- This is where the multi file output will appear -->

        <div id="waiver-file-list" class="jive-attachments">
            <#assign hasAttachments = false />
            <#list attachments as attachment>
                <#assign hasAttachments = true />
                <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                    <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />">
                    ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                    </a>
                    <#if (canAttach)>
                        <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="multi_selector.removeAttachment('jive-attachment-${attachment.ID?c}', ${attachment.ID?c});return false;"><@s.text name="global.remove" /></a>
                    </#if>
                </div>
            </#list>
            <#if !hasAttachments>
                <span style="font-style: italic;">No Attachments Found</span>
            </#if>

        </div>

        <#if (canAttach)>
            <a class="j-attachment-button j-btn-global">
                <span class="j-button-text"><@s.text name="global.choose_file" /></span>
                <label for="attachFile" class="j-508-label"><@s.text name="global.attachment" /><@s.text name="global.colon" /></label>
                <input type="file" id="attachFile" />
            </a>
        </#if>
    </div>
    </#if>

    <#if canAttach>
    <script language="JavaScript" type="text/javascript">

        <!-- Create an instance of the multiSelector class, pass it the output target and the max number of files -->
            <#assign globalRemove><@s.text name="global.remove" /></#assign>
        var multi_selector = new MultiSelector(document.getElementById('waiver-file-list'), ${maxAttachCount?c}, ${attachmentCount?c}, '${globalRemove?js_string}');
        <!-- Pass in the file element -->
        multi_selector.addElement(document.getElementById('attachFile'));
            <#if (attachmentCount == 0)>
            jQuery('#waiver-file-list').html('');
            <#else>
            jQuery('#waiver-file-list').show();
            </#if>

        // loop though any files in the remove
    </script>

    </#if>

</#macro>


<#-- Macro for Attachment Upload -->
<#macro synchroTPDSummaryAttachements attachments canAttach=false attachmentCount=0 maxAttachCount=30>
    <#if (attachments?? && (attachments?size>0)) || (maxAttachCount > 0) >
        <@macroFieldErrors name="attachFile" />
    <div id="jive-add-attachment" class="clearfix">
        <#--<div class="waiver-attach-text">
            <span class="jive-compose-attach"><span class="jive-icon-med jive-icon-attachment"></span><#if canAttach><@s.text name="post.attach_files.gtitle"/><#else><@s.text name="post.attached_files.gtitle"/></#if></span>
            <#if (canAttach)>
                <span id="jive-attach-maxsize" class="jive-compose-directions font-color-meta-light"><@s.text name="attach.maxSize.text" /><@s.text name="global.colon" /> ${statics['com.jivesoftware.util.ByteFormat'].getInstance().formatKB(jiveContext.attachmentManager.maxAttachmentSize)}
                    , <#if (jiveContext.attachmentManager.allowAllByDefault)><#if (!jiveContext.attachmentManager.disallowedTypes.empty)><@s.text name="doc.create.flTypesNotAllwd.text" /><@s.text name="global.colon" />&nbsp;<#list jiveContext.attachmentManager.disallowedTypesAsFileExtensions as extension>${extension?html}<#if extension_has_next>, </#if></#list><#else><@s.text name="attach.allTypesAllowed.text" /></#if><#else><@s.text name="doc.create.flTypesAllowed.text" /><@s.text name="global.colon" />&nbsp;<#if (!jiveContext.attachmentManager.allowedTypes.empty)><#list jiveContext.attachmentManager.allowedTypesAsFileExtensions as extension>${extension?html}<#if extension_has_next><@s.text name="global.comma" />&nbsp;</#if></#list><#else><@s.text name="doc.create.noFlTypesAllwd.text" /></#if></#if>
                    </span>
            </#if>
            <span id="jive-attach-maxfiles" class="jive-compose-directions font-color-meta-light" style="display: none;"><@s.text name="post.attach_files_max.label"><@s.param>${maxAttachCount}</@s.param></@s.text></span>
        </div>-->

        <!-- This is where the multi file output will appear -->
		<#if (canAttach)>
            <a class="j-attachment-button jive-icon-attachment custom-attachment-icon">
                <input type="file" id="attachFile" />
            </a>
        </#if>
        <div id="tpdSummary-file-list" class="jive-attachments custom-attachment-list">
            <#assign hasAttachments = false />
            <#list attachments as attachment>
                <#assign hasAttachments = true />
                <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
					<span class="jive-icon-med jive-icon-attachment"></span>
                    <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />">
                    ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                    </a>
                    <#if (canAttach)>
                        <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="multi_selector.removeAttachment('jive-attachment-${attachment.ID?c}', ${attachment.ID?c});return false;"><@s.text name="global.remove" /></a>
						
                    </#if>
                </div>
            </#list>
            <#if !hasAttachments>
              <!--  <span style="font-style: italic;">No Attachments Found</span>  -->
            </#if>

        </div>

        
    </div>
    </#if>

    <#if canAttach>
    <script language="JavaScript" type="text/javascript">

        <!-- Create an instance of the multiSelector class, pass it the output target and the max number of files -->
            <#assign globalRemove><@s.text name="global.remove" /></#assign>
        var multi_selector = new MultiSelector(document.getElementById('tpdSummary-file-list'), ${maxAttachCount?c}, ${attachmentCount?c}, '${globalRemove?js_string}');
        <!-- Pass in the file element -->
        multi_selector.addElement(document.getElementById('attachFile'));
            <#if (attachmentCount == 0)>
            jQuery('#tpdSummary-file-list').html('');
            <#else>
            jQuery('#tpdSummary-file-list').show();
            </#if>

        // loop though any files in the remove
    </script>

    </#if>

</#macro>


<#-- Macro for TPD Summary RS Attachment Upload -->
<#macro synchroTPDSummaryRSAttachements attachments canAttach=false attachmentCount=0 maxAttachCount=30>
    <#if (attachments?? && (attachments?size>0)) || (maxAttachCount > 0) >
        <@macroFieldErrors name="tpdattachFile" />
    <div id="jive-add-attachment" class="clearfix">
       

        <!-- This is where the multi file output will appear -->
		<#if (canAttach)>
            <a class="j-attachment-button jive-icon-attachment custom-attachment-icon">
                <input type="file" id="tpdattachFile" name="tpdattachFile"/>
            </a>
        </#if>
        <div id="tpdSummary-rs-file-list" class="jive-attachments custom-attachment-list">
            <#assign hasAttachments = false />
            <#list attachments as attachment>
                <#assign hasAttachments = true />
                <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
					<span class="jive-icon-med jive-icon-attachment"></span>
                    <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />">
                    ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                    </a>
                    <#if (canAttach)>
                        <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="multi_selector.removeAttachment('jive-attachment-${attachment.ID?c}', ${attachment.ID?c});return false;"><@s.text name="global.remove" /></a>
						
                    </#if>
                </div>
            </#list>
            <#if !hasAttachments>
                <span style="font-style: italic;">No Attachments Found</span>
            </#if>

        </div>

        
    </div>
    </#if>

    <#if canAttach>
    <script language="JavaScript" type="text/javascript">

        <!-- Create an instance of the multiSelector class, pass it the output target and the max number of files -->
            <#assign globalRemove><@s.text name="global.remove" /></#assign>
        var multi_selector = new MultiSelectorName(document.getElementById('tpdSummary-rs-file-list'), ${maxAttachCount?c}, ${attachmentCount?c}, '${globalRemove?js_string}', 'tpdattachFile');
        <!-- Pass in the file element -->
	
        multi_selector.addElement(document.getElementById('tpdattachFile'));
            <#if (attachmentCount == 0)>
            jQuery('#tpdSummary-rs-file-list').html('');
			
            <#else>
            jQuery('#tpdSummary-rs-file-list').show();
			
            </#if>

        // loop though any files in the remove
    </script>

    </#if>

</#macro>



<#macro renderSelectInitiatorField name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Initiator</#if></label>
    <@renderInitiatorFieldSection name='allInitiatorFields' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="initiatorFields-reload" href="javascript:void(0);"></a>
        <input id="addInitiatorfieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeInitiatorfieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addInitiatorfieldsBtn, #removeInitiatorfieldsBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addInitiatorfieldsBtn" ? "#allInitiatorFields" : "#owner";
            var moveTo = (id == "addInitiatorfieldsBtn") ? "select[name='owner']" : "#allInitiatorFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();

            console.log("moveTo " + jQuery(moveTo).val());
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allInitiatorFields").sortOptions();
    });

    jQuery("#initiatorFields-reload").click(function() {
        jQuery("#owner option").each(function()
        {
            jQuery("#allInitiatorFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allInitiatorFields").sortOptions();
        });
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<#macro renderInitiatorFieldSection name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allInitiatorFields'/>
    <#else>
        <#assign name = 'allInitiatorFields'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#list jiveContext.getSpringBean("synchroUtils").getWaiverEligibleInitiators() as user>
        <option value="${user.ID?c}">${user.name?string}</option>
    </#list>
</select>
</#macro>

<!-- Phase 4 GRAIL Macros-->
<#macro renderCategoryTypeField name='' value='-1' label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else><@s.text name="project.initiate.project.category.list"/></#if></label>
    <@renderAllCategoryTypeField name='allCategoryFields' value=value multiselect=true readonly=readonly />
    <div class="action_buttons">
        <a id="categoryFields-reload" href="javascript:void(0);"></a>
        <input id="addCategoryfieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeCategoryfieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label><@s.text name="project.initiate.project.category.selected"/></label>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled multiple="yes" class="">
    <#else>
    <select size="3" name="${name}" id="${name}" multiple="yes" class="">
    </#if>
    <#assign categoryTypes = statics['com.grail.synchro.SynchroGlobal'].getProductTypes() />
    <#assign categoryTypeKeySet = categoryTypes.keySet() />
    <#if (categoryTypes?has_content)>
        <#list categoryTypeKeySet as key>
            <#assign categoryType = categoryTypes.get(key) />
            <#if value?? && value?is_sequence && value?seq_contains(key)><option value="${key?c}">${categoryType}</option></#if>
        </#list>
    </#if>
</select>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addCategoryfieldsBtn, #removeCategoryfieldsBtn").click(function(event) {
            
			var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addCategoryfieldsBtn" ? "#allCategoryFields" : "#categoryType";
            var moveTo = (id == "addCategoryfieldsBtn") ? "#categoryType" : "#allCategoryFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            // jQuery(moveTo).sortOptions();
            processCategoryField();
        });
        // jQuery("#allCategoryFields").sortOptions();

    });

    jQuery("#categoryFields-reload").click(function() {

        //jQuery('#categoryType option').attr('selected', 'selected');
		jQuery('#categoryType option').prop('selected', true);
        var selectedItems = jQuery("#categoryType :selected").toArray();
        jQuery("#allCategoryFields").append(selectedItems);
        //jQuery("#allCategoryFields").sortOptions();

        /*jQuery("#categoryType option").each(function()
          {
             jQuery("#allCategoryFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
              jQuery(this).remove();
              jQuery("#allCategoryFields").sortOptions();
          });
          */
        processCategoryField();
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>
</#macro>

<#macro renderAllCategoryTypeField name='' value=[] multiselect=false readonly=false>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#assign categoryTypes = statics['com.grail.synchro.SynchroGlobal'].getProductTypes() />
    <#assign categoryTypeKeySet = categoryTypes.keySet() />
    <#if (categoryTypes?has_content)>
        <#list categoryTypeKeySet as key>
            <#assign categoryType = categoryTypes.get(key) />
            <#if !(value?? && value?is_sequence && value?seq_contains(key))> <option value="${key?c}">${categoryType}</option></#if>
        </#list>
    </#if>
</select>


</#macro>



<#macro renderEndMarketSingleSelectFld name='endmarket' value=0 disabled=false class=''>
    <#if class?? && class==''>
        <#assign classname='form-select' />
    <#else>
        <#assign classname='${class}' />
    </#if>

    <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
    <#assign endMarketKeySet = endMarkets.keySet() />

<select name="${name}" id="${name}" class="${classname}" <#if disabled>disabled</#if>>
    <option value="-1" disabled>-- None --</option>
    <#if (endMarkets?has_content)>
        <#list endMarketKeySet as key>
            <#assign endMarket = endMarkets.get(key) />
            <#if disabled && value?number == key?number>
                <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${endMarket}</option>
            <#elseif !disabled>
                <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${endMarket}</option>
            </#if>
        </#list>
    </#if>
</select>
<script type="text/javascript">
    jQuery("#${name}").val("${value}");
</script>
</#macro>

<!-- User Filters Starts -->
<#macro renderBrandFilter name='' value=0 readonly=false>
    <#if !name?exists>
        <#assign name = 'brand'/>
    <#else>
        <#assign name = 'brands'/>
    </#if>
    <#if readonly>
    <select name="${name}" id="${name}" disabled class="form-select">
    <#else>
    <select name="${name}" id="${name}" class="form-select synchro-user-filter" onchange="jQuery('#profilesearchform').submit();">
    </#if>

    <option value="-1">Select</option>
    <#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
    <#if (brands?has_content)>
        <#list brands.keySet() as key>
            <#local brandName = brands.get(key)/>
            <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${brandName}</option>
        </#list>
    </#if>
</select>
</#macro>

<#macro renderRoleFilter name='' value=0 readonly=false ownerfield=false>
    <#if ownerfield>
        <#assign roles = statics['com.grail.synchro.SynchroGlobal'].getProjectOwnerRoles() />
        <#assign selectDefaultID = statics['com.grail.synchro.SynchroConstants'].SYNCHRO_PROJECT_OWNER_FIELDID />
    <#else>
        <#assign roles = statics['com.grail.synchro.SynchroGlobal'].getUserRoles() />
        <#assign selectDefaultID = -1 />
    </#if>
    <#if ownerfield>
    <input type="hidden" name="ownerfield" value="${ownerfield?string}"/>
    </#if>
    <#if (readonly) && (value?number &gt; 0)>
        <#local roleValue = ''/>
        <#if (roles?has_content)>
            <#list roles.keySet() as key>
                <#if (key?number == value?number)>
                    <#local roleValue = roles.get(key)/>
                </#if>
            </#list>
        </#if>
    <input type="hidden"  readonly="readonly" value="${roleValue}"/>
    <input type="hidden" id="${name}" name="${name}" value="${value?number}"/>
    <input type="hidden" name="roleEnabled" value="false"/>
    <#else>
    <select name="${name}" id="${name}" class="form-select synchro-user-filter" onchange="jQuery('#profilesearchform').submit();">
        <option value="${selectDefaultID}">Select</option>
        <#if (roles?has_content)>
            <#list roles.keySet() as key>
                <#local roleName = roles.get(key)/>
                <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${roleName}</option>
            </#list>
        </#if>
    </select>
    </#if>

</#macro>

<#macro renderRegionFilter name='' value=0 readonly=false>
    <#if readonly>
    <select name="${name}" id="${name}" disabled class="form-select">
    <#else>
    <select name="${name}" id="${name}" class="form-select synchro-user-filter" onchange="jQuery('#profilesearchform').submit();">
    </#if>
    <option  value="-1">Select</option>
    <#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
    <#if (regions?has_content)>
        <#list regions.keySet() as key>
            <#local regionName = regions.get(key)/>
            <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${regionName}</option>
        </#list>
    </#if>
</select>
</#macro>



<#macro renderCountryFilter name='endmarket' value=0 disabled=false>
    <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
    <#assign endMarketKeySet = endMarkets.keySet() />
<select size="1" name="${name}" id="${name}" class="endmarketlist synchro-user-filter" <#if disabled>disabled</#if> onchange="jQuery('#profilesearchform').submit();">
    <option value="-1">Select</option>
    <#if (endMarkets?has_content)>
        <#list endMarketKeySet as key>
            <#local endMarketName = endMarkets.get(key) />
            <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${endMarketName}</option>
        </#list>
    </#if>
</select>
</#macro>

<#macro renderJobTitleFilter name='' value=0 readonly=false >
    <#if readonly>
    <select name="${name}" id="${name}" disabled class="form-select">
    <#else>
    <select name="${name}" id="${name}" class="form-select" onchange="jQuery('#profilesearchform').submit();">
    </#if>
    <option value="-1">Select</option>
    <#assign jobTitles = statics['com.grail.synchro.SynchroGlobal'].getJobTitles() />
    <#if (jobTitles?has_content)>
        <#list jobTitles.keySet() as key>
            <#local jobTitleName = jobTitles.get(key)/>
            <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${jobTitleName}</option>
        </#list>
    </#if>
</select>
</#macro>
<!-- User Filters Ends -->


<#macro renderAgencyPerfField name='' value=0 readonly=false>
    <#if readonly>
    <select name="${name}" id="${name}" disabled >
    <#else>
    <select name="${name}" id="${name}" class="form-select" onchange="jQuery('#profilesearchform').submit();">
    </#if>
    <option  value="-1" <#if value==-1> selected</#if>>Not Applicable</option>
    <option  value="1" <#if value==1> selected</#if>>1-Unsatisfactory</option>
    <option  value="2" <#if value==2> selected</#if>>2-Poor</option>
    <option  value="3" <#if value==3> selected</#if>>3-Satisfactory</option>
    <option  value="4" <#if value==4> selected</#if>>4-Good</option>
    <option  value="5" <#if value==5> selected</#if>>5-Outstanding</option>
</select>
</#macro>

<#macro renderAllSelectedCategoryTypeField name='' value=[] multiselect=false readonly=false>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#assign categoryTypes = statics['com.grail.synchro.SynchroGlobal'].getProductTypes() />
    <#assign categoryTypeKeySet = categoryTypes.keySet() />
    <#if (categoryTypes?has_content)>
        <#list categoryTypeKeySet as key>
            <#assign categoryType = categoryTypes.get(key) />
            <#if value?? && value?is_sequence && value?seq_contains(key)> <option value="${key?c}" >${categoryType}</option></#if>
        </#list>
    </#if>
</select>
</#macro>

<#macro renderAllSelectedCategoryTypeFieldAdmin name='' value=[] multiselect=false readonly=false>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#assign categoryTypes = statics['com.grail.synchro.SynchroGlobal'].getProductTypes() />
    <#assign categoryTypeKeySet = categoryTypes.keySet() />
    <#if (categoryTypes?has_content)>
        <#list categoryTypeKeySet as key>
            <#assign categoryType = categoryTypes.get(key) />
            <option value="${key?c}"  <#if value?? && value?is_sequence && value?seq_contains(key)> selected </#if>> ${categoryType}</option>
        </#list>
    </#if>
</select>


</#macro>

<#macro renderDataCollectionSelected name='' value=[] multiselect=false class='' readonly=false id=''>
    <#assign dataCollections = statics['com.grail.synchro.SynchroGlobal'].getDataCollections() />

    <#if readonly>
    <select name="${name}" id="${id}" disabled <#if multiselect?? && multiselect>multiple="yes"</#if> <#if class!="">class="${class}"<#else>class="select_field large"</#if>>
    <#else>
    <select name="${name}" id="${id}" <#if multiselect?? && multiselect>multiple="yes"</#if> <#if class!="">class="${class}"<#else>class="select_field large"</#if>>
    </#if>
<#-- <option value="-1" disabled>-- None --</option> -->
    <#if (dataCollections?has_content)>
        <#list dataCollections.keySet() as key>
            <#assign dataCollection = dataCollections.get(key) />
            <#if value?is_sequence && value?seq_contains(key)> <option value="${key?c}">${dataCollection}</option></#if>
        </#list>
    </#if>
</select>
</#macro>

<#function getFormattedDate(date)>
    <#assign formatted_date = ''/>
    <#if date?exists && !date?is_string>
        <#if date?string('MM/dd/yyyy')??>
            <#assign formatted_date = date?string('MM/dd/yyyy') />
        </#if>
    </#if>
<script type="text/javascript">
    console.log(${formatted_date?string});
</script>
    <#return formatted_date />
</#function>

<#function getEndMarketID(endMarket)>
    <#assign em_id = -1 />
    <#if endMarket?exists && !endMarket?is_number>
        <#if endMarket[0]?? >
            <#assign em_id = endMarket[0] />
        </#if>
    </#if>
    <#return em_id />
</#function>

<#macro renderMethodologyField name='' value=0 multiselect=false readonly=false >
   
	<select data-placeholder="Select Methodology Type" class="chosen-select" <#if multiselect?? && multiselect>multiple</#if> <#if readonly>disabled</#if> id = "${name}" name='${name}' >
	  <option value="-1"></option>
	   <#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getProjectIsMapping() />
		<#if (methodologies?has_content)>
			<#list methodologies.keySet() as key>
				<#assign methodology = methodologies.get(key)/>
				<option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${methodology}</option>
			</#list>
		</#if>
	</select>
	
</#macro>

<!-- CAP Rating -->
<#macro renderCAPRatingField name='' value=0 readonly=false>
    <#if !name?exists || name!="">
        <#assign name = 'capRating'/>
    </#if>
    <#if readonly>
    <select name="${name}" id="${name}" disabled class="form-select">
    <#else>
    <select name="${name}" id="${name}" class="form-select">
    </#if>
    <option value="-1">-- None --</option>
    <#assign ratings = statics['com.grail.synchro.SynchroGlobal'].getProjectTypes() />
    <#if (ratings?has_content)>
        <#list ratings.keySet() as key>
            <#assign rating = ratings.get(key)/>
            <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${rating}</option>
        </#list>
    </#if>
</select>
</#macro>

<#macro renderRegionSelect name='' value=0 readonly=false class=''>
    <#if class?? && class==''>

        <#assign class='form-select' />
    </#if>
    <#if readonly>
    <select name="${name}" id="${name}" disabled class="${class}">
    <#else>
    <select name="${name}" id="${name}" class="${class}">
    </#if>


    <option  value="-1">Select</option>
    <#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
    <#if (regions?has_content)>
        <#list regions.keySet() as key>
            <#local regionName = regions.get(key)/>
            <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${regionName}</option>
        </#list>
    </#if>
</select>
</#macro>

<#macro renderAreaSelect name='' value=0 readonly=false class=''>
    <#if class?? && class==''>
        <#assign class='form-select' />
    </#if>
    <#if readonly>
    <select name="${name}" id="${name}" disabled class="${class}">
    <#else>
    <select name="${name}" id="${name}" class="form-select">
    </#if>
    <option  value="-1">Select</option>
    <#assign areas = statics['com.grail.synchro.SynchroGlobal'].getAreas() />
    <#if (areas?has_content)>
        <#list areas.keySet() as key>
            <#local area = areas.get(key)/>
            <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${area}</option>
        </#list>
    </#if>
</select>
</#macro>


<#macro renderMultiEndMarketField name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'endMarkets'/>
    <#else>
        <#assign name = 'endMarket'/>
    </#if>
    <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
    <#assign endMarketKeySet = endMarkets.keySet() />
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if> class="endmarket-multiple-select" >
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if> class="endmarket-multiple-select" >
    </#if>
    <#if (endMarkets?has_content)>
        <#list endMarketKeySet as key>
            <#if value?? && value?is_sequence && value?seq_contains(key)>
                <#assign endMarket = endMarkets.get(key) />
                <option value="${key?c}" >${endMarket}</option>
            </#if>
        </#list>
    </#if>
</select>
</#macro>

<!-- Waiver Macros -->
<#macro renderProductTypeField name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'productTypes'/>
    <#else>
        <#assign name = 'productType'/>
    </#if>
    <#if readonly>
    <select name="${name}" id="${name}" disabled <#if waiver>class="form-select waiver-readonly" <#else>class="form-select" </#if><#if multiselect>multiple="yes"</#if>>
    <#else>
    <select name="${name}" id="${name}" class="form-select" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <option value="-1" <#if !selectNone>disabled <#else> selected </#if>>-- None --</option>
    <#assign productTypes = statics['com.grail.synchro.SynchroGlobal'].getProductTypes() />
    <#if (productTypes?has_content)>
        <#list productTypes.keySet() as key>
            <#assign productType = productTypes.get(key)/>
            <#if value?number == -1 && productType=="Manufactured Cigarettes">
            <option value="${key?c}" <#if !selectNone>selected="true"</#if>>${productType}
            <#else>
            <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${productType}
            </#if>
        </option>
        </#list>
    </#if>
</select>
</#macro>

<#macro renderWaiverMethodolgyApproverField name='approver' value=-1 id=id readonly=false>
    <#assign oracleApprovers = jiveContext.getSpringBean("synchroUtils").getSynchroMethodologyApprovers() />
<select name="${name}" id="${id}" class="form-select" <#if readonly>disabled</#if>>
    <option value=-1>- None -</option>
    <#if (oracleApprovers?has_content)>
        <#list oracleApprovers as oracleApprover>
                <option value=${oracleApprover.ID?c} <#if value == oracleApprover.ID>selected="true"</#if>>${oracleApprover.name}</option>
        </#list>
    </#if>
</select>
</#macro>

<#macro renderProcessWaiverApproverField name='approver' value=-1 id=id readonly=false>
    <#assign oracleApprovers = jiveContext.getSpringBean("synchroUtils").getSynchroProcessWaiverApprovers() />
<select name="${name}" id="${id}" class="form-select" <#if readonly>disabled</#if>>
    <option value=-1>- None -</option>
    <#if (oracleApprovers?has_content)>
        <#list oracleApprovers as oracleApprover>
                <option value=${oracleApprover.ID?c} <#if value == oracleApprover.ID>selected="true"</#if>>${oracleApprover.name}</option>
        </#list>
    </#if>
</select>
</#macro>

<#macro renderWaiverPreApproval name='' value='-1' readonly=false >
    <#if !name?exists>
        <#assign name = 'preApprovals'/>
    <#else>
        <#assign name = '${name}'/>
    </#if>

    <#assign waiverPreApprovalID = statics['com.grail.synchro.SynchroGlobal$WaiverPreApproval'].LOCALLY_APPROVED.getId() />
    <#assign waiverPreApprovalDesc = statics['com.grail.synchro.SynchroGlobal$WaiverPreApproval'].LOCALLY_APPROVED.getDescription() />
<input type="checkbox" <#if value?is_sequence && value?seq_contains(waiverPreApprovalID)>checked</#if> <#if readonly>disabled</#if> name="${name}" id="${name}" value="${waiverPreApprovalID}">${waiverPreApprovalDesc}<br>

    <#assign waiverPreApprovalID = statics['com.grail.synchro.SynchroGlobal$WaiverPreApproval'].REGIONAL_APPROVED.getId() />
    <#assign waiverPreApprovalDesc = statics['com.grail.synchro.SynchroGlobal$WaiverPreApproval'].REGIONAL_APPROVED.getDescription() />
<input type="checkbox" <#if value?is_sequence && value?seq_contains(waiverPreApprovalID)>checked</#if> <#if readonly>disabled</#if> name="${name}" id="${name}" value="${waiverPreApprovalID}">${waiverPreApprovalDesc}<br>

    <#assign waiverPreApprovalID = statics['com.grail.synchro.SynchroGlobal$WaiverPreApproval'].GLOBALLY_APPROVED.getId() />
    <#assign waiverPreApprovalDesc = statics['com.grail.synchro.SynchroGlobal$WaiverPreApproval'].GLOBALLY_APPROVED.getDescription() />
<input type="checkbox" <#if value?is_sequence && value?seq_contains(waiverPreApprovalID)>checked</#if> <#if readonly>disabled</#if> name="${name}" id="${name}" value="${waiverPreApprovalID}">${waiverPreApprovalDesc}<br>

</#macro>



<!-- Multiple End Market Macro ends -->
<#macro renderSelectSPIContactsField name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>SPI Contacts</#if></label>
    <@renderSPIContantsSection name='allSPIContacts' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="spi-contacts-reload" href="javascript:void(0);"></a>
        <input id="addSPIContactBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeSPIContactBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addSPIContactBtn, #removeSPIContactBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addSPIContactBtn" ? "#allSPIContacts" : "#spiContacts";
            var moveTo = (id == "addSPIContactBtn") ? "#spiContacts" : "#allSPIContacts";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allSPIContacts").sortOptions();
    });

    jQuery("#spi-contacts-reload").click(function() {
        jQuery("#spiContacts option").each(function()
        {
            jQuery("#allSPIContacts").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allSPIContacts").sortOptions();
        });
    });

    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<#macro renderSPIContantsSection name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allSPIContacts'/>
    <#else>
        <#assign name = 'allSPIContacts	'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#list jiveContext.getSpringBean("synchroUtils").getSPIGroupUsers() as user>
        <#if user.enabled?? && user.enabled>
            <option value="${user.ID?c}">${user.name?string}</option>
        </#if>
    </#list>
</select>
</#macro>

<!-- Multiple End Market Macro ends -->
<#macro renderSelectAgenciesField name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Agency Contact</#if></label>
    <@renderAgenciesSection name='allAgencies' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="agencies-reload" href="javascript:void(0);"></a>
        <input id="addAgencyBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeAgencyBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addAgencyBtn, #removeAgencyBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addAgencyBtn" ? "#allAgencies" : "#agencies";
            var moveTo = (id == "addAgencyBtn") ? "#agencies" : "#allAgencies";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allAgencies").sortOptions();
    });

    jQuery("#agencies-reload").click(function() {
        jQuery("#agencies option").each(function()
        {
            jQuery("#allAgencies").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allAgencies").sortOptions();
        });
    });

    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<#macro renderAgenciesSection name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allAgencies'/>
    <#else>
        <#assign name = 'allAgencies'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#list jiveContext.getSpringBean("synchroUtils").getAgencyGroupUsers() as user>
        <#if user.enabled?? && user.enabled>
            <option value="${user.ID?c}">${user.name?string}</option>
        </#if>
    </#list>
</select>
</#macro>


<!-- Multiple End Market Macro ends -->
<#macro renderSelectAgencyNamesField name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Agency Name</#if></label>
    <@renderAgencyNameSection name='allAgencyNames' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="agency-names-reload" href="javascript:void(0);"></a>
        <input id="addAgencyNameBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeAgencyNameBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addAgencyNameBtn, #removeAgencyNameBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addAgencyNameBtn" ? "#allAgencyNames" : "#agencyNames";
            var moveTo = (id == "addAgencyNameBtn") ? "#agencyNames" : "#allAgencyNames";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allAgenciesNames").sortOptions();
    });

    jQuery("#agency-names-reload").click(function() {
        jQuery("#agencyNames option").each(function()
        {
            jQuery("#allAgencyNames").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allAgencyNames").sortOptions();
        });
    });

    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<#macro renderAgencyNameSection name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allAgencyNames'/>
    <#else>
        <#assign name = 'allAgencyNames'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#list jiveContext.getSpringBean("synchroUtils").getAgencyNames() as dept>
        <option value="${dept.id?c}">${dept.name?string}</option>
    </#list>
</select>
</#macro>


<!-- ==================================================== -->
<!--   Kantar button dashboard related macros starts here   -->
<!-- ==================================================== -->

<#macro renderKantarButtonProjectInitiatorsMultiselectField name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Owner</#if></label>
    <@renderAllKantarButtonProjectInitiatorsSelectField name='allKantarButtonProjectInitiators' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="kantar-project-initiator-reload" href="javascript:void(0);"></a>
        <input id="addKantarButtonProjectInitiatorBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeKantarButtonProjectInitiatorBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addKantarButtonProjectInitiatorBtn, #removeKantarButtonProjectInitiatorBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addKantarButtonProjectInitiatorBtn" ? "#allKantarButtonProjectInitiators" : "#initiators";
            var moveTo = (id == "addKantarButtonProjectInitiatorBtn") ? "#initiators" : "#allKantarButtonProjectInitiators";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#initiators").sortOptions();
    });

    jQuery("#kantar-project-initiator-reload").click(function() {
        jQuery("#initiators option").each(function()
        {
            jQuery("#allKantarButtonProjectInitiators").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allKantarButtonProjectInitiators").sortOptions();
        });
    });

    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>




<#macro renderAllKantarButtonProjectInitiatorsSelectField name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allKantarButtonProjectInitiators'/>
    <#else>
        <#assign name = 'allKantarButtonProjectInitiators'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#list jiveContext.getSpringBean("synchroUtils").getKantarButtonInitiators() as user>
        <#if user.enabled?? && user.enabled>
            <option value="${user.ID?c}">${user.name?string}</option>
        </#if>
    </#list>
</select>
</#macro>



<#macro renderKantarReportAuthorsMultiselectField name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Owner</#if></label>
    <@renderAllKantarReportAuthorsSelectField name='allKantarReportAuthors' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="kantar-report-authors-reload" href="javascript:void(0);"></a>
        <input id="addKantarReportAuthorBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeKantarReportAuthorBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addKantarReportAuthorBtn, #removeKantarReportAuthorBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addKantarReportAuthorBtn" ? "#allKantarReportAuthors" : "#authors";
            var moveTo = (id == "addKantarReportAuthorBtn") ? "#authors" : "#allKantarReportAuthors";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#authors").sortOptions();
    });

    jQuery("#kantar-report-authors-reload").click(function() {
        jQuery("#authors option").each(function()
        {
            jQuery("#allKantarReportAuthors").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allKantarReportAuthors").sortOptions();
        });
    });

    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>




<#macro renderAllKantarReportAuthorsSelectField name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allKantarReportAuthors'/>
    <#else>
        <#assign name = 'allKantarReportAuthors'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#list jiveContext.getSpringBean("synchroUtils").getDocumentRepositoryInitiators() as user>
        <#if user.enabled?? && user.enabled>
            <option value="${user.ID?c}">${user.name?string}</option>
        </#if>
    </#list>
</select>
</#macro>



<#macro renderKantarButtonProjectBATContactsMultiselectField name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>BAT Contact</#if></label>
    <@renderAllKantarButtonProjectBATContactsSelectField name='allKantarButtonProjectBATContacts' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="kantar-project-batcontact-reload" href="javascript:void(0);"></a>
        <input id="addKantarButtonProjectBATContactBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeKantarButtonProjectBATContactBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addKantarButtonProjectBATContactBtn, #removeKantarButtonProjectBATContactBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addKantarButtonProjectBATContactBtn" ? "#allKantarButtonProjectBATContacts" : "#batContacts";
            var moveTo = (id == "addKantarButtonProjectBATContactBtn") ? "#batContacts" : "#allKantarButtonProjectBATContacts";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#batContacts").sortOptions();
    });

    jQuery("#kantar-project-batcontact-reload").click(function() {
        jQuery("#batContacts option").each(function()
        {
            jQuery("#allKantarButtonProjectBATContacts").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allKantarButtonProjectBATContacts").sortOptions();
        });
    });

    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<#macro renderAllKantarButtonProjectBATContactsSelectField name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allKantarButtonProjectBATContacts'/>
    <#else>
        <#assign name = 'allKantarButtonProjectBATContacts'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#list jiveContext.getSpringBean("synchroUtils").getKantarButtonBATContacts() as user>
        <#if user.enabled?? && user.enabled>
            <option value="${user.ID?c}">${user.name?string}</option>
        </#if>
    </#list>
</select>
</#macro>


<#macro renderKantarButtonMethodologyMultiselectField name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Methodology Type</#if></label>
    <@renderKantarButtonMethodolgySelectField name='allKantarButtonMethodologies' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="kantar-methodologies-reload" href="javascript:void(0);"></a>
        <input id="addKantarButtonMethodologyBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeKantarButtonMethodologyBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addKantarButtonMethodologyBtn, #removeKantarButtonMethodologyBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addKantarButtonMethodologyBtn" ? "#allKantarButtonMethodologies" : "#methodologies";
            var moveTo = (id == "addKantarButtonMethodologyBtn") ? "#methodologies" : "#allKantarButtonMethodologies";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#methdologies").sortOptions();
    });

    jQuery("#kantar-methodologies-reload").click(function() {
        jQuery("#methodologies option").each(function()
        {
            jQuery("#allKantarButtonMethodologies").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allKantarButtonMethodologies").sortOptions();
        });
    });

    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<#macro renderKantarButtonMethodolgySelectField name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allKantarButtonMethodologies'/>
    <#else>
        <#assign name = 'allKantarButtonMethodologies'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
<#--<option value="-1" selected="true">-- None --</option>-->
    <#assign methodologyTypes = statics['com.grail.kantar.util.KantarGlobals$KantarMethodologyType'].values()>
    <#if methodologyTypes?has_content>
        <#list methodologyTypes as methodologyType>
            <option value="${methodologyType.getId()?int}">${methodologyType.getName()}</option>
        </#list>
    </#if>
</select>
</#macro>


<#macro renderKantarReportTypeMultiselectField name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Methodology Type</#if></label>
    <@renderKantarReportTypesSelectField name='allKantarReportTypes' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="kantar-reporttype-reload" href="javascript:void(0);"></a>
        <input id="addKantarReportTypeBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeKantarReportTypeBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addKantarReportTypeBtn, #removeKantarReportTypeBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addKantarReportTypeBtn" ? "#allKantarReportTypes" : "#reportTypes";
            var moveTo = (id == "addKantarReportTypeBtn") ? "#reportTypes" : "#allKantarReportTypes";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#reportTypes").sortOptions();
    });

    jQuery("#kantar-reporttype-reload").click(function() {
        jQuery("#reportTypes option").each(function()
        {
            jQuery("#allKantarReportTypes").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allKantarReportTypes").sortOptions();
        });
    });

    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<#macro renderKantarReportTypesSelectField name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allKantarReportTypes'/>
    <#else>
        <#assign name = 'allKantarReportTypes'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
<#--<option value="-1" selected="true">-- None --</option>-->
    <#assign reportTypes =  statics['com.grail.kantar.util.KantarUtils'].getKantarReportTypeBeans()>
    <#--<#assign reportTypesSet = reportTypes.keySet() />-->
    <#--<#if (reportTypes?has_content)>-->
        <#--<#list reportTypesSet as key>-->
            <#--<#assign reportType = reportTypes.get(key) />-->
            <#--<option value="${key?c}">${reportType}</option>-->
        <#--</#list>-->
    <#--</#if>-->
    <#if (reportTypes?has_content)>
        <#list reportTypes as reportType>
            <#if request.getParameter("otherType")?? && request.getParameter("otherType") == 'true'>
               <#if reportType.otherType>
                   <option value="${reportType.id?c}">${reportType.name}</option>
               </#if>
            <#else>
                <option value="${reportType.id?c}">${reportType.name}</option>
            </#if>

        </#list>
    </#if>
<#--<#assign reportTypes = statics['com.grail.kantar.util.KantarGlobals$KantarReportType'].values()>-->
<#--<#if reportTypes?has_content>-->
<#--<#list reportTypes as reportType>-->
<#--<option value="${reportType.getId()?int}">${reportType.getName()}</option>-->
<#--</#list>-->
<#--</#if>-->
</select>
</#macro>

<!-- ==================================================== -->
<!--   Kantar button dashboard related macros ends here   -->
<!-- ==================================================== -->





<#function generateProjectCode projectID maxDigits=5 >
    <#if projectID?? && (projectID?number>0) >
        <#local length = (projectID?string)?length />
        <#local prependLen = (maxDigits - length) />
        <#local prepend = '' />
        <#if (length<maxDigits) >
            <#list 1..prependLen as x>
                <#local prepend = prepend + '0' />
            </#list>
        </#if>
        <#return (prepend + projectID?string)>
    </#if>
    <#return ''>
</#function>

<!-- Multiple Region starts -->
<#macro showMarketsFieldSection name='' regions=0 areas=0 endMarkets=0 label='' readonly=false validate=false >
<div class="form-select_div">
    <label>List of Markets</label>
    <@renderMarketsField name='availableMarkets' selectedregions=regions selectedareas=areas selectedendMarkets=endMarkets multiselect=true readonly=readonly/>
    <div class="action_buttons" style="top:90px;">
        <a id="marketsMM-reload" href="javascript:void(0);"></a>
        <input id="addMarketsMMBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeMarketsMMBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>Selected Markets</label>
    <#if readonly>
        <select name="${name}" id="${name}" disabled multiple="yes" class="" ></select>
    <#else>
        <select name="${name}" id="${name}" style="height:200px;" multiple="yes" class=""></select>
    </#if>
    <#attempt>
        <@macroCustomFieldErrors msg="Please choose Markets"/>
        <#recover>
    </#attempt>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addMarketsMMBtn, #removeMarketsMMBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addMarketsMMBtn" ? "#availableMarkets" : "#markets";
            var moveTo = (id == "addMarketsMMBtn") ? "#markets" : "#availableMarkets";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            // jQuery(moveTo).append(selectedItems);
            // jQuery(moveTo).sortOptions1();

            if(id == "addMarketsMMBtn")
            {
                var maxCountryCount = ${JiveGlobals.getJiveIntProperty("grail.multimarket.country.limit", 10)?c};
                var items = jQuery("#markets option").size();
                var newItems = selectedItems.length;

                if((items + newItems)>maxCountryCount)
                // if((newItems)>maxCountryCount)
                {
                    dialog({
                        title: 'Message',
                        html: '<p>MAXIMUM '+ maxCountryCount +' endmarkets are allowed </p>'
                    });
                }
                else
                {
                    jQuery(moveTo).append(selectedItems);
                    jQuery(moveTo).sortOptions1();
                    <#if validate>
                        validateAddMarketsLink();
                    </#if>
                }
            }
            else
            {
                <#if validate>
                    if(checkInvestmentGridPIT(selectedItems))
                    {
                        jQuery(moveTo).append(selectedItems);
                        jQuery(moveTo).sortOptions1();
                        validateAddMarketsLink();
                    }
                    else
                    {
                        dialog({
                            title: 'Message',
                            html: '<p>Please remove the relevant entry from the investment grid to be able to remove the end market(s) </p>'
                        });
                    }

                <#else>
                    jQuery(moveTo).append(selectedItems);
                    jQuery(moveTo).sortOptions1();
                </#if>
            }

        });
        jQuery("#addMarketsMMBtn").click();
        jQuery("#availableMarkets").sortOptions1();

    });

    jQuery("#marketsMM-reload").click(function() {

        var allItems = jQuery("#markets option").toArray();

        <#if validate>
            if(checkInvestmentGridPIT(allItems))
            {
                jQuery("#markets option").each(function()
                {
                    var arel = jQuery(this).attr('rel');

                    var newOption  = new Option(jQuery(this).text(), jQuery(this).val());
                    jQuery(newOption).attr('rel',arel);

                    // jQuery("#availableMarkets").append(new Option(jQuery(this).text(), jQuery(this).val()));
                    jQuery("#availableMarkets").append(newOption);
                    jQuery(this).remove();
                });
                jQuery("#availableMarkets").sortOptions1();
            }
            else
            {
                dialog({
                    title: 'Message',
                    html: '<p>Please remove the relevant entry from the investment grid to be able to remove the end market(s) </p>'
                });
            }
        <#else>
            jQuery("#markets option").each(function()
            {
                jQuery("#markets").append(new Option(jQuery(this).text(), jQuery(this).val()));
                jQuery(this).remove();
            });
            jQuery("#markets").sortOptions1();
        </#if>

        <#if validate>
            validateAddMarketsLink();
        </#if>




    });

    jQuery.fn.sortOptions1 = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {

                var arel = jQuery(a).attr('rel');
                var brel = jQuery(b).attr('rel');
                return arel == brel ? 0 : arel < brel ? -1 : 1
                // return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });

    }
</script>
</#macro>

<#macro renderMarketsField name='' selectedregions=[] selectedareas=[] selectedendMarkets=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'markets'/>
    <#else>
        <#assign name = 'market'/>
    </#if>
    <#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
    <#assign regionKeySet = regions.keySet() />

    <#if readonly>
    <select  name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select name="${name}" id="${name}" style="height:200px;" <#if multiselect>multiple="yes"</#if>>
    </#if>

    <option value="A0" rel="AAA" style="color:white; background:#808080;">End Markets</option>

    <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
    <#assign endMarketKeySet = endMarkets.keySet() />

    <#if (endMarkets?has_content)>
        <#list endMarketKeySet as key>
            <#assign endMarket = endMarkets.get(key) />
            <#if endMarket=="Global">
                <option value="A${key?c}" rel="AZZZZZ" <#if selectedendMarkets?? && selectedendMarkets?is_sequence && selectedendMarkets?seq_contains(key)>selected="true"</#if>>${endMarket}</option>
            <#else>
                <option value="A${key?c}" rel="AAA${endMarket}" <#if selectedendMarkets?? && selectedendMarkets?is_sequence && selectedendMarkets?seq_contains(key)>selected="true"</#if>>${endMarket}</option>
            </#if>
        </#list>
    </#if>

    <option value="B0" rel="BBB" style="color:white; background:#808080;">Regions</option>
    <#if (regions?has_content)>
        <#list regionKeySet as key>
            <#assign region = regions.get(key) />
            <option value="B${key?c}" rel="BBB${region}"  <#if selectedregions?? && selectedregions?is_sequence && selectedregions?seq_contains(key)>selected="true"</#if>>${region}</option>
        </#list>

        <option value="C0" rel="CCC" style="color:white; background:#808080;" disabled>Area</option>

        <#assign areas = statics['com.grail.synchro.SynchroGlobal'].getAreas() />
        <#assign areaKeySet = areas.keySet() />

        <#if (areas?has_content)>
            <#list areaKeySet as key>
                <#assign area = areas.get(key) />
                <option value="C${key?c}"  rel="CCC${area}" <#if selectedareas?? && selectedareas?is_sequence && selectedareas?seq_contains(key)>selected="true"</#if>>${area}</option>
            </#list>
        </#if>




    </#if>
</select>
</#macro>

    <!-- Multiple Area starts -->
<#macro showAreaFieldSection name='' value=0 label='' readonly=false validate=false >
    <div class="form-select_div">
        <label>List of Areas</label>
        <@renderAreaField name='availableAreas' value=value multiselect=true readonly=readonly/>
        <div class="action_buttons">
            <a id="areasMM-reload" href="javascript:void(0);"></a>
            <input id="addAreaMMBtn" type="button" value='>>' class="left_arrow" />
            <input id="removeAreaMMBtn" type="button" value='<<' class="right_arrow" />
        </div>
    </div>
    <div class="form-select_div_brand">
        <label>Selected List of Areas</label>
        <#if readonly>
            <select size="3" name="${name}" id="${name}" disabled multiple="yes" class="" ></select>
        <#else>
            <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
        </#if>
        <#attempt>
            <@macroCustomFieldErrors msg="Please choose Area"/>
            <#recover>
        </#attempt>
    </div>

    <script type="text/javascript">
        jQuery(function() {
            jQuery("#addAreaMMBtn, #removeAreaMMBtn").click(function(event) {
                var id = jQuery(event.target).attr("id");
                var selectFrom = id == "addAreaMMBtn" ? "#availableAreas" : "#areas";
                var moveTo = (id == "addAreaMMBtn") ? "#areas" : "#availableAreas";
                var selectedItems = jQuery(selectFrom + " :selected").toArray();

                jQuery(moveTo).append(selectedItems);
                jQuery(moveTo).sortOptions();


            });
            jQuery("#addAreaMMBtn").click();
            jQuery("#availableAreas").sortOptions();

        });

        jQuery("#areasMM-reload").click(function() {

            var allItems = jQuery("#areas option").toArray();

            jQuery("#areas option").each(function()
            {
                jQuery("#availableAreas").append(new Option(jQuery(this).text(), jQuery(this).val()));
                jQuery(this).remove();
            });
            jQuery("#availableAreas").sortOptions();


        });

        jQuery.fn.sortOptions = function(){
            jQuery(this).each(function(){
                var op = jQuery(this).children("option");
                op.sort(function(a, b) {
                    return a.text > b.text ? 1 : -1;
                })
                return jQuery(this).empty().append(op);
            });
        }
    </script>
</#macro>

<#macro renderAreaField name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'areas'/>
    <#else>
        <#assign name = 'area'/>
    </#if>
    <#assign areas = statics['com.grail.synchro.SynchroGlobal'].getAreas() />
    <#assign areaKeySet = areas.keySet() />

    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>

    <#if (areas?has_content)>
        <#list areaKeySet as key>
            <#assign area = areas.get(key) />
            <option value="${key?c}" <#if value?? && value?is_sequence && value?seq_contains(key)>selected="true"</#if>>${area}</option>
        </#list>
    </#if>
</select>
</#macro>

<#macro projectBudgetYearField name='budgetYear' value=-1  readonly=false>
    <script type="text/javascript">
        jQuery(document).ready(function(){
            jQuery("#budgetYears").html('');
            var now = new Date();
            var currYear = now.getFullYear();
            var minYear = Number("${JiveGlobals.getJiveProperty(statics['com.grail.synchro.SynchroConstants'].SYNCHRO_PROJECT_BUDGET_YEAR_START, "2013")}");
            if(currYear < minYear) {
                minYear = currYear;
            }
            var maxYear = currYear + 3;
            if(minYear > maxYear) {
                minYear = currYear;
            }
            var selVal = -1;
            <#if value?? && value?has_content>
                selVal = Number("${value}".replace(",",""));
            </#if>
            jQuery("#budgetYears").append("<option value='-1'>-- None --</option>")
            for(var y = minYear; y <= maxYear; y++) {
                var isSelected = false
                if(!isNaN(selVal) && y == selVal) {
                    isSelected = true;
                }
                jQuery("#budgetYears").append("<option value='" + y + "'" +(isSelected?"selected='true'":'')+ ">" + y + "</option>")
            }
        })
    </script>
    <div class="form-select_div">
        <label>Budget Year</label>
        <div class="inner_div">
            <#if readonly>
                <input type="text" id="budgetYearsText" name="budgetYearText" disabled="disabled" <#if value?? && value &gt; 0>value=${value?c}</#if>>
            <#else>
                <select id="budgetYears" name="budgetYear" class="form-select"></select>
            </#if>
        </div>
    </div>
</#macro>

<#macro synchrodatetimepicker id name value format="" showstime=false useservertime=false readonly=false disablePrevDates=false defaultDateTimePicker=true dateCompare=false dateCompare1=false  dateCompareFilter=false  dateCompareLogs=false   placeholder='' tpdDate=false dateCompareStart=false dateCompareEnd=false dateCompareStartPIT=false dateCompareEndPIT=false dateCompareProposalLegal=false tpdSubmissionDate=false>
    
	<#if dateCompare>
		<input type="text" class="jive-form-textinput-variable j-form-datepicker" id="${id}" name="${name}" placeholder="${placeholder}" onchange="checkVisiblty()" <#if readonly>readonly="true"</#if>/>
	<#elseif dateCompare1>
		<input type="text" class="jive-form-textinput-variable j-form-datepicker" id="${id}" name="${name}" placeholder="${placeholder}" onchange="dateCompare1()" <#if readonly>readonly="true"</#if>/>
		
	<#elseif dateCompareProposalLegal>
		<input type="text" class="jive-form-textinput-variable j-form-datepicker" id="${id}" name="${name}" placeholder="${placeholder}" onchange="dateCompare()" <#if readonly>readonly="true"</#if>/>	
		
		
	<#elseif tpdDate>
		<input type="text" class="jive-form-textinput-variable j-form-datepicker" id="${id}" placeholder="${placeholder}" name="${name}" onchange="dateSelected();" <#if readonly>readonly="true"</#if>/>
	<#elseif dateCompareFilter>
		<input type="text" class="jive-form-textinput-variable j-form-datepicker" id="${id}" name="${name}" placeholder="${placeholder}" onchange="dateCompareFilter()" <#if readonly>readonly="true"</#if>/>	
	<#elseif dateCompareStart>
		<input type="text" class="jive-form-textinput-variable j-form-datepicker" id="${id}" name="${name}" placeholder="${placeholder}" onchange="dateCompareStart()" <#if readonly>readonly="true"</#if>/>
	<#elseif dateCompareEnd>
		<input type="text" class="jive-form-textinput-variable j-form-datepicker" id="${id}" name="${name}" placeholder="${placeholder}" onchange="checkVisiblty()" <#if readonly>readonly="true"</#if>/>
	<#elseif dateCompareStartPIT>
		<input type="text" class="jive-form-textinput-variable j-form-datepicker" id="${id}" name="${name}" placeholder="${placeholder}" onchange="dateCompareStartPIT()" <#if readonly>readonly="true"</#if>/>
	<#elseif dateCompareEndPIT>
		<input type="text" class="jive-form-textinput-variable j-form-datepicker" id="${id}" name="${name}" placeholder="${placeholder}" onchange="dateCompareEndPITVisibiliity()" <#if readonly>readonly="true"</#if>/>		
	
    <#elseif dateCompareLogs>
		<input type="text" class="jive-form-textinput-variable j-form-datepicker" id="${id}" name="${name}" placeholder="${placeholder}" onchange="dateCompareLogs()" <#if readonly>readonly="true"</#if>/>		
	
	
	<#elseif tpdSubmissionDate>
		<input type="text" class="jive-form-textinput-variable j-form-datepicker" id="${id}" placeholder="${placeholder}" name="${name}" onchange="dateTPDSelected(this);" <#if readonly>readonly="true"</#if>/>	
		
	<#else>
		<input type="text" class="jive-form-textinput-variable j-form-datepicker" id="${id}" placeholder="${placeholder}" name="${name}"  <#if readonly>readonly="true"</#if>/>
		
		
	
	</#if>
		<a href="#" id="${id}_button" class="j-form-datepicker-btn">
		<img src="${themePath}/images/synchro/calendar.png" encode='false'" width="19" height="19" border="0" alt="<@s.text name="global.datepicker.tooltip"/>" title="<@s.text name="global.datepicker.tooltip"/>" />
		<script type="text/javascript">
			<!--  to hide script contents from old browsers
			Zapatec.Calendar.setup({
				inputField     :    "${id}",     // id of the input field
				ifFormat       :    "${format}",     // format of the input field
				button         :    "${id}_button",  // What will trigger the popup of the calendar
				showsTime      :     false      //don't show time, only date
			});
			// end hiding contents from old browsers  -->
		</script>
		</a>
    
</#macro>

<#macro fieldworkstudyField name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
  
	<select data-placeholder="Select" class="chosen-select" id = "${name}" <#if readonly>disabled</#if> name='${name}' >
	  <option value="-1"></option>
	  <option  <#if value==1> selected </#if> value="1" >Yes</option>
	  <option <#if value==2> selected </#if> value="2" >No</option>
	</select>
</#macro>

<#macro globalOutcomeEUShare name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
  
	<select data-placeholder="Select" class="chosen-select" id = "${name}" <#if readonly>disabled</#if> name='${name}' >
	  <option value="-1"></option>
	  <option  <#if value==1> selected </#if> value="1" >Yes</option>
	  <option <#if value==2> selected </#if> value="2" >No</option>
	</select>
</#macro>


<#macro renderMethodologyWaiverField name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
 	<select data-placeholder="Select" class="chosen-select" id = "${name}" name='${name}'  <#if readonly>disabled</#if>/>
	  <option value="-1"></option>
	  <option  value="-1" <#if value==-1> selected </#if>></option>
	  <option  value="1" <#if value==1> selected </#if>>Yes</option>
	  <option  value="2" <#if value==2> selected </#if>>No</option>
	  <option  value="3" <#if value==3> selected </#if>>I don’t know yet</option>
	</select>
</#macro>

<#macro renderBrandSpecificStudy name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
      
	<select data-placeholder="Select" class="chosen-select" id = "${name}" name='${name}'  <#if readonly>disabled</#if>>
	  <option value="-1"></option>
	  <option  value="1" <#if value==1> selected </#if>>Yes</option>
	  <option  value="2" <#if value==2> selected </#if>>No</option>
	</select>
</#macro>

<#macro renderBrandFieldNew name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
  
	<select title="" data-placeholder="Select the Brand" class="chosen-select" id = "${name}" name='${name}' <#if readonly>disabled</#if>>
	<option value="-1"></option>
	<#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
    <#if (brands?has_content)>
        <#list brands.keySet() as key>
            <#assign brand = brands.get(key)/>
            <option value="${key?c}" <#if value?number == key?number>selected="selected"</#if>>${brand}</option>
        </#list>
    </#if>
	</select>
</#macro>

<#macro renderBrandSpecificStudyType name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
    

<select title="Select the Study Type" data-placeholder="Select the Study Type" class="chosen-select" id = "${name}" name='${name}'  <#if readonly>disabled</#if>>
	  <option value="-1"></option>
	  <option  value="1" <#if value==1> selected </#if> >Multi-Brand Study</option>
	<option  value="2" <#if value==2> selected </#if> >Non-brand related</option>
	</select>
</#macro>


<#macro renderBudgetLocation name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
    
    <#if readonly>
		<select name="${name}" id="${name}" disabled <#if waiver>class="form-select waiver-readonly" <#else>class="form-select" </#if> <#if multiselect>multiple="yes"</#if>>
    <#else>
		<select name="${name}" id="${name}" class="form-select" <#if multiselect>multiple="yes"</#if>>
    </#if>
		<option  value="1" <#if value==1> selected </#if>>Global</option>
		<option  value="2" <#if value==2> selected </#if>>Regional</option>
		<option  value="3" <#if value==3> selected </#if>>End-Market</option>
		</select>
</#macro>

<#macro renderAgencies name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
      <#if readonly>
		<select name="${name}" id="${name}" disabled <#if waiver>class="form-select waiver-readonly" <#else>class="form-select" </#if> <#if multiselect>multiple="yes"</#if>>
    <#else>
		<select name="${name}" id="${name}" class="form-select" <#if multiselect>multiple="yes"</#if>>
    </#if>
		<option  value="1" >Agency 1</option>
		<option  value="2" >Agency 2</option>
		<option  value="3" >Agency 3</option>
		</select>
</#macro>

<#macro renderCostComponent name='' value=0 multiselect=false readonly=false selectNone=false waiver=false id=''>

	 <#if readonly>
		<select name="${name}" title="Select Cost Component" id="${id}" disabled <#if waiver>class="chosen-select form-select waiver-readonly costComponent" <#else>class="chosen-select form-select costComponent" </#if> <#if multiselect>multiple="yes"</#if>>
    <#else>
		<select name="${name}" title="Select Cost Component" id="${id}" data-placeholder="Cost Component" class="chosen-select form-select costComponent" <#if multiselect>multiple="yes"</#if>>
    </#if>
		<option value="-1"></option>
		<option  value="1" <#if value=='1'> selected </#if> >Coordination</option>
		<option  value="2"  <#if value=='2'> selected </#if>>Fieldwork</option>
		<#if project.isMigrated?? && project.isMigrated >
			<option  value="3"  <#if value=='3'> selected </#if>>Unclassified</option>
		</#if>	
		
		</select>
</#macro>

<#macro renderLegalApprovalStatusFields name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
    <select data-placeholder="Select TPD Status" title="Select TPD Status" class="chosen-select" id = "${name}" name='${name}'  <#if readonly>disabled</#if> onchange="enableConfirmButton();">
	 	<option  value="" ></option>
		<option  value="1" <#if value == '1'> selected </#if>>May have to be TPD Submitted</option>
		<option  value="2" <#if value == '2'> selected </#if>>Doesn't have to be TPD Submitted</option>
	</select>
</#macro>

<#macro renderLegalApprovalStatusFieldsTPDScreen name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
    <select data-placeholder="Select TPD Status" title="Select TPD Status" class="chosen-select" id = "${name}" name='${name}'  <#if readonly>disabled</#if> >
	 	<option  value="" ></option>
		<option  value="1" <#if value == '1'> selected </#if>>May have to be TPD Submitted</option>
		<option  value="2" <#if value == '2'> selected </#if>>Doesn't have to be TPD Submitted</option>
	</select>
</#macro>

<!-- Custom phase 5 macros -->
<#macro renderYesNoDD name='' value="-1" readonly=false>
    <#if !name?exists>
        <#assign name = 'default'/>    
    </#if>
    <#if readonly>
		<select name="${name}-dd" id="${name}-dd" disabled class="form-select">
    <#else>
		<select name="${name}-dd" id="${name}-dd" class="form-select synchro-user-filter">
    </#if>
			<option value="-1">Select</option>
			<option value="1" <#if value=="1">selected</#if>>Yes</option>
			<option value="2" <#if value=="2">selected</#if>>No</option>    
		</select>
</#macro>

<#macro renderTPDEditView name='' value="-1" readonly=false>
    <#if !name?exists>
        <#assign name = 'default'/>    
    </#if>
    <#if readonly>
		<select name="${name}-dd" id="${name}-dd" disabled class="form-select">
    <#else>
		<select name="${name}-dd" id="${name}-dd" class="form-select synchro-user-filter">
    </#if>
			<option value="-1">Select</option>
			<option value="1" <#if value=="1">selected</#if>>Edit</option>
			<option value="2" <#if value=="2">selected</#if>>View</option>    
		</select>
</#macro>

<#macro renderCurrenciesDD name='currency' value=-1?number >
    <#local defaultCurrency = JiveGlobals.getJiveIntProperty("grail.default.currency", -1) />
    <#assign currencies = statics['com.grail.synchro.SynchroGlobal'].getCurrencies() />
	<select name="${name}-dd" id="${name}-dd" class="select_field sortList">
		<option value=-1>Select</option>
			<#if (currencies?has_content)>
				<#list currencies.keySet() as key>
					<#assign currency = currencies.get(key) />
					<option value=${key?c}>${currency}</option>
				</#list>
			</#if>
	</select>    
    <script type="text/javascript">
        jQuery(".sortList").removeClass("sortList");
        if(jQuery('#${name} option[value=-1]').length < 1)
        {
            jQuery("#${name}").prepend("<option disabled value=-1 >Select</option>");
        }
            <#if  value?? && value?is_number && value != -1 >
            jQuery("#${name}").val("${value}");
            <#else>
            jQuery("#${name}").val("${defaultCurrency}");

            </#if>
    </script>    
</#macro>

<#macro projectBudgetYearFieldNew1 name='budgetYear' value=-1  readonly=false multiselect=false>
    
    <div class="form-select_div">
        <label>Budget Year</label>
        <div class="inner_div">
            <#if readonly>
                <input type="text" id="budgetYearsText" name="budgetYearText" disabled="disabled" <#if value?? && value &gt; 0>value=${value?c}</#if>>
            <#else>
               
				<select data-placeholder="Select the Budget Year" class="chosen-select" id = "${name}" name="${name}" <#if multiselect?? && multiselect>multiple</#if> >
				<option value="-1"></option>
				<option value="2013" <#if value==2013>selected</#if>>2013</option>
				<option value="2014"  <#if value==2014>selected</#if> >2014</option>
				<option value="2015" <#if value==2015>selected</#if>>2015</option>
				<option value="2016" <#if value==2016>selected</#if>>2016</option>
				<option value="2017" <#if value==2017>selected</#if>>2017</option>
				<option value="2018" <#if value==2018>selected</#if>>2018</option>
				<option value="2019" <#if value==2019>selected</#if>>2019</option>
				
				</select>
            </#if>
        </div>
    </div>
	
	
	
</#macro>

<#macro projectBudgetYearFieldNew name='budgetYear' value=-1  readonly=false multiselect=false>
    
    <div class="form-select_div">
        <label>Budget Year</label>
        <div class="inner_div">
            <#if readonly>
                <input type="text" id="budgetYearsText" name="budgetYearText" disabled="disabled" <#if value?? && value &gt; 0>value=${value?c}</#if>>
            <#else>
               
				<select data-placeholder="Select the Budget Year" class="chosen-select" id = "${name}" name="${name}" <#if multiselect?? && multiselect>multiple</#if> >
				<option value="-1"></option>
				<#assign startYear = JiveGlobals.getJiveIntProperty(statics['com.grail.synchro.SynchroConstants'].SYNCHRO_PROJECT_BUDGET_YEAR_START, 2013) />
				
				<#assign endYear = JiveGlobals.getJiveIntProperty(statics['com.grail.synchro.SynchroConstants'].SYNCHRO_PROJECT_BUDGET_YEAR_END, 2018) />
				
				
				<#assign counter = startYear />
							
				<#list startYear..endYear as x>
					<option value="${x?c}"  <#if value==x>selected</#if> >${x?c}</option>
				</#list>
				
				
				
				</select>
            </#if>
        </div>
    </div>
	
	
	
</#macro>



<#macro projectBudgetYearFieldNewForPIT name='budgetYear' value=-1  readonly=false multiselect=false>
    
    <div class="form-select_div">
        <label>Budget Year</label>
        <div class="inner_div">
            <#if readonly>
                <input type="text" id="budgetYearsText" name="budgetYearText" disabled="disabled" <#if value?? && value &gt; 0>value=${value?c}</#if>>
            <#else>
               
				<select data-placeholder="Select the Budget Year" class="chosen-select" id = "${name}" name="${name}" <#if multiselect?? && multiselect>multiple</#if> >
				<option value="-1"></option>
				<#assign startYear = JiveGlobals.getJiveIntProperty(statics['com.grail.synchro.SynchroConstants'].SYNCHRO_PROJECT_BUDGET_YEAR_START, 2013) />
				
				<#assign endYear = JiveGlobals.getJiveIntProperty(statics['com.grail.synchro.SynchroConstants'].SYNCHRO_PROJECT_BUDGET_YEAR_END, 2018) />
				
				
				<#assign counter = startYear />
							
				<#list startYear..endYear as x>
					<option value="${x?c}"  <#if value==x>selected</#if> >${x?c}</option>
				</#list>
				
				
				
				</select>
            </#if>
        </div>
		
		<span class="jive-error-message" id="budgetYearError" style="display:none">Please select Budget Year</span>
    </div>
	
	
	
</#macro>




<#macro renderEndMarketFundingField name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
 	<select data-placeholder="Select" class="chosen-select" id = "${name}" name='${name}'  <#if readonly>disabled</#if>/>
	  <option value="-1"></option>
	  <option  value="1" <#if value==1> selected </#if>>Yes</option>
	  <option  value="2" <#if value==2> selected </#if>>No</option>
	
	</select>
</#macro>
<#macro EuMarketConfrmationOptions name='' value=0 multiselect=false readonly=false selectNone=false>
  
	<select data-placeholder="Select" class="chosen-select" id = "${name}" <#if readonly>disabled</#if> name='${name}' >
	  <option value="-1"></option>
	  <option  <#if value==1> selected </#if> value="1" >Yes</option>
	  <option <#if value==2> selected </#if> value="2" >No</option>
	</select>
</#macro>
<#macro EndMarketFundingMarketConfrmationOptions name='' value=0 multiselect=false readonly=false selectNone=false>
  
	<select data-placeholder="Select" class="chosen-select" id = "${name}" <#if readonly>disabled</#if> name='${name}' >
	  <option value="-1"></option>
	  <option  <#if value==1> selected </#if> value="1" >Yes</option>
	  <option <#if value==2> selected </#if> value="2" >No</option>
	</select>
</#macro>

<#macro renderSelectProjectType name='' value=0 multiselect=false readonly=false selectNone=false>
 	<select data-placeholder="Select Project Type" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if>  <#if readonly>disabled</#if>/>
	  <option value=" "></option>
	  <option  value="1" >All</option>
	  <option  value="2" >Open</option>
	  <option  value="3" >Closed</option>
	  <#if statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) >
		<option  value="4" >Cancelled</option>
	  </#if>
	</select>
</#macro>

<#macro renderSelectProjectStatus name='' value=0 multiselect=false readonly=false selectNone=false>
 	<select data-placeholder="Select Project Status" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if>  <#if readonly>disabled</#if>/>
	  <option value=" "></option>
	  <option  value="1" >On Track</option>
	  <option  value="2" >Not On Track</option>
	</select>
</#macro>


<#macro renderTPDProjectStatus name='' value=0 multiselect=false readonly=false selectNone=false>
 	<select data-placeholder="Select TPD Status" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if>  <#if readonly>disabled</#if>/>
	  <option value=" "></option>
	  <option  value="1" >May have to be TPD Submitted</option>
	  <option  value="2" >Doesn't have to be TPD Submitted</option>
	   <option  value="3" >Pending</option>
	</select>
</#macro>

<#macro renderSelectProcessWaiverStatus name='' value=0 multiselect=false readonly=false selectNone=false>
 	<select data-placeholder="Select Waiver Status" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if>  <#if readonly>disabled</#if>/>
	  <option value=" "></option>
	  <option  value="2" >Pending</option>
	  <option  value="3" >Approved</option>
	  <option  value="4" >Rejected</option>
	</select>
</#macro>

<#macro renderSelectMethAndAgencyWaiverStatus name='' value=0 multiselect=false readonly=false selectNone=false>
 	<select data-placeholder="Select Waiver Status" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if>  <#if readonly>disabled</#if>/>
	  <option value=" "></option>
	  <option  value="0" >Pending</option>
	  <option  value="1" >Approved</option>
	  <option  value="2" >Rejected</option>
	</select>
</#macro>

<#macro renderSelectProjectStage name='' value=0 multiselect=false readonly=false selectNone=false>
 	<select data-placeholder="Select Project Stage" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if>  <#if readonly>disabled</#if>/>
	  <option value=" "></option>
	  <option  value="1" >In-Planning</option>
	  <option  value="2" >In-Progress</option>
	  <option  value="3" >Awaiting Results</option>
	  <option  value="4" >Closed</option>
	  <#if statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner()>
		<option  value="5" >Cancelled</option>
	  </#if>
	</select>
</#macro>

<#macro renderSelectCategoryType name='' value=0 multiselect=false readonly=false selectNone=false>
 	<div class="col-lg-6">
  
		<select data-placeholder="Select Category" class="chosen-select" id = "${name}" name='${name}' multiple >
		<option value=" "></option>
		   <#assign categoryTypes = statics['com.grail.synchro.SynchroGlobal'].getProductTypes() />
			<#assign categoryTypeKeySet = categoryTypes.keySet() />
			<#if (categoryTypes?has_content)>
				<#list categoryTypeKeySet as key>
					<#assign categoryType = categoryTypes.get(key) />
					 <option value="${key?c}" >${categoryType}</option>
				</#list>
			</#if>
		</select>
	
		<span class="jive-error-message" id="categoryTypeError" style="display:none">Please select Category</span>
		
	
	</div>
</#macro>

<#macro renderSelectEndMarkets name='' value=0 multiselect=false readonly=false selectNone=true>
 	<div class="col-lg-6">
  		<select data-placeholder="Select Research End market" class="chosen-select" id = "${name}" name='${name}'  <#if multiselect?? && multiselect>multiple</#if>  >
		<option value=" "></option>
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
							<option value="${endMarketkey?c}" >${endMarkets.get(endMarketkey)}</option>
						 </#list>
						 
						
					</optgroup>	 
					
				</#list>
			</#if>
		</select>
	</div>
</#macro>

<#macro renderSelectResearchAgency name='' value=0 multiselect=false readonly=false selectNone=true>

<select data-placeholder="Select Research Agency" title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if> >
						
	<option value=" "></option>
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
							<option isNonKantar="yes" value="${researchAgencykey?c}">${researchAgencies.get(researchAgencykey)}</option>
							
						<#else>
							<option isNonKantar="no" value="${researchAgencykey?c}" >${researchAgencies.get(researchAgencykey)}</option>
							
						</#if>
					 </#list>
				</optgroup>	 
			</#list>
		</#if>
	</select>
</#macro>


<#macro renderSelectMethodologyDetails name='' value=0 multiselect=false readonly=false selectNone=true>

	<select data-placeholder="Select Methodology" title="Select Methodology" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if> >
						
	<option value=" "></option>
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
								<option lessFrequent="yes" value="${methkey?c}" brandSpecific="${methodologyProperties.get(methkey).getBrandSpecific()}" > ${methodologies.get(methkey)}</option>
							<#else>
								<option lessFrequent="no" value="${methkey?c}" brandSpecific="${methodologyProperties.get(methkey).getBrandSpecific()}" >${methodologies.get(methkey)}</option>
							</#if>
						 </#list>
					</optgroup>	 
				</#list>
			</#if>
	</select>
</#macro>



<#macro renderSelectBrandedNonBrandedField name='' value=0 multiselect=false readonly=false selectNone=false>
    
	<#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
	<select title="Select Branding Option" data-placeholder="Select Branding Option" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if>>
		<option value="-1"></option>
		<option  value="30" <#if value==30> selected </#if> >Multi-Brand Study</option>
		<option  value="1" <#if value==1> selected </#if> >Non-brand related</option>
		<#if (brands?has_content)>
			<#list brands.keySet() as key>
				<#assign brand = brands.get(key)/>
				<option value="${key?c}">${brand}</option>
			</#list>
		</#if>
	</select>
</#macro>


<#macro renderSelectBudgetLocationFieldOLD name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
    <#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
	<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
	<#assign endMarketRegions = statics['com.grail.synchro.SynchroGlobal'].getRegionEndMarketsMapping() />
	
    <select title="Select Budget Location" data-placeholder="Select Budget Location" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if>>
		<option  value="-1" >Global</option>
		<#list regions.keySet() as regionKey>
			<#if regionKey==0>
			<#else>
				<option  value="${regionKey}" >${regions.get(regionKey)}</option>
			</#if>
		</#list>
		
		<#assign globalEndMarket = statics['com.grail.synchro.SynchroGlobal'].getGlobalEndMarket() />
		
		<#list endMarkets.keySet() as endMarketsKey>
			<#if globalEndMarket.get(endMarketsKey)??>
			<#else>
			<option  value="${endMarketsKey}" >${endMarkets.get(endMarketsKey)}</option>
			</#if>
		</#list>
		
		</select>
</#macro>

<#macro renderSelectBudgetLocationField name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
   
	<#if statics['com.grail.synchro.util.SynchroPermHelper'].isLegaUserType()>
		<#assign budgetLocations = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationTPDDashboardFilter(user) />
		<select title="Select Budget Location" data-placeholder="Select Budget Location" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if>>
			
			<#assign regionCounter = 0 />
			<#assign endMarketCounter = 0 />
			<#list budgetLocations.keySet() as bl>
				<#if bl==-1 >
					
					<option  value="${bl}" >${budgetLocations.get(bl)}</option>
					
				<#elseif (bl==-2 || bl==-3 || bl==-4 || bl==-5 || bl==-6)>
					<#if regionCounter==0>
					<optgroup label="-------------------------------">
					</#if>
					<#assign regionCounter = regionCounter + 1 />
					<option  value="${bl}" >${budgetLocations.get(bl)}</option>
					<#if regionCounter==0>
					</optgroup>
					</#if>
				<#else>
					<#if endMarketCounter==0>
					<optgroup label="-------------------------------">
					</#if>
					<#assign endMarketCounter = endMarketCounter + 1 />
					<option  value="${bl}" >${budgetLocations.get(bl)}</option>
					<#if endMarketCounter==0>
					</optgroup>
					</#if>
				</#if>	
			</#list>
		</select>
	<#else>
		<#assign budgetLocations = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationFilter(user) />
		<select title="Select Budget Location" data-placeholder="Select Budget Location" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if>>
			
			<#assign regionCounter = 0 />
			<#assign endMarketCounter = 0 />
			<#list budgetLocations.keySet() as bl>
				<#if bl==-1 >
					
					<option  value="${bl}" >${budgetLocations.get(bl)}</option>
					
				<#elseif (bl==-2 || bl==-3 || bl==-4 || bl==-5 || bl==-6)>
					<#if regionCounter==0>
					<optgroup label="-------------------------------">
					</#if>
					<#assign regionCounter = regionCounter + 1 />
					<option  value="${bl}" >${budgetLocations.get(bl)}</option>
					<#if regionCounter==0>
					</optgroup>
					</#if>
				<#else>
					<#if endMarketCounter==0>
					<optgroup label="-------------------------------">
					</#if>
					<#assign endMarketCounter = endMarketCounter + 1 />
					<option  value="${bl}" >${budgetLocations.get(bl)}</option>
					<#if endMarketCounter==0>
					</optgroup>
					</#if>
				</#if>	
			</#list>
			
		</select>
	</#if>	
</#macro>

<#macro renderSelectBudgetLocationTPDFilterField name='' value=0 multiselect=false readonly=false selectNone=false waiver=false>
   
	<#assign budgetLocations = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationTPDDashboardFilter(user) />
	
    <select title="Select Budget Location" data-placeholder="Select Budget Location" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if>>
	
		<#--
		<#list budgetLocations.keySet() as bl>
			<option  value="${bl}" >${budgetLocations.get(bl)}</option>
		</#list>
		-->
		
		<#assign regionCounter = 0 />
		<#assign endMarketCounter = 0 />
		<#list budgetLocations.keySet() as bl>
			<#if bl==-1 >
				
				<option  value="${bl}" >${budgetLocations.get(bl)}</option>
				
			<#elseif (bl==-2 || bl==-3 || bl==-4 || bl==-5 || bl==-6)>
				<#if regionCounter==0>
				<optgroup label="-------------------------------">
				</#if>
				<#assign regionCounter = regionCounter + 1 />
				<option  value="${bl}" >${budgetLocations.get(bl)}</option>
				<#if regionCounter==0>
				</optgroup>
				</#if>
			<#else>
				<#if endMarketCounter==0>
				<optgroup label="-------------------------------">
				</#if>
				<#assign endMarketCounter = endMarketCounter + 1 />
				<option  value="${bl}" >${budgetLocations.get(bl)}</option>
				<#if endMarketCounter==0>
				</optgroup>
				</#if>
			</#if>	
		</#list>
		
	</select>
</#macro>

<#macro renderSelectActionPending name='' value=0 multiselect=false readonly=false selectNone=false>
 	<select data-placeholder="Select Action Pending" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if>  <#if readonly>disabled</#if>/>
	  <option value=" "></option>
	  <option  value="1" >Brief Approval</option>
	  <option  value="2" >Proposal Approval</option>
	 
	</select>
</#macro>

<#macro renderTpdResearchDoneOn name='' value=0 multiselect=false readonly=false selectNone=false >
    <select data-placeholder="Select Research Done On" title="Select Research Done On" class="chosen-select" id = "${name}" name='${name}'  <#if readonly>disabled</#if> >
	 	<option  value="" ></option>
		<option  value="1" <#if value == '1'> selected </#if>>Existing Product in the Market</option>
		<option  value="2" <#if value == '2'> selected </#if>>Non-Existing Product in the Market</option>
		<option  value="3" <#if value == '3'> selected </#if>>Both - Existing & Non-existing Product in the Market</option>		
	</select>
</#macro>

<#macro renderTpdProductModification name='' value=0 multiselect=false readonly=false selectNone=false >
    <select data-placeholder="Select" title="Select" class="chosen-select" id = "${name}" name='${name}' <#if readonly>disabled</#if> >
	 	<option  value="" ></option>
		<option  value="1" <#if value == '1'> selected </#if>>Launch</option>
		<option  value="2" <#if value == '2'> selected </#if>>Modification</option>
		<option  value="3" <#if value == '3'> selected </#if>>None</option>
	</select>
</#macro>


<#macro renderSelectCostComponent name='' value=0 multiselect=false readonly=false selectNone=false>
 	<select data-placeholder="Select Cost Component" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if> <#if readonly>disabled</#if>/>
	  <option value=" "></option>
		<option  value="1" >Coordination</option>
		<option  value="2" >Fieldwork</option>
	 
	</select>
</#macro>


<#macro renderSpendByOptions name='' value=0 multiselect=false readonly=false selectNone=false>
 	<select data-placeholder="Select Spend Option" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if>  <#if readonly>disabled</#if>/>
		<option value=" "></option>
		<option  value="1" >COPLA</option>
		<option  value="2" >QPR 1</option>
		<option  value="3" >QPR 2</option>
		<option  value="4" >QPR 3</option>
		<option  value="5" >FULL YEAR</option>
	</select>
</#macro>

<#macro renderSelectSpendForOptions name='' value=0 multiselect=false readonly=false selectNone=false>
 	<select data-placeholder="Select Option" class="chosen-select" id = "${name}" name='${name}' <#if multiselect?? && multiselect>multiple</#if> <#if readonly>disabled</#if>/>
		<option value=" "></option>
		<option  value="1" >COPLA</option>
		<option  value="2" >QPR 1</option>
		<option  value="3" >QPR 2</option>
		<option  value="4" >QPR 3</option>
		<!--<option  value="5" >FULL YEAR</option> -->
		<option  value="6" >LATEST COST</option>
	</select>
</#macro>
