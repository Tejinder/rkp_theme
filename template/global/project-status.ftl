<#assign canChangeProjectStatus = statics['com.grail.synchro.util.SynchroPermHelper'].canChangeProjectStatus(projectID) />
<!-- PIB Import Utility JS-->
<script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/form-data-persist-handler.js?version=1" type="text/javascript"></script>

<!-- Dynamic variables declaration -->
<#assign isAdmin = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroMiniAdmin() />
<#assign isMultimarket = false />
<#assign isActive = false />
<#assign isDeleted = false />
<#assign isCancelled = false />
<#assign completed = false />

<#if projectActivateStatus?? && projectActivateStatus==statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].OPEN.ordinal() >
	<#assign isActive = true />
<#elseif projectActivateStatus?? && projectActivateStatus==statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].DELETED.ordinal() >
	<#assign isDeleted = true />
<#elseif projectActivateStatus?? && projectActivateStatus==statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].CANCEL.ordinal()>
	<#assign isCancelled = true />
<#elseif projectOverallStatus?? && projectOverallStatus==statics['com.grail.synchro.SynchroGlobal$ProjectStatus'].COMPLETED.ordinal()>
	<#assign completed = true />
</#if>
		
<#if canChangeProjectStatus?? && !canChangeProjectStatus>
<!-- TODO -->
    <#include "/template/global/project-status-readonly.ftl"/>
<#else>
    <#include "/template/global/include/synchro-macros.ftl" />
    <#include "/template/global/include/form-message.ftl" />

