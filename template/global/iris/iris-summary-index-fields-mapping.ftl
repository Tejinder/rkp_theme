
<#assign indexFieldsList = statics['com.grail.util.BATUtils'].getAllIRISSummaryIndexFields() />	

<#assign openIndexFieldsList = statics['com.grail.util.BATUtils'].getOpenIRISSummaryIndexFields() />	




<div class="indexFieldMappingWrap">
<div class="container">
    <h3>IRIS Summary Index Fields Mapping</h3>
	
	
	<div class="qpr-div  qpr-container">
		<#if indexFieldsList?? && indexFieldsList?size gt 0>
			<#list indexFieldsList as indexField>
				
				<#if indexField.getMappedIndexFields()?? && indexField.getMappedIndexFields()?size gt 0>
					<div class="region-inner clearfix">
						<div class="three-column"><span>Index Field</span> <input type="text" size="40" tabindex="1" name="spendForDisabled" id="spendForDisabled" value="${indexField.getFieldName()}" disabled/> </div>
						
						<#assign mappedIndexFieldNames = "" />
						
						<#list indexField.getMappedIndexFields() as mappedIndexField>
							<#if statics['com.grail.util.BATUtils'].getAllIRISSummaryIndexFieldNames().get(mappedIndexField)?? >
								
									<#assign mappedIndexFieldNames = mappedIndexFieldNames + statics['com.grail.util.BATUtils'].getAllIRISSummaryIndexFieldNames().get(mappedIndexField) + " "  />
							</#if>	
						</#list>
						
						<div class="three-column"> <span>Mapped Index Fields</span> <input type="text" size="120" tabindex="1" name="budgetYearDisabled" id="budgetYearDisabled" value="${mappedIndexFieldNames}" disabled/> </div>
					
					
						<input type="button" value="Remove" id="firstRemove" onclick="deleteMapping('${indexField.getId()}');" class="remove deleteButtonAlignment">
					
					 </div>
					 
				</#if>	
					
			</#list>
		</#if>
	</div>
	
	<form id="indexFieldsMappingForm" name="indexFieldsMappingForm" action="/iris-summary/index-fields-mapping!execute.jspa" method="POST">
	
		<div class="region-inner clearfix">
		<div class="three-column">
			<label>Index Field</label>
			<select data-placeholder="" class="chosen-select" id = "indexField" name="indexField">
				<option value=""></option>
				
				<#list openIndexFieldsList as indexField>
					<option value="${indexField.getId()}"  >${indexField.getFieldName()}</option>
				</#list>
			</select>
		</div>
		<div class="three-column">
			<select data-placeholder="" class="chosen-select" id = "mappedIndexField" name="mappedIndexField" multiple>
				<option value=""></option>
				
				<#list openIndexFieldsList as indexField>
					<option value="${indexField.getId()}"  >${indexField.getFieldName()}</option>
				</#list>
			</select>
		</div>
		<div class="three-column alignSubmit">
			
			<input type="button" value="Submit" onclick="submitMappingFields();" class="btn-blue" />
			
		</div>
		</div>
	</form>
	
	<form id="indexFieldsMappingDeleteForm" action="/iris-summary/index-fields-mapping!deleteMapping.jspa" method="POST" class="result-form-popup ">
		<input type="hidden" name="deleteIndexFieldId" id="deleteIndexFieldId" value="" />			
	</form>
	
</div>
</div>



<script type="text/javascript">

function submitMappingFields()
{
	var indexFieldsMappingForm = $j("#indexFieldsMappingForm");
	indexFieldsMappingForm.submit();
}

function deleteMapping(indexFieldId)
{
	dialog({
			title:"Message",
			html:"<p>Are you sure that you would like to delete this Mapping?</p>",
			buttons:{
			"YES":function() {
				var indexFieldsMappingDeleteForm = $j("#indexFieldsMappingDeleteForm");
				$j("#deleteIndexFieldId").val(indexFieldId);
				indexFieldsMappingDeleteForm.submit();
			},
			"NO": function() {
				return false;
			}
		},

		});
				
	
	
}
</script>