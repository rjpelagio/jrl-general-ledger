
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'glAccount.label', default: 'GlAccount')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body" style="width:45%">
            <h1>Summary of Sales and Invoices</h1>
            <g:form action="#" >
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td>Start Date</td>
                                <td>
                                    <calendar:datePicker name="startdate" precision="day" value="" years="1950, 2050"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td>End Date</td>
                                <td>
                                    <calendar:datePicker name="enddate" precision="day" value="" years="1950, 2050"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td>Customer Code</td>
                                <td>
                                    <input type="text" name="invoiceno">
                                </td>
                            </tr>
                            <tr>
                                <td>Report Type</td>
                                <td>
                                   <label for="sid">SID</label>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
