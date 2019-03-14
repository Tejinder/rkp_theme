<html>
<head>
    <title><@s.text name="cart.view.title" /></title>
<#if legacyBreadcrumb>

    <content tag="breadcrumb">
    <#--<@s.action name="legacy-breadcrumb" executeResult="true" ignoreContextParams="true">-->
    <#--</@s.action>-->
        <a href="<@s.url value='/'/>">${container.name?html}</a>
        <a href="#"><@s.text name="cart.view.breadcrumb.label" /></a>
    </content>
</#if>
<#--<content tag="breadcrumb">-->
<#--<@s.action name="community-breadcrumb" executeResult="true" ignoreContextParams="true" />-->
<#--<a href="<@s.action name='/view-cart'/>">View Cart</a>-->
<#--</content>-->
</head>
<body class="jive-view-cart-page">
<#include "/template/cart/cart-macros.ftl">
<!-- BEGIN: Jive Body Intro -->
<div id="jive-body-intro">
    <div id="jive-body-intro-content" class="jive-body-intro-community clearfix">
        <h1><span class="icon grail-icon-cart"></span><@s.text name="cart.view.header.label" /></h1>
        <p><@s.text name="cart.view.header.message" /></p>
    </div>
<#include "/template/global/include/form-message.ftl" />
<#-- BEGIN: Grail DWR status message -->
    <div id="grail-info-box">
        <div>
            <span id="cart-dwr-msg"></span>
        </div>
    </div>
    <div id="loaderDiv" class="loader-img" style="display:none;">
    </div>

<#-- END : Grail DWR status message -->
    <div class="jive-view-documents-container">
        <div class="grail-add-more"> <a href="<@s.url value="/" />"> <@s.text name="cart.view.addmore.label" /></a> </div>

        <!-- BEGIN Container -->
        <div class="jive-content-block-container" id="jive-document-content-block-container">
            <div class="jive-box-header"><h4><@s.text name="cart.view.table.header.label" /></h4></div>

            <!-- BEGIN Content Block-->
            <div class="jive-content-block">

                <!-- BEGIN content results -->
                <div id="jive-content-results">

                    <!-- BEGIN documents content -->
                    <div id="jive-document-content">



                    <#-- BEGIN : Iterate the cart -->
                        <div class="jive-box-body">
                            <div class="jive-featured">


                            <#assign items = cartItems />
                            <#assign isCartEmpty = items?? && items?size == 0 />

                                <!-- BEGIN jive-table -->
                            <#if !isCartEmpty >
                                <div class="jive-table">
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <thead>
                                        <tr>
                                            <th class="jive-table-head-subject"  colspan="2">Document Title</th>
                                            <th class="jive-table-head-views">Remove / Undo</th>

                                        </tr>
                                        </thead>
                                        <tbody>
                                            <#assign activityCnt = 0 />
                                            <#list cartItems as item>
                                                <#assign docID = item.documentID />
                                                <#assign cartID = item.cartItemID />
                                                <#assign isRemoved = item.removed />
                                            <tr class=" <#if (activityCnt % 2 == 0)> jive-table-row-even <#else>jive-table-row-odd</#if>">
                                                <td class="jive-table-cell-subject">
                                                    <#if item.type == "pdf" >
                                                        <span class="jive-icon-med jive-icon-doctype-acrobat"></span>
                                                    <#elseif item.type == "attachment">
                                                        <span class="jive-icon-med jive-icon-attachment"></span>
                                                        <#if statics['com.grail.cart.util.CartUtil'].getAttachment(item.attachmentID)??>
															<#assign attachmentBean = statics['com.grail.cart.util.CartUtil'].getAttachment(item.attachmentID) />
														</#if>
                                                    </#if>


                                                    <a href="<@s.url value='${JiveGlobals.getDefaultBaseURL()}/docs/${docID}'/>" > <span class="view-cart-content-title"> <#if item.type == "pdf" > ${item.documentTitle?html} <#elseif item.type == "attachment"> <#if attachmentBean??>  ${ attachmentBean.name?html } </#if></#if></span>	</a>
                                                </td>
                                                <td> </td>
                                                <td class="jive-table-cell-views">
                                                    <div  <#if isRemoved == 'true'> style="display:none;"</#if> id="cart-remove-${cartID}" class="cart_remove"><input title="Remove" type="button" name="Remove" onClick="removeFromCart(${cartID});"/>  Remove </div>
                                                    <div <#if isRemoved =='false'> style="display:none;"</#if> id="cart-undo-${cartID}" class="cart_undo"> <input title="Undo" type="button" name="Undo" onClick="undoFromCart(${cartID});"/>  Undo </div>
                                                </td>


                                            </tr>
                                                <#assign activityCnt = activityCnt + 1 />
                                            </#list>
                                        </tbody>
                                    </table>
                                </div>

                            <#else>
                                <div class="grail-jive-table">
                                    <span><@s.text name="cart.view.empty.message" /></span>
                                </div>

                            </#if>
                                <!-- END jive table -->



                            </div>
                        </div>
                    <#-- END : Iterate the cart -->

                    </div>
                    <!-- END documents content -->
                </div>
                <!-- END content results -->

                <!-- BEGIN Cart actions -->
            <#assign downloadCartItems = statics['com.grail.cart.util.CartUtil'].getCartItemsForDownload(user) />


                <div class="jive-box-controls jive-box-footer clearfix" id="cart_actions">
                <#if !isCartEmpty>
                    <a title="Empty your cart" href="#" class="empty"  onClick="clearCart();" > <span class="icon icon_new_empty"></span> <@s.text name="cart.view.emptycart.label" /></a>
                    <a title="Download cart" id="download-cart" class="download" onClick="hasDownloadCompleted()" href="<@s.url action="download-cart"/>" > <span class="icon icon_new_download"></span><@s.text name="cart.view.downloadcart.label" /></a>
                    <div id="download-inProgress" style="display:none;" class="download"><@s.text name="cart.view.downloading.label" /></div>
                <#else>
                    <a title="Empty your cart" href="#" class="disable_empty empty"  onClick="return false;" > <span class="icon disable_icon_new_empty"></span> <@s.text name="cart.view.emptycart.label" /></a>
                    <a title="Download cart" class="disable_download download" href="#"> <span class="icon disable_icon_new_download"></span><@s.text name="cart.view.downloadcart.label" /></a>
                </#if>
                </div>
                <!-- END Cart actions -->

            </div>
            <!-- END Content Block-->

        </div>
        <!-- BEGIN Container -->


    </div>


</div>
<!-- END: Jive Body Intro -->
</body>
</html>