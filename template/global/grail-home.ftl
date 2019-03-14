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
                 window.location.href = '<@s.url value="/grail/home!execute.jspa"/>';

             }


         </script>

        <#--<a href="javascript:void(0);">-->
            <img src="${themePath}/images/grail/grail-body-content-small.png" alt="" usemap="#clickheremap">
        <map name="clickheremap">
            <area shape="rect" coords="180,365,300,390" href="/grail/home-full!input.jspa" alt="Click here">
        </map>

        <span class="grail-make-request-button" onclick="makeRequest()"></span>

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
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].GRAIL.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].HOME.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, 0, "Home Page", "", -1, ${user.ID?c});
</script>