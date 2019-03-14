<#include "/template/global/include/kantar-macros.ftl" />
<#include "/template/global/include/error-macros.ftl" />

<script type="text/javascript">
    $j(document).ready(function(){
        AjaxMultiPartForm.initialize($j("#kantar-report-upload-form"),onKantarReportUploadSuccess,onKantarReportUploadError,validationFunc);
    });

    function validationFunc() {
        clearErrorMessages();
        return true;
    }

    function onKantarReportUploadSuccess(response, textStatus, jqXHR) {
        var result = JSON.parse(response);
        if(result != undefined && result != null) {
            var data = result.data;
            if(data != undefined && data != null) {
                if(data.formInvalid && Boolean(data.formInvalid)) {
                    var msg = "";
                    if(data.reportNameError != undefined) {
                        $j("#report-name-error").show();
                        $j("#report-name-error").html(data.reportNameError);
                    } else {
                        $j("#report-name-error").hide();
                        $j("#report-name-error").html('');
                    }

                    if(data.countryError != undefined) {
                        $j("#country-error").show();
                        $j("#country-error").html(data.countryError);
                    } else {
                        $j("#country-error").hide();
                        $j("#country-error").html('');
                    }

                    if(data.reportTypeError != undefined) {
                        $j("#report-type-error").show();
                        $j("#report-type-error").html(data.reportTypeError);
                    } else {
                        $j("#report-type-error").hide();
                        $j("#report-type-error").html('');
                    }

                    if(data.otherReportTypeError != undefined) {
                        $j("#other-report-type-error").show();
                        $j("#other-report-type-error").html(data.otherReportTypeError);
                    } else {
                        $j("#other-report-type-error").hide();
                        //$j("#other-report-type-error").html('');
                    }

                    if(data.attachFileError != undefined) {
                        $j("#attachment-error").show();
                        $j("#attachment-error").html(data.attachFileError);
                    } else {
                        $j("#attachment-error").hide();
                        $j("#attachment-error").html('');
                    }
                    resizeUploadKantarReportPopup();
                    //showErrorMessage(msg);
                } else {
                    if(data.success) {
                        $j("#kantar-report-upload-popup").hide();
                        $j('#error-message').hide();
                        clearErrorMessage();
                        if(data.newReportType) {
                            $j(".result-form-popup #allKantarReportTypes").append("<option id='"+data.newReportType.id+"'>"+data.newReportType.name+"</option>")
                        }
                        if(window.location.href.indexOf("dashboard.jspa") > -1) {
                            processPaginationRequest(1,"");
                        }

                        dialog({
                            title:'Confirmation',
                            html:'<div style="text-align: center"><p>Your documents(s) has been successfully uploaded.<p><br/><p>Do you wish to add more files to this document?</p></div>',
                            buttons:{
                                "YES":function() {
                                    closeUploadKantarReportPopup();
                                    if(data.id) {
                                        showUploadKantarReportPopup(data.id);
                                        resizeUploadKantarReportPopup();
                                    }
                                },
                                "NO":function() {

                                    var url = "<@s.url value="/kantar-report/dashboard.jspa"/>";

                                    if(data.newReportType) {
                                        url +=  "?reportTypeId="+data.newReportType.id+"&otherType=true";
                                        window.location.href = url;
                                    } else {
                                        var selRtype = $j("#reportTypeSelection").val();
                                        var repType = -1;
                                    <#if request.getParameter("reportTypeId")??>
                                        repType = Number(${request.getParameter("reportTypeId")});
                                    </#if>
                                        if(repType == -1 || repType != selRtype) {
                                            url +=  "?reportTypeId="+selRtype+"&otherType=false";
                                            window.location.href = url;
                                        }
                                    }
                                    closeUploadKantarReportPopup();
                                }
                            }
                        })
                    }
                }
            }
        }
    }

    function onKantarReportUploadError(data, textStatus, errorThrown) {

    }

    function clearErrorMessages() {
        $j("#report-name-error").hide();
        $j("#report-name-error").html('');
        $j("#country-error").hide();
        $j("#country-error").html('');
        $j("#report-type-error").hide();
        $j("#report-type-error").html('');
        $j("#other-report-type-error").hide();
        //$j("#other-report-type-error").html('');
        $j("#attachment-error").hide();
        $j("#attachment-error").html('');
    }

    function clearReportNameError() {
        if($j("#reportName").val()) {
            $j("#report-name-error").hide();
            $j("#report-name-error").html('');
        }
    }

    function clearCountryError(target) {
        if($j(target).val()) {
            $j("#country-error").hide();
            $j("#country-error").html('');
        }
    }

    function clearReportTypeError(target) {
        if($j(target).val() > 0 ||  $j(target).val() == -100) {
            $j("#report-type-error").hide();
            $j("#report-type-error").html('');
        }

    }

    function clearOtherReportTypeError() {
        if($j("#otherReportType").val()) {
            $j("#other-report-type-error").hide();
            //$j("#other-report-type-error").html('');
        }
    }

    function clearAttachmentError() {
        $j("#attachment-error").hide();
        $j("#attachment-error").html('');
    }


