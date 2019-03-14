var SYNCHRO_FIELD_ATTACHMENT_POPUP = Class.create({
    items: [],
    formUrl:'',
    lightBox:null,
    projectID:-1,
    endMarketID:-1,
    fieldId:-1,
	repType:-1,
	reportOrderId:-1,
	rowId:-1,
    errorMsg:'',
    showTitle:true,
    parentForm:null,
    beforeSave:null,
    initialize:function(options) {
        if(options.items) {
            this.items = options.items;
        }

        if(options.formUrl) {
            this.formUrl = options.formUrl;
        }

        if(options.projectID) {
            this.projectID = options.projectID;
        }

        if(options.endMarketID) {
            this.endMarketID = options.endMarketID;
        }

        if(options.showTitle != undefined) {
            this.showTitle = options.showTitle;
        }

        if(options.parentForm) {
            this.parentForm = options.parentForm;
        }

        if(options.beforeSave) {
            this.beforeSave = options.beforeSave;
        }

        if($j.cookie("scrollPosition")) {
            $j(window).scrollTop($j.cookie("scrollPosition"))
            $j.cookie("scrollPosition", null);
        }


    },

    show:function(fieldId, showTitle, repType, reportOrderId, rowId ) {

        
		var that = this;
	    if(showTitle != undefined && showTitle != null) {
            this.showTitle = showTitle;
        }
        this.fieldId = fieldId;
        var title = 'Attach file';
        if(fieldId && this.items) {
            var field = $j.grep(this.items,function(item){
                return (item.id == fieldId);
            });
            if(field && field.length > 0) {
                title = field[0].name;
            }
        }
        var target = this.getPopupContent(fieldId, repType, reportOrderId, rowId);
        this.lightBox = new LIGHT_BOX(target,{title:title,showTitle:that.showTitle,destroyOnClose:true});
        this.lightBox.show({title:title});
    },

    close:function() {
        this.lightBox.close();
    },

    getPopupContent:function(fieldId,repType, reportOrderId, rowId) {
        var that = this;

        var div = document.createElement("div");
        $j(div).attr('id', 'attachmentWindow');
        $j(div).attr('class', 'synchro-field-attachment-popup');

        var errorMsgDiv = document.createElement("div");
        $j(errorMsgDiv).attr('id', 'error-message');
        $j(errorMsgDiv).attr('class', 'error-message');
        $j(errorMsgDiv).css('display', 'none');
        $j(errorMsgDiv).appendTo($j(div));

        var form = that.getForm();

        var fileInput = that.getInput("file", "attachFile", "attachFile");
        $j(fileInput).attr("class","form-text");
        $j(fileInput).appendTo($j(form));

        var projectIDHiddenField =  that.getInput("hidden", "projectID", null);
        $j(projectIDHiddenField).val(this.projectID);
        $j(projectIDHiddenField).appendTo($j(form));

        var endMarketIDHiddenField = that.getInput("hidden", "endMarketId", null);
        $j(endMarketIDHiddenField).val(this.endMarketID);
        $j(endMarketIDHiddenField).appendTo($j(form));

        if(fieldId) {
            var fieldIDHiddenField = that.getInput("hidden", "fieldCategoryId", null);
            $j(fieldIDHiddenField).val(fieldId);
            $j(fieldIDHiddenField).appendTo($j(form));
			
			var repTypeIDHiddenField = that.getInput("hidden", "repTypeId", null);
            $j(repTypeIDHiddenField).val(repType);
            $j(repTypeIDHiddenField).appendTo($j(form));
			
			var repOrderIDHiddenField = that.getInput("hidden", "reportOrderId", null);
            $j(repOrderIDHiddenField).val(reportOrderId);
            $j(repOrderIDHiddenField).appendTo($j(form));
			
			var rowIDHiddenField = that.getInput("hidden", "rowId", null);
            $j(rowIDHiddenField).val(rowId);
            $j(rowIDHiddenField).appendTo($j(form));
			
        } else {
            if(this.items) {
                $j.each(this.items,function(idx, item){
                    var subdiv = document.createElement("div");
                    $j(subdiv).attr('class', 'views-field');

                    var radio = that.getInput("radio", "fieldCategoryId", null);
                    $j(radio).val(item.id);
                    $j(radio).appendTo($j(subdiv));
                    $j(radio).click(function(){
                        that.fieldId = $j(this).val();
                    });
                    var label = document.createElement("label");
                    $j(label).html(item.name);
                    $j(label).appendTo($j(subdiv));

                    $j(subdiv).appendTo($j(form));
                });
            }
        }

        var btnsDiv = document.createElement('div');
        $j(btnsDiv).attr("class","views-field buttons");

        var addBtn = that.getInput("submit", "", null);
        $j(addBtn).attr("value","Attach");
        $j(addBtn).attr("class","add");
        $j(addBtn).appendTo($j(btnsDiv));

        var cancelBtn = that.getInput("submit", "", null);
        $j(cancelBtn).attr("value","Cancel");
        $j(cancelBtn).attr("class","cancel");
        $j(cancelBtn).appendTo($j(btnsDiv));
        $j(cancelBtn).bind('click',function(){that.lightBox.close();});

        $j(btnsDiv).appendTo($j(form));

        $j(form).appendTo($j(div));

        $j(form).submit(function(event){
            showLoader('Please wait...');

            $j(errorMsgDiv).hide();
            var self = this;
            event.preventDefault();
            if(that.validate(self)) {
                if(that.parentForm) {
                   
			
				   var pFormURL = $j(that.parentForm).attr("action");
                    var pFormData = that.getParentFormData(that.parentForm);
					
					
				
					
					var form1 = form;
						$j.post(form1.attr("action"), form1.serialize(), function () {
							self.submit();
						});
					var form2 = $j(that.parentForm);
						
						$j.post(form2.attr("action"), form2.serialize(), function () {
							
						});
					
				/*	$j.ajax({
                        url: pFormURL + "?projectID=" +that.projectID,
                        type: 'POST',
                        data:   pFormData,
                        success: function(){
                            AUTO_SAVE.setFormDirty(false);
                            self.submit();
							// This has been added as part of Jive-8 
							//	jive.util.securedForm(form).always(function() {
							//	$j(that.parentForm).submit();
							//});
                        },
                        error: function() {
                            AUTO_SAVE.setFormDirty(false);
                            self.submit();
							//This has been added as part of Jive-8
							//	jive.util.securedForm(form).always(function() {
							//	$j(that.parentForm).submit();
							//});
                        }
                    });
							
                  */
					
					
					
						
					
					
                } else {
                    AUTO_SAVE.setFormDirty(false);
                    self.submit();
                }
                $j.cookie("scrollPosition", $j(window).scrollTop());
                return false;
            } else {
                hideLoader();
                $j(errorMsgDiv).html(that.errorMsg);
                $j(errorMsgDiv).show();
            }
        });

        return $j(div);
    },

    getParentFormData:function(form) {
        $j(form).find('select').each(function(){
            var isMultiple = $j(this).attr("multiple");
            console.log(isMultiple);
            if(isMultiple) {
               // $j(this).find("option").attr("selected","true");
				
			//	$j(this).find("option").prop('selected', true);
            }
        });
        $j(form).find('input').each(function(){
            var name = $j(this).attr("name");
            var type = $j(this).attr("type");
            if(name && name.indexOf("-display") != -1) {
                if(type == 'checkbox' || type == 'radio') {
                    if($j(this).is(":checked")) {
                        $j("input[name="+name.replace("-display",'')+"]").val(true);
                    } else {
                        $j("input[name="+name.replace("-display",'')+"]").val(false);
                    }
                } else {
                    if($j("input[name="+name+"]").val() != "") {
                        var val = Number($j("input[name="+name+"]").val().replace(/\,/g,''));
                        $j("input[name="+name.replace("-display",'')+"]").val(val);
                    } else {
                        $j("input[name="+name.replace("-display",'')+"]").val("");
                    }
                }
            }
        });
        var pFormData = $j(form).serializeArray();
        return pFormData;
    },

    validate:function(form) {
        var isValid = true;
        var attachFileValue = $j(form).find('input[name=attachFile]').val();
        var emsg = '<ul>';
        if(!attachFileValue) {
            emsg += "<li>Please choose the file.</li>";
            isValid = false;
        }
        if(!this.fieldId || this.fieldId <= 0) {
            emsg += "<li>Please select field type.</li>";
            isValid = false;
        }
        emsg += '</ul>';

        if(!isValid) {
            this.errorMsg = emsg;
        }

        return isValid;
    },

    getInput:function(type, nameVal, id) {
        var input = "<input type='"+type+"'";
        if(nameVal != ""){
            input += " name='"+nameVal+"'";
        }
        if(id) {
            input += " id='"+id+"'";
        }
        input += ">";
        return $j(input);

    },

    getForm:function() {
        var form = "<form name='field-attachment' id='field-attachment' method='POST' " +
            "enctype='multipart/form-data' action='"+this.formUrl+"'></form>";
        return $j(form);
    }

})

