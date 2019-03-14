<head>
    <script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/reporting-macros.ftl" />
<script type="text/javascript">
    var selectedCountries = [];
    function sortOptions(target){
        $j(target).find('option').sort(function(a, b){
            return a.value - b.value;
        }).appendTo($j(target)).parent().val('1');
    };

    function showApplyFilterPopup() {
        $j("#apply-filter-popup").lightbox_me({centered:true,closeEsc:false,overlayCSS:{background: 'black', opacity: .7}});
    }
    function closeApplyFilterPopup() {
        $j("#apply-filter-popup").trigger('close');
        //resetFilters();
    }


</script>

<div class="container">
<div class="project_view generate-report">
<div class="reports_dashboard_header">
    <h3>Select the report(s) required in excel</h3>
</div>
<#--<@reportTab activeTab=2 />-->
<div class="report-body">
    <a href="javascript:void(0);" onclick="showApplyFilterPopup()" class="apply-filters">Apply Additional Filters</a>
    
	<div class="region-inner showspendSelect__fix">
		<label class="label_b">Show Spend For</label>
		<@renderSelectSpendForOptions name='showSpendFor' multiselect=true/>
		<span id="showSpendFor-error" class="jive-error-message" style="display: none;">Please select the Show Spend For</span>
	</div>
	
	<div class="report-type region-inner">
        <label>Spend By</label>
        <div class="form-select_div left leftselectWrapper">
            <label>List of reports</label>
            <select size="18" name="listOfReports" id="listOfReports" class="listresportsSelect" multiple="yes">

            </select>
            <div class="action_buttons leftposition">
                <a id="report-type-reload-btn" href="javascript:void(0);"></a>
                <input id="report-type-add-btn" type="button" value='>>' class="left_arrow" />
                <input id="report-type-remove-btn" type="button" value='<<' class="right_arrow" />
            </div>
			<span id="report-type-selection-error" class="jive-error-message" <#if request.getParameter("reportTypeSelectionError")?? && request.getParameter("reportTypeSelectionError") == 'true'>style="display: block;"<#else>style="display: none;"</#if>>Please select the report(s) required in excel</span>
        </div>
        <div class="form-select_div_brand right rightmargin">
            <label>Selected reports</label>
            <select size="18" name="selectedReports" id="selectedReports" class="selectedReportsSelect"  multiple="yes" ></select>
           
			<label class="label-checkbox"><input id="crosstab" name="crosstab" type="checkbox"> Generate Crosstab</label>
			<span id="report-type-Second-selection-error" class="jive-error-message" style="display: none;">Please select at least two 'Spends By' reports to generate a crosstab </span>
        </div>
		 
		

        <script type="text/javascript">

            $j(function() {
                loadAllReports();
                $j("#report-type-add-btn, #report-type-remove-btn").click(function(event) {
                    var id = $j(event.target).attr("id");
                    var selectFrom = (id == "report-type-add-btn") ? "#listOfReports" : "#selectedReports";
                    var moveTo = (id == "report-type-add-btn") ? "#selectedReports" : "#listOfReports";
                    var selectedItems = $j(selectFrom + " :selected").toArray();
                    $j(moveTo).append(selectedItems);
                    sortOptions($j(moveTo));
                });
            });

            $j("#report-type-reload-btn").click(function() {
                loadAllReports();
            });
            function loadAllReports() {
                $j("#selectedReports").html('');
                $j("#listOfReports").html('')
            <#assign reportTypes = statics['com.grail.synchro.SynchroGlobal$SpendReportTypeNew'].values()/>
            <#if reportTypes?? && reportTypes?has_content>
                <#list reportTypes as reportType>
                    $j("#listOfReports").append("<option value='${reportType.getId()}'>${reportType.getName()}</option>");
                </#list>
            </#if>
            }
        </script>

		
		
    </div>


    <div class="report-year">
        <label>Budget Year</label>
        <div class="form-select_div left leftselectWrapper ">
        <#--<label>List of reports</label>-->
            <select size="5" name="listOfYears" id="listOfYears" multiple="yes" class="listresportsSelect">

            </select>
            <div class="action_buttons leftposition">
                <a id="year-reload-btn" href="javascript:void(0);"></a>
                <input id="year-add-btn" type="button" value='>>' class="left_arrow" />
                <input id="year-remove-btn" type="button" value='<<' class="right_arrow" />
            </div>
        </div>
        <div class="form-select_div_brand right rightmargin">
        <#--<label>Selected reports</label>-->
            <select size="5" name="selectedYears" id="selectedYears" class="selectedReportsSelect"  multiple="yes" ></select>
        </div>
		<span id="selectedYears-error" class="jive-error-message" style="display: none;">Please select the Budget Year</span>
        <script type="text/javascript">

            $j(function() {
                loadAllYears();
                $j("#year-add-btn, #year-remove-btn").click(function(event) {
                    var id = $j(event.target).attr("id");
                    var selectFrom = (id == "year-add-btn") ? "#listOfYears" : "#selectedYears";
                    var moveTo = (id == "year-add-btn") ? "#selectedYears" : "#listOfYears";
                    var selectedItems = $j(selectFrom + " :selected").toArray();
                    $j(moveTo).append(selectedItems);
                    sortOptions($j(moveTo));

                });
            });

            $j("#year-reload-btn").click(function() {
                loadAllYears();
            });
            function loadAllYears() {
                $j("#listOfYears").html('');
                $j("#selectedYears").html('');
                var now = new Date();
                var currYear = now.getFullYear();
                var minYear = Number("${JiveGlobals.getJiveProperty(statics['com.grail.synchro.SynchroConstants'].SYNCHRO_SPEND_REPORT_YEAR_FILTER_MIN, "2013")}");
                if(currYear < minYear) {
                    minYear = currYear;
                }
                var maxYear = currYear + 1;
                if(minYear > maxYear) {
                    minYear = currYear;
                }
                var numOfPrevYears = 10;
                for(var y = minYear; y <= maxYear; y++) {
                    $j("#listOfYears").append("<option value='" + y + "'>" + y + "</option>")
                }
            }
        </script>
    </div>
    <div class="report-currency showspendSelect__fix">
        <label>Currency</label>
    <@renderCurrenciesField name='spendReportCurrency' value=defaultCurrency disabled=false/>
    </div>
    <div class="generate-report-button buttons">
        <script type="text/javascript">
            $j(function(){
                var reportTypes = "";
                var years = "";
				var showSpendForTypes="";
                $j("#generate-report-form").submit(function(event){
                    reportTypes = "";
                    years = "";
					
					showSpendForTypes="";
                    $j("#report-type-selection-error").hide();
                    var self = this;
                    event.preventDefault();
                    var selectedReportTypesArr = [];
                    $j("#selectedReports").find('option').each(function(){
                        selectedReportTypesArr.push($j(this).val());
                    });
					var error = false;
                    if(selectedReportTypesArr.length > 0) {
                        reportTypes = selectedReportTypesArr.join(",");
                    } else {
                        $j("#report-type-selection-error").show();
                        error=true;
                    }

                    var selectedYearsArr = [];
                    $j("#selectedYears").find('option').each(function(){
                        selectedYearsArr.push($j(this).val());
                    });
                    if(selectedYearsArr.length > 0) {
                        years = selectedYearsArr.join(",");
						$j("#selectedYears-error").hide();
                    }
					else{
						$j("#selectedYears-error").show();
                        error=true;
					}
					
					
					if($j('#crosstab').prop('checked'))
					{
					       $j("#generateCrossTab").val("Yes");
					       //selectedReports
					        var  selectedReports= $j("#selectedReports");
	                     var selectedReportsSize = $j("#selectedReports option").size();
						 
						  if(selectedReportsSize<2)
						  {
						  
						   $j("#report-type-Second-selection-error").show();
						   
						   error=true;
						  }
						 else{
						     $j("#report-type-Second-selection-error").hide();
						 
						     }
						   
						  
						 
						 
					
					     
					   
					   
					   
					   
						
					}
					else{
					      
						$j("#generateCrossTab").val("No");
						$j("#report-type-Second-selection-error").hide();
					}
					
					
                    $j("#reportTypes").val(reportTypes);
                    $j("#years").val(years);
                    $j("#currencyId").val($j("#spendReportCurrency").val());
					
					/*var selectedShowSpendForArr = [];
					alert("SHOW SPEDN==>"+  $j("#showSpendFor").val());
                    $j("#showSpendFor").find('option').each(function(){
                        selectedShowSpendForArr.push($j(this).val());
                    });
                    if(selectedShowSpendForArr.length > 0) {
                        showSpendForTypes = selectedShowSpendForArr.join(",");
                    } else {
                        $j("#report-type-selection-error").show();
                        return;
                    }*/
					if($j("#showSpendFor").val()!=null && $j("#showSpendFor").val()!="")
					{
						$j("#spendForSnapshot").val($j("#showSpendFor").val());
						$j("#showSpendFor-error").hide();
					}
					else
					{
						 $j("#showSpendFor-error").show();
                         error=true;
					}
					if(error)
					{
					
						return false;
					}
                    self.submit();
                <#--<#assign i18CustomText><@s.text name="logger.project.report.generate.text" /></#assign>
                    SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].REPORTS.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].SPENDREPORTS.getId()}, "${i18CustomText}", "", -1, ${user.ID?c});-->

                });
            });
	// Amit CHnages Start
		
		$j("#showSpendFor").change(function()
			  {
			     if($j("#showSpendFor").val()!=undefined && $j("#showSpendFor").val()!="")
			        {
				    $j("#showSpendFor-error").hide();
				  }});
				  
				var checkhighlightedoption=0;  
			
				  
			  $j("#listOfReports").change(function()
			  {
			     checkhighlightedoption=1;
				 
				 
				 
			  });
			  
			  $j("#report-type-add-btn").click(function()
			  {
			  
			       if(checkhighlightedoption==1)
				     {
					 $j("#report-type-selection-error").hide();
					 
					 }
					 
					 
					 if(($j('#crosstab').prop('checked'))&& ($j("#selectedReports option").size() >=1 ))
				     {
					 $j("#report-type-Second-selection-error").hide();
					 
					 } 
					 
					 
				 if( (checkhighlightedoption==1) && ($j('#crosstab').prop('checked'))&& ($j("#selectedReports option").size() >=1 )) 	
                {
				 $j("#report-type-Second-selection-error").hide();
				}
				checkhighlightedoption=0;
				 });
			   
			   $j("#crosstab").click(function()
			   {
			      if($j('#crosstab').prop('checked'))
				  {}
				  else{
				  $j("#report-type-Second-selection-error").hide();
				  }
				  });   
				
				
				
				
					var checkhighlightedyearoption=0;
                $j("#listOfYears").change(function()
				{
				  
				   checkhighlightedyearoption=1;
				});
				
				$j("#year-add-btn").click(function()	
                 {
				 
				 if(checkhighlightedyearoption==1)
				   {
				   $j("#selectedYears-error").hide();
				   checkhighlightedyearoption=0;
				   }
				 });				
				
				/*$j("#selectedReports").change(function()
				{
				
				if($j('#crosstab').prop('checked') && $j("#selectedReports option").size() >=1  )
				{
				 $j("#report-type-Second-selection-error").hide();  
				}
				
				});
				*/
	// Amit Changes End
        </script>
        <form id="generate-report-form" action="<@s.url value="/new-synchro/downloadSpendReports.jspa"/>" method="post">
            <input type="hidden" id="reportTypes" name="reportTypes">
            <input type="hidden" id="years" name="years">
            <input type="hidden" id="regions" name="regions">
            <input type="hidden" id="countries" name="countries">
            <input type="hidden" id="marketTypes" name="marketTypes">
            <input type="hidden" id="currencyId" name="currencyId">
			<input type="hidden" id="spendForSnapshot" name="spendForSnapshot">
			<input type="hidden" id="budgetLocationsFilter" name="budgetLocationsFilter">
			<input type="hidden" id="methDetailsFilter" name="methDetailsFilter">
			<input type="hidden" id="brandsFilter" name="brandsFilter">
			<input type="hidden" id="generateCrossTab" name="generateCrossTab">
            <input type="submit" class="save" value="Download Report">
        </form>

    </div>
