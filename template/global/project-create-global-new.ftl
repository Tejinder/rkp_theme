<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<@resource.template file="/soy/userpicker/userpicker.soy" />



<style>


.form-select_div .j-form-datepicker-btn { 
    margin-top: 12px !important;
    position: relative !important;
    top: 5px !important;
    margin-left: 5px;
}
.ui-dialog{max-width:600px !important;}

</style>

 <link rel="stylesheet" href="${themePath}/style/multi-select.css" type="text/css" media="all" />
<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/error-macros.ftl" />

<#assign synchroUserNames = statics['com.grail.synchro.util.SynchroPermHelper'].getSynchroUserNames() />

<script>
	var methodologyMultipleMessageText='<@s.text name="project.methodology.multiple.message"/>';
	var currencyChangeMessageText='<@s.text name="project.currency.change.message"/>';
	var currencyChangeMessage = false;
</script>

<#--<script src="${themePath}/js/synchro/project-form.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script> -->
<script src="${themePath}/js/synchro/project-form-new.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>

<script src="${themePath}/js/synchro/second.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/autosearch2.js" type="text/javascript"></script>

 <script type="text/javascript">
       $j(document).ready(function() {
        //$j('.chosen-select').chosen();
		$j('.chosen-select').chosen({ allow_single_deselect: true });
        //$j('.chosen-select-deselect').chosen({ allow_single_deselect: true });
		$j(".chosen-search input").removeAttr("tabindex");
		
      });
	  
	  $j( function() {
		var arr = []; 
	
		<#list synchroUserNames as usname >
		  <#if usname??>
			  var userName = "${usname}";
			  arr.push(userName);
		  </#if>
		</#list>
		
		
		
	   
	     
	    $j("#projectManagerName").autocomplete({source: arr,select:function(){
		$j('.full-width .jive-error-message').hide(); }
	   });
	 });
    </script>

<#assign error_num = '<@s.text name="project.initiate.project.name.error"/>' />

<#assign defaultCurrency = statics['com.grail.synchro.util.SynchroUtils'].getDefaultCurrencyByUser(user) />
<#assign userCountryID = statics['com.grail.synchro.util.SynchroUtils'].getCountryByUser(user) />
<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />

<div class="project-initiate-container">
<#--<h3><@s.text name="project.initiate.heading"/></h3> -->
<div class="project_details create_project">
<div id="jive-error-box" class="jive-error-box" style="display:none">
    <div>
    <#--<span class="jive-icon-med jive-icon-redalert"></span>-->
        <span><i class="warningErr"></i><@s.text name="project.mandatory.error"/></span>
    </div>
</div>
<form action="<@s.url action='create-project-global.jspa'/>" method="post" name="form-create" id="form-create">
 <!-- PROJECT OVERVIEW STARTS -->
 <div class="end_market_details" style="display:block;">
	 <div class="">
		<h3 id="block_header_1" onclick="javascript:toggleProjectOverview();">Project Overview
						<a id="legend_1" href="javascript:void(0);" class="close-form"></a>
					</h3>
		 
		 <div id="project_overview" class="pib_angola" >
		<span id="normalProjects"><i>Please enter the project details. All details are mandatory</i></span>
		<span id="fielworkProjects" style="display:none"><i>Please enter the project details. All details are mandatory, unless specified</i></span>
		
		    <div class="topPanelWell">
		    <div class="region-inner">
				<label>Project Name</label>
				<div class="form-text_div">
					<!-- Project Name -->
					
					<input type="text" name="name" value="${project.name?default('')}" size="30" maxlength="128" class="form-text project_overview_project_name_width" placeholder='<@s.text name="project.initiate.project.name"/>'   onfocus="this.placeholder = ''" onblur="this.placeholder = '<@s.text name="project.initiate.project.name"/>'">
				
				<@macroCustomFieldErrors  msg="Please enter Project Name" />
				
				<@macroFieldErrors name="name"/>
					<#--<span class="synchro-note synchro-opt-label">(<@s.text name='project.initiate.name.note' />)</span> -->
				</div>
                  
				</div>

				<div class="region-inner">
					<label class='pit-editor-label'>Project Description</label>
					<div class="form-text_div pit-description-textarea">
						<textarea id="description" name="description" rows="10" cols="20" class="form-textarea"   placeholder="Enter Project Description">${project.description?default('')?html}</textarea>
					<@macroCustomFieldErrors msg="Please enter Project Description" class='textarea-error-message description-validation'/>
					</div>
					<textarea style="display:none;" id="descriptionText" name="descriptionText">${project.descriptionText?default('')?html}</textarea>
				</div>
			
			
				<div class="region-inner">
					<!-- Brand -->
					
					
					<div class="form-select_div " id="refSynchroCodeDiv" style="display:none">
					
						<label>Reference Synchro Code
							<span class="tooltip-wrap"><span class="tip-ico"></span><div class="bubble">Provide the Synchro Code for the market study associated with this project.If you have not received the project code, reach out to the market contact for details. <div class="bubble-arrow"></div></div>
							</span>
						</label>

						<div>
							   
							<input type="text"  name="refSynchroCode" placeholder="Enter Synchro Code" value="" id="refSynchroCode"  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter Synchro Code' "/>
							<span class="jive-error-message" id="referenceCodeError" style="display:none">Please enter Numeric Value</span>
						</div>
					</div>

</div>
				

                   
				
				
				<#if globalProjectType?? && globalProjectType=="GLOBAL" >
				
			
				<input type="hidden" name="globalProjectType" value="${globalProjectType}">
			
				<div class="region-inner">
					
					<#assign selectedEndMarket=-1 />
					<#assign showRefProjectMessage="" />
					
					<#if endMarketDetails?? && endMarketDetails?size gt 0 >
						<#assign selectedEndMarket= endMarketDetails.get(0).endMarketID />
					</#if>
					<label class="label_b">Research End Market</label>
					<div class="col-lg-6">
				 
					<#if statics['com.grail.synchro.util.SynchroPermHelper'].isRegionalUserType() >
					
						<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets'   >
							<option value=""></option>
							
							<#assign userRegionBudgetLocation = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationRegions(user) />
							<#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
							<#list userRegionBudgetLocation as uRegionBugLoc>
								<#if project?? && project.budgetLocation?? && endMarketIds?? && endMarketIds?seq_contains(uRegionBugLoc)>
									<option  value="${uRegionBugLoc}" selected >${regions.get(uRegionBugLoc?int)}</option>
								<#else>
									<option  value="${uRegionBugLoc}" >${regions.get(uRegionBugLoc?int)}</option>
								</#if>
							</#list>
						</select>
					
					<#else>	
						
						<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets'   >
							<option value=""></option>
							<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getGlobalEndMarket() />
							<#list endMarkets.keySet() as endMarketkey>
								<option value="${endMarketkey?c}" <#if endMarketIds?? && endMarketIds?seq_contains(endMarketkey)> selected </#if> >${endMarkets.get(endMarketkey)}</option>
							</#list>
						</select>
					</#if>	
						<span class="jive-error-message" id="endMarketError" style="display:none">Please select Research End Market</span>
					
					</div>
				</div>
				
				<#else>
					<div class="region-inner">
						
						<#assign selectedEndMarket=-1 />
						<#assign showRefProjectMessage="" />
						
						<#if endMarketDetails?? && endMarketDetails?size gt 0 >
							<#assign selectedEndMarket= endMarketDetails.get(0).endMarketID />
						</#if>
						<label class="label_b">Research End Market(s)</label>
						<div class="col-lg-6">
					  <#assign endMarketTypeMap = statics['com.grail.synchro.SynchroGlobal'].getEndmarketMarketTypeMap() />
					 
							<select data-placeholder="Select Research End Market" class="chosen-select" id = "endMarkets" name='endMarkets'  multiple >
							  <option value=""></option>
								   <#assign endMarketRegions = statics['com.grail.synchro.SynchroGlobal'].getRegionEndMarketsMapping() />
								   <#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
								   <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getNonEUEndMarkets() />
								   
										<#assign endMarketRegionsKeySet = endMarketRegions.keySet() />
										<#if (endMarketRegions?has_content)>
											<#list endMarketRegionsKeySet as key>
												<#assign region = endMarketRegions.get(key) />
												 <optgroup label="${regions.get(key)}">
													 <#assign endMarketKeySet = endMarketRegions.get(key).keySet() />
													 <#list endMarketKeySet as endMarketkey>
														<#if endMarketIds?? && endMarketIds?size gt 0 &&  endMarkets?? && endMarkets.get(endMarketkey)??>
														<option value="${endMarketkey?c}" eu="${endMarketTypeMap.get(endMarketkey)}" <#if endMarketIds?seq_contains(endMarketkey)> selected </#if>>${endMarkets.get(endMarketkey)}</option>
														<#if endMarketTypeMap.get(endMarketkey)==0>
														<#else>
															<#assign showRefProjectMessage="no" />
														</#if>
														
														<#else>
															<#if endMarkets?? && endMarkets.get(endMarketkey)??>
															<option value="${endMarketkey?c}" eu="${endMarketTypeMap.get(endMarketkey)}" >${endMarkets.get(endMarketkey)}</option>
															</#if>
														</#if>
													 </#list>
												</optgroup>	 
											</#list>
										</#if>
							</select>
							<span class="jive-error-message" id="endMarketError" style="display:none">Please select Research End Market</span>
						
						</div>
					</div>
				</#if>
				
				<div class="region-inner">
					<!-- Category Type Multi Select -->
					<label class="label_b"><@s.text name="project.initiate.project.category"/></label>
					<div class="col-lg-6">
				  
				   	<select data-placeholder="Select Category" class="chosen-select" id = "categoryType" name="categoryType" multiple >
					  <option value=""></option>
						   <#assign categoryTypes = statics['com.grail.synchro.SynchroGlobal'].getProductTypes() />
								<#assign categoryTypeKeySet = categoryTypes.keySet() />
								<#if (categoryTypes?has_content)>
									<#list categoryTypeKeySet as key>
										<#assign categoryType = categoryTypes.get(key) />
										 <option value="${key?c}" <#if project.categoryType?? && project.categoryType?seq_contains(key)> selected</#if> >${categoryType}</option>
									</#list>
								</#if>
						</select>
					
						<span class="jive-error-message" id="categoryTypeError" style="display:none">Please select Category</span>
						
					
				</div>
				</div>
				
				
				
				
				<div class="region-inner confirmation-msg">
				


				
                    <div  class="form-text_div" id="EuMarketConfrmationMessage" <#if showRefProjectMessage=="yes">style="display:block"><#else>style="display:none"></#if><b>This project included EU market(s). Please confirm if the outcome of the project will be shared with EU markets.</b>
                    </div>
				
				
				
		 
				<div class="form-text_div"   id="euMarketConfirmation"  <#if showRefProjectMessage=="yes">style='display:block'><#else>style='display:none'></#if> 	
					<#if project?? && project.euMarketConfirmation??>
						<@EuMarketConfrmationOptions   name='euMarketConfirmation' value=project.euMarketConfirmation/>
					<#else>
						<@EuMarketConfrmationOptions   name='euMarketConfirmation' value=-1/>
					</#if>
					<span class="jive-error-message" id="euMarketConfirmationError" style="display:none">Please select EU End Market Confirmation</span>
			    </div>
				
				  <!--dynamic Reference Project Details -->
				  
				  <div class="form-select_div reference-project-details"   id="ReferenceProjectDetailsDiv"  <#if showRefProjectMessage=="yes" && project?? && project.euMarketConfirmation?? && project.euMarketConfirmation==1 >style="display:block"><#else>style="display:none"></#if>
				  
				   <label class="label_b"> Reference Project Details</label>
				   
				        <div class="form-text_div">
				      <i><b>Provide Synchro code(s) for the following EU market projects  that need to be initiated as separate project(s) in Synchro using option 'Projects with EU end-markets'.If this information is not available right now, you can add it later.</b>
                      </i> 
					  <h3><span>Research end market</span><span>Synchro code</span></h3>
					  
					  <div id="dynamicReferenceProjectDetailsDiv">
						  </div>
					  
					  
					
					  
					  
					  
					  </div>
				  </div>
			 
				 
					
			
			
			
			
				
				
					<!-- Project Start Year Month Date -->
					<div class="form-select_div start_date">
						<#--<label><@s.text name="project.initiate.project.start"/></label>-->
						<label>Project Start Date</label>
				   
				  
				   
					<@synchrodatetimepicker id="startDate" name="startDate" value="" format="%d/%m/%Y" readonly=true dateCompare1=true   disablePrevDates=false defaultDateTimePicker=true placeholder='Enter Start Date'/>
					<#assign error_msg><@s.text name='project.error.startdate' /></#assign>
					<@macroCustomFieldErrors msg="Please enter Project Start Date" />
					<@macroFieldErrors name="startDate"/>
					</div>

					<!-- Project Completion Year Month Date -->
					<div class="form-select_div form-select_div_project_completion">
						<#--<label><@s.text name="project.initiate.project.end"/></label>-->
						<label>Project End Date</label>
				 
				
				 
				 <@synchrodatetimepicker id="endDate" name="endDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false dateCompare=true placeholder='Enter Project End Date'/>
					<#assign error_msg><@s.text name='project.error.enddate' /></#assign>
					<@macroCustomFieldErrors msg="Please enter Project End Date" />
					<@macroFieldErrors name="endDate"/>
					</div>
				</div>

				
					
				<div class="region-inner">
					<!-- Project Owner -->
				
					<div class="form-select_div">
						<#--<label><@s.text name="project.initiate.project.owner"/></label>-->
	<label>SP&I Contact <span class="tooltip-wrap"><span class="tip-ico"></span><div class="bubble">SP&I Contact is the contact person for this project at BAT<div class="bubble-arrow"></div></div>
						</span></label>

						<div>
						   
						<#if project?? && project.projectManagerName??>
						<input type="text"  name="projectManagerName" placeholder="Enter SP&I Contact" value="${project.projectManagerName}" id="projectManagerName"  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter SP&I Contact' "/>
						
						<#else>
						<input type="text"  name="projectManagerName" placeholder="Enter SP&I Contact" value="" id="projectManagerName"  onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter SP&I Contact' "/>
						
						</#if>
							

					<span class="full-width"><@macroCustomFieldErrors msg="Please enter SP&I Contact" /></span>
						</div>
					</div>

			<#--
					<div class="form-select_div form-select_div_project_completion">
					
						<label>Project Initiator</label>
						<div>
							<input type="text"  name="projectInitiator" value="${user.name}" id="projectInitiator"  disabled />
						
						<#assign error_msg><@s.text name="project.error.spi"/></#assign>
						<@macroCustomFieldErrors msg=error_msg />
						</div>
					</div>
