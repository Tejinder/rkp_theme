/*
 * $Revision: 1.1 $
 * $Date: 2018/03/19 12:14:26 $
 *
 * Copyright (C) 1999-2010 Jive Software. All rights reserved.
 *
 * This software is the proprietary information of Jive Software. Use is subject to license terms.
 */

/*globals innerShiv _jive_base_url */
/*jshint curly:false boss:true */

jive.namespace('UserPicker');

/**
 * this class replaces an <input> with a user autocomplete input
 *
 * @depends path=/resources/scripts/apps/userpicker/models/result_store.js
 * @depends path=/resources/scripts/apps/userpicker/views/select_people_view.js
 * @depends path=/resources/scripts/apps/userpicker/views/userpicker_message_view.js
 * @depends path=/resources/scripts/apps/userpicker/views/result_list_view.js
 * @depends path=/resources/scripts/apps/placepicker/views/container_browse_view.js
 * @depends path=/resources/scripts/jquery/jquery.scrollTo.js
 * @depends path=/resources/scripts/jquery/jquery.typeAhead.js
 * @depends path=/resources/scripts/jquery/ui/jquery.ui.core.js
 * @depends template=jive.UserPicker.soy.inputPlaceholder
 * @depends template=jive.UserPicker.soy.renderModalBrowseButton
 * @depends template=jive.UserPicker.soy.renderModalPlaceBrowseButton
 * @depends template=jive.UserPicker.soy.renderSelectedUsersList
 * @depends template=jive.UserPicker.soy.renderSelectedUser
 */
