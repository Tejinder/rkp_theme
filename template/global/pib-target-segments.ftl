<#include "/template/global/include/form-message.ftl" />

<#assign disableFields = false />
<#if isExternalAgencyUser >
<#assign disableFields = true />
</#if>

<@renderReferencebrand name='targeSegment' value=referenceBrandList disableFields=disableFields/>
<#if !(statics['com.grail.synchro.SynchroGlobal'].getPIBFieldsByMethodology().get(project.methodology?int)?? && statics['com.grail.synchro.SynchroGlobal'].getPIBFieldsByMethodology().get(project.methodology?int).contains("targetSegment")) >
<@renderTargetSegments name='targeSegment' value=targetSegmentsList disableFields=disableFields/>
</#if>
<@renderSmokerGroup name='targeSegment' value=smokerGroupList disableFields=disableFields/>

<#macro renderReferencebrand name='' value=[] multiselect=false disableFields=disableFields>
   
<div class="end_market_details"">
	<div class="end_market_forms synchro_form">
	  <h3 id="referenceBrandBlock">Reference Brand <a id="referenceBrandLegend" href="#" class="close-form" onclick="javascript:toggleReferenceBrandBlock();"></a></h3>
		<#if referenceBrandList?has_content>
		   <div class="content_div" id="referenceBrandDiv">
		    <#list referenceBrandList as referenceBrand>
				 
				 	<div class="end-market-main">
	                <div class="form-text_div">
	                    <label>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(referenceBrand.getEndmarketID()?int)}</label>
	                 
	               
	                   <@showProductBrandFieldSection selectedBrandIdList=referenceBrand.getBrandId() name='referenceBrand${referenceBrand.getEndmarketID()}' value=project.brand?default(-1) selectedEndMarket=referenceBrand.getEndmarketID() disableFields=disableFields/>
	                    
	                 </div>
                	</div>
				 </#list>
			</div>
		<#else>
		    No Endmarkets selected for this project.
		</#if>
	</div>
</div>
<span id="referenceBrandError" class="jive-error-message" style="display:none">Please Select Reference Brand</span>
</#macro>

<#macro renderTargetSegments name='' value=[] multiselect=false disableFields=disableFields>
    
<div class="end_market_details"">
	<div class="end_market_forms synchro_form">
		<h3 id="targetSegmentBlock">Target Segment <a id="targetSegmentLegend" href="#" class="close-form" onclick="javascript:toggleTargetSegmentBlock();"></a></h3>
		<#if targetSegmentsList?has_content>
		   <div class="content_div" id="targetSegmentDiv">
		    <#list targetSegmentsList as targetSegment>
	                <div class="end-market-main" >
	                	<div class="research-form-text_div">
	                    <label>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(targetSegment.getEndmarketID()?int)}</label>
	                 
	                    <textarea id="segementDetail${targetSegment.getEndmarketID()}" name="segementDetail${targetSegment.getEndmarketID()}" rows="10" cols="20" class="form-text-div" <#if disableFields>disabled</#if> onKeyDown="limitText('segementDetail${targetSegment.getEndmarketID()}', 'segementDetail${targetSegment.getEndmarketID()}countdown', 900);" 
onKeyUp="limitText('segementDetail${targetSegment.getEndmarketID()}', 'segementDetail${targetSegment.getEndmarketID()}countdown', 900);" >${targetSegment.segementDetail?default('')}</textarea>
		                <@macroFieldErrors name="segementDetail"/>
						<div <#if disableFields>style="display:none;"</#if> class="character-limit" >You have <input readonly type="text" id="segementDetail${targetSegment.getEndmarketID()}countdown" name="countdown" size="3" value="900" style="margin-top:7px;"> characters left.</div>
		                </div>
	                </div>
               
		    </#list>
		   </div>
		    
		<#else>
		    No Endmarkets selected for this project.
		</#if>
	</div>	
