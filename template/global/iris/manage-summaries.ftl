<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#-- DWR def -->
<head>

   
</head>


<script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>

<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/commons.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script src="${themePath}/js/synchro/form-data-persist-handler.js?version=1" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/project-sticky-header.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.MultiFile.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ajaxfileupload.js'/>"></script>
 
<link rel="stylesheet" href="${themePath}/style/multi-select.css" type="text/css" media="all" />
<script src="${themePath}/js/synchro/second.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/autosearch2.js" type="text/javascript"></script>


 
<body>



<!-- <div class="admin-outer-wrap">
<div class="row-wrapper"> 
  <div class="img-wrap-width">
    <a href="/iris-summary/search-summary!input.jspa">  <img src="${themePath}/images/iris/publised_summary.PNG" alt="img" class="round-section"> </a>
    <p>Published Summaries</p>  
  </div>
  <p class="textalign">Edit or delete published IRIS summaries. Move between containers, set privacy options</p> 
</div>

<div class="row-wrapper"> 
  <div class="img-wrap-width">
    <a href="/iris-summary/draft-summaries.jspa"> <img src="${themePath}/images/iris/draft_summary.PNG" alt="img" class="round-section"> </a> 
    <p>Drafts</p> 
  </div>
  <p class="textalign">Work on pending drafts, complete and move the summaries to desired containers for sharing with the users</p>
</div> 
</div> -->



<div class="searchBgImg">

  <div class="alignBreadcrumb">
    <a href="/iris-summary/admin-home.jspa">Admin Panel</a> > <a href="javascript:void(0);">Manage Summaries</a>
  </div>  

    <div class="admin-outer-wrap centerAlignWrap">
      <div class="row-wrapper"> 
       <a href="/iris-summary/search-summary!input.jspa"> <div class="img-wrap-width">
            <img src="${themePath}/images/iris/admin-publish-icon.png" alt="img" class="round-section">  
          <p>Published Summaries</p> 
        </div></a>
        <p class="textalign">Edit or delete published IRIS summaries. Move between folders, set privacy options</p>
      </div>

      <div class="row-wrapper"> 
        <a href="/iris-summary/draft-summaries.jspa?fromNavigation=ManageSummaries"><div class="img-wrap-width">
            <img src="${themePath}/images/iris/admin-draft-icon.png" alt="img" class="round-section boxTextAlign"> 
          <p>Draft</p> 
        </div></a>
        <p class="textalign">Work on pending drafts, complete and move the summaries to desired folders for sharing with the users</p> 
      </div>

    </div>
   
</div>


<script type="text/javascript">
    
    $j(document).ready(function(){
          
        var windowHeight = $j(window).height();
        var headerHEight = $j('#j-header-wrap').height();
        var headerLineHeight = $j('.header-top-page-wrapper').height();
        var footerHeight = $j('footer').height();
       var sumOfHeight = (headerHEight + headerLineHeight + footerHeight);
       var middleContentHeight = (windowHeight) - (sumOfHeight);
       $j('.searchBgImg').css('height',middleContentHeight);    

    });

</script>



</body>

