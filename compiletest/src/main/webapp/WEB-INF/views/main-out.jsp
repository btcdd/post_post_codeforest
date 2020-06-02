<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Code Forest</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath }/assets/css/main/main-out.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- code mirror -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/css/codemirror.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/abcdef.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/blackboard.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/dracula.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/duotone-light.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/eclipse.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/moxer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/neat.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/panda-syntax.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/solarized.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/codemirror/theme/ttcn.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/codemirror/js/codemirror.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/codemirror/mode/clike.js"></script>

<script>
$(function() {
	
   var save = false;
   $(".codeTest").submit(function(event) {
      event.preventDefault();
      var lang = $("select option:selected").val();
      
      var code = editor.getValue();

      $.ajax({
         url: '${pageContext.request.contextPath }/compile/' + lang,
         async: true,
         type: 'post',
         dataType: 'json',
         data: {code:code},
         success: function(response){
            if(response.result != "success") {
               console.error(response.message);
               return;
            }
            if(response.data[1] != "") {
               console.log("data[1]\n" + response.data[1]);
               $("#result").val(response.data[1]);
            } else {
               console.log("data[0]\n" + response.data[0]);
               $('#result').val(response.data[0]);
            }
         
         },
         error: function(xhr, status, e) {
            console.error(status + ":" + e);
         }
      });
   });
   
   var code = $('.CodeMirror')[0];
   var editor = CodeMirror.fromTextArea(code, {
   		lineNumbers: true,
   		mode: 'text/x-java',
   		theme: 'panda-syntax',
   		matchBrackets: true
   });
   
   $('.theme').click(function() {
	   var theme = $(".theme option:selected").val();
	   
	   editor.setOption("theme", theme);
   });
   
   $('.lang').change(function() {
	   var lang = $(".lang option:selected").val();
	   var face = '';
	   
	   if(lang === 'c') {
		   face = '#include <stdio.h>\n\n' + 
			   'int main() {\n' + 
			   	'\tprintf("Hello CodeForest!\\n");\n\n' + 
			   	'\treturn 0;\n' + 
			   '}';
	   } else if(lang === 'cpp') {
		   face = '#include <iostream>\n\n' + 
			   		'using namespace std;\n\n' + 
			   'int main()\n' + 
			   '{\n' + 
			       '\tcout << "Hello CodeForest!" << endl;\n\n' + 
			       '\treturn 0;\n' + 
			   '}';
	   } else if(lang === 'cs') {
		   face = 'using System;\n\n' + 
			   		'class HelloWorld {\n\n' + 
			     	'\tstatic void Main() {\n' +  
			       '\t\tConsole.WriteLine("Hello CodeForest");\n' + 
			     '\t}\n' + 
			   '}';
	   } else if(lang === 'java') {
		   face = '/*\n' + 
	   		"* 기본 언어 : 'JAVA'\n" + 
		   "* 기본 테마 : 'panda-syntax'\n" + 
		   '*/\n' + 
		  'public class Test{\n' + 
		  		'\tpublic static void main(String[] args) {\n' + 
		      		'\t\tSystem.out.println("Hello CodeForest!");\n' + 
		      '\t}\n' + 
		  '}\n';
	   } else if(lang === 'js') {
		   face = 'var str = "Hello CodeForest";\n\n' + 
		   			'console.log(str);';
	   } else if(lang === 'py') {
		   face = 'print("Hello World")';
	   }
	   
	   editor.setValue(face);
   });
   
 	$('.CodeMirror').addClass('code');
});

</script>
</head>
<body>
	<div class="head-image">
		<div class="user">
			<ul>
				<c:choose>
					<c:when test="${empty authUser }">
						<li><a href="${pageContext.request.contextPath }/user/login">LOGIN</a><li>
						<li><a href="${pageContext.request.contextPath }/user/join">JOIN</a><li>
					</c:when>
					<c:otherwise>
						<li><a href="${pageContext.request.contextPath }/mypage/mypage">회원정보수정</a><li>
						<li><a href="${pageContext.request.contextPath }/user/logout">로그아웃</a><li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		<div class="navigator">
			<nav>
				<ul>
					<li class="menu"><a href="#">Info</a></li>
					<li class="menu"><a href="#">Code Tree</a></li>
					<li class="title"><a>Code Forest</a></li>
					<li class="menu"><a href="#">Coding Test</a></li>
					<li class="menu"><a href="#">Training</a></li>
				</ul>
			</nav>
		</div>
		<div class="intro">
			<p>온라인에서</p>
			<p>쉽고 간단하게</p>
			<p class="end">코딩을 시작해보세요</p>
		</div>
		<a  class="join-btn" href="${pageContext.request.contextPath }/user/login">Get Started</a>
	</div>
	<div class="codeTest">
        <form action="" method="post">
            <table class="tbl-ex">
               <tr>
                  <td>
	                  <select class="lang" name="lang">
	                      <option value="c">C</option>
	                      <option value="cpp">C++</option>
	                      <option value="cs">C#</option>
	                      <option value="java" selected="selected">JAVA</option>
	                      <option value="js">JavaScript</option>
	                      <option value="py">Python</option>
	                  </select>
                  </td>
                  <td>
	                  <select class="theme" name="theme">
	                  	<optgroup label="black">
	                      <option value="abcdef">abcdef</option>
	                      <option value="blackboard">blackboard</option>
	                      <option value="dracula">dracula</option>
	                      <option value="moxer">moxer</option>
	                      <option value="panda-syntax" selected="selected">panda-syntax</option>
	                    </optgroup>
	                    <optgroup label="white">
	                      <option value="duotone-light">duotone-light</option>
	                      <option value="eclipse">eclipse</option>
	                      <option value="neat">neat</option>
	                      <option value="ttcn">ttcn</option>
	                      <option value="solarized">solarized</option>
	                    </optgroup>
	                  </select>
                  </td>
                  <td>
	                <span style="float: left;">
	                  <input type="submit" class="btn-run" value="실행">
	                </span>
	              </td>
               </tr>
               <tr>
                  <td colspan="4">
                      <textarea name="code" class="CodeMirror code" id="code">
/*
* 기본 언어 : 'JAVA'
* 기본 테마 : 'panda-syntax'
*/
public class Test{
	public static void main(String[] args) {
		System.out.println("Hello CodeForest!");
	}
}</textarea>
                  </td>
                  <td>
                     <textarea name="" id="result" readonly></textarea>
                  </td>
               </tr>
            </table>
         </form>
    </div>
    

</body>
</html>