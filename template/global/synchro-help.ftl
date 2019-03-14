<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<div id="help-c" class="synchro-help-main">
    <div class="synchro-help">
        <h2>Support</h2>
        <ul class="help-list">
        <#--<li>-->
        <#--<span>Download the Process document</span>-->
        <#--Link to Download the Process document-->
        <#--</li>-->
            <li>
                <span><a onClick="javascript:auditLogs('<@s.text name='logger.project.overview.text' />', ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()});" href="/file/download/SynchrO_Overview_8-5-14.pptx">Overview</a></span>
            </li>
        <#--<li>-->
        <#--<span>Go to Prism</span>-->
        <#--Link to Go to Prism-->
        <#--</li>-->
            <li>
            <#--<a href="<@s.url value='/pages/training-video.jsp' />" target="_blank"><span>Training Video</span></a>-->
                <a onClick="javascript:auditLogs('<@s.text name='logger.project.training.text' />', ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()});" href="http://interact/interact/marketing/attachstore.nsf/viewfiles/2590_Integreon_Synchro_FINAL.mp4/$file/2590_Integreon_Synchro_FINAL.mp4?openelement&login" target="_blank"><span>Training Video</span></a>
                <!--<div id="training-video" class="training-video">
                    <video id="MY_VIDEO_1" class="video-js vjs-default-skin" controls
                           preload="none" width="640" height="400" data-setup="{}">
                        <source src="${themePath}/training_videos/2590_Integreon_Synchro_BETA.mp4" type='video/mp4' />
                    </video>
                </div>-->
            </li>
            <li>
                <span><a onClick="javascript:auditLogs('<@s.text name='logger.project.faq.text' />', ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()});" href="/file/download/SYNCHRO_FAQs.pdf">FAQ’s</a></span>
            </li>
            <#--<li>-->
                <#--<span><a href="#">Prism</a></span>-->
            <#--</li>-->
            <#--<li>-->
                <#--<span><a href="#">IRIS</a></span>-->
            <#--</li>-->
            <#--<li>-->
                <#--<span><a href="#">C-PSI Database</a></span>-->
            <#--</li>-->
            <#--<li>-->
                <#--<span><a href="#">Interact link</a></span>-->
            <#--</li>-->
            <li>
                <a onClick="javascript:auditLogs('<@s.text name='logger.project.contactus.text' />', ${statics['com.grail.synchro.SynchroGlobal$Activity'].NOTIFICATION.getId()});" href="mailto:assistance@batinsights.com?subject=Research%20Management%20Tool:%20Assistance"><span>Contact Us</span></a>
            </li>
        </ul>
    </div>
</div>
<script type="text/javascript">
function auditLogs(text, activityType)
{
	<!-- Audit Logs -->	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].SUPPORT.getId()}, activityType, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].SUPPORT.getId()}, text, "", -1, ${user.ID?c});
}
</script>