
<!DOCTYPE html>

<html lang="en">

<head>
<#include "/template/decorator/default/header-favicon.ftl" />
<meta http-equiv="refresh" content="86400">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<script src="/8.0.3.1619a91/resources/scripts/jquery/jquery.js"></script>
<script src="/8.0.3.1619a91/resources/scripts/jquery/jquery.define.js"></script>

<script language="JavaScript" type="text/javascript" src="<@s.url value='/dwr/engine.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='/dwr/interface/InviteUserUtil.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='/dwr/interface/FieldMappingUtil.js'/>"></script>
<script type="text/javascript" src="<@s.url value='/dwr/interface/ProjectReadTracker.js' />"></script>
<script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>
<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>


<link rel="stylesheet" type="text/css" media="all" href="${themePath}/style/winxp.css" title="winxp" />
<link href="${themePath}/style/zpcal.css" rel="stylesheet" type="text/css">
<link href="${themePath}/style/template.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${themePath}/js/synchro/utils.js"></script>
<script type="text/javascript" src="${themePath}/js/synchro/calendar.js"></script>
<link href="${themePath}/style/jive-icons-8.css" rel="stylesheet" type="text/css">


<script type="text/javascript" src="${themePath}/js/synchro/calendar-en.js"></script>	
<script type="text/javascript" src="${themePath}/js/synchro/calendar-setup.js"></script>
<script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>
    

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
    <#elseif portalType == 'kantar_report'>
        <#assign pageTitle=action.getText('global.kantar.report.title')></assign>
    </#if>

</#if>
<#--<title>${skin.utils.abbreviate(page.title!(""), 50)} <#if page.title?? && "" != page.title?trim>|</#if> ${skin.template.rootCommunityName}</title>-->
<title>${pageTitle}</title>


<link rel="stylesheet" href="${themePath}/style/jquery-ui.css" type="text/css" />
<link rel="stylesheet" href="${themePath}/style/jive_custom.css" type="text/css" />




<#assign asyncLoadRTEValue = page.getProperty("meta.asyncLoadRTE")!"true" />
<#assign asyncLoadRTE = asyncLoadRTEValue != "false" />


<#include "/template/decorator/synchro/header-custom.ftl" />
<#include "/template/decorator/synchro/header-javascript-jquery.ftl" />

<link rel="stylesheet" href="<@s.url value='${themePath}/js/tinymce_4.1.2/skins/lightgray/skin.min.css'/>" type="text/css" />

<link rel="stylesheet" href="<@s.url value='${themePath}/js/tinymce_4.1.2/skins/lightgray/content.min.css'/>" type="text/css" />
<#include "/template/decorator/default/synchro-header-javascript-rte.ftl" />



${page.head}
<link rel="stylesheet" href="<@s.url value='${themePath}/style/jquery/datepicker.css'/>" type="text/css" media="all" />
<link rel="stylesheet" href="${themePath}/style/synchro.css?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/css" media="all" />
<!--[if !IE 8]><!-->
<link rel="stylesheet" href="<@s.url value='${themePath}/style/ie8.css'/>" type="text/css" media="all" />
<!--<![endif]-->


<script>

    var bVer = navigator.appVersion;
    var browserName = "";
    var browserVersion = "";

    $j(document).ready(function(){
        if(bVer.indexOf('MSIE') != -1) {
            var input = $j(".search_box");
            if($j(input).attr("placeholder") == $j(input).val()) {
                $j(input).val("");
            }
        }
    })
</script>

<!--[if lt IE 9]><![endif]-->





<style type="text/css"><@s.action name='custom-css' executeResult='true' ignoreContextParams='true' /></style>
<style type="text/css"><@s.action name='custom-css-container' executeResult='true' ignoreContextParams='true' /></style>


<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>

<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/jquery/jquery.cookie.js'/>"></script>

<link rel="stylesheet" href="${themePath}/style/jmenu.css" type="text/css" />
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/jquery/jquery.freezeheader.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jMenu.jquery.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.elastic.source.js'/>"></script>

<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/dropdown.custom.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/prototype.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/light-box.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/ajax-multi-part-form.js'/>"></script>


<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/auto-save.js?version=1'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/field-attachment-popup.js'/>"></script>

<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/date-parser.js'/>"></script>

