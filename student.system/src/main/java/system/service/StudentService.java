package system.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;
import system.entity.Administrator;
import system.entity.StuClass;
import system.entity.Student;
import system.repository.StudentRepository;
import system.vo.StuQuery;
import system.vo.StuSearchResult;

@Service
public class StudentService {
	
	@Autowired
	private StudentRepository studentRepository;
			
	/**依照查詢條件，取得查詢結果*/
	@Transactional
	public List<StuSearchResult> getSearchResult(StuQuery stuQuery){
		
		Specification<Student> sp = new Specification<Student>() {

			@Override
			public Predicate toPredicate(Root<Student> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				
				List<Predicate> predicatesList = new ArrayList<>();

				// 學生區塊
				if(!ObjectUtils.isEmpty(stuQuery.getStuName())) {
					predicatesList.add(cb.equal(root.get("stuName"), stuQuery.getStuName()));
				}
				if(!ObjectUtils.isEmpty(stuQuery.getStuNo())) {
					predicatesList.add(cb.equal(root.get("stuNo"), stuQuery.getStuNo()));
				}
				if(!ObjectUtils.isEmpty(stuQuery.getStuGender())) {
					predicatesList.add(cb.equal(root.get("stuGender"), stuQuery.getStuGender()));
				}
				
				// 班級區塊
				if(!ObjectUtils.isEmpty(stuQuery.getScClassName()) || !ObjectUtils.isEmpty(stuQuery.getScTeacher())) {
					Join<Student,StuClass> joinStuClass = root.join("stuClass");
					if(!ObjectUtils.isEmpty(stuQuery.getScClassName())) {
						predicatesList.add(cb.equal(joinStuClass.get("scClassName"), stuQuery.getScClassName()));
					}
					if(!ObjectUtils.isEmpty(stuQuery.getScTeacher())) {
						predicatesList.add(cb.equal(joinStuClass.get("scTeacher"), stuQuery.getScTeacher()));
					}
				}
				
				// 建立人區塊
				if(!ObjectUtils.isEmpty(stuQuery.getCreaterName())) {
					Join<Student,Administrator> joinAdministrator = root.join("creater");
					predicatesList.add(cb.equal(joinAdministrator.get("adminName"), stuQuery.getCreaterName()));
				}
				// 更新人區塊
				if(!ObjectUtils.isEmpty(stuQuery.getUpdaterName())) {
					Join<Student,Administrator> joinAdministrator = root.join("updater");
					predicatesList.add(cb.equal(joinAdministrator.get("adminName"), stuQuery.getUpdaterName()));
				}
				query.orderBy(cb.asc(root.get("stuNo")));
				Predicate[] predicates = new Predicate[predicatesList.size()];
				return cb.and(predicatesList.toArray(predicates));
			}
			
		};
		
		 
		List<Student> stuList= studentRepository.findAll(sp);
		List<StuSearchResult> resultList = new ArrayList<>();
		for(Student stu : stuList) {
			StuSearchResult eachSearchResult = new StuSearchResult();
			eachSearchResult.setStuId(stu.getStuId());
			eachSearchResult.setStuNo(stu.getStuNo());
			eachSearchResult.setStuName(stu.getStuName());
			eachSearchResult.setStuGender(stu.getStuGender());
			eachSearchResult.setScClassName(stu.getStuClass().getScClassName());
			eachSearchResult.setScTeacher(stu.getStuClass().getScTeacher());
			eachSearchResult.setStuCreateDate(stu.getStuCreateDate());
			eachSearchResult.setStuCreater(stu.getCreater().getAdminName());
			eachSearchResult.setStuUpdateDate(stu.getStuUpdateDate());
			eachSearchResult.setStuUpdater(stu.getUpdater().getAdminName());
			resultList.add(eachSearchResult);
		}
		return resultList;
	}
	
	@Transactional
	public void addStudent(Student stu) {
		studentRepository.save(stu);
	}
	
	@Transactional
	public void deleteStudent(List<Integer> stuIds) {
		for(Integer id : stuIds) {
			studentRepository.deleteById(id);
		}
	}
	
	@Transactional
	public Student getStudentById(Integer stuId) {
		return studentRepository.findById(stuId).get();
	}
	
	@Transactional
	public void updateStudent(Student userEditStu) {
		Student toUpdateStudent = getStudentById(userEditStu.getStuId());
		toUpdateStudent.setStuNo(userEditStu.getStuNo());
		toUpdateStudent.setStuName(userEditStu.getStuName());
		toUpdateStudent.setStuGender(userEditStu.getStuGender());
		toUpdateStudent.setStuClass(userEditStu.getStuClass());
		toUpdateStudent.setStuUpdateDate(userEditStu.getStuUpdateDate());
		toUpdateStudent.setUpdater(userEditStu.getUpdater());
		studentRepository.save(toUpdateStudent);
	}
}
