<#--
  - $Revision: 1.1 $
  - $Date: 2018/03/19 12:14:36 $
  -
  - Copyright (C) 1999-2008 Jive Software. All rights reserved.
  - This software is the proprietary information of Jive Software.  Use is subject to license terms.
-->

<#include "/template/docs/include/doc-macros.ftl" />

<html>
<head>
    <title>${action.renderSubjectToHtml(document)?html}</title>
    <meta name="titleEscaped" content="true"/>

    <#assign metaContent = action.getMetaInfo() />
    <meta name="description" content="${metaContent!?html}" />

	<link rel="stylesheet" href="<@resource.url value='/styles/jive-content.css'/>" type="text/css" media="all" />
	<link rel="stylesheet" href="<@resource.url value='/styles/tiny_mce3/themes/advanced/skins/default/content.css'/>" type="text/css" media="all" />
    <!-- UI-Extensions (if any)-->
    <#list documentActionUIExtensions as uiExtension>
        <#if uiExtension.CSSResourceName?exists && uiExtension.CSSResourceName != "">
            <link href="${uiExtension.CSSResourceName}" rel="stylesheet" type="text/css">
        </#if>
    </#list>


<#if (FeedUtils.isFeedsEnabled())>
        <link rel="alternate" type="${FeedUtils.getFeedType()}"
            title="${document.subject?html} <@s.text name='doc.main.vrsnHistFeed.tooltip' />"
            href="<@s.url value="/community/feeds/document-history/${document.documentID}"/>" />

        <link rel="alternate" type="${FeedUtils.getFeedType()}"
            title="${document.subject?html} <@s.text name='doc.main.commentsFeed.tooltip' />"
            href="<@s.url value="/community/feeds/document-comments/${document.documentID}"/>" />
    </#if>

    <#if legacyBreadcrumb && showContainerInfo>
    <content tag="breadcrumb">
        <@s.action name="legacy-breadcrumb" executeResult="true" ignoreContextParams="true">
            <@s.param name="container" value="${container.ID?c}L" />
            <@s.param name="containerType" value="${container.objectType?c}" />
            <@s.param name="contentType" value="${document.objectType?c}" />
            <@s.param name="contentID" value="${document.ID?c}L" />
            <@s.param name="link">
                <a class="jive-breadcrumb-last" href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>/content?filterID=contentstatus[published]~objecttype~objecttype[document]"><@s.text name="doc.main.brdcrmb.documents.link" /></a>
            </@s.param>
        </@s.action>
      </content>
    </#if>

	<@resource.template file="/soy/share/share.soy" />
   	<@resource.javascript file="/resources/scripts/apps/share/views/share_view.js" />
    <@resource.javascript file="/resources/scripts/apps/share/models/share_source.js" />
    <@resource.javascript file="/resources/scripts/apps/share/main.js" />
    <@resource.javascript file="/resources/scripts/jive/share.js" />

    <#if warnAboutExtendedAuthors>
        <@resource.javascript file="/resources/scripts/apps/extendedinvitations/main.js" />
    </#if>

    <@resource.template file="/soy/groups/membership.soy" />
    <@resource.javascript file="/resources/scripts/apps/socialgroup/membership/views/membership_view.js" />
    <@resource.javascript file="/resources/scripts/apps/socialgroup/membership/models/membership_source.js" />
    <@resource.javascript file="/resources/scripts/apps/socialgroup/membership/main.js" />

    <@resource.template file="/resources/scripts/apps/email_notification/main.js" />

    <@resource.template file="/soy/nav/movecontent.soy" />
    <@resource.template file="/soy/nav/modalizer.soy" />

    <@resource.javascript>
        function initBadgeHelper(badgeHelper) {
            badgeHelper.enableHeaderBadges();
        }
        require(['apps/outcomes/badgeHelper'],initBadgeHelper);
    </@resource.javascript>

    <@resource.javascript file="/resources/scripts/apps/outcomes/eventShim.js"/>

    <#if antivirusEnabled>
    <@resource.javascript file="/resources/scripts/apps/antivirus/views/antivirus_view.js" />
    <@resource.javascript file="/resources/scripts/apps/antivirus/models/antivirus_source.js" />
    <@resource.javascript file="/resources/scripts/apps/antivirus/main.js" />
    <@resource.javascript file="/resources/scripts/antivirus.js" />
    </#if>

