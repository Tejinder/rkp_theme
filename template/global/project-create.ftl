<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<@resource.template file="/soy/userpicker/userpicker.soy" />



<style>


    .form-select_div .j-form-datepicker-btn { 
    margin-top: 12px !important;
    position: relative !important;
    top: 5px !important;
    margin-left: 5px;
}
    
</style>

<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/error-macros.ftl" />


<script src="${themePath}/js/synchro/project-form.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>

<#assign error_num = '<@s.text name="project.initiate.project.name.error"/>' />

<#assign defaultCurrency = statics['com.grail.synchro.util.SynchroUtils'].getDefaultCurrencyByUser(user) />
<#assign userCountryID = statics['com.grail.synchro.util.SynchroUtils'].getCountryByUser(user) />

<div class="project-initiate-container">
<h3><@s.text name="project.initiate.heading"/></h3>
<div class="project_details create_project">
<div id="jive-error-box" class="jive-error-box" style="display:none">
    <div>
    <#--<span class="jive-icon-med jive-icon-redalert"></span>-->
        <span><@s.text name="project.mandatory.error"/></span>
    </div>
</div>
<form action="<@s.url action='create-project.jspa'/>" method="post" name="form-create" id="form-create">
<div class="form-text_div">
    <!-- Project Name -->
    <label><@s.text name="project.initiate.project.name"/></label>
    <input type="text" name="name" value="${project.name?default('')}" size="30" maxlength="128" class="form-text" placeholder='<@s.text name="project.initiate.project.name"/>'>
<#assign error_msg><@s.text name='project.error.name' /></#assign>
<@macroCustomFieldErrors msg=error_msg />
<@macroFieldErrors name="name"/>
    <span class="synchro-note synchro-opt-label">(<@s.text name='project.initiate.name.note' />)</span>
</div>

<#--
            <label class='pit-description-rte'><@s.text name="project.initiate.project.description"/></label>
            <div class="form-textarea_div">
                <textarea name="description" id="description" cols="60" rows="5" class="form-textarea" placeholder="Project Description">${project.description?default('')}</textarea>
                <@macroCustomFieldErrors msg="Please enter the Project description"/>
                <#assign error_msg><@s.text name='project.error.description' /></#assign>
                <@macroCustomFieldErrors msg=error_msg />
                <@macroFieldErrors name="description"/>
                <textarea style="display:none;" id="descriptionText" name="descriptionText">${project.descriptionText?default('')?html}</textarea>
            </div>
            -->

<div class="region-inner">
    <label class='pit-editor-label'>Project Description</label>
    <div class="form-text_div pit-description-textarea">
        <textarea id="description" name="description" rows="10" cols="20" class="form-textarea">${project.description?default('')?html}</textarea>
    <@macroCustomFieldErrors msg="Please enter the Project description" class='textarea-error-message'/>
    </div>
    <textarea style="display:none;" id="descriptionText" name="descriptionText">${project.descriptionText?default('')?html}</textarea>
</div>



<div class="region-inner">
    <!-- Category Type Multi Select -->
    <label class="label_b"><@s.text name="project.initiate.project.category"/></label>
    <div class="form-select_div_main pit-category">
    <#assign defaultCategoryID = JiveGlobals.getJiveIntProperty("grail.synchro.default.category", 1) />
                <@renderCategoryTypeField name='categoryType' value=project.categoryType?default([defaultCategoryID]) />
				<#assign error_msg><@s.text name='project.error.category' /></#assign>
				<@macroCustomFieldErrors msg=error_msg />
    </div>
</div>

