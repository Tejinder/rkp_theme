<#include "/template/decorator/default/header-javascript-global-params.ftl"/>

<#-- Kongregate Asynchronous JavaScript Loader -->
<#include "/template/decorator/default/header-javascript-kjs.ftl" />

<#if (!page?? || "false" != (page.getProperty("meta.includeHeaderScripts")!"true"))>
    <#include "/template/decorator/synchro/header-javascript-jquery.ftl" />
    <#include "/template/decorator/default/header-javascript-jive-core.ftl" />

<#-- Common includes -->
    <@resource.javascript file="/resources/scripts/utils.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive.js" header="true" id="core" />
    <#--<@resource.javascript file="${themePath}/js/scripts/multifile.js"  header="true" id="core"/>-->
    <@resource.javascript file='/resources/scripts/ie_reflow.js' header='true' id="core"/>
    <@resource.javascript file='/resources/scripts/ajax_error_handler.js' header='true' id="core"/>

<#-- soy includes -->
    <@resource.javascript file="/resources/scripts/soy/soyutils.js" header="true" id="core"/>
    <@resource.template file="/soy/shared/soy-core.soy" header="true" id="core"/>

<#-- External image security -->
<#-- Temporarily disabled:
<@resource.template file="/soy/external_image/external_image.soy" />
-->

    <#include "/template/decorator/default/header-javascript-zapatec.ftl" />
    <@resource.javascript file="/resources/scripts/jquery/jquery.tagAutocomplete.js" header="true" id="core"/>

    <@resource.javascript file="/resources/scripts/jive/widget/widget-container.js" header="true" id="core"/>

    <@resource.template file="/soy/userpicker/userpicker.soy" />
<#--    <@resource.javascript file="${themePath}/js/apps/userpicker/views/select_people_view.js" header="true" id="core" />

    <@resource.javascript file="${themePath}/js/apps/userpicker/views/userpicker_view.js" header="true" id="core" />
    <@resource.javascript file="${themePath}/js/apps/userpicker/models/userpicker_source.js" header="true" id="core" />
-->
    <@resource.javascript file="/resources/scripts/apps/userpicker/main.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jivespotlightsearch.js" header="true" id="core"/>

    <@resource.javascript file="/resources/scripts/apps/shared/models/rest_service.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/apps/shared/views/abstract_view.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/apps/follows/views/follow_view.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/apps/follows/models/follow_source.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/apps/follows/main.js" header="true" id="core" />

    <@resource.javascript file="/resources/scripts/apps/tracking/views/tracking_view.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/apps/tracking/models/tracking_source.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/apps/tracking/main.js" header="true" id="core" />
    <@resource.template file="/soy/eae/action/tracking.soy" header="true" id="core"/>

    <#--<#include "/template/decorator/default/header-javascript-browser-events.ftl" />-->
    <@resource.javascript file="/resources/scripts/apps/shared/models/user_relationship_list_source.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/apps/shared/models/user_relationship_source.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/apps/follows/user/views/follow_user_link.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/apps/follows/user/main.js" header="true" id="core" />

<script type="text/javascript">
    var profileShortUrl = "<@s.url action='profile-short' namespace='/' />";
    var profileLoadingTooltip = "${action.getText('user.tooltip.loading')?js_string}";
    var profileErrorTooltip = "${action.getText('user.tooltip.error')?js_string}";

    var containerShortUrl = "<@s.url action='container-short' namespace='/' />";

    var videoShortUrl = "<@s.url action='view-video-short' namespace='/' />";

    var followErrorMessage = "${action.getText('global.follow.error')?js_string}";

    var ajaxErrorMessage = "${action.getText('global.ajax_error')?js_string}";
    var ajaxNotFoundMessage = "${action.getText('error.notfound.unknown')?js_string}";
    var ajaxUnauthorizedMessage = "${action.getText('global.unauth')?js_string}";

    <#-- Ensure document.write is not called after the document has been loaded. If it is called after the
document is loaded the entire contents of the page will be cleared out and replaced with the
contents of the call (which we don't want) -->
    (function() {
        var originalWrite = document.write;
        document.write = function() {
            if(typeof $j != 'undefined' && $j.isReady) {
                console.warn("document.write called after document was loaded: ", arguments);
            }
            else {
                // In IE before version 8 `document.write()` does not
                // implement Function methods, like `apply()`.
                return Function.prototype.apply.call(originalWrite, document, arguments);
            }
        }
    })();
</script>

    <#if friendingReflexive>
        <#assign startFollow = action.getText("profile.friends.startfriending.message.text")/>
        <#assign stopFollow  = action.getText("profile.friends.stopfriending.message.text")/>
    <#else>
        <#assign startFollow = action.getText("profile.friends.startfollowing.message.text")/>
        <#assign stopFollow  = action.getText("profile.friends.stopfollowing.message.text")/>
    </#if>

    <@resource.javascript header="true" id="core">
    $j(document).ready(function() {
    var followView = new jive.FollowUserApp.ProfileFollowView({
    i18n: {
    startFollowingMessage: '<p>${startFollow?js_string}</p>',
    stopFollowingMessage:  '<p>${stopFollow?js_string}</p>',
    pendingConnectionMessage: '<p>${action.getText('profile.friends.requestfollowing.message.text')?js_string}</p>'
    },
    bidirectional: ${friendingReflexive?string}
    });
    var jiveUserFollow = new jive.FollowUserApp.Main({
    followView: followView
    });

    /* init placeholder text js */
    $j("input[placeholder]").placeHeld();
    });

    </@resource.javascript>
</#if>

<@resource.javascript file='/resources/scripts/places-autocomplete.js' header='true' id="core"/>

<#if chatPresenceManagerImpl.isPresenceAvailable()>
    <@resource.javascript file='/resources/scripts/jive/hallway_presence.js' header='true' id="core"/>
</#if>
