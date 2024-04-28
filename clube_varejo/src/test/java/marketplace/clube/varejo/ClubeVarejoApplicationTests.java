package marketplace.clube.varejo;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import junit.framework.TestCase;
import marketplace.clube.varejo.controller.AcessoController;
import marketplace.clube.varejo.model.Acesso;
import marketplace.clube.varejo.repository.AcessoRepository;

@SpringBootTest(classes = ClubeVarejoApplication.class)
class ClubeVarejoApplicationTests extends TestCase{

	
	@Autowired
	private AcessoController acessoController;
	
	@Autowired
	private AcessoRepository acessoRepository;
	
	@Test
	public void testCadastraAcesso() {

		// Criar e salvar o acesso
		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_ADMIN2");
		acesso = acessoController.salvarAcesso(acesso).getBody();
		
		// Consultar o acesso pelo ID
	    Acesso acessoSalvo = acessoRepository.findById(acesso.getId()).orElse(null);
	    
	    // Verificar se o acesso foi encontrado
	    assertNotNull(acessoSalvo);
	    
	    // Verificar se a descrição é a esperada
	    assertEquals("ROLE_ADMIN2", acessoSalvo.getDescricao());
	    
	    // Teste de delete
	    acessoRepository.deleteById(acessoSalvo.getId());
	    
	    acessoRepository.flush();
	    
	    Acesso acessoDelete = acessoRepository.findById(acessoSalvo.getId()).orElse(null);
	    
	    assertNull(acessoDelete);
	    
	    // Teste de query
	    acesso = new Acesso();
		acesso.setDescricao("ROLE_ALUNO");
		acesso = acessoController.salvarAcesso(acesso).getBody();
		
		List<Acesso> acessos = acessoRepository.buscarAcessoDesc("ALUNO".trim().toUpperCase());
		
		assertEquals(1, acessos.size());
		
		acessoRepository.deleteById(acesso.getId());
	}

}
