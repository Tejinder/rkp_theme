<script src="${themePath}/js/jquery.paginate.js" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js" type="text/javascript"></script>
<style>
.site_search input.search_box{
	behavior: url(${themePath}/pie/PIE.htc);
}
</style>
<div class="container">
    <div class="project_view">	
	        <h2>CHANGE STATUS</h2>
        <div class="site_search_changestatus">
			<h2>SELECT TO CANCEL, PUT ON HOLD, OR OPEN A PROJECT</h2>
		</div> 
		<div class="site_search">			
            <form id="search-box">
                <input type="text" name="q" size="31" id="search_box" class="search_box" placeholder="Search"/>
                <input type="button"  name="" value="" class="search_icon" />
            </form>
			 <#include "/template/global/synchro-catalogue-search-tag.ftl"/>
        </div>	
       <div id="table-main">
	   </div>
	   <div class="buttons">
		<a id="form_submit" href="javascript:void(0);" class="continue">CONTINUE</a>
	</div>
    </div>
</div>
<div id="overlay">
  <img src="${themePath}/images/bigrotation.gif" 
    id="img-load" />
</div>

<script type="text/javascript">
$j(document).ready(function () {
currPage = 1;
processPaginationRequest(currPage,"");
<#if !(statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroMiniAdmin()) >
	$j("#project-owner-filter").hide();
</#if>
	$j("#project-methodology-filter").hide();
	$j("#project-projectactivity-filter").hide();
	$j("#project-initiator-filter").hide();
	$j("#project-projectsupplier-filter").hide();
	$j(".result-form-popup .project_start_date .year select").css('width','340px');
 });

//Pagination
var xhr;
function processPaginationRequest(page,keyword)
{
	currPage = page;
	var url = '/synchro/dashboard-status-pagination.jspa';
	if(xhr != null) 
		xhr.abort();
	selectAllFilterBoxes();
	var filterForm = $j("#result-filter-form");
	xhr = $j.ajax({
    url: url,
    type: 'POST',
	data: filterForm.serialize() + '&keyword='+ keyword+"&page="+page,
    beforeSend: function() {	
	 $j("#overlay").show();
    },
    complete: function() {
       $j("#overlay").hide();
    },
    success: function(result) {
		xhr = null;	
		$j('#table-main').html(result);		
		docH = $j(document).height();	
		$j('body').css({height: docH});		
		}
	});
}

	// Search based on project name, owner, and project status
var timer;
$j("#search_box").keyup(function(){
currPage = 1;
clearTimeout(timer);
 timer = setTimeout(function(){
    var value = $j("#search_box").val();	
	if($j.trim(value) != "")
	{
	processPaginationRequest(1, $j.trim(value));
	}
	else
	{
	processPaginationRequest(1, "");
	}
	}, 300 );
	
	//Sort Fields
	$j("#sortField").val("");
	$j("#ascendingOrder").val("");
});   

$j("td.project-code-col").live('click', function(){
        $j(this).prev().click();
});
$j("td.project-select-col").live('click', function(){
        $j(this).find("input").attr('checked', true);
});

function auditLogs()
{	
	//TODO : Code if Applicable
}
    
</script>

