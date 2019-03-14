
<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#-- DWR def -->
<head>

    <script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>
    
    <script src="${themePath}/js/synchro/form-data-persist-handler.js?version=1" type="text/javascript"></script>
	<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/project-sticky-header.js'/>"></script>
	<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.MultiFile.js'/>"></script>
	<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ajaxfileupload.js'/>"></script>
    


</head>

<@resource.template file="/soy/userpicker/userpicker.soy" />
<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/commons.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>

<#assign defaultCurrency = statics['com.grail.synchro.util.SynchroUtils'].getDefaultCurrencyByProject(projectID) />

<#include "/template/global/include/synchro-macros.ftl" />

<script type="text/javascript">
    $j(document).ready(function(){
        AUTO_SAVE.register({form:$j("#pib-form"), projectID:${projectID?c}});
        PROJECT_STAGE_NAVIGATOR.initialize({
        <#if projectID??>
            projectId:${projectID?c},
        </#if>
            activeStage:-1
        });

    });
	
	var defaultCurrency = ${defaultCurrency?c};
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
	
	var userID = ${user.ID?c};
	
    
     function sendForApprovalWaiver()
    {
    	showLoader('Please wait...');
        var form = $j("#waiver-form");
        form.submit();
    }
    function sendForInformationWaiver()
    {
    	showLoader('Please wait...');
        setMethodologyWaiverSendforInfo();
        var form = $j("#waiver-form");
        form.submit();
    }
    function requestForInformationWaiver()
    {
    	showLoader('Please wait...');
        setMethodologyWaiverReqMoreInfo();
        var form = $j("#waiver-form");
        form.submit();
    }
    function approveWaiver()
    {
    	showLoader('Please wait...');
        setMethodologyWaiverApprove();
        var form = $j("#waiver-form");
        form.submit();
    }
    function rejectWaiver()
    {
    	showLoader('Please wait...');
        setMethodologyWaiverReject();
        var form = $j("#waiver-form");
        form.submit();
    }
    
    function sendForApprovalKantarWaiver()
    {
    	 showLoader('Please wait...');
        var form = $j("#kantar-waiver-form");
        form.submit();
    }
    function sendForInformationKantarWaiver()
    {
    	 showLoader('Please wait...');
        setKantarMethodologyWaiverSendforInfo();
        var form = $j("#kantar-waiver-form");
        form.submit();
    }
    function requestForInformationKantarWaiver()
    {
    	showLoader('Please wait...');
        setKantarMethodologyWaiverReqMoreInfo();
        var form = $j("#kantar-waiver-form");
        form.submit();
    }
    function approveKantarWaiver()
    {
    	 showLoader('Please wait...');
        setKantarMethodologyWaiverApprove();
        var form = $j("#kantar-waiver-form");
        form.submit();
    }
    function rejectKantarWaiver()
    {
    	showLoader('Please wait...');
        setKantarMethodologyWaiverReject();
        var form = $j("#kantar-waiver-form");
        form.submit();
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
    
    
    function closeEmailNotification()
    {
        $j("#emailNotification").trigger('close');
    }
    function sendNotificationFormat(recipients,subject,body,notificationTabId)
    {


        $j(".MultiFile-remove").each(function(index) {
            $j(this).click();
        });

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

        $j(".MultiFile-remove").each(function(index) {
            $j(this).click();
        });

        return false;
    }
    
    function approveReportsEndMarketId(recipients,subject,body,notificationTabId, endMarketId)
    {
    	<#if allProjectSpecsArroved?? && !allProjectSpecsArroved>
                dialog({title:"Message",html:"Project Spec(s) for one or more end markets is not approved. You will be able to approve the Report as soon as approval is received on Project Specs."});
                return false;
        </#if >
        return sendNotificationFormatEndMarketId(recipients,subject,body,notificationTabId, endMarketId);
    }
    
    function approveReports(recipients,subject,body,notificationTabId)
    {
    	<#if allProjectSpecsArroved?? && !allProjectSpecsArroved>
                dialog({title:"Message",html:"Project Spec(s) for one or more end markets is not approved. You will be able to approve the Report as soon as approval is received on Project Specs."});
                return false;
        </#if >
        return sendNotificationFormat(recipients,subject,body,notificationTabId);
    }
    
    function sendNotificationFormatEndMarketId(recipients,subject,body,notificationTabId, endMarketId)
    {

		
       
        $j(".MultiFile-remove").each(function(index) {
            $j(this).click();
        });

        return sendNotificationEndMarketId(recipients,subject.replace(/"""/g ,"'"),body.replace(/"""/g ,"'"),notificationTabId, endMarketId);
    }

    function sendNotificationEndMarketId(recipients,subject,body,notificationTabId, endMarketId)
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
        $j("#emailEndMarketId").val(endMarketId);

        $j(".MultiFile-remove").each(function(index) {
            $j(this).click();
        });

        return false;
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
                    $j("#messageBody").val(messageBody);
                    $j("#email-notification-form").submit();
                },
                async: true
            });
        }
    }
    
	function openInitiateWaiverWindow()
	{
	    $j("#initiateWaiver").lightbox_me({centered:true,closeEsc:false,closeClick:false,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7}});
	    initiateRTE('methodologyDeviationRationale', 2500, false);
	    initiateRTE('methodologyApproverComment', 2500, false);
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
    }
    function showPIBFieldsWindow(endMarketId)
    {
        
        $j( "#pibFieldsWindow .pibFieldsWindowClass" ).each(function( index ) {
	        $j(this).hide();
	    });
        pibFieldsWindow.show();
        $j('#pibFieldsWindow #pibPendingFields'+endMarketId).css("display","block");

    }

    function showProposalFieldsWindow()
    {
        proposalFieldsWindow.show();

    }
    function showProjectSpecsFieldsWindow(endMarketId)
    {
       $j( "#projectSpecsFieldsWindow .projectSpecsFieldsWindowClass" ).each(function( index ) {
	        $j(this).hide();
	    });
        projectSpecsFieldsWindow.show();
        $j('#projectSpecsFieldsWindow #psPendingFields'+endMarketId).css("display","block");
   
    }
  
    function showReportSummaryFieldsWindow(endMarketId)
    {
       $j( "#reportSummaryFieldsWindow .reportSummaryFieldsWindowClass" ).each(function( index ) {
	        $j(this).hide();
	    });
        reportSummaryFieldsWindow.show();
        $j('#reportSummaryFieldsWindow #rsPendingFields'+endMarketId).css("display","block");
   
    }
    function awardAgency()
    {
    <#if fundingInvestments??>
        <#assign fundingApprovalPending = false />
        <#list fundingInvestments as fundingInvestment>
            <#assign skip = false />
            <#if fundingInvestment.getEndmarketStatus()?? && fundingInvestment.getEndmarketStatus()==statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].CANCEL.ordinal() >
                <#assign skip = true />
            </#if>

            <#if (fundingInvestment.approvalStatus?? && fundingInvestment.approvalStatus) || skip>
                <!-- Do Nothing -->
            <#else>
                <#assign fundingApprovalPending = true />
            </#if>
        </#list>

        <#--if("${fundingApprovalPending?string}"=="true")-->
        <#--{-->
            <#--dialog({title:"Message",html:"All budget approvals are required to be able to award the project to an agency. For pending approval please visit ‘View Costs/ Approvals’ on PIB"});-->
            <#--return false;-->
        <#--}-->

    </#if>
        dialog({
            title:"Message",
            html:"Are you sure you want to award the project to this agency? You will not be able to undo this action later.<br>Once awarded, please raise a PO.",
            buttons:{
                "OK":function() {
                    var form = $j("#awardAgency-form");
                    form.submit();
                },
                "Cancel":function() {
                    closeDialog();
                }
            }

        });
        return false;
    }
</script>

<script type="text/javascript">
   <#--
    var initiateWaiverWindow = null;
    $j(document).ready(function(){
        initiateWaiverWindow = new LIGHT_BOX($j("#initiateWaiver"),{title:'Request for Methodology Waiver',confirmOnClose:true});

    });
	-->
    var initiateKantarWaiverWindow = null;
    $j(document).ready(function(){
        initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request Waiver for using Non-Kantar Agency',confirmOnClose:true});

    });

    var pibFieldsWindow = null;
    $j(document).ready(function(){
        pibFieldsWindow = new LIGHT_BOX($j("#pibFieldsWindow"),{title:'PIB Fields',confirmOnClose:false});

    });

    var proposalFieldsWindow = null;
    $j(document).ready(function(){
        proposalFieldsWindow = new LIGHT_BOX($j("#proposalFieldsWindow"),{title:'Proposal Fields',confirmOnClose:false});

    });

    var projectSpecsFieldsWindow = null;
    $j(document).ready(function(){
        projectSpecsFieldsWindow = new LIGHT_BOX($j("#projectSpecsFieldsWindow"),{title:'Project Specs Fields',confirmOnClose:false});

    });

    var reportSummaryFieldsWindow = null;
    $j(document).ready(function(){
        reportSummaryFieldsWindow = new LIGHT_BOX($j("#reportSummaryFieldsWindow"),{title:'Report Summary Fields',confirmOnClose:false});

    });

