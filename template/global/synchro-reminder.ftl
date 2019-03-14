<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#assign months = statics['com.grail.synchro.SynchroGlobal$ProjectReminderMonth'].values()/>
<#assign weekdays = statics['com.grail.synchro.SynchroGlobal$ProjectReminderWeekday'].values()/>
<div class="border-container">
<div class="synchro-reminder-container">
<h3 class="main-header"><#if request.getParameter("reminderType")??>Edit<#else>Set</#if> Reminder</h3>
<script type="text/javascript">
    $j(document).ready(function() {
        var reminderType = 1;
    <#if request.getParameter("reminderType")??>
        reminderType = Number(${request.getParameter("reminderType")});
    </#if>
        if(reminderType == undefined || isNaN(reminderType) || reminderType == 0) {
            reminderType = 1;
        }
        showReminderContainer(reminderType);
        if(reminderType == 1) {
            $j("#projectReminderRadio").attr("checked",true);
        } else if(reminderType == 2) {
            $j("#generalReminderRadio").attr("checked",true);
        }

    });
    function showReminderContainer(selectedReminderType) {
        var projectReminderType = Number(${statics['com.grail.synchro.SynchroGlobal$SynchroReminderType'].PROJECT_REMINDER.getId()});
        var generalReminderType = Number(${statics['com.grail.synchro.SynchroGlobal$SynchroReminderType'].GENERAL_REMINDER.getId()});
        if(selectedReminderType == projectReminderType) {
            $j("#project-reminder-container").show();
            $j("#general-reminder-container").hide();
        } else if(selectedReminderType == generalReminderType) {
            $j("#project-reminder-container").hide();
            $j("#general-reminder-container").show();
        }
    }
    function dismissProjectReminder() {
        <#if projectReminder?? && projectReminder.id??>
            window.location = "<@s.url value="/synchro/reminder!dismissProjectReminder.jspa"/>?id="+${projectReminder.id};
        <#else>
            window.location = "<@s.url value="/portal-options.jspa"/>";
        </#if>

    }
    function dismissGeneralReminder() {
    <#if generalReminder?? && generalReminder.id??>
        window.location = "<@s.url value="/synchro/reminder!dismissGeneralReminder.jspa"/>?id="+${generalReminder.id};
    <#else>
        window.location = "<@s.url value="/portal-options.jspa"/>";
    </#if>
    }
</script>
<#if !request.getParameter("reminderType")??>
<div  class="reminder-type-radio-container">


    <div class="reminder-type-radio-group first">
        <input type="radio" id="projectReminderRadio"
               name="reminderType" value="${statics['com.grail.synchro.SynchroGlobal$SynchroReminderType'].PROJECT_REMINDER.getId()}" checked="true"
               onclick="javascript:showReminderContainer($j(this).val())">
        <label for="projectReminderRadio">${statics['com.grail.synchro.SynchroGlobal$SynchroReminderType'].PROJECT_REMINDER.getName()}</label>
    </div>
    <div class="reminder-type-radio-group second">
        <input type="radio" id="generalReminderRadio"
               name="reminderType" value="${statics['com.grail.synchro.SynchroGlobal$SynchroReminderType'].GENERAL_REMINDER.getId()}"
               onclick="javascript:showReminderContainer($j(this).val())">
        <label for="generalReminderRadio">${statics['com.grail.synchro.SynchroGlobal$SynchroReminderType'].GENERAL_REMINDER.getName()}</label>
    </div>