</script>
<div >
    <h3><#if (newReport)>Upload<#else>View</#if> Document</h3>
    <form id="kantar-report-upload-form" action="<@s.url value="/kantar-report/upload-report!execute.jspa"/>" method="post" enctype="multipart/form-data">
    <#--<div id="error-message" class="error-message" style="display: none;"></div>-->
        <div class="form-field">
            <label class="label">Document Name<span>*</span></label>
            <div>
                <input type="text" id="reportName" name="reportName" size="30" maxlength="128" onchange="clearReportNameError()" <#if !(canEditReport || newReport)>readonly</#if>
                       class="form-text" placeholder="Document Name" <#if kantarReportBean?? && kantarReportBean.reportName??>value="${kantarReportBean.reportName}"</#if>>
                <span id="report-name-error" class="kantar-report-field-error" style="display: none;"></span>
            </div>
        <#--<@macroFieldErrors name="reportName" />-->
        </div>

        <div class="form-field">
            <label class="label">Country<span>*</span></label>
            <div>
                <select id="country" name="country" class="select_field markets" onchange="clearCountryError(this)" <#if !(canEditReport || newReport)>disabled</#if>>
                <#assign cId = -1/>
                <#if kantarReportBean?? && kantarReportBean.country??>
                    <#assign cId = kantarReportBean.country/>
                </#if>
                    <option value="-1" selected="true">-- None --</option>
                    <option value="-100" <#if cId?int = -100>selected="true"</#if>>Global</option>
                <#assign endmarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets()>
                <#assign endMarketKeySet = endmarkets.keySet() />
                <#if (endmarkets?has_content)>
                    <#list endMarketKeySet as key>
                        <#assign endmarket = endmarkets.get(key) />
                        <option value="${key?c}" <#if cId?int = key>selected="true"</#if>>${endmarket}</option>
                    </#list>
                </#if>
                </select>
                <span id="country-error" class="kantar-report-field-error" style="display: none;"></span>
            </div>

        </div>

        <div class="form-field">
            <label class="label">Document Type<span>*</span></label>
            <div>
                <script type="text/javascript">

                    function handleReportTypeSelection(target) {
                        clearReportTypeError(target);
                        var rVal = $j(target).val();
                        if(rVal == -100) {
                            $j("#otherReportType").show();
                            $j("#other-report-type-error").show();
//                            $j("#otherType").val("true");
                        } else {
                            $j("#otherReportType").hide();
                            $j("#otherReportType").val("");
                            $j("#other-report-type-error").hide();
//                            $j("#otherType").val("false");
                        }
                    }
                </script>
                <select id="reportTypeSelection" name="reportType" class="select_field reportType" onchange="handleReportTypeSelection(this)" <#if !(canEditReport || newReport)>disabled</#if>>
                <#assign rtId = -1/>
                <#if kantarReportBean?? && kantarReportBean.reportType??>
                    <#assign rtId = kantarReportBean.reportType/>
                <#elseif request.getParameter('reportTypeId')?? && request.getParameter('reportTypeId')?has_content>
                    <#assign rtId = request.getParameter('reportTypeId')?number/>
                <#--<option>${request.getParameter('reportTypeId')}</option>-->
                </#if>
                    <option value="-1" selected="true">-- None --</option>
                <#assign reportTypes =  statics['com.grail.kantar.util.KantarUtils'].getKantarReportTypes()>
                <#if (reportTypes?has_content)>
                    <#assign reportTypesSet = reportTypes.keySet() />
                    <#list reportTypesSet as key>
                        <#assign reportType = reportTypes.get(key) />
                        <option value="${key?c}" <#if rtId?int = key?int>selected="true"</#if>>${reportType}</option>
                    </#list>
                </#if>
                    <option value="-100">Other</option>

                </select>
                <span id="report-type-error" class="kantar-report-field-error" style="display: none;"></span>
            </div>
            <div>
                <input type="text" id="otherReportType" name="otherReportType" onchange="clearOtherReportTypeError()"
                       class="form-text" <#if rtId != -100>style="display: none;"</#if>>
                <span id="other-report-type-error" class="kantar-report-field-error" style="display: none;">Please enter the document type.</span>
            </div>
        </div>

        <div class="form-field">
            <label class="label">Author</label>
            <input type="text" id="authorName" name="authorName" class="form-text" disabled placeholder="Author Name" <#if authorName??>value="${authorName}"</#if>>
            <input type="hidden" id="createdBy" name="createdBy" <#if authorId??>value=${authorId}</#if>>
        </div>

        <div class="form-field comments">
            <label class="label">Comments</label>
            <textarea id="comments" name="comments" placeholder="Comments" <#if !(canEditReport || newReport)>readonly</#if>><#if kantarReportBean?? && kantarReportBean.comments??>${kantarReportBean.comments}</#if></textarea>
        </div>
        <div class="form-field attachments">
            <script type="text/javascript">
                $j("input[type=file]").bind("afterFileAttach", function(){
                    console.log("After file attach");
                    resizeUploadKantarReportPopup();
                });

                $j("input[type=file]").bind("afterFileRemove", function(){
                    console.log("After file remove");
                    resizeUploadKantarReportPopup();
                });

            </script>
<#if kantarReportBean?? && kantarReportBean.reportName??>
    <@kantarDocumentAttachements attachments=attachments canAttach=canAttach maxAttachCount=30 attachmentCount=attachmentCount  fromDocumentRepository=true objectName=kantarReportBean.reportName/>
<#else>
    <@kantarDocumentAttachements attachments=attachments canAttach=canAttach maxAttachCount=30 attachmentCount=attachmentCount  fromDocumentRepository=true />
</#if>

            <span id="attachment-error" class="kantar-report-field-error" style="display: none;"></span>
        </div>

        <input type="hidden" id="report-id" name="id" <#if id??>value="${id}"<#else>value="-1"</#if>>
    <#--<input type="hidden" id="otherType" name="otherType" <#if kantarReportBean.otherType??>value="${kantarReportBean.otherType?string}"<#else>value="false"</#if>>-->
    <#if (canEditReport || newReport)>
        <div class="buttons">
            <input type="submit" <#if id??>value="Save"<#else>value="Upload"</#if> class="save j-btn-callout">
            <input type="button" value="Cancel" class="cancel" onclick="closeUploadKantarReportPopup()">
        </div>
    </#if>

    </form>
</div>