-->
				</div>


				<!-- Project Publish Button -->
				<div class="buttons">
					<#if projectID?? >
					<a id="project_save_draft_link" href="javascript:void(0);" class="publish-details">Save Project</a>
					<#else>
					<a id="project_save_draft_link" href="javascript:void(0);" class="publish-details">Save As Draft</a>
					</#if>
					
					<a id="project_overview_continue_link" href="javascript:void(0);" style="margin-left: 10px;"  class="publish-details">Continue</a>
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

				<div style="display:none">
				
				</div>


		<@jive.token name="synchro.project.create" lazy=true />
		</div>
	</div>
 </div>
 </div>
<!-- PROJECT OVERVIEW ENDS -->

<!-- RESEARCH METHODOLOGY STARTS -->
 <div class="end_market_details" style="display:block;">
	 <div class="">
		
		
		<h3 id="block_header_2" >Research Methodology
						<a id="legend_2" href="javascript:void(0);" class="close-form"></a>
					</h3>
		 <div id="research_methodology" class="pib_angola" >
				


			
	<span><i>Please enter details below. All inputs are mandatory. If specific details are not known, please provide your best estimate - you can update details later</i></span>
				

				
			<div class="topPanelWell">	
				<div class="region-inner">
					
					<label class="label_b">Methodology</label>
					<div class="col-lg-6">
				  
						<#if isAdminUser>
							<select data-placeholder="Select Methodology" class="chosen-select" id = "methodologyDetails" name = "methodologyDetails" multiple >
						<#else>
							<select data-placeholder="Select Methodology" class="chosen-select" id = "methodologyDetails" name = "methodologyDetails" >
						</#if>
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
														<option lessFrequent="yes" brandSpecific="${methodologyProperties.get(methkey).getBrandSpecific()}" value="${methkey?c}" <#if project.methodologyDetails?? && project.methodologyDetails?seq_contains(methkey)> selected</#if>>${methodologies.get(methkey)}</option>
													<#else>
														<option lessFrequent="no" brandSpecific="${methodologyProperties.get(methkey).getBrandSpecific()}" value="${methkey?c}" <#if project.methodologyDetails?? && project.methodologyDetails?seq_contains(methkey)> selected</#if>>${methodologies.get(methkey)}</option>
													</#if>
												 </#list>
											</optgroup>	 
										</#list>
									</#if>
						</select>
						<span class="jive-error-message" id="methodologyDetailsError" style="display:none">Please select Methodology</span>
					
					</div>
				</div>

				<div class="region-inner">
					<!-- Methodology Group -->
					<div class="form-select_div">
						<label>Methodology Type</label>
				
					<@renderMethodologyField name='methodologyType' value=project.methodologyType?default('-1') readonly=false/>
					<@macroCustomFieldErrors msg="Please select Methodology Type" />
					
					</div>
					
				</div>
				
				<div class="region-inner">
					
					<div class="form-select_div">
						<label>Will a methodology waiver be required?</label>
					
					<#if project.methWaiverReq??>
						<@renderMethodologyWaiverField name='methWaiverReq' value=project.methWaiverReq?default('-1') />
					<#else>
						<@renderMethodologyWaiverField name='methWaiverReq' value=-1/>
					</#if>
					
					<span class="jive-error-message" id="methodologyWaiverError" style="display:none">Please select Will a methodology waiver be required?</span>
					
					</div>
					<div id="waiverMessage" style="display:none">You will be able to initiate waiver through the system once the project is created</div>
				</div>
				
				<div class="region-inner">
					
					<div class="form-select_div">
						<#--<label>Is this a brand specific study?<span class="tooltip-wrap"><span class="tip-ico"></span><div class="bubble">Brand specific studies are for particular brands such as Dunhill, Kent, Lucky Strike, etc. For example, the methodology 4Cast Migration is brand specific, and TRACK is not brand specific.<div class="bubble-arrow"></div></div>
						</span></label>
						-->
						
						<label>Is this a brand specific study?<span class="tooltip-wrap"><span class="tip-ico"></span><div class="bubble">Please select YES, for a study that primarily focuses on one brand, followed by selection of the Brand House involved in the study, in the next dropdown that appears. This would include studies such as a product test for Kent (which may have included Marlboro for comparison / benchmarking), which would be classified under Kent. Please select NO if the study focusses either on multiple brands OR all brands in the market. If multiple brands are involved, select “Multi-brand Study” in the next dropdown, then enter the brand names in the open text box that appears. Likewise, in case all brands in the market were covered, select “Non-brand related” in the next dropdown.<div class="bubble-arrow"></div></div>
						</span></label>
					
					<@renderBrandSpecificStudy name='brandSpecificStudy' value=project.brandSpecificStudy?default(-1)/>
					
					<span class="jive-error-message" id="brandSpecificStudyError" style="display:none">Please select Is this a brand specific study?</span>
					</div>
					<div id="brandSpecific" style="display:none">
					
					<div class="form-select_div">
						
					
					<@renderBrandFieldNew name='brand' value=project.brand?default('-1')/>
					<!--<#assign error_msg><@s.text name='project.error.methodologygroup' /></#assign>  
					<@macroCustomFieldErrors msg=error_msg />  -->
					
					<span class="jive-error-message" id="brandError" style="display:none">Please select Brand</span>
					
					</div>
					
					</div>
					<div id="brandSpecificStudyType" style="display:none">
					
					<div class="form-select_div">
										
					
					<@renderBrandSpecificStudyType name='brandSpecificStudyType' value=project.brandSpecificStudyType?default(-1)/>
					<span class="jive-error-message" id="brandSpecificStudyTypeError" style="display:none">Please select Study Type</span>
				
					</div>
					
					</div>
			<div class="form-select_div" id="MultibrandTextDiv" style="display:none">
						
							

							<div>
								   
								<input type="text"  name="multiBrandStudyText" placeholder="Enter the Brands"" id="multiBrandStudyText"  onfocus="this.placeholder='' " <#if project?? && project.multiBrandStudyText??> value="${project.multiBrandStudyText}" </#if> onblur="this.placeholder = 'Enter the Brands' "/>
								<span class="jive-error-message" id="MultibrandTextError" style="display:none">Please enter Brands </span>
							</div>
						</div>
				</div>
		
				<!-- Project Publish Button -->
				<div class="buttons">
					
					<#if projectID?? >
					<a id="project_save_draft_link_research" href="javascript:void(0);" class="publish-details">Save Project</a>
					<#else>
					<a id="project_save_draft_link_research" href="javascript:void(0);" class="publish-details">Save As Draft</a>
					</#if>
					<a id="project_researchMeth_continue_link" href="javascript:void(0);" style="margin-left: 10px;"  class="publish-details">Continue</a>
				</div>
			

				<div style="display:none">
				
				</div>


		<@jive.token name="synchro.project.create" lazy=true />
		</div>
	</div>
 </div>
 </div>
