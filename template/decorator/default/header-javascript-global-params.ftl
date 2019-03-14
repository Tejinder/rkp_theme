<#-- use webwork to determine the base context for generating relative URLs -->
<#assign jive_base_url><@s.url value="/" includeParams="none"/></#assign>
<#assign jive_resource_url><@resource.url value="/" /></#assign>

<#--<#if statics['com.grail.synchro.SynchroGlobal'].getAppProperties().get(statics['com.grail.util.BATConstants'].BAT_BASE_URL)??>-->
    <#--<#assign jive_base_url>${statics['com.grail.synchro.SynchroGlobal'].getAppProperties().get(statics['com.grail.util.BATConstants'].BAT_BASE_URL)}</#assign>-->
<#--</#if>-->


<#include "/template/global/include/jive-macros.ftl" />
<script type="text/javascript">
    (function() {
        var prepareUrl = function(url) {
        <#-- need to strip ;jsessionid=3rjp0oit23hk7 from urls -->
            if (url.indexOf(";") > 0) {
                url = url.substring(0, url.indexOf(";"));
            }
            if (url.charAt(url.length - 1) == '/') {
                url = url.substring(0, url.length - 1);
            }
            return url
        };
        if (typeof(window._jive_base_url) == "undefined") {
            window._jive_base_url = prepareUrl("${jive_base_url}")
        }
        if (typeof(window._jive_resource_url) == "undefined") {
            window._jive_resource_url = prepareUrl("${jive_resource_url}")
        }
    <#if user??>
        if (typeof(window._jive_current_user) == "undefined") {
            window._jive_current_user = {
            anonymous: <#if user.anonymous>true<#else>false</#if>,
                username: '${user.username?js_string}',
                ID: '${user.ID?c}',
            enabled: <#if user.enabled>true<#else>false</#if>,
                avatarID: '${jiveContext.avatarManager.getActiveAvatar(user).ID?c}',
                displayName: '${getUserDisplayName(user)?js_string}'
            };
        }



    </#if>
    })();

    var _jive_effective_user_id = "${user.ID!?c}";
   <#-- var _jive_auth_token ="${skin.tokenCreator.generateXHRtoken(user)}";-->
    var _jive_auth_token ="";
    var _jive_locale = "${SkinUtils.getLocale()!?js_string}";
    var _jive_browser_event = ${skin.template.browserEventQuery};
    var _jive_browser_event_polling_delay = ${browserEventsPollingDelay?c};
    var _jive_timezoneoffset = ${SkinUtils.getTimeZoneOffset(user)?c};
    <#--var _jcapi_token = "${skin.coreApiTokenGenerator.tokenValue!?js_string}";-->
	var _jcapi_token = "";

</script>
