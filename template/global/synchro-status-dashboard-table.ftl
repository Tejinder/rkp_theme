<#if projectsByPage?? && (projectsByPage?size > 0)>
<table id="project_status_table" class="project_status_table tablesorter">
            <thead>
				<th class="project-select-col sortable">&nbsp;</th>
                <th class="catalogue-code sortable"><span id="id">Project Code</span></th>
                <th class="catalogue-name sortable"><span id="name">Project Name</span></th>
                <th class="catalogue-owner sortable"><span id="owner">Owner</span></th>
                <th class="catalogue-year sortable"><span id="year">Year</span></th>
				<th class="project-region-col">Region</th>
                <th class="project-country-col">Country</th>
                <th class="catalogue-brand sortable"><span id="brand">Brand</span></th>
                <th class="project-supplier-col">Supplier Group</th>
                <th class="last waiver-status sortable"><span id="status">Status</span></th>
            </thead>
            <tbody>

	<#list projectsByPage as project>					
		<tr <#if (project_index % 2) == 0> class="last"</#if>>
			<td class="project-select-col">
				<input name="project-select" class="" value="${project.projectID?c}" type="radio" />
			</td>
			<td class="project-code-col">
				${project.projectID?c}
			</td>
			<td>
				<a href="project-details!input.jspa?projectID=${project.projectID?c}">${project.projectName?string}</a>
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
			<td class="clickable-bar">
				${project.supplierGroup}
			</td>
			<td class="last project-status-col">			
				${project.status}
			</td>
		</tr>
	
	</#list>


			</tbody>
        </table>
		 
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
	<div class="project_view">
		<div class="no-content">No Projects owned by you</div>
    </div>
		
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
	$j("#form_submit").click(function() {
	   var selectedProject = $j('input[name=project-select]');
	   var projectID = selectedProject.filter(':checked').val();
	   if(projectID == undefined)
	   {
		dialog();
		$j("#dialog-box").html("Please select a project");
		return false;
	   }
	   window.location.href = "/synchro/project-status!input.jspa?projectID="+projectID;
	   });	   	   
</script>
<script src="${themePath}/js/pagination.custom.js" type="text/javascript"></script>
