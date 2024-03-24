package system.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import system.entity.Administrator;
import system.entity.StuClass;
import system.service.StuClassService;
import system.vo.StuClassVo;
import system.vo.StuQueryPageForm;

@Controller
public class StuClassController {
	
	@Autowired
	private StuClassService stuClassService;
	
	/**至班級管理頁面*/
	@RequestMapping("/class_page") 
	public String classPage(HttpServletRequest request) {
		if(request.getSession().getAttribute("allClassList") == null) {
			request.getSession().setAttribute("allClassList", stuClassService.classList());
		}
		return "stu_class";
	}
	
	/**至新增頁面*/
	@RequestMapping("/to_add_class")
	public String toAddClass(HttpServletRequest request) {
		request.setAttribute("addAndEditClassTitle", "新增班級");
		return "add_edit_class";
	}
	
	/**新增*/
	@RequestMapping("/add_class")
	public String addClass(StuClass stuClass, HttpServletRequest request) {
		try {
			Date date = new Date();
			stuClass.setScCreateDate(date);
			stuClass.setScUpdateDate(date);
			Administrator admin = (Administrator) request.getSession().getAttribute("admin");
			stuClass.setClassCreater(admin);
			stuClass.setClassUpdater(admin);
			stuClassService.addClass(stuClass);
		} catch (Exception e) {
			request.setAttribute("error_msg", "*請輸入完整資料");
		}
		request.getSession().setAttribute("allClassList", null);
		return toAddClass(request);
	}
	
	/**至編輯頁面*/
	@RequestMapping("/to_edit_class")
	public String toEditClass(StuQueryPageForm form, HttpServletRequest request) {
		request.setAttribute("addAndEditClassTitle", "編輯班級");
		StuClass toEditClassInfo = stuClassService.getClassById(Integer.parseInt(request.getParameter("editClassId")));
		request.setAttribute("toEditClassInfo", toEditClassInfo);
		return "add_edit_class";
	}
	
	/**編輯*/
	@RequestMapping("/edit_class")
	public String editClass(StuClass userEditClass, StuQueryPageForm form, HttpServletRequest request) {
		try {
			Date date = new Date();
			userEditClass.setScUpdateDate(date);
			Administrator admin = (Administrator) request.getSession().getAttribute("admin");
			userEditClass.setClassUpdater(admin);
			stuClassService.updateClassInfo(userEditClass);
		} catch (Exception e) {
			request.setAttribute("error_msg", "*請輸入完整資料");
		}
		request.getSession().setAttribute("allClassList", null);
		return classPage(request);
	}
	
	/**刪除*/
	@RequestMapping("/delete_class")
	public String deleteClass(StuClassVo vo, HttpServletRequest request) {
		List<Integer> classIdList = new ArrayList<>();
		for(String id : vo.getDeleteClassIds()) {
			Integer classId = Integer.parseInt(id);
			classIdList.add(classId);
		}
		stuClassService.deleteClass(classIdList);
		request.getSession().setAttribute("allClassList", null);
		return classPage(request);
	}

}
