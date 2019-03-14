<#include "/template/global/include/grail-macros.ftl" />

<script type="text/javascript">
    function changeStatus(status) {
        $j.ajax({
            url: "<@s.url value="/grail/status!update.jspa"/>",
            type: 'POST',
            data: {id:${id},status:status},
            success: function(data, test) {
                window.location.href = "<@s.url value="/grail/status!input.jspa?id=${id}"/>";
            },
            error: function() {

                console.log("Error on saving details..")
            }
        });

    }

    function showCostErrorMsg() {
        dialog({title:'Warning', html:'<p>Please provide cost details on the Brief tab.</p>'})
    }
</script>

<div class="grail grail-main-container">
<@grailTabs id=id activeTab=3 />
    <div class="research_content">
        <div class="grail_project_name_div">
        <#if (grailBriefTemplate?? && grailBriefTemplate.id??)>
            <h2>${generateGrailProjectCode(grailBriefTemplate.id)}</h2>
        </#if>
        </div>
        <div class="change-status-main">
            <div class="change-status">
                <h3>Current Status of the Project</h3>
                <ul>
                    <li class="status">
                        <span class='progress first <#if status &gt; 1 && status &lt; 3>completed<#elseif status = 1>active</#if>'></span>
                        <span class="message">${statics['com.grail.GrailGlobals$GrailBriefTemplateStatusType'].IN_PROGRESS.toString()?upper_case}</span>
                    </li>
                    <li class="separator <#if status &gt;= 2 && status &lt; 3>fill</#if>"></li>
                    <li class="status">
                        <span class='progress last <#if status &gt;= 2 && status &lt; 3>completed</#if>'></span>
                        <span class="message">${statics['com.grail.GrailGlobals$GrailBriefTemplateStatusType'].COMPLETED.toString()?upper_case}</span>
                    </li>
                <#--<li class="separator <#if status &gt;= 2>fill</#if>"></li>-->
                <#--<li class="status">-->
                <#--<span class='progress last <#if status &gt;= 3>completed<#elseif status = 2>active</#if>'></span>-->
                <#--<span class="message">${statics['com.grail.GrailGlobals$GrailBriefTemplateStatusType'].CANCELLED.toString()?upper_case}</span>-->
                <#--</li>-->
                </ul>
            </div>
            <div class="change-status-sub">
                <h3>Click to Change the status of the Project</h3>
                <div class="cs-button-main">
                <#assign statusTypes = statics['com.grail.GrailGlobals$GrailBriefTemplateStatusType'].values()>
                <#if statusTypes?has_content>
                    <#list statusTypes as statusType>
                        <div class="cs-buttons">
                            <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
                            <#if statusType.getId()?? && statusType.getId() = 1>
                                <#if synchroPermHelper.isSynchroMiniAdmin(user) || synchroPermHelper.isSynchroAdmin(user)>
                                    <a href="javascript:void(0);" <#if canEditProject>onclick="changeStatus(${statusType.getId()})"</#if> <#if status?int = statusType.getId()>class="concept-activated"<#else>class="concept"</#if>>${statusType.toString()?upper_case}</a>
                                <#else>
                                    <a href="javascript:void(0);" <#if status?int = statusType.getId()>class="concept-activated"<#else>class="concept"</#if>>${statusType.toString()?upper_case}</a>
                                </#if>
                            <#elseif statusType.getId()?? && statusType.getId() = 2>
                                <#if canCompleteProject?? && canCompleteProject>
                                    <a href="javascript:void(0);" <#if canEditProject>onclick="changeStatus(${statusType.getId()})"</#if> <#if status?int = statusType.getId()>class="concept-activated"<#else>class="concept"</#if>>${statusType.toString()?upper_case}</a>
                                <#else>
                                    <a href="javascript:void(0);" onclick="showCostErrorMsg()" <#if status?int = statusType.getId()>class="concept-activated"<#else>class="concept"</#if>>${statusType.toString()?upper_case}</a>
                                </#if>

                            <#else>
                                <a href="javascript:void(0);" <#if canEditProject>onclick="changeStatus(${statusType.getId()})"</#if> <#if status?int = statusType.getId()>class="concept-activated"<#else>class="concept"</#if>>${statusType.toString()?upper_case}</a>
                            </#if>

                        </div>
                    </#list>
                </#if>
                </div>
            </div>
        </div>
    </div>
</div>