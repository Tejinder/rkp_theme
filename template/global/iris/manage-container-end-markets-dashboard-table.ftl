
 
			<#--
			<table class="table-container table-style ">
			<thead>
                <tr class="table-row">
                   
                    <th class="table-col cont-folder-name"><span id="projectname">NAME</span> </th>
					
                    <th class="table-col cont-modified"><span id="modificationdate">MODIFIED</span> </th>
					<th class="table-col cont-modified"><span id="modificationdate">SUMMARIES</span> </th>
                   
                </tr>
			</thead>
			<tbody>
				<#if irisContainerEndMarketList?? && irisContainerEndMarketList?size gt 0 >
					<#list irisContainerEndMarketList as irisContainerEndMarket>
						
			
						<tr class="table-row">
						
							<td class="table-col cont-name"><span><a class="folder" id = "" href="/iris-summary/container-iris-summaries.jspa?endMarketID=${irisContainerEndMarket.endMarketId}"
								>${irisContainerEndMarket.endMarketContainerName}</a></span></td>
								
							<td class="table-col cont-modified"><span><#if irisContainerEndMarket.lastModifiedDate?? > ${irisContainerEndMarket.lastModifiedDate} <#else> - </#if></span></td>
							
							<td class="table-col cont-modified"><span><#if irisContainerEndMarket.numberOfIRISSummaries?? >${irisContainerEndMarket.numberOfIRISSummaries} <#else> - </#if></span></td>
							
						</tr>
					</#list>
				</#if>

				</tbody>
            </table>
       
<#if pages?? && (pages > 1)>
<div id="pagination"></div>
</#if>
-->


<div class="rTableBoxOuterWrap adminFolderSectionWrap">

		<div class="rTableBoxWrap">

				<div class="rTableRowBoxWrap">
					<div class="rTableHeadBoxWrap"><strong>NAME</strong></div>
					<div class="rTableHeadBoxWrap"><strong>MODIFIED</strong></div>
					<div class="rTableHeadBoxWrap"><strong>SUMMARIES</strong></div>
					
					
					
				</div>

				<#if irisContainerEndMarketList?? && irisContainerEndMarketList?size gt 0 >
					<#list irisContainerEndMarketList as irisContainerEndMarket>
						<div class="rTableRowBoxWrap">

						   <div class="rTableCellBoxWrapLeft folderAlign">

								<a id = "" href="/iris-summary/container-iris-summaries.jspa?endMarketID=${irisContainerEndMarket.endMarketId}"
									><img src="${themePath}/images/iris/folder-icon.png">${irisContainerEndMarket.endMarketContainerName}</a>  

								
								
						   </div>

							<div class="rTableCellBoxWrapRight"><#if irisContainerEndMarket.lastModifiedDate?? > ${irisContainerEndMarket.lastModifiedDate} <#else> - </#if></div>
							<div class="rTableCellBoxWrapRight"><#if irisContainerEndMarket.numberOfIRISSummaries?? >${irisContainerEndMarket.numberOfIRISSummaries} <#else> - </#if></div>
							 
						   

						</div>
					</#list>
				</#if>
				
		</div>



<#if pages?? && (pages > 1)>
<div id="pagination"></div>
</#if>


</div>

<script type="text/javascript">

<#if plimit??>
	$j("#project-limit").val(${plimit});
</#if>
    <#if pages?? && (pages>0)>
    var pages = ${pages};
    <#else>
    var pages = 1;
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
			
			
        });

		anchorAsPerExt();	

		/*
		if( $j('#table-main tbody').find('tr').length == 0 ){
			$j('#table-main').hide();
		}
		*/
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

	

	
    </script>