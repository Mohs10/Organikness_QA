package com.Organics.LyncOrganic.Config;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@Configuration
@EnableMethodSecurity
public class SecurityConfig {

    @Autowired
    public AuthenticationSuccessHandler CustomSuccessHandler;

    private UserDetailsService userDetailsService;

    public SecurityConfig(UserDetailsService userDetailsService){
        this.userDetailsService = userDetailsService;
    }

    @Bean
    public static PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(
            AuthenticationConfiguration configuration) throws Exception {
        return configuration.getAuthenticationManager();
    }
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.authorizeHttpRequests()
                .requestMatchers("/organic/admin/**").hasRole("ADMIN")
                .requestMatchers("/organic/user/**").permitAll()
                .requestMatchers("/organic/sellerbuyer_registerNumber").permitAll()
                .requestMatchers("/organic/sellerbuyer_registerOtp_verify").permitAll()
                .requestMatchers("/organic/sellerbuyer_login").permitAll()
                .requestMatchers("/organic/sellerbuyer_login_verify").permitAll()
                .requestMatchers("/organic/**").permitAll()
                .requestMatchers("/**").permitAll()
                .and()
                .formLogin().loginPage("/login").loginProcessingUrl("/login")
                .successHandler(CustomSuccessHandler)
                .and()
                .logout().logoutUrl("/logout").logoutSuccessUrl("/login?logout")
                .invalidateHttpSession(true)
                .and()
                .csrf().disable();


        return http.build();
    }





//    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
//        http.authorizeHttpRequests()
//                .requestMatchers("/organic/admin/**").hasRole("ADMIN")
//                .requestMatchers("/organic/user/**").permitAll()
//                .requestMatchers("/organic/sellerbuyer_registerNumber").permitAll()
//                .requestMatchers("/organic/sellerbuyer_registerOtp_verify").permitAll()
//                .requestMatchers("/organic/sellerbuyer_login").permitAll()
//                .requestMatchers("/organic/sellerbuyer_login_verify").permitAll()
//                .requestMatchers("/organic/**").permitAll()
//                .requestMatchers("/**").permitAll()
//                .and()
//                .formLogin().loginPage("/login").loginProcessingUrl("/login")
//                .successHandler(CustomSuccessHandler)
//                .and()
//                .logout().logoutUrl("/logout").logoutSuccessUrl("/login?logout")
//                .invalidateHttpSession(true)
//                .and()
//                .csrf().disable();
//
//
//        return http.build();
//    }



}
