<html>
<head>

    <title><@s.text name="rstpwd.reset_yr_password.title" /></title>

    <meta name="nouserbar" content="true"/>
    <meta name="nosidebar" content="true" />

    <@resource.dwr file="PasswordStrength" />
    <script language="javascript">
        function passwordStrength() {
            var text = $j("#jive-newPassword").val();
            $j.ajax({
                url: jive.rest.url("/userregistration/passwordstrength"),
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data :JSON.stringify({val: text})
            }).then(passwordStrengthUpdate);
        }
        function passwordStrengthUpdate(strength) {
           var innerText = '<@s.text name="account.password.strength.unknown" />';
            var pwClass = 'jive-pw-null';
            if ("HIGH" == strength) {
                innerText = '<@s.text name="account.password.strength.high" />';
                pwClass = 'jive-pw-strong';
            }
            if ("MEDIUMHIGH" == strength) {
                innerText = '<@s.text name="account.password.strength.medhigh" />';
                pwClass = "jive-pw-good";
            }
            else  if ("MEDIUM" == strength) {
                innerText = '<@s.text name="account.password.strength.medium" />';
                pwClass = "jive-pw-fair";
            }
            else  if ("LOW" == strength) {
                    innerText = '<@s.text name="account.password.strength.weak" />';
                    pwClass = 'jive-pw-weak';
                }
            $j("#jivePwStrength").attr("innerHTML", innerText);
            $j("#jive-pw-strength").attr("class",pwClass);
            checkPwCharTypes();
        }
        <#if minimumPasswordStrength == statics["com.jivesoftware.community.JivePasswordStrengthCheck$Strength"].HIGH>
            var patMinLen = ".{8,}";
        <#elseif minimumPasswordStrength == statics["com.jivesoftware.community.JivePasswordStrengthCheck$Strength"].MEDIUMHIGH>
            var patMinLen = ".{7,}";
        <#elseif minimumPasswordStrength == statics["com.jivesoftware.community.JivePasswordStrengthCheck$Strength"].MEDIUM>
            var patMinLen = ".{7,}";
        <#else>
            var patMinLen = ".{6,}";
        </#if>
        function checkPwCharTypes() {
        	var text = $j("#jive-newPassword").val();
			var tips = $j("#jive-pw-tips li .jive-icon-sml");
			tips.attr({"class": "jive-icon-sml jive-icon-forbidden"});
			var patMin = new RegExp(patMinLen);
			var patBetter = new RegExp(".{8,}");
			var patLC = new RegExp("[a-z]");
			var patUC = new RegExp("[A-Z]");
			var patNum = new RegExp("[0-9]");
			var patPunc = new RegExp("[-_\\W]");
			if(patMin.test(text)) {
				$j("#pw-tip-min-length .jive-icon-sml").addClass("jive-icon-check").removeClass("jive-icon-forbidden");
			};
			if(patBetter.test(text)) {
				$j("#pw-tip-recommend-length .jive-icon-sml").addClass("jive-icon-check").removeClass("jive-icon-forbidden");
			};
			if(patLC.test(text)) {
				$j("#pw-tip-lowercase .jive-icon-sml").addClass("jive-icon-check").removeClass("jive-icon-forbidden");
			};
			if(patUC.test(text)) {
				$j("#pw-tip-uppercase .jive-icon-sml").addClass("jive-icon-check").removeClass("jive-icon-forbidden");
			};
			if(patNum.test(text)) {
				$j("#pw-tip-numeral .jive-icon-sml").addClass("jive-icon-check").removeClass("jive-icon-forbidden");
			};
			if(patPunc.test(text)) {
				$j("#pw-tip-punctuate .jive-icon-sml").addClass("jive-icon-check").removeClass("jive-icon-forbidden");
			};
        }
    </script>
	<style>
	body.jive-body-formpage-password-reset #jive-pw-strength {
    margin-top: 80px;
	}
	</style>
</head>
<body class="jive-body-formpage jive-body-formpage-password jive-body-formpage-password-reset">

<!-- BEGIN layout -->
<div class="j-layout j-layout-l clearfix">

    <!-- BEGIN large column -->
    <div class="j-column-wrap-l">
        <div class="j-column j-column-l">

        <#if JiveGlobals.getJiveBooleanProperty("passwordReset.enabled", true) && !success>

            <!-- BEGIN password reset form -->
            <div class="j-box j-enhanced j-box-resetpassword">
                <div class="j-box-body j-box-body-padding j-rc4">

                    <#include "/template/global/include/form-message.ftl" />

                    <h1><@s.text name="rstpwd.reset_yr_password.title" /></h1>

                    <#if !JiveGlobals.getJiveBooleanProperty("passwordReset.enabled", true)>
                        <p><@s.text name="rstpwd.err.func_disabled.text" /></p>
                    <#elseif success>
                        <p class="jive-intro-success">
                            <span class="jive-icon-med jive-icon-check"></span><@s.text name="rstpwd.reset_success.text" />
                        </p>

                        <p class="jive-intro-success">
                            <strong><a href="<@s.url action='login' method='input'/>"><@s.text name="rstpwd.log_in_now.link" /></a></strong>
                        </p>

                    <#else>
                        <p><@s.text name="rstpwd.plsEnterUsrIdTkn.instruc" /></p>
                    </#if>

                    <form action="<@s.url action='resetPassword'/>" method="post" name="resetForm" autocomplete="off" class="j-form">

                        <#-- Username -->
                        <div id="jive-password-username" class="j-form-row">
                            <label for="jive-username"><@s.text name="global.username"/></label>
                            <input type="text" name="username" id="jive-username"  value="<@s.property value="username" />" size="30" maxlength="150">
                            <@macroFieldErrors name="username"/>
                        </div>

                        <#-- Password token -->
                        <div id="jive-password-passwordtoken" class="j-form-row">
                            <label for="jive-token"><@s.text name="global.token" /></label>
                            <input type="text" class="jive-field" id="jive-token"  name="token" size="15" maxlength="8" value="<@s.property value="token" />">
                            <@macroFieldErrors name="token"/>
                        </div>

                        <#-- New password -->
                        <div id="jive-password-newpassword" class="j-form-row">
                            <label for="jive-newPassword"><@s.text name="global.new_password" /></label>
                            <input type="password" class="jive-field" id="jive-newPassword" name="newPassword" size="15" maxlength="50" onkeyup="return passwordStrength();" autocomplete="off">
                            <@macroFieldErrors name="newPassword"/>
                        </div>

                        <#-- Confirm new password -->
                        <div id="jive-password-confirmnewpassword" class="j-form-row">
                            <label for="jive-confirmNewPassword"><@s.text name="global.confirm_password" /></label>
                            <input type="password" class="jive-field" id="jive-confirmNewPassword" name="confirmNewPassword" size="15" maxlength="50" autocomplete="off">
                            <@macroFieldErrors name="confirmNewPassword"/>
                        </div>


                        <div class="j-form-row">
                            <input type="submit" name="saveButton" class="jive-form-button-submit j-btn-callout" value="<@s.text name='global.reset' />"/>
                            <input type="submit" name="method:cancel" class="jive-form-button-cancel" value="<@s.text name='global.cancel' />"/>
                        </div>

                    </form>

                    <#include "/template/global/include/password-tips.ftl" />

                </div>
            </div>
            <!-- END password reset form -->


        </#if>

        </div>
    </div>
    <!-- END large column -->

</div>
<!-- END layout -->

</body>
</html>