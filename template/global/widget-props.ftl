<#assign thisWidgetContext = widgetContext/>

<@soy.render template="jive.skin.template.ajaxload" data=skin.template/>
<html xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">

<#if (!complete)>

<body class="jive-widget-props">
<div class="jive-widget-edit-container">
    <#if action.getActionErrors()?? && action.getActionErrors().size() gt 0>
        <#list action.getActionErrors() as error>
            <div id="jive-error-box" class="jive-error-box" aria-live="polite" aria-atomic="true">
                <div>
                    <span class="jive-icon-med jive-icon-redalert"></span>
                ${error}
                </div>
            </div>
        </#list>
    </#if>

    <div class="jive-widget-edit-description">${widgetFrame.widget.getDescription(thisWidgetContext)!}</div>

    <form action="<@s.url action='widget-props'/>" id="jivewidgetpropform-${widgetFrame.ID?c}" onsubmit="jivewidgetprops${widgetFrame.ID?c}.loadEditorValues(); return false;"
          name="jivewidgetpropform-${widgetFrame.ID?c}" method="post">
        <input type="hidden" name="widgetFrameID" value="${widgetFrame.ID?c}"/>
        <input type="hidden" name="widgetTypeID" value="${widgetTypeID?c}"/>
        <@jive.token name="widget.props.${widgetFrame.ID?c}" />

        <div class="jive-widget-edit-elem-title"><label for="customTitle"><@s.text name="widget.props.customtitle"/><@s.text name="global.colon"/></label></div>
        <div class="jive-widget-edit-elem-desc"><@s.text name="widget.props.customtitle.desc"/></div>
        <input type="text" id="customTitle" name="customTitle" value="${customTitle!?html}"
               class="jive-widget-edit-elem-customtitle" style="width: 98%"/>
        <br/>
        <#assign communities = statics['java.util.Collections'].EMPTY_LIST/>
        <#assign projects = statics['java.util.Collections'].EMPTY_LIST/>
        <#assign socialGroups = statics['java.util.Collections'].EMPTY_LIST/>

        <#if !widgetFrame.widget.bridge??>
        <#-- this is a local widget, use reflection based properties -->
            <#list propertyDescriptors as propDescriptor>
                <#if (propDescriptor.name != 'ID' && propDescriptor.name != 'customTitle' && propDescriptor.name != 'widgetFrameID' && !propDescriptor.hidden && propDescriptor.readMethod?exists && propDescriptor.writeMethod?exists)>
                    <#if (propDescriptor.name == "communityID") && (widgetTypeID == enums['com.jivesoftware.community.widget.WidgetType'].PROJECT.key || widgetTypeID == enums['com.jivesoftware.community.widget.WidgetType'].SOCIALGROUP.key)>
                        <#break/>
                    <#elseif (propDescriptor.name == "projectID" || propDescriptor.name == "socialGroupID") && (widgetTypeID == enums['com.jivesoftware.community.widget.WidgetType'].COMMUNITY.key || widgetTypeID == enums['com.jivesoftware.community.widget.WidgetType'].PROJECT.key || widgetTypeID == enums['com.jivesoftware.community.widget.WidgetType'].SOCIALGROUP.key)>
                    <#elseif (propDescriptor.name == 'containerType')>
                    <#else>

                        <#assign propName = propDescriptor.name/>
                        <#assign propValue = action.getPropertyValue(propDescriptor)!/>
                        <#assign className = propDescriptor.propertyType.name/>
                        <#assign useLarge = ("true" == propDescriptor.getValue("useLargeTextField")!?lower_case)/>
                        <#assign useRich = ("true" == propDescriptor.getValue("useRichTextField")!?lower_case)/>
                        <#assign showStaticFileControls = ("true" == propDescriptor.getValue("showStaticFileControls")!?lower_case && widgetFrame.widget.isStaticsEnabled(thisWidgetContext))/>
                        <#if "java.util.Map" != className>
                            <#if showStaticFileControls && (useLarge || useRich)>
                                <@soy.render template="jive.staticFileStore.soy.modalTrigger" data={
                                "containerType": "${widgetFrame.parentObject.objectType?c}",
                                "containerID": "${widgetFrame.parentObject.ID?c}"
                                <#--"containerDisplayName": "${widgetFrame.parentObject.name?js_string}"-->
                                } />
                            </#if>
                            <div class="jive-widget-edit-elem-title">${propDescriptor.displayName}:</div>
                            <div class="jive-widget-edit-elem-desc jive-widget-edit-elem-word-wrap">${propDescriptor.shortDescription}</div>
                        </#if>

                        <@propsForm propDescriptor=propDescriptor propName=propName propValue=propValue className=className useLarge=useLarge useRich=useRich showStaticFileControls=showStaticFileControls/>
                            <br/>
                    </#if>
                </#if>
            </#list>
            <#else>
            <#-- remote widget, use WSTypedProperty object -->
                <#if remoteProperties??>
                    <#list remoteProperties as remoteProperty>
                        <#if (remoteProperty.name != 'ID' && remoteProperty.name != 'customTitle')>
                            <#if (remoteProperty.name == "communityID") && (widgetTypeID == enums['com.jivesoftware.community.widget.WidgetType'].PROJECT.key || widgetTypeID == enums['com.jivesoftware.community.widget.WidgetType'].SOCIALGROUP.key)>
                                <#break/>
                                <#elseif (remoteProperty.name == "projectID" || remoteProperty.name == "socialGroupID") && (widgetTypeID == enums['com.jivesoftware.community.widget.WidgetType'].COMMUNITY.key || widgetTypeID == enums['com.jivesoftware.community.widget.WidgetType'].PROJECT.key || widgetTypeID == enums['com.jivesoftware.community.widget.WidgetType'].SOCIALGROUP.key)>
                                    <#break/>
                                <#elseif (remoteProperty.name == 'containerType')>
                                <#else>
                                    <#assign propName = remoteProperty.name/>
                                    <#assign className = remoteProperty.type.className!/>
                                    <#if className == "java.util.Map">
                                        <#assign propValue = remoteProperty.values!/>
                                        <#else>
                                            <#assign propValue = remoteProperty.value!/>
                                            <div class="jive-widget-edit-elem-title">${remoteProperty.label!?html}:
                                            </div>
                                            <div class="jive-widget-edit-elem-desc">${remoteProperty.shortDescription!?html}</div>
                                    </#if>

                                <@propsForm propName=propName propValue=propValue className=className remote=true bridgeID=widgetFrame.widget.bridge.ID />
                                    <br/>
                            </#if>
                        </#if>
                    </#list>
                </#if>
        </#if>
        <br/>
        <input type="submit" id="jive-widgetprops-save_${widgetFrame.ID?c}" name="save"
               value="<@s.text name='widget.props.save.button'/>" class="j-btn-callout">
        <input type="button" id="jive-widgetprops-cancel_${widgetFrame.ID?c}" name="cancel"
               value="<@s.text name='global.cancel'/>" onclick="jivewidgetprops${widgetFrame.ID?c}.doCancel();">
    </form>