<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/dynamic-height-loader.js'/>"></script>

<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/html2canvas.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.plugin.html2canvas.js'/>"></script>


<!--[if lt IE 9]>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/placeholder-fix.js'/>"></script>
<![endif]-->

<script src="${themePath}/js/synchro/invite.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/scripts/multifile.js'/>"></script>

<#assign targetObj = skin.template.getTargetObject()/>



<script type="text/javascript">
$j(document).ready(function(){
    var synchroPaddingTop = null;
    $j(".border-container").hide();
    $j(".border-container").css("min-height", DYNAMIC_HEIGHT_LOADER.getMainContainerHeight()-92);
    $j(".border-container").show();
    AUTO_SAVE.setDelayTime(${JiveGlobals.getJiveIntProperty("synchro.autosave.delay.time", 300000)?c})
    AUTO_SAVE.setAutoSaveEnable(${JiveGlobals.getJiveBooleanProperty("synchro.autosave.enable", true)?string});

    $j(".print-btn input").bind("click",function(){
        $j(".print-btn").hide();
        var errorMessageList = hidePanels();
        var selectConfiguredList = configureMultiselectList();
        configureLegalBox();
        window.print();

        setTimeout(
                function()
                {
                    showPanels(errorMessageList);
                    resetMultiselectList(selectConfiguredList);
                    resetLegalBox();
                    $j(".print-btn").show();
                }, 1000);
    });

   
    function hidePanels()
    {
        var logoheader = $j("<div id='export-pdf-logo'><img height='70' src='${themePath}/images/synchro/export-pdf-logo.jpg' /></div>");
        $j(".project_name_div").prepend(logoheader);

        var containerwidth = $j(".research_content").width();
        $j("#export-pdf-logo").next().css("width",(containerwidth)+"px");
        $j("#export-pdf-logo").next().css("text-align", "center");

        var errorMessageList = [];
        var $section = $j("#j-main");
        var paddingTop = $section.css('padding-top');
        synchroPaddingTop = paddingTop;
        $section.css('padding-top', 0);
        $j(".right-sidebar-list").css('visibility','hidden');
        $j(".required-actions").css('visibility','hidden');
        $j(".sidebar-approve-dates").css('visibility','hidden');
        $j(".j-form-datepicker-btn").css('visibility','hidden');
        $j(".jive-chooser-browse").hide();
        $j(".induction_text").hide();


        $j(".field-attachments").hide();
        $j(".jive-icon-attachment").hide();
        $j(".jive-attachments").hide();

        $j(".save").hide();
        $j(".character-limit").hide();
        $j(".pib-multi-country").hide();
        $j(".stage-navigator").hide();
        $j("#j-header-wrap").hide();
        $j("#j-footer").hide();

        if($j(".endmarket-menus").length>0)
        {
            $j(".endmarket-menus ul.main-sub-menus li a").each(function(i) {
                if(!$j(this).hasClass("active"))
                {
                    $j(this).parent().css('visibility','hidden');
                }
            });
        }


        var message_index = 0;
        $j('[id^=synchro-error-]').each(function(i) {
            var elementID = $j(this).attr("id");
            if(elementID!=null && elementID.indexOf("synchro-error")!=-1)
            {
                var indexNumber = elementID.slice(elementID.indexOf("synchro-error")+14);
                if(parseInt(indexNumber)>message_index)
                {
                    message_index = parseInt(indexNumber) + 1;
                }
            }
        });

        var indexCounter = 0
        $j(".jive-error-message").each(function(i) {
            if($j(this).is(":visible"))
            {
                var generated_id = "synchro-error-"+message_index;
                if($j(this).attr("id")=="")
                {
                    $j(this).attr("id", generated_id);
                    message_index = message_index + 1;
                }
                else
                {
                    generated_id = $j(this).attr("id");
                }

                errorMessageList[indexCounter++] = generated_id;
                $j("#"+generated_id).hide();
            }
        });

        $j("#jive-error-box").each(function(i) {

            if($j(this).is(":visible"))
            {
                var generated_id = "synchro-error-"+message_index;
                if($j(this).attr("id")=="")
                {
                    $j(this).attr("id", generated_id);
                    message_index = message_index + 1;
                }
                else
                {
                    generated_id = $j(this).attr("id");
                }

                errorMessageList[indexCounter++] = generated_id;
                $j("#"+generated_id).hide();
            }
        });


        $j(".action_buttons").hide();
        $j(".data-collection-all-div").each(function(i) {
            $j(this).find("span").hide();
        });



        return errorMessageList;

    }

    function showPanels(errorMessageList)
    {
        $j("#export-pdf-logo").next().removeAttr("style");
        $j("#export-pdf-logo").remove();

        var $section = $j("#j-main");
        if(synchroPaddingTop!=null)
        {
            $section.css('padding-top', synchroPaddingTop);
        }
        $j(".right-sidebar-list").css('visibility','visible');
        $j(".required-actions").css('visibility','visible');
        $j(".sidebar-approve-dates").css('visibility','visible');
        $j(".j-form-datepicker-btn").css('visibility','visible');
        $j(".jive-chooser-browse").show();
        $j(".induction_text").show();


        $j(".field-attachments").show();
        $j(".jive-icon-attachment").show();
        $j(".jive-attachments").show();

        $j(".save").show();
        $j(".character-limit").show();
        $j(".pib-multi-country").css("display","block");
        $j(".stage-navigator").show();
        $j("#j-header-wrap").show();
        $j("#j-footer").show();



        if($j(".endmarket-menus").length>0)
        {
            $j(".endmarket-menus ul.main-sub-menus li a").each(function(i) {
                if(!$j(this).hasClass("active"))
                {
                    $j(this).parent().css('visibility','visible');
                }
            });
        }


        for ( var i=0; i<errorMessageList.length; i = i+1 ) {
            $j("#"+errorMessageList[i]).show();
        }



        $j(".action_buttons").show();
        $j(".data-collection-all-div").each(function(i) {
            $j(this).find("span").show();
        });
    }

    function configureMultiselectList()
    {
        var selectConfiguredList = [];
        var selectConfiguredListCounter = 0;
        $j("select").each(function(i) {
            if($j(this).is(":visible") && ($j(this).attr("multiple") || $j(this).attr("size")>1))
            {
                var $select = $j(this);
                var selectid = $j(this).attr("id");
                var selectname = $j(this).attr("name");
                if(selectid && selectid!="")
                {
                    var selectsize = $j("#"+selectid+" option").size();
                    var optionCounter = 1;
                    if($j(this).hasClass('endmarket-multiple-select'))
                    {
                        var selectList = "<ul id='"+selectid+"-displaylist' style='list-style-type:none; float:left; width:182px; border:1px solid#e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control; margin-bottom:15px;'>";
                    }
                    else
                    {
                        var selectList = "<ul id='"+selectid+"-displaylist' style='list-style-type:none; float:left; width:182px; border:1px solid#e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control;'>";
                    }

                    $j("#"+selectid+" option").each(function()
                    {
                        if(optionCounter==1)
                        {
                            selectList = selectList + "<li style='padding-left:7px;padding-top:6px;'>"+$j(this).text()+"</li>";
                        }
                        else if(optionCounter==selectsize)
                        {
                            selectList = selectList + "<li style='padding-left:7px;padding-bottom:6px;'>"+$j(this).text()+"</li>";
                        }
                        else
                        {
                            selectList = selectList + "<li style='padding-left:7px;'>"+$j(this).text()+"</li>";
                        }
                        optionCounter++;
                    });
                      
                   

                    selectList = selectList + "</ul>";

                    if(selectname=="availableDataCollection")
                    {

                    }
                    else
                    {
                        $select.parent().append(selectList);
                    }
                    $select.hide();
                    selectConfiguredList[selectConfiguredListCounter++] = selectid;
                }
            }
        });

        return selectConfiguredList;
    }

   function resetMultiselectList(selectConfiguredList)
    {
        for(var i=0; i<selectConfiguredList.length; i=i+1 ) {
            $j("#"+selectConfiguredList[i]).show();
            $j("#"+selectConfiguredList[i]+"-displaylist").remove();
        }
    }

    

    function configureLegalBox()
    {
        if($j(".legal-checkbox-container")==undefined || $j(".legal-checkbox-container").length==0)
            return;
        var legalPreviewElement = $j("<div id='legal-preview-box'><label class='label_b'>Legal Approval</label></div>");
        legalPreviewElement.append($j(".legal-checkbox-container"));
        $j(".research_content").append(legalPreviewElement);
    }

    function resetLegalBox()
    {
        if($j(".legal-checkbox-container")==undefined || $j(".legal-checkbox-container").length==0)
            return;
        $j("#legal-box-main").append($j(".legal-checkbox-container"));
        $j("#legal-preview-box").remove();
    }
});

