<#include "/template/global/include/synchro-macros.ftl" />
<div class="right-side-bar">
<script type="text/javascript">

    function openMyLibraryDialog() {
	
		<#assign i18MyLibText><@s.text name="logger.project.mylibrary.view.text" /></#assign>
		<#if stageId==1><#assign logProjectStage=statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PIB.getId() />
		<#elseif stageId==2><#assign logProjectStage=statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROPOSAL.getId() />
		<#elseif stageId==3><#assign logProjectStage=statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_SPECS.getId() />
		<#elseif stageId==4><#assign logProjectStage=statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].REPORT_SUMMARY.getId() />
		<#elseif stageId==5><#assign logProjectStage=statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_EVALUATION.getId() />
		</#if>		
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${logProjectStage}, "${i18MyLibText}", "${project.name}", ${projectID?c}, ${user.ID?c});
	
	
        var div = $j('<div id="my-library-popup" class="j-form-popup"></div>');
        $j(div).css('width','1024px');
        $j(div).css('background-color','transparent');
        $j(div).css('border','0px');

        var overlay = $j('<div></div>');
        $j(overlay).css('position','absolute');
        $j(overlay).css('top','0px');
        $j(overlay).css('left','500px');
        var img = $j('<img/>');

        $j(img).attr('src',"${themePath}/images/bigrotation.gif");
        $j(img).css('width','30px');
        $j(img).css('height','30px');
        $j(img).appendTo($j(overlay));
        $j(overlay).appendTo($j(div));


        var closeBtn =  $j('<a class="close" href="javascript:void(0)"></a>');
        $j(closeBtn).css('display','none');
        $j(closeBtn).appendTo($j(div));

        var subdiv = $j('<div></div>');
        $j(subdiv).css('margin-left','-9px');
        $j(subdiv).css('margin-top','7px');

        $j(div).lightbox_me({centered:true,closeEsc:false,overlayCSS:{background: 'black', opacity: .7},destroyOnClose:true,onLoad:function(){
            $j(subdiv).load("<@s.url value='/synchro/my-library.jspa'/> .maindiv,#j-footer",{isPopup:true},function(){

                $j(overlay).hide();
                $j(div).css('background-color','');
                $j(div).css('border','');
                $j(subdiv).find('#j-main').css('margin-bottom','-30px');
                $j(subdiv).find('.footer_main ').css('width','95.4%');
                $j(subdiv).find('#j-footer').css('margin-bottom','-10px');
                $j(subdiv).find('#j-footer').css('margin-top','15px');
                $j(subdiv).find('.project_dashboard_header').css('padding-left','1px');
                $j(subdiv).find('.project_dashboard_header').css('margin-top','-5px');
                $j(subdiv).find('.site_search').css('margin-top', '-8px');
                $j(subdiv).find('.site_search').css('margin-bottom', '-9px');
                $j(subdiv).find('.site_search input[type=button]').css('margin-top', '11px');

                $j(closeBtn).show();

                var script1 = document.createElement("script");
                $j(script1).attr("type", "text/javascript");
                $j(script1).attr("src", "${themePath}/js/synchro/my-library-scripts.js");
                $j(script1).prependTo($j(subdiv));

                var script2 = document.createElement("script");
                $j(script2).attr("type", "text/javascript");
                $j(script2).attr("src", "${themePath}/js/jquery.paginate.js");
                $j(script2).prependTo($j(subdiv));

                $j(subdiv).appendTo($j(div));

                $j(subdiv).ready(function(){
                    initializeAjaxForm();
                });

                $j(div).trigger('resize');

                isPopup = true;
                attachSearchBoxListeners();
                showFirstPage();
            });
        }});
    }



</script>
<#if stageId==1>
<ul class="right-sidebar-list" id="synchro-action-box">	
    <#assign isBudgetApprover = statics['com.grail.synchro.util.SynchroPermHelper'].isBudgetApprover(project.projectID) />
    
    <#if isAdminUser >
    	<li><a  href="javascript:void(0);" onclick="javascript:openPITWindow()">View/Edit PIT</a></li>
    <#elseif isProjectOwner || isSPIContactUser || user.ID==project.briefCreator || isBudgetApprover>
    	<#if isProposalAwarded?? && isProposalAwarded>
    		<li><a  href="javascript:void(0);" onclick="javascript:openPITWindow()">View PIT</a></li>
        <#else>
        	<li><a  href="javascript:void(0);" onclick="javascript:openPITWindow()">View/Edit PIT</a></li>
        </#if>
    </#if>

    <#if isCommunicationAgencyAdminUser>
    <#elseif isAdminUser >
        <li><a  href="javascript:void(0);" id="fileAttachBtn">Attach Files</a></li>
    <#elseif (isExternalAgencyUser || isCommAgencyUser || isLegalUser || isProcUser)  >
        <li class="disableToDoTab">Attach Files</li>
    <#elseif !canEditProject>
        <li class="disableToDoTab">Attach Files</li>
    <#else>
        <li><a  href="javascript:void(0);" id="fileAttachBtn">Attach Files</a></li>
    </#if>
    <li><a  href="javascript:void(0);" onclick="openMyLibraryDialog()">My Library</a></li>


    <#if isCommunicationAgencyAdminUser>
    <#elseif isAdminUser >
       <li><a id="import-pib-link" href="javascript:void(0);">Import from Word</a></li>
    <#elseif (isExternalAgencyUser || isCommAgencyUser || isLegalUser || isProcUser)  >
        <li class="disableToDoTab">Import from Word</li>
    <#elseif !canEditProject>
        <li class="disableToDoTab">Import from Word</li>
    <#else>
        <li><a id="import-pib-link" href="javascript:void(0);">Import from Word</a></li>		
    </#if>

    <li><a  href="javascript:void(0);"  onclick="javascript:exportPIBWord(${projectID?c});" >Export To Word</a></li>
    <li><a id="export-pdf-link" href="javascript:void(0);"  onclick="javascript:exportPDF(${projectID?c},'PIB','');">Export To PDF</a></li>

</ul>
<#elseif stageId==2 >
<ul class="right-sidebar-list" id="synchro-action-box">   
	<#assign isCommunicationAgencyAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroCommunicationAgencyAdmin() />
    
    <#if isCommunicationAgencyAdminUser>
    <#elseif isAdminUser >
        <li><a  href="javascript:void(0);" id="fileAttachBtn">Attach Files</a></li>
    <#elseif !isExternalAgencyUser || (proposalInitiation.isAwarded?? && proposalInitiation.isAwarded) || (proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted)>
        <li class="disableToDoTab">Attach Files</li>
    <#elseif !canEditProject>
        <li class="disableToDoTab">Attach Files</li>
    <#else>
        <li><a  href="javascript:void(0);" id="fileAttachBtn">Attach Files</a></li>
    </#if>
    <li><a  href="javascript:void(0);" onclick="openMyLibraryDialog()">My Library</a></li>
    <!-- Commented by Bhaskar -->
    <li><a  href="javascript:void(0);" id="export-pdf-link" onclick="javascript:exportPDF(${projectID?c},'Proposal',${agencyID?c});">Export To PDF</a></li>
</ul>
<#elseif stageId==3>
   
    
    
    <#if project.multiMarket?? && project.multiMarket  >
    <ul class="right-sidebar-list" id="synchro-action-box">		
        <#if isCommunicationAgencyAdminUser>
        <#elseif projectSpecsInitiation.status ?? && projectSpecsInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROJECT_SPECS_COMPLETED.ordinal() >
            
            <#if isAdminUser>
            	<li><a  href="javascript:void(0);" id="fileAttachBtn">Attach Files</a></li>
            <#else>
            	<li class="disableToDoTab">Attach Files</li>
            </#if>
            
            <#if isAboveMarket && isAdminUser> 
                 <li><a  href="javascript:void(0);" onclick="openFieldWorkWindow()">Change Fieldwork /<br/>Cost Status</a></li>
            
            <#elseif isAboveMarket || isCountryProjectContact || isCountrySPIContact> 
                <li class="disableToDoTab">Change Fieldwork /<br/>Cost Status</li>
            </#if>
            
      
        <#elseif !canEditProject>
            <li class="disableToDoTab">Attach Files</li>
           
           <#if isAboveMarket || isCountryProjectContact || isCountrySPIContact> 
                <li class="disableToDoTab">Change Fieldwork /<br/>Cost Status</li>
           </#if> 
        <#else>
            <li><a  href="javascript:void(0);" id="fileAttachBtn">Attach Files</a></li>
             
            <#-- <#if isAboveMarket && (isAboveMarketProjectContactUser || isAdminUser || isGlobalSuperUser || isEndMarketSuperUser)>-->
             <#if isAboveMarket && (isAboveMarketProjectContactUser || isAdminUser || isGlobalSuperUser || isEndMarketSuperUser || isProjectOwner)> 
                <li><a  href="javascript:void(0);" onclick="openFieldWorkWindow()">Change Fieldwork /<br/>Cost Status</a></li>
             <#elseif isCountryProjectContact || isCountrySPIContact >
             	<li><a  href="javascript:void(0);" onclick="openFieldWorkWindow()">Change Fieldwork /<br/>Cost Status</a></li>
            </#if>
            
             
            <#--
            <#if isAboveMarket || isCountryProjectContact || isCountrySPIContact || isGlobalSuperUser || isEndMarketSuperUser> 
                <li><a  href="javascript:void(0);" onclick="openFieldWorkWindow()">Change Fieldwork /<br/>Cost Status</a></li>
            </#if>-->
        </#if>

        <li><a  href="javascript:void(0);" onclick="openMyLibraryDialog()">My Library</a></li>
        <!-- Commented by Bhaskar -->
        <li><a  href="javascript:void(0);" id="export-pdf-link" onclick="javascript:exportPDF(${projectID?c},'ProjectSpecs','');">Export To PDF</a></li>
    </ul>
    <#-- SINGLE END MARKET -->
    <#else>
    <ul class="right-sidebar-list" id="synchro-action-box">
    
    	
		
        <#if isCommunicationAgencyAdminUser>
        <#elseif isAdminUser>
            <li><a  href="javascript:void(0);" id="fileAttachBtn">Attach Files</a></li>
            <li><a  href="javascript:void(0);" onclick="openFieldWorkWindow()">Change Fieldwork /<br/>Cost Status</a></li>
        <#elseif projectSpecsInitiation.status ?? && projectSpecsInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROJECT_SPECS_COMPLETED.ordinal() >
            <li class="disableToDoTab">Attach Files</li>
            <li class="disableToDoTab">Change Fieldwork /<br/>Cost Status</li>
        <#elseif isProcurementUser || isCommunicationAgencyUser>
            <li class="disableToDoTab">Attach Files</li>
            <li class="disableToDoTab">Change Fieldwork /<br/>Cost Status</li>
        <#elseif !canEditProject>
            <li class="disableToDoTab">Attach Files</li>
            <li class="disableToDoTab">Change Fieldwork /<br/>Cost Status</li>
        <#elseif projectContactHasReadonlyAccess?? && projectContactHasReadonlyAccess>
            <li class="disableToDoTab">Attach Files</li>
            <li class="disableToDoTab">Change Fieldwork /<br/>Cost Status</li>

        <#else>
            <li><a  href="javascript:void(0);" id="fileAttachBtn">Attach Files</a></li>
            <li><a  href="javascript:void(0);" onclick="openFieldWorkWindow()">Change Fieldwork /<br/>Cost Status</a></li>
        </#if>

        <li><a  href="javascript:void(0);" onclick="openMyLibraryDialog()">My Library</a></li>
        <!-- Commented by Bhaskar -->
        <li><a  href="javascript:void(0);" id="export-pdf-link" onclick="javascript:exportPDF(${projectID?c},'ProjectSpecs','');">Export To PDF</a></li>
    </ul>
    </#if>
<#elseif stageId==4>
<ul class="right-sidebar-list" id="synchro-action-box">   
    <#assign isCommunicationAgencyAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroCommunicationAgencyAdmin() />
    
    <#if isCommunicationAgencyAdminUser>
    <#elseif isAdminUser >
        <li><a  href="javascript:void(0);" id="fileAttachBtn">Attach Files</a></li>
    <#elseif (reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()) || (reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval)>
        <li class="disableToDoTab">Attach Files</li>
    <#elseif isProcurementUser || isCommunicationAgencyUser>
        <li class="disableToDoTab">Attach Files</li>
    <#elseif !canEditProject>
        <li class="disableToDoTab">Attach Files</li>
    <#elseif projectContactHasReadonlyAccess?? && projectContactHasReadonlyAccess>
        <li class="disableToDoTab">Attach Files</li>
    <#else>
        <li><a  href="javascript:void(0);" id="fileAttachBtn">Attach Files</a></li>
    </#if>
    <li><a  href="javascript:void(0);" onclick="openMyLibraryDialog()">My Library</a></li>
    <li><a  href="javascript:void(0);" id="export-pdf-link" onclick="javascript:exportPDF(${projectID?c},'ReportSummary','');">Export To PDF</a></li>

