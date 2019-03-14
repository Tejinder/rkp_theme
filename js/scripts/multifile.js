/**
 * Convert a single file-input element into a 'multiple' input list
 *
 * Usage:
 *
 *   1. Create a file input element (no name)
 *      eg. <input type="file" id="first_file_element">
 *
 *   2. Create a DIV for the output to be written to
 *      eg. <div id="files_list"></div>
 *
 *   3. Instantiate a MultiSelector object, passing in the DIV and an (optional) maximum number of files
 *      eg. var multi_selector = new MultiSelector( document.getElementById( 'files_list' ), 3 );
 *
 *   4. Add the first element
 *      eg. multi_selector.addElement( document.getElementById( 'first_file_element' ) );
 *
 *   5. That's it.
 *
 *   You might (will) want to play around with the addListRow() method to make the output prettier.
 *
 *   You might also want to change the line
 *       element.name = 'file_' + this.count;
 *   ...to a naming convention that makes more sense to you.
 *
 * Licence:
 *   Use this however/wherever you like, just don't blame me if it breaks anything.
 *
 * Credit:
 *   If you're nice, you'll leave this bit:
 *
 *   Class by Stickman -- http://www.the-stickman.com
 *      with thanks to:
 *      [for Safari fixes]
 *         Luis Torrefranca -- http://www.law.pitt.edu
 *         and
 *         Shawn Parker & John Pennypacker -- http://www.fuzzycoconut.com
 *      [for duplicate name bug]
 *         'neal'
 */
