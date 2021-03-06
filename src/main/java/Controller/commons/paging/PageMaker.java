package Controller.commons.paging;

import com.sun.jndi.toolkit.url.Uri;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class PageMaker {
    private int totalCount; // 게시글 전체 갯수
    private int startPage;  // 목록 하단의 시작 페이지 번호
    private int endPage;    // 목록 하단의 끝 페이지 번호
    private boolean prev;   // 이전 링크
    private boolean next;   // 다음 링크

    private int displayPageNum = 10;    // 목록 하단의 페이지 번호 갯수

    private Criteria criteria;

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        // 게시글 전체 갯수가 정해지는 순간, 필요한 값들을 계산
        calcDate();
    }

    private void calcDate(){
        endPage = (int)(Math.ceil(criteria.getPage()/(double)displayPageNum)*displayPageNum);
        startPage = (endPage - displayPageNum) + 1;

        int tmpEndPage = (int)(Math.ceil(totalCount/(double)criteria.getPerPageNum()));
        if(endPage>tmpEndPage)
            endPage = tmpEndPage;

        prev = startPage==1?false:true;
        next = endPage*criteria.getPerPageNum()>=totalCount?false:true;
    }

    //[10] 검색창 추가
    public String makeSearch(int page){
        UriComponents uriComponents = UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("perPageNum", criteria.getPerPageNum())
                .queryParam("searchType", ((SearchCriteria) criteria).getSearchType())
                .queryParam("keyword", encoding(((SearchCriteria) criteria).getKeyword()))
                .build();

        return uriComponents.toUriString();
    }

    private String encoding(String keyword) {
        if(keyword==null || keyword.trim().length()==0){
            return "";
        }

        try{
            return URLEncoder.encode(keyword, "UTF-8");
        } catch (UnsupportedEncodingException e){
            return "";
        }
    }

    public String makeQuery(int page){
        // URI 자동으로 생성
        UriComponents uriComponents = UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("perPageNum", criteria.getPerPageNum())
                .build();

        return uriComponents.toUriString();
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setPrev(boolean prev) {
        this.prev = prev;
    }

    public boolean isPrev() {
        return prev;
    }

    public void setNext(boolean next) {
        this.next = next;
    }

    public boolean isNext() {
        return next;
    }

    public void setDisplayPageNum(int displayPageNum) {
        this.displayPageNum = displayPageNum;
    }

    public int getDisplayPageNum() {
        return displayPageNum;
    }

    public void setCriteria(Criteria criteria){
        this.criteria = criteria;
    }

    public Criteria getCriteria() {
        return criteria;
    }

    @Override
    public String toString() {
        return "PageMaker{" +
                "totalCount=" + totalCount +
                ", startPage=" + startPage +
                ", endPage=" + endPage +
                ", prev=" + prev +
                ", next=" + next +
                ", displayPageNum=" + displayPageNum +
                ", criteria=" + criteria +
                '}';
    }
}
