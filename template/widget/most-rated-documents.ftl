<#include "/template/docs/include/doc-macros.ftl">

<#if containerSize == enums['com.jivesoftware.community.widget.Widget$ContainerSize'].SMALL>

     <#if (documents?exists && documents.hasNext())>
        <@jive.jiveContentListSidebar isRoot=isRoot communityName=communityName mostRated=isMostRated content=documents showContainer=isRoot limit=numResults remote=remoteWidget />
         <#if moreResultsAvailable>
             <#if isRoot>
             <#--<span id="jive-whats-new-more"><a href="<@s.url value='/docs' forceAddSchemeHostAndPort='${remoteWidget?string}'/>?start=${(numResults - numResults % 30)?c}&numResults=30&filterID=mostrated&itemView=detail" class="jive-icon-link-forward"><@s.text name="main.more.link" /></a></span>-->
			 <span id="jive-whats-new-more"><a href="/content?filterID=mostrated" class="jive-icon-link-forward"><@s.text name="main.more.link" /></a></span>
			 
			 
             <#else>
            <#-- <span id="jive-whats-new-more"><a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container, remoteWidget)}' />?view=documents&start=${(numResults - numResults % 30)?c}&numResults=30&filterID=mostrated&itemView=detail" class="jive-icon-link-forward"><@s.text name="main.more.link" /></a></span>-->
			<span id="jive-whats-new-more"><a href="/content?filterID=mostrated" class="jive-icon-link-forward"><@s.text name="main.more.link" /></a></span>
             </#if>
         </#if>
     <#else>
        <@jive.jiveEmptyContentListSidebar container=container showTypeExclusively="document" remote=remoteWidget/>
     </#if>

<#else>
	<#if documents?? && (documents?size>0)>
		<@jive.jiveRatedContentListAjax content=documents showContainer=isRoot remote=remoteWidget currentUser=widgetContext.user mostRated=isMostRated />
		<#if moreResultsAvailable>
		  <#if isRoot>
			<#--<span id="jive-whats-new-more"><a href="<@s.url value='/docs' forceAddSchemeHostAndPort='${remoteWidget?string}'/>?start=${(numResults - numResults % 30)?c}&numResults=30&filterID=mostrated&itemView=detail" class="jive-icon-link-forward"><@s.text name="main.more.link" /></a></span>-->
			<span id="jive-whats-new-more"><a href="/content?filterID=mostrated" class="jive-icon-link-forward"><@s.text name="main.more.link" /></a></span>
			<#else>
			<#--<span id="jive-whats-new-more"><a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container, remoteWidget)}' />?view=documents&start=${(numResults - numResults % 30)?c}&numResults=30&filterID=mostrated&itemView=detail" class="jive-icon-link-forward"><@s.text name="main.more.link" /></a></span>-->
			<span id="jive-whats-new-more"><a href="/content?filterID=mostrated" class="jive-icon-link-forward"><@s.text name="main.more.link" /></a></span>
		   </#if>
		</#if>
	<#else>
        <@jive.jiveEmptyContentList container=container showTypeExclusively="document" remote=remoteWidget/>
    </#if>
    
	<#--<#if (documents?exists && documents.hasNext())>
        <@jive.jiveRatedContentListAjax content=documents showContainer=isRoot remote=remoteWidget currentUser=widgetContext.user mostRated=isMostRated />
        <#if moreResultsAvailable>
          <#if isRoot>
            <span id="jive-whats-new-more"><a href="<@s.url value='/docs' forceAddSchemeHostAndPort='${remoteWidget?string}'/>?start=${(numResults - numResults % 30)?c}&numResults=30&filterID=mostrated&itemView=detail" class="jive-icon-link-forward"><@s.text name="main.more.link" /></a></span>
            <#else>
            <span id="jive-whats-new-more"><a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container, remoteWidget)}' />?view=documents&start=${(numResults - numResults % 30)?c}&numResults=30&filterID=mostrated&itemView=detail" class="jive-icon-link-forward"><@s.text name="main.more.link" /></a></span>
           </#if>
        </#if>
    <#else>
        <@jive.jiveEmptyContentList container=container showTypeExclusively="document" remote=remoteWidget/>
    </#if> -->

</#if>
