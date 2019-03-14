<#if waiverPendingActivities?? && (waiverPendingActivities?size > 0)>
<#--<div class="table-header">-->
<#--<table id="project_status_table_header" class="project_status_table tablesorter">-->

<#--<thead>-->
<#--<th class="catalogue-code sortable"><span id="id">Project Code</span></th>-->
<#--<th class="catalogue-name sortable"><span id="name">Project Name</span></th>-->
<#--<th class="catalogue-owner sortable"><span id="owner">Owner</span></th>-->
<#--<th class="catalogue-year sortable"><span id="year">Year</span></th>-->
<#--<th class="catalogue-brand sortable"><span id="brand">Brand</span></th>-->
<#--<th class="catalogue-type">Pending Activity Type</th>-->
<#--<th class="catalogue-link">Pending Activity Link</th>-->
<#--</thead>-->
<#--</table>-->
<#--</div>-->
<#--<div>-->
<#--<div class="table-body">-->
<div>
    <table id="project_status_table_body" class="scrollable-table project_status_table tablesorter">
        <thead>
        <tr>
            <th id="waiver-id-header" class="waiver-code-col sortable"><span id="id"><@s.text name="waiver.catalogue.table.header.waiver.id"/></span></th>
            <th id="waiver-name-header" class="waiver-name-col sortable"><span id="name"><@s.text name="waiver.catalogue.table.header.waiver.name"/></span></th>
            <th id="waiver-initiator-header" class="waiver-owner-col sortable"><span id="owner"><@s.text name="waiver.catalogue.table.header.initiator"/></span></th>
            <th id="waiver-year-header" class="waiver-year-col sortable"><span id="year"><@s.text name="waiver.catalogue.table.header.year"/></span></th>
            <th id="waiver-brand-header" class="waiver-brand-col sortable"><span id="brand"><@s.text name="waiver.catalogue.table.header.brand"/></span></th>
            <th id="waiver-status-header" class="waiver-status-col">Pending Activity Type</span></th>
            <th id="waiver-link-header" class="waiver-link-col">Pending Activity Link</th>
        </tr>
        </thead>
        <tbody>

            <#list waiverPendingActivities as waiver>
            <tr <#if (waiver_index % 2) == 0> class="last"</#if>>
                <td class="waiver-code-col">${waiver.waiverID?c}</td>
                <td class="waiver-name-col"><a href="<@s.url value='/synchro/project-waiver!input.jspa?projectWaiverID=${waiver.waiverID?c}'/>">${waiver.waiverName}</a></td>
                <td class="waiver-owner-col">${waiver.initiator}</td>
                <td class="waiver-year-col">${waiver.year?c}</td>
                <td class="waiver-brand-col">${waiver.brand}</td>
                <td class="waiver-status-col">${waiver.status}</td>
                <td class="waiver-link-col"><a href="<@s.url value='/synchro/project-waiver!input.jspa?projectWaiverID=${waiver.waiverID?c}'/>"><@s.url value='/synchro/project-waiver!input.jspa?projectWaiverID=${waiver.waiverID?c}'/></a></td>
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
<#else>
<script>
    if($j.trim($j("#search_box").val())!="")
    {
        $j(".no-content").html("No results matching the criteria");
    }
    else
    {
        if(!isfilterSet())
        {
            $j("#search_box").hide();
        }
    }
</script>
<div class="no-content">No Pending Activity</div>
</#if>

<#if pages?? && (pages>1)>
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

