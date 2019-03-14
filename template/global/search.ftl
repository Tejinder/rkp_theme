<html>
<head>
<title><@s.text name="search.space_search.title"/></title>
<link rel="stylesheet" href="<@resource.url value='/styles/jive-search.css'/>" type="text/css" media="all" />

<#if (FeedUtils.isFeedsEnabled() && q??)>
<link rel="alternate" type="${FeedUtils.getFeedType()}"
      title="<@s.text name='search.srchResultsFeed.tooltip' />" href="${rSSSearchQuery?html}">
</#if>

<@resource.javascript file="/resources/scripts/containerpicker.js"/>

<script type="text/javascript">
    <#assign searchFormMoreLink><@s.text name="search.form.more.link" /> <@s.text name="search.form.options.link" /></#assign>
    var moreOptionsLinkText = '${searchFormMoreLink?js_string}';
    <#assign searchFormFewerLink><@s.text name="search.form.fewer.link" /> <@s.text name="search.form.options.link" /></#assign>
    var lessOptionsLinkText = '${searchFormFewerLink?js_string}';
</script>

<@resource.javascript file="/resources/scripts/jive/search.js"/>

<script type="text/javascript">
    var criteria = false;
    function showSearchTab(opensearch, theLink) {
        $j('#j-search-opensearch-tabs').children('li').removeClass('j-tab-selected active');
        $j('#jiveTab_0').removeClass('j-tab-selected active');
        $j(theLink).parent('li').addClass('j-tab-selected active');
        $j('.jive-search-results').hide();
        if (opensearch) {
            $j('#j-search-tabs').hide();
            $j('#jive-search-opensearch-' + opensearch).show();
        } else {
            $j('#j-search-tabs').show();
            $j('#jive-search-results-native').show();
        }
    }

    function doViewSearch(view){
        document.getElementById("searchform").view.value = view;
        document.getElementById("searchform").resultTypes.value = 'all';
        document.getElementById("searchform").submit();
    }

    function doSearch(resultType){
        if(resultType == null){
            resultType = "all";
        }

        document.getElementById("searchform").resultTypes.value = resultType;
        document.getElementById("searchform").submit();
    }

    function doDateRangeSearch(dateRangeID) {
        document.getElementById("searchform").dateRange.value = dateRangeID;
        document.getElementById("searchform").submit();
    }

    function doNameOnlySearch(nameOnly) {
        document.getElementById("peopleNameOnly").value = nameOnly;
        document.getElementById("searchform").submit();
    }

    function doFuzzyNameSearch(fuzzyName) {
        document.getElementById("peopleFuzzy").value = fuzzyName;
        document.getElementById("searchform").submit();
    }

    function changeResultType(){
        criteria = true;
        if($j('#jive-search-terms').val() == ''){
            //var searchForm = $j('#searchform');
            $j('#resultTypes').val('document');
        }
    }

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
        } else {
            searchForm.submit();
            return true;
        }
    }
</script>

<#if (showSearchLanguageSelection && allowedSearchLanguages.size() > 1)>
    <@resource.javascript header="true">
    function openLanguageSelection() {
    $j('#current-lang').hide()
    $j('#search-lang-options-container').show();
    }

    function cancelLanguageSelection() {
    $j('#search-lang-options-container').hide();
    $j('#current-lang').show();
    }
    </@resource.javascript>
</#if>

</head>
<body class="jive-body-search">

<#assign showOpenSearch = !user.anonymous || JiveGlobals.getJiveBooleanProperty('opensearch.allowAnonResultView', false)>
<#if (showOpenSearch)>
    <#assign engines = jiveContext.searchEngineManager.searchEngines>
    <#assign engineStats = jiveContext.searchEngineManager.stats>
</#if>
<#assign showOpenSearchSidebar = showOpenSearch && engineStats.enabledEngines/>

<!-- BEGIN header -->
<header class="j-page-header">
    <h1><span class="jive-icon-big jive-icon-search"></span><@s.text name="search.results.title" /></h1>
</header>
<!-- END header -->


<#include "/template/global/include/form-message.ftl"/>
<#include "/template/cart/cart-macros.ftl">

<#if legacyBreadcrumb>
<content tag="breadcrumb">
    <a href="<@s.url value='/'/>">${rootContainer.name?html}</a>
    <a href="#">Search</a>
</content>
</#if>

<form action="<@s.url value="/search.jspa" />" name="searchform" id="searchform" class="j-form">
<input type="hidden" id="view" name="view" value="${view!?html}" />
<input type="hidden" id="resultTypes" name="resultTypes" <#if (resultTypes.size() > 0)>value="${resultTypes[0]}"</#if> />
<input type="hidden" id="dateRange" name="dateRange" value="${dateRange?html}" />
<input type="hidden" id="newSearch" name="newSearch" value='false' />
<input type="hidden" id="searchForDocumentsOnly" name="searchForDocumentsOnly" value="false">
<input type="hidden" id="applyExtendedPropertyFilters" name="applyExtendedPropertyFilters" value="${applyExtendedPropertyFilters?string}">

<#if view == statics['com.jivesoftware.community.search.action.SearchAction'].VIEW_PEOPLE>
<input type="hidden" id="peopleNameOnly" name="peopleNameOnly" value="${peopleNameOnly?string}" />
<input type="hidden" id="peopleFuzzy" name="peopleFuzzy" value="${peopleFuzzy?string}" />

</#if>


<div class="j-layout j-layout-<#if showOpenSearchSidebar>sl<#else>l</#if> j-layout-search-form j-rc4 clearfix">
<#if showOpenSearchSidebar>
<!-- BEGIN small column -->
<div class="j-column-wrap-s">
    <div class="j-column j-column-s">

        <!-- BEGIN tabs (if opensearches are present) -->
        <nav class="j-search-opensearch-bridge">
            <h5><@s.text name="search.thiscommunity.header"/></h5>
            <ul class="j-search-source-selector">
                <li id="jiveTab_0" class="j-tab-selected active">
                    <a href="#" onClick="showSearchTab('', this); return false;">
                        <#if includeAdvancedCSS>
                            <img src="${themePath}/images/favicon.png" class="jive-bridge-favicon" border="0" height="16" width="16">
                        <#else>
                            <img src="<@s.url value="/favicon.png"  />" class="jive-bridge-favicon" border="0" height="16" width="16">
                        </#if>
                    ${jiveContext.communityManager.rootCommunity.name?html}</a>
                </li>
            </ul>

            <#if engineStats.enabledParseableEngines>
                <h5><@s.text name="search.othercommunities.header"/></h5>
                <ul id="j-search-opensearch-tabs" class="j-search-source-selector">
                    <#list engines as engine>
                        <#if (engine.enabled && engine.queryResultParseable)>
                            <li id="jiveTab_${engine.ID?c}">
                                <a href="#" onClick="showSearchTab('${engine.ID?c}', this); return false;"><#if (engine.iconURL?has_content)><img src="${engine.iconURL}" class="jive-bridge-favicon" height="16" width="16" border="0"/></#if>
                                ${engine.shortName} <span id="jive-search-opensearch-${engine.ID?c}-resultcount"></span></a>
                            </li>
                        </#if>
                    </#list>
                </ul>
            </#if>

            <#if engineStats.enabledNonParseableEngines>
                <h5><@s.text name="search.results.os.loctns.label"/></h5>
                <ul id="j-search-opensearch-tabs" class="j-search-source-selector">
                    <#list engines as engine>
                        <#if (engine.enabled && !engine.queryResultParseable)>
                            <li id="jiveTab_${engine.ID?c}">
                                <a href="${engine.getExternalSearchableURL('${q!?html}')}" target="_new" title="${engine.description!}">
                                    <#if (engine.iconURL?has_content)><img src="${engine.iconURL}" class="jive-bridge-favicon" height="16" width="16" border="0"/></#if>
                                ${engine.shortName}
                                </a>
                            </li>
                        </#if>
                    </#list>
                </ul>
            </#if>
        </nav>
        <!-- END tabs -->
    </div>
