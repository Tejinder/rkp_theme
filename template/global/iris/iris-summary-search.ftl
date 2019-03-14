<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#-- DWR def -->
<head>

   
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







		<!-- <div class="img-container">
			<img src="images/GrailLogo.png"> 
		</div>-->
		<!-- <div id="j-header" class="logo-align-center">
		<a class="j-header-logo align-top-logo" href="/iris-summary/search-summary!input.jspa"></a>
		</div> -->
<div class="searchBgImg">

	    <div class="searchBarContainer">

	<!--  <form method="POST" name="searchIRISSummaryForm" id="searchIRISSummaryForm" action="/iris-summary/search!execute.jspa">
   			<div class="form-alignment">
			    <div class="search">
					  <span class="fa fa-search"></span>
					  <input type="text" name="searchText" value="">
					  
					  
					  <button class="j-btn-callout btnSearch-align">Search</button><span><i class="fa fa-filter" aria-hidden="true"></i></span>
				</div>
				<input class="j-btn-callout btnSearch-by-field-align" type="submit" name="Submit" value="Search by Fields" />
			</div>						
		</form> -->

	         <div class="searchBarLogo"></div>
				<form method="POST" name="searchIRISSummaryForm" id="searchIRISSummaryForm" action="/iris-summary/search-results-open!execute.jspa">
		           <input type="Search" name="searchText" id="searchText" placeholder="Enter Keywords for Search" onfocus="this.placeholder = ''" onblur="this.placeholder ='Enter Keywords for Search' " autocomplete="off" />
				   
		             <a class="searchBarSearchText" onclick="return searchIRIS();"><span>SEARCH</span> <i class="fa fa-search"></i></a>
					 
					 <!--	<span class="searchBarInfoIcon"></span> -->
		        </form> 


         </div>
</div>

<div class="successPopupwrap dialogAdvance">
	<div id="dialogOverlayDataInfo">
	   <div class="dialogBoxWrap">
	   	 <div class="successDialogWrap">   		
	   		<h5> <b>The search tips are under development.</b> </h5>
	      <div>
	   		 <div class="dialogBtnBox">
			   <p class="okBtn">OK</p>	
		     </div>
		  </div>
	   	</div>
	   </div> 
	</div>
</div>
  

<script>
	function searchIRIS()
	{
		if($j("#searchText").val()=="")
		{
			dialog({title:"Message",html:"Please enter keyword for Search"});
			return false;
		}
		else
		{
			var searchIRISSummaryForm = $j("#searchIRISSummaryForm");
			searchIRISSummaryForm.submit();
			
		}
	}
</script>

<!-- The below script will remove the scroll bar and stretcheness of the background image -->

<script type="text/javascript">
    
    $j(document).ready(function(){
	
	$j('.searchBarInfoIcon').click(function(){
  		$j('#dialogOverlayDataInfo').show();
  	})
    $j('.dialogBoxWrap .dialogBtnBox p').click(function(){
   	     $j('#dialogOverlayDataSuccess').hide();
   	     $j('#dialogOverlayDataInfo').hide();
   });
   
       var windowHeight = $j(window).height();
       var headerHEight = $j('#j-header-wrap').height();
       var headerLineHeight = $j('.header-top-page-wrapper').height();
       var footerHeight = $j('footer').height();
       var sumOfHeight = (headerHEight + headerLineHeight + footerHeight);
       var middleContentHeight = (windowHeight) - (sumOfHeight);
       $j('.searchBgImg').css('height',middleContentHeight);    

    });

</script>