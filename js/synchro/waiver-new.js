$j(document).ready(function() {

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
	
$j("#project_publish_link").click(function() {
	if(validateForm())
	{
		dialog({
				title: '',
				html: '<i class="warningErr positionSet"></i><p>Are you sure you want to create a waiver? You will not be able to change these details later.</p>',
				buttons:{
					"Yes":function() {
						showLoader('Please wait...');
						submitForm();
					},
					"No": function() {
						closeDialog();						
					}
				}
			});
			relPos();
		}
		else
		{			
			$j("#jive-error-box").show();
		}		
	});

	$j("#save_waiver_link").click(function() {
		 
	/* if(validateForm())
	{
		
		$j("#approveWaiver").val("");
		submitForm();
		}
		else
		{
                 			
			$j("#jive-error-box").show();
		}
     */
	 $j("#approveWaiver").val("");
		submitForm();
		
	});

	
$j("#add_attach_link").click(function() {
	var form = $j("#form-create");
	form.attr("action", "/synchro/create-waiver!addAttachment.jspa");
	jive.util.securedForm(form).always(function() {
		form.submit();           
	});
});

$j("#project_cancel_link").click(function() {
	
	dialog({
			title: 'Message',
			html: '<i class="warningErr positionSet"></i><p>Are you sure you want to cancel waiver? Your changes will not be saved.</p>',
			buttons:{
				"Yes":function() {
					window.location.href = '/new-synchro/process-waiver-dashboard.jspa';
				},
				"No": function() {
					closeDialog();						
				}
			}
		});
		relPos();	
});



$j("#approve").click(function() {
if(validateApproverComments())
{
	dialog({
            title: 'Message',
            html: '<p>Do you really want to approve this waiver?</p>',
            buttons:{
                "Yes":function() {
					showLoader('Please wait...');
                    var form = $j("#form-create");
					$j("#approveWaiver").val("true");
					jive.util.securedForm(form).always(function() {
						form.submit();           
					});
                },
                "No": function() {
                    closeDialog();
                }
            }
       });
}	
});

$j("#reject").click(function() {
if(validateApproverComments())
{
	dialog({
            title: 'Message',
            html: '<p>Do you really want to reject this waiver?</p>',
            buttons:{
                "Yes":function() {
					showLoader('Please wait...');
                    var form = $j("#form-create");
					console.log("data " + form.serialize());
					$j("#approveWaiver").val("false");
					jive.util.securedForm(form).always(function() {
						form.submit();           
					});
                },
                "No": function() {
                    closeDialog();
                }
            }
       });
}
});

	
$j(".numericfield").focusin(function() {
    $j(this).val($j(this).val().replace(/\,/g, ''));
});

$j(".numericfield").focusout(function() {   
	$j(".numericfield").trigger('change');
});

$j(".numericfield").change(function(event) {
    if($j(this).val() != "")
    {
		$j(this).parent().find("span").each(function(spanIndex) {
				if(!$j(this).hasClass('numeric-error'))
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
            if (!numericFormat($j(this))) {
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
						if($j(this).hasClass('numeric-error'))
						{
							$j(this).text("Please enter numeric value");
							$j(this).show();
						}
						
					});                    
                }                
            }
            else
            {				
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
                $j(this).parent().find("span").each(function(spanIndex) {
						if($j(this).hasClass('numeric-error'))
						{
							$j(this).text("Please enter numeric value");
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
	
/**Attachments Label click Handlers**/
$j("#field-attachment .views-field label").click('click', function (event) {
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
		//if($j(this).val()!=null && $j.trim($j(this).val())!="" && !contains(DEFAULT_VALUES, $j.trim($j(this).val())))
			if($j(this).val()!=null && $j.trim($j(this).val())!="")
		{
			$j(this).height(0);
			var scrollval = $j(this)[0].scrollHeight-10;
			$j(this).height(scrollval);
		}		
	  }	
	  $j(this).elastic();
	  
});


});

function submitForm() {	
	var form = $j("#form-create");	
	$j('#endMarkets option').prop('selected', true);
	jive.util.securedForm(form).always(function() {		
		form.submit();           
	}); 
}

function validateForm()
{
	
	var error = false;	
	/*$j(".jive-error-box").hide();
		$j( ".jive-error-message" ).each(function( index ) {
			if(!$j(this).hasClass('numeric-error'))
			{
				$j(this).hide();
			}
		});	
	$j("#waiver-success-box-approved").hide();
	*/
	
	//Waiver Name
	var name = $j("input[name=name]");	
	if(name.pVal() != null && $j.trim(name.pVal())=="")
	{		
		name.next().show();
		name.focus();
		 error=true; 
		//return false;
	}
	
	//Waiver Summary
	var summary = $j("textarea[name=summaryText]");	
	if(summary.val() != null && $j.trim(summary.val())=="")
	{
		$j("textarea[name=summary]").next().next().show();
		$j("textarea[name=summary]").focus();
		error=true;
	//return false;
	}
	
	//Brand
	var brand = $j("#brand");	
	if(brand.val()==null || brand.val()<0)
	{
		
		//brand.parent().next().show();
		
		//$j("#brandNonBrandErrorMsg").show();
		brand.next().next().show();
		brand.focus();
		  error=true;
		//return false;		
	}
	
	
	
	/*
	//Methodology Type
	var methodologyType = $j("#methodology");	
	if(methodologyType.val()==null || methodologyType.val()<0)
	{
		methodologyType.next().show();
		methodologyType.focus();
		return false;		
	}
	*/
	
	//EndMarkets
	var endMarkets = $j("#endMarkets");
	var endMarketsSize = $j("#endMarkets option").size();
    if(endMarketsSize < 1)
    {
        endMarkets.parent().find("span").show();
		endMarkets.focus();
		 error=true;
		//return false;	
    }
	
	//Pre-Approvals CheckBoxes
	/*var chb_selected = false;
	$j('#preApprovals').each(function() {
		alert("cb");
		if ($j(this).checked) {
			chb_selected = true;			
		}
	});
	
	if(!chb_selected)
	{
		return false;
	}
	
	//Pre-Approval Comment
	var preApprovalComment = $j("textarea[name=preApprovalComment]");	
	if(preApprovalComment.val() != null && $j.trim(preApprovalComment.val())=="")
	{
		preApprovalComment.next().show();
		preApprovalComment.focus();
		return false;
	}
	*/
	
	//Nexus Number
	/*var nexus = $j("input[name^=nexus]");	
	if(nexus.val() != null && $j.trim(nexus.val())=="")
	{	
		nexus.next().text("Please enter nexus number");
		nexus.next().show();
		nexus.focus();
		return false;
	}
	*/
	// Numeric format for Nexus number
	$j(".numericfield").each(function(){
			if($j(this).parent().find("span").is(":visible"))
			{
				error = true;
				$j(this).focus();				
			}
		});
		
		
		
		if ($j('.jive-attach-item').is(":visible") == false)
		{
			$j("#waiverattachmentErr").show();
			error=true;
        }
		else
		{
		    $j("#waiverattachmentErr").hide();
	    }
			
		
		
		
		
	if(error)
		return false;
		
	//Approver
	/*
	var approverID = $j("#approverID");	
	
	if(approverID.val()==null || approverID.val()<0)
	{
		approverID.next().show();
		approverID.focus();
		return false;		
	}
	*/
	$j('#endMarkets option').attr('selected', 'selected');	 
	 
	return true;	
}


function validateApproverComments()
{
     var flag=false;
	if(!validateForm())
		flag=true;
	
	
  /*	$j(".jive-error-box").hide();
		$j( ".jive-error-message" ).each(function( index ) {
			if(!$j(this).hasClass('numeric-error'))
			{
				$j(this).hide();
			}
		});	
	*/
	
	//Waiver Summary
	var approverComment = $j("textarea[name=approverCommentsText]");
	if(approverComment.val() != null && $j.trim(approverComment.val())=="")
	{
		$j("textarea[name=approverComments]").next().next().show();
		$j("textarea[name=approverComments]").focus();
		flag=true;
	}
	
	$j('#endMarkets option').attr('selected', 'selected');	 
	 
	 if(flag)
	 {
		 return false;
	 }
	return true;	
}


function numericFormat(uzip) {
    var numbers = /^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{1,2})?$/;
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
function limitText(limitField, limitCount, limitNum) {

    if(limitField.value) {
        if (limitField.value.length > limitNum) {
            limitField.value = limitField.value.substring(0, limitNum);
        } else {
            limitCount.value = limitNum - limitField.value.length;
        }
    }
}

$j.fn.pVal = function(){
    var $this = $j(this),
        val = $this.eq(0).val();
    if(val == $this.attr('placeholder'))
        return '';
    else
        return val;
}

//Save Waiver Form via AJAX and returns Waiver ID
/*
function save()
{
	$j.ajax({
			type: "POST",
			url: "/synchro/create-waiver!saveWaiverDetails.jspa",
			data: $j("#form-create").serialize(),
			success: function(response) {	
			var result = JSON.parse(response);			
			if(result!=null && result.data!=null)
			{	
				$j('#projectWaiverID').val(result.data);				
				$j('<input>').attr({
				type: 'hidden',
				id: 'attachWaiverID',
				name: 'attachWaiverID',
				value: result.data
			}).appendTo('#field-attachment');			
			}			
			}
			});
}
*/

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
function checkWaiverName()
{
var name = $j("input[name=name]");	
	if(name.pVal() != null && $j.trim(name.pVal())!="")
	{		
		name.next().hide();
		name.focus();
		 error=true; 
		//return false;
	}
	
	
}
	




