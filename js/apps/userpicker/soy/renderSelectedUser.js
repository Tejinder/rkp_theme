// This file was automatically generated from renderSelectedUser.soy.
// Please don't edit this file by hand.

goog.provide('jive.UserPicker.soy.renderSelectedUser');

goog.require('soy');
goog.require('soydata');
goog.require('soy.StringBuilder');
goog.require('jive.UserPicker.soy.renderedContainer');
goog.require('jive.shared.displayutil.avatar');


jive.UserPicker.soy.renderSelectedUser = function(opt_data, opt_sb) {
  
  var output = opt_sb || new soy.StringBuilder();
  if (opt_data.results.users.length > 0) {
    output.append('<ul class="jive-chooser-list j-people-list clearfix">');
    var userList6 = opt_data.results.users;
    var userListLen6 = userList6.length;
    for (var userIndex6 = 0; userIndex6 < userListLen6; userIndex6++) {
      var userData6 = userList6[userIndex6];
      if (userIndex6 == 0) {
        output.append('<li style="display: list-item;" class="assignee', (userData6.disabled) ? ' disabled' : '', (! userData6.entitled) ? ' notEntitled ' : '', '" data-user-id="', soy.$$escapeHtml(userData6.id), '" data-user-email="', soy.$$escapeHtml(userData6.email), '" data-user-name="', soy.$$escapeHtml(userData6.username), '">');
        if (! userData6.anonymous && ! userData6.external) {
          jive.shared.displayutil.avatar(soy.$$augmentMap(userData6, {size: 20, hideLink: true}), output);
        } else {
          output.append('<span class="jive-icon-glyph icon-envelope"></span>');			
        }
        output.append('<span>', soy.$$escapeHtml(userData6.displayName), '</span>', (! userData6.anonymous && ! userData6.external) ? (userData6.prop.isVisibleToPartner || userData6.prop.isPartner) ? '<span class="jive-icon-med jive-icon-partner" title="' + soy.$$escapeHtml(jive.i18n.i18nText(jive.i18n.getMsg('k2760'),[])) + '"></span>' : '' : '', (! opt_data.disabled) ? '<em><a class="remove" href="javascript:;" style="display: inline;" title="' + soy.$$escapeHtml(jive.i18n.i18nText(jive.i18n.getMsg('k418a'),[])) + ' ' + soy.$$escapeHtml(userData6.displayName) + '"><span class="jive-icon-glyph icon-close2"></span></a></em>' : '', '</li>');
		
      }
    }
    output.append('</ul>');
  } else if (opt_data.results.containers.length > 0) {
    var containerList51 = opt_data.results.containers;
    var containerListLen51 = containerList51.length;
    for (var containerIndex51 = 0; containerIndex51 < containerListLen51; containerIndex51++) {
      var containerData51 = containerList51[containerIndex51];
      if (containerIndex51 == 0) {
        jive.UserPicker.soy.renderedContainer(soy.$$augmentMap(opt_data, {container: containerData51}), output);
      }
    }
  }
  return opt_sb ? '' : output.toString();
};


jive.UserPicker.soy.renderCustomUserDisplayName = function(opt_data, opt_sb) {
  var username = ""; 
  if (opt_data.results.users.length > 0) {
      var userList6 = opt_data.results.users;
    var userListLen6 = userList6.length;
    for (var userIndex6 = 0; userIndex6 < userListLen6; userIndex6++) {
      var userData6 = userList6[userIndex6];
      if (userIndex6 == 0) {       
       username = soy.$$escapeHtml(userData6.displayName); 		
      }
    }   
  } 
  return username;
};