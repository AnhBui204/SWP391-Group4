<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.VoucherDB" %>
<%@ page import="Model.Voucher" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Voucher</title>
   
</head>
<body>
    <main>
        <header style="padding: 0px; align-items: center;">
            <div class="text-left" style="padding: 0px;">
                        <a href="uudai_homepage.jsp" class="btn" style="font-size: 1.5em;">Tin Khuyến Mãi</a>
                    </div>
<!--                        <a href="Promotion.jsp" class="btn btn-primary">Danh sách</a>-->
                </header>
        <section>
            <% 
                List<Voucher> listvc = VoucherDB.getAllVouchers();
                for(Voucher vc : listvc){
            %>
            <div class="product">
                <picture>
                    <img src="<%= vc.getImgPath() %>" alt="Voucher Image">
                </picture>
                <div class="detail">
                    <p>
                        <b><%= vc.getVoucherName() %></b><br>
                    </p>
                </div>
            </div>
            <% } %>
        </section>
    </main>
</body>
</html>