<!-- Page container -->
<div class="container project_change_status">
    <div class="project_name_div">
        <h2>Change Project Status</h2>
        <h2>${project.name?default('')} (${generateProjectCode('${projectID?c}')})</h2>
       <#-- <form action="project-status!execute.jspa?projectID=${projectID?c}" method="post" name="form-create" id="form-create">  -->
	    <form action="project-status!execute.jspa" method="post" name="form-create" id="form-create">            
            <!-- Return css class for active and completed stages -->
            <#function getStatusCSSClass overallStatus=0 class="">
                <#if overallStatus?? && overallStatus &gt;= 3  && overallStatus &lt;= 7>
                    <#if projectOverallStatus?? && projectOverallStatus &gt;= 3 && projectOverallStatus &lt;= 7 && overallStatus == 3>
                        <#return class + " active">
                    <#else>
                        <#return generateStatusCSSClass(overallStatus, class)>
                    </#if>
                <#else>
                    <#return generateStatusCSSClass(overallStatus, class)>
                </#if>
            </#function>

            <#function generateStatusCSSClass overallStatus=0 class="">
                <#if isActiveStatus(overallStatus)>
                    <#return class + " active">
                <#elseif isStatusCompleted(overallStatus)>
                    <#return class + " completed">
                <#else>
                    <#return class>
                </#if>
            </#function>

            <!-- check if stage is active -->
            <#function isActiveStatus overallStatus=0>
                <#if projectOverallStatus?? && projectOverallStatus==overallStatus && !isDeleted>
                    <#return true>
                <#else>
                    <#return false>
                </#if>
            </#function>

            <!-- check if stage is completed -->
            <#function isStatusCompleted overallStatus=0>
                <#if projectOverallStatus?? && projectOverallStatus &gt; overallStatus>
                    <#return true>
                <#else>
                    <#return false>
                </#if>
            </#function>
			<!-- Main status container START -->
            <div class="change-status-main">
                <div class="change-status">
                    <h3>Current Status of the Project</h3>
                    <ul>
                        <li class="status">
                            <span class='${getStatusCSSClass(1,"progress first")}'></span>
                            <span class="${getStatusCSSClass(1, "message")}">PIT</span>
                        </li>
                        <li class="separator <#if projectOverallStatus?? && projectOverallStatus &gt; 1>fill</#if>"></li>
                        <li class="status">
                            <span class="${getStatusCSSClass(2,"progress")}"></span>
                            <span class="${getStatusCSSClass(2,"message")}">PIB</span>
                        </li>
                        <li class="separator <#if projectOverallStatus?? && projectOverallStatus &gt; 2>fill</#if>"></li>
                        <li class="status">
                            <span class="${getStatusCSSClass(3,"progress")}"></span>
                            <span class="${getStatusCSSClass(3,"message in-progress")}">IN-PROGRESS</span>
                            <span class="${getStatusCSSClass(4,"sub-status")}"><p>PLANNING</p></span>
                            <span class="${getStatusCSSClass(5,"sub-status")}"><p>FIELDWORK</p></span>
                            <span class="${getStatusCSSClass(6,"sub-status")}"><p>ANALYSIS & REPORT</p></span>
                            <span class="${getStatusCSSClass(7,"sub-status")}"><p>UPLOAD TO IRIS</p></span>
                        </li>
                        <li class="separator <#if projectOverallStatus?? && projectOverallStatus &gt; 7>fill</#if>"></li>
                        <li class="status">
                            <span class="${getStatusCSSClass(8,"progress last")}"></span>
                            <span class="${getStatusCSSClass(8,"message")}">COMPLETED</span>
                        </li>
                    </ul>
                </div>

                <div class="change-status-sub">
                    <h3>Click to Change the status of the Project</h3>
                    <div class="cs-button-main">
                        <div class="cs-buttons">
                            <a id="form_astatus" href="javascript:void(0);" onclick="changeStatus(1, this);" <#if projectActivateStatus?? && projectActivateStatus==1>class="concept-activated"<#elseif (isDeleted && !isAdmin) || hasCompleted>class="concept status-button-disabled"<#elseif isCancelled && !isAdmin>class="concept status-button-disabled"<#else>class="concept"</#if>>ON-HOLD</a>
                        </div>

                        <div class="cs-buttons">
                            <a id="form_astatus" href="javascript:void(0);" onclick="changeStatus(2, this);" <#if projectActivateStatus?? && projectActivateStatus==2>class="concept-activated"<#elseif (isDeleted && !isAdmin) || hasCompleted>class="concept status-button-disabled"<#elseif isCancelled && !isAdmin>class="concept status-button-disabled"<#else>class="concept"</#if>>CANCEL PROJECT</a>
                        </div>
                        <div class="cs-buttons">
                            <a id="form_astatus" href="javascript:void(0);" onclick="changeStatus(0, this);" <#if isActive>class="concept-activated"<#elseif isDeleted && !isAdmin>class="concept status-button-disabled"<#elseif isCancelled && !isAdmin>class="concept"<#elseif hasCompleted && !isDeleted>class="concept status-button-disabled"<#else>class="concept"</#if>>OPEN</a>
                        </div>

                        <#if isAdmin>
                            <div class="cs-buttons">
                                <a id="form_astatus" href="javascript:void(0);" onclick="changeStatus(3, this);" <#if projectActivateStatus?? && projectActivateStatus==3>class="concept-activated"<#elseif isDeleted && !isAdmin>class="concept status-button-disabled"<#elseif isCancelled && !isAdmin>class="concept status-button-disabled"<#else>class="concept"</#if>>DELETE</a>
                            </div>
                        </#if>
                    </div>
                </div>				
			<div class="change-status-sub">
				<#if multimarket?? && multimarket>
					<div class="cs-button-main">
						<div class="cs-buttons">
							<a id="form_astatus" href="javascript:void(0);" onclick="loadPopup();" class="concept">VIEW/CHANGE <br/>MARKET'S STATUS</a>
						</div>
					</div>
				</#if>
			</div>
			
			<!-- Project Multi-market endmarkets Status Popup window  START -->
			<#if multimarket?? && multimarket>
				<!-- Dynamic Multi-market variables declaration -->
				<#assign OPEN_ID = statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].OPEN.ordinal() />
				<#assign ONHOLD_ID = statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].ONHOLD.ordinal() />
				<#assign CANCEL_ID = statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].CANCEL.ordinal() />
				<#assign DELETED_ID = statics['com.grail.synchro.SynchroGlobal$ProjectActivationStatus'].DELETED.ordinal() />
				<div id="endMarketStatus" style="display:none" class="multi-project-status">
					<ul>
						<li class="status-empty">
						</li>
						<li class="status-header">
							Put-On-Hold
						</li>
						<li class="status-header">
							Reactivate
						</li>
						<li class="status-header">
							Cancel
						</li>						
						<li class="status-header">
							Delete
						</li>						
					</ul>					
					<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() >
					<#list endMarketIDs as endMarketID>
						<#assign endMarketName = endMarkets.get(endMarketID?int) />
						<#if statusMap.get(endMarketID?c?string)?exists >
							<#assign status = statusMap.get(endMarketID?c?string) />							
							<#if status==ONHOLD_ID?c?string || status==CANCEL_ID?c?string || status==DELETED_ID?c?string>
								<#assign isEMActive = false />
							<#else>
								<#assign isEMActive = true />
							</#if>
						</#if>						
						
						<#assign isAwarded = false />		
						<#list awardedMap.entrySet() as entry>
							<#if entry.value?string=="true">
								<#assign isAwarded = true />
								<#break>
							</#if>
						</#list>
						
						<#assign fieldworkCompleted = false />
						<#list fieldWorkMap.entrySet() as fwentry>
							<#if fwentry.key?string==endMarketID?c?string && fwentry.value?string=="true">
								<#assign fieldworkCompleted = true />
								<#break>
							</#if>
						</#list>						
							<ul>
								<li class="endmarket">
									<span>
										${endMarketName?default('Not Available')}
									</span>
								</li>
								<li>								
									<input class="status-radio" type='radio' name='status-${endMarketID?c}' id="action-${ONHOLD_ID?c}" <#if status==ONHOLD_ID?c?string>checked</#if> <#if isAdmin><#elseif status==DELETED_ID?c?string || fieldworkCompleted>disabled</#if> />
								</li>
								<li>
									<input class="status-radio" type='radio' name='status-${endMarketID?c}' id="action-${OPEN_ID?c}" <#if status==OPEN_ID?c?string>checked</#if>  <#if isAdmin><#elseif isAwarded && !isEMActive>disabled<#elseif status==DELETED_ID?c?string>disabled</#if> />
								</li>
								<li>
									<input class="status-radio" type='radio' name='status-${endMarketID?c}' id="action-${CANCEL_ID?c}" <#if status==CANCEL_ID?c?string>checked</#if> <#if isAdmin><#elseif status==DELETED_ID?c?string || fieldworkCompleted>disabled</#if> />
								</li>								
								<li>
									<input class="status-radio" type='radio' name='status-${endMarketID?c}' id="action-${DELETED_ID?c}" <#if status==DELETED_ID?c?string>checked</#if> <#if isAdmin><#elseif status==DELETED_ID?c?string || fieldworkCompleted>disabled</#if> />
								</li>
								
							</ul>
					</#list>
					<input class="j-btn-callout" type="submit" name="doPost" id="postButton" onclick="return saveEndMarketStatus();" value="Save" style="font-weight: bold;">
				</div>
			</#if>
			<!-- Project Multi-market endmarkets Status Popup window ENDs -->			
            </div>
			<!-- Main status container ENDs -->
            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" name="projectActivateStatus" id="projectActivateStatus" value="${projectActivateStatus?default('')}" />
        </form>
		
		<form action="project-status!update.jspa?projectID=${projectID?c}" method="post" name="endmarket-status-form" id="endmarket-status-form">
			<div id="endmarket-status-content">
				<#list endMarketIDs as endMarketID>
					<input type="hidden" id="endmarket_${endMarketID}" name="endMarketID[${endMarketID_index}]" value ="${endMarketID?c}" />
					<#if statusMap?? && statusMap.containsKey(endMarketID?string)>
						<input type="hidden" id="status_${endMarketID}" name="status[${endMarketID_index}]" value =${statusMap.get(endMarketID?string)} />
					</#if>	
				</#list>
			</div>
		</form>
    </div>
