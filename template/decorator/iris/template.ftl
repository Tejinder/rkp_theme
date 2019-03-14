<#-- A default template for Synchro -->
<!DOCTYPE html>

<html lang="en">

<head>
<#include "/template/decorator/default/header-favicon.ftl" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Important $j script files -->
<script src="/8.0.3.1619a91/resources/scripts/jquery/jquery.js"></script>
<script src="/8.0.3.1619a91/resources/scripts/jquery/jquery.define.js"></script>
<!-- Important $j script files -->

<!-- DWR Files used in SynchrO -->
<script language="JavaScript" type="text/javascript" src="<@s.url value='/dwr/engine.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='/dwr/interface/InviteUserUtil.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='/dwr/interface/FieldMappingUtil.js'/>"></script>
<script type="text/javascript" src="<@s.url value='/dwr/interface/ProjectReadTracker.js' />"></script>



<!-- SynchrO Global files -->
<link rel="stylesheet" type="text/css" media="all" href="${themePath}/style/winxp.css" title="winxp" />
<link href="${themePath}/style/zpcal.css" rel="stylesheet" type="text/css">
<link href="${themePath}/style/template.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${themePath}/js/synchro/utils.js"></script>
<script type="text/javascript" src="${themePath}/js/synchro/calendar.js"></script>
<link href="${themePath}/style/jive-icons-8.css" rel="stylesheet" type="text/css">

<!-- import the language module -->
<script type="text/javascript" src="${themePath}/js/synchro/calendar-en.js"></script>	
<script type="text/javascript" src="${themePath}/js/synchro/calendar-setup.js"></script>
<!--<script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>-->
    
<!-- DWR token code written for Synchro jive 8 calls-->
<#assign jive_token = jiveContext.getSpringBean("jiveXHRTokenValidator").generateXHRtoken(user) />		

<script>
	
	dwr.engine.setHeaders({
	  "Content-Type":"text/plain",
	  "X-J-Token":"${jive_token}"
	});    
</script>


<#if session.getAttribute('grail.portal.type')??>
    <#assign portalType =  session.getAttribute('grail.portal.type')>
</#if>

<#assign pageTitle=action.getText('global.portal.title')></assign>
<#if (request.requestURI?contains('/login.jspa'))>
    <#assign pageTitle=action.getText('global.portal.login.title')></assign>
<#elseif (request.requestURI?contains('/portal-options.jspa'))>
    <#assign pageTitle=action.getText('global.portal.selection.title')></assign>
<#elseif (request.requestURI?contains('/disclaimer.jspa'))>
    <#assign pageTitle=action.getText('global.portal.disclaimer.title')></assign>
<#elseif portalType??>
    <#if portalType == 'rkp'>
        <#assign pageTitle=action.getText('global.rkp.title')></assign>
    <#elseif portalType == 'synchro'>
        <#assign pageTitle=action.getText('global.synchro.title')></assign>
    <#elseif portalType == 'grail'>
        <#assign pageTitle=action.getText('global.grail.title')></assign>
    <#elseif portalType == 'kantar'>
        <#assign pageTitle=action.getText('global.kantar.title')></assign>
    <#elseif portalType == 'oracle_documents'>
        <#assign pageTitle="Oracle Documents"></assign>
    </#if>

</#if>
<#--<title>${skin.utils.abbreviate(page.title!(""), 50)} <#if page.title?? && "" != page.title?trim>|</#if> ${skin.template.rootCommunityName}</title>-->
<title>${pageTitle}</title>


<link rel="stylesheet" href="${themePath}/style/jquery-ui.css" type="text/css" />
<link rel="stylesheet" href="${themePath}/style/jive_custom.css" type="text/css" />


<img style="display:none;" height='70' src='${themePath}/images/synchro/export-pdf-logo.jpg' />

<#assign asyncLoadRTEValue = page.getProperty("meta.asyncLoadRTE")!"true" />
<#assign asyncLoadRTE = asyncLoadRTEValue != "false" />


<#include "/template/decorator/iris/header-custom.ftl" />
<#include "/template/decorator/iris/header-javascript-jquery.ftl" />





<link rel="stylesheet" href="<@s.url value='${themePath}/css/font-awesome.min.css'/>" type="text/css" />
<!-- Include the default CSS -->


${page.head}





<link rel="stylesheet" href="<@s.url value='${themePath}/style/jquery/datepicker.css'/>" type="text/css" media="all" />


