<html>
<head>
    <title>Document Report</title>
    <content tag="pagetitle">Document Report</content>
    <content tag="pageID">document-report</content>

<script type="text/javascript" src="<@s.url value='/resources/scripts/prototype/prototype.js' />"></script>

<#-- Calender -->
<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
    <link rel="stylesheet" href="<@s.url value='${themePath}/style/admin/grail-analytics.css'/>" type="text/css" media="all" />
    <link rel="stylesheet" href="<@s.url value='${themePath}/style/jquery/normalize.css'/>" type="text/css" media="all" />
    <link rel="stylesheet" href="<@s.url value='${themePath}/style/jquery/datepicker.css'/>" type="text/css" media="all" />
    <script language="JavaScript" type="text/javascript" src="<@s.url value='/resources/scripts/jquery/jquery-min.js'/>"></script>
    <script language="JavaScript" type="text/javascript" src="<@s.url value='/resources/scripts/jquery/ui/ui.core-min.js'/>"></script>
    <script language="JavaScript" type="text/javascript" src="<@s.url value='/resources/scripts/jquery/ui/ui.datepicker-min.js'/>"></script>

<#--<script language="JavaScript" type='text/javascript' src="<@s.url value='/resources/scripts/zapatec/utils/zapatec.js'/>"></script>-->
<#--<script language="JavaScript" type='text/javascript' src="<@s.url value='/resources/scripts/zapatec/zpcal/src/calendar.js'/>"></script>-->
<#--<script language="JavaScript" type='text/javascript' src="<@s.url value='/resources/scripts/zapatec/zpcal/lang/calendar-en.js'/>"></script>-->


<#-- DWR related -->
<script type="text/javascript" src="../dwr/engine.js"></script>
<script type="text/javascript" src="../dwr/util.js"></script>
<script type="text/javascript" src="../dwr/interface/EventAnalyticsDWR.js"></script>

<#-- Grails -->
<script type="text/javascript" src="<@s.url value="${themePath}/scripts/grail/grail.js"/>"></script>

<script type="text/javascript">

    jQuery(document).ready(function() {
        jQuery("#dateStart").datepicker({showOn: 'button', buttonImageOnly: true,
            buttonImage:"images/calendar/calendar.gif", showButtonPanel: true,
            dateFormat: "dd/mm/yy",
            maxDate:new Date()});
        jQuery("#dateEnd").datepicker({showOn: 'button', buttonImageOnly: true,
            buttonImage:"images/calendar/calendar.gif", showButtonPanel: true,
            dateFormat: "dd/mm/yy",
            maxDate:new Date()});
    });

	/* Helper for document Report - 1st */
	function fetchDocumentReportPage(startIndex, type){
		var dateStart = $('dateStart').value;
		var dateEnd = $('dateEnd').value;
		var numResults = $('numResults').value;
		var usr_rep_page_url = "";
		if(type == 1){
		  usr_rep_page_url = "documentReport.jspa?dateStart=" + dateStart + "&dateEnd=" + dateEnd+ "&start=0&numResults=" + startIndex;
		}
		if(type == 0){
		  usr_rep_page_url = "documentReport.jspa?dateStart=" + dateStart + "&dateEnd=" + dateEnd+ "&start=" + startIndex +"&numResults=" + numResults;
		}
		location.href = encodeURI(usr_rep_page_url);
	}


	/* Helper for document Report drill down AJAX report - 2nd */
	function documentReportDrillDown(documentID, activityType, resetStartIndex){
		var startIndex = 0;
		if(!resetStartIndex){
			startIndex = $("doc_drill_form").ajxStartIndex.value;
		}
		var dateStart = $('dateStart').value;
		var dateEnd = $('dateEnd').value;

		/* set values for export as well */
		$("document_doc_drilldown_report").show();
		$("doc_drill_form").doc_id.value = documentID;
		$("doc_drill_form").userID.value = documentID;
		$("doc_drill_form").activityType.value = activityType;
		$("doc_drill_form").dateStart.value = dateStart;
		$("doc_drill_form").dateEnd.value = dateEnd;

		var numResults = $("doc_drill_form").ajxNumResults.value;


		var paginatorParams = {
			    numResults: numResults,
                            start: startIndex,
			    userID:documentID,
                            activityType:activityType,
                            dateStart: dateStart,
                            dateEnd: dateEnd
		          };
		//alert(Object.toJSON(paginatorParams));
		new Ajax.Updater("document_doc_drilldown_report_data", "documentDrillDownReport.jspa", {
			method: 'get',
			asynchronous:true,
			evalScripts:true,
			parameters: paginatorParams
	        });
	}

	function sortByField(varSortField){
		var sortingFieldEle = $('sort_'+varSortField);
		var mainRepForm = $('main_doc_report_form');
		var sortOrder;
		mainRepForm.sortField.value = varSortField;
		<#if Request.sortOrder == 0>
			$('main_doc_report_form').sortOrder.value = 1;
		<#elseif Request.sortOrder == 1>
			$('main_doc_report_form').sortOrder.value = 0;
		</#if>
        <#if Request.start??>
			$('main_doc_report_form').start.value = ${Request.start?c};
        </#if>
		$('main_doc_report_form').submit();
	}