<div class="region-inner">
    <!-- Brand -->
    <div class="form-select_div">
        <label><@s.text name="project.initiate.project.brand"/></label>
    <#assign defaultBrandID = JiveGlobals.getJiveIntProperty("grail.synchro.default.brand", 1) />
    <@renderBrandField name='brand' value=project.brand?default(defaultBrandID)/>
    <#assign error_msg><@s.text name='project.error.brand' /></#assign>
    <@macroCustomFieldErrors msg=error_msg />
    </div>


    <#--<!-- Methodology Type &ndash;&gt;-->
    <#--<div class="form-select_div_brand">-->
        <#--<label><@s.text name="project.initiate.project.methodology"/></label>-->
    <#--<#assign defaultMTypeID = JiveGlobals.getJiveIntProperty("grail.synchro.default.methodology", -1) />-->
    <#--<@renderMethodologyField name='methodologyType' value=project.methodologyType?default(defaultMTypeID)/>-->
    <#--<#assign error_msg><@s.text name='project.error.methodology' /></#assign>-->
    <#--<@macroCustomFieldErrors msg=error_msg />-->
    <#--</div>-->


</div>

<div class="region-inner">
    <!-- Methodology Group -->
    <div class="form-select_div">
        <label><@s.text name="project.initiate.project.methodologygroup"/></label>
    <#assign defaultMGroupID = JiveGlobals.getJiveIntProperty("grail.synchro.default.methodologygroup", -1) />
    <@renderMethodologyGroupField name='methodologyGroup' value=project.methodologyGroup?default(defaultMGroupID)/>
    <#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>
    <@macroCustomFieldErrors msg=error_msg />
    </div>
    <!-- Proposed Methodology -->
    <!--
				<div class="form-select_div_brand">
					<label><@s.text name="project.initiate.project.methodologyproposed"/><span class="synchro-opt-label">(<@s.text name='project.initiate.optional.note' />)</span></label>					
					<#assign defaultPMethodologyID = JiveGlobals.getJiveIntProperty("grail.synchro.default.proposedmethodology", -1) />
					<#if project.proposedMethodology?? && project.proposedMethodology[0]??>
						<#assign defaultPMethodologyID = project.proposedMethodology[0] />				
					</#if>
					<@renderProposedMethodologyGroupField name='proposedMethodology' value=defaultPMethodologyID />
					<#assign error_msg><@s.text name='project.error.proposedmethodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
                </div>
				-->
</div>

<div class="region-inner">
    <!-- Proposed Methodology Multi Select -->
    <label class="label_b"><@s.text name="project.initiate.project.methodologyproposed"/><#--<span class="synchro-opt-label">(<@s.text name='project.initiate.optional.note' />)</span>--></label>
    <div class="form-select_div_main pit-category">
    <#assign defaultPMethodologyID = JiveGlobals.getJiveIntProperty("grail.synchro.default.proposedmethodology", -1) />
					<@renderProposedMethodologyMultiSelect name='proposedMethodology' value=project.proposedMethodology?default([defaultPMethodologyID]) />
					<#assign error_msg><@s.text name='project.error.proposedmethodologygroup' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
    </div>
</div>

<div class="region-inner">
    <!-- End Markets -->
    <div class="form-select_div">
        <label><@s.text name="project.initiate.endmarket"/></label>
    <@renderEndMarketSingleSelectFld name='endMarkets' value="${endMarketId?default(userCountryID?c)}" />
    <#assign error_msg><@s.text name='project.error.endmarket' /></#assign>
    <@macroCustomFieldErrors msg=error_msg />
    </div>
</div>

<div class="region-inner">
    <!-- Project Start Year Month Date -->
    <div class="form-select_div">
        <label><@s.text name="project.initiate.project.start"/></label>
   
   <#-- <@jiveform.datetimepicker id="startDate" name="startDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
   
	<@synchrodatetimepicker id="startDate" name="startDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
    <#assign error_msg><@s.text name='project.error.startdate' /></#assign>
    <@macroCustomFieldErrors msg=error_msg />
    <@macroFieldErrors name="startDate"/>
    </div>

    <!-- Project Completion Year Month Date -->
    <div class="form-select_div form-select_div_project_completion">
        <label><@s.text name="project.initiate.project.end"/></label>
 
 <#--   <@jiveform.datetimepicker id="endDate" name="endDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/> -->
 
 <@synchrodatetimepicker id="endDate" name="endDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
    <#assign error_msg><@s.text name='project.error.enddate' /></#assign>
    <@macroCustomFieldErrors msg=error_msg />
    <@macroFieldErrors name="endDate"/>
    </div>
