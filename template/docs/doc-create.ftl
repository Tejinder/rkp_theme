<#assign isSpellCheckEnabled = JiveGlobals.getJiveBooleanProperty("skin.default.spellCheckEnabled", true)>
<#assign isInlineSpellEnabled = JiveGlobals.getJiveBooleanProperty("skin.default.inlineSpellCheckEnabled", false)>
<#assign isWikiTablesEnabled = WikiUtils.isWikiTableSyntaxEnabled(container)>
<#assign isWikiImagesEnabled = WikiUtils.isWikiImageSyntaxEnabled(container) && action.hasPermissionsToUploadImages()>
<#assign maxAttachCount = jiveContext.getAttachmentManager().getMaxAttachmentsPerDocument()>
<#assign isUserContainer = action.isUserContainer()>

<html>
<head>
<#if (edit)>
    <title><@s.text name="doc.edit_document.title" ><@s.param>${document.subject?html}</@s.param></@s.text></title>
<#else>
    <title><@s.text name="create.containable.document" /></title>
</#if>

    <meta name="nosidebar" content="true" />
    <meta name="noprint" content="true" />
    <meta name="asyncLoadRTE" content="false" />


<#-- Include global constants -->
    <script type="text/javascript">
        // required for some wiki - html & back conversions - defined in the posteditor.js file
        window.objectLookupSessionKey = "${statics['com.jivesoftware.community.action.DocCreateAction'].getDocumentSessionKey(document.documentID)}";
    </script>
<@resource.dwr file="DocCreate" />
<@resource.dwr file="Draft" />
<@resource.dwr file="WikiTextConverter" />
<@resource.dwr file="JiveSpellChecker" />

<@resource.javascript>
    var _editor_lang = "${displayLanguage}";
    var _jive_is_reply = false;
    var _jive_spell_check_enabled = "${isSpellCheckEnabled?string}";
    var _jive_gui_quote_text = "";
    var _jive_image_picker_url = "/doc-create!imagePicker.jspa?postedFromGUIEditor=true&containerType=${container.objectType?c}&container=${container.ID?c}&documentID=${document.documentID}";
    var _jive_video_picker__url = "?container=${container.ID?c}&containerType=${container.objectType?c}"
    var _jive_tables_enabled = ${isWikiTablesEnabled?string};
    var _jive_images_enabled = ${isWikiImagesEnabled?string};
</@resource.javascript>

<#if allowedToModifyApprovers>
    <#include "/template/docs/include/doc-javascript-collab.ftl" />
</#if> <#-- allowedToModifyApprovers -->

    <script type="text/javascript">

        function updateDocumentFromDraft(draft) {
            // dwr can't deserialize Image so just send along the image ID's
            draft.imageIDs = [];
            for (var i = 0; i < draft.images.length; i++) {
                draft.imageIDs[i] = draft.images[i].ID;
            }
            draft.images = [];

            DocCreate.updateImagesFromDraft(draft,
                    {
                        timeout: DWRTimeout, // 20 seconds
                        errorHandler: editorErrorHandler
                    });
        }

        function setSubmitText() {
            var approversExist = ${approvalRequired?string};
            var submitText = '${action.getText('doc.create.sbmtForApprvl.button'?js_string)}';
            var publishText = '${action.getText('doc.create.publish.button'?js_string)}';


            var approversExist = $j('input[name="documentApprovers"]').val() != '';
            if (approversExist) {
                $j('#postButton').val(submitText);
            }
            else {
                $j('#postButton').val(publishText);
            }
        }

    </script>

<@resource.javascript>
    $j(function() {
    $j("#jive-compose-categories input").change(function() {
    if ( $j(this).closest('span').hasClass('jive-category-highlight') ) {
    $j(this).closest('span').removeClass('jive-category-highlight');
    $j(this).closest('span').find('img').remove();
    }
    return true;
    });
    });


    function highlightCategory(theTag, theCategory) {
    var tag = ("#" + theTag);
    var category = ("#" + theCategory);
    if ( $j(category).is(":not(:checked)") && ($j(category).closest('span').hasClass('jive-category-highlight') == false) ) {
    $j(category).closest('span').toggleClass('jive-category-highlight', 300, function() {
    $j(category).closest('span').find('label').append("<img id='tags-tooltip' class='jive-icon-med jive-icon-help jiveTT-hover-suggest' alt='' src='<@s.url value='/images/transparent.png' />'/>");
    $j('#jive-tag2').text($j(theTag).text());
    $j('#jive-cat2').text($j(category).closest('span').find('label').text());
    });
    }
    return false;
    }
