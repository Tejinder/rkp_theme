<html>
<head>
    <title><@s.text name="profile.edit_user_profile.title" /></title>

    <@resource.javascript file="/resources/scripts/formconfirm.js"/>
    <@resource.javascript>
        new jive.FormConfirm("#profile-edit-form","<@s.text name="global.unsaved_changes.text"/>");
    </@resource.javascript>

	<link rel="stylesheet" href="<@resource.url value='/styles/jive-profileconfig.css'/>" type="text/css" media="all" />
    <link rel="stylesheet" href="<@resource.url value='/styles/zapatec/styles/aqua.css'/>" type="text/css" media="screen" />
	<style type="text/css">
		.form-select select
		{
			width:282px !important;
		}
	</style>

</head>
<body class="jive-body-formpage jive-body-profile-edit">


<header class="j-page-header">
    <h1><@s.text name="profile.edit_user_profile.title"/></h1>
    <#if legacyBreadcrumb>
        <content tag="breadcrumb">
            <a href="<@s.url value='/'/>">${container.name?html}</a>
            <a href="<@s.url value='/people'/>"><@s.text name="profile.people.brdcrmb.link" /></a>
            <a href="<@s.url value='/people/${username}'/>">${username}</a>
        </content>
    </#if>
</header>


<nav class="j-bigtab-nav j-rc5 j-rc-none-bottom">
    <ul class="j-tabbar j-rc5 j-rc-none-bottom">
        <li id="edit-profile-tab" class="j-tab-selected active j-ui-elem">
            <a class="j-ui-elem" href="<@s.url action="edit-profile" method="input"><@s.param name="targetUser">${targetUser.ID?c}</@s.param></@s.url>"><@s.text name="profile.edit_user_profile.title"/></a>
        </li>
        <li id="edit-profile-security-tab">
            <a href="<@s.url action="edit-profile-security" method="input"><@s.param name="targetUser">${targetUser.ID?c}</@s.param></@s.url>"><@s.text name="profile.edit_user_profile_security.title"/></a>
        </li>
    </ul>
</nav>


<#include "/template/global/include/form-message.ftl" />


