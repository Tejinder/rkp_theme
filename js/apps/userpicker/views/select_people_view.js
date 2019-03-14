jive.namespace('UserPicker');

/**
 * @depends path=/resources/scripts/jive/util.js
 * @depends template=jive.UserPicker.soy.searching
 * @depends template=jive.UserPicker.soy.renderModalLoading
 * @depends template=jive.UserPicker.soy.renderUserPickerModal
 * @depends path=/resources/scripts/jquery/jquery.form.js
 */
jive.UserPicker.SelectPeopleView = function() {
    var self = jive.conc.observable({}),
        $content,
        isMultiple = false,
        canInvitePartners = false,
        name = '',
        selectedUsers = {},
        browseModalUrl = _jive_base_url + '/user-autocomplete-modal.jspa',
        closeFocusSelector = '';

    // private

    function checkboxes(userIds) {
        var selectedIds = userIds.map(function(userId) {
            return 'userChk-' + userId;
        });

        return $j('input[id^=userChk-]').filter(function() {
            var checkboxId = $j(this).attr('id');
            return selectedIds.some(function(id) {
                return checkboxId === id;
            });
        });
    }

    function addUser(user) {
        // make sure we're only adding this user once, just in case
        selectedUsers[user.userID] = user;
        updateTotalUsers();
        updateUserNameDisplay();
        !isMultiple && complete();
        checkboxes([user.userID]).closest('tr').addClass('selected');
    }

    function updateCheckboxes() {
        checkboxes(Object.keys(selectedUsers)).each(function() {
            $j(this).prop('checked', true).closest('tr').addClass('selected');
        });
    }

    function updateUserNameDisplay() {
        var displayNames = [];
        $j.each(selectedUsers, function() {
            displayNames.push(this.displayName);
        });

        // JIVE-18840 we can't use .text() here because of an odd bug in IE. See ticket for details.
        var userNameList = jive.util.escapeHTML(displayNames.join(', '));
        $j('#preview').html(userNameList);
    }

    function removeUser(user) {
        delete selectedUsers[user.userID];
        updateTotalUsers();
        updateUserNameDisplay();
        checkboxes([user.userID]).closest('tr').removeClass('selected');
    }

    function attachEvents() {
        // toggle options
        $content.delegate('#userpicker-options-link', 'click', function(e) {
            e.preventDefault();
            $j('#jive-people-search-options').toggle();
        });

        // add users
        $content.delegate('#userpicker-addUsersButton', 'click', function(e) {
            e.preventDefault();
            !$j(this).hasClass('j-disabled') && complete();
        });

        // generic click events
        $content.delegate('#user-picker-modal-content a:not([data-action])', 'click', function(e) {
            e.preventDefault();
            get($j(this).attr('href')).addCallback(handleResponse);
        });

        // search form pagination
        $content.delegate('#user-picker-modal-content a[data-action=goToPage]', 'click', function(e) {
            e.preventDefault();

            $j('#profilesearchform-start').val($j(this).data('page'));
            $content.find('form').submit();
        });

        // checkbox clicks
        $content.delegate('#user-picker-modal-content :checkbox', 'click', function() {
            var $target = $j(this),
                $container = $target.closest('.jive-table-cell-checkbox'),
                user = {
                    avatar: $j('#' + $target.val() + '-avatar').html(),
                    displayName: $container.children().not('input').html(),
                    userID: $target.val(),
                    userName: $container.find(':hidden').val()
                };

            this.checked ? addUser(user) : removeUser(user);
        });


			// radio clicks
        $content.delegate('#user-picker-modal-content :radio', 'click', function() {			
            var $target = $j(this),
                $container = $target.closest('.jive-table-cell-checkbox'),
                user = {
                    avatar: $j('#' + $target.val() + '-avatar').html(),
                    displayName: $container.children().not('input').html(),
                    userID: $target.val(),
                    userName: $container.find(':hidden').val()
                };

            this.checked ? addUser(user) : removeUser(user);
        });
		
		
        $content.delegate('.userpicker-sort-link', 'click', function(e) {
            e.preventDefault();

            $j('#profilesearchform-sort').val($j(this).data('sortType'));
            $j('#profilesearchform').submit();
        });
    }

    function attachSubmitEvents() {
        // search
        $content.find('form').ajaxForm({
            beforeSubmit: function(formData) {
                formData.push({
                    name: 'selectedUsers',
                    value: buildSelectedUsersString()
                });
                $j('#people-search-submit').prop('disabled', true);
                $j('#people-search-submit').val(jive.UserPicker.soy.searching());
            },
            success: function(html) {
                handleResponse(html);
            },
            error: function(response, status, xhr) {
                handleErrorResponse(response, status, xhr);
            }
        });
    }

    function buildSelectedUsersString() {
        var userIds = [];
        $j.each(selectedUsers, function(id) {
            return userIds.push(id);
        });

        return userIds.join(',');
    }

    function complete() {
        var users = [];
        $j.each(selectedUsers, function() {
            users.push(this);
        });

        selectedUsers = {};
        $content.find('#userpicker-addUsersButton').after(jive.UserPicker.soy.renderModalLoading());
        self.emit('select' + name, {
            users: users
        });
    }

    function get(href) {
        var promise = new jive.conc.Promise();

        $j.get(href + '&selectedUsers=' + buildSelectedUsersString(), promise.emitSuccess.bind(promise));

        return promise;
    }

    function handleResponse(html) {
        var $html = $j(jive.UserPicker.soy.renderUserPickerModal({
            body: html
        }));
        $j('#user-picker-modal-content').replaceWith($html.find('#user-picker-modal-content'));
        updateTotalUsers();
        updateUserNameDisplay();
        updateCheckboxes();
        attachSubmitEvents();
    }

    function handleErrorResponse(response, status, xhr) {
        $j('#people-search-submit').prop('disabled', false);
        $j('#people-search-submit').val(jive.UserPicker.soy.search());
        updateTotalUsers();
        updateUserNameDisplay();
        updateCheckboxes();
        attachSubmitEvents();
    }

    function updateTotalUsers() {
        $j('#userpicker-addUsersButton').toggleClass('j-disabled', $j.isEmptyObject(selectedUsers));
    }

    // public
    self.setOptions = function(options) {
		self.options = options;
        isMultiple = typeof(options.multiple) != 'undefined' ? options.multiple : false;
        name = typeof(options.name) != 'undefined' ? options.name : '';
        canInvitePartners = typeof(options.canInvitePartners) != 'undefined' ? options.canInvitePartners : false;
        closeFocusSelector = typeof(options.closeFocusSelector) != 'undefined' ? options.closeFocusSelector : '';

        return self;
    };

    self.open = function() {
		
				
        var that = this;		
        var data = { multiple: isMultiple, canInvitePartners: canInvitePartners};
        if(self.options.defaultFilters) {
            $j.each(self.options.defaultFilters, function(name) {			
                if(name == 'role') {
                    $j.extend(data, {roleEnabled:false, ownerfield:false, hideInvite:false});
                } else if(name == 'brand') {
                    $j.extend(data, {brandEnabled:false});
                }  else if(name == 'region') {
                    $j.extend(data, {regionEnabled:false});
                } else if(name == 'country') {
                    $j.extend(data, {countryEnabled:false});
                } else if(name == 'jobTitle') {
                    $j.extend(data, {jobTitleEnabled:false});
                }				
            });
            $j.extend(data, self.options.defaultFilters);			
        }
		
        $j.ajax({
            url: browseModalUrl,
            data: data,
            success: function(html) {
                self.render({
                    body: html
                });
            }
        });
        return self;
    };

    self.close = function() {
        if ($content) {
            $content.find('.close').trigger('click');
        }
        return self;
    };

    self.render = function(data) {
        $content = $j(jive.UserPicker.soy.renderUserPickerModal(data));
        attachEvents();
        updateTotalUsers();

        $j($j($content)[0]).lightbox_me({
            // Position modal in front of the RTE content picker.
            zIndex: 300015,
            destroyOnClose: true,
			closeEsc:false,
            parentLightbox: $j('.jive-modal:visible'),
            closeFocusSelector: closeFocusSelector,
            onLoad: function() {
                isMultiple = $content.find('.jive-body-popup-container-userpicker').data('isMultiple');
                attachSubmitEvents();
            },
			onClose:function(){
                $j.event.trigger("onUserpickerClose");
            }
        });
		$j.event.trigger("onUserpickerLoad");
		$j("#user-autocomplete-modal-container").find("h2").text("Select People");
		$j("#user-autocomplete-modal-container").find(".j-modal-close-top").text("Close");
    };


    return self;
};


define('apps/userpicker/views/select_people_view', function() {
    return jive.UserPicker.SelectPeopleView;
});