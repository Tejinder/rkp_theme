<html>
<head>
    <title><@s.text name="login.user_login.title"/></title>
    <meta name="nosidebar" content="true" />
    <meta name="nouserbar" content="true" />
    <meta name="nofooter" content="true" />
</head>
<body class="jive-body-formpage jive-body-formpage-loginpopup">

<!-- BEGIN header & intro  -->
<div id="jive-body-intro">
    <div id="jive-body-intro-content">
        <h1><@s.text name="login.user_login.title"/></h1>
        <p><@s.text name="login.description.text"/></p>
    </div>
</div>
<!-- END header & intro -->

<!-- BEGIN main body -->
<div id="jive-body-main">

    <!-- BEGIN main body column -->
    <div id="jive-body-maincol-container">
        <div id="jive-body-maincol">
            <#include "/template/global/include/form-message.ftl" />

            <!-- BEGIN login form -->
            <div class="jive-standard-formblock-container jive-login-formblock">
                <div class="jive-standard-formblock">

                    <form action="cs_loginpopup" method="post" name="loginform01" autocomplete="off">

                    <#if (successURL??)>
                        <input type="hidden" name="successURL" value="${successURL?html}"/>
                    </#if>
                    <#if (cancelURL??)>
                        <input type="hidden" name="cancelURL" value="${cancelURL?html}"/>
                    </#if>

                    <#-- Username -->
                    <div id="jive-login-username">
                    <label for="username01"><@s.text name="global.username"/><@s.text name="global.colon"/></label>
                    <input type="text" name="username" size="30" maxlength="150" value="" id="username01">
                    <@macroFieldErrors name="username"/>
                    </div>

                    <#-- Password: -->
                    <div id="jive-login-password">
                    <label for="password01"><@s.text name="global.password"/><@s.text name="global.colon"/></label>
                    <input type="password" name="password" size="30" maxlength="150" value="" id="password01">
                    <@macroFieldErrors name="password"/>
                    </div>

                    <#-- Remember Me -->
                    <#if action.isRememberMeEnabled() >
                    <div id="jive-login-rememberme">
                    <input type="checkbox" name="autoLogin" id="autoLoginCb" value="true">
                    <label for="autoLoginCb"><@s.text name="global.remember_me"/></label>
                    </div>
                    </#if>

                    <div class="jive-form-buttons">
                        <#-- Login -->
                        <input type="submit" name="login" class="jive-form-button-submit" value="<@s.text name="global.login" />"/>
                        <input type="button" value="Cancel"  onclick="window.close();" />
                    </div>

                    </form>


                    <script type="text/javascript" language="JavaScript">
                        $('username01').focus();
						 
                    </script>

                </div>
            </div>
            <!-- END login form -->



        </div>
    </div>
    <!-- END main body column -->


</div>
<!-- END main body -->


</body>
</html>