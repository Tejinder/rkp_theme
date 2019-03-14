var inviteEmailPopup = null;

$j(document).ready(function() {
//	 inviteEmailPopup = new LIGHT_BOX($("#inviteEmailNotification"),{title:'Invite User to Synchro',
//         onShow:function(){
//             $.event.trigger("inviteUserPopupLoad");
//         },
//         onClose:function() {
//             $.event.trigger("inviteUserPopupClose");
//         }
//     });
	 configureInviteBodyContent();
});


function openMailPopup() {
//    $(".j-modal-close-top").click();
    $j("#inviteEmailNotification").lightbox_me({
        centered:true,
        closeEsc:false,
        showOverlay:false,
        destroyOnClose:true,
        parentLightbox:$j("#invited-users-popup"),
        zIndex:100000001,
        overlayCSS:{background: 'black', opacity: .7}
    });
}

function configureInviteBodyContent()
{
    $j("#inviteSubject").val("Wish you were on Synchro");
    var body = "Hi,\n"+
        "I wish you were available on Synchro. You can send a request form to Synchro Admin for access.\n"+
        "Request form can be downloaded from this link:\n"+
        "$j{jiveURL}/file/download/Synchro_User_Application_Form.xlsx";

    $j("#inviteMessageBodyDiv").val(body);

}




function closeInviteEmailNotification()
{
    $j("#inviteEmailNotification").trigger('close');
    $j("#inviteEmail").val("");
    configureInviteBodyContent();
    $j(".jive-error-message").each(function(index) {
        $j(this).hide();
    });
}

var clickedFor = '';

function sendEmailInvite(senderID, projectID, stageID)
{
    showLoader('Please wait...');
    $j(".jive-error-message").each(function(index) {
        $j(this).hide();
    });

    var recipient = $j("#inviteEmail");
    var subject = $j("#inviteSubject");
    var messageBody = $j("#inviteMessageBodyDiv");

//    if(!validateEmailInvite())
//    {
//        hideLoader();
//        return;
//    }
    console.log($j(recipient).val());
    if(recipient.val() != null && $j.trim(recipient.val()) == "") {
        recipient.next().show();
        recipient.next().text("Please enter email");
        recipient.focus();
        hideLoader();
        return;
    } else {
        /*Validate email via DWR request*/
        InviteUserUtil.validateEmail(recipient.val(), {
            callback: function(result) {
                if(result != "") {
                    recipient.next().show();
                    recipient.next().text(result);
                    recipient.focus();
                    hideLoader();
                    return;
                } else {
                    recipient.next().hide();
                }
                if(subject.val() != null && $j.trim(subject.val()) == "") {
                    subject.next().show();
                    subject.focus();
                    hideLoader();
                    return;
                }
                if($j.trim(messageBody.html()) == "") {
                    messageBody.next().show();
                    messageBody.focus();
                    hideLoader();
                    return;
                }

                processInviteRequest(senderID,projectID, stageID);
            },
            async: true
        });
    }

}

function processInviteRequest(senderID, projectID, stageID)
{
    var recipient = $j("#inviteEmail").val();
    var subject = $j("#inviteSubject").val();
    var messageBody = $j("#inviteMessageBodyDiv").html();
    console.log("messageBody " + messageBody);
    InviteUserUtil.getInviteIdByEmail(recipient, {
        callback: function(result) {
            if(result < 1)
            {
                InviteUserUtil.sendNotification(senderID, recipient, subject, messageBody, projectID, stageID, {
                    callback: function(result) {
                        if(result)
                        {
                            setInviteField(recipient);
                            $j("#inviteEmailNotification").trigger('close');
                            console.log("Invite email sent to user " + recipient);
                        }
                        else
                        {
                            hideLoader();
                            alert("Error sending email. Please try again");
                        }

                    },
                    async: false,
                    timeout: 20000
                });
            }
            else
            {
                var props = {buttons: {"OK": function() {}}};
                dialog(props);
                $j("#dialog-box").html('User is already invited');
                /*InviteUserUtil.sendNotification(senderID, recipient, subject, messageBody, {
                 callback: function(result) {
                 console.log("Invite email sent to user " + recipient);
                 },
                 async: false,
                 timeout: 20000
                 });*/
                hideLoader();
                closeAllPopups();
                $j('input[name='+select_fieldType+']').val(result);
                $j('#'+select_fieldType).val('Stakeholder Requested');
                $j('input[name='+select_fieldType+']').trigger("userUpdated");
            }

        },
        async: false,
        timeout: 20000
    });

}

