<#assign mYear = jiveContext.getSpringBean("synchroUtils").getYearDashboard() />
<#if projects?? && (projects?size > 0)>
<div class="project_dashboard_table_container">
<div class="project_dashboard_table_left">
<#--<div class="table-header">-->

<#--<table id="project_status_table_left_header" class="project_dashboard_table project_status_table tablesorter">-->
<#--<thead>-->
<#--<th class="project-code-col header sortable"><span id="id">Project Code</span></th>-->
<#--<th class="project-type-col header sortable"><span id="multimarket">Project Type</span></th>-->
<#--<th class="project-name-col header sortable"><span id="name">Project Name</span></th>-->
<#--<th class="project-start-date-col header sortable"><span id="startDate">Start<br/>Date</span></th>-->
<#--<th class="project-owner-col header sortable"><span id="owner">Owner</span></th>-->
<#--</thead>-->
<#--</table>-->
<#--</div>-->
<#--<div class="table-body">-->
    <table id="project_status_table_left_body" class="scrollable-table project_dashboard_table project_status_table tablesorter">
        <thead>
       <#-- <th class="project-code-col header sortable"><span id="id">Project Code</span></th> -->
        <#-- <th class="project-type-col header sortable"><span id="multimarket">Market(s)</span></th> -->
        <th class="project-name-col header sortable"><span id="name">Project<br/>Name</span></th>
        <th class="project-start-date-col header sortable"><span id="startDate">Start<br/>Date</span></th>
        <th class="project-owner-col header sortable"><span id="spiContact">Project<br/>Owner</span></th>
		<th class="project-emarkets header sortable"><span id="multimarket">Research End<br/>Market(s)</span></th>
		<th class="project-methodology header sortable"><span id="spiContact">Methodology</span></th>
		<th class="project-total-cost header sortable"><span id="spiContact">Total Cost (GBP)</span></th>
		<th class="project-project-stage header sortable"><span id="spiContact">Project Stage</span></th>

        </thead>
        <tbody>
            <#list projects as project>
            <tr <#if (project_index % 2) == 0> class="last"</#if> >               
                <td class="project-name-col">
                     <#if project.newSynchro>
							 <a href="${project.url}">${project.projectName?string}</a>
					<#elseif project.multimarket>
                        <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccessMultiMarket(project.projectID)
                        || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccessMultiMarket(project.projectID)) )>
                            <span>${project.projectName?string}</span>
                        <#else>
                            <a href="${project.url}">${project.projectName?string}</a>
                        </#if>
                    <#else>
                        <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccess(project.projectID)
                        || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccess(project.projectID)))>
                            <span>${project.projectName?string}</span>
                        <#else>
                            <a href="${project.url}">${project.projectName?string}</a>
                        </#if>
                    </#if>

                </td>
                <td class="project-start-date-col">
                    <#if project.multimarket>
                        <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccessMultiMarket(project.projectID)
                        || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccessMultiMarket(project.projectID)))>
                            <span></span>
                        <#else>
                            <span>${project.startDate?string("dd/MM/yyyy")}</span>
                        </#if>
                    <#else>
                        <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccess(project.projectID)
                        || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccess(project.projectID)) )>
                            <span></span>
                        <#else>
                            <#if project.startDate??>
							<span>${project.startDate?string("dd/MM/yyyy")}</span>
							</#if>
                        </#if>
                    </#if>

                </td>
					<td class="project-owner-col">
						<#if project.projectOwner??>
							<span>${project.projectOwner}</span>
						<#else>
							<span> Anonymous</span>
						</#if>
					</td>
					<td class="project-research-ems">
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
					<td class="project-methodology">
						<span>${project.methodology}</span>
					</td>
					<td class="project-total-cost">
						<span><#if project.totalCost??>${project.totalCost?c}</#if></span>
					</td>
					
					<td class="last project-status-col">
						<#if project.newSynchro>
							 ${project.status}
						<#elseif project.multimarket>
							<#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccessMultiMarket(project.projectID)
							|| statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccessMultiMarket(project.projectID)))>
								<span></span>
							<#else>
							${project.status}
							</#if>
						<#else>
							<#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccess(project.projectID)
							|| statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccess(project.projectID)) )>
								<span></span>
							<#else>
							${project.status}
							</#if>
						</#if>
                    </td>
            </tr>
            </#list>
        </tbody>
    </table>
</div>
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
        window.location.href = "/synchro/endmarket-dashboard.jspa?projectID="+id;
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

    function generateGraphBars() {
    
    }

    function getAvailableWidth() {
        return $j(".project_dashboard_table_middle .project_dashboard_table .table-header").width();
    }

    function getGraphBarPosition(year, month) {

        if(year > 0 && month > -1) {
            var currYear = ${mYear?c};

            if(year > (currYear + 2)) {
                year = (currYear + 2);
                month = 11;
            } else if(year < currYear) {
                year = currYear - 1;
                month = 0;
            }

            var yearWidth = $j(".project_dashboard_table .project-dates").width();
            var yearOffset = 0;
            var yearSeparatorPadding = $j(".project_dashboard_table_middle .inner .project_dashboard_table .separator").css("margin-left").replace("px","");
            var yearSeparatorOffset = yearSeparatorPadding * 2;
            if(year == (currYear + 1)) {
                yearOffset = (yearWidth + yearSeparatorOffset) + 5;
            } if(year == (currYear + 2)) {
                yearOffset = 2 * (yearWidth + yearSeparatorOffset) + 5;
            }
            var monthWidth = $j(".project_dashboard_table ul li").width();
            var monthOffset = (monthWidth) * month + monthWidth/2;

            return (yearOffset + monthOffset);
        }

    }

    function getYearSeparatorSpace() {
        var space = 0;
        if($j(".project_dashboard_table_middle .inner .project_dashboard_table .separator").css("margin-left")) {
            space += Number($j(".project_dashboard_table_middle .inner .project_dashboard_table .separator")
                    .css("margin-left").replace('px',''))
        }

        if($j(".project_dashboard_table_middle .inner .project_dashboard_table .separator").css("margin-right")) {
            space += Number($j(".project_dashboard_table_middle .inner .project_dashboard_table .separator")
                    .css("margin-right").replace('px',''))
        }

        if($j(".project_dashboard_table_middle .inner .project_dashboard_table .separator").css("width")) {
            space += Number($j(".project_dashboard_table_middle .inner .project_dashboard_table .separator")
                    .css("width").replace('px',''))
        }
        return space;

    }

    function getMonthString(val) {
        return months[val];
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