</script>

</head>
<body>

<#include "/template/global/include/form-message.ftl" />

<link rel="stylesheet" href="<@resource.url value='/styles/zapatec/styles/aqua.css'/>" type="text/css" media="all" />
<div id="document_report_query_block" name="document_report_query_block">
	<form action="documentReport.jspa" name="main_doc_report_form" id="main_doc_report_form">
		<div class="query_block">
			<@s.text name="analytics.dashboard.daterange.enter"/>:
			<label for="dateStart" style="padding-left:20px">
			<#assign stDate = '' />
			<#if Request.dateStart??>
			    <#assign stDate = Request.dateStart?string("dd/MM/yyyy") />
			</#if>
			<#--<@jiveform.datetimepicker id="dateStart" name="dateStart"  value=""/>-->
                <input id="dateStart" name="dateStart"  value="">
			<#assign edDate = '' />
			<#if Request.dateEnd??>
			    <#assign edDate =  Request.dateEnd?string("dd/MM/yyyy")  />
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
		    <input type="hidden" name="start" id="start" value="0" />
		    <input type="hidden" name="sortField" value="<#if sortField??>${sortField?c}<#else>0</#if>" />
		    <input type="hidden" name="sortOrder" value="<#if sortOrder??>${sortOrder?c}<#else>0</#if>" />
		    <input type="submit" value="Create Report">
		</div>
	</form>
</div>

<div id="document_report_wrapper" name="document_report_wrapper">
	<table border="1" width="100%">
		<tbody>
		<#if analyticsReportMap?? && analyticsReportMap?has_content>
			<tr>
				<th class="jive-table-head-title">
					<span id="sort_0">Title</span>
				</th>
				<th class="jive-table-head-title td_values" title="Users Read">
					<span id="sort_1" class="<#if  (Request.sortOrder == 0) && (Request.sortField == 1)>asc_sort<#else>desc_sort</#if><#if (Request.sortField == 1)> highlighted</#if>" onclick="sortByField(1);">
						Read
					</span>
				</th>
				<th class="jive-table-head-title td_values" title="Users commented">
					<span id="sort_2" class="<#if  (Request.sortOrder == 0) && (Request.sortField == 2)>asc_sort<#else>desc_sort</#if><#if (Request.sortField == 2)> highlighted</#if>" onclick="sortByField(2);">
						Comment
					</span>
				</th>
				<th class="jive-table-head-title td_values" title="Users bookmarked">
					<span id="sort_3" class="<#if  (Request.sortOrder == 0) && (Request.sortField == 3)>asc_sort<#else>desc_sort</#if><#if (Request.sortField == 3)> highlighted</#if>" onclick="sortByField(3);">
						Bookmark
					</span>
				</th>
				<th class="jive-table-head-title td_values last" title="Users rated">
					<span id="sort_4" class="<#if  (Request.sortOrder == 0) && (Request.sortField == 4)>asc_sort<#else>desc_sort</#if><#if (Request.sortField == 4)> highlighted</#if>" onclick="sortByField(4);">
						Average Rating
					</span>
				</th>
			</tr>
			<#list analyticsReportMap.keySet() as documentID>
				<tr>
					<#assign documentID = documentID?c />
					<#assign doc = jiveContext.documentManager.getDocument(documentID) />
					<#assign eventDetailsMap = analyticsReportMap.get(documentID)/>
					<#if (eventDetailsMap?has_content)>
					    <td>${doc.getSubject()?html}</td>
					    <td class="td_values"><#if eventDetailsMap.containsKey('READ_COUNT')>
						<#assign read_cnt = eventDetailsMap.get('READ_COUNT')?c />
							<a class="count_link" onclick="javascript:documentReportDrillDown('${documentID?c}', 'DOCUMENT_VIEWED', false);">
								${read_cnt}
							</a>
						<#else>0</#if>
					    </td>
					    <td class="td_values"><#if eventDetailsMap.containsKey('COMMENT_COUNT')>
							<#assign comment_cnt = eventDetailsMap.get('COMMENT_COUNT')?c />
							<a class="count_link" onclick="javascript:documentReportDrillDown('${documentID?c}', 'COMMENT_ADDED', false);">
								${comment_cnt}
							</a>
						<#else>0</#if></td>
					    <td class="td_values"><#if eventDetailsMap.containsKey('BOOKMARK_COUNT')>
							<#assign bookmark_cnt = eventDetailsMap.get('BOOKMARK_COUNT')?c />
							<a class="count_link" onclick="javascript:documentReportDrillDown('${documentID?c}', 'FAVORITE_added', false);">
								${bookmark_cnt}
							</a>
						<#else>0</#if></td>
					    <td class="td_values"><#if eventDetailsMap.containsKey('RATING_COUNT')>
							<#assign rating_cnt = eventDetailsMap.get('RATING_COUNT')?c />
							<a class="count_link" onclick="javascript:documentReportDrillDown('${documentID?c}', 'DOCUMENT_RATED', false);">
								${rating_cnt}
							</a>
						<#else>0</#if></td>
					<#else>
					    <td colspan="5" class="td_values">
						    No events for document - {documentID?string}
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
					<form action="downloadDocReport.jspa" method="post">
					    <input type="hidden" value="${stDate}" name="dateStart" />
					    <input type="hidden" value="${edDate}" name="dateEnd" />
					    <span>
						Export in Excel :
						    <select name="exportType" id="doc_top_exportType" onchange="checkSubmit(this);">
							<option value="-1" selected>--select--</option>
							<option value="0">Export this Report</option>
						    </select>
					    </span>
					</form>
				</td>
			</tr>
		</tbody>
		</table>
	        <@pageDisplay showNumResultsSelectBox=true dropDownRequired=true/>
	</#if>


