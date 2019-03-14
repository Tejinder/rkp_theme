<#macro attachmentList resource titleKey resourceURL='${resource.ID?c}'>
<#-- BEGIN attachments -->
<#if (jiveContext.attachmentManager.getAttachmentCount(resource) > 0)>
<div class="jive-attachments">
    <ul>
        <#-- rofl -->
        <#assign attachments = jiveContext.attachmentManager.getAttachments(resource)>
        <#if (attachments.iterator())??>
            <#assign attachments = attachments.iterator()>
        </#if>
        <#list attachments as attachment>
        <#assign blocked = statics["com.jivesoftware.community.JiveContentObject$Status"].REJECTED.equals(attachment.status) />
        <#assign queued = statics["com.jivesoftware.community.JiveContentObject$Status"].PROCESSING.equals(attachment.status) />
        <#if blocked || queued>
        <#-- queued -->
        <#assign iconElement = SkinUtils.getJiveObjectIcon(attachment, 0)! />

        <li data-attachmentID='${attachment.ID?c}'>
            <#if iconElement??><@jive.renderIconElement iconElement /><#else>
                <span class="${SkinUtils.getJiveObjectCss(attachment, 0)}"></span>
            </#if>
            ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
        <#if blocked>
            <b style="color:red"><@s.text name="post.status.blocked.text" /></b>
        <#else>
            <b><@s.text name="post.status.queued.text" /></b>
        </#if>
        </li>
        <#elseif (attachment.contentType?starts_with('image/'))>
        <li class="clearfix" data-attachmentID='${attachment.ID?c}'>
            <a class="j-attachment-icon" href="<@s.url value='/servlet/JiveServlet/download/${resourceURL}-${attachment.ID?c}/${attachment.name?url}'/>">
                <img alt="<@s.text name='global.attachment' />" src="<@s.url value='/servlet/JiveServlet/attachImage?attachImage=true&contentType=${attachment.contentType?url}&attachment=${attachment.ID?c}' />" border="0">
            </a>
            <div class="j-attachment-info clearfix">
                <a href="<@s.url value='/servlet/JiveServlet/download/${resourceURL}-${attachment.ID?c}/${attachment.name?url}'/>">${attachment.name?html}</a>
                <span class="j-attach-meta font-color-meta">${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}</span>
            </div>
        </li>
        <#else>
        <#-- not queued -->
        <li class="clearfix" data-attachmentID='${attachment.ID?c}'>
            <a class="j-attachment-icon" href="<@s.url value='/servlet/JiveServlet/download/${resourceURL}-${attachment.ID?c}/${attachment.name?url}'/>">
                <#assign iconElement = SkinUtils.getJiveObjectIcon(attachment, 2)! />
                <#if iconElement??><@jive.renderIconElement iconElement /><#else> <span class="${SkinUtils.getJiveObjectCss(attachment, 2)}"></span> </#if></a>
            <div class="j-attachment-info clearfix">
                <a href="<@s.url value='/servlet/JiveServlet/download/${resourceURL}-${attachment.ID?c}/${attachment.name?url}'/>">${attachment.name?html}</a>
                <span class="j-attach-meta font-color-meta">${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}
                    <@jive.previewableBinaryViewLink attachment attachment.name/>
                </span>
            </div>
        </li>
        </#if>
        </#list>
    </ul>
    <div class="j-attach-clip j-ui-elem"></div>
</div>
<#-- This is necessary to support the "previewableBinaryViewLink" macro -->
<div id="previewable-binary-viewer"></div>
</#if>
<#-- END attachments -->
</#macro>

<#macro displayUserDisplayName user='' js_string=false>
<#compress>
<#if (js_string)>${getUserDisplayName(user)?js_string}
<#else>${getUserDisplayName(user)}</#if>
</#compress>
</#macro>

<#function getPresenceJsObject(user)>

    <#assign presenceObject = 'null' />
    <#if chatPresenceManagerImpl.isPresencePublishedFor( user )>
        <#assign randomString = StringUtils.randomString( 4 ) />
        <#assign presenceProvider = chatPresenceManagerImpl.getPresenceProvider() />
        <#if presenceProvider??>
            <#assign presenceObject = presenceProvider.getPresenceJsObject( UserPermHelper.getEffectiveUser()!, user, randomString )!/>
        </#if>
    </#if>

    <#return presenceObject?html />
</#function>

<#function getPresenceId(user)>
</#function>

<#macro userDisplayNameLink user='' rel='' remote=false showHover=true anchorClass=''>
<#compress>
<#assign userDisplayName = getUserDisplayName(user)/>
<#if (user?has_content && !user.anonymous && !user.external && action.isUserVisible(user))>
<#assign randomString = user.ID?c + statics['java.lang.System'].nanoTime()?c />

<#if !remote && !user.external>

<#assign presenceObject = getPresenceJsObject( user ) />
<#if chatPresenceManagerImpl.isPresencePublishedFor( user )>
    <#assign presenceProvider = chatPresenceManagerImpl.getPresenceProvider() />
    <#if presenceProvider??>
        <#assign externalId = presenceProvider.getUserExternalId( user )! />
        <#if presenceProvider.isOnline??>
            <#assign online = presenceProvider.isOnline( user )! />
        </#if>
    </#if>
<#else>
    <#assign externalId = "" />
</#if>

<#if SkinUtils.isIntegrationUser(user)>
  <#if SkinUtils.isExtensionUser(user)>
<strong id="jive-${randomString}"
      class="jive-username-span jive-username-link jive-integration-user <#if anchorClass?has_content> ${anchorClass}</#if>">${userDisplayName}</strong>
  <#else>
<a href="${SkinUtils.getUserUrl(user, true)!?string}"
   id="jive-${randomString}"
   <#if (rel?has_content)> rel="${rel}" </#if>
   class="jive-username-link <#if anchorClass?has_content> ${anchorClass}</#if>"
        >${userDisplayName}</a>
  </#if>
<#else>
<a href="<@s.url value='/people/${user.username?url}' />"
   data-externalId="${externalId!}"
   data-username="${user.username?url}"
   data-avatarId="${jiveContext.avatarManager.getActiveAvatar(user).ID?c}"
   <#if online??>
   data-online="${online!?string}"
   </#if>
   id="jive-${randomString}"
   <#if showHover>
       data-userId="${user.ID?c}"
       data-presence="${presenceObject}"
   </#if>
   <#if (rel?has_content)>
       rel="${rel}"
   </#if>
   class="<#if showHover>jiveTT-hover-user</#if> jive-username-link<#if !user.enabled> jive-user-disabled</#if><#if anchorClass?has_content> ${anchorClass}</#if>"
        >${userDisplayName}</a>
</#if>
<#else>
<a href="<@s.url value='/people/${user.username?url}' forceAddSchemeHostAndPort='${remote?string}'/>"
   id="jive-${randomString}"
        <#if showHover>
        <#assign userProfile = RemoteProfileHelper.getUserProfile(user)/>
        <#assign userEmail = userProfile.primaryEmailAddress!/>
        <#assign userPhone = userProfile.primaryPhoneNumber!/>
        data-userDisplayName="${userDisplayName}"
        data-userStatus="${RemoteProfileHelper.getUserStatus(user)!?js_string?html}"
        data-userPhone="<#if userPhone?has_content>${userPhone.phoneNumber!?js_string?html}</#if>"
        data-userEmail="<#if userEmail?exists>${userEmail.email!?js_string?html}</#if>"
        data-profileUrl="<@s.url value='/people/${user.username?url}' forceAddSchemeHostAndPort='${remote?string}' />"
        data-avatarUrl="<@s.url value='/people/${user.username?url}/avatar/48.png' forceAddSchemeHostAndPort='${remote?string}' />"
        </#if>
   class="<#if showHover>jiveTT-hover-user-remote</#if> jive-username-link<#if !user.enabled> jive-user-disabled</#if>"
        >${userDisplayName}</a>
</#if>

<#if action.resolveFirstGroupRoleBadgeImageLocation(user)??>
    <#assign groupBadgeUri = action.resolveFirstGroupRoleBadgeImageLocation(user)/>
    <#assign groupBadgeRoleName = action.resolveFirstGroupBadgeRoleName(user) />

    <@soy.render template="jive.shared.displayutil.userRoleBadgeImage" data=
    {
    'groupBadgeUri' : groupBadgeUri,
    'groupBadgeRoleName' : groupBadgeRoleName
    }
    />
</#if>

<#elseif (action.isUserVisible(user) && user.status?string == 'invited')>
<span>${user.email}</span>
<#else>
<span>${userDisplayName}</span>
</#if>
</#compress>
</#macro>

<#macro imageProfileUrl profileImage={} user='' index=1 size=500 overrideStatus=false>
    <#if profileImage?size == 0>
        <#local pImage = jiveContext.profileImageManager.getProfileImage(user,index)! />
    <#else>
        <#local pImage = profileImage />
    </#if>
    <#if (pImage?size > 0) && (pImage.status.visible || overrideStatus) >
        <@s.url value='/profile-image-display.jspa?imageID=${pImage.ID?c}&size=${size}' />
    <#else>
        <@resource.url value='/images/jive-profile-default-portrait.png'/>
    </#if>
</#macro>

<#macro userAvatar user='' object='' size=16 class='' useLinks=true remote=false showHover=true>

<#if SkinUtils.isAvatarsEnabled()>
<#assign userDisplayName = getUserDisplayName(user)/>
<#assign hasUserLink = SkinUtils.getUserUrl(user, true)?has_content/>
<#if (user?has_content && !user.anonymous && action.isUserVisible(user))>
<#if useLinks && hasUserLink>
<#if !remote>
<#if SkinUtils.isIntegrationUser(user)>
<a href="${SkinUtils.getUserUrl(user, true)}"
           class="j-avatar <#if !SkinUtils.isCurrentUserPartner() && user.partner && (size gte 32)>j-partner</#if>">
<#else>
<#assign presenceObject = getPresenceJsObject( user ) />
<#if chatPresenceManagerImpl.isPresencePublishedFor( user )>
    <#assign presenceProvider = chatPresenceManagerImpl.getPresenceProvider() />
    <#if presenceProvider??>
        <#assign externalId = presenceProvider.getUserExternalId( user )! />
        <#if presenceProvider.isOnline??>
            <#assign online = presenceProvider.isOnline( user )! />
        </#if>
    </#if>
<#else>
    <#assign externalId = "" />
</#if>

<a href="<@s.url value="/people/${user.username?url}"/>"
   data-externalId="${externalId!}"
   data-username="${user.username?url}"
   data-avatarId="${jiveContext.avatarManager.getActiveAvatar(user).ID?c}"
   <#if online??>
   data-online="${online!?string}"
   </#if>
   class="j-avatar <#if showHover>jiveTT-hover-user</#if> <#if !SkinUtils.isCurrentUserPartner() && user.partner && (size gte 32)>j-partner</#if>"
    <#if showHover>
       data-userId="${user.ID?c}"
       data-presence="${presenceObject}"
    </#if>
>
</#if>
<#else>
<a href="<@s.url value='/people/${user.username?url}' forceAddSchemeHostAndPort='${remote?string}'/>" class="j-avatar
        <#if showHover>
        <#assign userProfile = RemoteProfileHelper.getUserProfile(user)/>
        <#assign userEmail = userProfile.primaryEmailAddress!/>
        <#assign userPhone = userProfile.primaryPhoneNumber!/>
       data-user-display-name="${userDisplayName}"
       data-user-status="${RemoteProfileHelper.getUserStatus(user)!?js_string?html}"
       data-user-phone="<#if userPhone?has_content>${userPhone.phoneNumber!?js_string?html}</#if>"
       data-user-email="<#if userEmail?exists>${userEmail.email!?js_string?html}</#if>"
       data-profile-url="<@s.url value='/people/${user.username?url}' forceAddSchemeHostAndPort='${remote?string}' />"
       data-avatar-url="<@s.url value='/people/${user.username?url}/avatar/48.png' forceAddSchemeHostAndPort='${remote?string}' />"
       jiveTT-hover-user-remote
        </#if>
        ">
    </#if>
    </#if>
    <#if !user.enabled>
    <img class="jive-avatar" src="<@resource.url value='/images/jive-avatar-disabled.png'/>" width="${size?c}"
         height="${size?c}" data-height="${size?c}"/>
    <#else>
    <img
        <#if class != ''>
            class="${class}"
        <#else>
            class="jive-avatar"
        </#if>

        <#if SkinUtils.isIntegrationUser(user)>
            src="${SkinUtils.getIntegrationUserAvatarUrl(user)}"
        <#elseif user.username??>
            <#if jiveContext.avatarManager.getActiveAvatar(user).ID??>
			
			<#-- This fix has been done as part of Jive 8 Migration as the avatar image using /people URL was not coming -->
			
			<#--  src="<@s.url value="/people/${user.username?url}/avatar" forceAddSchemeHostAndPort='${remote?string}'/>/${size?c}.png?a=${jiveContext.avatarManager.getActiveAvatar(user).ID?c}"
                data-avatarId="${jiveContext.avatarManager.getActiveAvatar(user).ID?c}"-->
				
				 src="/avatar-display.jspa?avatarID=${jiveContext.avatarManager.getActiveAvatar(user).ID?c}" 
            <#else>
               <#-- src="<@s.url value="/people/${user.username?url}/avatar" forceAddSchemeHostAndPort='${remote?string}'/>/${size?c}.png"-->
			   
			   src="/avatar-display.jspa?avatarID=${jiveContext.avatarManager.getActiveAvatar(user).ID?c}" 
            </#if>
            data-username="${user.username?url}"
        <#else>
            src="<@resource.url value='/images/jive-avatar-default.png'/>"
        </#if>

        border="0" height="${size}" data-height="${size?c}" width="${size}"
        alt="${userDisplayName}"
        /></#if>
    <#if !SkinUtils.isCurrentUserPartner() && user.partner && (size gte 32)>
        <span class="jive-icon-med jive-icon-partner"></span>
    </#if>
    <#if useLinks && hasUserLink></a></#if>
<#-- if there are line breaks or spaces above, the avatar border will have too much bottom padding on IE6 -->
<#elseif user?has_content && !action.isUserVisible(user)>
    <span class="j-avatar"><img class="jive-avatar" src="<@resource.url value='/images/jive-avatar-disabled.png'/>" width="${size?c}"
         height="${size?c}" data-height="${size?c}" alt="${userDisplayName}" title="${userDisplayName}"/></span>
<#else>
<#if object?has_content && SkinUtils.isExternalObject(object)>
    <img class="jive-avatar" src=${SkinUtils.getExternalObjectAvatarUrl(object)} ${size?c}.png" data-height="${size?c}" height="${size}"
       width="${size}" alt="${userDisplayName}" title="${userDisplayName}"/>
<#else>

    <img class="jive-avatar" src="<@s.url value="/people/guest/avatar" />/${size?c}.png" data-height="${size?c}" height="${size}"
         width="${size}" alt="${userDisplayName}" title="${userDisplayName}"/>
