<%--
  Created by IntelliJ IDEA.
  User: gyurin
  Date: 05/08/2020
  Time: 3:09 오후
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<%@ include file="../../include/head.jsp"%>
<style>
    .fileDrop{
        width: 100%;
        height: 200px;
        border: 2px dotted #0b58a2;
    }
</style>

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
                <small>수정페이지(페이징+검색)</small>
            </h1>
            <ol class="breadcrumb">
                <li><i class="fa fa-edit"></i> article</li>
                <li class="active"><a href="${path}/article/paging/search/modify"> modify</a></li>
            </ol>
        </section>


        <!-- Main content -->
        <section class="content container-fluid">

            <!--------------------------
              | Your Page Content Here |
              -------------------------->
            <div class="col-lg-12">
                <form role="form" id="modifyForm" method="post" action="${path}/article/paging/search/modify">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">게시글 작성</h3>
                        </div>
                        <div class="box-body">
                            <input type="hidden" name="articleNo" value="${article.articleNo}">
                            <input type="hidden" name="page" value="${searchCriteria.page}">
                            <input type="hidden" name="perPageNum" value="${searchCriteria.perPageNum}">
                            <input type="hidden" name="searchType" value="${searchCriteria.searchType}">
                            <input type="hidden" name="keyword" value="${searchCriteria.keyword}">
                            <div class="form-group">
                                <label for="title">제목</label>
                                <input class="form-control" id="title" name="title" placeholder="제목 입력" value="${article.title}">
                            </div>
                            <div class="form-group">
                                <label for="content">내용</label>
                                <textarea class="form-control" id="content" name="content" rows="30" placeholder="내용 입력" style="resize: none;">${article.content}</textarea>
                            </div>
                            <div class="form-group">
                                <label for="writer">작성자</label>
                                <input class="form-control" id="writer" name="writer" value="${article.writer}" readonly>
                            </div>
                            <%-- [15-7] --%>
                            <div class="form-group">
                                <div class="fileDrop">
                                    <br/>
                                    <br/>
                                    <br/>
                                    <br/>
                                    <p class="text-center"><i class="fa fa-paperclip"></i> 첨부파일을 드래그해주세요.</p>
                                </div>
                            </div>
                        </div>
                        <div class="box-footer">
                            <ul class="mailbox-attachments clearfix uploadedFileList"></ul>
                        </div>
                        <div class="box-footer">
                            <button type="button" class="btn btn-primary listBtn"><i class="fa fa-list"></i> 목록</button>
                            <div class="pull-right">
                                <button type="button" class="btn btn-warning cancelBtn"><i class="fa fa-trash"></i> 취소</button>
                                <button type="submit" class="btn btn-success modBtn"><i class="fa fa-save"></i> 수정 저장</button>
                            </div>
                        </div>
                    </div>
                </form>
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
<script id="fileTemplate" type="text/x-handlebars-template">
    <li>
        <span class="mailbox-attachment-icon has-img">
            <img src="{{imgSrc}}" alt="Attachment">
        </span>
        <div class="mailbox-attachment-info">
            <a href="{{originalFileUrl}}" class="mailbox-attachments-name">
                <i class="fa fa-paperclip"></i> {{originalFileName}}
            </a>
            <a href="{{fullName}}" class="btn btn-default btn-xs pull-right delBtn">
                <i class="fa fa-fw fa-remove"></i>
            </a>
        </div>
    </li>
</script>

<script type="text/javascript" src="dist/js/article_file_upload.js"></script>

<script>
    $(document).ready(function () {
        var formObj = $("form[role='form']");
        console.log(formObj);

        $(".modBtn").on("click", function () {
            formObj.submit();
        });
        $(".cancelBtn").on("click", function () {
            self.location = "read?page=${searchCriteria.page}"
                + "&perPageNum=${searchCriteria.perPageNum}"
                + "&searchType=${searchCriteria.searchType}"
                + "&keyword=${searchCriteria.keyword}"
                + "&articleNo=${article.articleNo}";
        });
        $(".listBtn").on("click", function () {
            self.location = "list?page=${searchCriteria.page}"
            + "&perPageNum=${searchCriteria.perPageNum}"
            + "&searchType=${searchCriteria.searchType}"
            + "&keyword=${searchCriteria.keyword}";
        });

        <%-- [15-7] 첨부파일 --%>
        var articleNo = "${article.articleNo}";

        // 첨부파일 삭제 버튼 클릭
        $(document).on("click", ".delBtn", function (event) {
            event.preventDefault();
            if(confirm("첨부파일을 삭제하시겠습니까? 삭제된 파일은 복구할 수 없습니다.")){
                var that = $(this);
                deleteFileModPage(that, articleNo);
            }
        });

        // 첨부파일 목록 호출
        getFiles(articleNo);

        // 수정 처리시 첨부파일 정보 처리
        $("#modifyForm").submit(function (event) {
            event.preventDefault();
            var that = $(this);
            filesSubmit(that);
        });
    });
</script>
</body>
</html>