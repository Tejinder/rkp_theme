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
<script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>
<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>

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
<script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>
    
<!-- DWR token code written for Synchro jive 8 calls-->
<#assign jive_token = jiveContext.getSpringBean("jiveXHRTokenValidator").generateXHRtoken(user) />		

<script>
	location.href = "/new-synchro/home.jspa";
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


<#include "/template/decorator/synchro/header-custom.ftl" />
<#include "/template/decorator/synchro/header-javascript-jquery.ftl" />

<link rel="stylesheet" href="<@s.url value='${themePath}/js/tinymce_4.1.2/skins/lightgray/skin.min.css'/>" type="text/css" />

<link rel="stylesheet" href="<@s.url value='${themePath}/js/tinymce_4.1.2/skins/lightgray/content.min.css'/>" type="text/css" />
<#include "/template/decorator/default/synchro-header-javascript-rte.ftl" />

<!-- Include the default CSS -->


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

    <#--jQuery(function(){-->
    <#--if(bVer.indexOf('MSIE') != -1) {-->
    <#--browserName = "IE";-->
    <#--var pattern = /MSIE\s?(\d[^;]*)/i;-->
    <#--browserVersion = Number(pattern.exec(bVer)[1]);-->
    <#--if(browserVersion == 8) {-->
    <#--jQuery(jQuery('head')[0]).append('<link rel="stylesheet" href="<@s.url value='${themePath}/style/ie8.css'/>" type="text/css" media="all" />');-->
    <#--}-->
    <#--}-->
    <#--});-->

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


<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>

<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/jquery/jquery.cookie.js'/>"></script>

<link rel="stylesheet" href="${themePath}/style/jmenu.css" type="text/css" />
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/jquery/jquery.freezeheader.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jMenu.jquery.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/jquery.elastic.source.js'/>"></script>

