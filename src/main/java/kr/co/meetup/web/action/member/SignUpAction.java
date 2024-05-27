package kr.co.meetup.web.action.member;

import java.io.UnsupportedEncodingException;

import common.AES128;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.GeoDAO;
import kr.co.meetup.web.dao.MemberDAO;
import kr.co.meetup.web.vo.MemberVO;

public class SignUpAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		try {
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");
			
			// 암호화 key
			String key = "1234567890123456";
			AES128 aes = new AES128(key);
			
			String memberPhone = req.getParameter("memberPhone");
			// 핸드폰번호 암호화
			memberPhone = aes.encrypt(memberPhone);
			
			String memberPw = req.getParameter("memberPw");
			// 비밀번호 암호화
			memberPw = aes.encrypt(memberPw);
			
			String memberNickname = req.getParameter("memberNickname");
			String memberBirth = req.getParameter("memberBirth");
			String memberGender = req.getParameter("memberGender");
			String geoCity = req.getParameter("geoCity");
			String geoDistrict = req.getParameter("geoDistrict");
			
			// geoCode 가져오기
			GeoDAO gdao = new GeoDAO();
			int geoCode = gdao.selectOneGeoByCity(geoCity, geoDistrict);
			
			// MemberVO 값 넣기
			MemberDAO mdao = new MemberDAO();
			MemberVO vo = new MemberVO();
			vo.setGeoCode(geoCode);
			vo.setMemberPhone(memberPhone);
			vo.setMemberPw(memberPw);
			vo.setMemberNickname(memberNickname);
			vo.setMemberBirth(memberBirth);
			vo.setMemberGender(memberGender);
			mdao.addMember(vo);
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "member?cmd=login";
	}

}
