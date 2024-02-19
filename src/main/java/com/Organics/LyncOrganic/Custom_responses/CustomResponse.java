package com.Organics.LyncOrganic.Custom_responses;

import com.Organics.LyncOrganic.entity.UserSeller;
import lombok.Data;

@Data

public class CustomResponse {
    private String name;
    private String phoneNumber;
    private UserSeller userSeller;
    private String Message;
    // Constructors, getters, and setters
}