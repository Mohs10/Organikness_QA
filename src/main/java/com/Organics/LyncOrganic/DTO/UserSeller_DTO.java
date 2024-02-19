package com.Organics.LyncOrganic.DTO;

import jakarta.persistence.Column;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserSeller_DTO {

    private Long uId;
    private Boolean enableSeller;
    @Size(max = 25, message = "Name must be at most 25 characters.")
    @Pattern(regexp = "^[a-zA-Z ]*$",
            message = "Name must contain only characters.")
    private String userName;
    @Size(max = 30, message = "Email length must be at most 30 characters.")
    @Pattern(regexp = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$",
            message = "Email must contain '@' and '.' and be in a valid format.")
    private String emailId;
    @Pattern(regexp = "^[0-9]{10}$",
            message = "Mobile number must be exactly 10 digits and contain only numeric characters.")
    private String mobileNo;
    private String address;
    private String certifinNo;
    private Date dob;
    private Date regDate;
    private String gender;
    private String organization;
    private List<Product_DTO> listOfProducts= new ArrayList<>();

    private Float maxPrice;
    private Float minPrice;

public  void addProductDetails(Product_DTO productDto){this.listOfProducts.add(productDto);}



}
