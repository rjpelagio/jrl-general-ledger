

<%@ page import="com.gl.GlAccount" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'glAccount.label', default: 'GlAccount')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="table-header">
              <g:message code="default.button.search.label" args="[entityName]" />
            </div>
            <g:form action="list">
                <div class="search">
                  <table>
                        <tbody>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="glAccount"><g:message code="glAccount.glAccount.label" default="GL Account Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: glAccountInstance, field: 'glAccount', 'errors')}">
                                    <g:textField name="glAccount" value="${glAccountInstance?.glAccount}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="glAccount.description.label" default="GL Account Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: glAccountInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${glAccountInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="glAccountType"><g:message code="glAccount.glAccountType.label" default="GL Account Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: glAccountInstance, field: 'glAccountType', 'errors')}">
                                    <g:select name="glAccountType.id" from="${com.gl.GlAccountType.list()}" optionKey="id" value="${glAccountInstance?.glAccountType?.id}" noSelection="['': '']" />
                                </td>
                            </tr>
                        
                            <tr>
                                <td></td>
                                <td>
                                    <g:submitButton name="search" class="save" value="Search" /></span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </g:form>
            <br/>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <!--th><g:message code="glAccount.parentGlAccount.label" default="Main GL Account" /></th-->
                        
                            <g:sortableColumn property="glAccount" title="${message(code: 'glAccount.glAccount.label', default: 'GL Account')}" />
                        
                            <th>GL Account Name</th>
                        
                            <th><g:message code="glAccount.glAccountType.label" default="Account Type" /></th>
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:if test = "${glAccountInstanceTotal==0}">
                        <tr>
                          <td colspan="5">No data available.</td>
                        </tr>
                    </g:if>
                    <g:else>
                      <g:each in="${glAccountInstanceList}" status="i" var="glAccountInstance">
                          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                              <!--td>${fieldValue(bean: glAccountInstance, field: "parentGlAccount")}</td-->
                              
                              <td><g:link action="show" id="${glAccountInstance.id}">${fieldValue(bean: glAccountInstance, field: "glAccount")}</g:link></td>

                              <td>${fieldValue(bean: glAccountInstance, field: "description")}</td>

                              <td>${fieldValue(bean: glAccountInstance, field: "glAccountType")}</td>

                              <td>
                                  <g:link action="edit" id="${glAccountInstance.id}">
                                      Edit
                                  </g:link>
                              </td>
                          </tr>
                      </g:each>
                    </g:else>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${glAccountInstanceTotal}" /> Record ${offset} of ${glAccountInstanceTotal} 
            </div>
            <g:jasperReport jasper="ChartOfAccounts" format="PDF, XLS" name="Chart of Accounts">
              <input type="hidden" name="USER" value="${session.user.id}"/>
              <input type="hidden" name="ORGCODE" value="${session.organization.id}"/>
            </g:jasperReport>
        </div>
    </body>
</html>
