<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>

    <ul class="tiles-cont">
		<#if shareTileList?? && shareTileList?size gt 0 >
			<#list shareTileList as shareTile>
				<li>
					<#if shareTile.getTileName() == "External Links">
						<a href="/share/links!externalLinks.jspa">
					<#elseif shareTile.getTileName() == "Internal Links">
						<a class="disabled" href="/share/links!internalLinks.jspa">
					<#else>	
						<a href="/share/share-folder-dashboard.jspa?tileID=${shareTile.getTileId()}">
					</#if>	
					<img src="${shareTile.getTileImageURL()}" alt=""><span><b>${shareTile.getTileName()}</b></span>
					</a>
				</li>
			</#list>
		</#if>
    </ul>
	
	<script>
	$j(document).on('click', '.tiles-cont li a.disabled', function(){ event.preventDefault()})
	
	<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.home.view.text" /></#assign>	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SHARE.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].HOME.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, 0, "${i18CustomText}", "", -1, ${user.ID?c});
	
	
	</script>
	