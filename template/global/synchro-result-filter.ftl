<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#include "/template/global/include/reporting-macros.ftl" />
<#include "/template/global/include/synchro-macros.ftl" />

<div class="result-filter">
    <form id="result-filter-form" class="result-form-popup">
        <div class="project_dashboard_header">
            <h2>Advanced Search</h2>
            <a href="#" class="close-btn">Close</a>
        </div>	
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
		 <div id="project-date-filter" class="project_names_dates">
			<div class="project_start_date">
			<label>Start Date</label>
				<#--<@jiveform.datetimepicker id="startDateLog" name="startDateLog" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
				<@synchrodatetimepicker id="startDateLog" name="startDateLog" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
			</div>
			<label>End Date</label>
			<div class="project_complete_date">
				<#--<@jiveform.datetimepicker id="endDateLog" name="endDateLog" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
				<@synchrodatetimepicker id="endDateLog" name="endDateLog" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
			</div>
        </div>
		<#if !(projectID?? && (projectID>0))>
			<div id="project-brand-filter" class="form-select_div_main">
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
    <#elseif (kantarDashboardCatalogue?? && kantarDashboardCatalogue) || (grailDashboardCatalogue?? && grailDashboardCatalogue)>
        <div id="kantar-project-initiator-filter" class="form-select_div_main">
            <@renderKantarButtonProjectInitiatorsMultiselectField name='initiators' label='Owner' />
        </div>

        <div id="project-endmarket-filter" class="kantar form-select_div_main">
            <@showEndMarketReportFieldSection name='endMarkets' label='Market' />
        </div>

        <div id="kantar-methodology-filter" class="form-select_div_main">
            <@renderKantarButtonMethodologyMultiselectField name='methodologies' label='Methodology Type' />
        </div>

        <div id="kantar-delivery-date-filter" class="project_names_dates kantar-delivery-date-filter">
            <label class="delivery-date-label">Delivery Date</label>
            <div class="delivery_start_date">
                <label>From</label>
                <#--<@jiveform.datetimepicker id="deliveryDateFrom" name="deliveryDateFrom" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
				<@synchrodatetimepicker id="deliveryDateFrom" name="deliveryDateFrom" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
            </div>
            <div class="delivery_end_date">
                <label>To</label>
               <#-- <@jiveform.datetimepicker id="deliveryDateTo" name="deliveryDateTo" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/>-->
				<@synchrodatetimepicker id="deliveryDateTo" name="deliveryDateTo" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
            </div>
        </div>

        <div id="kantar-bat-contact-filter" class="form-select_div_main">
            <@renderKantarButtonProjectBATContactsMultiselectField name='batContacts' label='BAT Contact' />
        </div>

    <#elseif kantarReportDashboardCatalogue?? && kantarReportDashboardCatalogue>
        <div id="project-name-filter" class="project-filter-field">
            <label>Any of these words<span>(Search in Report Name)</span></label>
            <input type="text" name="reportName" value="" />
        </div>
        <div id="project-endmarket-filter" class="kantar form-select_div_main">
            <@showEndMarketReportFieldSection name='endMarkets' label='Country' isDocumentRepository=true/>
        </div>
        <div id="kantar-project-initiator-filter" class="form-select_div_main">
            <@renderKantarReportAuthorsMultiselectField name='authors' label='Author' />
        </div>
        <#if !request.getParameter("reportTypeId")?has_content>
         <#--<#else>-->
         <div id="kantar-project-initiator-filter" class="form-select_div_main">
             <@renderKantarReportTypeMultiselectField name='reportTypes' label='Report Type' />
         </div>
        </#if>


    <#else>
        <div id="project-name-filter" class="project-filter-field">
            <label>Any of these words<span><#if waiverCatalogue?? && waiverCatalogue>(Search in Waiver Name)<#else>(Search in Project Name)</#if></span></label>
            <input type="text" name="name" value="" />
        </div>
        <#if waiverCatalogue?? && waiverCatalogue>
            <div id="project-initiator-filter" class="form-select_div_main">
                <@renderSelectInitiatorField name='owner' label='Initiator' />
            </div>
        <#else>
            <div id="project-owner-filter" class="form-select_div_main">
                <@renderSelectOwnerField name='ownerfield' />
            </div>

            <div id="spi-contacts-filter" class="form-select_div_main">
                <@renderSelectSPIContactsField name='spiContacts' />
            </div>

            <div id="agencies-filter" class="form-select_div_main">
                <@renderSelectAgenciesField name='agencies' />
            </div>

            <div id="agency-names-filter" class="form-select_div_main">
                <@renderSelectAgencyNamesField name='agencyNames' />
            </div>


        </#if>

        <#if (waiverCatalogue?? && waiverCatalogue) || (pendingActivityCatalogue?? && pendingActivityCatalogue) || (statusCatalogue?? && statusCatalogue) || (reportcatalogue?? && reportcatalogue) || (historyCatalogue?? && historyCatalogue)>
            <div id="project-date-filter" class="project_names_dates">
                <div class="project_start_date">
                    <label>Year</label>
                    <div class="year">
                        <@renderReportYearField name='startYear'/>
                        <span class="jive-error-message" style="display:none;"></span>
                    </div>
                </div>
            </div>
        <#else>
            <div id="project-date-filter" class="project_names_dates">
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
        </#if>


        <div id="project-methodology-filter" class="form-select_div_main">
            <@showMethodologyFieldsSection name='methodologyFields' />
        </div>
        <div id="project-brand-filter" class="form-select_div_main">
            <@showBrandFieldsSection name='brandFields' />
        </div>


        <!--new filter field-->
        <div id="project-region-filter" class="form-select_div_main">
            <@showRegionFieldsSection name='regionFields'/>
        </div>
        <!--new filter field-->
        <div id="project-endmarket-filter" class="synchro form-select_div_main">
            <@showEndMarketReportFieldSection name='endMarkets' label='Country' />
        </div>

        <!--new filter field-->
    <#--<#if waiverCatalogue?? && waiverCatalogue>
             <div id="project-projectstatus-filter" class="form-select_div_main">
                 <@showProjectStatusSection name='projectStatusFields' label='Status' isadmin=adminUser?default(false) waiver=true />
             </div>
         <#elseif statusCatalogue?? && statusCatalogue>
             <div id="project-projectstatus-filter" class="form-select_div_main">
                 <@showProjectStatusSection name='projectStatusFields' label='Status' isadmin=adminUser?default(false) statusCatalogue=true />
             </div>
         <#elseif reportcatalogue?? && reportcatalogue>
             <div id="project-projectstatus-filter" class="form-select_div_main">
                 <@showProjectStatusSection name='projectStatusFields' label='Status' statusCatalogue=true />
             </div>
         <#else>
             <div id="project-projectstatus-filter" class="form-select_div_main">
                 <@showProjectStatusSection name='projectStatusFields' label='Status' isadmin=adminUser?default(false) />
             </div>
         </#if>
         -->
        <!--new filter field-->
        <div id="project-projectactivity-filter" class="form-select_div_main">
            <@showProjectActivitySection name='projectActivityFields' />
        </div>

        <!--new filter field-->
        <div id="project-projectsupplier-filter" class="form-select_div_main">
            <@showProjectSupplierSection name='projectSupplierFields' />
        </div>
    </#if>

        <!-- Sort Hidden Fields used in AJAX Server Requests-->
        <input type="hidden" name="sortField" id="sortField" value="${sortField?default('')}" />
        <input type="hidden" name="ascendingOrder" id="ascendingOrder" value="${ascendingOrder?default('0')}" />

        <div class="filter-btn">
            <input type="button" value="Reset" class="popup-search-reset" />
            <input type="button" value="Cancel" class="cancel" />
            <input type="button" value="Search" class="popup-search" />
        </div>
    </form>
</div>