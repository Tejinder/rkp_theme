<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<@resource.template file="/soy/userpicker/userpicker.soy" />


<#if projects?? && (projects?size > 0)>
<div>
    <table id="project_status_table_body" class="scrollable-table project_status_table tablesorter" >
 
       <thead>
        <th class="catalogue-code sortable"><span id="id">Project Code</span></th>
        <th class="catalogue-name sortable"><span id="name">Project Name</span></th>
        <th class="catalogue-link"><span id="owner">Delegate Project</span></th>
        <th class="catalogue-link"><span id="year">Add Stakeholder</span></th>
        <th class="catalogue-brand sortable"><span id="brand">Project Status</span></th>
        
        </thead>
        <tbody>
            <#list projects as project>
            <tr <#if (project_index % 2) == 0> class="last"</#if> >
                <td class="catalogue-code" style="padding: 5px 20px">
                    <span>${generateProjectCode('${project.projectID?c}')}</span>
                </td>
              
                <td class="catalogue-name">
                    <#if project.multimarket>
                        <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccessMultiMarket(project.projectID)
                        || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccessMultiMarket(project.projectID)) && project.confidential)>
                            <span>${project.projectName?string}</span>
                        <#else>
                            <a href="${project.url}">${project.projectName?string}</a>
                        </#if>
                    <#else>
                        <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccess(project.projectID)
                        || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccess(project.projectID)) && project.confidential)>
                            <span>${project.projectName?string}</span>
                        <#else>
                            <a href="${project.url}">${project.projectName?string}</a>
                        </#if>
                    </#if>

                </td>
              
                 <td class="catalogue-link">
                    <#assign link = project.activityLink?default("") />
                    
                    <#if project.multimarket>
                    	<#assign isExternalAgencyUser = statics['com.grail.synchro.util.SynchroPermHelper'].isExternalAgencyUser(project.projectID,statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID) />
                    	<#if isExternalAgencyUser> 
                    		<a onclick="javascript:showDelegateAgencyUserWindow('${project.agencyContactName?string}','${project.projectID?c}','${statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID}','Above Market');" href="javascript:void(0);">Delegate</a>
                    	<#else>
                    		<#assign agencyConName = project.agencyContactName?default("")>
                    		<#if project.status==statics['com.grail.synchro.SynchroGlobal$Status'].DRAFT.getValue()>
                    			<a onclick="javascript:showDelegateMMUserWindow('${project.owner?string}','${project.spiContactName?string}','${project.projectID?c}','${project.endMarketIDs}','${project.endMarketName}','${project.endMarketIDs.size()}','${project.endMarketProjectOwner}','${project.endMarketSPIContact}','${agencyConName}','draft');" href="javascript:void(0);">Change Key Contacts and Owners</a>
                    		<#else>
                    			<a onclick="javascript:showDelegateMMUserWindow('${project.owner?string}','${project.spiContactName?string}','${project.projectID?c}','${project.endMarketIDs}','${project.endMarketName}','${project.endMarketIDs.size()}','${project.endMarketProjectOwner}','${project.endMarketSPIContact}','${agencyConName}','');" href="javascript:void(0);">Change Key Contacts and Owners</a>
                    		</#if>
                    		
                    		
                    	</#if>
                    <#else>
                    	<#assign isExternalAgencyUser = statics['com.grail.synchro.util.SynchroPermHelper'].isExternalAgencyUser(project.projectID,project.endMarketIDs.get(0)) />
						<#if isExternalAgencyUser>                    	
                    		<a onclick="javascript:showDelegateAgencyUserWindow('${project.agencyContactName?string}','${project.projectID?c}','${project.endMarketIDs.get(0)?c}','${project.endMarketName}');" href="javascript:void(0);">Delegate </a>
                    	<#else>
                    		<#assign agencyConName = project.agencyContactName?default("")>
                    		<#if project.status==statics['com.grail.synchro.SynchroGlobal$Status'].DRAFT.getValue()>
                    			<a onclick="javascript:showDelegateUserWindow('${project.owner?string}','${project.spiContactName?string}','${project.projectID?c}','${project.endMarketIDs.get(0)?c}','${project.endMarketName}','${agencyConName}','draft');" href="javascript:void(0);">Change Key Contacts and Owners</a>
                    		<#else>
                    			<a onclick="javascript:showDelegateUserWindow('${project.owner?string}','${project.spiContactName?string}','${project.projectID?c}','${project.endMarketIDs.get(0)?c}','${project.endMarketName}','${agencyConName}','');" href="javascript:void(0);">Change Key Contacts and Owners</a>
                    		</#if>
                    		
                    		
                    	</#if>
                    </#if>
                </td>
                 <td class="catalogue-link">
                    <#assign link = project.activityLink?default("") />
                      <#if project.multimarket>                    	
                    	<#if isExternalAgencyUser> 
                    		<a onclick="javascript:showAddAgencyContactWindow('${project.projectID?c}','${statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID}','Above Market','${project.otherAgencyContacts?string}')" href="javascript:void(0);">Add/View</a>
                    	<#else>
                    		<#if project.status==statics['com.grail.synchro.SynchroGlobal$Status'].DRAFT.getValue()>
                    			<a onclick="javascript:showAddStakeholderMMWindow('${project.projectID?c}','${project.endMarketIDs}','${project.endMarketName}','${project.endMarketIDs.size()}','${project.otherSPIContacts?string}','${project.otherLegalContacts?string}','${project.otherProductContacts?string}','${project.endMarketOtherSPIContacts}','${project.endMarketOtherLegalContacts}','${project.endMarketOtherProductContacts}','draft','${project.otherAgencyContacts?string}')" href="javascript:void(0);">Add/View</a>
                    		<#else>
                    			<a onclick="javascript:showAddStakeholderMMWindow('${project.projectID?c}','${project.endMarketIDs}','${project.endMarketName}','${project.endMarketIDs.size()}','${project.otherSPIContacts?string}','${project.otherLegalContacts?string}','${project.otherProductContacts?string}','${project.endMarketOtherSPIContacts}','${project.endMarketOtherLegalContacts}','${project.endMarketOtherProductContacts}','','${project.otherAgencyContacts?string}')" href="javascript:void(0);">Add/View</a>
                    		</#if>
                    	</#if>
                    	
                    <#else>                    	
                    	<#assign isExternalAgencyUser = statics['com.grail.synchro.util.SynchroPermHelper'].isExternalAgencyUser(project.projectID,statics['com.grail.synchro.SynchroConstants'].ABOVE_MARKET_MULTI_MARKET_ID) />
                    	<#if isExternalAgencyUser> 
                    		<a onclick="javascript:showAddAgencyContactWindow('${project.projectID?c}','${project.endMarketIDs.get(0)?c}','${project.endMarketName}','${project.otherAgencyContacts?string}')" href="javascript:void(0);">Add/View </a>
                    	<#else>
                    	
                    		<#if project.status==statics['com.grail.synchro.SynchroGlobal$Status'].DRAFT.getValue()>
                    			<a onclick="javascript:showAddStakeholderWindow('${project.projectID?c}','${project.endMarketIDs.get(0)?c}','${project.endMarketName}','${project.otherSPIContacts?string}','${project.otherLegalContacts?string}','${project.otherProductContacts?string}','draft','${project.otherAgencyContacts?string}')" href="javascript:void(0);">Add/View</a>
                    		<#else>
                    			<a onclick="javascript:showAddStakeholderWindow('${project.projectID?c}','${project.endMarketIDs.get(0)?c}','${project.endMarketName}','${project.otherSPIContacts?string}','${project.otherLegalContacts?string}','${project.otherProductContacts?string}','','${project.otherAgencyContacts?string}')" href="javascript:void(0);">Add/View</a>
                    		</#if>
                    	</#if>
                    	
                    </#if>
                    
                    
                </td>
                
                <td class="catalogue-brand">
                        <#if project.multimarket>
                            <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccessMultiMarket(project.projectID)
                            || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccessMultiMarket(project.projectID)) && project.confidential)>
                                <span></span>
                            <#else>
                            ${project.status}
                            </#if>
                        <#else>
                            <#if (!(statics["com.grail.synchro.util.SynchroPermHelper"].hasProjectAccess(project.projectID)
                            || statics["com.grail.synchro.util.SynchroPermHelper"].hasPIBAccess(project.projectID)) && project.confidential)>
                                <span></span>
                            <#else>
                            ${project.status}
                            </#if>
                        </#if>

                    </td>
            </tr>
           
           <script type="text/javascript">
          		 <#list project.endMarketIDs as emID>         		
            		initializeUserPicker({$input:$j("#projectOwnermm${emID}${project.projectID?c}"),name:'projectOwnermm${emID}${project.projectID?c}',value:'', defaultFilters:{'role':20,'roleEnabled':false, 'hideInvite':true}});
            		initializeUserPicker({$input:$j("#spiContactmm${emID}${project.projectID?c}"),name:'spiContactmm${emID}${project.projectID?c}',value:'', defaultFilters:{'role':1,'roleEnabled':false, 'hideInvite':true}});
            		
            		initializeUserPicker({$input:$j("#otherSPIMM${emID}${project.projectID?c}"),name:'otherSPIMM${emID}${project.projectID?c}',value:'', multiple:true, defaultFilters:{'role':1,'roleEnabled':false, 'hideInvite':true}});
					initializeUserPicker({$input:$j("#otherLegalContactMM${emID}${project.projectID?c}"),name:'otherLegalContactMM${emID}${project.projectID?c}',value:'', multiple:true, defaultFilters:{'role':4,'roleEnabled':false, 'hideInvite':true}});
					initializeUserPicker({$input:$j("#otherProductContactMM${emID}${project.projectID?c}"),name:'otherProductContactMM${emID}${project.projectID?c}',value:'', multiple:true, defaultFilters:{'role':20,'roleEnabled':false, 'hideInvite':true}});
				
				</#list>
			 </script>
            
            </#list>
        </tbody>
          <script type="text/javascript">
          		          		
            	initializeUserPicker({$input:$j("#projectOwner"),name:'projectOwner',value:'', defaultFilters:{'role':20,'roleEnabled':false, 'hideInvite':true}});
            	initializeUserPicker({$input:$j("#agencyContact"),name:'agencyContact',value:'',defaultFilters:{'role':6,'roleEnabled':false, 'hideInvite':true}});
            	initializeUserPicker({$input:$j("#agencyContactmm"),name:'agencyContactmm',value:'',defaultFilters:{'role':6,'roleEnabled':false, 'hideInvite':true}});
            	
            	initializeUserPicker({$input:$j("#projectOwnermm"),name:'projectOwnermm',value:'', defaultFilters:{'role':20,'roleEnabled':false, 'hideInvite':true}});
				initializeUserPicker({$input:$j("#spiContact"),name:'spiContact',value:'', defaultFilters:{'role':1,'roleEnabled':false, 'hideInvite':true}});
				initializeUserPicker({$input:$j("#spiContactmm"),name:'spiContactmm',value:'', defaultFilters:{'role':1,'roleEnabled':false, 'hideInvite':true}});
				
				initializeUserPicker({$input:$j("#otherSPI"),name:'otherSPI',value:'', multiple:true, defaultFilters:{'role':1,'roleEnabled':false, 'hideInvite':true}});
				initializeUserPicker({$input:$j("#otherLegalContact"),name:'otherLegalContact',value:'', multiple:true, defaultFilters:{'role':4,'roleEnabled':false, 'hideInvite':true}});
				initializeUserPicker({$input:$j("#otherProductContact"),name:'otherProductContact',value:'', multiple:true, defaultFilters:{'role':20,'roleEnabled':false, 'hideInvite':true}});
				
				initializeUserPicker({$input:$j("#otherAgencyContact"),name:'otherAgencyContact',value:'', multiple:true, defaultFilters:{'role':6,'roleEnabled':false, 'hideInvite':true}});
				initializeUserPicker({$input:$j("#otherAgencyContactMM"),name:'otherAgencyContactMM',value:'', multiple:true, defaultFilters:{'role':6,'roleEnabled':false, 'hideInvite':true}});
				
				initializeUserPicker({$input:$j("#otherSPIMM"),name:'otherSPIMM',value:'', multiple:true, defaultFilters:{'role':1,'roleEnabled':false, 'hideInvite':true}});
				initializeUserPicker({$input:$j("#otherLegalContactMM"),name:'otherLegalContactMM',value:'', multiple:true, defaultFilters:{'role':4,'roleEnabled':false, 'hideInvite':true}});
				initializeUserPicker({$input:$j("#otherProductContactMM"),name:'otherProductContactMM',value:'', multiple:true, defaultFilters:{'role':20,'roleEnabled':false, 'hideInvite':true}});
			 </script>
    </table>
    
	    <!-- Add Investment Popup Starts -->
	<div id="add-investment-popup" style="display:none">
	
	  <form id="delegate-project-form" action="<@s.url value="/synchro/delegate-add-stakeholders-pagination!delegateProject.jspa"/>" method="post" >
	    <div>
	        <a href="javascript:void(0);" class="close" onclick="closePopUp();"></a>
	        <label name="endMarketLabel" id="endMarketLabel" class="delegate-stakeholder-popup-market-type-label">End Market - Brazil</label>
	       
	        <div id="project-contact" class="investment-popup-field">
	            <span class="add-investment-sp">Project Owner </span>
	            <div id="popup-contact-container">
	                <input type="text" tabindex="1" name="projectOwner" id="projectOwner" class="j-user-autocomplete j-ui-elem" autocomplete="off" />
	            </div>
	            <span id="error-contact" class="jive-error-message" style="display:none">Please select Project Contact</span>
	        </div>
	        <div class="investment-popup-field" id="spi-contact-container" >
	            <span class="add-investment-sp"><@s.text name="project.initiate.project.spi"/></span>
	            <div id="popup-spi-container">
	                <input type="text" tabindex="1" name="spiContact" id="spiContact" class="j-user-autocomplete j-ui-elem" srole="1" autocomplete="off" />
	            </div>
	        </div>
	        
	         <div id="agency-contact" class="investment-popup-field">
	            <span class="add-investment-sp">BAT Contact </span>
	            <div id="popup-contact-container">
	                <input type="text" tabindex="1" name="agencyContact" id="agencyContact" class="j-user-autocomplete j-ui-elem" autocomplete="off" />
	            </div>
	            <span id="error-contact" class="jive-error-message" style="display:none">Please select BAT Contact</span>
	        </div>
	       
	        <div class="investment-popup-buttons">
	           <#-- <input type="button" id="investment-popup-save" value="Save" onClick="saveDelegateUser();"/>-->
	            <input type="submit" id="investment-popup-save" value="Save" />
	            
	            <input type="button" id="investment-popup-cancel" value="Cancel" onClick="closePopUp();" />
	        </div>
	        <input type="hidden" name="projectID" id="projectID" value="" />
	        <input type="hidden" name="endMarketID" id="endMarketID" value="" />
	        
	    </div>
	 </form>
	</div>
	<!-- Add Investment Popup Ends -->
	
	<!-- Delegate Agency User Popup Starts -->
	<div id="delegate-agency-stakeholder-popup" style="display:none">
	
	  <form id="delegate-project-form" action="<@s.url value="/synchro/delegate-add-stakeholders-pagination!delegateProjectAgencyContacts.jspa"/>" method="post" >
	    <div>
	        <a href="javascript:void(0);" class="close" onclick="closePopUp();"></a>
	        <label name="endMarketLabel" id="endMarketLabel" class="delegate-stakeholder-popup-market-type-label">End Market - Brazil</label>
	       <br><br>
	        <div id="project-contact" class="investment-popup-field">
	            <span class="add-investment-sp">BAT Contact </span>
	            <div id="popup-contact-container">
	                <input type="text" tabindex="1" name="agencyContact" id="agencyContact" class="j-user-autocomplete j-ui-elem" autocomplete="off" />
	            </div>
	            <span id="error-contact" class="jive-error-message" style="display:none">Please select BAT Contact</span>
	        </div>
	       	       
	        <div class="investment-popup-buttons">
	           <#-- <input type="button" id="investment-popup-save" value="Save" onClick="saveDelegateUser();"/>-->
	            <input type="submit" id="investment-popup-save" value="Save" />
	            
	            <input type="button" id="investment-popup-cancel" value="Cancel" onClick="closePopUp();" />
	        </div>
	        <input type="hidden" name="projectID" id="projectID" value="" />
	        <input type="hidden" name="endMarketID" id="endMarketID" value="" />
	        
	    </div>
	 </form>
	</div>
	<!-- Delegate Agency User Popup Ends -->
	
	    <!-- Delegate Project Stakeholder Multimarket Popup Starts -->
	<div id="delegate-stakeholder-mm-popup" style="display:none">
	
	  <form id="delegate-project-form" action="<@s.url value="/synchro/delegate-add-stakeholders-pagination!delegateProjectMM.jspa"/>" method="post" >
	    <div>
	        <a href="javascript:void(0);" class="close" onclick="closePopUp();"></a>
	        <label name="endMarketLabel" id="endMarketLabel" class="delegate-stakeholder-popup-market-type-label">Above Market</label>
	       
	        <div id="project-contact" class="investment-popup-fieldAM">
	            <span class="add-investment-sp">Project Owner </span>
	            <div id="popup-contact-container">
	                <input type="text" tabindex="1" name="projectOwnermm" id="projectOwnermm" class="j-user-autocomplete j-ui-elem" autocomplete="off" />
	            </div>
	            <span id="error-contact" class="jive-error-message" style="display:none">Please select Project Contact</span>
	        </div>
	        <div class="investment-popup-fieldAM" id="spi-contact-container" >
	            <span class="add-investment-sp"><@s.text name="project.initiate.project.spi"/></span>
	            <div id="popup-spi-container">
	                <input type="text" tabindex="1" name="spiContactmm" id="spiContactmm" class="j-user-autocomplete j-ui-elem" srole="1" autocomplete="off" />
	            </div>
	        </div>
	        
	        <div id="agency-contact" class="investment-popup-fieldAM">
	            <span class="add-investment-sp">BAT Contact </span>
	            <div id="popup-contact-container">
	                <input type="text" tabindex="1" name="agencyContactmm" id="agencyContactmm" class="j-user-autocomplete j-ui-elem" autocomplete="off" />
	            </div>
	            <span id="error-contact" class="jive-error-message" style="display:none">Please select BAT Contact</span>
	        </div>
	        
	        <#list projects as project>
	        	<#list project.endMarketIDs as emID>
			        <label name="endMarketLabel" id="endMarketLabel${emID}${project.projectID?c}" class="endMarketLabel delegate-stakeholder-popup-market-type-label" style="display:none;  font-weight: bold;">${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emID?int)}</label>
			        <div id="project-contact-mm${emID}${project.projectID?c}" class="investment-popup-field"  style="display:none">
			            <span class="add-investment-sp">Project Owner </span>
			            <div id="popup-contact-container">
			                <input type="text" tabindex="1" name="projectOwnermm${emID}${project.projectID?c}" id="projectOwnermm${emID}${project.projectID?c}" class="j-user-autocomplete j-ui-elem" autocomplete="off" />
			            </div>
			            <span id="error-contact" class="jive-error-message" style="display:none">Please select Project Owner</span>
			        </div>
			        
			        <div class="investment-popup-field" id="spi-contact-container-spiContactmm${emID}${project.projectID?c}" style="display:none">
			            <span class="add-investment-sp"><@s.text name="project.initiate.project.spi"/></span>
			            <div id="popup-spi-container">
			                <input type="text" tabindex="1" name="spiContactmm${emID}${project.projectID?c}" id="spiContactmm${emID}${project.projectID?c}" class="j-user-autocomplete j-ui-elem" srole="1" autocomplete="off" />
			            </div>
			        </div>
			    </#list>
		    </#list>
	       
	        <div class="investment-popup-buttons" id="investment-popup-buttons">
	           <#-- <input type="button" id="investment-popup-save" value="Save" onClick="saveDelegateUser();"/>-->
	            <input type="submit" id="investment-popup-save" value="Save" />
	            
	            <input type="button" id="investment-popup-cancel" value="Cancel" onClick="closePopUp();" />
	        </div>
	        <input type="hidden" name="projectID" id="projectID" value="" />
	        <input type="hidden" name="endMarketID" id="endMarketID" value="" />
	        
	    </div>
	 </form>
	</div>
	<!-- Delegate Project Stakeholder MM Popup Ends -->
	
	 <!-- Add Stakeholder Popup Starts -->
	<div id="add-stakeholder-popup" style="display:none">
	
	  <form id="delegate-project-form" action="<@s.url value="/synchro/delegate-add-stakeholders-pagination!addStakeholders.jspa"/>" method="post" >
	    <div>
	        <a href="javascript:void(0);" class="close" onclick="closePopUp();"></a>
	        <label name="endMarketLabel" id="endMarketLabel" class="delegate-stakeholder-popup-market-type-label">End Market - Brazil</label>
	       
	        <div id="project-contact" class="investment-popup-field">
	            <span class="add-investment-sp">Other SPI</span>
	            <div id="popup-contact-container">
	                <#--<input type="text" name="otherSPI" id="otherSPI" class="j-user-autocomplete j-ui-elem" /> -->
	                <input type="text" tabindex="1" name="otherSPI" id="otherSPI" class="j-user-autocomplete j-ui-elem" srole="1" autocomplete="off" />
	                 
	            </div>
	            <span id="error-contact" class="jive-error-message" style="display:none">Please select Project Contact</span>
	        </div>
	        <div class="investment-popup-field" id="spi-contact-container" >
	            <span class="add-investment-sp">Legal Contact</span>
	            <div id="popup-spi-container">
	                <#--<input type="text" name="otherLegalContact" id="otherLegalContact" class="j-user-autocomplete j-ui-elem" />-->
	                <input type="text" tabindex="1" name="otherLegalContact" id="otherLegalContact" class="j-user-autocomplete j-ui-elem" srole="4" autocomplete="off" />
	            </div>
	        </div>
	        <div class="investment-popup-field" id="spi-contact-container" >
	            <span class="add-investment-sp">Other BAT Contacts</span>
	            <div id="popup-spi-container">
	                <#--<input type="text" name="otherProductContact" id="otherProductContact" class="j-user-autocomplete j-ui-elem" /> -->
	                <input type="text" tabindex="1" name="otherProductContact" id="otherProductContact" class="j-user-autocomplete j-ui-elem" srole="20" autocomplete="off" />
	            </div>
	        </div>
	        
	         <div id="spi-contact-container" class="investment-popup-field">
	            <span class="add-investment-sp">Other Agency Contact</span>
	            <div id="popup-contact-container">
	                <input type="text" name="otherAgencyContact" id="otherAgencyContact" class="j-user-autocomplete j-ui-elem" />
	                 
	            </div>
	            <span id="error-contact" class="jive-error-message" style="display:none">Please select Project Contact</span>
	        </div>
	       
	        <div class="investment-popup-buttons">
	           <#-- <input type="button" id="investment-popup-save" value="Save" onClick="saveDelegateUser();"/>-->
	            <input type="submit" id="investment-popup-save" value="Save" />
	            
	            <input type="button" id="investment-popup-cancel" value="Cancel" onClick="closePopUp();" />
	        </div>
	        <input type="hidden" name="projectID" id="projectID" value="" />
	        <input type="hidden" name="endMarketID" id="endMarketID" value="" />
	        
	    </div>
	 </form>
	</div>
	<!-- Add Stakeholder Popup Ends -->
	
	<!-- Add Agency Contact Popup Starts -->
	<div id="add-agency-contact-popup" style="display:none">
	
	  <form id="delegate-project-form" action="<@s.url value="/synchro/delegate-add-stakeholders-pagination!addStakeholders.jspa"/>" method="post" >
	    <div>
	        <a href="javascript:void(0);" class="close" onclick="closePopUp();"></a>
	        <label name="endMarketLabel" id="endMarketLabel" class="delegate-stakeholder-popup-market-type-label">End Market - Brazil</label>
	        <br><br>
	        <div id="project-contact" class="investment-popup-field">
	            <span class="add-investment-sp">Other Agency Contact</span>
	            <div id="popup-contact-container">
	                <input type="text" name="otherAgencyContact" id="otherAgencyContact" class="j-user-autocomplete j-ui-elem" />
	                 
	            </div>
	            <span id="error-contact" class="jive-error-message" style="display:none">Please select Project Contact</span>
	        </div>
	        
	       
	        <div class="investment-popup-buttons">
	           <#-- <input type="button" id="investment-popup-save" value="Save" onClick="saveDelegateUser();"/>-->
	            <input type="submit" id="investment-popup-save" value="Save" />
	            
	            <input type="button" id="investment-popup-cancel" value="Cancel" onClick="closePopUp();" />
	        </div>
	        <input type="hidden" name="projectID" id="projectID" value="" />
	        <input type="hidden" name="endMarketID" id="endMarketID" value="" />
	        
	    </div>
	 </form>
	</div>
	<!-- Add Agency Contact Popup Ends -->
	
	 <!-- Add Stakeholder MM Popup Starts -->
	<div id="add-stakeholder-popup-mm" style="display:none">
	
	  <form id="delegate-project-form" action="<@s.url value="/synchro/delegate-add-stakeholders-pagination!addStakeholdersMM.jspa"/>" method="post" >
	    <div>
	        <a href="javascript:void(0);" class="close" onclick="closePopUp();"></a>
	        <label name="endMarketLabel" id="endMarketLabel" class="endMarketLabelAM  delegate-stakeholder-popup-market-type-label">Above Market</label>
	       
	        <div id="project-contact" class="investment-popup-fieldAM">
	            <span class="add-investment-sp">Other SPI</span>
	            <div id="popup-contact-container">
	                <#--<input type="text" name="otherSPIMM" id="otherSPIMM" class="j-user-autocomplete j-ui-elem" /> -->
	                <input type="text" tabindex="1" name="otherSPIMM" id="otherSPIMM" class="j-user-autocomplete j-ui-elem" srole="1" autocomplete="off" />
	                 
	            </div>
	            <span id="error-contact" class="jive-error-message" style="display:none">Please select Project Contact</span>
	        </div>
	        <div class="investment-popup-fieldAM" id="spi-contact-container" >
	            <span class="add-investment-sp">Legal Contact</span>
	            <div id="popup-spi-container">
	                <#--<input type="text" name="otherLegalContactMM" id="otherLegalContactMM" class="j-user-autocomplete j-ui-elem" /> -->
	                <input type="text" tabindex="1" name="otherLegalContactMM" id="otherLegalContactMM" class="j-user-autocomplete j-ui-elem" srole="4" autocomplete="off" />
	            </div>
	        </div>
	        <div class="investment-popup-fieldAM" id="spi-contact-container" >
	            <span class="add-investment-sp">Other BAT Contacts</span>
	            <div id="popup-spi-container">
	                <#--<input type="text" name="otherProductContactMM" id="otherProductContactMM" class="j-user-autocomplete j-ui-elem" /> -->
	                <input type="text" tabindex="1" name="otherProductContactMM" id="otherProductContactMM" class="j-user-autocomplete j-ui-elem" srole="20" autocomplete="off" />
	            </div>
	        </div>
	        
	         <div id="spi-contact-container" class="investment-popup-fieldAM">
	            <span class="add-investment-sp">Other Agency Contact</span>
	            <div id="popup-contact-container">
	                <input type="text" name="otherAgencyContactMM" id="otherAgencyContactMM" class="j-user-autocomplete j-ui-elem" />
	                 
	            </div>
	            <span id="error-contact" class="jive-error-message" style="display:none">Please select Project Contact</span>
	        </div>
	       
	       <#list projects as project>
	        	<#list project.endMarketIDs as emID>
			        <label name="endMarketLabel" id="endMarketLabel${emID}${project.projectID?c}" class="endMarketLabel delegate-stakeholder-popup-market-type-label"  style="display:none;">${statics['com.grail.synchro.SynchroGlobal'].getEndMarkets().get(emID?int)}</label>
			        
			        <div id="project-contact-mm${emID}${project.projectID?c}" class="investment-popup-field" style="display:none">
			            <span class="add-investment-sp">Other SPI</span>
			            <div id="popup-contact-container">
			                <#--<input type="text" name="otherSPIMM${emID}${project.projectID?c}" id="otherSPIMM${emID}${project.projectID?c}" class="j-user-autocomplete j-ui-elem" /> -->
			                <input type="text" tabindex="1" name="otherSPIMM${emID}${project.projectID?c}" id="otherSPIMM${emID}${project.projectID?c}" class="j-user-autocomplete j-ui-elem" srole="1" autocomplete="off" />
			        	</div>
	            		<span id="error-contact" class="jive-error-message" style="display:none">Please select Project Contact</span>
	        		</div>
			        <div class="investment-popup-field" id="spi-contact-container-mm${emID}${project.projectID?c}" style="display:none">
			            <span class="add-investment-sp">Legal Contact</span>
			            <div id="popup-spi-container">
			               <#-- <input type="text" name="otherLegalContactMM${emID}${project.projectID}" id="otherLegalContactMM${emID}${project.projectID}" class="j-user-autocomplete j-ui-elem" />-->
			               <input type="text" tabindex="1" name="otherLegalContactMM${emID}${project.projectID?c}" id="otherLegalContactMM${emID}${project.projectID?c}" class="j-user-autocomplete j-ui-elem" srole="4" autocomplete="off" />
			               
			            </div>
			        </div>
			        <div class="investment-popup-field" id="product-contact-container-mm${emID}${project.projectID?c}" style="display:none">
			            <span class="add-investment-sp">Other BAT Contacts</span>
			            <div id="popup-spi-container">
			                <#--<input type="text" name="otherProductContactMM${emID}${project.projectID}" id="otherProductContactMM${emID}${project.projectID}" class="j-user-autocomplete j-ui-elem" /> -->
			                <input type="text" tabindex="1" name="otherProductContactMM${emID}${project.projectID?c}" id="otherProductContactMM${emID}${project.projectID?c}" class="j-user-autocomplete j-ui-elem" srole="20" autocomplete="off" />
			            </div>
			        </div>
	        
			    </#list>
		   </#list>   
			        
	        <div class="investment-popup-buttons">
	           
	            <input type="submit" id="investment-popup-save" value="Save" />
	            
	            <input type="button" id="investment-popup-cancel" value="Cancel" onClick="closePopUp();" />
	        </div>
	        <input type="hidden" name="projectID" id="projectID" value="" />
	        <input type="hidden" name="endMarketID" id="endMarketID" value="" />
	        
	    </div>
	 </form>
	</div>
	<!-- Add Stakeholder MM Popup Ends -->
    
      <div class="table-vscroll">
        <script type="text/javascript">
            $j(document).ready(function() {
                $j(".table-vscroll").scroll(function(event) {
                    $j(".project_status_table tbody").scrollTop($j(this).scrollTop());
                });
            });
        </script>
        <div class="scollinner">
            <span>&nbsp;</span>
        </div>
    </div>
    
