<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Code Forest</title>
    <link rel="stylesheet" href="./account.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script type="text/javascript" src="./jquery-3.4.1.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(function() {
            $("#change-nickname").dialog({
                autoOpen: false,
                resizable: false,
                height: "auto",
                width: 400,
                modal: true,
                buttons: {
                    "완료": function() {
                        $(this).dialog("close");
                    },
                    Cancel: function() {
                        $(this).dialog("close");
                    }
                }
            });
            $("#nickname-btn").on("click", function() {
                $("#change-nickname").dialog("open");
            });

            $("#delete-user").dialog({
                autoOpen: false,
                resizable: false,
                height: "auto",
                width: 400,
                modal: true,
                buttons: {
                    "회원 탈퇴": function() {
                        $(this).dialog("close");
                    },
                    "취소": function() {
                        $(this).dialog("close");
                    }
                }
            });
            $("#delete-btn").on("click", function() {
                $("#delete-user").dialog("open");
            });

            $("#change-password").dialog({
                autoOpen: false,
                resizable: false,
                height: "auto",
                width: 400,
                modal: true,
                buttons: {
                    "변경": function() {
                        $(this).dialog("close");
                    },
                    "취소": function() {
                        $(this).dialog("close");
                    }
                }
            });
            $("#password-btn").on("click", function() {
                $("#change-password").dialog("open");
            });
        });
    </script>
</head>

<body>
    <div class="header">
        <div class="head">
            <div class="container-left clearfix">
                <div class="logo">
                    <h3>Code Forest</h3>
                </div>
                <div class="menu clearfix">
                    <div class="menu-item">에옹이</div>
                    <div class="menu-item">로그아웃</div>
                </div>
            </div>
        </div>
    </div>
    <div class="sidemenu">
        <nav>
            <ul>
                <li class="menulist"><a href="">마이페이지</a></li>
                <li class="menulist"><a href="">계정 관리</a></li>
                <li class="menulist"><a href="">문제 관리</a></li>
            </ul>
        </nav>
    </div>
    <div class="container">
        <div class="nickname">
            <div class="line">
                <h4>닉네임 변경</h4>
            </div>
            <button id="nickname-btn">변경</button>
        </div>
        <div class="password">
            <div class="line">
                <h4>비밀번호 변경</h4>
            </div>
            <button id="password-btn">비밀번호 변경</button>
        </div>
        <div class="disclosure">
            <div class="line">
                <h4>계정 공개 여부</h4>
            </div>
            <h4>계정 비공개를 설정하시겠습니까?</h4>
            계정 공개를 설정하시면 문제를 푼 기록, 팔로우와 관련된 모든 기록을 다른 사람이 열람 할 수 있습니다.

            </p>
            <input type="radio" name="chk_info" value="Oepn" checked="checked">공개
            <input type="radio" name="chk_info" value="Private">비공개
        </div>
        <div class="delete">
            <div class="line">
                <h4>계정 삭제</h4>
            </div>
            <h4>회원 탈퇴를 하시겠습니까?</h4>
            <p>
                회원 탈퇴를 하시면 문제를 푼 기록이 다 사라집니다.
            </p>
            <button id="delete-btn" style="color: red;">회원 탈퇴</button>
        </div>
    </div>

    <div id="change-nickname" title="닉네임 변경">
        변경하실 닉네임을 입력해주세요.
        <form>
            <fieldset>
                <label for="name">닉네임 입력 : </label>
                <input type="text" name="name" id="name" value="에옹이" class="text ui-widget-content ui-corner-all">

                <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
            </fieldset>
        </form>
    </div>

    <div id="change-password" title="비밀번호 변경">
        <pre>
            비밀번호를 변경하시려면 현재 비밀번호를 입력해주세요.
        </pre>
        <form>
            <fieldset>
                <label for="name">현재 비밀번호 : </label>
                <input type="text" name="password" id="password" value="" class="text ui-widget-content ui-corner-all">
            </fieldset>
        </form>
        <pre>
            변경하시려는 비밀번호를 입력해주세요.
        </pre>
        <form>
            <fieldset>
                <label for="name">변경 비밀번호 : </label>
                <input type="text" name="password" id="password" value="" class="text ui-widget-content ui-corner-all">
                <label for="name">비밀번호 확인: </label>
                <input type="text" name="password" id="password" value="" class="text ui-widget-content ui-corner-all">

                <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
            </fieldset>
        </form>
    </div>

    <div id="delete-user" title="회원 탈퇴">
        <pre>
            회원 탈퇴를 하시겠습니까?
            회원 탈퇴를 하시면 문제를 푼 기록이 다 사라집니다.
            아래 비밀번호를 입력하세요.
        </pre>
        <form>
            <fieldset>
                <label for="name">비밀번호 입력 : </label>
                <input type="text" name="delete" id="delete" value="" class="text ui-widget-content ui-corner-all">

                <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
            </fieldset>
        </form>
    </div>

</body>

</html>