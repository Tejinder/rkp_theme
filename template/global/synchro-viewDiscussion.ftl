<!-- This Ftl is customized version of /template/forums/thread.ftl -->

<#-- @ftlvariable name="" type="com.jivesoftware.community.action.ThreadActionSupport" -->
<#assign fromPrintPreview = (decorator?? && decorator == 'print')>
<#assign canCreateMessage = MessagePermHelper.getCanCreateMessage(thread)>
<#assign renderedPostBody = action.renderToHtml(thread.rootMessage)>
<#include "/template/global/include/jive-search-macros.ftl"/>
<#include "/template/global/include/discussion-comment-thread-common.ftl"/>
<#include "/template/global/include/tag-macros.ftl"/>

<!-- BEGIN SYNCHRO -->
<!-- Added the customized synchro common discussion ftl -->
<#include "/template/global/synchro-discussion-common.ftl">
<!-- END SYNCHRO -->
<html>
<head>

<title>${action.renderSubjectToText(thread.getRootMessage())}</title>

<link rel="stylesheet" href="<@resource.url value='/styles/jive-content.css'/>" type="text/css" media="all"/>
<#if bridgingEnabled>
<link rel="stylesheet" href="<@resource.url value='/styles/jive-bridges.css'/>" type="text/css" media="all"/>
</#if>
<link rel="stylesheet" href="<@resource.url value='/styles/tiny_mce3/themes/advanced/skins/default/content.css'/>" type="text/css" media="all" />

<#if fromPrintPreview>

    <#include "/template/decorator/default/header-clickjacking-prevent.ftl" />

    <#include "/template/decorator/default/header-javascript.ftl" />

<@resource.javascript id="core" output="true" />
    <#list jiveContext.getSpringBean("javascriptURLConfigurator").pluginJavascriptSrcURLs as src >
    <script type="text/javascript" src="<@s.url value='${src}' />"></script>
    </#list>

<@resource.javascript id="rte" output="true" />
<@resource.javascript output="true" />
</#if>

<#if (FeedUtils.isFeedsEnabled())>
    <#if (container.objectType == JiveConstants.COMMUNITY)>
    <link rel="alternate" type="${FeedUtils.getFeedType()}"
          title=" ${container.name} <@s.text name='forum.thrd.dscThrdsFeed.tooltip' />"
          href="<@s.url value='/community/feeds/threads?community=${container.ID?c}'
          />">
        <#elseif (container.objectType == JiveConstants.PROJECT)>
        <link rel="alternate" type="${FeedUtils.getFeedType()}"
              title=" ${container.name} <@s.text name='forum.thrd.dscThrdsFeed.tooltip' />"
              href="<@s.url value='/projects/feeds/threads?project=${container.ID?c}'
              />">
        <#elseif (container.objectType == JiveConstants.SOCIAL_GROUP)>
        <link rel="alternate" type="${FeedUtils.getFeedType()}"
              title=" ${container.name} <@s.text name='forum.thrd.dscThrdsFeed.tooltip' />"
              href="<@s.url value='/groups/feeds/threads?socialGroup=${container.ID?c}'
              />">
        <#else>

        <script type="text/javascript">
            console.log("An unknown container was specified. The discussions feed for the container is not being loaded.");
        </script>

    </#if>

<link rel="alternate" type="${FeedUtils.getFeedType()}"
      title="Messages in '${thread.name?html}' <@s.text name='forum.thrd.thread_feed.tooltip' />"
      href="<@s.url value='/community/feeds/messages?thread=${thread.ID?c}'
      />">
</#if>


<#if followable>
<@resource.javascript type="text/javascript">

    <#assign startFollowText><@s.text name="thread.startFollow.desc" /></#assign>
    <#assign stopFollowText><@s.text name="thread.stopFollow.desc" /></#assign>
    <#assign followError><@s.text name='global.follow.error'/></#assign>
var i18n = {startFollowing : '${startFollowText?js_string}',
stopFollowing : '${stopFollowText?js_string}',
followError : '${followError?js_string}'}

var jiveFollow = new jive.FollowApp.Main({objectType: 2, objectID:${thread.rootMessage.ID?c}, featureName:'thread',
i18n:i18n});

</@resource.javascript>
</#if>

<#if trackable>
    <@resource.javascript type="text/javascript">

    var jiveTracking = new jive.TrackingApp.Main({objectType: 2, objectID:${thread.rootMessage.ID?c},
    featureName:'thread',
    i18n: {
                trackedTypeName:    'tracked.discussion'
    }});

    </@resource.javascript>
</#if>

<@resource.template file="/soy/userpicker/userpicker.soy" />
<@resource.template file="/soy/share/share.soy" />
<@resource.javascript file="/resources/scripts/apps/share/views/share_view.js" />
<@resource.javascript file="/resources/scripts/apps/share/models/share_source.js" />
<@resource.javascript file="/resources/scripts/apps/share/main.js" />
<@resource.javascript file="/resources/scripts/jive/share.js" />

<@resource.template file="/soy/groups/membership.soy" />
<@resource.javascript file="/resources/scripts/apps/socialgroup/membership/views/membership_view.js" />
<@resource.javascript file="/resources/scripts/apps/socialgroup/membership/models/membership_source.js" />
<@resource.javascript file="/resources/scripts/apps/socialgroup/membership/main.js" />

<@resource.template file="/resources/scripts/apps/email_notification/main.js" />

<@resource.template file="/soy/nav/movecontent.soy" />
<@resource.template file="/soy/threadtodoc/threadtodoc.soy" />
<@resource.template file="/soy/nav/modalizer.soy" />


<#assign threadMessageCount = thread.getMessageCount()>
<@resource.javascript>
var jiveMembership = new jive.MembershipApp.Main({objectID:${container.ID?c}});
var pickerArgs = {
objectType: ${thread.objectType?c},
objectID: ${thread.ID?c},
personalContainerTitleKey:'nav.bar.create.personal_container.title.thread',
personalContainerCaptionKey:'nav.bar.create.personal_container.caption.thread',
searchPlaceholderKey:'place.picker.move.search.thread',
containerID: ${container.ID?c},
containerType: ${container.objectType?c}};
var jiveMoveContent = new jive.Move.Content.Main(pickerArgs);
var jiveThreadToDoc = new jive.ThreadToDoc.Main($j.extend({maxMessages:${maxMessagesForDocCreation?c},
threadMessageCount: ${threadMessageCount?c}}, pickerArgs));
var jiveLockThread = new jive.Modalizer.Main({triggers:['#jive-link-lock a','#jive-link-unlock a']});
var jiveBranchThread = new jive.Modalizer.Main({liveTriggers:['.js-link-branch'], width: 'medium'});
var jiveDeleteContent = new jive.Modalizer.Main({triggers:['#jive-link-delete a'], liveTriggers:['.js-link-delete']});
var jiveReportAbuse = new jive.Modalizer.Main({triggers:['#jive-link-abuse a'],liveTriggers:['.js-link-abuse'], width:
'medium'});
    <#if ((canMarkAsQuestion || canUnmarkAsQuestion) && thread.status.visible)>
    var jiveMarkAsQuestion = new jive.Modalizer.Main({liveTriggers:['#jive-answer-bar a'], width: 'medium'});
    </#if>
$j(function() { new jive.EmailNotification.Main(${thread.ID?c}, ${thread.objectType?c}); });
</@resource.javascript>

<@resource.dwr file="Draft" />
<@resource.dwr file="MessageCreate" />
<script type="text/javascript">
    function updateMessageFromDraft(draft) {
        // dwr can't deserialize Image so just send along the image ID's
        draft.imageIDs = [];
        for (var i = 0; i < draft.images.length; i++) {
            draft.imageIDs[i] = draft.images[i].ID;
        }
        draft.images = [];

        MessageCreate.updateImagesFromDraft(draft, {
            timeout: DWRTimeout, // 20 seconds
            errorHandler: editorErrorHandler
        });
    }
</script>

<#if action.isUserContainer()>
<@resource.dwr file="ManageContentCollaboration"/>
<@resource.javascript>
$j(function() {
$j("#jive-link-manage-collab > a").click(function() {
$j("#jive-modal-participants").lightbox_me();
return false;
});
});

$j(function() {
$j(".jive-participants-manage").click(function() {
$j("#jive-modal-participants").lightbox_me();
return false;
});
});

