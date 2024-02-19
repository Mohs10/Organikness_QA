package com.Organics.LyncOrganic.entity;

import jakarta.persistence.*;
import lombok.Data;
import org.antlr.v4.runtime.misc.NotNull;

@Entity
@Table(name = "product")
@Data
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Long pid;

    @Column(name = "product_category")
    private String category;

    @Column(name = "product_name")
    private String name;
}