

<html>
<head>
    <title><@s.text name="login.user_login.title"/></title>
    <link rel="stylesheet" href="<@resource.url value='/styles/jive-global-extended.css'/>" type="text/css" media="screen" />
	 
    <meta name="nosidebar" content="true"/>
    <meta name="nouserbar" content="true"/>

<@resource.javascript file="/resources/scripts/jquery/jquery.tooltip.js" />
    <script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/dynamic-height-loader.js'/>"></script>

	
</head>
<body class="jive-body-formpage jive-body-formpage-login">

<script type="text/javascript">
    $j(function () {
        $j("input#login-submit").removeAttr('disabled');
        $j("input#login-submit").removeClass("processing");
        $j("form#loginform").submit( function() {
            $j("input#login-submit").addClass("processing");
            $j("input#login-submit").val("<@s.text name="login.processing.text"/>");
            $j("input#login-submit").attr("disabled", "disabled");
        });
        $j("input#register-submit").removeAttr('disabled');
        $j("form#registerform").submit( function() {
            $j("input#register-submit").val("<@s.text name="login.processing.text"/>");
            $j("input#register-submit").attr("disabled", "disabled");
        });
    });

   $j(document).ready(function(){
       DYNAMIC_HEIGHT_LOADER.initialize();
   })

</script>



