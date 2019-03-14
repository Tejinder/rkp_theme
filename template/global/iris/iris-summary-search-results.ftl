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

<script src="${themePath}/js/jquery.paginate.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>

<script type="text/javascript">
    var  preseverdatastatusCheck=false;
      var  preserevedatastatusForCheckWithIn=false;
</script>   
    

<script src="${themePath}/js/iris/irisUtils.js" type="text/javascript"></script>

  <script type="text/javascript">
    $j(document).ready(function() {

           
        /*Start script For filter popup*/
        $j('[data-popup-ViewInsight]').on('click', function(e) {
     if($j('.popupViewInsight').is(':visible')) {

               $j('.popupViewInsight').css('display', 'none');
    
              }
            var targeted_popup_class = jQuery(this).attr('data-popup-viewInsight');
            $j('[viewInsight="' + targeted_popup_class + '"]').fadeIn(350);
            e.preventDefault();
        });

        $j('[data-popup-close]').on('click', function(e) {
            var targeted_popup_class = jQuery(this).attr('data-popup-close');
            $j('[viewInsight="' + targeted_popup_class + '"]').fadeOut(350);
            e.preventDefault();
        });


        // $j('[data-popup-brand]').on('click', function(e) {
        //     var targeted_popup_class = jQuery(this).attr('data-popup-brand');
        //     $j('[filter-brand="' + targeted_popup_class + '"]').fadeIn(350);
        //     e.preventDefault();
        // });


        /*End script For filter popup*/
    

     
    
    var selectedEndMarketFilters = [];
    <#if irisSummarySearchFilter?? && irisSummarySearchFilter.getSearchByEndMarketFilterValues()?? && irisSummarySearchFilter.getSearchByEndMarketFilterValues()?size gt 0>
      <#list irisSummarySearchFilter.getSearchByEndMarketFilterValues() as selectedEMarketId>
        selectedEndMarketFilters.push(${selectedEMarketId});
      </#list>
      
        getSearchResultEndMarketValueInitial(selectedEndMarketFilters);   


          

     if(selectedEndMarketFilters.length>0)
     {   
      preseverdatastatusCheck=true;
      $j('.searchResultOuterWrap .column.left').addClass('leftColumnBorder');
      $j('#irisSummarySearchWithIn').css('border-width','1px 0px 1px 0px');
    }
    else{
       $j('.searchResultOuterWrap .column.left').removeClass('leftColumnBorder');
    }
        
    </#if>

 

    
    var selectedMethodologyFilters = [];
    <#if irisSummarySearchFilter?? && irisSummarySearchFilter.getSearchByMethodologyFilterValues()?? && irisSummarySearchFilter.getSearchByMethodologyFilterValues()?size gt 0>
      <#list irisSummarySearchFilter.getSearchByMethodologyFilterValues() as selectedMethodologyId>
        selectedMethodologyFilters.push(${selectedMethodologyId});
      </#list>
      getSearchResultMethodologyValueInitial(selectedMethodologyFilters);

      if(selectedMethodologyFilters.length>0)
     {
        $j('.searchResultOuterWrap .column.left').addClass('leftColumnBorder');
        $j('#irisSummarySearchWithIn').css('border-width','1px 0px 1px 0px');
      preseverdatastatusCheck=true;
    }
    else{
            $j('.searchResultOuterWrap .column.left').removeClass('leftColumnBorder');
    }

    </#if>
    
    var selectedBrandFilters = [];
    <#if irisSummarySearchFilter?? && irisSummarySearchFilter.getSearchByBrandFilterValues()?? && irisSummarySearchFilter.getSearchByBrandFilterValues()?size gt 0>
      <#list irisSummarySearchFilter.getSearchByBrandFilterValues() as selectedBrandId>
        selectedBrandFilters.push(${selectedBrandId});
      </#list>
      getSearchResultBrandValueInitial(selectedBrandFilters);


      if(selectedBrandFilters.length>0)
     {
       $j('.searchResultOuterWrap .column.left').addClass('leftColumnBorder');
       $j('#irisSummarySearchWithIn').css('border-width','1px 0px 1px 0px');
      preseverdatastatusCheck=true;
    }
    else{
          $j('.searchResultOuterWrap .column.left').removeClass('leftColumnBorder');
    }
    </#if>
    
    var selectedCategoryFilters = [];
    <#if irisSummarySearchFilter?? && irisSummarySearchFilter.getSearchByCategoryFilterValues()?? && irisSummarySearchFilter.getSearchByCategoryFilterValues()?size gt 0>
      <#list irisSummarySearchFilter.getSearchByCategoryFilterValues() as selectedCategoryId>
        selectedCategoryFilters.push(${selectedCategoryId});
      </#list>
      getSearchResultCategoryValueInitial(selectedCategoryFilters);
       if(selectedCategoryFilters.length>0)
         {
           $j('.searchResultOuterWrap .column.left').addClass('leftColumnBorder');
           $j('#irisSummarySearchWithIn').css('border-width','1px 0px 1px 0px');
          preseverdatastatusCheck=true;
         }
         else{
              $j('.searchResultOuterWrap .column.left').removeClass('leftColumnBorder');
         }

    </#if>
    
    var selectedReportDateFilters;
    <#if searchByReportDateFilterValues?? && searchByReportDateFilterValues!="">
      
      
      //$j('input[class='dateRange'][value='Last 3 months']).attr('checked', true); 
      $j("input[name=reportDateFilter]").val(['${searchByReportDateFilterValues}']);

           
               if('${searchByReportDateFilterValues}'=="Custom" || '${searchByReportDateFilterValues}'=="custom")
               {


                       $j("#SearchResultStartDateRange").html('${searchByReportDateFilterCustomStartDate}');  
                       $j("#SearchResultEndDateRange").html('${searchByReportDateFilterCustomEndDate}');

                       $j('#SearchResultStartDateRange').css('display','block');
                       $j('#SearchResultEndDateRange').css('display','block');
                       $j('.searchResultOuterWrap .column.left').addClass('leftColumnBorder');
                       $j('#irisSummarySearchWithIn').css('border-width','1px 1px 1px 0px');

               }

               else{
                       $j('.searchResultOuterWrap .column.left').removeClass('leftColumnBorder');
                       $j('#irisSummarySearchWithIn').css('border-width','1px 0px 1px 0px');
               }


 $j('.searchResultOuterWrap .column.left').addClass('leftColumnBorder');
 $j('#irisSummarySearchWithIn').css('border-width','1px 0px 1px 0px');


      $j('#SearchResultDateRange').html('${searchByReportDateFilterValues}' + '<i class="error" onclick="clearReportDateFilters()"></i>');
      $j('#SearchResultDateRange').css('display','block');  

       
      preseverdatastatusCheck=true;
      
      
    </#if>
  
    var selectedSearchWithinFilters = [];
    <#if irisSummarySearchFilter?? && irisSummarySearchFilter.getSearchWithinFilterValues()?? && irisSummarySearchFilter.getSearchWithinFilterValues()?size gt 0>
      <#list irisSummarySearchFilter.getSearchWithinFilterValues() as selectedSearchWithinId>
        selectedSearchWithinFilters.push(${selectedSearchWithinId});
      </#list>
      
          getSearchResultSearchWithinValueInitial(selectedSearchWithinFilters);

      if(selectedSearchWithinFilters.length>0)
      {
        preserevedatastatusForCheckWithIn=true;
         $j('.searchResultOuterWrap .column.left').addClass('leftColumnBorder');
         $j('#irisSummarySearchWithIn').css('border-width','1px 1px 1px 0px');
         $j('.searchResultOuterWrap #filterdd').css('border-width','0px 0px 1px');
      }
      else{

           $j('.searchResultOuterWrap .column.left').removeClass('leftColumnBorder');
      } 
       
    </#if>


  <!--  if values are coming from Advance filter page, search result page color changes on filter    -->
  if(preseverdatastatusCheck==true)
  {

        $j('#filterdd').css({"background-color": "#507b87", "color": "#ffffff", });
        $j('#carettest').removeClass('fa-plus-circle').addClass('fa-minus-circle');
      
    
       
  }
  else
  {

     $j('#filterBoxContent').hide();
   
  }


    <!-- if data presever in with in filter -->
      if(preserevedatastatusForCheckWithIn)
          {
              
                  $j('#irisSummarySearchWithIn').css({"background-color": "#507b87", "color": "#ffffff", }); 
                  $j('#caret-irisSummary').removeClass('fa-plus-circle').addClass('fa-minus-circle');  
                   
                 


          }
           else
            {

              $j('#search-with-in').hide();

           }


  

  






    });
    </script>


<script type="text/javascript">
  $j(document).ready(function(){
     // $j('#SearchResultDateRange').hide();
    $j('.radio-list-dd').click(function() {
        var selValue = ($j("input[class='dateRange']:checked").val());
    if(selValue=="Custom") 
        {
      $j('.enableDisableDateField').css('pointer-events','auto');
      //$j('#searchResultClosePopup #searchResultClosePopupIfCustomSelect').css('pointer-events','none');
        } 
        else
        {
            $j('.enableDisableDateField').css('pointer-events','none');
      $j('#searchResultClosePopup #searchResultClosePopupIfCustomSelect').css('pointer-events','auto');

            $j('#customReportStartDate').val('');
            $j('#customReportEndDate').val('');

            $j('#SearchResultStartDateRange').hide();
            $j('#SearchResultEndDateRange').hide();
        }  



    if(selValue==undefined)
    {
      $j('#SearchResultDateRange').hide();
    }
    else
    {
      $j('#SearchResultDateRange').html(selValue + '<i class="error" onclick="clearReportDateFilters()" ></i>'); 
      $j('#SearchResultDateRange').css('display','block');
    }
    });
  


});

function  forStartDate()
     {

         
         var customReportStartDate = $j("#customReportStartDate").val();       
        $j('#SearchResultStartDateRange').html(customReportStartDate);
         $j('#SearchResultStartDateRange').css('display','block');                  
   var customReportEndDate = $j("#customReportEndDate").val();

                 if(customReportEndDate=="")
                 {
                        //$j('#searchResultClosePopup #searchResultClosePopupIfCustomSelect').css('pointer-events','none');
                  
                 }
                 else
                 {
                     $j('#searchResultClosePopup #searchResultClosePopupIfCustomSelect').css('pointer-events','auto');
                 }

     }

     function  forEndDate()
     {
       
       var customReportEndDate = $j("#customReportEndDate").val();
        $j('#SearchResultEndDateRange').html(customReportEndDate);
         $j('#SearchResultEndDateRange').css('display','block');
   var customReportStartDate = $j("#customReportStartDate").val();   

                 if(customReportStartDate=="")
                 {
                     //$j('#searchResultClosePopup #searchResultClosePopupIfCustomSelect').css('pointer-events','none');
                 }
                 else
                 {
                     $j('#searchResultClosePopup #searchResultClosePopupIfCustomSelect').css('pointer-events','auto');
                 }
                  
     }