</@resource.javascript>

    <link rel="stylesheet" href="<@resource.url value='/styles/jive-compose.css'/>" type="text/css" media="all" />
    <link rel="stylesheet" href="<@resource.url value='/styles/jive-content.css'/>" type="text/css" media="all" />
<#if bridgingEnabled>
    <link rel="stylesheet" href="<@resource.url value='/styles/jive-bridges.css'/>" type="text/css" media="all" />
</#if>

<#if legacyBreadcrumb>
    <#if (edit)>

        <content tag="breadcrumb">
        <#-- it's critical to not remove the ignoreContextParams parameter - if you do, webwork/ognl
             will re set the parameters on the page level action as well, which will break things
             since the DocCreateAction modifies the body in the validate() call - which won't be
             called again after the params are reset
        -->
            <@s.action name="legacy-breadcrumb" executeResult="true" ignoreContextParams="true">
                <@s.param name="containerType" value="${container.objectType?c}" />
                <@s.param name="container" value="${container.ID?c}" />
            </@s.action>

            <a href="<@s.url value='/docs/${document.documentID}' />">
            ${document.subject?html}
            </a>
        </content>

    <#else>
        <content tag="breadcrumb">
        <#-- it's critical to not remove the ignoreContextParams parameter - if you do, webwork/ognl
             will re set the parameters on the page level action as well, which will break things
             since the DocCreateAction modifies the body in the validate() call - which won't be
             called again after the params are reset
        -->
        <@s.action name="legacy-breadcrumb" executeResult="true" ignoreContextParams="true">
            <@s.param name="containerType" value="${container.objectType?c}" />
            <@s.param name="container" value="${container.ID?c}" />
        </@s.action>
        </content>
    </#if>
</#if>
</head>
<body class="jive-body-formpage jive-body-formpage-document j-doc">

<!-- BEGIN main body -->

<div class="jive-create-doc jive-create-large jive-content doc-page clearfix">
<#-- Draft Exists Message-->
<#if (draftExists)>
<div id="autosave-prompt" class="jive-warn-box">
    <div>
        <span class="jive-icon-med jive-icon-warn"></span>
        <@s.text name="post.draft.draft_exists.info"><@s.param>${draft.modificationDate?datetime?string.medium_short}</@s.param></@s.text>
        <br />
        <input type="button" class="jive-description" name=" " value="<@s.text name="post.draft.useRcvrdDraft.button" />" onclick="autoSave.useDraft('updateDocumentFromDraft');return false;" />
        <input type="button" class="jive-description" name="deleteDraft" value="<@s.text name="post.draft.delRcvrdDraft.button" />" onclick="autoSave.deleteDraft(); return false;" />
    </div>
</div>
</#if>

<#-- Unpublished draft (for this version) exists message-->
<#if (document.documentState == enums['com.jivesoftware.community.DocumentState'].INCOMPLETE && edit)>
<div id="jive-wiki-state-message" class="jive-info-box">
    <div>
        <@s.text name="document.viewer.incomplete" />
    </div>
</div>
</#if>

<#-- Edit must be approved message-->
<#if moderationRequired?exists && moderationRequired>
<div id="jive-success-box" class="jive-success-box">
    <div>
        <span class="jive-icon-med jive-icon-check"></span>
        <@s.text name="doc.creaate.reply_must_be_apprvd.text"/>
    </div>
</div>
</#if>

<script type="text/javascript">
    function focusOnGUIEditor(callEvent) {
        var keycode = callEvent.keyCode;
        if (keycode == 9 && !callEvent.shiftKey) { // tab
            tinyMCE.execCommand("mceFocus", null, "wysiwygtext");
        }
    }
</script>

<#-- Some users were not added to this document as collaborators due to permissions -->
<#if (dissallowedUsers?exists && dissallowedUsers?size > 0)>
<div class="jive-warn-box">
    <div>
        <span class="jive-icon-med jive-icon-warn"></span>
        <@s.text name="doc.collab.err.no_perm.info" /><@s.text name="global.colon" />
        <ul>
            <#list dissallowedUsers as dissallowed>
                <li><@jive.userAvatar user=dissallowed/><@jive.userDisplayNameLink user=dissallowed/></li>
            </#list>
        </ul>
    </div>