<!-- RESEARCH METHODOLOGY ENDS -->

 <!-- COST DETAILS STARTS -->
 <div class="end_market_details" style="display:block;">
	 <div class="">
		<h3 id="block_header_3" >Cost Details
						<a id="legend_3" href="javascript:void(0);" class="close-form"></a>
					</h3>
		 <div id="cost_details" class="pib_angola" >
		 <span><i>Please enter details below. All inputs are mandatory. If specific details are not known, please provide your best estimate - you can update details later</i></span>
			<div class="topPanelWell">
				<div class="region-inner">
					
					<div class="form-select_div">
						<label>Budget Location</label>
			
					
					<#assign userBudgetLocation = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationEndMarkets(user) />
					
					<select data-placeholder="Select the Budget Location" class="chosen-select" id = "budgetLocation" name="budgetLocation" >
						
						<option value=""></option>
						<#if statics['com.grail.synchro.util.SynchroPermHelper'].isGlobalUserType() || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner()>
							
							<#if project?? && project.budgetLocation??>
								<#if project.budgetLocation?int==-1>
								  <option  value="-1" selected >Global</option>
								<#else>
									<option  value="-1" >Global</option>
								</#if>	
							<#else>
								<option  value="-1" selected >Global</option>
							</#if>
						</#if>
						
						<#if statics['com.grail.synchro.util.SynchroPermHelper'].isRegionalUserType() || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner()>
							<#if statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner()>
								<#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
								
								<#assign regionsKeySet = regions.keySet() />
								<#list regionsKeySet as key>
									<#if regions.get(key?int) == "Global">
									<#else>
										<#if project?? && project.budgetLocation?? && project.budgetLocation==key>
											<option  value="${key}" selected >${regions.get(key?int)}</option>
										<#else>
											<option  value="${key}" >${regions.get(key?int)}</option>
										</#if>
									</#if>	
								</#list>
							<#else>
								<#assign userRegionBudgetLocation = statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationRegions(user) />
								<#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
								<#list userRegionBudgetLocation as uRegionBugLoc>
									<#if project?? && project.budgetLocation?? && project.budgetLocation==uRegionBugLoc>
										<option  value="${uRegionBugLoc}" selected >${regions.get(uRegionBugLoc?int)}</option>
									<#else>
										<option  value="${uRegionBugLoc}" >${regions.get(uRegionBugLoc?int)}</option>
									</#if>
								</#list>
							</#if>
						</#if>
						
						<!-- Only Global/Regional Users will never End Market options as Budget Location http://redmine.nvish.com/redmine/issues/333 -->
						
						
						<#--<#if userBudgetLocation?? && userBudgetLocation?size gt 0 >
							
							<#list userBudgetLocation as ubugLoc>
														
								<#if project?? && project.budgetLocation?? && project.budgetLocation==ubugLoc>
									<option  value="${ubugLoc}" selected>${endMarkets.get(ubugLoc?int)}</option>
								<#else>
									<option  value="${ubugLoc}" >${endMarkets.get(ubugLoc?int)}</option>
								</#if>
							</#list>
						</#if>
						-->
					</select>
					<span class="jive-error-message" id="budgetLocationError" style="display:none">Please select Budget Location</span>
					</div>
				</div>

				<div class="region-inner">
				<@projectBudgetYearFieldNew name="budgetYear" value=project.budgetYear/>
					<@macroCustomFieldErrors msg="Please enter Budget Year" />
					<span class="full-width"><span class="jive-error-message" id="budgetYearError" style="display:none">Please select Budget Year</span></span>
				</div>

				<div id="expenseDetailsContainer">
				<label>Cost Details</label>
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
						  
							
								<select data-placeholder="Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
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
																
																<#if project.isMigrated?? && project.isMigrated >
																	<option isNonKantar="no" value="${researchAgencykey?c}" <#if projectCostDetail.getAgencyId()==researchAgencykey> selected </#if>>${researchAgencies.get(researchAgencykey)}</option>
																<#else>
																	<#if researchAgencykey==131>
																	<#else>
																		<option isNonKantar="no" value="${researchAgencykey?c}" <#if projectCostDetail.getAgencyId()==researchAgencykey> selected </#if>>${researchAgencies.get(researchAgencykey)}</option>
																	</#if>	
																</#if>
															</#if>
														 </#list>
													</optgroup>	 
												</#list>
											</#if>
								</select>
								
								
							<span class='jive-error-message researchAgencydynamicError'  style='display:none'>Please select Research Agency</span>
							   
							</div>
						</div>
						
						<div class="region-inner">
							<@renderCostComponent name="costComponents" value="${projectCostDetail.getCostComponent()?default('-1')}" id='costComponent'/>
							<span class='jive-error-message costComponentdynamicError'  style='display:none'>Please select Cost Component</span> 
						</div>
						<div class="region-inner">
							
							<@renderCurrenciesFieldNew name='currencies' value="${projectCostDetail.getCostCurrency()?default(-1)}"  disabled=false id='currency' />
							<span class='jive-error-message costCurrencytdynamicError'  style='display:none'>Please select Cost Currency</span>
						</div>

						
						<div class="region-inner">
							<!-- Project Initial Cost Field -->
							<div class="form-select_div">
								<div class="pit-estimate-cost">
									<!-- <label><@s.text name="project.initiate.project.cost"/></label> -->

									<input type="text"  id="enter_cost" name="agencyCosts"  firstRow="yes" Placeholder="Enter Cost" class="text_field longField total-expense" value="${projectCostDetail.getEstimatedCost()}" />
								<span class="jive-error-message agencyCostsError" style="display: none;">Please enter Agency Cost</span>
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
						  
							
								<select data-placeholder="Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
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
																<#if project.isMigrated?? && project.isMigrated >
																	<option isNonKantar="no" value="${researchAgencykey?c}">${researchAgencies.get(researchAgencykey)}</option>
																<#else>
																	<#if researchAgencykey==131>
																	<#else>
																		<option isNonKantar="no" value="${researchAgencykey?c}">${researchAgencies.get(researchAgencykey)}</option>
																	</#if>	
																</#if>	
															</#if>
														 </#list>
													</optgroup>	 
												</#list>
											</#if>
								</select>
								
								
								<span class='jive-error-message researchAgencydynamicError'  style='display:none'>Please select Research Agency</span>
							   
							</div>
						</div>
						
						<div class="region-inner">
							<@renderCostComponent name="costComponents" value="" id='costComponent'/>
							<span class='jive-error-message costComponentdynamicError'  style='display:none'>Please select Cost Component</span> 
						</div>
						<div class="region-inner">
							<@renderCurrenciesFieldNew name='currencies' value='-1' disabled=false id='currency'/>
							<span class='jive-error-message costCurrencytdynamicError'  style='display:none'>Please select Cost Currency</span>
						</div>

						
						<div class="region-inner">
							<!-- Project Initial Cost Field -->
							<div class="form-select_div">
								<div class="pit-estimate-cost">
									<!-- <label><@s.text name="project.initiate.project.cost"/></label> -->

								<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" Placeholder="Enter Cost" class="text_field longField total-expense" value="" />
								<span class="jive-error-message agencyCostsError" style="display: none;">Please enter Agency Cost</span>
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
						  
							
								<select data-placeholder="Research Agency" title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "agency" name='agencies' >
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
																
																<#if project.isMigrated?? && project.isMigrated >
																	<option isNonKantar="no" value="${researchAgencykey?c}">${researchAgencies.get(researchAgencykey)}</option>
																<#else>
																	<#if researchAgencykey==131>
																	<#else>
																		<option isNonKantar="no" value="${researchAgencykey?c}">${researchAgencies.get(researchAgencykey)}</option>
																	</#if>	
																</#if>	
															</#if>
														 </#list>
													</optgroup>	 
												</#list>
											</#if>
								</select>
								
								
								<span class='jive-error-message researchAgencydynamicError'  style='display:none'>Please select Research Agency</span>
							   
							</div>
						</div>
						
						<div class="region-inner">
							<@renderCostComponent name="costComponents" value="" id='costComponent'/>
							<span class='jive-error-message costComponentdynamicError'  style='display:none'>Please select Cost Component</span> 
						</div>
						<div class="region-inner">
							<@renderCurrenciesFieldNew name='currencies' value='-1' disabled=false id='currency'/>
							<span class='jive-error-message costCurrencytdynamicError'  style='display:none'>Please select Cost Currency</span>
						</div>

						
						<div class="region-inner">
							<!-- Project Initial Cost Field -->
							<div class="form-select_div">
								<div class="pit-estimate-cost">
									<!-- <label><@s.text name="project.initiate.project.cost"/></label> -->

								<input type="text"  id="enter_cost" name="agencyCosts" firstRow="yes" Placeholder="Enter Cost" class="text_field longField total-expense" value="" />
								<span class="jive-error-message agencyCostsError" style="display: none;">Please enter Agency Cost</span>
								</div>
								
							</div>

						</div>
					</div>
					</#if>

					<div class="region-inner total-cost">
						<!-- Project Initial Cost Field -->
						<div class="form-select_div">
							<div class="pit-estimate-cost">
								<label>Total Cost (GBP)</label>
								<#if project.totalCost??> 
									<input type="text"   Placeholder="0" name="totalCost" class="text_field longField" disabled value="${project.totalCost?round}" />
								<#else>
									<input type="text"   Placeholder="0" name="totalCost" class="text_field longField" disabled value="" />
								</#if>
								
								<input type="hidden"  name="totalCostHidden"  id="totalCostHidden" value="" />
							<#assign error_msg><@s.text name="project.error.cost"/></#assign>
							<@macroCustomFieldErrors msg=error_msg class="numeric-error"/>
							</div>
							
						</div>
						
						<#if statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user)?? && JiveGlobals.getJiveIntProperty("grail.default.currency",87)==statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user)>
						<#else>
							<div class="form-select_div">
								<div class="pit-estimate-cost mar__top10">
									
									
									<#if statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user))?? >
										<label>Total Cost (${statics['com.grail.synchro.util.SynchroUtils'].getCurrencyFields().get(statics['com.grail.synchro.util.SynchroUtils'].getUserLocalCurrency(user))})</label>
									
										<#if statics['com.grail.synchro.util.SynchroUtils'].getPreferredCurrenyTotalCost(project,user)?? >
											<input type="text" placeholder="0" id="prefCost" name="prefCost" class="text_field_prefferedCurrency longField" value="${statics['com.grail.synchro.util.SynchroUtils'].getPreferredCurrenyTotalCost(project,user)?round}" disabled />
										<#else>
											<input type="text" placeholder="0" id="prefCost" name="prefCost" class="text_field_prefferedCurrency longField" value="" disabled />
										</#if>
									</#if> 
									
								<#assign error_msg><@s.text name="project.error.cost"/></#assign>
								<@macroCustomFieldErrors msg=error_msg class="numeric-error"/>
								</div>
								
							</div>
						</#if>	
 
					</div>
					<div id="nonKantarAgencyMessage" style="display:none">This project requires a waiver for using non-Kantar agency. You can initiate a waiver once a project is created.
					</div>
					</div>
				</div>
				
				
				
				<div class="form-note">
				NOTE:
				<ul>
				<li>In case agency and cost details are not known, please provide your best estimate</li>
				<li>All costs should be in the currency that the invoices will be paid</li>
				<li>If a research agency isn't listed, please contact the support helpdesk to have it added</li>
				<li>This project needs to include cost incurred by above market entities (Global/ Regional). Any cost incurred by an end market should be captured as a separate project initiated by the end market in Synchro</li>
				</div>
				
				
				<#if statics['com.grail.synchro.util.SynchroPermHelper'].isGlobalUserType() || statics['com.grail.synchro.util.SynchroPermHelper'].isRegionalUserType() || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner()>
						<div class="region-inner two-column">
						
						<div class="form-select_div">
							<label>Is an end market involved in this project?</label>
						
							<#if project.endMarketFunding??>
							<@renderEndMarketFundingField name='endMarketFunding' value=project.endMarketFunding?default('-1') />
						<#else>
							<@renderEndMarketFundingField name='endMarketFunding' value=-1/>
						</#if>
					<span class="jive-error-message" id="endMarketFundingError" style="display:none">Please select is an end market involved in this project?</span>
					   </div>
					   
				  <div  class="form-select_div second-column" id="MarketparticipatingFunding"  <#if project.endMarketFunding?? && project.endMarketFunding==1>style="display:block;"<#else>style="display:none;"</#if>>
				
				         <label>Select the end market(s) which will carry out the fieldwork</label>
				
				         <div id="DynamicMarketparticipatingFunding">
	        
						 	<select data-placeholder="Select markets"  multiple class="chosen-select" id = "fundingMarkets" name="fundingMarkets" >
							<option value=""></option>
							<#if endMarketDetails??>
							    <#list endMarketDetails as emd >
								    <#if emd?? && emd.getIsFundingMarket()?? && emd.getIsFundingMarket()>
									    <option value="${emd.getEndMarketID()}" selected>${endMarkets.get(emd.getEndMarketID()?int)}</option>
									<#else>
										<option value="${emd.getEndMarketID()}">${endMarkets.get(emd.getEndMarketID()?int)}</option>
									</#if>
								</#list>
							</#if>
							
							
						</select>	
						     <span class='jive-error-message fundingMarketsError fundErr__fix' style='display: none;'>Please select the end market(s) which will carry out the fieldwork</span>   
						  </div>
				
				 

				  </div>
				
				
			    </div>
				</#if>
				
				
				<!-- Project Publish Button -->
				<div class="buttons">
					
					<#if projectID?? >
					<a id="project_save_draft_link_cost" href="javascript:void(0);" class="publish-details">Save Project</a>
					<#else>
					<a id="project_save_draft_link_cost" href="javascript:void(0);" class="publish-details">Save As Draft</a>
					</#if>
					<#if projectID?? >
					<a id="project_publish_link" href="javascript:void(0);" style="margin-left: 10px;"  class="publish-details">Start Project</a>
					<#else>
					<a id="project_publish_link" href="javascript:void(0);" style="margin-left: 10px;"  class="publish-details">Create Project</a>
					</#if>
				</div>
				

				<div style="display:none">
				
				</div>


		<@jive.token name="synchro.project.create" lazy=true />
		</div>
	</div>
 </div>
 </div>
 </div>
