<@resource.javascript file="/resources/scripts/apps/shared/views/date_picker_view.js" />
<#macro displayProfileFieldInput field>
    <#assign isExternal = (field.externallyManaged && targetUser.federated) />
     <#if (!isExternal && (field.editable || admin??))>
        <tr class="jive-field-hidden">
            <td class="jive-field-hidden">
                <input type="hidden" name="profile[${field.ID?c}].typeID" value="${field.typeID?c}"/>
                <input type="hidden" name="profile[${field.ID?c}].fieldID" value="${field.ID?c}"/>
            </td>
            <td colspan="2">
            </td>
        </tr>
        <#if field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].LARGETEXT.ID>

            <tr>
                <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                    <label for="profile[${field.ID?c}].value">
                        <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                    </label>
                </td>
                <td class="jive-profile-edit-field">
                    <textarea id="profile[${field.ID?c}].value" name="profile[${field.ID?c}].value" cols="30" rows="3"
                        ><#if profile?? && profile.get(field.ID)?? && profile.get(field.ID).value??>${profile.get(field.ID).value?html}</#if></textarea>
                    <@macroFieldErrors name="profile[${field.ID?c}].value"/>
                </td>
                <#assign desc><@s.text name="${field.descriptionKey}"/></#assign>
                <#if desc != field.descriptionKey>
                    <td class="jive-profile-edit-desc">
                        <span class="jive-form-instructions font-color-meta">
                            <@displayProfileFieldDescription field />
                        </span>
                    </td>
                <#else>
                    <td></td>
                </#if>
            </tr>

        <#elseif field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].BOOLEAN.ID || field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].SINGLELIST.ID>

            <tr>
                <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                    <label for="profile[${field.ID?c}].value">
                        <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                    </label>
                </td>
                <td class="jive-profile-edit-field">
                <#if (field.options?? && field.options.size() > 0)>

                    <#if (field.options.size() < 5)>
                        <#list field.options as option>
                            <input type="radio" name="profile[${field.ID?c}].value" id="profile[${field.ID?c}].value${option.value?html}"
                                   value="${option.value?html}" fieldvalue="true"
                                <#if profile.get(field.ID)?? && profile.get(field.ID).value?? && profile.get(field.ID).value == option.value>
                                   checked="checked"
                                </#if>
                                    >
                            <label for="profile[${field.ID?c}].value${option.value?html}">${option.value?html}</label>
                        </#list>
                    <#else>
                        <@s.select theme="simple" id="profile[${field.ID?c}].value"
                            name="profile[${field.ID?c}].value" size="5" headerKey="" headerValue="${action.getText('profile.select.listitem')}"
                                emptyOption="true" list=field.options listKey="value" listValue="value" size="1"/>
                    </#if>

                <#else>

                    <@s.label theme="simple" name="profile[${field.ID?c}].value" value="${action.getText('profile.optionsNotConfigrd.text')}"/>

                </#if>
                    <@macroFieldErrors name="profile[${field.ID?c}].value"/>
                </td>

                <#assign desc><@s.text name="${field.descriptionKey}"/></#assign>
                <#if desc != field.descriptionKey>
                    <td class="jive-profile-edit-desc">
                        <span class="jive-form-instructions font-color-meta">
                            <@displayProfileFieldDescription field />
                        </span>
                    </td>
                <#else>
                    <td></td>
                </#if>
            </tr>

        <#elseif field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].MULTILIST.ID>

            <tr>
                <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                    <label for="profile[${field.ID?c}].values">
                        <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                    </label>
                </td>
                <td class="jive-profile-edit-field">
                <#if (field.options?? && field.options.size() > 0)>
                    <#if (field.options.size() < 5)>
                        <@s.checkboxlist theme="simple" id="profile[${field.ID?c}].values"
                            name="profile[${field.ID?c}].values" list=field.options listKey="value" listValue="value" fieldValue="true"/>
                    <#else>
                        <@s.select theme="simple" id="profile[${field.ID?c}].values"
                            name="profile[${field.ID?c}].values" size="5" headerKey="" headerValue="${action.getText('profile.select.listitem')}"
                                emptyOption="true" list=field.options listKey="value" listValue="value" multiple="true"/>
                    </#if>
                <#else>
                    <@s.label theme="simple" id="profile[${field.ID?c}].values"
                        name="profile[${field.ID?c}].values" value="${action.getText('profile.optionsNotConfigrd.text')}"/>
                </#if>
                    <@macroFieldErrors name="profile[${field.ID?c}].values"/>
                </td>
                <#assign desc><@s.text name="${field.descriptionKey}"/></#assign>
                <#if desc != field.descriptionKey>
                    <td class="jive-profile-edit-desc">
                        <span class="jive-form-instructions font-color-meta">
                            <@displayProfileFieldDescription field />
                        </span>
                    </td>
                <#else>
                    <td></td>
                </#if>
            </tr>

        <#elseif field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].DATE.ID>
            <#assign mask = calendarOverrideFormat />
            <#if field.listValues>
                <#if profile.get(field.ID)?? && profile.get(field.ID).values??>

                    <#list profile.get(field.ID).values as listVal>
                        <tr>
                            <#-- only show field label on first field in list -->
                            <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                                <#if listVal_index==0>
                                    <label for="date-${field.ID?c}-${listVal_index}">
                                        <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                                    </label>
                                <#else>
                                    &nbsp;
                                </#if>
                            </td>
                            <td colspan="2">
                                <@s.datetimepicker theme="simple" id="date-${field.ID?c}-${listVal_index}"
                                    name="profile[${field.ID?c}].values[${listVal_index}]" format=mask />
                                <@macroFieldErrors name="profile[${field.ID?c}].values[${listVal_index}]"/>
                            </td>
                        </tr>

                    </#list>

                <#else>

                    <#-- provide initial empty list for input -->
                    <tr>
                        <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                            <label for="profile[${field.ID?c}].values[0]">
                                <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                            </label>
                        </td>
                        <td colspan="2">
                            <@s.datetimepicker theme="simple" id="profile[${field.ID?c}].values[0]"
                                name="profile[${field.ID?c}].values[0]" format=mask />
                            <@macroFieldErrors name="profile[${field.ID?c}].values[0]"/>
                        </td>
                    </tr>
                </#if>

            <#else>
                <#if profile.get(field.ID)?? && profile.get(field.ID).value??>
                    <#assign profileDate = profile.get(field.ID).value?html>
                <#else>
                    <#assign profileDate = "">
                </#if>
                <script type="text/javascript">
                    $j(document).ready(function() {
                        var datePicker = new jive.shared.DatePicker.View({"locale": window._jive_locale || _jive_datepicker_locale});
                        datePicker.addDatePicker("#" + "date-${field.ID?c}");
                        if("${profileDate?js_string}") {
                            datePicker.setDate("#" + "date-${field.ID?c}", "${profileDate?js_string}");
                        }
                    });
                </script>
                <tr>
                    <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                        <label for="date-${field.ID?c}">
                            <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                        </label>
                    </td>
                    <td>
                        <input type="text" id="date-${field.ID?c}" name="profile[${field.ID?c}].value" <#if field.required>required</#if> format=mask >
                        <@macroFieldErrors name="profile[${field.ID?c}].value"/>
                    </td>
                    <#assign desc><@s.text name="${field.descriptionKey}"/></#assign>
                    <#if desc != field.descriptionKey>
                        <td class="jive-profile-edit-desc">
                        <span class="jive-form-instructions font-color-meta">
                            <@displayProfileFieldDescription field />
                        </span>
                        </td>
                    <#else>
                        <td></td>
                    </#if>
                </tr>
            </#if>

        <#elseif field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].URL.ID>

            <#if field.listValues>
                <#if profile.get(field.ID)?? && profile.get(field.ID).values??>

                    <#list profile.get(field.ID).values as listVal>
                        <tr>
                            <#-- only show field label on first field in list -->
                            <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                                <#if listVal_index==0>
                                    <label for="profile[${field.ID?c}].values[${listVal_index}]">
                                        <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                                    </label>
                                <#else>
                                    &nbsp;
                                </#if>
                            </td>
                            <td colspan="2">
                                <input type="text" id="profile[${field.ID?c}].values[${listVal_index}]" name="profile[${field.ID?c}].values[${listVal_index}]"
                                    value="${profile.get(field.ID).values[listVal_index]?html}" size="40"
                                    onblur="jiveCheckValidURL(this);"/>
                                <@macroFieldErrors name="profile[${field.ID?c}].values[${listVal_index}]"/>
                            </td>
                        </tr>
                    </#list>

                <#else>

                    <#-- provide initial empty list for input -->
                    <tr>
                        <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                            <label for="profile[${field.ID?c}].values[0]">
                                <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                            </label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="profile[${field.ID?c}].values[0]" name="profile[${field.ID?c}].values[0]"
                                onblur="jiveCheckValidURL(this);" />
                            <@macroFieldErrors name="profile[${field.ID?c}].values[0]"/>
                        </td>
                    </tr>
                </#if>

            <#else>

                <tr>
                    <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                        <label for="profile[${field.ID?c}].value">
                            <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                        </label>
                    </td>
                    <td class="jive-profile-edit-field">
                        <input type="text" id="profile[${field.ID?c}].value" size="40" name="profile[${field.ID?c}].value"
                            <#if profile?? && profile.get(field.ID)??> value="${profile.get(field.ID).value?html}"</#if>
                            onblur="jiveCheckValidURL(this);" />
                        <@macroFieldErrors name="profile[${field.ID?c}].value"/>
                    </td>
                    <#assign desc><@s.text name="${field.descriptionKey}"/></#assign>
                    <#if desc != field.descriptionKey>
                        <td class="jive-profile-edit-desc">
                            <span class="jive-form-instructions font-color-meta">
                                <@displayProfileFieldDescription field />
                            </span>
                        </td>
                    <#else>
                        <td></td>
                    </#if>
                </tr>

            </#if>

        <#elseif field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].PHONE_NUMBER.ID>

            <#if field.listValues>
                <#if profile.get(field.ID)?? && profile.get(field.ID).objectValues??>

                    <#list profile.get(field.ID).objectValues as listVal>
                        <tr>
                            <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                                <#-- only show field label on first field in list -->
                                <#if listVal_index == 0>
                                    <label for="profile[${field.ID?c}].phoneNumbers[${listVal_index}].phoneNumber">
                                        <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                                    </label>
                                <#else>
                                   &nbsp;
                                </#if>
                            </td>
                            <td colspan="2">
                                <input type="text" id="profile[${field.ID?c}].phoneNumbers[${listVal_index}].phoneNumber"
                                       size="40" name="profile[${field.ID?c}].phoneNumbers[${listVal_index}].phoneNumber"
                                    <#if profile?? && profile.get(field.ID)??> value="${profile.get(field.ID).phoneNumbers[listVal_index].phoneNumber?html}"</#if> />
                                <@macroFieldErrors name="profile[${field.ID?c}].phoneNumbers[${listVal_index}].phoneNumber"/>
                            </td>
                        </tr>
                        <#if field.defaultField>
                         <tr class="jive-field-hidden">
                            <td colspan="3" class="jive-field-hidden">
                                <input type="hidden" name="profile[${field.ID?c}].phoneNumbers[${listVal_index}].typeString" value="${action.getTypeForDefaultPhoneField(field)}"/>
                            </td>
                        </tr>
                        <#else>
                        <tr>
                            <td class="jive-profile-edit-label"><@s.text name="tag.form.type.label"/></td>
                            <td colspan="2">
                                <@s.select theme="simple" name="profile[${field.ID?c}].phoneNumbers[${listVal_index}].typeString" emptyOption="true"
                                       list="phoneNumberTypes" listKey="name" listValue="displayName"/>
                            </td>
                        </tr>
                        <tr><td colspan="3">&nbsp;</td></tr>
                        </#if>
                    </#list>

                <#else>

                    <#-- provide initial empty list for input -->
                    <tr>
                        <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                            <label for="profile[${field.ID?c}].phoneNumbers[0].phoneNumber">
                                <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                            </label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="profile[${field.ID?c}].phoneNumbers[0].phoneNumber"
                                   size="40" name="profile[${field.ID?c}].phoneNumbers[0].phoneNumber"/>
                            <@macroFieldErrors name="profile[${field.ID?c}].phoneNumbers[0].phoneNumber"/>
                        </td>
                    </tr>
                    <#if field.defaultField>
                    <tr class="jive-field-hidden">
                        <td colspan="3" class="jive-field-hidden">
                            <input type="hidden" name="profile[${field.ID?c}].phoneNumbers[0].typeString" value="${action.getTypeForDefaultPhoneField(field)}"/>
                        </td>
                    </tr>
                    <#else>
                    <tr>
                        <td class="jive-profile-edit-label"><@s.text name="tag.form.type.label"/></td>
                        <td colspan="2">
                            <@s.select theme="simple" name="profile[${field.ID?c}].phoneNumbers[0].typeString" emptyOption="true"
                                   list="phoneNumberTypes" listKey="name" listValue="displayName" />
                        </td>
                    </tr>
                    <tr><td colspan="3">&nbsp;</td></tr>
                    </#if>

                </#if>

            <#else>

                <tr>
                    <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                        <label for="profile[${field.ID?c}].phoneNumbers[0].phoneNumber">
                            <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                        </label>
                    </td>
                    <td class="jive-profile-edit-field">
                        <input type="text" id="profile[${field.ID?c}].phoneNumbers[0].phoneNumber"
                               size="40" name="profile[${field.ID?c}].phoneNumbers[0].phoneNumber"
                            <#if profile?? && profile.get(field.ID)?? && profile.get(field.ID).phoneNumbers[0]??> value="${profile.get(field.ID).phoneNumbers[0].phoneNumber?html}"</#if> />
                        <@macroFieldErrors name="profile[${field.ID?c}].phoneNumbers[0].phoneNumber"/>
                    </td>
                    <#assign desc><@s.text name="${field.descriptionKey}"/></#assign>
                    <#if desc != field.descriptionKey>
                        <td class="jive-profile-edit-desc">
                            <span class="jive-form-instructions font-color-meta">
                                <@displayProfileFieldDescription field />
                            </span>
                        </td>
                    <#else>
                        <td></td>
                    </#if>
                </tr>
                <#if field.defaultField>
                <tr class="jive-field-hidden">
                        <td colspan="3" class="jive-field-hidden">
                            <input type="hidden" name="profile[${field.ID?c}].phoneNumbers[0].typeString" value="${action.getTypeForDefaultPhoneField(field)}"/>
                        </td>
                    </tr>
                <#else>
                <tr>
                    <td class="jive-profile-edit-label"><@s.text name="tag.form.type.label"/></td>
                    <td colspan="2">
                        <@s.select theme="simple" name="profile[${field.ID?c}].phoneNumbers[0].typeString" emptyOption="true"
                               list="phoneNumberTypes" listKey="name" listValue="displayName" />
                    </td>
                </tr>
                <tr><td colspan="3">&nbsp;</td></tr>
                </#if>

            </#if>

        <#elseif field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].EMAIL.ID>

            <#if field.listValues>

                <#if profile.get(field.ID)?? && profile.get(field.ID).objectValues??>

                    <#list profile.get(field.ID).objectValues as listVal>
                        <tr>
                            <#-- only show field label on first field in list -->

                            <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                                <#if listVal_index==0>
                                    <label for="profile[${field.ID?c}].emails[${listVal_index}'].email">
                                        <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                                    </label>
                                <#else>
                                    &nbsp;
                                </#if>
                            </td>
                            <td colspan="2">
                                <input type="text" id="profile[${field.ID?c}].emails[${listVal_index}'].email"
                                       size="40" name="profile[${field.ID?c}].emails[${listVal_index}].email"
                                    <value="${profile.get(field.ID).emails[listVal_index].email?html}" />
                                <@macroFieldErrors name="profile[${field.ID?c}].emails[${listVal_index}].email"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="jive-profile-edit-label">
                                <label class="jive-profile-edit-secondary" for="profile[${field.ID?c}].emails[${listVal_index}'].typeString">
                                <@s.text name="tag.form.type.label"/>
                            </td>
                            <td colspan="2">
                                <@s.select theme="simple" name="profile[${field.ID?c}].emails[${listVal_index}'].typeString" emptyOption="true"
                                               list="emailTypes" listKey="name" listValue="displayName"/>
                            </td>
                        </tr>
                        <tr><td colspan="3">&nbsp;</td></tr>
                    </#list>

                <#else>

                    <#-- provide initial empty list for input -->
                    <tr>
                        <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                            <label for="profile[${field.ID?c}].emails[0].email">
                                <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                            </label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="profile[${field.ID?c}].emails[0].email" size="40"
                                   name="profile[${field.ID?c}].emails[0].email"/>
                            <@macroFieldErrors name="profile[${field.ID?c}].emails[0].email"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="jive-profile-edit-label">
                         <label class="jive-profile-edit-secondary" for="profile[${field.ID?c}].emails[0].typeString"><@s.text name="tag.form.type.label"/></label>
                        </td>
                        <td colspan="2">
                            <@s.select theme="simple" name="profile[${field.ID?c}].emails[0].typeString" emptyOption="true"
                                list="emailTypes" listKey="name" listValue="displaName" />
                        </td>
                    </tr>
                    <tr><td colspan="3">&nbsp;</td></tr>

                </#if>

            <#else>

                <tr>
                    <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                        <label for="profile[${field.ID?c}].emails[0].email">
                            <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                        </label>
                    </td>
                    <td  class="jive-profile-edit-field">
                        <input type="text" id="profile[${field.ID?c}].emails[0].email" name="profile[${field.ID?c}].emails[0].email" size="40"
                            <#if profile?? && profile.get(field.ID)?? && profile.get(field.ID).emails[0]??> value="${profile.get(field.ID).emails[0].email?html}"</#if> />
                        <@macroFieldErrors name="profile[${field.ID?c}].emails[0].email"/>
                    </td>
                    <#assign desc><@s.text name="${field.descriptionKey}"/></#assign>
                    <#if desc != field.descriptionKey>
                        <td class="jive-profile-edit-desc">
                            <span class="jive-form-instructions font-color-meta">
                                <@displayProfileFieldDescription field />
                            </span>
                        </td>
                    <#else>
                        <td></td>
                    </#if>
                </tr>
                <tr>
                    <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                     <label class="jive-profile-edit-secondary" for="profile[${field.ID?c}].emails[0].typeString">
                        <@s.text name="tag.form.type.label"/><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                     </label>
                    </td>
                    <td colspan="2">
                        <#if profile?? && profile.get(field.ID)?? && profile.get(field.ID).emails[0]??>
                            <@s.select theme="simple" name="profile[${field.ID?c}].emails[0].typeString" emptyOption="true"
                        list="emailTypes" listKey="name" listValue="displayName" />
                        <#else>
                            <@s.select theme="simple" name="profile[${field.ID?c}].emails[0].typeString" emptyOption="false" value="0" headerKey="0" headerValue=" "
                            list="emailTypes" listKey="name" listValue="displayName" />
                        </#if>
                    </td>
                </tr>
                <tr><td colspan="3">&nbsp;</td></tr>

            </#if>

        <#elseif field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].ADDRESS.ID>

            <tr>
                <td colspan="3">&nbsp;</td>
            </tr>
            <tr>
                <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                    <label>
                        <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                    </label>
                </td>
                <td colspan="2"><@macroFieldErrors name="profile[${field.ID?c}].addresses[0]"/></td>
            </tr>
            <tr>
                <td class="jive-profile-edit-label">
                    <label class="jive-profile-edit-secondary" for="profile[${field.ID?c}].addresses[0].street1">${action.getText('profile.address.street1')}<@s.text name="global.colon"/></label>
                </td>
                <td>
                    <input type="text" id="profile[${field.ID?c}].addresses[0].street1" name="profile[${field.ID?c}].addresses[0].street1" size="40"
                        <#if profile?? && profile.get(field.ID)?? && profile.get(field.ID).addresses[0]?? && profile.get(field.ID).addresses[0].street1??> value="${profile.get(field.ID).addresses[0].street1?html}"</#if> />
                </td>
                <#assign desc><@s.text name="${field.descriptionKey}"/></#assign>
                <#if desc != field.descriptionKey>
                    <td class="jive-profile-edit-desc">
                        <span class="jive-form-instructions font-color-meta">
                            <@displayProfileFieldDescription field />
                        </span>
                    </td>
                <#else>
                    <td></td>
                </#if>
            </tr>
            <tr>
                <td class="jive-profile-edit-label">
                    <label class="jive-profile-edit-secondary" for="profile[${field.ID?c}].addresses[0].street2">${action.getText('profile.address.street2')}<@s.text name="global.colon"/></label>
                </td>
                <td class="jive-profile-edit-input" colspan="2">
                    <input type="text" id="profile[${field.ID?c}].addresses[0].street2" name="profile[${field.ID?c}].addresses[0].street2" size="40"
                        <#if profile?? && profile.get(field.ID)?? && profile.get(field.ID).addresses[0]?? && profile.get(field.ID).addresses[0].street2??> value="${profile.get(field.ID).addresses[0].street2?html}"</#if> />
                </td>
            </tr>
            <tr>
                <td class="jive-profile-edit-label">
                    <label class="jive-profile-edit-secondary" for="profile[${field.ID?c}].addresses[0].city">${action.getText('profile.address.city')}<@s.text name="global.colon"/></label>
                </td>
                <td colspan="2">
                    <input type="text" id="profile[${field.ID?c}].addresses[0].city" name="profile[${field.ID?c}].addresses[0].city" size="40"
                        <#if profile?? && profile.get(field.ID)?? && profile.get(field.ID).addresses[0]?? && profile.get(field.ID).addresses[0].city??> value="${profile.get(field.ID).addresses[0].city?html}"</#if> />
                </td>
           </tr>
           <tr>
                <td class="jive-profile-edit-label">
                    <label class="jive-profile-edit-secondary" for="profile[${field.ID?c}].addresses[0].stateOrProvince">${action.getText('profile.address.state')}<@s.text name="global.colon"/></label>
                </td>
                <td class="jive-profile-edit-input" colspan="2">
                    <input type="text" id="profile[${field.ID?c}].addresses[0].stateOrProvince" size="40" name="profile[${field.ID?c}].addresses[0].stateOrProvince"
                        <#if profile?? && profile.get(field.ID)?? && profile.get(field.ID).addresses[0]?? && profile.get(field.ID).addresses[0].stateOrProvince??> value="${profile.get(field.ID).addresses[0].stateOrProvince?html}"</#if> />
                </td>
            </tr>
            <tr>
                <td class="jive-profile-edit-label">
                    <label class="jive-profile-edit-secondary" for="profile[${field.ID?c}].addresses[0].postalCode">${action.getText('profile.address.zip')}<@s.text name="global.colon"/></label>
                </td>
                 <td class="jive-profile-edit-input" colspan="2">
                     <input type="text" id="profile[${field.ID?c}].addresses[0].postalCode" size="40" name="profile[${field.ID?c}].addresses[0].postalCode"
                        <#if profile?? && profile.get(field.ID)?? && profile.get(field.ID).addresses[0]?? && profile.get(field.ID).addresses[0].postalCode??> value="${profile.get(field.ID).addresses[0].postalCode?html}"</#if> />
                 </td>
            </tr>
            <tr>
                <td class="jive-profile-edit-label">
                    <label class="jive-profile-edit-secondary" for="profile[${field.ID?c}].addresses[0].country">${action.getText('profile.address.country')}<@s.text name="global.colon"/></label>
                 </td>
                 <td class="jive-profile-edit-input" colspan="2">
                     <input type="text" id="profile[${field.ID?c}].addresses[0].country" name="profile[${field.ID?c}].addresses[0].country" size="40"
                        <#if profile?? && profile.get(field.ID)?? && profile.get(field.ID).addresses[0]?? && profile.get(field.ID).addresses[0].country??> value="${profile.get(field.ID).addresses[0].country?html}"</#if> />
                 </td>
            </tr>

            <#if (!field.defaultField)>

            <tr>
                <td class="jive-profile-edit-label">
                    <label class="jive-profile-edit-secondary" for="profile[${field.ID?c}].addresses[0].typeString">${action.getText('profile.address.type')}<@s.text name="global.colon"/></label>
                </td>
                <td colspan="2">
                    <@s.select theme="simple" id="profile[${field.ID?c}].addresses[0].typeString" name="profile[${field.ID?c}].addresses[0].typeString" emptyOption="true"
                       list="addressTypes" listKey="name" listValue="displayName" />
                </td>
            </tr>
            <tr><td colspan="3">&nbsp;</td></tr>

            <#elseif (field.name.equals("Address"))>

            <tr class="jive-field-hidden">
                <td colspan="3" class="jive-field-hidden">
                    <@s.hidden theme="simple" name="profile[${field.ID?c}].addresses[0].typeString" value="work"/>
                </td>
            </tr>
            <#elseif (field.name.equals("Home Address"))>

            <tr class="jive-field-hidden">
                <td colspan="3" class="jive-field-hidden">
                    <@s.hidden theme="simple" name="profile[${field.ID?c}].addresses[0].typeString" value="home"/>
                </td>
            </tr>

            </#if>
            <tr>
                <td colspan="3">&nbsp;</td>
            </tr>

        <#else> <#-- ALL OTHER TYPES (TEXT) -->

            <#if field.listValues>
                <#if profile.get(field.ID)?? && profile.get(field.ID).values??>

                    <#list profile.get(field.ID).values as listVal>
                        <tr>
                            <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                                 <#-- only show field label on first field in list -->
                                <#if listVal_index==0>
                                    <label for="profile[${field.ID?c}].values[${listVal_index}]">
                                        <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                                    </label>
                                <#else>
                                    &nbsp;
                                </#if>
                            </td>
                            <td colspan="2">
                                <input type="text" id="profile[${field.ID?c}].values[${listVal_index}]"
                                       size="40" name="profile[${field.ID?c}].values[${listVal_index}]"
                                       value="${profile.get(field.ID).values[listVal_index]}"/>
                                <@macroFieldErrors name="profile[${field.ID?c}].values[${listVal_index}]"/>
                            </td>
                        </tr>
                    </#list>

                <#else>

                    <#-- provide initial empty list for input -->
                    <tr>
                        <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                            <label for="profile[${field.ID?c}].values[0]">
                                <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                            </label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="profile[${field.ID?c}].values[0]"  size="40" name="profile[${field.ID?c}].values[0]"/>
                            <@macroFieldErrors name="profile[${field.ID?c}].values[0]"/>
                        </td>
                    </tr>
                </#if>

            <#else>

                <tr>
                    <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                        <label for="profile[${field.ID?c}].value">
                            <@displayProfileFieldName field /><#if field.required> <@displayRequiredText /></#if><@s.text name="global.colon"/>
                        </label>
                    </td>
                    <#--<td class="jive-profile-edit-field">
                        <input type="text" id="profile[${field.ID?c}].value" name="profile[${field.ID?c}].value" size="40"
                            <#if profile?? && profile.get(field.ID)?? && profile.get(field.ID).value??> value="${profile.get(field.ID).value?html}"</#if> />
                        <@macroFieldErrors name="profile[${field.ID?c}].value"/>
                    </td>
					-->
					 <td class="jive-profile-edit-field">
                        <#if fromSynchro?? && fromSynchro && field.ID == 2>
                        <select size="1" id="synchro-department-field" class="synchro-drop-down" name="profile[${field.ID?c}].value">
                            <option value="-1" disabled="disabled" selected="true">Select Department</option>
                            <#if allDepartments?has_content>
                                <#list allDepartments.keySet() as departmentKey>
                                    <option value="${departmentKey}" <#if profile?? && profile.get(field.ID)?? && profile.get(field.ID).value?? && profile.get(field.ID).value?matches("^\\d+$") && profile.get(field.ID).value?number == departmentKey>selected="true"</#if>>${allDepartments.get(departmentKey)}</option>
                                </#list>
                            </#if>
                        </select>
                    <#else>
                         <input type="text" id="profile[${field.ID?c}].value" name="profile[${field.ID?c}].value" size="40"
                            <#if profile?? && profile.get(field.ID)?? && profile.get(field.ID).value??> value="${profile.get(field.ID).value?html}"</#if> />
                        <@macroFieldErrors name="profile[${field.ID?c}].value"/>
                    </#if>
                </td>
				
                    <#assign desc><@s.text name="${field.descriptionKey}"/></#assign>
                    <#if desc != field.descriptionKey>
                        <td class="jive-profile-edit-desc">
                            <span class="jive-form-instructions font-color-meta">
                                <@displayProfileFieldDescription field />
                            </span>
                        </td>
                    <#else>
                        <td></td>
                    </#if>
                </tr>

            </#if>

        </#if>

    <#elseif (field.externallyManaged)>
        <tr>
            <td class="jive-profile-edit-label<#if field.required> jive-label-required</#if>">
                <label><@displayProfileFieldName field /><@s.text name="global.colon"/></label>
            </td>
            <td colspan="2">
                <#if (profile?? && profile.get(field.ID?long)??)>
                    <@displayProfileFieldValue field=field fieldValue=profile.get(field.ID?long)/>
                <#else>
                    <@s.text name="profile.empty.text"/>
                </#if>
            </td>
        </tr>
    </#if>
    <@resource.javascript>
        function jiveCheckValidURL(e) {
            // trim string
            var value = e.value.replace(/^\s*|\s*$/g, "");
            if (value != '') {
                // if a valid prefix is not specified, prepend http://
                if (value.indexOf("://") == -1) {
                    e.value = 'http://' + value;
                }
            }
        }
    </@resource.javascript>

