<#include "/template/cart/cart-macros.ftl">
<link rel="stylesheet" href="/styles/jive-search.css" type="text/css" media="all" />
<script type="text/javascript">
    var criteria = false;
</script>
<form action="<@s.url value="/search.jspa" />" name="searchform" id="searchform" class="j-form">

<input type="hidden" id="applyExtendedPropertyFilters" name="applyExtendedPropertyFilters" value="true">
<div class="j-box-body" id="jive-search-form">

        <input type="text" name="searchParam" id="jive-search-terms" size="50" maxlength="100" value='${searchParam?default("")}'> 
        <input type="submit" id="jive-search-button-submit" value="Search" onclick="this.disabled=true;this.value='Searching...';checkValues();return false;">


    </div>
<nav id="j-search-tabs" class="j-bigtab-nav j-rc5 j-rc-none-bottom">
    <ul class="j-tabbar">
        <li id="jiveTab_content" class="j-tab-selected active j-ui-elem">
            <a href="javascript:doViewSearch('content')" class="j-ui-elem">Content</a>
        </li>
    </ul>
</nav>
<div class="jive-search-results j-contained j-rc4 j-rc-none-top  clearfix">
<div id="jive-search-content" class="j-box-body j-rc4">
<div id="jive-search-results-content">
<!-- filters -->
<div class="j-browse-filters j-box-controls j-rc4  jive-noOpenSearch">

    <div class="j-browse-sorts">

<style type="text/css">
    div#custom_content_filter {
        background-attachment: scroll;
        background-clip: border-box;
        background-color: #F9F9F9;
        background-image: none;
        background-origin: padding-box;
        border-bottom-color: #DADADA;
        border-bottom-left-radius: 4px;
        border-bottom-right-radius: 4px;
        border-bottom-style: solid;
        border-bottom-width: 1px;
        border-left-color: #DADADA;
        border-left-style: solid;
        border-left-width: 1px;
        border-right-color: #DADADA;
        border-right-style: solid;
        border-right-width: 1px;
        border-top-color: #DADADA;
        border-top-left-radius: 4px;
        border-top-right-radius: 4px;
        border-top-style: solid;
        border-top-width: 1px;
        clear: both;
        color: #666;
        display: block;
        float: none;
        font-size: 12px;
        height: 85px;
        margin-bottom: 28px;
        margin-left: 0px;
        margin-right: 20px;
        margin-top: 0;
        outline-color: #666;
        outline-style: none;
        outline-width: 0px;
        padding-bottom: 5px;
        padding-left: 10px;
        padding-right: 20px;
        padding-top: 10px;
        position: relative;
        width: 865px;
    }
</style>

<#assign brands = JiveGlobals.getJiveProperty("grail.brandList")?split(",") />
<#assign countries = JiveGlobals.getJiveProperty("grail.countryList")?split(",") />
<#assign periodMonth = JiveGlobals.getJiveProperty("grail.periodMonth")?split(",") />
<#assign periodYear = JiveGlobals.getJiveProperty("grail.periodYear")?split(",") />
<#assign methodology = JiveGlobals.getJiveProperty("grail.methodologyList")?split(",") />
	
