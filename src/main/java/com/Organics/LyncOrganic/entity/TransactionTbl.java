package com.Organics.LyncOrganic.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigInteger;
import java.time.LocalDate;
import java.util.Date;

@Entity
@Table(name = "Transaction_Tbl")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class TransactionTbl {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tid")
    private Long tid;

    @Column(name = "method")
    private String method;

    @Column(name = "Total_amount")
    private BigInteger totalAmount;

    @Column(name = "Order_Date")
    private Date orderDate;  //Format: YYYY-MM-DD

    @Column(name = "Last_Update")
    private Date lastUpdate; //Format: YYYY-MM-DD

    @Column(name = "Remark")
    private String remark;

//    @Column(name = "Sample")
//    private Boolean forSample;
//
    @Column(name = "edits")
    private Integer noOfEdits;

    @Column(name = "Buyer_uid")
    private Long buyer_uid;

    @Column(name = "Status_id")
    private Long statusId;

    @Column(name = "product_id")
    private Long pid;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "product_name")
    private String productName;

    @Column(name = "seller_uid")
    private Long seller_uid;

    @Column(name = "final_price")
    private Float finalPrice;

    @Column(name = "date_of_delivery")
    private LocalDate dateOfDelivery; //Format: YYYY-MM-DD

    @Column(name = "target_price")
    private Float targetPrice;

    @Column(name = "certification")
    private String certification;

    @Column(name = "delivery_address")
    private String deliveryAddress;

    @Column(name = "payment_status")
    private String paymentStatus;
    @Column(name = "payment_id")
    private String paymentId;

    @Column(name = "payment_date")
    private LocalDate paymentDate;

}
