<#include "/template/global/include/grail-macros.ftl" />
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

<#if id?? && (id>0)>

<div class="border-container">
    <div id="synchro-success-box-approved" class="jive-success-box">
        <span class="jive-icon-med jive-icon-check"></span>
        <div class="success-msg">
            <span class="success-text">Thanks for making a request to use Grail. We will reach out to you to schedule a briefing call.</span>
        <#--<span>Project : <b></b></span>-->
            <span>Project Code : <b>${generateGrailProjectCode('${id?c}')}</b></span>
            <div class="my-dashboard-link"><a href="<@s.url value='/grail/dashboard.jspa'/>">My Dashboard</a></div>
        </div>
    </div>
</#if>

    <div  id="jive-body-main" class="j-layout j-layout-l clearfix portal-options-container">
        <div class="project_continue_main">
            <div class="dashboard_menu">
                <ul>
                    <li>
                        <a href="<@s.url value='/grail/brief-template!input.jspa?id=${id?c}'/>">
                            Continue with <br>Current Project
                        </a>
                    </li>
                    <li class="last">
                        <a href="<@s.url value="/grail/create-brief-template!input.jspa"/>">
                            Create a <br>New Project
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