function handleParticipantUpdate(){

var newCollaborators = $j('input[name="participants"]').val();

ManageContentCollaboration.updateCollaborators(${thread.objectType?c}, ${thread.ID?c}, ${user.ID?c}, newCollaborators,
function(users){
var newParticipants = [];
var shortUserHtml = "";
var allUserHtml = "";

for(var i = 0; i < users.length; i++){
newParticipants[i] = users[i].username;
var userText = '<a href="#" class="jive-username-link">' + users[i].displayName + '</a>';
if(i < users.length -1){
userText += ', ';
}
if( i < 5){
shortUserHtml += userText;
}
allUserHtml += userText;
}
if(users.length > 5){
<@s.text name="forum.thrd.showall" id="privateThreadShowAll" />
<@s.text name='forum.thrd.showless' id="privateThreadShowLess" />
shortUserHtml += '...&nbsp;(<a href="#" class="jive-shared-list-toggle jiveSharedShowAll">' +
    '${privateThreadShowAll?js_string}' + '</a>)';
allUserHtml += '&nbsp;(<a href="#" class="jive-shared-list-toggle jiveSharedShowLess">' +
    '${privateThreadShowLess?js_string}' + '</a>)';
}
$j('#jive-shared-list-short-users').html(shortUserHtml);
$j('#jive-shared-list-all-users').html(allUserHtml);

$j(function() {
$j('.jive-shared-list-toggle').click(function() {
$j('.jive-shared-list-short').toggle();
$j('.jive-shared-list-all').toggle();
return false;
});
});
});
return false;
};
</@resource.javascript>
</#if>

<@resource.javascript>
$j(function() {
$j('.jive-shared-list-toggle').click(function() {
$j('.jive-shared-list-short').toggle();
$j('.jive-shared-list-all').toggle();
return false;
});
});
</@resource.javascript>

<#if legacyBreadcrumb>
<content tag="breadcrumb">
    <@s.action name="legacy-breadcrumb" executeResult="true" ignoreContextParams="true">
        <@s.param name="container" value="${container.ID?c}" />
        <@s.param name="containerType" value="${container.objectType?c}" />
    </@s.action>
        <a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>/content?filterID=contentstatus[published]~objecttype~objecttype[thread]"><@s.text name="main.discussions.link" /></a>
</content>
</#if>

<!-- BEGIN action bar -->
<#include "/template/global/include/action-bar-macros.ftl" />
<@renderActionBar thread />
<!-- END action bar -->

<#if (JiveGlobals.getJiveBooleanProperty("skin.default.advancedThreadHighlighting", false))>
<script type="text/javascript" src="<@s.url value="/resources/scripts/thread-flat.js" />"></script>
<script type="text/javascript">
    // comment relationships
    Comments.tableRelations = new Array();
</script>
</#if>

<#assign bridged = false/>
<#if action.hasLocalBridgedDiscussion(thread)>
<@resource.javascript file="/resources/scripts/jive/bridge-bar.js"  />
    <#assign bridged = true/>
</#if>
<#if threaded>
    <link rel="canonical" href="${canonicalURL}"/>
<#else>
    <link rel="canonical"
          href="${canonicalURL}?start=${newPaginator.range * newPaginator.pageIndex}&tstart=0"/>
</#if>

<#assign personalDisabled = (action.isUserContainer()) && (!SkinUtils.isPersonalContentEnabled(thread.objectType)) />

<@resource.javascript>
var _editor_lang = "${displayLanguage}";
var _jive_video_picker__url = "?container=${container.ID?c}&containerType=${container.objectType?c}";
</@resource.javascript>

</head>

<!--featured content macro-->
<@jive.featureContentObject objectType=thread.objectType?c objectID=thread.ID?c containerType=container.objectType?c containerID=container.ID?c/>

<body class="jive-body-content j-thread jive-body-content-thread">

<#assign isThreadAuthor = user.ID?c == thread.rootMessage.user.ID?c>
<#assign statusLevelEnabled = jiveContext.getStatusLevelManager().isStatusLevelsEnabled()>
<#assign threadMessageCount = thread.getMessageCount()>

<#include "/template/decorator/default/header-javascript-minirte.ftl" />
<#include "/template/global/include/rte-macros.ftl"/>
<div id="rte-template" style="display:none;">
<@miniRteDiscussion thread=thread comment="" container=container replySubject="" partialURL=partialURL/>
</div>
<@initDiscusssionsJS/>

<!-- BEGIN header & intro  -->
<header id="jive-body-intro" class="font-color-meta">
<div class="j-context">

<!--BEGIN SYNCHRO -->
<#if backURL?? >
	<div class="go-back">
		<a href="/synchro/discussion-Forums.jspa">Go Back</a>
	</div>
<#else>
	<div class="go-back">
		<a href="/synchro/discussionForum/${projectID?c}/${container.ID?c}?filterID=contentstatus[published]~objecttype~objecttype[thread]">Go Back</a>
	</div>
</#if>
<!-- Changes made to display the Project Name and remove the other community Links -->
<h2>${container.name?html} (${projectID?c})</h2> 

<!--
<#if action.isUserContainer() >

<@s.param><a
        href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>"><@jive.displayUserDisplayName user=userContainerOwner/></a></@s.param>

    <#else>
    <a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>"><span class="${SkinUtils.getJiveObjectCss(container, 1)}"></span>${container.name?html}</a>
    
   
</#if>
-->
<!--END SYNCHRO -->
</div>
</header>
<!-- END header & intro -->

<!-- BEGIN SYNCHRO -->
<!-- Added Synchro Macros for rendering the other tabs -->
<#include "/template/global/include/synchro-macros.ftl" />
<@renderDetailsTab activeTab=7 projectID=projectID communityID=container.ID/>
<!-- END SYNCHRO -->
<!-- BEGIN layout -->

<div class="j-layout j-layout-ls clearfix">
&nbsp;
<@outputMainBodyColumn/>

    <!-- BEGIN small -->
    <div class="j-column-wrap-s">
        <div class="j-column-s j-column j-content-extras">

        <@jive.socialActions user followable followed thread thread.rootMessage "thread" favoriteManager.enabled sharingEnabled/>

        <#if backURL?? >
        	<@jive.renderActionSidebar 'thread-actions-viewAll' container />
        <#else>
        	<@jive.renderActionSidebar 'thread-actions' container />
        </#if>


       <#-- <@moreLikeThis objectType=thread.rootMessage.objectType objectID=thread.rootMessage.ID /> -->

        <@s.action name="incoming-links" executeResult="true" ignoreContextParams="true">
        <@s.param name="objectType">${thread.objectType?c}</@s.param>
        <@s.param name="objectID">${thread.ID?c}</@s.param>
        </@s.action>


        <#if question?exists && statusLevelEnabled>
            <#assign helpfulScenario = jiveContext.getStatusLevelManager().getStatusLevelScenarioByCode("helpfulAnswerAdded")>
            <#assign correctScenario = jiveContext.getStatusLevelManager().getStatusLevelScenarioByCode("correctAnswerAdded")>
            <div class="j-box">
                <header>
                    <h4><@s.text name="main.thrds.legend.gtitle" /></h4>
                </header>
                <div class="j-box-body jive-box-questionLegend">
                    <ul class="j-icon-list font-color-meta">
                        <#if (correctScenario.enabled)>
                            <li><span class="jive-icon-med jive-icon-discussion-correct"></span>
                            <@s.text name="forum.thrd.crrctAnswrAvail.text">
                            <@s.param><strong class="jive-thread-reply-message-correct-label"></@s.param>
                            <@s.param></strong></@s.param>
                            <@s.param>${correctScenario.points}</@s.param>
                            </@s.text>
                            </li>
                        </#if>
                        <#if (helpfulScenario.enabled)>
                            <li><span class="jive-icon-med jive-icon-discussion-helpful"></span>
                            <@s.text name="forum.thrd.helpful_answer.text">
                            <@s.param><strong class="jive-thread-reply-message-helpful-label"></@s.param>
                            <@s.param></strong></@s.param>
                            <@s.param>${helpfulScenario.points}</@s.param>
                            </@s.text>
                            </li>
                        </#if>
                    </ul>
                </div>
            </div>
        </#if>

        </div>
    </div>
    <!-- END small column -->


