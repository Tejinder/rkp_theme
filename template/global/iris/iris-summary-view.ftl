

<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#-- DWR def -->
<head>


<style>


 .colWidth62 div.mce-panel{ border: none !important;} 
 .colWidth62 div.mce-panel .mce-container-body.mce-flow-layout{display:none;}
 .newSectionBox .mce-container-body.mce-flow-layout{display:none;}    
 .newSectionBox .mce-container.mce-panel{border:none !important;}
 .colWidth62 iframe body#tinymce ul{padding-left: 10px;}
</style>
   
</head>

<script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>

<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/commons.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/form-data-persist-handler.js?version=1" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/project-sticky-header.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.MultiFile.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ajaxfileupload.js'/>"></script>
 
<link rel="stylesheet" href="${themePath}/style/multi-select.css" type="text/css" media="all" />
<script src="${themePath}/js/synchro/second.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/autosearch2.js" type="text/javascript"></script>

<script type="text/javascript" src="${themePath}/js/iris/tinymce.editor.custom.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}"></script>
<link rel="stylesheet" href="<@s.url value='${themePath}/js/tinymce-iris_4.1.2/skins/lightgray/skin.min.css'/>" type="text/css" />

<link rel="stylesheet" href="<@s.url value='${themePath}/js/tinymce-iris_4.1.2/skins/lightgray/content.min.css'/>" type="text/css" />
<#include "/template/decorator/iris/iris-header-javascript-rte.ftl" />

<script type="text/javascript">
  var contId;
   var selectedContainer;
    var currval;

 $j(document).ready(function () {



  // Start script for Research Insight in summary view section
	$j('.insightAccordionContent').show();
	$j('.researchInsightContentWrap').on('click', function () {

/*
	  // $j('#relevance-dd').css('background-color','#e4eaeb');
	  $j('.insightAccordionContent').show();
		if ($j('#researchInsightCaret').hasClass('fa-angle-down')) {
			$j('#researchInsightCaret').removeClass('fa-angle-down').addClass('fa-angle-up');
			$j('.insightAccordionContent').show();
  
		}else{
			$j('#researchInsightCaret').removeClass('fa-angle-up').addClass('fa-angle-down');
			$j('.insightAccordionContent').hide();
		}*/
	});
	
	
	
  // End script for Research Insight in summary view section



        

               // checkFileExtentionStatus();

         



        });


  // Start script/function used to change attachment images as per file extension 

   //        function checkFileExtentionStatus() {
        
       
			// $j('.attachmentBox .attachLabelWrap a span').each( function() {

   //               var attachmentText  =  $j(this).text();

   //               	var hrefExt = attachmentText.trim().toLowerCase().split(".");
   //              	var hrefExt2= hrefExt[hrefExt.length-2];

                	

                	

   //              	  if(hrefExt2!=undefined)
   //              	  {
                	  	  

   //                        var k=hrefExt2.toString();
                   

		 //                 if(k.includes('ftl'))
		 //                 {
		             	             
		 //                    $j('.attachmentBox .attachedReportBox a img').attr('src','/themes/rkp_theme/images/osp/oracle/icon-folder.png');               

		 //                 }
		 //                 else if(  k.includes('ppt') ||   k.includes('pptx'))

		 //                 {
		 //                        $j('.attachmentBox .attachedReportBox a img').attr('src','/themes/rkp_theme/images/osp/oracle/icon-file-ppt.png');
		          
		 //                 }
		 //                 else if( k.includes('doc') ||   k.includes('docx'))
		 //                 {
		 //                    $j('.attachmentBox .attachedReportBox a img').attr('src','/themes/rkp_theme/images/osp/oracle/icon-file-word.png');
		                  
		 //                 }
		                  
		 //                 else if( k.includes('xls') ||   k.includes('xlsx'))
		 //                 {
		 //                     $j('.attachmentBox .attachedReportBox a img').attr('src','/themes/rkp_theme/images/osp/oracle/icon-file-excel.png');

		 //                 }

		 //                   else if(k.includes('jar'))
		 //                 {
		                 		                 	
		 //                     $j('.attachmentBox .attachedReportBox a img').attr('src','/themes/rkp_theme/images/osp/oracle/icon-file-zip.png');

		 //                 }

		 //                    else if(k.includes('pdf'))
		 //                 {
		 //                     $j('.attachmentBox .attachedReportBox a img').attr('src','/themes/rkp_theme/images/osp/oracle/icon-file-pdf.png');

		 //                 }


   //                 }
      


			// });
		

   //     }

 // End script/function used to change attachment images as per file extension 


</script>


 
<script>
 <!-- for Calling textArea plugin  -->
   $j(document).ready(function () {
		 	 
		initiateRTE('methodologyDesc', 10000, true);
		initiateRTE('targetGroup', 10000, true);
		initiateRTE('sampleSize', 10000, true);
		initiateRTE('researchBackGround', 10000, true);
		initiateRTE('mainResearchObjective', 10000, true);
		initiateRTE('researchQuestion', 10000, true);
		initiateRTE('actionStandard', 10000, true);
		initiateRTE('findings', 10000, true);
		initiateRTE('resultAgainstActionStandard', 10000, true);
		initiateRTE('conclusion', 10000, true);
		initiateRTE('blurbs', 10000, true);
		
		var insightTagCounterGlobal = 1;
	
		<#if irisSummaryInsightsList?? && irisSummaryInsightsList?size gt 0>
			<#assign insightTagCounter = 1 />
			<#list irisSummaryInsightsList as irisSummaryInsight>
				
				<#if irisSummaryInsight.getInsightsText()?? && irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PRODUCT_TAGS_NAME>
			
				<#elseif irisSummaryInsight.getInsightsText()?? && irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PROJECT_TAGS_NAME>
			
				<#else>
					var insightsHeight = $j('#insightsDiv_${insightTagCounter}').height() + 80;
					
					//alert("insightsHeight==>"+insightsHeight);
						initiateRTE('insights_${insightTagCounter}', 10000, true);
					<#assign insightTagCounter = insightTagCounter + 1 />
					insightTagCounterGlobal = insightTagCounterGlobal + 1;
				</#if>	
			</#list>	
		</#if>
		
	});
</script>


<script type="text/javascript">

	var message='';
    $j(document).ready(function(){
              
        	$j('.checkboxContainer .allCheckBoxes ').click(function(){
        	var pdfAttachmentCheckStatus =false;
        	$j('.allCheckBoxes').each(function(){

            if($j(this).prop("checked") == true){
              
                 pdfAttachmentCheckStatus =true;
            }

            });

             if(pdfAttachmentCheckStatus)
             {

               <!-- ($j('.textColorBlueBox, .shareLinkBox').css('opacity','1')); -->
			   ($j('.textColorBlueBox').css('opacity','1'));
			   ($j('.textColorBlueBox').css('pointer-events','auto'));

                 ($j('.textColorBlueBox').css('cursor','pointer'));

                
             }
              else
              {
                <!-- ($j('.textColorBlueBox, .shareLinkBox').css('opacity','0.6')); -->
				($j('.textColorBlueBox').css('opacity','0.6'));

                ($j('.textColorBlueBox').css('pointer-events','none'));
				($j('.textColorBlueBox').css('cursor','default'));
              }
        });   
		
		
		if(window.location.href.indexOf("published=true") > -1) 
		{
			
			<#if irisSummary.containerId?? && irisSummary.containerId == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER>
		
				message = "<a target='_blank' href='/iris-summary/container-iris-summaries.jspa?endMarketID=-100'>Admin Folder</a>";
			
			<#elseif irisSummary.containerId?? && irisSummary.containerId == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL>
				
				message = '<a target="_blank" href="/iris-summary/container-end-markets.jspa?regionID=${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET}"><span>${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_FOLDER_NAME}</span></a> >'+ 
				'<a target="_blank" href="/iris-summary/container-iris-summaries.jspa?endMarketID=${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL}"><span>${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL_FOLDER_NAME}</span></a>';
				
			<#elseif irisSummary.containerId?? && irisSummary.containerId  == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL>
				message='<a target="_blank" href="/iris-summary/container-end-markets.jspa?regionID=${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET}"><span>${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_FOLDER_NAME}</span></a> > '+ 
				'<a target="_blank" href="/iris-summary/container-iris-summaries.jspa?endMarketID=${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL}"><span>${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL_FOLDER_NAME}</span></a>';	
				
			<#elseif irisSummary.containerId?? && statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(irisSummary.containerId)??>
				<#assign rName = statics['com.grail.synchro.util.SynchroUtils'].getAllRegionName(irisSummary.containerId)>
				<#assign cName = statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(irisSummary.containerId) />
				
				message = '<a target="_blank" href="/iris-summary/container-end-markets.jspa?regionID=${statics['com.grail.synchro.util.SynchroUtils'].getRegionId(irisSummary.containerId)}">${rName}</a> 	> <a href="/iris-summary/container-iris-summaries.jspa?endMarketID=${irisSummary.containerId}">${cName}</a>'; 	
			</#if>



            $j('#dialogOverlay').show();


			
                   
			
		}
    });
	
	function showViewPage()
	{
		<#if uploadSummary?? && uploadSummary=="true">
			window.location.href="/iris-summary/view-summary!input.jspa?irisSummaryId=${irisSummaryId?c}&uploadSummary=true"
		<#else>
			window.location.href="/iris-summary/view-summary!input.jspa?irisSummaryId=${irisSummaryId?c}"
		</#if>	
	}
