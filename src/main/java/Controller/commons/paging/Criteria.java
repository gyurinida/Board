package Controller.commons.paging;

public class Criteria {
    private int page;       // 현재 페이지 번호
    private int perPageNum; // 페이지 당 출력되는 게시글의 갯수

    public Criteria(){
        this.page = 1;
        this.perPageNum = 10;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        if(page<=0){
            this.page = 1;
            return;
        }
        this.page = page;
    }

    public int getPerPageNum() {
        return perPageNum;
    }

    public void setPerPageNum(int perPageNum) {
        if(perPageNum<=0 || perPageNum>100){
            this.perPageNum = 10;
            return;
        }
        this.perPageNum = perPageNum;
    }

    public int getPageStart(){
        // SQL Mapper 중 LIMIT에서 현재 페이지의 게시글 시작위치를 지정할 때 사용
        // ex. 10개씩 출력할 경우, 3페이지는 LIMIT 20, 10이 되어야 함
        return (this.page-1)*perPageNum;
    }

    @Override
    public String toString() {
        return "Criteria{" +
                "page=" + page +
                ", perPageNum=" + perPageNum +
                '}';
    }
}
