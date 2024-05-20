package kr.co.meetup.web.dao;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.co.meetup.web.vo.MeetingVO;

public class MeetingDAO {

	public SqlSessionFactory factory;
	
	public MeetingDAO() {
		try {
			// 설계도
			Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
			// 건설 노동자
			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
			// 공장
			factory = builder.build(r);
			// 설계도 닫기
			r.close();
		} catch (IOException e) {
			System.out.println("config.xml 파일을 찾을 수 없습니다!!");
			e.printStackTrace();
		}
	}
	
	// 모임의 정모 조회
	public List<MeetingVO> selectAll(int crewNo) {
		
		
		return null;
	}
}