<!-- BEGIN layout -->
<div class="j-layout clearfix j-contained j-contained-tabs j-rc5 j-rc-none-top">



    <#if (jiveContext.profileFieldManager.externallyManagedFields?has_content)>
    <div class="jive-info-box">
        <div>
            <span class="jive-icon-med jive-icon-info"></span>
            <@s.text name="profile.edit.ldap_managed.message" />
        </div>
    </div>
    </#if>



    <!-- BEGIN jive table -->
    <div class="j-box j-box-form">
        <div class="j-box-body">

            <form action="<@s.url action='edit-profile'/>" method="post" id="profile-edit-form" name="settingsform" enctype="multipart/form-data" autocomplete="off">

            <div class="jive-table">
                <table cellpadding="3" cellspacing="2" class="jive-edit-profile">
                <tbody>
                <tr>
                    <td class="jive-table-cell-label jive-label-required">
                        <#-- Username: -->
                        <@s.text name="global.username"/><@s.text name="global.colon"/>
                    </td>
                    <td colspan="2">
                        ${targetUser.username?html}
                    </td>
                </tr>

                <#if lastNameFirstNameEnabled>
                    <tr>
                        <td class="jive-table-cell-label jive-label-required">
                            <#-- First Name: -->
                            <label for="fname01">
                                <@s.text name="global.first.name" />
                                <span class="required"><@s.text name='global.required.parens'/></span><@s.text name="global.colon"/>
                            </label>
                        </td>
                        <td colspan="2">
                            <#if user.setNameSupported>
                                <input type="text" name="firstName" size="40" maxlength="80" id="fname01" value="${firstName!?html}" autocomplete="off" />
                            <#else>
                                ${firstName!?html}
                            </#if>

                            <@macroFieldErrors name="firstName"/>

                        </td>
                    </tr>
                    <tr>
                        <td class="jive-table-cell-label jive-label-required">
                            <#-- Last Name: -->
                            <label for="lname01">
                                <@s.text name="global.last.name" />
                                <span class="required"><@s.text name='global.required.parens'/></span><@s.text name="global.colon"/>
                            </label>
                        </td>
                        <td colspan="2">
                            <#if user.setNameSupported>
                                <input type="text" name="lastName" size="40" maxlength="80" id="lname01" value="${lastName!?html}" autocomplete="off" />
                            <#else>
                                ${lastName!?html}
                            </#if>
                            <@macroFieldErrors name="lastName"/>

                        </td>
                    </tr>

                <#else>
                    <tr>
                        <td class="jive-table-cell-label jive-label-required">
                            <label for="name01">
                                <@s.text name="global.name" />
                                <span class="required"><@s.text name='global.required.parens'/></span><@s.text name="global.colon" />
                            </label>
                        </td>
                        <td colspan="2">
                            <#if user.setNameSupported>
                                <input type="text" name="name" size="40" maxlength="80" id="name01" value="${name!?html}" autocomplete="off" />
                            <#else>
                                ${name!?html}
                            </#if>

                            <@macroFieldErrors name="name"/>

                        </td>
                    </tr>
                </#if>
				
                <tr>
                    <td class="jive-table-cell-label jive-label-required">
                        <label for="email01">
                            <@s.text name="global.email" />
                            <span class="required"><@s.text name='global.required.parens'/></span><@s.text name="global.colon" />
                        </label>
                    </td>
                    <td colspan="2">
                        <#if user.setEmailSupported>
                            <input type="text" name="email" size="40" maxlength="80" id="email01" value="${email?default('')?html}" autocomplete="off" />
                        <#else>
                            ${email?default('')?html}
                        </#if>

                        <@macroFieldErrors name="email"/>

                    </td>
                </tr>

                <#include "/template/global/include/edit-profile-rows.ftl" />

                <tr>
                    <td class="jive-table-cell-label"><@s.text name="community.tags.label" /></td>
                    <td colspan="2"><input type="text" name="tags" size="40" value="${tags!?html}" /></td>
                </tr>
				
				<#if fromSynchro?? && fromSynchro>
				<#include "/template/global/include/synchro-macros.ftl" />
					<tr>
						<td class="jive-table-cell-label">
							<label>Brand<@s.text name="global.colon" /></label>
						</td>
						<td colspan="2">
							<@renderBrandFilter name='brand' value='${brand?default(-1)}' readonly=true/>
						</td>
					</tr>
					<tr>
						<td class="jive-table-cell-label">
							<label>Region<@s.text name="global.colon" /></label>
						</td>
						<td colspan="2">
							<@renderRegionFilter name='region' value='${region?default(-1)}' readonly=true/>
						</td>
					</tr>
					<tr>				
						<td class="jive-table-cell-label">
							<label>Country<@s.text name="global.colon" /></label>
						</td>
						<td colspan="2">
							<@renderCountryFilter name='country' value='${country?default(-1)}' disabled=true/>
						</td>
					</tr>
					<tr>
						<td class="jive-table-cell-label">
							<label>Job Title<@s.text name="global.colon" /></label>
						</td>
						<td colspan="2">
							<@renderJobTitleFilter name='jobTitle' value='${jobTitle?default(-1)}' readonly=true/>
						</td>
					</tr>  
				</#if>
                <tr>
                    <td>&nbsp;</td>
                    <td class="jive-edit-profile-submit" colspan="2">
                        <input type="submit" name="save" class="jive-form-button-submit j-btn-callout" value="<@s.text name="global.save" />"/>
                        <input type="submit" name="method:cancel" class="jive-form-button-cancel" value="<@s.text name="global.cancel" />"/>
                    </td>
                </tr>
                </tbody>
                </table>
            </div>

            <input type="hidden" name="username" value="${targetUser.username?html}"/>
            <input type="hidden" name="targetUser" value="${targetUser.ID?c}"/>
            <@jive.token name="edit.profile.${targetUser.ID?c}" />

            </form>

        </div>
    </div>
    <!-- END jive table -->





</div>
<!-- END layout -->


</body>
</html>
