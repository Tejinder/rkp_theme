<#if skin.template.thirdPartyReportingEnabled>
    ${skin.template.thirdPartyReportingCode!}
</#if>


<#if chatPresenceManagerImpl.isPresenceAvailable()>
<#include "/template/global/include/action-bar-macros.ftl" />
<@renderEimJavascript/>
</#if>


<script type="text/javascript">
    $j(window).load(function(){
        if (jive.ActivityStream && jive.ActivityStream.TabCountsControllerMain) {
            jive.ActivityStream.TabCountsController = new jive.ActivityStream.TabCountsControllerMain(
                {pollingEnabled: ${streamPollingEnabled?string}});
        }
    });
</script>
