<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#-- DWR def -->

<#include "/template/global/include/iris-macros.ftl" />
<script src="${themePath}/js/iris/irisUtils.js" type="text/javascript"></script>  
<!-- this plugin for search  in Filters for fres-->






 <script type="text/javascript">
   
   

   var  advanceSearchpopupInitialization=   {modal: true, height: 590, width: 1005 };
   var FilterspopupInitialization=  {modal: true, height:200, width:250 };
   
       
   
		var showpopupWithinEndmarket=false;
        var showpopupWithinCategory=false;
   
		var showpopupWithinMethodology=false;
		var showpopupWithin=false;
		var showpopupWithinBrands=false;
		var checkCheckedField=false;
		var search_filtersFlag=false;
		var datavaluesForSearchWithin=new Array();
		var datavaluesIdsForSearchWithin=new Array();
		var datavaluesForBrands=new Array();
		var datavaluesIdsForBrands=new Array();
		var datavaluesForCategory=new Array();
		var datavaluesIdsForCategory=new Array();
		
		var datavaluesForMethodology=new Array();
		var datavaluesIdsForMethodology=new Array();
		
		var datavaluesForEndmarket=new Array();
		var datavaluesIdsForEndmarket=new Array();
		

		var  preseverdatastatusCheck=false;
		var  preserevedatastatusForCheckWithIn=false;

			
        $j(document).ready(function () {

			
            $j("#OpenDialogx").click(function () {
				
						
						
                //$j("#AdvancedSearchPopup").dialog(advanceSearchpopupInitialization).dialog("open");

				$j("#AdvancedSearchPopup").css('display','block');
				  
				
						$j("#finalValuesOfSearchWithin").hide();
			 
            });
			
			
			// $j("#search_within").click(function () {
			// 	showpopupWithin=true;	
				 
   //              $j("#search_withinPopup").dialog(FilterspopupInitialization).dialog("open");
				
			// });
			
			
			// $j("#search_withinPopup").click(function()
			//    {
			// 	   showpopupWithin=true;
			    
		 //       });
			   
			   
			
			  //  search by filters...
	// 		   $j("#search_filters").click(function () 
	// 			{
	// 				if($j("#resultantDivForFilters").is(":visible"))
	// 				{
	// 					  removeAppendedValues();
	// 					  $j("#resultantDivForFilters").hide();
						
	// 				}
					
	// 				 if($j("#searchFiltersDiv").is(":visible"))
	// 				{
 // var branddata=false;
	// 					  var methodologydata=false;
	// 					  var categorydata=false;
	// 					  var endMarketdata=false;
	// 					if(datavaluesForBrands.length>0)
	// 						{
	// 							branddata=true;
							 
	// 						}
						 
							
	// 					 if(datavaluesForMethodology.length>0)
	// 						{
	// 							methodologydata=true;
							 
	// 						}
	// 					  if(datavaluesForCategory.length>0)
	// 					    {
	// 							categorydata=true;
							 
	// 						}
							
	// 						if(datavaluesForEndmarket.length>0)
	// 					    {
	// 							endMarketdata=true;
							 
	// 						}
							
							
	// 					   if(branddata==false &&  methodologydata==false && categorydata==false &&endMarketdata==false)
	// 						         $j("#searchFiltersDiv").hide();
	// 							else
	// 							  showResultantPopup();									
							
	// 				}
	// 				else
	// 				{
	// 					$j("#searchFiltersDiv").show();	 
	// 				}
	// 			});
        
	// 		$j("#endmarketDiv").click(function () 
	// 		{
	// 			//$j("#endmarketDivPopup").show();
	// 			showpopupWithinEndmarket=true;
	// 			$j("#endmarketDivPopup").dialog(FilterspopupInitialization).dialog("open");
	// 		});
				
	// 			// when click on select all of Endmarket pop up checkboxes
	// 			$j("#endMarketPopup").click(function () 
	// 				{
	// 					showpopupWithinEndmarket=true;
	// 				});
				
	// 			 // when click on select single of endMarket pop up checkboxe
	// 			$j("#searchendMarketPopup").click(function () 
	// 			{ 
	// 				  showpopupWithinEndmarket=true;
	// 			});	
				
	// 			 //click on endmarket search box
	// 			$j("#searchendMarket").click(function () 
	// 			{      
	// 				 showpopupWithinEndmarket=true;
	// 			});
				
	// 		// when click on category pop up
	// 		$j("#categoryDiv").click(function ()  //ok
	// 			{
					
	// 				showpopupWithinCategory=true;
	// 				//$j("#endmarketDivPopup").show();
	// 				$j("#categoryDivPopup").dialog(FilterspopupInitialization).dialog("open");
					
	// 			});	
				
	// 			// when click on select all of category pop up checkboxes
					
	// 			$j("#categoryPopup").click(function () // ok
	// 				{
	// 					showpopupWithinCategory=true;
	// 				});	
					
	// 		    // when click on select single of category pop up checkboxe
	// 			$j("#searchCategoryPopup").click(function () // ok
	// 			{ 
	// 				  showpopupWithinCategory=true;
	// 			});	
					
	// 			 //click on brand search box
	// 			$j("#searchcategory").click(function () 
	// 			{      
	// 				 showpopupWithinCategory=true;
	// 			});
				
				
				
	// 			 // when click on methodology pop up
	// 			$j("#methodlogyDiv").click(function ()  // OK
	// 				{
	// 						showpopupWithinMethodology=true;
	// 						//$j("#endmarketDivPopup").show();
	// 						$j("#methodologyDivPopup").dialog(FilterspopupInitialization).dialog("open");
					
	// 				});	
					
	// 				// when click on select all of methodology pop up checkboxes
					
	// 			$j("#methodologyPopup").click(function () // OK
	// 				{
	// 					showpopupWithinMethodology=true;
	// 				});	
				
				
	// 			// when click on select single of methodology pop up checkboxe
	// 			$j("#searchMethodologiesPopup").click(function () 
	// 			{ 
	// 				  showpopupWithinMethodology=true;
	// 			});
				
	// 			 //click on brand search box
	// 			$j("#searchmethodologies").click(function () // Ok
	// 			{      
	// 				  showpopupWithinMethodology=true;
	// 			});
					
				
	// 		 // when click on brand pop up
	// 		$j("#brandDiv").click(function () 
	// 		{
	// 			showpopupWithinBrands=true;
	// 			$j("#brandDivPopup").dialog(FilterspopupInitialization).dialog("open");
	// 		});	
				
	// 		// when click on select all of brand pop up checkboxes
	// 		$j("#brandPopup").click(function () 
	// 		{
	// 			showpopupWithinBrands=true;
	// 			$j("#brandDivPopup").dialog(FilterspopupInitialization).dialog("open");
	// 		});	
				
 //            // when click on select single of brand pop up checkboxe
	// 		$j("#searchbrandPopup").click(function () 
	// 		{     
	// 			showpopupWithinBrands=true;
	// 		});
				
	// 		//click on brand search box
	// 		$j("#searchBrand").click(function () 
	// 		{      
	// 			showpopupWithinBrands=true;
	// 		});
	


		});
		
		
		
    </script>
   


  

