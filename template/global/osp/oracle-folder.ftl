
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Bootstrap 101 Template</title>
    <!-- Bootstrap -->
    <!-- <link href="css/bootstrap.min.css" rel="stylesheet"> -->
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
</head>

<body>
    <main>
        <div class="popupCont" id='copyLink_popup'>
			<div class="ui-dialog ui-widget ui-widget-content ui-corner-all" tabindex="-1" role="dialog" aria-labelledby="ui-id-1">
				<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"><span id="ui-id-1" class="ui-dialog-title">&nbsp;</span><a href="#" class="ui-dialog-titlebar-close ui-corner-all" role="button"><span class="ui-icon ui-icon-closethick">close</span></a></div>
				<div id="project-create-options" class="ui-dialog-content ui-widget-content" scrolltop="0" scrollleft="0">
				 <p>LINK to 'FOLDER 1' CREATED</p>
				 <div class="cont-popupFields">
				  <form action="">
				   <input type="text" name="copyLinkField" id="copyLinkField" value="">
				   <input type="submit" onclick="return copyToClipboard('#copyLinkField')"  value="COPY">
				   
				  </form>
				 </div>
				 <div class="cont-popFooter">
				  Only people with ORACLE access have permission to view this link 
				 </div>
				</div>
			</div>
		</div>
		
		<div class="popupCont" id='rename_popup'>
			<div class="ui-dialog ui-widget ui-widget-content ui-corner-all" tabindex="-1" role="dialog" aria-labelledby="ui-id-1">
				<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"><span id="ui-id-1" class="ui-dialog-title">&nbsp;</span><a href="#" class="ui-dialog-titlebar-close ui-corner-all" role="button"><span class="ui-icon ui-icon-closethick">close</span></a></div>
				<div id="project-create-options" class="ui-dialog-content ui-widget-content" scrolltop="0" scrollleft="0">
				 <div class="cont-popupFields">
				  
				  <form id="folder-rename-form" action="/oracle/folder!renameFolder.jspa" method="POST">
					
					<label>Folder Name </label>
						<input type="text" tabindex="1" name="renameFolderName" id="renameFolderName" value="" /> 
						<input type="Submit" value="RENAME" onclick="submitFolderRename()"/>
					
					<input type="hidden" name="tileID" id="tileID" value="${ospTile.getTileId()}" />	
					<input type="hidden" name="renameFolderID" id="renameFolderID" value="" />	
					
				</form>
				 
				 </div>
				
				</div>
			</div>
		</div>
		
		<div class="popupCont" id='new_popup'>
			<div class="ui-dialog ui-widget ui-widget-content ui-corner-all" tabindex="-1" role="dialog" aria-labelledby="ui-id-1">
				<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"><span id="ui-id-1" class="ui-dialog-title">&nbsp;</span><a href="#" class="ui-dialog-titlebar-close ui-corner-all" role="button"><span class="ui-icon ui-icon-closethick">close</span></a></div>
				<div id="project-create-options" class="ui-dialog-content ui-widget-content" scrolltop="0" scrollleft="0">
				
				 <div class="cont-popupFields">
				
				 
				 <label>Folder Name </label>
				  <form id="folder-create-form" action="/oracle/folder!execute.jspa" method="POST">
				   <input type="text" tabindex="1" name="folderName" id="folderName" value="" /> 
				   <input type="submit" onclick="submitFolderCreate()" value="CREATE">
				   <input type="hidden" name="tileID" id="tileID" value="${ospTile.getTileId()}" />
				  </form>
				 </div>
				 
				</div>
			</div>
		</div> 
		<div class="action-cont">
			<a href="#" class="link copy" id="copyLink"><img src="/themes/rkp_theme/images/osp/oracle/icon-locked-file.png" alt="">COPY LINK</a>
			<a href="#" class="link download"><img src="/themes/rkp_theme/images/osp/oracle/icon-download.png" alt="">DOWNLOAD</a>

			<a href="#" class="link download"    id="new_Popup" onclick="showCreateFolder()">NEW</a>	
			<a href="#" class="link download"    onclick="showDeleteFolder()" >DELETE</a>	
			<a href="#" class="link download"    id="rename_Popup" onclick="showRenameFolder()">RENAME</a>			
		</div>
		
        <div class="cont-gray">
            <div class="breadcrumb">
                <a href="/portal-options.jspa"><span>OSP</span></a>
                <a href="/oracle/home.jspa"><span>ORACLE</span></a>
                <a href="#"><span>${ospTile.getTileName()}</span></a>
            </div>
            <dl class="table-container table-style">
                <dt class="table-row">
                    <div class="table-col cont-checkbox"></div>
                    <div class="table-col cont-name"><span>NAME</span></div>
                    <div class="table-col cont-modified"><span>MODIFIED</span></div>
                    <div class="table-col cont-file-size"><span>FILE SIZE</span></div>
                </dt>

				<#if oracleFolderList?? && oracleFolderList?size gt 0 >
					<#list oracleFolderList as oracleFolder>
						

						<dd class="table-row">
							<div class="table-col cont-checkbox"></div>
							<div class="table-col cont-name"><span><a class="folder" id = "${oracleFolder.getFolderId()}" href="/oracle/file!input.jspa?tileID=${oracleFolder.getTileId()}&folderID=${oracleFolder.getFolderId()}" >${oracleFolder.getFolderName()} </a></span></div>
							<div class="table-col cont-modified"><span>${oracleFolder.getModifiedDateString()}</span></div>
							<div class="table-col cont-file-size"><span>${oracleFolder.getFolderSize()} KB</span></div>
						</dd>
					</#list>
				</#if>

				
            </dl>
        </div>
    </main>

