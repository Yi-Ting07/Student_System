package system.filter;

import java.io.IOException;

import org.springframework.stereotype.Component;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

@WebFilter("/*")
@Component
public class LoginFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		
		HttpServletRequest req = (HttpServletRequest)request;
		boolean login = req.getServletPath().toUpperCase().indexOf("login".toUpperCase()) > 0;
		boolean createAccount = req.getServletPath().toUpperCase().indexOf("createAccount".toUpperCase()) > 0;
		
		// 檢核是否有登入 (排除登入頁面、註冊頁面)
		if(login || createAccount || req.getSession().getAttribute("admin") != null) {
			chain.doFilter(request, response);
			return;
		}else {
			req.getRequestDispatcher("/WEB-INF/jsp/login_page.jsp").forward(request, response);
			return;
		}
	}

}
