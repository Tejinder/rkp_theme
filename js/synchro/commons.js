function limitText(limitField, limitCount, limitNum) {	
   if ($j("#"+limitField).val().length > limitNum) {
        $j("#"+limitField).val($j("#"+limitField).val().substring(0, limitNum));
    } else {
        $j("#"+limitCount).val(limitNum - $j("#"+limitField).val().length);
    }
}

function isDateformat(date)
{
    var date_regex = /^(0[1-9]|1\d|2\d|3[01])\/(0[1-9]|1[0-2])\/(19|20)\d{2}$/ ;
    if(!(date_regex.test(date)))
    {
        return false;
    }
    else
        return true;
}

function compareDate(startDate, endDate)
{
    if(DateParser.parse(startDate) <= DateParser.parse(endDate))
        return true;
    else
        return false;
}

$j(document).ready(function() {

	
	
	

	$j("textarea").each(function(index) {
		var textvalue = $j(this).val();	
		if($j(this).is(":visible") && textvalue!="" && textvalue.indexOf('</p>')==-1)
		{
			var newTextVal = textvalue.replace(/\n/g, '<br />');		
			console.log("New value - " + newTextVal);
			$j(this).text(newTextVal);
		}	
		});
		
	$j(document).click(function(event) {
		var invertselection = true;
		var $target = $j(event.target);
		var targetid = event.target.id;
		
			
		if($target!=undefined && targetid!=undefined)
		{			
			if(targetid.indexOf("-reload") != -1)
			{
				invertselection = false;
			}					
		}		
		else if($target.hasClass('left_arrow') || $target.hasClass('right_arrow'))
		{
			invertselection = false;
		}		
		
		var targetselectid = targetid;
		if ($target.is("option")) {
			targetselectid = $target.parent().attr("id");
		}
			
		if ($target.is("button") || $target.is("input") || $target.is("a")) {
			invertselection = false;			
		}
		
		if(invertselection)
		{
			$j("select").each(function(i) {
			var selectid = $j(this).attr("id");		
			if(selectid!=undefined && selectid!=targetselectid)
			{
				if($j(this).is(":visible") && ($j(this).attr("multiple")==true || $j(this).attr("size") > 1 ))
				{					
					$j(this).children().each(function () {						
						$j(this).removeAttr("selected");
					});
				}
			}	
			});
		}
	});

$j(".numericfield, .numericfieldpib").focusin(function() {
	if(!$j(this).hasClass("nonformatfield"))
	{
		$j(this).val($j(this).val().replace(/\,/g, ''));
	}
});

$j(".numericfield, .numericfieldpib").focusout(function() {    
	//$j(".numericfield").trigger('change');
	if(!$j(this).hasClass("nonformatfield"))
	{
		$j(this).val($j(this).val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
	}
	
});

$j(".numericfield").change(function(event) {
	var LONG_NUMBER = 9223372036854776000;					  
	var SHORT_NUMBER = 2147483647;
    if($j(this).val() != "")
    {
		$j(this).parent().find("span").each(function(spanIndex) {
			if(!$j(this).hasClass('numeric-error') && !$j(this).hasClass('synchro-help-icon'))
			{
				$j(this).hide();
			}
		});
		
		$j(this).parent().find("p").each(function(spanIndex) {
			if(!$j(this).hasClass('numeric-error'))
			{
			if(!$j(this).hasClass('induction_text'))
			{
				$j(this).hide();
			}			
			}
		});
			
        if($j(this).hasClass("numericformat"))
        {
            var allowDecimals = true;
            if($j(this).hasClass("no-decimal")) {
                allowDecimals = false;
            }
			
            if (!numericFormat($j(this),allowDecimals)) {
                var val = $j(this).val().replace(/\,/g, '');
                if(allnumeric($j(this), val))
                {
					$j(this).parent().find("span").each(function(spanIndex) {
						if($j(this).hasClass('numeric-error'))
						{
							$j(this).text("Please enter number in 000,000 format");
							$j(this).show();
						}						
					});                   
                }
                else
                {
					$j(this).parent().find("span").each(function(spanIndex) {
					var $that = $j(this);
						if($j(this).hasClass('numeric-error'))
						{
                            if(allowDecimals) {
								if($that.hasClass('nonformatfield'))
								{
									$j(this).text("Please enter numeric value without any special character such as comma, space, etc.,");
								}
								else
								{
									$j(this).text("Please enter a numeric value");
								}
                            } else {
                                $j(this).text("Please enter a whole number");
                            }
							$j(this).show();
						}						
					});                    
                }                
            }
            else
            {			
				/**Checks for Short Range - Integers**/
				if($j(this).hasClass('shortField'))
				{
					var val = $j(this).val().replace(/\,/g, '');
					if(val>=SHORT_NUMBER)
					{
						$j(this).parent().find("span").each(function(spanIndex) {
						if($j(this).hasClass('numeric-error'))
						{
                            $j(this).text("Please enter lesser value");
							$j(this).show();
						}						
					});
						return;
					}				
				}
				/**Checks for Long Range - Long**/
				else if($j(this).hasClass('longField'))
				{					
					var val = $j(this).val().replace(/\,/g, '');					
					if(val>=LONG_NUMBER)
					{
						$j(this).parent().find("span").each(function(spanIndex) {
						if($j(this).hasClass('numeric-error'))
						{
                            $j(this).text("Please enter lesser value");
							$j(this).show();
						}						
					});
						return;
					}				
				}
				
                $j(this).val($j(this).val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
				$j(this).parent().find("span").each(function(spanIndex) {
					if($j(this).hasClass('numeric-error'))
					{				
						$j(this).hide();
					}
				});                
            }
        }
        else
        {
            var val = $j(this).val();
            if(allnumeric($j(this), val))
            {
                $j(this).parent().find("span").each(function(spanIndex) {
					if($j(this).hasClass('numeric-error'))
					{				
						$j(this).hide();
					}
				});
            }
            else
            {
				var $that = $j(this);
                $j(this).parent().find("span").each(function(spanIndex) {
					if($j(this).hasClass('numeric-error'))
					{	
						if($that.hasClass('nonformatfield'))
						{
							$j(this).text("Please enter numeric value without any special character such as comma, space, etc.,");
						}
						else
						{
							$j(this).text("Please enter a numeric value");
						}
						$j(this).show();
					}
				}); 
            }
        }
    }
	else
	{				
		$j(this).parent().find("span").each(function(spanIndex) {
			if($j(this).hasClass('numeric-error'))
			{
				$j(this).hide();
			}
		});
	}
});

$j(".numericfieldpib").change(function(event) {
	var LONG_NUMBER = 9223372036854776000;					  
	var SHORT_NUMBER = 2147483647;
    if($j(this).val() != "")
    {
		$j(this).parent().find("span").each(function(spanIndex) {
			if(!$j(this).hasClass('numeric-error') && !$j(this).hasClass('synchro-help-icon'))
			{
				$j(this).hide();
			}
		});
		
		$j(this).parent().find("p").each(function(spanIndex) {
			if(!$j(this).hasClass('numeric-error'))
			{
				$j(this).hide();
			}
		});
			
        if($j(this).hasClass("numericformat"))
        {
            var allowDecimals = true;
            if($j(this).hasClass("no-decimal")) {
                allowDecimals = false;
            }
			
            if (!numericFormat($j(this),allowDecimals)) {
                var val = $j(this).val().replace(/\,/g, '');
                if(allnumeric($j(this), val))
                {
					$j(this).parent().find("span").each(function(spanIndex) {
						if($j(this).hasClass('numeric-error'))
						{
							$j(this).text("Please enter number in 000,000 format");
							$j(this).show();
						}						
					});                   
                }
                else
                {
					var $that = $j(this);
					$j(this).parent().find("span").each(function(spanIndex) {
						if($j(this).hasClass('numeric-error'))
						{							
                            if(allowDecimals) {
                               if($that.hasClass('nonformatfield'))
								{
									$j(this).text("Please enter numeric value without any special character such as comma, space, etc.,");
								}
								else
								{
									$j(this).text("Please enter a numeric value");
								}
                            } else {
                                $j(this).text("Please enter a whole number");
                            }
							$j(this).show();
						}						
					});                    
                }                
            }
            else
            {		
				/**Checks for Short Range - Integers**/
				if($j(this).hasClass('shortField'))
				{
					var val = $j(this).val().replace(/\,/g, '');
					if(val>=SHORT_NUMBER)
					{
						$j(this).parent().find("span").each(function(spanIndex) {
						if($j(this).hasClass('numeric-error'))
						{
                            $j(this).text("Please enter lesser value");
							$j(this).show();
						}						
					});
						return;
					}				
				}
				/**Checks for Long Range - Long**/
				else if($j(this).hasClass('longField'))
				{					
					var val = $j(this).val().replace(/\,/g, '');					
					if(val>=LONG_NUMBER)
					{
						$j(this).parent().find("span").each(function(spanIndex) {
						if($j(this).hasClass('numeric-error'))
						{
                            $j(this).text("Please enter lesser value");
							$j(this).show();
						}						
					});
						return;
					}				
				}
                $j(this).val($j(this).val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
				$j(this).parent().find("span").each(function(spanIndex) {
					if($j(this).hasClass('numeric-error'))
					{				
						$j(this).hide();
					}
				});                
            }
        }
        else
        {
            var val = $j(this).val();
            if(allnumeric($j(this), val))
            {
                $j(this).parent().find("span").each(function(spanIndex) {
					if($j(this).hasClass('numeric-error'))
					{				
						$j(this).hide();
					}
				});
            }
            else
            {
				var $that = $j(this);
                $j(this).parent().find("span").each(function(spanIndex) {
					if($j(this).hasClass('numeric-error'))
					{
						if($that.hasClass('nonformatfield'))
						{
							$j(this).text("Please enter numeric value without any special character such as comma, space, etc.,");
						}
						else
						{
							$j(this).text("Please enter a numeric value");
						}
						$j(this).show();
					}
				}); 
            }
        }
    }
	else
	{				
		$j(this).parent().find("span").each(function(spanIndex) {
			if($j(this).hasClass('numeric-error'))
			{
				$j(this).hide();
			}
		});
	}
});

$j("#methodologyGroup").change(function() {
	$j.processMultiMarketProposedField();
});

$j("#methodologyType").change(function() {
	processDataCollection();
});

/**Auto process Meta Fields on Page Load**/

//	processCategoryField();	
//	$j.processMultiMarketProposedField();

	
/**Attachments Label click Handlers**/
/*
$j("#field-attachment .views-field label").click('click', function (event) {
	*/
$j('body').on('click', '#field-attachment .views-field label', function(event){	

	$j(this).prev().click();
});

/*Adjust textarea height*/
//TODO
$j("textarea").each(function(i) {
	var textHeight = $j(this)[0].scrollHeight;
	var textboxHeight = $j(this).height();	
	  if (this.clientHeight < this.scrollHeight) {
		$j(this).height( $j(this)[0].scrollHeight-10);
	  }
	  else
	  {
		var DEFAULT_VALUES = ["Enter text and/or attach documents"];
		if($j(this).val()!=null && $j.trim($j(this).val())!="" && !contains(DEFAULT_VALUES, $j.trim($j(this).val())))
		{
			$j(this).height(0);
			var scrollval = $j(this)[0].scrollHeight-10;
			$j(this).height(scrollval);
		}		
	  }	
	  $j(this).elastic();
});

$j(function(){
	$j('#mailAttachment').MultiFile({
		onFileSelect: function(element, value, master_element){
		console.log("Email Attachment selected");
		/*validateAttachment(element, value, master_element);*/
	}});
});

function validateAttachment(element, value, master_element)
{
	
	/*var formdata;
    formdata = new FormData();
	var fileInput = document.getElementById('mailAttachment');
	var file = fileInput.files[0];
    formdata.append( 'mailAttachment', file);
	console.log("Data == " + formdata);
	$j.ajax({
		type: "POST",
		url: "synchro/validate-email-attachment!validateEmailAttachment.jspa",
		processData: false,
		contentType: 'multipart/form-data',
		enctype: 'multipart/form-data',
		data: formdata,
		success: function () {
			alert("Data Uploaded: ");
		}
	});
	*/
	
	/* $j.ajaxFileUpload({
		url:'synchro/validate-email-attachment!validateEmailAttachment.jspa', 
		secureuri:false,
		fileElementId:'mailAttachment',
		dataType: 'json'
	})*/
}
});

function processProposedMethodology()
{
	var id = $j("#methodologyGroup").val();	
	var methodologies = {};	
	if(id != undefined && id > 0)
	{
		FieldMappingUtil.getMethodlogyMapping(id, false,{
					callback: function(result) {					
					processProposedMethodologyField(result);
					},
					async: false,  
					timeout: 20000 
				});
	}
	else
	{
		FieldMappingUtil.getMethodlogyMapping(id, true,{
					callback: function(result) {					
					processProposedMethodologyField(result);
					},
					async: false,  
					timeout: 20000 
				});
	}
	try{
	
	FieldMappingUtil.getDefaultProposedMethodologyID(true,{
					callback: function(id) {
					$j('#proposedMethodology').val(id);
					},
					async: false,  
					timeout: 20000 
				});
	}catch(err){}
	
}

function processDataCollection()
{
	var id = $j("#methodologyType").val();	
	if(id != undefined && id > 0)
	{
		FieldMappingUtil.getDataCollections(false, id,{
					callback: function(result) {					
					processDataCollectionField(result);
					},
					async: false,  
					timeout: 20000 
				});
	}
	else
	{
		FieldMappingUtil.getDataCollections(true, id,{
					callback: function(result) {					
					processDataCollectionField(result);
					},
					async: false,  
					timeout: 20000 
				});
	}
	
}

function processProposedMethodologyField(result)
{	
	FieldMappingUtil.getMethodlogyNames(true,{
					callback: function(names) {					
					rebuildProposedMethodologyField(names, result);
					},
					async: false,  
					timeout: 20000 
				});
}

function processDataCollectionField(result)
{	
	FieldMappingUtil.getCollectionNames(true,{
					callback: function(names) {					
					rebuildDataCollectionField(names, result);
					},
					async: false,  
					timeout: 20000 
				});
}

function rebuildProposedMethodologyField(names, result)
{		
	$j('#proposedMethodology')[0].options.length = 0;
		$j('#proposedMethodology')         
			 .append($j("<option></option>")
			 .attr("value",-1)
			 .text("None of These"));
		$j.each(result, function( key, value ) {
			$j('#proposedMethodology')         
			 .append($j("<option></option>")
			 .attr("value",value)
			 .text(names[value]));
		});	
}

function rebuildDataCollectionField(names, result)
{	
	$j("select[id^=availableDataCollection_]").each(function(index) {
		var id = $j(this).attr("id").substring(("availableDataCollection_").length);
		var collections = []; 
		$j("#dataCollectionMethod_"+id+" > option").each(function(index) {
			collections[index] = $j(this).val();
			
			/*Check if render field values are valid for already selected*/
			if(!contains(result,$j(this).val()))
			{			
				$j(this).remove();
			}
		});
		
		$j("#availableDataCollection_"+id)[0].options.length = 0;		
		$j.each(result, function( key, value ) {			
			if(!contains(collections,value))
			{			
				$j("#availableDataCollection_"+id).append($j("<option></option>").attr("value",value).text(names[value]));
			}
		});
	});
}



function numericFormat(uzip, decimals) {

    if(decimals == undefined || decimals == null) {
        decimals = true;
    }
    var numbers;
    if(decimals) {
        numbers = /^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{1,9})?$/;
    } else {
        numbers = /^\$?(\d{1,3}(\,\d{3})*|(\d+))$/;
    }
    
    if (uzip.val().match(numbers)) {
        return true;
    } else {
        uzip.focus();
        return false;
    }
    return true;
}

function allnumeric(uzip, val) {
    var numbers = /^[0-9]+$/;
    if (val.match(numbers)) {
        return true;
    } else {
        uzip.focus();
        return false;
    }
}

function processCategoryField()
{
	var options = []; 
	$j("#categoryType > option").each(function(index) {		
		options[index] = $j(this).val();
	});
	
	var brands = [];	
	if(options.length > 0)
	{
		FieldMappingUtil.getCategoryBrandMapping(options, {
					callback: function(result) {					
					rebuildBrandsField(result);
					},
					async: false,  
					timeout: 20000 
				});
	}
	else
	{
		rebuildAllBrandsField();
	}
	try{
	 
	 /*TODO default value of brand from system property	 */
	FieldMappingUtil.getDefaultBrandID(true,{
					callback: function(id) {
				/*	$j('#brand').val(id);*/
					},
					async: false,  
					timeout: 20000 
				});
	 }catch(err){}
}

function rebuildBrandsField(result)
{	
	var brandID = $j('#brand').val();
	$j('#brand')[0].options.length = 0;
	$j('#brand')         
         .append($j("<option></option>")
         .attr("value",-1)
         .text("-- None --"));
	$j.each( result, function( key, value ) {		  
	    $j('#brand')         
         .append($j("<option></option>")
         .attr("value",value)
         .text(brandFieldMap[value]));
	});
	$j('#brand').val(brandID);
	
}

function rebuildAllBrandsField()
{	
	var brandID = $j('#brand').val();	
	$j('#brand')[0].options.length = 0;
	$j('#brand')         
         .append($j("<option></option>")
         .attr("value",-1)
         .text("-- None --"));
	$j.each(brandFieldMap, function( key, value ) {		
	    $j('#brand')         
         .append($j("<option></option>")
         .attr("value",key)
         .text(brandFieldMap[key]));
	});
	
	$j('#brand').val(brandID);
	
}

function contains(a, obj) {
    if(a!=null && a.length > 0)
	{
		for(var i=0; i<a.length; i++)
		{
			if(a[i]==obj)
				return true;
		}
	}
	return false;
}

/*Multi market Code */

/** Proposed Methodology Multi Select Box Code **/
$j.processMultiMarketProposedField = function()
{
	var id = $j("#methodologyGroup").val();	
	
	if(id != undefined && id > 0)
	{
		FieldMappingUtil.getProposedMethodology(false, id,{
					callback: function(result) {					
					$j.renderMultiMarketProposedField(result);
					},
					async: false,  
					timeout: 20000 
				});
	}
	else
	{
		FieldMappingUtil.getProposedMethodology(true, id,{
					callback: function(result) {					
					$j.renderMultiMarketProposedField(result);
					},
					async: false,  
					timeout: 20000 
				});
	}
}

$j.renderMultiMarketProposedField = function(result)
{
	FieldMappingUtil.getMethodlogyNames(true,{
					callback: function(names) {
					if($j("#allProposedMethodologyFields")[0]!=undefined)
						$j.rebuildMultiMarketProposedField(names, result);
					},
					async: false,
					timeout: 20000
				});
}

$j.rebuildMultiMarketProposedField = function(names, result)
{
		var methodologiesArray = [];		
		$j("#proposedMethodology > option").each(function(index) {			
			methodologiesArray[index] = $j(this).val();			
			/*Check if render field values are valid for already selected*/

		});
		
		$j("#allProposedMethodologyFields")[0].options.length = 0;		
		$j.each(result, function( key, value ) {		
			if(!contains(methodologiesArray, value))
			{				
				$j("#allProposedMethodologyFields").append($j("<option></option>").attr("value",value).text(names[value]));
			}
		});	
}

$j.formatNumber = function(number) {
    
    return number.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g,"$1,");
}
/** Proposed Methodology Multi Select Box Code **/


$j.limitTextFn = function(limitField, limitCount, limitNum) { 	
   if ($j("#"+limitField).val().length > limitNum) {
        $j("#"+limitField).val($j("#"+limitField).val().substring(0, limitNum));
    } else {
        $j("#"+limitCount).val(limitNum - $j("#"+limitField).val().length);
    }
}


