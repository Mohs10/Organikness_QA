package com.Organics.LyncOrganic.serviceImpl;

import com.Organics.LyncOrganic.CustomExceptionHandler.CustomApiException;
import com.Organics.LyncOrganic.DTO.SellerProduct_DTO;
import com.Organics.LyncOrganic.DTO.UserSeller_DTO;
import com.Organics.LyncOrganic.entity.SellerProduct;
import com.Organics.LyncOrganic.entity.TransactionTbl;
import com.Organics.LyncOrganic.entity.UserSeller;
import com.Organics.LyncOrganic.repository.SellerProduct_Repo;
import com.Organics.LyncOrganic.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class SellerProduct_ServiceImpl implements SellerProduct_Service {
    @Autowired
    private SellerProduct_Repo sellerProductRepo;
    @Autowired
    private UserSeller_Service userSellerService;


    @Autowired
    private Certificates_Service certificatesService;
    @Autowired
    private ProductCerti_Service productCertiService;

    @Autowired
    private Product_Service productService;


    @Override
    public SellerProduct save(SellerProduct sellerProduct) {
        // check uid and pid exits in Table and uid is enabled as Seller
        UserSeller userSeller=userSellerService.findById(sellerProduct.getUid().intValue());
        if(userSeller!=null && productService.isProductExists(sellerProduct.getPid())) {
            if(userSeller.getEnableSeller())
                return sellerProductRepo.save(sellerProduct);
            throw new RuntimeException("uid:"+sellerProduct.getUid()+" is not a Seller !!!!");
//            throw new CustomApiException("uid:"+sellerProduct.getUid()+" is not a Seller !!!!", HttpStatus.INTERNAL_SERVER_ERROR);

        }
        throw new RuntimeException("Please check pid, uid is valid or not !!!");
    }

    @Override
    public SellerProduct saveProduct(SellerProduct_DTO sellerProductDto)
    {
        SellerProduct sellerProduct = new SellerProduct();
        sellerProduct.setPid(sellerProductDto.getPid());
        sellerProduct.setUid(sellerProductDto.getUid());
        sellerProduct.setRate(sellerProductDto.getRate());
        sellerProduct.setMaxPrice(sellerProductDto.getMaxPrice());
        sellerProduct.setMinPrice(sellerProductDto.getMinPrice());
        sellerProduct.setQuantity(sellerProductDto.getQuantity());
        sellerProduct.setStockLocation(sellerProductDto.getStockLocation());
        sellerProduct.setLabReport(sellerProductDto.getLabReport());

        SellerProduct addedSellerProduct = save(sellerProduct);
        for (Long certification : sellerProductDto.getCertificationList())
        {
            productCertiService.saveProductCertificateForSellerById(sellerProductDto.getUid(),sellerProductDto.getPid(),certification);
        }

        return addedSellerProduct;
    }

    @Override
    public List<SellerProduct> findAllSellerByPid(Long pid) {
        return sellerProductRepo.findAllSellerByPid(pid);
    }

    @Override
    public List<SellerProduct> findProductByUid(Long uid) {
        return sellerProductRepo.findProductByUid(uid);
    }

    @Override
    public Float getRateByUidAndPid(Long uid, Long pid) {
        if(sellerProductRepo.existsByUidAndPid(uid,pid))
            return sellerProductRepo.findByUidAndPid(uid, pid);
        throw new RuntimeException("Invalid uid or pid  please check !!!!!");
    }

    @Override
    public Boolean existsByUidAndPid(Long uid, Long pid) {
        return sellerProductRepo.existsByUidAndPid(uid,pid);
    }

    @Override
    public List<UserSeller_DTO> findAllSellerDtoByPid(Long pid) {
        List<SellerProduct> sellerProducts= sellerProductRepo.findAllSellerByPid(pid);
        List<UserSeller_DTO> userSellerDtos =new ArrayList<>();
        for(SellerProduct sellerProduct:sellerProducts)
        {
            UserSeller_DTO userSellerDto = new UserSeller_DTO();
            UserSeller seller= userSellerService.findById(Math.toIntExact(sellerProduct.getUid()));
            userSellerDto.setUId(sellerProduct.getUid());
            userSellerDto.setUserName(seller.getUserName());
            userSellerDto.setEmailId(seller.getEmailId());
            userSellerDto.setMobileNo(seller.getMobileNo());
            userSellerDto.setAddress(seller.getAddress());
            userSellerDto.setDob(seller.getDob());
            userSellerDto.setRegDate(seller.getRegDate());
            userSellerDto.setGender(seller.getGender());
            userSellerDto.setOrganization(seller.getOrganization());
            userSellerDto.setMaxPrice(sellerProduct.getMaxPrice());
            userSellerDto.setMinPrice(sellerProduct.getMinPrice());

//            assert false;
            userSellerDtos.add(userSellerDto);
        }

        return userSellerDtos;
    }

    @Override
    public UserSeller_DTO findSellerByUidAndPid(Long uid, Long pid) {

        UserSeller seller= userSellerService.findById(Math.toIntExact(uid));
        UserSeller_DTO userSellerDto = new UserSeller_DTO();
        SellerProduct sellerProduct = sellerProductRepo.findProductByUidAndPid(uid,pid);

        userSellerDto.setUId(uid);
        userSellerDto.setUserName(seller.getUserName());
        userSellerDto.setEmailId(seller.getEmailId());
        userSellerDto.setMobileNo(seller.getMobileNo());
        userSellerDto.setAddress(seller.getAddress());
        userSellerDto.setDob(seller.getDob());
        userSellerDto.setRegDate(seller.getRegDate());
        userSellerDto.setGender(seller.getGender());
        userSellerDto.setOrganization(seller.getOrganization());
        userSellerDto.setMaxPrice(sellerProduct.getMaxPrice());
        userSellerDto.setMinPrice(sellerProduct.getMinPrice());
        return userSellerDto;
    }

    @Override
    public void deleteBySellerId(Long uId) {
        sellerProductRepo.deleteAllByUid(uId);
    }

    @Transactional
    @Override
    public void deleteBySellerIdProductId(Long uId, Long pId) {
        sellerProductRepo.deleteByUidAndPid(uId,pId);
    }

//    @Override
//    public Boolean existsByPid(Long pid) {
//        return ;
//    }
}
