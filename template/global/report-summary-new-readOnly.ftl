
<form name="report-summary-form" action="/new-synchro/report-summary!execute.jspa" method="POST"  id="report-summary-form" class="research_pib pib" >
<div class="research_content">
<input type="hidden" name="projectID" value="${projectID?c}">
<input type="hidden" name="isSave" value="${save?string}">
  <#assign  synchroPermHelper = statics['com.grail.synchro.util.SynchroPermHelper']/>


 <#assign methodologyProperties = statics['com.grail.synchro.SynchroGlobal'].getMethodologyProperties() />
	 <#assign methException ="" /> 
	 <#assign counter =0 />
	 <#list project.methodologyDetails as md>
	 <#if counter==0>
		 <#if methodologyProperties.get(md?int).isRepSummaryException() >
			 <#assign methException ="yes" /> 
		 </#if>
	</#if>
	<#assign counter = counter + 1 />
	 </#list>
	 

  
<div class="pib_inner_main">

<#-- Report Summary Code Starts  -->

<#if methException=="yes">
	<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId()) && proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus == 1)>
		<p><i>Please attach the following reports for this study. If the reports are not required, please select ‘This project does not require Report/ IRIS Summary'</i></p>
	<#else>
		<p><i>Please attach the following reports for this study. If the reports are not required, please select ‘This project does not require Report/ IRIS Summary'</i></p>
	</#if>
	
<#else>
	<p><i>Please attach the following reports for this study.</i></p>
</#if>

