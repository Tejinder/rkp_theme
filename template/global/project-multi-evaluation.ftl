<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#-- DWR def -->
<head>

</head>
<script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/project-sticky-header.js'/>"></script>

<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/form-message.ftl" />

<#assign canEditProject = statics['com.grail.synchro.util.SynchroPermHelper'].canEditProjectEvaluation(projectID) />

<script type="text/javascript">
    $j(document).ready(function(){
        PROJECT_STICKY_HEADER.initialize();
    });
</script>


<!-- Project Contact access to Project stages based on role hierarchies -->
<#assign projectContactHasReadonlyAccess = statics['com.grail.synchro.util.SynchroPermHelper'].hasReadOnlyProjectAccessMultiMarket(projectID) />

<#assign isCountryProjectContact = statics['com.grail.synchro.util.SynchroPermHelper'].isCountryProjectContact(projectID,endMarketId) />
<#assign isCountrySPIContact = statics['com.grail.synchro.util.SynchroPermHelper'].isCountrySPIContact(projectID,endMarketId) />
<#assign isAboveMarketProjectContactUser = statics['com.grail.synchro.util.SynchroPermHelper'].isAboveMarketProjectContact(projectID) />
<#assign isProjectOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectOwner(projectID) />
<#assign isLegalUser = statics['com.grail.synchro.util.SynchroPermHelper'].isLegalUser(projectID,statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID) />
<#assign isProcUser = statics['com.grail.synchro.util.SynchroPermHelper'].isProcurementUser(projectID,statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID) />
<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />

