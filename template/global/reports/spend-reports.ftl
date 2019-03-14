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
    <h2>Generate Reports</h2>
</div>
<@reportTab activeTab=2 />
<div class="report-body">
    <a href="javascript:void(0);" onclick="showApplyFilterPopup()" class="apply-filters">Apply filters</a>
    <div class="report-type">
        <label class="label">Select the report(s) required in excel</label>
        <div class="form-select_div left">
            <label>List of reports</label>
            <select size="18" name="listOfReports" id="listOfReports" multiple="yes">

            </select>
            <div class="action_buttons">
                <a id="report-type-reload-btn" href="javascript:void(0);"></a>
                <input id="report-type-add-btn" type="button" value='>>' class="left_arrow" />
                <input id="report-type-remove-btn" type="button" value='<<' class="right_arrow" />
            </div>
        </div>
        <div class="form-select_div_brand right">
            <label>Selected reports</label>
            <select size="18" name="selectedReports" id="selectedReports"  multiple="yes" ></select>
            <span id="report-type-selection-error" class="jive-error-message" <#if request.getParameter("reportTypeSelectionError")?? && request.getParameter("reportTypeSelectionError") == 'true'>style="display: block;"<#else>style="display: none;"</#if>>Please select the report(s) required in excel</span>
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
            <#assign reportTypes = statics['com.grail.synchro.SynchroGlobal$SpendReportType'].values()/>
            <#if reportTypes?? && reportTypes?has_content>
                <#list reportTypes as reportType>
                    $j("#listOfReports").append("<option value='${reportType.getId()}'>${reportType.getName()}</option>");
                </#list>
            </#if>
            }
        </script>

    </div>


    <div class="report-year">
        <label class="label">Year</label>
        <div class="form-select_div left">
        <#--<label>List of reports</label>-->
            <select size="5" name="listOfYears" id="listOfYears" multiple="yes">

            </select>
            <div class="action_buttons">
                <a id="year-reload-btn" href="javascript:void(0);"></a>
                <input id="year-add-btn" type="button" value='>>' class="left_arrow" />
                <input id="year-remove-btn" type="button" value='<<' class="right_arrow" />
            </div>
        </div>
        <div class="form-select_div_brand right">
        <#--<label>Selected reports</label>-->
            <select size="5" name="selectedYears" id="selectedYears"  multiple="yes" ></select>
        </div>

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
                var maxYear = currYear + 2;
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
    <div class="report-currency">
        <label class="label">Currency</label>
    <@renderCurrenciesField name='spendReportCurrency' value=defaultCurrency disabled=false/>
    </div>
    <div class="generate-report-button buttons">
        <script type="text/javascript">
            $j(function(){
                var reportTypes = "";
                var years = "";
                $j("#generate-report-form").submit(function(event){
                    reportTypes = "";
                    years = "";
                    $j("#report-type-selection-error").hide();
                    var self = this;
                    event.preventDefault();
                    var selectedReportTypesArr = [];
                    $j("#selectedReports").find('option').each(function(){
                        selectedReportTypesArr.push($j(this).val());
                    });
                    if(selectedReportTypesArr.length > 0) {
                        reportTypes = selectedReportTypesArr.join(",");
                    } else {
                        $j("#report-type-selection-error").show();
                        return;
                    }

                    var selectedYearsArr = [];
                    $j("#selectedYears").find('option').each(function(){
                        selectedYearsArr.push($j(this).val());
                    });
                    if(selectedYearsArr.length > 0) {
                        years = selectedYearsArr.join(",");
                    }
                    $j("#reportTypes").val(reportTypes);
                    $j("#years").val(years);
                    $j("#currencyId").val($j("#spendReportCurrency").val());
                    self.submit();
                <#assign i18CustomText><@s.text name="logger.project.report.generate.text" /></#assign>
                    SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].REPORTS.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].SPENDREPORTS.getId()}, "${i18CustomText}", "", -1, ${user.ID?c});

                });
            });
        </script>
        <form id="generate-report-form" action="<@s.url value="/synchro/downloadSpendReports.jspa"/>" method="post">
            <input type="hidden" id="reportTypes" name="reportTypes">
            <input type="hidden" id="years" name="years">
            <input type="hidden" id="regions" name="regions">
            <input type="hidden" id="countries" name="countries">
            <input type="hidden" id="marketTypes" name="marketTypes">
            <input type="hidden" id="currencyId" name="currencyId">
            <input type="submit" class="save" value="Generate Reports">
        </form>

    </div>
