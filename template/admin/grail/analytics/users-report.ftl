<html>
<head>
    <title>User Session Report</title>
    <content tag="pagetitle">User Report</content>
    <content tag="pageID">user-report</content>
    <style>
    </style>
<#-- Calender -->
<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
    <link rel="stylesheet" href="<@s.url value='${themePath}/style/admin/grail-analytics.css'/>" type="text/css" media="all" />
    <link rel="stylesheet" href="<@s.url value='${themePath}/style/jquery/normalize.css'/>" type="text/css" media="all" />
     <link rel="stylesheet" href="<@s.url value='${themePath}/style/jquery/datepicker.css'/>" type="text/css" media="all" />

  <#--  <script language="JavaScript" type="text/javascript" src="<@s.url value='/resources/scripts/jquery/jquery-min.js'/>"></script>
    <script language="JavaScript" type="text/javascript" src="<@s.url value='/resources/scripts/jquery/ui/ui.core-min.js'/>"></script>
    <script language="JavaScript" type="text/javascript" src="<@s.url value='/resources/scripts/jquery/ui/ui.datepicker-min.js'/>"></script>
-->


<#--<script language="JavaScript" type='text/javascript' src="<@s.url value='/resources/scripts/zapatec/utils/zapatec.js'/>"></script>-->
<#--<script language="JavaScript" type='text/javascript' src="<@s.url value='/resources/scripts/zapatec/zpcal/src/calendar.js'/>"></script>-->
<#--<script language="JavaScript" type='text/javascript' src="<@s.url value='/resources/scripts/zapatec/zpcal/lang/calendar-en.js'/>"></script>-->


 <@resource.javascript file="/resources/scripts/jquery/jquery.lightbox_me.js" />
    <@resource.javascript file="/resources/scripts/apps/userpicker/main.js" />
    <@resource.javascript file="/resources/scripts/apps/shared/views/date_picker_view.js" />
    <#include "/template/global/include/jive-macros.ftl" />
	
    <script type="text/javascript">
        jQuery(document).ready(function() {
           jQuery("#dateStart").datepicker({showOn: 'button', buttonImageOnly: true,
               buttonImage:"images/calendar/calendar.gif", showButtonPanel: true,
               dateFormat: "mm/dd/yy",
           maxDate:new Date()});
            jQuery("#dateEnd").datepicker({showOn: 'button', buttonImageOnly: true,
                buttonImage:"images/calendar/calendar.gif", showButtonPanel: true,
                dateFormat: "mm/dd/yy",
                maxDate:new Date()});
				
				var datePicker = new jive.shared.DatePicker.View({"locale": _jive_datepicker_locale});
            datePicker.addDependentDatePickers("#dateStart", "#dateEnd");
            datePicker.hide();
        });

        var ajx_total_items = 0;
        /* Helper for User Report - 1st */
        function fetchUserReportPage(startIndex, type){
            var dateStart = $('dateStart').value;
            var dateEnd = $('dateEnd').value;
            var numResults = $('numResults').value;
            var usr_rep_page_url = "";
            if(type == 1){
                usr_rep_page_url = "userReport.jspa?dateStart=" + dateStart + "&dateEnd=" + dateEnd+ "&start=0&numResults=" + startIndex;
            }
            if(type == 0){
                usr_rep_page_url = "userReport.jspa?dateStart=" + dateStart + "&dateEnd=" + dateEnd+ "&start=" + startIndex +"&numResults=" + numResults;
            }
            location.href = encodeURI(usr_rep_page_url);
        }

        /* Helper for User Report drill down AJAX report - 2nd */
        function userReportDrillDown(userID, activityType, resetStart){
            var startIndex = 0;
            if(!resetStart){
                startIndex = $("ajxStartIndex").value;
            }
            var numResults = $("ajxNumResults").value;
            var dateStart = $('dateStart').value;
            var dateEnd = $('dateEnd').value;

            /* set values for export as well */
            $("user_drill_form").userID.value = userID;
            $("user_drill_form").activityType.value = activityType;
            $("user_drill_form").dateStart.value = dateStart;
            $("user_drill_form").dateEnd.value = dateEnd;
            $("user_drill_form").ajxNumResults.value = numResults;

            var startIndex = 0;
            if(!resetStart){
                startIndex = $("ajxStartIndex").value;
            }
            var numResults = $("ajxNumResults").value;
            var dateStart = $('dateStart').value;
            var dateEnd = $('dateEnd').value;

            var finalParams = {
                numResults: numResults,
                start: startIndex,
                userID:userID,
                activityType:activityType,
                dateStart: dateStart,
                dateEnd: dateEnd
            };
            new Ajax.Updater("user_doc_drilldown_report_data", "<@s.url value='userDrillDownReport.jspa'/>", {
                method: 'get',
                asynchronous:true,
                evalScripts:true,
                parameters: finalParams
            });
            $("user_doc_drilldown_report").show();
        }


        function downloadDrillDownReport(ele){
            var selectEle = ele;
            if(selectEle.value == 0){
                selectEle.form.submit();
                selectEle.selectedIndex = 0;
            }
        }


        function sortByField(varSortField){
            var sortingFieldEle = $('sort_'+varSortField);
            var mainRepForm = $('main_user_report_form');
            var sortOrder;
            mainRepForm.sortField.value = varSortField;
        <#if Request.sortOrder == 0>
            $('main_user_report_form').sortOrder.value = 1;
        <#elseif Request.sortOrder == 1>
            $('main_user_report_form').sortOrder.value = 0;
        </#if>
        <#if Request.start??>
            $('main_user_report_form').start.value = ${Request.start?c};
        </#if>
            $('main_user_report_form').submit();
        }
    </script>
    <script type="text/javascript" src="../dwr/engine.js"></script>
    <script type="text/javascript" src="../dwr/util.js"></script>
    <script type="text/javascript" src="../dwr/interface/EventAnalyticsDWR.js"></script>

    <script type="text/javascript" src="<@s.url value="${themePath}/scripts/grail/grail.js"/>"></script>

