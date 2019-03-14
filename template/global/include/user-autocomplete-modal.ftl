<#include "/template/global/include/synchro-macros.ftl" />

<div id="jive-body-popup-container" class="jive-body-popup-container-userpicker" data-is-multiple="<#if multiple>true<#else>false</#if>">

    <form action="<@s.url action="user-autocomplete-modal" />" method="get" id="profilesearchform" name="profilesearchform">

    <#assign statusLevelEnabled = jiveContext.getStatusLevelManager().isStatusLevelsEnabled()>
	
	<!-- Check Portal Type -->
	<#assign isSynchroPortal = false />
	<#assign isKantarPortal = false />
	<#assign isGrailPortal = false />
	<#if session.getAttribute('grail.portal.type')??>
		<#assign portalType = session.getAttribute('grail.portal.type')/>
	</#if>
	
	<#-- TODO TO be removed after Session issue resolve -->
	<#assign portalType = 'synchro' />
	
	
	<#if portalType??>
		<#if portalType == 'synchro'>
			<#assign isSynchroPortal = true />
			<#assign isKantarPortal = false />
			<#assign isGrailPortal = false />
		<#elseif portalType == 'grail'>
			<#assign isSynchroPortal = true />
			<#assign isKantarPortal = false />
			<#assign isGrailPortal = true />
		<#elseif portalType == 'kantar'>
			<#assign isSynchroPortal = true />
			<#assign isKantarPortal = true />
			<#assign isGrailPortal = false />
		<#elseif portalType == 'kantar_report'>
			<#assign isSynchroPortal = true />
			<#assign isKantarPortal = true />
			<#assign isGrailPortal = false />
		<#elseif portalType == 'rkp'>
			<#assign isSynchroPortal = false />
			<#assign isKantarPortal = false />
			<#assign isGrailPortal = false />
		</#if>
	</#if>

	<#if isSynchroPortal?? && !isSynchroPortal && isKantarPortal?? && !isKantarPortal && isGrailPortal?? && !isGrailPortal>
    <nav class="j-tab-nav">
        <ul class="j-tabbar">
            <#if showBrowse>
            <li id="jive-aToZ-tab" class="<#if view == 'alphabetical'>active j-ui-elem</#if>">
                <a class="userpicker-page-link<#if view == 'alphabetical'> j-ui-elem</#if>" title="<@s.text name="user.picker.vwByUsrname.tooltip" />" href="<@s.url value="${actionMappingName}.jspa?view=alphabetical&showAddressbook=${showAddressbook?string}" />&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}"><@s.text name="user.picker.tab.browse.label" /></a>
            </li>            
            </#if>
            <li id="jive-connections-tab" class="<#if view == 'connections'>active j-ui-elem</#if>">
                <#assign friendingTitle><#if friendingReflexive><@s.text name="user.picker.vwByFriends.tooltip" /><#else><@s.text name="user.picker.vwByFollowing.tooltip" /></#if></#assign>
                <#assign friendingLabel><#if friendingReflexive><@s.text name="user.picker.tab.friends.label" /><#else><@s.text name="user.picker.tab.following.label" /></#if></#assign>
                <a class="userpicker-page-link<#if view == 'connections'> j-ui-elem</#if>" title="${friendingTitle}" href="<@s.url value="${actionMappingName}.jspa?view=connections&showAddressbook=${showAddressbook?string}" />&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}">${friendingLabel}</a>
            </li>            
            <#if (orgChartingEnabled) && !(user.partner)>
            <li id="jive-orgchart-tab" class="<#if view == 'orgchart'>active j-ui-elem</#if>">
                <a class="userpicker-page-link<#if view == 'orgchart'> j-ui-elem</#if>" title="<@s.text name="profile.gr.org.title" />" href="<@s.url value="${actionMappingName}.jspa?view=orgchart&showAddressbook=${showAddressbook?string}" />&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}"><@s.text name="profile.gr.org.title" /></a>
            </li>
            </#if>
            <li id="jive-search-tab" class="<#if view == 'search'>active j-ui-elem</#if>">
                <a class="userpicker-page-link<#if view == 'search'> j-ui-elem</#if>" title="<@s.text name="user.picker.vwBySearch.tooltip" />" href="<@s.url value="${actionMappingName}.jspa?view=search&showAddressbook=${showAddressbook?string}" />&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}"><@s.text name="user.picker.tab.search.label" /></a>
            </li>
            <li id="jive-online-tab" class="<#if view == 'online'>active j-ui-elem</#if>" style="display: none;">
                <a class="userpicker-page-link<#if view == 'online'> j-ui-elem</#if>" title="<@s.text name="user.picker.vwOnlnUsrs.tooltip" />" href="<@s.url value="${actionMappingName}.jspa?view=online&showAddressbook=${showAddressbook?string}" />&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}"><@s.text name="user.picker.tab.whosOnline.label" /></a>
            </li>
            <li id="jive-newest-tab" class="<#if view == 'newest'>active j-ui-elem</#if>">
                <a class="userpicker-page-link<#if view == 'newest'> j-ui-elem</#if>" title="<@s.text name="user.picker.vwByRegDate.tooltip" />" href="<@s.url value="${actionMappingName}.jspa?view=newest&showAddressbook=${showAddressbook?string}" />&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}"><@s.text name="user.picker.tab.newest.label" /></a>
            </li>
            <li id="jive-addressbook-tab" class="<#if view == 'addressbook'>active j-ui-elem</#if>" <#if !showAddressbook>style="display:none"</#if>>
                <a class="userpicker-page-link<#if view == 'addressbook'> j-ui-elem</#if>" title="<@s.text name="user.picker.addressBk.tooltip" />" href="<@s.url value="${actionMappingName}.jspa?view=addressbook&showAddressbook=true" />&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}"><@s.text name="user.picker.tab.address.label"/></a>
            </li>
        </ul>
    </nav>
	
	<#elseif (isSynchroPortal?? && isSynchroPortal) ||  (isKantarPortal?? && isKantarPortal) || (isGrailPortal?? && isGrailPortal)>
	<!--  Custom User Filters for Synchro : Starts -->
	<div id="synchro-filters-main" class="j-tab-nav">
		<ul class="j-tabbar">
			<li class="j-ui-elem">
				<#if roleEnabled>
					<label>Role</label>
					<@renderRoleFilter name='role' value='${role?default(-1)}' readonly=false ownerfield=ownerfield />
				<#else>
					<@renderRoleFilter name='role' value='${role?default(-1)}' readonly=true ownerfield=ownerfield/>
				</#if>
			</li>
			<li class="j-ui-elem">
				<label>Brand</label>
				<@renderBrandFilter name='brand' value='${brand?default(-1)}'/>
			</li>
			<li class="j-ui-elem">
				<label>Region</label>
				<@renderRegionFilter name='region' value='${region?default(-1)}'/>
			</li class="j-ui-elem">
			<li>
				<label>Country</label>
				<@renderCountryFilter name='country' value='${country?default(-1)}'/>
			</li>
			<li class="j-ui-elem">
				<label>Job Title</label>
				<@renderJobTitleFilter name='jobTitle' value='${jobTitle?default(-1)}'/>
			</li>
		</ul>
		<input type="hidden" value="${selectedUserID?default(-1)}" name="selectedUserID" />
		<#if hideInvite??>
			<input type="hidden" value="${hideInvite?string}" name="hideInvite" />
		</#if>
	</div>
	<!--  Custom User Filters for Synchro : Ends -->
	</#if>

    <#if (actionErrors.size() > 0)>
        <div id="jive-error-box" class="jive-error-box" aria-live="polite" aria-atomic="true">
            <div>
                <span class="jive-icon-med jive-icon-redalert"></span>
                <#list actionErrors as actionError>
                    ${actionError}
                </#list>
            </div>
        </div>
    </#if>

    <#if actionMessages?size gt 0>
    <#list actionMessages as actionMessage>
        <div class="jive-info-box" aria-live="polite" aria-atomic="true">
            <div>
                <span class="jive-icon-med jive-icon-info"></span>
            ${actionMessage?html}
            </div>
        </div>
    </#list>
    </#if>	
	
	<#function getPageLinkURL baseUrl paramsArr...>
		<#local url = baseUrl/>
		<#local params = ""/>

		<#if role?? && (role?number &gt; 0)>
			<#local paramsArr = paramsArr + ["role=${role}"]/>
		</#if>
		<#if roleEnabled??>
			<#local paramsArr = paramsArr + ["roleEnabled=${roleEnabled?string}"]/>
		</#if>

		<#if ownerfield??>
			<#local paramsArr = paramsArr + ["ownerfield=${ownerfield?string}"]/>
		</#if>

		<#if brand?? && (brand?number &gt; 0)>
			<#local paramsArr = paramsArr + ["brand=${brand}"]/>
		</#if>
		<#if brandEnabled??>
			<#local paramsArr = paramsArr + ["brandEnabled=${brandEnabled?string}"]/>
		</#if>

		<#if region?? && (region?number &gt; 0)>
			<#local paramsArr = paramsArr + ["region=${region}"]/>
		</#if>
		<#if regionEnabled??>
			<#local paramsArr = paramsArr + ["regionEnabled=${regionEnabled?string}"]/>
		</#if>

		<#if country?? && (country?number &gt; 0)>
			<#local paramsArr = paramsArr + ["country=${country}"]/>
		</#if>
		<#if countryEnabled??>
			<#local paramsArr = paramsArr + ["countryEnabled=${countryEnabled?string}"]/>
		</#if>

		<#if jobTitle?? && (jobTitle?number &gt; 0)>
			<#local paramsArr = paramsArr + ["jobTitle=${jobTitle}"]/>
		</#if>
		<#if jobTitleEnabled??>
			<#local paramsArr = paramsArr + ["jobTitleEnabled=${jobTitleEnabled?string}"]/>
		</#if>

		<#if selectedUserID??>
			<#local paramsArr = paramsArr + ["selectedUserID=${selectedUserID}"]/>
		</#if>

		<#if hideInvite??>
			<#local paramsArr = paramsArr + ["hideInvite=${hideInvite?string}"]/>
		</#if>
		<#if (paramsArr?? && paramsArr?size > 0) >
			<#list paramsArr as p>
				<#local params = params + p/>
				<#if p_has_next>
					<#local params = params + "&"/>
				</#if>
			</#list>
		</#if>
		<#if params?has_content>
			<#local url = url + "?" + params>
		</#if>

		<#return url>