</div>
<div id="apply-filter-popup" style="display: none;" class="generate-report-filter-popup">

<div class="j-form-popup">
<div class="title">
    <h4>Apply Filters</h4>
</div>
<a href="javascript:void(0);" class="close" onclick="closeApplyFilterPopup();"></a>
<div>
    <div class="form-select_div left">
        <label class="label">List of market types</label>
        <select size="2" name="listOfMarketTypes" id="listOfMarketTypes" multiple="yes">

        </select>
        <div class="markettype action_buttons">
            <a id="markettype-reload-btn" href="javascript:void(0);"></a>
            <input id="markettype-add-btn" type="button" value='>>' class="left_arrow" />
            <input id="markettype-remove-btn" type="button" value='<<' class="right_arrow" />
        </div>
    </div>
    <div class="form-select_div_brand right">
        <label class="label">Selected market types</label>
        <select size="2" name="selectedMarketTypes" id="selectedMarketTypes"  multiple="yes" ></select>
    </div>

    <script type="text/javascript">

        $j(function() {
            loadAllMarketTypes();
            $j("#markettype-add-btn, #markettype-remove-btn").click(function(event) {
                updateMarketTypeSelection($j(event.target).attr("id"));
            });
        });

        function updateMarketTypeSelection(id) {
            var selectFrom = (id == "markettype-add-btn") ? "#listOfMarketTypes" : "#selectedMarketTypes";
            var moveTo = (id == "markettype-add-btn") ? "#selectedMarketTypes" : "#listOfMarketTypes";
            var selectedItems = $j(selectFrom + " :selected").toArray();
            $j(moveTo).append(selectedItems);
            sortOptions($j(moveTo));

        }

        $j("#markettype-reload-btn").click(function() {
            loadAllMarketTypes();
        });
        function loadAllMarketTypes() {
            $j("#selectedMarketTypes").html('');
            $j("#listOfMarketTypes").html('');

            $j("#listOfMarketTypes").append("<option value='0'>Single Market</option>");
            $j("#listOfMarketTypes").append("<option value='1'>Multi Market</option>");
        }
    </script>

</div>
<div>
    <div class="form-select_div left">
        <label class="label">List of regions</label>
        <select size="5" name="listOfRegions" id="listOfRegions" multiple="yes">

        </select>
        <div class="action_buttons">
            <a id="regions-reload-btn" href="javascript:void(0);"></a>
            <input id="regions-add-btn" type="button" value='>>' class="left_arrow" />
            <input id="regions-remove-btn" type="button" value='<<' class="right_arrow" />
        </div>
    </div>
    <div class="form-select_div_brand right">
        <label class="label">Selected regions</label>
        <select size="5" name="selectedRegions" id="selectedRegions"  multiple="yes" ></select>
    </div>

    <script type="text/javascript">

        $j(function() {
            loadAllRegions();
            $j("#regions-add-btn, #regions-remove-btn").click(function(event) {
                var id = $j(event.target).attr("id");
                var selectFrom = (id == "regions-add-btn") ? "#listOfRegions" : "#selectedRegions";
                var moveTo = (id == "regions-add-btn") ? "#selectedRegions" : "#listOfRegions";
                var selectedItems = $j(selectFrom + " :selected").toArray();
                $j(moveTo).append(selectedItems);
                var regionAdded = (moveTo == "#listOfRegions")?false:true;
                updateEndmarketsSelectionByRegion(selectedItems,regionAdded);
                sortOptions($j(moveTo));
            });
        });

        function updateEndmarketsSelectionByRegion(selectedItems, regionAdded) {
            var countries = [];
            if(selectedItems.length > 0) {
                for(var i = 0; i < selectedItems.length; i++) {
                    var regionId = $j(selectedItems[i]).val();
                    <#assign regionEndmarketMap = statics['com.grail.synchro.SynchroGlobal'].getRegionEndMarketsMapping()/>;
                <#if regionEndmarketMap?has_content>
                    <#list regionEndmarketMap.keySet() as regionEndmarketMapKey>
                        var rid = ${regionEndmarketMapKey?c};

                        if(rid == Number(regionId)) {
                            <#assign rEmsMap = regionEndmarketMap.get(regionEndmarketMapKey)/>
                            <#if rEmsMap?has_content>
                                countries = countries.concat(${rEmsMap.keySet()});
                            </#if>
                        }
                    </#list>
                </#if>
                }

            }
            if(countries.length > 0) {
                var selectFrom = (regionAdded) ? "#listOfCountries" : "#selectedCountries";
                var moveTo = (regionAdded) ? "#selectedCountries" : "#listOfCountries";
                var selectedItems = [];
                for(var c = 0; c < countries.length; c++) {
                    $j(selectFrom + " option[value="+countries[c]+"]").appendTo($j(moveTo));
                }
                sortOptions($j(moveTo));
            }
        }


        $j("#regions-reload-btn").click(function() {
            updateEndmarketsSelectionByRegion($j("#selectedRegions option").toArray(), false);
            loadAllRegions();
        });
        function loadAllRegions() {
            $j("#selectedRegions").html('');
            $j("#listOfRegions").html('');
        <#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions(user) />
        <#if (regions?has_content)>
            <#list regions.keySet() as key>
                $j("#listOfRegions").append("<option value='${key?c}'>${regions.get(key)}</option>");
            </#list>
        </#if>

        }
    </script>