</script>



<#assign briefID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].PIB_BRIEF.getId()/>
<#assign othersID = statics['com.grail.synchro.SynchroGlobal$SynchroAttachmentObject'].OTHERS.getId()/>

<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />


	<#if irisSummary.containerId?? && irisSummary.containerId == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER>
		<#assign cName = statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER_NAME />
	<#elseif irisSummary.containerId?? && statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(irisSummary.containerId)??>
		<#assign cName = statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(irisSummary.containerId) />
	</#if>	



<div class="viewSummaryBox">

<#if isAdminUser >
	<div class="alignBreadcrumb">
		<a href="/iris-summary/admin-home.jspa">Admin Panel</a> > 
		<#if uploadSummary?? && uploadSummary=="true">
			<a href="/iris-summary/create-summary!input.jspa">Upload Summary</a> > 
		<#else>
			<a href="/iris-summary/container-regions.jspa">Spaces</a> > 
		</#if>	
		<#if irisSummary?? && irisSummary.status?? && irisSummary.status==0>
			<a href="/iris-summary/draft-summaries.jspa">Drafts</a> 
		<#elseif irisSummary?? && irisSummary.status?? && irisSummary.status==1>	
			<#if irisSummary.containerId?? && irisSummary.containerId == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER>
				<a href="/iris-summary/container-iris-summaries.jspa?endMarketID=-100">Admin Folder</a> 
			
			<#elseif irisSummary.containerId?? && irisSummary.containerId == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL>
				<a href="/iris-summary/container-end-markets.jspa?regionID=${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET}"><span>${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_FOLDER_NAME}</span></a> > 
				<a href="/iris-summary/container-iris-summaries.jspa?endMarketID=${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL}"><span>${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL_FOLDER_NAME}</span></a>
			<#elseif irisSummary.containerId?? && irisSummary.containerId  == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL>
				<a href="/iris-summary/container-end-markets.jspa?regionID=${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET}"><span>${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_FOLDER_NAME}</span></a> > 
				<a href="/iris-summary/container-iris-summaries.jspa?endMarketID=${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL}"><span>${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL_FOLDER_NAME}</span></a>	
				
			<#elseif irisSummary.containerId?? && statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(irisSummary.containerId)??>
				<#assign rName = statics['com.grail.synchro.util.SynchroUtils'].getAllRegionName(irisSummary.containerId)>
				
					<a href="/iris-summary/container-end-markets.jspa?regionID=${statics['com.grail.synchro.util.SynchroUtils'].getRegionId(irisSummary.containerId)}">${rName}</a> 	> 
				<#assign cName = statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(irisSummary.containerId) />
					<a href="/iris-summary/container-iris-summaries.jspa?endMarketID=${irisSummary.containerId}">${cName}</a> 	
			</#if>	
		</#if>
		> <a href="javascript:void(0);">${irisSummary.projectName}</a>
	</div>
