<#-- @ftlvariable name="" type="com.jivesoftware.community.action.JiveActionSupport" -->

<#macro macroSynchroFormError fieldErrors actionErrors actionMessages errorMsg=''>
<#if !fieldErrors.empty>
    <div id="jive-error-box" class="jive-error-box">
        <div>
            <#--<span class="jive-icon-med jive-icon-redalert"></span>-->
			<#if errorMsg != ''>
				${errorMsg}
			<#else>
				<@s.text name="error.field_error.text"/>
			</#if>            
        </div>
    </div>
<#elseif !actionErrors.empty>
    <div id="jive-error-box" class="jive-error-box">
        <div>
            <#--<span class="jive-icon-med jive-icon-redalert"></span>-->
            <#assign unknownErrorMessage><@s.text name='error.unknown_error.text'/></#assign>
            <#if (actionErrors?size > 1)>
                <#list actionErrors as actionError>
                    <li>${actionError?default(unknownErrorMessage)?html}</li>
                </#list>
            <#else>
                <#list actionErrors as actionError>
                    ${actionError?default(unknownErrorMessage)?html}
                </#list>
            </#if>
        </div>
    </div>
<#elseif !actionMessages.empty>
    <div id="jive-success-box" class="jive-success-box">
        <div>
            <span class="jive-icon-med jive-icon-check"></span>
            <#assign successMessage><@s.text name='global.success'/></#assign>
            <#list actionMessages as actionMessage>
                ${actionMessage?default(successMessage)?html}
            </#list>
        </div>
    </div>
</#if>
</#macro>

<#macro macroFieldErrors name=''>
    <#if !fieldErrors.empty && fieldErrors[name]?exists>
        <#list fieldErrors[name] as error>
            <span class="jive-error-message">${error?html}</span>
        </#list>
    </#if>
</#macro>

