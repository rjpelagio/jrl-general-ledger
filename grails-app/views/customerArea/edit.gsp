

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
        <div class="body" style="width:75%">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${employeeData}">
            <div class="errors">
                <g:renderErrors bean="${employeeData}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="empId" value="${employeeData?.empId}" />
                <g:hiddenField name="version" value="${employeeData?.version}" />
                <g:hiddenField name="partyId" value="${employeeData?.partyId}"/>
                <g:hiddenField name="personId" value="${employeeData?.personId}"/>

                <g:hiddenField name="postalAddressId" value="${employeeData?.postalAddressId}"/>
                <g:hiddenField name="telInfoId" value="${employeeData?.telInfoId}"/>
                <g:hiddenField name="contactPerson" value="${employeeData?.contactPerson}"/>
                <g:hiddenField name="elecAddressId" value="${employeeData?.elecAddressId}"/>

                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td class="name" colspan="2">Personal Information</td>
                                <td class="name" colspan="2">Contact Information</td>
                            </tr>   
                            <tr class="prop">
                                <td valign="middle" class="sub">
                                    <label for="personalTitle"><g:message code="employeeData.personalTitle.label" default="First Name" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: employeeData, field: 'personalTitle', 'errors')}">
                                    <g:select name="personalTitle" from="${employeeData.constraints.personalTitle.inList}" 
                                        value="${employeeData?.personalTitle}"  />
                                </td>

                                <td valign="middle" class="sub">
                                    <label for="addressLine1"><g:message code="employeeData.addressLine1.label" /></label>
                                </td>

                                <td class="value ${hasErrors(bean: employeeData, field: 'addressLine1', 'errors')}">
                                    <g:textField name="addressLine1" value="${employeeData?.addressLine1}" size="55"/>
                                </td>
                            </tr>                            

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="firstName"><g:message code="employeeData.firstName.label" default="First Name" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: employeeData, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" value="${employeeData?.firstName}" />
                                </td>

                                <td valign="middle" class="sub">
                                    <label for="addressLine2"><g:message code="employeeData.addressLine2.label" /></label>
                                </td>

                                <td class="value ${hasErrors(bean: employeeData, field: 'addressLine2', 'errors')}">
                                    <g:textField name="addressLine2" value="${employeeData?.addressLine2}" size="55"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="middleName"><g:message code="employeeData.middleName.label" default="Middle Name" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: employeeData, field: 'middleName', 'errors')}">
                                    <g:textField name="middleName" value="${employeeData?.middleName}" />
                                </td>

                                <td valign="middle" class="sub">
                                    <label for="province"><g:message code="employeeData.city.label" /></label>
                                </td>
                                <td class="value ${hasErrors(bean: employeeData, field: 'city', 'errors')}">
                                    <g:textField name="city" value="${employeeData?.city}" size="25"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="lastName"><g:message code="employeeData.lastName.label" default="Last Name" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: employeeData, field: 'lastName', 'errors')}">
                                    <g:textField name="lastName" value="${employeeData?.lastName}" />
                                </td>

                                <td valign="middle" class="sub">
                                    <label for="province"><g:message code="employeeData.province.label" /></label>
                                </td>
                                <td class="value" >
                                    <g:textField class="${hasErrors(bean: employeeData, field: 'province', 'errors')}"
                                        name="province" value="${employeeData?.province}" size="15"/>

                                    <span class="sub">
                                         <label for="postalCode"><g:message code="employeeData.postalCode.label" /></label>
                                    </span> &nbsp; &nbsp;
                                    <span>
                                         <g:textField class="${hasErrors(bean: employeeData, field: 
                                         'postalCode', 'errors')}"
                                            name="postalCode" value="${employeeData?.postalCode}" size="12"/>
                                    </span>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="Birthdate"><g:message code="employeeData.birthdate.label" default="Birthdate" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: employeeData, field: 'birthdate', 'errors')}">
                                    <calendar:datePicker name="birthdate" precision="day" value="${employeeData?.birthdate}" years="1950, 2013"  />
                                </td>

                                <td valign="middle" class="sub">
                                    <label for="areaCode"><g:message code="employeeData.contactNumber.label" /></label>
                                </td>
                                <td class="value">
                                    ( <g:textField class="${hasErrors(bean: employeeData, field: 'areaCode', 'errors')}"
                                        name="areaCode" value="${employeeData?.areaCode}" size="5"/> )
                                    
                                    &nbsp; &ndash; &nbsp;

                                    <g:textField class="${hasErrors(bean: employeeData, field: 'contactNumber', 'errors')}"
                                        name="contactNumber" value="${employeeData?.contactNumber}" size="20"/>
                                    
                                    
                                </td>
                            </tr>                            

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="gender"><g:message code="employeeData.gender.label" default="First Name" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: employeeData, field: 'gender', 'errors')}">
                                    <g:select name="gender" from="${employeeData.constraints.gender.inList}" 
                                        value="${employeeData?.gender}"  />
                                </td>
                                <td  class="sub">
                                    <label for="mobileNumber"><g:message code="employeeData.mobileNumber.label"/></label>
                                </td>
                                <td class="value ${hasErrors(bean: employeeData, field: 'mobileNumber', 'errors')}">
                                    +63 &nbsp;<g:textField name="mobileNumber" value="${employeeData?.mobileNumber}" size="25"/>
                                </td>
                            </tr>   

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="maritalStatus"><g:message code="employeeData.maritalStatus.label" default="First Name" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: employeeData, field: 'maritalStatus', 'errors')}">
                                    <g:select name="maritalStatus" from="${employeeData.constraints.maritalStatus.inList}" 
                                        value="${employeeData?.maritalStatus}"  />
                                </td>
                                <td  class="sub">
                                    <label for="emailAddress"><g:message code="employeeData.emailAddress.label"/></label>
                                </td>
                                <td class="value ${hasErrors(bean: employeeData, field: 'emailAddress', 'errors')}">
                                    <g:textField name="emailAddress" value="${employeeData?.emailAddress}" size="25"/>
                                </td>
                            </tr>   

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="tin"><g:message code="employeeData.tin.label" default="TIN" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: employeeData, field: 'tin', 'errors')}">
                                    <g:textField name="tin" value="${employeeData?.tin}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="department"><g:message code="employeeData.department.label" default="Department" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: employeeData, field: 'department', 'errors')}">
                                    <g:select name="department" from="${employeeData.constraints.department.inList}" 
                                        value="${employeeData?.department}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="position"><g:message code="employeeData.position.label" default="Position" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: employeeData, field: 'position', 'errors')}">
                                    <g:select name="position" from="${employeeData.constraints.position.inList}" 
                                        value="${employeeData?.position}"  />
                                    
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="status"><g:message code="employeeData.status.label" default="Status" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: employeeData, field: 'Status', 'errors')}">
                                    <g:select name="status" from="${employeeData.constraints.status.inList}" 
                                        value="${employeeData?.status}"  />
                                    
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
