<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Code Forest</title>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath }/assets/css/mypage/problem.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script type="text/javascript" src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  	<script type="text/javascript" src="${pageContext.servletContext.contextPath }/assets/js/jquery/table2excel.js"></script>
<script>
$(function() {
	var dialogDelete = $("#dialog-delete").dialog({
		autoOpen: false,
		resizable: false,
		height: "auto",
		width: 400,
		modal: true,
		buttons: {
			"삭제": function() {
				var no = $("#hidden-no").val();
				$.ajax({
					url: '${pageContext.servletContext.contextPath }/api/mypage/problem/delete/' + no,
					async: true,
					type: 'delete',
					dataType: 'json',
					data: '',
					success: function(response) {
						dialogDelete.dialog('close');
					},
					error: function(xhr, status, e) {
						console.error(status + ":" + e);
					}
				});
			},
			"취소": function() {
				$(this).dialog('close');
			}
		},
		close: function() {
			$("#hidden-no").val('');
			$("#dialog-delete-form p.validateTips.error").hide();
		}
	});
	
	$(document).on('click', '.delete', function(event) {
		event.preventDefault();
		
		var no = $(this).data('no');
		$('#hidden-no').val(no);
		dialogDelete.dialog('open');
	});
	
	// ------------------------------------- 문제 푼 사람 리스트 출력 --------------------------------------
	var dialogList = $(".problem-list").dialog({
		autoOpen: false,
		resizable: false,
		height: "auto",
		width: 1200,
		modal: true,
		buttons: {
			"다운로드": function() {		
				var title = $("#hidden-title").val();
				$(".problem-list-table").table2excel({
					exclude: ".discard",
					filename: title.concat(".xls")
				})
			},
			"취소": function() {
				$(this).dialog('close');
			}
		},
		close: function() {
			$(".problem-list-table tr th").removeClass();
			$(".problem-list-table tr th").show();
			$(".box-component").each(function(){
			       $(this).prop('checked',true);
			});
			$(".problem-list-table > #tbody > tr").remove();
			$("#hidden-no").val('');
		}
	});
	
	$(document).on('click', '.list', function(event) {
		event.preventDefault();
		
		var no = $(this).data('no');		
		var title = $(this).data('title');
		$('#hidden-title').val(title);
		
		$.ajax({
			url: '${pageContext.servletContext.contextPath }/api/mypage/problem/list/' + no,
			async: true,
			type: 'post',
			dataType: 'json',
			data: '',
			success: function(response) {
				console.log(response.data);
				var table = "";				
				for(var i in response.data) {
					table += "<tbody id='tbody'>" +
							"<tr><td id='name'>" + response.data[i].name + "</td>" +
							"<td id='email'>" + response.data[i].email + "</td>" + 
							"<td id='nickname'>" + response.data[i].nickname + "</td>" +
							"<td id='try-count'>" + response.data[i].tryCount + "</td>" + 
							"<td id='lang'>" + response.data[i].lang + "</td>" +
							"<td id='solve-time'>" + response.data[i].solveTime + "</td></tr></tbody>";							
				}			
				$(".problem-list-table").append(table);
				dialogList.dialog('open');
			},
			error: function(xhr, status, e) {
				console.error(status + ":" + e);
			}
		});
	});
	
	
	$(document).ready(function(){
	    $(".check-box input").on('click', function(){
	    	var value = $(this).val();
	    	console.log(value);
	        if($(this).prop("checked")){
	        	$(".problem-list-table > #tbody > tr > td#".concat(value)).show();
	        	$(".problem-list-table > #tbody > tr > td#".concat(value)).removeClass();
				$(".problem-list-table tr th#".concat(value)).show();
				$(".problem-list-table tr th#".concat(value)).removeClass();
	        }else{
	        	$(".problem-list-table > #tbody > tr > td#".concat(value)).hide();
	        	$(".problem-list-table > #tbody > tr > td#".concat(value)).addClass('discard');
				$(".problem-list-table tr th#".concat(value)).hide();
				$(".problem-list-table tr th#".concat(value)).addClass('discard');
	        }
	    });
	});
	
	// ------------------------------------------- 서브 문제 출력 -------------------------------------------------------
	$(".problem-title").on('click', function() { 
        console.log($(this).data('no'));        
    	var no = $(this).data('no');
    	
    	if($("." + no).css('display') == 'none') {
    		$("." + no + " > .sub-problem-tbody > tr").remove();
    	}
    	
        $.ajax({
			url: '${pageContext.servletContext.contextPath }/api/mypage/sub-problem/' + no,
			async: true,
			type: 'post',
			dataType: 'json',
			data: '',
			success: function(response) {
				if(response.data.length == 0) {
					return;
				}
				console.log(response.data);
				var tr = "";				
				for(var i in response.data) {
					tr += "<tr id='sub-problem" + response.data[i].no + "'><td>(" + no + "-" + response.data[i].no +")</td>" + 
						"<td>" + response.data[i].title + "</td>" + 
						'<td><input data-no="' + response.data[i].no + '" type="image" src="${pageContext.servletContext.contextPath }/assets/images/mypage/delete.png" alt="delete" class="sp-delete"></td></tr>'

				}			
				$("." + no + " .sub-problem-tbody").append(tr);
				$("." + no).toggle();
			},
			error: function(xhr, status, e) {
				console.error(status + ":" + e);
			}
		});    
	});
	
	// ----------------------------------------------- 서브 문제 삭제 ----------------------------------------
	var dialogSpDelete = $("#dialog-delete-sp").dialog({
		autoOpen: false,
		resizable: false,
		height: "auto",
		width: 400,
		modal: true,
		buttons: {
			"삭제": function() {
				var no = $("#hidden-sp-no").val();
				var tableClass = $("#hidden-table-class").val();
				$.ajax({
					url: '${pageContext.servletContext.contextPath }/api/mypage/sub-problem/delete/' + no,
					async: true,
					type: 'delete',
					dataType: 'json',
					data: '',
					success: function(response) {		
						console.log("tableClass="+tableClass);						
						dialogSpDelete.dialog('close');						
						$('#sub-problem'+no).remove();
					},
					error: function(xhr, status, e) {
						console.error(status + ":" + e);
					}
				});
			},
			"취소": function() {
				$(this).dialog('close');
			}
		},
		close: function() {			
			$("#hidden-sp-no").val('');
			$("#hidden-table-class").val('');
		}
	});
	
	$(document).on('click', '.sp-delete', function(event) {
		event.preventDefault();
		
		var spNo = $(this).data('no');
		var tableClass = $("#sub-problem-table").attr('class');
		console.log("spno=" + spNo);
		$('#hidden-sp-no').val(spNo);
		$('#hidden-table-class').val(tableClass);
		dialogSpDelete.dialog('open');
	});
	
});
</script>
    
