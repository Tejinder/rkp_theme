<head>
	<script type="text/javascript" src="<@s.url value='/dwr/interface/SynchroLogUtil.js' />"></script>
</head>
<script src="${themePath}/js/jqbar.js" type="text/javascript"></script>
<script src="${themePath}/js/jquery.paginate.js" type="text/javascript"></script>
<script src="${themePath}/js/adv_filter.js" type="text/javascript"></script>
<script src="${themePath}/js/synchro/table-height-handler.js" type="text/javascript"></script>
<#include "/template/global/include/synchro-macros.ftl" />
<div class="container">
    <h3>Spend Report QPR Update</h3>
	
	<form id="latestCostCrossTabForm" name="latestCostCrossTabForm" action="/new-synchro/qpr-snapshot!downloadCrossTabLatestCostBY.jspa" method="POST">
		<div class="region-inner clearfix">
		
		<div class="two-column">
			
			<@projectBudgetYearFieldNew name="latestCostBY"  multiselect=false/>
		</div>
		
		<div class="two-column">
			<input type="button" value="Download Latest Cost" onclick="downloadCrossTabLatestCost();" class="btn-blue" />
		</div>
		</div>
	</form>
	<div class="qpr-div  qpr-container">
	<#if qprSnapShotList?? && qprSnapShotList?size gt 0>
		<#list qprSnapShotList as qprSnapShot>
			<div class="region-inner clearfix">
			<#if qprSnapShot.spendFor?? && statics['com.grail.synchro.SynchroGlobal'].getSpendForOptions().get(qprSnapShot.spendFor) ??>
				<div class="three-column">Freeze Spend For <input type="text" tabindex="1" name="spendForDisabled" id="spendForDisabled" value="${statics['com.grail.synchro.SynchroGlobal'].getSpendForOptions().get(qprSnapShot.spendFor)}" disabled/> </div>
			<#else>
				<div class="three-column">Freeze Spend For <input type="text" tabindex="1" name="spendForDisabled" id="spendForDisabled" value="" disabled/> </div>
			</#if>
			<div class="three-column">Budget Year <input type="text" tabindex="1" name="budgetYearDisabled" id="budgetYearDisabled" value="${qprSnapShot.budgetYear?c}" disabled/> </div>
			<div class="three-column">Date of Freeze <input type="text" tabindex="1" name="freezeDateDisabled" id="freezeDateDisabled" value="${qprSnapShot.freezeDate?string('dd/MM/yyyy')}" disabled/>
			<a href="javascript:void(0)" onclick="showChangeQPRSnapshot('${qprSnapShot.snapShotID}');"> Change </a><div class="standard-report-download-link"><a href="javascript:void(0)" title="Download QPR Costs" onclick="downloadQPRCrosstabSnapshot('${qprSnapShot.snapShotID}');"></a>
			<a href="javascript:void(0)" title="Download Latest Costs" onclick="downloadQPRCrosstabLatestCostSnapshot('${qprSnapShot.snapShotID}');"></a>
			<a href="javascript:void(0)" title="Download QPR Snapshot" onclick="downloadQPRSnapshot('${qprSnapShot.snapShotID}');"></a>
			<input type="button" value="Remove" id="firstRemove" onclick="deleteQPRSnapshot('${qprSnapShot.snapShotID}');" class="remove deleteButtonAlignment"></div> </div>
			
			 </div>
			 
			<div id="qpr-snapshot-change_${qprSnapShot.snapShotID}" class=" evaluation_report qpr-snaphot wellLayoutPop" style="display:none">
			<div class="j-form-popup">