</div>
</#if>
<div id="project-reminder-container" class="project-reminder-container" style="display: none;">
<form id="project-reminder-form" action="<@s.url value="/synchro/reminder!setProjectReminder.jspa"/>" method="post">
<h3 class="sub-header">Project Reminder</h3>
<input type="hidden" name="reminderType" value="${statics['com.grail.synchro.SynchroGlobal$SynchroReminderType'].PROJECT_REMINDER.getId()}">
<#if request.getParameter("id")?? && request.getParameter("reminderType")?? && request.getParameter("reminderType")?string = statics['com.grail.synchro.SynchroGlobal$SynchroReminderType'].PROJECT_REMINDER.getId()?string>
<input type="hidden" name="id" value="${request.getParameter("id")}">
</#if>
<div class="project-reminder-type-container field-group">
    <div class="project-reminder-type-radio-container">
        <div class="radio-group first">
            <input type="radio" id="selfProjectReminderType"
                   name="projectReminderType" value="1"
                   <#if projectReminder?? && projectReminder.projectReminderType?? && projectReminder.projectReminderType?int = 1>checked="true"<#else>checked="true"</#if>
                   onclick="showToOthersContainer(1)">
            <label for="selfProjectReminderType">Self</label>
        </div>
        <div class="radio-group second">
            <input type="radio" id="toOthersProjectReminderType"
                   name="projectReminderType" value="2"
                   <#if projectReminder?? && projectReminder.projectReminderType?? && projectReminder.projectReminderType?int = 2>checked="true"</#if>
                   onclick="showToOthersContainer(2)">
            <label for="toOthersProjectReminderType">To Others</label>
        </div>

    </div>
    <div id="project-reminder-type-input-container" class="project-reminder-type-input-container" style="display: none;">
        <input type="text" tabindex="1" name="remindTo" id="remindTo" class="j-user-autocomplete-1 j-ui-elem remind-to"  autocomplete="off" />
        <script type="text/javascript">
            var users = [];

            <#if projectReminder?? && projectReminder.projectReminderType?? && projectReminder.projectReminderType?int = 2 && projectReminder.remindTo??>
                <#list projectReminder.remindTo as rt>
                users.push(${rt?c});
                </#list>
            </#if>
            initializeUserPicker({$input:$j("#remindTo"),name:'remindTo', multiple:true, value:users});
        </script>
    </div>
    <script type="text/javascript">
        $j(document).ready(function() {
            var pReminderType = 1;
            <#if projectReminder?? && projectReminder.projectReminderType??>
                pReminderType = Number(${projectReminder.projectReminderType});
            </#if>
            showToOthersContainer(pReminderType);
            onCategoryTypeSelect();
        });

        function showToOthersContainer(selectedProjReminderType) {
            if(selectedProjReminderType == 2) {
                $j("#project-reminder-type-input-container").show();
            } else {
                $j("#project-reminder-type-input-container").hide();
            }
        }

        function onCategoryTypeSelect() {
            if($j("#categoryType_1").is(":checked")) {
                $j("#draft-category-type-exception").show();
            } else {
                $j("#draft-category-type-exception").hide();
            }
        }
    </script>
    <label id="remind-type-error" class="field-error" style="display: none;">Please select user(s) to remind.</label>
</div>
<div class="project-reminder-category-container field-group">
    <label class="field-label category">Category</label>
    <div class="category-type-main-container">
    <#assign categoryTypes = statics['com.grail.synchro.SynchroGlobal$ProjectReminderCategoryType'].values()/>
    <#list categoryTypes as categoryType>
        <div class="category-type-container">
            <input type="checkbox" name="categoryTypes" id="categoryType_${categoryType.getId()}" value="${categoryType.getId()}"
                   onclick="onCategoryTypeSelect()"
                   <#if projectReminder?? && projectReminder.categoryTypes?? && projectReminder.categoryTypes?seq_contains(categoryType.getId())>checked="true"</#if>>
            <label for="categoryType_${categoryType.getId()}">${categoryType.getName()}</label>
        </div>
    </#list>
        <label id="category-type-error" class="field-error" style="display: none;">Please select category type(s).</label>
    </div>
    <div id="draft-category-type-exception" class="draft-category-type-exception" style="display: none">
        <label>Remind me</label>
        <input type="text" id="draftProjectRemindBefore" name="draftProjectRemindBefore"
               class="small-input-box" <#if projectReminder?? && projectReminder.draftProjectRemindBefore?? && projectReminder.draftProjectRemindBefore &gt; 0>value="${projectReminder.draftProjectRemindBefore}"</#if>/>
        <label>day(s) before the Project Start Date</label>
    </div>
</div>

<div class="project-reminder-frequency-container field-group">
<label class="field-label">Frequency</label>
<div class="frequency-type-main-container">
<script type="text/javascript">
    $j(document).ready(function(){
        var freqType = 1;
    <#if projectReminder?? && projectReminder.frequencyType??>
        freqType = Number(${projectReminder.frequencyType});
    </#if>

        onFrequencyTypeChange(freqType);
    })
    function onFrequencyTypeChange(ftype) {
        $j("#daily-frequency-container").hide();
        $j("#weekly-frequency-container").hide();
        $j("#monthly-frequency-container").hide();
        $j("#yearly-frequency-container").hide();

        if(ftype == 1) {
            $j(".daily-frequency-container").show();
        } else if(ftype == 2) {
            $j("#weekly-frequency-container").show();
        } else if(ftype == 3) {
            $j("#monthly-frequency-container").show();
        } else if(ftype == 4) {
            $j("#yearly-frequency-container").show();
        }
    }
</script>
<label class="field-sub-label">Recurrence pattern</label>
<div class="frequency-type-left">

