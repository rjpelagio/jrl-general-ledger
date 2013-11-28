

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
                                    <label for="party"><g:message code="employee.party.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'fullName', 'errors')}">
                                    <g:textField name="name" value="${employeeData?.fullName}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="personalTitle"><g:message code="employee.personalTitle.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'personalTitle', 'errors')}">
                                    <select id="personalTitle" name="personalTitle">
                                        <option value="Ms">Ms</option>
                                        <option value="Mr">Mr</option>
                                        <option value="Mrs">Mrs</option>
                                        <option value="Dr">Dr</option>
                                        <option value="Eng">Eng</option>
                                    </select>
                                </td>
                            </tr>                            

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="firstName"><g:message code="employee.firstName.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" value="${employeeData?.firstName}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="middleName"><g:message code="employee.middleName.label" default="Middle Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'middleName', 'errors')}">
                                    <g:textField name="middleName" value="${employeeData?.middleName}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastName"><g:message code="employee.lastName.label" default="Last Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'lastName', 'errors')}">
                                    <g:textField name="lastName" value="${employeeData?.lastName}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="Birthdate"><g:message code="employee.birthdate.label" default="Birthdate" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'birthdate', 'errors')}">
                                    <calendar:datePicker name="birthdate" precision="day" value="${employeeData?.birthdate}"  />
                                </td>
                            </tr>                            

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="gender"><g:message code="employee.gender.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'gender', 'errors')}">
                                    <select name="gender" id="gender" value="${employeeData?.gender}">
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                </td>
                            </tr>   

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="maritalStatus"><g:message code="employee.maritalStatus.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'maritalStatus', 'errors')}">
                                    <select id="maritalStatus" name="maritalStatus">
                                        <option value="Single">Single</option>
                                        <option value="Married">Married</option>
                                        <option value="Divorced">Divorced</option>
                                        <option value="Separated">Separated</option>
                                        <option value="Widowed">Widowed</option>
                                    </select>
                                </td>
                            </tr>   

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tin"><g:message code="employee.tin.label" default="TIN" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'tin', 'errors')}">
                                    <g:textField name="tin" value="${employeeData?.tin}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="employee.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'department', 'errors')}">
                                    <g:select name="department" from="${employeeData.constraints.department.inList}" value="${employeeInstance?.department}" valueMessagePrefix="employee.department"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="position"><g:message code="employee.position.label" default="Position" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeData, field: 'position', 'errors')}">
                                    <g:select name="position" from="${employeeData.constraints.position.inList}" value="${employeeInstance?.position}" valueMessagePrefix="employee.position"  />
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
