<#--
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.corner.js"></script>
<script type="text/javascript">
	try{
		$('.radius').corner();
	}catch(err){}
</script>
-->
<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<script type="text/javascript">
    $j(document).ready(function(){
        DYNAMIC_HEIGHT_LOADER.setVerticalCenter($j("#dashboard_div"));
    });
</script>

<div class="border-container">
    <div id="dashboard_div" class="dashboard_div">

        <div class="dashboard_menu">
            <ul>
                <li class="top">
                <#if createAccess?? && createAccess>
                    <a href="<@s.url value='create-project!input.jspa'/>" title="Click here to Initiate a Single Market Project">
                        <span class="single-market-icon"></span>
                        <span class="single-market-text">Initiate Single Market Project</span>
                    </a>
                <#else>
                    <a href="javascript:void(0);" class="disabled">
                        <span class="single-market-icon"></span>
                        <span class="single-market-text">Initiate Single Market Project</span>
                    </a>
                </#if>
                </li>
                <li class="top last">
                <#if createAccess?? && createAccess>
                    <a href="<@s.url value='/synchro/create-multimarket-project!input.jspa'/>" title="Click here to Initiate a Multi-Market Project">
                        <span class="multi-market-icon"></span>
                        <span class="multi-market-text">Initiate Multi-Market Project</span>
                    </a>
                <#else>
                    <a href="javascript:void(0);" class="disabled">
                        <span class="multi-market-icon"></span>
                        <span class="multi-market-text">Initiate Multi-Market Project</span>
                    </a>
                </#if>
                </li>
                <li class="bottom">
                <#if canAccessProjectWaiver?? && canAccessProjectWaiver>
                    <a href="<@s.url value="create-waiver!input.jspa"/>" title="Click here to Initiate a Waiver">
                        <span class="project-waiver-text">Initiate Waiver</span>
                        <span class="project-waiver-icon"></span>
                    </a>
                <#else>
                    <a href="javascript:void(0);" class="disabled">
                        <span class="project-waiver-text">Initiate Waiver</span>
                        <span class="project-waiver-icon"></span>
                    </a>
                </#if>
                </li>
                
                <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
                
               <#-- Enable the Generate Reports section only for the Super Admin user -->
                <#if synchroPermHelper.isSynchroAdmin(user) >
	                <li class="bottom">
	              
	                <#if (synchroPermHelper.isSynchroMiniAdmin(user) || synchroPermHelper.isSynchroAdmin(user)
	                || synchroPermHelper.isSynchroGlobalSuperUser(user) || synchroPermHelper.isSynchroRegionalSuperUser(user)
	                || synchroPermHelper.isSynchroEndmarketSuperUser(user))
	                && !(synchroPermHelper.isExternalAgencyUser(user) || synchroPermHelper.isCommunicationAgencyUser(user))>
	                    <#if (synchroPermHelper.isSynchroMiniAdmin(user) || synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isSynchroGlobalSuperUser(user))>
	                    <a href="<@s.url value="/synchro/raw-extract.jspa"/>" title="Click here to Generate Reports">
	                    <#else>
	                    <a href="<@s.url value="/synchro/spend-reports.jspa"/>" title="Click here to Generate Reports">
	                    </#if>
	                    <span class="generate-reports-text">Generate Reports</span>
	                    <span class="generate-reports-icon"></span>
	                </a>
	                <#else>
	                    <a href="javascript:void(0);" title="Click here to Generate Reports">
	                        <span class="generate-reports-text">Generate Reports</span>
	                        <span class="generate-reports-icon"></span>
	                    </a>
	                </#if>
	                </li>
	              </#if>
	              
                <li class="bottom last">
                    <a href="<@s.url value='help.jspa'/>" title="Click here to go to Help">
                        <span class="support-text">Support</span>
                        <span class="support-icon"></span>
                    </a>
                </li>
	            
           </ul>
        </div>
    </div>
</div>

<script type="text/javascript">
<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.home.view.text" /></#assign>	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].HOME.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, 0, "${i18CustomText}", "", -1, ${user.ID?c});
</script>