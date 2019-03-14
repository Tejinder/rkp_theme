<#--
  - $Revision: 1.1 $
  - $Date: 2018/03/19 12:14:39 $
  -
  - Copyright (C) 1999-2008 Jive Software. All rights reserved.
  - This software is the proprietary information of Jive Software. Use is subject to license terms.
-->

<html>
<head>

    <#if avatarEditEnabled && profileImageEnabled>
        <#assign title><@s.text name="photoavatar.edit.title" /></#assign>
    <#elseif !avatarEditEnabled>
        <#assign title><@s.text name="photoavatar.edit.profile_photo.title" /></#assign>
    <#else>
        <#assign title><@s.text name="photoavatar.edit.avatar.title" /></#assign>
    </#if>

    <title>${title}</title>
    <content tag="breadcrumb">
        <a href="<@s.url value='/'/>">${container.name?html}</a>
        <a href="<@s.url value='/people'/>"><@s.text name="profile.people.brdcrmb.link" /></a>
        <a href="<@s.url value='/people/${targetUser.username}'/>">${targetUser.username}</a>
        <a href="<@s.url value='#'/>"><@s.text name="profile.change_photoavatar.brdcrmb.link" /></a>
    </content>

    <link rel="stylesheet" href="<@resource.url value='/styles/jive-profileconfig.css'/>" type="text/css" media="all" />

    <#assign editingSelf=true>
    <#if (user.ID!=targetUser.ID)><#assign editingSelf=false></#if>
    <#if (editingSelf)>
        <#assign photoUpdateSuccessText>
        <@s.text name="photoavatar.photo_update_success.text" />
        </#assign>
        <#else>
            <#assign photoUpdateSuccessText>
            <@s.text name="photoavatar.photo_update_success.text.other_user">
            <@s.param>${SkinUtils.getUserDisplayName(targetUser.ID)}</@s.param>
            </@s.text>
            </#assign>
    </#if>
    <#if (editingSelf)>
        <#assign avatarUpdateSuccessText>
        <@s.text name="photoavatar.avatar_update_success.text" />
        </#assign>
        <#else>
            <#assign avatarUpdateSuccessText>
            <@s.text name="photoavatar.avatar_update_success.text.other_user">
            <@s.param>${SkinUtils.getUserDisplayName(targetUser.ID)}</@s.param>
            </@s.text>
            </#assign>
    </#if>
    <#if (editingSelf)>
        <#assign photoAddSuccessText><@s.text name="photoavatar.photo_add_success.text" /></#assign>
        <#else>
            <#assign photoAddSuccessText>
            <@s.text name="photoavatar.photo_add_success.text.other_user">
            <@s.param>${SkinUtils.getUserDisplayName(targetUser.ID)}</@s.param>
            </@s.text>
            </#assign>
    </#if>
    <#if (editingSelf)>
        <#assign avatarAddSuccessText>
        <@s.text name="photoavatar.avatar_add_success.text" />
        </#assign>
        <#else>
            <#assign avatarAddSuccessText>
            <@s.text name="photoavatar.avatar_add_success.text.other_user">
            <@s.param>${SkinUtils.getUserDisplayName(targetUser.ID)}</@s.param>
            </@s.text>
            </#assign>
    </#if>
    
    <@resource.javascript file="/resources/scripts/jquery/ui/ui.sortable.js" />

    <@resource.javascript>

    var REORDER_ENDPOINT = jive.rest.url("/profileimage/reorder");
    var DELETE_IMAGE_ENDPOINT = jive.rest.url("/profileimage/");
    var SET_AVATAR_ENDPOINT = jive.rest.url("/profileimage/avatar");
    var DELETE_AVATAR_ENDPOINT = jive.rest.url("/profileimage/avatar/");
    var REMAINING_AVATARS_ENDPOINT = jive.rest.url("/profileimage/remainingavatars/");

    $j(document).ready(function() {
        $j("#jive-photo-list").sortable({
            cursor: 'auto',
            delay: 100,
            distance: 10,
            items: '.sortable',
            forcePlaceholderSize: true,
            placeholder: 'jive-sortable-placeholder',
            tolerance: 'pointer',
            update: function(event,ui) {
                var source = getImageIndex(ui.item);
                var target;
                var targetUserID = ${targetUser.ID?c};

                $j('#jive-photo-list li:visible').find("strong").each(function(intIndex) {
                    if ($j(this).text() == source) {
                        target = intIndex + 1;
                        return;
                    }
                 });

                $j.post(REORDER_ENDPOINT, { "targetUserID": targetUserID, "sourceIndex": source, "targetIndex": target}, function() {
                    renumberSlots();
                    updateMessage('.jive-profile-photos-updated','${photoUpdateSuccessText?js_string}');
                });
            }
        });

        renumberSlots();
        <#if imageAddSuccess! == "photo">
            updateMessage('.jive-profile-photos-updated','${photoAddSuccessText?js_string}');
        <#elseif imageAddSuccess! == "avatar">
            updateMessage('.jive-profile-avatar-updated','${avatarAddSuccessText?js_string}');
        </#if>
    });

    function updateMessage(selector,message) {
	    var t;
        $j(selector).find('.thetext').text(message);
        if ( $j(selector).is(':visible') ) {
            $j(selector).animate({color: '#77bb44'}, 100, function() {
                $j(selector).animate({color: '#226611'}, 500);
            });
            clearTimeout(t);
            t = setTimeout(function() { $j(".jive-profile-photos-updated").fadeOut(200); }, 2000);
        } else {
            $j(selector).css('color', '#77bb44');
            $j(selector).fadeIn(50, function() {
                $j(selector).animate({color: '#77bb44'}, 100, function() {
                    $j(selector).animate({color: '#226611'}, 500);
                });

            });
            t = setTimeout(function() { $j(selector).fadeOut(200); }, 2000);
        }
    }

    function renumberSlots() {
        $j('#jive-photo-list > li:visible').find("strong").each(function(intIndex) {
            if ( intIndex == "0" ) {
                var thisPrimary = $j("#primaryPhoto").remove();
                $j(this).closest("li").find("span").append("<em id='primaryPhoto'> | <b><@s.text name="profile.image.primary"/></b></em>");
            }
            $j(this).text(intIndex + 1);
        });
    }

    function getImageIndex(obj) {
        return $j(obj).closest('li').find('strong').text();
    }

    function uploadImage(obj) {
        $j('#imageIndex').attr('value',getImageIndex(obj));
        $j('#profileImageForm').submit();
    }
    
    function deleteProfileImage(targetUserID, obj) {
        <#assign msg><@s.text name="photoavatar.deleteprompt.text"/></#assign>
        if (!confirm("${msg?js_string}")) {
            return;
        }    
        $j.ajax({
			type: "DELETE",
			url: DELETE_IMAGE_ENDPOINT + targetUserID + "/" + getImageIndex(obj),
            success: function() {
                $j(obj).closest('li').remove();
                addEmptyProfileImageSlot();
                renumberSlots();
                updateMessage('.jive-profile-photos-updated', '${photoUpdateSuccessText?js_string}');
            }
        });

    }

    function addEmptyProfileImageSlot() {
        $j('#jive-photo-list').append('<li class="unsortable">' +
            '<img src="<@resource.url value='/images/jive-profile-default-portrait.png'/>" class="jive-profilephoto" width="200" height="150" />' +
            '<strong>x</strong>' +
            "<span><a href='#' onclick='uploadImage(this)'><@s.text name="profile.image.add"/></a></span>" +
            '</li>');
    }

    function setActiveAvatar(targetUserID, id) {
        $j.post(SET_AVATAR_ENDPOINT, {"targetUserID": targetUserID, "ID": id}, function() {
            updateMessage('.jive-profile-avatar-updated', '${avatarUpdateSuccessText?js_string}');
            highlightActiveAvatar(id);
        });
    }

    function highlightActiveAvatar(id) {
        $j('#jive-avatar-list li').each(function() {
            if (this.id == 'jiveAvatarList_' + id) {
                $j(this).addClass('jive-avatar-selected');
            }
            else {
                $j(this).removeClass('jive-avatar-selected');
            }
        });
    }

    function deleteAvatar(targetUserID, id) {
        <#assign msg><@s.text name="photoavatar.deleteprompt.text"/></#assign>
        if (!confirm("${msg?js_string}")) {
            return;
        }
        $j.ajax({
            type: "DELETE",
            url: DELETE_AVATAR_ENDPOINT + targetUserID + "/" + id,
            success: function(newActiveId) {
                newActiveId = newActiveId == -1 ? 0 : newActiveId;
                $j('#jive-avatar-list li').each(function() {
                    if (this.id == 'jiveAvatarList_' + id) {
                        $j(this).remove();
                    }
                });
                updateMessage('.jive-profile-avatar-updated', '${avatarUpdateSuccessText?js_string}');
                highlightActiveAvatar(newActiveId);

                handleUploadLinkDisplay(targetUserID);
            }
        });
    }


    function handleUploadLinkDisplay(targetUserID) {
      $j.post(REMAINING_AVATARS_ENDPOINT, {"targetUserID": targetUserID}, function(remaining) {
            if(remaining >= 0) {
                $j('.jive-avatar-label-instructions').hide();    
                $j('.jive-avatar-add-link').show();
                $j('.jive-avatar-remaining-count').replaceWith('<span class="jive-avatar-remaining-count">' + remaining + '&nbsp;</span>');
            } else {
                $j('.jive-avatar-add-link').hide();
                $j('.jive-avatar-label-instructions').show();
            }
        });
    }

    </@resource.javascript>


