package com.Organics.LyncOrganic.repository;

import com.Organics.LyncOrganic.entity.CropTranx;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CropTranx_Repo extends JpaRepository<CropTranx,Long> {
    List<CropTranx> findAllByTid(Long tid);

    @Query("SELECT ct FROM CropTranx ct WHERE ct.tid = :tid AND ct.pid = :pid AND ct.seller_uid = :sellerUid")
    CropTranx findByTidAndPidAndSellerUid(@Param("tid") Long tid,@Param("pid") Long pid,@Param("sellerUid") Long seller_uid);
}
