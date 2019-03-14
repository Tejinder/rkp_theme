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
        <th class="project-code-col header sortable"><span id="id">Project Code</span></th>
        <th class="project-type-col header sortable"><span id="multimarket">Market(s)</span></th>
        <th class="project-name-col header sortable"><span id="name">Project<br/>Name</span></th>
        <th class="project-start-date-col header sortable"><span id="startDate">Start<br/>Date</span></th>
        <th class="project-owner-col header sortable"><span id="spiContact">SPI<br/>Contact</span></th>

        </thead>
        <tbody>
            <#list projects as project>
            <tr <#if (project_index % 2) == 0> class="last"</#if> >
                <td class="project-code-col">
                <#--<#if project.multimarket>-->
                <#--<span class="multi-market-icon-small">${generateProjectCode('${project.projectID?c}')}</span>-->
                <#--<#else>-->
                <#--<span class="single-market-icon-small">${generateProjectCode('${project.projectID?c}')}</span>-->
                <#--</#if>-->
                    <span>${generateProjectCode('${project.projectID?c}')}</span>
                </td>
                <td class="project-type-col">
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
                <td class="project-name-col">
                    <#if project.multimarket>
                        <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccessMultiMarket(project.projectID)
                        || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccessMultiMarket(project.projectID)) && project.confidential)>
                            <span>${project.projectName?string}</span>
                        <#else>
                            <a href="${project.url}">${project.projectName?string}</a>
                        </#if>
                    <#else>
                        <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccess(project.projectID)
                        || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccess(project.projectID)) && project.confidential)>
                            <span>${project.projectName?string}</span>
                        <#else>
                            <a href="${project.url}">${project.projectName?string}</a>
                        </#if>
                    </#if>

                </td>
                <td class="project-start-date-col">
                    <#if project.multimarket>
                        <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccessMultiMarket(project.projectID)
                        || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccessMultiMarket(project.projectID)) && project.confidential)>
                            <span></span>
                        <#else>
                            <span>${project.startDate?string("dd/MM/yyyy")}</span>
                        </#if>
                    <#else>
                        <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccess(project.projectID)
                        || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccess(project.projectID)) && project.confidential)>
                            <span></span>
                        <#else>
                            <span>${project.startDate?string("dd/MM/yyyy")}</span>
                        </#if>
                    </#if>

                </td>
                <td class="project-owner-col">
                    <#if project.spiContact??>
                        <span>${project.spiContact}</span>
                    <#else>
                        <span> Anonymous</span>
                    </#if>

                </td>
            </tr>
            </#list>
        </tbody>
    </table>
</div>