</div>
<!-- END small column -->
</#if>


<!-- BEGIN large column -->
<div class="j-column-wrap-l">
<div class="j-column j-column-l">

<!-- BEGIN search form -->
<div class="j-box j-box-form">
    <div class="j-box-body" id="jive-search-form">
        <input type="text" name="q" id="jive-search-terms" size="50" maxlength="100" value="${q!?html}"/>
    <#assign globalSearching><@s.text name="global.searching" /></#assign>
        <input type="submit" id="jive-search-button-submit" value="<@s.text name="global.search" />"
               onclick="this.disabled=true;this.value='${globalSearching?js_string}...';checkValues();return false;">

                    <span class="jive-search-terms-links clearfix">
                        <#if (showSearchLanguageSelection && allowedSearchLanguages.size() > 1)>
                            <span id="current-lang" class="jive-search-language">
                                <@s.text name="search.form.language.title"/><@s.text name="global.colon"/>
                                <strong>${action.getLanguageCodeDisplayName(language)}</strong>
                                <@s.text name="global.left_paren"/><a href="javascript:openLanguageSelection()"><@s.text name="global.change"/></a><@s.text name="global.right_paren"/>
                            </span>
                            <span id="search-lang-options-container" class="jive-search-language" style="display:none">
                                <label for="lang-options-select"><@s.text name="search.form.language.title"/></label>
                                <select id="lang-options-select" name="language" onchange="$j('#searchform').submit();">
                                    <#list allowedSearchLanguages as searchLanguage>
                                        <option value="${searchLanguage}" <#if (language == searchLanguage)>selected="selected"</#if>>${action.getLanguageCodeDisplayName(searchLanguage)}</option>
                                    </#list>
                                </select>
                                <span><@s.text name="global.left_paren"/><a href="javascript:cancelLanguageSelection();"><@s.text name="global.cancel"/></a><@s.text name="global.right_paren"/></span>
                            </span>
                        </#if>
                            <a href="#" class="j-searchtips-link" onclick="showSearchTips(); return false;"><@s.text name="search.search_tips.link" /></a>
                    </span>
    <@macroFieldErrors name="q"/>


    </div>
</div>
<!-- END search form -->




<!-- BEGIN tabs -->
<nav id="j-search-tabs" class="j-bigtab-nav j-rc5 j-rc-none-bottom">
    <ul class="j-tabbar">
        <#assign contentView = statics['com.jivesoftware.community.search.action.SearchAction'].VIEW_CONTENT/>
        <li id="jiveTab_${contentView}" <#if (view == contentView)>class="j-tab-selected active j-ui-elem"</#if>>
            <a href="javascript:doViewSearch('${contentView?js_string}')"<#if (view == contentView)> class="j-ui-elem"</#if>><@s.text name="global.content" /></a>
        </li>
        <#assign peopleView = statics['com.jivesoftware.community.search.action.SearchAction'].VIEW_PEOPLE/>
        <li id="jiveTab_${peopleView}" <#if (view == peopleView)>class="j-tab-selected active j-ui-elem"</#if>>
            <a href="javascript:doViewSearch('${peopleView?js_string}')"<#if (view == peopleView)> class="j-ui-elem"</#if>><@s.text name="global.people" /></a>
        </li>
        <#assign placesView = statics['com.jivesoftware.community.search.action.SearchAction'].VIEW_PLACES/>
        <li id="jiveTab_${placesView}" <#if (view == placesView)>class="j-tab-selected active j-ui-elem"</#if>>
            <a href="javascript:doViewSearch('${placesView?js_string}')"<#if (view == placesView)> class="j-ui-elem"</#if>><@s.text name="global.places" /></a>
        </li>
        <#assign wallEntryTypeCode = action.getObjectTypeCode(JiveConstants.WALL_ENTRY)>
        <#if (action.isTypeEnabled(wallEntryTypeCode))>
            <#assign updatesView = statics['com.jivesoftware.community.search.action.SearchAction'].VIEW_STATUS_UPDATES/>
            <li id="jiveTab_${updatesView}" <#if (view == updatesView)>class="j-tab-selected active j-ui-elem"</#if>>
                <a href="javascript:doViewSearch('${updatesView?js_string}')"<#if (view == updatesView)> class="j-ui-elem"</#if>><@s.text name="global.status" /></a>
            </li>
        </#if>
        <#assign dmTypeCode = action.getObjectTypeCode(ActivityConstants.DIRECT_MESSAGE)>
        <#if (!user.anonymous && action.isTypeEnabled(dmTypeCode))>
            <#assign messagesView = statics['com.jivesoftware.community.search.action.SearchAction'].VIEW_DIRECT_MESSAGES/>
            <li id="jiveTab_${messagesView}" <#if (view == messagesView)>class="j-tab-selected active j-ui-elem"</#if>>
                <a href="javascript:doViewSearch('${messagesView?js_string}')"<#if (view == messagesView)> class="j-ui-elem"</#if>><@s.text name="global.direct_messages" /></a>
            </li>
        </#if>

    </ul>
</nav>
<!-- END tabs -->
<#--<#if ((q?? && q != '') || applyExtendedPropertyFilters || q == '')>-->

<!-- BEGIN search results -->
<div class="jive-search-results j-contained j-rc4 j-rc-none-top <#if (showOpenSearch && engineStats.enabledParseableEngines)>j-contained-tabs j-rc-none-top</#if> clearfix" id="jive-search-results-native">

<!-- BEGIN search content -->
<div id="jive-search-content" class="j-box-body j-rc4">

<!-- BEGIN search result content -->
<div id="jive-search-results-content">

<!-- BEGIN search result options -->
<div class="j-browse-filters j-box-controls j-rc4  <#if (!showOpenSearch || !engineStats.enabledParseableEngines)>jive-noOpenSearch</#if>">

    <div class="j-browse-sorts">

        <#if (view == statics['com.jivesoftware.community.search.action.SearchAction'].VIEW_CONTENT)>
            <@customcontentFilter/>
            <@contentOptions/>

        <#elseif (view == statics['com.jivesoftware.community.search.action.SearchAction'].VIEW_PLACES)>

            <@placeOptions/>

        <#elseif (view == statics['com.jivesoftware.community.search.action.SearchAction'].VIEW_PEOPLE)>

            <@peopleOptions />

        <#else>

            <@realtimeOptions />

        </#if>



        <#assign paginator = newPaginator>
        <#if (paginator.numPages > 1)>
            <!-- BEGIN pagination-->
            <div class="j-pagination">
                <#list paginator.getPages(3) as page>
                    <#if (page??)>
                        <#if (page.start == start)>
                            <a href="<@s.url action='search'><@s.param name='start' value='${page.start?c}'/></@s.url>&${searchParams}"
                               class="j-pagination-current font-color-normal" rel="nozoom"><strong>${page.number}</strong></a>
                        <#else>
                            <a href="<@s.url action='search'><@s.param name='start' value='${page.start?c}'/></@s.url>&${searchParams}"
                               rel="nozoom">${page.number}</a>
                        </#if>
                    <#else>
                        <span class="ellipsis">&hellip;</span>
                    </#if>
                </#list>
                <span class="j-pagination-prevnext">
                                                <#if (paginator.previousPage)>
                                                    <a class="j-pagination-prev" title="<@s.text name="global.previous_page_title"/>" href="<@s.url action='search'><@s.param name='start' value='${paginator.previousPageStart?c}'/></@s.url>&${searchParams}" class="jive-pagination-prev" rel="nozoom"><@s.text name="global.previous"/></a>
                                                <#else>
                                                    <span class="j-pagination-prev j-disabled font-color-meta"><@s.text name="global.previous"/></span>
                                                </#if>
                    <#if (paginator.nextPage)>
                        <a class="j-pagination-next" title="<@s.text name="global.next_page_title"/>"  href="<@s.url action='search'><@s.param name='start' value='${paginator.nextPageStart?c}'/></@s.url>&${searchParams}" class="jive-pagination-next" rel="nozoom"><@s.text name="global.next"/></a>
                    <#else>
                        <span class="j-pagination-next j-disabled font-color-meta"><@s.text name="global.next"/></span>
                    </#if>
                                        </span>
            </div>
            <!-- END pagination -->
        </#if>

    </div>
