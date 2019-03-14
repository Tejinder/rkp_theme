<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.paginate.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/table-height-handler.js" type="text/javascript"></script>


		
		
		
		
	<!-- 	<#if endMarketID?? && endMarketID == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER>
			<div class="action-cont">
				<a href="javascript:void(0)" class="link download" id="delete_btn" >DELETE</a>	
				<a href="javascript:void(0)" class="link download" id="rename_Popup" onclick="openMovePopUp();">MOVE</a>	
			
			</div>	
		</#if> -->
		<div class="irisAdminSectionWrap">
		<!-- <div class="cont-gray"> -->
			<div class="breadcrumb">
				<a href="/iris-summary/admin-home.jspa"><span>Admin Panel</span></a>
				<a href="/iris-summary/container-regions.jspa"><span>Spaces</span></a>
				
				<#if endMarketID?? && endMarketID == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER>
					<a href="javascript:void(0)"><span>Admin Folder</span></a>
				<#elseif endMarketID == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL>
					<a href="/iris-summary/container-end-markets.jspa?regionID=${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET}"><span>${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_FOLDER_NAME}</span></a>
					<a href="javascript:void(0)"><span>${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL_FOLDER_NAME}</span></a>
				<#elseif endMarketID == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL>
					<a href="/iris-summary/container-end-markets.jspa?regionID=${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET}"><span>${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_FOLDER_NAME}</span></a>
					<a href="javascript:void(0)"><span>${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL_FOLDER_NAME}</span></a>	
				<#else>
					<a href="/iris-summary/container-end-markets.jspa?regionID=${regionID}"><span>${statics['com.grail.synchro.util.SynchroUtils'].getAllRegionName(endMarketID)}</span></a>
					<a href="javascript:void(0)"><span>${statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(endMarketID)}</span></a>
				</#if>	
			</div>
			
		<!-- 	<div class="site_search">
				<form id="search-box">
					<input type="text" name="q" size="31" id="search_box" class="search_box" placeholder="Search" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Search' "/>
					<input type="button"  name="" value="" class="search_icon" />
				</form>
			</div>
		-->



                <div class="attachBelowBtnWrap">
                   <div id="delete_Button" class="bottomBtnWrap link_disabled">
	                 	<div class="bottomBtnWrapAlign">
					          <p class="hoverCls">DELETE</p>
					   </div>
				   </div>

				    <div id="move_Button" class="bottomBtnWrap link_disabled">
	                 	<div class="bottomBtnWrapAlign">
					          <p class="hoverCls">MOVE</p>
					   </div>
				   </div>

					<!--	
					<div class="bottomBtnWrap">
	                 	<div class="bottomBtnWrapAlign">
					          <p>CANCEL</p>
					   </div>
				   </div>
				   -->
                </div> 

				<div class="searchBarContainer adminSearchBar">
						<form method="POST" name="" action="">
						   <input type="Search" id="searchText" name="searchText"  placeholder="Search Summary"/>
							<!--<button onclick="return searchKeyword();">| <span>SEARCH</span> <i class="fa fa-search"></i></button> -->
							<a class="searchBarSearchText" onclick="return searchKeyword();"><span>SEARCH</span> <i class="fa fa-search"></i></a> 
						</form> 
				</div>

         </div>


		<div id="table-main">
		</div>     
		<!-- </div>    -->  
	

		<div id="overlay">
			<img src="${themePath}/images/bigrotation.gif" id="img-load" />
		</div> 

		<form id="summary-delete-form" action="/iris-summary/container-iris-summaries!deleteSummaries.jspa" method="POST">
			<input type="hidden" name="deleteSummaryIDs" id="deleteSummaryIDs" value="" />	
								
		</form> 
	
		<form id="iris-summary-move-Form" action="/iris-summary/container-iris-summaries!moveSummaries.jspa" method="POST">
			<input type="hidden" name="moveSummaryIDs" id="moveSummaryIDs" value="" />	
			<input type="hidden" name="containerId" id="containerId" value="" />
			<input type="hidden" name="endMarketID" id="endMarketID1" value="${endMarketID}" />
		</form>
	
	<!-- Move Div Start -->
