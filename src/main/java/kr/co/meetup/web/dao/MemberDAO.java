package kr.co.meetup.web.dao;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.co.meetup.web.vo.MemberVO;

public class MemberDAO {
	private SqlSessionFactory factory;
	
	public MemberDAO() {
		try {
			Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
			factory = builder.build(r);
			r.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void addMember(MemberVO vo ) {
		SqlSession ss = factory.openSession(true);
		ss.insert("kr.co.meetup.member.addMember", vo);
		ss.close();
	}
}