</div>

    <#if showInfoDefault && !wildcardIgnored && userShowInfo && spotlight>
        <@displaySpotlightWildcardInfo/>
    </#if>


    <#if (view == statics['com.jivesoftware.community.search.action.SearchAction'].VIEW_PEOPLE)>
        <#if (!peopleResults?? || !peopleResults.hasNext())>

            <@displayNoResults/>

        <#else>

        <div class="jive-content-list">
            <ul class="jive-content-list-search j-people-list">
                <#list peopleResults as result>
                    <li>
                        <div class="jive-avatar-wrap">
                            <@jive.userAvatar user=result size=46 />
                        </div>
                        <div class="jive-people-results-wrap">
                            <@jive.userDisplayNameLink user=result/>
                            <#if result.title?has_content>
                                <p class="font-color-meta">${result.title?html}</p>
                            </#if>
                            <#if result.department?has_content>
                                <p>${result.department?html}</p>
                            </#if>
                            <#if result.location?has_content>
                                <p>${result.location?html}</p>
                            </#if>
                            <#if result.email?has_content>
                                <p>${result.email?html}</p>
                            </#if>
                        </div>
                    </li>
                </#list>
            </ul>
        </div>
        </#if>

    <#else>
        <#if (!results?? || !results.hasNext())>
            <@displayNoResults/>

        <#else>

        <div class="jive-content-list">
            <div class="search-title">
                <img src="${themePath}/images/arrow.png" class="search-title-image" border="0" height="16" width="17">
                Please select the checkbox given below to add a study to the cart
            </div>
            <div id="grail-info-box">
                <div>
                    <span id="cart-dwr-msg"></span>
                </div>
            </div>

            <ul class="jive-content-list-search">
                <#list results as result>
                    <#if result.jiveObjectType == JiveConstants.DOCUMENT>
                        <#assign document = jiveContext.getDocumentManager().getDocument(result.jiveObjectID?long)/>
                    </#if>

                    <li class="<#if result_index % 2 == 0>jive-content-list-odd<#else>jive-content-list-even</#if>">
                        <#if result.jiveObjectType == JiveConstants.DOCUMENT>
                            <#assign isOnCart = statics['com.grail.cart.util.CartUtil'].isContentOrAttachmentsAlreadyOnCart(action.user, document.ID?c,document)/>
                            <input <#if isOnCart> checked </#if> type="checkbox" name="${document.ID?c}" value="${document.ID?c}" onClick="addContentAndAttachments( ${document.ID?c},'${document.subject?replace("'"," ")?html}', this );"/>
                        </#if>
                        <a href="<@s.url value='${result.contentUrl}'/>" class="jive-link-subject">
                            <#assign iconElement = SkinUtils.getJiveObjectIcon(result.jiveObject, 1)! />
                            <#if iconElement??><@jive.renderIconElement iconElement /><#else>
                                <span class="${SkinUtils.getJiveObjectCss(result.jiveObject, 1)}" ></span>
                            </#if>
                        ${action.getRenderedHighlightedText(result.entityDescriptor, result.highlightedSubject)}
                        </a>
                    ${action.getRenderedHighlightedText(result.entityDescriptor, result.highlightedBody)}
                        <dl>
                            <#if result.author?has_content>
                                <dt><@s.text name="search.result.author"/><@s.text name="global.colon"/></dt>
                                <dd><@jive.userDisplayNameLink user=result.author /></dd>
                            </#if>
                            <dt><@s.text name="search.result.date"/><@s.text name="global.colon"/></dt>
                            <dd><span><#if result.creationDate?has_content>${result.creationDate?date}</#if></span></dd>
                            <#if result.containerInfoAvailable>
                                <dt><@s.text name="search.result.location"/><@s.text name="global.colon"/></dt>
                                <dd>
                                    <a href="<@s.url value='${result.containerUrl}'/>">${result.containerName}</a>
                                </dd>
                            </#if>

                            <#if result.favoriteCountAvailable>
                                <dt><@s.text name="search.form.bookmark.label"/><@s.text name="global.colon"/></dt>
                                <dd><span>${result.favoriteCount}</span></dd>
                            </#if>

                            <#if result.likingAvailable>
                                <dt><@s.text name="search.form.likes.label"/><@s.text name="global.colon"/></dt>
                                <dd><span>${result.likes}</span></dd>
                            </#if>

                            <dt><@s.text name="search.result.latest_activity"/><@s.text name="global.colon"/></dt>
                            <dd><span>${result.modificationDate?date}</span></dd>
                        </dl>
                        <#if result.highlightedTags?? && result.highlightedTags != ''>
                            <dl>
                                <dt><@s.text name="search.tags.label" /></dt>
                                <dd>${action.getRenderedHighlightedText(result.entityDescriptor, result.highlightedTags)}</dd>
                            </dl>
                        </#if>
                        <#if result.jiveObjectType == JiveConstants.DOCUMENT>
                            <#if document?exists && document.properties?exists>
                                <div class="grails-doc-props" style="overflow:hidden;">
                                    <#if document.properties('grail.brand')?exists>
                                        <div style="color:#666666;float:left;font-size:0.8889em;font-weight:normal; padding-right:5px;"><span style="font-weight:bold;">Brand :</span>&nbsp;${document.properties('grail.brand')?string}&nbsp;</div>
                                    </#if>
                                    <#if document.properties('grail.country')?exists>
                                        <div style="color:#666666;float:left;font-size:0.8889em;font-weight:normal; padding-right:5px;"><span style="font-weight:bold;">Country :</span>&nbsp;${document.properties('grail.country')?string}&nbsp;</div>
                                    </#if>
                                    <#if document.properties('grail.methodology')?exists>
                                        <div style="color:#666666;float:left;font-size:0.8889em;font-weight:normal; padding-right:5px;"><span style="font-weight:bold;">Methodology : </span>&nbsp;${document.properties('grail.methodology')?string}&nbsp;</div>
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
                                        <div style="color:#666666;float:left;font-size:0.8889em;font-weight:normal; padding-right:5px;"><span style="font-weight:bold;">Month : </span>&nbsp;${month}&nbsp;</div>
                                    </#if>
                                    <#if document.properties('grail.year')?exists>
                                        <div style="color:#666666;float:left;font-size:0.8889em;font-weight:normal;"><span style="font-weight:bold;">Year : </span>&nbsp;${document.properties('grail.year')?trim}</div>
                                    </#if>
                                </div>
                            </#if>
                        </#if>
                    </li>
                </#list>
            </ul>
        </div>

        </#if>


    <!-- BEGIN search footer -->
    <div class="j-browse-sorts jive-search-results-footer clearfix">

        <!-- BEGIN results per page dropdown -->
                                    <span class="jive-items-per-page">
                                        <select name="numResults" onChange="javascript:checkValues()">
                                            <#list statics['com.jivesoftware.community.search.action.SearchAction'].RESULT_OPTIONS as option>
                                                <option value="${option}" <#if numResults == option>selected="selected"</#if>>${option}</option>
                                            </#list>
                                        </select><span><@s.text name="search.items_per_page.label" /></span>
                                    </span>
        <!-- END results per page dropdown -->

        <!-- BEGIN search RSS link -->
        <#if FeedUtils.isFeedsEnabled()>
            <span class="jive-search-rss-link">
                                            <a href="${rSSSearchQuery?html}" title="<@s.text name='search.rssFeedOfList.tooltip'/>" rel="nozoom"><span class="jive-icon-sml jive-icon-rss"></span><@s.text name="search.rssFeedOfList.link"/></a>
                                        </span>
        </#if>
        <!-- END search RSS link -->

        <#assign paginator = newPaginator>
        <#if (paginator.numPages > 1)>
            <!-- BEGIN pagination-->
                                        <span class="j-pagination">
                                            <#list paginator.getPages(3) as page>
                                                <#if (page??)>
                                                    <#if (page.start == start)>
                                                        <a href="<@s.url action='search'><@s.param name='start' value='${page.start?c}'/></@s.url>&${searchParams}"
                                                           class="j-pagination-current font-color-normal" rel="nozoom"><strong>${page.number}</strong></a>
                                                    <#else>
                                                        <a href="<@s.url action='search'><@s.param name='start' value='${page.start?c}'/></@s.url>&${searchParams}"
                                                           rel="nozoom">${page.number}</a>
                                                    </#if>
                                                <#else>
                                                    <span class="ellipsis">&hellip;</span>
                                                </#if>
                                            </#list>
                                            <span class="j-pagination-prevnext">
                                                <#if (paginator.previousPage)>
                                                    <a class="j-pagination-prev" title="<@s.text name="global.previous_page_title"/>" href="<@s.url action='search'><@s.param name='start' value='${paginator.previousPageStart?c}'/></@s.url>&${searchParams}" class="jive-pagination-prev" rel="nozoom"><@s.text name="global.previous"/></a>
                                                <#else>
                                                    <span class="j-pagination-prev j-disabled font-color-meta"><@s.text name="global.previous"/></span>
                                                </#if>
                                                <#if (paginator.nextPage)>
                                                    <a class="j-pagination-next" title="<@s.text name="global.next_page_title"/>" href="<@s.url action='search'><@s.param name='start' value='${paginator.nextPageStart?c}'/></@s.url>&${searchParams}" class="jive-pagination-next" rel="nozoom"><@s.text name="global.next"/></a>
                                                <#else>
                                                    <span class="j-pagination-next j-disabled font-color-meta"><@s.text name="global.next"/></span>
                                                </#if>
                                            </span>
                                        </span>
            <!-- END pagination -->
        </#if>
    </div>
    <!-- END search footer -->


    </#if>

