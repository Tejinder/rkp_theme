<#include "/template/global/include/jive-macros.ftl" />


	<#macro irisdatetimepicker id name value format="" showstime=false useservertime=false readonly=false disablePrevDates=false defaultDateTimePicker=true placeholder='' >
		<input type="text" class="jive-form-textinput-variable j-form-datepicker" id="${id}" placeholder="${placeholder}" name="${name}"  <#if readonly>readonly="true"</#if>/>
		
		<a href="#" id="${id}_button" class="j-form-datepicker-btn">
		<img src="${themePath}/images/synchro/calendar.png" encode='false'" width="19" height="19" border="0" alt="<@s.text name="global.datepicker.tooltip"/>" title="<@s.text name="global.datepicker.tooltip"/>" />
		<script type="text/javascript">
			<!--  to hide script contents from old browsers
			Zapatec.Calendar.setup({
				inputField     :    "${id}",     // id of the input field
				ifFormat       :    "${format}",     // format of the input field
				button         :    "${id}_button",  // What will trigger the popup of the calendar
				showsTime      :     false      //don't show time, only date
			});
			// end hiding contents from old browsers  -->
		</script>
		</a>
		
	</#macro>

	<#macro renderBrandFieldNew name='' id='' value=0>
		<#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
	   
		<input type="text" value=""  name="searchBrand" id="searchBrand"/>
		<div  id="brandPopup">
			<input type="checkbox"  name="brandcheckAll" id="brandcheckAll" onclick="selectallBrands()" >Select All </input> 
		</div>
		<div id="searchbrandPopup">
			<#if (brands?has_content)>
				<#list brands.keySet() as key>
					<#assign brand = brands.get(key)/>
					<div>
						<input type="checkbox" name='brandCheckName' id="${key}" value="${brand}" onClick="checkByBrandFilter()" >${brand}</input> 
					</div>
				</#list>
			</#if>
		</div>
										
