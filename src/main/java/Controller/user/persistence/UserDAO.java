package Controller.user.persistence;

import Controller.user.domain.LoginDTO;
import Controller.user.domain.UserVO;

import java.util.Date;

public interface UserDAO {

    // 회원가입 처리
    void register(UserVO userVO) throws Exception;

    // 로그인 처리
    UserVO login(LoginDTO loginDTO) throws Exception;

    // [17] 로그인 유지 처리
    void keepLogin(String userId, String sessionId, Date sessionLimit) throws Exception;

    // [17] 세션 키 검증
    UserVO checkUserWithSessionKey(String value) throws Exception;
}
