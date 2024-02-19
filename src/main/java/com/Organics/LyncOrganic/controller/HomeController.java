package com.Organics.LyncOrganic.controller;


import com.Organics.LyncOrganic.DTO.Product_DTO;
import com.Organics.LyncOrganic.DTO.Tranx_CropDetails_DTO;
import com.Organics.LyncOrganic.DTO.UserSeller_DTO;
import com.Organics.LyncOrganic.entity.*;
import com.Organics.LyncOrganic.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;


@Controller
public class HomeController {



    @Autowired
    private Product_Service productService;
    @Autowired
    private SellerProduct_Service sellerProductService;

    @Autowired
    private TransactionTbl_Service tranxService;
    @Autowired
    private ProductImage_Service productImageService;
    @Autowired
    private TranxStatus_Service tranxStatusService;
    @Autowired
    private UserSeller_Service userSellerService;
    @Autowired
    private TransactionTbl_Service tranxTblService;
    @Autowired
    private  ProdCategory_Services prodCategoryServices;


    @GetMapping("/")//add this in home controller
    public String first()
    {
        return "redirect:/login";
    }
    @GetMapping("/login")//add this in home controller
    public String login()
    {
        return "Login";
    }

    @GetMapping("organic/admin/") // Dashboard
    public String dashBoard(Model model) {
        try {
            List<UserSeller> allUserSellers = userSellerService.findAll();

            // Count of buyers
            long buyersCount = allUserSellers.stream()
                    .filter(sellerBuyer -> !sellerBuyer.getEnableSeller())
                    .count();
            model.addAttribute("BuyersCount", buyersCount);

            // Count of sellers
            long sellersCount = allUserSellers.stream()
                    .filter(UserSeller::getEnableSeller)
                    .count();
            model.addAttribute("SellersCount", sellersCount);

            // Count of new users registered on the current date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String currentDateStr = dateFormat.format(new Date());
            long newUsersCount = allUserSellers.stream()
                    .filter(sellerBuyer -> {
                        String regDateStr = dateFormat.format(sellerBuyer.getRegDate());
                        return regDateStr.equals(currentDateStr);
                    })
                    .count();
            model.addAttribute("NewUsersCount", newUsersCount);


            long productCount = productService.findall().size();
            model.addAttribute("productCount", productCount);

            return "Dashboard";
        } catch (Exception e) {
            // Handle exceptions appropriately, such as logging or displaying an error message
            e.printStackTrace();
            return "ErrorPage";
        }
    }

    @GetMapping("organic/admin/sellerbuyers") //User page
    public String getAllSellerBuyer(Model model ,HttpSession session){
        return findPaginated(1, model);
    }
    @GetMapping(value="organic/admin/sellerbuyers/{pageNo}" ) //User page by number
    public String findPaginated(@PathVariable (value = "pageNo") int pageNo, Model model) {
        int pageSize = 7;
        Page<UserSeller> page = userSellerService.findPaginated(pageNo, pageSize);
        List<UserSeller> sellerBuyers = page.getContent();


        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("totalItems", page.getTotalElements());
        model.addAttribute("sellerBuyers",sellerBuyers);
        return "User";
    }



    @GetMapping("organic/admin/sellerbuyer/getbyid/{uid}") // get all list from sellerbuyer table
    public String getByuIdSellerBuyer(@PathVariable Integer uid, Model model) {
        try {
            UserSeller_DTO sellerBuyer= userSellerService.findByUidWithProducts(uid);
//            UserSeller sellerBuyer = userSellerService.findById(uid);
            if (sellerBuyer != null) {
                model.addAttribute("sellerBuyer", sellerBuyer);
//                List<SellerProduct> sellerProductsList = sellerProductService.findProductByUid(Long.valueOf(uid));
//                model.addAttribute("sellerProductsList", sellerProductsList);

                return "UserById";
            } else {
                // Handle case when user with given ID is not found
                model.addAttribute("errorMessage", "User not found with ID: " + uid);
                return "ErrorPage";
            }
        } catch (Exception e) {
            // Handle any unexpected exceptions
            e.printStackTrace(); // Replace with proper logging
            model.addAttribute("errorMessage", "An error occurred while fetching user details");
            return "ErrorPage";
        }
    }

    @GetMapping("organic/admin/statusenable/{id}/{currentPage}")
    public String enableFeature(@PathVariable Long id, @PathVariable int currentPage) {
        System.out.println("Here");
        userSellerService.statusUpdate(id, true);
        return "redirect:/organic/admin/sellerbuyers/" + currentPage;
    }