<div class="searchBgImg">

	<div class="searchBarContainer">



		 <div class="searchBarLogo"></div>
			<form method="POST" name="searchIRISSummaryForm" id="searchIRISSummaryForm" action="/iris-summary/search-results-advance!execute.jspa">
			   
			     <input type="Search" name="searchText" id="searchText" placeholder="Enter Search String" onclick="return showWarning();" onfocus="this.placeholder = ''" onblur="this.placeholder ='Enter Search String' " autocomplete="off" />
				<a class="searchBarSearchText" onclick="return advanceSearch();"><span>SEARCH</span> <i class="fa fa-search"></i></a>
				<!--	<span class="searchBarInfoIcon"></span> -->
				
				
				<!--<button class="j-btn-callout btnSearch-align btn-mrgn-srch" onclick="downloadScores();">Download Scores</button>-->
				 
				<input  type="hidden" name="ALL_OF_THESE_WORDS_HIDDEN"  id="ALL_OF_THESE_WORDS_HIDDEN" value=""/> 
				<input type="hidden" id="searchWithinFilterValues" name="searchWithinFilterValues" value="">
				<input type="hidden" id="searchByBrandFilterValues" name="searchByBrandFilterValues" value="">
				<input type="hidden" id="searchByCategoryFilterValues" name="searchByCategoryFilterValues" value="">
				<input type="hidden" id="searchByMethodologyFilterValues" name="searchByMethodologyFilterValues" value="">
				<input type="hidden" id="searchByEndMarketFilterValues" name="searchByEndMarketFilterValues" value="">
				
				<input type="hidden" name="searchByReportDateFilterValues" id="searchByReportDateFilterValues" value="">
				<input type="hidden" name="searchByReportDateFilterCustomStartDate" id="searchByReportDateFilterCustomStartDate" value="">
				<input type="hidden" name="searchByReportDateFilterCustomEndDate" id="searchByReportDateFilterCustomEndDate" value="">
				
				<input type="hidden" name="allOfTheseWords" id="allOfTheseWords" value="">
				
				<input type="hidden" name="noneOfTheseWords" id="noneOfTheseWords" value="">
					
				<input type="hidden" name="downloadScore" id="downloadScore" value="">
			</form> 
			
			

			<div class="bottomBtnWrap">

				<p class="advanceErrorMsg" id="advanceSearchErrorMessage" style="visibility:hidden"  onclick='showWarning();'>Please be careful while editing the search string. We recommend to use Boolean box to make strings</p>

				
				    <div  class="advanceBtnFixBox">


	                         <div class="search-in-style">
			    				<ul>	
				                     <li>IRIS Summary Sections</li>
				                     <li id="searchWithinSections"></li>
			    				</ul>
	    			         </div>
                                  

                            <div style="margin: 0 auto;width: 409px;">
									<div data-popup-searchwithin="Popup-SearchWithin" class="bottomBtnWrapAlign">
									   <p class="hoverCls">SEARCH WITHIN</p>
									</div>

									<div data-popup-boolean-search="Popup-booleanSearch" class="bottomBtnWrapAlign" id="OpenDialogx">
										<p class="hoverCls">BOOLEAN SEARCH</p>
									</div>
								
									<div class="bottomBtnWrapAlign open-filter-section">
										<p class="hoverCls txtSpace">APPLY FILTERS</p>
									</div>
							</div>


        <div  style="margin-top: -33px;" class="advanceSearchFilterContainer" id="hideit">
        	<div class="chooseFilterHead">Choose Filter</div>
             <!--  <a href="#">X</a> -->
			<ul>		
				<li data-popup-advance-search-brand="Popup-AdvanceSearchBrand" class="freezeColor advance-filter-subhead-brand" id="advance-search-brand">Brand <i class="error"></i> </li>	
                  	<li id="selected-advance-search-brands"></li>                                    
				<li data-popup-advance-search-methodology="Popup-AdvanceSearchMethodology" class="freezeColor advance-filter-subhead-methodology" id="advance-search-methodology">Methodology <i class="error"></i> </li>
				    <li id="selected-advance-search-methodology"></li> 
				<li data-popup-advance-search-end-market="Popup-AdvanceSearchEndMarket" class="freezeColor advance-filter-subhead" id="advance-search-end-market">End Market <i class="error"></i> </li>
				    <li id="selected-advance-search-end-markets"></li> 
				<li data-popup-advance-search-category="Popup-AdvanceSearchCategory" class="freezeColor advance-filter-subheadcategory" id="advance-search-category">Category <i class="error"></i> </li>
				    <li id="selected-advance-search-category"></li> 
				<li data-popup-advance-search-report-date="Popup-AdvanceSearchReportDate" class="freezeColor advance-filter-subhead-report-date" id="advance-search-report-date">Report Date Range <i class="error"></i> </li>
				    <li id="selected-advance-search-report-date"></li>
				    <li style="display: none;" id="selected-advance-search-report-date-to"></li>
			</ul>
        </div>  



                            	<!-- Start Applied filter page -->
									<!--     <div style="margin-top: -33px;" class="advance-search-filter-container">
									        <p class="advance-search-filter-head">Applied Filters</p>


											<div class="advanceAppliedFilterCheckboxWrap">
												<div>
													 <p class="advance-filter-subhead">ENDMARKET(S)<i class="error"></i></p>
													<div id="selected-advance-search-end-markets"> </div>
													<div class="clearFix lineDivider"></div>
												</div>
												<div>
													 <p class="advance-filter-subhead-brand">BRAND(S)<i class="error"></i></p>
													<div id="selected-advance-search-brands"> </div>
													   <div class="clearFix lineDivider"></div>
												</div>
												<div>
													 <p class="advance-filter-subhead-methodology">METHODOLOGY(S)<i class="error"></i></p>
													<div id="selected-advance-search-methodology"> </div>
													   <div class="clearFix lineDivider"></div>
												</div>
												<div>
													 <p class="advance-filter-subheadcategory">CATEGORY(S)<i class="error"></i></p>
													<div id="selected-advance-search-category"> </div>
													   <div class="clearFix lineDivider"></div>
												</div>
												<div>
													 <p class="advance-filter-subhead-report-date pt10">REPORT DATE RANGE<i class="error"></i></p>
													<div id="selected-advance-search-report-date"> </div>
													<div style="display: none;" id="selected-advance-search-report-date-to"> </div>
												</div>
											</div>
									    </div>
									    <div class="clearFix"></div> -->
				            <!-- End Applied filter page -->






				    </div>
				
				
				
				

				
			</div>


	 </div>