</div>
</#if>

<#-- Invalid users added as collaborators-->
<#if (invalidUsers?exists && invalidUsers?size > 0)>
<div class="jive-warn-box">
    <div>
        <span class="jive-icon-med jive-icon-warn"></span>
        <@s.text name="doc.collab.err.usrsNtFound.text" /><@s.text name="global.colon" />
        <ul>
            <#list invalidUsers as invalid>
                <li>${invalid?html}</li>
            </#list>
        </ul>
    </div>
</div>
</#if>
<#include "/template/global/include/form-message.ftl"/>

<#-- Document Saved -->
<#if savedMsg>
<div id="jive-doc-savedMsg" class="jive-success-box">
    <div>
        <span class="jive-icon-med jive-icon-check"></span>
        <@s.text name="doc.create.yrChangesSaved.text"/>
    </div>
</div>
<script type="text/javascript">
    new Effect.Fade('jive-doc-savedMsg', { duration: 3.0 });
</script>
</#if>

<#-- "Edit Document blah in blah text-->
<header>
    <h2>
        <span class="jive-icon-big jive-icon-document"></span>
    <#if edit>
        <@s.text name="doc.edit_document.title" ><@s.param>${document.subject?html}</@s.param></@s.text>
    <#else>
        <@s.text name="create.containable.document" />
    </#if>
        <span class="details"><@s.text name="doc.create.in.label" />
        <#if action.isUserContainer(container)>
            <@s.text name="ctr.choose.myctr.document.header"/>
        <#else>
            <a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(container)}' includeParams='none'/>">${container.name?html}</a>
        </#if>
                </span>
    </h2>
    <span class="j-page-crease j-ui-elem"></span>
</header>


<#-- <form> tag declaration -->
<#if (!canAttach)>

    <#if (edit)>
    <form action="<@s.url value="/doc-edit.jspa"/>" method="post" name="postform" id="postform" onsubmit="return validatePost(true);" class="j-form">
    <#else>
    <form action="<@s.url value="/doc-create.jspa"/>" method="post" name="postform" id="postform" onsubmit="return validatePost(true);" class="j-form">
    </#if>

<#else>
    <#assign uploadInProgressLabel><@s.text name="doc.upload.in_progress.label"/></#assign>
    <#include "/template/global/include/upload-progress.ftl"/>
    <#if (edit)>
    <form action="<@s.url value="/doc-edit.jspa"/>" method="post" enctype="multipart/form-data" name="postform"
          id="postform" onsubmit="return validatePost(true);" class="j-form">
    <#else>

    <form action="<@s.url value="/doc-create.jspa"/>" method="post" enctype="multipart/form-data"
          name="postform" id="postform" onsubmit="return validatePost(true);" class="j-form">
    </#if>

</#if>

<input type="hidden" name="containerType" value="${container.objectType?c}" />
<input type="hidden" name="container" value="${container.ID?c}" />
<input type="hidden" name="postedFromGUIEditor" id="postTypeFlag" value="false" />


<@jive.token name="document.create.${document.documentID}" />

<#if (document?exists)>
<input type="hidden" name="documentID" value="${document.documentID}" />
<input type="hidden" name="edittedVersion" value="${edittedVersion?c}" />
<input type="hidden" name="startEditTime" value="${startEditTime?c}" />

    <#list document.images as image>
    <input type="hidden" name="imageFile" id="imageFile${image.ID?c}" value="${image.ID?c}" />
    </#list>
</#if>


<#if referencedContentObject?exists>
    <@s.text name="doc.create.thisDocWillRef.text" />
    <#if (referencedContentObject.getObjectType() == JiveConstants.DOCUMENT)>
        <@s.text name="global.document" />
    <#elseif (referencedContentObject.getObjectType() == JiveConstants.BLOGPOST)>
        <@s.text name="doc.create.blog_post.text" />
    <#elseif (referencedContentObject.getObjectType() == JiveConstants.THREAD)>
        <@s.text name="doc.create.thread.text" />
    </#if>
'${referencedContentObject.subject?html}'
</#if>



<#if (authentication.anonymous)>
<div id="jive-compose-anonymous" class="clearfix">
    <p>
        <label for="name01"><@s.text name="global.name" /><@s.text name="global.colon" /></label>
        <input type="text" name="name" size="30" maxlength="75" id="name01" value="${name!?html}"/>
    </p>

    <p>
        <label for="email01"><@s.text name="global.email" /><@s.text name="global.colon" /></label>
        <input type="text" name="email" size="30" maxlength="75" id="email01" value="${email!?html}"/>
    </p>
