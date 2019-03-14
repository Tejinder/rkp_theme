<#import "/template/global/include/jive-form-elements.ftl" as jiveform/>
<#include "/template/global/include/synchro-macros.ftl" />
<#include "/template/global/include/kantar-macros.ftl" />
<#include "/template/global/include/error-macros.ftl" />
<head xmlns="http://www.w3.org/1999/html">
    <script type="text/javascript" src="${themePath}/js/synchro/tinymce.editor.custom.js"></script>
</head>


<div class="kantar kantar-main-container">
<@kantarTabs id=id activeTab=2 />
    <div class="research_content">
        <div class="grail-brief-template-container kantar">
            <div class="kantar_project_name_div ">
            <#if (kantarBriefTemplate?? && kantarBriefTemplate.id??)>
                <h2>${generateKantarProjectCode(kantarBriefTemplate.id)}</h2>
            <#else>
                <h2>Upload Reports</h2>
            </#if>
            </div>
            <div class="pib_content">
                <div class="left">
                    <div class="project_details">
                        <form action="<@s.url value='/kantar/documents!execute.jspa?id=${id}'/>" method="post" name="form-create" id="form-create" class="kantar-pib" enctype="multipart/form-data">
                            <div class="region-inner">
                                <label class="label">Comments</label>
                                <textarea id="comments" name="comments" rows="10" cols="20" placeholder="Please provide comments, if any"  <#if !canEditProject>readonly</#if>><#if kantarBriefTemplate?? && kantarBriefTemplate.comments??>${kantarBriefTemplate.comments}</#if></textarea>
                            </div>
                            <div id="kantar-attachments" class="region-inner">
                                <div class="form-textarea_div">
                                <@kantarDocumentAttachements attachments=attachments canAttach=canAttach maxAttachCount=30 attachmentCount=attachmentCount  />
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