</div>
<script type="text/javascript" language="JavaScript">
    var _jive_video_picker__url = "?container=${widgetFrame.parentObject.ID?c}&containerType=${widgetFrame.parentObject.objectType?c}";

    // var name needs to be unique because multiple could be included on the page
    var jivewidgetprops${widgetFrame.ID?c} = new WidgetProps({
        widgetTypeID : ${widgetTypeID?c},
        widgetFrameID : ${widgetFrameID?c},
        submitURL : '<@s.url action="widget-props"/>', // submitURL
        cancelURL : '<@s.url action="widget-props" method="cancel"/>' // cancelURL
    });

    var enableFollowedPlaces = function() {

        // disable all container radios
        $j('#choose-community-radio').prop('disabled', true);
        $j('#widget-edit-choose-group').prop('disabled', true);
        $j('#choose-project-radio').prop('disabled', true);
        $j('#widget-edit-choose-comm').prop('disabled', true);
        $j('#choose-group-radio').prop('disabled', true);
        $j('#widget-edit-choose-proj').prop('disabled', true);
        $j('#rb-recursive-1').prop('disabled', true);
        $j('#rb-recursive-2').prop('disabled', true);
    }

    var disableFollowedPlaces = function () {

        // enable all container radios
        $j('#choose-community-radio').prop('disabled', false);
        $j('#choose-project-radio').prop('disabled', false);
        $j('#choose-group-radio').prop('disabled', false);

        if ($j('#choose-community-radio').is(':checked')) {
            $j('#widget-edit-choose-comm').prop('disabled', false);
        } else if ($j('#choose-project-radio').is(':checked')) {
            $j('#widget-edit-choose-proj').prop('disabled', false);
        } else if ($j('#choose-group-radio').is(':checked')) {
            $j('#widget-edit-choose-group').prop('disabled', false);
        }

        $j('#rb-recursive-1').prop('disabled', false);
        $j('#rb-recursive-2').prop('disabled', false);
    }

    $j(document).delegate("input[name=showFollowedPlaces]", "click", function() {
        if ($j(this).val() == "false") {
            disableFollowedPlaces();
        }
        else {
            enableFollowedPlaces();
        }
    });
    if ($j('#rb-showFollowedPlaces-1').is(':checked')) {
        enableFollowedPlaces();
    }
