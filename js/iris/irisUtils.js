
 var checkScrollYStatus=false;

var demoArr1 = [];
var EndMarketArray = [];

var searchResultSearchWithinArray = [];
var searchResultSearchWithinIdArray = [];

var searchResultEndMarketArray = [];
var searchResultEndMarketIdArray = [];

var searchResultCategoryArray = [];
var searchResultCategoryIdArray = [];

var searchResultBrandArray = [];
var searchResultBrandIdArray = [];

var searchResultMethodologyArray = [];
var searchResultMethodologyIdArray = [];

var advanceSearchWithinArray = [];
var advanceSearchWithinIdArray = [];

var advanceSearchEndMarketArray = [];
var advanceSearchEndMarketIdArray = [];

var advanceSearchBrandArray = [];
var advanceSearchBrandIdArray = [];

var advanceSearchMethodologyArray = [];
var advanceSearchMethodologyIdArray = [];

var advanceSearchCategoryArray = [];
var advanceSearchCategoryIdArray = [];

var showAllFiltersAdvanceSearchFlag=false;
var showEndMarketFilterAdvanceSearchFlag=false;
var showBrandFilterAdvanceSearchFlag=false;
var showMethodologyFilterAdvanceSearchFlag=false;
var showCategoryFilterAdvanceSearchFlag=false;
var showReportDateFilterAdvanceSearchFlag=false;

var checkAdvanceBrandFilterSelectValues=false;
var checkAdvanceMethodologyFilterSelectValues=false;

var checkAdvanceCategoryFilterSelectValues=false;

var checkAdvanceEndMarketFilterSelectValues=false;

 var checkAdvanceApplyFilterContainer=false;



//var checkAdvanceBrandFilterSelectValues=false;





$j(document).ready(function() {

    UncheckAll();

    /*Start script For, as user write on search field Of multi checkbox then hide select all option */
    $j('#txtList').keyup(function() {

        if ($j(this).val() == '') {
            $j('#hideselectall').show();
        } else {
            $j('#hideselectall').hide();
        }
    });
    /*End script For, as user write on search field Of multi checkbox then hide select all option */


    $j(".search-within-popup-advance-search").click(function() {
		
        getAdvanceSearchWithinValue();
    });
	
	$j('.open-filter-section').click(function(){


         $j('.advanceSearchFilterContainer').css('display','block');
		 
		if (advanceSearchEndMarketIdArray.length != 0)
		{
			$j('#advance-search-end-market').css({"background-color": "#3c9b86", "color": "#fff"});
		}
		else
		{
			$j('#advance-search-end-market').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
		}	
		
		if (advanceSearchBrandIdArray.length != 0)
		{
			$j('#advance-search-brand').css({"background-color": "#3c9b86", "color": "#fff"});
			
		}
		else
		{
			$j('#advance-search-brand').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
		}
		
		if (advanceSearchMethodologyIdArray.length != 0)
		{
			$j('#advance-search-methodology').css({"background-color": "#3c9b86", "color": "#fff"});
		}
		else
		{
			$j('#advance-search-methodology').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
		}
		
		if (advanceSearchCategoryIdArray.length != 0)
		{
			$j('#advance-search-category').css({"background-color": "#3c9b86", "color": "#fff"});
		}
		else
		{
			$j('#advance-search-category').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
		}
		
		 showAllFiltersAdvanceSearchFlag=true;
    });
	
	
	$j(".advance-search-end-market-popup").click(function() {
		showEndMarketFilterAdvanceSearchFlag=true;
		showAllFiltersAdvanceSearchFlag=true;
		getAdvanceSearchEndMarketValue();
    });

    $j("#advance-search-end-market-popup").click(function() {
		showEndMarketFilterAdvanceSearchFlag=true;
		showAllFiltersAdvanceSearchFlag=true;	
    });
	
	$j(".advance-search-brand-popup").click(function() {
		   showBrandFilterAdvanceSearchFlag=true;
		    showAllFiltersAdvanceSearchFlag=true;
 	   getAdvanceSearchBrandValue();
    });

    $j("#advance-search-brand-popup").click(function() {
		   showBrandFilterAdvanceSearchFlag=true;
		  showAllFiltersAdvanceSearchFlag=true;	  	   	 
    });


	$j(".advance-search-methodology-popup").click(function() {
		showMethodologyFilterAdvanceSearchFlag=true;
		showAllFiltersAdvanceSearchFlag=true;
		getAdvanceSearchMethodologyValue();
    });

    $j("#advance-search-methodology-popup").click(function() {
		showMethodologyFilterAdvanceSearchFlag=true;
		showAllFiltersAdvanceSearchFlag=true;
		
    });
	
	$j(".advance-search-category-popup").click(function() {
		showCategoryFilterAdvanceSearchFlag=true;
		showAllFiltersAdvanceSearchFlag=true;
		getAdvanceSearchCategoryValue();
    });

    $j("#advance-search-category-popup").click(function() {
		showCategoryFilterAdvanceSearchFlag=true;
		showAllFiltersAdvanceSearchFlag=true;
		
    });
	
	$j(".advance-search-report-date-popup").click(function() {
		showReportDateFilterAdvanceSearchFlag=true;
		showAllFiltersAdvanceSearchFlag=true;
		//getAdvanceSearchCategoryValue();
       
    });


    $j("#advance-search-report-date-popup").click(function() {
		showReportDateFilterAdvanceSearchFlag=true;
		showAllFiltersAdvanceSearchFlag=true;
		
       
    });

    /*Start script to check all checkboxes*/
    $j("#ckbCheckAll, #ckbCheckAll-filter-brand").click(function() {
        $j(".checkBoxClass").prop('checked', $j(this).prop('checked'));
    });
	$j("#searchResultMethodologySelectAll").click(function() {
        $j(".methodologycheckBoxClass").prop('checked', $j(this).prop('checked'));




    });
	$j("#searchResultCategorySelectAll").click(function() {
        $j(".categorycheckBoxClass").prop('checked', $j(this).prop('checked'));
    });
	$j("#searchResultBrandSelectAll").click(function() {
        $j(".brandcheckBoxClass").prop('checked', $j(this).prop('checked'));
    });
	$j("#searchResultEndMarketSelectAll").click(function() {
        $j(".endMarketcheckBoxClass").prop('checked', $j(this).prop('checked'));
    });
	$j("#searchResultSearchWithinSelectAll").click(function() {
        $j(".searchWithinCheckBoxClass").prop('checked', $j(this).prop('checked'));
    });
	
	
	/*End script to check all checkboxes*/
	
	/* Start Script for Select ALL Search Within Boxes on Advance Search page */
	$j("#searchWithinSelectAll").click(function() {
        $j(".advancesearchWithinCheckBoxClass").prop('checked', $j(this).prop('checked'));
/*	if(!$j(this).prop('checked'))
		{
			$j('.search-in-style').fadeOut(1);
		} */
    });
	/*End script for Select ALL Search Within Boxes on Advance Search page*/
	
	/* Start Script for Select ALL End Market  on Advance Search page */
	$j("#advanceSearchEndMarketSelectAll").click(function() {
        $j(".advanceSearchEndMarketCheckBoxClass").prop('checked', $j(this).prop('checked'));
    });
	$j("#advanceSearchBrandSelectAll").click(function() {
        $j(".advanceSearchBrandCheckBoxClass").prop('checked', $j(this).prop('checked'));
    });
	$j("#advanceSearchMethodologySelectAll").click(function() {
        $j(".advanceSearchMethodologyCheckBoxClass").prop('checked', $j(this).prop('checked'));
    });
	$j("#advanceSearchCategorySelectAll").click(function() {
        $j(".advanceSearchCategoryCheckBoxClass").prop('checked', $j(this).prop('checked'));
    });
	/*End script for Select ALL End Market  on Advance Search page*/
    
    
	

    /*Start script For popup*/
    $j('[data-popup-searchwithin]').on('click', function(e) {

		
		$j('.txtListOnPopup').val('');
        filter('');
      // $j('.search-in-style').hide();
        var targeted_popup_class = jQuery(this).attr('data-popup-searchwithin');
        $j('[search-within="' + targeted_popup_class + '"]').fadeIn(350);
        e.preventDefault();
    });


	
    
	/*
	$j('[data-popup-boolean-search]').on('click', function(e) {


			recodeSearchString();
			var targeted_popup_class = jQuery(this).attr('data-popup-boolean-search');
			$j('[boolean-search="' + targeted_popup_class + '"]').fadeIn(350);
			e.preventDefault();
		});
*/

    $j('[data-popup-close]').on('click', function(e) {


		
		if (advanceSearchEndMarketIdArray.length != 0)
		{
			$j('#advance-search-end-market').css({"background-color": "#3c9b86", "color": "#fff"});

			 // $j('#advance-search-end-market').hover(function(){ $j(this).find(".error").css("display","block"); },function(){ $j(this).find(".error").css("display","none"); });
		}
		else
		{
			$j('#advance-search-end-market').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});

			// $j('#advance-search-end-market').hover(function(){ $j(this).find(".error").css("display","none"); });
		}
		
		if (advanceSearchBrandIdArray.length != 0)
		{
			$j('#advance-search-brand').css({"background-color": "#3c9b86", "color": "#fff"});
             

		}
		else
		{
			$j('#advance-search-brand').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
              			
		}
		
		if (advanceSearchMethodologyIdArray.length != 0)
		{
			$j('#advance-search-methodology').css({"background-color": "#3c9b86", "color": "#fff"});

			// $j('#advance-search-methodology').hover(function(){ $j(this).find(".error").css("display","block"); },function(){ $j(this).find(".error").css("display","none"); });
		}
		else
		{
			$j('#advance-search-methodology').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});

			 // $j('#advance-search-methodology').hover(function(){ $j(this).find(".error").css("display","none"); });
		}
		
		if (advanceSearchCategoryIdArray.length != 0)
		{
			$j('#advance-search-category').css({"background-color": "#3c9b86", "color": "#fff"});

			// $j('#advance-search-category').hover(function(){ $j(this).find(".error").css("display","block"); },function(){ $j(this).find(".error").css("display","none"); });
		}
		else
		{
			$j('#advance-search-category').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});

			 // $j('#advance-search-category').hover(function(){ $j(this).find(".error").css("display","none"); });
		}
					
		showAllFiltersAdvanceSearchFlag = true;
		
    });



 // mouse over for   advance brand filter
$j('#advance-search-brand').mouseover(function(){
   
       if(advanceSearchBrandIdArray.length == 0)
       {
       
          $j('#advance-search-brand .error').css("display","none");          
        }
        else
        {
        	  
        	   $j('#advance-search-brand .error').css("display","block");   	
        }            
});

$j('#advance-search-brand').mouseleave(function(){
         
          $j('#advance-search-brand .error').css("display","none");                        
});



// mouse over for   advance methodology filter
$j('#advance-search-methodology').mouseover(function(){
   
       if(advanceSearchMethodologyIdArray.length == 0)
       {
      
          $j('#advance-search-methodology .error').css("display","none");          
        }
        else
        {
        	 
        	   $j('#advance-search-methodology .error').css("display","block");   	
        }            
});

$j('#advance-search-methodology').mouseleave(function(){
        
          $j('#advance-search-methodology .error').css("display","none");                        
});



// mouse over for   advance end-market filter

$j('#advance-search-end-market').mouseover(function(){
   
       if(advanceSearchEndMarketIdArray.length == 0)
       {
       
          $j('#advance-search-end-market .error').css("display","none");          
        }
        else
        {
        	  
        	   $j('#advance-search-end-market .error').css("display","block");   	
        }            
});

$j('#advance-search-end-market').mouseleave(function(){
         
          $j('#advance-search-end-market .error').css("display","none");                        
});



// mouse over for   advance category filter
$j('#advance-search-category').mouseover(function(){
   
       if(advanceSearchCategoryIdArray.length == 0)
       {
       
          $j('#advance-search-category .error').css("display","none");          
        }
        else
        {
        	 
        	   $j('#advance-search-category .error').css("display","block");   	
        }            
});

$j('#advance-search-category').mouseleave(function(){
        
          $j('#advance-search-category .error').css("display","none");                        
});




// mouse over for   advance date filter

$j('#advance-search-report-date').mouseover(function(){
        if($j('#selected-advance-search-report-date').text()=="")
        {
      
          $j('#advance-search-report-date .error').css("display","none");          
        }
        else
        {
        	
        	   $j('#advance-search-report-date .error').css("display","block"); 
        	   
        }            
});

$j('#advance-search-report-date').mouseleave(function(){
         
          $j('#advance-search-report-date .error').css("display","none");                        
});





    /*End script For popup*/
 // $j('#advance-search-brand').hover(function(){
	// 		o	$j(this).css("background-color", "yellow");
	// 		});


    /*Start script For search In popup hide to click on outside popup */
    $j(document).click(function(e) {

   
    if($j(".calendar").is(':visible'))
	{

	   return;
	}



       var blankDatacheckWhenPopUpsNotSelectedAnyData=false;
      
       
// Start of code for advance search page popup if click outside popup then popup fadeout(hide)
	        if (advanceSearchBrandIdArray.length != 0 && $j(e.target).attr('id') == 'advance-search-brand-popup') 
	         {	  

                   
	            $j('#advance-search-brand-popup').fadeOut(350);
	            $j('#advance-search-brand').css({"background-color": "#3c9b86", "color": "#fff"});

	        
	         }

	          if (advanceSearchBrandIdArray.length == 0 && $j(e.target).attr('id') == 'advance-search-brand-popup') 
	         {	 
               
             
                blankDatacheckWhenPopUpsNotSelectedAnyData=true;
	            $j('#advance-search-brand-popup').fadeOut(350);

	           
	           // Brand Color converted into gray, when no brand is selected from menu..
	            $j('#advance-search-brand').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});



	           	            
	         }

	      

            if (advanceSearchMethodologyIdArray.length != 0 && $j(e.target).attr('id') == 'advance-search-methodology-popup')
             {        
	            $j('#advance-search-methodology-popup').fadeOut(350);
	            $j('#advance-search-methodology').css({"background-color": "#3c9b86", "color": "#fff"});
             } 
               if (advanceSearchMethodologyIdArray.length == 0 && $j(e.target).attr('id') == 'advance-search-methodology-popup')
             { 
                   blankDatacheckWhenPopUpsNotSelectedAnyData=true; 
	               $j('#advance-search-methodology-popup').fadeOut(350);
	               // methodology Color converted into gray, when no brand is selected from menu..
	               $j('#advance-search-methodology').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
	          
             } 
           
            if (advanceSearchEndMarketIdArray.length != 0 && $j(e.target).attr('id') == 'advance-search-end-market-popup') 
            {         
	            $j('#advance-search-end-market-popup').fadeOut(350);
	            $j('#advance-search-end-market').css({"background-color": "#3c9b86", "color": "#fff"});
            } 
             if (advanceSearchEndMarketIdArray.length == 0 && $j(e.target).attr('id') == 'advance-search-end-market-popup') 
            	{       
                   blankDatacheckWhenPopUpsNotSelectedAnyData=true; 
	            $j('#advance-search-end-market-popup').fadeOut(350);
	            // end-market Color converted into gray, when no brand is selected from menu..
	               $j('#advance-search-end-market').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
	          
           		 } 
           
      
            if (advanceSearchCategoryIdArray.length != 0 && $j(e.target).attr('id') == 'advance-search-category-popup') 
	        {         
	            $j('#advance-search-category-popup').fadeOut(350);
	            $j('#advance-search-category').css({"background-color": "#3c9b86", "color": "#fff"});
	        } 
	         if (advanceSearchCategoryIdArray.length == 0 && $j(e.target).attr('id') == 'advance-search-category-popup') 
	       		 { 
	       		     blankDatacheckWhenPopUpsNotSelectedAnyData=true;      
	              $j('#advance-search-category-popup').fadeOut(350);
	              // category Color converted into gray, when no brand is selected from menu..
	               $j('#advance-search-category').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});

	            
	       	 } 
	      

             if($j(e.target).attr('id') == 'advance-search-report-date-popup')
              {

           	  
	            if($j('#advance-search-report-date-popup').is(':visible'))
	            {
	            	
	                  	
					var selValue = ($j("input[class='dateRange']:checked").val());

	                    if(selValue=="custom" || selValue=="Custom")
	                    {
	                        

	                        var customReportStartDate = $j("#customReportStartDate").val();   
	                         var customReportEndDate = $j("#customReportEndDate").val();  
	                        
	                          
	                          if(customReportStartDate=="" || customReportEndDate=="")
	                          {			                              
	                          		
	                          		return;
	                          	
	                          }
	                          else
	                          {
	                          	$j('#advance-search-report-date-popup').fadeOut(350);                     	
	                          }
	                    }
	                    else
	                    {
	                    
	                    	$j('#advance-search-report-date-popup').fadeOut(350);
	                    }

	                   
	            }
	             setAdvanceSearchReportDateFilters();

                   
           } 
          

