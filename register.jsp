<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>
    <h2>Register</h2>
    <form action="registerUser.jsp" method="POST">
        Username: <input type="text" name="username" required /> <br/><br/>
        Password: <input type="password" name="password" required /> <br/><br/>
        Email: <input type="email" name="email" required /> <br/><br/>
        First Name: <input type="text" name="fname" required /> <br/><br/>
        Last Name: <input type="text" name="name" required /> <br/><br/>
        <input type="submit" value="Register" />
    </form>
</body>
</html>