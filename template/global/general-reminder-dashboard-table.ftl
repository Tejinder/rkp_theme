<#setting time_zone="${JiveGlobals.getJiveProperty('reminder.timeZone',JiveGlobals.getJiveProperty('locale.timeZone'))}">
<#if generalReminders?? && generalReminders?size &gt; 0>
<table id="standard-report-table" class="synchro-reminder-table project_status_table table-sorter">
    <thead>
    <tr>
        <th id="body-header" class="header"><span id="body">Body</span></th>
        <th id="date-header" class="header"><span id="date">Date</span></th>
        <th id="time-header" class="header"><span id="time">Time</span></th>
        <th>Dismiss</th>
    </tr>
    </thead>
    <tbody>
        <#list generalReminders as generalReminder>
        <input type="hidden" class="search_box"/>
        <tr <#if (generalReminder_index % 2) == 0> class="last"</#if>>
            <td><a href="javascript:void(0)" onclick="showSetReminderPopup(${generalReminder.id})" class="">${generalReminder.reminderBody}</a></td>
            <td><#if generalReminder.reminderDate??>${generalReminder.reminderDate?string("dd/MM/yyyy")}</#if></td>
            <td><#if generalReminder.reminderDate??>${generalReminder.reminderDate?string("hh:mm a")}</#if></td>
            <td><a href="javascript:void(0);" onclick="dismissGeneralReminder(${generalReminder.id})"><span class="dismiss-link"></span></a></td>
        <#--<td><a href="<@s.url value="synchro/reminder!input.jspa"/>?id=${generalReminder.id}&reminderType=2" class="">Edit</a></td>-->
        </tr>
        </#list>
    </tbody>
</table>
<script type="text/javascript">
    <#--$j(document).ready(function(){-->
        <#--var rIds = [];-->
        <#--<#list generalReminders as generalReminder>-->
            <#--rIds.push(${generalReminder.id});-->
        <#--</#list>-->
        <#--if(rIds.length > 0) {-->
            <#--var url = "<@s.url value='/synchro/general-reminder-alerts-pagination!updateReminderViews.jspa'/>";-->
            <#--$j.ajax({-->
                <#--url : url,-->
                <#--type: 'POST',-->
                <#--data: "reminderIds="+rIds.join(","),-->
                <#--success: function(result) {-->
                <#--}-->
            <#--});-->
        <#--}-->
    <#--});-->
</script>
<#else>
<div class="no-content">No results found</div>
</#if>
<#if pages?? && (pages > 1)>
<div id="pagination"></div>
</#if>
<script type="text/javascript">
    <#if pages?? && (pages>0)>
    var pages = ${pages};
    <#else>
    var pages = 1;
    </#if>
    function dismissGeneralReminder(id) {
        var xhr = $j.ajax({
            url : "<@s.url value="/synchro/general-reminder!dismiss.jspa"/>",
            type: 'POST',
            data: "id="+id,
            beforeSend: function() {
                $j("#overlay").show();
            },
            complete: function() {
                $j("#overlay").hide();
            },
            success: function(response) {
                xhr = null;
                var result = JSON.parse(response);
                if(result.data) {
                    var data = result.data;
                    if(data.success) {
                        dialog({title:"Confirmation",html:"General Reminder successfully dismissed."},function(){
                            processPaginationRequest(1);
                        });
                    } else {
                        dialog({title:"Confirmation",html:"Unable to dismiss General Reminder."});
                    }

                }

            }
        });
    }
</script>
<script src="${themePath}/js/pagination.custom.js" type="text/javascript"></script>