</script>




<script>
 $j(document).ready(function () {   



    $j('#filterdd').on('click', function () {



        var flag=false;
    $j('.searchResultOuterWrap .column.left').addClass('leftColumnBorder');
          $j('#irisSummarySearchWithIn').css('border-width','1px 0px');
      if ($j('#carettest').hasClass('fa-plus-circle')) {
        $j('#carettest').removeClass('fa-plus-circle').addClass('fa-minus-circle');

        if($j("#filterBoxContent").is(":visible")){
  

            $j('#filterBoxContent').hide();

          }

          else {
   $j('.searchResultOuterWrap #filterdd').css('border-width','1px 1px 1px');
                   $j('#filterBoxContent').show();

                     // tool tip for search with in section
                   $j('.searchWithinTitle').css('top','-14px');
          }


        $j('#filterdd').css({"background-color": "#507b87", "color": "#ffffff", });
      }else{


           if($j("#search-with-in").is(":visible")){
                flag=true;
                 $j('.searchResultOuterWrap .column.left').addClass('leftColumnBorder');
                  $j('.searchResultOuterWrap #filterdd').css('border-width','0px 0px 1px');

 
              }
              else{
                $j('.searchWithinTitle').css('top','36px');
              }

               if(flag==false)
               {
                 $j('.searchResultOuterWrap .column.left').removeClass('leftColumnBorder'); 

               }

                              
             $j('#irisSummarySearchWithIn').css('border-width','1px 1px');

        $j('#carettest').removeClass('fa-minus-circle').addClass('fa-plus-circle');
        $j('#filterBoxContent').hide();
         // $j('#filterdd').css({"background-color": "#ffffff", "color": "#5d5d5d"});
         $j('#filterdd').css({"background-color": "#507b87", "color": "#ffffff"});
      }
    });
  });


 $j(document).ready(function() {

            $j('#irisSummarySearchWithIn').on('click', function () {
     $j('.searchResultOuterWrap .column.left').addClass('leftColumnBorder');
            $j('.searchResultOuterWrap #filterdd').css('border-width','0px 0px 1px');


           //  if(($j("#filterBoxContent").is(":visible")) && ($j("#search-with-in").is("not:visible"))) {
           //  alert('vsh');
           // $j('.searchResultOuterWrap .column.left').addClass('leftColumnBorder');
           // }

               
               if($j("#filterBoxContent").is(":visible")){               
                 $j('.searchResultOuterWrap #filterdd').css('border-width','1px 1px 1px');
                  $j('#irisSummarySearchWithIn').css('border-width','1px 1px');

                    $j('.searchResultOuterWrap .column.left').addClass('leftColumnBorder');
                   // alert(5);

               }

                if ($j('#caret-irisSummary').hasClass('fa-plus-circle')) {
                    $j('#caret-irisSummary').removeClass('fa-plus-circle').addClass('fa-minus-circle');

                     if($j("#search-with-in").is(":visible")){

                             $j('#search-with-in').hide();

                                   }

                             else {
                                   $j('#search-with-in').show();

                                 // tool tip for search with in section......
                                   $j('.searchWithinTitle').css('top','36px');

                                

                                  }

                    $j('#irisSummarySearchWithIn').css({"background-color": "#507b87", "color": "#ffffff", });
                    //$j('.fa-minus-circle:before').css({"background-color": "#ffffff", "color": "#597985", "content": "\f056"});
                }else{
                     $j('.searchResultOuterWrap .column.left').removeClass('leftColumnBorder');
                    $j('.searchResultOuterWrap #filterdd').css('border-width','1px 1px 1px');
                    $j('#caret-irisSummary').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                    $j('#search-with-in').hide();
                    $j('#irisSummarySearchWithIn').css({"background-color": "#507b87", "color": "#ffffff"});

                        if($j('#filterBoxContent').is(":visible")){                       
                         $j('.searchResultOuterWrap .column.left').addClass('leftColumnBorder');
                         $j('#irisSummarySearchWithIn').css('border-width','1px 0px');

                         // tool tip for search with in section......
                          $j('.searchWithinTitle').css('top','-14px');

                       }                }
            });
        });
  


 // $j(document).ready(function () {
 //  $j('#pre-filter-content').hide();
 //            $j('#pre-filters-field').on('click', function () {
 //                if ($j('#caret-pre-filter').hasClass('fa-plus-circle')) {
 //                    $j('#caret-pre-filter').removeClass('fa-plus-circle').addClass('fa-minus-circle');
 //                    $j('#pre-filter-content').show();
 //                }else{
 //                    $j('#caret-pre-filter').removeClass('fa-minus-circle').addClass('fa-plus-circle');
 //                    $j('#pre-filter-content').hide();
 //                }
 //            });
 //        });

  var showSortByDiv = "yes";
  $j(document).ready(function () {
  $j('#relevance-dd-content').hide();
   $j('#relevance-dd').css({'background-color':'#507b87','color':'#ffffff'});
            $j('#relevance-dd').on('click', function () {

                if ($j('#relevanceCaret').hasClass('fa-caret-down')) {
                    $j('#relevanceCaret').removeClass('fa-caret-down').addClass('fa-caret-up');
                    $j('#relevance-dd').css({'background-color':'#507b87','color':'#ffffff'});
                    $j('#relevance-dd-content').show();
                   
                }else{
                    $j('#relevanceCaret').removeClass('fa-caret-up').addClass('fa-caret-down');
                    $j('#relevance-dd-content').hide();
                }

});
});



             
        // if(showSortByDiv=="yes")
        // {
        // $j('#relevance-dd').css({'background-color':'#507b87','color':'#ffffff'});
        // $j('#relevance-dd-content').show();   
        // showSortByDiv="no"        
        // }
        // else
        // {
      
        // $j('#relevance-dd-content').hide();
        // showSortByDiv="yes"
        // }
                   
        //     });
        // });


</script>


<script type="text/javascript">

    $j(document).ready(function(){

          // Start script for search result middle section on hover checkboxes appear and resume after click   

            $j('.searchResultHoverCheckbox').click(function () {  

                  var irisResultSummaryCheckStatus=false;

                $j('.searchResultHoverCheckbox').each(function(){

                    if($j(this).prop("checked") == true){
                        $j(this).parent().css('visibility','visible');  

                         var irisResultSummaryCheckStatus=true;               
                      }
                   else if(($j(this).prop("checked") == false))
                      {
                         $j(this).parent().removeAttr('style');                                                                            
            $j('#DownloadContainer label').css({'opacity':'0.5','pointer-events':'none'});                                                                          
                  }

                }); 


                    // var iris_Summary=$j("#iris_Summary").prop("checked");
                    // var attached_Reports=$j("#attached_Reports").prop("checked");
                    // var overview_Blurb=$j("#overview_Blurb").prop("checked");
                    // var overview_Insight=$j("#overview_Insight").prop("checked");


                     // if no check box is selecte above download link

                     $j('#iris-results input:checked').each(function() {

                          irisResultSummaryCheckStatus=true;




  
                          });

                    if(irisResultSummaryCheckStatus==false)
                      {
                           
                           ($j('.borderBottomDownload a').css('opacity','0.6'));
               //($j('.borderBottomDownload a').css('pointer-events','none'));

               
               
               

                               // $j("#iris_Summary").attr("disabled",true);
                               // $j("#attached_Reports").attr("disabled",true);
                               // $j("#overview_Blurb").attr("disabled",true);
                               //  $j("#overview_Insight").attr("disabled",true);
                 
                $j("#iris_Summary").attr("checked",false);
                  $j("#attached_Reports").attr("checked",false);
                $j("#overview_Blurb").attr("checked",false);
                $j("#overview_Insight").attr("checked",false);
                 
                 ($j('.borderBottomDownload a').css('pointer-events','none'));

                ($j('.borderBottomDownload a').css('cursor','default'));
                 $j('.checkboxContainer.deselectResult').css('display','none');

                      }
                      else
                      {

                                 // $j("#iris_Summary").removeAttr("disabled");
                                  // $j("#attached_Reports").removeAttr("disabled");
                                  // $j("#overview_Blurb").removeAttr("disabled");
                                  // $j("#overview_Insight").removeAttr("disabled");

                                 $j('#DownloadContainer label').css({'opacity':'1','pointer-events':'auto'});
                                  ($j('.borderBottomDownload a').css('pointer-events','auto'));
                                  $j('.checkboxContainer.deselectResult').css('display','block');
                                  $j('.searchResultDeselectAll').prop('checked',true);
                
                                                         
                       }


            });

          // End script for search result middle section on hover checkboxes appear and resume after click  


          // start script for search result download section enable disable start download option

                $j('.checkboxContainer .searchDownloadCheckboxes ').click(function(){

                   
                    var searchDownloadCheckStatus =false;
                    $j('.searchDownloadCheckboxes').each(function(){

                      if($j(this).prop("checked") == true){
                           searchDownloadCheckStatus =true;
                      }

                      });


                       if(searchDownloadCheckStatus)
                       {     
                         // check iris result summary 
                               var resultSummaryCheckSatatus=false
                               $j('#iris-results input:checked').each(function() {
                         
                                     resultSummaryCheckSatatus=true;
                             });
              if(resultSummaryCheckSatatus)
              {
                              ($j('.borderBottomDownload a').css('opacity','1'));
                 $j('.borderBottomDownload').removeAttr('style');
                ($j('.borderBottomDownload a').css('pointer-events','auto'));

                 ($j('.borderBottomDownload a').css('cursor','pointer'));


              }
              
                       }
                        else
                        {
                          ($j('.borderBottomDownload a').css('opacity','0.6'));
                          ($j('.borderBottomDownload a').css('pointer-events','none'));

                          ($j('.borderBottomDownload a').css('cursor','default'));
                        }
                  });  

          // End script for search result download section enable disable start download option


});

</script> 


<#--
<div class="searchResultBar">
  <div class="searchBarContainer">
        <form method="POST" name="searchIRISSummaryForm" id="searchIRISSummaryForm" action="/iris-summary/search!execute.jspa">
            <#if searchText??>
        <input type="Search" name="searchText" id="searchText" value='${searchText}'>
        
      <#else>
        <input type="Search" name="searchText" id="searchText" value="">
      </#if>  
           
                  
      <input type="hidden" name="downloadScore" id="downloadScore" value="">
      
      <a class="searchBarSearchText" onclick="searchIRIS();"><span>SEARCH</span> <i class="fa fa-search"></i></a>
      <a class="searchBarSearchText" onclick="downloadScores();">Download Scores</a>
          
        </form> 
    </div>
 </div>
-->



<#assign irisURL = request.requestURL />