<#if action.isUserContainer(container)>
    <!-- BEGIN modals -->
    <div class="jive-modal" id="jive-modal-participants">
        <header><h2><@s.text name='thread.private.manage-participants.text' /></h2></header>
        <a href="#" class="j-modal-close-top close"><@s.text name="global.close"/> <span
                class="j-close-icon j-ui-elem"></span></a>
        <!-- Add a category modal -->
        <div id="jive-modal-content-container" class="jive-modal-content clearfix">
            <div id="jive-modal-scrollto-container">
                <div id="jive-modal-content-participants">

                    <form class="j-form">
                        <p><@s.text name='thread.private.manage-participants-desc.text' /></p>

                        <p class="ie-zindex-fix">
                            <input type="text" name="participants" id="participants" class="j-user-autocomplete j-ui-elem"/>
                        <@resource.javascript>
                            $j(document).ready(function() {
                            var temp = <@jive.userAutocompleteUsers users=participantBeans />;
                            var autocomplete = new jive.UserPicker.Main({
                            multiple: true,
                            listAllowed: true,
                            startingUsers: temp,
                            $input : $j("#participants")
                            });
                            });
                        </@resource.javascript>
                        </p>

                        <p>
                            <input type="submit" class="close" name="Finished"
                                   value="<@s.text name="global.finished" />" onclick="handleParticipantUpdate();"/>
                        </p>

                    </form>

                </div>

            </div>
        </div>


    </div>
    <!-- END modals -->

</#if>

</div>
<!-- END layout -->

</body>
</html>


<#macro outputMainBodyColumn>
<#-- outputs the main body column, used by both a request for the discussion and for posting a discussion message
using the inline discussion rte from and ajax call-->
<!-- BEGIN large column -->
<div class="j-column-wrap-l">
<div class="j-column j-column-l lg-margin">
<!-- moderation feedback message -->
    <#include "/template/global/include/form-message.ftl"/>
<!-- hidden div used in parsing of ajax response to indicate that we have a moderated message -->
    <#if parameters.newMsgModerated?exists>
        <div style="display:none" id="jive-moderated-message"></div>
    </#if>
    <div id="success-moderation-edit" class="jive-success-box" style="display:none"></div>
    <#if personalDisabled >
        <div class="jive-warn-box">
            <div>
                <span class="jive-icon-med jive-icon-warn"></span>
                <@s.text name="forum.thrd.personalDisabled.text" />
            </div>
        </div>
    </#if>

<div id="object-follow-notify" class="jive-info-box" style="display:none"></div>

<div id="content-featured-notify" class="jive-info-box" style="display:none"></div>

<@jive.showMovedMesage content=thread container=container/>

    <#if archived>
        <div id="jive-thread-archived"><span><strong><@s.text name="forum.thrd.thrdIsArchived.text" /></strong></span></div>
    <#elseif locked>
        <div id="jive-thread-locked"><span><strong><@s.text name="forum.thrd.thrdIsLocked.text" /></strong></span></div>
    </#if>

    <#if question??>
    <#-- get correct answer object -->
        <#assign answer = question.getCorrectAnswer()!>
    </#if>


