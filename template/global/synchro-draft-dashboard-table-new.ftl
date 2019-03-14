
<#if projects?? && (projects?size > 0)>
<div>
    <table id="project_status_table_body" class="scrollable-table project_status_table tablesorter">
        <thead>
        
	<th class="catalogue-name sortable cat-sett"><span id="name">Project Name</span></th>

	<th class="catalogue-year sortable"><span id="projectStartDate">Project Start<br/>Date</span></th>
	<th class="catalogue-year sortable"><span id="projectManager">SP&I Contact</span></th>
      
      
    
	<th class="catalogue-year sortable"><span id="status">Project Status</span></th>
	

        </thead>
        <tbody>
            <#list projects as project>
            <tr <#if (project_index % 2) == 0> class="last"</#if> >
                
				<td class="catalogue-name cat-sett">
                    <a href="${project.url}" target="_blank">${project.projectName?string}</a>

                </td>
				<td class="catalogue-year">
                    <#if project.startDate??>
						<span>${project.startDate?string("dd/MM/yyyy")}</span>
					<#else>
						<span></span>
					</#if>

                </td>
				 
                <td class="catalogue-year">
                     <#if project.projectManagerName??>
						<span>${project.projectManagerName}</span>
					<#else>
						<span></span>
					</#if>

                </td>
               
              
				
				<td class="catalogue-year">
                    
					<span>${project.projectStage}</span>
					
                </td>
				
               
            </tr>
            </#list>
        </tbody>
    </table>
    
    <select name="project-limit" id="project-limit" onchange="loadLimit()">
	<option value="10">10</option>
	<option value="15">15</option>
	<option value="20">20</option>
	<option value="50">50</option>
	<option value="100">100</option>
</select>



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
<div class="no-content">No Projects in My Dashboard </div>
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
    var months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];

    $j('.project-statusbar-container').click(function() {
        var id =$j(this).attr("id").slice(4);
        window.location.href = "/new-synchro/endmarket-dashboard.jspa?projectID="+id;
    });

    $j(document).ready(function() {
        //$j("#project_status_table_left").freezeHeader();
        $j(".horizontal-scroll-table").mouseover(function(){
            $j(".horizontal-scroll-table .hscroll").show();
        });

        $j(".horizontal-scroll-table").mouseout(function(){
            $j(".horizontal-scroll-table .hscroll").hide();
        });
    });

    

    function getAvailableWidth() {
        return $j(".project_dashboard_table_middle .project_dashboard_table .table-header").width();
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