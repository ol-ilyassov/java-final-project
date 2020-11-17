<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%-- Header --%>
<jsp:include page="header.jsp"/>

<%-- Content --%>
<div class="block1">
    <p>Status of Last Action:</p><br>
    <p id="response">
        <c:choose>
            <c:when test = "${empty response}">
                - NO COMPLETED PROCESSES -
            </c:when>
            <c:when test = "${not empty response}">
                <c:out value="${response}"/>
            </c:when>
        </c:choose>
    </p><br>
    <%
        String role = " ";
        String userId = " ";
        Cookie[] cookies = null;
        cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie: cookies) {
                if (cookie.getName().equals("role")) {
                    role = cookie.getValue();
                }
                if (cookie.getName().equals("userId")) {
                    userId = cookie.getValue();
                }
            }
        }
        int number = Integer.parseInt(userId);
    %>
    <sql:query var="result2" dataSource="jdbc/db">
        SELECT * from students where student_id = <%=number%>
    </sql:query>
    <c:forEach items="${result2.rows}" var="row2">
        <a class="btnLink" href="eventsAdd.jsp?action=add&author=${row2.student_id}">Create Event</a><br>
    </c:forEach>

    <p>Events List</p><br>
    <input id="myInput1" type="text" placeholder="Search.."><br>
    <table>
        <tr>
            <th>ID: </th>
            <th>Name: </th>
            <th>Author: </th>
        </tr>
        <tbody id="myTable1">
        <c:forEach var="events" items="${eventsList}">
            <tr>
                <td>${events.event_id}</td>
                <td>${events.name}</td>
                <td>${events.author_id}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <table>
        <c:forEach var="sessionEvent" items="${eventSessionList}">
            <tr>
                <td>${sessionEvent.event_id}</td>
                <td>${sessionEvent.name}</td>
                <td>${sessionEvent.author_id}</td>
            </tr>
        </c:forEach>
    </table>
</div>

<script type="text/javascript">
    function deleteBook(taskId){
        $.ajax({
                url:"ServletEvents?event_id="+taskId,
                type: "DELETE",
            }
        )
            .done (function(data, textStatus, jqXHR) {
                $('#response').text("SUCCESS: Event was deleted.");
                $('#tr'+taskId).remove();
            })
            .fail (function(jqXHR, textStatus, errorThrown) {
                alert("Error "+textStatus+": "+errorThrown);
            })
    }

    $(document).ready(function(){
        $("#myInput1").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#myTable1 tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>

<%-- Footer --%>
<jsp:include page="footer.jsp"/>