
	 
/*AMIT CODE FOR BUG 184 Starts*/
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
		
		//$j("#fieldWorkStudyError").show();
		
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
	
    if(endMarkets.val() != null && $j.trim(endMarkets.val())=="")
    {
      //  $j("#endMarketError").show();

    }
	else if(endMarkets.val() == null)
    {
       // $j("#endMarketError").show();

    }
	else
	{
	  
           
	  $j("#endMarketError").hide();

	}
	});
	
	
	$j("#globalOutcomeEUShare").change(function ()
	{
		
	if($j("#globalOutcomeEUShare  option:selected").val() != null && $j.trim($j("#globalOutcomeEUShare option:selected").val())!="-1")
	{
		$j("#globalOutcomeEUShareError").hide();
	
	}
	});
	
	
	$j("input[name=projectManagerName]").change(function()
	{
      var projectManagerName = $j("input[name=projectManagerName]");

    if(projectManagerName.val() != null && $j.trim(projectManagerName.val())=="")
    {
        //projectManagerName.parent().find("span").show();
      
       
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

		// $j("#methodologyDetails").parent().find("span").show();
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

//change 536
 $j("input[name=multiBrandStudyText]").change(function()
 {
	var MultibrandText = $j("input[name=multiBrandStudyText]"); 
	
	 if(MultibrandText.val()!="")
	 {
		 $j("#MultibrandTextError").hide();
		 
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
    //	$j("#budgetYearError").show();
    
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
		tem = $j("#fundingMarkets_chosen a").text();
		if(tem == "Select end-market"){
			$j('#fundingMarkets').val("").trigger('chosen:updated');
			//$j(".fundingMarketsError").show();	
		}
		else{
			 $j(".fundingMarketsError").hide();	
		}
	});
	
	
/*AMIT CODE FOR Bug 184 Ends*/	 
	 
	 