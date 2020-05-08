package com.compile.compiletest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.compile.compiletest.Run.RunJs;
import com.compile.compiletest.dto.JsonResult;

@Controller
@RequestMapping("/compile")
public class CompileControllerJs {
   
	StringBuffer buffer = new StringBuffer();

	RunJs rtt = new RunJs();
	
   @ResponseBody
   @PostMapping("/js")
   public JsonResult compileJs(@RequestParam String code) {
      RunJs rtt = new RunJs();

      String result = rtt.execCommand();
      String errorResult = rtt.execCompile();
      
      String[] res = new String[2];
      res[0] = result;
      res[1] = errorResult;
      
      return JsonResult.success(res);
   }
   
   @ResponseBody
   @PostMapping("/js/save")
   public JsonResult compileSaveJs(@RequestParam String code) {
      
      String[] token = code.split("\n");
      
      for(int i = 0; i < token.length; i++) {
         buffer.append(token[i] + "\n");
      }
      rtt.createFileAsSource(code);
      
      String test = "success";
      
      return JsonResult.success(test);
   }
   
   @ResponseBody
	@PostMapping("/js/compile")
	public JsonResult cppCompileexam() {

		RunJs rtt = new RunJs();

		String result = rtt.execCompile();

		return JsonResult.success(result);
	}
}