</div>

<div class="region-inner">
    <!-- Project Initial Cost Field -->
    <div class="form-select_div">
        <div class="pit-estimate-cost">
            <label><@s.text name="project.initiate.project.cost"/></label>

            <input type="text" name="initialCost[0]" class="text_field numericfield longField" <#if project.initialCost?? && project.initialCost[0]??>value="${project.initialCost[0]?default('')}"<#else>value=""</#if> />
        <#assign error_msg><@s.text name="project.error.cost"/></#assign>
        <@macroCustomFieldErrors msg=error_msg class="numeric-error"/>
        </div>
        <div class="pit-currency">
            <label>Currency</label>
        <#if project.initialCostCurrency?? && project.initialCostCurrency[0]??>
            <@renderCurrenciesField name='initialCostCurrency[0]' value=project.initialCostCurrency[0] disabled=false/>
        <#else>
            <@renderCurrenciesField name='initialCostCurrency[0]' value=defaultCurrency disabled=false/>
        </#if>
        <@macroCurrencySelectError msg="Please select currency" />
        </div>
    </div>

</div>

<div class="region-inner">
    <!-- Project Owner -->
<#if project?? && project.projectOwner??>
<#--<#assign ownerUserName = jiveContext.getSpringBean("userManager").getUser(project.projectOwner).getName() />-->
    <#assign ownerUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner) />
<#else>
    <#assign ownerUserName = '' />
</#if>
    <div class="form-select_div">
        <label><@s.text name="project.initiate.project.owner"/></label>
        <div>
           <#-- <input type="text" tabindex="1" name="projectOwner" id="projectOwner" value="${ownerUserName}"  />-->
		   <input type="text" tabindex="1" name="projectOwner" id="projectOwner" value="${ownerUserName}" class="j-user-autocomplete j-ui-elem projectOwner" placeholder="" srole="20" autocomplete="off" />
			
			<#--   <input type="text" id="projectOwner" name="projectOwnerAuto" />-->

        <#assign error_msg><@s.text name="project.error.owner"/></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>
    </div>

    <!-- Project SP&I Contact -->
<#if project?? && project.spiContact?? && project.spiContact.size() &gt; 0 >
<#--<#assign spiContactName = jiveContext.getSpringBean("userManager").getUser(project.spiContact).getName() />-->
    <#assign spiContactName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.spiContact.get(0)) />
<#else>
    <#assign spiContactName = '' />
</#if>
    <div class="form-select_div form-select_div_project_completion">
        <label><@s.text name="project.initiate.project.spi"/></label>
        <div>
            <input type="text" tabindex="1" name="spiContact" value="${spiContactName}" id="spiContact" class="j-user-autocomplete-1 j-ui-elem" srole="1" autocomplete="off" />

        <#assign error_msg><@s.text name="project.error.spi"/></#assign>
        <@macroCustomFieldErrors msg=error_msg />
        </div>
    </div>

</div>

<div class="region-inner">
<@projectBudgetYearField name="budgetYear" value=project.budgetYear/>
</div>

<#--
<div class="form-text_div confidential_radio_div">
    <label>Confidential Project</label>
    <div class="inner_div">
    <#if project.confidential?? && project.confidential>
        <input type="radio" id="confidential1" name="confidential" value="1" checked="true">
        <span>Yes</span>
        <input type="radio" id="confidential2" name="confidential"  value="0" >
        <span>No</span>
    <#else>
        <input type="radio" id="confidential1" name="confidential"  value="1">
        <span>Yes</span>
        <input type="radio" id="confidential2" name="confidential"  value="0" checked="true">
        <span>No</span>
    </#if>
    </div>
</div>
-->

<!-- Project Publish Button -->
<div class="buttons">
    <a id="project_save_draft_link" href="javascript:void(0);" class="publish-details"><@s.text name="project.initiate.project.save.draft.label"/></a>
    <a id="project_publish_link" href="javascript:void(0);" style="margin-left: 10px;"  class="publish-details"><@s.text name="project.initiate.project.create.label"/></a>