<div class="searchResultOuterWrap">

    <div class="column left removeLeftSpace" >      
        <div>
      <div id="filterdd" class="filterHeadBox" title="After selecting parameters, click on Apply Filters button to refine search results.">
        <p style="padding-top: 4px;margin: 2px 0px 3px 0px !important;" title="After selecting parameters, click on Apply Filters button to refine search results.">Filters</p>
        <span style="float: right;position: relative;top: -20px;color: #fff;"><i id="carettest" class="fa fa-plus-circle"></i></span>                
      </div>
      <div id="filterBoxContent">
        <ul>
                                                                             
          <li data-popup-brand="Popup-Brand"><a href="#">Brand</a></li>
            <p id="SearchResultBrand" class="clt"></p>
			
		<li data-popup-methodology="Popup-Methodology"><a href="#">Methodology</a></li>
            <p id="SearchResultMethodology" class="clt"></p>         	
          <li data-popup-category="Popup-Category"><a href="#">Category</a></li>
            <p id="SearchResultCategory" class="clt"></p>
          <li data-popup-endmarket="Popup-EndMarket"><a href="#">End Market</a></li>
            <p id="SearchResultEndMarket" class="clt"></p>
           <li data-popup-report-date="Popup-ReportDate"><a href="#">Report Date Range</a></li>
            <p id="SearchResultDateRange" class="clt"></p>
             <p id="SearchResultStartDateRange" style="display: none;"></p>
                     <p id="SearchResultEndDateRange" style="display: none;"></p>

          <li id="filterApply" class="applyFilterEvent searchWithInDisable" onclick="return applySearchFilters();"><a href="#">Apply Filters</a></li>
          <li id="filterClearAll" class="applyFilterEvent" onclick="return clearSearchFilters();"><a href="#">Clear All Filters</a></li>
        </ul>                           
      </div>
        </div>

     <div>
      <#-- <#if searchBySynchroId?? && searchBySynchroId=="searchBySynchroId"> -->
      <#if irisURL?? && irisURL?contains("iris-summary/search-results-synchro-code!execute.jspa") > 
        <div id="irisSummarySearchWithIn" class="searchWithInDisable irisSummarySearchWithIn">
      <#else>
        <div id="irisSummarySearchWithIn" class="IrisSummaryHeadBox" title="After selecting parameters, click on Apply Selected Sections button to refine search results." >
        <#--  <div style="display: none;" class="searchWithinTitle">After selecting parameters, click on Apply Selected Sections button to refine search results.</div> -->
      </#if>

          <p style="width: 96px;margin-bottom: 0px;" title="After selecting parameters, click on Apply Selected Sections button to refine search results." >IRIS Summary Sections</p>
          <span style="float: right;position: relative;top: -25px;color: #fff;" ><i id="caret-irisSummary" class="fa fa-plus-circle" ></i></span>                
        </div>
      
      <div id="search-with-in">
        <ul>
          <li data-popup-search-within="Popup-SearchWithin"><a href="#" class="searchWithinTitle">Search Within</a></li>
            <p id="SearchResultSearchWithin" class="clt"></p>   
                                                                                  
          <li id="searchWithInApply" class="applySearchWithinEvent searchWithInDisable" onclick="return applySearchWithinFilters();"><a href="#">Apply Selected Sections</a></li>
          <li id="searchWithInClearAll" class="applySearchWithinEvent" onclick="return clearSearchWithInFilters();"><a href="#">Clear All Selections</a></li>
        </ul>                           
      </div>
    
        </div>
  
  <!-- Start Methodology Filter -->

  <div class="popup" methodology="Popup-Methodology">
         <!-- Below div is added to set the Pop-up position on Advance search page -->
    <div class="setPopupPosition"> 

        <div onclick="$j('.search-in-style').hide();" class="search-result-popup-inner">
      
            <div class="checkbox-popup-wrapper">
                <div class="search-field">
                    <input type='text' id='txtList' class='txtListOnPopup' onkeyup="filter(this)" placeholder="Search Methodology" />
                    <a class="popup-close" data-popup-close="Popup-Methodology" href="#"><img class="popupCrossBtn" src="${themePath}/images/iris/cross-icon.png"></a>
                </div>
                <div class="search-result-methodology-popup">                
                    <div class="select-all-section">
                        <div id="hideselectall">
                            <label class="checkboxContainer">Select All
                                <input type="checkbox" id="searchResultMethodologySelectAll" value="" name="searchResultMethodologySelectAll">
                                <span class="checkmark"></span>
                            </label>
                         </div>
                         
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
                      <input type="checkbox" class="methodologycheckBoxClass" value="${methodologies.get(methkey)}" methodologyid="${methkey}" id="${methodologies.get(methkey)}" >
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



<!-- Start Report Date Range Pop-Up -->

 <div id="searchResultClosePopup" class="popup" report-date="Popup-ReportDate">
    <!-- Below div is added to set the Pop-up position on Advance search page -->
    <div class="setPopupPosition"> 

        <div class="searchResultReportDatePopupInner">
            <div class="report-popup-wrapper">
                <div class="mainHeadBox">
          <p>Report Date Range</p>
          <a id="searchResultClosePopupIfCustomSelect" class="popup-close" data-popup-close="Popup-ReportDate" href="#"><img class="popupCrossBtn" src="${themePath}/images/iris/cross-icon.png"></a>
                </div>

                <div class="search-result-report-date-popup">                
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
            
            
                        <li class="customReportRange">
                            <label class="radioBtncontainer">Custom
                                <input type="radio" name="reportDateFilter" value="Custom" class="dateRange">
                                <span class="radiocheckmark"></span>
                           </label>
                        </li>
                      </ul>

                      <div class="calenderBoxWrap enableDisableDateField">
                        <input type="text" name="customReportStartDate" onchange="forStartDate()" placeholder="From" id="customReportStartDate" readonly="true" <#if searchByReportDateFilterCustomStartDate??> value="${searchByReportDateFilterCustomStartDate}" </#if>>
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
                        <input type="text" name="customReportEndDate" placeholder="To" onchange="forEndDate()" id="customReportEndDate"  readonly="true" <#if searchByReportDateFilterCustomEndDate??> value="${searchByReportDateFilterCustomEndDate}" </#if>>
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

    <!-- End Report Date Range Pop-Up -->
    
    <!-- End Methodology Filter --> 
  
  <!-- Start Brand Filter -->

  <div class="popup" brand="Popup-Brand">
<!-- Below div is added to set the Pop-up position on Advance search page -->
    <div class="setPopupPosition"> 

        <div onclick="$j('.search-in-style').hide();" class="search-result-popup-inner">
        

            <div class="checkbox-popup-wrapper">
                <div class="search-field">
                    <input type='text' id='txtList' class='txtListOnPopup' onkeyup="filter(this)" placeholder="Search Brand" />
                    <a class="popup-close" data-popup-close="Popup-Brand" href="#"><img class="popupCrossBtn" src="${themePath}/images/iris/cross-icon.png"></a>
                </div>
                <div class="search-result-brand-popup">                
                    <div class="select-all-section">
                        <div id="hideselectall">
                            <label class="checkboxContainer">Select All
                                <input type="checkbox" id="searchResultBrandSelectAll" value="" name="searchResultBrandSelectAll">
                                <span class="checkmark"></span>
                            </label>
                         </div>
                         
                    </div>
                    <div class="checkboxes-list-dd">
                        <ul id="checkBoxes" class="fromList">
            
              <#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
              <#if (brands?has_content)>
                <li>
                  <label class="checkboxContainer">${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getDescription()}
                  <input type="checkbox" class="brandcheckBoxClass" value="${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getDescription()}" brandid="${statics['com.grail.util.BATConstants'].MULTI_BRAND_DB_VALUE}" id="${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getDescription()}" >
                  <span class="checkmark"></span>
                  </label>
                </li>
                
                <li>
                  <label class="checkboxContainer">${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getDescription()}
                  <input type="checkbox" class="brandcheckBoxClass" value="${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getDescription()}" brandid="${statics['com.grail.util.BATConstants'].NON_BRAND_DB_VALUE}" id="${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getDescription()}" >
                  <span class="checkmark"></span>
                  </label>
                </li>
                
                <#list brands.keySet() as key>
                  <#assign brand = brands.get(key)/>
                  <#if key == statics['com.grail.util.BATConstants'].MULTI_BRAND_DB_VALUE || key == statics['com.grail.util.BATConstants'].NON_BRAND_DB_VALUE >
                  <#else>
                    <li>
                      <label class="checkboxContainer">${brand}
                      <input type="checkbox" class="brandcheckBoxClass" value="${brand}" brandid="${key}" id="${brand}" >
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

    <!-- End Brand Filter --> 
    
    
  
<!-- Start Category Filter -->

  <div class="popup" category="Popup-Category">
<!-- Below div is added to set the Pop-up position on Advance search page -->
    <div class="setPopupPosition"> 

        <div onclick="$j('.search-in-style').hide();" class="search-result-popup-inner">
            
    <div class="checkbox-popup-wrapper">
                <div class="search-field">
                    <input type='text' id='txtList' class='txtListOnPopup' onkeyup="filter(this)" placeholder="Search Category" />
                    <a class="popup-close" data-popup-close="Popup-Category" href="#"><img class="popupCrossBtn" src="${themePath}/images/iris/cross-icon.png"></a>
                </div>
                <div class="search-result-category-popup">                
                    <div class="select-all-section">
                        <div id="hideselectall">
                            <label class="checkboxContainer">Select All
                                <input type="checkbox" id="searchResultCategorySelectAll" value="" name="searchResultCategorySelectAll">
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
                    <input type="checkbox" class="categorycheckBoxClass" value="${categoryType}" categoryid="${key}" id="${categoryType}" >
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

    <!-- End Category Filter -->  
    



  <!-- Start end market Filter -->

  <div class="popup" end-market="Popup-EndMarket">
<!-- Below div is added to set the Pop-up position on Advance search page -->
    <div class="setPopupPosition"> 

        <div onclick="$j('.search-in-style').hide();" class="search-result-popup-inner">
           
<div class="checkbox-popup-wrapper">
                <div class="search-field">
                    <input type='text' id='txtList' class='txtListOnPopup' onkeyup="filter(this)" placeholder="Search End Market" />
                    <a class="popup-close" data-popup-close="Popup-EndMarket" href="#"><img class="popupCrossBtn" src="${themePath}/images/iris/cross-icon.png"></a>
                </div>
                <div class="search-result-end-market-popup">                
                    <div class="select-all-section">
                        <div id="hideselectall">
                            <label class="checkboxContainer">Select All
                                <input type="checkbox" id="searchResultEndMarketSelectAll" value="" name="searchResultEndMarketSelectAll">
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
                        <input type="checkbox" class="endMarketcheckBoxClass" value="${endMarkets.get(endMarketkey)}" endmarketid="${endMarketkey}" id="${endMarkets.get(endMarketkey)}" >
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

    <!-- End end market Filter -->



  
       
    
    
    <!-- Start Search Within Filter -->

  <div class="popup" search-within="Popup-SearchWithin">

