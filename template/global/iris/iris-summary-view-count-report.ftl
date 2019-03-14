<#include "/template/global/include/iris-macros.ftl" />
<div class="container">
    <h3>IRIS Summary View Count Report</h3>
	

	
	<form id="irisSummaryViewCountForm" name="irisSummaryViewCountForm" action="/iris-summary/downloadSummaryViewExtract!downloadReport.jspa" method="POST">
		<div class="qpr-div  qpr-container">
			
			Start Date <@irisdatetimepicker id="startDate" name="startDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false /> 
			End Date  <@irisdatetimepicker id="endDate" name="endDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false /> 
	
			
		</div>
	
		<div class="region-inner clearfix">
			<div class="three-column">
				<input type="button" value="Submit" onclick="submitForm();" class="btn-blue" />
			</div>
		</div>
	</form>
	
	
	
</div>
<script type="text/javascript">

function submitForm()
{
	var validationError = false;
	$j("form#irisSummaryViewCountForm .jive-error-message").each(function(){
		
		if($j(this).css("display") == "block" || $j(this).css("display") == "inline-block")
		{
		
			validationError = true;
			
		}
	});
	
	if(!validationError)
	{
		var irisSummaryViewCountForm = $j("#irisSummaryViewCountForm");
		irisSummaryViewCountForm.submit();
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
	

</script>