<!-- BEGIN thread messages -->
<div id="jive-thread-messages-container" class="jive-thread-messages">

    <#if !messages.iterator().hasNext()>
        <div id="jive-thread-nomessage"><span><strong><@s.text name="forum.thrd.nomessages.text" /></strong></span></div>
    </#if>

    <#assign message = thread.rootMessage!/>
    <#if message?has_content && (message.status.visible || JiveContainerPermHelper.isContainerModerator(container) || thread.user.ID?c == user.ID?c)>

    <!-- BEGIN thread info -->
    <#assign paginator = newPaginator>
    <#assign branchParentId = thread.branchedParentThreadID/>
    <#assign branchId = thread.branchedThreadID/>
    <#--<#if (!threaded && (paginator.numPages > 1) && (paginator.previousPage)) || (!threaded && (paginator.numPages > 1)) || (branchParentId != -1) || (branchId != -1)>-->
        <div class="jive-thread-info clearfix j-rc4">
            <#if (!threaded && (paginator.numPages > 1))>
                <!-- BEGIN pagination-->
                            <span class="j-pagination">

                                <#list paginator.getPages(3) as page>
                                    <#if (page?exists)>
                                        <#if (page.start == start)>
                                            <a href="<@s.url value='/thread/${thread.ID?c}?start=${page.start?c}&tstart=${tstart}'/>" class="j-pagination-current font-color-normal"><strong>${page.number}</strong></a>
                                        <#else>
                                            <a href="<@s.url value='/thread/${thread.ID?c}?start=${page.start?c}&tstart=${tstart}'/>">${page.number}</a>
                                        </#if>
                                    <#else>
                                        <span class="ellipsis">&hellip;</span>
                                    </#if>
                                </#list>

                                <span class="j-pagination-prevnext">
                                    <#if (paginator.previousPage)>
                                        <a href="<@s.url value='/thread/${thread.ID?c}?start=${paginator.previousPageStart?c}&tstart=${tstart}'/>"
                                           title="<@s.text name="global.previous_page_title"/>"
                                           class="j-pagination-prev"><@s.text name="global.previous"/></a>
                                        <#else>
                                            <span class="j-pagination-prev j-disabled font-color-meta"><@s.text name="global.previous"/></span>
                                    </#if>
                                    <#if (paginator.nextPage)>
                                        <a href="<@s.url value='/thread/${thread.ID?c}?start=${paginator.nextPageStart?c}&tstart=${tstart}'/>"
                                           title="<@s.text name="global.next_page_title"/>"
                                           class="j-pagination-next"><@s.text name="global.next"/></a>
                                        <#else>
                                            <span class="j-pagination-next j-disabled font-color-meta"><@s.text name="global.next"/></span>
                                    </#if>
                                </span>
                            </span>
                <!-- END pagination -->
            </#if>

            <#if threadMessageCount-1 == 1>
                <strong class="font-color-meta j-thread-info-block">${threadMessageCount-1} <@s.text name="forum.thrd.reply.gtitle" /></strong>
            <#else>
                <strong class="font-color-meta j-thread-info-block">${threadMessageCount-1} <@s.text name="forum.thrd.replies.gtitle" /></strong>
            </#if>
            <span class=" j-thread-info-block font-color-meta">
                <a href="<#if (!threaded)><@s.url value='/message/'/>${thread.latestMessage.ID?c}?tstart=${tstart}</#if>#${thread.latestMessage.ID?c}" <#if ((threaded) || (!threaded && paginator.numPages == 1))>class="localScroll"</#if>><@s.text name="forum.thrd.last_post.link"/></a><@s.text name="global.colon"/>
                ${thread.latestMessage.modificationDate?datetime?string.medium_short} <@s.text name="forum.thrd.by.link" />
                    <#if thread.latestMessage.user?exists && !thread.latestMessage.user.anonymous>
                    <@jive.displayUserDisplayName user=thread.latestMessage.user />
                        <#else>
                            <i><@renderGuestDisplayName message=thread.latestMessage/></i>
                    </#if>
            </span>

            <#if (!threaded && (paginator.numPages > 1) && (paginator.previousPage))>
                <span class="j-thread-info-block font-color-meta"><a href="<@s.url value='/thread/'/>${thread.ID?c}?tstart=0"><@s.text name="thread.back_to_top.link"/></a></span>
            </#if>

            <#if branchParentId != -1>
                <span class="j-thread-info-block font-color-meta"><@s.text name="forum.thrd.branchedFrom.text"/> <a
                        href="<@s.url value='/thread/${branchParentId?c}'/>"><@s.text name="forum.thrd.branchedFrom.link"/></a>.</span>
            </#if>

            <#if branchId != -1>
                <span class="j-thread-info-block font-color-meta"><@s.text name="forum.thrd.branchedTo.text"/> <a
                        href="<@s.url value='/thread/${branchId?c}'/>"><@s.text name="forum.thrd.branchedTo.link"/></a>.</span>
            </#if>
            <#-- TODO: move Feeds to actions/notifications block in sidebar -->
            <#if FeedUtils.isFeedsEnabled()>
                <span><a href="<@s.url value='/community/feeds/messages' />?thread=${thread.ID?c}"><img class="jive-icon-sml jive-icon-rss" src="<@resource.url value='/images/transparent.png' />" alt="RSS" /></a></span>
            </#if>

            <#if !fromPrintPreview>
                <#if (canUnmarkAsQuestion && thread.status.visible)>
                    <@displayAnswerBar isMarkAsQuestion=false/>
                <#elseif (canMarkAsQuestion && thread.status.visible)>
                    <@displayAnswerBar isMarkAsQuestion=true />
                </#if>
            </#if>

        </div>
    <#--</#if>-->
    <!-- END thread info -->

    <!-- BEGIN original thread post -->
        <#if (threaded) || (!threaded && (!paginator.previousPage))> <#-- only show if threaded or page 1 of flat -->


        <div class="jive-content j-op j-rc4 <#if thread.status == enums['com.jivesoftware.community.JiveContentObject$Status'].AWAITING_MODERATION || thread.status == enums['com.jivesoftware.community.JiveContentObject$Status'].ABUSE_HIDDEN>
                j-thread-mod
                </#if>">

            <div class="j-thread-post j-rc4 <#if bridged> jive-thread-post-bridged</#if>">
                <span class="j-thread-pointer j-ui-elem"></span>

                <a name="${thread.ID?c}"></a><a name="${message.ID?c}"></a>

                <header class="js-original-header">

                    <h1>
                        <!-- BEGIN SYNCHRO -->
                        <!-- Changing the URL for the Disucssion to point it to Synchro based URL -->
                        <a href="javascript:void();">${action.renderSubjectToText(message)}</a>
                       <!-- <a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(message)}' />">${action.renderSubjectToText(message)}</a> -->
                        <!-- END SYNCHRO -->
                    </h1>

                <#-- header : author is a user. -->
                    <#if !message.user.anonymous>
                        <div class="j-post-avatar">
                            <#if message.properties['unknownsender']?exists >
                                <@jive.userAvatar user='' size=46 class='jive-avatar' />
                            <#else>
                                <@jive.userAvatar user=message.user size=46 class='jive-avatar'/>
                                <#if statusLevelEnabled>
                                    <@jive.userStatusLevel user=message.user/>
                                </#if>
                            </#if>
                        </div>
                                <span class="j-post-author">
                                    <#if message.properties['onbehalfof']?exists >
                                        <strong>${message.properties['onbehalfof']}</strong> ${message.modificationDate?datetime?string.medium_short}
                                    <#else>
                                        <strong><@jive.userDisplayNameLink user=message.user /></strong> ${message.modificationDate?datetime?string.medium_short}
                                    </#if>
                                </span>
                        <#else>
                        <#-- header : author is a guest. -->
                            <div class="j-post-avatar">
                            <@jive.userAvatar user='' size=46 class='jive-avatar'/>
                            </div>
                                <span class="j-post-author font-color-meta">
                                    <strong><@renderGuestDisplayName message=message/></strong> ${message.modificationDate?datetime?string.medium_short}
                                </span>
                    </#if>

                <#-- lists private recipients if this is a private discussion (isUserContainer) -->
                    <#if action.isUserContainer() >
                        <div class="jive-content-personal font-color-meta">
                            <strong><@s.text name="thread.private_to"/><@s.text name="global.colon"/></strong>
                            <!-- visible to specific people -->
                            <#assign viewers = action.getViewers(thread)>
                            <span class="jive-shared-list jive-shared-list-short">
                                        <!-- visible to specific people -->
                                        <img src="<@s.url value='/images/transparent.png'/>" title=""
                                             class="jive-icon-sml jive-icon-bookmark-private"/>
                                        <span id='jive-shared-list-short-users'>
                                          <#list viewers as user>
                                          <@jive.userDisplayNameLink user=user/><#if user_has_next>,</#if>
                                              <#if user_index == 4><#break></#if>
                                          </#list>
                                            <#if (viewers.size() > 5)>
                                                ... <!-- show max of 5, then do show/hide of rest -->
                                          (<a href="#"
                                              class="jive-shared-list-toggle jiveSharedShowAll"><@s.text name='forum.thrd.showall'/></a>)
                                            </#if>
                                        </span>
                                    </span>
                                    <span class="jive-shared-list jive-shared-list-all" style="display: none;">
                                        <img src="<@s.url value='/images/transparent.png'/>" title=""
                                             class="jive-icon-sml jive-icon-bookmark-private"/>
                                        <span id='jive-shared-list-all-users'>
                                          <#list viewers as user>
                                          <@jive.userDisplayNameLink user=user/><#if user_has_next>,</#if>
                                          </#list>
                                            &nbsp;(<a href="#"
                                                      class="jive-shared-list-toggle jiveSharedShowLess"><@s.text name='forum.thrd.showless'/></a>)
                                        </span>
                                    </span>
                        </div>
                    </#if>


                </header>
                <section class="j-original-message">
                    <div class="jive-thread-post-moderating"><span
                            class="jive-icon-med jive-icon-moderation"></span><@s.text name="mod.post_in_moderation.text" />
                    </div>
                    <#if message.properties['onbehalfof']?exists >
                        <div class="jive-outlook-generated">
                            <img src="<@s.url value='/images/tools/Office-icon.png'/>" class="jive-icon-med" alt="">
                            Posted on behalf of ${message.properties['onbehalfof']} by ${message.properties['postedby']}
                            via <a href="<@s.url value='/tools.jspa'/>">Jive for Outlook</a>
                        </div>
                    </#if>
                ${renderedPostBody}
                <#-- add bridged content if it exists -->
                    <#if bridged>
                    <@s.action name="view-bridged-content" executeResult="true" ignoreContextParams="true">
                    <@s.param name="object">${thread.ID?c}</@s.param>
                    <@s.param name="contentObjectType">${thread.objectType?c}</@s.param>
                    </@s.action>
                    </#if>

                <#-- Attachments -->
                <@jive.attachmentList resource=message titleKey='forum.thrd.attachments.gtitle'/>

                </section>

            <#-- Footer (tags, reply, views) -->
                <footer>

                <#-- Tags -->
                    <#assign allObjectTagNames = "">
                    <#assign objectTagSets = action.getObjectTagSets(message)>
                    <#assign canEditTags=MessagePermHelper.getCanEditMessage(thread.rootMessage) && !fromPrintPreview && JiveGlobals.getJiveBooleanProperty("jive.tags.editable", true)>
                    <#if canEditTags>
                    <@resource.javascript>
                        function tagModerationCallback(status) {
                        var modDiv = $j('.jive-thread-post-mod');

                        if(!modDiv || modDiv.length == 0) {
                        $j('.jive-thread-post').toggleClass('jive-thread-post-mod');
                        $j('.jive-thread-post-moderating').show();

                        $j('.jive-thread-reply').removeClass().addClass('jive-thread-reply-mod clearfix');
                        $j('.jive-reply').hide();
                        }
                        }
                    </@resource.javascript>
                    </#if>

                    <ul class="clearfix">
                    <#-- View Count -->
                        <li class="j-footer-left font-color-meta">
                        <@jive.displayViewCount viewCount=thread.viewCount containerClass='jive-content-footer-item'/>
                        </li>

                    <#-- Tags -->
                        <li class="j-footer-left font-color-meta">
                        <@viewAndEditTags tags=thread.tagDelegator.tags entityDescriptor=thread container=container user=user canEditTags=canEditTags fromPrintPreview=fromPrintPreview/>
                        </li>

                    <#-- Categories -->
                        <#if (objectTagSets.hasNext()) >
                            <li class="j-footer-left font-color-meta">
                                <span class="jive-content-footer-item">
                                    <span class="jive-icon-med jive-icon-folder"></span><@s.text name="global.categories" /><@s.text name="global.colon" /> <#list objectTagSets as tagSet> ${tagSet.name?html}<#if objectTagSets.hasNext()>
                                    , </#if></#list>
                                </span>
                            </li>
                        </#if>

                    <#-- Reply link -->
                        <#if canCreateMessage || container.objectType == JiveConstants.SOCIAL_GROUP>
                        <@outputReplyAndJoinGrpLnks message=message thread=thread messageSubject="${message.subject}" isOriginal=true/>
                        </#if>

                    </ul>


                </footer>

                <div class="jive-thread-ratings clearfix">
                <@jive.ratings container thread "thread"/>
                </div>


            </div>
        </div>

        </#if>
    <!-- END original thread post -->

        <#else>

        <#-- The root message must have been hidden, let the user know -->
        <div id="jive-thread-nomessage"><span><strong><@s.text name="forum.thrd.norootmessage.text" /></strong></span>
        </div>

    </#if>

    <#if threaded>
        <#list action.getChildren(message) as child> <#-- important to not use treeWalker here, as we need the db tree walker in this action method -->
        <@outputMessage message=child threaded=threaded treeWalker=treeWalker itemIndex=child_index itemHasNext=child_has_next/>
        </#list>
        <#else>
            <#list messages as message>
                <#if (message.parentMessage?exists)>
                    <#if (!paginator.previousPage)>
                    <#-- itemIndex is less than message_index because we're ignoring the root message  -->
                    <@outputMessage message=message threaded=threaded treeWalker=treeWalker itemIndex=message_index-1 itemHasNext=message_has_next/>
                        <#else>
                        <@outputMessage message=message threaded=threaded treeWalker=treeWalker itemIndex=message_index itemHasNext=message_has_next/>
                    </#if>

                </#if>
            </#list>
    </#if>

    <#assign paginator = newPaginator>
    <#if (!threaded && (paginator.numPages > 1))>
    <!-- BEGIN thread info -->
    <div class="jive-thread-info clearfix j-rc4">

        <!-- BEGIN pagination-->
                    <span class="j-pagination">
                        <#list paginator.getPages(3) as page>
                            <#if (page?exists)>
                                <#if (page.start == start)>
                                    <a href="<@s.url value='/thread/${thread.ID?c}?start=${page.start?c}&tstart=${tstart}'/>" class="j-pagination-current font-color-normal"><strong>${page.number}</strong></a>
                                <#else>
                                    <a href="<@s.url value='/thread/${thread.ID?c}?start=${page.start?c}&tstart=${tstart}'/>">${page.number}</a>
                                </#if>
                            <#else>
                                <span class="ellipsis">&hellip;</span>
                            </#if>
                        </#list>
                        <span class="j-pagination-prevnext">
                            <#if (paginator.previousPage)>
                                <a href="<@s.url value='/thread/${thread.ID?c}?start=${paginator.previousPageStart?c}&tstart=${tstart}'/>"
                                   title="<@s.text name="global.previous_page_title"/>"
                                   class="j-pagination-prev"><@s.text name="global.previous"/></a>
                                <#else>
                                    <span class="j-pagination-prev j-disabled font-color-meta"><@s.text name="global.previous"/></span>
                            </#if>
                            <#if (paginator.nextPage)>
                                <a href="<@s.url value='/thread/${thread.ID?c}?start=${paginator.nextPageStart?c}&tstart=${tstart}'/>"
                                   title="<@s.text name="global.next_page_title"/>"
                                   class="j-pagination-next"><@s.text name="global.next"/></a>
                                <#else>
                                    <span class="j-pagination-next j-disabled font-color-meta"><@s.text name="global.next"/></span>
                            </#if>
                        </span>
                    </span>
        <!-- END pagination -->
    </div>
    <!-- END thread info -->
    </#if>


