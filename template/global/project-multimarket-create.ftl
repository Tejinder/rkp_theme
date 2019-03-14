<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<@resource.template file="/soy/userpicker/userpicker.soy" />
<head>
    <#--<script type="text/javascript" src="<@s.url value='/dwr/engine.js' />"></script>
    <script type="text/javascript" src="<@s.url value='/dwr/interface/FieldMappingUtil.js' />"></script>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/InviteUserUtil.js' />"></script>
	<script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>-->
</head>

<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/error-macros.ftl" />


<#assign defaultCurrency = JiveGlobals.getJiveIntProperty("grail.default.currency", -1) />
<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
<#assign isProjectOwner=false>
<#if projectID??>
	<#assign isProjectOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isProjectOwner(projectID) />
</#if>

<script src="${themePath}/js/synchro/project-form.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>

<#assign error_num = '<@s.text name="project.initiate.project.name.error"/>' />
<div class="project-initiate-container">
    <h3><@s.text name="project.initiate.heading"/></h3>
    <div class="project_details create_project">
        <div id="jive-error-box" class="jive-error-box" style="display:none">
            <div>                
                <span><@s.text name="project.mandatory.error"/></span>
            </div>
        </div>
        <form action="<@s.url action='create-multimarket-project.jspa'/>" method="post" name="form-create" id="form-create">
            <div class="form-text_div">
                <!-- Project Name -->
                <label><@s.text name="project.initiate.project.name"/></label>
                <input type="text" name="name" value="${project.name?default('')}" size="30" maxlength="128" class="form-text" placeholder='<@s.text name="project.initiate.project.name"/>'>
            <#assign error_msg><@s.text name='project.error.name' /></#assign>
            <@macroCustomFieldErrors msg=error_msg />
            <@macroFieldErrors name="name"/>
                <span class="synchro-note synchro-opt-label">(<@s.text name='project.initiate.name.note' />)</span>
            </div>
			
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
					<#--<@macroCustomFieldErrors msg=error_msg />-->
					<span class="jive-error-message" style="display:none; position:static">${error_msg?html}</span>
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
				<!-- TODO Make it multi-select-->
				<!--
			   <#--<div class="form-select_div_brand">-->
                    <#--<label><@s.text name="project.initiate.project.methodologyproposed"/><span class="synchro-opt-label">(<@s.text name='project.initiate.optional.note' />)</span></label>-->
					<#--<#assign defaultPMethodologyID = JiveGlobals.getJiveIntProperty("grail.synchro.default.proposedmethodology", -1) />-->
					<#--<@renderProposedMethodologyGroupField name='proposedMethodology' value=project.proposedMethodology?default(defaultPMethodologyID) /> .-->
					<#--<#assign error_msg><@s.text name='project.error.proposedmethodologygroup' /></#assign>-->
					<#--<@macroCustomFieldErrors msg=error_msg />-->
                <#--</div>-->
				-->
            </div>

			<div class="region-inner">
                <!-- Proposed Methodology Multi Select -->
                <label class="label_b"><@s.text name="project.initiate.project.methodologyproposed"/><#--<span class="synchro-opt-label">(<@s.text name='project.initiate.optional.note' />)</span>--></label>
                <div class="form-select_div_main pit-category">
					<#assign defaultPMethodologyID = JiveGlobals.getJiveIntProperty("grail.synchro.default.proposedmethodology", -1) />
					<@renderProposedMethodologyMultiSelect name='proposedMethodology' value=project.proposedMethodology?default([defaultPMethodologyID])/>
                </div>
            </div>
			
			 <div class="region-inner">
                 <!-- Regions -->
                <label class="label_b"><@s.text name="project.initiate.endmarkets"/>&nbsp;(Location/Fieldwork):</label>
                <div class="form-select_div_main pit-category">
					<@showMarketsFieldSection name='markets' regions=project.regions?default('-1') areas=project.areas?default('-1') endMarkets=project.endMarkets?default('-1') validate=true /> 
					<#assign error_msg><@s.text name='project.error.endmarket' /></#assign>
					<span class="jive-error-message" style="display:none; position:static">${error_msg?html}</span>
                </div>
            </div>
            
            <!--
            <div class="region-inner">

                
               <label class="label_b">Areas</label>
                <div class="form-select_div_main pit-category">
					<@showAreaFieldSection name='areas' value=project.areas?default('-1') validate=true /> 
					<#assign error_msg><@s.text name='project.error.endmarket' /></#assign>
					<span class="jive-error-message" style="display:none; position:static">${error_msg?html}</span>
                </div>
            </div>
			
			 <div class="region-inner">

                
               <label class="label_b"><@s.text name="project.initiate.endmarkets"/>&nbsp;(Location/Fieldwork):</label>
               
                <div class="form-select_div_main pit-category">
					<@showEndMarketFieldSection name='endMarkets' value=project.endMarkets?default('-1') validate=true /> 

					
					<#assign error_msg><@s.text name='project.error.endmarket' /></#assign>

					
					<span class="jive-error-message" style="display:none; position:static">${error_msg?html}</span>
                </div>
            </div>
            
            -->
            <div class="region-inner">
                <!-- Project Start Year Month Date -->
                <div class="form-select_div">
                    <label><@s.text name="project.initiate.project.start"/></label>
					
					<#-- <@jiveform.datetimepicker id="startDate" name="startDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/> -->
					<@synchrodatetimepicker id="startDate" name="startDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
					<#assign error_msg><@s.text name='project.error.startdate' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					<@macroFieldErrors name="startDate"/>
                </div>
                <!-- Project Completion Year Month Date -->
                <div class="form-select_div form-select_div_project_completion">
                    <label><@s.text name="project.initiate.project.end"/></label>
					
					<#-- <@jiveform.datetimepicker id="endDate" name="endDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/> -->
					<@synchrodatetimepicker id="endDate" name="endDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
					<#assign error_msg><@s.text name='project.error.enddate' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
					<@macroFieldErrors name="endDate"/>
                </div>
            </div>
            <div class="region-inner">
                <!-- Project Owner -->
            <#if project?? && project.projectOwner??>                
				<#assign ownerUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(project.projectOwner) />
            <#else>
                <#assign ownerUserName = '' />
            </#if>
                <div class="form-select_div">
                    <label>Above Market SP&I Contact</label>
                    <div>
                        <input type="text" tabindex="1" name="projectOwner" id="projectOwner" value="${ownerUserName}" class="j-user-autocomplete j-ui-elem" autocomplete="off" />
						<#assign error_msg><@s.text name="project.error.owner"/></#assign>
						<@macroCustomFieldErrors msg=error_msg />
                    </div>
                </div>
				
            </div>
			
			 <div class="region-inner">          
                <div class="form-select_div">
                    <label><@s.text name="project.initiate.project.caprating"/></label>                    
					<@renderCAPRatingField name='capRating' value='${project.capRating?default(-1)}' />
					<#assign error_msg><@s.text name="project.error.caprating"/></#assign>
                    <@macroCustomFieldErrors msg=error_msg />
                </div>				
            </div>
		<!-- Hidden fields -->
		<input type="hidden" id="totalCost" name="totalCost" value="" />
		<input type="hidden" id="totalCostCurrency" name="totalCostCurrency" value="" />
		 <div class="region-inner"> 
			<!-- Add Location and Funding Link-->
			<div class="add-investment-button">
				<input type="button" class="project_addfunding_btn" onclick="openAddInvestmentDetailsPIT();" value="<@s.text name='project.initiate.project.addfund.label'/>" />
            </div>
			
			<#include "/template/global/include/investment-funding.ftl" />			
			<span class="jive-error-message" id="investment-error" style="display:none">Please Add at-least one location and funding</span>
		</div>
		
		  <div class="region-inner">
                <!-- Project Initial Cost Field -->
				<#if project??>
					<#assign totalCostValue = project.totalCost?default('') />
				<#else>
					<#assign totalCostValue = '' />
				</#if>
				
                <div class="form-select_div">
                    <div class="pit-estimate-cost">
                        <label><@s.text name="project.initiate.project.tcost"/></label>                        
                        <input type="text" name="totalCost-display" id="totalCost-display" class="text_field numericfield longField" value="${project.totalCost?default('')}"/>
                        <#assign error_msg><@s.text name="project.error.tcost"/></#assign>						
                        <@macroCustomFieldErrors msg=error_msg class="numeric-error"/>			
                    </div>
                    <div class="pit-currency">
                        <label>Currency</label>
                        <@renderCurrenciesField name='totalCostCurrency-display' value=project.totalCostCurrency?default(-1) disabled=false/>
                        
                        <@macroCurrencySelectError msg="Please select currency" />
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
	                    <input type="radio" id="confidential2" name="confidential" value="0" >
	                    <span>No</span>
	                <#else>
	                	<input type="radio" id="confidential1" name="confidential" value="1">
	                    <span>Yes</span>
	                    <input type="radio" id="confidential2" name="confidential" value="0" checked="true">
	                    <span>No</span>
	                </#if>
                </div>
            </div>
            
            -->
            <!-- Project Publish Button -->
            <div class="buttons">
            	<a id="mproject_save_draft_link" href="javascript:void(0);" class="publish-details"><@s.text name="project.initiate.project.save.draft.label"/></a>
                <a id="mproject_publish_link" href="javascript:void(0);" style="margin-left: 10px;" class="publish-details"><@s.text name="project.initiate.project.create.label"/></a>
            </div>
            
            <input type="hidden" name="draft" id="draft" value="" />
            <input type="hidden" name="draftLocation" id="draftLocation" value="" />
            <input type="hidden" name="multiMarketProject" id="multiMarketProject" value="multiMarketProject" />
            
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
<script type="text/javascript">

	function showInvestments() {
        $j("#pitWindow .investment-details-table tbody").empty();
        
    <#if fundingInvestments??>
	    <#list fundingInvestments as fundingInvestment>
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
	            cost:${fundingInvestment.estimatedCost?c},
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
	            data["canModify"] = "true";
	        <#else>
	            data["canModify"] = "false";
	        </#if>
	        
	        <#if  user.ID==fundingInvestment.projectContact || isAdminUser || isProjectOwner>
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
	                data["canModify"] = "true";
	            </#if>
	            <#if isAdminUser || user.ID==fundingInvestment.spiContact || user.ID==fundingInvestment.projectContact || isProjectOwner>
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
	
	        showInvestmentDetailsPIT(data);
	    </#list>
	 </#if>
    }
	var defaultCurrency = ${defaultCurrency?c};	
	
    var addDocumentPopup = null;
	var select_fieldType;
    $j(document).ready(function() {
        <#--AUTO_SAVE.register({-->
            <#--objectID:<#if projectID??>${projectID?number}<#else>null</#if>,-->
            <#--objectType:"${statics['com.grail.synchro.SynchroGlobal$AutoSavePage'].PIT.toString()}",-->
            <#--form:$j("#form-create")-->
        <#--});-->


	   /*Load start and end dates*/
		<#if project.startDate?? >
		    var _startDate = "${project.startDate?string('dd/MM/yyyy')}";
		    $j("#startDate").val(_startDate);
		</#if>
		
		<#if project.endDate?? >
			var _endDate = "${project.endDate?string('dd/MM/yyyy')}";
			$j("#endDate").val(_endDate);
		</#if>
	
	showInvestments();
    initializeUserPicker({$input:$j("#projectOwner"),name:'projectOwner',defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});
	
    <#if project?? && project.projectOwner??>
        $j('input[type=hidden], input[name=projectOwner]').val(${project.projectOwner?c});
    </#if>
    
    <#if project.brand??>
    	$j("#brand").val("${project.brand}");
	</#if>
	
    });

	/*Brand ID - Name MAP*/
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
	
	var userID = ${user.ID?c};	

/* Initialization of Editor */
$j(document).ready(function () {
	initiateRTE('description', 1500, true);
	
	if(window.location.href.indexOf("savefirst") > -1) 
	{
	    var projectName = $j("input[name=name]");
   		var projectCode = $j("input[name=projectID]");

		dialog({
        title:"Message",
        html:"<p>Your project '"+projectName.val() +"' with 'Project Code: "+projectCode.val() +"' has been successfully saved as Draft.<br/><br/>You can access the project anytime from <a href='/synchro/draft-dashboard.jspa'>'My Dashboard'</a> and confirm it using the 'Start Project' button at the bottom of the PIT screen.</p>",
      
  		buttons:{
                 "Ok": function() {
                    window.location.href = "/synchro/dashboard.jspa";
                }
            }
        
    	});
      /*	buttons:{
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
