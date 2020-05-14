package com.compile.compiletest.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.compile.compiletest.vo.ProblemVo;

@Repository
public class TrainingRepository {
	
	@Autowired
	private SqlSession sqlSession;

	public List<ProblemVo> selectLevelList(Map<String, Object> map) {
		return sqlSession.selectList("training.selectLevelList", map);
	}

	public List<ProblemVo> selectProblemListOrigin() {
		return sqlSession.selectList("training.selectProblemListOrigin");
	}

	public List<ProblemVo> selectOrganizationList(Map<String, Object> map) {
		return sqlSession.selectList("training.selectOrganizationList", map);
	}
}