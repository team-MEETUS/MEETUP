import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

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

	// 게시판 총 데이터 수 조회
	public int selectTotalCountBoard() {
		// openSession(true) : autocommit 옵션
		SqlSession ss = factory.openSession(true);
		// 별칭 : namespace명.id
		int count = ss.selectOne("kr.co.meetup.web.board.selectTotalCountBoard");
		ss.close();
		return count;
	}
	
	// 게시판 -전체 조회
	public List<BoardVO> selectAllBoard(int boardStartNo, int boardEndNo) {
		SqlSession ss = factory.openSession(true);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("boardStartNo", boardStartNo);
		map.put("boardEndNo", boardEndNo);
		List<BoardVO> list = ss.selectList("kr.co.meetup.web.board.allSelectBoard", map);
		ss.close();
		return list;
	}

	// 게시판 - 1건 조회
	public BoardVO selectOneBoard(int boardNo) {
		SqlSession ss = factory.openSession(true);
		BoardVO vo = ss.selectOne("kr.co.meetup.web.board.selectOneBoard", boardNo);
		ss.close();
		return vo;
	}

	// 게시판 - 게시글 작성
	public void addOneBoard(BoardVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.insert("kr.co.meetup.web.board.addBoardOne", vo);
		ss.close();
	}

	// 게시판 - 1건 게시글 수정
	public void updateOneBoard(BoardVO vo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.web.board.updateOneBoard", vo);
		ss.close();
	}

	// 게시판 - 1건 게시글 삭제
	public void deleteOneBoard(int boardNo) {
		SqlSession ss = factory.openSession(true);
		ss.delete("kr.co.meetup.web.board.deleteOneBoard", boardNo);
		ss.close();
	}

	// 게시판- 조회수 1 증가
	public void raiseHitBoard(int boardNo) {
		SqlSession ss = factory.openSession(true);
		ss.update("kr.co.meetup.web.board.raiseHitBoard", boardNo);
		ss.close();
	}

}
