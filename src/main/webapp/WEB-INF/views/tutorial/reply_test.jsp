<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<%@ include file="../include/head.jsp"%>

<body class="hold-transition skin-blue sidebar-mini layout-boxed">
<div class="wrapper">

    <!-- Main Header -->
    <%@ include file="../include/main_header.jsp"%>
    <!-- Left side column. contains the logo and sidebar -->
    <%@ include file="../include/left_column.jsp"%>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                AJAX 댓글 테스트 페이지
            </h1>
            <ol class="breadcrumb">
                <li><i class="fa fa-edit"></i> reply test</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">
            <div class="col-lg-12">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">댓글 작성</h3>
                    </div>
                    <div class="box-body">
                        <div class="form-group">
                            <label for="newReplyText">댓글 내용</label>
                            <input class="form-control" id="newReplyText" name="replyText" placeholder="Please fill out Reply Contents">
                        </div>
                        <div class="form-group">
                            <label for="newReplyWriter">댓글 작성자</label>
                            <input class="form-control" id="newReplyWriter" name="replyWriter" placeholder="Please fill out Reply Writer">
                        </div>
                        <div class="pull-right">
                            <button type="button" id="replyAddBtn" class="btn btn-primary"><i class="fa fa-save"></i> 댓글 저장</button>
                        </div>
                    </div>
                    <div class="box-footer">
                        <ul id="replies">

                        </ul>
                    </div>
                    <div class="box-footer">
                        <div class="text-center">
                            <ul class="pagination pagination-sm no-margin">

                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modifyModal" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" date-dimiss="modal">&times;</button>
                            <h4 class="modal-title">댓글 수정창</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="replyNo">댓글 번호</label>
                                <input class="form-control" id="replyNo" name="replyNo" readonly>
                            </div>
                            <div class="form-group">
                                <label for="replyText">댓글 내용</label>
                                <input class="form-control" id="replyText" name="replyText">
                            </div>
                            <div class="form-group">
                                <label for="replyWriter">댓글 작성자</label>
                                <input class="form-control" id="replyWriter" name="replyWriter" readonly>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left" date-dimiss="modal">닫기</button>
                            <button type="button" class="btn btn-success modalModBtn">수정</button>
                            <button type="button" class="btn btn-danger modalDelBtn">삭제</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!-- Main Footer -->
    <%@ include file="../include/main_footer.jsp"%>

</div>
<!-- ./wrapper -->

<%@ include file="../include/plugin_js.jsp"%>
<script>
    // 댓글 가져올 게시글 번호, 목록페이지 번호(1로 초기화)
    var articleNo = 1002;
    var replyPageNum = 1;

    getRepliesPaging(replyPageNum);

    // 댓글 목록 출력
    function getReplies() {
        $.getJSON("/freeboard01_war_exploded/replies/all/"+articleNo, function (data) {
            console.log(data);

            var str = "";
            $(data).each(function () {
                str += "<li data-replyNo='" + this.replyNo + "' class='replyLi'>"
                    +   "<p class='replyText'>" + this.replyText + "</p>"
                    +   "<p class='replyWriter'>" + this.replyWriter + "</p>"
                    +   "<button type='button' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal'>댓글 수정</button>"
                    +   "</li>"
                    +   "<hr/>";
            });

            $("#replies").html(str);
        });
    }

    // 댓글 저장 버튼 클릭 이벤트
    $("#replyAddBtn").on("click", function () {

        // 입력값 처리
        var replyText = $("#newReplyText");
        var replyWriter = $("#newReplyWriter");
        var replyTextVal = replyText.val();
        var replyWriterVal = replyWriter.val();

        // POST
        $.ajax({
           type: "post",
           url: "/freeboard01_war_exploded/replies",
           headers: {
               "Content-type": "application/json",
               "X-HTTP-Method-Override": "POST"
           },
            dataType: "text",
            data: JSON.stringify({
                articleNo: articleNo,
                replyText: replyTextVal,
                replyWriter: replyWriterVal
            }),
            success: function(result){
                if(result=="regSuccess"){
                   alert("댓글 등록 완료!");
                }
                getRepliesPaging();    // 등록한 댓글 보디 위해 출력 함수 다시 호출
                replyText.val("");   // 댓글 내용 초기화
                replyWriter.val(""); // 댓글 작성자 초기화
            }
        });
    });

    // 댓글 수정 -> 댓글 값 세팅
    $("#replies").on("click", ".replyLi button", function () {
        var reply = $(this).parent();
        var replyNo = reply.attr("data-replyNo");
        var replyText = reply.find(".replyText").text();
        var replyWriter = reply.find(".replyWriter").text();

        $("#replyNo").val(replyNo);
        $("#replyText").val(replyText);
        $("#replyWriter").val(replyWriter);
    });

    // 댓글 수정 -> 댓글 삭제
    $(".modalDelBtn").on("click", function () {

        var replyNo = $(this).parent().parent().find("#replyNo").val();

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
                    alert("댓글 삭제 완료!");
                    $("#modifyModal").modal("hide"); // Modal 닫기
                    getRepliesPaging(); // 댓글 목록 갱신
                }
            }
        });
    });

    // 댓글 수정 -> 댓글 수정
    $(".modalModBtn").on("click", function () {

        var reply = $(this).parent().parent();
        var replyNo = reply.find("#replyNo").val();
        var replyText = reply.find("#replyText").val();

        // PUT
        $.ajax({
            type: "put",
            url: "/freeboard01_war_exploded/replies/" + replyNo,
            headers: {
                "Content-type": "application/json",
                "X-HTTP-Method-Override": "PUT"
            },
            data: JSON.stringify(
                {replyText: replyText}
            ),
            dataType: "text",
            success: function(result){
                console.log("result: "+ result);
                if(result=="modSuccess"){
                    alert("댓글 수정 완료!");
                    $("#modifyModal").modal("hide"); // Modal 닫기
                    getRepliesPaging(); // 댓글 목록 갱신
                }
            }
        });
    });

    // 댓글 목록 출력 + 페이징
    function getRepliesPaging(page) {
        $.getJSON("/freeboard01_war_exploded/replies/"+ articleNo + "/" + page, function (data) {
            console.log(data);

            var str = "";

            $(data.replies).each(function () {
                str += "<li data-replyNo='" + this.replyNo + "' class='replyLi'>"
                    +   "<p class='replyText'>" + this.replyText + "</p>"
                    +   "<p class='replyWriter'>" + this.replyWriter + "</p>"
                    +   "<button type='button' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal'>댓글 수정</button>"
                    +   "</li>"
                    +   "<hr/>";
            });

            $("#replies").html(str);

            // 페이지 번호 호출
            printPageNumbers(data.pageMaker);
        });
    }

    // 댓글 목록 페이지 번호 출력 함수
    function printPageNumbers(pageMaker) {
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

        $(".pagination-sm").html(str);
    }

    // 목록페이지 번호 클릭 이벤트
    $(".pagination").on("click", "li a", function (event) {
        event.preventDefault();
        replyPageNum = $(this).attr("href");    // 목록 페이지 번호 추출
        getRepliesPaging(replyPageNum);         // 목록 페이지 호출
    })

</script>
</body>
</html>