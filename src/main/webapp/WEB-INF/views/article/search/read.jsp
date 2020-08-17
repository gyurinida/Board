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
                    <!-- [15-6] 업로드 파일 정보 영역 -->
                    <div class="box-footer uploadFiles">
                        <ul class="mailbox-attachments clearfix uploadedFileList"></ul>
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
                    <!-- [12-2] 댓글 입력 -->
                    <div class="box-warning">
                        <div class="box-header with-border">
                            <a class="link-black text-lg"><i class="fa fa-pencil"></i> 댓글작성</a>
                        </div>
                        <div class="box-body">
                            <form class="form-horizontal">
                                <div class="form-group margin">
                                    <div class="col-sm-10">
                                        <textarea class="form-control" id="newReplyText" rows="3" placeholder="댓글 내용.." style="resize: none"></textarea>
                                    </div>
                                    <div class="col-sm-2">
                                        <input class="form-control" id="newReplyWriter" type="text" placeholder="댓글 작성자..">
                                    </div>
                                    <hr/>
                                    <div class="col-sm-2">
                                        <button type="button" class="btn btn-primary btn-block replyAddBtn"><i class="fa fa-save"></i> 저장</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- [12-2] 댓글 목록/페이징 -->
                    <div class="box box-success collapsed-box">
                        <div class="box-header with-border">
                            <%--댓글 유무 / 댓글 갯수 / 댓글 펼치기,접기--%>
                            <a href="" class="link-black text-lg"><i class="fa fa-comments-o margin-r-5 replyCount"></i> </a>
                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </div>
                        </div>
                        <%--댓글 목록--%>
                        <div class="box-body repliesDiv">

                        </div>
                        <%--댓글 페이징--%>
                        <div class="box-footer">
                            <div class="text-center">
                                <ul class="pagination pagination-sm no-margin">

                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- [12-2] 댓글 수정 modal -->
                    <div class="modal fade" id="modModal">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="model-header">
                                    <button type="button" class="close" date-dimiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <h4 class="modal-title">댓글 수정</h4>
                                </div>
                                <div class="modal-body" data-rno>
                                    <input type="hidden" class="replyNo" />
                                    <%-- <input type="text" id="replytext" class="form-control" /> --%>
                                    <textarea class="form-control" id="replyText" rows="3" style="resize: none"></textarea>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default pull-left exitModBtn" date-dimiss="modal">닫기</button>
                                    <button type="button" class="btn btn-primary modalModBtn">수정</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- [12-2] 댓글 삭제 modal -->
                    <div class="modal fade" id="delModal">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" date-dimiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <h4 class="modal-title">댓글 삭제</h4>
                                    <input type="hidden" class="rno" />
                                </div>
                                <div class="modal-body" data-rno>
                                    <p>댓글을 삭제하겠습니까?</p>
                                    <input type="hidden" class="rno" />
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default pull-left exitDelBtn" date-dimiss="modal">아니요</button>
                                    <button type="button" class="btn btn-primary modalDelBtn">네. 삭제!</button>
                                </div>
                            </div>
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
<script id="replyTemplate" type="text/x-handlebars-template">
    {{#each.}}
    <div class="post replyDiv" data-replyNo={{replyNo}}>
        <div class="user-block">
            <img class="img-circle img-bordered-sm" src="/freeboard01_war_exploded/dist/img/user1-128x128.jpg" alt="user image">
            <span class="username">
                <a href="#">{{replyWriter}}</a>
                <a href="#" class="pull-right btn-box-tool replyDelBtn" data-toggle="modal" data-target="#delModal">
                    <i class="fa fa-times"> 삭제</i>
                </a>
                <a href="#" class="pull-right btn-box-tool replyModBtn" data-toggle="modal" data-target="#modModal">
                    <i class="fa fa-edits"> 수정</i>
                </a>
            </span>
            <span class="description">{{prettifyDate regDate}}</span>
        </div>
        <div class="oldReplyText">{{{escape replyText}}}</div>
        <br/>
    </div>
    {{/each}}
</script>
<%-- [15-6] 게시글 첨부파일 Handlerbars 파일 템플릿 --%>
<script id="fileTemplate" type="text/x-handlebars-template">
    <li data-src="{{fullName}}">
        <span class="mailbox-attachment-icon has-img">
            <img src="{{imgSrc}}" alt="Attachment">
        </span>
        <div class="mailbox-attachment-info">
            <a href="{{originalFileUrl}}" class="mailbox-attachment-name">
                <i class="fa fa-paperclip"></i> {{originalFileName}}
            </a>
        </div>
    </li>
</script>
<script type="text/javascript" src="dist/js/article_file_upload.js"></script>
<script>
    $(document).ready(function () {

        <%-- [11-2] 댓글 목록 --%>
        var articleNo = "${article.articleNo}"; // 현재 게시글 번호
        var replyPageNum = 1;                   // 댓글 페이지 번호 초기화

        // [15-6] 첨부파일 목록 출력
        getFiles(articleNo);

        // 댓글 내용: 줄바꿈/공백
        Handlebars.registerHelper("escape", function (replyText) {
            var text = Handlebars.Utils.escapeExpression(replyText);
            text = text.replace(/(\r\n|\n|\r)/gm, "<br/>");
            text = text.replace(/( )/gm, "&nbsp;");
            return new Handlebars.SafeString(text);
        });

        // 댓글 등록일자: 날짜/시간 2자기 맞추기
        Handlebars.registerHelper("prettifyDate", function (timeValue) {
            var dateObj = new Date(timeValue);
            var year = dateObj.getFullYear();
            var month = dateObj.getMonth()+1;
            var date = dateObj.getDate();
            var hours = dateObj.getHours();
            var minutes = dateObj.getMinutes();

            // 두자리로 변환
            month<10?month='0'+month:month;
            date<10?date='0'+date:date;
            hours<10?hours='0'+hours:hours;
            minutes<10?minutes='0'+minutes:minutes;

            return year+"-"+month+"-"+date+"-"+hours+"-"+minutes;
        });

        // 댓글 목록 함수 호출
        getReplies("/freeboard01_war_exploded/replies/"+articleNo+"/"+replyPageNum);

        // 댓글 목록 함수
        function getReplies(repliesUri) {
            $.getJSON(repliesUri, function (data) {
                printReplyCount(data.pageMaker.totalCount);
                printReplies(data.replies, $(".repliesDiv"), $("#replyTemplate"));
                printReplyPaging(data.pageMaker, $(".pagination"));
            });
        }

        // 댓글 갯수 출력 함수
        function printReplyCount(totalCount) {
            var replyCount = $(".replyCount");
            var collapsedBox = $(".collapsed-box");

            // 댓글 없음
            if(totalCount==0){
                replyCount.html("댓글이 없습니다. 의견을 남겨주세요");
                collapsedBox.find(".btn-box-tool").remove();
                return;
            }

            // 댓글 존재
            replyCount.html(" 댓글 목록 ("+totalCount+")");
            collapsedBox.find(".box-tools").html(
                "<button type='button' class='btn btn-box-tool' data-widget='collapse'>"
                + "<i class='fa fa-plus'></i>"
                + "</button>"
            );
        }

        // 댓글 목록 출력 함수
        function printReplies(replyArr, targetArea, templateObj) {
            var replyTemplate = Handlebars.compile(templateObj.html());
            var html = replyTemplate(replyArr);
            $(".replyDiv").remove();
            targetArea.html(html);
        }

        // 댓글 페이징 출력
        function printReplyPaging(pageMaker, targetArea) {
            var str = "";

            // 이전 버튼
            if(pageMaker.prev){
                str += "<li><a href='"+(pageMaker.startPage-1)+"'>이전</a></li>";
            }

            // 페이지 번호 버튼
            for(var i = pageMaker.startPage, len=pageMaker.endPage; i<=len; i++){
                var strClass = pageMaker.criteria.page==i?'class=active':'';
                str += "<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
            }

            // 다음 버튼
            if(pageMaker.next){
                str += "<li><a href='"+(pageMaker.endPage+1)+"'>다음</a></li>";
            }

            targetArea.html(str);
        }

        // 댓글 페이지 번호 클릭 이벤트
        $(".pagination").on("click", "li a", function (event) {
            event.preventDefault();
            replyPageNum = $(this).attr("href");
            getReplies("/freeboard01_war_exploded/replies/"+articleNo+"/"+replyPageNum);
        })

        <%-- [11-2] 댓글 등록 --%>
        // 댓글 저장 버튼 클릭 이벤트
        $(".replyAddBtn").on("click", function () {
            var replyWriterObj = $("#newReplyWriter");
            var replyTextObj = $("#newReplyText");
            var replyWriter = replyWriterObj.val();
            var replyText = replyTextObj.val();

            // POST
            $.ajax({
                type: "post",
                url: "/freeboard01_war_exploded/replies/",
                headers: {
                    "Content-type": "application/json",
                    "X-HTTP-Method-Override": "POST"
                },
                dataType: "text",
                data: JSON.stringify({
                    articleNo: articleNo,
                    replyText: replyText,
                    replyWriter: replyWriter
                }),
                success: function(result){
                    console.log("result: " +result);
                    if(result=="regSuccess"){
                        alert("댓글이 등록되었습니다.");
                        replyPageNum = 1;
                        getReplies("/freeboard01_war_exploded/replies/"+articleNo+"/"+replyPageNum);

                        replyTextObj.val("");   // 댓글 내용 초기화
                        replyWriterObj.val(""); // 댓글 작성자 초기화
                    }
                }
            });
        })

        <%-- [11-2] 댓글 수정/삭제 --%>
        // 댓글 수정 위해 modal창에 값 불러오기
        $(".repliesDiv").on("click", ".replyDiv", function (event) {
            var reply = $(this);
            $(".replyNo").val(reply.attr("data-replyNo"));
            $("#replyText").val(reply.find(".oldReplyText").text());
        });

        // modal창 x로 닫기 이벤트
        $(".close").on("click", function () {
            $(".modal").modal("hide");
        })

        // modal -> 댓글 수정 버튼 클릭 이벤트
        $(".modalModBtn").on("click", function () {

            var replyNo = $(".replyNo").val();
            var replyText = $("#replyText").val();

            // PUT
            $.ajax({
                type: "put",
                url: "/freeboard01_war_exploded/replies/" + replyNo,
                headers: {
                    "Content-type": "application/json",
                    "X-HTTP-Method-Override": "PUT"
                },
                data: JSON.stringify({
                    replyText: replyText
                }),
                dataType: "text",
                success: function(result){
                    console.log("result: "+ result);
                    if(result=="modSuccess"){
                        alert("댓글이 수정되었습니다.");
                        getReplies("/freeboard01_war_exploded/replies/"+articleNo+"/"+replyPageNum); // 댓글 목록 갱신
                        $("#modModal").modal("hide"); // Modal 닫기
                    }
                }
            });
        });

        $(".exitModBtn").on("click", function () {
            $("#modModal").modal("hide");
        })

        // modal -> 댓글 삭제 버튼 클릭 이벤트
        $(".modalDelBtn").on("click", function () {

            var replyNo = $(".replyNo").val();

            // DELETE
            $.ajax({
                type: "delete",
                url: "/freeboard01_war_exploded/replies/" + replyNo,
                headers: {
                    "Content-type": "application/json",
                    "X-HTTP-Method-Override": "DELETE"
                },
                dataType: "text",
                success: function(result){
                    console.log("result: "+ result);
                    if(result=="delSuccess"){
                        alert("댓글이 삭제되었습니다.");
                        getReplies("/freeboard01_war_exploded/replies/"+articleNo+"/"+replyPageNum); // 댓글 목록 갱신
                        $("#delModal").modal("hide"); // Modal 닫기
                    }
                }
            });
        });

        $(".exitDelBtn").on("click", function () {
            $("#delModal").modal("hide");
        })

        <%--  게시글 수정, 삭제, 목록 버튼 --%>
        var formObj = $("form[role='form']");

        $(".modBtn").on("click", function () {
            formObj.attr("action", "modify");
            formObj.attr("method", "get");
            formObj.submit();
        });

        $(".delBtn").on("click", function () {

            // 댓글이 달린 게시글 삭제처리 방지
            var replyCnt = $(".replyDiv").length;
            if(replyCnt>0){
                alert("댓글이 달린 게시글은 삭제할 수 없습니다.");
                return;
            }

            // 첨부파일명들을 배열에 저장
            var arr = [];
            $(".uploadedFileList li").each(function () {
                arr.push($(this).attr("data-src"));
            });

            // 첨부파일 삭제 요청
            if(arr.length>0){
                $.post("/freeboard01_war_exploded/article/file/deleteAll", {files: arr}, function () {});
            }

            // 삭제처리
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