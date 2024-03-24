package system.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import system.entity.Administrator;

@Repository
public interface AdministratorRepository extends JpaRepository<Administrator, Integer>{
	
	@Query(nativeQuery = true, value = "SELECT * FROM administrator WHERE admin_account_no = ?1 AND admin_password = ?2")
	Administrator findByAccountNoAndPassword (String accNo, String password);

	@Query(nativeQuery = true, value = "SELECT * FROM administrator WHERE admin_account_no = ?")
	Administrator findByAccountNo (String accNo);
}