</#if>	

	<div class="colWidth75OuterWrap">

	<div class="colWidth75">

		<div class="mainHeadWrap">
		<a href="/iris-summary/pdf-summary!input.jspa?irisSummaryId=${irisSummaryId?c}" target="_blank"> <img src="${themePath}/images/iris/pdf-icon.png"> <span>View as PDF</span> </a>
		  <div class="topLinkAlign">
			
			
			<#if isAdminUser>
				<a href="javascript:void(0);" onclick="javascript:deleteSummary()"> <img src="${themePath}/images/iris/delete-icon.png"> <span>Delete</span> </a>
				
				 <li data-popup-move-summary="Popup-Move-Summary"><a href="#"> <img src="${themePath}/images/iris/move-icon.png"> <span>Move</span> </a></li>
				<!--<a href="#"> <img src="${themePath}/images/iris/move-icon.png"> <span>Move</span> </a>-->
				<a href="/iris-summary/edit-summary!input.jspa?irisSummaryId=${irisSummaryId?c}"> <img src="${themePath}/images/iris/edit-icon.png"> <span>Edit</span> </a>
				</div>
			<p class='viewSummaryHead'><#if irisSummary?? && irisSummary.projectName??> ${irisSummary.projectName}</#if></p>
			  <#else>
			        <p class='viewSummaryHead'><#if irisSummary?? && irisSummary.projectName??>${irisSummary.projectName}</#if></p>
					</div>
					   

			</#if>	
				
			
		 
		</div>
		<div class="mainSubHeadWrap">
			<p>PROJECT DETAILS</p>
		</div>
   
        <div class="viewSummaryContentBox">
        	<div class="colWidth38">
        		<p>Synchro code</p>
        	</div>
        	<div class="colWidth62">
        		<P><#if irisSummary?? && irisSummary.synchroCode?? && irisSummary.synchroCode gt 0> ${irisSummary.synchroCode?c}<#else>-</#if></P>
        	</div>
        </div>

         <div class="viewSummaryContentBox">
        	<div class="colWidth38">
        		<p>Project Name</p>
        	</div>
        	<div class="colWidth62">
        		<P><#if irisSummary?? && irisSummary.projectName?? && irisSummary.projectName!=""> ${irisSummary.projectName}<#else>-</#if></P>
        	</div>
        </div>

         <div class="viewSummaryContentBox">
        	<div class="colWidth38">
        		<p>Research End-Market(s)</p>
			<div>RESEARCH LOCATION(S)</div>
        	</div>
        	<div class="colWidth62">
        		<P>
					<#if irisSummary.endMarketId?? && irisSummary.endMarketId?size gt 0 && statics['com.grail.synchro.util.SynchroUtils'].getAllEndMarketNames(irisSummary.endMarketId)!="">
						${statics['com.grail.synchro.util.SynchroUtils'].getAllEndMarketNames(irisSummary.endMarketId)}
					<#else>
						-
					</#if>
				</P>
				<div><P><#if irisSummary?? && irisSummary.researchLocation?? && irisSummary.researchLocation!=""> ${irisSummary.researchLocation}<#else>-</#if></P></div>
        	</div>
        </div>

       <#--  <div class="viewSummaryContentBox">
        	<div class="colWidth38">
        		<p>Research Location(s)</p>
        	</div>
        	<div class="colWidth62">
        		<P><#if irisSummary?? && irisSummary.researchLocation??> ${irisSummary.researchLocation}</#if></P>
        	</div>
        </div>
		-->

         <div class="viewSummaryContentBox">
        	<div class="colWidth38">
        		<p>SP&I Contact</p>
        	</div>
        	<div class="colWidth62">
        		<P><#if irisSummary?? && irisSummary.spiContact?? && irisSummary.spiContact!=""> ${irisSummary.spiContact}<#else>-</#if></P>
        	</div>
        </div>

         <div class="viewSummaryContentBox" style="padding-bottom:20px;">
        	<div class="colWidth38">
        		<p>Methodology Name</p>
			<div>Methodology And Stimulus Description </div>
        	</div>
        	<div class="colWidth62">
        		<P>
					<#if irisSummary.methodology?? && irisSummary.methodology?size gt 0 && statics['com.grail.synchro.util.SynchroUtils'].getAllMethodologyNames(irisSummary.methodology)!="">
						${statics['com.grail.synchro.util.SynchroUtils'].getAllMethodologyNames(irisSummary.methodology)}
					<#else>
						-
					</#if>
				</P>
				<div>
					<P>
					<#if irisSummary?? && irisSummary.methodologyDesc?? && irisSummary.methodologyDesc.trim()!=""> 
						
						<textarea  id="methodologyDesc" disabled name="methodologyDesc">${irisSummary.methodologyDesc?default('')?html}</textarea>
					<#else>
						-
					</#if>
					
					<div id="methodologyDescDiv" name="methodologyDescDiv" style="display:none"><#if irisSummary.methodologyDesc?? && irisSummary.methodologyDesc!="">${irisSummary.methodologyDesc}</#if></div>
					</P>
				</div>
        	</div>
        </div>

        <#-- <div class="viewSummaryContentBox">
        	<div class="colWidth38">
        		<p>Methodology Description</p>
        	</div>
        	<div class="colWidth62">
        		<P>
					<#if irisSummary?? && irisSummary.methodologyDesc??> 
						${irisSummary.methodologyDesc}
					<#else>
						-
					</#if>
				</P>
        	</div>
        </div>
		-->
		
		<div class="viewSummaryContentBox">
        	<div class="colWidth38">
        		<p>Target Group</p>
        	</div>
        	<div class="colWidth62">
        		
				<#if irisSummary.targetGroup?? && irisSummary.targetGroup!="">
					<textarea  id="targetGroup" disabled name="targetGroup">${irisSummary.targetGroup?default('')?html}</textarea>
				<#else>
					-
				</#if>
				
				<div id="targetGroupDiv" name="targetGroupDiv" style="display:none"><#if irisSummary.targetGroup?? && irisSummary.targetGroup!="">${irisSummary.targetGroup}</#if></div>
				
			</div>
        </div>
		
		<div class="viewSummaryContentBox">
        	<div class="colWidth38">
        		<p>Sample Size</p>
        	</div>
        	<div class="colWidth62">
        		<#if irisSummary.sampleSize?? && irisSummary.sampleSize!="">
					<textarea  id="sampleSize" disabled name="sampleSize">${irisSummary.sampleSize?default('')?html}</textarea>
				<#else>
					-
				</#if>
				
				<div id="sampleSizeDiv" name="sampleSizeDiv" style="display:none"><#if irisSummary.sampleSize?? && irisSummary.sampleSize!="">${irisSummary.sampleSize}</#if></div>
				
			</div>
        </div>
		
		<div class="viewSummaryContentBox">
        	<div class="colWidth38">
        		<p>Category</p>
        	</div>
        	<div class="colWidth62">
        		<P>
					<#if irisSummary.category?? && irisSummary.category?size gt 0>
						${statics['com.grail.synchro.util.SynchroUtils'].getCategoryNamesInteger(irisSummary.category)}
					<#else>
						-
					</#if>
				</P>
			</div>
        </div>
		
		<div class="viewSummaryContentBox">
        	<div class="colWidth38">
        		<p>Brand Coverage</p>
        	</div>
        	<div class="colWidth62">
        		<P>
					<#if irisSummary.brandCoverage?? && irisSummary.brandCoverage gt 0>
						${statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].getById(irisSummary.brandCoverage).getDescription()}
					<#else>
						-
					</#if>
				</P>
			</div>
        </div>
		
		<#if irisSummary.brandCoverage?? && irisSummary.brandCoverage == statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getId()>
		<#else>
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Brand House(s)</p>
				</div>
				<div class="colWidth62">
					<P>
						<#if irisSummary.brandHouse?? && (irisSummary.brandHouse?size gt 0)  && statics['com.grail.synchro.util.SynchroUtils'].getBrandNamesInteger(irisSummary.brandHouse)!="">
							${statics['com.grail.synchro.util.SynchroUtils'].getBrandNamesInteger(irisSummary.brandHouse)}
						<#else>
							-
						</#if>
					</P>
				</div>
			</div>
		</#if>	
		
		<div class="viewSummaryContentBox">
        	<div class="colWidth38">
        		<p>Research Agency - Fieldwork</p>
        	</div>
        	<div class="colWidth62">
        		<P> 
					<#if irisSummary.fieldworkResearchAgency??  && irisSummary.fieldworkResearchAgency?size gt 0>
						${statics['com.grail.synchro.util.SynchroUtils'].getAllAgencyNames(irisSummary.fieldworkResearchAgency)}
					<#else>
						-
					</#if>
				</P>
			</div>
        </div>

		<!-- <div class="viewSummaryContentBox"> -->
			<div class="OnlyOneLine">

        	<div class="colWidth38">
        		<p>Research Agency - Coordination</p>
        	</div>
        	<div class="colWidth62">
        		<P>
					<#if irisSummary.coordinationResearchAgency?? && irisSummary.coordinationResearchAgency?size gt 0>
						${statics['com.grail.synchro.util.SynchroUtils'].getAllAgencyNames(irisSummary.coordinationResearchAgency)}
					<#else>
						-
					</#if>
				</P>
			</div>
        </div>
		
		<div class="newSectionBox">
			<div class="mainSubHeadWrap">
				<p>RESEARCH DETAILS</p>
			</div>
	   
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Fieldwork/Research Start Date</p>
				</div>
				<div class="colWidth62">
					<P>
						<#if irisSummary.fwStartDate??>
							${irisSummary.fwStartDate?string('dd/MM/yyyy')}
						<#else>
							-
						</#if>
					</P>
				</div>
			</div>

			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Fieldwork/Research End Date</p>
				</div>
				<div class="colWidth62">
					<P>
						<#if irisSummary.fwEndDate??>
							${irisSummary.fwEndDate?string('dd/MM/yyyy')}
						<#else>
							-
						</#if>
					</P>
				</div>
			</div>
			
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Final Report Date</p>
				</div>
				<div class="colWidth62">
					<P>
						<#if irisSummary.finalReportDate??>
							${irisSummary.finalReportDate?string('dd/MM/yyyy')}
						<#else>
							-
						</#if>
					</P>
				</div>
			</div>
			
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Research Background</p>
				</div>
				<div class="colWidth62">
				
						<#if irisSummary.researchBackGround?? && irisSummary.researchBackGround!="">
						
							<textarea  id="researchBackGround" disabled name="researchBackGround">${irisSummary.researchBackGround?default('')?html}</textarea>
						<#else>
							-
						</#if>
						
						<div id="researchBackGroundDiv" name="researchBackGroundDiv" style="display:none"><#if irisSummary.researchBackGround?? && irisSummary.researchBackGround!="">${irisSummary.researchBackGround}</#if></div>
				</div>
			</div>
			
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Main Research Objective</p>
				</div>
				<div class="colWidth62">
					
						<#if irisSummary.mainResearchObjective?? && irisSummary.mainResearchObjective!="">
							<textarea  id="mainResearchObjective" disabled name="mainResearchObjective">${irisSummary.mainResearchObjective?default('')?html}</textarea>
						<#else>
							-
						</#if>
					
						<div id="mainResearchObjectiveDiv" name="mainResearchObjectiveDiv" style="display:none"><#if irisSummary.mainResearchObjective?? && irisSummary.mainResearchObjective!="">${irisSummary.mainResearchObjective}</#if></div>
				</div>
			</div>
			
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Research Questions</p>
				</div>
				<div class="colWidth62">
					<#if irisSummary.researchQuestion?? && irisSummary.researchQuestion!="">
						<textarea  id="researchQuestion" disabled name="researchQuestion">${irisSummary.researchQuestion?default('')?html}</textarea>
					<#else>
						-
					</#if>
					
					<div id="researchQuestionDiv" name="researchQuestionDiv" style="display:none"><#if irisSummary.researchQuestion?? && irisSummary.researchQuestion!="">${irisSummary.researchQuestion}</#if></div>
					
				</div>
			</div>
			
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Action Standard(s)</p>
				</div>
				<div class="colWidth62">
					
					<#if irisSummary.actionStandard?? && irisSummary.actionStandard!="">
						<textarea  id="actionStandard" disabled name="actionStandard">${irisSummary.actionStandard?default('')?html}</textarea>
					<#else>
						-
					</#if>
					
					<div id="actionStandardDiv" name="actionStandardDiv" style="display:none"><#if irisSummary.actionStandard?? && irisSummary.actionStandard!="">${irisSummary.actionStandard}</#if></div>
					
				</div>
			</div>
			
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Findings</p>
				</div>
				<div class="colWidth62">
					<#if irisSummary.findings?? && irisSummary.findings!="">
						<textarea  id="findings" disabled name="findings">${irisSummary.findings?default('')?html}</textarea>
					<#else>
						-
					</#if>
					
					<div id="findingsDiv" name="findingsDiv" style="display:none"><#if irisSummary.findings?? && irisSummary.findings!="">${irisSummary.findings}</#if></div>
				</div>
			</div>
			
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Result Against Action Standards</p>
				</div>
				<div class="colWidth62">
					
					<#if irisSummary.resultAgainstActionStandard?? && irisSummary.resultAgainstActionStandard!="">
						<textarea  id="resultAgainstActionStandard" disabled name="resultAgainstActionStandard">${irisSummary.resultAgainstActionStandard?default('')?html}</textarea>
					<#else>
						-
					</#if>
					
					<div id="resultAgainstActionStandardDiv" name="resultAgainstActionStandardDiv" style="display:none"><#if irisSummary.resultAgainstActionStandard?? && irisSummary.resultAgainstActionStandard!="">${irisSummary.resultAgainstActionStandard}</#if></div>
					
				</div>
			</div>
			
			<div class="OnlyOneLine">
				<div class="colWidth38">
					<p>Conclusions</p>
				</div>
				<div class="colWidth62">
					
					<#if irisSummary.conclusion?? && irisSummary.conclusion!="">
						<textarea  id="conclusion" disabled name="conclusion">${irisSummary.conclusion?default('')?html}</textarea>
					<#else>
						-
					</#if>
					
					<div id="conclusionDiv" name="conclusionDiv" style="display:none"><#if irisSummary.conclusion?? && irisSummary.conclusion!="">${irisSummary.conclusion}</#if></div>
					
				</div>
			</div>
		</div>
		
		<#assign productTag="" />
		<#assign projectTag="" />
		
		<#assign insightTagSeqNo = 1 />
		
							
		<div class="newSectionBox researchInsightWrap">
			<div class="mainSubHeadWrap">
				<p>RESEARCH INSIGHTS</p>
			</div>
			
				<#assign showInsightsSection = "no" />
			<#if irisSummaryInsightsList?? && irisSummaryInsightsList?size gt 0>
				<#list irisSummaryInsightsList as irisSummaryInsight>
					
					<#if irisSummaryInsight.getInsightsText()?? && irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PRODUCT_TAGS_NAME>
						<#if irisSummaryInsight.getTags()?? >
							<#assign productTag=irisSummaryInsight.getTags() />
						</#if>	
					<#elseif irisSummaryInsight.getInsightsText()?? && irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PROJECT_TAGS_NAME>
						<#if irisSummaryInsight.getTags()?? >
							<#assign projectTag=irisSummaryInsight.getTags() />
						</#if>
					<#else>
						<div class="researchInsightOuterWrap">
							<div class="researchInsightContentWrap" onclick="showInsightTag(${irisSummaryInsight.getSequenceNo()})">
							  <div class="insightAccordionBox"> 
							<#--	<p><#if irisSummaryInsight.insightsHeading??>${irisSummaryInsight.insightsHeading}</#if></p> <span><i id="researchInsightCaret_${irisSummaryInsight.getSequenceNo()}" class="fa fa-angle-down"></i></span> -->
															<p><#if irisSummaryInsight.insightsHeading??>${irisSummaryInsight.insightsHeading}</#if></p> <span><i id="researchInsightCaret_${irisSummaryInsight.getSequenceNo()}" class="fa fa-plus-circle"></i></span>
							  </div>
							</div>
							
					

							<div class="insightAccordionContent" id="insightAccordionContent_${irisSummaryInsight.getSequenceNo()}" >
								
									
									
									<#if irisSummaryInsight.getInsights()??>
										<textarea  id="insights_${insightTagSeqNo}" disabled name="insights_${insightTagSeqNo}">${irisSummaryInsight.insights?default('')?html}</textarea>
									<#else>
										&nbsp;&nbsp;&nbsp;–
									</#if>
								<div id="insightsDiv_${insightTagSeqNo}" name="insightsDiv_${insightTagSeqNo}" style="display:none"> <p> <#if irisSummaryInsight.getInsights()?? && irisSummaryInsight.getInsights()!="">${irisSummaryInsight.getInsights()}<#else>–</#if> </p> </div>

								<div class="insightTagSection">TAG(S)</div>
								<div class="insightTagFlexBox">
									
									<#if irisSummaryInsight.getTags()??>
										<#list irisSummaryInsight.getTags()?split(",") as sValue>
											<#if sValue?? && sValue?trim!="">
												<div class="insightTagflexBoxContent">${sValue}</div> 
											</#if>	
										</#list>
									<#else>
										&nbsp;&nbsp;&nbsp;–	
									</#if>	
										
									
								</div>
							</div>
						</div>
							<#assign showInsightsSection = "yes" />
					</#if>	
					
					<#assign insightTagSeqNo = insightTagSeqNo + 1 />
				</#list>
			</#if>	
			
			<#if showInsightsSection == "no">
				<div class="researchInsightOuterWrap">
					<div class="researchInsightContentWrap" onclick="showInsightTag(1)">
					  <div class="insightAccordionBox"> 
					<#--	<p>Insight 1</p> <span><i id="researchInsightCaret_1" class="fa fa-angle-down"></i></span> -->
							<p>Insight 1</p> <span><i id="researchInsightCaret_1" class="fa fa-plus-circle"></i></span>
					  </div>
					</div>
					
			

					<div class="insightAccordionContent" id="insightAccordionContent_1" >
						
							
							
							&nbsp;&nbsp;&nbsp;–
						<div id="insightsDiv_1" name="insightsDiv_1" style="display:none"> <p> – </p> </div>

						<div class="insightTagSection">TAG(S)</div>
						<div class="insightTagFlexBox">
							
							&nbsp;&nbsp;&nbsp;–
								
							
						</div>
					</div>
				</div>
			</#if>	
			
			
			<div class="mainSubHeadWrap">
				<p>ADDITIONAL TAGS</p>
			</div>

			<div class="rTableTag">
				<div class="rTableRowTag">
					<div class="rTableCellLTag">PRODUCT TAG(S)</div>
					<div class="clearfix"></div>
					<div class="rTableCellRTag">
						
						<#if productTag??>
							<div class="insightTagFlexBox">
								<#assign showBlankProductTag = "yes" />
								<#list productTag?split(",") as sValue>
									<#if sValue?? && sValue?trim!="">
										<div class="insightTagflexBoxContent">${sValue}</div> 
										<#assign showBlankProductTag = "no" />	
									</#if>	
								</#list>
								<#if showBlankProductTag=="yes">
									<div class="blankProjectTarget">–</div> 
								</#if>
							</div>
						<#else>
							–
						</#if>		

					</div>
			</div>

				<div class="rTableRowTag">
					<div class="rTableCellLTag">PROJECT TAG(S)</div>
					<div class="clearfix"></div>
					<div class="rTableCellRTag">
						
						<#if projectTag??>
							<div class="insightTagFlexBox">
								<#assign showBlankProjectTag = "yes" />
								<#list projectTag?split(",") as sValue>
									<#if sValue?? && sValue?trim!="">
										<div class="insightTagflexBoxContent">${sValue}</div> 
										<#assign showBlankProjectTag = "no" />	
									</#if>	
								</#list>
								<#if showBlankProjectTag=="yes">
									<div  class="blankProjectTarget">–</div> 
								</#if>
							</div>
						<#else>
							–	
						</#if>	
					</div>
				</div>

			  </div>
		   
       <#--           <div class="topInnerWrapBox">
                       <div class="rTable">
							<div class="rTableRow">
								<div class="rTableHead"><strong>INSIGHTS</strong></div>
								<div class="rTableHead"><strong>TAG(S)</strong></div>
							</div>
							
							<#assign productTag="" />
							<#assign projectTag="" />
							<#if irisSummaryInsightsList?? && irisSummaryInsightsList?size gt 0>
								<#list irisSummaryInsightsList as irisSummaryInsight>
									
									<#if irisSummaryInsight.getInsightsText()?? && irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PRODUCT_TAGS_NAME>
										<#if irisSummaryInsight.getTags()?? >
											<#assign productTag=irisSummaryInsight.getTags() />
										</#if>	
									<#elseif irisSummaryInsight.getInsightsText()?? && irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PROJECT_TAGS_NAME>
										<#if irisSummaryInsight.getTags()?? >
											<#assign projectTag=irisSummaryInsight.getTags() />
										</#if>
									<#else>
										<div class="rTableRow">
											<div class="rTableCell">
												<ul><li><#if irisSummaryInsight.getInsights()??>${irisSummaryInsight.getInsights()}</#if></li></ul>
											</div>
											<div class="rTableCell"><#if irisSummaryInsight.getTags()??>${irisSummaryInsight.getTags()}</#if>
											</div>							
										</div>
									</#if>	
								</#list>
							</#if>	
							

						</div>
					</div>

                      <div class="belowInnerWrapBox">
						  <div class="rTable">
							<div class="rTableRow">
								<div class="rTableHead"><strong>PRODUCT TAG(S)</strong></div>
								<div class="rTableHead"><strong>PROJECT TAG(S)</strong></div>
							</div>
							<div class="rTableRow">
								<div class="rTableCell">
									<ul><li>${productTag}</li></ul>
								</div>
								<div class="rTableCell">${projectTag}</div>							
							</div>

						</div>
               	     </div> -->

		</div>
		
		<div class="newSectionBox">
			<div class="mainSubHeadWrap">
				<p>SUMMARY DETAILS</p>
			</div>
	   
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Blurb</p>
				</div>
				<div class="colWidth62">
					
					<#if irisSummary.blurbs?? && irisSummary.blurbs!="">
						<textarea  id="blurbs" disabled name="blurbs">${irisSummary.blurbs?default('')?html}</textarea>
					<#else>
						-
					</#if>
				
					<div id="blurbsDiv" name="blurbsDiv" style="display:none"><#if irisSummary.blurbs?? && irisSummary.blurbs!="">${irisSummary.blurbs}</#if></div>
					
				</div>
			</div>

			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Summary Written By</p>
				</div>
				<div class="colWidth62">
					<P>
						<#if irisSummary.summaryWrittenByName?? && irisSummary.summaryWrittenByName!="">
							${irisSummary.summaryWrittenByName}
						<#else>
							-
						</#if>
					</P>
				</div>
			</div>
			
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Designation</p>
				</div>
				<div class="colWidth62">
					<P>
						<#if irisSummary.summaryDesignation?? && irisSummary.summaryDesignation!="">
							${irisSummary.summaryDesignation}
						<#else>
							-
						</#if>
					</P>
				</div>
			</div>
			
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Agency Name</p>
				</div>
				<div class="colWidth62">
					<P>
						<#if irisSummary.summaryAgencyName?? && statics['com.grail.synchro.util.SynchroUtils'].getAllResearchAgencyFields().get(irisSummary.summaryAgencyName)??>
							
							${statics['com.grail.synchro.util.SynchroUtils'].getAllResearchAgencyFields().get(irisSummary.summaryAgencyName)}
					
						<#else>
							-
						</#if>
					</P>
				</div>
			</div>
			
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Summary Completion Date</p>
				</div>
				<div class="colWidth62">
					<P>
						<#if irisSummary.summaryCompletionDate??>
							${irisSummary.summaryCompletionDate?string('dd/MM/yyyy')}
						<#else>
							-
						</#if>
					</P>
				</div>
			</div>
			
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Summary Approved By</p>
				</div>
				<div class="colWidth62">
					<P>
						<#if irisSummary.summaryApprovedBy?? && irisSummary.summaryApprovedBy!="">
							${irisSummary.summaryApprovedBy}
						<#else>
							-
						</#if>
					</P>
				</div>
			</div>
			
			<div class="viewSummaryContentBox">
				<div class="colWidth38">
					<p>Summary Approval Date</p>
				</div>
				<div class="colWidth62">
					<P>
						<#if irisSummary.summaryApprovalDate??>
							${irisSummary.summaryApprovalDate?string('dd/MM/yyyy')}
						<#else>
							-
						</#if>
					</P>
				</div>
			</div>
			
			<!--<div class="viewSummaryContentBox"> -->
				<div class="OnlyOneLine">
				<div class="colWidth38">
					<p>Related Studies</p>
				</div>
				<div class="colWidth62">
					<P>
						<#assign showRelatesStudies = "no" />
						<#if irisSummary.relatedStudies?? && irisSummary.relatedStudies!="">
							<#assign relatedStudiesMap = statics['com.grail.util.BATUtils'].getIRISSummaryRelateStudiesName(irisSummary.relatedStudies)>
							
							<#assign counter = 1>
							<#if relatedStudiesMap?? && relatedStudiesMap?size gt 0 >
								
								<#list relatedStudiesMap.keySet() as relatedStudiesName>
									<#if relatedStudiesName!="">
										<#assign showRelatesStudies = "yes" />
										<a href="${relatedStudiesMap.get(relatedStudiesName)}" target="_blank">${relatedStudiesName}</a><#if relatedStudiesMap.size() gt counter>,</#if>
										<#assign counter = counter + 1>
									</#if>	
									
								</#list>
								<#if showRelatesStudies =="no" && irisSummary.relatedStudies?? && irisSummary.relatedStudies!="">
									${irisSummary.relatedStudies}
									<#assign showRelatesStudies = "yes" />
								</#if>
							<#else>
								<#if irisSummary.relatedStudies?? && irisSummary.relatedStudies!="">
									${irisSummary.relatedStudies}
									<#assign showRelatesStudies = "yes" />
								</#if>
							</#if>	
						
						</#if>
						
						<#if showRelatesStudies == "no" >
							-
						</#if>
					</P>
				</div>
			</div>
			
		</div>
		
		
