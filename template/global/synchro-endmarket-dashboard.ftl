<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/table-height-handler.js" type="text/javascript"></script>
<#assign mYear = jiveContext.getSpringBean("synchroUtils").getYearDashboard() />
<div class="container">
<div class="project_view">
<div class="dashboard-endmarket-back">
    <a href="/synchro/dashboard.jspa">Go Back</a>
</div>
<div class="project_dashboard_header">
    <h2>GANTT VIEW</h2>

    <div class="site_search">
        <h2>PLEASE CLICK ON THE PROJECT NAME TO VIEW THE DETAILED PROJECT PROGRESS</h2>
    </div>
</div>
<div class="project_dashboard_table_container">
<div class="project_dashboard_table_left">
    <table class="scrollable-table project_endmarket_dashboard project_dashboard_table project_status_table">
        <thead>
        <th class="project-code-col header">Project Code</th>
        <th class="project-type-col header">Market(s)</th>
        <th class="project-name-col header">Project Name</th>
        <th class="project-start-date-col header">Start Date</th>
        <th class="header last project-owner-col">SPI<br/>Contact</th>
        </thead>
        <tbody>
        <#-- fix-me: Should we populate this data as a bean n the push it to UX ?? -->
        <#assign userManager = jiveContext.getSpringBean("userManagerImpl") />
        <tr>
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
                <#if project.endMarkets?? && project.endMarkets?size &gt;0 && project.endMarkets.get(0)?? && project.endMarkets.get(0).name??>
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
            <#--<a href="${project.url}">${project.projectName?string}</a>-->
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
            <td class="project-owner-col last">
            <#if project.spiContact??>
            ${project.spiContact}
            <#else>
                Anonymous
            </#if>
            </td>
        </tr>

        <#list project.endMarkets as endMarket>
        <tr <#if (endMarket_index % 2) == 0> class="last"</#if>>
            <td class="project-code-col">&nbsp;</td>
            <td class="project-type-col"></td>
            <td class="project-endmarket-col project-name-col">-${endMarket.name?string}</td>
            <td class="project-start-date-col">
                &nbsp;
            </td>
            <td class="project-endmarket-owner-col project-owner-col">
                &nbsp;
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
            <tr>
            <#if project.multimarket>
                <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccessMultiMarket(project.projectID)
                || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccessMultiMarket(project.projectID)) && project.confidential)>
                    <td class="project-progress-bar-col"></td>
                <#else>
                    <td class="project-progress-bar-col view-row-div">
                        <div>
                            <div>
                                <div id="bar-main-${project.projectID?c}" class="project-statusbar-container"></div>
                            </div>
                        </div>
                    </td>
                </#if>
            <#else>
                <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccess(project.projectID)
                || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccess(project.projectID)) && project.confidential)>
                    <td class="project-progress-bar-col"></td>
                <#else>
                    <td class="project-progress-bar-col view-row-div">
                        <div>
                            <div>
                                <div id="bar-main-${project.projectID?c}" class="project-statusbar-container"></div>
                            </div>
                        </div>
                    </td>
                </#if>
            </#if>

            </tr>
            <#list project.endMarkets as endMarket>
            <tr <#if (endMarket_index % 2) == 0> class="last"</#if>>
                <td class="project-progress-bar-col view-row-div">
                    <div>

                        <div>
                            <div id="bar-${endMarket.id?c}" class="project-statusbar-container"></div>
                        </div>
                    </div>
                </td>
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
    <table id="project_status_table_right_body" class="scrollable-table project_dashboard_table project_status_table tablesorter">
        <thead>
        <th class="last project-status-col">Status</th>
        </thead>
        <tbody>
        <tr>
            <td class="last project-status-col">
            <#--<#assign projectStatusName = statics['com.grail.synchro.SynchroGlobal$Status'].getName(project.status) />-->
            <#--<#assign projectStatusDisplayName = statics['com.grail.synchro.SynchroGlobal'].getProjectStatusNames().get(projectStatusName) />-->
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
        <#list project.endMarkets as endMarket>
        <tr <#if (endMarket_index % 2) == 0> class="last"</#if>>
            <td class="last project-status-col">&nbsp;</td>
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

