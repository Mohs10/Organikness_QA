package com.Organics.LyncOrganic.service;

import org.springframework.stereotype.Service;


@Service
public interface OTPService {

    public String generateRandomOTP();

    public void sendOTP(String phoneNumber, String otp);
//    boolean verifyOtp(String phoneNumber, String otp);


}



