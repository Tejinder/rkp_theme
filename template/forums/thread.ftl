<#-- @ftlvariable name="" type="com.jivesoftware.community.action.ThreadActionSupport" -->
<#include "/template/global/include/jive-search-macros.ftl"/>
<#include "/template/global/include/discussion-comment-thread-common.ftl"/>
<#include "/template/global/include/tag-macros.ftl"/>
<#include "/template/forums/include/forum-postform-common.ftl">
<#include "/template/forums/include/forum-macros.ftl"/>

<@assignGlobals />

<html>
<head>

<title>${action.renderSubjectToHtml(thread.rootMessage)?html}</title>
<meta name="titleEscaped" content="true"/>
<#assign metaContent = action.getMetaInfo() />
<meta name="description" content="${metaContent!?html}" />

<link rel="stylesheet" href="<@resource.url value='/styles/jive-content.css'/>" type="text/css" media="all"/>
<#if bridgingEnabled>
<link rel="stylesheet" href="<@resource.url value='/styles/jive-bridges.css'/>" type="text/css" media="all"/>
</#if>
<link rel="stylesheet" href="<@resource.url value='/styles/tiny_mce3/themes/advanced/skins/default/content.css'/>"
      type="text/css" media="all"/>
<link rel="stylesheet" href="<@resource.url value='/styles/jfo.css'/>" type="text/css" media="all">

<#if (FeedUtils.isFeedsEnabled())>
    <#if (container.objectType == JiveConstants.COMMUNITY)>
    <link rel="alternate" type="${FeedUtils.getFeedType()}"
          title=" ${container.name?html} <@s.text name='forum.thrd.dscThrdsFeed.tooltip' />"
          href="<@s.url value='/community/feeds/threads?community=${container.ID?c}'
          />">
    <#elseif (container.objectType == JiveConstants.PROJECT)>
    <link rel="alternate" type="${FeedUtils.getFeedType()}"
          title=" ${container.name?html} <@s.text name='forum.thrd.dscThrdsFeed.tooltip' />"
          href="<@s.url value='/projects/feeds/threads?project=${container.ID?c}'
          />">
    <#elseif (container.objectType == JiveConstants.SOCIAL_GROUP)>
    <link rel="alternate" type="${FeedUtils.getFeedType()}"
          title=" ${container.name?html} <@s.text name='forum.thrd.dscThrdsFeed.tooltip' />"
          href="<@s.url value='/groups/feeds/threads?socialGroup=${container.ID?c}'
          />">
    <#else>

    <@resource.javascript>
    if (window.console) {
        console.log("An unknown container was specified. The discussions feed for the container is not being loaded.");
    }
    </@resource.javascript>

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

<@resource.template file="/soy/userpicker/userpicker.soy" />
<@resource.template file="/soy/share/share.soy" />
<@resource.javascript file="/resources/scripts/apps/share/views/share_view.js" />
<@resource.javascript file="/resources/scripts/apps/share/models/share_source.js" />
<@resource.javascript file="/resources/scripts/apps/share/main.js" />
<@resource.javascript file="/resources/scripts/jive/share.js" />

<@resource.template file="/soy/groups/membership.soy" />
<@resource.javascript file="/resources/scripts/apps/socialgroup/membership/views/membership_view.js" parseDependencies="true" />
<@resource.javascript file="/resources/scripts/apps/socialgroup/membership/models/membership_source.js" parseDependencies="true" />
<@resource.javascript file="/resources/scripts/apps/socialgroup/membership/main.js" parseDependencies="true" />

<@resource.template file="/resources/scripts/apps/email_notification/main.js" />

<@resource.javascript file="/resources/scripts/apps/trial/views/trial_tip_helper.js" />

<@resource.template file="/soy/nav/movecontent.soy" />
<@resource.template file="/soy/threadtodoc/threadtodoc.soy" />
<@resource.template file="/soy/nav/modalizer.soy" />

<#if antivirusEnabled>
<@resource.javascript file="/resources/scripts/apps/antivirus/views/antivirus_view.js" />
<@resource.javascript file="/resources/scripts/apps/antivirus/models/antivirus_source.js" />
<@resource.javascript file="/resources/scripts/apps/antivirus/main.js" />
<@resource.javascript file="/resources/scripts/antivirus.js" />
</#if>