</div>

<div>
    <div class="form-select_div left">
        <label class="label">List of countries</label>
        <select size="5" name="listOfCountries" id="listOfCountries" multiple="yes">

        </select>
        <div class="action_buttons">
            <a id="countries-reload-btn" href="javascript:void(0);"></a>
            <input id="countries-add-btn" type="button" value='>>' class="left_arrow" />
            <input id="countries-remove-btn" type="button" value='<<' class="right_arrow" />
        </div>
    </div>
    <div class="form-select_div_brand right">
        <label class="label">Selected countries</label>
        <select size="5" name="selectedCountries" id="selectedCountries"  multiple="yes" ></select>
    </div>

    <script type="text/javascript">

        $j(function() {
            loadAllCountries();
            $j("#countries-add-btn, #countries-remove-btn").click(function(event) {
                updateEndmarketSelection($j(event.target).attr("id"));
            });
        });

        function updateEndmarketSelection(id) {
            var selectFrom = (id == "countries-add-btn") ? "#listOfCountries" : "#selectedCountries";
            var moveTo = (id == "countries-add-btn") ? "#selectedCountries" : "#listOfCountries";
            var selectedItems = $j(selectFrom + " :selected").toArray();
            $j(moveTo).append(selectedItems);
            selectedCountries = [];
            $j("#selectedCountries option").each(function(){
                selectedCountries.push($j(this));
            })
            sortOptions($j(moveTo));

        }

        $j("#countries-reload-btn").click(function() {
            loadAllCountries();
        });
        function loadAllCountries() {
            $j("#selectedCountries").html('');
            $j("#listOfCountries").html('');

        <#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets(user) />
        <#if (endMarkets?has_content)>
            <#list endMarkets.keySet() as key>
                $j("#listOfCountries").append("<option value='${key?c}'>${endMarkets.get(key)}</option>");
            </#list>
        </#if>
        }
    </script>

</div>
<script type="text/javascript">
    function resetFilters() {
        loadAllRegions();
        loadAllCountries();
        loadAllMarketTypes();
        $j("#regions").val("");
        $j("#countries").val("");
        $j("#marketTypes").val("");
    }

    function applyFilters() {
        var regions  = "";
        var countries = "";
        var marketTypes = "";
        var selectedRegionsArr = [];
        $j("#selectedRegions").find('option').each(function(){
            selectedRegionsArr.push($j(this).val());
        });
        if(selectedRegionsArr.length > 0) {
            regions = selectedRegionsArr.join(",");
        }
        $j("#regions").val(regions);

        var selectedCountriesArr = [];
        $j("#selectedCountries").find('option').each(function(){
            selectedCountriesArr.push($j(this).val());
        });
        if(selectedCountriesArr.length > 0) {
            countries = selectedCountriesArr.join(",");
        }
        $j("#countries").val(countries);

        var marketTypesArr = [];
        $j("#selectedMarketTypes").find('option').each(function(){
            marketTypesArr.push($j(this).val());
        });
        if(marketTypesArr.length > 0) {
            marketTypes = marketTypesArr.join(",");
        }
        $j("#marketTypes").val(marketTypes);
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