<!-- Below div is added to set the Pop-up position on Advance search page -->
    <div class="setPopupPosition"> 

        <div onclick="$j('.search-in-style').hide();" class="search-result-popup-inner">
            

            <div class="checkbox-popup-wrapper">
                <div class="search-field">
                    <input type='text' id='txtList' class='txtListOnPopup' onkeyup="filter(this)" placeholder="Search Within" />
                    <a class="popup-close" data-popup-close="Popup-SearchWithin" href="#"><img class="popupCrossBtn" src="${themePath}/images/iris/cross-icon.png"></a>
                </div>
                <div class="search-result-search-within-popup">                
                    <div class="select-all-section">
                        <div id="hideselectall">
                            <label class="checkboxContainer">Select All
                                <input type="checkbox" id="searchResultSearchWithinSelectAll" value="" name="searchResultSearchWithinSelectAll">
                                <span class="checkmark"></span>
                            </label>
                         </div>
                           
                    </div>
                    <div class="checkboxes-list-dd">
                        <ul id="checkBoxes" class="fromList">
              <#assign indexFields = statics['com.grail.util.BATUtils'].getAllIRISSummaryIndexFieldNamesSearchWithin() />
              <#if (indexFields?? && indexFields?has_content)>
                <#list indexFields.keySet() as key>
                <#--  <#if statics['com.grail.util.BATUtils'].getAllIRISSummaryIndexFieldWeights().get(key) gt 0> -->
                
                    <li>
                      <label class="checkboxContainer">${statics['com.grail.util.BATConstants$IRISSummaryIndexFieldName'].getByCode('${indexFields.get(key)}').getDescription()}
                      <input type="checkbox" class="searchWithinCheckBoxClass" value="${statics['com.grail.util.BATConstants$IRISSummaryIndexFieldName'].getByCode('${indexFields.get(key)}').getDescription()}"  searchwithinid="${key}" id="${statics['com.grail.util.BATConstants$IRISSummaryIndexFieldName'].getByCode('${indexFields.get(key)}').getDescription()}" >
                      <span class="checkmark"></span>
                      </label>
                    </li>
                    
                <#--  </#if>  -->
                </#list>
              </#if>              
                        </ul>
                    </div>
                </div>
            </div>
        </div>
