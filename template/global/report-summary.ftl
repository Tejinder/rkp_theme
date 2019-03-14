<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#-- DWR def -->
<head>
  <#--  <script type="text/javascript" src="<@s.url value='/dwr/engine.js' />"></script>
    <script type="text/javascript" src="<@s.url value='/dwr/interface/ProjectReadTracker.js' />"></script>
    <script type="text/javascript" src="<@s.url value='/dwr/interface/InviteUserUtil.js' />"></script>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>-->
	<script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>
	
<style>
	.pib_band_view ul li.popup-view-row-right label {width:27% !important;padding-left:2%!important;}
	.jive-form-textinput-variable{width:44% !important; margin:0 4px 0 !important; }
	a.jive-chooser-browse{float:left !important; margin-top:6px !important;}
	</style>
</head>
<@resource.template file="/soy/userpicker/userpicker.soy" />

<script src="${themePath}/js/synchro/popup-form-data-persist-handler.js?version=1" type="text/javascript"></script>
<script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/project-sticky-header.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.MultiFile.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ajaxfileupload.js'/>"></script>

<script type="text/javascript">

    $j(document).ready(function(){
        AUTO_SAVE.register({form:$j("#report-summary-form"), projectID:${projectID?c}});
        PROJECT_STAGE_NAVIGATOR.initialize({
        <#if projectID??>
            projectId:${projectID?c},
        </#if>
            activeStage:5
        });

        POPUP_FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#report-summary-form"),form:$j("#email-notification-form"), projectID:${projectID?c}});
        PROJECT_STICKY_HEADER.initialize();
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
        location.href="/synchro/report-summary!removeAttachment.jspa?projectID=${projectID?c}&attachmentId="+attachmentId+"&attachmentFieldID="+fieldID+"&attachmentName="+attachmentName;
        /* $j.ajax({
       url: "<@s.url value='/synchro/report-summary!removeAttachment.jspa'/>",
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

	
    function openSummaryForIRISWindow()
	{
	   
	    $j("#summaryForIRISWindow").lightbox_me({centered:true,closeEsc:false,closeClick:false,closeSelector:".none_selector",overlayCSS:{background: 'black', opacity: .7}});
	    
	    initiateRTE('projectDesc', 1500, true);
    	initiateRTE('bizQuestion', 900, true);
    	initiateRTE('researchObjective', 900, true);
    	initiateRTE('actionStandard', 900, true);
    	initiateRTE('conclusions', 900, true);
		initiateRTE('keyFindings', 900, true);
		//initiateRTE('respondentType', 900, true);
		//initiateRTE('sampleSize', 900, true);
		initiateRTE('relatedStudy', 900, true);
		initiateRTE('tags', 900, true);
		initiateRTE('irisOptionRationale', 900, true);
		
		//Audit Logs
		newTemp = newTemp.mystring.replace(/"/g, "'");
		<#assign i18CustomIRISText><@s.text name="logger.project.iris.view.text" /></#assign>	
		var projName = "${project.name?js_string}";
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].REPORT_SUMMARY.getId()}, "${i18CustomIRISText}", projName, ${projectID?c}, ${user.ID?c});
	}
	function closeSummaryForIRISWindow()
	{
	    $j("#summaryForIRISWindow").hide();
	    dialog({
	        title:"Confirmation",
	        html:"Are you sure you want to close with out saving details?",
	        nonCloseActionButtons:['YES'],
	        buttons:{
	            "YES":function() {
	                $j("#summaryForIRISWindow").hide();
	                $j("#summaryForIRISWindow").trigger('close');
	                closeDialog();
	            },
	            "NO": function() {
	                $j("#summaryForIRISWindow").show();
	            }
	        },
	        closeActionButtonsClickHander:function() {
	            $j("#summaryForIRISWindow").show();
	            closeDialog();
	        }
	    });
	
	}
	
	function handleUserPickers() 
	{
	    var projectOwner = -1;
	    var isReference = false;
		<#assign isReference = false />
	     var summaryWrittenBy = -1;
	
	<#if synchroToIRIS.summaryWrittenBy?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(synchroToIRIS.summaryWrittenBy)>
    summaryWrittenBy = ${synchroToIRIS.summaryWrittenBy?c};
	<#else>
	    <#assign isReference = true />
	    summaryWrittenBy = -1;
	</#if>
	    <#--initializeUserPicker({$input:$j("#summaryWrittenBy"),name:'summaryWrittenBy',value:summaryWrittenBy,
		        defaultFilters:{'role':6,'roleEnabled':false, 'hideInvite':true}});-->
				initializeUserPicker({$input:$j("#summaryWrittenBy"),name:'summaryWrittenBy',
		        defaultFilters:{'role':6,'roleEnabled':false, 'hideInvite':true}});
		
	}
	
	function displayIRISRequiredDIV(currentInput, irisSummaryRequired) 
	{
	
		
		if($j("input[type='radio'][name='irisSummaryRequired']:checked").val()=="irisSummaryRequired")
        {
            $j("#irisSummaryRequiredDIV").show();
            
            $j("#irisSummaryRequiredAttachment").show();
             $j("#irisSummaryNotRequiredDIV").hide();
        }
        else
        {
            $j("#irisSummaryRequiredDIV").hide();
            $j("#irisSummaryRequiredAttachment").hide();
             $j("#irisSummaryNotRequiredDIV").show();
        }
	}
	function validateIRISummaryNotRequired()
	{
		
		var irisOptionRationale = $j("textarea[name=irisOptionRationale]");
		
		if(irisOptionRationale.val() != null && $j.trim(irisOptionRationale.val())=="")
		{
		    irisOptionRationale.focus();
		    irisOptionRationale.parent().parent().find("span").show();
		    return false;
		}
		return true;
	}
</script>
<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/form-message.ftl" />

<#assign projectContactHasReadonlyAccess = statics['com.grail.synchro.util.SynchroPermHelper'].hasReadOnlyProjectAccess(projectID) />
<#assign commentsID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].COMMENTS.getId()/>
<#assign fullReportID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].FULL_REPORT.getId()/>
<#assign summaryReportID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].SUMMARY_REPORT.getId()/>
<#assign summaryForIRISID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].SUMMARY_FOR_IRIS.getId()/>
<#assign isSPIContactUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSPIContactUser(projectID,endMarketDetails.get(0).getEndMarketID()) />
<#assign isLegalUser = statics['com.grail.synchro.util.SynchroPermHelper'].isLegalUser(projectID,endMarketDetails.get(0).getEndMarketID()) />
<#assign canEditProject = statics['com.grail.synchro.util.SynchroPermHelper'].canEditProjectByStatus(projectID) />
<#assign isProcurementUser = statics['com.grail.synchro.util.SynchroPermHelper'].isProcurementUser(projectID,endMarketDetails.get(0).getEndMarketID()) />
<#assign isCommunicationAgencyUser = statics['com.grail.synchro.util.SynchroPermHelper'].isCommunicationAgencyUser(projectID,endMarketDetails.get(0).getEndMarketID()) />

<#assign isProjectOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectOwner(projectID) />
<#assign isExternalAgencyUser = statics['com.grail.synchro.util.SynchroPermHelper'].isExternalAgencyUser(projectID,endMarketDetails.get(0).getEndMarketID()) />
<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />

<!-- Page container -->
<div class="container">

    <div class="project_names">


        <div class="project_name_div">
            <h2>Report <label style="font-size: 12px;">(<span class="red">*</span>Indicates the mandatory details needed to complete the stage)</label></h2>
            <h2>${project.name?html} (${generateProjectCode('${projectID?c}')}) </h2>
			<div class="print-btn">
				<input type="button" value="PRINT" class="j-btn-callout">
			</div>
        <#--<@renderProjectStagesTab projectID=projectID stageId=stageId />-->

        <#if showMandatoryFieldsError?? && showMandatoryFieldsError>
            <div id="jive-error-box" class="jive-error-box warning" >
                <div>
                <#--<span class="jive-icon-med jive-icon-redalert"></span>-->
                    <span>Please fill in comments section to submit the Report.</span>
                </div>
            </div>
        </#if>

        <#if project.multiMarket >
            <#assign endMarketId = endMarketIds.get(0) />
        <#else>
            <#assign endMarketId = endMarketDetails.get(0).getEndMarketID() />
        </#if>
            <br>


            <form name="report-summary" id="report-summary-form" action="/synchro/report-summary!execute.jspa" method="POST" name="form-create" class="research_pib pib" >
                <div class="research_content">
                    <input type="hidden" name="projectID" value="${projectID?c}">
                    <input type="hidden" name="isSave" value="${save?string}">
                    <input type="hidden" name="endMarketID" value="${endMarketId?c}">

                <#assign synchroUtils = jiveContext.getSpringBean("synchroUtils") />

                <#if isAdminUser>
                	<@renderReportSummaryCheckboxes label="Upload Report/Oracle Summary for SP&I Approval" readonly=false />
                <#elseif (reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()) || (reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval)>
                    <@renderReportSummaryCheckboxes label="Upload Report/Oracle Summary for SP&I Approval" readonly=true />
                <#elseif isProcurementUser || isCommunicationAgencyUser || projectContactHasReadonlyAccess>
                    <@renderReportSummaryCheckboxes label="Upload Report/Oracle Summary for SP&I Approval" readonly=true />
                <#else>
                    <@renderReportSummaryCheckboxes label="Upload Report/Oracle Summary for SP&I Approval" readonly=false />
                </#if>
					<!--START -->
					
					<div class="region-inner" id ="irisSummaryNotRequiredDIV" style="display:none;">
						<label class='rte-editor-label'>Rationale for not providing the Summary for IRIS <span class="red">*</span></label>
                        <div class="form-text_div report_textarea_div">
                        	<textarea id="irisOptionRationale" name="irisOptionRationale" <#if !isAdminUser && reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> >${synchroToIRIS.irisOptionRationale?default('')?html}</textarea>
		            		<@macroCustomFieldErrors msg="Please enter Summary for IRIS Option Rationale" class='textarea-error-message'/>
                        </div>
                    </div>   
					<!--END -->						
                    <div class="region-inner">
						<label class='rte-editor-label'>Comments</label>
                        <div class="form-text_div report_textarea_div">
                        <#if isProcurementUser || isCommunicationAgencyUser || projectContactHasReadonlyAccess>
                        <#elseif !(reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval)>

                        </#if>
                       
                        
                		<#if isAdminUser>
                        	<textarea id="comments" name="comments" rows="10" cols="20" >${reportSummaryInitiation.comments?default('Include notes here, as required')?html}</textarea>
                            <@macroCustomFieldErrors msg="Please enter Comments" class='textarea-error-message'/><br>
                        <#elseif (reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()) || (reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval)>
                            <textarea id="comments" name="comments" rows="10" cols="20" disabled>${reportSummaryInitiation.comments?default('Include notes here, as required')?html}</textarea>

                        <#elseif isProcurementUser || isCommunicationAgencyUser || projectContactHasReadonlyAccess>
                            <textarea id="comments" name="comments" rows="10" cols="20"  disabled>${reportSummaryInitiation.comments?default('Include notes here, as required')?html}</textarea>
                        <#else>
                            <textarea id="comments" name="comments" rows="10" cols="20">${reportSummaryInitiation.comments?default('Include notes here, as required')?html}</textarea>
                            <@macroCustomFieldErrors msg="Please enter Comments" class='textarea-error-message'/><br>
                          <#--  <div class="character-limit" >You have <input readonly type="text" id="commentscountdown" name="countdown" size="3" value="1500" style="margin-top:7px;"> characters left</div> -->

                        </#if>
                            <!-- ATTACHMENT DISPLAY STARTS -->
                            <div class="field-attachments">
                            <#if isAdminUser>
                            	<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${commentsID?c}, true)" ></span>
                            <#elseif !(reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval)>
								<#if !projectContactHasReadonlyAccess>
									<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${commentsID?c}, true)" ></span>
								</#if>
							</#if>
                            <#if attachmentMap?? && attachmentMap.get(commentsID)?? >
                                <div id="jive-file-list" class="jive-attachments">
                                    <#list attachmentMap.get(commentsID) as attachment>
                                        <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                                            <span class="jive-icon-med jive-icon-attachment"></span>
                                            <#if isAdminUser>
                                            	 <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                                                        <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${commentsID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
                                                    </#if>
                                            <#elseif reportSummaryInitiation.status?? && reportSummaryInitiation.status!=statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
                                                <#if !(reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval)>

                                                    <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                                                        <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${commentsID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
                                                    </#if>
                                                </#if>
                                            </#if>

                                            <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                                            ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})

                                            </a>
                                        </div>
                                    </#list>
                                </div>
                            </#if>
                            </div>
                            <!-- ATTACHMENT DISPLAY ENDS -->
                            <div class="ld-div">
                                <div class="buttons">
                                <#if isAdminUser>
                                	<#--<input type="submit" name="save pib" onclick="return validatePIBFormFields();" value="Save" class="save"/>-->
                                	<input type="submit" name="save pib" value="Save" class="save"/>
                                <#elseif reportSummaryInitiation.status?? && reportSummaryInitiation.status!=statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
                                    <#if isProcurementUser || isCommunicationAgencyUser || projectContactHasReadonlyAccess>
                                    <#elseif !(reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval)>
                                       <#-- <input type="submit" name="save pib" onclick="return validatePIBFormFields();" value="Save" class="save"/> -->
                                        <input type="submit" name="save pib" value="Save" class="save"/>
                                    </#if>
                                </#if>
                                </div>
                            <#-- END SYNCHRO-- Ending the else block for External Agency -->
                            </div>
                        </div>
                    </div>
                </div>
                <!-- BEGIN sidebar column -->
                <div id="jive-body-sidebarcol-container" class="j-column j-column-s j-content-extras">
                <#include "/template/docs/synchro-doc-sidebar.ftl" />
                </div>
                <!-- END sidebar column -->
            </form>


            <!-- SYNCHRO BEGIN -->
            <!-- EMAIL NOTIFICATION WINDOW -->
            <div id="emailNotification" style="display:none">
                <form id="email-notification-form" action="<@s.url value="/synchro/report-summary!sendNotification.jspa"/>" method="post" enctype="multipart/form-data" class="j-form-popup">
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
			<form method="POST" name="moveToNextStageForm" id="moveToNextStageForm" action="/synchro/report-summary!moveToNextStage.jspa"  >
			
			    <input type="hidden" name="projectID" value="${projectID?c}">
			    <input type="hidden" name="endMarketId" value="${endMarketId?c}">
			    <input type="hidden" id="approve" name="approve" value="approve" />
			</form>
			<!-- MOVE TO NEXT STAGE FORM ENDS -->
			            

            <!-- ATTACHMENT WINDOW STARTS -->
            <script type="text/javascript">
                var attachmentWindow = null;
                $j(document).ready(function(){
                    attachmentWindow = new SYNCHRO_FIELD_ATTACHMENT_POPUP({
                        formUrl:"<@s.url value='/synchro/report-summary!addAttachment.jspa'/>",
                        projectID:${projectID?c},
                        endMarketID:${endMarketId?c},
                        showTitle:true,
                        parentForm:$j("#report-summary-form"),
                        items:[
                            {id:${commentsID?c},name:'Comments'},
                            {id:${fullReportID?c},name:'Full Report'},
                            {id:${summaryReportID?c},name:'Top Line Report / Executive Presentation'}
                            <#-- {id:${summaryForIRISID?c},name:'Summary for IRIS'} -->
                        ]

                    });

                    $j("#fileAttachBtn").bind('click',function(){
                        attachmentWindow.show(null, true);
                    });
                });

                function showAttachmentPopup(fieldId, showTitle) {
                    attachmentWindow.show(fieldId, showTitle);
                }
            </script>
            <!-- ATTACHMENT WINDOW ENDS -->




        </div>
        <!-- SYNCHRO ENDS -->
    </div>
	
<form method="POST" enctype="multipart/form-data" action="/synchro/generate-pdf.jspa" id="pdf_img_screen_form">	
    <input type="hidden" name="pdfImageDataURL" id="pdf_img_screen" value="" />
	<input type="hidden" name="projectId" id="projectId" value="${projectID?c}" />
	<input type="hidden" name="pdfFileName" id="pdfFileName" value="" />
	<input type="hidden" name="redirectURL" id="redirectURL" value="" />
	<input type="hidden" id="report-token" name="token" value="reportsummary-token-${user.ID?c}" />
	<input type="hidden" id="report-token-cookie" name="tokenCookie" value="pdfcookie" />
</form>

</div>
<script type="text/javascript">
    $j(document).ready(function() {

	/**On Page load check if field has an attachment added or not**/
	$j(".report-checkbox").each(function(){
		if($j(this).is(':checked'))
		{
			var attachmentElement = $j(this).parent().next();
			if(!attachmentElement.hasClass('jive-attachments'))
			{
				$j(this).attr('checked', false); 
				$j(this).next().val("false");
			}
		}
	 });

	$j('.report-checkbox').click (function ()
        {          
			if($j(this).is(':checked'))
            {
				var attachmentElement = $j(this).parent().next();
				if(attachmentElement.hasClass('jive-attachments'))
				{
					$j(this).next().val("true");
				}
				else
				{
					dialog({title:"Message",html:"Please select attachment"});
					return false;
				}        
            }
            else
            {
                $j(this).next().val("false");
            }
        });

        /*Load Initial Cost */

    });

    <#if showMandatoryFieldsError?? && showMandatoryFieldsError>
        <#if attachmentMap?? && attachmentMap.get(commentsID)?? >
        <#else>
        var comments = $j("textarea[name=comments]");
        comments.next().show();
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
    
    if(window.location.href.indexOf("legalApprover") > -1) 
	{
		$j("#legalApprover").focus();
	}



    /*Code to track read status of the document for current user and project */
    <#assign effectiveUser = statics['com.grail.synchro.util.SynchroPermHelper'].getEffectiveUser() />

    function validatePIBFormFields()
    {
        showLoader('Please wait...');
        $j(".jive-error-box").hide();
        $j( ".jive-error-message" ).each(function( index ) {
            $j(this).hide();
        });
        var error = false;
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

        var endMarkets = new Array();
    <#--	endMarkets = ${project.endMarkets}; -->
        var targetSegmentError = $j("#targetSegmentError");
        var smokerGroupError = $j("#smokerGroupError");
        var referenceBrandError = $j("#referenceBrandError");

        if(businessDescription.val() != null && $j.trim(businessDescription.val())=="")
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
        }

        if(error)
            hideLoader();

        return !error;
    }
	
	/* Initialization of Editor */
	$j(document).ready(function () {		
		initiateRTE('comments', 1500);
		initiateRTE('irisOptionRationale', 900, true);
		//initiateRTE('actionStandard', 900, false);	


	});
	
    /*Code to track read status of the document for current user and project */
    ProjectReadTracker.setReadTrackInfo(${projectID?c}, ${user.ID?c}, 4);
