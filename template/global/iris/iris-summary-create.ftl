<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#-- DWR def -->
<head>

   
</head>


<script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>

<#--<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>-->
<script src="${themePath}/js/synchro/commons.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/form-data-persist-handler.js?version=1" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/project-sticky-header.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.MultiFile.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ajaxfileupload.js'/>"></script>
 
<link rel="stylesheet" href="${themePath}/style/multi-select.css" type="text/css" media="all" />
<script src="${themePath}/js/synchro/second.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/autosearch2.js" type="text/javascript"></script>

<#assign bussinessQuestionID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].BUSINESS_QUESTION.getId()/>
<#assign researchObjectiveID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].RESEARCH_OBJECTIVE.getId()/>
<#assign actionStandardID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].ACTION_STANDARD.getId()/>
<#assign researchDesignID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].RESEARCH_DESIGN.getId()/>
<#assign sampleProfileID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].SAMPLE_PROFILE.getId()/>
<#assign stimulusMaterialID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].STIMULUS_MATERIAL.getId()/>
<#assign otherReportingRequirementID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].OTHER_REPORTING_REQUIREMENT.getId()/>
<#assign othersID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].OTHERS.getId()/>
<#assign briefID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].PIB_BRIEF.getId()/>
<#assign agencyWaiverID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].AGENCY_WAIVER.getId()/>
<#assign briefLegalApprovalID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].PIB_BRIEF_LEGAL_APPROVAL.getId()/>



<!-- <form method="POST" name="fetchAttachment" id="fetchAttachment" class="browse-form-align" action="/iris-summary/create-summary!execute.jspa"  onsubmit="return validateForm()">
    <label>Please select the File:</label>
	<input type="text" name="projectID" class="browse-section" value="" disabled>
	<span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${briefID?c})" ></span>
	
	<div class="submit-btn-admin-browse">
	<input class="j-btn-callout" type="submit" name="Submit" value="Submit" />
	</div>
	
</form> -->

<div class="backgroundOuterWrap">

<div class="alignBreadcrumb">
	<a href="/iris-summary/admin-home.jspa">Admin Panel</a> > <a href="javascript:void(0);">Upload Summary</a>
</div>	

<div class="fileBrowseWrap">
	<form method="POST" name="fetchAttachment" action="/iris-summary/create-summary!execute.jspa"  onsubmit="return validateForm()">
    <input type="text" name="">

<div class="bottomBtnWrap mt5 ">
    <div class="bottomBtnWrapAlign" onclick="showAttachmentPopup(${briefID?c})">
		<p class="hoverCls">BROWSE</p>
	</div>
   
  <!-- <div class="upload-icon-text">
	   	<img src="${themePath}/images/iris/upload-icon.png">
	   	<span>Upload</span>
   </div>-->

   <div class="browseInfoText">
   	
      <p>Create and Publish on IRIS</p>

      <p>Click on Browse to select the IRIS template from your computer and  then click Upload.<br><span class="maxFileSizeText">The maximum file size is 50 MB</span></p>
      

      <p>Only new IRIS summary template version supported</p>


   </div>

</div>

	</form>
</div>
</div>



<div id="dialogOverlay">
   <div class="dialogBoxWrap">
   	 <div class="dialogInnerWrap">
   		<img src="${themePath}/images/iris/warning-icon.png">
   		<h5> <b>Incorrect file format</b> </h5>
      <div>
   		 <div class="dialogBtnBox">
		   <a href="#">OK</a>
		   <p>Only new IRIS summary template version supported (.xlsm)</p>
	     </div>
	  </div>
   	</div>
   </div> 
</div>



<div class="successPopupwrap">
	<div id="dialogOverlayDataSuccess">
	   <div class="dialogBoxWrap">
	   	 <div class="successDialogWrap">
	   		<img src="${themePath}/images/iris/green-tick.png">
	   		<h5> <b>IRIS Summary uploaded successfully</b> </h5>
	      <div>
	   		 <div class="dialogBtnBox">
			   <p class="okBtn">OK</p>	
		     </div>
		  </div>
	   	</div>
	   </div> 
	</div>
</div>





