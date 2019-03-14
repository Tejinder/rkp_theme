<#if projectsByPage?? && (projectsByPage?size > 0)>
<table id="project_status_table" class="project_status_table tablesorter">
            <thead>
				<th class="project-select-col">&nbsp;</th>
                <th class="catalogue-code sortable"><span id="id">Project <br>Code</span></th>
                <th class="sortable"><span id="name">Project Name</span></th>
                <th class="catalogue-owner sortable"><span id="owner">Owner</span></th>
                <th class="catalogue-year sortable"><span id="year">Year</span></th>
				<th class="project-region-col"><span>Region</span></th>
                <th class="project-country-col"><span>Country</span></th>
                <th class="project-owner-col sortable"><span id="brand">Brand</span></th>
                <th class="project-supplier-col"><span>Supplier Group</span></th>
                <th class="last project-status-col sortable"><span id="status">Status</span></th>
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
			<#assign projectStatus = statics['com.grail.synchro.SynchroGlobal$Status'].getName(project.status) />
				${projectStatus}
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
		<div class="project_dashboard_header" style="padding-bottom:20px;">
			<h2>Extract</h2>
		</div>	
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
	  // window.location.href = "/synchro/project-status!input.jspa?projectID="+projectID;
	   });
	   

	   	   
</script>
<script src="${themePath}/js/pagination.custom.js" type="text/javascript"></script>
