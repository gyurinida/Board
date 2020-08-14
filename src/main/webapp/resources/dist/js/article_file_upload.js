// Handlebars 파일템플릿 컴파일
var fileTemplate = Handlebars.compile($("#fileTemplate").html());

// 첨부파일 drag&drop 영역 선택자
var fileDropDiv = $(".fileDrop");

// 전체 페이지 첨부파일 drag&drop 기본 이벤트 방지
$(".content-wrapper").on("dragenter dragover drop", function (event) {
    event.preventDefault();
})

// 첨부파일 영역 drag&drop 기본 이벤트 방지
fileDropDiv.on("dragenter dragover", function (event) {
    event.preventDefault();
})

// 첨부파일 drag&drop 이벤트 처리: 파일 업로드 처리 -> 파일 출력
fileDropDiv.on("drop", function (event) {
    event.preventDefault();
    // drop 이벤트 발생시 전달된 파일 데이터
    var files = event.originalEvent.dataTransfer.files;
    // 단일 파일 데이터만을 처리하기 때문에 첫번째 파일만 저장
    var file = files[0];
    // form 객체 생성, 파일데이터 저장
    var formData = new FormData();
    formData.append("file", file);
    // 파일 업로드 AJAX 호출
    uploadFile(formData);
})

// 파일 업로드 AJAX
function uploadFile(formData) {
    $.ajax({
        url: "/freeboard01_war_exploded/article/file/upload",
        data: formData,
        dataType: "text",
        // processData: 데이터를 일반적인 query string으로 변환처리할 것인지
        // default: true(application/x-www-form-urlencoded 타입)
        processData: false,
        // contentType
        // default: true(application/x-www-form-urlencoded),
        //          false(multipart/form-data)
        contentType: false,
        type: "POST",
        success: function (data) {
            printFiles(data);
            $(".noAttach").remove();
        }
    });
}

// 첨부파일 출력
function printFiles(data) {
    var fileInfo = getFileInfo(data);
    var html = fileTemplate(fileInfo);  // Handlerbars 파일 템플릿에 파일 정보들을 바인딩하고 HTML 생성
    $(".uploadedFileList").append(html);  // Handlerbars 파일 템플릿 컴파일을 통해 생성된 HTML을 DOM에 주입

    // 이미지 파일인 경우, 파일 템플릿에 lightbox 속성 추가
    if(fileInfo.fullName.substr(12, 2)==="s_"){
        // 마지막에 추가된 첨부파일 템플릿 선택
        var that = $(".uploadedFileList li").last();
        // lightbox 속성 추가
        that.find(".mailbox-attachment-name").attr("data-lightbox", "uploadImages");
        // 파일 아이콘에서 이미지 아이콘으로 변경
        that.find(".fa-paperclip").attr("class", "fa fa-camera");
    }
}

// 게시글 입력/수정 submit 처리시 첨부파일 정보도 함께 처리
function filesSubmit(that) {
    var str = "";
    $(".uploadedFileList .delBtn").each(function (index) {
        str += "<input type='hidden' name='files[" + index + "]' value='" + $(this).attr("href") + "'>";
    });
    that.append(str);
    that.get(0).submit();
}

// 파일 삭제(입력 페이지): 첨부파일만 삭제처리
function deleteFileWrtPage(that) {
    var url = "/freeboard01_war_exploded/article/file/delete";
    deleteFile(url, that);
}

// 파일 삭제 AJAX 통신
function deleteFile(url, that) {
    $.ajax({
       url: url,
       type: "POST",
       data: {fileName: that.attr("href")},
       dataType: "text",
       success: function (result) {
           if(result==="DELETED"){
               alert("삭제되었습니다.");
               that.parents("li").remove();
           }
       }
    });
}

// 파일 정보 처리
function getFileInfo(fullName) {
    var originalFileName;   // 화면에 출력할 파일명
    var imgSrc;             // 썸네일 or 파일아이콘 이미지 파일 출력 요청 URL
    var originalFileUrl;    // 원본파일 요청 URL
    var uuidFileName;       // 날짜경로를 제외한 나머지 파일명(UUID_파일명.확장자)

    // 이미지 파일이면
    if(checkImageType(fullName)){
        imgSrc = "/freeboard01_war_exploded/article/file/display?fileName=" + fullName;  // 썸네일 이미지 링크
        uuidFileName = fullName.substr(14);
        var originalImg = fullName.substr(0, 12 )+fullName.substr(14);
        // 원본 이미지 요청 링크
        originalFileUrl = "/freeboard01_war_exploded/article/file/display?fileName="+originalImg;
    }
    else{
        // 파일 아이콘 이미지
        imgSrc = "/freeboard01_war_exploded/resources/upload/files/file-icon.png";
        uuidFileName = fullName.substr(12);
        // 파일 다운로드 요청 링크
        originalFileUrl = "/freeboard01_war_exploded/article/file/display?fileName=" + fullName;
    }
    originalFileName = uuidFileName.substr(uuidFileName.indexOf("_")+1);

    return {originalFileName: originalFileName, imgSrc: imgSrc, originalFileUrl: originalFileUrl, fullName: fullName};
}

// 이미지 파일 유무 확인
function checkImageType(fullName) {
    var pattern = /jpg$|gif$|png$|jpge$/i;
    return fullName.match(pattern);
}

// 파일 목록: 게시글 조회, 수정 페이지
function getFiles(articleNo) {
    $.getJSON("/freeboard01_war_exploded/article/file/list/"+articleNo, function (list) {

        if(list.length==0){
            $(".uploadedFileList").html("<span class='noAttach'>첨부파일이 없습니다.</span>");
        }
        $(list).each(function () {
            printFiles(this);
        });
    });
}