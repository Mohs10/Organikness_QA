package com.Organics.LyncOrganic.controller;

import com.Organics.LyncOrganic.Custom_responses.CustomResponse;
import com.Organics.LyncOrganic.DTO.OTP_DTO;
import com.Organics.LyncOrganic.entity.UserSeller;
import com.Organics.LyncOrganic.service.OTPService;
import com.Organics.LyncOrganic.service.OTPStorageService;
import com.Organics.LyncOrganic.service.UserSeller_Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/organic")
public class SellerBuyerLoginController {
    @Autowired
    private UserSeller_Service userSellerService;
    @Autowired
    private OTPService otpService;
    @Autowired
    private OTPStorageService otpStorageService;


    @PostMapping("/sellerbuyer_registerNumber")//Number verification sending otp
    public ResponseEntity<Map<String, String>> registerNumber (@RequestBody OTP_DTO otpDetails) {


        Map<String, String> response = new HashMap<>();
        String phoneNumber = otpDetails.getPhoneNumber();
        Boolean isPresent = userSellerService.phoneNumberIsPresent(phoneNumber);

        if (isPresent)
        {
            response.put("message", "Number already exists.");
            response.put("phoneNumber", phoneNumber);
            return ResponseEntity.status(HttpStatus.OK).body(response);
        }

        else
        {
            if (phoneNumber.matches("^[0-9]{10}$")) {
                String otp = otpService.generateRandomOTP();
                otpStorageService.storeOTP(phoneNumber, otp);
                otpService.sendOTP(phoneNumber, otp);
                response.put("message", "OTP generated");
                response.put("phoneNumber", phoneNumber);
                return ResponseEntity.status(HttpStatus.OK).body(response);
            } else {
                response.put("message", "Invalid Number");
                response.put("phoneNumber", phoneNumber);
                return ResponseEntity.status(HttpStatus.OK).body(response);
            }
        }
    }
    @PostMapping("/sellerbuyer_registerOtp_verify")//Otp verification
    public ResponseEntity<Map<String, String>> registerOTPVerify (@RequestBody OTP_DTO otpDetails) {

        String phoneNumber=otpDetails.getPhoneNumber();
        String enteredOTP=otpDetails.getEnteredOTP();

        Map<String, String> response = new HashMap<>();
        String storedOTP = otpStorageService.getStoredOTP(phoneNumber);


        if (storedOTP != null && enteredOTP.equals(storedOTP)) {
            otpStorageService.removeOTP(phoneNumber); // Remove the OTP after successful verification
            response.put("phoneNumber", phoneNumber);

            response.put("message", "Verified successfully.");

            return ResponseEntity.status(HttpStatus.OK).body(response);

        } else {
            response.put("phoneNumber", phoneNumber);
            response.put("message", "Invalid OTP. Authentication failed.");

            return ResponseEntity.badRequest().body(response);
        }
    }



    @PostMapping("/sellerbuyer_login") // Input number
    public ResponseEntity<Map<String, String>> sellerBuyerLogin (@RequestBody OTP_DTO otpDetails) {

        String phoneNumber=otpDetails.getPhoneNumber();
        Boolean isPresent = userSellerService.phoneNumberIsPresent(phoneNumber);

        Map<String, String> response = new HashMap<>();

        if (isPresent) {
            String otp = otpService.generateRandomOTP();
            otpStorageService.storeOTP(phoneNumber, otp);
            System.out.println(otpStorageService.getStoredOTPs());

            otpService.sendOTP(phoneNumber, otp);
//            sellerBuyerService.setRoleForUser(phoneNumber, "USER");

            response.put("message", "OTP generated");
            response.put("phoneNumber", phoneNumber);

            return ResponseEntity.status(HttpStatus.OK).body(response);
        } else {
            response.put("message", "Registration required");
            response.put("phoneNumber", phoneNumber);

            return ResponseEntity.status(HttpStatus.OK).body(response);
        }
    }

    @PostMapping("/sellerbuyer_login_verify")
    public ResponseEntity<CustomResponse> verifyOTP(@RequestBody OTP_DTO otpDetails) {
        String phoneNumber = otpDetails.getPhoneNumber();
        String enteredOTP = otpDetails.getEnteredOTP();
        Boolean isPresent = userSellerService.phoneNumberIsPresent(phoneNumber);

        if (isPresent) {
            UserSeller user = userSellerService.findByContactNumber(phoneNumber);
            String storedOTP = otpStorageService.getStoredOTP(phoneNumber);

            if (storedOTP != null && enteredOTP.equals(storedOTP)) {
                otpStorageService.removeOTP(phoneNumber); // Remove the OTP after successful verification

                // Create a CustomResponse object with the user details
                CustomResponse response = new CustomResponse();
                response.setName(user.getUserName());
                response.setPhoneNumber(phoneNumber);
                response.setUserSeller(user);
                response.setMessage("Login Successful");
                return ResponseEntity.status(HttpStatus.OK).body(response);
            } else {
                // Invalid OTP response
                CustomResponse response = new CustomResponse();
                response.setPhoneNumber(phoneNumber);
                response.setMessage("Invalid OTP. Authentication failed.");

                return ResponseEntity.badRequest().body(response);
            }
        } else {
            // Registration required response
            CustomResponse response = new CustomResponse();
            response.setMessage("Registration required");
            response.setPhoneNumber(phoneNumber);

            return ResponseEntity.badRequest().body(response);
        }
    }


}
