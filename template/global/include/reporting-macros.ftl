<#-- Reporting Secton Macros-->
<#-- Reports -->
<#macro reportTab activeTab=1>
<div class="report-menus" xmlns="http://www.w3.org/1999/html">
    <ul class="project_name_menu">
        <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
        <#--<#if (synchroPermHelper.hasGenerateReportAccess(user))>-->
            <#--<li><a href="<@s.url value='/synchro/raw-extract.jspa'/>" <#if activeTab == 1>class="active"</#if>>Raw Extract</a></li>-->
            <#--<li><a href="<@s.url value='/synchro/spend-reports.jspa'/>" <#if activeTab == 2>class="active"</#if>>Spend Reports</a></li>-->
        <#--</#if>-->
        <#if ((synchroPermHelper.isSynchroMiniAdmin(user) || synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isSynchroGlobalSuperUser(user))
           && !(synchroPermHelper.isExternalAgencyUser(user) || synchroPermHelper.isCommunicationAgencyUser(user)))>
            <li><a href="<@s.url value='/synchro/raw-extract.jspa'/>" <#if activeTab == 1>class="active"</#if>>Raw Extract</a></li>
        </#if>
        <#if ((synchroPermHelper.isSynchroMiniAdmin(user) || synchroPermHelper.isSynchroAdmin(user)
        || synchroPermHelper.isSynchroGlobalSuperUser(user) || synchroPermHelper.isSynchroRegionalSuperUser(user)
        || synchroPermHelper.isSynchroEndmarketSuperUser(user))
        && !(synchroPermHelper.isExternalAgencyUser(user) || synchroPermHelper.isCommunicationAgencyUser(user)))>
            <li><a href="<@s.url value='/synchro/spend-reports.jspa'/>" <#if activeTab == 2>class="active"</#if>>Spend Reports</a></li>
        </#if>
    </ul>
</div>
</#macro>

<#macro financialReportsSubTab activeTab=1>
<div class="report-sub-menus">
    <ul class="reportsub-menu">
        <li><a href="<@s.url value='financial-reports.jspa'/>" <#if activeTab == 1>class="active"</#if>>Project Financial Report</a></li>
        <li><a href="<@s.url value='financial-data-extract.jspa'/>" <#if activeTab == 2>class="active"</#if>>Finance Data Extract</a></li>
        <li><a href="<@s.url value='agency-evaluation-report.jspa'/>" <#if activeTab == 3>class="active"</#if>>Agency Evaluation Report</a></li>
        <li><a href="<@s.url value='exchange-rate-report.jspa'/>" <#if activeTab == 4>class="active"</#if>>Exchange Rate Report</a></li>
    </ul>
</div>
</#macro>

<#macro overallReportsSubTab activeTab=1>
<div class="report-sub-menus">
    <ul class="reportsub-menu">
        <li><a href="<@s.url value='reports.jspa'/>" <#if activeTab == 1>class="active"</#if>>Project Summary Report</a></li>
        <#if !(statics['com.grail.synchro.util.SynchroPermHelper'].isExternalAgencyUser() || statics['com.grail.synchro.util.SynchroPermHelper'].isCommunicationAgencyUser()) >
            <li><a href="<@s.url value='project-data-extract.jspa'/>" <#if activeTab == 2>class="active"</#if>>Project Data Extract</a></li>
        <#else>
            <li><a href="javascript:void(0);" class="disabled">Project Data Extract</a></li>
        </#if>
        <li><a href="<@s.url value='project-research-report.jspa'/>" <#if activeTab == 3>class="active"</#if>>Research Cycle Report</a></li>
    </ul>
</div>
</#macro>

