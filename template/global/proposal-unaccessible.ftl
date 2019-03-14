<html>
<head>

    <title><@s.text name="unauth.unauthorized.title"/></title>

    <meta name="nosidebar" content="true" />

</head>
<body class="jive-body-warn jive-body-unathorized">


<!-- BEGIN header & intro  -->
<div id="jive-body-intro">
    <div id="jive-body-intro-content">
        <h1><@s.text name="unauth.unauthorized.title"/></h1>
        <p><@s.text name="unauth.description.text"/>
        </p>
    </div>
</div>
<!-- END header & intro -->

<!-- BEGIN main body -->
<div id="jive-body-main">

    <!-- BEGIN main body column -->
    <div id="jive-body-maincol-container">
        <div id="jive-body-maincol">

        <br clear="all"/>
		<#assign url = request.requestURL />
		
        <#include "/template/global/include/form-message.ftl" />

        <div id="jive-error-box" class="jive-error-box unauth-warning">
            <div>
                
                <#if isProposalAwarded?? && isProposalAwarded >
	                <#assign pibURL = "" />
	                <#assign psURL = "" />
	                <#if project.multiMarket >
	                	<#assign pibURL = "/synchro/pib-multi-details!input.jspa?projectID=${projectID?c}" />
	                	<#assign psURL = "/synchro/project-multi-specs!input.jspa?projectID=${projectID?c}" />
	                <#else>
	                	<#assign pibURL = "/synchro/pib-details!input.jspa?projectID=${projectID?c}" />
	                	<#assign psURL = "/synchro/project-specs!input.jspa?projectID=${projectID?c}" />
	                </#if>
	                Proposal stage will be inaccessible to Communication Agency roles. Please visit <a href="${pibURL}"> PIB </a> or <a href="${psURL}"> Project Specs </a> Stage.
	             <#else>
	             	<#if project.multiMarket >
	                	<#assign pibURL = "/synchro/pib-multi-details!input.jspa?projectID=${projectID?c}" />
	                	
	                <#else>
	                	<#assign pibURL = "/synchro/pib-details!input.jspa?projectID=${projectID?c}" />
	                	
	                </#if>
	                
	                Proposal stage will be inaccessible to Communication Agency roles. Please visit <a href="${pibURL}">PIB </a> Stage.
	             </#if>
                
            </div>
        </div>

        </div>
    </div>
    <!-- END main body column -->


</div>
<!-- END main body -->


</body>
</html>