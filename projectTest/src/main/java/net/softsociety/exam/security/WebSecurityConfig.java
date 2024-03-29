package net.softsociety.exam.security;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

/**
 * Security 설정
 */
@Configuration
public class WebSecurityConfig {
    @Autowired
    private DataSource dataSource;

    //설정
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf().disable()
        .authorizeRequests()
        .antMatchers(
        
        		"/",
        		"/member/join",
        		"/member/idcheck",
        		"/member/nickname_check",
        		"/member/email_check",
        		"/tagify2",
        		"/getTagifyList",
                "/images/**",
                "/css/**",
                "/js/**",
                "/scripts/**",
                "/fonts/**",
                "/sukso/**"
                ).permitAll()
        .anyRequest().authenticated()
        .and()
        .formLogin()					
        .loginPage("/member/login")	
        .loginProcessingUrl("/member/login").permitAll()
        .usernameParameter("mem_id")
        .passwordParameter("mem_password")
        .and()
        .logout()
        .logoutUrl("/member/logout")
        .logoutSuccessUrl("/").permitAll()
        .and()
        .cors()
        .and()
        .httpBasic();

        return http.build();
    }

    //인증을 위한 쿼리
    @Autowired
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication()
        .dataSource(dataSource)
        // 인증 (로그인)
        .usersByUsernameQuery(
        		"select mem_id username, mem_password password, mem_state enabled " +
                "from PP_member " +
                "where mem_id = ?")
        // 권한
        .authoritiesByUsernameQuery(
        		"select mem_id username, mem_role role_name  " +
                "from PP_member " +
                "where mem_id = ?");
    }

    // 단방향 비밀번호 암호화
    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }
}