</div>
<!-- END search result content -->


</div>
<!-- END search content -->

</div>
<!-- END search results -->



<!-- BEGIN OpenSearch results -->
    <#if (showOpenSearch && engineStats.enabledParseableEngines)>

        <#list engines as engine>
            <#if (engine.enabled && engine.queryResultParseable)>

            <div class="jive-search-results j-contained j-rc4 j-contained-tabs j-rc-none-top clearfix" id="jive-search-opensearch-${engine.ID?c}" style="display: none">
                <div class="jive-search-results-opensearch">

                    <div class="jive-content-list-options jive-search-options">
                        <div class="jive-search-results-opensearch-more">
                            <a href="${engine.getExternalSearchableURL('${q!?html}')}"><span class="jive-icon-sml jive-icon-arrow-generic-up"></span><@s.text name="search.results.os.view_more"><@s.param>${engine.shortName}</@s.param></@s.text></a>
                        </div>
                    </div>

                    <ul id="jive-search-opensearch-${engine.ID?c}-list" title="OpenSearchResults"></ul>
                    <a id="jive-search-opensearch-${engine.ID?c}-link" style="display:none" href="${engine.getExternalSearchableURL('${q!?html}')}" class="jive-search-opensearch-more"><@s.text name="search.results.morefrom.label" /> ${engine.shortName}</a>
                </div>
            </div>

            </#if>
        </#list>

    </#if>
<!-- END OpenSearch results -->

<#--<#else>-->
<#--<!-- Preserve any previous settings for filters &ndash;&gt;-->
    <#--<#if (view == statics['com.jivesoftware.community.search.action.SearchAction'].VIEW_CONTENT)>-->
        <#--<@contentOptionsNoQuery />-->

    <#--<#elseif (view == statics['com.jivesoftware.community.search.action.SearchAction'].VIEW_PLACES)>-->

        <#--<@placeOptionsNoQuery />-->

    <#--<#else>-->

        <#--<@realtimeOptionsNoQuery />-->

    <#--</#if>-->
<#--</#if>-->



</div>
</div>
<!-- END large column -->



</div>
<!-- END layout -->

</form>

<#include "/template/global/include/jive-macros.ftl" />
<script type="text/javascript">
    $j(document).ready(function() {
        var startingUsers = <@userAutocompleteUsers user=searchedUser />
        var autocomplete = new jive.UserPicker.Main({
            startingUsers: startingUsers,
            multiple: false,
            $input : $j('#jive-user-chooser')
        });
        autocomplete.addListener('selectedUsersChanged', function(usersAndList) {
            $j('#searchform').submit();
        });

    });

    var autocompletePlaceTypes = [];
    <#list placeTypes as placeType>
    autocompletePlaceTypes.push(${placeType?js_string});
    </#list>
    var autocompleteContainer = new JiveContainerPicker({'validTypes': autocompletePlaceTypes, 'showRootCommunity': false});
    autocompleteContainer.addContainerHook = function(selected) {
        $j('#searchform').submit();
    };
    autocompleteContainer.removeContainerHook = function() {
        $j('#searchform').submit();
    };

</script>

<!-- only load this stuff if there are registered parseable openSearch engines -->
<#if (showOpenSearch && engineStats.enabledParseableEngines)>
    <@resource.dwr file="OpenSearchQuery" utils="true" />
    <@resource.javascript file="/resources/scripts/opensearchquery.js"/>
<script type="text/javascript">

        <@s.text name="search.results.os.searching.label" id="searchingLabel"/>
        <@s.text name="search.results.os.error.label" id="errorLabel" />
    var osQuery = new jive.OSQuery("${q!?js_string}", " (${searchingLabel?js_string})", "${errorLabel?js_string}");
    $j(document).ready(function() {
        <#list engines as engine>
            <#if (engine.enabled)>
                <#if (engine.queryResultParseable)>
                    osQuery.loadOpenSearchResults(${engine.ID?c});
                </#if>
            </#if>
        </#list>
    });

</script>
</#if>
<!-- only load this stuff if there are registered parseable openSearch engines -->



