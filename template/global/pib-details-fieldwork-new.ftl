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

<script>
	var methodologyMultipleMessageText='<@s.text name="project.methodology.multiple.message"/>';
	var currencyChangeMessageText='<@s.text name="project.currency.change.message"/>';
</script>

<#assign fieldCategoryId = ''/>

<#assign isBriefLegalApprover = statics['com.grail.synchro.util.SynchroPermHelper'].isBriefLegalUser(projectID) />

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
   
	<#--FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#synchro-pit-form"), projectID:${projectID?c}}) -->
    $j("#pitWindow").lightbox_me({centered:true,closeEsc:false,closeClick:false,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7}});
	
    initiateRTE('description', 1500, true);
	
	
	
	
	<#assign i18CustomPITText><@s.text name="logger.project.pit.view.text" /></#assign>
	var projName = "${project.name?js_string}";
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PIB.getId()}, "${i18CustomPITText}", projName, ${projectID?c}, ${user.ID?c});
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
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].ADD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PIB.getId()}, "${waiverBtnClickText}", projName, ${projectID?c}, ${user.ID?c});
	</#if>
}
function closeWaiverWindow()
{
    $j("#initiateWaiver").hide();
    <#if isBriefLegalApprover>
		$j("#initiateWaiver").trigger('close');
		closeDialog();
	<#else>
		
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
	</#if>
}
function closePITWindow()
{
    $j("#pitWindow").hide();
	<#if isBriefLegalApprover>
		$j("#pitWindow").trigger('close');
		closeDialog();
	<#else>
	
		dialog({
			title:"Confirmation",
			html:"Are you sure you want to close with out saving details?",
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
		});
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
    location.href="/new-synchro/pib-details!removeAttachment.jspa?projectID=${projectID?c}&attachmentId="+attachmentId+"&attachmentFieldID="+fieldID+"&attachmentName="+attachmentName;
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




<div class="new-page-wrapper">
	<div class="new-page-nav extra">
	<hr></hr>
	<ul>
	
	<li><div class="nav-select">1</div><span>in planning</span></li>
	<li class="disable"><div class="nav-select">2</div><span>complete</span></li>
	<li class="disable"><div class="nav-select">3</div><span>close</span></li>
	</ul>
	</div>
</div>
	
<div class="container">
<div class="project_names">


<div class="project_name_div">

<h2>${project.name?html} (${generateProjectCode('${projectID?c}')}) </h2>

<#if isBriefLegalApprover>
<a class="view-edit" href="javascript:void(0);" onclick="javascript:openPITWindow()">Click here to view more details</a>
<#else>
	<a class="view-edit" href="javascript:void(0);" onclick="javascript:openPITWindow()">Click here to view/edit more details</a>
</#if>

<#if !isBriefLegalApprover>
	<a class="cancel-project view-edit" href="javascript:void(0);" onclick="javascript:cancelProject()">Cancel Project</a>
</#if>

<#-- <span class="warning-msg"><span></span>PIB cannot be completed until all the mandatory PIB fields have not been filled.</span> -->
<div id="jive-error-box" class="jive-error-box warning" <#if showMandatoryFieldsError?? && showMandatoryFieldsError>style="display:block;"<#else>style="display:none"</#if>>
    <div>
    <#--<span class="jive-icon-med jive-icon-redalert"></span>-->
        <span><@s.text name="project.mandatory.error"/></span>
    </div>
</div>
<#--</#if>-->



<#assign isProjectOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectOwner(projectID) />

<#assign isMethAppUser = statics['com.grail.synchro.util.SynchroPermHelper'].isMethodologyApproverUser() />
<#assign isKantarMethAppUser = statics['com.grail.synchro.util.SynchroPermHelper'].isKantarMethodologyApproverUser() />


<#assign projectContactHasReadonlyAccessToPIB = statics['com.grail.synchro.util.SynchroPermHelper'].hasReadonlyAccessToPIB(projectID) />
<#assign isProjectCreator = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectCreator(projectID) />
<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
<#assign isSynchroSystemOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner() />
<#assign synchroSystemOwnerName = statics['com.grail.synchro.util.SynchroUtils'].getSynchroSystemOwnerName() />

<#assign defaultCurrency = -1/>




 <#assign endMarketId = endMarketDetails.get(0).getEndMarketID() />

<#assign canEditProject = statics['com.grail.synchro.util.SynchroPermHelper'].canEditProjectByStatus(projectID) />

<!-- Brief Legal Approver Changes Start -->
<#if isBriefLegalApprover>
	<#include "/template/global/pib-details-new-legalView.ftl" />
<#else>

<form name="pib-form" action="/new-synchro/pib-details!execute.jspa" method="POST"  id="pib-form" class="research_pib pib" >
<div class="research_content">
<input type="hidden" name="projectID" value="${projectID?c}">
<input type="hidden" name="isSave" value="${save?string}">
  <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
<div class="pib_inner_main">
<div class="pib_left">
	<!-- <a class="view-edit" href="javascript:void(0);" onclick="javascript:openPITWindow()">View/Edit PIT</a> -->
	<div>
        <div class="form-date_div">
            <label>Project Start</label>
			<@synchrodatetimepicker id="startDate" name="startDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
		 
            <#assign error_msg><@s.text name='project.error.startdate' /></#assign>
        </div>
        <@macroCustomFieldErrors msg=error_msg />
    </div>

    <div>
        <div class="form-date_div">
            <label>Project Completion</label>
           <@synchrodatetimepicker id="endDate" name="endDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
		 
            <#assign error_msg><@s.text name='project.error.enddate' /></#assign>

        </div>
        <@macroCustomFieldErrors msg=error_msg />
    </div>
	
	
	<div id="expenseDetailsContainer">
				<label>Expense Details</label>
					<div class="border-box">
					
					<#if projectCostDetailsList?? && projectCostDetailsList?size gt 0 >
						<#assign projectCostCounter = 0 />
						<#list projectCostDetailsList as projectCostDetail>
					
						<#assign projectCostCounter =  projectCostCounter + 1/>
						
					
						<div class="expense_row">
							
							<input type="button" value="duplicate" id="firstDuplicate" class="duplicate"/>
							<input type="button" value="Remove" id="firstRemove" class="remove" />
					
						<div class="region-inner">
							
						
							<div id="agencyMain">
						  
							
								<select data-placeholder="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' tabindex="6">
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
							<@renderCostComponent name="costComponents" value="${projectCostDetail.getCostComponent()?default('-1')}" id='costComponent'/>
							<span class='jive-error-message costComponentdynamicError'  style='display:none'>Please Select Cost Component</span> 
						</div>
						<div class="region-inner">
							
							<@renderCurrenciesFieldNew name='currencies' value="${projectCostDetail.getCostCurrency()?default(-1)}"  disabled=false id='currency' />
							<span class='jive-error-message costCurrencytdynamicError'  style='display:none'>Please Select Cost Currency</span>
						</div>

						
						<div class="region-inner">
							<!-- Project Initial Cost Field -->
							<div class="form-select_div">
								<div class="pit-estimate-cost">
									<!-- <label><@s.text name="project.initiate.project.cost"/></label> -->

									<input type="text"  id="enter_cost" name="agencyCosts"  firstRow="yes" Placeholder="Enter Cost" class="text_field longField total-expense" value="${projectCostDetail.getEstimatedCost()}" />
								<span class="jive-error-message agencyCostsError" style="display: none;">Please Enter Agency Cost</span>
								</div>
								
							</div>

						</div>
					</div>
					</#list>
					
					<#-- Adding a Blank Row Starts-->
					
						<div class="expense_row">
					     <input type="button" value="duplicate" class="duplicate" id="firstDuplicate" style="display:none"/>
						 <input type="button" value="Remove" class="remove" id="firstRemove" style="display:none"/>
						<div class="region-inner">
							
						
							<div id="agencyMain">
						  
							
								<select data-placeholder="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' tabindex="6">
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
																<option isNonKantar="yes" value="${researchAgencykey?c}">${researchAgencies.get(researchAgencykey)}</option>
															<#else>
																<option isNonKantar="no" value="${researchAgencykey?c}">${researchAgencies.get(researchAgencykey)}</option>
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

								<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" Placeholder="Enter Cost" class="text_field longField total-expense" value="" />
								<span class="jive-error-message agencyCostsError" style="display: none;">Please Enter Agency Cost</span>
								</div>
								
							</div>

						</div>
					</div>
					
					<#-- Adding a Blank Row Ends-->
					
					
					
					<#else>
					
					<div class="expense_row">
					     <input type="button" value="duplicate" class="duplicate" id="firstDuplicate" style="display:none"/>
						 <input type="button" value="Remove" class="remove" id="firstRemove" style="display:none"/>
						<div class="region-inner">
							
						
							<div id="agencyMain">
						  
							
								<select data-placeholder="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' tabindex="6">
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
																<option isNonKantar="yes" value="${researchAgencykey?c}">${researchAgencies.get(researchAgencykey)}</option>
															<#else>
																<option isNonKantar="no" value="${researchAgencykey?c}">${researchAgencies.get(researchAgencykey)}</option>
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

								<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" Placeholder="Enter Cost" class="text_field longField total-expense" value="" />
								<span class="jive-error-message agencyCostsError" style="display: none;">Please Enter Agency Cost</span>
								</div>
								
							</div>

						</div>
					</div>
					</#if>

					<div class="region-inner total-cost">
						<!-- Project Initial Cost Field -->
						<div class="form-select_div">
							<div class="pit-estimate-cost">
								<label>Total Cost(GBP)</label>
								<#if project.totalCost??> 
									<input type="text"   Placeholder="0" name="totalCost" class="text_field longField" disabled value="${project.totalCost}" />
								<#else>
									<input type="text"   Placeholder="0" name="totalCost" class="text_field longField" disabled value="" />
								</#if>
								
								<input type="hidden"  name="totalCostHidden"  id="totalCostHidden" value="" />
							<#assign error_msg><@s.text name="project.error.cost"/></#assign>
							<@macroCustomFieldErrors msg=error_msg class="numeric-error"/>
							</div>
							
						</div>
 
					</div>
					<div id="nonKantarAgencyMessage" style="display:none">This project requires a waiver for using non-Kantar agency. You can initiate a waiver once a project is created.
					</div>
					</div>
				</div>
	
	
	
	<div class="region-inner">
		<div class="form-select_div">
		<label>Is the project a fieldwork component of an above market study?</label>
		<@fieldworkstudyField name='fieldWorkStudy' value=project.fieldWorkStudy?default('-1')/>
		<#assign error_msg><@s.text name='project.error.brand' /></#assign>
		<@macroCustomFieldErrors msg=error_msg />
		</div>
	</div>
	
	
	<div>
		<label>Reference Synchro Code</label>
		<input type="text" tabindex="1" name="refSynchroCode" placeholder="Enter Synchro Code" value="${project.refSynchroCode?c}" id="refSynchroCode"  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter Synchro Code' "/>
		<#assign error_msg><@s.text name="project.error.owner"/></#assign>
		<span class="full-width"><@macroCustomFieldErrors msg=error_msg /></span>
	</div>
			
	<div class="project_waiver_rqst">
	<label>Agency Waiver Request</label>
	<ul class="right-sidebar-list">

		<li id="initiateKantarWaiverButton" ><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>
	</ul>
	</div>


	<div class="form-select_div select-div methodology-status" id="nonKantarWaiverStatus" <#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>style="display:block;" <#else> style="display:none;"</#if>>

		<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
			<label>Status:</label>
			<span>Approved</span>
		<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
			<label>Status:</label>
			<span>Rejected</span>
		<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID?? >
			<label>Status:</label>
			<span>Pending</span>
		<#else>
		</#if>

		<br/>
	</div>

	
	
	
	 <div class="form-select_div select-div">
        <label>Will a methodology waiver be required?</label>
		
    
		
		<select data-placeholder="Select" class="chosen-select" id = "deviationFromSM" name="deviationFromSM" tabindex="6" onchange="checkMethDeviation()">
			<option  value="-1" <#if project.methWaiverReq?? && project.methWaiverReq==-1 > selected </#if>></option>
			<option  value="1" <#if project.methWaiverReq?? && project.methWaiverReq==1 > selected </#if>>Yes</option>
			<option  value="2" <#if project.methWaiverReq?? && project.methWaiverReq==2 > selected </#if>>No</option>
			<option  value="3" <#if project.methWaiverReq?? && project.methWaiverReq==3 > selected </#if>>I don’t know yet</option>
		</select>
		
		

		
       
            <script type="text/javascript">
                <#--
                var initiateWaiverWindow = null;
                $j(document).ready(function(){
                    initiateWaiverWindow = new LIGHT_BOX($j("#initiateWaiver"),{title:'Request for Methodology Waiver',confirmOnClose:true});
                    FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#waiver-form"), projectID:${projectID?c}});
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
       
    </div>
    <#if project.methWaiverReq?? && project.methWaiverReq==1 && pibMethodologyWaiver?? && pibMethodologyWaiver.projectID?? >
        <div class="form-select_div select-div methodology-status">
            <label>Status:</label>
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



<div class="region-inner">
	<label class='rte-editor-label'>Proposal</label>
    <div class="form-text_div">
      
		<textarea id="brief"  placeholder="Add notes, if any" name="brief" rows="10" cols="20" class="form-text-div">${projectInitiation.brief?default('')?html}</textarea>
        <@macroCustomFieldErrors msg="Please enter the Project Brief" class='textarea-error-message'/>
		
    </div>
    <textarea style="display:none;" id="briefText" name="briefText">${projectInitiation.briefText?default('')?html}</textarea>
	 <!-- ATTACHMENT DISPLAY STARTS -->
    <div class="field-attachments">
   <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${briefID?c})" ></span>
		<#if attachmentMap?? && attachmentMap.get(briefID)?? >
			<div id="jive-file-list" class="jive-attachments">
				<#list attachmentMap.get(briefID) as attachment>
					<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
						<span class="jive-icon-med jive-icon-attachment"></span>
						<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
							<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${briefID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
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
    $j(document).ready(function(){
        attachmentWindow = new SYNCHRO_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/new-synchro/pib-details!addAttachment.jspa'/>",
            projectID:${projectID?c},
            endMarketID:${endMarketId?c},
            parentForm:$j("#pib-form"),
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
    }
</script>





<script type="text/javascript">
    var initiateKantarWaiverWindow = null;
    $j(document).ready(function(){
        initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request for Agency Waiver',confirmOnClose:true});
        FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#kantar-waiver-form"), projectID:${projectID?c}});
    });

</script>



<div class="buttons">
    <#if editStage && !isBriefLegalApprover  >
        <br>
        <input type="hidden" id="confirmProject" name="confirmProject" value="" />
		<a href="javascript:void(0);" style="margin-left: 10px;" onclick="return validatePIBFormFields('');" class="publish-details">Save</a>	
		<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" onclick="return continueProjectNonEU();" class="publish-details">Project Completed</a>	
    </#if>
	</div>

</div>
</div>
</div>

</form>




<div id="emailNotification" style="display:none">
    <form id="email-notification-form" action="<@s.url value="/new-synchro/pib-details!sendNotification.jspa"/>" method="post" enctype="multipart/form-data" class="j-form-popup">
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
  
   
		
        <form id="waiver-form" action="<@s.url value="/new-synchro/pib-details!updateWaiver.jspa"/>" method="post" class="j-form-popup">
        	
        	 
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

           
            <#elseif  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                <textarea id="methodologyDeviationRationale" disabled name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            <#else>
                <textarea id="methodologyDeviationRationale" name="methodologyDeviationRationale" placeholder="Methodology Description">${pibMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            </#if>
            </div>
            <div class="pib_view_popup">
                

                
            <#if isAdminUser>
                <input id="send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
             

            <#elseif  isProjectCreator>
                <#if  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                    <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
                   
                <#elseif  pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==2>
                     <input type="button" class="g-btn g-btn-send"  name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;cursor:default;" />
				
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

                
            <#if isAdminUser>
                <textarea id="methodologyApproverComment" name="methodologyApproverComment" placeholder="Methodology Approver Comments">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>

            <#elseif isSynchroSystemOwner>
                <#if pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==1>
                    <textarea id="methodologyApproverComment"  disabled name="methodologyApproverComment">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
                <#else>
                    <textarea id="methodologyApproverComment" name="methodologyApproverComment" placeholder="Methodology Approver Comments">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
               
                </#if>

                
            <#else>
                <textarea id="methodologyApproverComment"  disabled name="methodologyApproverComment">${pibMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
            </#if>
            </div>

            
        <#if isAdminUser>
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
        </form>
    </div>
</div>



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

        <form id="kantar-waiver-form" action="<@s.url value="/new-synchro/pib-details!updateKantarWaiver.jspa"/>" method="post">
            <label class='rte-editor-label'>Agency Deviation Rationale</label>
            <div class="pib_view_popup form-text_div">
            <#if isAdminUser>
                <textarea id="methodologyDeviationRationaleKantar" name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>

            <#elseif !(isProjectCreator) >
                <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            <#elseif  pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                <textarea id="methodologyDeviationRationaleKantar" disabled name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            <#else>
                <textarea id="methodologyDeviationRationaleKantar" name="methodologyDeviationRationale" placeholder="Agency Deviation Rationale Description">${pibKantarMethodologyWaiver.methodologyDeviationRationale?default('')?html}</textarea>
            </#if>
            </div>
			
			

			<div class="waiver-summary">
			<a href="<@s.url value="/file/download/AgencyCostDetails-SingleMarketTemplate.xlsx"/>">Download Agency Waiver Summary Template</a>
			
			<p>Waiver Summary</p> 
			<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${agencyWaiverID?c})" ></span>
			</div>
			<#if attachmentMap?? && attachmentMap.get(agencyWaiverID)?? >
				<div id="jive-file-list" class="jive-attachments">
					<#list attachmentMap.get(agencyWaiverID) as attachment>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							<#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
								<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c}, ${agencyWaiverID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
							</#if>
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
						</div>
					</#list>
				</div>
			</#if>

			 
            <div class="pib_view_popup">
               
                
            <#if isAdminUser>
                <input id="kantar-send-for-approval" class="j-btn-callout send-information" type="button" name="doPost" id="postButton" value="SEND FOR APPROVAL" style="font-weight: bold;" />
               

            <#elseif isProjectCreator>
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

                
            <#if isAdminUser>
                <textarea id="methodologyApproverCommentKantar" name="methodologyApproverComment" placeholder="Methodology Approver Comments">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>

            <#elseif  isSynchroSystemOwner>
                <#if pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
                    <textarea id="methodologyApproverCommentKantar"  disabled name="methodologyApproverComment">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
                <#else>
                    <textarea id="methodologyApproverCommentKantar" name="methodologyApproverComment" placeholder="Methodology Approver Comments">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
                <#--<div class="character-limit" >You have <input readonly type="text" id="methodologyApproverCommentcountdown" name="countdown" size="3" value="2500" style="margin-top:7px;"> characters left</div>-->
                </#if>

                
            <#else>
                <textarea id="methodologyApproverCommentKantar"  disabled name="methodologyApproverComment">${pibKantarMethodologyWaiver.methodologyApproverComment?default('')?html}</textarea>
            </#if>
            </div>

            
        <#if isAdminUser>
            <input id="kantar-request-for-information" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="REQUEST MORE INFORMATION" style="font-weight: bold;" />
            <input id="kantar-approve-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Approve" style="font-weight: bold;" />
            <input id="kantar-reject-waiver-btn" type="button" class="j-btn-callout send-information" name="doPost" id="postButton" value="Reject" style="font-weight: bold;" />

        <#elseif isSynchroSystemOwner>

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



<div id="pitWindow" style="display:none">
    <div class="view_edit_pib">
        <form id="synchro-pit-form" action="<@s.url value='/new-synchro/pib-details!updatePIT.jspa'/>" method="post" class="j-form-popup">
            <h3>Project Details Overview</h3>
			<a href="javascript:void(0);" class="close" onclick="closePITWindow();"></a>
            <div class="pib_view_popup">
                <label>Project Name </label>
            <input type="text" id="projectName" name="projectName" value="${project.name?html}" />
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
			  
					<select data-placeholder="" class="chosen-select" id = "categoryType" name="categoryType" multiple tabindex="6">
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
			
			<div class="region-inner">
				
				<div class="form-select_div">
					<#--<label><@s.text name="project.initiate.project.brand"/></label>-->
					<label>Is the project a fieldwork component of an above market study?</label>
				
				<@fieldworkstudyField name='fieldWorkStudy' value=project.fieldWorkStudy?default('-1')/>
				<#assign error_msg><@s.text name='project.error.brand' /></#assign>
				<@macroCustomFieldErrors msg=error_msg />
				</div>


			</div>
			
			<div class="region-inner">
				<#assign selectedEndMarket="" />
				<#if endMarketDetails?? && endMarketDetails?size gt 0 >
				<#assign selectedEndMarket= endMarketDetails.get(0).endMarketID />
				</#if>
				<label class="label_b">Research End Market</label>
				
				<div class="">
			  
					<select data-placeholder="" class="chosen-select" id = "endMarkets" name='endMarkets' tabindex="6">
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
					</select>
					<span class="jive-error-message" id="endMarketError" style="display:none"><@s.text name='project.error.endmarket' /></span>
				
				</div>
			</div>
			
			<div class="region-inner">
					
				<div class="form-select_div start_date">
					<label>Project Start</label>
			   
				<@synchrodatetimepicker id="startDate1" name="startDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
				<#assign error_msg><@s.text name='project.error.startdate' /></#assign>
				<@macroCustomFieldErrors msg=error_msg />
				<@macroFieldErrors name="startDate"/>
				</div>
			</div>	
			<div class="region-inner">
				<div class="form-select_div form-select_div_project_completion">
					<label>Project Completion</label>
					 
				<@synchrodatetimepicker id="endDate1" name="endDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
				<#assign error_msg><@s.text name='project.error.enddate' /></#assign>
				<@macroCustomFieldErrors msg=error_msg />
				<@macroFieldErrors name="endDate"/>
				</div>
			</div>
			
			<div class="region-inner">
				
				
				<div class="form-select_div">
					<#--<label><@s.text name="project.initiate.project.owner"/></label>-->
					<label>Project Manager</label>
					<div>
					
					   
					<input type="text" tabindex="1" name="projectManagerName" value="${project.projectManagerName}" id="projectManagerName"  />

					<#assign error_msg><@s.text name="project.error.owner"/></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
				</div>

				<!-- Project SP&I Contact -->
		
				<div class="form-select_div form-select_div_project_completion">
					<#--<label><@s.text name="project.initiate.project.spi"/></label>-->
					<label>Project Initiator</label>
					<div>
						<input type="text" tabindex="1" name="projectInitiator" value="${user.name}" id="projectInitiator"  disabled />
					
					<#assign error_msg><@s.text name="project.error.spi"/></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
				</div>

			</div>
			
			<div class="region-inner">
					
					<label class="label_b">Methodology Details</label>
					<div class="col-lg-6">
				  
						<select data-placeholder="" class="chosen-select" id = "methodologyDetails" name = "methodologyDetails" multiple tabindex="6">
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
						<label>Type</label>
				
					<@renderMethodologyField name='methodologyType' value=project.methodologyType?default('-1') readonly=false/>
					<@macroCustomFieldErrors msg="Please enter the Methodology Type" />
					
					</div>
					
				</div>
				
				<div class="region-inner">
					
					<div class="form-select_div">
						<label>Will a methodology waiver be required?</label>
					
					<#--<@renderMethodologyWaiverField name='methWaiverReq' value=project.methWaiverReq?default('-1') />-->
					
					<select data-placeholder="Select" class="chosen-select" id = "methWaiverReq" name="methWaiverReq" tabindex="6" onchange="checkMethDeviation()">
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
								<span>Status : Approved</span>
							<#elseif pibMethodologyWaiver.isApproved?? && pibMethodologyWaiver.isApproved==2>
								<span>Status : Rejected</span>
							<#else>
								<span>Status : Pending</span>
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
					
					<@renderBrandSpecificStudy name='brandSpecificStudy' value=project.brandSpecificStudy?default('-1')/>
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					<div id="brandSpecific" style="display:none">
					
					<div class="form-select_div">
						
					
					<@renderBrandFieldNew name='brand' value=project.brand?default('-1')/>
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
					
					</div>
					<div id="brandSpecificStudyType">
					
					
										
					<@renderBrandSpecificStudyType name='brandSpecificStudyType' value=project.brandSpecificStudyType?default('-1')/>
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					
					</div>
					</div>
					
					
				</div>
				
				
				<div class="region-inner">
					
					<div class="form-select_div">
						<label>Budget Location</label>
					
					<#assign userBudgetLocation = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationEndMarkets(user) />
					
					<select data-placeholder="Select the Budget Location" class="chosen-select" id = "budgetLocation" name="budgetLocation" tabindex="6">
						<#if userBudgetLocation?? && userBudgetLocation?size gt 0 >
							<option value=""></option>
							<#list userBudgetLocation as ubugLoc>
							<option  value="${ubugLoc}" <#if selectedEndMarket==ubugLoc> selected </#if>>${endMarkets.get(ubugLoc?int)}</option>
							</#list>
						</#if>
					</select>
					<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					</div>
				</div>

				<div class="region-inner">
				<@projectBudgetYearFieldNew name="budgetYear" value=project.budgetYear/>
					<@macroCustomFieldErrors msg="Please enter Budget Year" />
					<span class="jive-error-message" id="budgetYearError" style="display:none">Please enter Budget Year</span>
				</div>
				
				<!-- Add the Expense Details Here Start-->
				<!-- Add the Expense Details Here Ends-->
				
			<div class="project_waiver_rqst region-inner">
				<label>Agency Waiver Request</label>
				<ul class="right-sidebar-list">

					<li id="initiateKantarWaiverButtonPIT" ><a onclick="javascript:showInitiateKantarWaiverWindow();" href="javascript:void(0);"><#if pibKantarMethodologyWaiver.methodologyApprover??>View/Approve Waiver<#else>Click to Initiate Waiver</#if></a></li>
				</ul>
				
				<div  class="agency_methodology" id="nonKantarWaiverStatus" <#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID??>style="display:block;" <#else> style="display:none;"</#if>>

					<#if pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==1>
						<span>Status : Approved</span>
					<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.isApproved?? && pibKantarMethodologyWaiver.isApproved==2>
						<span>Status : Rejected</span>
					<#elseif pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.projectID?? >
						<span>Status : Pending</span>
					<#else>
					</#if>

				
				</div>
			</div>
				
            
            <div class="pib_band_view">
            
                <div class="region-inner-pib">
                    <input class="j-btn-callout" type="button" name="doPost" id="postButton" onclick="return validatePITFields();" value="Save" style="font-weight: bold;" />
                    
                </div>
            </div>
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" name="endMarketId" value="${endMarketId?c}">
        </form>
    </div>
</div>


</div>


</div>

</#if>

<!-- Brief Legal Approver Else ends -->

<form method="POST" name="sendForApprovalForm" id="sendForApprovalForm" action="/new-synchro/pib-details!updateSendForApproval.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
	<input type="hidden" id="briefLegalApproverHidden" name="briefLegalApproverHidden" value="">
</form>

<form method="POST" name="sendReminderForm" id="sendReminderForm" action="/new-synchro/pib-details!updateSendReminder.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
</form>

<form method="POST" name="needDiscussionForm" id="needDiscussionForm" action="/new-synchro/pib-details!updateNeedsDisussion.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
</form>
<form method="POST" name="confirmLegalApprovalSubmissionForm" id="confirmLegalApprovalSubmissionForm" action="/new-synchro/pib-details!confirmLegalApprovalSubmission.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
	<input type="hidden" name="legalApprovalStatus" id="legalApprovalStatus" value="">
	
</form>

<form method="POST" name="cancelProj" id="cancelProj" action="/new-synchro/pib-details!cancelProject.jspa"  >
    <input type="hidden" name="projectID" value="${projectID?c}">
</form>

</div>
  <script type="text/javascript">
     $j(document).ready(function() {
        $j('.chosen-select').chosen();
        $j('.chosen-select-deselect').chosen({ allow_single_deselect: true });
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
    var _legalApprovalDate = "${projectInitiation.legalApprovalDate?string('dd/MM/yyyy')}";
    $j("#legalApprovalDate").val(_legalApprovalDate);
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
		var systemOwnerName = "${synchroSystemOwnerName}";
	   dialog({
                title:"Message",
                html:"<p>An email notification for your waiver request has been sent to "+systemOwnerName+" (System Owner) for approval.<br/><br/>You can view the status of the approval through the current project page or through <b>Manage -> Waivers</b></p>",

                buttons:{
                    "Ok": function() {
                        showLoader('Please wait...');
						var form = $j("#waiver-form");
						form.submit();
                    }
                }

              

            });
		
		
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
       
	   var systemOwnerName = "${synchroSystemOwnerName}";
	   dialog({
                title:"Message",
                html:"<p>An email notification for your waiver request has been sent to "+systemOwnerName+" (System Owner) for approval.<br/><br/>You can view the status of the approval through the current project page or through <b>Manage -> Waivers</b></p>",

                buttons:{
                    "Ok": function() {
                        showLoader('Please wait...');
						var form = $j("#kantar-waiver-form");
						form.submit();
						
                    }
                }

              

            });
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

 	if(validateProjectCostDetails())
	{
		
		var pitForm = jQuery("#synchro-pit-form");
		pitForm.submit();
	}
	else
	{
		hideLoader();
		return false;
	}
    
  
	


}
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
function validatePIBFormFields(continueVar)
{


	var legalSignOffRequired=$j("#legalsignoffreq").prop("checked");
	if(legalSignOffRequired)
	{
		
		$j("#legalSignOffReqValue").val('yes');
		var pibForm = jQuery("#pib-form");
		pibForm.submit();
		
	}
	else
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

		
		
		 var brief = $j("textarea[name=brief]");
		


	  
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
		
	
		/*if(brief.val() != null && $j.trim(brief.val())=="")
		{
			
			if(!error)
				brief.focus();
			error = true;
			brief.parent().parent().find('.jive-error-message').show();

		}*/
		
		if(continueVar!="")
		{		
			<#if attachmentMap?? && attachmentMap.get(briefID)?? >
			<#else>
				if(!error)
					brief.focus();
				error = true;
				brief.parent().parent().find('.jive-error-message').show();
			 </#if>

		
			var briefLegalApprover = $j("#briefLegalApprover");
			if(briefLegalApprover.val() != null && $j.trim(briefLegalApprover.val())=="")
			{
				$j("#briefLegalApproverError").show();
				error = true;
			}
		}	

		if(error)
			hideLoader();

		if(error)
		{
			return false;
		}
		
		else
		{
			if(continueVar=="")
			{
				var pibForm = jQuery("#pib-form");
				pibForm.submit();
			}
			return true;
		}
	}
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
    initiateKantarWaiverWindow.show();
    initiateRTE('methodologyDeviationRationaleKantar', 2500, false);
    initiateRTE('methodologyApproverCommentKantar', 2500, false);
	
	
	<#if !(pibKantarMethodologyWaiver?? && pibKantarMethodologyWaiver.methodologyApprover??)>
		<#assign kantarBtnClickText><@s.text name="logger.project.kantar.btn.click" /></#assign>
		var projName = "${project.name?js_string}";
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].ADD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PIB.getId()}, "${kantarBtnClickText}", projName, ${projectID?c}, ${user.ID?c});
	</#if>
}

/* Initialization of Editor */
$j(document).ready(function () {
    
	initiateRTE('brief', 1500, true);
	
});

</script>

<script type="text/javascript">

	<#assign i18CustomText><@s.text name="logger.project.pib.view.text" /></#assign>	
	var projName = "${project.name?js_string}";	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PIB.getId()}, "${i18CustomText}", projName, ${projectID?c}, ${user.ID?c});
