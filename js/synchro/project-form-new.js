/***
 ** PIT validations New
 ** version 1.0
 ** @author Tejinder Singh
 **/
 
 
/***
 ** PIT validations
 ** version 4.0
 ** @author Kanwar Grewal
 **/
var investmentPopup = null;
function limitText(limitField, limitCount, limitNum) {

    if(limitField.value) {
        if (limitField.value.length > limitNum) {
            limitField.value = limitField.value.substring(0, limitNum);
        } else {
            limitCount.value = limitNum - limitField.value.length;
        }
    }

}

function submitForm() {
    /*$j("input[id^=sl-spiContact-]").each(function(i) {
        var value = $j(this).val();
        var fieldID = $j(this).attr("id");
        var id =  fieldID.split('-')[2];
        $j("input[id^=spiContact-]").each(function(i) {
            var name = $j(this).attr("name");
            if(name.indexOf("["+id+"]")>0)
            {
                var _id = "sl-spiContact-"+id;
                var _val = $j( "input[name='"+_id+"']" ).val();
                $j(this).val(_val);
            }
        });
    });
*/
	var form = $j("#form-create");
  
	// This has been done to preserve the proposedMetodolgy value on Project Creation
	//$j('#proposedMethodology option').prop('selected', true);
	//$j('#categoryType option').prop('selected', true);
	
	
    jive.util.securedForm(form).always(function() {
        form.submit();
    });
}

function submitFormDialog()
{
    if(validateForm())
    {
        submitForm();
    }
    else
    {
        $j("#jive-error-box").show();
    }
}

