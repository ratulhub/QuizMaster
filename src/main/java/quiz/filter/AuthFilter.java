package quiz.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Authentication Filter to protect specific pages from unauthorized access.
 * 
 * WHY IT EXISTS:
 * Instead of checking `session.getAttribute("user") != null` in every single Servlet and JSP file
 * (which violates the DRY principle - Don't Repeat Yourself), we use a Filter.
 * 
 * HOW IT WORKS:
 * A Filter intercepts HTTP requests BEFORE they reach the target Servlet or JSP.
 * If the user has a valid session, `chain.doFilter()` passes the request along.
 * If not, the Filter stops the request and redirects them to the login page immediately.
 */
@WebFilter(urlPatterns = {"/pages/user/*", "/pages/modes/*", "/pages/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
            
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        String path = req.getRequestURI();

        if (isLoggedIn) {
            // Admin Protection Check
            if (path.contains("/pages/admin/") && !"ADMIN".equals(session.getAttribute("role"))) {
                res.sendRedirect(req.getContextPath() + "/pages/dashboard.jsp?error=Unauthorized");
                return;
            }
            chain.doFilter(request, response); // Allow request
        } else {
            res.sendRedirect(req.getContextPath() + "/pages/login.jsp?error=Please+login+first");
        }
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
