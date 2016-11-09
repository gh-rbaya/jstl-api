<%--
   Copyright 2003 Sun Microsystems, Inc.  All rights reserved.
   SUN PROPRIETARY/CONFIDENTIAL.  Use is subject license terms.
--%>

<%@ page contentType="text/plain" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${'substring' == fn:substringAfter('substring', null)}">
        Test PASSED
    </c:when>
    <c:otherwise>
        Test FAILED.  Expected fn:substringAfter('substring, null) to return
        'substring'.  Actual return value: ${fn:substringAfter('substring', null)}
    </c:otherwise>
</c:choose>