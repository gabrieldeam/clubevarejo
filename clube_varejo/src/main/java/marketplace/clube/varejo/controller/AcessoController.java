package marketplace.clube.varejo.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import marketplace.clube.varejo.model.Acesso;
import marketplace.clube.varejo.repository.AcessoRepository;
import marketplace.clube.varejo.service.AcessoService;

@Controller
@RestController
public class AcessoController {
	
	@Autowired
	private AcessoService acessoService;
	
	@Autowired
	private AcessoRepository acessoRepository;
	
	@ResponseBody /*Poder dar um retorno da API*/
	@PostMapping(value = "/salvarAcesso") /*Mapeando a url para receber JSON*/
	public ResponseEntity<Acesso> salvarAcesso(@RequestBody Acesso acesso) { /*Recebe o JSON e converte pra Objeto*/
		
		Acesso acessoSalvo = acessoService.save(acesso);
		
		return new ResponseEntity<Acesso>(acessoSalvo, HttpStatus.OK);
	}
	
	@ResponseBody /*Poder dar um retorno da API*/
	@PostMapping(value = "/deleteAcesso") /*Mapeando a url para receber JSON*/
	public ResponseEntity<?> deleteAcesso(@RequestBody Acesso acesso) { /*Recebe o JSON e converte pra Objeto*/
		
		acessoRepository.deleteById(acesso.getId());
		
		return new ResponseEntity<>("Acesso Removido", HttpStatus.OK);
	}
	

	@ResponseBody
	@DeleteMapping(value = "/deleteAcessoPorId/{id}") 
	public ResponseEntity<?> deleteAcessoPorId(@PathVariable ("id") UUID id) { 
		
		acessoRepository.deleteById(id);
		
		return new ResponseEntity<>("Acesso Removido", HttpStatus.OK);
	}
	
	
	@ResponseBody
	@GetMapping(value = "/obterAcesso/{id}") 
	public ResponseEntity<Acesso> obterAcesso(@PathVariable ("id") UUID id) { 
		
		Acesso obterAcesso = acessoRepository.findById(id).get();
		
		return new ResponseEntity<Acesso>(obterAcesso, HttpStatus.OK);
	}

	
	@ResponseBody
	@GetMapping(value = "/buscarPorDesc/{desc}") 
	public ResponseEntity<List<Acesso>> buscarPorDesc(@PathVariable ("desc") String desc) { 
		
		List<Acesso> buscarAcesso = acessoRepository.buscarAcessoDesc(desc);
		
		return new ResponseEntity<List<Acesso>>(buscarAcesso, HttpStatus.OK);
	}
}
