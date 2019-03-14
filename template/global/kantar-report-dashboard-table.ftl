<#include "/template/global/include/kantar-macros.ftl" />
<#if kantarReports?? && (kantarReports?size > 0)>

<table id="standard-report-table" class="project_status_table table-sorter">
    <thead>
    <tr>
        <th id="report-name-header" class="header sortable"><span id="name">Document Name</span></th>
        <th id="market-header" class="market header sortable"><span id="country">Country</span></th>
        <th id="owner-header" class="owner header sortable"><span id="author">Author</span></th>
        <th id="report-type-header" class="reportType header sortable"><span id="reportType">Document Type</span></th>
        <th id="report-type-upload-date" class="reportTypeUploadDate header sortable"><span id="reportTypeUploadDate">Date of Upload /<br/>Last Modified Date </span></th>
    </tr>
    </thead>
    <tbody>
        <#list kantarReports as kantarReport>
        <tr <#if (kantarReport_index % 2) == 0> class="last"</#if>>
            <td><#if kantarReport.reportName??><a href="javascript:void(0)" onclick="showUploadKantarReportPopup(${kantarReport.id})">${kantarReport.reportName}</a></#if></td>
            <td>
                <#if kantarReport.country??>
                    <#if kantarReport.country?int = -100>
                        Global
                    <#elseif kantarReport.country &gt; 0 && statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().containsKey(kantarReport.country?int)>
                    ${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(kantarReport.country?int)}
                    </#if>
                </#if>
            <#--<#if kantarReport.country?? && kantarReport.country &gt; 0 && statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().containsKey(kantarReport.country?int)>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(kantarReport.country?int)}</#if>-->
            </td>
            <td>
                <#assign userName =""/>
                <#if kantarReport.createdBy?? && kantarReport.createdBy &gt; 0>
                <#assign userName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(kantarReport.createdBy?long)/>
            </#if>
                ${userName}
            </td>
            <td>
                <#assign reportTypeName = ""/>
                <#if kantarReport.reportType??>
                    <#assign reportTypes =  statics['com.grail.kantar.util.KantarUtils'].getKantarReportTypes()>
                    <#if (reportTypes?has_content)>
                        <#assign rKeySet = reportTypes.keySet()/>
                        <#list rKeySet as rKey>
                            <#if kantarReport.reportType?int == rKey?int>
                                <#assign reportTypeName = reportTypes.get(rKey)/>
                            </#if>
                        </#list>
                    </#if>
                </#if>
                <span>${reportTypeName}</span>
            </td>
            <td>${kantarReport.modificationDate?string('dd/MM/yyyy')}</td>
        </tr>

        </#list>

    </tbody>
</table>
<#else>
<div class="no-content">No results matching the criteria or you don't have access to it</div>
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