</div>


<div id="document_doc_drilldown_report" name="document_doc_drilldown_report" style="display:none;">
    <div id="document_doc_drilldown_report_data" style="padding-top:10px;">
    </div>
    <form action="downloadDrillDocumentReport.jspa" method="post" name="doc_drill_form" id="doc_drill_form">
        <input type="hidden" value="0" name="start" />
        <input type="hidden" name="doc_id" id="doc_id"/>
	<input type="hidden" name="userID"/>
        <input type="hidden" name="activityType" />
        <input type="hidden" value="${stDate}" name="dateStart" />
        <input type="hidden" value="${edDate}" name="dateEnd" />
	<span>
		Export in Excel :
		<select name="exportType" id="exportType" onchange="checkSubmit(this);">
		    <option value="-1" selected>--select--</option>
		    <option value="0">Export this Report</option>
		</select>
	</span>
        <SCRIPT LANGUAGE="JavaScript">
            $('document_doc_drilldown_report').dateStart = $('dateStart');
            $('document_doc_drilldown_report').dateEnd = $('dateEnd');
            function checkSubmit(ele){
		var selectEle = ele;
		if(selectEle.value == 0){
			ele.form.submit();
			selectEle.selectedIndex = 0;
		}

	    }
        </SCRIPT>

	<div style="float:right; padding-top:10px;">
		<span style="display:none;">Number of Items :
			<select name="ajxNumResults" id="ajxNumResults" onchange="documentReportDrillDown($('doc_drill_form').doc_id.value, $('doc_drill_form').activityType.value, true);">
				<option value="10">10</option>
				<option value="20">20</option>
				<option value="30">30</option>
				<option value="40">40</option>
				<option value="50">50</option>
				<option value="100">100</option>
			</select>
		</span>
		<span style="display:none;">Goto page :

			<select name="ajxStartIndex" id="ajxStartIndex" onchange="documentReportDrillDown($('doc_drill_form').userID.value, $('doc_drill_form').activityType.value, false);">
				<option value="0">1</option>
				<option value="1">2</option>
				<option value="2">3</option>
				<option value="3">4</option>
			</select>
		</span>
	</div>
    </form>
</div>


<#macro pageDisplay showNumResultsSelectBox=false dropDownRequired=false>
    <table cellpadding="3" cellspacing="0" border="0" width="100%">
    <tr valign="top">
	<#if showNumResultsSelectBox>
        <td>
            <span>Number of items :
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
                        <select name="goto" id="goto" onchange="javascript:fetchDocumentReportPage(this.value, 0);">
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
                    <a href="javascript:fetchDocumentReportPage(${newPaginator.previousPageStart?c}, 0)">
			<@s.text name="global.previous" />
                    </a> |
                </#if>


                <#list 0..pages?size-1 as idx>
                    <#if (!pages[idx]?exists)>
                        <@s.text name="global.elipse" />
                    <#else>
                        <a href="javascript:fetchDocumentReportPage(${pages[idx].start?c}, 0)"
                           class="<#if (newPaginator.start?c == pages[idx].start?c)>jive-current</#if>">${pages[idx].number}</a>
                     </#if>
                </#list>

                <#if (newPaginator.nextPage)>
                    | <a href="javascript:fetchDocumentReportPage(${newPaginator.nextPageStart?c}, 0)">
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
    <select name='${eleName}' id='${eleName}' onchange="fetchDocumentReportPage(this.value, 1);">
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