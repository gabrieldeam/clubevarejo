package marketplace.clube.varejo.security;


import marketplace.clube.varejo.model.Usuario;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import com.fasterxml.jackson.databind.ObjectMapper;


public class JWTLoginFilter extends UsernamePasswordAuthenticationFilter {

	public JWTLoginFilter(String url, AuthenticationManager authenticationManager) {
        super();
        setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher(url, "POST"));
        setAuthenticationManager(authenticationManager);
    }
	
	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
	        throws AuthenticationException {
		try {
	        Usuario user = new ObjectMapper().readValue(request.getInputStream(), Usuario.class);
	        return getAuthenticationManager().authenticate(new UsernamePasswordAuthenticationToken(user.getLogin(), user.getSenha()));
	    } catch (IOException e) {
	        throw new RuntimeException("Erro ao processar a autenticação", e);
	    }
	}
    
    @Override
    protected void successfulAuthentication(HttpServletRequest request,
    		HttpServletResponse response, FilterChain chain, Authentication authResult)
    		throws IOException, ServletException {
    	try {
            new JWTTokenAutenticacaoService().addAuthentication(response, authResult.getName());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}