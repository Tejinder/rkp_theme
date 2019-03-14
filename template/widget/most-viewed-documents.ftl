<#include "/template/docs/include/doc-macros.ftl">

<#if containerSize == enums['com.jivesoftware.community.widget.Widget$ContainerSize'].SMALL>

    <#if (documents?exists && documents.hasNext())>
        <@jive.jiveContentListSidebar isRoot=isRoot communityName=communityName mostRated=isMostRated content=documents showContainer=isRoot limit=numResults remote=remoteWidget />
    <#else>
        <@jive.jiveEmptyContentListSidebar container=container showTypeExclusively="document" remote=remoteWidget/>
    </#if>

<#else>
	<#if documents?? && (documents?size>0)>
		<@jive.jiveViewedContentListAjax content=documents showContainer=isRoot remote=remoteWidget currentUser=widgetContext.user mostRated=fal />
    <#else>
        <@jive.jiveEmptyContentList container=container showTypeExclusively="document" remote=remoteWidget/>
    </#if>
   <#-- <#if (documents?exists && documents.hasNext())>
        <@jive.jiveViewedContentListAjax content=documents showContainer=isRoot remote=remoteWidget currentUser=widgetContext.user mostRated=fal />
    <#else>
        <@jive.jiveEmptyContentList container=container showTypeExclusively="document" remote=remoteWidget/>
    </#if>-->

</#if>
