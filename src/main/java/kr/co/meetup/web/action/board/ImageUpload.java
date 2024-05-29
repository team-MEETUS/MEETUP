package kr.co.meetup.web.action.board;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/imageUpload")
public class ImageUpload extends HttpServlet {
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// 파일 경로 받아오기
        String saveDir = req.getServletContext().getRealPath("/upload");

        // 최대 파일 크기 지정
        int maxFileSize = 1024 * 1024 * 30;

        // MultipartRequest 객체 생성
        MultipartRequest mr = new MultipartRequest(req, saveDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());

        // 업로드된 파일 가져오기
        String fileName = mr.getFilesystemName("file");
        String fileUrl = req.getContextPath() + "/upload/" + fileName;

        // 응답으로 이미지 URL 반환
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        System.out.println("{\"url\": \"" + fileUrl + "\"}");
        out.print("{\"url\": \"" + fileUrl + "\"}");
        out.flush();
    }
}