</script>
</body>

    <#else>

    <body>
    <@jive.renderWidgetBody widgetFrame=widgetFrame widget=skin.widget.getWidgetRenderer(widgetFrame, widgetContext, containerSize)/>
    <#-- Manually set the inner html of the title to  the changed title, since that section does not update with props -->
    <script type="text/javascript">
        $j('#jive-widgetframe-title_${widgetFrame.ID?c}')
                .text('<#if widgetFrame.widget.customTitle?has_content>${widgetFrame.widget.customTitle?js_string}<#else>${widgetFrame.widget.getTitle(thisWidgetContext)?js_string}</#if>');
            <#if widgetFrame.widget.bridge??>
                <#assign globalOn = action.getText("global.on_place") />
            $j('#jive-widgetframe-title_${widgetFrame.ID?c}').append($j(document.createElement('span'))
                    .addClass('jive-widget-bridge-name').text(' ${globalOn} ').append($j(document.createElement('a'))
                    .attr('href', '${widgetFrame.widget.bridge.url?js_string}').append($j(document.createElement('img'))
                    .attr('src', '${widgetFrame.widget.bridge.faviconUrl?js_string!}').attr('border', '0')
                    .attr('height', '16').attr('width', '16')).append(document
                    .createTextNode('${widgetFrame.widget.bridge.name?js_string}'))));
            </#if>
    </script>
    </body>

</#if>

