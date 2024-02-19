package com.Organics.LyncOrganic.CustomExceptionHandler;

public class ForbiddenException extends RuntimeException {

    public ForbiddenException() {
        super("Access is forbidden.");
    }

    public ForbiddenException(String message) {
        super(message);
    }

    public ForbiddenException(String message, Throwable cause) {
        super(message, cause);
    }
}

