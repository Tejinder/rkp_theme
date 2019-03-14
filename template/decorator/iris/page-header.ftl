<#--<a href="<@s.url value="/"/>" class="j-header-logo">
    <#if skin.template.basicTitleUsed>
        <h1 id="jive-global-header-title">${skin.template.basicTitle?html}</h1>
    <#else>
        <#if skin.template.basicLogoUsed>
            <img src="${skin.template.basicLogoPath}" alt="" />
        <#else>
            <h1 id="logo">Welcome to Synchro</h1>
        </#if>
    </#if>
</a> -->

<#--<a href="<@s.url value="/"/>"class="j-header-logo">-->
<#--<h1 id="jive-global-header-title">Welcome to Synchro</h1>-->
<#--</a>-->

<!-- header -->
<#assign synchroURL = request.requestURL />

<#if synchroURL?? && (synchroURL?contains("login.jspa") || synchroURL?contains("portal")
|| synchroURL?contains("disclaimer"))>
<a class="j-header-logo<#if synchroURL?contains("/oracledocuments/")> oracle-documents</#if>"></a>
<#else>
    <#if  ((synchroURL?contains("edit-profile") && request.getParameter("from")?? && request.getParameter("from") == 'selective_screen')
    || (synchroURL?contains("change-password") && request.getParameter("from")?? && request.getParameter("from") == 'selective_screen')
    || (synchroURL?contains("/profile.jspa") && request.getParameter("from")?? && request.getParameter("from") == 'selective_screen')
    || (synchroURL?contains("/people/") && request.getParameter("from")?? && request.getParameter("from") == 'selective_screen')
    || synchroURL?contains("/synchro/reminder") || synchroURL?contains("/synchro/project-reminders")
    || synchroURL?contains("/synchro/general-reminders") || synchroURL?contains("/synchro/project-reminder-view-result"))>
    <a class="j-header-logo" href="/portal-options.jspa"></a>
    <#elseif synchroURL?contains("/oracledocuments/")>
    <a class="j-header-logo" href="/oracledocuments/oracle-manuals!input.jspa"></a>
    <#else>
    <a class="j-header-logo" href="/synchro/home"></a>
    </#if>

    <#attempt>
    <div class="welcome">
        <#if !page.getProperty("meta.nouserbar")??>
        <#assign selLink = page.getProperty("meta.nav.active.link")!""/>
       <#-- <#assign activityCountsData = action.getActivityCounts(page.getProperty("meta.sub.nav.active.link")!"")/> 
	   <#assign activityCountsData = 100/>
		<@soy.render template="jive.nav.navbar" data=skin.navBarViewProvider.getNavBarInstance(selLink, activityCountsData,request, session) />-->
		
		<#-- TODO to take this from navbar.soy file -->
		<ul id="j-satNav"> 
			<li><div class="font-color-meta-light withmenu">Welcome, <a href="/people/${user.username}" data-username="${user.name}"  data-userid="${user.name}" class="jive-username-link   ">${user.name}</a><a href="/logout.jspa"><span id="j-satNav-logout" class="j-nav-logout"> </span></a></div></li>
		</ul>
        </#if>
    </div>
        <#recover>
		
    </#attempt>

</#if>

