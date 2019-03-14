<html>
<head>

    <title><@s.text name="unauth.unauthorized.title"/></title>

    <meta name="nosidebar" content="true" />

</head>
<body class="jive-body-warn jive-body-unathorized">


<!-- BEGIN header & intro  -->
<div id="jive-body-intro">
    <div id="jive-body-intro-content">
        <h1><@s.text name="unauth.unauthorized.title"/></h1>
        <p><@s.text name="unauth.description.text"/>
        </p>
    </div>
</div>
<!-- END header & intro -->

<!-- BEGIN main body -->
<div id="jive-body-main">

    <!-- BEGIN main body column -->
    <div id="jive-body-maincol-container">
        <div id="jive-body-maincol">

        <br clear="all"/>

        <#include "/template/global/include/form-message.ftl" />

        <div id="jive-error-box" class="jive-error-box">
            <div>
                <#--<span class="jive-icon-med jive-icon-redalert"></span>-->
                Project has been Cancelled.
            </div>
        </div>

        </div>
    </div>
    <!-- END main body column -->


</div>
<!-- END main body -->


</body>
</html>