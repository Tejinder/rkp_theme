/*   this is for remove button */
	
    $j("body").on("click", ".remove", function () {
        $j(this).closest("div").remove();
		dynamicTotalCost();
		showKantarMessage();
    });
	
	
	$j("body").on("change", "#agency, #costComponent, #currency ", function () {
		
		//var statusVisible= $j("#nonKantarWaiverStatus").is(':visible');
		//if(statusVisible==true)
		
		var agencyDisabled = $j("#agency").is(':disabled');
		if(agencyDisabled==true)
		{  
	    }
		else
		{
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
					currencyChangeMessage=true;
					dialog({
							title: 'Message',
							html: currencyChangeMessageText,
							
						});
				}
				cuurentRow= $j(this).parent().parent();
			}
			else
			{
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
			/* if(isNonKantar=="yes")
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
		}
		
		currVal = $j(this).val();
	 if(currVal >=1){
		$j(this).parent().find(".jive-error-message").hide();
	 }
		
		
		dynamicTotalCost();
		AddCostDetailTitle();
	});
  
	$j("body").on("change", "#enter_cost", function () {
        
		//var statusVisible= $j("#nonKantarWaiverStatus").is(':visible');
		//if(statusVisible==true)
		var agencyDisabled = $j("#agency").is(':disabled');
		if(agencyDisabled==true)
		{  
	    }
		else
		{
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
		}
			
			// Validate Numeric
			var LONG_NUMBER = 9223372036854776000;
			var SHORT_NUMBER = 2147483647;
			if($j(this).val() != "")
			{
				if (!numericFormat($j(this))) 
				{
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
							$j(this).next().text("Please enter lesser value44");
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
					//$j(this).val($j(this).val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
					if($j(this).val().indexOf(".") < 0)
					{
						$j(this).val($j(this).val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
						
					}
					$j(this).next().hide();
				}
			}
			
			//change
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
	     researchAgencyOption = "<div class='region-inner'><div  id='agencyMain1'><select title='Select Research Agency' data-placeholder='Research Agency'  class='chosen-select  appended-agency researchAgency'         id='agency' name='agencies'>"+$j('#agency').clone(true).html()+"</select><span class='jive-error-message researchAgencydynamicError'  style='display:none'>Please select Research Agency</span></div></div>";
		  
		 		  
		
		
		
		
		var costComponentOption = "";
		costComponentOption = "<div class='region-inner'><select  id='costComponent'  title='Select Cost Component' data-placeholder='Cost Component' name='costComponents' class='chosen-select  appended-costComponent costComponent'>"+$j('#costComponent').clone(true).html()+"</select><span class='jive-error-message costComponentdynamicError'  style='display:none'>Please select Cost Component</span> </div>";     
		
		
	
		
		
		
		
		var costCurrencyOption = "";
		costCurrencyOption = "<div class='region-inner'><select  id='currency'   title='Select Currency' data-placeholder='Currency' class='chosen-select currency' id='currencies' name='currencies'>"+$j('#currency').clone(true).html()+"</select> <span class='jive-error-message costCurrencytdynamicError'  style='display:none'>Please select Cost Currency</span></div>";
		
		
		
		
     	 var content= '<input type="button" value="duplicate" class="duplicate" id="firstDuplicate" style="display:none"/>&nbsp;'+
		              '<input type="button" value="Remove" class="remove" id="firstRemove" style="display:none"/>&nbsp;'+
           		    researchAgencyOption +
				 costComponentOption +
				   costCurrencyOption +
				'<div class="region-inner"><input   name ="agencyCosts" type="text"   id="enter_cost" placeholder="Enter Cost"   onchange="javascript:dynamicTotalCost();"  class="text_field  longField total-expense" value="'+ value+ '" onfocus="this.placeholder = \'\'" onblur="this.placeholder = \'Enter Cost\'"/><span class="jive-error-message agencyCostsError" style="display: none;">Please enter Agency Cost</span></div>'
			
             return content;       
	}
	
	$j(document).ready(function() {	
		$j(".total-expense").change(function() {
		dynamicTotalCost();
		});
			
	
	});
	function dynamicTotalCost(CurrencyType)
	{	
	
		var CurrencyType=0;
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
		 //var a =   (total.toFixed(2)).toString();
		 var a =   (total.toFixed(0)).toString();
        $j('.total-cost .text_field').val(a.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
		
		
			
			
			
			$j("#prefCost").val(prefCurrTotal.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
		
			
		//$j("#totalCostHidden").val(total.toFixed(2));
		$j("#totalCostHidden").val(total);
		
			
	}
	
	function adjustExpenseRow()
		{
			$j(".expense_row #firstDuplicate").each(function(){
			if($j(this).is(':hidden'))
			{	
				$j(this).parent().css("margin-left","45px")
			}
			else
			{
				$j(this).parent().css("margin-left","0")
			}
			})
		}	
		//adjustExpenseRow();
		
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
		
	function validateProjectCostDetails()
	{
		/*NEW VALIDATION*/
			var error = false;
			var count=1;
			$j('.expense_row ').each(function(){
			var agencyDynamic  = $j(this).find('select[name="agencies"] option:selected').val();
			var costComponentDynamic  = $j(this).find('select[name="costComponents"] option:selected').val();
			var currencyDynamic  = $j(this).find('select[name="currencies"] option:selected').val();
			var agencyCostDynamic  = $j(this).find('input[name="agencyCosts"]');
			
			
			if((agencyDynamic==undefined || (agencyDynamic  < 1 || $j.trim(agencyDynamic)=="" || agencyDynamic==null)) && (costComponentDynamic==undefined || (costComponentDynamic  < 1 || $j.trim(costComponentDynamic)=="" || costComponentDynamic==null)) && (currencyDynamic==undefined || (currencyDynamic  < 1 || $j.trim(currencyDynamic)=="" || currencyDynamic==null)) && agencyCostDynamic.val() != null && agencyCostDynamic.val() != undefined &&  $j.trim(agencyCostDynamic.val())=="" )
			{		
				//$j(this).find('.researchAgencydynamicError').show();
				//error = true;
				if(count==1)
				{
					$j(this).find('.researchAgencydynamicError').show();
					$j(this).find('.costComponentdynamicError').show();
					$j(this).find('.costCurrencytdynamicError').show();
					$j(this).find('.agencyCostsError').show();
					error = true;
				}
			}
			else
			{
				if(agencyDynamic==undefined || agencyDynamic  < 1 || $j.trim(agencyDynamic)=="" || agencyDynamic==null)
				{
					$j(this).find('.researchAgencydynamicError').show();
					error = true;
				}
				else
				{
					$j(this).find('.researchAgencydynamicError').hide();
				}
				if(costComponentDynamic==undefined || costComponentDynamic  < 1 || $j.trim(costComponentDynamic)=="" || costComponentDynamic==null)
				{
					$j(this).find('.costComponentdynamicError').show();
					error = true;
				}
				else
				{
					$j(this).find('.costComponentdynamicError').hide();
				}
				if(currencyDynamic==undefined || currencyDynamic  < 1 || $j.trim(currencyDynamic)=="" || currencyDynamic==null)
				{
					$j(this).find('.costCurrencytdynamicError').show();
					error = true;
				}
				else
				{
					$j(this).find('.costCurrencytdynamicError').hide();
				}
				if(agencyCostDynamic.val() != null && agencyCostDynamic.val() != undefined &&  $j.trim(agencyCostDynamic.val())=="")
				{
					
					$j(this).find('.agencyCostsError').show();
					error = true;
				}
				else
		{
			console.log(agencyCostDynamic.val());
			
			
		var LONG_NUMBER = 9223372036854776000;
		var SHORT_NUMBER = 2147483647;
		if(agencyCostDynamic.val() != "")
		{
			if (!numericFormat(agencyCostDynamic)) {
				var val = agencyCostDynamic.val().replace(/\,/g, '');
				if(allnumeric(agencyCostDynamic, val))
				{
					agencyCostDynamic.next().text("Please enter number in 000,000 format");
				}
				else
				{
					agencyCostDynamic.next().text("Please enter numeric value");
				}

				agencyCostDynamic.next().show();
				error = true;
			
			}
			else
			{
				/**Checks for Short Range - Integers**/
				if(agencyCostDynamic.hasClass('shortField'))
				{
					var val = agencyCostDynamic.val().replace(/\,/g, '');
					if(val>=SHORT_NUMBER)
					{
						agencyCostDynamic.next().text("Please enter lesser value");
						agencyCostDynamic.next().show();
						error = true;
						return;
					}
				}
				/**Checks for Long Range - Long**/
				else if(agencyCostDynamic.hasClass('longField'))
				{
					var val = agencyCostDynamic.val().replace(/\,/g, '');
					if(val>=LONG_NUMBER)
					{
						agencyCostDynamic.next().text("Please enter lesser value");
						agencyCostDynamic.next().show();
						error = true;
						return;
					}
				}
				if(agencyCostDynamic.val().indexOf(".") < 0)
				{
					agencyCostDynamic.val(agencyCostDynamic.val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
					
				}
				agencyCostDynamic.next().hide();
				
			}
		}
			
			
			agencyCostDynamic.find('.agencyCostsError').hide();
		}
			}
			count++;
			});
			
			
			
			
		  
			if(error)
			{
				return false;
			}
			return true;
	}
	
	function AddCostDetailTitle(){
			$j('.expense_row .region-inner .chosen-select').each(function(){
				var TitleValue = $j('option:selected',this).text();
				if(TitleValue)$j(this).parent().find('.chosen-container').attr("title",TitleValue);
			});
		}
		
	function AddPITFieldTitle()
	{
		var brandvalue=$j("#brand option:selected").text();
		$j("#brand_chosen").attr("title",brandvalue);
		var brandvalue=$j("#brand option:selected").text();
		if(brandvalue.length>20)
		{
			$j("#brand_chosen").attr("title",brandvalue);
		}
		else
		{
		   $j("#brand_chosen").attr("title","");
		}
		var brandSpecificStudyTypeValue=$j("#brandSpecificStudyType option:selected").text();
			
		if(brandSpecificStudyTypeValue.length>20)
		{
			$j("#brandSpecificStudyType_chosen").attr("title",brandSpecificStudyTypeValue);
		}
		else
		{
		   $j("#brandSpecificStudyType_chosen").attr("title","");
		}
	}
	// for synchroCode ,accept only numerics
function isNumber() 
{
	
	var error=true;
    var numbers = /^[0-9]+$/; 
	var counter=1;
	
	$j('.synchroCode_row').each(function(){
		var data=$j(this).parent().find("#referenceSynchroCodes").val();
	   counter++;
		if(data.match(numbers))
		{
			$j(this).parent().find('.synchroCodeError').hide();  
		}
		else
		{
			if(data=="")
			{
			$j(this).parent().find('.synchroCodeError').hide(); 
			error=true;
			}else
			{
			 $j(this).parent().find('.synchroCodeError').show();
			 error= false;
			}
		}
	});
	if(error)
	{
		return true;
	}
	else
	{
		return false;
	}
}