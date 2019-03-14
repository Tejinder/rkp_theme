<#assign isPopup = false/>
<#if (request.getParameter('isPopup')?exists)>
    <#assign isPopup = request.getParameter('isPopup')>
</#if>

<#if myLibraryList?? && (myLibraryList?size > 0)>

<script type="text/javascript">
    $j(document).ready(function(){
        $j("#search-box-form").show();
    });
    function removeDocument(id, title, fileName) {
        dialog({
            title: 'Confirm Delete',
            html: '<p>Are you sure you want to delete \"' + title + '\"?</p>',
            buttons:{
                "DELETE":function() {
                    confirmDelete(id, fileName);
                },
                "CANCEL": function() {
                    closeDialog();
                }
            }
        });

    }

    function confirmDelete(id, fileName) {
        $j.ajax({
            url: "<@s.url value='/synchro/my-library!removeDocument.jspa'/>",
            type: 'POST',
            data:  "id="+id+"&fileName="+fileName,
            success: onRemoveSuccess,
            error: onRemoveFailure
        });
		
    }
    function onRemoveSuccess(response, textStatus, jqXHR) {
        processPaginationRequest(currPage, "");
    }
    function onRemoveFailure(jqXHR, textStatus, errorThrown) {

    }


</script>


<table id="my-library-table" class="project_status_table table-sorter">
    <thead>
    <tr>
        <th id="title-header" class="file-title sortable"><span id="title">Title</span></th>
        <th id="description-header" class="file-description sortable"><span id="description">Description</span></th>
        <th id="file-name-header" class="file-name sortable"><span id="fileName">File</span></th>
        <th id="added-date-header" class="added-date sortable"><span id="addedDate">Added Date</span></th>
        <th id="file-size-header" class="file-size sortable"><span id="fileSize">File Size</span></th>
        <#if isPopup?string == 'false'><th id="remove-header" class="remove-action"></th></#if>
    </tr>
    </thead>
    <tbody>
        <#list myLibraryList as library>
        <tr <#if (library_index % 2) == 0> class="last"</#if>>

            <td><#if library.title??>${library.title}</#if></td>
            <td><#if library.description??>${library.description}</#if></td>
            <td><#if library.fileName??><#if library.fileDownloadLink??><a onClick="javascript:downloadLogs();" href="${library.fileDownloadLink}"><#else><a href="#"></#if>${library.fileName}</a></#if></td>
            <td><#if library.addedDate??>${library.addedDate?string("dd/MM/yyyy")}</#if></td>
            <td><#if library.fileSize??>${library.fileSize}</#if></td>
            <#if isPopup?string == 'false'><td align="center"><div class="remove-file" align="center"><input type="button" onclick="removeDocument(${library.id}, '${library.title}', '${library.fileName}')"></div></td></#if>
        </tr>

        </#list>
    </tbody>
</table>
<#else>
<script type="text/javascript">
    $j(document).ready(function(){
       
        if($j.trim($j("#library-search-box").val()) != "") {
            $j(".no-content").html("No results matching.");
        } else {
            $j("#search-box-form").hide();
        }
    });

</script>
<div class="no-content">There is no documents found in your library.</div>
</#if>

<#if pages?? && (pages > 1)>
<div id="pagination" <#if isPopup?string == 'true'>style="margin-top: -16px;"</#if>></div>
</#if>
<script type="text/javascript">
    <#if pages?? && (pages>0)>
    var pages = ${pages};
    <#else>
    var pages = 1;
    </#if>
	
function downloadLogs()
{
	
	<#assign i18CustomTextDownload><@s.text name="logger.project.document.download.text" /></#assign>	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYLIBRARY.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DOCUMENT.getId()}, "${i18CustomTextDownload}", "", -1, ${user.ID?c});
}	
</script>
<script src="${themePath}/js/pagination.custom.js" type="text/javascript"></script>
