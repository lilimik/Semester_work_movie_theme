package ru.itis.services;

import ru.itis.dto.SignInForm;
import ru.itis.dto.SignUpForm;
import ru.itis.models.User;

public interface UserService {
    void signUp(SignUpForm form);
    String signIn(SignInForm form);
    User getUserByUUID(String uuid);
    void createDefaultAvatar();
}