</div>
    </div>

    <!-- End Search Within Filter -->
  
  
  
  
    
    <!--
    <div>
      <div id="searchWithIn" style="width: 100%;padding: 4px 6px;border: 1px solid #808082;">
        <p style="padding-top: 4px;margin: 2px 0px 3px 0px !important;">IRIS Summary Sections</p>
        <span style="float: right;position: relative;top: -20px;color: #fff;"><i id="carettest" class="fa fa-plus-circle"></i></span>                
      </div>
      <div id="filterBoxContent">
        <ul>
          <li data-popup-methodology="Popup-SearchWithin"><a href="#">Search Within</a></li>
            <p id="SearchResultWithin" class="clt"></p>                                                                            
          
        </ul>                           
      </div>
        </div>

    -->
         <!--  <div>
               <div id="pre-filters-field" style="width: 100%;background-color: #174349;padding: 1px 8px;margin-top: 25px;">
                <p style="text-align: center;color: #ffffff;padding-top: 4px;margin: 2px 0px 3px 0px !important;">Pre-Filters</p>
                  <span style="float: right;position: relative;top: -20px;color: #fff;fo"><i id="caret-pre-filter" class="fa fa-plus-circle"></i></span>                
               </div>
                <div id="pre-filter-content">
                           <p class="filter-dd-in">Methodology</p>
                           <p class="filter-dd-in">Brand</p>
                           <p class="filter-dd-in">End Market</p>
                           <p class="filter-dd-in">Tag</p>                                             
                </div>
          </div> -->

    </div>

  
  
  
      <div class="column middle"> 
      <!--   <form method="POST" name="searchIRISSummaryForm" id="searchIRISSummaryForm" action="/iris-summary/search!execute.jspa">
              <div>
                <div class="search-dynamic-page">
                  <span class="fa fa-search"></span>
                    <#if searchText??>
            <input type="text" name="searchText" value="${searchText}">
          <#else>
            <input type="text" name="searchText" value="">
          </#if>  
          <input type="hidden" name="downloadScore" id="downloadScore" value="">
                  <button class="j-btn-callout btnSearch-align btn-mrgn-srch" onclick="searchIRIS();">Search</button>
          <button class="j-btn-callout btnSearch-align btn-mrgn-srch" onclick="downloadScores();">Download Scores</button>
              </div>   
            </div>            
          </form>  -->




           <div class="searchResultContentBox">

            <!--  <div class="searchResultInnerWrap">
                <label class="checkboxContainer">
              <input type="checkbox">
              <span class="checkmark"></span>   
          </label>
                  <a href="#">New OXXO PM - Consumer Evaluation</a>
                  <div class="searchResultAlign">
                    <p>Turkey is a highly competitive "must win", making Turkey the 8th largest tobocco market in the world and in premium (1%). Turkey is predominantly a FF market (74% FF, 24% Lts)</p>
                    <a href="#" class="applyOnHover"> <i class="fa fa-angle-double-right" aria-hidden="true"></i> View Insights </a>
                    <small> Indonesia | Qualitative Study | Pall Mall | Report Date: 14-07-2017 | Synchro ID: 3421 | Category: Multi-Category </small>
                  </div> 

                      <div class="searchdialog">
                        <a href="#" class="close-classic"></a>
                        <p>Turkey is a highly competitive "must win", making Turkey the 8th largest tobocco market in the world and in premium.Turkey is a highly competitive "must win", making Turkey the 8th largest tobocco market in the world and in premium.</p>
                      </div>

              </div> -->

        
        
       <!--  <a href="#" class="deselectOptions" onclick="deSelectAllOptions();" >Deselect All</a> -->
        
        
          <#if irisSummaryList?? && irisSummaryList?size gt 0>
          <#assign userManager = jiveContext.getSpringBean("userManager") />
          <#assign irisSummaryManager = jiveContext.getSpringBean("irisSummaryManager") />
          <#list irisSummaryList as irisSummaryS>
            <#if irisSummaryS?? && irisSummaryS.irisSummaryId?? && irisSummaryS.irisSummaryId gt 0>
            <div class="searchResultInnerWrap" id="iris-results">
                <#assign irisSummary = irisSummaryManager.getIRISSummary(irisSummaryS.irisSummaryId)>
                <label class="checkboxContainer">
                  <input type="checkbox" name="${irisSummaryS.irisSummaryId?c}"  id="${irisSummaryS.irisSummaryId?c}" class="searchResultHoverCheckbox">
                  <span class="checkmark"></span>   
                </label>
                <#assign cName ="-" />
                <#assign mName ="-" />
                <#assign bName ="-" />
                <#assign categoryNames ="-" />
                
                <#--
                <#if irisSummary.containerId?? && irisSummary.containerId == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER>
                  <#assign cName = statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER_NAME />
                <#elseif irisSummary.containerId?? && irisSummary.containerId == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL>
                  <#assign cName = statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL_FOLDER_NAME />
                <#elseif irisSummary.containerId?? && irisSummary.containerId == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL>
                  <#assign cName = statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL_FOLDER_NAME />
                <#elseif irisSummary.containerId?? && statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(irisSummary.containerId)??>
                  <#assign cName = statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(irisSummary.containerId) />
                </#if>  
                -->
                
                <#if irisSummary.endMarketId?? && irisSummary.endMarketId?size gt 0>
                  <#assign cName = statics['com.grail.synchro.util.SynchroUtils'].getAllEndMarketNames(irisSummary.endMarketId) />
                  <#if cName=="" || cName =" ">
                    <#assign cName ="-" />
                  <#elseif cName?contains(",")>
                    <#assign cName ="Multiple End Markets" />
                  </#if>
                </#if>
                
                <#if irisSummary.methodology?? && irisSummary.methodology?size gt 0>
                  <#assign mName = statics['com.grail.synchro.util.SynchroUtils'].getAllMethodologyNames(irisSummary.methodology) />
                  <#if mName=="" || mName =" ">
                    <#assign mName ="-" />
                  </#if>
                </#if>
                
                <#if irisSummary.brandCoverage??  && (irisSummary.brandCoverage gt 0) && irisSummary.brandCoverage == statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getId() >
                  <#assign bName = statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getDescription() />
                <#elseif irisSummary.brandCoverage??  && (irisSummary.brandCoverage gt 0) && irisSummary.brandCoverage == statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getId() >
                  <#if irisSummary.brandHouse?? && irisSummary.brandHouse?size gt 0>
                    <#assign bName = statics['com.grail.synchro.util.SynchroUtils'].getBrandNamesInteger(irisSummary.brandHouse) />
                  <#else>
                    <#assign bName = statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getDescription() />
                  </#if>
                  
                <#elseif irisSummary.brandHouse?? && irisSummary.brandHouse?size gt 0>
                  <#assign bName = statics['com.grail.synchro.util.SynchroUtils'].getBrandNamesInteger(irisSummary.brandHouse) />
                </#if>
                
                <#if bName=="" || bName =" ">
                    <#assign bName ="-" />
                </#if>
                  
                <#if irisSummary.category?? && irisSummary.category?size gt 0>
                  <#assign categoryNames = statics['com.grail.synchro.util.SynchroUtils'].getCategoryNamesInteger(irisSummary.category) />
                </#if>
                
                <#if categoryNames=="" || categoryNames =" ">
                    <#assign categoryNames ="-" />
                </#if>
                
                <a href="/iris-summary/view-summary!input.jspa?irisSummaryId=${irisSummaryS.irisSummaryId?c}" target="_blank">${irisSummary.projectName}</a>
                <div class="searchResultAlign">
                  <small class="metaDataFirstLine" style="margin-bottom: 10px;">${cName} | ${mName} | ${bName} </small> 
                  <div class="blurbTextDynamic" style="margin-bottom: 10px;">
                  
                  
                    <p>
                      <#if irisSummary.blurbsText??>
                        ${irisSummary.blurbsText}
                      </#if>  
                    </p>
                  </div>
                  
                  <#--
                  <a data-popup-ViewInsight="popup-${irisSummaryS.irisSummaryId}" href="#" class="applyOnHover open-filter-section"> <i class="fa fa-angle-double-right" aria-hidden="true"></i> View Insights </a>
                  -->

                
                  
                   
                  
                  <small class="metaDataSecondLine"> Report Date: <#if irisSummary.finalReportDate??> ${irisSummary.finalReportDate?string('dd/MM/yyyy')}<#else>- </#if> | Synchro Code: <#if irisSummary.synchroCode?? && irisSummary.synchroCode gt 0> ${irisSummary.synchroCode?c}<#else>-</#if> | Category: ${categoryNames} </small> 
               

         
         
                </div>  

                <div class="popupViewInsight" viewInsight="popup-${irisSummaryS.irisSummaryId}">
                  <div  class="ViewInsightPopupInnner">      
                  <img src="${themePath}/images/iris/cross-icon.png" data-popup-close="popup-${irisSummaryS.irisSummaryId}">      
                  <div class="searchdialog">
                  <#--  <a href="#" class="close-classic" data-popup-close="popup-${irisSummaryS.irisSummaryId}"></a> -->
                     <#assign irisSummaryInsights = irisSummaryManager.getIRISSummaryInsights(irisSummaryS.irisSummaryId)>
                    
                    <#assign showInsightSection = "no" />
                    <#if irisSummaryInsights?? && irisSummaryInsights?size gt 0>
                      
                        <div class="viewInsightContentWrap">
                        <#list irisSummaryInsights as irisSummaryInsight>
                          <#if irisSummaryInsight.getInsightsText()??>
                            <#if irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PRODUCT_TAGS_NAME>
                            <#elseif irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PROJECT_TAGS_NAME>
                            <#else>
                              
                              <div class="viewInsightContent">                      
                                <p><#if irisSummaryInsight.getInsightsHeading()?? > ${irisSummaryInsight.getInsightsHeading()}</#if></p>
                                <div>${irisSummaryInsight.getInsightsText()}</div>
                              </div>
                              <#assign showInsightSection = "yes" />
                            </#if>  
                          
  
                          
                          
                          </#if>  
                        </#list>
                      
                      </div>
                     
                    <#--
                     <ul>
                      <#list irisSummaryInsights as irisSummaryInsight>
                        <#if irisSummaryInsight.getInsightsText()??>
                          <#if irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PRODUCT_TAGS_NAME>
                          <#elseif irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PROJECT_TAGS_NAME>
                          <#else>
                            <li>${irisSummaryInsight.getInsightsText()}</li>
                          </#if>  
                        </#if>  
                      </#list>
                      
                      </ul>
                      -->
                      
                    
                    </#if> 

                    <#if showInsightSection == "no">  
                      <div class="viewInsightContentWrap">  
                        <div class="viewInsightContent">    
                          <p>Insights</p>
                          <div>There are no insights to show.</div>
                        </div>  
                      </div>
                    </#if>
                   </div>  
                  </div>
                 </div>

                
              </div>
            </#if>
          </#list>
            
        <#else>
          <script>
                         $j(".searchResultOuterWrap .column.middle").css('height','371px');
                        $j('.searchResultContentBox').css('margin-top','0px');
                
                    </script> 
          <p class="noResultText"><img src="${themePath}/images/iris/iris-info-icon.png">  There were no results for your search.</p>
        </#if>  

        
        

                   <div class="searchResultPagAlign">
                  <#if pages?? && (pages>1)>
                      <div id="pagination"></div>
                  </#if>
               </div> 




        
           </div>



        </div>

  
  <div id="dialogOverlay">
     <div class="dialogBoxWrap">
     <div class="dialogInnerWrap">
      <img src="${themePath}/images/iris/warning-icon.png">
      <h5> <b>Incorrect Synchro Code</b> </h5>
      <div>
       <div class="dialogBtnBox">
         <a href="#">OK</a>
         <p>Please enter valid Synchro Code.</p>
       </div>
      </div>
    </div>
     </div> 
  </div>


      <!--
    <form method="POST" name="multiIRISSummaryDownloadForm" id="multiIRISSummaryDownloadForm" action="/iris-summary/pdf-summary!downloadMultiple.jspa"  >
      <input type="hidden" name="multipleIRISSummaryIds" id="multipleIRISSummaryIds" value="">
    </form>
  
    <form method="POST" name="multiIRISSummaryBlurbsDownloadForm" id="multiIRISSummaryBlurbsDownloadForm" action="/iris-summary/pdf-summary!downloadMultipleBlurbs.jspa"  >
      <input type="hidden" name="multipleIRISSummaryBlurbIds" id="multipleIRISSummaryBlurbIds" value="">
    </form>
    
    -->
    
    <form method="POST" name="multiIRISSummaryDownloadForm" id="multiIRISSummaryDownloadForm" action="/iris-summary/pdf-summary!downloadMultiple.jspa"  >
    <input type="hidden" name="multipleIRISSummaryIds" id="multipleIRISSummaryIds" value="">
    <input type="hidden" name="downloadIRISSummary" id="downloadIRISSummary" value="">
    <input type="hidden" name="downloadAttachedReports" id="downloadAttachedReports" value="">
    <input type="hidden" name="downloadBlurbs" id="downloadBlurbs" value="">
    <input type="hidden" name="downloadInsights" id="downloadInsights" value="">
    
    <input type="hidden" name="downloadSearchByEndMarketFilterValues" id="downloadSearchByEndMarketFilterValues" value="">
    <input type="hidden" name="downloadSearchByCategoryFilterValues" id="downloadSearchByCategoryFilterValues" value="">
    <input type="hidden" name="downloadSearchByBrandFilterValues" id="downloadSearchByBrandFilterValues" value="">
    <input type="hidden" name="downloadSearchByMethodologyFilterValues" id="downloadSearchByMethodologyFilterValues" value="">
    <input type="hidden" name="downloadSearchByReportDateFilterValues" id="downloadSearchByReportDateFilterValues" value="">
    <input type="hidden" name="downloadSearchByReportDateFilterCustomStartDate" id="downloadSearchByReportDateFilterCustomStartDate" value="">
    <input type="hidden" name="downloadSearchByReportDateFilterCustomEndDate" id="downloadSearchByReportDateFilterCustomEndDate" value="">
    <input type="hidden" name="downloadSearchWithinFilterValues" id="downloadSearchWithinFilterValues" value="">

    <#--
    <#if searchText??>
      <input type="hidden"  name="searchString" id="searchText2" value='${searchText}'>
    <#else>
      <input type="hidden" name="searchString"  id="downloadInsights" value="">
    </#if>  
    -->
    
    
    <#if searchText?? && searchText?contains("'")>
      
      <input type="hidden"  name="searchString" id="searchText2" value="${searchText}">
    <#elseif searchText??>
      
      <input type="hidden"  name="searchString" id="searchText2" value='${searchText}'>
      
    <#else>
      <input type="hidden" name="searchString"  id="downloadInsights" value="">
    </#if>  
    </form>
    
    
    <form method="POST" name="irisSummaryResultsExcelDownloadForm" id="irisSummaryResultsExcelDownloadForm" action="/iris-summary/search!downloadReport.jspa"  >
    <input type="hidden" name="searchResultIRISSummaryIds" id="searchResultIRISSummaryIds" value="">
    <#--
    <#if searchText??>
      <input type="hidden" name="searchTextUsed" id="searchTextUsed" value='${searchText}'>
    <#else>
      <input type="hidden" name="searchTextUsed" id="searchTextUsed" value="">
    </#if>  
    -->
    
    <#if searchText?? && searchText?contains("'")>
      <input type="hidden"  name="searchTextUsed" id="searchTextUsed" value="${searchText}">
    <#elseif searchText??>
      <input type="hidden"  name="searchTextUsed" id="searchTextUsed" value='${searchText}'>
    <#else>
      <input type="hidden" name="searchTextUsed"  id="searchTextUsed" value="">
    </#if> 
    
    <input type="hidden" name="downloadExcelSearchByEndMarketFilterValues" id="downloadExcelSearchByEndMarketFilterValues" value="">
    <input type="hidden" name="downloadExcelSearchByCategoryFilterValues" id="downloadExcelSearchByCategoryFilterValues" value="">
    <input type="hidden" name="downloadExcelSearchByBrandFilterValues" id="downloadExcelSearchByBrandFilterValues" value="">
    <input type="hidden" name="downloadExcelSearchByMethodologyFilterValues" id="downloadExcelSearchByMethodologyFilterValues" value="">
    <input type="hidden" name="downloadExcelSearchByReportDateFilterValues" id="downloadExcelSearchByReportDateFilterValues" value="">
    <input type="hidden" name="downloadExcelSearchByReportDateFilterCustomStartDate" id="downloadExcelSearchByReportDateFilterCustomStartDate" value="">
    <input type="hidden" name="downloadExcelSearchByReportDateFilterCustomEndDate" id="downloadExcelSearchByReportDateFilterCustomEndDate" value="">
    <input type="hidden" name="downloadExcelSearchWithinFilterValues" id="downloadExcelSearchWithinFilterValues" value="">
    </form>
    
  <#--  <form method="POST" name="irisSummaryResultsSortByForm" id="irisSummaryResultsSortByForm" action="/iris-summary/search-results-open!execute.jspa"  >
  -->
  
  <#if irisURL?? && irisURL?contains("iris-summary/search-results-open!execute.jspa") > 
    <form method="POST" name="irisSummaryResultsSortByForm" id="irisSummaryResultsSortByForm" action="/iris-summary/search-results-open!execute.jspa"  >
  <#elseif irisURL?? && irisURL?contains("iris-summary/search-results-advance!execute.jspa") >    
    <form method="POST" name="irisSummaryResultsSortByForm" id="irisSummaryResultsSortByForm" action="/iris-summary/search-results-advance!execute.jspa"  >
  <#elseif irisURL?? && irisURL?contains("iris-summary/search-results-synchro-code!execute.jspa") >     
    <form method="POST" name="irisSummaryResultsSortByForm" id="irisSummaryResultsSortByForm" action="/iris-summary/search-results-synchro-code!execute.jspa"  >
  </#if>  
     <!-- <input type="hidden" name="sortBy" id="sortBy" value="">-->
    <#--
    <#if searchText??>
      <input type="hidden" name="searchText" id="searchText3" value='${searchText}'>
    <#else>
      <input type="hidden" name="searchText" id="searchText3" value="">
    </#if>  
    -->
    <#if searchText?? && searchText?contains("'")>
      <input type="hidden" name="searchText" id="searchText3" value="${searchText}">
    <#elseif searchText??>
      <input type="hidden" name="searchText" id="searchText3" value='${searchText}'>
    <#else>
      <input type="hidden" name="searchText" id="searchText3" value="">
    </#if> 
    
    </form>

    
  
  <#if irisURL?? && irisURL?contains("iris-summary/search-results-open!execute.jspa") > 
    <form method="POST" name="irisSummaryResultsSearchByFiltersForm" id="irisSummaryResultsSearchByFiltersForm" action="/iris-summary/search-results-open!execute.jspa"  >
  <#elseif irisURL?? && irisURL?contains("iris-summary/search-results-advance!execute.jspa") >    
    <form method="POST" name="irisSummaryResultsSearchByFiltersForm" id="irisSummaryResultsSearchByFiltersForm" action="/iris-summary/search-results-advance!execute.jspa"  >
  <#elseif irisURL?? && irisURL?contains("iris-summary/search-results-synchro-code!execute.jspa") >     
    <form method="POST" name="irisSummaryResultsSearchByFiltersForm" id="irisSummaryResultsSearchByFiltersForm" action="/iris-summary/search-results-synchro-code!execute.jspa"  >
    
    <input type="hidden" id="searchBySynchroId1" name="searchBySynchroId" value="searchBySynchroId">
  </#if>  
    
    <#--
    <#if searchText??>
      <input type="hidden" name="searchText" id="searchText4" value='${searchText}'>
    <#else>
      <input type="hidden" name="searchText" id="searchText4" value="">
    </#if>  
    -->
    
    <#if searchText?? && searchText?contains("'")>
      <input type="hidden" name="searchText" id="searchText4" value="${searchText}">
    <#elseif searchText??>
      <input type="hidden" name="searchText" id="searchText4" value='${searchText}'>
    <#else>
      <input type="hidden" name="searchText" id="searchText4" value="">
    </#if> 
    
    
     <input type="hidden" name="downloadScore" id="downloadScore1" value="">
    
    
    
    <input type="hidden" name="searchByEndMarketFilterValues" id="searchByEndMarketFilterValues" value="">
    <input type="hidden" name="searchByCategoryFilterValues" id="searchByCategoryFilterValues" value="">
    <input type="hidden" name="searchByBrandFilterValues" id="searchByBrandFilterValues" value="">
    <input type="hidden" name="searchByMethodologyFilterValues" id="searchByMethodologyFilterValues" value="">
    <input type="hidden" name="searchByReportDateFilterValues" id="searchByReportDateFilterValues" value="">
    <input type="hidden" name="searchByReportDateFilterCustomStartDate" id="searchByReportDateFilterCustomStartDate" value="">
    <input type="hidden" name="searchByReportDateFilterCustomEndDate" id="searchByReportDateFilterCustomEndDate" value="">
    <input type="hidden" name="searchWithinFilterValues" id="searchWithinFilterValues" value="">
    
    <input type="hidden" name="allOfTheseWords" id="allOfTheseWords" value="">
    
  <input type="hidden" name="noneOfTheseWords" id="noneOfTheseWords" value="">
    <input type="hidden" name="sortBy" id="sortBy" value="">
    <input type="hidden" name="limit" id="limit" value="10">
    <input type="hidden" name="page" id="page" value="1">
    
  </form>
    
    
  

  
      <div class="column right fixRightColumn">
       
                <p class="subHeadText">Sort By</p>
                    <#if sortBy?? && sortBy=="reportDate">
      <div id="relevance-dd" style="border: 1px solid #808080;padding: 1px 8px;cursor: pointer;">