<a href="javascript:void(0);" class="close"></a>
<div class="popup-title-overlay"></div>
<div class="pop-upinner-scroll">
			
			
				
				<form id="qpr-snapshot-change-Form_${qprSnapShot.snapShotID}" action="/new-synchro/qpr-snapshot!openFreezeProjects.jspa" method="POST" class="result-form-popup ">
					
					<#if qprSnapShot.getOpenProjectIds()?? && qprSnapShot.getOpenProjectIds()?size gt 0>
						
						<div class="region-inner">
						<label>Open Projects</label> 
						<#if qprSnapShot.getOpenBLProjectIds()??>
							<input type="text" tabindex="1"  name="disableOpenProject" id="disableOpenProject" value="${qprSnapShot.getOpenBLProjectIds()}" title="${qprSnapShot.getOpenBLProjectIds()}" /> 
						<#else>
							<input type="text" tabindex="1"  name="disableOpenProject" id="disableOpenProject" value="" title="" /> 
						</#if>	
						<#--<input type="hidden" name="freezeProjectIds" id="freezeProjectIds" value="${qprSnapShot.getProjectIds()}" />
						<br>
						<label></label>-->
						</div>
						
						<div class="region-inner">
						<label>Open Projects (Individual)</label> 
						<#if qprSnapShot.getOpenIndividualProjectIds()??>
							<input type="text" tabindex="1"  name="disableOpenProject" id="disableOpenProject" value="${qprSnapShot.getOpenIndividualProjectIds()}" title="${qprSnapShot.getOpenIndividualProjectIds()}" /> 
						<#else>
							<input type="text" tabindex="1"  name="disableOpenProject" id="disableOpenProject" value="" title="" /> 
						</#if>	
						<#--<input type="hidden" name="freezeProjectIds" id="freezeProjectIds" value="${qprSnapShot.getProjectIds()}" />
						<br>
						<label></label>-->
						</div>
						
						<div class="region-inner">
						<label>Enter Projects to freeze</label> 
						<input type="text" name="freezeProjectIds" id="freezeProjectIds" value="" />
						<input type="button" value="Freeze" onclick="submitFreezeProjects('${qprSnapShot.snapShotID}','Freeze')" class="btn-blue" />
						</div>
					</#if>
					<div class="region-inner">
					<label>Project Code </label><input type="text" tabindex="1" name="openProjectIds" id="openProjectIds_${qprSnapShot.snapShotID}" value="" /> 
					<input type="button" value="Open" onclick="submitFreezeProjects('${qprSnapShot.snapShotID}','Open')" class="btn-blue" />
					</div>
					
					
					
					<#if qprSnapShot.getOpenBudgetLocations()?? && qprSnapShot.getOpenBudgetLocations()?size gt 0>
						
						
						<#--<label>Open Budget Locations</label> <input type="text" tabindex="1" disabled name="disableOpenBudgetLoc" id="disableOpenBudgetLoc" value="${qprSnapShot.getBudgetLocations()}" /> 
						
						<input type="hidden" name="freezeBudgetLocations" id="freezeBudgetLocations" value="${qprSnapShot.getOpenBudgetLocationIds()}" />
						
						<input type="button" value="Freeze" onclick="submitFreezeBudgetLocation('${qprSnapShot.snapShotID}','Freeze')" class="btn-blue" />-->
						
						
						<#--<label>Open Budget Locations</label> -->
						
						<#list qprSnapShot.getOpenBudgetLocations() as openBL>
							<label>Open Budget Locations</label> 
							<div class="region-inner">
							<input type="text" tabindex="1" disabled name="disableOpenBudgetLoc" id="disableOpenBudgetLoc" value="${statics['com.grail.synchro.util.SynchroUtils'].getBudgetLocationName(openBL)}" /> 
							
							<input type="hidden" name="freezeBudgetLocations" id="freezeBudgetLocations_${qprSnapShot.snapShotID}" value="" />
							
							<input type="button" value="Freeze" onclick="submitFreezeBudgetLocationIndividual('${qprSnapShot.snapShotID}','Freeze', '${openBL}')" class="btn-blue" />
							</div>
						</#list>
						
					</#if>
					
					<div class="region-inner">
					<label>Budget Location </label>
					
					<select data-placeholder="Select the Budget Location" class="chosen-select" id = "budgetLocation_${qprSnapShot.snapShotID}" name="budgetLocation" >
						<option value=""></option>
						<option  value="-1"  >Global</option>
					
						<#assign regions = statics['com.grail.synchro.SynchroGlobal'].getRegions() />
						<#assign regionsKeySet = regions.keySet() />
						<#list regionsKeySet as key>
							<#if regions.get(key?int)=="Global">
							<#else>
								<option  value="${key}" >${regions.get(key?int)}</option>
							</#if>	
						</#list>
					
						<#assign endMarkets = statics['com.grail.synchro.SynchroGlobal'].getEndMarkets() />
						<#assign endMarketsKeySet = endMarkets.keySet() />
						
						<#list endMarketsKeySet as key>
							<#if endMarkets.get(key?int)=="Global">
							<#else>
								<option  value="${key}">${endMarkets.get(key?int)}</option>
							</#if>	
						</#list>
							
					</select>
						<input type="button" value="Open" onclick="submitFreezeBudgetLocation('${qprSnapShot.snapShotID}','Open')" class="btn-blue" />
					</div>
					
					<input type="hidden" name="snapshotId" id="snapshotId" value="${qprSnapShot.snapShotID}" />					
					
					
					<input type="hidden" name="operationType" id="operationType_${qprSnapShot.snapShotID}" value="" />
					
					<input type="hidden" name="entityType" id="entityType_${qprSnapShot.snapShotID}" value="" />
					
				</form>
				
				
				
				<form id="qpr-snapshot-download-Form_${qprSnapShot.snapShotID}" action="/new-synchro/qpr-snapshot!downloadSnapshot.jspa" method="POST" class="result-form-popup ">
					<input type="hidden" name="downloadSnapshotId" id="downloadSnapshotId" value="${qprSnapShot.snapShotID}" />			
				</form>
				
				<form id="qpr-snapshot-delete-Form_${qprSnapShot.snapShotID}" action="/new-synchro/qpr-snapshot!deleteSnapshot.jspa" method="POST" class="result-form-popup ">
					<input type="hidden" name="deleteSnapshotId" id="deleteSnapshotId" value="${qprSnapShot.snapShotID}" />			
				</form>
				
				<form id="qpr-snapshot-crosstab-Form_${qprSnapShot.snapShotID}" action="/new-synchro/qpr-snapshot!downloadCrosstabSnapshot.jspa" method="POST" class="result-form-popup ">
					<input type="hidden" name="downloadSnapshotId" id="downloadSnapshotId" value="${qprSnapShot.snapShotID}" />			
				</form>
				
				<form id="qpr-snapshot-crosstab-LC-Form_${qprSnapShot.snapShotID}" action="/new-synchro/qpr-snapshot!downloadLatestCostCrosstabSnapshot.jspa" method="POST" class="result-form-popup ">
					<input type="hidden" name="downloadSnapshotId" id="downloadSnapshotId" value="${qprSnapShot.snapShotID}" />			
				</form>
				
				
			</div>
			</div>
			</div>
			
		</#list>
	</#if>
	</div>
	<form id="qprSnapshotForm" name="qprSnapshotForm" action="/new-synchro/qpr-snapshot!execute.jspa" method="POST">
		<div class="region-inner clearfix">
		<div class="three-column">
			<label>Freeze Spend For</label>
			<@renderSpendByOptions name="spendFor"  multiselect=false/>
		</div>
		<div class="three-column">
			<@projectBudgetYearFieldNew name="budgetYear"  multiselect=false/>
		</div>
		<div class="three-column">
			<input type="button" value="Freeze" onclick="submitQPRSnapshot();" class="btn-blue" />
			
		</div>
		</div>
	</form>
	
	
	
