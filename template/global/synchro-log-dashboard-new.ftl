<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>
<#--<script src="${themePath}/js/jquery.tablesorter.js" type="text/javascript"></script>-->
<script src="${themePath}/js/jquery.paginate.js" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/table-height-handler.js" type="text/javascript"></script>
<link rel="stylesheet" href="${themePath}/style/drop-down.css" type="text/css" />
<style>

    .jqbar.horizontal span {
        margin-left: 0px;
    }
    .jqbar.horizontal span.bar-level{
    <#--behavior: url("${themePath}/pie/PIE.htc");-->
    }
    .jqbar.horizontal .bar-level-wrapper{
        position:relative;
        z-index:0;
    }
    .site_search input.search_box{
    <#--behavior: url("${themePath}/pie/PIE.htc");-->
    }
</style>
<#include "/template/global/include/synchro-macros.ftl" />
<div class="container-sub">
    <div class="project_view">
        <div class="project_dashboard_header">          
            <h2><#if projectID?? && (projectID>0)>Project Logs<#elseif waiverID?? && (waiverID>0)>Waiver Logs<#else>All Logs</#if></h2><br>
			<#if projectName??><h3>${projectName?html} (${generateProjectCode('${projectID?c}')}) </h3></#if>
			<#if waiverName??><h3>${waiverName?html} (${generateProjectCode('${waiverID?c}')}) </h3></#if>
            <div class="site_search">    
                <form id="search-box">
                    <input type="text" name="q" size="31" id="search_box" class="search_box" placeholder="Search"/>
                    <input type="button"  name="" value="" class="search_icon" />
                </form>
				<div class="log-extract-download-link ">
                    <a href="javascript:void(0);" onclick="downloadLogFile()">Download Logs</a>
                </div>
          <#include "/template/global/synchro-catalogue-search-tag-new.ftl"/>
            </div>
        </div>
    <input type="hidden" name="projectID" id="projectID" value="<#if projectID?? && (projectID>0)>${projectID?c}</#if>">
	<input type="hidden" name="waiverID" id="waiverID" value="<#if waiverID?? && (waiverID>0)>${waiverID?c}</#if>">
 
        <div id="table-main"></div>
        <div id="overlay">
            <img src="${themePath}/images/bigrotation.gif"
                 id="img-load" />
        </div>
    </div>
</div>
<#if projectID?? && (projectID>0)>
	<form id="generate-log-form" style="display:none;" action="<@s.url value="/new-synchro/dashboard-log-pagination!downloadProjectLogFile.jspa"/>" method="post"></form>
<#elseif waiverID?? && (waiverID>0)>
	<form id="generate-log-form" style="display:none;" action="<@s.url value="/new-synchro/dashboard-log-pagination!downloadProjectLogFile.jspa"/>" method="post"></form>	
<#else>
	<form id="generate-log-form" style="display:none;" action="<@s.url value="/new-synchro/dashboard-log-pagination!downloadLogFile.jspa"/>" method="post"></form>
</#if>

<script type="text/javascript">

    $j(document).ready(function () {
        CustomDropDown.init($j('#my-dashboard-submenu'),$j('.my-dashboard'));
        CustomDropDown.init($j('#initiate-new-submenu'),$j('.initiate-new'));
		
        currPage = 1;
        processPaginationRequest(currPage,"");
        view = getURLParameter('view');
        if(view!=null && view=="filter")
        {
            toggle();
        }
        setTimeout( function(){$j(".warning-msg").fadeOut(1000);} , 4000);
        $j("#project-projectactivity-filter").hide();
        $j("#project-initiator-filter").hide();
        $j("#project-projectsupplier-filter").hide();
        if(!$j("#sortField").val()) {
           // $j("#sortField").val("timestamp");
        }

        if(!$j("#ascendingOrder").val()) {
          //  $j("#ascendingOrder").val("0");
        }

	$j("#startDateLog").click(function() {
        $j("#startDateLog_button").click();
    });
    $j("#endDateLog").click(function() {
        $j("#endDateLog_button").click();
    });
    });

    // Search based on project name, owner, and project status
    var timer;
    $j("#search_box").keyup(function(){
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
        }, 300);
        //Sort Fields
//        $j("#sortField").val("");
//        $j("#ascendingOrder").val("");
    });

    //Pagination
    var xhr;
    function processPaginationRequest(page,keyword)
    {
        currPage = page;
		var projectID = $j("#projectID").val();
		var waiverID = $j("#waiverID").val();
        var url = '/new-synchro/dashboard-log-pagination.jspa'
        if(xhr != null)
            xhr.abort();
        selectAllFilterBoxes();
        var filterForm = $j("#result-filter-form");
        xhr = $j.ajax({
            url: url,
            type: 'POST',
            data: filterForm.serialize() + '&keyword='+ keyword+"&page="+page+"&projectID="+projectID+"&waiverID="+waiverID,
            beforeSend: function() {
                // $j("#overlay").show();
            },
            complete: function() {
                // $j("#overlay").hide();
            },
            success: function(result) {
                xhr = null;
                $j('#table-main').html(result);               
              //  updateTableRowHeight();
               // adjustTableBodySize();
                TABLE_HEIGHT_HANDLER.initialize();
            }
        });
    }

    $j("#search-box").submit(function( event ) {
        //$j("#search_box").keyup();
        event.preventDefault();
    });
    function adjustTableBodySize() {
        $j(".table-vscroll .scollinner").height($j(".project_status_table tbody").height() + 15);
        $j(".table-vscroll").css("top",($j($j(".project_status_table thead")[0]).height()) + 1 + "px");
    }
	
	function auditLogs()
	{	
		//TODO Audit code for LOGS Dashboard if applicable
	}  
    
	function downloadLogFile()
    {      
		$j("#generate-log-form").html("");
		$j("#result-filter-form").find(":input").clone().appendTo("#generate-log-form");
		var value = $j("#search_box").val();
		if($j.trim(value) != "")
		{
			$j("#generate-log-form").append("<input type='hidden' id='keyword' name='keyword' value='"+$j.trim(value)+"' />");
		}
		
		var projectID = $j("#projectID").val();
		var waiverID = $j("#waiverID").val();
		
		if(projectID!=null && projectID>0)
		{
			$j("#generate-log-form").append("<input type='hidden' id='projectID' name='projectID' value='"+projectID+"' />");
		}
		if(waiverID!=null && waiverID>0)
		{
			$j("#generate-log-form").append("<input type='hidden' id='waiverID' name='waiverID' value='"+waiverID+"' />");
		}
		
		<#if !(projectID?? && (projectID > 0))>
			$j('#generate-log-form #portalFields option').attr('selected', 'selected');
			$j('#generate-log-form #pageFields option').attr('selected', 'selected');
		</#if>
		
		$j('#generate-log-form #activityFields option').attr('selected', 'selected');		
		$j("#generate-log-form").submit();
		$j("#generate-log-form").html("");		
    }
</script>