</head>
<body>



<link rel="stylesheet" href="<@resource.url value='/styles/zapatec/styles/aqua.css'/>" type="text/css" media="all" />
<#include "/template/global/include/form-message.ftl" />

<div id="user_report_query_block" name="user_report_query_block">
    <form action="userReport.jspa" name="main_user_report_form" id="main_user_report_form">
        <div class="query_block">
        <@s.text name="analytics.dashboard.daterange.enter"/>:
            <label for="dateStart" style="padding-left:20px">
            <#assign stDate = '' />
            <#if Request.dateStart??>
                <#assign stDate = Request.dateStart?string("MM/dd/yyyy") />
            </#if>
            <#--<@jiveform.datetimepicker id="dateStart" name="dateStart"  value=""/>-->
            <input id="dateStart" name="dateStart"  value="">
            <#assign edDate = '' />
            <#if Request.dateEnd??>
                <#assign edDate =  Request.dateEnd?string("MM/dd/yyyy")  />
            </#if>
                <label for="dateEnd"><@s.text name="analytics.dashboard.daterange.end"/>:</label>
            <#--<@jiveform.datetimepicker id="dateEnd" name="dateEnd"  value=""/>-->
                <input id="dateEnd" name="dateEnd"  value="">
                <script language="JavaScript" type='text/javascript'>
                    $('dateStart').value="${stDate}";
                    $('dateEnd').value="${edDate}";
                </script>
                <input type="hidden" name="numResults" value="<#if numResults??>${numResults?c}<#else>10</#if>" />
                <!-- FIX for #311 -->
                <input type="hidden" name="start" value="0" />
                <input type="hidden" name="sortField" id="sortField" />
                <input type="hidden" name="sortOrder" id="sortOrder" />
                <input type="submit" value="Create Report">
        </div>
    </form>
</div>

