package Controller.article.persistence;

import Controller.article.domain.ArticleVO;
import Controller.commons.paging.Criteria;
import Controller.commons.paging.SearchCriteria;

import java.util.List;

public interface ArticleDAO {
    void create(ArticleVO articleVO) throws Exception;

    ArticleVO read(Integer articleNo) throws Exception;

    void update(ArticleVO articleVO) throws Exception;

    void delete(Integer articleNo) throws Exception;

    List<ArticleVO> listAll() throws Exception;

    List<ArticleVO> listPaging(int page) throws Exception;

    List<ArticleVO> listCriteria(Criteria criteria) throws Exception;

    int countArticles(Criteria criteria) throws Exception;
    // [10-4]
    List<ArticleVO> listSearch(SearchCriteria searchCriteria) throws Exception;
    // [10-4]
    int countSearchArticles(SearchCriteria searchCriteria) throws Exception;
}
