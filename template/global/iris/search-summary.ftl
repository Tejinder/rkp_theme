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

<div class="publishSummaryWrap">
<div class="backgroundOuterWrap">

<div class="alignBreadcrumb">
    <a href="/iris-summary/admin-home.jspa">Admin Panel</a> > <a href="/iris-summary/manage-summaries.jspa">Manage Summaries</a> > <a href="javascript:void(0);">Published Summaries</a>
</div> 

<div class="fileBrowseWrap">
    <form method="POST" name="searchIRISSummaryForm" id="searchIRISSummaryForm" action="/iris-summary/view-summary!execute.jspa"  >
        <#if synchroCode??>
			<input type="text" id="synchroCode" autocomplete="off" name="synchroCode" value="${synchroCode?c}">
		<#else>
			<input type="text" id="synchroCode" autocomplete="off" name="synchroCode" value="">
		</#if>	
        <div class="bottomBtnWrap mt5 ">
            <div onclick="formSubmit()" class="bottomBtnWrapAlign">
                <p class="hoverCls">GO TO SUMMARY</p>          
            </div>     
            <div class="browseInfoText">
              <p>Navigate to a desired IRIS summary using Synchro Code</p>   
              <p>Access the EDIT, MOVE and DELETE options</p>
            </div>
        </div>
    </form>
</div>
</div>

</div>


 <!-- Start dialog box for if synchro code does not exist -->
<div id="dialogOverlay">
   <div class="dialogBoxWrap">
     <div class="dialogInnerWrap">
        <img src="${themePath}/images/iris/warning-icon.png">
        <h5> <b>Incorrect Synchro Code</b> </h5>
      <div>
         <div class="dialogBtnBox">
           <a href="#">OK</a>
           <p>Synchro Code does not exist. Please enter correct Synchro Code</p>
         </div>
      </div>
    </div>
   </div> 
</div>
<!-- End dialog box for if synchro code does not exist -->

 <!-- Start dialog box for if synchro code is not Numeric -->
<div id="dialogOverlayNotNumeric" style="display:none">
   <div class="dialogBoxWrap">
     <div class="dialogInnerWrap">
        <img src="${themePath}/images/iris/warning-icon.png">
        <h5> <b>Incorrect Synchro Code</b> </h5>
      <div>
         <div class="dialogBtnBox">
           <a href="#">OK</a>
           <p>Synchro Code is not correct. Please enter correct Synchro Code</p>
         </div>
      </div>
    </div>
   </div> 
</div>
<!-- End dialog box for if synchro code is not Numeric -->


  <!-- Start dialog box for multiple summaries on single synchro code -->
<div id="dialogOverlayMultipleSummaries">
       <div class="dialogBoxWrapSynchro">
         <a id="multiSummariesClose" href="#">X</a>
         <div class="dialogInnerWrapLinks">
            <h5> <b>Synchro Code: <span><#if synchroCode??>${synchroCode?c}</#if></span> </b> </h5>
          <div>
             <div class="dialogBtnBox">       
                <#if irisSummaryList?? && irisSummaryList?size gt 0 >
					<#list irisSummaryList as irisSummary>
						<a target="_blank" href="/iris-summary/view-summary!input.jspa?irisSummaryId=${irisSummary.irisSummaryId?c}">${irisSummary.projectName}</a>
					</#list>	
				</#if>
			                      
             </div>
          </div>
        </div>
       </div>
</div>
 <!-- End dialog box for multiple summaries on single synchro code -->


<script type="text/javascript">

       
    if(window.location.href.indexOf("synchroCode") > -1) 
    {
       
         $j('#dialogOverlay').show();      
    }

    
    <#if irisSummaryList?? && irisSummaryList?size gt 0 >
		
		<#if irisSummaryList?size == 1>
			
			window.open("/iris-summary/view-summary!input.jspa?irisSummaryId=${irisSummaryList.get(0).getIrisSummaryId()?c}", "_blank");
		<#else>
			
			
			 $j('#dialogOverlayMultipleSummaries').show();   
		</#if>	 
	<#elseif invalidSynchroCode?? && invalidSynchroCode=="yes">
		 $j('#dialogOverlay').show();      
	</#if>		
    

        
  function formSubmit(){
    
	var sCode =  $j("#synchroCode").val();
	
	if(sCode=="" || isNaN(sCode))
	{
		$j('#dialogOverlayNotNumeric').show();      
	}
	else
	{
		$j("#synchroCode").val(sCode.trim());
		$j("#searchIRISSummaryForm").submit();
	}	
  }
  
  $j("#synchroCode").on("keypress", function (e) {            

    if (e.keyCode == 13) {
        // Cancel the default action on keypress event
        e.preventDefault(); 
        formSubmit();
    }
});

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

       $j('.dialogBoxWrap .dialogBtnBox a').click(function(){
         $j('#dialogOverlay').hide();
		 $j('#dialogOverlayNotNumeric').hide();
		 
       });   

        $j('#multiSummariesClose').click(function(){
         $j('#dialogOverlayMultipleSummaries').hide();
        }); 
		
		

    });

</script>

