<%@ page import="java.io.Reader" %>
<%@ page import="org.apache.ibatis.io.Resources" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="com.Class.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="com.Class.School" %>
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
    var a="<%=request.getAttribute("panduan")%>";
    if(a ==="1"){
        alert('课程名已存在');
    }
</script>
<body>
<form action="http://localhost:9999/Work_war_exploded/adds" method="post" id="form0">
    <div class="box1">
        <table class="styletable">
            <tr>
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
            %>
            <tr>
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
<%--    <a id="add1" onclick="mysu();">添加</a>--%>
    <div id="box2">
        <div class="Title">
            新增课程
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
    </div>
    <input type="button" value="确定添加" onclick="adds();">
</form>
</body>
</html>