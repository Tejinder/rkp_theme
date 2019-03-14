function fetchUserDrillDownPage(pageStart, resetStart){
		var userID = $('user_id').value;
		var activityType =  $('act_type').value;
		var numResults =  $('ajxNumResults').value;
		var pageStart = pageStart;
		if(resetStart){
			pageStart = 0;
		}
		var dateStart = $('dateStart').value;
		var dateEnd = $('dateEnd').value;
		var paginatorParams = {
		    numResults: numResults,
		    start: pageStart,
		    userID:userID,
		    activityType:activityType,
		    dateStart: dateStart,
		    dateEnd: dateEnd
		  };
		new Ajax.Updater("user_doc_drilldown_report_data", "userDrillDownReport.jspa", {
			method: 'get',
			asynchronous:true,
			evalScripts:true,
			parameters: paginatorParams
	});

}

function fetchDocumentDrillDownPage(pageStart, resetStart){
		var docID = $('doc_id').value;
		var activityType =  $('act_type').value;
		var numResults =  $('ajxNumResults').value;
		var pageStart = pageStart;
		if(resetStart){
			pageStart = 0;
		}
		var dateStart = $('dateStart').value;
		var dateEnd = $('dateEnd').value;
		var paginatorParams = {
		    numResults: numResults,
		    start: pageStart,
		    userID:docID,
		    activityType:activityType,
		    dateStart: dateStart,
		    dateEnd: dateEnd
		};

		  new Ajax.Updater("document_doc_drilldown_report_data", "documentDrillDownReport.jspa", {
			method: 'get',
			asynchronous:true,
			evalScripts:true,
			parameters: paginatorParams
	      });
}


