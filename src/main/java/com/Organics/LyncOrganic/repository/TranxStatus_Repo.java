package com.Organics.LyncOrganic.repository;

import com.Organics.LyncOrganic.entity.TranxStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface TranxStatus_Repo extends JpaRepository<TranxStatus,Long> {

    @Query("SELECT ts.meaning FROM TranxStatus ts WHERE ts.statusId = :statusId")
    String findMeaningByStatusId(@Param("statusId") Long statusId);
}
