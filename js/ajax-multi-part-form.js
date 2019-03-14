var AjaxMultiPartForm = {
    initialize:function(form, successHandler, errorHandler, validationFunc) {
        this.form = form;

        this.handleSubmitForm(form, successHandler, errorHandler, validationFunc);
        return this;
    },
    submit:function() {
        $j(this.form).submit();
    },
    handleSubmitForm:function(form, successHandler, errorHandler, validationFunc) {

        var that = this;
        if(successHandler == undefined) {
            successHandler = function(data, textStatus, jqXHR) {};
        }

        if(errorHandler == undefined) {
            errorHandler = function(jqXHR, textStatus, errorThrown) {};
        }

        $j(form).submit(function(e)
        {
            if(validationFunc) {
                if(!validationFunc()) {
                    return false;
                }
            }
            var self = this;
            var formObj = $j(this);
            var formURL = formObj.attr("action");
            if(window.FormData !== undefined)  // for HTML5 browsers
            {
                e.preventDefault();
                e.stopImmediatePropagation();
                var formData = new FormData(this);

                $j.ajax({
                    url: formURL,
                    type: 'POST',
                    data:  formData,
                    beforeSend:function(){
                        that.showLoader("Please wait...");
                    },
                    mimeType:"multipart/form-data",
                    contentType: false,
                    cache: false,
                    processData:false,
                    success: function(response, textStatus, jqXHR){that.hideLoader();successHandler(response, textStatus, jqXHR)},
                    error: function(data, textStatus, errorThrown){that.hideLoader();errorHandler(data, textStatus, errorThrown)}
                });

            }
            else  //for olden browsers
            {
                $j("#hiddenUploadIFrame").remove();
                //generate a random id
                var  iframeId = 'unique' + (new Date().getTime());
                var newSrc = 'about:blank?nocache=' + Math.random();

                //create an empty iframe
                var iframe = $j('<iframe id="hiddenUploadIFrame" src="'+newSrc+'" name="'+iframeId+'" />');

                //hide it
                $j(iframe).hide();

                //set form target to iframe
                $j(formObj).attr('target',iframeId);

                //Add iframe to body
                $j(iframe).appendTo('body');
                that.showLoader("Please wait...");

                $j(iframe).load(function()
                {
                    var doc = that.getDoc(iframe[0]);
                    var docRoot = doc.body ? doc.body : doc.documentElement;
                    var data = docRoot.innerHTML;
                    //data is returned from server.
                    if(data != null) {
                        var response = data.replace(/(\<pre\>|\<\/pre\>)/ig,"");
                        that.hideLoader();
                        successHandler(response);
                        //    errorHandler(response);
                    } else {
                        that.hideLoader();
                    }
                });

            }

        });
    },
    getDoc:function(frame) {
        var doc = null;

        // IE8 cascading access check
        try {
            if (frame.contentWindow) {
                doc = frame.contentWindow.document;
            }
        } catch(err) {
        }

        if (doc) { // successful getting content
            return doc;
        }

        try { // simply checking may throw in ie8 under ssl or mismatched protocol
            doc = frame.contentDocument ? frame.contentDocument : frame.document;
        } catch(err) {
            // last attempt
            doc = frame.document;
        }
        return doc;
    },

    showLoader:function (title) {
        $j.loader({
            className:"blue-with-image",
            content: title
        });
    },

    hideLoader:function () {
        $j("#jquery-loader").remove();
        $j("#jquery-loader-background").remove();
    }

}