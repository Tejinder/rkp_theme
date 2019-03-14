<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.paginate.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/table-height-handler.js" type="text/javascript"></script>


		
		<div class="popupCont" id='copyLink_popup'>
			<div class="ui-dialog ui-widget ui-widget-content ui-corner-all" tabindex="-1" role="dialog" aria-labelledby="ui-id-1">
				<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"><span id="ui-id-1" class="ui-dialog-title">&nbsp;</span><a href="javascript:void(0)" class="ui-dialog-titlebar-close ui-corner-all" role="button"><span class="ui-icon ui-icon-closethick">close</span></a></div>
				<div id="project-create-options" class="ui-dialog-content ui-widget-content" scrolltop="0" scrollleft="0">
				 <p>LINK TO '<span id='dynamicFolderName'></span>' <span id='pathStatus'>CREATED</span></p>
				 <div class="cont-popupFields">
				  <form action="">
				   <input type="text" name="copyLinkField" id="copyLinkField" value="" readonly="true">
				   <input type="submit" onclick="return copyToClipboard('#copyLinkField')"  value="COPY">
				   
				  </form>
				 </div>
				 <div class="cont-popFooter">
				  <img alt="sorting" src="/themes/rkp_theme/images/osp/oracle/icon-lock.png" />Only people with SHARE access have permission to view this link 
				 </div>
				</div>
			</div>
		</div>
		
		<div class="popupCont" id='rename_popup'>
			<div class="ui-dialog ui-widget ui-widget-content ui-corner-all" tabindex="-1" role="dialog" aria-labelledby="ui-id-1">
				<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"><span id="ui-id-1" class="ui-dialog-title">&nbsp;</span><a href="javascript:void(0)" class="ui-dialog-titlebar-close ui-corner-all" role="button"><span class="ui-icon ui-icon-closethick">close</span></a></div>
				<div id="project-create-options" class="ui-dialog-content ui-widget-content" scrolltop="0" scrollleft="0">
				 <div class="cont-popupFields">
				  
				  <form id="folder-rename-form" action="/share/share-folder-dashboard!renameFolder.jspa" method="POST">
					
					<label>Folder Name </label>
						<input type="text" tabindex="1" name="renameFolderName" id="renameFolderName" value=""  onkeyup="myRenameFunction()" autofocus maxlength="100" /> 
						<input type="Submit" value="RENAME" onclick="return submitFolderRename();"/>
					
					
					 <input type="hidden" name="hiddenTileID" id="hiddenTileID" value="${ospTile.getTileId()}" />
					<input type="hidden" name="renameFolderID" id="renameFolderID" value="" />	
					
				</form>
				 
				  <span   class ="jive-error-message" id="createRenameWarningMessage1" style="display:none"> Please enter folder name</span>
				   <span   class ="jive-error-message" id="createRenameWarningMessage" style="display:none">Folder name should be less than 100 characters</span>
				 
				 </div>
				
				</div>
			</div>
		</div>
		
		<div class="popupCont" id='new_popup'>
			<div class="ui-dialog ui-widget ui-widget-content ui-corner-all" tabindex="-1" role="dialog" aria-labelledby="ui-id-1">
				<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"><span id="ui-id-1" class="ui-dialog-title">&nbsp;</span><a href="javascript:void(0)" class="ui-dialog-titlebar-close ui-corner-all" role="button"><span class="ui-icon ui-icon-closethick">close</span></a></div>
				<div id="project-create-options" class="ui-dialog-content ui-widget-content" scrolltop="0" scrollleft="0">
				
				 <div class="cont-popupFields">
				
				 <label>Folder Name </label>
				  <form id="folder-create-form" action="/share/share-folder-dashboard!createNewFolder.jspa" method="POST">
				   <input type="text" tabindex="1" name="folderName" id="folderName" value=""   onkeyup="myFunction()"   autofocus  maxlength="100"/> 
				   <input type="submit" onclick="return submitFolderCreate();" value="CREATE">
				   <input type="hidden" name="hiddenTileID" id="hiddenTileID" value="${ospTile.getTileId()}" />
				  </form>
				
				 </div>
				    <span   class ="jive-error-message" id="createFolderWarningMessage1" style="display:none"> Please enter folder name</span>
				   <span   class ="jive-error-message" id="createFolderWarningMessage" style="display:none">Folder name should be less than 100 characters</span>
				 
				 
				 
				</div>
			</div>
		</div>
		
		<#assign canEditOSP = statics['com.grail.synchro.util.SynchroPermHelper'].canEditOSPSharePortal(user) />
		
		<div class="action-cont">
			<a href="javascript:void(0)" class="link copy" id="copyLink"><!--<img src="/themes/rkp_theme/images/osp/oracle/icon-locked-file.png" alt="">-->COPY LINK</a>
			<!--<a href="javascript:void(0)" class="link download"><img src="/themes/rkp_theme/images/osp/oracle/icon-download.png" alt="">DOWNLOAD</a>-->

			<!--<a href="javascript:void(0)" class="link download" id="new_Popup" onclick="showCreateFolder()">NEW</a>-->	
			<#if canEditOSP>
				<a href="javascript:void(0)" class="link download" id="new_Popup"><!--<img src="/themes/rkp_theme/images/osp/oracle/icon-new.png" alt="">-->NEW</a>	
				<a href="javascript:void(0)" class="link download" id="delete_btn" ><!--<img src="/themes/rkp_theme/images/osp/oracle/icon-delete.png" alt="">-->DELETE</a>	
				<!--<a href="javascript:void(0)" class="link download" id="rename_Popup" onclick="showRenameFolder()">RENAME</a>-->				
				<a href="javascript:void(0)" class="link download" id="rename_Popup"><!--<img src="/themes/rkp_theme/images/osp/oracle/icon-edit.png" alt="">-->RENAME</a>			
			</#if>	
		</div>	
		
		<div class="cont-gray">
			<div class="breadcrumb">
				<a href="/portal-options.jspa"><span>OSP</span></a>
				<a href="/share/home.jspa"><span>SHARE</span></a>
				<a href="javascript:void(0)"><span>${ospTile.getTileName()}</span></a>
			</div>
			
			<div id="table-main">
			</div>       
		</div>       
   

	<div id="overlay">
		<img src="${themePath}/images/bigrotation.gif" id="img-load" />
	</div>

