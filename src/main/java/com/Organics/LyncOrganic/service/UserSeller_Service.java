package com.Organics.LyncOrganic.service;

import com.Organics.LyncOrganic.DTO.UserSeller_DTO;
import com.Organics.LyncOrganic.entity.UserSeller;
import org.springframework.data.domain.Page;

import java.util.List;

public interface UserSeller_Service {
   UserSeller save(UserSeller buyer);

   List<UserSeller> findAll();

   UserSeller findById(Integer uid);

   String enableAsSeller(Integer uid);

   Boolean isUidPresent(Long uid);

   UserSeller update(UserSeller userSeller);

	String disableSeller(Integer uid);
   Page<UserSeller> findPaginated(int pageNo, int pageSize);

   void statusUpdate(Long id, Boolean status);

   List<UserSeller> findByNameOrEmailList(String name , String email);

   boolean phoneNumberIsPresent(String mobileNo);

   UserSeller findByContactNumber(String mobileNo);

   String findUserNameByUId(Long uId);

   List<UserSeller>findSellers();
   List<UserSeller>findBuyers();


   Page<UserSeller> findSellersPaginatedByFilter(int pageNo,String filter, int pageSize);

   Page<UserSeller> findSellersPaginated(int pageNo, int pageSize);
   Page<UserSeller> findBuyersPaginated(int pageNo, int pageSize);


   UserSeller_DTO findByUidWithProducts(Integer uid);


   void deleteUserById(Integer uId);

   UserSeller updateUserSeller(Integer uid ,UserSeller_DTO userSellerDto);

}