<!-- Page container -->
<div class="container">

    <div class="project_names">


        <div class="project_name_div">
           <h2>Project Evaluation <label style="font-size: 12px;">(<span class="red">*</span>Indicates the mandatory details needed to complete the stage)</label></h2>
            <h2>${project.name?html} (${generateProjectCode('${projectID?c}')}) </h2>

      
		 <#assign endMarketId = endMarketId />
		 
		 
		<div class="main-sub-menus-div endmarket-menus">
		    <ul class="main-sub-menus">
		        <li><a href="/synchro/project-multi-eval!input.jspa?projectID=${projectID?c}" <#if (!endMarketId?exists) || (endMarketId &lt;= 0)>class="active"</#if>>Above Market</a></li>
		    <#list endMarketDetails as emd>
				<#if emd.getStatus()?? && emd.getStatus()!=statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].CANCEL.ordinal()>
					<li><a href="/synchro/project-multi-eval!input.jspa?projectID=${projectID?c}&endMarketId=${emd.getEndMarketID()}" <#if endMarketId?exists && endMarketId == emd.getEndMarketID()>class="active"</#if>>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emd.getEndMarketID()?int)}</a></li>
				</#if>		        
		    </#list>
		    </ul>
		</div>
		
		<#assign isExternalAgencyUser = statics['com.grail.synchro.util.SynchroPermHelper'].isExternalAgencyUser(projectID,statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID) />
		<#assign isAwardedExternalAgencyUser = statics['com.grail.synchro.util.SynchroPermHelper'].isAwardedExternalAgencyUser(projectID,statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID) />
		
		
            <form name="project-eval" id="project-eval" action="/synchro/project-multi-eval!execute.jspa" method="POST" name="form-create" class="research_pib pib" >
            <div class="research_content">
                <input type="hidden" name="projectID" value="${projectID?c}">
                <input type="hidden" name="isSave" value="${save?string}">
                <input type="hidden" name="endMarketId" value="${endMarketId?c}">
                
                <div class="pib-evaluation-div">
             	<div class="pib-evaluation">
				<h2 class="pib_sub_heading">International Management</h2>
				
				<div class="pib-select_div">
					
					<label>Agency Performance for Project<span class="red">*</span></label>
					
					<#if isAdminUser || isProjectOwner || isAboveMarketProjectContactUser || isAwardedExternalAgencyUser>
						<@renderAgencyPerfField name='agencyPerfIM' value=projectEvaluationInitiation.agencyPerfIM?default(-1)/>
					<#elseif isExternalAgencyUser || projectContactHasReadonlyAccess> 
						<@renderAgencyPerfField name='agencyPerfIM' value=projectEvaluationInitiation.agencyPerfIM?default(-1) readonly=true />
					<#elseif !canEditProject>
						<@renderAgencyPerfField name='agencyPerfIM' value=projectEvaluationInitiation.agencyPerfIM?default(-1) readonly=true />
					<#--<#elseif projectEvaluationInitiation.status?? && projectEvaluationInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROJ_EVAL_COMPLETED.ordinal()>
						<@renderAgencyPerfField name='agencyPerfIM' value=projectEvaluationInitiation.agencyPerfIM?default(-1) readonly=true />-->
					<#elseif !(isAboveMarket) && !(isCountryProjectContact || isCountrySPIContact) >
						<@renderAgencyPerfField name='agencyPerfIM' value=projectEvaluationInitiation.agencyPerfIM?default(-1) readonly=true />
					<#elseif (isAboveMarket) && !(isAboveMarketProjectContactUser || isProjectOwner || isLegalUser || isProcUser) >
						<@renderAgencyPerfField name='agencyPerfIM' value=projectEvaluationInitiation.agencyPerfIM?default(-1) readonly=true />
					<#else>	
						<@renderAgencyPerfField name='agencyPerfIM' value=projectEvaluationInitiation.agencyPerfIM?default(-1)/>
					</#if>
				</div>
				
				<div class="region-inner">
					<label class='rte-editor-label'>BAT Comments</label>	                 
                	<div class="form-text_div">
	                    <#if isAdminUser || isProjectOwner || isAboveMarketProjectContactUser || isAwardedExternalAgencyUser>
	                    		 <textarea id="batCommentsIM" name="batCommentsIM"  rows="10" cols="20" class="form-text-div">${projectEvaluationInitiation.batCommentsIM?default('')?html}</textarea>
			                <@macroCustomFieldErrors msg="Please enter BAT Comments"/>
							
							<#--<div class="character-limit" >You have <input readonly type="text" id="batCommentsIMcountdown" name="countdown" size="3" value="900" style="margin-top:7px;"> characters left</div>-->
							
							
	                    <#elseif !(isAboveMarket) && !(isCountryProjectContact || isCountrySPIContact) >
	                    	  <textarea id="batCommentsIM" name="batCommentsIM"  disabled  rows="10" cols="20" class="form-text-div">${projectEvaluationInitiation.batCommentsIM?default('')?html}</textarea>
	                    <#elseif (isAboveMarket) && !(isAboveMarketProjectContactUser || isProjectOwner || isLegalUser || isProcUser) >
	                    	  <textarea id="batCommentsIM" name="batCommentsIM"  disabled  rows="10" cols="20" class="form-text-div">${projectEvaluationInitiation.batCommentsIM?default('')?html}</textarea>
	                    
	                    <#else>
			                    <textarea id="batCommentsIM" name="batCommentsIM" <#if isExternalAgencyUser || projectContactHasReadonlyAccess || !canEditProject > disabled </#if> rows="10" cols="20" class="form-text-div" >${projectEvaluationInitiation.batCommentsIM?default('')?html}</textarea>
			                <@macroCustomFieldErrors msg="Please enter BAT Comments"/>
							<#if !(isExternalAgencyUser || projectContactHasReadonlyAccess || !canEditProject )>
							<#--<div class="character-limit" >You have <input readonly type="text" id="batCommentsIMcountdown" name="countdown" size="3" value="900" style="margin-top:7px;"> characters left</div> -->
							</#if>
						</#if>
	                </div>
	           
                </div>
                
                <div class="region-inner">
					<label class='rte-editor-label'>Agency Comments</label>
                	<div class="form-text_div">
	                    <#if isAdminUser>
	                    		<textarea id="agencyCommentsIM" name="agencyCommentsIM"  rows="10" cols="20" class="form-text-div">${projectEvaluationInitiation.agencyCommentsIM?default('')?html}</textarea>
			                <@macroCustomFieldErrors msg="Please enter Agency Comments"/>
						<#--	<div class="character-limit" >You have <input readonly type="text" id="agencyCommentsIMcountdown" name="countdown" size="3" value="900" style="margin-top:7px;"> characters left</div> -->
							
	                    <#elseif isAwardedExternalAgencyUser || isAboveMarketProjectContactUser || isProjectOwner>             
			                    <textarea id="agencyCommentsIM" name="agencyCommentsIM"  rows="10" cols="20" class="form-text-div">${projectEvaluationInitiation.agencyCommentsIM?default('')?html}</textarea>
			                <@macroCustomFieldErrors msg="Please enter Agency Comments"/>
							<#-- <div class="character-limit" >You have <input readonly type="text" id="agencyCommentsIMcountdown" name="countdown" size="3" value="900" style="margin-top:7px;"> characters left</div> -->
							
						
						<#else>
							  <textarea id="agencyCommentsIM" name="agencyCommentsIM"  rows="10" cols="20" disabled class="form-text-div">${projectEvaluationInitiation.agencyCommentsIM?default('')?html}</textarea>
			                <@macroCustomFieldErrors msg="Please enter Agency Comments"/>
							
						</#if>
	                </div>
	           
                </div>
                </div>
                
                <div class="pib-evaluation">
				<h2 class="pib_sub_heading">Local Management</h2>
				
				<div class="pib-select_div">
					<label>Agency Performance for Project</label>
					
					<#if isAdminUser || isProjectOwner || isAboveMarketProjectContactUser || isAwardedExternalAgencyUser>
						<@renderAgencyPerfField name='agencyPerfLM' value=projectEvaluationInitiation.agencyPerfLM?default(-1) />
					<#elseif isExternalAgencyUser || projectContactHasReadonlyAccess || !canEditProject> 
						<@renderAgencyPerfField name='agencyPerfLM' value=projectEvaluationInitiation.agencyPerfLM?default(-1)  readonly=true />
					<#--<#elseif projectEvaluationInitiation.status?? && projectEvaluationInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROJ_EVAL_COMPLETED.ordinal()>
						<@renderAgencyPerfField name='agencyPerfLM' value=projectEvaluationInitiation.agencyPerfLM?default(-1)  readonly=true />-->
					<#elseif !(isAboveMarket) && !(isCountryProjectContact || isCountrySPIContact) >
						<@renderAgencyPerfField name='agencyPerfLM' value=projectEvaluationInitiation.agencyPerfLM?default(-1)  readonly=true />
					<#elseif (isAboveMarket) && !(isAboveMarketProjectContactUser || isProjectOwner || isLegalUser || isProcUser) >
						<@renderAgencyPerfField name='agencyPerfLM' value=projectEvaluationInitiation.agencyPerfLM?default(-1)  readonly=true />
					<#else>	
						<@renderAgencyPerfField name='agencyPerfLM' value=projectEvaluationInitiation.agencyPerfLM?default(-1) />
					</#if>
				</div>
				
				<div class="region-inner">
					<label class='rte-editor-label'>BAT Comments</label>	                 
                	<div class="form-text_div">
	                    <#if isAdminUser || isProjectOwner || isAboveMarketProjectContactUser || isAwardedExternalAgencyUser>
	                    		<textarea id="batCommentsLM" name="batCommentsLM" rows="10"  cols="20" class="form-text-div">${projectEvaluationInitiation.batCommentsLM?default('')?html}</textarea>
			                <@macroCustomFieldErrors msg="Please enter BAT Comments"/>
							
						<#--	<div class="character-limit" >You have <input readonly type="text" id="batCommentsLMcountdown" name="countdown" size="3" value="900" style="margin-top:7px;"> characters left</div> -->
							
	                    <#elseif !(isAboveMarket) && !(isCountryProjectContact || isCountrySPIContact) >
	                    	  <textarea id="batCommentsLM" name="batCommentsLM" rows="10"  disabled  cols="20" class="form-text-div">${projectEvaluationInitiation.batCommentsLM?default('')?html}</textarea>
	                   <#elseif (isAboveMarket) && !(isAboveMarketProjectContactUser || isProjectOwner || isLegalUser || isProcUser) >
	                   	 	  <textarea id="batCommentsLM" name="batCommentsLM" rows="10"  disabled  cols="20" class="form-text-div">${projectEvaluationInitiation.batCommentsLM?default('')?html}</textarea>
	                    
	                    <#else>
			                   <textarea id="batCommentsLM" name="batCommentsLM" rows="10" <#if isExternalAgencyUser || projectContactHasReadonlyAccess || !canEditProject > disabled </#if> cols="20" class="form-text-div">${projectEvaluationInitiation.batCommentsLM?default('')?html}</textarea>
			                <@macroCustomFieldErrors msg="Please enter BAT Comments"/>
							<#if !(isExternalAgencyUser || projectContactHasReadonlyAccess || !canEditProject )>
						<#--	<div class="character-limit" >You have <input readonly type="text" id="batCommentsLMcountdown" name="countdown" size="3" value="900" style="margin-top:7px;"> characters left</div> -->
							</#if>
						</#if>
	                </div>
	           
                </div>
                
               <div class="region-inner">
					<label class='rte-editor-label'>Agency Comments</label>	
                	<div class="form-text_div">
	                   	<#if isAdminUser>
	                   		<textarea id="agencyCommentsLM" name="agencyCommentsLM" rows="10" cols="20" class="form-text-div">${projectEvaluationInitiation.agencyCommentsLM?default('')?html}</textarea>
	                <@macroCustomFieldErrors msg="Please enter Agency Comments"/>
					<#-- <div class="character-limit" >You have <input readonly type="text" id="agencyCommentsLMcountdown" name="countdown" size="3" value="900" style="margin-top:7px;"> characters left</div> -->
					
	                    <#elseif isAwardedExternalAgencyUser || isProjectOwner || isAboveMarketProjectContactUser>
	                    	<textarea id="agencyCommentsLM" name="agencyCommentsLM" rows="10" cols="20" class="form-text-div">${projectEvaluationInitiation.agencyCommentsLM?default('')?html}</textarea>
	                <@macroCustomFieldErrors msg="Please enter Agency Comments"/>
					<#-- <div class="character-limit" >You have <input readonly type="text" id="agencyCommentsLMcountdown" name="countdown" size="3" value="900" style="margin-top:7px;"> characters left</div> -->
					    
	                    <#else>
	                    <textarea id="agencyCommentsLM" name="agencyCommentsLM"  disabled  rows="10" cols="20" class="form-text-div">${projectEvaluationInitiation.agencyCommentsLM?default('')?html}</textarea>
	                <@macroCustomFieldErrors msg="Please enter Agency Comments"/>
					    
	                    </#if>                 
	                    
	                </div>
	           
                </div>
                </div>
                
                
                <div class="pib-evaluation">
                <h2 class="pib_sub_heading">Fieldwork Agencies</h2>
				
				<div class="pib-select_div">
					<label>Agency Performance for Project</label>
					
					<#if isAdminUser || isProjectOwner || isAboveMarketProjectContactUser || isAwardedExternalAgencyUser>
						<@renderAgencyPerfField name='agencyPerfFA' value=projectEvaluationInitiation.agencyPerfFA?default(-1) />
					<#elseif isExternalAgencyUser || projectContactHasReadonlyAccess || !canEditProject> 
						<@renderAgencyPerfField name='agencyPerfFA' value=projectEvaluationInitiation.agencyPerfFA?default(-1)  readonly=true />
					<#--<#elseif projectEvaluationInitiation.status?? && projectEvaluationInitiation.status == statics['com.grail.synchro.SynchroGlobal$StageStatus'].PROJ_EVAL_COMPLETED.ordinal()>
						<@renderAgencyPerfField name='agencyPerfFA' value=projectEvaluationInitiation.agencyPerfFA?default(-1)  readonly=true />-->
					 <#elseif !(isAboveMarket) && !(isCountryProjectContact || isCountrySPIContact) >
					 	<@renderAgencyPerfField name='agencyPerfFA' value=projectEvaluationInitiation.agencyPerfFA?default(-1)  readonly=true />
					<#elseif (isAboveMarket) && !(isAboveMarketProjectContactUser || isProjectOwner || isLegalUser || isProcUser) >
						<@renderAgencyPerfField name='agencyPerfFA' value=projectEvaluationInitiation.agencyPerfFA?default(-1)  readonly=true />
					<#else>	
						<@renderAgencyPerfField name='agencyPerfFA' value=projectEvaluationInitiation.agencyPerfFA?default(-1) />
					</#if>
				</div>
				
				<div class="region-inner">
					<label class='rte-editor-label'>BAT Comments</label>
                	<div class="form-text_div">
	                    <#if isAdminUser || isProjectOwner || isAboveMarketProjectContactUser || isAwardedExternalAgencyUser>
	                    		 <textarea id="batCommentsFA" name="batCommentsFA" rows="10"  cols="20" class="form-text-div">${projectEvaluationInitiation.batCommentsFA?default('')?html}</textarea>
			                <@macroCustomFieldErrors msg="Please enter BAT Comments"/>
							
						<#--	<div class="character-limit" >You have <input readonly type="text" id="batCommentsFAcountdown" name="countdown" size="3" value="900" style="margin-top:7px;"> characters left</div> -->
								                    		
	                    <#elseif !(isAboveMarket) && !(isCountryProjectContact || isCountrySPIContact) >
	                    	   <textarea id="batCommentsFA" name="batCommentsFA" rows="10"  disabled  cols="20" class="form-text-div">${projectEvaluationInitiation.batCommentsFA?default('')?html}</textarea>
	                    
	                    <#elseif (isAboveMarket) && !(isAboveMarketProjectContactUser || isProjectOwner || isLegalUser || isProcUser) >
	                    	<textarea id="batCommentsFA" name="batCommentsFA" rows="10"  disabled  cols="20" class="form-text-div">${projectEvaluationInitiation.batCommentsFA?default('')?html}</textarea>
	                    
	                    <#else>
			                    <textarea id="batCommentsFA" name="batCommentsFA" rows="10" <#if isExternalAgencyUser || projectContactHasReadonlyAccess || !canEditProject > disabled </#if> cols="20" class="form-text-div" >${projectEvaluationInitiation.batCommentsFA?default('')?html}</textarea>
			                <@macroCustomFieldErrors msg="Please enter BAT Comments"/>
							<#if !(isExternalAgencyUser || projectContactHasReadonlyAccess || !canEditProject )>
							<#-- <div class="character-limit" >You have <input readonly type="text" id="batCommentsFAcountdown" name="countdown" size="3" value="900" style="margin-top:7px;"> characters left</div> -->
							</#if>
						</#if>
	                </div>
	                <div class="region-inner">
					<label class='rte-editor-label'>Agency Comments</label>
                	<div class="form-text_div">
	                    <#if isAdminUser>
	                    	<textarea id="agencyCommentsFA" name="agencyCommentsFA" rows="10" cols="20" class="form-text-div">${projectEvaluationInitiation.agencyCommentsFA?default('')?html}</textarea>
	                <@macroCustomFieldErrors msg="Please enter Agency Comments"/>
					<#-- <div class="character-limit" >You have <input readonly type="text" id="agencyCommentsFAcountdown" name="countdown" size="3" value="900" style="margin-top:7px;"> characters left</div> -->
					
	                    <#elseif isAwardedExternalAgencyUser || isProjectOwner || isAboveMarketProjectContactUser>
	                    
	                    	<textarea id="agencyCommentsFA" name="agencyCommentsFA" rows="10" cols="20" class="form-text-div">${projectEvaluationInitiation.agencyCommentsFA?default('')?html}</textarea>
	                <@macroCustomFieldErrors msg="Please enter Agency Comments"/>
					<#-- <div class="character-limit" >You have <input readonly type="text" id="agencyCommentsFAcountdown" name="countdown" size="3" value="900" style="margin-top:7px;"> characters left</div> -->
					
					
	                    <#else>
	                    
	                    	<textarea id="agencyCommentsFA" name="agencyCommentsFA" disabled  rows="10" cols="20" class="form-text-div">${projectEvaluationInitiation.agencyCommentsFA?default('')?html}</textarea>
	                <@macroCustomFieldErrors msg="Please enter Agency Comments"/>
					
	                    </#if>
	                    
	                    
	                </div>
	           
                </div>
	           
                </div>
                </div>
                </div>
  
      		<div class="ld-div">
	        <div class="buttons">
	           <#if isAdminUser>
	           		<input type="submit" name="save pib" onclick="return validatePIBFormFields();" value="Save" class="save"/>
	           <#elseif canEditProject && !projectContactHasReadonlyAccess>
	           	  <#if isExternalAgencyUser >
	           	  		<#if isAwardedExternalAgencyUser>
	           	  			<input type="submit" name="save pib" onclick="return validatePIBFormFields();" value="Save" class="save"/>
	           	  		</#if>
	           	  <#else>
	           	  		<#if !(isAboveMarket) && !(isCountryProjectContact || isCountrySPIContact) >
	           	  		<#elseif (isAboveMarket) && !(isAboveMarketProjectContactUser || isProjectOwner || isLegalUser || isProcUser) >
	           	  		<#else>
	           	  			<input type="submit" name="save pib" onclick="return validatePIBFormFields();" value="Save" class="save"/>
	           	  		</#if>
	           	  </#if>	
	           </#if>
	        </div>
	       </div>
       </div>
        
        
      <!-- BEGIN sidebar column -->
      
