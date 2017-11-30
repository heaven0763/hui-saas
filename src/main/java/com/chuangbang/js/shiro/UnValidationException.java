package com.chuangbang.js.shiro;

import org.apache.shiro.authc.AuthenticationException;

public class UnValidationException extends AuthenticationException{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public UnValidationException() {
        super();
    }

    public UnValidationException(String message, Throwable cause) {
        super(message, cause);
    }

    public UnValidationException(String message) {
        super(message);
    }

    public UnValidationException(Throwable cause) {
        super(cause);
    }
}
