package com.Organics.LyncOrganic.DTO;

//import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class OTP_DTO {
//    @Pattern(regexp = "^[0-9]{10}$",
//            message = "Mobile number must be exactly 10 digits and contain only numeric characters.")
    private String phoneNumber;
    private String enteredOTP;
}