</div>
</#if>


<#--error message display -->
<div class="jive-error-message jive-error-box" id="dwr-error-table" style="display:none;">
    <div>
        <span class="jive-icon-med jive-icon-redalert"></span>
        <span class="jive-error-text" id="dwr-error-text"></span>
    </div>
</div>


<div class="jive-error-message jive-error-box" id="post-error-table" style="display:none;">
    <div id="post-error-subject" style="display:none;">
        <span class="jive-icon-med jive-icon-redalert"></span>
    <@s.text name="post.err.pls_enter_subject.text" />
    </div>
    <div id="post-error-body" style="display:none;">
    <@s.text name="doc.create.error_text.text" />
    </div>
    <div id="post-error-year-month" style="display:none;">
    <@s.text name="doc.create.error_year_na" />
    </div>
    <div id="post-error-month-year" style="display:none;">
    <@s.text name="doc.create.error_month_na" />
    </div>
</div>
<div id="jive-post-bodybox" class="jive-create-large">
<div id="jive-doc-corner-img"></div>

<p id="jive-compose-title">
    <label for="subject01" class="j-508-label"><@s.text name="global.subject" /><@s.text name="global.colon" /></label>
    <input type="text" name="subject" size="75" maxlength="255"  id="subject01"
           value="${subject!?html}"
    <#if (draftEnabled)>
           onchange="autoSave.messageChangeHandler()"
    </#if>
           onKeyDown="focusOnGUIEditor(event);">
</p>


<@macroFieldErrors name="subject"/>

<div class="jive-editor-panel jive-large-editor-panel">
    <textarea id='wysiwygtext' name="body" rows="15" cols="30" >${body!?html}</textarea>
<@macroFieldErrors name="textBody"/>
</div>

<#-- bridged content reply links -->
<#if (document?? && action.hasBridgedDiscussion(document))>
    <#assign actionUrl = "/doc-create!bridgedContentReply.jspa"/>
    <@jive.bridgedContentReply document container actionUrl false false true/>
</#if>

<#assign attachIterator = attachments>
<#if ((attachIterator.hasNext() && canAttach)|| (canAttach && maxAttachCount > 0))>

    <@macroFieldErrors name="attachFile" />

<div id="jive-add-attachment" class="clearfix">
    <div class="jive-attach-text">
        <span class="jive-compose-attach"><span class="jive-icon-med jive-icon-attachment"></span><@s.text name="post.attach_files.gtitle"/></span>
        <#if (canAttach)>
            <span id="jive-attach-maxsize" class="jive-compose-directions font-color-meta-light"><@s.text name="attach.maxSize.text" /><@s.text name="global.colon" /> ${statics['com.jivesoftware.util.ByteFormat'].getInstance().formatKB(jiveContext.attachmentManager.maxAttachmentSize)}
                , <#if (jiveContext.attachmentManager.allowAllByDefault)><#if (!jiveContext.attachmentManager.disallowedTypes.empty)><@s.text name="doc.create.flTypesNotAllwd.text" /><@s.text name="global.colon" />&nbsp;<#list jiveContext.attachmentManager.disallowedTypesAsFileExtensions as extension>${extension?html}<#if extension_has_next>, </#if></#list><#else><@s.text name="attach.allTypesAllowed.text" /></#if><#else><@s.text name="doc.create.flTypesAllowed.text" /><@s.text name="global.colon" />&nbsp;<#if (!jiveContext.attachmentManager.allowedTypes.empty)><#list jiveContext.attachmentManager.allowedTypesAsFileExtensions as extension>${extension?html}<#if extension_has_next><@s.text name="global.comma" />&nbsp;</#if></#list><#else><@s.text name="doc.create.noFlTypesAllwd.text" /></#if></#if>
                    </span>
        </#if>
        <span id="jive-attach-maxfiles" class="jive-compose-directions font-color-meta-light" style="display: none;"><@s.text name="post.attach_files_max.label"><@s.param>${maxAttachCount}</@s.param></@s.text></span>
    </div>

    <!-- This is where the multi file output will appear -->
    <div id="jive-file-list" class="jive-attachments">
        <#list attachIterator as attachment>

            <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                <#if !(attachment.properties['status']?exists && (attachment.properties['status'] == "queued" || attachment.properties['status'] == "blocked"))>
                <a
                    <#if edit>
                            href="<@s.url value="/servlet/JiveServlet/download/${document.ID?c}-${document.documentVersion.versionNumber?c}-${attachment.ID?c}/${attachment.name?url}" />"
                    <#else>
                            href="<@s.url value="/servlet/JiveServlet/download/${attachment.ID?c}/${attachment.name?url}" />"
                    </#if>
                            target="_new">
                </#if>
            ${attachment.name?html}
                <#if !(attachment.properties['status']?exists && (attachment.properties['status'] == "queued" || attachment.properties['status'] == "blocked"))>
                </a>
                </#if>
                (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})

                <#if (attachment.properties['status']?exists && attachment.properties['status'] == "blocked")>
                    <b style="color:red">BLOCKED</b>
                <#elseif (attachment.properties['status']?exists && attachment.properties['status'] == "queued")>
                    <b>QUEUED</b>
                </#if>
                <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="multi_selector.removeAttachment('jive-attachment-${attachment.ID?c}', ${attachment.ID?c});return false;"><@s.text name="global.remove" /></a>

            </div>
        </#list>

    </div>

    <#if (canAttach)>
        <a class="j-attachment-button j-btn-global">
            <span class="j-button-text"><@s.text name="global.choose_file" /></span>
            <label for="attachFile" class="j-508-label"><@s.text name="global.attachment" /><@s.text name="global.colon" /></label>
            <input type="file" id="attachFile" />
        </a>
    </#if>