<div id="dialogOverlayTemplate">
   <div class="dialogBoxWrap">
   	 <div class="dialogInnerWrap">
   		<!-- <img src="${themePath}/images/iris/warning-icon.png"> -->
   		<h5> <b>Incorrect IRIS Summary template version. </br> Please update your template</b> </h5>
      <div>
   		 <div class="dialogBtnBox">
		   <a href="#">OK</a>
		  <!--  <p>Only new IRIS summary template version supported (.xlsm)</p> -->
	     </div>
	  </div>
   	</div>
   </div> 
</div>






<script type="text/javascript">
	
$j(document).ready(function(){

   $j('.dialogBoxWrap .dialogBtnBox a').click(function(){
   	     $j('#dialogOverlay').hide();
   });

     $j('.dialogBoxWrap .dialogBtnBox p').click(function(){
   	     $j('#dialogOverlayDataSuccess').hide();
   });

     $j('#dialogOverlayTemplate .dialogBtnBox a').click(function(){
   	     $j('#dialogOverlayTemplate').hide();
   });


});

</script>


<script type="text/javascript">

       // validation for submit button
	 function validateForm()
	 {
	 
	   // alert($j("input[name=projectID]").val());
	   if($j("input[name=projectID]").val()!="")
	   {
	   
	   return true;
	   }
	   else
	   {
	       dialog({title:"",html:"Please attach file"});
	       return false;
	   
	   }
	   
	   
	 
	 }


    var attachmentWindow = null;
    $j(document).ready(function(){
        attachmentWindow = new IRIS_SUMMARY_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/iris-summary/create-summary!execute.jspa'/>",
            
            items:[
                {id:${bussinessQuestionID?c},name:'Business Question'},
                {id:${researchObjectiveID?c},name:'Research Objective(s)'},
                {id:${actionStandardID?c},name:'Action Standard(s)'},
                {id:${researchDesignID?c},name:'Methodology Approach and Research design'},
                {id:${sampleProfileID?c},name:'Sample Profile (Research)'},
                {id:${stimulusMaterialID?c},name:'Stimulus Material'},
                {id:${otherReportingRequirementID?c},name:'Other Reporting Requirements'},
                {id:${othersID?c},name:'Other Comments'}
            ]

        });

        $j("#fileAttachBtn").bind('click',function(){
            attachmentWindow.show();
        });
		
		if(window.location.href.indexOf("validSynchroCode") > -1) 
		{
			


			dialog({title:"",html:"The Synchro Code already exists. Please enter unique Synchro Code"});
			return false;
		}
		
		if(window.location.href.indexOf("summaryCreated=false") > -1) 
		{
			$j('#dialogOverlay').show();
		
			// dialog({title:"",html:"<h5><b>Incorrect file format.</h5></b> <p>Only new IRIS summary template version supported (.xlsm)</p>"});
			// return false;
		}
		
		
		if(window.location.href.indexOf("version=invalid") > -1) 
		{

                $j('#dialogOverlayTemplate').show();

			// dialog({title:"",html:"<h5><b>Incorrect IRIS Summary template version.</h5></b> <p>Please update your template</p>"});
			// return false;


		}
		else if(window.location.href.indexOf("summaryCreated=true") > -1) 
		{

			  //  tick pop  ......
			  $j('#dialogOverlayDataSuccess').show();

			// dialog({title:"",html:"IRIS Summary uploaded successfully."});
			// return false;
		}
		
		if(window.location.href.indexOf("validFile=false") > -1) 
		{



                $j('#dialogOverlay').show();

			//dialog({title:"",html:"<h5><b>Incorrect file format.</h5></b> <p>Only new IRIS summary template version supported (.xlsm)</p>"});
			//return false;
		}
		
    });

    function showAttachmentPopup(fieldId) {
         attachmentWindow.show(fieldId);
		 
		
    }
</script>



<script type="text/javascript">
    
    $j(document).ready(function(){
          
        var windowHeight = $j(window).height();
        var headerHEight = $j('#j-header-wrap').height();
        var headerLineHeight = $j('.header-top-page-wrapper').height();
        var footerHeight = $j('footer').height();
       var sumOfHeight = (headerHEight + headerLineHeight + footerHeight);
       var middleContentHeight = (windowHeight) - (sumOfHeight);
       $j('.backgroundOuterWrap').css('height',middleContentHeight);    

    });

</script>