</head>
<body class="jive-view-profile jive-view-profile-photosavatars jive-body-formpage">


<header class="j-page-header">
    <h1>${title}</h1>
</header>


<!-- BEGIN layout -->
<div class="j-layout j-layout-l clearfix">

    <!-- BEGIN large column -->
    <div class="j-column-wrap-l">
        <div class="j-column j-column-l">

            <#if action.isImageInModeration()>
            <div class="jive-info-box">
                <div>
                    <span class="jive-icon-med jive-icon-info"></span>
                    <@s.text name="profile.moderated.image.exists"/>
                </div>
            </div>
            </#if>

            <form id="profileImageForm" method="get" action="<@s.url action='edit-profile-avatar' method='inputImage'/>" class="jive-form jive-form-profileimages">
            <input type="hidden" id="imageIndex" name="imageIndex" value="1"/>
            <input type="hidden" id="targetUser" name="targetUser" value="${targetUser.ID?c}"/>
            <div class="jive-profile-images <#if !profileImageEnabled>jive-profile-images-nophoto</#if> clearfix">

                <#if profileImageEnabled>
                <div class="jive-profile-photos">
                     <h5><@s.text name="profile.images.label"/><span class="jive-profile-photos-updated" style="display: none"><span class="jive-icon-sml jive-icon-check"></span><span class="thetext"></span></span></h5>
                     <p>
                         <#if (editingSelf)>
                            <@s.text name="profile.image.edit.instructions"/>
                         <#else>
                            <@s.text name="profile.image.edit.instructions.other_user">
                                <@s.param>${SkinUtils.getUserDisplayName(targetUser.ID)}</@s.param>
                            </@s.text>
                        </#if>
                     </p>
                     <ul id="jive-photo-list" class="jive-profile-photo-list">

                         <#list [1,2,3,4] as slotNo>
                            <#assign changelink=""/>
                            <#assign primarylink=""/>
                            <#if (action.getProfileImageForIndex(slotNo)??)>
                                <#assign slotImage = action.getProfileImageForIndex(slotNo)/>
                                <#assign sortclass>sortable</#assign>
                                <#assign imglink><div class="jive-profile-photo-list-image" style="background-image:url(<@jive.imageProfileUrl user=targetUser index=slotImage.index size=200 overrideStatus=true/>)">&nbsp;</div></#assign>
                                <#assign changelink><#if slotImage.status.visible><a href="#" onclick="uploadImage(this)"><@s.text name="global.change"/></a> | </#if><a href="#" onclick="deleteProfileImage('${targetUser.ID?c}', this)"><@s.text name="global.remove"/></a></#assign>
                                <#assign moderatedImage=!slotImage.status.visible/>
                            <#else>
                                <#assign sortclass>unsortable</#assign>
                                <#assign imglink><img src="<@resource.url value='/images/jive-profile-default-portrait.png'/>" class="jive-profilephoto" width="200" height="150" /></#assign>
                                <#assign changelink><a href="#" onclick="uploadImage(this)"><@s.text name="profile.image.add"/></a></#assign>
                                <#assign moderatedImage=false/>
                            </#if>

                            <li class="${sortclass} <#if moderatedImage>jive-image-in-moderation</#if>">
                            ${imglink}
                            <strong>x</strong>
                            <span>${changelink!}${primarylink!}</span>
                            <#if moderatedImage><div class="jive-moderate-object"><@s.text name="profile.moderated.image.label"/></div></#if>
                            </li>

                         </#list>


                     </ul>
               </div><!-- END profile photos -->
               </#if>

               <#if avatarEditEnabled>
               <div class="jive-profile-avatars <#if !profileImageEnabled>jive-profile-avatars-nophoto</#if>">
                    <h5>Avatar <span class="jive-profile-avatar-updated" style="display: none"><span class="jive-icon-sml jive-icon-check"></span><span class="thetext"></span></span></h5>
                    <#-- Choose Avatar: -->
                    <p><@s.text name="avatar.select.instruc" /></p>
                    <ul id="jive-avatar-list" class="jive-profile-avatar-list">

                         <#if defaultAvatarID == -1>
                             <li id="jiveAvatarList_0" class="<#if activeAvatar.systemDefault>jive-avatar-selected</#if>">
                                 <a href="#" onclick="setActiveAvatar('${targetUser.ID?c}', '0');return false;">
                                     <img src="<@s.url value="/people/guest/avatar/48.png" />" id="0" alt="" class="jive-avatar" />
                                 </a>
                             </li>
                         </#if>

                         <#if globalAvatars?has_content >
                             <#list globalAvatars as avatar >
                             <li id="jiveAvatarList_${avatar.ID?c}" class="<#if avatar.ID == activeAvatar.ID>jive-avatar-selected</#if>">
                                 <a href="#" onclick="setActiveAvatar('${targetUser.ID?c}', '${avatar.ID?c}');return false;">
                                     <img src="<@s.url action='avatar-display'/>?avatarID=${avatar.ID?c}&file=av.png" id="${avatar.ID?c}" alt="" class="jive-avatar" />
                                 </a>
                             </li>
                             </#list>
                         </#if>

                         <#if userAvatars?has_content >
                             <#list userAvatars as avatar >
                                 <#if !avatarModerationEnabled || (avatar.modValue > 0) >
                                     <li id="jiveAvatarList_${avatar.ID?c}"  class="<#if avatar.ID == activeAvatar.ID>jive-avatar-selected</#if>">
                                         <a href="#" onclick="setActiveAvatar('${targetUser.ID?c}', '${avatar.ID?c}');return false;">
                                             <img src="<@s.url action='avatar-display'/>?avatarID=${avatar.ID?c}&file=av.png" id="${avatar.ID?c}" alt="" />
                                         </a>
                                         <div class="jive-avatar-label-delete">
                                             <a href="#" onClick="deleteAvatar('${targetUser.ID?c}', '${avatar.ID?c}'); return false;"><@s.text name="global.left_paren"/><@s.text name="avatar.delete_avatar.link"/><@s.text name="global.right_paren"/></a>
                                         </div>
                                     </li>
                                 <#else>
                                     <li id="jiveAvatarList_${avatar.ID?c}" class="<#if avatar.ID == activeAvatar.ID>jive-avatar-selected</#if>">
                                         <img src="<@s.url action='avatar-display'/>?avatarID=${avatar.ID?c}&file=av.png" id="${avatar.ID?c}" alt="" />
                                         <div class="jive-avatar-pending-approval"><@s.text name="avatar.pending.label" /></div>
                                         <div class="jive-avatar-label-delete">
                                             <a href="#" onClick="deleteAvatar('${targetUser.ID?c}', '${avatar.ID?c}'); return false;"><@s.text name="global.left_paren"/><@s.text name="avatar.delete_avatar.link"/><@s.text name="global.right_paren"/></a>
                                         </div>
                                     </li>
                                 </#if>
                             </#list>
                         </#if>

                         <#if ( userAvatarsEnabled && (maxUserAvatars > 0) ) >
                             <li class="instructions clearfix">
                                 <div class="jive-avatar-label-instructions" <#if (userAvatars.size() < maxUserAvatars) >style="display:none"</#if>>

                                 <span>
                                     <@s.text name="avator.replace_avator.instruc" />
                                 </span>
                                     </div>
                             </li>


                                 <li>
                                     <div class="jive-avatar-add-link" style="<#if (userAvatars.size() >= maxUserAvatars) >display: none;</#if>">

                                     <span>
                                         <a href="<@s.url value="/avatar-userupload!inputImage.jspa?targetUser=${targetUser.ID?c}" />"><@s.text name="avatar.add_another.link" /></a>
                                         <span class="jive-avatar-remaining-count">${maxUserAvatars - userAvatars.size()}&nbsp;</span><span><@s.text name="avator.number_remaining.text"/></span>
                                     </span>
                                         </div>
                                 </li>

                         </#if>

                    </ul>
                </div><!-- END profile avatars -->
                </#if>

             </div><!-- END profile image -->


             <div class="jive-form-buttons clearfix">
                    <button type="button" class="j-btn-callout" onclick="location.href='<@s.url value="/people" />/${targetUser.username?url}'"><@s.text name="global.finished" /></button>
             </div>

             </form>
            
        </div>
    </div>
    <!-- END large column -->

</div>
<!-- END layout -->


</body>
</html>