<#macro propsForm propDescriptor propName propValue className useLarge=false useRich=false remote=false bridgeID=-1 showStaticFileControls=false>
    <#if (("int" == className) || ("double" == className) || ("long" == className))>
        <#if propName = 'containerID'>
			 <style type="text/css">
            .jive-container-chooser-selected {
                font-size: 1.2em;
                background: #f0f8fe;
                border: 1px solid #d0e3f6;
                -moz-border-radius: 4px;
                -webkit-border-radius: 4px;
                border-radius: 4px;
                padding: 8px 15px 6px;
            }
            .jive-container-chooser-selected a{
                font-size: .83em;
            }
        </style>
            <div class="j-js-picker-container">
                <#if remote>
                    <input type="hidden" name="remoteContainerType" id="jive-container-chooser-type-${widgetFrame.ID?c}"
                           value="<#if remoteContainer??>${remoteContainer.objectType?c}<#else>-1</#if>"/>
                    <input type="hidden" name="remoteContainerID" id="jive-container-chooser-id-${widgetFrame.ID?c}"
                           value="<#if remoteContainer??>${remoteContainer.ID?c}<#else>-1</#if>"/>

                    <div id="jive-container-chooser-selected" onclick="autocompleteContainer.removeContainer(); return false;"
                         <#if !remoteContainer??>style="display:none"</#if>>
                        <#if remoteContainer??><span><span
                                class="${SkinUtils.getJiveObjectCss(remoteContainer, 0)}"></span>${remoteContainer.name?html}</span></#if>
                        <a class="j-js-change" href="#" class="font-color-meta"><@s.text name="global.change"/></a>
                    </div>
                    <label for="jive-container-chooser" class="j-508-label"><@s.text name="widget.props.choose.a.place"/></label>
                    <input type="text" id="jive-container-chooser" name="containerName"
                       class="jive-search-container jive-autocomplete"
                       style="             <#if remoteContainer??>display: none;</#if>"/>
                <#else>
                    <input type="hidden" name="containerType" id="jive-container-chooser-type-${widgetFrame.ID?c}"
                           value="<#if container??>${container.objectType?c}<#else>-1</#if>"/>
                    <input type="hidden" name="containerID" id="jive-container-chooser-id-${widgetFrame.ID?c}"
                           value="<#if container??>${container.ID?c}<#else>-1</#if>"/>

                    <div id="jive-container-chooser-selected-${widgetFrame.ID?c}" class="jive-container-chooser-selected" 
                         onclick="autocompleteContainer.removeContainer(); return false;"
                         <#if !container??>style="display:none"</#if>>
                        <#if container??><span><span
                                class="${SkinUtils.getJiveObjectCss(container, 0)}"></span>${container.name?html}
                            </span>
                            <#if container.visibleToPartner>
                            <span title="<@s.text name="partner.browse.ext_access"/>" class="jive-icon-med jive-icon-partner"></span>
                            </#if>
                        </#if>
                        <a class="j-js-change" href="#" class="font-color-meta"><@s.text name="global.change"/></a>
                    </div>
                    <label for="jive-container-chooser" class="j-508-label"><@s.text name="widget.props.choose.a.place"/></label>
                    <input type="text" id="jive-container-chooser-${widgetFrame.ID?c}" name="containerName" 
                           class="jive-search-container jive-autocomplete"
                           style="<#if container??>display: none;</#if>"/>
                </#if>
                <ul id="jive-container-chooser-choices" class="jive-autocomplete"
                    style="max-height:300px; overflow-y:auto; display:none"></ul>
            </div>

            <@resource.javascript file="/resources/scripts/containerpicker.js" parseDependencies="true" />
            <@resource.javascript>
                var autocompleteContainer = new JiveContainerPicker({
            containerTypeField: "jive-container-chooser-type-${widgetFrame.ID?c}",
            containerIDField: "jive-container-chooser-id-${widgetFrame.ID?c}",
            containerSelected: "jive-container-chooser-selected-${widgetFrame.ID?c}",
            chooser:"jive-container-chooser-${widgetFrame.ID?c}",
                <#if remote>bridge:${bridgeID?c},</#if>
                    <#if containerChooserType??>validTypes:[${containerChooserType?js_string}],</#if>
                    showRootCommunity: <#if rootCommunityChooseable??>true<#else>false</#if>
                });
            </@resource.javascript>
            <@resource.javascript output=true/>

        <#elseif propName == 'projectIDOrTask' && !remote>
            <select name="projectIDOrTask">
                <option value="0"<#if (propValue == 0)>
                        selected="selected"</#if>><@s.text name="widget.props.alltasks.text" /></option>
                <option value="-1"<#if (propValue == -1)>
                        selected="selected"</#if>><@s.text name="widget.props.personaltasks.text" /></option>

                <#list action.getTrackedProjects() as project>
                    <option value="${project.ID?c}"<#if (propValue == project.ID)> selected="selected"</#if>>
                    ${project.name?html}
                        <#if (project.parentContainer?has_content)>
                            (<@s.text name="widget.props.in.text" /> ${project.parentContainer.name?html})
                        </#if>
                    </option>
                </#list>
            </select>

        <#elseif propName == 'documentID' && !remote>
            <span>
                <input type="text" name="documentAuto" class="jive-widget-edit-elem-customtitle" role="combobox"
                       id="document-autocomplete-input"/>
            </span>

            <#if document??>
                <#assign documentHtml><span class="${SkinUtils.getJiveObjectCss(document, 1)}"></span><span
                        class="jive-autocomplete-result-content">${action.renderSubjectToText(document)} </span>
                </#assign>
            </#if>

            <@resource.javascript file="/resources/scripts/jquery/jquery.utils.js" />
            <@resource.javascript file="/resources/scripts/jquery/jquery.contentAutocomplete.js" parseDependencies="true" />
            <@resource.javascript>
                $j(function() {
                    $j("#document-autocomplete-input").contentAutocomplete({
                        <#if document??>
                            startingContent: {
                                type: ${document.objectType?c},
                                id: ${document.ID?c},
                                html: '${documentHtml?js_string}'
                            },
                        </#if>
                        i18nKeys: {
                            <#assign globalChange><@s.text name="global.change"/></#assign>
                            change: '${globalChange?js_string}'
                        },
                        urls: {
                            contentAutocomplete: _jive_base_url + '/doc-widget-content-autocomplete.jspa'
                        },
                        contentIDParam: 'documentID',
                        contentTypes: [${JiveConstants.DOCUMENT}]
                    });
                });
            </@resource.javascript>

        <#elseif propName == 'blogID' && !remote>

            <input type="hidden" name="containerType" id="jive-container-chooser-type"
                   value="<#if blog??>${blog.objectType?c}<#else>-1</#if>"/>
            <input type="hidden" name="blogID" id="jive-container-chooser-id"
                   value="<#if blog??>${blog.ID?c}<#else>-1</#if>"/>

            <div id="jive-container-chooser-selected" onclick="autocompleteContainer.removeContainer(); return false;"
                 <#if !blog??>style="display:none"</#if>>
                <#if blog??><span><span
                        class="${SkinUtils.getJiveObjectCss(blog, 0)}"></span>${blog.name?html}</span></#if>
                <a class="j-js-change" href="#" class="font-color-meta"><@s.text name="global.change"/></a>
            </div>
            <input type="text" id="jive-container-chooser" name="containerName"
                   class="jive-search-container jive-autocomplete"
                   style="<#if blog??>display: none;</#if>"/>
            <ul id="jive-container-chooser-choices" class="jive-autocomplete"
                style="max-height:300px; overflow-y:auto; display:none"></ul>

            <@resource.javascript file="/resources/scripts/blogpicker.js"/>
            <@resource.javascript>
                var autocompleteContainer = new JiveBlogPicker({<#if validTypes??> validTypes:[${validTypes}] </#if>});
            </@resource.javascript>
            <@resource.javascript output=true/>

        <#elseif propName == 'acclaimDateRange' && !remote>

            <select name="acclaimDateRange">
                <option value="0"<#if (propValue == 0)>
                        selected="selected"</#if>><@s.text name="acclaim.widget.today" /></option>
                <option value="1"<#if (propValue == 1)>
                        selected="selected"</#if>><@s.text name="acclaim.widget.past_week" /></option>
                <option value="2"<#if (propValue == 2)>
                        selected="selected"</#if>><@s.text name="acclaim.widget.past_month" /></option>
                <option value="3"<#if (propValue == 3)>
                        selected="selected"</#if>><@s.text name="acclaim.widget.all_time" /></option>
            </select>

            <#elseif propName == 'viewBlogOption' && !remote>
                <#assign viewBlogWidget = statics['com.jivesoftware.community.widget.impl.ViewBlogWidget'] />
            <select name="viewBlogOption">
                <option value="${viewBlogWidget.TITLE_VIEW}"<#if (propValue == viewBlogWidget.TITLE_VIEW)>
                        selected="selected"</#if>><@s.text name="widget.viewblog.option.title" /></option>
                <option value="${viewBlogWidget.EXCERPT_VIEW}"<#if (propValue == viewBlogWidget.EXCERPT_VIEW)>
                        selected="selected"</#if>><@s.text name="widget.viewblog.option.excerpt" /></option>
                <option value="${viewBlogWidget.FULL_VIEW}"<#if (propValue == viewBlogWidget.FULL_VIEW)>
                        selected="selected"</#if>><@s.text name="widget.viewblog.option.full" /></option>
            </select>

        <#elseif propName == 'viewRssFeedMode' && !remote>
            <#assign rssSubscriptionWidget = statics['com.jivesoftware.community.widget.impl.RssSubscriptionWidget'] />
            <select name="viewRssFeedMode">
                <option value="${rssSubscriptionWidget.TITLE_VIEW}"<#if (propValue == rssSubscriptionWidget.TITLE_VIEW)>
                        selected="selected"</#if>><@s.text name="widget.rsssubscription.option.title" /></option>
                <option value="${rssSubscriptionWidget.EXCERPT_VIEW}"<#if (propValue == rssSubscriptionWidget.EXCERPT_VIEW)>
                        selected="selected"</#if>><@s.text name="widget.rsssubscription.option.excerpt" /></option>
                <option value="${rssSubscriptionWidget.FULL_VIEW}"<#if (propValue == rssSubscriptionWidget.FULL_VIEW)>
                        selected="selected"</#if>><@s.text name="widget.rsssubscription.option.full" /></option>
            </select>

        <#else>
            <input type="text" name="${propName?html}" size="4" maxlength="10" class="jive-widget-edit-elem-num"
                   <#if (propValue?has_content && propValue?is_number)>value="${propValue?c}"
                   <#elseif (propValue?has_content)>value="${propValue?string?html}"</#if>/>
        </#if>

    <#elseif ("boolean" == className)>
        <#assign booleanValue = ("true" == propValue?string?lower_case)/>
        <input type="radio" name="${propName?html}" id="rb-${propName?html}-1" value="true"
               <#if booleanValue>checked="checked"</#if> />
        <label for="rb-${propName?html}-1"><@s.text name='global.yes'/></label>
        <input type="radio" name="${propName?html}" id="rb-${propName?html}-2" value="false"
               <#if !booleanValue>checked="checked"</#if> />
        <label for="rb-${propName?html}-2"><@s.text name='global.no'/></label>

    <#elseif ("java.util.Map" == className)>
        <#-- This block is a special case allowing dynamic content types to show up in the config form for a few widgets we provide in core, like RecentContentWidget and TagCloudWidget. -->
        <#if !remote>
            <@jive.dynObjWidgetProps map=propValue/>
        <#else>
            <@jive.remoteDynObjectWidgetProps props=propValue/>
        </#if>

    <#elseif ("java.lang.String" == className)>
        <#if (propName?lower_case?contains("password"))>
            <input type="password" autocomplete="off" name="${propName?html}" size="30" maxlength="150"
                   <#if propValue?has_content>value="${propValue?string?html}"</#if>/>
        <#elseif ("username" == propName?lower_case || "user" == propName?lower_case || "targetuser" == propName?lower_case)>
            <#if !remote>
                <div>
                    <input type="text" name="${propName?html}" id="editUserID${widgetFrame.ID?c}" size="40" role="combobox"
                           maxlength="255" class="jive-widget-edit-elem-url"/>
                </div>

                    <#include "/template/global/include/jive-macros.ftl" />
                <script type="text/javascript">
                    $j(document).ready(function() {
                        <#if propValue?has_content>
                            var startingUsers = <@userAutocompleteUsers user=action.toUserBean(propValue) />;
                            <#else>
                                var startingUsers = { users : [], userlists : [] };
                        </#if>
                        var autocomplete = new jive.UserPicker.Main({
                            startingUsers: startingUsers,
                            valueIsUsername:true,
                            $input : $j('#editUserID${widgetFrame.ID?c}')
                        });
                    });
                </script>
            </#if>
        <#else>
            <#if useRich>
                <#assign editorPanelGUID = StringUtils.randomString(6) />

                <textarea id="wysiwygtext-${editorPanelGUID?html}" name="${propName?html}" cols="40"
                      rows="6"><#if propValue?has_content>${action.getPropertyValueForRichText(propDescriptor)?html}</#if></textarea>

                <#-- Div containing the body textarea and controls -->
                <@resource.javascript file="/resources/scripts/jive/rte/FormAttachmentService.js" />
                <@resource.javascript file="/resources/scripts/jive/rte/ImageService.js" />
                <@resource.javascript file="/resources/scripts/jive/rte/LinkService.js" />
                <@resource.javascript file="/resources/scripts/jive/rte/FormService.js" />
                <@resource.javascript file="/resources/scripts/jive/rte/EntitlementService.js" />
                <@resource.javascript file="/resources/scripts/jive/rte/rte_wrap.js" />
                <@resource.javascript>
                    $j(function buildRTE() {
                        <#assign toggleDisplay><@s.text name="rte.toggle_display" /></#assign>
                        <#assign editDisabled><@s.text name="rte.edit.disabled" /></#assign>
                        <#assign editDisabledSummary><@s.text name="rte.edit.disabled.desc" /></#assign>
                        <#assign alwaysUse><@s.text name="post.alwaysUseThisEditor.tab" /></#assign>

                        var jiveControl = null,
                            imageService = null,
                            entitlementService = null,
                            formService = null;

                        require(['jive/model/control'], function(JiveModelController) {
                            jiveControl = new JiveModelController();
                        });

                        require(['jive/rte/EntitlementService'], function(JiveRTEEntitlementService) {
                            entitlementService = new JiveRTEEntitlementService({
                                objectID: ${widgetFrame.parentObject.ID?c},
                                objectType: ${widgetFrame.parentObject.objectType?c},
                                entitlement: "VIEW"
                            });
                        });

                        <#if imageContentResourceObject?? && JiveGlobals.getJiveBooleanProperty("formattedtext.images.enabled", true)>
                            require(['jive/rte/ImageService'], function(JiveRTEImageService) {
                                imageService = new JiveRTEImageService({
                                    objectId: -1,
                                    objectType: -1,
                                    containerId: ${widgetFrame.parentObject.ID?c},
                                    containerType: ${widgetFrame.parentObject.objectType?c}
                                });
                            });
                        </#if>

                        require(['jive/rte/FormService'], function(JiveRTEFormService) {
                            formService = new JiveRTEFormService({
                                $form: $j("#wysiwygtext-${editorPanelGUID?html}").closest("form"),
                                formSubmitHandler: function(){
                                    jivewidgetprops${widgetFrame.ID?c}.loadEditorValues();
                                    return false;
                                }
                            });
                        });

                        <#assign rteImagesEnabled = skin.template.imageEnabled />
                        if(typeof window._jive_images_enabled == 'undefined' || window._jive_images_enabled != <#if rteImagesEnabled>true<#else>false</#if>) {
                            window._jive_images_enabled=<#if rteImagesEnabled>true<#else>false</#if>;
                        }

                        var rte = new jive.rte.RTEWrap({
                            $element      : $j("#wysiwygtext-${editorPanelGUID?html}"),
                            controller    : jiveControl,
                            preset        : "widget",
                            shouldFloat   : true,
                            preferredMode : "${preferredEditorMode}",
                            startMode     : "${preferredEditorMode}",
                            mobileUI      : <#if rteDisabledBrowser>true<#else>false</#if>,
                            toggleText    : '${toggleDisplay?js_string}',
                            alwaysUseTabText  : '${alwaysUse?js_string}',
                            editDisabledText : '${editDisabled?js_string}',
                            editDisabledSummary : '${editDisabledSummary?js_string}',
                            communityName : '${SkinUtils.getCommunityName()?js_string}',
                            isEditing     : <#if propValue?has_content>true<#else>false</#if>,
                            images_enabled: window._jive_images_enabled || false,
                            pinToolbar    : false,
                            autoExpand    : true,
                            onReady       : function() {
                                var list = new jive.rte.RTEListener();
                                list.initFinished = function() {
                                    $j('#wysiwygtext-${editorPanelGUID?js_string}').data('rte', rte);
                                };
                                rte.addListener(list);
                            },
                            services      : {
                                imageService: imageService,
                                formService: formService,
                                entitlementService: entitlementService
                            }
                        });
                    });
                </@resource.javascript>
                <@resource.javascript id="widget-props" asyncOutput="true" depends="jive.rte"/>
            <#else>
                <#if (useLarge)>
                    <textarea name="${propName?html}" cols="40"
                          rows="6"><#if propValue?has_content>${propValue?html}</#if></textarea>
                <#else>
                    <#if propName == 'tags'>
                        <div class='j-form j-tag-form' id="tagForm${widgetFrame.ID?c}">
                            <@soy.render template="jive.tags.autocomplete.tagInput" data={"tags": propValue!?html} />
                            <@resource.javascript file="/resources/scripts/apps/tags/tags_controller.js" ajaxOutput=true />
                            <@resource.javascript>
                                $j(document).ready(function() {
                                    require(['apps/tags/tags_controller'], function(TagAutocomplete) {
                                        var auto = new TagAutocomplete($j('#tagForm${widgetFrame.ID?c}').find('.js-tag-input'), {
                                            containerType: jive.global.containerType,
                                            containerID: jive.global.containerID
                                        });
                                        auto.populate();
                                    });
                                });
                            </@resource.javascript>
                        </div>
                    <#else>
                    <input type="text" name="${propName?html}" size="40" class="jive-widget-edit-elem-url"
                           <#if (propValue?has_content)>value="${propValue?html}"</#if>/>
                    </#if>
                </#if>
            </#if>
        </#if>
    </#if>
</#macro>

<@resource.javascript output=true/>
</html>