<@resource.javascript>

        <#if followable>
            <#assign startFollowText><@s.text name="doc.startFollow.desc" /></#assign>
            <#assign stopFollowText><@s.text name="doc.stopFollow.desc" /></#assign>
            <#assign followError><@s.text name='global.follow.error'/></#assign>
            var i18n = {startFollowing : '${startFollowText?js_string}',
                        stopFollowing  : '${stopFollowText?js_string}',
                        followError    : '${followError?js_string}'}

            var jiveFollow = new jive.FollowApp.Main({objectType: 102, objectID:${document.ID?c}, featureName:'document', i18n:i18n});
        </#if>

        var jiveMembership = new jive.MembershipApp.Main({objectID:${container.ID?c}});
        var jiveMoveContent = new jive.Move.Content.Main({
            objectType: ${document.objectType?c},
            objectID: ${document.ID?c},
            personalContainerTitleKey:'${action.getI18nKey("nav.bar.create.personal_container.title.document")}',
            personalContainerCaptionKey:'${action.getI18nKey("nav.bar.create.personal_container.caption.document")}',
            searchPlaceholderKey:'${action.getI18nKey("place.picker.move.search.document")}',
            containerID: ${container.ID?c},
            containerType: ${container.objectType?c}});
        var jiveReportAbuse = new jive.Modalizer.Main({triggers:['#jive-link-abuse a'],liveTriggers:['.js-link-abuse'], width: 'medium'});
        $j(function() { new jive.EmailNotification.Main(${document.ID?c}, ${document.objectType?c}); });
    </@resource.javascript>


    <#assign docRollbackConfirmText>
        <@s.text name="doc.rollback.confirm.text" />
    </#assign>
    <#assign docDeleteConfirmDelDocText>
        <@s.text name="doc.delete.confirm_del_doc.text" />
    </#assign>
    <script type="text/javascript">
        var documentID = ${document.ID?c};

        function publishDraft() {
            var form = $j('#documentPublishForm');
            jive.util.securedForm(form).always(function() {
                form.submit();
            });
        }

        function restoreVersion(version) {
           if (confirm('${docRollbackConfirmText?js_string}')){
                var form = $j('#documentRestoreForm');
                jive.util.securedForm(form).always(function() {
                    form.submit();
                });
           }
        }

    </script>

    <!-- BEGIN action bar, only for non-binary documents -->
    <#if !document.binaryBody??>
        <#include "/template/global/include/action-bar-macros.ftl" />
        <@renderActionBar document />
    </#if>
    <!-- END action bar -->

</head>

<!--featured content macro-->
<@jive.featureContentObject objectType=document.objectType?c objectID=document.ID?c containerType=container.objectType?c containerID=container.ID?c/>