<script language="JavaScript" type="text/javascript" src="<@s.url value='/dwr/interface/ProjectStageNavigatorHelperService.js'/>"></script>
<link rel="stylesheet" href="${themePath}/style/project-navigator.css" type="text/css" />
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/project-stage-navigator.js'/>"></script>
<!--
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ui.dialog.js'/>"></script>-->
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/dropdown.custom.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/prototype.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/light-box.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/ajax-multi-part-form.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/ajax-multi-part-import-form.js'/>"></script>
<#--<script language="JavaScript" type="text/javascript" src="<@s.url value='/dwr/interface/AutoSaveService.js'/>"></script>-->
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/auto-save.js?version=1'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/field-attachment-popup.js'/>"></script>
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
$j(document).ready(function(){
    var synchroPaddingTop = null;
    $j(".border-container").hide();
    $j(".border-container").css("min-height", DYNAMIC_HEIGHT_LOADER.getMainContainerHeight()-92);
    $j(".border-container").show();
    AUTO_SAVE.setDelayTime(${JiveGlobals.getJiveIntProperty("synchro.autosave.delay.time", 300000)?c})
    AUTO_SAVE.setAutoSaveEnable(${JiveGlobals.getJiveBooleanProperty("synchro.autosave.enable", true)?string});

    $j(".print-btn input").bind("click",function(){
        //Configure Print layouts
        $j("html, body").scrollTop($j(document).height());
        $j(".print-btn").hide();
        var errorMessageList = hidePanels();
        var selectConfiguredList = configureMultiselectList();
        var selectConfiguredListSingle = configureSingleSelectList();
        var textFieldsList = configureTextFields();
        var textBoxList = convertTextBoxes();
        configureLegalBox();

        //Print Command


        //Reset Print layouts
        setTimeout(function(){
            window.print();
            showPanels(errorMessageList);
            resetMultiselectList(selectConfiguredList);
            resetSingleSelectList(selectConfiguredListSingle);
            resetTextFields(textFieldsList);
            resetTextBoxes(textBoxList);
            resetLegalBox();
            $j(".print-btn").show();
            $j("html, body").scrollTop(0);
        }, 800);

    });

    function convertTextBoxes()
    {
        var textBoxList = [];
        var textBoxListCounter = 0;

        if(tinymce)
        {
            for(i=0; i<tinymce.editors.length; i++){
                var content = tinymce.editors[i].getContent();
                var editorNAME = tinymce.editors[i].id;
                var parentDIV = $j("textarea[name="+editorNAME+"]").parent();
                var customTextBoxDiv = "<div class='pdf-textarea-div' style='float:right;width:98.6%;border: 1px solid #e5e5e5;margin: 10px 0 20px 0px;padding: 9px 9px 9px 5px;border-radius:3px;font-family:monospace;' id='"+editorNAME+"-displayDiv' name='"+editorNAME+"-displayDiv'></div>";
                parentDIV.append(customTextBoxDiv);
                var divid = editorNAME+"-displayDiv";
                $j("div#"+divid).html(content);
                removeDefaultListFormatting(divid);
                if($j("#"+editorNAME).length > 0 && $j("#"+editorNAME).prev().hasClass('mce-container'))
                {
                    $j("#"+editorNAME).prev().hide();
                }
                textBoxList[textBoxListCounter++] = editorNAME;
            }
        }

        return textBoxList;
    }

    function removeDefaultListFormatting(divid)
    {
        var content = $j("div#"+divid).html();
        if(content)
        {
            $j("div#" + divid + " li").css("list-style","inherit");
            $j("div#" + divid + " ol").css("margin-left","35px");
            $j("div#" + divid + " ul").css("margin-left","35px");
        }
    }

    function resetTextBoxes(textBoxList)
    {
        if(textBoxList && textBoxList!=undefined)
        {
            for(var i=0; i<textBoxList.length; i++)
            {
                if($j("#"+textBoxList[i]).length > 0 && $j("#"+textBoxList[i]).prev().hasClass('mce-container'))
                {
                    $j("#"+textBoxList[i]).prev().show();
                }
                $j("#"+textBoxList[i]+"-displayDiv").remove();
            }
        }
    }


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
        $j(".right-sidebar-list").css('display','none');
        $j(".required-actions").css('visibility','hidden');
        $j(".sidebar-approve-dates").css('visibility','hidden');
        $j(".j-form-datepicker-btn").css('visibility','hidden');
        $j(".jive-chooser-browse").hide();
        $j(".induction_text").hide();

        //Attachments
        $j(".field-attachments").hide();
        $j(".jive-icon-attachment").hide();
        $j(".jive-attachments").hide();

        $j(".save").hide();
        $j(".character-limit").hide();
        $j(".pib-multi-country").hide();
        $j(".stage-navigator").hide();
        $j("#j-header-wrap").hide();
        $j("#j-footer").hide();
        //Check endmarket tabs are there
        if($j(".endmarket-menus").length>0)
        {
            $j(".endmarket-menus ul.main-sub-menus li a").each(function(i) {
                if(!$j(this).hasClass("active"))
                {
                    $j(this).parent().css('visibility','hidden');
                }
            });
        }

        //Handle error messages
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

        /*Hide Action buttons*/
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
        $j(".right-sidebar-list").css('display','block');
        $j(".required-actions").css('visibility','visible');
        $j(".sidebar-approve-dates").css('visibility','visible');
        $j(".j-form-datepicker-btn").css('visibility','visible');
        $j(".jive-chooser-browse").show();
        $j(".induction_text").show();

        //Attachments
        $j(".field-attachments").show();
        $j(".jive-icon-attachment").show();
        $j(".jive-attachments").show();

        $j(".save").show();
        $j(".character-limit").show();
        $j(".pib-multi-country").css("display","block");
        $j(".stage-navigator").show();
        $j("#j-header-wrap").show();
        $j("#j-footer").show();


        //Check endmarket tabs are there
        if($j(".endmarket-menus").length>0)
        {
            $j(".endmarket-menus ul.main-sub-menus li a").each(function(i) {
                if(!$j(this).hasClass("active"))
                {
                    $j(this).parent().css('visibility','visible');
                }
            });
        }

        //Show error messages
        if(errorMessageList && errorMessageList!=undefined)
        {
            for ( var i=0; i<errorMessageList.length; i = i+1 ) {
                $j("#"+errorMessageList[i]).show();
            }
        }


        /*Show Action buttons*/
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
                        var selectList = "<ul id='"+selectid+"-displaylist' style='list-style-type:none; margin-top:10px; float:left; width:182px; border:1px solid#e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control; margin-bottom:15px;'>";
                    }
                    else
                    {
                        var selectList = "<ul id='"+selectid+"-displaylist' style='list-style-type:none; float:left; width:182px; border:1px solid#e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control;'>";
                    }

                    if((selectedCategoryList && typeof selectedCategoryList !== 'undefined') && selectid=="categoryType")
                    {
                        selectsize = 0;
                        $j.each(selectedCategoryList, function( index, value ) {
                            selectsize = selectsize + 1;
                        });


                        for(var i=0; i<selectsize; i++)
                        {

                            if(selectsize==1 && optionCounter==1)
                            {
                                selectList = selectList + "<li style='padding-left:7px;padding-top:6px;padding-bottom:6px'>"+selectedCategoryList[i]+"</li>";
                            }
                            else if(optionCounter==1)
                            {
                                selectList = selectList + "<li style='padding-left:7px;padding-top:6px;'>"+selectedCategoryList[i]+"</li>";
                            }
                            else if(optionCounter==selectsize)
                            {
                                selectList = selectList + "<li style='padding-left:7px;padding-bottom:6px;'>"+selectedCategoryList[i]+"</li>";
                            }
                            else
                            {
                                selectList = selectList + "<li style='padding-left:7px;'>"+selectedCategoryList[i]+"</li>";
                            }
                            optionCounter++;
                        }
                    }
                    else if(selectid=="proposedMethodology" && selectedProposedMethList !== undefined)
                    {

                        selectsize = 0;
                        $j.each(selectedProposedMethList, function( index, value ) {
                            selectsize = selectsize + 1;
                        });

                        for(var i=0; i<selectsize; i++)
                        {
                            if(selectsize==1 && optionCounter==1)
                            {
                                selectList = selectList + "<li style='padding-left:7px;padding-top:6px;padding-bottom:6px'>"+selectedProposedMethList[i]+"</li>";
                            }
                            else if(optionCounter==1)
                            {
                                selectList = selectList + "<li style='padding-left:7px;padding-top:6px;'>"+selectedProposedMethList[i]+"</li>";
                            }
                            else if(optionCounter==selectsize)
                            {
                                selectList = selectList + "<li style='padding-left:7px;padding-bottom:6px;'>"+selectedProposedMethList[i]+"</li>";
                            }
                            else
                            {
                                selectList = selectList + "<li style='padding-left:7px;'>"+selectedProposedMethList[i]+"</li>";
                            }
                            optionCounter++;
                        }
                    }
                    else
                    {
                        $j("#"+selectid+" option").each(function()
                        {
                            if(selectsize==1 && optionCounter==1)
                            {
                                selectList = selectList + "<li style='padding-left:7px;padding-top:6px;padding-bottom:6px'>"+$j(this).text()+"</li>";
                            }
                            else if(optionCounter==1)
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

                        if(optionCounter==1)
                        {
                            selectList = selectList + "<li style='padding-left:7px;padding-top:6px;padding-bottom:6px;'>Not Applicable</li>";
                        }
                    }

                    selectList = selectList + "</ul>";

                    if(selectname=="availableDataCollection")
                    {

                        //Do nothing
                    }
                    /*else if(selectname.indexOf('dataCollectionMethod')!=-1)
                         {
                             $select.parent().parent().children(":first").append(selectList);
                         }*/
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

    function configureSingleSelectList()
    {
        var selectConfiguredList = [];
        var selectConfiguredListCounter = 0;
        $j("select").each(function(i) {
            //$j(this).attr("multiple") || $j(this).attr("size")>1
            if($j(this).is(":visible") && !$j(this).attr("multiple") && $j(this).attr("size")<=1)
            {
                var $select = $j(this);
                var selectid = $j(this).attr("id");
                var selectname = $j(this).attr("name");
                if(selectid && selectid!="")
                {
                    if($j(this).hasClass('form-select'))
                    {
                        var selectWidth = 180;
                    }
                    else if($j(this).hasClass('select_field'))
                    {
                        $j(this).prev().css('float','left');
                        var selectWidth = 80;
                    }

                    if($j(this).parent().parent().hasClass('pib_left'))
                    {
                        var selectList = "<ul id='"+selectid+"-displaylist' style='margin: 6px 0 6px 0;list-style-type:none; width:"+selectWidth+"px; float:left;border:1px solid#e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control;'>";
                    }
                    else if($j(this).parent().parent().hasClass('pib_right'))
                    {
                        if($j(this).hasClass('select_field'))
                        {
                            var selectList = "<ul id='"+selectid+"-displaylist' style='list-style-type:none;margin-left:10px;width:"+selectWidth+"px; float:left;border:1px solid#e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control;'>";
                        }
                        else
                        {
                            var selectList = "<ul id='"+selectid+"-displaylist' style='list-style-type:none; width:"+selectWidth+"px; float:left;border:1px solid#e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control;'>";
                        }

                    }
                    else
                    {

                        if($j(this).hasClass('select_field'))
                        {
                            var selectList = "<ul id='"+selectid+"-displaylist' style='list-style-type:none;margin-left:10px; width:"+selectWidth+"px; float:left;border:1px solid#e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control;'>";
                        }
                        else
                        {
                            var selectList = "<ul id='"+selectid+"-displaylist' style='list-style-type:none; width:"+selectWidth+"px; float:left;border:1px solid#e5e5e5; color:#545454; border-bottom: 2px solid #e5e5e5; font:-webkit-small-control;'>";
                        }

                    }


                    selectList = selectList + "<li style='padding-left:7px;padding-top:6px;padding-bottom:6px;'>"+$j(this).find('option:selected').text()+"</li>";

                    selectList = selectList + "</ul>";
                    $select.parent().append(selectList);

                    $select.hide();
                    selectConfiguredList[selectConfiguredListCounter++] = selectid;
                }
            }
        });

        return selectConfiguredList;
    }

    function configureTextFields()
    {
        var textConfiguredList = [];
        var textConfiguredListCounter = 0;
        $j("input[name^=proposedFWAgencyNames]").each(function(i) {
            if($j(this).is(":visible"))
            {
                var $input = $j(this);
                var $inputid = $j(this).attr("id");
                var $inputname = $j(this).attr("name");
                var customTextField = "<textarea id='"+$inputname+"-displayList' name='"+$inputname+"-displayList'>"+$j(this).val()+"</textarea>";
                $input.parent().append(customTextField);
                $input.hide();
                textConfiguredList[textConfiguredListCounter++] = $inputname;
                autoAdjustTextAreaHeight($inputname + "-displayList");
            }
        });

        return textConfiguredList;
    }

    function autoAdjustTextAreaHeight(textareaid)
    {
        var $textarea = $j("#"+textareaid);
        var textareafld = document.getElementById(textareaid);
        var textHeight = $textarea[0].scrollHeight;
        var textboxHeight = $textarea.height();

        if (textareafld.clientHeight < textareafld.scrollHeight) {
            $textarea.height( $textarea[0].scrollHeight-10);
        }
        else
        {
            $textarea.height(0);
            var scrollval = $textarea[0].scrollHeight-10;
            $textarea.height(scrollval);
        }

        $textarea.elastic();
    }

    function resetTextFields(textConfiguredList)
    {
        if(textConfiguredList && textConfiguredList!=undefined)
        {
            for(var i=0; i<textConfiguredList.length; i=i+1 ) {
                $j("input[name="+textConfiguredList[i]+"]").show();
                $j("#"+textConfiguredList[i]+"-displayList").remove();
            }
        }
    }

    function resetMultiselectList(selectConfiguredList)
    {
        if(selectConfiguredList && selectConfiguredList!=undefined)
        {
            for(var i=0; i<selectConfiguredList.length; i=i+1 ) {
                $j("#"+selectConfiguredList[i]).show();
                $j("#"+selectConfiguredList[i]+"-displaylist").remove();
            }
        }
    }

    function resetSingleSelectList(selectConfiguredList)
    {
        if(selectConfiguredList && selectConfiguredList!=undefined)
        {
            for(var i=0; i<selectConfiguredList.length; i=i+1 ) {
                $j("#"+selectConfiguredList[i]).show();
                $j("#"+selectConfiguredList[i]+"-displaylist").remove();
            }
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
    <div id="j-header-wrap">
    <#include "/template/decorator/default/license-banner.ftl" />
        <header id="j-header"  <#if synchroURL?contains("/oracledocuments/")>class="oracle-documents"</#if>>
        <#include "/template/decorator/synchro/page-header.ftl" />


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
                    <li class="header-nav-home"><a href="<@s.url value="/portal-options.jspa"/>"></a></li>
                    <#if !((synchroURL?contains("edit-profile") && request.getParameter("from")?? && request.getParameter("from") == 'selective_screen')
                    || (synchroURL?contains("change-password") && request.getParameter("from")?? && request.getParameter("from") == 'selective_screen')
                    || (synchroURL?contains("/profile.jspa") && request.getParameter("from")?? && request.getParameter("from") == 'selective_screen')
                    || (synchroURL?contains("/people/") && request.getParameter("from")?? && request.getParameter("from") == 'selective_screen')
                    || synchroURL?contains("/synchro/reminder") || synchroURL?contains("/synchro/project-reminders")
                    || synchroURL?contains("/synchro/general-reminders") || synchroURL?contains("/synchro/project-reminder-view-result") || synchroURL?contains("/oracledocuments/"))>
                        <li class="my-dashboard-menu">
                            <a href="javascript:void(0)" class="parent-menu">My Dashboard</a>
                            <ul style="display: none;">
                                <li><a href="<@s.url value="/synchro/dashboard.jspa"/>">My Projects</a></li>
                                <li><a href="<@s.url value="/synchro/pending-activities.jspa"/>">My Pending Activities</a></li>
                                <li><a href="<@s.url value="/synchro/waiver-catalogue.jspa"/>">My Waivers</a></li>
                                <li><a class="delegate-menu" href="<@s.url value="/synchro/delegate-add-stakeholders.jspa"/>">Change Key Contacts and Owners</a></li>
                                <li><a class="delegate-menu" href="<@s.url value="/synchro/current-status-dashboard.jspa"/>">View Project Status</a></li>
                            <#--<li class="last"><a href="<@s.url value="/synchro/history.jspa"/>">My History</a></li>-->
                            </ul>
                        </li>
                        <li class="initiate-project-menu">
                            <a href="javascript:void(0)">Initiate Project</a>
                            <ul style="display: none;">
                                <li><a href="<@s.url value='/synchro/create-project!input.jspa'/>">Single Market Project</a></li>
                                <li><a href="<@s.url value='/synchro/create-multimarket-project!input.jspa'/>">Multi-Market Project</a></li>
                            </ul>
                        </li>
                        <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
                    <#--<#if action.getAuthenticationProvider().isSystemAdmin()>-->
                    <#--<li><a href="<@s.url value="/synchro/raw-extract.jspa"/>">Generate Reports</a></li>-->
                    <#--</#if>-->
                    <#--<#if (synchroPermHelper.hasGenerateReportAccess(user))>-->
                    <#--<li>-->
                    <#--<a href="<@s.url value="/synchro/raw-extract.jspa"/>">Generate Reports</a>-->
                    <#--</li>-->
                    <#--</#if>-->
                        
                        <#-- Enable the Generate Reports section only for the Super Admin user -->
                		<#if synchroPermHelper.isSynchroAdmin(user) >
	                        <#if (synchroPermHelper.isSynchroMiniAdmin(user) || synchroPermHelper.isSynchroAdmin(user)
	                        || synchroPermHelper.isSynchroGlobalSuperUser(user) || synchroPermHelper.isSynchroRegionalSuperUser(user)
	                        || synchroPermHelper.isSynchroEndmarketSuperUser(user))
	                        && !(synchroPermHelper.isExternalAgencyUser(user) || synchroPermHelper.isCommunicationAgencyUser(user))>
	                            <li>
	                                <#if (synchroPermHelper.isSynchroMiniAdmin(user) || synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isSynchroGlobalSuperUser(user))>
	                                    <a href="<@s.url value="/synchro/raw-extract.jspa"/>">Generate Reports</a>
	                                <#else>
	                                    <a href="<@s.url value="/synchro/spend-reports.jspa"/>">Generate Reports</a>
	                                </#if>
	                            </li>
	                        </#if>
	                    </#if>
	                    
                        <li class="last"><a href="<@s.url value="/synchro/my-library.jspa"/>">My Library</a></li>
                        <#--<li class="last"><a href="<@s.url value="/synchro/oracle-manuals!input.jspa"/>">Oracle Documents</a></li>-->

                        <li class="header-nav-help"><a href="<@s.url value="/synchro/help.jspa"/>"></a></li>
                    </#if>


                </ul>
            </div>
        <#elseif  synchroURL?contains("/synchro/project-waiver")>
            <div class="header-nav">
                <script type="text/javascript">
                    function goBack() {
                        if(window.history && window.history.length > 0) {
                            window.history.back();
                        } else {
                            window.location.href = "<@s.url value="/synchro/home"/>";
                        }

                    }
                </script>
                <div class="help-goback">
                    <a href="javascript:void(0)" onclick="goBack()">Go Back</a>
                </div>
            </div>
        </#if>

        </header>
    </div>
    <!-- breadcrumbs Text -->
<#--<div class="synchro-banner">-->
<#--<img src="/themes/rkp_theme/images/synchro_banner.jpeg">-->
<#--</div>-->
    <section id="j-main" class="clearfix">


    <#--<div id="${bodyID!('jive-body')}" class="clearfix">-->
    <#--<#if legacyBreadcrumb>-->
    <#--<#include "/template/decorator/default/page-breadcrumb.ftl" />-->
    <#--</#if>-->
        <!-- Page container -->
        <div id="main-container" class="container">
        ${page.body}
        </div>
    <#--</div>-->

    </section>
<#include "/template/decorator/default/page-tooltips.ftl" />
<#include "/template/decorator/default/post-footer.ftl" />

</div>

<footer id="j-footer">
<#assign license = jiveContext.getLicenseManager().getJiveLicense()/>
<#--<#if !page.getProperty("meta.nofooter")??>-->
<#--<@soy.render template="jive.nav.footer" data=skin.template.instanceInfoView />-->
<#--</#if>-->
    <!-- footer -->
    <div class="footer_main">
    <#--<div class="footer">Synchro powered by Jive SBS @ ${license.version.versionString} Community Software</div>-->
        <div class="footer-left"><h4>British American Tobacco</h4></div>
        <div class="footer-right">
            <ul>
            <#--<li class="footer-info"><a href="#"></a></li>-->
                <li><a href="<@s.url value="/synchro/help.jspa"/>">Support</a></li>
                <li><a href="<@s.url value="/disclaimer.jspa"/>">Terms & Conditions</a></li>
            </ul>
        </div>
    </div>

</footer>
<script type="text/javascript">
    /*Footer CSS code*/
    var docH;
    /*$j(document).ready(function() {
        docH = $j(document).height();
        $('body').css({height: docH});
    });
    $j(window).resize(function() {
        $j('body').css({height: docH});
    });*/
    /*Footer CSS code*/


    <#if initiatePage?? && initiatePage >
    $j("#anchor_home_link").click(function(event) {
        event.preventDefault();
        var props = {buttons: {"Yes": submitFormDialog, "No": function() {window.location.href="/synchro/home";}}};
        dialog(props);
        $j("#dialog-box").html('Do you want to save the details?');
    });
    </#if>

</script>
<div id="dialog-box" title="Alert" style="display:none;min-height:auto;">
    <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span></p>
</div>
<#include "/template/global/synchro-result-filter.ftl" />
<div id="backgroundPopup"></div>

</body>



</html>
