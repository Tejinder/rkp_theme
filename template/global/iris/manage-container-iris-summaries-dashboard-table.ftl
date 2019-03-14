
 
			
		<!-- 	<table class="table-container table-style ">
			<thead>
                <tr class="table-row">
                    
					<#if endMarketID?? && endMarketID == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER>
						<th class="table-col cont-checkbox"></th>
					</#if>	
                    <th class="table-col cont-folder-name"><span id="projectname">NAME</span> </th>
					
                    <th class="table-col cont-modified"><span id="modificationdate">MODIFIED</span> </th>
					<th class="table-col cont-modified"><span id="modificationdate">Report Date</span> </th>
                   
                </tr>
			</thead>
			<tbody>
				<#if irisSummaryList?? && irisSummaryList?size gt 0 >
					<#list irisSummaryList as irisSummary>
						
			
						<tr class="table-row">
						
							<#if endMarketID?? && endMarketID == statics['com.grail.util.BATConstants'].IRIS_SUMMARY_ADMIN_FOLDER>
								<td class="table-col cont-checkbox"></td>
							</#if>	
							<td class="table-col cont-name"><span><a class="folder" id = "${irisSummary.irisSummaryId?c}" target="_blank" href="/iris-summary/view-summary!input.jspa?irisSummaryId=${irisSummary.irisSummaryId?c}"
								>${irisSummary.projectName}</a></span></td>
								
							<td class="table-col cont-modified"><span><#if irisSummary.modifiedDateString?? > ${irisSummary.modifiedDateString} <#else> - </#if></span></td>
							
							<td class="table-col cont-modified"><span><#if irisSummary.finalReportDate?? >${irisSummary.finalReportDate?string('dd/MM/yyyy')} <#else> - </#if></span></td>
							
						</tr>
					</#list>
				</#if>

				</tbody>
            </table> -->

<div class="rTableBoxOuterWrap adminWrapSpace">

                    <div class="rTableBoxWrap">

							<div class="rTableRowBoxWrap">
								<div class="rTableHeadBoxWrap"><strong>NAME</strong></div>
								<div class="rTableHeadBoxWrap"><strong>MODIFIED</strong></div>
								<div class="rTableHeadBoxWrap"><strong>REPORT DATE</strong></div>
							</div>

							<#if irisSummaryList?? && irisSummaryList?size gt 0 >
								<#list irisSummaryList as irisSummary>
									<div class="rTableRowBoxWrap">

									   <div class="rTableCellBoxWrapLeft">

											   <label class="checkboxContainer">
				                                 <input type="checkbox" class="adminSectionCheckbox" value='${irisSummary.irisSummaryId?c}' >
				                                 <span class="checkmark"></span>
				                               </label>

												<a  id = "${irisSummary.irisSummaryId?c}" target="_blank" href="/iris-summary/view-summary!input.jspa?irisSummaryId=${irisSummary.irisSummaryId?c}"
								><#if irisSummary.projectName?? && irisSummary.projectName!="">${irisSummary.projectName}<#else>-</#if></a>
									   </div>

									    <div class="rTableCellBoxWrapRight"><#if irisSummary.modifiedDateString?? > ${irisSummary.modifiedDateString} <#else> - </#if></div>
										 
									   <div class="rTableCellBoxWrapRight"><#if irisSummary.finalReportDate?? >${irisSummary.finalReportDate?string('dd/MM/yyyy')} <#else> - </#if></div>

									</div>
								</#list>
							</#if>
							
					</div>



<#if pages?? && (pages > 1)>
<div id="pagination"></div>
</#if>


</div>





<!-- <script>
	  $j(document).ready(function(){
    $j('.rTableRowBoxWrap')
        .mouseenter(function () {
            $j(".rTableBoxWrap .rTableCellBoxWrapLeft label").show();

            $j(".rTableCellBoxWrapLeft label").css('display','block');



            alert('vinod');
        })
        .mouseleave(function () {
            if ($j(".rTableBoxWrap .rTableCellBoxWrapLeft input").is(":checked"))
            	alert('hooda');
                $j(".rTableBoxWrap .rTableCellBoxWrapLeft label").show();
            else
                $j(".rTableBoxWrap .rTableCellBoxWrapLeft label").hide();
        });
        });
</script> -->




<script type="text/javascript">
    $j(document).ready(function(){

            $j('.adminSectionCheckbox').click(function () {   	 
            
        	var irisAdminSection =false;
			var isSelected = false;
        	 $j('.adminSectionCheckbox').each(function(){

                      if($j(this).prop("checked") == true){  
                       
                           
                         

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
			$j('#move_Button').removeClass('link_disabled');

			 $j('.irisAdminSectionWrap #delete_Button .bottomBtnWrapAlign,.irisAdminSectionWrap #move_Button .bottomBtnWrapAlign').addClass('pointerEventsAuto').removeClass('pointerEventsNone');	
		}
		else
		{
			$j('#delete_Button').addClass('link_disabled');	
			$j('#move_Button').addClass('link_disabled');	
			$j('.irisAdminSectionWrap #delete_Button .bottomBtnWrapAlign,.irisAdminSectionWrap #move_Button .bottomBtnWrapAlign').addClass('pointerEventsNone').removeClass('pointerEventsAuto'); 

		            
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
