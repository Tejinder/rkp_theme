<!-- Include the default CSS -->
<head>
    <link rel="stylesheet" href="${themePath}/style/jmenu.css" type="text/css" />
    <script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jMenu.jquery.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}'/>"></script>

	 


    <style>

        .project_portfolio_div ul li{
            behavior: url(${themePath}/pie/PIE.htc);
        }
        .project_portfolio_div ul li .research_portal{
            border-radius: 25px 25px 0 0;
            behavior: url(${themePath}/pie/PIE.htc);
        }
        .project_portfolio_div .home_menu_text{
            border-radius:0 0 25px 25px;
            behavior: url(${themePath}/pie/PIE.htc);
        }
        #j-main {
            padding: 10px 0 0 0 !important;
			min-height: calc(100% - 61px);
        }

                   

         .project-wrapper{            
             background: url(/themes/rkp_theme/images/h-bg.png);           
        }
        #project_portfolio{margin-top: 30px;}

    </style>
</head>
<body class="jive-body-formpage jive-body-formpage-login">
<script type="text/javascript">
	
	
    $j(document).ready(function(){
	/*page background */
	
	// var imagePath = '${JiveGlobals.getJiveProperty("portal.options.background.image","/themes/rkp_theme/images/h-bg.jpg")}';
	// var bg_url = "url("+imagePath+")";
	// $j('.project-wrapper').css("background",bg_url);
	
        $j("#j-main").addClass("portal-options");
//        DYNAMIC_HEIGHT_LOADER.setVerticalCenter($j("#project_portfolio"));
        // $j("#project_portfolio").css('margin-top', "30px");
        //$j("#jive-body-main").css("min-height","800px");
    });
	
	
	
	
</script>
<div  id="jive-body-main" class="j-layout j-layout-l clearfix portal-options-container">

<#--<div class="synchro-reminder-container">-->
<#--<div class="synchro-reminder-settings-container">-->
<#--<span class="icon"></span>-->
<#--<script type="text/javascript">-->
<#--$j(document).ready(function(){-->
<#--$j("#synchro-reminder-settings-menu").jMenu({-->
<#--openClick : false,-->
<#--TimeBeforeOpening : 0,-->
<#--TimeBeforeClosing : 0,-->
<#--animatedText : false,-->
<#--paddingLeft: 1,-->
<#--effects : {-->
<#--effectSpeedOpen : 0,-->
<#--effectSpeedClose : 0,-->
<#--effectTypeOpen : 'slide',-->
<#--effectTypeClose : 'slide',-->
<#--effectOpen : 'swing',-->
<#--effectClose : 'swing'-->
<#--}-->

<#--});-->
<#--});-->
<#--</script>-->
<#--<ul id="synchro-reminder-settings-menu" class="synchro-reminder-settings-menu">-->
<#--&lt;#&ndash;<li>&ndash;&gt;-->
<#--&lt;#&ndash;<a href="javascript:void(0)">Settings</a>&ndash;&gt;-->
<#--&lt;#&ndash;<ul style="display: none;" class="settings-sub-menu">&ndash;&gt;-->
<#--&lt;#&ndash;<li><a href="<@s.url value="/synchro/edit-profile!input.jspa?targetUser=${user.ID}"/>&from=selective_screen">Edit Profile</a></li>&ndash;&gt;-->
<#--&lt;#&ndash;<li><a href="<@s.url value="/synchro/change-password!input.jspa"/>?from=selective_screen">Change Password</a></li>&ndash;&gt;-->
<#--&lt;#&ndash;<li><a href="<@s.url value="/synchro/project-reminders!input.jspa"/>">My Reminders</a></li>&ndash;&gt;-->
<#--&lt;#&ndash;<li><a href="<@s.url value="/logout.jspa"/>">Logout</a></li>&ndash;&gt;-->
<#--&lt;#&ndash;</ul>&ndash;&gt;-->
<#--&lt;#&ndash;</li>&ndash;&gt;-->
<#---->
<#--</ul>-->

<#--</div>-->

