<%--
  Created by IntelliJ IDEA.
  User: gyurin
  Date: 17/08/2020
  Time: 4:14 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<%@ include file="../include/head.jsp" %>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <a href="${path}/">
            <b>GYURIN</b>&nbsp MVC-BOARD
        </a>
    </div>
    <!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg">로그인 페이지</p>
        <form action="${path}/user/loginPost" method="post">
            <div class="form-group has-feedback">
                <input type="text" name="userId" class="form-control" placeholder="아이디">
                <span class="glyphicon glyphicon-exclamation-sign form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" name="userPw" class="form-control" placeholder="비밀번호">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="row">
                <div class="col-xs-8">
                    <div class="checkbox icheck">
                        <label>
                            <input type="checkbox" name="iseCookie"> 로그인 유지
                        </label>
                    </div>
                </div>
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">
                        <i class="fa fa-sign-in"></i> 로그인
                    </button>
                </div>
            </div>
        </form>

        <div class="social-auth-links text-center">
            <p>- 또는 -</p>
            <a href="#" class="btn btn-block btn-social btn-facebook btn-flat">
                <i class="fa fa-facebook"></i> 페이스북으로 로그인
            </a>
            <a href="#" class="btn btn-block btn-social btn-google btn-flat">
                <i class="fa fa-google-plus"></i> 구글 계정으로 로그인
            </a>
        </div>

        <a href="#">비밀번호 찾기</a>
        <a href="${path}/user/register" class="text-center">회원가입</a>
    </div>
    <!-- /.login-box box -->
</div>
<!-- /.login box -->

<%@ include file="../include/plugin_js.jsp"%>
<script>
    var msg = "${msg}";
    if(msg==="REGISTERED")
        alert("회원가입이 완료되었습니다. 로그인해주세요:)");
    else if(msg==="FAILURE")
        alert("아이디와 비밀번호를 확인해주세요");

    $(function () {
        // TODO: TypeError: undefined is not a function (near '...$('input').iCheck...')
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    });
</script>
</body>
</html>
