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




<div class="searchBgImg">

	    <div class="searchBarContainer">

	

	         <div class="searchBarLogo"></div>
				<form method="POST" name="searchIRISSummaryForm" id="searchIRISSummaryForm" action="/iris-summary/search-results-synchro-code!execute.jspa">
		           <input type="Search" name="searchText" id="searchText" placeholder="Enter Synchro Code" onfocus="this.placeholder = ''" onblur="this.placeholder ='Enter Synchro Code' " autocomplete="off" />
				   
		             <a class="searchBarSearchText" onclick="return vaildateSynchroCodes();"> <span>SEARCH</span> <i class="fa fa-search"></i></a>
					 <input type="hidden" id="searchBySynchroId" name="searchBySynchroId" value="searchBySynchroId">	 
					 
					<!-- <span class="searchBarInfoIcon"></span> -->
		        </form> 

		      


         </div>
</div>

	<div id="dialogOverlay">
	   <div class="dialogBoxWrap">
		 <div class="dialogInnerWrap">
			<img src="${themePath}/images/iris/warning-icon.png">
			<h5> <b>Incorrect Synchro Code</b> </h5>
		  <div>
			 <div class="dialogBtnBox">
			   <a href="#">OK</a>
			   <p>Please enter valid Synchro Code.</p>
			 </div>
		  </div>
		</div>
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

function vaildateSynchroCodes()
{
	var st = $j("#searchText").val();
	
	
	var isValid = false;
	
	
	// We allow * symbol as well for search by synchro code
	// var regex = /^[0-9\s]*$/;
	//var regex = /^[0-9*]*$/;
	var regex = /^[0-9\s*]*$/;
  
	isValid = regex.test(st);
	if(isValid)
	{
		searchIRIS();
	}
	else
	{
		
		 
		 $j("#dialogOverlay").show();
		return false;
	}
	
}

function searchIRIS()
{
	if($j("#searchText").val()=="")
	{
		 $j("#dialogOverlay").show();
		return false;
	}
	else
	{
		var searchIRISSummaryForm = $j("#searchIRISSummaryForm");
		searchIRISSummaryForm.submit();
		
	}
}

$j("#searchText").on("keypress", function (e) {            

    if (e.keyCode == 13) {
        // Cancel the default action on keypress event
        e.preventDefault(); 
        vaildateSynchroCodes();
    }
});
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


	 $j('.dialogBoxWrap .dialogBtnBox a').click(function(){
			 $j('#dialogOverlay').hide();
	   });	   

    });

</script>