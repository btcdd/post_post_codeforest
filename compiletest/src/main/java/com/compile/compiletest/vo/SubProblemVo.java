package com.compile.compiletest.vo;

public class SubProblemVo {
	private Long no;
	private String contents;
	private String examInput;
	private String correctCode;
	private String examOutput;
	private Long problemNo;
	
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getExamInput() {
		return examInput;
	}
	public void setExamInput(String examInput) {
		this.examInput = examInput;
	}
	public String getCorrectCode() {
		return correctCode;
	}
	public void setCorrectCode(String correctCode) {
		this.correctCode = correctCode;
	}
	public String getExamOutput() {
		return examOutput;
	}
	public void setExamOutput(String examOutput) {
		this.examOutput = examOutput;
	}
	public Long getProblemNo() {
		return problemNo;
	}
	public void setProblemNo(Long problemNo) {
		this.problemNo = problemNo;
	}
	
	@Override
	public String toString() {
		return "SubProblemVo [no=" + no + ", contents=" + contents + ", examInput=" + examInput + ", correctCode="
				+ correctCode + ", examOutput=" + examOutput + ", problemNo=" + problemNo + "]";
	}
}
