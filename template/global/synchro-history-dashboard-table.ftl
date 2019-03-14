<#if projectHistoryByPage?? && (projectHistoryByPage?size > 0)>
<table id="project_status_table" class="project_status_table tablesorter">
            <thead>			
                <th class="catalogue-code sortable"><span id="id">Project Code</span></th>
                <th class="catalogue-name sortable"><span id="name">Project Name</span></th>
                <th class="header sortable"><span id="owner">Owner</span></th>
                <th class="catalogue-year sortable"><span id="year">Year</span></th>
				<th class="header">Region</th>
                <th class="header">Country</th>
                <th class="header sortable"><span id="brand">Brand</span></th>                
                <th class="catalogue-link">Status</th> 
            </thead>
            <tbody>
	
	<#list projectHistoryByPage as project>					
		<tr <#if (project_index % 2) == 0> class="last"</#if>>
			<td class="project-code-col">
				${generateProjectCode('${project.projectID?c}')}
			</td>
			<td>
				<a href="${project.url}">${project.projectName?string}</a>
			</td>
			<td class="project-owner-col">
				<#if project.owner??>
					${project.owner}
				<#else>
					Anonymous
				</#if>
			</td>
			<td class="clickable-bar">
				${project.startYear}
			</td>
			<td class="clickable-bar">
				${project.region}
			</td>
			<td class="clickable-bar">
				${project.country}
			</td>
			<td class="clickable-bar">
				${project.brand}			
			</td>			
			<td class="last project-history-col">
			 ${project.status}
			</td>
		</tr>
	
	</#list>
	
			</tbody>
        </table>
	<#else>
		<script type="text/javascript">
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
	<div class="no-content">No Project History</div>	
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