</#if>
</#if>
</#if>
</#macro>

<#macro userStatusLevel user='' container='' showPoints=false remote=false>
<#if (user?has_content && !user.anonymous)>
<#if container?has_content>
<#assign statusLevel = jiveContext.getSpringBean("statusLevelDelegator").getStatusLevel(user, container)!>
<#if statusLevel?has_content>
    <#if statusLevel.imagePath?has_content>
        <#assign imagePath><@resource.url value='${statusLevel.getImagePath()}' forceAddSchemeHostAndPort='${remote?string}'/></#assign>
    <#elseif statusLevel.imageURL?has_content>
        <#assign imagePath=statusLevel.imageURL />
    </#if>
<span class="j-status-levels"><#if imagePath?has_content><img src="${imagePath}"
           alt="${statusLevel.name?html}" title="${statusLevel.name?html}"/></#if> <#if showPoints>${statusLevel.name?html} <span>(${jiveContext.getStatusLevelManager().getPointLevel(user, container)?default(0)} <@s.text name="jivemacro.points.label"/>)</span></#if></span>
</#if>
<#else>
<#assign statusLevel = jiveContext.getSpringBean("statusLevelDelegator").getStatusLevel(user)!>
<#if statusLevel?has_content>
    <#if statusLevel.imagePath?has_content>
        <#assign imagePath><@resource.url value='${statusLevel.getImagePath()}' forceAddSchemeHostAndPort='${remote?string}'/></#assign>
    <#elseif statusLevel.imageURL?has_content>
        <#assign imagePath=statusLevel.imageURL />
    </#if>
<span class="j-status-levels"><#if imagePath?has_content><img src="${imagePath}"
           alt="${statusLevel.name?html}" title="${statusLevel.name?html}"/></#if> <#if showPoints>${statusLevel.name?html} <span>(${jiveContext.getStatusLevelManager().getPointLevel(user)?default(0)} <@s.text name="jivemacro.points.label"/>)</span></#if></span>
</#if>
</#if>
</#if>
</#macro>

<#macro ratingDisplay meanRating>
<div class="jive-content-avgrating-score"
     title="<@s.text name="rate.avg_user_rating.label" />: ${meanRating?string('#.##')}">
    <#list jiveContext.ratingManager.availableRatings as rating>
    <span class="jive-icon-avgrating-${rating.score?c} jive-icon-med jive-icon-rate-avg-<#if (meanRating >= rating.score)>on<#elseif (meanRating >= (rating.score - 0.50))>half<#else>off</#if>"></span>
    </#list>
</div>
</#macro>


<#-- BEGIN Grail Most Rated Document widget custom macro -->
<#macro jiveRatedContentListAjax content=content showContainer=false limit=-1 showLatestContent=true remote=false displayThumbnails=false thumbnailSize=110 currentUser='' mostRated=true>
   <#-- <#if (content?exists && content.hasNext())>-->
   <#if content?? && (content?size>0)>
    <#-- BEGIN jive-table -->
    <div class="jive-table jive-table-widget jive-table-recentcontent">
        <table cellpadding="0" cellspacing="0" border="0">
            <tbody>
                <#list content as object>
                  
					<#--<#assign provider = action.recentContentInfoProvider(object.objectType)!> -->
					<#assign provider = action.contentInfoProvider!>
                    <#if provider?has_content>
                    <#if (limit > 0 && object_index >= limit)>
                        <#break/>
                    </#if>
                    <@jiveRatedProviderContentList object=object object_index=object_index provider=provider type="recentcontent" showContainer=showContainer limit=limit showLatestContent=showLatestContent remote=remote displayThumbnails=displayThumbnails thumbnailSize=thumbnailSize currentUser=currentUser/>
                </#if>
                </#list>
            </tbody>
        </table>
    </div>
    <#-- END jive-table -->
    </#if>
</#macro>

<#macro jiveRatedProviderContentList object=object object_index=object_index provider=provider type="recentcontent" showContainer=showContainer limit=limit showLatestContent=showLatestContent remote=remote displayThumbnails=displayThumbnails thumbnailSize=thumbnailSize currentUser=''>
    <#assign contentObject = object>
    <#if object.objectType == statics['com.jivesoftware.community.acclaim.Acclaim'].OBJECTID>
        <#if !object.jiveObject??>
            <#return/>
        </#if>
        <#assign contentObject = object.jiveObject>
    </#if>
    <#assign objectURL = provider.getObjectUrl(contentObject, remote)?default('')>
    <#assign objectUser = provider.getAuthor( contentObject )!/>
<tr class="jive-table-row-<#if object_index % 2 == 0>odd<#else>even</#if>">
    <td class="jive-table-cell-type">
        <#if (contentObject.objectType == JiveConstants.VIDEO && !remote)>
            <#if displayThumbnails>
                <div class="jive-recentVidList-thumb-110"
                     onmouseover="$j('#jive-video-recentVidsLarge-selector${contentObject.ID?c}').show()"
                     onmouseout="$j('#jive-video-recentVidsLarge-selector${contentObject.ID?c}').hide()">
                <#-- Mouseover PLAY link -->
                    <div id="jive-video-recentVidsLarge-selector${contentObject.ID?c}"
                         class="jive-video-recentVidsLarge-selector" style="display:none;">
                        <a href="<@s.url value='/videos/${contentObject.ID?c}'/>"></a>
                    </div>
                    <a href="<@s.url value='${objectURL}'/>">
                        <img src="<@s.url action='video-grab-display' namespace='/'>
                                        <@s.param name='videoID' value='${contentObject.ID?c}'/>
                                        <@s.param name='size' value='110'/>
                                        </@s.url>"
                             alt="<#if contentObject.subject??>${action.renderSubjectToText(contentObject)}</#if>"/>
                    </a>
                </div>
            <#else>
                <a href="<@s.url value='${objectURL}'/>">
                    <img class="${SkinUtils.getJiveObjectCss(contentObject, 1)}" alt=""
                         src="<@resource.url value='/images/transparent.png' forceAddSchemeHostAndPort='${remote?string}'/>"/>
                </a>
            </#if>
        <#elseif (contentObject.objectType == JiveConstants.FAVORITE)>
            <a href="<@s.url value='${objectURL}'/>">
                <img class="${SkinUtils.getJiveObjectCss(contentObject.objectFavorite.favoritedObject, 1)}" alt=""
                     src="<@resource.url value='/images/transparent.png' forceAddSchemeHostAndPort='${remote?string}'/>"/>
            </a>
        <#else>
            <#assign iconElement = SkinUtils.getJiveObjectIcon(contentObject, 1)! />
            <a href="<@s.url value='${objectURL}'/>">
                <#if iconElement??><@jive.renderIconElement iconElement /><#else>
                    <img class="${SkinUtils.getJiveObjectCss(contentObject, 1)}"  alt=""
                         src="<@resource.url value='/images/transparent.png' forceAddSchemeHostAndPort='${remote?string}'/>"/>
                </#if>
            </a>
        </#if>
    </td>
    <td class="jive-table-cell-title">

        <#if (contentObject.objectType == JiveConstants.VIDEO && !remote)>
            <a href="<@s.url value='${objectURL}'/>" >
                <#assign subject = provider.getSubject(contentObject)?default('') />${subject}
            </a>
        <#else>
            <a href="<@s.url value='${objectURL}'/>">
                <#assign subject = provider.getSubject(contentObject)?default('') />${subject}
            </a>
        </#if>
        <span>
            <strong>
                <#if provider.displayLocalized?? && provider.displayLocalized && currentUser??>
                    <#assign date = provider.getDate(contentObject, currentUser)?default('') />
                <#else>
                    <#assign date = provider.getDate(contentObject)?default('') />
                </#if>${date}
            </strong>
            <#if showContainer>
                <#if (contentObject.objectType == JiveConstants.BLOGPOST)>
                    <span><@s.text name="main.in.label" /> <@blogPostContainerLink blogPost=contentObject remote=remote/></span>
                <#else>
                    <#assign parent = provider.getParent(contentObject)!/>
                    <#if parent?has_content>
                        <#if parent.objectType == JiveConstants.USER_CONTAINER>
                            <#assign objectTypeUtils = statics['com.jivesoftware.community.objecttype.ObjectTypeUtils'] >
                            <#assign typeName = objectTypeUtils.getContentTypeFeatureName(contentObject, locale)!/>
                            <@s.text name="main.in_user_container.label">
                                <@s.param><@jive.containerDisplayNameLink container=parent remote=remote /></@s.param>
                                <@s.param>${typeName}</@s.param>
                            </@s.text>
                        <#else>
                            <@s.text name="main.in.label" /> <@jive.containerDisplayNameLink
                        container=parent remote=remote />
                        </#if>
                    </#if>

                </#if>
            </#if>

        </span>
        <#if provider.edittingUser?has_content>
            <span class="jive-currently-editing">
                 <@s.text name="community.currentlyEditBy.label" />
                <@jive.displayUserDisplayName user=provider.edittingUser />
            </span>
        </#if>
    </td>
    <td class="jive-table-cell-rating" width="25%">
        <@jive.ratingDisplay meanRating=object.ratingDelegator.meanRating/>
        <br style="line-height:5px;">
        <span class="jive-table-cell-views">${object.viewCount?default('0')} (views)</span>
    </td>
</tr>
</#macro>

<#-- END Grail Most Rated Document widget custom macro -->


<#-- BEGIN Grail Most Rated Document widget custom macro -->
<#macro jiveViewedContentListAjax content=content showContainer=false limit=-1 showLatestContent=true remote=false displayThumbnails=false thumbnailSize=110 currentUser='' mostRated=true>
    <#--<#if (content?exists && content.hasNext())>-->
	<#if content?? && (content?size>0)>
    <#-- BEGIN jive-table -->
    <div class="jive-table jive-table-widget jive-table-recentcontent">
        <table cellpadding="0" cellspacing="0" border="0">
            <tbody>
                <#list content as object>
                    <#--<#assign provider = action.recentContentInfoProvider(object.objectType)!>-->
					<#assign provider = action.contentInfoProvider!>
                    <#if provider?has_content>
                    <#if (limit > 0 && object_index >= limit)>
                        <#break/>
                    </#if>
                    <@jiveViewedProviderContentList object=object object_index=object_index provider=provider type="recentcontent" showContainer=showContainer limit=limit showLatestContent=showLatestContent remote=remote displayThumbnails=displayThumbnails thumbnailSize=thumbnailSize currentUser=currentUser/>
                </#if>
                </#list>
            </tbody>
        </table>
    </div>
    <#-- END jive-table -->
    </#if>
</#macro>

<#macro jiveViewedProviderContentList object=object object_index=object_index provider=provider type="recentcontent" showContainer=showContainer limit=limit showLatestContent=showLatestContent remote=remote displayThumbnails=displayThumbnails thumbnailSize=thumbnailSize currentUser=''>
    <#assign contentObject = object>
    <#if object.objectType == statics['com.jivesoftware.community.acclaim.Acclaim'].OBJECTID>
        <#if !object.jiveObject??>
            <#return/>
        </#if>
        <#assign contentObject = object.jiveObject>
    </#if>
    <#assign objectURL = provider.getObjectUrl(contentObject, remote)?default('')>
    <#assign objectUser = provider.getAuthor( contentObject )!/>
<tr class="jive-table-row-<#if object_index % 2 == 0>odd<#else>even</#if>">
    <td class="jive-table-cell-type">
        <#if (contentObject.objectType == JiveConstants.VIDEO && !remote)>
            <#if displayThumbnails>
                <div class="jive-recentVidList-thumb-110"
                     onmouseover="$j('#jive-video-recentVidsLarge-selector${contentObject.ID?c}').show()"
                     onmouseout="$j('#jive-video-recentVidsLarge-selector${contentObject.ID?c}').hide()">
                <#-- Mouseover PLAY link -->
                    <div id="jive-video-recentVidsLarge-selector${contentObject.ID?c}"
                         class="jive-video-recentVidsLarge-selector" style="display:none;">
                        <a href="<@s.url value='/videos/${contentObject.ID?c}'/>"></a>
                    </div>
                    <a href="<@s.url value='${objectURL}'/>">
                        <img src="<@s.url action='video-grab-display' namespace='/'>
                                        <@s.param name='videoID' value='${contentObject.ID?c}'/>
                                        <@s.param name='size' value='110'/>
                                        </@s.url>"
                             alt="<#if contentObject.subject??>${action.renderSubjectToText(contentObject)}</#if>"/>
                    </a>
                </div>
            <#else>
                <a href="<@s.url value='${objectURL}'/>">
                    <img class="${SkinUtils.getJiveObjectCss(contentObject, 1)}" alt=""
                         src="<@resource.url value='/images/transparent.png' forceAddSchemeHostAndPort='${remote?string}'/>"/>
                </a>
            </#if>
        <#elseif (contentObject.objectType == JiveConstants.FAVORITE)>
            <a href="<@s.url value='${objectURL}'/>">
                <img class="${SkinUtils.getJiveObjectCss(contentObject.objectFavorite.favoritedObject, 1)}" alt=""
                     src="<@resource.url value='/images/transparent.png' forceAddSchemeHostAndPort='${remote?string}'/>"/>
            </a>
        <#else>
            <#assign iconElement = SkinUtils.getJiveObjectIcon(contentObject, 1)! />
            <a href="<@s.url value='${objectURL}'/>">
                <#if iconElement??><@jive.renderIconElement iconElement /><#else>
                    <img class="${SkinUtils.getJiveObjectCss(contentObject, 1)}"  alt=""
                         src="<@resource.url value='/images/transparent.png' forceAddSchemeHostAndPort='${remote?string}'/>"/>
                </#if>
            </a>
        </#if>
    </td>
    <td class="jive-table-cell-title">

        <#if (contentObject.objectType == JiveConstants.VIDEO && !remote)>
            <a href="<@s.url value='${objectURL}'/>" >
                <#assign subject = provider.getSubject(contentObject)?default('') />${subject}
            </a>
        <#else>
            <a href="<@s.url value='${objectURL}'/>">
                <#assign subject = provider.getSubject(contentObject)?default('') />${subject}
            </a>
        </#if>
        <span>
            <strong>
                <#if provider.displayLocalized?? && provider.displayLocalized && currentUser??>
                    <#assign date = provider.getDate(contentObject, currentUser)?default('') />
                <#else>
                    <#assign date = provider.getDate(contentObject)?default('') />
                </#if>${date}
            </strong>
            <#if showContainer>
                <#if (contentObject.objectType == JiveConstants.BLOGPOST)>
                    <span><@s.text name="main.in.label" /> <@blogPostContainerLink blogPost=contentObject remote=remote/></span>
                <#else>
                    <#assign parent = provider.getParent(contentObject)!/>
                    <#if parent?has_content>
                        <#if parent.objectType == JiveConstants.USER_CONTAINER>
                            <#assign objectTypeUtils = statics['com.jivesoftware.community.objecttype.ObjectTypeUtils'] >
                            <#assign typeName = objectTypeUtils.getContentTypeFeatureName(contentObject, locale)!/>
                            <@s.text name="main.in_user_container.label">
                                <@s.param><@jive.containerDisplayNameLink container=parent remote=remote /></@s.param>
                                <@s.param>${typeName}</@s.param>
                            </@s.text>
                        <#else>
                            <@s.text name="main.in.label" /> <@jive.containerDisplayNameLink
                        container=parent remote=remote />
                        </#if>
                    </#if>

                </#if>
            </#if>

        </span>
        <#if provider.edittingUser?has_content>
            <span class="jive-currently-editing">
                 <@s.text name="community.currentlyEditBy.label" />
                <@jive.displayUserDisplayName user=provider.edittingUser />
            </span>
        </#if>
    </td>
    <td class="jive-table-cell-views" width="100%" >
        <span class="jive-table-cell-views">${object.viewCount?default('0')} (views)</span>
    </td>
    <td class="jive-table-cell-author">
                        <span><@s.text name="global.by"/>
                            <#if objectUser?has_content && !objectUser.anonymous>
                                <#if objectUser?has_content><@jive.userDisplayNameLink user=objectUser remote=remote/></span></#if>
                            <#else>
                                <@renderGuestDisplayName contentObject/>
                            </#if>
    </td>
    <td class="jive-table-cell-avatar">
        <#if objectUser?has_content><span><@jive.userAvatar user=objectUser size=22 remote=remote/></span></#if>
    </td>
