<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%-- Header --%>
<jsp:include page="header.jsp"/>

<%-- Content --%>
<div class="block1">
    <form action="ServletEvents" method="post">
        <input type="text" name="action" value="${param['action']}" hidden>

        <table>
            <c:choose>
                <c:when test = "${param['action'] == 'update'}">
                    <sql:query var="result" dataSource="jdbc/db">
                        SELECT name,description,author FROM events where event_id = ${param['event_id']}
                    </sql:query>
                    <c:forEach items="${result.rows}" var="row">
                        <input type="text" name="event_id" value="${param['event_id']}" hidden>
                        <tr>
                            <td>Name:</td>
                            <td><input type='text' name='name' value="${row.name}"></td>
                        </tr>
                        <input type="text" name="author" value="${param['author']}" hidden>
                        <tr>
                            <td>Description:</td>
                            <td><input type='text' name='description' value="${row.description}"></td>
                        </tr>
                        <tr>
                        <tr>
                            <td><input type="submit" name="submitBtn" value="OK"></td>
                            <td></td>
                        </tr>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <tr>
                        <td>Name:</td>
                        <td><input type='text' name='name'></td>
                    </tr>
                    <tr>
                        <td>Description:</td>
                        <td><input type='text' name='description'></td>
                    </tr>
                        <input type='text' name='author' value="${param['author']}" hidden></td>
                    <tr>
                        <td><input type="submit" name="submitBtn" value="OK"></td>
                        <td></td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </table>
    </form>
</div>

<%-- Footer --%>
<jsp:include page="footer.jsp"/>