<!-- 	<div class="qpr-div  qpr-container">
		<div id="iris-summary-move" class=" evaluation_report qpr-snaphot wellLayoutPop" style="display:none">
			<div class="j-form-popup">
				<a href="javascript:void(0);" class="close"></a>
				<div class="popup-title-overlay"></div>
				<div class="pop-upinner-scroll">
				
					<form id="iris-summary-move-Form" action="/iris-summary/container-iris-summaries!moveSummaries.jspa" method="POST" class="result-form-popup ">
						
						<div class="region-inner">
						<label>Select the Container </label>
						
						
							<select data-placeholder="" class="chosen-select" id = "containerId" name='containerId' >
								<option value=""></option>
								<#assign endMarketRegions = statics['com.grail.synchro.SynchroGlobal'].getRegionEndMarketsMapping() />
								<#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
								<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets() />
								<#assign endMarketRegionsKeySet = endMarketRegions.keySet() />
								<#if (endMarketRegions?has_content)>
									<#list endMarketRegionsKeySet as key>
										<#assign region = endMarketRegions.get(key) />
										 <optgroup label="${regions.get(key)}">
											 <#assign endMarketKeySet = endMarketRegions.get(key).keySet() />
											 <#list endMarketKeySet as endMarketkey>
												<option value="${endMarketkey?c}" >${endMarkets.get(endMarketkey)}</option>
											 </#list>
										</optgroup>	 
									</#list>
								</#if>
							</select>	
							
							<input type="button" value="Move" onclick="showMoveMessage('');" class="btn-blue" />
							
						</div>
						
						
					<input type="hidden" name="moveSummaryIDs" id="moveSummaryIDs" value="" />	
						
					</form>
				
				</div>
			</div>
		</div>
		
	</div> -->
	
	<!-- Move Div End -->
	
	
	<!-- Start end market Filter for Move Summary  -->

	<div class="popup" end-market="Popup-Move-Summary" id="move-summary-div">


<!-- Below div is added to set the Pop-up position on Advance search page -->
    <div class="setPopupPosition">

        <div  class="admin-move-popup-inner">
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


<div class="successPopupwrap">
	<div id="dialogOverlayMoveSuccess">
	   <div class="dialogBoxWrap">
	   	 <div class="successDialogWrap">
	   		<h5> <span id="summaryMoveSuccess"></span> </h5>
	      <div>
	   		 <div class="dialogBtnBox">
			   <p onclick="closeDialog();" class="moveDialogBtn moveDialogBtnNo">OK</p>		  			 
		     </div>
		  </div>
	   	</div>
	   </div> 
	</div>
</div>





<script type="text/javascript">
    
var xhr;

 var delSummaryId;