</#macro>

<#macro displayRequiredText><span <#if action.getAuthenticationProvider().isSystemAdmin()> title="<@s.text name="profile.edit.requiredForNonAdmin.field" />"<#else>class="required"</#if>><@s.text name='global.required.parens'/></span></#macro>

<#macro displayProfileFields fields viewingSelf=false>
    <#assign phoneNumberNotDisplayed = true>
    <#list fields as field>
    <tr class="j-profile-extended-data">
        <#if field.name == "Address">
            <@displayWorkEmailAndWebsite viewingSelf=viewingSelf/>
            <@displayWorkPhoneNumber fields viewingSelf=viewingSelf/>
            <#assign phoneNumberNotDisplayed = false>
        </#if>
        <#if field.name != "Phone Number">
            <@displayProfileField field=field viewingSelf=viewingSelf/>
        </#if>
        <#if field.name == "Address">
            <@displayOtherDetails viewingSelf=viewingSelf/>
            <@displayMemberSinceAndLastLoggedIn viewingSelf=viewingSelf/>
        </#if>
    </tr>
    </#list>

    <#if phoneNumberNotDisplayed>
        <tr>
            <@displayWorkEmailAndWebsite viewingSelf=viewingSelf/>
            <@displayWorkPhoneNumber fields viewingSelf=viewingSelf/>
            <@displayOtherDetails viewingSelf=viewingSelf/>
            <@displayMemberSinceAndLastLoggedIn viewingSelf=viewingSelf/>
        </tr>
    </#if>
