package system.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import system.entity.Administrator;
import system.service.AdministratorService;
import system.service.LoginService;

@Controller
public class LoginController {
	
	private final Logger log = LogManager.getLogger(this.getClass());
	
	@Autowired
	private LoginService loginService; 
	
	@Autowired
	private AdministratorService administratorService;
	
	@RequestMapping("/login_page")
	public String loginPage(HttpServletRequest request) {
		log.info("LoginController： 有人進來囉");
		log.info("LoginController-訪問IP：" + getIpAddr(request));
	    return "login_page";
	}
	
	@RequestMapping("/loginSubmit")
	public String login(@RequestParam String account, 
			@RequestParam String password, 
			HttpServletRequest request, HttpServletResponse response, 
			Model model) throws IOException {
		Boolean check = loginService.checkAccountInfo(account, password);
		if(!check) {
			request.setAttribute("error_msg", "帳號或密碼錯誤");
			return loginPage(request);
		}
		Administrator administrator = administratorService.getAdministrator(account);
		request.getSession().setAttribute("admin", administrator);
		response.sendRedirect(request.getContextPath() + "/query_page");
	    return "query_page";
	}
	
	@RequestMapping("/toCreateAccountPage")
	public String toCreateAccountPage( 
			HttpServletRequest request, 
			Model model) {
	    return "create_account";
	}

	@RequestMapping("/createAccount")
	public String createAccount(Administrator admin, 
			HttpServletRequest request, 
			Model model) {
		try {
			loginService.createAccount(admin);
		} catch (Exception e) {
			request.setAttribute("error_msg", "請輸入完整資料");
			return "/create_account";
		}
	    return loginPage(request);
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return loginPage(request);
	}
	
	@GetMapping("/createAccount_checkAccount")
	@ResponseBody
	public Map<String, String> checkAccount(@RequestParam String account, HttpServletRequest request, HttpServletResponse response) throws IOException {
		Administrator administrator = administratorService.getAdministrator(account);
		
		Map<String, String> map = new HashMap<>();
		String result = null;
		if(ObjectUtils.isEmpty(account)) {
			result = "請輸入帳號";
		}else if(administrator == null) {
			result = "此帳號可以使用";
		}else {
			result = "此帳號已被使用";
		}
		map.put("result", result);
		return map;
	}
	
	private String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if(ip == null || ip.length() == 0 ||"unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 ||"unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 ||"unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if(ip == null || ip.length() == 0 ||"unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if(ip == null || ip.length() == 0 ||"unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		if(ip != null && ip.indexOf(",") != -1) {
			String[] ipWithMultiProxy = ip.split(",");
			
			for(int i = 0 ; i < ipWithMultiProxy.length ; ++i) {
				String eachIpSegement = ipWithMultiProxy[i];
				if(!"unknown".equalsIgnoreCase(eachIpSegement)) {
					ip = eachIpSegement;
					break;
				}
			}
		}
		return ip;
	}
}