$j(document).ready(function() {


  $j('#dialogOverlayDelete .dialogBtnNo').click(function(){
   	     $j('#dialogOverlayDelete').hide();
   });

   $j('#dialogOverlayMove .moveDialogBtnNo').click(function(){
   	     $j('#dialogOverlayMove').hide();
   });

    $j('#dialogOverlayMoveSuccess .moveDialogBtnNo').click(function(){
   	     $j('#dialogOverlayMoveSuccess').hide();
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
	
	<#if toMoveContainderId?? && statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(toMoveContainderId)??>
		if(window.location.href.indexOf("toMoveContainderId") > -1) 
		{

              $j('#dialogOverlayMoveSuccess').show();

              $j('#summaryMoveSuccess').html('Selected Summaries have been successfully moved to <a href="javascript:void(0)">Admin</a> > <a href="javascript:void(0)">Spaces</a> > <a href="/iris-summary/container-iris-summaries.jspa?endMarketID=${toMoveContainderId}" target="_blank">${statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(toMoveContainderId)}</a>.');

			// dialog({title:"",html:'Selected Summaries have been successfully moved to <a href="javascript:void(0)">Admin</a> > <a href="javascript:void(0)">Spaces</a> > <a href="/iris-summary/container-iris-summaries.jspa?endMarketID=${toMoveContainderId}" target="_blank">${statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(toMoveContainderId)}</a>.'});
			// return false;
		}
	</#if>	
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
	

	
	var url = '/iris-summary/container-iris-summaries-pagination.jspa';
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
	
	$j("#endMarketID").val(${endMarketID});
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
  $j("#search-box").submit(function( event ) {
        //$j("#search_box").keyup();
        event.preventDefault();
    });

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

	var contId;
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
		
		$j('#delete_Button').on('click', function(){
			if( $j(this).hasClass('link_disabled') ) {
				event.stopPropagation();
			} else {
				showDeleteFolder();
			}
		});
		
		$j('#move_Button').on('click', function(){
			if( $j(this).hasClass('link_disabled') ) {
				event.stopPropagation();
			} else {
				$j("#move-summary-div").fadeIn(350);
				//showMoveMessage();
			}
		});
		
		$j('#move-summary-close-div').on('click', function(e) {
          	$j("#move-summary-div").fadeOut(500);
		});	 
		
		
		$j('.moveSummaryFilterClass').on('click', function(e) {
          	
			
			 contId = $j(this).id();

	
            	$j('#dialogOverlayMove').show();
				
				var currentMarketName = '';
				<#if endMarketID?? && endMarketID == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER>
					currentMarketName = 'Admin Folder';
				<#elseif endMarketID == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL>

					currentMarketName = '${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_GLOBAL_FOLDER_NAME}' ;
				<#elseif endMarketID == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL>
					currentMarketName = '${statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ABOVE_MARKET_REGIONAL_FOLDER_NAME}' ;
				<#else>
					
					currentMarketName = '${statics['com.grail.synchro.SynchroGlobal'].getAllEndMarkets().get(endMarketID)}' ;
				</#if>	


         $j('#summaryMove').html('<div>Are you sure you want to move the summary from <a href="javascript:void(0)">Admin </a> > <a href="javascript:void(0)">Spaces</a> > <a href="javascript:void(0)" >'+currentMarketName+'</a> to <a href="javascript:void(0)">Admin</a> > <a href="javascript:void(0)">Spaces</a> > <a href="/iris-summary/container-iris-summaries.jspa?endMarketID='+contId+'" target="_blank">'+$j(this).val()+' </a>?</div>');


		});	 



			
			// dialog({
			// 	title: 'Move Summary',
			// 	<!-- html: '<p>Are you sure you want to move the summary from '+selectedContainer+' to '+$j(this).val()+'</p>', -->
			// 	html: '<p>Are you sure you want to move the summary from <a href="javascript:void(0)">Admin </a> > <a href="javascript:void(0)">Spaces</a> > <a href="javascript:void(0)" >Admin Folder</a> to <a href="javascript:void(0)">Admin</a> > <a href="javascript:void(0)">Spaces</a> > <a href="/iris-summary/container-iris-summaries.jspa?endMarketID='+contId+'" target="_blank">'+$j(this).val()+' </a>?</p>',
			// 	buttons:{
			// 		"YES":function() {
			// 			var irisSummaryMoveForm = $j("#iris-summary-move-Form");
			// 			$j("#containerId").val(contId);
			// 			var moveSummaryId = checkId();
			// 			$j("#moveSummaryIDs").val(moveSummaryId);
						
			// 			irisSummaryMoveForm.submit();
			// 		},
			// 		"NO": function() {
			// 			closeDialog();
			// 		}
			// 	}
			// });
			
			
			
	
		
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

	function moveDialogYesOption(){
              
				var irisSummaryMoveForm = $j("#iris-summary-move-Form");
						$j("#containerId").val(contId);
						var moveSummaryId = checkId();
						$j("#moveSummaryIDs").val(moveSummaryId);
						
						irisSummaryMoveForm.submit();

			}



    
	
	function showDeleteFolder()
	  {	
		 delSummaryId = checkId();
		console.log("delSummaryId==>"+delSummaryId);
       
       $j('#dialogOverlayDelete').show();

	  }

		function deleteDialogYes(){

		

		       $j("#deleteSummaryIDs").val(delSummaryId);
				var deleteSummaryForm = jQuery("#summary-delete-form");
				deleteSummaryForm.submit();
		}

       

		// dialog({
		// 		title:"",
		// 		html:'<i class="warningErr"></i><p>Once you delete the Summary, it will no longer be accessible.</p><p>Are you sure you want to delete the Summaries</p>',
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
					clickID = clickID+','+$j(this).val();

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

	function openMovePopUp()
	{
		$j("#iris-summary-move").lightbox_me({centered:true,closeEsc:false,closeClick:false,overlayCSS:{background: 'black', opacity: .7}});
	}
	
	function showMoveMessage()
	{
		var to = $j('select[name="containerId"] option:selected').text();
		var toId = $j('select[name="containerId"] option:selected').val();
		
		var moveSummaryId = checkId();
		console.log("moveSummaryId==>"+moveSummaryId);
		console.log("toId==>"+toId);
		
		dialog({
			title: 'Move Summary',
			html: '<p>Are you sure you want to move the selected summaries from <a href="javascript:void(0)">Admin </a> > <a href="javascript:void(0)">Spaces</a> > <a href="javascript:void(0)">Admin Folder</a> to <a href="javascript:void(0)">Admin</a> > <a href="javascript:void(0)">Spaces</a> > <a href="/iris-summary/container-iris-summaries.jspa?endMarketID='+toId+'" target="_blank">'+to+' </a>?</p>',
			buttons:{
				"YES":function() {
					$j("#moveSummaryIDs").val(moveSummaryId);
					var irisSummaryMoveForm = $j("#iris-summary-move-Form");
					irisSummaryMoveForm.submit();
				},
				"NO": function() {
					closeDialog();
				}
			}
		});
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
  
    </script>
