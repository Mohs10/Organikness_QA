package com.Organics.LyncOrganic.service;

import com.Organics.LyncOrganic.entity.ProductCertificate;

import java.util.List;

public interface ProductCerti_Service
{
    ProductCertificate saveProductCertificateForSellerById(Long uId,Long pId,Long cId);

    List<ProductCertificate> findProductCertificateOfASeller(Long pId,Long uId);

    List<Long> findCertificateIdOfASellerProduct(Long pId,Long uId);

    List<String> findCertificateNameOfASellerProduct(Long pId,Long uId);


}
