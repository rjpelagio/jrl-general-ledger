

<%@ page import="com.app.Employee" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${employeeData}">
            <div class="errors">
                <g:renderErrors bean="${employeeData}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="personalTitle"><g:message code="employeeData.personalTitle.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'personalTitle', 'errors')}">
                                    <g:select name="personalTitle" from="${employeeData.constraints.personalTitle.inList}" 
                                        value="${employeeData?.personalTitle}"  />
                                </td>
                            </tr>                            

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="firstName"><g:message code="employeeData.firstName.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" value="${employeeData?.firstName}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="middleName"><g:message code="employeeData.middleName.label" default="Middle Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'middleName', 'errors')}">
                                    <g:textField name="middleName" value="${employeeData?.middleName}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastName"><g:message code="employeeData.lastName.label" default="Last Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'lastName', 'errors')}">
                                    <g:textField name="lastName" value="${employeeData?.lastName}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="Birthdate"><g:message code="employeeData.birthdate.label" default="Birthdate" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'birthdate', 'errors')}">
                                    <calendar:datePicker name="birthdate" precision="day" value="${employeeData?.birthdate}" years="1950, 2013"  />
                                </td>
                            </tr>                            

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="gender"><g:message code="employeeData.gender.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'gender', 'errors')}">
                                    <g:select name="gender" from="${employeeData.constraints.gender.inList}" 
                                        value="${employeeData?.gender}"  />
                                </td>
                            </tr>   

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="maritalStatus"><g:message code="employeeData.maritalStatus.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'maritalStatus', 'errors')}">
                                    <g:select name="maritalStatus" from="${employeeData.constraints.maritalStatus.inList}" 
                                        value="${employeeData?.maritalStatus}"  />
                                </td>
                            </tr>   

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tin"><g:message code="employeeData.tin.label" default="TIN" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'tin', 'errors')}">
                                    <g:textField name="tin" value="${employeeData?.tin}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="employeeData.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'department', 'errors')}">
                                    <g:select name="department" from="${employeeData.constraints.department.inList}" 
                                        value="${employeeData?.department}"  />
                                </td>

                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="position"><g:message code="employeeData.position.label" default="Position" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'position', 'errors')}">
                                    <g:select name="position" from="${employeeData.constraints.position.inList}" 
                                        value="${employeeData?.position}"  />
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
