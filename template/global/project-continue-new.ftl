
<body class="synchro-body-formpage">

<#--<div class="view-project-sub-menu">-->
<#--<ul>-->
<#--<li><a title="Click here to Initiate a Single Market Project" href="<@s.url value='create-project!input.jspa'/>">Initiate a Single Market Project</a></li>-->
<#--<li><a title="Click here to Initiate a Multi-Market Project" href="#">Initiate a Multi-Market Project</a></li>-->
<#--<li><a title="Click here to Generate Reports" href="<@s.url value='reports.jspa'/>">Generate Reports</a></li>-->
<#--<li><a title="Click here to Initiate a Waiver" href="<@s.url value='waiver-catalogue.jspa'/>">Initiate a Waiver</a></li>-->
<#--<li><a title="Click here to go to My Dashboard" href="<@s.url value='dashboard.jspa'/>">My Dashboard</a></li>-->
<#--<li class="last"><a title="Click here to go to My Dashboard" href="<@s.url value='help.jspa'/>">Help</a></li>-->

<#--</ul>-->
<#--</div>-->

<#if projectID?? && (projectID>0)>

<div>
    <div id="synchro-success-box-approved" class="jive-success-box">
        <span class="jive-icon-med jive-icon-check"></span>
        <div class="success-msg">
					<span class="success-text">
                        <@s.text name='project.continue.success.msg'>
						</@s.text>
                    </span>
            <span>Project: <b>${projectName?default('')}</b></span>
            <span>Project Code: <b>${generateProjectCode('${projectID?c}')}</b></span>
			<#assign dashboardURL = "" />
				<#if statics['com.grail.synchro.util.SynchroPermHelper'].isGlobalUserType() || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner()>
					<#assign dashboardURL = "/new-synchro/global-dashboard-open.jspa" />
				<#elseif statics['com.grail.synchro.util.SynchroPermHelper'].isRegionalUserType()>
					<#assign dashboardURL = "/new-synchro/regional-dashboard-open.jspa" />
				<#else>
					<#assign dashboardURL = "/new-synchro/em-dashboard-open.jspa" />
				</#if>
				
            <div class="my-dashboard-link"><a href="${dashboardURL}">Projects</a></div>
        </div>
    </div>
</#if>

    <div  id="jive-body-main" class="j-layout j-layout-l clearfix portal-options-container">
        <div class="project_continue_main">
            <div class="dashboard_menu">
                <ul>
                    <li>
                        
                        <#assign continueURL = "/new-synchro/pib-details!input.jspa?projectID="+projectID?c/>
						<#if isFieldWorkProject>
							<#assign continueURL = "/new-synchro/proposal-details-fieldwork!input.jspa?projectID="+projectID?c/>
						</#if>
                        
                        <a href="<@s.url value="${continueURL}"/>">
                        <#--<div class="project-continue-icon"></div>-->
                        <#--<input id="project_continue_btn" type="submit" value='<@s.text name="project.continue.btn.label"/>' class="home_menu_text" />-->
                            <span class="dashoboard-icon"></span>
                            <span class="dashoboard-text">Continue<br>with Current<br>Project</span>
                        </a>
                    </li>
                    <li class="last">
                   
                        <#assign createURL = "/new-synchro/create-project!input.jspa"/>
                   
                        <a href="<@s.url value="${createURL}"/>">
                        <#--<div class="home_menu_icons"></div>-->
                        <#--<input id="project_continue_btn" type="submit" value='<@s.text name="project.createnew.btn.label"/>' class="home_menu_text" />-->
                            <span class="dashoboard-icon"></span>
                             <span class="dashoboard-text">Initiate<br> a New <br>Project</span>
                                                </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>

<#function generateProjectCode projectID maxDigits=5 >
<#if projectID?? && (projectID?number>0) >
	<#local length = (projectID?string)?length />
	<#local prependLen = (maxDigits - length) />
	<#local prepend = '' />
	<#if (length<maxDigits) >
		<#list 1..prependLen as x>
			<#local prepend = prepend + '0' />
		</#list>
	</#if>
	<#return (prepend + projectID?string)>
</#if>
<#return ''>
</#function>