</#macro>

<#macro displayProfileField field viewingSelf=false>
    <#if field.visibleToUsers || viewingSelf >
        <#if profile.get(field.ID?long)??>
            <#assign pfv=profile.get(field.ID?long)>
            <#if pfv.hasValue()>
            <td><@displayProfileFieldName field=field/><@s.text name="global.colon"/></td>
            <td><@displayProfileFieldValue field=field fieldValue=pfv showBrowseLink=field.filterable/></td>
            </#if>
        </#if>
    </#if>
</#macro>

<#macro displayOtherDetails viewingSelf=false>
<tr>
    <td class="j-profile-section" colspan="2">
        <h3 class="font-color-meta"><@s.text name="profile.otherdetails"/></h3>
    </td>
</tr>
</#macro>

<#macro displayMemberSinceAndLastLoggedIn viewingSelf=false>
    <#if (targetUser.creationDate??)>
    <tr class="j-profile-extended-data">
        <td><@s.text name="settings.member_since.label" /></td>
        <td>${targetUser.creationDate?date}</td>
    </tr>
    </#if>
    <#if SkinUtils.getLastLoggedIn(targetUser)??>
    <tr class="j-profile-extended-data">
        <td><@s.text name="settings.last_logged_in.label" /></td>
        <td>${SkinUtils.getLastLoggedIn(targetUser)?datetime?string.medium_short}</td>
    </tr>
    </#if>
