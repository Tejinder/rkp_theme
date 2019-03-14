<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<script src="${themePath}/js/jquery.paginate.js" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<#--<#include "/template/global/include/synchro-macros.ftl" />-->
<#include "/template/global/include/reporting-macros.ftl" />

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
        var url = "<@s.url value='/synchro/raw-extract-pagination.jspa'/>";
        xhr = $j.ajax({
            url : url,
            type: 'POST',
            data: "page="+page+"&keyword="+keyword,
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
            var value = $j("#library-search-box").val();
            processSearchBoxInput($j("#library-search-box").val())
        })
        // Search based on project name, owner, and project status
        $j("#standard-report-search-box").keyup(function(event){
            clearTimeout(searchTimer);
            searchTimer = setTimeout(function(){
                processSearchBoxInput($j("#standard-report-search-box").val());
            }, 300);

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

    function downloadReport() {
       var url = "<@s.url value="/synchro/downloadRawExtract.jspa"/>";
        if($j("#standard-report-search-box").val()) {
           url += "?keyword="+$j("#standard-report-search-box").val();
        }
	<#assign i18CustomText><@s.text name="logger.project.report.download.text" /></#assign>	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].REPORTS.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].DOWNLOAD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].RAWEXTRACT.getId()}, "${i18CustomText}", "", -1, ${user.ID?c});
        window.location.href = url;
    }

</script>
<div class="container">
    <div class="project_view generate-report">
        <div class="reports_dashboard_header">
            <h2>Generate Reports</h2>
        </div>
    <@reportTab activeTab=1 />
        <div class="report-body">
            <#--<h2>Raw Extract</h2>-->
            <div class="site_search">
                <form id="search-box-form">
                    <input type="text" name="q" size="31" id="standard-report-search-box" class="search_box"/>
                    <input type="button"  name="" value="" class="search_icon" />
                </form>
                <div class="standard-report-download-link">
                    <a href="javascript:void(0);" onclick="downloadReport()">Download Report</a>
                </div>
            </div>
        </div>
    </div>
    <div id="table-main">
    </div>

</div>
<div id="overlay">
    <img src="${themePath}/images/bigrotation.gif" id="img-load" />
</div>





