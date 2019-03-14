
<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>

<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
   
<div class="wrapperBoxBackground">
   <div class="wrap-top-align">
   
   <div class="boxContentAlign">
    <h2>WELCOME</h2>
    <P>This is IRIS, BAT's Research Knowledge Portal</P>
   </div>
   
        <div class="welcomeWrapper">
       
        <div class="row-wrapper">
             <a href="/iris-summary/advance-search!input.jspa">
                <img class="advanceImg" src="${themePath}/images/iris/advance-search-without-shadow.png" alt="Advanced Search"  title="Search using targeted search features">
            </a>
             <!--<div class="advanceHiddenText">Search using targeted <br> search features</div>  -->
        </div>
       <div class="row-wrapper">
            <a href="/iris-summary/search!input.jspa">
                    <img class="openTextSearchImg" src="${themePath}/images/iris/open-text-search.png" alt="Open Text Search"  title="Search without pre-filtering content">
            </a>

        <!-- <div class="homeHiddenText">Search without <br> pre-filtering content</div> -->

        </div>
        <div class="row-wrapper">
            <a href="/iris-summary/search-synchroId!input.jspa">
                <img class="synchroImg" src="${themePath}/images/iris/synchro-without-shadow.png" alt="Search by Synchro Code"  title="Search using Synchro Code of project">
            </a>
            <!-- <div class="synchroHiddenText">Search using Synchro <br> Code of project</div>  -->
        </div>
        
        <div class="clearfix"></div>

        <#if isAdminUser>
            <div class="adminPanelLink">
                <a href="/iris-summary/admin-home.jspa">
                    <img src="${themePath}/images/iris/admin-icon.png" alt="Admin">
                </a>
                <div class="adminHiddenText">Admin</div>
            </div>
        </#if>  
        
    </div>
    </div>
</div>

<!-- The below script will remove the scroll bar and stretcheness of the background image -->
<script type="text/javascript">
    
    $j(document).ready(function(){
 $j('img.openTextSearchImg').mousemove(function(event) {

        var x = (event.clientX + 20) + 'px';
        var y = (event.clientY + 20) + 'px';
        $j(".homeHiddenText").css({top: y, left: x}).show();
    
       });

      $j('img.synchroImg').mousemove(function(event) {
        var x = (event.clientX + 20) + 'px';
        var y = (event.clientY + 20) + 'px';
        $j(".synchroHiddenText").css({top: y, left: x}).show();
       });

      $j('img.advanceImg').mousemove(function(event) {
        var x = (event.clientX + 20) + 'px';
        var y = (event.clientY + 20) + 'px';
        $j(".advanceHiddenText").css({top: y, left: x}).show();
       });
          
        var windowHeight = $j(window).height();
        var headerHEight = $j('#j-header-wrap').height();
        var headerLineHeight = $j('.header-top-page-wrapper').height();
        var footerHeight = $j('footer').height();
       var sumOfHeight = (headerHEight + headerLineHeight + footerHeight);
       var middleContentHeight = (windowHeight) - (sumOfHeight);
       $j('.wrapperBoxBackground').css('height',middleContentHeight); 

        $j('img.openTextSearchImg').hover(function(event) {  
           $j('.homeHiddenText').css('display','block');
           $j(this).attr('src', '${themePath}/images/iris/open-text-search-shadow.png');
       }, function() {
          $j(this).attr('src', '${themePath}/images/iris/open-text-search.png');
          $j('.homeHiddenText').css('display','none');
        });  

         $j('img.synchroImg').hover(function() {      
           $j('.synchroHiddenText').css('display','block');
           $j(this).attr('src', '${themePath}/images/iris/synchro-with-shadow.png');
       }, function() {
          $j(this).attr('src', '${themePath}/images/iris/synchro-without-shadow.png');
          $j('.synchroHiddenText').css('display','none');
        });  

          $j('img.advanceImg').hover(function() {      
           $j('.advanceHiddenText').css('display','block');
           $j(this).attr('src', '${themePath}/images/iris/advance-search-shadow.png');
       }, function() {
          $j(this).attr('src', '${themePath}/images/iris/advance-search-without-shadow.png');
          $j('.advanceHiddenText').css('display','none');
        });


       $j('.adminPanelLink img').hover(function() {      
       $j('.adminHiddenText').css('display','block');    
       }, function() {
          $j('.adminHiddenText').css('display','none');
        });


      

    });
	
	<!-- Audit Logs -->
	<#assign i18CustomText><@s.text name="logger.project.home.view.text" /></#assign>	
	SynchroLogUtil.addLogActivity("${statics['com.grail.synchro.SynchroGlobal$PortalType'].IRIS.getDescription()}", ${statics['com.grail.synchro.SynchroGlobal$PageType'].HOME.getId()}, ${statics['com.grail.synchro.SynchroGlobal$Activity'].VIEW.getId()}, 0, "${i18CustomText}", "", -1, ${user.ID?c});

</script>