</tr>
</#macro>
<!-- Custom Macros ends here -->

<#macro jiveAcclaimContentListSidebar content=content type="like" showContainer=false limit=-1 showLatestContent=true remote=false displayThumbnails=false thumbnailSize=60>
    <@jiveContentListSidebar content=content type=type showContainer=showContainer limit=limit remote=false showLatestContent=false />
</#macro>

<#macro jiveContentListSidebar content=content type="recentcontent" showContainer=false limit=-1 showLatestContent=true remote=false displayThumbnails=false thumbnailSize=60>
<#if (content?exists && content.hasNext())>
<#assign renderUtils = statics['com.jivesoftware.community.action.util.RenderUtils'] >
<ul class="j-icon-list">
    <#list content as object>
        <#if (limit > 0 && object_index >= limit)>
            <#break/>
        </#if>
        <#assign contentObject = object/>
        <#if (object.objectType == statics['com.jivesoftware.community.acclaim.Acclaim'].OBJECTID)>
            <#if !object.jiveObject??>
                <#break/>
            </#if>
            <#assign contentObject = object.jiveObject/>
        </#if>
        <#assign objectURL = JiveResourceResolver.getJiveObjectURL(contentObject, remote)>
        <#if (contentObject.objectType == JiveConstants.THREAD && showLatestContent)>
            <#if contentObject.latestMessage?exists>
                <#assign objectURL = JiveResourceResolver.getJiveObjectURL(contentObject.latestMessage, remote) />
            </#if>
        </#if>


        <#if (contentObject.objectType == JiveConstants.FAVORITE)>
            <li>
                <@renderSmallAcclaimScore type object />
                <a href="<@s.url value='${objectURL}'/>" class="jive-content-link">
                <#assign iconElement = SkinUtils.getJiveObjectIcon(object, 1)! />
                <#if iconElement??><@jive.renderIconElement iconElement /><#else>
                    <span class="${SkinUtils.getJiveObjectCss(object, 1)}"></span>
                </#if>
        <#else>
            <li>
                <@renderSmallAcclaimScore type object />
                <a href="<@s.url value='${objectURL}'/>" class="jive-content-link">
                <#assign iconElement = SkinUtils.getJiveObjectIcon(contentObject, 1)! />
                <#if iconElement??><@jive.renderIconElement iconElement /><#else>
                    <span class="${SkinUtils.getJiveObjectCss(contentObject, 1)}"></span>
                </#if>
        </#if>

        <#if (contentObject.objectType == JiveConstants.THREAD && contentObject.messageCount > 1 && showLatestContent)>
            ${renderUtils.renderSubjectToText(contentObject.getLatestMessage(), action.getGlobalRenderManager())}
        <#elseif contentObject.objectType == JiveConstants.VIDEO>
            <div class="jive-recentVidList-title-smallIcon">
                ${renderUtils.renderSubjectToText(contentObject, action.getGlobalRenderManager())}
            </div>
        <#else>
            ${renderUtils.renderSubjectToText(contentObject, action.getGlobalRenderManager())}
        </#if>
        </a>

        <#if (contentObject.objectType == JiveConstants.BLOGPOST)>
            <span><@s.text name="main.in.label" /> <@blogPostContainerLink blogPost=contentObject remote=remote/></span>
        <#elseif showContainer>
            <#if contentObject.jiveContainer?? || action.getPrincipalContainer(contentObject)??>
                <#assign parent = contentObject.jiveContainer!action.getPrincipalContainer(contentObject)/>
                <#if parent?has_content && parent.objectType != JiveConstants.USER_CONTAINER>
                    <span><@s.text name="main.in.label" /> <a
                    href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(parent, remote)}' includeParams='none'/>">${parent.name?html}</a></span>
                </#if>
            </#if>
        </#if>
        </li>
    </#list>
</ul>
</#if>
</#macro>

<#macro jiveContentList currentUser content=content showContainer=false limit=-1 showLatestContent=true remote=false displayThumbnails=false thumbnailSize=110>

<#if (content?exists && content.hasNext())>

<#-- BEGIN jive-table -->
<div class="jive-table jive-table-widget jive-table-recentcontent">
    <table cellpadding="0" cellspacing="0" border="0">
        <thead>
        <tr>
            <th class="jive-table-head-title" colspan="2"><@s.text name="community.subject.colhead" /></th>
            <th class="jive-table-head-author" colspan="2"><@s.text name="global.author" /></th>
        </tr>
        </thead>
        <tbody>
        <#list content as object>
            <#assign provider = action.contentInfoProvider!>
            <#if provider?has_content>
                <#if (limit > 0 && object_index >= limit)>
                    <#break/>
                </#if>
                <@jiveProviderContentList currentUser=currentUser object=object object_index=object_index provider=provider type="recentcontent" showContainer=showContainer limit=limit showLatestContent=showLatestContent remote=remote displayThumbnails=displayThumbnails thumbnailSize=thumbnailSize />
            </#if>
        </#list>
        </tbody>
    </table>

</div>
<#-- END jive-table -->

</#if>
</#macro>


<#macro jiveContentListAjax currentUser content=content showContainer=false limit=-1 showLatestContent=true remote=false displayThumbnails=false thumbnailSize=110>
<#if (content?exists && content.hasNext())>
<#-- BEGIN jive-table -->
<div class="jive-table jive-table-widget jive-table-recentcontent">
    <table cellpadding="0" cellspacing="0" border="0">
        <tbody>
        <#list content as object>
            <#assign provider = action.contentInfoProvider!>
            <#if provider?has_content>
                <#if (limit > 0 && object_index >= limit)>
                    <#break/>
                </#if>
                <@jiveProviderContentList currentUser=currentUser object=object object_index=object_index provider=provider type="recentcontent" showContainer=showContainer limit=limit showLatestContent=showLatestContent remote=remote displayThumbnails=displayThumbnails thumbnailSize=thumbnailSize />
            </#if>
        </#list>
        </tbody>
    </table>
</div>
<#-- END jive-table -->
</#if>
</#macro>

<#macro jiveProviderContentList currentUser object=object object_index=object_index provider=provider type="recentcontent" showContainer=showContainer limit=limit showLatestContent=showLatestContent remote=remote displayThumbnails=displayThumbnails thumbnailSize=thumbnailSize>
    <#assign contentObject = object>
    <#if object.objectType == statics['com.jivesoftware.community.acclaim.Acclaim'].OBJECTID>
        <#if !object.jiveObject??>
            <#return/>
        </#if>
        <#assign contentObject = object.jiveObject>
    </#if>
    <#assign objectURL = provider.getObjectUrl(contentObject, remote)?default('')>
    <#assign objectUser = provider.getAuthor( contentObject )!/>
    <tr class="jive-table-row-<#if object_index % 2 == 0>odd<#else>even</#if>">
        <#if type == "like">
        <td class="jive-table-cell-likes">
            <div id="acclaim-scoredisplay-${contentObject.objectType?c}-${contentObject.ID?c}">
                ${object.scoreDisplay}
            </div>
        </td>
        <#elseif type == "rate">
        <td class="jive-table-cell-acclaim-rate">
            <@ratingDisplay meanRating=object.scoreDisplay />
        </td>
        </#if>
        <td class="jive-table-cell-type">
            <#if (contentObject.objectType == JiveConstants.VIDEO && !remote)>
            <#if displayThumbnails>
            <div class="jive-recentVidList-thumb-110"
                 onmouseover="$j('#jive-video-recentVidsLarge-selector${contentObject.ID?c}').show()"
                 onmouseout="$j('#jive-video-recentVidsLarge-selector${contentObject.ID?c}').hide()">
                <#-- Mouseover PLAY link -->
                <div id="jive-video-recentVidsLarge-selector${contentObject.ID?c}"
                     class="jive-video-recentVidsLarge-selector" style="display:none;">
                    <a href="<@s.url value='/videos/${contentObject.ID?c}'/>"></a>
                </div>
                <a href="<@s.url value='${objectURL}'/>">
                    <img src="<@s.url action='video-grab-display' namespace='/'>
                                        <@s.param name='video' value='${contentObject.ID?c}L'/>
                                        <@s.param name='size' value='110'/>
                                        </@s.url>"
                         alt="<#if contentObject.subject??>${action.renderSubjectToText(contentObject)}</#if>"/>
                </a>
            </div>
            <#else>
            <a href="<@s.url value='${objectURL}'/>">
                <img class="${SkinUtils.getJiveObjectCss(contentObject, 1)}" alt=""
                     src="<@resource.url value='/images/transparent.png' forceAddSchemeHostAndPort='${remote?string}'/>"/>
            </a>
            </#if>
            <#elseif (contentObject.objectType == JiveConstants.FAVORITE)>
            <a href="<@s.url value='${objectURL}'/>">
                <img class="${SkinUtils.getJiveObjectCss(contentObject.objectFavorite.favoritedObject, 1)}" alt=""
                     src="<@resource.url value='/images/transparent.png' forceAddSchemeHostAndPort='${remote?string}'/>"/>
            </a>
            <#else>
            <#assign iconElement = SkinUtils.getJiveObjectIcon(contentObject, 1)! />
            <a href="<@s.url value='${objectURL}'/>">
                <#if iconElement??><@jive.renderIconElement iconElement /><#else>
                <img class="${SkinUtils.getJiveObjectCss(contentObject, 1)}"  alt=""
                     src="<@resource.url value='/images/transparent.png' forceAddSchemeHostAndPort='${remote?string}'/>"/>
                </#if>
            </a>
            </#if>
        </td>
        <td class="jive-table-cell-title">
            <#if (contentObject.objectType == JiveConstants.VIDEO && !remote)>
            <a href="<@s.url value='${objectURL}'/>" >
                <#assign subject = provider.getSubject(contentObject)?default('') />${subject}
            </a>
            <#elseif (contentObject.objectType == JiveConstants.WALL_ENTRY)>
                <a href="<@s.url value='${objectURL}'/>">
                    <#assign subject = stringEscapeUtils.unescapeHtml(provider.getSubject(contentObject)?default('')) />${subject}
                </a>
            <#else>
            <a href="<@s.url value='${objectURL}'/>">
                <#assign subject = provider.getSubject(contentObject)?default('') />${subject}
            </a>
            </#if>
                        <span>
                        <strong>
                            <#assign date = provider.getDate(contentObject, currentUser)?default('') />${date}
                        </strong>
                         <#if showContainer>
                            <#if (contentObject.objectType == JiveConstants.BLOGPOST)>
                               <span><@s.text name="main.in.label" /> <@blogPostContainerLink blogPost=contentObject remote=remote/></span>
                            <#else>
                                <#assign parent = provider.getParent(contentObject)!/>
                                <#if parent?has_content>
                                    <#if parent.objectType == JiveConstants.USER_CONTAINER>
                                        <#assign objectTypeUtils = statics['com.jivesoftware.community.objecttype.ObjectTypeUtils'] >
                                        <#assign typeName = objectTypeUtils.getContentTypeFeatureName(contentObject, locale)!/>
                                        <@s.text name="main.in_user_container.label">
                                            <@s.param><@jive.containerDisplayNameLink container=parent remote=remote /></@s.param>
                                            <@s.param>${typeName}</@s.param>
                                        </@s.text>
                                    <#else>
                                        <@s.text name="main.in.label" /> <@jive.containerDisplayNameLink
                                            container=parent remote=remote />
                                    </#if>
                                </#if>
                            </#if>
                        </#if>

                        </span>
            <#if provider.edittingUser?has_content>
                        <span class="jive-currently-editing">
                            <@s.text name="community.currentlyEditBy.label" />
                            <@jive.displayUserDisplayName user=provider.edittingUser />
                        </span>
            </#if>
        </td>
        <td class="jive-table-cell-author">

            <#if contentObject.objectType != ActivityConstants.TILE_STREAM_ENTRY>
                <span>
                <#if objectUser?has_content && !objectUser.anonymous>
					<@s.text name="global.by_author">
						<@s.param><@jive.userDisplayNameLink user=objectUser remote=remote/></@s.param>
					</@s.text>		                    
                <#else>
					<@s.text name="global.by_author">
						<@s.param><@renderGuestDisplayName contentObject/></@s.param>
					</@s.text>		                    
                </#if>
                </span>
            </#if>
        </td>
        <td class="jive-table-cell-avatar">
            <#if contentObject.objectType == ActivityConstants.TILE_STREAM_ENTRY>

            <#else>
                <#if objectUser?has_content><span><@jive.userAvatar user=objectUser object=object size=22 remote=remote/></span></#if>
            </#if>
        </td>
    </tr>
</#macro>

<#macro jiveAcclaimContentList currentUser content=content type="like" showContainer=false limit=-1 showLatestContent=true remote=false displayThumbnails=false thumbnailSize=110>

<#if (content?exists && content.hasNext())>

<#-- BEGIN jive-table -->
<div class="jive-table jive-table-widget jive-table-toplikedcontent">
    <table cellpadding="0" cellspacing="0" border="0">
        <thead>
        <tr>
            <th class="jive-table-head-likes"><@s.text name="acclaim.mostLiked.likes.head" /></th>
            <th class="jive-table-head-title" colspan="2"><@s.text name="community.subject.colhead" /></th>
            <th class="jive-table-head-author" colspan="2"><@s.text name="global.author" /></th>
        </tr>
        </thead>

        <tbody>
        <#list content as object>
            <#if object.jiveObjectDescriptor.objectType == JiveConstants.EXTERNAL_URL>
                <#assign provider = action.acclaimInfoProvider(object.jiveObjectDescriptor.objectType)>
            <#else>
                <#assign provider = action.contentInfoProvider! />
            </#if>

            <#if provider?has_content>
                <#if (limit > 0 && object_index >= limit)>
                    <#break/>
                </#if>
                <@jiveProviderContentList currentUser=currentUser object=object object_index=object_index provider=provider type=type showContainer=showContainer limit=limit showLatestContent=false remote=remote displayThumbnails=displayThumbnails thumbnailSize=thumbnailSize />
            </#if>
        </#list>
        </tbody>
    </table>

