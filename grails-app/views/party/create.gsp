

<%@ page import="com.app.Party" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'party.label', default: 'Party')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body" style="width:75%">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${payeeData}">
            <div class="errors">
                <g:renderErrors bean="${payeeData}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table border='1'>
                        <tbody>
                            <tr class="prop">
                                <td class="name" colspan="2">Personal Information</td>
                                <td class="name" colspan="2">Contact Information</td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="middle" class="sub">
                                    <label for="personalTitle"><g:message code="employeeData.personalTitle.label" default="First Name" /></label>
                                </td>
                                <td valign="middle" class="value ${hasErrors(bean: payeeData, field: 'personalTitle', 'errors')}">
                                    <g:select name="personalTitle" from="${payeeData.constraints.personalTitle.inList}" 
                                        value="${payeeData?.personalTitle}"  />
                                </td>

                                <td valign="middle" class="sub">
                                    <label for="addressLine1"><g:message code="employeeData.addressLine1.label" /></label>
                                </td>

                                <td class="value ${hasErrors(bean: payeeData, field: 'addressLine1', 'errors')}">
                                    <g:textField name="addressLine1" value="${payeeData?.addressLine1}" size="55"/>
                                </td>

                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="sub">
                                    <label for="firstName"><g:message code="employeeData.firstName.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: payeeData, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" value="${payeeData?.firstName}" />
                                </td>

                                <td valign="middle" class="sub">
                                    <label for="addressLine2"><g:message code="employeeData.addressLine2.label" /></label>
                                </td>

                                <td class="value ${hasErrors(bean: payeeData, field: 'addressLine2', 'errors')}">
                                    <g:textField name="addressLine2" value="${payeeData?.addressLine2}" size="55"/>
                                </td>

                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="sub">
                                    <label for="middleName"><g:message code="employeeData.middleName.label" default="Middle Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: payeeData, field: 'middleName', 'errors')}">
                                    <g:textField name="middleName" value="${payeeData?.middleName}" />
                                </td>
                                
                                <td valign="middle" class="sub">
                                    <label for="province"><g:message code="employeeData.city.label" /></label>
                                </td>
                                <td class="value ${hasErrors(bean: payeeData, field: 'city', 'errors')}">
                                    <g:textField name="city" value="${payeeData?.city}" size="25"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="sub">
                                    <label for="lastName"><g:message code="employeeData.lastName.label" default="Last Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: payeeData, field: 'lastName', 'errors')}">
                                    <g:textField name="lastName" value="${payeeData?.lastName}" />
                                </td>

                                <td valign="middle" class="sub">
                                    <label for="province"><g:message code="employeeData.province.label" /></label>
                                </td>
                                <td class="value" >
                                    <g:textField class="${hasErrors(bean: payeeData, field: 'province', 'errors')}"
                                        name="province" value="${payeeData?.province}" size="15"/>

                                    <span class="sub">
                                         <label for="postalCode"><g:message code="employeeData.postalCode.label" /></label>
                                    </span> &nbsp; &nbsp;
                                    <span>
                                         <g:textField class="${hasErrors(bean: payeeData, field: 
                                         'postalCode', 'errors')}"
                                            name="postalCode" value="${payeeData?.postalCode}" size="12"/>
                                    </span>
                                </td>
                            </tr>
                        
                             <tr class="prop">
                                <td valign="top" class="sub">
                                    <label for="Birthdate"><g:message code="employeeData.birthdate.label" default="Birthdate" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: payeeData, field: 'birthdate', 'errors')}">
                                    <calendar:datePicker name="birthdate" precision="day" value="${payeeData?.birthdate}" years="1950, 2013"  />
                                </td>

                                <td valign="middle" class="sub">
                                    <label for="areaCode"><g:message code="employeeData.contactNumber.label" /></label>
                                </td>
                                <td class="value">
                                    <g:textField class="${hasErrors(bean: payeeData, field: 'areaCode', 'errors')}"
                                        name="areaCode" value="${payeeData?.areaCode}" size="5"/>
                                    
                                    &nbsp; &ndash; &nbsp;

                                    <g:textField class="${hasErrors(bean: payeeData, field: 'contactNumber', 'errors')}"
                                        name="contactNumber" value="${payeeData?.contactNumber}" size="20"/>
                                    
                                    
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="sub">
                                    <label for="gender"><g:message code="employeeData.gender.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: payeeData, field: 'gender', 'errors')}">
                                    <g:select name="gender" from="${payeeData.constraints.gender.inList}" 
                                        value="${payeeData?.gender}"  />
                                </td>
                                <td valign="top" class="sub">
                                    <label for="mobileNumber"><g:message code="employeeData.mobileNumber.label"/></label>
                                </td>
                                <td class="value ${hasErrors(bean: payeeData, field: 'mobileNumber', 'errors')}">
                                    +63 &nbsp;<g:textField name="mobileNumber" value="${payeeData?.mobileNumber}" size="25"/>
                                </td>

                            </tr>   

                            <tr class="prop">
                                <td valign="top" class="sub">
                                    <label for="maritalStatus"><g:message code="employeeData.maritalStatus.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: payeeData, field: 'maritalStatus', 'errors')}">
                                    <g:select name="maritalStatus" from="${payeeData.constraints.maritalStatus.inList}" 
                                        value="${payeeData?.maritalStatus}"  />
                                </td>
                                <td valign="top" class="sub">
                                    <label for="emailAddress"><g:message code="employeeData.emailAddress.label"/></label>
                                </td>
                                <td class="value ${hasErrors(bean: payeeData, field: 'emailAddress', 'errors')}">
                                    <g:textField name="emailAddress" value="${payeeData?.emailAddress}" size="25"/>
                                </td>
                            </tr>   

                            <tr class="prop">
                                <td valign="top" class="sub">
                                    <label for="tin"><g:message code="employeeData.tin.label" default="TIN" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: payeeData, field: 'tin', 'errors')}">
                                    <g:textField name="tin" value="${payeeData?.tin}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="sub">
                                    <label for="role"><g:message code="employeeData.role.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: payeeData, field: 'role', 'errors')}">
                                    <g:select name="role" from="${payeeData.constraints.role.inList}" 
                                        value="${payeeData?.role}"  />
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