<div class="jive-modal jive-modal-searchtips" id="jive-author-by-email-modal">
    <header>
        <h2><@s.text name="search.search_tips.gtitle"/></h2>
    </header>
    <a href="#" class="j-modal-close-top close"><@s.text name="global.close"/> <span class="j-close-icon j-ui-elem"></span></a>
    <div class="jive-modal-content" id="search-tips-modal">

        <div id="highlightbox" class="j-rc4">
            <h4><@s.text name="searchtips.howto.gtitle"/></h4>
            <p><@s.text name="searchtips.howto.instruc"/><@s.text name="global.colon"/></p>
            <ol>
                <li><strong><@s.text name="searchtips.use_quotes.text"/></strong>
                    <p><@s.text name="searchtips.a_search_for.text"/> <tt><@s.text name="searchtips.black_cat_term.text"/></tt> <@s.text name="searchtips.black_cat_srch.info"/></p></li>
                <li><strong><@s.text name="searchtips.choose_space"/></strong>
                    <p><@s.text name="searchtips.choose_where.text"/></p></li>
                <li><strong><@s.text name="searchtips.choose_period.text"/></strong>
                    <p><@s.text name="searchtips.choose_when.text"/></p></li>
            </ol>
        </div>

        <section>
            <h4><@s.text name="searchtips.advanced_help.gtitle"/></h4>
            <p><@s.text name="searchtips.more_tips.msg"/><@s.text name="global.colon"/></p>
            <ul>
                <li><a href="#basic"><@s.text name="searchtips.words_unordered.text"/></a> </li>
                <li><a href="#phrase"><@s.text name="searchtips.words_ordered.text"/></a> </li>
                <li><a href="#wildcard"><@s.text name="searchtips.certain_letters.text"/></a> </li>
                <li><a href="#fuzzy"><@s.text name="searchtips.fuzzy_terms.text"/></a> </li>
                <li><a href="#proximity"><@s.text name="searchtips.similar_words.text"/></a> </li>
                <li><a href="#boolean"><tt><@s.text name="searchtips.this.text"/></tt>
                <@s.text name="searchtips.word.text"/> OR <tt><@s.text name="searchtips.that.text"/></tt>
                <@s.text name="searchtips.word.text"/><@s.text name="global.semi_colon"/> <tt><@s.text name="searchtips.this.text"/></tt>
                <@s.text name="searchtips.word.text"/> AND <tt><@s.text name="searchtips.that.text"/></tt>
                <@s.text name="searchtips.word.text"/><@s.text name="global.period"/></a>
                </li>
                <li><a href="#scoping"><@s.text name="searchtips.scoping.gtitle"/></a></li>
            </ul>
            <p><@s.text name="searchtips.you_can.text"/> <a href="#exclude"><span><em><@s.text name="searchtips.exclude.text"/></em></span>
            <@s.text name="searchtips.certain_words.text"/><@s.text name="global.period"/></a>
            </p>
            <p><@s.text name="searchtips.you_can_also.text"/><@s.text name="global.colon"/></p>
            <ul>
                <li><a href="#boosting"><@s.text name="searchtips.boosting.text"/></a></li>
                <li><a href="#escaping"><@s.text name="searchtips.escaping.text"/></a></li>
            </ul>
        </section>

        <section>
            <h4><a name="basic"></a><@s.text name="searchtips.basic_help.gtitle"/></h4>
            <p><@s.text name="searchtips.basic_help.instruc"/><@s.text name="global.colon"/></p>
            <blockquote> <tt><@s.text name="searchtips.black_cat_adopt.text"/></tt> </blockquote>
            <p><@s.text name="searchtips.search_for_doc.text"/> <tt><@s.text name="searchtips.black.text"/></tt>,
                <tt><@s.text name="searchtips.cat.text"/></tt> <@s.text name="searchtips.and.text"/>
                <tt><@s.text name="searchtips.adoption.text"/></tt><@s.text name="global.period"/></p>
        </section>

        <section>
            <h4><a name="phrase"></a><@s.text name="searchtips.basic.ordered.text"/></h4>
            <p><@s.text name="searchtips.basic.qt_phrase.text"/><@s.text name="global.colon"/></p>
            <blockquote> <tt><@s.text name="searchtips.black_cat_term.text"/></tt> </blockquote>
            <p><@s.text name="searchtips.basic.phrase.info"/></p>
        </section>

        <section>
            <h4><a name="wildcard"></a><@s.text name="searchtips.basic.wildcards.text"/></h4>
            <p><@s.text name="searchtips.basic.wldcrds.intruc"/> <tt><@s.text name="global.question_mark"/></tt> <@s.text name="searchtips.and.text"/> <tt>*</tt>.</p>
            <p><@s.text name="searchtips.singleCharWcard.text"/> (<tt><@s.text name="global.question_mark"/></tt>)
            <@s.text name="searchtips.singleCharWcard.info"/>
                <tt><@s.text name="searchtips.text.text"/></tt> <@s.text name="global.or"/>
                <tt><@s.text name="searchtips.test.text"/></tt> <@s.text name="searchtips.use_following.text"/><@s.text name="global.colon"/>
            </p>
            <blockquote> <tt><@s.text name="searchtips.singleCharExmpl.text"/></tt> </blockquote>
            <p><@s.text name="searchtips.multiCharWldcrd.text"/> (<tt>*</tt>)
            <@s.text name="searchtips.rprsntsMultiChr.text"/> <tt><@s.text name="searchtips.test.text"/></tt>, <tt><@s.text name="searchtips.tests.text"/></tt> <@s.text name="global.or"/> <tt><@s.text name="searchtips.tester.text"/></tt>, <@s.text name="searchtips.youCanUseSearch.text"/><@s.text name="global.colon"/></p>
            <blockquote> <tt><@s.text name="searchtips.test.text"/>*</tt> </blockquote>
            <p><@s.text name="searchtips.useWcrdInMiddle.text"/></p>
            <blockquote> <tt><@s.text name="searchtips.multiCharExmpl.text"/></tt> </blockquote>
            <p><@s.text name="searchtips.youCannotUse.long"><@s.param><tt>*</tt></@s.param><@s.param><tt>?</tt></@s.param></@s.text></p>
        </section>

        <section>
            <h4><a name="fuzzy"></a><@s.text name="searchtips.fuzzy.gtitle"/></h4>
            <p><@s.text name="searchtips.fuzzy.info"/> <tt><@s.text name="searchtips.foam.text"/></tt>
            <@s.text name="searchtips.add_a_tilde.text"/> (<tt>~</tt>)
            <@s.text name="searchtips.to_your_term.text"/><@s.text name="global.colon"/></p>
            <blockquote> <tt><@s.text name="searchtips.foam.text"/>~</tt> </blockquote>
            <p><@s.text name="searchtips.matchTermsLike.text"/> <tt><@s.text name="searchtips.foam.text"/></tt><@s.text name="searchtips.and.text"/> <tt><@s.text name="searchtips.roams.text"/></tt><@s.text name="global.period"/></p>
        </section>

        <section>
            <h4><a name="proximity"></a><@s.text name="searchtips.proximitySrch.gtitle"/></h4>
            <p><@s.text name=""/> <tt><@s.text name="searchtips.new.text"/></tt> <@s.text name="searchtips.and.text"/> <tt>car</tt> <@s.text name="searchtips.are_within_five.text"/><@s.text name="global.colon"/></p>
            <blockquote> <tt><@s.text name="searchtips.new_car_term.text"/>~5</tt> </blockquote>
        </section>

        <section>
            <h4><a name="boosting"></a><@s.text name="searchtips.boosting.gtitle"/></h4>
            <p><@s.text name="searchtips.boosting.info"/> <tt><@s.text name="searchtips.black_cat.text"/></tt> <@s.text name="searchtips.boosting.instruc"/><@s.text name="global.colon"/> </p>
            <blockquote> <tt><@s.text name="searchtips.black_cat.text"/>^4</tt> </blockquote>
            <p><@s.text name="searchtips.boost_phrases.text"/><@s.text name="global.colon"/></p>
            <blockquote> <tt><@s.text name="searchtips.black_cat_term.text"/>^<@s.text name="searchtips.four_adopt.text"/></tt> </blockquote>
            <p><@s.text name="searchtips.boost_term.instruc"/><@s.text name="global.colon"/></p>
            <blockquote> <tt><@s.text name="searchtips.black_cat_term.text"/>^<@s.text name="searchtips.six_adopt.text"/></tt> </blockquote>
        </section>

        <section>
            <h4><a name="boolean"></a><@s.text name="searchtips.srchContentWith.text"/> <tt><@s.text name="searchtips.this.text"/></tt> <@s.text name="searchtips.word.text"/> OR <tt><@s.text name="searchtips.that.text"/></tt> <@s.text name="searchtips.word.text"/>; <tt><@s.text name="searchtips.this.text"/></tt> <@s.text name="searchtips.word.text"/> AND <tt><@s.text name="searchtips.that.text"/></tt> <@s.text name="searchtips.word.text"/>.</h4>
            <p><@s.text name="searchtips.booleanOperator.info"/> <tt>AND</tt>,<tt>+</tt>,
                <tt>OR</tt>, <tt>NOT</tt> <@s.text name="searchtips.and.text"/> <tt>-</tt>
            <@s.text name="searchtips.using_operators.text"/></p>

            <h5><@s.text name="searchtips.using.gtitle"/> OR</h5>
            <p> <@s.text name="searchtips.the_large_cap.text"/> <tt>OR</tt>
            <@s.text name="searchtips.or_operator.info"/> <tt>||</tt> <@s.text name="searchtips.used_in_place.text"/> <tt>OR</tt><@s.text name="global.period"/>
            <@s.text name="searchtips.use_or_query.text"/><@s.text name="global.colon"/></p>
            <blockquote> <tt><@s.text name="searchtips.black_cat_term.text"/> OR <@s.text name="searchtips.catAdoptionTerm.text"/></tt> </blockquote>
            <p><@s.text name="global.or"/></p>
            <blockquote> <tt><@s.text name="searchtips.black_cat_term.text"/> || <@s.text name="searchtips.catAdoptionTerm.text"/></tt> </blockquote>
            <p><strong><@s.text name="searchtips.note.text"/><@s.text name="global.colon"/></strong> <tt>OR</tt>
            <@s.text name="searchtips.opUsageSummary.info"/><@s.text name="global.colon"/></p>
            <blockquote> <tt><@s.text name="searchtips.black_cat_term.text"/> <@s.text name="searchtips.catAdoptionTerm.text"/></tt> </blockquote>

            <h5><@s.text name="searchtips.using.gtitle"/> AND</h5>
            <p><@s.text name="searchtips.the_large_cap.text"/> <tt>AND</tt> <@s.text name="searchtips.and_op_info.text"/> <tt>&amp;&amp;</tt> <@s.text name="searchtips.used_in_place.text"/>
                <tt>AND</tt>. <@s.text name="searchtips.use_and_query.text"/> <i><@s.text name="searchtips.both.text"/></i> <@s.text name="searchtips.black_cat_term.text"/>
                <i><@s.text name="searchtips.and.text"/></i> <@s.text name="searchtips.just_cat_adop.text"/><@s.text name="global.colon"/>
            </p>
            <blockquote> <tt><@s.text name="searchtips.black_cat_term.text"/> AND  <@s.text name="searchtips.catAdoptionTerm.text"/></tt> </blockquote>
            <p><@s.text name="global.or"/> <@s.text name="searchtips.this.text"/><@s.text name="global.colon"/></p>
            <blockquote> <tt><@s.text name="searchtips.black_cat_term.text"/> &amp;&amp; <@s.text name="searchtips.catAdoptionTerm.text"/></tt> </blockquote>
            <p><@s.text name="searchtips.get_fancy.instruc"/><@s.text name="global.colon"/></p>
            <blockquote> <tt>(<@s.text name="searchtips.black.text"/> OR <@s.text name="searchtips.orange.text"/> OR <@s.text name="searchtips.white.text"/>) AND <@s.text name="searchtips.cat.text"/></tt> </blockquote>

            <h5><a name="exclude"></a><@s.text name="searchtips.exclude_words.gtitle"/> <i><@s.text name="searchtips.does_not.text"/></i> <@s.text name="searchtips.hvCertainWords.text"/></h5>
            <p><@s.text name="searchtips.the_large_cap.text"/> <tt>NOT</tt> <@s.text name="searchtips.excl_operator.text"/>
                <tt>NOT</tt>. <@s.text name="searchtips.you_can_use_the.text"/> <tt>!</tt> <@s.text name="searchtips.symInPlaceOfWrd.text"/>
                <tt>NOT</tt>. <@s.text name="searchtips.not_op_howto.text"/><@s.text name="global.colon"/></p>
            <blockquote> <tt><@s.text name="searchtips.black_cat_term.text"/> NOT <@s.text name="searchtips.catAdoptionTerm.text"/></tt> </blockquote>
            <p><@s.text name="global.or"/></p>
            <blockquote> <tt><@s.text name="searchtips.black_cat_term.text"/> ! <@s.text name="searchtips.catAdoptionTerm.text"/></tt> </blockquote>
            <p><strong><@s.text name="searchtips.note.text"/><@s.text name="global.colon"/></strong>
            <@s.text name="searchtips.the_large_cap.text"/> NOT <@s.text name="searchtips.not_op_warning_part.info"/><@s.text name="global.colon"/></p>
            <blockquote> <tt>NOT <@s.text name="searchtips.black_cat_term.text"/></tt> </blockquote>
        </section>

        <section>
            <h4><a name="scoping"></a><@s.text name="searchtips.scoping.gtitle"/></h4>
            <p><@s.text name="searchtips.scoping.info"/><@s.text name="searchtips.cat.text"/><@s.text name="searchtips.scoping.subject.text"/></p>
            <blockquote><tt><@s.text name="searchtips.scoping.subject.term"/>:<@s.text name="searchtips.cat.text"/></tt></blockquote>
        </section>

        <section>
            <h4><a name="escaping"></a><@s.text name="searchtips.escaping.gtitle"/></h4>
            <p><@s.text name="searchtips.special_chars.msg"/></p>
            <p><@s.text name="searchtips.special_chars.label"/><@s.text name="global.colon"/></p>
            <blockquote> <tt>+ - &amp;&amp; || ! ( ) { } [ ] ^ " ~ * ? \</tt> </blockquote>
            <p><@s.text name="searchtips.to_escape_chars_text"/> <tt>\</tt> <@s.text name="searchtips.before_the_char.text"/> <tt>(1+1)-2</tt>, <@s.text name="searchtips.has_special_chr.text"/> <tt>(</tt>, <tt>)</tt>,<tt>+</tt>, <@s.text name="searchtips.and.text"/> <tt>:</tt>, <@s.text name="searchtips.use_the_query.text"/><@s.text name="global.colon"/></p>
            <blockquote> <tt>\(1\+1\)\-2</tt> </blockquote>
        </section>

    </div>