</div>
</div>
</div>


<#--<#macro renderProjectStatusBar width=0 projectid=-1>-->
<#--<div style="padding-left:${width}px;">-->
<#--<div id="bar-main-${projectid}"></div>-->
<#--</div>-->
<#--</#macro>-->

<#--<#macro renderProjectEndMarketStatusBar width=0 projectid=-1>-->
<#--<div style="padding-left:${width}px;">-->
<#--<div id="bar-${projectid}"></div>-->
<#--</div>-->
<#--</#macro>-->

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


<script type="text/javascript">

    $j(document).ready(function () {
        $j(".horizontal-scroll-table").mouseover(function(){
            $j(".horizontal-scroll-table .hscroll").show();
        });

        $j(".horizontal-scroll-table").mouseout(function(){
            $j(".horizontal-scroll-table .hscroll").hide();
        });
        generateGraphBars();
        updateTableRowHeight();
        adjustTableBodySize();
        TABLE_HEIGHT_HANDLER.initialize();
    });

    function generateGraphBars() {
        showGraphBar($j('#bar-main-${project.projectID?c}'),${project.startYear?c}, ${project.startMonth?c}, ${project.endYear?c}, ${project.endMonth?c});
    <#list project.endMarkets as endMarket>
        showGraphBar($j('#bar-${endMarket.id?c}'),${endMarket.startYear?c}, ${endMarket.startMonth?c}, ${endMarket.endYear?c}, ${endMarket.endMonth?c});
    </#list>
    }

    function showGraphBar(target, startYear,startMonth, endYear, endMonth) {
        var startPosition = getGraphBarPosition(startYear, startMonth);
        if(startYear <= 0  || startMonth <= -1) {
            $j(target).css("display","none");
            return false;
        }
        $j(target).parent().css('padding-left', startPosition);
        var barLength = 0;
        if(startYear == endYear && startMonth == endMonth) {
            barLength = 3;
        } else {
            barLength = getGraphBarPosition(endYear, endMonth)- startPosition;
        }
        $j(target).parent().parent().css('width','100%');
        $j(target).jqbar({ barLength: barLength, barColor: '#2caadd'});
//        $j(target).jqbar({ barLength: barLength, barColor: "#2caadd"})

    }



    function getAvailableWidth() {
        return $j(".project_dashboard_table_middle .project_dashboard_table .table-header").width();
    }

    function getGraphBarPosition(year, month) {
        console.log(year + " :: " + month);
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
        var months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
        return months[val];
    }

    function updateTableRowHeight() {
        $j(".project_dashboard_table_middle tbody tr").each(function(idx){
            var mh = $j(this).height();
            var lh = $j($j(".project_dashboard_table_left tbody tr")[idx]).height();
            var rh = $j($j(".project_dashboard_table_right tbody tr")[idx]).height();
            var h = Math.max(lh,mh,rh);
//            var bVer = navigator.appVersion;
//            if(bVer.indexOf('MSIE')) {
//                h = h + 1;
//            }
            $j($j(".project_dashboard_table_left tbody tr")[idx]).css("height",h);
            $j(this).css("height", h);
            $j($j(".project_dashboard_table_right tbody tr")[idx]).css("height",h);

        });
    }

    function adjustTableBodySize() {
        $j(".table-vscroll .scollinner").height($j(".project_status_table tbody").height() + 15);
        //$j(".table-vscroll").css("top",($j(".project_status_table thead").offset().top + $j(".project_status_table thead").height()  - 90) + "px");
        $j(".table-vscroll").css("top",($j($j(".project_status_table thead")[0]).height()) + 1 + "px");
    }


</script>