<div id="custom_content_filter">
				<span class="jive-content-list-sort jive-content-list-sort-sortby">
                    <div id="custom_filter_top_div">
                        <!-- Brand dropdown -->
                        <label for="docBrand">Brand: </label>
                        
           <select name="docBrand" id="docBrand" class="customselect" onchange="javascript:changeResultType();">
                <option value="NA">Please Select</option>
				<#list brands as brand>
					<option value="${brand?string}" <#if docBrand?exists && docBrand.contains(brand)><#assign criteriea = true/>selected</#if>>${brand?string}</option>
				</#list>
            </select>

			<!-- Country dropdown -->
			<label for="docRegion">Country: </label>
			<select name="docRegion" id="docRegion" class="customselect" onchange="changeResultType();">
			<option value="NA">Please Select</option>
		<#list countries as country>
			<option value="${country?string}" <#if docRegion?exists && docRegion.contains(country)><#assign criteriea = true/>selected</#if>>${country?string}</option>
		</#list>
		</select>

                        <!-- Methodology dropdonw -->
                        <label for="docMethodology">Methodology: </label>
                        <select name="docMethodology" id="docMethodology" class="customselectwidth" onchange="changeResultType();">
                <option value="NA">Please Select</option>
            <#list methodology as md>
                <option value="${md?string}" <#if docMethodology?exists && docMethodology.contains(md)><#assign criteriea = true/>selected</#if>>${md?string}</option>
            </#list>
            </select>
                    </div>
                    <div id="custom_filter_bottom_div">
                        <table>
                            <tbody><tr>
                                <td>
                                    <!-- From block -->
                                    <fieldset style="border: 1px solid #dadada;padding:0.5em;margin:2px;width:340px">
                                        <legend>From</legend>
                                        <!-- From month-->
                                        <label for="docPeriodFromMonth">Month: </label>
                                        <select name="docPeriod" id="docPeriodFromMonth" class="customselect" onchange="javascript:changeResultType();">
											<option value="NA">Please Select</option>
										<#assign i=0 />
										<#list periodMonth as month>
											<option value="${i}" <#if docPeriod?exists && (docPeriod[0]?trim = i?string)><#assign criteriea = true/>selected</#if>>${month?string}</option>
											<#assign i = i+1 />
										</#list>
										</select>
                                        <!-- From year-->
                                        <label for="docPeriodFromYear">Year: </label>
                                        <select name="docPeriod" id="docPeriodFromYear" class="customselect" onchange="javascript:changeResultType();">
											<option value="NA">Please Select</option>
										<#list periodYear as year>
											<option value="${year?string}" <#if docPeriod?exists && docPeriod[1]?trim == year?trim?string><#assign criteriea = true/>selected</#if>>${year?string}</option>
										</#list>
										</select>
                                    </fieldset>
                                </td>
                                <td>
                                    <!-- To Block -->
                                    <fieldset style="border: 1px solid #dadada;padding:0.5em;margin:2px;width:340px">
                                        <legend>To</legend>
                                        <!-- To month-->
                                        <label for="docPeriodToMonth">Month: </label>
                                        <select name="docPeriod" id="docPeriodToMonth" class="customselect" onchange="javascript:changeResultType();">
											<option value="NA">Please Select</option>
										<#assign i=0 />
										<#list periodMonth as month>
											<option value="${i}" <#if docPeriod?exists && (docPeriod[2]?trim == i?string)><#assign criteriea = true/>selected</#if>>${month?string}</option>
											<#assign i = i+1 />
										</#list>
										</select>
                                        <!-- To year-->
                                        <label for="docPeriodToYear">Year: </label>
                                       <select name="docPeriod" id="docPeriodToYear" class="customselect" onchange="javascript:changeResultType();">
											<option value="NA">Please Select</option>
										<#list periodYear as year>
											<option value="${year?string}" <#if docPeriod?exists && (docPeriod[3]?trim == year?trim?string)><#assign criteriea = true/>selected</#if>>${year?string}</option>
										</#list>
										</select>
                                    </fieldset>
                                </td>
                            </tr>
                        </tbody></table>


                    </div>

                </span>
    <br clear="all">
</div>
</div>
</div>
<!-- end filters -->
<div class="jive-content-list">
<div class="search-title">
                <img src="/themes/rkp_theme/images/arrow.png" class="search-title-image" border="0" height="16" width="17">
                Please select the checkbox given below to add a study to the cart
            </div>
			
<div id="grail-info-box">
	<div>
		<span id="cart-dwr-msg"></span>
	</div>
</div>
<ul class="jive-content-list-search">
<#list documentsList as document>