</script>

<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
<#assign isMethAppUser = statics['com.grail.synchro.util.SynchroPermHelper'].isMethodologyApproverUser() />
<#assign isProjectOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectOwner(projectID) />
<#assign isKantarMethAppUser = statics['com.grail.synchro.util.SynchroPermHelper'].isKantarMethodologyApproverUser() />
<#assign isProjectCreator = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectCreator(projectID) />
<#assign isAboveMarketProjectContactUser = statics['com.grail.synchro.util.SynchroPermHelper'].isAboveMarketProjectContact(projectID) />
<#assign isProcUser = statics['com.grail.synchro.util.SynchroPermHelper'].isProcurementUser(projectID,statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID) />
<#assign stageNumber = statics['com.grail.synchro.beans.ProjectStage'].getCurrentStageNumber(project)/>

<div class="border-container">
<div class="project_names">

<h2>${project.name?html} (${generateProjectCode('${projectID?c}')}) </h2>
<div class="legends-icons-current-status">
    <ul>
        <li class="legend-complete-status-icon">Completed</li>
        <li class="legend-pending-status-icon">Pending</li>
        <li class="legend-next-step-icon">Next Step</li>
    </ul>
</div>
<div class="current-status-container">
<h3 class="container-header">PENDING ACTIONS</h3>
<table class="current-status-table">
<thead>
<tr>
    <th class="table-header first">ACTIVITY DESCRIPTION</th>
    <th class="table-header status-header">STATUS</th>
    <th class="table-header status-header">COMPLETION DATE</th>
    <th class="table-header responsible-header">PERSON RESPONSIBLE<br/><i>(Click on the name to contact the person)</i></th>
    <th class="table-header next-step-header last">PENDING ACTIONS</th>
</tr>
</thead>
<tbody>
<tr class="top-row">
    
    <#if project.status gt statics['com.grail.synchro.SynchroGlobal$Status'].DRAFT.ordinal() >
    	<td class="table-data-header first">PIT</td>
    <#else>
    	<td class="table-data-header first"><a href="${pitStageUrl}">PIT </a></td>
    </#if>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
</tr>

<#assign firstNextItemIcon = "false" />


<#list pitCurrentStatusList as pitCurrentStatus>
<#--<tr <#if pitCurrentStatus_index = (pitCurrentStatusList?size-1)>class="last-row"</#if>>-->
<#if pitCurrentStatus.status=="Complete" >
	<tr class="status-complete">
<#else>
	<tr class="status-pending">
</#if>
    <td class="activity-name first">${pitCurrentStatus.activityDesc}</td>
    <td class="check-box"><input type="checkbox" name="status" disabled <#if pitCurrentStatus.status=="Complete">checked="true"</#if>/><label></label></td>
	<#if pitCurrentStatus.completionDate??>
		<td>${pitCurrentStatus.completionDate?string('dd/MM/yyyy')}</td>
	<#else>
		<td></td>
	</#if>
    <#if pitCurrentStatus.status=="Complete">
    	<td>${pitCurrentStatus.personResponsible}</td>
    <#else>
    	<td><a  onclick="return sendNotificationFormat('${pitCurrentStatus.personRespEmail}','${pitCurrentStatus.personRespSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pitCurrentStatus.personRespMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PENDING_ACTION_PERSON_RESPONSIBLE');" href="">${pitCurrentStatus.personResponsible}</a></td>
    </#if>

    <#if pitCurrentStatus.nextStepLink?? && pitCurrentStatus.nextStepLink!="">
        <td class="next-step-action"><a href="${pitCurrentStatus.nextStepLink}" >${pitCurrentStatus.nextStep}</a></td>
    <#else>
        <td class="next-step-action">${pitCurrentStatus.nextStep}</td>
    </#if>
</tr>
</#list>


<#if pibCurrentStatusList?? && pibCurrentStatusList.size() gt 0>
<tr>
    <td <#if stageNumber?? && stageNumber==statics['com.grail.synchro.beans.ProjectStage$StageType'].PIB.getStageNumber() >class="table-data-header active" <#else> class="table-data-header first"</#if>><a href="${pibStageUrl}">PIB </a></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
</tr>
</#if>



<#list pibCurrentStatusList as pibCurrentStatus>
<#--<tr <#if pibCurrentStatus_index = (pibCurrentStatusList?size-1)>class="last-row"</#if>>-->
<#if pibCurrentStatus.status=="Complete" >
	<tr class="status-complete">
<#else>
	<tr class="status-pending">
</#if>
    <#if pibCurrentStatus.activityDesc.contains("Project Brief")>
        <td class="table-data-header first subheading"><a onclick="javascript:showPIBFieldsWindow('${pibCurrentStatus.endMarketID}');" href="javascript:void(0);">${pibCurrentStatus.activityDesc}</a></td>
    <#else>
        <td class="activity-name first">${pibCurrentStatus.activityDesc}</td>
    </#if>
    <td class="check-box"><input type="checkbox" name="status"  disabled id="" <#if pibCurrentStatus.status=="Complete">checked="true" </#if>/><label></label> </td>
	
	<#if pibCurrentStatus.completionDate??>
		<td>${pibCurrentStatus.completionDate?string('dd/MM/yyyy')}</td>
	<#else>
		<td></td>
	</#if>
	
    
	<#if pibCurrentStatus.status=="Complete" || pibStatus=="Completed">
    	
    	 <#if pibCurrentStatus.nextStep=="View/Approve Waiver" && pibCurrentStatus.status=="Pending">
	            <#if pibCurrentStatus.activityDesc=="Agency Waiver Approval">
	                <td><a  onclick="return sendNotificationFormat('${pibCurrentStatus.personRespEmail}','${pibCurrentStatus.personRespSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibCurrentStatus.personRespMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PENDING_ACTION_PERSON_RESPONSIBLE');" href="">${pibCurrentStatus.personResponsible}</a></td>
	            <#else>
	                <td><a  onclick="return sendNotificationFormat('${pibCurrentStatus.personRespEmail}','${pibCurrentStatus.personRespSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibCurrentStatus.personRespMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PENDING_ACTION_PERSON_RESPONSIBLE');" href="">${pibCurrentStatus.personResponsible}</a></td>
	            </#if>
	     <#else>
			<td>${pibCurrentStatus.personResponsible}</td>
		</#if>
    <#else>
    	<td><a  onclick="return sendNotificationFormat('${pibCurrentStatus.personRespEmail}','${pibCurrentStatus.personRespSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibCurrentStatus.personRespMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PENDING_ACTION_PERSON_RESPONSIBLE');" href="">${pibCurrentStatus.personResponsible}</a></td>
    </#if>
    
	<#if (user.email==pibCurrentStatus.personRespEmail || isAdminUser) && pibStatus=="Pending">
	    <#if pibCurrentStatus.nextStepLink?? && pibCurrentStatus.nextStepLink!="">
	        <#if firstNextItemIcon=="false">
	        	<#assign firstNextItemIcon = "true" />
	        	<td class="next-step-action first"><a href="${pibCurrentStatus.nextStepLink}" >${pibCurrentStatus.nextStep}</a></td>
	        <#else>
	        	<td class="next-step-action"><a href="${pibCurrentStatus.nextStepLink}" >${pibCurrentStatus.nextStep}</a></td>
	        </#if>
	        
	    <#else>
	        <#if pibCurrentStatus.nextStep=="View/Approve Waiver">
	            <#if pibCurrentStatus.activityDesc=="Agency Waiver Approval">
	                
	                <#if firstNextItemIcon=="false">
			        	<#assign firstNextItemIcon = "true" />
			        	<td class="next-step-action first"><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);">${pibCurrentStatus.nextStep}</a></td>
			        <#else>
			        	<td class="next-step-action"><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);">${pibCurrentStatus.nextStep}</a></td>
			        </#if>
	            <#else>
	                
	                <#if firstNextItemIcon=="false">
			        	<#assign firstNextItemIcon = "true" />
			        	<td class="next-step-action first"><a onclick="javascript:openInitiateWaiverWindow();" href="javascript:void(0);">${pibCurrentStatus.nextStep}</a></td>
			        <#else>
			        	<td class="next-step-action"><a onclick="javascript:openInitiateWaiverWindow();" href="javascript:void(0);">${pibCurrentStatus.nextStep}</a></td>
			        </#if>
	            </#if>
	        <#elseif pibCurrentStatus.nextStep=="Send Brief to Agency">
	            <#if pibCurrentStatus.nextStepEnable?? && pibCurrentStatus.nextStepEnable  >
	            	
	            	<#if firstNextItemIcon=="false">
			        	<#assign firstNextItemIcon = "true" />
			        	<td class="next-step-action first"><a  onclick="return sendNotificationFormat('${pibCurrentStatus.nextStepPersonEmail}','${pibCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PIB_COMPLETE_NOTIFY_AGENCY');" href="">${pibCurrentStatus.nextStep}</a></td>
			        <#else>
			        	<td class="next-step-action"><a  onclick="return sendNotificationFormat('${pibCurrentStatus.nextStepPersonEmail}','${pibCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PIB_COMPLETE_NOTIFY_AGENCY');" href="">${pibCurrentStatus.nextStep}</a></td>
			        </#if>
	            <#else>
	            	<td class="next-step-action">${pibCurrentStatus.nextStep}</td>
	            </#if>
	        <#elseif pibCurrentStatus.nextStep=="Notify Above Market SP&I">
	            
	               <#if firstNextItemIcon=="false">
			        	<#assign firstNextItemIcon = "true" />
			        	<td class="next-step-action first"><a  onclick="return sendNotificationFormat('${pibCurrentStatus.nextStepPersonEmail}','${pibCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PIB_NOTIFY_ABOVE_MARKET_SPI');" href="">${pibCurrentStatus.nextStep}</a></td>
			        <#else>
			        	<td class="next-step-action"><a  onclick="return sendNotificationFormat('${pibCurrentStatus.nextStepPersonEmail}','${pibCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${pibCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PIB_NOTIFY_ABOVE_MARKET_SPI');" href="">${pibCurrentStatus.nextStep}</a></td>
			        </#if>    
	        <#elseif pibCurrentStatus.nextStep.contains("Provide Cost Approval")>
	            
	               <#if firstNextItemIcon=="false">
			        	<#assign firstNextItemIcon = "true" />
			        	<td class="next-step-action first"><a  href="javascript:void(0);" onclick="javascript:openPITWindow()">${pibCurrentStatus.nextStep}</a></td>
			        <#else>
			        	<td class="next-step-action"><a  href="javascript:void(0);" onclick="javascript:openPITWindow()">${pibCurrentStatus.nextStep}</a></td>
			        </#if>    
	        <#else>
	            <td class="next-step-action">${pibCurrentStatus.nextStep}</td>
	        </#if>
	    </#if>
	<#else>
		 <#if pibCurrentStatus.nextStep=="View/Approve Waiver">
	            <#if pibCurrentStatus.activityDesc=="Agency Waiver Approval">
	                <td class="next-step-action"><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);">${pibCurrentStatus.nextStep}</a></td>
	            <#else>
	                <td class="next-step-action"><a onclick="javascript:openInitiateWaiverWindow();" href="javascript:void(0);">${pibCurrentStatus.nextStep}</a></td>
	            </#if>
	    <#elseif (user.email==pibCurrentStatus.personRespEmail || isAdminUser) && pibCurrentStatus.nextStep.contains("Provide Cost Approval")>
	            <td class="next-step-action"><a  href="javascript:void(0);" onclick="javascript:openPITWindow()">${pibCurrentStatus.nextStep}</a></td>
	     <#else>
			<td class="next-step-action">${pibCurrentStatus.nextStep}</td>
		</#if>
		
	</#if>
