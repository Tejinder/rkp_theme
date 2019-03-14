<#include "/template/global/include/profile-macros.ftl"  />

<#assign activityView = view == statics['com.jivesoftware.community.action.ViewProfile'].VIEW_ACTIVITY />
<#assign bioView = view == statics['com.jivesoftware.community.action.ViewProfile'].VIEW_BIO />
<#assign contentView = view == statics['com.jivesoftware.community.action.ViewProfile'].VIEW_CONTENT />
<#assign placesView = view == statics['com.jivesoftware.community.action.ViewProfile'].VIEW_PLACES />
<#assign peopleView = view == statics['com.jivesoftware.community.action.ViewProfile'].VIEW_PEOPLE />
<#assign tasksView = view == statics['com.jivesoftware.community.action.ViewProfile'].VIEW_TASKS />
<#assign bookmarksView = view == statics['com.jivesoftware.community.action.ViewProfile'].VIEW_BOOKMARKS />
<#assign anywhereView = view == statics['com.jivesoftware.community.action.ViewProfile'].VIEW_DEVICES />

<html>
<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
<#if (FeedUtils.isFeedsEnabled())>
    <link rel="alternate" type="${FeedUtils.getFeedType()}"
          title="<@s.text name='settings.msgsByUserFeed.tooltip'><@s.param>${jive.getUserDisplayName(targetUser)}</@s.param></@s.text>"
          href="<@s.url value="/community/feeds/messages?rssUsername=${targetUser.username?url}"
          />" />

    <#if BlogPermHelper.getCanViewBlogs() >
        <link rel="alternate" type="${FeedUtils.getFeedType()}"
              title="<@s.text name='settings.blgsByUserFeed.tooltip'><@s.param>${jive.getUserDisplayName(targetUser)}</@s.param></@s.text>"
              href="${BlogUtils.getUserFeedURL(targetUser.username)?default("")}"/>
    </#if>
</#if>


<#assign externalEdition = SkinUtils.isExternal() />

    <title>
    <#if viewingSelf>
        <#if contentView>
        <@s.text name="profile.your_stuff.gtitle"/>
    <#else>
        <@s.text name="settings.your_profile.gtitle"/>

    </#if>
    <#else>
        <#if contentView>
            <@s.text name="profile.users_stuff.gtitle">
                <@s.param>${jive.getUserDisplayName(targetUser)}</@s.param>
            </@s.text>
        <#else>
            <@s.text name="settings.users_profile.gtitle">
                <@s.param>${jive.getUserDisplayName(targetUser)}</@s.param>
            </@s.text>
        </#if>
    </#if>
    </title>
<#if legacyBreadcrumb>
    <content tag="breadcrumb">
        <a href="<@s.url value='/'/>">${container.name?html}</a>
        <a href="<@s.url value='/people'/>"><@s.text name="profile.people.brdcrmb.link" /></a>
    </content>
</#if>

<#if tasksView>
    <link rel="stylesheet" href="<@resource.url value='/styles/jive-project.css'/>" type="text/css" media="all" />
</#if>