<div id="user_report_wrapper" name="user_report_wrapper">
    <table border="1" width="100%">
        <tbody>
        <#if analyticsReportMap?? && analyticsReportMap?has_content>
        <tr>
            <th class="jive-table-head-title">Name</span></th>
            <th class="jive-table-head-title td_values" title="Documents Read">
					<span id="sort_1" class="<#if (Request.sortOrder == 0) && (Request.sortField == 1)>asc_sort<#else>desc_sort</#if><#if (Request.sortField == 1)> highlighted</#if>" onclick="sortByField(1);">
						Read
					</span>
            </th>
            <th class="jive-table-head-title td_values" title="Documents commented">
					<span id="sort_2" class="<#if (Request.sortOrder == 0) && (Request.sortField == 2)>asc_sort<#else>desc_sort</#if><#if (Request.sortField == 2)> highlighted</#if>" onclick="sortByField(2);">
						Comment
					</span>
            </th>
            <th class="jive-table-head-title td_values" title="Documents bookmarked">
					<span id="sort_3" class="<#if (Request.sortOrder == 0) && (Request.sortField == 3)>asc_sort<#else>desc_sort</#if><#if (Request.sortField == 3)> highlighted</#if>" onclick="sortByField(3);">
						Bookmark
					</span>
            </th>
            <th class="jive-table-head-title td_values last" title="Documents rated">
					<span id="sort_4" class="<#if (Request.sortOrder == 0) && (Request.sortField == 4)>asc_sort<#else>desc_sort</#if><#if (Request.sortField == 4)> highlighted</#if>" onclick="sortByField(4);">
						Document Rated
					</span>
            </th>
        </tr>
            <#list analyticsReportMap.keySet() as userID>
            <tr>
                <#assign userID = userID?c />
                <#assign u = jiveContext.userManager.getUser(userID) />
                <#assign eventDetailsMap = analyticsReportMap.get(userID)/>
                <#if (eventDetailsMap?has_content)>
                    <td>${SkinUtils.getDisplayName(u)}</td>
                    <td class="td_values"><#if eventDetailsMap.containsKey('READ_COUNT')>
                        <#assign read_cnt = eventDetailsMap.get('READ_COUNT')?c />
                        <a class="count_link" onclick="userReportDrillDown(${userID?c}, 'DOCUMENT_VIEWED', false);">
                        ${read_cnt}
                        </a>
                    <#else>0</#if>
                    </td>
                    <td class="td_values"><#if eventDetailsMap.containsKey('COMMENT_COUNT')>
                        <#assign comment_cnt = eventDetailsMap.get('COMMENT_COUNT')?c />
                        <a class="count_link" onclick="userReportDrillDown(${userID?c}, 'COMMENT_ADDED', false);">
                        ${comment_cnt}
                        </a>
                    <#else>0</#if></td>
                    <td class="td_values"><#if eventDetailsMap.containsKey('BOOKMARK_COUNT')>
                        <#assign bookmark_cnt = eventDetailsMap.get('BOOKMARK_COUNT')?c />
                        <a class="count_link" onclick="userReportDrillDown(${userID?c}, 'FAVORITE_added', false);">
                        ${bookmark_cnt}
                        </a>
                    <#else>0</#if></td>
                    <td class="td_values"><#if eventDetailsMap.containsKey('RATING_COUNT')>
                        <#assign rating_cnt = eventDetailsMap.get('RATING_COUNT')?c />
                        <a class="count_link" onclick="userReportDrillDown(${userID?c}, 'DOCUMENT_RATED', false);">
                        ${rating_cnt}
                        </a>
                    <#else>0</#if></td>
                <#else>
                    <td colspan="5" class="td_values">
                        No events for user - {userID?string}
                    </td>
                </#if>
            </tr>
            </#list>
        <#else>
        <tr>
            <td class="td_values">
                No data available
            </td>
        </tr>
        </#if>
        </tbody>
    </table>
<#if analyticsReportMap?? && analyticsReportMap?size &gt; 0 && analyticsReportMap?has_content>
    <table>
        <tbody>
        <tr>
            <td class="td_values">
                <form action="downloadUserReport.jspa" method="post" name="main_user_report_download_form">
                    <input type="hidden" value="${stDate}" name="dateStart" />
                    <input type="hidden" value="${edDate}" name="dateEnd" />
                    Export in Excel :
                    <select name="exportType" id="usr_top_exportType" onchange="downloadDrillDownReport(this);">
                        <option value="-1" selected>--select--</option>
                        <option value="0">Export this Report</option>
                    </select>
                </form>
            </td>
        </tr>
        </tbody>
    </table>
    <@pageDisplay showNumResultsSelectBox=true dropDownRequired=true/>
</#if>
</div>

<div id="user_doc_drilldown_report" name="user_doc_drilldown_report" style="display:none;">
    <div id="user_doc_drilldown_report_data" name="user_doc_drilldown_report_data" style="padding-top:10px;">

    </div>
<@ajxExportOption />
</div>

