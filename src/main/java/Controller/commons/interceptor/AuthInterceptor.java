package Controller.commons.interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthInterceptor extends HandlerInterceptorAdapter {
    private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

    // [16-3.10] 페이지 요청 정보 저장
    // 로그인 후 원하던 페이지로 이동하게끔
    private void saveDestination(HttpServletRequest request){
        String uri = request.getRequestURI();
        String query = request.getQueryString();

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
