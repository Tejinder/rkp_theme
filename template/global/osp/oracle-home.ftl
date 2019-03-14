<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>

    <ul class="tiles-cont">
		<#if oracleTileList?? && oracleTileList?size gt 0 >
			<#list oracleTileList as oracleTile>
				<li><a href="/oracle/oracle-folder-dashboard.jspa?tileID=${oracleTile.getTileId()}"><img src="${oracleTile.getTileImageURL()}" alt=""><span><b>${oracleTile.getTileName()}</b></span></a></li>
			</#list>
		</#if>
    </ul>
	
	<script>
	
	
	<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.home.view.text" /></#assign>	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].ORACLE.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].HOME.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, 0, "${i18CustomText}", "", -1, ${user.ID?c});
	
	
	</script>