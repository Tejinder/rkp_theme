<head>
    <style>
        #advsearch_text {
            text-align: left;
            -moz-border-radius: 6px;
            background: #eef2f7;
            -webkit-border-radius: 6px;
            border: 1px solid #536376;
            -webkit-box-shadow: rgba(0,0,0,.6) 0px 2px 12px;
            -moz-box-shadow:  rgba(0,0,0,.6) 0px 2px 12px;;
            padding: 14px 22px;
            width: 400px;
            position: relative;
            display: none;
        }

        #search_examples {
            background: #FFFFFF;
            border: 1px solid #536376;
            padding: 5px;
        }

        table#advSearch {
            width:98%;
        }

        table#advSearch td {
            padding: 7px 5px;
            border-bottom: 1px solid #c3ccd8;
        }
		
		a#top{display:none;}
		

    </style>

<#if session.getAttribute('grail.portal.type')??>
    <#assign portalType =  session.getAttribute('grail.portal.type')>
</#if>

    <#assign pageTitle=action.getText('global.portal.title')></assign>
<#if (request.requestURI?contains('/login.jspa'))>
        <#assign pageTitle=action.getText('global.portal.login.title')></assign>
<#elseif (request.requestURI?contains('/portal-options.jspa'))>
        <#assign pageTitle=action.getText('global.portal.selection.title')></assign>
<#elseif (request.requestURI?contains('/disclaimer.jspa'))>
        <#assign pageTitle=action.getText('global.portal.disclaimer.title')></assign>
<#elseif portalType??>
    <#if portalType == 'rkp'>
            <#assign pageTitle=action.getText('global.rkp.title')></assign>
    <#elseif portalType == 'synchro'>
            <#assign pageTitle=action.getText('global.synchro.title')></assign>
    <#elseif portalType == 'grail'>
            <#assign pageTitle=action.getText('global.grail.title')></assign>
    <#elseif portalType == 'kantar'>
            <#assign pageTitle=action.getText('global.kantar.title')></assign>
    </#if>
</#if>

    <title>${pageTitle}</title>
	
	
		 <link href="${themePath}/style/bootstrap.css" rel="stylesheet">
	  <link href="${themePath}/style/custom.css" rel="stylesheet">
	   
	 <link rel="stylesheet" href="${themePath}/style/rkp.css?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/css" media="all" />
	  <link rel="stylesheet" href="${themePath}/style/rkp_new.css?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/css" media="all" />
	 
</head>
<#include "/template/decorator/default/header-favicon.ftl" />


<div class="grail-wrapper">
    <a name="top"></a>
	<#assign url_string = request.requestURL />
	<#if url_string?? && (url_string?contains("portal-options.jspa") || url_string?contains("change-password-expired") || url_string?contains("disclaimer.jspa")
	|| url_string?contains("change-password") || (url_string?contains("login.jspa")) || url_string?contains("resetPassword") || url_string?contains("emailPasswordToken"))>
		<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/dynamic-height-loader.js'/>"></script>
		<div id="j-header-wrap">
			<#if (url_string?contains("portal-options.jspa"))>
				<header></header>
			<#else>
					<#--<header id="j-header" class="j-common-header"></header> -->
				<header id="j-header" class="main-header">
				<div class="top-icons">
					<img src='${themePath}/images/icon1.png'>
				</div>
				<div class="top-icons">
					<img src="${themePath}/images/icon2.png">
				</div>
				<div class="top-icons">
					<img src="${themePath}/images/icon3.png">
				</div>
				<div class="top-icons">
					<img src="${themePath}/images/icon4.png">
				</div>
</header>
			</#if>
		</div>
	<#else>
		
	</#if>

