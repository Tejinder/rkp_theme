<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<script src="${themePath}/js/jquery.paginate.js" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>


<script type="text/javascript">
    var xhr;
    var searchTimer = null;
    $j(document).ready(function(){
        attachSearchBoxListeners();
        showFirstPage();
    });
    function showFirstPage() {
        currPage = 1;
        processPaginationRequest(currPage, "");
    }

    function processPaginationRequest(page, keyword) {
        currPage = page;
        if(xhr != null) {
            xhr.abort();
            xhr = null;
        }
        var url = "<@s.url value='/kantar/kantar-dashboard-pagination.jspa'/>";
        var filterForm = $j("#result-filter-form");
        xhr = $j.ajax({
            url : url,
            type: 'POST',
            data: filterForm.serialize() + "&page="+page+"&keyword="+keyword,
            beforeSend: function() {
                $j("#overlay").show();
            },
            complete: function() {
                $j("#overlay").hide();
            },
            success: function(result) {
                xhr = null;
                $j('#table-main').html(result);
                $j('body').css({height: $j(document).height()});
            }
        });
    }

    function attachSearchBoxListeners() {
        $j("#search-box-form").submit(function(event){
            event.preventDefault();
            var value = $j("#kantar-search-box").val();
            processSearchBoxInput($j("#kantar-search-box").val())
        })
        // Search based on project name, owner, and project status
        $j("#kantar-search-box").keyup(function(event){
            clearTimeout(searchTimer);
            searchTimer = setTimeout(function(){
                processSearchBoxInput($j("#kantar-search-box").val());
            }, 300);

        });

        $j("#search-box-form").submit(function( event ) {
            event.preventDefault();
        });
    }

    function processSearchBoxInput(value) {
        if($j.trim(value) != "") {
            processPaginationRequest(1, $j.trim(value));
        } else {
            processPaginationRequest(1, "");
        }

        //Sort Fields
        $j("#sortField").val("");
        $j("#ascendingOrder").val("");
    }


</script>
<div class="container">
    <div class="project_view generate-report">
        <div class="kantar_dashboard_header">
            <h2>My Projects</h2>
        </div>
        <div class="kantar-dashboard-body">
        <#--<h2>Raw Extract</h2>-->
            <div class="site_search">
                <form id="search-box-form">
                    <input type="text" name="q" size="31" id="kantar-search-box" class="search_box"/>
                    <input type="button"  name="" value="" class="search_icon" />
                </form>
            <#include "/template/global/synchro-catalogue-search-tag.ftl"/>
            </div>
        </div>
    </div>
    <div id="table-main">
    </div>

</div>
<div id="overlay">
    <img src="${themePath}/images/bigrotation.gif" id="img-load" />
</div>
<script type="text/javascript">
		function auditLogs()
	{			
		<#assign i18CustomAdvSearchText><@s.text name="logger.kantar.dashboard.search.text" /></#assign>
		SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].KANTAR.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DASHBOARDKANTAR.getId()}, "${i18CustomAdvSearchText}", "", -1, ${user.ID?c});
	}
	
<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.kantar.dashboard.view.text" /></#assign>
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].KANTAR.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, 0, "${i18CustomText}", "", -1, ${user.ID?c});
</script>