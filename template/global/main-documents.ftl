<#include "/template/docs/include/doc-macros.ftl" />
<html>
<head>
    <title>${community.name?html} <@s.text name="main.documents.documents.title" /></title>

    <#if FeedUtils.isFeedsEnabled()>
        <link rel="alternate" type="${FeedUtils.getFeedType()}"
            title="${community.name} <@s.text name='main.documents.docsFeed.tooltip'/>"
            href="<@s.url value="/community/feeds/documents?community=${community.ID?c}"
                />" />
    </#if>

	<link rel="stylesheet" href="<@resource.url value='/styles/jive-community.css'/>" type="text/css" media="all" />
	<link rel="stylesheet" href="<@resource.url value='/styles/jive-wiki.css'/>" type="text/css" media="all" />

    <content tag="breadcrumb">
        <@s.action name="community-breadcrumb" executeResult="true" ignoreContextParams="true">
            <@s.param name="container" value="${community.ID?c}" />
            <@s.param name="containerType" value="${community.objectType?c}" />
        </@s.action>
        <a href="<@s.url value='/docs/'/>"><@s.text name='global.documents' /></a>
    </content>
</head>

<body class="jive-browse-documents">


<!-- BEGIN header & intro  -->
<div id="jive-body-intro">
    <div id="jive-body-intro-content">

        <!-- <a href="<@s.url action='index'/>" class="jive-icon-link-back">Back to ${community.name?html}</a> -->

        <div id="jive-body-intro-main-hdr">
            <h1><span class="jive-icon-big jive-icon-document"></span><@s.text name="main.documents.documents.title" /></h1>
            <span id="jive-body-intro-main-hdr-stats">
                &nbsp;
            </span>
        </div>
    </div>
</div>
<!-- END header & intro -->


<!-- BEGIN main body -->
<div id="jive-body-main">

    <!-- BEGIN main body column -->
    <div id="jive-body-maincol-container">
    	<div id="jive-body-maincol">

            <#if showSpaceBrowser>
                <@documentCommunityList />
            </#if>

            <div id="jive-view-documents-container">
                <#-- We do not want to ignoreContextParams here, since request params on this parent action
                     should carry into the view-threads action -->
                <@s.action name="view-documents" executeResult="true"/>
            </div>

    	</div>
    </div>
    <!-- END main body column -->



    <!-- BEGIN sidebar column -->
    <div id="jive-body-sidebarcol-container">
    	<div id="jive-body-sidebarcol">

            <#if !JiveContainerPermHelper.isBannedFromPosting()>
            <!-- BEGIN sidebar box 'ACTIONS' -->
            <div class="jive-sidebar jive-sidebar-actions">
                <div class="jive-sidebar-header"></div>
                <div class="jive-sidebar-body jive-sidebar-body-actions">
                    <h4><@s.text name="main.documents.actions.gtitle" /></h4>
                    <ul class="jive-icon-list">
                        <li><a href="<@s.url action='choose-container' method='input'><@s.param name="containerType" value="${community.objectType?c}"/><@s.param name="container" value="${community.ID?c}"/><@s.param name="contentType" value="${JiveConstants.DOCUMENT?c}"/></@s.url>"><span class="jive-icon-med jive-icon-document"></span><@s.text name="main.documents.creatNewDoc.link" /></a></li>
                    </ul>
                </div>
            </div>
            <!-- END sidebar box 'ACTIONS' -->
            </#if>

            <@displayPopularDocuments container=community limit=10 />

            <@s.action name="status-level-leaders" executeResult="true" ignoreContextParams="true">
                <@s.param name="container" value="${community.ID?c}"/>
                <@s.param name="containerType" value="${community.objectType?c}"/>
            </@s.action>

            <@s.action name="tag-cloud" executeResult="true" ignoreContextParams="true">
                <@s.param name="community" value="${community.ID?c}"/>
                <@s.param name="taggableTypes" value="${JiveConstants.DOCUMENT}"/>
                <@s.param name="recursive" value="'true'"/>
                <@s.param name="numResults" value="'15'"/>
            </@s.action>

            <!-- BEGIN sidebar box 'LEGEND' -->
            <div class="jive-sidebar">
                <div class="jive-sidebar-header">
                    <h4><@s.text name="main.documents.legend.title" /></h4>
                </div>
                <div class="jive-sidebar-body jive-sidebar-body-legend">
                    <ul class="jive-icon-list">
                        <li><span class="jive-icon-med jive-icon-document"></span><@s.text name="main.documents.clbDoc.listitem" /></li>
                        <li><span class="jive-icon-med jive-icon-doctype-document"></span><@s.text name="main.documents.offcdoc.listitem" /></li>
                        <li><span class="jive-icon-med jive-icon-doctype-spreadsheet"></span><@s.text name="main.documents.sprdsht.listitem" /></li>
                        <li><span class="jive-icon-med jive-icon-doctype-presentation"></span><@s.text name="main.documents.present.listitem" /></li>
                        <li><span class="jive-icon-med jive-icon-doctype-text"></span><@s.text name="main.documents.plain.listitem" /></li>
                        <li><span class="jive-icon-med jive-icon-doctype-acrobat"></span><@s.text name="main.documents.adobe.listitem" /></li>
                        <li><span class="jive-icon-med jive-icon-doctype-image"></span><@s.text name="main.documents.image.listitem" /></li>
                        <li><span class="jive-icon-med jive-icon-doctype-video"></span><@s.text name="main.documents.video.listitem" /></li>
                        <li><span class="jive-icon-med jive-icon-doctype-compressed"></span><@s.text name="main.documents.cmprssd.listitem" /></li>
                        <li><span class="jive-icon-med jive-icon-doctype-generic"></span><@s.text name="main.documents.other.listitem" /></li>
                    </ul>
                </div>
            </div>
            <!-- END sidebar box 'LEGEND' -->


    	</div>
    </div>
    <!-- END sidebar column -->


</div>
<!-- END main body -->

</body>
</html>
