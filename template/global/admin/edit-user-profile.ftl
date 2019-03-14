<html>
<head>
    <title>User Summary: ${targetUser.username}</title>
    <content tag="pagetitle">User Summary: ${targetUser.username?html}</content>
    <content tag="pageID">usergroups-searchusers</content>
    <content tag="pagehelp">
        <h3>Help Section Here</h3>
        <p>
          View and edit user properties using the form below. Other useful information is provided as well such as last post time and group memberships.
        </p>
    </content>
    <script language="JavaScript" type='text/javascript' src="<@s.url value='/resources/scripts/domLib.js' />"></script>
    <script language="JavaScript" type='text/javascript' src="<@s.url value='/resources/scripts/domTT.js' />"></script>
    <@soy.render template="jive.skin.template.javascript.zapatec"
                 data={ "calendarOverrideFormat": calendarOverrideFormat , "calendarFileName": calendarFileName } />

    <style type="text/css">
        table.jive-profile-datetime-container tbody tr td { padding: 0 5px 0 0;}
	.tpd-managing-blk{display:none;}
	.tpd-managing-blk select {    margin-left: 60px;}
	#tpdErrorMessage{color:red;}
    </style>
	 <link rel="stylesheet" href="<@s.url value='/admin/style/synchro-admin.css'/>">
</head>
<body>

<form action="<@s.url action='user-status'/>" name="statusForm" id="statusForm" method="post">
    <input type="hidden" name="userId" value="${targetUser.ID?c}">
    <@jive.token name="edit.profile.admin.status.${targetUser.ID?c}" />
</form>

<form action="<@s.url action='user-federated'/>" name="federateForm" id="federateForm" method="post">
    <input type="hidden" name="userId" value="${targetUser.ID?c}">
    <@jive.token name="edit.profile.admin.federate.${targetUser.ID?c}" />
</form>

<form action="<@s.url action='user-delete-externalid'/>" name="extIdDeleteForm" id="extIdDeleteForm" method="post">
    <input type="hidden" name="userId" value="${targetUser.ID?c}">
    <input type="hidden" name="extid" id="extId">
    <@jive.token name="edit.profile.admin.extid.delete.${targetUser.ID?c}" />
</form>

<form action="<@s.url value='/admin/user-delete.jsp'/>" name="deleteForm" id="deleteForm" method="post">
    <input type="hidden" name="user" value="${targetUser.ID?c}">
    <@jive.token name="edit.profile.admin.delete.${targetUser.ID?c}" />
</form>

<form action="<@s.url action='user-moderate'/>" name="moderateForm" id="moderateForm" method="post">
    <input type="hidden" name="userId" value="${targetUser.ID?c}">
    <@jive.token name="edit.profile.admin.moderate.${targetUser.ID?c}" />
</form>

<#include "/template/global/include/form-message.ftl">

<#if (success)>

    <div class="jive-success">
    <table cellpadding="0" cellspacing="0" border="0">
    <tbody>
        <tr><td class="jive-icon"><img src="images/success-16x16.gif" width="16" height="16" border="0" alt="" /></td>
        <td class="jive-icon-label">
        User properties updated successfully.
        </td></tr>
    </tbody>
    </table>
    </div><br />
    
</#if>

<#if usernameIsEmail>
    <div id="jive-info-box" class="jive-info-box" aria-live="polite" aria-atomic="true">
        <span class="jive-icon-med jive-icon-info"></span>
        <@s.text name="profile.edit.usernameIsEmail" />
    </div>
</#if>

<p>

<#assign showEdit = displayEditControls />

<#if targetUser.setPasswordHashSupported && showEdit>
&raquo;
<a href="user-password.jsp?user=${targetUser.ID?c}" title="Change this users password">Change Password</a>
&nbsp;&nbsp;
</#if>
&raquo;
<a href="user-documents.jsp?user=${targetUser.ID?c}" title="Click to view or delete all documents created by this user">View Documents</a>
&nbsp;&nbsp;

&raquo;
<a href="user-messages.jsp?user=${targetUser.ID?c}" title="Click to view or delete all discussion messages posted by this user">View Discussion Messages</a>
&nbsp;&nbsp;

&raquo;
<a href="user-blogposts.jsp?user=${targetUser.ID?c}" title="Click to view or delete all blog posts created by this user">View Blog Posts</a>
&nbsp;&nbsp;

&raquo;
<a href="user-xprops.jsp?user=${targetUser.ID?c}" title="Click to manage user extended properties">User Properties</a>
&nbsp;&nbsp;

<#if showEdit>
&raquo;
<a href="#" title="Delete User and Content" onclick="deleteForm.submit(); return false;">Delete User and Content</a>
&nbsp;&nbsp;
</#if>

<#if devInstallation >
&raquo;
<a href="user-digest.jsp?userId=${targetUser.ID?c}" title="Generate Digest Email">Test Digest Email</a>
&nbsp;&nbsp;
</#if>


</p>

<form action="editUserProfile.jspa" method="post" id="editForm">
<@jive.token name="edit.profile.admin.${user.ID?c}" />
<input type="hidden" name="userId" value="${targetUser.ID?c}">

<div class="jive-table">
<table cellpadding="0" cellspacing="0" border="0" width="100%">
<thead>
    <tr>
        <th colspan="3">User Properties</th>
    </tr>
