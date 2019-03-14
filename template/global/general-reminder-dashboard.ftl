<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<script src="${themePath}/js/jquery.paginate.js" type="text/javascript"></script>
<script type="text/javascript">
    var origBodyHeight, origMainDivHeight, origPoupHeight;
    var xhr;
    var searchTimer = null;
    $j(document).ready(function(){
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
        var url = "<@s.url value='/synchro/general-reminders-pagination.jspa'/>";
        var filterForm = $j("#result-filter-form");
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

    function showSetReminderPopup(id) {
        $j('#error-message').hide();
        clearErrorMessage();
        var div = $j('<div id="general-reminder-popup" class="synchro-reminder-popup general-reminder-popup"></div>');
        $j('<a class="close" href="javascript:void(0)"></a>').appendTo($j(div));

        var subdiv = $j('<div class="synchro-reminder-container"></div>');

        $j(subdiv).appendTo($j(div));
        showLoader();
        var url = "<@s.url value='/synchro/general-reminder!input.jspa'/>";
        if(id != undefined && id > 0) {
            url += "?id="+id;
        }
        $j(div).lightbox_me({centered:true,closeEsc:false,closeClick:false,overlayCSS:{background: 'black', opacity: .7},destroyOnClose:true,onLoad:function(){
            $j(div).hide();
            $j(subdiv).load(url,{},function(){
                $j(div).show();
                clearErrorMessage();
                hideLoader();
                origPoupHeight = $j("#general-reminder-form").height();
                resizePopup();
                //$j("#kantar-report-upload-popup").trigger("resize");
            }, function(){$j(div).show()});
        }});
    }

    function clearErrorMessage() {
        $j('#error-message').hide();
        $j('#error-message').html('');
    }

    function resizePopup() {

        var popupHeight = $j("#general-reminder-popup").height();
        var bodyHeight = $j("body").height();
        var mainDivHeight = $j(".maindiv").height();
        var overlayHeight = $j(".lb_overlay").height();
        if((popupHeight + 150) > bodyHeight) {
            $j("body").height(popupHeight + 200);
            $j(".maindiv").height(popupHeight + 200);
            $j(".lb_overlay").height(popupHeight + 200 + 37);
            var topPos = $j("#general-reminder-popup").offset().top;
            if(topPos > 45) {
                $j("#general-reminder-popup").css("top", (topPos - 37) + "px");
            }
            $j("body").scrollTop();
        }
        else {
            $j("body").height(origBodyHeight);
            $j(".maindiv").height(origMainDivHeight);
            $j(".lb_overlay").height(origBodyHeight);
        }

        $j("#general-reminder-popup").trigger("resize");
        $j("body").scrollTop();
    }

    function closeGeneralReminderPopup() {
        $j("#general-reminder-popup").trigger("close");
    }

</script>
<div class="container  synchro-reminders">
    <div class="project_view">
        <div class="project_dashboard_header">
            <h3>My Reminders</h3>
            <div class="report-menus" xmlns="http://www.w3.org/1999/html">
                <ul class="project_name_menu">
                    <li><a href="<@s.url value='/synchro/project-reminders!input.jspa'/>">Project Reminder Alerts</a></li>
                    <li><a href="<@s.url value='/synchro/general-reminders!input.jspa'/>" class="active">General Reminder Alerts</a></li>
                </ul>
            </div>
            <div class="site_search">
                <a href="<@s.url value="/portal-options.jspa"/>">Go Back</a>
                <input type="button" value="Set a new Reminder" onclick="showSetReminderPopup()" class="add-btn">
            </div>
            <div id="table-main">
            </div>
        </div>
    </div>
</div>
<div id="overlay">
    <img src="${themePath}/images/bigrotation.gif" id="img-load" />
</div>


<script type="text/javascript">	
<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.reminder.view.general" /></#assign>
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].ALERTSANDREMINDERS.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, 0, "${i18CustomText}", "", -1, ${user.ID?c});
</script>