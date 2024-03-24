package system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import system.entity.StuClass;
import system.repository.StuClassRepository;

@Service
public class StuClassService {
	
	@Autowired
	private StuClassRepository stuClassRepository;
	
	@Transactional
	public List<StuClass> classList() {
		return stuClassRepository.findAll();
	}
	
	@Transactional
	public StuClass addClass(StuClass stuClass) {
		return stuClassRepository.save(stuClass);
	}
	
	@Transactional
	public void deleteClass(List<Integer> classIds) {
		for(Integer id : classIds) {
			stuClassRepository.deleteById(id);
		}
	}
	
	@Transactional
	public StuClass getClassById(Integer classId) {
		return stuClassRepository.findById(classId).get();
	}
	
	@Transactional
	public void updateClassInfo(StuClass userEditClass) {
		StuClass toUpdateClass = getClassById(userEditClass.getScId());
		toUpdateClass.setScClassName(userEditClass.getScClassName());
		toUpdateClass.setScTeacher(userEditClass.getScTeacher());
		toUpdateClass.setScUpdateDate(userEditClass.getScUpdateDate());
		toUpdateClass.setClassUpdater(userEditClass.getClassUpdater());
		stuClassRepository.save(toUpdateClass);
	}
}
