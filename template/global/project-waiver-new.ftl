<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<head>
	<script src="${themePath}/js/synchro/import-util.js" type="text/javascript"></script>
	<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>
	<script src="${themePath}/js/synchro/waiver-new.js?version=${JiveGlobals.getJiveProperty("grail.source.files.version","1.0.0")}" type="text/javascript"></script>
	<script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>
	<script type="text/javascript" src="${themePath}/js/scripts/multifile.js"></script>
</head>
<!-- Include Macro files -->
<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/error-macros.ftl" />
<style>
input[readonly="true"], textarea:disabled, input[disabled]
{
    background-color: rgb(241, 241, 241) !important;
	color: rgb(84, 84, 84) !important;
}
</style>

<#assign isAdminUser = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroAdmin(user) />
<#assign isSynchroSystemOwner = statics['com.grail.synchro.util.SynchroPermHelper'].isSynchroSystemOwner() />

<div class="project-initiate-container">
	<div class="dashboard-endmarket-back">
		<#--<a href="<@s.url value="/new-synchro/waiver-catalogue.jspa"/>">Go Back</a>-->
		<a href="<@s.url value="/new-synchro/process-waiver-dashboard.jspa"/>">Go Back</a>
		
		
	</div>
	
	<#if isAdminUser || isSynchroSystemOwner>
		<a class="cancel-project view-edit" href="/new-synchro/log-dashboard.jspa?waiverID=${projectWaiverID?c}" >View Logs</a>
	</#if>	
	
    <h3 style="padding-left:0px;"><@s.text name="project.waiver.approval"/></h3>
	<div id="jive-error-box" class="jive-error-box" style="display:none">
		<div>     
			<span><@s.text name="project.mandatory.error"/></span>
		</div>
	</div>
	
	<#if request.getParameter("approved")?? && request.getParameter("approved")=="true">
		<div id="waiver-success-box-approved" class="jive-success-box">
			<div>
				<span class="jive-icon-med jive-icon-check"></span>
					Waiver is Approved
				</div>
		</div>
	<#elseif request.getParameter("approved")?? && request.getParameter("approved")=="false">
		<div id="waiver-success-box-approved" class="jive-error-box">
			<div>
				<span class="jive-icon-med jive-icon-check"></span>
					Waiver is Rejected
				</div>
		</div>
	</#if>	
    <div class="project_details create_project">
        <div id="jive-error-box" class="jive-error-box" style="display:none">
            <div>     
                <span><@s.text name="project.mandatory.error"/></span>
            </div>
        </div>
        <form action="<@s.url action='project-waiver!submit.jspa'/>" method="post" name="form-create" id="form-create" class="research_pib pib project_waiver_form create_waiver" enctype="multipart/form-data">
		
			<div class="region-inner">
                <!-- Waiver ID -->
                <label><@s.text name="project.waiver.id"/></label>
                <input type="text" name="projectWaiverID1" value="<#if projectWaiverID??>${projectWaiverID?c}</#if>" size="15" class="form-text" disabled />
				<input type="hidden" name="projectWaiverID" value="<#if projectWaiverID??>${projectWaiverID?c}</#if>"/>
            </div>
			
            <div class="region-inner">
                <!-- Waiver Name -->
				
                <label><@s.text name="project.waiver.name"/></label>
				<div class="form-text_div">
                <input type="text"  name="name" value="${projectWaiver.name?default('')}"   placeholder='<@s.text name="project.waiver.name"/>'  onfocus="this.placeholder = ''"  onblur="this.placeholder = '<@s.text name="project.waiver.name"/>'"    size="30" maxlength="128" class="form-text" <#if !isAdminUser && !isSynchroSystemOwner> disabled</#if>   onchange="checkWaiverName();"/>
				<#assign error_msg>Please enter Waiver Name</#assign>
				<@macroCustomFieldErrors msg=error_msg />
				</div>				
            </div>
			
			<div class="region-inner text-editor_div">
				<label class='rte-editor-label-waiver'><@s.text name="project.waiver.description"/></label>
					<div class="form-text_div">		
						<textarea name="summary" id="summary" cols="60" rows="5" class="form-textarea" <#if !isAdminUser && !isSynchroSystemOwner>disabled</#if> placeholder="Waiver Description">${projectWaiver.summary?default('')?html}</textarea>
						<@macroCustomFieldErrors msg="Please enter the waiver summary"/>							
						<#assign error_msg><@s.text name='project.error.summary' /></#assign>
						<span class="textarea-error-message" id="textareaErrorMsg" style="display:none">Please enter Waiver Description</span>
						<!--<@macroCustomFieldErrors msg=error_msg /> -->
					</div>	
				<textarea style="display:none;" id="summaryText" name="summaryText">${projectWaiver.summary?default('')?html}</textarea>						
			</div>	
			
            <div class="region-inner">
                <!-- Waiver Brand -->
				
				<label>Brand/Non-brand</label>
                <div class="form-text_div selectWell__fix">
					
					<#if !isAdminUser && !isSynchroSystemOwner>
						<@renderBrandField name='brand' value=projectWaiver.brand?default('-1') readonly=true />
					<#else>
						<@renderBrandField name='brand' value=projectWaiver.brand?default('-1') readonly=false />
						<#assign error_msg><@s.text name='project.error.brand' /></#assign>
						<@macroCustomFieldErrors msg=error_msg />
					</#if>
					
                </div>
                <!-- Waiver Methodology Type 
                <div class="form-select_div_brand">
					<label><@s.text name="project.initiate.project.methodology"/></label>				
					<@renderMethodologyField name='methodology' value=projectWaiver.methodology?default('-1') readonly=true />					
                </div>
				-->
            
			</div>
			
			<div class="region-inner">
                 <!-- Waiver End Markets Multiselect -->
               <label class="label_b">Waiver End markets</label>
                <div class="pit-category form-text_div waiverSelect__fix">
				
				<#if !isAdminUser && !isSynchroSystemOwner>
					<div class="div_brand_user">
						 <@displayEndMarketField name='endMarkets' value=projectWaiver.endMarkets?default('-1') />     
					</div>			
				<#else>
					<@showEndMarketFieldSection name='endMarkets' value=projectWaiver.endMarkets?default('-1') />
					<#assign error_msg><@s.text name='project.error.endmarket' /></#assign>
					<@macroCustomFieldErrors msg=error_msg />
				</#if>					
                </div>
            </div>			
			
			<#--
			<div class="region-inner">
				
				<div class="form-text_div">
					<div class="pit-estimate-cost">
						<label><@s.text name="waiver.initiate.nexus"/></label>						
						<input type="text" name="nexus" class="text_field numericfield" value="<#if projectWaiver?? && projectWaiver.nexus??>${projectWaiver.nexus?c}</#if>" <#if !isAdminUser>readonly=true</#if> />
						<@macroCustomFieldErrors msg='' class='numeric-error' />
					</div>                   
				</div>
			</div>
		
			<div class="region-inner">
			
				<div class="form-select_div">
					<label style="width:auto;">Global Head of Marketing Research</label>
					<#if !isAdminUser && !isSynchroSystemOwner>
						<@renderProcessWaiverApproverField name="approverID" value=projectWaiver.approverID?default(-1) id="approverID" readonly=true />
					<#else>
						<@renderProcessWaiverApproverField name="approverID" value=projectWaiver.approverID?default(-1) id="approverID" readonly=false />
						<#assign error_msg><@s.text name='waiver.error.approver' /></#assign>
						<@macroCustomFieldErrors msg=error_msg />
					</#if>
					
				</div>            
			</div>
			-->
						
			<!-- Pre Approvals -->
			<#--<div id="waiver-preapprovals" class="region-inner">  
				<div class="form-textarea_div">
					<div>
					
						<label>Waiver Document</label>
					</div>
					<div class="waiver-preapproval">
						<span>All projects will require pre approval by the following people in each market</span>
						<ul class="preapproval-list">
							<li>End Market Head of Brands/Marketing Director</li>							
							<li>Regional Marketing Manager</li>
						</ul>
					</div>
				</div>
			</div>-->
			
			<div id="waiver-preapprovals" class="region-inner">
				
				
				
				
						<label>Waiver Document</label>
						
						<div id="waiver-attachments" class="form-text_div">
				
					<#if isAdminUser || isSynchroSystemOwner>
						<@synchroWaiverAttachements attachments=attachments canAttach=true maxAttachCount=30 attachmentCount=attachmentCount  />					
					<#else>
						<@synchroWaiverAttachements attachments=attachments canAttach=false maxAttachCount=30 attachmentCount=attachmentCount  />					
					</#if>
				
			</div>
						
				<#--	<div class="waiver-preapproval">
						<span>All projects will require pre approval by the following person in each market</span>
						<ul class="preapproval-list">
							<li>System Owner</li>										
						</ul>
					</div>  -->
				
			</div>
			
			
			
			
			<div id="waiver-preapprovals" class="region-inner">
				<div class="form-textarea_div">
						<label>Status</label><br/>
					<div class="waiver-preapproval status-report">
						<#if projectWaiver?? && projectWaiver.status?? && projectWaiver.status== statics['com.grail.synchro.SynchroGlobal$ProjectWaiverStatus'].PENDING_APPROVAL.value()>
							<sapn class="status-txt">Pending Approval</span>
						<#elseif projectWaiver?? && projectWaiver.status?? && projectWaiver.status== statics['com.grail.synchro.SynchroGlobal$ProjectWaiverStatus'].APPROVED.value()>
							<sapn class="status-txt">Approved</span>
						<#elseif projectWaiver?? && projectWaiver.status?? && projectWaiver.status== statics['com.grail.synchro.SynchroGlobal$ProjectWaiverStatus'].REJECTED.value()>	
							<sapn class="status-txt">Rejected</span>
						</#if>
					</div>
				</div>
			</div>
				<br/>
			<div class="region-inner">
				<#--<label class='rte-editor-label-waiver'><@s.text name="project.waiver.approver.comments"/><span>*</span></label>-->
				<label class='rte-editor-label-waiver'>Approver Comments<span></span></label>				
				
					<div class="form-text_div">		
						<#if (isApprover && !isApproved) || isAdminUser>
					<textarea name="approverComments" id="approverComments" cols="60" rows="5" class="form-textarea" placeholder="Approver Comments">${projectWaiver.approverComments?default('')?html}</textarea>
					<@macroCustomFieldErrors msg="Please enter comments"/>						
					<!--<#assign error_msg><@s.text name='waiver.error.comment' /></#assign>  -->
					<!--<@macroCustomFieldErrors msg=error_msg />  -->
					<span class="textarea-error-message_approver" id="textareaErrorMsg" style="display:none">Please enter Approver Comments</span>
				<#else>
					<textarea name="approverComments" id="approverComments" cols="60" rows="5" class="form-textarea" placeholder="" disabled>${projectWaiver.approverComments?default('')?html}</textarea>
				</#if>	
					</div>	
				<textarea style="display:none;" id="approverCommentsText" name="approverCommentsText">${projectWaiver.approverComments?default('')?html}</textarea>
				
			</div>	
			
			
            <!-- Waiver Publish Button -->
			<#if isApprover || isAdminUser>
			<#if !isApproved || isAdminUser>  
				<div class="buttons">					
					<a id="approve" href="javascript:void(0);" class="approve-btn">Approve</a>					
					<#if isAdminUser || isSynchroSystemOwner>
						<a id="save_waiver_link" href="javascript:void(0);" class="approve-btn">Save</a>
					</#if>
					<a id="reject" href="javascript:void(0);" class="continue-btn">Reject</a>
				</div>
	          	<#else>
                                 
			         <#--	  new change  533  <div class="buttons">
                                           
					<a href="javascript:void(0);" class="approve-btn disabled">Approve</a>
					<a href="javascript:void(0);" class="approve-btn disabled">Reject</a>
				</div> -->  
        
                              <div class="buttons">					
					<a id="approve" href="javascript:void(0);" class="approve-btn">Approve</a>					
					
					<a id="reject" href="javascript:void(0);" class="continue-btn">Reject</a>
				</div>



			</#if>   
				
			</#if>		
			<#if !isAdminUser && !isSynchroSystemOwner>
				<input type="hidden" name="approverID" value="${projectWaiver.approverID?c}" />
				<input type="hidden" name="nexus" value="${projectWaiver.nexus?c}" />
			</#if>
			<input type="hidden" name="approveWaiver" id="approveWaiver" value="" />
			
			<@jive.token name="synchro.waiver.approve" lazy=true />		
			
        </form>
    </div>
</div>

<script type="text/javascript">
/* Initialization of Editor */
$j(document).ready(function () {
	initiateRTE('summary', 2500, true);
	initiateRTE('approverComments', 900, true);
});



$j("#brand").change(function()
{
var brand = $j("#brand");	
	if(brand.val()!=null || brand.val()>0)
	{
		brand.next().hide();
			
	}
});

  var availableEndMarketsList=0;

$j("#availableEndMarkets").change(function()
{
  availableEndMarketsList=1;

});


$j("#addEndMarketMMBtn").click(function()
{

    
if(availableEndMarketsList==1)
 {
 var endMarkets = $j("#endMarkets");
 endMarkets.parent().find("span").hide();
 }

});

</script>	