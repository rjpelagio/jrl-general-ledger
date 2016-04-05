
<%@ page import="com.gl.GlAccount" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'glAccount.label', default: 'GlAccount')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}"><g:message code="default.home.label"/></a></span>
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
                            <td  class="sub"><g:message code="glAccount.parentGlAccount.label" default="Main GL Account" /></td>

                            <td  class="value"><g:link controller="glAccount" action="show" id="${glAccountInstance?.parentGlAccount?.id}">${glAccountInstance?.parentGlAccount?.encodeAsHTML()}</g:link></td>

                        </tr>
                    
                        <tr class="prop">
                            <td  class="sub"><g:message code="glAccount.glAccount.label" default="GL Account" /></td>
                            
                            <td  class="value">${fieldValue(bean: glAccountInstance, field: "glAccount")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="sub"><g:message code="glAccount.description.label" default="Description" /></td>
                            
                            <td  class="value">${fieldValue(bean: glAccountInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="sub"><g:message code="glAccount.glAccountType.label" default="GL Account Type" /></td>
                            
                            <td  class="value">${glAccountInstance?.glAccountType?.encodeAsHTML()}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="sub"><g:message code="glAccount.dateCreated.label" default="Date Created" /></td>
                            
                            <td  class="value"><g:formatDate date="${glAccountInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="sub"><g:message code="glAccount.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td  class="value"><g:formatDate date="${glAccountInstance?.lastUpdated}" /></td>
                            
                        <tr class="prop">
                            <td  class="sub">
                              <label for="organization"><g:message code="glAccount.organization.label" default="Organization" /></label>
                            </td>

                            <td>
                                <ul>
                                  <g:each in="${organizationInstance?.organization?}" var="o">
                                      <li>${o?.encodeAsHTML()}</li>
                                  </g:each>
                            </ul>
                            </td>
                        </tr>
                        
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${glAccountInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