</tr>
</#list>


<#if proposalCurrentStatusList?? && proposalCurrentStatusList.size() gt 0>
<tr>
    <td <#if stageNumber?? && stageNumber==statics['com.grail.synchro.beans.ProjectStage$StageType'].PROPOSAL.getStageNumber() >class="table-data-header active" <#else> class="table-data-header first"</#if>><a href="${proposalStageUrl}" >PROPOSAL </a></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
</tr>
</#if>
<#list proposalCurrentStatusList as proposalCurrentStatus>
<#--<tr <#if proposalCurrentStatus_index = (proposalCurrentStatusList?size-1)>class="last-row"</#if>>-->
<#if proposalCurrentStatus.status=="Complete" >
	<tr class="status-complete">
<#else>
	<tr class="status-pending">
</#if>

    <#if proposalCurrentStatus.activityDesc=="Project Proposal">
        <td class="table-data-header first subheading"><a onclick="javascript:showProposalFieldsWindow();" href="javascript:void(0);">${proposalCurrentStatus.activityDesc}</a></td>
    <#else>
        <td class="activity-name first">${proposalCurrentStatus.activityDesc}</td>
    </#if>
    <td class="check-box"><input type="checkbox" name="status" disabled  id="" <#if proposalCurrentStatus.status=="Complete">checked="true" </#if> /> <label></label></td>
	
	<#if proposalCurrentStatus.completionDate??>
		<td>${proposalCurrentStatus.completionDate?string('dd/MM/yyyy')}</td>
	<#else>
		<td></td>
	</#if>
    <#if proposalCurrentStatus.status=="Complete" || proposalStatus=="Completed">
    	<td>${proposalCurrentStatus.personResponsible}</td>
    <#else>
    	<td><a  onclick="return sendNotificationFormat('${proposalCurrentStatus.personRespEmail}','${proposalCurrentStatus.personRespSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${proposalCurrentStatus.personRespMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PENDING_ACTION_PERSON_RESPONSIBLE');" href="">${proposalCurrentStatus.personResponsible}</a></td>
    </#if>

    <#if (user.email==proposalCurrentStatus.personRespEmail || isAdminUser) && proposalStatus=="Pending">
	    <#if proposalCurrentStatus.nextStepLink?? && proposalCurrentStatus.nextStepLink!="">
	        
	        <#if firstNextItemIcon=="false">
	        	<#assign firstNextItemIcon = "true" />
	        	<td class="next-step-action first"><a href="${proposalCurrentStatus.nextStepLink}" >${proposalCurrentStatus.nextStep}</a></td>
	        <#else>
	        	<td class="next-step-action"><a href="${proposalCurrentStatus.nextStepLink}" >${proposalCurrentStatus.nextStep}</a></td>
	        </#if>
	    <#else>
	        <#if proposalCurrentStatus.nextStep=="Send Proposal to BAT">
	             <#if proposalCurrentStatus.nextStepEnable?? && proposalCurrentStatus.nextStepEnable  >
	            	
	            	<#if firstNextItemIcon=="false">
			        	<#assign firstNextItemIcon = "true" />
			        	<td class="next-step-action first"><a  onclick="return sendNotificationFormat('${proposalCurrentStatus.nextStepPersonEmail}','${proposalCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${proposalCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_PROPOSAL_TO_BAT');" href="">${proposalCurrentStatus.nextStep}</a></td>
			        <#else>
			        	<td class="next-step-action"><a  onclick="return sendNotificationFormat('${proposalCurrentStatus.nextStepPersonEmail}','${proposalCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${proposalCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_PROPOSAL_TO_BAT');" href="">${proposalCurrentStatus.nextStep}</a></td>
			        </#if>
	            <#else>
	            	<td class="next-step-action">${proposalCurrentStatus.nextStep}</td>
	            </#if>
	            
	        <#elseif proposalCurrentStatus.nextStep=="Notify BAT about Proposal Revision">
            
            	<#if firstNextItemIcon=="false">
		        	<#assign firstNextItemIcon = "true" />
		        	<td class="next-step-action first"><a  onclick="return sendNotificationFormat('${proposalCurrentStatus.nextStepPersonEmail}','${proposalCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${proposalCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_BAT_ABOUT_PROPOSAL_REVISION');" href="">${proposalCurrentStatus.nextStep}</a></td>
		        <#else>
		        	<td class="next-step-action"><a  onclick="return sendNotificationFormat('${proposalCurrentStatus.nextStepPersonEmail}','${proposalCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${proposalCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_BAT_ABOUT_PROPOSAL_REVISION');" href="">${proposalCurrentStatus.nextStep}</a></td>
		        </#if>
	        <#elseif proposalCurrentStatus.nextStep=="Send Proposal to Project Owner">
	             <#if proposalCurrentStatus.nextStepEnable?? && proposalCurrentStatus.nextStepEnable  >
	            	
		            <#if firstNextItemIcon=="false">
			        	<#assign firstNextItemIcon = "true" />
			        	<td class="next-step-action first"><a  onclick="return sendNotificationFormat('${proposalCurrentStatus.nextStepPersonEmail}','${proposalCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${proposalCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_PROPOSAL_TO_PROJECT_OWNER');" href="">${proposalCurrentStatus.nextStep}</a></td>
			        <#else>
			        	<td class="next-step-action"><a  onclick="return sendNotificationFormat('${proposalCurrentStatus.nextStepPersonEmail}','${proposalCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${proposalCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_PROPOSAL_TO_PROJECT_OWNER');" href="">${proposalCurrentStatus.nextStep}</a></td>
			        </#if>
	            <#else>
	            	<td class="next-step-action">${proposalCurrentStatus.nextStep}</td>
	            </#if>
	           
	        <#elseif proposalCurrentStatus.nextStep=="Award Proposal">
	            
	             <#if proposalCurrentStatus.nextStepEnable?? && proposalCurrentStatus.nextStepEnable  >
	            	 
	            	<#if firstNextItemIcon=="false">
			        	<#assign firstNextItemIcon = "true" />
			        	<td class="next-step-action first"><a  onclick="awardAgency()" href="javascript:void(0);">${proposalCurrentStatus.nextStep}</a></td>
			        <#else>
			        	<td class="next-step-action"><a  onclick="awardAgency()" href="javascript:void(0);">${proposalCurrentStatus.nextStep}</a></td>
			        </#if>
	            <#else>
	            	<td class="next-step-action">${proposalCurrentStatus.nextStep}</td>
	            </#if>
	        <#else>
	            <td class="next-step-action">${proposalCurrentStatus.nextStep}</td>
	        </#if>
	    </#if>
	<#else>
		<td class="next-step-action">${proposalCurrentStatus.nextStep}</td>
	</#if>
