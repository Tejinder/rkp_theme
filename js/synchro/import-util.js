//var importForm = null;
$j(document).ready(function() {
  //  importForm = AjaxMultiPartForm.initialize($j("#import-document-form"),onSuccess, onError);
	$j("#import-pib-link").click(function() {		
		//$j("#attachPIBTemplate").click();	
		showImportPopup();
	});
	
	$j("#importDocConfirmTextIE").click('click', function(e) {
		e.preventDefault;		
		$j("#importDocConfirmIE").click();
	});


	$j("input:file#attachPIBTemplateIE").change(function (){
		  var ext = $j(this).val().split('.').pop().toLowerCase();
			if($j.inArray(ext, ['doc','docx']) == -1) {			
				showErrorDialog('Alert', 'Please select doc/docx file only');
				$j("input:file#attachPIBTemplateIE").val("");
				$j(".ui-dialog").css('z-index', '1008');
				//closeImportPopup();
				return;	
			}
			
		$j("#fileTypeIE").val(ext);
		/*var showDialog =  $j("#importDocConfirmOptIE").val();		
		if(showDialog=="0")
		{
			 dialog({
				title: 'Alert',
				html: "<p>Are you sure you want to import the file? </p><p></p>It will overwrite all existing data (within relevant sections) on PIB<br /><br /><input type='checkbox' id='importDocConfirmIE' name='importDocConfirmIE' onchange='javascript:confirmOptChange();' /><span id='importDocConfirmTextIE'>Do now show this message again</span>",
				buttons:{
					"NO":function() {
						 closeDialog();
					},
					"YES": function() {
						//processImportRequest();
					}
				}
			});
		}
		else
		{
			//processImportRequest();
		}
		*/
	});

});

function confirmOptChange()
{
  var checked = $j("input[id=importDocConfirmIE]:checked").length;
  if (checked == 0) {  
    $j("#importDocConfirmOptIEimportDocConfirmOptIE").val("0");
  } else {  
    $j("#importDocConfirmOptIE").val("1");
  }
}
function processImportRequest()
{
	//$j("#importDocConfirm")
	//showLoader("Importing data from PIB Template. Please wait...");
   // importForm.submit();
	$j("input:file#attachPIBTemplateIE").val("");
}

 function onSuccess(response, textStatus, jqXHR) { 
	var result = JSON.parse(response);
	 if(result != undefined && result != null) {
		var data = result.data;
		if(data != undefined && data != null) {
			if(data.success!=undefined && data.success)
			{
				var fieldMap = data.fieldMap;
				$j.each( fieldMap, function( key, value ) {
					if(!($j("#"+key).attr("disabled")))
					{						
						if(tinymce && tinymce.get(key) && value)
						{
							
							var formattedValue = value.replace(/"/g, '\'').replace(/&gt;/g, '>').replace(/&lt;/g, '<');
							tinymce.get(key).setContent(formattedValue);		
							setPlainText(tinymce.get(key));											
						}						
					}
				});	
				tinyMCE.triggerSave(true, true);
			}
			else
			{
				showErrorDialog('Alert', data.message);				
			}
		}
	 }
	 hideLoader();
	 closeImportPopup();
 }
 
 function setPlainText(editor)
 {
	if(editor)
	{
		if($j("#hidden-textarea-content-div").length<1)
		{
			var domElement ="<div id='hidden-textarea-content-div' style='display:none;'></div>";
			$j("body").append(domElement);
		}
		var dom = $j("#hidden-textarea-content-div");
		var name= editor.id;
		var rteHTML=editor.getContent();		
		dom.html(rteHTML);
		var rtePlainText = dom.text();
		
		if(name!=null && name!="" && $j("#"+name+ "Text").length>0)
		{
			$j("#"+name+ "Text").text(rtePlainText);
		}
	}
 }
 
 function onError(response, textStatus, jqXHR) {
	 var msg = "Error importing PIB document. Please try again";
	 var result = JSON.parse(response);
	 if(result != undefined && result != null) {
	 var data = result.data;
	 if(data != undefined && data != null) {
		msg = data.message;
	 }
	 }
	 hideLoader();
	 closeImportPopup();
	showErrorDialog('Error', msg);
 }
 
 function showLoader(title)
{
	
	$j.loader({
			className:"blue-with-image",
			content: title
		});
}

function hideLoader()
{
	$j("#jquery-loader").remove();
	$j("#jquery-loader-background").remove();
}

function showErrorDialog(title, msg)
{
	dialog({
			title: title,
			 html: '<p>'+msg+'</p>',
			buttons:{
				"OK":function() {
					 closeDialog();
				}
			}
		});				
}



$j(document).ready(function(){
    initializeAjaxForm();
});

function initializeAjaxForm() {
    AjaxMultiPartImportForm.initialize($j("#import-ie-document-form"),onSuccess,onError);
}


function showImportPopup() {
    clearImportForm();
    $j("#import-document-ie-popup").lightbox_me({centered:true,closeEsc:false,overlayCSS:{background: 'black', opacity: .7},
    });    
}
function closeImportPopup() {   
    $j("#import-ie-document-form").trigger('close');
	clearImportForm();	
}

function clearImportForm()
{
	$j("input:file#attachPIBTemplateIE").val("");
}
