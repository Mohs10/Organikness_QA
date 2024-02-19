package com.Organics.LyncOrganic.DTO;

import jakarta.persistence.Column;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class SellerProduct_DTO {

    private Long pid;
    private Long uid;
    private Float rate;
    private Float maxPrice;
    private Float minPrice;
    private String stockLocation;
    private Float quantity;
    private Boolean labReport;
    private List<Long> certificationList;
    private List<String> certification;

}