<body class="jive-body-content j-doc">

    <form id="documentRestoreForm" method="post" action='<@s.url value="/docs/${document.documentID}/restore" />'>
        <input type="hidden" name="version" value="${version}" />
        <@jive.token name="document.restore.${document.documentID}" lazy=true />
    </form>

    <form id="documentPublishForm" method="post" action='<@s.url action="doc-publish" />'>
        <@jive.token name="document.publish.${document.documentID}" lazy=true />
        <input type="hidden" name="document" value="${document.documentID}" />
    </form>

	<#assign rootCommunity = jiveContext.getSpringBean("communityManager").getRootCommunity() />
	<div id="jive-breadcrumb">
	<a href="${JiveResourceResolver.getJiveObjectURL(rootCommunity)}"> ${rootCommunity.getName()} </a> -> <a href="/places">All Places</a>
	<#list parents as parent>
		-><a href="${parent.objectURL}"> ${parent.name} </a>
	</#list>
	
	-><a href="${JiveResourceResolver.getJiveObjectURL(container)}"> ${container.getName()} </a>
	-><a href="${JiveResourceResolver.getJiveObjectURL(container)}/content?filterID=contentstatus[published]~objecttype~objecttype[document]"> Documents </a>
	</div>
	
	
    <#if !legacyBreadcrumb && showContainerInfo>
		<!-- BEGIN header & intro  -->
		<header id="jive-body-intro">
			<nav class="j-context" role="navigation" aria-label="<@s.text name='global.breadcrumb' />">
				<span id="js-breadcrumb-intro"
					  data-container-url="${JiveResourceResolver.getJiveObjectURL(container)}"
					  data-container-icon-css="${SkinUtils.getJiveObjectCss(container, 1)}"
					  data-container-display-name="${container.name?html}"
					  data-content-browse-filter="/content?filterID=contentstatus[published]~objecttype~objecttype[document]"
					  data-has-content-rel-intro-key="doc.main.docs_in_related.link"
					  data-no-content-rel-intro-key="doc.main.up_to_docs_in.link">
					<#if action.isUserContainer()?? >
						<@s.text name='doc.main.up_to_user_docs_in.link'>
							<@s.param><a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>/content?filterID=contentstatus[published]~objecttype~objecttype[document]"></@s.param>
							<@s.param></a></@s.param>
							<@s.param><a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>"><@jive.displayUserDisplayName user=action.getAuthor(document)/></a></@s.param>
						</@s.text>
					<#elseif hasContentPlaceRelationships>
						<@s.text name='doc.main.docs_in_related.link'>
							<@s.param><a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>"><span class="${SkinUtils.getJiveObjectCss(container, 1)}"></span>${container.name?html}</a></@s.param>
						</@s.text>
					<#else>
						<@s.text name='doc.main.up_to_docs_in.link'>
							<@s.param><a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>/content?filterID=contentstatus[published]~objecttype~objecttype[document]"></@s.param>
							<@s.param></a></@s.param>
							<@s.param><a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>"><span class="${SkinUtils.getJiveObjectCss(container, 1)}"></span>${container.name?html}</a></@s.param>
						</@s.text>
					</#if>
				</span>
			<@s.action name="context-menu" executeResult="true" ignoreContextParams="true">
				<@s.param name="container" value="${container.ID?c}L" />
				<@s.param name="containerType" value="${container.objectType?c}" />
				<@s.param name="contentType" value="${document.objectType?c}" />
				<@s.param name="contentID" value="${document.ID?c}L" />
			</@s.action>
			</nav>
			
		</header>
	
	<#else>
		<header id="jive-body-intro">
			<div id="jive-body-intro-content">
				<a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}'/>/content?filterID=contentstatus[published]~objecttype~objecttype[document]">
					<span class="jive-icon-sml jive-icon-arrow-generic-up"></span>
					<@s.text name='doc.main.up_to_docs_space_in.link'>
						<@s.param>${container.name?html}</@s.param>
					</@s.text>
				</a>
			</div>
		</header>
    <!-- END header & intro -->
    </#if>

    <!-- BEGIN main body -->
    <div class="jive-wiki-post-moderating jive-content-header-moderating">
        <span class="jive-icon-glyph icon-moderation"></span><@s.text name="mod.post_in_moderation.text" />
    </div>
    <div id="jive-body-main" class="j-layout j-layout-ls clearfix">
        <div class="j-column-wrap-l">
            <div class="j-column j-column-l lg-margin">
                    <#if (action.isUserContainer()) &&  (!SkinUtils.isPersonalContentEnabled(document.objectType))>
                    <div class="jive-warn-box" aria-live="polite" aria-atomic="true">
                        <div>
                            <span class="jive-icon-med jive-icon-warn"></span>
                            <@s.text name="doc.main.personalDisabled.text" />
                        </div>
                    </div>
                    </#if>
					
					<#if Session.attachmentExceeded?exists>
						<div class="jive-info-box">
							<div>
								<span class="jive-icon-med jive-icon-redalert"></span> ${Session.attachmentExceeded}
							</div>
						</div>

					</#if>

					<#if Session.attachmentExceeded?exists>
						<#assign t = action.session.remove('attachmentExceeded') />
					</#if>

					<#-- BEGIN Grail DWR status message -->
						<div id="grail-info-box">
							<div>
								<span id="cart-dwr-msg"></span>
							</div>
						</div>
					<#-- END Grail DWR status message -->
					
                    <div id="object-follow-notify" class="jive-info-box" style="display:none" aria-live="polite" aria-atomic="true"></div>

                    <div id="content-featured-notify" class="jive-info-box" style="display:none" aria-live="polite" aria-atomic="true"></div>

                    <@jive.showMovedMesage content=document container=container/>

                    <@soy.render template="jive.extended_invitation.warn_bar" data={
                        "warnVisibleToPartner": warnVisibleToPartner?? && warnVisibleToPartner,
                        "warnAboutExtendedAuthors": warnAboutExtendedAuthors?? && warnAboutExtendedAuthors,
                        "canRemoveExtendedAuthors": canCurrentUserRemoveAuthors?? && canCurrentUserRemoveAuthors,
                        "objectType": document.objectType?c,
                        "objectId":document.ID?c
                    }/>


                    <#include "/template/global/include/form-message.ftl"/>

                    <#include "/template/docs/include/doc-needs-approval.ftl" />

                    <#include "/template/docs/doc-state.ftl" />

                    <#include "/template/docs/doc-upload-message.ftl" />

                    <#include "/template/docs/presenter/presenter-default.ftl" />

                     <@jive.ratings container document "doc"/>

                    <@soy.render template="jive.outcomes.summary.summaryContainer" data={
                        'objectType': '${document.objectType?c}',
                        'objectId': '${document.ID?c}'
                    } />

                    <#include "/template/global/include/comment-macros.ftl" />
                    <@comments contentObject=document />

                    <@docDeletePrompt doc=document/>
            </div>
        </div>



        <!-- BEGIN sidebar column -->
        <div id="jive-body-sidebarcol-container" class="j-column j-column-s j-content-extras">

            <#include "/template/docs/doc-sidebar.ftl" />

        </div>
        <!-- END sidebar column -->


    </div>

</body>
</html>