<#-- If there are more than 3 replies, show a "reply to original" link -->
    <#if (threadMessageCount > 2)>
    <div id="jive-thread-reply-footer" class="clearfix">
        <#if ((threaded) || (!paginator.previousPage))>
            <a href="#${thread.ID?c}" class="localScroll"><span
                    class="jive-icon-sml jive-icon-arrow-top"></span><@s.text name="thread.back_to_top.link"/></a>
            <#else>
                <a href="<@s.url value='/thread/'/>${thread.ID?c}?tstart=0"><span
                        class="jive-icon-sml jive-icon-arrow-top"></span><@s.text name="thread.back_to_top.link"/></a>
        </#if>
        <#if canCreateMessage && (!personalDisabled)>
        <#-- post body hidden here as workaround for quoting post in replies after first page -->
            <div class="jive-rendered-content" style="display:none">${renderedPostBody}</div>
            <strong>
            <@replyLink message="" thread=thread isOriginal=true domID="jive-thread-reply-footer-link-orginal">
                <span class="jive-icon-med jive-icon-comment-add"></span><@s.text name="thread.reply_to_original.link"/>
            </@replyLink>
            </strong>
            <#elseif container.objectType == JiveConstants.SOCIAL_GROUP && !SocialGroupPermHelper.getCanContributeToSocialGroup(container, user) && SocialGroupPermHelper.getCanJoinSocialGroup(container, user)>
                <strong>
                    <a class="jive-link-joinSocialGroup" href="#"><@s.text name='sgroup.join.reply'/> </a>
                </strong>
        </#if>
    </div>
    </#if>


</div>
<!-- END messages -->

</div>
</div>
<!-- END large column -->
</#macro>

<#macro renderGuestDisplayName message>
    <#assign guestName = message.getProperties().get("name")?default('')>
    <#assign guestEmail = message.getProperties().get("email")?default('')>
    <#if guestName?has_content>
    ${guestName?html}
        <#elseif guestEmail?has_content>
        ${guestEmail?html}
        <#else>
        ${action.getText("global.guest")}
    </#if>
</#macro>

<#macro outputReplyAndJoinGrpLnks message thread messageSubject isOriginal=false>
    <#if canCreateMessage && (!personalDisabled)>
    <#local mID = "${message.ID?c}" />
   <!-- BEGIN SYNCHRO -->
   <!-- Changed By Tejinder as on Reply link for the messages the links were not getting created properly. So using the Advanced Editor by default -->
   <#-- <li><strong><@replyLink message thread isOriginal><span class="jive-icon-med jive-icon-comment-add"></span><@s.text name="global.reply"/></@replyLink></strong></li>-->
    <li><strong><a href="/synchro/synchro-createDiscussion!reply.jspa?message=${mID}<#if backURL?? >&viewAll=viewAll</#if>"><@s.text name="global.reply"/></a></strong></li>
    <!-- END SYNCHRO -->
    </#if>
</#macro>

<#macro replyLink message thread isOriginal=false domID="">
    <#if isOriginal>
        <#assign author = thread.user/>
        <#local replyParamName="thread" replyParamValue="${thread.ID?c}" />
        <#local usernameParam><#if (user.ID == author.ID)>${user.username}<#else><@jive.displayUserDisplayName user=author /></#if></#local>
        <#local isAnonymous><#if (thread.user.anonymous)>true<#else>false</#if></#local>
        <#local msgID = "${thread.rootMessage.ID?c}" />
    <#else>
        <#assign author = message.user/>
        <#local replyParamName="message" replyParamValue="${message.ID?c}"/>
        <#local usernameParam><#if (user.ID == author.ID)>${user.username}<#else><@jive.displayUserDisplayName user=author /></#if></#local>
        <#local isAnonymous><#if (message.user.anonymous)>true<#else>false</#if></#local>
        <#local msgID = "${message.ID?c}" />
    </#if>

<!-- BEGIN SYNCHRO -->
<!-- Changed the URl for creating the discussion -->
<a class="discussionAdd"
   <#if domID != "">id="${domID?html}"</#if>
   data-isAnonymous="${isAnonymous?string}"
   data-replySubject="${replySubject?html}"
   data-advEditorLnk="<@s.url action='synchro-createDiscussion' method='reply'><@s.param name='${replyParamName}' value='${replyParamValue}'/></@s.url>"
   data-discussionusername="${usernameParam?html}"
   data-messageID="${msgID}"
   data-isReply="${(!isOriginal)?string}"
   title="<@s.text name='forum.thrd.rplyToThsMsg.tooltip'/>">
    <#nested>
</a>
</#macro>
<!-- END SYNCHRO -->

