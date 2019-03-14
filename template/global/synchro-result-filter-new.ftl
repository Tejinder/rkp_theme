<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#include "/template/global/include/reporting-macros.ftl" />
<#include "/template/global/include/synchro-macros.ftl" />

<link rel="stylesheet" href="${themePath}/style/multi-select.css" type="text/css" media="all" />
<script src="${themePath}/js/synchro/second.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/autosearch2.js" type="text/javascript"></script>
<#assign synchroUserNames = statics['com.grail.synchro.util.SynchroPermHelper'].getSynchroUserNames() />

<script type="text/javascript">
     $j(document).ready(function() {
        //$j('.chosen-select').chosen();
		$j('.chosen-select').chosen({ allow_single_deselect: true });
        //$j('.chosen-select-deselect').chosen({ allow_single_deselect: true });
		$j(".chosen-search input").removeAttr("tabindex");
      });
	  
	  $j( function() {
		var arr = []; 
	
		<#if synchroUserNames?? >
			<#list synchroUserNames as usname >
			  <#if usname??>
				  var userName = "${usname}";
				  arr.push(userName);
			  </#if>
			</#list>
		</#if>   
		
	   $j("#projectManagerName").autocomplete({source: arr,select:function(){
		$j('.full-width .jive-error-message').hide(); }
	   });
	 });
    </script>



<script type="text/javascript">
       $j(document).ready(function() {
       
		$j('.chosen-select').chosen({ allow_single_deselect: true });
       
		
      });
	 function dateCompareFilter()
	{
		var startDateBegin = $j("input[name='startDateBegin']").val();
		var startDateComplete = $j("input[name='startDateComplete']").val();
		var endDateBegin = $j("input[name='endDateBegin']").val();
		var endDateComplete = $j("input[name='endDateComplete']").val();
		
		var creationDateBegin = $j("input[name='creationDateBegin']").val();
		var creationDateComplete = $j("input[name='creationDateComplete']").val();
		
		if(startDateBegin!=null && startDateBegin!="" && startDateComplete!=null && startDateComplete!="")
		{
			if(!compareDateFilter(startDateBegin, startDateComplete))
			{
			  
			 dialog({
					title:"Message",
					html:"<p>Please check the date you have selected and select the Project Duration correctly.</p>",
					buttons:{
					"OK":function() {
						$j("#startDateComplete").val('');
						return false;		
					}
				},

				});
			   error = true;
			}
		}
		if(endDateBegin!=null && endDateBegin!="" && endDateComplete!=null && endDateComplete!="")
		{
			if(!compareDateFilter(endDateBegin, endDateComplete))
			{
			  
			 dialog({
					title:"Message",
					html:"<p>Please check the date you have selected and select the Duration correctly.</p>",
					buttons:{
					"OK":function() {
						$j("#endDateComplete").val('');
						return false;		
					}
				},

				});
			   error = true;
			}
		}
		if(creationDateBegin!=null && creationDateBegin!="" && creationDateComplete!=null && creationDateComplete!="")
		{
			if(!compareDateFilter(creationDateBegin, creationDateComplete))
			{
			  
			 dialog({
					title:"Message",
					html:"<p>Please check the date you have selected and select the Project Duration correctly.</p>",
					buttons:{
					"OK":function() {
						$j("#creationDateComplete").val('');
						return false;		
					}
				},

				});
			   error = true;
			}
		}
	}
function dateCompareLogs()
	{
	 
	 var startDateLog = $j("input[name='startDateLog']").val();
		
		var endDateLog = $j("input[name='endDateLog']").val();
	 
	 if(endDateLog!=null && endDateLog!="" && startDateLog!=null && startDateLog!="")
		{
			if(!compareDateFilter(startDateLog, endDateLog))
			{
			  
			 dialog({
					title:"Message",
					html:"<p>Please check the date you have selected.</p><p>Project Start cannot be after to the Project End.</p>",
					buttons:{
					"OK":function() {
						$j("#endDateLog").val('');
						return false;		
					}
				},

				});
			   error = true;
			}
		}
	}
	function compareDateFilter(startDate, endDate)
	{
		if(DateParser.parse(startDate) <= DateParser.parse(endDate))
			return true;
		else
			return false;
	}
    </script>


<div class="result-filter new-filter">
 
