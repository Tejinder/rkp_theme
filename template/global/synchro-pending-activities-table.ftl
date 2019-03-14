
<#if pendingActivities?? && (pendingActivities?size > 0)>
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
        <th class="catalogue-code sortable"><span id="id">Project Code</span></th>
        <th class="catalogue-name sortable"><span id="name">Project Name</span></th>
        <th class="catalogue-owner sortable"><span id="owner">Owner</span></th>
        <th class="catalogue-year sortable"><span id="year">Year</span></th>
        <th class="catalogue-brand sortable"><span id="brand">Brand</span></th>
        <th class="catalogue-type">Pending Activity Type</th>
        <th class="catalogue-link">Pending Activity Link</th>
        </thead>
        <tbody>

            <#list pendingActivities as project>
            <tr <#if (project_index % 2) == 0> class="last"</#if>>
                <td class="catalogue-code">
                ${generateProjectCode('${project.projectID?c}')}
                </td>
                <td class="catalogue-name">
                    <a href="${project.activityLink?default("#")}">${project.projectName?string}</a>
                </td>
                <td class="catalogue-owner">
                    <#if project.owner??>
                    ${project.owner}
                    <#else>
                        Anonymous
                    </#if>
                </td>
                <td class="catalogue-year">
                ${project.startYear}
                </td>
                <td class="catalogue-brand">
                ${project.brand}
                </td>
                <td class="catalogue-type">
                ${project.pendingActivity?default("")}
                </td>
                <td class="catalogue-link">
                    <#assign link = project.activityLink?default("") />
                    <a onClick="javascript:captureAuditLog();" href="${link}">${link}</a>
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
	function captureAuditLog()
	{		
	<#assign i18CustomText><@s.text name="logger.project.pending.link.text" /></#assign>	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DASHBOARDPENDINGACTV.getId()}, "${i18CustomText}", "", -1, ${user.ID?c});
	}
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