</tr>
</#list>



<#if projectSpecsCurrentStatusList?? && projectSpecsCurrentStatusList.size() gt 0>
<tr>
    <td <#if stageNumber?? && stageNumber==statics['com.grail.synchro.beans.ProjectStage$StageType'].PROJECT_SPECS.getStageNumber() >class="table-data-header active" <#else> class="table-data-header first"</#if>><a href="${projectSpecsStageUrl}" >PROJECT SPECS </a></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
</tr>
</#if>
<#list projectSpecsCurrentStatusList as projectSpecsCurrentStatus>
<#--<tr <#if projectSpecsCurrentStatus_index = (projectSpecsCurrentStatusList?size-1)>class="last-row"</#if>>-->
<#if projectSpecsCurrentStatus.status=="Complete" >
	<tr class="status-complete">
<#else>
	<tr class="status-pending">
</#if>
    
     
    <#if projectSpecsCurrentStatus.activityDesc.contains("Project Specs -")>
        <td class="table-data-header first subheading"><a onclick="javascript:showProjectSpecsFieldsWindow('${projectSpecsCurrentStatus.endMarketID}');" href="javascript:void(0);">${projectSpecsCurrentStatus.activityDesc}</a></td>
    <#else>
        <td class="activity-name first">${projectSpecsCurrentStatus.activityDesc}</td>
    </#if>
    <td class="check-box"><input type="checkbox" name="status" disabled id=""  <#if projectSpecsCurrentStatus.status=="Complete">checked="true" </#if> /> <label></label></td>

	<#if projectSpecsCurrentStatus.completionDate??>
		<td>${projectSpecsCurrentStatus.completionDate?string('dd/MM/yyyy')}</td>
	<#else>
		<td></td>
	</#if>
	
     <#if projectSpecsCurrentStatus.status=="Complete" || projectSpecsStatus=="Completed">
    	<td>${projectSpecsCurrentStatus.personResponsible}</td>
    <#else>
    	<td><a  onclick="return sendNotificationFormat('${projectSpecsCurrentStatus.personRespEmail}','${projectSpecsCurrentStatus.personRespSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${projectSpecsCurrentStatus.personRespMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PENDING_ACTION_PERSON_RESPONSIBLE');" href="">${projectSpecsCurrentStatus.personResponsible}</a></td>
    </#if>
    
    <#if (user.email==projectSpecsCurrentStatus.personRespEmail || isAdminUser) && projectSpecsStatus=="Pending">
	    <#if projectSpecsCurrentStatus.nextStepLink?? && projectSpecsCurrentStatus.nextStepLink!="">
	        
	        <#if firstNextItemIcon=="false">
	        	<#assign firstNextItemIcon = "true" />
	        	<td class="next-step-action first"><a href="${projectSpecsCurrentStatus.nextStepLink}" >${projectSpecsCurrentStatus.nextStep}</a></td>
	        <#else>
	        	<td class="next-step-action"><a href="${projectSpecsCurrentStatus.nextStepLink}" >${projectSpecsCurrentStatus.nextStep}</a></td>
	        </#if>
	    <#else>
	        <#if projectSpecsCurrentStatus.nextStep.contains("Notify BAT about Project Specs Revision")>
	            
	            <#if firstNextItemIcon=="false">
		        	<#assign firstNextItemIcon = "true" />
		        	<td class="next-step-action first"><a  onclick="return sendNotificationFormat('${projectSpecsCurrentStatus.nextStepPersonEmail}','${projectSpecsCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${projectSpecsCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_BAT_PROJECT_SPECS_REVISION');" href="">${projectSpecsCurrentStatus.nextStep}</a></td>
		        <#else>
		        	<td class="next-step-action"><a  onclick="return sendNotificationFormat('${projectSpecsCurrentStatus.nextStepPersonEmail}','${projectSpecsCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${projectSpecsCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_BAT_PROJECT_SPECS_REVISION');" href="">${projectSpecsCurrentStatus.nextStep}</a></td>
		        </#if>
	        <#elseif projectSpecsCurrentStatus.nextStep.contains("Approve Project Specs")>
	            
	            <#if projectSpecsCurrentStatus.nextStepEnable?? && projectSpecsCurrentStatus.nextStepEnable  >
	            	 <#if projectSpecsCurrentStatus.endMarketID??>
	            	 	
	            	 	<#if firstNextItemIcon=="false">
				        	<#assign firstNextItemIcon = "true" />
				        	<td class="next-step-action first"><a  onclick="return sendNotificationFormatEndMarketId('${projectSpecsCurrentStatus.nextStepPersonEmail}','${projectSpecsCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${projectSpecsCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE_PROJECT_SPECS','${projectSpecsCurrentStatus.endMarketID?c}');" href="">${projectSpecsCurrentStatus.nextStep}</a></td>
				        <#else>
				        	<td class="next-step-action"><a  onclick="return sendNotificationFormatEndMarketId('${projectSpecsCurrentStatus.nextStepPersonEmail}','${projectSpecsCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${projectSpecsCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE_PROJECT_SPECS','${projectSpecsCurrentStatus.endMarketID?c}');" href="">${projectSpecsCurrentStatus.nextStep}</a></td>
				        </#if>
	            	 <#else>
	            	 	
	            	 	<#if firstNextItemIcon=="false">
				        	<#assign firstNextItemIcon = "true" />
				        	<td class="next-step-action first"><a  onclick="return sendNotificationFormat('${projectSpecsCurrentStatus.nextStepPersonEmail}','${projectSpecsCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${projectSpecsCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE_PROJECT_SPECS');" href="">${projectSpecsCurrentStatus.nextStep}</a></td>
				        <#else>
				        	<td class="next-step-action"><a  onclick="return sendNotificationFormat('${projectSpecsCurrentStatus.nextStepPersonEmail}','${projectSpecsCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${projectSpecsCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE_PROJECT_SPECS');" href="">${projectSpecsCurrentStatus.nextStep}</a></td>
				        </#if>
	            	 </#if>
	            <#else>
	            	<td class="next-step-action">${projectSpecsCurrentStatus.nextStep}</td>
	            </#if>
	
	        <#else>
	            <td class="next-step-action">${projectSpecsCurrentStatus.nextStep}</td>
	        </#if>
	
	    </#if>
	 <#else>
	 	<td class="next-step-action">${projectSpecsCurrentStatus.nextStep}</td>
	 </#if>
</tr>
</#list>


<#if reportCurrentStatusList?? && reportCurrentStatusList.size() gt 0>
<tr>
    <td <#if stageNumber?? && stageNumber==statics['com.grail.synchro.beans.ProjectStage$StageType'].REPORT.getStageNumber() >class="table-data-header active" <#else> class="table-data-header first"</#if>><a href="${reportSummaryStageUrl}" >REPORT SUMMARY </a></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
    <td class="table-data-header last"></td>
</tr>
</#if>
<#list reportCurrentStatusList as reportCurrentStatus>
<#--<tr <#if reportCurrentStatus_index = (reportCurrentStatusList?size-1)>class="last-row"</#if>>-->
<#if reportCurrentStatus.status=="Complete" >
	<tr class="status-complete">
<#else>
	<tr class="status-pending">