<#--</div>-->
  <!--  <div class="synchro-nav-bar" style="position:relative"> -->
  <div class="synchro-nav-bar homepage-logout-wrap" style="position:relative">
        <ul>
           
           <#-- <li class="edit-profile"><a href="<@s.url value="/synchro/people/${user.username}"/>?from=selective_screen">Edit Profile / Change password</a></li>-->
		    <li class="edit-profile"><a href="/change-password!input.jspa">Change password</a></li>
            <#-- <li class="set-reminder"><a href="<@s.url value="/synchro/project-reminders!input.jspa"/>">Set Reminders</a></li>
            <li class="alerts">
                <div class="alerts-container">
					
                    <span class="count">${statics['com.grail.synchro.util.SynchroReminderUtils'].getUserAlertCount(user.ID)}</span>
					<span class="count">0</span>
                    <a href="<@s.url value='/new-synchro/pending-activities.jspa'/>">Alerts</a>
                </div>
            </li>-->
            <#--<li class="oracle-documents"><a href="<@s.url value="/synchro/oracle-manuals!input.jspa"/>">Oracle Documents</a></li>-->
            <li class="logout"><a href="<@s.url value="/logout.jspa"/>">Logout</a></li>
        </ul>
			<div id="changePasswordSuccessMessage" style="display:none; position:absolute; bottom:10px; color:#00adc3; left:29%	">
		Password has been changed successfully.
	</div>
    </div>

    <div class="project-wrapper">
    <div id="project_portfolio" class="project_portfolio">
        <#--<div class="select-system"><p>Please select the system you wish to use</p></div>-->
        <div class="project_portfolio_div">
            <ul>
               
                <#if hasAccessToSynchro>
                    <li class="first synchro">
					<a href="<@s.url value='/new-synchro/home.jspa'/>" ></a>
                <#else>
                     <li class="first synchro disabled">
					<a href="javascript:void(0);" class="disabled"></a>
                </#if>
                </li>

            <#if hasAccessToRkp>
                <li class="last rkp">
                   <#-- <a href="<@s.url value='/welcome'/>" ></a> -->
				   <!--<a href="/iris-summary/search!input.jspa" ></a>-->
				   <a href="/iris-summary/home!input.jspa" ></a>
				   
                </li>
            <#else>
                <li class="last rkp disabled">
                    <a href="javascript:void(0);" class="disabled"></a>
                </li>
            </#if>
			<#if hasAccessToOSPShare>
                
				
				<#--
				<li  class="bottom kantar-report <#if hasAccessToSynchro>first<#else>last</#if> <#if !hasAccessToGrail && hasAccessToKantar && !hasAccessToKantarReport> center-align</#if>">
					
				  <a  href="<@s.url value='/share/home.jspa'/>" ></a> 
                </li>-->
				
				<li  class="bottom kantar-report last ">
                     <a href="<@s.url value='/share/home.jspa'/>" ></a>
                </li>
            <#else>
				
				<li  class="bottom kantar-report last ">
                    <a class="disabled"  href="javascript:void(0)" ></a>
                </li>
			</#if>     


			<!--   <#if hasAccessToGrail>
                <li class="bottom grail first<#if hasAccessToGrail && !hasAccessToKantar && !hasAccessToKantarReport> center-align</#if>">
                    <a href="<@s.url value='/grail/home!input.jspa'/>" ></a>				
                </li>
            </#if>-->

			
			<#if hasAccessToOSPOracle>
                <li  class="bottom oracle-documents last">
                    <a href="<@s.url value='/oracle/home.jspa'/>" ></a>
                </li>
				
			<#else>	
				<#--<li  class="bottom oracle-documents <#if hasAccessToDocumentRepository?? && hasAccessToDocumentRepository>last<#else>center-align</#if> ">-->
				<li  class="bottom oracle-documents last">
                    <a class="disabled"  href="javascript:void(0)" ></a>
                </li>
			  
			  <!--  <li title="Currently this feature is not available and will be made available later"  alt="Currently this feature is not available and will be made available later" class="bottom oracle-documents <#if hasAccessToDocumentRepository?? && hasAccessToDocumentRepository>last<#else>center-align</#if> ">
                    <a href="<@s.url value='/oracledocuments/oracle-manuals!input.jspa'/>" class="disabled"  title="Currently this feature is not available and will be made available later"  alt="Currently this feature is not available and will be made available later"></a>
                </li>
				-->
            </#if>
  

          <!--  <#if hasAccessToKantar>
                <li class="bottom kantar <#if !hasAccessToGrail>first<#else>last</#if> <#if !hasAccessToGrail && hasAccessToKantar && !hasAccessToKantarReport> center-align</#if>">
                    <a href="<@s.url value='/kantar/home!input.jspa'/>" ></a>
		        </li>
            </#if>-->

            <#--<#if hasAccessToKantarReport>-->
                <#--<li class="bottom kantar-report last <#if ((hasAccessToGrail && hasAccessToKantar) || (!hasAccessToGrail && !hasAccessToKantar)) && hasAccessToKantarReport> center-align</#if>">-->
                    <#--<a href="<@s.url value='/kantar-report/dashboard.jspa'/>" ></a>-->
                <#--</li>-->
            <#--</#if>-->


          
           


                <#--<li class="synchro-post-launch-enhancements">-->
                    <#--<div class="left">-->
                        <#--<label class="label">Post-launch enhancements in SynchrO</label>-->
                        <#--<a class="link" href="<@s.url value="/file/download/Post-launch_Enhancements.pdf"/>">Click here to view</a>-->
                    <#--</div>-->
                    <#--<span class="icon right"></span>-->
                <#--</li>-->
                <#--<li class="synchro-feedback-survey">-->
                    <#--<span class="icon left"></span>-->
                    <#--<div class="right">-->
                        <#--<label class="label">SynchrO feedback survey</label>-->
                        <#--<a class="link" href="http://survey.confirmit.com/wix/p3072256479.aspx?esynchro=${user.email}" target="_blank">Click here to participate</a>-->
                    <#--</div>-->
                <#--</li>-->
            <#--</ul>-->
        </div>


    </div>
</div>
</div>

<script>
if(window.location.href.indexOf("changePassword") > -1) 
	{
		showChangePasswordMsg();
	}

	function showChangePasswordMsg()
	{
		$j("#changePasswordSuccessMessage").show();
				   
	}
</script>
</body>