<!--	<div id="create-folder-Div" class="evaluation_report qpr-snaphot wellLayoutPop" style="display:none">
		<div class="j-form-popup">
			<a href="javascript:void(0);" class="close"></a>
			<div class="popup-title-overlay"></div>
			<div class="pop-upinner-scroll">
				<form id="folder-create-form" action="/oracle/folder!execute.jspa" method="POST" class="result-form-popup ">
					<div class="region-inner">
					<label>Folder Name </label>
						<input type="text" tabindex="1" name="folderName" id="folderName" value="" /> 
						<input type="button" value="Open" onclick="submitFolderCreate()" class="btn-blue" />
					</div>
					<input type="hidden" name="tileID" id="tileID" value="${ospTile.getTileId()}" />					
				</form>
			</div>
		</div>
	</div>

	<div id="rename-folder-Div" class="evaluation_report qpr-snaphot wellLayoutPop" style="display:none">
		<div class="j-form-popup">
			<a href="javascript:void(0);" class="close"></a>
			<div class="popup-title-overlay"></div>
			<div class="pop-upinner-scroll">
				<form id="folder-rename-form" action="/oracle/folder!renameFolder.jspa" method="POST" class="result-form-popup ">
					<div class="region-inner">
					<label>Folder Name </label>
						<input type="text" tabindex="1" name="renameFolderName" id="renameFolderName" value="" /> 
						<input type="button" value="Open" onclick="submitFolderRename()" class="btn-blue" />
					</div>
					<input type="hidden" name="tileID" id="tileID" value="${ospTile.getTileId()}" />	
					<input type="hidden" name="renameFolderID" id="renameFolderID" value="" />		
				</form>
			</div>
		</div>
	</div>
