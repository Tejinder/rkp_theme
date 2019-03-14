function toggle()
{
    if($j(".result-filter").css('display') == 'none') {
        //	$j("#dashboard_menu mt_stuff").hide();
        //$j("#search_box").hide();
        $j(".result-filter").lightbox_me({centered:true,closeEsc:false,overlayCSS:{background: 'black', opacity: .7}});
        //$j("#advanced_search").hide();
        //$j(".adv-close").hide();
        //centerPopup();
        //load popup
        //loadPopup();
		auditLogs();
		
    } else {
        $j(".result-filter").trigger('close');
        $j("#search_box").show();
        $j("#advanced_search").show();
        $j(".adv-close").show();
    }
}
function getURLParameter(name) {
    return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null
}

function resetSearchFilters()
{
   // alert("Working...")
    $j("input[name='name']").val("");
    $j("#startYear option:first").attr('selected','selected');
    $j("#startMonth option:first").attr('selected','selected');
    $j("#endYear option:first").attr('selected','selected');
    $j("#endMonth option:first").attr('selected','selected');
    $j("#methodologyFields-reload").click();
    $j("#brandFields-reload").click();
    $j("#owner-reload").click();
    $j("#initiatorFields-reload").click();
    $j("#regionFields-reload").click();
    $j(".synchro #endmarkets-reload").click();
    $j("#projectStatusFields-reload").click();
    $j("#projectActivityFields-reload").click();
    $j("#projectSupplierFields-reload").click();
    $j("#spi-contacts-reload").click();
    $j("#agencies-reload").click();
    $j("#kantar-project-initiator-reload").click();
    $j(".kantar #endmarkets-reload").click();
    $j("#kantar-methodologies-reload").click();
    $j("#deliveryDateFrom").val("");
    $j("#deliveryDateTo").val("");
    $j("#kantar-project-batcontact-reload").click();
    $j("#kantar-report-authors-reload").click();
    $j("#kantar-reporttype-reload").click();
	$j("#portalFields-reload").click();
	$j("#pageFields-reload").click();
	$j("#activityFields-reload").click();	
	$j("#startDateLog").val("");
	$j("#endDateLog").val("");
	
	resetProjectTypes();
	resetProjectStatus();
	resetProjectStages();
	resetTPDStatus();
	resetProjectDuration();
	resetProjectManager();
	resetProjectInitiator();
	resetCategoryTypes();
	resetResearchEndMarkets();
	resetResearchAgencies();
	resetMethodologyDetails();
	resetMethodologyTypes();
	resetBrands();
	resetBudgetLocations();
	resetBudgetYears();
	resetTotalCost();
	resetWaiverInitiator();
	resetWaiverStatus();
	resetActionPendings();
	resetCostComponents();
	resetTPDSubmitDateDuration();
	
}

function clearTags() {
    $j("#name-tag").hide();
    $j("#name-tag").text("");
    $j("#owner-tag").hide();
    $j("#spiContacts-tag").hide();
    $j("#agencies-tag").hide();
    $j("#agency-names-tag").hide();
    $j("#date-tag").hide();
    $j("#methodology-tag").hide();
    $j("#brand-tag").hide();
    $j("#region-tag").hide();
    $j("#country-tag").hide();
    $j("#status-tag").hide();
    $j("#activity-tag").hide();
    $j("#supplier-tag").hide();
    $j("#kantar-owner-tag").hide();
    $j("#kantar-market-tag").hide();
    $j("#kantar-methodology-type-tag").hide();
    $j("#kantar-delivery-date-tag").hide();
    $j("#kantar-bat-contact-tag").hide();
    $j("#kantar-report-author-tag").hide();
    $j("#kantar-report-type-tag").hide();
    $j("#kantar-report-name-tag").hide();
    $j("#kantar-report-name-tag").text("");
	$j("#log-timestamp-tag").hide();
	$j("#log-portal-tag").hide();
	$j("#log-page-tag").hide();
	$j("#log-activity-tag").hide();
	
	$j("#project-type-tag").hide();
	$j("#project-status-tag").hide();
	$j("#project-stage-tag").hide();
	$j("#project-duration-tag").hide();
	$j("#project-manager-tag").hide();
	$j("#project-initiator-tag").hide();
	$j("#category-type-tag").hide();
	$j("#research-endmarkets-tag").hide();
	
	$j("#research-agencies-tag").hide();
	$j("#methodology-details-tag").hide();
	$j("#methodology-type-tag").hide();
	$j("#brands-type-tag").hide();
	$j("#budget-locations-tag").hide();
	$j("#budget-years-tag").hide();
	$j("#total-cost-tag").hide();
	$j("#waiverInitiator-tag").hide();
	$j("#waiverStatus-tag").hide();
	
	$j("#creation-date-tag").hide();
	$j("#actionPendings-tag").hide();
	$j("#cost-components-tag").hide();

}

