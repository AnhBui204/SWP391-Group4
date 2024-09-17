        <%
            String user = (String) session.getAttribute("user");
            if (user == null) { %>
        <%@include file="includes/header.jsp" %>
        <% } else { %>
        <%@include file="includes/header_user.jsp" %>
        <% } %>
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