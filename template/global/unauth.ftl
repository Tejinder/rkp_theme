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
                <#--<span class="jive-icon-med jive-icon-redalert"></span>-->
                <#if user.anonymous>
                    <@s.text name="login.wrn.notAuthToViewCnt.link">
                        <@s.param><a href="<@s.url action='login'/>"></@s.param>
                        <@s.param></a></@s.param>
                    </@s.text>
                    
                    <#if (newAccountCreationEnabled && !jive.isSeatStatusBlocked())>
                        <@s.text name="login.create_account_full.text">
                            <@s.param><a href="<@s.url action='create-account'/>"></@s.param>
                            <@s.param></a></@s.param>
                        </@s.text>
                    </#if>
				<#elseif url?? && url?contains("/synchro/")>
					<@s.text name="synchro.err.notAuthToViewCnt.info"/>
                <#else>
                    <@s.text name="login.err.notAuthToViewCnt.info"/>
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