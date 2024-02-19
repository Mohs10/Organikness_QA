package com.Organics.LyncOrganic.serviceImpl;

import com.Organics.LyncOrganic.service.OTPService;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;
import org.springframework.stereotype.Service;

import java.util.Random;


@Service
public class OTP_ServiceImpl implements OTPService {
    private static final String accountSid="AC46ead9f001b78f59c164b127a5e521d5";
    private static final String authToken="7e140faca14eef32ca8b1a3fccbf079b";
    private static final String authPhoneNumber="+19414622715";

    public String generateRandomOTP() {
        Random random = new Random();
        int otp = 1000 + random.nextInt(9000); // 4-digit OTP
        return String.valueOf(otp);
    }
    @Override
    public void sendOTP(String phoneNumber, String otp) {
        Twilio.init(accountSid, authToken);
        phoneNumber="+91"+phoneNumber;
        Message message = Message.creator(
                new PhoneNumber(phoneNumber),
                new PhoneNumber(authPhoneNumber),
                "Your OTP for Lync is : " + otp
        ).create();
    }



}