</div>


<!-- Start Advance Search Brand Filter Pop-up-->

<div class="advanceSearchBrandContainer">

	<div class="popupAdvanceSearch" advance-search-brand="Popup-AdvanceSearchBrand" id="advance-search-brand-popup">

  <!-- Below div is added to set the Pop-up position on Advance search page -->
    <div class="setPopupPosition"> 

        <div class="popup-inner">
            <div class="checkbox-popup-wrapper">
                <div class="search-field">
                    <input type='text' id='txtList' class='txtListOnPopup' onkeyup="filter(this)" placeholder="Search Brand" />
                    <a class="popup-close" data-popup-close="Popup-AdvanceSearchBrand" href="#"> <img class="popupCrossBtn" src="${themePath}/images/iris/cross-icon.png"> </a>
                </div>
                <div class="advance-search-brand-popup">                
                    <div class="select-all-section">
                        <div id="hideselectall">
                            <label class="checkboxContainer">Select All
                                <input type="checkbox" id="advanceSearchBrandSelectAll" value="" name="advanceSearchBrandSelectAll">
                                <span class="checkmark"></span>
                            </label>
                         </div>
                           <!-- <input type="checkbox" id="ckbCheckAll" value="" name="demo" />Select all</div> -->
                    </div>
                    <div class="checkboxes-list-dd">
                        <ul id="checkBoxes" class="fromList">
							<#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
							<#if (brands?has_content)>
								
								<li>
									<label class="checkboxContainer">${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getDescription()}
									<input type="checkbox" class="advanceSearchBrandCheckBoxClass" value="${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getDescription()}" brandid="${statics['com.grail.util.BATConstants'].MULTI_BRAND_DB_VALUE}" id="${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getDescription()}" >
									<span class="checkmark"></span>
									</label>
								</li>
								
								<li>
									<label class="checkboxContainer">${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getDescription()}
									<input type="checkbox" class="advanceSearchBrandCheckBoxClass" value="${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getDescription()}" brandid="${statics['com.grail.util.BATConstants'].NON_BRAND_DB_VALUE}" id="${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getDescription()}" >
									<span class="checkmark"></span>
									</label>
								</li>
								
								<#list brands.keySet() as key>
									<#assign brand = brands.get(key)/>
									<#if key == statics['com.grail.util.BATConstants'].MULTI_BRAND_DB_VALUE || key == statics['com.grail.util.BATConstants'].NON_BRAND_DB_VALUE >
									<#else>
										<li>
											<label class="checkboxContainer">${brand}
											<input type="checkbox" class="advanceSearchBrandCheckBoxClass" value="${brand}" brandid="${key}" id="${brand}" >
											<span class="checkmark"></span>
											</label>
										</li>
									</#if>	
								</#list>
							</#if>	
                        </ul>
                    </div>
                </div>
            </div>
        </div>

</div>



    </div>
</div>

    <!-- End Advance Search Filter Brand  Pop-up-->

<!-- Start Advance Search Methodology Filter Pop-up-->

<div class="advanceSearchMethodologyContainer">

	<div class="popupAdvanceSearch" advance-search-brand="Popup-AdvanceSearchMethodology" id="advance-search-methodology-popup">


