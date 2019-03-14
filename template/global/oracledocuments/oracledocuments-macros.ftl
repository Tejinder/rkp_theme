<#macro oracleDocumentsLeftSidePanel documentType=1>
<div class="oracle-documents left-side-panel">
    <ul class="parent">
        <li class="parent">ORACLE</li>
        <ul class="child">
            <li<#if documentType = 1> class="active"</#if>><a href="<@s.url value="/oracledocuments/oracle-manuals!input.jspa"/>">ORACLE Toolkit & Manuals</a></li>
            <li class="last<#if documentType = 2> active</#if>"><a href="<@s.url value="/oracledocuments/oracle-governance!input.jspa"/>">ORACLE Governance</a></li>
        </ul>
    </ul>
</div>
</#macro>


<#macro oracleDocumentsOwnedByPanel documentType=1>
<script type="text/javascript">
    $j(document).ready(function(){
        tinymce.init({
            mode : "specific_textareas",
            selector: '#ownerPanelTextArea',
            theme: "modern",
            menubar:false,
            plugins: [
                "autoresize advlist autolink lists link image charmap print preview hr anchor pagebreak",
                "searchreplace visualblocks visualchars code fullscreen",
                "insertdatetime media nonbreaking save table contextmenu directionality",
                "emoticons template paste textcolor colorpicker textpattern"
            ],
            toolbar1: "styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link forecolor backcolor | code image inserttable",
            file_picker_callback: function(callback, value, meta) {
                    $j('#image_upload_form input').click()

            }
        });
        initializeAjaxForm();
    });
    function showOwnerPanelEditor() {
        $j("#owner-panel-edit-link").hide();
        $j("#owner-panel-save-link").show();
        $j("#owner-panel-cancel-link").show();
        $j(".oracle-documents-container .owner-panel-content").hide();
        $j("#ownerPanelEditForm .mce-tinymce").show();
    }
    function closeOwnerPanelEditor() {
        $j("#owner-panel-save-link").hide();
        $j("#owner-panel-cancel-link").hide();
        $j("#owner-panel-edit-link").show();
        $j("#ownerPanelEditForm .mce-tinymce").hide();
        $j(".oracle-documents-container .owner-panel-content").show();
    }
    function saveOwnerPanelEditorContent() {
        $j("#ownerPanelEditForm").submit();
        closeOwnerPanelEditor();
    }

    function initializeAjaxForm() {
        AjaxMultiPartForm.initialize($j("#image_upload_form"),onSuccess,onError);
    }

    function onSuccess(response, textStatus, jqXHR) {
        $j('#image_upload_form input').val("");
        var result = JSON.parse(response);
        if(result.data) {
            var data = result.data;
            if(data.imagePath) {
                top.$j('.mce-btn.mce-open').parent().find('.mce-textbox').val(data.imagePath);
                console.log("Hello");
            }
        }
    }

    function onError(data, textStatus, errorThrown) {
        $j('#image_upload_form input').val("");
        console.log("Failure");
    }
</script>
<div class="oracle-documents owner-panel">
    <#--<div class="image-container">-->
        <#--<#if documentType = 2>-->
            <#--<img src="<@s.url value="/oracledocuments/oraclegovernance/oracle-governance-owner.png"/>" alt="Owner">-->
        <#--<#else>-->
            <#--<img src="<@s.url value="/oracledocuments/oraclemanuals/oracle-manuals-owner.png"/>" alt="Owner">-->
        <#--</#if>-->
    <#--</div>-->

    <div class="edit-container">

            <#assign synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
            <#if (synchroPermHelper.isSynchroMiniAdmin(user) || synchroPermHelper.isSynchroAdmin(user))>
            <div class="edit-links">
                    <a id="owner-panel-edit-link" href="javascript:void(0);" onclick="showOwnerPanelEditor()" class="action-link">Edit</a>
                    <a id="owner-panel-save-link" href="javascript:void(0);" onclick="saveOwnerPanelEditorContent()" style="display: none;" class="action-link">Save</a>
                    <a id="owner-panel-cancel-link" href="javascript:void(0);" onclick="closeOwnerPanelEditor()" style="display: none;" class="action-link">Cancel</a>
            </div>
            </#if>

        <div class="owner-panel-content">
        ${ownerPanelContent}
        </div>
        <form id="ownerPanelEditForm" action="/oracledocuments/save-owner-content.jspa">
        <#--<script type="text/javascript">-->
        <#--function onChange() {-->
        <#--$j("#pageContent").val("'"+$j("#edittextarea").html()+"'");-->
        <#--}-->
        <#--</script>-->
            <textarea id="ownerPanelTextArea" name="ownerPanelContent" style="display: none" onchange="">${ownerPanelContent}</textarea>

        <#--<input type="hidden" name="pageContent" value="${pageContent?string}">-->
            <input type="hidden" name="documentType" value="${documentType}">
            <input type="hidden" name="page" value="${page}">
            <input type="hidden" name="redirectURL" value="${request.requestURL}">
        </form>
        <#--<iframe id="image_upload_form_target" name="image_upload_form_target" style="display:none"></iframe>-->
        <form id="image_upload_form" action="<@s.url value="/oracledocuments/upload-owner-image!updateOwnerImage.jspa"/>" method="post" enctype="multipart/form-data" style="width:0px;height:0;overflow:hidden">
            <input name="image" type="file" onchange="$j('#image_upload_form').submit();this.input='';">
        </form>
    </div>
</div>
</#macro>

