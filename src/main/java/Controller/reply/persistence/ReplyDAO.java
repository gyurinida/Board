package Controller.reply.persistence;

import Controller.commons.paging.Criteria;
import Controller.reply.domain.ReplyVO;

import java.util.List;

public interface ReplyDAO {
    List<ReplyVO> list(Integer articleNo) throws Exception;
    void create(ReplyVO replyVO) throws Exception;
    void update(ReplyVO replyVO) throws Exception;
    void delete(Integer replyNO) throws Exception;
    // [11-3] 댓글 페이징
    List<ReplyVO> listPaging(Integer articleNo, Criteria criteria) throws Exception;
    int countReplies(Integer articleNo) throws Exception;
}