-->

	<form id="folder-delete-form" action="/oracle/folder!delete.jspa" method="POST" class="result-form-popup ">
		<input type="hidden" name="deleteFolderIDs" id="deleteFolderIDs" value="" />	
		<input type="hidden" name="tileID" id="tileID" value="${ospTile.getTileId()}" />							
	</form>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
   
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <!-- <script src="js/bootstrap.min.js"></script> -->
    <script>
    $j(function(){


        $j('.cont-checkbox').click(function(event) {
          console.log('clicked');
            $j(this).each(function(event) {
                /* Act on the event */
                console.log('each');
                if ($j(this).closest('dd.table-row').hasClass('active')) {
                    $j(this).closest('dd.table-row').removeClass('active');
                    var header = $j(this).parent('dd').siblings('dt.table-row');
                    if ( header.hasClass('selectedall') ) {
                     // alert('');
                      header.removeClass('selectedall');
                      header.removeClass('active');
                    }
                      
                    console.log('class removed');
                } else {
                    $j(this).closest('dd.table-row').addClass('active');
                    console.log('class added');
                }

                //select all
                if ($j(this).closest('dt.table-row').hasClass('selectedall')) {
                    $j(this).closest('dt.table-row').removeClass('selectedall');
                    $j(this).closest('dt.table-row').removeClass('active');
                    $j(this).parent('dt.table-row').siblings('dd.table-row').removeClass('active');
                    console.log('class removed');
                } else {
                    $j(this).closest('dt.table-row').addClass('selectedall');
                    $j(this).closest('dt.table-row').addClass('active');
                    $j(this).parent('dt.table-row').siblings('dd.table-row').addClass('active');
                    console.log('class added');
                }
            });
        });

		anchorAsPerExt();	

			$j('.ui-icon-closethick').on('click', function(){
		 $j(this).closest('.popupCont').hide()
		});

		$j('#copyLink').on('click', function(){
			$j('#copyLinkField').val(getCheckedCopyURL());
			$j('#copyLink_popup').show();
		});

		$j('#rename_Popup').on('click', function(){
			$j('#rename_popup').show();
		});

		$j('#delete_Popup').on('click', function(){
			$j('#delete_popup').show();
		});

		$j('#new_Popup').on('click', function(){
			$j('#new_popup').show();
		})
		
    })

    function anchorAsPerExt() {
        
        if ( $j('a').length ) {
            $j('a').each( function() {
				//debugger;                
                //var hrefExt = $j(this).attr('href');
                var hrefExt = $j(this).context.href	;
                hrefExt = hrefExt.trim().toLowerCase();
                if( $j(this).hasClass('folder') ){
                        $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-folder.png" />');
                } else if ( hrefExt.indexOf('.pptx') != -1 ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file-ppt.png" />');
                }else if ( hrefExt.indexOf('.docx') != -1 ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file-word.png" />');
                }else if ( hrefExt.indexOf('.xlsx') != -1 ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file-excel.png" />');
                }else if ( hrefExt.indexOf('.mp4') != -1 ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file-mp4.png" />');
                }else if ( hrefExt.indexOf('.mp3') != -1 ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file-mp3.png" />');
                }
            })
            
        }
        
    }
	/*
	function showCreateFolder()
	{
		$j("#create-folder-Div").lightbox_me({centered:true,closeEsc:false,closeClick:false,overlayCSS:{background: 'black', opacity: .7}});
	}

	function showRenameFolder()
	{
		$j("#rename-folder-Div").lightbox_me({centered:true,closeEsc:false,closeClick:false,overlayCSS:{background: 'black', opacity: .7}});
	}
*/
	function submitFolderCreate()
	{
		var folderName = $j("#folderName").val();
	
		if(folderName=="")
		{
			dialog({title:"Message",html:"Please enter Folder Name"});
			return false;
		}
		else
		{
			var createFolderForm = $j("#folder-create-form");
			createFolderForm.submit();
		}
	}
	
	function submitFolderRename()
	{
		var renameFolderName = $j("#renameFolderName").val();
	
		if(renameFolderName=="")
		{
			dialog({title:"Message",html:"Please enter Folder Name"});
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
	
	function getCheckedCopyURL(){

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
		
		
		document.execCommand("copy");
		temp.remove();
		return false;
	}
	
    </script>
</body>

</html>