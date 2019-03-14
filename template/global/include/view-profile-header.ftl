<#assign textArgs = [ '\\!\\,\\.\\?\\*\\@\\`\\~\\-\\+\\_\\=\\/\\\\:\\$' ] />
<#assign idPrefix = StringUtils.randomString(6) />

<@resource.dwr file="UserStatusAction" />
<@resource.javascript file="/resources/scripts/jive/widget/your-statusupdates.js"/>
<@resource.javascript file="/resources/scripts/apps/wall/util.js" />

<script type="text/javascript">
    yourStatusUpdates = (function() {
        var userName = "${SkinUtils.getDisplayName(user)?js_string}";
        var excludeName = true;
        var idPrefix = '${idPrefix}';
        var invalidCharsText = "${action.getText('settings.status.invalidChars', textArgs)}";
        return new jive.model.YourStatusUpdates(userName, idPrefix, invalidCharsText, excludeName);
    })();
    statusUpdateMessage = "<@s.text name="global.left_paren"/><@s.text name="global.update"/><@s.text name="global.right_paren"/>";

    <#if !(viewingSelf || user.anonymous || !targetUser.enabled)>
    this.jiveTracking = new jive.TrackingApp.Main({
        objectType: ${targetUser.objectType},
        objectID: ${targetUser.ID?c},
        featureName: 'user',
        i18n: {
            trackedTypeName:    'tracked.user'
        }
    });
    </#if>
</script>

<#if action.isAwaitingModeration(targetUser) && action.getCanModerate(targetUser)>
    <@resource.javascript>
    (function() {
    var actionQueueService = new jive.ActionQueue.ListSource();
    var spinner = new jive.loader.LoaderView({size: 'big'});

    $j('#j-action-button-accept').live('click', function(e) {
    spinner.prependTo($j('#j-profile-approval-container'));

    var postData = new jive.ActionQueue.ActionResult(${user.ID?c}, ${approvalEntryID?c}, 1, $j('#jive-approval-note-input').val());
    actionQueueService.performAction(postData).addCallback(function(data) {
    spinner.getContent().remove();
    spinner.destroy();
    $j('#j-profile-approval-container').remove();
    $j('<p><@s.text name="profile.approval.membership.approved"><@s.param>${SkinUtils.getDisplayName(targetUser)?js_string}</@s.param></@s.text></p>').message({style: 'success'});
    }).addErrback(function(message, status) {
    spinner.getContent().remove();
    spinner.destroy();
    });

    e.preventDefault();
    });
    $j('#j-action-button-reject').live('click', function(e) {
    spinner.prependTo($j('#j-profile-approval-container'));

    var postData = new jive.ActionQueue.ActionResult(${user.ID?c}, ${approvalEntryID?c}, 2, $j('#jive-approval-note-input').val());
    actionQueueService.performAction(postData).addCallback(function(data) {
    spinner.getContent().remove();
    spinner.destroy();
    $j('#j-profile-approval-container').remove();
    $j('<p><@s.text name="profile.approval.membership.rejected"><@s.param>${SkinUtils.getDisplayName(targetUser)?js_string}</@s.param></@s.text></p>').message({style: 'success'});
    }).addErrback(function(message, status) {
    spinner.getContent().remove();
    spinner.destroy();
    });

    e.preventDefault();
    });
    })();
    </@resource.javascript>
</#if>


<#if !user.anonymous && user.ID == targetUser.ID && jiveContext.getEmailInteractionManager().getCanCreateProfileContent(user)>
    <@resource.javascript>
    function launchAuthorByEmailModal() {
    $j('#vcard-modal').html('<p class="font-color-meta-light"><img src="<@s.url value="/images/jive-image-loading.gif"/>" alt=""/><@s.text name="customize.loading"/></p>');

    $j('#vcard-modal').load('<@s.url action="author-by-email"/>', function() {
    $j('#jive-author-by-email-modal').trigger('resize');
    $j(":checkbox[name ='vCardObjectTypes']").click(function() {
    toggleVCardActionButtons();
    });
    });

    $j("#jive-author-by-email-modal").lightbox_me({closeSelector: ".jive-close, .close"});
    }
    </@resource.javascript>
</#if>


<header class="j-page-header">

<@jive.userAvatar user=targetUser size=46 showHover=false />
<#assign targetUserStatus = jiveContext.statusManager.getCurrentStatus(targetUser)! />
    <div id="j-profile-header-details" class="vcard <#if !targetUserStatus?has_content >no_status</#if>">
        <h1 class="fn n">
        <@jive.displayUserDisplayName user=targetUser/>
        <#if (!targetUser.enabled)>
            <span><@s.text name="global.left_paren"/><@s.text name="global.disabled"/><@s.text name="global.right_paren"/></span>
        </#if>
        </h1>


    </div>