<!-- COST DETAILS ENDS -->
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
                title:"",
                html:"<p>Your project '"+projectName.val() +"' has been successfully saved as Draft.<br/><br/>You can access the draft anytime from <a href='/new-synchro/draft-dashboard.jspa'>'Projects'</a> and continue working on it.</p>",
                buttons:{
                    "Ok": function() {
                        window.location.href = "/new-synchro/draft-dashboard.jspa";
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

//This is done for hiding the User Picker icon
 $j('.jive-chooser-browse').css('display', 'none');
 toggleResearchMethodology();
 toggleCostDetails();
    });
	
	function toggleProjectOverview()
	{
		var projectBlock = $j('#project_overview');
		projectBlock.toggle();
		// Expanded view
		if(projectBlock.css('display') == "block")
		{
			$j('#block_header_1').css('border-bottom', '1px solid #c9c9c9');
			$j('#legend_1').removeClass('open-form');
			$j('#legend_1').addClass('close-form');
			$j('#research_methodology').hide().parent().find("#legend_2").addClass('open-form');
			$j('#cost_details').hide().parent().find("#legend_3").addClass('open-form');
			$j('#block_header_2').css('border-bottom', 'none');
			$j('#legend_2').addClass('open-form');
			$j('#legend_2').removeClass('close-form');
			$j('#block_header_3').css('border-bottom', 'none');
			$j('#legend_3').addClass('open-form');
			$j('#legend_3').removeClass('close-form');
		}
		// Closed/Minimized view
		else
		{
			$j('#block_header_1').css('border-bottom', 'none');
			$j('#legend_1').addClass('open-form');
			$j('#legend_1').removeClass('close-form');
		}
	}
	
	function toggleResearchMethodology()
	{	
		var researchMethBlock = $j('#research_methodology');
		researchMethBlock.toggle();
		// Expanded view
		if(researchMethBlock.css('display') == "block")
		{
			$j('#block_header_2').css('border-bottom', '1px solid #c9c9c9');
			$j('#block_header_1').css('border-bottom', 'none');
			$j('#legend_1').addClass('open-form');
			$j('#legend_1').removeClass('close-form');
			$j('#block_header_3').css('border-bottom', 'none');
			$j('#legend_3').addClass('open-form');
			$j('#legend_3').removeClass('close-form');
			
			
			$j('#legend_2').removeClass('open-form');
			$j('#legend_2').addClass('close-form');
			$j('#project_overview').hide().parent().find("#legend_1").addClass('open-form');
			$j('#cost_details').hide().parent().find("#legend_3").addClass('open-form');
		}
		// Closed/Minimized view
		else
		{
			$j('#block_header_2').css('border-bottom', 'none');
			$j('#legend_2').addClass('open-form');
			$j('#legend_2').removeClass('close-form');
		}
	}
	
	function toggleCostDetails()
	{
		var costDetailsBlock = $j('#cost_details');
		costDetailsBlock.toggle();
		// Expanded view
		if(costDetailsBlock.css('display') == "block")
		{
			$j('#block_header_3').css('border-bottom', '1px solid #c9c9c9');
			$j('#legend_3').removeClass('open-form');
			$j('#legend_3').addClass('close-form');
			$j('#project_overview').hide().parent().find("#legend_1").addClass('open-form');
			$j('#research_methodology').hide().parent().find("#legend_2").addClass('open-form');
			$j('#block_header_1').css('border-bottom', 'none');
			$j('#legend_1').addClass('open-form');
			$j('#legend_1').removeClass('close-form');
			
			$j('#block_header_2').css('border-bottom', 'none');
			$j('#legend_2').addClass('open-form');
			$j('#legend_2').removeClass('close-form');
		}
		// Closed/Minimized view
		else
		{
			$j('#block_header_3').css('border-bottom', 'none');
			$j('#legend_3').addClass('open-form');
			$j('#legend_3').removeClass('close-form');
		}
	}
	
	
	/*   this is for remove button */
	
    $j("body").on("click", ".remove", function () {
        $j(this).closest("div").remove();
		dynamicTotalCost();
		showKantarMessage();
    });
	
	
	 $j("body").on("change", "#agency, #costComponent, #currency ", function () {
        var  changed = $j(this).attr('id'); 
		 
		  console.log("changed" + changed)
	  var element = $j(this).find('option:selected'); 
	  var isNonKantar = element.attr("isNonKantar");
	  var value = $j(this).val();
		  if (changed == 'agency')
		  {
		    cuurentRow= $j(this).parent().parent().parent();
			showKantarMessage();
		   }
		   else if(changed == 'currency')
		   {
				var element = $j(this).find('option:selected'); 
				var isGlobal = element.attr("isGlobal");
				
				if(currencyChangeMessage==false && isGlobal!=null && isGlobal!=undefined && $j.trim(isGlobal)=="no")
				{
					 currencyChangeMessage= true;
					 dialog({
						title: '',
						html: currencyChangeMessageText,
						
					});
				}
				cuurentRow= $j(this).parent().parent();
		   }
		   else{
		   
		   cuurentRow= $j(this).parent().parent();
		   }
	  
	
	
	  
	  console.log(cuurentRow);
	  
	 $j(cuurentRow).find("#firstRemove").css("display","block");
	 $j(cuurentRow).find("#firstDuplicate").css("display","block");
	 $j(this).find("#firstRemove").css("display","block");
	 
 	  if ($j(cuurentRow).next().hasClass('expense_row'))
	  {
		/*if(isNonKantar=="yes")
		{
			$j("#nonKantarAgencyMessage").show();
	    }
		else
		{
			$j("#nonKantarAgencyMessage").hide();
		}*/
	 }
	  else
	  {
	     /*if(isNonKantar=="yes")
	     {
	         $j("#nonKantarAgencyMessage").show();
	     }
		 else
		{
			$j("#nonKantarAgencyMessage").hide();
		}*/
	     var div = $j("<div/>");
         // $j("#firstDuplicate").css("display","block");
		 // $j("#firstRemove").css("display","block");
	     div.html(GetDynamicTextBox("")).addClass("expense_row");
		 $j("#expenseDetailsContainer .border-box  > .region-inner").before(div);
		 $j('.appended-agency').chosen();
	   
		 $j('.appended-costComponent').chosen();
	     $j('.currency').chosen();
		 
		adjustExpenseRow();		 
		 
		 $j(div).find(".appended-agency").next().find("span").text("");
			$j(div).find(".appended-costComponent").next().find("span").text("");
			$j(div).find(".currency").next().find("span").text("");
			var lastRow = $j('.expense_row').last();
			//lastRow.find('#agency').val('');
			//lastRow.find('#currency').val('');
			//lastRow.find('#costComponent').val('');
			
			lastRow.find('#agency').val('').trigger('chosen:updated');
			lastRow.find('#currency').val('').trigger('chosen:updated');
			
			lastRow.find('#costComponent').val('').trigger('chosen:updated');
			
			
   	 }
	 //change
		currVal = $j(this).val();
	    if(currVal >=1){
		$j(this).parent().find(".jive-error-message").hide();
	 }
	 
	 
	dynamicTotalCost();
	AddCostDetailTitle();
	
});
  
  $j("body").on("change", "#enter_cost", function () {
        var  firstRow = $j(this).attr('firstRow'); 
		  
	  console.log("firstRow" + firstRow);
	  var element = $j(this).find('option:selected'); 
	  var isNonKantar = element.attr("isNonKantar");
	  var value = $j(this).val();
	  if (firstRow == 'yes')
	   {
		
		cuurentRow= $j(this).parent().parent().parent().parent();
		   
	   }
	   else
	   {
		cuurentRow= $j(this).parent().parent();
	   }
	 $j(cuurentRow).find("#firstRemove").css("display","block");
	 $j(cuurentRow).find("#firstDuplicate").css("display","block");
	 $j(this).find("#firstRemove").css("display","block");
	  if ($j(cuurentRow).next().hasClass('expense_row'))
	  {
		/*if(isNonKantar=="yes")
		{
			$j("#nonKantarAgencyMessage").show();
	    }
		else
		{
			$j("#nonKantarAgencyMessage").hide();
		}*/
	 }
	  else
	  {
	   /*  if(isNonKantar=="yes")
	     {
	         $j("#nonKantarAgencyMessage").show();
	     }
		 else
		{
			$j("#nonKantarAgencyMessage").hide();
		}*/
	     var div = $j("<div/>");
        
	     div.html(GetDynamicTextBox("")).addClass("expense_row");
		 $j("#expenseDetailsContainer .border-box  > .region-inner").before(div);
		 $j('.appended-agency').chosen();
	   
		 $j('.appended-costComponent').chosen();
	     $j('.currency').chosen();
		 adjustExpenseRow();		
		 
		  $j(div).find(".appended-agency").next().find("span").text("");
			$j(div).find(".appended-costComponent").next().find("span").text("");
			$j(div).find(".currency").next().find("span").text("");
			var lastRow = $j('.expense_row').last();
			//lastRow.find('#agency').val('');
			//lastRow.find('#currency').val('');
			//lastRow.find('#costComponent').val('');
			
			lastRow.find('#agency').val('').trigger('chosen:updated');
			lastRow.find('#currency').val('').trigger('chosen:updated');
			
			lastRow.find('#costComponent').val('').trigger('chosen:updated');
   	 }
	
	 // Validate Numeric
		var LONG_NUMBER = 9223372036854776000;
		var SHORT_NUMBER = 2147483647;
		if($j(this).val() != "")
		{
			if (!numericFormat($j(this))) {
				var val = $j(this).val().replace(/\,/g, '');
				if(allnumeric($j(this), val))
				{
					$j(this).next().text("Please enter number in 000,000 format");
				}
				else
				{
					$j(this).next().text("Please enter numeric value");
				}

				$j(this).next().show();
			
			}
			else
			{
				/**Checks for Short Range - Integers**/
				if($j(this).hasClass('shortField'))
				{
					var val = $j(this).val().replace(/\,/g, '');
					if(val>=SHORT_NUMBER)
					{
						$j(this).next().text("Please enter lesser value");
						$j(this).next().show();
						return;
					}
				}
				/**Checks for Long Range - Long**/
				else if($j(this).hasClass('longField'))
				{
					var val = $j(this).val().replace(/\,/g, '');
					if(val>=LONG_NUMBER)
					{
						$j(this).next().text("Please enter lesser value");
						$j(this).next().show();
						return;
					}
				}
				if($j(this).val().indexOf(".") < 0)
				{
					$j(this).val($j(this).val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
					
				}
				$j(this).next().hide();
				
			}
		}
		else
		{
		
		          $j(this).next().text("Please enter Agency Cost");
				
				  $j(this).next().show();
		
		}
		
		
		AddCostDetailTitle();
  });  
  

  
  $j("body").on("click", "#firstDuplicate", function () {
  
	  var element = $j(this).find('option:selected'); 
	  var isNonKantar = element.attr("isNonKantar");
	  var value = $j(this).val();
	
	  cuurentRow= $j(this).parent().parent().parent();
	  
	 $j(cuurentRow).find("#firstRemove").css("display","block");
	 $j(cuurentRow).find("#firstDuplicate").css("display","block");
	 $j(this).find("#firstRemove").css("display","block");
	 
 	  if ($j(cuurentRow).next().hasClass('expense_row'))
	  {
		/*if(isNonKantar=="yes")
		{
			$j("#nonKantarAgencyMessage").show();
	    }
		else
		{
			$j("#nonKantarAgencyMessage").hide();
		}*/
	 }
	  else
	  {
	    /* if(isNonKantar=="yes")
	     {
	         $j("#nonKantarAgencyMessage").show();
	     }
		 else
		{
			$j("#nonKantarAgencyMessage").hide();
		}*/
	     var div = $j("<div/>");
        
	     div.html(GetDynamicTextBox("")).addClass("expense_row");
		 //$j("#expenseDetailsContainer .border-box  > .region-inner").before(div);
		  //$j(cuurentRow).after(div);
		//  $j(cuurentRow).find("#firstDuplicate").parent().after(div);
		$j(this).closest("div").after(div);
		 $j('.appended-agency').chosen();
	   
		 $j('.appended-costComponent').chosen();
	     $j('.currency').chosen();
			
		 
		 var curObj=$j(this).closest("div").next();
	     var getObj=$j(this).closest("div");
		 
		 $j(this).closest("div").next().find("#firstRemove").css("display","block");
		 $j(this).closest("div").next().find("#firstDuplicate").css("display","block");
	 
		 var agency=$j(getObj).find("#agency").val();
		 var agency_comp=($j(getObj).find("#agency option:selected").text());
		  
		 var cost_comp=($j(getObj).find("#costComponent option:selected").text());
		 var cost_comp_select=($j(getObj).find("#costComponent").val());
		 
		 var currency=($j(getObj).find("#currency").val());
		 var currency_comp=($j(getObj).find("#currency option:selected").text());
		
	     var cost=($j(getObj).find("#enter_cost").val());
		  
		 if(agency!=null && agency!=undefined && agency!="" &&  agency > 0)
		 {
			  $j(curObj).find(".appended-agency").val(agency);
			  $j(curObj).find(".appended-agency").next().find("span").text(agency_comp);
			  $j(curObj).find(".appended-agency").next().find('.chosen-default').removeClass('chosen-default');
		 }
		 else
		 {
			  $j(curObj).find(".appended-agency").val('');
			  $j(curObj).find(".appended-agency").val('').trigger('chosen:updated');
		 }
		 if(cost_comp_select!=null && cost_comp_select!=undefined && cost_comp_select!="" &&  cost_comp_select > 0)
		 {
			 $j(curObj).find(".appended-costComponent").val(cost_comp_select);
			 $j(curObj).find(".appended-costComponent").next().find("span").text(cost_comp);
			 $j(curObj).find(".appended-costComponent").next().find('.chosen-default').removeClass('chosen-default');
		 }
		 else
		 {
			 $j(curObj).find(".appended-costComponent").val('');
			 $j(curObj).find(".appended-costComponent").val('').trigger('chosen:updated');
		 }
		 
		 if(currency!=null && currency!=undefined && currency!="" &&  currency > 0)
		 {
			 $j(curObj).find(".currency").val(currency);
			 $j(curObj).find(".currency").next().find("span").text(currency_comp);
			 $j(curObj).find(".currency").next().find('.chosen-default').removeClass('chosen-default');
		 }
		 else
		 {
			 $j(curObj).find(".currency").val('');
			 $j(curObj).find(".currency").val('').trigger('chosen:updated');
		 }
		
		   
		 $j(curObj).find("#enter_cost").val(cost);
		 dynamicTotalCost();
		   	 adjustExpenseRow();
   	 }

	AddCostDetailTitle();
  });
	 
	 
  
	 
	 

	function GetDynamicTextBox(value) {
		
		
	 	 var researchAgencyOption = "";
	     researchAgencyOption = "<div class='region-inner'><div class='col-lg-6' id='agencyMain1'><select title='Select Research Agency' data-placeholder='Research Agency'  class='chosen-select  appended-agency researchAgency'         id='agency' name='agencies'>"+$j('#agency').clone(true).html()+"</select><span class='jive-error-message researchAgencydynamicError'  style='display:none'>Please select Research Agency</span></div></div>";
		  
		 		  
		
		
		
		
		var costComponentOption = "";
		costComponentOption = "<div class='region-inner'><select  title='Select Cost Component' id='costComponent' data-placeholder='Select Cost Component' name='costComponents' class='chosen-select  appended-costComponent costComponent'>"+$j('#costComponent').clone(true).html()+"</select><span class='jive-error-message costComponentdynamicError'  style='display:none'>Please select Cost Component</span> </div>";     
		
		
	
		
		
		
		
		var costCurrencyOption = "";
		costCurrencyOption = "<div class='region-inner'><select title='Select Cost Currency' id='currency' data-placeholder='Select Currency' class='chosen-select currency' id='currencies' name='currencies'>"+$j('#currency').clone(true).html()+"</select> <span class='jive-error-message costCurrencytdynamicError'  style='display:none'>Please select Cost Currency</span></div>";
		
		
		
		
     	/* var content= '<input type="button" value="duplicate" class="duplicate" id="firstDuplicate" style="display:none"/>&nbsp;'+
		              '<input type="button" value="Remove" class="remove" id="firstRemove" style="display:none"/>&nbsp;'+
           		    researchAgencyOption +
				 costComponentOption +
				   costCurrencyOption +
				'<div class=" region-inner"><div class="form-select_div"><div class="pit-estimate-cost"><input   name ="agencyCosts" type="text"   id="enter_cost" placeholder="Enter Cost"   onchange="javascript:dynamicTotalCost();"  class="text_field  longField total-expense" value="'+ value+ '"/><span class="jive-error-message agencyCostsError" style="display: none;">Please enter Agency Cost</span></div></div></div>';
				*/
				
		 var content= '<input type="button" value="duplicate" class="duplicate" id="firstDuplicate" style="display:none"/>&nbsp;'+
		              '<input type="button" value="Remove" class="remove" id="firstRemove" style="display:none"/>&nbsp;'+
           		    researchAgencyOption +
				 costComponentOption +
				   costCurrencyOption +
				'<div class=" region-inner"><input   name ="agencyCosts" type="text"   id="enter_cost" placeholder="Enter Cost"   onchange="javascript:dynamicTotalCost();"  class="text_field  longField total-expense" value="'+ value+ '"/><span class="jive-error-message agencyCostsError" style="display: none;">Please enter Agency Cost</span></div>'		
			
             return content;       
	}

	$j(document).ready(function() {
		 var brandSpecificStudy = $j('select[name="brandSpecificStudy"] option:selected').val();

		if(brandSpecificStudy=="2")
		 {
			$j("#brandSpecificStudyType").show();
			if($j('select[name="brandSpecificStudyType"] option:selected').val()=="1")
            {
                $j("#MultibrandTextDiv").show();
            }
			$j("#brandSpecific").hide();
		 }
		 if(brandSpecificStudy=="1")
		 {
			  $j("#brandSpecific").show();
			  $j("#brandSpecificStudyType").hide();
		 }
	});
	
	
	$j('body').click(function() {
      var endDate = $j("#endDate").val();
	       if(endDate==null ||endDate=="")
		     {
			 }
			 else
			 {
			  
			  setTimeout(function(){
		 
		  if($j('body').find(".calendar").length==0)
		     {
			 dateCompare();
			 
			 }
			 else
			 {}
		  
		  
		  }, 200);
        }
	});
	
	
	   function  checkVisiblty()
	   {
	     setTimeout(function(){
		 
		  if($j('body').find(".calendar").length==0)
		     {
			 dateCompare();
			 
			 }
			 else
			 {}	  
		  }, 200);
	   }
		
	function dateCompare()
	{
		var endDate = $j("#endDate").val();
		var startDate = $j("#startDate").val();
		if(!compareDate(startDate, endDate))
		{
		  
		 dialog({
				title:"",
				html:"<i class='warningErr'></i><p>Please check the date you have selected.</p><p>Project End date cannot be prior to the Project Start.</p>",
				buttons:{
				"OK":function() {
					$j("#endDate").val('');
					$j("#endDate").next().next("span").show();
					return false;		
				}
			},

			});
		   error = true;
		}
	if(endDate != null && $j.trim(endDate)!="")
       {
	  
       
		 $j("#endDate").next().next("span").hide();
		
       
        } 
	}
	
	function dateCompare1()
	{
	
	var endDate = $j("#endDate").val();
	var startDate = $j("#startDate").val();
	
	  if(endDate=="" ||endDate==null)
	  {
	  }
	  else
	  {
	  
	    if(!compareDate(startDate, endDate))
            {
      
			dialog({
			title:"",
			html:"<i class='warningErr'></i><p>Please check the date you have selected.</p><p>Project Start cannot be after to the Project End.</p>",
			buttons:{
			"OK":function() {
				$j("#startDate").val('');
				$j("#startDate").next().next("span").show();
				return false;		
			}
		},

		});
       error = true;
    }
}
	  if(startDate != null && $j.trim(startDate)!="")
       {
	  
       
		 $j("#startDate").next().next("span").hide();
		
       
        } }
	
	
	
	
	
	$j(document).ready(function() {	
		$j(".total-expense").change(function() {
		dynamicTotalCost();
		});
	});
	
	function dynamicTotalCost(CurrencyType)
	{	var CurrencyType=0;
		var total=0;
		var prefCurrTotal = 0;
		$j('.expense_row').each(function(){
		CurrencyType = $j(this).find(".currency").val();
		//$j(this).find(".currency ")
		
		var costComponent =  $j(this).find(".costComponent").val();
		var researchAgency = $j(this).find(".researchAgency").val();
		
		var cost = $j(this).find(".total-expense").val();
		
	
		console.log("cost===>>"+ cost);
		
		
		var gbpExchangeRate = $j(this).find('.currency option:selected').attr("gbpExchangeRate");
		
		var prefCurrExchangeRate = $j(this).find('.currency option:selected').attr("prefCurrExchangeRate");
		
		if(CurrencyType!=null && CurrencyType!=undefined && $j.trim(CurrencyType)!="" && $j.trim(CurrencyType)!="-1" && costComponent!=null && costComponent!=undefined && $j.trim(costComponent)!="" && $j.trim(costComponent)!="-1" && researchAgency!=null && researchAgency!=undefined && $j.trim(researchAgency)!="" && cost!=null && cost!=undefined && $j.trim(cost)!="")
		{
		
			if(gbpExchangeRate!=null && gbpExchangeRate!=undefined && $j.trim(gbpExchangeRate)!="")
			{
				console.log("gbpExchangeRate-->"+gbpExchangeRate);
				console.log("TOTAL COST ---->"+ $j(this).find(".total-expense").val());
				total = (parseFloat($j(this).find(".total-expense").val().replace(/,/g, ""))*gbpExchangeRate) + total;
			}
			else if($j(this).find(".total-expense")!=null && $j(this).find(".total-expense").val()!=undefined && $j.trim($j(this).find(".total-expense").val())!="" )
			{
				console.log("gbpExchangeRate ELSE-->"+gbpExchangeRate);
				console.log("TOTAL COST ELSE---->"+ $j(this).find(".total-expense").val().replace(/,/g, ""));
				total = (parseFloat($j(this).find(".total-expense").val().replace(/,/g, ""))*1) + total;
			}
			
			if(prefCurrExchangeRate!=null && prefCurrExchangeRate!=undefined && $j.trim(prefCurrExchangeRate)!="")
			{
				prefCurrTotal = (parseFloat((1/prefCurrExchangeRate))*total);
				prefCurrTotal =   (prefCurrTotal.toFixed(0)).toString();
			}
		}
			});
		//$j('.total-cost .text_field').val(total.toFixed(2));
			
		//$j("#totalCostHidden").val(total.toFixed(2));
		$j("#totalCostHidden").val(total);
		
		 //var a =   (total.toFixed(2)).toString();
		 var a =   (total.toFixed(0)).toString();
        $j('.total-cost .text_field').val(a.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
		
		$j("#prefCost").val(prefCurrTotal.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
		
			
	}
	
	
</script>

<script type="text/javascript">
     $j(document).ready(function() {
   
           
   
      var date1=new Date();
         var date = new Date(date1.toString());
		 var day="";
		 if(date.getDate()<10)
		 {
			day="0"+date.getDate();
		 }
		 else
		 {
			day=date.getDate();
		 }
		 var month="";
		 if(date.getMonth()<9)
		 {
			month="0"+(date.getMonth()+1);
		 }
		 else
		 {
			month=(date.getMonth()+1);
		 }
		 
   
	
	<#if project.startDate?? >
		<#else>
			var currentdateformat= day + '/' + month + '/' +  date.getFullYear();
			$j('#startDate').val(currentdateformat);
		</#if>
      });
	  
	  
	  $j("#fieldWorkStudy").change(function() {
			
			 var fieldWorkStudy = $j('select[name="fieldWorkStudy"] option:selected').val();
			
			  if(fieldWorkStudy=="1")
			 {
					dialog({
					title: '',
					html: '<i class="warningErr"></i><p>Fieldwork only project is initiated to capture only fieldwork related information of a complete market study.</p><p>Please ensure you would like to proceed. Would you like to process?',
					buttons:{
						"Yes":function() {
							
						  $j("#refSynchroCodeDiv").show();
						  $j("#fielworkProjects").show();
						  $j("#normalProjects").hide();
						  
							
						},
						"No": function() {
							$j('#fieldWorkStudy').val('').trigger('chosen:updated');
							$j("#refSynchroCodeDiv").hide();
						    $j("#fielworkProjects").hide();
						    $j("#normalProjects").show();
							return false;
						}
					},
					close: function() { 
						$j('#fieldWorkStudy').val('').trigger('chosen:updated');
							$j("#refSynchroCodeDiv").hide();
						    $j("#fielworkProjects").hide();
						    $j("#normalProjects").show();
							return false;
					}
				});
				
				
				
			 }
			 if(fieldWorkStudy=="2" || fieldWorkStudy=="-1")
			 {
				 $j("#refSynchroCodeDiv").hide();
				 $j("#fielworkProjects").hide();
				 $j("#normalProjects").show();
			 }
			
		});
		
		
		<#if statics['com.grail.synchro.util.SynchroPermHelper'].isGlobalUserType() || statics['com.grail.synchro.util.SynchroPermHelper'].isRegionalUserType() || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user)>
				var endMarketO = $j('select[name="endMarkets"] option:selected').val();
		var endMarketText = $j('select[name="endMarkets"] option:selected').text();
		$j("#endMarkets").change(function() {
			
			var endMarket = $j('#endMarkets').val();
			
		
			var element = $j(this).find('option:selected'); 
			var eu = element.attr("eu");
			
			/*if(eu=="0")
			{
				dialog({
					title:"",
					html:"<p>You are trying to change 'Research End Market'. This cannot be updated to Non EU!</p><p>You need to cancel the project and setup it up as a new project on Synchro with the correct information.</p>",
					buttons:{
					"OK":function() {
						$j('select[name="endMarkets"] select').val(endMarketO);
						$j('#endMarkets_chosen span').text(endMarketText);	
						//$j('#endMarkets').val('').trigger('chosen:updated');
						return false;		
					}
				},

				});
			
			}
			else
			{
				endMarketO=$j('#endMarkets').val();
				endMarketText = $j('select[name="endMarkets"] option:selected').text();
				$j("#fundingMarkets option").val(endMarketO).text(endMarketText);
			}
			*/
			
			endMarketO=$j('#endMarkets').val();
				endMarketText = $j('select[name="endMarkets"] option:selected').text();
				$j("#fundingMarkets option").val(endMarketO).text(endMarketText);
				
			//$j('#budgetLocation').val(endMarket).trigger('chosen:updated');
			$j('#fundingMarkets').val('').trigger('chosen:updated');
		});
		
		
		
		$j("#endMarketFunding").change(function() {
			
			var endMarketFunding = $j('#endMarketFunding').val();
			if(endMarketFunding=="1")
			{
				$j("#fundingMarketsDiv").show();
				var MarketFunding = $j('select[name="fundingMarkets"] option:selected').val();
				   if(MarketFunding>=1)
				   {
				 
				   $j(".fundingMarketsError").hide();	
				   }
				   else
				   {
				   
				       
					// $j(".fundingMarketsError").show();
					
					 }
			}
			else
			{
				$j("#fundingMarketsDiv").hide();
			}
		});
		<#else>
			$j("#endMarkets").change(function() {
			
			var endMarket = $j('#endMarkets').val();
			$j('#budgetLocation').val(endMarket).trigger('chosen:updated');
		});
		</#if>
		
		
		
		
		function adjustExpenseRow()
		{
			$j(".expense_row #firstDuplicate").each(function(){
			if($j(this).is(':hidden'))
			{	
				$j(this).parent().css("margin-left","61px")
			}
			else
			{
				$j(this).parent().css("margin-left","0")
			}
			})
		}	
		adjustExpenseRow();
		
		function showKantarMessage()
		{
			$j("#nonKantarAgencyMessage").hide();
			$j(".expense_row #agency").each(function(){
				var element = $j(this).find('option:selected'); 
				var isNonKantar = element.attr("isNonKantar");
				if(isNonKantar=="yes")
				{
					$j("#nonKantarAgencyMessage").show();
				}
			})
		}	
		showKantarMessage();
		$j("#brand").change(function() {
			  var brandvalue=$j("#brand option:selected").text();
			
			  if(brandvalue.length>20)
			  {
				$j("#brand_chosen").attr("title",brandvalue);
			  }
			else
			 {
			   $j("#brand_chosen").attr("title","");
			 }
		
		});
		
		$j("#brandSpecificStudyType").change(function() {
			  var brandSpecificStudyTypeValue=$j("#brandSpecificStudyType option:selected").text();
			
			  if(brandSpecificStudyTypeValue.length>20)
			  {
				$j("#brandSpecificStudyType_chosen").attr("title",brandSpecificStudyTypeValue);
			  }
			else
			 {
			   $j("#brandSpecificStudyType_chosen").attr("title","");
			 }
		
			 // new change..issue...536

			 if(brandSpecificStudyTypeValue=="Multi-Brand Study")
			  {
			  $j("#MultibrandTextDiv").show();
			  
			  }
			  else
			  {
			  $j("#MultibrandTextDiv").hide();
			  }
		});
		function AddCostDetailTitle(){
			$j('.expense_row .region-inner .chosen-select').each(function(){
				var TitleValue = $j('option:selected',this).text();
				if(TitleValue)$j(this).parent().find('.chosen-container').attr("title",TitleValue);
			});
		}
		
		
		
	         var euMarkertValues=[];
		     var euMarketText=[];
		 var TotalendMarketsValues=[];
		  var TotalendMarketsText=[];
			 var k=0;
		     var flag=false;
			 
			 var firstCount=0;
			 
		$j("#endMarkets").change(function(selected1){
		
		
		if(firstCount>0)
		{
			$j("#endMarketFunding").val('-1').trigger('chosen:updated');
		
		     $j("#DynamicMarketparticipatingFunding").empty();
				   $j("#MarketparticipatingFunding").hide();
		
		}
		
		     m=0;
		     k=0;
			 euMarkertValues=[];
	          euMarketText=[];
		   TotalendMarketsValues=[];
		   TotalendMarketsText=[];
              var count = $j('#endMarkets :selected').length;
		   //if no any option selected
			if(count==0)
			{
			  $j("#EuMarketConfrmationMessage").hide();
			  $j("#euMarketConfirmation").hide();
			  $j("#dynamicReferenceProjectDetailsDiv").empty();
			  $j("#ReferenceProjectDetailsDiv").hide();
			  flag=false;
			  
			  $j("#fielworkProjects").hide();
			  $j("#normalProjects").show();
			
			}
			 else
		     {
			
			$j('#endMarkets :selected').each(function(i, selected){ 
           
			var element=$j(selected); 
		    var euValue = element.attr("eu");
			//var nonEU= false;
			//$j("#euMarketConfirmation").val('-1').trigger('chosen:updated');
			if(euValue=="1")
			 {
		      // alert($j(selected).text()+" "+euValue); 
			   $j("#EuMarketConfrmationMessage").show();
			   $j("#euMarketConfirmation").show();
				  //new change
			var endMarketConfirmation = $j('select[name="euMarketConfirmation"] option:selected').val();   
			   
			    
				
				if(endMarketConfirmation==-1)
				{
				//$j("#euMarketConfirmationError").show();
				}
				else
				{$j("#euMarketConfirmationError").hide();}
			   
			 //  $j("#EuMarketConfrmation").val('-1').trigger('chosen:updated');
			   nonEU= true;
			    flag=true;
			    return false;	   
			 }
			  
			  if(euValue=="-1" ||euValue=="0"||euValue=="2")
			 { flag=false;    
					 return true;	// for continue loop   
			 }
		 });
		 
		  
		    // If all Non EU available....
		  if(flag==false)
		  {
		      $j("#EuMarketConfrmationMessage").hide();
			  $j("#euMarketConfirmation").hide();
			  $j("#dynamicReferenceProjectDetailsDiv").empty();
			  $j("#ReferenceProjectDetailsDiv").hide();
			  
			  $j("#fielworkProjects").hide();
			  $j("#normalProjects").show();
		  
		  }
		  else
		  {
			  $j("#fielworkProjects").show();
			  $j("#normalProjects").hide();
		  }
	  $j('#endMarkets :selected').each(function(i, selected){
		  
		  
		   var element=$j(selected); 
		    var euValue1 = element.attr("eu");
		         TotalendMarketsValues[m]=$j(selected).val();
			 TotalendMarketsText[m]=$j(selected).text();
			  m++;
			 flagStatus=true;
			  if(euValue1 =="1")
			 {
			   euMarkertValues[k] = $j(selected).val(); 
			   euMarketText[k]=$j(selected).text();
			   k++;
			   var element = $j("#euMarketConfirmation").find('option:selected').text();
			   if(element=="Yes")
			      {
				    
				     $j("#dynamicReferenceProjectDetailsDiv").empty();
				     yesLogical();
				  }
			   
			  }
		     });
			 
			} // else close
			 
	     });

        
  
  $j("#euMarketConfirmation").change(function() {
			   var element = $j(this).find('option:selected').text();
				 if(element=="Yes")
				{
					 dialog({
								title: '',
								html:'The study requires legal sign-off.Please initiate seprate project(s) in Synchro using the project with EU End-market option when first initiating a project',
				             });
				     yesLogical();			 
				}
				  else 
			       {
			        $j("#dynamicReferenceProjectDetailsDiv").empty();
				    $j("#ReferenceProjectDetailsDiv").hide();
				  
				  }
				 });

			function yesLogical()
             {			
			   $j("#ReferenceProjectDetailsDiv").show();
			     var i=0;
			     for(i=0;i<euMarkertValues.length;i++)
                     {
				 
				    var div = $j("<div/>");
                    div.html(dynamicReferenceProjectDetailsComponents(i));  
				    
					 
				     $j("#dynamicReferenceProjectDetailsDiv").append(div);
					 
				      $j(".chosen-select").chosen();
				      }
				
			  }  
		
 function dynamicReferenceProjectDetailsComponents(val)
  {
                    var comp="";
            comp= "<div class='float-left'><select  class='chosen-select' id='referenceEndMarkets' name='referenceEndMarkets'><option value='"+euMarkertValues[val]+"'>"+euMarketText[val]+"</option></select></div>&nbsp&nbsp&nbsp&nbsp";
			
                   var synCode = "";
				   var emId = "";
				
				   <#if endMarketDetails??>
				   <#list endMarketDetails as emd >
					  <#if emd?? && emd.getReferenceSynchroCode()?? && emd.getReferenceSynchroCode() gt 0>
						  
						  emId = "${emd.getEndMarketID()}";
						  if(emId==euMarkertValues[val])
						  {
							synCode = "${emd.getReferenceSynchroCode()?c}";
						  }
					  </#if>
					</#list>
					</#if>
				
				 var content=comp+'<div class="float-left synchroCode_row"><input   name ="referenceSynchroCodes" type="text"   id="referenceSynchroCodes" placeholder="Enter SynchrO Code"    onChange="return isNumber()" class="text_field  longField total-expense" onfocus="this.placeholder = \'\'" onblur="this.placeholder = \'Enter Synchro Code\'" value='+synCode+'><span class="jive-error-message synchroCodeError"  style="display: none;">Please enter numeric value</span></div>'
			
                return content;      
	       //alert(euMarkertValues[val]+" "+euMarketText[val]);
				   
		 }
	
	$j(document).ready(function() {
    
//	$j("#endMarkets").change();
	firstCount=firstCount+1;
//	$j("#endMarketFunding").change();
	var  flagStatus=false;

 m=0;
 $j('#endMarkets :selected').each(function(i, selected){
		  
		  
		   var element=$j(selected); 
		    var euValue1 = element.attr("eu");
		         TotalendMarketsValues[m]=$j(selected).val();
			     TotalendMarketsText[m]=$j(selected).text();
				   
			  m++;
			  });
});
	      //  End market Fundng...
          $j("#endMarketFunding").change(function() {
			   var element = $j(this).find('option:selected').text();
				 if(element=="Yes")
				{
					//TotalendMarketsValues[m]=$j(selected).val();
			// TotalendMarketsText[m]=$j(selected).text();
					
					
					
					if(TotalendMarketsValues.length>0)
					{
				      $j("#MarketparticipatingFunding").show();
						
					    //$j("#DynamicMarketparticipatingFunding").empty(); 
					    var div = $j("<div/>");
                        div.html(dynamicFunding()); 
						
			 
			
			
                    if(flagStatus==true)
					  {
			
                    $j("#DynamicMarketparticipatingFunding").append(div);
					
					}
					else{
					}
					for(i=0;i<TotalendMarketsValues.length;i++)
					{			
					
						var fundingMarketSelected="";
						 <#if endMarketDetails??>
							<#list endMarketDetails as emd >
							  <#if emd?? && emd.getIsFundingMarket()?? && emd.getIsFundingMarket()>
								  
								  var emId = "${emd.getEndMarketID()}";
								  if(emId==TotalendMarketsValues[i])
								  {
									
									fundingMarketSelected = "yes";
								  }
							  </#if>
							</#list>
						</#if>
						
						if(fundingMarketSelected=="yes")
						{
							
							$j('#fundingMarkets').append($j("<option selected value='"+TotalendMarketsValues[i]+"'>"+TotalendMarketsText[i]+"</option>"));
						}
						else
						{
							$j('#fundingMarkets').append($j("<option value='"+TotalendMarketsValues[i]+"'>"+TotalendMarketsText[i]+"</option>"));
						}
					}	
						
				        $j(".chosen-select").chosen();
						//$j("#fundingMarkets").val('').trigger('chosen:updated');
					
					}
					
			      }
				  else 
			       {
				   
				   
			       $j("#DynamicMarketparticipatingFunding").empty();
				   $j("#MarketparticipatingFunding").hide();
					flagStatus=true;
				  
				  }
				 });

	function dynamicFunding()
     {
		var i=0;
	    var comp="<div class='float-left'><select onChange='dynamicFundingHeight();' multiple data-placeholder='Select Market' class='chosen-select' id='fundingMarkets' name='fundingMarkets'></select><span class='jive-error-message fundingMarketsError fundErr__fix' style='display: none;'>Please select the end market(s) which will carry out the fieldwork</span></div>";
		return comp;	 
	 }
	 
	/* two column height calculation for funding component */
	function dynamicFundingHeight(){
		ht = $j('#DynamicMarketparticipatingFunding').height();
		$j('.two-column').height(ht);
	}
		$j("input[name=name]").change(function() {
		var name = $j("input[name=name]");
    if(name.pVal() != null && $j.trim(name.pVal())!="")
    {
        name.next().hide();
     }
	else{
	    //name.next().show();
		 name.focus();
		}
		});
	
	$j("#fieldWorkStudy").change(function(){
	var fieldWorkStudy = $j("#fieldWorkStudy");
	
	if(fieldWorkStudy.val() != null && $j.trim(fieldWorkStudy.val())=="-1")
	{
		$j("#fieldWorkStudyError").show();
		
	}
	else
	{
		$j("#fieldWorkStudyError").hide();
	
	}
	});
	
	
	
	$j("#categoryType").change(function()
	{
	
	var categoryType = $j("#categoryType");
	if(categoryType.val() != null)
	{
		$j("#categoryTypeError").hide();
	
	}
	else
	{
		//$j("#categoryTypeError").show();
		
	}
	});
	

	
	$j("#endMarkets").change(function()
	{
       var endMarkets = $j("#endMarkets");
	  
	   
       if($j.trim(endMarkets.val())=="" && endMarkets.val() == null )
       {
	     //$j("#endMarketError").show();
	     }
         else
	    {
	      $j("#endMarketError").hide();
	     }

	});
	
	
	
	
     $j("#euMarketConfirmation").change(function()
	 {
	    var endMarketConfirmation = $j('select[name="euMarketConfirmation"] option:selected').val();   
		if(endMarketConfirmation==-1)
		 {
		  // $j("#euMarketConfirmationError").show();
		  }
		else
		{$j("#euMarketConfirmationError").hide();}

	 
	 });
	
	
	
	
	
	
	$j("input[name=projectManagerName]").change(function()
	{
      var projectManagerName = $j("input[name=projectManagerName]");

    if(projectManagerName.val() != null && $j.trim(projectManagerName.val())=="")
    {
       // projectManagerName.parent().find("span").show();
      
       
    }
	else
	{
	 projectManagerName.parent().find("span").hide();
	}
	});
	
	
	
	
	
	
	
	// methodlogies
	
	$j("#methodologyDetails").change(function()
	{
	
	var methodologyDetails = $j("#methodologyDetails").val();
	
	
	
	if(methodologyDetails != null && methodologyDetails!="")
	{
	
	//$j("#methodologyDetails").next().find("span").hide();
	 $j("#methodologyDetails").next().next("span").hide();
	 
	 
	 var methodologyType = $j('select[name="methodologyType"] option:selected').val();
	 
	
	
    if(methodologyType < 1)
    {
   		//$j("#methodologyType").parent().find("span").show();
	   // $j("#methodologyType").focus();
		 $j("#methodologyType").next().next("span").hide();
		
      
    }
	else if(methodologyType==undefined)
	{
		// $j("#methodologyType").parent().find("span").show();
	     $j("#methodologyType").focus();
		 $j("#methodologyType").next().next("span").hide(); 
		 
        
	}
	else
	{
	  // alert("yes data available in type");
	   $j("#methodologyType").next().next("span").hide();
	}
	
	
	var brandSpecificStudy = $j('select[name="brandSpecificStudy"] option:selected').val();
	 
	  
	   if(brandSpecificStudy<1 ||brandSpecificStudy==undefined)
	   {
		 $j("#brandSpecificStudyError").hide();  
		   
	   }	
	 
	}
	
	else
	{

		 //$j("#methodologyDetails").parent().find("span").show();
	     $j("#methodologyDetails").focus();
        // $j("#methodologyType").parent().find("span").show();
	}
	
	});
	
	
	
	
	$j("#methodologyType").change(function()
	{
	  var methodologyType = $j('select[name="methodologyType"] option:selected').val();
	
       if(methodologyType < 1)
      {
   		//$j("#methodologyType").parent().find("span").show();
	    $j("#methodologyType").focus();
      
       }
	else if(methodologyType==undefined)
	{
		//$j("#methodologyType").parent().find("span").show();
	     $j("#methodologyType").focus();
        
	}
	
	 else
	 {
	   $j("#methodologyType").next().next("span").hide();
	 
	 }
   });
	
	
	$j("#methWaiverReq").change(function()
    {
	var methWaiverReq = $j('select[name="methWaiverReq"] option:selected').val();
	
    if(methWaiverReq < 1)
    {
        
		//$j("#methWaiverReq").parent().find("span").show();
	     $j("#methWaiverReq").focus();
       
    }
	else
	{
		
	    $j("#methWaiverReq").next().next("span").hide();
	 
	}
	
	});
	
	
	
    $j("#brandSpecificStudy").change(function()
	{
	
	var brandSpecificStudy = $j('select[name="brandSpecificStudy"] option:selected').val();
	
    if(brandSpecificStudy < 1)
    {
        
		//$j("#brandSpecificStudyError").show();
        
    }
	else if (brandSpecificStudy==undefined)
	{
		//$j("#brandSpecificStudyError").show();
        
	}
	else
	{
		$j("#brandSpecificStudyError").hide();
    
	}
	
	
	});
	

	
	//amit
	
	
	$j("#brandSpecificStudyType").change(function(){
	
	
	
	var brandSpecificStudyType = $j('select[name="brandSpecificStudyType"] option:selected').val();
	
	   
	
	  if(brandSpecificStudyType=="2" ||brandSpecificStudyType=="1")
	  {
	      $j("#brandSpecificStudyTypeError").hide();
	  }
	
     else if((brandSpecificStudyType < 1 || brandSpecificStudyType==undefined))
    {
        
		
		//$j("#brandSpecificStudyTypeError").show();
       
    }
	else
	{
	
	
		$j("#brandSpecificStudyTypeError").hide();
    
	}

	});
	
	
	
	

	$j("#brand").change(function()
	{
	var brand = $j('select[name="brand"] option:selected').val();
	 
    if((brand < 1 || brand==undefined))
    {
        
	//	$j("#brandError").show();
        error = true;
    }
	else
	{
		$j("#brandError").hide();
    
	}
 });


//const detail section start.

	$j("#budgetLocation").change(function()
	{

var budgetLocation = $j("#budgetLocation");

	if(budgetLocation.val() == null)
	{
		//$j("#budgetLocationError").show();
		
	}
	else if(budgetLocation.val() == "")
	{
		//$j("#budgetLocationError").show();
		
	}
	else
	{
		$j("#budgetLocationError").hide();
	}

});


	$j("#budgetYear").change(function()
	{

 var budgetYear = $j('select[name="budgetYear"] option:selected').val();

    if(budgetYear < 1)
    {
    	//$j("#budgetYearError").show();
    
    }
	else
	{
	
		$j("#budgetYearError").hide();
    }
 });
 
 $j("#endMarketFunding").change(function()
	{
      var endMarketFunding = $j('select[name="endMarketFunding"] option:selected').val();
      if(endMarketFunding!=null && endMarketFunding!=undefined && endMarketFunding < 1)
       {
    	//$j("#endMarketFundingError").show();
        
        }
	    else
	    {
		$j("#endMarketFundingError").hide();
    
	    }
	});
      $j(document).on("change","#fundingMarkets",function(e){
	
	     var marketvalue=$j("#fundingMarkets").val();
		  if(marketvalue==null)
		  {
		 
		 // $j(".fundingMarketsError").show();
		  }
		  else
		  {
		 
		  $j(".fundingMarketsError").hide();
		  }
	   });

	  // change 536
	   $j("input[name=multiBrandStudyText]").change(function()
      {
	var MultibrandText = $j("input[name=multiBrandStudyText]"); 
	
	 if(MultibrandText.val()!="")
	 {
		 $j("#MultibrandTextError").hide();
		 
	 }
 });
</script>