</ul>

</#if>

<#include "/template/global/include/jive-search-macros.ftl"/>
<div class="right-side-list">


<!-- BEGIN SYNCHRO -->
<!-- Changes for displaying appropriate To Do List Actions for each stage -->
<#if stageId ==1>
    <#--<#if !isMethAppUser && !isProcUser && !isLegalUser && !isExternalAgencyUser>-->
    <#if (!isMethAppUser && !isProcUser && !isLegalUser) || (isProjectOwner || isSPIContactUser)>
        <@renderProjectActionStages stageToDoList=stageToDoList stageId=stageId projectID=projectID?c disable=!canEditProject />
        <#if project.multiMarket?? && project.multiMarket  >
            <#if !(isAboveMarketProjectContactUser || isProjectOwner || isCountryProjectContact || isCountrySPIContact || isAdminUser || isExternalAgencyUser)>
            <div id="legal-box-main">
                <div class="legal-checkbox-container">
                    
                    <@renderLegalPIBCheckBox label='Legal Approval for PIB received from' name='legalApprovalRcvd' isChecked=projectInitiation.legalApprovalRcvd?default(false) disable=true />
                    
                    <input type="text" id="legalApprover" name="legalApprover" autocomplete="off" value="${projectInitiation.legalApprover?default('')?html}" size="30" disabled class="form-text-div" >
                    <@renderLegalPIBCheckBox label='Legal Approval not required on PIB' name='legalApprovalNotReq' isChecked=projectInitiation.legalApprovalNotReq?default(false) disable=true />
                </div>
            </div>
            <#elseif !(isAboveMarket) && !(isCountryProjectContact || isCountrySPIContact || isAdminUser || isProjectOwner) >
            <div id="legal-box-main">
                
                <div class="legal-checkbox-container">
                    <@renderLegalPIBCheckBox label='Legal Approval for PIB received from' name='legalApprovalRcvd' isChecked=projectInitiation.legalApprovalRcvd?default(false) disable=true />
                    
                    <input type="text" id="legalApprover" name="legalApprover" autocomplete="off" value="${projectInitiation.legalApprover?default('')?html}" size="30" disabled class="form-text-div" >
                    <@renderLegalPIBCheckBox label='Legal Approval not required on PIB' name='legalApprovalNotReq' isChecked=projectInitiation.legalApprovalNotReq?default(false) disable=true />
                </div></div>
            <#else>
            <div id="legal-box-main">
                
                <div class="legal-checkbox-container">
                    <@renderLegalPIBCheckBox label='Legal Approval for PIB received from' name='legalApprovalRcvd' isChecked=projectInitiation.legalApprovalRcvd?default(false)/>
                
                    <input type="text" id="legalApprover" name="legalApprover" autocomplete="off" value="${projectInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >
                    <@renderLegalPIBCheckBox label='Legal Approval not required on PIB' name='legalApprovalNotReq' isChecked=projectInitiation.legalApprovalNotReq?default(false)/>
                </div></div>
            </#if>
        <#else>
            <#if isSPIContactUser || isAdminUser>
            <div id="legal-box-main">
                <div class="legal-checkbox-container">
                    <@renderLegalPIBCheckBox label='Legal Approval for PIB received from' name='legalApprovalRcvd' isChecked=projectInitiation.legalApprovalRcvd?default(false)/>

                <#--<@renderLegalRadioBox label='Legal Approval for PIB received from' name='legalApprovalRcvd' id='legalApprovalRcvd' value='legalApprovalRcvd' isChecked=projectInitiation.legalApprovalRcvd?default(false)/>-->
                    <input type="text" id="legalApprover" name="legalApprover" autocomplete="off" value="${projectInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >

                    <@renderLegalPIBCheckBox label='Legal Approval not required on PIB' name='legalApprovalNotReq' isChecked=projectInitiation.legalApprovalNotReq?default(false)/>
                <#-- <@renderLegalRadioBox label='Legal Approval not required on PIB' name='legalApprovalRcvd' id='legalApprovalNotReq' value='legalApprovalNotReq' isChecked=projectInitiation.legalApprovalNotReq?default(false)/> -->
                </div></div>
            </#if>
        </#if>


    <#else >
        <#if project.multiMarket?? && project.multiMarket && (isAboveMarketProjectContactUser || isProjectOwner || isCountryProjectContact || isCountrySPIContact) >
            <@renderProjectActionStages stageToDoList=stageToDoList stageId=stageId projectID=projectID?c disable=!canEditProject />

            <#if !(isAboveMarketProjectContactUser || isProjectOwner || isCountryProjectContact || isCountrySPIContact)>
            <div id="legal-box-main">
                <div class="legal-checkbox-container">
                    <@renderLegalPIBCheckBox label='Legal Approval for PIB received from' name='legalApprovalRcvd' isChecked=projectInitiation.legalApprovalRcvd?default(false) disable=true />
                    <input type="text" id="legalApprover" name="legalApprover" autocomplete="off" value="${projectInitiation.legalApprover?default('')?html}" size="30" disabled class="form-text-div" >
                    <@renderLegalPIBCheckBox label='Legal Approval not required on PIB' name='legalApprovalNotReq' isChecked=projectInitiation.legalApprovalNotReq?default(false) disable=true />
                </div></div>
            <#elseif !(isAboveMarket) && !(isCountryProjectContact || isCountrySPIContact || isProjectOwner) >
            <div id="legal-box-main">
                <div class="legal-checkbox-container">
                    <@renderLegalPIBCheckBox label='Legal Approval for PIB received from' name='legalApprovalRcvd' isChecked=projectInitiation.legalApprovalRcvd?default(false) disable=true />
                    <input type="text" id="legalApprover" name="legalApprover" autocomplete="off" value="${projectInitiation.legalApprover?default('')?html}" size="30" disabled class="form-text-div" >
                    <@renderLegalPIBCheckBox label='Legal Approval not required on PIB' name='legalApprovalNotReq' isChecked=projectInitiation.legalApprovalNotReq?default(false) disable=true />
                </div></div>
            <#else>
            <div id="legal-box-main">
                <div class="legal-checkbox-container">
                    <@renderLegalPIBCheckBox label='Legal Approval for PIB received from' name='legalApprovalRcvd' isChecked=projectInitiation.legalApprovalRcvd?default(false)/>
                    <input type="text" id="legalApprover" name="legalApprover" autocomplete="off" value="${projectInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >
                    <@renderLegalPIBCheckBox label='Legal Approval not required on PIB' name='legalApprovalNotReq' isChecked=projectInitiation.legalApprovalNotReq?default(false)/>
                </div></div>
            </#if>
        <#else>
            <#if isSPIContactUser || isAdminUser>
                <@renderProjectActionStages stageToDoList=stageToDoList stageId=stageId projectID=projectID?c disable=!canEditProject />
            <div id="legal-box-main">
                <div class="legal-checkbox-container">
                    <@renderLegalPIBCheckBox label='Legal Approval for PIB received from' name='legalApprovalRcvd' isChecked=projectInitiation.legalApprovalRcvd?default(false)/>

                <#--<@renderLegalRadioBox label='Legal Approval for PIB received from' name='legalApprovalRcvd' id='legalApprovalRcvd' value='legalApprovalRcvd' isChecked=projectInitiation.legalApprovalRcvd?default(false)/>-->
                    <input type="text" id="legalApprover" name="legalApprover" autocomplete="off" value="${projectInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >

                    <@renderLegalPIBCheckBox label='Legal Approval not required on PIB' name='legalApprovalNotReq' isChecked=projectInitiation.legalApprovalNotReq?default(false)/>
                <#-- <@renderLegalRadioBox label='Legal Approval not required on PIB' name='legalApprovalRcvd' id='legalApprovalNotReq' value='legalApprovalNotReq' isChecked=projectInitiation.legalApprovalNotReq?default(false)/> -->
                </div></div>
            </#if>
        </#if>
    </#if>

<#elseif stageId ==2 >
    <#if project.multiMarket?? && project.multiMarket  >
    <#-- Admin user changes starts -->
        <#if isAdminUser>
        <ul class="right-sidebar-list required-actions">

            <li><h4>Required Actions</h4></li>

            <#if proposalInitiation.status?? && (proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOSAL_SAVED.ordinal() || proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOSAL_SUBMITTED.ordinal() || proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOASL_AWARDED.ordinal()) && canEditProject>
                
                <#assign pOwner = "" />
				 <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
					<#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
				 <#else>
					<#assign pOwner = "Stakeholder Requested" />
				 </#if>
                <li><a class="o-btn" onclick="return sendNotificationFormat('${pOwner}','${subjectSubmitProposal.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySubmitProposal.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SUBMIT_PROPOSAL');" href="">Save & Send Proposal</a></li>
            <#else>
                <li class="disableToDoTab"><span>Save & Send Proposal</span></li>
            </#if>

			<#if proposalInitiation.isAwarded?? && proposalInitiation.isAwarded && canEditProject>
                 <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
            <#elseif isProposalAwarded?? && isProposalAwarded>
                 <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
            <#else>
				<li><a class="o-btn" style="background:green;" onclick="awardAgencySM()" href="javascript:void(0);">MOVE TO NEXT STAGE</a></li>
			</#if>

<#--            <#if proposalInitiation.status?? && (proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOSAL_SUBMITTED.ordinal() || proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOASL_AWARDED.ordinal()) && proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>


                <li><a class="o-btn" style="background:green;" onclick="awardAgencySM()" href="javascript:void(0);">MOVE TO NEXT STAGE</a></li>

            <#else>

                <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
            </#if>
