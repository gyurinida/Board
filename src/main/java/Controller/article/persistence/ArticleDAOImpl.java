package Controller.article.persistence;

import Controller.article.domain.ArticleVO;
import Controller.commons.paging.Criteria;
import Controller.commons.paging.SearchCriteria;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.List;

@Repository
public class ArticleDAOImpl implements ArticleDAO {
    private static final String NAMESPACE = "Controller.mappers.article.ArticleMapper";

    private final SqlSession sqlSession;

    @Inject
    public ArticleDAOImpl(SqlSession sqlSession){
        this.sqlSession = sqlSession;
    }

    @Override
    public void create(ArticleVO articleVO) throws Exception {
        sqlSession.insert(NAMESPACE+".create", articleVO);
    }

    @Override
    public ArticleVO read(Integer articleNo) throws Exception {
        return sqlSession.selectOne(NAMESPACE+".read", articleNo);
    }

    @Override
    public void update(ArticleVO articleV0) throws Exception {
        sqlSession.update(NAMESPACE+".update", articleV0);
    }

    @Override
    public void delete(Integer articleNo) throws Exception {
        sqlSession.delete(NAMESPACE+".delete", articleNo);
    }

    @Override
    public List<ArticleVO> listAll() throws Exception {
        //System.out.println("ArticleDAOImpl.java");
        //System.out.println(sqlSession.selectList(NAMESPACE+".listAll"));
        return sqlSession.selectList(NAMESPACE+".listAll");
    }

    @Override
    public List<ArticleVO> listPaging(int page) throws Exception {
        if(page<=0)
            page = 1;

        page = (page-1)*10;
        return sqlSession.selectList(NAMESPACE+".listPaging", page);
    }

    @Override
    public List<ArticleVO> listCriteria(Criteria criteria) throws Exception {
        return sqlSession.selectList(NAMESPACE+".listCriteria", criteria);
    }

    @Override
    public int countArticles(Criteria criteria) throws Exception {
        return sqlSession.selectOne(NAMESPACE+".countArticles", criteria);
    }

    @Override
    public List<ArticleVO> listSearch(SearchCriteria searchCriteria) throws Exception {
        return sqlSession.selectList(NAMESPACE+".listSearch", searchCriteria);
    }

    @Override
    public int countSearchArticles(SearchCriteria searchCriteria) throws Exception {
        return sqlSession.selectOne(NAMESPACE+".countSearchArticles", searchCriteria);
    }
}