<#assign isOnCart = statics['com.grail.cart.util.CartUtil'].isContentOrAttachmentsAlreadyOnCart(user, document.ID?c,document)/>
<input <#if isOnCart> checked </#if> type="checkbox" name="${document.ID?c}" value="${document.ID?c}" onClick="addContentAndAttachments( ${document.ID?c},'${document.subject?replace("'"," ")?html}', this );"/>

<li class="jive-content-list">

<a href="/docs/${document.getDocumentID()}" ><span class="jive-icon-med jive-icon-document"></span> ${document.getSubject()}</a>
<div class="jive-rendered-content">

${document.getSubject()}
</div>
<dl>
<dt>Author:</dt> <dd><a><@jive.userDisplayNameLink user=document.getUser() /></a></dd>
<dt>Date:</dt><dd> <span><#if document.creationDate?has_content>${document.creationDate?date}</#if></span></dd>
<dt>Location:</dt> <dd><a></a></dd>
<dt>Latest Activity:</dt> <dd><span>${document.modificationDate?date}</span></dd>
</dl>

<div class="grails-doc-props" style="overflow:hidden;">
	<#if document.properties('grail.brand')?exists>
		<div><span >Brand :</span>&nbsp;${document.properties('grail.brand')?string}&nbsp;</div>
	</#if>
	<#if document.properties('grail.country')?exists>
		<div><span >Country :</span>&nbsp;${document.properties('grail.country')?string}&nbsp;</div>
	</#if>
	<#if document.properties('grail.methodology')?exists>
		<div><span >Methodology : </span>&nbsp;${document.properties('grail.methodology')?string}&nbsp;</div>
	</#if>
	<#if document.properties('grail.month')?exists>
		<#assign month = document.properties('grail.month') />
		<#if month == '0'>
			<#assign month = 'January' />
		<#elseif month == '1'>
			<#assign month = 'February' />
		<#elseif month == '2'>
			<#assign month = 'March' />
		<#elseif month == '3'>
			<#assign month = 'April' />
		<#elseif month == '4'>
			<#assign month = 'May' />
		<#elseif month == '5'>
			<#assign month = 'June' />
		<#elseif month == '6'>
			<#assign month = 'July' />
		<#elseif month == '7'>
			<#assign month = 'August' />
		<#elseif month == '8'>
			<#assign month = 'September' />
		<#elseif month == '9'>
			<#assign month = 'October' />
		<#elseif month == '10'>
			<#assign month = 'November' />
		<#elseif month == '11'>
			<#assign month = 'December' />
		<#else>
			<#assign month = 'NA' />
		</#if>
		<div><span >Month : </span>&nbsp;${month}&nbsp;</div>
	</#if>
	<#if document.properties('grail.year')?exists>
		<div><span >Year : </span>&nbsp;${document.properties('grail.year')?trim}</div>
	</#if>
</div>
</li>


</#list>


</ul>
</div>
</div>
</div>
</div>

</form>

