package kr.co.meetup.web.action.member;

import java.io.UnsupportedEncodingException;

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
			
			String memberPhone = req.getParameter("memberPhone");
			String memberPw = req.getParameter("memberPw");
			String memberNickname = req.getParameter("memberNickname");
			String geoCity = req.getParameter("geoCity");
			String geoDistrict = req.getParameter("geoDistrict");
			
			// geoCode 가져오기
			GeoDAO gdao = new GeoDAO();
			int geoCode = (int) gdao.selectOneGeoByCity(geoCity, geoDistrict);
			
			// MemberVO 값 넣기
			MemberDAO mdao = new MemberDAO();
			MemberVO vo = new MemberVO();
			vo.setGeoCode(geoCode);
			vo.setMemberPhone(memberPhone);
			vo.setMemberPw(memberPw);
			vo.setMemberNickname(memberNickname);
			mdao.addMember(vo);
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "member?cmd=login";
	}

}
