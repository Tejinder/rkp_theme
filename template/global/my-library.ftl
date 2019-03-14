<html>
<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<#include "/template/global/include/synchro-macros.ftl" />
<head>
    <title>My Library</title>
    
    <script src="${themePath}/js/jquery.paginate.js" type="text/javascript"></script>

</head>

<body>
<#assign isPopup = false/>
<#if (request.getParameter('isPopup')?exists)>
    <#assign isPopup = request.getParameter('isPopup')>
</#if>

<script type="text/javascript" src="${themePath}/js/synchro/my-library-scripts.js"></script>

<script type="text/javascript">

    $j(document).ready(function() {
        isPopup = ${isPopup?string};
        attachSearchBoxListeners();
        showFirstPage();
    });
</script>


<div class="container-sub">
    <div class="project_view">
        <div class="project_dashboard_header">
            <h2>MY LIBRARY</h2>
            <div class="site_search">
                <input type="button" value="Add Document" onclick="showPopup()" class="add-btn">
                <#--<a href="/file/download/Product_Template__Illustrative__v1.xlsx">Click here to download Product Template</a>-->
                <a id="default-templates-link" href="<@s.url value="/synchro/default-templates!input.jspa"/>">Default Templates</a>
                <form id="search-box-form" style="display: none;">
                    <input type="text" name="q" size="31"  id="library-search-box" class="search_box" placeholder="Search"/>
                    <input type="button"  name="" value="" class="search_icon" />
                </form>
            </div>

        </div>
        <div id="project-waiver-table-main">
        </div>

    </div>

    <div id="add-document-popup" class="add-document-popup" style="display: none;">
        <div class="title">
            <h4>Add Document</h4>
        </div>
        <a href="javascript:void(0);" class="close" onclick="closePopup();"></a>
        <form id="add-document-form" action="<@s.url value='/synchro/my-library!addDocument.jspa'/>"
              method="post" enctype="multipart/form-data" name="add-document-form">
            <div id="error-message" class="error-message"></div>
            <div>
                <label>Title<span>*</span></label>
                <input type="text" id="title" name="title" size="30" maxlength="128" class="form-text" placeholder="Title" onkeyup="inputChange(this)">
            </div>
            <div class="form_divider">
                <label>Description</label>
                <textarea name="description" id="description" class="form-textarea" style="resize: none" cols="30" rows="10" placeholder="Description" ></textarea>
            </div>
            <div class="form_divider">
                <input type="file" id="attachFile" name="attachFile" class="form-text" onchange="inputChange(this)">
            </div>
            <div class="buttons">
                <input type="submit" value="Attach" class="save">
                <input type="button" value="Cancel" class="cancel" onclick="closePopup()">
            </div>
        </form>
    </div>

    <div id="overlay">
        <img src="${themePath}/images/bigrotation.gif" id="img-load" />
    </div>
</div>
<script type="text/javascript">

function auditLogs()
{	
	//TODO : Code if Applicable
}
<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.document.view.text" /></#assign>	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].SYNCHRO.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].MYLIBRARY.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, ${statics['com.grail.synchro.SynchroGlobal$LogProjectStage'].DOCUMENT.getId()}, "${i18CustomText}", "", -1, ${user.ID?c});
</script>

</body>
</html>

