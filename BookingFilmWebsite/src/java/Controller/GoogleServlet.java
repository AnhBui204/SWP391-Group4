//package Controller;
//
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import stackjava.com.accessgoogle.common.GooglePojo;
//import stackjava.com.accessgoogle.common.GoogleUtils;
//
//@WebServlet("/login-google")
//public class GoogleServlet extends HttpServlet {
//  private static final long serialVersionUID = 1L;
//  public GoogleServlet() {
//    super();
//  }
//  protected void doGet(HttpServletRequest request, HttpServletResponse response)
//      throws ServletException, IOException {
//    String code = request.getParameter("code");
//    if (code == null || code.isEmpty()) {
//      RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
//      dis.forward(request, response);
//    } else {
//      String accessToken = GoogleUtils.getToken(code);
//      GooglePojo googlePojo = GoogleUtils.getUserInfo(accessToken);
//      request.setAttribute("id", googlePojo.getId());
//      request.setAttribute("name", googlePojo.getName());
//      request.setAttribute("email", googlePojo.getEmail());
//      RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
//      dis.forward(request, response);
//    }
//  }
//  protected void doPost(HttpServletRequest request, HttpServletResponse response)
//      throws ServletException, IOException {
//    doGet(request, response);
//  }
//}