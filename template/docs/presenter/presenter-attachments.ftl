<#--
  ~ $Revision: 1.1 $
  ~ $Date: 2018/03/19 12:14:36 $
  ~
  ~ Copyright (C) 1999-2008 Jive Software. All rights reserved.
  ~
  ~ This software is the proprietary information of Jive Software. Use is subject to license terms.
  -->
<!-- BEGIN attachments -->

<#include "/template/cart/cart-macros.ftl">

<#assign attachmentCount = jiveContext.attachmentManager.getAttachmentCount(document) />
<#if (attachmentCount?exists && attachmentCount > 0)>

<div class="jive-attachments">
    <ul>
        <#list jiveContext.attachmentManager.getAttachments(document) as attachment>

            <#assign isOnCart = statics['com.grail.cart.util.CartUtil'].isAlreadyOnCart(action.user, document.ID?c,'attachment', attachment.ID?c)/>
            <#if attachment.properties['status']?exists && attachment.properties['status'] == "blocked">
                <li><span class="${SkinUtils.getJiveObjectCss(attachment, 0)}"></span>${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) <b style="color:red;">BLOCKED</b></li>
            <#elseif attachment.properties['status']?exists && attachment.properties['status'] == "queued">
                <li><span class="${SkinUtils.getJiveObjectCss(attachment, 0)}"></span>${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) <b>QUEUED</b></li>
            <#elseif (attachment.contentType?starts_with('image/'))>
                <li>
                    <input <#if isOnCart > checked </#if> type="checkbox" name="${attachment.ID?c}" value="${attachment.ID?c}" onClick="addAttachCheck( ${document.ID?c},'attachment', '${document.subject?replace("'"," ")?html}', ${attachment.ID?c}, this );"/>
                    <a href="<@s.url value='/servlet/JiveServlet/download/${document.ID?c}-${document.documentVersion.versionNumber?c}-${attachment.ID?c}/${attachment.name?url}'/>">
                        <img alt="<@s.text name='global.attachment' />" src="<@s.url value='/servlet/JiveServlet/attachImage?attachImage=true&contentType=${attachment.contentType?url}&attachment=${attachment.ID?c}' />" border="0" style="margin: 3px 1px 0px 0px;" />
                    </a>
                    <a href="<@s.url value='/servlet/JiveServlet/download/${document.ID?c}-${document.documentVersion.versionNumber?c}-${attachment.ID?c}/${attachment.name?url}'/>">${attachment.name?html}</a>
                    (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                </li>
            <#else>
                <li> <input <#if isOnCart > checked </#if> type="checkbox" name="${attachment.ID?c}" value="${attachment.ID?c}" onClick="addAttachCheck( ${document.ID?c},'attachment', '${document.subject?replace("'"," ")?html}', ${attachment.ID?c}, this );"/>  <a href="<@s.url value="/servlet/JiveServlet/download/${document.ID?c}-${document.documentVersion.versionNumber?c}-${attachment.ID?c}/${attachment.name?url}"/>"><span class="${SkinUtils.getJiveObjectCss(attachment, 0)}"></span>${attachment.name?html}</a> (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})</li>
            </#if>


            <!-- Need to check whether following commented lines is required or not -->

            <#--<#assign iconElement = SkinUtils.getJiveObjectIcon(attachment, 2)! />-->
            <#--<#if attachment.properties['status']?exists && attachment.properties['status'] == "blocked">-->
                <#--<li>-->
                    <#--<#if iconElement??><@jive.renderIconElement iconElement /><#else>-->
                        <#--<span class="${SkinUtils.getJiveObjectCss(attachment, 2)}"></span>-->
                    <#--</#if>-->
                <#--${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) <b style="color:red;"><@s.text name="post.status.blocked.text" /></b></li>-->
            <#--<#elseif attachment.properties['status']?exists && attachment.properties['status'] == "queued">-->
                <#--<li>-->
                    <#--<#if iconElement??><@jive.renderIconElement iconElement /><#else>-->
                        <#--<span class="${SkinUtils.getJiveObjectCss(attachment, 2)}"></span>-->
                    <#--</#if>-->
                <#--${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) <b><@s.text name="post.status.queued.text" /></b></li>-->
            <#--<#elseif (attachment.contentType?starts_with('image/'))>-->
                <#--<li class="clearfix">-->
                    <#--<a class="j-attachment-icon" href="<@s.url value='/servlet/JiveServlet/download/${document.ID?c}-${document.documentVersion.versionNumber?c}-${attachment.ID?c}/${attachment.name?url}'/>">-->
                        <#--<img alt="<@s.text name='global.attachment' />" src="<@s.url value='/servlet/JiveServlet/attachImage?attachImage=true&contentType=${attachment.contentType?url}&attachment=${attachment.ID?c}' />" border="0" style="margin: 3px 1px 0px 0px;" />-->
                    <#--</a>-->
                    <#--<div class="j-attachment-info clearfix">-->
                        <#--<a href="<@s.url value='/servlet/JiveServlet/download/${document.ID?c}-${document.documentVersion.versionNumber?c}-${attachment.ID?c}/${attachment.name?url}'/>">${attachment.name?html}</a>-->
                        <#--<span class="j-attach-meta font-color-meta">${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}</span>-->
                    <#--</div>-->
                <#--</li>-->
            <#--<#else>-->
                <#--<li class="clearfix">-->
                    <#--<a class="j-attachment-icon" href="<@s.url value="/servlet/JiveServlet/download/${document.ID?c}-${document.documentVersion.versionNumber?c}-${attachment.ID?c}/${attachment.name?url}"/>">-->
                        <#--<#if iconElement??><@jive.renderIconElement iconElement /><#else>-->
                            <#--<span class="${SkinUtils.getJiveObjectCss(attachment, 2)}"></span>-->
                        <#--</#if></a>-->
                    <#--<div class="j-attachment-info clearfix">-->
                        <#--<a href="<@s.url value="/servlet/JiveServlet/download/${document.ID?c}-${document.documentVersion.versionNumber?c}-${attachment.ID?c}/${attachment.name?url}"/>">${attachment.name?html}</a>-->
                            <#--&lt;#&ndash;<span class="j-attach-meta font-color-meta">${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}&ndash;&gt;-->
                            <#--<@jive.previewableBinaryViewLink attachment attachment.name/></span>-->
                    <#--</div>-->


                <#--</li>-->
            <#--</#if>-->
        </#list>
    </ul>
    <div class="j-attach-clip j-ui-elem"></div>
</div>
</#if>
<!-- END attachments -->

<#-- This is necessary to support the "previewableBinaryViewLink" macro -->
<div id="previewable-binary-viewer"></div>
