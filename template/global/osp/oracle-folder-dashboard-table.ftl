<#--
<div>
    <table id="project_waiver_catalogue_table_body" class="scrollable-table project_status_table table-sorter">
        <thead>
        <tr>
            <th id="waiver-id-header" class="waiver-code-col sortable"><span id="id">NAME</span></th>
            <th id="waiver-name-header" class="waiver-name-col sortable"><span id="name">MODIFIED</span></th>
            <th id="waiver-initiator-header" class="waiver-owner-col"><span id="owner">FILE SIZE</span></th>
        </tr>
        </thead>
        <tbody>
       <#list oracleFolderList as oracleFolder>
        <tr <#if (oracleFolder_index % 2) == 0> class="last"</#if>>
            <td class="waiver-code-col">${oracleFolder.getFolderName()}</td>
         
            <td class="waiver-name-col">${oracleFolder.getModifiedDateString()}</td>
            <td class="waiver-owner-col">${oracleFolder.getFolderSizeString()}</td>
            
            
        </tr>

        </#list>
        </tbody>
    </table>
	
	
   
</div>

-->
 <#--
<table id="project_waiver_catalogue_table_body" class="scrollable-table project_status_table table-sorter">
        <thead>
        <tr>
            <th id="waiver-id-header" class="waiver-code-col sortable"><span id="folderName">Project Code</span></th>
            <th id="waiver-name-header" class="waiver-name-col sortable"><span id="name">Project Name</span></th>
            <th id="waiver-initiator-header" class="waiver-owner-col"><span id="owner">Research End market(s)</span></th>
            <th id="waiver-year-header" class="waiver-year-col sortable"><span id="budgetyear">Budget Year</span></th>
            <th id="waiver-region-header" class="waiver-catalogue-region-col sortable" ><span id="methodologyApprover">Approver Name</span></th>
            <th id="waiver-country-header" class="waiver-catalogue-country-col sortable" ><span id="status">Status</span></th>
			<th id="waiver-country-header" class="waiver-catalogue-country-col" ><span id="action">Action</span></th>
			
			
			
            
        </tr>
           <dl class="table-container table-style ">
                <dt class="table-row">
                    <div class="table-col cont-checkbox"></div>
                    <div class="table-col cont-name sortable"><span id="folderName">NAME<img alt="sorting" src="/themes/rkp_theme/images/osp/oracle/icon-sortBy.png" /></span> </div>
					
                    <div class="table-col cont-modified"><span>MODIFIED<img alt="sorting" src="/themes/rkp_theme/images/osp/oracle/icon-sortBy.png" /></span> </div>
                    <div class="table-col cont-file-size"><span>FILE SIZE<img alt="sorting" src="/themes/rkp_theme/images/osp/oracle/icon-sortBy.png" /> </span></div>
                </dt>

			<#if oracleFolderList?? && oracleFolderList?size gt 0 >
				<#list oracleFolderList as oracleFolder>
					<dd class="table-row">
						<div class="table-col cont-checkbox"></div>
						<div class="table-col cont-name"><span><a class="folder" id = "${oracleFolder.getFolderId()}" href="/oracle/oracle-file-dashboard.jspa?tileID=${oracleFolder.getTileId()}&folderID=${oracleFolder.getFolderId()}" >${oracleFolder.getFolderName()}</a></span></div>
						<div class="table-col cont-modified"><span>${oracleFolder.getModifiedDateString()}</span></div>
						<div class="table-col cont-file-size"><span>${oracleFolder.getFolderSizeString()} </span></div>
					</dd>
				</#list>
			</#if>

				
            </dl>-->
			
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
				<#if oracleFolderList?? && oracleFolderList?size gt 0 >
					<#list oracleFolderList as oracleFolder>
						

						<tr class="table-row">
							<td class="table-col cont-checkbox"></td>
							<#if sortBy??>
								<#if sortOrder??>
									<td class="table-col cont-name"><span><a class="folder" id = "${oracleFolder.getFolderId()}" href="/oracle/oracle-file-dashboard.jspa?tileID=${oracleFolder.getTileId()}&folderID=${oracleFolder.getFolderId()}&currPage=${page}&sortBy=${sortBy}&sortOrder=${sortOrder}"
								>${oracleFolder.getFolderName()}</a></span></td>
								<#else>
									<td class="table-col cont-name"><span><a class="folder" id = "${oracleFolder.getFolderId()}" href="/oracle/oracle-file-dashboard.jspa?tileID=${oracleFolder.getTileId()}&folderID=${oracleFolder.getFolderId()}&currPage=${page}&sortBy=${sortBy}"
								>${oracleFolder.getFolderName()}</a></span></td>
								</#if>
								
							<#else>
								<td class="table-col cont-name"><span><a class="folder" id = "${oracleFolder.getFolderId()}" href="/oracle/oracle-file-dashboard.jspa?tileID=${oracleFolder.getTileId()}&folderID=${oracleFolder.getFolderId()}&currPage=${page}&sortBy="
								>${oracleFolder.getFolderName()}</a></span></td>
							</#if>	
							<td class="table-col cont-modified"><span>${oracleFolder.getModifiedDateString()}</span></td>
							<td class="table-col cont-file-size"><span>${oracleFolder.getFolderSizeString()}</span></td>
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
			
			<#if oracleFolderList?? && oracleFolderList?size == 1 >
				
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