<%--
  Created by IntelliJ IDEA.
  User: gyurin
  Date: 01/08/2020
  Time: 6:08 오후
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
                <small>목록페이지(페이징)</small>
            </h1>
            <ol class="breadcrumb">
                <li><i class="fa fa-edit"></i> article</li>
                <li class="active"><a href="${path}/article/paging/list"> list</a></li>
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
                        <h3 class="box-title">게시글 목록</h3>
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered">
                            <tbody>
                            <tr>
                                <th style="width: 30px">#</th>
                                <th>제목</th>
                                <th style="width: 100px">작성자</th>
                                <th style="width: 150px">작성시간</th>
                                <th style="width: 60px">조회</th>
                            </tr>
                            <c:forEach items="${articles}" var="article">
                                <tr>
                                    <td>${article.articleNo}</td>
                                    <%-- <td><a href="${path}/article/read?articleNo=${article.articleNo}">${article.title}</a></td> --%>
                                    <%-- [08] UriComponentsBuilder를 이용한 페이징 처리 개선--%>
                                    <td>
                                        <a href="${path}/article/paging/read${pageMaker.makeQuery(pageMaker.criteria.page)}&articleNo=${article.articleNo}">
                                            ${article.title}
                                        </a>
                                    </td>
                                    <td>${article.writer}</td>
                                    <td><fmt:formatDate value="${article.regDate}" pattern="yyyy-MM-dd a HH:mm"/></td>
                                    <td><span class="badge bg-red">${article.viewCnt}</span></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="box-footer">
                        <div class="pull-right">
                            <button type="button" class="btn btn-success btn-flat" id="writeBtn">
                                <i class="fa fa-pencil"></i> 글쓰기
                            </button>
                        </div>
                    </div>
                    <div class="box-footer">
                        <div class="text-center">
                            <form id="listPageForm">
                                <input type="hidden" name="page" value="${pageMaker.criteria.page}">
                                <input type="hidden" name="perPageNum" value="${pageMaker.criteria.perPageNum}">
                            </form>
                            <ul class="pagination">
                                <c:if test="${pageMaker.prev}">
                                    <%-- <li><a href="${path}/article/list?page=${pageMaker.startPage-1}">이전</a> </li> --%>
                                    <%-- [08] UriComponentsBuilder를 이용한 페이징 처리 개선--%>
                                    <!--<li>
                                        <a href="${path}/article/list${pageMaker.makeQuery(pageMaker.startPage-1)}">
                                            이전
                                        </a>
                                    </li>-->
                                    <%-- [08] javascript를 이용한 페이징 처리 개선--%>
                                    <li><a href="${pageMaker.startPage-1}">이전</a></li>
                                </c:if>
                                <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
                                    <li <c:out value="${pageMaker.criteria.page==idx?'class=active':''}"/> >
                                        <%-- <a href="${path}/article/list?page=${idx}">${idx}</a> --%>
                                        <%-- [08] UriComponentsBuilder를 이용한 페이징 처리 개선--%>
                                        <!-- <a href="${path}/article/list${pageMaker.makeQuery(idx)}">${idx}</a>-->
                                        <%-- [08] javascript를 이용한 페이징 처리 개선--%>
                                        <a href="${idx}">${idx}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${pageMaker.next && pageMaker.endPage>0}">
                                    <%-- <li><a href="${path}/article/list?page=${pageMaker.endPage+1}">다음</a> </li> --%>
                                    <%-- [08] UriComponentsBuilder를 이용한 페이징 처리 개선--%>
                                    <!--
                                    <li>
                                        <a href="${path}/article/list?${pageMaker.makeQuery(pageMaker.endPage+1)}">
                                            다음
                                        </a>
                                    </li>
                                    -->
                                    <%-- [08] javascript를 이용한 페이징 처리 개선--%>
                                    <li><a href="${pageMaker.endPage+1}">다음</a> </li>
                                </c:if>
                            </ul>
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

<%@ include file="../../include/plugin_js.jsp"%>

<script>
    $(".pagination li a").on("click", function (event) {
        event.preventDefault();

        var targetPage = $(this).attr("href");
        var listPageForm = $("#listPageForm");
        listPageForm.find("[name='page']").val(targetPage);
        console.log(targetPage);
        listPageForm.attr("action", "list").attr("method", "get");
        listPageForm.submit();
    });

    $("#writeBtn").on("click", function () {
        self.location = "write";
    });
</script>

</body>
</html>