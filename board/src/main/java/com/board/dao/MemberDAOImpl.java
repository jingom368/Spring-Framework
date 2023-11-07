package com.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.board.dto.AddressDTO;
import com.board.dto.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	SqlSession sql;
	private static String namespace = "com.board.mappers.member";
	
	// 회원 가입
	@Override
	public void memberInfoRegistry(MemberDTO member) {
		sql.insert(namespace + ".memberInfoRegistry", member);
	}
	
	// 아이디 중복 확인
	@Override
	public int idCheck(String userid) {
		return sql.selectOne(namespace + ".idCheck", userid);
	}
	
	// 패스워드 수정
	@Override
	public void memberPasswordModify(MemberDTO member) {
		sql.update(namespace + ".memberPasswordModify", member);
	}
	
	// 마지막 로그인 날짜 등록 하기
	@Override
	public void lastlogindateUpdate(MemberDTO member) {
		sql.update(namespace + ".lastlogindateUpdate", member);
	}	
	
	// 마지막 로그아웃 날짜 등록 하기
	@Override
	public void lastlogoutdateUpdate(MemberDTO member) {
		sql.update(namespace + ".lastlogoutdateUpdate", member);
	}
	
	// 아이디 찾기
	@Override
	public String searchID(MemberDTO member) {
		return sql.selectOne(namespace + ".searchID", member);
	}
	
	// authkey 업데이트
	@Override
	public void authkeyUpdate(MemberDTO member) {
		sql.update(namespace + ".authkeyUpdate", member);
	}
	
	// authkey 존재 여부 확인
	@Override
	public MemberDTO MemberInfoByAuthkey(MemberDTO member) {
		return sql.selectOne(namespace + ".MemberInfoByAuthkey", member);
	}
		
	
	// 회원 정보 가져 오기
	@Override
	public MemberDTO memberInfo(String userid) {
		return sql.selectOne(namespace +".memberInfo", userid);
	}
	
	// 주소 검색
	@Override
	public List<AddressDTO> addrSearch(int startPoint, int postNum, String addrSearch) {
		Map<String,Object> data = new HashMap<>();
		data.put("startPoint", startPoint);
		data.put("postNum", postNum);
		data.put("addrSearch", addrSearch);
		return sql.selectList(namespace + ".addrSearch", data);
	}

	// 주소 행 최댓 갯수 계산
	@Override
	public int addrTotalCount(String addrSearch) {
		return sql.selectOne(namespace + ".addrTotalCount", addrSearch);
	
	}


	
}
