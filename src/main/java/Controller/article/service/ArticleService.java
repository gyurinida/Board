package Controller.article.service;

import Controller.article.domain.ArticleVO;
import Controller.commons.paging.Criteria;

import java.util.List;

public interface ArticleService {
    void create(ArticleVO articleVO) throws Exception;
    ArticleVO read(Integer articleNo) throws Exception;
    void update(ArticleVO articleVO) throws Exception;
    void delete(Integer articleNo) throws Exception;
    List<ArticleVO> listAll() throws Exception;
    List<ArticleVO> listCriteria(Criteria criteria) throws Exception;
}
