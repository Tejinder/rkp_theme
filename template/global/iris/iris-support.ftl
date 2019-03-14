

<head>
  <script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>

<div class="irisSupport">
<div id="help-c" class="synchro-help-main">
    <div class="synchro-help">
        <h2>Support</h2>
        <ul class="help-list clearfix">
        <#--<li>-->
        <#--<span>Download the Process document</span>-->
        <#--Link to Download the Process document-->
        <#--</li>-->
            
        <#--<li>-->
        <#--<span>Go to Prism</span>-->
        <#--Link to Go to Prism-->
        <#--</li>-->
               
         <#--<li class="disabled_help_link_active">  
         <span  class="disabled_help_link">-->
        
		
		<li>
			<a href="javascript:void(0);" onclick="showVideo();">
				<span class="dashoboard-icon"></span>  
				<span class="dashoboard-text help-training-video"></span>Video</a>
				</span>
			</a>
        </li>
		
		
		<#--
		<li class="disabled_help_link_active"> 
			<span class="disabled_help_link">
				<a onClick="javascript:auditLogs('<@s.text name='logger.project.faq.text' />', ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()});" href="/file/download/SYNCHRO_FAQs.pdf"   title="Currently this feature is not available and will be made available later" alt="Currently this feature is not available and will be made available later">
					<span class="dashoboard-icon"></span>
					<span class="dashoboard-text help-training-video"></span>Video
				</a>
			</span>
		</li>
      
		-->
		
		
		
		<li>
         
			 <a onClick="javascript:auditLogs('<@s.text name='logger.project.overview.text' />', ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()});" href="/file/download/IRIS-User-Manual.pdf">
			<span class="dashoboard-icon"></span>
			<span class="dashoboard-text help-overview"></span>User Manual
			</a>
		</li>
      
	  <#--
	  
	    <li class="disabled_help_link_active"> 
			<span class="disabled_help_link">
                <a onClick="javascript:auditLogs('<@s.text name='logger.project.faq.text' />', ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()});" href="/file/download/SYNCHRO_FAQs.pdf"   title="Currently this feature is not available and will be made available later" alt="Currently this feature is not available and will be made available later">
					<span class="dashoboard-icon"></span>
					<span class="dashoboard-text help-overview"></span>User Manual
				</a>
			</span>
        </li>
			
	  -->
	    
		
		
		<li class="disabled_help_link_active"> 
			<span class="disabled_help_link">
                <a onClick="javascript:auditLogs('<@s.text name='logger.project.faq.text' />', ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()});" href="/file/download/SYNCHRO_FAQs.pdf"   title="Currently this feature is not available and will be made available later" alt="Currently this feature is not available and will be made available later">
					<span class="dashoboard-icon"></span>
					<span class="dashoboard-text user_manual"></span>Tips
				</a>
			</span>
        </li>
		
	  <#--
	  
		<li>
			<a onClick="javascript:auditLogs('<@s.text name='logger.project.contactus.text' />', ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()});" href="/file/download/SynchroUserManual.zip">
				<span class="dashoboard-icon"></span>
				<span class="dashoboard-text user_manual"></span>Tips
			</a>
		</li>
	  
      -->
      
        <li class="disabled_help_link_active"> 
			<span class="disabled_help_link">
				<a onClick="javascript:auditLogs('<@s.text name='logger.project.faq.text' />', ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()});" href="/file/download/SYNCHRO_FAQs.pdf"   title="Currently this feature is not available and will be made available later" alt="Currently this feature is not available and will be made available later">
					<span class="dashoboard-icon"></span>
					<span class="dashoboard-text help-faq"></span>FAQ
				</a>
			</span>
        </li>
		
		<#--
      
      
		<li> 
            <a onClick="javascript:auditLogs('<@s.text name='logger.project.faq.text' />', ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()});" href="/file/download/Synchro_Frequently_Asked_Questions_v1.0.pdf"   title="Currently this feature is not available and will be made available later" alt="Currently this feature is not available and will be made available later">
				<span class="dashoboard-icon"></span>
				<span class="dashoboard-text help-faq"></span>FAQ
			</a>
        </li>
      
      -->
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
                <a onClick="javascript:auditLogs('<@s.text name='logger.project.contactus.text' />', ${statics['com.grail.synchro.SynchroGlobal$Activity'].NOTIFICATION.getId()});" href="mailto:assistance@batinsights.com?subject=Research%20Management%20Tool:%20Assistance">
					<span class="dashoboard-icon"></span>
					<span class="dashoboard-text help-contact"></span>Contact Us
				</a>
            </li>
        </ul>
    </div>
</div>



<div id="all-Videos" style="display:none">
  <i class="icon_remove"><label id="popupheaderMessage">Select the video you would like to download:</label></i>
  <br>
  <label><input type='radio' name='downloadVideoTypeOption'  title=""     id="euVideoType" value='euVideo'>Synchro Training Session for EU Market</label>
  <br> 
  <label><input type='radio' name='downloadVideoTypeOption' title="" id="nonEUVideoType" value='noneuVideo'>Synchro Training Session for Non EU Market</label>
  
   <br>
   
   
      <input type="button" value="Download Video" id="downloadVideo"  onclick="downloadVideo()" />
  
</div>

</div> 
<!-- End iris support -->

<script type="text/javascript">
function auditLogs(text, activityType)
{
  <!-- Audit Logs --> 
  SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].SUPPORT.getId()}, activityType, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].SUPPORT.getId()}, text, "", -1, ${user.ID?c});
}

function downloadVideo()
{
  var checkRadioStatus=$j('input[name=downloadVideoTypeOption]:checked').val();
  if(checkRadioStatus=="euVideo")
  {
    window.location.href = '/file/download/Synchro-Training-Session-for-EU-Market.mp4';
    //$j("#euvideolink").trigger('click');
  }
  if(checkRadioStatus=="noneuVideo")
  {
  
    window.location.href = '/file/download/Synchro-Training-Session-for-Non-EU-Market.mp4';
    //$j("#noneuvideolink").trigger('click');
  }
    
}

$j(document).ready(function(){ 
   $j(".disabled_help_link_active").hover( function(){
    
     $j(".disabled_help_link_active").attr("title","Currently this feature is not available and will be made available later");
   });
   
   });
 function showVideo()
   {
  
  window.location.href = '/file/download/IRIS-Induction-Video.ppsx';
  /* $j("#all-Videos").dialog({
      modal: true,
      width: 450,
      resizable: false,
        draggable: false
    });
    */
   }    
</script>