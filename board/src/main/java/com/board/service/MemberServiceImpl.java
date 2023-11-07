package com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.dao.MemberDAO;
import com.board.dto.AddressDTO;
import com.board.dto.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO dao;
	
	// 회원 가입
	@Override
	public void memberInfoRegistry(MemberDTO member) {
		dao.memberInfoRegistry(member);
	}
	
	// 회원 정보 가져오기
	@Override
	public MemberDTO memberInfo(String userid) {
		return dao.memberInfo(userid);
	}
	
	// 아이디 중복 확인
	@Override
	public int idCheck(String userid) {
		return dao.idCheck(userid);
	}
	
	// 패스워드 수정
	@Override
	public void memberPasswordModify(MemberDTO member) {
		dao.memberPasswordModify(member);
	}
	
	// 마지막 로그인 날짜 등록 하기
	@Override
	public void lastlogindateUpdate(MemberDTO member) {
		dao.lastlogindateUpdate(member);
	}
	
	// 마지막 로그아웃 날짜 등록 하기
	@Override
	public void lastlogoutdateUpdate(MemberDTO member) {
		dao.lastlogindateUpdate(member);
	}
	
	// 아이디 찾기
	@Override
	public String searchID(MemberDTO member) {
		return dao.searchID(member);
	}
	
	// authkey 업데이트
	@Override
	public void authkeyUpdate(MemberDTO member) {
		dao.authkeyUpdate(member);
	}
	
	// authkey 존재 여부 확인 
	public MemberDTO MemberInfoByAuthkey(MemberDTO member) {
		return dao.MemberInfoByAuthkey(member);
	}
	
	// 주소 검색
	@Override
	public List<AddressDTO> addrSearch(int startPoint, int postNum, String addrSearch) {
		return dao.addrSearch(startPoint, postNum, addrSearch);
	}

	// 주소 행 최대 갯수 계산
	@Override
	public int addrTotalCount(String addrSearch) {
		return dao.addrTotalCount(addrSearch);
	}



}