// End of code for advance search page popup if click outside popup then popup fadeout(hide)






    
		if (advanceSearchWithinIdArray.length != 0 && $j(e.target).attr('class') == 'popup') {
            $j('.search-in-style').fadeIn(500);
            $j('.popup').fadeOut(500);
            
        }
        
        //  For  search Result Page..........

        else if ($j(e.target).attr('class') == 'popup') {
			if($j('#searchResultClosePopup').is(':visible'))
            {
            	
				var selValue = ($j("input[class='dateRange']:checked").val());

                    if(selValue=="custom" || selValue=="Custom")
                    {
                        
                     

                        var customReportStartDate = $j("#customReportStartDate").val();   
                         var customReportEndDate = $j("#customReportEndDate").val();  
                        
                          if(customReportStartDate=="" || customReportEndDate=="")
                          {
                              
                          		return;
                          }
                          else
                          {

                          	$j('.popup').fadeOut(500);                     	
                          }

                    }
                    else
                    {
                    	// alert(2);
                    	$j('.popup').fadeOut(500);
                    }

                   
            }
            else
            {
            	$j('.popup').fadeOut(500);
            	//fade out search with in header when unselect "selectAll" option on Pop up Menu
            	$j('.search-in-style').fadeOut(300);

             }



               setTimeout(function(){ addRemove(); }, 500);
				changePointerEvent();
          	           
        }
		 //      click on advance Filter Container
       			

		if(e.target.id=='advance-search-end-market')
		{
			showEndMarketFilterAdvanceSearchFlag=true;
			showAllFiltersAdvanceSearchFlag=true;
			$j('#advance-search-end-market-popup').fadeIn(500);
			 $j('.txtListOnPopup').val('');
             		 filter('');
		}
		
		if(e.target.id=='advance-search-brand')
		{
			
			showBrandFilterAdvanceSearchFlag=true;
			showAllFiltersAdvanceSearchFlag=true;
			$j('#advance-search-brand-popup').fadeIn(500);
			$j('.txtListOnPopup').val('');
			
			filter('');	
		}
		
		if(e.target.id=='advance-search-methodology')
		{
			showMethodologyFilterAdvanceSearchFlag=true;
			showAllFiltersAdvanceSearchFlag=true;
			$j('#advance-search-methodology-popup').fadeIn(500);
			$j('.txtListOnPopup').val('');
			
			filter('');	
		}
		
		if(e.target.id=='advance-search-category')
		{
			showCategoryFilterAdvanceSearchFlag=true;
			showAllFiltersAdvanceSearchFlag=true;
			$j('#advance-search-category-popup').fadeIn(500);
			$j('.txtListOnPopup').val('');
			
			filter('');	
		}
		
		if(e.target.id=='advance-search-report-date')
		{
			showReportDateFilterAdvanceSearchFlag=true;
			showAllFiltersAdvanceSearchFlag=true;
			$j('#advance-search-report-date-popup').fadeIn(500);
			$j('.txtListOnPopup').val('');
			
			filter('');	
		}


		// $j('li.advance-filter-subhead-brand').find('.error').on('click', function(){ 

  //                               alert("you clicked cross on document");  

		// 	});


		
		// if (showAllFiltersAdvanceSearchFlag==true )
		// {
		// 	 $j('.advanceSearchFilterContainer').css('display','block');
		// 	 showAllFiltersAdvanceSearchFlag=false;
		// 	 $j('.advance-search-filter-container').hide();
		// }
		// else
		// {
			
		// 	if($j('.advance-search-end-market-popup').is(":visible") )
		// 	{
		// 		showAllFiltersAdvanceSearchFlag=true;
		// 		$j('.advance-search-filter-container').hide();
		// 	}
		// 	else if($j('.advance-search-brand-popup').is(":visible") )
		// 	{
		// 		  alert("click on cross");
		// 		showAllFiltersAdvanceSearchFlag=true;
		// 		$j('.advance-search-filter-container').hide();
		// 	}
		// 	else if($j('.advance-search-methodology-popup').is(":visible") )
		// 	{
		// 		showAllFiltersAdvanceSearchFlag=true;
		// 		$j('.advance-search-filter-container').hide();
		// 	}
		// 	else if($j('.advance-search-category-popup').is(":visible") )
		// 	{
		// 		showAllFiltersAdvanceSearchFlag=true;
		// 		$j('.advance-search-filter-container').hide();
		// 	}
		// 	else if($j('.advance-search-report-date-popup').is(":visible") )
		// 	{
		// 		showAllFiltersAdvanceSearchFlag=true;
		// 		$j('.advance-search-filter-container').hide();
		// 	}
		// 	else
		// 	{
				
		// 		if (advanceSearchEndMarketIdArray.length == 0 && advanceSearchBrandIdArray.length == 0 && advanceSearchMethodologyIdArray.length == 0 && advanceSearchCategoryIdArray.length == 0)
		// 		{
		// 			var reportDateFilter = $j("input[name='reportDateFilter']:checked").val();
		// 			if(reportDateFilter!=undefined && reportDateFilter.trim()!="")
		// 			{
		// 				$j('.advance-search-filter-container').show();
						
		// 			}
		// 			else
		// 			{
		// 				$j('.advance-search-filter-container').hide();
		// 			}
		// 		}
		// 		else
		// 		{
		// 			$j('.advance-search-filter-container').show();	
		// 		}
				
		// 	}
			
			
		// }
	
	//	changePointerEvent();
        



	
		
		if(showEndMarketFilterAdvanceSearchFlag==true)
		{
			
		}
		else
		{
			
			$j('#advance-search-end-market-popup').fadeOut(500);
			showEndMarketFilterAdvanceSearchFlag=false;
		}
		
		if(showBrandFilterAdvanceSearchFlag==true)
		{

			
		}
		else
		{
			

			$j('#advance-search-brand-popup').fadeOut(500);
			showBrandFilterAdvanceSearchFlag=false;
			
		}
		
		if(showMethodologyFilterAdvanceSearchFlag==true)
		{
			
		}
		else
		{
			$j('#advance-search-methodology-popup').fadeOut(500);
			showMethodologyFilterAdvanceSearchFlag=false;
		}
		
		if(showCategoryFilterAdvanceSearchFlag==true)
		{
			
		}
		else
		{
			$j('#advance-search-category-popup').fadeOut(500);
			showCategoryFilterAdvanceSearchFlag=false;
   
		}
		
		if(showReportDateFilterAdvanceSearchFlag==true)
		{
			
		}
		else
		{
	     	         $j('#advance-search-report-date-popup').fadeOut(500);
		        	 showReportDateFilterAdvanceSearchFlag=false;
		}


       // if array data available in   advance filters
       if(checkAdvanceSearchAllFilltersArrayData()==true  || checkAdvanceSearchDateFilterSelectedValues()==true)
        {
          
           

         }
       else
       {
         
       
             // alert("yes here"+blankDatacheckWhenPopUpsNotSelectedAnyData);

       // check event on apply filters and choose filters click event.
      // blankDatacheckWhenPopUpsNotSelectedAnyData=true||


       	  if(checkAdvanceApplyFilterContainer==true||blankDatacheckWhenPopUpsNotSelectedAnyData==true||checkAdvanceMethodologyFilterSelectValues==true||  checkAdvanceCategoryFilterSelectValues==true
       	  	|| checkAdvanceEndMarketFilterSelectValues==true||  checkAdvanceBrandFilterSelectValues==true
       	  	||showAllFiltersAdvanceSearchFlag==true||showEndMarketFilterAdvanceSearchFlag==true 
       	  	|| showBrandFilterAdvanceSearchFlag==true ||showMethodologyFilterAdvanceSearchFlag==true
       	  	||showCategoryFilterAdvanceSearchFlag==true||showReportDateFilterAdvanceSearchFlag==true)
          
          {


             showAllFiltersAdvanceSearchFlag=false;
             showEndMarketFilterAdvanceSearchFlag=false;
             showBrandFilterAdvanceSearchFlag=false;
             showMethodologyFilterAdvanceSearchFlag==false;
             showCategoryFilterAdvanceSearchFlag==false;
             showReportDateFilterAdvanceSearchFlag==false;
             checkAdvanceBrandFilterSelectValues=false;
             checkAdvanceMethodologyFilterSelectValues=false;
 			 checkAdvanceCategoryFilterSelectValues=false;
 			 checkAdvanceEndMarketFilterSelectValues=false;
 			 blankDatacheckWhenPopUpsNotSelectedAnyData=false;
 			 checkAdvanceApplyFilterContainer=false;
 		



          }
            else
            {
                $j('.advanceSearchFilterContainer').fadeOut(350); 	
            }

           

       }

        showAllFiltersAdvanceSearchFlag=false;

       showEndMarketFilterAdvanceSearchFlag=false;

        showBrandFilterAdvanceSearchFlag=false;

        showMethodologyFilterAdvanceSearchFlag=false;

        showCategoryFilterAdvanceSearchFlag=false;
        showReportDateFilterAdvanceSearchFlag=false;


		showFilterScroller();

    });
    /*End script For search In popup hide to click on outside popup */

	

   // click on advace Filters popup
	$j('.advanceSearchFilterContainer').click(function()
			{
				

				checkAdvanceApplyFilterContainer=true;
			});
		    




    /*start filter script*/







    $j(".filter-inner-boxes").on("click", function() {
        $j(this).css({ "background": "#a0a2a5", 'color': '#ffffff' });

    });




  /*Start script For filter popup*/
        $j('[data-popup-endmarket]').on('click', function(e) {
	ieTest();
 $j('.searchResultOuterWrap .column.left').addClass('searchResultLeftColumnHeight');
            var targeted_popup_class = jQuery(this).attr('data-popup-endmarket');
            $j('[end-market="' + targeted_popup_class + '"]').fadeIn(350);
	   $j('.txtListOnPopup').val('');
            filter('');		
            e.preventDefault();

               searchResultHeaderFixed();

        });

        $j('[data-popup-close]').on('click', function(e) {
            var targeted_popup_class = jQuery(this).attr('data-popup-close');
            $j('[end-market="' + targeted_popup_class + '"]').fadeOut(350);
            e.preventDefault();
        });


         $j('[data-popup-close]').on('click', function(e) {
            var targeted_popup_class = jQuery(this).attr('data-popup-close');
            $j('[filter-brand="' + targeted_popup_class + '"]').fadeOut(350);
   e.preventDefault();

            var targeted_popup_class = jQuery(this).attr('data-popup-close');
	        $j('[boolean-search="' + targeted_popup_class + '"]').fadeOut(350);
            e.preventDefault();
			
			var targeted_popup_class = jQuery(this).attr('data-popup-close');
            $j('[category="' + targeted_popup_class + '"]').fadeOut(350);
            e.preventDefault();
			
			var targeted_popup_class = jQuery(this).attr('data-popup-close');
            $j('[brand="' + targeted_popup_class + '"]').fadeOut(350);
            e.preventDefault();
			
			var targeted_popup_class = jQuery(this).attr('data-popup-close');

             setTimeout(function(){ addRemove(); }, 350);

            $j('[methodology="' + targeted_popup_class + '"]').fadeOut(350);
            e.preventDefault();

                                    
           var targeted_popup_class = jQuery(this).attr('data-popup-close');
		if($j('#searchResultClosePopup, #advance-search-report-date-popup').is(':visible'))
            {
                      
            	var selValue = ($j("input[class='dateRange']:checked").val());

				 if(selValue=="custom" || selValue=="Custom")
                    {
                      

                 
                  // $j('#searchResultClosePopup').css('pointer-events','none');
						
                        var customReportStartDate = $j("#customReportStartDate").val();   
                         var customReportEndDate = $j("#customReportEndDate").val();  

                       
		
                          if(customReportStartDate=="" || customReportEndDate=="")
                          {
                                                              
                          
						  // $j('#searchResultClosePopup #searchResultClosePopupIfCustomSelect').css('pointer-events','none');
						   
						     // This has been done for http://redmine.nvish.com/redmine/issues/840
							 $j('.popup').fadeOut(350);
							 						  
							
							 
							 
							 $j("input[name=reportDateFilter]").val(['']);
							$j('#SearchResultDateRange').html('');
							$j('#SearchResultDateRange').css('display','none');
							 $j('#SearchResultStartDateRange').css('display','none');
							$j('#SearchResultEndDateRange').css('display','none');
							
							$j("#customReportStartDate").val('');
							$j("#customReportEndDate").val('');
							
							$j('.enableDisableDateField').css('pointer-events','none');
                                	                                	
                          }
                          else
                          {
                                
                          	 $j('#searchResultClosePopup #searchResultClosePopupIfCustomSelect').css('pointer-events','auto');
                          	$j('.popup').fadeOut(350);
                                                      
                          }
                    }

                    else
                    {
                    	$j('.popup').fadeOut(350);
                    	 
                    }

              }    
             else
             {

               $j('[report-date="' + targeted_popup_class + '"]').fadeOut(350);
                e.preventDefault();
                  setTimeout(function(){ addRemove(); }, 350);
			
             }

	
			 var targeted_popup_class = jQuery(this).attr('data-popup-close');
            $j('[search-within="' + targeted_popup_class + '"]').fadeOut(350);
            e.preventDefault();
			
			var targeted_popup_class = jQuery(this).attr('data-popup-close');
            $j('[advance-search-end-market="' + targeted_popup_class + '"]').fadeOut(350);
            e.preventDefault();
			
			var targeted_popup_class = jQuery(this).attr('data-popup-close');
            $j('[advance-search-brand="' + targeted_popup_class + '"]').fadeOut(350);
            e.preventDefault();
			
			var targeted_popup_class = jQuery(this).attr('data-popup-close');
            $j('[advance-search-methodology="' + targeted_popup_class + '"]').fadeOut(350);
            e.preventDefault();
			
			var targeted_popup_class = jQuery(this).attr('data-popup-close');
            $j('[advance-search-category="' + targeted_popup_class + '"]').fadeOut(350);
            e.preventDefault();
			
			changePointerEvent();		

        });

         function addRemove(){

         	$j('.addMarginToSearchOuterWrap').removeClass('addMarginToSearchOuterWrap').addClass('searchResultOuterWrap');
              $j('.searchResultOuterWrap .column.left').removeClass('addStaticPosition').addClass('addFixedPosition');
              $j('.addStaticPosition').removeClass('addStaticPosition').addClass('fixRightColumn');
              $j('.searchResultOuterWrap .column.middle').addClass('addMargin20perToMiddleCol').removeClass('addMarginToMiddleColumn');
               $j('div.fixSearchResultHeader').removeClass('fixRightColumn');
               $j('.searchResultInnerWrap').css('position','relative');
               $j('body').css({'overflow-y':'auto','position':'static'});

	       $j('.searchResultOuterWrap .column.left').removeClass('searchResultLeftColumnHeight');
         }
		
		/** This method for closing the Advance Search Report Date Filter */
		$j('[advance-search-report-date-popup-close]').on('click', function(e) {

			 

			var targeted_popup_class = jQuery(this).attr('advance-search-report-date-popup-close');
            if($j('#advance-search-report-date-popup').is(':visible'))
            {

            	var selValue = ($j("input[class='dateRange']:checked").val());
				 if(selValue=="custom" || selValue=="Custom")
                    {

                        var customReportStartDate = $j("#customReportStartDate").val();   
                         var customReportEndDate = $j("#customReportEndDate").val();  

                          if(customReportStartDate=="" || customReportEndDate=="")
                          {
                                                               //return  true;
                               // $j('.advanceSearchReportDateContainer a#searchResultClosePopupIfCustomSelect').css('pointer-events','none');
                              
							 // This has been done for http://redmine.nvish.com/redmine/issues/840
							 $j('.popupAdvanceSearch').fadeOut(500);
							
							  
							 $j("input[name=reportDateFilter]").val(['']);
							 $j("#customReportStartDate").val('');
							 $j("#customReportEndDate").val('');
							 $j('.enableDisableDateField').css('pointer-events','none');
                          }
                          else
                          {
                          	$j('.popupAdvanceSearch').fadeOut(500);


                          	 // $j('.advanceSearchReportDateContainer a#searchResultClosePopupIfCustomSelect').css('pointer-events','auto');

                          }
                    }
                    else
                    {
                    	$j('.popupAdvanceSearch').fadeOut(500);

                    }
              }    
             else
             {
               $j('[advance-search-report-date="' + targeted_popup_class + '"]').fadeOut(350);
                e.preventDefault();	

                // setAdvanceSearchReportDateFilters();		
             }



   //          $j('[advance-search-report-date="' + targeted_popup_class + '"]').fadeOut(350);
   //          e.preventDefault();	
			setAdvanceSearchReportDateFilters();
		});


        /** This method for closing the Search Result page Date Filter */
		// $j('[search-result-data-popup-close]').on('click', function(e) {
		// 	var targeted_popup_class = jQuery(this).attr('search-result-data-popup-close');
  //           $j('[search-result-report-date="' + targeted_popup_class + '"]').fadeOut(350);
  //           e.preventDefault();	
			//setAdvanceSearchReportDateFilters();
		// });    
		
		/** This method for closing the Advance Search Within Filter */
		$j('[advance-search-search-within-popup-close]').on('click', function(e) {
			var targeted_popup_class = jQuery(this).attr('advance-search-search-within-popup-close');
			$j('[search-within="' + targeted_popup_class + '"]').fadeOut(350);
			$j('.txtListOnPopup').val('');
            filter('');
			e.preventDefault();
			
			/* Code for checking if there are some selected values in Search Within then display the values on Advance Search Screen */
			
			if (advanceSearchWithinIdArray.length != 0)
			{
				$j('.search-in-style').show();
			}
			else
			{
				$j('.search-in-style').fadeOut(300);
			}	


			
		});
		
		$j('[data-popup-category]').on('click', function(e) {
	ieTest();
  $j('.searchResultOuterWrap .column.left').addClass('searchResultLeftColumnHeight');
  showFilterScroller();
            var targeted_popup_class = jQuery(this).attr('data-popup-category');
            $j('[category="' + targeted_popup_class + '"]').fadeIn(350);
            e.preventDefault();
		 $j('.txtListOnPopup').val('');
            filter('');
               searchResultHeaderFixed();
        });
		
		$j('[data-popup-brand]').on('click', function(e) {
	ieTest();
$j('.searchResultOuterWrap .column.left').addClass('searchResultLeftColumnHeight');
showFilterScroller();
            var targeted_popup_class = jQuery(this).attr('data-popup-brand');
            $j('[brand="' + targeted_popup_class + '"]').fadeIn(350);
            e.preventDefault();
		 $j('.txtListOnPopup').val('');
            filter('');
               searchResultHeaderFixed();
        });
		
		$j('[data-popup-methodology]').on('click', function(e) {
	$j('.searchResultOuterWrap .column.left').addClass('searchResultLeftColumnHeight');

/*
         	if($j('#search-with-in').is(':visible')){

              //alert(8);
                       
				$j('.searchResultOuterWrap .column.left').addClass('testDemo');
				$j('.addMarginToSearchOuterWrap .column.left').addClass('testDemo');          

		     }*/
	ieTest();
		   
         showFilterScroller();



            var targeted_popup_class = jQuery(this).attr('data-popup-methodology');
            $j('[methodology="' + targeted_popup_class + '"]').fadeIn(350);
            e.preventDefault();
		  $j('.txtListOnPopup').val('');
           filter('');
          searchResultHeaderFixed();

        });


        function searchResultHeaderFixed()
        {

            $j('.searchResultOuterWrap .searchResultInnerWrap').css('position','static');
            $j('.fixSearchResultHeader,.fixRightColumn').addClass('addStaticPosition').removeClass('fixRightColumn');
            $j('.searchResultOuterWrap .column.middle').addClass('addMarginToMiddleColumn');
            $j('.searchResultOuterWrap').addClass('addMarginToSearchOuterWrap').removeClass('searchResultOuterWrap');
            $j('.addFixedPosition').removeClass('addFixedPosition');
   $j('.addFixedPosition').removeClass('addFixedPosition').addClass('searchResultLeftColumnHeight');
              
               var hasVScroll = document.body.scrollHeight > document.body.clientHeight;
                   if (checkScrollYStatus) 
                   {
                         
                          $j('body').css({'overflow-y':'scroll','position':'fixed'});
                         
                      }
                      else
                      {
                              $j('body').css('overflow-y','hidden');

                      }

        }
		
		$j('[data-popup-report-date]').on('click', function(e) {
	ieTest();
$j('.searchResultOuterWrap .column.left').addClass('searchResultLeftColumnHeight');
showFilterScroller();
            var targeted_popup_class = jQuery(this).attr('data-popup-report-date');
            $j('[report-date="' + targeted_popup_class + '"]').fadeIn(350);
            e.preventDefault();
               searchResultHeaderFixed();
		});	
		
		$j('[data-popup-search-within]').on('click', function(e) {
	ieTest();
    $j('.searchResultOuterWrap .column.left').addClass('searchResultLeftColumnHeight');
	showFilterScroller();
            var targeted_popup_class = jQuery(this).attr('data-popup-search-within');
            $j('[search-within="' + targeted_popup_class + '"]').fadeIn(350);
            e.preventDefault();
		  $j(".txtListOnPopup").val('');
            filter('');
               searchResultHeaderFixed();
        });
		
		$j('[data-popup-advance-search-end-market]').on('click', function(e) {
            var targeted_popup_class = jQuery(this).attr('data-popup-advance-search-end-market');
            $j('[advance-search-end-market="' + targeted_popup_class + '"]').fadeIn(350);
            e.preventDefault();
        });
		
		$j('[data-popup-advance-search-brand]').on('click', function(e) {
            var targeted_popup_class = jQuery(this).attr('data-popup-advance-search-brand');
            $j('[advance-search-brand="' + targeted_popup_class + '"]').fadeIn(350);
            e.preventDefault();
        });
		
		$j('[data-popup-advance-search-methodology]').on('click', function(e) {
            var targeted_popup_class = jQuery(this).attr('data-popup-advance-search-methodology');
            $j('[advance-search-methodology="' + targeted_popup_class + '"]').fadeIn(350);
            e.preventDefault();
        });
		
		$j('[data-popup-advance-search-category]').on('click', function(e) {
            var targeted_popup_class = jQuery(this).attr('data-popup-advance-search-category');
            $j('[advance-search-category="' + targeted_popup_class + '"]').fadeIn(350);
            e.preventDefault();
        });
		
		$j('[data-popup-advance-search-report-date]').on('click', function(e) {
            var targeted_popup_class = jQuery(this).attr('data-popup-advance-search-report-date');
            $j('[advance-search-report-date="' + targeted_popup_class + '"]').fadeIn(350);
            e.preventDefault();
			
        });
			



      


        /*End script For filter popup*/


        /*Start script for search result pop-up*/

        $j(".search-result-methodology-popup").click(function() {
            getSearchResultMethodologyValue();

        })
		
		$j(".search-result-brand-popup").click(function() {
            getSearchResultBrandValue();
        })
		$j(".search-result-category-popup").click(function() {
            getSearchResultCategoryValue();
        });
		$j(".search-result-end-market-popup").click(function() {
            getSearchResultEndMarketValue();

        });
		
		$j(".search-result-search-within-popup").click(function() {
            getSearchResultSearchWithinValue();

        });
		

        /*End script for search result pop-up*/

	  $j('popup').click(function(){

		$j('#overlay').css(display,block);
	  })





}); /*End documents.ready tag*/