</#if>
    <#if reportCurrentStatus.activityDesc.contains("Reports -")>
        <td class="table-data-header first subheading"><a onclick="javascript:showReportSummaryFieldsWindow('${reportCurrentStatus.endMarketID}');" href="javascript:void(0);">${reportCurrentStatus.activityDesc}</a></td>
    <#else>
        <td class="activity-name first">${reportCurrentStatus.activityDesc}</td>
    </#if>
    <td class="check-box"><input type="checkbox" name="status" disabled  id="" <#if reportCurrentStatus.status=="Complete">checked="true" </#if> /> <label></label></td>
	
	<#if reportCurrentStatus.completionDate??>
		<td>${reportCurrentStatus.completionDate?string('dd/MM/yyyy')}</td>
	<#else>
		<td></td>
	</#if>
	
    <#if reportCurrentStatus.status=="Complete" || reportSummaryStatus=="Completed">
    	<td>${reportCurrentStatus.personResponsible}</td>
    <#else>
    	<td><a  onclick="return sendNotificationFormat('${reportCurrentStatus.personRespEmail}','${reportCurrentStatus.personRespSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.personRespMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PENDING_ACTION_PERSON_RESPONSIBLE');" href="">${reportCurrentStatus.personResponsible}</a></td>
    </#if>

    <#if (user.email==reportCurrentStatus.personRespEmail || isAdminUser) && reportSummaryStatus=="Pending">
	    <#if reportCurrentStatus.nextStepLink?? && reportCurrentStatus.nextStepLink!="">
	        
	        <#if firstNextItemIcon=="false">
	        	<#assign firstNextItemIcon = "true" />
	        	<td class="next-step-action first"><a href="${reportCurrentStatus.nextStepLink}" >${reportCurrentStatus.nextStep}</a></td>
	        <#else>
	        	<td class="next-step-action"><a href="${reportCurrentStatus.nextStepLink}" >${reportCurrentStatus.nextStep}</a></td>
	        </#if>
	    <#else>
	        <#if reportCurrentStatus.nextStep.contains("Upload Reports")>
	           
	             <#if reportCurrentStatus.nextStepEnable?? && reportCurrentStatus.nextStepEnable  >
	            	  
	            	  <#if reportCurrentStatus.endMarketID??>
	            	 	<#if firstNextItemIcon=="false">
				        	<#assign firstNextItemIcon = "true" />
				        	<td class="next-step-action first"><a  onclick="return sendNotificationFormatEndMarketId('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_FOR_APPROVAL_REPORTS','${reportCurrentStatus.endMarketID?c}');" href="">${reportCurrentStatus.nextStep}</a></td>
				        <#else>
				        	<td class="next-step-action"><a  onclick="return sendNotificationFormatEndMarketId('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_FOR_APPROVAL_REPORTS','${reportCurrentStatus.endMarketID?c}');" href="">${reportCurrentStatus.nextStep}</a></td>
				        </#if>
	            	 <#else>
	            	 	
	            	 	<#if firstNextItemIcon=="false">
				        	<#assign firstNextItemIcon = "true" />
				        	<td class="next-step-action first"><a  onclick="return sendNotificationFormat('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_FOR_APPROVAL_REPORTS');" href="">${reportCurrentStatus.nextStep}</a></td>
				        <#else>
				        	<td class="next-step-action"><a  onclick="return sendNotificationFormat('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_FOR_APPROVAL_REPORTS');" href="">${reportCurrentStatus.nextStep}</a></td>
				        </#if>
	            	 </#if>
	            <#else>
	            	<td class="next-step-action">${reportCurrentStatus.nextStep}</td>
	            </#if>
	        <#elseif reportCurrentStatus.nextStep.contains("Notify BAT about Reports Revision")>
	            
	             <#if reportCurrentStatus.endMarketID??>
	            	 	
	            	 	<#if firstNextItemIcon=="false">
				        	<#assign firstNextItemIcon = "true" />
				        	<td class="next-step-action first"><a  onclick="return sendNotificationFormatEndMarketId('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_BAT_REPORTS_REVISION','${reportCurrentStatus.endMarketID?c}');" href="">${reportCurrentStatus.nextStep}</a></td>
				        <#else>
				        	<td class="next-step-action"><a  onclick="return sendNotificationFormatEndMarketId('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_BAT_REPORTS_REVISION','${reportCurrentStatus.endMarketID?c}');" href="">${reportCurrentStatus.nextStep}</a></td>
				        </#if>
	            	 <#else>
	            	 	
	            	 	<#if firstNextItemIcon=="false">
				        	<#assign firstNextItemIcon = "true" />
				        	<td class="next-step-action first"><a  onclick="return sendNotificationFormat('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_BAT_REPORTS_REVISION');" href="">${reportCurrentStatus.nextStep}</a></td>
				        <#else>
				        	<td class="next-step-action"><a  onclick="return sendNotificationFormat('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','NOTIFY_BAT_REPORTS_REVISION');" href="">${reportCurrentStatus.nextStep}</a></td>
				        </#if>
	            	 </#if>
	        <#elseif reportCurrentStatus.nextStep.contains("Approve Reports")>
	            
	            <#if reportCurrentStatus.nextStepEnable?? && reportCurrentStatus.nextStepEnable  >
	            	 
	            	  <#if reportCurrentStatus.endMarketID??>
	            	 	
	            	 	<#if firstNextItemIcon=="false">
				        	<#assign firstNextItemIcon = "true" />
				        	<td class="next-step-action first"><a  onclick="return approveReportsEndMarketId('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE_REPORTS','${reportCurrentStatus.endMarketID?c}');" href="">${reportCurrentStatus.nextStep}</a></td>
				        <#else>
				        	<td class="next-step-action"><a  onclick="return approveReportsEndMarketId('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE_REPORTS','${reportCurrentStatus.endMarketID?c}');" href="">${reportCurrentStatus.nextStep}</a></td>
				        </#if>
	            	 <#else>
	            	 	
	            	 	<#if firstNextItemIcon=="false">
				        	<#assign firstNextItemIcon = "true" />
				        	<td class="next-step-action first"><a  onclick="return approveReports('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE_REPORTS');" href="">${reportCurrentStatus.nextStep}</a></td>
				        <#else>
				        	<td class="next-step-action"><a  onclick="return approveReports('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','APPROVE_REPORTS');" href="">${reportCurrentStatus.nextStep}</a></td>
				        </#if>
	            	 </#if>
	            <#else>
	            	<td class="next-step-action">${reportCurrentStatus.nextStep}</td>
	            </#if>
	
	        <#elseif reportCurrentStatus.nextStep=="Request for Upload to IRIS">
	           
				<#if reportCurrentStatus.nextStepEnable?? && reportCurrentStatus.nextStepEnable  >
	            	 
	            	 <#if reportCurrentStatus.endMarketID??>
	            	 	
	            	 	<#if firstNextItemIcon=="false">
				        	<#assign firstNextItemIcon = "true" />
				        	<td class="next-step-action first"><a  onclick="return sendNotificationFormatEndMarketId('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','UPLOAD_TO_IRIS_REPORTS','${reportCurrentStatus.endMarketID?c}');" href="">${reportCurrentStatus.nextStep}</a></td>
				        <#else>
				        	<td class="next-step-action"><a  onclick="return sendNotificationFormatEndMarketId('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','UPLOAD_TO_IRIS_REPORTS','${reportCurrentStatus.endMarketID?c}');" href="">${reportCurrentStatus.nextStep}</a></td>
				        </#if>
	            	 <#else>
	            	 	
	            	 	<#if firstNextItemIcon=="false">
				        	<#assign firstNextItemIcon = "true" />
				        	<td class="next-step-action first"><a  onclick="return sendNotificationFormat('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','UPLOAD_TO_IRIS_REPORTS');" href="">${reportCurrentStatus.nextStep}</a></td>
				        <#else>
				        	<td class="next-step-action"><a  onclick="return sendNotificationFormat('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','UPLOAD_TO_IRIS_REPORTS');" href="">${reportCurrentStatus.nextStep}</a></td>
				        </#if>
	            	 </#if>
	            <#else>
	            	<td class="next-step-action">${reportCurrentStatus.nextStep}</td>
	            </#if>
	        <#elseif reportCurrentStatus.nextStep=="Request for Upload to C-PSI Database">
	            
	            <#if reportCurrentStatus.nextStepEnable?? && reportCurrentStatus.nextStepEnable  >
	            	
	            	<#if reportCurrentStatus.endMarketID??>
	            	 	
	            	 	<#if firstNextItemIcon=="false">
				        	<#assign firstNextItemIcon = "true" />
				        	<td class="next-step-action first"><a  onclick="return sendNotificationFormatEndMarketId('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','UPLOAD_TO_C_PSI_DATABASE_REPORTS','${reportCurrentStatus.endMarketID?c}');" href="">${reportCurrentStatus.nextStep}</a></td>
				        <#else>
				        	<td class="next-step-action"><a  onclick="return sendNotificationFormatEndMarketId('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','UPLOAD_TO_C_PSI_DATABASE_REPORTS','${reportCurrentStatus.endMarketID?c}');" href="">${reportCurrentStatus.nextStep}</a></td>
				        </#if>
	            	 <#else>
	            	 	
	            	 	<#if firstNextItemIcon=="false">
				        	<#assign firstNextItemIcon = "true" />
				        	<td class="next-step-action first"><a  onclick="return sendNotificationFormat('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','UPLOAD_TO_C_PSI_DATABASE_REPORTS');" href="">${reportCurrentStatus.nextStep}</a></td>
				        <#else>
				        	<td class="next-step-action"><a  onclick="return sendNotificationFormat('${reportCurrentStatus.nextStepPersonEmail}','${reportCurrentStatus.nextStepSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${reportCurrentStatus.nextStepMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','UPLOAD_TO_C_PSI_DATABASE_REPORTS');" href="">${reportCurrentStatus.nextStep}</a></td>
				        </#if>
	            	 </#if>
	            <#else>
	            	<td class="next-step-action">${reportCurrentStatus.nextStep}</td>
	            </#if>
	
	        <#else>
	            <td class="next-step-action">${reportCurrentStatus.nextStep}</td>
	        </#if>
	
	    </#if>
	 <#else>
	 	<td class="next-step-action">${reportCurrentStatus.nextStep}</td>
	 </#if>