<p style="padding-top: 4px;margin: 2px 0px 3px 0px !important;">Report Date <i  id="relevanceCaret"  class="fa fa-caret-down" aria-hidden="true"></i></p>
         <span style="float: right;position: relative;top: -20px;color: #fff;"></span>                
      </div>
      <div id="relevance-dd-content">
<p onclick="return applySort('relevance');" style="border:1px solid gray;border-top: none;" class="relevance-contnt-dd"><a href="javascript:void(0);"  >Relevance</a></p>
      </div>
    <#else>
    
      <div id="relevance-dd" style="border: 1px solid #808080;padding: 1px 8px;cursor: pointer;">
        <p style="padding-top: 4px;margin: 2px 0px 3px 0px !important;">Relevance<i id="relevanceCaret" class="fa fa-caret-down" aria-hidden="true"></i></p>
          <span style="float: right;position: relative;top: -20px;color: #fff;"></i></span>                
      </div>
      <div id="relevance-dd-content">
         <p onclick="return applySort('reportDate');" style="border:1px solid gray;border-top: none;" class="relevance-contnt-dd"><a href="javascript:void(0);"  >Report Date</a></p>
      </div>
    </#if>
                  
             



 <div class="mt40"> <span id="downloadtext">Downloads </span></div>
   <div id="DownloadContainer">
                      <!--    <p class="checkbox_download"><input type="checkbox" name="IRIS_Summary">   IRIS Summary </input></p>
             <p class="checkbox_download"> <input type="checkbox" name="Attached_Reports"> Attached Reports </input>  </p>
             <p class="checkbox_download"> <input type="checkbox" name="Overview_Blurb"> Overview - Blurb  </input> </p>
             <p class="checkbox_download"><input type="checkbox" name="Overview_Insight"> Overview-Insight   </input></p>
             <p class="checkbox_download"><a href="#"> Start Download   </input></p>
             <p class="">Download all Result in Excel   </input></p>
             <p class="checkbox_download"><a href="#"> Start Download   </input></p> -->
             
          <label class="checkboxContainer makeOpacityFull">IRIS Summary
              <input type="checkbox" id="iris_Summary" name="iris_Summary" class="searchDownloadCheckboxes">
              <span class="checkmark"></span>
          </label>  

          <label class="checkboxContainer makeOpacityFull">Attached Report(s)
               <input type="checkbox" name="attached_Reports" id="attached_Reports" class="searchDownloadCheckboxes">
              <span class="checkmark"></span>
          </label> 

          <label class="checkboxContainer makeOpacityFull">Overview - Blurb
               <input type="checkbox" name="overview_Blurb" id="overview_Blurb" class="searchDownloadCheckboxes">
              <span class="checkmark"></span>
          </label> 

       <#--   <label class="checkboxContainer makeOpacityFull">Overview - Insight
             <input type="checkbox" name="overview_Insight" id="overview_Insight" class="searchDownloadCheckboxes">
              <span class="checkmark"></span>
          </label> 
    -->  

          <div class="borderBottomDownload" style="pointer-events: none;">
            <a style="cursor: default;" href="#" class="textColorBlue" onclick="return downloadIRISSummaries();">
                <img src="${themePath}/images/iris/download-icon.png" width="16" height="18"> 
                <span class="pl8">Start Download</span>
            </a>
          </div>

          <div class="excelIconAlign">
            <img src="${themePath}/images/iris/excel-icon.png">
            <p>Download all results in Excel</p>
          </div>

        <#if irisSummaryList?? && irisSummaryList?size gt 0>
       <div>
        <a href="#" class="textColorBlue" onclick="return downloadIRISSearchResults();">
          <img src="${themePath}/images/iris/download-icon.png" width="16" height="18">
          <span class="pl8">Start Download</span>
        </a>
          </div>
    <#else>
       <div style="opacity:0.6; pointer-events: none;">
            <a href="#" class="textColorBlue" onclick="return downloadIRISSearchResults();">
              <img src="${themePath}/images/iris/download-icon.png" width="16" height="18">
              <span class="pl8">Start Download</span>
            </a>
          </div>
    </#if>
    
     
     
             
                                                                    
              </div>
    
    

    <!--  <a href="javascript:void(0);" id="downloadOption1" style="margin-left: 10px;" onclick="return downloadIRISSummary();" class="publish-details">Download IRIS Summary 1</a>
        <a href="javascript:void(0);" id="downloadOption2" style="margin-left: 10px;" onclick="return downloadIRISSummaryBlurbs();" class="publish-details">Download IRIS Summary 2</a> 
        <a href="javascript:void(0);" id="downloadOption3" style="margin-left: 10px;" onclick="return downloadIRISSearchResults();" class="publish-details">Download all results in excel</a>
    -->

</div>

   </div>




  <!-- BOOLEAN SEARCH Window Starts -->
  
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
  <!-- BOOLEAN SEARCH Window Ends -->


<script>
function downloadIRISSummaries()
{
  
  var iris_Summary=$j("#iris_Summary").prop("checked");
  var attached_Reports=$j("#attached_Reports").prop("checked");
  var overview_Blurb=$j("#overview_Blurb").prop("checked");
  var overview_Insight=$j("#overview_Insight").prop("checked");
  
  if(iris_Summary)
  {
    $j("#downloadIRISSummary").val("yes");
  }
  else
  {
    $j("#downloadIRISSummary").val("no");
  }
  if(attached_Reports)
  {
    $j("#downloadAttachedReports").val("yes");
  }
  else
  {
    $j("#downloadAttachedReports").val("no");
  }
  if(overview_Blurb)
  {
    $j("#downloadBlurbs").val("yes");
  }
  else
  {
    $j("#downloadBlurbs").val("no");
  }
  if(overview_Insight)
  {
    $j("#downloadInsights").val("yes");
  }
  else
  {
    $j("#downloadInsights").val("no");
  }


  var selected = [];
  $j('#iris-results input:checked').each(function() {

    selected.push($j(this).attr('name'));
  
  });


  // Applying the filters
  applyFormFieldsDownload();
  
  
  if(selected.length>0)
  { 

      // if no check box is selecte above download link
     // if(iris_Summary==false &&  attached_Reports==false && overview_Blurb==false  && overview_Insight==false)
      if(iris_Summary==false &&  attached_Reports==false && overview_Blurb==false)
      {

      }
      else
      {
          

           $j("#multipleIRISSummaryIds").val(selected);
           var multiIRISSummaryDownloadForm = jQuery("#multiIRISSummaryDownloadForm");
            multiIRISSummaryDownloadForm.submit();  
       }
  }



}
function downloadIRISSummary()
{
  
  
  var selected = [];
  $j('#iris-results input:checked').each(function() {
    selected.push($j(this).attr('name'));
  
  });
  
  
  if(selected.length>0)
  { 
    showLoader('Please wait...');


    $j("#multipleIRISSummaryIds").val(selected);
    var multiIRISSummaryDownloadForm = jQuery("#multiIRISSummaryDownloadForm");
    multiIRISSummaryDownloadForm.submit();   
    hideLoader();
  }
  else
  {
    dialog({
          title:"",
          html:"<i class='positionSet'></i><p>Please select an IRIS Summary to Download.</p>",

        });
         orangeBtn();
         relPos();
    return false;
  }
  
  
}

function downloadIRISSummaryBlurbs()
{
  
  
  var selected = [];
  $j('#iris-results input:checked').each(function() {
    selected.push($j(this).attr('name'));
  
  });
  
  
  if(selected.length>0)
  { 
    showLoader('Please wait...');
 
        $j("#multipleIRISSummaryBlurbIds").val(selected);
    var multiIRISSummaryBlurbsDownloadForm = jQuery("#multiIRISSummaryBlurbsDownloadForm");
    multiIRISSummaryBlurbsDownloadForm.submit();   
    hideLoader();
  }
  else
  {
    dialog({
          title:"",
          html:"<i class='positionSet'></i><p>Please select an IRIS Summary to Download.</p>",

        });
        orangeBtn();
    relPos();
    return false;
  }
  
  
}

function downloadIRISSearchResults()
{
  
  
  var selected = [];
  <#if fullIrisSummaryList?? && fullIrisSummaryList?size gt 0>
  
    <#list fullIrisSummaryList as irisSummary>
      selected.push(${irisSummary.getIrisSummaryId()?c});
    </#list>
  </#if>
  
  
  
  
  if(selected.length>0)
  { 
    showLoader('Please wait...');
    
    // Applying the filters
    applyFormFieldsDownload();
        $j("#searchResultIRISSummaryIds").val(selected);
    var irisSummaryResultsExcelDownloadForm = jQuery("#irisSummaryResultsExcelDownloadForm");
    irisSummaryResultsExcelDownloadForm.submit();   
    hideLoader();
  }
  else
  {
    
    return false;
  }
  
  
}

