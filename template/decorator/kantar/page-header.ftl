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
<a class="j-header-logo"></a>
<#else>
<#if synchroURL?contains("kantar-dashboard")>
<a class="j-header-logo"></a>
<#else>
    <#assign portalType = ""/>
 <#if session.getAttribute('grail.portal.type')??>
    <#assign portalType =  session.getAttribute('grail.portal.type')>
</#if>

<#if portalType == 'kantar_report'>
<a class="j-header-logo kantar" href="/kantar-report/dashboard.jspa"></a>
<#else>
<a class="j-header-logo kantar" href="/kantar/home!input.jspa"></a>
</#if>

</#if>
   
        <#attempt>
        <div class="welcome">
            <#if !page.getProperty("meta.nouserbar")??>
      <#--  <#assign selLink = page.getProperty("meta.nav.active.link")!""/>
        <#assign activityCountsData = action.getActivityCounts(page.getProperty("meta.sub.nav.active.link")!"")/>
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
<#--<#if showHome?? && !showHome>
            <a href="#" class="help-icon"><span>help</span></a>
        </#if>-->