<#if bioView || activityView>

    <@resource.javascript file='/resources/scripts/breadcrumb.js'/>
    <@resource.javascript file='/resources/scripts/jive/gui/window.js'/>
    <@resource.template file="/resources/scripts/apps/email_notification/main.js" />
    <@resource.template file="/resources/scripts/apps/recommendation_app/profile_page_controller.js" />
    <@resource.javascript>
        function showPhoto(imageNo) {

        $j('.jive-profile-photo').each(function() {
        if (this.id.startsWith('photo_')) {
        if (this.id == 'photo_' + imageNo) {
        $j(this).show();
        }
        else {
        $j(this).hide();
        }
        }
        else {
        if (this.id == 'thumbnail_' + imageNo) {
        $j(this).closest('li').addClass('current');
        }
        else {
        $j(this).closest('li').removeClass('current');
        }
        }
        });
        }

        function deleteSelectedImage() {
        <#assign msg><@s.text name="profile.image.delete.confirm"/></#assign>
        if (!confirm("${msg?js_string}")) {
        return;
        }

        var selectedId = $j('#jive-profile-photo img:visible')[0].id;
        if (selectedId) {
        var index = selectedId.replace("photo_", "");
        $j('#delete-image-index').val(index);
        $j('#delete-image-form').submit();
        }
        return false;
        }

        <#assign profileFriendsSendMessageToLabel><@s.text name="profile.friends.sendmessageto.label"><@s.param>${SkinUtils.getDisplayName(targetUser)}</@s.param></@s.text></#assign>
        function popMessageWindow() {
        win = new jive.gui.smallWindowPanel('${profileFriendsSendMessageToLabel?js_string}', $j("#send-friend-msg-panel").get(0), "medium");
        win.setBackAction(function(){
        win.close();
        });
        win.show();
        }

    <#--function emailFriends(title, msg, copySelf) {
      if (!title || !msg || trim(title) == '' || trim(msg) == ''){
          showError("<@s.text name='profile.friends.subjectmessagerequired.error' />");
          return false;
      }
      FriendListAction.emailFriends(trim(title), trim(msg), new Array(String(targetUserID)), copySelf, {
          callback:function() {
              showMessage("<@s.text name='profile.friends.messagesent.message' />");
              clearEmailForm();
              return true;
          }
      });
    }-->

        function trim(str){
        return str.replace(/^\s+|\s+$/g, '');
        }

    <#--function clearEmailForm() {
        $j('#sendMessageToIDs').val("");
        $j('#friendMessageSubject').val("");
        $j('#friendMessageText').val("");
    }-->

        function showMessage(msg){
        $j('#info-box').append(
        $j(document.createElement('div'))
        .text(msg)
        .prepend(
        $j(document.createElement('span')).addClass('jive-icon-med jive-icon-info')
        )
        ).fadeIn();
        setTimeout(function() { $j(document).click(hideMsgBoxes); }, 1000);
        }

        function hideMsgBoxes(){
        $j('#info-box').hide();
        $j('#error-box').hide();
        $j(document).unbind('click', hideMsgBoxes);
        }

        $j(function() { new jive.EmailNotification.Main(${targetUser.ID?c}, ${targetUser.objectType?c}, true); });
    </@resource.javascript>
</#if>

<#if chatPresenceManagerImpl.isPresencePublishedFor( targetUser )>
    <#assign this_user_presence = StringUtils.randomString( 4 ) />
    <#assign presenceObject = 'null' />
    <#assign presenceProvider = chatPresenceManagerImpl.getPresenceProvider() />
    <#if presenceProvider??>
        <#assign presenceObject = presenceProvider.getPresenceJsObject( JiveGlobals.getCurrentUser()! , targetUser, this_user_presence )!/>
        <#if presenceObject??>
            <script type='text/javascript'>
                $j(document).ready(function() {
                    var presence = ${presenceObject};
                    presence.start();
                });
            </script>
        </#if>
    </#if>
</#if>
</head>
<body class="jive-view-profile j-view-profile">

<#if approval?exists>
    <#include "/template/global/include/user-needs-approval.ftl" />
</#if>

<#include "/template/global/include/view-profile-header.ftl"/>




<!-- Render profile view -->
<#if bioView>

<!-- BEGIN layout -->
<div class="j-layout j-layout-l j-contained j-contained-tabs j-contained-tabs-profile j-rc5 j-rc-none-top clearfix">
    <!-- BEGIN large column -->
    <div class="j-column-wrap-l">
        <div class="j-column j-column-l">
            <@userProfile postfix=this_user_presence/>
        </div>
    </div>
    <!-- END large column -->
</div>
<!-- END layout -->

<#elseif activityView>