</#function>

    <div id="jive-people-results" class="clearfix">

        <div id="jive-people-resultsbar">

            <#if view?? && view == 'alphabetical'>
                <#if showBrowse>
                <span id="jive-people-resultbar-alphabetical" >
                    <#assign seq = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']>
                    <#if !prefix?has_content>
                        <span class="jive-alpha-link selected"><@s.text name="global.all"/></span> <span class="font-color-meta">| </span>
                    <#else>
                        <#--<span class="jive-alpha-link"><a class="userpicker-page-link" href="<@s.url value="${actionMappingName}!input.jspa?&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}&view=alphabetical" />"><@s.text name="global.all"/></a></span> |-->
						<span class="jive-alpha-link"><a class="userpicker-page-link" href="${getPageLinkURL('${action.getDefaultBaseURL()}/${actionMappingName}!input.jspa','multiple=${multiple?string}', 'view=alphabetical')}"><@s.text name="global.all"/></a></span> |
                    </#if>
                    <#list seq as x>
                        <#if prefix?exists && prefix == x>
                            <span class="jive-alpha-link  selected">${x?upper_case}</span>
                        <#else>
                           <#-- <span class="jive-alpha-link"><a class="userpicker-page-link" href="<@s.url value="${actionMappingName}!input.jspa?&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}&view=alphabetical&prefix=${x}" />">${x?upper_case}</a></span>-->
							<span class="jive-alpha-link"><a class="userpicker-page-link" href="${getPageLinkURL('${action.getDefaultBaseURL()}/${actionMappingName}!input.jspa' ,'multiple=${multiple?string}', 'view=alphabetical','prefix=${x}')}">${x?upper_case}</a></span>
                        </#if>
                    </#list>
                </span>
            </#if>
            </#if>

            <#if (view?? && view == 'connections' && (userRelationshipLists.size() > 0))>
                <span id="jive-people-resultbar-connections">
                    <@s.text name="profile.friends.filterbylabel.title" /><@s.text name="global.colon" />
                    <#if labelID <= 0 >
                        <span class="jive-alpha-link jive-alpha-link-selected"><@s.text name="global.all"/></span> <span class="font-color-meta">| </span>
                    <#else>
                        <span class="jive-alpha-link"><a class="userpicker-page-link" href="<@s.url value="${actionMappingName}!input.jspa?&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}&view=connections" />"><@s.text name="global.all"/></a></span> |
                    </#if>
                    <#list userRelationshipLists as userRelationshipList>
                        <#if (userRelationshipList.ID == labelID)>
                            <span class="jive-alpha-link  jive-alpha-link-selected">${userRelationshipList.name?html}</span>
                        <#else>
                            <span class="jive-alpha-link"><a class="userpicker-page-link" href="<@s.url value="${actionMappingName}!input.jspa?&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}&view=connections&labelID=${userRelationshipList.ID?c}" />">${userRelationshipList.name?html}</a></span>
                        </#if>
                    </#list>
                </span>
            </#if>

            <#if view?? && view == 'search'>

                <div id="jive-people-search">

                    <input type="text" id="query" name="query" size="50" class="jive-global-search-field jive-people-search-form-input"/>

                    <input type="hidden" name="resultTypes" value="COMMUNITY"/>
                    <input type="hidden" id="profilesearchform-sort" name="sort" value="${sort!"relevance"}" />
                    <input type="hidden" id="profilesearchform-start" name="start" value="0" />
                    <input type="hidden" name="multiple" value="${multiple?string}" />
                    <input type="hidden" name="canInvitePartners" value="${canInvitePartners?string}" />
                    <input type="hidden" name="view" value="search" />
                    <input id="people-search-submit" type="submit" class="jive-people-search-form-submit" value="<@s.text name='global.search'/>" />

                    <a id="userpicker-options-link" href="#" class="font-color-meta" data-action="toggleOptions"><@s.text name="user.picker.more_options.link" /></a>

                    <div id="jive-people-search-options" <#if !searchOptionsVisible>style="display:none"</#if>>
                        <@s.checkbox theme="simple" name="usernameEnabled" id="usernameEnabled" fieldValue="true"/>
                        <label for="usernameEnabled" class="jive-description"><@s.text name="global.username"/></label>
                        &nbsp;&nbsp;

                        <@s.checkbox theme="simple" name="nameEnabled" id="nameEnabled" fieldValue="true"/>
                        <label for="nameEnabled" class="jive-description"><@s.text name="global.name"/></label>
                        &nbsp;&nbsp;

                        <@s.checkbox theme="simple" name="emailEnabled" id="emailEnabled" fieldValue="true"/>
                        <label for="emailEnabled" class="jive-description"><@s.text name="global.email"/></label>
                        &nbsp;&nbsp;

                        <#assign fields = jiveContext.getProfileFieldManager().getProfileFields() />
                        <#if (fields.size() > 0)>
                            <@s.checkbox theme="simple" name="profileEnabled" id="profileEnabled" fieldValue="true"/>
                            <label for="profileEnabled" class="jive-description"><@s.text name="global.profile"/></label>
                        </#if>
                    </div>
                </div>

                <#if (view?? && view == 'search' && query?has_content)>
                    <#if (results.size() == 0)>
                        <#-- empty -->
                    <#else>
                        <div id="jive-peoplesearch-resultbar-sort">
                            <@s.text name="global.sort_by"/><@s.text name="global.colon"/>
                            <@s.set name="relevance" value="getText('search.user.relevance.link')"/>
                            <@s.set name="statuslevel" value="getText('people.status_level.link')"/>
                            <#if sort == 'relevance' || sort == ''>
                                <span class="jive-alpha-link jive-alpha-link-selected">${relevance}</span>
                            <#else>
                                <span class="jive-alpha-link">
                                    <a id="userpicker-sort-link-relevance" class="userpicker-sort-link" href="#" data-action="sort" data-sort-type="relevance" title="<@s.text name="user.picker.srtByRlvnc.tooltip" />">${relevance}</a>
                                </span>
                            </#if>
                            <#if (jiveContext.getStatusLevelManager().isStatusLevelsEnabled())>
                                <#if sort == 'statusLevel'>
                                    <span class="jive-alpha-link jive-alpha-link-selected">${statuslevel}</span>
                                <#else>
                                    <span class="jive-alpha-link">
                                        <a id="userpicker-sort-link-statusLevel" class="userpicker-sort-link" href="#" data-action="sort" data-sort-type="statusLevel" title="<@s.text name="user.picker.srtByStsLvl.tooltip" />">${statuslevel}</a>
                                    </span>
                                </#if>
                            </#if>
                            <#if showBrowse>
                            <#if sort == 'username'>
                                <span class="jive-alpha-link jive-alpha-link-selected"><@s.text name="global.username" /></span>
                            <#else>
                                <span class="jive-alpha-link">
                                    <a id="userpicker-sort-link-username" class="userpicker-sort-link" href="#" data-action="sort" data-sort-type="username" title="<@s.text name="user.picker.srtByUsrnam.tooltip" />"><@s.text name="global.username" /></a>
                                </span>
                            </#if>
                            </#if>
                        </div>
                    </#if>
                </#if>
            </#if>


            <#assign baseURL = "${actionMappingName}.jspa">
            <#if (paginator.numPages > 1)>
                <#if view?exists && view == 'search'>
                    <span class="j-pagination">
                        <#list paginator.getPagesNoLast(3) as page>
                        <#compress>
                        <#if (page?exists)>
                            <#if (page.start == start)>
                                <a href="#" class="j-pagination-current font-color-normal" id="search-paginate-${page.start?c}" data-action="goToPage" data-page="${page.number}"><strong>${page.number}</strong></a>
                            <#else>
                                <a href="#" id="search-paginate-${page.start?c}" data-action="goToPage" data-page="${page.number}">${page.number}</a>
                            </#if>
                        <#else>
                            <span>&hellip;</span>
                        </#if></#compress>
                        </#list>
                        <span class="j-pagination-prevnext">
                            <#if (paginator.previousPage)>
                                <a id="search-paginate-${paginator.previousPageStart?c}" href="#"
                                    data-action="goToPage" data-page="${paginator.previousPageStart?c}"
                                    title="<@s.text name="global.previous_page_title"/>"
                                    class="j-pagination-prev"><@s.text name="global.previous"/></a>
                            <#else>
                                <span class="j-pagination-prev j-disabled font-color-meta"><@s.text name="global.previous"/></span>
                            </#if>
                            <#if (paginator.nextPage)>
                                <a id="search-paginate-${paginator.nextPageStart?c}" href="#"
                                    data-action="goToPage" data-page="${paginator.nextPageStart?c}"
                                    title="<@s.text name="global.next_page_title"/>"
                                    class="j-pagination-next"><@s.text name="global.next"/></a>
                            <#else>
                                <span class="j-pagination-next j-disabled font-color-meta"><@s.text name="global.next"/></span>
                            </#if>
                        </span>
                    </span>
                <#else>
                    <div class="j-pagination">
					
					<#if isSynchroPortal?? && isSynchroPortal && hideInvite?? && !hideInvite>
						<a href="javascript:void(0);" onclick="inviteUser();" id="email-link" class="wish">Wish you were here !</a>
					</#if>
					
                        <#list paginator.getPagesNoLast(3) as page>
                        <#compress>
                        <#if (page?exists)>
                            <#if (page.start == start)>
							
								<a href="${getPageLinkURL('${action.getDefaultBaseURL()}/${baseURL}','start=${page.start?c}', 'view=${view?html}', 'multiple=${multiple?string}')}<#if prefix?exists>&prefix=${prefix?html}</#if>" class="j-pagination-current font-color-normal"><strong>${page.number}</strong></a>
							<#else>
								<a href="${getPageLinkURL('${action.getDefaultBaseURL()}/${baseURL}','start=${page.start?c}', 'view=${view?html}', 'multiple=${multiple?string}')}<#if prefix?exists>&prefix=${prefix?html}</#if>">${page.number}</a>
							
							<#--
                                <a href="<@s.url value="${baseURL}" />?start=${page.start?c}&view=${view?html}&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}<#if prefix?exists>&prefix=${prefix?html}</#if>" class="j-pagination-current font-color-normal"><strong>${page.number}</strong></a>
                            <#else>
                                <a href="<@s.url value="${baseURL}" />?start=${page.start?c}&view=${view?html}&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}<#if prefix?exists>&prefix=${prefix?html}</#if>">${page.number}</a> -->
								
                            </#if>
                        <#else>
                            <span>&hellip;</span>
                        </#if></#compress>
                        </#list>
                        <span class="j-pagination-prevnext">
                            <#if (paginator.previousPage)>
                                <#--<a href="<@s.url value="${baseURL}" />?start=${paginator.previousPageStart?c}&view=${view?html}&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}<#if prefix?exists>&prefix=${prefix?html}</#if>"
                                   title="<@s.text name="global.previous_page_title"/>"
                                   class="userpicker-page-link j-pagination-prev"><@s.text name="global.previous"/></a>-->
								   
								   <a href="${getPageLinkURL('${action.getDefaultBaseURL()}/${baseURL}','start=${paginator.previousPageStart?c}', 'view=${view?html}', 'multiple=${multiple?string}')}<#if prefix?exists>&prefix=${prefix?html}</#if>"
                                   title="<@s.text name="global.previous_page_title"/>"
                                   class="userpicker-page-link j-pagination-prev"><@s.text name="global.previous"/></a>
								   
                            <#else>
                                <span class="j-pagination-prev j-disabled font-color-meta"><@s.text name="global.previous"/></span>
                            </#if>
                            <#if (paginator.nextPage)>
                                <#--<a href="<@s.url value="${baseURL}" />?start=${paginator.nextPageStart?c}&view=${view?html}&multiple=${multiple?string}&canInvitePartners=${canInvitePartners?string}<#if prefix?exists>&prefix=${prefix?html}</#if>"
                                   title="<@s.text name="global.next_page_title"/>"
                                   class="userpicker-page-link j-pagination-next"><@s.text name="global.next"/></a>-->
								   
								 <a href="${getPageLinkURL('${action.getDefaultBaseURL()}/${baseURL}','start=${paginator.nextPageStart?c}', 'view=${view?html}', 'multiple=${multiple?string}')}<#if prefix?exists>&prefix=${prefix?html}</#if>" title="<@s.text name="global.next_page_title"/>"
                       class="userpicker-page-link j-pagination-next"><@s.text name="global.next"/></a>
								   
                            <#else>
                                <span class="j-pagination-next j-disabled font-color-meta"><@s.text name="global.next"/></span>
                            </#if>
                    </span>
                </div>
                </#if>
				
				<#elseif isSynchroPortal?? && isSynchroPortal && hideInvite?? && !hideInvite>
					<div class="j-pagination">
						<a href="javascript:void(0);" onclick="inviteUser();" id="email-link" class="wish">Wish you were here !</a>
					</div>	
            </#if>
        </div>

        <div <#if multiple>id="jive-user-picker-results-multiple"<#else>id="jive-user-picker-results-single"</#if> class="jive-group-picker-results">
            <div class="jive-table jive-table-userpicker">
            <#if (view?? && ((view == 'connections') || (view == 'orgchart') && orgChartingEnabled))>
                <div id="jive-table-userpicker-body" class="jive-table-userpicker-body-relationships j-table-fixed-height">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tbody>
                            <#if userRelationshipViews.size() == 0>
                                <p class="jive-box-empty-message font-color-meta">
                                    <#if (view == 'connections')>
                                        <#if friendingReflexive>
                                            <@s.text name="profile.friends.self.nofriends.label" />
                                        <#else>
                                            <@s.text name="profile.friends.self.nofollow.label" />
                                        </#if>
                                    <#elseif (view == 'orgchart')>
                                        <@s.text name="profile.org.orgchart.undefined.text" />
                                    </#if>
                                </p>
                            </#if>
                            <#list userRelationshipViews as userRelationshipView>
                            <@userRow result=userRelationshipView.person idx=userRelationshipView_index />
                            </#list>
                        </tbody>
                    </table>
                </div>
            <#elseif (view?? && view = 'addressbook')>
                 <div id="jive-table-userpicker-body" class="jive-table-userpicker-body-relationships">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tbody>
                            <#list addressbook as user>
                            <@userRow result=user idx=user_index />
                            </#list>
                        </tbody>
                    </table>
                </div>
            <#elseif (view??)>
                <div id="jive-table-userpicker-body" <#if view?? && view == 'search'>class="jive-table-userpicker-body-search"</#if>>
                    <table cellpadding="0" cellspacing="0" border="0">
                        <tbody>
                            <#if results.size() == 0>
                                <p class="jive-box-empty-message font-color-meta">
                                    <#if (view == 'search' && query?has_content)>
                                        <@s.text name="search.noResultsForQuery.text" /> <strong>${query?html}</strong>
                                    <#elseif (view == 'alphabetical')>
                                        <@s.text name="search.noResultsForQuery.text" /> <strong>${prefix!}</strong>
                                    <#elseif (view == 'newest')>
                                        <@s.text name="people.newest.empty.text" />
                                    <#else>
                                        <@s.text name="search.noResultsQuery.text" />
                                    </#if>
                                </p>
                            </#if>
							<#--
                            <#list results as user>
                            <@userRow result=user idx=user_index />
                            </#list>-->
							
							<#if (!multiple && (isSynchroPortal?? && isSynchroPortal) || (isKantarPortal?? && isKantarPortal) || (isGrailPortal?? && isGrailPortal))>
								<#list results as user>
									<#if user.ID==selectedUserID>
										<@synchroUserRow result=user idx=user_index  checked=true/>
									<#else>
										<@synchroUserRow result=user idx=user_index />
									</#if>
								</#list>
							<#else>
								<#list results as user>
									<@userRow result=user idx=user_index />
								</#list>
							</#if>
					
					
                        </tbody>
                    </table>
                </div>
            </#if>
            </div>
        </div>

    </div>


    <#if multiple>
    <div class="jive-user-search-mult-preview">
        <div class="jive-user-search-mult-preview-users jive-modal-content-userpicker-selected">
            <label for="preview"><@s.text name="user.picker.selected_usrs.label" /><@s.text name="global.colon" /></label>
            <strong id="preview"></strong>
        </div>

        <div class="jive-user-search-mult-preview-buttons j-pop-row j-last">
            <button id="userpicker-addUsersButton" class="j-btn-global j-btn-callout j-disabled" data-action="addUsers"><@s.text name="user.picker.addSlctdUsrs.button" /></button>
            <button type="button" class="close"><@s.text name="global.cancel"/></button>
        </div>
    </div>
    </#if>

    </form>

