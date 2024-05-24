package kr.co.meetup.web.action.member;

import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.dao.GeoDAO;
import kr.co.meetup.web.dao.MemberDAO;
import kr.co.meetup.web.vo.MemberVO;

@WebServlet("/memberUpload")
public class UpdateAction extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String saveDir = req.getServletContext().getRealPath("/upload");
		
		int maxFileSize = 1024 * 1024 * 30;
		
		MultipartRequest mr = new MultipartRequest(req, saveDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
		
		String mno = mr.getParameter("memberNo");
		if(mno != null) {
			int memberNo = Integer.parseInt(mno);
			String memberNickname = mr.getParameter("memberNickname");
			String geoCity = mr.getParameter("geoCity");
			String geoDistrict = mr.getParameter("geoDistrict");
			String memberIntro = mr.getParameter("memberIntro");
			
			String memberOriginalImg = mr.getOriginalFileName("memberImg");
			String memberSaveImg = mr.getFilesystemName("memberImg");
			
			GeoDAO gdao = new GeoDAO();
			int geoCode = gdao.selectOneGeoByCity(geoCity, geoDistrict);
			
			MemberDAO mdao = new MemberDAO();
			MemberVO vo = new MemberVO();
			
			vo.setMemberNo(memberNo);
			vo.setMemberNickname(memberNickname);
			vo.setGeoCode(geoCode);
			vo.setMemberIntro(memberIntro);
			vo.setMemberOriginalImg(memberOriginalImg);
			vo.setMemberSaveImg(memberSaveImg);
			
			mdao.updateOneMemberByMemberNo(vo);
			
			resp.sendRedirect("index.jsp");
		}
		

	}

}