function UncheckAll() {
    var w = document.getElementsByTagName('input');
	
	 
    for (var i = 0; i < w.length; i++) {
        if (w[i].type == 'checkbox') {
            w[i].checked = false;
        }
    }
	
	
}

function uncheckSearchResultSearchWithInFilters()
{
	
	$j(".searchWithinCheckBoxClass").prop('checked', false);
}

function uncheckSearchResultFilters()
{
	$j(".methodologycheckBoxClass").prop('checked', false);
	$j(".brandcheckBoxClass").prop('checked', false);
	$j(".categorycheckBoxClass").prop('checked', false);
	$j(".endMarketcheckBoxClass").prop('checked', false);
}


function filter(element) {
    var value = $j(element).val();
    $j(".fromList li").each(function() {
        if ($j(this).text().search(new RegExp(value, "i")) > -1) {
            $j(this).show();
        } else {
            $j(this).hide();
        }
    });
}
/*Advance Search End Market Filter Starts */

function getAdvanceSearchEndMarketValue() 
{
	
    
	var selectedItemsContainer = $j('#selected-advance-search-end-markets');
    var items = $j('.advanceSearchEndMarketCheckBoxClass');

    // items.on('change', function(){
    /*console.log('end market');*/
    selectedItemsContainer.empty();
    var appendData = '';
    
	advanceSearchEndMarketArray = [];
	advanceSearchEndMarketIdArray = [];

    $j.each(items, function(i, itemChkbox) {
         
         // var a= "<label class='checkboxContainer'><input type='checkbox' checked><span class='checkmark'></span></label>";
		//console.log($j(itemChkbox).val());
        if ($j(itemChkbox).prop('checked')) 
		{
            /*console.log('value:'+$j(itemChkbox).val());*/
            advanceSearchEndMarketArray.push($j(itemChkbox).val());
			advanceSearchEndMarketIdArray.push($j(itemChkbox).attr('endmarketid'));
			console.log("advanceSearchEndMarketIdArray==>"+advanceSearchEndMarketIdArray);
			
           // appendData += '<p class="align-applied-filter-result" id=' + i + '>' +'<input type="checkbox" checked /> ' + $j(itemChkbox).val() ;
		   // appendData += '<p class="align-advance-search-filter-result" id=' + $j(itemChkbox).attr('endmarketid') + '>' +a + '<span>'+$j(itemChkbox).val()+'</sapn>'  ;
		   appendData += '<p id=' + i + '>' + $j(itemChkbox).val() + '<i class="error"></i></p>';
        } 
         else 
		 {
			if ($j(itemChkbox).prop('unchecked'))
			{
				advanceSearchEndMarketArray.slice($j(itemChkbox).val());
				advanceSearchEndMarketIdArray.slice($j(itemChkbox).attr('endmarketid'));
				//console.log('After unchecked value:'+$j(itemChkbox).val());        

				
			}           
          }
    });

   
    selectedItemsContainer.append(appendData);
    deleteAdvanceSearchEndMarket(advanceSearchEndMarketArray, selectedItemsContainer);
    deleteAdvanceSearchEndMarketFilter(advanceSearchEndMarketArray, selectedItemsContainer);



} 

// This function is used to clear all the selected End Market Filters on the Advanced Search Page
function deleteAdvanceSearchEndMarketFilter(advanceSearchEndMarketArray, selectedItemsContainer)
{

   
	$j('li.advance-filter-subhead').find('.error').on('click', function(e){ 

        e.stopPropagation();
		
		$j("#advanceSearchEndMarketSelectAll").prop('checked', false);
        $j('#advance-search-end-market .error').css("display","none");
        // $j('#advance-search-end-market').hover(function(){ $j(this).find(".error").css("display","none"); });

        advanceSearchEndMarketArray.length = 0;
        advanceSearchEndMarketIdArray.length = 0;
		updatedDataAppendAdvanceSearchEndMarket(advanceSearchEndMarketArray, selectedItemsContainer);
        // $j('p.align-advance-search-filter-result').hide();
        $j(".advanceSearchEndMarketCheckBoxClass").prop('checked', false);
        $j('#advance-search-end-market').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
	});

	// $j(".advanceSearchEndMarketCheckBoxClass").prop('checked', false);
} 


function deleteAdvanceSearchEndMarket(advanceSearchEndMarketArray, selectedItemsContainer) 
{
    
	
	$j('#selected-advance-search-end-markets p .error').on('click', function() {

    	var getId = $j(this).parent().text();
		 // var getId = $j(this).parent().text().trim();
		  // var getId = $j(this).text().trim();
  
     
	
        removeAdvanceSearchEndMarket(advanceSearchEndMarketArray, getId);
       // console.log('demoArr updated'+EndMarketArray);
	   
	   /** This is optimization for deleting the individual end market when many end markets are selected on advanced search page. Instead of creating all the p tags with selected values again from scratch, we will now remove only the deleted value from the array and removing that p tag only. This will speed up the process. http://redmine.nvish.com/redmine/issues/705
		*/
		$j(this).parent().hide();
        //updatedDataAppendAdvanceSearchEndMarket(advanceSearchEndMarketArray, selectedItemsContainer);
		
		if (advanceSearchEndMarketArray.length == 0)
		{

			checkAdvanceEndMarketFilterSelectValues=true;
			$j('#advance-search-end-market').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
		}

		
    });
}     

function removeAdvanceSearchEndMarket(advanceSearchEndMarketArray, getId) 
{
    var valueFindout=false;
	for (var i in advanceSearchEndMarketArray) 
	{
        if (advanceSearchEndMarketArray[i] == getId) 
		{
			advanceSearchEndMarketArray.splice(i, 1);
			advanceSearchEndMarketIdArray.splice(i, 1);
            $j( "#checkBoxes .advanceSearchEndMarketCheckBoxClass" ).each(function( index )
            {
                if( getId== $j(this).val())
                {
                    $j(this).attr('checked', false);
                    valueFindout=true;
                    return false;
                }
            });
		}
        if(valueFindout==true)
		{
              $j('#advanceSearchEndMarketSelectAll').attr('checked', false);

            break;
        }
    }
}  
 

function updatedDataAppendAdvanceSearchEndMarket(advanceSearchEndMarketArray, mycont1) 
{
    var appendData1 = '';
    if (advanceSearchEndMarketArray.length !== 0)
	{
        for (var j = 0; j < advanceSearchEndMarketArray.length; j++) 
		{  
          //  appendData1 += '<p class="align-applied-filter-result" id=' + j + '>' +'<input type="checkbox" checked /> ' + updatedemoArr1[j] ; + '<span>'+$j(itemChkbox).val()+'</sapn>'
		   // var a= "<label class='checkboxContainer'><input type='checkbox' checked><span class='checkmark'></span></label>";
     //       appendData1 += '<p class="align-advance-search-filter-result" id=' + j + '>' +a + '<span>' + advanceSearchEndMarketArray[j] +'</sapn>'; 
            appendData1 += '<p id=' + j + '>' + advanceSearchEndMarketArray[j] + '<i class="error"></i></p>';
           mycont1.empty();
           mycont1.append(appendData1);
           deleteAdvanceSearchEndMarket(advanceSearchEndMarketArray, mycont1);
        }
    } 
    else 
	{

		 $j('#advance-search-end-market').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
        mycont1.empty();       
        // $j('.HideIfEmpty').hide();
       /* $j('.search-in-style').fadeOut(500);*/
    }

}     
/*Advance Search End Market Filter Ends */


/*Advance Search Brand Filter Starts */

function getAdvanceSearchBrandValue() 
{
	
    var selectedItemsContainer = $j('#selected-advance-search-brands');
    var items = $j('.advanceSearchBrandCheckBoxClass');

    selectedItemsContainer.empty();
    var appendData = '';
    
	advanceSearchBrandArray = [];
	advanceSearchBrandIdArray = [];

    $j.each(items, function(i, itemChkbox) {
         
         // var a= "<label class='checkboxContainer'><input type='checkbox' checked><span class='checkmark'></span></label>";
		if ($j(itemChkbox).prop('checked')) 
		{
            advanceSearchBrandArray.push($j(itemChkbox).val());
			advanceSearchBrandIdArray.push($j(itemChkbox).attr('brandid'));
			// appendData += '<p class="align-applied-filter-result" id=' + i + '>' +'<input type="checkbox" checked /> ' + $j(itemChkbox).val() ;
		    // appendData += '<p class="align-advance-search-filter-result" id=' + $j(itemChkbox).attr('brandid') + '>' +a + '<span>' + $j(itemChkbox).val() +'</sapn>' ;
            appendData += '<p id=' + i + '>' + $j(itemChkbox).val() + '<i class="error"></i></p>';

        } 
         else 
		 {
			if ($j(itemChkbox).prop('unchecked'))
			{
				advanceSearchBrandArray.slice($j(itemChkbox).val());
				advanceSearchBrandIdArray.slice($j(itemChkbox).attr('brandid'));
			}           
          }
    });

    selectedItemsContainer.append(appendData);
    deleteAdvanceSearchBrand(advanceSearchBrandArray, selectedItemsContainer);
    deleteAdvanceSearchBrandFilter(advanceSearchBrandArray, selectedItemsContainer);

} 

// This function is used to clear all the selected Brand Filters on the Advanced Search Page
function deleteAdvanceSearchBrandFilter(advanceSearchBrandArray, selectedItemsContainer)
{
    $j('li.advance-filter-subhead-brand').find('.error').on('click', function(e){



     e.stopPropagation();
	 
	$j("#advanceSearchBrandSelectAll").prop('checked', false);
	
    $j('#advance-search-brand .error').css("display","none");
  
        advanceSearchBrandArray.length = 0;
        advanceSearchBrandIdArray.length =0;
		updatedDataAppendAdvanceSearchBrand(advanceSearchBrandArray, selectedItemsContainer);
        $j(".advanceSearchBrandCheckBoxClass").prop('checked', false);
        $j('#advance-search-brand').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});

	});
} 


function deleteAdvanceSearchBrand(advanceSearchBrandArray, selectedItemsContainer) 
{
    $j('#selected-advance-search-brands p .error').on('click', function() {	

  
		 var getId = $j(this).parent().text();
		  // var getId = $j(this).text().trim();
	
        removeAdvanceSearchBrand(advanceSearchBrandArray, getId);
       // console.log('demoArr updated'+EndMarketArray);
        //updatedDataAppendAdvanceSearchBrand(advanceSearchBrandArray, selectedItemsContainer);
		
		/** This is optimization for deleting the individual brand when many brands are selected on Advanced Filter page. Instead of creating all the p tags with selected values again from scratch, we will now remove only the deleted value from the array and removing that p tag only. This will speed up the process. http://redmine.nvish.com/redmine/issues/705
		*/
		$j(this).parent().hide();
		
		if (advanceSearchBrandArray.length == 0)
		{

		     checkAdvanceBrandFilterSelectValues=true;
			$j('#advance-search-brand').css({"background-color": "#e4eaeb", "color": "#5d5d5d"}); 
		}
    });



}     

function removeAdvanceSearchBrand(advanceSearchBrandArray, getId) 
{
    var valueFindout=false;
	for (var i in advanceSearchBrandArray) 
	{
        if (advanceSearchBrandArray[i] == getId) 
		{
			advanceSearchBrandArray.splice(i, 1);
			advanceSearchBrandIdArray.splice(i, 1);
            $j( "#checkBoxes .advanceSearchBrandCheckBoxClass" ).each(function( index )
            {
                if( getId== $j(this).val())
                {
                    $j(this).attr('checked', false);
                    valueFindout=true;
                    return  false;
                }
            });
		}
        if(valueFindout==true)
		{
			$j('#advanceSearchBrandSelectAll').attr('checked', false);
            break;
        }
    }
}  
 

function updatedDataAppendAdvanceSearchBrand(advanceSearchBrandArray, mycont1) 
{
    var appendData1 = '';
    if (advanceSearchBrandArray.length !== 0)
	{
        for (var j = 0; j < advanceSearchBrandArray.length; j++) 
		{  
          //  appendData1 += '<p class="align-applied-filter-result" id=' + j + '>' +'<input type="checkbox" checked /> ' + updatedemoArr1[j] ; 
		   // var a= "<label class='checkboxContainer'><input type='checkbox' checked><span class='checkmark'></span></label>";
     //       appendData1 += '<p class="align-advance-search-filter-result" id=' + j + '>' +a + '<span>' + advanceSearchBrandArray[j] + '</span>'; 

              appendData1 += '<p id=' + j + '>' + advanceSearchBrandArray[j] + '<i class="error"></i></p>';

           mycont1.empty();
           mycont1.append(appendData1);
           deleteAdvanceSearchBrand(advanceSearchBrandArray, mycont1);
        }
    } 
    else 
	{
		 $j('#advance-search-brand').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});  

        mycont1.empty();

        // $j('.HideIfEmpty').hide();
       /* $j('.search-in-style').fadeOut(500);*/
    }

}     
/*Advance Search Brand Filter Ends */

/*Advance Search Methodology Filter Starts */

function getAdvanceSearchMethodologyValue() 
{
	
    var selectedItemsContainer = $j('#selected-advance-search-methodology');
    var items = $j('.advanceSearchMethodologyCheckBoxClass');

    selectedItemsContainer.empty();
    var appendData = '';
    
	advanceSearchMethodologyArray = [];
	advanceSearchMethodologyIdArray = [];

    $j.each(items, function(i, itemChkbox) {
         
         // var a= "<label class='checkboxContainer'><input type='checkbox' checked><span class='checkmark'></span></label>";
		if ($j(itemChkbox).prop('checked')) 
		{
            advanceSearchMethodologyArray.push($j(itemChkbox).val());
			advanceSearchMethodologyIdArray.push($j(itemChkbox).attr('methodologyid'));
			// appendData += '<p class="align-applied-filter-result" id=' + i + '>' +'<input type="checkbox" checked /> ' + $j(itemChkbox).val() ;
		    // appendData += '<p class="align-advance-search-filter-result" id=' + $j(itemChkbox).attr('methodologyid') + '>' +a + '<span>' + $j(itemChkbox).val() + '</span>' ;
		    appendData += '<p id=' + i + '>' + $j(itemChkbox).val() + '<i class="error"></i></p>';
        } 
         else 
		 {
			if ($j(itemChkbox).prop('unchecked'))
			{
				advanceSearchMethodologyArray.slice($j(itemChkbox).val());
				advanceSearchMethodologyIdArray.slice($j(itemChkbox).attr('methodologyid'));
			}           
          }
    });

    selectedItemsContainer.append(appendData);
    deleteAdvanceSearchMethodology(advanceSearchMethodologyArray, selectedItemsContainer);
    deleteAdvanceSearchMethodologyFilter(advanceSearchMethodologyArray, selectedItemsContainer);

} 