<link rel="stylesheet" href="${themePath}/style/synchro-new_modified.css?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/css" media="all" />
<link rel="stylesheet" href="${themePath}/style/synchro-new.css?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/css" media="all" />

<link rel="stylesheet" href="${themePath}/style/osp-oracle.css?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/css" media="all" /> 

<link rel="stylesheet" href="${themePath}/style/iris.css" type="text/css" media="all" />


	


<!--[if !IE 8]><!-->
<link rel="stylesheet" href="<@s.url value='${themePath}/style/ie8.css'/>" type="text/css" media="all" />
<!--<![endif]-->






<!--[if lt IE 9]><![endif]-->
<#--<#if includeAdvancedCSS>-->
<#--<link rel="stylesheet" href="${themePath}/style/rkp.css" type="text/css" media="all" />-->
<#--</#if>-->
<#--<#if skinTemplateUtils.includePaletteCSS>-->
<#--<link rel="stylesheet" href="<@s.url value='${skinTemplateUtils.paletteCSSPath}'/>" type="text/css" />-->
<#--</#if>-->

<#--Commented out the below: not sure why it was being called -->
<#--<link rel="stylesheet" type="text/css" href="<@resource.url value="/styles/tiny_mce3/plugins/inlinepopups/skins/clearlooks2/window.css" />" />-->



<style type="text/css"><@s.action name='custom-css' executeResult='true' ignoreContextParams='true' /></style>
<style type="text/css"><@s.action name='custom-css-container' executeResult='true' ignoreContextParams='true' /></style>


<script src="${themePath}/js/jquery.loader.Iris.js" type="text/javascript"></script>

<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/jquery/jquery.cookie.js'/>"></script>

<link rel="stylesheet" href="${themePath}/style/jmenu.css" type="text/css" />
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/jquery/jquery.freezeheader.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jMenu.jquery.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.elastic.source.js'/>"></script>



<!--
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/project-stage-navigator.js'/>"></script>

<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ui.dialog.js'/>"></script>-->
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/dropdown.custom.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/prototype.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/light-box.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/ajax-multi-part-form.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/ajax-multi-part-import-form.js'/>"></script>


<script src="${themePath}/js/synchro/field-attachment-popup.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<!--
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/apps/services/user_service.js'/>"></script>-->
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/date-parser.js'/>"></script>

<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/dynamic-height-loader.js'/>"></script>
<!--
<script language="JavaScript" type="text/javascript" src="<@s.url value='/resources/scripts/jquery/ui/ui.datepicker-min.js'/>"></script>-->
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/html2canvas.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.plugin.html2canvas.js'/>"></script>
<!--<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.synchro.lightbox_me.js'/>"></script> -->


<script src="${themePath}/js/synchro/invite.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>

<#assign targetObj = skin.template.getTargetObject()/>




<#--
<#include "/template/decorator/synchro/header-custom.ftl" />-->

<script type="text/javascript">


var containerType = ${targetObj.objectType?c};
var containerID = ${targetObj.ID?c};



<#if skin.template.spotlightSearchEnabled>
var spotlightSearchURL = "<@s.url action='spotlight-search' />";
</#if>