-->
            <#if proposalInitiation.status?? && (proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOSAL_SUBMITTED.ordinal() || proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOASL_AWARDED.ordinal()) && proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>

                <li><a class="o-btn" onclick="rejectAgency()" href="javascript:void(0);">REJECT PROPOSAL</a></li>
            <#else>
                <li class="disableToDoTab"><span>REJECT PROPOSAL</span></li>
            </#if>



            <#if proposalInitiation.status?? && (proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOSAL_SUBMITTED.ordinal() || proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOASL_AWARDED.ordinal()) && proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>

                <!--  //EmailNotification#10 Fetch AgencyEmail in submittedAgency parameter -->
                 
                <#attempt>
	                <#assign submittedAgency = jiveContext.getSpringBean("userManager").getUser(proposalInitiation.getAgencyID()).getEmail() />
	                <li><a class="o-btn" onclick="return sendNotificationFormat('${submittedAgency}','${subject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PROPOSAL_REQ_CLARIFICATION');" href="">REQUEST FOR CLARIFICATION</a></li>
	                 <#recover>
	                  <li><a class="o-btn" onclick="return sendNotificationFormat('','${subject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PROPOSAL_REQ_CLARIFICATION');" href="">REQUEST FOR CLARIFICATION</a></li>
        			</#attempt>
            <#else>
                <li class="disableToDoTab"><span>REQUEST FOR CLARIFICATION</span></li>
            </#if>


            <#if proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>
            <#-- <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() /> -->
                <li><a class="o-btn" onclick="return sendNotificationFormat('${aboveMarketProjectContact?default('')}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_PROJECT_OWNER');" href="">Send to <br/>Project Owner</a></li>
            <#else>
                <li class="disableToDoTab"><span>Send to <br/>Project Owner</span></li>
            </#if>

        </ul>
        </#if>
    <#-- Admin user changes ends -->
        <#if (isProjectOwner || isExternalAgencyUser || isAboveMarketProjectContact || isRegionalProjectContact || isAreaProjectContact) && !(isAdminUser)>
        <ul class="right-sidebar-list required-actions">

            <li><h4>Required Actions</h4></li>

            <#if isExternalAgencyUser >
                <#if proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>
                <#-- <li class="b-btn"><span>Save & Send Proposal</span></li> -->
                    <li class="disableToDoTab"><span>Save & Send Proposal</span></li>
                <#elseif isProposalAwarded?? && isProposalAwarded>
                    <li class="disableToDoTab"><span>Save & Send Proposal</span></li>
                <#elseif isExternalAgencyUser && proposalInitiation.status?? && proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOSAL_SAVED.ordinal() && canEditProject>
                    
                    <#assign pOwner = "" />
					 <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
						<#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
					 <#else>
						<#assign pOwner = "Stakeholder Requested" />
					 </#if>
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${pOwner}','${subjectSubmitProposal.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySubmitProposal.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SUBMIT_PROPOSAL');" href="">Save & Send Proposal</a></li>
                <#--<li><a class="o-btn" onclick="submitProposal(${projectID?c})" href="javascript:void(0);">Save & Send Proposal</a></li>-->
                <#else>
                    <li class="disableToDoTab"><span>Save & Send Proposal</span></li>
                </#if>

            </#if>

          <#--  <#if isAboveMarketProjectContact || isExternalAgencyUser || isRegionalProjectContact || isAreaProjectContact || (isProjectOwner && projectContactName==statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner)) > -->
            <#if isAboveMarketProjectContact || isExternalAgencyUser || isRegionalProjectContact || isAreaProjectContact || isProjectOwner  >
                <#if proposalInitiation.isAwarded?? && proposalInitiation.isAwarded && canEditProject>
                     <#--<li class="disableToDoTab"><span>AWARD TO AGENCY</span></li>-->
                     <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                <#--<#elseif (isAboveMarketProjectContact || isRegionalProjectContact || isAreaProjectContact || (isProjectOwner && projectContactName==statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner))) && proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>-->
                <#elseif (isAboveMarketProjectContact || isExternalAgencyUser || isRegionalProjectContact || isAreaProjectContact || isProjectOwner ) && canEditProject>
                    <#if isProposalAwarded?? && isProposalAwarded>
                       <#-- <li class="disableToDoTab"><span>AWARD TO AGENCY</span></li>-->
                        <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                    <#else>
                        <#--<li><a class="o-btn" onclick="awardAgency()" href="javascript:void(0);">AWARD TO AGENCY</a></li>-->
                        <li><a class="o-btn" style="background:green;" onclick="awardAgencySM()" href="javascript:void(0);">MOVE TO NEXT STAGE</a></li>
                    </#if>
                <#else>
                    <#--<li class="disableToDoTab"><span>AWARD TO AGENCY</span></li>-->
                    <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                </#if>

                <#if proposalInitiation.isAwarded?? && proposalInitiation.isAwarded && canEditProject>
                <#--<li class="b-btn">REJECT PROPOSAL</li> -->
                    <li class="disableToDoTab"><span>REJECT PROPOSAL</span></li>
                <#elseif (isAboveMarketProjectContact || isRegionalProjectContact || isAreaProjectContact || (isProjectOwner && projectContactName==statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner))) && proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>
                    <#if isProposalAwarded?? && isProposalAwarded>
                        <li class="disableToDoTab"><span>REJECT PROPOSAL</span></li>
                    <#else>
                        <li><a class="o-btn" onclick="rejectAgency()" href="javascript:void(0);">REJECT PROPOSAL</a></li>
                    </#if>
                <#else>
                    <li class="disableToDoTab"><span>REJECT PROPOSAL</span></li>
                </#if>
            </#if>
            <#if isProjectOwner >
                <#if proposalInitiation.isAwarded?? && proposalInitiation.isAwarded && canEditProject>
                <#--  <li class="b-btn"><span>REQUEST FOR CLARIFICATION</span></li> -->
                    <li class="disableToDoTab"><span>REQUEST FOR CLARIFICATION</span></li>
                <#elseif proposalInitiation.isReqClariModification?? && proposalInitiation.isReqClariModification>
                <#--  <li class="r-btn"><span>REQUEST FOR CLARIFICATION</span></li> -->
                    <#assign submittedAgency = jiveContext.getSpringBean("userManager").getUser(proposalInitiation.getAgencyID()).getEmail() />
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${submittedAgency}','${subject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PROPOSAL_REQ_CLARIFICATION');" href="">REQUEST FOR CLARIFICATION</a></li>
                <#elseif isProjectOwner && proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>
                    <#if isProposalAwarded?? && isProposalAwarded>
                        <li class="disableToDoTab"><span>REQUEST FOR CLARIFICATION</span></li>
                    <#else>
                        <!--  //EmailNotification#10 Fetch AgencyEmail in submittedAgency parameter -->
                        <#assign submittedAgency = jiveContext.getSpringBean("userManager").getUser(proposalInitiation.getAgencyID()).getEmail() />
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${submittedAgency}','${subject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PROPOSAL_REQ_CLARIFICATION');" href="">REQUEST FOR CLARIFICATION</a></li>
                    </#if>
                <#else>
                    <li class="disableToDoTab"><span>REQUEST FOR CLARIFICATION</span></li>
                </#if>
            </#if>

            <#if isProjectOwner>
                <#if proposalInitiation.isAwarded?? && proposalInitiation.isAwarded>

                    <li class="disableToDoTab"><span>Send to <br/>Project Owner</span></li>
                <#elseif proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>
                <#-- <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() /> -->
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${aboveMarketProjectContact?default('')}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_PROJECT_OWNER');" href="">Send to <br/>Project Owner</a></li>
                <#else>
                    <li class="disableToDoTab"><span>Send to <br/>Project Owner</span></li>
                </#if>
            </#if>
        <#--  <#if isAboveMarketProjectContact || (isProjectOwner && projectContactName==statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner))> -->

        <#--  <#if isProjectOwner>
            <#if proposalInitiation.isAwarded?? && proposalInitiation.isAwarded>
                <li class="disableToDoTab"><span>Request For Clarification</span></li>
           <#elseif proposalInitiation.isSendToProjectOwner?? && proposalInitiation.isSendToProjectOwner && canEditProject>
               <#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
               <li><a class="o-btn" onclick="return sendNotificationFormat('${pOwner}','${subjectSendToSPI.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToSPI.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','REQUEST_FOR_CLARIFICATION');" href="">Request For Clarification</a></li>
           <#else>
               <li class="disableToDoTab"><span>Request For Clarification</span></li>
           </#if>
       </#if> -->
        </ul>
        </#if>
    <#-- SINGLE END MARKET -->
    <#else>

        <#if (isProjectOwner || isExternalAgencyUser || isSPIContactUser) && !(isAdminUser)>
        <ul class="right-sidebar-list required-actions">

            <li><h4>Required Actions</h4></li>

            <#if isExternalAgencyUser >

                <#if proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>
                    <li class="disableToDoTab"><span>Save & Send Proposal</span></li>
                <#elseif isProposalAwarded?? && isProposalAwarded>
                    <li class="disableToDoTab"><span>Save & Send Proposal</span></li>
                <#elseif isExternalAgencyUser && proposalInitiation.status?? && proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOSAL_SAVED.ordinal() && canEditProject>
                    
                    <#assign spiUser = "" />
					  <#if spiContact?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(spiContact) >
						<#assign spiUser = jiveContext.getSpringBean("userManager").getUser(spiContact).getEmail() />
					  <#else>
						<#assign spiUser = "Stakeholder Requested" />
					  </#if>
						     
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${spiUser}','${subjectSubmitProposal.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySubmitProposal.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SUBMIT_PROPOSAL');" href="">Save & Send Proposal</a></li>
                <#--<li><a class="o-btn" onclick="submitProposal(${projectID?c})" href="javascript:void(0);">Save & Send Proposal</a></li>-->
                <#else>
                    <li class="disableToDoTab"><span>Save & Send Proposal</span></li>
                </#if>
                
                <#if proposalInitiation.isAwarded?? && proposalInitiation.isAwarded && canEditProject>
                     <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                <#elseif canEditProject>
                    <#if isProposalAwarded?? && isProposalAwarded>
                        <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                    <#else>
                        <li><a class="o-btn" style="background:green;" onclick="awardAgencySM()" href="javascript:void(0);">MOVE TO NEXT STAGE</a></li>
                    </#if>
                <#else>
                    <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                </#if>
            

            <#elseif isProjectOwner || isSPIContactUser >
                <#if proposalInitiation.isAwarded?? && proposalInitiation.isAwarded && canEditProject>
                     <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
          <#--      <#elseif isProjectOwner && proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>-->
                <#elseif (isProjectOwner || isSPIContactUser) && canEditProject>
                    <#if isProposalAwarded?? && isProposalAwarded>
                        <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                    <#else>
                        <li><a class="o-btn" style="background:green;" onclick="awardAgencySM()" href="javascript:void(0);">MOVE TO NEXT STAGE</a></li>
                    </#if>
                <#else>
                    <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
                </#if>

                <#if proposalInitiation.isAwarded?? && proposalInitiation.isAwarded && canEditProject>
                <#-- <li class="b-btn">REJECT PROPOSAL</li> -->
                    <li class="disableToDoTab"><span>REJECT PROPOSAL</span></li>
                <#elseif isProjectOwner && proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>
                    <#if isProposalAwarded?? && isProposalAwarded>
                        <li class="disableToDoTab"><span>REJECT PROPOSAL</span></li>
                    <#else>
                        <li><a class="o-btn" onclick="rejectAgency()" href="javascript:void(0);">REJECT PROPOSAL</a></li>
                    </#if>
                <#else>
                    <li class="disableToDoTab"><span>REJECT PROPOSAL</span></li>
                </#if>
            </#if>
            
            <#if isSPIContactUser >

                <#if isProposalAwarded?? && isProposalAwarded>
                    <li class="disableToDoTab"><span>REQUEST FOR CLARIFICATION</span></li>
                <#elseif proposalInitiation.isAwarded?? && proposalInitiation.isAwarded && canEditProject>
                <#-- <li class="b-btn"><span>REQUEST FOR CLARIFICATION</span></li> -->
                    <li class="disableToDoTab"><span>REQUEST FOR CLARIFICATION</span></li>
                <#elseif proposalInitiation.isReqClariModification?? && proposalInitiation.isReqClariModification>
                <#--<li class="r-btn"><span>REQUEST FOR CLARIFICATION</span></li>-->
                    <#assign submittedAgency = jiveContext.getSpringBean("userManager").getUser(proposalInitiation.getAgencyID()).getEmail() />
                <#--<li class="b-btn"><a class="active" onclick="return sendNotificationFormat('${submittedAgency}','${subject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PROPOSAL_REQ_CLARIFICATION');" href="">REQUEST FOR CLARIFICATION</a></li>-->
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${submittedAgency}','${subject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PROPOSAL_REQ_CLARIFICATION');" href="">REQUEST FOR CLARIFICATION</a></li>
                <#elseif isSPIContactUser && proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>
                    <#if isProposalAwarded?? && isProposalAwarded>
                        <li class="disableToDoTab"><span>REQUEST FOR CLARIFICATION</span></li>
                    <#else>
                        <!--  //EmailNotification#10 Fetch AgencyEmail in submittedAgency parameter -->
                        <#assign submittedAgency = jiveContext.getSpringBean("userManager").getUser(proposalInitiation.getAgencyID()).getEmail() />
                        <li><a class="o-btn" onclick="return sendNotificationFormat('${submittedAgency}','${subject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PROPOSAL_REQ_CLARIFICATION');" href="">REQUEST FOR CLARIFICATION</a></li>
                    </#if>
                <#else>
                    <li class="disableToDoTab"><span>REQUEST FOR CLARIFICATION</span></li>
                </#if>
            </#if>

            <#if isSPIContactUser>
                <#if proposalInitiation.isAwarded?? && proposalInitiation.isAwarded && canEditProject>
                <#-- <li class="b-btn"><span>Send to <br/>Project Owner</span></li> -->
                    <li class="disableToDoTab"><span>Send to <br/>Project Owner</span></li>
                <#elseif proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>
                    <#assign pOwner = "" />
					 <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
						<#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
					 <#else>
						<#assign pOwner = "Stakeholder Requested" />
					 </#if>
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${pOwner}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_PROJECT_OWNER');" href="">Send to <br/>Project Owner</a></li>
                <#else>
                    <li class="disableToDoTab"><span>Send to <br/>Project Owner</span></li>
                </#if>
            </#if>

        <#--
            <#if isProjectOwner>
                <#if proposalInitiation.isAwarded?? && proposalInitiation.isAwarded && canEditProject>
                   <li class="disableToDoTab"><span>Request For Clarification</span></li>
                <#elseif proposalInitiation.isSendToProjectOwner?? && proposalInitiation.isSendToProjectOwner && canEditProject>
                    <#assign spiUser = jiveContext.getSpringBean("userManager").getUser(spiContact).getEmail() />
                    <li><a class="o-btn" onclick="return sendNotificationFormat('${spiUser}','${subjectSendToSPI.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToSPI.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','REQUEST_FOR_CLARIFICATION');" href="">Request For Clarification</a></li>
                <#else>
                    <li class="disableToDoTab"><span>Request For Clarification</span></li>
                </#if>
            </#if>
        -->
        </ul>
        </#if>

    <#-- Admin user changes Starts-->
        <#if isAdminUser>
        <ul class="right-sidebar-list required-actions">

            <li><h4>Required Actions</h4></li>
            <#if proposalInitiation.status?? && (proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOSAL_SAVED.ordinal() || proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOSAL_SUBMITTED.ordinal() || proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOASL_AWARDED.ordinal()) && canEditProject>
                
                <#assign spiUser = "" />
				  <#if spiContact?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(spiContact) >
					<#assign spiUser = jiveContext.getSpringBean("userManager").getUser(spiContact).getEmail() />
				  <#else>
					<#assign spiUser = "Stakeholder Requested" />
				  </#if>
                <li><a class="o-btn" onclick="return sendNotificationFormat('${spiUser}','${subjectSubmitProposal.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySubmitProposal.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SUBMIT_PROPOSAL');" href="">Save & Send Proposal</a></li>
            <#else>
                <li class="disableToDoTab"><span>Save & Send Proposal</span></li>
            </#if>

           <#--
            <#if proposalInitiation.status?? && (proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOSAL_SUBMITTED.ordinal() || proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOASL_AWARDED.ordinal()) && proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>
                <li><a class="o-btn" onclick="awardAgency()" href="javascript:void(0);">AWARD TO AGENCY</a></li>
            <#else>
                <li class="disableToDoTab"><span>AWARD TO AGENCY</span></li>
            </#if>
			-->
			
			<#if proposalInitiation.status?? && canEditProject>
                <li><a class="o-btn" style="background:green;" onclick="awardAgencySM()" href="javascript:void(0);">MOVE TO NEXT STAGE</a></li>
            <#else>
                <li class="disableToDoTab"><span>MOVE TO NEXT STAGE</span></li>
            </#if>
			
        <#-- <#if proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject> -->
            <#if proposalInitiation.status?? && (proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOSAL_SUBMITTED.ordinal() || proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOASL_AWARDED.ordinal()) && proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>
                <li><a class="o-btn" onclick="rejectAgency()" href="javascript:void(0);">REJECT PROPOSAL</a></li>
            <#else>
                <li class="disableToDoTab"><span>REJECT PROPOSAL</span></li>

            </#if>


            <#if proposalInitiation.isReqClariModification?? && proposalInitiation.isReqClariModification>
                <#assign submittedAgency = jiveContext.getSpringBean("userManager").getUser(proposalInitiation.getAgencyID()).getEmail() />
                <li><a class="o-btn" onclick="return sendNotificationFormat('${submittedAgency}','${subject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PROPOSAL_REQ_CLARIFICATION');" href="">REQUEST FOR CLARIFICATION</a></li>
            <#-- <#elseif proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject> -->
            <#elseif proposalInitiation.status?? && (proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOSAL_SUBMITTED.ordinal() || proposalInitiation.status== statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROPOASL_AWARDED.ordinal()) && proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>
                <!--  //EmailNotification#10 Fetch AgencyEmail in submittedAgency parameter -->
                 <#attempt>
	                <#assign submittedAgency = jiveContext.getSpringBean("userManager").getUser(proposalInitiation.getAgencyID()).getEmail() />
	                <li><a class="o-btn" onclick="return sendNotificationFormat('${submittedAgency}','${subject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PROPOSAL_REQ_CLARIFICATION');" href="">REQUEST FOR CLARIFICATION</a></li>
	                 <#recover>
	                  <li><a class="o-btn" onclick="return sendNotificationFormat('','${subject.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBody.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','PROPOSAL_REQ_CLARIFICATION');" href="">REQUEST FOR CLARIFICATION</a></li>
        			</#attempt>   
            <#else>
                <li class="disableToDoTab"><span>REQUEST FOR CLARIFICATION</span></li>
            </#if>

            <#if proposalInitiation.isPropSubmitted?? && proposalInitiation.isPropSubmitted && canEditProject>
                <#assign pOwner = "" />
				 <#if project.projectOwner?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(project.projectOwner) >
					<#assign pOwner = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getEmail() />
				 <#else>
					<#assign pOwner = "Stakeholder Requested" />
				 </#if>
                <li><a class="o-btn" onclick="return sendNotificationFormat('${pOwner}','${subjectSendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','${messageBodySendToProjOwner.replaceAll("'","&quot;&quot;&quot;").replaceAll("\"","&quot;&quot;&quot;")}','SEND_TO_PROJECT_OWNER');" href="">Send to <br/>Project Owner</a></li>
            <#else>
                <li class="disableToDoTab"><span>Send to <br/>Project Owner</span></li>

            </#if>

        </ul>
        </#if>
    <#-- Admin user changes Ends -->

    </#if>
    <ul class="right-sidebar-list modified-fields-lengend">
        <li>
            <div>
                <div class="empty-box"></div>
                <div class="label"><span>Fields modified by the Agency</span></div>
            </div>
        </li>
    </ul>
<#elseif stageId == 3>
    <#if project.multiMarket?? && project.multiMarket &&  (isSPIContactUser || isCountryProjectContact || isCountrySPIContact || isAdminUser || isProjectOwner) >
        <#assign seeActionButtons = true />
    <#elseif isSPIContactUser || isProjectOwner>
        <#assign seeActionButtons = true />
    <#else>
        <#assign seeActionButtons = false />
    </#if>

    <#if (!isMethAppUser && !isProcUser && !isLegalUser ) || seeActionButtons >
        <@renderProjectActionStages stageToDoList=stageToDoList stageId=stageId projectID=projectID?c />

        <#if project.multiMarket?? && project.multiMarket  >
            <#if isAboveMarket>
                <#if isAdminUser>
                <div id="legal-box-main">
                    <div class="legal-checkbox-container">
                        <@renderLegalCheckBox label='Legal Approval - Stimulus Material from' name='legalApprovalStimulus' isChecked=projectSpecsInitiation.legalApprovalStimulus?default(false)/>
                        <input type="text" name="legalApproverStimulus" id="legalApproverStimulus" autocomplete="off" value="${projectSpecsInitiation.legalApproverStimulus?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Screener from' name='legalApprovalScreener' isChecked=projectSpecsInitiation.legalApprovalScreener?default(false)/>
                        <input type="text" name="legalApproverScreener" id="legalApproverScreener" autocomplete="off" value="${projectSpecsInitiation.legalApproverScreener?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Consumer Contract and Confidentiality Agreement from' name='legalApprovalCCCA' isChecked=projectSpecsInitiation.legalApprovalCCCA?default(false)/>
                        <input type="text" name="legalApproverCCCA" id="legalApproverCCCA"  autocomplete="off" value="${projectSpecsInitiation.legalApproverCCCA?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Questionnaire from' name='legalApprovalQuestionnaire' isChecked=projectSpecsInitiation.legalApprovalQuestionnaire?default(false)/>
                        <input type="text" name="legalApproverQuestionnaire" id="legalApproverQuestionnaire"  autocomplete="off" value="${projectSpecsInitiation.legalApproverQuestionnaire?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Discussion guide from' name='legalApprovalDG' isChecked=projectSpecsInitiation.legalApprovalDG?default(false)/>
                        <input type="text" name="legalApproverDG" id="legalApproverDG"  autocomplete="off" value="${projectSpecsInitiation.legalApproverDG?default('')?html}" size="30" class="form-text-div" >
                    </div></div>
               <#-- <#elseif isSPIContactUser && projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved!=1 >-->
                <#elseif (isSPIContactUser || isExternalAgencyUser || isAboveMarketProjectContactUser) && projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved!=1 >
                <div id="legal-box-main">
                    <div class="legal-checkbox-container">
                        <@renderLegalCheckBox label='Legal Approval - Stimulus Material from' name='legalApprovalStimulus' isChecked=projectSpecsInitiation.legalApprovalStimulus?default(false)/>
                        <input type="text" name="legalApproverStimulus" id="legalApproverStimulus" autocomplete="off" value="${projectSpecsInitiation.legalApproverStimulus?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Screener from' name='legalApprovalScreener' isChecked=projectSpecsInitiation.legalApprovalScreener?default(false)/>
                        <input type="text" name="legalApproverScreener" id="legalApproverScreener" autocomplete="off" value="${projectSpecsInitiation.legalApproverScreener?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Consumer Contract and Confidentiality Agreement from' name='legalApprovalCCCA' isChecked=projectSpecsInitiation.legalApprovalCCCA?default(false)/>
                        <input type="text" name="legalApproverCCCA" id="legalApproverCCCA"  autocomplete="off" value="${projectSpecsInitiation.legalApproverCCCA?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Questionnaire from' name='legalApprovalQuestionnaire' isChecked=projectSpecsInitiation.legalApprovalQuestionnaire?default(false)/>
                        <input type="text" name="legalApproverQuestionnaire" id="legalApproverQuestionnaire"  autocomplete="off" value="${projectSpecsInitiation.legalApproverQuestionnaire?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Discussion guide from' name='legalApprovalDG' isChecked=projectSpecsInitiation.legalApprovalDG?default(false)/>
                        <input type="text" name="legalApproverDG" id="legalApproverDG"  autocomplete="off" value="${projectSpecsInitiation.legalApproverDG?default('')?html}" size="30" class="form-text-div" >
                    </div></div>
                <#else>
                <div id="legal-box-main">
                    <div class="legal-checkbox-container">
                        <@renderLegalCheckBox label='Legal Approval - Stimulus Material from' name='legalApprovalStimulus' isChecked=projectSpecsInitiation.legalApprovalStimulus?default(false) disable=true/>
                        <input type="text" name="legalApproverStimulus" autocomplete="off" value="${projectSpecsInitiation.legalApproverStimulus?default('')?html}" size="30" disabled class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Screener from' name='legalApprovalScreener' isChecked=projectSpecsInitiation.legalApprovalScreener?default(false) disable=true/>
                        <input type="text" name="legalApproverScreener" autocomplete="off" value="${projectSpecsInitiation.legalApproverScreener?default('')?html}" size="30" disabled class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Consumer Contract and Confidentiality Agreement from' name='legalApprovalCCCA' isChecked=projectSpecsInitiation.legalApprovalCCCA?default(false) disable=true/>
                        <input type="text" name="legalApproverCCCA" autocomplete="off" value="${projectSpecsInitiation.legalApproverCCCA?default('')?html}" size="30" disabled class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Questionnaire from' name='legalApprovalQuestionnaire' isChecked=projectSpecsInitiation.legalApprovalQuestionnaire?default(false) disable=true/>
                        <input type="text" name="legalApproverQuestionnaire" autocomplete="off" value="${projectSpecsInitiation.legalApproverQuestionnaire?default('')?html}" disabled size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Discussion guide from' name='legalApprovalDG' isChecked=projectSpecsInitiation.legalApprovalDG?default(false) disable=true/>
                        <input type="text" name="legalApproverDG" autocomplete="off" value="${projectSpecsInitiation.legalApproverDG?default('')?html}" size="30" disabled class="form-text-div" >
                    </div></div>
                </#if>
            <#else>
                <#if isAdminUser>
                <div id="legal-box-main">
                    <div class="legal-checkbox-container">
                        <@renderLegalCheckBox label='Legal Approval - Stimulus Material from' name='legalApprovalStimulus' isChecked=projectSpecsInitiation.legalApprovalStimulus?default(false)/>
                        <input type="text" name="legalApproverStimulus" id="legalApproverStimulus" autocomplete="off" value="${projectSpecsInitiation.legalApproverStimulus?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Screener from' name='legalApprovalScreener' isChecked=projectSpecsInitiation.legalApprovalScreener?default(false)/>
                        <input type="text" name="legalApproverScreener" id="legalApproverScreener" autocomplete="off" value="${projectSpecsInitiation.legalApproverScreener?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Consumer Contract and Confidentiality Agreement from' name='legalApprovalCCCA' isChecked=projectSpecsInitiation.legalApprovalCCCA?default(false)/>
                        <input type="text" name="legalApproverCCCA" id="legalApproverCCCA"  autocomplete="off" value="${projectSpecsInitiation.legalApproverCCCA?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Questionnaire from' name='legalApprovalQuestionnaire' isChecked=projectSpecsInitiation.legalApprovalQuestionnaire?default(false)/>
                        <input type="text" name="legalApproverQuestionnaire" id="legalApproverQuestionnaire"  autocomplete="off" value="${projectSpecsInitiation.legalApproverQuestionnaire?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Discussion guide from' name='legalApprovalDG' isChecked=projectSpecsInitiation.legalApprovalDG?default(false)/>
                        <input type="text" name="legalApproverDG" id="legalApproverDG"  autocomplete="off" value="${projectSpecsInitiation.legalApproverDG?default('')?html}" size="30" class="form-text-div" >
                    </div></div>
                <#elseif !(isAboveMarket) && endMarketStatus?? && endMarketStatus==statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].CANCEL.ordinal() >
                <div id="legal-box-main">
                    <div class="legal-checkbox-container">
                        <@renderLegalCheckBox label='Legal Approval - Stimulus Material from' name='legalApprovalStimulus' isChecked=projectSpecsInitiation.legalApprovalStimulus?default(false) disable=true/>
                        <input type="text" name="legalApproverStimulus" autocomplete="off" value="${projectSpecsInitiation.legalApproverStimulus?default('')?html}" size="30" disabled class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Screener from' name='legalApprovalScreener' isChecked=projectSpecsInitiation.legalApprovalScreener?default(false) disable=true/>
                        <input type="text" name="legalApproverScreener" autocomplete="off" value="${projectSpecsInitiation.legalApproverScreener?default('')?html}" size="30" disabled class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Consumer Contract and Confidentiality Agreement from' name='legalApprovalCCCA' isChecked=projectSpecsInitiation.legalApprovalCCCA?default(false) disable=true/>
                        <input type="text" name="legalApproverCCCA" autocomplete="off" value="${projectSpecsInitiation.legalApproverCCCA?default('')?html}" size="30" disabled class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Questionnaire from' name='legalApprovalQuestionnaire' isChecked=projectSpecsInitiation.legalApprovalQuestionnaire?default(false) disable=true/>
                        <input type="text" name="legalApproverQuestionnaire" autocomplete="off" value="${projectSpecsInitiation.legalApproverQuestionnaire?default('')?html}" disabled size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Discussion guide from' name='legalApprovalDG' isChecked=projectSpecsInitiation.legalApprovalDG?default(false) disable=true/>
                        <input type="text" name="legalApproverDG" autocomplete="off" value="${projectSpecsInitiation.legalApproverDG?default('')?html}" size="30" disabled class="form-text-div" >
                    </div> </div>
                <#elseif !(isAboveMarket) && !(isCountryProjectContact || isCountrySPIContact || isProjectOwner) >
                <div id="legal-box-main">
                    <div class="legal-checkbox-container">
                        <@renderLegalCheckBox label='Legal Approval - Stimulus Material from' name='legalApprovalStimulus' isChecked=projectSpecsInitiation.legalApprovalStimulus?default(false) disable=true/>
                        <input type="text" name="legalApproverStimulus" autocomplete="off" value="${projectSpecsInitiation.legalApproverStimulus?default('')?html}" size="30" disabled class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Screener from' name='legalApprovalScreener' isChecked=projectSpecsInitiation.legalApprovalScreener?default(false) disable=true/>
                        <input type="text" name="legalApproverScreener" autocomplete="off" value="${projectSpecsInitiation.legalApproverScreener?default('')?html}" size="30" disabled class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Consumer Contract and Confidentiality Agreement from' name='legalApprovalCCCA' isChecked=projectSpecsInitiation.legalApprovalCCCA?default(false) disable=true/>
                        <input type="text" name="legalApproverCCCA" autocomplete="off" value="${projectSpecsInitiation.legalApproverCCCA?default('')?html}" size="30" disabled class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Questionnaire from' name='legalApprovalQuestionnaire' isChecked=projectSpecsInitiation.legalApprovalQuestionnaire?default(false) disable=true/>
                        <input type="text" name="legalApproverQuestionnaire" autocomplete="off" value="${projectSpecsInitiation.legalApproverQuestionnaire?default('')?html}" disabled size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Discussion guide from' name='legalApprovalDG' isChecked=projectSpecsInitiation.legalApprovalDG?default(false) disable=true/>
                        <input type="text" name="legalApproverDG" autocomplete="off" value="${projectSpecsInitiation.legalApproverDG?default('')?html}" size="30" disabled class="form-text-div" >
                    </div></div>

                <#elseif (isCountryProjectContact || isCountrySPIContact || isSPIContactUser || isProjectOwner) && (projectSpecsInitiation.isApproved?? && projectSpecsInitiation.isApproved!=1 ) >
                <div id="legal-box-main">
                    <div class="legal-checkbox-container">
                        <@renderLegalCheckBox label='Legal Approval - Stimulus Material from' name='legalApprovalStimulus' isChecked=projectSpecsInitiation.legalApprovalStimulus?default(false)/>
                        <input type="text" name="legalApproverStimulus" id="legalApproverStimulus" autocomplete="off" value="${projectSpecsInitiation.legalApproverStimulus?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Screener from' name='legalApprovalScreener' isChecked=projectSpecsInitiation.legalApprovalScreener?default(false)/>
                        <input type="text" name="legalApproverScreener" id="legalApproverScreener" autocomplete="off" value="${projectSpecsInitiation.legalApproverScreener?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Consumer Contract and Confidentiality Agreement from' name='legalApprovalCCCA' isChecked=projectSpecsInitiation.legalApprovalCCCA?default(false)/>
                        <input type="text" name="legalApproverCCCA" id="legalApproverCCCA"  autocomplete="off" value="${projectSpecsInitiation.legalApproverCCCA?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Questionnaire from' name='legalApprovalQuestionnaire' isChecked=projectSpecsInitiation.legalApprovalQuestionnaire?default(false)/>
                        <input type="text" name="legalApproverQuestionnaire" id="legalApproverQuestionnaire"  autocomplete="off" value="${projectSpecsInitiation.legalApproverQuestionnaire?default('')?html}" size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Discussion guide from' name='legalApprovalDG' isChecked=projectSpecsInitiation.legalApprovalDG?default(false)/>
                        <input type="text" name="legalApproverDG" id="legalApproverDG"  autocomplete="off" value="${projectSpecsInitiation.legalApproverDG?default('')?html}" size="30" class="form-text-div" >
                    </div></div>
                <#else>
                <div id="legal-box-main">
                    <div class="legal-checkbox-container">
                        <@renderLegalCheckBox label='Legal Approval - Stimulus Material from' name='legalApprovalStimulus' isChecked=projectSpecsInitiation.legalApprovalStimulus?default(false) disable=true/>
                        <input type="text" name="legalApproverStimulus" autocomplete="off" value="${projectSpecsInitiation.legalApproverStimulus?default('')?html}" size="30" disabled class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Screener from' name='legalApprovalScreener' isChecked=projectSpecsInitiation.legalApprovalScreener?default(false) disable=true/>
                        <input type="text" name="legalApproverScreener" autocomplete="off" value="${projectSpecsInitiation.legalApproverScreener?default('')?html}" size="30" disabled class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Consumer Contract and Confidentiality Agreement from' name='legalApprovalCCCA' isChecked=projectSpecsInitiation.legalApprovalCCCA?default(false) disable=true/>
                        <input type="text" name="legalApproverCCCA" autocomplete="off" value="${projectSpecsInitiation.legalApproverCCCA?default('')?html}" size="30" disabled class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Questionnaire from' name='legalApprovalQuestionnaire' isChecked=projectSpecsInitiation.legalApprovalQuestionnaire?default(false) disable=true/>
                        <input type="text" name="legalApproverQuestionnaire" autocomplete="off" value="${projectSpecsInitiation.legalApproverQuestionnaire?default('')?html}" disabled size="30" class="form-text-div" >
                        <@renderLegalCheckBox label='Legal Approval - Discussion guide from' name='legalApprovalDG' isChecked=projectSpecsInitiation.legalApprovalDG?default(false) disable=true/>
                        <input type="text" name="legalApproverDG" autocomplete="off" value="${projectSpecsInitiation.legalApproverDG?default('')?html}" size="30" disabled class="form-text-div" >
                    </div></div>

                </#if>
            </#if>

        <#else>

            <#if isSPIContactUser || isAdminUser >
            <div id="legal-box-main">
                <div class="legal-checkbox-container">
                    <@renderLegalCheckBox label='Legal Approval - Stimulus Material from' name='legalApprovalStimulus' isChecked=projectSpecsInitiation.legalApprovalStimulus?default(false)/>
                    <input type="text" name="legalApproverStimulus" id="legalApproverStimulus" autocomplete="off" value="${projectSpecsInitiation.legalApproverStimulus?default('')?html}" size="30" class="form-text-div" >
                    <@renderLegalCheckBox label='Legal Approval - Screener from' name='legalApprovalScreener' isChecked=projectSpecsInitiation.legalApprovalScreener?default(false)/>
                    <input type="text" name="legalApproverScreener" id="legalApproverScreener" autocomplete="off" value="${projectSpecsInitiation.legalApproverScreener?default('')?html}" size="30" class="form-text-div" >
                    <@renderLegalCheckBox label='Legal Approval - Consumer Contract and Confidentiality Agreement from' name='legalApprovalCCCA' isChecked=projectSpecsInitiation.legalApprovalCCCA?default(false)/>
                    <input type="text" name="legalApproverCCCA" id="legalApproverCCCA"  autocomplete="off" value="${projectSpecsInitiation.legalApproverCCCA?default('')?html}" size="30" class="form-text-div" >
                    <@renderLegalCheckBox label='Legal Approval - Questionnaire from' name='legalApprovalQuestionnaire' isChecked=projectSpecsInitiation.legalApprovalQuestionnaire?default(false)/>
                    <input type="text" name="legalApproverQuestionnaire" id="legalApproverQuestionnaire"  autocomplete="off" value="${projectSpecsInitiation.legalApproverQuestionnaire?default('')?html}" size="30" class="form-text-div" >
                    <@renderLegalCheckBox label='Legal Approval - Discussion guide from' name='legalApprovalDG' isChecked=projectSpecsInitiation.legalApprovalDG?default(false)/>
                    <input type="text" name="legalApproverDG" id="legalApproverDG"  autocomplete="off" value="${projectSpecsInitiation.legalApproverDG?default('')?html}" size="30" class="form-text-div" >
                </div></div>
            <#else>
            <div id="legal-box-main">
                <div class="legal-checkbox-container">
                    <@renderLegalCheckBox label='Legal Approval - Stimulus Material from' name='legalApprovalStimulus' isChecked=projectSpecsInitiation.legalApprovalStimulus?default(false) disable=true/>
                    <input type="text" name="legalApproverStimulus" autocomplete="off" value="${projectSpecsInitiation.legalApproverStimulus?default('')?html}" size="30" disabled class="form-text-div" >
                    <@renderLegalCheckBox label='Legal Approval - Screener from' name='legalApprovalScreener' isChecked=projectSpecsInitiation.legalApprovalScreener?default(false) disable=true/>
                    <input type="text" name="legalApproverScreener" autocomplete="off" value="${projectSpecsInitiation.legalApproverScreener?default('')?html}" size="30" disabled class="form-text-div" >
                    <@renderLegalCheckBox label='Legal Approval - Consumer Contract and Confidentiality Agreement from' name='legalApprovalCCCA' isChecked=projectSpecsInitiation.legalApprovalCCCA?default(false) disable=true/>
                    <input type="text" name="legalApproverCCCA" autocomplete="off" value="${projectSpecsInitiation.legalApproverCCCA?default('')?html}" size="30" disabled class="form-text-div" >
                    <@renderLegalCheckBox label='Legal Approval - Questionnaire from' name='legalApprovalQuestionnaire' isChecked=projectSpecsInitiation.legalApprovalQuestionnaire?default(false) disable=true/>
                    <input type="text" name="legalApproverQuestionnaire" autocomplete="off" value="${projectSpecsInitiation.legalApproverQuestionnaire?default('')?html}" disabled size="30" class="form-text-div" >
                    <@renderLegalCheckBox label='Legal Approval - Discussion guide from' name='legalApprovalDG' isChecked=projectSpecsInitiation.legalApprovalDG?default(false) disable=true/>
                    <input type="text" name="legalApproverDG" autocomplete="off" value="${projectSpecsInitiation.legalApproverDG?default('')?html}" size="30" disabled class="form-text-div" >
                </div></div>

            </#if>
        </#if>
    </#if>
<#elseif stageId == 4>
    <@renderProjectActionStages stageToDoList=stageToDoList stageId=stageId projectID=projectID?c />
    <#if project.multiMarket?? && project.multiMarket  >
        <#if isAboveMarket>

            <#if isAdminUser>
            <div id="legal-box-main">
                <div class="legal-checkbox-container">
                    <@renderLegalPIBCheckBox label='Legal Approval from' name='legalApproval' isChecked=reportSummaryInitiation.legalApproval?default(false) isMandatory=true/>
                    <input type="text" name="legalApprover" id="legalApprover" autocomplete="off" value="${reportSummaryInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >
                </div></div>
            <#elseif isSPIContactUser || isAboveMarketProjectContact || isExternalAgencyUser >
            <div id="legal-box-main">
                <div class="legal-checkbox-container">
                    <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved>
                        <@renderLegalPIBCheckBox label='Legal Approval from' name='legalApproval' isChecked=reportSummaryInitiation.legalApproval?default(false) disable=true isMandatory=true/>
                        <input type="text" name="legalApprover" id="legalApprover" disabled autocomplete="off" value="${reportSummaryInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >
                    <#else>
                        <@renderLegalPIBCheckBox label='Legal Approval from' name='legalApproval' isChecked=reportSummaryInitiation.legalApproval?default(false) isMandatory=true/>
                        <input type="text" name="legalApprover" id="legalApprover" autocomplete="off" value="${reportSummaryInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >
                    </#if>
                </div></div>
            </#if>
        <#elseif !(isAboveMarket) && endMarketStatus?? && endMarketStatus==statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].CANCEL.ordinal() >

            <#if isAdminUser>
            <div id="legal-box-main">
                <div class="legal-checkbox-container">
                    <@renderLegalPIBCheckBox label='Legal Approval from' name='legalApproval' isChecked=reportSummaryInitiation.legalApproval?default(false)/>
                    <input type="text" name="legalApprover" id="legalApprover" autocomplete="off" value="${reportSummaryInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >
                </div></div>
            <#elseif isCountryProjectContact || isCountrySPIContact >
            <div id="legal-box-main">
                <div class="legal-checkbox-container">
                    <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved>
                        <@renderLegalPIBCheckBox label='Legal Approval from' name='legalApproval' isChecked=reportSummaryInitiation.legalApproval?default(false) disable=true/>
                        <input type="text" name="legalApprover" id="legalApprover" disabled autocomplete="off" value="${reportSummaryInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >
                    <#else>
                        <@renderLegalPIBCheckBox label='Legal Approval from' name='legalApproval' isChecked=reportSummaryInitiation.legalApproval?default(false) disable=true/>
                        <input type="text" name="legalApprover" id="legalApprover" disabled autocomplete="off" value="${reportSummaryInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >
                    </#if>
                </div></div>
            </#if>
        <#else>

            <#if isAdminUser>
            <div id="legal-box-main">
                <div class="legal-checkbox-container">
                    <@renderLegalPIBCheckBox label='Legal Approval from' name='legalApproval' isChecked=reportSummaryInitiation.legalApproval?default(false)/>
                    <input type="text" name="legalApprover" id="legalApprover" autocomplete="off" value="${reportSummaryInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >
                </div></div>
            <#elseif isCountryProjectContact || isCountrySPIContact || isProjectOwner >
            <div id="legal-box-main">
                <div class="legal-checkbox-container">
                    <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved>
                        <@renderLegalPIBCheckBox label='Legal Approval from' name='legalApproval' isChecked=reportSummaryInitiation.legalApproval?default(false) disable=true/>
                        <input type="text" name="legalApprover" id="legalApprover" disabled autocomplete="off" value="${reportSummaryInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >
                    <#else>
                        <@renderLegalPIBCheckBox label='Legal Approval from' name='legalApproval' isChecked=reportSummaryInitiation.legalApproval?default(false)/>
                        <input type="text" name="legalApprover" id="legalApprover" autocomplete="off" value="${reportSummaryInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >
                    </#if>
                </div></div>
            </#if>
        </#if>
    <#else>
        <#if (isSPIContactUser || isExternalAgencyUser || isProjectOwner) && !(isAdminUser)>
        <div id="legal-box-main">
            <div class="legal-checkbox-container">
                <#if reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved>
                    <@renderLegalPIBCheckBox label='Legal Approval from' name='legalApproval' isChecked=reportSummaryInitiation.legalApproval?default(false) disable=true isMandatory=true/>
                    <input type="text" name="legalApprover" id="legalApprover" disabled autocomplete="off" value="${reportSummaryInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >
                <#else>
                    <@renderLegalPIBCheckBox label='Legal Approval from' name='legalApproval' isChecked=reportSummaryInitiation.legalApproval?default(false) isMandatory=true/>
                    <input type="text" name="legalApprover" id="legalApprover" autocomplete="off" value="${reportSummaryInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >
                </#if>
            </div></div>
        </#if>

        <#if isAdminUser >
        <div id="legal-box-main">
            <div class="legal-checkbox-container">
                <@renderLegalPIBCheckBox label='Legal Approval from' name='legalApproval' isChecked=reportSummaryInitiation.legalApproval?default(false) isMandatory=true/>
                <input type="text" name="legalApprover" id="legalApprover" autocomplete="off" value="${reportSummaryInitiation.legalApprover?default('')?html}" size="30" class="form-text-div" >
            </div></div>
        </#if>

    <#-- <#if isSPIContactUser || isProjectOwner || isExternalAgencyUser>
        <@renderLegalCheckBox label='IRIS Oracle Summary Uploaded' name='uploadedSummary' isChecked=reportSummaryInitiation.uploadedSummary?default(false)/>
       <@renderLegalCheckBox label='IRIS Oracle Summary uploaded available for SP&I' name='irisOracleSummary' isChecked=reportSummaryInitiation.irisOracleSummary?default(false)/>
    </#if>
    -->
    </#if>


<#else>
    <@renderProjectActionStages stageToDoList=stageToDoList stageId=stageId docId=document.ID?c projectID=projectID?c />
</#if>

<!-- END SYNCHRO -->


<#if stageId!=1 && stageId !=2 >
<div class="sidebar-approve-dates">
    <div class="approve-heading">
        <div class="approves">Approvers</div>
        <div>Date</div>
    </div>
    <div class="approve-list">
        <div class="approve-left">
            <ul>
                <#list approvers.entrySet() as entry>
                    <#if entry.value??>
                    <#-- <li class="approved"><span>${entry.key}</span></li>-->
                        <li><span>${entry.key}</span></li>
                    <#else>
                    <#--<li class="unapproved"><span>${entry.key}</span></li> -->
                        <li><span>${entry.key}</span></li>
                    </#if>
                </#list>
            </ul>
        </div>
        <div class="approve-dates">
            <ul>
                <#list approvers.entrySet() as entry>
                    <#if entry.value??>
                        <li>${entry.value}</li>
                    <#else>
                        <li>&nbsp;</li>
                    </#if>
                </#list>
            </ul>
        </div>
    </div>
</div>

</#if>


<!-- Project Change Status Action -->
<#if project.multiMarket?? && project.multiMarket  >
    <#if statics['com.grail.synchro.util.SynchroPermHelper'].canEditMultimarketProject(user, projectID)>
        <@renderChangeStatusAction label='Change Project Status' projectID=projectID multimarket=true changeStatus=true/>
	<#else>
		<@renderChangeStatusAction label='Change Project Status' projectID=projectID multimarket=true changeStatus=false/>
    </#if>
<#else>
    <#if statics['com.grail.synchro.util.SynchroPermHelper'].canEditproject(user, projectID)>
        <@renderChangeStatusAction label='Change Project Status' projectID=projectID  multimarket=false changeStatus=true/>
	<#else>
		<@renderChangeStatusAction label='Change Project Status' projectID=projectID multimarket=false changeStatus=false/>
    </#if>
</#if>

</div>

</div>



<#if stageId==5 && document.getProperties().containsKey("stage.status")>
<div class="sidebar-approve-dates">
    <div class="approve-heading">
        <div class="approves">Payment Order</div>
    </div>
    <#assign isExternalAgencyUser = statics['com.grail.synchro.util.SynchroPermHelper'].isExternalAgencyUser(projectID) || statics['com.grail.synchro.util.SynchroPermHelper'].isCommunicationAgencyUser(projectID) />
    <#if document.getProperties().get("stage.status").equals(statics['com.grail.synchro.SynchroGlobal$StageStatus'].STARTED.name()) && !isExternalAgencyUser>
        <#assign stageBudgetApprovers = jiveContext.getSpringBean("stageManager").getStageBudgetApproversPONum(document.ID?c,stageId?c,projectID?c) >

        <#list stageBudgetApprovers as budgetAppPoNum>
            <div class="budget-approver-box">
                <span class="bab-heading">${jiveContext.getSpringBean("userManager").getUser(budgetAppPoNum.getBudgetApproverId()?number).getName()}</span>
                <div class="box-inside">
                    <form  id="form_PONUM_${budgetAppPoNum.getBudgetApproverId()}" action="<@s.url value='activity!savePONumber.jspa' />" method="POST">
                        <#if budgetAppPoNum.getPoNum()??>
                            <span>PO Raised </span><input id="poCheckBox${budgetAppPoNum.getBudgetApproverId()}" name="poCheckBox${budgetAppPoNum.getBudgetApproverId()}" type="checkbox" <#if budgetAppPoNum.isPoCheckBox()> checked </#if>  >
                            <span class="po-number">PO Number </span><input type="text" id="poNumber${budgetAppPoNum.getBudgetApproverId()}" name="poNumber${budgetAppPoNum.getBudgetApproverId()}" value="${budgetAppPoNum.getPoNum()}" class="form-text">
                            <a href="javascript:void(0);" class="save" id="savePO" name="savePO" onClick="savePONumber(${budgetAppPoNum.getBudgetApproverId()});">SAVE</a>
                        <#else>
                            <span>PO Raised </span><input id="poCheckBox${budgetAppPoNum.getBudgetApproverId()}" name="poCheckBox${budgetAppPoNum.getBudgetApproverId()}" type="checkbox"  <#if budgetAppPoNum.isPoCheckBox()> checked </#if>>
                            <span class="po-number">PO Number </span><input type="text" id="poNumber${budgetAppPoNum.getBudgetApproverId()}" name="poNumber${budgetAppPoNum.getBudgetApproverId()}" value="" class="form-text">
                            <a href="javascript:void(0);" class="save" id="savePO" name="savePO" onClick="savePONumber(${budgetAppPoNum.getBudgetApproverId()});">SAVE</a>
                        </#if>
                        <input type="hidden" name="docId" value="${document.ID?c}" />
                        <input type="hidden" name="projectID" value="${projectID?c}" />
                        <input type="hidden" name="bugAppId" value="${budgetAppPoNum.getBudgetApproverId()}" />
                    </form>
                </div>
            </div>
        </#list>
    <#elseif document.getProperties().get("stage.status").equals(statics['com.grail.synchro.SynchroGlobal$StageStatus'].COMPLETED.name()) || isExternalAgencyUser>
        <#assign stageBudgetApprovers = jiveContext.getSpringBean("stageManager").getStageBudgetApproversPONum(document.ID?c,stageId?c,projectID?c) >
        <#list stageBudgetApprovers as budgetAppPoNum>
            <div class="budget-approver-box">
                <span class="bab-heading">${jiveContext.getSpringBean("userManager").getUser(budgetAppPoNum.getBudgetApproverId()?number).getName()}</span>
                <div class="box-inside">
                    <#if budgetAppPoNum.getPoNum()??>
                        <span>PO Raised </span><input id="poCheckBox${budgetAppPoNum.getBudgetApproverId()}" name="poCheckBox${budgetAppPoNum.getBudgetApproverId()}" type="checkbox" disabled <#if budgetAppPoNum.isPoCheckBox()> checked </#if>  >
                        <span class="po-number">PO Number </span><input type="text" id="poNumber${budgetAppPoNum.getBudgetApproverId()}" name="poNumber${budgetAppPoNum.getBudgetApproverId()}" value="${budgetAppPoNum.getPoNum()}" disabled class="form-text">
                    <#else>
                        <span>PO Raised </span><input id="poCheckBox${budgetAppPoNum.getBudgetApproverId()}" name="poCheckBox${budgetAppPoNum.getBudgetApproverId()}" type="checkbox" disabled  <#if budgetAppPoNum.isPoCheckBox()> checked </#if>>
                        <span class="po-number">PO Number </span><input type="text" id="poNumber${budgetAppPoNum.getBudgetApproverId()}" name="poNumber${budgetAppPoNum.getBudgetApproverId()}" value="" disabled class="form-text">
                    </#if>
                </div>
            </div>
        </#list>
    </#if>

</div>
</#if>


<script type="text/javascript">

function extractPIBExcel(projectId)
{
    window.location.href = "/synchro/pib-details!extractPIBExcel.jspa?projectID="+projectId;
}
function exportPIBWord(projectId)
{
	<!-- Audit Logs -->
	<#assign projectExportWordText><@s.text name="logger.project.export.word" /></#assign>
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PIB.getId()}, "${projectExportWordText}", "${project.name}", ${projectID?c}, ${user.ID?c});
	
    window.location.href = "/synchro/pib-details!exportToWordPIB.jspa?projectID="+projectId;
}

function exportPDF(projectId, pdfType, agencyId)
{
    if(pdfType=="PIB")
    {
        $j("#pdfFileName").val("${statics['com.grail.synchro.SynchroGlobal$PDFDocumentName'].getById(1)}");
        clickAndPostScreenshot('project_name_div');
		
	<!-- Audit Logs -->
	<#assign projectExportPDFText><@s.text name="logger.project.export.pdf" /></#assign>
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PIB.getId()}, "${projectExportPDFText}", "${project.name}", ${projectID?c}, ${user.ID?c});
    }
    else if(pdfType=="Proposal")
    {
        $j("#pdfFileName").val("${statics['com.grail.synchro.SynchroGlobal$PDFDocumentName'].getById(2)}");
        clickAndPostScreenshot('project_name_div');
		
		<!-- Audit Logs -->
	<#assign projectExportPDFText><@s.text name="logger.project.export.pdf" /></#assign>
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROPOSAL.getId()}, "${projectExportPDFText}", "${project.name}", ${projectID?c}, ${user.ID?c});
    }
    else if(pdfType=="ProjectSpecs")
    {
        $j("#pdfFileName").val("${statics['com.grail.synchro.SynchroGlobal$PDFDocumentName'].getById(3)}");
        clickAndPostScreenshot('project_name_div');
		
		<!-- Audit Logs -->
	<#assign projectExportPDFText><@s.text name="logger.project.export.pdf" /></#assign>
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_SPECS.getId()}, "${projectExportPDFText}", "${project.name}", ${projectID?c}, ${user.ID?c});
    }
    else if(pdfType=="ReportSummary")
    {
        $j("#pdfFileName").val("${statics['com.grail.synchro.SynchroGlobal$PDFDocumentName'].getById(4)}");
        clickAndPostScreenshot('project_name_div');
		
		<!-- Audit Logs -->
	<#assign projectExportPDFText><@s.text name="logger.project.export.pdf" /></#assign>
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].REPORT_SUMMARY.getId()}, "${projectExportPDFText}", "${project.name}", ${projectID?c}, ${user.ID?c});
    }

}

