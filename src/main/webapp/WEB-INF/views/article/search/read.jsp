<%--
  Created by IntelliJ IDEA.
  User: gyurin
  Date: 05/08/2020
  Time: 3:11 오후
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<%@ include file="../../include/head.jsp"%>

<body class="hold-transition skin-blue sidebar-mini layout-boxed">
<div class="wrapper">

    <!-- Main Header -->
    <%@ include file="../../include/main_header.jsp"%>
    <!-- Left side column. contains the logo and sidebar -->
    <%@ include file="../../include/left_column.jsp"%>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                게시판
                <small>조회페이지(페이징+검색)</small>
            </h1>
            <ol class="breadcrumb">
                <li><i class="fa fa-edit"></i> article</li>
                <li class="active"><a href="${path}/article/paging/search/read"> read</a></li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">

            <!--------------------------
              | Your Page Content Here |
              -------------------------->
            <div class="col-lg-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">글 제목: ${article.title}</h3>
                    </div>
                    <div class="box-body" style="height: 700px">
                        ${article.content}
                    </div>
                    <div class="box-footer">
                        <div class="user-block">
                            <img class="img-circle img-bordered-sm" src="dist/img/user1-128x128.jpg" alt="user image">
                            <span class="username">
                                <a href="#">${article.writer}</a>
                            </span>
                            <span class="description"><fmt:formatDate value="${article.regDate}" pattern="yyyy-MM-dd a HH:mm" /></span>
                        </div>
                    </div>
                    <div class="box-footer">
                        <form role="form" method="post">
                            <input type="hidden" name="articleNo" value="${article.articleNo}">
                            <input type="hidden" name="page" value="${searchCriteria.page}">
                            <input type="hidden" name="perPageNum" value="${searchCriteria.perPageNum}">
                            <input type="hidden" name="searchType" value="${searchCriteria.searchType}">
                            <input type="hidden" name="keyword" value="${searchCriteria.keyword}">
                        </form>
                        <button type="submit" class="btn btn-primary listBtn"><i class="fa fa-list"></i> 목록</button>
                        <div class="pull-right">
                            <button type="submit" class="btn btn-warning modBtn"><i class="fa fa-edit"></i> 수정</button>
                            <button type="submit" class="btn btn-danger delBtn"><i class="fa fa-trash"></i> 삭제</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!-- Main Footer -->
    <%@ include file="../../include/main_footer.jsp"%>

</div>
<!-- ./wrapper -->

<%@ include file="../../include/plugin_js.jsp"%>
<script>
    $(document).ready(function () {
        var formObj = $("form[role='form']");

        $(".modBtn").on("click", function () {
            formObj.attr("action", "modify");
            formObj.attr("method", "get");
            formObj.submit();
        });

        $(".delBtn").on("click", function () {
            formObj.attr("action", "remove");
            formObj.submit();
        });

        $(".listBtn").on("click", function () {
            formObj.attr("action", "list");
            formObj.attr("method", "get");
            formObj.submit();
        });

    });
</script>
</body>
</html>