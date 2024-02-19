package com.Organics.LyncOrganic.repository;

import com.Organics.LyncOrganic.entity.Certificate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface Certificate_Repo extends JpaRepository<Certificate, Long> {
    @Query("SELECT c.certName FROM Certificate c WHERE c.certId = :certId")
    String findCertNameById(@Param("certId") Long certId);
}
