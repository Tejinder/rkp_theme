
    <#include "/template/global/include/synchro-macros.ftl" />
    <#include "/template/global/include/form-message.ftl" />
    <#assign isAdmin = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) || statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroMiniAdmin() />

<!-- Page container -->
<div class="container project_change_status">
    <div class="project_name_div">
        <h2>${project.name?default('')} (${generateProjectCode('${projectID?c}')})</h2>
        <!-- Finds Project Activate Status -->
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

    <#--<@renderProjectStagesTab projectID=projectID stageId=7 />-->

        <form action="project-status.jspa?projectID=${projectID?c}" method="post" name="form-create" id="form-create">
            <#if isMultimarket?? && isMultimarket>
                <div class="endmarket-status-btn">
                    <a href="javascript:void(0);" onclick="openEMStatusPopup();" class="view-endmarket-btn">Click to View/Change a <br/>Market's Status</a>
                </div>
            </#if>
            <#--<#assign projectOverallStatus = 6/>-->
            <#function getStatusCSSClass overallStatus=0 class="">
                <#if projectOverallStatus?? && projectOverallStatus==overallStatus && !isDeleted>
                    <#return class + " active">
                <#elseif projectOverallStatus?? && projectOverallStatus &gt; overallStatus>
                    <#return class + " completed">
                <#else>
                    <#return class>
                </#if>

            </#function>
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

                            <#if projectOverallStatus?? && projectOverallStatus == 3>
                                <span class="${getStatusCSSClass(3,"progress")}"></span>
                                <span class="${getStatusCSSClass(3,"message in-progress")}">IN-PROGRESS</span>
                            <#elseif projectOverallStatus?? && projectOverallStatus == 4>
                                <span class="${getStatusCSSClass(4,"progress")}"></span>
                                <span class="${getStatusCSSClass(4,"message in-progress")}">IN-PROGRESS</span>
                                <span class="sub-status"><span class="message-separator"></span><p>PLANNING</p></span>
                            <#elseif projectOverallStatus?? && projectOverallStatus == 5>
                                <span class="${getStatusCSSClass(5,"progress")}"></span>
                                <span class="${getStatusCSSClass(5,"message in-progress")}">IN-PROGRESS</span>
                                <span class="sub-status"><span class="message-separator"></span><p>FIELDWORK</p></span>
                            <#elseif projectOverallStatus?? && projectOverallStatus == 6>
                                <span class="${getStatusCSSClass(6,"progress")}"></span>
                                <span class="${getStatusCSSClass(6,"message in-progress")}">IN-PROGRESS</span>
                                <span class="sub-status"><span class="message-separator"></span><p>ANALYSIS & REPORT</p></span>
                            <#elseif projectOverallStatus?? && projectOverallStatus == 7>
                                <span class="${getStatusCSSClass(7,"progress")}"></span>
                                <span class="${getStatusCSSClass(7,"message in-progress")}">IN-PROGRESS</span>
                                <span class="sub-status"><span class="message-separator"></span><p>UPLOAD TO IRIS</p></span>
							<#else>
								<span class="${getStatusCSSClass(3,"progress")}"></span>
                                <span class="${getStatusCSSClass(3,"message in-progress")}">IN-PROGRESS</span>
                            </#if>
                        </li>
                        <li class="separator <#if projectOverallStatus?? && projectOverallStatus &gt; 7>fill</#if>"></li>
                        <li class="status">
                            <span class="${getStatusCSSClass(8,"progress last")}"></span>
                            <span class="${getStatusCSSClass(8,"message")}">COMPLETED</span>
                        </li>
                    </ul>               

                </div>

                <div class="change-status-sub">
                    <h3>Click to Change the status of the project</h3>
                    <div class="cs-button-main">
                        <div class="cs-buttons">
                            <a id="form_astatus" href="javascript:void(0);" <#if projectActivateStatus?? && projectActivateStatus==1>class="concept-activated"<#else>class="concept status-button-disabled"</#if>>PUT ON-HOLD</a>
                        </div>
                        <div class="cs-buttons">
                            <a id="form_astatus" href="javascript:void(0);" <#if isActive>class="concept-activated"<#else>class="concept status-button-disabled"</#if>>REACTIVATE</a>
                        </div>
                        <div class="cs-buttons">
                            <a id="form_astatus" href="javascript:void(0);" <#if projectActivateStatus?? && projectActivateStatus==2>class="concept-activated"<#else>class="concept status-button-disabled"</#if>>CANCEL PROJECT</a>
                        </div>

                        <#if isAdmin>
                            <div class="cs-buttons">
                                <a id="form_astatus" href="javascript:void(0);" <#if projectActivateStatus?? && projectActivateStatus==3>class="concept-activated"<#else>class="concept status-button-disabled"</#if>>DELETE</a>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>

            <input type="hidden" name="projectID" value="${projectID?c}">
            <input type="hidden" name="projectActivateStatus" id="projectActivateStatus" value="${projectActivateStatus?default('')}" />
        </form>
    </div>
</div>
