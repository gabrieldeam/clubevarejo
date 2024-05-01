package marketplace.clube.varejo.repository;

import java.util.UUID;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import marketplace.clube.varejo.model.Usuario;

@Repository
@Transactional
public interface UsuarioRepository extends CrudRepository<Usuario, UUID>{

	@Query(value = "select u from Usuario u where u.login = ?1")
	Usuario findUserByLogin(String login);
}
