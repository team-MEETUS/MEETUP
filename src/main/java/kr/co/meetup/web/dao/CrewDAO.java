package kr.co.meetup.web.dao;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.co.meetup.web.vo.CategoryBigVO;
import kr.co.meetup.web.vo.CategorySmallVO;
import kr.co.meetup.web.vo.CrewVO;
import kr.co.meetup.web.vo.GeoVO;


public class CrewDAO {
	public SqlSessionFactory factory;
	
	public CrewDAO() {
		try {
			// 설계도
			Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
			// 건설노동자 
			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
			// 공장
			factory = builder.build(r);
			// 설계도 자원 반납
			r.close();
		} catch (IOException e) {
			System.err.println("config.xml 파일을 찾을 수 없습니다.");
			e.printStackTrace();
		}
	}
	
	// 전체 모임 조회
	public List<CrewVO> selectAll() {
		SqlSession ss = factory.openSession(true);
		List<CrewVO> list = ss.selectList("kr.co.meetup.crew.selectAllCrew");
		ss.close();
		return list;
	}
	
	// 카테고리 별 전체 모임 조회
	public List<CrewVO> selectCrewByCategory(int ctg) {
		SqlSession ss = factory.openSession(true);
		List<CrewVO> list = ss.selectList("kr.co.meetup.crew.selectCrewByCategory", ctg);
		ss.close();
		return list;
	}
	
	// 전체 대 카테고리 조회
	public List<CategoryBigVO> selectAllCategoryBig() {
		SqlSession ss = factory.openSession(true);
		List<CategoryBigVO> list = ss.selectList("kr.co.meetup.crew.selectAllCategoryBig");
		ss.close();
		return list;
	}
	
	// 전체 소 카테고리 조회
	public List<CategorySmallVO> selectAllCategorySmall() {
		SqlSession ss = factory.openSession(true);
		List<CategorySmallVO> list = ss.selectList("kr.co.meetup.crew.selectAllCategorySmall");
		ss.close();
		return list;
	}
	
	// 전체 지역 조회
	public List<GeoVO> selectAllGeo() {
		SqlSession ss = factory.openSession(true);
		List<GeoVO> list = ss.selectList("kr.co.meetup.crew.selectAllGeo");
		ss.close();
		return list;
	}
	
	// 모임 등록 
	public void addCrew(CrewVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.insert("kr.co.meetup.crew.addCrew", vo);
		ss.close();
	}
	
	
}
