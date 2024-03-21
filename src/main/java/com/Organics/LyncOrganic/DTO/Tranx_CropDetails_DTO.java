package com.Organics.LyncOrganic.DTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigInteger;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Tranx_CropDetails_DTO{
    private String productName;
    private Long tid;
    private Long pid;
    private String method;
    private BigInteger totalAmount;
    private Date orderDate;  //Format: YYYY-MM-DD
    private Date lastUpdate; //Format: YYYY-MM-DD
    private String remark;
    private Integer noOfEdits;
    private Long buyer_uid;
    private String buyer_name;
    private Integer quantity;
    private String seller_Name;  /////
    private Long seller_uid;

    private Long statusId;
    private String statusMeaning;
    private Float targetPrice;
    private Float finalPrice;
    private LocalDate dateOfDelivery; //Format: YYYY-MM-DD
    private String deliveryAddress;
    private String paymentStatus;
    private List<String> certification;


//    private List<CropTranxDetails_DTO> listCropTranxDetails = new ArrayList<>();;

//    public void addCropTranxDetails(CropTranxDetails_DTO ctDto) {
//        this.listCropTranxDetails.add(ctDto);
//    }
}
