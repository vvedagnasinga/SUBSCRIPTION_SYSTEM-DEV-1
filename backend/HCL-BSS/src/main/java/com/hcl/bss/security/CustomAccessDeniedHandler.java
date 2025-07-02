package com.hcl.bss.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;
/**
 * This class is used to send authorization error 
 * @author aditya-gu
 *
 */
@Component
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

    @Override
    public void handle(final HttpServletRequest request, final HttpServletResponse response, final AccessDeniedException ex) throws IOException, ServletException {
        response.getOutputStream().print("Access is denied");
        response.setStatus(403);
        response.setContentType("application/json");
        // response.sendRedirect("/my-error-page");
    }

}