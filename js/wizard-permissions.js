$j("#project_publish_link").click(function() {
			var props = {buttons: {"Yes": publishForm,"No": function() {}}};
			dialog(props);
			$j("#dialog-box").html('Are you sure you want to publish the project ?');		
	});
	
function publishForm() {
		setApproverPermissions("");	
		var form = $j("#form-create");
		$j('#form-create').attr('action', 'publish.jspa');		
		console.log(form);
		jive.util.securedForm(form).always(function() {
		console.log("submit the form");
		form.submit();            
	});

}

$j('.wizard-menus ul li a').click(function(event) {
    event.preventDefault();
	if($j(this).attr("id") == "active-link")
	{
		var href = $j(this).attr("href");
		if(href != "#")
		{
			$j("#redirecturl").val(href);
			var props = {buttons: {"Yes": saveAndSubmitForm, "No": function() {window.location.href = href;}}};
			dialog(props);
			$j("#dialog-box").html('Do you want to save changes?');		
		}	
	}
});
	
function saveAndSubmitForm()
{	
	$j("#dialog-box").html('Saving changes. Please wait...');
	$j(".ui-dialog-titlebar").hide();		
	$j(".ui-dialog-buttonset button").each(function() {
		$j(this).hide();
	});		
	setApproverPermissions($j("#redirecturl").val());	
}
	
	var checked_list = [];
	var unchecked_list = [];
	
	$j(function () {
	$j("table tbody td input[type=checkbox]").click(function(){		
		if ($j(this).attr("checked"))
		{	
			var selectedVal = $j(this).val();
			if($j.inArray(selectedVal, checked_list) < 0)
			{
				//Add element to checked list array	
				checked_list.push(selectedVal);				
			}
			if($j.inArray(selectedVal, unchecked_list) > -1)
			{
				//Remove element from un-checked list array				
				unchecked_list = jQuery.grep(unchecked_list, function(value) 
				{				
					return value != selectedVal;
				});				
			}			
		} 
		else 
		{
			var unselectedVal = $j(this).val();			
			if($j.inArray(unselectedVal, checked_list) > -1)
			{
				//Remove element from checked list array								
				checked_list = jQuery.grep(checked_list, function(value) 
				{
					return value != unselectedVal;
				});				
			}			
			if($j.inArray(unselectedVal, unchecked_list) < 0)
			{
				//Add element to un-checked list array			
				unchecked_list.push(unselectedVal);			
			}
		}		
	});	
    });
	
	$j('.stage_buttons a').click(function(event) {		
		event.preventDefault();
		setApproverPermissions($j(this).attr("href"));		
		});	
	
	 function setPermission(projectID, userId, jiveGroupID, stageId) {
			var completed;
            console.log('Add Permission for User : ' + userId + " Stage : " + stageId + "  ProjectID  : " + projectID + " JiveGroupID :  " + jiveGroupID);
			ProjectPermission.addPermission(projectID, userId, jiveGroupID, stageId, {
	            callback: function(result) {
				completed = result;
	            },
	            async: false,  
	            timeout: 20000 
	        });        
    }	

    function removePermission(projectID, userId, jiveGroupID, stageId) {
		var completed;
        console.log('Remove Permission for User : ' + userId + " Stage : " + stageId + "  ProjectID  : " + projectID + " JiveGroupID :  " + jiveGroupID);
        ProjectPermission.removePermission(projectID, userId, jiveGroupID, stageId, {
	            callback: function(result) {
				completed = result;
	            },
	            async: false,  
	            timeout: 20000 
	        });		
    }

    function getPerms(projectId, jiveGroupId) {
        console.log('Load Permissions for projectId ' + projectId + " jiveGroupId : " + jiveGroupId);
        ProjectPermission.getPermissions(projectId, jiveGroupId);
    }
	
	function setApproverPermissions(redirecturl)
	{		
		for (var i = 0; i < checked_list.length; i++) {
				var item = checked_list[i].split("_");
				var userID = item[0];
				var tabID = item[1];			
				setPermission(projectID, userID, userGroupMap[userID],tabID);
			}
			for (var i = 0; i < unchecked_list.length; i++) {
				var item = unchecked_list[i].split("_");
				var userID = item[0];
				var tabID = item[1];			
				removePermission(projectID, userID, userGroupMap[userID],tabID);
			}
			if(redirecturl!="")
			{
				window.location.href = redirecturl;			
			}
	}
	
	/**
	* Update Property that default permissions are set
	**/
	ProjectPermission.updatePermissionProperty(projectID, wStage);