<!-- Below div is added to set the Pop-up position on Advance search page -->
    <div class="setPopupPosition"> 

        <div class="popup-inner">
            <div class="checkbox-popup-wrapper">
                <div class="search-field">
                    <input type='text' id='txtList' class='txtListOnPopup' onkeyup="filter(this)" placeholder="Search Methodology" />
                    <a class="popup-close" data-popup-close="Popup-AdvanceSearchMethodology" href="#"><img class="popupCrossBtn" src="${themePath}/images/iris/cross-icon.png"></a>
                </div>
                <div class="advance-search-methodology-popup">                
                    <div class="select-all-section">
                        <div id="hideselectall">
                            <label class="checkboxContainer">Select All
                                <input type="checkbox" id="advanceSearchMethodologySelectAll" value="" name="advanceSearchMethodologySelectAll">
                                <span class="checkmark"></span>
                            </label>
                         </div>
                           <!-- <input type="checkbox" id="ckbCheckAll" value="" name="demo" />Select all</div> -->
                    </div>
                    <div class="checkboxes-list-dd">
                        <ul id="checkBoxes" class="fromList">
							
							<#assign methMethGroupMapping = statics['com.grail.synchro.SynchroGlobal'].getMethodologyMapping() />
							<#assign methGroup = statics['com.grail.synchro.SynchroGlobal'].getMethodologyGroups(true, 0) />
							<#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getMethodologies() />
							<#assign methodologyProperties = statics['com.grail.synchro.SynchroGlobal'].getMethodologyProperties() />
							<#assign methMethGroupKeySet = methMethGroupMapping.keySet() />
							<#if (methMethGroupMapping?has_content)>
								<#list methMethGroupKeySet as key>
										
									<#assign methKeySet = methMethGroupMapping.get(key).keySet() />
									<#list methKeySet as methkey>
										
										
										<li>
											<label class="checkboxContainer">${methodologies.get(methkey)}
											<input type="checkbox" class="advanceSearchMethodologyCheckBoxClass" value="${methodologies.get(methkey)}" methodologyid="${methkey}" id="${methodologies.get(methkey)}" >
											<span class="checkmark"></span>
											</label>
										</li>
									
									</#list>
										
								</#list>
							</#if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

</div>

    </div>
</div>

    <!-- End Advance Search Filter Methodology  Pop-up-->
	
<!-- Start Advance Search Category Filter Pop-up-->

<div class="advanceSearchCategoryContainer">

	<div class="popupAdvanceSearch" advance-search-brand="Popup-AdvanceSearchCategory" id="advance-search-category-popup">


<!-- Below div is added to set the Pop-up position on Advance search page -->
    <div class="setPopupPosition"> 

        <div class="popup-inner">
            <div class="checkbox-popup-wrapper">
                <div class="search-field">
                    <input type='text' id='txtList' class='txtListOnPopup' onkeyup="filter(this)" placeholder="Search Category" />
                    <a class="popup-close" data-popup-close="Popup-AdvanceSearchCategory" href="#"><img class="popupCrossBtn" src="${themePath}/images/iris/cross-icon.png"></a>
                </div>
                <div class="advance-search-category-popup">                
                    <div class="select-all-section">
                        <div id="hideselectall">
                            <label class="checkboxContainer">Select All
                                <input type="checkbox" id="advanceSearchCategorySelectAll" value="" name="advanceSearchCategorySelectAll">
                                <span class="checkmark"></span>
                            </label>
                         </div>
                           <!-- <input type="checkbox" id="ckbCheckAll" value="" name="demo" />Select all</div> -->
                    </div>
                    <div class="checkboxes-list-dd">
                        <ul id="checkBoxes" class="fromList">							
							<#assign categoryTypes = statics['com.grail.synchro.SynchroGlobal'].getProductTypes() />
							<#assign categoryTypeKeySet = categoryTypes.keySet() />
							<#if (categoryTypes?has_content)>
								<#list categoryTypeKeySet as key>
									<#assign categoryType = categoryTypes.get(key) />
									<li>
										<label class="checkboxContainer">${categoryType}
										<input type="checkbox" class="advanceSearchCategoryCheckBoxClass" value="${categoryType}" categoryid="${key}" id="${categoryType}" >
										<span class="checkmark"></span>
										</label>
									</li>
									 
								</#list>
							</#if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

</div>



    </div>
</div>

    <!-- End Advance Search Filter Category  Pop-up-->



<!-- Start Advance Search End Market Filter Pop-up-->

<div class="advanceSearchEndMarketContainer">

	<div class="popupAdvanceSearch" advance-search-end-market="Popup-AdvanceSearchEndMarket" id="advance-search-end-market-popup">


<!-- Below div is added to set the Pop-up position on Advance search page -->
    <div class="setPopupPosition"> 

        <div class="popup-inner">
            <div class="checkbox-popup-wrapper">
                <div class="search-field">
                    <input type='text' id='txtList' class='txtListOnPopup' onkeyup="filter(this)" placeholder="Search End Market" />
                    <a class="popup-close" data-popup-close="Popup-AdvanceSearchEndMarket" href="#"><img class="popupCrossBtn" src="${themePath}/images/iris/cross-icon.png"></a>
                </div>
                <div class="advance-search-end-market-popup search-result-end-market-popup">                
                    <div class="select-all-section">
                        <div id="hideselectall">
                            <label class="checkboxContainer">Select All
                                <input type="checkbox" id="advanceSearchEndMarketSelectAll" value="" name="advanceSearchEndMarketSelectAll">
                                <span class="checkmark"></span>
                            </label>
                         </div>
                           <!-- <input type="checkbox" id="ckbCheckAll" value="" name="demo" />Select all</div> -->
                    </div>
                    <div class="checkboxes-list-dd">
                        <ul id="checkBoxes" class="fromList">
						<#assign endMarketRegions = statics['com.grail.synchro.SynchroGlobal'].getRegionEndMarketsMapping() />
							
							<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
							<#assign endMarketRegionsKeySet = endMarketRegions.keySet() />
							<#if (endMarketRegions?has_content)>
								<#list endMarketRegionsKeySet as key>
									<#assign region = statics['com.grail.synchro.SynchroGlobal'].getRegions().get(key) />
									<#if region=="Global">
									<#else>
										 <li>
										<label class="popUpLabel">${region}</label>
										<ul>
										<#assign endMarketKeySet = endMarketRegions.get(key).keySet() />
										<#list endMarketKeySet as endMarketkey>
											
											<li>
												<label class="checkboxContainer">${endMarkets.get(endMarketkey)}
												<input type="checkbox" class="advanceSearchEndMarketCheckBoxClass" value="${endMarkets.get(endMarketkey)}" endmarketid="${endMarketkey}"  id="${endMarkets.get(endMarketkey)}" >
												<span class="checkmark"></span>
												</label>
											</li>
										 </#list>
										  </ul>
					 </li>
									</#if>	 
								</#list>
							</#if>                         
                        </ul>
                    </div>
                </div>
            </div>
        </div>

