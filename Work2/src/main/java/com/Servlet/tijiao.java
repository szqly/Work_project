package com.Servlet;

import com.Class.School;
import com.Class.Student;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Reader;

public class tijiao extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String id=req.getParameter("id");
        String name= req.getParameter("Name");
        String Hours=req.getParameter("Hours");
        String schoolname=req.getParameter("schoolname");
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
        Student student = new Student();
        student.setHours(Integer.parseInt(Hours));
        student.setName(name);
        student.setSid(school.getId());
        student.setId(Integer.parseInt(id));
        session1.update("Stupdate",student);
        System.out.println(student);
        session1.commit();
        req.getRequestDispatcher("index.jsp").forward(req,resp);
    }
}
