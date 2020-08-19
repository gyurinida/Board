package Controller.reply.service;

import Controller.article.persistence.ArticleDAO;
import Controller.commons.paging.Criteria;
import Controller.reply.domain.ReplyVO;
import Controller.reply.persistence.ReplyDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import java.util.List;

@Service
public class ReplyServiceImpl implements ReplyService{
    private final ReplyDAO replyDAO;
    private final ArticleDAO articleDAO;    // [14]

    @Inject
    public ReplyServiceImpl(ReplyDAO replyDAO, ArticleDAO articleDAO) {
        this.replyDAO = replyDAO;
        this.articleDAO = articleDAO;
    }

    @Override
    public List<ReplyVO> getReplies(Integer articleNo) throws Exception {
        return replyDAO.list(articleNo);
    }

    @Transactional  //[14]
    @Override
    public void addReply(ReplyVO replyVO) throws Exception {
        replyDAO.create(replyVO);
        articleDAO.updateReplyCnt(replyVO.getArticleNo(), 1); // 댓글 갯수 1 증가
    }

    @Override
    public void modifyReply(ReplyVO replyVO) throws Exception {
        replyDAO.update(replyVO);
    }

    @Transactional  // [14]
    @Override
    public void removeReply(Integer replyNo) throws Exception {
        int articleNo = replyDAO.getArticleNo((replyNo));   // 댓글 삭제 전에, 댓글이 달린 게시글 번호 먼저 받아오기
        replyDAO.delete(replyNo);
        articleDAO.updateReplyCnt(articleNo, -1);   // 댓글 갯수 1 감소
    }

    @Override
    public List<ReplyVO> getRepliesPaging(Integer articleNo, Criteria criteria) throws Exception {
        return replyDAO.listPaging(articleNo, criteria);
    }

    @Override
    public int countReplies(Integer articleNo) throws Exception {
        return replyDAO.countReplies(articleNo);
    }
}
