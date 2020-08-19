package Controller.user.service;

import Controller.user.domain.LoginDTO;
import Controller.user.domain.UserVO;

import java.util.Date;

public interface UserService {

    // 회원 가입 처리
    void register(UserVO userVO) throws Exception;

    // 로그인 처리
    UserVO login(LoginDTO loginDTO) throws Exception;

    // [17] 로그인 유지
    void keepLogin(String userId, String sessionId, Date sessionLimit) throws Exception;

    // [17] loginCookie로 회원정보 조회
    UserVO checkLoginBefore(String value) throws Exception;
}
