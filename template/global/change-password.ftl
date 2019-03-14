<html>
<head>

    <title><@s.text name="settings.change_password_title"/></title>

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

</head>
<body class="jive-body-formpage jive-body-formpage-changepassword">


<!-- BEGIN layout -->
<div class="j-layout j-layout-l clearfix">

    <!-- BEGIN large column -->
    <div class="j-column-wrap-l">
        <div class="j-column j-column-l">

            <#if user.setPasswordSupported>
            <#if JiveGlobals.getJiveBooleanProperty("passwordReset.enabled", true)>

            <#include "/template/global/include/form-message.ftl" />

            <!-- BEGIN form block -->
            <div class="j-box j-enhanced j-box-changepassword">
                <div class="j-box-body j-rc4">

 					<h1><@s.text name="settings.change_password_title"/></h1>


                  <#if JiveGlobals.getJiveBooleanProperty("jive.auth.forceSecure", false)>
 					<#assign changeURI><@s.url value="change-password.jspa" scheme="https"/></#assign>
 					<#else>
 					<#assign changeURI><@s.url value="change-password.jspa"/></#assign>
 					</#if>
				
                        <form action="${changeURI}" method="post" name="settingsform" autocomplete="off" class="j-form">
                        <@jive.token name="change.password.${user.ID?c}" />

                        <#-- Current Password: -->
                        <div id="jive-password-currentPassword" class="jive-label-input-pair j-form-row">
                            <label for="jive-currentPassword"><@s.text name="global.current_password"/></label>
                            <input type="password" name="currentPassword" id="jive-currentPassword" size="20" maxlength="100"
                                   value="">
                            <@macroFieldErrors name="currentPassword"/>
                        </div>

                        <#-- New Password: -->
                        <div id="jive-password-newpassword" class="jive-label-input-pair j-form-row">
                            <label for="jive-newPassword"><@s.text name="global.new_password"/></label>
                            <input type="password" name="newPassword" id="jive-newPassword" size="20" maxlength="100"
                                   value="" onkeyup="return passwordStrength();">
                            <@macroFieldErrors name="passwordLength"/>
                            <@macroFieldErrors name="newPassword"/>
                        </div>
                        <#-- Confirm New Password: -->
                        <div id="jive-password-confirmnewpassword" class="jive-label-input-pair j-form-row">
                            <label for="jive-confirmNewPassword"><@s.text name="global.confirm_password"/></label>
                            <input type="password" name="confirmNewPassword" id="jive-confirmNewPassword" size="20" maxlength="100" value="">
                            <@macroFieldErrors name="confirmNewPassword"/>
                            <@macroFieldErrors name="passwordMatch"/>
                        </div>

                        <div class="jive-form-buttons j-form-row">
                            <input type="submit" name="save" value="<@s.text name="global.save" />"
                                   class="jive-form-button-submit j-btn-callout"/>
                            <input type="submit" name="method:cancel" value="<@s.text name="global.cancel" />"
                                   class="jive-form-button-cancel"/>
                        </div>
                        <#if request.getParameter("from")?? && request.getParameter("from") == 'selective_screen'>
                        <input type="hidden" name="from" class="${request.getParameter("from")}">
                        </#if>
                    </form>

                    <#include "/template/global/include/password-tips.ftl" />

                </div>
            </div>
            <!-- END form block -->

            </#if>
            </#if>

        </div>
    </div>
    <!-- END large column -->

</div>
<!-- END layout -->

</div>

</body>
</html>