<#-- Project field macro-->
<#macro showProjectFieldSection name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Project Details</#if></label>
    <@renderProjectFieldSection name='allProjectFields' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="projectfields-reload" href="javascript:void(0);"></a>
        <input id="addprojectfieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeprojectfieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addprojectfieldsBtn, #removeprojectfieldsBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addprojectfieldsBtn" ? "#allProjectFields" : "#projectDetailFields";
            var moveTo = (id == "addprojectfieldsBtn") ? "#projectDetailFields" : "#allProjectFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allProjectFields").sortOptions();
    });

    jQuery("#projectfields-reload").click(function() {
        jQuery("#projectDetailFields option").each(function()
        {
            jQuery("#allProjectFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allProjectFields").sortOptions();
        });
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<#macro renderProjectFieldSection name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allProjectFields'/>
    <#else>
        <#assign name = 'allProjectFields'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <option value="projectID">Project ID</option>
    <option value="name">Project Name</option>
    <option value="ownerID">Project Owner</option>
    <option value="startYear">Project Start Year</option>
    <option value="startMonth">Project Start Month</option>
    <option value="endYear">Project End Year</option>
    <option value="endMonth">Project End Month</option>
    <option value="projectType">Project Type</option>
    <option value="brand">Brand</option>
    <option value="methodologyGroup">Methodology Group</option>
    <option value="methodology">Methodology</option>
    <option value="researchType">Research Type</option>
    <option value="insights">Insights Priorities Project</option>
    <option value="npi">NPI Number</option>
    <option value="fwEnabled">Project Has Fieldwork</option>
    <option value="partialMethodologyWaiverRequired">Partial Methodology Waiver Required</option>
</select>
</#macro>

<#-- End Market Fields Macro-->

<#macro showEndMarketDetailFieldsSection name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>End-Market Details</#if></label>
    <@renderEndMarketDetailFieldsSection name='allEndMarketDetailFields' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="endmarketfields-reload" href="javascript:void(0);"></a>
        <input id="addendmarketfieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeEndMarketFieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addendmarketfieldsBtn, #removeEndMarketFieldsBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addendmarketfieldsBtn" ? "#allEndMarketDetailFields" : "#endMarketDetailFields";
            var moveTo = (id == "addendmarketfieldsBtn") ? "#endMarketDetailFields" : "#allEndMarketDetailFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allEndMarketDetailFields").sortOptions();
    });

    jQuery("#endmarketfields-reload").click(function() {
        jQuery("#endMarketDetailFields option").each(function()
        {
            jQuery("#allEndMarketDetailFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allEndMarketDetailFields").sortOptions();
        });
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<#macro renderEndMarketDetailFieldsSection name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allProjectFields'/>
    <#else>
        <#assign name = 'allProjectFields'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <option value="startYear">Fieldwork Start Year</option>
    <option value="startMonth">Fieldwork Start Month</option>
    <option value="endYear">Report Completion Year</option>
    <option value="endMonth">Report Completion Month</option>
    <option value="interviews">Number of Interviews</option>
    <option value="focusGroups">Number of Focus Groups</option>
    <option value="waves">Number of Waves</option>
    <option value="cells">Number of Cells</option>
    <option value="dataCollectionMethod">Data Collection Method</option>
    <option value="partialMethodologyWaiverRequired">Partial Methodology Waiver Required?</option>
    <option value="methodologyRationale">Methodology Rationale</option>
    <option value="oracleApprover">Oracle Approver</option>
    <option value="approved">Approved</option>
    <option value="oracleApproverComment">Oracle Approver Comments</option>
    </option>
</select>
</#macro>

<#-- Coordination details -->
<#macro showCoordinationDetailFieldsSection name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Coordinating Details</#if></label>
    <@renderCoordinationDetailFieldSection name='allCoordinatingdetailFields' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="coordinatingFields-reload" href="javascript:void(0);"></a>
        <input id="addcoordinatingFieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeCoordinatingFieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addcoordinatingFieldsBtn, #removeCoordinatingFieldsBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addcoordinatingFieldsBtn" ? "#allCoordinatingdetailFields" : "#coordinatingDetailFields";
            var moveTo = (id == "addcoordinatingFieldsBtn") ? "#coordinatingDetailFields" : "#allCoordinatingdetailFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allCoordinatingdetailFields").sortOptions();
    });

    jQuery("#coordinatingFields-reload").click(function() {
        jQuery("#coordinatingDetailFields option").each(function()
        {
            jQuery("#allCoordinatingdetailFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allCoordinatingdetailFields").sortOptions();
        });
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<#macro renderCoordinationDetailFieldSection name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allCoordinatingdetailFields'/>
    <#else>
        <#assign name = 'allCoordinatingdetailFields'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <option value="supplier">Supplier</option>
    <option value="name">Supplier Group</option>
    <option value="createDate">Coordination Created Date</option>
    <option value="lastUpdated">Coordination Last Updated Date</option>
    <option value="fwSupplier">Fieldwork Supplier</option>
    <option value="fwSupplierGroup">Fieldwork Supplier Group</option>
    <option value="fwEndMarket">Fieldwork End-Market</option>
    <option value="tenderingAgencyID">Tendering Agency</option>
    <option value="bidValue">Bid Value</option>
    <option value="marketType">Market Type</option>
    <option value="collectionMethod">Data Collection Method</option>
    <option value="fwCancelled">Fieldwork Cancelled</option>
</select>
</#macro>

<#--Financial Details Filter -->
<#macro showFinancialDetailFieldsSection name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Financial Details</#if></label>
    <@renderFinancialDetailFieldSection name='allFinancialDetailFields' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="financialDetailFields-reload" href="javascript:void(0);"></a>
        <input id="addFinancialDetailFieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeFinancialDetailFieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addFinancialDetailFieldsBtn, #removeFinancialDetailFieldsBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addFinancialDetailFieldsBtn" ? "#allFinancialDetailFields" : "#financialDetailFields";
            var moveTo = (id == "addFinancialDetailFieldsBtn") ? "#financialDetailFields" : "#allFinancialDetailFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allFinancialDetailFields").sortOptions();
    });

    jQuery("#financialDetailFields-reload").click(function() {
        jQuery("#financialDetailFields option").each(function()
        {
            jQuery("#allFinancialDetailFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allFinancialDetailFields").sortOptions();
        });
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<#macro renderFinancialDetailFieldSection name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allFinancialDetailFields'/>
    <#else>
        <#assign name = 'allFinancialDetailFields'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <option value="budgetApprover">Budget Approver</option>
    <option value="holderLocation">Budget Holder Location</option>
    <option value="holderFunction">Budget Holder Function</option>
    <option value="budgetYear">Budget Year</option>
    <option value="prePlanDetails">Pre-Plan Details</option>
    <option value="budgetDetails">Budget Details</option>
    <option value="forecastDetails">Forecast Details</option>
    <option value="actuals">Actuals</option>

</select>
</#macro>

<#-- Workflow Type DropDown-->
<#macro renderWorkFlowType name='' value=0 multiselect=false readonly=false>
    <#if readonly>
    <select name="${name}" id="${name}" disabled class="form-select medium" <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select name="${name}" id="${name}" class="form-select medium" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <option value="-1">All Workflows</option>
    <option value="GLOBALLY">Global</option>
    <option value="REGIONAL">Regional</option>
    <option value="SIMPLE">End-Market</option>
</select>
</#macro>

<#-- Supplier Group -->
<#macro renderSupplierGroupField name='' value=0 multiselect=false >
<select name="${name}" id="${name}" class="form-select" <#if multiselect>multiple="yes"</#if> onchange=javascript:changeSuppliers();>
    <option value="-1">-- None --</option>
    <#assign supplierGroups = statics['com.grail.synchro.SynchroGlobal'].getSupplierGroup() />
    <#if (supplierGroups?has_content)>
        <#list supplierGroups.keySet() as key>
            <#assign supplierGroup = supplierGroups.get(key)/>
            <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${supplierGroup}</option>
        </#list>
    </#if>
</select>
</#macro>

<#-- Supplier -->
<#macro renderSupplierReportField name='supplier' value=-1 supplierGroup=-1>
    <#assign suppliers = statics['com.grail.synchro.SynchroGlobal'].getSuppliers() />

    <#if supplierGroup==-1>
    <select name="${name}" id="${name}" class="form-select">
        <option value="-1">-- None --</option>
        <#if (suppliers?has_content)>
            <#list suppliers.keySet() as key>
                <#assign supplier = suppliers.get(key) />
                <option value="${key?c}" <#if value?is_number && key?number == value?number>selected="true"</#if>>${supplier}</option>
            </#list>
        </#if>
    </select>
    <#else>
        <#assign supplierGroupList = statics['com.grail.synchro.SynchroGlobal'].getSupplierGroupSupplierMapping().get(supplierGroup?int) />

    <select name="${name}" id="${name}" <#if multiselect?? && multiselect>multiple="yes"</#if> class="select_field large">
        <option value="-1">-- None --</option>
        <#if (suppliers?has_content && supplierGroupList?has_content)>
            <#list supplierGroupList?split(",") as key>
                <option value="${key}" <#if value?is_number && key?number == value?number>selected="true"</#if>> ${suppliers.get(key?number?int)}</option>
            </#list>
        </#if>
    </select>
    </#if>
</#macro>



<#-- Region Macro -->
<#macro showRegionFieldsSection name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Region</#if></label>
    <@renderRegionFieldSection name='allRegionFields' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="regionFields-reload" href="javascript:void(0);"></a>
        <input id="addRegionFieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeRegionFieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addRegionFieldsBtn, #removeRegionFieldsBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addRegionFieldsBtn" ? "#allRegionFields" : "#regionFields";
            var moveTo = (id == "addRegionFieldsBtn") ? "#regionFields" : "#allRegionFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allRegionFields").sortOptions();
    });

    jQuery("#regionFields-reload").click(function() {
        jQuery("#regionFields option").each(function()
        {
            jQuery("#allRegionFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allRegionFields").sortOptions();
        });
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<#macro renderRegionFieldSection name='' value=[] multiselect=false readonly=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'allCoordinatingdetailFields'/>
    <#else>
        <#assign name = 'allCoordinatingdetailFields'/>
    </#if>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
    <#if (regions?has_content)>
        <#list regions.keySet() as key>
            <#assign region = regions.get(key)/>
            <option value="${key?c}" <#if value == key?number>selected="true"</#if>>${region}</option>
        </#list>
    </#if>
<#--<option value="1">${statics['com.grail.synchro.SynchroGlobal$Region'].GLOBAL}</option>-->
<#--<option value="2">${statics['com.grail.synchro.SynchroGlobal$Region'].AMERICAS}</option>-->
<#--<option value="3">${statics['com.grail.synchro.SynchroGlobal$Region'].ASIA_PACIFIC}</option>-->
<#--<option value="4">${statics['com.grail.synchro.SynchroGlobal$Region'].EAST_EUR_MID_EAST_AFRICA}</option>-->
<#--<option value="5">${statics['com.grail.synchro.SynchroGlobal$Region'].WEST_EUROPE}</option>-->

</select>
</#macro>


<#-- Methodology Macro -->
<#macro showMethodologyFieldsSection name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Methodology</#if></label>
    <@renderMethodologyFieldSection name='allMethodologyFields' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="methodologyFields-reload" href="javascript:void(0);"></a>
        <input id="addMethodologyFieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeMethodologyFieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addMethodologyFieldsBtn, #removeMethodologyFieldsBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addMethodologyFieldsBtn" ? "#allMethodologyFields" : "#methodologyFields";
            var moveTo = (id == "addMethodologyFieldsBtn") ? "#methodologyFields" : "#allMethodologyFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allMethodologyFields").sortOptions();
    });

    jQuery("#methodologyFields-reload").click(function() {
        jQuery("#methodologyFields option").each(function()
        {
            jQuery("#allMethodologyFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allMethodologyFields").sortOptions();
        });
    });

    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }

