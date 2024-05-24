package kr.co.meetup.web.action.crew;

import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.dao.GeoDAO;
import kr.co.meetup.web.vo.CrewVO;

@WebServlet("/crewWrite")
public class WriteAction extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파일 경로 받아오기
		String saveDir = req.getServletContext().getRealPath("/upload");
	    
	    // 최대 파일 크기 지정 
	    int maxFileSize = 1024 * 1024 * 30;
	    
    	// MultipartRequest 객체 생성 
    	MultipartRequest mr = new MultipartRequest(req, saveDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
        
    	// MultipartRequest 객체로부터 파라미터 값 가져오기
        String cbn = mr.getParameter("categoryBigNo");
		String csn = mr.getParameter("categorySmallNo");
		String geoCity = mr.getParameter("geoCity");
		String geoDistrict = mr.getParameter("geoDistrict");
		String crewName = mr.getParameter("crewName");
		String cm = mr.getParameter("crewMax");
		String crewContent = mr.getParameter("crewContent");
		// 메인 이미지의 원본파일명, 저장파일명
		String crewOriginalImg = mr.getOriginalFileName("crewImg");
		String crewSaveImg = mr.getFilesystemName("crewImg");;
		
		// 배너 이미지의 원본파일명, 저장파일명
		String crewOriginalBanner = mr.getOriginalFileName("crewBanner");
		String crewSaveBanner = mr.getFilesystemName("crewBanner");;
		
		// crewContent 의 첫 줄을 crewIntro 로 저장 
		String crewIntro = "";
		if (crewContent != null && !crewContent.trim().isEmpty()) {
			String[] lines = crewContent.split("\\R");
			if (lines.length > 0) {
				crewIntro = lines[0];
			}
		}
		
		// 해당 시/구 지역코드 가져오기
		GeoDAO gdao = new GeoDAO();
		int geoCode = gdao.selectOneGeoByCity(geoCity, geoDistrict);
		
		// String > int 형변환
		int categoryBigNo = Integer.parseInt(cbn);
		int categorySmallNo = Integer.parseInt(csn);
		int crewMax = Integer.parseInt(cm);
		
		// DB 에 저장
		CrewDAO dao = new CrewDAO();
		CrewVO vo = new CrewVO();
		vo.setGeoCode(geoCode);
		vo.setCategoryBigNo(categoryBigNo);
		vo.setCategorySmallNo(categorySmallNo);
		// 작성자 임시값 사용
		vo.setMemberNo(2);
		// 파라미터 값 넣기
		vo.setCrewName(crewName);
		vo.setCrewContent(crewContent);
		vo.setCrewIntro(crewIntro);
		vo.setCrewMax(crewMax);
		vo.setCrewOriginalImg(crewOriginalImg);
		vo.setCrewSaveImg(crewSaveImg);
		vo.setCrewOriginalBanner(crewOriginalImg);
		vo.setCrewSaveBanner(crewSaveBanner);
		dao.addCrew(vo);
        
		resp.sendRedirect("crew");
		
	}
	
}
