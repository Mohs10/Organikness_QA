package com.Organics.LyncOrganic.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Entity
@Table(name = "UserSeller_tbl")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class UserSeller {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "uid")
    private Long uId;
    @Column(name = "enableSeller")
    private Boolean enableSeller;
    @Column(name = "name")
    @Size(max = 25, message = "Name must be at most 25 characters.")
    @Pattern(regexp = "^[a-zA-Z ]*$",
            message = "Name must contain only characters.")
    private String userName;
    @Column(name = "email")
    @Size(max = 30, message = "Email length must be at most 30 characters.")
    @Pattern(regexp = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$",
            message = "Email must contain '@' and '.' and be in a valid format.")
    private String emailId;
    @Column(name = "mobile")
    @Pattern(regexp = "^[0-9]{10}$",
            message = "Mobile number must be exactly 10 digits and contain only numeric characters.")
    private String mobileNo;
    @Column(name = "address")
    private String address;
    // right now it's not being used
    @Column(name = "certifin_no")
    private String certifinNo;
    @Column(name = "date_of_birth")
    private Date dob;
    @Column(name = "reg_date")
    private Date regDate;
    @Column(name = "gender")
    private String gender;
    @Column(name = "organization")
    private String organization;
    @Column(name = "aadhaar") // newly added to this Client suggested
    @Pattern(regexp = "^[0-9]{12}$",
            message = "Aadhaar number must be exactly 12 digits and contain only numeric characters.")
    private String aadhaarNo;
//    @Column(name = "role")
//    private String role;
}