var SYNCHRO_WAIVER_FIELD_ATTACHMENT_POPUP = Class.create({
    items: [],
    formUrl:'',
    lightBox:null,
    projectID:-1,
    endMarketID:-1,
    fieldId:-1,
    errorMsg:'',
    showTitle:true,
    parentForm:null,
    initialize:function(options) {
        if(options.items) {
            this.items = options.items;
        }

        if(options.formUrl) {
            this.formUrl = options.formUrl;
        }

        if(options.projectID) {
            this.projectID = options.projectID;
        }

        if(options.endMarketID) {
            this.endMarketID = options.endMarketID;
        }

        if(options.showTitle != undefined) {
            this.showTitle = options.showTitle;
        }

        if(options.parentForm) {
            this.parentForm = options.parentForm;
        }

        if($j.cookie("scrollPosition")) {
            $j(window).scrollTop($j.cookie("scrollPosition"))
            $j.cookie("scrollPosition", null);
        }


    },

    show:function(fieldId) {
        var that = this;
        this.fieldId = fieldId;
        var title = 'Attach file';
        if(fieldId && this.items) {
            var field = $j.grep(this.items,function(item){
                return (item.id == fieldId);
            });
            if(field && field.length > 0) {
                title = field[0].name;
            }
        }
        var target = this.getPopupContent(fieldId);
        this.lightBox = new LIGHT_BOX(target,{title:title,showTitle:that.showTitle,destroyOnClose:true});
        this.lightBox.show({title:title});
    },

    close:function() {
        this.lightBox.close();
    },

    getPopupContent:function(fieldId) {
        var that = this;

        var div = document.createElement("div");
        $j(div).attr('id', 'attachmentWindow');
        $j(div).attr('class', 'synchro-field-attachment-popup');

        var errorMsgDiv = document.createElement("div");
        $j(errorMsgDiv).attr('id', 'error-message');
        $j(errorMsgDiv).attr('class', 'error-message');
        $j(errorMsgDiv).css('display', 'none');
        $j(errorMsgDiv).appendTo($j(div));

        var form = that.getForm();

        var fileInput = that.getInput("file", "attachFile", "attachFile");
        $j(fileInput).attr("class","form-text");
        $j(fileInput).appendTo($j(form));

        var projectIDHiddenField =  that.getInput("hidden", "projectID", null);
        $j(projectIDHiddenField).val(this.projectID);
        $j(projectIDHiddenField).appendTo($j(form));

        var endMarketIDHiddenField = that.getInput("hidden", "endMarketId", null);
        $j(endMarketIDHiddenField).val(this.endMarketID);
        $j(endMarketIDHiddenField).appendTo($j(form));

        if(fieldId) {
            var fieldIDHiddenField = that.getInput("hidden", "fieldCategoryId", null);
            $j(fieldIDHiddenField).val(fieldId);
            $j(fieldIDHiddenField).appendTo($j(form));
        } else {
            if(this.items) {
                $j.each(this.items,function(idx, item){
                    var subdiv = document.createElement("div");
                    $j(subdiv).attr('class', 'views-field');

                    var radio = that.getInput("radio", "fieldCategoryId", null);
                    $j(radio).val(item.id);
                    $j(radio).appendTo($j(subdiv));
                    $j(radio).click(function(){
                        that.fieldId = $j(this).val();
                    });
                    var label = document.createElement("label");
                    $j(label).html(item.name);
                    $j(label).appendTo($j(subdiv));

                    $j(subdiv).appendTo($j(form));
                });
            }
        }

        var btnsDiv = document.createElement('div');
        $j(btnsDiv).attr("class","views-field buttons");

        var addBtn = that.getInput("submit", "", null);
        $j(addBtn).attr("value","Attach");
        $j(addBtn).attr("class","add");
        $j(addBtn).appendTo($j(btnsDiv));

        var cancelBtn = that.getInput("submit", "", null);
        $j(cancelBtn).attr("value","Cancel");
        $j(cancelBtn).attr("class","cancel");
        $j(cancelBtn).appendTo($j(btnsDiv));
        $j(cancelBtn).bind('click',function(){that.lightBox.close();});

        $j(btnsDiv).appendTo($j(form));

        $j(form).appendTo($j(div));

        $j(form).submit(function(event){
            showLoader('Please wait...');
            $j(errorMsgDiv).hide();
            var self = this;
            event.preventDefault();
            if(that.validate(self)) {
                self.submit();
                $j.cookie("scrollPosition", $j(window).scrollTop());
                return false;
            } else {
                hideLoader();
                $j(errorMsgDiv).html(that.errorMsg);
                $j(errorMsgDiv).show();
            }
        });

        return $j(div);
    },

    validate:function(form) {
        var isValid = true;
        var attachFileValue = $j(form).find('input[name=attachFile]').val();
        var emsg = '<ul>';
        if(!attachFileValue) {
            emsg += "<li>Please choose the file.</li>";
            isValid = false;
        }
        if(!this.fieldId || this.fieldId <= 0) {
            emsg += "<li>Please select field type.</li>";
            isValid = false;
        }
        emsg += '</ul>';

        if(!isValid) {
            this.errorMsg = emsg;
        }

        return isValid;
    },

    getInput:function(type, nameVal, id) {
        var input = "<input type='"+type+"'";
        if(nameVal != ""){
            input += " name='"+nameVal+"'";
        }
        if(id) {
            input += " id='"+id+"'";
        }
        input += ">";
        return $j(input);

    },

    getForm:function() {
        var form = "<form name='field-attachment' id='field-attachment' method='POST' " +
            "enctype='multipart/form-data' action='"+this.formUrl+"'></form>";
        return $j(form);
    }

})