</div>


    </div>
</div>

 <!-- End Applied Filter End Market  Pop-up-->
 
 <!-- Start Advance Search Report Date Filter Pop-up -->
<div class="advanceSearchReportDateContainer">
<div class="popupAdvanceSearch" advance-search-report-date="Popup-AdvanceSearchReportDate" id="advance-search-report-date-popup">


    <!-- Below div is added to set the Pop-up position on Advance search page -->
    <div class="setPopupPosition"> 


        <div class="reportDatePopupInner">
            <div class="report-popup-wrapper">
                <div class="mainHeadBox">
                  <p>Report Date Range</p>
                   <a id="searchResultClosePopupIfCustomSelect" class="popup-close" advance-search-report-date-popup-close="Popup-AdvanceSearchReportDate" href="#"><img class="popupCrossBtn" src="${themePath}/images/iris/cross-icon.png"></a>
                </div>

                 <div class="advance-search-report-date-popup">                     
                    <div class="radio-list-dd">
                      <form>
                      <ul>
                        <li>
                            <label class="radioBtncontainer">Last 3 months
                                <input type="radio" name="reportDateFilter" value="Last 3 months" class="dateRange">
                                <span class="radiocheckmark"></span>
                           </label>
                        </li>
                         <li>
                            <label class="radioBtncontainer">Last 6 months
                                <input type="radio" name="reportDateFilter" value="Last 6 months" class="dateRange">
                                <span class="radiocheckmark"></span>
                           </label>
                        </li>
                         <li>
                            <label class="radioBtncontainer">Last 12 months
                                <input type="radio" name="reportDateFilter" value="Last 12 months" class="dateRange">
                                <span class="radiocheckmark"></span>
                           </label>
                        </li>
						<li>
                            <label class="radioBtncontainer">Last 2 years
                                <input type="radio" name="reportDateFilter" value="Last 2 years" class="dateRange">
                                <span class="radiocheckmark"></span>
                           </label>
                        </li>
                         <li>
                            <label class="radioBtncontainer">Last 3 years
                                <input type="radio" name="reportDateFilter" value="Last 3 years" class="dateRange">
                                <span class="radiocheckmark"></span>
                           </label>
                        </li>
                         <li>
                            <label class="radioBtncontainer">Last 4 years
                                <input type="radio" name="reportDateFilter" value="Last 4 years" class="dateRange">
                                <span class="radiocheckmark"></span>
                           </label>
                        </li>
                        <li>
                            <label  class="radioBtncontainer">Custom
                                <input type="radio" name="reportDateFilter" value="Custom" class="dateRange">
                                <span class="radiocheckmark"></span>
                           </label>
                        </li>
                      </ul>

                      <div class="calenderBoxWrap enableDisableDateField">
                        <input type="text" name="customReportStartDate" placeholder="From" id="customReportStartDate" readonly="true">
                        <a href="#" id="customReportStartDate_button" class="j-form-datepicker-btn">
                            <img src="/themes/rkp_theme/images/synchro/calendar.png" encode="false"  width="19" height="19" border="0" alt="Click to select a date" title="Click to select a date">
                            <script type="text/javascript">
                              <!--  to hide script contents from old browsers
                              Zapatec.Calendar.setup({
                                inputField     :    "customReportStartDate",     // id of the input field
                                ifFormat       :    "%d/%m/%Y",     // format of the input field
                                button         :    "customReportStartDate_button",  // What will trigger the popup of the calendar
                                showsTime      :     false      //don't show time, only date
                              });
                              // end hiding contents from old browsers  -->
                            </script>
                            </a>
                            <!--  <span class="jive-error-message" style="display:none">Please select from Date</span> -->
                      </div>

                      <div class="calenderBoxWrapTo enableDisableDateField">
                        <input type="text" name="customReportEndDate" placeholder="To" id="customReportEndDate"  readonly="true">
                        <a href="#" id="customReportEndDate_button" class="j-form-datepicker-btn">
                            <img src="/themes/rkp_theme/images/synchro/calendar.png" encode="false" width="19" height="19" border="0" alt="Click to select a date" title="Click to select a date">
                            <script type="text/javascript">
                              <!--  to hide script contents from old browsers
                              Zapatec.Calendar.setup({
                                inputField     :    "customReportEndDate",     // id of the input field
                                ifFormat       :    "%d/%m/%Y",     // format of the input field
                                button         :    "customReportEndDate_button",  // What will trigger the popup of the calendar
                                showsTime      :     false      //don't show time, only date
                              });
                              // end hiding contents from old browsers  -->
                            </script>
                            </a>
                             <!-- <span class="jive-error-message" style="display:none">Please select To Date</span> -->
                      </div>


                     </form>
                    </div>
                </div>
            </div>
        </div>

</div>



    </div>
    </div>
    <!-- End Advance Search Report Date Filter Pop-up -->
	
 
 