function clickAndPostScreenshot(classname)
{
	cookieTimer();
    var errorMessageList = hidePanels();
    var selectConfiguredListMultiple = configureMultiselectList();
    var selectConfiguredListSingle = configureSingleSelectList();
    var textFieldsList = configureTextFields();
    var textBoxList = convertTextBoxes();
    configureLegalBox();
    jQuery('.'+classname).html2canvas({
        onrendered: function (canvas) {
            $j("#pdf_img_screen").val(canvas.toDataURL("image/png"));
            showPanels(errorMessageList);
            resetMultiselectList(selectConfiguredListMultiple);
            resetSingleSelectList(selectConfiguredListSingle);
            resetTextFields(textFieldsList);
            resetTextBoxes(textBoxList);
            resetLegalBox();

            try{
                var url = window.location.pathname+window.location.href.slice(window.location.href.indexOf('?'));
                if(url!=null && url.indexOf('synchro/')!=-1)
                {
                    var redirecturl = url.slice(url.indexOf('synchro/')+8);
                    $j("#redirectURL").val(redirecturl);
                }
            }catch(err){console.log(err);}
            hideLoader();
            $j("#pdf_img_screen_form").submit();
        }
    });
}

function convertTextBoxes()
{
    var textBoxList = [];
    var textBoxListCounter = 0;
    /*$j("textarea").each(function(i) {
             if($j(this).is(":visible"))
             {
                 var $textareaid = $j(this).attr("id");
                 var customTextBoxDiv = "<div class='pdf-textarea-div' style='float:right;width:98.6%;border: 1px solid #e5e5e5;margin: 10px 0 20px 0px;padding: 8px 0 10px 8px;border-radius:3px;font-family:monospace;' id='"+$textareaid+"-displayDiv' name='"+$textareaid+"-displayDiv'></div>";
                 $j(this).parent().append(customTextBoxDiv);
                 var divid = $textareaid+"-displayDiv";
                 $j("div#"+divid).html($j(this).val());
                 $j(this).hide();
                 textBoxList[textBoxListCounter++] = $textareaid;
             }
             });
             */
   /* for (var i in CKEDITOR.instances) {
        var editorNAME = CKEDITOR.instances[i].name;
        var parentDIV = $j("textarea[name="+editorNAME+"]").parent();
        var customTextBoxDiv = "<div class='pdf-textarea-div' style='float:right;width:98.6%;border: 1px solid #e5e5e5;margin: 10px 0 20px 0px;padding: 8px 0 10px 8px;border-radius:3px;font-family:monospace;' id='"+editorNAME+"-displayDiv' name='"+editorNAME+"-displayDiv'></div>";
        parentDIV.append(customTextBoxDiv);
        var divid = editorNAME+"-displayDiv";
        $j("div#"+divid).html(CKEDITOR.instances[i].getData());
        $j("#cke_"+editorNAME).hide();
        textBoxList[textBoxListCounter++] = editorNAME;
    } */
	if(tinymce)
	{
		for(i=0; i<tinymce.editors.length; i++){
			var content = tinymce.editors[i].getContent();
			console.log(tinymce.editors[i].id + " - " + content);
			
			var editorNAME = tinymce.editors[i].id;
			var parentDIV = $j("textarea[name="+editorNAME+"]").parent();
			var customTextBoxDiv = "<div class='pdf-textarea-div' style='float:right;width:98.6%;border: 1px solid #e5e5e5;margin: 10px 0 20px 0px;padding: 9px 9px 9px 5px;border-radius:3px;font-family:monospace;' id='"+editorNAME+"-displayDiv' name='"+editorNAME+"-displayDiv'></div>";
			parentDIV.append(customTextBoxDiv);
			var divid = editorNAME+"-displayDiv";
			$j("div#"+divid).html(content);
			removeDefaultListFormatting(divid);
			//$j("#cke_"+editorNAME).hide();
			if($j("#"+editorNAME).length > 0 && $j("#"+editorNAME).prev().hasClass('mce-container'))
			{
				$j("#"+editorNAME).prev().hide();
			}
			textBoxList[textBoxListCounter++] = editorNAME;
		}
	}	 
	
    return textBoxList;
}

