package kr.co.meetup.web.dao;

import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.co.meetup.web.vo.CategoryBigVO;
import kr.co.meetup.web.vo.CategorySmallVO;
import kr.co.meetup.web.vo.CrewLikeVO;
import kr.co.meetup.web.vo.CrewMemberVO;
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
	public List<CrewVO> selectAllCrew(int startNo, int recordPerPage) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("startNo", startNo);
		map.put("recordPerPage", recordPerPage);
		List<CrewVO> list = ss.selectList("kr.co.meetup.crew.selectAllCrew", map);
		ss.close();
		return list;
	}
	
	// 카테고리 별 전체 모임 조회
	public List<CrewVO> selectAllCrewByCategory(int ctg, int startNo, int recordPerPage) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("ctg", ctg);
		map.put("startNo", startNo);
		map.put("recordPerPage", recordPerPage);
		List<CrewVO> list = ss.selectList("kr.co.meetup.crew.selectAllCrewByCategory", map);
		ss.close();
		return list;
	}
	
	// 지역 별 전체 모임 조회
	public List<CrewVO> selectAllCrewByGeo(int geoCode, int startNo, int recordPerPage) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("geoCode", geoCode);
		map.put("startNo", startNo);
		map.put("recordPerPage", recordPerPage);
		List<CrewVO> list = ss.selectList("kr.co.meetup.crew.selectAllCrewByGeo", map);
		ss.close();
		return list;
	}
	
	// 지역&카테고리 별 전체 모임 조회
	public List<CrewVO> selectAllCrewByGeoCategory(int geoCode, int ctg, int startNo, int recordPerPage) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("geoCode", geoCode);
		map.put("ctg", ctg);
		map.put("startNo", startNo);
		map.put("recordPerPage", recordPerPage);
		List<CrewVO> list = ss.selectList("kr.co.meetup.crew.selectAllCrewByGeoCategory", map);
		ss.close();
		return list;
	}
	
	// 사용자 별 전체 모임 조회
	public List<CrewVO> selectAllCrewByMember(int memberNo) {
		SqlSession ss = factory.openSession(true);
		List<CrewVO> list = ss.selectList("kr.co.meetup.crew.selectAllCrewByMember", memberNo);
		ss.close();
		return list;
	}
	
	// 사용자 별 짬한 모임 조회
	public List<CrewVO> selectAllCrewLikeByMember(int memberNo) {
		SqlSession ss = factory.openSession(true);
		List<CrewVO> list = ss.selectList("kr.co.meetup.crew.selectAllCrewLikeByMember", memberNo);
		ss.close();
		return list;
	}
	
	// 사용자 많은 순 별 모임 조회 
	public List<CrewVO> selectAllCrewOrderMember(int startNo, int recordPerPage) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("startNo", startNo);
		map.put("recordPerPage", recordPerPage);
		List<CrewVO> list = ss.selectList("kr.co.meetup.crew.selectAllCrewOrderMember", map);
		ss.close();
		return list;
	}
	
	// 사용자 많은 순 & 지역 별 모임 조회 
	public List<CrewVO> selectAllCrewOrderMemberByGeo(int geoCode, int startNo, int recordPerPage) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("geoCode", geoCode);
		map.put("startNo", startNo);
		map.put("recordPerPage", recordPerPage);
		List<CrewVO> list = ss.selectList("kr.co.meetup.crew.selectAllCrewOrderMemberByGeo", map);
		ss.close();
		return list;
	}
	
	// 한개 모임 조회
	public CrewVO selectOneCrew(int crewNo) {
		SqlSession ss = factory.openSession(true);
		CrewVO vo = ss.selectOne("kr.co.meetup.crew.selectOneCrew", crewNo);
		ss.close();
		return vo;
	}
	
	// 전체 모임회원 조회
	public List<CrewMemberVO> selectAllCrewMember(int crewNo) {
		SqlSession ss = factory.openSession(true);
		List<CrewMemberVO> list = ss.selectList("kr.co.meetup.crew.selectAllCrewMember", crewNo);
		ss.close();
		return list;
	}
	
	// 한개 모임회원 조회
	public CrewMemberVO selectCrewMemberByCrewNoMemberNo(int crewNo, int memberNo) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("crewNo", crewNo);
		map.put("memberNo", memberNo);
		CrewMemberVO vo = ss.selectOne("kr.co.meetup.crew.selectCrewMemberByCrewNoMemberNo", map);
		ss.close();
		return vo;
	}
	
	// 모임 등록 
	public int addCrew(CrewVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.insert("kr.co.meetup.crew.addCrew", vo);
		ss.close();
		return vo.getCrewNo();
	}
	
	// 모임 수정 
	public void updateCrew(CrewVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.crew.updateCrew", vo);
		ss.close();
	}
	
	// 모임 삭제 
	public void deleteCrew(int crewNo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.crew.deleteCrew", crewNo);
		ss.close();
	}
	
	// 모임 회원 등록
	public void addCrewMember(CrewMemberVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.insert("kr.co.meetup.crew.addCrewMember", vo);
		ss.close();
	}
	
	// 모임 회원 수정 (권한)
	public void updateCrewMember(CrewMemberVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.crew.updateCrewMember", vo);
		ss.close();
	}
	
	// 모임장 수정
	public void updateCrewMemberLeader(int crewNo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.crew.updateCrewMemberLeader", crewNo);
		ss.close();
	}
	
	// 모임 퇴장
	public void deleteCrewMember(int crewNo, int memberNo) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("crewNo", crewNo);
		map.put("memberNo", memberNo);
		ss.delete("kr.co.meetup.crew.deleteCrewMember", map);
		ss.close();
	}
	
	// 모임 회원 수 수정 (+1 / -1)
	public void updateCrewAttend(int crewNo, int no) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("crewNo", crewNo);
		map.put("no", no);
		ss.update("kr.co.meetup.crew.updateCrewAttend", map);
	}

	// 전체 모임 수 조회
	public int selectAllCrewCnt() {
		SqlSession ss = factory.openSession(true);
		int cnt = ss.selectOne("kr.co.meetup.crew.selectCrewCnt");
		ss.close();
		return cnt;
	}
	
	// 카테고리 별 전체 모임 수 조회
	public int selectAllCrewCntByCategory(int categoryBigNo) {
		SqlSession ss = factory.openSession(true);
		int cnt = ss.selectOne("kr.co.meetup.crew.selectAllCrewCntByCategory", categoryBigNo);
		ss.close();
		return cnt;
	}
	
	// 지역 별 전체 모임 수 조회
	public int selectAllCrewCntByGeo(int geoCode) {
		SqlSession ss = factory.openSession(true);
		int cnt = ss.selectOne("kr.co.meetup.crew.selectAllCrewCntByGeo", geoCode);
		ss.close();
		return cnt;
	}
	
	// 지역 & 카테고리 별 전체 모임 수 조회
	public int selectAllCrewCntByGeoCategory(int geoCode, int categoryBigNo) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("geoCode", geoCode);
		map.put("categoryBigNo", categoryBigNo);
		int cnt = ss.selectOne("kr.co.meetup.crew.selectAllCrewCntByGeoCategory", map);
		ss.close();
		return cnt;
	}
	
	// 찜 여부 조회
	public int selectCrewLikeCntByMemberNo(int crewNo, int memberNo) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("crewNo", crewNo);
		map.put("memberNo", memberNo);
		int cnt = ss.selectOne("kr.co.meetup.crew.selectCrewLikeByMemberNo", map);
		return cnt;
	}
	
	// 찜 등록
	public void addCrewLike(CrewLikeVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.insert("kr.co.meetup.crew.addCrewLike", vo);
		ss.close();
	}
	
	// 찜 삭제
	public void deleteCrewLike(CrewLikeVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.delete("kr.co.meetup.crew.deleteCrewLike", vo);
		ss.close();
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
	
}
