package marketplace.clube.varejo;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import marketplace.clube.varejo.model.Acesso;
import marketplace.clube.varejo.repository.AcessoRepository;
import marketplace.clube.varejo.service.AcessoService;


@SpringBootTest(classes = ClubeVarejoApplication.class)
class ClubeVarejoApplicationTests {

	@Autowired
	private AcessoService acessoService;
	
	@Autowired
	private AcessoRepository acessoRepository;
	
	@Test
	public void testCadastraAcesso() {

		Acesso acesso = new Acesso();
		acesso.setDescricao("ROLE_USER");
		acessoRepository.saveAndFlush(acesso);
	}

}
