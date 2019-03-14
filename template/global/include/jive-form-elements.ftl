<#macro fixIEDisabledFields>

<!--[if lt IE 8]>
 <script type="text/javascript">
        function restore(e) {
            if (e.options[e.selectedIndex].disabled) {
                e.selectedIndex = window.select_current[e.id];
            }
        }

        function emulate(e) {
            for (var i = 0, option; option = e.options[i]; i++) {
                if (option.disabled) {
                    option.style.color = "graytext";
                }
                else
                {
                    option.style.color = "menutext";
                }
            }
        }

        jQuery(function() {
            if (document.getElementsByTagName) {
                var s = jQuery("select");
                if (s.length > 0) {
                    window.select_current = new Array();
                    for (var i = 0, select; select = s[i]; i++) {
                        select.onfocus = function() {
                            window.select_current[this.id] = this.selectedIndex;
                        }
                        select.onchange = function() {
                            restore(this);
                        }
                        emulate(select);
                    }
                }
            }
        });

    </script>
  <![endif]-->

</#macro>
<#assign portalType =  'Synchro'>
<#--
<#if session.getAttribute('grail.portal.type')??>
    <#assign portalType =  session.getAttribute('grail.portal.type')>
</#if>
-->
<#macro datetimepicker id name value format="" showstime=false useservertime=false readonly=false disablePrevDates=false defaultDateTimePicker=true>
    <#--<#if defaultDateTimePicker>-->
        <@jiveform.fixIEDisabledFields/>
    <#-- the necessary javascript is included in the decorator -->
    <input type="text" class="jive-form-textinput-variable j-form-datepicker" id="${id}" name="${name}" <#if readonly>readonly="true"</#if>/>
    <input type="hidden"  id="userLocale" name="userLocale" value="${locale}" />

    <a href="#" id="${id}_button" class="j-form-datepicker-btn">

        <#if portalType?? && (portalType == 'synchro' || portalType == 'grail' || portalType == 'kantar')>
            <img src="${themePath}/images/synchro/calendar.png" encode='false'" width="19" height="19" border="0" alt="<@s.text name="global.datepicker.tooltip"/>" title="<@s.text name="global.datepicker.tooltip"/>" />
        <#else>
            <img src="<@resource.url value="/images/calendar/calendar.gif" encode='false'/>" width="34" height="21" border="0" alt="<@s.text name="global.datepicker.tooltip"/>" title="<@s.text name="global.datepicker.tooltip"/>" />
        </#if>

    </a>

    <script type="text/javascript">
        jQuery(document).ready(function() {

            <#if portalType?? && (portalType == 'synchro' || portalType == 'grail' || portalType == 'kantar')>
                <#assign dtFormat = "%d/%m/%Y"/>
            <#else>
                <#assign  dtFormat = "%d/%m/%Y"/>
            </#if>
            var time = null;
            <#if (value?has_content && value.time?exists && value.time > 0)>
                time = ${value.time?c};
                <#if useservertime>
                    time = ${value.time?c} - ${timeZone.rawOffset?c} + ${serverTimeZone.rawOffset?c};
                </#if>
            </#if>

            jQuery(window).scroll(function() {
                jQuery(".calendar").remove();
            });

            jQuery("#${id}_button, #${id}").mousedown(function(event){
                jQuery(".calendar").remove();
                console.log(jQuery("#${id}_button").offset());
            });

            function setTime(){
                if(time){
                    jQuery('#${id}').val(new Date(time).print(Zapatec.Calendar._TT["DEF_DATE_FORMAT"]));
                    jQuery('#${id}').change();
                }
            }

            function dateDisableHandler(date) {
                <#if disablePrevDates>
                    var today = new Date();
                    today.setHours(0);
                    today.setMinutes(0);
                    today.setSeconds(0);
                    today.setMilliseconds(0);

                    var calDate = eval(date);
                    calDate.setHours(0);
                    calDate.setMinutes(0);
                    calDate.setSeconds(0);
                    calDate.setMilliseconds(0);

                    if(calDate.getTime() < today.getTime()) {
                        return true;
                    }
                </#if>
                return false;
            }

            // lazy load zapatec calendar
            Zapatec.Calendar.bootstrap({
                inputField     :    "${id}",
//            disableFunc    :    dateDisableHandler,
                <#if dtFormat?has_content>
                    ifFormat       :    "${dtFormat}",
                </#if>
                <#if showstime?has_content>
                    showsTime      :    ${showstime?string},
                </#if>
                <#if (value?has_content && value.time?exists && value.time > 0)>
                    date           :    new Date(${value.time?c}),
                </#if>
                button         :    "${id}_button",
                step           :    1,
                disableDrag    : true,
                //position : [jQuery("#${id}_button").offset().top,jQuery("#${id}_button").offset().left],
                onUpdate:function(){
                    jQuery('#${id}').trigger("dateUpdate");					
					jQuery('#${id}').trigger("change");
                }
            }, setTime);
        });
    </script>
    <#--<#else>-->
       <#--<script type="text/javascript">-->
           <#--jQuery(document).ready(function(){-->
               <#--jQuery("#${id}").datepicker({showOn: 'button', buttonImageOnly: true,-->
                   <#--buttonImage:"<@resource.url value="images/calendar/calendar.gif"/>", showButtonPanel: true,-->
                  <#--dateFormat:"dd/mm/yy"-->
               <#--});-->
           <#--});-->
       <#--</script>-->
    <#--<input id="${id}" name="${name}"  value="">-->
    <#--</#if>-->
</#macro>

<#macro projectchooser project='' projectViewBeans='' id='jive-project-chooser' name='project' showPersonal=false showBrowse=true disabled=false>
    <@jiveform.fixIEDisabledFields/>
<#-- the necessary javascript is included in the decorator -->
<select id="${id}" name="${name}" <#if disabled>disabled="disabled"</#if>>
    <#if showPersonal>
        <option value=""><@s.text name='project.chooser.personal'/></option>
    <#else>
        <option value="">--</option>
    </#if>
    <#if (project?has_content && project.objectType == JiveConstants.PROJECT)>
        <option value="${project.ID?c}" selected="selected">
        ${project.name?html}
            <#if (project.parentContainer?has_content)>
                (in ${project.parentContainer.name?html})
            </#if>
        </option>
    </#if>
    <option value="-2" disabled="disabled"><@s.text name='project.chooser.your'/></option>
    <#if projectViewBeans?has_content && projectViewBeans.hasNext()>
        <#list projectViewBeans as aProject>
            <#if (!project?has_content || (aProject.ID != project.ID))>
                <option value="${aProject.ID?c}">
                    &nbsp;&nbsp;${aProject.name?html}
                    <#if (aProject.parentContainer?has_content) >
                        (in ${aProject.parentContainer.name?html})
                    </#if>
                </option>
            </#if>
        </#list>
    <#else>
        <option value="-3" disabled="disabled">&nbsp;&nbsp;<@s.text name='project.chooser.your_none'/></option>
    </#if>
    <#if showBrowse>
        <option value="" disabled="disabled"><@s.text name='project.chooser.browse'/></option>
        <option value="-1">&nbsp;&nbsp;<@s.text name='project.chooser.all'/></option>
    </#if>
</select>
<script type="text/javascript">
    jQuery(document).ready(function() {
        var jiveprojectchooser = new jive.Projectpicker.Main({triggerSelector:'#${id}', objectType: ${JiveConstants.TASK}});
        jQuery('#${id}').change(jiveprojectchooser.handleChange.bind(jiveprojectchooser, jQuery('#${id}')[0]));
    });
</script>
</#macro>
