package com.Organics.LyncOrganic.serviceImpl;

import com.Organics.LyncOrganic.CustomExceptionHandler.CustomApiException;
import com.Organics.LyncOrganic.DTO.Product_DTO;
import com.Organics.LyncOrganic.DTO.UserSeller_DTO;
import com.Organics.LyncOrganic.ReuseableCodes.ReusableMethods;
import com.Organics.LyncOrganic.entity.SellerProduct;
import com.Organics.LyncOrganic.entity.UserSeller;
import com.Organics.LyncOrganic.repository.UserSeller_Repo;
import com.Organics.LyncOrganic.service.ProductCerti_Service;
import com.Organics.LyncOrganic.service.Product_Service;
import com.Organics.LyncOrganic.service.SellerProduct_Service;
import com.Organics.LyncOrganic.service.UserSeller_Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class UserSeller_ServiceImpl implements UserSeller_Service {
    @Autowired
    UserSeller_Repo userSellerRepo;
    @Autowired
    ReusableMethods reusableMethods;

    private Map<String, List<UserSeller>> userSellerCache = new HashMap<>();

    @Autowired
    @Lazy
    private ProductCerti_Service productCertiService;
    @Autowired
    @Lazy
    private SellerProduct_Service sellerProductService;
    @Autowired
    @Lazy
    private Product_Service productService;
    @Override
    public UserSeller save(UserSeller userSeller) {
        boolean isPresent = userSellerRepo.existsByEmailId(userSeller.getEmailId());

        if (isPresent) {
            throw new CustomApiException("User already exists with this email", HttpStatus.BAD_REQUEST);
        }

        userSeller.setEnableSeller(Boolean.FALSE);
        userSeller.setRegDate(new Date());

        // Save the new user details
        return userSellerRepo.save(userSeller);
    }


    @Override
    public List<UserSeller> findAll() {
        return userSellerRepo.findAll();
    }

    @Override
    public UserSeller findById(Integer uid) {
        return userSellerRepo.findById(Long.valueOf(uid)).orElse(null);
    }

    @Override
    public String enableAsSeller(Integer uid) {
        UserSeller buyer= userSellerRepo.findById(Long.valueOf(uid)).orElse(null);
        if(buyer == null)
            throw new RuntimeException("Buyer not found with Id:"+uid);

        buyer.setEnableSeller(Boolean.TRUE);
        userSellerRepo.save(buyer);
        return "user "+uid+" has been enabled as Seller";
    }
    @Override
    public String disableSeller(Integer uid) {
        UserSeller seller= userSellerRepo.findById(Long.valueOf(uid)).orElse(null);
        if(seller == null)
            throw new RuntimeException("Seller not found with Id:"+uid);

        seller.setEnableSeller(Boolean.FALSE);
        userSellerRepo.save(seller);
        return "user "+uid+" has been Disabled as Seller";
    }
    @Override
    public Boolean isUidPresent(Long uid) {
        return userSellerRepo.existsById(uid);
    }

    @Override
    public UserSeller update(UserSeller userSeller) {
        UserSeller usr;
        if(userSellerRepo.findById(userSeller.getUId()).isPresent()) {
            usr = userSellerRepo.findById(userSeller.getUId()).get();
            // keep the old value of EnableSeller , RegDate

            userSeller.setEnableSeller(usr.getEnableSeller());
            userSeller.setRegDate(usr.getRegDate());
            return userSellerRepo.save(userSeller);
        }
        throw new RuntimeException("Please check entered values to be updated !!!!");
    }
    @Override
    public Page<UserSeller> findPaginated(int pageNo, int pageSize) {
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        return userSellerRepo.findAll(pageable);
    }


    @Override
//    public List<UserSeller> findByNameOrEmailList(String name, String email) {
//        if (name == null) {
//            name = "";
//        }
//        if (email == null) {
//            email = "";
//        }
//
//        String userName = name.toLowerCase();
//        String userEmail = email.toLowerCase();
//
//        return userSellerRepo.findAll().stream()
//                .filter(sellerBuyer ->
//                        reusableMethods.isPartialMatch(sellerBuyer.getUserName().toLowerCase(), userName) ||
//                                reusableMethods.isPartialMatch(sellerBuyer.getEmailId().toLowerCase(), userEmail))
//                .collect(Collectors.toList());
//    }

    public List<UserSeller> findByNameOrEmailList(String name, String email) {
        if (name == null) {
            name = "";
        }
        if (email == null) {
            email = "";
        }

        String key = name.toLowerCase() + "_" + email.toLowerCase();
        if (userSellerCache.containsKey(key)) {
            return userSellerCache.get(key);
        }

        String finalName = name;
        String finalEmail = email;
        List<UserSeller> result = userSellerRepo.findAll().stream()
                .filter(sellerBuyer ->
                        reusableMethods. isPartialMatch(sellerBuyer.getUserName().toLowerCase(), finalName.toLowerCase()) ||
                                reusableMethods.  isPartialMatch(sellerBuyer.getEmailId().toLowerCase(), finalEmail.toLowerCase()))
                .collect(Collectors.toList());

        userSellerCache.put(key, result);
        return result;
    }


    @Override
    public void statusUpdate(Long id ,Boolean status)
    {
        UserSeller sellerBuyer = userSellerRepo.findById(id).orElse(null);
        if (sellerBuyer == null)
            throw new RuntimeException(id+" does not exist and trying to enable");
        sellerBuyer.setEnableSeller(status);
        userSellerRepo.save(sellerBuyer);
    }



    @Override
    public boolean phoneNumberIsPresent(String mobileNo) {
        List<UserSeller>sellerBuyers=userSellerRepo.findAll();
        for (UserSeller sellerBuyer: sellerBuyers)
        {
            if (sellerBuyer.getMobileNo().equals(mobileNo))
            {
                return true;
            }

        }
        return false;
    }

    @Override
    public UserSeller findByContactNumber(String mobileNo) {

        List<UserSeller>sellerBuyers=userSellerRepo.findAll();
        for (UserSeller sellerBuyer: sellerBuyers)
        {
            if (sellerBuyer.getMobileNo().equals(mobileNo))
            {
                return sellerBuyer;
            }

        }
        return null;
    }

    @Override
    public String findUserNameByUId(Long uId) {
        return userSellerRepo.findUserNameByuId(uId);
    }

    @Override
    public List<UserSeller> findSellers() {
        return userSellerRepo.findByEnableSellerTrue();
    }

    @Override
    public List<UserSeller> findBuyers() {
        return userSellerRepo.findByEnableSellerFalse();
    }

    @Override
    public Page<UserSeller> findSellersPaginatedByFilter(int pageNo, String filter, int pageSize) {
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        if (filter.equalsIgnoreCase("seller"))
        {
            return userSellerRepo.findByEnableSellerTrue(pageable);
        }
        else
        {
            return userSellerRepo.findByEnableSellerFalse(pageable);

        }
    }

    @Override
    public Page<UserSeller> findSellersPaginated(int pageNo, int pageSize) {
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        return userSellerRepo.findByEnableSellerTrue(pageable);
    }

    @Override
    public Page<UserSeller> findBuyersPaginated(int pageNo, int pageSize) {
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        return userSellerRepo.findByEnableSellerFalse(pageable);
    }

    @Override
    public UserSeller_DTO findByUidWithProducts(Integer uid) {
        UserSeller_DTO userSellerDto = new UserSeller_DTO();
        UserSeller userSeller= userSellerRepo.findById(Long.valueOf(uid)).get();

        userSellerDto.setUId(userSeller.getUId());
        userSellerDto.setEnableSeller(userSeller.getEnableSeller());
        userSellerDto.setUserName(userSeller.getUserName());
        userSellerDto.setEmailId(userSeller.getEmailId());
        userSellerDto.setMobileNo(userSeller.getMobileNo());
        userSellerDto.setAddress(userSeller.getAddress());
        userSellerDto.setCertifinNo(userSeller.getCertifinNo());
        userSellerDto.setDob(userSeller.getDob());
        userSellerDto.setRegDate(userSeller.getRegDate());
        userSellerDto.setGender(userSeller.getGender());
        userSellerDto.setOrganization(userSeller.getOrganization());

        List<SellerProduct> products= sellerProductService.findProductByUid(Long.valueOf(uid));
        for(SellerProduct product: products)
        {
            Product_DTO productDto= new Product_DTO();

            String category = productService.getProductById(Math.toIntExact(product.getPid())).getCategory();

            productDto.setPid(product.getPid());
            productDto.setName(productService.findNameByPid(product.getPid()));
            productDto.setCategory(category);
            productDto.setMinPrice(product.getMinPrice());
            productDto.setMaxPrice(product.getMaxPrice());

            productDto.setCertificationName(productCertiService.findCertificateNameOfASellerProduct(Long.valueOf(uid),product.getPid()));
            productDto.setQuantity(product.getQuantity());
            productDto.setRate(product.getRate());
            userSellerDto.addProductDetails(productDto);
        }

        return userSellerDto;
    }

    @Override
    public void deleteUserById(Integer uId) {
        System.out.println("Deleting user with ID: " + uId);

        // Delete associated SellerProduct entities
        List<SellerProduct> sellerProducts = sellerProductService.findProductByUid(Long.valueOf(uId));
        for (SellerProduct sellerProduct : sellerProducts) {
            System.out.println("Deleting SellerProduct with ID: " + sellerProduct.getPid());
                sellerProductService.deleteBySellerIdProductId(Long.valueOf(uId),sellerProduct.getPid());
        }

        // Delete the user
        userSellerRepo.deleteById(Long.valueOf(uId));
        System.out.println("User deleted with ID: " + uId);
    }

    @Override
    public UserSeller updateUserSeller(Integer uid,UserSeller_DTO userSellerDto)

    {
        UserSeller userSeller = userSellerRepo.findById(Long.valueOf(uid)).get();
        userSeller.setUserName(userSellerDto.getUserName());
        userSeller.setDob(userSellerDto.getDob());
        userSeller.setGender(userSellerDto.getGender());
        userSeller.setEmailId(userSellerDto.getEmailId());
        userSeller.setAddress(userSellerDto.getAddress());
        userSeller.setOrganization(userSellerDto.getOrganization());
        return userSellerRepo.save(userSeller);
    }


}
