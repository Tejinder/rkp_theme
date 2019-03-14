
    <#-- Include global constants -->
    <script type="text/javascript">
        window.SPELL_LANGS = "${skin.template.languageString?js_string}";
        window.CS_BASE_URL = "${skin.template.currentBaseUrl?js_string}";
        window.CS_RESOURCE_BASE_URL = "${skin.template.resourceBaseUrl?js_string}";
        window.tinyMCEPreInit = {
            suffix : "_src",
            base : CS_BASE_URL + "/resources/scripts/tiny_mce3"
        };
        if (typeof(_jive_project_i18n) == "undefined") {
            var _jive_project_i18n = new Array();
            _jive_project_i18n['project.calendar.task'] = "${action.getText("project.calendar.task")?js_string}";
            _jive_project_i18n['project.calendar.tasks'] = "${action.getText("project.calendar.tasks")?js_string}";
            _jive_project_i18n['project.calendar.checkpoint'] = "${action.getText("project.calendar.checkpoint")?js_string}";
            _jive_project_i18n['project.calendar.checkpoints'] = "${action.getText("project.calendar.checkpoints")?js_string}";
            _jive_project_i18n['global.edit'] = "${action.getText("global.edit")?js_string}";
            _jive_project_i18n['global.delete'] = "${action.getText("global.delete")?js_string}";
            _jive_project_i18n['project.task.mark.complete'] = "${action.getText("project.task.mark.complete")?js_string}";
            _jive_project_i18n['project.task.assign.to.me'] = "${action.getText("project.task.assign.to.me")?js_string}";
            _jive_project_i18n['task.incomplete.link'] = "${action.getText("task.incomplete.link")?js_string}";
            _jive_project_i18n['project.checkPoint.create.link'] = "${action.getText("project.checkPoint.create.link")?js_string}";
            _jive_project_i18n['project.task.create.link'] = "${action.getText("project.task.create.link")?js_string}";
        }
    </script>
    <@resource.javascript file="/resources/scripts/supernote.js" header="true" id="core" /> <#-- supernote depends on CS_BASE_URL -->

    <#-- Language support -->
    <@resource.javascript file="/resources/scripts/lib/jiverscripts/src/compat/array.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/lib/jiverscripts/src/compat/object.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/lib/core_ext/array.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/lib/core_ext/function.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/lib/core_ext/object.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/lib/core_ext/string.js" header="true" id="core" />

    <#-- Security measures -->
    <@resource.javascript file="/resources/scripts/jive/json-security.js" header="true" id="core" />

    <#-- JSON 2 util lib -->
    <@resource.javascript file="/resources/scripts/json/json2.js" header="true" id="core" />

    <#-- Include core ClearSpace JavaScript API -->
    <@resource.javascript file="/resources/scripts/jive/namespace.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/dispatcher.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/lib/jiverscripts/src/oo/class.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/lib/jiverscripts/src/oo/compose.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/lib/jiverscripts/src/conc/next_tick.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/lib/jiverscripts/src/conc/observable.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/lib/jiverscripts/src/conc/promise.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/lib/event.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/util.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/i18n.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/ext/x/x_core.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/ext/x/x_event.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/ext/x/x_timer.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/ext/y/y_core.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/ext/y/y_ajax.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/xhr_stack.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/xml/xparse.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/xml/xmlparser.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/card.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/ajax.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/control.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/task_control.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/checkpoint_control.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/date.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/i18n/${displayLanguage}.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/language.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/login.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/refresh.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/settings.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/user.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/places.js"  header="true" id="core"/>
    <@resource.javascript file="/resources/scripts/jive/model/project.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/project_list.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/document.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/document_list.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/task_list.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/model/task.js" header="true" id="core" />
    <@resource.javascript header="true" id="core">
        // begin list of custom CSS
        jive.rte.defaultStyles = new Array();
        <#list skin.template.pluginCSSSrcURLs as src >
            jive.rte.defaultStyles.push("<@s.url value='${src}' />");
        </#list>
        // end list of custom CSS
    </@resource.javascript>

    <@resource.javascript file="/resources/scripts/jive/rte/settings.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/paramset.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/rte.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/rte_layout.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/rte_wrap.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/macro.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/emote.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/rte_list.js" header="true" id="core" />

    <@resource.javascript file="/resources/scripts/jive/rte/syntax/shCore.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/syntax/shBrushCpp.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/syntax/shBrushCSharp.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/syntax/shBrushCss.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/syntax/shBrushDelphi.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/syntax/shBrushJava.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/syntax/shBrushJScript.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/syntax/shBrushPhp.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/syntax/shBrushPython.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/syntax/shBrushRuby.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/syntax/shBrushSql.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/syntax/shBrushVb.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/syntax/shBrushXml.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/syntax/shBrushPlain.js" header="true" id="core" />

    <@resource.javascript file="/resources/scripts/jive/rte/renderedContent.js" header="true" id="core" />

    <@resource.javascript file="/resources/scripts/jive/rest.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/apps/shared/models/rest_service.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/ImageService.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/LinkService.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/FormService.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/rte/EntitlementService.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/soy_functions.js" header="true" id="core" />
    <@resource.javascript file="/resources/scripts/jive/template.js" header="true" id="core" />

    <@resource.javascript file="/resources/scripts/jive/avatar.js" header="true" id="core" />

    <#-- Instatiate a Controller and Model -->
    <@resource.javascript header="true" id="core">
            var jiveControl = new jive.model.Controller();
            jive.rte.mobileUI = <#if rteDisabledBrowser?? && rteDisabledBrowser>true<#else>false</#if>;
    </@resource.javascript>

    <#-- Set up short alias for jive.conc.observable. -->
    <@resource.javascript header="true" id="core">
        jive.observable = jive.conc.observable;
    </@resource.javascript>

    <#if skin.template.clientConstants??>
        <@resource.javascript header="true" id="core">
            //make jive constants available to JS and client-side soy
            ${skin.template.clientConstants}
        </@resource.javascript>
    </#if>
