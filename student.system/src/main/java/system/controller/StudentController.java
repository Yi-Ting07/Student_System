package system.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import system.entity.Administrator;
import system.entity.Student;
import system.service.AdministratorService;
import system.service.StuClassService;
import system.service.StudentService;
import system.vo.StuQueryPageForm;

@Controller
public class StudentController {
	
	@Autowired
	private StudentService studentService; 
	
	@Autowired
	private StuClassService stuClassService;
	
	@Autowired
	private AdministratorService administratorService;
	
	/**查詢頁面*/
	@RequestMapping("/query_page")
	public String queryPage(StuQueryPageForm form, HttpServletRequest request) {
		if(request.getSession().getAttribute("allClassList") == null) {
			request.getSession().setAttribute("allClassList", stuClassService.classList());
		}
		return "query_page";
	}
	
	/**查詢結果*/
	@RequestMapping("/result_list")
	public String resultList(StuQueryPageForm form, HttpServletRequest request) {
	    form.setStuSearchResultList(studentService.getSearchResult(form.getQuery()));
		return queryPage(form, request);
	}
	
	/**至新增頁面*/
	@RequestMapping("/to_add_student")
	public String toAddStudent(StuQueryPageForm form, HttpServletRequest request) {
		request.setAttribute("addAndEditStuTitle", "新增學生");
		return "add_edit_student";
	}
	
	/**新增*/
	@RequestMapping("/add_student")
	public String addStudent(Student stu, StuQueryPageForm form, HttpServletRequest request) {
		try {
			Date date = new Date();
			stu.setStuCreateDate(date);
			stu.setStuUpdateDate(date);
			Administrator administrator = (Administrator) request.getSession().getAttribute("admin");
			stu.setCreater(administrator);
			stu.setUpdater(administrator);
			studentService.addStudent(stu);
		} catch (Exception e) {
			request.setAttribute("error_msg", "*請輸入完整資料");
		}
		return toAddStudent(form,request);
	}
	
	/**至編輯頁面*/
	@RequestMapping("/to_edit_student")
	public String toEditStudent(StuQueryPageForm form, HttpServletRequest request) {
		request.setAttribute("addAndEditStuTitle", "編輯學生");
		Student toEditStuInfo = studentService.getStudentById(Integer.parseInt(request.getParameter("editStudentId")));
		request.setAttribute("toEditStuInfo", toEditStuInfo);
		return "add_edit_student";
	}
	
	/**編輯*/
	@RequestMapping("/edit_student")
	public String editStudent(Student userEditStu, StuQueryPageForm form, HttpServletRequest request) {
		try {
			Date date = new Date();
			userEditStu.setStuUpdateDate(date);
			Administrator administrator = (Administrator) request.getSession().getAttribute("admin");
			userEditStu.setUpdater(administrator);
			studentService.updateStudent(userEditStu);
		} catch (Exception e) {
			request.setAttribute("error_msg", "*請輸入完整資料");
		}
		
		return queryPage(form, request);
	}
	
	/**刪除*/
	@RequestMapping("/to_delete_student")
	public String toDeleteStudent(StuQueryPageForm form, HttpServletRequest request) {
		List<Integer> studentIdList = new ArrayList<>();
		for(String id : form.getDeleteStudentIds()) {
			Integer stuId = Integer.parseInt(id);
			studentIdList.add(stuId);
		}
		studentService.deleteStudent(studentIdList);
		return resultList(form, request);
	}
	
}
