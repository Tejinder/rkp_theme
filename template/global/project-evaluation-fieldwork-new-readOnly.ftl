

<form name="project-eval-form" action="/new-synchro/project-eval-fieldwork!execute.jspa" method="POST"  id="project-eval-form" class="research_pib pib" >
<div class="research_content">
<input type="hidden" name="projectID" value="${projectID?c}">
<input type="hidden" name="isSave" value="${save?string}">
  <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>

  
<div class="pib_inner_main" id="mainAgencyRating">

<#-- Project Evaluation Code Starts  -->
<p><i>Please complete the project evaluation:</i></p>
<div class="region-inner">
	<label>Project Evaluation</label>
	<#assign projectEvalCounter = 0 />	
	<#if initiationList?? && initiationList?size gt 0>

		<#list initiationList as projEvaluation>
			<div class="form-text_div">
			<div class="col-md-5">
<div class="boxinnerContainer">
			<#if projectCostDetailsList?? && projectCostDetailsList?size gt 0 >
				<#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getResearchAgency() />
				<#if !statics['com.grail.synchro.util.SynchroPermHelper'].isActiveResearchAgency(projectID)>
					<#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getAllResearchAgency() />
				</#if>
				
				<#if projectEvalCounter gt 0>
					<select name="agencies" id="eval-agency" disabled data-placeholder="Select Agency" class="chosen-select form-select agency-select" >
				<#else>
				<select name="agency" id="eval-agency" disabled data-placeholder="Select Agency" class="chosen-select form-select agency-select" >
				</#if>
					<option value=""></option>
					
					<#list projectCostDetailsList as projectCostDetail>
						<option value="${projectCostDetail.getAgencyId()}" <#if projEvaluation.getAgencyId()==projectCostDetail.getAgencyId()> selected</#if>>${researchAgencies.get(projectCostDetail.getAgencyId()?int)}</option>
					</#list>
				</select>
				<span class="jive-error-message full-width" id="evalAgencyError" style="display:none">Please select Agency</span>
			</#if>
			</div>
			<div class="boxinnerContainer">
			<#if projectEvalCounter gt 0>
				<select name="ratings" id="rating" disabled data-placeholder="Select Rating" class="chosen-select form-select" >
			<#else>
				<select name="rating" id="rating" disabled data-placeholder="Select Rating" class="chosen-select form-select" >
			</#if>
			<option value=""></option>
			<option value="1"  <#if projEvaluation.getAgencyRating()==1> selected</#if>>1-Poor</option>
			<option value="2" <#if projEvaluation.getAgencyRating()==2> selected</#if>>2-Unsatisfactory</option>
			<option value="3" <#if projEvaluation.getAgencyRating()==3> selected</#if>>3-Satisfactory</option>
			<option value="4" <#if projEvaluation.getAgencyRating()==4> selected</#if>>4-Good</option>
			<option value="5" <#if projEvaluation.getAgencyRating()==5> selected</#if>>5-Excellent</option>
			</select>
			<span class="jive-error-message full-width" id="ratingError" style="display:none">Please select Rating</span>
			</div>
			</div>
			<div class="col-md-7" id="commentDiv">
			<#if projectEvalCounter gt 0>
				<#if projEvaluation.getAgencyComments()?? >
					<textarea id="comment" name="comments"  rows="5" cols="20" disabled placeholder="Comments" class="form-text-div">${projEvaluation.getAgencyComments()}</textarea>
				<#else>	
					<textarea id="comment" name="comments"  rows="5" cols="20" disabled placeholder="Comments" class="form-text-div"></textarea>
				</#if>
			<#else>
				<#if projEvaluation.getAgencyComments()?? >
					<textarea id="comment" name="comment"  rows="5" cols="20" disabled placeholder="Comments" class="form-text-div">${projEvaluation.getAgencyComments()}</textarea>
				<#else>
					<textarea id="comment" name="comment"  rows="5" cols="20" disabled placeholder="Comments" class="form-text-div"></textarea>
				</#if>
			</#if>
				
				<span class="jive-error-message full-width" id="commentError" style="display:none">Please enter Comment</span>	
			</div>
			<#assign projectEvalCounter = projectEvalCounter + 1 />
			</div>

			
		</#list>
	<#else>
		<div class="form-text_div">
		<div class="col-md-5">
<div class="boxinnerContainer">
		<#if projectCostDetailsList?? && projectCostDetailsList?size gt 0 >
			<#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getResearchAgency() />
			<#if !statics['com.grail.synchro.util.SynchroPermHelper'].isActiveResearchAgency(projectID)>
				<#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getAllResearchAgency() />
			</#if>
			
			<select name="agency" id="eval-agency" data-placeholder="Select Agency" disabled class="chosen-select form-select agency-select" >
				<option value=""></option>
				
				<#list projectCostDetailsList as projectCostDetail>
					<#if projectCostDetail.getAgencyId()?? && projectCostDetail.getAgencyId() gt 0 >
						<option value="${projectCostDetail.getAgencyId()}" >${researchAgencies.get(projectCostDetail.getAgencyId()?int)}</option>
					</#if>
				</#list>
			</select>
			<span class="jive-error-message full-width" id="evalAgencyError" style="display:none">Please select Agency</span>
		</#if>
		</div>
		<div class="boxinnerContainer">
		<select name="rating" id="rating" data-placeholder="Select Rating" disabled class="chosen-select form-select" >
		<option value=""></option>
		<option value="1">1-Poor</option>
		<option value="2">2-Unsatisfactory</option>
		<option value="3">3-Satisfactory</option>
		<option value="4">4-Good</option>
		<option value="5">5-Excellent</option>
		</select>
		<span class="jive-error-message full-width" id="ratingError" style="display:none">Please select Rating</span>
		</div>
		</div>
		<div class="col-md-7" id="commentDiv">
			<textarea id="comment" name="comment"  rows="5" cols="20" placeholder="Comments" disabled class="form-text-div"></textarea>
			<span class="jive-error-message full-width" id="commentError" style="display:none">Please enter Comment</span>	
		</div>
	</#if>
	
<#-- Project Evaluation Code ends -->
	</div>
	
</div>

<div class="buttons">
    
       
        <input type="hidden" id="confirmProject" name="confirmProject" value="" />
		<a href="javascript:void(0);" style="margin-left: 10px;"  class="publish-details disabled">SAVE</a>	
		<a href="javascript:void(0);" id="confirmProjectEnable" style="margin-left: 10px;" class="publish-details disabled">CLOSE PROJECT</a>	
		
	
	</div>



    <#assign synchroUtils = jiveContext.getSpringBean("synchroUtils") />

<script type="text/javascript">
    var attachmentWindow = null;
    $j(document).ready(function(){
        attachmentWindow = new SYNCHRO_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/new-synchro/project-eval-fieldwork!addAttachment.jspa'/>",
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
      <#--  initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request for Agency Waiver',confirmOnClose:false});
        FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#pib-form"),form:$j("#kantar-waiver-form"), projectID:${projectID?c}}); -->
    });

</script>







</div>
</div>


</form>

  
  
