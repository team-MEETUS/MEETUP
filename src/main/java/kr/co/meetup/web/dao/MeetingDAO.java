package kr.co.meetup.web.dao;

import java.io.IOException;
import java.io.Reader;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
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
	
	// 모임별 정모 조회
	public List<MeetingVO> selectAllMeetingByCrewNo(int crewNo, int startNo, int endNo) {
		SqlSession ss = factory.openSession(true);
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("crewNo", crewNo);
		map.put("startNo", startNo);
		map.put("endNo", endNo);
		
		List<MeetingVO> list = ss.selectList("kr.co.meetup.meeting.selectAllMeetingByCrewNo", map);
		
		ss.close();
		
		return list;
	}
	
	// 날짜별 정모 조회
	public List<MeetingVO> selectAllMeetingByDate(Timestamp meetingDate, int startNo, int endNo) {
		SqlSession ss = factory.openSession(true);
		
		String date = new SimpleDateFormat("yyyy-MM-dd").format(meetingDate);
		String dateStart = date + " 00:00:00";
		String dateEnd = date + " 23:59:59";
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("dateStart", dateStart);
		map.put("dateEnd", dateEnd);
		map.put("startNo", startNo);
		map.put("endNo", endNo);
		
		System.out.println(date);
		System.out.println(dateStart);
		System.out.println(dateEnd);
		
		List<MeetingVO> list = ss.selectList("kr.co.meetup.meeting.selectAllMeetingByDate", map);
		
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
	public void addMeetingMember (MeetingMemberVO vo) {
		SqlSession ss = factory.openSession(true);
		
		ss.insert("kr.co.meetup.meeting.addMeetingMember", vo);
		
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
	
	// 정모 멤버 삭제 (나가기)
	public void deleteMeetingMember (int meetingNo, int memberNo) {
		SqlSession ss = factory.openSession(true);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("meetingNo", meetingNo);
		map.put("memberNo", memberNo);
		
		ss.delete("kr.co.meetup.meeting.deleteMeetingMember", map);
		
		ss.close();
	}
}