</script>

</#macro>

<#macro renderMethodologyFieldSection name='' value=[] multiselect=false readonly=false>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#assign methodologies = statics['com.grail.synchro.SynchroGlobal'].getMethodologies() />
    <#if (methodologies?has_content)>
        <#list methodologies.keySet() as key>
            <#assign methodology = methodologies.get(key)/>
            <option value="${key?c}" <#if value == key?number>selected="true"</#if>>${methodology}</option>
        </#list>
    </#if>
</select>
</#macro>


<#-- Brand Macro -->
<#macro showBrandFieldsSection name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Brand</#if></label>
    <@renderBrandFieldSection name='allBrandFields' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="brandFields-reload" href="javascript:void(0);"></a>
        <input id="addBrandFieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeBrandFieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addBrandFieldsBtn, #removeBrandFieldsBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addBrandFieldsBtn" ? "#allBrandFields" : "#brandFields";
            var moveTo = (id == "addBrandFieldsBtn") ? "#brandFields" : "#allBrandFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allBrandFields").sortOptions();
    });

    jQuery("#brandFields-reload").click(function() {
        jQuery("#brandFields option").each(function()
        {
            jQuery("#allBrandFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allBrandFields").sortOptions();
        });
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }

</script>

</#macro>

<#macro renderBrandFieldSection name='' value=[] multiselect=false readonly=false>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
    <#if (brands?has_content)>
        <#list brands.keySet() as key>
            <#assign brand = brands.get(key)/>
            <#if value == -1 && brand=="Non-Brand Specific">
                <option value="${key?c}" selected="true">${brand}</option>
            <#else>
                <option value="${key?c}" <#if value == key?number>selected="true"</#if>>${brand}</option>
            </#if>
        </#list>
    </#if>
</select>
</#macro>

<#-- Product Type Macro -->
<#macro showProductTypeFieldsSection name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Product Type</#if></label>
    <@renderProductTypeFieldSection name='allProductTypeFields' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="productTypeFields-reload" href="javascript:void(0);"></a>
        <input id="addProductTypeFieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeProductTypeFieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addProductTypeFieldsBtn, #removeProductTypeFieldsBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addProductTypeFieldsBtn" ? "#allProductTypeFields" : "#productTypeFields";
            var moveTo = (id == "addProductTypeFieldsBtn") ? "#productTypeFields" : "#allProductTypeFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allProductTypeFields").sortOptions();
    });

    jQuery("#productTypeFields-reload").click(function() {
        jQuery("#productTypeFields option").each(function()
        {
            jQuery("#allProductTypeFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allProductTypeFields").sortOptions();
        });
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }

</script>

</#macro>

<#macro renderProductTypeFieldSection name='' value=[] multiselect=false readonly=false>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#assign productTypes = statics['com.grail.synchro.SynchroGlobal'].getProductTypes() />
    <#if (productTypes?has_content)>
        <#list productTypes.keySet() as key>
            <#assign productType = productTypes.get(key)/>
            <#if value == -1 && productType=="Manufactured Cigarettes">
            <option value="${key?c}" selected="true">${productType}
            <#else>
            <option value="${key?c}" <#if value == key?number>selected="true"</#if>>${productType}
            </#if>
        </option>
        </#list>
    </#if>
</select>
</#macro>

<#-- End Markets Macro-->
<#macro showEndMarketReportFieldSection name='' value=0 label='' readonly=false isDocumentRepository=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>End-Market</#if></label>
    <@renderEndMarketReportField name='availableEndMarkets' value=value multiselect=true readonly=readonly isDocumentRepository=isDocumentRepository/>
    <div class="action_buttons">
        <a id="endmarkets-reload" href="javascript:void(0);"></a>
        <input id="addEndMarketBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeEndMarketBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label><span class="list">&nbsp;</span></label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
    <#attempt>
        <@macroCustomFieldErrors msg="Please choose End Markets"/>
        <#recover>
    </#attempt>

</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addEndMarketBtn, #removeEndMarketBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addEndMarketBtn" ? "#availableEndMarkets" : "#endMarkets";
            var moveTo = (id == "addEndMarketBtn") ? "#endMarkets" : "#availableEndMarkets";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            if(id == "addEndMarketBtn")
            {
                var maxCountryCount = ${JiveGlobals.getJiveIntProperty("grail.multimarket.country.limit", 10)?c};
                var items = jQuery("#endMarkets option").size();
                var newItems = selectedItems.length;
                if((items + newItems)>maxCountryCount)
                {
                    //alert("MAX 10 is allowed");
                }
                else
                {
                    jQuery(moveTo).append(selectedItems);
                    jQuery(moveTo).sortOptions();
                    <#if isDocumentRepository?? && isDocumentRepository>
                        jQuery(moveTo+" option[value=-100]").prependTo(jQuery(moveTo));
                    </#if>
                }
            }
            else
            {
                jQuery(moveTo).append(selectedItems);
                jQuery(moveTo).sortOptions();
                <#if isDocumentRepository?? && isDocumentRepository>
                    jQuery(moveTo+" option[value=-100]").prependTo(jQuery(moveTo));
                </#if>
            }
        });
        jQuery("#availableEndMarkets").sortOptions();
        <#if isDocumentRepository?? && isDocumentRepository>
            jQuery("#availableEndMarkets option[value=-100]").prependTo(jQuery("#availableEndMarkets"));
        </#if>
    });

    jQuery("#endmarkets-reload").click(function() {
        jQuery("#endMarkets option").each(function()
        {
            jQuery("#availableEndMarkets").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#availableEndMarkets").sortOptions();
            <#if isDocumentRepository?? && isDocumentRepository>
            jQuery("#availableEndMarkets option[value=-100]").prependTo(jQuery("#availableEndMarkets"));
            </#if>
        });
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>

</#macro>

<#macro renderEndMarketReportField name='' value=[] multiselect=false readonly=false isDocumentRepository=false>
    <#if ! name?exists && multiselect>
        <#assign name = 'endMarkets'/>
    <#else>
        <#assign name = 'endMarket'/>
    </#if>
    <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
    <#assign endMarketKeySet = endMarkets.keySet() />
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#if isDocumentRepository?? && isDocumentRepository>
        <option value='-100'>Global</option>
    </#if>
  <#if (endMarkets?has_content)>
      <#list endMarketKeySet as key>
          <#assign endMarket = endMarkets.get(key) />
          <option value="${key?c}" <#if value?? && value?is_sequence && value?seq_contains(key)>selected="true"</#if>>${endMarket}</option>

      </#list>
  </#if>
</select>
</#macro>

<#macro renderReportYearField name='' value=-1 multiselect=false noOfYears=8 disable=false>
  <#--<#assign currentYear = DateUtils.now()?date?string('yyyy')?number /> -->
  <#assign currentYear = 2013 />
  <#if ! name?exists>
      <#assign name = 'year'/>
  <#else>
      <#assign name = 'years'/>
  </#if>
  <#if value == -1>
      <#assign selectedValue = currentYear?c />
  </#if>
<select name="${name}" id="${name}" class="form-select_year" <#if disable>disabled="true"</#if> <#if multiselect>multiple="yes"</#if>>
  <option value="-1">-- None --</option>
  <option value="${currentYear?c}">${currentYear?c}</option>
<#-- To render next 5 years -->
    <#list 1..noOfYears as i>
        <#assign year = (currentYear + i)?c />
        <option value="${year}">${year}</option>
    </#list>
</select>
</#macro>

<#macro renderReportMonthField name=-1 value=-1 multiselect=false disable=false>

    <#if ! name?exists && multiselect>
        <#assign name = 'month'/>
    <#else>
        <#assign name = 'months'/>
    </#if>
    <#assign currentMonth = (DateUtils.now()?date?string('MM')?number - 1) />

<select name="${name}" id="${name}" class="form-select_year" <#if disable>disabled="true"</#if> <#if multiselect>multiple="yes"</#if>>
    <option value=-1>-- None --</option>
    <option value=0>JANUARY</option>
    <option value=1>FEBRUARY</option>
    <option value=2>MARCH</option>
    <option value=3>APRIL</option>
    <option value=4>MAY</option>
    <option value=5>JUNE</option>
    <option value=6>JULY</option>
    <option value=7>AUGUST</option>
    <option value=8>SEPTEMBER</option>
    <option value=9>OCTOBER</option>
    <option value=10>NOVEMBER</option>
    <option value=11>DECEMBER</option>
</select>
</#macro>


<#-- Project Status Macro -->
<#macro showProjectStatusSection name='' value=0 label='' readonly=false isadmin=false statusCatalogue=false waiver=false >
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Project Status</#if></label>
    <@renderProjectStatusSection name='allProjectStatusFields' value=value multiselect=true readonly=readonly isadmin=isadmin statusCatalogue=statusCatalogue waiver=waiver />
    <div class="action_buttons">
        <a id="projectStatusFields-reload" href="javascript:void(0);"></a>
        <input id="addProjectStatusFieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeProjectStatusFieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>

<script type="text/javascript">
    jQuery(function() {
        jQuery("#addProjectStatusFieldsBtn, #removeProjectStatusFieldsBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addProjectStatusFieldsBtn" ? "#allProjectStatusFields" : "#projectStatusFields";
            var moveTo = (id == "addProjectStatusFieldsBtn") ? "#projectStatusFields" : "#allProjectStatusFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allProjectStatusFields").sortOptions();
    });

    jQuery("#projectStatusFields-reload").click(function() {
        jQuery("#projectStatusFields option").each(function()
        {
            jQuery("#allProjectStatusFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allProjectStatusFields").sortOptions();
        });
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>
</#macro>

<#macro renderProjectStatusSection name='' value=[] multiselect=false readonly=false isadmin=false statusCatalogue=false waiver=false>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#if waiver>
        <#assign statusList = statics['com.grail.synchro.SynchroGlobal'].getWaiverStatusList() />
    <#else>
        <#assign statusList = statics['com.grail.synchro.SynchroGlobal'].getProjectStatuses(isadmin) />
    </#if>

    <#if (statusList?has_content)>
        <#list statusList.keySet() as key>
            <#assign status = statusList.get(key)/>
            <option value="${key?c}">${status}</option>
        </#list>
    </#if>
</select>
</#macro>


<#-- Project Status Macro -->
<#macro showProjectActivitySection name='' value=0 label='' readonly=false>
    <div class="form-select_div">
        <label><#if label!=''>${label}<#else>Pending Activity Type</#if></label>
        <@renderProjectActivitySection name='allProjectActivityFields' value=value multiselect=true readonly=readonly />
        <div class="action_buttons">
            <a id="projectActivityFields-reload" href="javascript:void(0);"></a>
            <input id="addProjectActivityFieldsBtn" type="button" value='>>' class="left_arrow" />
            <input id="removeProjectActivityFieldsBtn" type="button" value='<<' class="right_arrow" />
        </div>
    </div>
    <div class="form-select_div_brand">
        <label>&nbsp;</label>
        <#if readonly>
            <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
        <#else>
            <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
        </#if>
    </div>

    <script type="text/javascript">
        jQuery(function() {
            jQuery("#addProjectActivityFieldsBtn, #removeProjectActivityFieldsBtn").click(function(event) {
                var id = jQuery(event.target).attr("id");
                var selectFrom = id == "addProjectActivityFieldsBtn" ? "#allProjectActivityFields" : "#projectActivityFields";
                var moveTo = (id == "addProjectActivityFieldsBtn") ? "#projectActivityFields" : "#allProjectActivityFields";
                var selectedItems = jQuery(selectFrom + " :selected").toArray();
                jQuery(moveTo).append(selectedItems);
                jQuery(moveTo).sortOptions();
            });
            jQuery("#allProjectActivityFields").sortOptions();
        });

        jQuery("#projectActivityFields-reload").click(function() {
            jQuery("#projectActivityFields option").each(function()
            {
                jQuery("#allProjectActivityFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
                jQuery(this).remove();
                jQuery("#allProjectActivityFields").sortOptions();
            });
        });
        jQuery.fn.sortOptions = function(){
            jQuery(this).each(function(){
                var op = jQuery(this).children("option");
                op.sort(function(a, b) {
                    return a.text > b.text ? 1 : -1;
                })
                return jQuery(this).empty().append(op);
            });
        }
    </script>
</#macro>

<#macro renderProjectActivitySection name='' value=[] multiselect=false readonly=false >
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#assign pendingActivityList = statics['com.grail.synchro.SynchroGlobal'].getPendingActivityList() />
    <#if (pendingActivityList?has_content)>
        <#list pendingActivityList.keySet() as key>
            <#assign pendingActivity = pendingActivityList.get(key)/>
            <option value="${key?string}">${pendingActivity}</option>
        </#list>
    </#if>
</select>
</#macro>


<#-- Project Supplier Macro -->
<#macro showProjectSupplierSection name='' value=0 label='' readonly=false>
    <div class="form-select_div">
        <label><#if label!=''>${label}<#else>Project Supplier</#if></label>
        <@renderProjectSupplierSection name='allProjectSupplierFields' value=value multiselect=true readonly=readonly />
        <div class="action_buttons">
            <a id="projectSupplierFields-reload" href="javascript:void(0);"></a>
            <input id="addProjectSupplierFieldsBtn" type="button" value='>>' class="left_arrow" />
            <input id="removeProjectSupplierFieldsBtn" type="button" value='<<' class="right_arrow" />
        </div>
    </div>
    <div class="form-select_div_brand">
        <label>&nbsp;</label>
        <#if readonly>
            <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
        <#else>
            <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
        </#if>
    </div>

    <script type="text/javascript">
        jQuery(function() {
            jQuery("#addProjectSupplierFieldsBtn, #removeProjectSupplierFieldsBtn").click(function(event) {
                var id = jQuery(event.target).attr("id");
                var selectFrom = id == "addProjectSupplierFieldsBtn" ? "#allProjectSupplierFields" : "#projectSupplierFields";
                var moveTo = (id == "addProjectSupplierFieldsBtn") ? "#projectSupplierFields" : "#allProjectSupplierFields";
                var selectedItems = jQuery(selectFrom + " :selected").toArray();
                jQuery(moveTo).append(selectedItems);
                jQuery(moveTo).sortOptions();
            });
            jQuery("#allProjectSupplierFields").sortOptions();
        });

        jQuery("#projectSupplierFields-reload").click(function() {
            jQuery("#projectSupplierFields option").each(function()
            {
                jQuery("#allProjectSupplierFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
                jQuery(this).remove();
                jQuery("#allProjectSupplierFields").sortOptions();
            });
        });
        jQuery.fn.sortOptions = function(){
            jQuery(this).each(function(){
                var op = jQuery(this).children("option");
                op.sort(function(a, b) {
                    return a.text > b.text ? 1 : -1;
                })
                return jQuery(this).empty().append(op);
            });
        }
    </script>
</#macro>

<#macro renderProjectSupplierSection name='' value=[] multiselect=false readonly=false >
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#assign supplierList = statics['com.grail.synchro.SynchroGlobal'].getSuppliers() />
    <#if (supplierList?has_content)>
        <#list supplierList.keySet() as key>
            <#assign supplier = supplierList.get(key)/>
            <option value="${key?c}">${supplier}</option>
        </#list>
    </#if>
</select>
</#macro>

<!-- Log Dashboard Search Filters starts -->
<!-- Portal Name Macro -->
<#macro showPortalFieldsSection name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Portal Name</#if></label>
    <@renderPortalFieldSection name='allPortalFields' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="portalFields-reload" href="javascript:void(0);"></a>
        <input id="addPortalFieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removePortalFieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>
<script type="text/javascript">
    jQuery(function() {
        jQuery("#addPortalFieldsBtn, #removePortalFieldsBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addPortalFieldsBtn" ? "#allPortalFields" : "#portalFields";
            var moveTo = (id == "addPortalFieldsBtn") ? "#portalFields" : "#allPortalFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allPortalFields").sortOptions();
    });

    jQuery("#portalFields-reload").click(function() {
        jQuery("#portalFields option").each(function()
        {
            jQuery("#allPortalFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allPortalFields").sortOptions();
        });
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>
</#macro>
<#macro renderPortalFieldSection name='' value=[] multiselect=false readonly=false>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#assign portals = statics['com.grail.synchro.SynchroGlobal'].getPortalTypes() />
    <#if (portals?has_content)>
        <#list portals.keySet() as key>
            <#assign portal = portals.get(key)/>
            <#if value == -1 && portal=="Synchro">
                <option value="${key?c}" selected="true">${portal}</option>
            <#else>
                <option value="${key?c}" <#if value == key?number>selected="true"</#if>>${portal}</option>
            </#if>
        </#list>
    </#if>
</select>
</#macro>


<!-- Page Access Macro -->
<#macro showPageFieldsSection name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Page Access</#if></label>
    <@renderPageFieldSection name='allPageFields' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="pageFields-reload" href="javascript:void(0);"></a>
        <input id="addPageFieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removePageFieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>
<script type="text/javascript">
    jQuery(function() {
        jQuery("#addPageFieldsBtn, #removePageFieldsBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addPageFieldsBtn" ? "#allPageFields" : "#pageFields";
            var moveTo = (id == "addPageFieldsBtn") ? "#pageFields" : "#allPageFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allPageFields").sortOptions();
    });

    jQuery("#pageFields-reload").click(function() {
        jQuery("#pageFields option").each(function()
        {
            jQuery("#allPageFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allPageFields").sortOptions();
        });
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>
</#macro>
<#macro renderPageFieldSection name='' value=[] multiselect=false readonly=false>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#assign pages = statics['com.grail.synchro.SynchroGlobal'].getPageTypes() />
    <#if (pages?has_content)>
        <#list pages.keySet() as key>
            <#assign page = pages.get(key)/>
            <option value="${key?c}" <#if value == key?number>selected="true"</#if>>${page}</option>
        </#list>
    </#if>
</select>
</#macro>


<!-- Activity Type Macro -->
<#macro showActivityFieldsSection name='' value=0 label='' readonly=false>
<div class="form-select_div">
    <label><#if label!=''>${label}<#else>Activity Type</#if></label>
    <@renderActivityFieldSection name='allActivityFields' value=value multiselect=true readonly=readonly/>
    <div class="action_buttons">
        <a id="activityFields-reload" href="javascript:void(0);"></a>
        <input id="addActivityFieldsBtn" type="button" value='>>' class="left_arrow" />
        <input id="removeActivityFieldsBtn" type="button" value='<<' class="right_arrow" />
    </div>
</div>
<div class="form-select_div_brand">
    <label>&nbsp;</label>
    <#if readonly>
        <select size="3" name="${name}" id="${name}" disabled multiple="yes" class=""></select>
    <#else>
        <select size="3" name="${name}" id="${name}" multiple="yes" class=""></select>
    </#if>
</div>
<script type="text/javascript">
    jQuery(function() {
        jQuery("#addActivityFieldsBtn, #removeActivityFieldsBtn").click(function(event) {
            var id = jQuery(event.target).attr("id");
            var selectFrom = id == "addActivityFieldsBtn" ? "#allActivityFields" : "#activityFields";
            var moveTo = (id == "addActivityFieldsBtn") ? "#activityFields" : "#allActivityFields";
            var selectedItems = jQuery(selectFrom + " :selected").toArray();
            jQuery(moveTo).append(selectedItems);
            jQuery(moveTo).sortOptions();
        });
        jQuery("#allActivityFields").sortOptions();
    });

    jQuery("#activityFields-reload").click(function() {
        jQuery("#activityFields option").each(function()
        {
            jQuery("#allActivityFields").append(new Option(jQuery(this).text(), jQuery(this).val()));
            jQuery(this).remove();
            jQuery("#allActivityFields").sortOptions();
        });
    });
    jQuery.fn.sortOptions = function(){
        jQuery(this).each(function(){
            var op = jQuery(this).children("option");
            op.sort(function(a, b) {
                return a.text > b.text ? 1 : -1;
            })
            return jQuery(this).empty().append(op);
        });
    }
</script>
</#macro>
<#macro renderActivityFieldSection name='' value=[] multiselect=false readonly=false>
    <#if readonly>
    <select size="3" name="${name}" id="${name}" disabled <#if multiselect>multiple="yes"</#if>>
    <#else>
    <select size="3" name="${name}" id="${name}" <#if multiselect>multiple="yes"</#if>>
    </#if>
    <#assign activities = statics['com.grail.synchro.SynchroGlobal'].getActivityTypes() />
    <#if (activities?has_content)>
        <#list activities.keySet() as key>
            <#assign activity = activities.get(key)/>
            <option value="${key?c}" <#if value == key?number>selected="true"</#if>>${activity}</option>
        </#list>
    </#if>
</select>
</#macro>
<!-- Log Dashboard Search Filters ends -->