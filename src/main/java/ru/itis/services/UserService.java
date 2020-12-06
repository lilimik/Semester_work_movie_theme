package ru.itis.services;

import ru.itis.dto.SignInForm;
import ru.itis.dto.SignUpForm;
import ru.itis.dto.UserInfo;
import ru.itis.models.User;

import java.util.List;

public interface UserService {
    void saveUser(User user);
    List<User> findAll();
    void signUp(SignUpForm form);
    String signIn(SignInForm form);
    User getUserByUUID(String uuid);
    void createDefaultAvatar();
    void updateUserInfo(UserInfo userInfo);
}