    @GetMapping("organic/admin/statusdisable/{id}/{currentPage}")
    public String disableFeature(@PathVariable Long id, @PathVariable int currentPage) {
        System.out.println("Here");
        userSellerService.statusUpdate(id, false);
        return "redirect:/organic/admin/sellerbuyers/" + currentPage;
    }


    @GetMapping("organic/admin/Error")
    public String Error(Model model)
    {
        model.addAttribute("errorMessage", "No products found");

        return "ErrorPage";
    }

    @GetMapping("organic/admin/getProductEXPs")

    public String getProductEXPs(Model model){

        model.addAttribute("productList", productService.findall());
        return "ExpImage";
    }

    @GetMapping("organic/admin/product")

    public String getProducts(Model model){


        return ProductsPaginated(1, model);
    }

    @GetMapping("organic/admin/product/{pageNo}")
    public String ProductsPaginated(@PathVariable(value = "pageNo") int pageNo, Model model) {
        List<String> categories = prodCategoryServices.allCategory();
        model.addAttribute("categories", categories);

        int pageSize = 8;
        try {
            Page<Product> page = productService.findPaginated(pageNo, pageSize);

            List<Product> products = page.getContent();

            if (!products.isEmpty()) {
                model.addAttribute("products", products);
                model.addAttribute("currentPage", pageNo);
                model.addAttribute("totalPages", page.getTotalPages());
                model.addAttribute("totalItems", page.getTotalElements());
                return "Product";
            } else {
                // Handle case when no products are found
                model.addAttribute("errorMessage", "No products found");
                return "ErrorPage";
            }
        } catch (Exception e) {
            // Handle any unexpected exceptions
            e.printStackTrace(); // Replace with proper logging
            model.addAttribute("errorMessage", "An error occurred while fetching products");
            return "ErrorPage";
        }
    }

    @GetMapping("organic/admin/productBy/{category}")

    public String getProductsByCategory(@PathVariable(value = "category") String category,Model model){

        model.addAttribute("Caughtcategory", category);

        return ProductsByCategoryPaginated(category,1, model);
    }

    @GetMapping("/organic/admin/productBy/{category}/{pageNo}")
    public String ProductsByCategoryPaginated(
            @PathVariable(value = "category") String category,
            @PathVariable(value = "pageNo") int pageNo,
            Model model)
    {
        model.addAttribute("Caughtcategory", category);

        try {
            int pageSize = 8;

            // Retrieve distinct categories
            List<String> categories = prodCategoryServices.allCategory();
            model.addAttribute("categories", categories);
            Page<Product> page = productService.findProductsByCategoryPaginated(category, pageNo, pageSize);
            List<Product> products = page.getContent();

            if (!products.isEmpty()) {
                model.addAttribute("products", products);
                model.addAttribute("currentPage", pageNo);
                model.addAttribute("totalPages", page.getTotalPages());
                model.addAttribute("totalItems", page.getTotalElements());
                model.addAttribute("category", category);

                return "ProductByCategory";
            } else {
                model.addAttribute("errorMessage", "No products found for the given category and page");
                return "ErrorPage";
            }
        } catch (Exception ex) {

            model.addAttribute("errorMessage", "No products found for the given category");
            return "ErrorPage";
        }
    }

    @GetMapping("organic/admin/NewProduct")
    public String NewProduct(HttpSession session, Model model)
    {
        List<String> categories = prodCategoryServices.allCategory();
        model.addAttribute("categories", categories);

        return "AddNewProduct";
    }

    @PostMapping("organic/admin/AddProduct")
    public String AddProduct(@ModelAttribute Product_DTO thProduct, @RequestParam("file") MultipartFile file,
                             Product product, HttpSession session) throws IOException {

        if(productService.isProductExistsByname(thProduct.getName()))
        {

            session.setAttribute("msg", "Product already exists");
            return "redirect:organic/admin/NewProduct?exists";
        }

        product.setCategory(thProduct.getCategory());
        product.setName(thProduct.getName());

        Product gotProduct=productService.addProduct(product);

        productImageService.uploadImage(gotProduct.getPid(), file);

        return "redirect:/organic/admin/product";
    }


