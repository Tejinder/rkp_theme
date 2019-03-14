var LIGHT_BOX  = Class.create({
    showTitle:true,
    onShow:null,
    onClose:null,
    confirmOnClose:false,
    initialize:function(target, options) {
        this.target = target;
        this.options = options;
        if(options.showTitle != undefined) {
            this.showTitle = options.showTitle;
        }

        if(options.onShow != undefined && options.onShow != null) {
            this.onShow = options.onShow;
        }
        if(options.onClose != undefined && options.onClose != null) {
            this.onClose = options.onClose;
        }
        if(options.confirmOnClose != undefined && options.confirmOnClose != null) {
            this.confirmOnClose = options.confirmOnClose;
        }
        this.prepare();
    },
    show:function(prop) {

        if(this.popup !== null && this.popup !== undefined) {
            var options = {centered:true,closeEsc:false,closeClick:false,closeSelector:".none_selector", overlayCSS:{background: 'black', opacity: .7}}
            if(this.options != undefined && this.options != null) {
                options = $j.extend(options, this.options);
            }
            if(prop != null && prop != undefined && prop.title) {
                if($j(this.popup).find(".light-box-title")) {
                    $j(this.popup).find(".light-box-title h4").html(prop.title);
                } else {
                    $j(this.getTitle(prop.title)).prependTo($j(this.popup));
                }
            }
            $j(this.target).show();
            if(this.onShow != null && $j.isFunction(this.onShow)) {
                this.onShow();
            }
            $j(".lb_overlay").remove();
            this.popup.lightbox_me(options);
        }

    },
    close:function() {

        var that = this;
        if(this.confirmOnClose) {
            $j(this.popup).hide();
            dialog({
                title:"Confirmation",
                html:"Are you sure you want to close with out saving details?",
                nonCloseActionButtons:['YES'],
                buttons:{
                    "YES":function() {
                        that.popupCloseHandler();
                        closeDialog();
                    },
                    "NO": function() {
                        $j(".lb_overlay").show();
                        $j(that.popup).show();
                    }
                },
                closeActionButtonsClickHander:function() {
                    $j(".lb_overlay").show();
                    $j(that.popup).show();
                    closeDialog();
                }
            });
        } else {
            this.popupCloseHandler();
        }
    },

    popupCloseHandler:function() {
        var that = this;
        if($j(".light-box form")) {
            $j(".light-box form").each(function(idx) {
                that.resetForm(this);
            })
        }
        $j(this.target).hide();
        $j(".lb_overlay").hide();
        $j(this.popup).trigger('close');
        //$j(".lb_overlay").hide();
    },
    prepare:function() {
        var div = document.createElement('div');
        $j(div).addClass("light-box");
        if(this.options != undefined && this.options.title != undefined) {
            $j(this.getTitle(this.options.title)).appendTo($j(div));
        }
        $j(div).appendTo($j('body'));
        $j("<input type='button' class='close-btn' value=''>").appendTo($j(div));
        $j(this.target).appendTo($j(div));
        this.popup = $j(div);
        this.bindEvents();
    },

    getTitle:function(title) {
        if(this.showTitle) {
            return $j("<div class='light-box-title'><h4>"+title+ "</h4></div>");
        } else {
            return $j("<div class='no-title'></div>");
        }

    },

    bindEvents:function() {
        var that = this;
        if($j(".light-box .close-btn")) {
            $j(".light-box .close-btn").bind('click', function() {
                that.close();
            });
        }
    },
    resetForm:function(form) {
        $j(form).each (function(){
            this.reset();
        });
    }


});
