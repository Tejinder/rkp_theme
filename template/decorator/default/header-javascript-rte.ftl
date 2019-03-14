    <#if request.getAttribute("headerRTEInclude")! != "true">
    <#assign headerRTEInclude = request.setAttribute("headerRTEInclude", "true")/>

    <script>
    <#-- Documents, Blog Posts, and Discussions set the images variable up in their own ftl - which is why we check for isWikiImagesEnabled -->
    <#if !isWikiImagesEnabled?? && (container?? && object??) >
        <#-- checking perm helper -->
        window._jive_images_enabled = <#if skin.template.isObjectImagesEnabled(container, object)>true;<#else>false;</#if>
    <#elseif !isWikiImagesEnabled??>
        window._jive_images_enabled = <#if skin.template.imageEnabled>true;<#else>false;</#if>
    </#if>
    </script>

    <@resource.template file="/soy/status_input/status_input_drop_down.soy" id="rte" />
    <@resource.template file="/soy/rte/rte_table.soy" id="rte" />

    <@resource.javascript file="/resources/scripts/jquery/jquery.spinbox.js" header="true" id="rte"/>
    <@resource.javascript file="/resources/scripts/jquery/jquery.json.js" header="true" id="rte"/>
    <@resource.javascript file="/resources/scripts/jive_selection.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/jive/ext/y/y_slide.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/tiny_mce_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/langs/${displayLanguage}.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_core_i18n_custom.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivelists/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_jivelists_i18n.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivestyle/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_jivestyle_i18n.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivemacros/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_jivemacros_i18n.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_jivemacros_i18n_dlg.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jiveemoticons/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivemention/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_jivemention_i18n.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_jivetable_i18n.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivetable/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivetablecontrols/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivescroll/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jiveblackout/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivecontextmenu/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jiveresize/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_jiveemoticons_i18n.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivebuttons/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivekeyboard/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivelink/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_jivelink_i18n.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jiveimage/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_jiveimage_i18n.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivequote/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_jivequote_i18n.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jiveutil/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jiveselection/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivemouse/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivevideo/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_jivevideo_i18n.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_jivevideo_i18n_dlg.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/jivetablebutton/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_tabletoolbar_i18n.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/style/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/table/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/table/langs/${displayLanguage}_dlg.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_table_i18n_dlg_custom.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/html/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_html_i18n_dlg.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/save/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/advimage/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/advimage/langs/${displayLanguage}_dlg.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_advimage_i18n_dlg_custom.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/advlink/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/advlink/langs/${displayLanguage}_dlg.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/inlinepopups/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/plugins/paste/editor_plugin_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/themes/advanced/editor_template_src.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/themes/advanced/langs/${displayLanguage}.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_advanced_i18n_custom.js" header="true" id="rte" />
    <@resource.javascript file="/resources/scripts/tiny_mce3/themes/advanced/langs/${displayLanguage}_dlg.js" header="true" id="rte" />

    <@resource.javascript file="/resources/scripts/jive/rte/syntax/syntaxhighlightmacro.js" header="true" id="rte" />


    <#-- OpenSocial gadgets -->
    <@resource.javascript file="/resources/scripts/opensocial/gadget-source.js" id="rte" header="true"/>
    <@resource.javascript file="/resources/scripts/opensocial/rte/editor_plugin_src.js" id="rte" header="true" />
    <@resource.javascript file="/resources/scripts/tinymce/i18n/${displayLanguage}_rte_jivegadget_i18n.js" id="rte"
        header="true" />

    <@resource.javascript file="/resources/scripts/post.js"  header="true" id="rte"/>
    <@resource.javascript file="/resources/scripts/autosave.js"  header="true" id="rte"/>
    <@resource.javascript file="${themePath}/scripts/posteditor.js"  header="true" id="rte"/>
    <@resource.javascript file="/resources/scripts/guieditor.js"  header="true" id="rte"/>

    <@resource.javascript  header="true" id="rte">
    window.errorHandlerMessage = "An error occurred:";

    window.editorErrorHandler = function(message, exception) {
        // if the message is something other than a timeout, show the message plus the error code
        if (message.indexOf('Timeout') == -1) {
            $j('#dwr-error-text').text(errorHandlerMessage + ' Error Code: ' + message);
            $j('#dwr-error-table').fadeIn();
            setTimeout(function() {
                $j('#dwr-error-table').fadeOut();
            }, 10000);
        }
    };
    </@resource.javascript>

    <@resource.javascript header="true" id="rte">
    
    <#list skin.template.pluginResourceBundles as bundle>
    if(typeof(tinyMCE) != "undefined"){ // could be Safari 2, which dies with tinyMCE
        tinyMCE.addI18n('${displayLanguage}.jivemacros',{
            <#list bundle.keys as key>
                <#if key.startsWith("macro.") >
                    "${key}": "${bundle.getString(key)?js_string}",
                </#if>
            </#list>
                    "unused.jive.key" : "nothing."
        });
    }
    </#list>


        window.RawHTMLSaveFunction = function(element_id, html, body){
            var text = $j('#wysiwygtext');
            if (text.is(':not(:visible)')) {
                return html;
            }else{
                return text.val();
            }
        }
        jive.rte.multiRTE = new Array();

        //Not used by RTEWrap, but we need this for backward compatibility; see CS-23883
        window.refreshLinks = function() {
            jive.rte.multiRTE.forEach(function(rteID) {
                if ($j('#' + rteID + '_parent').length < 1) {
                    // safari 2, text only
                    $j('#' + rteID + '_toggle_html').hide();
                    $j('#jivePreferredEditorModeLinkHREF').hide();
                    return;
                }

                if(currentMode == 'rawhtml') {
                    $j('#' + rteID + '_toggle_html').css('display', 'block');
                }else{
                    $j('#' + rteID + '_toggle_html').hide();
                }

                if (preferredMode == currentMode) {
                    $j('#jivePreferredEditorModeLinkHREF').hide();
                } else {
                    $j('#jivePreferredEditorModeLinkHREF').css('display', 'block');
                }
            });
        }

    window.editor = new jive.ext.y.HashTable();
    </@resource.javascript>
    <#--<link rel="stylesheet" type="text/css" href="<@resource.url value="/styles/tiny_mce3/plugins/inlinepopups/skins/clearlooks2/window.css" />" />-->

    <@resource.javascript header="true" id="rte">
       ${macroJavaScript}
    </@resource.javascript>

    <@resource.javascript>
        <#-- When loading the RTE asynchronously set a flag to indicate that the DOM is already ready. -->
        <#if asyncLoadRTE!true>
            window.tinyMCE_GZ = { loaded: true };
        <#else>
            <#-- Allows `kjs.require('jive.rte')` to work even when code is loaded synchronously. -->
            kjs.sat('jive.rte');
            kjs.sat('jive.rte--required');
        </#if>
    </@resource.javascript>

    <#if asyncLoadRTE!true>
        <@resource.javascript header="true" id="rte" asyncOutput=true satisfies="jive.rte" />
    <#else>
        <@resource.javascript header="true" id="rte" output="true" />
    </#if>

    </#if>
