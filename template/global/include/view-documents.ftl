<#include "/template/global/include/pagination-macros.ftl" />
<@initializePagination "view-documents" />

<!-- BEGIN jive-featured-table -->
<#if action.hasFeaturedContent(container, JiveConstants.DOCUMENT)>
<div class="jive-box jive-box-featured">
    <div class="jive-box-header">
        <h4><@s.text name="featuredcontent.documents.title" /></h4>
    </div>
    <div class="jive-box-body">
        <div class="jive-featured">
        <#list action.getFeaturedContent(container, JiveConstants.DOCUMENT) as document>
            <div class="jive-featured-item">
                <a href="<@s.url value='${JiveResourceResolver.getJiveObjectURL(document)}'/>" ><span class="${SkinUtils.getJiveObjectCss(document, 1)}"></span>${action.renderSubjectToText(document)}</a>
                <span class="font-color-meta-light"><@s.text name="settings.by.text" /> <@jive.userDisplayNameLink user=document.versionManager.newestDocumentVersion.author/></span>
            </div>
        </#list>
        </div>
    </div>
</div>
</#if>
<!-- END jive-featured-table -->

<#include "/template/docs/include/doc-macros.ftl">
<!-- BEGIN content list -->
<div class="jive-content-block-container" id="jive-document-content-block-container">
    <#if targetUser?exists && !targetUser.anonymous>
        <#if (user.ID == targetUser.ID)>
            <div class="jive-box-header"><h4><@s.text name="settings.yourPublshdDocs.gtitle" /></h4></div>
            <div class="jive-box-byline jive-content-block-description"><p><@s.text name="settings.blIsListOfYrDocs.text" /></p></div>
        <#else>
            <div class="jive-box-header"><h4><@s.text name="settings.userDocs.text"><@s.param><@jive.displayUserDisplayName user=targetUser/></@s.param></@s.text></h4></div>
            <div class="jive-box-byline jive-content-block-description"><p><@s.text name='settings.blAreAllUserDocs.text'><@s.param><@jive.displayUserDisplayName user=targetUser /></@s.param></@s.text></p></div>
        </#if>
    <#else>
        <div class="jive-box-header"><h4><@s.text name="cmmty.cont.documents.gtitle" /></h4></div>
    </#if>

    <div class="jive-box-body jive-content-block">
        <#assign tagSets = action.getTagSets(container)>
        <#assign tsObjectType = enums['com.jivesoftware.community.JiveObjectType'].Document>
        <#include '/template/global/category-display.ftl' />

        <!-- BEGIN content results -->
        <div id="jive-content-results" class="jive-document-content-block-container">

            <!-- BEGIN recent documents content -->
            <div id="jive-document-content">


                <#if ((documents?exists && documents.hasNext()) || (filter != statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_ALL) || showPrivate)>


                            <#assign paginator = newPaginator>
                            <#if (paginator.numPages > 1)>
                                <!-- BEGIN pagination-->
				    <div class="jive-box-controls clearfix">
                                <span class="jive-pagination">
                                    <span class="jive-pagination-numbers">
                                        <#list paginator.getPages(3) as page>
                                        <#if (page?exists)>
                                            <a href="#/pages/#{page.number}"
                                                <#if (page.start == start)>class="jive-pagination-current"</#if> >
                                                ${page.number}
                                            </a>
                                        <#else>
                                            <span>...</span>
                                        </#if>
                                        </#list>
                                    </span>
                                    <span class="jive-pagination-prevnext">
                                        <#if (paginator.previousPage)>
                                            <a href="#/pages/${paginator.getPageIndex()}" class="jive-pagination-prev">
                                                <@s.text name="global.previous"/>
                                            </a>
                                        <#else>
                                            <span class="jive-pagination-prev-none"><@s.text name="global.previous"/></span>
                                        </#if>
                                        <#if (paginator.nextPage)>
                                            <a href="#/pages/${paginator.getPageIndex() + 2}" class="jive-pagination-next">
                                                <@s.text name="global.next"/>
                                            </a>
                                        <#else>
                                            <span class="jive-pagination-next-none"><@s.text name="global.next"/></span>
                                        </#if>
                                    </span>
                                </span>
				</div>
                                <!-- END pagination -->
                            </#if>

                <div class="jive-box-controls clearfix">
                    <!-- BEGIN topics per page dropdown -->
                    <form action="#/page_sizes/?mostRated=true" method="get" class="autosubmit">
                             <#if mostRated == "true">
   <input type="hidden" name="mostRated" value="true"/>
                                   </#if>
                        <span class="jive-items-per-page">
                            <select name="numResults">
                            <option value="15" <#if numResults == 15>selected="selected"</#if>>15</option>
                            <option value="30" <#if numResults == 30>selected="selected"</#if>>30</option>
                            <option value="50" <#if numResults == 50>selected="selected"</#if>>50</option>
                            </select><span><@s.text name="community.items_per_page.label" /></span>
                        </span>
                    </form>
                    <!-- END topics per page dropdown -->

                    <!-- BEGIN document filter -->
                    <#if (jiveContext.getBinaryBodyManager().isBinaryBodyEnabled())>
                    <form action="#/parameters/" method="get" class="autosubmit">
                               <#if mostRated == "true">
   <input type="hidden" name="mostRated" value="true"/>
                                   </#if>
                        <span class="jive-table-filter">
                            <span><@s.text name="community.filter.label" /></span>
                            <select size="1" name="filter" id="jiveviewdocumentsform-filter">
                            <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_ALL}" <#if filter == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_ALL>selected="selected"</#if>><@s.text name="community.all_docs.listitem" /></option>
                            <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_COLLABORATIVE}" <#if filter == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_COLLABORATIVE>selected="selected"</#if>><@s.text name="community.collabtvDocs.listitem" /></option>
                            <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_DOCUMENTS}" <#if filter == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_DOCUMENTS>selected="selected"</#if>><@s.text name="community.docsWordRtf.listitem" /></option>
                            <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_SPREADSHEETS}" <#if filter == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_SPREADSHEETS>selected="selected"</#if>><@s.text name="community.spreadsheets.listitem" /></option>
                            <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_PRESENTATIONS}" <#if filter == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_PRESENTATIONS>selected="selected"</#if>><@s.text name="community.presentation.listitem" /></option>
                            <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_TEXT}" <#if filter == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_TEXT>selected="selected"</#if>><@s.text name="community.plain_text.listitem" /></option>
                            <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_PDF}" <#if filter == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_PDF>selected="selected"</#if>><@s.text name="community.acrobat_pdf.listitem" /></option>
                            <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_IMAGES}" <#if filter == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_IMAGES>selected="selected"</#if>><@s.text name="community.images.listitem" /></option>
                            <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_VIDEOS}" <#if filter == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_VIDEOS>selected="selected"</#if>><@s.text name="community.videos.listitem" /></option>
                            <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_COMPRESSED}" <#if filter == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_COMPRESSED>selected="selected"</#if>><@s.text name="community.comprsdFiles.listitem" /></option>
                            <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_OTHER}" <#if filter == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_OTHER>selected="selected"</#if>><@s.text name="community.allOthrTypes.listitem" /></option>
                            </select>
                        </span>
                    </form>
               <#if mostRated == "true">
		    <form action="#/parameters/" method="get" class="autosubmit">
                         <input type="hidden" name="mostRated" value="true"/>
                        <span class="jive-table-filter">
                            <span><@s.text name="community.sortby.label" /></span>
                            <select size="1" name="sortBy" id="jiveviewdocumentsform-sortby">
                            <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_RATING}" <#if sortBy == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_RATING>selected="selected"</#if>><@s.text name="community.docs_by_rating.listitem" /></option>
                            <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_VIEWS}" <#if sortBy == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_VIEWS>selected="selected"</#if>><@s.text name="community.docs_by_views.listitem" /></option>
                            <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_MODIFIED_DATE}" <#if sortBy == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_MODIFIED_DATE>selected="selected"</#if>><@s.text name="community.docs_by_modified_date.listitem" /></option>
                            </select>
                        </span>
          </form>
                           <form action="#/parameters/" method="get" class="autosubmit">
                                 <input type="hidden" name="mostRated" value="true"/>
                        <span class="jive-table-filter">
                            <span><@s.text name="community.order.label" /></span>
                            <select size="1" name="order" id="jiveviewdocumentsform-order">
                                <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_DESCENDING}" <#if order == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_DESCENDING>selected="selected"</#if>><@s.text name="community.docs_by_descending.listitem" /></option>
                                <option value="${statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_ASCENDING}" <#if order == statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_ASCENDING>selected="selected"</#if>><@s.text name="community.docs_by_ascending.listitem" /></option>
                            </select>
                        </span>
                    </form>
                   </#if>
                    </#if>
                    <!-- END docuemnt filter -->

                    <#if ((targetUser?? && user.ID == targetUser.ID) && (hasPrivateDocuments))>
                    <!-- BEGIN personal content filter -->
                    <form action="#/parameters/" method="get" class="autosubmit">
                        <span class="jive-table-filter jive-table-filter-personal">
                            <input type="checkbox" id="jiveviewdocumentsform-showPrivate" name="showPrivate" value="true" <#if showPrivate >checked</#if> />
                            <label for="jiveviewdocumentsform-showPrivate">
                                <img src="<@resource.url value='/images/transparent.png'/>" title="" class="jive-icon-sml jive-icon-bookmark-private" style="display: none"/>
                                <@s.text name="main.documents.filter.personal.label"/>
                            </label>
                        </span>
                    </form>
                    <!-- END personal content filter -->
                    </#if>



                </div>
                </#if>



                    <#if (!documents?exists || !documents.hasNext())>

                        <#if ((filter != statics['com.jivesoftware.community.action.ViewDocumentsAction'].FILTER_ALL) || tagSet?exists)>
                            <div id="jive-community-empty" class="jive-community-empty-small">
                                <p><@s.text name="community.docs.filtered.none">
                                    <@s.param><a href="#/parameters/?tagSet=&tag=&filter="></@s.param>
                                    <@s.param></a></@s.param>
                                </@s.text></p>
                            </div>
                        <#else>

                             <@jive.jiveEmptyContentList container=container showTypeExclusively="document"/>

                        </#if>

                    <#else>

                        <!-- BEGIN jive-table -->
                        <div class="jive-table">
                            <#assign isRoot = (container.objectType == JiveConstants.COMMUNITY && container.ID == jiveContext.communityManager.rootCommunity.ID)/>
                            <@documentList documents=documents user=user showContainer=isRoot/>
                        </div>
                        <!-- END jive-table -->

                        <!-- BEGIN table footer -->
                        <div class="jive-box-controls jive-box-footer clearfix">

                            <!-- BEGIN document RSS link -->
                            <#if FeedUtils.isFeedsEnabled()>
                                <span class="jive-table-rss-link">
                                    <a href="<@s.url value="/community/feeds/documents" />?<#if tagSet?exists>tagSet=${tagSet.ID?c}<#else>containerType=${container.objectType?c}&container=${container.ID?c}</#if><#if targetUser?exists && !targetUser.anonymous>&targetUser=${targetUser.ID?c}</#if>" title="<@s.text name='community.rssFeedOfList.tooltip'/>" class="font-color-meta"><span class="jive-icon-sml jive-icon-rss"></span><@s.text name="community.rssFeedOfList.link" /></a>
                                </span>
                            </#if>
                            <!-- END document RSS link -->

                            <#assign paginator = newPaginator>
                            <#if (paginator.numPages > 1)>
                                <!-- BEGIN pagination-->
                                <span class="jive-pagination">
                                    <span class="jive-pagination-numbers">
                                        <#list paginator.getPages(3) as page>
                                        <#if (page?exists)>
                                            <a href="#/pages/#{page.number}"
                                                <#if (page.start == start)>class="jive-pagination-current"</#if> >
                                                ${page.number}
                                            </a>
                                        <#else>
                                            <span>&hellip;</span>
                                        </#if>
                                        </#list>
                                    </span>
                                    <span class="jive-pagination-prevnext">
                                        <#if (paginator.previousPage)>
                                            <a href="#/pages/${paginator.getPageIndex()}" class="jive-pagination-prev">
                                                <@s.text name="global.previous"/>
                                            </a>
                                        <#else>
                                            <span class="jive-pagination-prev-none"><@s.text name="global.previous"/></span>
                                        </#if>
                                        <#if (paginator.nextPage)>
                                            <a href="#/pages/${paginator.getPageIndex() + 2}" class="jive-pagination-next">
                                                <@s.text name="global.next"/>
                                            </a>
                                        <#else>
                                            <span class="jive-pagination-next-none"><@s.text name="global.next"/></span>
                                        </#if>
                                    </span>
                                </span>
                                <!-- END pagination -->
                            </#if>

                        </div>
                        <!-- END table footer -->


                    </#if>


            </div>
            <!-- END recent documents content -->

        </div>
        <!-- BEGIN content results -->

    </div>
</div>
<!-- END content list -->
