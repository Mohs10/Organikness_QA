package com.Organics.LyncOrganic.service;

import com.Organics.LyncOrganic.entity.Product;
import org.springframework.data.domain.Page;

import java.util.List;

public interface Product_Service {

    List<Product> findall();

    Product getProductById(Integer pid);

    Product addProduct(Product product);

    Boolean isProductExists(Long pid);

    Boolean isProductExistsByname(String ProductName);
    Page<Product> findPaginated(int pageNo, int pageSize);
    List<String> findAllDistinctCategories();

    Page<Product> findProductsByCategoryPaginated(String category, int pageNo, int pageSize);

    String findNameByPid(Long pid);

    List<String> findAllSellersByProductId(Long pid);

}