</div>  <!--End colWidth75 div -->

</div>


		<div class="colWidth25">
		      
		      <div class="attachmentBox">

		      	<p class="mainHeading">Download and Share</p>
		      	 <div class="attachInnerWrap">

			      	<p>Attached Report(s)</p>

                    <#if irisSummaryAttachments?? && irisSummaryAttachments?size gt 0>  
						<#list irisSummaryAttachments as attachment>
							<div class="attachLabelWrap attachedReportBox">
								<#--<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.irisSummaryId?c}-${attachment.attachmentId?c}/${attachment.fileName?url}" />"> -->
														
								<#assign attachFileExt ="">
								<#assign imageIconURL = themePath + "/images/iris/icon-file.png">		
								<#list attachment.fileName?html?split(".") as sValue>
									<#assign attachFileExt = sValue>		
								</#list>
								
								<#if attachFileExt=="ppt" || attachFileExt=="pptx" >
									<#assign imageIconURL = "/themes/rkp_theme/images/osp/oracle/icon-file-ppt.png">		
								</#if>
								<#if attachFileExt=="doc" || attachFileExt=="docx" >
									<#assign imageIconURL = "/themes/rkp_theme/images/osp/oracle/icon-file-word.png">		
								</#if>
								<#if attachFileExt=="xls" || attachFileExt=="xlsx" || attachFileExt=="xlsm">
									<#assign imageIconURL = "/themes/rkp_theme/images/osp/oracle/icon-file-excel.png">		
								</#if>
								<#if attachFileExt=="txt" >
									<#assign imageIconURL = "/themes/rkp_theme/images/osp/oracle/icon-file-txt.png">		
								</#if>
								<#if attachFileExt=="jpeg" || attachFileExt=="jpg" || attachFileExt=="png" || attachFileExt=="gif">
									<#assign imageIconURL = "/themes/rkp_theme/images/osp/oracle/icon-file-img.png">		
								</#if>
								<#if attachFileExt=="zip" || attachFileExt=="rar" >
									<#assign imageIconURL = "/themes/rkp_theme/images/osp/oracle/icon-file-zip.png">		
								</#if>
								<#if attachFileExt=="pdf">
									<#assign imageIconURL = "${themePath}/images/iris/pdf-icon.png">		
								</#if>
								 
								 <img src="${imageIconURL}" width="25" height="25"><span class="attachSpanContent">${attachment.fileName?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.fileSize)}) </span>
							
								 <label class="checkboxContainer">
		                           <input type="checkbox" class="attachmentCheckbox allCheckBoxes" value="${attachment.attachmentId?c}">
		                           <span class="checkmark"></span>
		                         </label>
							</div>
						</#list>
					</#if>	
					
					<div class="SummaryPdfSection">
					   <p>Summary PDF</p>
						<div class="attachLabelWrap">														
							  <img src="${themePath}/images/iris/pdf-icon.png" width="25" height="25"><span class="attachSpanContent">${irisSummary.projectName}</span>
														
							 <label class="checkboxContainer">
							   <input type="checkbox" class="attachmentCheckbox1 allCheckBoxes" value="${irisSummaryId?c}">
							   <span class="checkmark"></span>
							 </label>
						</div>
					 </div>

                  <div class="textColorBlueBox" style="cursor: default;pointer-events: none;">
                    <a href="javascript:void(0);" onclick="downloadAttachments();" >
                      <img src="/themes/rkp_theme/images/iris/download-icon.png" width="16" height="18">
                      <span class="pl8">Start Download</span>
                    </a>
                  </div>

                   <div class="shareLinkBox">
                    
					<!--<a  href="mailto:assistance@batinsights.com?subject=Research&attachment=D:\\IRIS\\Client-Documents\\3-MAY\\IRIS-Summary-Template_03.05.2018.xlsm">-->
					<#assign emailSubject = "Sharing "+ irisSummary.projectName />
					<#assign emailBody = "Hey! Check this out! "+ irisSummary.projectName />
					
					 <#assign hyperlink = JiveGlobals.getJiveProperty("jiveURL","") + "/iris-summary/view-summary!input.jspa?irisSummaryId=${irisSummary.irisSummaryId?c}" />

					   <#assign bText = irisSummary.blurbsText?replace('&gt;', ' ', 'r') />
					   
					   <#assign bText = bText?replace("'","apostrophescommas") />
					   
					   <#assign bText = bText?replace('&amp;gt;', ' ', 'r') />
					   <#assign bText = bText?replace('&#10;', ' ', 'r') />
					   <#assign bText = bText?replace('>', ' ', 'r') />
					   <#assign bText = bText?replace('&', ' ', 'r') />
					   
					   <#assign emailBody1 = bText?default('')?html />
					   
					  
					   
						<#assign cName ="-" />
						<#assign mName ="-" />
						<#assign bName ="-" />
						<#assign categoryNames ="-" />
						
						<#--
						<#if irisSummary.containerId?? && irisSummary.containerId == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER>
							<#assign cName = statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER_NAME />
						<#elseif irisSummary.containerId?? && irisSummary.containerId == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL>
							<#assign cName = statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL_FOLDER_NAME />
						<#elseif irisSummary.containerId?? && irisSummary.containerId == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL>
							<#assign cName = statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL_FOLDER_NAME />
						<#elseif irisSummary.containerId?? && statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(irisSummary.containerId)??>
							<#assign cName = statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(irisSummary.containerId) />
						</#if>	
						-->
						
						<#if irisSummary.endMarketId?? && irisSummary.endMarketId?size gt 0>
							<#assign cName = statics['com.grail.synchro.util.SynchroUtils'].getAllEndMarketNames(irisSummary.endMarketId) />
							<#if cName=="" || cName =" ">
								<#assign cName ="-" />
							<#elseif cName?contains(",")>
								<#assign cName ="Multiple End Markets" />
							</#if>
						</#if>
						
						<#if irisSummary.methodology?? && irisSummary.methodology?size gt 0>
							<#assign mName = statics['com.grail.synchro.util.SynchroUtils'].getAllMethodologyNames(irisSummary.methodology) />
							<#if mName=="" || mName =" ">
								<#assign mName ="-" />
							</#if>
						</#if>
						
						<#if irisSummary.brandCoverage??  && (irisSummary.brandCoverage gt 0) && irisSummary.brandCoverage == statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getId() >
							<#assign bName = statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].NON_BRAND_RELATED.getDescription() />
						<#elseif irisSummary.brandCoverage??  && (irisSummary.brandCoverage gt 0) && irisSummary.brandCoverage == statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getId() >
							<#if irisSummary.brandHouse?? && irisSummary.brandHouse?size gt 0>
								<#assign bName = statics['com.grail.synchro.util.SynchroUtils'].getBrandNamesInteger(irisSummary.brandHouse) />
							<#else>
								<#assign bName = statics['com.grail.util.BATConstants$IRISSummaryBrandCoverage'].MULTI_BRAND.getDescription() />
							</#if>
							
						<#elseif irisSummary.brandHouse?? && irisSummary.brandHouse?size gt 0>
							<#assign bName = statics['com.grail.synchro.util.SynchroUtils'].getBrandNamesInteger(irisSummary.brandHouse) />
						</#if>
						
						<#if bName=="" || bName =" ">
								<#assign bName ="-" />
						</#if>
							
						<#if irisSummary.category?? && irisSummary.category?size gt 0>
							<#assign categoryNames = statics['com.grail.synchro.util.SynchroUtils'].getCategoryNamesInteger(irisSummary.category) />
						</#if>
						
						<#if categoryNames=="" || categoryNames =" ">
								<#assign categoryNames ="-" />
						</#if>
						
						
						<#assign metaData= cName + " | " + mName + " | " + bName /> 
						
						
						<#assign reports ="Report Date:" />
						<#if irisSummary.finalReportDate??>
							<#assign reports = reports +  irisSummary.finalReportDate?string('dd/MM/yyyy')/>
						</#if>
						<#assign reports = reports +  " | Synchro ID:" />
						<#if irisSummary.synchroCode?? && irisSummary.synchroCode gt 0> 
							<#assign reports = reports +  irisSummary.synchroCode?c/> 
						<#else>
							<#assign reports = reports +  " - "/> 
						</#if>
					   <#assign reports =  metaData + " | " + reports +  " | Category:" + categoryNames  />
					   
					   <#assign pName = irisSummary.projectName?replace("'","apostrophescommas")>
						
						<a id="link"><img src="/themes/rkp_theme/images/iris/share-icon.png" width="16" height="18">
								<span class="pl8">Share</span>
						</a> 
						
					
                  </div>

				  <script>

                 	 
				
					  /*
					   var strLink = "Hello,"+'%0D%0A%0D%0A'+"Trust you are doing great!"+'%0D%0A%0D%0A'+"Sharing a link to the IRIS summary below:"+'%0D%0A%0D%0A'+'${irisSummary.projectName}' +" (  "+'${hyperlink}'+"  )"+'%0D%0A%0D%0A'+ '${emailBody1?j_string}' + '%0D%0A%0D%0A'+'${metaData}'+'%0D%0A'+'${reports}'+'%0D%0A%0D%0A'+"Do let me know in case of any assistance.";
					   */
					   
					   var eBobdy = '${emailBody1?j_string}';
					   
					   eBobdy = (eBobdy.length && eBobdy[0] == ' ') ? eBobdy.slice(1) : eBobdy;
					   
					   var projectNameJS = '${pName?j_string}'
					   
					  /*  var strLink = "Hi,"+'%0D%0A%0D%0A'+"Please find attached the link for the report on \'"+'${irisSummary.projectName}'+"\', I thought you might find it interesting!"+'%0D%0A%0D%0A'+"You can access this report through the link: " +'${hyperlink}'+'%0D%0A%0D%0A'+ "Project Overview-"+'%0D%0A%0D%0A'+eBobdy.replace(/apostrophescommas/g, "'") + '%0D%0A%0D%0A'+"Other Project Information-"+'%0D%0A%0D%0A'+ '${reports}'+'%0D%0A%0D%0A'+"Regards,"+'%0D%0A%0D%0A'+'${user.getFirstName()}'+" "+'${user.getLastName()}';
					  
					  */
					   
					    var strLink = "Hi,"+'%0D%0A%0D%0A'+"Please find attached the link for the report on \'"+projectNameJS.replace(/apostrophescommas/g, "'")+"\', I thought you might find it interesting!"+'%0D%0A%0D%0A'+"You can access this report through the link: " +'${hyperlink}'+'%0D%0A%0D%0A'+ "Project Overview-"+'%0D%0A%0D%0A'+eBobdy.replace(/apostrophescommas/g, "'") + '%0D%0A%0D%0A'+"Other Project Information-"+'%0D%0A%0D%0A'+ '${reports}'+'%0D%0A%0D%0A'+"Regards,"+'%0D%0A%0D%0A'+'${user.getFirstName()}'+" "+'${user.getLastName()}';
						
                      strLink = "mailto:?subject=${emailSubject}&body="+strLink;
                      document.getElementById("link").setAttribute("href",strLink);
					  
					 
                  </script>


                  </div>
			  </div>

        </div>  <!--End colWidth25 div -->




 <!-- Start end market Filter for Move Summary  -->

	<div class="popup" end-market="Popup-Move-Summary" id="move-summary-div">
 <!-- Below div is added to set the Pop-up position on Advance search page -->
    <div class="setPopupPosition"> 

        <div  class="move-popup-inner">

            <div class="checkbox-popup-wrapper">
                <div class="search-field">
                    <input type='text' id='txtList' onkeyup="filter(this)" placeholder="Search Space" />
                    <a class="popup-close" data-popup-close="Popup-Move-Summary" id="move-summary-close-div" href="#"><img class="popupCrossBtn" src="${themePath}/images/iris/cross-icon.png"></a>
                </div>
                <div class="search-result-end-market-popup">                
					
                    <div class="checkboxes-list-dd">
                        <ul id="checkBoxes" class="fromList">
						<#assign endMarketRegions = statics['com.grail.synchro.SynchroGlobal'].getRegionEndMarketsMapping() />
							
							<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
							<#assign endMarketRegionsKeySet = endMarketRegions.keySet() />
							<#if (endMarketRegions?has_content)>
								<#list endMarketRegionsKeySet as key>
									<#assign region = statics['com.grail.synchro.SynchroGlobal'].getRegions().get(key) />
									<#if region=="Global">
									<#else>
										
										<li>
											<label class="popUpLabel">${region}</label>
											<ul>
												<#assign endMarketKeySet = endMarketRegions.get(key).keySet() />
												<#list endMarketKeySet as endMarketkey>
													
													<li>
														<label class="checkboxContainer">${endMarkets.get(endMarketkey)}
														
														<input type="radio" name="moveSummaryFilter" id="${endMarketkey}" value="${endMarkets.get(endMarketkey)}" class="moveSummaryFilterClass">
														<span class="checkmark"></span>
														</label>
													</li>
												 </#list>
											</ul>
										</li>
									</#if>	 
								</#list>
								
								
								<li>
									<label class="popUpLabel">Above Market</label>
									<ul>
										<li>
											<label class="checkboxContainer">${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL_FOLDER_NAME}
											<input type="radio" name="moveSummaryFilter" id="${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL}" value="${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL_FOLDER_NAME}" class="moveSummaryFilterClass">
											<span class="checkmark"></span>
										</li>
										<li>
											<label class="checkboxContainer">${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL_FOLDER_NAME}
											<input type="radio" name="moveSummaryFilter" id="${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL}" value="${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL_FOLDER_NAME}" class="moveSummaryFilterClass">
											<span class="checkmark"></span>
										</li>
									</ul>
								</li>	
							
								<li>
									<label class="popUpLabel">${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER_NAME}</label>
									<ul>
										<li>
											<label class="checkboxContainer">${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER_NAME}
											<input type="radio" name="moveSummaryFilter" id="${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER}" value="${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER_NAME}" class="moveSummaryFilterClass">
											<span class="checkmark"></span>
										</li>		
									</ul>
								</li>
										
							
								
							</#if>                         
                        </ul>
                    </div>
                </div>
            </div>
        </div>
