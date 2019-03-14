<#include "/template/global/oracledocuments/oracledocuments-macros.ftl" />
<head xmlns="http://www.w3.org/1999/html">
    <script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>
    <script type="text/javascript">
        $j(document).ready(function(){
            tinymce.init({
                mode : "specific_textareas",
                selector: '#edittextarea',
                theme: "modern",
                menubar:false,
                plugins: [
                    "autoresize advlist autolink lists link image charmap print preview hr anchor pagebreak",
                    "searchreplace visualblocks visualchars code fullscreen",
                    "insertdatetime media nonbreaking save table contextmenu directionality",
                    "emoticons template paste textcolor colorpicker textpattern"
                ],
                toolbar1: "styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link forecolor backcolor | code"
            });
        });
        function showEditor() {
            $j("#edit-link").hide();
            $j("#save-link").show();
            $j("#cancel-link").show();
            $j(".oracle-documents-container .main-content").hide();
            $j("#editForm .mce-tinymce").show();
        }
        function closeEditor() {
            $j("#save-link").hide();
            $j("#cancel-link").hide();
            $j("#edit-link").show();
            $j("#editForm .mce-tinymce").hide();
            $j(".oracle-documents-container .main-content").show();
        }
        function saveEditorContent() {
            $j("#editForm").submit();
            closeEditor();
        }
    </script>

</head>

<div class="oracle-documents-container">
<@oracleDocumentsLeftSidePanel documentType=documentType/>
    <div class="middle-container">
    <#assign synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
    <#if (synchroPermHelper.isSynchroMiniAdmin(user) || synchroPermHelper.isSynchroAdmin(user))>
        <div>
            <a id="edit-link" href="javascript:void(0);" onclick="showEditor()" class="action-link">Edit</a>
            <a id="save-link" href="javascript:void(0);" onclick="saveEditorContent()" style="display: none;" class="action-link">Save</a>
            <a id="cancel-link" href="javascript:void(0);" onclick="closeEditor()" style="display: none;" class="action-link">Cancel</a>
        </div>
    </#if>
        <div class="main-content<#if documentType = 2> oracle-governance<#else> oracle-manuals</#if>">
        ${pageContent}
        </div>
        <form id="editForm" action="/oracledocuments/save-oracle-document.jspa">
        <#--<script type="text/javascript">-->
        <#--function onChange() {-->
        <#--$j("#pageContent").val("'"+$j("#edittextarea").html()+"'");-->
        <#--}-->
        <#--</script>-->
            <textarea id="edittextarea" name="pageContent" style="display: none" onchange="">${pageContent}</textarea>
        <#--<input type="hidden" name="pageContent" value="${pageContent?string}">-->
            <input type="hidden" name="documentType" value="${documentType}">
            <input type="hidden" name="page" value="${page}">
            <input type="hidden" name="redirectURL" value="${request.requestURL}">
        </form>
<#if showOwnedByPanel?? && showOwnedByPanel>
    <@oracleDocumentsOwnedByPanel documentType=documentType/>
</#if>
    </div>

</div>