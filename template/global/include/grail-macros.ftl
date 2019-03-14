<#macro grailTabs id activeTab=1>
<div class="report-menus" xmlns="http://www.w3.org/1999/html">
    <ul class="project_name_menu">
        <li><a href="<@s.url value='/grail/brief-template!input.jspa?id=${id}'/>" <#if activeTab == 1>class="active"</#if>>Brief</a></li>
        <li><a href="<@s.url value='/grail/documents!input.jspa?id=${id}'/>" <#if activeTab == 2>class="active"</#if>>Upload Reports</a></li>
        <li><a href="<@s.url value='/grail/status!input.jspa?id=${id}'/>" <#if activeTab == 3>class="active"</#if>>Status</a></li>
    </ul>
</div>
</#macro>

<#-- Macro for Attachment Upload -->
<#macro grailDocumentAttachements attachments canAttach=false attachmentCount=0 maxAttachCount=30>
    <#if (attachments?? && (attachments?size>0)) || (maxAttachCount > 0) >

        <@macroFieldErrors name="attachFile" />
    <div id="jive-add-attachment" class="clearfix">
        <div class="kantr-attach-text">
            <span class="jive-compose-attach"><span class="jive-icon-med jive-icon-attachment"></span><#if canAttach><@s.text name="post.attach_files.gtitle"/><#else><@s.text name="post.attached_files.gtitle"/></#if></span>
            <#if (canAttach)>
                <span id="jive-attach-maxsize" class="jive-compose-directions font-color-meta-light"><@s.text name="attach.maxSize.text" /><@s.text name="global.colon" /> ${statics['com.jivesoftware.util.ByteFormat'].getInstance().formatKB(jiveContext.attachmentManager.maxAttachmentSize)}
                    , <#if (jiveContext.attachmentManager.allowAllByDefault)><#if (!jiveContext.attachmentManager.disallowedTypes.empty)><@s.text name="doc.create.flTypesNotAllwd.text" /><@s.text name="global.colon" />&nbsp;<#list jiveContext.attachmentManager.disallowedTypesAsFileExtensions as extension>${extension?html}<#if extension_has_next>, </#if></#list><#else><@s.text name="attach.allTypesAllowed.text" /></#if><#else><@s.text name="doc.create.flTypesAllowed.text" /><@s.text name="global.colon" />&nbsp;<#if (!jiveContext.attachmentManager.allowedTypes.empty)><#list jiveContext.attachmentManager.allowedTypesAsFileExtensions as extension>${extension?html}<#if extension_has_next><@s.text name="global.comma" />&nbsp;</#if></#list><#else><@s.text name="doc.create.noFlTypesAllwd.text" /></#if></#if>
                    </span>
            </#if>
            <span id="jive-attach-maxfiles" class="jive-compose-directions font-color-meta-light" style="display: none;"><@s.text name="post.attach_files_max.label"><@s.param>${maxAttachCount}</@s.param></@s.text></span>
        </div>


        <!-- This is where the multi file output will appear -->

        <div id="kantar-document-list" class="kantar-attachment-list jive-attachments">
            <#assign hasAttachments = false />

            <#list attachments as attachment>

                <#assign hasAttachments = true />
                <div id="jive-attachment-${attachment.ID?c}" class="kantar-attach-item jive-attach-item">
                    <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" download>
                    ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)})
                    </a>
                    <#if (canAttach)>
                        <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="multi_selector.removeAttachment('jive-attachment-${attachment.ID?c}', ${attachment.ID?c});return false;"></a>
                    </#if>
                </div>
            </#list>
            <#if !hasAttachments>
                <span style="font-style: italic;">No Attachments Found</span>
            </#if>

        </div>

        <#if (canAttach)>
            <a class="kantar-attachments-choose-btn j-attachment-button j-btn-global">
                <span class="j-button-text"><@s.text name="global.choose_file" /></span>
                <label for="attachFile" class="j-508-label"><@s.text name="global.attachment" /><@s.text name="global.colon" /></label>
                <input type="file" id="attachFile" />
            </a>
        </#if>
    </div>
    </#if>

    <#if canAttach>
    <script language="JavaScript" type="text/javascript">

        <!-- Create an instance of the multiSelector class, pass it the output target and the max number of files -->
            <#assign globalRemove><@s.text name="global.remove" /></#assign>
        var multi_selector = new MultiSelector(document.getElementById('kantar-document-list'), ${maxAttachCount?c}, ${attachmentCount?c}, '${globalRemove?js_string}');
        <!-- Pass in the file element -->
        multi_selector.addElement(document.getElementById('attachFile'));
            <#if (attachmentCount == 0)>
            jQuery('#kantar-document-list').html('');
            <#else>
            jQuery('#kantar-document-list').show();
            </#if>

        // loop though any files in the remove
    </script>

    </#if>

</#macro>



<#function generateGrailProjectCode projectID maxDigits=5 >
    <#if projectID?? && (projectID?number>0) >
        <#local length = (projectID?string)?length />
        <#local prependLen = (maxDigits - length) />
        <#local prepend = 'G' />
        <#if (length<maxDigits) >
            <#list 1..prependLen as x>
                <#local prepend = prepend + '0' />
            </#list>
        </#if>
        <#return (prepend + projectID?string)>
    </#if>
    <#return ''>
</#function>