define('apps/userpicker/views/userpicker_view', ['apps/shared/views/abstract_view'], function(abstract_view) {
    jive.UserPicker.View = abstract_view.extend(function(protect) {

        // Mix in observable to make this class an event emitter.
        jive.conc.observable(this);

        /**
         * the jquery object to use to create the user picker input
         * @param $input
         */
		 
		 
        this.init = function($input, opts) {

            this.options = opts;

            var that = this;
			that.options.inputname = $input;
            this.$input = $input;
			
            if (opts.placeHolder) {
                this.setPlaceholder(opts.placeHolder);
            } else {
                this.setPlaceholder(jive.UserPicker.soy.inputPlaceholder(opts));
            }

            this.$input.attr('autocomplete', 'off');
            this.$input.parents('form').attr('autocomplete', 'off');

            if (opts.emailAllowed && !opts.userAllowed) {
                this.$input.addClass('j-user-autocomplete-email');
            }

            this.urls = {
                userAutocomplete: _jive_base_url + '/user-autocomplete.jspa'
            };

            this.changes = {};

            this.selectPeopleView = new jive.UserPicker.SelectPeopleView();
            this.selectPlaceView = new jive.Placepicker.ContainerBrowseView({
                followLinks: false,
                closeOnSelect: this.closeOnSelect,
                hideUserContainer: true,
                includeShareContext : opts.includeShareContext || false
            });
            this.selectionCallbacks = opts.selectionCallbacks || [];
            this.messagesView = new jive.UserPicker.Messages($input, opts);
            this.resultStore = new jive.UserPicker.ResultStore();

            this.showNoPicker = false;

            this.selectedUsers = [];
            this.selectedLists = [];
            this.selectedContainers = [];
            this.excludedContainers = [];

            $input.addClass('jive-chooser-input jive-form-textinput-variable');

            // create an input that'll actually hold the user ids / email addresses
            $input.before('<input type=\'hidden\'/>');
            this.$valueStore = $input.prev();
            this.$valueStore.attr('name', opts.userParam || $input.attr('name'));
            $input.removeAttr('name');

            // create selected block
            this.$selected = $j('<div class="jive-chooser-list j-result-list j-people-list clearfix"></div>');
            if (this.options.resultListAllowed) {
                $input.after(this.$selected.hide());
            }

            var canInvitePartners = false;
            if (opts.canInvitePartners) {
                canInvitePartners = opts.canInvitePartners;
            }

            var canInvitePreprovisioned = false;
            if (opts.canInvitePreprovisioned) {
                canInvitePreprovisioned = opts.canInvitePreprovisioned;
            }

            var invitePreprovisionedDomainRestricted = false;
            if (opts.invitePreprovisionedDomainRestricted) {
                invitePreprovisionedDomainRestricted = opts.invitePreprovisionedDomainRestricted;
            }

            // create results block
            var $chooser = $j('<div class="j-pop j-autocomplete j-menu j-quick-menu"></div>');
            this.chooserView = new jive.UserPicker.ResultListView({
                $chooser: $chooser,
                $input: $input,
                emailAllowed: opts.emailAllowed,
                userAllowed: opts.userAllowed,
                listAllowed: opts.listAllowed,
                placeAllowed: opts.placeAllowed,
                domains: opts.domains,
                trial: opts.trial,
                canInvitePartners: canInvitePartners,
                canInvitePreprovisioned: canInvitePreprovisioned,
                invitePreprovisionedDomainRestricted: invitePreprovisionedDomainRestricted,
                onShow: function(chooser) {
                    $input.data('typeAhead').setSuggestElement(chooser);
                },
                onHide: function() {
                    $input.data('typeAhead').updateAriaAttributes();
                }
            });

            this.maxSelectedCount = opts.maxSelectedCount;
            this.isRelationshipRestricted = opts.relatedMessage ? true : false;

            if (that.options.userAllowed && opts.filterIDs.length === 0) {
                that.$browse = $j(jive.UserPicker.soy.renderModalBrowseButton({
                    plural: that.options.multiple
                }));
                if (that.options.browseAllowed) {
                    $input.after(that.$browse);
                    that.$browse.click(function() {
                        that.loadBrowseModal();
                    });
                }
                if (opts.skillsEnabled) {
                    require(['apps/userpicker/views/select_skill_view', 'soy!jive.UserPicker.soy.renderModalSkillSearchButton'],
                        function(SelectSkillView, SkillSearchButton) {
                            var selectSkillView = new SelectSkillView();
                            var $skillSearch = $j(SkillSearchButton());
                            $input.closest('.js-invitees').append($skillSearch);
                            $skillSearch.click(function(e) {
                                e.preventDefault();
                                that.options.closeFocusSelector = $skillSearch;
                                selectSkillView
                                    .setOptions(that.options)
                                    .addListener('select' + that.options.name, function(payload) {
                                        that.selectAction(payload);
                                        $skillSearch.focus();
                                    })
                                    .open();
                            });
                        });
                }
            }
            if (that.options.placeAllowed && that.options.browsePlaceAllowed) {
                that.$browsePlace = $j(jive.UserPicker.soy.renderModalPlaceBrowseButton());
                if (that.$browse) {
                    that.$browse.after(that.$browsePlace);
                    that.$browsePlace.click(function() {
                        that.loadPlaceBrowseModal();
                    });
                } else {
                    $input.after(that.$browsePlace);
                    that.$browsePlace.click(function() {
                        that.loadPlaceBrowseModal();
                    });
                }
            }

            this.lastAjaxAsk = '';

            //Event handlers specific to Jquery.typeAhead.js Plugin
            $input.typeAhead({
                    keystrokeWait: 600,
                    itemSelector: 'li:visible',
                    selectedClass: 'j-selected'
                }).on('selectionChosen', function(ev, typeAhead, selected) {
                    that.selectResult(selected.children('a'));
                }).on('otherEnter', function(ev, typeAhead) {
                    that.selectBestMatch(false);
                }).on('keystroke.suggestBox', function(ev) {
                    var val = $input.val();
                    if (val != that.lastAjaxAsk) {
                        if (/[\|;,@]/.test(val)) {
                            that.handlePaste().then(function() {
                                that.ajaxTheUserList();
                            });
                        } else {
                            that.ajaxTheUserList();
                        }
                    }
                })
                .on('close', function(ev) {
                    that.hideTheUserList(true);
                    ev.stopPropagation();
                }).attr('aria-autocomplete', 'list');

            //JIVE-28366 - END

            this.typeAhead = $input.data('typeAhead');

            // init default value
            this.setSelectedUsers(that.options.startingUsers.users);
            this.setSelectedLists(that.options.startingUsers.userlists);
            this.setSelectedContainers(that.options.startingContainers);
            this.setExcludedContainers(that.options.excludedContainers);
			
			//TODO Uncomment below code
			/*
			if(that.isSynchroPortal()) {
				$input.bind('input',function(e){
					if(typeof ($j(this).data('events').focusout) == 'undefined') {
						$input.focusout(function(e){inputChange()});
					}
				});
			}
			*/
			if(that.isSynchroPortal()) {
				$input.focusout(function() {					
				//	inputChange();
				});
			}		

        function inputChange() {
			console.log("THT --> " + JSON.stringify(that));
            var target = $input;
            if($j(target).val()) {
                if(that.selectedUsers.length) {
                    var match = $j.grep(that.selectedUsers, function(item){
                        return item.displayName == $j(target).val();
                    });
                    if(match.length == 0) {
                        $input.val(that.selectedUsers[0].displayName);
                    }
                } else {
                    var user = $j.grep(that.userStore.toArray(),function(item){
                        return typeof item == 'object' && item.displayName == $j(target).val();
                    });
                    if(user.length > 0) {
                        $j.ajax({
                            url : _jive_base_url + '/__services/v2/rest/users/' + user[0].id,
                            dataType : "json",
                            success : function(user){
                                if(user && !contains(that.selectedUsers, user)){
                                    that.selectedUsers.push(user);
                                    that.refreshSelectedUserListDisplayAndHiddenInput();
                                }
                            },
                            error : function(){
                                console.log("User not found");
                            }
                        });
                    } else {
                        that.selectedUsers = [];
                        $input.val("");
                        that.$valueStore.val("");
                        that.$valueStore.trigger("userUpdated");
                    }
                }
            } else {
                that.selectedUsers = [];
                that.$valueStore.val("");
                that.$valueStore.trigger("userUpdated");
            }

        }
        };
		
		 this.isSynchroPortal = function() {
			return (this.options.isSynchroPortal
				|| (document.location.href.indexOf("/synchro/") != -1))
		}

        protect.selectAction = function(payload) {
            var that = this;
            var selected = payload.users;
			
			if(!that.options.multiple) {
                that.selectedUsers = [];
                this.selectedLists = [];
            }
			
            that.changes = {
                added: []
            };
            if (selected.length > 0) {
                var count = selected.length;
                selected.forEach(function(selectedUser) {
                    that.emitP('loadUser', selectedUser.userID).addCallback(
                        function(user) {
                            count--;
                            if (user && !that.containsItem(that.selectedUsers, user)) {
                                that.changes.added.push(user);
                                that.selectedUsers.push(user);
                                that.refreshSelectedUserListDisplayAndHiddenInput();
                            }
                            if (count === 0) {
                                that.selectPeopleView.close();
                                that.messagesView.showResultMessages(that.changes);
                                that.emit('selectedUsersChanged', that.getSelectedUsersAndLists());
                            }
                        }).addErrback(function() {
                        count--;
                        if (count === 0) {
                            that.selectPeopleView.close();
                            that.messagesView.showResultMessages(that.changes);
                            that.emit('selectedUsersChanged', that.getSelectedUsersAndLists());
                        }
                    });
                });
            }
        };

        this.removeList = function(list_id, shouldRemove) {
            var that = this;
            if (list_id) {
                var removedList;
                if (that.showNoPicker) {
                    that.selectedLists = that.selectedLists.map(function(list) {
                        if (list.id == list_id) {
                            removedList = that.cloneList(list);
                            list.excluded = shouldRemove;
                        }
                        return list;
                    });
                } else {
                    that.selectedLists = that.selectedLists.filter(function(list) {
                        if (list.id == list_id) {
                            removedList = that.cloneList(list);
                        }
                        return list.id != list_id;
                    });
                }
                if (shouldRemove && removedList) {
                    that.changes = {
                        removed: removedList
                    };
                }
            }
        };

        this.removeUser = function(user_id, user_email, shouldRemove) {
            var that = this;
            var removedUser;
            if (user_id && user_id != -1) {
                if (that.showNoPicker) {
                    that.selectedUsers = that.selectedUsers.map(function(user) {
                        if (user.id == user_id) {
                            removedUser = that.cloneUser(user);
                            user.excluded = shouldRemove;
                        }
                        return user;
                    });
                } else {
                    that.selectedUsers = that.selectedUsers.filter(function(user) {
                        if (user.id == user_id) {
                            removedUser = that.cloneUser(user);
                        }
                        return user.id != user_id;
                    });
                }
            } else if (user_email) {
                that.selectedUsers = that.selectedUsers.filter(function(user) {
                    if (user.email == user_email) {
                        removedUser = that.cloneUser(user);
                    }
                    return user.email != user_email;
                });
            }
            if (shouldRemove && removedUser) {
                that.changes = {
                    removed: removedUser
                };
            }
        };

        this.removeContainer = function(container_type, container_id, shouldRemove) {
            var that = this;
            if (container_type && container_id) {
                var removedContainer;
                if (that.showNoPicker) {
                    that.selectedContainers = that.selectedContainers.map(function(container) {
                        if (container.id == container_id && container.type == container_type) {
                            removedContainer = that.cloneContainer(container);
                            container.excluded = shouldRemove;
                        }
                        return container;
                    });
                } else {
                    that.selectedContainers = that.selectedContainers.filter(function(container) {
                        if (container.id == container_id && container.type == container_type) {
                            removedContainer = that.cloneContainer(container);
                        }
                        return container.id != container_id || container.type != container_type;
                    });
                }
                if (shouldRemove && removedContainer) {
                    that.changes = {
                        removed: removedContainer
                    };
                }
            }
        };

        protect.setPlaceholder = function(val) {
            this.$input.attr('placeholder', val);
            if (this.$input.placeHeld) {
                this.$input.placeHeld();
            }
        };

        /**
         * this function is responsible for rendering the list
         * of selected users and user-lists. it is also responsible
         * for setting the value of the hidden input to an list
         * of user ids
         */
        protect.refreshSelectedUserListDisplayAndHiddenInput = function() {
			this.$input.unbind('focusout');
            var that = this;
            var userList = [];
            var userIdList = [];
            var containerList = [];
            // if this var is false,
            // then we show() $permissionmsg
            // otherwise hide()
            var hasPermission = true;
            var hasRelationship = true;
            var overResultLimit = false;

            $j(that.selectedUsers).each(function(index, user) {
                hasPermission = hasPermission && user.entitled;
                user.prop.hasConnection = (typeof(user.prop) != 'undefined' ?
                    (typeof(user.prop.hasConnection) !=
                        'undefined' ? user.prop.hasConnection : true) : true);
                user.prop.isVisibleToPartner = (typeof(user.prop) != 'undefined' ?
                    (typeof(user.prop.isVisibleToPartner) !=
                        'undefined' ? user.prop.isVisibleToPartner : false) : false);
                hasRelationship = hasRelationship && user.prop.hasConnection;
                if (!that.containsItem(userList, user) && !user.excluded) {
                    if (that.inSelectedCountLimit(userIdList)) {
                        userList.push(user);
                        if (user.id == -1) {
                            userIdList.push(user.email);
                        } else {
                            if (that.options.valueIsUsername) {
                                userIdList.push(user.username);
                            } else {
                                userIdList.push(user.id);
                            }
                        }
                    } else {
                        that.removeUser(user.id, user.email, false);
                        overResultLimit = true;
                    }
                }
            });
            $j(that.selectedLists).each(function(index, list) {
                if (!list.excluded) {
                    var listHasPermission = true;
                    $j(list.users).each(function(index, user) {
                        listHasPermission = listHasPermission && user.entitled;

                        user.prop.hasConnection = (typeof(user.prop) != 'undefined' ?
                            (typeof(user.prop.hasConnection) != 'undefined' ? user.prop
                                .hasConnection : true) : true);
                        hasRelationship = hasRelationship && user.prop.hasConnection;
                        if (!that.containsItem(userList, user)) {
                            if (that.inSelectedCountLimit(userIdList)) {
                                userList.push(user);
                                if (user.id == -1) {
                                    userIdList.push(user.email);
                                } else {
                                    if (that.options.valueIsUsername) {
                                        userIdList.push(user.username);
                                    } else {
                                        userIdList.push(user.id);
                                    }
                                }
                            } else {
                                that.removeUser(user.id, user.email, false);
                                overResultLimit = true;
                            }
                        }
                    });
                    list.entitled = listHasPermission;
                    hasPermission = hasPermission && listHasPermission;
                }
            });

            $j(that.selectedContainers).each(function(index, container) {
                if (!container.excluded && !that.containsItem(containerList, container) && !that.containsItem(that.excludedContainers, container)) {
                    if (that.inSelectedCountLimit(userIdList)) {
                        containerList.push(container);
                        userIdList.push(container.type + '-' + container.id);
                    } else {
                        that.removeContainer(container.type, container.id, false);
                        overResultLimit = true;
                    }
                }
            });

            that.messagesView.togglePermissionMessage(hasPermission);
            that.messagesView.toggleRelatedMessage(hasRelationship);
            that.messagesView.toggleLimitMessage(overResultLimit);
            that.messagesView.hideResultMessages();

            that.$valueStore.val(userIdList.join(','));
			this.$valueStore.trigger("userUpdated");

            if (that.selectedLists.length || that.selectedUsers.length || that.selectedContainers.length) {
				 if(that.isSynchroPortal()) {
                    if(that.options.multiple){
                        var usernameList = [];
                        var userSelectedList = [];
                        if(that.selectedLists.length) {
                           userSelectedList = that.selectedLists;
                        } else if(that.selectedUsers.length) {
                            userSelectedList = that.selectedUsers;
                        }
                        $j(userSelectedList).each(function(index, item) {
                            usernameList.push(item.displayName);
                        });
						
                        that.options.inputname.val(usernameList.join(", "));
                    } else {
						//console.log("THAT " + that.options.inputname.attr("id"));
						var userDisplayName = jive.UserPicker.soy.renderCustomUserDisplayName({
										results: {
											users: that.selectedUsers,
											userlists: that.selectedLists,
											containers: that.selectedContainers
										},
										disabled: that.options.disabled
									});
													
                    
						that.options.inputname.val(userDisplayName);
                    }
                } else 
				{
                if (that.options.multiple) {
                    that.$selected.html(jive.UserPicker.soy.renderSelectedUsersList({
                        results: {
                            users: that.selectedUsers,
                            userlists: that.selectedLists,
                            containers: that.selectedContainers
                        },
                        message: that.options.message,
                        disabled: that.options.disabled,
                        relationship: that.isRelationshipRestricted
                    })).show();
                } else {
                    that.$selected.html(jive.UserPicker.soy.renderSelectedUser({
                        results: {
                            users: that.selectedUsers,
                            userlists: that.selectedLists,
                            containers: that.selectedContainers
                        },
                        disabled: that.options.disabled
                    })).show();
	
                    if (that.selectedUsers.length || that.selectedContainers.length) {
					 if(that.isSynchroPortal()) {
						  //  that.$input.hide();
                        if (that.$browse) {
                        //    that.$browse.hide();
                        }
                        if (that.$browsePlace) {
                            that.$browsePlace.hide();
                        }
					 }
					else
					{
						that.$input.hide();
                        if (that.$browse) {
							that.$browse.hide();
                        }
                        if (that.$browsePlace) {
                            that.$browsePlace.hide();
                        }
						
					}	
					
                    }
                }
			}
                var $li;
                that.$selected.find('li').each(function() {
                    $li = $j(this);
                    $li.find('a.showConnections').click(function() {
                        var theOther = this;
                        var theDiv = $j.find('#listContents' + $j(theOther).closest('li').data('list-id'));
                        $j(theDiv).popover({
                            context: $j(theOther),
                            putBack: true,
                            destroyOnClose: false,
                            container: that.$selected.closest('.j-modal')
                        });
                        return false;
                    });

                    $li.find('em a.add, em a.remove').parent().click(function(e) {
                        var $container = $j(this).closest('li'),
                            $anchor = $j('a.add, a.remove', this),
                            shouldRemove = $anchor.hasClass('remove'),
                            list_id = $container.data('list-id'),
                            user_id = $container.data('user-id'),
                            user_email = $container.data('user-email'),
                            container_id = $container.data('container-id'),
                            container_type = $container.data('container-type');

                        // JIVE-18461 remove any popovers that may be hanging around
                        $container.closest('.j-modal').find('.js-pop').remove();

                        if (list_id) {
                            that.removeList(list_id, shouldRemove);
                        }
                        if (user_id || user_email) {
                            that.removeUser(user_id, user_email, shouldRemove);
                        }
                        if (container_id && container_type) {
                            that.removeContainer(container_type, container_id, shouldRemove);
                        }

                        that.emit('selectedUsersChanged', that.getSelectedUsersAndLists());
                        that.refreshSelectedUserListDisplayAndHiddenInput();

                        e.preventDefault();
                    });
                });

                //scroll to the last item in the list
                if ($li) {
                    that.$selected.find('ul').scrollTo($li);
                }
            } else {
                that.$selected.html('');
                that.$selected.hide();
                that.show();
            }

            that.selectionCallbacks.forEach(function(callback) {
                callback(that.$selected, that.selectedUsers, that.selectedLists);
            });
        };

        protect.inSelectedCountLimit = function(selectedList) {
            return !this.maxSelectedCount || selectedList.length < this.maxSelectedCount;
        };

        /**
         * the function is called when the user clicks or presses [enter] for either
         * a list, an email address, user or container.
         */
        protect.selectResult = function(anchor) {
            var that = this;
            var data = anchor.data();
            var result = that.chooseResult(data);
			
			if(!that.options.multiple) {
                that.selectedUsers = [];
                that.selectedLists = [];
            }
			
			
            if (result) {
				//console.log("Result -> " + JSON.stringify(result));				
				
                var token = (result.prop && result.prop.matchToken) ? result.prop.matchToken : $j.trim(that.$input.val());
                that.$input.val(that.$input.val().replace(new RegExp(token + '([,;|\\s])?'), ''));
                that.lastAjaxAsk = that.$input.val();
                that.$input.focus();

                that.refreshSelectedUserListDisplayAndHiddenInput();
                that.hideTheUserList(data.userEmail);
				var doNotReset = (that.isSynchroPortal()?true:false);
				
				//TODO Uncomment below code
				that.hideTheUserList(doNotReset);
				
                // User or User List
                if (result.objectType == 3 || result.objectType == 53 || (result.archetype && result.archetype == 'containers')) {
                    var changes = {
                        added: [result]
                    };					
					// Set resulted userDisplayName in input box
					if(that.isSynchroPortal()) {
						if(result && result.displayName && result.id)
						{
							var userDisplayName = result.displayName;
							that.options.inputname.val(userDisplayName);
							//Set user ID
							var userID = result.id;
							var inputname = that.options.inputname.attr("id");						
							$j("input[name='"+inputname+"']").val(userID);	
						}						
					}
					else
					{
						//Default behavoiur for IRIS and other modules
						that.messagesView.showResultMessages(changes);
					}                    
                }
            }
        };

        protect.chooseResult = function(data) {
            var that = this;
            var result;
            if (data.userId || data.userEmail) {
                // add the user to the selected items
                var user = that.resultStore.getUser(data.userId, data.userEmail);
                if (user && !that.containsItem(that.selectedUsers, user)) {
                    that.selectedUsers.push(user);
                    that.changes = {
                        added: user
                    };

                    that.emit('selectedUsersChanged', that.getSelectedUsersAndLists());
                    result = user;
                }
            } else if (data.listId) {
                var list = that.resultStore.getList(data.listId);
                if (list && !that.containsItem(that.selectedLists, list)) {
                    that.selectedLists.push(list);
                    that.changes = {
                        added: list
                    };

                    that.emit('selectedUsersChanged', that.getSelectedUsersAndLists());
                    result = list;
                }
            } else if (data.containerId && data.containerType) {
                var container = that.resultStore.getContainer(data.containerType, data.containerId);

                if (container && that.containsItem(that.excludedContainers, container)) {
                    container.alreadyLinkedToPlace = true;
                }

                if (container && !that.containsItem(that.selectedContainers, container)) {
                    that.selectedContainers.push(container);
                    that.changes = {
                        added: [container]
                    };

                    that.emit('selectedUsersChanged', that.getSelectedUsersAndLists());
                    result = container;
                }
            }
            return result;
        };

        protect.containsItem = function(arr, ask) {
            var has = false;
            $j(arr).each(function(index, item) {
                if (ask.id == -1) {
                    has = has || (jive.util.equalsIgnoreCaseAndPadding(item.email, ask.email));
                } else {
                    has = has || (item.id == ask.id && item.objectType == ask.objectType && (!ask.type || item.type == ask.type));
                }
            });
            return has;
        };

        protect.cloneUser = function(user) {
            return {
                displayName: user.displayName,
                id: user.id,
                anonymous: user.anonymous,
                external: user.external,
                enabled: user.enabled,
                visible: user.visible,
                objectType: user.objectType,
                username: user.username,
                email: user.email,
                entitled: user.entitled,
                prop: {
                    hasConnection: (typeof(user.prop) != 'undefined' ?
                        (typeof(user.prop.hasConnection) != 'undefined' ? user.prop
                            .hasConnection : true) : true),
                    isVisibleToPartner: (typeof(user.prop) != 'undefined' ?
                        (typeof(user.prop.isVisibleToPartner) != 'undefined' ? user.prop
                            .isVisibleToPartner : false) : false)
                },
                avatarID: user.avatarID,
                excluded: (typeof(user.excluded) != 'undefined' ? user.excluded : false),
                disabled: (typeof(user.disabled) != 'undefined' ? user
                        .disabled : false) //applies to take action on the selected user, unrelated to 'enabled' param
            };
        };

        protect.cloneList = function(list) {
            var view = this;
            var ret = {
                displayName: list.displayName,
                id: list.id,
                objectType: list.objectType,
                style: list.style,
                users: [],
                excluded: (typeof(list.excluded) != 'undefined' ? list.excluded : false)
            };
            $j(list.users).each(function(index, user) {
                ret.users.push(view.cloneUser(user));
            });
            return ret;
        };

        protect.cloneContainer = function(container) {
            return {
                subject: container.subject,
                id: container.id,
                type: container.type,
                iconCss: container.iconCss,
                excluded: (typeof(container.excluded) != 'undefined' ? container.excluded : false)
            };
        };

        this.shiv = function(html) {
            if (typeof innerShiv != 'undefined') {
                return innerShiv(html);
            } else {
                return html;
            }
        };

        /**
         * make sure that this.selectedUsers contains every user
         * in the input array
         *
         * be sure to maintain the .excluded bit on every user
         * object currently in the this.selectedUsers array
         * @param arr
         */
        this.setSelectedUsers = function(arr) {
            if (!arr) {
                arr = [];
            }
            var that = this;
            $j(arr).each(function(index, item) {
                if (!that.containsItem(that.selectedUsers, item)) {
                    that.selectedUsers.push(that.cloneUser(item));
                }
            });
            for (var i = 0; i < that.selectedUsers.length; i++) {
                if (!that.containsItem(arr, that.selectedUsers[i])) {
                    that.selectedUsers.splice(i, 1);
                    i--;
                }
            }
            this.refreshSelectedUserListDisplayAndHiddenInput();
        };

        this.setSelectedLists = function(arr) {
            if (!arr) {
                arr = [];
            }
            var that = this;
            $j(arr).each(function(index, item) {
                if (!that.containsItem(that.selectedLists, item)) {
                    that.selectedLists.push(that.cloneList(item));
                }
            });
            for (var i = 0; i < this.selectedLists.length; i++) {
                if (!that.containsItem(arr, that.selectedLists[i])) {
                    this.selectedLists.splice(i, 1);
                    i--;
                }
            }
            this.refreshSelectedUserListDisplayAndHiddenInput();
        };

        this.setSelectedContainers = function(arr) {
            if (!arr) {
                arr = [];
            }
            var that = this;
            $j(arr).each(function(index, item) {
                if (!that.containsItem(that.selectedContainers, item)) {
                    that.selectedContainers.push(that.cloneContainer(item));
                }
            });
            for (var i = 0; i < this.selectedContainers.length; i++) {
                if (!that.containsItem(arr, that.selectedContainers[i])) {
                    this.selectedContainers.splice(i, 1);
                    i--;
                }
            }
            this.refreshSelectedUserListDisplayAndHiddenInput();
        };

        this.setExcludedContainers = function(arr) {
            if (!arr) {
                arr = [];
            }
            var that = this;
            $j(arr).each(function(index, item) {
                if (!that.containsItem(that.excludedContainers, item)) {
                    that.excludedContainers.push(that.cloneContainer(item));
                }
            });
        };

        this.getSelectedUsersAndLists = function(includeListUsers) {
            var that = this;
            var users = $j.merge([], this.selectedUsers);
            if (includeListUsers) {
                that.selectedLists.forEach(function(list) {
                    list.users.forEach(function(user) {
                        if (!that.containsItem(users, user)) {
                            users.push(user);
                        }
                    });
                });
            }
            return {
                users: users,
                userlists: this.selectedLists,
                containers: this.selectedContainers,
                changes: this.changes
            };
        };

        this.val = function() {
            return this.$valueStore.val();
        };

        /**
         * the dropdown needs to be dismissed, hide it from view
         */
        protect.hideTheUserList = function(dontReset) {			
            this.chooserView.hide();
            if (!dontReset) {
                this.$input.val('');
            }
        };

        /**
         * make sure that our dropdown is showing the latest
         * and greatest list of users/lists/emails, and if not,
         * then ajax in the new values for it
         */
        protect.ajaxTheUserList = function() {
            // fire off an ajax to load the popup if needed
            if (this.lastAjaxAsk != this.$input.val() && this.$input.val().length) {
                if (this.$input.val().length > 1) { // Don't bother the server until there are at least 2 characters to match
                    this.lastAjaxAsk = this.$input.val();
                    this.emit('autocompleteRequest', this.lastAjaxAsk.replace(';', '|'));
                }
            } else if (this.lastAjaxAsk.length && this.$input.val().length) {
                this.chooserView.show();
            }

            if (!this.$input.val || this.$input.val().length === 0) {
                this.chooserView.hide();
            }
            return true;
        };


        protect.isEmptyInput = function() {
            return $j.trim(this.$input.val()).length === 0;
        };

        protect.selectBestMatch = function(matchName) {
            var that = this,
                $item;
            var val = $j.trim(this.$input.val());
            if (val && val.length > 0) {
                $item = that.typeAhead.getSelectable();
                if ($item.length == 1) {
                    $item = $item.find('a:first');
                    that.selectResult($item);
                    return false;
                } else if (that.isValidEmailAddress(val.toLowerCase())) {
                    //if token is email address (case insensitive), add user
                    $item = this.typeAhead.getSelected().children('a');
                    if (jive.util.equalsIgnoreCaseAndPadding($item.data('user-email'), val)) {
                        that.selectResult($item);
                    }
                    return false;
                } else if (matchName) {
                    //if token is exact match of name or username (case sensitive) or only one result, add user
                    $item = that.chooserView.findNameMatches(val);
                    if ($item.length == 1) {
                        that.selectResult($item);
                    }
                    return false;
                }
            }
            return true;
        };

        protect.handlePaste = function() {
            var that = this;
            var spinnerContext = {
                context: $j('.j-user-input-typeahead')
            };
            that.showSpinner(spinnerContext);
            return that.emitP('batchRequest', $j.trim(that.$input.val()).replace(/;/g, '|')).always(function() {
                that.hideSpinner(spinnerContext);
            }).then(
                function(data) {
                    if (data.users) {
                        that.resultStore.storeResults(data);
                        var selected = [];
                        var tokens = that.$input.val().split(new RegExp(/[\|;,]+/));

                        var tokenReplaceString = that.$input.val();
                        tokens.forEach(function(token) {
                            var sanatizedToken = token.trim();
                            var listOfMatchedUsers = that.tokenMatchesOneUser(data.users, sanatizedToken);
                            if (listOfMatchedUsers.length === 1) {
                                var result = that.chooseResult({
                                    userId: listOfMatchedUsers[0].id,
                                    userEmail: listOfMatchedUsers[0].email
                                });
                                if (result) {
                                    selected.push(result);
                                    var regex = new RegExp(token + '([,;|\\s])?','g');
                                    var regexLastChar = new RegExp('[,;|\\s]$');
                                    tokenReplaceString = tokenReplaceString.replace(regex, '');
                                    tokenReplaceString = tokenReplaceString.replace(regexLastChar,'')
                                }
                            }
                        });
                        that.$input.val(tokenReplaceString);
                        that.refreshSelectedUserListDisplayAndHiddenInput();
                        if (selected.length) {
                            that.changes = {
                                added: selected[0],
                                pasted: selected
                            }; //do this so messages work as expected
                            that.messagesView.showResultMessages(that.changes);
                        }
                        if (data.limitExceeded) {
                            that.messagesView.toggleLimitMessage(true);
                        }
                    }
                });
        };

        protect.tokenMatchesOneUser = function(users, token) {
            var that = this;
            var matchedUsers = [];
            _.filter(users, function(user) {
                if (that.matchUserName(user, token)) {
                    matchedUsers.push(user);
                } else if (that.matchEmail(user, token)) {
                    matchedUsers.push(user);
                } else if (that.matchDisplayName(user, token)) {
                    matchedUsers.push(user);
                }
            });
            return matchedUsers;
        };

        protect.matchEmail = function(user, token) {
            return user.prop.matchType == 'email' && jive.util.equalsIgnoreCaseAndPadding(token, user.email);
        };

        protect.matchUserName = function(user, token) {
            return jive.util.equalsIgnoreCaseAndPadding(token, user.username);
        };

        protect.matchDisplayName = function(user, token) {
            return jive.util.equalsIgnoreCaseAndPadding(token, user.displayName);
        };

        protect.loadBrowseModal = function() {
			var that = this;
            that.options.closeFocusSelector = that.$browse;
			
			var srole = this.$input.attr("id");
            select_fieldType = srole;
            var $selObj = $j("input[name="+srole+"]");
            var $selectedUserID = 0;
            if($selObj!=undefined && $selObj!=null && $selObj.val()>0)
            {
                $selectedUserID = $j("input[name="+srole+"]").val();
            }
            $j.extend(that.options.defaultFilters, {selectedUserID:$selectedUserID});
			
            
            that.selectPeopleView
                .setOptions(that.options)
                .addListener('select' + that.options.name, function(payload) {
                    that.selectAction(payload);
                    that.$browse.focus();
                })
                .open();
            return false;
        };

        protect.loadPlaceBrowseModal = function() {
            var that = this;
            that.emit('browsePlace');
        };

        this.setCanInvitePartners = function(b) {
            this.options.canInvitePartners = b;
            this.refreshSelectedUserListDisplayAndHiddenInput();
        };

        this.setDisabled = function(b) {
            this.options.disabled = b;
            this.refreshSelectedUserListDisplayAndHiddenInput();
        };

        /**
         * hide the input box + the "select people" link
         */
        this.hide = function() {
            this.$input.hide();
            if (this.$browse) {
                this.$browse.hide();
            }
        };

        this.show = function() {
            if (!this.showNoPicker) {
                this.$input.show();
                if (this.$browse) {
                    this.$browse.css('display', 'inline-block');
                }
            } else {
                this.hide();
            }
        };

        this.setNoPicker = function(b) {
            console.log('setting user picker to be fake read only: ' + b);
            this.showNoPicker = b;
            this.show();
        };

        /**
         * results for the autocomplete ask
         * @param results
         */
        this.autocompleteResponse = function(results) {
			console.log("results " + JSON.stringify(results));
            var that = this;
            that.resultStore.storeResults(results);
            that.chooserView.render(results);
        };

        this.selectPlace = function(container) {
            var that = this;
            if (container && that.containsItem(that.excludedContainers, container)) {
                container.alreadyLinkedToPlace = true;
            }

            if (container && !that.containsItem(that.selectedContainers, container)) {
                that.selectedContainers.push(container);
                that.changes = {
                    added: [container]
                };

                that.emit('selectedUsersChanged', that.getSelectedUsersAndLists());
                that.refreshSelectedUserListDisplayAndHiddenInput();

                that.messagesView.showResultMessages(that.changes);
            }
        };

        protect.isValidEmailAddress = function(emailAddress) {
            //regex is reused from StringUtils#isValidEmailAddress but matches any domain
            return emailAddress.match('^([\\w\\.!#$%&*\\+/?\\^`{}\\|~_\'=-]+)@([\\w\\.-]+)\\.([\\w\\.-]+)$');
        };

        this.remove = function() {
            this.messagesView.hideResultMessages();
        };
    });

    return jive.UserPicker.View;	
	
});