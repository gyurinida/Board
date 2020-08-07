package Controller.article;

import Controller.commons.paging.Criteria;
import Controller.reply.domain.ReplyVO;
import Controller.reply.persistence.ReplyDAO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.inject.Inject;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring-config/applicationContext.xml"})
public class ReplyDAOTest {
    private static final Logger logger = LoggerFactory.getLogger(ReplyDAOTest.class);

    @Inject
    private ReplyDAO replyDAO;

    @Test
    public void testReplyPaging() throws Exception{
        Criteria criteria = new Criteria();
        criteria.setPerPageNum(20);
        criteria.setPage(1);

        List<ReplyVO> replies = replyDAO.listPaging(1002, criteria);
        for(ReplyVO reply: replies)
            System.out.println(reply.getReplyNo()+": "+reply.getReplyText());
    }
    /*
    @Test
    public void testReplyCreate() throws Exception{
        for(int i=1; i<=100; i++){
            ReplyVO replyVO = new ReplyVO();
            replyVO.setArticleNo(1002);
            replyVO.setReplyText(i+"번째 댓글입니다..");
            replyVO.setReplyWriter("user0"+(i%10));
            replyDAO.create(replyVO);
        }
    }


    @Test
    public void testReplyList() throws Exception{
        System.out.println(replyDAO.list(1002).toString());
    }

    @Test
    public void testReplyUpdate() throws Exception{
        ReplyVO replyVO = new ReplyVO();
        replyVO.setArticleNo(1002);
        replyVO.setReplyNo(2);
        replyVO.setReplyText(2+"번째 댓글 수정!");
        replyDAO.update(replyVO);
    }

    @Test
    public void testReplyDelete() throws Exception{
        replyDAO.delete(3);
    }

     */
}
