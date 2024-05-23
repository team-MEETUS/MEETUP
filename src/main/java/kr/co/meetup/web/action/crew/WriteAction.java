package kr.co.meetup.web.action.crew;

import java.io.UnsupportedEncodingException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.CrewVO;

public class WriteAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		try {
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");
			
			// MultipartRequest 객체로부터 파라미터 값 가져오기 
			String categoryBigNo = (String) req.getAttribute("categoryBigNo");
			String categorySmallNo = (String) req.getAttribute("categorySmallNo");
			String geoCity = (String) req.getAttribute("geoCity");
			String geoDistrict = (String) req.getAttribute("geoDistrict");
			String crewName = (String) req.getAttribute("crewName");
			String crewMax = (String) req.getAttribute("crewMax");
			String crewContent = (String) req.getAttribute("crewContent");
			String crewOriginalImg = (String) req.getAttribute("crewOriginalImg");
			String crewSaveImg = (String) req.getAttribute("crewSaveImg");
			String crewOriginalBanner = (String) req.getAttribute("crewOriginalBanner");
			String crewSaveBanner = (String) req.getAttribute("crewSaveBanner");
			
			// crewContent 의 첫 줄을 crewIntro 로 저장 
			String crewIntro = "";
			if (crewContent != null && !crewContent.trim().isEmpty()) {
				String[] lines = crewContent.split("\\R");
				if (lines.length > 0) {
					crewIntro = lines[0];
				}
			}
			System.out.println("한줄소개 : " + crewIntro);

			// DB 에 저장
			CrewDAO dao = new CrewDAO();
			CrewVO vo = new CrewVO();
			// 카테고리&지역코드&작성자 임시값 사용
			vo.setGeoCode(11110);
			vo.setCategoryBigNo(1);
			vo.setCategorySmallNo(3);
			vo.setMemberNo(2);
			// 파라미터 값 넣기
			vo.setCrewName(crewName);
			vo.setCrewContent(crewContent);
			vo.setCrewIntro(crewIntro);
			vo.setCrewMax(Integer.parseInt(crewMax));
			vo.setCrewOriginalImg(crewOriginalImg);
			vo.setCrewSaveImg(crewSaveImg);
			vo.setCrewOriginalBanner(crewOriginalImg);
			vo.setCrewSaveBanner(crewSaveBanner);
			dao.addCrew(vo);
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
		return "redirect:crew?cmd=list";
	}

}
