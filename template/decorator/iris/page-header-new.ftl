

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
    <#else>
    <a class="j-header-logo irisHeaderLogo" href="/iris-summary/home!input.jspa"></a>
	<div class="logoHiddenText">IRIS Home</div>
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
		<#--<li><div class="font-color-meta-light withmenu">Welcome, <a href="/people/${user.username}" data-username="${user.name}"  data-userid="${user.name}" class="jive-username-link   ">${user.name}</a><a title="Logout" href="/logout.jspa"><span id="j-satNav-logout" class="j-nav-logout"> </span></a></div></li>-->
		
		<li><div class="font-color-meta-light withmenu">Welcome, <a href="javascript:void(0);" data-username="${user.name}"  data-userid="${user.name}" class="jive-username-link   ">${user.name}</a><a class="showhiddenTxt" href="/logout.jspa"><span id="j-satNav-logout" class="j-nav-logout"> </span></a></div>
        </li>
		
		</ul>
        <div class="headerLogoutHiddenText">Logout</div>
        </#if>
    </div>
        <#recover>
		
    </#attempt>

</#if>

<script type="text/javascript">
    
    $j(document).ready(function(){
	$j('a.j-header-logo.irisHeaderLogo').hover(function() {      
       $j('.logoHiddenText').css('display','block');    
       }, function() {
          $j('.logoHiddenText').css('display','none');
        });


       $j('#j-satNav a.showhiddenTxt').hover(function() {      
       $j('.headerLogoutHiddenText').css('display','block');    
       }, function() {
          $j('.headerLogoutHiddenText').css('display','none');
        });


    });

</script>


