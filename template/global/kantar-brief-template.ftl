<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/kantar-macros.ftl" />
<#include "/template/global/include/form-message.ftl"/>

<script language="JavaScript" type="text/javascript" src="<@s.url value='/dwr/interface/KantarBriefTemplateAutoSaveService.js'/>"></script>
<script type="text/javascript">
    $j(document).ready(function(){
        $j(".kantar-final-cost-error").hide();
        $j(".kantar-final-cost-currency-error").hide();
    <#--<#if kantarBriefTemplate?? && kantarBriefTemplate.id?? && request.getParameter("validationError")??>-->
        <#--<#if !kantarBriefTemplate.finalCost??>-->
            <#--$j(".kantar-final-cost-error").show();-->
        <#--<#elseif (!kantarBriefTemplate.finalCostCurrency?? || kantarBriefTemplate.finalCostCurrency &lt;= 0)>-->
            <#--$j(".kantar-final-cost-currency-error").show();-->
        <#--</#if>-->
    <#--</#if>-->
    <#if showFinalCostError?? && showFinalCostError>
        $j(".kantar-final-cost-error").show();
    </#if>
    <#if showFinalCostCurrencyError?? && showFinalCostCurrencyError>
        $j(".kantar-final-cost-currency-error").show();
    </#if>

        $j(".numericfield, .numericfieldpib").focusout(function() {
            //$j(".numericfield").trigger('change');
            if(!$j(this).hasClass("nonformatfield"))
            {
                $j(this).val($j(this).val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
            }

        });

        $j(".numericfield, .numericfieldpib").focusin(function() {
            if(!$j(this).hasClass("nonformatfield"))
            {
                $j(this).val($j(this).val().replace(/\,/g, ''));
            }
        });
    });

</script>
<#--<script type="text/javascript">-->
<#--$j(document).ready(function(){-->
<#--DYNAMIC_HEIGHT_LOADER.setVerticalCenter($j("#grail-brief-template-container"));-->
<#--});-->
<#--</script>-->
<script type="text/javascript">
    var intervalId = null;
    $j(document).ready(function(){
        //resetTimeOut();
    });

    function resetTimeOut() {
        if(intervalId !== null) {
            clearTime();
        }

        if(intervalId === null) {
            intervalId = setTimeout(timeOutHandler, 60000); // 60000 = 1min
        }
    }

    function clearTime() {
        clearTimeout(intervalId);
        intervalId = null;
    }

    function timeOutHandler() {
        saveDraftTemplate();
    }

    $j(function(){
    <#--GrailBriefTemplateAutoSaveService.getDraftTemplate(${user.ID?c},{-->
    <#--callback: function(data) {-->
    <#--if(data != null) {-->
    <#--if(data.researchNeedsPriorities) {-->
    <#--$j("#researchNeedsPriorities").val(data.researchNeedsPriorities);-->
    <#--}-->
    <#--if(data.hypothesisBusinessNeed) {-->
    <#--$j("#hypothesisBusinessNeeds").val(data.hypothesisBusinessNeed);-->
    <#--}-->
    <#--if(data.markets) {-->
    <#--$j("#markets").val(data.markets);-->
    <#--}-->
    <#--if(data.products) {-->
    <#--$j("#products").val(data.products);-->
    <#--}-->
    <#--if(data.brands) {-->
    <#--$j("#brands").val(data.brands)-->
    <#--}-->
    <#--if(data.categories) {-->
    <#--$j("#categories").val(data.categories);-->
    <#--}-->
    <#--if(data.deliveryDate) {-->
    <#--var deliveryDate =  new Date(data.deliveryDate);-->
    <#--$j("#deliveryDate").val((deliveryDate.getDate() < 9?"0":"") + deliveryDate.getDate() + "/" + ((deliveryDate.getMonth() + 1) < 9?"0":"") + (deliveryDate.getMonth() + 1) + "/" +deliveryDate.getFullYear());-->
    <#--}-->
    <#--if(data.outputFormat) {-->
    <#--$j("#outputFormat").val(data.outputFormat)-->
    <#--}-->
    <#--}-->

    <#--}-->
    <#--});-->
    });

    function saveDraftTemplate() {
        var formData = $j("#grail-brief-template-form").serializeArray();
        var canSaveAsDraft = false;
        for(var i = 0; i < formData.length; i++) {
            var obj = formData[i];
            if(obj && obj.name) {
                if(obj.name === 'outputFormat') {
                    if(obj.value && obj.value > 0) {
                        canSaveAsDraft = true;
                    }
                } else if(obj.name !== 'userLocale') {
                    if(obj && obj.value) {
                        canSaveAsDraft = true;
                    }
                }
            }
        }
        if(canSaveAsDraft) {
            var formURL = $j("#grail-brief-template-form").attr("action");
            $j.ajax({
                url: formURL + "?draft=true" ,
                type: 'POST',
                data: formData,
                success: function(data, test) {
                    resetTimeOut();
                    console.log("Grail Brief Template saved successfully in draft mode");
                },
                error: function() {
                    console.log("Error on saving details..")
                }
            });
        } else {
        <#--GrailBriefTemplateAutoSaveService.deleteDraftTemplate(${user.ID?c},{-->
        <#--callback: function(data) {-->
        <#--resetTimeOut();-->
        <#--}-->
        <#--});-->
        }

    }

    function cancel() {
    <#--GrailBriefTemplateAutoSaveService.deleteDraftTemplate(${user.ID?c},{-->
    <#--callback: function(data) {-->
    <#--window.location.href = '<@s.url value="/grail/home!input.jspa"/>';-->
    <#--}-->
    <#--});-->
        window.location.href = '<@s.url value="/kantar/home!input.jspa"/>';
    }
    $j(function(){
    <#if request.getParameter("success")?? && request.getParameter("success") == "true">
        dialog({title:"Confirmation", html:"<p>Thanks for making a request to Kantar. The Kantar team will reach out to you to clarify your request.</p>"},
                function(){
                    window.location.href = '<@s.url value="/kantar/home!input.jspa"/>';
                });

    </#if>
    });
</script>
<div class="kantar kantar-main-container">
<#if (kantarBriefTemplate?? && kantarBriefTemplate.id??)>
    <@kantarTabs id=id activeTab=1 />
</#if>
<div class="research_content">
<div class="grail-brief-template-container kantar">
<#if (kantarBriefTemplate?? && kantarBriefTemplate.id??)>
<h2>${generateKantarProjectCode(kantarBriefTemplate.id)}</h2>
<#else>
<h2>Brief Template</h2>
</#if>

<form id="grail-brief-template-form" action="<@s.url value="/kantar/brief-template!execute.jspa"/>?draft=false<#if request.getParameter("id")??>&id=${request.getParameter("id")}</#if>" method="post">
    <div class="left">
        <div class="top">
        <#--<label class="label" for="researchNeedsPriorities">Research Needs and Priorities</label>-->
            <label class="label" for="researchNeedsPriorities">Business Question</label>
            <textarea id="researchNeedsPriorities" name="researchNeedsPriorities" placeholder="What is your business question?" <#if !(canEditProject || newProject)>readonly</#if>><#if kantarBriefTemplate?? && kantarBriefTemplate.researchNeedsPriorities??>${kantarBriefTemplate.researchNeedsPriorities}</#if></textarea>
        </div>
        <div class="separator"></div>
        <div class="bottom">
            <label class="label" for="hypothesisBusinessNeeds">Hypotheses and Business Needs</label>
            <textarea id="hypothesisBusinessNeeds" name="hypothesisBusinessNeed" placeholder="What are you trying to prove?" <#if !(canEditProject || newProject)>readonly</#if>><#if kantarBriefTemplate?? && kantarBriefTemplate.hypothesisBusinessNeed??>${kantarBriefTemplate.hypothesisBusinessNeed}</#if></textarea>
        </div>
        <div class="separator"></div>
        <div class="bottom">
            <label class="label" for="dataSource">Suggested Data Source</label>
            <textarea id="dataSource" name="dataSource" placeholder="Please provide data source, if any" <#if !(canEditProject || newProject)>readonly</#if>><#if kantarBriefTemplate?? && kantarBriefTemplate.dataSource??>${kantarBriefTemplate.dataSource}</#if></textarea>
        </div>

    </div>
    <div class="right">
        <label class="header label">Scope (Leave blank, if not applicable)</label>
        <div class="top">
            <div class="form_text">
                <label>Markets</label>
            <#--<input type="text" id="markets" name="markets" <#if kantarBriefTemplate?? && kantarBriefTemplate.markets??>value="${kantarBriefTemplate.markets}"</#if>>-->
            <#assign marketId = -1>
            <#if kantarBriefTemplate?? && kantarBriefTemplate.markets??>
                <#assign marketId = kantarBriefTemplate.markets>
            </#if>
                <select id="markets" name="markets" class="select_field markets" <#if !(canEditProject || newProject)>disabled</#if>>
                    <option value="-1" selected="true">-- None --</option>
                <#assign endmarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets()>
                <#assign endMarketKeySet = endmarkets.keySet() />
                <#if (endmarkets?has_content)>
                    <#list endMarketKeySet as key>
                        <#assign endmarket = endmarkets.get(key) />
                        <option value="${key?c}" <#if key = marketId?int>selected="true"</#if>>${endmarket}</option>
                    </#list>
                </#if>
                </select>
            </div>
            <div class="form_text">
                <label>Products</label>
                <input type="text" id="products" name="products" <#if kantarBriefTemplate?? && kantarBriefTemplate.products??>value="${kantarBriefTemplate.products}"</#if> <#if !(canEditProject || newProject)>readonly</#if>>
            </div>
            <div class="form_text">
                <label>Brands</label>
                <input type="text" id="brands" name="brands" <#if kantarBriefTemplate?? && kantarBriefTemplate.brands??>value="${kantarBriefTemplate.brands}"</#if> <#if !(canEditProject || newProject)>readonly</#if>>
            </div>
            <div class="form_text">
                <label>Categories</label>
                <input type="text" id="categories" name="categories" <#if kantarBriefTemplate?? && kantarBriefTemplate.categories??>value="${kantarBriefTemplate.categories}"</#if> <#if !(canEditProject || newProject)>readonly</#if>>
            </div>

            <div class="form_text">
            <#assign methId = -1>
            <#if kantarBriefTemplate?? && kantarBriefTemplate.methodologyType??>
                <#assign methId = kantarBriefTemplate.methodologyType>
            </#if>
                <label>Methodology Type</label>
                <select id="methodologyType" name="methodologyType" class="select_field methodologyType" <#if !(canEditProject || newProject)>disabled</#if>>
                    <option value="-1" selected="true">-- None --</option>
                <#assign methodologyTypes = statics['com.grail.kantar.util.KantarUtils'].getKantarButtomMethodologyTypes()>
                <#assign methodologyTypeKeySet = methodologyTypes.keySet() />
                <#if (methodologyTypes?has_content)>
                    <#list methodologyTypeKeySet as key>
                        <#assign methodologyType = methodologyTypes.get(key) />
                        <option value="${key?c}" <#if key = methId?long>selected="true"</#if>>${methodologyType}</option>
                    </#list>
                </#if>
                </select>
                <script type="text/javascript">
                    $j("#methodologyType").change(function(){
                        var that = this;
                        var val = $j(this).val();
                        if(val == -100) {
                            dialog({title:'Confirmation',
                                html:"Are you sure you wish to choose 'Other'?",
                                buttons:{
                                    "YES":function() {
                                        closeDialog();
                                    },
                                    "NO":function() {
                                        $j(that).val(${methId});
                                        closeDialog();
                                    }
                                }
                            })
                        }
                    });
                </script>
            </div>
        <#if kantarBriefTemplate?? && kantarBriefTemplate.id??>
            <div class="form_text">
                <label>Final Cost</label>
                <script type="text/javascript">
                    function finalCostChange() {
                        if($j("input[name=finalCost-display]").val() != "") {
                            var val =  Number($j("input[name=finalCost-display]").val().replace(/\,/g,''));
                            $j("input[name=finalCost]").val(val);
                        } else {
                            $j("input[name=finalCost]").val("");
                        }
                    }
                </script>
                <input type="text" name="finalCost-display" onchange="finalCostChange()" <#if kantarBriefTemplate?? && kantarBriefTemplate.finalCost??>value="${kantarBriefTemplate.finalCost}"</#if> size="30" class="form-text-div numericfield longField finalCost" <#if !(canEditProject || newProject)>readonly</#if>>
                <input type="hidden" name="finalCost" <#if kantarBriefTemplate?? && kantarBriefTemplate.finalCost??>value="${kantarBriefTemplate.finalCost}"</#if>>
                <#if kantarBriefTemplate?? && kantarBriefTemplate.finalCostCurrency?? && kantarBriefTemplate.finalCostCurrency &gt; 0>
                    <@renderCurrenciesField name='finalCostCurrency' value=kantarBriefTemplate.finalCostCurrency?default(defaultCurrency) disabled=(!canEditProject)/>
                <#else>
                    <@renderCurrenciesField name='finalCostCurrency' value=defaultCurrency disabled=(!canEditProject)/>
                </#if>
                <#--<@macroFieldErrors name="finalCost" cls='kantar-final-cost-error'/>-->
                <#--<@macroFieldErrors name="finalCostCurrency" cls='kantar-final-cost-currency-error'/>-->

                <span class="jive-error-message kantar-final-cost-error" style="display: none;">Please enter final cost.</span>
                <span class="jive-error-message kantar-final-cost-currency-error" style="display: none;">Please select final cost currency.</span>

            </div>
        </#if>
        </div>
        <div class="separator"></div>
        <div class="bottom">
            <div class="first">
                <label class="label">Delivery Date</label>
            <#if (canEditProject || newProject)>
                <#--<@jiveform.datetimepicker id="deliveryDate" name="deliveryDate" value="" readonly=true disablePrevDates=false defaultDateTimePicker=false/> -->
				<@synchrodatetimepicker id="deliveryDate" name="deliveryDate" value="" format="%d/%m/%Y" readonly=true disablePrevDates=false defaultDateTimePicker=false/>
				
            <#else>
                <input type="text" tabindex="1" name="deliveryDate" id="deliveryDate" class="deliveryDateReadonly" readonly/>
            </#if>
                <script type="text/javascript">
                    $j(function(){
                    <#if (kantarBriefTemplate?? && kantarBriefTemplate.deliveryDate??)>
                        $j('#deliveryDate').val("${kantarBriefTemplate.deliveryDate?string('dd/MM/yyyy')}");
                    </#if>
                    <#if (canEditProject || newProject)>
                        $j("#deliveryDate").click(function() {
                            $j("#deliveryDate_button").click();
                        });
                    </#if>
                    });
                </script>

            </div>
            <div class="second">
            <#assign oType = -1>
            <#if kantarBriefTemplate?? && kantarBriefTemplate.outputFormat??>
                <#assign oType = kantarBriefTemplate.outputFormat>
            </#if>
                <label for="outputFormat" class="label">Output Format</label>
                <select id="outputFormat" name="outputFormat" class="select_field" <#if !(canEditProject || newProject)>disabled</#if>>
                    <option value="-1" readonly="readonly" selected="true">Select output format</option>
                <#assign outputTypes = statics['com.grail.kantar.util.KantarGlobals$BriefTemplateOutputType'].values()/>
                <#if outputTypes?? && outputTypes?has_content>
                    <#list outputTypes as outputType>
                        <option value='${outputType.getId()}' <#if oType = outputType.getId()>selected="true" </#if>>${outputType.getName()}</option>
                    </#list>
                </#if>
                <#--<option value="PPT">PPT</option>-->
                <#--<option value="Excel">Excel</option>-->
                <#--<option value="Word">Word</option>-->
                <#--<option value="Email">Email</option>-->
                </select>
            </div>
        </div>
        <div class="bottom last">
            <div class="form_text">
                <label class="label">BAT Contact</label>
            <#if (canEditProject || newProject)>
                <input type="text" tabindex="1" name="batContact" id="batContact" class="j-user-autocomplete j-ui-elem" srole="20" autocomplete="on" />
            <#else>
                <input type="text" tabindex="1" name="batContactName" id="batContactName" <#if !(canEditProject || newProject)>readonly</#if>/>
            </#if>
            </div>
        </div>
    </div>
<#--<#if request.getParameter("id")??>-->
<#--<input type="hidden" value="${request.getParameter('id')}" name="id">-->
<#--</#if>-->
<#if (canEditProject || newProject)>
<div class="action-buttons<#if kantarBriefTemplate?? && kantarBriefTemplate.id??> edit</#if>">
    <input class="save" type="submit" <#if kantarBriefTemplate?? && kantarBriefTemplate.id??>value="Save" class="left"<#else>value="Submit"</#if>>
    <#if !(kantarBriefTemplate?? && kantarBriefTemplate.id??)>
        <input type="button" class="jive-form-button-decline cancel" value="cancel" onclick="cancel()">
    </#if>
</#if>
</div>
</form>
</div>
</div>
</div>

<#--<#include "/template/global/include/synchro-invite-user.ftl" />-->
<script type="text/javascript">
    var batContact = -1;
    <#assign isReference = false />
    <#if kantarBriefTemplate?? && kantarBriefTemplate.batContact?? && !statics['com.grail.synchro.util.SynchroUtils'].isReferenceID(kantarBriefTemplate.batContact)>
    batContact = ${kantarBriefTemplate.batContact?c};
    <#else>
        <#assign isReference = true />
    batContact = -1;
    </#if>
    $j(document).ready(function(){
    <#if (canEditProject || newProject)>
        initializeUserPicker({$input:$j("#batContact"),name:'batContact',value:batContact ,defaultFilters:{'role':20, 'roleEnabled':true, 'ownerfield': true,'hideInvite':false}});
        <#if isReference?? && isReference && kantarBriefTemplate.batContact??>
            $j('input[name=batContact]').val("${kantarBriefTemplate.batContact?c}");
            <#assign userDisplayName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(kantarBriefTemplate.batContact) />
            $j("#batContact").val("${userDisplayName}");
            <#assign isReference = false />
        </#if>

    <#else>
        <#if kantarBriefTemplate?? && kantarBriefTemplate.batContact??>
            <#assign ownerUserName = statics['com.grail.synchro.util.SynchroUtils'].getUserDisplayName(kantarBriefTemplate.batContact?long)/>
            $j("#batContactName").val("${ownerUserName}");
        </#if>
    </#if>
    });
</script>