</script>

	<script src="${themePath}/js/synchro/project-cost-details-Fieldwork.js" type="text/javascript"></script> 
  <script type="text/javascript">
  

  
  
  
  function continueProject()
  {
	
	{
			
			var pibForm = jQuery("#pib-form");
			
			var legalSignOffRequired=$j("#legalsignoffreq").prop("checked");
			
			
			if(legalSignOffRequired)
			{
			
				$j("#legalSignOffReqValue").val('yes');
				$j("#confirmProject").val('confirmProject');
				pibForm.submit();
			}
			else
			{
				var error = validatePIBFormFields("continue");
				if(!error)
				{
					return false;	
				}
				else
				{	
					$j("#confirmProject").val('confirmProject');
					pibForm.submit();
				}
			}
	}
	
	
  }
  
 
  
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

	var endMarket = $j('select[name="endMarkets"] option:selected').val();
	var endMarketText = $j('select[name="endMarkets"] option:selected').text();
	$j("#endMarkets").change(function() {
			
			dialog({
					title:"Message",
					html:"<p>You are trying to change 'Research End Market'. This cannot be updated!</p><p>You need to cancel the project and setup it up as a new project on SynchrO with the correct information.</p>",
					buttons:{
					"OK":function() {
						return false;		
					}
				},

				});
			$j('select[name="endMarkets"] select').val(endMarket);
			$j('#endMarkets_chosen span').text(endMarketText);
			
	});
	
	
	
	
	var fieldWorkStudy = $j('select[name="fieldWorkStudy"] option:selected').val();
	var fieldWorkStudyText = $j('select[name="fieldWorkStudy"] option:selected').text();
	
	
	$j("#fieldWorkStudy").change(function() {
			
			dialog({
					title:"Message",
					html:"<p>You are trying to change 'Is the project a fieldwork component of an above market study?'. This cannot be updated!</p><p>You need to cancel the project and setup it up as a new project on SynchrO with the correct information.</p>",
					buttons:{
					"OK":function() {
						return false;		
					}
				},

				});
			$j('select[name="fieldWorkStudy"] select').val(fieldWorkStudy);
			$j('#fieldWorkStudy_chosen span').text(fieldWorkStudyText);
	});
	
	function cancelProject()
  {
	
	{
		dialog({
					title:"Message",
					html:"<p>Once you cancel the project, it will no longer be accessible.</p><p>Are you sure you want to cancel the project</p>",
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
	
	 $j("#legalsignoffreq").change(function() {
			
			var legalSignOffRequired=$j("#legalsignoffreq").prop("checked");
			if(legalSignOffRequired)
			{	
				$j('#confirmProjectEnable').removeClass("disabled");
			}
			else
			{	$j('#confirmProjectEnable').addClass("disabled");
				
			}
			
	});
	
	$j("#briefLegalApprover").change(function() {
		
		 <#if attachmentMap?? && attachmentMap.get(briefID)?? >
			$j('#sendForApprovalEnable').removeClass("disabled");
			var briefLegalApprover = $j("#briefLegalApprover").val();
		
			$j("#briefLegalApproverHidden").val(briefLegalApprover);
		
		 </#if>
	});
	
	

  </script>
  

  
  
  
  
  
  