</div>


</body>

</html>

<#macro displaySpotlightWildcardInfo>
<div id="jive-search-info" class="clearfix">

    <div class="jive-search-info-type jive-search-info-wildcardsearch" id="jive-search-info-wildcardsearch">

        <div class="jive-search-info-header">
            <div class="jive-search-info-title">
                <span class="jive-icon-med jive-icon-question"></span>
                <a class="jive-search-info-details-toggle" href="#"><@s.text name="search.info.wildcard.title" /></a>
            </div>
            <ul>
                <li>
                    <a class="jive-search-info-details-toggle" id="jive-search-info-details-toggle-link" href="#"><@s.text name="global.show_details" /></a>
                </li>
                <#if !user.anonymous>
                    <li>
                        <a class="jive-search-info-remove" href="#"><@s.text name="global.remove" /></a>
                    </li>
                </#if>
            </ul>
        </div>

        <div class="jive-search-info-content" id="jive-search-info-content" style="display: none;">
            <p><@s.text name="search.info.wildcard.text" /></p>

            <input type="text" name="newq" id="jive-new-search-terms" size="25" maxlength="100" value="${q!?html}*"/>
            <#assign globalSearching><@s.text name="global.searching" /></#assign>
            <input type="submit" id="jive-new-search-button-submit" value="<@s.text name="global.search" />"
                   onclick="prepareNewSearch(this);">

            <p><@s.text name="search.info.advanced.tips" /> <a href="<@s.url value='/search-tips.jspa' />" target="_blank"><@s.text name="search.search_tips.link" /></a></p>
        </div>

    </div>

    <script type="text/javascript">
        $j(document).ready(function() {
            $j('.jive-search-info-details-toggle').toggle(
                    function () {
                        $j('.jive-search-info-content').show();
                        $j('#jive-search-info-details-toggle-link').text('${action.getText('global.hide_details')?js_string}');
                    },
                    function () {
                        $j('.jive-search-info-content').hide();
                        $j('#jive-search-info-details-toggle-link').text('${action.getText('global.show_details')?js_string}');
                    }
            );

            $j('.jive-search-info-remove').click(
                    function () {
                        $j('#jive-search-info').remove();
                        $j.ajax({
                            type: "DELETE",
                            url: jive.rest.url("/search") + "/removeinfo"
                        });
                    }
            );
        });

        function prepareNewSearch(submit) {
            submit.disabled=true;
            submit.value='${globalSearching?js_string}...';
            $j('#jive-search-terms').val($j('#jive-new-search-terms').val());
            submit.form.submit();
            return false;
        }
    </script>

