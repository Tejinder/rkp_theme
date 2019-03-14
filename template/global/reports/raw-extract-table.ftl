<script type="text/javascript">
    //    $j(document).ready(function(){
    //        $j("#search-box-form").show();
    //    });
    //
</script>

<#if rawExtractReportList?? && (rawExtractReportList?size > 0)>
<table id="standard-report-table" class="project_status_table table-sorter">
    <thead>
    <tr>
        <th id="projectcode-header" class="projectcode"><span id="projectcode">Project Code</span></th>
        <th id="projectname-header" class="projectname"><span id="projectname">Project Name</span></th>
        <th id="market-header" class="market"><span id="market">Market</span></th>
        <th id="methodology-header" class="methodology"><span id="methodology">Methodology</span></th>
        <th id="brand-header" class="brand"><span id="brand">Brand</span></th>
        <th id="supplier-header" class="supplier"><span id="supplier">Supplier</span></th>
        <th id="caprating-header" class="caprating"><span id="caprating">CAP Rating</span></th>
        <th id="projectcost-header" class="projectcost"><span id="projectcost">Latest Project Cost</span></th>
        <th id="currency-header" class="gbp"><span id="currency">Latest Project Cost - Currency</span></th>
        <th id="gbp-header" class="gbp"><span id="gbp">Latest Project Cost(GBP)</span></th>
    </tr>
    </thead>
    <tbody>
        <#list rawExtractReportList as standardReport>
        <tr <#if (standardReport_index % 2) == 0> class="last"</#if>>
            <td><#if standardReport.projectId??>${generateProjectCode(standardReport.projectId?c)}</#if></td>
            <td><#if standardReport.projectName??>${standardReport.projectName}</#if></td>
            <td><#if standardReport.market??>${standardReport.market}</#if></td>
            <td><#if standardReport.methodology??>${standardReport.methodology}</#if></td>
            <td><#if standardReport.brand??>${standardReport.brand}</#if></td>
            <td><#if standardReport.supplier??>${standardReport.supplier}<#else>Not Defined</#if></td>
            <td><#if standardReport.capRating??>${standardReport.capRating}<#else>NONE</#if></td>
            <td><#if standardReport.latestProjectCost?? &&  standardReport.latestProjectCost &gt; 0 >${standardReport.latestProjectCost?string(",##0.####")}<#else>0</#if></td>
            <td><#if standardReport.latestProjectCostCurrency??>${standardReport.latestProjectCostCurrency}</#if></td>
            <td><#if standardReport.latestProjectCostDBPRate??>${standardReport.latestProjectCostDBPRate?string(",##0.####")}</#if></td>
        </tr>

        </#list>
    </tbody>
</table>
<#else>
<div class="no-content">There is no items found.</div>
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

<#function generateProjectCode projectID maxDigits=5 >
    <#if projectID?? && (projectID?number>0) >
        <#local length = (projectID?string)?length />
        <#local prependLen = (maxDigits - length) />
        <#local prepend = '' />
        <#if (length<maxDigits) >
            <#list 1..prependLen as x>
                <#local prepend = prepend + '0' />
            </#list>
        </#if>
        <#return (prepend + projectID?string)>
    </#if>
    <#return ''>
</#function>