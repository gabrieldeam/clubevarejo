package marketplace.clube.varejo;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import junit.framework.TestCase;
import marketplace.clube.varejo.controller.AcessoController;
import marketplace.clube.varejo.model.Acesso;
//import marketplace.clube.varejo.repository.AcessoRepository;
//import marketplace.clube.varejo.service.AcessoService;


@SpringBootTest(classes = ClubeVarejoApplication.class)
class ClubeVarejoApplicationTests extends TestCase{

	//@Autowired
	//private AcessoService acessoService;
	
	//@Autowired
	//private AcessoRepository acessoRepository;
	
	@Autowired
	private AcessoController acessoController;
	
	@Test
	public void testCadastraAcesso() {

		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_ADMIN");
		acesso = acessoController.salvarAcesso(acesso).getBody();
		
	}

}
