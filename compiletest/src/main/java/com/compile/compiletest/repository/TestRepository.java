package com.compile.compiletest.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.compile.compiletest.vo.ProblemVo;
import com.compile.compiletest.vo.UserVo;

@Repository
public class TestRepository {
	
	@Autowired
	private SqlSession sqlSession;

	public List<ProblemVo> selectTestList() {
		return sqlSession.selectList("test.selectTestList");
	}

	public UserVo findUserByEmail(String userEmail) {
		return sqlSession.selectOne("test.findUserByEmail", userEmail);
	}

	
}