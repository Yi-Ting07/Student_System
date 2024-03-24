package system.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import system.entity.Administrator;
import system.repository.AdministratorRepository;

@Service
public class LoginService {
	
	@Autowired
	private AdministratorRepository administratorRepository;
	
	@Transactional
	public Boolean checkAccountInfo(String account, String password) {
		Administrator info = administratorRepository.findByAccountNoAndPassword(account, password);
		if(info == null) {
			return false;
		}else {
			return true;
		}
	}
	
	@Transactional
	public void createAccount(Administrator admin) {
		administratorRepository.save(admin);
	}

}