    private MediaType determineImageType(byte[] imageBytes) {
        // Check if the imageBytes array is not null and has some content
        if (imageBytes != null && imageBytes.length >= 4) {
            // JPEG magic number: 0xFF, 0xD8, 0xFF
            if (imageBytes[0] == (byte) 0xFF && imageBytes[1] == (byte) 0xD8 && imageBytes[2] == (byte) 0xFF) {
                return MediaType.IMAGE_JPEG;
            }
            // PNG magic number: 0x89, 0x50, 0x4E, 0x47
            else if (imageBytes[0] == (byte) 0x89 && imageBytes[1] == (byte) 0x50 &&
                    imageBytes[2] == (byte) 0x4E && imageBytes[3] == (byte) 0x47) {
                return MediaType.IMAGE_PNG;
            }
            // GIF magic number: 0x47, 0x49, 0x46
            else if (imageBytes[0] == (byte) 0x47 && imageBytes[1] == (byte) 0x49 &&
                    imageBytes[2] == (byte) 0x46) {
                return MediaType.IMAGE_GIF;
            }
        }
        // Return MediaType.UNKNOWN if the image type cannot be determined
        return MediaType.APPLICATION_OCTET_STREAM; // Or MediaType.UNKNOWN or any default type
    }

    @GetMapping("/organic/admin/transaction")
    public String getallTransaction(Model model){
        return getallTransactionPaginated(1,model);
    }

    @GetMapping("/organic/admin/transaction/{pageNo}")
    public String getallTransactionPaginated(@PathVariable (value = "pageNo") int pageNo,Model model){

        int pageSize = 7;
        Page<Tranx_CropDetails_DTO> page = tranxService.findTranxByStatusIdLessThanOrEqualPaginated(pageNo,pageSize,2L);
        List<Tranx_CropDetails_DTO> tranxList = page.getContent();

        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("totalItems", page.getTotalElements());
        model.addAttribute("transactions", tranxList);
        return "Transaction";
    }

    @GetMapping("/organic/admin/AcceptedQuery")
    public String getAllAcceptedQueries(Model model){

        return getAllAcceptedQueriesPaginated(1,model);
    }

    @GetMapping("/organic/admin/AcceptedQuery/{pageNo}")
    public String getAllAcceptedQueriesPaginated(@PathVariable (value = "pageNo") int pageNo,Model model){

//        List<Tranx_CropDetails_DTO> tranxList = tranxService.getAllTranxDetailsByStatusId(3L);
        int pageSize = 7;
        Page<Tranx_CropDetails_DTO> page = tranxService.getAllTranxDetailsByStatusIdPaginated(pageNo,pageSize,3L);
        List<Tranx_CropDetails_DTO> tranxList = page.getContent();

        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("totalItems", page.getTotalElements());
        model.addAttribute("transactions", tranxList);
        return "AcceptedQuery";
    }

    @GetMapping("/organic/admin/ConfirmQuery")
    public String getAllConfirmQueries(Model model){

        return getAllConfirmQueriesPaginated(1,model);
    }
    @GetMapping("/organic/admin/ConfirmQuery/{pageNo}")
    public String getAllConfirmQueriesPaginated(@PathVariable (value = "pageNo") int pageNo,Model model){

        int pageSize = 7;
        Page<Tranx_CropDetails_DTO> page = tranxService.findTranxByStatusIdGreaterThanOrEqualPaginated(pageNo,pageSize,4L);
        List<Tranx_CropDetails_DTO> tranxList = page.getContent();

        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("totalItems", page.getTotalElements());
        model.addAttribute("transactions", tranxList);
        return "ConfirmQuery";
    }














//    @GetMapping("organic/admin/Buyers")
//    public String Buyers(Model model) {
//        List<UserSeller> Buyers=userSellerService.findAll().stream().filter(sellerBuyer -> sellerBuyer.getEnableSeller().equals(false)).collect(Collectors.toList());
//        model.addAttribute("Buyers",Buyers);
//        return "Buyer";
//    }
//
//    @GetMapping("organic/admin/Sellers")
//    public String Sellers(Model model) {
//
//        List<UserSeller> Sellers=userSellerService.findAll().stream().filter(sellerBuyer -> sellerBuyer.getEnableSeller().equals(true)).collect(Collectors.toList());
//        model.addAttribute("Sellers",Sellers);
//        return "Seller";
//    }

    @GetMapping("organic/admin/statusenableBysearch/{id}")
    public String enableFeatureBysearch(@PathVariable Long id) {
        System.out.println("Here2");
        userSellerService.statusUpdate(id, true);
        return "redirect:/organic/admin/sellerbuyers";
    }

