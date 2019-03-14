
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
<style>
.project_status_table tr .catalogue-brand{width:12%;}
.project_status_table tr .catalogue-code{width:11%;}
.project_status_table tr .catalogue-name{width:18%;}

</style>
<div>
    <table id="project_status_table_body" class="scrollable-table project_status_table tablesorter">
        <thead>
        <th class="catalogue-code sortable"><span id="id">Project Code</span></th>
        <th class="catalogue-name sortable"><span id="name">Project Name</span></th>
        <th class="catalogue-owner sortable"><span id="projectType">Project Type</span></th>
        <th class="catalogue-year sortable"><span id="startDate">Project Start Date</span></th>
        <th class="catalogue-brand sortable"><span id="projectManager">SP&I Contact</span></th>
        <th class="catalogue-type sortable"><span id="methodology">Methodology</span></th>
        <th class="catalogue-brand sortable"><span id="pendingAction">Approval Pending</span></th></th>
        </thead>
        <tbody>

            <#list pendingActivities as project>
            <tr <#if (project_index % 2) == 0> class="last"</#if>>
                <td class="catalogue-code">
                ${generateProjectCode('${project.projectID?c}')}
                </td>
                <td class="catalogue-name">
                    <a href="${project.activityLink?default("#")}" target="_blank">${project.projectName?string}</a>
                </td>
                <td class="catalogue-owner">
                     <#if project.projectType??>
                    ${project.projectType}
                    <#else>
                        
                    </#if>
					
                </td>
                <td class="catalogue-year">
                <#if project.startDate??>
					 ${project.startDate?string('dd/MM/yyyy')}
				</#if>
                </td>
                <td class="catalogue-brand">
                <#if project.projectManager??>
                    ${project.projectManager}
                    <#else>
                        
                    </#if>
                </td>
                <td class="catalogue-type">
               
				 <#if project.methodology??>
                    ${project.methodology}
                    <#else>
                        
                    </#if>
				
                </td>
                <td class="catalogue-brand">
                   ${project.pendingActivity?default("")}
                </td>
            </tr>
            </#list>

        </tbody>

    </table>
<!-- Items code-->
<select name="project-limit" id="project-limit" onchange="loadLimit()">
	<option value="10">10</option>
	<option value="15">15</option>
	<option value="20">20</option>
	<option value="50">50</option>
	<option value="100">100</option>
</select>
<span id="project-limit-text">items per page</span>

    
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
<#if plimit??>
	$j("#project-limit").val(${plimit});
</#if>
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