function removeDefaultListFormatting(divid)
{
	var content = $j("div#"+divid).html();
	if(content)
	{		
		$j("div#" + divid + " li").css("list-style","inherit");
		$j("div#" + divid + " ol").css("margin-left","35px");
		$j("div#" + divid + " ol").css("list-style-position","inside");
		$j("div#" + divid + " ul").css("margin-left","35px");	
	
	/*$j("div#" + divid + " ul li").each(function() {
		var parent = $j(this).parent();		
		if(parent && parent.attr("style") && parent.attr("style").indexOf("disc")!=-1)
		{
			$j(this).html("<lid style='margin:0 6px 0 -16px;'>&#149;</lid>" + $j(this).html());
			$j("div#" + divid + " ul").css("margin-left","50px");
		}
		else if(parent && parent.attr("style") && parent.attr("style").indexOf("circle")!=-1)
		{
			$j(this).html("<lid style='margin:0 6px 0 -16px;'>&#129;</lid>" + $j(this).html());
			$j("div#" + divid + " ul").css("margin-left","50px");
		}		
		else if(parent && parent.attr("style") && parent.attr("style").indexOf("list-style-type")==-1)
		{
			$j(this).html("<lid style='margin:0 6px 0 -16px;'>&#149;</lid>" + $j(this).html());
			$j("div#" + divid + " ul").css("margin-left","50px");
		}
		
	});
	
	$j("div#" + divid + " ol li").each(function() {
		var parent = $j(this).parent();		
		if(parent && parent.attr("style") && parent.attr("style").indexOf("square")!=-1)
		{
			$j(this).html("<lid style='margin:0 6px 0 -16px;'>&#9642;</lid>" + $j(this).html());
			$j("div#" + divid + " ul").css("margin-left","50px");
		}		
	});
	*/
	$j("div#" + divid + " li").each(function() {
		//console.log("li -- > ol - " + $j(this).html() +" - " + $j(this).parent().is("ol"));
		//console.log("li -- > ul - " + $j(this).html() +" - " + $j(this).parent().is("ul"));
		
		if($j(this).parent().is("ul"))
		{
			var parent = $j(this).parent();		
			if(parent && parent.attr("style") && parent.attr("style").indexOf("disc")!=-1)
			{
				$j(this).html("<lid style='margin:0 6px 0 -16px;'>&#149;</lid>" + $j(this).html());
				$j("div#" + divid + " ul").css("margin-left","50px");
			}
			else if(parent && parent.attr("style") && parent.attr("style").indexOf("circle")!=-1)
			{
				$j(this).html("<lid style='margin:0 6px 0 -16px;'>&#176;</lid>" + $j(this).html());
				$j("div#" + divid + " ul").css("margin-left","50px");
			}		
			else if(parent && parent.attr("style") && parent.attr("style").indexOf("list-style-type")==-1)
			{
				$j(this).html("<lid style='margin:0 6px 0 -16px;'>&#149;</lid>" + $j(this).html());
				$j("div#" + divid + " ul").css("margin-left","50px");
			}
		}
		else if($j(this).parent().is("ol"))
		{
			var parent = $j(this).parent();		
			if(parent && parent.attr("style") && parent.attr("style").indexOf("square")!=-1)
			{
				$j(this).html("<lid style='margin:0 6px 0 -16px;'>&#9642;</lid>" + $j(this).html());
				$j("div#" + divid + " ul").css("margin-left","50px");
			}	
		}
	});	
	}
}
	