var OSP_FIELD_ATTACHMENT_POPUP = Class.create({
    items: [],
    formUrl:'',
    lightBox:null,
    tileID:-1,
    folderID:-1,
	currPage:-1,
	sortBy:null,
    fieldId:-1,
	errorMsg:'',
    showTitle:true,
    parentForm:null,
    beforeSave:null,
    initialize:function(options) {
        if(options.items) {
            this.items = options.items;
        }

        if(options.formUrl) {
            this.formUrl = options.formUrl;
        }

        if(options.tileID) {
            this.tileID = options.tileID;
        }

        if(options.folderID) {
            this.folderID = options.folderID;
        }
		
		if(options.currPage) {
            this.currPage = options.currPage;
        }

		if(options.sortBy) {
            this.sortBy = options.sortBy;
        }
		
        if(options.showTitle != undefined) {
            this.showTitle = options.showTitle;
        }

        if(options.parentForm) {
            this.parentForm = options.parentForm;
        }

        if(options.beforeSave) {
            this.beforeSave = options.beforeSave;
        }

        if($j.cookie("scrollPosition")) {
            $j(window).scrollTop($j.cookie("scrollPosition"))
            $j.cookie("scrollPosition", null);
        }


    },

    show:function(fieldId, showTitle, tileId, folderId) {

        
		var that = this;
	    if(showTitle != undefined && showTitle != null) {
            this.showTitle = showTitle;
        }
        this.fieldId = fieldId;
        var title = 'Attach file';
        if(fieldId && this.items) {
            var field = $j.grep(this.items,function(item){
                return (item.id == fieldId);
            });
            if(field && field.length > 0) {
                title = field[0].name;
            }
        }
        var target = this.getPopupContent(fieldId);
        this.lightBox = new LIGHT_BOX(target,{title:title,showTitle:that.showTitle,destroyOnClose:true});
        this.lightBox.show({title:title});
    },

    close:function() {
        this.lightBox.close();
    },

    getPopupContent:function(fieldId) {
        var that = this;

        var div = document.createElement("div");
        $j(div).attr('id', 'attachmentWindow');
        $j(div).attr('class', 'synchro-field-attachment-popup');

        var errorMsgDiv = document.createElement("div");
        $j(errorMsgDiv).attr('id', 'error-message');
        $j(errorMsgDiv).attr('class', 'error-message');
        $j(errorMsgDiv).css('display', 'none');
        $j(errorMsgDiv).appendTo($j(div));

        var form = that.getForm();

        var fileInput = that.getInput("file", "attachFile", "attachFile");
        $j(fileInput).attr("class","form-text");
        $j(fileInput).appendTo($j(form));

        var tileIDHiddenField =  that.getInput("hidden", "tileID", null);
        $j(tileIDHiddenField).val(this.tileID);
        $j(tileIDHiddenField).appendTo($j(form));

        var folderIDHiddenField = that.getInput("hidden", "folderID", null);
        $j(folderIDHiddenField).val(this.folderID);
        $j(folderIDHiddenField).appendTo($j(form));
		
		var currPageHiddenField =  that.getInput("hidden", "currPage", null);
        $j(currPageHiddenField).val(this.currPage);
        $j(currPageHiddenField).appendTo($j(form));
		
		var sortByHiddenField =  that.getInput("hidden", "sortBy", null);
        $j(sortByHiddenField).val(this.sortBy);
        $j(sortByHiddenField).appendTo($j(form));

        if(fieldId) {
            var fieldIDHiddenField = that.getInput("hidden", "fieldCategoryId", null);
            $j(fieldIDHiddenField).val(fieldId);
            $j(fieldIDHiddenField).appendTo($j(form));
			
			var repTypeIDHiddenField = that.getInput("hidden", "repTypeId", null);
            $j(repTypeIDHiddenField).val(repType);
            $j(repTypeIDHiddenField).appendTo($j(form));
			
			
			
        } else {
            if(this.items) {
                $j.each(this.items,function(idx, item){
                    var subdiv = document.createElement("div");
                    $j(subdiv).attr('class', 'views-field');

                    var radio = that.getInput("radio", "fieldCategoryId", null);
                    $j(radio).val(item.id);
                    $j(radio).appendTo($j(subdiv));
                    $j(radio).click(function(){
                        that.fieldId = $j(this).val();
                    });
                    var label = document.createElement("label");
                    $j(label).html(item.name);
                    $j(label).appendTo($j(subdiv));

                    $j(subdiv).appendTo($j(form));
                });
            }
        }

        var btnsDiv = document.createElement('div');
        $j(btnsDiv).attr("class","views-field buttons");

        var addBtn = that.getInput("submit", "", null);
        $j(addBtn).attr("value","Attach");
        $j(addBtn).attr("class","add");
        $j(addBtn).appendTo($j(btnsDiv));

        var cancelBtn = that.getInput("submit", "", null);
        $j(cancelBtn).attr("value","Cancel");
        $j(cancelBtn).attr("class","cancel");
        $j(cancelBtn).appendTo($j(btnsDiv));
        $j(cancelBtn).bind('click',function(){that.lightBox.close(); event.stopPropagation(); return false;});

        $j(btnsDiv).appendTo($j(form));

        $j(form).appendTo($j(div));

        $j(form).submit(function(event){
	


            $j(errorMsgDiv).hide();
            var self = this;
            event.preventDefault();
            if(that.validate(self)) {
				
							//amit	
	     setTimeout(function(){
		 showLoader('Please wait...');
		  },10);
                if(that.parentForm) {
                   
		
		  
				   var pFormURL = $j(that.parentForm).attr("action");
                    var pFormData = that.getParentFormData(that.parentForm);
					
					
				
					
					var form1 = form;
						$j.post(form1.attr("action"), form1.serialize(), function () {
							self.submit();
						});
					var form2 = $j(that.parentForm);
						
						$j.post(form2.attr("action"), form2.serialize(), function () {
							
						});
					
				/*	$j.ajax({
                        url: pFormURL + "?projectID=" +that.projectID,
                        type: 'POST',
                        data:   pFormData,
                        success: function(){
                            AUTO_SAVE.setFormDirty(false);
                            self.submit();
							// This has been added as part of Jive-8 
							//	jive.util.securedForm(form).always(function() {
							//	$j(that.parentForm).submit();
							//});
                        },
                        error: function() {
                            AUTO_SAVE.setFormDirty(false);
                            self.submit();
							//This has been added as part of Jive-8
							//	jive.util.securedForm(form).always(function() {
							//	$j(that.parentForm).submit();
							//});
                        }
                    });
							
                  */
					
					
					
						
					
					
                } else {
                    AUTO_SAVE.setFormDirty(false);
                    self.submit();
                }
                $j.cookie("scrollPosition", $j(window).scrollTop());
                return false;
            } else {
                hideLoader();
                $j(errorMsgDiv).html(that.errorMsg);
                $j(errorMsgDiv).show();
            }
        });

        return $j(div);
    },

    getParentFormData:function(form) {
        $j(form).find('select').each(function(){
            var isMultiple = $j(this).attr("multiple");
            console.log(isMultiple);
            if(isMultiple) {
               // $j(this).find("option").attr("selected","true");
				
			//	$j(this).find("option").prop('selected', true);
            }
        });
        $j(form).find('input').each(function(){
            var name = $j(this).attr("name");
            var type = $j(this).attr("type");
            if(name && name.indexOf("-display") != -1) {
                if(type == 'checkbox' || type == 'radio') {
                    if($j(this).is(":checked")) {
                        $j("input[name="+name.replace("-display",'')+"]").val(true);
                    } else {
                        $j("input[name="+name.replace("-display",'')+"]").val(false);
                    }
                } else {
                    if($j("input[name="+name+"]").val() != "") {
                        var val = Number($j("input[name="+name+"]").val().replace(/\,/g,''));
                        $j("input[name="+name.replace("-display",'')+"]").val(val);
                    } else {
                        $j("input[name="+name.replace("-display",'')+"]").val("");
                    }
                }
            }
        });
        var pFormData = $j(form).serializeArray();
        return pFormData;
    },

    validate:function(form) {
        var isValid = true;
        var attachFileValue = $j(form).find('input[name=attachFile]').val();
        var emsg = '<ul>';
        if(!attachFileValue) {
            emsg += "<li>Please choose the file.</li>";
            isValid = false;
        }
      /*  if(!this.fieldId || this.fieldId <= 0) {
            emsg += "<li>Please select field type.</li>";
            isValid = false;
        }*/
        emsg += '</ul>';

        if(!isValid) {
            this.errorMsg = emsg;
        }

        return isValid;
    },

    getInput:function(type, nameVal, id) {
        var input = "<input type='"+type+"'";
        if(nameVal != ""){
            input += " name='"+nameVal+"'";
        }
        if(id) {
            input += " id='"+id+"'";
        }
        input += ">";
        return $j(input);

    },

    getForm:function() {
        var form = "<form name='field-attachment' id='field-attachment' method='POST' " +
            "enctype='multipart/form-data' action='"+this.formUrl+"'></form>";
        return $j(form);
    }

})