<div class="project_dashboard_table_middle horizontal-scroll-table">

    <div class="inner">

        <table id="project_status_table_middle_body" class="scrollable-table project_dashboard_table project_status_table tablesorter">
            <thead>
            <th class="project-progress-bar-col last header">
                <div class="table-header">
                    <div class="project-dates">

                        <span id="year-${mYear?c}">${mYear?c}</span>
                        <ul>
                            <li class="move-down"><p id="${mYear?c}-jan">Jan</p><div class="line"></div></li>
                            <li><p id="${mYear?c}-feb">Feb</p><div class="line"></div></li>
                            <li class="move-down"><p id="${mYear?c}-mar">Mar</p><div class="line"></li>
                            <li><p id="${mYear?c}-apr">Apr</p><div class="line"></li>
                            <li class="move-down"><p id="${mYear?c}-may">May</p><div class="line"></li>
                            <li><p id="${mYear?c}-jun">Jun</p><div class="line"></li>
                            <li class="move-down"><p id="${mYear?c}-jul">Jul</p><div class="line"></li>
                            <li><p id="${mYear?c}-aug">Aug</p><div class="line"></li>
                            <li class="move-down"><p id="${mYear?c}-sep">Sep</p><div class="line"></li>
                            <li><p id="${mYear?c}-oct">Oct</p><div class="line"></li>
                            <li class="move-down"><p id="${mYear?c}-nov">Nov</p><div class="line"></li>
                            <li><p id="${mYear?c}-dec">Dec</p><div class="line"></li>
                        </ul>
                    </div>
                    <div class="separator"></div>
                    <div class="project-dates">
                        <span id="year-${(mYear + 1)?c}">${(mYear + 1)?c}</span>
                        <ul>
                            <li class="move-down"><p id="${(mYear + 1)?c}-jan">Jan</p><div class="line"></div></li>
                            <li><p id="${(mYear + 1)?c}-feb">Feb</p><div class="line"></div></li>
                            <li class="move-down"><p id="${(mYear + 1)?c}-mar">Mar</p><div class="line"></li>
                            <li><p id="${(mYear + 1)?c}-apr">Apr</p><div class="line"></li>
                            <li class="move-down"><p id="${(mYear + 1)?c}-may">May</p><div class="line"></li>
                            <li><p id="${(mYear + 1)?c}-jun">Jun</p><div class="line"></li>
                            <li class="move-down"><p id="${(mYear + 1)?c}-jul">Jul</p><div class="line"></li>
                            <li><p id="${(mYear + 1)?c}-aug">Aug</p><div class="line"></li>
                            <li class="move-down"><p id="${(mYear + 1)?c}-sep">Sep</p><div class="line"></li>
                            <li><p id="${(mYear + 1)?c}-oct">Oct</p><div class="line"></li>
                            <li class="move-down"><p id="${(mYear + 1)?c}-nov">Nov</p><div class="line"></li>
                            <li><p id="${(mYear + 1)?c}-dec">Dec</p><div class="line"></li>
                        </ul>
                    </div>
                    <div class="separator"></div>
                    <div class="project-dates">
                        <span id="year-${(mYear + 2)?c}">${(mYear + 2)?c}</span>
                        <ul>
                            <li class="move-down"><p id="${(mYear + 2)?c}-jan">Jan</p><div class="line"></div></li>
                            <li><p id="${(mYear + 2)?c}-feb">Feb</p><div class="line"></div></li>
                            <li class="move-down"><p id="${(mYear + 2)?c}-mar">Mar</p><div class="line"></li>
                            <li><p id="${(mYear + 2)?c}-apr">Apr</p><div class="line"></li>
                            <li class="move-down"><p id="${(mYear + 2)?c}-may">May</p><div class="line"></li>
                            <li><p id="${(mYear + 2)?c}-jun">Jun</p><div class="line"></li>
                            <li class="move-down"><p id="${(mYear + 2)?c}-jul">Jul</p><div class="line"></li>
                            <li><p id="${(mYear + 2)?c}-aug">Aug</p><div class="line"></li>
                            <li class="move-down"><p id="${(mYear + 2)?c}-sep">Sep</p><div class="line"></li>
                            <li><p id="${(mYear + 2)?c}-oct">Oct</p><div class="line"></li>
                            <li class="move-down"><p id="${(mYear + 2)?c}-nov">Nov</p><div class="line"></li>
                            <li><p id="${(mYear + 2)?c}-dec">Dec</p><div class="line"></li>
                        </ul>
                    </div>
                </div>
            </th>
            </thead>


            <tbody>
                <#list projects as project>
                <tr <#if (project_index % 2) == 0> class="last"</#if> >
                    <#if project.multimarket>
                        <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccessMultiMarket(project.projectID)
                        || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccessMultiMarket(project.projectID)) && project.confidential)>
                            <td class="project-progress-bar-col"></td>
                        <#else>
                            <td class="project-progress-bar-col clickable-bar">
                                <div class="view-row-div">
                                    <div>
                                        <div id="bar-${project.projectID?c}" class="project-statusbar-container">
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </#if>
                    <#else>
                        <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccess(project.projectID)
                        || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccess(project.projectID)) && project.confidential)>
                            <td class="project-progress-bar-col"></td>
                        <#else>
                            <td class="project-progress-bar-col clickable-bar">
                                <div class="view-row-div">
                                    <div>
                                        <div id="bar-${project.projectID?c}" class="project-statusbar-container">
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </#if>
                    </#if>

                </tr>
                </#list>
            </tbody>
        </table>
    </div>
    <div class="hscroll"><div class="scollinner"><span>&nbsp;</span></div></div>
    <script type="text/javascript">
        $j(".hscroll").scroll(function(event) {
            $j(".project_dashboard_table_middle .inner").scrollLeft($j(this).scrollLeft());
        });
    </script>


</div>

<div class="project_dashboard_table_right">
    <#--<div>-->
        <table id="project_status_table_right_body" class="scrollable-table project_dashboard_table project_status_table">

            <thead>
            <th class="project-status-col last header sortable"><span id="status">Status</span></th>
            </thead>
            <tbody>
                <#list projects as project>
                <tr <#if (project_index % 2) == 0> class="last"</#if> >
                    <td class="last project-status-col">
                        <#if project.multimarket>
                            <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccessMultiMarket(project.projectID)
                            || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccessMultiMarket(project.projectID)) && project.confidential)>
                                <span></span>
                            <#else>
                            ${project.status}
                            </#if>
                        <#else>
                            <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccess(project.projectID)
                            || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccess(project.projectID)) && project.confidential)>
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
    <#--</div>-->
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
    <#if projects?? && (projects?size > 0)>
        <#list projects as project>
            var startPosition = getGraphBarPosition(${project.startYear?c}, ${project.startMonth?c})
            if(${project.startYear?c} <= 0  || ${project.startMonth?c} <= -1) {
            $j('#bar-${project.projectID?c}').css("display","none");
        }
            $j('#bar-${project.projectID?c}').parent().css('padding-left', startPosition);
            var barLength = 0;
            if(${project.startYear?c} == ${project.endYear?c} && ${project.startMonth?c} == ${project.endMonth?c}) {
            barLength = 3;
        } else {
            barLength = getGraphBarPosition(${project.endYear?c}, ${project.endMonth?c})- startPosition;
        }
            $j('#bar-${project.projectID?c}').parent().parent().css('width','100%');
        <#--$j('#bar-${project.projectID?c}').jqbar({ barLength: barLength, barColor: '${project.graphColor}' });-->
            $j('#bar-${project.projectID?c}').jqbar({ barLength: barLength, barColor: '#2caadd' });
            //d9d9d9

        </#list>
    </#if>
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