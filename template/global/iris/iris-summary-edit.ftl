

<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#-- DWR def -->
<head>

<style>
  
    .rTableCellRight .mce-container.mce-panel{border: 0.5px solid #808080 !important;} 
	 .newSectionBox .mce-container.mce-panel{border: 0px solid #808080;} 

</style>
   
</head>

<script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>
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
<script type="text/javascript" src="${themePath}/js/scripts/multifile.js"></script>

<link rel="stylesheet" href="<@s.url value='${themePath}/js/tinymce_4.1.2/skins/lightgray/skin.min.css'/>" type="text/css" />

<link rel="stylesheet" href="<@s.url value='${themePath}/js/tinymce_4.1.2/skins/lightgray/content.min.css'/>" type="text/css" />
<#include "/template/decorator/default/synchro-header-javascript-rte.ftl" />

<script>
 <!-- for Calling textArea plugin  -->
	
	var insightTagCounterGlobal = 1;
	
	
 </script>




<#assign briefID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].PIB_BRIEF.getId()/>
<#assign othersID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].OTHERS.getId()/>

<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
<#include "/template/global/include/iris-macros.ftl" />






<div class="viewSummaryBox editSummaryContainer">
 <div class="colWidth75OuterWrap">
  <div class="contentWrapperBorderBox">
	<p class="topHeadStyle">CREATE NEW DOCUMENT</p>
	<form method="POST" name="editIRISSummaryForm" id="editIRISSummaryForm" action="/iris-summary/edit-summary!execute.jspa"  enctype="multipart/form-data">
	
			
		<input type="hidden" name="irisSummaryId" value="${irisSummary.irisSummaryId?c}" >
		<#if uploadSummary??>
			<input type="hidden" name="uploadSummary" value="${uploadSummary}" >
		<#else>
			<input type="hidden" name="uploadSummary" value="" >
		</#if>	
		<div class="colWidth75">

			<div class="mainHeadWrap">
			  <div class="topLinkAlignBox">
				<#if irisSummary.projectName??>
					<p>${irisSummary.projectName}</p>
				</#if>	
				
			  </div>
			</div>

			
					<div class="mainSubHeadWrap">
						<p>PROJECT DETAILS</p>
					</div>
	   
					<div class="editSummaryInnerWrap">
			
						  <div class="editContentBox">

							  <div class="rTable">

								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Synchro Code</p>
									</div>
									<div class="rTableCellRight"> 
										<#if irisSummary.synchroCode?? && irisSummary.synchroCode gt 0>
											<input type="text" id="" name="synchroCode" value='${irisSummary.synchroCode?c}'>
										<#else>
											<input type="text" id="" name="synchroCode" value=''>
										</#if>	
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Project Name</p>
									</div>
									<div class="rTableCellRight"> 
										 <#if irisSummary.projectName??>
											<input type="text" id="" name="projectName" value="${irisSummary.projectName}">
										<#else>
											<input type="text" id="" name="projectName" value=''>
										</#if>	
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Research End-Market(S)</p>
									</div>
									<div class="rTableCellRight"> 
											
										<select data-placeholder="" class="chosen-select" id = "endMarketId" name='endMarketId' multiple>
								
											<option value=""></option>
											<#assign endMarketRegions = statics['com.grail.synchro.SynchroGlobal'].getRegionEndMarketsMapping() />
											<#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
											<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets() />
												<#assign endMarketRegionsKeySet = endMarketRegions.keySet() />
												<#if (endMarketRegions?has_content)>
													<#list endMarketRegionsKeySet as key>
														<#assign region = endMarketRegions.get(key) />
														 <optgroup label="${regions.get(key)}">
															 <#assign endMarketKeySet = endMarketRegions.get(key).keySet() />
															 <#list endMarketKeySet as endMarketkey>
																<option value="${endMarketkey?c}"  <#if irisSummary.endMarketId?? && irisSummary.endMarketId?seq_contains(endMarketkey)> selected </#if>>${endMarkets.get(endMarketkey)}</option>
															 </#list>
														</optgroup>	 
													</#list>
												</#if>
										</select>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Research Location(S)</p>
									</div>
									<div class="rTableCellRight"> 
										<#if irisSummary.researchLocation??>
											<input type="text" id="" name="researchLocation" value="${irisSummary.researchLocation}">
										<#else>
											<input type="text" id="" name="researchLocation" value=''>
										</#if>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>SP&I Contact</p>
									</div>
									<div class="rTableCellRight"> 
										<#if irisSummary.spiContact??>
											<input type="text" id="" name="spiContact" value="${irisSummary.spiContact}">
										<#else>
											<input type="text" id="" name="spiContact" value=''>
										</#if>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Methodology Name</p>
									</div>
									<div class="rTableCellRight"> 
										<select title=""  data-placeholder="" class="chosen-select" id = "methodologyDetails" name = "methodology" multiple>
						
											<option value=""></option>
											<#assign methMethGroupMapping = statics['com.grail.synchro.SynchroGlobal'].getAllMethodologyMapping() />
											<#assign methGroup = statics['com.grail.synchro.SynchroGlobal'].getMethodologyGroups(true, 0) />
											<#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getAllMethodologies() />
											<#assign methodologyProperties = statics['com.grail.synchro.SynchroGlobal'].getAllMethodologyProperties() />
											<#assign methMethGroupKeySet = methMethGroupMapping.keySet() />
												<#if (methMethGroupMapping?has_content)>
													<#list methMethGroupKeySet as key>
														<optgroup label="${methGroup.get(key)}">
														<#assign methKeySet = methMethGroupMapping.get(key).keySet() />
														<#list methKeySet as methkey>
															<option value="${methkey?c}" <#if irisSummary.methodology?? && irisSummary.methodology?seq_contains(methkey) > selected</#if> >${methodologies.get(methkey)}</option>
														</#list>
														</optgroup>	 
													</#list>
												</#if>
										</select>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Methodology And Stimulus Description</p>
									</div>
									<div class="rTableCellRight">  
									   <#if irisSummary.methodologyDesc??>
										  <textarea  id="methodologyDesc" name="methodologyDesc">${irisSummary.methodologyDesc?default('')?html}</textarea>
										 <#else>
									   </#if>
										<textarea style="display:none;" id="methodologyDescText" name="methodologyDescText">${irisSummary.methodologyDescText?default('')?html}</textarea> 
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Target Group</p>
									</div>
									<div class="rTableCellRight">  
										<#if irisSummary.targetGroup??>
											<textarea  id="targetGroup" name="targetGroup" rows="10" cols="20" class="form-text-div">${irisSummary.targetGroup?default('')?html}</textarea>
												
										<#else>		
											<textarea  id="targetGroup" name="targetGroup"></textarea>	
										</#if>	
										<textarea style="display:none;" id="targetGroupText" name="targetGroupText">${irisSummary.targetGroupText?default('')?html}</textarea>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Sample Size</p>
									</div>
									<div class="rTableCellRight">  
										<#if irisSummary.sampleSize??>
											<textarea  id="sampleSize" name="sampleSize">${irisSummary.sampleSize?default('')?html}</textarea>
										<#else>
											<textarea  id="sampleSize" name="sampleSize"></textarea>
										</#if>
										<textarea style="display:none;" id="sampleSizeText" name="sampleSizeText">${irisSummary.sampleSizeText?default('')?html}</textarea>
									</div>
								</div>
								
								
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Brand Coverage</p>
									</div>
									<div class="rTableCellRight"> 
										<#if irisSummary.brandCoverage??>
											
											<select data-placeholder="" class="chosen-select" id = "brandCoverage" name="brandCoverage" >
												<option value=""></option>
												<option value="${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].BRAND_SPECIFIC.getId()}" <#if irisSummary.brandCoverage == statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].BRAND_SPECIFIC.getId()> selected </#if>  >${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].BRAND_SPECIFIC.getDescription()}</option>
												<option value="${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getId()}"  <#if irisSummary.brandCoverage == statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getId()> selected </#if> >${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getDescription()}</option>
												<option value="${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getId()}"  <#if irisSummary.brandCoverage == statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getId()> selected </#if>  >${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getDescription()}</option>
											</select>
										<#else>
											<select data-placeholder="" class="chosen-select" id = "brandCoverage" name="brandCoverage" >
												<option value=""></option>
												<option value="${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].BRAND_SPECIFIC.getId()}"  >${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].BRAND_SPECIFIC.getDescription()}</option>
												<option value="${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getId()}"  >${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getDescription()}</option>
												<option value="${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getId()}"  >${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getDescription()}</option>
											</select>
										</#if>
									</div>							
								</div>
								
								<#if irisSummary.brandCoverage?? && irisSummary.brandCoverage == statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getId()>
									<div class="rTableRow" id="brandHouseDiv" style="display:none">
										<div class="rTableCellLeft">
											<p>Brand House(s)</p>
										</div>
										<div class="rTableCellRight"> 
											<select title="" data-placeholder="Select the Brand" class="chosen-select" id = "brandHouseSingle" name='brandHouseSingle' >
												<option value="-1"></option>
												<#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
												<#if (brands?has_content)>
													<#list brands.keySet() as key>
														<#assign brand = brands.get(key)/>
														<#if brand == "Non-Brand Related" && key == 1>
														<#else>
															<option value="${key?c}" <#if irisSummary.brandHouse?? && irisSummary.brandHouse?seq_contains(key) >selected="selected"</#if>>${brand}</option>
														</#if>	
													</#list>
												</#if>
											</select>	
										</div>							
									</div>
									<div class="rTableRow" id="brandHouseMultipleDiv" style="display:none">
										<div class="rTableCellLeft">
											<p>Brand House(s)</p>
										</div>
										<div class="rTableCellRight"> 
											<select title="" data-placeholder="Select the Brand" class="chosen-select" id = "brandHouseMultiple" name='brandHouseMultiple' multiple >
												<option value="-1"></option>
												<#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
												<#if (brands?has_content)>
													<#list brands.keySet() as key>
														<#assign brand = brands.get(key)/>
														<#if brand == "Non-Brand Related" && key == 1>
														<#else>
															<option value="${key?c}" <#if irisSummary.brandHouse?? && irisSummary.brandHouse?seq_contains(key) >selected="selected"</#if>>${brand}</option>
														</#if>	
													</#list>
												</#if>
											</select>	
										</div>							
									</div>
								<#elseif irisSummary.brandCoverage?? && irisSummary.brandCoverage == statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].BRAND_SPECIFIC.getId()>
									<div class="rTableRow" id="brandHouseDiv">
										<div class="rTableCellLeft">
											<p>Brand House(s)</p>
										</div>
										<div class="rTableCellRight"> 
											<select title="" data-placeholder="Select the Brand" class="chosen-select" id = "brandHouseSingle" name='brandHouseSingle' >
												<option value="-1"></option>
												<#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
												<#if (brands?has_content)>
													<#list brands.keySet() as key>
														<#assign brand = brands.get(key)/>
														<#if brand == "Non-Brand Related" && key == 1>
														<#else>	
															<option value="${key?c}" <#if irisSummary.brandHouse?? && irisSummary.brandHouse?seq_contains(key) >selected="selected"</#if>>${brand}</option>
														</#if>	
															
													</#list>
												</#if>
											</select>	
										</div>							
									</div>
									<div class="rTableRow" id="brandHouseMultipleDiv" style="display:none">
										<div class="rTableCellLeft">
											<p>Brand House(s)</p>
										</div>
										<div class="rTableCellRight"> 
											<select title="" data-placeholder="Select the Brand" class="chosen-select" id = "brandHouseMultiple" name='brandHouseMultiple' multiple >
												<option value="-1"></option>
												<#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
												<#if (brands?has_content)>
													<#list brands.keySet() as key>
														<#assign brand = brands.get(key)/>
														<#if brand == "Non-Brand Related" && key == 1>
														<#else>
															<option value="${key?c}" <#if irisSummary.brandHouse?? && irisSummary.brandHouse?seq_contains(key) >selected="selected"</#if>>${brand}</option>
														</#if>	
													</#list>
												</#if>
											</select>	
										</div>							
									</div>
								<#elseif irisSummary.brandCoverage?? && irisSummary.brandCoverage == statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getId()>	
								
									<div class="rTableRow" id="brandHouseDiv" style="display:none">
										<div class="rTableCellLeft">
											<p>Brand House(s)</p>
										</div>
										<div class="rTableCellRight"> 
											<select title="" data-placeholder="Select the Brand" class="chosen-select" id = "brandHouseSingle" name='brandHouseSingle' >
												<option value="-1"></option>
												<#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
												<#if (brands?has_content)>
													<#list brands.keySet() as key>
														<#assign brand = brands.get(key)/>
														<#if brand == "Non-Brand Related" && key == 1>
														<#else>
															<option value="${key?c}" <#if irisSummary.brandHouse?? && irisSummary.brandHouse?seq_contains(key) >selected="selected"</#if>>${brand}</option>
														</#if>	
													</#list>
												</#if>
											</select>	
										</div>							
									</div>
									<div class="rTableRow" id="brandHouseMultipleDiv" >
										<div class="rTableCellLeft">
											<p>Brand House(s)</p>
										</div>
										<div class="rTableCellRight"> 
											<select title="" data-placeholder="Select the Brand" class="chosen-select" id = "brandHouseMultiple" name='brandHouseMultiple' multiple >
												<option value="-1"></option>
												<#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
												<#if (brands?has_content)>
													<#list brands.keySet() as key>
														<#assign brand = brands.get(key)/>
														<#if brand=="Non-Brand Related" && key == 1>
														<#else>
															<option value="${key?c}" <#if irisSummary.brandHouse?? && irisSummary.brandHouse?seq_contains(key) >selected="selected"</#if>>${brand}</option>
														</#if>	
													</#list>
												</#if>
											</select>	
										</div>							
									</div>
								</#if>	
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Category</p>
									</div>
									<div class="rTableCellRight"> 
										<select data-placeholder="" class="chosen-select" id = "category" name="category" multiple>
											<option value=""></option>
											<#assign categoryTypes = statics['com.grail.synchro.SynchroGlobal'].getProductTypes() />
											<#assign categoryTypeKeySet = categoryTypes.keySet() />
											<#if (categoryTypes?has_content)>
												<#list categoryTypeKeySet as key>
													<#assign categoryType = categoryTypes.get(key) />
													<option value="${key?c}" <#if irisSummary.category?? && irisSummary.category?seq_contains(key)> selected</#if> >${categoryType}</option>
												</#list>
											</#if>
										</select>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Research Agency - Fieldwork</p>
									</div>
									<div class="rTableCellRight"> 
										<select data-placeholder="Select Research Agency" title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "fieldworkResearchAgency" name='fieldworkResearchAgency' multiple >
											<option value=""></option>
											<#assign researchAgencyMapping = statics['com.grail.synchro.SynchroGlobal'].getAllResearchAgencyMapping() />
											<#assign researchAgencyGroups = statics['com.grail.synchro.SynchroGlobal'].getResearchAgencyGroup() />
											<#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getAllResearchAgency() />
											<#assign researchAgencyMappingKeySet = researchAgencyMapping.keySet() />
											<#if (researchAgencyMapping?has_content)>
												<#list researchAgencyMappingKeySet as key>
													<#assign researchAgnecyGroup = researchAgencyMapping.get(key) />
													<optgroup label="${researchAgencyGroups.get(key)}">
														<#assign researchAgencyKeySet = researchAgencyMapping.get(key).keySet() />
														<#list researchAgencyKeySet as researchAgencykey>
															<option value="${researchAgencykey?c}" <#if irisSummary.fieldworkResearchAgency?? && irisSummary.fieldworkResearchAgency?seq_contains(researchAgencykey) > selected </#if>>${researchAgencies.get(researchAgencykey)}</option>
														</#list>
													</optgroup>	 
												</#list>
											</#if>
										</select>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Research Agency - Coordination</p>
									</div>
									<div class="rTableCellRight"> 
										<select data-placeholder="Select Research Agency" title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "coordinationResearchAgency" name='coordinationResearchAgency' multiple >
											<option value=""></option>
											<#assign researchAgencyMapping = statics['com.grail.synchro.SynchroGlobal'].getAllResearchAgencyMapping() />
											<#assign researchAgencyGroups = statics['com.grail.synchro.SynchroGlobal'].getResearchAgencyGroup() />
											<#assign researchAgencies = statics['com.grail.synchro.SynchroGlobal'].getAllResearchAgency() />
											<#assign researchAgencyMappingKeySet = researchAgencyMapping.keySet() />
											<#if (researchAgencyMapping?has_content)>
												<#list researchAgencyMappingKeySet as key>
													<#assign researchAgnecyGroup = researchAgencyMapping.get(key) />
													<optgroup label="${researchAgencyGroups.get(key)}">
														<#assign researchAgencyKeySet = researchAgencyMapping.get(key).keySet() />
														<#list researchAgencyKeySet as researchAgencykey>
															<option value="${researchAgencykey?c}" <#if  irisSummary.coordinationResearchAgency?? &&  irisSummary.coordinationResearchAgency?seq_contains(researchAgencykey)  > selected </#if>>${researchAgencies.get(researchAgencykey)}</option>
														</#list>
													</optgroup>	 
												</#list>
											</#if>
										</select>
									</div>							
								</div>

							</div>

						 </div>
					</div>







				 <div class="newSectionBox">
					<div class="mainSubHeadWrap">
						<p>RESEARCH DETAILS</p>
					</div>
	   
					<div class="editSummaryInnerWrap">
			
						  <div class="editContentBox">

							  <div class="rTable">

								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Fieldwork/Research Start Date</p>
									</div>
									<div class="rTableCellRight"> 
										<#if irisSummary.fwStartDate??>
											<#-- <input type="text" id="" name="fwStartDate" value="${irisSummary.fwStartDate?string('dd/MM/yyyy')}"> -->
											 <@irisdatetimepicker id="fwStartDate" name="fwStartDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false /> 
										<#else>
											<@irisdatetimepicker id="fwStartDate" name="fwStartDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false /> 
										</#if>
										<a class="editDeleteIconAlign" href="#"> <img src="${themePath}/images/iris/cross-icon.png"> </a>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Fieldwork/Research End Date</p>
									</div>
									<div class="rTableCellRight"> 
										<#if irisSummary.fwEndDate??>
											<#--<input type="text" id="" name="fwEndDate" value="${irisSummary.fwEndDate?string('dd/MM/yyyy')}">  -->
											 <@irisdatetimepicker id="fwEndDate" name="fwEndDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false /> 
										<#else>
											 <@irisdatetimepicker id="fwEndDate" name="fwEndDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false /> 
										</#if>
										<a class="editDeleteIconAlign" href="#"> <img src="${themePath}/images/iris/cross-icon.png"> </a>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Final Report Date</p>
									</div>
									<div class="rTableCellRight"> 
										<#if irisSummary.finalReportDate??>
											 <#-- <input type="text" id="" name="finalReportDate" value="${irisSummary.finalReportDate?string('dd/MM/yyyy')}"> -->
											<@irisdatetimepicker id="finalReportDate" name="finalReportDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false /> 
										<#else>
											<@irisdatetimepicker id="finalReportDate" name="finalReportDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false /> 
										</#if>
										<a class="editDeleteIconAlign" href="#"> <img src="${themePath}/images/iris/cross-icon.png"> </a>
									</div>							
								</div>

								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Research Background</p>
									</div>
									<div class="rTableCellRight">  
										<#if irisSummary.researchBackGround??>
											<textarea  id="researchBackGround" name="researchBackGround">${irisSummary.researchBackGround?default('')?html}</textarea>
										<#else>
											<textarea  id="researchBackGround" name="researchBackGround"></textarea>
										</#if>
										<textarea style="display:none;" id="researchBackGroundText" name="researchBackGroundText">${irisSummary.researchBackGroundText?default('')?html}</textarea>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Main Research Objective</p>
									</div>
									<div class="rTableCellRight">  
										<#if irisSummary.mainResearchObjective??>
											<textarea  id="mainResearchObjective" name="mainResearchObjective">${irisSummary.mainResearchObjective?default('')?html}</textarea>
										<#else>
											<textarea  id="mainResearchObjective" name="mainResearchObjective"></textarea>
										</#if>
										<textarea style="display:none;" id="mainResearchObjectiveText" name="mainResearchObjectiveText">${irisSummary.mainResearchObjectiveText?default('')?html}</textarea>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Research Questions</p>
									</div>
									<div class="rTableCellRight">  
										<#if irisSummary.mainResearchObjective??>
											<textarea  id="researchQuestion" name="researchQuestion">${irisSummary.researchQuestion?default('')?html}</textarea>
										<#else>
											<textarea  id="researchQuestion" name="researchQuestion"></textarea>
										</#if>
										<textarea style="display:none;" id="researchQuestionText" name="researchQuestionText">${irisSummary.researchQuestionText?default('')?html}</textarea>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Action Standard(s)</p>
									</div>
									<div class="rTableCellRight">  
										<#if irisSummary.mainResearchObjective??>
											<textarea  id="actionStandard" name="actionStandard">${irisSummary.actionStandard?default('')?html}</textarea>
										<#else>
											<textarea  id="actionStandard" name="actionStandard"></textarea>
										</#if>
										<textarea style="display:none;" id="actionStandardText" name="actionStandardText">${irisSummary.actionStandardText?default('')?html}</textarea>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Findings</p>
									</div>
									<div class="rTableCellRight">  
										<#if irisSummary.findings??>
											<textarea  id="findings" name="findings">${irisSummary.findings?default('')?html}</textarea>
										<#else>
											<textarea  id="findings" name="findings"></textarea>
										</#if>
										<textarea style="display:none;" id="findingsText" name="findingsText">${irisSummary.findingsText?default('')?html}</textarea>
									</div>							
								</div>
								
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Result Against Action Standards</p>
									</div>
									<div class="rTableCellRight">  
										<#if irisSummary.resultAgainstActionStandard??>
											<textarea  id="resultAgainstActionStandard" name="resultAgainstActionStandard">${irisSummary.resultAgainstActionStandard?default('')?html}</textarea>
										<#else>
											<textarea  id="resultAgainstActionStandard" name="resultAgainstActionStandard"></textarea>
										</#if>
										<textarea style="display:none;" id="resultAgainstActionStandardText" name="resultAgainstActionStandardText">${irisSummary.resultAgainstActionStandardText?default('')?html}</textarea>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Conclusions</p>
									</div>
									<div class="rTableCellRight">  
										<#if irisSummary.conclusion??>
											<textarea  id="conclusion" name="conclusion">${irisSummary.conclusion?default('')?html}</textarea>
										<#else>
											<textarea  id="conclusion" name="conclusion"></textarea>
										</#if>
										<textarea style="display:none;" id="conclusionText" name="conclusionText">${irisSummary.conclusionText?default('')?html}</textarea>
									</div>							
								</div>

								

							</div>

						 </div>
					</div>

				</div>





				<div class="newSectionBox editResearchInsightWrap">
					<div class="mainSubHeadWrap">
						<p>RESEARCH INSIGHTS</p>
					</div>




					<#assign productTag="" />
					<#assign projectTag="" />
					
					<#assign insightTagSeqNo = 1 />


                       <div class="researchInsightOuterWrap">

                       	<a id="incrementRow" href="#"><i class="fa fa-plus" aria-hidden="true"></i></a>
                       	<div class="clearfix"></div>

						<#if irisSummaryInsightsList?? && irisSummaryInsightsList?size gt 0>
							<#list irisSummaryInsightsList as irisSummaryInsight>
								<#if irisSummaryInsight.getInsightsText()?? && irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PRODUCT_TAGS_NAME>
									<#if irisSummaryInsight.getTags()?? >
										<#assign productTag=irisSummaryInsight.getTags() />
									</#if>	
								<#elseif irisSummaryInsight.getInsightsText()?? && irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PROJECT_TAGS_NAME>
									<#if irisSummaryInsight.getTags()?? >
										<#assign projectTag=irisSummaryInsight.getTags() />
									</#if>
								<#else>	

									<div id="insightTags_${insightTagSeqNo}" class="insightAccordionContent">
										<div class="researchInsightContentWrap">
										  <div class="insightAccordionBox"> 
											<p contenteditable="true" id="inHeading_${insightTagSeqNo}" name="inHeading"><#if irisSummaryInsight.insightsHeading??>${irisSummaryInsight.insightsHeading}</#if></p> <span><i id="researchInsightEditCaret" class="fa fa-close" onclick="removeInsightTag(${insightTagSeqNo})"></i></span>
										  </div>
										</div>
		 
										<textarea  id="insights_${insightTagSeqNo}" name="insights">${irisSummaryInsight.insights?default('')?html}</textarea>
										<#assign insightTextVarName = "insights_${insightTagSeqNo}" + "Text" />
										<textarea  style="display:none;" id="${insightTextVarName}" name="insightsText">${irisSummaryInsight.insightsText?default('')?html}</textarea>
											
									
										<div class="rTable">
											<div class="rTableRow">
												<div class="rTableCellLeft">
													<p>TAG(S)</p>
												</div>
												<div class="rTableCellRight"> 
													<#if irisSummaryInsight.tags??>
														<input type="text" id="tags_${insightTagSeqNo}" name="tags" value="${irisSummaryInsight.tags}">
													<#else>
														<input type="text" id="tags_${insightTagSeqNo}" name="tags" value="">
													</#if>	
													<span class="irisSummaryTagsError" id="tags_Error_${insightTagSeqNo}" style="display:none">Please enter Tags</span>
												</div>							
											</div>
										</div>
								
									</div>
									<input type="hidden" id="insightTagSeqNo" name="insightTagSeqNo" value="${insightTagSeqNo}">
									<#assign insightTagSeqNo = insightTagSeqNo + 1 />
								</#if>	
							</#list>
						</#if>	
						<input type="hidden" id="insightsHeading" name="insightsHeading" value="">

                                <div id="productTagsDiv" class="rTable">
                                  	<div class="rTableRow">
										<div class="rTableCellLeft">
											<p>PRODUCT TAG(S)</p>
										</div>
										<div class="rTableCellRight"> 
											<input type="text" name="productTag" value="${productTag}">
										</div>							
								  	</div>
								</div>

								<div class="rTable">
                                  	<div class="rTableRow">
										<div class="rTableCellLeft">
											<p>PROJECT TAG(S)</p>
										</div>
										<div class="rTableCellRight"> 
											<input type="text" name="projectTag" value="${projectTag}">
										</div>							
								  	</div>
								</div>



						</div>


					







<#--
						 <div class="topInnerWrapBox">
						   <div class="rTable">
								<div class="rTableRow">
									<div class="rTableHead"><strong>INSIGHTS</strong></div>
									<div class="rTableHead"><strong>TAG(S)</strong></div>
								</div>
								<#assign productTag="" />
								<#assign projectTag="" />
								
								<#assign insightTagSeqNo = 1 />
								<#if irisSummaryInsightsList?? && irisSummaryInsightsList?size gt 0>
									<#list irisSummaryInsightsList as irisSummaryInsight>
										<#if irisSummaryInsight.getInsightsText()?? && irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PRODUCT_TAGS_NAME>
											<#if irisSummaryInsight.getTags()?? >
												<#assign productTag=irisSummaryInsight.getTags() />
											</#if>	
										<#elseif irisSummaryInsight.getInsightsText()?? && irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PROJECT_TAGS_NAME>
											<#if irisSummaryInsight.getTags()?? >
												<#assign projectTag=irisSummaryInsight.getTags() />
											</#if>
										<#else>	
											<div class="rTableRow">
												<div class="rTableCell">		
													<textarea  id="insights_${insightTagSeqNo}" name="insights">${irisSummaryInsight.insights?default('')?html}</textarea>
													<#assign insightTextVarName = "insights_${insightTagSeqNo}" + "Text" />
													<textarea  style="display:none;" id="${insightTextVarName}" name="insightsText">${irisSummaryInsight.insightsText?default('')?html}</textarea>
												</div>
												<div class="rTableCell">
													
													<#if irisSummaryInsight.tags??>
														<input type="text" id="tags" name="tags" value="${irisSummaryInsight.tags}">
													<#else>
														<input type="text" id="tags" name="tags" value="">
													</#if>	
												</div>							
											</div>
											<input type="hidden" id="insightTagSeqNo" name="insightTagSeqNo" value="${insightTagSeqNo}">
											<#assign insightTagSeqNo = insightTagSeqNo + 1 />
											
										</#if>	
										
									</#list>
								</#if>
								
								
							</div>
						</div> 


						   <div class="belowInnerWrapBox">
							  <div class="rTable">
								<div class="rTableRow">
									<div class="rTableHead"><strong>PRODUCT TAG(S)</strong></div>
									<div class="rTableHead"><strong>PROJECT TAG(S)</strong></div>
								</div>
								<div class="rTableRow">
									<div class="rTableCell">

										
										<input type="text" name="productTag" value="">
										

									</div>
									<div class="rTableCell">
							
										 <input type="text" name="projectTag" value="">

									</div>							
								</div>

							</div>
						 </div>   
-->
				</div>



				 <div class="newSectionBox">
					<div class="mainSubHeadWrap">
						<p>SUMMARY DETAILS</p>
					</div>
	   
					<div class="editSummaryInnerWrap">
			
						  <div class="editContentBox">

							  <div class="rTable">

								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Blurb</p>
									</div>
									<div class="rTableCellRight"> 
										<#if irisSummary.blurbs??>
											<textarea  id="blurbs" name="blurbs">${irisSummary.blurbs?default('')?html}</textarea>
										<#else>
											<textarea  id="blurbs" name="blurbs">${irisSummary.blurbs?default('')?html}</textarea>
										</#if>
										<textarea style="display:none;" id="blurbsText" name="blurbsText">${irisSummary.blurbsText?default('')?html}</textarea>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Summary Written By</p>
									</div>
									<div class="rTableCellRight"> 
										<#if irisSummary.summaryWrittenByName??>
											<input type="text" id="" name="summaryWrittenByName" value="${irisSummary.summaryWrittenByName}">
										<#else>
											<input type="text" id="" name="summaryWrittenByName" >
										</#if>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Designation</p>
									</div>
									<div class="rTableCellRight"> 
										<#if irisSummary.summaryDesignation??>
											<input type="text" id="" name="summaryDesignation" value="${irisSummary.summaryDesignation}">
										<#else>
											<input type="text" id="" name="summaryDesignation" >
										</#if>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Agency Name</p>
									</div>
									<div class="rTableCellRight"> 
										<select data-placeholder="Select Research Agency" title="Select Research Agency" class="chosen-select  appended-agency researchAgency" id = "summaryAgencyName" name='summaryAgencyName' >
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
															
															<option value="${researchAgencykey?c}" <#if irisSummary.summaryAgencyName?? && irisSummary.summaryAgencyName==researchAgencykey> selected </#if>>${researchAgencies.get(researchAgencykey)}</option>
														 </#list>
													</optgroup>	 
												</#list>
											</#if>
									</select>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Summary Completion Date</p>
									</div>
									<div class="rTableCellRight"> 
										<#if irisSummary.summaryCompletionDate??>
											<#-- <input type="text" id="" name="summaryCompletionDate" value="${irisSummary.summaryCompletionDate?string('dd/MM/yyyy')}"> -->
											<@irisdatetimepicker id="summaryCompletionDate" name="summaryCompletionDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false /> 
										<#else>
											<@irisdatetimepicker id="summaryCompletionDate" name="summaryCompletionDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false /> 
										</#if>

										<a class="editDeleteIconAlign" href="#"> <img src="/themes/rkp_theme/images/iris/cross-icon.png"> </a>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Summary Approved By</p>
									</div>
									<div class="rTableCellRight"> 
										<#if irisSummary.summaryApprovedBy??>
											<input type="text" id="" name="summaryApprovedBy" value="${irisSummary.summaryApprovedBy}">
										<#else>
											<input type="text" id="" name="summaryApprovedBy" >
										</#if>
									</div>							
								</div>

								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Summary Approval Date</p>
									</div>
									<div class="rTableCellRight"> 
										<#if irisSummary.summaryApprovalDate??>
											<#-- <input type="text" id="" name="summaryApprovalDate" value="${irisSummary.summaryApprovalDate?string('dd/MM/yyyy')}"> -->
											<@irisdatetimepicker id="summaryApprovalDate" name="summaryApprovalDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false /> 
										<#else>
											<@irisdatetimepicker id="summaryApprovalDate" name="summaryApprovalDate1" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false /> 
										</#if>
										<a class="editDeleteIconAlign" href="#"> <img src="/themes/rkp_theme/images/iris/cross-icon.png"> </a>
									</div>							
								</div>
								
								<div class="rTableRow">
									<div class="rTableCellLeft">
										<p>Related Studies</p>
									</div>
									<div class="rTableCellRight"> 
										<#if irisSummary.relatedStudies??>
											<input type="text" id="" name="relatedStudies" value="${irisSummary.relatedStudies}">
										<#else>
											<input type="text" id="" name="relatedStudies" >
										</#if>
									</div>							
								</div>

								
							</div>

						 </div>
					</div>

				</div>



			<div>

				<div class="bottomBrowseSectionWrap">
					  <span class="attachHeadContent">Attach Report <img src="${themePath}/images/iris/attachment-icon.png" class="attachIcon"></span>
					<p>Maximum Size: 50 MB</p>
					<p>Maximum number of attachments allowed: 100</p>
					
					
				 	<!--<p> <img src="${themePath}/images/iris/pdf-icon.png"> <span>file size in mb.pdf</span> </p> -->

					<!--  <div class="bottomBtnWrap">
						<div class="bottomBtnWrapAlign">
							  <p>BROWSE</p>
					   </div>
				   </div>   --> 
				   
				   
				   <@irisSummaryAttachements attachments=irisSummaryAttachments canAttach=true maxAttachCount=30 attachmentCount=attachmentCount  />

				</div>
				<input type="hidden" name="status" id="status" value="">

				<div class="attachBelowBtnWrap">
				   <div class="bottomBtnWrap">
						<div class="bottomBtnWrapAlign" onclick="return publish();">
							  <p class="hoverCls">PUBLISH</p>
					   </div>
				   </div>

					<#if irisSummary.status?? && irisSummary.status == 0 >
						<div class="bottomBtnWrap">
							<div class="bottomBtnWrapAlign"  onclick="return saveAsDraft();">
								  <p class="hoverCls">SAVE DRAFT</p>
						   </div>
					   </div>
					</#if>
					
					 <div class="bottomBtnWrap">
						<div class="bottomBtnWrapAlign" onclick="cancelSummary();">
							  <p class="hoverCls">CANCEL</p>
					   </div>
				   </div>
				</div>

			</div>

			
		</div>  <!--End colWidth75 div -->
	</form>
	
	<form method="POST" name="cancelIRISSummary" id="cancelIRISSummary" action="/iris-summary/edit-summary!cancelIRISSummary.jspa"  >
		<input type="hidden" name="irisSummaryId" value="${irisSummary.irisSummaryId?c}" >
	</form>	
</div>

</div>

<div class="successPopupwrap">
	<div id="dialogOverlayDataSuccess">
	   <div class="dialogBoxWrap">
	   	 <div class="successDialogWrap">
	   		<img src="${themePath}/images/iris/green-tick.png">
	   		<h5> 
				<b>
					IRIS Summary uploaded successfully. 
					<#if uploadSummaryMessage??>
						${uploadSummaryMessage}
					</#if>
				
				</b> 
			</h5>
	      <div>
	   		 <div class="dialogBtnBox">
			   <p class="okBtn">OK</p>

			  
			  <!--  <p>Summary successfully published in <a href='/iris-summary/admin-home.jspa' target="_blank">Admin Panel</a> > <a href='/iris-summary/container-regions.jspa' target="_blank">Spaces</a> >  <span id="abc"></span>  </p> -->


		     </div>
		  </div>
	   	</div>
	   </div> 
	</div>
</div>
  
  <script type="text/javascript">
    var attachmentWindow = null;
    $j(document).ready(function(){
        attachmentWindow = new IRIS_SUMMARY_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/iris-summary/edit-summary!addAttachment.jspa'/>",
             irisSummaryId:${irisSummary.irisSummaryId?c}

        });

        $j("#fileAttachBtn").bind('click',function(){
            attachmentWindow.show();
        });
		
		$j("#brandCoverage").change(function() {
			
			
			if($j(this).val()==3)
			{
				$j("#brandHouseDiv").hide();
				$j("#brandHouseMultipleDiv").hide();
			}
			if($j(this).val()==1)
			{
				$j("#brandHouseDiv").show();
				$j("#brandHouseMultipleDiv").hide();
			}
			if($j(this).val()==2)
			{
				$j("#brandHouseDiv").hide();
				$j("#brandHouseMultipleDiv").show();
			}
			
		});
		
		initiateRTE('methodologyDesc', 10000, true);
		initiateRTE('targetGroup', 10000, true);
		initiateRTE('sampleSize', 10000, true);
		initiateRTE('researchBackGround', 10000, true);
		initiateRTE('mainResearchObjective', 10000, true);
		initiateRTE('researchQuestion', 10000, true);
		initiateRTE('actionStandard', 10000, true);
		initiateRTE('findings', 10000, true);
		initiateRTE('resultAgainstActionStandard', 10000, true);
		initiateRTE('conclusion', 10000, true);
		initiateRTE('blurbs', 10000, true);
		
		
		

		
		
		<#if irisSummaryInsightsList?? && irisSummaryInsightsList?size gt 0>
			<#assign insightTagCounter = 1 />
			<#list irisSummaryInsightsList as irisSummaryInsight>
				initiateRTE('insights_${insightTagCounter}', 10000, true);
				<#assign insightTagCounter = insightTagCounter + 1 />
				insightTagCounterGlobal = insightTagCounterGlobal + 1;
			</#list>	
		</#if>
		
		
		// for  upload summary Successfully




         //  Summary saved in draft...
       if(window.location.href.indexOf("saved=true&uploadSummary=true") > -1) 
		{



			 
		}
		//  summary uploaded successfully..
		else if(window.location.href.indexOf("uploadSummary=true&version=invalid&versionNo=") > -1)
		{

			 //  tick pop  ......
			  $j('#dialogOverlayDataSuccess').show();

			
		}
		//  summary uploaded successfully..
		else if(window.location.href.indexOf("uploadSummary=true") > -1)
		{

			 //  tick pop  ......
			  $j('#dialogOverlayDataSuccess').show();

			
		}




    $j('.dialogBoxWrap .dialogBtnBox p.okBtn').click(function(){
   	     $j('#dialogOverlayDataSuccess').hide();
   });	
		
    });

    function showAttachmentPopup(fieldId) {
         attachmentWindow.show(fieldId);
		 
		
    }
	
	function removeAttachment(attachmentId) 
	{
		dialog({
			title: 'Confirm Delete',
			html: '<p>Are you sure you want to remove the attachment </p>',
			buttons:{
				"DELETE":function() {
					confirmDelete(attachmentId);
				},
				"CANCEL": function() {
					closeDialog();
				}
			}
		});

	}

	function confirmDelete(attachmentId) 
	{
		location.href="/iris-summary/edit-summary!removeAttachment.jspa?irisSummaryId=${irisSummaryId?c}&attachmentId="+attachmentId;
	}

	<#if irisSummary.fwStartDate??>
		var _fwStartDate = "${irisSummary.fwStartDate?string('dd/MM/yyyy')}";
		$j("#fwStartDate").val(_fwStartDate);
	</#if>

	<#if irisSummary.fwEndDate??>
		var _fwEndDate = "${irisSummary.fwEndDate?string('dd/MM/yyyy')}";
		$j("#fwEndDate").val(_fwEndDate);
	</#if>

	<#if irisSummary.finalReportDate??>
		var _finalReportDate = "${irisSummary.finalReportDate?string('dd/MM/yyyy')}";
		$j("#finalReportDate").val(_finalReportDate);
	</#if>

	<#if irisSummary.summaryCompletionDate??>
		var _summaryCompletionDate = "${irisSummary.summaryCompletionDate?string('dd/MM/yyyy')}";
		$j("#summaryCompletionDate").val(_summaryCompletionDate);
	</#if>

	<#if irisSummary.summaryApprovalDate??>
		var _summaryApprovalDate = "${irisSummary.summaryApprovalDate?string('dd/MM/yyyy')}";
		$j("#summaryApprovalDate").val(_summaryApprovalDate);
	</#if>
   
	function saveAsDraft()
	{
	
		$j("#status").val('0');
		var editIRISSummaryForm = $j("#editIRISSummaryForm");
		editIRISSummaryForm.submit();
		//return true;
	}
	
	function publish()
	{
		//insightsHeading
		//alert("B-->"+$j('#inHeading').val());
		
		//var contenteditable = document.querySelector('[contenteditable]'),
		//text = contenteditable.textContent;
		//alert(text);
	
		var cc = document.getElementsByName("inHeading");
		var insightHeadingArray = [];
		for(var i=0;i<cc.length;i++)
		{
			//alert("cc Value"+cc[i].innerHTML);
			insightHeadingArray.push(cc[i].innerHTML)
		}
		$j("#insightsHeading").val(insightHeadingArray);
	
		$j("#status").val('1');
		//return true;
		
		
		
		var allInsightTagsFilled = true;
		
		for(var j=1; j<=insightTagCounterGlobal; j++)
		{
			var insightHeading = $j('#inHeading_'+j).text();
			var insights = $j('#insights_'+j).val();
			var tags = $j('#tags_'+j).val();
		
			if(insightHeading.trim()!="" && insights.trim()!="" && tags.trim()=="")
			{
				//dialog({title:"Message",html:"Please enter at least one tag corresponding to "+insightHeading});
				
				
				if(allInsightTagsFilled)
				{
					$j('#tags_'+j).focus();
				}
				allInsightTagsFilled = false;
				$j('#tags_Error_'+j).show();
				//return false;
			}
			else
			{
				$j('#tags_Error_'+j).hide()
			}
			
		}
		if(allInsightTagsFilled)
		{
			var editIRISSummaryForm = $j("#editIRISSummaryForm");
			editIRISSummaryForm.submit();
		}
		else
		{
			return false;
		}
	}
	
	
	function cancelSummary()
	{
		var cancelIRISSummary = $j("#cancelIRISSummary");
		cancelIRISSummary.submit();
	}
   