</div>

<@resource.javascript ajaxOutput="true"/>

<#macro userRow result idx>
<#if result.enabled>
<#assign online = jiveContext.getPresenceManager().isOnline(result) />
<#assign statusLevelEnabled = jiveContext.getStatusLevelManager().isStatusLevelsEnabled()>
<#assign sharedGroupsEnabled = jiveContext.getSharedGroupManager().isEnabled()>
<#assign viewingSelf = (user.ID?c == result.ID?c)>
    <tr>
        <td class="jive-table-cell-checkbox">
            <input id="userChk-${result.ID?c}" type="checkbox" value="${result.ID?c}" role="checkbox" tabindex="0" />
            <input type="hidden" name="userChk-${result.ID?c}-userName" value="${result.username?html}" />
            <label for="userChk-${result.ID?c}" class="j-508-label">${SkinUtils.getDisplayName(result)?html}</label>
        </td>
        <td class="jive-table-cell-avatar">
            <label for="userChk-${result.ID?c}"><span id="userChk-${result.ID?c}-avatar"><@jive.userAvatar user=result size=22 useLinks=false /></span></label>
        </td>
        <td class="jive-table-cell-name">
            <label for="userChk-${result.ID?c}"><@jive.displayUserDisplayName user=result /></label>
            <#if (!user.partner && sharedGroupsEnabled && result.partner)>
                <span class="jive-icon-med jive-icon-partner"></span>
            </#if>
        </td>
        <td class="jive-table-cell-title font-color-meta">
            <#if (result.title?has_content && result.department?has_content)>
                <@s.text name="search.result.people.in">
                    <@s.param>${result.title?html}</@s.param>
                    <@s.param>${result.department?html}</@s.param>
                </@s.text>
            <#elseif (result.title?has_content)>
                ${result.title?html}
            <#elseif (result.department?has_content)>
                ${result.department?html}
            </#if>
        </td>
        <td class="jive-table-cell-email font-color-meta">
            <#if (result.email?has_content)>
                ${result.email?html}
            <#else>
                <@s.text name="profile.hidden.text" />
            </#if>
        </td>
        <#if (view == 'newest')>
            <td class="jive-table-cell-date">
                <@s.text name='search.user.result.joined'>
                <@s.param>${result.creationDate?date}</@s.param>
                </@s.text>
            </td>
        </#if>
         <#if (statusLevelEnabled && (view != 'newest'))>
            <td class="jive-table-cell-status">
                <#if community?exists>
                    <@jive.userStatusLevel user=result container=community />
                <#else>
                    <@jive.userStatusLevel user=result />
                </#if>
                &nbsp;
            </td>
        </#if>
    </tr>
