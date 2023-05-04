package com.Servlet;

import com.Class.School;
import com.Class.Student;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.Reader;

@WebServlet(name = "adds", value = "/adds")
public class adds extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name=request.getParameter("name");
        String hours=request.getParameter("hours");
        String schoolname=request.getParameter("schoolname");
        String resouce="connect.xml";
        Reader reader=null;
        try{
            reader= Resources.getResourceAsReader(resouce);
        }catch (Exception e){
            e.printStackTrace();
        }
        SqlSessionFactory sqlMap=new SqlSessionFactoryBuilder().build(reader);
        SqlSession session1 = sqlMap.openSession();
        School school=session1.selectOne("ScfindByname",schoolname);
        Student student1 = session1.selectOne("Stfindbyname",name);
//        System.out.println(student1);
        if(student1==null){
            Student student = new Student();
            student.setHours(Integer.parseInt(hours));
            student.setName(name);
            student.setSid(school.getId());
            session1.insert("Stinsert",student);
            session1.commit();
        }else{
            request.setAttribute("panduan","1");
        }
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }
}
