package com.Servlet;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import com.Class.User;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.Reader;
import java.util.Objects;

public class Login extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if(Objects.equals(username, "") || Objects.equals(password, "")){
            request.setAttribute("a","2");
            request.getRequestDispatcher("").forward(request,response);
        }
        String dbprocess = "connect.xml";
        Reader reader = null;
        try{
            reader = Resources.getResourceAsReader(dbprocess);
        }catch (Exception e){
            e.printStackTrace();
        }
        SqlSessionFactory sql = new SqlSessionFactoryBuilder().build(reader);
        SqlSession sqlsession = sql.openSession();
        User user = sqlsession.selectOne("UfindByname",username);
        if(user==null){
            System.out.println("用户不存在");
            request.setAttribute("a","0");
            request.getRequestDispatcher("").forward(request,response);
        }else if(password.equals(user.getPsd())){
            System.out.println("登录成功");
            request.setAttribute("username",username);
            HttpSession session = request.getSession();
            session.setAttribute("username",username);
            ServletConfig config = getServletConfig();
            ServletContext context = config.getServletContext();
            context.setAttribute("name",username);
//            request.getRequestDispatcher("/JSP/main.jsp").forward(request,response);
            response.sendRedirect("http://localhost:9999/Work_war_exploded//JSP/main.jsp");
        } else{
            System.out.println("密码错误");
            request.setAttribute("a","-1");
            request.getRequestDispatcher("").forward(request,response);
        }
        sqlsession.close();
    }
}
