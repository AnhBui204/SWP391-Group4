<%-- 
    Document   : charge
    Created on : Oct 13, 2024, 8:40:41 PM
    Author     : pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nạp Tiền Vào Tài Khoản</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #ffebcc;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .recharge-container {
            width: 400px;
            padding: 20px;
            background-color: #ffe0a1;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            color: #444;
        }

        select, input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .payment-options {
            display: flex;
            flex-direction: column;
            margin-bottom: 15px;
        }

        .payment-options label {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            cursor: pointer;
        }

        .payment-options input {
            margin-right: 10px;
        }

        .icon {
            width: 24px;
            height: 24px;
            margin-right: 10px;
        }

        .submit-btn {
            width: 100%;
            padding: 12px;
            background-color: #ff6b2c;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #ff4514;
        }

        #form{
            font-family:"FontAwesome";
            font-size:14px;
        }
        
        input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: border-color 0.3s;
        }

        input[type="number"]:focus {
            border-color: #007BFF;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

/*        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: border-color 0.3s;
        }

        input[type="text"]:focus {
            border-color: #007BFF;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }*/
        
    </style>
</head>
<body>
    <div class="recharge-container">
        <h1>Nạp Tiền Vào Tài Khoản</h1>
        <form action="vnpayajax" id="frmCreateOrder" method="post"><!--
-->            <label for="amount">Chọn số tiền cần nạp</label>
            <div name = "form" class="custom-select">
                <select id="amount" name="amount" required>
                    <option value="" disabled selected>-- Chọn số tiền --</option>
                    <option value="100000">100.000 VND</option>
                    <option value="200000">200.000 VND</option>
                    <option value="500000">500.000 VND</option>
                    <option value="1000000">1.000.000 VND</option>
                </select>
            </div>

<!--            <label for="amount">Nhập số tiền cần nạp</label>
            <input type="number" id="amount" name="amount" min="100000" step="100000" required placeholder="Nhập số tiền (tối thiểu 100.000 VND)">
            <input type="text" id="amount" name="amount" required placeholder="Nhập số tiền (tối thiểu 100.000 VND)">-->

            
            <button type="submit" class="submit-btn">Xác Nhận Nạp Tiền</button>
        </form>
    </div>
    
    
    
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
    <script type="text/javascript">
        $("#frmCreateOrder").submit(function () {
            var postData = $("#frmCreateOrder").serialize();
            var submitUrl = $("#frmCreateOrder").attr("action");
            $.ajax({
                type: "POST",
                url: submitUrl,
                data: postData,
                dataType: 'JSON',
                success: function (x) {
                    if (x.code === '00') {
                        if (window.vnpay) {
                            vnpay.open({width: 768, height: 600, url: x.data});
                        } else {
                            location.href = x.data;
                        }
                        return false;
                    } else {
                        alert(x.Message);
                    }
                }
            });
            return false;
        });
        
//        $(document).ready(function() {
//            $('#amount').on('input', function() {
//                var value = $(this).val().replace(/\D/g, ''); // Chỉ giữ lại số
//                if (value) {
//                    // Định dạng số
//                    var formattedValue = Number(value).toLocaleString('vi-VN') + ' VND';
//                    $(this).val(formattedValue);
//                } else {
//                    $(this).val('');
//                }
//            });
//        });

//        $(document).ready(function() {
//            $('#amount').on('input', function() {
//                // Lưu giá trị nhập vào
//                var input = $(this).val().replace(/\D/g, ''); // Chỉ giữ lại số
//                if (input) {
//                    // Định dạng số
//                    var formattedValue = Number(input).toLocaleString('vi-VN') + ' VND';
//                    $(this).val(formattedValue);
//                } else {
//                    $(this).val('');
//                }
//            });
//
//            // Xử lý khi gửi form
//            $('#frmCreateOrder').submit(function(event) {
//                var rawValue = $('#amount').val().replace(/ VND/, '').replace(/\./g, ''); // Xóa định dạng
//                $('#amount').val(rawValue); // Đặt lại giá trị cho form
//                if (parseInt(rawValue) < 100000) { // Kiểm tra giá trị tối thiểu
//                    alert("Số tiền tối thiểu là 100.000 VND!");
//                    event.preventDefault(); // Ngăn chặn gửi form nếu không hợp lệ
//                }
//            });
//        });


    </script>       
</body>
</html>
