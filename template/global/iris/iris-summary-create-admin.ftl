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
<script src="${themePath}/js/synchro/autosearch2.js" type="text/javascript"></script>

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



<form method="POST" name="fetchAttachment" id="fetchAttachment" action="/iris-summary/create-summary-admin!execute.jspa"  >
    <label>Please select the File:</label>
	<input type="text" name="projectID" value="">
	<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${briefID?c})" ></span>
	<input class="j-btn-callout" type="submit" name="Submit" value="Submit" />
	
	
	
	
	
</form>

	<#if errorMessage??>
		<p style='position: relative;left: -523px;top: 80px;color: red;'>${errorMessage}</p>
	</#if>
	


<script type="text/javascript">
    var attachmentWindow = null;
    $j(document).ready(function(){
        attachmentWindow = new IRIS_SUMMARY_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/iris-summary/create-summary-admin!execute.jspa'/>",
            
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


