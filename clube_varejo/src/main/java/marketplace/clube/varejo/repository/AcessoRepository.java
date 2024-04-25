package marketplace.clube.varejo.repository;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import marketplace.clube.varejo.model.Acesso;

@Repository
@Transactional
public interface AcessoRepository extends JpaRepository<Acesso, UUID> {

}