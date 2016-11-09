<%--
 Copyright 2003 Sun Microsystems, Inc. All rights reserved.
 SUN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%@ taglib prefix="tck" uri="http://java.sun.com/jstltck/jstltck-util" %>
<%@ page import="javax.sql.*, java.util.*" %>

<tck:test testName="positiveTxIsolationAttributeRead_UnCommittedTest">


   <%
        pageContext.setAttribute("isoLevel", new Integer(1), PageContext.APPLICATION_SCOPE);
   %>

   <c:set var='theIsolationLevel' value='read_uncommitted' />

   <!-- Validate sql:transaction action which specifies read_uncommitted for the
          isolation attribute  -->

   <h1>Validate sql:transaction action which specifies read_uncommitted for the
          isolation attribute </h1>
   <p>

   <sql:transaction dataSource='<%=(DataSource) pageContext.getAttribute("logDS", PageContext.APPLICATION_SCOPE) %>'
                       isolation='<%=(String) pageContext.getAttribute("theIsolationLevel", PageContext.PAGE_SCOPE) %>' >

      <sql:query var="resultSet2"
                    sql='<%=((Properties)pageContext.getAttribute("sqlProps",PageContext.APPLICATION_SCOPE)).getProperty("Select_Jstl_Tab1_OneRow_Query") %>' />
   </sql:transaction>


    <strong>Dump LifeCycle for sql:transaction action setting isolation attribute</strong>
    <p>
    <c:forEach var='entry' items='${applicationScope.connLog}'>
       <c:out value='${entry}' />
       <br>
   </c:forEach>

   <c:remove var='connLog' scope= 'application' />

</tck:test>