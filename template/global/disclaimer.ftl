<html>
<head>
    <title>Disclaimer</title>
    <meta name="nosidebar" content="true" />
    <meta name="nouserbar" content="true" />
    <script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/dynamic-height-loader.js'/>"></script>

</head>
<body class="jive-body-formpage jive-body-formpage-login">
<#--<#if (type==statics['com.grail.util.BATGlobal$PortalType'].SYNCHRO.toString() || type==statics['com.grail.util.BATGlobal$PortalType'].GRAIL.toString())>-->
<link rel="stylesheet" href="${themePath}/style/synchro-disclaimer.css?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/css" media="all" />
<#--</#if>-->
<script type="text/javascript">
    $j(document).ready(function(){
        $j("#disclaimer-container.jive-standard-formblock").hide();
        var dynamicHeight = DYNAMIC_HEIGHT_LOADER.getMainContainerHeight();
        dynamicHeight = dynamicHeight - 105;

        $j("#disclaimer-container.jive-standard-formblock").css("height", dynamicHeight);
        $j("#disclaimer-container.jive-standard-formblock").show();
    });

</script>
<!-- BEGIN main body -->
<div id="jive-body-main">
    <!-- BEGIN main body column -->
    <div id="jive-body-maincol-container">
        <div id="jive-body-maincol">
            <div class="main_disclaimer">
                <div class="jive-standard-formblock-container jive-login-formblock">
                    <label>Legal Notices</label>
                    <div id="disclaimer-container" class="jive-standard-formblock">
                        <div>
                            <span><strong class="dis_heading">Additional Conditions of Use</strong></span>
                            <span>
						
                                    <p>Please use the Research Management Tools [Synchro, IRIS, Share and Oracle] responsibly and respectfully. The Research Management Tools are a global business resource and must not be used for personal conversations.</p>
                                    <p>Please consider that once you submit information on the Research Management Tools, everyone with access to the Research Management Tools can read it.</p>
                                    <p>Please make your submission(s) clearly and ensure that it is not misunderstood. Do not forget that you are legally responsible for what you submit on the Research Management Tools and you should not share information that you would not want disclosed in court.</p>
                                    <p>Please consider how your comment could be received by others.</p>
                                    <p>You agree to keep your username and password confidential. If you suspect that your username and password have become known to another party then you agree to change your password immediately.</p>
                            </span>
                        </div>

                        <div>
                            <span><strong class="dis_heading">ASU30</strong></span>
                            <span>
                                    <p>Where any reference is made in this document to 'adult' or 'young adult', the term is defined as anyone who is 18 years or over or such higher age as the local law and/or industry code in any particular country requires. Any reference in this document to 'ASU30', 'consumer', 'target consumers', 'smokers', 'target audience', or any similar term shall mean smokers who are adults.</p>
                            </span>
                        </div>


                        <div>
                            <span><strong class="dis_heading">Local Legislation/Regulations</strong></span>
                            <span>
                                    <p>Please note that the material contained in this document related to a specific market and as such may present applications and issues which might not be legally permissible in other markets. Similarly, you should not assume that because an application has been permitted in your market in the past that it will continue to be permitted in the future, since tobacco regulation and legislation changes regularly. In addition, the company's views on socially responsible marketing are subject to change in response to feedback from each of its stakeholder groups. As a result, you must ensure that prior to applying any such activities or applications in your own market you obtain specific local legal advice regarding the permissibility of that activity or application, taking into consideration both local legislation and regulations, the implementation of the International Marketing Standards and the then current views on socially responsible marketing practices.</p>
                            </span>
                        </div>

                        <div>
                            <span>
                                <p><strong class="dis_heading copyright">Copyright</strong> © British-American Tobacco (Holdings) Limited. All rights reserved. No part of this document may be reproduced in any form or any means without the prior written consent of British-American Tobacco (Holdings) Limited. This document is proprietary to British-American Tobacco (Holdings) Limited and is provided at its discretion. Unauthorised possession or use of this material or disclosure of the proprietary information may result in legal action.</p>
                            </span>
                        </div>

                        <div>
                            <span><strong class="dis_heading">Data Protection Notice</strong></span>
                            <span>
                                    <p>British-American Tobacco (Holdings) Limited respects the privacy of British American Tobacco ("BAT") Group personnel. It is committed to safeguarding their privacy and to acting responsibly and with integrity with regard to protecting their rights and freedoms.</p>
                                    <p>In registering to use the Research Management Tools services ("the Services") you will be required to input certain personal data relating to you such as your name, business email address and telephone number ("Your Personal Data").</p>
                                    <p>BASS will collect, use and/or process Your Personal Data in order to provide you with the Services and may share Your Personal Data with other members of the BAT Group of Companies worldwide so that it can be processed in order to provide you with the Services.</p>
                                    <p>Your Personal Data may be shared with other members of the BAT Group of Companies worldwide, Integreon Inc., Grail Research (a division of Integreon Managed Solutions, Inc.) and its Subcontractors outside the European Economic Area ("EEA" meaning member countries of the European Union and Switzerland and, Norway, Iceland and Liechtenstein) so that it can be processed in order to monitor your use of the system and share with you the latest developments about the system via newsletter or periodic surveys.</p>
                                    <p>Your Personal Data will be retained in the system until such time that your User account ends either because you are no longer a User or because you have left your employment at BAT at which point Your Personal Data will be deleted.</p>
                                    <p>In proceeding with your registration to use the Services you agree to the processing and handling of Your Personal Data as set out above.</p>
                                    <p>Should you require any further information please contact: <a href="mailto:Taina_Vauhkonen@bat.com">Taina Vauhkonen</a></p>
                            </span>
                        </div>


                    </div>
                    <center class="clear">
                        <form action="disclaimer.jspa" method="post" name="loginform01" autocomplete="off" class="jive-accept-div">
                            <input type="hidden" name="accept" value="true" />
							<#if synchroRedirectUrl??>
								<input type="hidden" name="synchroRedirectUrlRetained" value="${synchroRedirectUrl}" />
							<#else>	
								<input type="hidden" name="synchroRedirectUrlRetained" value="" />
							</#if>
                            <input type="submit" class="jive-form-button-accept continue" value="Accept" />
                        </form>
                        <form action="disclaimer.jspa" method="post" name="loginform01" autocomplete="off"  class="jive-decline-div">
                            <input type="hidden" name="decline" value="true" />
                            <input type="submit" class="jive-form-button-decline cancel" value="Decline" />
                        </form>
                        <span style="font-size:14px;"><strong>I have read and understood these legal notices.</strong></span>
                    </center>
                </div>
            </div>
        </div>
    </div>
    <!-- END main body column -->
</div>

<!-- END main body -->

</body>
</html>