</div>
<#-- END jive-table -->

</#if>
</#macro>

<#macro containerDisplayNameLink container=container remote=false showFullIcon=false wallentry=false tooltip=true>
    <@compress>
    <#if (showFullIcon)>
    <#assign objectTypeUtils = statics['com.jivesoftware.community.objecttype.ObjectTypeUtils'] >
    <#assign typeName = objectTypeUtils.getJiveObjectType(container.objectType).code?lower_case/>
    </#if>

    <#if (container.objectType == JiveConstants.SOCIAL_GROUP)>
        <a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container, remote)}' includeParams='none'/>"
        <#if tooltip>
            class='jivecontainerTT-hover-container'
            data-objectId="${container.ID?c}" data-objectType="${container.objectType?c}"
        </#if>
        >
        ${container.name?html}</a>
    <#elseif (container.objectType == JiveConstants.USER_CONTAINER && wallentry)>
        <#if container.name?has_content>
            <a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container, remote)}' includeParams='none'/>"
            <#if tooltip>
                class='jivecontainerTT-hover-container'
                data-objectId="${container.ID?c}" data-objectType="${container.objectType?c}"
            </#if>
            >
            <@s.text name="activity.in_user_container2.we">
                <@s.param>
                ${container.name?html}
                </@s.param>
            </@s.text>
            </a>
        </#if>
    <#elseif (container.objectType == JiveConstants.USER_CONTAINER)>
        <#if container.name?has_content>
            <a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container, remote)}' includeParams='none'/>"
            <#if tooltip>
                class='jivecontainerTT-hover-container'
                data-objectId="${container.ID?c}" data-objectType="${container.objectType?c}"
            </#if>
            >
            ${container.name?html}</a>
        </#if>
    <#else>
        <a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container, remote)}' includeParams='none'/>"
        <#if tooltip>
            class='jivecontainerTT-hover-container'
            data-objectId="${container.ID?c}" data-objectType="${container.objectType?c}"
        </#if>
        >
        ${container.name?html}</a>
    </#if>
    </@compress>
</#macro>

<#macro jiveEmptyContentListSidebar container showThreadLink=true showDocLink=true showBlogPostLink=true  remote=false showTypeExclusively="">
<#assign canCreateThread = MessagePermHelper.getCanCreateThread(container) />
<#assign canCreateDocument = DocumentPermHelper.getCanCreateDocument(container) />
<#assign canCreateBlogPost = BlogPermHelper.getCanCreateBlogPost(container)/>

<div class="jive-widget-body-empty jive-widget-body-empty-recentcontent">
    <#if JiveEmptyContentListHelper.shouldShow( "message", showTypeExclusively ) && showThreadLink && jive.isModuleAvailable("forums", container)>
        <#-- check write permissions -->
        <#if (canCreateThread && !remote)>
        <#if container.objectType == 14 && container.ID == 1 >
            <a href="<@s.url value="/"/>?contentType=${JiveConstants.THREAD?c}"
                class="jive-icon-link-forward jive-widget-empty-action js-create-quick-link"><@s.text name="community.discussions.none.link" /></a>
        <#else>
            <a href="<@s.url namespace="/discussion" action="create" forceAddSchemeHostAndPort='${remote?string}'>
                <@s.param name="containerType" value="${container.objectType?c}"/>
                <@s.param name="containerID" value="${container.ID?c}L"/>
                </@s.url>"
                class="jive-icon-link-forward jive-widget-empty-action js-create-quick-link"><@s.text name="community.discussions.none.link" /></a>
        </#if>
        <p><@s.text name="community.discussions.none" /></p>
        <#else>
        <p><@s.text name="community.discusssns.noCrt.text" /></p>
        </#if>
    </#if>
    <#if JiveEmptyContentListHelper.shouldShow( "document", showTypeExclusively ) && showDocLink && jive.isModuleAvailable("wiki", container) >
        <#-- check write permissions -->
        <#if (canCreateDocument && !remote)>
        <#if container.objectType == 14 && container.ID == 1>
            <@s.text name="community.documents.none.link">
                <@s.param><a href="<@s.url value="/"/>?contentType=${JiveConstants.DOCUMENT?c}"
                    class="jive-icon-link-forward jive-widget-empty-action js-create-quick-link"></@s.param>
                <@s.param></a></@s.param>
                <@s.param><a href="<@s.url value="/"/>?contentType=${JiveConstants.DOCUMENT?c}&upload=true"
                    class="jive-icon-link-forward jive-widget-empty-action js-create-quick-link"></@s.param>
                <@s.param></a></@s.param>
            </@s.text>
        <#else>
            <@s.text name="community.documents.none.link">
                <@s.param><a href="<@s.url action='choose-container'><@s.param name="containerType" value="${container.objectType?c}"/><@s.param name="container" value="${container.ID?c}L"/><@s.param name="contentType" value="${JiveConstants.DOCUMENT?c}"/><@s.param name="upload" value="false"/></@s.url>"
                    class="jive-icon-link-forward jive-widget-empty-action"></@s.param>
                <@s.param></a></@s.param>
                <@s.param><a href="<@s.url action='choose-container'><@s.param name="containerType" value="${container.objectType?c}"/><@s.param name="container" value="${container.ID?c}L"/><@s.param name="contentType" value="${JiveConstants.DOCUMENT?c}"/><@s.param name="upload" value="true"/></@s.url>"
                    class="jive-icon-link-forward jive-widget-empty-action"></@s.param>
                <@s.param></a></@s.param>
            </@s.text>
        </#if>
        <p><@s.text name="community.documents.none" /></p>
        <#else>
        <p><@s.text name="cmnty.docs.no_create.text" /></p>
        </#if>
    </#if>
    <#if JiveEmptyContentListHelper.shouldShow( "blogpost", showTypeExclusively ) && showBlogPostLink && jive.isModuleAvailable("blogs", container)>
        <#-- check write permissions -->
        <#if (canCreateBlogPost && !remote)>
        <#if blog?exists>
        <a href="<@s.url namespace='/blog' action='create-post' forceAddSchemeHostAndPort='${remote?string}'><@s.param name='containerType' value='${blog.objectType?c}'/><@s.param name='containerID' value='${blog.ID?c}L'/></@s.url>"
           class="jive-icon-link-forward"><@s.text name="cmnty.blogposts.write_post.link" /></a>
        <#else>
        <a href="<@s.url value="/"/>?contentType=${JiveConstants.BLOGPOST?c}"
           class="jive-icon-link-forward jive-widget-empty-action js-create-quick-link"><@s.text name="cmnty.blogposts.write_post.link" /></a>
        </#if>
        <p><@s.text name="community.blogposts.none" /></p>
        <#else>
        <p><@s.text name="community.blogposts.no_crt.text" /></p>
        </#if>
    </#if>

    <#-- render custom types -->
    <#list JiveEmptyContentListHelper.getEmptyContentListBeans( container, showTypeExclusively, remote, true ) as bean>
    <div class="jive-widget-empty-${bean.type.code}">
        <#-- check write permissions -->
        <#if bean.canCreate() >
        <#if container.objectType == 14 && container.ID == 1 >
        <a href="<@s.url value="/"/>?contentType=${bean.type.ID?c}"
           class="jive-icon-link-forward jive-widget-empty-action js-create-quick-link"><@s.text name="community.${bean.type.code}.none.link" /></a>
        <#else>
        <a href="<@s.url value='${bean.createURL}' forceAddSchemeHostAndPort='${remote?string}'/>"
           class="jive-icon-link-forward jive-widget-empty-action"><@s.text name="community.${bean.type.code}.none.link" /></a>
        </#if>

        <p><@s.text name="community.${bean.type.code}.none" /></p>
        <#else>
        <p><@s.text name="community.${bean.type.code}.noCrt.text" /></p>
        </#if>
    </div>
    </#list>

</div>
</#macro>

<#macro jiveEmptyContentList container showThreadLink=true showDocLink=true showBlogPostLink=true remote=false showTypeExclusively="">
<#assign canCreateThread = MessagePermHelper.getCanCreateThread(container) />
<#assign canCreateDocument = DocumentPermHelper.getCanCreateDocument(container) />
<#assign canCreateBlogPost = BlogPermHelper.getCanCreateBlogPost(container)/>

<div class="jive-widget-body-empty">

            <#if JiveEmptyContentListHelper.shouldShow( "message", showTypeExclusively ) && showThreadLink && jive.isModuleAvailable("forums", container)>
            <div class="jive-content-block-empty-discussions">
                <#-- check write permissions -->
                <#if (canCreateThread)>
                <a href="<@s.url namespace="/discussion" action="create" forceAddSchemeHostAndPort='${remote?string}'>
                    <@s.param name="containerType" value="${container.objectType?c}"/>
                    <@s.param name="containerID" value="${container.ID?c}L"/>
                    </@s.url>"
                   class="jive-icon-link-forward jive-widget-empty-action js-create-quick-link"><@s.text name="community.discussions.none.link" /></a>

                <p><@s.text name="community.discussions.none" /></p>
                <#else>
                <p><@s.text name="community.discusssns.noCrt.text" /></p>
                </#if>
            </div>
            </#if>
            <#if JiveEmptyContentListHelper.shouldShow( "document", showTypeExclusively ) && showDocLink && jive.isModuleAvailable("wiki", container) >
            <div class="jive-content-block-empty-documents">
                <#-- check write permissions -->
                <#if (canCreateDocument)>
                    <@s.text name="community.documents.none.link">
                        <@s.param><a href="<@s.url namespace="/document" action='create'>
                            <@s.param name="containerType" value="${container.objectType?c}"/>
                            <@s.param name="containerID" value="${container.ID?c}L"/></@s.url>"
                            class="jive-icon-link-forward jive-widget-empty-action js-create-quick-link"></@s.param>
                        <@s.param></a></@s.param>
                        <@s.param><a href="<@s.url  namespace="/document" action='upload'>
                            <@s.param name="containerType" value="${container.objectType?c}"/>
                            <@s.param name="containerID" value="${container.ID?c}L"/></@s.url>"
                            class="jive-icon-link-forward jive-widget-empty-action js-create-quick-link"></@s.param>
                        <@s.param></a></@s.param>
                    </@s.text>
                    <p><@s.text name="community.documents.none" /></p>
                <#else>
                    <p><@s.text name="cmnty.docs.no_create.text" /></p>
                </#if>
            </div>
            </#if>
            <#if JiveEmptyContentListHelper.shouldShow( "blogpost", showTypeExclusively ) && showBlogPostLink && jive.isModuleAvailable("blogs", container) >
            <div class="jive-content-block-empty-blogposts">
                <#-- check write permissions -->
                <#if (canCreateBlogPost)>
                    <#if blog?exists>
                        <a href="<@s.url namespace='/blog' action='create-post' forceAddSchemeHostAndPort='${remote?string}'>
                            <@s.param name='containerType' value='${blog.objectType?c}'/>
                            <@s.param name='containerID' value='${blog.ID?c}L'/></@s.url>"
                           class="jive-icon-link-forward jive-widget-empty-action js-create-quick-link"><@s.text name="cmnty.blogposts.write_post.link" /></a>
                    <#else>
                        <a href="<@s.url value="/"/>?contentType=${JiveConstants.BLOGPOST?c}"
                            class="jive-icon-link-forward jive-widget-empty-action js-create-quick-link"><@s.text name="cmnty.blogposts.write_post.link" /></a>
                    </#if>
                    <p><@s.text name="community.blogposts.none" /></p>
                <#else>
                <p><@s.text name="community.blogposts.no_crt.text" /></p>
                </#if>
            </div>
            </#if>


            <#-- render custom types -->
            <#list JiveEmptyContentListHelper.getEmptyContentListBeans( container, showTypeExclusively, remote, false ) as bean>
            <div class="jive-content-block-empty-${bean.type.code}">
                <#-- check write permissions -->
                <#if bean.canCreate() >
                    <a href="<@s.url value='${bean.createURL}' forceAddSchemeHostAndPort='${remote?string}'/>"
                       class="jive-icon-link-forward jive-widget-empty-action js-create-quick-link"><@s.text name="community.${bean.type.code}.none.link" /></a>
                    <p><@s.text name="community.${bean.type.code}.none" /></p>
                <#else>
                    <p><@s.text name="community.${bean.type.code}.noCrt.text" /></p>
                </#if>
            </div>
            </#list>

</div>
</#macro>

<#macro jiveTaggableList taggables=taggables showContainer=false limit=-1 remote=false>

<#if (taggables?exists && taggables.hasNext())>