    @GetMapping("organic/admin/statusdisablBysearche/{id}")
    public String disableFeatureBysearch(@PathVariable Long id) {
        System.out.println("Here2");
        userSellerService.statusUpdate(id, false);
        return "redirect:/organic/admin/sellerbuyers";
    }

    @GetMapping("organic/admin/sellerbuyersFilter/{filter}") //User page
    public String getAllSellerBuyerFilter(@PathVariable String filter, Model model)
    {
        model.addAttribute("filter", filter);

        return findPaginatedByfilter(1,filter, model);
    }
    @GetMapping(value="organic/admin/sellerbuyersFilter/{filter}/{pageNo}" ) //User page by number
    public String findPaginatedByfilter(@PathVariable (value = "pageNo") int pageNo, @PathVariable(value = "filter") String filter, Model model) {
        int pageSize = 7;
        Page<UserSeller> page = userSellerService.findSellersPaginatedByFilter(pageNo,filter,pageSize);
        List<UserSeller> sellerBuyers = page.getContent();

        model.addAttribute("filter", filter);

        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("totalItems", page.getTotalElements());
        model.addAttribute("sellerBuyers",sellerBuyers);
        return "UserByFilter";
    }

    @GetMapping("organic/admin/NewCategory")
    public String NewCategory(HttpSession session, Model model)
    {
        List<String> categories = prodCategoryServices.allCategory();
        model.addAttribute("categories", categories);

        return "AddNewProdCategory";
    }

    @PostMapping("organic/admin/AddCategory")
    public String AddCategory(@ModelAttribute ProductCategory category, HttpSession session) throws IOException {

        if(prodCategoryServices.isExsits(category.getCategory()))
        {

            session.setAttribute("msg", "Category already exists");
            return "redirect:organic/admin/NewCategory?exists";
        }


        prodCategoryServices.saveCategory(category);
        session.setAttribute("msg", category.getCategory()+"  added successfully");


        return "redirect:/organic/admin/NewCategory";
    }

    @GetMapping("organic/admin/getQueryDetails/{id}")
    public String getQueryDetails(HttpSession session, Model model, @PathVariable Long id) {
        Tranx_CropDetails_DTO tranxCropDetailsDto = tranxService.getTransactionDetailsById(id);
        System.out.println(tranxCropDetailsDto);

        model.addAttribute("transaction", tranxCropDetailsDto);

        TransactionTbl transactionTbl =  tranxTblService.findByTid(id);
        System.out.println(transactionTbl);

        List<UserSeller_DTO> sellers = sellerProductService.findAllSellerDtoByPid(transactionTbl.getPid());
        model.addAttribute("sellers", sellers);
        UserSeller buyer= userSellerService.findById(Math.toIntExact(transactionTbl.getBuyer_uid()));
        model.addAttribute("buyer", buyer);


        return "QueryDetails";
    }
    @GetMapping("organic/admin/sendQueryDetails/{tid}/{id}")
    public String sendQueryDetails(HttpSession session, Model model, @PathVariable(value = "tid") Long tid,@PathVariable(value = "id") Long id)
    {

        tranxTblService.sendQueryToSeller(tid,id);

        Tranx_CropDetails_DTO tranxCropDetailsDto = tranxService.getTransactionDetailsById(tid);

        System.out.println("111");
        model.addAttribute("msg", "Query sent to  "+tranxCropDetailsDto.getSeller_Name()+" successfully");

        session.setAttribute("msg", "Query sent to  "+tranxCropDetailsDto.getSeller_Name()+" successfully");

        return "redirect:/organic/admin/getQueryDetails/"+tid+"?exists";
    }