</tr>
</#list>


<#if projectEvalCurrentStatusList?? && projectEvalCurrentStatusList.size() gt 0>
<tr>
    <td <#if stageNumber?? && stageNumber==statics['com.grail.synchro.beans.ProjectStage$StageType'].PROJECT_EVALUATION.getStageNumber() >class="table-data-header active" <#else> class="table-data-header first"</#if>><a href="${projectEvaluationStageUrl}" >PROJECT EVALUATION </a></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
    <td class="table-data-header"></td>
</tr>
</#if>
<#list projectEvalCurrentStatusList as projectEvalCurrentStatus>
<#--<tr <#if projectEvalCurrentStatus_index = (projectEvalCurrentStatusList?size-1)>class="last-row"</#if>>-->
<#if projectEvalCurrentStatus.status=="Complete" >
	<tr class="status-complete">
<#else>
	<tr class="status-pending">
</#if>
    <td class="activity-name first">${projectEvalCurrentStatus.activityDesc}</td>
    <td class="check-box"><input type="checkbox" name="status" disabled  id=""  <#if projectEvalCurrentStatus.status=="Complete">checked="true" </#if> /><label></label> </td>
    
    <#if projectEvalCurrentStatus.completionDate??>
		<td>${projectEvalCurrentStatus.completionDate?string('dd/MM/yyyy')}</td>
	<#else>
		<td></td>
	</#if>
	
    <#if projectEvalCurrentStatus.status=="Complete">
    	<td>${projectEvalCurrentStatus.personResponsible}</td>
    <#else>
    	<td><a  onclick="return sendNotificationFormat('${projectEvalCurrentStatus.personRespEmail}','${projectEvalCurrentStatus.personRespSubject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${projectEvalCurrentStatus.personRespMessage.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PENDING_ACTION_PERSON_RESPONSIBLE');" href="">${projectEvalCurrentStatus.personResponsible}</a></td>
    </#if>
    
    <#if user.email==projectEvalCurrentStatus.personRespEmail || isAdminUser>
    	
    	<#if firstNextItemIcon=="false">
        	<#assign firstNextItemIcon = "true" />
        	<td class="next-step-action first"><a href="${projectEvalCurrentStatus.nextStepLink}" >${projectEvalCurrentStatus.nextStep}</a></td>
        <#else>
        	<td class="next-step-action"><a href="${projectEvalCurrentStatus.nextStepLink}" >${projectEvalCurrentStatus.nextStep}</a></td>
        </#if>
    <#else>
    	<td class="next-step-action">${projectEvalCurrentStatus.nextStep}</td>
    </#if>
</tr>
</#list>
</tbody>
</table>
</div>

</div>
</div>


<!-- EMAIL NOTIFICATION WINDOW -->
<div id="emailNotification" style="display:none">
    <form id="email-notification-form" action="<@s.url value="/synchro/current-status-multi!sendNotification.jspa"/>" method="post" enctype="multipart/form-data" class="j-form-popup">
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
        <input type="hidden" id="projectID" name="projectID" value="" />
        <input type="hidden" name="endMarketId" value="${endMarketId?c}">
        <input type="hidden" id="notificationTabId" name="notificationTabId" value="" />
        <input type="hidden" id="emailEndMarketId" name="emailEndMarketId" value="" />
        <input class="j-btn-callout" type="button" name="doPost" id="postButton" onclick="return notificationVal();" value="Submit" style="font-weight: bold;" />

    </form>
</div>

<!-- EMAIL NOTIFICATION WINDOW ENDS -->

<!-- AWARD AGENCY FORM STARTS -->
<form name="awardAgency-form" id="awardAgency-form" action="<@s.url value='/synchro/proposal-multi-details!awardAgency.jspa'/>" method="post" >
    <input type="hidden" name="projectID" value="${projectID?c}">
   
   <#-- <input type="hidden" name="endMarketId" value="${proposalEndMarketId?c}"> -->
   <input type="hidden" name="currentStatus" value="currentStatus">
    <#if proposalInitiation?? && proposalInitiation.agencyID??>
    	<input type="hidden" name="agencyID" value="${proposalInitiation.agencyID?c}">
    <#else>
    	<input type="hidden" name="agencyID" value="">
    </#if>
</form>
<!-- AWARD AGENCY FORM ENDS -->

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

            <#elseif (isMethAppUser) && !(isProjectOwner || isProjectCreator) >
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
            <#elseif (isMethAppUser ) && !(isProjectOwner || isProjectCreator) >
                <@renderMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibMethodologyWaiver.methodologyApprover?default(-1)?c}" readonly=true/>
            <#else>
                <@renderMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibMethodologyWaiver.methodologyApprover?default(-1)?c}"/>
            </#if>

                <!-- Current User is either Project Owner or SPI User-->
            <#if isAdminUser>
                <input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" onclick="javascript:sendForApprovalWaiver();" />
                <input  id="send-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="SEND FOR INFORMATION" style="font-weight: bold;" onclick="javascript:sendForInformationWaiver();" />

            <#elseif isProjectOwner || isProjectCreator>
                <#if  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                    <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
                    <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton"  value="SEND FOR INFORMATION" style="font-weight: bold;cursor:default;" />
                <#else>
                    <input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" onclick="javascript:sendForApprovalWaiver();" />
                    <input  id="send-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="SEND FOR INFORMATION" style="font-weight: bold;" onclick="javascript:sendForInformationWaiver();" />

                </#if>

            <#elseif isMethAppUser || isProcUser>
                <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
                <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton"  value="SEND FOR INFORMATION" style="font-weight: bold;cursor:default;" />
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
                <#--<div class="character-limit" >You have <input readonly type="text" id="methodologyApproverCommentcountdown" name="countdown" size="3" value="2500" style="margin-top:7px;"> characters left</div>-->
                </#if>

                <!-- Current User is NOT Methodology Approver User -->
            <#else>
                <textarea id="methodologyApproverComment"  disabled name="methodologyApproverComment">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
            </#if>
            </div>

            <!-- Current User is Methodology User and is also Project Methodology Approver -->
        <#if isAdminUser>
            <input id="request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" onclick="javascript:requestForInformationWaiver();" />
            <input id="approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" onclick="javascript:approveWaiver();" />
            <input id="reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" onclick="javascript:rejectWaiver();" />

        <#elseif isMethAppUser && pibMethodologyWaiver.methodologyApprover?? && user.ID==pibMethodologyWaiver.methodologyApprover>

            <#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                <input type="button" class="g-btn r-more" name="doPost" id="postButton"  value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
            <#else>
                <input id="request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" onclick="javascript:requestForInformationWaiver();" />
            </#if>
            <#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton"  value="Approve" style="font-weight: bold;cursor:default;" />
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />
            <#elseif pibMethodologyWaiver.status?? && pibMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_APP_PENDING.ordinal()>
                <input id="approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" onclick="javascript:approveWaiver();" />
                <input id="reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" onclick="javascript:rejectWaiver();" />
            <#elseif pibMethodologyWaiver.status?? && pibMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_MORE_INFO_REQ.ordinal()>
                <input id="approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" onclick="javascript:approveWaiver();" />
                <input id="reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" onclick="javascript:rejectWaiver();" />
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
        <#--  <input type="hidden" name="endMarketId" value="${endMarketId?c}"> -->
        <input type="hidden" name="pageRequest" value="PendingActions">
            <input type="hidden" id="methodologyWaiverAction" name="methodologyWaiverAction" value="">
        </form>
    </div>