</div>
    </div>

    <!-- End end market Filter -->
		 

  </div>
  </div>

  </div>

<div class="successPopupwrap">
	<div id="dialogOverlay">
	   <div class="dialogBoxWrap">
	   	 <div class="successDialogWrap">
	   		<img src="${themePath}/images/iris/green-tick.png">
	   		<h5> <b>Published</b> </h5>
	      <div>
	   		 <div class="dialogBtnBox">
			   <p class="okBtn" onclick="showViewPage();">OK</p>

			  
			   <p>Summary successfully published in <a href='/iris-summary/admin-home.jspa' target="_blank">Admin Panel</a> > <a href='/iris-summary/container-regions.jspa' target="_blank">Spaces</a> >  <span id="summaryPublished"></span>  </p>


		     </div>
		  </div>
	   	</div>
	   </div> 
	</div>
</div>

<div id="dialogOverlayDelete">
   <div class="dialogBoxWrap">
   	 <div class="dialogInnerWrap">
   		<h5> Are you sure you want to delete the summary?</h5>
      <div>
   		 <div class="dialogBtnBox">
   		 	<a href="#" onclick="closeDialog();">CANCEL</a>
		   <a href="#" onclick="confirmDelete();">DELETE</a>
	     </div>
	  </div>
   	</div>
   </div> 