</div>



	<div id="overlay">
		<img src="${themePath}/images/bigrotation.gif" id="img-load" />
	</div>

<script type="text/javascript">

function submitQPRSnapshot()
{
	var spendFor = $j("#spendFor").val();
	
	var budgetYear = $j("#budgetYear").val();
	
	var error = false;
	if(spendFor.trim()!=null && spendFor.trim()!="" && budgetYear!="" && budgetYear > 0)
	{
		<#if qprSnapShotList?? && qprSnapShotList?size gt 0>
		<#list qprSnapShotList as qprSnapShot>
			
			var spend = "${qprSnapShot.spendFor}";
			var budyear = "${qprSnapShot.budgetYear?c}";
			if(spend==spendFor && budyear==budgetYear)	
			{
				//error = true;
				/*dialog({
					title:"Message",
					html:"<p>It will ovewrite the existing value for this Snapshot</p>",

				});
				return false;
				*/
				error = true;
				dialog({
					title:"Message",
					html:"<p>You are trying to overwrite a previously saved snapshot with the same 'Freeze Spend For' and 'Budget Year'.</p><p>Are you sure that you would like to make this change?</p>",
					buttons:{
					"YES":function() {
						var qprSnapshotForm = $j("#qprSnapshotForm");
						qprSnapshotForm.submit();
					},
					"NO": function() {
						return false;
					}
				},

				});
			}
		</#list>
		</#if>
		if(error)
		{
		}
		else
		{
			var qprSnapshotForm = $j("#qprSnapshotForm");
			qprSnapshotForm.submit();
		}
	}
	else
	{
		dialog({
						title:"Message",
						html:"<p>Please select Freeze Spend For and Budget Year</p>",

					});
	}
}

function downloadCrossTabLatestCost()
{
	var budgetYear = $j("#latestCostBY").val();
	if(budgetYear!="" && budgetYear > 0)
	{
		var latestCostCrossTabForm = $j("#latestCostCrossTabForm");
		latestCostCrossTabForm.submit();
	}
	else
	{
		dialog({
			title:"Message",
			html:"<p>Please select Budget Year</p>",

		});
		
	}
	
}

