package Controller.article.controller;

import Controller.article.domain.ArticleVO;
import Controller.article.service.ArticleService;
import Controller.commons.paging.PageMaker;
import Controller.commons.paging.SearchCriteria;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;
import java.util.Date;

@Controller
@RequestMapping("/article/paging/search")
public class ArticlePagingSearchController {

    private static final Logger logger = LoggerFactory.getLogger(ArticleService.class);
    private final ArticleService articleService;

    @Inject
    public ArticlePagingSearchController(ArticleService articleService) {
        this.articleService = articleService;
    }

    // 등록 페이지 이동
    @RequestMapping(value = "/write", method = RequestMethod.GET)
    public String writeGET(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria){
        logger.info("search write GET...");
        return "article/search/write";
    }

    // 등록 처리
    @RequestMapping(value = "/write", method = RequestMethod.POST)
    public String writePOST(ArticleVO articleVO, RedirectAttributes redirectAttributes) throws Exception{
        Date curtime = new Date();
        articleVO.setRegDate(curtime);

        logger.info("search write POST...");
        articleService.create(articleVO);
        redirectAttributes.addFlashAttribute("msg", "regSuccess");

        return "redirect:/article/paging/search/list";
    }

    // [10]
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,
                       Model model) throws Exception{
        logger.info("search list() called...");

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(searchCriteria);
        //pageMaker.setTotalCount(articleService.countArticles(searchCriteria));
        pageMaker.setTotalCount(articleService.countSearchedArticles(searchCriteria));

        //model.addAttribute("articles", articleService.listCriteria(searchCriteria));
        model.addAttribute("articles", articleService.listSearch(searchCriteria));
        model.addAttribute("pageMaker", pageMaker);

        return "article/search/list";
    }

    // [10-6] 조회 페이지 이동 + 목록페이지 정보 유지 + 검색어처리
    @RequestMapping(value = "/read", method = RequestMethod.GET)
    public String read(@RequestParam("articleNo") int articleNo,
                       @ModelAttribute("searchCriteria") SearchCriteria searchCriteria,
                       Model model) throws  Exception{

        logger.info("search read...");
        model.addAttribute("article", articleService.read(articleNo));

        return "article/search/read";
    }

    // 비로그인 상태에서 댓글 달려고 할 때
    @RequestMapping(value = "/read/repliesLogin", method = RequestMethod.GET)
    public String readRepliesLogin(@RequestParam("articleNo") int articleNo,
                       @ModelAttribute("searchCriteria") SearchCriteria searchCriteria,
                       Model model) throws  Exception{

        return "user/login";
    }

    // [10-6] 수정 페이지 이동 + 목록페이지 정보 유지 + 검색어처리
    @RequestMapping(value = "/modify", method = RequestMethod.GET)
    public String modifyGET(@RequestParam("articleNo") int articleNo,
                            @ModelAttribute("searchCriteria") SearchCriteria searchCriteria,
                            Model model) throws Exception{
        logger.info("search modify Get..");
        model.addAttribute("article", articleService.read(articleNo));

        return "article/search/modify";
    }

    // [10-6] 수정 처리 + 목록페이지 정보 유지 + 검색어처리
    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String modifyPOST(ArticleVO articleVO,
                             SearchCriteria searchCriteria,
                             RedirectAttributes redirectAttributes) throws Exception{
        logger.info("search modifyPOST...");
        articleService.update(articleVO);
        redirectAttributes.addAttribute("page", searchCriteria.getPage());
        redirectAttributes.addAttribute("perPageNum", searchCriteria.getPerPageNum());
        redirectAttributes.addAttribute("searchType", searchCriteria.getSearchType());
        redirectAttributes.addAttribute("keyword", searchCriteria.getKeyword());
        redirectAttributes.addFlashAttribute("msg", "modSuccess");

        return "redirect:/article/paging/search/list";
    }

    // [10-6] 삭제 처리 + 검색어처리
    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    public String remove(@RequestParam("articleNo") int articleNo,
                         SearchCriteria searchCriteria,
                         RedirectAttributes redirectAttributes) throws Exception{
        logger.info("search remove...");

        articleService.delete(articleNo);
        redirectAttributes.addAttribute("page", searchCriteria.getPage());
        redirectAttributes.addAttribute("perPageNum", searchCriteria.getPerPageNum());
        redirectAttributes.addAttribute("searchType", searchCriteria.getSearchType());
        redirectAttributes.addAttribute("keyword", searchCriteria.getKeyword());
        redirectAttributes.addFlashAttribute("msg", "delSuccess");

        return "redirect:/article/paging/search/list";
    }
}
