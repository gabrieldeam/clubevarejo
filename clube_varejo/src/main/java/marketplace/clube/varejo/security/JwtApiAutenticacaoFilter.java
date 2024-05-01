package marketplace.clube.varejo.security;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.GenericFilterBean;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;

//Filtro onde todas as requisicoes serão capturadas para autenticar
public class JwtApiAutenticacaoFilter extends GenericFilterBean {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		/*Estabele a autenticao do user*/
		
		Authentication authentication = new JWTTokenAutenticacaoService().
				getAuthetication((HttpServletRequest) request, (HttpServletResponse) response);
		
		/*Coloca o processo de autenticacao para o spring secutiry*/
		SecurityContextHolder.getContext().setAuthentication(authentication);
		
		chain.doFilter(request, response);
		
	}

}