<#assign frequencyTypes = statics['com.grail.synchro.SynchroGlobal$ProjectReminderFrequencyType'].values()/>
<#list frequencyTypes as frequencyType>
    <div class="frequency-type-container">
        <input type="radio" name="frequencyType" id="frequencyType_${frequencyType.getId()}"
               value="${frequencyType.getId()}" <#if projectReminder?? && projectReminder.frequencyType?? && projectReminder.frequencyType?int = frequencyType.getId()>checked="true"<#elseif frequencyType.getId() == 1>checked="true"</#if> onclick="onFrequencyTypeChange(${frequencyType.getId()})">
        <label for="frequencyType_${frequencyType.getId()}">${frequencyType.getName()}</label>
    </div>

</#list>
    <label id="frequency-type-error" class="field-error" style="display: none;">Please select recurrence pattern.</label>
</div>
<div class="frequency-type-right">
    <div id="daily-frequency-container" class="daily-frequency-container" style="display: none;">

        <div class="sub-field-group">
            <div>
                <input type="radio" name="dailyFrequencyType" value="1"
                       <#if projectReminder?? && projectReminder.dailyFrequencyType?? && projectReminder.dailyFrequencyType?int = 1>checked="true"<#else>checked="true"</#if>>
                <label>Every</label>
                <input type="text" id="dailyFrequency" name="dailyFrequency" class="small-input-box"
                       <#if projectReminder?? && projectReminder.dailyFrequency?? && projectReminder.dailyFrequency &gt; 0>value="${projectReminder.dailyFrequency}"</#if>/>
                <label>days(s)</label>
            </div>
            <label id="daily-frequency-type-error" class="field-error" style="display: none;">Please enter days for daily recurrence.</label>
        </div>
        <div class="sub-field-group">
            <input type="radio" name="dailyFrequencyType" value="2"
                   <#if projectReminder?? && projectReminder.dailyFrequencyType?? && projectReminder.dailyFrequencyType?int = 2>checked="true"</#if>>
            <label>Every weekday</label>
        </div>
    </div>
    <div id="weekly-frequency-container" class="weekly-frequency-container" style="display: none;">
        <div class="sub-field-group">
            <div>
                <label>Recur every</label>
                <input type="text" id="weeklyFrequency" name="weeklyFrequency" class="small-input-box"
                       <#if projectReminder?? && projectReminder.weeklyFrequency?? && projectReminder.weeklyFrequency &gt; 0>value="${projectReminder.weeklyFrequency}"</#if>/>
                <label>week(s) on</label>
            </div>
            <label id="weekly-frequency-type-error" class="field-error" style="display: none;">Please enter weeks for weekly recurrence.</label>
        </div>
        <div class="sub-field-group weekdays">

        <#list weekdays as weekday>
            <div class="weekday-container">
                <input type="checkbox" name="weekdayTypes" id="weekdayType_${weekday.getId()}" value="${weekday.getId()}"
                       <#if projectReminder?? && projectReminder.weekdayTypes?? && projectReminder.weekdayTypes?seq_contains(weekday.getId())>checked="true"</#if>>
                <label for="weekdayType_${weekday.getId()}">${weekday.getName()}</label>
            </div>
        </#list>
            <label id="weekly-types-error" class="field-error" style="display: none;">Please select week days for weekly recurrence.</label>

        </div>
    </div>
    <div id="monthly-frequency-container" class="monthly-frequency-container" style="display: none;">
        <script type="text/javascript">
            function updateMonthlyFreqeuncy() {
                if($j("#monthlyFrequencyType1").is(":checked")) {
                    $j("#monthlyFrequency").val($j("#monthlyFrequency1").val())
                } else if($j("#monthlyFrequencyType2").is(":checked")) {
                    $j("#monthlyFrequency").val($j("#monthlyFrequency2").val())
                }
            }
        </script>
        <input type="hidden" id="monthlyFrequency" name="monthlyFrequency"/>
        <div class="sub-field-group">
            <input type="radio" id="monthlyFrequencyType1" name="monthlyFrequencyType" value="1"
                   <#if projectReminder?? && projectReminder.monthlyFrequencyType?? && projectReminder.monthlyFrequencyType?int = 1>checked="true"<#else>checked="true"</#if>
                   onchange="updateMonthlyFreqeuncy()">
            <label>Day</label>
            <input type="text" id="monthlyDayOfMonth" name="monthlyDayOfMonth" class="small-input-box"
                   <#if projectReminder?? && projectReminder.monthlyDayOfMonth?? && projectReminder.monthlyDayOfMonth &gt; 0>value="${projectReminder.monthlyDayOfMonth}"</#if>/>
            <label>of every</label>
            <input type="text" id="monthlyFrequency1" name="monthlyFrequency1" class="small-input-box" onkeyup="updateMonthlyFreqeuncy()"
                   <#if projectReminder?? && projectReminder.monthlyFrequencyType?? && projectReminder.monthlyFrequencyType?int = 1 && projectReminder.monthlyFrequency?? && projectReminder.monthlyFrequency &gt; 0>value="${projectReminder.monthlyFrequency}"</#if>/>
            <label>months(s)</label>
            <label id="monthly-day-of-month-error" class="field-error" style="display: none;">Please enter day of month.</label>
            <label id="monthly-frequency-type1-error" class="field-error" style="display: none;">Please enter months for monthly recurrence.</label>
        </div>
        <div class="sub-field-group">
            <input type="radio" id="monthlyFrequencyType2" name="monthlyFrequencyType" value="2"
                   <#if projectReminder?? && projectReminder.monthlyFrequencyType?? && projectReminder.monthlyFrequencyType?int = 2>checked="true"</#if>
                   onchange="updateMonthlyFreqeuncy()">
            <label>The</label>
            <select id="monthlyWeekOfMonth" name="monthlyWeekOfMonth" class="select-field">
            <#--<option value="-1">-- Select --</option>-->
                <option value="1" <#if projectReminder?? && projectReminder.monthlyWeekOfMonth?? && projectReminder.monthlyWeekOfMonth?int=1>selected="true"</#if>>First</option>
                <option value="2" <#if projectReminder?? && projectReminder.monthlyWeekOfMonth?? && projectReminder.monthlyWeekOfMonth?int=2>selected="true"</#if>>Second</option>
                <option value="3" <#if projectReminder?? && projectReminder.monthlyWeekOfMonth?? && projectReminder.monthlyWeekOfMonth?int=3>selected="true"</#if>>Third</option>
                <option value="4" <#if projectReminder?? && projectReminder.monthlyWeekOfMonth?? && projectReminder.monthlyWeekOfMonth?int=4>selected="true"</#if>>Fourth</option>
            </select>

            <select id="monthlyDayOfWeek" name="monthlyDayOfWeek" class="select-field">
            <#list weekdays as weekday>
                <option value="${weekday.getId()}"
                        <#if projectReminder?? && projectReminder.monthlyWeekOfMonth?? && projectReminder.monthlyDayOfWeek?int=weekday.getId()>selected="true"</#if>>${weekday.getName()}</option>
            </#list>
            </select>
            <label>of every</label>
            <input type="text" id="monthlyFrequency2" name="monthlyFrequency2" class="small-input-box"
                   <#if projectReminder?? && projectReminder.monthlyFrequencyType?? && projectReminder.monthlyFrequencyType?int = 2 && projectReminder.monthlyFrequency?? && projectReminder.monthlyFrequency &gt; 0>value="${projectReminder.monthlyFrequency}"</#if>
                   onkeyup="updateMonthlyFreqeuncy()"/>
            <label>months(s)</label>
            <label id="monthly-week-of-month-error" class="field-error" style="display: none;">Please select week of month.</label>
            <label id="monthly-day-of-week-error" class="field-error" style="display: none;">Please select day of week.</label>
            <label id="monthly-frequency-type2-error" class="field-error" style="display: none;">Please enter months for monthly recurrence.</label>
        </div>
        <label id="monthly-frequency-type-error" class="field-error" style="display: none;">Please select monthly recurrence type.</label>

    </div>
    <div id="yearly-frequency-container" class="yearly-frequency-container" style="display: none;">
        <div class="sub-field-group">
            <label>Recur every</label>
            <input type="text" id="yearlyFrequency" name="yearlyFrequency" class="small-input-box"
                   <#if projectReminder?? &&projectReminder.yearlyFrequency?? && projectReminder.yearlyFrequency &gt; 0>value="${projectReminder.yearlyFrequency}"</#if>/>
            <label>years(s) on</label>
            <label id="yearly-frequency-error" class="field-error" style="display: none;">Please enter years for yearly recurrence.</label>
        </div>
        <div class="sub-field-group years">
            <script type="text/javascript">
                $j(document).ready(function(){
                    updateYearlyMonthOfYear();
                });
                function updateYearlyMonthOfYear() {
                    if($j("#yearlyFrequencyType1").is(":checked")) {
                        $j("#yearlyMonthOfYear").val($j("#yearlyMonthOfYear1").val())
                    } else if($j("#yearlyFrequencyType2").is(":checked")) {
                        $j("#yearlyMonthOfYear").val($j("#yearlyMonthOfYear2").val())
                    }
                }
            </script>
            <input type="hidden" id="yearlyMonthOfYear" name="yearlyMonthOfYear">
            <div class="year-frequency-type-container">
                <div>
                    <input type="radio" id="yearlyFrequencyType1" name="yearlyFrequencyType" value="1" onclick="updateYearlyMonthOfYear()"
                           <#if projectReminder?? && projectReminder.yearlyFrequencyType?? && projectReminder.yearlyFrequencyType?int = 1>checked="true"<#else> checked="true"</#if>>
                    <label>On</label>
                    <select id="yearlyMonthOfYear1" name="yearlyMonthOfYear1" class="select-field" onchange="updateYearlyMonthOfYear()">
                    <#assign months = statics['com.grail.synchro.SynchroGlobal$ProjectReminderMonth'].values()/>
                    <#list months as month>
                        <option value="${month.getId()}"
                                <#if projectReminder?? && projectReminder.yearlyFrequencyType?? && projectReminder.yearlyFrequencyType?int = 1 && projectReminder.yearlyMonthOfYear?? && projectReminder.yearlyMonthOfYear?int = month.getId()>selected="true"</#if>>
                        ${month.getName()}
                        </option>
                    </#list>
                    </select>
                    <input type="text" id="yearlyDayOfMonth" name="yearlyDayOfMonth" class="small-input-box"
                           <#if projectReminder?? && projectReminder.yearlyDayOfMonth?? && projectReminder.yearlyDayOfMonth &gt; 0>value="${projectReminder.yearlyDayOfMonth}"</#if>/>
                </div>
                <label id="yearly-year-of-month1-error" class="field-error" style="display: none;">Please select month of year.</label>
                <label id="yearly-day-of-month-error" class="field-error" style="display: none;">Please enter day of month.</label>
            </div>
            <div class="year-frequency-type-container">
                <input type="radio" id="yearlyFrequencyType2" name="yearlyFrequencyType" value="2" onclick="updateYearlyMonthOfYear()"
                       <#if projectReminder?? && projectReminder.yearlyFrequencyType?? && projectReminder.yearlyFrequencyType?int = 2>checked="true"</#if>>
                <label>On the</label>
                <select id="yearlyWeekOfMonth" name="yearlyWeekOfMonth" class="select-field">
                <#--<option value="-1">-- Select --</option>-->
                    <option value="1" <#if projectReminder?? && projectReminder.yearlyWeekOfMonth?? && projectReminder.yearlyWeekOfMonth?int = 1>selected="true"</#if>>First</option>
                    <option value="2" <#if projectReminder?? && projectReminder.yearlyWeekOfMonth?? && projectReminder.yearlyWeekOfMonth?int = 2>selected="true"</#if>>Second</option>
                    <option value="3" <#if projectReminder?? && projectReminder.yearlyWeekOfMonth?? && projectReminder.yearlyWeekOfMonth?int = 3>selected="true"</#if>>Third</option>
                    <option value="4" <#if projectReminder?? && projectReminder.yearlyWeekOfMonth?? && projectReminder.yearlyWeekOfMonth?int = 4>selected="true"</#if>>Fourth</option>
                </select>
                <select id="yearlyDayOfWeek" name="yearlyDayOfWeek" class="select-field">
                <#list weekdays as weekday>
                    <option value="${weekday.getId()}"
                            <#if projectReminder?? && projectReminder.yearlyFrequencyType?? && projectReminder.yearlyFrequencyType?int = 2 && projectReminder.yearlyDayOfWeek?? && projectReminder.yearlyDayOfWeek?int = weekday.getId()>selected="true"</#if>>
                    ${weekday.getName()}
                    </option>
                </#list>
                </select>
                <label>of</label>
                <select id="yearlyMonthOfYear2" name="yearlyMonthOfYear2" class="select-field" onchange="updateYearlyMonthOfYear()">
                <#list months as month>
                    <option value="${month.getId()}"
                            <#if projectReminder?? && projectReminder.yearlyFrequencyType?? && projectReminder.yearlyFrequencyType?int = 2 && projectReminder.yearlyMonthOfYear?? && projectReminder.yearlyMonthOfYear?int = month.getId()>selected="true"</#if>>
                    ${month.getName()}
                    </option>
                </#list>
                </select>
                <label id="yearly-week-of-month-error" class="field-error" style="display: none;">Please select week of month.</label>
                <label id="yearly-day-of-week-error" class="field-error" style="display: none;">Please select day of week.</label>
                <label id="yearly-year-of-month2-error" class="field-error" style="display: none;">Please select month of year.</label>
            </div>
        </div>
        <label id="yearly-frequency-type-error" class="field-error" style="display: none;">Please select yearly recurrence type.</label>
    </div>
