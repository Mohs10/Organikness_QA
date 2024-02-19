package com.Organics.LyncOrganic.service;

import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public interface OTPStorageService {

    public void storeOTP(String identifier, String otp);
    public String getStoredOTP(String identifier);

    public void removeOTP(String identifier);

    public Map<String, String> getStoredOTPs();


}
