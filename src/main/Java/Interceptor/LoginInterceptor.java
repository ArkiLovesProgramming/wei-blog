package Interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("LoginInterceptor - preHandle 方法被触发");
        if (request.getSession().getAttribute("user") == null) {
            System.out.println("用户未登录，重定向到 explore.jsp");
            response.sendRedirect(request.getContextPath() + "/explore.jsp");
            return false;
        }
        System.out.println("用户已登录，继续处理请求");
        return true;
    }
}