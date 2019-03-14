<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/grail-macros.ftl" />
<#include "/template/global/include/error-macros.ftl" />
<head xmlns="http://www.w3.org/1999/html">
    <script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>
</head>


<div class="grail grail-main-container">
<@grailTabs id=id activeTab=2 />
    <div class="research_content">
        <div class="grail-brief-template-container">
            <div class="grail_project_name_div ">
            <#if (grailBriefTemplate?? && grailBriefTemplate.id??)>
                <h2>${generateGrailProjectCode(grailBriefTemplate.id)}</h2>
            <#else>
                <h2>Upload Reports</h2>
            </#if>
            </div>
            <div class="pib_content">
                <div class="left">
                    <div class="project_details">
                        <form action="<@s.url value='/grail/documents!execute.jspa?id=${id}'/>" method="post" name="form-create" id="form-create" class="grail-pib" enctype="multipart/form-data">
                            <div class="region-inner">
                                <label class="label">Comments</label>
                                <textarea id="comments" name="comments" rows="10" cols="20" placeholder="Please provide comments, if any"  <#if !canEditProject>readonly</#if>><#if grailBriefTemplate?? && grailBriefTemplate.comments??>${grailBriefTemplate.comments}</#if></textarea>
                            </div>
                            <div id="grail-attachments" class="region-inner">
                                <div class="form-textarea_div">
                                <@grailDocumentAttachements attachments=attachments canAttach=canAttach maxAttachCount=30 attachmentCount=attachmentCount  />
                                </div>
                            </div>

                            <div class="buttons">
                            <#if canEditProject>
                                <a id="project_publish_link" href="javascript:void(0);" class="publish-details">SAVE</a>
                            </#if>
                            </div>

                            <input type="hidden" name="id" value=${id}>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $j(document).ready(function(){
        $j("#project_publish_link").click(function(){
            $j("#form-create").submit();
        });
    });
</script>