</div>
<!-- All container ENDs -->

<script type="text/javascript">
var endMarketStatusWindow = null;
    $j(document).ready(function(){
        PROJECT_STAGE_NAVIGATOR.initialize({
            <#if projectID??>
                projectId:${projectID?c},
            </#if>
            activeStage:-1
        });
       
		$j(".project_change_status .project_name_div").hide();
        $j(".project_change_status .project_name_div").css("min-height", DYNAMIC_HEIGHT_LOADER.getMainContainerHeight()-186);
        $j(".project_change_status .project_name_div").show();
	
	endMarketStatusWindow = new LIGHT_BOX($j("#endMarketStatus"),{title:'Market Status'});
	
	/**  Multimarket change status Popup's select Radio Event **/
	$j(".status-radio").change(function() {
	  var id = $j(this).attr('id');
	  var action = null;
	  if(id.indexOf('-')!=-1)
	  {
		action = id.split('-')[1];
	  }
	  
	  var name = $j(this).attr('name');
	  if(name.indexOf('-')!=-1)
	  {
		var eid = name.split('-')[1];
		var $div = $j("#endmarket-status-content");		
		var status_field = $j("#status_"+eid);
		if(action!=null)
		{
			status_field.val(action);
		}
	  }
	});
	
    });

    function submitForm() {
        var form = $j("#form-create");
        jive.util.securedForm(form).always(function() {
            console.log("submit the form");
            form.submit();
        });
    }

    function changeStatus(status, that)
    {		
        if(!hasClass(that, 'status-button-disabled') && !hasClass(that, 'concept-activated'))
        {		
			showLoader('Please wait...');
            $j("#projectActivateStatus").val(status);			
			submitForm();
        }
    }

    function hasClass(element, cls) {
        return (' ' + element.className + ' ').indexOf(' ' + cls + ' ') > -1;
    }
	
	function loadPopup()
	{
		endMarketStatusWindow.show();
	}
	
	function saveEndMarketStatus()
	{
		showLoader('Please wait...');
		var form = $j("#endmarket-status-form");		
        jive.util.securedForm(form).always(function() {        
			form.submit();
        });
	}
	
</script>
</#if>