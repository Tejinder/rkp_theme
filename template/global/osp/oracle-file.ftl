
<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#-- DWR def -->
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


<script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>

<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/commons.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/form-data-persist-handler.js?version=1" type="text/javascript"></script>

<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.MultiFile.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ajaxfileupload.js'/>"></script>
 




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
		
        <div class="action-cont">
			
			<a href="#" class="link copy" id="copyLink"><img src="/themes/rkp_theme/images/osp/oracle/icon-locked-file.png" alt="">COPY LINK</a>
			<a href="javascript:void(0);" class="link download" onclick="showDownloadFile()"><img src="/themes/rkp_theme/images/osp/icon-download.png" alt="">DOWNLOAD</a>
			<a href="javascript:void(0);" class="link download" onclick="showAttachmentPopup()"><img src="/themes/rkp_theme/images/osp/icon-download.png" alt="">UPLOAD</a>
			<a href="javascript:void(0);" class="link download" onclick="showDeleteFile()" ><img src="/themes/rkp_theme/images/osp/icon-download.png" alt="">DELETE</a>	
		</div>
        <div class="cont-gray">
            <div class="breadcrumb">
                <a href="/portal-options.jspa"><span>OSP</span></a>
                <a href="/oracle/home.jspa"><span>ORACLE</span></a>
                <a href="/oracle/folder!input.jspa?tileID=${ospTile.getTileId()}"><span>${ospTile.getTileName()}</span></a>
				<a href="#"><span>${ospFolder.getFolderName()}</span></a>
            </div>
            <dl class="table-container table-style">
                <dt class="table-row">
                    <div class="table-col cont-checkbox"></div>
                    <div class="table-col cont-name"><span>NAME</span></div>
                    <div class="table-col cont-modified"><span>MODIFIED</span></div>
                    <div class="table-col cont-file-size"><span>FILE SIZE</span></div>
                </dt>

			<#if oracleFileList?? && oracleFileList?size gt 0 >
				<#list oracleFileList as oracleFile>
					<dd class="table-row">
						<div class="table-col cont-checkbox"></div>
						<div class="table-col cont-name"><span><a id = "${oracleFile.getAttachmentId()?c}" href="<@s.url value="/servlet/JiveServlet/download/${oracleFile.getObjectId()?c}-${oracleFile.getAttachmentId()?c}/${oracleFile.getFileName()?url}" />" >${oracleFile.getFileName()} </a></span></div>
						
						
						
							
						<div class="table-col cont-modified"><span>${oracleFile.getModifiedDateString()}</span></div>
						<div class="table-col cont-file-size"><span>${oracleFile.getFileSize()} KB</span></div>
					</dd>
				</#list>
			</#if>

				
            </dl>
        </div>
	<input type="hidden" name="tileID" value="">
	<input type="hidden" name="folderID" value="">
    
	</main>
	
	
	<form id="file-attachment-form" action="/oracle/file!download.jspa" method="POST" class="result-form-popup ">
		<input type="hidden" name="downloadAttachmentIds" id="downloadAttachmentIds" value="" />	
		<input type="hidden" name="tileID" value="${ospTile.getTileId()}">
		<input type="hidden" name="folderID" value="${ospFolder.getFolderId()}">			
	</form>
	
	<form id="file-delete-form" action="/oracle/file!delete.jspa" method="POST" class="result-form-popup ">
		
		<input type="hidden" name="deleteFileIDs" id="deleteFileIDs" value="" />	
		<input type="hidden" name="tileID" value="${ospTile.getTileId()}">
		<input type="hidden" name="folderID" value="${ospFolder.getFolderId()}">		
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


<script type="text/javascript">
    var attachmentWindow = null;
	
    $j(document).ready(function(){
        attachmentWindow = new OSP_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/oracle/file!addAttachment.jspa'/>",
            tileID:${ospTile.getTileId()},
            folderID:${ospFolder.getFolderId()},
           

        });
		
		

        $j("#fileAttachBtn").bind('click',function(){
            attachmentWindow.show('1');
        });
    });

    function showAttachmentPopup(tileId, folderId) {
         attachmentWindow.show(tileId, folderId);
		 
		
    }
	
	
</script>