// Dialog Box code
function dialog(props, callback) {
    var dialogOpen = false;
    var actionButtonClicked = '';

    var scrollTop = $j(window).scrollTop();

    $j(window).bind("mousewheel",function(event){
        if(dialogOpen) {
            event.preventDefault();
        }
    });

    var target = $j("#dialog-box");

    if(props == undefined) {
        props = {};
    }
    if(props != undefined && props.buttons != undefined) {
        $j.each(props.buttons, function(key, value){
            props.buttons[key] = function() {
                value();
                actionButtonClicked = key;
                closeDialog();

            }
        });
    } else {
        props.buttons = {
            "OK": function() {
                if(callback != undefined) {
                    callback();
                }
                actionButtonClicked = "OK";
                closeDialog();
            }
        };
    }
    var default_props = {
        resizable: false,
        modal: true,
        position: ['center','top'],
        autoReposition : true,
        open:function() {
            $j(window).bind("mousewheel",function(event){
                event.preventDefault();
            });
        },
        close:function(e) {
            var nonCloseActionButtons = props.nonCloseActionButtons;
            if(actionButtonClicked == '' || (nonCloseActionButtons && nonCloseActionButtons.indexOf(actionButtonClicked) < 0)) {
                if(props.closeActionButtonsClickHander) {
                    props.closeActionButtonsClickHander();
                }
            }

        }
    };
    if(props != undefined) {
        props = $j.extend(default_props, props)
    }

    jQuery(target).dialog(props);
    if(props.html != undefined) {
        jQuery(target).html(props.html);
    }

    $j(".ui-dialog-content").css("min-height", "0px");
    $j(".ui-dialog-content").css("margin-top", "10px");
    $j(".ui-dialog-buttonpane").css("margin-top", "0px");
    $j(".ui-dialog-buttonpane").css("padding-top", "0px");
    $j(".ui-dialog").css("position", "absolute");
    $j(".ui-dialog").css("width", "auto");
    $j(".ui-dialog").css("min-width", "300px");
    $j(".ui-dialog").css("max-width", "900px");

    var t = $j(".ui-dialog"), w = window;
    $j(t).offset({
        top: ($j(w).height() / 2) - ($j(t).height() / 2) + (scrollTop),
        left: ($j(w).width() / 2) - ($j(t).width() / 2)
    });

    $j(window).scrollTop(scrollTop);

    $j.each($j(".ui-dialog .ui-dialog-buttonpane button"),function(idx, btn){
        var val = $j.trim($j(btn).html());
        if((/(CANCEL|CLOSE)/i).test(val)) {
            $j(btn).addClass("close");
        } else if((/(DELETE|REMOVE)/i).test(val)) {
            $j(btn).addClass("delete");
        }
    });

}

function closeDialog(target) {
    if(target == undefined) {
        target = $j("#dialog-box");
    }
    target.dialog('destroy');
}

var userService = null;
function initializeUserPicker(options) {
   
	if(options.$input) {
        var startingUsers = null;
        if(options.value) {
            if(!userService) {
                userService = new jive.Services.UserService();
            }
            if($j.isArray(options.value)) {
                var users = [];
                $j.each(options.value, function(idx ,val) {
                    var user = userService.getUser(val);
                    if(user) {
                        users.push(user);
                    }
                })
                if(users.length > 0) {
                    startingUsers = { users :users , userlists : [] }
                }
            } else if(options.value > 0) {


                var user = userService.getUser(options.value);
                if(user) {
                    startingUsers = { users :[user] , userlists : [] }
                }
            }
        } else {
            startingUsers = <@jive.userAutocompleteUsers users=participantBeans />;
        }

        var defaultOptions =  {
            multiple: false,
            listAllowed: false,
            startingUsers: startingUsers,
            disableDefaultFilters:true,
            isSynchroPortal:true,
            isKantarPortal:false
        };
        var name = '';
        if(options.name) {
            name = options.name;
        } else {
            name = $j(options.$input).attr("name");
        }
        var autocompleteref = 'autocomplete';
        if(name) {
            autocompleteref +=  '_' + name;
        }
        options =  $j.extend(defaultOptions, options);
        window[autocompleteref] = new jive.UserPicker.Main(options);
		//$j(".j-user-autocomplete").attr("placeholder","");
		$j('[class^="j-user-autocomplete"]').attr("placeholder","");
		$j('[class^="jive-chooser-browse j-select-people j-btn-global"]').prop('title', 'Select People');
		
 }	  
}


</script>
</head>

<body class="${page.getProperty("body.class")!}">
<#assign synchroURL = request.requestURL />


<div class="maindiv">
    <a name="top"></a>

<#if synchroURL?? && (synchroURL?contains("iris-summary/search-results-open!execute.jspa") || synchroURL?contains("iris-summary/search-results-advance!execute.jspa") || synchroURL?contains("iris-summary/search-results-synchro-code!execute.jspa")) >
	<div class="fixSearchResultHeader">