    @GetMapping("organic/admin/getSellerAcceptedQueryDetails/{id}")//id stands for query/transaction id
    public String getSellerAcceptedQueryDetails(HttpSession session, Model model, @PathVariable Long id) {
        Tranx_CropDetails_DTO tranxCropDetailsDto = tranxService.getTransactionDetailsById(id);
        System.out.println(tranxCropDetailsDto);
        model.addAttribute("transaction", tranxCropDetailsDto);
        TransactionTbl transactionTbl =  tranxTblService.findByTid(id);
        UserSeller_DTO seller=sellerProductService.findSellerByUidAndPid(transactionTbl.getSeller_uid(),transactionTbl.getPid());
        model.addAttribute("seller", seller);
        UserSeller buyer= userSellerService.findById(Math.toIntExact(transactionTbl.getBuyer_uid()));
        model.addAttribute("buyer", buyer);

        return "SellerAcceptedQueryDetails";
    }



@PostMapping("organic/admin/sendQuotation")
    public String sendQuotation(HttpSession session,@ModelAttribute Tranx_CropDetails_DTO tranxCropDetailsDto )
{
    System.out.println(tranxCropDetailsDto);

    TransactionTbl transactionTbl= tranxTblService.sendQuotation(tranxCropDetailsDto);

    System.out.println(transactionTbl);
    if (transactionTbl!=null)
    {
        session.setAttribute("msg", "Quotation sent successfully");

        return "redirect:/organic/admin/getBuyerAcceptedQuotationDetails/"+transactionTbl.getTid()+"?exists";
    }
    else {
            return "redirect:/organic/admin/Error";
        }
}


    @GetMapping("organic/admin/getBuyerAcceptedQuotationDetails/{id}")//id stands for query/transaction id
    public String getBuyerAcceptedQuotationDetails(HttpSession session, Model model, @PathVariable Long id) {
        Tranx_CropDetails_DTO tranxCropDetailsDto = tranxService.getTransactionDetailsById(id);
        System.out.println(tranxCropDetailsDto);
        model.addAttribute("transaction", tranxCropDetailsDto);
        TransactionTbl transactionTbl =  tranxTblService.findByTid(id);
        model.addAttribute("FinalPrice", transactionTbl.getFinalPrice());
        model.addAttribute("DateOfDelivery", transactionTbl.getDateOfDelivery());
        model.addAttribute("statusId", transactionTbl.getStatusId());

        UserSeller_DTO seller=sellerProductService.findSellerByUidAndPid(transactionTbl.getSeller_uid(),transactionTbl.getPid());
        model.addAttribute("seller", seller);
        UserSeller buyer= userSellerService.findById(Math.toIntExact(transactionTbl.getBuyer_uid()));
        model.addAttribute("buyer", buyer);

        return "BuyerAcceptedQuotationDetails";
    }
    @PostMapping("organic/admin/sendOrderToSeller")
    public String sendOrderToSeller(HttpSession session,@ModelAttribute Tranx_CropDetails_DTO tranxCropDetailsDto )
    {
        TransactionTbl transactionTbl= tranxTblService.sendOrderToSeller(tranxCropDetailsDto.getTid());

        System.out.println(transactionTbl);
        if (transactionTbl!=null)
        {
            session.setAttribute("msg", "Quotation sent successfully");

            return "redirect:/organic/admin/ConfirmQuery";
        }
        else {
            return "redirect:/organic/admin/Error";
        }
    }

//    @GetMapping("organic/admin/deleteUserById/{uid}")
//    public String deleteUserById(HttpSession session, @PathVariable(value = "uid") Long uid) {
//        String name = userSellerService.findUserNameByUId(uid);
//        String message = "User named " + name + " Deleted";
//        userSellerService.deleteUserById(Math.toIntExact(uid));
//        session.setAttribute("msg", message);
//        return "redirect:/organic/admin/sellerbuyers?exists";
//    }

    @GetMapping("organic/admin/deleteUserById/{uid}")
    public String deleteUserById(HttpSession session ,@PathVariable(value="uid") Long uid)
    {
        String name= userSellerService.findUserNameByUId(uid);
        session.setAttribute("msg", "User named "+name+" Deleted");
        userSellerService.deleteUserById(Math.toIntExact(uid));


        return "redirect:/organic/admin/sellerbuyers?exists";
    }









//    @GetMapping("organic/admin/viewQuotation/{id}")//id stands for query/transaction id
//    public String viewQuotation(HttpSession session, Model model, @PathVariable Long id) {
//        Tranx_CropDetails_DTO tranxCropDetailsDto = tranxService.getTransactionDetailsById(id);
//        model.addAttribute("transaction", tranxCropDetailsDto);
//        TransactionTbl transactionTbl =  tranxTblService.findByTid(id);
//
//        UserSeller_DTO seller=sellerProductService.findSellerByUidAndPid(transactionTbl.getSeller_uid(),transactionTbl.getPid());
//        System.out.println(seller);
//        model.addAttribute("seller", seller);
//
//        return "Send_Quotation_user_details";
//    }

}

