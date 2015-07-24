
<%@ page import="com.app.Party" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'party.label', default: 'Party')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body" style="width:75%">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                        <tr class="prop">
                            <td class="name" colspan="2">Personal Information</td>
                            <td class="name" colspan="2">Contact Information</td>
                        </tr>
                    
                        <tr class="prop">
                            <td  class="sub"><g:message code="party.name.label"  /></td>
                            
                            <td  class="value">${payeeData?.fullName}</td>

                            <td class="sub" ><g:message code="employeeData.addressLine1.label"/></td>
                            
                            <td  class="value">${payeeData?.addressLine1}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td  class="sub"><g:message code="employeeData.firstName.label"  /></td>
                            
                            <td  class="value">${payeeData?.firstName}</td>

                            <td class="sub" ><g:message code="employeeData.addressLine2.label"/></td>
                            
                            <td  class="value">${payeeData?.addressLine2}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td  class="sub"><g:message code="employeeData.middleName.label"  /></td>
                            
                            <td  class="value">${payeeData?.middleName}</td>

                            <td class="sub" ><g:message code="employeeData.city.label"/></td>
                            
                            <td  class="value">${payeeData?.city}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td  class="sub"><g:message code="employeeData.lastName.label"  /></td>
                            
                            <td  class="value">${payeeData?.lastName}</td>
                            
                            <td  class="sub"><g:message code="employeeData.province.label" /></td>
                            
                            <td  class="value">${payeeData?.province}, ${payeeData?.postalCode}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td  class="sub"><g:message code="employeeData.birthdate.label"  /></td>
                            
                            <td  class="value">
                                <g:formatDate format="yyyy-MM-dd" date="${payeeData?.birthdate}" />
                            </td>

                            <td class="sub" ><g:message code="employeeData.contactNumber.label"/></td>
                            
                            <td  class="value">(${payeeData?.areaCode}) ${payeeData?.contactNumber}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td  class="sub"><g:message code="employeeData.gender.label"  /></td>
                            
                            <td  class="value">${payeeData?.gender}</td>

                            <td class="sub" ><g:message code="employeeData.mobileNumber.label"/></td>
                            
                            <td  class="value">(+63)${payeeData?.mobileNumber}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td  class="sub"><g:message code="employeeData.maritalStatus.label"  /></td>
                            
                            <td  class="value">${payeeData?.maritalStatus}</td>

                            <td class="sub" ><g:message code="employeeData.emailAddress.label"/></td>
                            
                            <td  class="value">${payeeData?.emailAddress}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td  class="sub"><g:message code="employeeData.tin.label"  /></td>
                            
                            <td  class="value">${payeeData?.tin}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td  class="sub"><g:message code="employeeData.role.label" /></td>
                            
                            <td  class="value">${payeeData?.role}</td>

                            <td class="sub" ><g:message code="employeeData.status.label"/></td>
                            
                            <td  class="value">${payeeData?.status}</td>
                            
                        </tr>
                
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${payeeData?.partyId}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
