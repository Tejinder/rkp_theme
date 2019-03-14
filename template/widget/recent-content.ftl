<#if widgetContext.edit && converted?? && !convertMessageClosed>

<div class="widget-message" xmlns="http://www.w3.org/1999/html">
    <div class="widget-deprecated-msg">
        <span class="jive-icon-med jive-icon-warn"></span>
        <#if converted="recentDocuments">
            <@s.text name='widget.recentdocuments.deprecated'/>
        <#elseif converted="recentDiscussions">
            <@s.text name='widget.recentdiscussions.deprecated'/>
        <#elseif converted="recentBookmarks">
            <@s.text name='widget.recentbookmarks.deprecated'/>
        <#else>
            <@s.text name='widget.unrecognized.text'/>
        </#if>
    </div>
    <div class="widget-deprecated-converted">
        <@s.text name='widget.converted'/>
        <a class="widget-edit-link"><@s.text name='widget.edit.config'/></a>
        <a class="widget-dismiss-link" data-property="convert.recentcontent.closed"><@s.text name='widget.dontshowmsg'/></a>
    </div>
</div>

</#if>

<@resource.javascript file="/${themePath}/scripts/jive/widget/recent-content.js"/>
<#assign recentUpdatesAction = statics['com.jivesoftware.community.action.RecentUpdatesAction'] />

<@resource.javascript>
(function() {
var containerSelector = "#widget-${widgetFrameID?c}";
var i18n = {
    <#assign loadingString><@s.text name="global.loading" /></#assign>
loading: "${loadingString?js_string}"
};
var recentContent = new jive.RecentContentApp(containerSelector, i18n);
})();
</@resource.javascript>

<#if showCategoryFiltering>
    <#assign contentBlock="widget-${widgetFrameID?c}" idPrefix="${widgetFrameID?c}" />

<#-- The Recent Content widget is struggling a bit in older versions of IE. If this is one of those versions, use the small category display header -->
    <#if request.getHeader("User-Agent")?matches(".*MSIE [1-7].*") || containerSize == enums['com.jivesoftware.community.widget.Widget$ContainerSize'].SMALL>
        <#include '/template/global/category-display-small.ftl' />
    <#else>
        <#include "/template/global/include/pagination-macros.ftl" />
        <@paginationDependencies />
        <@resource.javascript>
        $j(document).ready(function() {
        var pager = new jive.Pager.Main($j('#widget-${widgetFrameID?c}'),
        "<@s.url action='render-widget' method="execute" /> #widget-${widgetFrameID?c} > *",
        {
        frameID: ${widgetFrameID?c},
        widgetType: ${widgetType?c},
        widgetID: ${widgetID?c},
            <#if container?exists>
            container: ${container.getID()?c},
            containerType: ${container.getObjectType()?c},
            </#if>
        per_page: <#if numResults?exists>${numResults?c}<#else>per_page: 25</#if>,
        idPrefix: '${idPrefix}',
        size: ${containerSize.getID()?c}
        },

        {
        updateLocation: false
        });
        if (typeof(ContentFilterHandler_${idPrefix}) != 'undefined') {
        ContentFilterHandler_${idPrefix}.contentLoader = pager;
        }
        });
        </@resource.javascript>

        <#include '/template/global/category-display.ftl' />
    </#if>
</#if>

<div class="widget-container" id="widget-${widgetFrameID?c}">

    <form class="status-morecontent-form" action="<@s.url action="recent-updates" method="moreContentResults"/>">
        <input type="hidden" name="containerID" value="${container.ID?c}"/>
        <input type="hidden" name="containerType" value="${container.objectType?c}"/>
        <input type="hidden" name="recursive" value="${recursive?string}"/>
        <input type="hidden" name="visibleTypes" value="${visibleTypes?html}"/>
        <input type="hidden" name="filterEnabled" value="true"/>
        <input type="hidden" name="start"  value="${(start + numResults)?c}"/>
        <input type="hidden" name="numResults" value="${numResults?c}"/>
        <input type="hidden" name="containerSize" value="${containerSize?html}"/>
        <input type="hidden" name="root" value="${isRoot?string}"/>
        <input type="hidden" name="zeroItem" value="${zeroItem?html}"/>
        <input type="hidden" name="showProjectContent" value="${showProjectContent?string}"/>
    <#if tagSet??>
        <input type="hidden" name="tagSet" value="${tagSet.ID?c}" />
    </#if>
    <#if tag??>
        <input type="hidden" name="tag" value="${tag.ID?c}" />
    </#if>
    </form>

