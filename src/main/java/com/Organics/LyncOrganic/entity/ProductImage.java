package com.Organics.LyncOrganic.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "Product_Image")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class ProductImage {
    @Id
    @Column(name = "product_id", unique = true, nullable = false)
    private Long pid;

    @Lob
    @Column(name = "imageContent", columnDefinition = "LONGBLOB")
    private byte[] imageContent;
}