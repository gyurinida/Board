package Controller.reply.persistence;

import Controller.commons.paging.Criteria;
import Controller.reply.domain.ReplyVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.test.context.jdbc.Sql;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ReplyDAOImpl implements ReplyDAO{
    private static String NAMESPACE = "Controller.mappers.reply.ReplyMapper";

    private final SqlSession sqlSession;

    @Inject
    public ReplyDAOImpl(SqlSession sqlSession){
        this.sqlSession = sqlSession;
    }

    @Override
    public List<ReplyVO> list(Integer articleNo) throws Exception {
        return sqlSession.selectList(NAMESPACE+".list", articleNo);
    }

    @Override
    public void create(ReplyVO replyVO) throws Exception {
        sqlSession.insert(NAMESPACE+".create", replyVO);
    }

    @Override
    public void update(ReplyVO replyVO) throws Exception {
        sqlSession.update(NAMESPACE+".update", replyVO);
    }

    @Override
    public void delete(Integer replyNO) throws Exception {
        sqlSession.delete(NAMESPACE+".delete", replyNO);
    }

    // [11-3] 댓글 페이징
    @Override
    public List<ReplyVO> listPaging(Integer articleNo, Criteria criteria) throws Exception {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("articleNo", articleNo);
        paramMap.put("criteria", criteria);

        return sqlSession.selectList(NAMESPACE+".listPaging", paramMap);
    }

    @Override
    public int countReplies(Integer articleNo) throws Exception {
        return sqlSession.selectOne(NAMESPACE+".countReplies", articleNo);
    }

    // [14]
    @Override
    public int getArticleNo(Integer replyNo) throws Exception {
        return sqlSession.selectOne(NAMESPACE+".getArticleNo", replyNo);
    }


}
