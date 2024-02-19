package com.Organics.LyncOrganic.repository;

import com.Organics.LyncOrganic.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface Product_Repo extends JpaRepository<Product, Long> {

    @Query("SELECT p.name FROM Product p WHERE p.pid = :pid")
    String findNameByPid(@Param("pid") Long pid);
    Page<Product> findByCategory(String category, Pageable pageable);

    @Query("SELECT DISTINCT p.category FROM Product p")
    List<String> findDistinctCategories();

    @Query("SELECT CASE WHEN COUNT(p) > 0 THEN true ELSE false END FROM Product p WHERE p.name = :name")
    boolean existsProductByName(@Param("name") String name);
}