</div>


<div class="successPopupwrap">
	<div id="dialogOverlayMove">
	   <div class="dialogBoxWrap">
	   	 <div class="successDialogWrap">
	   		<h5> <span id="summaryMove"></span> </h5>
	      <div>
	   		 <div class="dialogBtnBox">
			   <p onclick="closeDialog();" class="moveDialogBtn moveDialogBtnNo">NO</p>	
			   <p onclick="moveDialogYesOption();" class="moveDialogBtn">YES</p>	  			 
		     </div>
		  </div>
	   	</div>
	   </div> 
	</div>
</div>

  
 
  <div class="fileAttachmentHiddenForm">
	<form id="file-attachment-form" action="/iris-summary/view-summary!download.jspa" method="POST" class="result-form-popup ">
		<input type="hidden" name="downloadAttachmentIds" id="downloadAttachmentIds" value="" />
		<input type="hidden" name="irisSummaryId" id="irisSummaryId" value="${irisSummary.irisSummaryId?c}" >
		<input type="hidden" name="downloadIRISSummaryPDF" id="downloadIRISSummaryPDF" value="" >
	</form>

	<form id="iris-summary-move-Form" action="/iris-summary/view-summary!moveSummary.jspa" method="POST" class="result-form-popup ">
		<input type="hidden" name="irisSummaryId" id="irisSummaryId" value="${irisSummary.irisSummaryId?c}" >
		<input type="hidden" name="containerId" id="containerId" value="" >			
	</form>
				
  </div>

  <script type="text/javascript">
	
