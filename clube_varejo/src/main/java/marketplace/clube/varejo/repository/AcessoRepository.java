package marketplace.clube.varejo.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import marketplace.clube.varejo.model.Acesso;

@Repository
@Transactional
public interface AcessoRepository extends JpaRepository<Acesso, UUID> {

	@Query("select a from Acesso a where upper(trim(a.descricao)) like %?1%")
	List<Acesso> buscarAcessoDesc(String desc);
	
}