</thead>
<tbody>
    <tr>
    	<td width="35%">User ID:</td>
    	<td colspan="2">${targetUser.ID?c}</td>
    </tr>
    <tr>
    	<td width="35%">Username:</td>
    	<td colspan="2">
    	    <#if targetUser.setUsernameSupported && showEdit && !usernameIsEmail>

                <input type="text" id="username" name="username" size="40" maxlength="254"
                       value="${username?default('')?html}">

                <@macroFieldErrors name="username"/>

                <#if targetUser.federated>
                    <script type="text/javascript">
                        $j('#username').change(function() {
                            $j('form').submit(function(e) {
                                if(!confirm('<@s.text name="profile.edit.change_username.warning"/>')) {
                                    e.stopPropagation();
                                    return false;
                                }
                            });
                        });
                    </script>
                </#if>

            <#else>

                ${username?default('')?html}

            </#if>
    	</td>
    </tr>
    <#if targetUser.setPasswordHashSupported && canChangePassword && showEdit >
        <tr>
            <td width="35%">Password:</td>
            <td colspan="2"><a href="user-password.jsp?user=${targetUser.ID?c}">Change Password</a></td>
        </tr>
    </#if>
    <tr>
    	<td width="35%">
            Activated:
            <img id="jive-status-tooltip" alt="" src="<@s.url value='/images/transparent.png' />" class="jive-icon-med jive-icon-help"
                  onmouseover="domTT_activate(this, event, 'content',
                    'Deactivate a user&#146;s account to prevent their logging in, receiving notifications, and so on, but to keep their content. Jive SBS will display the user&#146;s account as deactivated. A user account that&#146;s deactivated will not count toward your license limit.',
                    'styleClass', 'jive-tooltip', 'trail', true, 'delay', 300, 'lifetime', 8000);" />
        </td>
    	<td colspan="2">
            <#if targetUser.enabled>
                <span class="jive-status-enabled">Yes</span>
                <#if showEdit>
                <a href="#" class="jive-description" onclick="if(confirm('Are you sure you want to deactivate this user account?')){statusForm.submit()}; return false;">[Deactivate]</a>
                </#if>
            <#else>
                <span class="jive-status-disabled">No</span>
                <#if (jiveContext.licenseManager.seatStatusOK || jiveContext.licenseManager.seatStatusWarning)>
                    <#if showEdit>
                    <a href="#" class="jive-description" onclick="if (confirm('Are you sure you want to activate this user account?')){statusForm.submit()}; return false;">[Activate]</a>
                    </#if>
                <#else>
                    <a href="<@s.url action='license'/>" class="jive-description">[View License]</a>
                </#if>
            </#if>
        </td>
    </tr>

    <tr>
        <td width="35%">
            Federated:
            <img id="jive-status-tooltip" alt="" src="<@s.url value='/images/transparent.png' />" class="jive-icon-med jive-icon-help" />
        </td>
        <td colspan="2">
        <#if targetUser.federated>
            <span class="jive-federated-yes">Yes</span>
            <a href="#" class="jive-description" onclick="federateForm.submit(); return false;">[Unfederate]</a>
        <#else>
            <span class="jive-federated-no">No</span>
            <a href="#" class="jive-description" onclick="federateForm.submit(); return false;" >[Federate]</a>
        </#if>
        </td>
    </tr>

    <#if targetUser.status == statics['com.jivesoftware.base.User$Status'].awaiting_moderation ||
         targetUser.status == statics['com.jivesoftware.base.User$Status'].rejected>
    <tr>
        <td width="35%">
            Moderation Status:
        </td>
        <td colspan="2">
        <#if targetUser.status == statics['com.jivesoftware.base.User$Status'].awaiting_moderation>
            <span class="jive-status-enabled">Awaiting Moderation</span>
        <#else>
            <span class="jive-status-disabled">Rejected</span>
            <a href="#" class="jive-description" onclick="moderateForm.submit(); return false;" >[Submit for moderation]</a>
        </#if>
        </td>
    </tr>
    </#if>

    <tr>
        <td width="35%">External Identities:</td>
        <td colspan="2">
        <#if (externalIdentities.size() == 0)>
            No external identities.
        <#else>
            <table cellpadding="0" cellspacing="0" border="0" style="min-width: 350px;">
            <table cellpadding="0" cellspacing="0" border="0" style="min-width: 350px;">
                <thead>
                    <tr>
                        <th>Identity</th>
                        <th>Type</th>
                        <th width="15%" nowrap="nowrap">Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <#list externalIdentities as extid>
                    <tr>
                        <td>${extid.identity!?html}</td>
                        <td>
                            <#if extid.type??>
                                <#if extid.type.id == 1>SAML
                                <#elseif extid.type.id == 2>OpenID
                                <#elseif extid.type.id == 3>Facebook
                                <#elseif extid.type.id == 4>LDAP DN
                                <#elseif extid.type.id == -257867437>LDAP UUID
                                <#else>${extid.type.id?c}
                                </#if>
                            <#else>
                                null
                            </#if>
                        </td>
                        <td class="user-column jive-table-cell-delete control-column"><a href="#"
                               class="jive-description" onclick="if (confirm('Are you sure you want to delete this external identity entry?')){
                                $j('#extId').val('${extid.externalIdentityID?c}'); extIdDeleteForm.submit();
                               }; return false;">
                            <img src="../images/jive-icon-delete-16x16.gif" width="16" height="16" alt="Delete External Identity..." border="0"></a></td>
                    </tr>
                    </#list>
            </tbody>
            </table>
        </#if>
        </td>
    </tr>

    <tr>
    	<td width="35%">Activity:</td>
    	<td colspan="2">
            <a href="user-documents.jsp?user=${targetUser.ID?c}" title="View Documents"
             >Documents(${totalDocumentCount})</a>,
            <a href="user-messages.jsp?user=${targetUser.ID?c}" title="View Discussion Messages"
             >Messages(${totalMessageCount})</a>,
            <a href="user-blogposts.jsp?user=${targetUser.ID?c}" title="View Blog Posts"
             >Blog Posts(${totalBlogpostCount})</a>
    </td>
    </tr>
    <tr>
    	<td width="35%">Last Activity:</td>
    	<td colspan="2">
            <#if (lastActivity?exists)>${lastActivity?datetime?string.medium_short}<#else>No activity</#if>
        </td>
    </tr>
    <tr>
    	<td width="35%">Member Since:</td>
    	<td colspan="2">${targetUser.creationDate?date}</td>
    </tr>
    <#if lastNameFirstNameEnabled>
        <tr>
            <td width="35%"><@s.text name="global.first.name" /><@s.text name="global.colon"/></td>
            <td colspan="2">
                <#if targetUser.setNameSupported && showEdit >

                    <input type="text" name="firstName" size="40" maxlength="100"
                           value="${firstName?default('')?html}">

                    <@macroFieldErrors name="firstName"/>

                <#else>

                    ${firstName?default('')?html}

                </#if>
            </td>
        </tr>
        <tr>
            <td width="35%"><@s.text name="global.last.name" /><@s.text name="global.colon"/></td>
            <td colspan="2">
                <#if targetUser.setNameSupported && showEdit>

                    <input type="text" name="lastName" size="40" maxlength="100"
                           value="${lastName?default('')?html}">

                    <@macroFieldErrors name="lastName"/>

                <#else>

                    ${lastName?default('')?html}

                </#if>
            </td>
        </tr>
    <#else>
        <tr>
            <td width="35%">Name:</td>
            <td colspan="2">
                <#if targetUser.setNameSupported && showEdit>

                    <input type="text" name="name" size="40" maxlength="100"
                           value="${name?default('')?html}">

                    <@macroFieldErrors name="name"/>

                <#else>

                    ${name?default('')?html}

                </#if>
            </td>
        </tr>
    </#if>

    <tr>
        <td width="35%">Name visibility:</td>
        <td colspan="2">
            <#assign opts = securityLevelOptions.get('name')/>
            <#if opts?size gt 1>
                <@s.select theme="simple" name="nameSecurityLevelID" emptyOption="false"
                    list="securityLevelOptions['name']" listKey="ID" listValue="name" value="nameSecurityLevelID"/>
            <#else>
                ${opts.get(0).name?html}
                <@s.hidden name="nameSecurityLevelID"/>
            </#if>
        </td>
    </tr>
    
    <tr>
    	<td width="35%">Email:</td>
    	<td colspan="2">
            <#if changeEmailSupported && showEdit>

                <input type="text" name="email" size="40" maxlength="254"
                       value="${email?default('')?html}">

                <@macroFieldErrors name="email"/>
            
            <#else>

                ${email?default('')?html}

            </#if>
    	</td>
    </tr>

    <tr>
        <td width="35%">Email visibility:</td>
        <td colspan="2">
            <#assign opts = securityLevelOptions.get('email')/>
            <#if opts?size gt 1>
                <@s.select theme="simple" name="emailSecurityLevelID" emptyOption="false"
                    list="securityLevelOptions['email']" listKey="ID" listValue="name" value="emailSecurityLevelID"/>
            <#else>
                ${opts.get(0).name?html}
                <@s.hidden name="emailSecurityLevelID"/>
            </#if>
        </td>
    </tr>
    
    <#if displayGroups>
        <tr>
            <td width="35%">Groups:</td>
            <td colspan="2">
                <#if (groups.size() == 0)>

                    No group memberships.

                <#else>
                    <#list groups as group>
                        <a href="group-props!input.jspa?groupID=${group.ID?c}" title="Group ID: ${group.ID?c}"
                             >${group.name?html}</a><#if (group_index < groups.size()-1)>,</#if>
                    </#list>
                </#if>
            </td>
        </tr>
    </#if>

    <tr>
        <td width="35%">User Type:</td>
        <td colspan="2">
            <#assign opts = userTypeOptions/>
            <#if opts?size gt 1>
               <@s.select theme="simple" name="type" emptyOption="false"
                list="userTypeOptions" listKey="Id" listValue="%{getText('user.type.'+Id)}" value="type"/>
            <#else>
                <#assign typeId = "user.type."+opts.get(0).id/>
                <@s.text name="${typeId}"/>
                <@s.hidden name="type"/>
            </#if>
        </td>
    </tr>

    <style type="text/css">
        <#-- override the jive label class for the profile field includes -->
        .jive-label {
            background-color: #fff;
            padding-right: 10px;
            width: 1%;
            white-space: nowrap;
        }
    </style>

    <#include "/template/global/include/edit-profile-rows.ftl" />
	
	<!-- Customizations starts here -->




