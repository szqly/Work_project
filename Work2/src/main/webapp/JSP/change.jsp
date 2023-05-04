<%@ page import="com.Class.Student" %>
<%@ page import="java.io.Reader" %>
<%@ page import="org.apache.ibatis.io.Resources" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSessionFactoryBuilder" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="com.Class.School" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Faith
  Date: 2023/3/30
  Time: 12:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>change</title>
</head>
<body>
<link rel="stylesheet" href="../Css/MyStyle.css">
<script type="text/javascript">
  var change=function (){
    var form0=document.getElementById("form0");
    form0.submit();
  }
</script>
<%
  Student student = (Student) request.getAttribute("changestudnt");
  String resources = "connect.xml";
  Reader reader = null;
  try {
    reader = Resources.getResourceAsReader(resources);
  } catch (IOException e) {
    e.printStackTrace();
  }
  SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
  SqlSession session1 = sqlMapper.openSession();
%>
<form action="http://localhost:9999/Work_war_exploded/tijiao" id="form0" method="post">
  <a style="text-align: center">序号</a>
  <input value="<%=student.getId()%>" id="id" name="id">
  <a style="text-align: center">课程名</a>
  <input type="text" value="<%=student.getName()%>" name="Name" id="Name"/>
  <a style="text-align: center">课时数</a>
  <input type="text" value="<%=student.getHours()%>" name="Hours" id="Hours"/>
  <a style="text-align: center">开课单位</a>
  <select size="1" name="schoolname" id="schoolname">
    <%
      List<School> schools=session1.selectList("Scfindall");
      for(School school:schools){
        int i =0;
    %>
    <option value="<%=school.getSchoolname()%>"><%=school.getSchoolname()%></option>
    <%
      }
    %>
  </select>
  <input type="button" value="提交" onclick="change();"/>
</form>
</body>
</html>
