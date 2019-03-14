<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<div class="border-container grail">
    <div id="dashboard_div" class="grail-home-container">
        <script type="text/javascript">
            function makeRequest() {
            <#--GrailMakeRequestService.makeRequest({-->
            <#--callback: function(data) {-->
            <#--window.location.href = '<@s.url value="/grail/grail-home!execute.jspa"/>';-->
            <#--},-->
            <#--async: false-->
            <#--});-->
                window.location.href = '<@s.url value="/kantar/home!execute.jspa"/>';

            }


        </script>

    <#--<a href="javascript:void(0);">-->
        <img src="${themePath}/images/kantar/kantar-body-content.png" alt="">

        <span class="kantar grail-make-request-button" onclick="makeRequest()"></span>
    <#--</a>-->
    <#--<div>-->
    <#--<map id="grailHelplineMap" name="grailHelplineMap">-->
    <#--<area shape="circle" coords="860,145,100" href="<@s.url value="/grail/brief-template!input.jspa"/>" alt="Grail Help Line">-->
    <#--</map>-->
    <#--</div>-->
    </div>

</div>

<script type="text/javascript">	
<!-- Audit Logs -->	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].KANTAR.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].HOME.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, 0, "Home Page", "", -1, ${user.ID?c});
</script>