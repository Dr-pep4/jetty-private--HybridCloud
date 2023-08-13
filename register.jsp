<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>final_sign_up</title>
    <style>
        body {
    margin: 0;
    padding: 0;
    background-size: cover;
    background-repeat: no-repeat;
  }
        #wrap {
            margin: 0 auto;
            width: 85%;
            height: 600px;}
        #wrap>p{
            display:flex;
            border:1px solid black;
            justify-content:space-between;
        }

        h1{
            text-align: center;
        }
        #search_section{
            justify-content: space-around;
            width:80%;
            display: flex;
        }
        table {
    width: 500px;
    border-collapse: collapse;
    background-color: rgba(255, 255, 255, 0.8);
  }
  th, td {
    height:30px;
    padding: 5px;
    text-align: center;
  }

  .left-column {
    width: 10%;
  }
  .right-column {
    width: 90%;
  }
    #btn{
        width:500px;
        height:30px;
    }
    </style>
</head>
<body>
    <header>
        <h1>Join The Redffle!</h1>
    </header>
    <hr>
    <div id="wrap">
  <form method="post" action="/register">
    <input type="hidden" name="gift" id="gift" value="${param.id}">
    <table>
      <tr>
        <td class="left-column"><label for="user_email">email:</label></th>
        <td class="right-column"><input style="width:40%" type="text" id="first_email" name="first_email" required>@<input style="width:40%" type="text" id="last_email" name="last_email" required></th>
      </tr>
      <tr>
        <td class="left-column"> <label for="password">password:</label></td>
        <td class="right-column">  <input style="width: 90%" type="password" id="user_password" name="user_password" required></td>
      </tr>
      <tr>
        <td class="left-column"><label for="text">name:</label></td>
        <td class="right-column"><input style="width:90%" type="text" id="user_name" name="user_name" required></td>
      </tr>
      <tr>
        <td class="left-column"><label for="text">address:</label></td>
        <td class="right-column"><input type="text" style="width:90%" id="user_name" name="user_name" required></td>
      </tr>
      <tr>
        <td class="left-column"><label for="password">phone:</label></td>
        <td class="right-column"><input style="width:10%" type="text" value="010" readonly id="first_phone" name="first_phone" required>-<input type="text" style="width:30%"id="mid_phone" name="mid_phone" required>-<input type="text" style="width:30%" id="last_phone" name="last_phone" required></td>
      </tr>
    </table>
    <input type="submit" value="회원가입" id="btn">
  </form>
    </div>
    <%
    String user_password = request.getParameter("user_password");
    
    String user_name = request.getParameter("user_name");
    String user_address = request.getParameter("user_address");

    String first_email = request.getParameter("first_email");
    String last_email = request.getParameter("last_email");
    String user_email = first_email+"@"+last_email;


    String first_phone = request.getParameter("first_phone");
    String mid_phone = request.getParameter("mid_phone");
    String last_phone = request.getParameter("last_phone");
    String user_phone = first_phone+"-"+mid_phone+"-"+last_phone;

    String gift = request.getParameter("gift");
    %>
        <%@ page import="java.sql.*" %>
        <%@ page import="javax.naming.*" %>
        <%@ page import="javax.sql.*" %>
<%
if (request.getMethod().equals("POST")) {
String url = "jdbc:mysql://team2-db.coccer63gd4o.ap-northeast-1.rds.amazonaws.com:3306/schema1";
String dbUsername = "admin";
String dbPassword = "qwer1234";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

    try {
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(url, dbUsername, dbPassword);

      String checkQuery = "SELECT COUNT(*) FROM user WHERE user_email = ?";
            pstmt = conn.prepareStatement(checkQuery);
            pstmt.setString(1, user_email);
            rs = pstmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                // ID already exists, display an error message or redirect to a duplicate ID error page
                out.println("<script>alert('이미 추첨함ㅋ 욕심이 많으시네요~');</script>");
            } else {
                // Insert new user record
                String insertQuery = "INSERT INTO user (user_email, user_password, user_phone, user_name, user_address, pick) VALUES (?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(insertQuery);
                pstmt.setString(1, user_email);
                pstmt.setString(2, user_password);
                pstmt.setString(3, user_phone);
                pstmt.setString(4, user_name);
                pstmt.setString(5, user_address);
                pstmt.setString(6, gift);

                
                int insertResult = pstmt.executeUpdate();
               
                if (insertResult > 0) {
                    // 회원가입 성공한 경우에만 count 증가 처리
                    String updateCountQuery = "UPDATE table1 SET count = count + 1 WHERE ID = ?";
                    PreparedStatement updateCountPstmt = conn.prepareStatement(updateCountQuery);
                    updateCountPstmt.setString(1, gift);
                    updateCountPstmt.executeUpdate();

                    out.println("<script>alert('추첨 완료');</script>");
                    out.println("<script>window.location.href='/main';</script>");
                }
            }

    } catch (Exception e) {
out.println("<script>alert('예외 발생: " + e.getMessage() + "');</script>");
      e.printStackTrace();
    } finally {
      if (rs != null) {
        try { rs.close(); } catch (SQLException e) { }
      }
      if (pstmt != null) {
        try { pstmt.close(); } catch (SQLException e) { }
      }
      if (conn != null) {
        try { conn.close(); } catch (SQLException e) { }
             }
        }
    }
  %>




</body>
<script>
    function applyBackgroundImage() {
    const screenHeight = window.innerHeight;
    const screenWidth = window.innerWidth;

    if ( screenWidth > screenHeight) {
      document.body.style.backgroundImage = 'url("https://images.pexels.com/photos/5767386/pexels-photo-5767386.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")';
    } else {
      document.body.style.backgroundImage = 'url("https://images.unsplash.com/photo-1607920592519-bab4d7db727d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80")';
    }
  }

  window.addEventListener('resize', applyBackgroundImage);
  window.addEventListener('load', applyBackgroundImage);
    function success(){
        window.location.href ="/admin_main";
    }

</script>
</html>