function loadLimit()
{
  var plimit = $j("#project-limit").val();
  
  
  applyMoreRecords(plimit);
}


function applyFormFields()
{
  var reportDateFilter = $j("input[name='reportDateFilter']:checked").val();
  
  //alert("reportDateFilter==>"+reportDateFilter);
  
  if(searchResultEndMarketIdArray.length>0)
  { 
      $j("#searchByEndMarketFilterValues").val(searchResultEndMarketIdArray);
  
  }
  
  if(searchResultCategoryIdArray.length>0)
  { 
      $j("#searchByCategoryFilterValues").val(searchResultCategoryIdArray);
  
  }
  
  if(searchResultBrandIdArray.length>0)
  { 
      $j("#searchByBrandFilterValues").val(searchResultBrandIdArray);
  }
  
  if(searchResultMethodologyIdArray.length>0)
  { 
      $j("#searchByMethodologyFilterValues").val(searchResultMethodologyIdArray);
  }
  
  if(searchResultSearchWithinIdArray.length>0)
  { 
      $j("#searchWithinFilterValues").val(searchResultSearchWithinIdArray);
  }
  
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
      
      
  var allOfTheseWords = $j("#ALL_OF_THESE_WORDS").val();
  //alert("allOfTheseWords==>"+allOfTheseWords);
  if(allOfTheseWords!=null && allOfTheseWords!=undefined)
  {
    $j("#allOfTheseWords").val(allOfTheseWords);
  }
  var noneOfTheseWords = $j("#NONE_OF_THESE_WORDS").val();
//  alert("noneOfTheseWords==>"+noneOfTheseWords);
  if(noneOfTheseWords!=null && noneOfTheseWords!=undefined)
  {
    $j("#noneOfTheseWords").val(noneOfTheseWords);
  }
  
      
}

function applyFormFieldsDownload()
{
  var reportDateFilter = $j("input[name='reportDateFilter']:checked").val();
  
  //alert("reportDateFilter==>"+reportDateFilter);
  
  if(searchResultEndMarketIdArray.length>0)
  { 
      $j("#downloadSearchByEndMarketFilterValues").val(searchResultEndMarketIdArray);
    $j("#downloadExcelSearchByEndMarketFilterValues").val(searchResultEndMarketIdArray);
  
  }
  
  if(searchResultCategoryIdArray.length>0)
  { 
      $j("#downloadSearchByCategoryFilterValues").val(searchResultCategoryIdArray);
    $j("#downloadExcelSearchByCategoryFilterValues").val(searchResultCategoryIdArray);
  
  }
  
  if(searchResultBrandIdArray.length>0)
  { 
      $j("#downloadSearchByBrandFilterValues").val(searchResultBrandIdArray);
    $j("#downloadExcelSearchByBrandFilterValues").val(searchResultBrandIdArray);
  }
  
  if(searchResultMethodologyIdArray.length>0)
  { 
      $j("#downloadSearchByMethodologyFilterValues").val(searchResultMethodologyIdArray);
    $j("#downloadExcelSearchByMethodologyFilterValues").val(searchResultMethodologyIdArray);
  }
  
  if(searchResultSearchWithinIdArray.length>0)
  { 
      $j("#downloadSearchWithinFilterValues").val(searchResultSearchWithinIdArray);
    $j("#downloadExcelSearchWithinFilterValues").val(searchResultSearchWithinIdArray);
  }
  
  if(reportDateFilter!=undefined && reportDateFilter.trim()!="")
  { 
      $j("#downloadSearchByReportDateFilterValues").val(reportDateFilter);
    $j("#downloadExcelSearchByReportDateFilterValues").val(reportDateFilter);
    if(reportDateFilter=="Custom")
    {
      var searchByReportDateFilterCustomStartDate = $j("#customReportStartDate").val();
      $j("#downloadSearchByReportDateFilterCustomStartDate").val(searchByReportDateFilterCustomStartDate);
      $j("#downloadExcelSearchByReportDateFilterCustomStartDate").val(searchByReportDateFilterCustomStartDate);
      
      var searchByReportDateFilterCustomEndDate = $j("#customReportEndDate").val();
      $j("#downloadSearchByReportDateFilterCustomEndDate").val(searchByReportDateFilterCustomEndDate);
      $j("#downloadExcelSearchByReportDateFilterCustomEndDate").val(searchByReportDateFilterCustomEndDate);
    }
  }
}

function applySort(sortByValue)
{
  showLoader('Please wait...');
  
  applyFormFields();
  $j("#sortBy").val(sortByValue);
  
  <#-- 
  <#if searchBySynchroId?? && searchBySynchroId=="searchBySynchroId">
    
    $j("#searchBySynchroId").val("searchBySynchroId");
    $j("#searchBySynchroId1").val("searchBySynchroId");
  </#if>
  -->
  
  var irisSummaryResultsSearchByFiltersForm = jQuery("#irisSummaryResultsSearchByFiltersForm");
  irisSummaryResultsSearchByFiltersForm.submit();   
  hideLoader();
}



function applySearchFilters()
{
  applyFormFields();
  var reportDateFilter = $j("input[name='reportDateFilter']:checked").val();
  
  if(searchResultEndMarketIdArray.length>0 || searchResultCategoryIdArray.length>0 || searchResultBrandIdArray.length>0 || searchResultMethodologyIdArray.length>0 || (reportDateFilter!=undefined && reportDateFilter.trim()!="") || preseverdatastatusCheck==true)
  { 
    showLoader('Please wait...');
    
    //alert("Search -->"+$j("#searchText").val());
    var st = $j("#searchText").val()
    //$j("#searchText1").val(st);
    $j("#searchText2").val(st);
    $j("#searchText3").val(st);
    $j("#searchText4").val(st);
    
    <#--
    <#if searchBySynchroId?? && searchBySynchroId=="searchBySynchroId">
    
      $j("#searchBySynchroId").val("searchBySynchroId");
      $j("#searchBySynchroId1").val("searchBySynchroId");
    </#if>
    -->
    
    var irisSummaryResultsSearchByFiltersForm = jQuery("#irisSummaryResultsSearchByFiltersForm");
    irisSummaryResultsSearchByFiltersForm.submit();   
    hideLoader();
  }
  
  else
  {
    return false;
  }
  
}

function applySearchWithinFilters()
{
  applyFormFields();
  var reportDateFilter = $j("input[name='reportDateFilter']:checked").val();
  
  if(searchResultSearchWithinIdArray.length>0 || preserevedatastatusForCheckWithIn==true)
  { 
    showLoader('Please wait...');
    //alert("Search -->"+$j("#searchText").val());
    var st = $j("#searchText").val()
    //$j("#searchText1").val(st);
    $j("#searchText2").val(st);
    $j("#searchText3").val(st);
    $j("#searchText4").val(st);

    <#--
    <#if searchBySynchroId?? && searchBySynchroId=="searchBySynchroId">
      
      $j("#searchBySynchroId").val("searchBySynchroId");
      $j("#searchBySynchroId1").val("searchBySynchroId");
    </#if>
    -->
    
    var irisSummaryResultsSearchByFiltersForm = jQuery("#irisSummaryResultsSearchByFiltersForm");
    irisSummaryResultsSearchByFiltersForm.submit();   
    hideLoader();
  }
  else
  {
    return false;
  }
}

function applyMoreRecords(plimit)
{
  showLoader('Please wait...');
  applyFormFields();
  <#if sortBy??>
    $j("#sortBy").val('${sortBy}');
  </#if>
  
  if(plimit!=undefined && plimit!="")
  {
    $j("#limit").val(plimit);
  }
  else
  {
    <#if limit??>
      $j("#limit").val('${limit}');
    </#if>
  }
  
  <#--
  <#if searchBySynchroId?? && searchBySynchroId=="searchBySynchroId">
    
    $j("#searchBySynchroId").val("searchBySynchroId");
    $j("#searchBySynchroId1").val("searchBySynchroId");
  </#if>
  -->
  
  var irisSummaryResultsSearchByFiltersForm = jQuery("#irisSummaryResultsSearchByFiltersForm");
  irisSummaryResultsSearchByFiltersForm.submit();   
  hideLoader();
}

function clearSearchFilters()
{
  //alert("clearSearchFilters");
  uncheckSearchResultFilters();
  getSearchResultEndMarketValue();
  getSearchResultBrandValue();
  getSearchResultCategoryValue();
  getSearchResultMethodologyValue();
  
  $j("input[name=reportDateFilter]").val(['']);
  $j('#SearchResultDateRange').html('');
  $j('#SearchResultDateRange').css('display','none');
  
  $j("#customReportStartDate").val('');
  $j("#customReportEndDate").val('');
  
  applyFormFields();
  
  //alert("Search -->"+$j("#searchText").val());
    var st = $j("#searchText").val()
    //$j("#searchText1").val(st);
    $j("#searchText2").val(st);
    $j("#searchText3").val(st);
    $j("#searchText4").val(st);
    
  <#--  
  <#if searchBySynchroId?? && searchBySynchroId=="searchBySynchroId">
    
    $j("#searchBySynchroId").val("searchBySynchroId");
    $j("#searchBySynchroId1").val("searchBySynchroId");
  </#if>
  -->
  
  var irisSummaryResultsSearchByFiltersForm = jQuery("#irisSummaryResultsSearchByFiltersForm");
  irisSummaryResultsSearchByFiltersForm.submit();   
  //return false;
  
}

function clearSearchWithInFilters()
{
  
  uncheckSearchResultSearchWithInFilters();
  getSearchResultSearchWithinValue();
  applyFormFields();
  
  //alert("Search -->"+$j("#searchText").val());
    var st = $j("#searchText").val()
    //$j("#searchText1").val(st);
    $j("#searchText2").val(st);
    $j("#searchText3").val(st);
    $j("#searchText4").val(st);
    
  <#--
  <#if searchBySynchroId?? && searchBySynchroId=="searchBySynchroId">
    
    $j("#searchBySynchroId").val("searchBySynchroId");
    $j("#searchBySynchroId1").val("searchBySynchroId");
  </#if>
  -->
  var irisSummaryResultsSearchByFiltersForm = jQuery("#irisSummaryResultsSearchByFiltersForm");
    irisSummaryResultsSearchByFiltersForm.submit();   
}

function clearReportDateFilters()
{
  $j("input[name=reportDateFilter]").val(['']);
  $j('#SearchResultDateRange').html('');
  $j('#SearchResultDateRange').css('display','none');
   $j('#SearchResultStartDateRange').css('display','none');
    $j('#SearchResultEndDateRange').css('display','none');
  
  $j("#customReportStartDate").val('');
  $j("#customReportEndDate").val('');
  return false;
}

