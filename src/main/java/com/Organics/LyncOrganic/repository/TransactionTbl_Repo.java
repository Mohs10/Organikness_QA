package com.Organics.LyncOrganic.repository;

import com.Organics.LyncOrganic.entity.TransactionTbl;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TransactionTbl_Repo extends JpaRepository<TransactionTbl, Long> {
    @Query("SELECT t.statusId FROM TransactionTbl t WHERE t.tid = :tid")
    Long findStatusIdByTid(@Param("tid") Long tid);
   // Long findStatusIdByTid(Long tid);

    @Query("SELECT t FROM TransactionTbl t WHERE t.seller_uid = :seller_uid AND t.statusId = :statusId")
    List<TransactionTbl> findTranxBySellerUidAndStatusId(@Param("seller_uid") Long sellerUid, @Param("statusId") Long statusId);

    @Query("SELECT t FROM TransactionTbl t WHERE t.seller_uid = :seller_uid")
    List<TransactionTbl> findTranxBySellerUid(@Param("seller_uid") Long sellerUid);

    @Query("SELECT t FROM TransactionTbl t WHERE  t.statusId = :statusId")
    List<TransactionTbl> findTranxByStatusId( @Param("statusId") Long statusId);

    @Query("SELECT t FROM TransactionTbl t WHERE t.statusId >= :statusId")
    List<TransactionTbl> findTranxByStatusIdGreaterThanOrEqual(@Param("statusId") Long statusId);

    @Query("SELECT t FROM TransactionTbl t WHERE t.statusId <= :statusId")
    List<TransactionTbl> findTranxByStatusIdLessThanOrEqual(@Param("statusId") Long statusId);

    @Query("SELECT t FROM TransactionTbl t WHERE t.buyer_uid = :buyer_uid")
    List<TransactionTbl> findTranxByBuyerUid(@Param("buyer_uid") Long buyerUid);

    @Query("SELECT t FROM TransactionTbl t WHERE t.statusId = :statusId")
    Page<TransactionTbl> findTranxByStatusId(@Param("statusId") Long statusId, Pageable pageable);

    @Query("SELECT t FROM TransactionTbl t WHERE t.statusId >= :statusId")
    Page<TransactionTbl> findTranxByStatusIdGreaterThanOrEqual(@Param("statusId") Long statusId, Pageable pageable);

    @Query("SELECT t FROM TransactionTbl t WHERE t.statusId <= :statusId")
    Page<TransactionTbl> findTranxByStatusIdLessThanOrEqual(@Param("statusId") Long statusId, Pageable pageable);

}