<#-- BEGIN jive-table -->
<div class="jive-table jive-table-widget jive-table-taggables">

    <table cellpadding="0" cellspacing="0" border="0">
        <thead>
        <tr>
            <th class="jive-table-head-title" colspan="2"><@s.text name="community.subject.colhead" /></th>
            <th class="jive-table-head-author" colspan="2"><@s.text name="global.author" /></th>
        </tr>
        </thead>
        <tbody>
        <#list taggables as object>
        <#if (limit > 0 && object_index >= limit)>
        <#break/>
        </#if>
        <#assign objectURL = JiveResourceResolver.getJiveObjectURL(object, remote)>
        <#assign docBeingEdited = false/>
        <#assign objectUser></#assign>
        <#if (object.getObjectType() == JiveConstants.DOCUMENT)>
        <#assign docBeingEdited = object.documentBeingEdited/>
        <#if (object.versionManager.publishedDocumentVersion?exists && object.versionManager.publishedDocumentVersion.author?exists)>
        <#assign objectUser = object.versionManager.publishedDocumentVersion.author />
        </#if>
        <#elseif (object.objectType == JiveConstants.THREAD)>
        <#if object.latestMessage?exists>
        <#assign objectUser = object.latestMessage.user />
        </#if>
        <#elseif object.user?exists>
        <#assign objectUser = object.user />
        </#if>
        <tr class="jive-table-row-<#if object_index % 2 == 0>odd<#else>even</#if>">
            <td class="jive-table-cell-type">
                <img class="${SkinUtils.getJiveObjectCss(object, 1)}"
                     src="<@resource.url value='/images/transparent.png' forceAddSchemeHostAndPort='${remote?string}'/>"
                     alt=""/>
            </td>
            <td class="jive-table-cell-title">
                <a href="<@s.url value='${objectURL}'/>">
                    <#if (object.objectType == JiveConstants.THREAD && object.messageCount > 1)>Re: </#if>
                    <#if (object.objectType == JiveConstants.USER)>
                    <@jive.displayUserDisplayName user=object />
                    <#elseif (object.objectType == JiveConstants.SOCIAL_GROUP)>
                    ${object.name?html}
                    <#else>
                    ${action.renderSubjectToText(object)}
                    </#if>
                </a>
                            <span>
                            <strong>
                                ${StringUtils.getTimeFromLong(object.modificationDate.time?long, 1)}
                            </strong>
                            <#if (object.objectType == JiveConstants.BLOGPOST)>
                                <span><@s.text name="main.in.label" /> <@blogPostContainerLink blogPost=object remote=remote/></span>
                            <#elseif showContainer>
                                <#if ((object.objectType != JiveConstants.USER) && (object.objectType != JiveConstants.SOCIAL_GROUP) && (object.objectType != JiveConstants.FAVORITE))>
                                    <#if (object.objectType == JiveConstants.TASK)>
                                        <#assign parent = object.parentObject!/>
                                    <#elseif object.jiveContainer?exists>
                                        <#assign parent = object.jiveContainer!/>
                                    <#else>
                                        <#assign parent = object.parentContainer!/>
                                    </#if>
                                    <#if !parent?has_content>
                                        <#assign parent = action.getPrincipalContainer(object)!/>
                                    </#if>
                                    <#if parent?has_content && parent.objectType != JiveConstants.USER_CONTAINER>
                                        <span><@s.text name="main.in.label" /> <a
                                                href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(parent, remote)}' includeParams='none'/>">${parent.name?html}</a></span>
                                    </#if>
                                </#if>
                            </#if>

                            </span>
                <#if docBeingEdited>
                            <span class="jive-currently-editing">
                                <@s.text name="community.currentlyEditBy.label" />
                                <@jive.displayUserDisplayName user=object.editUser />
                            </span>
                </#if>
            </td>
            <#if ((object.objectType != JiveConstants.USER) && (object.objectType != JiveConstants.SOCIAL_GROUP) && (object.objectType != JiveConstants.PROJECT) && (object.objectType != JiveConstants.COMMUNITY) && (object.objectType != JiveConstants.FAVORITE))>
            <td class="jive-table-cell-author">
                <#if !objectUser.anonymous>
                <span>
					<@s.text name="global.by_author">
						<@s.param><@jive.userDisplayNameLink user=objectUser remote=remote/></@s.param>
					</@s.text>					
				</span>
                <#else>
                <span>
					<@s.text name="global.by_author">
						<@s.param><@jive.renderGuestDisplayName object/></@s.param>
					</@s.text>					
				</span>
                </#if>
            </td>
            <td class="jive-table-cell-avatar"><@jive.userAvatar user=objectUser size=22 object=object remote=remote/></td>
            <#else>
            <td colspan="2"></td>
            </#if>
        </tr>
        </#list>
        </tbody>
    </table>

</div>
<#-- END jive-table -->

</#if>
</#macro>

<#macro importJavascript scripts>
<#assign mergeScript><#list scripts as script>${script}|</#list></#assign>


<script type="text/javascript" language="JavaScript"
        src="<@s.url value='/resources/merge|${mergeScript}' />"></script>

</#macro>

<#macro displayTabItems tab community=''>
<#assign visibleItems = 0>
<#if tab.items?has_content>
<#list tab.items as item>
<@isItemAllowed item ; item>
<#assign visibleItems = visibleItems + 1>
<#nested item />
</@isItemAllowed>
</#list>
</#if>
</#macro>

<#macro xyz item>
<#nested item />
</#macro>

<#macro displayTabs component community=''>
<#if component.tabs?has_content>
<#list component.tabs as tab>
<@isItemAllowed tab ; tab>
<#nested tab />
</@isItemAllowed>
</#list>
</#if>
</#macro>

<#macro isItemAllowed item >
<#if item.visible && (!item.module?has_content || isModuleAvailable(item.module!, community)) >

<#attempt>
<#assign entitled><#if item.entitled>${skin.freemarkerEntitlementTypeProvider.isEntitled(item.entitledObject?eval, item.entitledType)?string}<#else>true</#if></#assign>
<#if entitled != 'false' && (eval(item.when!'true') == 'true')>
<#nested item />
</#if>
<#recover>
<script type="text/javascript" language="JavaScript">
    alert('There was an error rendering ${item.id?js_string}');
</script>
<#nested item>
</#attempt>
</#if>
</#macro>

<#include "/template/global/include/contributed-action-links.ftl"/>

<#macro renderActionSidebar componentName contentObject='' container=''>

<#-- BEGIN sidebar box 'ACTIONS' -->
<#assign classedTabs = 0>
<#assign visibleTabs = 0>
<#assign displayedInGroup = container?? && container?has_content && container.objectType == JiveConstants.SOCIAL_GROUP &&
container.type == enums['com.jivesoftware.community.socialgroup.SocialGroup$DefaultSocialGroupType'].MEMBER_ONLY>
<@jive.displayTabs UIComponents.getUIComponent(componentName) container ; tab >
<#assign visibleActions = 0>
<div class="j-box j-box-actions" role="toolbar" aria-labelledby="jive-action-sidebar-tab-header_${tab.id}">
    <header>
        <h4 id="jive-action-sidebar-tab-header_${tab.id}"><@s.text name="${tab.name}" /></h4>
    </header>
    <div id="jive-action-sidebar_${tab.id}" class="j-box-body">

        <div id="jive-action-sidebar-tab-_${tab.id}"
                <#if classedTabs==0>
             class="jive-action-sidebar-tab-first"
                <#else>
             class="jive-action-sidebar-tab-notfirst"
                </#if> >


            <#if visibleTabs == 0 && displayedInGroup && !user.anonymous
                       && !statics['com.jivesoftware.community.util.SocialGroupPermHelper'].getCanContributeToSocialGroup(container, user)>
                <#if statics['com.jivesoftware.community.util.SocialGroupPermHelper'].getCanJoinSocialGroup(container, user)>
                    <p class="jive-sidebar-message">
                        <@s.text name='sgroup.not_member.msg'/>
                        <a class="jive-link-joinSocialGroup" href="#"> <@s.text name='sgroup.not_member.lnk'/> </a>
                    </p>
                    <#assign visibleActions = visibleActions + 1>
                <#else>
                    <p class="jive-sidebar-message"><@s.text name='sgroup.banned_member.msg'/></p>
                </#if>
            </#if>

            <ul id="jive-action-sidebar-tab-list_${tab.id}" class="${tab.cssClass?default('')} j-icon-list">
                <@jive.displayTabItems tab ; item >
                <#if item.url?has_content>
                <li id="${item.id}" style="${processAsTemplate(item.style!)}"
                        ><#compress><a href="${processAsTemplate(item.url!)}"
                            rel="nofollow"
                            onclick="${processAsTemplate(item.onclick!)}"
                            title="${processAsTemplate(item.description!)}">
                    <span class="${processAsTemplate(item.CSSClass!)}"></span>
                    <#if item.id == 'jive-link-abuse'&&(contentObject??&&contentObject?has_content&&userReportedAbuse??&&userReportedAbuse == true&&
                    contentObject.getStatus() == enums['com.jivesoftware.community.JiveContentObject$Status'].ABUSE_VISIBLE)>
                        <@s.text name="outcomes.actionMenu.item.reportedAbuse" />
                    <#else>
                        ${processAsTemplate(action.getText(item.name))}
                    </#if>

                </a></#compress></li>
                <#elseif item.include?has_content>
                <li id="${item.id}" style="${processAsTemplate(item.style!)}">
                        ${processAsTemplate(item.include)}
                </li>
                <#else>
                <li>
                    ${processAsTemplate(action.getText(item.name))}
                </li>
                </#if>
                <#assign visibleActions = visibleActions + 1>
                </@jive.displayTabItems>
            </ul>
        </div> <!-- /#jive-action-sidebar-tab-_id -->

        <#if visibleActions < 1>
            <script type="text/javascript">
                $j(document).ready(function() {
                    $j('#jive-action-sidebar-tab-_${tab.id}').hide();
                });
            </script>
            <#assign visibleTabs = visibleTabs - 1>
        <#else>
            <#assign classedTabs = classedTabs + 1>
            <#assign visibleTabs = visibleTabs + 1>
        </#if>
    </div>
    </div>

    <#if action.contributedLinks?? && action.contributedLinks.size() &gt; 0>
    <div class="j-box j-box-actions" role="toolbar" aria-labelledby="jive-action-sidebar-tab-header_${tab.id}">
        <p>&nbsp;</p>
        <header>
            <h4 id="jive-action-sidebar-tab-header_app-actions"><@s.text name="appframework.app.actions.title" /></h4>
        </header>
        <div id="jive-action-sidebar_app-actions" class="j-box-body">

            <div id="jive-action-sidebar-tab-_app-actions" class="jive-action-sidebar-tab-notfirst">
                <ul id="jive-action-sidebar-tab-list_app-actions" class="j-icon-list">
                    <@renderContributedActions/>
                </ul>
                <@renderContributedActionsToggle/>
            </div>
        </div>
    </div>
    </#if>

<!-- /.j-box-actions -->
</@jive.displayTabs>
    <#if visibleTabs < 0>
    <script type="text/javascript">
        $j(document).ready(function() {
            $j('[id^=jive-action-sidebar_]').each(function() {
                var me = $j(this);
                if (me.find("ul[id^=jive-action-sidebar-tab-list_] > li").length == 0) {
                    me.closest('.j-box-actions').hide();
                }
            });
        });
    </script>
    </#if>
<#-- END sidebar box 'ACTIONS' -->
</#macro>



<#include "/template/widget/util/widget-macros.ftl"/>

<#macro blogPostContainerLink blogPost remote=false>
<#if blogPost?exists && (blogPost.blog.userBlog || blogPost.blog.systemBlog) >
    <a href="${BlogUtils.getBlogURL(blogPost.blog)}">${blogPost.blog.name?html}</a>
<#else>
    <#if blogPost.blog?? && blogPost.blog.jiveContainer??>
        <#assign blogContainer = blogPost.blog.jiveContainer/>

        <span>
            <a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(blogContainer, remote)}'/>">${blogContainer.name?html}</a>
        </span>
    </#if>
</#if>
</#macro>

<#function getUserDisplayName(user)>
    <#if (user?has_content && !user.anonymous)>
        <#return SkinUtils.getDisplayName(user)?html />
    </#if>
    <#return "" />
</#function>


<#function isModuleAvailable(module='', community='')>
   <#if community?has_content>
    <#return jiveContext.getLicenseManager().isModuleAvailable(module, community) >
   <#else>
       <#return jiveContext.getLicenseManager().isModuleAvailable(module) >
   </#if>

</#function>

<#function isSeatStatusBlocked()>
    <#--
  ~ $Revision: 1.1 $
  ~ $Date: 2018/03/19 12:14:43 $
  ~
  ~ Copyright (C) 1999-2008 Jive Software. All rights reserved.
  ~
  ~ This software is the proprietary information of Jive Software. Use is subject to license terms.
  ~
  -->
<#return jiveContext.getLicenseManager().isSeatStatusBlocked()>
</#function>

<#macro token name noform=false lazy=false>
    <#if lazy>
        <#assign tokenGUID = '[placeholder]' />
    <#else>
        <#assign tokenGUID = statics['com.jivesoftware.community.web.struts.JiveTokenInterceptor'].setToken(name) />
    </#if>
    <#if (noform)><#compress>
        ${tokenGUID?html}
    </#compress>
    <#else>
        <input type="hidden" name="jive.token.name" value="${name}"/>
        <input type="hidden" name="${name}" value="${tokenGUID?html}"/>
    </#if>
</#macro>

<#macro recentActivityList recentActivity numResults=25 showDetail=true remote=false showAvatar=true>
    <#if recentActivity?has_content>
        <#assign activityCnt = 0 />
        <ul class="j-icon-list jive-recent-activity jive-activity-list">
            <#list recentActivity as activity>
            <#if (numResults <= 0 || activityCnt >= numResults)>
                <#break>
            </#if>
            <@recentActivityEntry activity=activity useTable=false remote=remote showDetail=showDetail showAvatar=showAvatar/>
            </#list>
        </ul>
    </#if>
</#macro>

<#macro recentActivityTable recentActivity numResults=25 showDetail=true remote=false showAvatar=true noResultsKey='activity.no_results'>
    <#-- begin jive-table jive-table-activity -->
    <div class="jive-table jive-table-activity <#if !showDetail>jive-table-activity-condensed<#else>jive-table-activity-full</#if> clearfix">
        <table>
            <#assign hasActivity = false />
            <#assign activityCnt = 0 />
            <#if recentActivity?has_content>
            <colgroup>
                <#if showDetail>
                <#if showAvatar>
                <col class="jive-table-col-avatar">
                </#if>
                <#else>
                <col class="jive-table-col-type">
                </#if>
                <col class="jive-table-col-activity">
                <col class="jive-table-col-date">
            </colgroup>
            <tbody>
            <#list recentActivity as activity>
            <#if (numResults > 0 && activityCnt >= numResults)>
            <#break>
            </#if>
            <@recentActivityEntry activity=activity remote=remote showDetail=showDetail showAvatar=showAvatar/>
            <#assign hasActivity = true />
            </#list>
            </tbody>
            </#if>
            <#if !hasActivity>
                <tr>
                    <td colspan="3">
                        <div class="jive-box-body-empty">
                            <span class="font-color-meta"><@s.text name="${noResultsKey}" /></span>

                            <#if noResultsKey == "we.connections.no_results.no_rel">
                                <p class="j-empty-call-to-action">
                                    <@s.text name="we.connections.no_results.no_rel.pt2"/>
                                    <br/>
                                    <@s.text name="we.connections.no_results.no_rel.pt3"/>
                                    <a href="#"><@s.text name="we.connections.no_results.no_rel.pt4"/></a>
                                </p>
                            <#elseif noResultsKey == "we.mentions.no_results">
                                <p class="j-empty-call-to-action">
                                    <@s.text name="we.mentions.no_results.pt2" />
                                    <br/>
                                    <@s.text name="we.mentions.no_results.pt3" />
                                </p>
                            </#if>

                        </div>
                    </td>
                </tr>
            </#if>
        </table>
    </div>
    <#-- close jive-table jive-table-activity -->

</#macro>

<#macro activityVerbPhrase activityType objectType object>
    <#if objectType == JiveConstants.THREAD>
        <#if activityType == 'created'>
            <#if (object.hasQuestion())>
                <@s.text name="activity.type.asked" />
            <#else>
                <@s.text name="activity.type.starteddiscussion" />
            </#if>
        <#else>
            <@s.text name="activity.type.${activityType}" />
        </#if>
    <#elseif (objectType == JiveConstants.BLOGPOST || objectType == JiveConstants.DOCUMENT) && (activityType == 'created')>
        <@s.text name="activity.type.wrote" />
    <#elseif (object.getObjectType() == JiveConstants.USER_STATUS)>
        <@s.text name='activity.type.status'/>
    <#elseif (object.getObjectType() == statics['com.jivesoftware.community.microblogging.WallEntry'].OBJECTID)>
        <#assign wallEntryUtil = statics['com.jivesoftware.community.microblogging.util.WallEntryUtil']/>
        <#if activityType == 'liked'>
            <@s.text name='activity.type.${activityType}'/>
        <#elseif wallEntryUtil.hasCreationSource(object)>
            <@s.text name='activity.type.status.with.source'>
                <@s.param>${wallEntryUtil.getCreationSource(object)}</@s.param>
            </@s.text>
        <#else>
            <@s.text name='activity.type.status'/>
        </#if>
    <#elseif (object.getObjectType() == JiveConstants.PROJECT_STATUS)>
        <@s.text name='activity.type.updatedStatus'/>
    <#else>
    	<#if activityType != ''>
        	<@s.text name="activity.type.${activityType}" />
      	</#if>
    </#if>