</div>
<span id="targetSegmentError" class="jive-error-message" style="display:none">Please Enter Target Segment</span>
</#macro>

<#macro renderSmokerGroup name='' value=[] multiselect=false disableFields=disableFields> 
<div class="end_market_details"">
	<div class="end_market_forms synchro_form">
	  <h3 id="smokerGroupBlock">Smoker Groups Included in Research <a id="smokerGroupLegend" href="#" class="close-form" onclick="javascript:toggleSmokerGroupBlock();"></a></h3>
		<#if smokerGroupList?has_content>
		   <div class="content_div" id="smokerGroupDiv">
		    <#list smokerGroupList as smokerGroup>
				 
				 	<div class="end-market-main">
	                <div class="form-text_div">
	                    <label>${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(smokerGroup.getEndmarketID()?int)}</label>
	                 
	               
	                   <@showSmokerGroupFieldSection selectedBrandIdList=smokerGroup.getBrandId() name='smokerGroup${smokerGroup.getEndmarketID()}' value=project.brand?default(-1) selectedEndMarket=smokerGroup.getEndmarketID() disableFields=disableFields/>
	                    
	                 </div>
                	</div>
				 </#list>
			</div>
		<#else>
		    No Endmarkets selected for this project.
		</#if>
	</div>
</div>
<span id="smokerGroupError" class="jive-error-message" style="display:none">Please Select Smoker Group</span>
</#macro>

<#macro showProductBrandFieldSection selectedBrandIdList name='' value=0  selectedEndMarket=0 disableFields=disableFields>
    <div class="form-select_div">
        <@renderPibBrandField selectedBrandIdList=selectedBrandIdList name='availableReferenceBrands${selectedEndMarket}' value=value multiselect=true disableFields=disableFields/>
        <div class="action_buttons">
        <#if !disableFields>
		 <a id="referenceBrandsReload${selectedEndMarket}" href="javascript:void(0);"></a>
            <input id="addReferenceBrandsBtn${selectedEndMarket}" type="button" value='>>' class="left_arrow" />
            <input id="removeReferenceBrandsBtn${selectedEndMarket}" type="button" value='<<' class="right_arrow" />
         </#if>
        </div>
    </div>
    <div class="form-select_div_brand">
       				       	
       <select name="${name}" id="${name}" multiple="yes" class="" <#if disableFields>disabled</#if> >
        <#if value!=-1 >
        <#list selectedBrandIdList as selectedBrandId >
			<@renderSelectedPibBrandField selectedBrandId/>
		</#list> 
		
        </#if>
        </select>
		<#attempt>
			<@macroCustomFieldErrors msg="Please choose Brands"/>
		<#recover> 
		</#attempt>	
		
    </div>
    <script type="text/javascript">
        $j(function() {
            $j("#addReferenceBrandsBtn${selectedEndMarket}, #removeReferenceBrandsBtn${selectedEndMarket}").click(function(event) {
                var id = $j(event.target).attr("id");
                var selectFrom = id == "addReferenceBrandsBtn${selectedEndMarket}" ? "#availableReferenceBrands${selectedEndMarket}" : "#referenceBrand${selectedEndMarket}";
                var moveTo = (id == "addReferenceBrandsBtn${selectedEndMarket}") ? "#referenceBrand${selectedEndMarket}" : "#availableReferenceBrands${selectedEndMarket}";
                var selectedItems = $j(selectFrom + " :selected").toArray();
                $j(moveTo).append(selectedItems);
		  	    $j(moveTo).sortOptions();
            });
			$j("#availableReferenceBrands${selectedEndMarket}").sortOptions();
        });		
		
		$j("#referenceBrandsReload${selectedEndMarket}").click(function() {
			$j("#referenceBrand${selectedEndMarket} option").each(function()
				{	
					$j("#availableReferenceBrandsReload${selectedEndMarket}").append(new Option($j(this).text(), $j(this).val()));
					$j(this).remove();
					$j("#availableReferenceBrands${selectedEndMarket}").sortOptions();
				});
		});
		 $j.fn.sortOptions = function(){
			
			$j(this).each(function(){
			var op = $j(this).children("option");
			
			op.sort(function(a, b) {
            return a.text > b.text ? 1 : -1;
			})
		
		return $j(this).empty().append(op);
		});
		}
	</script>
