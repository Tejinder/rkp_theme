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
		<@financialReportsSubTab activeTab=2 />        
		<div class="project-data-extract">
		<div class="report-heading">
			<h2>Project Fields</h2>            
        </div>
		<form id="financial-data-extract" action="<@s.url value='financial-data-extract.jspa' />" method="POST">
			<div class="form-select_div_main">
				<@showProjectFieldSection name='projectDetailFields'/>
			</div>
			
			<div class="form-select_div_main">
				<@showEndMarketDetailFieldsSection name='endMarketDetailFields'/>
			</div>
			
			<div class="form-select_div_main">
				<@showCoordinationDetailFieldsSection name='coordinatingDetailFields'/>
			</div>
			
			<div class="form-select_div_main">
				<@showFinancialDetailFieldsSection name='financialDetailFields'/>
			</div>
			
			<div class="report-heading">
				<h2>Extract Filters</h2>            
			</div>		
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
					</div>
					<div class="month">
						<label>Month</label>
						<@renderReportMonthField  name='startMonth'/>
						
					</div>
				</div>

				<!-- Project Completion Year Month -->
				<div class="project_complete_date">
					<label>Project Completion</label>
					<div class="year">
						<label>Year</label>
						<@renderReportYearField name='endYear'/>
						
					</div>
					<div class="month">
						<label>Month</label>
						<@renderReportMonthField  name='endMonth'/>
						
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
			
			<div class="form-select_div_main">                
                <@showProductTypeFieldsSection name='productTypeFields' />                
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
	var cookie_name = "financial-data-report";
	var token = cookie_name+"-${user.ID?c}";

	$j("#form_submit").click(function() {
	$j("#report-token").val(token);
	$j("#report-token-cookie").val(cookie_name);
	cookieTimer(cookie_name, token);
	$j("#financial-data-extract").submit();
	});
</script>