</script>

<script type="text/javascript">
	
	
	$j(document).ready(function(){

// Start script for edit section delete date
		$j('.editDeleteIconAlign').click(function(){
           $j(this).parent().children('input').val('');
		});
// End script for edit section delete date


    
     $j("#incrementRow").on('click', function(){
 
    var cloneInsightTagDiv = '<div id="insightTags_'+insightTagCounterGlobal+'" class="insightAccordionContent"><div class="researchInsightContentWrap"><div class="insightAccordionBox"> <p contenteditable="true" id="inHeading_'+insightTagCounterGlobal+'" name="inHeading">Insight '+insightTagCounterGlobal+'</p> <span><i id="researchInsightEditCaret" class="fa fa-close" onclick="removeInsightTag('+insightTagCounterGlobal+')"></i></span>  </div>	</div><textarea  id="insights_'+insightTagCounterGlobal+'" name="insights"></textarea> <textarea style="display:none;" id="insights_'+insightTagCounterGlobal+'Text" name="insightsText"></textarea><div class="rTable"><div class="rTableRow"><div class="rTableCellLeft"><p>TAG(S)</p></div><div class="rTableCellRight"><input type="text" id="tags_'+insightTagCounterGlobal+'" name="tags" value=""><span class="irisSummaryTagsError" id="tags_Error_'+insightTagCounterGlobal+'" style="display:none">Please enter Tags</span></div></div></div></div><input type="hidden" id="insightTagSeqNo" name="insightTagSeqNo" value="'+insightTagCounterGlobal+'">';

	
	$j("#productTagsDiv").before(cloneInsightTagDiv);								
							
	initiateRTE('insights_'+insightTagCounterGlobal, 10000, true);
	insightTagCounterGlobal = insightTagCounterGlobal + 1;	

  })

	});
	
	function removeInsightTag(insightTagRowCounter)
	{
		
		$j("#insightTags_"+insightTagRowCounter).remove();
	}

</script>
  
  
  

