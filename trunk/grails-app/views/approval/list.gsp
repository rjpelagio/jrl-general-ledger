

<%@ page import="com.app.Approval" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'approval.label', default: 'Approval')}" />
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
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="approval.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="description" value="${approvalInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="approval.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: approvalInstance, field: 'department', 'errors')}">
                                    <g:select name="department" from="${approvalInstance.constraints.department.inList}" value="${approvalInstance?.department}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="approvalFeature"><g:message code="approval.approvalFeature.label" default="Approval Feature" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: approvalInstance, field: 'approvalFeature', 'errors')}">
                                    <g:select name="approvalFeature" from="${approvalInstance.constraints.approvalFeature.inList}" value="${approvalInstance?.approvalFeature}"  />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'approval.id.label', default: 'Id')}" />
                        
                            <th>Description</th>
                        
                            <th>Department</th>
                        
                            <th>Approval Feature</th>
                        
                            <th>Active</th>
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${approvalInstanceList}" status="i" var="approvalInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${approvalInstance.id}">${fieldValue(bean: approvalInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: approvalInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: approvalInstance, field: "department")}</td>
                        
                            <td>${fieldValue(bean: approvalInstance, field: "approvalFeature")}</td>
                        
                            <td>${fieldValue(bean: approvalInstance, field: "active")}</td>
                        
                            <td>
                                <g:link action="edit" id="${approvalInstance.id}">
                                    Edit
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${approvalInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
