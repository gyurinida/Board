package Controller.upload.persistence;

import java.util.List;

public interface ArticleFileDAO {
    void addFile(String fileName) throws Exception;

    // 첨부파일 목록
    List<String> getArticleFiles(Integer articleNo) throws Exception;

    // 게시글 첨부 파일 전체 삭제
    void deleteFiles(Integer articleNo) throws Exception;

    // 첨부 파일 삭제
    void deleteFile(String fileName) throws Exception;

    // 첨부 파일 수정
    void replaceFile(String fileName, Integer articleNo) throws Exception;

    // 첨부파일 갯수 갱신
    void updateFileCnt(Integer articleNo) throws Exception;

}