</script>


<#macro renderReportSummaryCheckboxes label='' readonly=false >
<label>${label}</label>
<div class="pib-report-requirement">
    <div>
        <div class="check-field report-check-field">
            <#if reportSummaryInitiation.fullReport?? && reportSummaryInitiation.fullReport>
                <input type="checkbox" class="report-checkbox" name="fullReport-display" checked="true" <#if readonly>disabled</#if>>
                <input type="hidden" name="fullReport" id="fullReport" value="true">
            <#else>
                <input type="checkbox" class="report-checkbox" name="fullReport-display" <#if readonly>disabled</#if>>
                <input type="hidden" name="fullReport" id="fullReport" value="false" >
            </#if>
            <span class="label">Full Report<lable style class="red">*</lable></span>
            <#if isAdminUser>
            	<span class="jive-icon-med jive-icon-attachment" onclick="showAttachmentPopup(${fullReportID?c}, true)"></span></td>
            <#elseif !(reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval)>
                <#--<#if !(attachmentMap?? && attachmentMap.get(fullReportID)?? && attachmentMap.get(fullReportID)?size &gt; 0)>-->
				<#if !projectContactHasReadonlyAccess>
                    <span class="jive-icon-med jive-icon-attachment" onclick="showAttachmentPopup(${fullReportID?c}, true)"></span></td>
                </#if>
				<#--</#if>-->
            </#if>
        </div>
        <#if attachmentMap?? && attachmentMap.get(fullReportID)?? >
            <div id="jive-file-list" class="jive-attachments">
                <#list attachmentMap.get(fullReportID) as attachment>
                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                        <span class="jive-icon-med jive-icon-attachment"></span>
                       <#if isAdminUser>
                            <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${fullReportID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
                        <#elseif reportSummaryInitiation.status?? && reportSummaryInitiation.status!=statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
                            <#if !(reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval)>
                                <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                                    <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${fullReportID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
                                </#if>
                            </#if>
                        </#if>

                        <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                        ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                        </a>
                    </div>
                </#list>
            </div>
        </#if>
    </div>
    <div>
        <div class="check-field report-check-field">
            <#if reportSummaryInitiation.summaryReport?? && reportSummaryInitiation.summaryReport>
                <input type="checkbox" class="report-checkbox" name="summaryReport-display" checked="true" <#if readonly>disabled</#if> />
                <input type="hidden" name="summaryReport" id="summaryReport" value="true" />
            <#else>
                <input type="checkbox" class="report-checkbox" name="summaryReport-display" <#if readonly>disabled</#if> />
                <input type="hidden" name="summaryReport" id="fullReport" value="false" />
            </#if>
            <span class="label">Top&nbsp;Line&nbsp;Report&nbsp;/&nbsp;Executive</br>Presentation</span>
            <#if isAdminUser>
            	<span class="jive-icon-med jive-icon-attachment" onclick="showAttachmentPopup(${summaryReportID?c}, true)"></span></td>
            <#elseif !(reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval)>
                <#--<#if !(attachmentMap?? && attachmentMap.get(summaryReportID)?? && attachmentMap.get(summaryReportID)?size &gt; 0)>-->
				<#if !projectContactHasReadonlyAccess>
                    <span class="jive-icon-med jive-icon-attachment" onclick="showAttachmentPopup(${summaryReportID?c}, true)"></span></td>			
				</#if>
				<#--</#if>-->
            </#if>
        </div>

        <#if attachmentMap?? && attachmentMap.get(summaryReportID)?? >
            <div id="jive-file-list" class="jive-attachments">
                <#list attachmentMap.get(summaryReportID) as attachment>
                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                        <span class="jive-icon-med jive-icon-attachment"></span>
                        
                        <#if isAdminUser>
                        	<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${summaryReportID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
                        <#elseif reportSummaryInitiation.status?? && reportSummaryInitiation.status!=statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
                            <#if !(reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval)>

                                <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
                                    <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${summaryReportID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
                                </#if>
                            </#if>
                        </#if>

                        <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                        ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                        </a>
                    </div>
                </#list>
            </div>
        </#if>
    </div>
    <div>
         <div class="check-field report-check-field width100">
            <#if reportSummaryInitiation.summaryForIRIS?? && reportSummaryInitiation.summaryForIRIS>
                <input type="checkbox"  name="summaryForIRIS-display" id="summaryForIRIS-display" checked="true" disabled />
               <#-- <input type="hidden" name="summaryForIRIS" id="summaryForIRIS" value="true" /> -->
            <#else>
               <input type="checkbox"  name="summaryForIRIS-display" disabled />
               <#-- <input type="hidden" name="summaryForIRIS" id="fullReport" value="false" /> -->
            </#if>
            <span class="label">Summary for IRIS<lable style class="red">*</lable></span>
            <#--<a href="javascript:void(0);" onclick="javascript:openSummaryForIRISWindow()">Click here to complete the Summary for IRIS</a>-->
            
            <p class="induction_text">(Download Summary for IRIS Template.)</p>
			 <div class="standard-report-download-link" style="top:-12px; right:-402px;">
	              <a href="<@s.url value="/file/download/IRIS-Summary-Template-and-Guidelines.xls"/>"></a>
	         </div>
	         <br>
	           <div class="summaryTextBox">

              <#if !isAdminUser && ((reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()) || (reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved))>
                  <div class="inputBox">
                      <input type="radio" id="irisSummaryRequired" name="irisSummaryRequired" value="irisSummaryRequired" disabled <#if synchroToIRIS.irisSummaryRequired?? && synchroToIRIS.irisSummaryRequired==1>  checked="true" </#if>  >
                      Summary For IRIS required 
                  </div>
                  <div class="inputBox">
                      <input type="radio" id="irisSummaryNotRequired" name="irisSummaryRequired" value="irisSummaryNotRequired" disabled <#if synchroToIRIS.irisSummaryRequired?? && synchroToIRIS.irisSummaryRequired==2>  checked="true" </#if> >
                      Summary For IRIS not required
                  </div>

              <#elseif synchroToIRIS.irisSummaryRequired?? && synchroToIRIS.irisSummaryRequired==2>

                  <div class="inputBox">
                      <input type="radio" id="irisSummaryRequired" name="irisSummaryRequired" value="irisSummaryRequired" onclick="javascript:displayIRISRequiredDIV(this, 'irisSummaryRequired');" <#if synchroToIRIS.irisSummaryRequired?? && synchroToIRIS.irisSummaryRequired==1>  checked="true" </#if>  >
                      Summary For IRIS required <span id="irisSummaryRequiredAttachment" class="jive-icon-med jive-icon-attachment" onclick="showAttachmentPopup(${summaryForIRISID?c}, true)"></span>
                  </div>
                  <div class="inputBox">
                      <input type="radio" id="irisSummaryNotRequired" name="irisSummaryRequired" value="irisSummaryNotRequired" onclick="javascript:displayIRISRequiredDIV(this, 'irisSummaryNotRequired');" <#if synchroToIRIS.irisSummaryRequired?? && synchroToIRIS.irisSummaryRequired==2>  checked="true" </#if> >
                      Summary For IRIS not required
                  </div>
              <#else>
                  <div class="inputBox">
                      <input type="radio" id="irisSummaryRequired" name="irisSummaryRequired" value="irisSummaryRequired" onclick="javascript:displayIRISRequiredDIV(this, 'irisSummaryRequired');"  checked="true"  >
                      Summary For IRIS required <span id="irisSummaryRequiredAttachment" class="jive-icon-med jive-icon-attachment" onclick="showAttachmentPopup(${summaryForIRISID?c}, true)"></span>
                  </div>
                  <div class="inputBox">
                      <input type="radio" id="irisSummaryNotRequired" name="irisSummaryRequired" value="irisSummaryNotRequired" onclick="javascript:displayIRISRequiredDIV(this, 'irisSummaryNotRequired');">
                      Summary For IRIS not required
                  </div>
              </#if>

              </div>
              
              <div id ="irisSummaryRequiredDIV" class="summary-popup-inside">
              	
              <#if attachmentMap?? && attachmentMap.get(summaryForIRISID)?? >
		            <div id="jive-file-list" class="jive-attachments">
		                <#list attachmentMap.get(summaryForIRISID) as attachment>
		                    <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
		                        <span class="jive-icon-med jive-icon-attachment" style="float:left;"></span>
		                        
		                        <#if isAdminUser>
		                        	<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${summaryReportID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
		                        <#elseif reportSummaryInitiation.status?? && reportSummaryInitiation.status!=statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
		                            <#if !(reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval)>
		
		                                <#if (attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID) || (isAdminUser) >
		                                    <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c},${summaryReportID?c}, '${attachment.name}');"><@s.text name="global.remove" /></a>
		                                </#if>
		                            </#if>
		                        </#if>
		
		                        <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
		                        ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
		                        </a>
		                    </div>
		                </#list>
		            </div>
		        </#if>
		        
		        </div>
              
            
            <#--
            <#if isAdminUser>
            	<span class="jive-icon-med jive-icon-attachment" onclick="showAttachmentPopup(${summaryForIRISID?c}, true)"></span></td>
            <#elseif !(reportSummaryInitiation.isSPIApproved?? && reportSummaryInitiation.isSPIApproved && reportSummaryInitiation.legalApproval?? && reportSummaryInitiation.legalApproval)>

              	<#if !projectContactHasReadonlyAccess>
                    <span class="jive-icon-med jive-icon-attachment" onclick="showAttachmentPopup(${summaryForIRISID?c}, true)"></span></td>				


                </#if>              
            </#if>
            -->
        </div>
        
    </div>
</div>
</#macro>


<!-- SUMMARY FOR IRIS WINDOW STARTS -->

<div id="summaryForIRISWindow" style="display:none">
    <div class="summaryForIRIS view_edit_pib">
        <form id="synchro-pit-form" action="<@s.url value="/synchro/report-summary!updateSynchroToIRIS.jspa"/>" method="post" class="j-form-popup">
            <a href="javascript:void(0);" class="close" onclick="closeSummaryForIRISWindow();"></a>
            
          <div class="summary-heading">
              <span class="summaryText">  Summary For IRIS</span>


              <div class="summaryTextBox">

              <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
                  <div class="inputBox">
                      <input type="radio" id="irisSummaryRequired" name="irisSummaryRequired" value="irisSummaryRequired" disabled <#if synchroToIRIS.irisSummaryRequired?? && synchroToIRIS.irisSummaryRequired==1>  checked="true" </#if>  >
                      Summary For IRIS required
                  </div>
                  <div class="inputBox">
                      <input type="radio" id="irisSummaryNotRequired" name="irisSummaryRequired" value="irisSummaryNotRequired" disabled <#if synchroToIRIS.irisSummaryRequired?? && synchroToIRIS.irisSummaryRequired==2>  checked="true" </#if> >
                      Summary For IRIS not required
                  </div>

              <#elseif synchroToIRIS.irisSummaryRequired?? && synchroToIRIS.irisSummaryRequired==2>

                  <div class="inputBox">
                      <input type="radio" id="irisSummaryRequired" name="irisSummaryRequired" value="irisSummaryRequired" onclick="javascript:displayIRISRequiredDIV(this, 'irisSummaryRequired');" <#if synchroToIRIS.irisSummaryRequired?? && synchroToIRIS.irisSummaryRequired==1>  checked="true" </#if>  >
                      Summary For IRIS required
                  </div>
                  <div class="inputBox">
                      <input type="radio" id="irisSummaryNotRequired" name="irisSummaryRequired" value="irisSummaryNotRequired" onclick="javascript:displayIRISRequiredDIV(this, 'irisSummaryNotRequired');" <#if synchroToIRIS.irisSummaryRequired?? && synchroToIRIS.irisSummaryRequired==2>  checked="true" </#if> >
                      Summary For IRIS not required
                  </div>
              <#else>
                  <div class="inputBox">
                      <input type="radio" id="irisSummaryRequired" name="irisSummaryRequired" value="irisSummaryRequired" onclick="javascript:displayIRISRequiredDIV(this, 'irisSummaryRequired');"  checked="true"  >
                      Summary For IRIS required
                  </div>
                  <div class="inputBox">
                      <input type="radio" id="irisSummaryNotRequired" name="irisSummaryRequired" value="irisSummaryNotRequired" onclick="javascript:displayIRISRequiredDIV(this, 'irisSummaryNotRequired');">
                      Summary For IRIS not required
                  </div>
              </#if>

              </div>
          </div>
           
       
			
			<div id ="irisSummaryRequiredDIV" class="summary-popup-inside">
			 <div class="mandatoryDetailTex">  *Please provide the mandatory details to complete the process for IRIS Summary</div>
				
	             <div class="pib_band_view">
	            <ul>
                    <li>
	                        <label>Synchro ID</label>
	                         <input type="text" id="initialCost" name="initialCost" value="${projectID?c}" disabled size="30" class="">
	                </li>
                    <li class="popup-view-row-right">
                        <label>Project Name </label>

                        <input type="text" id="projectName" name="projectName" disabled value="${synchroToIRIS.projectName?default('')?html}" />
                    <#--<textarea id="projectName" name="projectName" <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> >${synchroToIRIS.projectName?default('')?html}</textarea>-->
                    </li>
                </ul>

				<#--<label style="float:none;" class="pit-description-label">Project Name</label>-->

                </div>
	            
	          
	
	            <div class="pib_band_view">
	                <ul>
	                    <li>
	                        <label>Brand/Non-Branded</label>
	                    <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
	                    	<@renderBrandField name='brand' value=synchroToIRIS.brand?default('-1') readonly=true />
	                    <#else>
	                    	<@renderBrandField name='brand' value=synchroToIRIS.brand?default('-1') readonly=false />
	                    </#if>
	                    </li>
	                    <li class="popup-view-row-right">
	                        <label>Methodology Type</label>
	                    <@renderMethodologyField name='methodologyType' value=synchroToIRIS.methodologyType?default('-1') readonly=true/>
	                    </li>
	                    <li >
	                        <label>Country</label>
	                    <@renderEndMarketSingleSelectFld name='updatedSingleMarketId' value=synchroToIRIS.endMarketId?default('-1') disabled=true/>
	                    </li>
	                    <li class="popup-view-row-right">
	                        <label>Methodology Group</label>
	                    <@renderMethodologyGroupField name='methodologyGroup' value=synchroToIRIS.methodologyGroup?default('-1') readonly=true/>
	                    </li>
	                    
	                </ul>
	                
	                <ul class="pib_initial_div">
	                    <li>
	                        <label>Summary Written By</label>
	                         
	                          <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
	                         	<#assign summaryWrittenByName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(synchroToIRIS.summaryWrittenBy) />
	                        	<input type="text" id="initialCost" name="initialCost" value="${summaryWrittenByName}" size="30" disabled class="form-text-div numericfield numericformat longField">
	                        
	                         <#else>
	                             <input type="text" tabindex="1" name="summaryWrittenBy" id="summaryWrittenBy" class="j-user-autocomplete j-ui-elem" srole="6" autocomplete="off" />
	                         </#if>
	                    
	                    </li>
                        <li class="popup-view-row-right">
                            <label>BAT Primary Contact</label>
                            <#assign batPrimaryContact = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(synchroToIRIS.batPrimaryContact) />
                            <input type="text" id="initialCost" name="initialCost" value="${batPrimaryContact}" size="30" disabled class="form-text-div numericfield numericformat longField">
                            <input type="hidden" name="batPrimaryContact" value="${batPrimaryContact}">
                                                
                        </li>
	                </ul>
	                
	                <ul>
	                    <li>
	                        <label>Fieldwork Start Date</label>
	                        
	                          <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
	                           		<input type="text" name="fieldWorkStartDate" id="fieldWorkStartDate" <#if synchroToIRIS.fieldWorkStartDate??> value="${synchroToIRIS.fieldWorkStartDate?string('dd/MM/yyyy')}" <#else>value=""</#if> disabled />
	                           <#else>
	                         	<#--	<@jiveform.datetimepicker id="fieldWorkStartDate"  name="fieldWorkStartDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
								<@synchrodatetimepicker id="fieldWorkStartDate" name="fieldWorkStartDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
	                         </#if>
	                        
	                    </li>
	                    <li class="popup-view-row-right">
	                        <label>Fieldwork End Date</label>
	                        <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
	                           		<input type="text" name="fieldWorkEndDate" id="fieldWorkEndDate" <#if synchroToIRIS.fieldWorkEndDate??> value="${synchroToIRIS.fieldWorkEndDate?string('dd/MM/yyyy')}" <#else>value=""</#if> disabled />
	                           <#else>
	                         		<#-- <@jiveform.datetimepicker id="fieldWorkEndDate" name="fieldWorkEndDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/> -->
									 <@synchrodatetimepicker id="fieldWorkEndDate" name="fieldWorkEndDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
	                         </#if>
	                    </li>
	                </ul>
	                
                    <ul>
                        <li>
                            <label>Sample Size<span class="red">*</span></label>
                            <input type="text" name="sampleSize" class="error" id="sampleSize" <#if synchroToIRIS.sampleSize??> value="${synchroToIRIS.sampleSize?default('')?html}" <#else>value=""</#if> <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> />
                            <!-- <div class="pib_view_popup">
                                 
                                 <#<textarea id="sampleSize" name="sampleSize" <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> >${synchroToIRIS.sampleSize?default('')?html}</textarea>
                            </div>  -->
                        </li>
                        <li class="popup-view-row-right">
                            <label>Research Agency<span class="red">*</span></label>
                            <#--<#assign reasearchAgencyName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(synchroToIRIS.researchAgency) /> -->
                            <input type="text" id="researchAgency" name="researchAgency" value="${synchroToIRIS.researchAgency}" size="30" disabled class="form-text-div numericfield numericformat longField">
                           <#-- <input type="hidden" name="researchAgency" value="${synchroToIRIS.researchAgency}"> -->
                        
                        </li>
                    </ul>
	                 
		            
		             <ul class="pib_initial_div">
	                    
                        <li>
                            <label>Report Date<span class="red">*</span></label>
                             <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
                                    <input type="text" name="reportDate" id="reportDate" <#if synchroToIRIS.reportDate??> value="${synchroToIRIS.reportDate?string('dd/MM/yyyy')}" <#else>value=""</#if> disabled />
                               <#else>
                                 <#--   <@jiveform.datetimepicker id="reportDate" name="reportDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/> -->
								 	<@synchrodatetimepicker id="reportDate" name="reportDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
                               </#if>
                        
                        </li>
                        <li class="popup-view-row-right">
                            <label>Respondent Type<span class="red">*</span></label>
                            <input type="text" name="respondentType" class="error id="respondentType" <#if synchroToIRIS.sampleSize??> value="${synchroToIRIS.respondentType?default('')?html}" <#else>value=""</#if> <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> />
                            <!-- <div class="pib_view_popup">
                                 
                                 <#<textarea id="respondentType" name="respondentType" <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> >${synchroToIRIS.respondentType?default('')?html}</textarea>
                            </div> -->
                        </li>
	                </ul>
	            
	            </div>
	            
	              <label style="float:none;" class="pit-description-label">Project Description</label>
	            <div class="pib_view_popup form-text_div">
		            <textarea id="projectDesc" name="projectDesc" <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> >${synchroToIRIS.projectDesc?html}</textarea>
			     </div>
	
				<label style="float:none;" class="pit-description-label">Research Objectives(s)</label>
				<div class="pib_view_popup">
	                  <textarea id="researchObjective" name="researchObjective" <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> >${synchroToIRIS.researchObjective?html}</textarea>
	            </div>
	            
	            <label style="float:none;" class="pit-description-label">Business Question</label>
	            <div class="pib_view_popup">
	                  <textarea id="bizQuestion" name="bizQuestion" <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> >${synchroToIRIS.bizQuestion?default('')?html}</textarea>
	            </div>
	            
	            
	            <div class="pib_view_popup">
	                 
	                  Action Standard(s)
			            <div class="pib_view_popup form-text_div">
			            
			                <textarea id="actionStandard" name="actionStandard" <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> >${synchroToIRIS.actionStandard?html}</textarea>
			
			            </div>
	            </div>
	            
	            <label style="float:none;" class="pit-description-label">Tags<span class="red">*</span></label>
	            <div class="pib_view_popup error_pib_view_popup">
	                 <textarea id="tags"  name="tags" <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> >${synchroToIRIS.tags?default('')?html}</textarea>
	            </div>
	            
	            
	            <label style="float:none;" class="pit-description-label">Related Studies</label>
	            <div class="pib_view_popup error_pib_view_popup">
	                 <textarea id="relatedStudy" name="relatedStudy" <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> >${synchroToIRIS.relatedStudy?default('')?html}</textarea>
	            </div> 
	            
	            
	            <label style="float:none;" class="pit-description-label">Conclusions<span class="red">*</span></label>
	            <div class="pib_view_popup error_pib_view_popup">
	                <textarea id="conclusions" name="conclusions" <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> >${synchroToIRIS.conclusions?default('')?html}</textarea>
	            </div>
	            
	            <label style="float:none;" class="pit-description-label">Key Findings<span class="red">*</span></label>
	            <div class="pib_view_popup error_pib_view_popup">
	                 
	                  <textarea id="keyFindings" name="keyFindings" <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> >${synchroToIRIS.keyFindings?default('')?html}</textarea>
	            </div>
	              
	            
	            
	           
	           
	              <div class="pib_band_view">  
	                 
	                
	                
	           
	               
	                
	                
	               </div>
	               
	                 
	                
	               
	                
	               
	            <div class="pib_band_view">
	                
	               
	                
	                <ul class="pib_initial_div DocEngBox" >
	                    <li>
	                        <label style="width:21%;">All documents are in English <span class="red">*</span></label>
	                                                  
	                           <div class="inputBox"> <input type="checkbox" class="" name="allDocsEnglish" id ="allDocsEnglish" <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> <#if synchroToIRIS.allDocsEnglish?? && synchroToIRIS.allDocsEnglish > checked="true" </#if> >Yes</div>
	                     </li>
	                </ul>
	                
	                <ul class="pib_initial_div DocEngBox">
	                   <li>                        
	                       <input type="checkbox" class="" name="irisdisclaimer" id ="irisdisclaimer" <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> <#if synchroToIRIS.disclaimer?? && synchroToIRIS.disclaimer > checked="true" </#if> >I accept that this study is not confidential as the studies that are confidential are not meant for everyone and should not be sent to IRIS upload.
	                     </li>
	                </ul>
	           
					
					<div class="region-inner-pib">
	                    <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
	                    <#else>
	                    	<input class="j-btn-callout" type="submit" name="doPost" id="postButton" value="Save" style="font-weight: bold;" />
	                    </#if>
	                    
	                </div>
	        
	            </div>
	         </div>
	        
	         <div id ="irisSummaryNotRequiredDIV" style="display:none; width:100%;">
	         
	         	 <div class="mandatoryDetailTex">*Please provide the rationale for not uploading Summary for IRIS</div>
	        
	       
	         	<label style="float:none; margin-bottom:5px;" class="pit-description-label">Summary for IRIS Option Rationale <span class="red">*</span></label>
	            <div class="pib_view_popup form-text_div">
		            <textarea id="irisOptionRationale" name="irisOptionRationale" <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()> disabled </#if> >${synchroToIRIS.irisOptionRationale?default('')?html}</textarea>
		            <@macroCustomFieldErrors msg="Please enter Summary for IRIS Option Rationale" class='textarea-error-message'/>
			     </div>
			 
			     
			      <div class="pib_band_view">
			     <div class="region-inner-pib">
	                    <#if reportSummaryInitiation.status?? && reportSummaryInitiation.status==statics['com.grail.synchro.SynchroGlobal$StageStatus'].REPORT_SUMMARY_COMPLETED.ordinal()>
	                    <#else>
	                    	<input class="j-btn-callout" type="submit" name="doPost" id="postButton" value="Save" onclick="return validateIRISummaryNotRequired();" style="font-weight: bold;" />
	                    </#if>
	                    
	                </div>
	                </div>
	         </div>
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" name="endMarketId" value="${endMarketId?c}">
        </form>
    </div>
</div>

<!-- SUMMARY FOR IRIS WINDOW ENDS -->

<script type="text/javascript">

$j(document).ready(function() {
  
 <#if synchroToIRIS.fieldWorkStartDate??>
    	var _fieldWorkStartDate = "${synchroToIRIS.fieldWorkStartDate?string('dd/MM/yyyy')}";
       	$j("#fieldWorkStartDate").val(_fieldWorkStartDate);
	</#if>
	
	<#if synchroToIRIS.fieldWorkEndDate??>
    	var _fieldWorkEndDate = "${synchroToIRIS.fieldWorkEndDate?string('dd/MM/yyyy')}";
       	$j("#fieldWorkEndDate").val(_fieldWorkEndDate);
	</#if>
	
	<#if synchroToIRIS.reportDate??>
    	var _reportDate = "${synchroToIRIS.reportDate?string('dd/MM/yyyy')}";
       	$j("#reportDate").val(_reportDate);
	</#if>
	handleUserPickers();
	
	<#if synchroToIRIS.irisSummaryRequired?? && synchroToIRIS.irisSummaryRequired==2>
		 $j("#irisSummaryRequiredDIV").hide();
         $j("#irisSummaryNotRequiredDIV").show();
	<#else>
		 $j("#irisSummaryRequiredDIV").show();
         $j("#irisSummaryNotRequiredDIV").hide();
	</#if>
	
	$j("#reportDate").addClass('error_pib_view_popup');
});


<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.report.view.text" /></#assign>	
	var projName = "${project.name?js_string}";
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].REPORT_SUMMARY.getId()}, "${i18CustomText}", projName, ${projectID?c}, ${user.ID?c});

</script>