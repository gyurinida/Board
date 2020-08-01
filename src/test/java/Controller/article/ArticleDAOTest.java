package Controller.article;

import Controller.article.domain.ArticleVO;
import Controller.article.persistence.ArticleDAO;
import Controller.commons.paging.Criteria;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.inject.Inject;
import java.util.Date;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring-config/applicationContext.xml"})

public class ArticleDAOTest {
    private static final Logger logger = LoggerFactory.getLogger(ArticleDAOTest.class);

    @Inject
    private ArticleDAO articleDAO;

    @Test
    public void testListCriteria() throws Exception{
        Criteria criteria = new Criteria();
        criteria.setPage(3);
        criteria.setPerPageNum(20);

        List<ArticleVO> articles = articleDAO.listCriteria(criteria);

        for(ArticleVO article: articles)
            System.out.println(article.getArticleNo()+": "+article.getTitle());
    }


/*
    @Test
    public void testListPaging() throws Exception{
        int page = 3;
        List<ArticleVO> articles = articleDAO.listPaging(page);

        for(ArticleVO article: articles)
            System.out.println(article.getArticleNo()+": "+article.getTitle());
            //logger.info(article.getArticleNo()+": "+article.getTitle());
    }


    @Test
    public void testCreateHundred() throws Exception{
        for(int i=1; i<=1000; i++){
            ArticleVO articleVO = new ArticleVO();
            articleVO.setArticleNo(i);
            articleVO.setTitle(i+"th post..");
            articleVO.setContent(i+"th content");
            articleVO.setWriter("user0"+(i%10));
            Date todaytime = new Date();
            articleVO.setRegDate(todaytime);
            articleDAO.create(articleVO);
        }
    }

    @Test
    public void testListAll() throws Exception{
        System.out.println(articleDAO.listAll());
    }

    @Test
    public void testCreate() throws Exception {
        ArticleVO article = new ArticleVO();
        article.setTitle("새로운 글 작성 테스트 제목;");
        article.setContent("새로운 글 작성 테스트 내용");
        article.setWriter("새로운 글 작성자");
        Date todaytime = new Date();
        article.setRegDate(todaytime);
        articleDAO.create(article);
    }

    @Test
    public void testRead() throws Exception {
        logger.info(articleDAO.read(4).toString());
        //System.out.println(articleDAO.read(4));
    }

    @Test
    public void testUpdate() throws Exception {
        ArticleVO article = new ArticleVO();
        article.setArticleNo(3);
        article.setTitle("글 수정 테스트 제목");
        article.setContent("글 수정 테스트 내용");
        articleDAO.update(article);
    }

    @Test
    public void testDelete() throws Exception {
        articleDAO.delete(2);
    }
     */
}
