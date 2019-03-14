
<#if currentStatusBean?? && (currentStatusBean?size > 0)>

<div>
    <table id="project_status_table_body" class="scrollable-table project_status_table tablesorter">
        <thead>
        <th class="catalogue-code sortable"><span id="id">Project Code</span></th>
        <th class="catalogue-name sortable"><span id="name">Project Name</span></th>
        <th class="catalogue-owner sortable"><span id="multimarket">Market</span></th>
        
       
        <th class="catalogue-owner sortable"><span id="pendingActivity">Next Steps</th>
     
        <th class="catalogue-owner sortable"><span id="personResponsible">Person Responsible</th>
        </thead>
        <tbody>

            <#list currentStatusBean as project>
            <tr <#if (project_index % 2) == 0> class="last"</#if>>
                <td class="catalogue-code" style="padding: 5px 29px">
                ${generateProjectCode('${project.projectID?c}')}
                </td>
                <td class="catalogue-name">
                    <a href="${project.pendingActionsLink?default("#")}">${project.projectName?string}</a>
                </td>
                <td class="catalogue-owner">
                    <#if project.multimarket>
                    <span>Multi Market</span>
                    <#else>
                       <#if project.endMarketName??>
                       		<span>${project.endMarketName}</span>
                       <#elseif project.endMarkets?? && project.endMarkets?size &gt;0 && project.endMarkets.get(0)?? && project.endMarkets.get(0).name??>
                           <span>${project.endMarkets.get(0).name}</span>
                       <#else>
                           <span></span>
                       </#if>
                    </#if>
                    
                </td>
                
                <td class="catalogue-owner">
                ${project.pendingActivity?default("")}
                </td>
                <td class="catalogue-owner">
                    
                   ${project.personResponsible?default("")}
                </td>
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