</div>
</#macro>

<#macro displayNoResults>
    <#if correctedQ?? && correctedQ != '' && correctedQ != q>
    <!-- BEGIN no results with suggestion -->
    <div id="jive-search-results-empty-suggestion">
        <#if q??>
            <p><@s.text name="search.noResultsForQuery.text" /> <strong>${q!?html}</strong></p>
        <#else>
            <p><@s.text name="search.noResultsQuery.text"/></p>
        </#if>

    <#-- Did you mean: -->
        <p class="jive-search-result-correction">
            <span class="jive-icon-med jive-icon-question"></span>
            <@s.text name="search.did_you_mean.label"/>
            <a href="<@s.url action='search'/>?<@s.property value="correctedSearchParams" />"><strong>${correctedQ}</strong></a>
        </p>

    </div>
    <!-- END no results with suggestion -->
    <#else>

    <div id="jive-search-results-empty">
        <#if q??>
            <p><@s.text name="search.noResultsForQuery.text" /> <strong>${q!?html}</strong></p>
        <#else>
            <p><@s.text name="search.noResultsQuery.text"/></p>
        </#if>
    </div>

    </#if>
</#macro>

<#macro customcontentFilter>
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

<div id="custom_content_filter">
				<span class="jive-content-list-sort jive-content-list-sort-sortby">
			       <#assign brands = JiveGlobals.getJiveProperty("grail.brandList")?split(",") />
                    <#assign countries = JiveGlobals.getJiveProperty("grail.countryList")?split(",") />
                    <#assign periodMonth = JiveGlobals.getJiveProperty("grail.periodMonth")?split(",") />
                    <#assign periodYear = JiveGlobals.getJiveProperty("grail.periodYear")?split(",") />
                    <#assign methodology = JiveGlobals.getJiveProperty("grail.methodologyList")?split(",") />
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
                            <tr>
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
                        </table>


                    </div>

                <#--<table width=100%>-->
                <#--<tr>-->
                <#--<td>-->
                <#--<fieldset  style="border: 1px solid #dadada;padding:0.5em;margin:2px">-->
                <#--<legend style="font-size:12px">From</legend>-->


                <#--</fieldset>-->
                <#--</td>-->
                <#--<td>-->
                <#--<fieldset style="border: 1px solid #dadada;padding:0.5em;margin:2px">-->
                <#--<legend style="font-size:12px">&nbsp;To&nbsp;</legend>-->
                <#--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Month: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->
                <#--<select name="docPeriod" id="docPeriodToMonth" class="customselect" onchange="javascript:changeResultType();">-->
                <#--<option value="NA">Please Select</option>-->
                <#--<#assign i=0 />-->

                <#--<#list periodMonth as month>-->
                <#--<option value="${i}" <#if docPeriod?exists && (docPeriod[2]?trim == i?string)><#assign criteriea = true/>selected</#if>>${month?string}</option>-->
                <#--<#assign i = i+1 />-->
                <#--</#list>-->
                <#--</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->
                <#--Year: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
                <#--<select name="docPeriod" id="docPeriodToYear" class="customselect" onchange="javascript:changeResultType();">-->
                <#--<option value="NA">Please Select</option>-->

                <#--<#list periodYear as year>-->
                <#--<option value="${year?string}" <#if docPeriod?exists && (docPeriod[3]?trim == year?trim?string)><#assign criteriea = true/>selected</#if>>${year?string}</option>-->
                <#--</#list>-->
                <#--</select>-->
                <#--</fieldset>-->
                <#--</td>-->
                <#--<tr>-->
                <#--</table>-->
                </span>
    <br clear="all" />
</div>

</#macro>

<#macro contentOptions>
<div class="jive-content-list-options jive-search-options clearfix jive-noOpenSearch">
    <!-- BEGIN sort by dropdown -->
<span class="jive-content-list-sort jive-content-list-sort-sortby">
        <label for="rankBy"><@s.text name="search.sort_by.label" /><@s.text name="global.colon"/></label>
        <select id="rankBy" name="rankBy" onChange="this.form.submit();">
            <option value="${enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].RELEVANCE.getKey()}"   <#if rankBy == enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].RELEVANCE.getKey()>selected="selected"</#if>><@s.text name="search.relevance.listitem" /></option>
            <option value="${enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].LIKES.getKey()}"       <#if rankBy == enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].LIKES.getKey()>selected="selected"</#if>><@s.text name="search.likes.listitem" /></option>
            <option value="${enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].RATING.getKey()}"      <#if rankBy == enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].RATING.getKey()>selected="selected"</#if>><@s.text name="search.rating.listitem" /></option>
            <option value="${enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].SUBJECT.getKey()}"     <#if rankBy == enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].SUBJECT.getKey()>selected="selected"</#if>><@s.text name="search.subject.listitem" /></option>
            <option value="${enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].MODIFICATION_DATE.getKey()}"        <#if rankBy == enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].MODIFICATION_DATE.getKey()>selected="selected"</#if>><@s.text name="search.date.listitem" /></option>
        </select>
    </span>
    <!-- END sort by dropdown -->

    <!-- BEGIN content type filter -->

<span class="jive-content-list-sort jive-content-list-sort-contenttype">
        <label for="contentType"><@s.text name="search.sort_by_type.label" /><@s.text name="global.colon"/></label>
        <select onChange="doSearch(value)" name="contentType" id="contentType">
            <option value="all" <#if (resultTypes.size() == 0)>selected</#if>><@s.text name="global.all" /></option>
            <#assign typeCode = action.getObjectTypeCode(enums['com.jivesoftware.community.JiveObjectType'].Message.key)>
            <#if (action.isTypeEnabled(typeCode))>
                <option value="${typeCode}" <#if (resultTypes.contains(typeCode))>selected</#if>><@s.text name="search.form.discussions.label" /></option>
            </#if>
            <#assign typeCode = action.getObjectTypeCode(enums['com.jivesoftware.community.JiveObjectType'].Document.key)>
            <#if (action.isTypeEnabled(typeCode))>
                <option value="${typeCode}" <#if (resultTypes.contains(typeCode))>selected</#if>><@s.text name="search.form.documents.label" /></option>
            </#if>
            <#assign typeCode = action.getObjectTypeCode(enums['com.jivesoftware.community.JiveObjectType'].BlogPost.key)>
            <#if (action.isTypeEnabled(typeCode))>
                <option value="${typeCode}" <#if (resultTypes.contains(typeCode))>selected</#if>><@s.text name="search.form.blogposts.label" /></option>
            </#if>
            <#assign typeCode = action.getObjectTypeCode(enums['com.jivesoftware.community.JiveObjectType'].Video.key)>
            <#if (action.isTypeEnabled(typeCode))>
                <option value="${typeCode}" <#if (resultTypes.contains(typeCode))>selected</#if>><@s.text name="search.form.video.label" /></option>
            </#if>
            <#assign typeCode = action.getObjectTypeCode(enums['com.jivesoftware.community.JiveObjectType'].Task.key)>
            <#if (action.isTypeEnabled(typeCode))>
                <option value="${typeCode}" <#if (resultTypes.contains(typeCode))>selected</#if>><@s.text name="search.form.tasks.label" /></option>
            </#if>
            <#list action.getNonDefaultTypes() as resultType>
                <#if (action.isTypeEnabled(resultType.code))>
                    <option value="${resultType.code}" <#if (resultTypes.contains(resultType.code))>selected</#if>><@s.text name="search.form.${resultType.code}.label" /></option>
                </#if>
            </#list>
        </select>
    </span>
    <!-- END content type filter -->

    <@timespanFilter/>