function sendRemainder(recipient,senderID,projectID, stageID) {
    var subject = $j("#inviteSubject").val();
    var messageBody = $j("#inviteMessageBodyDiv").html();
    $j("#remainder-message").hide();
    InviteUserUtil.sendNotification(senderID, recipient, subject, messageBody, projectID, stageID, {
        callback: function(result) {
            if(result) {
                $j("#remainder-message").html("<p>Reminder sent successfully.</p>")
                $j("#remainder-message").addClass("success");
                $j("#remainder-message").show();
                setTimeout(function(){$j("#remainder-message").hide()},2000);
            }
            else
            {
                $j("#remainder-message").html("<p>Unable to send reminder.</p>")
                $j("#remainder-message").addClass("error");
                $j("#remainder-message").show()
                setTimeout(function(){$j("#remainder-message").hide()},2000);
            }

        },
        async: false,
        timeout: 20000
    });

}
function setReferenceUserID(email) {
    InviteUserUtil.getInviteIdByEmail(email, {
        callback: function(result) {
            if(result < 1) {
                InviteUserUtil.addInvite(email, {
                    callback: function(result) {
                        $j('input[name='+select_fieldType+']').val(result);
                        $j('#'+select_fieldType).val('Stakeholder Requested');
                        $j('input[name='+select_fieldType+']').trigger("userUpdated");
                    },
                    async: false,
                    timeout: 20000
                });
            } else {
                $j('input[name='+select_fieldType+']').val(result);
                $j('#'+select_fieldType).val('Stakeholder Requested');
                $j('input[name='+select_fieldType+']').trigger("userUpdated");
            }
        },
        async: false,
        timeout: 20000
    });
}

function setInviteField(recipient) {
    closeAllPopups();
    setReferenceUserID(recipient);
    hideLoader();
}

function validateEmailInvite()
{
    $j(".jive-error-message").each(function(index) {
        $j(this).hide();
    });

    var recipient = $j("#inviteEmail");
    var subject = $j("#inviteSubject");
    var messageBody = $j("#inviteMessageBodyDiv");

    if(recipient.val() != null && $j.trim(recipient.val())=="")
    {
        recipient.next().show();
        recipient.next().text("Please enter email");
        recipient.focus();
        return false;
    }
    else{
        /*Validate email via DWR request*/
        InviteUserUtil.validateEmail(recipient.val(), {
            callback: function(result) {

                if(result!="")
                {
                    recipient.next().show();
                    recipient.next().text(result);
                    recipient.focus();
                    return false;
                }
                else
                {
                    recipient.next().hide();
                }
                if(subject.val() != null && $j.trim(subject.val())=="")
                {
                    subject.next().show();
                    subject.focus();
                    return false;
                }
                if(!$j.trim(messageBody.val()))
                {
                    messageBody.next().show();
                    messageBody.focus();
                    return false;
                }
            },
            async: false
        });
    }
    return true;
}

function showLoader(title) {
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

function inviteUser() {
    $j("#user-autocomplete-modal-container").hide();
    var div = $j('<div id="invited-users-popup" class="invited-users-popup j-form-popup" style="display: none;"></div>');

    var closeBtn =  $j('<a class="close" href="javascript:void(0)"></a>');
    $j(closeBtn).css('display','none');
    $j(closeBtn).appendTo($j(div));



    var subdiv = $j('<div></div>');
    $j(subdiv).css('margin-left','-9px');
    $j(subdiv).css('margin-top','7px');

    var title = $j("<div class='light-box-title'><h4>Users requested on SynchrO</h4></div>");
    $j(title).appendTo($j(div))

    $j(div).hide();
    showLoader();

    $j(div).lightbox_me({centered:true,closeEsc:false,overlayCSS:{background: 'black', opacity: .7},
        showOverlay:false,
        destroyOnClose:true,
        parentLightbox:$j("#user-autocomplete-modal-container"),
        zIndex:100000000,
        onLoad:function(){
            $j(div).hide();
            $j(subdiv).load("/synchro/invite-user!input.jspa?page=1",function(){
                hideLoader();
                $j(subdiv).appendTo($j(div));
                $j(closeBtn).fadeIn();
                $j(div).fadeIn();
                $j(div).trigger('resize');
            });
        },
        onClose:function() {
            $j(div).fadeOut();
            $j("#user-autocomplete-modal-container").show();
            hideLoader();
        },
        onDefault:function() {
            $j(div).hide();
        }
    });
}

function closeAllPopups() {
    closeInviteEmailNotification();
  $j("#invited-users-popup").trigger('close');
  $j("#user-autocomplete-modal-container").trigger('close');
}



