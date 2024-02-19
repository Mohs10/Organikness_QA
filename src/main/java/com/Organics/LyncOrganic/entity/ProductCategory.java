package com.Organics.LyncOrganic.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "productCategory")
@Data
public class ProductCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "category_id")
    private Long cid;

    @Column(name = "product_category")
    private String category;
}
