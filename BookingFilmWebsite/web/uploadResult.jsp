<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>User Profile</title></head>
<body>
<h1>User Profile</h1>
<p>${avatarPath}</p>
<c:if test="${!empty avatarPath}">
    <img src="${user}" alt="User Avatar" />
</c:if>
<c:if test="${empty avatarPath}">
    <p>No image found for this user.</p>
</c:if>
</body>

</html>