function MultiSelector(list_target, max, current, remove_i18n) {
console.log("MS --");
   var $ = jQuery;

    // Where to write the list
    this.list_target = list_target;
    this.addedElements = [];
    // How many elements?
    if (current) {
        this.count = current;
    }
    else {
        this.count = 0;
    }
    // How many elements?
    this.id = 0;
    // Is there a maximum?
    if (max) {
        this.max = max;
    }
    else {
        this.max = -1;
    }

    this.removeStr = remove_i18n;

    /**
     * Add a new file input element
     */
    this.addElement = function(element) {

        var $ele = $(element),
            self = this;


        if ($ele.is('input:file')) {
            $ele
                .attr('name', 'attachFile')
                .attr('id', 'attachFile_' + self.count);

            element.multi_selector = self;

            $ele.change(function() {
                if ($ele.val() == '') {
                    return;
                }

                element.multi_selector.addedElements.push($ele.attr('id'));

                $(list_target).show();

                var $newEle = $('<input type="file"/>');
                $ele.before($newEle);

                element.multi_selector.addElement($newEle[0]);
                element.multi_selector.addListRow(element);

                $ele.css({'position': 'absolute', 'left': '-1000px', 'top': '-1000px'});


            });

            /* max number reached */
            if (self.max != -1 && self.count >= self.max) {
                var $buttonParent = $ele.parent('.j-attachment-button');
                if ($buttonParent.length) {
                    $buttonParent.hide();
                }

                $ele.attr('disabled', 'disabled').hide();
                $('#jive-attach-maxsize').show();
            } else if (self.max != -1 && self.count > self.max - 1) {
                $('#jive-attach-maxfiles').show();
            }


            $ele.unbind("afterFileAttach");
            $j.event.trigger("afterFileAttach");
            self.count++;
            self.current_element = element;
        } else {
            console.log('errors');
        }


    };

    /**
     * Add a new row to the list of files
     */
    this.addListRow = function(element) {
        var $ele         = $(element),
            $new_row     = $('<div class="jive-attach-item iris-summary-attachment" id="jive-attach-item' + element.id.slice("attachFile_".length) + '"/>'),
            $remove_link = $('<a href="#" class="j-remove-file font-color-meta">' + this.removeStr + '</a>');

        $new_row[0].element = element;


        // Remove function
        $remove_link.click(function() {
            var $parent = $(this).parent('div'),
                ele_id = $ele.attr('id');

            $(this).parent('div').remove();
            $ele.remove();

            var addedElements = this.parentNode.element.multi_selector.addedElements;
            for (var i = 0; i < addedElements.length; i++) {
                if (addedElements[i] == ele_id && addedElements.length == 1) {
                    // not sure why but in ff splice(0, 0) wouldn't work.
                    this.parentNode.element.multi_selector.addedElements = [];
                }
                else if (addedElements[i] == $()) {
                    addedElements.splice(i, i);
                }
            }

            // Decrement counter
            this.parentNode.element.multi_selector.count--;

            // hide list if no elements left
            if (this.parentNode.element.multi_selector.count < 2) {
                $(list_target).hide();
            }

            // Re-enable input element (if it's disabled)
            var $buttonParent = $j(this.parentNode.element.multi_selector.current_element).parent('.j-attachment-button');
            if ($buttonParent.length) {
                $buttonParent.show();
            }
            this.parentNode.element.multi_selector.current_element.style.display = "";
            this.parentNode.element.multi_selector.current_element.disabled = false;

            $("#jive-attach-maxsize").show();
            $ele.unbind("afterFileRemove");
            $j.event.trigger("afterFileRemove");

            // Appease Safari
            // without it Safari wants to reload the browser window
            // which nixes your already queued uploads
            return false;
        });
        $remove_link.hover(function() {
            $(this).parent('div').addClass('remove-hover');
        }, function() {
            $(this).parent('div').removeClass('remove-hover');
        })

        var ua = navigator.userAgent;
        var isWindows = ua.indexOf('Windows') != -1;
        var isMac = !isWindows && ua.indexOf('Mac') != -1;

        // Set row value
        var elValue = element.value;
        // grab only the filename minus the path
        var fName = elValue;
        if (fName.indexOf('\\') != -1 && isWindows) {
            fName = fName.substring(fName.lastIndexOf('\\') + 1);
        }
        else if (fName.indexOf('/') != -1) {
            fName = fName.substring(fName.lastIndexOf('/') + 1);
        }
        else if (fName.indexOf(':') != -1 && isMac) {
            fName = fName.substring(fName.lastIndexOf(':') + 1);
        }
        $new_row.text(fName + " ");

        // Add remove link
        $new_row.append($remove_link);

        // Add it to the list
        $(this.list_target).append($new_row);

    };

    this.removeAttachment = function(elementID, id) {
        // Add a hidden field removeAttachID -> id
        var new_element = document.createElement('input');
        new_element.type = 'hidden';
        new_element.name = "removeAttachID";
        new_element.value = id;

        // Replace div with hidden field
        var e = document.getElementById(elementID);
        e.parentNode.replaceChild(new_element, e);

        // decrement the counter
        this.count--;

        // hide list if no elements left
        if (this.count < 2) {
            list_target.style.display = "none";
        }

        // Re-enable input element (if it's disabled)
        this.current_element.style.display = "";
        this.current_element.disabled = false;
        $("#jive-attach-maxsize").style.display = "";

    };
    this.haveAttachmentsBeenAdded = function() {
        return this.addedElements.length > 0;
    }
};


