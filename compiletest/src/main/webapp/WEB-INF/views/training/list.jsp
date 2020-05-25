<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Code Forest</title>
    <link href="${pageContext.servletContext.contextPath }/assets/css/training/list.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.servletContext.contextPath }/assets/css/main/main.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script type="text/javascript" src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>
<script>

function onKeyDown() {
	if(event.keyCode == 13) {
		kwd = $('#kwd').val();
		levelChecked(page, kwd);
	}
}

var checkValues = new Array();
var page = '1';
var category = '';
var kwd = '';

var originList = function(page, kwd, category) {
	
	$.ajax({
		url: '${pageContext.request.contextPath }/api/training/list',
		async: false,
		type: 'post',
		dataType: 'json',
		traditional: true,
		data: {
			'page': page,
			'kwd': kwd,
			'category': category,
			'checkValues': checkValues
		},
		success: function(response){
			if(response.result != "success"){
				console.error(response.message);
				return;
			}
			map = response.data;
						
			fetchList();
		},
		error: function(xhr, status, e){
			console.error(status + ":" + e);
		}
	});
}

var fetchList = function() {

    $(".list .problem-box").remove();
	$(".list .pager").remove();
	var str = "";
	for(var i = 0; i < map.list.length;i++){
		str += '<div class="problem-box" onclick="location.href=' + "'" + '${pageContext.servletContext.contextPath }/training/view/' + map.list[i].no + "'" + '">' +
		'<div class="problem-no"><a data-no=' + map.list[i].no + '>' + map.list[i].no +'</a></div>' +
        '<div class="problem-recommend"><img src="${pageContext.servletContext.contextPath }/assets/images/like.png" class="like" />' + map.list[i].recommend + '</div>' + 
		'<div class="problem-title" id="title">' + map.list[i].title + '</div>' +
        '<div class="problem-user">' + map.list[i].nickname + '</div>' + 
        '<div class="problem-kind">' + map.list[i].kind + '</div>' + 
	'</div>';		
	}
	$(".problems").append(str);
	
	var str2 = "<div class='pager'>";
	
	if(page != '1'){
		str2 += '<span class="prev">◀</span>';
	}	
	for(var i = map.startPageNum; i < map.endPageNum; i++){
		str2 += '<span class="page" id="' + i + '">';
		if(map.select != i ){
			str2 += i;
		}
		if(map.select == i){
			str2 += '<b>'+i+'</b>';
		}
		str2 += '</span>';
	}
	if(map.next){
		str2 += '<span class="next">▶</span>';
	}	 
	str2 += "</div>"; 
		
	$(".problems").after(str2);
}

var levelChecked = function(page, kwd) {
	
	$("input[name=level]:checked").each(function(i) {
		checkValues.push($(this).val());
		category = 'level';
	})
	$("input[name=organization]:checked").each(function(i) {
		checkValues.push($(this).val());
		category = 'organization';
	})
	
	originList(page, kwd, category);
	checkValues = new Array();
}

var disabled = function(add, remove) {
	if(category === add) {
		$("input[name=" + remove + "]").attr("disabled", true);
	} else if(category === '') {
		$("input[name=" + add + "]").removeAttr("disabled");
		$("input[name=" + remove + "]").removeAttr("disabled");
	} else {
		$("input[name=" + remove + "]").removeAttr("disabled");
	}
	category = '';
}

$(function() {
	originList('1', '', '');
	
	$(document).on("click", ".page", function() {
		page = $(this).attr('id');
		levelChecked(page, kwd);
	});
	
	$(document).on("click", ".prev", function() {
		page = $('span b').parent().attr('id');
		var prevNo = parseInt(page) - 1;
		page = String(prevNo);
		
		console.log(typeof(page) + " page: " + page + " / " + typeof(prevNo) + ":" + prevNo);
		
		levelChecked(page, kwd);
	});
	
	$(document).on("click", ".next", function() {
		page = $('span b').parent().attr('id');
		var prevNo = parseInt(page) + 1;
		page = String(prevNo);
		console.log(typeof(page) + " page: " + page + " / " + typeof(prevNo) + ":" + prevNo);
		levelChecked(page, kwd);
	});

	$('input[name=level]').change(function() {
		
		if($("input[name=level]").is(":checked")) {
			page = $('span b').parent().attr('id');
		} else {
			page = '1';
			category = '';
		}
		
		levelChecked(page, kwd);
		
		disabled('level','organization');
	});
	
	$('input[name=organization]').change(function() {
		page = $('span b').parent().attr('id');
		levelChecked(page, kwd);
		
		disabled('organization','level');
	});
	
	$('#search').on('click', function() {
		kwd = $('#kwd').val();
		levelChecked(page, kwd);
	});
});


</script>
</head>
<body>
    <c:import url="/WEB-INF/views/include/main-header.jsp" />
    <div class="content">
        <div class="menu-bar">
            <div class="algo">
                <table>
                    <tr id="title">
                        <th>알고리즘</th>
                    </tr>
                    <tr id="sub">
                        <td><input type="checkbox" id="one" name="level" value="one">
                            <label for="one"><span></span>level 1</label></td>
                    </tr>
                    <tr id="sub">
                        <td><input type="checkbox" id="two" name="level" value="two">
                            <label for="two"><span></span>level 2</label></td>
                    </tr>
                    <tr id="sub">
                        <td><input type="checkbox" id="three" name="level" value="three">
                            <label for="three"><span></span>level 3</label></td>
                    </tr>
                    <tr id="sub">
                        <td><input type="checkbox" id="four" name="level" value="four">
                            <label for="four"><span></span>level 4</label></td>
                    </tr>
                    <tr id="sub">
                        <td><input type="checkbox" id="five" name="level" value="five">
                            <label for="five"><span></span>level 5</label></td>
                    </tr>
                </table>
            </div>

            <div class="category">
                <table>
                    <tr id="title">
                        <th>분류</th>
                    </tr>
                    <tr id="sub">
                        <td><input type="checkbox" id="enterprise" name="organization" value="enterprise">
                            <label for="enterprise"><span></span>기업</label></td>
                    </tr>
                    <tr id="sub">
                        <td><input type="checkbox" id="individual" name="organization" value="individual">
                            <label for="individual"><span></span>개인</label></td>
                    </tr>
                    <tr id="sub">
                        <td><input type="checkbox" id="academy" name="organization" value="academy">
                            <label for="academy"><span></span>학원</label></td>
                    </tr>
                    <tr id="sub">
                        <td><input type="checkbox" id="school" name="organization" value="school">
                            <label for="school"><span></span>학교</label></td>
                    </tr>
                    <tr id="sub">
                        <td><input type="checkbox" id="other" name="organization" value="other">
                            <label for="other"><span></span>기타</label></td>
                    </tr>
                </table>
            </div>
        </div> <!-- div menu-bar -->

        <div class="list">
            <div class="search">
                <input type="text" id="kwd" name="kwd" placeholder="Search.." onKeyDown="onKeyDown();">
                <input type="button" id="search" value="검색" >
                <button class="make-problem" onclick="${pageContext.servletContext.contextPath }/training/write">문제작성</button>
            </div>
            <div class="problems">
            </div> <!-- div problems -->
        </div> <!-- div list -->
    </div>
<%-- 	<c:import url="/WEB-INF/views/include/footer.jsp" /> --%>
</body>

</html>