</#if>
</#macro>



<#macro synchroUserRow result idx checked=false>
    <#if result.enabled>
        <#assign online = jiveContext.getPresenceManager().isOnline(result) />
        <#assign statusLevelEnabled = jiveContext.getStatusLevelManager().isStatusLevelsEnabled()>
        <#assign viewingSelf = (user.ID?c == result.ID?c)>
    <tr>
        <td class="jive-table-cell-checkbox">
            <input id="userChk-${result.ID?c}" name="select-people-radio" type="radio" value="${result.ID?c}" <#if checked>checked="checked"</#if>/>
            <input type="hidden" name="userChk-${result.ID?c}-userName" value="${result.username?html}" />
            <span id="userChk-${result.ID?c}-displayName" style="display: none;">${SkinUtils.getDisplayName(result)?html}</span>
        </td>
        <td class="jive-table-cell-avatar">
            <label for="userChk-${result.ID?c}"><span id="userChk-${result.ID?c}-avatar"><@jive.userAvatar user=result size=22 useLinks=false /></span></label>
        </td>
        <td class="jive-table-cell-name">
            <label for="userChk-${result.ID?c}"><@jive.displayUserDisplayName user=result /></label>
        </td>
        <td class="jive-table-cell-email font-color-meta">
            <#if (result.email?has_content)>
                ${result.email?html}
            <#else>
                <@s.text name="profile.hidden.text" />
            </#if>
        </td>
        <#if (view == 'newest')>
            <td class="jive-table-cell-date">
                <@s.text name='search.user.result.joined'>
                <@s.param>${result.creationDate?date}</@s.param>
                </@s.text>
            </td>
        </#if>
        <#if (statusLevelEnabled && (view != 'newest'))>
            <td class="jive-table-cell-status">
                <#if community?exists>
                    <@jive.userStatusLevel user=result container=community />
                <#else>
                    <@jive.userStatusLevel user=result />
                </#if>
                &nbsp;
            </td>
        </#if>
    </tr>
    </#if>
</#macro>
