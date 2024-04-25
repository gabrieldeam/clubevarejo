package marketplace.clube.varejo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EntityScan(basePackages = "marketplace.clube.varejo.model")
@ComponentScan(basePackages = {"marketplace.*"})
@EnableJpaRepositories(basePackages = {"marketplace.clube.varejo.repository"})
@EnableTransactionManagement
public class ClubeVarejoApplication {

	public static void main(String[] args) {
		SpringApplication.run(ClubeVarejoApplication.class, args);
	}

}