</#if>	
    <div id="j-header-wrap">
    <#include "/template/decorator/default/license-banner.ftl" />
        <header id="j-header"  <#if synchroURL?contains("/oracledocuments/")>class="oracle-documents"</#if>>
        <#include "/template/decorator/iris/page-header-new.ftl" />


        <#if synchroURL?? && !(synchroURL?contains("login.jspa") || synchroURL?contains("portal")
        || synchroURL?contains("disclaimer"))>
            <div class="header-nav">
                <script>
                    $j(document).ready(function(){
                        $j("#header-menu").jMenu({
                            openClick : false,
//                            ulWidth :'100%',
                            TimeBeforeOpening : 0,
                            TimeBeforeClosing : 0,
                            animatedText : false,
                            paddingLeft: 1,
                            effects : {
                                effectSpeedOpen : 0,
                                effectSpeedClose : 0,
                                effectTypeOpen : 'slide',
                                effectTypeClose : 'slide',
                                effectOpen : 'swing',
                                effectClose : 'swing'
                            }

                        });
                    });
                </script>
                <ul id="header-menu">
					<!--<a  title="Home" href="/iris-summary/admin-home.jspa">Admin-Home</a>-->
                     <li class="header-nav-home"><a href="<@s.url value="/portal-options.jspa"/>"></a>
                          
                          <div class="headerHomeHiddenText">OSP Home</div>

                    </li>                    


                </ul>
            </div>
   
            
        </#if>

        </header>
    </div>

<#if synchroURL?? && synchroURL?contains("iris-summary/search-results-open!execute.jspa") >		
	
    
	<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
	<div class="header-top-page-wrapper"></div>

        <div class="searchResultBar">
          <div class="searchBarContainer">
                <form method="POST" name="searchIRISSummaryForm" id="searchIRISSummaryForm" action="/iris-summary/search-results-open!execute.jspa">
                   <#if searchText?? && searchText?contains("'")>
						<input type="Search" placeholder="Enter Keywords for Search"  onfocus="this.placeholder = ''" onblur="this.placeholder ='Enter Keywords for Search' " name="searchText" id="searchText" value="${searchText}" autocomplete="off">
					<#elseif searchText??>
                        <input type="Search" placeholder="Enter Keywords for Search"  onfocus="this.placeholder = ''" onblur="this.placeholder ='Enter Keywords for Search' " name="searchText" id="searchText" value='${searchText}' autocomplete="off">
                        
                    <#else>
                        <input type="Search" placeholder="Enter Keywords for Search" onfocus="this.placeholder = ''" onblur="this.placeholder ='Enter Keywords for Search' " name="searchText" id="searchText" value="" autocomplete="off">
                    </#if> 	
                                             
                    <input type="hidden" name="downloadScore" id="downloadScore" value="">
					<#if searchBySynchroId?? && searchBySynchroId=="searchBySynchroId">
						<input type="hidden" id="searchBySynchroId" name="searchBySynchroId" value="searchBySynchroId">
					<#else>
						<input type="hidden" id="searchBySynchroId" name="searchBySynchroId" value="">
					</#if>	
                    <a class="searchBarSearchText" onclick="searchIRIS();"><span>SEARCH</span> <i class="fa fa-search"></i></a>
                    <#if isAdminUser >
						
						<#if user.ID == 2002 || user.ID == 2184 || user.ID == 2003>
							<a class="searchBarSearchText" onclick="downloadScores();">Download Scores</a>
							
						</#if>	
					</#if>	
					
                  
                </form> 
                <!-- <a href="#" data-popup-boolean-search="Popup-booleanSearch" class="booleanSearchresult">BOOLEAN SEARCH</a> -->
			<a href="#" data-popup-boolean-search="Popup-booleanSearch" class="booleanSearchresult">Would you like to build your own search string?</a>
				

            </div>


        </div>
		
		 <div class="deselectPosition">
            <label class="checkboxContainer deselectResult"  onclick="deSelectAllOptions();" style="display: none;">Deselect All
                <input type="checkbox" class="searchResultDeselectAll">
                <span class="checkmark"></span>   
            </label>
       <!--    <a href="#" class="deselectOptions" onclick="deSelectAllOptions();">Deselect All</a> -->
        </div>
		
		<script type="text/javascript">
			$j("#searchText").on("keypress", function (e) {            

				if (e.keyCode == 13) {
					// Cancel the default action on keypress event
					e.preventDefault(); 
					searchIRIS();
				}
			});
		</script>

</div> <!-- end fixSearchResultHeader -->