<!-- Start Search Within Filter  Pop-up-->
<div class="searchWithin-container">

 <div class="popup" search-within="Popup-SearchWithin">


 <!-- Below div is added to set the Pop-up position on Advance search page -->
    <div class="setPopupPosition"> 

        <div  class="advanceSearch-withinpopup-inner">
            <div class="checkbox-popup-wrapper">
                <div class="search-field">
                    <input type='text' id='txtList' class='txtListOnPopup' onkeyup="filter(this)" placeholder="Search Within" />
                    <a class="popup-close" advance-search-search-within-popup-close="Popup-SearchWithin" href="#"><img class="popupCrossBtn" src="${themePath}/images/iris/cross-icon.png"></a>
                </div>
                <div class="search-within-popup-advance-search">                
                    <div class="select-all-section">
                        <div id="hideselectall">
                            <label class="checkboxContainer">Select All
                                <input type="checkbox" id="searchWithinSelectAll" value="" name="searchWithinSelectAll">
                                <span class="checkmark"></span>
                            </label>
                         </div>
                           <!-- <input type="checkbox" id="ckbCheckAll" value="" name="demo" />Select all</div> -->
                    </div>
                    <div class="checkboxes-list-dd">
                        <ul id="checkBoxes" class="fromList">
							
							<#assign indexFields = statics['com.grail.util.BATUtils'].getAllIRISSummaryIndexFieldNamesSearchWithin() />
							<#if (indexFields?? && indexFields?has_content)>
								<#list indexFields.keySet() as key>
								<#--	<#if statics['com.grail.util.BATUtils'].getAllIRISSummaryIndexFieldWeights().get(key) gt 0> -->
										<li>
											<label class="checkboxContainer">${statics['com.grail.util.BATConstants$IRISSummaryIndexFieldName'].getByCode('${indexFields.get(key)}').getDescription()}
											<input type="checkbox" class="advancesearchWithinCheckBoxClass" value="${statics['com.grail.util.BATConstants$IRISSummaryIndexFieldName'].getByCode('${indexFields.get(key)}').getDescription()}"  searchwithinid="${key}" id="${statics['com.grail.util.BATConstants$IRISSummaryIndexFieldName'].getByCode('${indexFields.get(key)}').getDescription()}" >
											<span class="checkmark"></span>
											</label>
										</li>
										
								<#--	</#if>	 -->
								</#list>
							</#if>
							
							                   
                        </ul>
                    </div>
                </div>
            </div>
        </div>

</div>


    </div>
</div>

    <!-- End Search Within Filter -->

<div id="AdvancedSearchPopup" class="homePopupWrapper">
        

      <div class="popup" boolean-search="Popup-booleanSearch">

       <div  class="advanceSearch-booleanSearch-inner">

	<a href="#" class="booleanCrossBtn" data-popup-close="Popup-booleanSearch"><img class="popupCrossBtn" src="/themes/rkp_theme/images/iris/cross-icon-new.jpg"></a>
            <div class="innerhomePopWrapper">
            
                  <!--   <input class="homePopupTextField" type="text" name="advanceSearchMainInputbox" id="advanceSearchMainInputbox" disabled /> -->

                  <div id="booleanUpperTextBar">
                  	
                  	 <p id="advanceSearchMainInputbox"></p>

                  </div>
				<p>Type multiple words in a field separated by comma</p>
                <div class="mT23">
                    <div class="contain30Percent">
                        <p>ALL OF THESE WORDS/PHRASES</p>
                        <p>ANY OF THESE WORDS/PHRASES</p>
                        <p>ANY OF THESE EXACT PHRASES</p>
                        <p>NONE OF THESE WORDS/PHRASES</p>
                    </div>
                    <div class="contain70Percent">
                        <div class="innerFieldWrapPopup">
                            <div class="popupInnerContentInput">
                                <input class="outClick" type="text" name="ALL_OF_THESE_WORDS"  id="ALL_OF_THESE_WORDS"/>
								
                            </div>
                            <div class="popupInnerContentText">
                                 <p>Type all the important words/phrases, all of which needs to be searched</p>
                            </div>
                            <div class="cf"></div>
                        </div>
                        <div class="innerFieldWrapPopup">
                            <div class="popupInnerContentInput">
                                <input class="outClick" type="text" name="ANY_OF_THESE_WORDS" id="ANY_OF_THESE_WORDS" />
                            </div>
                            <div class="popupInnerContentText">
                                <p>Type all the words/phrases, any of which needs to be searched</p>
                            </div>
                            <div class="cf"></div>
                        </div>
                        <div class="innerFieldWrapPopup">
                            <div class="popupInnerContentInput">
                                <input class="outClick" type="text" name="THE_EXACT_PHARSE" id="THE_EXACT_PHARSE"/>
                            </div>
                            <div class="popupInnerContentText">
                                <p>Type the exact string of words/phrases that needs to be searched as a whole, such as ‘Pall Mall’</p>
                            </div>
                            <div class="cf"></div>
                        </div>
                        <div class="innerFieldWrapPopup">
                            <div class="popupInnerContentInput">
                                <input class="outClick" type="text" name="NONE_OF_THESE_WORDS" id="NONE_OF_THESE_WORDS"/>
                            </div>
                            <div class="popupInnerContentText">
                                <p class="removeSpace">Type all the words/phrases which must not be included in the search results</p>
                            </div>
                            <div class="cf"></div>
                        </div>
                    </div>
                    <div class="cf"></div>
                    <div class="booleanSearchBtnWrap">

                    	<a href="#" id="booleanOKButton" class="outClick">OK</a>
                    	<a href="#" id="booleanClearAllButton" class="outClick">CLEAR ALL</a>
                       <!-- <input type="button" id="booleanOKButton" value="OK">
					   <input type="button" id="booleanClearAllButton" value="CLEAR ALL"> -->
					</div>
                </div>
            </div>

        </div>

    </div>

        
    </div>
	
	
	<div id="search_withinPopup" style="display:none">
		<input type="checkbox" name="allCheck" onClick="selectallMe()">Select All</input>
		<hr>
		<#assign indexFields = statics['com.grail.util.BATUtils'].getAllIRISSummaryIndexFieldNames() />
		<#if (indexFields?? && indexFields?has_content)>
			<#list indexFields.keySet() as key>
				<#if statics['com.grail.util.BATUtils'].getAllIRISSummaryIndexFieldWeights().get(key) gt 0>
					<input type="checkbox" name="chkName" onClick="checkByWithinCheckBox()" value='${statics['com.grail.util.BATConstants$IRISSummaryIndexFieldName'].getByCode('${indexFields.get(key)}').getDescription()}' id='${key}'>${statics['com.grail.util.BATConstants$IRISSummaryIndexFieldName'].getByCode('${indexFields.get(key)}').getDescription()}</input><br>
				</#if>	
			</#list>
		</#if>
		
		
 	</div>
 
 
 
