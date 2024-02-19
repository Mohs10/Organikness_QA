package com.Organics.LyncOrganic.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CropTranxDetails_DTO {
    private Long ctId;
    private Long seller_uid;
    private String seller_Name;  /////
    private Long pid;
    private String productName;
    private Integer quantity;
    private Long buyer_uid;
    private String buyer_Name;  ////
    private Long tid;
    private Boolean sellerApprove;
    private Boolean buyerApprove;
    private Float cropAmount;
    private Float rate;
    private Float taxDiscount;
}