<#macro ajxExportOption>
<form action="downloadUserDrillDownReport.jspa" method="post" name="user_drill_form" id="user_drill_form">
    <input type="hidden" value="0" name="start" >
    <input type="hidden" name="userID">
    <input type="hidden" name="activityType">
    <input type="hidden" name="dateStart" id="dateStart">
    <input type="hidden" name="dateEnd" id="dateEnd">
    <input type="hidden" name="ajxStartIndex" id="ajxStartIndex">
    <input type="hidden" name="ajxNumResults" id="ajxNumResults">
    <script type="text/javascript">
        function downloadUserDrillDownDocument(ele){
            var selectEle = ele;
            $('user_drill_form').dateStart.value = $('dateStart').value;
            $('user_drill_form').dateEnd.value = $('dateEnd').value;
            if(selectEle.value == 0){
                selectEle.form.action = "downloadUserDrillDownReport.jspa";
                selectEle.form.submit();
                selectEle.selectedIndex = 0;
            }if(selectEle.value == 1){
                selectEle.form.action = "downloadAllDocReport.jspa";
                selectEle.form.submit();
                selectEle.selectedIndex = 0;
            }
        }
    </script>

    <div id="export_drill_down_report" style="padding-top:10px;">
			<span>Export this report :
				 <select name="exportType" id="exportType" onchange="downloadUserDrillDownDocument(this);">
                     <option value="-1" selected>--select--</option>
                     <option value="0">Export this Report</option>
                     <option value="1">All users All activities</option>
                 </select>
			</span>
    </div>
</form>
</#macro>

<#macro pageDisplay showNumResultsSelectBox=false dropDownRequired=false>
<table cellpadding="3" cellspacing="0" border="0" width="100%">
    <tr valign="top">
        <#if showNumResultsSelectBox>
            <td>
		    <span>
                <@numResultsSelect startIndex=newPaginator.start />
            </span>
            </td>
        </#if>

        <td style="text-align:right;">
            <#if (newPaginator.numPages > 1)>
                <@s.text name="global.pages" /><@s.text name="global.colon" />
                <#assign pages = newPaginator.getPages()>
                <#if dropDownRequired>
                    <span>Go to page :
                        <#assign pages = newPaginator.getPages()>
                        <select name="goto" id="goto" onchange="javascript:fetchUserReportPage(this.value, 0);">
                            <#list 0..pages?size-1 as idx>
                                <#if (pages[idx]?exists)>
                                    <option <#if (start/numResults)?c=idx?c>selected</#if> value="${pages[idx].start?c}">${pages[idx].number}</option>
                                </#if>
                            </#list>
                        </select>
                    </span>
                </#if>
                <span class="jive-paginator">
                [
                    <#if (newPaginator.previousPage)>
                        <a href="javascript:fetchUserReportPage(${newPaginator.previousPageStart?c}, 0)">
                            <@s.text name="global.previous" />
                        </a> |
                    </#if>
                    <#list 0..pages?size-1 as idx>
                        <#if (!pages[idx]?exists)>
                            <@s.text name="global.elipse" />
                        <#else>
                            <a href="javascript:fetchUserReportPage(${pages[idx].start?c}, 0)"
                               class="<#if (newPaginator.start?c == pages[idx].start?c)>jive-current</#if>">${pages[idx].number}</a>
                        </#if>
                    </#list>

                    <#if (newPaginator.nextPage)>
                        | <a href="javascript:fetchUserReportPage(${newPaginator.nextPageStart?c}, 0)">
                        <@s.text name="global.next" />
                    </a>
                    </#if>
                    ]
                </span>

            </#if>
        </td>

    </tr>
</table>
</#macro>

<#macro numResultsSelect eleName='numResults' startIndex=10?c>

Number of items :
<select name='${eleName}' id='${eleName}' onchange="javascript:fetchUserReportPage(this.value, 1);">
    <option value="10" <#if numResults?c=10?c>selected</#if>>10</option>
    <option value="20" <#if numResults?c=20?c>selected</#if>>20</option>
    <option value="30" <#if numResults?c=30?c>selected</#if>>30</option>
    <option value="40" <#if numResults?c=40?c>selected</#if>>40</option>
    <option value="50" <#if numResults?c=50?c>selected</#if>>50</option>
    <option value="100" <#if numResults?c=100?c>selected</#if>>100</option>
</select>
</#macro>
</body>
</html>