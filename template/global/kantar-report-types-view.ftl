<#assign reportTypes =  statics['com.grail.kantar.util.KantarUtils'].getKantarReportTypeBeans()>
<head>
    <script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
    <script type="text/javascript">
        var otherLabelAdded = false;
        $j(function(){

        <#if (reportTypes?has_content)>
            <#list reportTypes as reportType>
                <#if reportType.otherType?? && reportType.otherType>
                    if(!otherLabelAdded) {
                        $j("#other-report-type-container").append("<a href='<@s.url value= "/kantar-report/dashboard.jspa?otherType=true"/>' class='other-lbl'>Other</a>");
                        otherLabelAdded = true;
                    }
                    $j("#other-report-type-container").append("<a href='<@s.url value= "/kantar-report/dashboard.jspa?reportTypeId=${reportType.id}&otherType=true"/>' class='other-report-type'>${reportType.name}</a> ");
                <#else>
                    $j("#report-type-container").append("<a href='<@s.url value= "/kantar-report/dashboard.jspa?reportTypeId=${reportType.id}&otherType=false"/>' class='report-type'>${reportType.name}</a>");
                </#if>
            </#list>
        </#if>
        })
    </script>
</head>

<div class="border-container kantar-report-types">
    <div class="kantar-report-types-container-main">
        <span class="header">Click on the type of document that you would like to view</span>
    <#if canUploadDocument?? && canUploadDocument>
        <input type="button" value="Upload a new Document" onclick="showUploadKantarReportPopup()" class="add-btn upload-document-btn">
    </#if>


        <div class="kantar-report-types-container">
        <#if (reportTypes?has_content)>

            <div id="report-type-container" class="report-type-container"></div>
            <div id="other-report-type-container" class="report-type-container">

            </div>
        </#if>
        </div>
    </div>
<#--<div>-->
<#--</div>-->
</div>
<script type="text/javascript">
    SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].DOCUMENT.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYDASHBOARD.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, 0, "Report Types", "", -1, ${user.ID?c});
</script>