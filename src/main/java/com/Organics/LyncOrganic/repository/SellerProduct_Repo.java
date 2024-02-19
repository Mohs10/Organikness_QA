package com.Organics.LyncOrganic.repository;

import com.Organics.LyncOrganic.entity.SellerProduct;
import com.Organics.LyncOrganic.entity.SellerProductKey;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SellerProduct_Repo extends JpaRepository<SellerProduct, SellerProductKey> {

    @Query("SELECT s.rate FROM SellerProduct s WHERE s.uid = :uid AND s.pid = :pid")
    Float findRateByUidAndPid(@Param("uid") Long uid, @Param("pid") Long pid);
    List<SellerProduct> findAllSellerByPid(Long pid);
    Float findByUidAndPid(Long uid, Long pid);

    List<SellerProduct> findProductByUid(@Param("uid")Long uid);
    boolean existsByUidAndPid(Long uid, Long pid);

    @Query("SELECT s FROM SellerProduct s WHERE s.uid = :uid AND s.pid = :pid")
    SellerProduct findProductByUidAndPid(@Param("uid") Long uid, @Param("pid") Long pid);

    @Modifying
    @Query("DELETE FROM SellerProduct s WHERE s.uid = :uid")
    void deleteAllByUid(@Param("uid") Long uid);

    @Modifying
    @Query("DELETE FROM SellerProduct s WHERE s.uid = :uid AND s.pid = :pid")
    void deleteByUidAndPid(@Param("uid") Long uid, @Param("pid") Long pid);


}
