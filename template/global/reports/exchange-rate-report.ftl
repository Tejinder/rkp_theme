<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/reporting-macros.ftl" />
<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<script src="${themePath}/js/cookie.js" type="text/javascript"></script>
<div class="container">
    <div class="project_view">
	<div class="reports_dashboard_header">
        <h2>Generate Reports</h2>
		<@reportTab activeTab=2 />		
	</div>
	<div class="project-report">
		<@financialReportsSubTab activeTab=4 />        
		<div class="project-data-extract">
		<div class="report-heading">
			<h2>Exchange Rate Report</h2>            
        </div>
		<form id="exchange-rate-report" action="<@s.url value='exchange-rate-report.jspa' />" method="POST">		
			<div class="report-dates">
				<!-- Project Start Year Month -->
				<div class="project_start_date">
					<label>Start Year</label>
					<div class="year">					
						<@renderReportYearField name='startYear'/>
						<span class="jive-error-message" style="display:none;"></span>						
					</div>
				</div>

				<!-- Project Completion Year Month -->
				<div class="project_complete_date">
					<label>End Year</label>
					<div class="year">						
						<@renderReportYearField name='endYear'/>
						<span class="jive-error-message" style="display:none;"></span>
					</div>					
				</div>
			</div>	
		<input type="hidden" id="report-token" name="token" value="" />
		<input type="hidden" id="report-token-cookie" name="tokenCookie" value="" />
		</form>
	</div>
	<div class="buttons">
		<a id="form_submit" href="javascript:void(0);" class="continue">EXTRACT</a>
	</div>
	</div>
	
	   
    </div>
</div>

<script type="text/javascript">
var token = "exchange-rate-report-${user.ID?c}";
var cookie_name = "exchange-rate-report";
	
	$j("#form_submit").click(function() {
	if(!validate())
	{
		$j("#report-token").val(token);
		$j("#report-token-cookie").val(cookie_name);	
		cookieTimer(cookie_name, token);
		$j("#exchange-rate-report").submit();
	}
	});
	
	function validate()
	{
		$j(".jive-error-message").each(function( index ) {
			$j(this).hide();
		});
		
		var startYear = $j('#startYear');		
		var endYear = $j('#endYear');
				
		var error = false;
		if(parseInt(startYear.val())!=-1 && parseInt(endYear.val())!=-1 && (startYear.val() > endYear.val()))
		{
			error = true;
			startYear.next().text("Start year can't be greater than the completion year.");
			startYear.next().show();		
		}		
	return error;
	}
</script>

