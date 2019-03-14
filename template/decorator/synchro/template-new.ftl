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
<script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}"></script>
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


<#include "/template/decorator/synchro/header-custom.ftl" />
<#include "/template/decorator/synchro/header-javascript-jquery.ftl" />

<link rel="stylesheet" href="<@s.url value='${themePath}/js/tinymce_4.1.2/skins/lightgray/skin.min.css'/>" type="text/css" />

<link rel="stylesheet" href="<@s.url value='${themePath}/js/tinymce_4.1.2/skins/lightgray/content.min.css'/>" type="text/css" />
<#include "/template/decorator/default/synchro-header-javascript-rte.ftl" />

<!-- Include the default CSS -->


${page.head}





<link rel="stylesheet" href="<@s.url value='${themePath}/style/jquery/datepicker.css'/>" type="text/css" media="all" />



<link rel="stylesheet" href="${themePath}/style/synchro-new.css?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/css" media="all" />
<link rel="stylesheet" href="${themePath}/style/synchro-new_modified.css?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/css" media="all" />

	<link rel="stylesheet" href="<@s.url value='${themePath}/style/ie-synchro-new_modified.css'/>" type="text/css"  />


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
<!--
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/project-stage-navigator.js'/>"></script>

<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/ui.dialog.js'/>"></script>-->
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/dropdown.custom.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/prototype.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/light-box.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/ajax-multi-part-form.js'/>"></script>
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/ajax-multi-part-import-form.js'/>"></script>
<#--<script language="JavaScript" type="text/javascript" src="<@s.url value='/dwr/interface/AutoSaveService.js'/>"></script>-->
<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/auto-save.js?version=1'/>"></script>
<#--<script language="JavaScript" type="text/javascript" src="<@s.url value='${themePath}/js/synchro/field-attachment-popup.js'/>"></script>-->
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
			mceHeightSet()
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
        <#include "/template/decorator/synchro/page-header-new.ftl" />


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
                    <li class="header-nav-home"><a  title="Home" href="<@s.url value="/portal-options.jspa"/>"></a></li>
                    <#if !((synchroURL?contains("edit-profile") && request.getParameter("from")?? && request.getParameter("from") == 'selective_screen')
                    || (synchroURL?contains("change-password") && request.getParameter("from")?? && request.getParameter("from") == 'selective_screen')
                    || (synchroURL?contains("/profile.jspa") && request.getParameter("from")?? && request.getParameter("from") == 'selective_screen')
                    || (synchroURL?contains("/people/") && request.getParameter("from")?? && request.getParameter("from") == 'selective_screen')
                    || synchroURL?contains("/synchro/reminder") || synchroURL?contains("/synchro/project-reminders")
                    || synchroURL?contains("/synchro/general-reminders") || synchroURL?contains("/synchro/project-reminder-view-result") || synchroURL?contains("/oracledocuments/"))>
                        
						<#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>
						<li class="my-dashboard-menu">
                           <#-- <#if synchroPermHelper.isSynchroSystemOwner() && !synchroPermHelper.isSynchroAdmin(user)>
								<a href="javascript:void(0)" class="parent-menu">Manage</a>
								<ul style="display: none;">
									<#assign manageProjectURL = "" />
									<#if synchroPermHelper.isGlobalUserType() || synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isSynchroSystemOwner()>
										<#assign manageProjectURL = "/new-synchro/global-dashboard-open.jspa" />
									<#elseif synchroPermHelper.isRegionalUserType()>
										<#assign manageProjectURL = "/new-synchro/regional-dashboard-open.jspa" />
									<#else>
										<#assign manageProjectURL = "/new-synchro/em-dashboard-open.jspa" />
									</#if>
									<li><a href="${manageProjectURL}">Projects</a></li>
									<li><a href="<@s.url value="/new-synchro/process-waiver-dashboard.jspa"/>">Waivers</a></li>
									<#if synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.canViewTPDSubmission() || synchroPermHelper.isSynchroSystemOwner()>
										<li><a class="delegate-menu" href="/new-synchro/tpd-dashboard.jspa">TPD Submissions</a></li>
									</#if>
								
								</ul>
							<#else>
								<a href="javascript:void(0)" class="parent-menu">Manage</a>
								<ul style="display: none;">
									<#assign manageProjectURL = "" />
									<#if synchroPermHelper.isGlobalUserType() || synchroPermHelper.isSynchroAdmin(user)>
										<#assign manageProjectURL = "/new-synchro/global-dashboard-open.jspa" />
									<#elseif synchroPermHelper.isRegionalUserType()>
										<#assign manageProjectURL = "/new-synchro/regional-dashboard-open.jspa" />
									<#else>
										<#assign manageProjectURL = "/new-synchro/em-dashboard-open.jspa" />
									</#if>
									<li><a href="${manageProjectURL}">Projects</a></li>
									<li><a href="<@s.url value="/new-synchro/process-waiver-dashboard.jspa"/>">Waivers</a></li>
									<#if synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.canViewTPDSubmission()>
										<li><a class="delegate-menu" href="/new-synchro/tpd-dashboard.jspa">TPD Submissions</a></li>
									</#if>
								
								</ul>
							</#if>-->
							
							<a href="javascript:void(0)" class="parent-menu">Projects</a>
							<ul style="display: none;">
								<#if statics['com.grail.synchro.util.SynchroPermHelper'].canInitiateProject_NEW() >
									<#if synchroPermHelper.isSynchroSystemOwner() || synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isGlobalUserType() || synchroPermHelper.isRegionalUserType() >
										<li><a href="javascript:void(0);" onclick="javascript:openProjectCreateWindow()">Initiate</a></li>
									<#else>
										<li><a href="<@s.url value='/new-synchro/create-project!input.jspa'/>">Initiate</a></li>
									</#if>
									
									<#assign manageProjectURL = "" />
									<#if synchroPermHelper.isGlobalUserType() || synchroPermHelper.isSynchroAdmin(user)>
										<#assign manageProjectURL = "/new-synchro/global-dashboard-open.jspa" />
									<#elseif synchroPermHelper.isRegionalUserType()>
										<#assign manageProjectURL = "/new-synchro/regional-dashboard-open.jspa" />
									<#else>
										<#assign manageProjectURL = "/new-synchro/em-dashboard-open.jspa" />
									</#if>
									<li><a href="${manageProjectURL}">Manage</a></li>
								<#else>
									<li><a href="javascript:void(0);" class="disableMenu">Initiate</a></li>
									
									<#assign manageProjectURL = "" />
									<#if synchroPermHelper.isGlobalUserType() || synchroPermHelper.isSynchroAdmin(user)>
										<#assign manageProjectURL = "/new-synchro/global-dashboard-open.jspa" />
									<#elseif synchroPermHelper.isRegionalUserType()>
										<#assign manageProjectURL = "/new-synchro/regional-dashboard-open.jspa" />
									<#else>
										<#assign manageProjectURL = "/new-synchro/em-dashboard-open.jspa" />
									</#if>
									<li><a href="${manageProjectURL}">View</a></li>
								</#if>		
							</ul>
							
                        </li>
						
                        <li class="initiate-project-menu">
							
							<#--
							<#if synchroPermHelper.isSynchroSystemOwner() || synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isEndMarketUserType() || synchroPermHelper.isGlobalUserType() || synchroPermHelper.isRegionalUserType() >
							   <a href="javascript:void(0)">Initiate</a>
								<ul style="display: none;">
									<#if synchroPermHelper.isSynchroSystemOwner() || synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isGlobalUserType() || synchroPermHelper.isRegionalUserType() >
										<li><a href="javascript:void(0);" onclick="javascript:openProjectCreateWindow()">Project</a></li>
									<#else>
										<li><a href="<@s.url value='/new-synchro/create-project!input.jspa'/>">Project</a></li>
									</#if>
									<#if synchroPermHelper.isSynchroSystemOwner() || synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isEndMarketUserType() || synchroPermHelper.isGlobalUserType() || synchroPermHelper.isRegionalUserType() >
										<li><a href="<@s.url value='/new-synchro/create-waiver!input.jspa'/>">Waiver</a></li>
									</#if>
								</ul>
							</#if>	-->
							
							<a href="javascript:void(0)">Waivers</a>
							<ul style="display: none;">
								<#if statics['com.grail.synchro.util.SynchroPermHelper'].canInitiateWaiver_NEW() >
									<#if statics['com.grail.synchro.util.SynchroPermHelper'].canInitiateProject_NEW() >
										<li><a href="<@s.url value='/new-synchro/create-waiver!input.jspa'/>">Initiate Business Waiver</a></li>
									<#else>
										<li><a href="javascript:void(0);" class="disableMenu">Initiate Business Waiver</a></li>
									</#if>
									<#if statics['com.grail.synchro.util.SynchroPermHelper'].canInitiateProject_NEW() >
										<li><a href="<@s.url value="/new-synchro/process-waiver-dashboard.jspa"/>">Manage all Waivers</a></li>
									<#else>
										<li><a href="<@s.url value="/new-synchro/process-waiver-dashboard.jspa"/>">View all Waivers</a></li>
									</#if>	
								<#else>
								    <#if synchroPermHelper.isGlobalUserType()>
										<li><a href="javascript:void(0);" class="disableMenu">Initiate Business Waiver</a></li>
										<#--<li><a href="<@s.url value="/new-synchro/process-waiver-dashboard.jspa"/>">Manage all Waivers</a></li> -->
										<li><a href="<@s.url value="/new-synchro/methodology-waiver-dashboard.jspa"/>">Manage all Waivers</a></li>
										
									<#elseif synchroPermHelper.isRegionalUserType()>
										<li><a href="javascript:void(0);" class="disableMenu">Initiate Business Waiver</a></li>
										<#--<li><a href="<@s.url value="/new-synchro/process-waiver-dashboard.jspa"/>">Manage all Waivers</a></li> -->
										<li><a href="<@s.url value="/new-synchro/methodology-waiver-dashboard.jspa"/>">Manage all Waivers</a></li>
									<#else>
										<li><a href="javascript:void(0);" class="disableMenu">Initiate Business Waiver</a></li>
										<li><a href="<@s.url value="/new-synchro/process-waiver-dashboard.jspa"/>">View all Waivers</a></li>
									
									</#if>
									
								</#if>
								
							</ul>
                        </li>
                        
                  
                        
						<li class="initiate-project-menu">
							<#--<a href="javascript:void(0)">Generate Reports</a>
							<ul style="display: none;">
								<#if synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isSynchroSystemOwner()>
									<li><a href="/new-synchro/qpr-snapshot!input.jspa" >QPR Snapshot</a></li>
								</#if>
								<li><a href="/new-synchro/downloadRawExtract.jspa" >Raw Extract</a></li>
								<li><a href="/new-synchro/spend-reports.jspa" >Spend Reports</a></li>
								<li><a href="javascript:void(0);" onclick="showAgencyEvaluationReportFilter();">Agency Evaluation Reports</a></li>
							</ul>	-->
							
							<a href="javascript:void(0)">Reports</a>
							<ul style="display: none;">
								<#if synchroPermHelper.isSynchroAdmin(user) || synchroPermHelper.isSynchroSystemOwner()>
									<li><a href="/new-synchro/qpr-snapshot!input.jspa" >QPR Snapshot</a></li>
								</#if>
								<!--<li><a href="/new-synchro/downloadRawExtract.jspa" >All Projects Report</a></li> -->
								
								<li><a href="javascript:void(0);" onclick="showAllProjectsReport();">All Projects Report</a></li>
								<li><a href="/new-synchro/spend-reports.jspa" >Spend Report</a></li> 
								<li><a href="javascript:void(0);" onclick="showAgencyEvaluationReportFilter();">Agency Evaluation Report</a></li>
							</ul>
						</li>
						
						
	                    
                     
                      <#--  <#if synchroPermHelper.isLegaUserType() ||  synchroPermHelper.isSynchroAdmin(user)>
							<li class="last"><div class="notification-alert"><img id="notificationAlert" src="/themes/rkp_theme/images/synchro/notification-icon.png"><span class="notification-text">${statics['com.grail.synchro.util.SynchroReminderUtils'].getPendingActivitiesCount()}</span></div><a href="<@s.url value="/new-synchro/pending-activities.jspa"/>">Pending Activities</a></li>
						<#elseif synchroPermHelper.isSynchroSystemOwner()>	
							<li class="last"><div class="notification-alert"><img id="notificationAlert" src="/themes/rkp_theme/images/synchro/notification-icon.png"><span class="notification-text">${statics['com.grail.synchro.util.SynchroReminderUtils'].getPendingActivitiesCount()}</span></div><a href="<@s.url value="/new-synchro/process-waiver-pending-activities.jspa"/>">Pending Activities</a></li>
						</#if>

                        <li class="header-nav-help"><a  title="Support" href="<@s.url value="/new-synchro/help.jspa"/>"></a></li> -->
						
						
						<#if  synchroPermHelper.canEditTPDSummary() || synchroPermHelper.canViewTPDSubmission()>
						
						<li class="last"> <a href="javascript:void(0)">TPD</a> 
							<ul style="display: none;">
								<#if  synchroPermHelper.canEditTPDSummary()>
									<li><a href="/new-synchro/tpd-dashboard.jspa" >Manage TPD Submission</a></li>
								<#elseif  synchroPermHelper.canViewTPDSubmission()>
									<li><a href="/new-synchro/tpd-dashboard.jspa" >View TPD Submission</a></li>
								</#if>
								
							
							</ul>
						</li>
						
						<#else>
						  
						<li class="last"> <a href="javascript:void(0)"  class="disableMenu">TPD</a> </li>

						
						</#if>
						
						
						<#if synchroPermHelper.isLegaUserType() ||  synchroPermHelper.isSynchroAdmin(user)>
							<li class="last"><div class="notification-alert"><img id="notificationAlert" src="/themes/rkp_theme/images/synchro/notification-icon.png"><span class="notification-text">${statics['com.grail.synchro.util.SynchroReminderUtils'].getPendingActivitiesCount()}</span></div><a href="<@s.url value="/new-synchro/pending-activities.jspa"/>">Pending Approvals</a></li>
						<#elseif synchroPermHelper.isSynchroSystemOwner()>	
							<li class="last"><div class="notification-alert"><img id="notificationAlert" src="/themes/rkp_theme/images/synchro/notification-icon.png"><span class="notification-text">${statics['com.grail.synchro.util.SynchroReminderUtils'].getPendingActivitiesCount()}</span></div><a href="<@s.url value="/new-synchro/process-waiver-pending-activities.jspa"/>">Pending Approvals</a></li>
						</#if>
                    </#if>


                </ul>
            </div>
        <#elseif  synchroURL?contains("/new-synchro/project-waiver")>
            <div class="header-nav">
                <script type="text/javascript">
                    function goBack() {
                        if(window.history && window.history.length > 0) {
                            window.history.back();
                        } else {
                            window.location.href = "<@s.url value="/new-synchro/home.jspa"/>";
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
		<div class="header-top-page-wrapper"></div>
	<#--	<div class="new-page-wrapper">
			<div class="new-page-nav">
			<hr></hr>
			<ul>
		
			<li><div class="nav-select">1</div><span>in planning</span></li>
			<li><div class="nav-select">2</div><span>in progress</span></li>
			<li><div class="nav-select">3</div><span>complete</span></li>
			<li class="disable"><div class="nav-select">4</div><span>close</span></li>
			</ul>
			</div>
		</div>
	-->
	
	<div class="new-page-wrapper" id="new-page-wrapper" style="display:none">
			<div class="new-page-nav">
			<hr></hr>
			<ul>
	
	
		  
			<#if project?? && project.status?? && (project.status == 1 || project.status == 2) >
			     <#if project.getFieldWorkStudy()==1>
				<script>
			   
			      $j(".new-page-nav hr").css("width","310px");
			   </script>
			
				<li><div class="nav-select">1</div><span>in planning</span></li>
				<!--<li class="disable"><div class="nav-select">2</div><span>in progress</span></li> -->
				<li class="disable"><div class="nav-select">2</div><span>Awaiting Results</span></li>
				<li class="disable"><div class="nav-select">3</div><span>closed</span></li>
				
				  <#else>
				   <script>
			        $j(".new-page-nav hr").css("width","405px");
			        </script>
					<li><div class="nav-select">1</div><span>in planning</span></li>
				     <li class="disable"><div class="nav-select">2</div><span>in progress</span></li> 
				     <li class="disable"><div class="nav-select">3</div><span>Awaiting Results</span></li>
				     <li class="disable"><div class="nav-select">4</div><span>closed</span></li>
					
				
				</#if>
				
			
			  <#elseif project?? && project.status?? && (project.status == 3)>
				<li><div class="nav-select">1</div><span>in planning</span></li>
				<li><div class="nav-select">2</div><span>in progress</span></li>
				<li class="disable"><div class="nav-select">3</div><span>Awaiting Results</span></li>
				<li class="disable"><div class="nav-select">4</div><span>closed</span></li>
				
				
			<#elseif  project?? && project.status?? && (project.status == 4 || project.status == 5)>
			   <#if project.getFieldWorkStudy()==1>
			   <script>
			   
			      $j(".new-page-nav hr").css("width","310px");
			   </script>
			     <li><div class="nav-select">1</div><span>in planning</span></li>
				 <!--<li><div class="nav-select">2</div><span>in progress</span></li> -->
				 <li><div class="nav-select">2</div><span>Awaiting Results</span></li>
				<li class="disable"><div class="nav-select">3</div><span>closed</span></li>
			   
			   <#else>
			   <script>
			      $j(".new-page-nav hr").css("width","405px");
			   </script>
			     <li><div class="nav-select">1</div><span>in planning</span></li>
				 <li><div class="nav-select">2</div><span>in progress</span></li> 
				 <li><div class="nav-select">3</div><span>Awaiting Results</span></li>
				<li class="disable"><div class="nav-select">4</div><span>closed</span></li>
			   
			    </#if>
			
				
			<#elseif project?? && project.status?? && (project.status == 6)>
			    <#if project.getFieldWorkStudy()==1>
				<script>
			   
			      $j(".new-page-nav hr").css("width","310px");
			   </script>
				<li><div class="nav-select">1</div><span>in planning</span></li>
				<!--<li><div class="nav-select">2</div><span>in progress</span></li> -->
				<li><div class="nav-select">2</div><span>Awaiting Results</span></li>
				<li><div class="nav-select">3</div><span>closed</span></li>
				
				
				  <#else>
				   <script>
			      $j(".new-page-nav hr").css("width","405px");
			   </script>
				      <li><div class="nav-select">1</div><span>in planning</span></li>
				      <li><div class="nav-select">2</div><span>in progress</span></li>
				      <li><div class="nav-select">3</div><span>Awaiting Results</span></li>
				      <li><div class="nav-select">4</div><span>closed</span></li>
				  
				  
				  </#if>
			</#if>
			
			</ul>
			</div>
		</div>
		
	
        <div id="main-container" class="container">
        ${page.body}
        </div>
    <#--</div>-->

    </section>
   <#include "/template/decorator/default/page-tooltips.ftl" />
   <#include "/template/decorator/default/post-footer.ftl" />
   <#include "/template/global/include/synchro-macros.ftl" />

</div>

<div id="project-create-options" style="display:none">
	<i class="icon_remove">Select from the process options below to Initiate a project:</i>
	<br>
	<label><input type='radio' name='endMarketType' id="endMarketNonEUType" value='NONEU'>With no EU end market</label>
	<br>
	<label><input type='radio' name='endMarketType' id="endMarketEUType" value='EU'>With EU end market</label>
	
	<#if synchroPermHelper.isGlobalUserType() || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner()>
		<br>
		<label><input type='radio' name='endMarketType' id="endMarketGLOBALType" value='GLOBAL'>With no end market focus</label>
	<#elseif synchroPermHelper.isRegionalUserType()>
		<br>
		<label><input type='radio' name='endMarketType' id="endMarketGLOBALType" value='GLOBAL'>With no end market focus</label>
	</#if>
	<#if synchroPermHelper.isGlobalUserType()||synchroPermHelper.isRegionalUserType()>
		
		<#else>   <br>
		<label><input type='radio' name='endMarketType' id="endMarketOnly" value='ENDMARKET'>End market project</label>
	</#if>

	<input type="button" value="Initiate" id="downloadReport"  onclick="initiateProject()" />
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
                                    <p>Should you require any further information please contact: <a href="mailto:Taina_Vauhkonen@bat.com">Taina Vauhkonen</a></p>  
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
<#-- Agency Evluation Report Filter Start -->
<div id="agency-Evaluation-Report" class="evaluation_report" style="display:none">


 
<a href="javascript:void(0);" class="close" ></a>
<div class="popup-title-overlay"></div>
<div class="pop-upinner-scroll">

	
		<form id="agency-Evaluation-Report-Form" action="/new-synchro/download-agency-eval-extract!downloadReport.jspa" method="POST" class="result-form-popup ">
			<div class="project_dashboard_header">
				<h3>Agency Evaluation Report </h3>
				<i>Please select the filters you would like to apply</i>
				<i class="warning-text">It is mandatory to select at least one filed</i>
			</div>	
			<label>Project Duration</label>
			<div  class="project_names_dates region-inner">
				<div class="project_start_date">
					<label>Started Between</label>
					<div class="year">
						
					
						<@synchrodatetimepicker id="aeStartDateBegin" name="aeStartDateBegin" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false   dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					<div class="month">
						<label>And</label>
			
							<@synchrodatetimepicker id="aeStartDateComplete" name="aeStartDateComplete" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false  dateCompareFilter=true placeholder='Select Date'/>
			 
						<span class="jive-error-message" style="display:none;"></span>
					</div>
				</div>
				<div class="project_complete_date">
					<label>Completed Between</label>
					<div class="year">
						
						<@synchrodatetimepicker id="aeEndDateBegin" name="aeEndDateBegin" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=true  dateCompareFilter=true placeholder='Select Date' />
						<span class="jive-error-message" style="display:none;"></span>
					</div>
					<div class="month">
						<label>And</label>
						<@synchrodatetimepicker id="aeEndDateComplete" name="aeEndDateComplete" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=true  dateCompareFilter=true placeholder='Select Date'/>
						<span class="jive-error-message" style="display:none;"></span>
					</div>
				</div>
			</div>
			
			<div  class="region-inner">
				<label>Evaluation Done By</label>
				<input type="text" name="evaluationDoneBy" value="" placeholder="Enter Name" onfocus="this.placeholder = '' " onblur="this.placeholder = 'Enter Name' "/>
			</div>
			
			<div class="region-inner">
				<label class="label_b">Agency</label>
				<@renderSelectResearchAgency name='aeResearchAgencies' multiselect=true/>
			</div>
			
			<div class="region-inner">
				<label class="label_b">Cost Component</label>
				<@renderSelectCostComponent name='aeCostComponents' multiselect=true/>
			</div>
			
			<div class="region-inner">
					
				<label class="label_b">Research End-market(s)</label>
				<@renderSelectEndMarkets name='aeResearchEndMarkets' multiselect=true/>
			</div>
			
			<div class="region-inner">
				<label class="label_b">Methodology</label>
				<@renderSelectMethodologyDetails name='aeMethDetails' multiselect=true/>
			</div>
			<div class="region-inner">
				<label class="label_b">Methodology Type</label>
				<@renderMethodologyField name='aeMethodologyTypes' readonly=false multiselect=true/>
			</div>
			<div class="region-inner">
				<label class="label_b">Budget Location</label>
				<@renderSelectBudgetLocationField name='aeBudgetLocations' multiselect=true/>
				
			</div>
			<div class="region-inner">
				<@projectBudgetYearFieldNew name="aeBudgetYears"  multiselect=true/>
			</div>
			
			<div class="filter-btn">
				<input type="button" value="Cancel" onclick="closeAgencyEvaluationReportFilter();" class="cancel-agency-filter" />
				<input type="button" value="Reset" onclick="resetAgencyEvaluationReportFilter();" class="reset-agency-filter" />
				
				<input type="button" value="Download Report" onclick="generateAgencyEvaluationReports();" class="btn-blue" />

				
			</div>
			
			
		</form>
		</div>
		</div>
	
</div>
<#-- Agency Evluation Report Filter End -->





 <#--All reports  download Filter    -->
 
 <div id="all-project-Report" class="popupreport__fix" style="display:none">

 
 

 <i><label class="popup-header-italics">Select the budget year for which you want the report:</label></i>
	<br>
	
	<form  id="allprojects"  action="/new-synchro/downloadRawExtract.jspa" method="POST">
	
	
	<#--<div class="region-inner">
				<@projectBudgetYearFieldNew name="budgetYearData"/>
			<span class="full-width"><span class="jive-error-message" id="budgetYearError" style="display:none">Please select Budget Year</span></span>
			</div>
			-->
			
	
			
	 <div class="budgetDownload__fix ">
	  <@projectBudgetYearFieldNew name="budgetYearData"/>
			<span class="jive-error-message errorMSgspanBuget" id="budgetYearError" style="display:none">Please select Budget Year</span>
		</div>	
			
			
			
	
	 <br>
	 
	       <input type="button" value="Download Report" id="downloadReport"  onclick="downloadAllProjects()" />
   </form>

 
 </div>
 
 
 <#--  End All reports  download Filter   -->


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
				<#if synchroURL?contains("/new-synchro/home.jspa") >
				<#elseif synchroURL?contains("/new-synchro/help.jspa") >
				<#else>
					<li><a  href="<@s.url value="/new-synchro/help.jspa"/>"  target="_blank" >Support</a></li>
				</#if>	
                <li><a href="javascript:void(0);" onclick="javascript:terms_condition()">Terms & Conditions</a></li>
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

	
  function	downloadAllProjects()
	{
		
		if($j("#budgetYearData").val()==-1)
		{
			$j("#budgetYearError").show();
			return false;
			
		}
		else
		{
			$j("#budgetYearError").hide();
			 
			
			 
			var allProjectForm = $j("#allprojects");
			allProjectForm.submit();
			
		}
		
		
		
	}
	$j("#budgetYearData").change(function()
	{
		
	$j("#budgetYearError").hide();	
		
	});

	
	
	

    <#if initiatePage?? && initiatePage >
    $j("#anchor_home_link").click(function(event) {
        event.preventDefault();
        var props = {buttons: {"Yes": submitFormDialog, "No": function() {window.location.href="/new-synchro/home.jspa";}}};
        dialog(props);
        $j("#dialog-box").html('Do you want to save the details?');
    });
    </#if>
	
	function openProjectCreateWindow(){
		
   $j("#project-create-options").dialog({
			modal: true,
			width: 450,
			resizable: false,
        draggable: false
		});
}





function initiateProject()
{
    // check which radio button is selected
	var checkRadioStatus=$j('input[name=endMarketType]:checked').val();
	if(checkRadioStatus=="NONEU")
	{
		location.href="/new-synchro/create-project-global!input.jspa";
	}
	else if(checkRadioStatus=="EU")
	{
		location.href="/new-synchro/create-project!input.jspa?globalProjectType=EU";
	}
	else if(checkRadioStatus=="GLOBAL")
	{
		location.href="/new-synchro/create-project-global!input.jspa?globalProjectType=GLOBAL";
	}
	else if(checkRadioStatus=="ENDMARKET")
	{
		location.href="/new-synchro/create-project!input.jspa";
	}
	else 
	{
		   
	}
	   
}

/*
	$j("#endMarketNonEUType").click(function() {
		
		location.href="/new-synchro/create-project-global!input.jspa";
		
    });   
	$j("#endMarketEUType").click(function() {
		location.href="/new-synchro/create-project!input.jspa?globalProjectType=EU";
    });
	
	$j("#endMarketGLOBALType").click(function() {
		location.href="/new-synchro/create-project-global!input.jspa?globalProjectType=GLOBAL";
    });
	
	$j("#endMarketOnly").click(function() {
		location.href="/new-synchro/create-project!input.jspa";
    }); 
*/
	
		function terms_condition(){
		
   $j("#termsndCondition").dialog({
			modal: true,
			width: 900,
			resizable: false,
        draggable: false
		});
}


  function showAllProjectsReport()
{
	 $j("#all-project-Report").dialog({
			modal: true,
			width: 450,
			resizable: false,
        draggable: false
		});
	
	
}


	function showAgencyEvaluationReportFilter()
	{
		$j("#agency-Evaluation-Report").lightbox_me({centered:true,closeEsc:false,closeClick:false,overlayCSS:{background: 'black', opacity: .7}});
	}
	
	function closeAgencyEvaluationReportFilter()
	{
		$j("#agency-Evaluation-Report").trigger('close');
	}
	function resetAgencyEvaluationReportFilter()
	{
		$j("input[name='aeStartDateBegin']").val("");
		$j("input[name='aeStartDateComplete']").val("");
		$j("input[name='aeEndDateBegin']").val("");
		$j("input[name='aeEndDateComplete']").val("");
		$j("input[name='evaluationDoneBy']").val("");
		$j('select[name="aeResearchAgencies"]').val('').trigger('chosen:updated');
		$j('select[name="aeCostComponents"]').val('').trigger('chosen:updated');
		$j('select[name="aeResearchEndMarkets"]').val('').trigger('chosen:updated');
		$j('select[name="aeMethDetails"]').val('').trigger('chosen:updated');
		$j('select[name="aeMethodologyTypes"]').val('').trigger('chosen:updated');
		$j('select[name="aeBudgetLocations"]').val('').trigger('chosen:updated');
		$j('select[name="aeBudgetYears"]').val('').trigger('chosen:updated');
	}
	
	function generateAgencyEvaluationReports()
	{
		 $j(".warning-text").hide();
			var agencyEvalForm = $j("#agency-Evaluation-Report-Form");
			agencyEvalForm.submit();
/*
		var flag = true;
		var aeStartDateBegin = $j("input[name='aeStartDateBegin']").val();
		var aeStartDateComplete = $j("input[name='aeStartDateComplete']").val();
		var aeEndDateBegin = $j("input[name='aeEndDateBegin']").val();
		var aeEndDateComplete = $j("input[name='aeEndDateComplete']").val();
	
		if((aeStartDateBegin!=null && aeStartDateBegin!="") || (aeStartDateComplete!=null && aeStartDateComplete!="") || (aeEndDateBegin!=null && aeEndDateBegin!="") || (aeEndDateComplete!=null && aeEndDateComplete!=""))
		{
			flag = false;
			
		}
		var evaluationDoneBy = $j("input[name='evaluationDoneBy']").val();
		if(evaluationDoneBy!=null && evaluationDoneBy!="") 
		{
			flag = false;
		}
		if($j("#aeResearchAgencies option:selected").length>0)
		{
			
			if($j("#aeResearchAgencies option:selected").val()!="")
			{
				flag = false;
			}
		}
		if($j("#aeCostComponents option:selected").length>0)
		{
			
			if($j("#aeCostComponents option:selected").val()!="")
			{
				flag = false;
			}
		}
		if($j("#aeResearchEndMarkets option:selected").length>0)
		{
			
			if($j("#aeResearchEndMarkets option:selected").val()!="")
			{
				flag = false;
			}
		}
		if($j("#aeMethDetails option:selected").length>0)
		{
			
			if($j("#aeMethDetails option:selected").val()!="")
			{
				flag = false;
			}
		}
		if($j("#aeMethodologyTypes option:selected").length>0)
		{
			
			if($j("#aeMethodologyTypes option:selected").val()!="")
			{
				flag = false;
			}
		}
		if($j("#aeBudgetLocations option:selected").length>0)
		{
			
			if($j("#aeBudgetLocations option:selected").val()!="")
			{
				flag = false;
			}
		}
		if($j("#aeBudgetYears option:selected").length>0)
		{
			
			if($j("#aeBudgetYears option:selected").val()!="")
			{
				flag = false;
			}
		}
		if(flag)
		{
			$j(".warning-text").show();
		}
		else
		{
			$j(".warning-text").hide();
			var agencyEvalForm = $j("#agency-Evaluation-Report-Form");
			agencyEvalForm.submit();
		}
	*/
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



  if (window.history && window.history.pushState) {

    window.history.pushState('forward', null, null);

    $(window).on('popstate', function() {
      /*dialog({
			title:"",
			closeOnEscape: false,
			html:"<i class='warningErr'></i>Clicking back button will log you out of the system. Do you want to continue?",
			nonCloseActionButtons:['YES'],
			open: function(event, ui) {
				$(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
			},
			buttons:{
				"YES":function() {
					 location.href="/logout.jspa";
					 window.history.pushState('forward', null, "/logout.jspa");
				},
				"NO": function() {
					 window.history.pushState('forward', null, null);
				}
			},
			closeActionButtonsClickHander:function() {
				
				closeDialog();
			}
		});
		*/
		dialog({
					title: '',
					html: '<i class="warningErr"></i><p>Clicking back button will log you out of the system.</p><p>Do you want to continue?',
					buttons:{
						"Yes":function() {
							
						 location.href="/logout.jspa";
					 window.history.pushState('forward', null, "/logout.jspa");
						  
							
						},
						"No": function() {
							window.history.pushState('forward', null, null);
						}
					},
					close: function() { 
						closeDialog();
					}
				});
    });

  }
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
	
/*	
$j(function(){
var hasVerticalScrollbar= $j('tbody').scrollHeight > $j('tbody').clientHeight;
	//hasscrollerFunction()
	//alert(hasVerticalScrollbar)
})
 
var hasscrollerFunction = function(){
	if(!$j('tbody').hasVerticalScrollbar){
		alert("dasda")
	$j('.scrollable-table.project_status_table tbody').css('width','993px');
	}
	else{
		alert("asdasdasd")
	$j('.scrollable-table.project_status_table tbody').css('width','977px');
	}
}*/
</script>
<div id="dialog-box" title="Alert" style="display:none;min-height:auto;">
    <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span></p>
</div>
<#include "/template/global/synchro-result-filter-new.ftl" />
<div id="backgroundPopup"></div>





</body>

</html>
