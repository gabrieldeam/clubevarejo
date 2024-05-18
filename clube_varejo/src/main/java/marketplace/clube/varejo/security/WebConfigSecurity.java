package marketplace.clube.varejo.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import marketplace.clube.varejo.service.ImplementacaoUserDetailsService;

@Configuration
@EnableWebSecurity
public class WebConfigSecurity {

    @Autowired
    private ImplementacaoUserDetailsService implementacaoUserDetailsService;

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(implementacaoUserDetailsService).passwordEncoder(passwordEncoder());
    }

    @Configuration
    public static class WebSecurityConfig extends WebSecurityConfigurerAdapter {
        
        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http.csrf().disable()
                .authorizeRequests()
                .antMatchers("/", "/index").permitAll()
                .antMatchers(HttpMethod.OPTIONS, "/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .logout().logoutSuccessUrl("/index").permitAll()
                .and()
                .addFilter(new JWTLoginFilter(authenticationManager()))
                .addFilter(new JwtApiAutenticacaoFilter());
        }
    }
}