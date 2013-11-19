

<%@ page import="com.app.Employee" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${employeeInstance}">
            <div class="errors">
                <g:renderErrors bean="${employeeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${employeeInstance?.id}" />
                <g:hiddenField name="version" value="${employeeInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>

                          <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="party.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: partyInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${employeeInstance?.party?.name}" />
                                    <g:hiddenField name="party.id" value="${employeeInstance?.party?.id}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="firstName"><g:message code="party.firstName.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: partyInstance, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" value="${employeeInstance?.party?.firstName}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="middleName"><g:message code="party.middleName.label" default="Middle Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: partyInstance, field: 'middleName', 'errors')}">
                                    <g:textField name="middleName" value="${employeeInstance?.party?.middleName}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="lastName"><g:message code="party.lastName.label" default="Last Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: partyInstance, field: 'lastName', 'errors')}">
                                    <g:textField name="lastName" value="${employeeInstance?.party?.lastName}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tin"><g:message code="party.tin.label" default="TIN" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: partyInstance, field: 'tin', 'errors')}">
                                    <g:textField name="tin" value="${employeeInstance?.party?.tin}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="department"><g:message code="employee.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeInstance, field: 'department', 'errors')}">
                                    <g:select name="department" from="${employeeInstance.constraints.department.inList}" value="${employeeInstance?.department}" valueMessagePrefix="employee.department"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="position"><g:message code="employee.position.label" default="Position" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeInstance, field: 'position', 'errors')}">
                                    <g:select name="position" from="${employeeInstance.constraints.position.inList}" value="${employeeInstance?.position}" valueMessagePrefix="employee.position"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
