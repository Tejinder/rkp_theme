<body class="synchro-body-formpage">
<#if projectWaiverID?? && (projectWaiverID>0)>

<div class="border-container">
    <div id="synchro-success-box-approved" class="jive-success-box">
        <span class="jive-icon-med jive-icon-check"></span>
        <div class="success-msg">
					<span class="success-text">
                        <@s.text name='waiver.continue.success.msg'>
						</@s.text>
                    </span>
            <span>Waiver: <b>${waiverName?default('')}</b></span>
            <span>Waiver Code: <b>${projectWaiverID?c}</b></span>
            <div class="my-dashboard-link"><a href="<@s.url value='/synchro/waiver-catalogue.jspa'/>">View My Waiver</a></div>
        </div>
    </div>
</#if>

    <div  id="jive-body-main" class="j-layout j-layout-l clearfix portal-options-container">
        <div class="project_continue_main">
            <div class="dashboard_menu">
                <ul>                   
                    <li class="create_new_waiver">
						<#assign createURL = "/synchro/create-waiver!input.jspa"/>
                        <a href="<@s.url value="${createURL}"/>">                        
                            Create a <br>New Waiver
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