function isfilterSet()
{
    clearTags();

    var flag = false;
    var name = $j("input[name='name']").val() ;
    if(name!=null && $j.trim(name)!="")
    {
        flag = true;
        $j("#name-tag").text(truncate(name,15));
        $j("#name-tag").show();
    }
    if($j("#ownerfield option:selected").length>0)
    {
        flag = true;
        $j("#owner-tag").show();
    }

    if($j("#spiContacts option:selected").length>0)
    {
        flag = true;
        $j("#spiContacts-tag").show();
    }

    if($j("#agencies option:selected").length>0)
    {
        flag = true;
        $j("#agencies-tag").show();
    }


    if($j("#agencyNames option:selected").length>0)
    {
        flag = true;
        $j("#agency-names-tag").show();
    }

    if($j("#startYear option:selected").val()>0 || $j("#startMonth option:selected").val()>0)
    {
        flag = true;
        $j("#date-tag").show();
    }

    if($j("#endYear option:selected").val()>0 || $j("#endMonth option:selected").val()>0)
    {
        flag = true;
        $j("#date-tag").show();
    }


    if($j("#methodologyFields option:selected").length>0)
    {
        flag = true;
        $j("#methodology-tag").show();
    }
    if($j("#brandFields option:selected").length>0)
    {
        flag = true;
        $j("#brand-tag").show();
    }

    if($j("#regionFields option:selected").length>0)
    {
        flag = true;
        $j("#region-tag").show();
    }
    if($j(".synchro #endMarkets option:selected").length>0)
    {
        flag = true;
        $j("#country-tag").show();
    }
    if($j("#projectStatusFields option:selected").length>0)
    {
        flag = true;
        $j("#status-tag").show();
    }
    if($j("#projectActivityFields option:selected").length>0)
    {
        flag = true;
        $j("#activity-tag").show();
    }

    if($j("#projectSupplierFields option:selected").length>0)
    {
        flag = true;
        $j("#supplier-tag").show();
    }

//    ---

    if($j("#initiators option:selected").length>0) {
        flag = true;
        $j("#kantar-owner-tag").show();
    }

    if($j(".kantar #endMarkets option:selected").length>0) {
        flag = true;
        $j("#kantar-market-tag").show();
    }

    if($j("#methodologies option:selected").length>0) {
        flag = true;
        $j("#kantar-methodology-type-tag").show();
    }

    if(($j("#deliveryDateFrom").val() != undefined && $j("#deliveryDateFrom").val() != "")
        || ($j("#deliveryDateTo").val() != undefined && $j("#deliveryDateTo").val() != "")) {
        console.log($j("#deliveryDateFrom").val() + " ::: " + $j("#deliveryDateTo").val())
        flag = true;
        $j("#kantar-delivery-date-tag").show();
    }

    if($j("#batContacts option:selected").length>0) {
        flag = true;
        $j("#kantar-bat-contact-tag").show();
    }

    if($j("#authors option:selected").length>0) {
        flag = true;
        $j("#kantar-report-author-tag").show();
    }

    if($j("#reportTypes option:selected").length>0) {
        flag = true;
        $j("#kantar-report-type-tag").show();
    }

    var kantarReportName = $j("input[name='reportName']").val() ;
    if(kantarReportName!=null && $j.trim(kantarReportName)!="")
    {
        flag = true;
        $j("#kantar-report-name-tag").text(truncate(kantarReportName,15));
        $j("#kantar-report-name-tag").show();
    }

	//Log Dashboard
	var logStartDate = $j("#startDateLog");
	var logEndDate = $j("#endDateLog");
	if(logStartDate && logStartDate.val()!=null && $j.trim(logStartDate.val())!="")
    {
        flag = true;
        $j("#log-timestamp-tag").show();
    }
	if(logEndDate && logEndDate.val()!=null && $j.trim(logEndDate.val())!="")
    {
        flag = true;
        $j("#log-timestamp-tag").show();
    }
	if($j("#portalFields option:selected").length>0)
    {
        flag = true;
        $j("#log-portal-tag").show();
    }
	if($j("#pageFields option:selected").length>0)
    {
        flag = true;
        $j("#log-page-tag").show();
    }
	if($j("#activityFields option:selected").length>0)
    {
        flag = true;
        $j("#log-activity-tag").show();
    }
	
	// Synchro New Requirement Filters
	if($j("#projectTypes option:selected").length>0)
    {
        if($j("#projectTypes option:selected").val()!="")
		{
			flag = true;
			$j("#project-type-tag").show();
		}
    }
	if($j("#projectStatus option:selected").length>0)
    {
        
		if($j("#projectStatus option:selected").val()!="")
		{
			flag = true;
			$j("#project-status-tag").show();
		}
    }
	if($j("#projectStages option:selected").length>0)
    {
        
		if($j("#projectStages option:selected").val()!="")
		{
			flag = true;
			$j("#project-stage-tag").show();
		}
    }
	var startDateBegin = $j("input[name='startDateBegin']").val();
	var startDateComplete = $j("input[name='startDateComplete']").val();
	var endDateBegin = $j("input[name='endDateBegin']").val();
	var endDateComplete = $j("input[name='endDateComplete']").val();
	
	if((startDateBegin!=null && startDateBegin!="") || (startDateComplete!=null && startDateComplete!="") || (endDateBegin!=null && endDateBegin!="") || (endDateComplete!=null && endDateComplete!=""))
	{
		flag = true;
		$j("#project-duration-tag").show();
	}
	
	var projManager = $j("input[name='projManager']").val();
	if(projManager!=null && projManager!="") 
	{
		flag = true;
		$j("#project-manager-tag").show();
	}
	
	var projectInitiator = $j("input[name='projectInitiator']").val();
	if(projectInitiator!=null && projectInitiator!="") 
	{
		flag = true;
		$j("#project-initiator-tag").show();
	}

	if($j("#categoryTypes option:selected").length>0)
    {
        
		if($j("#categoryTypes option:selected").val()!="")
		{
			flag = true;
			$j("#category-type-tag").show();
		}
    }
	
	if($j("#researchEndMarkets option:selected").length>0)
    {
		if($j("#researchEndMarkets option:selected").val()!="")
		{
			flag = true;
			$j("#research-endmarkets-tag").show();
		}
    }
	
	if($j("#researchAgencies option:selected").length>0)
    {
		if($j("#researchAgencies option:selected").val()!="")
		{
			flag = true;
			$j("#research-agencies-tag").show();
		}
    }
	
	if($j("#methDetails option:selected").length>0)
    {
		if($j("#methDetails option:selected").val()!="")
		{
			flag = true;
			$j("#methodology-details-tag").show();
		}
    }
	if($j("#methodologyTypes option:selected").length>0)
    {
		if($j("#methodologyTypes option:selected").val()!="")
		{
			flag = true;
			$j("#methodology-type-tag").show();
		}
    }
	
	if($j("#brands option:selected").length>0)
    {
		if($j("#brands option:selected").val()!="")
		{
			flag = true;
			$j("#brands-type-tag").show();
		}
    }
	
	if($j("#budgetLocations option:selected").length>0)
    {
		if($j("#budgetLocations option:selected").val()!="")
		{
			flag = true;
			$j("#budget-locations-tag").show();
		}
    }
	
	if($j("#budgetYears option:selected").length>0)
    {
		if($j("#budgetYears option:selected").val()!="")
		{
			flag = true;
			$j("#budget-years-tag").show();
		}
    }
	
	var totalCostStart = $j("input[name='totalCostStart']").val();
	var totalCostEnd = $j("input[name='totalCostEnd']").val();
	
	if((totalCostStart!=null && totalCostStart!="") || (totalCostEnd!=null && totalCostEnd!=""))
	{
		flag = true;
		$j("#total-cost-tag").show();
	}
	
	var waiverInitiator = $j("input[name='waiverInitiator']").val();
	if((waiverInitiator!=null && waiverInitiator!=""))
	{
		flag = true;
		$j("#waiverInitiator-tag").show();
	}
	
	if($j("#waiverStatus option:selected").length>0)
    {
		if($j("#waiverStatus option:selected").val()!="")
		{
			flag = true;
			$j("#waiverStatus-tag").show();
		}
    }
	
	if($j("#actionPendings option:selected").length>0)
    {
		if($j("#actionPendings option:selected").val()!="")
		{
			flag = true;
			$j("#actionPendings-tag").show();
		}
    }
	
	var creationDateBegin = $j("input[name='creationDateBegin']").val();
	var creationDateComplete = $j("input[name='creationDateComplete']").val();
	
	
	if((creationDateBegin!=null && creationDateBegin!="") || (creationDateComplete!=null && creationDateComplete!=""))
	{
		flag = true;
		$j("#creation-date-tag").show();
	}
	
	
	if($j("#costComponents option:selected").length>0)
    {
		if($j("#costComponents option:selected").val()!="")
		{
			flag = true;
			$j("#cost-components-tag").show();
		}
    }
	
	if($j("#tpdStatus option:selected").length>0)
    {
        
		if($j("#tpdStatus option:selected").val()!="")
		{
			flag = true;
			$j("#tpdStatus-tag").show();
		}
    }
	
	var tpdSubmitBegin = $j("input[name='tpdSubmitDateBegin']").val();
	var tpdSubmitDateComplete = $j("input[name='tpdSubmitDateComplete']").val();
	
	
	if((tpdSubmitBegin!=null && tpdSubmitBegin!="") || (tpdSubmitDateComplete!=null && tpdSubmitDateComplete!="") )
	{
		flag = true;
		$j("#tpd-submit-date-tag").show();
	}
	
    return flag;

}
$j(document).ready(function () {

    $j("#name-tag").click(function(){
        $j(this).text("");
        $j(this).hide();
        resetName();
        processPaginationRequest(1,"");
    });
    $j("#owner-tag").click(function(){
        resetOwner();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
    $j("#spiContacts-tag").click(function(){
        resetSPIContacts();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
    $j("#agencies-tag").click(function(){
        resetAgencies();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
    $j("#agency-names-tag").click(function(){
        resetAgencyNames();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
    $j("#date-tag").click(function(){
        resetDate();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
    $j("#methodology-tag").click(function(){
        resetMethodology();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
    $j("#brand-tag").click(function(){
        resetBrand();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
    $j("#region-tag").click(function(){
        resetRegion();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
    $j("#country-tag").click(function(){
        resetCountry();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
    $j("#status-tag").click(function(){
        resetStatus();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
    $j("#activity-tag").click(function(){
        resetActivity();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
    $j("#supplier-tag").click(function(){
        resetSupplier();
        $j(this).hide();
        processPaginationRequest(1,"");
    });

    $j("#kantar-owner-tag").click(function(){
        resetKantarButtonOwner();
        $j(this).hide();
        processPaginationRequest(1,"");
    });

    $j("#kantar-market-tag").click(function(){
        resetKantarButtonMarket();
        $j(this).hide();
        processPaginationRequest(1,"");
    });

    $j("#kantar-report-author-tag").click(function(){
        resetKantarReportAuthor();
        $j(this).hide();
        processPaginationRequest(1,"");
    });

    $j("#kantar-report-type-tag").click(function(){
        resetKantarReportType();
        $j(this).hide();
        processPaginationRequest(1,"");
    });

    $j("#kantar-methodology-type-tag").click(function(){
        resetKantarButtonMethodology();
        $j(this).hide();
        processPaginationRequest(1,"");
    });

    $j("#kantar-delivery-date-tag").click(function(){
        resetKantarButtonDeliveryDates();
        $j(this).hide();
        processPaginationRequest(1,"");
    });

    $j("#kantar-bat-contact-tag").click(function(){
        resetKantarButtonBatContact();
        $j(this).hide();
        processPaginationRequest(1,"");
    });

    $j("#kantar-report-name-tag").click(function(){
        $j(this).text("");
        $j(this).hide();
        resetKantarReportName();
        processPaginationRequest(1,"");
    });
	$j("#log-timestamp-tag").click(function(){
        resetLogTimestamp();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	$j("#log-portal-tag").click(function(){
        resetLogPortal();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	$j("#log-page-tag").click(function(){
        resetLogPage();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	$j("#log-activity-tag").click(function(){
        resetLogActivity();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
    $j(".adv-close").click(function(){
        $j(".adv-close").hide();
        resetSearchFilters();
        $j("#advanced_search").removeClass("projectfilter");
        processPaginationRequest(1,"");
        if($j("#search_box").css('display') == 'none')
        {
            $j("#search_box").show();
        }
    });

	
	$j("#project-type-tag").click(function(){
        resetProjectTypes();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#project-status-tag").click(function(){
        resetProjectStatus();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#project-stage-tag").click(function(){
        resetProjectStages();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#tpdStatus-tag").click(function(){
        resetTPDStatus();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	
	$j("#project-duration-tag").click(function(){
        resetProjectDuration();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#tpd-submit-date-tag").click(function(){
        resetTPDSubmitDateDuration();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#project-manager-tag").click(function(){
        resetProjectManager();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#project-initiator-tag").click(function(){
        resetProjectInitiator();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#category-type-tag").click(function(){
        resetCategoryTypes();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#research-endmarkets-tag").click(function(){
        resetResearchEndMarkets();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#research-agencies-tag").click(function(){
        resetResearchAgencies();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#methodology-details-tag").click(function(){
        resetMethodologyDetails();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#methodology-type-tag").click(function(){
        resetMethodologyTypes();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#brands-type-tag").click(function(){
        resetBrands();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#budget-locations-tag").click(function(){
        resetBudgetLocations();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#budget-years-tag").click(function(){
        resetBudgetYears();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#total-cost-tag").click(function(){
        resetTotalCost();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#waiverInitiator-tag").click(function(){
        resetWaiverInitiator();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#waiverStatus-tag").click(function(){
        resetWaiverStatus();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#actionPendings-tag").click(function(){
        resetActionPendings();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#creation-date-tag").click(function(){
        resetCreationDateDuration();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
	$j("#cost-components-tag").click(function(){
        resetCostComponents();
        $j(this).hide();
        processPaginationRequest(1,"");
    });
	
    $j(".popup-search").click(function(){
        if($j('.total-cost-field').length < 1)
	   {
		   toggle();   
		    //close pop up filter window
	   }
       else
	   {
		   if(!checkGBPBetweenAnd()){
			   dialog({
					title:"Message",
					html:"<p>'And' value should be greater than 'Between' value</p>",
					buttons:{
					"OK":function() {
						$j("#startDateComplete").val('');
						return false;		
					}
				 }
				});
		   }
		   else toggle(); 
		   
		
	   }
        disablePopup();
        if(isfilterSet())
        {
            $j("#advanced_search").addClass("projectfilter");
            $j(".adv-close").show();
        }
        else
        {
            $j("#advanced_search").removeClass("projectfilter");
            $j(".adv-close").hide();
        }
        $j(".search_box").val("");
        $j("#sortField").val("");
        $j("#ascendingOrder").val("");
        processPaginationRequest(1,"");
    });

    $j(".popup-search-reset").click(function(){
        resetSearchFilters();
    });
    $j(".close-btn").click(function(){
        toggle();
//        //resetSearchFilters();
        disablePopup();
//        processPaginationRequest(1,"");
//        if(isfilterSet())
//        {
//            $j("#advanced_search").addClass("projectfilter");
//            $j(".adv-close").show();
//        }
//        else
//        {
//            $j("#advanced_search").removeClass("projectfilter");
//            $j(".adv-close").hide();
//        }
    });

    $j("#advanced_search").click(function(){
        toggle();
    });

    $j(".cancel").click(function(){
        toggle();
        resetSearchFilters();
        clearTags();
        disablePopup();
        processPaginationRequest(1,"");
    });


    /*$j("#backgroundPopup").click(function(){
     toggle();
     resetSearchFilters();
     disablePopup();
     processPaginationRequest(1,"");
     });*/
    //Press Escape event!

    $j(document).keypress(function(e){
        if(e.keyCode==27 && popupStatus==1){
            toggle();
            resetSearchFilters();
            disablePopup();
            processPaginationRequest(1,"");
        }
    });

/*
    $j("#result-filter-form").submit(function( event ) {
        $j(".popup-search").click();
        event.preventDefault();
    });
*/
});

var popupStatus = 0;


function loadPopup(){
    //loads popup only if it is disabled
    if(popupStatus==0){
        $j("#backgroundPopup").css({
            "opacity": "0.7"
        });
        $j("#backgroundPopup").fadeIn("slow");
        $j(".result-filter").fadeIn("slow");
        popupStatus = 1;
    }
}

//disabling popup with jQuery magic!
function disablePopup(){
    //disables popup only if it is enabled
    if(popupStatus==1){
        $j("#backgroundPopup").fadeOut("slow");
        $j(".result-filter").fadeOut("slow");
        popupStatus = 0;
    }
}

//centering popup
function centerPopup(){
    //request data for centering
    var windowWidth = document.documentElement.clientWidth;
    var windowHeight = document.documentElement.clientHeight;
    var popupHeight = $j(".result-filter").height();
    var popupWidth = $j(".result-filter").width();
    //centering
    $j(".result-filter").css({
        "position": "absolute",
        "top": windowHeight/2-popupHeight/2,
        "left": windowWidth/2-popupWidth/2
    });
    //only need force for IE6

    $j("#backgroundPopup").css({
        "height": windowHeight
    });

}
function resetName()
{
    $j("input[name='name']").val("");
}

function resetOwner()
{
    $j("#owner-reload").click();
    $j("#initiatorFields-reload").click();
}


function resetSPIContacts()
{
    $j("#spi-contacts-reload").click();
}
function resetAgencies()
{
    $j("#agencies-reload").click();
}

function resetAgencyNames()
{
    $j("#agency-names-reload").click();
}

function resetKantarButtonOwner()
{
    $j("#kantar-project-initiator-reload").click();
}

function resetKantarButtonMarket()
{
    $j("#endmarkets-reload").click();
}

function resetKantarReportAuthor()
{
    $j("#kantar-report-authors-reload").click();
}

function resetKantarReportType()
{
    $j("#kantar-reporttype-reload").click();
}

function resetLogTimestamp()
{
	
	$j("#startDateLog").val("");
	$j("#endDateLog").val("");
}
function resetLogPortal()
{
	$j("#portalFields-reload").click();
}
function resetLogPage()
{
	$j("#pageFields-reload").click();
}
function resetLogActivity()
{
	$j("#activityFields-reload").click();
}

function resetKantarButtonMethodology()
{
    $j("#kantar-methodologies-reload").click();
}

function resetKantarButtonDeliveryDates()
{
    $j("#deliveryDateFrom").val("");
    $j("#deliveryDateTo").val("");
}

function resetKantarButtonBatContact()
{
    $j("#kantar-project-batcontact-reload").click();
}

function resetDate()
{
    $j("#startYear option:first").attr('selected','selected');
    $j("#startMonth option:first").attr('selected','selected');
    $j("#endYear option:first").attr('selected','selected');
    $j("#endMonth option:first").attr('selected','selected');
}

function resetMethodology()
{
    $j("#methodologyFields-reload").click();
}

function resetBrand()
{
    $j("#brandFields-reload").click();
}

function resetRegion()
{
    $j("#regionFields-reload").click();
}
function resetCountry()
{
    $j("#endmarkets-reload").click();
}
function resetStatus()
{
    $j("#projectStatusFields-reload").click();
}
function resetActivity()
{
    $j("#projectActivityFields-reload").click();
}
function resetSupplier()
{
    $j("#projectSupplierFields-reload").click();
}

function resetKantarReportName()
{
    $j("input[name='reportName']").val("");
}

function resetProjectTypes()
{
	$j('select[name="projectTypes"]').val('').trigger('chosen:updated');
}
function resetProjectStatus()
{
	
	$j('#projectStatus').val('').trigger('chosen:updated');
}
function resetProjectStages()
{
	$j('select[name="projectStages"]').val('').trigger('chosen:updated');
}

function resetTPDStatus()
{
	$j('select[name="tpdStatus"]').val('').trigger('chosen:updated');
}

function resetProjectDuration()
{
	$j("input[name='startDateBegin']").val("");
	$j("input[name='startDateComplete']").val("");
	$j("input[name='endDateBegin']").val("");
	$j("input[name='endDateComplete']").val("");
	
}

function resetTPDSubmitDateDuration()
{
	$j("input[name='tpdSubmitDateBegin']").val("");
	$j("input[name='tpdSubmitDateComplete']").val("");
	
	
}

function resetProjectManager()
{
	$j("input[name='projManager']").val("");
}

function resetProjectInitiator()
{
	$j("input[name='projectInitiator']").val("");
}

function resetCategoryTypes()
{
	$j('select[name="categoryTypes"]').val('').trigger('chosen:updated');
}

function resetResearchEndMarkets()
{
	$j('select[name="researchEndMarkets"]').val('').trigger('chosen:updated');
}

function resetResearchAgencies()
{
	$j('select[name="researchAgencies"]').val('').trigger('chosen:updated');
}

function resetMethodologyDetails()
{
	$j('select[name="methDetails"]').val('').trigger('chosen:updated');
}

function resetMethodologyTypes()
{
	$j('select[name="methodologyTypes"]').val('').trigger('chosen:updated');
}

function resetBrands()
{
	$j('select[name="brands"]').val('').trigger('chosen:updated');
}

function resetBudgetLocations()
{
	$j('select[name="budgetLocations"]').val('').trigger('chosen:updated');
}

function resetBudgetYears()
{
	$j('select[name="budgetYears"]').val('').trigger('chosen:updated');
}

function resetTotalCost()
{
	$j("input[name='totalCostStart']").val("");
	$j("input[name='totalCostEnd']").val("");
}
function resetWaiverInitiator()
{
	$j("input[name='waiverInitiator']").val("");
}
function resetWaiverStatus()
{
	$j('select[name="waiverStatus"]').val('').trigger('chosen:updated');
}
function resetActionPendings()
{
	$j('select[name="actionPendings"]').val('').trigger('chosen:updated');
}

function resetCreationDateDuration()
{
	$j("input[name='creationDateBegin']").val("");
	$j("input[name='creationDateComplete']").val("");

}

function resetCostComponents()
{
	$j('select[name="costComponents"]').val('').trigger('chosen:updated');
}

function truncate(str, len)
{
    if(str.length>len)
    {
        var substr = str.substring(0,len)+"...";
        return substr;
    }
    else
    {
        return str;
    }
}

function selectAllFilterBoxes()
{
    var owners = $j("#ownerfield").find("option");
    owners.each(function(optionEle) {
        owners[optionEle].selected = 'selected';
    });

    var spiContacts = $j("#spiContacts").find("option");
    spiContacts.each(function(optionEle) {
        spiContacts[optionEle].selected = 'selected';
    });

    var agencies = $j("#agencies").find("option");
    agencies.each(function(optionEle) {
        agencies[optionEle].selected = 'selected';
    });

    var agencyNames = $j("#agencyNames").find("option");
    agencyNames.each(function(optionEle) {
        agencyNames[optionEle].selected = 'selected';
    });

    var regionFields = $j("#regionFields").find("option");
    regionFields.each(function(optionEle) {
        regionFields[optionEle].selected = 'selected';
    });

    var endMarkets = $j("#endMarkets").find("option");
    endMarkets.each(function(optionEle) {
        endMarkets[optionEle].selected = 'selected';
    });

    var methodologyFields = $j("#methodologyFields").find("option");
    methodologyFields.each(function(optionEle) {
        methodologyFields[optionEle].selected = 'selected';
    });

    var brandFields = $j("#brandFields").find("option");
    brandFields.each(function(optionEle) {
        brandFields[optionEle].selected = 'selected';
    });

    var projectStatusFields = $j("#projectStatusFields").find("option");
    projectStatusFields.each(function(optionEle) {
        projectStatusFields[optionEle].selected = 'selected';
    });

    var projectActivityFields = $j("#projectActivityFields").find("option");
    projectActivityFields.each(function(optionEle) {
        projectActivityFields[optionEle].selected = 'selected';
    });

    var projectSupplierFields = $j("#projectSupplierFields").find("option");
    projectSupplierFields.each(function(optionEle) {
        projectSupplierFields[optionEle].selected = 'selected';
    });
	
	var portalFields = $j("#portalFields").find("option");
    portalFields.each(function(optionEle) {
        portalFields[optionEle].selected = 'selected';
    });
	var pageFields = $j("#pageFields").find("option");
    pageFields.each(function(optionEle) {
        pageFields[optionEle].selected = 'selected';
    });
	var activityFields = $j("#activityFields").find("option");
    activityFields.each(function(optionEle) {
        activityFields[optionEle].selected = 'selected';
    });
}
function  checkGBPBetweenAnd()
{    
     var totalCostBetween= parseFloat($j(".totalCostBetween").val());
	 var totalCostAnd= parseFloat($j(".totalCostAnd").val());
	 
	if(($j(".totalCostBetween").val()) =="" && ($j(".totalCostAnd").val()==""))
	{
		  return true;
    }
	if(totalCostAnd>=totalCostBetween)
    {
	    return true;
	}
	else
	{
        return false;
	}
}

function  onChangeTotalCost()
{    
    var totalCostBetween= parseFloat($j(".totalCostBetween").val());
	var totalCostAnd= parseFloat($j(".totalCostAnd").val());
	
	var error = true;	
	if(($j(".totalCostBetween").val()) =="" ||  ($j(".totalCostAnd").val()==""))
	{
		  error = false;
    }
	if(error && totalCostAnd>=totalCostBetween)
    {
	    error = false;	
	}
	
	
   
   if(error)
	 {
			   dialog({
					title:"Message",
					html:"<p>'And' value should be greater than 'Between' value</p>",
					buttons:{
					"OK":function() {
						return false;		
					}
				 }
				});
		   }	
}