<script type="text/javascript">
function checkValues(){
        var searchForm = $j('#searchform');
       
		
            //var searchForm = document.getElementById("searchform");
           // $j("#searchForDocumentsOnly").val(false);
            //$j("#applyExtendedPropertyFilters").val(false);

            var periodFromMonth = $j('#docPeriodFromMonth').val();
            var periodFromYear = $j('#docPeriodFromYear').val();
            var periodToMonth = $j('#docPeriodToMonth').val();
            var periodToYear =  $j('#docPeriodToYear').val();
         //   var searchTerm =  $j('#jive-search-terms').val();
            var docBrand = $j('#docBrand').val();
            var docRegion = $j('#docRegion').val();
            var docMethodology =  $j('#docMethodology').val();
			var searchParam = $j('#searchParam').val();
			
	
			
           /* if( (docBrand != 'NA' || docRegion != 'NA' || docMethodology != 'NA' || periodFromMonth != 'NA' || periodFromYear != 'NA' || periodToMonth != 'NA' || periodToYear != 'NA')) {
    
				$j('#newSearch').val('true');
                $j("#searchForDocumentsOnly").val(true);
                $j("#applyExtendedPropertyFilters").val(true);
                $j('#resultTypes').val('document');
            } else {
    
				$j("#searchForDocumentsOnly").val(false);
                $j("#applyExtendedPropertyFilters").val(false);
                $j('#resultTypes').val('all');
            }
*/
            if( searchParam == '' && (docBrand == 'NA' && docRegion == 'NA' && docMethodology == 'NA' && periodFromMonth == 'NA' && periodFromYear == 'NA' && periodToMonth == 'NA' && periodToYear == 'NA') ) {
                alert('Please enter at least one search term or select from Brand, Country, Methodology, Period');
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                return false;
            }

            if(periodFromYear == 'NA' && periodFromMonth != 'NA') {
                alert('Please enter valid From Year');
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                return false;
            }

            if(periodFromMonth == 'NA' && periodFromYear != 'NA') {
                alert('Please enter valid From Month');
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                return false;
            }

            if(periodToYear == 'NA' && periodToMonth != 'NA') {
                alert('Please enter valid To Year');
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                return false;
            }

            if(periodToMonth == 'NA' && periodToYear != 'NA') {
                alert('Please enter valid To Month');
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                return false;
            }

            if((periodFromYear != 'NA' && periodFromMonth != 'NA') && (periodToYear == 'NA' && periodToMonth == 'NA')) {
                alert('Please enter valid To Year and Month');
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                return false;
            }

            if((periodFromYear == 'NA' && periodFromMonth == 'NA') && (periodToYear != 'NA' && periodToMonth != 'NA')) {
                alert('Please enter valid From Year and Month');
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                return false;
            }

            if((periodFromMonth != undefined && periodFromMonth.toLowerCase() == "NA".toLowerCase()) || (periodFromYear != undefined && periodFromYear.toLowerCase() == "NA".toLowerCase())
                    || (periodToMonth != undefined && periodToMonth.toLowerCase() == "NA".toLowerCase()) || (periodToYear != undefined && periodToYear.toLowerCase() == "NA".toLowerCase())){
                // searchForm.resultTypes.value = "document";
                $j('#jive-search-button-submit').val("Search");
                $j('#jive-search-button-submit').attr("disabled",false);
                //searchForm.newSearch.value = 'true';
                if( (docBrand != 'NA' || docRegion != 'NA' || docMethodology != 'NA'  || periodFromMonth != 'NA' || periodFromYear != 'NA' || periodToMonth != 'NA' || periodToYear != 'NA') ) {
                    $j('#resultTypes').val('document');
                }
                searchForm.submit();
                return true;
            } else {
                if((parseInt(periodToYear) > parseInt(periodFromYear)) || ((parseInt(periodToYear) == parseInt(periodFromYear)) && (parseInt(periodToMonth) >= parseInt(periodFromMonth)))) {
                    $j('#resultTypes').val("document");
                    //searchForm.newSearch.value = 'true';
                    $j('#newSearch').val('true');
                    if( (docBrand != 'NA' || docRegion != 'NA' || docMethodology != 'NA'  || periodFromMonth != 'NA' || periodFromYear != 'NA' || periodToMonth != 'NA' || periodToYear != 'NA') ) {
                        $j('#resultTypes').val('document');
                    }
                    searchForm.submit();
                    return true;
                }
                else {
                    if ((periodToYear == periodFromYear) && (parseInt(periodToMonth) < parseInt(periodFromMonth))) {
                        
						alert('Please enter valid From Month');
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
        
    }
	
	function changeResultType(){
        criteria = true;
       /* if($j('#jive-search-terms').val() == ''){
            //var searchForm = $j('#searchform');
            $j('#resultTypes').val('document');
        }*/
    }
</script>



