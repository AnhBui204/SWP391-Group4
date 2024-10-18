<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width= , initial-scale=1.0">
    <link rel="stylesheet" href="css/admins.css">
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    <title>Document</title>
</head>

<body>

    <div class="container">
        <aside>

            <div class="top">
                <div class="log">
                    <h2 class="primary">Cine<span class="danger">Luxe</span></h2>
                </div>
                <div class="close" id="close_btn">
                    <span class="material-symbols-outlined">
                        close
                    </span>
                </div>
            </div>
            <div class="sidebar">
                <a href="AdminDashBoard.jsp" class="active">
                    <span class="material-symbols-outlined">
                        grid_view
                    </span>
                    <h3>Dashboard</h3>
                </a>
                <a href="customer.jsp">
                    <span class="material-symbols-outlined">
                        person
                    </span>
                    <h3>Customer</h3>
                </a>
                <a href="cinema.jsp">
                    <span class="material-symbols-outlined">
                        movie
                    </span>
                    <h3>Theatre</h3>
                </a>
                <a href="ticket.jsp">
                    <span class="material-symbols-outlined">
                        local_activity
                    </span>
                    <h3>Ticket</h3>
                </a>
                <a href="UserServlet?action=logout">
                    <span class="material-symbols-outlined">
                        logout
                    </span>
                    <h3>Log out</h3>
                </a>
            </div>

        </aside>

        <main>
            <h1>Dashboard</h1>
            <div class="date">
                <input type="date">
            </div>

            <div class="insight">
                <div class="sales">
                    <span class="material-symbols-outlined">trending_up</span>
                    <h3>Total Sales</h3>
                    <div class="middle">
                        <h1>25,000</h1>
                        <div class="progress">
                            <svg>
                                <circle r="30" cy="40" cx="40"></circle>
                            </svg>
                            <div class="number">
                                80%
                            </div>
                        </div>
                    </div>
                    <small>Last 24 Hours</small>
                </div>


                <div class="expenses">
                    <span class="material-symbols-outlined">local_mall</span>
                    <h3>Total Expenses</h3>
                    <div class="middle">
                        <h1>25,000</h1>
                        <div class="progress">
                            <svg>
                                <circle r="30" cy="40" cx="40"></circle>
                            </svg>
                            <div class="number">
                                80%
                            </div>
                        </div>
                    </div>

                    <small>Last 24 Hours</small>
                </div>

                <div class="income">
                    <span class="material-symbols-outlined">stacked_line_chart</span>
                    <h3>Income</h3>
                    <div class="middle">
                        <h1>25,000</h1>
                        <div class="progress">
                            <svg>
                                <circle r="30" cy="40" cx="40"></circle>
                            </svg>
                            <div class="number">
                                80%
                            </div>
                        </div>
                    </div>
                    <small>Last 24 Hours</small>
                </div>
            </div>

            <div class="recent_order">
                <h1>Recent Order</h1>
                <table>
                    <thead>
                        <tr>
                            <th>Product Name</th>
                            <th>Product Number</th>
                            <th>Payment</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Mini USB</td>
                            <td>123</td>
                            <td>456</td>
                            <td class="warning">Pending</td>
                            <td class="primary">Detail</td>
                            <td class="success">Success</td>
                        </tr>
                        <tr>
                            <td>Mini USB</td>
                            <td>123</td>
                            <td>456</td>
                            <td class="warning">Pending</td>
                            <td class="primary">Detail</td>
                            <td class="success">Success</td>
                        </tr>
                        <tr>
                            <td>Mini USB</td>
                            <td>123</td>
                            <td>456</td>
                            <td class="warning">Pending</td>
                            <td class="primary">Detail</td>
                            <td class="success">Success</td>
                        </tr>
                        <tr>
                            <td>Mini USB</td>
                            <td>123</td>
                            <td>456</td>
                            <td class="warning">Pending</td>
                            <td class="primary">Detail</td>
                            <td class="success">Success</td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </main>

        <div class="right">
            <div class="top">
                <button id="menu_bar">
                    <span class="material-symbols-outlined">
                        menu
                    </span>
                </button>
                <div class="theme-toggler">
                    <span class="material-symbols-outlined active">light_mode</span>

                    <span class="material-symbols-outlined">dark_mode</span>

                </div>
                <div class="profile">
                    <div class="info">
                        <p><b>Babar</b></p>
                        <p>Admin</p>
                        <small class="text-muted"></small>
                    </div>
                    <div class="profile-photo">
                        <img src="image/logo/logo.png" alt="">
                    </div>
                </div>
            </div>

            <div class="recent_updates">
                <h2>Recent Update</h2>
                <div class="updates">
                    <div class="update">
                        <div class="profile-photo">
                            <img src="image/logo/logo.png" alt="">
                        </div>
                        <div class="message"><p><b>Babar</b> Recived his order</p></div>
                    </div>
    
                    <div class="update">
                        <div class="profile-photo">
                            <img src="image/logo/logo.png" alt="">
                        </div>
                        <div class="message"><p><b>Babar</b> Recived his order</p></div>
                    </div>
    
                    <div class="update">
                        <div class="profile-photo">
                            <img src="image/logo/logo.png" alt="">
                        </div>
                        <div class="message"><p><b>Babar</b> Recived his order</p></div>
                    </div>
                </div>

            </div>
            
            <div class="sales_analytics">
                <h2>Sales Analytics</h2>

                <div class="item onlion">
                    <div class="icon">
                        <span class="material-symbols-outlined">shopping_cart</span>
                    </div>
                    <div class="right_text">
                        <div class="info">
                            <h3>Onlion order</h3>
                            <small class="text-muted">Last seen 2 Hours</small>
                        </div>
                        <h5 class="danger">-17%</h5>
                        <h3>3849</h3>
                    </div>
                </div>

                <div class="item onlion">
                    <div class="icon">
                        <span class="material-symbols-outlined">shopping_cart</span>
                    </div>
                    <div class="right_text">
                        <div class="info">
                            <h3>Onlion order</h3>
                            <small class="text-muted">Last seen 2 Hours</small>
                        </div>
                        <h5 class="danger">-17%</h5>
                        <h3>3849</h3>
                    </div>
                </div>

                <div class="item onlion">
                    <div class="icon">
                        <span class="material-symbols-outlined">shopping_cart</span>
                    </div>
                    <div class="right_text">
                        <div class="info">
                            <h3>Onlion order</h3>
                            <small class="text-muted">Last seen 2 Hours</small>
                        </div>
                        <h5 class="danger">-17%</h5>
                        <h3>3849</h3>
                    </div>
                </div>
            </div>
            <div class="item add_products">
                <div>
                    <span class="material-symbols-outlined">add</span>
                </div>
            </div>
        </div>
        
    </div>

</body>
<script src="admin.js"></script>
</html>