</div>
<div class="j-search-adv-option-block clearfix">
    <@containerChooser/>
        <@userChooser/>
</div>

</#macro>

<#macro contentOptionsNoQuery>
    <#if rankBy??>
    <input type="hidden" name="rankBy" value="${rankBy?html}"/>
    </#if>

    <#if contentType??>
    <input type="hidden" name="contentType" value="${contentType?html}"/>
    </#if>

    <#if container??>
    <input type="hidden" name="containerType" value="${container.objectType?c}"/>
    <input type="hidden" name="container" value="${container.ID?c}"/>
    </#if>

    <#if userID??>
    <input type="hidden" name="userID" value="${userID?html}"/>
    </#if>
</#macro>

<#macro peopleOptions>
<section>
    <div class="jive-content-list-sort jive-content-list-sort-people j-form-row clearfix">
        <ul class="j-form-group j-form-group-toggle">
            <li><input id="nameOnly" type="checkbox" onclick="doNameOnlySearch(this.checked);" <#if peopleNameOnly>checked="checked"</#if>><label class="j-form-label-special" for="nameOnly"><@s.text name="search.people.nameOnly"/></label></li>
            <li><input id="fuzzyName" type="checkbox" onclick="doFuzzyNameSearch(this.checked);" <#if peopleFuzzy>checked="checked"</#if>><label class="j-form-label-special" for="fuzzyName"><@s.text name="search.people.fuzzyName"/></label></li>
        </ul>
    </div>
</section>
</#macro>


<#macro placeOptions>

<!-- BEGIN content type filter -->
<span class="jive-content-list-sort jive-content-list-sort-contenttype">
    <label for="contentType"><@s.text name="search.sort_by_type.label" /><@s.text name="global.colon"/></label>
    <select onChange="doSearch(value)" name="contentType" id="contentType">
        <option value="all" <#if (resultTypes.size() == 0)>selected</#if>><@s.text name="global.all" /></option>
        <#assign typeCode = action.getObjectTypeCode(enums['com.jivesoftware.community.JiveObjectType'].Community.key)>
        <#if (action.isTypeEnabled(typeCode))>
            <option value="${typeCode}" <#if (resultTypes.contains(typeCode))>selected</#if>><@s.text name="search.form.community.label" /></option>
        </#if>
        <#assign typeCode = action.getObjectTypeCode(enums['com.jivesoftware.community.JiveObjectType'].SocialGroup.key)>
        <#if (action.isTypeEnabled(typeCode))>
            <option value="${typeCode}" <#if (resultTypes.contains(typeCode))>selected</#if>><@s.text name="search.form.sgroup.label" /></option>
        </#if>
        <#assign typeCode = action.getObjectTypeCode(enums['com.jivesoftware.community.JiveObjectType'].Project.key)>
        <#if (action.isTypeEnabled(typeCode))>
            <option value="${typeCode}" <#if (resultTypes.contains(typeCode))>selected</#if>><@s.text name="search.form.project.label" /></option>
        </#if>
    </select>
</span>
<!-- END content type filter -->

    <@timespanFilter/>
<div class="j-search-adv-option-block clearfix">
    <@userChooser/>
</div>
</#macro>

<#macro placeOptionsNoQuery>
    <#if contentType??>
    <input type="hidden" name="contentType" value="${contentType?html}"/>
    </#if>

    <#if userID??>
    <input type="hidden" name="userID" value="${userID?html}"/>
    </#if>
</#macro>

<#macro realtimeOptions>

<!-- BEGIN sort by dropdown -->
<span class="jive-content-list-sort jive-content-list-sort-sortby">
    <label for="rankBy"><@s.text name="search.sort_by.label" /><@s.text name="global.colon"/></label>
    <select id="rankBy" name="rankBy" onChange="this.form.submit();">
        <option value="${enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].RELEVANCE.getKey()}"   <#if rankBy == enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].RELEVANCE.getKey()>selected="selected"</#if>><@s.text name="search.relevance.listitem" /></option>
        <option value="${enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].MODIFICATION_DATE.getKey()}"        <#if rankBy == enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].MODIFICATION_DATE.getKey()>selected="selected"</#if>><@s.text name="search.date.listitem" /></option>
        <option value="${enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].LIKES.getKey()}"       <#if rankBy == enums['com.jivesoftware.community.search.SearchQueryCriteria$DefaultSort'].LIKES.getKey()>selected="selected"</#if>><@s.text name="search.likes.listitem" /></option>
    </select>
</span>
<!-- END sort by dropdown -->

    <@timespanFilter/>
<div class="j-search-adv-option-block clearfix">
    <@userChooser/>
</div>

</#macro>

<#macro realtimeOptionsNoQuery>
    <#if rankBy??>
    <input type="hidden" name="rankBy" value="${rankBy?html}"/>
    </#if>

    <#if userID??>
    <input type="hidden" name="userID" value="${userID?html}"/>
    </#if>
</#macro>

<#macro timespanFilter>
<!-- BEGIN timespan filter -->
<span class="jive-content-list-sort jive-content-list-sort-timespan">
        <label><@s.text name="search.sort_by_time.label" /><@s.text name="global.colon"/></label>
        <ul>
            <li><a href="javascript:doDateRangeSearch('${defaultDateRange.ID}');" <#if (dateRange == defaultDateRange.ID)>class="selected"</#if>><@s.text name="search.sort_by_time.option.any" /></a></li>
            <li class="seperator font-color-meta-light">|</li>
            <li class="seperator font-color-meta"><@s.text name="search.sort_by_time.option.past.label" /><@s.text name="global.colon"/></li>
            <#list dateRanges as range>
                <#assign rangeString = action.getText(range.i18nKey)>
                <li><a href="javascript:doDateRangeSearch('${range.ID}');" <#if (dateRange == range.ID)>class="selected"</#if>>${rangeString?cap_first}</a></li>
            </#list>
        </ul>
    </span>

<!-- END timespan filter -->
</#macro>

<#macro containerChooser>
<div class="j-search-adv-option j-js-picker-container">

    <label for="jive-container-chooser">${containerChooserLabel?html}<@s.text name="global.colon" /></label>

    <input type="hidden" id="jive-container-chooser-type" name="containerType" value="<#if container??>${container.objectType?c}</#if>"/>
    <input type="hidden" id="jive-container-chooser-id" name="container" value="<#if container??>${container.ID?c}</#if>"/>
    <div id="jive-container-chooser-selected" onclick="autocompleteContainer.removeContainer(); return false;"
         <#if !container??>style="display:none">
         <#else>>
        <span class="jive-autocomplete-search-container">
         <#assign iconElement = SkinUtils.getJiveObjectIcon(container, 0)! />
            <#if iconElement??><@jive.renderIconElement iconElement /><#else>
                <span class="${SkinUtils.getJiveObjectCss(targetContainer, 0)}"></span>
            </#if>
        ${container.name?html}</span>
         </#if>
    </div>
    <input type="text" id="jive-container-chooser" name="containerName"
           class="jive-search-container jive-autocomplete"
           style="width:250px <#if container??>; display:none</#if>"
           <#if container??>value="${container.name?html}" </#if>
            />
    <ul id="jive-container-chooser-choices" class="jive-autocomplete" style="max-height:300px; overflow-y:auto; display:none"></ul>
</div>
</#macro>

<#macro userChooser>
<div class="j-search-adv-option">
    <label for="jive-user-chooser"><@s.text name="search.form.person.label" /><@s.text name="global.colon" /></label>

    <input type="text" id="jive-user-chooser"
           name="userID"
           class="jive-search-user jive-autocomplete"
           style="width:250px" />
</div>
</#macro>