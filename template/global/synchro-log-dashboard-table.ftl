<#if projectID?? && (projectID > 0)>
	<#include "/template/global/synchro-project-log-dashboard-table.ftl" />
<#else>
<#assign mYear = jiveContext.getSpringBean("synchroUtils").getYearDashboard() />
<#if logs?? && (logs?size > 0)>
<div class="project_dashboard_table_container">
<div class="project_dashboard_table_left">
    <table id="project_logs_table_body" class="scrollable-table project_status_table tablesorter">
        <thead>
        <th class="log-timestamp sortable"><span id="timestamp">Timestamp</span></th>
        <th class="log-username sortable"><span id="userName">Username</span></th>
        <th class="log-portal sortable"><span id="portal">Portal Name</span></th>
        <th class="log-page sortable"><span id="page">Page Access</span></th>
        <th class="log-activity sortable"><span id="type">Activity<br /> Type</span></th>
		<th class="log-description"><span>Activity Description</span></th>
		<th class="log-projectcode sortable"><span id="id">Project Code</span></th>
		<th class="log-projectname sortable"><span id="name">Project Name</span></th>
        </thead>
        <tbody>
            <#list logs as log>		
			<#if log.descriptions?? && (log.descriptions?size > 0)>
			<#assign showRow = true />
			<#list log.descriptions as description>						
				<tr id="log-${log_index}-${description_index}" <#if !showRow>style="display:none;"</#if><#if (log_index % 2) == 0> class="last"</#if>>
					<td class="log-timestamp">
						<span><#if description_index==0>${log.timestamp}</#if></span>
					</td>
					<td class="log-username">
						<#if log.username??>
							<span><#if description_index==0>${log.username}</#if></span>
						<#else>
							<span><#if description_index==0>Anonymous</#if></span>
						</#if>

					</td>                
					<td class="log-portal">
						<span><#if description_index==0>${log.portalname}</#if></span>
					</td>
					<td class="log-page">
					  <span><#if description_index==0>${log.page}</#if></span>
					</td>
					<td class="log-activity">
					  <span><#if description_index==0>${log.activity}</#if></span>
					</td>
					<td class="log-description">
						<span>${description} <#if (log.descriptions?size>1) && (description_index==0)><br /><a class="synchro-log-link" id="show-log-${log_index}" href="javascript:void(0);" onClick="showDetailedRows('log-${log_index}');">(Click for more details)</a><#elseif (log.descriptions?size>1) && (description_index==(log.descriptions?size-1))><br /><a  class="synchro-log-link" style="display:none();" id="hide-log-${log_index}" href="javascript:void(0);" onClick="hideDetailedRows('log-${log_index}');">(Hide details)</a></#if></span>
					</td>
					<td class="log-projectcode">
						<span><#if description_index==0><#if log.projectID??>${log.projectID?c}</#if></#if></span>
					</td>
					<td class="log-projectname">
						<span><#if description_index==0>${log.projectName}</#if></span>
					</td>
				</tr>
				<#if (log.descriptions?size>1) && (description_index==0)>
					<#assign showRow = false />
				</#if>
			</#list>
			
			</#if>
           
            </#list>
        </tbody>
    </table>
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
<div class="no-content">No logs in My Dashboard </div>
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

    $j(document).ready(function() {
        //$j("#project_status_table_left").freezeHeader();
        $j(".horizontal-scroll-table").mouseover(function(){
            $j(".horizontal-scroll-table .hscroll").show();
        });

        $j(".horizontal-scroll-table").mouseout(function(){
            $j(".horizontal-scroll-table .hscroll").hide();
        });
    });
	
	function showDetailedRows(rowid)
	{		
		$j('tr[id^='+rowid+']').each(function(idx) {	
			$j(this).show();
		});
		//$j("#"+rowid+"-0").scrollTop(0);		
		$j("#show-"+rowid).hide();		
		$j("#hide-"+rowid).show();
	}
	
	function hideDetailedRows(rowid)
	{		
		$j('tr[id^='+rowid+']').each(function(idx) {	
			if(idx>0)
				$j(this).hide();
		});
		
		$j("#show-"+rowid).show();		
		$j("#hide-"+rowid).hide();
	}

    function updateTableRowHeight() {
        $j(".project_dashboard_table_middle tbody tr").each(function(idx) {
            var mh = $j(this).height();
            var lh = $j($j(".project_dashboard_table_left tbody tr")[idx]).height();
            var rh = $j($j(".project_dashboard_table_right tbody tr")[idx]).height();
            var h = Math.round(Math.max(lh,mh,rh));
            var bVer = navigator.appVersion;
            if(bVer.indexOf('MSIE')) {
                h = h + 1;
            }
            $j($j(".project_dashboard_table_left tbody tr")[idx]).height(h);
            $j($j(".project_dashboard_table_middle tbody tr")[idx]).height(h);
            $j($j(".project_dashboard_table_right tbody tr")[idx]).height(h);
        });
    }



</script>
<script src="${themePath}/js/pagination.custom.js" type="text/javascript"></script>
</#if>