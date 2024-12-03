<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String fname = request.getParameter("fname");
    String name = request.getParameter("name");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to your MySQL database
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/TrainStations", "root", "databas3");

        // Check if username already exists
        String checkSql = "SELECT username FROM Customer WHERE username = ?";
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setString(1, username);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            out.println("<h3>Username already exists. Please choose another. <a href='register.jsp'>Try again.</a></h3>");
        } else {
            // Insert the new user into the database
            String sql = "INSERT INTO Customer (username, password, email, fname, name) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            pstmt.setString(3, email);
            pstmt.setString(4, fname);
            pstmt.setString(5, name);

            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                out.println("<h3>Registration successful! <a href='login.jsp'>Click here to login.</a></h3>");
            } else {
                out.println("<h3>Registration failed. Please try again.</h3>");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