</#macro>

<#assign stringEscapeUtils = statics['org.apache.commons.lang.StringEscapeUtils'] />

<#macro recentActivityEntry activity useTable=true remote=false showDetail=true showAvatar=true>
    <#if activity.jiveObject?exists>
        <#assign object = activity.jiveObject/>
        <#if object.getObjectType() == statics['com.jivesoftware.community.acclaim.Vote'].OBJECTID>
            <#assign object = activity.containerObject.jiveObject/>
        </#if>
        <#assign provider = action.recentActivityInfoProvider(object.objectType)!>
        <#if object.getObjectType() == statics['com.jivesoftware.community.acclaim.Acclaim'].OBJECTID>
            <#assign object = object.jiveObject/>
        </#if>
        <#if provider?has_content && object?exists>
            <#-- Handle content types generically, always use absolute URL because of issues w/ s.url encoding # in certain URLs -->
            <#assign objectURL = provider.getObjectUrl(object, true) />
            <#assign jiveObjectType = ObjectTypeUtils.getJiveObjectType(object) />
            <#assign objectType = object.objectType />
            <#if  (objectType == JiveConstants.PROJECT_STATUS) || (objectURL?has_content)>
                <#assign activityCnt = activityCnt + 1 />
                <#if useTable>
                    <#if showDetail>
                        <@activityDetail activity activityCnt object objectType jiveObjectType provider objectURL showAvatar remote/>
                    <#else><#-- showDetail -->
                        <#if (object.getObjectType() == JiveConstants.PROJECT_STATUS)>
                        <#assign project = activity.containerObject>
                        <#assign objectURL = JiveResourceResolver.getJiveObjectURL(project, remote)>
                            <tr>
                                <td class="jive-table-cell-type">
                                    <span class="<@projStatusIcon status=object />"
                                          title="<@projStatusText status=object />"></span>
                                </td>
                                <td class="jive-table-cell-activity">
                                    <span><@jive.userDisplayNameLink user=activity.user remote=remote/></span>
                                    <@s.text name='activity.type.${activity.type}'/>
                                    <strong><a href="<@s.url value='${objectURL}'/>">${project.name?html}</a></strong>
                                    <@s.text name='global.lowercase.to'/> <@s.text name='global.double.quote'/><strong><@projStatusText status=object /></strong><@s.text name='global.double.quote'/>
                                </td>
                                <td class="jive-table-cell-date">
                                    <span>${StringUtils.getTimeFromLong(activity.creationDate.time?long, 1)}</span></td>
                            </tr>
                        <#else>
                            <tr>
                                <td class="jive-table-cell-type"><img class="${SkinUtils.getJiveObjectCss(object, 1)}"
                                                                      src="<@resource.url value='/images/transparent.png' forceAddSchemeHostAndPort='${remote?string}'/>"
                                                                      alt=""/></td>
                                <td class="jive-table-cell-activity">
                                    <#if !provider.hideActivityDetail?exists>
                                        <span class="jive-activity-author">
                                        <#if activity.user?? && !activity.user.anonymous>
                                            <@jive.userDisplayNameLink user=activity.user remote=remote/>
                                        <#else>
                                            <@jive.renderGuestDisplayName object/>
                                        </#if>
                                        </span>
                                    <#assign assignedUser = provider.getAssignedUser(object,activity)! />
                                    <#if assignedUser?has_content>
                                    <@s.text name='activity.type.tasked_with'><@s.param><span><@jive.userDisplayNameLink user=assignedUser remote=remote/></span></@s.param></@s.text>
                                    <#else>
                                    <@activityVerbPhrase activity.type object.objectType object />
                                    </#if>
                                    </#if>
                                    <strong><a href="${objectURL}">${action.renderSubjectToText(object)}</a></strong>
                                </td>
                                <td class="jive-table-cell-date">${StringUtils.getTimeFromLong(activity.creationDate.time?long, 1)}</td>
                            </tr>
                        </#if>
                    </#if><#-- showDetail -->


                <#-- use list item - for narrow displays -->
                <#else>


                    <#if (object.getObjectType() == JiveConstants.PROJECT_STATUS)>
                        <#assign project = activity.containerObject>
                        <#assign objectURL = JiveResourceResolver.getJiveObjectURL(project, remote)>
                        <li class="clearfix">
                            <span class="<@projStatusIcon status=object />"
                                  title="<@projStatusText status=object />"></span>

                            <span><@jive.userDisplayNameLink user=activity.user remote=remote/></span>
                            <@s.text name='activity.type.${activity.type}'/>
                            <strong><a href="<@s.url value='${objectURL}'/>">${project.name?html}</a></strong>
                            <@s.text name='global.lowercase.to'/> <@s.text name='global.double.quote'/><strong><@projStatusText status=object /></strong><@s.text name='global.double.quote'/>
                            <span>${StringUtils.getTimeFromLong(activity.creationDate.time?long, 1)}</span>
                        </li>

                    <#else>
                        <li class="clearfix">
                            <#assign iconElement = SkinUtils.getJiveObjectIcon(object, 1)! />
                            <#if iconElement??><@jive.renderIconElement iconElement /><#else>
                                <span class="${SkinUtils.getJiveObjectCss(object, 1)}"></span>
                            </#if>
                            <#if !provider.hideActivityDetail?exists>
                            <span><@jive.userDisplayNameLink user=activity.user remote=remote/></span>
                            <#assign assignedUser = provider.getAssignedUser(object,activity)! />
                            <#if assignedUser?has_content>
                            <@s.text name='activity.type.tasked_with'><@s.param><span><@jive.userDisplayNameLink user=assignedUser remote=remote/></span></@s.param></@s.text>
                            <#else>
                            <@activityVerbPhrase activity.type object.objectType object />
                            </#if>
                            </#if>

                            <#-- activity with a reference to an object stored within itself (ex: acclaim) -->
                            <#if object.jiveObject?exists>
                                <#assign object=object.jiveObject />
                            </#if>

                            <#if (objectType == JiveConstants.MESSAGE)> <#assign subjectObject=object.forumThread /> <#else> <#assign subjectObject=object /> </#if>
                            <strong><a href="${objectURL}">${action.renderSubjectToText(subjectObject)}</a></strong>
                            <span>${StringUtils.getTimeFromLong(activity.creationDate.time?long, 1)}</span>
                        </li>

                    </#if>

                </#if> <#-- end list item -->

            </#if>

        </#if>
    </#if>
</#macro>

<#macro activityDetail activity activityCnt object objectType jiveObjectType provider objectURL showAvatar remote=false>
        <#local wallClass= ""/>
        <#if (objectType == JiveConstants.COMMENT && object.commentContentResource.objectType == statics['com.jivesoftware.community.microblogging.WallEntry'].OBJECTID)>
            <#local wallClass = "j-wall-comment"/>
        <#elseif (object.objectType == statics['com.jivesoftware.community.microblogging.WallEntry'].OBJECTID && activity.type != "liked")>
            <#local wallClass = "j-wall-entry"/>
        <#elseif (activity.jiveObject.objectType == statics['com.jivesoftware.community.acclaim.Acclaim'].OBJECTID)>
            <#local wallClass = "j-acclaim-entry"/>
        </#if>
        <tr class="<#if (activityCnt % 2 == 0)>jive-table-row-even<#else>jive-table-row-odd</#if> ${wallClass}">
            <#if showAvatar>
            <td class="jive-table-cell-avatar"><@jive.userAvatar user=activity.user object=object size=32 remote=remote /></td>
            </#if>
            <td class="jive-table-cell-activity">
                <span class="jive-activity-author">
                    <#if activity.user?? && !activity.user.anonymous><@jive.userDisplayNameLink user=activity.user remote=remote /> <#else><@jive.renderGuestDisplayName object/> </#if> <#-- line breaks and spacing is intentional, an nbsp is too much space -->
                    <#assign assignedUser = provider.getAssignedUser(object,activity)! />
                    <#if assignedUser?has_content>
                    <@s.text name='activity.type.tasked_with'><@s.param><span><@jive.userDisplayNameLink user=assignedUser remote=remote/></span></@s.param></@s.text>
                    <#else>
                        <@activityVerbPhrase activity.type object.objectType object />
                    </#if>
                    <#if (objectType == JiveConstants.PROJECT_STATUS)>
                    <#assign project = activity.containerObject>
                    <#local objectURL = JiveResourceResolver.getJiveObjectURL(project, remote)>
                        <a href="<@s.url value='${objectURL}'/>">${project.name?html}</a> <@s.text name='global.lowercase.to'/>
                    </#if>
                </span>
                <#if activity.type == "liked">
                    <#assign template = skin.recentActivity.getDetailedTemplateName(activity.jiveObject.objectType)!/>
                <#else>
                    <#assign template = skin.recentActivity.getDetailedTemplateName(objectType)!/>
                </#if>
                <#if template?has_content>
                <#include template/>
                <#elseif (objectType == JiveConstants.PROJECT_STATUS)>
                    <div class="jive-activity-status">
                        <span class="<@projStatusIcon status=object />">
                               <img src="<@resource.url value='/images/transparent.png' forceAddSchemeHostAndPort='${remote?string}'/>"
                                    alt="" class="jive-icon-med <@projStatusIcon status=object />"/> <@s.text name='global.double.quote'/><@projStatusText status=object /><@s.text name='global.double.quote'/>
                        </span>
                    </div>

                <#else>

                <#-- Handle content types generically, always use absolute URL because of issues w/ s.url encoding # in certain URLs -->

                <#-- The main subject for discussion replies in the thread, not the actual message -->
                <#if (objectType == JiveConstants.MESSAGE)>
                <#assign subjectObject=object.forumThread />
                <#else>
                <#assign subjectObject=object />
                </#if>

                <span class="jive-activity-title">
                    <#assign iconElement = SkinUtils.getJiveObjectIcon(object, 1)! />
                    <#if iconElement??><@jive.renderIconElement iconElement /><#else>
                        <a href="${objectURL}"><img src="<@resource.url value='/images/transparent.png' forceAddSchemeHostAndPort='${remote?string}'/>"
                         alt=""
                         class="jive-icon-med ${SkinUtils.getJiveObjectCss(object, 1)}" /></a>
                    </#if>
                    <a href="${objectURL}">${action.renderSubjectToText(subjectObject)}</a>
                </span>

                <div class="jive-activity-content">

                    <#if (objectType == JiveConstants.DOCUMENT) && conversionManager.isConvertable(object)>
                    <a href="${objectURL}"><img class="jive-activity-thumbnail" src="<@s.url value="/__services/v2/rest/office/d/pageThumbnail" forceAddSchemeHostAndPort='${remote?string}'>
                            <@s.param name="PermissionId">${object.objectType?c}_${object.ID?c}_${object.versionID?c}</@s.param>
                            <@s.param name="PageNumber">1</@s.param>
                            </@s.url>" onerror="$j(this).hide()"/></a>
                    </#if>

                    <#if objectType != JiveConstants.EXTERNAL_URL && objectType != JiveConstants.SOCIAL_GROUP>
                        <#assign text="${action.renderToText(object)}"/>
                    </#if>

                    <#if text?has_content>
                        <#if stringEscapeUtils.unescapeHtml(text)?length < 140>
                            <#assign preview=text?substring(0,text?length)/>
                        <#else>
                            <#assign preview=stringEscapeUtils.escapeHtml(stringEscapeUtils.unescapeHtml(text)?substring(0,140))/>
                        </#if>
                        <p><@s.text name='global.double.quote'/>${preview?trim}<@s.text name='global.double.quote'/></p>
                    </#if>

                    <#if objectType == JiveConstants.POLL>
                    <p>
                        <@s.text name="activity.poll.Xtotalvotes">
                            <@s.param>${object.getVoteCount()}</@s.param>
                        </@s.text>

                        <#if (object.getVoteCount() > 1)>
                            <#assign leadingIndex = object.leadingOptionIndex />
                            <#if (leadingIndex > -1)>
                                .&nbsp;&nbsp;
                                <@s.text name="activity.poll.currentlyaheadX">
                                    <@s.param><strong>${object.getOptions().get(object.leadingOptionIndex).text?html}</strong></@s.param>
                                </@s.text>
                            </#if>
                        </#if>
                    </p>
                    </#if>

                    <#--
                        CS-16354 -- it seems that the previous assign to the text variable will not be
                        cleared in action.renderToText(object) fails in some way. Therefore, we'll manually
                        clear the variable after we're done using it.
                    -->
                    <#assign text=""/>
                    <#assign preview=""/>

                    <@activityDetailContainerMeta activity object objectType jiveObjectType remote/>
                </div>


                </#if><#-- specific type activity -->

            </td>
            <td class="jive-table-cell-date">${StringUtils.getTimeFromLong(activity.creationDate.time?long, 1)}</td>
        </tr>

</#macro>

