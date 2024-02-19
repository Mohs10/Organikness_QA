package com.Organics.LyncOrganic.serviceImpl;

import com.Organics.LyncOrganic.DTO.SellerProduct_DTO;
import com.Organics.LyncOrganic.entity.ProductCertificate;
import com.Organics.LyncOrganic.repository.Certificate_Repo;
import com.Organics.LyncOrganic.repository.ProdCertificate_Repo;
import com.Organics.LyncOrganic.service.ProductCerti_Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductCerti_ServiceImpl implements ProductCerti_Service {
    @Autowired
    private ProdCertificate_Repo prodCertificateRepo;
    @Autowired
    private Certificate_Repo certificateRepo;
    @Override
    public ProductCertificate saveProductCertificateForSellerById(Long uId,Long pId,Long cId) {
        ProductCertificate productCertificate = new ProductCertificate();
        productCertificate.setPid(pId);
        productCertificate.setSeller_uid(uId);
        productCertificate.setCertId(cId);

        return prodCertificateRepo.save(productCertificate);
    }

    @Override
    public List<ProductCertificate> findProductCertificateOfASeller(Long pId, Long uId) {
        return prodCertificateRepo.findCertificatesByProductIdAndUserId(pId,uId);
    }

    @Override
    public List<Long> findCertificateIdOfASellerProduct(Long pId, Long uId) {
        return prodCertificateRepo.findCertIdsByProductIdAndUserId(pId,uId);
    }

    @Override
    public List<String> findCertificateNameOfASellerProduct(Long pId, Long uId) {

        List<String> certificateNames = new ArrayList<>();

        for(Long cId: prodCertificateRepo.findCertIdsByProductIdAndUserId(pId,uId) )
        {
            certificateNames.add(certificateRepo.findCertNameById(cId));
        }
        return certificateNames;
    }
}
