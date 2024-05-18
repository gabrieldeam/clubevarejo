package marketplace.clube.varejo.security;

import java.io.IOException;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;


import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import marketplace.clube.varejo.model.Usuario;

public class JWTLoginFilter extends AbstractAuthenticationProcessingFilter {

	//Confgurando o gerenciado de autenticacao
	public JWTLoginFilter(String Url, AuthenticationManager authenticationManager) {
		
		//Ibriga a autenticat a url
		super(new AntPathRequestMatcher(Url));
		
		//Gerenciador de autenticao
		setAuthenticationManager(authenticationManager);
	}

	//Retorna o usuário ao processar a autenticacao
	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException, IOException, ServletException {
		/*Obter o usuário*/
		Usuario user = new ObjectMapper().readValue(request.getInputStream(), Usuario.class);
		
		/*Retorna o user com login e senha*/
		return getAuthenticationManager().
				authenticate(new UsernamePasswordAuthenticationToken(user.getLogin(), user.getSenha()));
	}
	
	@Override
	protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain,
			Authentication authResult) throws IOException, ServletException {
		try {
			new JWTTokenAutenticacaoService().addAuthentication(response, authResult.getName());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