<!-- BEGIN main body -->
<div id="jive-body-main">



    <!-- BEGIN main body column -->
    <div id="jive-body-maincol-container">
        <div id="jive-body-maincol">

            <!-- BEGIN login form -->
        <#assign showRegisterForm = (newAccountCreationEnabled && !jive.isSeatStatusBlocked())/>

            <div class="jive-standard-formblock-container jive-login-reg-formblock clearfix <#if (!showRegisterForm || registerOnly)>jive-login-short-width</#if>">

            <#include "/template/global/include/form-message.ftl" />
                <div class="jive-standard-formblock">

                <#if approvalRequired>
                    <div class="jive-info-box">
                        <div>
                            <#--<span class="jive-icon-med jive-icon-redalert"></span>-->
                            <@s.text name="login.info.acctNotApproved.text" />
                        </div>
                    </div>
                </#if>

                <#if !registerOnly>
                    <div id="jive-login-formblock" <#if (!showRegisterForm)>class="jive-login-only-box"</#if>>

                        <h1><@s.text name="login.user_login.title"/></h1>
                        <p><@s.text name="login.description.text"/></p>

                        <#if JiveGlobals.getJiveBooleanProperty("jive.auth.forceSecure", false)>
                            <#assign loginURI><@s.url value="/cs_login" scheme="https"/></#assign>
                        <#else>
                            <#assign loginURI><@s.url value="/cs_login"/></#assign>
                        </#if>

                        <form action="${loginURI}" id="loginform" method="post" name="loginform01" autocomplete="off">


                            <input type="hidden" name="fromLogin" value="true"/>
                            <#if (successURL?exists)>
                                <input type="hidden" name="successURL" value="${successURL?html}"/>
                            </#if>
                            <#if (cancelURL?exists)>
                                <input type="hidden" name="cancelURL" value="${cancelURL?html}"/>
                            </#if>

                        <#-- Username -->
                            <div id="jive-login-username" class="clearfix">
                                <label for="username01"><@s.text name="global.username"/><@s.text name="global.colon"/></label>
                                <input type="text" name="username" size="30" maxlength="150" value="" id="username01"/>
                                <@macroFieldErrors name="username"/>
                            </div>

                        <#-- Password: -->
                            <div id="jive-login-password" class="clearfix">
                                <label for="password01"><@s.text name="global.password"/><@s.text name="global.colon"/></label>
                                <input type="password" name="password" size="30" maxlength="150" value="" id="password01"/>
                                <@macroFieldErrors name="password"/>
                            </div>

                           <#-- <#if (action.isLoginThrottled() || action.isFailedCaptchaRequest()) && action.isCaptchaEnabled()>-->
                            <#-- Captcha: 
                                <div id="jive-login-captcha">
                                    <img src="${captchaImageUrl}" alt="">
                                    <label for="${captchaKey}">Enter the characters you see in the image<@s.text name="global.colon"/></label>
                                    <input type="text" name="${captchaKey}" size="30" maxlength="150" value=""
                                           id="${captchaKey}">
                                    <@macroFieldErrors name="password"/>
                                </div>
                           </#if> -->

                        <#-- Remember Me -->						
                            <#if action.isRememberMeEnabled() >
                                <div id="jive-login-rememberme" class="clearfix">
                                    <input type="checkbox" name="autoLogin" id="autoLoginCb" value="true"/>
                                   <#-- <label for="autoLoginCb"><@s.text name="global.remember_me"/></label>-->
								    <label for="autoLoginCb">Remember Me</label>
                                </div>
                            </#if>

                            <div id="jive-login-button" class="clearfix">
                            <#-- Login -->
                                <input type="submit" name="login" id="login-submit"
                                       class="jive-form-button-submit" <#if action.isLoginThrottled()>
                                       disabled='disabled' </#if> value="<@s.text name="global.login" />"/>
                                <a href="<@s.url action='emailPasswordToken' method='input'/>"><@s.text name="login.forgot_pwd.link"/></a>
                            </div>

                            <#if (JiveGlobals.getJiveBooleanProperty("passwordReset.enabled", true))>
                            <#-- I forgot my password -->
                                <div id="jive-login-forgotpwd" class="jive-login-forgotpwd">


                                <#-- <br/> <br/>
                                             BAT Interact link
                                            <font color="black">If you are not yet registered, please </font><a href="http://interact/interact/marketing/sb_theview.nsf/(0)/254B80051D87E969802577D6003E07ADXXX?OpenDocument" target="_blank">click here</a>-->

                                    <font>If you are not registered, Please fill in this </font><a href="/file/download/OSP_User_Application_Form(V1.5).xlsm">application form</a> <font>and send to </font><a href="mailto:assistance@batinsights.com">assistance@batinsights.com</a>
                                    <br><br><font>Note: If you have <b>not logged in for the past 5 months</b> your account will be deactivated. Please contact the </font><a href="mailto:assistance@batinsights.com">administrator</a> <font>to

                                    reactivate your account</font>
                                </div>
                            </#if>

                        </form>

                    </div>
                </#if>


                <#if showRegisterForm>
                    <#if validationEnabled>

                    <#-- send validation email -->
                        <div id="jive-validate-formblock">
                            <#if validationSent>

                                <h2><@s.text name="login.validate.title"/></h2>
                                <p class="jive-validation-sent">
                                    <@s.text name="login.validate.desc">
                                        <@s.param><strong>${emailAddress}</strong></@s.param>
                                    </@s.text>
                                </p>
                            <#else>

                                <h2><@s.text name="login.no_account.title"/></h2>
                                <p>
                                    <#if SkinUtils.isDomainRestrictionEnabled() >
                               <@s.text name="login.no_account.desc"><@s.param>${SkinUtils.getCompanyName()}</@s.param></@s.text>
                           <#else>
                                        <@s.text name="login.no_account.unrestrict.desc"></@s.text>
                                    </#if>
                                </p>
                                <form action="<@s.url action='login'/>" method="post" id="registerform" name="registerform01" autocomplete="off">
                                    <label for="emailAddress">
                                        <strong><@s.text name="login.email.text"/></strong>
                                        <#if SkinUtils.isDomainRestrictionEnabled() >
                                            <#if SkinUtils.isSingleDomain()>
                                                <span><@s.text name="login.email.info"><@s.param>${SkinUtils.getCompanyDomain()}</@s.param></@s.text></span>
                                            <#else>
                                                <a href="#" onClick="return false;" class="tooltip"
                                                   title="<@s.text name="login.email.info.domains"> <@s.param>${SkinUtils.getAllCompanyDomainsHTML()}</@s.param> </@s.text>">
                                                    <span><@s.text name="login.email.info.multi"><@s.param>${SkinUtils.getCompanyName()}</@s.param></@s.text></span>
                                                </a>
                                            </#if>
                                        </#if>
                                    </label>
                                    <input type="text" name="emailAddress" value="${emailAddress!}" class="jive-validate-email"/>
                                    <input type="submit" id="register-submit" name="regsubmit" value="<@s.text name='login.email.confirm.button'/>"  class="jive-validate-confirm"/>
                                    <input type="hidden" name="method:register" value="true" />
                                        <input type="hidden" name="registerOnly" value=<#if registerOnly> "true" <#else> "false" </#if> />
                                    <@macroFieldErrors name="emailAddress"/>
                                </form>

                            </#if>

                        </div>

                    <#else>

                    <#-- create user account -->
                        <h2><@s.text name="login.no_account.title"/></h2>
                        <p id="jive-create-account-formblock">
                            <@s.text name="login.create_account.text">
                                <@s.param><a href="create-account.jspa"></@s.param>
                                <@s.param></a></@s.param>
                            </@s.text>
                        </p>
                    </#if>
                </#if>

                    <script type="text/javascript" language="JavaScript">
                        $j('#username01').focus();
                        <#if action.isLoginThrottled()>
                        var delay = ${loginDelay};
                        setTimeout(function() {
                            $j('#jive-error-box').fadeOut("fast");
                            $j('#login01').removeAttr("disabled");
                        }, delay * 1000);
                        </#if>
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