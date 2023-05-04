package com.Servlet;

//import jdk.internal.loader.Resource;
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

public class delete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String resouce="connect.xml";
        Reader reader=null;
        try{
            reader= Resources.getResourceAsReader(resouce);
        }catch (Exception e){
            e.printStackTrace();
        }
        SqlSessionFactory sqlMap=new SqlSessionFactoryBuilder().build(reader);
        SqlSession session1=sqlMap.openSession();
//        System.out.println(req.getParameter("id"));
        String id=req.getParameter("id");
        Student student=session1.selectOne("Stfindbyid",Integer.parseInt(id));
        session1.delete("StdeleteByid",Integer.parseInt(id));
        session1.delete("deleteImg",student.getName());
        session1.commit();
        req.getRequestDispatcher("index.jsp").forward(req,resp);
    }
}