</div>
</div>
</div>
<div class="project-reminder-range-container field-group">
    <label class="field-label">Range of recurrence</label>
    <script type="text/javascript">
        $j(document).ready(function(){
            $j("#rangeStartDate").click(function() {
                $j("#rangeStartDate_button").click();
            });
            $j("#rangeEndDate").click(function() {
                $j("#rangeEndDate_button").click();
            });
            onProjectReminderRangeEndChange(1);
        });

        function onProjectReminderRangeEndChange(selVal) {
            $j("#rangeEndAfter").attr("disabled", "true");
            $j("#rangeEndDate").attr("disabled", "true");
            $j("#rangeEndDateInput").show();
            $j("#rangeEndDate").hide();
            $j("#rangeEndDate_button").hide();
            if(selVal == 2) {
                $j("#rangeEndAfter").removeAttr("disabled");
            } else if(selVal == 3) {
                $j("#rangeEndDate").removeAttr("disabled");
                $j("#rangeEndDateInput").hide();
                $j("#rangeEndDate").show();
                $j("#rangeEndDate_button").show();
            }

        }
    </script>
    <div class="reminder-range-main-container">
        <div class="range-start-container">
            <label for="rangeStartDate" class="date-label">Start</label>
            <script type="text/javascript">
                $j(document).ready(function(){
                <#if projectReminder?? && projectReminder.rangeStartDate??>
                    $j("#rangeStartDate").val("${projectReminder.rangeStartDate?string("dd/MM/yyyy")}")
                <#else>
                    $j("#rangeStartDate").val("${currentDate?string("dd/MM/yyyy")}")
                </#if>

                })
            </script>
        <@jiveform.datetimepicker id="rangeStartDate" name="rangeStartDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
            <label id="range-start-error" class="field-error" style="display: none;">Please select recurrence start date.</label>
        </div>
        <div class="range-end-container">
            <div class="range-end-field">
                <input type="radio" id="rangeNoEndDate" name="rangeEndType" value="1"
                       <#if projectReminder?? && projectReminder.rangeEndType?? && projectReminder.rangeEndType?int = 1>checked="true"<#else>checked="true"</#if>
                       onclick="onProjectReminderRangeEndChange(1)">
                <label for="rangeNoEndDate">No end date</label>
            </div>
            <div class="range-end-field">
                <div>
                    <script type="text/javascript">
                        $j(document).ready(function(){
                        <#if projectReminder?? && projectReminder.rangeEndAfter??>
                            $j("#rangeEndAfterRB").click();
                        </#if>

                        })
                    </script>
                    <input type="radio" id="rangeEndAfterRB" name="rangeEndType" value="2"
                           <#if projectReminder?? && projectReminder.rangeEndType?? && projectReminder.rangeEndType?int = 2>checked="true"</#if>
                           onclick="onProjectReminderRangeEndChange(2)">
                    <label for="rangeEndAfterRB">End after</label>
                    <input type="text" id="rangeEndAfter" name="rangeEndAfter" class="small-input-box"
                           <#if projectReminder?? && projectReminder.rangeEndType?? && projectReminder.rangeEndType?int = 2 && projectReminder.rangeEndAfter?? && projectReminder.rangeEndAfter &gt; 0>value="${projectReminder.rangeEndAfter}"</#if>>
                    <label>occurrences</label>
                </div>
                <label id="range-end-occurrences-error" class="field-error" style="display: none;">Please enter number of occurrences to end.</label>

            </div>
            <div class="range-end-field">
                <div>
                    <input type="radio" id="rangeEndDateRB" name="rangeEndType" value="3"
                           <#if projectReminder?? && projectReminder.rangeEndDate??>checked="true"</#if>
                           onclick="onProjectReminderRangeEndChange(3)">
                    <label for="rangeEndDate" class="range-end-by-label">End by</label>
                    <script type="text/javascript">
                        $j(document).ready(function(){
                        <#if projectReminder?? && projectReminder.rangeEndType?? && projectReminder.rangeEndType?int = 3 && projectReminder.rangeEndDate??>
                            $j("#rangeEndDate").val("${projectReminder.rangeEndDate?string("dd/MM/yyyy")}");
                            $j("#rangeEndDateRB").click();
                        </#if>

                        });
                    </script>
                <@jiveform.datetimepicker id="rangeEndDate" name="rangeEndDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
                    <input type="text" id="rangeEndDateInput" name="rangeEndDateInput" disabled="true" style="display: none"/>
                </div>
                <label id="range-end-date-error" class="field-error" style="display: none;">Please select recurrence end date.</label>
            </div>
            <label id="range-end-type-error" class="field-error" style="display: none;">Please select recurrence end date type.</label>
        </div>
    </div>
