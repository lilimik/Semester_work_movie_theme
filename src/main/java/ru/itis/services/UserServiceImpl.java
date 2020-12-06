package ru.itis.services;

import org.springframework.security.crypto.password.PasswordEncoder;
import ru.itis.dto.SignInForm;
import ru.itis.dto.SignUpForm;
import ru.itis.dto.UserInfo;
import ru.itis.models.Cookie;
import ru.itis.models.User;
import ru.itis.repositories.UsersRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class UserServiceImpl implements UserService {

    private final UsersRepository usersRepository;
    private final PasswordEncoder passwordEncoder;
    private final CookieService cookieService;
    private final FilesService filesService;

    public UserServiceImpl(UsersRepository usersRepository, PasswordEncoder passwordEncoder, CookieService cookieService, FilesService filesService) {
        this.usersRepository = usersRepository;
        this.passwordEncoder = passwordEncoder;
        this.cookieService = cookieService;
        this.filesService = filesService;
    }

    @Override
    public void signUp(SignUpForm form) {
        User user = User.builder()
                .email(form.getEmail())
                .firstName(form.getFirstName())
                .lastName(form.getLastName())
                .hashPassword(passwordEncoder.encode(form.getPassword()))
                .build();
        Long accountId = usersRepository.saveAndReturnId(user);
        filesService.saveDefaultAvatarToStorage(accountId);
    }

    @Override
    public String signIn(SignInForm form) {
        Optional<User> optionalUser = usersRepository.findByEmail(form.getEmail());
        if (optionalUser.isPresent())
            if (passwordEncoder.matches(form.getPassword(), optionalUser.get().getHashPassword())) {
                String uuid = UUID.randomUUID().toString();
                cookieService.save(Cookie.builder()
                        .id(optionalUser.get().getId())
                        .UUID(uuid)
                        .build());
                return uuid;
            }
        return null;
    }

    @Override
    public User getUserByUUID(String uuid) {
        Long id = cookieService.findIdByUuid(uuid);
        User user = null;
        if (id != null) {
            Optional<User> optionalUser = usersRepository.findById(id);
            if (optionalUser.isPresent())
                user = optionalUser.get();
        }
        return user;
    }

    @Override
    public void createDefaultAvatar() {

    }

    @Override
    public void updateUserInfo(UserInfo form) {
        User user = User.builder()
                .id(form.getAccountId())
                .firstName(form.getFirstName())
                .lastName(form.getLastName())
                .hashPassword(passwordEncoder.encode(form.getPassword()))
                .build();
        if (form.getPassword().equals("")) {
            user.setHashPassword(null);
        }
        usersRepository.update(user);
    }

    @Override
    public void saveUser(User user) {
        usersRepository.save(user);
    }

    @Override
    public List<User> findAll() {
        return usersRepository.findAll();
    }

}
