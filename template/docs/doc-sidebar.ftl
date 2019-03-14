<@jive.socialActions user followable followed streamsAssociatedCount document document "document" favoriteManager.enabled sharingEnabled/>



<@resource.javascript>
$j(function() {
       $j('#jive-office-plugin-download').css('display','block');
       $j('#jive-office-plugin-download > div').css('padding', '0px');
});
 </@resource.javascript>

<@jive.renderActionSidebar 'document-actions' document container/>

<#if showImpactStats>
    <@soy.render template="jive.impact2.main" data=impactStatsSoyModel />
</#if>

<#include "/template/global/include/jive-search-macros.ftl"/>



<#if (document.approvalStatus?exists && document.approvalStatus?size > 0)>
    <div class="j-box" id="jive-approval-status">
        <header>
            <h4><@s.text name="doc.main.approval_status.gtitle" /></h4>
        </header>
        <article class="j-box-body jive-sidebar-body-actions">
            <div id="jive-approval-status-inner">
                <ul class="j-icon-list">
                <#list document.approvalStatus as status >
                    <li><a href="<@s.url value='/people/${status.user.username?url}'/>"><span class="jive-icon-med <#if status.approved >jive-icon-check<#elseif status.rejected>jive-icon-delete<#else>jive-icon-question</#if>"></span>${status.user.name?default(status.user.username)?html}</a></li>
                </#list>
                </ul>
            </div>
        </article>
    </div>
</#if> 


<div id="doc-page-more-like-this">
	<@moreLikeThis objectType=document.objectType objectID=document.ID />
</div>

<#--
<@s.action name="incoming-links" executeResult="true" ignoreContextParams="true">
    <@s.param name="objectType">${document.objectType?c}</@s.param>
    <@s.param name="objectID">${document.ID?c}</@s.param>
</@s.action>

 <@s.action name="office-plugin-download" executeResult="true" ignoreContextParams="true">
</@s.action>
-->