</head>

<body>
    <c:import url="/WEB-INF/views/include/mypage-header.jsp" />
    <div class="container">
        <div class="quizlist">
            <div class="line">
                <h4>작성한 퀴즈</h4>
            </div>
            <br>
            <table class="quiz-table">
            	<thead>
	                <tr>
	                    <th width="10%">번호</th>
	                    <th width="53%">제목</th>
	                    <th width="11%">조회수</th>
	                    <th width="11%">추천수</th>
	                    <th width="11%">삭제</th>
	                    <th width="11%">목록</th>
	                </tr>
                </thead>
                <tbody id="problem-tbody">
                	
	              	<c:forEach items='${map.list }' var='problemvo' varStatus='status'>
	                	<tr class="list-contents" data-no="${problemvo.no }">
	                		<td><a data-no="${problemvo.no }">${problemvo.no }</a></td>
		                    <td class="problem-title" data-no="${problemvo.no }">${problemvo.title }</td>
		                    <td>${problemvo.hit }</td>
		                    <td>${problemvo.recommend }</td>
		                    <td><input data-no="${problemvo.no }" type="image" src="${pageContext.servletContext.contextPath }/assets/images/mypage/delete.png" alt="delete" class="delete"></td>
	                      <td><input data-no="${problemvo.no }" data-title="${problemvo.title }" type="image" src="${pageContext.servletContext.contextPath }/assets/images/mypage/list.png" alt="list" class="list"></td>
	                	</tr>
	                	
	                	<tr>
	                		<td></td>
		                	<td>
			                	<table id="sub-problem-table" class="${problemvo.no }" style="display: none;">
			                		<tbody class="sub-problem-tbody">
			                		
			                		</tbody>
			                	</table>
		                	</td>
		               	</tr>	
		                      	
	             		
	                	
	                </c:forEach>
                </tbody>
                
            </table>
				
				
				
				<!-- pager 추가 -->
				<div class ="pager">
					<c:if test="${map.prev }">
						<span>[ <a href="${pageContext.request.contextPath }/mypage/problem?p=${map.startPageNum -1}">이전</a> ]</span>
					</c:if>				
					
					<c:forEach begin="${map.startPageNum }" end="${map.endPageNum }" var="page">
						<span>
							<c:if test="${map.select != page }">
								<a href="${pageContext.request.contextPath }/mypage/problem?p=${page}">${page}</a>
							</c:if>
							
							<c:if test="${map.select == page }">
								<b>${page }</b>
							</c:if>
						</span>
					</c:forEach>
						
					<c:if test="${map.next }">
						<span>[ <a href="${pageContext.request.contextPath }/mypage/problem?p=${map.endPageNum +1}">다음</a> ]</span>
					</c:if>											
				</div>
				<!-- pager 추가 -->           
            
            
            <br>
        </div>

    </div>
    
    <div id="dialog-delete" title="문제 모음 삭제" style="display: none">
    	<p>
    		<span class="ui-icon ui-icon-alert" style="float: left; margin: 12px 12px 20px 0;">	
    		</span>
    		해당 문제 모음을 삭제하시겠습니까?
    	</p>
    	<form>
    		<input type="hidden" id="hidden-no" value="">
    		<input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    	</form>
    </div>
    
    <div id="dialog-delete-sp" title="서브 문제 삭제" style="display: none">
    	<p>
    		<span class="ui-icon ui-icon-alert" style="float: left; margin: 12px 12px 20px 0;">	
    		</span>
    		해당 서브 문제를 삭제하시겠습니까?
    	</p>
    	<form>
    		<input type="hidden" id="hidden-sp-no" value="">
    		<input type="hidden" id="hidden-table-class" value="">
    		<input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    	</form>
    </div>
    
    <div class="problem-list" title="문제 푼 사람 리스트" style="display: none">
    	<input type="hidden" id="hidden-title" value="">
    	<div class="check-box">
	    	<label><input class="box-component" type="checkbox" name="problem-list-table" value="name" checked>이름</label>
	    	<label><input class="box-component" type="checkbox" name="problem-list-table" value="email" checked>이메일</label>
	    	<label><input class="box-component" type="checkbox" name="problem-list-table" value="nickname" checked>닉네임</label>
	    	<label><input class="box-component" type="checkbox" name="problem-list-table" value="try-count" checked>시도횟수</label>
	    	<label><input class="box-component" type="checkbox" name="problem-list-table" value="lang" checked>언어</label>
	    	<label><input class="box-component" type="checkbox" name="problem-list-table" value="solve-time" checked>해결시간</label>
    	</div>
    	<table class="problem-list-table">
    		<tr>
            	<th id="name">이름</th>
                <th id="email">이메일</th>
                <th id="nickname">닉네임</th>
                <th id="try-count">시도횟수</th>
                <th id="lang">언어</th>
                <th id="solve-time">해결시간</th>
            </tr>           
    	</table>

    </div>
    
</body>

</html>