// This function is used to clear all the selected Methodology Filters on the Advanced Search Page
function deleteAdvanceSearchMethodologyFilter(advanceSearchMethodologyArray, selectedItemsContainer)
{
	
	 $j('li.advance-filter-subhead-methodology').find('.error').on('click', function(e){

         //$j('#advance-search-methodology').hover(function(){ $j(this).find(".error").css("display","none"); });
		 
		 
		 $j("#advanceSearchMethodologySelectAll").prop('checked', false);
         e.stopPropagation();
         $j('#advance-search-methodology .error').css("display","none");

        advanceSearchMethodologyArray.length = 0;
        advanceSearchMethodologyIdArray.length =0;
		
		updatedDataAppendAdvanceSearchMethodology(advanceSearchMethodologyArray, selectedItemsContainer);
        $j(".advanceSearchMethodologyCheckBoxClass").prop('checked', false);
        $j('#advance-search-methodology').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});



	});
} 


function deleteAdvanceSearchMethodology(advanceSearchMethodologyArray, selectedItemsContainer) 
{
    $j('#selected-advance-search-methodology p .error').on('click', function() {	

		  var getId = $j(this).parent().text();
		  // var getId = $j(this).text().trim();
         
        removeAdvanceSearchMethodology(advanceSearchMethodologyArray, getId);
       // console.log('demoArr updated'+EndMarketArray);
       // updatedDataAppendAdvanceSearchMethodology(advanceSearchMethodologyArray, selectedItemsContainer);
	   
	   /** This is optimization for deleting the individual methodology when many methodologies are selected on Advanced Search Page. Instead of creating all the p tags with selected values again from scratch, we will now remove only the deleted value from the array and removing that p tag only. This will speed up the process. http://redmine.nvish.com/redmine/issues/705
		*/
		$j(this).parent().hide();
		
		if (advanceSearchMethodologyArray.length == 0)
		{
          checkAdvanceMethodologyFilterSelectValues=true;


			$j('#advance-search-methodology').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});   
		}
    });
}     

function removeAdvanceSearchMethodology(advanceSearchMethodologyArray, getId) 
{
    var valueFindout=false;
	for (var i in advanceSearchMethodologyArray) 
	{
        if (advanceSearchMethodologyArray[i] == getId) 
		{
			advanceSearchMethodologyArray.splice(i, 1);
			advanceSearchMethodologyIdArray.splice(i, 1);
            $j( "#checkBoxes .advanceSearchMethodologyCheckBoxClass" ).each(function( index )
            {
                if( getId== $j(this).val())
                {
                    $j(this).attr('checked', false);
                    valueFindout=true;
                     return  false;
                }
            });
		}
        if(valueFindout==true)
		{
			$j('#advanceSearchMethodologySelectAll').attr('checked', false);
            break;
        }
    }
}  
 

function updatedDataAppendAdvanceSearchMethodology(advanceSearchMethodologyArray, mycont1) 
{
    var appendData1 = '';
    if (advanceSearchMethodologyArray.length !== 0)
	{
        for (var j = 0; j < advanceSearchMethodologyArray.length; j++) 
		{  
          //  appendData1 += '<p class="align-applied-filter-result" id=' + j + '>' +'<input type="checkbox" checked /> ' + updatedemoArr1[j] ; 
		   // var a= "<label class='checkboxContainer'><input type='checkbox' checked><span class='checkmark'></span></label>";
     //       appendData1 += '<p class="align-advance-search-filter-result" id=' + j + '>' +a + '<span>' + advanceSearchMethodologyArray[j] + '</span>'; 
             appendData1 += '<p id=' + j + '>' + advanceSearchMethodologyArray[j] + '<i class="error"></i></p>';
           mycont1.empty();
           mycont1.append(appendData1);
           deleteAdvanceSearchMethodology(advanceSearchMethodologyArray, mycont1);
        }
    } 
    else 
	{

		 $j('#advance-search-methodology').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});   
        mycont1.empty();
        $j('.HideIfEmpty').hide();
       /* $j('.search-in-style').fadeOut(500);*/
    }

}     
/*Advance Search Methodology Filter Ends */


/*Advance Search Category Filter Starts */

function getAdvanceSearchCategoryValue() 
{
	
    var selectedItemsContainer = $j('#selected-advance-search-category');
    var items = $j('.advanceSearchCategoryCheckBoxClass');

    selectedItemsContainer.empty();
    var appendData = '';
    
	advanceSearchCategoryArray = [];
	advanceSearchCategoryIdArray = [];

    $j.each(items, function(i, itemChkbox) {
         
         // var a= "<label class='checkboxContainer'><input type='checkbox' checked><span class='checkmark'></span></label>";
		if ($j(itemChkbox).prop('checked')) 
		{
            advanceSearchCategoryArray.push($j(itemChkbox).val());
			advanceSearchCategoryIdArray.push($j(itemChkbox).attr('categoryid'));
			// appendData += '<p class="align-applied-filter-result" id=' + i + '>' +'<input type="checkbox" checked /> ' + $j(itemChkbox).val() ;
		    // appendData += '<p class="align-advance-search-filter-result" id=' + $j(itemChkbox).attr('categoryid') + '>' +a + '<span>' + $j(itemChkbox).val() + '</span>' ;
		    appendData += '<p id=' + i + '>' + $j(itemChkbox).val() + '<i class="error"></i></p>';
        } 
         else 
		 {
			if ($j(itemChkbox).prop('unchecked'))
			{
				advanceSearchCategoryArray.slice($j(itemChkbox).val());
				advanceSearchCategoryIdArray.slice($j(itemChkbox).attr('categoryid'));
			}           
          }
    });

    selectedItemsContainer.append(appendData);
    deleteAdvanceSearchCategory(advanceSearchCategoryArray, selectedItemsContainer);
    deleteAdvanceSearchCategoryFilter(advanceSearchCategoryArray, selectedItemsContainer);

} 

// This function is used to clear all the selected Category Filters on the Advanced Search Page

function deleteAdvanceSearchCategoryFilter(advanceSearchCategoryArray, selectedItemsContainer)
{
    $j('li.advance-filter-subheadcategory').find('.error').on('click', function(e)
    	{

          e.stopPropagation();
		  
		  $j("#advanceSearchCategorySelectAll").prop('checked', false);
		  
          $j('#advance-search-category .error').css("display","none");
          //$j('#advance-search-category').hover(function(){ $j(this).find(".error").css("display","none"); });

     	  advanceSearchCategoryArray.length = 0;
        advanceSearchCategoryIdArray.length = 0;
		updatedDataAppendAdvanceSearchCategory(advanceSearchCategoryArray, selectedItemsContainer);
		$j(".advanceSearchCategoryCheckBoxClass").prop('checked', false);
        $j('#advance-search-category').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
		});
} 


function deleteAdvanceSearchCategory(advanceSearchCategoryArray, selectedItemsContainer) 
{
    $j('#selected-advance-search-category p .error').on('click', function() {	

		var getId = $j(this).parent().text();
		  // var getId = $j(this).text().trim();
  
        removeAdvanceSearchCategory(advanceSearchCategoryArray, getId);
       // console.log('demoArr updated'+EndMarketArray);
       // updatedDataAppendAdvanceSearchCategory(advanceSearchCategoryArray, selectedItemsContainer);
	   
	   /** This is optimization for deleting the individual categories when many categories are selected on Advanced Search Page. Instead of creating all the p tags with selected values again from scratch, we will now remove only the deleted value from the array and removing that p tag only. This will speed up the process. http://redmine.nvish.com/redmine/issues/705
		*/
		$j(this).parent().hide();
		
		if (advanceSearchCategoryArray.length == 0)
		{

			checkAdvanceCategoryFilterSelectValues=true;

			 $j('#advance-search-category').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
		}
    });
}     

function removeAdvanceSearchCategory(advanceSearchCategoryArray, getId) 
{
    var valueFindout=false;
	for (var i in advanceSearchCategoryArray) 
	{
        if (advanceSearchCategoryArray[i] == getId) 
		{
			advanceSearchCategoryArray.splice(i, 1);
			advanceSearchCategoryIdArray.splice(i, 1);
            $j( "#checkBoxes .advanceSearchCategoryCheckBoxClass" ).each(function( index )
            {
                if( getId== $j(this).val())
                {
                    $j(this).attr('checked', false);
                    valueFindout=true;
                     return  false;
                }
            });
		}
        if(valueFindout==true)
		{
			$j('#advanceSearchCategorySelectAll').attr('checked', false);


            break;
        }
    }
}  
 

function updatedDataAppendAdvanceSearchCategory(advanceSearchCategoryArray, mycont1) 
{
    var appendData1 = '';
    if (advanceSearchCategoryArray.length !== 0)
	{
        for (var j = 0; j < advanceSearchCategoryArray.length; j++) 
		{  
          //  appendData1 += '<p class="align-applied-filter-result" id=' + j + '>' +'<input type="checkbox" checked /> ' + updatedemoArr1[j] ; 
		   // var a= "<label class='checkboxContainer'><input type='checkbox' checked><span class='checkmark'></span></label>";
     //       appendData1 += '<p class="align-advance-search-filter-result" id=' + j + '>' +a + '<span>' + advanceSearchCategoryArray[j] + '</span>' ;
             appendData1 += '<p id=' + j + '>' + advanceSearchCategoryArray[j] + '<i class="error"></i></p>'; 
           mycont1.empty();
           mycont1.append(appendData1);
           deleteAdvanceSearchCategory(advanceSearchCategoryArray, mycont1);
        }
    } 
    else 
	{

		 $j('#advance-search-category').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
        mycont1.empty();
        // $j('.HideIfEmpty').hide();
       /* $j('.search-in-style').fadeOut(500);*/
    }

}     
/*Advance Search Category Filter Ends */




/*START script For SEARCH RESULT SEARCH WITHIN FILTER*/


function getSearchResultSearchWithinValue() 
{
    var selectedItemsContainer = $j('#SearchResultSearchWithin');
    var items = $j('.searchWithinCheckBoxClass');

    selectedItemsContainer.empty();
	var appendData = '';
    searchResultSearchWithinArray = [];
	searchResultSearchWithinIdArray = [];

    $j.each(items, function(i, itemChkbox) {

        //console.log($j(itemChkbox).val());
        if ($j(itemChkbox).prop('checked'))
		{
            /*console.log('value:'+$j(itemChkbox).val());*/
			searchResultSearchWithinArray.push($j(itemChkbox).val());
			searchResultSearchWithinIdArray.push($j(itemChkbox).attr('searchwithinid'));
		  		    appendData += '<p id=' + i + '>' + $j(itemChkbox).val() + '<i class="error selectedSearchWithInSearchResult"></i></p>';
        } 
         else 
		{
			if ($j(itemChkbox).prop('unchecked'))
			{
				searchResultSearchWithinArray.slice($j(itemChkbox).val());
				searchResultSearchWithinIdArray.slice($j(itemChkbox).attr('searchwithinid'));
            }
        }
    });

    selectedItemsContainer.append(appendData);
    deleteSearchResultSearchWithin(searchResultSearchWithinArray, selectedItemsContainer);
	console.log("searchResultSearchWithinArray After==>"+searchResultSearchWithinArray);
}   /*End getEndMarketValue functions*/


/* This function is used for setting the Search Within Filters initially
*/
function getSearchResultSearchWithinValueInitial(selectedSearchWithinFilters) 
{
	
	if(selectedSearchWithinFilters.length>0)
	{
	
		// preseve values here.......
		var selectedItemsContainer = $j('#SearchResultSearchWithin');
		var appendData = '';
	   
		var items = $j('#checkBoxes .searchWithinCheckBoxClass');
		
		searchResultSearchWithinArray = [];
		searchResultSearchWithinIdArray = [];
	
		for(var k=0;k<selectedSearchWithinFilters.length;k++) 
		{
			
			$j.each(items, function(i, itemChkbox) 
			{
			
				if(selectedSearchWithinFilters[k] == $j(itemChkbox).attr('searchwithinid'))
				{
					appendData += '<p id=' + k+ '>' + $j(this).val() + '<i class="selectedSearchWithInSearchResult error"></i></p>';
					$j(this).prop('checked', true);
					//  $j(".checkBoxClass").prop('checked', $j(this).prop('checked'));
					searchResultSearchWithinArray[k]=$j(this).val();
					searchResultSearchWithinIdArray[k]=selectedSearchWithinFilters[k];				
				}
			});      

		}
		//$j('#SearchResultEndMarket').html(appendData);
		
		selectedItemsContainer.append(appendData);
		deleteSearchResultSearchWithin(searchResultSearchWithinArray, selectedItemsContainer);
	}
}   


function deleteSearchResultSearchWithin(searchResultSearchWithinArray, selectedItemsContainer) 
{

  //$j('p').find('.error').on('click', function() {
	$j('.selectedSearchWithInSearchResult').on('click', function() {  
    
        var getId = $j(this).parent().text();

        removeSearchResultSearchWithin(searchResultSearchWithinArray, getId);
        	/** This is optimization for deleting the individual search withins when many search withins are selected. Instead of creating all the p tags with selected values again from scratch, we will now remove only the deleted value from the array and removing that p tag only. This will speed up the process. http://redmine.nvish.com/redmine/issues/705
		*/
		$j(this).parent().hide();
        //   updatedAppendSearchResultSearchWithin(searchResultSearchWithinArray, selectedItemsContainer);
		changePointerEvent();
		
		showFilterScroller();
    });
}      

function removeSearchResultSearchWithin(searchResultSearchWithinArray, getId) 
{


    var valueFindout=false;
  
    for (var i in searchResultSearchWithinArray) {


        if (searchResultSearchWithinArray[i] == getId) {
           
           searchResultSearchWithinArray.splice(i, 1);
		   searchResultSearchWithinIdArray.splice(i, 1);


              $j( "#checkBoxes .searchWithinCheckBoxClass" ).each(function( index )
                      {
             
                            if( getId== $j(this).val())

                             {
                                    $j(this).attr('checked', false);
                                    valueFindout=true;
                                     return  false;
                             }
                      });
                      
           // $j('input[class="checkBoxClass"]').attr('checked', false);
        } // if   

         if(valueFindout==true)
         {
         	$j('#searchResultSearchWithinSelectAll').attr('checked', false);
            break;
         }
     }

}
    
 
 /*End removeSearchResultEndMarket functions*/   

function updatedAppendSearchResultSearchWithin(updatedemoArr, mycont)
{
    
    var appendData1 = '';
    console.log('updatedemoArr' + updatedemoArr);
    if (updatedemoArr.length !== 0) {
       
        console.log(updatedemoArr.length);
        for (var j = 0; j < updatedemoArr.length; j++) {
            //demoArr[j]).val()
            appendData1 += '<p id=' + j + '>' + updatedemoArr[j] + '<i class="error selectedSearchWithInSearchResult"></i></p>';
            mycont.empty();
            mycont.append(appendData1);
            deleteSearchResultSearchWithin(updatedemoArr, mycont);
        }
    } else {
        mycont.empty();
       /* $j('.search-in-style').fadeOut(500);*/
     
    }

}      /*End updatedDataAppendEndMarket functions*/


/*End script For SEARCH RESULT SEARCH WITHIN FILTER*/

/*Start script For SEARCH RESULT POPUP FILTER(page after search)*/


function getSearchResultEndMarketValue() 
{
    var selectedItemsContainer = $j('#SearchResultEndMarket');
    var items = $j('.endMarketcheckBoxClass');

    selectedItemsContainer.empty();
	var appendData = '';
    searchResultEndMarketArray = [];
	searchResultEndMarketIdArray = [];

    $j.each(items, function(i, itemChkbox) {

        //console.log($j(itemChkbox).val());
        if ($j(itemChkbox).prop('checked'))
		{
            /*console.log('value:'+$j(itemChkbox).val());*/
			searchResultEndMarketArray.push($j(itemChkbox).val());
			searchResultEndMarketIdArray.push($j(itemChkbox).attr('endmarketid'));
		     appendData += '<p id=' + i + '>' + $j(itemChkbox).val() + '<i class="error selectedEndMarketSearchResult"></i></p>';
        } 
         else 
		{
			if ($j(itemChkbox).prop('unchecked'))
			{
				searchResultEndMarketArray.slice($j(itemChkbox).val());
				searchResultEndMarketIdArray.slice($j(itemChkbox).attr('endmarketid'));
            }
        }
    });

    selectedItemsContainer.append(appendData);
    deleteSearchResultEndMarket(searchResultEndMarketArray, selectedItemsContainer);
//	console.log("searchResultEndMarketIdArray After==>"+searchResultEndMarketIdArray);
}   /*End getEndMarketValue functions*/


/* This function is used for setting the EndMarketFilters initially
*/
function getSearchResultEndMarketValueInitial(selectedEndMarketFilters) 
{
	
	if(selectedEndMarketFilters.length>0)
	{
		// preseve values here.......
		var selectedItemsContainer = $j('#SearchResultEndMarket');
		var appendData = '';
	   
		var items = $j('#checkBoxes .endMarketcheckBoxClass');
		
		searchResultEndMarketArray = [];
		searchResultEndMarketIdArray = [];
	
		for(var k=0;k<selectedEndMarketFilters.length;k++) 
		{
			
			$j.each(items, function(i, itemChkbox) 
			{
			
				if(selectedEndMarketFilters[k] == $j(itemChkbox).attr('endmarketid'))
				{
					appendData += '<p id=' + k+ '>' + $j(this).val() + '<i class="selectedEndMarketSearchResult error"></i></p>';
					$j(this).prop('checked', true);
					//  $j(".checkBoxClass").prop('checked', $j(this).prop('checked'));
					searchResultEndMarketArray[k]=$j(this).val();
					searchResultEndMarketIdArray[k]=selectedEndMarketFilters[k];				
				}
			});      

		}
		//$j('#SearchResultEndMarket').html(appendData);
		
		selectedItemsContainer.append(appendData);
		deleteSearchResultEndMarket(searchResultEndMarketArray, selectedItemsContainer);
	}
}   