<#macro activityDetailContainerMeta activity object objectType jiveObjectType remote=false>
        <#assign wallEntryComment = object>
        <span class="jive-activity-details">
            <#assign objectTypeUtils = statics['com.jivesoftware.community.objecttype.ObjectTypeUtils'] >
            <#-- use the activity user for "in ..." for favorites -->
            <#if objectType == JiveConstants.FAVORITE || objectType == JiveConstants.EXTERNAL_URL>
                <#assign typeName = objectTypeUtils.getContentTypeFeatureName(activity.jiveObject, locale)!/>
                <@s.text name="main.in_user_container.label">
                    <@s.param><@jive.userDisplayNameLink user=activity.user remote=remote/></@s.param>
                    <@s.param>${typeName}</@s.param>
                </@s.text>
                <@activityDetailObjectMeta object objectType jiveObjectType/>
            <#else>
                <#-- parent will be a JiveContainer or a Blog -->
                <#assign parent = provider.getContainerObject(activity)!/>
                <#if parent?has_content>
                    <#if (parent.objectType == JiveConstants.USER_CONTAINER)>
                        <#if objectType == JiveConstants.COMMENT && (wallEntryComment.commentContentResource.objectType == statics['com.jivesoftware.community.microblogging.WallEntry'].OBJECTID)>
                            <#-- get the commented object for the correct object typeName and meta data -->
                            <#local object = activity.jiveObject.commentContentResource/>
                            <#local jiveObjectType = ObjectTypeUtils.getJiveObjectType(object) />
                            <#assign typeName = objectTypeUtils.getContentTypeFeatureName(object, locale)!/>
                        <#else>
                            <#assign typeName = objectTypeUtils.getContentTypeFeatureName(activity.jiveObject, locale)!/>
                        </#if>

                        <#if (objectType == JiveConstants.COMMENT && wallEntryComment.commentContentResource.objectType == statics['com.jivesoftware.community.microblogging.WallEntry'].OBJECTID)>
                        <@s.text name="activity.in_user_container.we"></@s.text>
                        <@jive.containerDisplayNameLink container=parent remote=remote wallentry=true/>

                        <#else>
                        <@s.text name="main.in_user_container.label">
                            <@s.param><@jive.containerDisplayNameLink container=parent remote=remote /></@s.param>
                            <@s.param>${typeName}</@s.param>
                        </@s.text>
                        </#if>

                        <@activityDetailObjectMeta object objectType jiveObjectType/>
                    <#else>
                        <#if objectType == JiveConstants.COMMENT>
                            <#-- get the commented object for meta data -->
                            <#local object = object.commentContentResource/>
                            <#local jiveObjectType = ObjectTypeUtils.getJiveObjectType(object) />
                            <#-- skip comments on external URL bookmarks since they don't live inside a container other than the root -->
                            <#if object.objectType == JiveConstants.EXTERNAL_URL>
                                <@activityDetailObjectMeta object objectType jiveObjectType false />
                            <#else>
                                <@s.text name="main.in.label" /> <@jive.containerDisplayNameLink container=parent remote=remote />
                                <@activityDetailObjectMeta object objectType jiveObjectType/>
                            </#if>
                        <#else>
                            <@s.text name="main.in.label" /> <@jive.containerDisplayNameLink container=parent remote=remote />
                            <@activityDetailObjectMeta object objectType jiveObjectType/>
                        </#if>
                    </#if>
                <#else>
                    <@activityDetailObjectMeta object objectType jiveObjectType/>
                </#if>
            </#if>

        </span>

</#macro>

<#macro activityDetailObjectMeta object objectType jiveObjectType prependWithDash=true>
        <#if object.commentDelegator?exists>
            <span class="j-bullet">&#8226;</span> ${object.commentDelegator.commentCount}&nbsp;<@s.text name="activity.commentcount"/>
        </#if>
        <#if jiveObjectType.favoriteInfoProvider?exists>
            <#if prependWithDash> <span class="j-bullet">&#8226;</span> </#if>${action.getFavoriteCount(object)}&nbsp;<@s.text name="activity.bookmarkcount" />
        </#if>
        <#if objectType == JiveConstants.MESSAGE>
            <#assign replyCount = subjectObject.messageCount-1>
            <#if (replyCount > 0)>
                <span class="j-bullet">&#8226;</span> ${replyCount}&nbsp;<@s.text name="activity.replycount" />
            <#else>
                <span class="j-bullet">&#8226;</span> <@s.text name="activity.noreplies" />
            </#if>
        </#if>
      <#if objectType == JiveConstants.TASK && object.dueDate?exists>
            <span class="j-bullet">&#8226;</span> <@s.text name="activity.task.due"><@s.param>${object.dueDate?date?string.short}</@s.param></@s.text>
      </#if>
      <#if jiveObjectType.ID == statics['com.jivesoftware.community.acclaim.Acclaim'].OBJECTID>
            <span class="j-bullet">&#8226;</span> ${object.score}&nbsp;<@s.text name="activity.likecount" />
      </#if>

</#macro>

<#-- Used to create class names string to replace project icon with the project status -->
<#macro projStatusIcon status>
    <#if status.type?exists>
        <#if (enums["com.jivesoftware.community.project.ProjectStatus$Type"].LOW == status.type)>
            jive-icon-med jive-icon-project-status-low
        <#elseif (enums["com.jivesoftware.community.project.ProjectStatus$Type"].MEDIUM == status.type)>
            jive-icon-med jive-icon-project-status-med
        <#elseif (enums["com.jivesoftware.community.project.ProjectStatus$Type"].HIGH == status.type)>
            jive-icon-med jive-icon-project-status-high
        <#elseif (enums["com.jivesoftware.community.project.ProjectStatus$Type"].COMPLETE == status.type)>
            jive-icon-med jive-icon-project-status-complete
        </#if>
    </#if>
</#macro>

<#macro projStatusIconText status>
    <#if status.type?exists>
        <#if (enums["com.jivesoftware.community.project.ProjectStatus$Type"].LOW == status.type)>
            <span class="j-proj-status j-proj-status-low font-color-status-low"><@s.text name="project.status.type.low" /></span>
        <#elseif (enums["com.jivesoftware.community.project.ProjectStatus$Type"].MEDIUM == status.type)>
            <span class="j-proj-status j-proj-status-med font-color-status-med"><@s.text name="project.status.type.med" /></span>
        <#elseif (enums["com.jivesoftware.community.project.ProjectStatus$Type"].HIGH == status.type)>
            <span class="j-proj-status j-proj-status-high font-color-status-high"><@s.text name="project.status.type.high" /></span>
        <#elseif (enums["com.jivesoftware.community.project.ProjectStatus$Type"].COMPLETE == status.type)>
            <span class="j-proj-status j-proj-status-complete font-color-status-complete"><@s.text name="project.status.type.complete" /></span>
        </#if>
    </#if>
</#macro>

<#-- Just project status enum text -->
<#macro projStatusText status>
<#compress>
        <#if status.type?exists>
            <#if (enums["com.jivesoftware.community.project.ProjectStatus$Type"].LOW == status.type)>
                <@s.text name="project.status.type.low" /><#if status.description?exists><@s.text name="global.colon"/> ${status.description}</#if>
            <#elseif (enums["com.jivesoftware.community.project.ProjectStatus$Type"].MEDIUM == status.type)>
                <@s.text name="project.status.type.med" /><#if status.description?exists><@s.text name="global.colon"/> ${status.description}</#if>
            <#elseif (enums["com.jivesoftware.community.project.ProjectStatus$Type"].HIGH == status.type)>
                <@s.text name="project.status.type.high" /><#if status.description?exists><@s.text name="global.colon"/> ${status.description}</#if>
            <#elseif (enums["com.jivesoftware.community.project.ProjectStatus$Type"].COMPLETE == status.type)>
                <@s.text name="project.status.type.complete" /><#if status.description?exists><@s.text name="global.colon"/> ${status.description}</#if>
            </#if>

        </#if>
</#compress>
</#macro>

<#-- No project status description, just status indicator and text -->
<#macro smallStatus status>
    <#if status.type?exists>
        <#if (enums["com.jivesoftware.community.project.ProjectStatus$Type"].LOW == status.type)>
            <span class="j-proj-status j-proj-status-low font-color-status-low"><span class="jive-icon-med jive-icon-project-status-low"></span> <@s.text name="project.status.type.low" /></span>
        <#elseif (enums["com.jivesoftware.community.project.ProjectStatus$Type"].MEDIUM == status.type)>
            <span class="j-proj-status j-proj-status-med font-color-status-med"><span class="jive-icon-med jive-icon-project-status-med"></span> <@s.text name="project.status.type.med" /></span>
        <#elseif (enums["com.jivesoftware.community.project.ProjectStatus$Type"].HIGH == status.type)>
            <span class="j-proj-status j-proj-status-high font-color-status-high"><span class="jive-icon-med jive-icon-project-status-high"></span> <@s.text name="project.status.type.high" /></span>
        <#elseif (enums["com.jivesoftware.community.project.ProjectStatus$Type"].COMPLETE == status.type)>
            <span class="j-proj-status j-proj-status-complete font-color-status-complete"><span class="jive-icon-med jive-icon-project-status-complete"></span> <@s.text name="project.status.type.complete" /></span>
        </#if>
    </#if>
</#macro>


<#-- Dynamic object type widget-properties -->
<#macro dynObjWidgetProps map>
<#assign objectTypeUtils = statics['com.jivesoftware.community.objecttype.ObjectTypeUtils'] >

<#list map.keySet() as objectTypeId>
		<#if objectTypeId == JiveConstants.BLOGPOST>
            <#assign typeName = "blogpost"?string/>
            <#assign i18nKeyPrefix = "blogpost"?string />
	  <#else>
			<#assign typeName = objectTypeUtils.getJiveObjectType(objectTypeId).code?lower_case/>
			<#assign i18nKeyPrefix = objectTypeUtils.getI18nKeyPrefixFromType(objectTypeId) />
	   </#if>    

    <#if (widgetTitle == action.getText("widget.tagcloud.title"))>
        <div class="jive-widget-edit-elem-title"><@s.text name="${i18nKeyPrefix}.tcw.display.name" />:</div>
    <#elseif (widgetTitle == action.getText("widget.topliked.title"))>
        <div class="jive-widget-edit-elem-title"><@s.text name="${i18nKeyPrefix}.tlw.display.name" />:</div>
    <#elseif (widgetTitle == action.getText("widget.toprated.title"))>
        <div class="jive-widget-edit-elem-title"><@s.text name="${i18nKeyPrefix}.trw.display.name" />:</div>
    <#else>
        <div class="jive-widget-edit-elem-title"><@s.text name="${i18nKeyPrefix}.rcw.display.name" />:</div>
    </#if>

    <#assign booleanValue = ("true" == map.get(objectTypeId)?string?lower_case)/>
    <input type="radio" name="${typeName?html}" id="rb-${typeName?html}-1" value="true"
           <#if booleanValue>checked="checked"</#if>/>
    <label for="rb-${typeName?html}-1"><@s.text name='global.yes'/></label>
    <input type="radio" name="${typeName?html}" id="rb-${typeName?html}-2" value="false"
           <#if !booleanValue>checked="checked"</#if>/>
    <label for="rb-${typeName?html}-2"><@s.text name='global.no'/></label>
</#list>
</#macro>

<#-- Dynamic object type widget-properties for remote widgets -->
<#macro remoteDynObjectWidgetProps props>
    <#if props?has_content>
        <#list props as wsTypedProperty>
            <div class="jive-widget-edit-elem-title">${wsTypedProperty.label?html}:</div>
            <div class="jive-widget-edit-elem-desc">${wsTypedProperty.shortDescription?html}</div>
            <#assign booleanValue = ("true" == wsTypedProperty.value?lower_case)/>
            <input type="radio" name="${wsTypedProperty.objectTypeName?html}"
                   id="rb-${wsTypedProperty.objectTypeName?html}-1" value="true"
                   <#if booleanValue>checked="checked"</#if>/>
            <label for="rb-${wsTypedProperty.objectTypeName?html}-1"><@s.text name='global.yes'/></label>
            <input type="radio" name="${wsTypedProperty.objectTypeName?html}"
                   id="rb-${wsTypedProperty.objectTypeName?html}-2" value="false"
                   <#if !booleanValue>checked="checked"</#if>/>
            <label for="rb-${wsTypedProperty.objectTypeName?html}-2"><@s.text name='global.no'/></label>
        </#list>
    </#if>
</#macro>

<#macro showMovedMesage content container>
    <#compress>
        <#if (prevContainer?exists)>
            <div class="jive-success-box" aria-live="polite" aria-atomic="true">
                <div>
                    <span class="jive-icon-med jive-icon-check"></span>
                    <@s.text name="content.mv.success">
                    <@s.param>${action.getContentTypeName(content.objectType)}</@s.param>
                    <@s.param><@jive.containerDisplayNameLink container=prevContainer remote=false showFullIcon=true /></@s.param>
                    <@s.param><@jive.containerDisplayNameLink container=container remote=false showFullIcon=true /></@s.param>
                    </@s.text>
                </div>
            </div>
        </#if>
    </#compress>
</#macro>

<#macro defaultActionErrorsAndMessages>
    <#compress>
        <#if !actionErrors.empty>
                <div id="jive-error-box" class="jive-error-box" style="display:none;" aria-live="polite" aria-atomic="true">
                    <div>
                        <span class="jive-icon-med jive-icon-redalert"></span>
                        <#list actionErrors as actionError>
                        ${actionError}
                        </#list>
                    </div>
                </div>
                <script type="text/javascript">
                    $j(document).ready(function() {
                        $j('#jive-error-box').fadeIn();
                    });
                </script>
            <#elseif !actionMessages.empty>
                <div id="jive-success-box" class="jive-success-box" style="display:none;" aria-live="polite" aria-atomic="true">
                    <div>
                        <span class="jive-icon-med jive-icon-check"></span>
                        <#list actionMessages as actionMessage>
                        ${actionMessage}
                        </#list>
                    </div>
                </div>
                <script type="text/javascript">
                    $j(document).ready(function() {
                        $j('#jive-success-box').fadeIn( function() { setTimeout( function() { $j("#jive-success-box").fadeOut("slow"); }, 5000); });
                    });
                </script>
            </#if>
    </#compress>
</#macro>

<#macro renderGuestDisplayName message>
    <#assign guestName = ''>
    <#assign guestEmail = ''>

    <#if message.objectType == JiveConstants.THREAD>
        <#assign guestName = message.getRootMessage().getProperties().get("name")?default('')>
        <#assign guestEmail = message.getRootMessage().getProperties().get("email")?default('')>
    <#elseif message.objectType == JiveConstants.MESSAGE>
        <#assign guestName = message.getProperties().get("name")?default('')>
        <#assign guestEmail = message.getProperties().get("email")?default('')>
    </#if>

    <#if guestName?has_content>
        ${guestName?html}
    <#elseif guestEmail?has_content>
        ${guestEmail?html}
    <#else>
        ${action.getText("global.guest")}
    </#if>
</#macro>

<#macro featureContentObject objectType objectID containerType containerID>
    <#include "/template/global/include/featureable-javascript.ftl"/>
</#macro>

<#macro oldUserAutocompleteUsers user='' users='' emails='' varName="startingUsers" includeAvatars=true>
    var ${varName} = [];
    <#if emails?has_content>
    <#list emails as email>
        ${varName}.push({
            userID: 'email',
            avatar: '<span class="jive-icon-glyph icon-envelope"></span>',
            displayName: '${email?js_string}'
        });
    </#list>
    </#if>
    <#if user?has_content>
        <#assign avatar><#if includeAvatars><@userAvatar user=user size=22 useLinks=false showHover=false/></#if></#assign>
        <#assign displayName><@displayUserDisplayName user=user /></#assign>
        ${varName}.push({
            userID: '${user.ID?c}',
            userName : '${user.username?js_string}',
            avatar: '${avatar?js_string}',
            displayName: '${displayName?js_string}'
        });
    </#if>
    <#if users?has_content>
    <#list users as user>
        <#assign avatar><#if includeAvatars><@userAvatar user=user size=22 useLinks=false showHover=false/></#if></#assign>
        <#assign displayName><@displayUserDisplayName user=user /></#assign>
        ${varName}.push({
            userID: '${user.ID?c}',
            userName : '${user.username?js_string}',
            avatar: '${avatar?js_string}',
            displayName: '${displayName?js_string}'
        });
    </#list>
    </#if>
</#macro>

