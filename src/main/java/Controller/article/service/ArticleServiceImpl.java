package Controller.article.service;

import Controller.article.domain.ArticleVO;
import Controller.article.persistence.ArticleDAO;
import Controller.commons.paging.Criteria;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;

@Service
public class ArticleServiceImpl implements ArticleService{
    private final ArticleDAO articleDAO;

    @Inject
    public ArticleServiceImpl(ArticleDAO articleDAO){
        this.articleDAO = articleDAO;
    }

    @Override
    public void create(ArticleVO articleVO) throws Exception {
        articleDAO.create(articleVO);
    }

    @Override
    public ArticleVO read(Integer articleNo) throws Exception {
        return articleDAO.read(articleNo);
    }

    @Override
    public void update(ArticleVO articleVO) throws Exception {
        articleDAO.update(articleVO);
    }

    @Override
    public void delete(Integer articleNo) throws Exception {
        articleDAO.delete(articleNo);
    }

    @Override
    public List<ArticleVO> listAll() throws Exception {
        //System.out.println("ArticleServiceImpl.java");
        //System.out.println(articleDAO.listAll());
        return articleDAO.listAll();
    }

    @Override
    public List<ArticleVO> listCriteria(Criteria criteria) throws Exception {
        return articleDAO.listCriteria(criteria);
    }

    @Override
    public int countArticles(Criteria criteria) throws Exception {
        return articleDAO.countArticles(criteria);
    }
}
