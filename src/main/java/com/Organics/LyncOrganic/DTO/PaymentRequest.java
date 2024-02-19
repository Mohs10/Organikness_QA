package com.Organics.LyncOrganic.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PaymentRequest {
    private int amount;
    private String currency;
    private String source;
    private String description;

    // Getters and setters
}

