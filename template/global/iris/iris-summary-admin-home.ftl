
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






<div class="searchBgImg">

<div class="alignBreadcrumb">
  <a href="/iris-summary/admin-home.jspa">Admin Panel</a>
</div>  

<div class="admin-outer-wrap">
<div class="row-wrapper"> 
  <a href="/iris-summary/create-summary!input.jspa"><div class="img-wrap-width">
      <img src="${themePath}/images/iris/admin-upload-icon.png" alt="img" class="round-section"> 
    <p>Upload Summary</p> 
  </div></a>
  <!--<p class="textalign">Create insightful summaries and publish them on the portal</p> -->
  <p class="textalign">Upload IRIS summaries and publish them for the IRIS search portal</p> 
     

</div>

<div class="row-wrapper"> 
 <a href="/iris-summary/manage-summaries.jspa"> <div class="img-wrap-width">
      <img src="${themePath}/images/iris/admin-manage-icon.png" alt="img" class="round-section">  
    <p>Manage Summaries</p> 
  </div></a>
  <p class="textalign">Edit or delete existing summaries. Move between folders, set privacy options</p>
</div>

<div class="row-wrapper"> 
  <a href="/iris-summary/container-regions.jspa"><div class="img-wrap-width">
      <img src="${themePath}/images/iris/admin-view-space.png" alt="img" class="round-section"> 
    <p>View Space</p> 
  </div></a>
 <!-- <p class="textalign">Manage data containers. Create, rename, delete the spaces storing the summaries</p>  -->
      <p class="textalign">Browse through the folders containing summaries</p>


</div>

  
</div>




     
</div>

<!-- The below script will remove the scroll bar and stretcheness of the background image -->
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