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
<body class="bodyy">
    <main>
        <header class="headerr">
            <h1>TIN KHUYẾN MÃI</h1>
        </header>
        <section class="sectionn">
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