function resetTextBoxes(textBoxList)
{
    if(textBoxList!=undefined)
    {
        for(var i=0; i<textBoxList.length; i++)
        {
            //$j("#cke_"+textBoxList[i]).show();
			if($j("#"+textBoxList[i]).length > 0 && $j("#"+textBoxList[i]).prev().hasClass('mce-container'))
			{
				$j("#"+textBoxList[i]).prev().show();
			}
            $j("#"+textBoxList[i]+"-displayDiv").remove();
        }
    }
}


function hidePanels()
{
    var logoheader = $j("<div id='export-pdf-logo'><img height='70' src='${themePath}/images/synchro/export-pdf-logo.jpg' /></div>");
    $j(".project_name_div").prepend(logoheader);

    var containerwidth = $j(".research_content").width();
    $j("#export-pdf-logo").next().css("width",(containerwidth)+"px");
    $j("#export-pdf-logo").next().css("text-align", "center");

    var errorMessageList = [];
    $j(".print-btn").css('display','none');
    $j(".right-sidebar-list").css('display','none');
    $j(".required-actions").css('visibility','hidden');
    $j(".sidebar-approve-dates").css('visibility','hidden');
    $j(".save").css('display','none');
    $j(".character-limit").css('display','none');
    $j(".pib-multi-country").css('display','none');

    //Calender
    $j(".j-form-datepicker-btn").hide();
    $j(".jive-chooser-browse").hide();
    $j(".induction_text").hide();

    //Attachments
    $j(".field-attachments").hide();
    $j(".jive-icon-attachment").hide();
    $j(".jive-attachments").hide();


    //Check endmarket tabs are there
    if($j(".endmarket-menus").length>0)
    {
        $j(".endmarket-menus ul.main-sub-menus li a").each(function(i) {
            if(!$j(this).hasClass("active"))
            {
                $j(this).parent().css('visibility','hidden');
            }
        });
    }

    //Open Endmarket panels
    $j(".end_market_details h3").each(function(i) {
        if(!$j(this).next().is(":visible"))
        {
            var blockheaderid = $j(this).attr("id");
            if(blockheaderid!=null)
            {
                if(blockheaderid.indexOf('block_header_')!=-1)
                {
                    var blockendmarketid = blockheaderid.slice(blockheaderid.indexOf('block_header_')+13);
                    try{
                        var blockendmarketidInteger = parseInt(blockendmarketid);
                        if(blockendmarketidInteger!=null && blockendmarketidInteger>0)
                        {
                            toggleEndmarketBlock(blockendmarketidInteger);
                        }
                    }catch(err){}
                }
            }
        }
    });



    //Handle error messages
    var message_index = 0;
    $j('[id^=synchro-error-]').each(function(i) {
        var elementID = $j(this).attr("id");
        if(elementID!=null && elementID.indexOf("synchro-error")!=-1)
        {
            var indexNumber = elementID.slice(elementID.indexOf("synchro-error")+14);
            if(parseInt(indexNumber)>message_index)
            {
                message_index = parseInt(indexNumber) + 1;
            }
        }
    });

    var indexCounter = 0
    $j(".jive-error-message").each(function(i) {
        if($j(this).is(":visible"))
        {
            var generated_id = "synchro-error-"+message_index;
            if($j(this).attr("id")=="")
            {
                $j(this).attr("id", generated_id);
                message_index = message_index + 1;
            }
            else
            {
                generated_id = $j(this).attr("id");
            }

            errorMessageList[indexCounter++] = generated_id;
            $j("#"+generated_id).hide();
        }
    });

    $j("#jive-error-box").each(function(i) {

        if($j(this).is(":visible"))
        {
            var generated_id = "synchro-error-"+message_index;
            if($j(this).attr("id")=="")
            {
                $j(this).attr("id", generated_id);
                message_index = message_index + 1;
            }
            else
            {
                generated_id = $j(this).attr("id");
            }

            errorMessageList[indexCounter++] = generated_id;
            $j("#"+generated_id).hide();
        }
    });

    /*Hide Action buttons*/
    $j(".action_buttons").hide();
    $j(".data-collection-all-div").each(function(i) {
        $j(this).find("span").hide();
    });

    return errorMessageList;
}

