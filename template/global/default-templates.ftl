<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<script src="${themePath}/js/jquery.loader.js" type="text/javascript"></script>

<div class="border-container">
    <div class="synchro-default-templates-container">
        <a class="back-link"  href="javascript:void(0);" onclick="javascript:window.history.back();">Go Back</a>
        <h2>Default Templates</h2>
        <ul>
        <#assign templateTypes = statics['com.grail.synchro.SynchroGlobal$DefaultTemplateType'].values()/>
        <#if templateTypes?? && templateTypes?has_content>
            <#list templateTypes as templateType>
                <li>
                    <span class="header">${templateType.getName()}</span>
                    <#if defaultTemplatesMap?? && defaultTemplatesMap.get(templateType.getId())??>
                        <#assign templates = defaultTemplatesMap.get(templateType.getId())/>
                        <#if templates?? && templates?has_content>
                            <#list templates as template>
                                <form name="delete" action="<@s.url value="default-templates!delete.jspa"/>" method="post" class="">
                                    <div class="content">
                                        <input type="hidden" name="templateType" value="${template.id}">
                                        <input type="hidden" name="attachmentId" value="${template.attachmentId}">
                                        <#if template.fileDownloadLink??>
                                            <a href="${template.fileDownloadLink}">${template.fileName}</a>
                                        <#else>
                                            <a href="#">${template.fileName}</a>
                                        </#if>

                                        <#if action.getAuthenticationProvider().isSystemAdmin()>
                                            <input type="submit" class="remove" value="">
                                        </#if>
                                    </div>
                                </form>


                            </#list>
                        </#if>
                    <#else>
                        <span class="empty-message">Templates not available</span>
                    </#if>

                    <#if action.getAuthenticationProvider().isSystemAdmin()>
                        <form name="upload" action="<@s.url value="default-templates!execute.jspa"/>" method="post" enctype="multipart/form-data" class="attach-form">
                            <input type="hidden" name="templateType" value="${templateType.getId()}">
                            <input type="file" name="attachFile" class="form-text">
                            <input type="submit" class="attach" value="Attach">
                        </form>

                    </#if>

                </li>
            </#list>
            <script type="text/javascript">
                $j(function(){
                   $j("form").submit(function(e){
                       var self = this;
                       e.preventDefault();
                       $j.loader({
                           className:"blue-with-image",
                           content: self.name == 'upload'?"Uploading...":"Please wait..."
                       });
                       self.submit();
                   })
                });
            </script>
        </#if>

        </ul>
    </div>
</div>



