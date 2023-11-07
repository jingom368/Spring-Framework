package com.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.board.dto.BoardDTO;
import com.board.dto.FileDTO;
import com.board.dto.LikeDTO;
import com.board.dto.ReplyDTO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Autowired // 의존성 주입이라는 방법으로 XML방식(root-context.xml)을 통해 생성된 스프링빈인 SqlSession을 호출
	private SqlSession sql;
	
	private static String namespace = "com.board.mappers.board";
	
	// 게시물 목록 보기 - selectList
	@Override
	public List<BoardDTO> list(int startPoint, int postNum, String keyword) throws Exception {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("startPoint", startPoint);
		data.put("postNum", postNum);
		data.put("keyword", keyword);
		return sql.selectList(namespace + ".list", data); // com.board.mappers.board.list
	}
	
	// 게시물 전체 갯수 계산
	public int getTotalCount(String keyword) {
		return sql.selectOne(namespace + ".getTotalCount", keyword);
	}

	// 게시물 내용 보기 - selectOne
	@Override
	public BoardDTO view(int seqno) throws Exception {
		return sql.selectOne(namespace + ".view", seqno);
	}
	
	// 게시물 내용 이전 보기 - selectOne
	@Override
	public int pre_seqno(int seqno, String keyword) throws Exception {
		Map<String,Object> data = new HashMap<>();
		data.put("seqno", seqno);
		data.put("keyword", keyword);
		return sql.selectOne(namespace + ".pre_seqno", data);
	}
	 
	// 게시물 내용 다음 보기 - selectOne
	@Override
	public int next_seqno(int seqno, String keyword) throws Exception {
		Map<String,Object> data = new HashMap<>();
		data.put("seqno", seqno);
		data.put("keyword", keyword);
		return sql.selectOne(namespace + ".next_seqno", data);
	}
	
	// 게시물 조회수 증가 - update
	@Override
	public void hitno(int seqno) throws Exception {
		sql.update(namespace + ".hitno", seqno);
	}

	// 게시물 등록 하기 - insert
	@Override
	public void write(BoardDTO board) throws Exception {
		sql.insert(namespace + ".write", board);
	}
	
	// 첨부파일 등록 하기
	@Override
	public void fileInfoRegistry(Map<String, Object> data) {
		sql.insert(namespace + ".fileInfoRegistry", data);
	}
	
	// 첨부 파일 목록 보기
	@Override
	public List<FileDTO> fileInfoView(int seqno) {
		return sql.selectList(namespace + ".fileInfoView", seqno);
	}
	
	// 다운로드를 위한 파일 정보 가져 오기
	@Override
	public FileDTO fileInfo(int fileseqno) {
		return sql.selectOne(namespace + ".fileInfo", fileseqno);
	}
	
	// 첨부 파일 삭제를 위한 checkfile 정보 변경
	public void fileInfoUpdate(int seqno) {
		sql.update(namespace + ".fileInfoUpdate", seqno);
	}

	// 게시물 수정 하기 - update
	@Override
	public void modify(BoardDTO board) throws Exception {
		sql.update(namespace + ".modify", board);
	}
	
	// 게시물 수정 시 파일 파일 정보 수정(checkfile을 X로 변경)
	@Override
	public void deleteFileList(int fileseqno) throws Exception {
		sql.update(namespace + ".deleteFileList",fileseqno);
	}

	// 게시물 삭제 하기 - delete
	@Override
	public void delete(int seqno) throws Exception {
		sql.update(namespace + ".delete", seqno);
	}
	
	// 게시물 좋아요/싫어요 수정
	@Override
	public void boardlikeUpdate(BoardDTO board) throws Exception {
		sql.update(namespace + ".boardlikeUpdate", board);
	}

	// 좋아요/싫어요 등록 여부 확인
	@Override
	public LikeDTO likeCheckView(LikeDTO like) {
		return sql.selectOne(namespace + ".likeCheckView", like);
	}

	// 좋아요/싫어요 신규 등록
	@Override
	public void likeCheckRegistry(LikeDTO like) {
		sql.insert(namespace + ".likeCheckRegistry", like);
	}

	// 좋아요/싫어요 수정
	@Override
	public void likeCheckUpdate(LikeDTO like) {
		sql.update(namespace + ".likeCheckUpdate", like);
	}

	// 댓글 보기
	@Override
	public List<ReplyDTO> replyView(ReplyDTO reply) throws Exception {
		return sql.selectList(namespace + ".replyView", reply);
	}

	// 댓글 등록
	@Override
	public void replyRegistry(ReplyDTO reply) throws Exception {
		sql.insert(namespace + ".replyRegistry", reply);
	}

	// 댓글 수정
	@Override
	public void replyUpdate(ReplyDTO reply) throws Exception {
		sql.update(namespace + ".replyUpdate", reply);		
	}

	// 댓글 삭제
	@Override
	public void replyDelete(ReplyDTO reply) throws Exception {
		sql.delete(namespace + ".replyDelete", reply);				
	}
}
