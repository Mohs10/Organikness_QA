package com.Organics.LyncOrganic.DTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class Quotation_DTO
{
    private String productName;
    private String productCategory;
    private String buyerName;
    private String buyerAddress;
    private String buyerContact;
    private float finalPrice;
    private LocalDate dateOfDelivery;
}
