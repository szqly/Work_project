<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <script type="text/javascript">
        var login=function () {
            var form0=document.getElementById("form0");

            form0.submit();
        }
        var a='<%=(String)request.getAttribute("a")%>';
        if(a === "0"){
            alert("不存在该用户");
        }else if(a==="-1"){
            alert("密码错误")
        }else if(a==="2"){
            alert("不能为空")
        }

    </script>
    <style>
        body{
            background-image: url("img/dm6.png");
            background-repeat:no-repeat;
            background-size:100%;

        }
        form{
            width: 400px;
            height: 250px;

            background-color: #E1E9EF;

            opacity: 80%;

            text-align: center;

            padding: 120px 100px;

            font-size: 18px;

            border-radius: 10px;

            margin: 120px auto;
        }

        .textinput{
            height: 40px;
            width: 300px;

            padding: 0 35px;

            border: none;

            background: #F8F9F9;

            font-size: 15px;

            box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), inset 0px 2px 5px #aaaaaa;

            border-radius: 5px;

            color: saddlebrown;
        }

        input[type="submit"]{
            /* 设置宽高 */
            width: 110px;
            height: 40px;

            text-align: center;

            border-radius: 5px;

            font:16px "黑体";

            background-color: #C0C6CB;
        }
        a {
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<form action="http://localhost:9999/Work_war_exploded/Login" method="post" id="form0">
    <p>用户名</br>
        <input type="text" class="textinput" placeholder="请输入用户名" name="username" id="username"/>
    </p>
    <p>密码</br>
        <input type="password" class="textinput" placeholder="请输入密码" name="password" id="password"/>
    </p>
    <p>
        <input type="button" value="登录" onclick="login();"/>
    </p>
</form>
</body>
</html>