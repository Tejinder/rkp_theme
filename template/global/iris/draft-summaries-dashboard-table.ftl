
 
			<#--
			<table class="table-container table-style ">
			<thead>
                <tr class="table-row">
                    <th class="table-col cont-checkbox"></th>
                    <th class="table-col cont-folder-name sortable"><span id="projectname">NAME<img alt="sorting" src="/themes/rkp_theme/images/osp/oracle/icon-sortBy.png" /></span> </th>
					
                    <th class="table-col cont-modified sortable"><span id="modificationdate">MODIFIED<img alt="sorting" src="/themes/rkp_theme/images/osp/oracle/icon-sortBy.png" /></span> </th>
                   
                </tr>
			</thead>
			<tbody>
				<#if irisSummaryList?? && irisSummaryList?size gt 0 >
					<#list irisSummaryList as irisSummary>
						
			
						<tr class="table-row">
							<td class="table-col cont-checkbox"></td>
							<td class="table-col cont-name"><span><a class="folder" target="_blank" id = "${irisSummary.irisSummaryId?c}" href="/iris-summary/edit-summary!input.jspa?irisSummaryId=${irisSummary.irisSummaryId?c}"
								>${irisSummary.projectName}</a></span></td>
								
							<td class="table-col cont-modified"><span>${irisSummary.modifiedDateString}</span></td>
							
						</tr>
					</#list>
				</#if>

				</tbody>
            </table>
			-->
       

	   <div class="rTableBoxOuterWrap">

		<div class="rTableBoxWrap">

				<div class="rTableRowBoxWrap">
					<div class="rTableHeadBoxWrap"><strong>NAME</strong></div>
					<div class="rTableHeadBoxWrap"><strong>MODIFIED</strong></div>
					
				</div>

				<#if irisSummaryList?? && irisSummaryList?size gt 0 >
					<#list irisSummaryList as irisSummary>
						<div class="rTableRowBoxWrap">

						   <div class="rTableCellBoxWrapLeft">

								   <label class="checkboxContainer">
									 <input type="checkbox" class="adminSectionCheckbox" value='${irisSummary.irisSummaryId?c}' >
									 <span class="checkmark"></span>
								   </label>

									<a  id = "${irisSummary.irisSummaryId?c}" target="_blank" href="/iris-summary/edit-summary!input.jspa?irisSummaryId=${irisSummary.irisSummaryId?c}"
					><#if irisSummary.projectName?? && irisSummary.projectName!="">${irisSummary.projectName}<#else>-</#if></a>
						   </div>

							<div class="rTableCellBoxWrapRight"><#if irisSummary.modifiedDateString?? > ${irisSummary.modifiedDateString} <#else> - </#if></div>
							 
						   

						</div>
					</#list>
				</#if>
				
		</div>



<#if pages?? && (pages > 1)>
<div id="pagination"></div>
</#if>


</div>
	
<script type="text/javascript">
    $j(document).ready(function(){

            $j('.adminSectionCheckbox').click(function () {   	 
            
        	var irisAdminSection =false;
			var isSelected = false;
        	 $j('.adminSectionCheckbox').each(function(){

                    if($j(this).prop("checked") == true)
					{
                        $j(this).parent().css('display','block');
                        // $j(this).parents('.rTableCellBoxWrapLeft').parent().css({'background-color':'#ddd','color':'#000'});            
						
						isSelected = true;
                           
		            }
					else if(($j(this).prop("checked") == false))
	        		{
						// $j(this).parents('.rTableCellBoxWrapLeft').parent().css({'background-color':'#fff','color':'#000'});  
		             	$j(this).parent().removeAttr('style');     				          
		            }
        
        });   
		if(isSelected==true)
		{
			$j('#delete_Button').removeClass('link_disabled');
           	 $j('.irisAdminSectionWrap #delete_Button .bottomBtnWrapAlign').addClass('pointerEventsAuto').removeClass('pointerEventsNone');			
		}
		else
		{
			$j('#delete_Button').addClass('link_disabled');	
				$j('.irisAdminSectionWrap #delete_Button .bottomBtnWrapAlign').addClass('pointerEventsNone').removeClass('pointerEventsAuto'); 
		}
		
	});
});

</script> 
	
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