</#macro>

<#macro showSmokerGroupFieldSection selectedBrandIdList name='' value=0  selectedEndMarket=0 disableFields=disableFields>
    <div class="form-select_div">
        <@renderPibBrandField selectedBrandIdList=selectedBrandIdList name='availableSmokerGroup${selectedEndMarket}' value=value multiselect=true disableFields=disableFields/>
        <div class="action_buttons">
		 <#if !disableFields>
		 <a id="smokerGroupReload${selectedEndMarket}" href="javascript:void(0);"></a>
            <input id="addSmokerGroupBtn${selectedEndMarket}" type="button" value='>>' class="left_arrow" />
            <input id="removeSmokerGroupBtn${selectedEndMarket}" type="button" value='<<' class="right_arrow" />
          </#if>
        </div>
    </div>
    <div class="form-select_div_brand">
       				       	
       <select name="${name}" id="${name}" multiple="yes" class="" <#if disableFields>disabled</#if>>
	        <#if value!=-1 >
		        <#list selectedBrandIdList as selectedBrandId >
					<@renderSelectedPibBrandField selectedBrandId/>
				</#list> 
		    </#if>
       </select>
		<#attempt>
			<@macroCustomFieldErrors msg="Please choose Brands"/>
		<#recover> 
		</#attempt>	
		
    </div>
    <script type="text/javascript">
        $j(function() {
            $j("#addSmokerGroupBtn${selectedEndMarket}, #removeSmokerGroupBtn${selectedEndMarket}").click(function(event) {
                var id = $j(event.target).attr("id");
                var selectFrom = id == "addSmokerGroupBtn${selectedEndMarket}" ? "#availableSmokerGroup${selectedEndMarket}" : "#smokerGroup${selectedEndMarket}";
                var moveTo = (id == "addSmokerGroupBtn${selectedEndMarket}") ? "#smokerGroup${selectedEndMarket}" : "#availableSmokerGroup${selectedEndMarket}";
                var selectedItems = $j(selectFrom + " :selected").toArray();
                $j(moveTo).append(selectedItems);
		  	    $j(moveTo).sortOptions();
            });
			$j("#availableSmokerGroup${selectedEndMarket}").sortOptions();
        });		
		
		$j("#smokerGroupReload${selectedEndMarket}").click(function() {
			$j("#smokerGroup${selectedEndMarket} option").each(function()
				{	
					$j("#availableSmokerGroupReload${selectedEndMarket}").append(new Option($j(this).text(), $j(this).val()));
					$j(this).remove();
					$j("#availableSmokerGroup${selectedEndMarket}").sortOptions();
				});
		});
		 $j.fn.sortOptions = function(){
			
			$j(this).each(function(){
			var op = $j(this).children("option");
			
			op.sort(function(a, b) {
            return a.text > b.text ? 1 : -1;
			})
		
		return $j(this).empty().append(op);
		});
		}
	</script>
</#macro>

<#macro renderPibBrandField selectedBrandIdList name='' value=0 multiselect=false disableFields=disableFields>
  
      <select name="${name}" id="${name}"  <#if multiselect>multiple="yes"</#if><#if disableFields>disabled</#if>>
        <option  value="-1" disabled>-- None --</option>
        <#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
        <#if (brands?has_content)>
            <#list brands.keySet() as key>
                <#assign brand = brands.get(key)/>
                <#if !selectedBrandIdList.contains(key?long)>
                <option value="${key?c}" <#if value?number == key?number>selected="true"</#if>>${brand}</option>
                </#if>
            </#list>
        </#if>
    </select>