function showChangeQPRSnapshot(snapshotId)
{
	$j("#qpr-snapshot-change_"+snapshotId).lightbox_me({centered:true,closeEsc:false,closeClick:false,overlayCSS:{background: 'black', opacity: .7}});
}


function downloadQPRSnapshot(snapshotId)
{
	var qprSnapshotDownloadForm = $j("#qpr-snapshot-download-Form_"+snapshotId);
	qprSnapshotDownloadForm.submit();
	
}

function downloadQPRCrosstabSnapshot(snapshotId)
{
	var qprSnapshotDownloadForm = $j("#qpr-snapshot-crosstab-Form_"+snapshotId);
	qprSnapshotDownloadForm.submit();
	
}


function downloadQPRCrosstabLatestCostSnapshot(snapshotId)
{
	
	var qprSnapshotDownloadForm = $j("#qpr-snapshot-crosstab-LC-Form_"+snapshotId);
	qprSnapshotDownloadForm.submit();
	
}


function deleteQPRSnapshot(snapshotId)
{
	dialog({
			title:"Message",
			html:"<p>Are you sure that you would like to delete this Snapshot?</p>",
			buttons:{
			"YES":function() {
				var qprSnapshotDeleteForm = $j("#qpr-snapshot-delete-Form_"+snapshotId);
				qprSnapshotDeleteForm.submit();
			},
			"NO": function() {
				return false;
			}
		},

		});
				
	
	
}

function closeChangeQPRSnapshot()
{
	$j("#qpr-snapshot-change").trigger('close');
}
function submitFreezeProjects(snapshotId, operationType)
{
	$j("#entityType_"+snapshotId).val('Project');
	if(operationType=="Freeze")
	{
		$j("#operationType_"+snapshotId).val('Freeze');
		var qprSnapshotChangeForm = $j("#qpr-snapshot-change-Form_"+snapshotId);
		qprSnapshotChangeForm.submit();
	}
	if(operationType=="Open")
	{
		
		var openProjectIds = $j("#openProjectIds_"+snapshotId).val();
		
		
		$j("#operationType_"+snapshotId).val('Open');
		if(openProjectIds=="")
		{
			dialog({title:"Message",html:"Please enter Project Code"});
			return false;
		}
		else{
			var qprSnapshotChangeForm = $j("#qpr-snapshot-change-Form_"+snapshotId);
			qprSnapshotChangeForm.submit();
		}
	}
	
}

function submitFreezeBudgetLocation(snapshotId, operationType)
{
	$j("#entityType_"+snapshotId).val('Budget Location');
	if(operationType=="Freeze")
	{
		$j("#operationType_"+snapshotId).val('Freeze');
		var qprSnapshotChangeForm = $j("#qpr-snapshot-change-Form_"+snapshotId);
		qprSnapshotChangeForm.submit();
	}
	if(operationType=="Open")
	{
		
		var openBudgetLocation = $j("#budgetLocation_"+snapshotId).val();
		
		
		
		var freezeBL = $j("#freezeBudgetLocations").val();
		if(freezeBL!=undefined)
		{
			if(freezeBL.includes(","))
			{
				var blArray = freezeBL.split(",");
				var error = false;
				for(var i=0;i<blArray.length;i++)
				{
					if(openBudgetLocation==blArray[i])
					{
						error = true;
					}
				}
				if(error)
				{
					dialog({title:"Message",html:"Please select other Budget Location"});
					return false;
				}
			}
			else
			{
				if(openBudgetLocation==freezeBL)
				{
					dialog({title:"Message",html:"Please select other Budget Location"});
					return false;
				}
			}
		}
		
		
		
		$j("#operationType_"+snapshotId).val('Open');
		if(openBudgetLocation=="")
		{
			dialog({title:"Message",html:"Please select Budget Location"});
			return false;
		}
		else{
			var qprSnapshotChangeForm = $j("#qpr-snapshot-change-Form_"+snapshotId);
			qprSnapshotChangeForm.submit();
		}
	}
	
}

function submitFreezeBudgetLocationIndividual(snapshotId, operationType, budgetLocation)
{
	$j("#entityType_"+snapshotId).val('Budget Location');
	if(operationType=="Freeze")
	{
		$j("#operationType_"+snapshotId).val('Freeze');
		$j("#freezeBudgetLocations_"+snapshotId).val(budgetLocation);
		var qprSnapshotChangeForm = $j("#qpr-snapshot-change-Form_"+snapshotId);
		qprSnapshotChangeForm.submit();
	}
	
	
}
</script>