<a href="javascript:void(0);" class="close" ></a>
<div class="popup-title-overlay"></div>
<div class="pop-upinner-scroll">
<form id="result-filter-form" class="result-form-popup">
				<div class="pop-upinner-content">
               
				
					
   
	<h3>Apply Filters</h3>
       
        
		<#if logDashboardCatalogue?? && logDashboardCatalogue>
			<#if (projectID?? && (projectID>0))>
				<div id="project-name-filter" class="project-filter-field">
						<label>Any of these words<span>(Search in Activity Description)</span></label>
						<input type="text" name="name" value="" />
				</div>
			<#else>
				<div id="project-name-filter" class="project-filter-field">
						<label>Any of these words<span>(Search in Project Name)</span></label>
						<input type="text" name="name" value="" />
				</div>
			</#if>
			<!-- Timestamp filter -->
			 <div id="project-date-filter" class="project_names_dates region-inner filter_label__fix">
				<div class="project_start_date">
				<label>Start Date</label>
					<#--<@jiveform.datetimepicker id="startDateLog" name="startDateLog" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
					<@synchrodatetimepicker id="startDateLog" name="startDateLog" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false dateCompareLogs=true/>
				</div>
				
				<div class="project_complete_date">
				<label>End Date</label>
					<#--<@jiveform.datetimepicker id="endDateLog" name="endDateLog" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
					<@synchrodatetimepicker id="endDateLog" name="endDateLog" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false dateCompareLogs=true/>
				</div>
			</div>
			<#if !(projectID?? && (projectID>0))>
				<div id="project-brand-filter" class="form-select_div_main ">
					<@showPortalFieldsSection name='portalFields' />
				</div>
			</#if>
			<#if !(projectID?? && (projectID>0))>
				<div id="project-brand-filter" class="form-select_div_main">
					<@showPageFieldsSection name='pageFields' />
				</div>
			</#if>
			<div id="project-brand-filter" class="form-select_div_main">
				<@showActivityFieldsSection name='activityFields' />
			</div>
		
		<#elseif processWaiverCatalogue?? && processWaiverCatalogue >

			<div id="project-name-filter" class="project-filter-field region-inner">
				<label>Initiator</label>
				<input type="text" id="projectManagerName" name="waiverInitiator" value="" placeholder="Enter Initiator" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter Initiator' "/>
			</div>
			
			
			<div id="project-date-filter" class="project_names_dates region-inner">
			<#--	<label>Initiator</label>
				<input type="text" name="Initiator" value="" placeholder="Enter Initiator" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter Project Initiator' "/>  -->
				<label>Date of Request</label>
				<div class="project_start_date">
					
					<div class="filter-dates">
					<label>Between</label>
					<div class="year">
						
					
						<@synchrodatetimepicker id="startDateBegin" name="startDateBegin" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false   dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					<div class="month">
						<label>And</label>
			
							<@synchrodatetimepicker id="startDateComplete" name="startDateComplete" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					</div>
				</div>
				<label>Date of Approval</label>
				<div class="project_complete_date">
					
					<div class="filter-dates">
					<label>Between</label>
					<div class="year">
						
						<@synchrodatetimepicker id="endDateBegin" name="endDateBegin" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=true  dateCompareFilter=true placeholder='Select Date' />
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					<div class="month">
						<label>And</label>
						<@synchrodatetimepicker id="endDateComplete" name="endDateComplete" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=true  dateCompareFilter=true placeholder='Select Date'/>
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					</div>
				</div>
			</div>
			
			<div class="region-inner">
				<div class="project-field">
					<label>Status</label>
					<@renderSelectProcessWaiverStatus name='waiverStatus' multiselect=true/>
					<span class="jive-error-message" style="display:none;"></span>
				</div>
			</div>
			
			<div class="region-inner">
					
				<label class="label_b">Research End market(s)</label>
				<@renderSelectEndMarkets name='researchEndMarkets' multiselect=true/>
			</div>
			
			<div class="region-inner">
				<label class="label_b">Branded/Non-branded</label>
				<@renderSelectBrandedNonBrandedField name='brands' multiselect=true/>
			</div>
		
		<#elseif ((methodologyWaiverCatalogue?? && methodologyWaiverCatalogue) || (agencyWaiverCatalogue?? && agencyWaiverCatalogue) || (pendingMethWaiverCatalogue?? && pendingMethWaiverCatalogue) || (pendingAgencyWaiverCatalogue?? && pendingAgencyWaiverCatalogue) || (pendingProcessWaiverCatalogue?? && pendingProcessWaiverCatalogue)) >
			
			<#if (methodologyWaiverCatalogue?? && methodologyWaiverCatalogue) || (agencyWaiverCatalogue?? && agencyWaiverCatalogue)>
				<div id="project-name-filter" class="project-filter-field region-inner">
					<label>Initiator</label>
					<input type="text"  id="projectManagerName" name="waiverInitiator" value="" placeholder="Enter Initiator" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter Project Initiator' "/>
				</div>
			</#if>	
			
			
			<div id="project-date-filter" class="project_names_dates region-inner">
				<div class="project_start_date">
					<label>Date of Request</label>
					<div class="filter-dates">
					<label>Between</label>
					<div class="year">
						
					
						<@synchrodatetimepicker id="startDateBegin" name="startDateBegin" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false   dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					<div class="month">
						<label>And</label>
			
							<@synchrodatetimepicker id="startDateComplete" name="startDateComplete" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					</div>
				</div>
				
				<#if (methodologyWaiverCatalogue?? && methodologyWaiverCatalogue) || (agencyWaiverCatalogue?? && agencyWaiverCatalogue)>
					<div class="project_complete_date">
						<label>Date of Approval</label>
						<div class="filter-dates">
						<label>Between</label>
						<div class="year">
							
							<@synchrodatetimepicker id="endDateBegin" name="endDateBegin" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=true  dateCompareFilter=true placeholder='Select Date' />
							<span class="jive-error-message" style="display:none;"></span>
						</div>
						<div class="month">
							<label>And</label>
							<@synchrodatetimepicker id="endDateComplete" name="endDateComplete" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=true  dateCompareFilter=true placeholder='Select Date'/>
							<span class="jive-error-message" style="display:none;"></span>
						</div>
						</div>
					</div>
				</#if>

				
			</div>
			
			
			<#if (pendingAgencyWaiverCatalogue?? && pendingAgencyWaiverCatalogue) || (pendingMethWaiverCatalogue?? && pendingMethWaiverCatalogue) || (pendingProcessWaiverCatalogue?? && pendingProcessWaiverCatalogue)>
				<div id="project-name-filter" class="project-filter-field region-inner">
					<label>Initiator</label>
					<input type="text" id="projectManagerName" name="waiverInitiator" value="" placeholder="Enter Initiator" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter Initiator' "/>
				</div>
			</#if>	
			
			<#if (pendingMethWaiverCatalogue?? && pendingMethWaiverCatalogue) >
			<#elseif (pendingAgencyWaiverCatalogue?? && pendingAgencyWaiverCatalogue) >
			<#elseif (pendingProcessWaiverCatalogue?? && pendingProcessWaiverCatalogue) >
			<#else>
				<div class="region-inner">
					<div class="project-field">
						<label>Status</label>
						<@renderSelectMethAndAgencyWaiverStatus name='waiverStatus' multiselect=true/>
						<span class="jive-error-message" style="display:none;"></span>
					</div>
				</div>
			</#if>
			
			<#if (agencyWaiverCatalogue?? && agencyWaiverCatalogue)>
				<div class="region-inner">
					<label class="label_b">Agency</label>
					<@renderSelectResearchAgency name='researchAgencies' multiselect=true/>
				</div>
				
				<div class="region-inner">
					<label class="label_b">Cost Component</label>
					<@renderSelectCostComponent name='costComponents' multiselect=true/>
				</div>
			</#if>
			<div class="region-inner">
					
				<label class="label_b">Research End market(s)</label>
				<@renderSelectEndMarkets name='researchEndMarkets' multiselect=true/>
			</div>
			
			<div class="region-inner">
				<label class="label_b">Methodology</label>
				<@renderSelectMethodologyDetails name='methDetails' multiselect=true/>
			</div>
		
			<div class="region-inner">
				<@projectBudgetYearFieldNew name="budgetYears"  multiselect=true/>
			</div>
			
		
		<#elseif (projectPendingActivityCatalogue?? && projectPendingActivityCatalogue) >
			<div class="region-inner">
				<div class="project-field">
					<label>Project Stage</label>
					<@renderSelectProjectStage name='projectStages' multiselect=true/>
					<span class="jive-error-message" style="display:none;"></span>
				</div>
			</div>
			
			<label>Creation Date</label>
			<div id="project-date-filter" class="project_names_dates region-inner">
				<div class="project_start_date">
					<div class="filter-dates">
					<label>Between</label>
					<div class="year">
						
					
						<@synchrodatetimepicker id="creationDateBegin" name="creationDateBegin" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					<div class="month">
						<label>And</label>
			
							<@synchrodatetimepicker id="creationDateComplete" name="creationDateComplete" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
				</div>
				
			</div>
			</div>
			
			
		<label>Project Duration</label>
			<div id="project-date-filter" class="project_names_dates project-adv-filter region-inner">
				<div class="project_start_date">
				<div class="filter-dates">
					<label>Started Between</label>
					<div class="year">
						
					
						<@synchrodatetimepicker id="startDateBegin" name="startDateBegin" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false   dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					<div class="month">
						<label>And</label>
			
							<@synchrodatetimepicker id="startDateComplete" name="startDateComplete" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
				  </div>
				</div>
				<div class="project_complete_date">
				<div class="filter-dates">
					<label>Ended   Between</label>
					<div class="year">
						
						<@synchrodatetimepicker id="endDateBegin" name="endDateBegin" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=true  dateCompareFilter=true placeholder='Select Date' />
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					<div class="month">
						<label>And</label>
						<@synchrodatetimepicker id="endDateComplete" name="endDateComplete" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=true  dateCompareFilter=true placeholder='Select Date'/>
						<span class="jive-error-message" style="display:none;"></span>
					</div>
				</div>
			</div>
			 </div>
			
			
			<div class="region-inner">
					
				<label class="label_b">Action Pending</label>
				<@renderSelectActionPending name='actionPendings' multiselect=true/>
			</div>
			
			
			<div id="project-name-filter" class="project-filter-field region-inner">
				<label>SP&I Contact</label>
				<input type="text"  id="projectManagerName" name="projManager" value="" placeholder="Enter SP&I Contact" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter SP&I Contact' "/>
			</div>
			
			<#--
			<div id="project-name-filter" class="project-filter-field region-inner">
				<label>Project Initiator</label>
				<input type="text"  id="projectManagerName" name="projectInitiator" value="" placeholder="Enter Project Initiator" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter Project Initiator' "/>
			</div>-->
			
			<div class="region-inner">
					
				<label class="label_b"><@s.text name="project.initiate.project.category"/></label>
				<@renderSelectCategoryType name='categoryTypes' />
			</div>
			
			<div class="region-inner">
					
				<label class="label_b">Research End market(s)</label>
				<@renderSelectEndMarkets name='researchEndMarkets' multiselect=true/>
			</div>
			
			<div class="region-inner">
				<label class="label_b">Methodology</label>
				<@renderSelectMethodologyDetails name='methDetails' multiselect=true/>
			</div>
			<div class="region-inner">
				<label class="label_b">Methodology Type</label>
				<@renderMethodologyField name='methodologyTypes' readonly=false multiselect=true/>
			</div>
		
			<div class="region-inner">
				<label class="label_b">Budget Location</label>
				<@renderSelectBudgetLocationField name='budgetLocations' multiselect=true/>
				
			</div>
		<#elseif (tpdDashboard?? && tpdDashboard) >	
			
			<label>Project Duration</label>
		<div id="project-date-filter" class="project_names_dates project-adv-filter region-inner">
				<div class="project_start_date">
					<div class="filter-dates">
					<label>Started Between</label>
					<div class="year">
						
					
						<@synchrodatetimepicker id="startDateBegin" name="startDateBegin" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false   dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					<div class="month">
						<label>And</label>
			
							<@synchrodatetimepicker id="startDateComplete" name="startDateComplete" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
				</div>
					</div>
				<div class="project_complete_date">
						<div class="filter-dates">
					<label>Ended Between</label>
					<div class="year">
						
						<@synchrodatetimepicker id="endDateBegin" name="endDateBegin" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=true  dateCompareFilter=true placeholder='Select Date' />
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					<div class="month">
						<label>And</label>
						<@synchrodatetimepicker id="endDateComplete" name="endDateComplete" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=true  dateCompareFilter=true placeholder='Select Date'/>
						<span class="jive-error-message" style="display:none;"></span>
							</div>
					</div>
				</div>
			</div>
			
			<label>Last TPD Submitted</label>
			<div id="project-date-filter" class="project_names_dates project-adv-filter region-inner">
				<div class="project_start_date">
					<div class="filter-dates">
					<label>Between</label>
					<div class="year">
						
					
						<@synchrodatetimepicker id="tpdSubmitDateBegin" name="tpdSubmitDateBegin" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false   dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					<div class="month">
						<label>And</label>
			
							<@synchrodatetimepicker id="tpdSubmitDateComplete" name="tpdSubmitDateComplete" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					</div>
				</div>
				
			</div>
			
			<div class="region-inner">
				<div class="project-field">
					<label>Project Stage</label>
					<@renderSelectProjectStage name='projectStages' multiselect=true/>
					<span class="jive-error-message" style="display:none;"></span>
				</div>
			</div>
			
			<div id="project-name-filter" class="project-filter-field region-inner">
				<label>SP&I Contact</label>
				<input type="text"  id="projectManagerName" name="projManager" value="" placeholder="Enter SP&I Contact" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter SP&I Contact' "/>
			</div>
			
			
			<div id="project-name-filter" class="project-filter-field region-inner">
				<label>Project Initiator</label>
				<input type="text" name="projectInitiator" value="" placeholder="Enter Project Initiator" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter Project Initiator' "/>
			</div>
			
			
			<div class="region-inner">
					
				<label class="label_b"><@s.text name="project.initiate.project.category"/></label>
				<@renderSelectCategoryType name='categoryTypes' />
			</div>
			
			
			<div class="region-inner">
				<div class="project-field">
					<label>TPD Status</label>
					<@renderTPDProjectStatus name='tpdStatus' multiselect=true/>
					<span class="jive-error-message" style="display:none;"></span>
				</div>
			</div>
			
			<div class="region-inner">
					
				<label class="label_b">Research End market(s)</label>
				<@renderSelectEndMarkets name='researchEndMarkets' multiselect=true/>
			</div>
			
			<div class="region-inner">
				<label class="label_b">Methodology</label>
				<@renderSelectMethodologyDetails name='methDetails' multiselect=true/>
			</div>
			<div class="region-inner">
				<label class="label_b">Methodology Type</label>
				<@renderMethodologyField name='methodologyTypes' readonly=false multiselect=true/>
			</div>
			<div class="region-inner">
				<label class="label_b">Branded/Non-branded</label>
				<@renderSelectBrandedNonBrandedField name='brands' multiselect=true/>
			</div>
			<div class="region-inner">
				<label class="label_b">Budget Location</label>
				<@renderSelectBudgetLocationTPDFilterField name='budgetLocations' multiselect=true/>
				
			</div>
			<div class="region-inner">
				<@projectBudgetYearFieldNew name="budgetYears"  multiselect=true/>
			</div>
			<div id="project-name-filter" class="project-filter-field region-inner">
				<label>Total Cost(GBP)</label>
				<div class="total-cost-field">
				Between
				<input class="totalCostBetween" type="text" name="totalCostStart" value="" />
				And
				<input class="totalCostAnd" type="text" name="totalCostEnd" value="" />
				</div>
			</div>
		
		<#else> 
		
			<#--<div class="region-inner">
				<div class="project-field">
					<label>Project Type</label>
					<@renderSelectProjectType name='projectTypes' multiselect=true/>
					<span class="jive-error-message" style="display:none;"></span>
				</div>
			</div>-->
			
			<div class="region-inner">
				<div class="project-field">
					<label>Project Status</label>
					<@renderSelectProjectStatus name='projectStatus' multiselect=true/>
					<span class="jive-error-message" style="display:none;"></span>
				</div>
			</div>
			
			<div class="region-inner">
				<div class="project-field">
					<label>Project Stage</label>
					<@renderSelectProjectStage name='projectStages' multiselect=true/>
					<span class="jive-error-message" style="display:none;"></span>
				</div>
			</div>
			
			<label>Project Duration</label>
			<div id="project-date-filter" class="project_names_dates project-adv-filter region-inner">
				<div class="project_start_date">
					<div class="filter-dates">
					<label>Started Between</label>
					<div class="year">
						
					
						<@synchrodatetimepicker id="startDateBegin" name="startDateBegin" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false   dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					<div class="month">
						<label>And</label>
			
							<@synchrodatetimepicker id="startDateComplete" name="startDateComplete" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					</div>
				</div>
				<div class="project_complete_date">
					<div class="filter-dates">
					<label>Ended Between</label>
					<div class="year">
						
						<@synchrodatetimepicker id="endDateBegin" name="endDateBegin" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=true  dateCompareFilter=true placeholder='Select Date' />
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					<div class="month">
						<label>And</label>
						<@synchrodatetimepicker id="endDateComplete" name="endDateComplete" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=true  dateCompareFilter=true placeholder='Select Date'/>
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					</div>
				</div>
			</div>
			
			<div id="project-name-filter" class="project-filter-field region-inner">
				<label>SP&I Contact</label>
				<input type="text" name="projManager"  id="projectManagerName" value="" placeholder="Enter SP&I Contact" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter SP&I Contact' "/>
			</div>
			
			<#--
			<div id="project-name-filter" class="project-filter-field">
				<label>Project Initiator</label>
				<input type="text" name="projectInitiator" value="" placeholder="Enter Project Initiator" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter Project Initiator' "/>
			</div>
			-->
			
			<div class="region-inner">
					
				<label class="label_b"><@s.text name="project.initiate.project.category"/></label>
				<@renderSelectCategoryType name='categoryTypes' />
			</div>
			
			<div class="region-inner">
					
				<label class="label_b">Research End market(s)</label>
				<@renderSelectEndMarkets name='researchEndMarkets' multiselect=true/>
			</div>
			<div class="region-inner">
				<label class="label_b">Agency</label>
				<@renderSelectResearchAgency name='researchAgencies' multiselect=true/>
			</div>
			<div class="region-inner">
				<label class="label_b">Methodology</label>
				<@renderSelectMethodologyDetails name='methDetails' multiselect=true/>
			</div>
			<div class="region-inner">
				<label class="label_b">Methodology Type</label>
				<@renderMethodologyField name='methodologyTypes' readonly=false multiselect=true/>
			</div>
			<div class="region-inner">
				<label class="label_b">Branded/Non-branded</label>
				<@renderSelectBrandedNonBrandedField name='brands' multiselect=true/>
			</div>
			<div class="region-inner">
				<label class="label_b">Budget Location</label>
				<@renderSelectBudgetLocationField name='budgetLocations' multiselect=true/>
				
			</div>
			<div class="region-inner">
				<@projectBudgetYearFieldNew name="budgetYears"  multiselect=true/>
			</div>
			<div id="project-name-filter" class="project-filter-field region-inner">
				<label>Total Cost(GBP)</label>
				<div class="total-cost-field">
				Between
				<input class="totalCostBetween" type="text" name="totalCostStart" onchange="onChangeTotalCost();" value="" />
				And
				<input class="totalCostAnd" type="text" name="totalCostEnd" onchange="onChangeTotalCost();" value="" />
				</div>
			</div>
		</#if>	
		
		
      

     
    

        <!-- Sort Hidden Fields used in AJAX Server Requests-->
        <input type="hidden" name="sortField" id="sortField" value="${sortField?default('')}" />
        <input type="hidden" name="ascendingOrder" id="ascendingOrder" value="${ascendingOrder?default('0')}" />
		
		<input type="hidden" id="downloadReportKeyword" name="downloadReportKeyword" value="">
		<input type="hidden" id="downloadReportPage" name="downloadReportPage" value="">
		<input type="hidden" id="downloadReportLimit" name="downloadReportLimit" value="">
		<input type="hidden" id="downloadReportType" name="downloadReportType" value="">
		
			<input type="hidden" id="budgetYearSelected" name="budgetYearSelected" value="">
			
			
		<input type="hidden" id="userTimezone" name="userTimezone" value="">	
		
		<input type="hidden" id="tileID" name="tileID" value="">	
		<input type="hidden" id="folderID" name="folderID" value="">	
		<input type="hidden" id="currPage" name="currPage" value="">
		<input type="hidden" id="sortBy" name="sortBy" value="">
		<input type="hidden" id="regionID" name="regionID" value="">
		<input type="hidden" id="endMarketID" name="endMarketID" value="">

        <div class="filter-btn clearfix">
           
            <input type="button" value="Cancel" class="cancel" />
			 <input type="button" value="Reset" class="popup-search-reset" />
            <input type="button" value="Apply" class="popup-search" />
        </div>
   
</div>
 </form>
</div>

</div>