<#-- Loads the necessary JavaScript dependencies for the discussions macro -->
<#macro discussionsDependencies>
<@resource.javascript file="/resources/scripts/jive/i18n.js" />
<@resource.javascript file="/resources/scripts/jive/action.js"/>
<@resource.javascript file="resources/scripts/apps/shared/models/rest_service.js" />
<@resource.javascript file="resources/scripts/apps/shared/models/nested_rest_service.js" />
<@resource.javascript file="/resources/scripts/apps/comment_app/models/comment.js" />
<@resource.javascript file="/resources/scripts/apps/shared/views/rte_view.js" />
<@resource.javascript file="/resources/scripts/apps/shared/views/form_waiting_view.js"/>
<@resource.javascript file="/resources/scripts/apps/comment_app/views/form_view.js" />
<@resource.javascript file="/resources/scripts/apps/comment_app/views/edit_form_view.js" />
<@resource.javascript file="/resources/scripts/apps/comment_app/views/comment_view.js" />
<@resource.javascript file="/resources/scripts/apps/discussion_app/models/discussion.js" />
<@resource.javascript file="/resources/scripts/apps/discussion_app/models/discussion_source.js" />
<@resource.javascript file="/resources/scripts/apps/discussion_app/models/question_source.js" />
<@resource.javascript file="/resources/scripts/apps/discussion_app/views/discussion_view.js" />
<@resource.javascript file="/resources/scripts/apps/discussion_app/views/discussion_list_view.js" />
<@resource.javascript file="/resources/scripts/apps/discussion_app/views/question_view.js" />
<@resource.javascript file="resources/scripts/apps/discussion_app/main.js" />
<@resource.template file="/soy/shared/display_utils.soy"/>
<@resource.template file="/soy/discussions/discussions-question.soy"/>
<@resource.template file="/soy/discussion_app/messages.soy"/>
<@resource.template file="/soy/shared/form_waiting_view.soy" />
<@resource.dwr file="WikiTextConverter" />
</#macro>

<#macro initDiscusssionsJS>
<@discussionsDependencies/>

    <#assign isWikiImagesEnabled = WikiUtils.isWikiImageSyntaxEnabled(container) && action.hasPermissionsToUploadImages()>
    <#assign toggleDisplay><@s.text name="rte.toggle_display" /></#assign>
    <#assign editDisabled><@s.text name="rte.edit.disabled" /></#assign>
    <#assign editDisabledSummary><@s.text name="rte.edit.disabled.desc" /></#assign>
    <#assign alwaysUse><@s.text name="post.alwaysUseThisEditor.tab" /></#assign>

<@resource.javascript>
/*********************************************
* autosave settings and initialization for discussion/question replies
*********************************************/
(function(){
    <#if (draftEnabled && !rteDisabledBrowser)>
    <#--var enabled = ${(!draftExists)?string};-->
    var interval = ${jiveContext.draftManager.autosaveInterval?c};
    var draftType = ${JiveConstants.MESSAGE};
    var objectType = ${JiveConstants.THREAD};
    var objectID = ${message.forumThreadID?c};
    var body = 'wysiwygtext';
    var subject = 'subject01';
    var properties = [];
    var images = [];
        <#assign globalUnsavedChangesText><@s.text name="global.unsaved_changes.text" /></#assign>
    var confirmationMessage = '${globalUnsavedChangesText?js_string}';
        <#assign forumPostSaveAndEditText><@s.text name="forum.post.save_and_edit.text" /></#assign>
    var saveMessage = '${forumPostSaveAndEditText?js_string}';
        <#assign forumPostSaveAndEditText><@s.text name="forum.post.save_and_edit.text" /></#assign>
    var savedMessage = '${forumPostSaveAndEditText?js_string}';
    window.autoSave = new JiveAutoSave(false, interval, draftType, objectType, objectID, body, subject, images, properties, confirmationMessage, saveMessage, savedMessage);
        <#else>
        window.autoSave = new DummyAutoSave(false);
    </#if>
})();
/*********************************************
* done setting up autosave
*********************************************/
(function() {
var options = {
    draftExists:        ${draftExists?string},
    isModerated:        ${messageModerationOn?string},
    isThreaded:         ${threaded?string},
    resourceType:       ${thread.objectType?c},
    resourceID:         ${thread.ID?c},

    containerType:      ${container.objectType?c},
    containerID:        ${container.ID?c},

    listAction:         "<@s.url action="comment-list"/>",
    resourceVersionID:  -1,

    preferredMode:      '<#if rteDisabledBrowser>rawhtml<#else>${preferredEditorMode}</#if>',
    currentMode:        '<#if rteDisabledBrowser>rawhtml<#else>${preferredEditorMode}</#if>',
    rteDisabledBrowser: <#if rteDisabledBrowser>true<#else>false</#if>,
        <#if sort??>
        sort:               '${sort?js_string}',
        </#if>
    isAnonymous:        <#if authentication.anonymous>true<#else>false</#if>,

    question:           <#if question?? && question!=''>true<#else>false</#if>,
    imagesEnabled:      <#if isWikiImagesEnabled && JiveGlobals.getJiveBooleanProperty("image.enabled", true)>true<#else>false</#if>,
    rteOptions : {
        controller    : jiveControl,
        preset        : "mini-w-quote",
        autoSave      : autoSave,
        preferredMode : "${preferredEditorMode}",
        startMode     : "${preferredEditorMode}",
        mobileUI      : <#if rteDisabledBrowser>true<#else>false</#if>,
        toggleText    : '${toggleDisplay?js_string}',
        alwaysUseTabText : '${alwaysUse?js_string}',
        editDisabledText : '${editDisabled?js_string}',
        editDisabledSummary : '${editDisabledSummary?js_string}',
        communityName : '${SkinUtils.getCommunityName()?js_string}',
        height        : 300,
        imagePickerUrl : _jive_base_url + "/post!imagePicker.jspa?containerType=${container.objectType?c}&container=${container.ID?c}&message=${(message.ID?c)!-1}&postedFromGUIEditor=true&reply=true",
        destroyImagePickerUrl : _jive_base_url + "/image-picker!clean.jspa"
    },
    i18n: {
        <#assign postSuccessText><@s.text name="post.msgPostedSuccessfully.text" /></#assign>
    postSuccessText:         '${postSuccessText?js_string}',
        <#assign postErrorText><@s.text name="post.err.inline.text" /></#assign>
    postErrorText:           '${postErrorText?js_string}',
        <#assign forumThrdReplyToVal><@s.text name="forum.thrd.replyTo" /></#assign>
    forumThrdReplyTo:        '${forumThrdReplyToVal?js_string}',

    // Question text for discussions-question.soy
        <#assign questionNotAnswered><@s.text name="question.state.not_answered.text"/></#assign>
    questionNotAnswered:     '${questionNotAnswered?js_string}',
        <#assign markQuestionAsAssumedAnswered><@s.text name="question.mark_as_assmd_answrd"/></#assign>
    markQuestionAsAssumedAnswered: '${markQuestionAsAssumedAnswered?js_string}',
        <#assign questionAssumedAnswered><@s.text name="question.state.assumed_answered.text" /></#assign>
    questionAssumedAnswered: '${questionAssumedAnswered?js_string}',
        <#assign questionAnswered><@s.text name="question.state.answered.text" /></#assign>
    questionAnswered: '${questionAnswered?js_string}',
        <#assign correctAnswer><@s.text name="forum.thrd.correct_answer.link" /></#assign>
    correctAnswer: '${correctAnswer?js_string}',
        <#assign helpfulAnswer><@s.text name="forum.thrd.helpful_answer.link" /></#assign>
    helpfulAnswer: '${helpfulAnswer?js_string}',
        <#assign helpfulAnswers><@s.text name="question.helpfulAnswers.text" /></#assign>
    helpfulAnswers: '${helpfulAnswers?js_string}',
        <#assign byWord><@s.text name="global.by" /></#assign>
    byWord: '${byWord?js_string}&nbsp;',
        <#assign onWord><@s.text name="global.on" /></#assign>
    onWord: '&nbsp;${onWord?js_string}&nbsp;',
        <#assign leftParen><@s.text name="global.left_paren" /></#assign>
    leftParen: '${leftParen?js_string}',
        <#assign rightParen><@s.text name="global.right_paren" /></#assign>
    rightParen: '${rightParen?js_string}',
        <#assign unmarkAsCorrectAnswer><@s.text name="question.unmarkAsCorrect.link" /></#assign>
    unmarkAsCorrectAnswer: '${unmarkAsCorrectAnswer?js_string}',
        <#assign unmarkAsHelpfulAnswer><@s.text name="question.unmarkAsHelpful.link" /></#assign>
    unmarkAsHelpfulAnswer: '${unmarkAsHelpfulAnswer?js_string}',
        <#assign seeAnswerInContext><@s.text name="question.seeAnswerInContext.text" /></#assign>
    seeAnswerInContext: '${seeAnswerInContext?js_string}',
        <#assign seeThisAnswer><@s.text name="question.seeThisAnswer.text" /></#assign>
    seeThisAnswer: '${seeThisAnswer?js_string}',
        <#assign allHelpfulAnswersAwarded><@s.text name="question.allHelpfulAnswersAwarded.text"/></#assign>
    allHelpfulAnswersAwarded: '${allHelpfulAnswersAwarded?js_string}',
        <#assign oneHelpfulAnswerLeft><@s.text name="question.oneHelpfulAnswerLeft.text"/></#assign>
    oneHelpfulAnswerLeft: '${oneHelpfulAnswerLeft?js_string}',
        <#assign someHelpfulAnswersLeft><@s.text name="question.someHelpfulAnswersLeft.text"/></#assign>
    someHelpfulAnswersLeft: '${someHelpfulAnswersLeft?js_string}',
    postUserWroteLabel: '${action.getText("post.user_wrote.label")?js_string}',
    postGuestWroteLabel: '${action.getText("post.guest_wrote.label")?js_string}',
    formSubmitPleaseWait:'${action.getText("we.form.submit.pleaseWait")?js_string}',
    postReplyMustBeApprvdText:'${action.getText("post.reply_must_be_apprvd.text")?js_string}',
    globalLoginRequired:'${action.getText("global.login.required")?js_string}',
    advEditor:'${action.getText("forum.thrd.useAdvancedEditor")?js_string}'
}
};

// Create DiscusssionApp
var discussisons = new jive.DiscussionApp.Main(options);
})();
</@resource.javascript>
</#macro>

