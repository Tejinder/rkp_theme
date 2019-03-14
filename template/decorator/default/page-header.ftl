<script type="text/javascript">
    var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
    document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
    try {
        var pageTracker = _gat._getTracker("UA-12774522-1");
        pageTracker._trackPageview();
    } catch(err) {}

</script>
<#if session.getAttribute('grail.portal.type')??>
   <#assign portalType = session.getAttribute('grail.portal.type')/>
</#if>
<#if portalType??>
    <#if portalType == 'synchro'>
        <a href="<@s.url value="/synchro/home"/>" class="j-header-logo"></a>
    <#elseif portalType == 'rkp'>
        <a href="<@s.url value="/index.jspa"/>" class="j-header-logo"> </a>
    </#if>
<#elseif Session.passwordExpired??>
    <a class="j-header-logo"></a>
<#else>
    <a class="j-header-logo"></a>
</#if>
<div></div>

<#--<#if skin.template.basicTitleUsed>
    <h1 id="jive-global-header-title">${skin.template.basicTitle?html}</h1>
<#else>
    <#if skin.template.basicLogoUsed>
        <img src="${skin.template.basicLogoPath}" alt="" />
    <#else>
        <h1 id="logo">Jive</h1>

    </#if>
</#if>-->

<#if !page.getProperty("meta.nouserbar")?? && !Session.passwordExpired??>
   <#-- <#assign downloadCartItems = statics['com.grail.cart.util.CartUtil'].getCartItemsCount(user) />
    <div id="view-grail-cart" class="view-grail-cart">
        <a href="<@s.url action="view-cart"/>"><span class="icon icon_view_cart"></span>View Cart (${downloadCartItems}) </a>
    </div>
  -->

</#if>