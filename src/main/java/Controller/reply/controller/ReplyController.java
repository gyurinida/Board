package Controller.reply.controller;

import Controller.commons.paging.Criteria;
import Controller.commons.paging.PageMaker;
import Controller.reply.domain.ReplyVO;
import Controller.reply.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/replies")
public class ReplyController {
    private final ReplyService replyService;

    @Inject
    public ReplyController(ReplyService replyService) {
        this.replyService = replyService;
    }

    @RequestMapping(value = "", method = RequestMethod.GET)
    public ResponseEntity<String> registerGET(){
        ResponseEntity<String> entity = null;
        System.out.println("################");
        System.out.println("ReplyController->registerGET");
        return entity;
    }

    // 댓글 등록처리
    @RequestMapping(value = "", method = RequestMethod.POST)
    public ResponseEntity<String> register(@RequestBody ReplyVO replyVO){
        ResponseEntity<String> entity = null;
        try{
            replyService.addReply(replyVO);
            entity = new ResponseEntity<>("regSuccess", HttpStatus.OK);
        } catch (Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

    // 댓글 목록
    @RequestMapping(value = "/all/{articleNo}", method = RequestMethod.GET)
    public ResponseEntity<List<ReplyVO>> list(@PathVariable("articleNo") Integer articleNo){
        ResponseEntity<List<ReplyVO>> entity = null;
        try {
            entity = new ResponseEntity<>(replyService.getReplies(articleNo), HttpStatus.OK);
        } catch (Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

    // 댓글 수정
    @RequestMapping(value = "/{replyNo}", method = {RequestMethod.PUT, RequestMethod.PATCH})
    public ResponseEntity<String> update(@PathVariable("replyNo") Integer replyNo, @RequestBody ReplyVO replyVO){
        ResponseEntity<String> entity = null;
        try {
            replyVO.setReplyNo(replyNo);
            replyService.modifyReply(replyVO);
            entity = new ResponseEntity<>("modSuccess", HttpStatus.OK);
        } catch (Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

    // 댓글 삭제
    @RequestMapping(value = "/{replyNo}", method = RequestMethod.DELETE)
    public ResponseEntity<String> delete(@PathVariable("replyNo") Integer replyNo){
        ResponseEntity<String> entity = null;
        try{
            replyService.removeReply(replyNo);
            entity = new ResponseEntity<>("delSuccess", HttpStatus.OK);
        } catch (Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return entity;
    }

    // 댓글 페이징
    @RequestMapping(value = "/{articleNo}/{page}", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> listPaging(
            @PathVariable("articleNo") Integer articleNo,
            @PathVariable("page") Integer page){
        ResponseEntity<Map<String, Object>> entity = null;
        try {
            Criteria criteria = new Criteria();
            criteria.setPage(page);

            List<ReplyVO> replies = replyService.getRepliesPaging(articleNo, criteria);
            int repliesCount = replyService.countReplies(articleNo);

            PageMaker pageMaker = new PageMaker();
            pageMaker.setCriteria(criteria);
            pageMaker.setTotalCount(repliesCount);;

            Map<String, Object> mapp = new HashMap<>();
            mapp.put("replies", replies);
            mapp.put("pageMaker", pageMaker);

            entity = new ResponseEntity<>(mapp, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            entity = new ResponseEntity<>(HttpStatus.OK);
        }
        return entity;
    }
}