</div>





<#else>
<script>
    if($j.trim($j("#search_box").val())!="")
    {
        $j(".no-content").html("No results matching the criteria");
    }
    else
    {
        if(!isfilterSet())
        {
            $j("#search_box").hide();
        }
    }
</script>
<div class="no-content">No Projects in My Dashboard </div>
</#if>
<#if pages?? && (pages>1)>

<div id="pagination"></div>
</#if>
<script type="text/javascript">
    <#if pages?? && (pages>0)>
    var pages = ${pages};
    <#else>
    var pages = 1;
    </#if>
    
     var investmentPopup = null;
     investmentPopup = new LIGHT_BOX($j("#add-investment-popup"),{title:'Delegate Project'});
     
     var delegateAgencyUserPopup = null;
     delegateAgencyUserPopup = new LIGHT_BOX($j("#delegate-agency-stakeholder-popup"),{title:'Delegate Project'});
     
     var delegateUserMMPopup = null;
     delegateUserMMPopup = new LIGHT_BOX($j("#delegate-stakeholder-mm-popup"),{title:'Delegate Project'});
      
     var addStakeholderPopup = null;
     addStakeholderPopup = new LIGHT_BOX($j("#add-stakeholder-popup"),{title:'Add Stakeholders'});
     
     var addAgencyContactPopup = null;
     addAgencyContactPopup = new LIGHT_BOX($j("#add-agency-contact-popup"),{title:'Add Stakeholders'});
     
     var addStakeholderMMPopup = null;
     addStakeholderMMPopup = new LIGHT_BOX($j("#add-stakeholder-popup-mm"),{title:'Add Stakeholders'});
     
    function showDelegateUserWindow(projectOwner, spiContact, projectID, endMarketID,endMarketName,agencyUser,draft)
	{
	     endMarketName = endMarketName.replace("[","");
	    endMarketName = endMarketName.replace("]","");
	    $j("#add-investment-popup #projectOwner").val(projectOwner);
	    $j("#add-investment-popup #spiContact").val(spiContact); 
	    $j("#add-investment-popup #projectID").val(projectID); 
	    $j("#add-investment-popup #endMarketID").val(endMarketID); 
	    $j("#add-investment-popup #endMarketLabel").text("End Market - "+endMarketName);
	    $j("#add-investment-popup #agencyContact").val(agencyUser);
	    if(draft=="draft")
	    {
	    	$j('#add-investment-popup #agency-contact').css("display","none");
	    } 
	    else
	    {
	    	$j('#add-investment-popup #agency-contact').css("display","block");
	    }
	    investmentPopup.show();
	}
	
	function showDelegateAgencyUserWindow(agencyUser,projectID, endMarketID,endMarketName)
	{
	    endMarketName = endMarketName.replace("[","");
	    endMarketName = endMarketName.replace("]","");
	    $j("#delegate-agency-stakeholder-popup #agencyContact").val(agencyUser);
	    $j("#delegate-agency-stakeholder-popup #projectID").val(projectID); 
	    $j("#delegate-agency-stakeholder-popup #endMarketID").val(endMarketID); 
	    $j("#delegate-agency-stakeholder-popup #endMarketLabel").text("End Market - "+endMarketName);
	    delegateAgencyUserPopup.show();
	}
	
	 function showDelegateMMUserWindow(projectOwner, spiContact, projectID, endMarketIDs,endMarketName, endMarketSize,endMarketProjectOwnerName,endMarketSPIContactName, agencyUser, draft)
	{
	   endMarketName = endMarketName.replace("[","");
	   endMarketName = endMarketName.replace("]","");
	   
	   var endMktNames = endMarketName.split(",");
	   var ss = "#spi-contact-container-spiContactmm1"+projectID;
	   
	   endMarketIDs = endMarketIDs.replace("[","");
	   endMarketIDs = endMarketIDs.replace("]","");
	   var endMktIDArray = endMarketIDs.split(",");
	   
	   endMarketProjectOwnerName = endMarketProjectOwnerName.replace("[","");
	   endMarketProjectOwnerName = endMarketProjectOwnerName.replace("]","");
	   var endMarketPOName =  endMarketProjectOwnerName.split(",");
	   
	   endMarketSPIContactName = endMarketSPIContactName.replace("[","");
	   endMarketSPIContactName = endMarketSPIContactName.replace("]","");
	   var endMarketSPIName =  endMarketSPIContactName.split(",");
	 
	   for(var i=0;i<endMarketSize;i++)
	   {
		 /*   var html= "<label name='endMarketLabel' id='endMarketLabel'>"+endMktNames[i]+"</label><div id='project-contact' class='investment-popup-field'> <span class='add-investment-sp'>Project Owner </span> <div id='popup-contact-container'> <input type='text' tabindex='1' name='projectOwner' id='projectOwner' class='j-user-autocomplete j-ui-elem' autocomplete='off' /> </div> <span id='error-contact' class='jive-error-message' style='display:none'>Please select Project Contact</span></div>";
		    html = html + "<div class='investment-popup-field' id='spi-contact-container' > <span class='add-investment-sp'><@s.text name='project.initiate.project.spi'/></span> <div id='popup-spi-container'> <input type='text' tabindex='1' name='spiContactmm121' id='spiContactmm121' class='j-user-autocomplete j-ui-elem' srole='1' autocomplete='off' /></div> </div>";
		    $j("#delegate-stakeholder-mm-popup #investment-popup-buttons").before(html);
		   */
		     $j('#delegate-stakeholder-mm-popup #spi-contact-container-spiContactmm' + $j.trim(endMktIDArray[i]) + projectID).css("display","block"); 
	       $j('#delegate-stakeholder-mm-popup #project-contact-mm' + $j.trim(endMktIDArray[i]) + projectID).css("display","block"); 
	       $j('#delegate-stakeholder-mm-popup #endMarketLabel' + $j.trim(endMktIDArray[i]) + projectID).css("display","block");
	       
	         $j('#delegate-stakeholder-mm-popup #projectOwnermm'+ $j.trim(endMktIDArray[i]) + projectID).val(endMarketPOName[i]);
	         $j('#delegate-stakeholder-mm-popup #spiContactmm'+ $j.trim(endMktIDArray[i]) + projectID).val(endMarketSPIName[i]);
	    
	    } 
	    
	    $j("#delegate-stakeholder-mm-popup #projectOwnermm").val(projectOwner);
	    $j("#delegate-stakeholder-mm-popup #spiContactmm").val(spiContact); 
	    $j("#delegate-stakeholder-mm-popup #projectID").val(projectID); 
	    
	    $j("#delegate-stakeholder-mm-popup #agencyContactmm").val(agencyUser);
	    
	    if(draft=="draft")
	    {
	    	$j('#delegate-stakeholder-mm-popup #agencyContactmm').css("display","none");
	    } 
	    else
	    {
	    	$j('#delegate-stakeholder-mm-popup #agencyContactmm').css("display","block");
	    }
	    
	  //  $j("#delegate-stakeholder-mm-popup #endMarketID").val(endMarketID); 
	   // $j('#delegate-stakeholder-mm-popup #spi-contact-container-spiContactmm1' + projectID).css("display","block"); 
	   //  $j('#delegate-stakeholder-mm-popup #project-contact-mm1' + projectID).css("display","block"); 
	    
	   // $j("#delegate-stakeholder-mm-popup #endMarketLabel").text("End Market - "+endMarketName);
	    delegateUserMMPopup.show();
	}
	function showAddStakeholderWindow(projectID, endMarketID,endMarketName, otherSPIContacts, otherLegalContacts, otherProductContacts, draft,otherAgencyContacts)
	{
	    $j("#add-stakeholder-popup #projectID").val(projectID); 
	    $j("#add-stakeholder-popup #endMarketID").val(endMarketID); 
	    $j("#add-stakeholder-popup #endMarketLabel").text("End Market - "+endMarketName);
	    $j("#add-stakeholder-popup #otherSPI").val(otherSPIContacts);
	    $j("#add-stakeholder-popup #otherLegalContact").val(otherLegalContacts);
	    $j("#add-stakeholder-popup #otherProductContact").val(otherProductContacts);
	    $j("#add-stakeholder-popup #otherAgencyContact").val(otherAgencyContacts);
	    
	    if(draft=="draft")
	    {
	    	$j('#add-stakeholder-popup #spi-contact-container').css("display","none");
	    } 
	    
	    addStakeholderPopup.show();
	}
	function showAddAgencyContactWindow(projectID, endMarketID,endMarketName, otherAgencyContacts)
	{
	    $j("#add-agency-contact-popup #projectID").val(projectID); 
	    $j("#add-agency-contact-popup #endMarketID").val(endMarketID); 
	    $j("#add-agency-contact-popup #endMarketLabel").text("End Market - "+endMarketName);
	    
	    $j("#add-agency-contact-popup #otherAgencyContact").val(otherAgencyContacts);
	    
	    addAgencyContactPopup.show();
	}
	function showAddStakeholderMMWindow(projectID, endMarketIDs,endMarketName, endMarketSize, otherSPIContacts, otherLegalContacts, otherProductContacts, endMarketOtherSPIContacts, endMarketOtherLegalContacts, endMarketOtherProductContacts, draft, otherAgencyContacts)
	{
	    
	   endMarketOtherSPIContacts = endMarketOtherSPIContacts.replace("[","");
	   endMarketOtherSPIContacts = endMarketOtherSPIContacts.replace("]","");
	   var endMktOtherSPIArray = endMarketOtherSPIContacts.split(",");
	   
	   endMarketOtherLegalContacts = endMarketOtherLegalContacts.replace("[","");
	   endMarketOtherLegalContacts = endMarketOtherLegalContacts.replace("]","");
	   var endMktOtherLegalArray = endMarketOtherLegalContacts.split(",");
	   
	   endMarketOtherProductContacts = endMarketOtherProductContacts.replace("[","");
	   endMarketOtherProductContacts = endMarketOtherProductContacts.replace("]","");
	   var endMktOtherProductArray = endMarketOtherProductContacts.split(",");
	   
	   endMarketIDs = endMarketIDs.replace("[","");
	   endMarketIDs = endMarketIDs.replace("]","");
	   var endMktIDArray = endMarketIDs.split(",");
	   
	   for(var i=0;i<endMarketSize;i++)
	   {
		   $j('#add-stakeholder-popup-mm #endMarketLabel' + $j.trim(endMktIDArray[i]) + projectID).css("display","block");
		   $j('#add-stakeholder-popup-mm #project-contact-mm' + $j.trim(endMktIDArray[i]) + projectID).css("display","block"); 
	       if(draft=="")
	       {
	       		$j('#add-stakeholder-popup-mm #spi-contact-container-mm' + $j.trim(endMktIDArray[i]) + projectID).css("display","block");
	       		$j('#add-stakeholder-popup-mm #product-contact-container-mm' + $j.trim(endMktIDArray[i]) + projectID).css("display","block"); 
	       }
	       $j('#add-stakeholder-popup-mm #otherSPIMM'+ $j.trim(endMktIDArray[i]) + projectID).val(endMktOtherSPIArray[i].replace("~",","));
	       $j('#add-stakeholder-popup-mm #otherLegalContactMM'+ $j.trim(endMktIDArray[i]) + projectID).val(endMktOtherLegalArray[i].replace("~",","));
	       $j('#add-stakeholder-popup-mm #otherProductContactMM'+ $j.trim(endMktIDArray[i]) + projectID).val(endMktOtherProductArray[i].replace("~",","));
	    
	    } 
	    $j("#add-stakeholder-popup-mm #projectID").val(projectID); 
	    
	   
	    $j("#add-stakeholder-popup-mm #otherSPIMM").val(otherSPIContacts);
	    $j("#add-stakeholder-popup-mm #otherLegalContactMM").val(otherLegalContacts);
	    $j("#add-stakeholder-popup-mm #otherProductContactMM").val(otherProductContacts);
	    $j("#add-stakeholder-popup-mm #otherAgencyContactMM").val(otherAgencyContacts);
	    
	    if(draft=="draft")
	    {
	    	$j('#add-stakeholder-popup-mm #spi-contact-container').css("display","none");
	    }
	    addStakeholderMMPopup.show();
	}
	function closePopUp()
	{
	    investmentPopup.close();
	    addStakeholderPopup.close();
	    delegateUserMMPopup.close();
	    addStakeholderMMPopup.close();
	    
	    
	    $j( "#add-stakeholder-popup-mm .investment-popup-field" ).each(function( index ) {
	        $j(this).hide();
	    });
	    $j("#add-stakeholder-popup-mm .endMarketLabel").each(function( index ) {
	        $j(this).hide();
	    });
	    
	    $j( "#delegate-stakeholder-mm-popup .investment-popup-field" ).each(function( index ) {
	        $j(this).hide();
	    });
	    $j("#delegate-stakeholder-mm-popup .endMarketLabel").each(function( index ) {
	        $j(this).hide();
	    });
	   
	    
	}
	function saveDelegateUser()
	{
		var form = $j("#delegate-project-form");
	    jive.util.securedForm(form).always(function() {
	        form.submit();
   		 });
   	}
	$j(".close-btn").click(function() {
       closePopUp();
    });
	
</script>
<script src="${themePath}/js/pagination.custom.js" type="text/javascript"></script>

<#function generateProjectCode projectID maxDigits=5 >
    <#if projectID?? && (projectID?number>0) >
        <#local length = (projectID?string)?length />
        <#local prependLen = (maxDigits - length) />
        <#local prepend = '' />
        <#if (length<maxDigits) >
            <#list 1..prependLen as x>
                <#local prepend = prepend + '0' />
            </#list>
        </#if>
        <#return (prepend + projectID?string)>
    </#if>
    <#return ''>
</#function>