$j(document).ready(function(){

   $j('.dialogBoxWrap .dialogBtnBox p.okBtn').click(function(){
   	     $j('#dialogOverlay').hide();
   });

    $j('.dialogBoxWrap .dialogBtnBox a').click(function(){
   	     $j('#dialogOverlayDelete').hide();
   });

    $j('#dialogOverlayMove .moveDialogBtnNo').click(function(){
   	     $j('#dialogOverlayMove').hide();
   });

  $j('#summaryPublished').html(message);

});

</script>
  
    <script type="text/javascript">
  function deleteSummary() {

  	$j('#dialogOverlayDelete').show();

    // dialog({
    //     title: 'Confirm Delete',
    //     html: '<p>Are you sure you want to delete the summary?</p>',
    //     buttons:{
    //         "DELETE":function() {
    //             confirmDelete();
    //         },
    //         "CANCEL": function() {
    //             closeDialog();
    //         }
    //     }
    // });

}	
	function downloadAttachments()
	{
		
		var downloadAttachmentIds = [];
		var downloadIRISSummaryPDF = "";
		
		
		
		$j('.attachmentCheckbox').each(function(){

            if($j(this).prop("checked") == true)
			{
				//alert($j(this).val());
                //location.href=$j(this).val();
				downloadAttachmentIds.push($j(this).val());
            }

            });
			
		$j('.attachmentCheckbox1').each(function(){

            if($j(this).prop("checked") == true)
			{
				//alert($j(this).val());
                //location.href=$j(this).val();
				downloadIRISSummaryPDF="yes";
            }

            });	
		
		
		console.log("downloadAttachmentIds==>"+downloadAttachmentIds);
		if(downloadAttachmentIds.length!=0 || downloadIRISSummaryPDF=="yes" )
		{
			$j("#downloadAttachmentIds").val(downloadAttachmentIds);
			$j("#downloadIRISSummaryPDF").val(downloadIRISSummaryPDF);
			
			var downloadFileForm = jQuery("#file-attachment-form");
			downloadFileForm.submit();
		}
	}
	