function configureMultiselectList()
{
    var selectConfiguredList = [];
    var selectConfiguredListCounter = 0;
    $j("select").each(function(i) {
        if($j(this).is(":visible") && ($j(this).attr("multiple") || $j(this).attr("size")>1))
        {
            var $select = $j(this);
            var selectid = $j(this).attr("id");
            var selectname = $j(this).attr("name");
            if(selectid && selectid!="")
            {
                var selectsize = $j("#"+selectid+" option").size();
                var optionCounter = 1;
                if($j(this).hasClass('endmarket-multiple-select'))
                {
                    var selectList = "<ul id='"+selectid+"-displaylist' style='list-style-type:none; margin-top:10px; float:left; width:182px; border:1px solid #e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control; margin-bottom:15px;'>";
                }
                else
                {
                    var selectList = "<ul id='"+selectid+"-displaylist' style='list-style-type:none; float:left; width:182px; border:1px solid #e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control;'>";
                }

                if((selectedCategoryList && typeof selectedCategoryList !== 'undefined') && selectid=="categoryType")
                {
                    selectsize = 0;
                    $j.each(selectedCategoryList, function( index, value ) {
                        selectsize = selectsize + 1;
                    });


                    for(var i=0; i<selectsize; i++)
                    {
                        if(selectsize==1 && optionCounter==1)
                        {
                            selectList = selectList + "<li style='padding-left:7px;padding-top:6px;padding-bottom:6px;'>"+selectedCategoryList[i]+"</li>";
                        }
                        else if(optionCounter==1)
                        {
                            selectList = selectList + "<li style='padding-left:7px;padding-top:6px;'>"+selectedCategoryList[i]+"</li>";
                        }
                        else if(optionCounter==selectsize)
                        {
                            selectList = selectList + "<li style='padding-left:7px;padding-bottom:6px;'>"+selectedCategoryList[i]+"</li>";
                        }
                        else
                        {
                            selectList = selectList + "<li style='padding-left:7px;'>"+selectedCategoryList[i]+"</li>";
                        }
                        optionCounter++;
                    }
                }
                else if(selectid=="proposedMethodology" && selectedProposedMethList !== undefined)
                {

                    selectsize = 0;
                    $j.each(selectedProposedMethList, function( index, value ) {
                        selectsize = selectsize + 1;
                    });

                    for(var i=0; i<selectsize; i++)
                    {
                        if(selectsize==1 && optionCounter==1)
                        {
                            selectList = selectList + "<li style='padding-left:7px;padding-top:6px;padding-bottom:6px'>"+selectedProposedMethList[i]+"</li>";
                        }
                        else if(optionCounter==1)
                        {
                            selectList = selectList + "<li style='padding-left:7px;padding-top:6px;'>"+selectedProposedMethList[i]+"</li>";
                        }
                        else if(optionCounter==selectsize)
                        {
                            selectList = selectList + "<li style='padding-left:7px;padding-bottom:6px;'>"+selectedProposedMethList[i]+"</li>";
                        }
                        else
                        {
                            selectList = selectList + "<li style='padding-left:7px;'>"+selectedProposedMethList[i]+"</li>";
                        }
                        optionCounter++;
                    }
                }
                else
                {
                    $j("#"+selectid+" option").each(function()
                    {
                        if(selectsize==1 && optionCounter==1)
                        {
                            selectList = selectList + "<li style='padding-left:7px;padding-top:6px;padding-bottom:6px'>"+$j(this).text()+"</li>";
                        }
                        else if(optionCounter==1)
                        {
                            selectList = selectList + "<li style='padding-left:7px;padding-top:6px;'>"+$j(this).text()+"</li>";
                        }
                        else if(optionCounter==selectsize)
                        {
                            selectList = selectList + "<li style='padding-left:7px;padding-bottom:6px;'>"+$j(this).text()+"</li>";
                        }
                        else
                        {
                            selectList = selectList + "<li style='padding-left:7px;'>"+$j(this).text()+"</li>";
                        }
                        optionCounter++;

                    });
                    if(optionCounter==1)
                    {
                        selectList = selectList + "<li style='padding-left:7px;padding-top:6px;padding-bottom:6px;'>Not Applicable</li>";
                    }
                }

                selectList = selectList + "</ul>";

                if(selectname=="availableDataCollection")
                {

                    //Do nothing
                }
                /*else if(selectname.indexOf('dataCollectionMethod')!=-1)
                        {
                            $select.parent().parent().children(":first").append(selectList);
                        }*/
                else
                {
                    $select.parent().append(selectList);
                }
                $select.hide();
                selectConfiguredList[selectConfiguredListCounter++] = selectid;
            }
        }
    });

    return selectConfiguredList;
}