<#elseif synchroURL?? && synchroURL?contains("iris-summary/search-results-advance!execute.jspa") >			
    
	<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
	<div class="header-top-page-wrapper"></div>

        <div class="searchResultBar">
          <div class="searchBarContainer">
                <form method="POST" name="searchIRISSummaryForm" id="searchIRISSummaryForm" action="/iris-summary/search-results-advance!execute.jspa">
                    

					<#if searchText?? && searchText?contains("'")>
						<input type="Search" name="searchText" placeholder="Enter Search String" onfocus="this.placeholder = ''" onblur="this.placeholder ='Enter Search String' " id="searchText" value="${searchText}" autocomplete="off">
					<#elseif searchText??>
                        <input type="Search" name="searchText" placeholder="Enter Search String" onfocus="this.placeholder = ''" onblur="this.placeholder ='Enter Search String' " id="searchText" value='${searchText}' autocomplete="off">
                        
                    <#else>
                        <input type="Search" name="searchText" placeholder="Enter Search String" onfocus="this.placeholder = ''" onblur="this.placeholder ='Enter Search String' " id="searchText" value="" autocomplete="off">
                    </#if> 					
                                             
                    <input type="hidden" name="downloadScore" id="downloadScore" value="">
					<#if searchBySynchroId?? && searchBySynchroId=="searchBySynchroId">
						<input type="hidden" id="searchBySynchroId" name="searchBySynchroId" value="searchBySynchroId">
					<#else>
						<input type="hidden" id="searchBySynchroId" name="searchBySynchroId" value="">
					</#if>	
                    <a class="searchBarSearchText" onclick="searchIRIS();"><span>SEARCH</span> <i class="fa fa-search"></i></a>
                    <#if isAdminUser >
						<#if user.ID == 2002 || user.ID == 2184 || user.ID == 2003>
							<a class="searchBarSearchText" onclick="downloadScores();">Download Scores</a>
							
						</#if>	
					</#if>	
					
                </form> 
             
			  <!--  <a href="#" class="deselectOptions" onclick="deSelectAllOptions();" style="display: none">Deselect All</a> -->
               <a href="#" data-popup-boolean-search="Popup-booleanSearch" class="booleanSearchresult">Would you like to build your own search string?</a>
				

            </div>


        </div>

        <div class="deselectPosition">
            <label class="checkboxContainer deselectResult"  onclick="deSelectAllOptions();" style="display: none;">Deselect All
                <input type="checkbox" class="searchResultDeselectAll">
                <span class="checkmark"></span>   
            </label>
       <!--    <a href="#" class="deselectOptions" onclick="deSelectAllOptions();">Deselect All</a> -->
        </div>
		
		<script type="text/javascript">
			$j("#searchText").on("keypress", function (e) {            

				if (e.keyCode == 13) {
					// Cancel the default action on keypress event
					e.preventDefault(); 
					searchIRIS();
				}
			});
		</script>	


</div> <!-- end fixSearchResultHeader -->

<#elseif synchroURL?? && synchroURL?contains("iris-summary/search-results-synchro-code!execute.jspa") >			
    
	<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
	<div class="header-top-page-wrapper"></div>

        <div class="searchResultBar">
          <div class="searchBarContainer">
                <form method="POST" name="searchIRISSummaryForm" id="searchIRISSummaryForm" action="/iris-summary/search-results-synchro-code!execute.jspa">
                    <#if searchText?? && searchText?contains("'")>
						<input type="Search" placeholder="Enter Synchro Code"  onfocus="this.placeholder = ''" onblur="this.placeholder ='Enter Synchro Code' " name="searchText" id="searchText" value="${searchText}" autocomplete="off" >
					<#elseif searchText??>
                        <input type="Search" placeholder="Enter Synchro Code" onfocus="this.placeholder = ''"  onblur="this.placeholder ='Enter Synchro Code' " name="searchText" id="searchText" value='${searchText}' autocomplete="off" >
                        
                    <#else>
                        <input type="Search" placeholder="Enter Synchro Code"  onfocus="this.placeholder = ''" onblur="this.placeholder ='Enter Synchro Code' " name="searchText" id="searchText" value="" autocomplete="off" >
                    </#if>  
                                             
                    <input type="hidden" name="downloadScore" id="downloadScore" value="">
					
					<input type="hidden" id="searchBySynchroId" name="searchBySynchroId" value="searchBySynchroId">
					
                    <a class="searchBarSearchText" onclick="vaildateSynchroCodes();"><span>SEARCH</span> <i class="fa fa-search"></i></a>
                    <#if isAdminUser >
						<#if user.ID == 2020>
						<#else>
							<#if user.ID == 2002 || user.ID == 2184 || user.ID == 2003>
								<a class="searchBarSearchText" onclick="downloadScores();">Download Scores</a>
							</#if>	
						</#if>	
					</#if>	
					
				<!--	<span class="jive-error-message" style="display: none;" id="invalidSynchroCode">Please enter Valid Synchro Code</span> -->
                  
                </form> 
               
			  <!--  <a href="#" class="deselectOptions" onclick="deSelectAllOptions();" style="display: none">Deselect All</a> -->
				

            </div>


        </div>
		
		 <div class="deselectPosition">
            <label class="checkboxContainer deselectResult"  onclick="deSelectAllOptions();" style="display: none;">Deselect All
                <input type="checkbox" class="searchResultDeselectAll">
                <span class="checkmark"></span>   
            </label>
       <!--    <a href="#" class="deselectOptions" onclick="deSelectAllOptions();">Deselect All</a> -->
        </div>
		
		<script type="text/javascript">
			$j("#searchText").on("keypress", function (e) {            

			if (e.keyCode == 13) {
				// Cancel the default action on keypress event
				e.preventDefault(); 
				vaildateSynchroCodes();
				return false;
			}
		});
		</script>

