<#include "/template/global/include/kantar-macros.ftl" />
<#if kantarBriefTemplates?? && (kantarBriefTemplates?size > 0)>
    <#assign methodologyTypes = statics['com.grail.kantar.util.KantarUtils'].getAllKantarButtomMethodologyTypes()>
    <#assign methodologyTypeKeySet = methodologyTypes.keySet() />
<table id="standard-report-table" class="project_status_table table-sorter">
    <thead>
    <tr>
        <th id="projectcode-header" class="projectcode header sortable"><span id="id">Project Code</span></th>
        <th id="owner-header" class="owner header sortable"><span id="owner">Owner</span></th>
        <th id="market-header" class="market header sortable"><span id="market">Market</span></th>
        <th id="request-raised-header" class="requestRaised header sortable"><span id="requestRaised">Request Raised</span></th>
        <th id="delivery-date-header" class="deliveryDate header sortable"><span id="deliveryDate">Delivery Date</span></th>
        <th id="methodologytype-header" class="methodologytype header sortable"><span id="methodologyType">Methodology Type</span></th>
        <th id="projectstatus-header" class="projectstatus header sortable"><span id="status">Project Status</span></th>

    </tr>
    </thead>
    <tbody>
        <#list kantarBriefTemplates as kantarBriefTemplate>
        <tr <#if (kantarBriefTemplate_index % 2) == 0> class="last"</#if>>
            <td><#if kantarBriefTemplate.id??><a href="<@s.url value='/kantar/brief-template!input.jspa?id=${kantarBriefTemplate.id}'/>">${generateKantarProjectCode(kantarBriefTemplate.id?c)}</a></#if></td>
            <td>
                <#assign userName =""/>
                <#if kantarBriefTemplate.createdBy?? && kantarBriefTemplate.createdBy &gt; 0>
                     <#assign userName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(kantarBriefTemplate.createdBy?long)/>
                </#if>
                ${userName}
            </td>
            <td><#if kantarBriefTemplate.markets?? && kantarBriefTemplate.markets &gt; 0 && statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().containsKey(kantarBriefTemplate.markets?int)>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(kantarBriefTemplate.markets?int)}</#if></td>
            <td><#if kantarBriefTemplate.creationDate??>${kantarBriefTemplate.creationDate?string("dd/MM/yyyy")}</#if></td>
            <td><#if kantarBriefTemplate.deliveryDate??>${kantarBriefTemplate.deliveryDate?string("dd/MM/yyyy")}</#if></td>
            <td>
                <#assign methodologyName = ""/>

                <#if (methodologyTypes?has_content)>
                    <#list methodologyTypeKeySet as key>
                       <#if kantarBriefTemplate.methodologyType?? && key == kantarBriefTemplate.methodologyType?long>
                        <#assign methodologyName = methodologyTypes.get(key) />
                       </#if>
                    </#list>
                </#if>
                <span>${methodologyName}</span>
            </td>
            <td><#if kantarBriefTemplate.status?? &&  kantarBriefTemplate.status &gt; 0>${statics['com.grail.kantar.util.KantarGlobals$KantarBriefTemplateStatusType'].getById(kantarBriefTemplate.status).toString()}</#if></td>
        </tr>

        </#list>
    </tbody>
</table>
<#else>
<div class="no-content">No results matching the criteria</div>
</#if>

<#if pages?? && (pages > 1)>
<div id="pagination"></div>
</#if>
<script type="text/javascript">
    <#if pages?? && (pages>0)>
    var pages = ${pages};
    <#else>
    var pages = 1;
    </#if>
</script>
<script src="${themePath}/js/pagination.custom.js" type="text/javascript"></script>