<!--  Synchro Filter fields - start -->
<#if fromSynchro?? && fromSynchro>
    <#include "/template/global/include/synchro-macros.ftl" />
<tr style="height: 25px;">
<td colspan="3"></td>
</tr>
<tr class="synchro-user-profile-fields configuration-header">
<td colspan="3"><label>Synchro User Properties Configuration</label></td>
</tr>
<tr class="synchro-user-profile-fields">
<td class="jive-table-cell-label">
<label>Brand<@s.text name="global.colon" /></label>
</td>
<td colspan="2">
<@renderBrandFilter name='brand' value='${brand?default(-1)}'/>
</td>
</tr>
<tr class="synchro-user-profile-fields">
<td class="jive-table-cell-label">
<label>Region<@s.text name="global.colon" /></label>
</td>
<td colspan="2">
<@renderRegionFilter name='region' value='${region?default(-1)}'/>
</td>
</tr>
<tr class="synchro-user-profile-fields">
<td class="jive-table-cell-label">
<label>Country<@s.text name="global.colon" /></label>
</td>
<td colspan="2">
<@renderCountryFilter name='country' value='${country?default(-1)}'/>
</td>
</tr>
<tr class="synchro-user-profile-fields">
<td class="jive-table-cell-label">
<label>Job Title<@s.text name="global.colon" /></label>
</td>
<td colspan="2">
<@renderJobTitleFilter name='jobTitle' value='${jobTitle?default(-1)}'/>
</td>
<#--</tr>-->
<#--<tr class="synchro-user-profile-fields">-->
<#--<td class="jive-table-cell-label">-->
<#--<label>Agency Group Name<@s.text name="global.colon" /></label>-->
<#--</td>-->
<#--<td colspan="2">-->
<#--<select id="agencyGroupName" name="agencyGroupName">-->
<#--<option disabled="disabled" selected="true">Select agency group name</option>-->
<#--<#if allDepartments??>-->
<#--<#list allDepartments as userDepartment>-->
<#--<option value="${userDepartment.name}" <#if agencyGroupName?? && userDepartment.name==agencyGroupName>selected="true"</#if>>${userDepartment.name}</option>-->
<#--</#list>-->
<#--</#if>-->
<#--</select>-->
<#--</td>-->
<#--</tr>-->

<tr style="height: 20px;">
    <td colspan="3"></td>
</tr>
<tr class="synchro-user-profile-fields configuration-header">
    <td colspan="3"><label>Synchro Project Access Configuration</label></td>
</tr>
<#--<tr class="synchro-user-profile-fields drop-down">-->
    <#--<td class="jive-table-cell-label">-->
        <#--<label>Job Title<@s.text name="global.colon" /></label>-->
    <#--</td>-->
    <#--<td>-->
        <#--<@renderJobTitleFilter name='jobTitle' value='${jobTitle?default(-1)}'/>-->
    <#--</td>-->
    <#--<td>-->
    <#--</td>-->
<#--</tr>-->

<tr class="synchro-user-profile-fields">
    <td width="35%"><label>Brands:</label></td>
    <td colspan="2">
        <div>
            <div class="form-select_div">
                <label><span class="list">All Brands</span></label>
                <select size="3" id="all-brands" class="all" multiple="true">
                    <#if unselectedBrands?has_content>
                        <#list  unselectedBrands.keySet() as unselectedBrandKey>
                            <option value="${unselectedBrandKey}">${unselectedBrands.get(unselectedBrandKey)}</option>
                        </#list>
                    </#if>
                </select>
                <div class="action_buttons">
                    <input id="add-brands" type="button" value=">>" class="left_arrow">
                    <input id="remove-brands" type="button" value="<<" class="right_arrow">
                </div>
            </div>

            <div class="form-select_div_brand">
                <label><span class="list">Selected Brands</span></label>
                <select id="selected-brands" multiple="true" size="3" class="selected">
                    <#if selectedBrands?has_content>
                        <#list selectedBrands.keySet() as selectedBrandKey>
                            <option value="${selectedBrandKey}">${selectedBrands.get(selectedBrandKey)}</option>
                        </#list>
                    </#if>
                </select>
            </div>
            <script type="text/javascript">
                $j(function() {
                    $j("#add-brands, #remove-brands").click(function(event) {
                        var id = $j(event.target).attr("id");
                        var selectFrom = id == "add-brands" ? "#all-brands" : "#selected-brands";
                        var moveTo = (id == "add-brands") ? "#selected-brands" : "#all-brands";
                        var selectedItems = $j(selectFrom + " :selected").toArray();
                        $j(moveTo).append(selectedItems);
                        reArrangeSelect("brand");
                    });
                });
            </script>
        </div>
    </td>