function deleteSearchResultEndMarket(searchResultEndMarketArray, selectedItemsContainer) 
{

  //$j('p').find('.error').on('click', function() {
	$j('.selectedEndMarketSearchResult').on('click', function() {  
    
        var getId = $j(this).parent().text();

        removeSearchResultEndMarket(searchResultEndMarketArray, getId);
        	/** This is optimization for deleting the individual end market when many end markets are selected. Instead of creating all the p tags with selected values again from scratch, we will now remove only the deleted value from the array and removing that p tag only. This will speed up the process. http://redmine.nvish.com/redmine/issues/705
		*/
		$j(this).parent().hide();
        //updatedAppendSearchResultEndMarket(searchResultEndMarketArray, selectedItemsContainer);
		changePointerEvent();
		showFilterScroller();
    });
}       /*End deleteSearchResultEndMarket functions*/

function removeSearchResultEndMarket(searchResultEndMarketArray, getId) 
{


    var valueFindout=false;
  
    for (var i in searchResultEndMarketArray) {


        if (searchResultEndMarketArray[i] == getId) {
           
           searchResultEndMarketArray.splice(i, 1);
		   searchResultEndMarketIdArray.splice(i, 1);


              $j( "#checkBoxes .endMarketcheckBoxClass" ).each(function( index )
                      {
             
                            if( getId== $j(this).val())

                             {
                                    $j(this).attr('checked', false);
                                    valueFindout=true;
                                      return  false;
                             }
                      });
                      
           // $j('input[class="checkBoxClass"]').attr('checked', false);
        } // if   

         if(valueFindout==true)
         {
          $j('#searchResultEndMarketSelectAll').attr('checked', false);
 
            break;
         }
     }

}
    
 
 /*End removeSearchResultEndMarket functions*/   

function updatedAppendSearchResultEndMarket(updatedemoArr, mycont)
{
    
    var appendData1 = '';
    //console.log('updatedemoArr' + updatedemoArr);
    if (updatedemoArr.length !== 0) {
       
        console.log(updatedemoArr.length);
        for (var j = 0; j < updatedemoArr.length; j++) {
            //demoArr[j]).val()
             appendData1 += '<p id=' + j + '>' + updatedemoArr[j] + '<i class="error selectedEndMarketSearchResult"></i></p>';
            mycont.empty();
            mycont.append(appendData1);
            deleteSearchResultEndMarket(updatedemoArr, mycont);
        }
    } else {
        mycont.empty();
       /* $j('.search-in-style').fadeOut(500);*/
     
    }

}      /*End updatedDataAppendEndMarket functions*/


/* Category Filters Search Result Page Starts */

function getSearchResultCategoryValue() 
{
    var selectedItemsContainer = $j('#SearchResultCategory');
    var items = $j('.categorycheckBoxClass');
    selectedItemsContainer.empty();
    var appendData = '';
    searchResultCategoryArray = [];
	searchResultCategoryIdArray = [];

    $j.each(items, function(i, itemChkbox) {

        //console.log($j(itemChkbox).val());
        if ($j(itemChkbox).prop('checked')) 
		{
            /*console.log('value:'+$j(itemChkbox).val());*/
			searchResultCategoryArray.push($j(itemChkbox).val());
			searchResultCategoryIdArray.push($j(itemChkbox).attr('categoryid'));
			
            appendData += '<p id=' + i + '>' + $j(itemChkbox).val() + '<i class="error selectedCategorySearchResult"></i></p>';
        } 
         else 
		{
          
			if ($j(itemChkbox).prop('unchecked'))
			{
				searchResultCategoryArray.slice($j(itemChkbox).val());
				searchResultCategoryIdArray.slice($j(itemChkbox).attr('categoryid'));
				//console.log('After unchecked value:'+$j(itemChkbox).val());              
			}
        }
    });

    
    selectedItemsContainer.append(appendData);
    deleteSearchResultCategory(searchResultCategoryArray, selectedItemsContainer);
	
}


/* This function is used for setting the Category initially
*/
function getSearchResultCategoryValueInitial(selectedCategoryFilters) 
{
	
	if(selectedCategoryFilters.length>0)
	{
		var selectedItemsContainer = $j('#SearchResultCategory');
		var appendData = '';
	   
		var items = $j('.categorycheckBoxClass');
		
		searchResultCategoryArray = [];
		searchResultCategoryIdArray = [];

	
		for(var k=0;k<selectedCategoryFilters.length;k++) 
		{
			
			$j.each(items, function(i, itemChkbox) 
			{
			
				if(selectedCategoryFilters[k] == $j(itemChkbox).attr('categoryid'))
				{
					appendData += '<p id=' + k+ '>' + $j(this).val() + '<i class="selectedCategorySearchResult error"></i></p>';
					$j(this).prop('checked', true);
					//  $j(".checkBoxClass").prop('checked', $j(this).prop('checked'));
					searchResultCategoryArray[k]=$j(this).val();
					searchResultCategoryIdArray[k]=selectedCategoryFilters[k];				
				}
			});      

		}
	
		selectedItemsContainer.append(appendData);
		 deleteSearchResultCategory(searchResultCategoryArray, selectedItemsContainer);
	}
}   


function deleteSearchResultCategory(searchResultCategoryArray, selectedItemsContainer) 
{
     //$j('p').find('.error').on('click', function() {
		$j('.selectedCategorySearchResult').on('click', function() {

        var getId = $j(this).parent().text();
      
        removeSearchResultCategory(searchResultCategoryArray, getId);
        	/** This is optimization for deleting the individual categories when many categories are selected. Instead of creating all the p tags with selected values again from scratch, we will now remove only the deleted value from the array and removing that p tag only. This will speed up the process. http://redmine.nvish.com/redmine/issues/705
		*/
		$j(this).parent().hide();
        //updatedAppendSearchResultCategory(searchResultCategoryArray, selectedItemsContainer);
		changePointerEvent();
		showFilterScroller();
    });
}     

function removeSearchResultCategory(searchResultCategoryArray, getId) 
{
    var valueFindout=false;
	for (var i in searchResultCategoryArray) 
	{
		if (searchResultCategoryArray[i] == getId) 
		{
            searchResultCategoryArray.splice(i, 1);
			searchResultCategoryIdArray.splice(i, 1);
            $j( "#checkBoxes .categorycheckBoxClass" ).each(function( index )
            {
                if( getId== $j(this).val())
                {
                    $j(this).attr('checked', false);
                    valueFindout=true;
                     return  false;
                }
            });
            // $j('input[class="checkBoxClass"]').attr('checked', false);
		} // if   
        if(valueFindout==true)
        { $j('#searchResultCategorySelectAll').attr('checked', false);

            break;
        }
    }
}
 
function updatedAppendSearchResultCategory(updatedemoArr, mycont)
{
    
    var appendData1 = '';
  
    if (updatedemoArr.length !== 0) {
       
        console.log(updatedemoArr.length);
        for (var j = 0; j < updatedemoArr.length; j++) {
            //demoArr[j]).val()
            appendData1 += '<p id=' + j + '>' + updatedemoArr[j] + '<i class="error selectedCategorySearchResult"></i></p>';
            mycont.empty();
            mycont.append(appendData1);
            deleteSearchResultCategory(updatedemoArr, mycont);
        }
    } else {
        mycont.empty();
       
     
    }

}      /*End updatedDataAppendEndMarket functions*/

/* Category Filters Search Result Page Ends */

/* Brand Filters Search Result Page Starts */

function getSearchResultBrandValue() 
{
    var selectedItemsContainer = $j('#SearchResultBrand');
    var items = $j('.brandcheckBoxClass');
    selectedItemsContainer.empty();
    var appendData = '';
    searchResultBrandArray = [];
	searchResultBrandIdArray = [];

    $j.each(items, function(i, itemChkbox) {

       if ($j(itemChkbox).prop('checked')) 
		{
			searchResultBrandArray.push($j(itemChkbox).val());
			searchResultBrandIdArray.push($j(itemChkbox).attr('brandid'));
			
            appendData += '<p id=' + i + '>' + $j(itemChkbox).val() + '<i class="error selectedBrandSearchResult"></i></p>';
        } 
         else 
		{
			if ($j(itemChkbox).prop('unchecked'))
			{
				searchResultBrandArray.slice($j(itemChkbox).val());
				searchResultBrandIdArray.slice($j(itemChkbox).attr('brandid'));
			}
        }
    });


    selectedItemsContainer.append(appendData);
    deleteSearchResultBrand(searchResultBrandArray, selectedItemsContainer);
	
}


/* This function is used for setting the Brand initially
*/
function getSearchResultBrandValueInitial(selectedBrandFilters) 
{
	
	if(selectedBrandFilters.length>0)
	{
		var selectedItemsContainer = $j('#SearchResultBrand');
		var appendData = '';
	   
		var items = $j('.brandcheckBoxClass');
		
		searchResultBrandArray = [];
		searchResultBrandIdArray = [];
	
		for(var k=0;k<selectedBrandFilters.length;k++) 
		{
			
			$j.each(items, function(i, itemChkbox) 
			{
			
				if(selectedBrandFilters[k] == $j(itemChkbox).attr('brandid'))
				{
						appendData += '<p id=' + k+ '>' + $j(this).val() + '<i class="selectedBrandSearchResult error"></i></p>';
					$j(this).prop('checked', true);
					//  $j(".checkBoxClass").prop('checked', $j(this).prop('checked'));
					searchResultBrandArray[k]=$j(this).val();
					searchResultBrandIdArray[k]=selectedBrandFilters[k];				
				}
			});      

		}
	
		selectedItemsContainer.append(appendData);
		deleteSearchResultBrand(searchResultBrandArray, selectedItemsContainer);
	}
}   


function deleteSearchResultBrand(searchResultBrandArray, selectedItemsContainer) 
{
     //$j('p').find('.error').on('click', function() {
		 
		$j('.selectedBrandSearchResult').on('click', function() {
        var getId = $j(this).parent().text();
        console.log('getid value is :' +getId);
        removeSearchResultBrand(searchResultBrandArray, getId);
       
		
		/** This is optimization for deleting the individual brands when many brands are selected. Instead of creating all the p tags with selected values again from scratch, we will now remove only the deleted value from the array and removing that p tag only. This will speed up the process. http://redmine.nvish.com/redmine/issues/705
		*/
		$j(this).parent().hide();
        // updatedAppendSearchResultBrand(searchResultBrandArray, selectedItemsContainer);
			changePointerEvent();
			showFilterScroller();
    });
}     

function removeSearchResultBrand(searchResultBrandArray, getId) 
{
    var valueFindout=false;
	for (var i in searchResultBrandArray) 
	{
		if (searchResultBrandArray[i] == getId) 
		{
            searchResultBrandArray.splice(i, 1);
			searchResultBrandIdArray.splice(i, 1);
            $j( "#checkBoxes .brandcheckBoxClass" ).each(function( index )
            {
                if( getId== $j(this).val())
                {
                    $j(this).attr('checked', false);
                    valueFindout=true;
                     return false;
                }
            });
          
		} 
        if(valueFindout==true)
        {

        	 $j('#searchResultBrandSelectAll').attr('checked', false);
        	 break;
        }
    }
}
 
function updatedAppendSearchResultBrand(updatedemoArr, mycont)
{
    var appendData1 = '';
   
    if (updatedemoArr.length !== 0) 
	{
         console.log(updatedemoArr.length);
        for (var j = 0; j < updatedemoArr.length; j++) 
		{
            appendData1 += '<p id=' + j + '>' + updatedemoArr[j] + '<i class="error selectedBrandSearchResult"></i></p>';
            mycont.empty();
            mycont.append(appendData1);
            deleteSearchResultBrand(updatedemoArr, mycont);
        }
    } 
	else 
	{
        mycont.empty();
    }
}     

/* Brand Filters Search Result Page Ends */


/* Methodology Filters Search Result Page Starts */

function getSearchResultMethodologyValue() 
{
    var selectedItemsContainer = $j('#SearchResultMethodology');
    var items = $j('.methodologycheckBoxClass');
    selectedItemsContainer.empty();
    var appendData = '';
    searchResultMethodologyArray = [];
	searchResultMethodologyIdArray = [];

    $j.each(items, function(i, itemChkbox) {

       if ($j(itemChkbox).prop('checked')) 
		{
			searchResultMethodologyArray.push($j(itemChkbox).val());
			searchResultMethodologyIdArray.push($j(itemChkbox).attr('methodologyid'));





	
            appendData += '<p id=' + i + '>' + $j(itemChkbox).val() + '<i class="error selectedMethodologySearchResult"></i></p>';
        } 
         else 
		{
			if ($j(itemChkbox).prop('unchecked'))
			{
				searchResultMethodologyArray.slice($j(itemChkbox).val());
				searchResultMethodologyIdArray.slice($j(itemChkbox).attr('methodologyid'));
			}
        }
    });

   
    selectedItemsContainer.append(appendData);
    deleteSearchResultMethodology(searchResultMethodologyArray, selectedItemsContainer);

 //   alert("Select searchResultMethodologyArray.length-->"+searchResultMethodologyIdArray.length);


	 showFilterScroller();

	
}


/* This function is used for setting the Methodology initially
*/
function getSearchResultMethodologyValueInitial(selectedMethodologyFilters) 
{
	
	if(selectedMethodologyFilters.length>0)
	{


		var selectedItemsContainer = $j('#SearchResultMethodology');
		var appendData = '';
	   
		var items = $j('.methodologycheckBoxClass');
		
		 searchResultMethodologyArray = [];
		searchResultMethodologyIdArray = [];
	
		for(var k=0;k<selectedMethodologyFilters.length;k++) 
		{
			
			$j.each(items, function(i, itemChkbox) 
			{
			
				if(selectedMethodologyFilters[k] == $j(itemChkbox).attr('methodologyid'))
				{
					appendData += '<p id=' + k+ '>' + $j(this).val() + '<i class="selectedMethodologySearchResult error"></i></p>';
					$j(this).prop('checked', true);
					//  $j(".checkBoxClass").prop('checked', $j(this).prop('checked'));
					searchResultMethodologyArray[k]=$j(this).val();
					searchResultMethodologyIdArray[k]=selectedMethodologyFilters[k];				
				}
			});      

		}
	
		selectedItemsContainer.append(appendData);
		deleteSearchResultMethodology(searchResultMethodologyArray, selectedItemsContainer);
	}
}   

function deleteSearchResultMethodology(searchResultMethodologyArray, selectedItemsContainer) 
{
   //$j('p').find('.error').on('click', function() {
      $j('.selectedMethodologySearchResult').on('click', function() {
        var getId = $j(this).parent().text();

        removeSearchResultMethodology(searchResultMethodologyArray, getId);
       
		
		/** This is optimization for deleting the individual methodologies when many methodologies are selected. Instead of creating all the p tags with selected values again from scratch, we will now remove only the deleted value from the array and removing that p tag only. This will speed up the process. http://redmine.nvish.com/redmine/issues/705
		*/
		$j(this).parent().hide();
        //  updatedAppendSearchResultMethodology(searchResultMethodologyArray, selectedItemsContainer);
		changePointerEvent();
		
		showFilterScroller();
    });
}     

// this is for uncheck value for pop up
function removeSearchResultMethodology(searchResultMethodologyArray, getId) 
{
    var valueFindout=false;
	for (var i in searchResultMethodologyArray) 
	{
		if (searchResultMethodologyArray[i] == getId) 
		{
            searchResultMethodologyArray.splice(i, 1);
			searchResultMethodologyIdArray.splice(i, 1);
            $j( "#checkBoxes .methodologycheckBoxClass" ).each(function( index )
            {
                if( getId== $j(this).val())
                {
                    $j(this).attr('checked', false);
                    valueFindout=true;
                   return false; 
                }
            });
          
		} 
        if(valueFindout==true)
        {$j('#searchResultMethodologySelectAll').attr('checked', false);

            break;
        }
    }
}
 
function updatedAppendSearchResultMethodology(updatedemoArr, mycont)
{
    var appendData1 = '';
   
    if (updatedemoArr.length !== 0) 
	{
        
        for (var j = 0; j < updatedemoArr.length; j++) 
		{
            appendData1 += '<p id=' + j + '>' + updatedemoArr[j] + '<i class="error selectedMethodologySearchResult"></i></p>';
            mycont.empty();
            mycont.append(appendData1);
            deleteSearchResultMethodology(updatedemoArr, mycont);
        }
    } 
	else 
	{
        mycont.empty();
    }
}     

/* Methodology Filters Search Result Page Ends */



/* Advance search Search Within Starts */


function getAdvanceSearchWithinValue() {
    var selectedItemsContainer = $j('#searchWithinSections');
    var items = $j('.advancesearchWithinCheckBoxClass');

   
    selectedItemsContainer.empty();
    var appendData = '';
    
	advanceSearchWithinArray = [];
	advanceSearchWithinIdArray = [];

    $j.each(items, function(i, itemChkbox) {

       
        if ($j(itemChkbox).prop('checked')) {
       
            advanceSearchWithinArray.push($j(itemChkbox).val());
			
			advanceSearchWithinIdArray.push($j(itemChkbox).attr('searchwithinid'));
            appendData += '<p id=' + i + '>' + $j(itemChkbox).val() + '<i class="error"></i></p>';

        }


    });
    if(advanceSearchWithinArray.length==0)
     {
        $j('.search-in-style').fadeOut(0);

     }
    
    selectedItemsContainer.append(appendData);
   
	deleteAdvanceSearchWithin(advanceSearchWithinArray, selectedItemsContainer);
	
}

function deleteAdvanceSearchWithin(advanceSearchWithinArray, selectedItemsContainer) {
    $j('p').find('.error').on('click', function() {
  	
        var getId = $j(this).parent().text();
     
        removeAdvanceSearchWithin(advanceSearchWithinArray, getId);
        updatedAdvanceSearchWithinAppend(advanceSearchWithinArray, selectedItemsContainer);
    });
}


