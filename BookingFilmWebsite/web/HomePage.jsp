<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
    // H�m ?? ?n th�ng b�o sau m?t kho?ng th?i gian
    function hideNotification() {
        const notification = document.getElementById("notification");
        if (notification) {
            setTimeout(() => {
                notification.style.display = 'none';
            }, 2000); // Th?i gian timeout l� 5000 milliseconds (5 gi�y)
        }
    }

    // G?i h�m khi trang ???c t?i
    window.onload = hideNotification;
</script>

<c:if test="${not empty sessionScope.successMessage}">
    <div id="notification" class="alert alert-success">
        ${sessionScope.successMessage}
    </div>
    <c:remove var="successMessage" scope="session" />
</c:if>

<c:if test="${not empty requestScope.errorMessage}">
    <div id="notification" class="alert alert-danger">
        ${requestScope.errorMessage}
    </div>
    <c:remove var="successMessage" scope="session" />
</c:if>




<%
    String user = (String) session.getAttribute("user");
    if (user == null) { %>
<%@include file="includes/header.jsp" %>
<% } else { %>
<%@include file="includes/header_user.jsp" %>
<% }%>
<%@include file="includes/headerBanner.jsp" %>


<%@include file="includes/body.jsp" %>
<%@include file="includes/voucher.jsp" %>
<%@include file="includes/footer.jsp" %>


<link rel="stylesheet" href="css/headers.css" />
<link rel="stylesheet" href="css/body.css" />
<link rel="stylesheet" href="css/voucher.css" />
<link rel="stylesheet" href="css/footer.css" />

<script src="js/jvs.js"></script>
<script src="js/voucher.js"></script>