</tr>

    <#if externalAgencyUser?? && externalAgencyUser>
    <tr class="synchro-user-profile-fields">
        <td width="35%" style="border-bottom: none;"><label>Departments:</label></td>
        <td colspan="2" style="border-bottom: none;">
            <div>
                <div class="form-select_div">
                    <label><span class="list">All Departments</span></label>
                    <select size="3" id="all-departments" name="all-departments" class="all" multiple="true">
                        <#if unselectedDepartments?has_content>
                            <#list unselectedDepartments.keySet() as unselectedDepartmentKey>
                                <option value="${unselectedDepartmentKey}">${unselectedDepartments.get(unselectedDepartmentKey)}</option>
                            </#list>
                        </#if>
                    </select>
                    <div class="action_buttons">
                        <input id="add-departments" type="button" value=">>" class="left_arrow">
                        <input id="remove-departments" type="button" value="<<" class="right_arrow">
                    </div>
                </div>

                <div class="form-select_div_brand">
                    <label><span class="list">Selected Departments</span></label>
                    <select id="selected-departments" name="selected-departments" multiple="true" size="3" class="selected">
                        <#if selectedDepartments?has_content>
                            <#list selectedDepartments.keySet() as selectedDepartmentKey>
                                <option value="${selectedDepartmentKey}">${selectedDepartments.get(selectedDepartmentKey)}</option>
                            </#list>
                        </#if>
                    </select>
                </div>
                <script type="text/javascript">
                    $j(function() {
                        $j("#add-departments, #remove-departments").click(function(event) {
                            var id = $j(event.target).attr("id");
                            var selectFrom = id == "add-departments" ? "#all-departments" : "#selected-departments";
                            var moveTo = (id == "add-departments") ? "#selected-departments" : "#all-departments";
                            var selectedItems = $j(selectFrom + " :selected").toArray();
                            $j(moveTo).append(selectedItems);
                            reArrangeSelect("department");
                        });
                    });
                </script>
            </div>

        </td>
    </tr>
    <tr class="synchro-user-profile-fields">
        <td></td>
        <td colspan="2" style="padding-top: 0px;"><span class="jive-error-message"  id="departments-error-message" style="display: none;">Please select departments.</span></td>
    </tr>
    </#if>

<tr class="synchro-user-profile-fields">
<td width="35%"><label>Access:</label></td>
<td colspan="2">
<div class="access-type-container">
    <div>
        <input id="globalAccessType" type="checkbox" value="${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].GlOBAL.getId()}"
               name="accessTypeGroup" onchange="accessTypeChange(this)" <#if globalAccessSuperUser?? && globalAccessSuperUser == true>checked="true"</#if>>
        <label for="globalAccessType">${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].GlOBAL.getDescription()} Super User</label>
    </div>
</div>
<div class="access-type-container">
    <div>
        <input id="regionalAccessType" type="checkbox" value="${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].REGION.getId()}"
               name="accessTypeGroup" onchange="accessTypeChange(this)" <#if regionalAccessSuperUser?? && regionalAccessSuperUser == true>checked="true"</#if>>
        <label for="regionalAccessType">${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].REGION.getDescription()}</label>
    </div>
    <div class="access-type-selection-container">
        <div id="region-selection">
            <div class="form-select_div">
                <label><span class="list">Normal user regions</span></label>
                <select size="3" id="normal-user-regions" name="normal-user-regions" class="all" multiple="true" <#if !(regionalAccessSuperUser?? && regionalAccessSuperUser == true)>disabled="disabled"</#if>>
                    <#if unselectedRegions?has_content>
                        <#list  unselectedRegions.keySet() as unselectedRegionKey>
                            <option value="${unselectedRegionKey}">${unselectedRegions.get(unselectedRegionKey)}</option>
                        </#list>
                    </#if>
                </select>
                <div class="action_buttons">
                    <input id="add-regions" type="button" value=">>" class="left_arrow" <#if !(regionalAccessSuperUser?? && regionalAccessSuperUser == true)>disabled="disabled"</#if>>
                    <input id="remove-regions" type="button" value="<<" class="right_arrow" <#if !(regionalAccessSuperUser?? && regionalAccessSuperUser == true)>disabled="disabled"</#if>>
                </div>
            </div>

            <div class="form-select_div_brand">
                <label><span class="list">Super user regions</span></label>
                <select id="super-user-regions" name="super-user-regions" multiple="true" size="3" class="selected" <#if !(regionalAccessSuperUser?? && regionalAccessSuperUser == true)>disabled="disabled"</#if>>
                    <#if selectedRegions?has_content>
                        <#list  selectedRegions.keySet() as selectedRegionKey>
                            <option value="${selectedRegionKey}">${selectedRegions.get(selectedRegionKey)}</option>
                        </#list>
                    </#if>
                </select>
            </div>
            <script type="text/javascript">
                $j(function() {
                    $j("#add-regions, #remove-regions").click(function(event) {
                        var id = $j(event.target).attr("id");
                        var selectFrom = id == "add-regions" ? "#normal-user-regions" : "#super-user-regions";
                        var moveTo = (id == "add-regions") ? "#super-user-regions" : "#normal-user-regions";
                        var selectedItems = $j(selectFrom + " :selected").toArray();
                        $j(moveTo).append(selectedItems);
                        reArrangeSelect("region");
                        //updateSelectedCountryList();

                    });
                });
            </script>
        </div>
    </div>
</div>
<#--<div  class="access-type-container">
    <div>
        <input id="areaAccessType" type="checkbox" value="${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].AREA.getId()}"
               name="accessTypeGroup"  onchange="accessTypeChange(this)" <#if areaAccessSuperUser?? && areaAccessSuperUser == true>checked="true"</#if>>
        <label for="areaAccessType">${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].AREA.getDescription()}</label>
    </div>
    <div class="access-type-selection-container">
        <div id="area-selection">
            <div class="form-select_div">
                <label><span class="list">Normal user areas</span></label>
                <select size="3" id="normal-user-areas" name="normal-user-areas" class="all" multiple="true" <#if !(areaAccessSuperUser?? && areaAccessSuperUser == true)>disabled="disabled"</#if>>
                    <#if unselectedAreas?has_content>
                        <#list  unselectedAreas.keySet() as unselectedAreaKey>
                            <option value="${unselectedAreaKey}">${unselectedAreas.get(unselectedAreaKey)}</option>
                        </#list>
                    </#if>
                </select>
                <div class="action_buttons">
                    <input id="add-areas" type="button" value=">>" class="left_arrow" <#if !(areaAccessSuperUser?? && areaAccessSuperUser == true)>disabled="disabled"</#if>>
                    <input id="remove-areas" type="button" value="<<" class="right_arrow" <#if !(areaAccessSuperUser?? && areaAccessSuperUser == true)>disabled="disabled"</#if>>
                </div>
            </div>

            <div class="form-select_div_brand">
                <label><span class="list">Super user areas</span></label>
                <select id="super-user-areas" name="super-user-areas" multiple="true" size="3" class="selected" <#if !(areaAccessSuperUser?? && areaAccessSuperUser == true)>disabled="disabled"</#if>>
                    <#if selectedAreas?has_content>
                        <#list  selectedAreas.keySet() as selectedAreaKey>
                            <option value="${selectedAreaKey}">${selectedAreas.get(selectedAreaKey)}</option>
                        </#list>
                    </#if>
                </select>
            </div>
            <script type="text/javascript">
                $j(function() {
                    $j("#add-areas, #remove-areas").click(function(event) {
                        var id = $j(event.target).attr("id");
                        var selectFrom = id == "add-areas" ? "#normal-user-areas" : "#super-user-areas";
                        var moveTo = (id == "add-areas") ? "#super-user-areas" : "#normal-user-areas";
                        var selectedItems = $j(selectFrom + " :selected").toArray();
                        $j(moveTo).append(selectedItems);
                        reArrangeSelect("area");
                       // updateSelectedCountryList();
                    });
                });
            </script>
        </div>
    </div>
