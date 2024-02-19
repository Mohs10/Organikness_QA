package com.Organics.LyncOrganic.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
@Entity
@Table(name = "crop_tranx")
public class CropTranx {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "croptranx_id")
    private Long ctId;
    @Column(name = "seller_uid")
    private Long seller_uid;
    @Column(name = "product_id")
    private Long pid;
    @Column(name = "Quantity")
    private Integer quantity;

    @Column(name = "buyer_uid")
    private Long buyer_uid;

    @Column(name = "tid")
    private Long tid;

    @Column(name = "seller_approve")
    private Boolean sellerApprove;

    @Column(name = "buyer_approve")
    private Boolean buyerApprove;

    @Column(name = "cropAmount")
    private Float cropAmount;

    @Column(name = "Rate_Final")
    private Float rate;

    @Column(name = "Tax_Discount") // default value 1.00
    private Float taxDiscount;
}
