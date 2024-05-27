package kr.co.meetup.web.dao;

import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.co.meetup.web.vo.MeetingMemberVO;
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
	
	// 전체 게시물 수 (crewNo 조건)
	public int selectAllMeetingByCrewNoCnt(int crewNo) {
		SqlSession ss = factory.openSession(true);
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("crewNo", crewNo);
		
		int count = ss.selectOne("kr.co.meetup.meeting.selectAllMeetingByCrewNoCnt", map);
		
		ss.close();
		return count;
	}
	
	// 전체 게시물 수 (meetingDate 조건)
	public int selectAllMeetingByMeetingDateCnt(String date) {
		SqlSession ss = factory.openSession(true);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("date", date);
		
		int count = ss.selectOne("kr.co.meetup.meeting.selectAllMeetingByMeetingDateCnt", map);
		
		ss.close();
		return count;
	}
	
	// 모임별 정모 조회
	public List<MeetingVO> selectAllMeetingByCrewNo(int crewNo, int startNo, int recordPerPage) {
		SqlSession ss = factory.openSession(true);
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("crewNo", crewNo);
		map.put("startNo", startNo);
		map.put("recordPerPage", recordPerPage);
		System.out.println(map);
		
		List<MeetingVO> list = ss.selectList("kr.co.meetup.meeting.selectAllMeetingByCrewNo", map);
		System.out.println(list);
		ss.close();
		
		return list;
	}
	
	// 날짜별 정모 조회
	public List<MeetingVO> selectAllMeetingByDate(String date, int startNo, int recordPerPage) {
		SqlSession ss = factory.openSession(true);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("date", date);
		map.put("startNo", startNo);
		map.put("recordPerPage", recordPerPage);
		System.out.println(map);
		List<MeetingVO> list = ss.selectList("kr.co.meetup.meeting.selectAllMeetingByDate", map);
		
		System.out.println(list);
		
		ss.close();
		
		return list;
	}
	
	// 정모 모집 등록
	public void addMeeting(MeetingVO vo) {
		SqlSession ss = factory.openSession(true);
		
		ss.insert("kr.co.meetup.meeting.addMeeting", vo);
		
		ss.close();
	}
	
	// 정모 삭제 (update)
	public void deleteMeeting(int meetingNo) {
		SqlSession ss = factory.openSession(true);
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("meetingNo", meetingNo);
		
		ss.update("kr.co.meetup.meeting.deleteMeeting", map);
		
		ss.close();
	}
	
	// 정모 멤버 등록 (참여)
	public void addMeetingMember (int meetingNo, int memberNo) {
		SqlSession ss = factory.openSession(true);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("meetingNo", meetingNo);
		map.put("memberNo", memberNo);
		// 정모회원 테이블 추가
		ss.insert("kr.co.meetup.meeting.addMeetingMember", map);
		ss.commit();
		// 정모회원 테이블 조회
		int cnt = ss.selectOne("kr.co.meetup.meeting.selectMeetingMemberCnt",map);
		map.put("cnt", cnt);
		// 모임참석인원 update
		ss.update("kr.co.meetup.meeting.updateMeetingAttend", map);
		
		ss.close();
	}
	
	// 정모 멤버 삭제 (나가기)
	public void deleteMeetingMember (int meetingNo, int memberNo) {
		SqlSession ss = factory.openSession(true);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("meetingNo", meetingNo);
		map.put("memberNo", memberNo);
		
		ss.delete("kr.co.meetup.meeting.deleteMeetingMember", map);
		ss.commit();
		int cnt = ss.selectOne("kr.co.meetup.meeting.selectMeetingMemberCnt",map);
		map.put("cnt", cnt);
		ss.update("kr.co.meetup.meeting.updateMeetingAttend", map);
		ss.close();
	}
	
	// 정모 모집 마감 (update)
	public void updateMeeting(int meetingNo) {
		SqlSession ss = factory.openSession(true);
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("meetingNo", meetingNo);

		ss.update("kr.co.meetup.meeting.updateMeeting", map);
		
		ss.close();
	}
}
