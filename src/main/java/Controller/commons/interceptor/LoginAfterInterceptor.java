package Controller.commons.interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginAfterInterceptor extends HandlerInterceptorAdapter {
    private static final Logger logger = LoggerFactory.getLogger(LoginAfterInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        // 로그인 처리 후 로그인/회원가입 페이지 이동할 경우
        HttpSession httpSession = request.getSession();
        if(httpSession.getAttribute("login")!=null){
            response.sendRedirect(request.getContextPath()+"/");
            return false;
        }

        return true;
    }
}