</div> <!-- end fixSearchResultHeader -->


</#if>

    <!-- breadcrumbs Text -->

    <section id="j-main" class="clearfix">


    
        <!-- Page container -->
		
		<#if synchroURL?? && (synchroURL?contains("iris-summary/search-results-open!execute.jspa") || synchroURL?contains("iris-summary/search-results-advance!execute.jspa") || synchroURL?contains("iris-summary/search-results-synchro-code!execute.jspa")) >
		<#else>
			 <div class="header-top-page-wrapper"></div>
 		</#if>	
	
	
		
	
        <div id="main-container" class="container">
        ${page.body}
        </div>
   

    </section>
  <#include "/template/decorator/default/page-tooltips.ftl" />
   <#include "/template/decorator/default/post-footer.ftl" />
   <#include "/template/global/include/synchro-macros.ftl" />

</div>




<div id="termsndCondition" style="display:none">
	<div id="jive-body-main">
    <!-- BEGIN main body column -->
    <div id="jive-body-maincol-container">
        <div id="jive-body-maincol">
            <div class="main_disclaimer">
                <div class="jive-standard-formblock-container jive-login-formblock">
                    <label>Legal Notices</label>
                    <div id="disclaimer-container" class="jive-standard-formblock" style="display: block; height: 357px;">
                        <div>
                            <span><strong class="dis_heading">Additional Conditions of Use</strong></span>
                            <span>
                                    <p>Please use the Research Management Tools [Synchro, IRIS, Share and Oracle]  responsibly and respectfully. The Research Management Tools are a global business resource and must not be used for personal conversations.</p>
                                    <p>Please consider that once you submit information on the Research Management Tools, everyone with access to the Research Management Tools can read it.</p>
                                    <p>Please make your submission(s) clearly and ensure that it is not misunderstood. Do not forget that you are legally responsible for what you submit on the Research Management Tools and you should not share information that you would not want disclosed in court.</p>
                                    <p>Please consider how your comment could be received by others.</p>
                                    <p>You agree to keep your username and password confidential. If you suspect that your username and password have become known to another party then you agree to change your password immediately.</p>
                            </span>
                        </div>

                        <div>
                            <span><strong class="dis_heading">ASU30</strong></span>
                            <span>
                                    <p>Where any reference is made in this document to 'adult' or 'young adult', the term is defined as anyone who is 18 years or over or such higher age as the local law and/or industry code in any particular country requires. Any reference in this document to 'ASU30', 'consumer', 'target consumers', 'smokers', 'target audience', or any similar term shall mean smokers who are adults.</p>
                            </span>
                        </div>


                        <div>
                            <span><strong class="dis_heading">Local Legislation/Regulations</strong></span>
                            <span>
                                    <p>Please note that the material contained in this document related to a specific market and as such may present applications and issues which might not be legally permissible in other markets. Similarly, you should not assume that because an application has been permitted in your market in the past that it will continue to be permitted in the future, since tobacco regulation and legislation changes regularly. In addition, the company's views on socially responsible marketing are subject to change in response to feedback from each of its stakeholder groups. As a result, you must ensure that prior to applying any such activities or applications in your own market you obtain specific local legal advice regarding the permissibility of that activity or application, taking into consideration both local legislation and regulations, the implementation of the International Marketing Standards and the then current views on socially responsible marketing practices.</p>
                            </span>
                        </div>

                        <div>
                            <span>
                                <p><strong class="dis_heading copyright">Copyright</strong> © British-American Tobacco (Holdings) Limited. All rights reserved. No part of this document may be reproduced in any form or any means without the prior written consent of British-American Tobacco (Holdings) Limited. This document is proprietary to British-American Tobacco (Holdings) Limited and is provided at its discretion. Unauthorised possession or use of this material or disclosure of the proprietary information may result in legal action.</p>
                            </span>
                        </div>

                        <div>
                            <span><strong class="dis_heading">Data Protection Notice</strong></span>
                            <span>
                                    <p>British-American Tobacco (Holdings) Limited respects the privacy of British American Tobacco ("BAT") Group personnel. It is committed to safeguarding their privacy and to acting responsibly and with integrity with regard to protecting their rights and freedoms.</p>
                                    <p>In registering to use the Research Management Tools services ("the Services") you will be required to input certain personal data relating to you such as your name, business email address and telephone number ("Your Personal Data").</p>
                                    <p>BASS will collect, use and/or process Your Personal Data in order to provide you with the Services and may share Your Personal Data with other members of the BAT Group of Companies worldwide so that it can be processed in order to provide you with the Services.</p>
                                    <p>Your Personal Data may be shared with other members of the BAT Group of Companies worldwide, Integreon Inc., Grail Research (a division of Integreon Managed Solutions, Inc.) and its Subcontractors outside the European Economic Area ("EEA" meaning member countries of the European Union and Switzerland and, Norway, Iceland and Liechtenstein) so that it can be processed in order to monitor your use of the system and share with you the latest developments about the system via newsletter or periodic surveys.</p>
                                    <p>Your Personal Data will be retained in the system until such time that your User account ends either because you are no longer a User or because you have left your employment at BAT at which point Your Personal Data will be deleted.</p>
                                    <p>In proceeding with your registration to use the Services you agree to the processing and handling of Your Personal Data as set out above.</p>
                                    <p>Should you require any further information please contact: <a href="mailto:Taina_Vauhkonen@bat.com" style="color: #00adc3 !important">Taina Vauhkonen</a></p>  
                            </span>
                        </div>


                    </div>
					
					
			 
					
                    
                </div>
            </div>
        </div>
    </div>
    <!-- END main body column -->
