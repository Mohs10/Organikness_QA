package com.Organics.LyncOrganic.repository;

import com.Organics.LyncOrganic.entity.ProductCertificate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ProdCertificate_Repo extends JpaRepository<ProductCertificate, Long> {

    @Query("SELECT pc FROM ProductCertificate pc WHERE pc.pid = :pid AND pc.seller_uid = :sellerUid")
    Optional<ProductCertificate> findCertificateByProductIdAndUserId(@Param("pid") Long productId, @Param("sellerUid") Long userId);

    @Query("SELECT pc FROM ProductCertificate pc WHERE pc.pid = :pid AND pc.seller_uid = :sellerUid")
    List<ProductCertificate> findCertificatesByProductIdAndUserId(@Param("pid") Long productId, @Param("sellerUid") Long userId);
    @Query("SELECT pc.certId FROM ProductCertificate pc WHERE pc.pid = :pid AND pc.seller_uid = :sellerUid")
    List<Long> findCertIdsByProductIdAndUserId(@Param("pid") Long productId, @Param("sellerUid") Long userId);
}