function MultiSelectorName(list_target, max, current, remove_i18n, name) {
console.log("NAME MS --");
   var $ = jQuery;

    // Where to write the list
    this.list_target = list_target;
    this.addedElements = [];
    // How many elements?
    if (current) {
        this.count = current;
    }
    else {
        this.count = 0;
    }
    // How many elements?
    this.id = 0;
    // Is there a maximum?
    if (max) {
        this.max = max;
    }
    else {
        this.max = -1;
    }

    this.removeStr = remove_i18n;

    /**
     * Add a new file input element
     */
    this.addElement = function(element) {

        var $ele = $(element),
            self = this;


        if ($ele.is('input:file')) {
            $ele
                .attr('name', name)
                .attr('id', name+'_' + self.count);

            element.multi_selector = self;

            $ele.change(function() {
                if ($ele.val() == '') {
                    return;
                }

                element.multi_selector.addedElements.push($ele.attr('id'));

                $(list_target).show();

                var $newEle = $('<input type="file"/>');
                $ele.before($newEle);

                element.multi_selector.addElement($newEle[0]);
                element.multi_selector.addListRow(element);

                $ele.css({'position': 'absolute', 'left': '-1000px', 'top': '-1000px'});


            });

            /* max number reached */
            if (self.max != -1 && self.count >= self.max) {
                var $buttonParent = $ele.parent('.j-attachment-button');
                if ($buttonParent.length) {
                    $buttonParent.hide();
                }

                $ele.attr('disabled', 'disabled').hide();
                $('#jive-attach-maxsize').show();
            } else if (self.max != -1 && self.count > self.max - 1) {
                $('#jive-attach-maxfiles').show();
            }


            $ele.unbind("afterFileAttach");
            $j.event.trigger("afterFileAttach");
            self.count++;
            self.current_element = element;
        } else {
            console.log('errors');
        }


    };

    /**
     * Add a new row to the list of files
     */
    this.addListRow = function(element) {
        var $ele         = $(element),
            $new_row     = $('<div class="jive-attach-item" id="jive-attach-item' + element.id.slice((name+"_").length) + '"/>'),
            $remove_link = $('<a href="#" class="j-remove-file font-color-meta">' + this.removeStr + '</a>');

        $new_row[0].element = element;


        // Remove function
        $remove_link.click(function() {
            var $parent = $(this).parent('div'),
                ele_id = $ele.attr('id');

            $(this).parent('div').remove();
            $ele.remove();

            var addedElements = this.parentNode.element.multi_selector.addedElements;
            for (var i = 0; i < addedElements.length; i++) {
                if (addedElements[i] == ele_id && addedElements.length == 1) {
                    // not sure why but in ff splice(0, 0) wouldn't work.
                    this.parentNode.element.multi_selector.addedElements = [];
                }
                else if (addedElements[i] == $()) {
                    addedElements.splice(i, i);
                }
            }

            // Decrement counter
            this.parentNode.element.multi_selector.count--;

            // hide list if no elements left
            if (this.parentNode.element.multi_selector.count < 2) {
                $(list_target).hide();
            }

            // Re-enable input element (if it's disabled)
            var $buttonParent = $j(this.parentNode.element.multi_selector.current_element).parent('.j-attachment-button');
            if ($buttonParent.length) {
                $buttonParent.show();
            }
            this.parentNode.element.multi_selector.current_element.style.display = "";
            this.parentNode.element.multi_selector.current_element.disabled = false;

            $("#jive-attach-maxsize").show();
            $ele.unbind("afterFileRemove");
            $j.event.trigger("afterFileRemove");

            // Appease Safari
            // without it Safari wants to reload the browser window
            // which nixes your already queued uploads
            return false;
        });
        $remove_link.hover(function() {
            $(this).parent('div').addClass('remove-hover');
        }, function() {
            $(this).parent('div').removeClass('remove-hover');
        })

        var ua = navigator.userAgent;
        var isWindows = ua.indexOf('Windows') != -1;
        var isMac = !isWindows && ua.indexOf('Mac') != -1;

        // Set row value
        var elValue = element.value;
        // grab only the filename minus the path
        var fName = elValue;
        if (fName.indexOf('\\') != -1 && isWindows) {
            fName = fName.substring(fName.lastIndexOf('\\') + 1);
        }
        else if (fName.indexOf('/') != -1) {
            fName = fName.substring(fName.lastIndexOf('/') + 1);
        }
        else if (fName.indexOf(':') != -1 && isMac) {
            fName = fName.substring(fName.lastIndexOf(':') + 1);
        }
        $new_row.text(fName + " ");

        // Add remove link
        $new_row.append($remove_link);

        // Add it to the list
        $(this.list_target).append($new_row);

    };

    this.removeAttachment = function(elementID, id) {
        // Add a hidden field removeAttachID -> id
        var new_element = document.createElement('input');
        new_element.type = 'hidden';
        new_element.name = "removeAttachID";
        new_element.value = id;

        // Replace div with hidden field
        var e = document.getElementById(elementID);
        e.parentNode.replaceChild(new_element, e);

        // decrement the counter
        this.count--;

        // hide list if no elements left
        if (this.count < 2) {
            list_target.style.display = "none";
        }

        // Re-enable input element (if it's disabled)
        this.current_element.style.display = "";
        this.current_element.disabled = false;
        $("#jive-attach-maxsize").style.display = "";

    };
    this.haveAttachmentsBeenAdded = function() {
        return this.addedElements.length > 0;
    }
};