</div>
	
</div>








<footer id="j-footer">
<#assign license = jiveContext.getLicenseManager().getJiveLicense()/>

    <!-- footer -->
    <div class="footer_main">
    <#--<div class="footer">Synchro powered by Jive SBS @ ${license.version.versionString} Community Software</div>-->
        <div class="footer-left"><h4> 
	<#--	<a  href="javascript:void(0);" onclick="javascript:contactUs()">
				
				Contact Us  </a> -->
		   <a href="/iris-summary/iris-support.jspa"> Support </a>		
				
				</h4></div>
				
        <div class="footer-right">
            <ul>
            <#--<li class="footer-info"><a href="#"></a></li>-->
				<#if synchroURL?contains("/new-synchro/home.jspa") >
				<#elseif synchroURL?contains("/new-synchro/help.jspa") >
				<#else>
					<!-- <li><a  href="<@s.url value="/new-synchro/help.jspa"/>"  target="_blank" >Support</a></li> -->
				</#if>	
                <li><a href="javascript:void(0);" onclick="javascript:terms_condition()">Terms & Conditions</a></li>
            </ul>
        </div>
		
		  <!--  if iris summary  exists       -->
<#if irisSummaryList?? && irisSummaryList?size gt 0>   
  <div class="displayResult">
    <span id="project-limit-text">Displaying</span>
    <#if resultCount gt 10>
      <select name="project-limit" id="project-limit" onchange="loadLimit()">
        <option value="10" <#if limit?? && limit==10> selected </#if> >10</option>
        <#if resultCount gt 11>
          <option value="15" <#if limit?? && limit==15> selected </#if> >15</option>
        </#if>
        <#if resultCount gt 16> 
          <option value="20"<#if limit?? && limit==20> selected </#if> >20</option>
        </#if>  
        <#if resultCount gt 21>
          <option value="50" <#if limit?? && limit==50> selected </#if> >50</option>
        </#if>
        <#if resultCount gt 51>
          <option value="100" <#if limit?? && limit==100> selected </#if> >100</option>
        </#if>  
      </select>
      <span id="project-limit-text">of ${resultCount} results</span>
    <#else>
      <#if resultCount == 1>
        <span id="project-limit-text"> ${resultCount} result</span>
      <#else>
        <span id="project-limit-text"> ${resultCount} results</span>
      </#if>  
    </#if>
    
