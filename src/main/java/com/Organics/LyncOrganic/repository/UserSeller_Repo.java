package com.Organics.LyncOrganic.repository;

import com.Organics.LyncOrganic.entity.UserSeller;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserSeller_Repo extends JpaRepository<UserSeller,Long> {

    // Correct
    @Query("SELECT userSeller.userName FROM UserSeller userSeller WHERE userSeller.uId = :uId")
    String findUserNameByuId(@Param("uId") Long uId);

    boolean existsByMobileNo(String mobileNo);
    List<UserSeller> findByEnableSellerTrue();
    List<UserSeller> findByEnableSellerFalse();
    Page<UserSeller> findByEnableSellerTrue(Pageable pageable);
    Page<UserSeller> findByEnableSellerFalse(Pageable pageable);
    UserSeller findByMobileNo(String mobileNo);

    boolean existsByEmailId(String emailId);



}