</#macro>

<#macro displayWorkEmailAndWebsite viewingSelf=false>
    <#if profileObject.primaryEmailAddress?? && profileObject.primaryEmailAddress.hasValue()>
    <tr>
        <td><@s.text name='profile.email'/></td>
        <td><span class="theEmail"><a href="mailto:${profileObject.primaryEmailAddress.email?default('')?html}" class="email">${profileObject.primaryEmailAddress.email?default('')?html}</a></span></td>
    </tr>
    </#if>
    <#if profileObject.primaryURL?has_content>
    <tr>
        <td><@s.text name='profile.web.site'/></td>
        <td><a href="${profileObject.primaryURL}" class="url"<#if viewingSelf> rel="me"</#if>>${profileObject.primaryURL?html}</a></td>
    </tr>
    </#if>
</#macro>

<#macro displayWorkPhoneNumber fields viewingSelf=false>
    <#list fields as field>
        <#if field.name == "Phone Number">
        <tr class="j-profile-extended-data">
            <@displayProfileField field=field viewingSelf=viewingSelf/>
        </tr>
        </#if>
    </#list>
</#macro>

<#macro displayProfileFieldName field>
<#compress>
    <#assign text><@s.text name="${field.displayNameKey}"/></#assign>
    <#if text == field.displayNameKey>
        <#assign text>${field.name}</#assign>
    </#if>
  	${text?html}