</div>
</#if>
		
		
    </div>
</footer>

<script type="text/javascript">
    /*Footer CSS code*/
    var docH;
  
    /*Footer CSS code*/

function contactUs()
{
    window.location.href = "mailto:assistance@batinsights.com?subject=Research%20Management%20Tool:%20Assistance";
}
	
function terms_condition(){
		
		$j("#termsndCondition").dialog({
			modal: true,
			width: 900,
			resizable: false,
			draggable: false
		});
		window.scrollTo(0,0);
		$j('#termsndCondition').scrollTo(0,0);
	}

  
	
	
var orangeBtn = function(){
var okOrangeBtn =$j(".ui-dialog-buttonset button.ui-button").text().toUpperCase();
if(okOrangeBtn=="OK"){$j(".ui-dialog-buttonset button.ui-button").addClass("orangeButton")}	
}
var greyBtn = function(){
var okgreyBtn =$j(".ui-dialog-buttonset button.ui-button").text().toUpperCase();
if(okgreyBtn=="NO"){$j(".ui-dialog-buttonset button.ui-button").addClass("greyButton")}	
}
var relPos = function(){
$j(".positionSet").parents(".ui-dialog").addClass("posRel");
}

jQuery(document).ready(function($) {



	
scrollFunctionFix();
orangeBtn();
greyBtn();

//$j("#table-main").height(totalHeight)
//$j("tr").height()



 
});
	
	var scrollFunctionFix = function(){
	  var request = true;
var onMouseWheelSpin = function(event) {
    if(request === true){ 
        request = false;
        var nDelta = 0;
        if (!event) { event = window.event; }
        // cross-bowser handling of eventdata to boil-down delta (+1 or -1)
        if ( event.wheelDelta ) { // IE and Opera
            nDelta= event.wheelDelta;
            if ( window.opera ) {  // Opera has the values reversed
                nDelta= -nDelta;
            }
        }
        else if (event.detail) { // Mozilla FireFox
            nDelta= -event.detail;
        }
        if (nDelta > 0) {
            zoomFun( 1, event );
        }
        if (nDelta < 0) {
            zoomFun( -1, event );
        }
        if ( event.preventDefault ) {  // Mozilla FireFox
            event.preventDefault();
        }
        event.returnValue = false;  // cancel default action
    }
}

var zoomFun = function(delta,e) {
    if(delta > 0){ // zoom in
        alert("In");
    }else{ // zoom out
        alert("Out");
    }
    request = true;
}

var setupMouseWheel = function(){
    // for mouse scrolling in Firefox
    var elem = document.getElementById("zoom");
    if (elem.addEventListener) {    // all browsers except IE before version 9
        // Internet Explorer, Opera, Google Chrome and Safari
        elem.addEventListener ("mousewheel", onMouseWheelSpin, false);
        // Firefox
        elem.addEventListener ("DOMMouseScroll", onMouseWheelSpin, false);
    }else{
        if (elem.attachEvent) { // IE before version 9
            elem.attachEvent ("onmousewheel", onMouseWheelSpin);
        }
    }   
}
$j(window).on("DOMMouseScroll mousewheel wheel", onMouseWheelSpin);
	
	
	
	
	}
	
	$j(window).load(function(){
		$j("#main-container").css("display","block");
	})

	
	var HeightSet = function (){
			var trLength = $j(".scrollable-table.project_status_table tbody tr").length;
var trHeightGet = $j(".scrollable-table.project_status_table tbody tr").height();
var totalHeight = trLength * trHeightGet;



if(totalHeight>=400){
	$j('.scrollable-table.project_status_table tbody').css('display','block');
	$j('.scrollable-table.project_status_table thead').css('width','977px');
	
}
else{
	
	$j('.scrollable-table.project_status_table tbody').css('display','inherit');
	$j('.scrollable-table.project_status_table thead').css('width','993px');
}
	}
	

</script>
<div id="dialog-box" title="Alert" style="display:none;min-height:auto;">
    <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span></p>
</div>

<#include "/template/global/synchro-result-filter-new.ftl" />

<div id="backgroundPopup"></div>


<script type="text/javascript">
    
    $j(document).ready(function(){

    $j('#header-menu .header-nav-home a.fNiv').hover(function() {      
       $j('.headerHomeHiddenText').css('display','block');    
       }, function() {
          $j('.headerHomeHiddenText').css('display','none');
        });

    });

</script>



</body>

</html>