function removeAdvanceSearchWithin(advanceSearchWithinArray, getId) 
{
    var valueFindout=false;
	for (var i in advanceSearchWithinArray) 
	{
		if (advanceSearchWithinArray[i] == getId) 
		{
            advanceSearchWithinArray.splice(i, 1);
			advanceSearchWithinIdArray.splice(i, 1);
            $j( "#checkBoxes .advancesearchWithinCheckBoxClass" ).each(function( index )
            {
                if( getId== $j(this).val())
                {
                    $j(this).attr('checked', false);
                    valueFindout=true;                  
                    // break;
                }
            });
          
		} 
        if(valueFindout==true)
        {
		$j('#searchWithinSelectAll').attr('checked', false);
            break;
        }
    }
}


function updatedAdvanceSearchWithinAppend(advanceSearchWithinArray, mycont) {
    
    var appendData1 = '';
    
    if (advanceSearchWithinArray.length !== 0) {
        
        for (var j = 0; j < advanceSearchWithinArray.length; j++) {
            
            appendData1 += '<p id=' + j + '>' + advanceSearchWithinArray[j] + '<i class="error"></i></p>';
            mycont.empty();
            mycont.append(appendData1);

            deleteAdvanceSearchWithin(advanceSearchWithinArray, mycont);
            
        }
    } else {
        mycont.empty();       
        $j('.search-in-style').fadeOut(500);
    }

}


/* Advance search Search Within Ends */

/* Advance search Report Date Filters Ends */
function setAdvanceSearchReportDateFilters()
{
	var selValue = ($j("input[class='dateRange']:checked").val());     
	if(selValue!=undefined && selValue!='')
	{
		if(selValue=="Custom")
		{
			var customReportStartDate = $j("#customReportStartDate").val();
			var customReportEndDate = $j("#customReportEndDate").val();
			$j('#selected-advance-search-report-date').html(customReportStartDate);

               if(  ($j("#customReportStartDate").val().length== 0 ) &&  $j("#customReportEndDate").val().length == 0)
               {
					$j('#selected-advance-search-report-date').css('display','none');
					$j('#selected-advance-search-report-date-to').css('display','none');

					 $j('#advance-search-report-date .error').css("display","none");

               }

              else if($j("#customReportEndDate").val().length == 0 && $j("#customReportStartDate").val().length != 0)
               {
                      
               	    
               	    	$j('#selected-advance-search-report-date-to').css('display','none');
               	    	$j('#selected-advance-search-report-date').css('display','block');

               }

                 else if($j("#customReportEndDate").val().length != 0 && $j("#customReportStartDate").val().length == 0)
               			{

                          
               	                $j('#selected-advance-search-report-date-to').css('display','blcok');
               	    			$j('#selected-advance-search-report-date').css('display','none');

                				}

              else {
           	 
                $j('#selected-advance-search-report-date-to').html(customReportEndDate);
            	$j('#selected-advance-search-report-date-to').css('display','block');

           }  
			
		}//  custome code stop
		else
		{
         

			$j('#selected-advance-search-report-date').html(selValue + '<i class="error" onclick="clearReportDateFilters()" ></i>');
			$j('#selected-advance-search-report-date-to').css('display','none');


		}
		$j('#selected-advance-search-report-date').css('display','block');
		$j('#selected-advance-search-report-date').css({"padding":"6px 5px",'border-bottom':'1px solid #bbbbbb','text-align':'left'});
		$j('#advance-search-report-date').css({"background-color": "#3c9b86", "color": "#fff"});

        // set variable true to retain date pop up if date is available   There
       
		 // $j('#advance-search-report-date').hover(function(){ $j(this).find(".error").css("display","block"); },function(){ $j(this).find(".error").css("display","none"); });
        

			
		  $j('#selected-advance-search-report-date-to').css({"padding":"6px 5px",'text-align':'left'});
		  $j('#advance-search-report-date').css({"background-color": "#3c9b86", "color": "#fff"});

	}
	else
	{


		//$j('#selected-advance-search-report-date').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});
		$j('#advance-search-report-date').css({"background-color": "#e4eaeb", "color": "#5d5d5d"});

		// $j('#advance-search-report-date').hover(function(){ $j(this).find(".error").css("display","none"); });

		 $j('#advance-search-report-date .error').css("display","none");
	}
	showAllFiltersAdvanceSearchFlag=true;	
}


function changePointerEvent()
	{
		
		
		var reportDateFilter = $j("input[name='reportDateFilter']:checked").val();
		if(searchResultEndMarketIdArray.length>0 || searchResultCategoryIdArray.length>0 || searchResultBrandIdArray.length>0 || searchResultMethodologyIdArray.length>0 || (reportDateFilter!=undefined && reportDateFilter.trim()!="") )
		{
			$j('#filterBoxContent .applyFilterEvent').css('pointer-events','auto'); 
			$j('#filterClearAll').removeClass('searchWithInDisable');
			$j('#filterApply').removeClass('searchWithInDisable');
			
		}
		else
		{
			/* This check is for handling the scenario in case the pre filters are selected. In that case the Apply button to get active in case all the filters are removed
			*/
			if(preseverdatastatusCheck==true)
			{
				$j('#filterBoxContent .applyFilterEvent').css('pointer-events','auto'); 
				$j('#filterClearAll').removeClass('searchWithInDisable');
				$j('#filterApply').removeClass('searchWithInDisable');
			}
			else
			{
				$j('#filterBoxContent .applyFilterEvent').css('pointer-events','none'); 
				$j('#filterClearAll').addClass('searchWithInDisable');	
				$j('#filterApply').addClass('searchWithInDisable');
			}	
		}
		
		if(searchResultSearchWithinIdArray.length>0)
		{
			$j('.applySearchWithinEvent').css('pointer-events','auto'); 
			$j('#searchWithInClearAll').removeClass('searchWithInDisable');	
			$j('#searchWithInApply').removeClass('searchWithInDisable');	
		}
		else
		{
			/* This check is for handling the scenario in case the pre filters are selected. In that case the Apply button to get active in case all the filters are removed
			*/
			if(preserevedatastatusForCheckWithIn==true)
			{
				$j('.applySearchWithinEvent').css('pointer-events','auto'); 
				$j('#searchWithInClearAll').removeClass('searchWithInDisable');	
				$j('#searchWithInApply').removeClass('searchWithInDisable');	
			}
			else
			{
				$j('.applySearchWithinEvent').css('pointer-events','none'); 
				$j('#searchWithInClearAll').addClass('searchWithInDisable');
				$j('#searchWithInApply').addClass('searchWithInDisable');				
			}	
		}
	}
	
	
	function changePointerEventInitial()
	{
		
		var reportDateFilter = $j("input[name='reportDateFilter']:checked").val();
		if(searchResultEndMarketIdArray.length>0 || searchResultCategoryIdArray.length>0 || searchResultBrandIdArray.length>0 || searchResultMethodologyIdArray.length>0 || (reportDateFilter!=undefined && reportDateFilter.trim()!="") )
		{
			//$j('#filterBoxContent .applyFilterEvent').css('pointer-events','auto');
			$j('#filterClearAll').removeClass('searchWithInDisable');			
		}
		else
		{
			//$j('#filterBoxContent .applyFilterEvent').css('pointer-events','none'); 
			$j('#filterClearAll').addClass('searchWithInDisable');		
		}
		
		if(searchResultSearchWithinIdArray.length>0)
		{
			//$j('.applySearchWithinEvent').css('pointer-events','auto'); 	
			$j('#searchWithInClearAll').removeClass('searchWithInDisable');		
		}
		else
		{
			//$j('.applySearchWithinEvent').css('pointer-events','none'); 
			$j('#searchWithInClearAll').addClass('searchWithInDisable');			
		}
	}

$j(document).ready(function(){
	
	
	$j('.endmarketError').click(function(){
		getSearchResultEndMarketValue();
  
	});

	$j('p.advance-filter-subhead').find('.error').click (function() {
	
	  	deleteAdvanceSearchEndMarketFilter();
  });

	$j('p.advance-filter-subhead-brand').find('.error').click (function() {
	
	  	deleteAdvanceSearchBrandFilter();
  });

		// $j('p.advance-filter-subhead-methodology').find('.error').click (function() {
	
	 //  	deleteSearchResultMethodology();
  // });

  	$j('p.advance-filter-subheadcategory').find('.error').click (function() {
	
	  	deleteAdvanceSearchCategoryFilter();
  });



});

function checkAdvanceSearchAllFilltersArrayData()
{

   var dataStatus=false;

   if( advanceSearchBrandIdArray.length != 0 )
   {
      dataStatus=true;

   }

   	else if(advanceSearchMethodologyIdArray.length != 0)
   	{
dataStatus=true;

   	}
   		else if(advanceSearchEndMarketIdArray.length != 0)
   		{
   			dataStatus=true;
   		}
   			else if(advanceSearchCategoryIdArray.length != 0)
   			{
   				dataStatus=true;
   			}

     else
     {
     		dataStatus=false;
     }
   			


   			return dataStatus;
}


// check advance search report date value select 

function checkAdvanceSearchDateFilterSelectedValues()
{
    if($j('#selected-advance-search-report-date').text()=="")
    {
        return false;

    }
    else
    {
        return true;
    }
 
}

/** BOOLEAN SEARCH STARTS **/

	
		
		
	function   forAnyOf_These_Words()
	{
		forAll_Of_These_Words_New($j("#ALL_OF_THESE_WORDS").val(),$j("#NONE_OF_THESE_WORDS").val(),$j("#ANY_OF_THESE_WORDS").val(),$j("#THE_EXACT_PHARSE").val());
	}
	  
	function   for_The_Exact_Phrese()
	{
		forAll_Of_These_Words_New($j("#ALL_OF_THESE_WORDS").val(),$j("#NONE_OF_THESE_WORDS").val(),$j("#ANY_OF_THESE_WORDS").val(),$j("#THE_EXACT_PHARSE").val());
	}
	  
	function   for_None_Of_These_Words()
	{
		forAll_Of_These_Words_New($j("#ALL_OF_THESE_WORDS").val(),$j("#NONE_OF_THESE_WORDS").val(),$j("#ANY_OF_THESE_WORDS").val(),$j("#THE_EXACT_PHARSE").val());
	}
	 
	  
	function  resultantQuery(searchString)
	{

   
         $j('#advanceSearchMainInputbox').html('');

		// $j("#advanceSearchMainInputbox").val(searchString);
		$j("#advanceSearchMainInputbox").html(searchString);

		booleanTwoLineEllipsis();

	}
	
	var finalSearchString = "";	  
		
	