<!-- BEGIN layout -->
<div class="j-layout j-layout-ls j-contained j-contained-tabs j-contained-tabs-profile j-contained-tabs-profile-activity j-rc4 j-rc-none-top clearfix">
    <!-- BEGIN large column -->
    <div class="j-column-wrap-l">
        <div class="j-column j-column-l">

            <!-- BEGIN latest activity -->
            <!-- begin jive-content-block -->

            <#import "/template/microblogging/wallentry-macros.ftl" as we/>
            <@we.includeStatusInputJs />
            <@we.initStatusInputI18N/>
            <@resource.template   file="/soy/shared/display_utils.soy"/>
            <@resource.template   file="/soy/wall/wall.soy"/>
            <@resource.javascript file="resources/scripts/apps/wall/wall_entry_comment_helper.js"/>
            <@resource.javascript file="resources/scripts/apps/wall/wall_entry_repost_helper.js"/>
            <script type="text/javascript">
                $j(function() {
                    <@we.initCommentsi18n/>
                    var templateOptions = {
                    canComment: <#if statics['com.jivesoftware.community.microblogging.util.WallEntryPermHelper'].canComment()>true<#else>false</#if>,
                    canCreateImage: <#if statics['com.jivesoftware.community.microblogging.util.WallEntryPermHelper'].canCreateImage()>true<#else>false</#if>,
                        i18n: commenti18n
                    };

                    // bind various items up
                    jive.Wall.Main.bindRowHover();
                    jive.Wall.Main.bindRepostAndComments(${statics['com.jivesoftware.community.microblogging.WallEntry'].OBJECTID?c},
                            '<@s.url action="status-list-comments"/>');

                    jive.Wall.Main.bindComments(${statics['com.jivesoftware.community.microblogging.WallEntry'].OBJECTID?c}, templateOptions);
                    // Setup repost functionality
                    //jive.Wall.RepostHelper.bindRepostAnchors(templateOptions);
                });
            </script>
            <@s.action name="profile-activity-stream" executeResult="true" ignoreContextParams="true">
                <@s.param name="targetUser">${targetUser.ID?c}</@s.param>
                <@s.param name="filterStatus">${filterStatus?string}</@s.param>
            </@s.action>
            <!-- close jive-content-block -->
            <!-- END recent activity -->

        </div>
    </div>
    <!-- END large column -->

    <!-- BEGIN small column -->
    <@profileSidebar />
    <!-- END small column -->

</div>
<!-- END layout -->

<#elseif contentView>

    <#if viewingSelf>
    <!-- display a message that you will see content others may not see, TBD -->
    </#if>

    <@s.action name="profile-content" executeResult="true" ignoreContextParams="false">
        <@s.param name="targetUser">${targetUser.ID?c}</@s.param>
    </@s.action>

<#elseif peopleView>

    <@s.action name="profile-people" executeResult="true" ignoreContextParams="false">
        <@s.param name="targetUser">${targetUser.ID?c}</@s.param>
    </@s.action>

<#elseif placesView>

    <@s.action name="profile-places" executeResult="true" ignoreContextParams="false">
        <@s.param name="targetUser">${targetUser.ID?c}</@s.param>
    </@s.action>

<#elseif tasksView>

<div id="thread.watch.notify" class="jive-info-box" style="display:none"></div>

<!-- BEGIN layout -->
<div class="j-layout j-layout-l j-contained j-contained-tabs j-contained-tabs-profile j-rc4 j-rc-none-top clearfix">
    <!-- BEGIN large column -->
    <div class="j-column-wrap-l">
        <div class="j-column j-column-l">

            <div id="jive-task-list-container">
                <@s.action name="view-task-list" executeResult="true" ignoreContextParams="true">
                            <@s.param name="owner">${targetUser.ID?c}</@s.param>
                            <@s.param name="task"><#if task?exists>${task.ID?c}</#if></@s.param>
                            <@s.param name="filter"><#if filter?exists>${filter?html}</#if></@s.param>
                        </@s.action>
            </div>

        </div>
    </div>

    <#if viewingSelf>
        <div class="j-column j-column-s" style="display: none;"> <#-- no need for this column now -->
            <div class="j-box j-box-actions">
                <header>
                    <h4><@s.text name="settings.actions.gtitle" /></h4>
                </header>

                <div id="jive-action-sidebar" class="j-box-body">
                    <div class="jive-action-sidebar-tab-first">
                        <ul class="j-icon-list">
                            <li><a href="<@s.url action="create-task" method="input" />"><span class="jive-icon-med jive-icon-task"></span><@s.text name="project.task.create.link"/></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </#if>
