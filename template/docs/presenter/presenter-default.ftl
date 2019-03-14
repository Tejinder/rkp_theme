<#--
  ~ $Revision: 1.1 $
  ~ $Date: 2018/03/19 12:14:36 $
  ~
  ~ Copyright (C) 1999-2008 Jive Software. All rights reserved.
  ~
  ~ This software is the proprietary information of Jive Software. Use is subject to license terms.
  -->

<!-- BEGIN document -->

<div class="jive-content clearfix doc-page document-view">
    <header>
        <h1><span class="jive-icon-big jive-icon-document"></span>${action.renderSubjectToText(document)}</h1>
       <#assign docVersion = document.versionManager.getDocumentVersion(version)/>
        <#assign docAuthor = action.getAuthor(document)/>
        <#assign onBehalfCreator = action.getDocumentOnBehalfCreateUser(document)!/>
        <#assign docVersionAuthor = action.getDocumentVersionAuthor(docVersion)/>
        <#assign onBehalfModifier = action.getDocumentVersionOnBehalfModifiedUser(docVersion)!/>

        <#if (ActionUtils.previousVersionExists(document, action.user) && document.textBody && !user.anonymous)>
            <a class="j-version" href="<@s.url value='/docs/${document.documentID}/diff?secondVersionNumber=${document.documentVersion.versionNumber?c}'/>">
                <span class="jive-icon-glyph icon-stack"></span> <@s.text name="prsntr.default.version.label" /> ${version}
            </a>
        <#else>
            <span class="j-version">
                <span class="jive-icon-glyph icon-stack"></span> <@s.text name="prsntr.default.version.label" /> ${version}
            </span>
        </#if>

        <div class="j-byline font-color-meta">
            <#if (onBehalfCreator!="" || onBehalfModifier!="")>
                <#assign onBehalfVia = action.getDocumentOnBehalfOfVia(document)!/>
                <#if onBehalfCreator!="" && onBehalfModifier!="">
                    <@s.text name="doc.created_by.created_behalf_modified_behalf">
                        <@s.param><@renderOnBehalf onBehalfUser=onBehalfCreator /></@s.param>
                        <@s.param><@renderUser onBehalfVia=onBehalfVia user=docAuthor /></@s.param>
                        <@s.param>${document.creationDate?datetime?string.medium_short}</@s.param>
                        <@s.param><@renderOnBehalf onBehalfUser=onBehalfModifier /></@s.param>
                        <@s.param><@renderUser onBehalfVia=onBehalfVia user=docVersionAuthor /></@s.param>
                        <@s.param>${docVersion.modificationDate?datetime?string.medium_short}</@s.param>
                    </@s.text>
                <#elseif onBehalfCreator!="" && onBehalfModifier=="">
                    <@s.text name="doc.created_by.created_behalf_modified_by">
                        <@s.param><@renderOnBehalf onBehalfUser=onBehalfCreator /></@s.param>
                        <@s.param><@renderUser onBehalfVia=onBehalfVia user=docAuthor /></@s.param>
                        <@s.param>${document.creationDate?datetime?string.medium_short}</@s.param>
                        <@s.param><#if docVersionAuthor?exists><@jive.userDisplayNameLink user=docVersionAuthor/><#else><@s.text name="prsntr.modified.guest.text" /></#if></@s.param>
                        <@s.param>${docVersion.modificationDate?datetime?string.medium_short}</@s.param>
                    </@s.text>
                <#elseif onBehalfCreator=="" && onBehalfModifier!="">
                    <@s.text name="doc.created_by.created_by_modified_behalf">
                        <@s.param><#if !docAuthor.anonymous><@jive.userDisplayNameLink user=docAuthor/><#else><@s.text name="prsntr.created.guest.text"/></#if></@s.param>
                        <@s.param>${document.creationDate?datetime?string.medium_short}</@s.param>
                        <@s.param><@renderOnBehalf onBehalfUser=onBehalfModifier /></@s.param>
                        <@s.param><@renderUser onBehalfVia=onBehalfVia user=docVersionAuthor /></@s.param>
                        <@s.param>${docVersion.modificationDate?datetime?string.medium_short}</@s.param>
                    </@s.text>
                </#if>
            <#else> <#--uses default created_by text-->
                <@s.text name="doc.created_by.created_by_modified_by">
                    <@s.param><#if !docAuthor.anonymous><@jive.userDisplayNameLink user=docAuthor/><#else><@s.text name="prsntr.created.guest.text"/></#if></@s.param>
                    <@s.param>${document.creationDate?datetime?string.medium_short}</@s.param>
                    <@s.param><#if docVersionAuthor?exists><@jive.userDisplayNameLink user=docVersionAuthor/><#else><@s.text name="prsntr.modified.guest.text" /></#if></@s.param>
                    <@s.param>${docVersion.modificationDate?datetime?string.medium_short}</@s.param>
                </@s.text>
            </#if>
        </div>

        <#if action.isUserContainer() >
        <div class="jive-content-personal font-color-meta">
            <strong class="font-color-meta"><@s.text name="global.visibility"/><@s.text name="global.colon"/></strong>
            <#if action.getVisibilityPolicy(action.user, document) == enums['com.jivesoftware.visibility.VisibilityPolicy'].owner>
            <!-- visible only to you, the author -->
            <span>
                <img src="<@s.url value='/images/transparent.png' />" title="" class="jive-icon-sml jive-icon-bookmark-private"/>
                <@s.text name="doc.visibility.owner.radio"/>
            </span>
            </#if>
            <#if action.getVisibilityPolicy(action.user, document) == enums['com.jivesoftware.visibility.VisibilityPolicy'].open>
            <!-- visible to anyone -->
            <span>
                <@s.text name="doc.visibility.open.radio"/>
            </span>
            </#if>
            <#if action.getVisibilityPolicy(action.user, document) == enums['com.jivesoftware.visibility.VisibilityPolicy'].restricted>
            <#assign viewers = action.removeOwner(action.getViewers(document), document)>
                <span class="jive-shared-list jive-shared-list-short">
                <!-- visible to specific people -->
                    <img src="<@s.url value='/images/transparent.png' />" title="" class="jive-icon-sml jive-icon-content-private-shared"/>
                <#list viewers as user>
                <#if user != document.user>
                     <@jive.userDisplayNameLink user=user/><#if user_has_next>,</#if>
                <#if user_index == 4><#break></#if>
                </#if>
                </#list>
                    <#if (viewers.size() > 4)>
                        ... <!-- show max of 5, then do show/hide of rest -->
                    (<a href="#" class="jive-shared-list-toggle jiveSharedShowAll">show all</a>)
                    </#if>
                </span>
                <#if (viewers.size() > 4)>
                <span class="jive-shared-list jive-shared-list-all" style="display: none;">
                    <img src="<@s.url value='/images/transparent.png' />" title="" class="jive-icon-sml jive-icon-content-private-shared"/>
                    <#list viewers as user>
                    <#if user != document.user>
                    <@jive.userDisplayNameLink user=user/><#if user_has_next>,</#if>
                    </#if>
                    </#list>
                    &nbsp;(<a href="#" class="jive-shared-list-toggle jiveSharedShowLess">show less</a>)
                </span>
                </#if>
            </#if>
        </div>
        </#if>
        <span class="j-page-crease j-ui-elem"></span>
    </header>


    <section class="jive-content-body">
        <#include "/template/docs/presenter/presenter-body.ftl" />
        <#include "/template/docs/presenter/presenter-attachments.ftl" />
    
	<#-- BEGIN Grail Cart customization -->
	<#assign isOnCart = statics['com.grail.cart.util.CartUtil'].isAlreadyOnCart(action.user, document.ID?c,'pdf', 0?c)/>
		<div class="grail-content-pdf">
			<input <#if isOnCart> checked </#if> type="checkbox" name="${document.ID?c}" value="${document.ID?c}" onClick="addContentPDF( ${document.ID?c},'pdf', '${document.subject?replace("'"," ")?html}', this );"/>
			Add document to the cart (in PDF format)
		</div>

    <footer class="jive-content-footer clearfix font-color-meta">
        <@jive.displayViewCount viewCount=document.viewCount containerClass='jive-content-footer-item'/>

        <#include "/template/docs/presenter/presenter-tags.ftl" />

    </footer>
    <span class="j-doc-shadow j-left-doc-shadow j-ui-elem"></span>
    <span class="j-doc-shadow j-right-doc-shadow j-ui-elem"></span>
 
	 <div>
	   <#assign country = country?replace("[", "") />
		<#assign country = country?replace("]", "") />
		<#assign country = country?replace(",", " ") />

		<#assign brand = brand?replace("[", "") />
		<#assign brand = brand?replace("]", "") />

		<#assign methodology = methodology?replace("[", "") />
		<#assign methodology = methodology?replace("]", "") />

		<#assign month = month?replace("[", "") />
		<#assign month = month?replace("]", "") />
		<#assign monthName ="" />
		<#if month?? && month=="0">
			<#assign monthName ="January" />
		<#elseif month?? && month=="1">
			<#assign monthName ="February" />
		<#elseif month?? && month=="2">
			<#assign monthName ="March" />
		<#elseif month?? && month=="3">
			<#assign monthName ="April" />
		<#elseif month?? && month=="4">
			<#assign monthName ="May" />
		<#elseif month?? && month=="5">
			<#assign monthName ="June" />
		<#elseif month?? && month=="6">
			<#assign monthName ="July" />
		<#elseif month?? && month=="7">
			<#assign monthName ="August" />
		<#elseif month?? && month=="8">
			<#assign monthName ="September" />
		<#elseif month?? && month=="9">
			<#assign monthName ="October" />
		<#elseif month?? && month=="10">
			<#assign monthName ="November" />
		<#elseif month?? && month=="11">
			<#assign monthName ="December" />
		</#if>

		<#assign year = year?replace("[", "") />
		<#assign year = year?replace("]", "") />
			<!-- system property fetch and display -->
			<div class="grails-doc-props jive-wiki-details" style="overflow:hidden; ">
				<div style="color:#666666;float:left;font-size:0.8889em;font-weight:normal; padding-right:5px;"><span style="font-weight:bold;">Country :</span>  ${country?string}&sbquo;</div>
				<div style="color:#666666;float:left;font-size:0.8889em;font-weight:normal; padding-right:5px;"><span style="font-weight:bold;">Brand :</span> ${brand?string}&sbquo;</div>
				<div style="color:#666666;float:left;font-size:0.8889em;font-weight:normal; padding-right:5px;"><span style="font-weight:bold;">Methodology : </span>${methodology?string}&sbquo;</div>
				<div style="color:#666666;float:left;font-size:0.8889em;font-weight:normal; padding-right:5px;"><span style="font-weight:bold;">Month : </span>${monthName}&sbquo;</div>
				<div style="color:#666666;float:left;font-size:0.8889em;font-weight:normal;"><span style="font-weight:bold;">Year : </span>${year?trim}</div>
			</div>
	   </div>
    </section>

</div>


<!-- END document -->