</div>
</#if>

<!-- BEGIN compose section -->
<div class="jive-compose-section jive-compose-section-cats-tags clearfix">

<#if !action.isUserContainer(container)>
    <#assign objectTagSetIDs = action.getObjectTagSetIDs(document)>
    <#include "/template/global/include/category.ftl" />
</#if>

<@macroFieldErrors name="tags"/>

    <div id="jive-compose-tags">
                <span id="jive-compose-tags-container">

                    <h4><label for="jive-tags"><span class="jive-icon-med jive-icon-tag"></span>
                    <@s.text name="doc.create.tags.gtitle" /></label>
                        <span id="tag_directions" class="jive-compose-directions font-color-meta-light"><@s.text name="doc.create.spaceSeprtsTags.text" /></span>
                    </h4>

                    <div id="jive-compose-tags-form">

                        <input type="text" name="tags" size="65" id="jive-tags"
                               <#if (draftEnabled)>onchange="autoSave.messageChangeHandler()"</#if>
                               value="${tags!?html}" />

                        <ul class="autocomplete" id="jive-tag-choices"></ul>

                    <#if (popularTags?size > 0)>
                        <div id="jive-populartags-container">
                                <span>
                                    <strong><@s.text name="doc.create.popular_tags.gtitle" /><@s.text name="global.colon" /></strong>
                                    <#if container.objectType == JiveConstants.SOCIAL_GROUP>
                                        <@s.text name="document.editor.tags.group.popular.instructions" />
                                    <#elseif container.objectType == JiveConstants.PROJECT>
                                        <@s.text name="document.editor.tags.project.popular.instructions" />
                                    <#else>
                                        <@s.text name="document.editor.tags.popular.instructions" />
                                    </#if>
                                </span>
                            <div>
                                <#list popularTags as tag>
                                    <a name="populartag" rel="nofollow" href="#" onclick="swapTag(this); <#if !action.isUserContainer(container)>TagSet.highlightCategory('${tag?js_string?html}');</#if> return false;"
                                        <#if (tags?exists && ((tags.indexOf(' ' + tag + ' ') > -1) || (tags.startsWith(tag + ' ')) || (tags.endsWith(' ' + tag))))>
                                       class="jive-tagname-${tag?html} jive-tag-selected"
                                        <#else>
                                       class="jive-tagname-${tag?html} jive-tag-unselected"
                                        </#if>
                                            >${action.renderTagToHtml(tag)}</a>&nbsp;
                                </#list>
                            </div>
                        </div>
                    </#if>
                    </div>

                    <!-- NOTE: this include MUST come after the 'tags' input element -->
                <@resource.javascript file="/resources/scripts/tag-selector.js"/>
                </span>
    </div>