</div>
<div id="apply-filter-popup" style="display: none;" class="generate-report-filter-popup wellLayoutPop">

<div class="j-form-popup">
<a href="javascript:void(0);" class="close" onclick="closeApplyFilterPopup();"></a>
<div class="popup-title-overlay"></div>
<div class="pop-upinner-scroll">
 <div class="pop-upinner-content">
    <h3>Apply Additional Filters</h3>
<div class="wellLayoutform">
	
	<div class="region-inner">
		<label class="label_b">Methodology</label>
		<@renderSelectMethodologyDetails name='methDetailsSR' multiselect=true/>
	</div>
	
	
	<div class="region-inner">
		<label class="label_b">Branded/Non-branded</label>
		<@renderSelectBrandedNonBrandedField name='brandsSR' multiselect=true/>
	</div>
	
	<div class="region-inner">
		<label class="label_b">Budget Location</label>
		<@renderSelectBudgetLocationField name='budgetLocationsSR' multiselect=true/>
	</div>

</div>
<script type="text/javascript">
    function resetFilters() {
        
        
		$j('select[name="budgetLocationsSR"]').val('').trigger('chosen:updated');
		$j('select[name="methDetailsSR"]').val('').trigger('chosen:updated');
		$j('select[name="brandsSR"]').val('').trigger('chosen:updated');
		
		$j("#budgetLocationsFilter").val("");
        $j("#methDetailsFilter").val("");
        $j("#brandsFilter").val("");
        
    }

    function applyFilters() {
        
		if($j("#budgetLocationsSR").val()!=null && $j("#budgetLocationsSR").val()!="")
		{
			$j("#budgetLocationsFilter").val($j("#budgetLocationsSR").val());
		}
		if($j("#methDetailsSR").val()!=null && $j("#methDetailsSR").val()!="")
		{
			$j("#methDetailsFilter").val($j("#methDetailsSR").val());
		}
		if($j("#brandsSR").val()!=null && $j("#brandsSR").val()!="")
		{
			$j("#brandsFilter").val($j("#brandsSR").val());
		}
		
        closeApplyFilterPopup();
    }

    function cancelFilters() {
        resetFilters();
        closeApplyFilterPopup();
    }
</script>
<div class="buttons">
    <input type="button" value="Apply" class="apply" onclick="applyFilters();">
    <input type="button" value="Reset" class="reset" onclick="resetFilters()">
    <input type="button" value="Cancel" class="cancel" onclick="cancelFilters();">
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>

