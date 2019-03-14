<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.paginate.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/table-height-handler.js" type="text/javascript"></script>


	
		
		
		<!--
		<div class="action-cont">
			<a href="javascript:void(0)" class="link download" id="delete_btn" >DELETE</a>	
		</div>	-->
		
		<!-- <div class="cont-gray">-->
		
		<div id="overlay">
			<img src="${themePath}/images/bigrotation.gif" id="img-load" />
		</div>

		<form id="summary-delete-form" action="/iris-summary/draft-summaries!deleteSummary.jspa" method="POST" >
			<input type="hidden" name="deleteSummaryIDs" id="deleteSummaryIDs" value="" />	
		</form>
		
		<div class="irisAdminSectionWrap">
			<div class="breadcrumb">
				<a href="/iris-summary/admin-home.jspa"><span>Admin Panel</span></a>
				<#if fromNavigation?? && fromNavigation=="ManageSummaries">
					<a href="/iris-summary/manage-summaries.jspa"><span>Manage Summaries</span></a>
				<#else>
					<a href="/iris-summary/container-regions.jspa"><span>Spaces</span></a>
				</#if>	
				<a href="javascript:void(0)"><span>Draft</span></a>
			</div>
			
			<div class="attachBelowBtnWrap">
				<div id="delete_Button" class="bottomBtnWrap link_disabled">
					<div class="bottomBtnWrapAlign">
						  <p class="hoverCls">DELETE</p>
				   </div>
			   </div>
			</div> 
			
		
				
			
			<div class="searchBarContainer adminSearchBar">
				<form method="POST" name="" action="">
				   <input type="Search" id="searchText" name="searchText"  placeholder="Search Summary"/>
					<!-- <button onclick="return searchKeyword();">| <span>SEARCH</span> <i class="fa fa-search"></i></button> -->
					<a class="searchBarSearchText" onclick="return searchKeyword();"><span>SEARCH</span> <i class="fa fa-search"></i></a> 
				</form> 
			</div>
		</div> 	
			
			<div id="table-main">
			</div>  




<div class="adminSummaryDelete dialogDelete">
	<div id="dialogOverlayDelete">
	   <div class="dialogBoxWrap">
	   	 <div class="dialogInnerWrap">
	   		<h5> <b>Once you delete the Summary, it will no longer be accessible. </br>Are you sure you want to delete the Summaries?</b> </h5>
	      <div>
	   		 <div class="dialogBtnBox">
	   		 	<a href="#" class="dialogBtnNo">NO</a>
			   <a href="#" onclick="deleteDialogYes();">YES</a>
		     </div>
		  </div>
	   	</div>
	   </div> 
	</div>
</div>     
		      
   
<!--
	<div id="overlay">
		<img src="${themePath}/images/bigrotation.gif" id="img-load" />
	</div>

<form id="summary-delete-form" action="/iris-summary/draft-summaries!deleteSummary.jspa" method="POST" class="result-form-popup ">
		<input type="hidden" name="deleteSummaryIDs" id="deleteSummaryIDs" value="" />	
							
	</form>
-->
<script type="text/javascript">
    
var xhr;
$j(document).ready(function() {

     $j('#dialogOverlayDelete .dialogBtnNo').click(function(){
   	     $j('#dialogOverlayDelete').hide();
   });

	currPage = 1;
	if(window.location.href.indexOf("currPage") > -1) 
	{
		var localCurrPage = window.location.href.split("currPage=")[1];
		if(localCurrPage.indexOf("&") > -1)
		{	
			//alert("CCPAGE ==>"+localCurrPage.split("&")[0]);
			currPage=localCurrPage.split("&")[0];
		}
		else
		{
			//alert("CCPAGE ==>"+localCurrPage)
			currPage=localCurrPage;
		}
	}
	var sortBy = "";
	if(window.location.href.indexOf("sortField") > -1) 
	{
		var localSortField = window.location.href.split("sortField=")[1];
		if(localSortField.indexOf("&") > -1)
		{	
			//alert("CCPAGE ==>"+localCurrPage.split("&")[0]);
			
			sortBy = localSortField.split("&")[0];
		}
		else
		{
			
			if(localSortField!='')
			{
				sortBy = localSortField;
				
			}
		}
	}
	
	var sortOrder = "";
	if(window.location.href.indexOf("sortOrder") > -1) 
	{
		var localSortOrder = window.location.href.split("sortOrder=")[1];
		if(localSortOrder.indexOf("&") > -1)
		{	
			sortOrder = localSortOrder.split("&")[0];
		}
		else
		{
			
			if(localSortOrder!='')
			{
				sortOrder = localSortOrder;
				
			}
		}
	}

	processPaginationRequest(currPage, "");	
	//processPaginationRequestMain(currPage, "",10, sortBy, sortOrder);	
	
	$j(".result-form-popup .project_start_date .year select").css('width','340px');
});

	
// Search based on project name, owner, and project status
var timer;
//$j("#search_box").keyup(function(){
$j("#search_box").on("keyup",function(){
	clearTimeout(timer);
	timer = setTimeout(function(){
		var value = $j("#search_box").val();	
		if($j.trim(value) != "")
        {
                
			var plimit = $j("#project-limit").val();
            processPaginationRequest(1, $j.trim(value), plimit);
        }
        else
        {
           	var plimit = $j("#project-limit").val();
            processPaginationRequest(1, "", plimit);
        }
	}, 300);
	
	//Sort Fields
	$j("#sortField").val("");
	$j("#ascendingOrder").val("");
});

