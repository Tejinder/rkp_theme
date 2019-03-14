<div id="import-document-ie-popup" class="add-document-popup" style="display:none;">
	<div class="title">
		<h4>Import PIB Document</h4>
	</div>
	<a href="javascript:void(0);" class="close" onclick="closeImportPopup();"></a>
	<form id="import-ie-document-form" action="<@s.url value='/synchro/import-doc-ie-util!importDocument.jspa'/>"
		  method="post" enctype="multipart/form-data" name="import-ie-document-form">           
		<div class="form_divider">
			<input type="file" id="attachPIBTemplateIE" name="attachPIBTemplateIE"/>
		</div>
		<input type="hidden" id="fileTypeIE" name="fileTypeIE" />
		
		<input type="hidden" id="projectName" name="projectName" value="${project.name}" />
		<input type="hidden" id="projectID" name="projectID" value="${projectID?c}" />
		<input type="hidden" id="userID" name="userID" value="${user.ID?c}"/>
		
		<input type="hidden" id="importDocConfirmOptIE" name="importDocConfirmOptIE" value="0" />
		<div class="buttons">
			<input type="submit" value="Import" class="save">
			<input type="button" value="Cancel" class="cancel" onclick="closeImportPopup()">
		</div>
	</form>
</div>