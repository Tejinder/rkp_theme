
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>

<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.paginate.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/table-height-handler.js" type="text/javascript"></script>


<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.MultiFile.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ajaxfileupload.js'/>"></script>
 
 
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
						<input type="text" tabindex="1" name="renameFolderName" id="renameFolderName" value="" /> 
						<input type="Submit" value="RENAME" onclick="submitFolderRename()"/>
					
					
					 <input type="hidden" name="hiddenTileID" id="hiddenTileID" value="${ospTile.getTileId()}" />  
					 <input type="hidden" name="renameFolderID" id="renameFolderID" value="" />	
					
				</form>
				 
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
				   <input type="text" tabindex="1" name="folderName" id="folderName" value="" /> 
				   <input type="submit" onclick="submitFolderCreate()" value="CREATE">
				   <input type="hidden" name="hiddenTileID" id="hiddenTileID" value="${ospTile.getTileId()}" />
				  </form>
				 </div>
				 
				</div>
			</div>
		</div>
		
		<#assign canEditOSP = statics['com.grail.synchro.util.SynchroPermHelper'].canEditOSPSharePortal(user) />
		
		<div class="action-cont">
	
			<a href="#" class="link copy" id="copyLink"><!--<img src="/themes/rkp_theme/images/osp/oracle/icon-locked-file.png" alt="">-->COPY LINK</a>
			<a href="javascript:void(0);" class="link download" id="download_btn"><!--<img src="/themes/rkp_theme/images/osp/oracle/icon-download.png" alt="">-->DOWNLOAD</a>
			
			<#if canEditOSP>
				<a href="javascript:void(0);" class="link download"  id="upload_btn" onclick="showAttachmentPopup()" ><!--<img src="/themes/rkp_theme/images/osp/oracle/icon-upload.png" alt="">-->UPLOAD</a>
				<!--<a href="javascript:void(0);" class="link download" id="delete_btn"><img src="/themes/rkp_theme/images/osp/icon-download.png" alt="">DELETE</a>		-->
				<a href="javascript:void(0)" class="link download" id="delete_btn" ><!--<img src="/themes/rkp_theme/images/osp/oracle/icon-delete.png" alt="">-->DELETE</a>			
			</#if>	
		</div>	
		
		
		<div class="cont-gray">
			<div class="breadcrumb">
				<a href="/portal-options.jspa"><span>OSP</span></a>
				<a href="/share/home.jspa"><span>SHARE</span></a>
				<#if sortBy??>
										
					<#if currPage??>
						<#if sortOrder??>
							<a href="/share/share-folder-dashboard.jspa?tileID=${ospTile.getTileId()}&currPage=${currPage}&sortField=${sortBy}&sortOrder=${sortOrder}"><span>${ospTile.getTileName()}</span></a>
						<#else>
							<a href="/share/share-folder-dashboard.jspa?tileID=${ospTile.getTileId()}&currPage=${currPage}&sortField=${sortBy}"><span>${ospTile.getTileName()}</span></a>
						</#if>
						
					<#else>
						<#if sortOrder??>
							<a href="/share/share-folder-dashboard.jspa?tileID=${ospTile.getTileId()}&sortField=${sortBy}&sortOrder=${sortOrder}"><span>${ospTile.getTileName()}</span></a>
						<#else>
							<a href="/share/share-folder-dashboard.jspa?tileID=${ospTile.getTileId()}&sortField=${sortBy}"><span>${ospTile.getTileName()}</span></a>
						</#if>
						
					</#if>	
				<#else>
					<#if currPage??>
						<a href="/share/share-folder-dashboard.jspa?tileID=${ospTile.getTileId()}&currPage=${currPage}"><span>${ospTile.getTileName()}</span></a>
					<#else>
						<a href="/share/share-folder-dashboard.jspa?tileID=${ospTile.getTileId()}"><span>${ospTile.getTileName()}</span></a>
					</#if>	
				</#if>	
				
				<a href="javascript:void(0)"><span>${ospFolder.getFolderName()}</span></a>
			</div>
			
			<div id="table-main">
			</div>       
		</div>       
    

	<div id="overlay">
		<img src="${themePath}/images/bigrotation.gif" id="img-load" />
	</div>

	
	<form id="file-attachment-form" action="/share/share-file-dashboard!download.jspa" method="POST" class="result-form-popup ">
		<input type="hidden" name="downloadAttachmentIds" id="downloadAttachmentIds" value="" />	
		<input type="hidden" name="hiddenTileID" id="hiddenTileID" value="${ospTile.getTileId()}" />
		<input type="hidden" name="hiddenFolderID" id="hiddenFolderID" value="${ospFolder.getFolderId()}">				
	</form>
	
	<form id="file-delete-form" action="/share/share-file-dashboard!delete.jspa" method="POST" class="result-form-popup ">
		
		<input type="hidden" name="deleteFileIDs" id="deleteFileIDs" value="" />	
		<input type="hidden" name="hiddenTileID" id="hiddenTileID" value="${ospTile.getTileId()}" />
		<input type="hidden" name="hiddenFolderID" id="hiddenFolderID" value="${ospFolder.getFolderId()}">		
		<input type="hidden" name="hiddenCurrPage" id="hiddenCurrPage" value="${currPage}">	
		<#if sortBy??>
			<input type="hidden" name="hiddenSortBy" id="hiddenSortBy" value="${sortBy}">
		<#else>
			<input type="hidden" name="hiddenSortBy" id="hiddenSortBy" value="">
		</#if>
	</form>