function   forAll_Of_These_Words_New(ALL_OF_THESE_WORDS,NONE_OF_THESE_WORDS,ANY_OF_THESE_WORDS,THE_EXACT_PHARSE)
	{

		
		//alert("ALL_OF_THESE_WORDS-->"+ALL_OF_THESE_WORDS);
		
		var anySearchString = createAdvanceSearchStringAny(ANY_OF_THESE_WORDS);
		var allSearchString=createAdvanceSearchStringAll(ALL_OF_THESE_WORDS);
		
		$j("#ALL_OF_THESE_WORDS_HIDDEN").val(ALL_OF_THESE_WORDS);
		
		var notSearchString=createAdvanceSearchStringNot(NONE_OF_THESE_WORDS);
		var exactSearchString = createAdvanceSearchStringExact(THE_EXACT_PHARSE);
		
		//var finalSearchString = anySearchString + " " + allSearchString + " " + notSearchString + " " + exactSearchString;
		
		 finalSearchString = "";
		
		if(anySearchString.trim()!="")
		{
			finalSearchString = anySearchString;
		}
		
		if(exactSearchString.trim()!="")
		{
			
			if(finalSearchString.trim()!="")
			{
				finalSearchString = finalSearchString + " "+exactSearchString;
			}
			else
			{
				finalSearchString = exactSearchString;
			}
		}
		
		
		if(allSearchString.trim()!="")
		{
			if(finalSearchString.trim()!="")
			{
				finalSearchString = finalSearchString + " & "+allSearchString;
			}
			else
			{
				finalSearchString = allSearchString;
			}
		}
		if(notSearchString.trim()!="")
		{
			if(finalSearchString.trim()!="")
			{
				finalSearchString = finalSearchString + " "+notSearchString;
			}
			else
			{
				finalSearchString = notSearchString;
			}
		}
		/*if(exactSearchString.trim()!="")
		{
			
			if(finalSearchString.trim()!="")
			{
				finalSearchString = finalSearchString + " "+exactSearchString;
			}
			else
			{
				finalSearchString = exactSearchString;
			}
		}
		*/
	
		//alert("finalSearchString==>"+finalSearchString);
		resultantQuery(finalSearchString);
		    
	}
	
	function createAdvanceSearchStringAll(searchString)
	{
		var modifiedString=searchString;
		//alert("modifiedString11==>"+modifiedString);
		if(searchString.indexOf(",")!=-1)
		{
			var splitCommaWords = searchString.split(",");
			
			for(var j=0;j<splitCommaWords.length;j++)
			{
				var commaStrings = '';
				if(splitCommaWords[j].indexOf(" ")!=-1)
				{
					
					
					var splitWords = splitCommaWords[j].split(" ");
					
					/*if(splitWords.length > 1)
					{
						commaStrings = "\"";
					}*/
					//alert("splitWords Len"+ splitWords.length);
					
					//var addQuote = false;
					for(var i=0;i<splitWords.length;i++)
					{
						if(splitWords[i].trim()!="")
						{
							//addQuote=true;
							//alert("commaStringBB==>"+commaStrings);
							if(commaStrings.trim()=="")
							{
								if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
								{
									commaStrings = commaStrings + splitWords[i].toLowerCase().trim(); 
								}
								else
								{
									commaStrings = commaStrings + splitWords[i].trim() ;
								}
								//alert("commaString11==>"+commaStrings);
							}
							else
							{
								if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
								{
									if(commaStrings!="")
									{
										commaStrings = commaStrings +" "+ splitWords[i].toLowerCase().trim(); 
									}
									else
									{
										commaStrings=splitWords[i].toLowerCase().trim();
									}	
								}
								else
								{
									if(commaStrings!="")
									{
										commaStrings = commaStrings +" "+ splitWords[i].trim() ;
									}
									else
									{
										commaStrings=splitWords[i].trim() ;
									}	
									
								}
								//alert("commaString22==>"+commaStrings);
							}
						}	
					}
					if(commaStrings.indexOf(" ")!=-1)
					{
						commaStrings = "\"" + commaStrings + "\"";
					}
					
					
				}
				else
				{
					if(j==0)
					{
						if(splitCommaWords[j]=="AND" || splitCommaWords[j]=="OR" || splitCommaWords[j]=="NOT")
						{
							commaStrings = splitCommaWords[j].toLowerCase().trim(); 
						}
						else
						{
							commaStrings = splitCommaWords[j].trim();
						}
					}
					else
					{
						if(splitCommaWords[j]=="AND" || splitCommaWords[j]=="OR" || splitCommaWords[j]=="NOT")
						{
							commaStrings = commaStrings +" " +splitCommaWords[j].toLowerCase().trim(); 
						}
						else
						{
							if(commaStrings!="")
							{
								commaStrings = commaStrings +" "+ splitCommaWords[j].trim();
							}
							else
							{
								commaStrings = commaStrings + splitCommaWords[j].trim();
							}	
						}
					}	
				}
				
				if(j==0)
				{
					modifiedString = commaStrings ;
				}
				else
				{
					if(commaStrings.trim()!="" && modifiedString.trim()!="")
					{
						modifiedString = modifiedString + " AND " +commaStrings ;
					}
					else if(commaStrings.trim()!="")
					{
						modifiedString = commaStrings ;
					}
					else if(modifiedString.trim()!="")
					{
						modifiedString = modifiedString ;
					}
				}
			}
		}
		else
		{
			if(searchString.indexOf(" ")!=-1)
			{
				
				var splitWords = searchString.split(" ");
				modifiedString = "";
				/*if(splitWords.length > 1)
				{
					modifiedString = "\"";
				}
				*/
				//alert("splitWords==>"+splitWords.length);
				for(var i=0;i<splitWords.length;i++)
				{
					if(splitWords[i].trim()!="")
					{
						
						if(i==0)
						{
							if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
							{
								modifiedString = modifiedString.trim() + splitWords[i].toLowerCase().trim(); 
							}
							else
							{
								modifiedString = modifiedString.trim() + splitWords[i].trim() ;
							}
						}
						else
						{
							if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
							{
								
								if(modifiedString.trim()!="")
								{
									modifiedString = modifiedString.trim() +" "+ splitWords[i].toLowerCase().trim(); 
								}
								else
								{
									modifiedString = splitWords[i].toLowerCase().trim(); 
								}
								
							}
							else
							{
								if(modifiedString.trim()!="")
								{
									modifiedString = modifiedString.trim() +" "+ splitWords[i].trim() ;
								}
								else
								{
									modifiedString = splitWords[i].trim() ;
								}
								
							}
						}
					}
				}
				//alert("modifiedString =="+modifiedString);
				if(modifiedString.indexOf(" ")!=-1)
				{
					modifiedString = "\"" + modifiedString + "\"";
				}
			}
			else
			{
				if(modifiedString=="AND" || modifiedString=="OR" || modifiedString=="NOT")
				{
					modifiedString = modifiedString.toLowerCase().trim(); 
				}
			}
		}
		return modifiedString;
	}
	
	function createAdvanceSearchStringAny(searchString)
	{
		var modifiedString=searchString;
		//alert("modifiedString11==>"+modifiedString);
		if(searchString.indexOf(",")!=-1)
		{
			var splitCommaWords = searchString.split(",");
			
			for(var j=0;j<splitCommaWords.length;j++)
			{
				var commaStrings = '';
				if(splitCommaWords[j].indexOf(" ")!=-1)
				{
					
					
					var splitWords = splitCommaWords[j].split(" ");
					
					/*if(splitWords.length > 1)
					{
						commaStrings = "\"";
					}*/
					//alert("splitWords Len"+ splitWords.length);
					
					//var addQuote = false;
					for(var i=0;i<splitWords.length;i++)
					{
						if(splitWords[i].trim()!="")
						{
							//addQuote=true;
							//alert("commaStringBB==>"+commaStrings);
							if(commaStrings.trim()=="")
							{
								if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
								{
									commaStrings = commaStrings + splitWords[i].toLowerCase().trim(); 
								}
								else
								{
									commaStrings = commaStrings + splitWords[i].trim() ;
								}
								//alert("commaString11==>"+commaStrings);
							}
							else
							{
								if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
								{
									commaStrings = commaStrings +" "+ splitWords[i].toLowerCase().trim(); 
								}
								else
								{
									if(commaStrings!="")
									{
										commaStrings = commaStrings +" "+ splitWords[i].trim() ;
									}
									else
									{
										commaStrings = splitWords[i].trim() ;
									}
								}
								//alert("commaString22==>"+commaStrings);
							}
						}	
					}
					if(commaStrings.indexOf(" ")!=-1)
					{
						commaStrings = "\"" + commaStrings + "\"";
					}
					
					
				}
				else
				{
					if(j==0)
					{
						if(splitCommaWords[j]=="AND" || splitCommaWords[j]=="OR" || splitCommaWords[j]=="NOT")
						{
							commaStrings = splitCommaWords[j].toLowerCase().trim(); 
						}
						else
						{
							commaStrings = splitCommaWords[j].trim();
						}
					}
					else
					{
						if(splitCommaWords[j]=="AND" || splitCommaWords[j]=="OR" || splitCommaWords[j]=="NOT")
						{
							commaStrings = commaStrings +" " +splitCommaWords[j].toLowerCase().trim(); 
						}
						else
						{
							if(commaStrings!="")
							{
								commaStrings = commaStrings +" "+ splitCommaWords[j].trim();
							}
							else
							{
								commaStrings = splitCommaWords[j].trim();
							}
						}
					}	
				}
				
				if(j==0)
				{
					modifiedString = commaStrings ;
				}
				else
				{
					if(commaStrings.trim()!="" && modifiedString.trim()!="")
					{
						modifiedString = modifiedString + " " +commaStrings ;
					}
					else if(commaStrings.trim()!="")
					{
						modifiedString = commaStrings ;
					}
					else if(modifiedString.trim()!="")
					{
						modifiedString = modifiedString ;
					}
				}
			}
		}
		else
		{
			if(searchString.indexOf(" ")!=-1)
			{
				
				var splitWords = searchString.split(" ");
				modifiedString = "";
				/*if(splitWords.length > 1)
				{
					modifiedString = "\"";
				}
				*/
				//alert("splitWords==>"+splitWords.length);
				for(var i=0;i<splitWords.length;i++)
				{
					if(splitWords[i].trim()!="")
					{
						
						if(i==0)
						{
							if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
							{
								modifiedString = modifiedString.trim() + splitWords[i].toLowerCase().trim(); 
							}
							else
							{
								modifiedString = modifiedString.trim() + splitWords[i].trim() ;
							}
						}
						else
						{
							if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
							{
								
								if(modifiedString.trim()!="")
								{
									modifiedString = modifiedString.trim() +" "+ splitWords[i].toLowerCase().trim(); 
								}
								else
								{
									modifiedString = splitWords[i].toLowerCase().trim(); 
								}
								
							}
							else
							{
								if(modifiedString.trim()!="")
								{
									modifiedString = modifiedString.trim() +" "+ splitWords[i].trim() ;
								}
								else
								{
									modifiedString = splitWords[i].trim() ;
								}
								
							}
						}
					}
				}
				//alert("modifiedString =="+modifiedString);
				if(modifiedString.indexOf(" ")!=-1)
				{
					modifiedString = "\"" + modifiedString + "\"";
				}
			}
			else
			{
				if(modifiedString=="AND" || modifiedString=="OR" || modifiedString=="NOT")
				{
					modifiedString = modifiedString.toLowerCase().trim(); 
				}
			}
		}
		// alert(" dfdsa"+modifiedString);
		return modifiedString;
	}
	
	function createAdvanceSearchStringNot(searchString)
	{
		var modifiedString=searchString;
		//alert("modifiedString11==>"+modifiedString);
		if(searchString.indexOf(",")!=-1)
		{
			var splitCommaWords = searchString.split(",");
			
			for(var j=0;j<splitCommaWords.length;j++)
			{
				var commaStrings = '';
				if(splitCommaWords[j].indexOf(" ")!=-1)
				{
					
					
					var splitWords = splitCommaWords[j].split(" ");
					
					/*if(splitWords.length > 1)
					{
						commaStrings = "\"";
					}*/
					//alert("splitWords Len"+ splitWords.length);
					
					//var addQuote = false;
					for(var i=0;i<splitWords.length;i++)
					{
						if(splitWords[i].trim()!="")
						{
						//	addQuote=true;
							//alert("commaStringBB==>"+commaStrings);
							if(commaStrings.trim()=="")
							{
								if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
								{
									commaStrings = commaStrings + splitWords[i].toLowerCase().trim(); 
								}
								else
								{
									commaStrings = commaStrings + splitWords[i].trim() ;
								}
								//alert("commaString11==>"+commaStrings);
							}
							else
							{
								if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
								{
									if(commaStrings!="")
									{
										commaStrings = commaStrings +" "+ splitWords[i].toLowerCase().trim(); 
									}
									else
									{
										commaStrings = splitWords[i].toLowerCase().trim(); 
									}
									
								}
								else
								{
									if(commaStrings!="")
									{
										commaStrings = commaStrings +" "+ splitWords[i].trim() ;
									}
									else
									{
										commaStrings = splitWords[i].trim() ;
									}	
								}
								//alert("commaString22==>"+commaStrings);
							}
						}	
					}
					if(commaStrings.indexOf(" ")!=-1)
					{
						commaStrings = "\"" + commaStrings + "\"";
					}
					
					
				}
				else
				{
					if(j==0)
					{
						if(splitCommaWords[j]=="AND" || splitCommaWords[j]=="OR" || splitCommaWords[j]=="NOT")
						{
							commaStrings = splitCommaWords[j].toLowerCase().trim(); 
						}
						else
						{
							commaStrings = splitCommaWords[j].trim();
						}
					}
					else
					{
						if(splitCommaWords[j]=="AND" || splitCommaWords[j]=="OR" || splitCommaWords[j]=="NOT")
						{
							if(commaStrings.trim()!="")
							{
								commaStrings = commaStrings +" " +splitCommaWords[j].toLowerCase().trim(); 
							}
							else
							{
								commaStrings = splitCommaWords[j].toLowerCase().trim(); 
							}
							
						}
						else
						{
							
							if(commaStrings.trim()!="")
							{
								commaStrings = commaStrings +" "+ splitCommaWords[j].trim();
							}
							else
							{
								commaStrings = splitCommaWords[j].trim();
							}
						}
					}	
				}
				
				if(j==0)
				{
					modifiedString = commaStrings ;
				}
				else
				{
					if(commaStrings.trim()!="" && modifiedString.trim()!="")
					{
						modifiedString = modifiedString + " NOT " +commaStrings ;
					}
					else if(commaStrings.trim()!="")
					{
						modifiedString = commaStrings ;
					}
					else if(modifiedString.trim()!="")
					{
						modifiedString = modifiedString ;
					}
				}
			
			}
			if(modifiedString.trim()!="")
			{
				modifiedString = "NOT " + modifiedString;
			}
		}
		else
		{
			if(searchString.indexOf(" ")!=-1)
			{
				
				var splitWords = searchString.split(" ");
				modifiedString = "";
				/*if(splitWords.length > 1)
				{
					modifiedString = "\"";
				}
				*/
				//alert("splitWords==>"+splitWords.length);
				for(var i=0;i<splitWords.length;i++)
				{
					if(splitWords[i].trim()!="")
					{
						
						if(i==0)
						{
							if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
							{
								modifiedString = modifiedString.trim() + splitWords[i].toLowerCase().trim(); 
							}
							else
							{
								modifiedString = modifiedString.trim() + splitWords[i].trim() ;
							}
						}
						else
						{
							if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
							{
								
								if(modifiedString.trim()!="")
								{
									modifiedString = modifiedString.trim() +" "+ splitWords[i].toLowerCase().trim(); 
								}
								else
								{
									modifiedString = splitWords[i].toLowerCase().trim(); 
								}
								
							}
							else
							{
								if(modifiedString.trim()!="")
								{
									modifiedString = modifiedString.trim() +" "+ splitWords[i].trim() ;
								}
								else
								{
									modifiedString = splitWords[i].trim() ;
								}
								
							}
						}
					}
				}
				//alert("modifiedString =="+modifiedString);
				if(modifiedString.indexOf(" ")!=-1)
				{
					modifiedString = "\"" + modifiedString + "\"";
				}
			}
			else
			{
				if(modifiedString=="AND" || modifiedString=="OR" || modifiedString=="NOT")
				{
					modifiedString = modifiedString.toLowerCase().trim(); 
				}
			}
			
			if(modifiedString.trim()!="")
			{
				modifiedString = "NOT " + modifiedString;
			}
		}
		return modifiedString;
	}
	
	
	function createAdvanceSearchStringExact(searchString)
	{
		var modifiedString=searchString;
		//alert("modifiedString11==>"+modifiedString);
		if(searchString.indexOf(",")!=-1)
		{
			var splitCommaWords = searchString.split(",");
			
			for(var j=0;j<splitCommaWords.length;j++)
			{
				var commaStrings = '';
				if(splitCommaWords[j].indexOf(" ")!=-1)
				{
					var splitWords = splitCommaWords[j].split(" ");
					
					/*if(splitWords.length > 1)
					{
						commaStrings = "\"";
					}*/
					//alert("splitWords Len"+ splitWords.length);
					
					//var addQuote = false;
					for(var i=0;i<splitWords.length;i++)
					{
						if(splitWords[i].trim()!="")
						{
							//addQuote=true;
							//alert("commaStringBB==>"+commaStrings);
							if(commaStrings.trim()=="")
							{
								if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
								{
									commaStrings = commaStrings + splitWords[i].toLowerCase().trim(); 
								}
								else
								{
									commaStrings = commaStrings + splitWords[i].trim() ;
								}
								//alert("commaString11==>"+commaStrings);
							}
							else
							{
								if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
								{
									commaStrings = commaStrings +" "+ splitWords[i].toLowerCase().trim(); 
								}
								else
								{
									commaStrings = commaStrings +" "+ splitWords[i].trim() ;
								}
								//alert("commaString22==>"+commaStrings);
							}
						}	
					}
					/*if(commaStrings.indexOf(" ")!=-1)
					{
						commaStrings = "\"" + commaStrings + "\"";
					}*/
					if(commaStrings.trim()!="")
					{
						commaStrings = "\"" + commaStrings + "\"";
					}	
					
				}
				else
				{
					if(j==0)
					{
						if(splitCommaWords[j]=="AND" || splitCommaWords[j]=="OR" || splitCommaWords[j]=="NOT")
						{
							commaStrings = splitCommaWords[j].toLowerCase().trim(); 
						}
						else
						{
							commaStrings = splitCommaWords[j].trim();
						}
					}
					else
					{
						if(splitCommaWords[j]=="AND" || splitCommaWords[j]=="OR" || splitCommaWords[j]=="NOT")
						{
							commaStrings = commaStrings.trim() +" " +splitCommaWords[j].toLowerCase().trim(); 
						}
						else
						{
							commaStrings = commaStrings.trim() +" "+ splitCommaWords[j].trim();
						}
					}
					
					if(commaStrings.trim()!="")
					{
						commaStrings = "\"" + commaStrings.trim() + "\"";
					}	
					
				}
				
				if(j==0)
				{
					modifiedString = commaStrings ;
				}
				else
				{
					if(commaStrings.trim()!="" && modifiedString.trim()!="")
					{
						modifiedString = modifiedString + " " +commaStrings ;
					}
					else if(commaStrings.trim()!="")
					{
						modifiedString = commaStrings ;
					}
					else if(modifiedString.trim()!="")
					{
						modifiedString = modifiedString ;
					}
				}
			}
		}
		else
		{
			if(searchString.indexOf(" ")!=-1)
			{
				
				var splitWords = searchString.split(" ");
				modifiedString = "";
				/*if(splitWords.length > 1)
				{
					modifiedString = "\"";
				}
				*/
				//alert("splitWords==>"+splitWords.length);
				for(var i=0;i<splitWords.length;i++)
				{
					if(splitWords[i].trim()!="")
					{
						
						if(i==0)
						{
							if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
							{
								modifiedString = modifiedString.trim() + splitWords[i].toLowerCase().trim(); 
							}
							else
							{
								modifiedString = modifiedString.trim() + splitWords[i].trim() ;
							}
						}
						else
						{
							if(splitWords[i]=="AND" || splitWords[i]=="OR" || splitWords[i]=="NOT")
							{
								
								if(modifiedString.trim()!="")
								{
									modifiedString = modifiedString.trim() +" "+ splitWords[i].toLowerCase().trim(); 
								}
								else
								{
									modifiedString = splitWords[i].toLowerCase().trim(); 
								}
								
							}
							else
							{
								if(modifiedString.trim()!="")
								{
									modifiedString = modifiedString.trim() +" "+ splitWords[i].trim() ;
								}
								else
								{
									modifiedString = splitWords[i].trim() ;
								}
								
							}
						}
					}
				}
				//alert("modifiedString =="+modifiedString);
				if(modifiedString.trim()!="")
				{
					modifiedString = "\"" + modifiedString + "\"";
				}
			}
			else
			{
				if(modifiedString=="AND" || modifiedString=="OR" || modifiedString=="NOT")
				{
					modifiedString = modifiedString.toLowerCase().trim(); 
				}
				if(modifiedString.trim()!="")
				{
					modifiedString = "\"" + modifiedString + "\"";
				}
			}
		}
		return modifiedString;
	}
	
	function  recodeSearchString()
	{
		
		var searchString = $j("#searchText").val();
		searchString = searchString + " ";
		
		var exactMatchString = "";
		var notString = "";
		var anyofTheseWordString = "";
		var allofTheseWordString = "";
		
		// This is for replacing all the copied quotes to keyboard quotes
		searchString = searchString.replace(/(“|”)/g, "\""); 

		
		// This is done as we are manually adding & sign between ANY/EXACT words and AND keywords. As per UAT users request
		searchString = searchString.replace(" & ", " ")	
		
		// STEP 1 STARTS
		var quoteCount = find_occurences(searchString,'"');
		//alert("quoteCount==>"+quoteCount);
		
		if(quoteCount % 2 == 0)
		{
			//alert("Even Quote");
		}
		else
		{
			//alert("Odd Quote");
			var strReplacedWith="";
			var currentIndex = searchString.lastIndexOf("\"");
			searchString = searchString.substring(0, currentIndex) + strReplacedWith + searchString.substring(currentIndex + 1, searchString.length);
			//alert("Search String after replacing with rightmost quote==>"+searchString);

		}
		// STEP 1 ENDS
		
		
		// STEP 3 STARTS
		
		var quotedWords = getFromBetween.get(searchString,"\"","\"");
		//alert("quotedWords==>"+quotedWords);
		for(var i=0;i<quotedWords.length;i++)
		{
			var lowerCaseAND = quotedWords[i].replace(/ AND /g, " and ");
			
			//alert("firstWord AND ==>"+firstWord(lowerCaseAND));
			if(firstWord(lowerCaseAND)=="AND")
			{
				lowerCaseAND = lowerCaseAND.replace("AND", "and")
			}
			if(lastWord(lowerCaseAND)=="AND")
			{
				var strReplacedWith="and";
				var currentIndex = lowerCaseAND.lastIndexOf("AND");
				lowerCaseAND = lowerCaseAND.substring(0, currentIndex) + strReplacedWith + lowerCaseAND.substring(currentIndex + 3, lowerCaseAND.length);
			}
			//alert("lastWord AND ==>"+lastWord(lowerCaseAND));
			
			var lowerCaseNOT = lowerCaseAND.replace(/ NOT /g, " not ");
			
			if(firstWord(lowerCaseNOT)=="NOT")
			{
				lowerCaseNOT = lowerCaseNOT.replace("NOT", "not")
			}
			if(lastWord(lowerCaseNOT)=="NOT")
			{
				var strReplacedWith="not";
				var currentIndex = lowerCaseNOT.lastIndexOf("NOT");
				lowerCaseNOT = lowerCaseNOT.substring(0, currentIndex) + strReplacedWith + lowerCaseNOT.substring(currentIndex + 3, lowerCaseNOT.length);
			}
			var lowerCaseOR = lowerCaseNOT.replace(/ OR /g, " or ");
			
			if(firstWord(lowerCaseOR)=="OR")
			{
				lowerCaseOR = lowerCaseOR.replace("OR", "or")
			}
			if(lastWord(lowerCaseOR)=="OR")
			{
				var strReplacedWith="or";
				var currentIndex = lowerCaseOR.lastIndexOf("OR");
				lowerCaseOR = lowerCaseOR.substring(0, currentIndex) + strReplacedWith + lowerCaseOR.substring(currentIndex + 2, lowerCaseOR.length);
			}
			
			searchString=searchString.replace("\"" + quotedWords[i] + "\"","\"" + lowerCaseOR + "\"");
			
			//alert("searchString STEP 3==>"+searchString);
		}
		
		// STEP 3 ENDS
		
		// STEP 2 STARTS
		
		if(firstWordWithoutQuote(searchString)=="AND")
		{
			searchString = searchString.replace("AND", "")
		}
		if(lastWordWithoutQuote(searchString)=="AND")
		{
			var strReplacedWith="";
			var currentIndex = searchString.lastIndexOf("AND");
			searchString = searchString.substring(0, currentIndex) + strReplacedWith + searchString.substring(currentIndex + 3, searchString.length);
		}
		
		if(lastWordWithoutQuote(searchString)=="NOT")
		{
			var strReplacedWith="";
			var currentIndex = searchString.lastIndexOf("NOT");
			searchString = searchString.substring(0, currentIndex) + strReplacedWith + searchString.substring(currentIndex + 3, searchString.length);
		}
		
		if(firstWordWithoutQuote(searchString)=="OR")
		{
			searchString = searchString.replace("OR", "")
		}
		if(lastWordWithoutQuote(searchString)=="OR")
		{
			var strReplacedWith="";
			var currentIndex = searchString.lastIndexOf("OR");
			searchString = searchString.substring(0, currentIndex) + strReplacedWith + searchString.substring(currentIndex + 2, searchString.length);
		}
		
		//alert("searchString STEP 2==>"+searchString);
		// STEP 2 ENDS
		
		// STEP 4 STARTS
		
		searchString = searchString.replace(/ OR /g, " ");
		//alert("searchString STEP 4==>"+searchString);
			
		// STEP 4 ENDS
		
		// STEP 5 STARTS
		
		searchString = searchString.replace(/ AND AND /g, " AND ");
		searchString = searchString.replace(/ NOT NOT /g, " NOT ");
		searchString = searchString.replace(/ AND NOT /g, " NOT ");
		searchString = searchString.replace(/ NOT AND /g, " AND ");
		
		searchString = searchString.replace(/ AND AND /g, " AND ");
		searchString = searchString.replace(/ NOT NOT /g, " NOT ");
		searchString = searchString.replace(/ AND NOT /g, " NOT ");
		searchString = searchString.replace(/ NOT AND /g, " AND ");
		if(searchString.startsWith("NOT AND "))
		{
			searchString = searchString.replace(/NOT AND /g, "AND ");
		}
		
	//	alert("searchString STEP 5==>"+searchString);		
		// STEP 5 ENDS
		
		// Replace all the multiple spaces with single space
		searchString = searchString.replace(/  /g, " ");
		
	//	alert("searchString STEP 6==>"+searchString);
		
		if(searchString.trim()!="" )
		{ 
			var notResult = [];
			notResult = getFromBetweenNotQuotes.get(searchString,"NOT \"","\"");
			//alert("Not Match result with quotes BEFORE==>"+notResult);
			if(notResult!="")
			{
				for(var i=0;i<notResult.length;i++)
				{
					searchString=searchString.replace("NOT \"" + notResult[i] + "\"","");
				}
			}
			//alert("Search string after replace ==>"+ searchString);
			var notResult1 = getFromBetween.get(searchString,"NOT "," ");
			//alert("Not Match result with quotes==>"+notResult);
			
			
			//searchString = searchString.replace("NOT " +notResult1,"");
			if(notResult1!="")
			{
				for(var i=0;i<notResult1.length;i++)
				{
					searchString=searchString.replace("NOT " + notResult1[i] ,"");
				}
			}
			if(notResult!="" && notResult1!="")
			{
				//notString = notResult +","+ notResult1.toString().replace(/,/g,'').replace(/["'{}()]/g,"");
				notString = notResult +", "+ notResult1.toString().replace(/["'{}()]/g,"");
				
			}
			else
			{
				notString = notResult + notResult1.toString().replace(/["'{}()]/g,"");
			}
			
			notString = notString.split(',').join(', ');
			//alert("Search string Beofre replace exactMatchResult ==>"+ searchString);
		
			// ALL OF THESE WORDS RECODING
		/*	var searchString1 = searchString;
			if(searchString.indexOf(" AND ")!=-1)
			{
				var splitAndWords = searchString.split(" AND ");
			}
			*/
			// Exact Match Quoted String recoding starts here
			var exactMatchResult = [];
			exactMatchResult = getFromBetween.get(searchString,"\"","\"");
			
			//alert("Search String Before ==>"+searchString);
			
			if(exactMatchResult!="")
			{
				for(var i=0;i<exactMatchResult.length;i++)
				{
					if((searchString.indexOf("AND "+ "\"" + exactMatchResult[i] + "\"") ==-1) && (searchString.indexOf("\"" + exactMatchResult[i] + "\"" + " AND")==-1) )
					{
						searchString=searchString.replace("\"" + exactMatchResult[i] + "\""," ");
						
						//alert("Evact Match result[i]==>"+exactMatchResult[i]);
						
						if(exactMatchString!="")
						{
							exactMatchString = exactMatchString + ", " + exactMatchResult[i];
						}
						else
						{
							exactMatchString = exactMatchString + exactMatchResult[i];
						}
					}
				}
			}
			
			/*
			alert("Search string Beofre ALLOF WORD ==>"+ searchString);
			if((searchString.indexOf("AND "+ "\"" + exactMatchResult + "\"")==-1) && (searchString.indexOf("\"" + exactMatchResult + "\"" + " AND")==-1) )
			{
				alert("Inside AND Blocl");
			}
			else
			{
				searchString=searchString.replace("\"" + exactMatchResult + "\"","");
				//exactMatchString = exactMatchResult;
				alert("exactMatchString ==>"+ exactMatchString);
				//alert("Search string after replace exactMatchResult ==>"+ searchString);
			}
			alert("Search string After ALLOF WORD ==>"+ searchString);
			*/
			
			// All of these words (AND) String recoding starts here
			
			//searchString=searchString.replaceAll(" NOT "," AND ");
			
			//alert("Search string Beofre ALLOF WORD ==>"+ searchString);
			
			searchString = searchString.replace(/ OR /g, " ");
			
			if(searchString.indexOf(" AND ")!=-1)
			{
				searchString = searchString.replace(/,/g,' ').replace(/['{}()]/g,"");
				var splitWords = searchString.split(" AND ");
				
				searchString = searchString.replace(/ AND /g, " ");
				
				var modifiedWords = "";
				for(var i=0;i<splitWords.length;i++)
				{
					
					if(i==0)
					{
						
						modifiedWords="";
						modifiedWords = lastWord(splitWords[i]);
						//alert("lastword==>"+modifiedWords);
						
						searchString = searchString.replace(modifiedWords,"");
						if(allofTheseWordString.indexOf(modifiedWords)==-1)
						{
							if(modifiedWords!=""&& allofTheseWordString.trim()!="")
							{
								allofTheseWordString = allofTheseWordString + ", "+ modifiedWords;
							}
							else
							{
								allofTheseWordString = allofTheseWordString+modifiedWords;
							}	
						}	
					}
					else if(i==splitWords.length-1)
					{
						
						modifiedWords="";
						modifiedWords = firstWord(splitWords[i]);
						//alert("firstWord==>"+modifiedWords);
						searchString = searchString.replace(modifiedWords,"");
						if(allofTheseWordString.indexOf(modifiedWords)==-1)
						{
							if(modifiedWords!=""&& allofTheseWordString.trim()!="")
							{
								allofTheseWordString = allofTheseWordString + ", "+ modifiedWords;
							}
							else
							{
								allofTheseWordString = allofTheseWordString+modifiedWords;
							}	
						}	
					}
					else
					{
						
						modifiedWords="";
						modifiedWords = firstWord(splitWords[i+1]);
						//alert("firstWord==>"+modifiedWords);
						searchString = searchString.replace(modifiedWords,"");
						
						if(allofTheseWordString.indexOf(modifiedWords)==-1)
						{
							if(modifiedWords!=""&& allofTheseWordString.trim()!="")
							{
								allofTheseWordString = allofTheseWordString + ", "+ modifiedWords;
							}
							else
							{
								allofTheseWordString = allofTheseWordString+modifiedWords;
							}
						}
						modifiedWords="";
						modifiedWords = lastWord(splitWords[i]);
						
					//alert("lastWord==>"+modifiedWords);
						searchString = searchString.replace(modifiedWords,"");
						
						if(allofTheseWordString.indexOf(modifiedWords)==-1)
						{
							if(modifiedWords!=""&& allofTheseWordString.trim()!="")
							{
								allofTheseWordString = allofTheseWordString + ", "+ modifiedWords;
							}
							else
							{
								allofTheseWordString = allofTheseWordString+modifiedWords;
							}
						}
					}
					
					
					
					
					
					/*
					if(splitWords[i].trim()!="")
					{
						var splitWordsSpace = splitWords[i].split(" ");
						for(var j=0;j<splitWordsSpace.length;j++)
						{
							modifiedWords=splitWordsSpace[j].trim().replace(/,/g,'').replace(/["'{}()]/g,"");
						}
					//	alert("modifiedWords==>"+modifiedWords);
					}
					if(modifiedWords!="")
					{
						allofTheseWordString = allofTheseWordString + " "+ modifiedWords;
					}
					else
					{
						allofTheseWordString = allofTheseWordString+modifiedWords;
					}*/
					
					//alert("modifiedWords==>"+modifiedWords);
					//alert("allofTheseWordString==>"+allofTheseWordString);
				
					/*
					if(modifiedWords.trim()!=""&& allofTheseWordString.trim()!="")
					{
						allofTheseWordString = allofTheseWordString + ","+ modifiedWords;
					}
					else
					{
						allofTheseWordString = allofTheseWordString+modifiedWords;
					}*/
				}
				
				//alert("searchString==>"+searchString);
				var splitWordsAny = searchString.split(" ");
				modifiedWords = "";
				for(var i=0;i<splitWordsAny.length;i++)
				{
					splitWordsAny[i] = splitWordsAny[i].replace(/,/g,'').replace(/["'{}()]/g,"");
					if(splitWordsAny[i].trim()!="" && splitWordsAny[i]!="AND")
					{
						if(modifiedWords!="")
						{
							modifiedWords=modifiedWords+", "+splitWordsAny[i].trim().replace(/,/g,'').replace(/["'{}()]/g,"");
						}
						else
						{
							modifiedWords=splitWordsAny[i].trim().replace(/,/g,'').replace(/["'{}()]/g,"");
						}
					}
					anyofTheseWordString = modifiedWords;
				}
				
			}
			else
			{
				var splitWords = searchString.split(" ");
				var modifiedWords = "";
				for(var i=0;i<splitWords.length;i++)
				{
					if(splitWords[i].trim()!="")
					{
						if(modifiedWords!="")
						{
							modifiedWords=modifiedWords+", "+splitWords[i].trim().replace(/,/g,' ').replace(/["'{}()]/g,"");
						}
						else
						{
							modifiedWords=splitWords[i].trim().replace(/,/g,' ').replace(/["'{}()]/g,"");
						}
					}
				}
			
				anyofTheseWordString = modifiedWords;
			}
			
			
		}
		//alert("allofTheseWordString==>"+allofTheseWordString);
		

		$j("#ANY_OF_THESE_WORDS").val(anyofTheseWordString);
		$j("#ALL_OF_THESE_WORDS").val(allofTheseWordString);
		$j("#NONE_OF_THESE_WORDS").val(notString);
		$j("#THE_EXACT_PHARSE").val(exactMatchString);
		
		
		
	//	alert("Not String ==>"+ notString);
		

		forAll_Of_These_Words_New($j("#ALL_OF_THESE_WORDS").val(),$j("#NONE_OF_THESE_WORDS").val(),$j("#ANY_OF_THESE_WORDS").val(),$j("#THE_EXACT_PHARSE").val());


	}
	
	function find_occurences(str, char_to_count)
	{
		return str.split(char_to_count).length - 1;
	}

	var lastWord= function(str) {
	  if (str.trim() === ""){
		return "";
	  } else {   
		
		if(str.indexOf("\"")!=-1)
		{
			var splitStr = str.split('"');
			splitStr = splitStr.filter(lengthFilter);
			return splitStr[splitStr.length - 1];
		}
		else
		{
			var splitStr = str.split(' ');
			splitStr = splitStr.filter(lengthFilter);
			return splitStr[splitStr.length - 1];
		}
	  }
	};
	
	var firstWord= function(str) {
	  if (str.trim() === ""){
		return "";
	  } else {   
		
		
		if(str.indexOf("\"")!=-1)
		{
			var splitStr = str.split('"');
			splitStr = splitStr.filter(lengthFilter);
			return splitStr[0];
		}
		else
		{
			var splitStr = str.split(' ');
			splitStr = splitStr.filter(lengthFilter);
			return splitStr[0];
		}	
	  }
	  
	};
	
	var lastWordWithoutQuote= function(str) {
	  if (str.trim() === ""){
		return "";
	  } else {   
		
		
			var splitStr = str.split(' ');
			splitStr = splitStr.filter(lengthFilter);
			return splitStr[splitStr.length - 1];
		
	  }
	};
	
	var firstWordWithoutQuote= function(str) {
	  if (str.trim() === ""){
		return "";
	  } else {   
		
		
		
			var splitStr = str.split(' ');
			splitStr = splitStr.filter(lengthFilter);
			return splitStr[0];
		
	  }
	  
	};

	var lengthFilter = function(str){
		return str.length >= 1;
	};
	var getFromBetween = {
    results:[],
    string:"",
    getFromBetween:function (sub1,sub2) {
        if(this.string.indexOf(sub1) < 0 || this.string.indexOf(sub2) < 0) return false;
        var SP = this.string.indexOf(sub1)+sub1.length;
        var string1 = this.string.substr(0,SP);
        var string2 = this.string.substr(SP);
        var TP = string1.length + string2.indexOf(sub2);
        return this.string.substring(SP,TP);
    },
    removeFromBetween:function (sub1,sub2) {
        if(this.string.indexOf(sub1) < 0 || this.string.indexOf(sub2) < 0) return false;
        var removal = sub1+this.getFromBetween(sub1,sub2)+sub2;
        this.string = this.string.replace(removal,"");
    },
    getAllResults:function (sub1,sub2) {
        // first check to see if we do have both substrings
        if(this.string.indexOf(sub1) < 0 || this.string.indexOf(sub2) < 0) return;

        // find one result
        var result = this.getFromBetween(sub1,sub2);
        // push it to the results array
        this.results.push(result);
        // remove the most recently found one from the string
        this.removeFromBetween(sub1,sub2);

        // if there's more substrings
        if(this.string.indexOf(sub1) > -1 && this.string.indexOf(sub2) > -1) {
            this.getAllResults(sub1,sub2);
        }
        else return;
    },
    get:function (string,sub1,sub2) {
        this.results = [];
        this.string = string;
        this.getAllResults(sub1,sub2);
        return this.results;
    }
};

var getFromBetweenNotQuotes = {
    results:[],
    string:"",
    getFromBetween:function (sub1,sub2) {
        if(this.string.indexOf(sub1) < 0 || this.string.indexOf(sub2) < 0) return false;
        var SP = this.string.indexOf(sub1)+sub1.length;
        var string1 = this.string.substr(0,SP);
        var string2 = this.string.substr(SP);
        var TP = string1.length + string2.indexOf(sub2);
        return this.string.substring(SP,TP);
    },
    removeFromBetween:function (sub1,sub2) {
        if(this.string.indexOf(sub1) < 0 || this.string.indexOf(sub2) < 0) return false;
        var removal = sub1+this.getFromBetween(sub1,sub2)+sub2;
        this.string = this.string.replace(removal,"");
    },
    getAllResults:function (sub1,sub2) {
        // first check to see if we do have both substrings
        if(this.string.indexOf(sub1) < 0 || this.string.indexOf(sub2) < 0) return;

        // find one result
        var result = this.getFromBetween(sub1,sub2);
        // push it to the results array
        this.results.push(result);
        // remove the most recently found one from the string
        this.removeFromBetween(sub1,sub2);

        // if there's more substrings
        if(this.string.indexOf(sub1) > -1 && this.string.indexOf(sub2) > -1) {
            this.getAllResults(sub1,sub2);
        }
        else return;
    },
    get:function (string,sub1,sub2) {
        this.results = [];
        this.string = string;
        this.getAllResults(sub1,sub2);
        return this.results;
    }
};

function booleanTwoLineEllipsis(){

  	          var flag=false;

  	            var textLength = $j("#advanceSearchMainInputbox").text().length;

                  // for single line
  	            if(textLength <= 127){
  	            	

                       flag=false;
  	            	   $j('#booleanUpperTextBar').css('height','28px');
  	            	
  	            } 
  	              // double line...
  	            else if(textLength>=127 && textLength<=251)
  	            {
  	            	  
  	            	   flag=false;
  	            	  $j('#booleanUpperTextBar').css({'height':'42px'});
                    
  	            }


  	             
  	            // alert(textLength);

                  else if(textLength>=252)
                   {
                   	
                   var textContentP=$j('#advanceSearchMainInputbox'); 
				     var divh=$j('#booleanUpperTextBar').height();
				     var Pheight = $j(textContentP).outerHeight();
				     console.log('Pheight'+Pheight);// yes
				     console.log('div height'+divh);

                        // get 251 characters from orinal string.  then apply

                         var substring=$j('#advanceSearchMainInputbox').text().substring(0,240);
                             $j('#advanceSearchMainInputbox').text(substring);
                             textContentP=$j('#advanceSearchMainInputbox');   





                        // $j('#booleanUpperTextBar').css({'height':'42px'});


				     if ($j(textContentP).outerHeight()>divh) {
					
				    $j(textContentP).text(function (index, text) {

				    	
				        return text.replace(/\W*\s(\S)*$/, '...');
				    });

                    $j('#booleanUpperTextBar').css({'height':'42px'});


				}//  if close
			}

				//  else if(textLength>=252)

				// {

				// 	  //for show  full data
				// 	  
                  // $j('#booleanUpperTextBar').css('height','auto');
    // //                   return false;

				// // }

		
				
                 

      }


      function showFilterScroller()
      {

      	var totalFilterLength = searchResultMethodologyIdArray.length + searchResultEndMarketIdArray.length + searchResultCategoryIdArray.length + searchResultBrandIdArray.length ;

      	var selValue = ($j("input[class='dateRange']:checked").val());

     

      	if(selValue!=undefined && selValue!="")
      	{
      		totalFilterLength = totalFilterLength + 1;
      	}

      //	alert("totalFilterLength"+totalFilterLength);
      	 if(totalFilterLength >=1 &&  ($j('.popup').is(":visible")) )
	     {
	     	// alert(1);
	     	$j('.addMarginToSearchOuterWrap .column.left').addClass('testDemo');

	     } 
	     //else if(searchResultMethodologyArray.length>=1 &&  ($j('.popup').is(":visible")) )
	     else if( ($j('#search-with-in').is(':visible')) && ($j('.popup').is(':visible')))
	     {
	     //	alert(2)
	     	$j('.addMarginToSearchOuterWrap .column.left').addClass('testDemo');

	     } 
	     else{
	     	// alert(3);
	     	$j('.addMarginToSearchOuterWrap .column.left').removeClass('testDemo');
	     	$j('.searchResultOuterWrap .column.left').removeClass('testDemo');
	     	
	     }
      }

/** BOOLEAN SEARCH ENDS **/

function ieTest(){

	if(!!navigator.userAgent.match(/Trident.*rv\:11\./)){

      if($j(window).width()<=1024){  
      	  $j('.searchResultBar').css('padding-bottom','47.9px');     	
      }

    }
}