<#if (content?? && content.hasNext())>
    <#if containerSize == enums['com.jivesoftware.community.widget.Widget$ContainerSize'].SMALL>
        <@jive.jiveContentListSidebar content=content remote=remoteWidget/>
    <#else>
        <@jive.jiveContentListAjax content=content showContainer=(isRoot || recursive || showProjectContent) remote=remoteWidget currentUser=widgetContext.user/>
    </#if>
    <div class="jive-box-footer">
      <div class="more-status-content">
        <#assign communityURL = JiveResourceResolver.getJiveObjectURL(container, false)/>
        <span class="jive-whats-new-more">
           <#if visibleTypes?contains("-")>
               <#if isRoot?string == 'true'>
                   <#assign targetURL = "/docs?numResults=30&itemView=detail&filterID=all~objecttype~showall"?string/>
               <#else>
                   <#assign targetURL = "${communityURL}/content"?string/>
               </#if>

           <#else>
               <#assign objectType = 'showall'?string>
               <#if visibleTypes == JiveConstants.DOCUMENT?string>
                   <#assign objectType = 'document'?string>
               <#elseif visibleTypes == JiveConstants.THREAD?string>
                   <#assign objectType = 'thread'?string>
               <#elseif visibleTypes == JiveConstants.POLL?string>
                   <#assign objectType = 'poll'?string>
               <#elseif visibleTypes == JiveConstants.BLOGPOST?string>
                   <#assign objectType = 'blogpost'?string>
               <#elseif visibleTypes == JiveConstants.FAVORITE?string>
                   <#assign objectType = 'favorite'?string>
               </#if>
               <#if isRoot?string == 'true'>
                   <#if (objectType?? && objectType != 'showall')>
                       <#assign targetURL = "/content?filterID=all~objecttype~objecttype%5B${objectType}%5D"?string/>
					   <#--<#assign targetURL = "/docs?numResults=30&itemView=detail&filterID=all~objecttype~objecttype%5B${objectType}%5D"?string/>-->
                   <#else>
                       <#assign targetURL = "/docs?numResults=30&itemView=detail&filterID=all~objecttype~showall"?string/>
                   </#if>
               <#else>
                   <#if (objectType?? && objectType != 'showall')>
                       <#assign targetURL = "${communityURL}/content?filterID=contentstatus%5Bpublished%5D~objecttype~objecttype%5B${objectType}%5D"?string/>
                   <#else>
                       <#assign targetURL = "${communityURL}/content"?string/>
                   </#if>
               </#if>

           </#if>
            <a href="<@s.url value="${targetURL}"/>" class="jive-icon-link-forward-content jive-more-content"><@s.text name="main.more.link" /></a>
        </span>
       </div>
    </div>

<#else>
<#-- show empty message for small and large sizes -->
    <#if containerSize == enums['com.jivesoftware.community.widget.Widget$ContainerSize'].SMALL>
        <div class="jive-widget-body-empty">
            <@s.text name='main.no_recent_content.text'/>
        </div>
    <#else>
        <div class="jive-widget-body-empty">
            <@s.text name='main.no_recent_content.text'/>
        </div>
    </#if>
</#if>


    <#--<div class="jive-box-footer">-->
        <#--<span class="jive-whats-new-more">-->
        <#--<#if FeedUtils.isFeedsEnabled()>-->
            <#--<#if container.objectType == 14>-->
                <#--<a href="<@s.url value='/community/feeds/allcontent?community=${container.ID?c}&showProjectContent=${showProjectContent?string}&recursive=${recursive?string}' />" class="statusrss">-->
            <#--<#else>-->
                <#--<a href="<@s.url value='/community/feeds/allcontent?community=1&showProjectContent=${showProjectContent?string}' />" class="statusrss">-->
            <#--</#if>-->
                    <#--<span class="jive-icon-med jive-icon-rss"></span>-->
                <#--</a>-->
        <#--</#if>-->
        <#--</span>-->
    <#--</div>-->

</div>