<script type="text/javascript">
    
var xhr;
$j(document).ready(function() {
	currPage = 1;
	//processPaginationRequest(currPage, "");	
	processPaginationRequest(currPage, "",10);	
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
	var url = '/share/share-file-dashboard-pagination.jspa';
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
	$j("#folderID").val(${folderID});
	
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
			$j('#rename_popup').show();
		});

		$j('#delete_btn').on('click', function(){
			//$j('#delete_popup').show();
			if( $j(this).hasClass('link_disabled') ) {
				event.stopPropagation();
			} else {
				showDeleteFile();
			}
		});
		
		$j('#download_btn').on('click', function(){
			if( $j(this).hasClass('link_disabled') ) {
				event.stopPropagation();
			} else {
				showDownloadFile();
			}
		});

		$j('#new_Popup').on('click', function(){
			$j('#new_popup').show();
		})
		
		setTimeout(function(){
			changePaginationPos();
		}, 300);
		
		$j( window ).resize(function() {
		  changePaginationPos();
		});		
	
		disableAction();
		
		if(window.location.href.indexOf("validFileSize") > -1) 
		{
			dialog({title:"",html:"The file size should be greater than 0 KB."});
			return false;
		}
		else if(window.location.href.indexOf("validFile") > -1) 
		{
			dialog({title:"",html:"This File Name already exists. Please enter unique File Name"});
			return false;
		}
		
		
    })

   
function disableAction(){
	var actionCont = $j('.action-cont');
	if( actionCont.length ){
		//$j('#copyLink, #new_Popup, #rename_Popup, #delete_btn').addClass('link_disabled');
		$j('#copyLink, #delete_btn, #download_btn').addClass('link_disabled');
	}
}
	
	function showDownloadFile()
	{	
		var downloadFileId = getCheckedAttachmentIds();
		console.log("downloadFileId==>"+downloadFileId);
		$j("#downloadAttachmentIds").val(downloadFileId);
		var downloadFileForm = jQuery("#file-attachment-form");
		downloadFileForm.submit();
	}
	
	function showDeleteFile()
	{	
		var delFileId = getCheckedAttachmentIds();
		console.log("delFileId==>"+delFileId);
		dialog({
				title:"",
				html:'<i class="warningErr"></i><p>Once you delete the file, it will no longer be accessible.</p><p>Are you sure you want to delete the file</p>',
				buttons:{
				"YES":function() {
					$j("#deleteFileIDs").val(delFileId);
					var deleteFileForm = jQuery("#file-delete-form");
					deleteFileForm.submit();
				},
				"NO": function() {
					return false;
				}
				
			},

		});
	}
	
	function getCheckedAttachmentIds(){

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
	

    var attachmentWindow = null;
	
    $j(document).ready(function(){
	
        
		
		  <#if sortBy?? && sortBy!="">
			attachmentWindow = new OSP_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/share/share-file-dashboard!addAttachment.jspa'/>",
            tileID:${ospTile.getTileId()},
            folderID:${ospFolder.getFolderId()},
			currPage:${currPage},
			sortBy:"${sortBy}"
        });	
		<#else>
			attachmentWindow = new OSP_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/share/share-file-dashboard!addAttachment.jspa'/>",
            tileID:${ospTile.getTileId()},
            folderID:${ospFolder.getFolderId()},
			currPage:${currPage}
	
        });	
		</#if>

        $j("#fileAttachBtn").bind('click',function(){
            attachmentWindow.show('1');
        });
		
    });

    function showAttachmentPopup(tileId, folderId) {
         attachmentWindow.show(tileId, folderId);
		 
		
    }
	
	
	
	
</script>
	