<link rel="stylesheet" type="text/css" href="${themePath}/style/quick-search.css">
<script type="text/javascript">
    function checkValues(){
        var searchForm = $j('#searchform');
        if($j('#view').val() == 'content') {
            //var searchForm = document.getElementById("searchform");
            $j("#searchForDocumentsOnly").val(false);
            $j("#applyExtendedPropertyFilters").val(false);

            var periodFromMonth = $j('#docPeriodFromMonth').val();
            var periodFromYear = $j('#docPeriodFromYear').val();
            var periodToMonth = $j('#docPeriodToMonth').val();
            var periodToYear =  $j('#docPeriodToYear').val();
            var searchTerm =  $j('#jive-search-terms').val();
            var docBrand = $j('#docBrand').val();
            var docRegion = $j('#docRegion').val();
            var docMethodology =  $j('#docMethodology').val();

            if( (docBrand != 'NA' || docRegion != 'NA' || docMethodology != 'NA' || periodFromMonth != 'NA' || periodFromYear != 'NA' || periodToMonth != 'NA' || periodToYear != 'NA')) {
                $j('#newSearch').val('true');
                $j("#searchForDocumentsOnly").val(true);
                $j("#applyExtendedPropertyFilters").val(true);
                $j('#resultTypes').val('document');
            } else {
                $j("#searchForDocumentsOnly").val(false);
                $j("#applyExtendedPropertyFilters").val(false);
                $j('#resultTypes').val('all');
            }

            if( (docBrand == 'NA' && docRegion == 'NA' && docMethodology == 'NA' && periodFromMonth == 'NA' && periodFromYear == 'NA' && periodToMonth == 'NA' && periodToYear == 'NA') && searchTerm == '') {
                alert('Please select at least one search term from Brand, Country, Methodology, Period');
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                return false;
            }

            if(periodFromYear == 'NA' && periodFromMonth != 'NA') {
                alert('Please select valid "From" year');
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                return false;
            }

            if(periodFromMonth == 'NA' && periodFromYear != 'NA') {
                alert('Please select valid "From" month');
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                return false;
            }

            if(periodToYear == 'NA' && periodToMonth != 'NA') {
                alert('Please select valid "To" year');
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                return false;
            }

            if(periodToMonth == 'NA' && periodToYear != 'NA') {
                alert('Please select valid "To" month');
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                return false;
            }

            if((periodFromYear != 'NA' && periodFromMonth != 'NA') && (periodToYear == 'NA' && periodToMonth == 'NA')) {
                alert('Please select valid "To" Year and Month');
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                return false;
            }

            if((periodFromYear == 'NA' && periodFromMonth == 'NA') && (periodToYear != 'NA' && periodToMonth != 'NA')) {
                alert('Please select valid "From" year and month');
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                return false;
            }

            if(periodFromMonth.toLowerCase() == "NA".toLowerCase() || periodFromYear.toLowerCase() == "NA".toLowerCase() || periodToMonth.toLowerCase() == "NA".toLowerCase() || periodToYear.toLowerCase() == "NA".toLowerCase()){
                // searchForm.resultTypes.value = "document";
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                //searchForm.newSearch.value = 'true';
                if( (docBrand != 'NA' || docRegion != 'NA' || docMethodology != 'NA'  || periodFromMonth != 'NA' || periodFromYear != 'NA' || periodToMonth != 'NA' || periodToYear != 'NA') && searchTerm == '') {
                    $j('#resultTypes').val('document');
                }
                searchForm.submit();
                return true;
            } else {
                if((periodToYear > periodFromYear) || ((periodToYear == periodFromYear) && (periodToMonth >= periodFromMonth))) {
                    $j('#resultTypes').val("document");
                    //searchForm.newSearch.value = 'true';
                    $j('#newSearch').val('true');
                    if( (docBrand != 'NA' || docRegion != 'NA' || docMethodology != 'NA'  || periodFromMonth != 'NA' || periodFromYear != 'NA' || periodToMonth != 'NA' || periodToYear != 'NA') && searchTerm == '') {
                        $j('#resultTypes').val('document');
                    }
                    searchForm.submit();
                    return true;
                }
                else {
                    if ((periodToYear == periodFromYear) && (periodToMonth < periodFromMonth)) {
                        alert('Please enter valid "From" month');
                        $j('#jive-search-button-submit').val("Search");
                        $j('#jive-search-button-submit').attr("disabled",false);
                        return false;
                    }
                    alert('Please specify valid dates!!!');
                    $j('#jive-search-button-submit').val("Search");
                    $j('#jive-search-button-submit').attr("disabled",false);
                    return false;
                }
            }
            $j('#jive-search-button-submit').val("Search");
            $j('#jive-search-button-submit').attr("disabled",false);
            return false;
        } else {
            searchForm.submit();
            return true;
        }
    }