</div>
<!-- INITIATE WAIVER WINDOW ENDS -->

<!-- INITIATE KANTAR WAIVER WINDOW STARTS -->
<div id="initiateKantarWaiver" style="display:none">
    <script type="text/javascript">
        $j(document).ready(function(){
            if($j("#initiateKantarWaiver").parent().hasClass('light-box'))
            {
                $j("#initiateKantarWaiver").parent().prepend($j("#success-msg-waiver-kantar"));
            }
        });
    </script>
    <div class="popup-waiver">

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

            <#elseif (isKantarMethAppUser ) && !(isProjectOwner || isProjectCreator) >
                <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            <#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            <#else>
                <textarea id="methodologyDeviationRationaleKantar" name="methodologyDeviationRationale" placeholder="Methodology Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            </#if>
            </div>
            <div class="pib_view_popup">
                <label class="synchro-help-waiver-label" title="Consumer Based Research- Taina Vauhkonen
Trade Measurement Research (including Retail Measurement Service)- Tim Carey">Approver<span style="margin: -16px 1px 2px 70px;"  title="Consumer Based Research- Taina Vauhkonen
Trade Measurement Research (including Retail Measurement Service)- Tim Carey">help</span></label>

            <#if isAdminUser>
                <@renderKantarMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibKantarMethodologyWaiver.methodologyApprover?default(-1)?c}"/>
            <#elseif (isKantarMethAppUser ) && !(isProjectOwner || isProjectCreator) >
                <@renderKantarMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibKantarMethodologyWaiver.methodologyApprover?default(-1)?c}" readonly=true/>
            <#else>
                <@renderKantarMethodologyApproverField name='methodologyApprover' id='methodologyApprover'  value="${pibKantarMethodologyWaiver.methodologyApprover?default(-1)?c}"/>
            </#if>

                <!-- Current User is either Project Owner or SPI User-->
            <#if isAdminUser>
                <input id="kantar-send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" onclick="javascript:sendForApprovalKantarWaiver();" />
                <input  id="kantar-send-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="SEND FOR INFORMATION" style="font-weight: bold;" onclick="javascript:sendForInformationKantarWaiver();" />

            <#elseif isProjectOwner || isProjectCreator>
                <#if  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                    <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
                    <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton"  value="SEND FOR INFORMATION" style="font-weight: bold;cursor:default;" />
                <#else>
                    <input id="kantar-send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" onclick="javascript:sendForApprovalKantarWaiver();" />
                    <input  id="kantar-send-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="SEND FOR INFORMATION" style="font-weight: bold;" onclick="javascript:sendForInformationKantarWaiver();" />

                </#if>

            <#elseif isKantarMethAppUser >
                <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
                <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton"  value="SEND FOR INFORMATION" style="font-weight: bold;cursor:default;" />
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
                <#--<div class="character-limit" >You have <input readonly type="text" id="methodologyApproverCommentcountdown" name="countdown" size="3" value="2500" style="margin-top:7px;"> characters left</div>-->
                </#if>

                <!-- Current User is NOT Methodology Approver User -->
            <#else>
                <textarea id="methodologyApproverCommentKantar"  disabled name="methodologyApproverComment">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
            </#if>
            </div>

            <!-- Current User is Methodology User and is also Project Methodology Approver -->
        <#if isAdminUser>
            <input id="kantar-request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" onclick="javascript:requestForInformationKantarWaiver();" />
            <input id="kantar-approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" onclick="javascript:approveKantarWaiver();" />
            <input id="kantar-reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" onclick="javascript:rejectKantarWaiver();" />

        <#elseif isKantarMethAppUser && pibKantarMethodologyWaiver.methodologyApprover?? && user.ID==pibKantarMethodologyWaiver.methodologyApprover>

            <#if pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                <input type="button" class="g-btn r-more" name="doPost" id="postButton"  value="REQUEST MORE INFORMATION" style="font-weight: bold;cursor:default;" />
            <#else>
                <input id="kantar-request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" onclick="javascript:requestForInformationKantarWaiver();" />
            </#if>
            <#if pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton"  value="Approve" style="font-weight: bold;cursor:default;" />
                <input type="button" class="g-btn g-btn-medium" name="doPost" id="postButton" value="Reject" style="font-weight: bold;cursor:default;" />
            <#elseif pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_APP_PENDING.ordinal()>
                <input id="kantar-approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" onclick="javascript:approveKantarWaiver();" />
                <input id="kantar-reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" onclick="javascript:rejectKantarWaiver();" />
            <#elseif pibKantarMethodologyWaiver.status?? && pibKantarMethodologyWaiver.status == statics['com.grail.synchro.SynchroGlobal$MethodologyWaiverStatus'].PIB_METH_WAIV_MORE_INFO_REQ.ordinal()>
                <input id="kantar-approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" onclick="javascript:approveKantarWaiver();" />
                <input id="kantar-reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" onclick="javascript:rejectKantarWaiver();" />
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
        <#-- <input type="hidden" name="endMarketId" value="${endMarketId?c}"> -->
        	
        	<input type="hidden" name="pageRequest" value="PendingActions">
            <input type="hidden" id="kantarMethodologyWaiverAction" name="kantarMethodologyWaiverAction" value="">
        </form>
    </div>
</div>
<!-- INITIATE KANTAR WAIVER WINDOW ENDS -->

<!-- PIB FIELDS WINDOW STARTS -->
<div id="pibFieldsWindow" class="current-status-popup" style="display:none">
     
	     <#list pibPendingFieldsListMap.entrySet() as pibPendingFieldsMap>  
	        
	       <div id="pibPendingFields${pibPendingFieldsMap.key}" class="pibFieldsWindowClass" style="display:none" >
			   <table>
		        <thead>
		        <tr>
		            <th></th>
		            <th>Information Provided</th>
		            <th>Attachment Done</th>
		        </tr>
		        </thead>
		        <tbody>
		        <#list pibPendingFieldsMap.value as pibPendingField>
		        <tr>
		            <td class="first">${pibPendingField.fieldName}</td>
		            <#if pibPendingField.displayInformation?? && pibPendingField.displayInformation!="">
		            	<td>${pibPendingField.displayInformation}</td>
		            <#else>
		            	<td class="check-box"><input type="checkbox" name="status" disabled <#if pibPendingField.informationProvided>checked="true" </#if> id=""  /></td>
		            </#if>
		            <#if pibPendingField.attachmentDone?? && pibPendingField.attachmentDone=="N/A" >
		                <td>${pibPendingField.attachmentDone}</td>
		            <#elseif pibPendingField.attachmentDone?? && pibPendingField.attachmentDone=="Yes">
		                <td class="check-box"><input type="checkbox" disabled name="status" checked="true"   id=""  /></td>
		            <#else>
		                <td class="check-box"><input type="checkbox" disabled name="status" id=""  /></td>
		            </#if>
		
		        </tr>
		        </#list>
		        
		         </tbody>

   			 </table>
		     </div>
	       </#list>
	    
       
</div>
<!-- PIB FIELDS WINDOW ENDS -->

<!-- PROPOSAL FIELDS WINDOW STARTS -->
<div id="proposalFieldsWindow" class="current-status-popup" style="display:none">

    <table>
        <thead>
        <tr>
            <th></th>
            <th>Information Provided</th>
            <th>Attachment Done</th>
        </tr>
        </thead>
        <tbody>
    <#list proposalPendingFieldsList as proposalPendingField>
        <#if proposalPendingField.endMarketId?? >
	        <tr>
	        <td class="first"><b>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(proposalPendingField.endMarketId?int)}</b></td>
	        <td></td>
	        <td></td>
	        </tr>
	    </#if>
        <tr>
            <td class="first">${proposalPendingField.fieldName}</td>
            <td class="check-box"><input type="checkbox" name="status" disabled <#if proposalPendingField.informationProvided>checked="true" </#if> id=""  /></td>
            <#if proposalPendingField.attachmentDone?? && proposalPendingField.attachmentDone=="N/A" >
                <td>${proposalPendingField.attachmentDone}</td>
            <#elseif proposalPendingField.attachmentDone?? && proposalPendingField.attachmentDone=="Yes">
                <td class="check-box"><input type="checkbox" disabled name="status" checked="true"   id=""  /></td>
            <#else>
                <td class="check-box"><input type="checkbox" disabled name="status" id=""  /></td>
            </#if>

        </tr>
    </#list>
        </tbody>

    </table>
</div>
<!-- PROPOSAL FIELDS WINDOW ENDS -->

<!-- PROJECT SPECS FIELDS WINDOW STARTS -->

