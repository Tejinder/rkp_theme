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
		
		/*page background */
		
		var imagePath = '${JiveGlobals.getJiveProperty("synchro.home.page.background.image","/themes/rkp_theme/images/synchro/bg2.png")}';
		var bg_url = "url("+imagePath+")";
		$j('.dashboard_div').css("background",bg_url);
		$j('#main-container').addClass('conThome');
		
    });
</script>

<div class="border-container">
    <div id="dashboard_div" class="dashboard_div">
        <div class="dashboard_menu">
            <h2>Welcome</h2>
            <p   >Welcome to Synchro, the Research Management Tool.</p>
            <#--<p>Please choose from the following options.</p>-->
			
			<#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
			
            <ul class="clearfix">
                <#-- <li class="">
               
			   <#if synchroPermHelper.isSynchroSystemOwner() || synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isEndMarketUserType() || synchroPermHelper.isGlobalUserType() || synchroPermHelper.isRegionalUserType() >
                    <a href="<@s.url value="create-waiver!input.jspa"/>" title="Click here to Initiate a Waiver">
                        <span class="dashoboard-icon"></span>
                        <span class="dashoboard-text">Initiate Waivers</span>
                        
                    </a>
                <#else>
                    <a href="javascript:void(0);" class="disabled">
                        <span class="dashoboard-icon"></span>
                        <span class="dashoboard-text">Initiate Waivers</span>
                    </a>
                </#if>-->
				
				<#--
				<#if synchroPermHelper.canInitiateWaiver_NEW() >
					<a href="<@s.url value="create-waiver!input.jspa"/>" title="Click here to Initiate a Waiver">
                        <span class="dashoboard-icon"></span>
                        <span class="dashoboard-text">Initiate Waivers</span>
                    </a>
				<#else>	
					<a href="javascript:void(0);" class="disabled">
                        <span class="dashoboard-icon"></span>
                        <span class="dashoboard-text">Initiate Waivers</span>
                    </a>
				</#if> 
                </li> -->
            
            
             
             
                
                
                
               <#-- Enable the Generate Reports section only for the Super Admin user and System Owner-->
            <#--    <#if synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isSynchroSystemOwner()>
	                <li class="">
			
						<a href="javascript:void(0);" onclick="javascript:openGenerateReportWindow()" title="Click here to Generate Reports">
						
	                    <span class="dashoboard-icon"></span>
	                    <span class="dashoboard-text">Generate Reports</span>
						</a>
	                </li>
	              </#if> -->
				  
			
	                <li class="">
			
						<a href="javascript:void(0);" onclick="javascript:openGenerateReportWindow()" title="Click here to Generate Reports">
						
	                    <span class="dashoboard-icon"></span>
	                    <span class="dashoboard-text">Generate Reports</span>
						</a>
	                </li>
	         
	         
	         
               <#-- <li class="">
					<#if createAccess?? && createAccess>
						 <#if synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isGlobalUserType() || synchroPermHelper.isRegionalUserType() || synchroPermHelper.isSynchroSystemOwner()>
							<a href="javascript:void(0);" onclick="javascript:openProjectCreateWindow()" title="Click here to Initiate a Project">
							<span class="dashoboard-icon"></span>
							<span class="dashoboard-text">Initiate projects</span>
							</a>
						 
						<#else>
							<a href="<@s.url value='create-project!input.jspa'/>" title="Click here to Initiate a Project">
							<span class="dashoboard-icon"></span>
							<span class="dashoboard-text">Initiate projects</span>
						</a>
						</#if>
					<#else>
						<a href="javascript:void(0);" class="disabled">
							<span class="dashoboard-icon"></span>
							<span class="dashoboard-text">Initiate projects</span>
						</a>
					</#if>
				</li> -->
				
				
                
				<li class="">
					<#assign manageProjectURL = "" />
					<#if synchroPermHelper.isGlobalUserType() || synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isSynchroSystemOwner()>
						<#assign manageProjectURL = "/new-synchro/global-dashboard-open.jspa" />
					<#elseif synchroPermHelper.isRegionalUserType()>
						<#assign manageProjectURL = "/new-synchro/regional-dashboard-open.jspa" />
					<#else>
						<#assign manageProjectURL = "/new-synchro/em-dashboard-open.jspa" />
					</#if>
					
					<#if createAccess?? && createAccess>
						<a href="${manageProjectURL}" title="Manage Projects">
							<span class="dashoboard-icon"></span>
							<span class="dashoboard-text">Manage projects</span>
						</a>
					<#else>
						<a href="${manageProjectURL}" title="View Projects">
							<span class="dashoboard-icon"></span>
							<span class="dashoboard-text">View projects</span>
						</a>
					</#if>
				</li>
				
				<li class="">
					<#if createAccess?? && createAccess>
						 <#if synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isGlobalUserType() || synchroPermHelper.isRegionalUserType() || synchroPermHelper.isSynchroSystemOwner()>
							<a href="javascript:void(0);" onclick="javascript:openProjectCreateWindow()" title="Click here to Initiate a Project">
							<span class="dashoboard-icon"></span>
							<span class="dashoboard-text">Initiate projects</span>
							</a>
						 
						<#else>
							<a href="<@s.url value='create-project!input.jspa'/>" title="Click here to Initiate a Project">
							<span class="dashoboard-icon"></span>
							<span class="dashoboard-text">Initiate projects</span>
						</a>
						</#if>
					<#else>
						<a href="javascript:void(0);" class="disabled">
							<span class="dashoboard-icon"></span>
							<span class="dashoboard-text">Initiate projects</span>
						</a>
					</#if>
				</li>
				
				<li class="bottom support">
                	<a href="<@s.url value="/new-synchro/help.jspa"/>" target="blank" title="Click here to go to Help">
                        <span class="dashoboard-icon"></span>
                    </a>
                </li>
	            
	            
           </ul>
          
        </div>
    </div>