function downloadScores()
{
  $j("#downloadScore").val("downloadScore");
  $j("#downloadScore1").val("downloadScore");
  
  
  <#--
  <#if searchBySynchroId?? && searchBySynchroId=="searchBySynchroId">
    
    $j("#searchBySynchroId").val("searchBySynchroId");
    $j("#searchBySynchroId1").val("searchBySynchroId");
  </#if>


  var searchIRISSummaryForm = $j("#searchIRISSummaryForm");
  searchIRISSummaryForm.submit();
  
  
  $j("#downloadScore").val("");
  -->
  
  applyFormFields();
  

  
  showLoader('Please wait...');
    
  //alert("Search -->"+$j("#searchText").val());
  var st = $j("#searchText").val()
  //$j("#searchText1").val(st);
  $j("#searchText2").val(st);
  $j("#searchText3").val(st);
  $j("#searchText4").val(st);
  
  <#--
  <#if searchBySynchroId?? && searchBySynchroId=="searchBySynchroId">
  
    $j("#searchBySynchroId").val("searchBySynchroId");
    $j("#searchBySynchroId1").val("searchBySynchroId");
  </#if>
  -->
  
  var irisSummaryResultsSearchByFiltersForm = jQuery("#irisSummaryResultsSearchByFiltersForm");
  irisSummaryResultsSearchByFiltersForm.submit();   
  hideLoader();
  
  $j("#downloadScore").val("");
  $j("#downloadScore1").val("");
}

/*
$j("#searchText").on("keypress", function (e) {            

    if (e.keyCode == 13) {
        // Cancel the default action on keypress event
        e.preventDefault(); 
        searchIRIS();
    }
});
*/


function vaildateSynchroCodes()
{
  var st = $j("#searchText").val();
  
  
  var isValid = false;
  // We allow * symbol as well for search by synchro code
  // var regex = /^[0-9\s]*$/;
 // var regex = /^[0-9*]*$/;
	var regex = /^[0-9\s*]*$/;
  isValid = regex.test(st);
  if(isValid)
  {
    
	searchIRIS();
  }
  else
  {
    
     
     $j("#dialogOverlay").show();
     return false;
  }
  
}

function searchIRIS()
{
  
  $j("#downloadScore").val("");
  applyFormFields();
  
  <#--
  <#if searchBySynchroId?? && searchBySynchroId=="searchBySynchroId">
    
    $j("#searchBySynchroId").val("searchBySynchroId");
    $j("#searchBySynchroId1").val("searchBySynchroId");
  </#if>
  var searchIRISSummaryForm = $j("#searchIRISSummaryForm");
  searchIRISSummaryForm.submit();
  -->
  
  showLoader('Please wait...');
    
  //alert("Search -->"+$j("#searchText").val());
  var st = $j("#searchText").val()
  //$j("#searchText1").val(st);
  $j("#searchText2").val(st);
  $j("#searchText3").val(st);
  $j("#searchText4").val(st);
  
  <#--
  <#if searchBySynchroId?? && searchBySynchroId=="searchBySynchroId">
  
    $j("#searchBySynchroId").val("searchBySynchroId");
    $j("#searchBySynchroId1").val("searchBySynchroId");
  </#if>
  -->
  
  if(st==null ||st=="")
  {
   
    hideLoader();
    return false;

  }
  else
  {
         
     
      showLoader('Please wait...'); 
      
           

          setTimeout(function(){
             submitForm();
           },400)
     
  } 

  
}
 function submitForm()
   {
    
    var irisSummaryResultsSearchByFiltersForm = $j("#irisSummaryResultsSearchByFiltersForm");
        irisSummaryResultsSearchByFiltersForm.submit();
  } 


      
  <#if pages?? && (pages>0)>
    var pages = ${pages};
  <#else>
    var pages = 1;
    </#if>
  
  <#if page?? && (page > 0)>
    currPage = ${page};
  </#if>
  
 
  
  function processPaginationRequest(page,keyword, limit)
  {
    showLoader('Please wait...');
    currPage = page;
    applyFormFields();
    <#if sortBy??>
      $j("#sortBy").val('${sortBy}');
    </#if>
    
    if(limit!=undefined && limit!="")
    {
      $j("#limit").val(limit);
    }
    else
    {
      <#if limit??>
        $j("#limit").val('${limit}');
      </#if>
    }
    
    if(page!=undefined && page!="")
    {
      $j("#page").val(page);
    }
    else
    {
      <#if page??>
        $j("#page").val('${page}');
      </#if>
    }
    
    <#--
    <#if searchBySynchroId?? && searchBySynchroId=="searchBySynchroId">
      
      $j("#searchBySynchroId").val("searchBySynchroId");
      $j("#searchBySynchroId1").val("searchBySynchroId");
    </#if>
    -->
    
    var irisSummaryResultsSearchByFiltersForm = jQuery("#irisSummaryResultsSearchByFiltersForm");
    irisSummaryResultsSearchByFiltersForm.submit();   
    hideLoader();
  }
  


  
</script>

<script src="${themePath}/js/pagination.custom.js" type="text/javascript"></script>
<script>

 $j(document).ready(function() {
 
 // JS for Advance Filter top and bottom hover effect
		 $j('#filterBoxContent li').hover(function(){

			var selectedFilter = $j(this).text();
			
			if(selectedFilter=="Brand" || selectedFilter=="Methodology" || selectedFilter=="Category" || selectedFilter=="End Market" ||  selectedFilter=="Report Date Range")
			{
			
				$j(this).css('margin','0px');
				$j(this).find('a').css('margin-left','6px');
				$j(this).prev().prev('li').css('margin','0px');
				$j(this).prev().prev('li').find('a').css('margin-left','6px');
			}	

		},function(){
			var selectedFilter = $j(this).text();
			if(selectedFilter=="Brand" || selectedFilter=="Methodology" || selectedFilter=="Category" || selectedFilter=="End Market" ||  selectedFilter=="Report Date Range")
			{
				$j(this).css('margin','0px 6px');
				$j(this).find('a').css('margin-left','0px');
				$j(this).prev().prev('li').css('margin','0px 6px');
				$j(this).prev().prev('li').find('a').css('margin-left','0px');
			}	
		});
 
	 $j('#search-with-in li').hover(function(){

		var selectedFilter = $j(this).text();
		if(selectedFilter=="Search Within")
		{
			$j(this).css('margin','0px');
			$j(this).find('a').css('margin-left','6px');
		}	
	 
	 
	},function(){
		var selectedFilter = $j(this).text();
		if(selectedFilter=="Search Within")
		{
			$j(this).css('margin','0px 6px');
			$j(this).find('a').css('margin-left','0px');
		}	
	});
	
 
 
 
 
 
 
 
    // Check if body height is higher than window height :)

     // $j('.customReportRange').click(function(){
            
     //         $j('#searchResultClosePopupIfCustomSelect').addClass('pointerEventsNone');
     // });

     checkScrollYStatus=false;

    var hasVScroll = document.body.scrollHeight > document.body.clientHeight;
    if (hasVScroll) {
      checkScrollYStatus  =true;  
    }

else
{
   
 $j('body').css('overflow-y','hidden');
 checkScrollYStatus  =false; 
}
   
changePointerEventInitial();


});


jQuery(document).ready(function($) {

  $j('.searchResultDeselectAll').prop('checked',true);

 if (window.history && window.history.pushState) {

   //alert("JJ");
    window.history.pushState('forward', null, null);

    $j(window).on('popstate', function() {
    
      
      <#if irisURL?? && irisURL?contains("iris-summary/search-results-open!execute.jspa") > 
        location.href="/iris-summary/search!input.jspa";
        window.history.pushState('forward', null, "/iris-summary/search!input.jspa");
      <#elseif irisURL?? && irisURL?contains("iris-summary/search-results-advance!execute.jspa") >    
        location.href="/iris-summary/advance-search!input.jspa";
        window.history.pushState('forward', null, "/iris-summary/advance-search!input.jspa");
      <#elseif irisURL?? && irisURL?contains("iris-summary/search-results-synchro-code!execute.jspa") >     
        location.href="/iris-summary/search-synchroId!input.jspa";
        window.history.pushState('forward', null, "/iris-summary/search-synchroId!input.jspa");
      </#if>  
      
      
    
    });

  }
});

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
      
      //  $j("#searchText").val('');
      $j("#advanceSearchMainInputbox").html('');
      $j("#advanceSearchMainInputbox").val('');
      $j("#ALL_OF_THESE_WORDS").val('');
      $j("#NONE_OF_THESE_WORDS").val('');
      $j("#ANY_OF_THESE_WORDS").val('');
      $j("#THE_EXACT_PHARSE").val('');
      
    }); 
    
    $j('[data-popup-boolean-search]').on('click', function(e) {

      $j("#AdvancedSearchPopup").css('display','block');
      recodeSearchString();
      var targeted_popup_class = jQuery(this).attr('data-popup-boolean-search');
      $j('[boolean-search="' + targeted_popup_class + '"]').fadeIn(350);
      e.preventDefault();
    });
    
    $j("div.blurbTextDynamic").each(function(i){
       // len=$j(this).find('ul li').text().length;
        len=$j(this).text().length;
      console.log("Length==>"+len);
        if(len>500)
        {

          $j(this).text($j(this).text().substr(0,500)+'...'+'\n');
          $j(this).attr('title'); 
        }
        else{
               $j(this).removeAttr('title');
        }
      });
</script> 
<script type="text/javascript">
  
 var rowLength = $j('.searchResultContentBox .searchResultInnerWrap').length - 1;
  $j('.searchResultContentBox .searchResultInnerWrap').eq(rowLength).find('.popupViewInsight').css({'top':'-80px'});

  var rowLengthSecondLast = $j('.searchResultContentBox .searchResultInnerWrap').length - 2;
  $j('.searchResultContentBox .searchResultInnerWrap').eq(rowLengthSecondLast).find('.popupViewInsight').css({'top':'48%'});

 
 $j('.dialogBoxWrap .dialogBtnBox a').click(function(){
         $j('#dialogOverlay').hide();
   });




 function deSelectAllOptions()
 {



    $j('.searchResultInnerWrap .searchResultHoverCheckbox').each(function(){
                    
                 $j('.searchResultHoverCheckbox').prop('checked',false);
        
                 $j(this).parent().removeAttr('style');
                 $j('#DownloadContainer label').css({'opacity':'0.5','pointer-events':'none'});
      
            });



    ($j('.borderBottomDownload a').css('opacity','0.6'));
        
                 
                $j("#iris_Summary").attr("checked",false);
                  $j("#attached_Reports").attr("checked",false);
                $j("#overview_Blurb").attr("checked",false);
                $j("#overview_Insight").attr("checked",false);
                 
                 ($j('.borderBottomDownload a').css('pointer-events','none'));

                ($j('.borderBottomDownload a').css('cursor','default'));

 $j('#DownloadContainer label').css({'opacity':'0.5','pointer-events':'none'});
  $j('.checkboxContainer.deselectResult').css('display','none');


               
  }                     

</script>