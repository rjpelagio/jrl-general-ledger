

<%@ page import="com.app.Approval" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'approval.label', default: 'Approval')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${approvalInstance}">
            <div class="errors">
                <g:renderErrors bean="${approvalInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${approvalInstance?.id}" />
                <g:hiddenField name="version" value="${approvalInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="description"><g:message code="approval.description.label" default="Description" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: approvalInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${approvalInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="department"><g:message code="approval.department.label" default="Department" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: approvalInstance, field: 'department', 'errors')}">
                                    <g:select name="department" from="${approvalInstance.constraints.department.inList}" value="${approvalInstance?.department}" valueMessagePrefix="approval.department"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="approvalFeature"><g:message code="approval.approvalFeature.label" default="Approval Feature" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: approvalInstance, field: 'approvalFeature', 'errors')}">
                                    <g:select name="approvalFeature" from="${approvalInstance.constraints.approvalFeature.inList}" value="${approvalInstance?.approvalFeature}" valueMessagePrefix="approval.approvalFeature"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="active"><g:message code="approval.active.label" default="Active" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: approvalInstance, field: 'active', 'errors')}">
                                    <g:select name="active" from="${approvalInstance.constraints.active.inList}" value="${approvalInstance?.active}" valueMessagePrefix="approval.active"  />
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