function configureSingleSelectList()
{
    var selectConfiguredList = [];
    var selectConfiguredListCounter = 0;
    $j("select").each(function(i) {
        //$j(this).attr("multiple") || $j(this).attr("size")>1
        if($j(this).is(":visible") && !$j(this).attr("multiple") && $j(this).attr("size")<=1)
        {
            var $select = $j(this);
            var selectid = $j(this).attr("id");
            var selectname = $j(this).attr("name");
            if(selectid && selectid!="")
            {
                if($j(this).hasClass('form-select'))
                {
                    var selectWidth = 180;
                }
                else if($j(this).hasClass('select_field'))
                {
                    $j(this).prev().css('float','left');
                    var selectWidth = 80;
                }

                if($j(this).parent().parent().hasClass('pib_left'))
                {
                    var selectList = "<ul id='"+selectid+"-displaylist' style='margin: 6px 0 6px 0;list-style-type:none; width:"+selectWidth+"px; float:left;border:1px solid #e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control;'>";
                }
                else if($j(this).parent().parent().hasClass('pib_right'))
                {
                    if($j(this).hasClass('select_field'))
                    {
                        var selectList = "<ul id='"+selectid+"-displaylist' style='list-style-type:none;margin-left:10px;width:"+selectWidth+"px; float:left;border:1px solid #e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control;'>";
                    }
                    else
                    {
                        var selectList = "<ul id='"+selectid+"-displaylist' style='list-style-type:none; width:"+selectWidth+"px; float:left;border:1px solid #e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control;'>";
                    }

                }
                else
                {

                    if($j(this).hasClass('select_field'))
                    {
                        var selectList = "<ul id='"+selectid+"-displaylist' style='list-style-type:none;margin-left:10px; width:"+selectWidth+"px; float:left;border:1px solid #e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control;'>";
                    }
                    else
                    {
                        var selectList = "<ul id='"+selectid+"-displaylist' style='list-style-type:none; width:"+selectWidth+"px; float:left;border:1px solid #e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control;'>";
                    }

                }


                selectList = selectList + "<li style='padding-left:7px;padding-top:6px;padding-bottom:6px;'>"+$j(this).find('option:selected').text()+"</li>";

                selectList = selectList + "</ul>";
                $select.parent().append(selectList);

                $select.hide();
                selectConfiguredList[selectConfiguredListCounter++] = selectid;
            }
        }
    });

    return selectConfiguredList;
}

function resetMultiselectList(selectConfiguredList)
{
    for(var i=0; i<selectConfiguredList.length; i=i+1 ) {
        $j("#"+selectConfiguredList[i]).show();
        $j("#"+selectConfiguredList[i]+"-displaylist").remove();
    }
}

function resetSingleSelectList(selectConfiguredList)
{
    for(var i=0; i<selectConfiguredList.length; i=i+1 ) {
        $j("#"+selectConfiguredList[i]).show();
        $j("#"+selectConfiguredList[i]+"-displaylist").remove();
    }
}
function configureTextFields()
{
    var textConfiguredList = [];
    var textConfiguredListCounter = 0;
    $j("input[name^=proposedFWAgencyNames]").each(function(i) {
        if($j(this).is(":visible"))
        {
            var $input = $j(this);
            var $inputid = $j(this).attr("id");
            var $inputname = $j(this).attr("name");
            var customTextField = "<textarea id='"+$inputname+"-displayList' name='"+$inputname+"-displayList'>"+$j(this).val()+"</textarea>";
            $input.parent().append(customTextField);
            $input.hide();
            textConfiguredList[textConfiguredListCounter++] = $inputname;
            autoAdjustTextAreaHeight($inputname + "-displayList");
        }
    });

    $j(".pib_detail_st_list").find("input[type=text]").each(function(i) {
        if($j(this).hasClass('j-ui-elem'))
        {

            $j(this).removeClass('j-ui-elem');
        }
    });

    return textConfiguredList;
}

function autoAdjustTextAreaHeight(textareaid)
{
    var $textarea = $j("#"+textareaid);
    var textareafld = document.getElementById(textareaid);
    var textHeight = $textarea[0].scrollHeight;
    var textboxHeight = $textarea.height();

    if (textareafld.clientHeight < textareafld.scrollHeight) {
        $textarea.height( $textarea[0].scrollHeight-10);
    }
    else
    {
        $textarea.height(0);
        var scrollval = $textarea[0].scrollHeight-10;
        $textarea.height(scrollval);
    }

    $textarea.elastic();
}
function resetTextFields(textConfiguredList)
{
    for(var i=0; i<textConfiguredList.length; i=i+1 ) {
        $j("input[name="+textConfiguredList[i]+"]").show();
        $j("#"+textConfiguredList[i]+"-displayList").remove();
    }
    $j(".pib_detail_st_list").find("input[type=text]").each(function(i) {
        if(!$j(this).hasClass('j-ui-elem'))
        {
            $j(this).addClass('j-ui-elem');
        }
    });
}

function configureLegalBox()
{
    if($j(".legal-checkbox-container")==undefined || $j(".legal-checkbox-container").length==0)
        return;
    var legalPreviewElement = $j("<div id='legal-preview-box'><label class='label_b'>Legal Approval</label></div>");
    legalPreviewElement.append($j(".legal-checkbox-container"));
    $j(".research_content").append(legalPreviewElement);
}

function resetLegalBox()
{
    if($j(".legal-checkbox-container")==undefined || $j(".legal-checkbox-container").length==0)
        return;
    $j("#legal-box-main").append($j(".legal-checkbox-container"));
    $j("#legal-preview-box").remove();
}

function showPanels(errorMessageList)
{
    $j("#export-pdf-logo").next().removeAttr("style");
    $j("#export-pdf-logo").remove();

    $j(".print-btn").css('display','block');
    $j(".right-sidebar-list").css('display','block');
    $j(".required-actions").css('visibility','visible');
    $j(".sidebar-approve-dates").css('visibility','visible');
    $j(".save").css('display','block');
    $j(".character-limit").css('display','block');
    $j(".pib-multi-country").css('display','block');

    //Calender
    $j(".j-form-datepicker-btn").css('visibility','visible');
    $j(".jive-chooser-browse").show();
    $j(".induction_text").show();

    //Attachments
    $j(".field-attachments").show();
    $j(".jive-icon-attachment").show();
    $j(".jive-attachments").show();

    //Check endmarket tabs are there
    if($j(".endmarket-menus").length>0)
    {
        $j(".endmarket-menus ul.main-sub-menus li a").each(function(i) {
            if(!$j(this).hasClass("active"))
            {
                $j(this).parent().css('visibility','visible');
            }
        });
    }



    //Show error messages
    if(errorMessageList!=undefined)
    {
        for ( var i=0; i<errorMessageList.length; i = i+1 ) {
            $j("#"+errorMessageList[i]).show();
        }
    }


    /*Show Action buttons*/
    $j(".action_buttons").show();
    $j(".data-collection-all-div").each(function(i) {
        $j(this).find("span").show();
    });

}

function cookieTimer()
{
    //var cookie_name = $j("#report-token-cookie").val();
    //var token = $j("#report-token").val();
    showLoader('Exporting to PDF...');
    $j("#jquery-loader-background").css("opacity", "1");
    /*var timerId = 0;
         timerId = window.setInterval(function(){
         if(readCookie(cookie_name)!=null && readCookie(cookie_name)==token)
         {
             clearInterval(timerId);
             hideLoader();
             eraseCookie(cookie_name);
         }
         }, 100);
         */
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

function eraseCookie(name) {

    document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}

function openAttachmentWindow()
{
    //$j("#attachmentWindow").show();
    //attachmentWindow.show();
}
function submitProposal(projectId)
{
//        alert(projectId)
//        FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#proposal-form"),form:$j("#submit-proposal-form"), projectID:projectId});
    var form = $j("#submit-proposal-form");
    if(validatePIBFormFields())
    {
//          form.submit();
        FORM_DATA_PERSIST_HANDLER.saveForms($j("#proposal-form"),form, projectId);
    }
}

/**
 Award Agency with Custom dialog box
 function awardAgency()
 {



 dialog({
 title: 'Confirm',
 html: '<p>Are you sure you want to award the project to this agency? You will not be able to undo this action later.</p>',
 buttons:{
 "Yes":function() {
 showLoader('Please wait...');
 var form = $j("#awardAgency-form");
 form.submit();
 },
 "No": function() {
 closeDialog();
 }
 }
 });

 return false;
 }
 **/

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

function awardAgencySM()
{
	<#if attachmentMap?? && attachmentMap.get(propCostTemplateID)?? && (attachmentMap.get(propCostTemplateID)?size>0) >
	 	
	   <#-- dialog({
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
	
	    });-->
	    var form = $j("#awardAgency-form");
	    form.submit();
    <#else>
    	{
			dialog({title:"Message",html:"Please attach the proposal and agency wise break-up for coordination and fieldwork costs in the provided template."});
            return false;
		}
    </#if>
    return false;
}

function rejectAgency()
{
    var form = $j("#rejectAgency-form");
    form.submit();
}
function savePONumber(poIndex){

    var form = $j("#form_PONUM_"+poIndex);
    form.submit();

}
function enablePO(poIndex){

    if ($j("#poRaised"+poIndex).is(":checked"))
    {
        $j("#poNumber"+poIndex).removeAttr('disabled');
    }
    else
    {
        $j("#poNumber"+poIndex).attr('disabled','disabled');
    }
}


</script>