</#compress>
</#macro>

<#macro displayProfileFieldDescription field>
  	<#assign text><@s.text name="${field.descriptionKey}"/></#assign>
  	${text?html}
</#macro>

<#macro displayProfileFieldValue field fieldValue showBrowseLink=false>
    <#if (fieldValue?? && fieldValue.hasValue())>
        <#if field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].URL.ID>
            <#if field.listValues>
                <#list fieldValue.objectValues as urlVal>
                   <#-- primary url field already shown in business card view -->
                    <#if (field.name != 'URL' || urlVal != profileObject.primaryURL)>
                        <a href="${urlVal?html}">${urlVal?html}</a><#if urlVal_has_next>,</#if>
                    </#if>
                </#list>
            <#elseif (fieldValue.objectValue??)>
                <a href="${fieldValue.objectValue?html}">${fieldValue.objectValue?html}</a>
            </#if>
        <#elseif (field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].PHONE_NUMBER.ID)>
            <#if field.listValues>
                <#list fieldValue.objectValues as phoneVal>
                    ${phoneVal.phoneNumber!?html}<#if phoneVal_has_next>,</#if>
                </#list>
            <#elseif (fieldValue.objectValue??)>
                ${fieldValue.objectValue.phoneNumber!?html}
            </#if>
        <#elseif (field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].EMAIL.ID)>
            <#if field.listValues>
                <#list fieldValue.objectValues as emailVal>
                    <a href="mailto:${emailVal.email!?html}">${emailVal.email!?html}<#if emailVal_has_next></a>,</#if>
                </#list>
            <#elseif (fieldValue.objectValue??)>
                <a href="mailto:${fieldValue.objectValue.email!?html}">${fieldValue.objectValue.email!?html}</a>
            </#if>
        <#elseif (field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].ADDRESS.ID)>
            <#if field.listValues>
                <#list fieldValue.objectValues as addrVal>
                    <#if (addrVal.street1?has_content)>${addrVal.street1!?html}<br/></#if>
                    <#if (addrVal.street2?has_content)>${addrVal.street2!?html}<br/></#if>
                    <#if (addrVal.city?has_content)>${addrVal.city!?html},</#if>
                    <#if (addrVal.stateOrProvince?has_content)>${addrVal.stateOrProvince!?html}</#if>
                    <#if (addrVal.postalCode?has_content)>${addrVal.postalCode!?html}<br/></#if>
                    <#if (addrVal.country?has_content)>${addrVal.country!?html}<br/></#if>
                    <#if addrVal_has_next>,</#if>
                </#list>
            <#elseif (fieldValue.objectValue??)>
                    <#if (fieldValue.objectValue.street1?has_content)>${fieldValue.objectValue.street1!?html}<br/></#if>
                    <#if (fieldValue.objectValue.street2?has_content)>${fieldValue.objectValue.street2!?html}<br/></#if>
                    <#if (fieldValue.objectValue.city?has_content)>${fieldValue.objectValue.city!?html}, </#if>
                    <#if (fieldValue.objectValue.stateOrProvince?has_content)>${fieldValue.objectValue.stateOrProvince!?html}</#if>
                    <#if (fieldValue.objectValue.postalCode?has_content)>${fieldValue.objectValue.postalCode!?html}<br/></#if>
                    <#if (fieldValue.objectValue.country?has_content)>${fieldValue.objectValue.country!?html}</#if>
            </#if>
        <#elseif (field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].DATE.ID && fieldValue.value??)>
            <#assign blValue = field.getBrowseLink(fieldValue)/>
            <#if showBrowseLink && blValue?has_content><a href="<@s.url value=blValue/>"></#if>${DateUtils.convertDefaultToLocal(fieldValue.value, locale)!?html}<#if showBrowseLink && blValue?has_content></a></#if>
        <#elseif (field.typeID == statics["com.jivesoftware.community.user.profile.ProfileField$Type"].LARGETEXT.ID && fieldValue.value??)>
            ${fieldValue.value?html?replace("\r", "<br />")}
        <#else>
           <#if fieldValue.value??>
                <#assign blValue = field.getBrowseLink(fieldValue)/>
                <#if showBrowseLink && blValue?has_content><a href="<@s.url value=blValue/>"></#if>${fieldValue.value?html}<#if showBrowseLink && blValue?has_content></a></#if>
           <#elseif fieldValue.values?has_content>
                <#list fieldValue.values as multiSelVal><#if multiSelVal?has_content>
                    <#assign blValue = field.getBrowseLink(fieldValue, multiSelVal_index)/>
                <#if showBrowseLink && blValue?has_content><a href="<@s.url value=blValue/>"></#if>${multiSelVal!?html}<#if showBrowseLink && blValue?has_content></a></#if><#if (multiSelVal_has_next)>, </#if>
                </#if></#list>
            <#else>
                <@s.text name="profile.na.text" />
            </#if>
        </#if>
    </#if>
