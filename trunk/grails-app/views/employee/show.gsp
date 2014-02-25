
<%@ page import="com.app.EmployeeData" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name">Personal Information</td>
                            <td class="value"/>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="employeeData.fullName.label" default="Name" /></td>
                            <td valign="top" class="value">${employeeData?.lastName}, ${employeeData?.firstName} ${employeeData?.middleName}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="employeeData.gender.label" default="Gender" /></td>
                            <td valign="top" class="value">${employeeData?.gender}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="employeeData.birthdate.label" default="Date" /></td>
                            <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${employeeData?.birthdate}" /></td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="employeeData.maritalStatus.label" default="Date" /></td>
                            <td valign="top" class="value">${employeeData?.maritalStatus}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="party.tin.label" default="TIN" /></td>

                            <td valign="top" class="value" colspan="3">${employeeData?.tin}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="employee.department.label" default="Department" /></td>
                            
                            <td valign="top" class="value" colspan="3">${fieldValue(bean: employeeData, field: "department")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="employee.position.label" default="Position" /></td>
                            
                            <td valign="top" class="value" colspan="3">${fieldValue(bean: employeeData, field: "position")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${employeeData?.empId}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
