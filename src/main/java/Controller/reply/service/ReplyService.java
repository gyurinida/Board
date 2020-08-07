package Controller.reply.service;

import Controller.commons.paging.Criteria;
import Controller.reply.domain.ReplyVO;

import java.util.List;

public interface ReplyService {
    List<ReplyVO> getReplies(Integer articleNo) throws Exception;
    void addReply(ReplyVO replyVO) throws Exception;
    void modifyReply(ReplyVO replyVO) throws Exception;
    void removeReply(Integer replyNo) throws Exception;
    // [11-3] 댓글 페이징
    List<ReplyVO> getRepliesPaging(Integer articleNo, Criteria criteria) throws Exception;
    int countReplies(Integer articleNo) throws Exception;
}