</div>
<!-- END compose section -->
<!-- Start Grail changes -->
<div id="grails-doc-props" style="overflow:hidden; width:100%; padding-bottom:10px;">
<@macroFieldErrors name="grails_doc_props"/>
<#if JiveGlobals.getJiveProperty('grail.countryList')?exists>
    <#assign countries = JiveGlobals.getJiveProperty('grail.countryList')?split(",") />
    <label style="float:left; padding-right:10px; font-weight:bold;">Country:</label>
    <select style="float:left; height:100px;" name="country" multiple="true">
        <option value="NA" <#if (country?exists && country.contains('NA')) || !(country?exists)> selected</#if>>NA</option>
        <#list countries as countryValue>
            <option value="${countryValue?string}" <#if country?exists && country?contains(countryValue)>selected="selected" </#if>>${countryValue}</option>
        </#list>
    </select>
<#else>
    <select style="float:left; height:100px;" name="country">
        <option value="NA">NA</option>
    </select>
</#if>

<#if JiveGlobals.getJiveProperty('grail.brandList')?exists>
    <#assign brands = JiveGlobals.getJiveProperty('grail.brandList')?split(",") />
    <label style="float:left; padding-right:10px; font-weight:bold;">Brand:</label>
    <select style="float:left; height:100px;" name="brand" multiple="true">
        <option value="NA" <#if (brand?exists && brand.contains('NA')) || !(brand?exists)> selected</#if>>NA</option>
        <#list brands as brandValue>
            <option value="${brandValue?string}" <#if brand?exists && brand.contains(brandValue)>selected="selected" </#if>>${brandValue}</option>
        </#list>
    </select>
<#else>
    <select style="float:left; height:100px;" name="brand">
        <option value="NA">NA</option>
    </select>
</#if>

<#if JiveGlobals.getJiveProperty('grail.methodologyList')?exists>
    <#assign methodologies = JiveGlobals.getJiveProperty('grail.methodologyList')?split(",") />
    <label style="float:left; padding-right:10px; font-weight:bold;">Methodology:</label>

    <select style="float:left; height:100px;" name="methodology" multiple="true">
        <option value="NA" <#if (methodology?exists && methodology.contains('NA')) || !(methodology?exists)> selected</#if>>NA</option>
        <#list methodologies as methodologyValue>
            <option value="${methodologyValue}" <#if methodology?exists && methodology.contains(methodologyValue)>selected="selected" </#if>>${methodologyValue}</option>
        </#list>
    </select>
<#else>
    <select style="float:left; height:100px;" name="methodology">
        <option value="NA" selected>NA</option>
    </select>
</#if>

<#if JiveGlobals.getJiveProperty('grail.periodMonth')?exists>
    <#assign months = JiveGlobals.getJiveProperty('grail.periodMonth')?split(",")  />
    <label style="float:left; padding-right:10px; font-weight:bold;">Period:</label>
    <select style="float:left;" name="month" id="month">
        <option value="NA" selected>NA</option>
        <#assign i=0 />
        <#list months as monthValue>
            <option value="${i}" <#if month?exists && i?string == month[0]>selected="selected" </#if>>${monthValue}</option>
            <#assign i = i+1 />
        </#list>
    </select>
<#else>
    <select style="float:left;" name="month">
        <option value="NA" selected>NA</option>
    </select>
</#if>

<#if JiveGlobals.getJiveProperty('grail.periodYear')?exists>
    <#assign years = JiveGlobals.getJiveProperty('grail.periodYear')?split(",") />
    <select style="float:left;" name="year" id="year">
        <option value="NA" selected>NA</option>
        <#list years as yearValue>
            <option value="${yearValue}" <#if year?exists && yearValue?trim == year[0]>selected="selected" </#if>>${yearValue}</option>
        </#list>
    </select>
<#else>
    <select style="float:left;" name="year">
        <option value="NA" selected>NA</option>
    </select>
</#if>

</div>

<!-- end system property fetch and display -->


<!-- End Grail Changes -->


<#include "/template/docs/include/doc-collab.ftl"/>



<#if edit>
<div>
    <input type="checkbox" name="minorEdit" value="true" id="jive-compose-minor-edit" <#if minorEdit>checked="CHECKED"</#if> />
    <strong>
        <label for="jive-compose-minor-edit"><@s.text name="doc.create.minor_edit.checkbox" /></label>
    </strong>
</div>
</#if>



<!-- upload progress meter for attachments -->
<div id="progressBar" style="display: none;">
    <div id="theMeter">
        <div id="progressBarText"></div>
        <div id="progressBarBox"><div id="progressBarBoxContent"></div></div>
    </div>
