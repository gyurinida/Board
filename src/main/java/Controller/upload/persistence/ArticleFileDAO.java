package Controller.upload.persistence;

import java.util.List;

public interface ArticleFileDAO {
    void addFile(String fileName) throws Exception;

    // 첨부파일 목록
    List<String> getArticleFiles(Integer articleNo) throws Exception;

    // 게시글 첨부 파일 전체 삭제
    void deleteFiles(Integer articleNo) throws Exception;
}