</div>

<div id="project-create-options" style="display:none">
	<i class="icon_remove">Select from the process options below to Initiate a project:</i>
	<br>
	<label><input type='radio' name='endMarketType' id="endMarketNonEUType" value='NONEU'>With no EU end market</label>
	<br>
	<label><input type='radio' name='endMarketType' id="endMarketEUType" value='EU'>With EU end market</label>
	<#if synchroPermHelper.isGlobalUserType() || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner()>
		<br>
		<label><input type='radio' name='endMarketType' id="endMarketGLOBALType" value='GLOBAL'>With no end market focus</label>
	<#elseif synchroPermHelper.isRegionalUserType()>
		<br>
		<label><input type='radio' name='endMarketType' id="endMarketGLOBALType" value='GLOBAL'>With no end market focus</label>
	</#if>
	
	<#if statics['com.grail.synchro.util.SynchroPermHelper'].isEndMarketUserType() || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner()>
		<#if statics['com.grail.synchro.util.SynchroPermHelper'].isGlobalUserType() || statics['com.grail.synchro.util.SynchroPermHelper'].isRegionalUserType()>
		<#else>
		<br>
		<label><input type='radio' name='endMarketType' id="endMarketOnly" value='ENDMARKET'>End market project</label>
		</#if>
	</#if>
	<input type="button" value="Initiate" id="downloadReport"  onclick="initiateProject()" />
</div>

<div id="generate-report-options" style="display:none">
	<i  class="icon_remove">Select from the options below to generate report:</i>
	<#if statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner()>
	<br>
	<label><input type='radio' name='generateReportType' id="qprSnapshotReportType" value='NONEU'>QPR Snapshot</label>
	</#if>
	<br>
	<label><input type='radio' name='generateReportType' id="rawExtractReportType" value='EU1'>All Projects Report</label>
	<br>
	<label><input type='radio' name='generateReportType' id="spendReportsReportType" value='EU2'>Spend Report</label>
	<br>
	<label><input type='radio' name='generateReportType' id="agencyEvaluationReportType" value='EU3'>Agency Evaluation Report</label>
	 <br/>
	<input type="button" value="Ok" id="genertateReports"  onclick="genertateReports()" />
</div>

<script type="text/javascript">
<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.home.view.text" /></#assign>	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].HOME.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, 0, "${i18CustomText}", "", -1, ${user.ID?c});

function openProjectCreateWindow(){
		
  
   $j("#project-create-options").dialog({
			modal: true,
			width: 450,
			resizable: false,
        draggable: false
		});
}

function openGenerateReportWindow(){
	
 $j('input[name="generateReportType"]').prop('checked', false);	
   $j("#generate-report-options").dialog({
			modal: true,
			width: 450,
			resizable: false,
        draggable: false
		});
}

 /*$j("#endMarketNonEUType").click(function() {
		
		
		
    });   
 $j("#endMarketEUType").click(function() {
		
		location.href="/new-synchro/create-project!input.jspa?globalProjectType=EU";
    }); 
	*/
	
	function initiateProject()
{
    // check which radio button is selected
	var checkRadioStatus=$j('input[name=endMarketType]:checked').val();
	if(checkRadioStatus=="NONEU")
	{
		location.href="/new-synchro/create-project-global!input.jspa";
	}
	else if(checkRadioStatus=="EU")
	{
		location.href="/new-synchro/create-project!input.jspa?globalProjectType=EU";
	}
	else if(checkRadioStatus=="GLOBAL")
	{
		location.href="/new-synchro/create-project-global!input.jspa?globalProjectType=GLOBAL";
	}
	else if(checkRadioStatus=="ENDMARKET")
	{
		location.href="/new-synchro/create-project!input.jspa";
	}
	else 
	{
		   
	}
	   
}
function genertateReports()
{
var checkRadioStatus=$j('input[name=generateReportType]:checked').val();
	if(checkRadioStatus=="NONEU")
	{
		location.href="/new-synchro/qpr-snapshot!input.jspa";
	}
	else if(checkRadioStatus=="EU1")
	{
		//location.href="/new-synchro/downloadRawExtract.jspa";
		$j('#generate-report-options').dialog('close');
		 showAllProjectsReport();
		
	}
	else if(checkRadioStatus=="EU2")
	{
		location.href="/new-synchro/spend-reports.jspa";
	}
	else if(checkRadioStatus=="EU3")
	{
		$j('#generate-report-options').dialog('close')
		showAgencyEvaluationReportFilter();
	}
	else 
	{
		   
	}

}
/*
 $j("#qprSnapshotReportType").click(function() {
		
		location.href="/new-synchro/qpr-snapshot!input.jspa";
		
    });
	
	$j("#rawExtractReportType").click(function() {
		
		location.href="/new-synchro/downloadRawExtract.jspa";
		
    });	
	
	$j("#spendReportsReportType").click(function() {
		
		location.href="/new-synchro/spend-reports.jspa";
		
    });	
	
	$j("#agencyEvaluationReportType").click(function() {
		
		
		$j('#generate-report-options').dialog('close')
		showAgencyEvaluationReportFilter();
		
    });	

*/
</script>