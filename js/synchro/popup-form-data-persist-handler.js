var POPUP_FORM_DATA_PERSIST_HANDLER = {
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
            var formURL = $j(that.parentForm).attr("action");
            var formData = $j(that.parentForm).serializeArray();
            $j(that.parentForm).find('input').each(function(){
                var inp = this;
                if($j(this).hasClass("numericfield")) {
                    $j.each(formData,function(idx, o) {
                        if(o.name == inp.name && formData[idx].value.indexOf(",") != -1) {
                            formData[idx]["value"] = Number(formData[idx].value.replace(/\,/g,''));
                        }
                    });
                }
            });
            $j.ajax({
                url: formURL + "?projectID=" +that.projectID,
                type: 'POST',
                data:   formData,
                success: function(){
                    self.submit();
                },
                error: function() {
                    self.submit();
                }
            });
        });

    }
};