</script>
<div>
    <form id="searchform" action="<@s.url value='/search.jspa'/>">
        <input type="hidden" id="view" name="view" value="content">
        <input type="hidden" id="resultTypes" name="resultTypes" value="document">
        <input type="hidden" id="dateRange" name="dateRange" value="last90days">
        <input type="hidden" id="newSearch" name="newSearch" value="true">
        <input type="hidden" id="searchForDocumentsOnly" name="searchForDocumentsOnly" value="true">
        <input type="hidden" id="applyExtendedPropertyFilters" name="applyExtendedPropertyFilters" value="true">
    <#assign brands = JiveGlobals.getJiveProperty("grail.brandList")?split(",") />
    <#assign countries = JiveGlobals.getJiveProperty("grail.countryList")?split(",") />
    <#assign periodMonth = JiveGlobals.getJiveProperty("grail.periodMonth")?split(",") />
    <#assign periodYear = JiveGlobals.getJiveProperty("grail.periodYear")?split(",") />
    <#assign methodology = JiveGlobals.getJiveProperty("grail.methodologyList")?split(",") />
        <!-- Brand dropdown -->
        <div id="docs-brand-select-container">
            <label for="docBrand">Brand: </label>
            <select name="docBrand" id="docBrand">
                <option value="NA">Please Select</option>
            <#list brands as brand>
                <option value="${brand?string}" <#if docBrand?exists && docBrand.contains(brand)><#assign criteriea = true/>selected</#if>>${brand?string}</option>
            </#list>
            </select>
        </div>

        <!-- Country dropdown -->
        <div id="docs-country-select-container">
            <label for="docRegion">Country: </label>
            <select name="docRegion" id="docRegion" class="customselect" onchange="changeResultType();">
                <option value="NA">Please Select</option>
            <#list countries as country>
                <option value="${country?string}" <#if docRegion?exists && docRegion.contains(country)><#assign criteriea = true/>selected</#if>>${country?string}</option>
            </#list>
            </select>
        </div>

        <!-- Methodology dropdonw -->
        <div id="docs-methodology-select-container">
            <label for="docMethodology">Methodology: </label>
            <select name="docMethodology" id="docMethodology" class="customselectwidth" onchange="changeResultType();">
                <option value="NA">Please Select</option>
            <#list methodology as md>
                <option value="${md?string}" <#if docMethodology?exists && docMethodology.contains(md)><#assign criteriea = true/>selected</#if>>${md?string}</option>
            </#list>
            </select>
        </div>

        <!-- From block -->
        <div id="docs-from-select-container">
            <span>From</span>

            <div>
                <!-- From month-->
                <div class="docperiod-month">
                    <label for="docPeriodFromMonth">Month: </label>
                    <select name="docPeriod" id="docPeriodFromMonth" class="customselect" onchange="javascript:changeResultType();">
                        <option value="NA">Please Select</option>
                    <#assign i=0 />
                    <#list periodMonth as month>
                        <option value="${i}" <#if docPeriod?exists && (docPeriod[0]?trim = i?string)><#assign criteriea = true/>selected</#if>>${month?string}</option>
                        <#assign i = i+1 />
                    </#list>
                    </select>
                </div>
                <!-- From year-->
                <div class="docperiod-year">
                    <label for="docPeriodFromYear">Year: </label>
                    <select name="docPeriod" id="docPeriodFromYear" class="customselect" onchange="javascript:changeResultType();">
                        <option value="NA">Please Select</option>
                    <#list periodYear as year>
                        <option value="${year?string}" <#if docPeriod?exists && docPeriod[1]?trim == year?trim?string><#assign criteriea = true/>selected</#if>>${year?string}</option>
                    </#list>
                    </select>
                </div>
            </div>
        </div>
        <div id="docs-to-select-container">
            <span>To</span>
            <div>
                <!-- To month-->
                <div class="docperiod-month">
                    <label for="docPeriodToMonth">Month: </label>
                    <select name="docPeriod" id="docPeriodToMonth" class="customselect" onchange="javascript:changeResultType();">
                        <option value="NA">Please Select</option>
                    <#assign i=0 />
                    <#list periodMonth as month>
                        <option value="${i}" <#if docPeriod?exists && (docPeriod[2]?trim == i?string)><#assign criteriea = true/>selected</#if>>${month?string}</option>
                        <#assign i = i+1 />
                    </#list>
                    </select>
                </div>
                <!-- To year-->
                <div class="docperiod-year">
                    <label for="docPeriodToYear">Year: </label>
                    <select name="docPeriod" id="docPeriodToYear" class="customselect" onchange="javascript:changeResultType();">
                        <option value="NA">Please Select</option>
                    <#list periodYear as year>
                        <option value="${year?string}" <#if docPeriod?exists && (docPeriod[3]?trim == year?trim?string)><#assign criteriea = true/>selected</#if>>${year?string}</option>
                    </#list>
                    </select>
                </div>
            </div>
        </div>
        <div class="save-button">
            <input type="button" value="Search" onclick="checkValues();return false;">
        </div>
    </form>
</div>