$j(document).ready(function() {


    $j("#j-header a").click(function(event) {
        var pageType = $j("#pageType").val();
       
        var draftLocation = $j("#draftLocation").val();
        var multiMarketProject = $j("#multiMarketProject").val();
       if(draftLocation!=undefined && multiMarketProject!=undefined)
        {
            var href = $j(this).attr("href");
       
            event.preventDefault();
            dialog({
                title: 'Message',
                html: '<p>Do you want to save the details</p>',
                buttons:{
                    "Yes":function() {
	                    
				        if(validateSaveMultiMarketForm())
				         {       
				       		$j('#regions option').attr('selected', 'selected');
							$j('#areas option').attr('selected', 'selected');
							$j("#draftLocation").val(href);
							appendInvestmentFieldstoForm();
							submitForm();
				         }
                        
                    },
                    "No": function() {
                        window.location.href = href;
                    }
                }
            });
        }
        else if(draftLocation!=undefined)
        {
            var href = $j(this).attr("href");
             event.preventDefault();
            dialog({
                title: '',
                html: '<i class="warningErr"></i><p>Moving out of this space will result in all your information being<br/> lost!</p><p> Do you wish to navigate out of this stage?</p>',
                buttons:{
                    
                    "Yes":function() {
                       /* if(validateSaveForm())
				        {
				            $j("#draftLocation").val(href);
				            submitForm();
				        }*/
                        window.location.href = href;
                    },
					"No": function() {
                        /*window.location.href = href;*/
                    }
                }
            });
        }
        
        else if(pageType!='pib')
        {
            var href = $j(this).attr("href");
            event.preventDefault();
            dialog({
                title: '',
                html: '<p>Do you want to save the details</p>',
                buttons:{
                    "Yes":function() {
                        return;
                    },
                    "No": function() {
                        window.location.href = href;
                    }
                }
            });
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

    /* Add previously added Category to Selected Category Box */
    $j("#addCategoryfieldsBtn").click();

    /*$j("#project_publish_link").click(function() {
        showLoader('Please wait...');
        if(validateForm())
        {
            $j("#draft").val('publish');
            submitForm();
        }
        else
        {
            hideLoader();
            $j("#jive-error-box").show();
        }
    });
    */
    $j("#project_save_draft_link").click(function() {
       
         if(validateSaveForm())
         {       
       		 showLoader('Please wait...');   
			 $j("#draft").val('draft');
			 submitForm();
         }
        else
        {
            hideLoader();
            $j("#jive-error-box").show();
        }
           
    });
	
	$j("#project_save_draft_link_research").click(function() {
       
         if(validateSaveForm())
         {       
       		 showLoader('Please wait...');   
			 $j("#draft").val('draft');
			 submitForm();
         }
        else
        {
            hideLoader();
            $j("#jive-error-box").show();
        }
           
    });
	$j("#project_save_draft_link_cost").click(function() {
       
         if(validateSaveForm())
         {       
       		 showLoader('Please wait...');   
			 $j("#draft").val('draft');
			 submitForm();
         }
        else
        {
            hideLoader();
            $j("#jive-error-box").show();
        }
           
    });


    $j("#mproject_publish_link").click(function() {
		//appendInvestmentFieldstoForm();
        showLoader('Please wait...');
        if(validateMultiMarketForm())
        {
             $j("#draft").val('publish');
             $j("#draftLocation").val("");
             //$j('#regions option').attr('selected', 'selected');
             // $j('#areas option').attr('selected', 'selected');
             $j('#markets option').attr('selected', 'selected');
            appendInvestmentFieldstoForm();
            submitForm();
        }
        else
        {
            hideLoader();
            $j("#jive-error-box").show();
        }
		
    });
    
     $j("#mproject_save_draft_link").click(function() {
		
       if(validateSaveMultiMarketForm())
         {       
       		showLoader('Please wait...');   
			$j("#draft").val('draft');
			//$j('#regions option').attr('selected', 'selected');
			//$j('#areas option').attr('selected', 'selected');
			$j('#markets option').attr('selected', 'selected');
			appendInvestmentFieldstoForm();
			submitForm();
         }
        else
        {
            hideLoader();
            $j("#jive-error-box").show();
        }
		
    });

    $j(".numericfield").focusin(function() {
        $j(this).val($j(this).val().replace(/\,/g, ''));
    });

    $j(".numericfield").focusout(function() {
        $j(".numericfield").trigger('change');
        $j(this).val($j(this).val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
    });

    $j(".numericfield").change(function(event) {
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
                $j(this).val($j(this).val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                $j(this).next().hide();
            }
        }
    });

    $j(".numericfield-pit").focusin(function() {
        $j(this).val($j(this).val().replace(/\,/g, ''));
    });

    $j(".numericfield-pit").focusout(function() {
        $j(".numericfield-pit").trigger('change');
    });

    $j(".numericfield-pit").change(function(event) {
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
                $j(this).val($j(this).val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                $j(this).next().hide();
            }
        }
    });

    $j(".investment-popup-field .numericfield").change(function(event) {
        if($j(this).val() != "")
        {
            if (!numericFormat($j(this))) {
                var val = $j(this).val().replace(/\,/g, '');
                if(allnumeric($j(this), val))
                {
                    $j("#numeric-error-initialCost").text("Please enter number in 000,000 format");
                }
                else
                {
                    $j("#numeric-error-initialCost").text("Please enter numeric value");
                }

                $j("#numeric-error-initialCost").show();
            }
            else
            {
                $j(this).val($j(this).val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                $j("#numeric-error-initialCost").hide();
            }
        }
    });

    $j("#methodologyGroup").change(function() {
        $j.processMultiMarketProposedField();
    });

	$j("select[name=fieldwork]").change(function() {		
		$j("select[name=funding]").val($j(this).val());
    });

	
    $j("#startDate").click(function() {
        $j("#startDate_button").click();
    });
    $j("#endDate").click(function() {
        $j("#endDate_button").click();
    });

    /*Multimarket Code*/
    $j(".investmentType").click(function() {
        var id = $j(this).attr("id");
        var value = $j(this).attr("value");

        if(value==1)
        {
            $j("#spi-contact-container").hide();
            resetInvestmentDropdowns();
        }
        else if(value==2)
        {
            $j("#spi-contact-container").hide();
            resetInvestmentDropdowns();
            $j("#region").removeAttr("disabled");
        }
        else if(value==3)
        {
            $j("#spi-contact-container").hide();
            resetInvestmentDropdowns();
            $j("#area").removeAttr("disabled");
        }
        else if(value==4)
        {
            $j("#spi-contact-container").show();
            resetInvestmentDropdowns();
            $j("#fieldwork").removeAttr("disabled");
            $j("#funding").removeAttr("disabled");
        }

    });

    $j(".investment-popup-field span").click(function() {
        $j(this).prev().click();
    });


   /* $j('.delete-investment').click("click",function(){		*/
	$j('body').on('click', '.delete-investment', function(){		
			
        var $tr = $j(this).parent().parent();
        var id = $tr.attr("id");

        if(id !=undefined && id!=null)
        {
            $tr.remove();
        }

        if($j(".global-row").length==0)
        {
            $j(".global-row-header").remove();
        }

        if($j(".country-row").length==0)
        {
            $j(".country-row-header").remove();
        }

        /** *Check for empty table*/
        var gHeaderClass= 'global-row-header';
        var cHeaderClass= 'country-row-header';
        var gClass= 'global-row';
        var cClass= 'country-row';
        var isEmpty = true;
        var pageType = $j("#pageType").val();
        var investmentDetailsRow = (pageType == 'pib')?$j("#pitWindow #investment-details tbody tr"):$j("#investment-details tbody tr");

        $j(investmentDetailsRow).each(function(index) {
            if($j(this).hasClass(gHeaderClass) || $j(this).hasClass(cHeaderClass) || $j(this).hasClass(gClass) || $j(this).hasClass(cClass))
            {
                isEmpty = false;
            }
        });
        if(isEmpty)
        {
            var investmentDetails = (pageType == 'pib')?$j("#pitWindow #investment-detailsr"):$j("#investment-details");
            $j(investmentDetails).find('tbody').append($j("<tr>")
                .append($j("<td class='no-items' colspan='10'>")
                .append("Investments not available")));
        }

        $j.paintGrid();
    })

    /*$j('.edit-investment').live("click",function(){		*/
	
	$j('body').on('click', '.edit-investment', function(){		
			
       
        var $tr = $j(this).parent().parent();
        var $spi;

        var $curr;
        var rowid = $tr.attr("id");
        var type = -1;
        var region = -1;
        var area = -1;
        var fwmarket = -1;
        var fndmarket = -1;
        var contactID = $tr.find('#contact-id').val();
        var contactName = $tr.find('#contact-name').val();
        var spiID = $tr.find('#spi-id').val();
        var spiName = $tr.find('#spi-name').val();
        var $cost = $tr.find('.cost-col').text();
        var currency = $tr.find('#currency').val();
        var investmentID = $tr.find('#investmentID').val();

		
        if(rowid !=undefined && rowid!=null)
        {
            var prefix = "ivt_row_"
            var id = rowid.replace(prefix,"");
            if(id.indexOf('_')!=-1)
            {
                var $array = id.split('_');
                if($array.length==2)
                {
                    type = $array[0];
                    if(type==2)
                    {
                        region = $array[1];

                    }
                    else if(type==3)
                    {
                        area = $array[1];
                    }
                }
                else if($array.length==4)
                {
                    type = $array[0];
                    fwmarket = $array[1];
                    fndmarket = $array[3];
                }
            }
            else
            {
                //Global region
                type = 1;
            }

            //Initialize investment pop up values
            openAddInvestmentDetails();
            $j("#add-investment-popup #editMode").val("true");
            $j("#add-investment-popup #editRowID").val(rowid);
            
			$j('#add-investment-popup input[name="investmentType"][value="' + type + '"]').prop('checked', 'checked');
			
            $j("#add-investment-popup #region").val(region);
            $j('#add-investment-popup #area').val(area);
            $j('#add-investment-popup #fieldwork').val(fwmarket);
            $j('#add-investment-popup #funding').val(fndmarket);
            $j('#add-investment-popup input[name=initialCost]').val($cost);
            $j('#add-investment-popup #initialCostCurrency').val(currency);
            $j('#add-investment-popup #investmentID').val(investmentID);

            resetContactField(contactID, contactName);
            if(type!=null && type==4)
            {
                $j("#spi-contact-container").show();
                resetSPIField(spiID, spiName);
            }
            else
            {
                $j("#spi-contact-container").hide();
            }

            if(type!=null)
            {
                if(type==2)
                    $j("#region").removeAttr("disabled");
                if(type==3)
                    $j("#area").removeAttr("disabled");
                if(type==4)
                {
                    $j("#fieldwork").removeAttr("disabled");
                    $j("#funding").removeAttr("disabled");
                }
            }

        }
    });
    /** Initialize the Add funding and Investment popup **/
    investmentPopup = new LIGHT_BOX($j("#add-investment-popup"),{title:'Add Investment'});

    $j("#add-investment-popup").bind("onUserpickerLoad",function(){
        $j("#add-investment-popup").parent().hide();
    });
    $j("#add-investment-popup").bind("onUserpickerClose",function(){
        $j("#add-investment-popup").parent().show();
    });

    $j("#add-investment-popup").bind("inviteUserPopupLoad",function(){
        $j("#add-investment-popup").parent().hide();
    });
    $j("#add-investment-popup").bind("inviteUserPopupClose",function(){
        $j("#add-investment-popup").parent().show();
    });

    /**Auto process Meta Fields on Page Load**/
	
	var pageType = $j("#pageType").val();
    if(pageType!='pib')
    {
		processCategoryField();
		$j.processMultiMarketProposedField();
	}
    

});

$j.fn.pVal = function(){
    var $this = $j(this),
        val = $this.eq(0).val();
    if(val == $this.attr('placeholder'))
        return '';
    else
        return val;
}

function validateForm()
{
    var error = false;
    /** Code to be placed before hiding all previous error messages **/
    $j(".jive-error-box").hide();
    $j( ".jive-error-message" ).each(function( index ) {
        if(!$j(this).hasClass('numeric-error'))
        {
            $j(this).hide();
        }
    });

    var name = $j("input[name=name]");
    if(name.pVal() != null && $j.trim(name.pVal())=="")
    {
        name.next().show();
        name.focus();
        return false;
    }
	
    var description = $j("textarea[name=descriptionText]");
    if(description.val() != null && $j.trim(description.val())=="")
    {
        $j("textarea[name=description]").next().show();
        $j("textarea[name=description]").focus();
        return false;
    }

    var categorySize = $j("#categoryType option").size();
    if(categorySize < 1)
    {
        $j("#categoryType").parent().next().next().show();
        $j("#categoryType").focus();
        return false;
    }

    var brand = $j("#brand");
    if(brand.val()==null || brand.val()<0)
    {
        brand.next().show();
        brand.focus();
        return false;
    }

//    var methodologyType = $j("#methodologyType");
//    if(methodologyType.val()==null || methodologyType.val()<0)
//    {
//        methodologyType.next().show();
//        methodologyType.focus();
//        return false;
//    }

    var methodologyGroup = $j("#methodologyGroup");
    if(methodologyGroup.val()==null || methodologyGroup.val()<0)
    {
        methodologyGroup.next().show();
        methodologyGroup.focus();
        return false;
    }

    var endMarkets = $j("#endMarkets");
    if(endMarkets.val()==null || endMarkets.val()<0)
    {
        endMarkets.parent().find("span").show();
        endMarkets.focus();
        return false;
    }

    var startDate = $j("input[name=startDate]");
    if(startDate.val() != null && $j.trim(startDate.val())=="")
    {
        startDate.parents('div:eq(0)').find("span").show();
        startDate.focus();
        return false;
    }
    else if(!isDateformat(startDate.val()))
    {
        startDate.parents('div:eq(0)').find("span").show();
        startDate.parents('div:eq(0)').find("span").text("Project start date should be in dd/mm/yyyy format");
        startDate.focus();
        return false;
    }


    var endDate = $j("input[name=endDate]");
    if(endDate.val() != null && $j.trim(endDate.val())=="")
    {
        endDate.parents('div:eq(0)').find("span").show();
        endDate.focus();
        return false;
    }
    else if(!isDateformat(endDate.val()))
    {
        endDate.parents('div:eq(0)').find("span").show();
        endDate.parents('div:eq(0)').find("span").text("Project end date should be in dd/mm/yyyy format");
        endDate.focus();
        return false;
    }

    if(!compareDate(startDate.val(), endDate.val()))
    {
        endDate.parents('div:eq(0)').find("span").show();
        endDate.parents('div:eq(0)').find("span").text("Enter an end date which is after the project start date");
        endDate.focus();
        return false;
    }

    var initialCost = $j("input[name^=initialCost]");
    if(initialCost.val() != null && $j.trim(initialCost.val())=="")
    {
        initialCost.parent().find("span").text("Please enter estimated cost");
        initialCost.parent().find("span").show();
        initialCost.focus();
        return false;
    }


    $j(".numericfield").each(function(){
        if($j(this).parent().find("span").is(":visible"))
        {
            error = true;
            $j(this).focus();
        }
    });

    if(error)
        return false;

    var currency = $j("select[name^=initialCostCurrency]");
    if(currency.val()==null || currency.val() < 0)
    {
        currency.parent().find("p").show();
        currency.focus();
        return false;
    }
    var owner = $j("input[name=projectOwner]");

    if(owner.val() != null && $j.trim(owner.val())=="")
    {
        owner.parent().find("span").show();
        owner.focus();
        return false;
    }

    var spi = $j("input[name=spiContact]");

    if(spi.val() != null && $j.trim(spi.val())=="")
    {
        spi.parent().find("span").show();
        spi.focus();
        return false;
    }

    /*var err_found = false;
     $j("input[name^=spiContact]").each(function( index ) {
     if($j(this).val() != null && $j.trim($j(this).val())=="")
     {
     $j(this).parent().find("span").show();
     $j(this).focus();
     err_found = true;
     return false;
     }
     });

     if(err_found)
     return false;
     */

    $j('#categoryType option').attr('selected', 'selected');
    $j('#proposedMethodology option').attr('selected', 'selected');

    return true;
}

/* This function is created for https://svn.sourcen.com/issues/19687 */
function validateSaveForm()
{
    var error = false;
    /** Code to be placed before hiding all previous error messages **/
    $j(".jive-error-box").hide();
    $j( ".jive-error-message" ).each(function( index ) {
        if(!$j(this).hasClass('numeric-error'))
        {
            $j(this).hide();
        }
    });

    var name = $j("input[name=name]");
    if(name.pVal() != null && $j.trim(name.pVal())=="")
    {
        name.next().show();
        name.focus();
        error = true;
        //return false;
    }
	
    /*var description = $j("textarea[name=descriptionText]");
    if(description.val() != null && $j.trim(description.val())=="")
    {
        $j("textarea[name=description]").next().show();
        $j("textarea[name=description]").focus();
       // return false;
        error = true;
    }
*/
    /*var categorySize = $j("#categoryType option").size();
    if(categorySize < 1)
    {
        $j("#categoryType").parent().next().next().show();
        $j("#categoryType").focus();
        //return false;
         error = true;
    }

    var brand = $j("#brand");
    if(brand.val()==null || brand.val()<0)
    {
        brand.next().show();
        brand.focus();
       // return false;
        error = true;
    }

//    var methodologyType = $j("#methodologyType");
//    if(methodologyType.val()==null || methodologyType.val()<0)
//    {
//        methodologyType.next().show();
//        methodologyType.focus();
//       // return false;
//        error = true;
//    }

    var methodologyGroup = $j("#methodologyGroup");
    if(methodologyGroup.val()==null || methodologyGroup.val()<0)
    {
        methodologyGroup.next().show();
        methodologyGroup.focus();
       // return false;
        error = true;
    }

    var endMarkets = $j("#endMarkets");
    if(endMarkets.val()==null || endMarkets.val()<0)
    {
        endMarkets.parent().find("span").show();
        endMarkets.focus();
       // return false;
        error = true;
    }
*/
    var startDate = $j("input[name=startDate]");
	if(startDate.val() != null && $j.trim(startDate.val())!="")
	{
		
		if(startDate.val() != null && $j.trim(startDate.val())=="")
		{
			startDate.parents('div:eq(0)').find("span").show();
			startDate.focus();
		   // return false;
			error = true;
		}
		else if(!isDateformat(startDate.val()))
		{
			startDate.parents('div:eq(0)').find("span").show();
			startDate.parents('div:eq(0)').find("span").text("Project start date should be in dd/mm/yyyy format");
			startDate.focus();
			//return false;
			 error = true;
		}

	}
    var endDate = $j("input[name=endDate]");
    
	if(endDate.val() != null && $j.trim(endDate.val())!="")
	{
		if(endDate.val() != null && $j.trim(endDate.val())=="")
		{
			endDate.parents('div:eq(0)').find("span").show();
			endDate.focus();
			//return false;
			 error = true;
		}
		else if(!isDateformat(endDate.val()))
		{
			endDate.parents('div:eq(0)').find("span").show();
			endDate.parents('div:eq(0)').find("span").text("Project end date should be in dd/mm/yyyy format");
			endDate.focus();
		   // return false;
			error = true;
		}

		if(!compareDate(startDate.val(), endDate.val()))
		{
			endDate.parents('div:eq(0)').find("span").show();
			endDate.parents('div:eq(0)').find("span").text("Enter an end date which is after the project start date");
			endDate.focus();
		  //  return false;
		   error = true;
		}
	}
   /* var initialCost = $j("input[name^=initialCost]");
    if(initialCost.val() != null && $j.trim(initialCost.val())=="")
    {
        initialCost.parent().find("span").text("Please enter estimated cost");
        initialCost.parent().find("span").show();
        initialCost.focus();
      //  return false;
        error = true;
    }
*/

    $j(".numericfield").each(function(){
        if($j(this).parent().find("span").is(":visible"))
        {
            error = true;
            $j(this).focus();
        }
    });

/*    var currency = $j("select[name^=initialCostCurrency]");
    if(currency.val()==null || currency.val() < 0)
    {
        currency.parent().find("p").show();
        currency.focus();
       // return false;
        error = true;
    }
    var owner = $j("input[name=projectOwner]");

    if(owner.val() != null && $j.trim(owner.val())=="")
    {
        owner.parent().find("span").show();
        owner.focus();
      //  return false;
       error = true;
    }

    var spi = $j("input[name=spiContact]");

    if(spi.val() != null && $j.trim(spi.val())=="")
    {
        spi.parent().find("span").show();
        spi.focus();
       // return false;
        error = true;
    }

*/
  //  $j('#categoryType option').attr('selected', 'selected');
   // $j('#proposedMethodology option').attr('selected', 'selected');
	
	if(error)
	{
        return false;
    }
    return true;
}

/* Validate multi-market form */
function validateMultiMarketForm()
{
    var error = false;

    /** Code to be placed before hiding all previous error messages **/
    $j(".jive-error-box").hide();
    $j( ".jive-error-message" ).each(function( index ) {
        if(!$j(this).hasClass('numeric-error'))
        {
            $j(this).hide();
        }
    });

    var name = $j("input[name=name]");
    if(name.val() != null && $j.trim(name.val())=="")
    {
        name.next().show();
        name.focus();
        return false;
    }

    var description = $j("textarea[name=descriptionText]");
    if(description.val() != null && $j.trim(description.val())=="")
    {
        $j("textarea[name=description]").next().show();
        $j("textarea[name=description]").focus();
        return false;
    }

    var categorySize = $j("#categoryType option").size();
    if(categorySize < 1)
    {
        $j("#categoryType").parent().next().next().show();
        $j("#categoryType").focus();
        return false;
    }

    var brand = $j("#brand");
    if(brand.val()==null || brand.val()<0)
    {
        brand.next().show();
        brand.focus();
        return false;
    }

//    var methodologyType = $j("#methodologyType");
//    if(methodologyType.val()==null || methodologyType.val()<0)
//    {
//        methodologyType.next().show();
//        methodologyType.focus();
//        return false;
//    }

    var methodologyGroup = $j("#methodologyGroup");
    if(methodologyGroup.val()==null || methodologyGroup.val()<0)
    {
        methodologyGroup.next().show();
        methodologyGroup.focus();
        return false;
    }

  /*  var endMarketsSize = $j("#endMarkets option").size();
    if(endMarketsSize < 1)
    {
        $j("#endMarkets").parent().next().next().show();
        $j("#endMarkets").focus();
        return false;
    }
    */
    
    var marketsSize = $j("#markets option").size();
    if(marketsSize < 1)
    {
        $j("#markets").parent().next().next().show();
        $j("#markets").focus();
        return false;
    }

    var startDate = $j("input[name=startDate]");
    if(startDate.val() != null && $j.trim(startDate.val())=="")
    {
        startDate.parents('div:eq(0)').find("span").show();
        startDate.focus();
        return false;
    }
    else if(!isDateformat(startDate.val()))
    {
        startDate.parents('div:eq(0)').find("span").show();
        startDate.parents('div:eq(0)').find("span").text("Project start date should be in dd/mm/yyyy format");
        startDate.focus();
        return false;
    }


    var endDate = $j("input[name=endDate]");
    if(endDate.val() != null && $j.trim(endDate.val())=="")
    {
        endDate.parents('div:eq(0)').find("span").show();
        endDate.focus();
        return false;
    }
    else if(!isDateformat(endDate.val()))
    {
        endDate.parents('div:eq(0)').find("span").show();
        endDate.parents('div:eq(0)').find("span").text("Project end date should be in dd/mm/yyyy format");
        endDate.focus();
        return false;
    }

    if(!compareDate(startDate.val(), endDate.val()))
    {
        endDate.parents('div:eq(0)').find("span").show();
        endDate.parents('div:eq(0)').find("span").text("Enter an end date which is after the project start date");
        endDate.focus();
        return false;
    }

    var owner = $j("input[name=projectOwner]");
    if(owner.val() != null && $j.trim(owner.val())=="")
    {
        owner.parent().find("span").show();
        owner.focus();
        return false;
    }

    /* CAP ratings */
   /* var capRating = $j("select[name^=capRating]");
    if(capRating.val()==null || capRating.val() < 0)
    {
        capRating.parent().find("span").show();
        capRating.focus();
        return false;
    }
*/
	/*SVN-18817*/
	var error = false;
	/*var endMarkets = [];
    $j("#endMarkets > option").each(function(index) {    
		var $rowsize = $j("#investment-details tbody tr[id^=ivt_row_4_"+$j(this).val()+"]").length;
		if($rowsize<1)
		{
			$j("#investment-error").text("Please Add at-least one location and funding");
			$j("#investment-error").show();		
			$j(".project_addfunding_btn").focus();
			error = true;
		}
    });
	
	if(error)
	{
		$j("#investment-error").text("Please add all endmarket investments");
        $j("#investment-error").show();		
        $j(".project_addfunding_btn").focus();
        return false;
	}*/
	
	var markets = [];
    $j("#markets > option").each(function(index) {

	    var marketValue = $j(this).val();
	    if(marketValue.indexOf("A")!=-1)
	    {
//	       var $rowsize = $j("#investment-details tbody tr[id^=ivt_row_4_"+marketValue.replace("A","")+"]").length;
//		   if($rowsize<1)
//		   {
//				$j("#investment-error").text("Please add at-least one location and funding");
//				$j("#investment-error").show();
//				$j(".project_addfunding_btn").focus();
//				error = true;
//		   }
	    }

    });
	
//	if(error)
//	{
//		$j("#investment-error").text("Please add all end-market investments");
//        $j("#investment-error").show();
//        $j(".project_addfunding_btn").focus();
//        return false;
//	}
	
    /*Check Investment grid for atleast one entry*/
    var global_rows = $j(".global-row").length;
    var country_rows = $j(".country-row").length;
//    if(global_rows==0 && country_rows==0)
//    {
//		$j("#investment-error").text("Please add at-least one location and funding");
//        $j("#investment-error").show();
//        $j(".project_addfunding_btn").focus();
//        return false;
//    }

    if(global_rows==0 && country_rows==0)
    {
        $j("#investment-error").text("Please add at least one above market investment");
        $j("#investment-error").show();
        $j(".project_addfunding_btn").focus();
        return false;
    }
	
    /* Total Cost field */
    var totalCost = $j("input[name^=totalCost-display]");
   /* if(totalCost.val() != null && $j.trim(totalCost.val())=="")
    {
        totalCost.parent().find("span").text("Please enter total cost");
        totalCost.parent().find("span").show();
        totalCost.focus();
        return false;
    }
*/

    $j(".numericfield").each(function(){
        if($j(this).parent().find("span").is(":visible"))
        {
            error = true;
            $j(this).focus();
        }
    });

    if(error)
        return false;

    var currency = $j("select[name^=totalCostCurrency-display]");
    if(currency.val()==null || currency.val() < 0)
    {
        currency.parent().find("p").show();
        currency.focus();
        return false;
    }

    if(!error)
    {
        $j("input[name=totalCost]").val($j("input[name=totalCost-display]").val().replace(/\,/g, ''));
        $j("input[name=totalCostCurrency]").val($j("#totalCostCurrency-display").val());
        $j('#categoryType option').attr('selected', 'selected');
        $j('#proposedMethodology option').attr('selected', 'selected');
        $j('#endMarkets option').attr('selected', 'selected');
    }
    return true;
}

/* This method is for https://svn.sourcen.com/issues/19687 */
function validateSaveMultiMarketForm()
{
    var error = false;

    /** Code to be placed before hiding all previous error messages **/
    $j(".jive-error-box").hide();
    $j( ".jive-error-message" ).each(function( index ) {
        if(!$j(this).hasClass('numeric-error'))
        {
            $j(this).hide();
        }
    });

    var name = $j("input[name=name]");
    if(name.val() != null && $j.trim(name.val())=="")
    {
        name.next().show();
        name.focus();
       // return false;
       error = true;
    }

    var description = $j("textarea[name=descriptionText]");
    if(description.val() != null && $j.trim(description.val())=="")
    {
        $j("textarea[name=description]").next().show();
        $j("textarea[name=description]").focus();
        //return false;
        error = true;
    }

    var categorySize = $j("#categoryType option").size();
    if(categorySize < 1)
    {
        $j("#categoryType").parent().next().next().show();
        $j("#categoryType").focus();
       // return false;
       error = true;
    }

    var brand = $j("#brand");
    if(brand.val()==null || brand.val()<0)
    {
        brand.next().show();
        brand.focus();
       // return false;
       error = true;
    }

//    var methodologyType = $j("#methodologyType");
//    if(methodologyType.val()==null || methodologyType.val()<0)
//    {
//        methodologyType.next().show();
//        methodologyType.focus();
//       // return false;
//       error = true;
//    }

    var methodologyGroup = $j("#methodologyGroup");
    if(methodologyGroup.val()==null || methodologyGroup.val()<0)
    {
        methodologyGroup.next().show();
        methodologyGroup.focus();
       // return false;
       error = true;
    }

   /* var endMarketsSize = $j("#endMarkets option").size();
    if(endMarketsSize < 1)
    {
        $j("#endMarkets").parent().next().next().show();
        $j("#endMarkets").focus();
        error = true;
    }
*/
    var startDate = $j("input[name=startDate]");
    if(startDate.val() != null && $j.trim(startDate.val())=="")
    {
        startDate.parents('div:eq(0)').find("span").show();
        startDate.focus();
       // return false;
       error = true;
    }
    else if(!isDateformat(startDate.val()))
    {
        startDate.parents('div:eq(0)').find("span").show();
        startDate.parents('div:eq(0)').find("span").text("Project start date should be in dd/mm/yyyy format");
        startDate.focus();
       // return false;
       error = true;
    }


    var endDate = $j("input[name=endDate]");
    if(endDate.val() != null && $j.trim(endDate.val())=="")
    {
        endDate.parents('div:eq(0)').find("span").show();
        endDate.focus();
      //  return false;
        error = true;
    }
    else if(!isDateformat(endDate.val()))
    {
        endDate.parents('div:eq(0)').find("span").show();
        endDate.parents('div:eq(0)').find("span").text("Project end date should be in dd/mm/yyyy format");
        endDate.focus();
        //return false;
        error = true;
    }

    if(!compareDate(startDate.val(), endDate.val()))
    {
        endDate.parents('div:eq(0)').find("span").show();
        endDate.parents('div:eq(0)').find("span").text("Enter an end date which is after the project start date");
        endDate.focus();
        //return false;
        error = true;
    }

    var owner = $j("input[name=projectOwner]");
    if(owner.val() != null && $j.trim(owner.val())=="")
    {
        owner.parent().find("span").show();
        owner.focus();
       // return false;
       error = true;
    }

    /* CAP ratings */
   /* var capRating = $j("select[name^=capRating]");
    if(capRating.val()==null || capRating.val() < 0)
    {
        capRating.parent().find("span").show();
        capRating.focus();
       // return false;
       error = true;
    }
*/
	/*SVN-18817*/
	var endMarketError = false;
	var endMarkets = [];
   /* $j("#endMarkets > option").each(function(index) {    
		var $rowsize = $j("#investment-details tbody tr[id^=ivt_row_4_"+$j(this).val()+"]").length;
		if($rowsize<1)
		{
			$j("#investment-error").text("Please Add at-least one location and funding");
			$j("#investment-error").show();		
			$j(".project_addfunding_btn").focus();
			endMarketError = true;
		}
    });
	
	if(endMarketError)
	{
		$j("#investment-error").text("Please add all endmarket investments");
        $j("#investment-error").show();		
        $j(".project_addfunding_btn").focus();
       // return false;
       error = true;
	}
	
   
    var global_rows = $j(".global-row").length;
    var country_rows = $j(".country-row").length;
    if(global_rows==0 && country_rows==0)
    {
		$j("#investment-error").text("Please Add at-least one location and funding");
        $j("#investment-error").show();		
        $j(".project_addfunding_btn").focus();
        //return false;
        error = true;
    }
	*/
    /* Total Cost field */
    var totalCost = $j("input[name^=totalCost-display]");
  /*  if(totalCost.val() != null && $j.trim(totalCost.val())=="")
    {
        totalCost.parent().find("span").text("Please enter total cost");
        totalCost.parent().find("span").show();
        totalCost.focus();
       // return false;
       error = true;
    }
*/

    $j(".numericfield").each(function(){
        if($j(this).parent().find("span").is(":visible"))
        {
            error = true;
            $j(this).focus();
        }
    });

  // if(error)
    //    return false;

    var currency = $j("select[name^=totalCostCurrency-display]");
    if(currency.val()==null || currency.val() < 0)
    {
        currency.parent().find("p").show();
        currency.focus();
       // return false;
       error = true;
    }

    if(!error)
    {
        $j("input[name=totalCost]").val($j("input[name=totalCost-display]").val().replace(/\,/g, ''));
        $j("input[name=totalCostCurrency]").val($j("#totalCostCurrency-display").val());
        $j('#categoryType option').attr('selected', 'selected');
        $j('#proposedMethodology option').attr('selected', 'selected');
        //$j('#endMarkets option').attr('selected', 'selected');
        $j('#markets option').attr('selected', 'selected');
    }
    else
    {
    	return false;
    }
    return true;
}

function numericFormat(uzip) {
    var numbers = /^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{1,9})?$/;
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

function compareDate(startDate, endDate)
{
    if(DateParser.parse(startDate) <= DateParser.parse(endDate))
        return true;
    else
        return false;
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

function processCategoryField()
{
   /* showLoader('Fetching list');
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
                hideLoader();
            },
            async: false,
            timeout: 20000
        });
    }
    else
    {
        rebuildAllBrandsField();
        hideLoader();
    }

    FieldMappingUtil.getDefaultBrandID(true,{
        callback: function(id) {
            $j('#brand').val(id);
        },
        async: false,
        timeout: 20000
    });*/
}

function rebuildBrandsField(result)
{
/*    $j('#brand')[0].options.length = 0;
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
*/
}

function rebuildAllBrandsField()
{
  /*  $j('#brand')[0].options.length = 0;
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
	*/
}

function processProposedMethodology()
{
    showLoader('Fetching list');
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

    FieldMappingUtil.getDefaultProposedMethodologyID(true,{
        callback: function(id) {
            $j('#proposedMethodology').val(id);
        },
        async: false,
        timeout: 20000
    });
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
    hideLoader();
}

/*Multi market Code */

/** Proposed Methodology Multi Select Box Code **/
$j.processMultiMarketProposedField = function()
{
    showLoader('Fetching list');
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
        if(!contains(result, $j(this).val()))
        {
            $j(this).remove();
        }
    });
    if($j("#allProposedMethodologyFields") && $j("#allProposedMethodologyFields").length > 0) {
        $j("#allProposedMethodologyFields")[0].options.length = 0;
        $j.each(result, function( key, value ) {
            if(!contains(methodologiesArray, value))
            {
                $j("#allProposedMethodologyFields").append($j("<option></option>").attr("value",value).text(names[value]));
            }
        });
    }
    hideLoader();
}
/** Proposed Methodology Multi Select Box Code **/

function processInvestmentFields()
{

    var options = [];
    var pageType = $j("#pageType").val();
    if(pageType=='pib')
    {
        $j("#updatedSingleMarketId1 > option").each(function(index) {
            options[index] = $j(this).val();
        });
    }
    else
    {
        $j("#endMarkets > option").each(function(index) {
            options[index] = $j(this).val();
        });
    }

    if(options.length > 0)
    {
        /* Region field*/
        /** Commented as per Issue 18625
         FieldMappingUtil.getRegionByEndMarkets(options, {
         callback: function(result) {
         rebuildInvestmentField(result, "region");
         },
         async: false,
         timeout: 20000
         });
         **/
        /* Area Field */
        FieldMappingUtil.getAreaByEndMarkets(options, {
            callback: function(result) {
                rebuildInvestmentField(result, "area");
            },
            async: false,
            timeout: 20000
        });

        /* Country Fields*/
        $j("select[name='fieldwork']")[0].options.length = 0;
        $j("select[name='fieldwork']")
            .append($j("<option disabled></option>")
            .attr("value",-1)
            .text("-- None --"));

        if(pageType=='pib')
        {
            $j("#updatedSingleMarketId1 > option").each(function(index) {
                $j("select[name='fieldwork']")
                    .append($j("<option></option>")
                    .attr("value",$j(this).val())
                    .text($j(this).text()));
            });
        }
        else
        {
            $j("#endMarkets > option").each(function(index) {
                $j("select[name='fieldwork']")
                    .append($j("<option></option>")
                    .attr("value",$j(this).val())
                    .text($j(this).text()));
            });
        }
    }
}

function processInvestmentFieldsPIT()
{

    var options = [];
    var pageType = $j("#pageType").val();
    if(pageType=='pib')
    {
        $j("#updatedSingleMarketId1 > option").each(function(index) {
            options[index] = $j(this).val();
        });
    }
    else
    {
        $j("#markets > option").each(function(index) {
            
            var marketValue = $j(this).val();
           
            if(marketValue.indexOf("A")!=-1)
            {
            	options[index] = marketValue.replace("A","");
            }
        });
    }

    if(options.length > 0)
    {
        /* Region field*/
        /** Commented as per Issue 18625
         FieldMappingUtil.getRegionByEndMarkets(options, {
         callback: function(result) {
         rebuildInvestmentField(result, "region");
         },
         async: false,
         timeout: 20000
         });
         **/
        /* Area Field */
        FieldMappingUtil.getAreaByEndMarkets(options, {
            callback: function(result) {
                rebuildInvestmentField(result, "area");
            },
            async: false,
            timeout: 20000
        });

        /* Country Fields*/
        $j("select[name='fieldwork']")[0].options.length = 0;
        $j("select[name='fieldwork']")
            .append($j("<option disabled></option>")
            .attr("value",-1)
            .text("-- None --"));

        if(pageType=='pib')
        {
            $j("#updatedSingleMarketId1 > option").each(function(index) {
                $j("select[name='fieldwork']")
                    .append($j("<option></option>")
                    .attr("value",$j(this).val())
                    .text($j(this).text()));
            });
        }
        else
        {
            $j("#markets > option").each(function(index) {
                
                 var marketValue = $j(this).val();
           
	            if(marketValue.indexOf("A")!=-1)
	            {
	            	 $j("select[name='fieldwork']")
                    .append($j("<option></option>")
                    .attr("value",marketValue.replace("A",""))
                    .text($j(this).text()));
	            }
                
               
            });
        }
    }
}
function rebuildInvestmentField(result, field)
{
    $j("select[name='"+field+"']")[0].options.length = 0;
    $j("select[name='"+field+"']")
        .append($j("<option></option>")
        .attr("value",-1)
        .text("Select "+field));
    $j.each(result, function( key, value ) {
        $j("select[name='"+field+"']")
            .append($j("<option></option>")
            .attr("value",key)
            .text(result[key]));
    });
}

function closePopUp()
{
    investmentPopup.close();
}

function resetInvestmentDropdowns()
{
    $j(".investment-popup-select").each(function(i) {
        $j(this).attr("disabled", true);
    });
}

function saveInvestment(data)
{
    if(validateInvestmentForm())
    {
        $j("input[name=canViewRow]").val("true");
        if(showInvestmentDetails(data)) {
            closePopUp();
        }

        $j("#investment-error").hide();
    }
}

function showInvestmentDetails(data) {

    /*Remove empty row message when first entry is saved into it.*/
    
    
    var pageType = $j("#pageType").val();

    var $emptyRow = (pageType == 'pib')?$j("#pitWindow .investment-details-table .no-items"):$j(".investment-details-table .no-items");
    if($emptyRow.length > 0 )
    {
        $emptyRow.remove();
    }

    /* Get values from popup */
    var typeName = getInvestmentType(data);
    var fieldwork = (pageType == 'pib' && data != undefined && data != null && data.fieldwork)?data.fieldwork:getFieldwork();
    var funding = (pageType == 'pib' && data != undefined && data != null && data.funding)?data.funding:getFunding();
    var projectContactID = (pageType == 'pib' && data != undefined && data != null && data.projectContactID)?data.projectContactID:$j("#add-investment-popup input[name=projectContact]").val();
    var projectContactName = (pageType == 'pib' && data != undefined && data != null && data.projectContactName)?data.projectContactName:$j("#add-investment-popup input[id=projectContact]").val();
    var spiContactID = (pageType == 'pib' && data != undefined && data != null && data.spiContactID)?data.spiContactID:$j("#add-investment-popup input[name=spiContact]").val();
    var spiContactName = (pageType == 'pib' && data != undefined && data != null && data.spiContactName)?data.spiContactName:$j("#add-investment-popup input[id=spiContact]").val();
    var spiCostCurrency = (pageType == 'pib' && data != undefined && data != null && data.currencyName)?data.currencyName:getSPICostCurrency();
    var currency = (pageType == 'pib' && data != undefined && data != null && data.currency)?data.currency:$j("#add-investment-popup #initialCostCurrency").val();
    var cost = (pageType == 'pib' && data != undefined && data != null && data.cost)?data.cost:getSPICost();
    var idChanged = false;


	
	
    /*Generate new row id and row class*/
    var row_id = generateRowID(data);
	var approvalStatus = (pageType == 'pib' && data != undefined)?data.approvalStatus:null;
	
    var investmentID = (pageType == 'pib' && data != undefined && data != null && data.investmentID)?data.investmentID:$j("#add-investment-popup #investmentID").val();

    var editRowID = (pageType == 'pib' && data != undefined && data != null && data.editRowID)?data.editRowID:$j("#add-investment-popup #editRowID").val();
    var editMode = (pageType == 'pib' && data != undefined && data != null && data.editMode != null)?data.editMode:$j("#add-investment-popup #editMode").val();
    var approved = (pageType == 'pib' && data != undefined && data != null && data.approved != null)?data.approved:$j("#add-investment-popup #approved").val();
	
	/*Default alue is set to true for PIT page. And for MM PIB value value will always come in the form of true or false but never null.*/
	var canModify = (pageType == 'pib' && data != undefined && data != null && data.canModify)?data.canModify:"true";
	
	var isAdminUser = (pageType == 'pib' && data != undefined && data != null && data.isAdminUser)?data.isAdminUser:"false";
	
	var canView = (pageType == 'pib' && data != undefined && data != null && data.canView)?data.canView:"false";

	var canViewRow = $j("#canViewRow").val(); 
	if(pageType !='pib')
	{
		canView = "true";
	}
	if(canViewRow!= undefined && canViewRow != null && canViewRow=="true")
	{
		canView = "true";
	}
	
	var isBudgetApprover = false;
	
	if(userID!=null && projectContactID==userID)
	{
		isBudgetApprover = true;
	}
	else if(userID!=null && spiContactID==userID)
	{
		isBudgetApprover = true;
	}
	else if(isAdminUser!=null && isAdminUser=="true")
	{
		isBudgetApprover = true;
	}
	else
	{
		isBudgetApprover = false;
	}
	
    /**Check if row id will be changed*/
    if(row_id != editRowID)
        idChanged = true;

    /**Check if row if entry is above market or country level**/
    var $typeID = (pageType == 'pib' && data != undefined && data != null && data.investmentType)?data.investmentType:$j('input:radio[name=investmentType]:checked').val();
    var class_level = "global-row";
    var rowExits = false;
    var reachedMaxLimit = false;
    var message = "Already added";
    var rowIdArr = row_id.split("_");
    if($typeID == 4) {
        class_level = "country-row";
        var country_rows_count = $j(".country-row").length;
        if(country_rows_count != null && country_rows_count >= 10) {
            reachedMaxLimit = true;
            message = "Investment cannot be added. Maximum limit of 10 countries is reached.";
        } else {
            if(rowIdArr != null && rowIdArr.length == 6) {
                $j(".investment-details-table tr.country-row").each(function(){
                    var currRowId = $j(this).attr("id");
                    if(editMode == "false"
                        || (editMode == "true" && currRowId != editRowID)) {
                        var currRowIdArr = currRowId.split("_");
                        if(currRowIdArr.length == 6
                            && currRowIdArr[3] == rowIdArr[3]) {
                            rowExits = true;
                            message = "'"+fieldwork+"' country investment already added."
                            return;
                        }
                    }
                });
            }
        }
    }  else if(editMode == "false") {
        $j(".investment-details-table tr.global-row").each(function(){
            var currRowIdArr = $j(this).attr("id").split("_");		
				
			var regionType = $j("#add-investment-popup #region");
			var region = (pageType == 'pib' && data != undefined && data != null && data.regionType)?data.regionType:$j(regionType).val();			
					 
            if(currRowIdArr[2] == $typeID && currRowIdArr[3]==region) {
                rowExits = true;
                if($typeID == 1) {
                    message = "Global investment already added."
                } else if($typeID == 2) {					 
						message = "Regional investment already added."
                } else if($typeID == 3) {
                    message = "Area investment already added."
                }
                return;
            }
        });
    }
	
    if(rowExits || reachedMaxLimit) {
        dialog({
            title:"Message",
            html:message,
            open:function(){
                $j("#add-investment-popup").parent().hide();
            },
            close:function() {
                $j("#add-investment-popup").parent().show();
                
            },
            buttons: { "Ok": function() { 
            closeDialog();
            $j("#add-investment-popup").parent().show();
            }}
            
        });
        return false;
    }
    
    if(editMode == "true") {
        var $row = $j("#"+editRowID);
        var $td = $row.find('td:first');
        //Investment Column
        $td.html("<span>"+typeName + "</span><input type='hidden' name='investmentID' id='investmentID' value='"+investmentID+"' />");

        //Fieldwork Column
        $td = $td.next();
        $td.text(fieldwork);

        //Funding Column
        $td = $td.next();
        $td.text(funding);

        //Project Contact Column
        $td = $td.next();
        var $html = projectContactName;
        $html = $html + "<input type='hidden' name='contact-id' id='contact-id' value='"+projectContactID+"' />";
        $html = $html + "<input type='hidden' name='contact-name' id='contact-name' value='"+projectContactName+"' />";
        $td.html($html);

        //Project SPI Column
        $td = $td.next();
        var $html = spiContactName;
        $html = $html + "<input type='hidden' name='spi-id' id='spi-id' value='"+spiContactID+"' />";
        $html = $html + "<input type='hidden' name='spi-name' id='spi-name' value='"+spiContactName+"' />";
        $td.html($html);

        //Estimated Cost Column
        $td = $td.next();
        $td.text(cost);

        //Estimated Cost Currency Column
        $td = $td.next();
        $html = spiCostCurrency;
        $html = $html + "<input type='hidden' name='currency' id='currency' value='"+currency+"' />";
        $td.html($html);

        //update row id
        $row.attr("id",row_id);
        $j.restructure($j("#"+row_id));
        return true;
    }

//    if(editMode=="true" && row_id.split("_").length==6 && editRowID.split("_").length!=6)
//    {
//        var country_rows_count = $j(".country-row").length;
//        if(country_rows_count!=null && country_rows_count>=10)
//        {
//            dialog();
//            $j("#dialog-box").html("Investment cannot be added. Maximum limit of 10 countries is reached.");
//            closePopUp();
//            return;
//        }
//    }

//    /*Check if row having same type and values exists or NOT*/
//    console.log($j("#"+row_id));
//    if($j("#"+row_id).length > 0) {
//        if(editMode=="true" && !idChanged)
//        {
//            //Do Nothing
//        }
//        else
//        {
//            dialog();
//            $j("#dialog-box").html("Already added");
//            closePopUp();
//            return;
//        }
//    } else if(row_id.split('_').length==6) {
//        /*Check if same fieldwork is added irrespective of the funding*/
//        var prefix$id = row_id.substring(0,row_id.lastIndexOf("_"));
//        if($j("tr[id^="+prefix$id+"]").length>0)
//        {
//            dialog();
//            $j("#dialog-box").html("Already added");
//            closePopUp();
//            return;
//        }
//    }
//
//    if(editMode=="true")
//    {
//        var $row = $j("#"+editRowID);
//        var $td = $row.find('td:first');
//        //Investment Column
//        $td.html("<span>"+typeName + "</span><input type='hidden' name='investmentID' id='investmentID' value='"+investmentID+"' />");
//
//        //Fieldwork Column
//        $td = $td.next();
//        $td.text(fieldwork);
//
//        //Funding Column
//        $td = $td.next();
//        $td.text(funding);
//
//        //Project Contact Column
//        $td = $td.next();
//        var $html = projectContactName;
//        $html = $html + "<input type='hidden' name='contact-id' id='contact-id' value='"+projectContactID+"' />";
//        $html = $html + "<input type='hidden' name='contact-name' id='contact-name' value='"+projectContactName+"' />";
//        $td.html($html);
//
//        //Project SPI Column
//        $td = $td.next();
//        var $html = spiContactName;
//        $html = $html + "<input type='hidden' name='spi-id' id='spi-id' value='"+spiContactID+"' />";
//        $html = $html + "<input type='hidden' name='spi-name' id='spi-name' value='"+spiContactName+"' />";
//        $td.html($html);
//
//        //Estimated Cost Column
//        $td = $td.next();
//        $td.text(cost);
//
//        //Estimated Cost Currency Column
//        $td = $td.next();
//        $html = spiCostCurrency;
//        $html = $html + "<input type='hidden' name='currency' id='currency' value='"+currency+"' />";
//        $td.html($html);
//
//        //update row id
//        $row.attr("id",row_id);
//        closePopUp();
//        return;
//    }

	
	
    /*Adding new row with Values */
	var approveDisabled = 'disabled';
	if(isBudgetApprover)
	{
		approveDisabled = '';
	}
	if(canView!=null && canView=="true")
	{
	    var investmentDetails = (pageType == 'pib')?$j("#pitWindow #investment-details"):$j("#investment-details");
		var approvedStatusName = getApprovedStatusNameByIndex();	
	    $j(investmentDetails).find('tbody')
	        .append($j("<tr id="+row_id+" class='"+class_level+"'>")
	        .append($j('<td>')
	        .append("<span>"+typeName+"</span>")
	        .append("<input type='hidden' name='investmentID' id='investmentID' value='"+investmentID+"' />")
	    ).append($j('<td>')
	        .append(fieldwork)
	    ).append($j('<td>')
	        .append(funding)
	    ).append($j("<td class='contact-col'>")
	        .append(projectContactName)
	        .append("<input type='hidden' name='contact-id' id='contact-id' value='"+projectContactID+"' />")
	        .append("<input type='hidden' name='contact-name' id='contact-name' value='"+projectContactName+"' />")
	    ).append($j("<td class='spi-col'>")
	        .append(spiContactName)
	        .append("<input type='hidden' name='spi-id' id='spi-id' value='"+spiContactID+"' />")
	        .append("<input type='hidden' name='spi-name' id='spi-name' value='"+spiContactName+"' />")
	    ).append($j("<td class='cost-col'>")
	        .append(cost)
	    ).append($j("<td class='curr-col'>")
	        .append(spiCostCurrency)
	        .append("<input type='hidden' name='currency' id='currency' value='"+currency+"' />")
	    )
	        .append($j("<td class='approve-fld'>")
	        .append((approvalStatus!=null && approvalStatus == "true")?"<div class='approve-input-yes'><input "+approveDisabled+" type='radio' name='"+approvedStatusName+"' value='1' checked /><span>Yes</span></div><div class='approve-input-no'><input "+approveDisabled+" type='radio' name='"+approvedStatusName+"' value='0'/><span>No</span></div>":(approvalStatus!=null && approvalStatus == "false")?"<div class='approve-input-yes'><input "+approveDisabled+" type='radio' name='"+approvedStatusName+"' value='1'/><span>Yes</span></div><div class='approve-input-no'><input "+approveDisabled+" type='radio' name='"+approvedStatusName+"' value='0' checked/><span>No</span></div>":"<div class='approve-input-yes'><input "+approveDisabled+" type='radio' name='"+approvedStatusName+"' value='1' /><span>Yes</span></div><div class='approve-input-no'><input "+approveDisabled+" type='radio' name='"+approvedStatusName+"' value='0'/><span>No</span></div>")
	    )
	        .append($j('<td>')
	        .append((canModify!=null && canModify=="true")?("<a href='javascript:void(0);' class='edit-investment'>Edit</a>"):("<a href='javascript:void(0);' class='edit-investment-disabled'>Edit</a>"))
	    )
	        .append($j('<td>')
	        .append((canModify!=null && canModify=="true")?("<a href='javascript:void(0);' class='delete-investment'>Delete</a>"):("<a href='javascript:void(0);' class='delete-investment-disabled'>Delete</a>"))
	    )
	    );
	}

    $j.restructure($j("#"+row_id));
    return true;
}

function getApprovedStatusNameByIndex()
{
	return 'approvedFundStatus-' + $j("input[name^=approvedFundStatus]").length;
}
function generateRowID(data)
{
    var prefix = "ivt_row"
    var pageType = $j("#pageType").val();
    var investmentType = $j("#add-investment-popup input:radio[name=investmentType]:checked");
    var type = (pageType == 'pib' && data != undefined && data != null && data.investmentType)?data.investmentType:$j(investmentType).val();
    if(type==undefined || type==null)
        return prefix;
    if(type==1)
    {
        prefix = prefix +  "_"	+ type;
    }

    if(type==2)
    {
        var regionType = $j("#add-investment-popup #region");
        var region = (pageType == 'pib' && data != undefined && data != null && data.regionType)?data.regionType:$j(regionType).val();
        if(region>0)
        {
            prefix = prefix +  "_" +type +	"_" + region;
        }
    }
    if(type==3)
    {
        var areaType = $j("#add-investment-popup #area");
        var area = (pageType == 'pib' && data != undefined && data != null && data.areaType)?data.areaType:$j(areaType).val();
        if(area>0)
            prefix = prefix +  "_" +type +	"_" + area;
    }
    if(type==4)
    {
        var fieldworkType = $j("#add-investment-popup #fieldwork");
        var fieldwork = (pageType == 'pib' && data != undefined && data != null && data.fieldworkType)?data.fieldworkType:$j(fieldworkType).val();
        if(fieldwork>0)
            prefix = prefix +  "_" +type +	"_" + fieldwork;

        var fundingType = $j("#add-investment-popup #funding");
        var funding = (pageType == 'pib' && data != undefined && data != null && data.fundingType)?data.fundingType:$j(fundingType).val();
        if(funding>0)
            prefix = prefix +  "_"+ type +	"_" + funding;
    }
    return prefix;

}

function generateRowIDPIT(data)
{
    var prefix = "ivt_row"
    var pageType = $j("#pageType").val();
    var investmentType = $j("#add-investment-popup input:radio[name=investmentType]:checked");
    var type = (data != undefined && data != null && data.investmentType)?data.investmentType:$j(investmentType).val();
    if(type==undefined || type==null)
        return prefix;
    if(type==1)
    {
        prefix = prefix +  "_"	+ type;
    }

    if(type==2)
    {
        var regionType = $j("#add-investment-popup #region");
        var region = ( data != undefined && data != null && data.regionType)?data.regionType:$j(regionType).val();
        if(region>0)
        {
            prefix = prefix +  "_" +type +	"_" + region;
        }
    }
    if(type==3)
    {
        var areaType = $j("#add-investment-popup #area");
        var area = (data != undefined && data != null && data.areaType)?data.areaType:$j(areaType).val();
        if(area>0)
            prefix = prefix +  "_" +type +	"_" + area;
    }
    if(type==4)
    {
        var fieldworkType = $j("#add-investment-popup #fieldwork");
        var fieldwork = (data != undefined && data != null && data.fieldworkType)?data.fieldworkType:$j(fieldworkType).val();
        if(fieldwork>0)
            prefix = prefix +  "_" +type +	"_" + fieldwork;

        var fundingType = $j("#add-investment-popup #funding");
        var funding = ( data != undefined && data != null && data.fundingType)?data.fundingType:$j(fundingType).val();
        if(funding>0)
            prefix = prefix +  "_"+ type +	"_" + funding;
    }
    return prefix;

}
function getInvestmentType(data)
{
    var pageType = $j("#pageType").val();
    var type = (pageType == 'pib' && data != undefined && data != null && data.investmentType)?data.investmentType:$j('#add-investment-popup input:radio[name=investmentType]:checked').val();
    if(type!=undefined && type!=null)
    {
        if(type==1)
        {
            return "Global";
        }
        else if(type==2)
        {
            return (pageType == 'pib' && data != undefined && data != null && data.regionTypeName)?data.regionTypeName:$j("#add-investment-popup #region").find(":selected").text();
        }
        else if(type==3)
        {
            return (pageType == 'pib' && data != undefined && data != null && data.areaTypeName)?data.areaTypeName:$j("#add-investment-popup #area").find(":selected").text();
        }
    }
    return "";
}

function getFieldwork()
{
    var type = $j('#add-investment-popup input:radio[name=investmentType]:checked').val();
    if(type!=undefined && type!=null && type==4)
    {
        return $j("#add-investment-popup #fieldwork").find(":selected").text();
    }
    return "";
}

function getFunding()
{
    var type = $j('#add-investment-popup input:radio[name=investmentType]:checked').val();
    if(type!=undefined && type!=null && type==4)
    {
        return $j("#add-investment-popup #funding").find(":selected").text();
    }
    return "";
}

function getProjectContact()
{
    var html = $j("#projectContact").parent().find("span").html();
    var $html = $j('<dummy />').append(html);
    var $em = $html.find("em");
    $em.remove();
    return $html.text();
}

function getSPIContact()
{
    var html = $j("#spiContact").parent().find("span").html();
    var $html = $j('<dummy />').append(html);
    var $em = $html.find("em");
    $em.remove();
    return $html.text();
}

function getSPICost()
{
    return $j("#add-investment-popup input[name=initialCost]").val();
}

function getSPICostCurrency()
{
    if($j("#add-investment-popup #initialCostCurrency").find(":selected").val()>0)
        return $j("#add-investment-popup #initialCostCurrency").find(":selected").text();
}

function openAddInvestmentDetails()
{
    processInvestmentFields();
    resetInvestmentField();
    investmentPopup.show();
}

function openAddInvestmentDetailsPIT()
{
    processInvestmentFieldsPIT();
    resetInvestmentField();
    investmentPopup.show();
}

function validateAddInvestmentLink()
{
//    var size = $j('select#endMarkets option').length;
//    if(size > 0)
//    {
//        $j(".project_addfunding_btn").removeAttr("disabled", "disabled");
//    }
//    else
//    {
//        $j(".project_addfunding_btn").attr( "disabled", "disabled" );
//    }
    $j(".project_addfunding_btn").removeAttr( "disabled", "disabled" );
}

function validateAddMarketsLink()
{
    var size = $j('select#markets option').length;
    if(size > 0)
    {
        
        //$j(".project_addfunding_btn").removeAttr("disabled", "disabled");
        
        $j("#markets > option").each(function(index) {
      
		    var marketValue = $j(this).val();
		    if(marketValue.indexOf("A")!=-1)
		    {
		       //$j(".project_addfunding_btn").removeAttr("disabled", "disabled");
		    }    
		
    	});
        
    }
    else
    {
       // $j(".project_addfunding_btn").attr( "disabled", "disabled" );
    }
}

function resetContactField(value, name)
{
    var $div = $j("#popup-contact-container");
    $div.html("");
    if(value>0) {
//        $div.append("<input type='hidden' name='projectContact' value='"+value+"'>");
        $div.append("<input type='text' tabindex='1' name='projectContact' id='projectContact' value='"+name+"' class='j-user-autocomplete j-ui-elem' autocomplete='off' />");
    } else {
        $div.append("<input type='text' tabindex='1' name='projectContact' id='projectContact' value='' class='j-user-autocomplete j-ui-elem' autocomplete='off' />");
    }

    initializeUserPicker({$input:$j("#projectContact"),name:'projectContact',defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true}});
    if(value > 0) {
        $j("#popup-contact-container input[name=projectContact]").val(value);
    }
}

function resetSPIField(value, name)
{
    var $div = $j("#popup-spi-container");
    $div.html("");
    if(value>0) {
//        $div.append("<input type='hidden' name='spiContact' value='"+value+"'>");
        $div.append("<input type='text' tabindex='1' name='spiContact' id='spiContact' value='"+name+"' class='j-user-autocomplete j-ui-elem' srole='1' autocomplete='off' />");
    } else {
        $div.append("<input type='text' tabindex='1' name='spiContact' id='spiContact' value='' class='j-user-autocomplete j-ui-elem' srole='1' autocomplete='off' />");
    }

    initializeUserPicker({$input:$j("#popup-spi-container #spiContact"),name:'spiContact',defaultFilters:{'role':1,'roleEnabled':false}});
    if(value > 0) {
        $j("#popup-spi-container input[name=spiContact]").val(value);
    }
}

function resetInvestmentField()
{
    $j( "#add-investment-popup .jive-error-message" ).each(function( index ) {
        $j(this).hide();
    });

    $j("#add-investment-popup input[name=investmentID]").val(0);
    $j("#add-investment-popup input[name=investmentType]").attr("checked", false);
    $j("#add-investment-popup #editMode").val("false");
    $j("#add-investment-popup #region option:first").attr('selected','selected');
    $j("#add-investment-popup #area option:first").attr('selected','selected');
    $j("#add-investment-popup #fieldwork option:first").attr('selected','selected');
    $j("#add-investment-popup #funding option:first").attr('selected','selected');
    resetContactField('', -1);
    resetSPIField('', -1);
    $j("#add-investment-popup #spi-contact-container").hide();
    $j("#add-investment-popup input[name='initialCost']").val("");
    $j("#add-investment-popup #initialCostCurrency").val(defaultCurrency);
    //$j("#add-investment-popup #initialCostCurrency option:first").attr('selected','selected');
    resetInvestmentDropdowns();
}

function validateInvestmentForm()
{
    $j( "#add-investment-popup .jive-error-message" ).each(function( index ) {
        if(!$j(this).hasClass('numeric-error'))
        {
            $j(this).hide();
        }
    });

    var type = $j('input[name=investmentType]:checked', '#add-investment-popup').val();
    if(type == undefined || type < 0) {
        $j("#error-investmentType").show();
        return false;
    }

    if(type == 2) {
        var region = $j("#region").val();
        if(region == undefined || region < 0)
        {
            $j("#error-region").css("display","block");
            return false;
        }
    } else if(type == 3) {
        var area = $j("#area").val();
        if(area == undefined || area < 0)
        {
            $j("#error-area").css("display","block");
            return false;
        }
    } else if(type==4) {
        var fieldwork = $j("#fieldwork").val();
        if(fieldwork==undefined || fieldwork<0)
        {
            $j("#error-fieldwork").show();
            return false;
        }

        var funding = $j("#funding").val();
        if(funding==undefined || funding<0)
        {
            $j("#error-funding").show();
            return false;
        }
    }

    /*var contact = $j("input[name=projectContact]").val();
     if(contact != null && $j.trim(contact)=="")
     {
     $j("#error-contact").show();
     return false;
     }

     var spi = $j("input[name=spiContact]").val();
     if(spi != null && $j.trim(spi)=="")
     {
     $j("#error-spi").show();
     return false;
     }*/

    var initialCost = $j("input[name=initialCost]").val();
    if(initialCost != null && $j.trim(initialCost)=="")
    {
        $j("#numeric-error-initialCost").text("Please enter initial cost");
        $j("#numeric-error-initialCost").show();
        return false;
    }

    if($j("#numeric-error-initialCost").is(":visible"))
    {
        return false;
    }

    var initialCostCurrency = $j("#initialCostCurrency").val();
    if(initialCostCurrency<0)
    {
        $j("#error-currency").show();
        return false;
    }

    return true;
}

function appendInvestmentFieldstoForm()
{
    
    $j('tr[id^="ivt_row_"]').each(function(idx) {
        var rowid = $j(this).attr("id");
        var type= -1;
        var typeID = -1;
        var fwmarket = -1;
        var fndmarket = -1;
        if(rowid !=undefined && rowid!=null) {
            var prefix = "ivt_row_"
            var id = rowid.replace(prefix,"");
            if(id.indexOf('_') != -1) {
                var $array = id.split('_');
				
                if($array.length == 2) {
                    type = $array[0];
                    if(type == 2) {
                        typeID = $array[1];
                    }
                    else if(type == 3) {
                        typeID = $array[1];
                    }
                }
                else if($array.length == 4) {				
                    type = $array[0];
                    fwmarket = $array[1];
                    fndmarket = $array[3];
					console.log("fwmarket = "+fwmarket);
                }
            }
            else {
                //Global region
                type = 1;
            }



            var invId = $j($j(this).find('td')[0]).find("input[name=investmentID]").val();
            $j('<input>').attr({
                type: 'hidden',
                id: 'investmentID['+idx+']',
                name: 'investmentID['+idx+']',
                value: invId
            }).appendTo('#append-investment-div');

            $j('<input>').attr({
                type: 'hidden',
                id: 'investmentType['+idx+']',
                name: 'investmentType['+idx+']',
                value: type
            }).appendTo('#append-investment-div');

            $j('<input>').attr({
                type: 'hidden',
                id: 'investmentTypeID['+idx+']',
                name: 'investmentTypeID['+idx+']',
                value: typeID
            }).appendTo('#append-investment-div');

            $j('<input>').attr({
                type: 'hidden',
                id: 'fieldworkMarketID['+idx+']',
                name: 'fieldworkMarketID['+idx+']',
                value: fwmarket
            }).appendTo('#append-investment-div');

            $j('<input>').attr({
                type: 'hidden',
                id: 'fundingMarketID['+idx+']',
                name: 'fundingMarketID['+idx+']',
                value: fndmarket
            }).appendTo('#append-investment-div');

			
            /*Check if investment type is endmarket(4) level and project contact or spi contact field is empty */			
			console.log("typeID = "+ type);
			
			//Find Project and SPI Contact ID in row
			var projectContact = $j(this).find('input:hidden[name=contact-id]').val();
			var spiContact = $j(this).find('input:hidden[name=spi-id]').val();
			
			if(type==4)
			{
				console.log("investment type is endmarket. typeID= " + type);				
				var skip = false;				
				console.log("Initial contact values: projectContact= " + projectContact + ", spiContact= " + spiContact);
				if(projectContact!='' && spiContact!='')
				{
					skip = true;
				}
				
				/*Swap values */				
				if(projectContact=='' && spiContact!='')
				{			  
					projectContact = spiContact;					
					skip = true;					
				}				
				if(spiContact=='' && projectContact!='')
				{
					spiContact = projectContact;				
					skip = true;
				}			
				
				if(skip)
					console.log("Swapped the project contact and spi contact values.Setting both values to = " + projectContact);
					
				//check for contact field values in global market investment
				if(!skip)
				{				
					var globalContact = $j('tr[id="ivt_row_1"]').find('input:hidden[name=contact-id]').val();
					console.log("Checking if global investment is added or not: globalContact= " + globalContact);
					if(globalContact!=undefined && globalContact!="")
					{
						console.log("globalContact is not empty = " + globalContact);
						projectContact = globalContact;
						spiContact = globalContact;
						skip = true;
					}
				}
				
				//check for contact field values in regional investment added if this endmarket has corresponding region investment(its above market) added
				if(!skip)
				{
					
					console.log("fwmarket = "+fwmarket);
					var regionID = endMarketRegionMap[fwmarket];
					console.log("Value from MAP: regionID = "+regionID);
					var regionalContact = getAboveMarketProjectContact(regionID, '2');
					console.log("Checking if regional investment is added or not: regionalContact= " + regionalContact);
					if(regionalContact!=undefined && regionalContact!="")
					{
						console.log("regionalContact is not empty =  " + regionalContact);
						projectContact = regionalContact;
						spiContact = regionalContact;
						skip = true;
					}
				}
				
				//check for contact field values in area investment added if this endmarket has corresponding area investment(its above market) added
				if(!skip)
				{
					var areaID = 1;
					console.log("fwmarket = "+fwmarket);
					var areaID = endMarketAreaMap[fwmarket];
					console.log("Value from MAP: areaID = "+areaID);
					var areaContact = getAboveMarketProjectContact(areaID, '3');
					console.log("Checking if area investment is added or not: areaContact= " + areaContact);
					if(areaContact!=undefined && areaContact!="")
					{
						console.log("areaContact is not empty =  " + areaContact);
						projectContact = areaContact;
						spiContact = areaContact;
						skip = true;
					}
				}
				
		// In case no contact is found in end-market as well as above market investment details, then project owner will become spi contact and project contact
			if(!skip)
			{					
				projectContact = $j("input[name=projectOwner]").val();
				spiContact = projectContact;
				console.log("All contacts in investment are empty. Now setting it from project owner field " + projectContact);
			}			
			}
			else
			{				
				if(projectContact=='')
					projectContact = $j("input[name=projectOwner]").val();
			}
			
		/** Setting up form hidden fields related to investment contacts, cost **/
			$j('<input>').attr({
				type: 'hidden',
				id: 'projectContact['+idx+']',
				name: 'projectContact['+idx+']',
				value: projectContact
			}).appendTo('#append-investment-div');
			
			$j('<input>').attr({
				type: 'hidden',
				id: 'spiContact['+idx+']',
				name: 'spiContact['+idx+']',
				value: spiContact
			}).appendTo('#append-investment-div');

			//Find Estimated Cost in row
			var cost = $j(this).find('.cost-col').html();
			$j('<input>').attr({
				type: 'hidden',
				id: 'initialCost['+idx+']',
				name: 'initialCost['+idx+']',
				value: cost
			}).appendTo('#append-investment-div');

			//Find Estimated Cost Currency in row
			var currency = $j(this).find('input:hidden[name=currency]').val();
			$j('<input>').attr({
				type: 'hidden',
				id: 'initialCostCurrency['+idx+']',
				name: 'initialCostCurrency['+idx+']',
				value: currency
			}).appendTo('#append-investment-div');

			//Find Approved Checkbox value in row
			
			var approvedStatus;
			if($j(this).find('input[name^=approvedFundStatus]').is(":checked"))
			{
				approvedStatus = $j(this).find('input[name^=approvedFundStatus]:checked').val();
			}		
			$j('<input>').attr({
				type: 'hidden',
				id: 'approvalStatus['+idx+']',
				name: 'approvalStatus['+idx+']',
				value: approvedStatus
			}).appendTo('#append-investment-div');
			
			$j('<input>').attr({
				type: 'hidden',
				id: 'approved['+idx+']',
				name: 'approved['+idx+']',
				value: (approvedStatus==null)?0:1
			}).appendTo('#append-investment-div');
			
			
        }
		
    });
}

$j.restructure = function($row)
{
    var gHeaderClass= 'global-row-header';
    var cHeaderClass= 'country-row-header';
    var gClass= 'global-row';
    var cClass= 'country-row';
    var lastGlobalRow;
    var lastCountryRow;
    var pageType = $j("#pageType").val();
    var investmentDetailsRow = (pageType == 'pib')?$j("#pitWindow #investment-details tbody tr"):$j("#investment-details tbody tr");
    $j(investmentDetailsRow).each(function(index) {
        if($j(this).hasClass(gClass))
        {
            if($row.attr("id")!=$j(this).attr("id"))
                lastGlobalRow = $j(this);
        }
        else if($j(this).hasClass(cClass))
        {
            if($row.attr("id")!=$j(this).attr("id"))
                lastCountryRow = $j(this);
        }
    });

    if($row.hasClass(gClass))
    {
        if($j("."+gHeaderClass).length==0)
        {
            var rowFirst = (pageType == 'pib')?$j('#pitWindow table[id=investment-details] > tbody > tr:first'):$j('table[id=investment-details] > tbody > tr:first');
            $j(rowFirst).before($j("<tr class='"+gHeaderClass+"'>")
                .append($j('<td>')
                .append("Above Market"))
                .append($j('<td>'))
                .append($j('<td>'))
                .append($j('<td>'))
                .append($j('<td>'))
                .append($j('<td>'))
                .append($j('<td>'))
                .append($j('<td>'))
                .append($j('<td>'))
                .append($j('<td>')));
        }

    }
    else if($row.hasClass(cClass))
    {
        if($j("."+cHeaderClass).length==0)
        {
            $row.before($j("<tr class='"+cHeaderClass+"'>")
                .append($j('<td>')
                .append("Country"))
                .append($j('<td>'))
                .append($j('<td>'))
                .append($j('<td>'))
                .append($j('<td>'))
                .append($j('<td>'))
                .append($j('<td>'))
                .append($j('<td>'))
                .append($j('<td>'))
                .append($j('<td>')));
        }
    }

    if(lastGlobalRow==null)
    {
        lastGlobalRow = $j("."+gHeaderClass);
    }

    if(lastCountryRow==null)
    {
        lastCountryRow = $j("."+cHeaderClass);
    }

    if($row.attr("id")!=lastGlobalRow.attr("id") && $row.hasClass(gClass))
    {
        lastGlobalRow.after($row);
    }
    else if($row.attr("id")!=lastCountryRow.attr("id") && $row.hasClass(cClass))
    {
        lastCountryRow.after($row);
    }

    $j.paintGrid();
}

$j.paintGrid = function()
{
    var gHeaderClass= 'global-row-header';
    var cHeaderClass= 'country-row-header';
    var gClass= 'global-row';
    var cClass= 'country-row';
    var odd_row = true;
    var pageType = $j("#pageType").val();
    $j(".investment-details-table tr.global-row").each(function(){
        if(!$j(this).hasClass("global-row-header") && !$j(this).prev().hasClass("global-row-header")) {
            var prevType = Number($j(this).prev().attr("id").replace(/ivt_row_(\d+)(_\d+)*/,"$1"));
            var currType = Number($j(this).attr("id").replace(/ivt_row_(\d+)(_\d+)*/,"$1"));
            if(!isNaN(prevType) && !isNaN(currType) && currType < prevType) {
                $j($j(this)).insertBefore($j(this).prev());
            }
        }
    });

    var investmentDetailsRow = (pageType == 'pib')?$j("#pitWindow #investment-details tbody tr"):$j("#investment-details tbody tr");
    $j(investmentDetailsRow).each(function(index) {
        if($j(this).hasClass(gHeaderClass) || $j(this).hasClass(cHeaderClass) || $j(this).hasClass(gClass) || $j(this).hasClass(cClass))
        {

            if($j(this).hasClass('paint-row'))
                $j(this).removeClass('paint-row');

            if(odd_row)
            {
                $j(this).addClass('paint-row');
            }
            if(odd_row)
                odd_row = false;
            else
                odd_row = true;
        }
    });


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

/**
 function checkInvestmentGrid()
 {
 var options = [];
 $j("#endMarkets > option").each(function(index) {
 options[index] = $j(this).val();
 });
 console.log("options " + options);
 $j("#investment-details tbody tr").each(function(i) {
 var id = $j(this).attr('id');
 console.log("id " + id);
 if(id!=null && id.indexOf('_')!=-1)
 {
 if(id.split('_').length==6)
 {
 var fieldworkid = id.split('_')[3];
 console.log("fieldworkid " + fieldworkid);
 if(options.length>0)
 {
 if($j.inArray(fieldworkid, options)<0)
 {
 console.log(fieldworkid + " fieldworkid not in Array " + options);
 alert("Please remove corresponding entries from investment grid");
 }
 }
 else
 {
 alert("Please remove corresponding entries from investment grid");
 }
 }
 }
 });
 }
 **/
function checkInvestmentGrid(array)
{
    var move = true;
    var investments = [];
    var count=0;
    $j("#investment-details tbody tr").each(function(index) {
        var id = $j(this).attr('id');
        if(id!=null && id.indexOf('_')!=-1)
        {
            if(id.split('_').length==6)
            {
                investments[count++] = id.split('_')[3];
            }
        }
    });

    $j.each(array, function( index, element ) {
        if($j.inArray(element.value, investments)>=0)
        {
            move = false;
            return;
        }
    });

    return move;
}
function checkInvestmentGridPIT(array)
{
    var move = true;
    var investments = [];
    var count=0;
    $j("#investment-details tbody tr").each(function(index) {
        var id = $j(this).attr('id');
        if(id!=null && id.indexOf('_')!=-1)
        {
            if(id.split('_').length==6)
            {
                investments[count++] = id.split('_')[3];
            }
        }
    });

    $j.each(array, function( index, element ) {
        var endMarketValue = element.value.replace("A","");
        if($j.inArray(endMarketValue, investments)>=0)
        {
            move = false;
            return;
        }
    });

    return move;
}

function  getAboveMarketProjectContact(typeID, type){
	if(typeID==undefined)
		return '';
	console.log("ROW ID= " + 'ivt_row_'+type+'_'+typeID);
	var $investmentrow = $j('tr[id="ivt_row_'+type+'_'+typeID+'"]');				
	if($investmentrow!=undefined && $investmentrow!=null)
	{
		var investmentrowContact = $investmentrow.find('input:hidden[name=contact-id]').val();
		if(investmentrowContact!=undefined && investmentrowContact!='' )
		{
			return investmentrowContact;			
		}
	}
	return '';
}

function showInvestmentDetailsPIT(data) {

    /*Remove empty row message when first entry is saved into it.*/
    var pageType = $j("#pageType").val();

    var $emptyRow = (pageType == 'pib')?$j("#pitWindow .investment-details-table .no-items"):$j(".investment-details-table .no-items");
    if($emptyRow.length > 0 )
    {
        $emptyRow.remove();
    }

    /* Get values from popup */
    var typeName = getInvestmentTypePIT(data);
    var fieldwork = (data != undefined && data != null && data.fieldwork)?data.fieldwork:getFieldwork();
    var funding = (data != undefined && data != null && data.funding)?data.funding:getFunding();
    var projectContactID = (data != undefined && data != null && data.projectContactID)?data.projectContactID:$j("#add-investment-popup input[name=projectContact]").val();
    var projectContactName = (data != undefined && data != null && data.projectContactName)?data.projectContactName:$j("#add-investment-popup input[id=projectContact]").val();
    var spiContactID = (data != undefined && data != null && data.spiContactID)?data.spiContactID:$j("#add-investment-popup input[name=spiContact]").val();
    var spiContactName = (data != undefined && data != null && data.spiContactName)?data.spiContactName:$j("#add-investment-popup input[id=spiContact]").val();
    var spiCostCurrency = (data != undefined && data != null && data.currencyName)?data.currencyName:getSPICostCurrency();
    var currency = (data != undefined && data != null && data.currency)?data.currency:$j("#add-investment-popup #initialCostCurrency").val();
    var cost = (data != undefined && data != null && data.cost)?data.cost:getSPICost();
    var idChanged = false;
	
	
    /*Generate new row id and row class*/
    var row_id = generateRowIDPIT(data);
	var approvalStatus = (data != undefined)?data.approvalStatus:null;
	
    var investmentID = (data != undefined && data != null && data.investmentID)?data.investmentID:$j("#add-investment-popup #investmentID").val();

    var editRowID = (data != undefined && data != null && data.editRowID)?data.editRowID:$j("#add-investment-popup #editRowID").val();
    var editMode = (data != undefined && data != null && data.editMode != null)?data.editMode:$j("#add-investment-popup #editMode").val();
    var approved = (data != undefined && data != null && data.approved != null)?data.approved:$j("#add-investment-popup #approved").val();
	
	/*Default alue is set to true for PIT page. And for MM PIB value value will always come in the form of true or false but never null.*/
	var canModify = (pageType == 'pib' && data != undefined && data != null && data.canModify)?data.canModify:"true";
	
	var isAdminUser = (pageType == 'pib' && data != undefined && data != null && data.isAdminUser)?data.isAdminUser:"false";
	
	var canView = (pageType == 'pib' && data != undefined && data != null && data.canView)?data.canView:"false";
	if(pageType !='pib')
	{
		canView = "true";
	}
	
	
	var isBudgetApprover = false;
	
	if(userID!=null && projectContactID==userID)
	{
		isBudgetApprover = true;
	}
	else if(userID!=null && spiContactID==userID)
	{
		isBudgetApprover = true;
	}
	else if(isAdminUser!=null && isAdminUser=="true")
	{
		isBudgetApprover = true;
	}
	else
	{
		isBudgetApprover = false;
	}
	
    /**Check if row id will be changed*/
    if(row_id != editRowID)
        idChanged = true;

    /**Check if row if entry is above market or country level**/
    var $typeID = (data != undefined && data != null && data.investmentType)?data.investmentType:$j('input:radio[name=investmentType]:checked').val();
    var class_level = "global-row";
    var rowExits = false;
    var reachedMaxLimit = false;
    var message = "Already added";
    var rowIdArr = row_id.split("_");
    if($typeID == 4) {
        class_level = "country-row";
        var country_rows_count = $j(".country-row").length;
        if(country_rows_count != null && country_rows_count >= 10) {
            reachedMaxLimit = true;
            message = "Investment cannot be added. Maximum limit of 10 countries is reached.";
        } else {
            if(rowIdArr != null && rowIdArr.length == 6) {
                $j(".investment-details-table tr.country-row").each(function(){
                    var currRowId = $j(this).attr("id");
                    if(editMode == "false"
                        || (editMode == "true" && currRowId != editRowID)) {
                        var currRowIdArr = currRowId.split("_");
                        if(currRowIdArr.length == 6
                            && currRowIdArr[3] == rowIdArr[3]) {
                            rowExits = true;
                            message = "'"+fieldwork+"' country investment already added."
                            return;
                        }
                    }
                });
            }
        }
    }  else if(editMode == "false") {
        $j(".investment-details-table tr.global-row").each(function(){
            var currRowIdArr = $j(this).attr("id").split("_");		
				
			var regionType = $j("#add-investment-popup #region");
			var region = (data != undefined && data != null && data.regionType)?data.regionType:$j(regionType).val();			
					 
            if(currRowIdArr[2] == $typeID && currRowIdArr[3]==region) {
                rowExits = true;
                if($typeID == 1) {
                    message = "Global investment already added."
                } else if($typeID == 2) {					 
						message = "Regional investment already added."
                } else if($typeID == 3) {
                    message = "Area investment already added."
                }
                return;
            }
        });
    }

    if(rowExits || reachedMaxLimit) {
        dialog({
            title:"Message",
            html:message,
            open:function(){
                $j("#add-investment-popup").parent().hide();
            },
            close:function() {
                $j("#add-investment-popup").parent().show();
            }
        });
        return false;
    }
    if(editMode == "true") {
        var $row = $j("#"+editRowID);
        var $td = $row.find('td:first');
        //Investment Column
        $td.html("<span>"+typeName + "</span><input type='hidden' name='investmentID' id='investmentID' value='"+investmentID+"' />");

        //Fieldwork Column
        $td = $td.next();
        $td.text(fieldwork);

        //Funding Column
        $td = $td.next();
        $td.text(funding);

        //Project Contact Column
        $td = $td.next();
        var $html = projectContactName;
        $html = $html + "<input type='hidden' name='contact-id' id='contact-id' value='"+projectContactID+"' />";
        $html = $html + "<div style='display:none'><input type='text' name='contact-name' id='contact-name' value='"+projectContactName+"' /></div>";
        $td.html($html);

        //Project SPI Column
        $td = $td.next();
        var $html = spiContactName;
        $html = $html + "<input type='hidden' name='spi-id' id='spi-id' value='"+spiContactID+"' />";
        $html = $html + "<div style='display:none'><input type='text' name='spi-name' id='spi-name' value='"+spiContactName+"' /></div>";
        $td.html($html);

        //Estimated Cost Column
        $td = $td.next();
        $td.text(cost);

        //Estimated Cost Currency Column
        $td = $td.next();
        $html = spiCostCurrency;
        $html = $html + "<input type='hidden' name='currency' id='currency' value='"+currency+"' />";
        $td.html($html);

        //update row id
        $row.attr("id",row_id);
        $j.restructure($j("#"+row_id));
        return true;
    }

    /*Adding new row with Values */
	var approveDisabled = 'disabled';
	if(isBudgetApprover)
	{
		approveDisabled = '';
	}
	if(canView!=null && canView=="true")
	{
	    var investmentDetails = (pageType == 'pib')?$j("#pitWindow #investment-details"):$j("#investment-details");
		var approvedStatusName = getApprovedStatusNameByIndex();	
	    $j(investmentDetails).find('tbody')
	        .append($j("<tr id="+row_id+" class='"+class_level+"'>")
	        .append($j('<td>')
	        .append("<span>"+typeName+"</span>")
	        .append("<input type='hidden' name='investmentID' id='investmentID' value='"+investmentID+"' />")
	    ).append($j('<td>')
	        .append(fieldwork)
	    ).append($j('<td>')
	        .append(funding)
	    ).append($j("<td class='contact-col'>")
	        .append(projectContactName)
	        .append("<div style='display:none'><input type='text' name='contact-id' id='contact-id' value='"+projectContactID+"' /></div>")
	        .append("<div style='display:none'><input type='text' name='contact-name' id='contact-name' value='"+projectContactName+"' /></div>")
	        
	        
	    ).append($j("<td class='spi-col'>")
	        .append(spiContactName)
	        .append("<div style='display:none'><input type='text' name='spi-id' id='spi-id' value='"+spiContactID+"' /></div>")
	        .append("<div style='display:none'><input type='text' name='spi-name' id='spi-name' value='"+spiContactName+"' /></div>")
	        
	    ).append($j("<td class='cost-col'>")
	        .append(cost)
	    ).append($j("<td class='curr-col'>")
	        .append(spiCostCurrency)
	        .append("<div style='display:none'><input type='text' name='currency' id='currency' value='"+currency+"' /></div>")
	    )
	        .append($j("<td class='approve-fld'>")
	        .append((approvalStatus!=null && approvalStatus == "true")?"<div class='approve-input-yes'><input "+approveDisabled+" type='radio' name='"+approvedStatusName+"' value='1' checked /><span>Yes</span></div><div class='approve-input-no'><input "+approveDisabled+" type='radio' name='"+approvedStatusName+"' value='0'/><span>No</span></div>":(approvalStatus!=null && approvalStatus == "false")?"<div class='approve-input-yes'><input "+approveDisabled+" type='radio' name='"+approvedStatusName+"' value='1'/><span>Yes</span></div><div class='approve-input-no'><input "+approveDisabled+" type='radio' name='"+approvedStatusName+"' value='0' checked/><span>No</span></div>":"<div class='approve-input-yes'><input "+approveDisabled+" type='radio' name='"+approvedStatusName+"' value='1' /><span>Yes</span></div><div class='approve-input-no'><input "+approveDisabled+" type='radio' name='"+approvedStatusName+"' value='0'/><span>No</span></div>")
	    )
	        .append($j('<td>')
	        .append((canModify!=null && canModify=="true")?("<a href='javascript:void(0);' class='edit-investment'>Edit</a>"):("<a href='javascript:void(0);' class='edit-investment-disabled'>Edit</a>"))
	    )
	        .append($j('<td>')
	        .append((canModify!=null && canModify=="true")?("<a href='javascript:void(0);' class='delete-investment'>Delete</a>"):("<a href='javascript:void(0);' class='delete-investment-disabled'>Delete</a>"))
	    )
	    );
	}

    $j.restructure($j("#"+row_id));
    return true;
}

function getInvestmentTypePIT(data)
{
    var pageType = $j("#pageType").val();
    var type = (data != undefined && data != null && data.investmentType)?data.investmentType:$j('#add-investment-popup input:radio[name=investmentType]:checked').val();
    if(type!=undefined && type!=null)
    {
        if(type==1)
        {
            return "Global";
        }
        else if(type==2)
        {
            return (pageType == 'pib' && data != undefined && data != null && data.regionTypeName)?data.regionTypeName:$j("#add-investment-popup #region").find(":selected").text();
        }
        else if(type==3)
        {
            return (pageType == 'pib' && data != undefined && data != null && data.areaTypeName)?data.areaTypeName:$j("#add-investment-popup #area").find(":selected").text();
        }
    }
    return "";
}
 
 $j(document).ready(function() {
	 $j("#project_overview_continue_link").click(function() {
		   
			if(validateSaveProjectOverviewForm())
			 {       
				   
				
				$j("#draft").val('draft');
				/* submitForm();*/
				var researchMethBlock = $j('#research_methodology');
				if(researchMethBlock.css('display') == "none")
				{
					toggleProjectOverview();
					toggleResearchMethodology();
				}
			 }
			else
			{
				
				$j("#jive-error-box").show();
			}
			   
		});
		$j("#project_researchMeth_continue_link").click(function() {
		   
			
			if(validateSaveProjectResearchMethForm())
			 {       
				 
				 $j("#draft").val('draft');
				/* submitForm(); */
				var costDetailsBlock = $j('#cost_details');
				if(costDetailsBlock.css('display') == "none")
				{
					toggleResearchMethodology();
					toggleCostDetails();
				}
			 }
			else
			{
				hideLoader();
				$j("#jive-error-box").show();
			}
			   
		});
		
		$j("#block_header_2").click(function() {
		   
			if(validateSaveProjectOverviewForm())
			{
				toggleResearchMethodology();
			}
			else
			{
				
					//updated  #321
			  $j("#jive-error-box").show();	
			}
			   
		});
		
		$j("#block_header_3").click(function() {
		   
		if(validateSaveProjectOverviewForm())
			{
				  if(validateSaveProjectResearchMethForm())
					{
					    toggleCostDetails();   
          			}
					
					else
			       {
					//updated  #321
				    $j("#jive-error-box").show();
			        }
				}
			else
			{
					
				$j("#jive-error-box").show();
			}
			   
		});
		 $j("#brandSpecificStudy").change(function() {
			
				 
				 var brandSpecificStudy = $j('select[name="brandSpecificStudy"] option:selected').val();
				 // change 536
				var brandSpecificStudyType= $j('select[name="brandSpecificStudyType"] option:selected').val();
				  
				   if(brandSpecificStudyType==1)
				   {
					   $j("#MultibrandTextDiv").show();
					   
				   }
				 
				 if(brandSpecificStudy=="2")
				 {
					$j("#brandSpecificStudyType").show();
					$j("#brandSpecific").hide();
				 }
				 if(brandSpecificStudy=="1")
				 {
					  $j("#brandSpecific").show();
					  $j("#brandSpecificStudyType").hide();
					    $j("#MultibrandTextDiv").hide();  // change 536
					  $j("#MultibrandTextError").hide();
				 }
				 if(brandSpecificStudy=="-1")
				 {
					  $j("#brandSpecific").hide();
					  $j("#brandSpecificStudyType").hide();
					 $j("#MultibrandTextDiv").hide();  // change 536
					  $j("#MultibrandTextError").hide();
				 }
				
		});
		
		 $j("#project_publish_link").click(function() {
			showLoader('Please wait...');
			if(validateSaveProjectOverviewForm() && validateSaveProjectResearchMethForm() && validateCostDetailsForm() )
			{
				$j("#draft").val('publish');
				
				/*This has been done so that the updated total cost is saved in DB when we are creating project*/
				dynamicTotalCost();
				submitForm();
			}
			else
			{
				hideLoader();
				$j("#jive-error-box").show();
			}
		});
		$j("#methWaiverReq").change(function() {
			var methWaiverReq = $j('select[name="methWaiverReq"] option:selected').val();
			 if(methWaiverReq=="1")
			 {
				 $j("#waiverMessage").show();
			 }
			 else{
				 $j("#waiverMessage").hide();
			 }
		});
		var methodologyChangeMessage=false;
		var methodologyChangeLessFrequentMessage=false;
		$j("#methodologyDetails").change(function() {
			
			var methodogyDetails = $j("#methodologyDetails").val();
			
			
			if(methodologyChangeMessage==false && methodogyDetails!=null && $j.trim(methodogyDetails).indexOf(",")>-1)
			{
				 methodologyChangeMessage = true;
				 dialog({
					title: 'Message',
					html: methodologyMultipleMessageText,
					
				});
			}
			
			
            
			var element = $j(this).find('option:selected'); 
			var lessFrequent = element.attr("lessFrequent");
			var methName = $j("#methodologyDetails option:selected" ).text();
			
			$j('#brand').val('').trigger('chosen:updated');	
			$j('select[name="brandSpecificStudyType"]').val('').trigger('chosen:updated');
			
			if(methodologyChangeLessFrequentMessage==false && lessFrequent!=null && lessFrequent!=undefined && $j.trim(lessFrequent)=="yes")
			{
				 methodologyChangeLessFrequentMessage = true;
				 dialog({
					title: 'Message',
					html: '<p>'+methName+' is a quantitative study, conducted across all retaining units in a market.</p><p> This study is not frequently done.Please ensure that you really wish to initiate a project with '+methName+'.</p>',
					
				});
			}

          /*Logic for autopopulating of MethodologType and other fields Starts*/
		 
		  if($j.trim(methodogyDetails).indexOf(",")>-1)
		  {
				$j('#methodologyType').val('').trigger('chosen:updated');
				$j('#brandSpecificStudy').val('').trigger('chosen:updated');
				
				$j("#brandSpecificStudyType").hide();
			    $j("#brandSpecific").hide();	
				 // change  536				
				$j("#MultibrandTextDiv").hide();
				$j("#MultibrandTextError").hide();
		  }
		  else
		  {
			  FieldMappingUtil.getMethodologyTypeByMethodology(parseInt(methodogyDetails), {
					callback: function(result) {
		
					  if(result > -1)
					  {
						  $j('#methodologyType').val(result).trigger('chosen:updated');
					  }
					  else
					  {
						 
						  $j('#methodologyType').val('').trigger('chosen:updated');
						  $j('#brandSpecificStudy').val('').trigger('chosen:updated');
						  $j("#brandSpecificStudyType").hide();
						  $j("#brandSpecific").hide();	
					  }
					},
					async: false,
					timeout: 20000
				});
				var brandSpecific = element.attr("brandSpecific");
				
				if(brandSpecific=="1")
				{
					$j('#brandSpecificStudy').val('1').trigger('chosen:updated');
					 $j("#brandSpecific").show();
					$j("#brandSpecificStudyType").hide();
				}
				else if(brandSpecific=="2")
				{
					$j('#brandSpecificStudy').val('2').trigger('chosen:updated');
					$j("#brandSpecificStudyType").show();
					$j("#brandSpecific").hide();
				}
					// change 536
				$j("#MultibrandTextDiv").hide();
				$j("#MultibrandTextError").hide();
		  }
		
		
		  /*Logic for autopopulating of MethodologType and other fields Ends*/
		  
		});
		
		/*$j("#currency").change(function() {
			
				 var element = $j(this).find('option:selected'); 
				var isGlobal = element.attr("isGlobal");
				
				if(isGlobal!=null && isGlobal!=undefined && $j.trim(isGlobal)=="no")
				{
					 methodologyChangeLessFrequentMessage = true;
					 dialog({
						title: 'Message',
						html: currencyChangeMessageText,
						
					});
				}
				
		});
		*/
		

	});
	
function validateSaveProjectOverviewForm()
{

	var error = false;
    /** Code to be placed before hiding all previous error messages **/
    $j(".jive-error-box").hide();
    $j( ".jive-error-message" ).each(function( index ) {
        if(!$j(this).hasClass('numeric-error'))
        {
            $j(this).hide();
        }
    });

    var name = $j("input[name=name]");
    if(name.pVal() != null && $j.trim(name.pVal())=="")
    {
        name.next().show();
        name.focus();
        error = true;
    }
	
    var description = $j("textarea[name=descriptionText]");
    if(description.val() != null && $j.trim(description.val())=="")
    {
        $j("textarea[name=description]").next().show();
        $j("textarea[name=description]").focus();
		error = true;
    }
	
	var fieldWorkStudy = $j("#fieldWorkStudy");
	
	if(fieldWorkStudy.val() != null && $j.trim(fieldWorkStudy.val())=="-1")
	{
		$j("#fieldWorkStudyError").show();
		error = true;
	}
	
	
	var categoryType = $j("#categoryType");
	if(categoryType.val() != null)
	{
	}
	else
	{
		$j("#categoryTypeError").show();
		error = true;
	}
	

    var endMarkets = $j("#endMarkets");
	
    if(endMarkets.val() != null && $j.trim(endMarkets.val())=="")
    {
        $j("#endMarketError").show();
		error = true;
    }
	else if(endMarkets.val() == null)
    {
        $j("#endMarketError").show();
		error = true;
    }
    var startDate = $j("input[name=startDate]");
    if(startDate.val() != null && $j.trim(startDate.val())=="")
    {
        startDate.parents('div:eq(0)').find("span").show();
        startDate.focus();
     
        error = true;
    }
    else if(!isDateformat(startDate.val()))
    {
        startDate.parents('div:eq(0)').find("span").show();
        startDate.parents('div:eq(0)').find("span").text("Project start date should be in dd/mm/yyyy format");
        startDate.focus();
     
         error = true;
    }


    var endDate = $j("input[name=endDate]");
    if(endDate.val() != null && $j.trim(endDate.val())=="")
    {
        endDate.parents('div:eq(0)').find("span").show();
        endDate.focus();
      
         error = true;
    }
    else if(!isDateformat(endDate.val()))
    {
        endDate.parents('div:eq(0)').find("span").show();
        endDate.parents('div:eq(0)').find("span").text("Project end date should be in dd/mm/yyyy format");
        endDate.focus();
      
        error = true;
    }

    if(!compareDate(startDate.val(), endDate.val()))
    {
        
		/*endDate.parents('div:eq(0)').find("span").show();
        endDate.parents('div:eq(0)').find("span").text("Project Completion cannot be prior to the Project Start");
        endDate.focus();
     */
       error = true;
    }
	
	
	if($j("#globalOutcomeEUShare option:selected").val() != null && $j.trim($j("#globalOutcomeEUShare option:selected").val())=="-1")
	{
		$j("#globalOutcomeEUShareError").show();
		error = true;
	}
	
	
	
	var euMarketConfirmation = $j("#euMarketConfirmation");
	if(euMarketConfirmation.css('display') == "block")
	{
    	if($j("#euMarketConfirmation option:selected").val() != null && $j.trim($j("#euMarketConfirmation option:selected").val())=="-1")
		{
			$j("#euMarketConfirmationError").show();
			error = true;
		}
	}


    $j(".numericfield").each(function(){
        if($j(this).parent().find("span").is(":visible"))
        {
            error = true;
            $j(this).focus();
        }
    });

  
    var projectManagerName = $j("input[name=projectManagerName]");

    if(projectManagerName.val() != null && $j.trim(projectManagerName.val())=="")
    {
        projectManagerName.parent().find("span").show();
       // projectManagerName.focus();
        error = true;
    }

	var refSynchroCode = $j("#refSynchroCode").val();
	if(fieldWorkStudy.val() != null && $j.trim(fieldWorkStudy.val())=="1" && refSynchroCode!=null && refSynchroCode!="" && !$j.isNumeric(refSynchroCode))
	{
		$j("#referenceCodeError").show();
		error = true;
	}
	//amit change
        
      if(!isNumber())
	   {
		 error=true;  
		   
	   }
  //amit
  
    $j('#proposedMethodology option').attr('selected', 'selected');

	if(error)
	{
        return false;
    }
    return true;
}	

function validateSaveProjectResearchMethForm()
{
	var error = false;
    /** Code to be placed before hiding all previous error messages **/
    $j(".jive-error-box").hide();
    $j( ".jive-error-message" ).each(function( index ) {
        if(!$j(this).hasClass('numeric-error'))
        {
            $j(this).hide();
        }
    });

  
    
	var methodologyDetails = $j("#methodologyDetails");
	
	if(methodologyDetails.val() != null && methodologyDetails.val()!="")
	{
	}
	else
	{
		$j("#methodologyDetails").parent().find("span").show();
	     $j("#methodologyDetails").focus();
        error = true;
	}
	var methodologyType = $j('select[name="methodologyType"] option:selected').val();
	
    if(methodologyType < 1)
    {
   		$j("#methodologyType").parent().find("span").show();
	     $j("#methodologyType").focus();
        error = true;
    }
	else if(methodologyType==undefined)
	{
		$j("#methodologyType").parent().find("span").show();
	     $j("#methodologyType").focus();
        error = true;
	}
    
	var methWaiverReq = $j('select[name="methWaiverReq"] option:selected').val();
	
    if(methWaiverReq < 1)
    {
        
		$j("#methWaiverReq").parent().find("span").show();
	     $j("#methWaiverReq").focus();
        error = true;
    }
	
	 
	var brandSpecificStudy = $j('select[name="brandSpecificStudy"] option:selected').val();
	
    if(brandSpecificStudy < 1)
    {
        
		$j("#brandSpecificStudyError").show();
        error = true;
    }
	else if (brandSpecificStudy==undefined)
	{
		$j("#brandSpecificStudyError").show();
        error = true;
	}
	//amit
	
	var brandSpecificStudyType = $j('select[name="brandSpecificStudyType"] option:selected').val();
	
    if(brandSpecificStudy=="2" && (brandSpecificStudyType < 1 || brandSpecificStudyType==undefined))
    {
        
		$j("#brandSpecificStudyTypeError").show();
        error = true;
    }
	var brand = $j('select[name="brand"] option:selected').val();
    
	
	if(brandSpecificStudy=="1" && (brand < 1 || brand==undefined))
    {
        
		$j("#brandError").show();
        error = true;
    }	
   //amit
   
	 // change 536

     var MultibrandText = $j("input[name=multiBrandStudyText]").val();
      
	   
    if(brandSpecificStudyType==1 && MultibrandText=="")
	{
	
	$j("#MultibrandTextError").show();	 
	 error=true;
	
	}

    $j(".numericfield").each(function(){
        if($j(this).parent().find("span").is(":visible"))
        {
            error = true;
            $j(this).focus();
        }
    });

  
	if(error)
	{
        return false;
    }
    return true;
}	


function validateCostDetailsForm()
{
	var error = false;
    /** Code to be placed before hiding all previous error messages **/
    $j(".jive-error-box").hide();
    $j( ".jive-error-message" ).each(function( index ) {
        if(!$j(this).hasClass('numeric-error'))
        {
            $j(this).hide();
        }
    });

	
	var budgetLocation = $j("#budgetLocation");

	if(budgetLocation.val() == null)
	{
		$j("#budgetLocationError").show();
		error = true;
	}
	else if(budgetLocation.val() == "")
	{
		$j("#budgetLocationError").show();
		error = true;
	}
	/*var agency = $j('select[name="agency"] option:selected').val();
	
    if(agency < 1)
    {
        
		$j("#agency").parent().find("span").show();
	     $j("#agency").focus();
        error = true;
    }*/
    	//for dynamic agencies---------------issues...
  /* 
  $j('.expense_row .region-inner').each(function(){
    var agencydynamic  = $j(this).find('select[name="agencies"] option:selected').val();
    if(agencydynamic  < 1)
    {		
     	$j(this).find('.researchAgencydynamicError').show();
		error = true;
    }
	else{
		$j(this).find('.researchAgencydynamicError').hide();
	    }
	});
	
	$j('.expense_row .region-inner').each(function(){
	var agencycosts  = $j(this).find('input[name="agencyCosts"]');
    if(agencycosts.pVal() != null && $j.trim(agencycosts.pVal())=="")
    {		
     	$j(this).find('.agencyCostsError').show();
		error = true;
    }
	else{
		$j(this).find('.agencyCostsError').hide();
	    }
  });*/
	/*var costComponent = $j('select[name="costComponent"] option:selected').val();
	
    if(costComponent < 1)
    {
        
		$j("#costComponentError").show();
		error = true;
    }*/
	// for dynamic cost components 
	/*
	$j('.expense_row .region-inner').each(function(){
     var costComponentdynamic  = parseInt($j(this).find('select[name="costComponents"]').val());
	 //alert(costComponentdynamic);
    if(costComponentdynamic < 1)
    {		
     	$j(this).find('.costComponentdynamicError').show();
		error = true;
    }
	else{
		$j(this).find('.costComponentdynamicError').hide();
	}
	});
	
	
	
	 //  for dynamic currency component message
	$j('.expense_row .region-inner').each(function(){
     var costComponentdynamic  = parseInt($j(this).find('select[name="currencies"]').val());
	 
    if(costComponentdynamic < 1)
    {		
     	$j(this).find('.costCurrencytdynamicError').show();
		error = true;
    }
	else{
		$j(this).find('.costCurrencytdynamicError').hide();
	}
	});
	
	
	*/
	

	
	
	
	
	//amit
	/*var currency = $j('select[name="currency"] option:selected').val();
	
    if(currency < 1)
    {
        
		$j("#costCurrencyError").show();
		error = true;
    }
	
	var agencyCost = $j("input[name=agencyCost]");
    if(agencyCost.pVal() != null && $j.trim(agencyCost.pVal())=="")
    {
        agencyCost.next().show();
        agencyCost.focus();
        error = true;
    }
	*/
    var budgetYear = $j('select[name="budgetYear"] option:selected').val();

    if(budgetYear < 1)
    {
    	$j("#budgetYearError").show();
        error = true;
    }
	
	var endMarketFunding = $j('select[name="endMarketFunding"] option:selected').val();

	
    if(endMarketFunding!=null && endMarketFunding!=undefined && endMarketFunding < 1)
    {
    	$j("#endMarketFundingError").show();
        error = true;
    }
	
		//amit change
	if(endMarketFunding==1)
	{
	 var fundingMarkets = $j("#fundingMarkets");
	   if($j.trim(fundingMarkets.val())=="")
       {
		  

        $j(".fundingMarketsError").show();	
		
		error = true;
       }
		 
	}
	
	/*NEW VALIDATION*/
	 var count=1;
	$j('.expense_row ').each(function(){
    var agencyDynamic  = $j(this).find('select[name="agencies"] option:selected').val();
	var costComponentDynamic  = $j(this).find('select[name="costComponents"] option:selected').val();
	var currencyDynamic  = $j(this).find('select[name="currencies"] option:selected').val();
	var agencyCostDynamic  = $j(this).find('input[name="agencyCosts"]');
		
	
    if((agencyDynamic==undefined || (agencyDynamic  < 1 || $j.trim(agencyDynamic)=="" || agencyDynamic==null)) && (costComponentDynamic==undefined || (costComponentDynamic  < 1 || $j.trim(costComponentDynamic)=="" || costComponentDynamic==null)) && (currencyDynamic==undefined || (currencyDynamic  < 1 || $j.trim(currencyDynamic)=="" || currencyDynamic==null)) && agencyCostDynamic.pVal() != null && agencyCostDynamic.pVal() != undefined &&  $j.trim(agencyCostDynamic.pVal())=="" )
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
		if(agencyCostDynamic.pVal() != null && agencyCostDynamic.pVal() != undefined &&  $j.trim(agencyCostDynamic.pVal())=="")
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
// for synchroCode ,accept only numerics
function isNumber() {
	
	
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
	 

	 
	 