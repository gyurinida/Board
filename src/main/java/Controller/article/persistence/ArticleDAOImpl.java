package Controller.article.persistence;

import Controller.article.domain.ArticleVO;
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
}
