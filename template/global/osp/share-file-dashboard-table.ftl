
			
			<table class="table-container table-style ">
				<thead>
					<tr class="table-row">
						<th class="table-col cont-checkbox"></th>
						<th class="table-col cont-name sortable"><span id="filename">NAME<img alt="sorting" src="/themes/rkp_theme/images/osp/oracle/icon-sortBy.png" /></span> </th>
						
						<th class="table-col cont-modified sortable"><span id="modificationdate">MODIFIED<img alt="sorting" src="/themes/rkp_theme/images/osp/oracle/icon-sortBy.png" /></span> </th>
						<th class="table-col cont-file-size sortable"><span id="filesize">FILE SIZE<img alt="sorting" src="/themes/rkp_theme/images/osp/oracle/icon-sortBy.png" /> </span></th>
					</tr>
				</thead>
				<tbody>
					<#if shareFileList?? && shareFileList?size gt 0 >
						<#list shareFileList as shareFile>
							<tr class="table-row">
								<td class="table-col cont-checkbox"></td>
								<td class="table-col cont-name"><span><a id = "${shareFile.getAttachmentId()?c}" href="<@s.url value="/servlet/JiveServlet/download/${shareFile.getObjectId()?c}-${shareFile.getAttachmentId()?c}/${shareFile.getFileName()?url}" />" >${shareFile.getFileName()}</a></span></td>
								
								
								<td class="table-col cont-modified"><span>${shareFile.getModifiedDateString()}</span></td>
								<td class="table-col cont-file-size"><span>${shareFile.getFileSizeString()}</span></td>
							</tr>
						</#list>
					</#if>
				</tbody>
            </table>
       
<#if pages?? && (pages > 1)>
<div id="pagination"></div>
</#if>
<script type="text/javascript">

<#if plimit??>
	$j("#project-limit").val(${plimit});
</#if>
    <#if pages?? && (pages>0)>
    var pages = ${pages};
    <#else>
    var pages = 1;
    </#if>
    <#if pibMethodologyWaiverList?? && (pibMethodologyWaiverList?size<1) >
    $j("a#continue").hide();
    </#if>


</script>
<script src="${themePath}/js/pagination.custom.js" type="text/javascript"></script>
<script>
    $j(function(){


        $j('.cont-checkbox').click(function(event) {
            $j(this).each(function(event) {
                /* Act on the event */
                if ($j(this).closest('tbody .table-row').hasClass('active')) {
                    $j(this).closest('tbody .table-row').removeClass('active');
                    var header = $j(this).closest('tbody').siblings('thead').children('.table-row');
                    if ( header.hasClass('selectedall') ) {
                      header.removeClass('selectedall');
                      header.removeClass('active');
                    };		
                } else {
                    $j(this).closest('tbody .table-row').addClass('active');
					 if( $j('#pathStatus').parent().hasClass('copy_status') ){
						$j('#pathStatus').text('CREATED').parent().removeClass('copy_status')
					 }
                }

                //select all
                if ($j(this).closest('thead .table-row').hasClass('selectedall')) {
                    $j(this).closest('thead .table-row').removeClass('selectedall');
                    $j(this).closest('thead .table-row').removeClass('active');
                    $j(this).closest('thead').siblings('tbody').children('.table-row').removeClass('active');
					
                } else {
                    $j(this).closest('thead .table-row').addClass('selectedall');
                    $j(this).closest('thead .table-row').addClass('active');
                    $j(this).closest('thead').siblings('tbody').children('.table-row').addClass('active');
                    //console.log('class added');
                }
				
				
            });
			
			if( $j('.table-row.active').length == 1 ){			
				$j('#copyLink, #rename_Popup').removeClass('link_disabled');
			} else {
				$j('#copyLink, #rename_Popup').addClass('link_disabled');
			}
			if( $j('.table-row.active').length >= 1 ){
				$j('#delete_btn').removeClass('link_disabled');
			}else {
				$j('#delete_btn').addClass('link_disabled');
			}
			if( $j('.table-row.active').length >= 1 ){
				$j('#download_btn').removeClass('link_disabled');
			}else {
				$j('#download_btn').addClass('link_disabled');
			}
        });

		anchorAsPerExt();	

		if( $j('#table-main tbody').find('tr').length == 0 ){
			$j('#table-main').hide();
		}
    })

    function anchorAsPerExt() {
        
        if ( $j('#table-main .table-container a').length ) {
			$j('#table-main .table-container a').each( function() {
				//debugger;                
                //var hrefExt = $j(this).attr('href');
                /*var hrefExt = $j(this).context.href	;
                hrefExt = hrefExt.trim().toLowerCase();
                hrefExt = hrefExt.split(".");
                hrefExt = hrefExt[hrefExt.length-1];*/
				
				var hrefExt = $j(this).context.href.trim().toLowerCase().split(".");
				
				hrefExt = hrefExt[hrefExt.length-1];
                if( $j(this).hasClass('folder') ){
                        $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-folder.png" />');
                } else if ( hrefExt == 'ppt' ||  hrefExt == 'pptx') {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file-ppt.png" />');
                }else if ( hrefExt == 'doc' ||  hrefExt == 'docx' ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file-word.png" />');
                }else if ( hrefExt == 'xls' ||  hrefExt == 'xlsx' ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file-excel.png" />');
                }else if (  hrefExt == 'mp4' ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file-mp4.png" />');
                }else if (   hrefExt == 'mp3' ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file-mp3.png" />');
                }
				else if (   hrefExt == 'txt' ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file-txt.png" />');
                }
				
				else if  ((   hrefExt == 'jpeg' )|| (   hrefExt == 'jpg' ) || (  hrefExt == 'png' ) || (   hrefExt == 'gif' ) ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file-img.png" />');
                }
				
				else if  ((   hrefExt == 'zip' )|| (   hrefExt == 'rar' )) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file-zip.png" />');
                }
				else if  (   hrefExt == 'pdf' ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file-pdf.png" />');
                }
				else {
                    
					$j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/oracle/icon-file.png" />');
                }
				
				
				
				
            })
            
        }
        
    }
	
	
	
	
	
	
	
	
    </script>

	