</div> -->
<div  class="access-type-container">
    <div>
	<input id="endmarketAccessType" type="checkbox" value="${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].COUNTRY.getId()}"
               name="accessTypeGroup" onchange="accessTypeChange(this)" <#if endmarketAccessSuperUser?? && endmarketAccessSuperUser == true>checked="true"</#if>>
        <label>${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].COUNTRY.getDescription()}</label>
    </div>	
    <div class="access-type-selection-container">
        <div id="country-selection">
            <div class="form-select_div">
                <label><span class="list">Normal user countries</span></label>
                <select size="3" id="normal-user-countries" name="normal-user-countries" class="all" multiple="true" <#if !((regionalAccessSuperUser?? && regionalAccessSuperUser == true) || (areaAccessSuperUser?? && areaAccessSuperUser == true) || (globalAccessSuperUser?? && globalAccessSuperUser == false))>disabled="disabled"</#if>>

                    <#if unselectedCountries?has_content>
                        <#list  unselectedCountries.keySet() as unselectedCountryKey>
                            <option value="${unselectedCountryKey}">${unselectedCountries.get(unselectedCountryKey)}</option>
                        </#list>
                    </#if>
                </select>
                <div class="action_buttons">
                    <input id="add-countries" type="button" value=">>" class="left_arrow" <#if !((regionalAccessSuperUser?? && regionalAccessSuperUser == true) || (areaAccessSuperUser?? && areaAccessSuperUser == true) || (globalAccessSuperUser?? && globalAccessSuperUser == false))>disabled="disabled"</#if>>
                    <input id="remove-countries" type="button" value="<<" class="right_arrow" <#if !((regionalAccessSuperUser?? && regionalAccessSuperUser == true) || (areaAccessSuperUser?? && areaAccessSuperUser == true) || (globalAccessSuperUser?? && globalAccessSuperUser == false))>disabled="disabled"</#if>>
                </div>
            </div>

            <div class="form-select_div_brand">
                <label><span class="list">Super user countries</span></label>
                <select id="super-user-countries" name="super-user-countries" multiple="true" size="3" class="selected" <#if !((regionalAccessSuperUser?? && regionalAccessSuperUser == true) || (areaAccessSuperUser?? && areaAccessSuperUser == true) || (globalAccessSuperUser?? && globalAccessSuperUser == false))>disabled="disabled"</#if>>
                    <#if selectedCountries?has_content>
                        <#list  selectedCountries.keySet() as selectedCountryKey>
                            <option value="${selectedCountryKey}">${selectedCountries.get(selectedCountryKey)}</option>
                        </#list>
                    </#if>
                </select>
            </div>
            <script type="text/javascript">
                $j(function() {
                    $j("#add-countries, #remove-countries").click(function(event) {
                        var id = $j(event.target).attr("id");
                        var selectFrom = id == "add-countries" ? "#normal-user-countries" : "#super-user-countries";
                        var moveTo = (id == "add-countries") ? "#super-user-countries" : "#normal-user-countries";
                        var selectedItems = $j(selectFrom + " :selected").toArray();
                        $j(moveTo).append(selectedItems);
                        reArrangeSelect("country");
                    });
                });
            </script>
        </div>
    </div>
</div>
<script type="text/javascript">
function accessTypeChange(target) {

  

    if(target != null) {
        if(target.value == ${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].GlOBAL.getId()}) {/*
		
		
		
            if($j(target).is(':checked')) {
                $j("#regionalAccessType").removeAttr("checked");
                $j("#areaAccessType").removeAttr("checked");				
				$j("#endmarketAccessType").removeAttr("checked");
                $j("#countryAccessType").removeAttr("checked");
                $j("#normal-user-regions").attr("disabled","disabled");
                $j("#super-user-regions").attr("disabled","disabled");
                $j("#add-regions").attr("disabled","disabled");
                $j("#remove-regions").attr("disabled","disabled");
                $j("#normal-user-areas").attr("disabled","disabled");
                $j("#super-user-areas").attr("disabled","disabled");
                $j("#add-areas").attr("disabled","disabled");
                $j("#remove-areas").attr("disabled","disabled");
                $j("#normal-user-countries").attr("disabled","disabled");
                $j("#super-user-countries").attr("disabled","disabled");
                $j("#add-countries").attr("disabled","disabled");
                $j("#remove-countries").attr("disabled","disabled");
            } else {
                $j("#normal-user-countries").removeAttr("disabled");
                $j("#super-user-countries").removeAttr("disabled");
                $j("#add-countries").removeAttr("disabled");
                $j("#remove-countries").removeAttr("disabled");
            }
        */} 
		
		
		
		
		else if(target.value == ${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].REGION.getId()}) {
            
			
			//$j("#globalAccessType").removeAttr("checked");
            if($j(target).is(':checked')) {
			      
               // $j("#normal-user-countries").removeAttr("disabled");
                //$j("#super-user-countries").removeAttr("disabled");
                //$j("#add-countries").removeAttr("disabled");
                //$j("#remove-countries").removeAttr("disabled");
                $j("#normal-user-regions").removeAttr("disabled");
                $j("#super-user-regions").removeAttr("disabled");
                $j("#add-regions").removeAttr("disabled");
                $j("#remove-regions").removeAttr("disabled");
            } else {
                if(!$j("#areaAccessType").is(':checked')) {
                   // $j("#normal-user-countries").attr("disabled","disabled");
                   // $j("#super-user-countries").attr("disabled","disabled");
                   // $j("#add-countries").attr("disabled","disabled");
                    //$j("#remove-countries").attr("disabled","disabled");
                }
                $j("#normal-user-regions").attr("disabled","disabled");
                $j("#super-user-regions").attr("disabled","disabled");
                $j("#add-regions").attr("disabled","disabled");
                $j("#remove-regions").attr("disabled","disabled");
            }
            //updateSelectedCountryList();
        } else if(target.value == ${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].AREA.getId()}) {
            //$j("#globalAccessType").removeAttr("checked");
			
            if($j(target).is(':checked')) {
			    
                $j("#normal-user-countries").removeAttr("disabled");
                $j("#super-user-countries").removeAttr("disabled");
                $j("#add-countries").removeAttr("disabled");
                $j("#remove-countries").removeAttr("disabled");
                $j("#normal-user-areas").removeAttr("disabled");
                $j("#super-user-areas").removeAttr("disabled");
                $j("#add-areas").removeAttr("disabled");
                $j("#remove-areas").removeAttr("disabled");

            } else {
                if(!$j("#regionalAccessType").is(':checked')) {
                   // $j("#normal-user-countries").attr("disabled","disabled");
                   // $j("#super-user-countries").attr("disabled","disabled");
                    //$j("#add-countries").attr("disabled","disabled");
                    //$j("#remove-countries").attr("disabled","disabled");
                }
                $j("#normal-user-areas").attr("disabled","disabled");
                $j("#super-user-areas").attr("disabled","disabled");
                $j("#add-areas").attr("disabled","disabled");
                $j("#remove-areas").attr("disabled","disabled");
            }
           // updateSelectedCountryList();
        } else if(target.value == ${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].COUNTRY.getId()}) {
		      
			   
			   if($j(target).is(':checked')) {
			      
				 
                $j("#normal-user-countries").removeAttr("disabled");
                $j("#super-user-countries").removeAttr("disabled");
                $j("#add-countries").removeAttr("disabled");
                $j("#remove-countries").removeAttr("disabled");
               
            } else {
                if(!$j("#endmarketAccessType").is(':checked')) {
				  
                   
                }
                $j("#normal-user-countries").attr("disabled","disabled");
                $j("#super-user-countries ").attr("disabled","disabled");
                  $j("#add-countries").attr("disabled","disabled");
                  $j("#remove-countries").attr("disabled","disabled");
                
            }
			   
			 // normal-user-countries  super-user-countries  
			   
		
		
            //$j("#globalAccessType").removeAttr("checked");
        }
    }
}