</div>

    <@resource.javascript file="/resources/scripts/jivetasklist.js"/>
    <@resource.javascript>
    var jivetasklist = new JiveTaskList("jive-task-list-container", "<@s.url action='edit-task' method='complete'/>", "<@s.url action='edit-task' method='incomplete'/>", "<@s.url action='edit-task' method='take'/>", "<@s.url action='edit-task' method='delete'/>", "<@s.url action='view-task-list'><@s.param name='owner' value='${targetUser.ID?c}'/></@s.url>", "${action.getText('task.delete.confirm.msg')?js_string}", "${action.getText('task.list.unauth')?js_string}", "${action.getText('task.list.error')?js_string}");
    </@resource.javascript>

<#elseif bookmarksView && !user.anonymous>

    <@s.action name="profile-bookmarks" executeResult="true" ignoreContextParams="false">
        <@s.param name="targetUser">${targetUser.ID?c}</@s.param>
    </@s.action>

<#elseif anywhereView && viewingSelf>

    <@s.action name="profile-anywhere" executeResult="true" ignoreContextParams="false">
        <@s.param name="targetUser">${targetUser.ID?c}</@s.param>
    </@s.action>

</#if>


<#macro profileSidebar>
<!-- BEGIN small column -->
<div class="j-column-wrap-s">
    <div class="j-column j-column-s">

        <#if viewingSelf>
            <@jive.renderActionSidebar 'profile-actions-self' />
        <#else>
            <#if (!user.anonymous)>
                <@jive.renderActionSidebar 'profile-actions' />
            </#if>
        </#if>

        <#if chatPresenceManagerImpl.isPresencePublishedFor( targetUser ) >
            <!-- -->
            <div class="j-box j-box-presence">
                <div class="j-box-body">
                    <@jive.renderPresence user=targetUser postfix=this_user_presence/>
                </div>
            </div>
        </#if>

        <#if jive.isModuleAvailable("blogs") && ((personalExists!false) || (viewingSelf && BlogPermHelper.getCanCreateBlog())) && !JiveContainerPermHelper.isBannedFromPosting()>
            <!-- BEGIN sidebar box 'BLOGS' -->
            <div class="j-box j-box-userblog">
                <header>
                    <h4>
                        <#if viewingSelf>
                            <#if personalExists>
                                <@s.text name="settings.your_blog.gtitle" />
                            </#if>
                        <#else>
                            <span><@s.text name='profile.blog.visit'><@s.param><@jive.displayUserDisplayName user=targetUser/></@s.param></@s.text></span>
                        </#if>
                    </h4>
                </header>
                <div class="j-box-body">
                    <#if personalExists>
                        <p><a href="${BlogUtils.getBlogURL(personalBlog)}">${personalBlog.name?html}</a></p>
                    <#else>
                        <@s.text name="settings.youDoNotHvBlog.text" />
                        <strong><a href="<@s.url action='blogs-create-blog' method='input' />" ><span class="jive-icon-med jive-icon-blog"></span><@s.text name='global.create_personal_blog' /></a></strong>
                    </#if>
                </div>
            </div>
            <!-- END sidebar box 'BLOGS' -->
        </#if>


        <#if action.isRecommendationsEnabled()>
            <div id="trendy-container" class="j-box j-box-actions">
                <header><h4><@s.text name="profile.trendycontent.title" /></h4></header>

                <article id="trendy" class="j-box-body" data-modulebody="true" data-max="10" data-loadmore="false" data-max="10"></article>
                <@resource.javascript>
                    $j(function() {
                    jive.RecommendationApp.profilePageController.initialize(${targetUser.ID?c});
                    });
                </@resource.javascript>
            </div>
        </#if>

        <@s.action name="similar-users!include" executeResult="true" ignoreContextParams="true">
            <@s.param name="targetUser">${targetUser.ID?c}</@s.param>
        </@s.action>


        <#if action.isAcclaimEnabled("like")>
            <@s.action name="most-liked" executeResult="true" ignoreContextParams="true">
                <@s.param name="container">${jiveContext.communityManager.rootCommunity.ID?c}</@s.param>
                <@s.param name="containerType">${JiveConstants.COMMUNITY}</@s.param>
                <@s.param name="filterUserID">${targetUser.ID?c}</@s.param>
                <@s.param name="numResults" value="'10'"/>
            </@s.action>
        </#if>

    </div>
