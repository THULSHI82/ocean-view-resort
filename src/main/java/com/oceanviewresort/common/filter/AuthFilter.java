package com.oceanviewresort.common.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter({"/dashboard", "/dashboard.jsp"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("loggedUser") == null) {
            ((HttpServletResponse) response).sendRedirect("login.jsp");
        } else {
            chain.doFilter(request, response);
        }
    }
}