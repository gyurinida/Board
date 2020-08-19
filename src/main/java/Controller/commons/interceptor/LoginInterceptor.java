package Controller.commons.interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor extends HandlerInterceptorAdapter {
    // 로그인 한 사용자에 대한 정보를 HttpSession에 보관 및 처리

    private static final String LOGIN = "login";
    private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 기존의 로그인 정보가 있을 경우 초기화하는 역할

        HttpSession httpSession = request.getSession();

        // 기존 로그인 정보 제거
        if(httpSession.getAttribute(LOGIN) != null){
            logger.info("Clear Login Data Before");
            httpSession.removeAttribute(LOGIN);
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) throws Exception {
        // httpSession 컨트롤러에서 저장한 user를 저장 후 리다이렉트하는 역할

        HttpSession httpSession = request.getSession();
        ModelMap modelMap = modelAndView.getModelMap();
        Object userVO = modelMap.get("user");

        if(userVO!=null){
            logger.info("New Login Success");
            httpSession.setAttribute(LOGIN, userVO);

            // [17] 쿠키 생성 후, HttpServletResponse에 담아 전송
            if(request.getParameter("useCookie")!=null){
                logger.info("Cookie..");
                // 쿠키 생성
                Cookie loginCookie = new Cookie("loginCookie", httpSession.getId());
                loginCookie.setPath("/freeboard01_war_exploded");
                loginCookie.setMaxAge(60*60*24*7);
                // 전송
                response.addCookie(loginCookie);
            }

            Object destination = httpSession.getAttribute("destination");
            response.sendRedirect(destination!=null?(String)destination:"/freeboard01_war_exploded/");
        }
    }
}