<#if skin??>
    <#assign titleEscaped = false />
    <#if (page.getProperty("meta.titleEscaped")??)>
        <#if (page.getProperty("meta.titleEscaped") != "false")>
            <#assign titleEscaped = true />
        </#if>
    </#if>

    <#if (page.getProperty("meta.embedded")!"false") == "false">

		<#if url_string?? && (url_string?contains("portal-options.jspa") || url_string?contains("change-password-expired") || url_string?contains("disclaimer.jspa")
			|| url_string?contains("change-password") || (url_string?contains("login.jspa")) || (url_string?contains("resetPassword")) || url_string?contains("emailPasswordToken"))>       
			
				<#if url_string?contains("login.jspa") || url_string?contains("disclaimer.jspa") || url_string?contains("portal-options.jspa")>
							 <@soy.render template="jive.skin.template.main"
						data=skin.template params={
						"title": page.title!"",
						"titleEscaped": titleEscaped,
						"headContent": page.head!"",
						"bodyContent" :page.body!"",
						"bodyClass" :page.getProperty("body.class")!"",
						"noHeader": page.getProperty("meta.noheader")!false,
						<#--"noFooter": page.getProperty("meta.nofooter")!false,-->
						"noFooter": true,
						"noPaletteCss":page.getProperty("meta.nopalettecss")!false,
					   <#-- "noUserBar": page.getProperty("meta.nouserbar")!false,-->
						"noUserBar": true,
						"customizeSite": page.getProperty("meta.customizesite")!false,
						"postFooter": page.getProperty("page.postfooter")!"",
						"jiveTooltip" : page.getProperty("page.jiveTooltip")!"",
						"pageBreadcrumb" : page.getProperty("page.breadcrumb")!"",
						"excludeCommonContainer" : page.getProperty("meta.excludecommoncontainer")!"",
						"selectedLinkID" :page.getProperty("meta.nav.active.link")!"",
						"customizeSite":page.getProperty("meta.customizesite")!false,
						"asyncLoadRTE" : page.getProperty("meta.asyncLoadRTE")!true,
						"showNav":false}/>
				<#else>
					<@soy.render template="jive.skin.template.embedded"
					data=skin.template params={
					"title": page.title!"",
					"headContent": page.head!"",
					"bodyContent" :page.body!"",
					"bodyClass" :page.getProperty("body.class")!"",
					"excludeCommonContaineFr" : true,
					"asyncLoadRTE" : page.getProperty("meta.asyncLoadRTE")!true}/>
				</#if>
			<#else>
			
	
			   <@soy.render template="jive.skin.template.main"
				data=skin.template params={
				"title": page.title!"",
				"titleEscaped": titleEscaped,
				"headContent": page.head!"",
				"bodyContent" :page.body!"",
				"bodyClass" :page.getProperty("body.class")!"",
				"noHeader": page.getProperty("meta.noheader")!false,
				<#--"noFooter": page.getProperty("meta.nofooter")!false,-->
				"noFooter": true,
				"noPaletteCss":page.getProperty("meta.nopalettecss")!false,
			   <#-- "noUserBar": page.getProperty("meta.nouserbar")!false,-->
				"noUserBar": true,
				"customizeSite": page.getProperty("meta.customizesite")!false,
				"postFooter": page.getProperty("page.postfooter")!"",
				"jiveTooltip" : page.getProperty("page.jiveTooltip")!"",
				"pageBreadcrumb" : page.getProperty("page.breadcrumb")!"",
				"excludeCommonContainer" : page.getProperty("meta.excludecommoncontainer")!"",
				"selectedLinkID" :page.getProperty("meta.nav.active.link")!"",
				"customizeSite":page.getProperty("meta.customizesite")!false,
				"asyncLoadRTE" : page.getProperty("meta.asyncLoadRTE")!true,
				"showNav":true}/>
			</#if>
    <#else>
	
        <@soy.render template="jive.skin.template.embedded"
        data=skin.template params={
        "title": page.title!"",
        "headContent": page.head!"",
        "bodyContent" :page.body!"",
        "bodyClass" :page.getProperty("body.class")!"",
        "excludeCommonContaineFr" : true,
        "asyncLoadRTE" : page.getProperty("meta.asyncLoadRTE")!true}/>
    </#if>
<#else>

Skin is missing.  Did TemplateView creation fail (check logs for stack trace in JiveActionSupport#getSkin)?
</#if>


<#include "/template/decorator/default/post-footer.ftl" />
<#if url_string?? && (url_string?contains("portal-options.jspa") || (url_string?contains("login.jspa")) || (url_string?contains("disclaimer.jspa")))>
    <!-- Syncho Disclaimer -->
    <footer >
        <div class="footer_main">
            <div class="footer-left"><h4>British American Tobacco</h4></div>
            <div class="footer-right">
                <ul>
                    <#--<li class="footer-info"><a href="#"></a></li>-->
                    <#--<li><a href="<@s.url value="/new-synchro/help.jspa"/>">Support</a></li>-->
                    <#--<li><a href="#">Terms & Conditions</a></li>-->
                </ul>
            </div>
        </div>
      
    </footer>
<#else>
    <footer id="j-footer">
        <div class="jive-footer-nav">
            <#assign license = jiveContext.getLicenseManager().getJiveLicense()/>
            <a href="http://www.jivesoftware.com/poweredby/" target="_blank">
                <#if portalType??>
                    <#if portalType == 'synchro'>
                        Synchro powered by Jive SBS @ ${license.version.versionString} Community Software</p>
                    <#elseif portalType == 'grail'>
                        Research Support powered by Jive SBS @ ${license.version.versionString} community software
                    <#else>
                        Research Knowledge Portal powered by Jive SBS @ ${license.version.versionString} community software
                    </#if>
                <#else>
                    Research Knowledge Portal powered by Jive SBS @ ${license.version.versionString} community software
                </#if>
            </a>
        </div>

        
    </footer>
</#if>
</div>

<div id="advsearch_text" style="display:none";>
</div>
 
<script>
/*
 $j(document).ready(function(){
      
		DocumentCartService.getCartItemsCount(function(response){
                document.getElementById('view-grail-cart').innerHTML  = '<a id="view-grail-cart" href="<@s.url action="view-cart"/>"><span class="icon icon_view_cart"></span>View Cart ('+response+')</a>';
            } );
    })*/
</script>