</#macro>

<#macro userProfile postfix=''>

<!-- BEGIN user profile -->

<!-- BEGIN layout -->
<div class="j-layout j-layout-ls j-layout-bio clearfix">

    <!-- BEGIN large column -->
    <div class="j-column-wrap-l">
        <div class="j-column j-column-l">

            <#if targetUser.partner && !user.partner && !user.anonymous>
                <div class="jive-warn-box" aria-live="polite" aria-atomic="true">
                    <div>
                        <span class="jive-icon-med jive-icon-partner"></span><@s.text name="partner.profile.warn.visible"/> ${action.getSocialGroupsMembershipCount()} <@s.text name="partner.profile.warn.visible.postfix"/>
                    </div>
                </div>
            </#if>

            <table class="vcard" aria-label="<@s.text name='profile.information' />" role="main">
                <tr>
                    <td class="j-profile-section j-profile-section-first" colspan="2">
                        <h3 class="font-color-meta"><@s.text name="profile.work"/></h3>
                    </td>
                </tr>
                <#if (targetUser.nameVisible)>
                    <tr>
                        <td><@s.text name='profile.name'/></td>
                        <td><span class="fn n">${jive.getUserDisplayName(targetUser)}</span></td>
                    </tr>
                </#if>
                <#if (!user.partner && profileObject.manager?has_content)>
                    <tr>
                        <td><@s.text name='profile.manager'/></td>
                        <td class="j-context"><#if profileObject.manager??><a href="<@s.url value='/people/${profileObject.manager.username?url}'/>"></#if>
                            <span class="manager">${profileObject.manager.name?html}</span>
                            <#if profileObject.manager??></a></#if>
                            <#if escalationChain?has_content>
                                <@escChain parents=escalationChain user=profileObject/>
                            </#if>
                            <#if (orgChartingEnabled)>
                                <span class="jive-orgchart-recenter font-color-meta">
                                    <a href="<@s.url value='/people/${targetUser.username?url}/people?filterID=orgchart'/>" class="font-color-meta-light" title="<@s.text name='profile.org.view-orgchart.link'/>"><span class="jive-icon-sml jive-glyph-orgchart"></span><@s.text name='profile.org.view-orgchart.link'/></a>
                                </span>
                            </#if>
                        </td>
                    </tr>
                </#if>
                <#assign statusLevelEnabled = jiveContext.getStatusLevelManager().isStatusLevelsEnabled() />
                <#if (statusLevelEnabled)>
                    <tr>
                        <td><@s.text name='profile.status.level'/></td>
                        <td class="jive-status-level">
                            <@jive.userStatusLevel user=targetUser showPoints=true/>
                        </td>
                    </tr>
                </#if>

                <@displayProfileFields fields=fields viewingSelf=viewingSelf/>

                <#include "/template/socialgroup/view-profile-socialgroups.ftl"/>

                <#if profileObject.tagDelegator.getTags().hasNext()>
                    <tr class="j-profile-extended-data">
                        <td><@s.text name="community.tags.label" /></td>
                        <td>
                            <#list profileObject.tagDelegator.getTags() as tag>
                                <a href="<@s.url value='/tags'/>#/?tags=${tag.name?url}&amp;taggableTypes=${JiveConstants.USER}">${action.renderTagToHtml(tag)}</a>
                            </#list>
                        </td>
                    </tr>
                </#if>

                <#if (linkedInEnabled && !user.anonymous) >
                    <tr class="j-profile-extended-data j-profile-linkedIn">
                        <td colspan=2>
                            <script src="//platform.linkedin.com/in.js" type="text/javascript">
                                extensions: EmployeeProfileWidget@//www.linkedin.com/cws/empprofile-js
                                api_key: ${linkedInAPIKey}
                                        authorize: true
                            </script>
                            <script type="IN/EmployeeProfileWidget"
                                    data-minWidth="450"  <#-- this width has a dependency in jive.css -->
                                    data-companyId="${linkedInCompanyID}"
                                    <#if user.firstName??>data-viewerFirstName="${user.firstName?html}"</#if>
                                    <#if user.lastName??>data-viewerLastName="${user.lastName?html}"</#if>
                                    data-viewerEmailAddress="${user.email?default('')?html}"
                                    data-vieweeFirstName="${profileObject.firstName?default('')?html}"
                                    data-vieweeLastName="${profileObject.lastName?default('')?html}"
                                    data-vieweeEmailAddress="${profileObject.email?default('')?html}">
                            </script>
                        </td>
                    </tr>
                </#if>

                <#if postfix !=''>
                    <tr class="j-profile-extended-data">
                        <td colspan=2>
                            <div class="jive-sidebar-body">
                                <@jive.renderPresence user=targetUser postfix=this_user_presence/>
                            </div>
                        </td>
                    </tr>
                </#if>

            </table>

        </div>
    </div>
    <!-- END large column -->

    <!-- BEGIN small column -->
    <div class="j-column-wrap-s">
        <div class="j-column j-column-s">

            <div id="jive-profile-photos-block" <#if !profileImageEnabled>class="jive-profile-photos-block-nophotos"</#if> aria-label="<@s.text name='profile.sidebar' />">
                <form id="delete-image-form" method="post" action="<@s.url action="delete-profile-image"/>">
                    <input id="delete-image-user" type="hidden" name="imageUsername" value="${targetUser.username?html}"/>
                    <input id="delete-image-index" type="hidden" name="index" value=""/>
                </form>

                <#assign imageCount=profileImages?size />
                <#assign showImage = profileImageEnabled && (imageCount >= 1) />
                <#if profileImageEnabled>
                    <div id="jive-profile-photo">
                        <#if (showImage)>
                            <#list profileImages as pImage>
                                <img src="<@jive.imageProfileUrl profileImage=pImage user=targetUser index=pImage.index size=350/>" id='photo_${pImage.index?c}' class="jive-profile-photo" <#if (pImage_index > 0)>style="display:none"</#if> alt="<@s.text name='profile.image.primary'/>" />
                            </#list>
                        <#else>
                            <img src="<@resource.url value='/images/jive-profile-default-portrait.png' />" alt="<@s.text name='profile.image.primary'/>" width="320" border="0" class="jive-profile-photo" />
                            <#if viewingSelf>
                                <span class="j-profile-img-text j-rc3"><a href="<@s.url value='/edit-profile-avatar!input.jspa?targetUser=${targetUser.ID?c}'/>" class="j-btn-global"><@s.text name="profile.image.text.add.photo"/></a></span>
                            </#if>
                        </#if>
                    </div>
                </#if>
                <#if (showImage && imageCount > 1)>
                    <ul id="jive-profile-photos-list" class="clearfix">
                        <#list profileImages as pImage>
                            <li <#if pImage_index==0>class="current"</#if>><a href="#"><img src="<@jive.imageProfileUrl profileImage=pImage user=targetUser index=pImage.index size=72 />" class="jive-profile-photo thumb j-rc3" alt="<@s.text name='profile.image.thumbnail'/>" id="thumbnail_${pImage.index?c}" onclick="showPhoto(${pImage.index?c}); return false;" /></a></li>
                        </#list>
                    </ul>
                </#if>

                <#if viewingSelf>
                    <@jive.renderActionSidebar 'profile-actions-self' />
                <#else>
                    <#if (!user.anonymous)>
                        <@jive.renderActionSidebar 'profile-actions' />
                    </#if>
                </#if>
            </div>

        </div>
    </div>
    <!-- END small column -->

</div>
<!-- END layout -->

<!-- END user profile-->
</#macro>

<#macro escChain parents user>
    <a href="#" id="js-place-parents-link" class="j-context-more j-ui-elem" title="<@s.text name="prof.org.escchain.view"/>"><@s.text name="prof.org.escchain.view"/></a>
    <div id="js-place-parents-container" class="j-menu j-breadcrumb-popover" style="display: none">
        <div>
        <#if (parents?has_content)>
        <#list parents as parent>
            <ul>
            <li>
                <a href="<@s.url value='/people/${parent.username?html}'/>"><@jive.userAvatar user=parent size=16 useLinks=false showHover=false /> ${parent.name?html}</a>
                <span class="jive-icon-sml jive-icon-arrow-breadcrumb"></span>
        </#list>
        </#if>
                <ul>
                    <li><a href="<@s.url value='/people/${user.username?html}'/>" class="last-child"><@jive.userAvatar user=user size=16  useLinks=false showHover=false /> ${user.name?html}</a></li>
                </ul>
        <#if (parents?has_content)>
        <#list parents as parent>
            </li>
            </ul>
        </#list>
        </#if>
        </div>
    </div>
</#macro>
