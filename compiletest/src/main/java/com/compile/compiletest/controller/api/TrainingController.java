package com.compile.compiletest.controller.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.compile.compiletest.dto.JsonResult;
import com.compile.compiletest.linux.TrainingLinux;
import com.compile.compiletest.service.TrainingService;
import com.compile.compiletest.vo.CodeVo;
import com.compile.compiletest.vo.ProblemVo;
import com.compile.compiletest.vo.SavePathVo;
import com.compile.compiletest.vo.SubProblemVo;
import com.compile.compiletest.vo.UserVo;

@RestController("TrainingController")
@RequestMapping("/api/training")
public class TrainingController {

	@Autowired
	private TrainingService trainingService;


	@PostMapping(value = "/list")
	public JsonResult originProblemList(String page, String kwd, String category, String[] checkValues) {

		int p = Integer.parseInt(page);
		Map<String, Object> map = trainingService.getContentsList(p, kwd, category, checkValues);

		return JsonResult.success(map);
	}

	@PostMapping("/mylist")
	public JsonResult mylist(Long no) {

		ProblemVo problemVo = trainingService.selectProblemOne(no);
		List<SubProblemVo> list = trainingService.selectSubProblem(no);

		Map<String, Object> map = new HashMap<>();

		map.put("problemVo", problemVo);
		map.put("list", list);
		map.put("listSize", list.size());
		map.put("problemNo", no);

		return JsonResult.success(map);
	}


	@PostMapping("/answerlist")
	public JsonResult answerList(String page, String language, String subProblemNo) {

		int p = Integer.parseInt(page);
		Map<String, Object> map = trainingService.selectAnswerUserList(p, Long.parseLong(subProblemNo), language);

		return JsonResult.success(map);
	}

	@PostMapping("/save/problem")
	public JsonResult saveProblem(Long problemNo, HttpSession session, Long[] array) {

		UserVo authUser = (UserVo) session.getAttribute("authUser");

		trainingService.insertSaveProblemNo(authUser.getNo(), problemNo);
		Long saveNo = trainingService.findSaveNo(problemNo);

		trainingService.insertSavePath(array, saveNo, authUser.getNo(), problemNo);

		TrainingLinux trainingLinux = new TrainingLinux();
		trainingLinux.saveProblemAndSubProblem(authUser.getNo(), problemNo, array);

		return JsonResult.success(null);
	}

	@PostMapping("/recommend")
	public JsonResult recommend(Long problemNo, HttpSession session) {

		UserVo authUser = (UserVo) session.getAttribute("authUser");

		Map<String, Object> map = trainingService.updateRecommend(authUser.getNo(), problemNo);

		return JsonResult.success(map);
	}
}
