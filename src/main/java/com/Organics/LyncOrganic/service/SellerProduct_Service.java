package com.Organics.LyncOrganic.service;

import com.Organics.LyncOrganic.DTO.SellerProduct_DTO;
import com.Organics.LyncOrganic.DTO.UserSeller_DTO;
import com.Organics.LyncOrganic.entity.SellerProduct;

import java.util.List;

public interface SellerProduct_Service {
    SellerProduct save(SellerProduct sellerProduct);

    SellerProduct saveProduct(SellerProduct_DTO sellerProductDto);

    List<SellerProduct> findAllSellerByPid(Long pid);

    List<SellerProduct> findProductByUid(Long uid);

    Float getRateByUidAndPid(Long uid, Long pid);

    Boolean existsByUidAndPid(Long uid, Long pid);

    List<UserSeller_DTO> findAllSellerDtoByPid(Long pid);

    UserSeller_DTO findSellerByUidAndPid(Long uid , Long pid);

    void deleteBySellerId(Long uId);

    void deleteBySellerIdProductId(Long uId, Long pId);


//    Boolean existsByPid(Long pid); //Kishan: get product from pid
}
