<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<head>
	<script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>
	<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
	<script src="${themePath}/js/synchro/waiver.js" type="text/javascript"></script>
	<script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>
	<script type="text/javascript" src="${themePath}/js/scripts/multifile.js"></script>

</head>
<!-- Include Macro files -->
<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/form-message.ftl" />

<div class="container">
	<div class="project_names">
		<div class="project_name_div">
			<h2><@s.text name="waiver.initiate.heading"/></h2>			
				<div id="jive-error-box" class="jive-error-box" style="display:none">
					<div>     
						<span><@s.text name="project.mandatory.error"/></span>
					</div>
				</div>
				<form action="<@s.url action='create-waiver!execute.jspa'/>" method="post" name="form-create" id="form-create" class="research_pib pib create_waiver" enctype="multipart/form-data">
					<div class="research_content">
					<div class="pib_inner_main">					
						<div class="form-text_div">
							<!-- Waiver Name -->
							<label><@s.text name="project.waiver.name"/></label>
							<input type="text" name="name" value="${projectWaiver.name?default('')}" size="30" maxlength="128" class="form-text" placeholder='<@s.text name="project.waiver.name"/>'>
							<#assign error_msg><@s.text name='project.error.name' /></#assign>
							<@macroCustomFieldErrors msg=error_msg />				
						</div>
						
						<div class="region-inner">
							<label class='rte-editor-label'><@s.text name="project.waiver.description"/></label>
								<div class="form-text_div">		
									<textarea name="summary" id="summary" cols="60" rows="5" class="form-textarea" placeholder="Waiver Description">${projectWaiver.summary?default('')?html}</textarea>
									<@macroCustomFieldErrors msg="Please enter the waiver summary"/>							
									<#assign error_msg><@s.text name='project.error.summary' /></#assign>
									<@macroCustomFieldErrors msg=error_msg />
								</div>	
								<textarea style="display:none;" id="summaryText" name="summaryText">${projectWaiver.summary?default('')?html}</textarea>						
						</div>					   

						<div class="region-inner">
							<!-- Waiver Brand -->
							<div class="form-select_div">
								<label><@s.text name="project.initiate.project.brand"/></label>				
								<@renderBrandField name='brand' value=projectWaiver.brand?default('-1')/>
								<#assign error_msg><@s.text name='project.error.brand' /></#assign>
								<@macroCustomFieldErrors msg=error_msg />
							</div>
							<!-- Waiver Methodology Type
							<div class="form-select_div_brand">
								<label><@s.text name="project.initiate.project.methodology"/></label>				
								<@renderMethodologyField name='methodology' value=projectWaiver.methodology?default('-1') />
								<#assign error_msg><@s.text name='project.error.methodology' /></#assign>
								<@macroCustomFieldErrors msg=error_msg />
							</div>
							-->
						</div>
						
						<div class="region-inner">
							 <!-- Waiver End Markets Multiselect -->
						   <label class="label_b"><@s.text name="waiver.initiate.endmarkets"/></label>
							<div class="form-select_div_main pit-category">
								<@showEndMarketFieldSection name='endMarkets' value=projectWaiver.endMarkets?default('-1') />
								<#assign error_msg><@s.text name='project.error.endmarket' /></#assign>
								<@macroCustomFieldErrors msg=error_msg />
							</div>
						</div>
						<#--
						<div class="region-inner">
							
							<div class="form-select_div">
								<label><@s.text name="waiver.initiate.preapprovals"/></label>
                                <div class="waiver-checkbox">
								<@renderWaiverPreApproval name='preApprovals' value=projectWaiver.preApprovals?default('-1') />
								<#assign error_msg><@s.text name='waiver.error.preapprovals' /></#assign>
								<@macroCustomFieldErrors msg=error_msg />
                                </div>
							</div>
							
							<div class="form-select_div pre-approval-waiver">
								<textarea name="preApprovalComment" id="preApprovalComment" cols="60" rows="5" class="form-textarea" placeholder="Pre-Approval Comments" onKeyDown="limitText(this.form.preApprovalComment,this.form.preApprovalCommentcountdown,900);"
										  onKeyUp="limitText(this.form.preApprovalComment,this.form.preApprovalCommentcountdown,900);">${projectWaiver.preApprovalComment?default('')?html}</textarea>
								<#assign error_msg><@s.text name='project.error.preapprovalcomment' /></#assign>
								<@macroCustomFieldErrors msg=error_msg />
								<div class="character-limit">You have <input readonly type="text" id="preApprovalCommentcountdown" name="preApprovalCommentcountdown" size="3" value="900"> characters left</div>
                               
                                <div class="field-attachments">
                                    <span class="jive-icon-med jive-icon-attachment j-link" onclick="showAttachmentPopup(${preApprovalCommentsID?c})" ></span>
                                <#if attachmentMap?? && attachmentMap.get(preApprovalCommentsID)?? >
                                    <div id="jive-file-list" class="jive-attachments">
                                        <#list attachmentMap.get(preApprovalCommentsID) as attachment>
                                            <div id="jive-attachment-${attachment.ID?c}" class="jive-attach-item">
                                                <span class="jive-icon-med jive-icon-attachment"></span>

                                                <#if attachmentUser?? && attachmentUser.get(attachment.ID)?? && attachmentUser.get(attachment.ID)==user.ID >
                                                    <a href="javascript:void(0);" class="j-remove-file font-color-meta" onclick="javascript:removeAttachment(${attachment.ID?c});"><@s.text name="global.remove" /></a>
                                                </#if>
                                                <a href="<@s.url value="/servlet/JiveServlet/download/${attachment.objectID?c}-${attachment.ID?c}/${attachment.name?url}" />" >
                                                ${attachment.name?html} (${statics['com.jivesoftware.util.ByteFormat'].getInstance().format(attachment.size)}) </a>
                                            </div>
                                        </#list>
                                    </div>
                                </#if>
                                </div>
                                
							</div>

						</div>
						-->
						<div class="region-inner">
							<!-- Waiver Nexus Number -->
							<div class="form-select_div">
								<div class="pit-estimate-cost">
									<label><@s.text name="waiver.initiate.nexus"/></label>						
									<input type="text" name="nexus" class="text_field numericfield" value="<#if projectWaiver?? && projectWaiver.nexus??>${projectWaiver.nexus?c}</#if>" />
									<@macroCustomFieldErrors msg='' class='numeric-error' />
								</div>                   
							</div>
						</div>
					
						<div class="region-inner">
							<!-- Waiver Select Approver -->
							<div class="form-select_div">
								<label style="width:auto;">Global Head of Marketing Research</label>				
								<@renderProcessWaiverApproverField name="approverID" value=projectWaiver.approverID?default(-1) id="approverID" />
								<#assign error_msg><@s.text name='waiver.error.approver' /></#assign>
								<@macroCustomFieldErrors msg=error_msg />
							</div>            
						</div>
						
						<!-- Pre Approvals -->
						<div id="waiver-preapprovals" class="region-inner">
							<div class="form-textarea_div">
								<div>
									<label><@s.text name="project.waiver.preapprovals"/><span>*</span></label><br/>
								</div>
								<div class="waiver-preapproval">
									<span>All projects will require pre approval by the following people in each market</span>
									<ul class="preapproval-list">
										<li>End Market Head of Brands/Marketing Director</li>										
										<li>Regional Marketing Manager</li>
									</ul>
								</div>
							</div>
						</div>
						
						<div id="waiver-attachments" class="region-inner">
							<div class="form-textarea_div">
								<@synchroWaiverAttachements attachments=attachments canAttach=true maxAttachCount=30 attachmentCount=attachmentCount  />
							</div>
						</div>
						
						<!-- Waiver Publish Button -->
						<div class="buttons">
							<a id="project_cancel_link" href="javascript:void(0);" class="waiver-cancel"><@s.text name="global.cancel"/></a>
							<a id="project_publish_link" href="javascript:void(0);" class="publish-details"><@s.text name="initiate.waiver.submit.label"/></a>
						</div>
						
						<input type="hidden" name="projectWaiverID" id="projectWaiverID" value="${projectWaiverID?default('')}" />									
						<@jive.token name="synchro.waiver.create" lazy=true />
					</div>
					</div>
					<!---  Side bar for Attach Files button --
					<div id="jive-body-sidebarcol-container" class="j-column j-column-s j-content-extras">
						<div class="right-side-bar">
							<ul class="right-sidebar-list">
								 <li><a  href="javascript:void(0);" id="fileAttachBtn">Attach Files</a></li>
							</ul>
						</div>					
					</div>
					-->
				</form>			
		</div>
	</div>
</div>
<script type="text/javascript">
/* Initialization of Editor */
$j(document).ready(function () {
	initiateRTE('summary', 2500, true);
});
</script>	