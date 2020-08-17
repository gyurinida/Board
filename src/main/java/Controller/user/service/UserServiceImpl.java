package Controller.user.service;

import Controller.user.domain.LoginDTO;
import Controller.user.domain.UserVO;
import Controller.user.persistence.UserDAO;
import org.springframework.stereotype.Service;

import javax.inject.Inject;

@Service
public class UserServiceImpl implements UserService{

    private final UserDAO userDAO;

    @Inject
    public UserServiceImpl(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    // 회원 가입 처리
    @Override
    public void register(UserVO userVO) throws Exception {
        userDAO.register(userVO);
    }

    // 로그인 처리
    @Override
    public UserVO login(LoginDTO loginDTO) throws Exception {
        return userDAO.login(loginDTO);
    }
}
