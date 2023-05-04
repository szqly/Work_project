import com.hnust.s_school;
import com.hnust.s_student;
import org.junit.Test;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

public class MyTest {
    @Test
    public void Test(){
        String resources = "mybatis-config.xml";
        Reader reader = null;
        try {
            reader = Resources.getResourceAsReader(resources);
        } catch (IOException e) {
                e.printStackTrace();
        }
        SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
        SqlSession session = sqlMapper.openSession();
        s_student student =session.selectOne("StfindByid",2);
        System.out.println(student);
        s_school sSchool = session.selectOne("ScfindByname","计算机学院");
        List<s_student> sStudentList = session.selectList("StfindBysid",sSchool.getId());
        for(s_student ff:sStudentList){
            System.out.println(ff);
        }
        s_student pl = new s_student();
        pl.setHours(40);
        pl.setId(4);
        s_student student1 = session.selectOne("StfindByid",4);
        session.update("Stupdate",pl);
        student1 = session.selectOne("StfindByid",4);
        System.out.println(student1);
        s_student fs = new s_student();
        fs.setHours(32);
        fs.setName("大数据存储");
        fs.setSid(1);
        session.insert("Stinsert",fs);
        student1 = session.selectOne("StfindByid",11);
        System.out.println(student1);
        List<s_student> sStudentList1 = session.selectList("StfindAll");
        for(s_student ff:sStudentList1){
            System.out.println(ff);
        }
        session.commit();
    }
}
