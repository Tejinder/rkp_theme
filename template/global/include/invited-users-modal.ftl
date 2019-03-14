<#if invitedUsers?? && invitedUsers?size &gt; 0>
<table class="invited-users-table">
    <thead>
      <th></th>
      <th></th>
      <th>Users Already Requested</th>
      <th>Requested by</th>
      <th></th>
    </thead>
    <tbody>
        <#list invitedUsers as invitedUser>
        <tr <#if (invitedUser_index % 2) == 0> class="last"</#if>>
            <td class="invite-user-cell-checkbox"><input type="radio" name="invitedUser" value="${invitedUser.email}" onclick="setSelectedInvitedUser(this)"></td>
            <td class="invite-user-cell-avatar">
            <#--<#if invitedUser.invitedBy?? && invitedUser.invitedBy &gt; 0>-->
            <#--<#assign usr = jiveContext.getSpringBean("userManager").getUser(invitedUser.invitedBy)/>-->
            <#--<@userAvatar user=usr size=22 useLinks=false />-->
            <#--<#else>-->
                <img class="jive-avatar"  src="${themePath}/images/avatar-22.png" border="0" height="22" data-height="22" width="22">
            <#--</#if>-->
            </td>
            <td class="invite-user-cell-email"><span>${invitedUser.email}</span></td>
            <td class="invite-user-cell-user">
                <#if invitedUser.invitedBy?? && invitedUser.invitedBy &gt; 0>
                    <span>${jiveContext.getSpringBean("userManager").getUser(invitedUser.invitedBy).getEmail()}</span><
                <#else>
                    <span>-----</span>
                </#if>
            </td>

            <td class="invite-user-cell-link"><a href="javascript:void(0);" onclick="javascript:sendRemainder('${invitedUser.email}', ${user.ID?c}, <#if projectID??>${projectID?c}<#else>-1</#if>, <#if stageId??>${stageId?c}<#else>0</#if>)">Send Reminder</a></td>
        </tr>
        </#list>
    </tbody>
</table>
<script type="text/javascript">
    function setSelectedInvitedUser(target) {
        setInviteField($j(target).val());
        closeAllPopups();
    }
    var lastPageNum = 0;
    var currentPage,totalPages;
    function updatePagination() {
        $j("#invited-users-pagination").html('');
        totalPages = Number(${pages});
        currentPage = Number(${page});
        var pageNumVisibleLimit = 5;
        var startNum = 1;
        var endNum = (totalPages > pageNumVisibleLimit)?pageNumVisibleLimit:totalPages;
        var showStartNum = false;
        var showEndNum = false;
        if(totalPages > 0) {
            if(totalPages > pageNumVisibleLimit) {
                showEndNum = true;
                 if(currentPage > (pageNumVisibleLimit - 2)) {
                     showStartNum = true;
                     endNum = (currentPage + 2) > totalPages?totalPages:(currentPage + 2);
                     startNum = endNum - (pageNumVisibleLimit - 1);
                     showEndNum = endNum >= totalPages?false:true;
                 } else {
                     showStartNum = false;
                 }
            }
            var pagesDiv = $j('<div id="invited-users-pages" class="invited-users-pages"></div>');
            if(showStartNum) {
                $j('<a href="#" class="pagenum" style="text-decoration: none" onclick="javascript:pageNumClick(1)">1..</a>').appendTo($j(pagesDiv));
            }

            for(var p = startNum; p <= endNum; p++) {
                if(p == currentPage) {
                    $j('<a href="#" class="pagenum active" style="text-decoration: none" onclick="javascript:pageNumClick('+p+')">'+p+'</a>').appendTo($j(pagesDiv));
                } else {
                    $j('<a href="#" class="pagenum" style="text-decoration: none" onclick="javascript:pageNumClick('+p+')">'+p+'</a>').appendTo($j(pagesDiv));
                }

            }

            if(showEndNum) {
                $j('<a href="#" class="pagenum" style="text-decoration: none" onclick="javascript:pageNumClick('+totalPages+')">..'+totalPages+'</a>').appendTo($j(pagesDiv));
            }
            $j(pagesDiv).appendTo($j("#invited-users-pagination"));

            var pageNavDiv = $j("<div id='invited-users-pages-navigation' class='invited-users-pages-navigation'>");
            var prevNav = currentPage == 1?$j('<a href="#" title="Click to go to the previous page" class="pagination-prev disabled">Previous</a>'):$j('<a href="#" title="Click to go to the previous page" class="pagination-prev" onclick="prevNavClick()">Previous</a>');
            $j(prevNav).appendTo($j(pageNavDiv));
            var nextNav = currentPage == totalPages?$j('<a href="#" title="Click to go to the next page" class="pagination-next disabled">Next</a>'):$j('<a href="#" title="Click to go to the next page" class="pagination-next" onclick="nextNavClick()">Next</a>');
            $j(nextNav).appendTo($j(pageNavDiv));
            $j(pageNavDiv).appendTo($j("#invited-users-pagination"))

        }
    }

    function nextNavClick() {
        if(totalPages > 0 && currentPage < totalPages) {
            pageNumClick(currentPage + 1);
        }
    }

    function prevNavClick() {
        if(currentPage > 1) {
            pageNumClick(currentPage - 1);
        }
    }

    function pageNumClick(num) {
        processPaginationRequest(num, $j.trim($j("#invite-user-search-box").val()));
    }
</script>
<#else>
<div class="no-content">
    <p>Requested users are not found</p>
</div>
</#if>

