package kr.co.meetup.web.dao;

import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import common.AES128;
import kr.co.meetup.web.vo.MemberVO;

public class MemberDAO {
	private SqlSessionFactory factory;
	// 암호화 key값
	private String key = "1234567890123456";
	
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
	// 회원가입 시 회원 추가
	public void addMember(MemberVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.insert("kr.co.meetup.member.addMember", vo);
		ss.close();
	}
	// 로그인 시 회원 정보 가져오기
	public MemberVO selectOneMemberByPhone(String phone, String pw) {
		SqlSession ss = factory.openSession(true);
		
		// DB와 비교를 위한 암호화
		AES128 aes = new AES128(key);
		phone = aes.encrypt(phone);
		pw = aes.encrypt(pw);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberPhone", phone);
		map.put("memberPw", pw);
		
		MemberVO vo = ss.selectOne("kr.co.meetup.member.selectOneMemberByPhone", map);
		ss.close();
		
		return vo;
	}
	// 회원가입 시 회원 중복 가입 방지
	public Integer selectMemberNoByPhone(String phone) {
		SqlSession ss = factory.openSession(true);
		
		AES128 aes = new AES128(key);
		phone = aes.encrypt(phone);
		
		Integer memberNo = ss.selectOne("kr.co.meetup.member.selectMemberNoByPhone", phone);
		ss.close();
		
		if (memberNo == null) {
			memberNo = -1;
		}
		
		return memberNo;
	}
	// 내 정보 회원 정보 업데이트
	public void updateOneMemberByMemberNo(MemberVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.member.updateOneMemberByMemberNo", vo);
		ss.close();
	}
	// 비밀번호 변경
	public void updateMemberPw(MemberVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.member.updateMemberPw", vo);
		ss.close();
	}
	// 회원탈퇴
	public void deleteOneMemberByMemberNo(int memberNo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.member.deleteOneMemberByMemberNo", memberNo);
		ss.close();
	}
	// 회원 번호로 정보 조회
	public MemberVO selectOneMemberByMemberNo(int memberNo) {
		SqlSession ss = factory.openSession(true);
		MemberVO vo = ss.selectOne("kr.co.meetup.member.selectOneMemberByMemberNo", memberNo);
		ss.close();
		
		return vo;
	}
}
