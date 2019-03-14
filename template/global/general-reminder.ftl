<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<div id="general-reminder-container" class="general-reminder-container">
    <script type="text/javascript">

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
                success: function(result) {
                    xhr = null;
                    if(result.data) {
                        var data = result.data;
                        if(data.success) {
                            closeGeneralReminderPopup();
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
    <div id="#error-message" class="synchro-reminder-error-msg" style="display: none;"></div>
    <form  id="general-reminder-form" action="<@s.url value="/synchro/reminder!setGeneralReminder.jspa"/>" method="post">

        <h3 class="sub-header">General Reminder</h3>
        <input type="hidden" name="reminderType" value="${statics['com.grail.synchro.SynchroGlobal$SynchroReminderType'].GENERAL_REMINDER.getId()}">
    <#if generalReminder?? && generalReminder.id?? && generalReminder.id &gt; 0>
        <input type="hidden" name="id" value="${generalReminder.id}">
    </#if>
    <#--<#if generalReminder?? && generalReminder.remindTo?? && generalReminder.remindTo &gt; 0>-->
    <#--<input type="hidden" name="remindTo" value="${generalReminder.remindTo}">-->
    <#--</#if>-->

        <h4 class="sub-header-msg">(Please set other project related reminders only)</h4>
        <div class="field-group">
            <label class="body-label">Body</label>
            <textarea rows="15" cols="50" id="reminderBody" name="reminderBody"><#if generalReminder?? && generalReminder.reminderBody??>${generalReminder.reminderBody}</#if></textarea>
            <label id="reminder-body-error" class="field-error" style="display: none;">Please enter reminder body.</label>
        </div>
        <div class="field-group reminder-date">
            <div class="date-field">
                <label class="field-label">Date</label>
                <div>
                    <script type="text/javascript">
                        $j(document).ready(function(){
                        <#if generalReminder?? && generalReminder.reminderDate??>
                            $j("#reminderDate").val("${generalReminder.reminderDate?string("dd/MM/yyyy")}");
                        </#if>

                        });
                    </script>
                <@jiveform.datetimepicker id="reminderDate" name="reminderDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
                    <label id="reminder-date-error" class="field-error" style="display: none;">Please select reminder date.</label>
                </div>
            </div>
            <div class="time-field">
                <label class="field-label">Time</label>
                <div class="time-field-element">

                    <label>Hrs</label>
                    <select class="select-field" name="hours" id="select-hours"></select>
                    <script type="text/javascript">
                        $j(document).ready(function(){
                            for(var i = 1; i <= 12; i++) {
                                var lbl = i < 10 ? ("0"+i) : i;
                                var isSelected = false;
                            <#if generalReminder?? && generalReminder.reminderDate??>
                                var clbl = "${generalReminder.reminderDate?string('hh')}";
                                if(lbl == clbl) {
                                    isSelected = true;
                                }
                            </#if>

                                if(isSelected) {
                                    $j("#select-hours").append("<option value="+i+" selected='true'>"+lbl+"</option>");
                                } else {
                                    $j("#select-hours").append("<option value="+i+">"+lbl+"</option>");
                                }
                            }

                        })
                    </script>
                </div>
                <div class="time-field-element">
                    <label>Mins</label>
                    <select class="select-field" name="minutes" id="select-minutes"></select>
                    <script type="text/javascript">
                        $j(document).ready(function(){
                            for(var i = 0; i <= 55; i += 5) {
                                var lbl = i < 10 ? ("0"+i) : i;
                                var isSelected = false;
                            <#if generalReminder?? && generalReminder.reminderDate??>
                                var clbl = "${generalReminder.reminderDate?string('mm')}";
                                if(lbl == clbl) {
                                    isSelected = true;
                                }
                            </#if>
                                if(isSelected) {
                                    $j("#select-minutes").append("<option value="+i+" selected='true'>"+lbl+"</option>");
                                } else {
                                    $j("#select-minutes").append("<option value="+i+">"+lbl+"</option>");
                                }
                            }
                        })
                    </script>
                </div>
                <div class="time-field-element">
                    <script type="text/javascript">
                        $j(document).ready(function(){
                        <#if generalReminder?? && generalReminder.reminderDate??>
                            var clbl = "${generalReminder.reminderDate?string('a')?lower_case}";
                            console.log(clbl);
                            $j("#meridian-select").val(clbl);
                        </#if>
                        })
                    </script>
                    <select id="meridian-select" class="select-field" name="meridian">
                        <option value="am">AM</option>
                        <option value="pm">PM</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="action-buttons-container<#if !generalReminder?? || !generalReminder.id??> new-reminder</#if>">
            <script type="text/javascript">
                function setGeneralReminder() {
                    if(validateGeneralReminderForm()) {
                        var formData = $j("#general-reminder-form").serializeArray();;
                        var xhr = $j.ajax({
                            url : "<@s.url value="/synchro/general-reminder!setReminder.jspa"/>",
                            type: 'POST',
                            data: formData,
                            beforeSend: function() {
                                $j("#overlay").show();
                            },
                            complete: function() {
                                $j("#overlay").hide();
                            },
                            success: function(response) {
                                xhr = null;
                                var result = JSON.parse(response);
                                if(result && result.data) {
                                    var data = result.data;
                                    if(data.success) {
                                        closeGeneralReminderPopup();
                                        dialog({title:"Confirmation",html:"General Reminder successfully saved."},function(){
                                            processPaginationRequest(1);
                                        });

                                    }
                                } else {
                                    $j('#error-message').show();
                                    $j('#error-message').html('Unable to save General Reminder');
                                }
                            }
                        });

                    }
                }
                function validateGeneralReminderForm() {
                    $j("label.field-error").hide();
                    var reminderBody = $j("#reminderBody").val();
                    if(reminderBody == undefined || reminderBody == "") {
                        $j("#reminder-body-error").show();
                        return false;
                    } else {
                        $j("#reminder-body-error").hide();
                    }
                    var reminderDate = $j("#reminderDate").val();
                    if(reminderDate == undefined || reminderDate == "") {
                        $j("#reminder-date-error").show();
                        return false;
                    } else {
                        $j("#reminder-date-error").hide();
                    }
                    return true;
                }
            </script>
            <input type="button" class="set-reminder" value="Set Reminder" onclick="setGeneralReminder()">
        <#if generalReminder?? && generalReminder.id??>
            <input type="button" class="dismiss-reminder" value="Dismiss" onclick="dismissGeneralReminder(${generalReminder.id})">
        </#if>
        </div>
    </form>
</div>