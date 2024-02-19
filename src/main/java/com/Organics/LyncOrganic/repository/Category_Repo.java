package com.Organics.LyncOrganic.repository;

import com.Organics.LyncOrganic.entity.ProductCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface Category_Repo extends JpaRepository<ProductCategory, Long> {
    @Query("SELECT pc.category FROM ProductCategory pc")
    List<String> findAllCategoryNames();
    @Query("SELECT COUNT(pc) > 0 FROM ProductCategory pc WHERE pc.category = :categoryName")
    boolean existsByCategoryName(@Param("categoryName") String categoryName);
}