<@resource.javascript>
var jiveMembership = new jive.MembershipApp.Main({objectID:${container.ID?c}});
var pickerArgs = {
objectType: ${thread.objectType?c},
objectID: ${thread.ID?c},
personalContainerTitleKey: '${action.getI18nKey("nav.bar.create.personal_container.title.thread")}',
personalContainerCaptionKey: '${action.getI18nKey("nav.bar.create.personal_container.caption.thread")}',
searchPlaceholderKey: '${action.getI18nKey("place.picker.move.search.thread")}',
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

<#if action.isUserContainer()>
    <@resource.dwr file="ManageContentCollaboration"/>
    <@resource.javascript>
    function handleParticipantUpdate(){

    var newCollaborators = $j('input[name="participants"]').val();

    ManageContentCollaboration.updateCollaborators(${thread.objectType?c}, ${thread.ID?c}, ${user.ID?c},
    newCollaborators,
    function(users){
    var newParticipants = [];
    var shortUserHtml = "";
    var allUserHtml = "";

    for(var i = 0; i < users.length; i++){
    newParticipants[i] = users[i].username;
    var userText = '<a href="#" class="jive-username-link">' + users[i].displayName + '</a>';

    if(i < users.length - 1){
    //userText += ', ';
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

    });
    return false;
    };
    </@resource.javascript>
</#if>

<#if legacyBreadcrumb && showContainerInfo>
<content tag="breadcrumb">
    <@s.action name="legacy-breadcrumb" executeResult="true" ignoreContextParams="true">
        <@s.param name="container" value="${container.ID?c}L" />
        <@s.param name="containerType" value="${container.objectType?c}" />
        <@s.param name="contentType" value="${thread.objectType?c}" />
        <@s.param name="contentID" value="${thread.ID?c}L" />
        <@s.param name="link">
            <a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>/content?filterID=contentstatus[published]~objecttype~objecttype[thread]"><@s.text name="main.discussions.link" /></a>
        </@s.param>
    </@s.action>
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

<#if bridged>
    <@resource.javascript file="/resources/scripts/jive/bridge-bar.js"  />
</#if>
<link rel="canonical" href="${canonicalURL}"/>
<#if previousURL??>
    <link rel="prev" href="${previousURL}"/>
</#if>
<#if nextURL??>
    <link rel="next" href="${nextURL}"/>
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

<#assign isThreadAuthor = action.isUserAuthor(user,thread)>
<#assign statusLevelEnabled = jiveContext.getStatusLevelManager().isStatusLevelsEnabled()>
<#assign threadMessageCount = thread.getMessageCount()>

<#include "/template/global/include/rte-macros.ftl"/>
<div id="rte-template" style="display:none;">
<@miniRteDiscussion thread=thread comment="" container=container replySubject="" partialURL=partialURL/>
</div>
<@initDiscusssionsJS/>


<#assign rootCommunity = jiveContext.getSpringBean("communityManager").getRootCommunity() />
	<div id="jive-breadcrumb">
	<a href="${JiveResourceResolver.getJiveObjectURL(rootCommunity)}"> ${rootCommunity.getName()} </a> -> <a href="/places">All Places</a>
	<#list parents as parent>
		-><a href="${parent.objectURL}"> ${parent.name} </a>
	</#list>
	
	-><a href="${JiveResourceResolver.getJiveObjectURL(container)}"> ${container.getName()} </a>
	-><a href="${JiveResourceResolver.getJiveObjectURL(container)}/content?filterID=contentstatus[published]~objecttype~objecttype[thread]"> Discussions </a>
	</div>

<#if !legacyBreadcrumb && showContainerInfo>
<!-- BEGIN header & intro  -->
<header id="jive-body-intro">
    <nav class="j-context" role="navigation" aria-label="<@s.text name='global.breadcrumb' />">
        <span id="js-breadcrumb-intro"
              data-container-url="${JiveResourceResolver.getJiveObjectURL(container)}"
              data-container-icon-css="${SkinUtils.getJiveObjectCss(container, 1)}"
              data-container-display-name="${container.name?html}"
              data-content-browse-filter="/content?filterID=contentstatus[published]~objecttype~objecttype[thread]"
              data-has-content-rel-intro-key="forum.thrd.relatedDiscussnsIn.link"
              data-no-content-rel-intro-key="forum.thrd.upToDiscussnsIn.link">
            <#if action.isUserContainer() >
                <@s.text name='forum.thrd.upToUserDiscussnsIn.link'>
                    <@s.param><a
                           href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>/content?filterID=contentstatus[published]~objecttype~objecttype[thread]"></@s.param>
                    <@s.param></a></@s.param>
                    <@s.param><a
                            href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>"><@jive.displayUserDisplayName user=userContainerOwner/></a></@s.param>
                </@s.text>
            <#elseif hasContentPlaceRelationships>
                <@s.text name='forum.thrd.relatedDiscussnsIn.link'>
                    <@s.param><a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>"><span class="${SkinUtils.getJiveObjectCss(container, 1)}"></span>${container.name?html}</a></@s.param>
                </@s.text>
            <#else>
                <@s.text name='forum.thrd.upToDiscussnsIn.link'>
                    <@s.param><a
                            href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>/content?filterID=contentstatus[published]~objecttype~objecttype[thread]"></@s.param>
                    <@s.param></a></@s.param>
                    <@s.param><a
                            href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>"><span
                            class="${SkinUtils.getJiveObjectCss(container, 1)}"></span>${container.name?html}</a></@s.param>
                </@s.text>
            </#if>
        </span>
        <@s.action name="context-menu" executeResult="true" ignoreContextParams="true">
            <@s.param name="container" value="${container.ID?c}L" />
            <@s.param name="containerType" value="${container.objectType?c}" />
            <@s.param name="contentType" value="${thread.objectType?c}" />
            <@s.param name="contentID" value="${thread.ID?c}L" />
        </@s.action>
    </nav>
</header>
<!-- END header & intro -->
</#if>

<!-- BEGIN layout -->
<div class="j-layout j-layout-ls clearfix">

<@outputMainBodyColumn/>

    <!-- BEGIN small -->
    <div class="j-column-wrap-s">
        <div class="j-column-s j-column j-content-extras">
        <@jive.socialActions user followable followed streamsAssociatedCount thread thread.rootMessage "thread" favoriteManager.enabled sharingEnabled/>

        <@jive.renderActionSidebar 'thread-actions' thread container />

        <#if showImpactStats>
            <@soy.render template="jive.impact2.main" data=impactStatsSoyModel />
        </#if>

        <@moreLikeThis objectType=thread.rootMessage.objectType objectID=thread.rootMessage.ID />

        <@s.action name="incoming-links" executeResult="true" ignoreContextParams="true">
            <@s.param name="objectType">${thread.objectType?c}</@s.param>
            <@s.param name="objectID">${thread.ID?c}</@s.param>
        </@s.action>


        <#if question?exists && statusLevelEnabled>
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
                    </ul>
                </div>
            </div>
        </#if>

        </div>
    </div>
    <!-- END small column -->


</div>
<!-- END layout -->

</body>
</html>
