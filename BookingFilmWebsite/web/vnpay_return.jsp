<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="com.vnpay.common.Config"%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="Model.*"%>

<%@page import="java.util.*"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kết Quả Thanh Toán</title>

        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                background-color: #ffebcc;
                font-family: 'Arial', sans-serif;
            }
            .container {
                max-width: 600px;
                margin-top: 50px;
                background-color: #ffe0a1;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 30px;
                border-radius: 8px;
            }
            h3 {
                color: #ff6600;
                font-weight: bold;
                text-align: center;
                margin-bottom: 30px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                font-weight: 600;
            }
            footer {
                text-align: center;
                margin-top: 20px;
                font-size: 14px;
                color: #6c757d;
            }
        </style>
    </head>
    <%
        if(session.getAttribute("user") != null){
    %>
    <body>
        <%
            // Begin process return from VNPAY
            Map<String, String> fields = new HashMap<>();
            for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode(params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if (fieldValue != null && !fieldValue.isEmpty()) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            fields.remove("vnp_SecureHashType");
            fields.remove("vnp_SecureHash");

            String signValue = Config.hashAllFields(fields);

            int amount = Integer.parseInt(request.getParameter("vnp_Amount")) / 100;
            NumberFormat currency = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            String money = currency.format(amount);

            String date = request.getParameter("vnp_PayDate");
            DateTimeFormatter input = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
            DateTimeFormatter output = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
            LocalDateTime ldt = LocalDateTime.parse(date, input);
            date = ldt.format(output);
        %>

        <div class="container">
            <h3>Kết Quả Thanh Toán</h3>

            <div class="table-responsive">
                <div class="form-group">
                    <label>Mã giao dịch thanh toán:</label>
                    <div><%=request.getParameter("vnp_TxnRef")%></div>
                </div>
                <div class="form-group">
                    <label>Số tiền:</label>
                    <div><%=money%></div>
                </div>
                <!--                <div class="form-group">
                                    <label>Mô tả giao dịch:</label>
                                    <div><%=request.getParameter("vnp_OrderInfo")%></div>
                                </div>-->
                <!--                <div class="form-group">
                                    <label>Mã lỗi thanh toán:</label>
                                    <div><%=request.getParameter("vnp_ResponseCode")%></div>
                                </div>-->
                <div class="form-group">
                    <label>Mã giao dịch tại VNPAY-QR:</label>
                    <div><%=request.getParameter("vnp_TransactionNo")%></div>
                </div>
                <!--                <div class="form-group">
                                    <label>Mã ngân hàng thanh toán:</label>
                                    <div><%=request.getParameter("vnp_BankCode")%></div>
                                </div>-->
                <div class="form-group">
                    <label>Thời gian thanh toán:</label>
                    <div><%=date%></div>
                </div>
                <div class="form-group">
                    <label>Tình trạng giao dịch:</label>
                    <label>
                        <%
                            if (signValue.equals(vnp_SecureHash)) {
                                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                                    String userID = (String)session.getAttribute("user");
                                    new UserDB().addMoneyToBalance(amount / 1000, userID);
                                    
                                    session.setAttribute("user", userID);
                                    out.print("Thành công"); 
                                } else {
                                    out.print("Không thành công");
                                }
                            } else {
                                out.print("Chữ ký không hợp lệ");
                            }
                        %>
                    </label>
                </div>
            </div>

        </div>
        <a href="HomePage.jsp" class="d-flex justify-content-center btn btn-warning">Trở về</a>
        <footer>
            <p>&copy; VNPAY 2024</p>
        </footer>
    </div>
    <%
        }
    %>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>