var IRIS_SUMMARY_FIELD_ATTACHMENT_POPUP = Class.create({
    items: [],
    formUrl:'',
    lightBox:null,
    irisSummaryId:-1,
    currPage:-1,
	sortBy:null,
    fieldId:-1,
	errorMsg:'',
    showTitle:true,
    parentForm:null,
    beforeSave:null,
    initialize:function(options) {
        if(options.items) {
            this.items = options.items;
        }

        if(options.formUrl) {
            this.formUrl = options.formUrl;
        }

        if(options.irisSummaryId) {
            this.irisSummaryId = options.irisSummaryId;
        }

     	if(options.currPage) {
            this.currPage = options.currPage;
        }

		if(options.sortBy) {
            this.sortBy = options.sortBy;
        }
		
        if(options.showTitle != undefined) {
            this.showTitle = options.showTitle;
        }

        if(options.parentForm) {
            this.parentForm = options.parentForm;
        }

        if(options.beforeSave) {
            this.beforeSave = options.beforeSave;
        }

        if($j.cookie("scrollPosition")) {
            $j(window).scrollTop($j.cookie("scrollPosition"))
            $j.cookie("scrollPosition", null);
        }


    },

    show:function(fieldId, showTitle, irisSummaryId) {

        
		var that = this;
	    if(showTitle != undefined && showTitle != null) {
            this.showTitle = showTitle;
        }
        this.fieldId = fieldId;
        var title = 'Upload file';
        if(fieldId && this.items) {
            var field = $j.grep(this.items,function(item){
                return (item.id == fieldId);
            });
            if(field && field.length > 0) {
                title = field[0].name;
            }
        }
        var target = this.getPopupContent(fieldId);
        this.lightBox = new LIGHT_BOX(target,{title:title,showTitle:that.showTitle,destroyOnClose:true});
        this.lightBox.show({title:title});
    },

    close:function() {
        this.lightBox.close();
    },

    getPopupContent:function(fieldId) {
        var that = this;

        var div = document.createElement("div");
        $j(div).attr('id', 'attachmentWindow');
        $j(div).attr('class', 'synchro-field-attachment-popup');

        var errorMsgDiv = document.createElement("div");
        $j(errorMsgDiv).attr('id', 'error-message');
        $j(errorMsgDiv).attr('class', 'error-message');
        $j(errorMsgDiv).css('display', 'none');
        $j(errorMsgDiv).appendTo($j(div));

        var form = that.getForm();

        var fileInput = that.getInput("file", "attachFile", "attachFile");
        $j(fileInput).attr("class","form-text");
        $j(fileInput).appendTo($j(form));

        var irisSummaryIdHiddenField =  that.getInput("hidden", "irisSummaryId", null);
        $j(irisSummaryIdHiddenField).val(this.irisSummaryId);
        $j(irisSummaryIdHiddenField).appendTo($j(form));

       
		
		var currPageHiddenField =  that.getInput("hidden", "currPage", null);
        $j(currPageHiddenField).val(this.currPage);
        $j(currPageHiddenField).appendTo($j(form));
		
	

        if(fieldId) {
            var fieldIDHiddenField = that.getInput("hidden", "fieldCategoryId", null);
            $j(fieldIDHiddenField).val(fieldId);
            $j(fieldIDHiddenField).appendTo($j(form));
			
		
			
			
			
        } else {
            if(this.items) {
                $j.each(this.items,function(idx, item){
                    var subdiv = document.createElement("div");
                    $j(subdiv).attr('class', 'views-field');

                    var radio = that.getInput("radio", "fieldCategoryId", null);
                    $j(radio).val(item.id);
                    $j(radio).appendTo($j(subdiv));
                    $j(radio).click(function(){
                        that.fieldId = $j(this).val();
                    });
                    var label = document.createElement("label");
                    $j(label).html(item.name);
                    $j(label).appendTo($j(subdiv));

                    $j(subdiv).appendTo($j(form));
                });
            }
        }

        var btnsDiv = document.createElement('div');
        $j(btnsDiv).attr("class","views-field buttons");

        var addBtn = that.getInput("submit", "", null);
        $j(addBtn).attr("value","Upload");
        $j(addBtn).attr("class","add");
        $j(addBtn).appendTo($j(btnsDiv));

        var cancelBtn = that.getInput("submit", "", null);
        $j(cancelBtn).attr("value","Cancel");
        $j(cancelBtn).attr("class","cancel");
        $j(cancelBtn).appendTo($j(btnsDiv));
        $j(cancelBtn).bind('click',function(){that.lightBox.close(); event.stopPropagation(); return false;});

        $j(btnsDiv).appendTo($j(form));

        $j(form).appendTo($j(div));

        $j(form).submit(function(event){
	


            $j(errorMsgDiv).hide();
            var self = this;
            event.preventDefault();
            if(that.validate(self)) {
				
							//amit	
	     setTimeout(function(){
		 showLoader('Please wait...');
		  },10);
                if(that.parentForm) {
                   
		
		  
				   var pFormURL = $j(that.parentForm).attr("action");
                    var pFormData = that.getParentFormData(that.parentForm);
					
					
				
					
					var form1 = form;
						$j.post(form1.attr("action"), form1.serialize(), function () {
							self.submit();
						});
					var form2 = $j(that.parentForm);
						
						$j.post(form2.attr("action"), form2.serialize(), function () {
							
						});
					
				/*	$j.ajax({
                        url: pFormURL + "?projectID=" +that.projectID,
                        type: 'POST',
                        data:   pFormData,
                        success: function(){
                            AUTO_SAVE.setFormDirty(false);
                            self.submit();
							// This has been added as part of Jive-8 
							//	jive.util.securedForm(form).always(function() {
							//	$j(that.parentForm).submit();
							//});
                        },
                        error: function() {
                            AUTO_SAVE.setFormDirty(false);
                            self.submit();
							//This has been added as part of Jive-8
							//	jive.util.securedForm(form).always(function() {
							//	$j(that.parentForm).submit();
							//});
                        }
                    });
							
                  */
					
					
					
						
					
					
                } else {
                  //  AUTO_SAVE.setFormDirty(false);
                    self.submit();
                }
                $j.cookie("scrollPosition", $j(window).scrollTop());
                return false;
            } else {
                hideLoader();
                $j(errorMsgDiv).html(that.errorMsg);
                $j(errorMsgDiv).show();
            }
        });

        return $j(div);
    },

    getParentFormData:function(form) {
        $j(form).find('select').each(function(){
            var isMultiple = $j(this).attr("multiple");
            console.log(isMultiple);
            if(isMultiple) {
               // $j(this).find("option").attr("selected","true");
				
			//	$j(this).find("option").prop('selected', true);
            }
        });
        $j(form).find('input').each(function(){
            var name = $j(this).attr("name");
            var type = $j(this).attr("type");
            if(name && name.indexOf("-display") != -1) {
                if(type == 'checkbox' || type == 'radio') {
                    if($j(this).is(":checked")) {
                        $j("input[name="+name.replace("-display",'')+"]").val(true);
                    } else {
                        $j("input[name="+name.replace("-display",'')+"]").val(false);
                    }
                } else {
                    if($j("input[name="+name+"]").val() != "") {
                        var val = Number($j("input[name="+name+"]").val().replace(/\,/g,''));
                        $j("input[name="+name.replace("-display",'')+"]").val(val);
                    } else {
                        $j("input[name="+name.replace("-display",'')+"]").val("");
                    }
                }
            }
        });
        var pFormData = $j(form).serializeArray();
        return pFormData;
    },

    validate:function(form) {
        var isValid = true;
        var attachFileValue = $j(form).find('input[name=attachFile]').val();
        var emsg = '<ul>';
        if(!attachFileValue) {
            emsg += "<li>Please choose the file.</li>";
            isValid = false;
        }
      /*  if(!this.fieldId || this.fieldId <= 0) {
            emsg += "<li>Please select field type.</li>";
            isValid = false;
        }*/
        emsg += '</ul>';

        if(!isValid) {
            this.errorMsg = emsg;
        }

        return isValid;
    },

    getInput:function(type, nameVal, id) {
        var input = "<input type='"+type+"'";
        if(nameVal != ""){
            input += " name='"+nameVal+"'";
        }
        if(id) {
            input += " id='"+id+"'";
        }
        input += ">";
        return $j(input);

    },

    getForm:function() {
        var form = "<form name='field-attachment' id='field-attachment' method='POST' " +
            "enctype='multipart/form-data' action='"+this.formUrl+"'></form>";
        return $j(form);
    }

})