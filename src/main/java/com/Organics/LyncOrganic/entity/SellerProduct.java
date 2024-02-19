package com.Organics.LyncOrganic.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table( name = "Seller_Product")
@Data
@IdClass(SellerProductKey.class)  // composite key
public class SellerProduct {
    // unique combination of pid and uid
    @Id
    @Column(name = "product_id")
    private Long pid;

    @Id
    @Column(name = "uid")
    private Long uid;

    @Column(name = "Rate")
    private Float rate;

    @Column(name = "max_price")
    private Float maxPrice;

    @Column(name = "min_price")
    private Float minPrice;

    @Column(name = "stock_location")
    private String stockLocation;

    @Column(name = "quantity")
    private Float quantity;

    @Column(name = "lab_report")
    private Boolean labReport;

}
