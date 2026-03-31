package vn.pildo.laptopshop.config;

import jakarta.servlet.DispatcherType;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import vn.pildo.laptopshop.service.CartService;
import vn.pildo.laptopshop.service.UserService;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final UserService userService;
    private final CartService cartService;

    public SecurityConfig(UserService userService, CartService cartService) {
        this.userService = userService;
        this.cartService = cartService;
    }

    @Bean
    public AuthenticationSuccessHandler customSuccessHandler() {
        return new CustomSuccessHandler(userService, cartService);
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(authorize -> authorize
                .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()
                .requestMatchers("/", "/client/**", "/login", "/product/**", "/register", "/css/**", "/js/**", "/images/**").permitAll()
                .requestMatchers("/cart", "/cart/**", "/add-to-cart/**", "/buy-now/**", "/api/**",
                                 "/checkout", "/payment/**", "/order-success/**", "/orders", "/orders/**").authenticated()
                .requestMatchers("/admin/**").hasRole("ADMIN")
                .anyRequest().authenticated()
            )
            .formLogin(formLogin -> formLogin
                .loginPage("/login")
                .failureUrl("/login?error")
                .successHandler(customSuccessHandler())
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout")
                .deleteCookies("JSESSIONID", "remember-me")
                .permitAll()
            )
            .rememberMe(rememberMe -> rememberMe
                .key("laptopshop-secret-key")
                .tokenValiditySeconds(7 * 24 * 60 * 60)
                .rememberMeParameter("remember-me")
            )
            .sessionManagement(session -> session
                .sessionCreationPolicy(SessionCreationPolicy.ALWAYS)
                .invalidSessionUrl("/login?expired")
                .maximumSessions(1)
                .maxSessionsPreventsLogin(false)
            )
            .exceptionHandling(ex -> ex
                .accessDeniedPage("/access-denied")
            )
            .csrf(csrf -> csrf.disable());
        return http.build();
    }
}
