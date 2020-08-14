<%--
  Created by IntelliJ IDEA.
  User: gyurin
  Date: 05/08/2020
  Time: 3:10 오후
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<%@ include file="../../include/head.jsp"%>
<!-- [15] 파일 업로드 영역 -->
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
                <small>입력페이지(페이징+검색)</small>
            </h1>
            <ol class="breadcrumb">
                <li><i class="fa fa-edit"></i> article</li>
                <li class="active"><a href="${path}/article/paging/search/write"> write</a></li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">

            <div class="col-lg-12">
                <form role="form" id="writeForm" method="post" action="${path}/article/paging/search/write">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">게시글 작성</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group">
                                <label for="title">제목</label>
                                <input class="form-control" id="title" name="title" placeholder="제목 입력">
                            </div>
                            <div class="form-group">
                                <label for="content">내용</label>
                                <textarea class="form-control" id="content" name="content" rows="30" placeholder="내용 입력" style="resize: none;"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="writer">작성자</label>
                                <input class="form-control" id="writer" name="writer">
                            </div>
                            <%-- [15-5] 첨부파일 영역 추가 --%>
                            <div class="form-group">
                                <div class="fileDrop">
                                    <br/>
                                    <br/>
                                    <br/>
                                    <br/>
                                    <p class="text-center"><i class="fa fa-paperclip"></i> 첨부파일을 드래그해주세요</p>
                                </div>
                            </div>
                        </div>
                        <%-- [15-5] 첨부파일 영역 추가 --%>
                        <div class="box-footer">
                            <ul class="mailbox-attachments clearfix uploadedFileList"></ul>
                        </div>
                        <div class="box-footer">
                            <button type="button" class="btn btn-primary listBtn"><i class="fa fa-list"></i> 목록</button>
                            <div class="pull-right">
                                <button type="reset" class="btn btn-warning"><i class="fa fa-reply"></i> 초기화</button>
                                <button type="submit" class="btn btn-success"><i class="fa fa-save"></i> 저장</button>
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
<%-- [15-5] 첨부파일 출력을 위한 Handlebars 템플릿 --%>
<script id="fileTemplate" type="text/x-handlebars-template">
    <li>
        <span class="mailbox-attachment-icon has-img">
            <img src="{{imgSrc}}" alt="Attachment">
        </span>
        <div class="mailbox-attachment-info">
            <a href="{{originalFileUrl}}" class="mailbox-attachment-name">
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

        $(".listBtn").on("click", function () {
            self.location = "list?page=${searchCriteria.page}"
                + "&perPageNum=${searchCriteria.perPageNum}"
                + "&searchType=${searchCriteria.searchType}"
                + "&keyword=${searchCriteria.keyword}";
        });

        $("#writeForm").submit(function (event) {
            event.preventDefault();
            var that = $(this);
            filesSubmit(that);
        })

        // 첨부파일 삭제 버튼 클릭
        $(document).on("click", ".delBtn", function (event) {
            event.preventDefault();
            var that = $(this);
            deleteFileWrtPage(that);
        });

    });
</script>
</body>
</html>

