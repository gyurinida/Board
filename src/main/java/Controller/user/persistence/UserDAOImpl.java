package Controller.user.persistence;

import Controller.user.domain.LoginDTO;
import Controller.user.domain.UserVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;

@Repository
public class UserDAOImpl implements UserDAO {

    private static final String NAMESPACE = "Controller.mappers.user.UserMapper";
    private final SqlSession sqlSession;

    @Inject
    public UserDAOImpl(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    // 회원 가입 처리
    @Override
    public void register(UserVO userVO) throws Exception {
        sqlSession.insert(NAMESPACE+".register", userVO);
    }

    // 로그인 처리
    @Override
    public UserVO login(LoginDTO loginDTO) throws Exception {
        return sqlSession.selectOne(NAMESPACE+".login", loginDTO);
    }
}