<div class="successPopupwrap dialogAdvance">
	<div id="dialogOverlayDataSuccess">
	   <div class="dialogBoxWrap">
	   	 <div class="successDialogWrap">   		
	   		<h5> <b>Please enter keyword for Search</b> </h5>
	      <div>
	   		 <div class="dialogBtnBox">
			   <p class="okBtn">OK</p>	
		     </div>
		  </div>
	   	</div>
	   </div> 
	</div>
</div>
<div class="successPopupwrap dialogAdvance">
	<div id="dialogOverlayDataInfo">
	   <div class="dialogBoxWrap">
	   	 <div class="successDialogWrap">   		
	   		<h5> <b>The search tips are under development.</b> </h5>
	      <div>
	   		 <div class="dialogBtnBox">
			   <p class="okBtn">OK</p>	
		     </div>
		  </div>
	   	</div>
	   </div> 
	</div>
</div>
  
  
   
 
   
   
		
   			   
	<script>
	  
		
		  $j("#ALL_OF_THESE_WORDS").blur(function() {
		  

			//alert($j("#ALL_OF_THESE_WORDS").val());
			forAll_Of_These_Words_New($j("#ALL_OF_THESE_WORDS").val(),$j("#NONE_OF_THESE_WORDS").val(),$j("#ANY_OF_THESE_WORDS").val(),$j("#THE_EXACT_PHARSE").val());
		});
		  
		 
		$j("#NONE_OF_THESE_WORDS").blur(function() {
		  
           //alert($j("#NONE_OF_THESE_WORDS").val());
			for_None_Of_These_Words();
        });
		 
	
		$j("#ANY_OF_THESE_WORDS").blur(function() {
		  
           //alert($j("#NONE_OF_THESE_WORDS").val());
			forAnyOf_These_Words();
        });
		 
		 
		$j("#THE_EXACT_PHARSE").blur(function() {
		  
			//alert($j("#NONE_OF_THESE_WORDS").val());
			for_The_Exact_Phrese();
        });
		 
		 
		$j("#advanceSearchMainInputbox").blur(function() {
			 
			advanceSearchMainInputbox($j("#advanceSearchMainInputbox").val());
			 
		});
		  
		$j("#booleanOKButton").click(function()  {
			//$j("#searchText").val($j("#advanceSearchMainInputbox").val());
			$j("#searchText").val($j("#advanceSearchMainInputbox").text());
			$j('#AdvancedSearchPopup').fadeOut(350);
		}); 
		
		$j("#booleanClearAllButton").click(function()  {
		//	$j("#searchText").val('');
			$j("#advanceSearchMainInputbox").html('');
			$j("#advanceSearchMainInputbox").val('');
			$j("#ALL_OF_THESE_WORDS").val('');
			$j("#ALL_OF_THESE_WORDS_HIDDEN").val('');
			$j("#NONE_OF_THESE_WORDS").val('');
			$j("#ANY_OF_THESE_WORDS").val('');
			$j("#THE_EXACT_PHARSE").val('');
			
		}); 
		 
		$j('[data-popup-boolean-search]').on('click', function(e) {


			recodeSearchString();
			var targeted_popup_class = jQuery(this).attr('data-popup-boolean-search');
			$j('[boolean-search="' + targeted_popup_class + '"]').fadeIn(350);
			e.preventDefault();
		});
		 
		
	
	function downloadScores()
	{
		$j("#downloadScore").val("downloadScore");
	}
	
	$j("#searchText").on("keypress", function (e) {            

		if (e.keyCode == 13) {
			// Cancel the default action on keypress event
			e.preventDefault(); 
			advanceSearch();
		}
});

	function advanceSearch()
	{
		var allOfTheseWordsHidden = $j("#ALL_OF_THESE_WORDS_HIDDEN").val();
		if($j("#searchText").val()=="")
		{
			$j('#dialogOverlayDataSuccess').show();

			// dialog({title:"Message",html:"Please enter keyword for Search"});
			// return false;

		}
		else
		{
			$j("#downloadScore").val("");
			
			
			if(advanceSearchWithinIdArray.length>0)
			{	
				$j("#searchWithinFilterValues").val(advanceSearchWithinIdArray);
			}
			
			if(advanceSearchEndMarketIdArray.length>0)
			{	
				$j("#searchByEndMarketFilterValues").val(advanceSearchEndMarketIdArray);
			}
			
			if(advanceSearchBrandIdArray.length>0)
			{	
				$j("#searchByBrandFilterValues").val(advanceSearchBrandIdArray);
			}
			
			if(advanceSearchMethodologyIdArray.length>0)
			{	
				$j("#searchByMethodologyFilterValues").val(advanceSearchMethodologyIdArray);
			}
			
			if(advanceSearchCategoryIdArray.length>0)
			{	
				$j("#searchByCategoryFilterValues").val(advanceSearchCategoryIdArray);
			}
			
			var reportDateFilter = $j("input[name='reportDateFilter']:checked").val();
			if(reportDateFilter!=undefined && reportDateFilter.trim()!="")
			{	
				$j("#searchByReportDateFilterValues").val(reportDateFilter);
				if(reportDateFilter=="Custom")
				{
					var searchByReportDateFilterCustomStartDate = $j("#customReportStartDate").val();
					$j("#searchByReportDateFilterCustomStartDate").val(searchByReportDateFilterCustomStartDate);
					
					var searchByReportDateFilterCustomEndDate = $j("#customReportEndDate").val();
					$j("#searchByReportDateFilterCustomEndDate").val(searchByReportDateFilterCustomEndDate);
				}
			}
			
			// This is done as Recoding Algorithm needs to be called in all the cases.
			recodeSearchString();
			
			//alert("ALL_OF_THESE_WORDS_HIDDEN aa"+$j("#ALL_OF_THESE_WORDS_HIDDEN").val());
			
			
			var allOfTheseWords = $j("#ALL_OF_THESE_WORDS").val();
			//alert("allOfTheseWords==>"+allOfTheseWords);
			if(allOfTheseWords!=null && allOfTheseWords!=undefined)
			{
				$j("#allOfTheseWords").val(allOfTheseWords);
			}
			
			if(allOfTheseWordsHidden!=null && allOfTheseWordsHidden!=undefined)
			{
				$j("#ALL_OF_THESE_WORDS_HIDDEN").val(allOfTheseWordsHidden);
			}
			
			var noneOfTheseWords = $j("#NONE_OF_THESE_WORDS").val();
		//	alert("noneOfTheseWords==>"+noneOfTheseWords);
			if(noneOfTheseWords!=null && noneOfTheseWords!=undefined)
			{
				$j("#noneOfTheseWords").val(noneOfTheseWords);
			}
			
			var searchIRISSummaryForm = $j("#searchIRISSummaryForm");
			searchIRISSummaryForm.submit();
		}
	}
	
	$j('li.advance-filter-subhead-report-date').find('.error').click (function(e) {
		
		 e.stopPropagation();
		  // $j('#advance-search-report-date').find(".error").css("display","none");

		    $j('#advance-search-report-date .error').css("display","none");

		$j("input[name=reportDateFilter]").val(['']);
		$j('#selected-advance-search-report-date').html('');
		$j('#selected-advance-search-report-date').css('display','none');
		
		$j('#selected-advance-search-report-date-to').html('');
		$j('#selected-advance-search-report-date-to').css('display','none');
	
		$j("#customReportStartDate").val('');
		$j("#customReportEndDate").val('');
	  	$j('#advance-search-report-date').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
		
	});
	
	function showWarning()
	{
	   //	$j("#advanceSearchErrorMessage").css('color', '#507b87');
	    $j("#advanceSearchErrorMessage").css('color', 'rgb(128,128,128,0.6)');
		 // setTimeout(function() {
   //      // $j("#advanceSearchErrorMessage").css('visibility','hidden');
		
   //       }, 2000);
		
		$j('#advanceSearchErrorMessage').css('visibility','visible');
		
		
	}
	

	
