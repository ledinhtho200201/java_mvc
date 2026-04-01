package vn.pildo.laptopshop.service;

import java.util.Collections;
import java.util.Map;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import vn.pildo.laptopshop.domain.User;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    private final UserService userService;

    public CustomOAuth2UserService(UserService userService) {
        this.userService = userService;
    }

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(userRequest);

        Map<String, Object> attributes = oAuth2User.getAttributes();
        
        // Try to get email
        String email = (String) attributes.get("email");
        if (email == null) {
            email = (String) attributes.get("preferred_username");
        }
        
        String name = (String) attributes.get("name");
        if (name == null) {
            name = (String) attributes.get("given_name");
        }
        if (name == null) {
            name = email;
        }

        if (email == null) {
            throw new OAuth2AuthenticationException("Email not found from OAuth2 provider");
        }

        User user = userService.getUserByEmail(email);
        if (user == null) {
            user = new User();
            user.setEmail(email);
            user.setFullName(name);
            user.setPassword("Oauth2Password123!"); 
            user.setAvatar("default-avatar.png");
            
            user.setRole("USER");
            userService.handleSaveUser(user);
        }

        String roleName = "ROLE_" + user.getRole();
        
        return new DefaultOAuth2User(
                Collections.singleton(new SimpleGrantedAuthority(roleName)),
                attributes,
                "email" // This becomes getName()
        );
    }
}