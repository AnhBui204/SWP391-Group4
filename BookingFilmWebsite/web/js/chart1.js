/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */



// Khai báo biến toàn cục myChart
var myChart;

// Lắng nghe sự kiện change trên select
document.getElementById('cinemaSelect').addEventListener('change', function() {
    var selectedCinema = this.value;

    // Dữ liệu khác nhau cho các rạp chiếu phim
    var cinemaData = {
        'Starlight Đà Nẵng': [2050, 1900, 2100, 2800, 1800, 2000, 2500, 2600, 2450, 1950, 2300, 2900],
        'Rio Đà Nẵng': [1500, 1600, 1700, 2200, 2100, 2400, 2600, 2500, 2700, 2400, 2900, 3100],
        'CGV Vĩnh Trung Plaza': [2500, 2700, 2300, 2000, 2200, 2100, 2400, 2600, 2700, 2800, 3000, 3200],
        'CGV Vincom Đà Nẵng': [1800, 1700, 1600, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800],
        'Lotte Đà Nẵng': [1300, 1200, 1400, 1500, 1700, 1600, 1800, 1900, 2000, 2100, 2200, 2300],
        'Galaxy Đà Nẵng': [900, 950, 1000, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000],
        'Metiz Cinema': [2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200, 3300],
        'IF Đà Nẵng': [1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200]
    };

    // Màu tương ứng cho các rạp
    var cinemaColors = {
        'Starlight Đà Nẵng': 'rgba(41, 155, 99, 1)',
        'Rio Đà Nẵng': 'rgba(54, 162, 235, 1)',
        'CGV Vĩnh Trung Plaza': 'rgba(255, 206, 86, 1)',
        'CGV Vincom Đà Nẵng': 'rgba(120, 46, 139, 1)',
        'Lotte Đà Nẵng': 'rgba(255, 99, 132, 1)',
        'Galaxy Đà Nẵng': 'rgba(153, 102, 255, 1)',
        'Metiz Cinema': 'rgba(255, 159, 64, 1)',
        'IF Đà Nẵng': 'rgba(75, 192, 192, 1)'
    };

    // Xóa biểu đồ hiện tại (nếu có)
    if (myChart) {
        myChart.destroy();
    }

    // Hiển thị biểu đồ với dữ liệu và màu sắc tương ứng
    var ctx = document.getElementById('lineChart').getContext('2d');
    myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                label: 'Earnings in $',
                data: cinemaData[selectedCinema], // Dữ liệu được thay đổi theo rạp được chọn
                backgroundColor: cinemaColors[selectedCinema], // Màu tương ứng cho rạp được chọn
                borderColor: cinemaColors[selectedCinema], // Đặt màu đường
                borderWidth: 2
            }]
        },
        options: {
            responsive: true
        }
    });
});

// Hiển thị biểu đồ mặc định khi tải trang
document.addEventListener('DOMContentLoaded', function() {
    var ctx = document.getElementById('lineChart').getContext('2d');
    myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                label: 'Earnings in $',
                data: [2050, 1900, 2100, 2800, 1800, 2000, 2500, 2600, 2450, 1950, 2300, 2900],
                backgroundColor: 'rgba(41, 155, 99, 1)', // Màu cho Starlight Đà Nẵng
                borderColor: 'rgba(41, 155, 99, 1)', // Đặt màu đường cho Starlight Đà Nẵng
                borderWidth: 2
            }]
        },
        options: {
            responsive: true
        }
    });
});