</#macro>

<#macro renderSelectedPibBrandField value=0 >
  
      <#assign brands = statics['com.grail.synchro.SynchroGlobal'].getBrands(false, 1) />
        <#if (brands?has_content)>
            <#list brands.keySet() as key>
                <#assign brand = brands.get(key)/>
                <#if value?number == key?number>
                <option value="${key?c}" selected="true">${brand}</option>
                </#if>
            </#list>
        </#if>
   
</#macro>

<script type="text/javascript">
    function saveTargetSegment(id){
        var frm = $j("#form_"+id)[0];
         //console.log(frm);
        $j.ajax({
            type: "POST",
            url: frm.action,
            // serializes the form's elements
            data: $j("#form_"+id).serialize(),
            success: function() {
                //alert('TargetSegment details saved successfully !!! --- ' + ${actionMessages?size});
            }
        });
    }

    function toggleEndmarketBlock(id){
        var endMarketBlock = $j('#endMarket_'+id);
        endMarketBlock.toggle();
        // Expanded view
        if(endMarketBlock.css('display') == "block"){
            $j('#block_header_'+id).css('border-bottom', '1px solid #c9c9c9');
            $j('#legend_'+id).removeClass('open-form');
            $j('#legend_'+id).addClass('close-form');
        }
        // Closed/Minimized view
        else{
            $j('#block_header_'+id).css('border-bottom', 'none');
            $j('#legend_'+id).addClass('open-form');
            $j('#legend_'+id).removeClass('close-form');
        }
    }
    
    function toggleTargetSegmentBlock(){
       var targetSegmentBlock = $j('#targetSegmentDiv');
        targetSegmentBlock.toggle();
        // Expanded view
        if(targetSegmentBlock.css('display') == "block"){
            $j('#targetSegmentBlock').css('border-bottom', '1px solid #c9c9c9');
            $j('#targetSegmentLegend').removeClass('open-form');
            $j('#targetSegmentLegend').addClass('close-form');
        }
        // Closed/Minimized view
        else{
            $j('#targetSegmentBlock').css('border-bottom', 'none');
            $j('#targetSegmentLegend').addClass('open-form');
            $j('#targetSegmentLegend').removeClass('close-form');
        }
    }
    function toggleReferenceBrandBlock(){
       var refBrandBlock = $j('#referenceBrandDiv');
        refBrandBlock.toggle();
        // Expanded view
        if(refBrandBlock.css('display') == "block"){
            $j('#referenceBrandBlock').css('border-bottom', '1px solid #c9c9c9');
            $j('#referenceBrandLegend').removeClass('open-form');
            $j('#referenceBrandLegend').addClass('close-form');
        }
        // Closed/Minimized view
        else{
            $j('#referenceBrandBlock').css('border-bottom', 'none');
            $j('#referenceBrandLegend').addClass('open-form');
            $j('#referenceBrandLegend').removeClass('close-form');
        }
    }
    
     function toggleSmokerGroupBlock(){
       var smokerGroupBlock = $j('#smokerGroupDiv');
        smokerGroupBlock.toggle();
        // Expanded view
        if(smokerGroupBlock.css('display') == "block"){
            $j('#smokerGroupBlock').css('border-bottom', '1px solid #c9c9c9');
            $j('#smokerGroupLegend').removeClass('open-form');
            $j('#smokerGroupLegend').addClass('close-form');
        }
        // Closed/Minimized view
        else{
            $j('#smokerGroupBlock').css('border-bottom', 'none');
            $j('#smokerGroupLegend').addClass('open-form');
            $j('#smokerGroupLegend').removeClass('close-form');
        }
    }
   
</script>

<#macro macroCustomFieldErrors msg=''>   
    <span class="jive-error-message" style="display:none">${msg?html}</span>     
</#macro>