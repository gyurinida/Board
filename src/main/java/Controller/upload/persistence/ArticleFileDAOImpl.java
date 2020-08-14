package Controller.upload.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.List;

@Repository
public class ArticleFileDAOImpl implements ArticleFileDAO{

    private static final String NAMESPACE = "Controller.mappers.upload.ArticleFileMapper";
    private final SqlSession sqlSession;

    @Inject
    public ArticleFileDAOImpl(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void addFile(String fileName) throws Exception {
        sqlSession.insert(NAMESPACE+".addFile", fileName);
    }

    @Override
    public List<String> getArticleFiles(Integer articleNo) throws Exception {
        return sqlSession.selectList(NAMESPACE+".getArticleFiles", articleNo);
    }

    @Override
    public void deleteFiles(Integer articleNo) throws Exception {
        sqlSession.delete(NAMESPACE+".deleteFiles", articleNo);
    }
}
