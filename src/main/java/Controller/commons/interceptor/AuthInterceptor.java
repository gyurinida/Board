package Controller.commons.interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthInterceptor extends HandlerInterceptorAdapter {
    // 특정 경로에 접근할 경우 현재 사용자의 로그인 여부 체크

    private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

    // [16-3.10] 페이지 요청 정보 저장: 로그인 후 원하던 페이지로 이동하게끔
    private void saveDestination(HttpServletRequest request){
        // TODO: 이전의 destination이 남아있는 문제도 해결해야 함
        String uri = request.getRequestURI();
        String query = request.getQueryString();

        // 댓글을 달기 위해 로그인페이지로 이동할 경우에 대한 처리
        // from ArticlePagingSearchController.readRepliesLogin
        if(uri.contains("/read/repliesLogin")){
            System.out.println(uri.substring(0, uri.indexOf("/repliesLogin")));
            uri = uri.substring(0, uri.indexOf("/repliesLogin"));
        }

        if(query==null || query.equals("null"))
            query = "";
        else
            query = "?" +query;

        if(request.getMethod().equals("GET")){
            logger.info("destination: "+ (uri+query));
            request.getSession().setAttribute("destination", uri+query);
        }
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 현재 사용자가 로그인 상태인지 확인 후, 컨트롤러 호출 여부 결정

        HttpSession httpSession = request.getSession();

        if(httpSession.getAttribute("login")==null){
            logger.info("Current User Is Not Logged");
            saveDestination(request);
            response.sendRedirect("/freeboard01_war_exploded/user/login");
            return false;
        }
        return true;
    }
}