<form id="folder-delete-form" action="/share/share-folder-dashboard!delete.jspa" method="POST" class="result-form-popup ">
		<input type="hidden" name="deleteFolderIDs" id="deleteFolderIDs" value="" />	
		 <input type="hidden" name="hiddenTileID" id="hiddenTileID" value="${ospTile.getTileId()}" />						
	</form>

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
	//processPaginationRequest(currPage, "");	
		processPaginationRequestMain(currPage, "",10, sortBy, sortOrder);	
	$j("#project-methodology-filter").hide();	
	$j("#project-projectactivity-filter").hide();
	$j("#project-projectsupplier-filter").hide();
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

	disableAction();
	currPage = page;
	if(xhr != null) {
		xhr.abort();
	}
	
	//$j("#sortField").val("foldersize");
	//alert("sortField==>"+ $j('#sortField').val());
	
	
	var url = '/share/share-folder-dashboard-pagination.jspa';
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
	
	$j("#tileID").val(${tileID});
	
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

function processPaginationRequestMain(page, keyword, plimit, sortBy, sortOrder) {

	disableAction();
	currPage = page;
	if(xhr != null) {
		xhr.abort();
	}
	
	//$j("#sortField").val("foldersize");
	//alert("sortField==>"+ $j('#sortField').val());
	
	
	var url = '/share/share-folder-dashboard-pagination.jspa';
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
	
	$j("#tileID").val(${tileID});
	
	xhr = $j.ajax({
		url : url,
		type: 'POST',
		data: filterForm.serialize() + '&keyword='+ keyword+"&page="+page+"&plimit="+plimit+"&sortBy="+sortBy+"&sortOrder="+sortOrder,
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

		$j('#copyLink').on('click', function(e){
			if( $j(this).hasClass('link_disabled') ) {
				event.stopPropagation();
			} else {
			//debugger;
				$j('#copyLinkField').val(getCheckedCopyURL());
				var x, y, offset;
				//x = e.pageX;
				//y = e.pageY;			
				//$j('#copyLink_popup>.ui-dialog').css({'left':x+'px', 'top':y+'px'});
				offset = $j(this).offset();
				x = offset.left;
				y = offset.top+$j(this).height();
				$j('#copyLink_popup>.ui-dialog').css({'left':x+'px', 'top':(y-$j(document).scrollTop())+'px'});				
				$j('#copyLink_popup').show();	
				$j('body').addClass('stopScroll');
			}
		});

		$j('#rename_Popup').on('click', function(){
			if( $j(this).hasClass('link_disabled') ) {
				event.stopPropagation();
			} else {
				 $j("#createRenameWarningMessage1").hide();
				$j("#createRenameWarningMessage").hide();
				$j('#rename_popup').show();
				$j('#renameFolderName').focus();
					$j('#renameFolderName').val(checkFolderName());  
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

		$j('#new_Popup').on('click', function(){
			
			 $j("#createFolderWarningMessage1").hide();
			$j("#createFolderWarningMessage").hide();
			$j('#new_popup').show();
			$j('#folderName').focus();
		})
		
		setTimeout(function(){
			changePaginationPos();
		}, 300);
		
		$j( window ).resize(function() {
		  changePaginationPos();
		});		
	
		disableAction();
		if(window.location.href.indexOf("validFolder") > -1) 
		{
			dialog({title:"",html:"This Folder Name already exists. Please enter unique Folder Name"});
			return false;
		}
    })

	

/*$j(document).on('click', '.link_disabled' ,function(){
	event.stopPropagation();
}) */
	
function disableAction(){
	var actionCont = $j('.action-cont');
	if( actionCont.length ){
		//$j('#copyLink, #new_Popup, #rename_Popup, #delete_btn').addClass('link_disabled');
		$j('#copyLink, #delete_btn, #rename_Popup').addClass('link_disabled');
	}
}
    
	function submitFolderCreate()
	{
		//var folderName = $j("#folderName").val();
	
		/*if(folderName=="")
		{
			dialog({title:"Message",html:"Please enter Folder Name"});
			return false;
		}
		*/
		 
		 if($j("#folderName").val().trim().length==0)
		 {
		  $j("#createFolderWarningMessage1").show();
		    return false;
		 }
		 
		if( $j("#folderName").val().length  >= 100)
		{
		
		 
		$j("#createFolderWarningMessage").show();
		  return false;
		}
		
		
		else
		{
		  $j("#createFolderWarningMessage1").hide();
		   $j("#createFolderWarningMessage").hide();
			var createFolderForm = $j("#folder-create-form");
			createFolderForm.submit();
		}
	}
	
	function submitFolderRename()
	{
		//var renameFolderName = $j("#renameFolderName").val();
	
		/*if(renameFolderName=="")
		{
			dialog({title:"Message",html:"Please enter Folder Name"});
			return false;
		}*/
		
		if($j("#renameFolderName").val().trim().length==0)
		 {
		  $j("#createRenameWarningMessage1").show();
		    return false;
		 }
		 
		else if( $j("#renameFolderName").val().length  >= 100)
		{
		
		 
		$j("#createRenameWarningMessage").show();
		  return false;
		}
		
		
		else
		{
			var renameFolderId = checkId();		
			$j("#renameFolderID").val(renameFolderId);
			var renameFolderForm = $j("#folder-rename-form");
			renameFolderForm.submit();
		}
	}
	function showDeleteFolder()
	{	
		var delFolderId = checkId();
		console.log("delFolderId==>"+delFolderId);
		dialog({
				title:"",
				html:'<i class="warningErr"></i><p>Once you delete the folder, it will no longer be accessible.</p><p>Are you sure you want to delete the folder</p>',
				buttons:{
				"YES":function() {
					$j("#deleteFolderIDs").val(delFolderId);
					var deleteFolderForm = jQuery("#folder-delete-form");
					deleteFolderForm.submit();
				},
				"NO": function() {
					return false;
				}
				
			},

		});
	}


	function checkId(){

		var clickID="";
		if( $j('.table-container .table-row a') ){
			$j('a').each( function(){
				if($j(this).closest('.table-row').hasClass('active')){
					console.log($j(this).context.id);
					if ( clickID != '' ){
						clickID = clickID+','+$j(this).context.id;
					} else {
						clickID = $j(this).context.id
					}
					
					console.log(clickID);
				}
			})
		}
	return clickID;
	}
	
		function checkFolderName(){
		
		var folderName="";
		if( $j('.table-container .table-row a') ){
			$j('a').each( function(){
				if($j(this).closest('.table-row').hasClass('active')){
					//folderName = $j(this).context.id
					folderName = $j(this).text();
				}
			})
		}
		return folderName;
	}
	
	function getCheckedCopyURL(){

		$j('#dynamicFolderName').text(checkFolderName());
		var copyURL="";
		if( $j('.table-container .table-row a') ){
			$j('a').each( function(){
				if($j(this).closest('.table-row').hasClass('active')){
					console.log($j(this).context.href	);
					if ( copyURL != '' ){
						copyURL = copyURL+','+$j(this).context.href	;
					} else {
						copyURL = $j(this).context.href	
					}
					
					console.log(copyURL);
				}
			})
		}
	return copyURL;
	}
	
	function copyToClipboard(element)
	{
		
		//var copyURL = getCheckedCopyURL();
		//alert(copyURL);
		var temp = $j("<input>");
		$j("body").append(temp);
		temp.val($j(element).val()).select();
		
		$j("#pathStatus").text('COPIED').parent('').addClass('copy_status');
		document.execCommand("copy");
		temp.remove();
		return false;
	}
	
	function changePaginationPos(){
//debugger;
	var p = $j('.jPaginate');
	var pW = p.outerWidth();
	var pPW = p.parent().innerWidth();
	var pMargin = (pPW - pW ) /2;
	p.css({'margin-left':pMargin+'px', 'margin-right':pMargin+'px'});	
}


  function myFunction()
  {
         
      if($j("#folderName").val().length>= 100)     
	  {
	    $j("#createFolderWarningMessage").show();
	  }
	  else
	  {
	  $j("#createFolderWarningMessage1").hide();
	  $j("#createFolderWarningMessage").hide();
	  }
     	  
   
   
  }
  
  
  function myRenameFunction()
  {
         
      if($j("#renameFolderName").val().length>= 100)     
	  {
	    $j("#createRenameWarningMessage").show();
	  }
	  else
	  {
	  $j("#createRenameWarningMessage1").hide();
	  $j("#createRenameWarningMessage").hide();
	  }
     
   
   
  }
  
  
    </script>
