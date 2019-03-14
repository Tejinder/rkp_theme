<div id="user_doc_drilldown_report" name="user_doc_drilldown_report">
   <#if drillDownMapReport?? && drillDownMapReport?size &gt; 0>
	<#assign drillDownMap = drillDownMapReport />

	<#assign reportType = drillDownMap.get('type')?string />
	<#assign activityType = drillDownMap.get('activity')?string />
	<#assign user_id = drillDownMap.get('obj_id')?c />
	<#assign act_type = drillDownMap.get('act_type')?string />

	<input type="hidden" id="user_id" value="${user_id}">
	<input type="hidden" id="act_type" value="${act_type?string}">

	<div class='drilled_report_data'>
		<table>
			<tbody>
				<tr>
					<#if reportType == 'USER'>
						<td>Name : </td>
					<#elseif reportType == 'DOCUMENT'>
						<td>Document : </td>
					</#if>
					<td id='td_user_id'>${drillDownMap.get('title')?html}</td>
				</tr>
				<tr>
					<td>Activity :</td>
					<td id='td_act_type'>${activityType?html}</td>
				</tr>
			</tbody>
                </table>
		<#assign eventDetailsList = drillDownMap.get('dataList')/>
		<table border="1" width="100%">
			<tbody>
				<tr>
					<th class="jive-table-head-title">
						<#if reportType == 'USER'>
							Documents
						<#elseif reportType == 'DOCUMENT'>
							Users
						</#if>
					</th>
					<th class="jive-table-head-title td_values">
						Count
					</th>
					<#if activityType == 'Rating'>
						<th class="jive-table-head-title td_values">
							Score
						</th>
					<#elseif activityType == 'Bookmark'>
						<th class="jive-table-head-title td_values">
							Type
						</th>
					</#if>
				</tr>
				<#list eventDetailsList as detailMap>
					<tr>
						<#if detailMap?has_content>
							<td>${detailMap.get('target_obj_title')?html}</td>
							<td>${detailMap.get('target_obj_event_cnt')?html}</td>
							<#if activityType == 'Rating'>
								<td class="jive-table-head-title td_values">
									${detailMap.get('rating_score')?html}
								</td>
							<#elseif activityType == 'Bookmark'>
								<td class="jive-table-head-title td_values">
									${detailMap.get('bookmark_type')?html}
								</td>
							</#if>
						</#if>
					</tr>
				</#list>
				<tr>
					<td style='font-weight:bold;'>Total </td>
					<td style='font-weight:bold;'>
						${drillDownMap.get('total_act_count')?string}
					</td>
				</tr>

			</tbody>
		</table>
	 </div>
	 <@ajxPageDisplay />
   </#if>
</div>

<#macro ajxPageDisplay showNumResultsSelectBox=true dropDownRequired=true>
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
                        <#assign pages = newPaginator.getPages()>
                        <select name="goto" id="goto" onchange="javascript:fetchUserDrillDownPage(this.value, false);">
                            <#list 0..pages?size-1 as idx>
                                <#if (pages[idx]?exists)>
                                    <option <#if (start/numResults)?c=idx?c>selected</#if> value="${pages[idx].start}">${pages[idx].number}</option>
                                </#if>    
                            </#list>
                        </select>
                    </span>
                </#if>
                <span class="jive-paginator">
                [
                <#if (newPaginator.previousPage)>
                    <a href="javascript:fetchUserDrillDownPage('${newPaginator.previousPageStart?c}', false);">
			            <@s.text name="global.previous" />
                    </a> |
                </#if>


                <#list 0..pages?size-1 as idx>
                    <#if (!pages[idx]?exists)>
                        <@s.text name="global.elipse" />
                    <#else>
                        <a href="javascript:fetchUserDrillDownPage('${pages[idx].start?c}', false);"
                           class="<#if (newPaginator.start?c == pages[idx].start?c)>jive-current</#if>">${pages[idx].number}</a>
                     </#if>
                </#list>

                <#if (newPaginator.nextPage)>
                    | <a href="javascript:fetchUserDrillDownPage('${newPaginator.nextPageStart?c}', false);">
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

<#macro numResultsSelect eleName='ajxNumResults' startIndex=10?c>
	<select name='${eleName}' id='${eleName}' onchange="javascript:fetchUserDrillDownPage(this.value, true);">
		<option value="10" <#if numResults?c=10?c>selected</#if>>10</option>
		<option value="20" <#if numResults?c=20?c>selected</#if>>20</option>
		<option value="30" <#if numResults?c=30?c>selected</#if>>30</option>
		<option value="40" <#if numResults?c=40?c>selected</#if>>40</option>
		<option value="50" <#if numResults?c=50?c>selected</#if>>50</option>
		<option value="100" <#if numResults?c=100?c>selected</#if>>100</option>
	</select>
</#macro>