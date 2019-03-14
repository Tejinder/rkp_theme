<#setting time_zone="${JiveGlobals.getJiveProperty('reminder.timeZone',JiveGlobals.getJiveProperty('locale.timeZone'))}">
<#if projectReminders?? && projectReminders?size &gt; 0>
<table id="standard-report-table" class="synchro-reminder-table project_status_table table-sorter">
    <thead>
    <tr>
        <th id="category-type-header" class="header category-type-header"><span id="categoryType">Category Type(s)</span></th>
        <th id="frequencyType-header" class="header frequencyType-header"><span id="frequencyType">Frequency Type</span></th>
        <th id="recipient-header" class="header recipient-header"><span id="recipient">Recipient</span></th>
        <th id="reminder-start-header" class="header"><span id="author">Reminder Start</span></th>
        <th id="last-reminder-sent-header" class="header"><span id="lastReminderSent">Last Reminder Sent</span></th>
        <th class="header">View<br/>Activities</th>
        <th class="header">Dismiss</th>
    <#--<th></th>-->
    </tr>
    </thead>
    <tbody>
        <#list projectReminders as projectReminder>
        <tr <#if (projectReminder_index % 2) == 0> class="last"</#if>>
            <#assign categoryTypeStr = ""/>
            <#if projectReminder.categoryTypes??>
                <#list projectReminder.categoryTypes as categoryType>
                    <#if categoryTypeStr != "">
                        <#assign  categoryTypeStr = categoryTypeStr + ", ">
                    </#if>
                    <#assign cName = statics['com.grail.synchro.SynchroGlobal$ProjectReminderCategoryType'].getById(categoryType?int).toString()/>
                    <#assign  categoryTypeStr = categoryTypeStr + cName/>
                </#list>
            </#if>
            <td><a href="javascript:void(0)" onclick="showSetReminderPopup(${projectReminder.id})" class="">${categoryTypeStr}</a></td>
            <#assign freqTypeStr = ""/>
            <#if projectReminder.frequencyType??>
                <#assign freqTypeStr = statics['com.grail.synchro.SynchroGlobal$ProjectReminderFrequencyType'].getById(projectReminder.frequencyType?int).toString()/>
            </#if>
            <td>${freqTypeStr}</td>
            <td>
                <#if projectReminder.projectReminderType?? && projectReminder.projectReminderType = 2>
                    <#assign users = ""/>
                    <#if projectReminder.remindTo?? && projectReminder.remindTo?size &gt; 0>
                      <#list projectReminder.remindTo as userId>
                      <#if users != "">
                          <#assign users = users + ", "/>
                      </#if>
                      <#assign users = users + jiveContext.getSpringBean("userManager").getUser(userId).getName()/>
                      </#list>
                    </#if>
                    ${users}
                <#else>Self
                </#if>
            </td>
            <td><#if projectReminder.rangeStartDate??>${projectReminder.rangeStartDate?string('dd/MM/yyyy')}</#if></td>
            <td><#if projectReminder.lastReminderSentOn??>${projectReminder.lastReminderSentOn?string('dd/MM/yyyy hh:mm a')}</#if></td>
            <td><a href="<@s.url value="/synchro/project-reminder-view-result!input.jspa"/>?id=${projectReminder.id}"><span class="view-link"></span></a></td>
            <td><a href="javascript:void(0);" onclick="dismissProjectReminder(${projectReminder.id})"><span class="dismiss-link"></span></a></td>
        <#--<td><a href="<@s.url value="synchro/reminder!input.jspa"/>?id=${projectReminder.id}&reminderType=1" class="">Edit</a></td>-->

        </tr>

        </#list>
    </tbody>
</table>
<script type="text/javascript">
    <#--$j(document).ready(function(){-->
        <#--var rIds = [];-->
        <#--<#list projectReminders as projectReminder>-->
            <#--rIds.push(${projectReminder.id});-->
        <#--</#list>-->
        <#--if(rIds.length > 0) {-->
            <#--var url = "<@s.url value='/synchro/project-reminder-alerts-pagination!updateReminderViews.jspa'/>";-->
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
    function dismissProjectReminder(id) {
        var xhr = $j.ajax({
            url : "<@s.url value="/synchro/project-reminder!dismiss.jspa"/>",
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
                        dialog({title:"Confirmation",html:"Project Reminder successfully dismissed."},function(){
                            processPaginationRequest(1);
                        });
                    } else {
                        dialog({title:"Confirmation",html:"Unable to dismiss Project Reminder."});
                    }

                }

            }
        });
    }
</script>
<script src="${themePath}/js/pagination.custom.js" type="text/javascript"></script>