<#macro miniRteDiscussion thread comment container replySubject partialURL name="discussionBody" reply=true>
<@outputTokenFormInput thread=thread message="" container=container isInline=true />


    <#if (draftExists)>
    <div class="jive-warn-box">
        <div>
            <span class="jive-icon-med jive-icon-warn"></span>
        <@s.text name="post.draft.draft_exists.info"><@s.param>${draft.modificationDate?datetime?string.medium_short}</@s.param></@s.text>
            <br/>
            <input type="button" class="jive-description" name="useDraft"
                   value="<@s.text name="post.draft.useRcvrdDraft.button" />"
                   onclick="autoSave.useDraft('updateMessageFromDraft'); return false;"/>
            <input type="button" class="jive-description" name="deleteDraft"
                   value="<@s.text name="post.draft.delRcvrdDraft.button" />"
                   onclick="autoSave.deleteDraft(); return false;"/>
        </div>
    </div>
    </#if>
<@outputFormElemStartTagReply partialURL=partialURL isInline=true/>
<@outputFormInput edit=false thread=thread reply=reply/>
<@outputMessageFormInput message=false isInline=true/>
<input type="hidden" name="postedFromGUIEditor" id="postTypeFlag" value="false"/>
<@outputErrorMsgs/>
<@outputSubjectForm isInline=true replySubject=message.subject/>

<#-- todo: (for Greg S) - the below should probably be pulled out now that we have the new answer button workflow -->
<@outputQuestionAnsForm reply=reply message=message thread=thread MessagePermHelper=MessagePermHelper isInline=true/>

<textarea name="body" rows="10" class="jive-comment-textarea"></textarea>

<#-- add in the bridge replies if there are any -->
    <#if (thread?? && action.hasBridgedDiscussion(thread))>
        <#assign actionUrl><@s.url action='synchro-createDiscussion' method='bridgedContentReply'/></#assign>
    <@jive.bridgedContentReply thread container actionUrl reply false true/>
    </#if>

<div>
    <input type="submit" name="synchro-createDiscussion" class="jive-form-button-save j-btn-callout" value="<@s.text name="forum.thrd.addReply" />"/>
    <#if (draftEnabled)>
        <input type="hidden" name="draftid" id="draftid" value="0"/>
    </#if>
    <input type="button" name="cancel" class="jive-form-button-cancel" value="<@s.text name="forum.thrd.cancel" />"/>
</div>
</form>
</#macro>

<#-- Display answer bar, now only to let you mark discussion as question or vice versa within     -->
<#-- com.jivesoftware.community.action.MarkAsQuestionAction.TIME_LIMIT minutes of creating thread.-->
<#macro displayAnswerBar isMarkAsQuestion=true>
<!-- BEGIN answer bar -->
<div id="jive-answer-bar" class="font-color-meta clearfix">
    <#if isMarkAsQuestion>
        <#if JiveContainerPermHelper.isContainerAdmin(container)>
            <@s.text name="question.markAsQuestionAdmin.text">
                <@s.param><a id="jive-mark-question" href="<@s.url value="/markquestion!input.jspa" />?thread=${thread.ID?c}"></@s.param>
                <@s.param></a></@s.param>
            </@s.text>
        <#else>
            <#-- Is this a question? You have X minutes left to <a href="#">mark this discussion as a question</a>. -->
            <@s.text name="question.timeLmtToMarkAsQ.text">
                <@s.param>${statics['com.jivesoftware.community.action.MarkAsQuestionAction'].TIME_LIMIT}</@s.param>
                <@s.param><a id="jive-mark-question" href="<@s.url value="/markquestion!input.jspa" />?thread=${thread.ID?c}"></@s.param>
                <@s.param></a></@s.param>
            </@s.text>
        </#if>
    <#else>
        <#if JiveContainerPermHelper.isContainerAdmin(container)>
            <@s.text name="question.unMarkAsQuestionAdmin.text">
                <@s.param><a href="<@s.url value="/unmarkquestion!input.jspa" />?thread=${thread.ID?c}"></@s.param>
                <@s.param></a></@s.param>
            </@s.text>
        <#else>
            <#-- You have X minutes to <a href="#">un-mark this discussion as a question</a> if you didn't mean to mark it as such. -->
            <@s.text name="question.youHaveXMinutes.text">
                <@s.param>${statics['com.jivesoftware.community.action.MarkAsQuestionAction'].TIME_LIMIT}</@s.param>
                <@s.param><a href="<@s.url value="/unmarkquestion!input.jspa" />?thread=${thread.ID?c}"></@s.param>
                <@s.param></a></@s.param>
            </@s.text>
        </#if>
    </#if>

</div>
<!-- END answer bar -->
</#macro>

<#macro renderByline messageUser message threaded>
    <#assign parent = message.parentMessage!>
<span class="j-post-author ">
        <#-- User name -->

            <strong>
                <#if !messageUser.anonymous>
                   <!-- Office can post messages on behalf of someone who's not in the system -->
                   <!-- Add a link to their email address if this is the case -->
                   <#if message.properties['onbehalfof']?exists >
                        ${message.properties['onbehalfof']}
                    <#else>
                        <@jive.userDisplayNameLink user=messageUser />
                   </#if>
                <#else>
                    <@renderGuestDisplayName message=message/>
                </#if>
            </strong>

        <#-- Post date -->
        ${message.modificationDate?datetime?string.medium_short}


        <#-- In reply to... -->
            <#if parent?has_content && !parent.user.anonymous>
                <span class="font-color-meta-light j-thread-replyto">
                    <@s.text name="global.left_paren"/><a
                        href="<#if (!threaded)><@s.url value="/message/" />${parent.ID?c}</#if>#${parent.ID?c}"
                        title="<@s.text name="global.go_to_message" />"
                        class="font-color-meta-light <#if (threaded)>localScroll</#if>"><@s.text name="global.in_response_to">
                <@s.param>
                     <#if parent.properties['onbehalfof']?exists >
                        ${parent.properties['onbehalfof']}
                     <#else>
                        <@jive.displayUserDisplayName user=parent.user />
                     </#if>
                </@s.param>
                </@s.text></a><@s.text name="global.right_paren"/>
                </span>
            <#elseif parent?has_content && parent.user.anonymous>
                <span class="font-color-meta-light j-thread-replyto">
                <@s.text name="global.left_paren"/><a
                    href="<#if (!threaded)><@s.url value="/message/" />${parent.ID?c}</#if>#${parent.ID?c}"
                    title="<@s.text name="global.go_to_message" />"
                    class="font-color-meta-light <#if (threaded)>localScroll</#if>"><@s.text name="global.in_response_to">
                    <@s.param><@jive.renderGuestDisplayName parent/></@s.param>
                </@s.text></a><@s.text name="global.right_paren"/>
                </span>
            </#if>

        
    </span>