var containerType = ${targetObj.objectType?c};
var containerID = ${targetObj.ID?c};



<#if skin.template.spotlightSearchEnabled>
var spotlightSearchURL = "<@s.url action='spotlight-search' />";
</#if>


function dialog(props, callback) {
    var dialogOpen = false;
    

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
            props.buttons[key] = function() { value(); closeDialog();}
        });
    } else {
        props.buttons = {
            "OK": function() {
                if(callback != undefined) {
                    callback();
                }
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
        close:function() {
            $j(this).html("");
            $j(window).unbind("mousewheel");
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
    $j(".ui-dialog").css("max-width", "1000px");

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
    target.dialog( "close" );
}

var userService = null;
function initializeUserPicker(options) {
   
	if(options.$input) {
        var startingUsers = null;
         if(options.value && options.value > 0) {
            if(!userService) {
                userService = new jive.Services.UserService();
            }
            
			var user = userService.getUser(options.value);
			if(user) {
				startingUsers = { users :[user] , userlists : [] }
		   
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
    <div id="j-header-wrap">
    <#include "/template/decorator/default/license-banner.ftl" />
        
		 <header id="j-header" class="<#if portalType == 'kantar_report'>kantar-report<#else>kantar</#if>">
        <#include "/template/decorator/kantar/page-header.ftl" />


        <#if synchroURL?? && !(synchroURL?contains("login.jspa") || synchroURL?contains("portal")
        || synchroURL?contains("disclaimer"))>
		 <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
            <div class="header-nav">
              
                <ul id="header-menu">
                    <li class="header-nav-home"><a href="<@s.url value="/portal-options.jspa"/>"></a></li>
                    <#if portalType == 'kantar'>

                        <li><a href="<@s.url value="/kantar/kantar-dashboard.jspa"/>">My Dashboard</a></li>


                        <#if (synchroPermHelper.isSynchroMiniAdmin(user) || synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isSynchroGlobalSuperUser(user))>
                            <li><a href="<@s.url value="/kantar/create-brief-template!input.jspa"/>">Initiate a Request</a></li>
                            <li class="last"><a href="<@s.url value="/kantar/download-raw-extract.jspa"/>">Generate Report</a></li>
                        <#else>
                            <li class="last"><a href="<@s.url value="/kantar/create-brief-template!input.jspa"/>">Initiate a Request</a></li>
                        </#if>

                    <#elseif portalType == 'kantar_report'>

                        <#if synchroPermHelper.isDocumentRepositoryBATUser(user) || synchroPermHelper.isDocumentRepositoryAgencyUser(user)>
                            <li class="last"><a href="javascript:void(0);" onclick="showUploadKantarReportPopup()">Upload a New Document</a></li>
                        </#if>
                    </#if>
                    <li class="header-nav-help"><a href="javascript:void(0)" onclick="sendEmailQuery()"></a></li>
                </ul>
            </div>
       
        </#if>

        </header>
    </div>
    <section id="j-main" class="clearfix">


        <div id="main-container" class="container">
        ${page.body}
        </div>


    </section>
<#include "/template/decorator/default/page-tooltips.ftl" />
<#include "/template/decorator/default/post-footer.ftl" />

</div>

<footer id="j-footer">
<#assign license = jiveContext.getLicenseManager().getJiveLicense()/>

    <div class="footer_main">

        <div class="footer-left">
        <#if portalType == 'kantar_report'>
            <h4>Repository</h4>
        <#else>
            <h4>Kantar Support</h4>
        </#if>
        </div>
        <div class="footer-right">
            <ul>
                <li><a href="<@s.url value="/disclaimer.jspa"/>">Terms & Conditions</a></li>
            </ul>
        </div>
    </div>

</footer>
<script type="text/javascript">

    var docH;


   function showLoader(title){
        $j.loader({
            className:"blue-with-image",
            content: title
        });
    }

    function hideLoader()
    {
        $j("#jquery-loader").remove();
        $j("#jquery-loader-background").remove();
    }


</script>
<div id="dialog-box" title="Alert" style="display:none;min-height:auto;">
    <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span></p>
</div>
<#include "/template/global/synchro-result-filter.ftl" />
<div id="backgroundPopup"></div>

<#if portalType == 'kantar_report'>
<script type="text/javascript">
    var origBodyHeight, origMainDivHeight, origPoupHeight;
    $j(document).ready(function(){
        origBodyHeight = $j("body").height();
        origMainDivHeight = $j(".maindiv").height();
    });
    function showUploadKantarReportPopup(id) {
        
		$j('#error-message').hide();
        clearErrorMessage();
        var div = $j('<div id="kantar-report-upload-popup" class="kantar-report-upload-popup j-form-popup"></div>');
        $j('<a class="close" href="javascript:void(0)"></a>').appendTo($j(div));

        var subdiv = $j('<div></div>');

        $j(subdiv).appendTo($j(div));
		
        showLoader();
        var url = "<@s.url value='/kantar-report/upload-report!input.jspa'/>";
        if(id != undefined && id > 0) {
            url += "?id="+id;
        }
        <#if request.getParameter('reportTypeId')??>
            url += ((id != undefined && id > 0)?"&":"?")+"reportTypeId=${request.getParameter('reportTypeId')}";
        </#if>;
		
        $j(div).lightbox_me({centered:true,closeEsc:false,closeClick:false,overlayCSS:{background: 'black', opacity: .7},destroyOnClose:true,onLoad:function(){
            $j(div).hide();
			
            $j(subdiv).load(url,{},function(){
                $j(div).show();
                clearErrorMessage();
                hideLoader();
                origPoupHeight = $j("#kantar-report-upload-form").height();
                resizeUploadKantarReportPopup()

            }, function(){$j(div).show()});
			
        }});
		
    }


    function resizeUploadKantarReportPopup() {

        var popupHeight = $j("#kantar-report-upload-popup").height();
        var bodyHeight = $j("body").height();
        var mainDivHeight = $j(".maindiv").height();
        var overlayHeight = $j(".lb_overlay").height();
        if((popupHeight + 150) > bodyHeight) {
            $j("body").height(popupHeight + 200);
            $j(".maindiv").height(popupHeight + 200);
            $j(".lb_overlay").height(popupHeight + 200 + 37);
            var topPos = $j("#kantar-report-upload-popup").offset().top;
            if(topPos > 45) {
                $j("#kantar-report-upload-popup").css("top", (topPos - 37) + "px");
            }
            $j("body").scrollTop();
        }
        else {
            $j("body").height(origBodyHeight);
            $j(".maindiv").height(origMainDivHeight);
            $j(".lb_overlay").height(origBodyHeight);
        }

        $j("#kantar-report-upload-popup").trigger("resize");
        $j("body").scrollTop();
    }

    function closeUploadKantarReportPopup() {
        $j("#kantar-report-upload-popup").trigger("close");

    }
    function showErrorMessage(msg) {
        var pattern = /^\<li\>(.*)\<\/li\>$/;
        if(msg.match(pattern)) {
            msg = "<ul>"+msg+"</ul>";
        } else {
            msg = "<ul><li>"+msg+"</li></ul>"
        }
        $j('#error-message').show();
        $j('#error-message').html(msg);
    }

    function clearErrorMessage() {
        $j('#error-message').hide();
        $j('#error-message').html('');
    }
</script>
</#if>


<div id="emailNotification" style="display:none">

    <script type="text/javascript">
        $j(document).ready(function(){
            AjaxMultiPartForm.initialize($j("#email-notification-form"),onEmailQuerySentSuccess,onEmailQuerySentError);
        });
        function onEmailQuerySentSuccess(response, textStatus, jqXHR) {
            hideLoader();
            var result = JSON.parse(response);
            if(result != undefined && result != null) {
                var data = result.data;
                if(data != undefined && data != null) {
                    if(Boolean(data.success)) {
                        closeEmailNotification();
                        dialog({title:"Confirmation",html:"<p>"+data.message+"</p>"})
                    } else {
                        showNotificationError(data.message);
                    }
                }

            }
        }

        function onEmailQuerySentError(data, textStatus, errorThrown) {
            hideLoader();
            showNotificationError(data.message);
        }
        function closeEmailNotification() {
            $j("#emailNotification").trigger('close');
        }
        function sendEmailQuery() {
            hideNotificationError();
            $j("#emailNotification").lightbox_me({centered:true,closeEsc:false,overlayCSS:{background: 'black', opacity: .7},onClose:resetNotificationForm});
        <#if portalType == 'kantar_report'>
            $j("#recipients").val("${JiveGlobals.getJiveProperty('research.repository.portal.email.notification.recipient', 'assistance@batinsights.com')}");
        <#else>
            $j("#recipients").val("${JiveGlobals.getJiveProperty('kantar.portal.email.notification.recipient', 'assistance@batinsights.com')}");
        </#if>

        }

        function showNotificationError(msg) {
            $j(".kantar-email-notification-error-msg").show();
            $j(".kantar-email-notification-error-msg").html("<p>"+msg+"</p>");
        }

        function hideNotificationError() {
            $j(".kantar-email-notification-error-msg").hide();
            $j(".kantar-email-notification-error-msg").html("");
        }
        function resetNotificationForm() {
            $j("#messageBodyDiv").html("");
            $j("#email-notification-form")[0].reset();
            $j("#email-notification-form .jive-error-message").hide();
            $j("#email-notification-form .jive-error-message").hide();
            $j("#email-notification-form .kantar-email-notification-error-msg").hide();

        }

        function notifyQuery() {
            var recipients = $j("#recipients").val();
            hideNotificationError();

            if(recipients) {
                InviteUserUtil.validateEmailRegex(recipients, {
                    callback: function(result) {
                        if(result != "") {
                            $j("#recipients").next().show();
                            $j("#recipients").next().text(result);
                            $j("#recipients").focus();
                            hideLoader();
                            return;
                        } else {
                            $j("#recipients").next().hide();
                        }
                        if($j.trim($j("#subject").val())=='') {
                            $j("#subject").next().show();
                            hideLoader();
                            return;
                        } else {
                            $j("#subject").next().hide();
                        }
                        var messageBody = $j("#messageBodyDiv").html();
                        if($j.trim(messageBody)=='') {
                            $j("#messageBody").next().show();
                            hideLoader();
                            return;
                        } else {
                            $j("#messageBody").next().hide();
                        }
                        $j("#messageBody").val(messageBody);
                        $j("#email-notification-form").submit();
                    },
                    async: true
                });

            } else {
                $j("#recipients").next().show();
                return;
            }
        }


    </script>
    <form id="email-notification-form" action="<@s.url value="/grail/email-queries!sendNotification.jspa"/>" method="post" enctype="multipart/form-data" class="j-form-popup">
        <a href="javascript:void(0);" class="close" onclick="closeEmailNotification();"></a>
        <div id="email-notification-error-msg" class="kantar-email-notification-error-msg" style="display: none;"></div>
        To <input type="text" id="recipients" name="recipients" value="" />
        <span class="jive-error-message" style="display:none" id="inviteEmail_error"><@s.text name="invite.email.error"/></span>
        Subject <input type="text" id="subject" name="subject" value="" />
        <span class="jive-error-message" style="display:none" id="inviteSubject_error"><@s.text name="invite.subject.error"/></span>
        Body
        <div id="messageBodyDiv" name="messageBodyDiv" contenteditable></div>
        <textarea id="messageBody" name="messageBody" style="display:none;"></textarea>
    <#if portalType == 'kantar'>
        <input type="hidden" name="type" value="${statics['com.grail.GrailGlobals$GrailEmailQueriesType'].KANTAR_BUTTON.getId()}">
    <#elseif portalType == 'kantar_report'>
        <input type="hidden" name="type" value="${statics['com.grail.GrailGlobals$GrailEmailQueriesType'].KANTAR_REPORT_BUTTON.getId()}">
    </#if>

        <span class="jive-error-message" style="display:none" id="inviteMessageBody_error"><@s.text name="invite.body.error"/></span>

        <input type="file" name="mailAttachment" id="mailAttachment" multiple />
        <input class="j-btn-callout" type="button" name="doPost" id="postButton" onclick="return notifyQuery();" value="Submit" style="font-weight: bold;" />


    </form>
</div>

</body>



</html>
