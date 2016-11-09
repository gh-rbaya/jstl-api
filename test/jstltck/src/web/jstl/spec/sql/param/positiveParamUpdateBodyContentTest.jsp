<%--
 Copyright 2003 Sun Microsystems, Inc. All rights reserved.
 SUN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%@ taglib prefix="tck" uri="http://java.sun.com/jstltck/jstltck-util" %>
<%@ page import="javax.sql.*, java.util.*" %>

<tck:test testName="positiveParamUpdateBodyContentTest">

   <%
      pageContext.setAttribute("key", new Integer("1"));
   %>
   <%-- Number of rows to be affected by the DML statements --%>
   <c:set var="expectedRowsAffected" value="${1}" />

   <!-- Validate sql:update and sql:params actions allows for the
            execution of a SQL statement specifying parameters -->

   <h1>Validate  sql:update and sql:params actions allows for the
            execution of a SQL statement specifying parameters </h1>
   <p>
   <%-- Clear out our table prior to starting the test --%>
   <sql:update var="updateCount" dataSource="${applicationScope.jstlDS}">
       <c:out value="${sqlProps.Delete_AllRows_Query}" />
   </sql:update>

   <sql:update var="updateCount" dataSource="${applicationScope.jstlDS}">
       <c:out value="${sqlProps.Insert_Row_Query}" escapeXml='false'/>
   </sql:update>

   <sql:update var="updateCount2"
                  dataSource='<%=(DataSource) pageContext.getAttribute("jstlDS", PageContext.APPLICATION_SCOPE) %>' >
      <c:out value="${sqlProps.Delete_Jstl_Tab2_Using_Param_Query}" escapeXml='false' />
      <sql:param value='<%= pageContext.getAttribute("key") %>' />
   </sql:update>

   <c:choose>
       <c:when test="${updateCount2 == expectedRowsAffected}">
        The SQL statement executed correctly and  returned the correct
        update count of <strong><c:out value="${expectedRowsAffected}" />
        </strong>.<p>
       </c:when>
       <c:otherwise>
          <strong>Error:</strong> The SQL statement "<strong>
          <c:out value="${sqlProps.Delete_Jstl_Tab2_Using_Param_Query}" />
          </strong>" resulted in an update count of <strong>
          <c:out value="${updateCount2}" /></strong> and the
          the expected update count was <strong>
          <c:out value="${expectedRowsAffected}" /></strong>!<p>
       </c:otherwise>
   </c:choose>


</tck:test>