</#macro>


<#macro outputMessage message threaded treeWalker itemIndex=-1 itemHasNext=false>
    <#assign messageUser = action.getProxiedUser(message.user)/>
<!-- BEGIN reply -->
<@outputIndentDiv threaded=threaded treeWalker=treeWalker item=message itemID="${message.ID?c}" itemIndex=itemIndex itemHasNext=itemHasNext>

    <#if (message.status.visible || JiveContainerPermHelper.isContainerModerator(container) || messageUser.ID?c == user.ID?c) && (message.status != enums['com.jivesoftware.community.JiveContentObject$Status'].REJECTED)>
    <div id="thread-message-${message.ID?c}" class="jive-thread-message clearfix">

        <#assign checkMod=""/>
        <#if message.status == enums['com.jivesoftware.community.JiveContentObject$Status'].AWAITING_MODERATION>
            <#assign checkMod="j-thread-mod ">
        <#elseif message.status == enums['com.jivesoftware.community.JiveContentObject$Status'].ABUSE_HIDDEN>
            <#assign checkMod="j-thread-mod ">
        </#if>
            <div class="js-thread-post-wrapper j-thread-post-wrapper j-rc4 ${checkMod}<#if (messageUser.ID == user.ID)>j-you </#if><#if (messageUser.ID == message.forumThread.user.ID)>j-op </#if> jive-content">

        <div class="j-thread-post  j-rc4" id="${message.ID?c}">

            <span class="j-thread-pointer j-ui-elem"></span>
            <a name="${message.ID?c}"></a>

            <header>

                <h6>
                    <strong>
                    <#-- Index (if flat )-->
                        <#if (!threaded)>
                            <#assign messageIndex = (start + itemIndex) />
                            <#if (!paginator.previousPage)><#assign messageIndex = (messageIndex+1) /></#if>
                            <a class="font-color-meta-light"
                               href="<@s.url value='/message/${message.ID?c}#${message.ID?c}'/>"
                               title="<@s.text name='forum.thrd.linkToReply.tooltip'/> #${messageIndex}"
                               class="jive-thread-reply-num font-color-meta-light">${messageIndex}.</a>
                        </#if>

                        <#assign msgSubject="${action.renderSubjectToText(message)}"/>
                        <a class="font-color-meta-light"
                           href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(message)}' />">${msgSubject}</a>
                    </strong>
                </h6>


                <div class="j-post-avatar">
                    <#if message.properties['unknownsender']?exists >
                        <@jive.userAvatar user='' size=46 class='jive-avatar' />
                    <#else>
                        <@jive.userAvatar user=messageUser size=46 class='jive-avatar'/>
                        <#if statusLevelEnabled && !messageUser.anonymous>
                            <@jive.userStatusLevel user=messageUser/>
                        </#if>
                    </#if>
                </div>

            <@renderByline messageUser message threaded />

            </header>
            <section>
                <div class="jive-thread-post-moderating"><span
                        class="jive-icon-med jive-icon-moderation"></span><@s.text name="mod.post_in_moderation.text" />
                </div>


                        <#if message.properties['onbehalfof']?exists >
                            <div class="jive-outlook-generated">
                                <img src="<@s.url value='/images/tools/Office-icon.png'/>" class="jive-icon-med" alt="">
                                Posted on behalf of ${message.properties['onbehalfof']}
                                by ${message.properties['postedby']} via <a href="/tools.jspa">Jive for Outlook</a>
                            </div>
                        </#if>

                    ${action.renderToHtml(message)}
                        <@jive.attachmentList resource=message titleKey='forum.thrd.attachments.gtitle'/>

            </section>

            <footer>
                <ul class="clearfix">

                    <#if MessagePermHelper.getCanEditMessage(message)>
                       <!--<li><a href="<@s.url value='/' />message/${message.ID?c}/edit"><span
                                class="jive-icon-sml jive-icon-edit"></span><@s.text name="forum.thrd.edit.link" /></a>
                        </li>-->
                        <!-- BEGIN SYNCHRO -->
                        <!-- Changes made in the URL for Edit Discussion -->
                        <li><a href="<@s.url value='/' />synchro/message/${message.ID?c}/synchro-editDiscussion<#if backURL?? >/viewAll</#if>"><span
                                class="jive-icon-sml jive-icon-edit"></span><@s.text name="forum.thrd.edit.link" /></a>
                        </li>
                        <!-- END SYNCHRO -->
                    </#if>
                    <!-- BEGIN SYNCHRO -->
                    <!-- Changes made in the Url for making it compatible with Synchro Urls -->
                    <#if MessagePermHelper.getCanDeleteMessage(message)>
                        <li class="js-link-delete"><a
                                href="<@s.url action='synchro-deleteDiscussion' method='input'><@s.param name='message' value='${message.ID?c}'/><@s.param name='start' value='${start?c}'/><@s.param name='tstart' value='${tstart?c}'/></@s.url>"><span
                                class="jive-icon-sml jive-icon-delete"></span><@s.text name="global.delete" /></a></li>
                    </#if>
                    <!-- END SYNCHRO -->
                    
                    <#if MessagePermHelper.getCanBranchMessage(message)  && (message.status != enums['com.jivesoftware.community.JiveContentObject$Status'].ABUSE_HIDDEN)>
                        <li class="js-link-branch"><a
                                href="<@s.url action='thread-branch' method='input'><@s.param name='message' value='${message.ID?c}'/></@s.url>"><span
                                class="jive-icon-sml jive-icon-discussion-branch"></span><@s.text name="forum.thrd.branch.link" />
                        </a></li>
                    </#if>
                    <#if (jiveContext.getAbuseManager().isReportAbuseEnabled() && (user.ID != messageUser.ID) && (message.status != enums['com.jivesoftware.community.JiveContentObject$Status'].ABUSE_HIDDEN))>
                        <#if (!jiveContext.getAbuseManager().hasUserReportedAbuse(message, user))>
                            <li class="js-link-abuse"><a
                                    href="<@s.url action='message-abuse' method='input'><@s.param name='objectID' value='${message.ID?c}'/><@s.param name='objectType' value='${message.objectType?c}'/></@s.url>"><span
                                    class="jive-icon-sml jive-icon-warn"></span><@s.text name="forum.thrd.abuse.link" />
                            </a></li>
                            <#else>
                                <li><span><span
                                        class="jive-icon-sml jive-icon-warn"></span><@s.text name="forum.thrd.abuse_reported.link" /></span>
                                </li>
                        </#if>
                    </#if>

                <#-- Hide 'Like' and 'Reply' buttons for messages that are hidden due to reported abuse  -->
                    <#if message.status != enums['com.jivesoftware.community.JiveContentObject$Status'].ABUSE_HIDDEN>
                        <li class="discussion-message-acclaim"><@jive.acclaim object=message ratingType="like" containerClass="discussion-message-acclaim"/></li>

                    <@outputReplyAndJoinGrpLnks message=message thread=thread messageSubject=msgSubject/>
                        <#else>
                            <li class="font-color-meta"><a
                                    href="<@s.url value="/actions/moderation"/>"><span
                                    class="jive-icon-sml jive-icon-moderation"></span><@s.text name="mod.link.approve_or_reject"/>
                            </a></li>
                    </#if>

                </ul>
            </footer>


        </div>

    </div>
    </div>

        <#elseif threaded && !treeWalker.isLeaf(message)>
        <#-- need to show a stub message so the children can be listed from it -->
            <div id="thread-message-${message.ID?c}" class="jive-thread-message clearfix">
                <div class="jive-thread-reply-mod jive-thread-reply-hidden clearfix">
                    <div class="jive-thread-reply-body font-color-meta">
                    <@s.text name="forum.thrd.nomessage.text"/>
                    </div>
                </div>
            </div>
    </#if>

    <#if threaded && !treeWalker.isLeaf(message)>
    <#-- recursivly output children -->
        <#list action.getChildren(message) as child>
        <#-- important to not use treeWalker here, as we need the db tree walker in this action method -->
        <@outputMessage message=child threaded=threaded treeWalker=treeWalker itemIndex=child_index itemHasNext=child_has_next/>
        </#list>
    </#if>


</@outputIndentDiv>
    <!-- END reply -->
</#macro>