function updateSelectedCountryList() {
    var selectedEndmarketsOptions = [];
    var unselectedEndmarketsOptions = [];
    var endmarketIds = [];
    if($j("#regionalAccessType").is(":checked")) {
        $j("#super-user-regions option").each(function(){
            var rId = Number($j(this).attr("value"));
            var regionEndmarkets = getRegionEndmarkets(rId);
            if(regionEndmarkets.length > 0) {
                for(var i = 0; i < regionEndmarkets.length; i++) {
                    if(endmarketIds.indexOf(regionEndmarkets[i]) < 0) {
                        endmarketIds.push(regionEndmarkets[i]);
                    }
                }
            }

        });
    }

    if($j("#areaAccessType").is(":checked")) {
        var rId = Number($j(this).attr("value"));
        $j("#super-user-areas option").each(function(){
            var aId = Number($j(this).attr("value"));
            var areaEndmarkets = getAreaEndmarkets(aId);

            if(areaEndmarkets.length > 0) {
                for(var i = 0; i < areaEndmarkets.length; i++) {
                    if(endmarketIds.indexOf(areaEndmarkets[i]) < 0) {
                        endmarketIds.push(areaEndmarkets[i]);
                    }
                }
            }
        });
    }

    <#if allCountries?has_content>
        <#list allCountries.keySet() as countryKey>
            if(endmarketIds.indexOf(${countryKey}) >= 0) {
                selectedEndmarketsOptions.push("<option value='${countryKey}'>${allCountries.get(countryKey)}</option>");
            } else {
                unselectedEndmarketsOptions.push("<option value='${countryKey}'>${allCountries.get(countryKey)}</option>");
            }
        </#list>
    </#if>

    $j("#super-user-countries").html("");
    if(selectedEndmarketsOptions.length > 0) {
        for(var i = 0; i < selectedEndmarketsOptions.length; i++) {
            $j("#super-user-countries").append(selectedEndmarketsOptions[i]);
        }
    }

    if(unselectedEndmarketsOptions.length > 0) {
        $j("#normal-user-countries").html("");
        for(var i = 0; i < unselectedEndmarketsOptions.length; i++) {
            $j("#normal-user-countries").append(unselectedEndmarketsOptions[i]);
        }
    }

    reArrangeSelect("country");

}

function getRegionEndmarkets(regionId) {
    var regionEndmarkets = [];
    <#assign regionEndmarketMap = statics['com.grail.synchro.SynchroGlobal'].getRegionEndMarketsMapping()/>
    <#if regionEndmarketMap?has_content>
        <#list regionEndmarketMap.keySet() as regionEndmarketMapKey>
            if(${regionEndmarketMapKey?c} == regionId) {
            <#assign rEmsMap = regionEndmarketMap.get(regionEndmarketMapKey)/>
            <#if rEmsMap?has_content>
                <#list rEmsMap.keySet() as rEmsMapKey>
                    regionEndmarkets.push(${rEmsMapKey});
                </#list>
            </#if>
        }
        </#list>
    </#if>
    return regionEndmarkets;
}

function getAreaEndmarkets(areaId) {
    var areaEndmarkets = [];
    <#assign areaEndmarketMap = statics['com.grail.synchro.SynchroGlobal'].getAreaEndMarketsMapping()/>
    <#if areaEndmarketMap?has_content>
        <#list areaEndmarketMap.keySet() as areaEndmarketMapKey>
            if(${areaEndmarketMapKey?c} == areaId) {
            <#assign aEmsMap = areaEndmarketMap.get(areaEndmarketMapKey)/>
            <#if aEmsMap?has_content>
                <#list aEmsMap.keySet() as aEmsMapKey>
                    areaEndmarkets.push(${aEmsMapKey});
                </#list>
            </#if>
        }
        </#list>
    </#if>
    return areaEndmarkets;
}

function reArrangeSelect(type) {
    // TODO: Need to optimize code
    if(type == "department") {
        $j("#all-departments").html($j("#all-departments option").sort(function(a, b) {
            return a.text == b.text ? 0 : a.text < b.text ? -1 : 1
        }));
        $j("#selected-departments").html($j("#selected-departments option").sort(function(a, b) {
            return a.text == b.text ? 0 : a.text < b.text ? -1 : 1
        }));
    } else if(type == "brand") {
        $j("#all-brands").html($j("#all-brands option").sort(function(a, b) {
            return a.text == b.text ? 0 : a.text < b.text ? -1 : 1
        }));
        $j("#selected-brands").html($j("#selected-brands option").sort(function(a, b) {
            return a.text == b.text ? 0 : a.text < b.text ? -1 : 1
        }));
    } else if(type == "region") {
        $j("#normal-user-regions").html($j("#normal-user-regions option").sort(function(a, b) {
            return a.text == b.text ? 0 : a.text < b.text ? -1 : 1
        }));
        $j("#super-user-regions").html($j("#super-user-regions option").sort(function(a, b) {
            return a.text == b.text ? 0 : a.text < b.text ? -1 : 1
        }));
    } else if(type == "area") {
        $j("#normal-user-areas").html($j("#normal-user-areas option").sort(function(a, b) {
            return a.text == b.text ? 0 : a.text < b.text ? -1 : 1
        }));
        $j("#super-user-areas").html($j("#super-user-areas option").sort(function(a, b) {
            return a.text == b.text ? 0 : a.text < b.text ? -1 : 1
        }));
    } else if(type == "country") {
        $j("#normal-user-countries").html($j("#normal-user-countries option").sort(function(a, b) {
            return a.text == b.text ? 0 : a.text < b.text ? -1 : 1
        }));
        $j("#super-user-countries").html($j("#super-user-countries option").sort(function(a, b) {
            return a.text == b.text ? 0 : a.text < b.text ? -1 : 1
        }));
    }

}