</div>

</div>
<div id="jive-compose-buttons">
    <div>
    <#if approvalRequired>
        <div id="approvers-text">
            <@s.text name='doc.create.approval.text' />
            <#list communityApprovers as communityApprover>
                <@jive.userDisplayNameLink user=communityApprover/>
            </#list>.
        </div>
        <#assign publishValue = action.getText('doc.create.sbmtForApprvl.button')/>
    <#else>
        <#assign publishValue = action.getText('doc.create.publish.button')/>
    </#if>
    <#if showPublishButton>
        <input class="j-btn-callout" type="submit"
               name="doPost"
               id="postButton"
               value="${publishValue}"
               style="font-weight: bold;"

                />
    </#if>
    <#if !rteDisabledBrowser>
        <input type="submit"
               name="method:postAndContinueEditing"
               value="<@s.text name='doc.create.svAndContinue.button' />"
               onclick="continuing = true;"

                />
    </#if>
        <input type="submit" id="draftButton"
               name="method:saveDraft"
        <#--<#if (authorshipPolicy == statics['com.jivesoftware.community.Document'].AUTHORSHIP_OPEN)>disabled=true</#if>-->
               value="<@s.text name='doc.create.save_draft.button' />"

                />

    <#if (draftEnabled)>
        <input type="hidden" name="draftid" id="draftid" value="0" />
        <input type="submit"
               name="method:cancel"
               value="<@s.text name='global.cancel' />"
               onclick="autoSave.doDiscard();"
                >
    <#else>
        <input type="submit"
               name="method:cancel"
               value="<@s.text name='global.cancel' />"
               onclick="cancelPost = true;"
                >
    </#if>
        <div id="autosave" class="jive-description"></div>
    </div>

</div>
</form>



<span class="j-doc-shadow j-left-doc-shadow j-ui-elem"></span>
<span class="j-doc-shadow j-right-doc-shadow j-ui-elem"></span>
</div>
<#if ((document.ID > 0) && ((document.authorCommentDelegator.commentCount > 0) || (document.commentDelegator.commentCount > 0)))>
    <#include "/template/global/include/comment-macros.ftl" />
    <@comments contentObject=document isPrintPreview=true/>
</#if>