<#if !action.isAwaitingModeration(targetUser) && !(viewingSelf || user.anonymous || !targetUser.enabled)>
    <div id="j-profile-header-actions" class="j-rc5">
        <@s.action name="profile-follow-link" executeResult="true" ignoreContextParams="true">
                <@s.param name="targetUser" value="${targetUser.ID?c}"/>
            </@s.action>
    </div>
<#elseif (!action.isAwaitingModeration(targetUser) && viewingSelf)>
    <div id="j-profile-header-actions" class="j-rc5">
        <@s.action name="profile-follow-link" executeResult="true" ignoreContextParams="true">
                <@s.param name="targetUser" value="${targetUser.ID?c}"/>
                <@s.param name="showOnlyCounts" value="true"/>
            </@s.action>
    </div>
</#if>


<#if targetUserStatus?has_content >
    <div class="j-profile-header-status font-color-meta">
        "${targetUserStatus.statusText}"
        <span>
            - <a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(targetUserStatus)}'/>">
        ${StringUtils.getTimeFromLong(targetUserStatus.creationDate.time?long, 1)}</a>
        </span>
    </div>
</#if>

<#if action.isAwaitingModeration(targetUser) && action.getCanModerate(targetUser)>
    <div class="j-profile-header-approval">
        <div id="j-profile-approval-container" class="jive-table-approval-note j-rc5">
            <div>
                <div id="jive-approval-note-container">
                    <div class="jive-table-approval-noteheader"><span class="jive-icon-med jive-icon-note-add"></span><@s.text name="profile.approval.notes.text"/>
                        <span class="jive-approval-note-info font-color-meta"><@s.text name="profile.approval.note.info.text"/></span>
                    </div>
                    <div class="jive-table-approval-noteedit"><input id="jive-approval-note-input" type="text" name="approvalnote" size="" rows="3" maxlength="350"></div>
                </div>

                <div class="j-approval-actions clearfix">
                    <a href="#" id="j-action-button-accept" class="j-button"><@s.text name="eae.inbox.accept"/></a>
                    <@s.text name="global.or" />
                    <a href="#" id="j-action-button-reject" class="j-button"><@s.text name="eae.inbox.reject"/></a>
                    <@s.text name="profile.approval.membership.text" />
                </div>
            </div>
        </div>
    </div>
</#if>

</header>


<!-- BEGIN guest message -->
<#if (showGuestLoginOrRegisterMessage!false)>
<div class="j-guest-tip jive-info-box j-rc5">
    <@s.text name="profile.guesttip.text">
        <@s.param>
            <a href="<@s.url action='login' method='input'/>"><@s.text name='userbar.login.link' /></a>
        </@s.param>
        <@s.param>${targetUser.username?html}</@s.param>
    </@s.text>

    <#if accountCreationEnabled>
        <@s.text name="browse.guesttip.joinnow">
            <@s.param>
                <#if validationEnabled>
                    <a href="<@s.url action="login!input?registerOnly=true"/>"><@s.text name='browse.guesttip.join' /></a>
                <#else>
                    <a href="<@s.url action="create-account"/>"><@s.text name='browse.guesttip.join' /></a>
                </#if>
            </@s.param>
        </@s.text>
    </#if>
</div>
</#if>
<!-- END guest message -->
<#assign portalType = ""/>

<#if session.getAttribute('grail.portal.type')??>
  <#assign portalType = session.getAttribute('grail.portal.type')/>
</#if>

<#if portalType = statics['com.grail.util.BATGlobal$PortalType'].SYNCHRO.toString()>
    <#assign tabComponent = UIComponents.getUIComponent('user-profile-synchro') />
<#else>
    <#assign tabComponent = UIComponents.getUIComponent('user-profile') />
</#if>
<#if view?? && tabComponent.getTab(view)??>
    <#assign tabView = view />
<#else>
    <#assign tabView = 'profile' />
</#if>

<@jive.defaultActionErrorsAndMessages/>
<div id="info-box" class="jive-info-box" style="display:none"></div>
<div id="jive-error-box" class="jive-error-box" style="display:none"></div>
<div id="thread.watch.notify" class="jive-info-box" style="display:none"></div>

<nav class="j-bigtab-nav j-rc5 j-rc-none-bottom">
    <ul class="j-tabbar j-rc5">
    <@jive.displayTabs tabComponent ; tab >
        <li id="jive-${tab.id}-tab" class="<#if tabView == tab.id>j-tab-selected active j-ui-elem</#if>">
            <a title="${processAsTemplate(tab.description)}" href="${processAsTemplate(tab.url!)}"<#if tabView == tab.id> class="j-ui-elem"</#if>>${processAsTemplate(tab.name!)}</a>
        </li>
    </@jive.displayTabs>
    </ul>
</nav>

