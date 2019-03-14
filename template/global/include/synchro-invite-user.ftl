<#assign jiveURL = JiveGlobals.getJiveProperty("jiveURL")/>
<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<#include "/template/global/include/synchro-macros.ftl" />
<div class="invite-user-container">
    <div class="invite-user-container-main">
        <div class="top-container">
            <span class="go-back-link"><a href="javascript:void(0);" onclick="javascript:$j('#invited-users-popup').trigger('close');">Go Back</a></span>
            <span class="request-new"><a href="javascript:void(0);" onclick="javascript:openMailPopup()">Request a New User</a></span>
        </div>
        <#--<span class="table-title">Requested Users</span>-->
        <div class="search-container">

            <span class="download-report"><a href="<@s.url value="/synchro/invite-user!downloadReport.jspa"/>">Download Report</a></span>
            <div class="site_search">
                <input type="text" name="q" size="31" id="invite-user-search-box" class="search_box" onkeyup="onSearchInputKeyUp()"/>
                <input type="button"  name="" value="" class="search_icon" />
            </div>
            <div id="invited-users-pagination" class="invited-users-pagination">

            <#--<#if pages?? && pages &gt; 0>-->
            <#--<div id="invited-users-pages-navigation" class="invited-users-pages-navigation">-->
                <#--<a href="#" title="Click to go to the previous page" class="pagination-prev">Previous</a>-->
                <#--<a href="#" title="Click to go to the next page" class="pagination-next">Next</a>-->
            <#--</div>-->
        <#--</#if>-->
            </div>
        </div>
        <div id="remainder-message" class="remainder-message" style="display: none"><p>Reminder sent successfully.</p></div>
    </div>
    <div id="invited-users-results" class="invited-users-results">
    </div>
</div>
<div id="inviteEmailNotification" class="j-form-popup" style="display:none;">
    <form method="post" id="invite-user-form">
        <a href="javascript:void(0);" class="close" onclick="closeInviteEmailNotification();"></a>
        <label><@s.text name="invite.to.field"/></label>
        <input type="text" id="inviteEmail" name="recipient" value="" />
        <span class="jive-error-message" style="display:none" id="inviteEmail_error"><@s.text name="invite.email.error"/></span>
        <br />
        <label><@s.text name="invite.subject.field"/></label>
        <input type="text" id="inviteSubject" name="subject" value="<@s.text name='invite.subject.text'/>" />
        <span class="jive-error-message" style="display:none" id="inviteEmail_error"><@s.text name="invite.email.error"/></span>
        <span class="jive-error-message" style="display:none" id="inviteSubject_error"><@s.text name="invite.subject.error"/></span>
        <br />

        <label><@s.text name="invite.body.field"/></label><br />
        <div id="inviteMessageBodyDiv" contenteditable>
            <p>
            <@s.text name="invite.body.text">
          <@s.param>${jiveURL}${"/file/download/Synchro_User_Application_Form.xlsx"}</@s.param>
       </@s.text>
            </p>
        </div>
        <span class="jive-error-message" style="display:none" id="inviteMessageBody_error"><@s.text name="invite.body.error"/></span>
        <br />
        <input class="j-btn-callout" type="button" name="doPost" id="postButton" onclick="javascript:sendEmailInvite(${user.ID?c}, <#if projectID??>${projectID?c}<#else>-1</#if>, <#if stageId??>${stageId?c}<#else>0</#if>);" value="send"/>
    </form>
</div>
<script type="text/javascript">
    var currPage = 1;
    var timer;
    $j(document).ready(function(){
        processPaginationRequest(currPage,"");
    });

    function onSearchInputKeyUp() {
        clearTimeout(timer);
        timer = setTimeout(function(){
            var value = $j("#invite-user-search-box").val();
            if($j.trim(value) != "") {
                processPaginationRequest(1, $j.trim(value));
            } else {
                processPaginationRequest(1, "");
            }
        }, 300);
    }




    var xhr;
    function processPaginationRequest(page,keyword)
    {
        currPage = page;
        var url = '/synchro/invited-users-modal!input.jspa'
        if(xhr != null) {
            xhr.abort();
        }

        xhr = $j.ajax({
            url: url,
            type: 'POST',
            data: 'keyword='+ keyword+"&page="+page,
            beforeSend: function() {
            },
            complete: function() {
            },
            success: function(result) {
                xhr = null;
                $j('#invited-users-results').html(result);
                updatePagination();
                $j("#invited-users-popup").trigger('resize');
            }
        });
    }

    $j("#invite-user-search-box").submit(function( event ) {
        event.preventDefault();
    });

</script>