<div class="container-sub">
    <div class="project_view">
        <div class="project_dashboard_header">
            <div style="padding-bottom: 10px;"><a href="<@s.url value="/synchro/project-reminders!input.jspa"/>">Go Back</a></div>
            <div id="table-main">
                <table id="standard-report-table" class="project_status_table table-sorter project-reminder">
                    <thead>
                    <tr>
                        <th id="project-code-header" class="header project-code-header"><span id="projectCode">Project<br/>Code</span></th>
                        <th id="project-name-header" class="header"><span id="projectName">Project Name</span></th>
                        <th id="spi-contact-header" class="header"><span id="spiContact">SP&I Contact</span></th>
                        <th id="pending-activity-type-header" class="header "><span id="pendingActivityTYpe">Pending Activity Type</span></th>
                        <th id="pending-activity-link-header" class="header pending-activity-link-header"><span id="pendingActivityLink">Pending Activity Link</span></th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if projectWaivers?? && projectWaivers?size &gt;0>
                    <tr><td colspan='5' class="row-header">${statics['com.grail.synchro.SynchroGlobal$ProjectReminderCategoryType'].WAIVERS.getName()}</td></tr>
                        <#list projectWaivers as projectWaiver>
                        <tr <#if (projectWaiver_index % 2) == 0> class="last"</#if>>
                            <#assign waiverLink = "synchro/project-waiver!input.jspa?projectWaiverID="+projectWaiver.waiverID/>
                            <td><a href="${waiverLink}">${generateProjectCode(projectWaiver.waiverID?c)}</a></td>
                            <td>${projectWaiver.name}</td>
                            <#assign spiName = "">
                            <#if projectWaiver.approverID??>
                                <#assign user = jiveContext.userManager.getUser(projectWaiver.approverID?c) />
                                <#assign spiName = user.name>
                            </#if>
                            <td>${spiName}</td>
                            <td>Process Waiver Approval Pending</td>
                            <td><a href="${waiverLink}">${waiverLink}</a></td>
                        </tr>
                        </#list>
                    </#if>
                    <#if draftProjects?? && draftProjects?size &gt; 0>
                    <tr><td colspan='5' class="row-header">${statics['com.grail.synchro.SynchroGlobal$ProjectReminderCategoryType'].DRAFT_PROJECT.getName()}</td></tr>
                        <#list draftProjects as draftProject>
                            <#assign draftLink = statics['com.grail.synchro.beans.ProjectStage'].generateURL(draftProject,statics['com.grail.synchro.beans.ProjectStage'].getCurrentStageNumber(draftProject))/>
                        <tr <#if (draftProject_index % 2) == 0> class="last"</#if>>
                            <td><a href="${draftLink}">${generateProjectCode(draftProject.projectID?c)}</a></td>
                            <td>${draftProject.name}</td>
                            <#assign spiName = "">
                            <#if draftProject.spiContact?? && draftProject.spiContact?size &gt; 0>
                                <#assign user = jiveContext.userManager.getUser(draftProject.spiContact.get(0)) />
                                <#assign spiName = user.name>
                            </#if>
                            <td>${spiName}</td>
                            <td>Draft (PIT) -<br/>Start Project Pending</td>
                            <td><a href="${draftLink}">${draftLink}</a></td>
                        </tr>
                        </#list>
                    </#if>
                    <#if projectPendingActivities?? && projectPendingActivities?size &gt;0>
                    <tr><td colspan='5' class="row-header">${statics['com.grail.synchro.SynchroGlobal$ProjectReminderCategoryType'].PROJECT_PENDING_ACTIVITY.getName()}</td></tr>
                        <#list projectPendingActivities as projectPendingActivity>
                        <tr <#if (projectPendingActivity_index % 2) == 0> class="last"</#if>>
                            <#assign projectPendingActivityLink = projectPendingActivity.getActivityLink()/>
                            <td><a href="${projectPendingActivityLink}">${generateProjectCode(projectPendingActivity.projectID?c)}</a></td>
                            <td>${projectPendingActivity.projectName}</td>
                            <#assign spiName = "">
                            <#assign project = jiveContext.getSpringBean("synchroProjectManager").get(projectPendingActivity.projectID) />
                            <#if project??>
                                <#if project.spiContact?? && project.spiContact?size &gt; 0>
                                    <#assign user = jiveContext.userManager.getUser(project.spiContact.get(0)) />
                                    <#assign spiName = user.name>
                                </#if>
                            </#if>
                            <td>${spiName}</td>
                            <td>${projectPendingActivity.pendingActivity}</td>
                            <td><a href="${projectPendingActivityLink}">${projectPendingActivityLink}</a></td>
                        </tr>
                        </#list>
                    </#if>

                    <#if grailBriefTemplates?? && grailBriefTemplates?size &gt;0>
                    <tr><td colspan='5' class="row-header">${statics['com.grail.synchro.SynchroGlobal$ProjectReminderCategoryType'].GRAIL_PENDING_ACTIVITY.getName()}</td></tr>
                        <#list grailBriefTemplates as grailBriefTemplate>
                        <tr <#if (grailBriefTemplate_index % 2) == 0> class="last"</#if>>
                            <#assign grailBriefLink = "/grail/brief-template!input.jspa?id="+grailBriefTemplate.id/>
                            <td><a href="${grailBriefLink}">${generateProjectCode(grailBriefTemplate.id?c, "G")}</a></td>
                            <td>Grail Brief</td>
                            <#assign spiName = "">
                            <#if grailBriefTemplate.batContact?? && grailBriefTemplate.batContact &gt;  0>
                                <#assign user = jiveContext.userManager.getUser(grailBriefTemplate.batContact) />
                                <#assign spiName = user.name>
                            </#if>
                            <td>${spiName}</td>
                            <td>In Progress-Cost Pending</td>
                            <td><a href="${grailBriefLink}">${grailBriefLink}</a></td>
                        </tr>
                        </#list>
                    </#if>
                    <#if kantarBriefTemplates?? && kantarBriefTemplates?size &gt;0>
                    <tr><td colspan='5' class="row-header">${statics['com.grail.synchro.SynchroGlobal$ProjectReminderCategoryType'].KANTAR_PENDING_ACTIVITY.getName()}</td></tr>
                        <#list kantarBriefTemplates as kantarBriefTemplate>
                        <tr <#if (kantarBriefTemplate_index % 2) == 0> class="last"</#if>>
                            <#assign kantarBriefLink = "/kantar/brief-template!input.jspa?id="+kantarBriefTemplate.id/>
                            <td><a href="${kantarBriefLink}">${generateProjectCode(kantarBriefTemplate.id?c, "K")}</a></td>
                            <td>Kantar Brief</td>
                            <#assign spiName = "">
                            <#if kantarBriefTemplate.batContact?? && kantarBriefTemplate.batContact &gt;  0>
                                <#assign user = jiveContext.userManager.getUser(kantarBriefTemplate.batContact) />
                                <#assign spiName = user.name>
                            </#if>
                            <td>${spiName}</td>
                            <td>In Progress-Cost Pending</td>
                            <td><a href="${kantarBriefLink}">${kantarBriefLink}</a></td>
                        </tr>
                        </#list>
                    </#if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div id="overlay">
    <img src="${themePath}/images/bigrotation.gif" id="img-load" />
</div>

<#function generateProjectCode projectID prepend='' maxDigits=5>
    <#if projectID?? && (projectID?number>0) >
        <#local length = (projectID?string)?length />
        <#local prependLen = (maxDigits - length) />
        <#if (length<maxDigits) >
            <#list 1..prependLen as x>
                <#local prepend = prepend + '0' />
            </#list>
        </#if>
        <#return (prepend + projectID?string)>
    </#if>
    <#return ''>
</#function>