<div id="jive-body-sidebarcol-container" class="j-column j-column-s j-content-extras">
<ul class="right-sidebar-list" id="synchro-action-box">
   <li><a  href="/synchro/current-status-multi!input.jspa?projectID=${project.projectID?c}" >View Current Status</a></li>
</ul>

<#if statics['com.grail.synchro.util.SynchroPermHelper'].canEditproject(user, projectID)>

	<div class="right-side-bar">
		<div class="right-side-list">
	<!-- Project Change Status Action -->
			<ul class="right-sidebar-list required-actions">
				<li class="view-field-btn"><a class="o-btn" href="/synchro/project-status!input.jspa?projectID=${projectID?c}">Change Project Status</a></li>	
			</ul>
		</div>
	</div>

</#if>
</div>
            </form>
            
            
            <!-- SYNCHRO BEGIN -->
		
		
	    </div>
        
        <!-- SYNCHRO ENDS -->
        
		
    </div>
     
</div>



<!-- END sidebar column -->
<script type="text/javascript">
   $j(document).ready(function() {
       AUTO_SAVE.register({form:$j("#project-eval"), projectID:${projectID?c}});
       PROJECT_STAGE_NAVIGATOR.initialize({
       <#if projectID??>
           projectId:${projectID?c},
       </#if>
           activeStage:6
       });

   });

/*Code to track read status of the document for current user and project */
<#assign effectiveUser = statics['com.grail.synchro.util.SynchroPermHelper'].getEffectiveUser() />


function limitText(limitField, limitCount, limitNum) {	

	if ($j("#"+limitField).val().length > limitNum) {
		$j("#"+limitField).val($j("#"+limitField).val().substring(0, limitNum));		
	} else {
		$j("#"+limitCount).val(limitNum - $j("#"+limitField).val().length);		
	}
}

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
		initiateRTE('batCommentsIM', 900);
		initiateRTE('agencyCommentsIM', 900);
		initiateRTE('batCommentsLM', 900);
		initiateRTE('agencyCommentsLM', 900);
		initiateRTE('batCommentsFA', 900);
		initiateRTE('agencyCommentsFA', 900);
	});


	/*Code to track read status of the document for current user and project */
	ProjectReadTracker.setReadTrackInfo(${projectID?c}, ${user.ID?c}, 5);	
</script>

<script type="text/javascript">
<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.evaluation.view.text" /></#assign>	
	var projName = "${project.name?js_string}";
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROJECT.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].PROJECT_EVALUATION.getId()}, "${i18CustomText}", projName, ${projectID?c}, ${user.ID?c}, ${endMarketId?c});
</script>