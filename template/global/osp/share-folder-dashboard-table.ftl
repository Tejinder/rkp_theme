
			
			<table class="table-container table-style ">
			<thead>
                <tr class="table-row">
                    <th class="table-col cont-checkbox"></th>
                    <th class="table-col cont-folder-name sortable"><span id="foldername">NAME<img alt="sorting" src="/themes/rkp_theme/images/osp/oracle/icon-sortBy.png" /></span> </th>
					
                    <th class="table-col cont-modified sortable"><span id="modificationdate">MODIFIED<img alt="sorting" src="/themes/rkp_theme/images/osp/oracle/icon-sortBy.png" /></span> </th>
                    <th class="table-col cont-file-size sortable"><span id="foldersize">FILE SIZE<img alt="sorting" src="/themes/rkp_theme/images/osp/oracle/icon-sortBy.png" /> </span></th>
                </tr>
			</thead>
			<tbody>
				<#if shareFolderList?? && shareFolderList?size gt 0 >
					<#list shareFolderList as shareFolder>
						

						<tr class="table-row">
							<td class="table-col cont-checkbox"></td>
							
							<#if sortBy??>
								<#if sortOrder??>
									<td class="table-col cont-name"><span><a class="folder" id = "${shareFolder.getFolderId()}" href="/share/share-file-dashboard.jspa?tileID=${shareFolder.getTileId()}&folderID=${shareFolder.getFolderId()}&currPage=${page}&sortBy=${sortBy}&sortOrder=${sortOrder}"
								>${shareFolder.getFolderName()}</a></span></td>
								<#else>
										<td class="table-col cont-name"><span><a class="folder" id = "${shareFolder.getFolderId()}" href="/share/share-file-dashboard.jspa?tileID=${shareFolder.getTileId()}&folderID=${shareFolder.getFolderId()}&currPage=${page}&sortBy=${sortBy}"
								>${shareFolder.getFolderName()}</a></span></td>
								</#if>
								
							
							<#else>
								<td class="table-col cont-name"><span><a class="folder" id = "${shareFolder.getFolderId()}" href="/share/share-file-dashboard.jspa?tileID=${shareFolder.getTileId()}&folderID=${shareFolder.getFolderId()}&currPage=${page}&sortBy="
								>${shareFolder.getFolderName()}</a></span></td>
							</#if>	
							<td class="table-col cont-modified"><span>${shareFolder.getModifiedDateString()}</span></td>
							<td class="table-col cont-file-size"><span>${shareFolder.getFolderSizeString()}</span></td>
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
			
			<#if shareFolderList?? && shareFolderList?size == 1 >
				
				if( $j('.table-row.active').length == 1 || $j('.table-row.active').length == 2 )
				{			
					$j('#copyLink, #rename_Popup').removeClass('link_disabled');
				}
				else 
				{
					$j('#copyLink, #rename_Popup').addClass('link_disabled');
				}
			</#if>
			
        });

		anchorAsPerExt();	

		
		if( $j('#table-main tbody').find('tr').length == 0 ){
			$j('#table-main').hide();
		}
    })

    function anchorAsPerExt() {
        
        if ( $j('a').length ) {
            $j('a').each( function() {
				//debugger;                
                //var hrefExt = $j(this).attr('href');
                var hrefExt = $j(this).context.href	;
                hrefExt = hrefExt.trim().toLowerCase();
                if( $j(this).hasClass('folder') ){
                        $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/share/icon-folder.png" />');
                } else if ( hrefExt.indexOf('.pptx') != -1 ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/share/icon-file-ppt.png" />');
                }else if ( hrefExt.indexOf('.docx') != -1 ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/share/icon-file-word.png" />');
                }else if ( hrefExt.indexOf('.xlsx') != -1 ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/share/icon-file-excel.png" />');
                }else if ( hrefExt.indexOf('.mp4') != -1 ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/share/icon-file-mp4.png" />');
                }else if ( hrefExt.indexOf('.mp3') != -1 ) {
                    $j(this).prepend('<img alt="'+$j(this).text()+'" src="/themes/rkp_theme/images/osp/share/icon-file-mp3.png" />');
                }
            })
            
        }
        
    }

	

	
    </script>