</div>
<div class="action-buttons-container">
<script type="text/javascript">
function setProjectReminder() {
    if(validateProjectReminderForm()) {
        $j("#project-reminder-form").submit();
    }
}
function validateProjectReminderForm() {
    $j("label.field-error").hide();
    if($j("#toOthersProjectReminderType").is(":checked")) {
        var remindTo = $j("#remindTo").val();
        if(remindTo == undefined || remindTo == "") {
            $j("#remind-type-error").show();
            return false;
        } else {
            $j("#remind-type-error").hide();
        }
    }

    var categoryTypes = $j("input[name=categoryTypes]:checked").val();
    if(categoryTypes == undefined || categoryTypes == "") {
        $j("#category-type-error").show();
        return false;
    } else {
        $j("#category-type-error").hide();
    }

    var frequencyType= $j("input[name=frequencyType]:checked").val();

    if(frequencyType == undefined || frequencyType == "") {
        $j("#frequency-type-error").show();
        return false;
    } else {
        $j("#frequency-type-error").hide();
    }

    if(frequencyType == 1) {
        var dailyFrequencyType = $j("input[name=dailyFrequencyType]:checked").val();
        console.log(dailyFrequencyType)
        if(dailyFrequencyType == 1) {
            var dailyFrequency = $j("#dailyFrequency").val();
            if(dailyFrequency == undefined || dailyFrequency == "") {
                $j("#daily-frequency-type-error").show();
                return false;
            } else {
                $j("#daily-frequency-type-error").hide();
            }
        } else {
            $j("#daily-frequency-type-error").hide();
        }
    } else if(frequencyType == 2) {
        var weeklyFrequency = $j("#weeklyFrequency").val();
        if(weeklyFrequency == undefined || weeklyFrequency == "") {
            $j("#weekly-frequency-type-error").show();
            return false;
        } else {
            $j("#weekly-frequency-type-error").hide();
        }
        var weekdayTypes = $j("input[name=weekdayTypes]:checked").val();
        if(weekdayTypes == undefined || weekdayTypes == "") {
            $j("#weekly-types-error").show();
            return false;
        } else {
            $j("#weekly-types-error").hide();
        }

    } else if(frequencyType == 3) {
        var monthlyFreqType = $j("input[name=monthlyFrequencyType]:checked").val();
        if(monthlyFreqType == undefined || monthlyFreqType == "") {
            $j("#monthly-frequency-type-error").show();
            return false;
        } else {
            $j("#monthly-frequency-type-error").hide();
        }
        if(monthlyFreqType == 1) {
            var monthDayOfMonth = $j("#monthlyDayOfMonth").val();
            if(monthDayOfMonth == undefined || monthDayOfMonth == "") {
                $j("#monthly-day-of-month-error").show();
                return false;
            } else {
                $j("#monthly-day-of-month-error").hide();
            }

            var monthlyFreq1 = $j("#monthlyFrequency1").val();
            if(monthlyFreq1 == undefined || monthlyFreq1 == "") {
                $j("#monthly-frequency-type1-error").show();
                return false;
            } else {
                $j("#monthly-frequency-type1-error").hide();
            }

        } else if(monthlyFreqType == 2) {
            var monthlyWeekOfMonth = $j("#monthlyWeekOfMonth").val();
            if(monthlyWeekOfMonth == undefined || monthlyWeekOfMonth == "") {
                $j("#monthly-week-of-month-error").show();
                return false;
            } else {
                $j("#monthly-week-of-month-error").hide();
            }

            var monthlyDayOfWeek = $j("#monthlyDayOfWeek").val();
            if(monthlyDayOfWeek == undefined || monthlyDayOfWeek == "") {
                $j("#monthly-day-of-week-error").show();
                return false;
            } else {
                $j("#monthly-day-of-week-error").hide();
            }

            var monthlyFreq2 = $j("#monthlyFrequency2").val();
            if(monthlyFreq2 == undefined || monthlyFreq2 == "") {
                $j("#monthly-frequency-type2-error").show();
                return false;
            } else {
                $j("#monthly-frequency-type2-error").hide();
            }
        }
    } else if(frequencyType  == 4) {
        var yearlyFreq = $j("#yearlyFrequency").val();
        if(yearlyFreq == undefined || yearlyFreq == "") {
            $j("#yearly-frequency-error").show();
            return false;
        } else {
            $j("#yearly-frequency-error").hide();
        }
        var yearlyFrequencyType = $j("input[name=yearlyFrequencyType]:checked").val();
        if(yearlyFrequencyType == undefined || yearlyFrequencyType == "") {
            $j("#yearly-frequency-type-error").show();
            return false;
        } else {
            $j("#yearly-frequency-type-error").hide();
        }

        if(yearlyFrequencyType == 1) {
            var yearlyMonthOfYear1 = $j("#yearlyMonthOfYear1").val();
            if(yearlyMonthOfYear1 == undefined || yearlyMonthOfYear1 == "") {
                $j("#yearly-year-of-month1-error").show();
                return false;
            } else {
                $j("#yearly-year-of-month1-error").hide();
            }

            var yearlyDayOfMonth = $j('#yearlyDayOfMonth').val();
            if(yearlyDayOfMonth == undefined || yearlyDayOfMonth == "") {
                $j("#yearly-day-of-month-error").show();
                return false;
            } else {
                $j("#yearly-day-of-month-error").hide();
            }
        } else if(yearlyFrequencyType  == 2) {
            var yearlyWeekOfMonth = $j("#yearlyWeekOfMonth").val();
            if(yearlyWeekOfMonth == undefined || yearlyWeekOfMonth == "") {
                $j("#yearly-week-of-month-error").show();
                return false;
            } else {
                $j("#yearly-week-of-month-error").hide();
            }

            var yearlyDayOfWeek = $j("#yearlyDayOfWeek").val();
            if(yearlyDayOfWeek == undefined || yearlyDayOfWeek == "") {
                $j("#yearly-day-of-week-error").show();
                return false;
            } else {
                $j("#yearly-day-of-week-error").hide();
            }

            var yearlyMonthOfYear2 = $j("#yearlyMonthOfYear2").val();
            if(yearlyMonthOfYear2 == undefined || yearlyMonthOfYear2 == "") {
                $j("#yearly-year-of-month2-error").show();
                return false;
            } else {
                $j("#yearly-year-of-month2-error").hide();
            }
        }
    }

    var rangeStartDate = $j("#rangeStartDate").val();
    if(rangeStartDate == undefined || rangeStartDate == "") {
        $j("#range-start-error").show();
        return false;
    } else {
        $j("#range-start-error").hide();
    }

    var rangeEndDateType = $j("input[name=rangeEndType]:checked").val();
    if(rangeEndDateType == undefined || rangeEndDateType == "") {
        $j("#range-end-type-error").show();
        return false;
    } else {
        $j("#range-end-type-error").hide();
    }

    if(rangeEndDateType == 2) {
        var rangeEndAfter = $j("#rangeEndAfter").val();
        if(rangeEndAfter == undefined || rangeEndAfter == "") {
            $j("#range-end-occurrences-error").show();
            return false;
        } else {
            $j("#range-end-occurrences-error").hide();
        }
    } else if(rangeEndDateType == 3) {
        var rangeEndDate = $j("#rangeEndDate").val();
        if(rangeEndDate == undefined || rangeEndDate == "") {
            $j("#range-end-date-error").show();
            return false;
        } else {
            $j("#range-end-date-error").hide();
        }

    }
    return true;
}
</script>
<input type="button" class="set-reminder" value="Set Reminder" onclick="setProjectReminder()">
<input type="button" class="dismiss-reminder" value="Dismiss" onclick="dismissProjectReminder()">
</div>
</form>
</div>

<div id="general-reminder-container" class="general-reminder-container" style="display: none;">
    <form  id="general-reminder-form" action="<@s.url value="/synchro/reminder!setGeneralReminder.jspa"/>" method="post">
        <h3 class="sub-header">General Reminder</h3>
        <input type="hidden" name="reminderType" value="${statics['com.grail.synchro.SynchroGlobal$SynchroReminderType'].GENERAL_REMINDER.getId()}">
    <#if request.getParameter("id")?? && request.getParameter("reminderType")?? && request.getParameter("reminderType")?string = statics['com.grail.synchro.SynchroGlobal$SynchroReminderType'].GENERAL_REMINDER.getId()?string>
        <input type="hidden" name="id" value="${request.getParameter("id")}">
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
        <div class="action-buttons-container">
            <script type="text/javascript">
                function setGeneralReminder() {
                    if(validateGeneralReminderForm()) {
                        $j("#general-reminder-form").submit();
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
            <input type="button" class="dismiss-reminder" value="Dismiss" onclick="dismissGeneralReminder()">
        </div>
    </form>
</div>

</div>
</div>