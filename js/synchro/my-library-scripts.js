var xhr;
var searchTimer = null;
var isPopup = false;
function attachSearchBoxListeners() {
    $j("#search-box-form").submit(function(event){
        event.preventDefault();
        var value = $j("#library-search-box").val();
        processSearchBoxInput($j("#library-search-box").val())
    })
   
    $j("#library-search-box").keyup(function(event){
        clearTimeout(searchTimer);
        searchTimer = setTimeout(function(){
            processSearchBoxInput($j("#library-search-box").val());
        }, 300);

    });
}

function processSearchBoxInput(value) {
    if($j.trim(value) != "")
    {
        processPaginationRequest(1, $j.trim(value));
    }
    else
    {
        processPaginationRequest(1, "");
    }

   
    $j("#sortField").val("");
    $j("#ascendingOrder").val("");
}

function showFirstPage() {
    currPage = 1;
    processPaginationRequest(currPage, "");
}



function processPaginationRequest(page, keyword) {
    currPage = page;
    if(xhr != null) {
        xhr.abort();
        xhr = null;
    }
    var sortField = $j("#sortField").val();
    var ascendingOrder = $j("#ascendingOrder").val();
    var url = "/synchro/my-library-pagination.jspa";
    xhr = $j.ajax({
        url : url,
        type: 'POST',
        data: 'sortField='+ sortField + '&ascendingOrder=' + ascendingOrder + '&keyword='+ keyword+"&page="+page+"&isPopup="+isPopup,
        beforeSend: function() {
            $j("#overlay").show();
        },
        complete: function() {
            $j("#overlay").hide();
        },
        success: function(result) {
            xhr = null;
			try
			{
				$j('#project-waiver-table-main').html(result);
			}
			catch(err)
			{
				
			}
            $j('body').css({height: $j(document).height()});
        }
    });
}

$j(document).ready(function(){
    initializeAjaxForm();
});

function initializeAjaxForm() {
    AjaxMultiPartForm.initialize($j("#add-document-form"),onSuccess,onError);
}


function showPopup() {

    $j('#error-message').hide();
    clearErrorMessage();
    if(isPopup) {
        $j("#my-library-popup").hide();
    }
    $j("#add-document-popup").lightbox_me({centered:true,closeEsc:false,overlayCSS:{background: 'black', opacity: .7},
        onClose:function() {
            if(isPopup) {
                $j("#my-library-popup").show();
            }
        }
    });
    $j(".input-validation-error").each(function(idx){
        $j(this).removeClass("input-validation-error");
    });

}
function closePopup() {
    clearErrorMessage();
    clearForm();
    $j("#add-document-popup").trigger('close');
}

function clearForm() {
    $j("#add-document-form").trigger('reset');
}

function onSuccess(response, textStatus, jqXHR) {
    var result = JSON.parse(response);
    if(result != undefined && result != null) {
        var data = result.data;
        if(data != undefined && data != null) {
            if(Boolean(data.success)) {
                showFirstPage();
                closePopup();
            } else {
                handleErrorMessage(data);
            }
        }

    }
}

function onError(data, textStatus, errorThrown) {
    handleErrorMessage(data);
    console.log("Failure");
}
function handleErrorMessage(data) {
    if(data.formInvalid != undefined && Boolean(data.formInvalid)) {
        var focusField = null;
        var msg = "";
        if(data.title != undefined) {
            if(focusField == null) {
                focusField = $j("#add-document-form input[name=title]");
            }
            $j("#add-document-form input[name=title]").addClass("input-validation-error");
            msg += "<li>"+data.title+"</li>";
        }

        if(data.attachFile != undefined) {
            if(focusField == null) {
                focusField = $j("#add-document-form input[name=attachFile]");
            }
            $j("#add-document-form input[name=attachFile]").addClass("input-validation-error");
            msg += "<li>"+data.attachFile+"</li>";
        }
        if(focusField != null) {
            $j(focusField).focus()
        }
        showErrorMessage(msg);
    } else if(data.message != undefined) {
        showErrorMessage(data.message);
    } else {
        showErrorMessage("Unable to add document. Please try again.")
    }
}

function showErrorMessage(msg) {
    var pattern = /^\<li\>(.*)\<\/li\>$/;
    if(msg.match(pattern)) {
        msg = "<ul>"+msg+"</ul>";
    } else {
        msg = "<ul><li>"+msg+"</li></ul>"
    }
    $j('#error-message').show();
    $j('#error-message').html(msg);
}

function clearErrorMessage() {
    $j('#error-message').hide();
    $j('#error-message').html('');
}

function inputChange(target) {
    clearErrorMessage();
    if($j(target).hasClass("input-validation-error") && $j(target).val() != "") {
        $j(target).removeClass("input-validation-error");
    }
}
