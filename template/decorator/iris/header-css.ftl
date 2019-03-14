    <link rel="stylesheet" href="<@resource.url value='/styles/jive.css'/>" type="text/css" media="all" />
    <link rel="stylesheet" href="<@resource.url value='/styles/jive-icons.css'/>" type="text/css" media="all" />
	<link rel="stylesheet" href="<@resource.url value='${themePath}/style/jquery-ui.css'/>" type="text/css" media="all" />
	
    <#list skin.template.pluginCSSSrcURLs as src >
        <link rel="stylesheet" href="<@s.url value='${src}' />" type="text/css" media="all" />
    </#list>

    <#if skin.template.includeBasicCSS>
        <link rel="stylesheet" href="<@s.url value='${skin.template.basicCSSPath}'/>" type="text/css" />
    </#if>

    <#if skin.template.basicLogoUsed>
       <style type="text/css">
            a#logo {
                background-image: url(${skin.template.basicLogoPath});
                no-repeat: scroll 0%;
            }
       </style>
    </#if>

    <#if chatPresenceManagerImpl.isPresenceAvailable()>
        <link rel="stylesheet" href="<@resource.url value='/styles/jive-eim.css'/>" type="text/css" media="all"/>
    </#if>