<div id="projectSpecsFieldsWindow" class="current-status-popup" style="display:none">
     
	     <#list psPendingFieldsListMap.entrySet() as psPendingFieldsMap>  
	        
	       <div id="psPendingFields${psPendingFieldsMap.key}" class="projectSpecsFieldsWindowClass" style="display:none" >
			   <table>
		        <thead>
		        <tr>
		            <th></th>
		            <th>Information Provided</th>
		            <th>Attachment Done</th>
		        </tr>
		        </thead>
		        <tbody>
		        <#list psPendingFieldsMap.value as psPendingField>
		        <tr>
		            <td class="first">${psPendingField.fieldName}</td>
		            <td class="check-box"><input type="checkbox" name="status" disabled <#if psPendingField.informationProvided>checked="true" </#if> id=""  /></td>
		            <#if psPendingField.attachmentDone?? && psPendingField.attachmentDone=="N/A" >
		                <td>${psPendingField.attachmentDone}</td>
		            <#elseif psPendingField.attachmentDone?? && psPendingField.attachmentDone=="Yes">
		                <td class="check-box"><input type="checkbox" disabled name="status" checked="true"   id=""  /></td>
		            <#else>
		                <td class="check-box"><input type="checkbox" disabled name="status" id=""  /></td>
		            </#if>
		
		        </tr>
		        </#list>
		        
		         </tbody>

   			 </table>
		     </div>
	       </#list>
	    
       
</div>

<!-- PROJECT SPECS FIELDS WINDOW ENDS -->

<!-- REPORT SUMMARY FIELDS WINDOW STARTS -->

<div id="reportSummaryFieldsWindow" class="current-status-popup" style="display:none">
     
	     <#list rsPendingFieldsListMap.entrySet() as rsPendingFieldsMap>  
	        
	       <div id="rsPendingFields${rsPendingFieldsMap.key}" class="reportSummaryFieldsWindowClass" style="display:none" >
			   <table>
		        <thead>
		        <tr>
		            <th></th>
		            <th>Information Provided</th>
		            <th>Attachment Done</th>
		        </tr>
		        </thead>
		        <tbody>
		        <#list rsPendingFieldsMap.value as rsPendingField>
		        <tr>
		            <td class="first">${rsPendingField.fieldName}</td>
		            <td class="check-box"><input type="checkbox" name="status" disabled <#if rsPendingField.informationProvided>checked="true" </#if> id=""  /></td>
		            <#if rsPendingField.attachmentDone?? && rsPendingField.attachmentDone=="N/A" >
		                <td>${rsPendingField.attachmentDone}</td>
		            <#elseif rsPendingField.attachmentDone?? && rsPendingField.attachmentDone=="Yes">
		                <td class="check-box"><input type="checkbox" name="status" disabled checked="true"   id=""  /></td>
		            <#else>
		                <td class="check-box"><input type="checkbox" name="status" disabled id=""  /></td>
		            </#if>
		
		        </tr>
		        </#list>
		        
		         </tbody>

   			 </table>
		     </div>
	       </#list>
	    
       
</div>

<!-- REPORT SUMMARY FIELDS WINDOW ENDS -->


<div id="pitWindow" style="display:none">
<script src="${themePath}/js/synchro/project-form.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<!-- PIT WINDOW STARTS -->
<script type="text/javascript">

    function openPITWindow() {
   

        $j("#pitWindow").lightbox_me({centered:true,closeEsc:false,closeClick:false,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7},
            onLoad:function() {
                showInvestments();
            }
        });
    <#if project.brand??>
        $j("#brand").val("${project.brand}");
    </#if>
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
	        if (initialCost && !numericFormat(initialCost, true)) {
	           
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
            $j("#synchro-pit-form select[name=categoryType] option").attr('selected','selected');
            $j(categoryType).parent().find("span").hide();
        }
		 
	<#--
        var proposedMethodology = $j("#synchro-pit-form select[name=proposedMethodology]");
        var pmOptions = $j(proposedMethodology).find('option');
        if(pmOptions.length <= 0) {
            $j(proposedMethodology).parent().parent().find("span").show();
            error = true;
        } else {
            $j("#synchro-pit-form select[name=proposedMethodology] option").attr('selected','selected');
            $j(proposedMethodology).parent().find("span").hide();
        }-->
    
        if(error)
            hideLoader();

        return !error;
    }

   

    var investmentPopup = null;
    $j("#pitWindow").ready(function(){
        $j("#add-investment-popup #pageType").val('pib');
        investmentPopup = new LIGHT_BOX($j("#add-investment-popup"),{title:'Add Investment',
            onClose:function(){
                $j("#pitWindow").show();
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
            <#if user.ID==fundingInvestment.spiContact>
                
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
        var size = $j('select#endMarkets_pitPopup option').length;
        if(size > 0) {
            $j(".project_addfunding_btn").removeAttr("disabled", "disabled");
        } else {
            $j(".project_addfunding_btn").attr( "disabled", "disabled" );
        }
    }
</script>

<div class="view_edit_pib">
    <form id="synchro-pit-form" action="<@s.url value="/synchro/current-status-multi!updatePIT.jspa"/>" method="post" class="j-form-popup">
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
					<#--		<@renderSelectedProposedMethodologyMultiSelect name='proposedMethodology' methodologyGroup=project.methodologyGroup?default('-1') id="pit" value=project.proposedMethodology?default([defaultPMethodologyID])/> --> 
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
                    <#if project.projectOwner &gt; 0>

					    <#assign ownerUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner) />
					
					<#else>
					    <#assign ownerUserName="" />
					</#if>
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
                    <input type="text" id="totalCost" name="totalCost" value="${project.totalCost?c}" size="30" class="form-text-div numericfieldpib numericformat longField">
                    <@renderCurrenciesField name='totalCostCurrency' value=project.totalCostCurrency?default(defaultCurrency) disabled=false/>
                    <br/><br/>
                    <@macroCustomFieldErrors msg='' class='numeric-error' />
                <#elseif isAboveMarketProjectContactUser || isProjectOwner || isProjectCreator>
                	<label>Total Cost</label>
	                <#if projectInitiation?? && projectInitiation.status?? && projectInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PIB_COMPLETED.ordinal() >
	                    <input type="text" name="totalCost" value="${project.totalCost?c}" size="30" disabled class="form-text-div">
	                    <@renderCurrenciesField name='totalCostType' value=project.totalCostCurrency?default(defaultCurrency) disabled=true/>
	                <#elseif !(isAboveMarketProjectContactUser || isProjectOwner ) >
	                    <input type="text" name="totalCost" value="${project.totalCost?c}" size="30" disabled class="form-text-div">
	                    <@renderCurrenciesField name='totalCostType' value=project.totalCostCurrency?default(defaultCurrency) disabled=true/>
	                <#else>
	                    <input type="text" id="totalCost" name="totalCost" value="${project.totalCost?default(0)?c}" size="30" class="form-text-div numericfieldpib numericformat longField">
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
        <#elseif projectInitiation?? && projectInitiation.status?? && projectInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PIB_COMPLETED.ordinal() && !isBudgetApprover>
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
    
     <textarea id="description" style="display:none;" name="description" rows="10" cols="20" class="form-text-div">${project.description?default('')?html}</textarea>
     
     <div id="endMarketsHiddenDiv" style="display:none;">
     	<@renderMultiEndMarketField name='updatedSingleMarketId1' value=emIds?default('-1')/>
     </div>
        <input type="hidden" name="projectID" value="${projectID?c}">
        <input type="hidden" name="endMarketId" value="${endMarketId?c}">

    </form>
</div>
</div>
<!-- PIT WINDOW ENDS -->

<script type="text/javascript">
	$j("#descriptionpit-div").html($j("#description").text());
	
	<!-- Audit Logs -->
if(location.search && location.search.split('prevStage='))
{
	var stageID = 0;
	var prevStageID = location.search.split('prevStage=')[1];	
	if(prevStageID==1)
	{
		stageID = ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PIB.getId()};
	}
	else if(prevStageID==2)
	{
		stageID = ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROPOSAL.getId()};
	}
	else if(prevStageID==3)
	{
		stageID = ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_SPECS.getId()};
	}
	else if(prevStageID==4)
	{
		stageID = ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].REPORT_SUMMARY.getId()};
	}
	else if(prevStageID==5)
	{
		stageID = ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_EVALUATION.getId()};
	}
	
	if(stageID>0)
	{
		<#assign i18CustomText><@s.text name="logger.project.current.status.view.text" /></#assign>	
		var projName = "${project.name?js_string}";
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, stageID, "${i18CustomText}", projName, ${projectID?c}, ${user.ID?c});
	}
	else
	{
		<#assign i18CustomText><@s.text name="logger.visibility.inside.project" /></#assign>
		var projName = "${project.name?js_string}";
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, stageID, "${i18CustomText}", projName, ${projectID?c}, ${user.ID?c});
	}

}

</script>