</script>



<script type="text/javascript">
  $j(document).ready(function(){

  	$j('.searchBarInfoIcon').click(function(){
  		$j('#dialogOverlayDataInfo').show();
  	})

		$j('.dialogBoxWrap .dialogBtnBox p').click(function(){
   	     $j('#dialogOverlayDataSuccess').hide();
   	     $j('#dialogOverlayDataInfo').hide();
   });
    $j('.radio-list-dd').click(function() {

        var selValue = ($j("input[class='dateRange']:checked").val());
                      
          if(selValue=="Custom") 
          {

          

          	 // $j('.advanceSearchReportDateContainer a#searchResultClosePopupIfCustomSelect').css('pointer-events','none');

            $j('.enableDisableDateField').css('pointer-events','auto');
        
          } 
          else
          {
              $j('.enableDisableDateField').css('pointer-events','none');

              $j('#customReportStartDate').val('');
              $j('#customReportEndDate').val('');  

              // $j('.advanceSearchReportDateContainer a#searchResultClosePopupIfCustomSelect').css('pointer-events','auto');         

          }  

    });	

});

</script>

<script type="text/javascript">
    
    $j(document).ready(function(){
          
        var windowHeight = $j(window).height();
        var headerHEight = $j('#j-header-wrap').height();
        var headerLineHeight = $j('.header-top-page-wrapper').height();
        var footerHeight = $j('footer').height();
       var sumOfHeight = (headerHEight + headerLineHeight + footerHeight);
       var middleContentHeight = (windowHeight) - (sumOfHeight);
       $j('.searchBgImg').css('height',middleContentHeight); 


      	$j(document).on( 'keydown', function (e) {
             if ( e.keyCode === 27 ) {
        $j('#AdvancedSearchPopup').fadeOut(350);
       }
      });



      



      $j('.advanceSearch-booleanSearch-inner').click(function(e){
     
     
     if(e.target.className !== 'outClick')
    {
    	
         
         var textLength;
 
          

          			var ALL_OF_THESE_WORDS_Length= $j("#ALL_OF_THESE_WORDS").val().length;

                  	var NONE_OF_THESE_WORDS_Length=$j("#NONE_OF_THESE_WORDS").val().length;
                  	var  ANY_OF_THESE_WORDS_Length=    $j("#ANY_OF_THESE_WORDS").val().length;
                   	var    THE_EXACT_PHARSE_Length=  $j("#THE_EXACT_PHARSE").val().length;
             
           var TOTOAL_TEXT_LENGTH=ALL_OF_THESE_WORDS_Length+NONE_OF_THESE_WORDS_Length+ANY_OF_THESE_WORDS_Length
                          +THE_EXACT_PHARSE_Length;
                         



             
             if(TOTOAL_TEXT_LENGTH>248)
              {
                   

                $j('#advanceSearchMainInputbox').text(finalSearchString);
             $j('#booleanUpperTextBar').css({'height':'auto','min-height':'28px'});
    	 }


    }
  }
);



         

    });



  



</script>

                 <!--  <div class="booleanUpperTextBar">
                  	
                  	 <p id="advanceSearchMainInputbox"></p>

                  </div> -->