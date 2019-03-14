<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.paginate.js" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<script src="${themePath}/js/cookie.js" type="text/javascript"></script>
<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/reporting-macros.ftl" />
<style>
.site_search input.search_box{
	behavior: url(${themePath}/pie/PIE.htc);
}
</style>
<div class="container">
    <div class="project_view">
	<div class="reports_dashboard_header">		
		<h2>Generate Reports</h2>
		<@reportTab activeTab=2 />
		<@financialReportsSubTab activeTab=1 />
        <div class="site_search">
			<h2>Project Finance Report</h2>				
            <form id="search-box">
                <input type="text" name="q" size="31" id="search_box" class="search_box" placeholder="Search"/>
                <input type="button"  name="" value="" class="search_icon" />
            </form>
			 <#include "/template/global/synchro-catalogue-search-tag.ftl"/>
        </div>		
	</div>	
       <div id="table-main">
	   </div>
	   <div class="buttons">
		<a id="form_submit" href="javascript:void(0);" onclick="javascript:extractProjectFinancialReport();" class="continue">EXTRACT</a>
	</div>
    </div>
</div>
<div id="overlay">
  <img src="${themePath}/images/bigrotation.gif" 
    id="img-load" />
</div>

<script type="text/javascript">
var cookie_name = "project-financial-extract";
var token = cookie_name+"-${user.ID?c}";

$j(document).ready(function () {
	currPage = 1;
	processPaginationRequest(currPage,"");
	
	/** Hide other elements of advanced result filter **/		
	$j("#project-methodology-filter").hide();	
	$j("#project-projectactivity-filter").hide();
	$j(".result-form-popup .project_start_date .year select").css('width','340px');
 });

//Pagination
var xhr;
function processPaginationRequest(page,keyword)
{
	currPage = page;
	var url = '/synchro/project-finance-report.jspa';
	if(xhr != null) 
		xhr.abort();
	var owners = $j("#owner").find("option");
	owners.each(function(optionEle) {
	owners[optionEle].selected = 'selected';
	});
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
	function extractProjectFinancialReport()
	{
		var selectedProject = $j('input[name=project-select]');
	    var projectID = selectedProject.filter(':checked').val();
	    if(projectID == undefined)
	    { 
			dialog();
			$j("#dialog-box").html("Please select a project");
			return false;
	   	}	
		
		cookieTimer(cookie_name, token);
	    window.location.href = "/synchro/financial-reports!extractReport.jspa?projectID="+projectID+"&token="+token+"&tokenCookie="+cookie_name;
    }
$j("td.project-code-col").live('click', function(){
        $j(this).prev().click();
});
$j("td.project-select-col").live('click', function(){
        $j(this).find("input").attr('checked', true);
});    
</script>