</script>
</td>
</tr>

<!-- Custom fields legal, edit rights, waiver etc. -->
<tr>
	<td class="jive-table-cell-label">
		<label>Legal Entity?<@s.text name="global.colon" /></label>
	</td>
	<td colspan="2">
		<@renderYesNoDD name='legalUser' value='${legalUser}'/>
	</td>
</tr>
<tr>
	<td class="jive-table-cell-label">
		<label>Does the person have edit rights?<@s.text name="global.colon" /></label>
	</td>
	<td colspan="2">
		<@renderYesNoDD name='editRightsUser' value='${editRightsUser}'/>
	</td>
</tr>
<tr>
	<td class="jive-table-cell-label">
		<label>Is the person a waiver approver?<@s.text name="global.colon" /></label>
	</td>
	<td colspan="2">
		<@renderYesNoDD name='waiverApproverUser' value='${waiverApproverUser}'/>
	</td>
</tr>
<tr>
	<td class="jive-table-cell-label">
		<label>Does the person have TPD managing rights?<@s.text name="global.colon" /></label>
	</td>
	<td >
		<@renderYesNoDD name='TPDUser' value='${TPDUser}'/>
	</td>
	<td>
		<div class="tpd-managing-blk"><label>Please select the rights</label>
		<@renderTPDEditView  name='TPDUserEditView' value='${TPDUserEditView}' />
		<span  id="tpdErrorMessage" style="display:none">Please select the rights</span>
		</div>
		
		
		
	</td>

</tr>
<tr>
	<td class="jive-table-cell-label">
		<label>Preferred Currency<@s.text name="global.colon" /></label>
	</td>
	<td colspan="2">
		<@renderCurrenciesDD name='currencyUser' value='${currencyUser}'/>
	</td>
</tr>


<tr style="display: none;">
    <td colspan="3">
        <input id="departments" type="hidden" name="departments"/>
        <input id="brands" type="hidden" name="brands"/>
        <input id="globalAccessSuperUser" type="hidden" name="globalAccessSuperUser" value="false"/>
        <input id="regionalAccessSuperUser" type="hidden" name="regionalAccessSuperUser" value="false"/>
        <input id="regionalAccessList" type="hidden" name="regionalAccessList"/>
        <input id="areaAccessSuperUser" type="hidden" name="areaAccessSuperUser" value="false"/>
        <input id="areaAccessList" type="hidden" name="areaAccessList"/>
		<input id="endmarketAccessSuperUser" type="hidden" name="endmarketAccessSuperUser" value="false"/>
        <input id="endmarketAccessList" type="hidden" name="endmarketAccessList"/>
		<input id="legalUser" type="hidden" name="legalUser"/>
		<input id="editRightsUser" type="hidden" name="editRightsUser"/>
		<input id="waiverApproverUser" type="hidden" name="waiverApproverUser"/>
		<input id="TPDUser" type="hidden" name="TPDUser"/>
		<input id="TPDUserEditView" type="hidden" name="TPDUserEditView"/>
		<input id="currencyUser" type="hidden" name="currencyUser"/>
    </td>
</tr>

<!-- Customizations ends here -->

</#if>
<!--  Synchro Filter fields - end -->

</tbody>
<tfoot>
    <tr>
        <td colspan="3">
            <input type="submit" onClick="return saveValidations()"   name="save" value="Save">
            <input type="submit" name="method:cancel" value="<@s.text name="global.cancel" />">
        </td>
    </tr>
</tfoot>
</table>
</div>
</form>

