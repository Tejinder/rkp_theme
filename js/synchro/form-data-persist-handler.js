var FORM_DATA_PERSIST_HANDLER = {
    parentForm:null,
    form:null,
    options:{},
    projectID:-1,
    handle:function(options) {
        var that = this;
        if(options) {
            this.options = options;
        }
        if(options.projectID) {
            this.projectID = options.projectID;
        }

        if(options.parentForm) {
            this.parentForm = options.parentForm;
        }
        if(options.form) {
            this.form = options.form;
        }

        if(!(this.parentForm || this.form)) {
            return;
        }

        $j(this.form).submit(function(e){
            var self = this;
            e.preventDefault();
            that.saveForms(that.parentForm, self,  that.projectID);
        });

    },

    saveForms:function(parentForm, subForm, projectID) {	
	
        var formURL = $j(parentForm).attr("action");
        var formData = this.getFormData(parentForm);	
        
        var subFormName = $j(subForm).attr("name");
		
		
		// This check is done for Move To Next Stage for PIB for Multi market so that the end markets should also be saved.
		if(subFormName!=null && subFormName=="moveToNextStageForm")
		{
	        
	        $j.ajax({
	            url: formURL ,
	            type: 'POST',
	            data:   formData ,
	            success: function(data, test){
	                AUTO_SAVE.setFormDirty(false);
	                subForm.submit();
	            },
	            error: function() {
	                AUTO_SAVE.setFormDirty(false);
	                subForm.submit();
	            }
	        });
	     }
	     else
	     {
	     	$j.ajax({
	            url: formURL + "?saveEmailForm=saveEmailForm" ,
	            type: 'POST',
	            data:   formData ,
	            success: function(data, test){
	                AUTO_SAVE.setFormDirty(false);
	                subForm.submit();
	            },
	            error: function() {
	                AUTO_SAVE.setFormDirty(false);
	                subForm.submit();
	            }
	        });
	     }
	        
		
    },

    getFormData:function(form) {
        $j(form).find('select').each(function(){
            var isMultiple = $j(this).attr("multiple");
            console.log(isMultiple);
            if(isMultiple) {
                $j(this).find("option").attr("selected","true");
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
                    var inputVal = $j("input[name="+name+"]").val();
                    if(inputVal) {
                        var val = Number($j("input[name="+name+"]").val().replace(/\,/g,''));
                        $j("input[name="+name.replace("-display",'')+"]").val(val);
                    } else {
                        $j("input[name="+name.replace("-display",'')+"]").val("");
                    }
//                    if($j("input[name="+name+"]").val() != "") {
//                        var val = Number($j("input[name="+name+"]").val().replace(/\,/g,''));
//                        $j("input[name="+name.replace("-display",'')+"]").val(val);
//                    } else {
//                        $j("input[name="+name.replace("-display",'')+"]").val("");
//                    }
                }
            }
        });
        var pFormData = $j(form).serializeArray();
        return pFormData;
    }

};