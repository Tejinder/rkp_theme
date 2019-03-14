
function destroyRTE(textareaid)
{	
	if(tinyMCE && tinyMCE.editors && tinyMCE.editors[textareaid])
		tinyMCE.editors[textareaid].destroy();
}

function initiateRTE(textareaid, characterLimit, setPlainText, callback)
{	
	
	destroyRTE(textareaid);
	var readonly = 0;
	if($j("#"+textareaid).length>0 && $j("#"+textareaid).is(':disabled'))
	{
		readonly = 1;
	}	
	
	tinymce.init({
        mode : "specific_textareas",
        selector: '#'+textareaid,
        theme: "modern",
		readonly : readonly,
        menubar:false,
		height: 160,
		auto_resize: false,
		style_formats : [
            {title : 'Line height 0px', selector : 'p,div,h1,h2,h3,h4,h5,h6', styles: {lineHeight: '0px'}},
            {title : 'Line height 10px', selector : 'p,div,h1,h2,h3,h4,h5,h6', styles: {lineHeight: '10px'}},
			{title : 'Line height 20px', selector : 'p,div,h1,h2,h3,h4,h5,h6', styles: {lineHeight: '20px'}},
			{title : 'Line height 30px', selector : 'p,div,h1,h2,h3,h4,h5,h6', styles: {lineHeight: '30px'}}

    ],
        plugins: [
            "advlist autolink lists link image charmap print preview hr anchor pagebreak",
            "searchreplace visualblocks visualchars code fullscreen",
            "insertdatetime media nonbreaking save table contextmenu directionality",
            "emoticons template paste textcolor colorpicker textpattern charcount",
			"placeholder"
        ],
        toolbar1: "undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | forecolor backcolor",
//        toolbar2: "print preview media | forecolor backcolor emoticons",
//        toolbar2: "forecolor backcolor",		
        image_advtab: true,
       // contextmenu: "paste | link image inserttable | cell row column deletetable",
      /*  templates: [
            {title: 'Test template 1', content: 'Test 1'},
            {title: 'Test template 2', content: 'Test 2'}
        ] ,
		*/
        charLimit:characterLimit,
	
		setup: function(editor) {
			editor.on('blur', function(e) {			
				$j("#"+editor.id).prev().find('.mce-edit-area').removeAttr("style");
				$j("#"+editor.id).prev().find('.mce-toolbar-grp').hide();
				if(setPlainText){setPlainTextFields(editor);}
				if(callback){compareContent(editor);}
				tinyMCE.triggerSave(true, true);				
			}),		
			editor.on('init', function(e) {				
				$j("#"+editor.id).prev().find('.mce-edit-area').removeAttr("style");
				$j("#"+editor.id).prev().find('.mce-toolbar-grp').hide();
				if(callback){comparePIBProposal();}
			}),
			editor.on('focus', function(e) {
				$j("#"+editor.id).prev().find('.mce-edit-area').attr("style","border-width: 1px 0px 0px;");
				$j("#"+editor.id).prev().find('.mce-toolbar-grp').show();
			}),
			editor.on('load', function(e) {			
		/*	$j("#"+editor.id).prev().find('.mce-edit-area').removeAttr("style");
			$j("#"+editor.id).prev().find('.mce-toolbar-grp').hide();
			if(callback){comparePIBProposal();}*/
			});
            editor.on('change', function(e){
                console.log("Working...");
                 $j("#"+textareaid).val(editor.getContent());
		 t = $j("#"+textareaid).val();
		        
				 if(t == ""){
					// $j('.description-validation').show();
					// $j("#methDeviationError").show();
					 
				 }
				 else{
					   $j("#agencyDeviationError").hide();
					   $j('.description-validation').hide();
					   $j("#methDeviationError").hide();
					   $j("#methWaiverError").hide();
					   $j("#methKantarWaiverError").hide();
					   $j(".textarea-error-message").hide();
					   
					  var approverComment = $j("textarea[name=approverCommentsText]");
	                  if(approverComment.val() != null && $j.trim(approverComment.val())!="")
	                    {
	                     	$j("textarea[name=approverComments]").next().next().hide();
	                     	
	        	
						}
					   
					   
					  
				 }
                $j("#"+textareaid).trigger("tinyMCETextAreaChange");
            });
		}
    });
}


function fitTosize(e)
{
	if(e)
	{
		var id = e.iframeElement.id;
		if(id && id.indexOf('_')!=-1)
		{
			var name = id.split("_")[0];
			if(name && tinymce && tinymce.get(name))
			{	
				if($j("#hidden-textarea-content-div").length<1)
				{
					var domElement ="<div id='hidden-textarea-content-div' style='display:none;'></div>";
					$j("body").append(domElement);
				}
				var dom = $j("#hidden-textarea-content-div");				
				var rteHTML=tinymce.get(name).getContent();		
				var the_height= document.getElementById(id).contentWindow.document.body.offsetHeight ;
				//console.log(name + " content height " + the_height);
				dom.html(rteHTML);
				var rtePlainText = dom.text();
				if(isIEBrowser())
				{
					if(rtePlainText && $j.trim(rtePlainText)!="")
					{					
						if(e.isNotDirty && dom.height()<80)
						{						
							var nonemptyBoxHeight = parseInt(dom.height()) + 70;						
							
						}
						else
						{
							var nonemptyBoxHeight = parseInt(the_height)-20;
						}
						
						$j("#"+id).css("height", nonemptyBoxHeight);					
					}
					else
					{
						var emptyBoxHeight = $j("textarea[name="+name+"]").height();					
						$j("#"+id).css("height", parseInt(emptyBoxHeight)+70);		
					}
				}
				else
				{
					if(rtePlainText && $j.trim(rtePlainText)!="")
					{					
						$j("#"+id).css("height", parseInt(the_height)-20);
					}			
				}
				
			}
		}
	}	
}

function isIEBrowser()
{
  var ua = window.navigator.userAgent;
    var msie = ua.indexOf('MSIE ');
    var trident = ua.indexOf('Trident/');

    if (msie > 0) {
        // IE 10 or older => return version number
        return true;
    }

    if (trident > 0) {
        // IE 11 (or newer) => return version number       
       return true;
    }

    // other browser
    return false;
}
  
function setPlainTextFields(editor)
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
		
		var actionStandardInput = "actionStandard";
		var researchDesignInput  = "researchDesign";			
		var sampleProfileInput = "sampleProfile";
		var stimulusMaterialInput = "stimulusMaterial";
		
			
		if(name!=null && name.indexOf('_')!=-1!=-1 && (name.substring(0, actionStandardInput.length) === actionStandardInput || name.substring(0, researchDesignInput.length) === researchDesignInput || name.substring(0, sampleProfileInput.length) === sampleProfileInput || name.substring(0, stimulusMaterialInput.length) === stimulusMaterialInput))
			{
				var arrayobj = name.split("_");
				var fieldname = arrayobj[0];
				var endmarketid = arrayobj[1];
				
				if(fieldname!="" && endmarketid!=undefined && endmarketid!="")
				{						
					$j("#"+fieldname+ "Text_"+endmarketid).text(rtePlainText);
				}	
				else if(fieldname!="")
				{
					$j("#"+fieldname+ "Text").text(rtePlainText);	
				}

				
			}	
			else if(name!=null && name!="" && $j("#"+name+ "Text").length>0)
			{
				$j("#"+name+ "Text").text(rtePlainText);
			}		
	}	
}