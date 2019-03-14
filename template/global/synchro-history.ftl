<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.paginate.js" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js" type="text/javascript"></script>
<style>
.site_search input.search_box{
	behavior: url(${themePath}/pie/PIE.htc);
}
</style>
<div class="container">    
    <div class="project_view">
	<div class="project_dashboard_header">	
		<h2>HISTORY</h2>			 
        <div class="site_search">				
            <form id="search-box">
                <input type="text" name="q" size="31" id="search_box" class="search_box" placeholder="Search"/>
                <input type="button"  name="" value="" class="search_icon" />
            </form>
			 <#include "/template/global/synchro-catalogue-search-tag.ftl"/>
        </div>	
	</div>	
       <div id="table-main">	  
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

	$j("#project-methodology-filter").hide();	
	$j("#project-projectactivity-filter").hide();
	$j("#project-projectsupplier-filter").hide();
	$j("#project-projectstatus-filter").hide();
	$j(".result-form-popup .project_start_date .year select").css('width','340px');
 });
  
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

//Pagination
var xhr;
function processPaginationRequest(page,keyword)
{
	currPage = page;
	var url = '/synchro/dashboard-history-pagination.jspa';
	if(xhr != null) 
		xhr.abort();
	var filterForm = $j("#result-filter-form");
	xhr = $j.ajax({
		url: url,
		type: 'POST',
		data: filterForm.serialize() + '&keyword='+ keyword+"&page="+page,
		beforeSend: function() {	
		 $j("#overlay").fadeIn();
		},
		complete: function() {
		   $j("#overlay").hide();
		},
		success: function(result) {
			xhr = null;	
			$j('#table-main').html(result);			
			}
	});	
}
function auditLogs()
{	
	//TODO : Code if Applicable
}
</script>

