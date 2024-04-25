package marketplace.clube.varejo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import marketplace.clube.varejo.model.Acesso;
import marketplace.clube.varejo.repository.AcessoRepository;


@Service
public class AcessoService {
	
	@Autowired
	private AcessoRepository acessoRepository;
	
	public Acesso save(Acesso acesso) {
		return acessoRepository.save(acesso);
	}

}