</div>
<!-- END small column -->
</#macro>



<#-- author by email modal -->
<#if !user.anonymous && user.ID == targetUser.ID && jiveContext.getEmailInteractionManager().getCanCreateProfileContent(user) >
    <@resource.javascript file="/resources/scripts/jive/author-by-email.js" header="true" id="core" />
<div class="jive-modal jive-modal-medium jive-author-by-email-modal" id="jive-author-by-email-modal">
    <header><h2><@s.text name="author.by.email.modal.title" /></h2></header>
    <a href="#" class="j-modal-close-top close"><@s.text name="author.by.email.modal.close" /> <span class="j-close-icon  j-ui-elem"></span></a>
    <div class="jive-modal-content" id="vcard-modal">
    </div>
</div>
</#if>
<#-- end author by email modal -->

<#if bioView || activityView>
<div class="jive-friend-actionpanel clearfix jive-modal-form" id="send-friend-msg-panel" style="display:none">
    <form action="#">

        <div class="jive-form-row">
            <div class="jive-form-label">
                <label for="friendMessageSubject"><@s.text name="global.subject" /></label>
            </div>
            <div class="jive-form-element">
                <input type="text" size="40" name="friendMessageSubject" id="friendMessageSubject" class="jive-msg-subject jive-form-element-text"/>
            </div>
        </div>
        <div class="jive-form-row">
            <div class="jive-form-label">
                <label class="jive-windowform-label" for="friendMessageText"><@s.text name="global.message" /></label>
            </div>
            <div class="jive-form-element">
                <textarea rows="3" cols="40" wrap="virtual" id="friendMessageText" name="friendMessageText" class="jive-form-element-textarea"></textarea>
            </div>
        </div>
        <div class="jive-form-row">
            <div class="jive-form-element">
                <input type="checkbox" id="friendMessageCopySelf" class="jive-form-element-checkbox"/>
                <label class="jive-windowform-label-inline jive-checkbox-label" for="friendMessageText"><@s.text name="profile.friends.sendcopy.text" /></label>
            </div>
        </div>
        <div class="jive-form-buttons clearfix">
            <button class="j-btn-callout" onclick="emailFriends($j('#friendMessageSubject').val(), $j('#friendMessageText').val(), $j('#friendMessageCopySelf').attr('checked')); closeMyLightbox(this); return false;"><@s.text name="pm.send_message.button" /></button>
            <button onclick="closeMyLightbox(this); return false;"><@s.text name="global.cancel" /></button>
        </div>
    </form>
</div>
</#if>
<script type="text/javascript">

$j(document).ready(function() {
	$j("#jive-link-user-vcard a").click(function(event) {
		<#assign i18CustomTextVCard="Vcard" />
		SynchroLogUtil.addLogActivity("", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROFILE.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()}, "", "${i18CustomTextVCard}", "", -1, ${user.ID?c});
	});
});
<!-- Audit Logs -->
	<#assign i18CustomText="Bio" />
	SynchroLogUtil.addLogActivity("", ${statics['com.grail.synchro.SynchroGlobal$PageType'].PROFILE.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, "", "${i18CustomText}", "", -1, ${user.ID?c});
</script>
</body>
</html>