<!-- END main body -->
<script language="JavaScript" type="text/javascript">

    <#if canAttach>

    <!-- Create an instance of the multiSelector class, pass it the output target and the max number of files -->
        <#assign globalRemove><@s.text name="global.remove" /></#assign>
    var multi_selector = new MultiSelector(document.getElementById('jive-file-list'), ${maxAttachCount?c}, ${attachmentCount?c}, '${globalRemove?js_string}');
    <!-- Pass in the file element -->
    multi_selector.addElement(document.getElementById('attachFile'));
        <#if (attachmentCount == 0)>
        $j('#jive-file-list').html('');
        <#else>
        $j('#jive-file-list').show();
        </#if>

    // loop though any files in the remove


    </#if>


    /*********************************************
     * autosave settings and initialization
     *********************************************/
    $j(function(){
    <#if (draftEnabled)>
        var draftEnabled = ${(!draftExists)?string};
    <#else>
        var draftEnabled = false;
    </#if>
        interval = ${jiveContext.draftManager.autosaveInterval?c};
        draftType = ${JiveConstants.DOCUMENT};
    <#if (edit)>
        objectType= ${JiveConstants.DOCUMENT};
        objectID = ${document.ID?c};
    <#else>
        objectType = ${container.objectType?c};
        objectID = ${container.ID?c};
    </#if>
        body = 'wysiwygtext';
        subject = 'subject01';
    <#if allowedToModifyApprovers>
        properties = ['authorshipPolicy', 'jive-tags', 'documentApprovers', 'documentAuthors', 'commentStatus'];
    <#else>
        properties = ['jive-tags'];
    </#if>
    <#if (document?exists && document.imageCount > 0)>
        images = [<#list document.images as image>'imageFile${image.ID?c}'<#if image_has_next>,</#if></#list>];
    <#else>
        images = [];
    </#if>
    <#assign globalUnsavedChangesText><@s.text name="global.unsaved_changes.text" /></#assign>
    <#assign docCreateSaveAndEditText><@s.text name="doc.create.save_and_edit.text" /></#assign>
    <#assign docCreateSaveAndEditText><@s.text name="doc.create.save_and_edit.text" /></#assign>
        confirmationMessage = '${globalUnsavedChangesText?js_string}';
        saveMessage  = '${docCreateSaveAndEditText?js_string}';
        savedMessage = '${docCreateSaveAndEditText?js_string}';
    <#if rteDisabledBrowser>
        window.autoSave = new DummyAutoSave(false);
    <#else>
        window.autoSave = new JiveAutoSave(draftEnabled, interval, draftType, objectType, objectID, body, subject, images, properties, confirmationMessage, saveMessage, savedMessage);
    </#if>


        /* hover effects on remove link */
        $j('.j-remove-file').hover(function() {
            $j(this).parent('div').addClass('remove-hover');
        }, function() {
            $j(this).parent('div').removeClass('remove-hover');
        })
    });
    /*********************************************
     * done setting up autosave
     *********************************************/

// Returns the value of the selected editing policy radio button.
    function getauthorshipPolicy() {
        return $j('[id^=editingPolicy]:checked').val() || '';
    }

    function setauthorshipPolicy(value) {
        $j('[id^=editingPolicy]').each(function() {
            if (this.value == value) {
                this.checked = true;
            }
        });
    }

    // Returns the value of the selected comment status radio button.
    function getcommentStatus() {
        return $j('[id^=commentStatus]:checked').val() || '';
    }

    function setcommentStatus(value) {
        $j('[id^=commentStatus]').each(function() {
            if (this.value == value) {
                this.checked = true;
            }
        });
    }

    function buildRTE(){
    <#assign toggleDisplay><@s.text name="rte.toggle_display" /></#assign>
    <#assign editDisabled><@s.text name="rte.edit.disabled" /></#assign>
    <#assign editDisabledSummary><@s.text name="rte.edit.disabled.desc" /></#assign>
    <#assign alwaysUse><@s.text name="post.alwaysUseThisEditor.tab" /></#assign>

    <#if (edit)>
        var objectType= ${JiveConstants.DOCUMENT};
        var objectID = ${document.ID?c};
        var entitlement = "VIEW";
    <#else>
        var objectType = ${container.objectType?c};
        var objectID = ${container.ID?c};
        var entitlement = "VIEW_CONTENT";
    </#if>

        var entitlementService = new jive.rte.EntitlementService({
            objectID: objectID,
            objectType: objectType,
            entitlement: entitlement
        });

        var imageService = new jive.rte.ImageService({
            contentResourceSessionKey: objectLookupSessionKey,
            objectId: "${document.documentID}",
            objectType: ${JiveConstants.DOCUMENT?c},
            containerId: ${container.ID?c},
            containerType: ${container.objectType?c}
        });

        var formService = new jive.rte.FormService({
            $form: $j("#wysiwygtext").closest("form")
        });

        var rte = new jive.rte.RTEWrap({
            $element      : $j("#wysiwygtext"),
            controller    : jiveControl,
            preset        : "wiki",
            autoSave      : window.autoSave,
            preferredMode : "${preferredEditorMode}",
            startMode     : "${preferredEditorMode}",
        mobileUI      : <#if rteDisabledBrowser>true<#else>false</#if>,
            toggleText    : '${toggleDisplay?js_string}',
            alwaysUseTabText  : '${alwaysUse?js_string}',
            editDisabledText : '${editDisabled?js_string}',
            editDisabledSummary : '${editDisabledSummary?js_string}',
            communityName : '${SkinUtils.getCommunityName()?js_string}',
        isEditing     : <#if (edit)>true<#else>false</#if>,
            services      : {
                imageService: imageService,
                formService: formService,
                entitlementService: entitlementService
            }
        });
        $j('#documentApprovers').change(setSubmitText).keyup(setSubmitText).blur(setSubmitText).focus(setSubmitText);


    <#if (authentication.anonymous)>
        document.postform.name.focus();
    <#else>
        document.postform.subject.focus();
    </#if>
    }
    $j(buildRTE);
</script>

<content tag="jiveTooltip">
    <div id="jiveTT-note-tags" class="jive-tooltip-help notedefault snp-mouseoffset" >
    <@s.text name="doc.create.tag_explained.info" />
    </div>

    <div id="jiveTT-note-suggest" class="jive-tooltip-help notedefault snp-mouseoffset"  >
        <div id="jive-note-category-suggestion-body">
            <strong>Suggested Category</strong>
        </div>
    </div>
</content>


</body>
</html>