<script type="text/javascript">
    $j(document).ready(function(){
        $j("#editForm").submit(function(event){
            var self = this;
            event.preventDefault();
        <#if fromSynchro?? && fromSynchro>
            
			
			
			
	
			
			$j("#departments-error-message").hide();

			<!-- legaluser  editRightsUser  waiverApproverUser  TPDUser  currencyUser -->
			console.log("Legal User Dropdown --> " + $j("#legaluser-dd").val());
			if($j("#legalUser-dd").val()!="-1")
			{
				var value_dd = $j("#legalUser-dd").val();
				$j("#legalUser").val(value_dd);
			}
			if($j("#editRightsUser-dd").val()!="-1")
			{
				var value_dd = $j("#editRightsUser-dd").val();
				$j("#editRightsUser").val(value_dd);
			}
			if($j("#waiverApproverUser-dd").val()!="-1")
			{
				var value_dd = $j("#waiverApproverUser-dd").val();
				$j("#waiverApproverUser").val(value_dd);
			}
			if($j("#TPDUser-dd").val()!="-1")
			{
				var value_dd = $j("#TPDUser-dd").val();
				$j("#TPDUser").val(value_dd);
			}
			
			if($j("#TPDUserEditView-dd").val()!="-1")
			{
				var value_dd = $j("#TPDUserEditView-dd").val();
				$j("#TPDUserEditView").val(value_dd);
			}
			
			if($j("#currencyUser-dd").val()!="-1")
			{
				var value_dd = $j("#currencyUser-dd").val();
				$j("#currencyUser").val(value_dd);
			}
			
			var depList = [];
            $j("#selected-departments option").each(function(){
                depList.push($j(this).val());
            });
            if(depList.length > 0) {
                $j("#departments").val(depList.join(","));
            } else {
                $j("#departments").val("");
            }

            var brandList = [];
            $j("#selected-brands option").each(function(){
                brandList.push($j(this).val());
            });
            if(brandList.length > 0) {
                $j("#brands").val(brandList.join(","));
            } else {
                $j("#brands").val("");
            }

            if($j("#globalAccessType").is(":checked")) {
                $j("#globalAccessSuperUser").val("true");
               // $j("#regionalAccessSuperUser").val("false");
                //$j("#regionalAccessList").val("");
                //$j("#areaAccessSuperUser").val("false");
				//$j("#endmarketAccessSuperUser").val("false");
                //$j("#areaAccessList").val("");
                //$j("#endmarketAccessList").val("");
            } 
                //$j("#globalAccessSuperUser").val("false");
                if($j("#regionalAccessType").is(":checked")) {
                    if($j("#super-user-regions option").length > 0) {
                        var regionalAccessList = [];
                        $j("#regionalAccessSuperUser").val("true");
                        $j("#super-user-regions option").each(function(){
                            regionalAccessList.push($j(this).val());
                        });
                        if(regionalAccessList.length > 0) {
                            $j("#regionalAccessList").val(regionalAccessList.join(","));
                        } else {
                            $j("#regionalAccessList").val("");
                        }
                    } else {
                        $j("#regionalAccessSuperUser").val("false");
                        $j("#regionalAccessList").val("");
                    }
                }

                if($j("#areaAccessType").is(":checked")) {
                    if($j("#super-user-areas option").length > 0) {
                        var areaAccessList = [];
                        $j("#areaAccessSuperUser").val("true");
                        $j("#super-user-areas option").each(function(){
                            areaAccessList.push($j(this).val());
                        });
                        if(areaAccessList.length > 0) {
                            $j("#areaAccessList").val(areaAccessList.join(","));
                        } else {
                            $j("#areaAccessList").val("");
                        }
                    } else {
                        $j("#areaAccessSuperUser").val("false");
                        $j("#areaAccessList").val("");
                    }
                }

				
				
                if($j("#super-user-countries option").length > 0) {
				 
					$j("#endmarketAccessSuperUser").val("true");
                    var endmarketAccessList = [];
                    $j("#super-user-countries option").each(function(){
                        endmarketAccessList.push($j(this).val());
                    });
                    if(endmarketAccessList.length > 0) {
                        $j("#endmarketAccessList").val(endmarketAccessList.join(","));
                    } else {
                        $j("#endmarketAccessList").val("");
                    }
                } else {
				
                    $j("#endmarketAccessList").val("");
					$j("#endmarketAccessSuperUser").val("false");
                }
            


        <#--var superUserAccessList = [];-->
        <#--if(accessType == ${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].GlOBAL.getId()}) {-->
        <#--superUserAccessList = [];-->
        <#--$j("#superUserAccessList").val("");-->
        <#--if($j("#globalSuperUserCB").is(':checked')) {-->
        <#--$j("#globalAccessSuperUser").val("true");-->
        <#--} else {-->
        <#--$j("#globalAccessSuperUser").val("false");-->
        <#--}-->
        <#--} else if(accessType == ${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].REGION.getId()}) {-->
        <#--$j("#globalAccessSuperUser").val("false");-->
        <#--superUserAccessList = [];-->
        <#--$j("#super-user-regions option").each(function(){-->
        <#--superUserAccessList.push($j(this).val());-->
        <#--});-->

        <#--} else if(accessType == ${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].AREA.getId()}) {-->
        <#--$j("#globalAccessSuperUser").val("false");-->
        <#--superUserAccessList = [];-->
        <#--$j("#super-user-areas option").each(function(){-->
        <#--superUserAccessList.push($j(this).val());-->
        <#--});-->
        <#--} else if(accessType == ${statics['com.grail.synchro.SynchroGlobal$InvestmentType'].COUNTRY.getId()}) {-->
        <#--$j("#globalAccessSuperUser").val("false");-->
        <#--superUserAccessList = [];-->
        <#--$j("#super-user-countries option").each(function(){-->
        <#--superUserAccessList.push($j(this).val());-->
        <#--});-->
        <#--}-->
        <#--if(superUserAccessList.length > 0) {-->
        <#--$j("#superUserAccessList").val(superUserAccessList.join(","));-->
        <#--} else {-->
        <#--$j("#superUserAccessList").val("");-->
        <#--}-->
        <#else>
            $j("#departments").val("");
            $j("#brands").val("");
            $j("#globalAccessSuperUser").val("false");
            $j("#regionalAccessSuperUser").val("false");
            $j("#regionalAccessList").val("");
            $j("#areaAccessSuperUser").val("false");
            $j("#areaAccessList").val("");
            $j("#endmarketAccessList").val("");

        </#if>

        <#if externalAgencyUser?? && externalAgencyUser>
        if(($j("#globalAccessSuperUser").val() != '' && $j("#globalAccessSuperUser").val() != 'false')
                ||  $j("#endmarketAccessList").val() != "")
            if($j("#departments").val() == null
                    || $j("#departments").val() == undefined || $j("#departments").val() == "") {
                $j("#departments-error-message").show();
                return false;
            }
        </#if>
            self.submit();
        });
		
		//set currency
		$j("#currencyUser-dd").val("${currencyUser}");
		$j("#TPDUser-dd").change(function(){
			if($j("#TPDUser-dd").val() == 1)
			{
			//$j('#tpd-managing-blk').val('').trigger('chosen:updated');
			$j('.tpd-managing-blk').show();
			//$j('#TPDUserEditView-dd').val('Select').trigger('chosen:updated');;
			
			
			}
			else {
				$j('.tpd-managing-blk').hide();
				$j('#TPDUserEditView-dd').val(-1);
			}
		});
		
		if($j("#TPDUser-dd").val() == 1)
		{		
		    
			$j('.tpd-managing-blk').show();
			
			
		}
		else 
		{	
			$j('.tpd-managing-blk').hide();
		}
    });
	
	 $j(".tpd-managing-blk").change(function()
	  {
	      var tpd_message = $j('select[name="TPDUserEditView-dd"] option:selected').val();
		  if(tpd_message<1)
		  {
		  $j("#tpdErrorMessage").show();
		  }
		  else
		  {
		  $j("#tpdErrorMessage").hide();
		  }
		 
	   });
	   
	   
	function  saveValidations()   
	{
	  
	   var tpdpermission = $j('select[name="TPDUser-dd"] option:selected').val(); 
	  var tpd_rights = $j('select[name="TPDUserEditView-dd"] option:selected').val();
	    if(tpdpermission==1 && tpd_rights==-1)
		{
		    
			 $j("#tpdErrorMessage").show();
	      return false;
		
		}
		else
		{
		
		 $j("#tpdErrorMessage").hide();
		return true;
		}
	   
	   }
	   
	   
	
	
	
</script>

<br />

<#if (userAvatars?? && userAvatars.hasNext())>
    <br/>
    <form action="editUserProfile.jspa" name="avform" method="post">
        <@jive.token name="edit.profile.admin.avatar.${user.ID?c}" />
        <input type="hidden" name="userId" value="${targetUser.ID?c}">
        <fieldset>
            <legend>User Avatars</legend>
            <div>
                <p class="jive-description">
                Below is the set of custom avatars for this user. To delete an avatar,
                click the checkbox next to the image and then click "Delete Avatar".
                </p>
                <p class="jive-description">
                Note: If you delete an avatar that the user has installed that user will have their avatar reset.
                They will be able to choose a new avatar when they edit their settings.
                </p>

                <div class="jive-avatar-table">
                <table cellpadding="3" cellspacing="0" border="0" width="100%">
                <tbody>
                    <tr><td>

                    <#list userAvatars as avatar>

                        <table cellpadding="3" cellspacing="0" border="0" width="1%" style="display:inline;">
                        <tbody><tr>
                        <td>
                            <input type="checkbox" name="avatarIDs" value="${avatar.ID?c}" id="avatarID_${avatar.ID?c}"/>
                        </td>
                        <td class="jive-avatar-box">
                            <a href="#" class="jive-avatar-image" onclick="document.avform.avatarIDs[${avatar_index}].checked = !document.avform.avatarIDs[${avatar_index}].checked; return false;">
                                <img src="avatar-display.jspa?avatarID=${avatar.ID?c}&file=av.png" border="0" alt="Avatar Image" />
                            </a>
                        </td>
                        </tr></tbody>
                        </table>

                    </#list>

                    </td></tr>
                </tbody>
                </table>
                </div>

                <input type="hidden" name="avatarID" value="-1">

                <br />

                <input type="submit" name="method:deleteAvatars" value="Delete Avatar(s)"/>
            </div>
        </fieldset>
    </form>
</#if>

</body>
</html>