</#macro>
	 
	 
	<#macro methodologyrenderNew name='' id='' value=0>
	    <input type="text" value=""  name="searchmethodologies" id="searchmethodologies"/>
		<div  id="methodologyPopup">
			<input type="checkbox"  name="methodologiescheckAll" id="methodologiescheckAll"  onClick="selectallMethodology()">Select All </input>
		</div>
					
		<div id="searchMethodologiesPopup">
	        <#assign methMethGroupMapping = statics['com.grail.synchro.SynchroGlobal'].getMethodologyMapping() />
			<#assign methGroup = statics['com.grail.synchro.SynchroGlobal'].getMethodologyGroups(true, 0) />
			<#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getMethodologies() />
			<#assign methodologyProperties = statics['com.grail.synchro.SynchroGlobal'].getMethodologyProperties() />
			<#assign methMethGroupKeySet = methMethGroupMapping.keySet() />
			<#if (methMethGroupMapping?has_content)>
				<#list methMethGroupKeySet as key>
					<#assign methKeySet = methMethGroupMapping.get(key).keySet() />
					<#list methKeySet as methkey>
						<div>
							<input type="checkbox" name="methodologyCheckName" id="${methkey}" value="${methodologies.get(methkey)}"    onClick="checkByMethodologyFilter()">${methodologies.get(methkey)}</input> 
						</div>
					</#list>
				</#list>
			</#if>
		</div>
    </#macro>
	
	
	<#macro categoryrenderNew name='' id='' value=0>
	    <#assign categoryTypes = statics['com.grail.synchro.SynchroGlobal'].getProductTypes() />
	    <input type="text" value=""  name="searchcategory" id="searchcategory"/>
		<div  id="categoryPopup">
			<input type="checkbox"  name="categorycheckAll" id="categorycheckAll"  onClick="selectallCategory()">	Select All </input>
		</div>
		<div id="searchCategoryPopup">
			<#assign categoryTypeKeySet = categoryTypes.keySet() />
			<#if (categoryTypes?has_content)>
				<#list categoryTypeKeySet as key>
					<#assign categoryType = categoryTypes.get(key) />
					<div>
						<input type="checkbox" name="categoryCheckName" value='${categoryType}' id='${key}'  onClick="checkByCategoryFilter()">${categoryType} </input> 
					</div>
				</#list>
			</#if>
		</div>		
	</#macro>
	
	<#macro endMarketrenderNew name='' id='' value=0>
		<#assign endMarketRegions = statics['com.grail.synchro.SynchroGlobal'].getRegionEndMarketsMapping() />
	
		<input type="text" value=""  name="searchendMarket" id="searchendMarket"/>
		<div id="endMarketPopup">
			<input type="checkbox"  name="endMarketcheckAll" id="endMarketcheckAll" onClick="selectallEndmarket()">	Select All </input>
		</div>
		
		<div id="searchendMarketPopup">
			<#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
			<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
			<#assign endMarketRegionsKeySet = endMarketRegions.keySet() />
			<#if (endMarketRegions?has_content)>
				<#list endMarketRegionsKeySet as key>
					<#assign region = endMarketRegions.get(key) />
					<#assign endMarketKeySet = endMarketRegions.get(key).keySet() />
					<#list endMarketKeySet as endMarketkey>
						<div>
							<input type="checkbox" name="endMarketCheckName"  id='${endMarketkey}' value="${endMarkets.get(endMarketkey)}"   onClick="checkByEndmarketFilter()">${endMarkets.get(endMarketkey)} </input>
						</div>
					 </#list>
				</#list>
			</#if>
		</div>
	</#macro>		

		<#-- Macro for Attachment Upload -->
	<#macro irisSummaryAttachements attachments canAttach=false attachmentCount=0 maxAttachCount=30>
		<#if (attachments?? && (attachments?size>0)) || (maxAttachCount > 0) >
			
		<div id="jive-add-attachment" class="clearfix">
			

			<!-- This is where the multi file output will appear -->

			<div id="waiver-file-list" class="jive-attachments">
				<#assign hasAttachments = false />
				<#list attachments as attachment>
					<#assign hasAttachments = true />
					<div id="jive-attachment-${attachment.attachmentId?c}" class="jive-attach-item">
					    <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.irisSummaryId?c}-${attachment.attachmentId?c}/${attachment.fileName?url}" />">
					      <span>${attachment.fileName?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.fileSize)})</span>
						</a>
						<#if (canAttach)>
							<a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="multi_selector.removeAttachment('jive-attachment-${attachment.attachmentId?c}', ${attachment.attachmentId?c});return false;"><@s.text name="global.remove" /></a>
						</#if>
					</div>
				</#list>
				<#if !hasAttachments>
					<span style="font-style: italic;">No Attachments Found</span>
				</#if>

			</div>

			<#if (canAttach)>
				<a class="j-attachment-button j-btn-global">
					<span class="j-button-text">Browse</span>
					<label for="attachFile" class="j-508-label"><@s.text name="global.attachment" /><@s.text name="global.colon" /></label>
					
					<input type="file" id="attachFile" />
				</a>
			</#if>
		</div>
		</#if>

		<#if canAttach>
		<script language="JavaScript" type="text/javascript">

			<!-- Create an instance of the multiSelector class, pass it the output target and the max number of files -->
				<#assign globalRemove><@s.text name="global.remove" /></#assign>
			var multi_selector = new MultiSelector(document.getElementById('waiver-file-list'), ${maxAttachCount?c}, ${attachmentCount?c}, '${globalRemove?js_string}');
			<!-- Pass in the file element -->
			multi_selector.addElement(document.getElementById('attachFile'));
				<#if (attachmentCount == 0)>
				jQuery('#waiver-file-list').html('');
				<#else>
				jQuery('#waiver-file-list').show();
				</#if>

			// loop though any files in the remove
		</script>

		</#if>

	</#macro>
								
	
	

