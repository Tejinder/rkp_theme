<div>
    <table id="project_waiver_catalogue_table_body" class="scrollable-table project_status_table table-sorter">
        <thead>
        <tr>
            <th id="waiver-id-header" class="waiver-code-col sortable"><span id="id"><@s.text name="waiver.catalogue.table.header.waiver.id"/></span></th>
            <th id="waiver-name-header" class="waiver-name-col sortable"><span id="name"><@s.text name="waiver.catalogue.table.header.waiver.name"/></span></th>
            <th id="waiver-initiator-header" class="waiver-owner-col sortable"><span id="owner"><@s.text name="waiver.catalogue.table.header.initiator"/></span></th>
            <th id="waiver-year-header" class="waiver-year-col sortable"><span id="year"><@s.text name="waiver.catalogue.table.header.year"/></span></th>
            <th id="waiver-region-header" class="waiver-catalogue-region-col"><@s.text name="waiver.catalogue.table.header.region"/></th>
            <th id="waiver-country-header" class="waiver-catalogue-country-col"><@s.text name="waiver.catalogue.table.header.country"/></th>
            <th id="waiver-brand-header" class="waiver-brand-col sortable"><span id="brand"><@s.text name="waiver.catalogue.table.header.brand"/></span></th>
            <th id="waiver-approver-header" class="waiver-approver-col sortable"><span id="approver"><@s.text name="waiver.catalogue.table.header.methodology.approver"/></span></th>
            <th id="waiver-status-header" class="waiver-status-col sortable"><span id="status"><@s.text name="waiver.catalogue.table.header.status"/></span></th>
        </tr>
        </thead>
        <tbody>
        <#list projectCatalogues as projectCatalogue>
        <tr <#if (projectCatalogue_index % 2) == 0> class="last"</#if>>
            <td class="waiver-code-col">${projectCatalogue.waiverID?c}</td>
           <#-- <td class="waiver-name-col"><a href="/synchro/project-waiver!input.jspa?projectWaiverID=${projectCatalogue.waiverID?c}">${projectCatalogue.waiverName?default('')}</a></td>-->
            <td class="waiver-name-col"><a href="${projectCatalogue.waiverUrl?default('')}">${projectCatalogue.waiverName?default('')}</a></td>
            <td class="waiver-owner-col">${projectCatalogue.initiator}</td>
            <td class="waiver-year-col"><#if projectCatalogue.year == -1>N/A<#else>${projectCatalogue.year?c}</#if></td>
            <td class="waiver-catalogue-region-col">${projectCatalogue.region}</td>
            <td class="waiver-catalogue-country-col">${projectCatalogue.country}</td>
            <td class="waiver-brand-col">${projectCatalogue.brand?default('')}</td>
            <td class="waiver-approver-col">${projectCatalogue.approver}</td>
            <td class="waiver-status-col">${projectCatalogue.status?default('')}</td>
        </tr>

        </#list>
        </tbody>
    </table>
    <div class="table-vscroll">
        <script type="text/javascript">
            $j(document).ready(function() {
                $j(".table-vscroll").scroll(function(event) {
                    $j(".project_status_table tbody").scrollTop($j(this).scrollTop());
                });
            });
        </script>
        <div class="scollinner">
            <span>&nbsp;</span>
        </div>
    </div>
</div>
<#if pages?? && (pages > 1)>
<div id="pagination"></div>
</#if>
<script type="text/javascript">
    <#if pages?? && (pages>0)>
    var pages = ${pages};
    <#else>
    var pages = 1;
    </#if>
    <#if projectCatalogues?? && (projectCatalogues?size<1) >
    $j("a#continue").hide();
    </#if>
</script>
<script src="${themePath}/js/pagination.custom.js" type="text/javascript"></script>