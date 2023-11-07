package com.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.dao.BoardDAO;
import com.board.dto.BoardDTO;
import com.board.dto.FileDTO;
import com.board.dto.LikeDTO;
import com.board.dto.ReplyDTO;

@Service 
class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO dao;
	
	// 게시물 목록 보기 - selectList
	@Override
	public List<BoardDTO> list(int startPoint, int postNum, String keyword) throws Exception {
		return dao.list(startPoint, postNum, keyword);
	}
	
	// 게시물 전체 갯수 계산
	public int getTotalCount(String keyword) {
		return dao.getTotalCount(keyword);
	}

	// 게시물 내용 보기 - selectOne
	@Override
	public BoardDTO view(int seqno) throws Exception {
		return dao.view(seqno);
	}
	
	// 게시물 내용 이전 보기 - selectOne
	@Override
	public int pre_seqno(int seqno, String keyword) throws Exception {
		return dao.pre_seqno(seqno, keyword);
	}

	// 게시물 내용 다음 보기 - selectOne
	@Override
	public int next_seqno(int seqno, String keyword) throws Exception {
		return dao.next_seqno(seqno, keyword);
	}

	// 게시물 조회수 증가 - update
	@Override
	public void hitno(int seqno) throws Exception {
		dao.hitno(seqno);
	}
	
	// 게시물 등록 하기
	@Override
	public void write(BoardDTO board) throws Exception {
		dao.write(board);
	}
	
	// 첨부파일 등록 하기
	@Override
	public void fileInfoRegistry(Map<String, Object> data) {
		dao.fileInfoRegistry(data);
	}
	
	// 첨부 파일 목록 보기
	@Override
	public List<FileDTO> fileInfoView(int seqno) {
		return dao.fileInfoView(seqno);
	}
	
	// 다운로드를 위한 파일 정보 가져 오기
	@Override
	public FileDTO fileInfo(int fileseqno) {
		return dao.fileInfo(fileseqno);
	}
	
	// 첨부 파일 삭제를 위한 checkfile 정보 변경
	public void fileInfoUpdate(int seqno) {
		dao.fileInfoUpdate(seqno);
	}
	
	// 게시물 수정 하기 - update
	@Override
	public void modify(BoardDTO board) throws Exception {
		dao.modify(board);
	}

	// 게시물 삭제하기 - view
	@Override
	public void delete(int seqno) throws Exception {
		dao.delete(seqno);
	}
	
	// 게시물 좋아요/싫어요 수정
	@Override
	public void boardlikeUpdate(BoardDTO board) throws Exception {
		dao.boardlikeUpdate(board);
	}

	// 좋아요/싫어요 등록 여부 확인
	@Override
	public LikeDTO likeCheckView(LikeDTO like) {
		return dao.likeCheckView(like);
	}

	// 좋아요/싫어요 신규 등록
	@Override
	public void likeCheckRegistry(LikeDTO like) {
		dao.likeCheckRegistry(like);
	}

	// 좋아요/싫어요 수정
	@Override
	public void likeCheckUpdate(LikeDTO like) {
		dao.likeCheckUpdate(like);
	}

	// 댓글 보기
	@Override
	public List<ReplyDTO> replyView(ReplyDTO reply) throws Exception {
		return dao.replyView(reply);
	}

	// 댓글 등록
	@Override
	public void replyRegistry(ReplyDTO reply) throws Exception {
		dao.replyRegistry(reply);
	}

	// 댓글 수정
	@Override
	public void replyUpdate(ReplyDTO reply) throws Exception {
		dao.replyUpdate(reply);
	}

	// 게시물 수정 시 파일 정보 수정(checkfile을 X로 변경)
	@Override
	public void deleteFileList(int fileseqno) throws Exception {
		dao.deleteFileList(fileseqno);
	}
	
	// 댓글 삭제
	@Override
	public void replyDelete(ReplyDTO reply) throws Exception {
		dao.replyDelete(reply);
	}
}