<div class="table report-summary-table">
	<div class="tr table-header">
		<div class="th">Report Type</div>
		<div class="th">Legal Approval Provided By</div>
		<div class="th">Attach Report </div>
	</div>
	
	<#assign hasReportAttachment  = "yes" />
	<#assign hasIRISAttachment = "yes" />
	<#assign hasTPDAttachment = "yes" />
	
	<#if reportSummaryDetailsList?? && reportSummaryDetailsList?size gt 0 >
		<#assign reportTypeCounter = 0 />
		<#assign irisCounter = 0 />
		<#assign tpdCounter = 0 />
		
		<#list reportSummaryDetailsList as reportSummaryDetails>
			<#assign reportTypeLegalApproverName =""/>
			<#assign irisLegalApproverName =""/>
			<#assign tpdLegalApproverName =""/>
			
			<#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT.getId()>
				<#if reportSummaryDetails.getLegalApprover()??>
					<#assign reportTypeLegalApproverName = reportSummaryDetails.getLegalApprover()/>
				<#else>
					<#assign reportTypeLegalApproverName = ""/>
				</#if>
				<#assign reportTypeCounter =  reportTypeCounter + 1/>
			<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TOP_LINE_REPORT.getId()>
				<#assign reportTypeLegalApproverName = reportSummaryDetails.getLegalApprover()/>
				<#assign reportTypeCounter =  reportTypeCounter + 1/>
			<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].EXECUTIVE_PRESENTATION.getId()>
				<#assign reportTypeLegalApproverName = reportSummaryDetails.getLegalApprover()/>
				<#assign reportTypeCounter =  reportTypeCounter + 1/>
			<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT_BLANK.getId()>
				<#if reportSummaryDetails.getLegalApprover()??>
					<#assign reportTypeLegalApproverName = reportSummaryDetails.getLegalApprover()/>
				<#else>
					<#assign reportTypeLegalApproverName = ""/>
				</#if>
				<#assign reportTypeCounter =  reportTypeCounter + 1/>
			<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].IRIS_SUMMARY.getId()>
				<#if reportSummaryDetails.getLegalApprover()??>
					<#assign irisLegalApproverName = reportSummaryDetails.getLegalApprover()/>
				<#else>
					<#assign reportTypeLegalApproverName = ""/>
				</#if>	
				<#assign irisCounter =  irisCounter + 1/>
			<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TPD_SUMMARY.getId()>
				<#if reportSummaryDetails.getLegalApprover()??>
					<#assign tpdLegalApproverName = reportSummaryDetails.getLegalApprover()/>
				<#else>
					<#assign reportTypeLegalApproverName = ""/>
				</#if>	
				<#assign tpdCounter =  tpdCounter + 1/>
			</#if>
			
			<#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT.getId() || reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TOP_LINE_REPORT.getId() || reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].EXECUTIVE_PRESENTATION.getId() || reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT_BLANK.getId()>
			<div class="tr" id="mainReportTypeDiv">
				<#if  reportTypeCounter gt 1>
					<div class="td dynamic-row">
				<#else>
					<div class="td">
				</#if>
					<#if  reportTypeCounter gt 1>
						<select name="reportTypes" id="reportType" disabled data-placeholder="Select Report Type" class="chosen-select form-select rt report-type-attach" >
					<#else>
						
						<select name="reportType" id="reportType" data-placeholder="Select Report Type" disabled class="chosen-select form-select report-type-attach" >
						
					</#if>
					
					<option value=""></option>
					<option value="1" <#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT.getId()> selected </#if>>Full Report</option>
					<option value="2" <#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TOP_LINE_REPORT.getId()> selected </#if>>Top Line Report</option>
					<option value="3" <#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].EXECUTIVE_PRESENTATION.getId()> selected </#if>>Executive Presentation</option>
					
					</select>
					<span class="jive-error-message full-width" id="reportTyperError" style="display:none">Please Select Report Type</span>
				</div>
			
				<div class="td" id="legalApproverDiv">
					<#if  reportTypeCounter gt 1>
						<input type="text" name="reportTypeLegalApprovers" id="reportTypeLegalApprover" disabled placeholder="Add Legal Approver Name" value="${reportTypeLegalApproverName}" />
					<#else>
						<input type="text" name="reportTypeLegalApprover" id="reportTypeLegalApprover" disabled placeholder="Add Legal Approver Name" value="${reportTypeLegalApproverName}" />
						<span class="jive-error-message full-width" id="reportTypeLegalApproverError" style="display:none">Please Enter Legal Approver</span>
					</#if>
					
				</div>
					<div class="td" id="attachmentDiv"><span class="jive-icon-med jive-icon-attachment j-link" ></span>
						<#assign attachIds =""	/>
						<#if attachmentMap?? && attachmentMap.get(fullReportID)?? >
							<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
							<div id="jive-file-list" class="jive-attachments">
							
						
							 	<#list attachmentMap.get(fullReportID) as attachment>
									<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
									<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
										<span class="jive-icon-med jive-icon-attachment"></span>
										
										<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
										${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
									<#--	<#assign hasReportAttachment  = "yes" />-->
										
										<#assign attachIds = attachIds+","+attachment.ID?c />
	
									</div>
									</#if>
									
								</#list>
								
								
							</div>
						</#if>
						
						<#if attachIds!="">
						<#else>
							<#assign hasReportAttachment  = "no" />
						</#if>	
					<#if  reportTypeCounter gt 1>
						<input type="hidden" name="reportTypeAttachments" id="reportTypeAttachment" value="${attachIds}" />
					<#else>
						<input type="hidden" name="reportTypeAttachment" id="reportTypeAttachment" value="${attachIds}" />
					</#if>
						
						</#if>
						
						
				
					</div>
				</div>
			</#if>
			
			<#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].IRIS_SUMMARY.getId()>
		
		<div class="tr" id="mainIrisSummaryTypeDiv">
			
			<#if  irisCounter gt 1>
				<div class="td dynamic-row">IRIS Summary </div>
			
				<div class="td"><input type="text" name="irisSummaryLegalApprovers" disabled id="irisSummaryLegalApprover" placeholder="Add Legal Approver Name" value="${irisLegalApproverName}" /></div>
			<#else>
				<div class="td">IRIS Summary <div class="download-link-wrapper"><div class="standard-report-download-link" >
				  <a href="<@s.url value="/file/download/IRIS-Summary-Template_09.11.2018.xlsm"/>"></a>
			 </div><p class="induction_text">Download Template for IRIS Summary</p></div></div>
			
				<div class="td">
				<input type="text" name="irisSummaryLegalApprover" id="irisSummaryLegalApprover" disabled placeholder="Add Legal Approver Name" value="${irisLegalApproverName}" />
				<span class="jive-error-message full-width" id="irisSummaryLegalApproverError" style="display:none">Please Enter Legal Approver</span>
				</div>
			</#if>
			<#assign irisAttachIds =""	/>
			<div class="td"><span class="jive-icon-med jive-icon-attachment j-link" ></span>
				
				
				<#if attachmentMap?? && attachmentMap.get(irisSummaryReportID)?? >
					<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
					<div id="jive-file-list" class="jive-attachments">
					
					
						<#list attachmentMap.get(irisSummaryReportID) as attachment>
							<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
							<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
								<span class="jive-icon-med jive-icon-attachment"></span>
								
								<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
								${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
								
								<#assign irisAttachIds = irisAttachIds+","+attachment.ID?c />
								
								<#--<#assign hasIRISAttachment = "yes" />-->

							</div>
							</#if>
						</#list>
					</div>
					</#if>
				</#if>
				
				<#if irisAttachIds!="">
					<#else>
						<#assign hasIRISAttachment  = "no" />
				</#if>	

				<#if  irisCounter gt 1>
					<input type="hidden" name="irisAttachments" id="irisAttachment" value="${irisAttachIds}" />
				<#else>
					<input type="hidden" name="irisAttachment" id="irisAttachment" value="${irisAttachIds}" />
				</#if>
						
			
				
				
			</div>
		</div>
		</#if>
		
		<#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TPD_SUMMARY.getId() && ((project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId()) && proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus == 1))  || ((project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId()) && project?? && project.globalOutcomeEUShare?? && project.globalOutcomeEUShare==1 && proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && proposalInitiation.legalApprovalStatus == 1)))>
		<div class="tr" id="mainTPDSummaryTypeDiv">
			
			<#if tpdCounter gt 1>
				<div class="td dynamic-row">TPD Summary </div>
				<div class="td"><input type="text" name="tpdSummaryLegalApprovers" id="tpdSummaryLegalApprover" disabled placeholder="Add Legal Approver Name" value="${tpdLegalApproverName}" />
			<#else>
				<div class="td">TPD Summary </div>
				<div class="td"><input type="text" name="tpdSummaryLegalApprover" id="tpdSummaryLegalApprover" disabled placeholder="Add Legal Approver Name" value="${tpdLegalApproverName}" />
				<span class="jive-error-message full-width" id="tpdSummaryLegalApproverError" style="display:none">Please Enter Legal Approver</span>
			</#if>	
			<div>
			
			<#assign tdpAttachIds =""	/>
			
			<#if tpdCounter gt 1 >
				<#if reportSummaryDetails.getLegalApprovalDate()??>
					<input type="text" disabled id="tpdSummaryDate" name="tpdSummaryDate" value="${reportSummaryDetails.getLegalApprovalDate()?string('dd/MM/yyyy')}">
				<#else>
					<input type="text" disabled  id="tpdSummaryDate" name="tpdSummaryDate" value="">
				</#if>
				
				
				
			<#else>
				
				
				<#if reportSummaryDetails.getLegalApprovalDate()??>
					<input type="text" disabled id="tpdSummaryDate" name="tpdSummaryDate" value="${reportSummaryDetails.getLegalApprovalDate()?string('dd/MM/yyyy')}">
				<#else>
					<input type="text" disabled  id="tpdSummaryDate" name="tpdSummaryDate" value="">
				</#if>
		
				
    
			</#if>
			<span class="jive-error-message full-width" id="tpdSummaryDateError" style="display:none">Please Enter Legal Approver Date</span>
			
			</div>
			</div>
			<div class="td"><span class="jive-icon-med jive-icon-attachment j-link"  ></span>
			
			<#if attachmentMap?? && attachmentMap.get(tpdSummaryReportID)?? >
				<#if reportSummaryAttachments?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType())?? && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?? >
				<div id="jive-file-list" class="jive-attachments">
				
				
					<#list attachmentMap.get(tpdSummaryReportID) as attachment>
						<#if reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?is_sequence && reportSummaryAttachments.get(reportSummaryDetails.getReportType()).get(reportSummaryDetails.getReportOrderId())?seq_contains(attachment.ID)>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
							
	
						<#--	<#assign hasTPDAttachment = "yes" />-->
							
							<#assign tdpAttachIds = tdpAttachIds+","+attachment.ID?c />
						</div>
						</#if>
						
					</#list>
				</div>
				</#if>
			</#if>
			
			<#if tdpAttachIds!="">
			<#else>
				<#assign hasTPDAttachment  = "no" />
			</#if>
			
			<#if  tpdCounter gt 1>
				<input type="hidden" name="tpdAttachments" id="tpdAttachment" value="${tdpAttachIds}" />
			<#else>
				<input type="hidden" name="tpdAttachment" id="tpdAttachment" value="${tdpAttachIds}" />
			</#if>
					
			
			</div>
		</div>
		</#if>
		</#list>
		
		
		<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
			<div class="tr" id="mainTPDSummaryTypeDiv" style="display:none">
			
		<#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId()) && proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus == 1)>
		
		<#else>
			<div class="tr" id="mainTPDSummaryTypeDiv" style="display:none">
		
		</#if>
		
	<#else>	
		<div class="tr" id="mainReportTypeDiv">
			<div class="td">
				<select name="reportType" id="reportType" disabled data-placeholder="Select Report Type" class="chosen-select form-select report-type-attach" >
				
				<option value=""></option>
				<option value="1">Full Report</option>
				<option value="2">Top Line Report</option>
				<option value="3">Executive Presentation</option>
				
				</select>
				<span class="jive-error-message full-width" id="reportTyperError" style="display:none">Please Select Report Type</span>
			</div>
			
			<div class="td" id="legalApproverDiv">
				<input type="text" name="reportTypeLegalApprover" id="reportTypeLegalApprover" disabled placeholder="Add Legal Approver Name" value="" />
				<span class="jive-error-message full-width" id="reportTypeLegalApproverError" style="display:none">Please Enter Legal Approver</span>
			</div>
			<div class="td" id="attachmentDiv"><span class="jive-icon-med jive-icon-attachment j-link" ></span>
			
			<#assign attachIds = ""/>
			<#if attachmentMap?? && attachmentMap.get(fullReportID)?? >
				<div id="jive-file-list" class="jive-attachments">
			
					<#list attachmentMap.get(fullReportID) as attachment>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
							
						<#--<#assign hasReportAttachment  = "yes" />-->
							<#assign attachIds = attachIds+","+attachment.ID />	
						</div>
					</#list>
				</div>
				
				
				
			</#if>
			
			<#if attachIds!="">
			<#else>
				<#assign hasReportAttachment  = "no" />
			</#if>
			
			<#--<input type="button" value="Remove" class="remove" id="removeLink"> -->
			</div>
			
		</div>
		<div class="tr" id="mainIrisSummaryTypeDiv">
			<div class="td">IRIS Summary <div class="download-link-wrapper"><div class="standard-report-download-link" >
				  <a href="<@s.url value="/file/download/IRIS-Summary-Template_09.11.2018.xlsm"/>"></a>
			 </div><p class="induction_text">Download Template for IRIS Summary</p></div></div>
			<div class="td">
				<input type="text" name="irisSummaryLegalApprover" id="irisSummaryLegalApprover" disabled placeholder="Add Legal Approver Name" value="" />
				<span class="jive-error-message full-width" id="irisSummaryLegalApproverError" style="display:none">Please Enter Legal Approver</span>
			</div>
			<div class="td"><span class="jive-icon-med jive-icon-attachment j-link" ></span>
			
			<#assign irisAttachIds = "" />	
			
			<#if attachmentMap?? && attachmentMap.get(irisSummaryReportID)?? >
				<div id="jive-file-list" class="jive-attachments">
					<#list attachmentMap.get(irisSummaryReportID) as attachment>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
							
							<#--<#assign hasIRISAttachment = "yes" />-->
							<#assign irisAttachIds = irisAttachIds+","+attachment.ID />	
						</div>
					</#list>
				</div>
			</#if>
			
			<#if irisAttachIds!="">
			<#else>
				<#assign hasIRISAttachment  = "no" />
			</#if>
			<#--<input type="button" value="Remove" class="remove">-->
			</div>
		</div>
		<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId())>
			<div class="tr" id="mainTPDSummaryTypeDiv" style="display:none">
		<#elseif project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId()) && proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus == 1)>
			<div class="tr" id="mainTPDSummaryTypeDiv" >
		<#else>
			<div class="tr" id="mainTPDSummaryTypeDiv" style="display:none">
		</#if>
		
			<div class="td">TPD Summary </div>
			<div class="td"><input type="text" placeholder="Add Legal Approver Name" disabled name="tpdSummaryLegalApprover" id="tpdSummaryLegalApprover" value="" />
			<span class="jive-error-message full-width" id="tpdSummaryLegalApproverError" style="display:none">Please Enter Legal Approver</span>
			<div><input type="text" disabled  id="tpdSummaryDate" name="tpdSummaryDate" value="">
				
			<span class="jive-error-message full-width" id="tpdSummaryDateError" style="display:none">Please Enter Legal Approver Date</span>

			</div>
			</div>
			<div class="td"><span class="jive-icon-med jive-icon-attachment j-link" ></span>
			
			<#assign tpdAttachIds = "" />
			
			<#if attachmentMap?? && attachmentMap.get(tpdSummaryReportID)?? >
				<div id="jive-file-list" class="jive-attachments">
					<#list attachmentMap.get(tpdSummaryReportID) as attachment>
						<div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
							<span class="jive-icon-med jive-icon-attachment"></span>
							
							<a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
							${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
							
							<#--<#assign hasTPDAttachment = "yes" />-->
							<#assign tpdAttachIds = tpdAttachIds+","+attachment.ID />	
						</div>
					</#list>
				</div>
			</#if>
			
			<#if tpdAttachIds!="">
			<#else>
				<#assign hasTPDAttachment  = "no" />
			</#if>
			<#--<input type="button" value="Remove" class="remove">-->
			</div>
		</div>
	</#if>
	</div>
	
	
	 <#if methException == "yes">
		
		<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_EU_OFFLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_ONLINE.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_EU_OFFLINE.getId()) && proposalInitiation?? && proposalInitiation.legalApprovalStatus?? && (proposalInitiation.legalApprovalStatus == 1)>
		
			<div class="legal-checkbox" id="legal-checkbox"><input type="checkbox" disabled name="legalsignoffreq" <#if reportSummaryInitiation?? && reportSummaryInitiation.legalSignOffRequired?? && reportSummaryInitiation.legalSignOffRequired==1> checked="true"</#if>  id="legalsignoffreq" >This project does not require Report/IRIS Summary.</div>
			<div class="legal-checkbox" id="legal-checkbox">Note: Selecting the box will not cease the option to upload any report. If you wish to upload any report(s) you can still make an attachment.</div>
			<input type="hidden" id="legalSignOffReqValue" name="legalSignOffReqValue" value="" />
		
		<#else>
			<div class="legal-checkbox" id="legal-checkbox"><input type="checkbox"  disabled name="legalsignoffreq" <#if reportSummaryInitiation?? && reportSummaryInitiation.legalSignOffRequired?? && reportSummaryInitiation.legalSignOffRequired==1> checked="true"</#if>  id="legalsignoffreq" >This project does not require Report/IRIS Summary.</div>
			<input type="hidden" id="legalSignOffReqValue" name="legalSignOffReqValue" value="" />
		</#if>	
			
	 </#if>
<#-- Report Summary Code ends -->

</div>



    <#assign synchroUtils = jiveContext.getSpringBean("synchroUtils") />

<script type="text/javascript">
    var attachmentWindow = null;
    $j(document).ready(function(){
        attachmentWindow = new SYNCHRO_FIELD_ATTACHMENT_POPUP({
            formUrl:"<@s.url value='/new-synchro/report-summary!addAttachment.jspa'/>",
            projectID:${projectID?c},
            endMarketID:${endMarketId?c},
            parentForm:$j("#report-summary-form"),
            items:[
                {id:${bussinessQuestionID?c},name:'Business Question'},
                {id:${researchObjectiveID?c},name:'Research Objective(s)'},
                {id:${actionStandardID?c},name:'Action Standard(s)'},
                {id:${researchDesignID?c},name:'Methodology Approach and Research design'},
                {id:${sampleProfileID?c},name:'Sample Profile (Research)'},
                {id:${stimulusMaterialID?c},name:'Stimulus Material'},
                {id:${otherReportingRequirementID?c},name:'Other Reporting Requirements'},
                {id:${othersID?c},name:'Other Comments'}
            ]

        });

        $j("#fileAttachBtn").bind('click',function(){
            attachmentWindow.show();
        });
    });

    function showAttachmentPopup(fieldId) {
      
		attachmentWindow.show(fieldId);
    }
	function showAttachmentPopupNew(fieldId, reportType, reportOrderId) {
      	
		
		
		/*
		var reportTypeLegalApprover = $j("input[name=reportTypeLegalApprover]");
		var reportTypeLegalApprovers = $j("input[name=reportTypeLegalApprovers]");
		
		*/
		var reportSummaryForm = $j("#report-summary-form");
		
		attachmentWindow.show(fieldId,'TITLE', reportType, reportOrderId);
    }
	function showAttachmentPopupNewReport(fieldId, curr, reportOrderId) {
		var reportType = $j(curr).parent().parent().find(".report-type-attach").val();
		
		if(reportType!=null && reportType!="")
		{
			attachmentWindow.show(fieldId,'TITLE', reportType, reportOrderId);
		}
		else{
			attachmentWindow.show(fieldId,'TITLE', 0, reportOrderId);
		}
	}
	
</script>


 


<script type="text/javascript">
    var initiateKantarWaiverWindow = null;
    $j(document).ready(function(){
    <#--   initiateKantarWaiverWindow = new LIGHT_BOX($j("#initiateKantarWaiver"),{title:'Request for Agency Waiver',confirmOnClose:false});
-->        FORM_DATA_PERSIST_HANDLER.handle({parentForm:$j("#report-summary-form"),form:$j("#kantar-waiver-form"), projectID:${projectID?c}});
    });

</script>





<div class="buttons">
  

    
        
        <br>
        <input type="hidden" id="confirmProject" name="confirmProject" value="" />
		<#--<input type="submit" name="save pib" onclick="return validatePIBFormFields();" value="Save" class="save"/>
		<input type="button" name="save pib" onclick="return continueProject();" value="Proceed to Project Evaluation" class="save continue"/>-->
		<a href="javascript:void(0);" style="margin-left: 10px;"  class="publish-details disabled">Save</a>	
		<a href="javascript:void(0);" style="margin-left: 10px;"  class="publish-details disabled">Proceed to Project Evaluation</a>	
   
  
	
	<#assign emptyLegalApprover ="no" />
		<#list reportSummaryDetailsList as reportSummaryDetails>
		<#if reportSummaryDetails.getLegalApprover()?? && !reportSummaryDetails.getLegalApprover().equals("") >
			<#if reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].TPD_SUMMARY.getId()>
				<#if project.processType?? && project.processType !=  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() &&  project.processType !=  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId()>
					<#if reportSummaryDetails.getLegalApprovalDate()?? >
					<#else>
					<#assign emptyLegalApprover ="yes" />
					</#if>
				</#if>
			<#elseif reportSummaryDetails.getReportType()==statics['com.grail.synchro.SynchroGlobal$ReportType'].FULL_REPORT_BLANK.getId()>	
				<#assign emptyLegalApprover ="yes" />
			</#if>
		<#else>
			<#assign emptyLegalApprover ="yes" />
		</#if>
		</#list>
	<script>
		$j(document).ready(function() {
			
			<#if methException == "yes">
			var legalSignOffRequired=$j("#legalsignoffreq").prop("checked");
			if(legalSignOffRequired)
			{	
				$j('#confirmProjectEnable').removeClass("disabled");
				//$j('#legalsignoffreq').attr("disabled", true);
			}
			else
			{	
				
				
				<#if reportSummaryDetailsList?? && reportSummaryDetailsList?size gt 0 && hasReportAttachment=="yes" && hasIRISAttachment=="yes" && hasTPDAttachment=="yes">
				
					<#if emptyLegalApprover=="yes">
						$j('#confirmProjectEnable').addClass("disabled");
						
					<#else>
						$j('#confirmProjectEnable').removeClass("disabled");
						//$j('#legalsignoffreq').attr("disabled", true);
					</#if>
					
				<#else>
					<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId()) && reportSummaryDetailsList?? && reportSummaryDetailsList?size gt 0 && hasReportAttachment=="yes" && hasIRISAttachment=="yes">
					$j('#confirmProjectEnable').removeClass("disabled");
					//$j('#legalsignoffreq').attr("disabled", true);
				<#else>
					$j('#confirmProjectEnable').addClass("disabled");
					
				</#if>
				
				</#if>
				
				
			}
			<#elseif reportSummaryDetailsList?? && reportSummaryDetailsList?size gt 0 && hasReportAttachment=="yes" && hasIRISAttachment=="yes" && hasTPDAttachment=="yes">
				
					
					<#if emptyLegalApprover=="yes">
					
						$j('#confirmProjectEnable').addClass("disabled");
					<#else>
					
						$j('#confirmProjectEnable').removeClass("disabled");
						//$j('#legalsignoffreq').attr("disabled", true);
					</#if>
			<#else>
				<#if project.processType?? && (project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].END_MARKET_NON_EU.getId() || project.processType ==  statics['com.grail.synchro.SynchroGlobal$ProjectProcessType'].GLOBAL_NON_EU.getId()) && reportSummaryDetailsList?? && reportSummaryDetailsList?size gt 0 && hasReportAttachment=="yes" && hasIRISAttachment=="yes" >
					$j('#confirmProjectEnable').removeClass("disabled");
					//$j('#legalsignoffreq').attr("disabled", true);
				<#else>
					$j('#confirmProjectEnable').addClass("disabled");
				</#if>
				
			</#if>
	});
	
	$j(document).ready(function() {
		 var brandSpecificStudy = $j('select[name="brandSpecificStudy"] option:selected').val();
		 if(brandSpecificStudy=="2")
		 {
			$j("#brandSpecificStudyType").show();
			if($j('select[name="brandSpecificStudyType"] option:selected').val()=="1")
            {
                $j("#MultibrandTextDiv").show();
            }
			$j("#brandSpecific").hide();
		 }
		 if(brandSpecificStudy=="1")
		 {
			  $j("#brandSpecific").show();
			  $j("#brandSpecificStudyType").hide();
		 }
	});
	
	</script>
</div>

</div>
</div>



	

</form>

  
  
  
