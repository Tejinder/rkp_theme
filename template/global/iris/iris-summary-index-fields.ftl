
<div class="container">
    <h3>IRIS Summary Index Fields</h3>
	
	<form id="indexFieldsForm" name="indexFieldsForm" action="/iris-summary/index-fields!execute.jspa" method="POST">
		<div class="qpr-div  qpr-container">
			<#if irisSummaryIndexFields?? && irisSummaryIndexFields?size gt 0>
				
				<div class="region-inner clearfix">
					<div class="three-column indexFieldHead">Index Field </div>
					<div class="three-column indexFieldHead">Weight </div>
					<div class="three-column indexFieldHead">Combined Weight </div>
					<div class="three-column indexFieldHead">Search Within </div>
					
				</div>
				
				<#list irisSummaryIndexFields as indexField>
					
					<div class="region-inner clearfix">
						<div class="three-column"><input class="indexNameField" type="text" tabindex="1" name="indexFieldName" id="indexFieldName" value="${indexField.getFieldName()}" disabled/> </div>
						<div class="three-column"> <input type="text" tabindex="1" class="numericfield" name="indexFieldWeight" id="indexFieldWeight_${indexField.getId()}" value="${indexField.getWeight()}" /> 
						<span class="jive-error-message full-width" id="indexFieldWeightError_${indexField.getId()}" style="display:none">Please enter Numeric value</span>
						</div>
						<#if statics['com.grail.util.BATUtils'].getIRISSummaryIndexFieldsTotalWeight()?? && statics['com.grail.util.BATUtils'].getIRISSummaryIndexFieldsTotalWeight() gt 0>
							<div class="three-column"> <input type="text" tabindex="1" name="combinedWeight" id="combinedWeight" value="${indexField.getWeight()/statics['com.grail.util.BATUtils'].getIRISSummaryIndexFieldsTotalWeight()}" disabled/> </div>
						<#else>
							<div class="three-column"> <input type="text" tabindex="1" name="combinedWeight" id="combinedWeight" value="0" disabled/> </div>
						</#if>	
						
						<input type="hidden" tabindex="1" name="indexFieldId" id="indexFieldId" value="${indexField.getId()}"/>
						
						<input type="checkbox" class="searchWithinCheckbox" name="searchWithInSelected_${indexField.getId()}" id="searchWithInSelected_${indexField.getId()}" <#if indexField.getIsSearchWithInField()?? && indexField.getIsSearchWithInField() > checked="true" </#if> class="remove deleteButtonAlignment" />
						<#-- <input type="button" value="Remove" id="firstRemove" onclick="deleteIndexField('${indexField.getId()}');" class="remove deleteButtonAlignment"> -->
					</div>
						
				</#list>
			</#if>
		</div>
	
		<div class="region-inner clearfix">
			<div class="three-column">
				<input type="button" value="Submit" onclick="submitIndexFields();" class="btn-blue" />
			</div>
		</div>
	</form>
	
	<form id="indexFieldsDeleteForm" action="/iris-summary/index-fields!deleteIndexField.jspa" method="POST" class="result-form-popup ">
		<input type="hidden" name="deleteIndexFieldId" id="deleteIndexFieldId" value="" />			
	</form>
	
</div>
<script type="text/javascript">

function submitIndexFields()
{
	var validationError = false;
	$j("form#indexFieldsForm .jive-error-message").each(function(){
		
		if($j(this).css("display") == "block" || $j(this).css("display") == "inline-block")
		{
		
			validationError = true;
			
		}
	});
	
	if(!validationError)
	{
		var indexFieldsForm = $j("#indexFieldsForm");
		indexFieldsForm.submit();
	}	

	
	
}

function isDecInteger(amount) {
    var numbers = /(^\d*(?:\.|\,)?\d*[0-9]+\d*$)|(^[0-9]+\d*(?:\.|\,)\d*$)/;
    if (amount.val().match(numbers)) {
        return true;
    } else {
        amount.focus();
        return false;
    }
}
	$j(".numericfield").change(function(event) {
		if($j(this).val() != "")
		{
		if (!isDecInteger($j(this))) {
			$j(this).next().show();
		}
		else
		{
			$j(this).next().hide();
		}
		}
	});
	
function deleteIndexField(indexFieldId)
{
	dialog({
			title:"Message",
			html:"<p>Are you sure that you would like to delete this Index Field?</p>",
			buttons:{
			"YES":function() {
				var indexFieldsDeleteForm = $j("#indexFieldsDeleteForm");
				$j("#deleteIndexFieldId").val(indexFieldId);
				indexFieldsDeleteForm.submit();
			},
			"NO": function() {
				return false;
			}
		},

		});
				
	
	
}
</script>