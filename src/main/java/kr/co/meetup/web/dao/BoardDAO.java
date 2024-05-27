package kr.co.meetup.web.dao;

import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.co.meetup.web.vo.BoardCategoryVO;
import kr.co.meetup.web.vo.BoardCommentVO;
import kr.co.meetup.web.vo.BoardVO;

public class BoardDAO {

	public SqlSessionFactory factory;

	public BoardDAO() {
		try {
			Reader r = Resources.getResourceAsReader("config/SqlMapConfig.xml");
			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
			factory = builder.build(r);
			r.close();
		} catch (IOException e) {
			System.err.println("config.xml 파일을 찾을 수 없습니다.");
			e.printStackTrace();
		}
	}

	// 게시판 총 데이터 수 조회(crewNo 조건)
	public int selectAllBoardByCrewNoCnt(int crewNo) {
		SqlSession ss = factory.openSession(true);
		int count = ss.selectOne("kr.co.meetup.web.board.selectAllBoardByCrewNoCnt");
		ss.close();
		return count;
	}
	public int selectAllBoardCount() {
		SqlSession ss = factory.openSession(true);
		int count = ss.selectOne("kr.co.meetup.web.board.selectAllBoardCount");
		ss.close();
		return count;
	}
	public int selectAllBoardByBoardCategoryNo(int boardCategoryNo) {
		SqlSession ss = factory.openSession(true);
		int count = ss.selectOne("kr.co.meetup.web.board.selectAllBoardByBoardCategoryNo",boardCategoryNo);
		ss.close();
		return count;
	}

//	// 모임별 게시판 전체 조회(crewNo 조건 포함)
//	public List<BoardVO> selectAllBoardBycrewNo(int crewNo, int startNo, int recordPerPage) {
//		SqlSession ss = factory.openSession(true);
//
//		HashMap<String, Integer> map = new HashMap<String, Integer>();
//		map.put("crewNo", crewNo);
//		map.put("startNo", startNo);
//		map.put("recordPerPage", recordPerPage);
//		List<BoardVO> list = ss.selectList("kr.co.meetup.web.board.selectAllBoardBycrewNo", map);
//		ss.close();
//		return list;
//	}

	// 게시판 카테고리 조회
	public List<BoardCategoryVO> selectAllBoardCategory() {
		SqlSession ss = factory.openSession(true);
		List<BoardCategoryVO> list = ss.selectList("kr.co.meetup.web.board.selectAllBoardCategory");
		ss.close();
		return list;
	}

	// 게시판 카테고리별 게시글 조회
	public List<BoardVO> selectBoardByCategory(int bc,int startNo,int recordPerPage) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("boardCategoryNo", bc);
		map.put("startNo", startNo);
		map.put("recordPerPage", recordPerPage);
		List<BoardVO> list = ss.selectList("kr.co.meetup.web.board.selectBoardByCategory", map);
		ss.close();
		return list;
	}
	
	//리스트 페이징 처리용
	public List<BoardVO> selectBoardAllByCategory(int startNo,int recordPerPage) {
		SqlSession ss = factory.openSession(true);
		Map<String, Integer> map = Map.of("startNo", startNo,"recordPerPage", recordPerPage);
		List<BoardVO> list = ss.selectList("kr.co.meetup.web.board.selectBoardAllByCategory",map);
		ss.close();
		return list;
	}

	// 게시글 1건 조회
	public BoardVO selectOneBoard(int boardNo) {
		SqlSession ss = factory.openSession(true);
		BoardVO vo = ss.selectOne("kr.co.meetup.web.board.selectOneBoard", boardNo);
		ss.close();
		return vo;
	}

	// 게시글 작성
	public void addOneBoard(BoardVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.insert("kr.co.meetup.web.board.addOneBoard", vo);
		ss.close();
	}

	// 게시글 수정
	public void updateOneBoard(BoardVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.web.board.updateOneBoard", vo);
		ss.close();
	}

	// 게시글 삭제(update)
	public void deleteOneBoard(int boardNo) {
		SqlSession ss = factory.openSession(true);

		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("boardNo", boardNo);

		ss.update("kr.co.meetup.web.board.deleteOneBoard", map);

		ss.close();
	}

	// 게시글 조회수 1 증가
	public void raiseHitBoard(int boardNo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.web.board.raiseHitBoard", boardNo);
		ss.close();
	}
	
	
	//댓글 작성
	public void addOneComment(BoardCommentVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.insert("kr.co.meetup.web.board.addOneComment", vo);
		ss.close();
	}
	
	//댓글 목록 조회
	public List<BoardCommentVO> selectComment(int boardNo) {
		SqlSession ss = factory.openSession(true);
		List<BoardCommentVO> list = ss.selectList("kr.co.meetup.web.board.selectComment", boardNo);
		ss.close();
		return list;
	}
	
	// 댓글 수정
	public void updateOneBoardComment(BoardCommentVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.web.board.updateOneBoardComment", vo);
		System.out.println(vo.getBoardCommentContent());
		ss.close();
	}
	
}