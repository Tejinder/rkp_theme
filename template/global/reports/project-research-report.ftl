<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/reporting-macros.ftl" />
<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<script src="${themePath}/js/cookie.js" type="text/javascript"></script>
<div class="container">
    <div class="project_view">
	<div class="reports_dashboard_header">
        <h2>Generate Reports</h2>
		<@reportTab activeTab=1 />
		
	</div>
	<div class="project-report">
		<@overallReportsSubTab activeTab=3 />        
		<div class="project-data-extract">
		<div class="report-heading">
			<h2>Research Cycle Report</h2>            
        </div>
		<form id="project-research-cycle" action="<@s.url value='project-research-report.jspa' />" method="POST">		
			<div class="report-select">
				<label>Workflow Type</label>
				<@renderWorkFlowType name='workflowType' />                
			</div>
			
			<div class="report-dates">
				<!-- Project Start Year Month -->
				<div class="project_start_date">
					<label>Project Start</label>
					<div class="year">
						<label>Year</label>
						<@renderReportYearField name='startYear'/>
						<span class="jive-error-message" style="display:none;"></span>						
					</div>
					<div class="month">
						<label>Month</label>
						<@renderReportMonthField  name='startMonth'/>
						<span class="jive-error-message" style="display:none;"></span>
					</div>
				</div>

				<!-- Project Completion Year Month -->
				<div class="project_complete_date">
					<label>Project Completion</label>
					<div class="year">
						<label>Year</label>
						<@renderReportYearField name='endYear'/>
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					<div class="month">
						<label>Month</label>
						<@renderReportMonthField  name='endMonth'/>
						<span class="jive-error-message" style="display:none;"></span>
					</div>
				</div>
			</div>
			<div class="form-select_div_main">
				<!-- Supplier Group-->
				 <div class="report-select-left">
					<label>Supplier Group</label>
					<@renderSupplierGroupField name='supplierGroup' />                
				</div>
				<!-- Supplier -->
				<div class="report-select-right">
					<label>Supplier</label>
					<@renderSupplierReportField name='supplier' />                
				</div>
			</div>
			
			<div class="form-select_div_main">
				<@showRegionFieldsSection name='regionFields'/>
			</div>
			
			<div class="form-select_div_main">
            <@showEndMarketReportFieldSection name='endMarkets' />
			</div>
			
			<div class="form-select_div_main">              
                <@showMethodologyFieldsSection name='methodologyFields' />                
            </div>
			
			<div class="form-select_div_main">       
                <@showBrandFieldsSection name='brandFields' />                
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
	var cookie_name = "project-research-report";
	var token = cookie_name+"-${user.ID?c}";    
	$j("#form_submit").click(function() {
	if(!validate())
	{
		$j("#report-token").val(token);
		$j("#report-token-cookie").val(cookie_name);
		cookieTimer(cookie_name, token);
		$j("#project-research-cycle").submit();
	}
	});
	
	function validate()
	{
		$j(".jive-error-message").each(function( index ) {
			$j(this).hide();
		});
		
		var startYear = $j('#startYear');
		var startMonth = $j('#startMonth');
		var endYear = $j('#endYear');
		var endMonth = $j('#endMonth');
		
		var error = false;
		if(parseInt(startYear.val())!=-1 && parseInt(endYear.val())!=-1 && (startYear.val() > endYear.val()))
		{
			error = true;
			startYear.next().text("Start year can't be greater than the completion year.");
			startYear.next().show();		
		}
	
		if(parseInt(startYear.val())!=-1 && parseInt(endYear.val())!=-1 && (parseInt(startYear.val()) == parseInt(endYear.val())))
		{
			if(parseInt(startMonth.val())!=-1 && parseInt(endMonth.val())!=-1 && (parseInt(startMonth.val()) > parseInt(endMonth.val())))
			{				
				error = true;	
				startMonth.next().text("Start month can't be greater than the completion month.");
				startMonth.next().show();
			}
		}
	return error;
	}	
</script>

