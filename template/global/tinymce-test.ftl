<#--<link rel="stylesheet" type="text/css" href="${themePath}/js/jquery-easyui-1.4/themes/default/easyui.css">-->
<#--<link rel="stylesheet" type="text/css" href="${themePath}/js/jquery-easyui-1.4/themes/icon.css">-->
<#--<script type="text/javascript" src="${themePath}/js/jquery-easyui-1.4/jquery.easyui.min.js" ></script>-->
<script type="text/javascript" src="${themePath}/js/fixheadertable/jquery.fixheadertable.min.js" ></script>
<#--<#include "/template/decorator/default/header-javascript-rte.ftl" />-->
<style type="text/css">
    td[field=f5] {
        position: relative;
        left:200px;
    }
</style>
<script type="text/javascript">

    $j(document).ready(function(){
        $j('#data-table').fixheadertable({
            height:80
        });
//        $j('#data-table').datagrid({
////            frozenColumns:[
////                {field:'f1',width:100},
////                {field:'f2',width:100},
////                {field:'f3',width:100}
////            ],
//           data:[
//               {f1:'value11', f2:'value12',f3:'value13',f4:'value14',f5:'value15'},
//               {f1:'value21', f2:'value22', f3:'value23', f4:'value24', f5:'value22'}
//           ]
//        });
    });

//    tinymce.init({
//        mode : "specific_textareas",
//        selector: '#mytextarea',
//        theme: "modern",
//        menubar:false,
//
//        plugins: [
//            "autoresize"
//        ],
//        toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link forecolor backcolor",
////        toolbar2: "print preview media | forecolor backcolor emoticons",
////        toolbar2: "forecolor backcolor",
//        image_advtab: true,
//        contextmenu: "paste | link image inserttable | cell row column deletetable",
//        templates: [
//            {title: 'Test template 1', content: 'Test 1'},
//            {title: 'Test template 2', content: 'Test 2'}
//        ] ,
//        charLimit:500
//    });
        </script>

<div>
    <#--<table id="data-table" style="width:300px;">-->
        <#--<thead data-options="frozen:true">-->
        <#--<tr>-->
            <#--<th data-options="field:'f1',width:100">Column1</th>-->
            <#--<th data-options="field:'f2',width:100">Column2</th>-->
            <#--<th id="field-5" data-options="field:'f5',width:100,fixed:true">Column5</th>-->

         <#--</tr>-->

        <#--</thead>-->

        <#--<thead>-->
        <#--<tr>-->
            <#--<th data-options="field:'f3',width:100">Column3</th>-->
            <#--<th data-options="field:'f4',width:100">Column4</th>-->
        <#--</tr>-->
        <#--</thead>-->
        <#--&lt;#&ndash;<thead data-options="frozen:true">&ndash;&gt;-->
        <#--&lt;#&ndash;<tr>&ndash;&gt;-->
            <#--&lt;#&ndash;<th data-options="field:'f5'">Column5</th>&ndash;&gt;-->
        <#--&lt;#&ndash;</tr>&ndash;&gt;-->
        <#--&lt;#&ndash;</thead>&ndash;&gt;-->

    <#--</table>-->

        <table id="data-table">
            <thead>
            <tr>
                <th>Column1</th>
                <th>Column2</th>
                <th>Column3</th>
                <th>Column4</th>
                <th>Column5</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Column1 Row1 Value</td>
                <td>Column2 Row1 Value</td>
                <td>Column3 Row1 Value</td>
                <td>Column4 Row1 Value</td>
                <td>Column5 Row1 Value</td>
            </tr>
            <tr>
                <td>Column1 Row2 Value</td>
                <td>Column2 Row2 Value</td>
                <td>Column3 Row2 Value</td>
                <td>Column4 Row2 Value</td>
                <td>Column5 Row2 Value</td>
            </tr>
            <tr>
                <td>Column1 Row3 Value</td>
                <td>Column2 Row3 Value</td>
                <td>Column3 Row3 Value</td>
                <td>Column4 Row3 Value</td>
                <td>Column5 Row3 Value</td>
            </tr>
            <tr>
                <td>Column1 Row4 Value</td>
                <td>Column2 Row4 Value</td>
                <td>Column3 Row4 Value</td>
                <td>Column4 Row4 Value</td>
                <td>Column5 Row4 Value</td>
            </tr>
            <tr>
                <td>Column1 Row5 Value</td>
                <td>Column2 Row5 Value</td>
                <td>Column3 Row5 Value</td>
                <td>Column4 Row5 Value</td>
                <td>Column5 Row5 Value</td>
            </tr>
            </tbody>
        </table>
</div>