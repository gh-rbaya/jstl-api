<%--
 Copyright 2003 Sun Microsystems, Inc. All rights reserved.
 SUN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%@ taglib prefix="tck" uri="http://java.sun.com/jstltck/jstltck-util" %>
<%@ page import="javax.sql.*, java.util.*" %>

<tck:test testName="positiveTxUpdateCommitTest">

   <%
      pageContext.setAttribute("key", new Integer("1"));
   %>
   <%-- Number of rows to be returned by the DML statements --%>
   <c:set var="expectedRowsAffected" value="${1}" />

  <!-- Validate sql:transaction and sql:update actions allows for the
            execution of a SQL statement and the correct number of rows is
            added to the table -->

   <h1>Validate sql:transaction and sql:update actions allows for the
       execution of a SQL statement and the correct number of rows is added to
       the table </h1>
   <p>

   <%-- Clear out our table prior to starting the test --%>
   <sql:update var="updateCount" dataSource="${applicationScope.jstlDS}">
       <c:out value="${sqlProps.Delete_AllRows_Query}" />
   </sql:update>

   <sql:transaction dataSource='<%=(DataSource) pageContext.getAttribute("jstlDS", PageContext.APPLICATION_SCOPE) %>' >
      <sql:update var="updateCount2"
                    sql='<%=((Properties)pageContext.getAttribute("sqlProps",PageContext.APPLICATION_SCOPE)).getProperty("Insert_Row_Query") %>' />
   </sql:transaction>

   <c:choose>
       <c:when test="${updateCount2 == expectedRowsAffected}">
        The SQL statement executed correctly and  returned the correct
        update count of <strong><c:out value="${expectedRowsAffected}" />
        </strong>.<p>
       </c:when>
       <c:otherwise>
          <strong>Error:</strong> The SQL statement "<strong>
          <c:out value="${sqlProps.Insert_Row_Query}" />
          </strong>" resulted in an update count of <strong>
          <c:out value="${updateCount2}" /></strong> and the
          the expected update count was <strong>
          <c:out value="${expectedRowsAffected}" /></strong>!<p>
       </c:otherwise>
   </c:choose>

   <!-- Validate that we had the correct number of rows added to our table -->
    <sql:query var="resultSet" dataSource="${applicationScope.jstlDS}"
              sql="${sqlProps.Select_Jstl_Tab2_AllRows_Query}" />

   <c:choose>
      <c:when test="${resultSet.rowCount != expectedRowsAffected}">
         <H2>ERROR:</H2>
         The query: <strong>
         "<c:out value="${sqlProps.Select_Jstl_Tab2_AllRows_Query}" />"
         </strong> returned <strong>"<c:out value="${resultSet.rowCount}" />"
         </strong> rows and the expected number of rows was
         <strong>"<c:out value="${expectedRowsAffected}" />"</strong>.
         <p>
      </c:when>
      <c:otherwise>
         The query did return a Result Object that contained
         <strong><c:out value="${expectedRowsAffected}" /></strong> rows.
         <p>
      </c:otherwise>
   </c:choose>

</tck:test>