<%@ page import="java.io.Reader" %>
<%@ page import="org.apache.ibatis.io.Resources" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="com.Class.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="com.Class.School" %>
<%@ page import="com.Class.Headimg" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Workspace</title>
</head>
<link rel="stylesheet" href="Css/MyStyle.css">
<script type="text/javascript">
    var adds=function (){
        var form0=document.getElementById("form0");
        form0.submit();
    }
    var upload=function (){
        var img=document.getElementById("img");
        img.submit();
    }
    var a="<%=request.getAttribute("panduan")%>";
    if(a ==="1"){
        alert('课程名已存在');
    }
    var b=<%=request.getAttribute("imgno")%>
    if(b!==null){
        <%
            session.setAttribute("imgno",request.getAttribute("imgno"));
        %>
    }
    var mysu=function (){
        var box2=document.getElementById("box2");
        var add=document.getElementById("add2");
        var img=document.getElementById("img");
        box2.style.display='block';
        img.style.display='block'
        add.style.display='none';
    }
    var closes=function (){
        var box2=document.getElementById("box2");
        var add=document.getElementById("add2");
        var img=document.getElementById("img");
        box2.style.display='none';
        img.style.display='none'
        add.style.display='block';
    }
</script>
<body>
<form action="http://localhost:9999/Work_war_exploded/adds" method="post" id="form0">
    <div class="box1">
        <table class="styletable">
            <tr>
                <td></td>
<%--                <td>序号</td>--%>
                <td>课程名</td>
                <td>课时数</td>
                <td>学院</td>
                <td></td>
                <td></td>
            </tr>
            <%
                String resources = "connect.xml";
                Reader reader = null;
                try {
                    reader = Resources.getResourceAsReader(resources);
                } catch (IOException e) {
                    e.printStackTrace();
                }
                SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
                SqlSession session1 = sqlMapper.openSession();
                List<Student>students=session1.selectList("Stfindall");
                for(Student student:students){
                    School school = session1.selectOne("ScfindByid", student.getSid());
                    Headimg headimg=session1.selectOne("Imgfindbyname",student.getName());
            %>
            <tr>
<%--                <%=(int)(12.0*Math.random()) + 1%>--%>
                <td style="overflow: hidden "><img height="50px" width="50px" class="img" src="img/<%=headimg.getImgNo()%>.png" alt="课程图标"></td>
<%--                <td id="<%=student.getId()%>"><%=student.getId()%></td>--%>
                <td id="<%=student.getName()%>"><%=student.getName()%></td>
                <td id="<%=student.getHours()%>"><%=student.getHours()%></td>
                <td id="<%=student.getSid()%>"><%=school.getSchoolname()%></td>
                <td><a href="http://localhost:9999/Work_war_exploded/delete?id=<%=student.getId()%>">删除</a></td>
                <td><a href="http://localhost:9999/Work_war_exploded/change?id=<%=student.getId()%>">修改</a></td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
    <input type="button" value="添加" name="add2" id="add2" onclick="mysu();">
    <div id="box2">
        <div class="Title">
            新增课程
            <a href="" id="close" onclick="closes();">关闭</a>
        </div>
        <a class="typea">课程名</a>
        <input type="text" id="name"name="name">
        <a class="typea">课时数</a>
        <input type="text" id="hours" name="hours">
        <select size="1" name="schoolname" id="schoolname">
        <%
            List<School>schools=session1.selectList("Scfindall");
            for(School school:schools){
        %>
            <option value="<%=school.getSchoolname()%>"><%=school.getSchoolname()%></option>
            <%
                }
            %>
        </select>
        <input type="button" value="确定添加" onclick="adds();">
    </div>
</form>
<form action="http://localhost:9999/Work_war_exploded/upload" name="img" method="post" id="img" enctype="multipart/form-data" target="frameName">
    <a class="typea">课程图片</a><br/>
    <input type="file" name="headimgs" id="headimgs" accept="image/*" onchange="testimg(this)"/>
    <img  height="50px" width="50px" class="img" name="headimg" id="headimg" src="">
    <script type="text/javascript">
        function testimg(source){
            var file=source.files[0];
            if(window.FileReader){
                var fr=new FileReader();
                fr.onloadend=function (e){
                    document.getElementById("headimg").src=e.target.result;
                };
                fr.readAsDataURL(file);
            }else{
                alert("浏览器不支持");
            }
        }
    </script>
    <br/>
    <input style="margin-left: 25px" type="button" value="上传" onclick="upload();">
</form>
<iframe src="" frameborder="0" name="frameName"></iframe>
</body>
</html>