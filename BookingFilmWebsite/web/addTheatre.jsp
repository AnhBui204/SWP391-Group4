<!DOCTYPE html>
<html>
    <head>
        <title>Add Theatre</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <style>
        /* Form container */
        body {
            background-color: #ffd08e;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 30px;
            background-color: #f7f7f7;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Form title */
        h2 {
            text-align: center;
            color: #333;
            font-size: 1.8rem;
            margin-bottom: 20px;
            font-weight: bold;
        }

        /* Form labels */
        label {
            font-size: 1rem;
            color: #555;
            font-weight: 500;
        }

        /* Form inputs */
        .form-control {
            font-size: 1rem;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-bottom: 15px;
            transition: border-color 0.3s ease-in-out;
        }

        /* Hover & focus effect on inputs */
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        /* Submit buttons */
        button[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            font-size: 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out;
            width: 100%;
        }

        /* Submit button hover effect */
        button[type="submit"]:hover {
            background-color: #0056b3;
        }

        /* Styling error/success messages */
        .alert {
            margin-top: 15px;
            padding: 10px;
            color: white;
            text-align: center;
            border-radius: 5px;
        }

        .alert-success {
            background-color: #28a745;
        }

        .alert-danger {
            background-color: #dc3545;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            h2 {
                font-size: 1.6rem;
            }

            .form-control {
                padding: 8px;
            }
        }

    </style>
    <body>
        <div class="container mt-5">
            <h2>Add New Theatre</h2>
            <form action="TheatreServlet?action=add" method="post">
                <div class="form-group">
                    <label for="name">Theatre Name:</label>
                    <input type="text" class="form-control" id="name" name="theatreName" required>
                </div>
                <div class="form-group">
                    <label for="location">Location:</label>
                    <input type="text" class="form-control" id="location" name="theatreLocation" required>
                </div>
                <button type="submit" class="btn btn-primary">Add Theatre</button>
            </form>
        </div>
    </body>
</html>