$j("#searchText").on("keyup",function(){
	searchKeyword();
	
	
});

$j("#searchText").on("keypress", function (e) {            

    if (e.keyCode == 13) {
        // Cancel the default action on keypress event
        e.preventDefault(); 
        searchKeyword();
    }
});

function searchKeyword()
{

	var value = $j("#searchText").val();
	if($j.trim(value) != "")
    {
        var plimit = $j("#project-limit").val();
        processPaginationRequest(1, $j.trim(value), plimit);
    }
    else
    {
        var plimit = $j("#project-limit").val();
        processPaginationRequest(1, "", plimit);
    }	
	
	return false;
}

function processPaginationRequest(page, keyword, plimit) {

	
	
	currPage = page;
	
	if(xhr != null) {
		xhr.abort();
	}
	

	
	var url = '/iris-summary/draft-summaries-pagination.jspa';
	selectAllFilterBoxes();
	var filterForm = $j("#result-filter-form");
    
	if(plimit!=null && plimit!=undefined)
	{
		//limit = plimit;
	}
	else
	{
		plimit = $j("#project-limit").val();
	}
	
	if(plimit==undefined)
	{
		plimit=10;
	}
	
	
	xhr = $j.ajax({
		url : url,
		type: 'POST',
		data: filterForm.serialize() + '&keyword='+ keyword+"&page="+page+"&plimit="+plimit,
		beforeSend: function() {
			$j("#overlay").show();
		},
		complete: function() {
			//$j("#overlay").hide();
		},
		success: function(result) {
			xhr = null;
			$j("#overlay").hide();
			$j('#table-main').html(result);
			
                HeightSet();			
			//$j('body').css({height: $j(document).height()});
           // adjustTableBodySize();
            TABLE_HEIGHT_HANDLER.initialize();
			changePaginationPos();
		}
	});		
	
	changePaginationPos();
}

function adjustTableBodySize() {
    $j(".table-vscroll .scollinner").height($j(".project_status_table tbody").height() + 15);
    $j(".table-vscroll").css("top",($j($j(".project_status_table thead")[0]).height()) + 1 + "px");
}


function loadLimit()
{	
	var value = $j("#search_box").val();
	if($j.trim(value) != "")
	{
		var plimit = $j("#project-limit").val();
		
		processPaginationRequest(1, $j.trim(value), plimit);
	}
	else
	{
		var plimit = $j("#project-limit").val();
		
		processPaginationRequest(1, "", plimit);
	}	
	
}


</script>
<script>
    $j(function(){

		$j('.ui-icon-closethick').on('click', function(){
			$j(this).closest('.popupCont').hide()
			if( $j('body').hasClass('stopScroll') ){
				$j('body').removeClass('stopScroll');
			}
		});

		

		
		
		$j('#delete_Button').on('click', function(){
			if( $j(this).hasClass('link_disabled') ) {
				event.stopPropagation();
			} else {
				showDeleteFolder();
			}
		});
		
		

		
		
		setTimeout(function(){
			changePaginationPos();
		}, 300);
		
		$j( window ).resize(function() {
		  changePaginationPos();
		});		
	
		
		if(window.location.href.indexOf("validFolder") > -1) 
		{
			dialog({title:"",html:"This Folder Name already exists. Please enter unique Folder Name"});
			return false;
		}
    })

	



    
	
	function showDeleteFolder()
	{	
		

		$j('#dialogOverlayDelete').show();

		}

		function deleteDialogYes(){

			var delSummaryId = checkId();
		    console.log("delSummaryId==>"+delSummaryId);

			$j("#deleteSummaryIDs").val(delSummaryId);
			var deleteSummaryForm = jQuery("#summary-delete-form");
			deleteSummaryForm.submit();
		}


		// dialog({
		// 		title:"",
		// 		html:'<i class="warningErr"></i><p>Once you delete the Summary, it will no longer be accessible.</p><p>Are you sure you want to delete the Summaries ?</p>',
		// 		buttons:{
		// 		"YES":function() {
		// 			$j("#deleteSummaryIDs").val(delSummaryId);
		// 			var deleteSummaryForm = jQuery("#summary-delete-form");
		// 			deleteSummaryForm.submit();
		// 		},
		// 		"NO": function() {
		// 			return false;
		// 		}
				
		// 	},

		// });
	


	function checkId(){

		var clickID="";
		
		
		$j('.adminSectionCheckbox').each(function(){

			if($j(this).prop("checked") == true)
			{
				if ( clickID != '' )
				{
					clickID = clickID+','+$j(this).val()
				}
				else 
				{
					clickID = $j(this).val();
				}
			}
        });
	return clickID;
	}
	
		
	
	function changePaginationPos(){
//debugger;
	var p = $j('.jPaginate');
	var pW = p.outerWidth();
	var pPW = p.parent().innerWidth();
	var pMargin = (pPW - pW ) /2;
	p.css({'margin-left':pMargin+'px', 'margin-right':pMargin+'px'});	
}


  
  
    </script>