</div>
<input type="hidden" name="draft" id="draft" value="" />
<input type="hidden" name="draftLocation" id="draftLocation" value="" />

<div style="display:none">
<#if projectID??>
    <input type="text" id="projectID" name="projectID" value="${projectID?c?default('')}"  />
<#else>
    <input type="text" id="projectID" name="projectID" value="${projectID?default('')}"  />
</#if>
</div>


<@jive.token name="synchro.project.create" lazy=true />
</form>
</div>
</div>

<#--<#include "/template/global/include/synchro-invite-user.ftl" />-->

<input type="hidden" name="selectPeople" id="selectPeople" value="spi" />
 <script>
        $j(document).ready(function() {

		  /* var projectOwner = <@jive.userAutocompleteUsers users=approvers />
            var userpicker = new jive.UserPicker.Main({
                multiple: true,
                startingUsers: projectOwner,
                userParam: 'userID',
                $input: $j('#projectOwner')
            });
			*/
			
        });
   </script>
<script type="text/javascript">


    var addDocumentPopup = null;
    var select_fieldType;
    jQuery(document).ready(function() {

    <#--AUTO_SAVE.register({-->
    <#--objectID:<#if projectID??>${projectID?number}<#else>null</#if>,-->
    <#--objectType:"${statics['com.grail.synchro.SynchroGlobal$AutoSavePage'].PIT.toString()}",-->
    <#--form:jQuery("#form-create")-->
    <#--});-->

        /*Load start and end dates*/
    <#if project.startDate?? >
        var _startDate = "${project.startDate?string('dd/MM/yyyy')}";
        jQuery("#startDate").val(_startDate);
    </#if>

    <#if project.endDate?? >
        var _endDate = "${project.endDate?string('dd/MM/yyyy')}";
        jQuery("#endDate").val(_endDate);
    </#if>




      //  initializeUserPicker({$input:jQuery("#projectOwner"),name:'projectOwner',defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});
      //  initializeUserPicker({$input:jQuery("#spiContact"),name:'spiContact',defaultFilters:{'role':1,'roleEnabled':false}});
	  
	  initializeUserPicker({$input:$j("#projectOwner"),name:'projectOwner',defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});
	  initializeUserPicker({$input:$j("#spiContact"),name:'spiContact',defaultFilters:{'role':1, 'roleEnabled':false}});

    <#if project?? && project.projectOwner??>
        jQuery('input[type=hidden], input[name=projectOwner]').val(${project.projectOwner?c});
    </#if>

    <#if project?? && project.spiContact??>
    <#--  jQuery('input[type=hidden], input[name=spiContact]').val(${project.spiContact?c}); -->
    </#if>

    });

    /*Brand ID - Name MAP*/
    var brandFieldMap = {};
    <#assign brandsMap = statics['com.grail.synchro.SynchroGlobal'].getBrands() />
    <#list brandsMap.keySet() as brandMap>
    brandFieldMap[${brandMap}] = "${brandsMap.get(brandMap)}";
    </#list>

    /* Initialization of Editor */
    jQuery(document).ready(function () {	
	   initiateRTE('description', 1500, true);
        if(window.location.href.indexOf("savefirst") > -1)
        {
            var projectName = jQuery("input[name=name]");
            var projectCode = jQuery("input[name=projectID]");

            dialog({
                title:"Message",
                html:"<p>Your project '"+projectName.val() +"' with 'Project Code: "+projectCode.val() +"' has been successfully saved as Draft.<br/><br/>You can access the project anytime from <a href='/synchro/draft-dashboard.jspa'>'My Dashboard'</a> and confirm it using the 'Start Project' button at the bottom of the PIT screen.</p>",

                buttons:{
                    "Ok": function() {
                        window.location.href = "/synchro/dashboard.jspa";
                    }
                }

            });
            /*buttons:{
                    "Continue":function() {
            		            closeDialog();
					        
                    },
                    "Exit": function() {
                        window.location.href = "/synchro/home";
                    }
                }
            
        	});*/
        }


    });
	

</script>
