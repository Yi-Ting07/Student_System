package system.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import system.entity.Administrator;
import system.repository.AdministratorRepository;

@Service
public class AdministratorService {
	
	@Autowired
	private AdministratorRepository administratorRepository;
	
	@Transactional
	public Administrator getAdministrator(String account) {
		return administratorRepository.findByAccountNo(account);
	}
}