<#macro userAutocompleteUsers user='' users='' emails='' varName="startingUsers" includeAvatars=true>
  (function(){
      var obj = {};
      obj.userlists = [];
      obj.users = [];
      <#if emails?has_content>
        <#list emails as email>
            obj.users.push({
                userID: 'email',
                avatar: '<span class="jive-icon-glyph icon-envelope"></span> ',
                displayName: '${email?js_string}'
            });
        </#list>
      </#if>
      <#if user?has_content>
          obj.users.push({
              id: '<#if user.ID?is_number>${user.ID?c}<#else>${user.ID}</#if>',
              anonymous : <#if user.anonymous>true<#else>false</#if>,
              enabled: <#if user.enabled>true<#else>false</#if>,
              objectType : ${user.objectType},
              username : '${user.username?js_string}',
              email : '${user.email!?js_string}',
              entitled : <#if user.entitled>true<#else>false</#if>,
              avatarID: '<#if user.avatarID?is_number>${user.avatarID?c}<#else>${user.avatarID}</#if>',
              displayName: '${user.displayName?js_string}',
              visible: <#if user.visible>true<#else>false</#if>,
              partner: <#if user.partner>true<#else>false</#if>,
              prop: {isVisibleToPartner: <#if user.prop?? && user.prop['isVisibleToPartner']>true<#else>false</#if>}
 });
</#if>
<#if users?has_content>
<#list users as user>
   obj.users.push({
       id: '<#if user.ID?is_number>${user.ID?c}<#else>${user.ID}</#if>',
       anonymous : <#if user.anonymous>true<#else>false</#if>,
       enabled: <#if user.enabled>true<#else>false</#if>,
       objectType : ${user.objectType},
       username : '${user.username?js_string}',
       email : '${user.email!?js_string}',
       entitled : <#if user.entitled>true<#else>false</#if>,
       avatarID: '${user.avatarID?js_string}',
       displayName: '${user.displayName?js_string}'
   });
</#list>
</#if>
return obj;
})();
</#macro>

<#-- inserts bridge reply links below the RTE for docs, blog posts, discussions, and comments -->
<#macro bridgedContentReply object container actionUrl reply=false comment=false loadJS=false>
    <#if loadJS>
        <@resource.javascript file="/resources/scripts/jive/bridge-bar.js"  />
    </#if>
    <@s.action name="bridge-reply!input" executeResult="true" ignoreContextParams="true">
        <@s.param name="object">${object.ID?c}</@s.param>
        <@s.param name="contentObjectType">${object.objectType?c}</@s.param>
        <@s.param name="container">${container.ID?c}</@s.param>
        <@s.param name="containerType">${container.objectType?c}</@s.param>
        <@s.param name="actionUrl">${actionUrl}</@s.param>
        <@s.param name="reply">${reply?string}</@s.param>
        <@s.param name="comment">${comment?string}</@s.param>
    </@s.action>
</#macro>

<#-- shows the ratings UI that is typically displayed below a content type, includes the UI for rating a content type-->
<#macro ratings container object shortObjectType allowComments=true>
    <#if action.isRatingsEnabled(object)>
        <#assign guid>${statics['org.apache.struts2.util.TokenHelper'].generateGUID()?html}</#assign>
        <div class="jive-content-rating j-rc5 clearfix" data-guid="${guid?html}">
            <#include "/template/global/include/rate.ftl"/>
        </div>
    </#if>
</#macro>

<#macro previewableBinaryViewLink pb title>

    <#if conversionManager.isConvertable(pb) >
        <@resource.javascript file="/resources/scripts/conversion/previewable-binary-lightbox.js"  />

        <a href="#" onClick="showPreviewableBinary('<@s.url action="conversion-viewer-overlay"><@s.param name="objectID">${pb.ID?c}</@s.param><@s.param name="objectType">${pb.objectType?c}</@s.param></@s.url>', '${title}');return false;"><@s.text name="global.preview"/></a>
    </#if>

</#macro>

<#macro renderPresence user postfix=''>
    <#if postfix != ''>
    <#include "/template/global/include/presence.ftl"/>
    </#if>
</#macro>

<#macro acclaim object ratingType='like' uniqueValue='' iconClass='jive-icon-like' anchorClass='' containerClass='' templatePath='/template/global/include/acclaim.ftl' alterClass='' isButton=false>
    <#if action.isAcclaimEnabled(object.objectType, ratingType)>
        <#include templatePath/>
    <#elseif containerClass != ''>
        <script type="text/javascript">$j(document).ready(function() {$j('.${containerClass}').hide()});</script>
    </#if>
</#macro>

<#macro renderSmallAcclaimScore type object>
    <#if type == "like">
        <span id="acclaim-smallscoredisplay-${object.jiveObjectDescriptor.objectType?c}-${object.jiveObjectDescriptor.ID?c}" class="jive-acclaim-smallscore">
            ${object.scoreDisplay}
        </span>
    </#if>
</#macro>

<#macro displayViewCount viewCount includeContainer=true containerType='span' containerClass='jive-content-footer-item'>
    <#if viewCount &gt; -1> <#-- view count less than 0 means view counts are disabled -->
        <#if includeContainer><${containerType} class="${containerClass}"></#if>
            ${viewCount?c}&nbsp;<#if viewCount == 1><@s.text name="global.view.noun"/><#else><@s.text name="global.views"/></#if>
        <#if includeContainer></${containerType}></#if>
    </#if>

</#macro>

<#macro renderIconElement icon>
    <#switch icon.tag>
        <#case "img">
            <img <@jive.renderIconElementAttrs data=icon />/>
        <#break>
        <#case "span">
            <span <@jive.renderIconElementAttrs data=icon /> ></span>
        <#break>
        <#case "div">
            <div <@jive.renderIconElementAttrs data=icon /> ></div>
        <#default>
    </#switch>
</#macro>

<#macro renderIconElementAttrs data>
    <#list data.attributeNames as name>
        <#if name = 'title'>
             ${name}="<@s.text name='${data.attributes.get(name)}'/>"
        <#else/>
            ${name}="${data.attributes.get(name)}"
        </#if>
    </#list>
</#macro>

<#macro socialActions user followable followed streamsAssociatedCount contentObject likeObject objectTypeDescriptor favoritesEnabled shareEnabled mbCreationModerated=false>
    <#assign likeable = action.isAcclaimEnabled(likeObject.objectType, "like") />

    <a href="#" id="mobile-sidenav-btn"></a>

    <#if !user.anonymous >
    <div class="j-box j-social-actions">
        <ul class="j-icon-list clearfix" role="toolbar" aria-label="<@s.text name="browse.action.label"/>">
            <#-- Follow / Stop Following -->
            <#if user?exists && followable>
                <li class="j-js-follow-controls" data-streamsassoc="${streamsAssociatedCount?c}" data-location='jive-macros' aria-live="polite" aria-atomic="true">
                    <a id="jive-link-${objectTypeDescriptor}-startFollowing"  style="<#if followed>display: none;</#if>" href="#" class="j-social-action">
                        <span class="jive-icon-glyph icon-pulse"></span>
                        <@s.text name="global.follow"/>
                    </a>
                    <a id="jive-link-${objectTypeDescriptor}-following"  style="<#if !followed>display: none;</#if>" href="#" class="j-social-action">
                        <span class="jive-icon-glyph icon-plus-circle2"></span>
                        <span class="j-js-streams-assoc-count j-instream-count">
                            <#if 0 < streamsAssociatedCount>
                                <@s.text name="profile.friends.following.nonstream.link">
                                    <@s.param><span class="jive-icon-glyph icon-pulse j-instreamicon"></span> ${streamsAssociatedCount?c}</@s.param>
                                </@s.text>
                            </#if>
                        </span>
                    </a>
                </li>
            </#if>

            <#-- Share -->
            <#if shareEnabled && user?exists>
                <li>
                    <#-- This is duplicated in share.soy (jive.soy.share.control) -->
                    <a href="#" class="j-social-action" data-command="share" data-object-id="${contentObject.ID?c}" data-object-type="${contentObject.objectType?c}">
                        <span>
                            <span class="jive-icon-glyph icon-share2"></span>
                            <@s.text name="share.link"/>
                        </span>
                    </a>
                </li>
            </#if>

            <#-- Bookmark -->
            <#if favoritesEnabled>
                <li<#if !likeable> class="last"</#if>>
                    <#assign favoritedObject = contentObject /><#include "/template/favorites/include/create-favorite-sidebar-include.ftl" />
                </li>
            </#if>

            <#-- Repost (for status updates) -->
            <#if contentObject.objectType == JiveConstants.WALL_ENTRY && contentObject.containerType == JiveConstants.USER_CONTAINER>
                <li class="j-repost-item" id="j-repost-item-${contentObject.ID?c}" data-statusid="${contentObject.ID?c}" mb-creation-moderated="${mbCreationModerated?string}">
                    <a href="#" name='${contentObject.ID?c}' class="j-repost j-social-action">
                        <span class="jive-icon-glyph  icon-loop"></span>
                        <@s.text name='eae.menu.repost'/>
                    </a>

                    <div class="jive-modal j-repost-modal" id="j-repost-modal-${contentObject.ID?c}" style="width:700px;">

                        <header>
                            <h2><@s.text name='eae.mb.repost.default.text'/></h2>
                        </header>
                        <label class="j-508-label" id="close-modal-508"><@s.text name="global.close.modal"/></label>
                        <a href="#" class="j-modal-close-top close" aria-labelledby="close-modal-508" title="<@s.text name="global.close.modal"/>"><@s.text name='global.close'/> <span class="j-close-icon j-ui-elem" role="img"></span></a>


                        <article class="j-act-mb">
                            <section class="jive-modal-content clearfix">
                                <@we.displayWallEntryRepost repost=contentObject isSingleEntryView=true/>

                                <h4><@s.text name='we.repost.comment'/></h4>
                                <div id="j-repost-form-placeholder-${object.ID?c}"></div>
                            </section>
                        </article>
                    </div>
                </li>
            </#if>

            <#-- Like -->
            <#if likeable>
                <li class="last">
                    <@jive.acclaim object=likeObject ratingType="like" isButton=true/>
                </li>
            </#if>

            <script>
                $j(function() {
                    /*
                    * Oh how I wish I didn't have to do it this way.
                    *
                    * it's JS instead of CSS because the hovered element affects the parent.
                    * it's delegate instead of simple event binding because the bookmark element gets replaced when the user takes action.
                    *
                     */
                    $j('.j-social-actions').delegate('a.j-social-action', 'mouseover', function() {
                        $j(this).closest('li').addClass('hover');
                    }).delegate('a.j-social-action', 'mouseout', function() {
                        $j(this).closest('li').removeClass('hover');
                    }).delegate('a.j-social-action', 'mousedown', function() {
                        $j(this).closest('li').addClass('active');
                    }).delegate('a.j-social-action', 'mouseup', function() {
                        $j(this).closest('li').removeClass('active');
                    })


                })
            </script>

        </ul>
    </div>
    </#if>
</#macro>

<#macro viewersList viewers>
    <@resource.javascript ajaxOutput="true">
        $j(function() {
            $j('.jive-shared-list-toggle').click(function() {
                $j('.jive-shared-list-short').toggle();
                $j('.jive-shared-list-all').toggle();
                return false;
            });
        });
    </@resource.javascript>
    <span class="jive-shared-list jive-shared-list-short">
        <!-- visible to specific people -->
        <img src="<@s.url value='/images/transparent.png' />" title="" class="jive-icon-sml jive-icon-content-private-shared"/>
        <#list viewers as user>
            <@jive.userDisplayNameLink user=user/>
            <#if user_index == 3>
                <#break>
            <#else>
                <#if user_has_next>, </#if><#lt>
            </#if>
        </#list>
        <#if (viewers.size() > 4)>
            <!-- show max of 5, then do show/hide of rest -->
            ... (<a href="#" class="jive-shared-list-toggle jiveSharedShowAll"><@s.text name="eae.direct_message.showall"/></a>)
        </#if>
    </span>
    <#if (viewers.size() > 4)>
        <span class="jive-shared-list jive-shared-list-all" style="display: none;">
            <img src="<@s.url value='/images/transparent.png' />" title="" class="jive-icon-sml jive-icon-content-private-shared"/>
            <#list viewers as user>
                <@jive.userDisplayNameLink user=user/>
                <#if user_has_next>, </#if><#lt>
            </#list>
            &nbsp;(<a href="#" class="jive-shared-list-toggle jiveSharedShowLess"><@s.text name="eae.direct_message.showless"/></a>)
        </span>
    </#if>
</#macro>


<!-- macro to display the generic warning about the content object being in moderation, abuse hidden, or rejected -->
<#macro displayModerationStatus contentObject>

    <#if (contentObject.getStatus() == enums['com.jivesoftware.community.JiveContentObject$Status'].AWAITING_MODERATION)>
        <div class="jive-content-moderation-box" >
            <span class="jive-icon-med jive-icon-warn"></span><@s.text name="mod.content.view" />
        </div>
    </#if>

    <#if (contentObject.getStatus() == enums['com.jivesoftware.community.JiveContentObject$Status'].ABUSE_HIDDEN)>
        <div class="jive-content-moderation-box" >
            <span class="jive-icon-med jive-icon-warn"></span><@s.text name="mod.content.view" />
        </div>
    </#if>

    <#if (contentObject.getStatus() == enums['com.jivesoftware.community.JiveContentObject$Status'].REJECTED)>
        <div class="jive-error-box" aria-live="polite" aria-atomic="true">
            <div>
            <span class="jive-icon-med jive-icon-redalert"></span>
            <@s.text name="mod.content.rejected" />
            </div>
        </div>

    </#if>
</#macro>

<#macro postedOnBehalfContent user onBehalfVia onBehalfUser content>
    <@s.text name="tse.XpostedonbehalfofY">
        <@s.param>
        <strong class="font-color-normal">
            <#if onBehalfVia != "" >  <#--if exist, adds a "via APPLICATION" text-->
                <#assign appExternalURL = SkinUtils.getSpaceExternalURL(content) />
                <#if appExternalURL?exists>
                    <a href="<@s.url value='${appExternalURL}'/>">${onBehalfVia.applicationName}</a>
                <#elseif onBehalfVia.applicationUrl?exists>
                    <a href="<@s.url value='${onBehalfVia.applicationUrl}'/>">${onBehalfVia.applicationName}</a>
                <#else>
                    <span style="font-weight: bold">${onBehalfVia.applicationName}</span>
                </#if>
            <#else>
                ${SkinUtils.getDisplayName(user)?html}
            </#if>
        </strong>
        </@s.param>
        <@s.param>
            <#if onBehalfUser.jiveUser?exists>
                <@jive.userDisplayNameLink user=onBehalfUser.jiveUser/>
            <#else>
                <#if onBehalfUser.unknownUserUrl?exists>
                    <a href="${onBehalfUser.unknownUserUrl}">${onBehalfUser.unknownUserName}</a>
                <#else>
                    ${onBehalfUser.unknownUserName}
                </#if>
            </#if>
        </@s.param>
    </@s.text>
</#macro>
