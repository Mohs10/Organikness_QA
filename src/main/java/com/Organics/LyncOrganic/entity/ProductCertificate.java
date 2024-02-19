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
@Table(name = "prod_certificate")
public class ProductCertificate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "seller_uid")
    private Long seller_uid;

    @Column(name = "product_id")
    private Long pid;

    @Column(name = "certificate_id")
    private Long certId;
}
