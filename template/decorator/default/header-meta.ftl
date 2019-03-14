<meta http-equiv="Content-Type" content="text/html; charset=${skin.template.characterEncoding}" />
<meta http-equiv="Content-Language" content="${skin.template.getLocale()}" />
<meta name="keywords" content="<#if document??><#list document.tagDelegator.tags as tag>${tag.name?html}<#if (tag_has_next)>, </#if></#list><#elseif thread??><#list thread.tagDelegator.tags as tag>${tag.name?html}<#if (tag_has_next)>, </#if></#list><#elseif blogPost??><#list blogPost.tagDelegator.tags as tag>${tag.name?html}<#if (tag_has_next)>, </#if></#list><#elseif video??><#list video.tagDelegator.tags.iterator() as tag>${tag.name?url}<#if (tag_has_next)>, </#if></#list></#if>" />
<meta charset="utf-8" />
<!--[if IE]><![endif]-->
