<#assign bannerBean = skin.template.getComplianceMessagingBean()!/>
<#if bannerBean?has_content>
    <div id="jive-compliance" class="${bannerBean.style!}"<#if !bannerBean.show> style="display:none"</#if>>
        <span class="jive-icon-med ${bannerBean.icon!}"></span><strong>${bannerBean.iconTitle!}:</strong>
        <#if bannerBean.title??>
        <h2>${bannerBean.title}</h2>
        </#if>
        <#if bannerBean.message??>
        <p>${bannerBean.message}</p>
        </#if>

        <#if bannerBean.smbText?has_content>
            ${bannerBean.smbText}
        </#if>

        <#if bannerBean.footer??>
        <br/>
        <p>${bannerBean.footer}</p>
        </#if>
    </div>
</#if>