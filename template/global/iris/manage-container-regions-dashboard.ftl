<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.paginate.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/table-height-handler.js" type="text/javascript"></script>


		
		
		

		<!--<div class="cont-gray">-->
		<div class="irisAdminSectionWrap regionAlign">
			<div class="breadcrumb">
				<a href="/iris-summary/admin-home.jspa"><span>Admin Panel</span></a>
				<a href="javascript:void(0)"><span>Spaces</span></a>
			</div>
			
			<div id="table-main">
			</div>       
		</div>       
   

	



<script type="text/javascript">
    
var xhr;
$j(document).ready(function() {
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

function processPaginationRequest(page, keyword, plimit) {

	//disableAction();
	
	currPage = page;
	
	if(xhr != null) {
		xhr.abort();
	}
	

	
	var url = '/iris-summary/container-regions-pagination.jspa';
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

		

		$j('#delete_btn').on('click', function(){
			//$j('#delete_popup').show();
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
	
		//disableAction();
		if(window.location.href.indexOf("validFolder") > -1) 
		{
			dialog({title:"",html:"This Folder Name already exists. Please enter unique Folder Name"});
			return false;
		}
    })

	


	


		
	
	function changePaginationPos(){
//debugger;
	var p = $j('.jPaginate');
	var pW = p.outerWidth();
	var pPW = p.parent().innerWidth();
	var pMargin = (pPW - pW ) /2;
	p.css({'margin-left':pMargin+'px', 'margin-right':pMargin+'px'});	
}


  
  
    </script>
