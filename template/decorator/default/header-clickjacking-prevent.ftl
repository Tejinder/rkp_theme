<#--
    This snippet is used to prevent the application from being embedded into
    an iframe.  This is done to prevent the "clickjacking" exploit.  Details of
    how the exploit is done can be found here - http://www.sectheory.com/clickjacking.htm

    If it is absolutely necessary to embed the application into an iframe, then
    this include file should be overridden via a theme to remove the Javascript
    snippet below.

    The result of this snippet will be that if the page detects that it is being
    included in an iframe, it will force the top level page to redirect to the
    page URL proper.
-->
<script type="text/javascript">
    if (top != self) {
        var isSafeTopUrl = false;
        try {
            var topUrl = top.location.href;
            var topUrlQsIdx = topUrl.indexOf('?');
            if (topUrlQsIdx > 0) {
                topUrl = topUrl.substring(0, topUrlQsIdx);
            }
            topUrl = topUrl.toLowerCase();

            var safeTopUrls = new Array(
                '${skin.template.defaultBaseURL}/skin-basic.jspa',
                '${skin.template.defaultBaseURL}/skin-advanced.jspa',
                '${skin.template.defaultBaseURL}/skin-advanced!UploadSkinZip.jspa',
                '${JiveGlobals.getDefaultBaseURL()}/skin-palette.jspa',
                '${JiveGlobals.getDefaultBaseURL()}/skin-palette!start.jspa'
            );
            for (var i = 0; i < safeTopUrls.length; i++) {
                if (safeTopUrls[i].toLowerCase() == topUrl) {
                    isSafeTopUrl = true;
                    break;
                }
            }
        } catch (err) {
        }
        if (!isSafeTopUrl) top.location = location;
    }
</script>