function confirmDelete() {
    location.href="/iris-summary/view-summary!deleteSummary.jspa?irisSummaryId=${irisSummaryId?c}";
}
 
	$j('[data-popup-move-summary]').on('click', function(e) {
          	$j("#move-summary-div").fadeIn(350);
		});	 
	
	$j('#move-summary-close-div').on('click', function(e) {
          	$j("#move-summary-div").fadeOut(500);
		});	 
		
	$j('.moveSummaryFilterClass').on('click', function(e) {
          	
			 selectedContainer = "${selectedContainerName}";
			 contId = $j(this).id();
			    currval=$j(this).val();

				$j('#dialogOverlayMove').show();


         $j('#summaryMove').html('<div>Are you sure you want to move the summary from <a href="javascript:void(0)">Admin </a> > <a href="javascript:void(0)">Spaces</a> > <a href="/iris-summary/container-iris-summaries.jspa?endMarketID=${irisSummary.getContainerId()}" target="_blank">'+selectedContainer+'</a> to <a href="javascript:void(0)">Admin</a> > <a href="javascript:void(0)">Spaces</a> > <a href="/iris-summary/container-iris-summaries.jspa?endMarketID='+contId+'" target="_blank">'+$j(this).val()+'</a>?</div>');
        



		   });		

			function moveDialogYesOption(){
               
				var irisSummaryMoveForm = $j("#iris-summary-move-Form");
						$j("#containerId").val(contId);
						
						irisSummaryMoveForm.submit();

			}
			
			// dialog({
			// 	title: 'Move Summary',
			// 	<!-- html: '<p>Are you sure you want to move the summary from '+selectedContainer+' to '+$j(this).val()+'</p>', -->
			// 	html: '<p>Are you sure you want to move the summary from <a href="javascript:void(0)">Admin </a> > <a href="javascript:void(0)">Spaces</a> > <a href="/iris-summary/container-iris-summaries.jspa?endMarketID=${irisSummary.getContainerId()}" target="_blank">'+selectedContainer+'</a> to <a href="javascript:void(0)">Admin</a> > <a href="javascript:void(0)">Spaces</a> > <a href="/iris-summary/container-iris-summaries.jspa?endMarketID='+contId+'" target="_blank">'+$j(this).val()+'</a>?</p>',
			// 	buttons:{
			// 		"YES":function() {
			// 			var irisSummaryMoveForm = $j("#iris-summary-move-Form");
			// 			$j("#containerId").val(contId);
						
			// 			irisSummaryMoveForm.submit();
			// 		},
			// 		"NO": function() {
			// 			closeDialog();
			// 		}
			// 	}
			// });
			
	
		
function confirmDelete() 
{
    location.href="/iris-summary/view-summary!deleteSummary.jspa?irisSummaryId=${irisSummaryId?c}";
}
	
function filter(element)
{
    var value = $j(element).val();
    $j(".fromList li").each(function() {
        if ($j(this).text().search(new RegExp(value, "i")) > -1) {
            $j(this).show();
        } else {
            $j(this).hide();
        }
    });
}

function showInsightTag(insightTagRowCounter)
	{
		
		/*
		if ($j('#researchInsightCaret_'+insightTagRowCounter).hasClass('fa-angle-down')) {
			$j('#researchInsightCaret_'+insightTagRowCounter).removeClass('fa-angle-down').addClass('fa-angle-up');
			$j('#insightAccordionContent_'+insightTagRowCounter).show();
  
		}else{
			$j('#researchInsightCaret_'+insightTagRowCounter).removeClass('fa-angle-up').addClass('fa-angle-down');
			$j('#insightAccordionContent_'+insightTagRowCounter).hide();
		}
		*/
			if ($j('#researchInsightCaret_'+insightTagRowCounter).hasClass('fa-minus-circle')) {
			$j('#researchInsightCaret_'+insightTagRowCounter).removeClass('fa-minus-circle').addClass('fa-plus-circle');
			$j('#insightAccordionContent_'+insightTagRowCounter).hide();
  
		}else{
			$j('#researchInsightCaret_'+insightTagRowCounter).removeClass('fa-plus-circle').addClass('fa-minus-circle');
			$j('#insightAccordionContent_'+insightTagRowCounter).show();
		}
	}
	
	$j(document).ready(function () {
		
		//alert("rwad");
		<#if irisSummaryInsightsList?? && irisSummaryInsightsList?size gt 0>
			<#list irisSummaryInsightsList as irisSummaryInsight>
				showInsightTag('${irisSummaryInsight.getSequenceNo()}');
			</#list>
		<#else>
			showInsightTag('1');
		</#if>		
		
	});

	function setTextAreaIE(iFrameName)
	{

		
		var x = document.getElementById(iFrameName);
		if(x!=null && x!=undefined)
		{
			var y = x.contentDocument;
			//var m = y.body.style.height;
			var m = (y.body.clientHeight) - 26;
			
			document.getElementById(iFrameName).style.height = m+'px';
		}	
	}
	
	
	function setTextArea(iFrameName)
	{
		
		var x = document.getElementById(iFrameName);
		if(x!=null && x!=undefined)
		{
			var y = x.contentDocument;
			//var m = y.body.style.height;
			var m = (y.body.clientHeight);
			
			document.getElementById(iFrameName).style.height = m+'px';
		}	
	}
	
	var ua = navigator.userAgent;
	//alert("ua"+ua);
    var msie = ua.indexOf("Trident/7.0");
	
	$j(function(){





		$j(window).on('pageshow',function() {


            if(msie!=-1)
            {
                     

            	 setTimeout(function(){ setTextAreaIE("methodologyDesc_ifr"); }, 100);
			setTimeout(function(){ setTextAreaIE("targetGroup_ifr"); }, 100);
			setTimeout(function(){ setTextAreaIE("sampleSize_ifr"); }, 100);
			setTimeout(function(){ setTextAreaIE("researchBackGround_ifr"); }, 100);
			setTimeout(function(){ setTextAreaIE("mainResearchObjective_ifr"); }, 100);
			setTimeout(function(){ setTextAreaIE("researchQuestion_ifr"); }, 100);
			
			setTimeout(function(){ setTextAreaIE("actionStandard_ifr"); }, 100);
			setTimeout(function(){ setTextAreaIE("findings_ifr"); }, 100);
			setTimeout(function(){ setTextAreaIE("resultAgainstActionStandard_ifr"); }, 100);
			setTimeout(function(){ setTextAreaIE("conclusion_ifr"); }, 100);
			setTimeout(function(){ setTextAreaIE("blurbs_ifr"); }, 100);
		
		
		
			<#if irisSummaryInsightsList?? && irisSummaryInsightsList?size gt 0>
				<#assign insightTagCounter = 1 />

				<#list irisSummaryInsightsList as irisSummaryInsight>
						
					<#if irisSummaryInsight.getInsightsText()?? && irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PRODUCT_TAGS_NAME>
					
					<#elseif irisSummaryInsight.getInsightsText()?? && irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PROJECT_TAGS_NAME>
					
					<#else>
						var insightTextArea = 'insights_'+${insightTagCounter}+'_ifr';
						
						//console.log("insightTextArea==>"+insightTextArea);
					//	alert("insightTextArea==>"+insightTextArea);
						
						setTimeout(function(){ setTextAreaIE('insights_'+${insightTagCounter}+'_ifr'); }, 100);
						<#assign insightTagCounter = insightTagCounter + 1 />
					</#if>	
				</#list>	
			</#if>



            }
            else
            {

               setTimeout(function(){ setTextArea("methodologyDesc_ifr"); }, 100);
			setTimeout(function(){ setTextArea("targetGroup_ifr"); }, 100);
			setTimeout(function(){ setTextArea("sampleSize_ifr"); }, 100);
			setTimeout(function(){ setTextArea("researchBackGround_ifr"); }, 100);
			setTimeout(function(){ setTextArea("mainResearchObjective_ifr"); }, 100);
			setTimeout(function(){ setTextArea("researchQuestion_ifr"); }, 100);
			
			setTimeout(function(){ setTextArea("actionStandard_ifr"); }, 100);
			setTimeout(function(){ setTextArea("findings_ifr"); }, 100);
			setTimeout(function(){ setTextArea("resultAgainstActionStandard_ifr"); }, 100);
			setTimeout(function(){ setTextArea("conclusion_ifr"); }, 100);
			setTimeout(function(){ setTextArea("blurbs_ifr"); }, 100);
		
		
		
			<#if irisSummaryInsightsList?? && irisSummaryInsightsList?size gt 0>
				<#assign insightTagCounter = 1 />

				<#list irisSummaryInsightsList as irisSummaryInsight>
						
					<#if irisSummaryInsight.getInsightsText()?? && irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PRODUCT_TAGS_NAME>
					
					<#elseif irisSummaryInsight.getInsightsText()?? && irisSummaryInsight.getInsightsText()==statics['com.grail.util.BATConstants'].IRIS_SUMMARY_PROJECT_TAGS_NAME>
					
					<#else>
						var insightTextArea = 'insights_'+${insightTagCounter}+'_ifr';
						
						//console.log("insightTextArea==>"+insightTextArea);
					//	alert("insightTextArea==>"+insightTextArea);
						
						setTimeout(function(){ setTextArea('insights_'+${insightTagCounter}+'_ifr'); }, 100);
						<#assign insightTagCounter = insightTagCounter + 1 />
					</#if>	
				</#list>	
			</#if>




            }

			


			
			
				
			
		});
		});
		
	
	
	
  </script>
  
  
  
  
  
  
  
 
 
 
 
 



