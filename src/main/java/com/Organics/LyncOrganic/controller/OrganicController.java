package com.Organics.LyncOrganic.controller;

import com.Organics.LyncOrganic.CustomExceptionHandler.CustomApiException;
import com.Organics.LyncOrganic.DTO.*;
import com.Organics.LyncOrganic.entity.*;
import com.Organics.LyncOrganic.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/organic")

public class OrganicController {
    @Autowired
    private Certificates_Service certificatesService;
    @Autowired
    private ProductCerti_Service productCertiService;
    @Autowired
    private Product_Service productService;

    @Autowired
    private TranxStatus_Service tranxStatusService;

    @Autowired
    private UserSeller_Service userSellerService;

    @Autowired
    private SellerProduct_Service sellerProductService;

    @Autowired
    private TransactionTbl_Service tranxService;

    @Autowired
    private CropTranx_Service cropTranxService;

    @Autowired
    private ProductImage_Service productImageService;


    //-------- Tranx Status ------------------------------------------------------------------------
    @PostMapping("/tranxstatus")
    public ResponseEntity<TranxStatus> createTranxStatus(@RequestBody TranxStatus tranxStatus) {
        return  ResponseEntity.status(HttpStatus.CREATED).body(tranxStatusService.saveTranxStatus(tranxStatus));
    }
    @PostMapping("/tranxstatus/addall")
    public ResponseEntity<List<TranxStatus>> createTranxStatus() {
        try {
            tranxStatusService.saveTranxStatus(new TranxStatus(0L,"Buyer Declined Quotation"));
            tranxStatusService.saveTranxStatus(new TranxStatus(1L,"Buyer Raised Query"));
            tranxStatusService.saveTranxStatus(new TranxStatus(2L,"Pending Seller Approval"));
            tranxStatusService.saveTranxStatus(new TranxStatus(3L,"Seller Confirmed"));
            tranxStatusService.saveTranxStatus(new TranxStatus(4L,"Sent Quotation To Buyer"));
            tranxStatusService.saveTranxStatus(new TranxStatus(5L,"Buyer Placed Order"));
            tranxStatusService.saveTranxStatus(new TranxStatus(6L,"Order sent to Seller"));
            tranxStatusService.saveTranxStatus(new TranxStatus(7L,"Seller Cleaning"));
            tranxStatusService.saveTranxStatus(new TranxStatus(8L,"Seller Sorting"));
            tranxStatusService.saveTranxStatus(new TranxStatus(9L,"Seller Packing"));
            tranxStatusService.saveTranxStatus(new TranxStatus(10L,"Product Ready to be Shipped"));
            tranxStatusService.saveTranxStatus(new TranxStatus(11L,"Product Dispatched"));
            tranxStatusService.saveTranxStatus(new TranxStatus(12L,"Product Received"));

            return ResponseEntity.status(HttpStatus.CREATED).body(tranxStatusService.findAll());
        } catch (Exception e) {
            // Handle any potential exceptions here
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.emptyList());
        }
    }

    @GetMapping("/tranxstatus/{statusId}")
    public ResponseEntity<TranxStatus> getByIdTranxStatus(@PathVariable Integer statusId) {
        try {
            TranxStatus tranxStatus = tranxStatusService.findByStatusId(statusId);
            if (tranxStatus != null) {
                return ResponseEntity.status(HttpStatus.FOUND).body(tranxStatus);
            } else {
                throw new CustomApiException("TranxStatus not found", HttpStatus.NOT_FOUND);
            }
        } catch (CustomApiException ex) {
            return ResponseEntity.status(ex.getHttpStatus()).body(null);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @GetMapping("/tranxstatus")
    public ResponseEntity<List<TranxStatus>> getAllTranxStatus() {
        try {
            List<TranxStatus> tsList = tranxStatusService.findAll();
            if (!tsList.isEmpty()) {
                return ResponseEntity.status(HttpStatus.FOUND).body(tsList);
            } else {
                throw new CustomApiException("No TranxStatus found", HttpStatus.NOT_FOUND);
            }
        } catch (CustomApiException ex) {
            return ResponseEntity.status(ex.getHttpStatus()).body(null);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }


    //-------- Product ------------------------------------------------------------------------
    @GetMapping("/product")
    public ResponseEntity<List<Product>> getAllProducts() {
        try {
            List<Product> productList = productService.findall();
            if (!productList.isEmpty()) {
                return ResponseEntity.status(HttpStatus.FOUND).body(productList);
            }
            else
            {
                throw new CustomApiException("No products found", HttpStatus.NOT_FOUND);
            }
        } catch (CustomApiException ex)
        {
            return ResponseEntity.status(ex.getHttpStatus()).body(null);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @GetMapping("/product/{pid}")
    public ResponseEntity<Product> getProductById(@PathVariable Integer pid) {
        Product product = productService.getProductById(pid);

        if (product == null) {
            throw new CustomApiException("No details found for ID: " + pid, HttpStatus.NOT_FOUND);
        }

        return ResponseEntity.status(HttpStatus.OK).body(product);
    }


    @PostMapping("/product")
    public ResponseEntity<Product> addProduct(@RequestBody Product product) {
        try {
            Product addedProduct = productService.addProduct(product);
            if (addedProduct != null) {
                return ResponseEntity.status(HttpStatus.CREATED).body(addedProduct);
            } else {
                throw new CustomApiException("Failed to add product", HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } catch (CustomApiException ex) {
            return ResponseEntity.status(ex.getHttpStatus()).body(null);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    // upload image for product
    @PutMapping("/product/{pid}/uploadImage")
    public ResponseEntity<String> uploadProductImage(@PathVariable Long pid, @RequestParam("file") MultipartFile file) throws IOException {
            productImageService.uploadImage(pid, file);
            return ResponseEntity.ok("Image uploaded successfully for product with id: " + pid);
    }

    // download image of product
    @GetMapping("/product/{pid}/getImage")
    public ResponseEntity<byte[]> downloadImage(@PathVariable Long pid) {
        byte[] imageContent = productImageService.getImageByProductId(pid);

        if (imageContent != null && imageContent.length > 0) {
            HttpHeaders headers = new HttpHeaders();

            headers.setContentType(MediaType.IMAGE_JPEG);

//            or MediaType.IMAGE_PNG/
           // headers.setContentType(MediaType.parseMediaType("image/*")); // Set to allow all image types
//            headers.setContentType(MediaType.parseMediaType("image/*"));
            return new ResponseEntity<>(imageContent, headers, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    //------- UserSeller   Buyer------------------------------------
      // by default User is Buyer , after enabled by Admin he becomes Seller


    @PostMapping("/user/sellerbuyer")
    public ResponseEntity<?> createBuyer(@RequestBody UserSeller buyer) {
        try {
            // Perform additional validation here
            if (buyer.getUserName() == null || buyer.getEmailId() == null || buyer.getMobileNo() == null ||
                    buyer.getUserName().isEmpty() || buyer.getEmailId().isEmpty() || buyer.getMobileNo().isEmpty()) {
                throw new CustomApiException("Required fields are empty", HttpStatus.BAD_REQUEST);
            }

            // Save the user if validations pass
            UserSeller savedBuyer = userSellerService.save(buyer);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedBuyer);
        } catch (CustomApiException ex) {
            return ResponseEntity.status(ex.getHttpStatus()).body(ex.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }


    @PutMapping("/user/sellerbuyer_update")
    public ResponseEntity<UserSeller> updateUserSeller(@RequestBody UserSeller userSeller) {
        try {
            // Perform additional validation if needed before updating

            UserSeller updatedUserSeller = userSellerService.update(userSeller);
            if (updatedUserSeller != null) {
                return ResponseEntity.status(HttpStatus.ACCEPTED).body(updatedUserSeller);
            } else {
                throw new CustomApiException("Failed to update UserSeller", HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } catch (CustomApiException ex) {
            return ResponseEntity.status(ex.getHttpStatus()).body(null);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
    @GetMapping("/user/sellerbuyer/{uid}")
    public ResponseEntity<UserSeller> getByIdSellerBuyer(@PathVariable Integer uid) {
        try {
            UserSeller userSellerList = userSellerService.findById(uid);
            if (userSellerList != null) {
                return ResponseEntity.status(HttpStatus.FOUND).body(userSellerList);
            } else {
                throw new CustomApiException("UserSeller not found on ID:"+uid, HttpStatus.NOT_FOUND);
            }
        } catch (CustomApiException ex) {
            // Handle specific exception type
            return ResponseEntity.status(ex.getHttpStatus()).body(null);
        } catch (Exception e) {
            // Handle generic exception or rethrow
            throw new CustomApiException("An error occurred", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/user/sellerbuyer/enable_as_seller/{uid}")
    public ResponseEntity<String> enableBuyerAsSeller(@PathVariable Integer uid) {
        return ResponseEntity.accepted().body(userSellerService.enableAsSeller(uid));
    }
    @PutMapping("/user/sellerbuyer/disable_as_seller/{uid}")
    public ResponseEntity<String> disableAsSeller(@PathVariable Integer uid) {
        return ResponseEntity.accepted().body(userSellerService.disableSeller(uid));
    }

    //---- SellerProduct ------------------------------------------------

    @GetMapping("/user/FetchAllCertificates")
    public ResponseEntity<?> allCertificates()
    {
        try {
            List<Certificate> certificates= certificatesService.fetchAllCertificates();
            if(certificates != null)
            {
                return  ResponseEntity.status(HttpStatus.FOUND).body(certificates);
            }
            else {
                throw new CustomApiException("Failed to Find Products", HttpStatus.INTERNAL_SERVER_ERROR);
            }

        }
        catch (CustomApiException ex) {
            throw new CustomApiException("Failed to find certificates", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @GetMapping("/user/certificateById/{id}")
    public ResponseEntity<?> certificateById(@PathVariable Long id)
    {
        try {
            Certificate certificate= certificatesService.findCertificateById(id);
            if(certificate != null)
            {
                return  ResponseEntity.status(HttpStatus.FOUND).body(certificate);
            }
            else {
                throw new CustomApiException("Failed to Find Certificates", HttpStatus.INTERNAL_SERVER_ERROR);
            }

        }
        catch (CustomApiException ex) {
            throw new CustomApiException("Failed to find certificates", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/user/seller/product_to_sell")
    public ResponseEntity<SellerProduct> addSellerProduct(@RequestBody SellerProduct_DTO sellerProductDto) {
        try {
          SellerProduct addedSellerProduct= sellerProductService.saveProduct(sellerProductDto);

            if (addedSellerProduct != null) {
                return ResponseEntity.status(HttpStatus.CREATED).body(addedSellerProduct);
            } else {
                throw new CustomApiException("Failed to add Product", HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } catch (CustomApiException ex) {
            return ResponseEntity.status(ex.getHttpStatus()).body(null);
        } catch (Exception e) {
            throw new CustomApiException("It's A BUYER Please Contact Admin ... ", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @GetMapping("/user/seller/findproduct/{pid}") // Gel all sellers selling a particular product
    public ResponseEntity<List<SellerProduct>> getSellerProductsByPid(@PathVariable Long pid) {
        try {
            // Perform additional validation if needed before fetching
            // For instance, check if pid is valid or exists

            List<SellerProduct> sellerProductsList = sellerProductService.findAllSellerByPid(pid);
            if (!sellerProductsList.isEmpty()) {
                return ResponseEntity.status(HttpStatus.FOUND).body(sellerProductsList);
            } else {
                throw new CustomApiException("No SellerProducts found for the given PID", HttpStatus.NOT_FOUND);
            }
        } catch (CustomApiException ex) {
            return ResponseEntity.status(ex.getHttpStatus()).body(null);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @GetMapping("/user/seller/findproductBySellerId/{uid}") //Get all the products what a seller is selling
    public ResponseEntity<List<SellerProduct>> findproductBySellerId(@PathVariable Long uid) {
        try {
            List<SellerProduct> sellerProductsList = sellerProductService.findProductByUid(uid);
            if (!sellerProductsList.isEmpty()) {
                return ResponseEntity.status(HttpStatus.FOUND).body(sellerProductsList);
            } else {
                throw new CustomApiException("No Products found for the given UID", HttpStatus.NOT_FOUND);
            }
        } catch (CustomApiException ex) {
            return ResponseEntity.status(ex.getHttpStatus()).body(null);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    // ----- Admin -------




    // ------ TransactionTbl
    @PostMapping("/user/sellerbuyer/transaction")  // add tranx
    public ResponseEntity<TransactionTbl> addTransaction(@RequestBody AddTranx_DTO addTranxDTO) {

        return ResponseEntity.status(HttpStatus.CREATED).body(tranxService.add(addTranxDTO));
    }
    @GetMapping("/user/sellerbuyer/transaction") // get all
    public ResponseEntity<List<TransactionTbl>> getAllTransaction() {
        List<TransactionTbl> tranxList=tranxService.findAll();
        return (tranxList != null) ?
                ResponseEntity.status(HttpStatus.FOUND).body(tranxList) :
                ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
    }
    @GetMapping("/user/sellerbuyer/transaction/{tid}")
    public ResponseEntity<Tranx_CropDetails_DTO> getTransactionTblByTid(@PathVariable Long tid) {
        Tranx_CropDetails_DTO tranxCropDetailsDto =tranxService.getTransactionDetailsById(tid);
        return (tranxCropDetailsDto != null) ?
                ResponseEntity.status(HttpStatus.FOUND).body(tranxCropDetailsDto) :
                ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
    }
    @GetMapping("/user/sellerbuyer/croptranx/{tid}")
    public ResponseEntity<List<CropTranx>> getAllCropTranxByTid(@PathVariable Long tid) {
        List<CropTranx> listCT = cropTranxService.findAllbyTid(tid);
        return (listCT != null) ?
                ResponseEntity.status(HttpStatus.FOUND).body(listCT) :
                ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
    }

    // All seller approval pending list in CropTran format
    @GetMapping("/user/seller/pending_approvals")
    public ResponseEntity<List<CropTranx>> getAllSeller_PendingApprovals() {
        List<CropTranx> listCT = tranxService.getAllSeller_PendingApprovals();
        return (listCT != null) ?
                ResponseEntity.status(HttpStatus.FOUND).body(listCT) :
                ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
    }


    //All seller approval pending list in SelPenApr_DTO
    @GetMapping("/user/seller/pendingapprovals")
    public ResponseEntity<List<SelPenApr_DTO>> getAllSellers_PendingApproval(){
        List<SelPenApr_DTO> selListDTO =tranxService.getAllSellers_PendingApproval();
        return (selListDTO != null) ?
                ResponseEntity.status(HttpStatus.FOUND).body(selListDTO) :
                ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
    }



    // seller_uid approval pending list in SelPenApr_DTO
    @GetMapping("/user/seller/{sid}/pendingapprovals")
    public ResponseEntity<List<SelPenApr_DTO>> getSellerID_PendingApproval(@PathVariable("sid") Long sid){
        List<SelPenApr_DTO> selListDTO =tranxService.getSellerID_PendingApproval(sid);
        return (selListDTO != null) ?
                ResponseEntity.status(HttpStatus.FOUND).body(selListDTO) :
                ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
    }

    @PutMapping("/user/seller/approves")
    public ResponseEntity<CropTranx> setSeller_CropTranxApproval(@RequestBody SelPenApr_DTO dto){
        CropTranx ct =tranxService.setSeller_CropTranxApproval(dto);
        return (ct != null) ?
                ResponseEntity.status(HttpStatus.FOUND).body(ct) :
                ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
    }






    //Search Api
    @GetMapping("/admin/searchList/{nameOremail}")
    public ResponseEntity<List<UserSeller>> searchByNameOrEmailList(@PathVariable String nameOremail)
    {
        System.out.println(nameOremail);
        List<UserSeller> sellerBuyers=userSellerService.findByNameOrEmailList(nameOremail,nameOremail);
        System.out.println(sellerBuyers);
        return ResponseEntity.ok(sellerBuyers);
    }

    @GetMapping("/admin/searchFilter/{filter}")
    public ResponseEntity<List<UserSeller>> searchFilter(@PathVariable String filter)
    {
        System.out.println(filter);
        if(filter.equals("seller"))
        {
            List<UserSeller> sellerBuyers=userSellerService.findAll();
            System.out.println(sellerBuyers);
            return ResponseEntity.ok(sellerBuyers);
        }
        return ResponseEntity.ok(userSellerService.findAll());
    }

    @GetMapping("/user/sellerName/{uid}")
    public String getByIdSellerName(@PathVariable Integer uid) {
        try {
            UserSeller userSellerList = userSellerService.findById(uid);
            if (userSellerList != null) {
                return userSellerList.getUserName();
            } else {
                throw new CustomApiException("UserSeller not found on ID:"+uid, HttpStatus.NOT_FOUND);
            }
        } catch (CustomApiException ex) {
            // Handle specific exception type
            return null;
        } catch (Exception e) {
            // Handle generic exception or rethrow
            throw new CustomApiException("An error occurred", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    // ----- Query processes-------


    @GetMapping("/user/seller/transactions/{seller_uid}")    // Fetch all seller queries
    public ResponseEntity<List<TransactionTbl>> getTxnBySellerIdAndStsId2(@PathVariable Long seller_uid){

//        List<Tranx_CropDetails_DTO> trnxDtoList=
        List<TransactionTbl> tblList = tranxService.getTranxForSeller(seller_uid);
        if (!tblList.isEmpty()) {

            System.out.println(tblList);
            return ResponseEntity.status(HttpStatus.FOUND).body(tblList);
        } else {
            // You can customize the response message or handle other scenarios
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);

        }
    }

    @GetMapping("/user/buyer/transactions/{buyer_uid}")    // Fetch all seller queries
    public ResponseEntity<List<TransactionTbl>> getTxnByBuyerId(@PathVariable Long buyer_uid){

//        List<Tranx_CropDetails_DTO> trnxDtoList=
        List<TransactionTbl> tblList = tranxService.findTranxByBuyerUid(buyer_uid);
        if (!tblList.isEmpty()) {

            System.out.println(tblList);
            return ResponseEntity.status(HttpStatus.FOUND).body(tblList);
        } else {
            // You can customize the response message or handle other scenarios
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);

        }
    }
    @PutMapping("/user/seller/confirmQuery/{uid}/{tid}") //Seller confirms the query .
    public ResponseEntity<String> sellerQueryConfirm(@PathVariable(value="uid") Long uid, @PathVariable(value="tid") Long tid)
    {
        if (uid!=null) {

            TransactionTbl tbl = tranxService.findByTid(tid);

            if (tbl != null) {

                UserSeller userSellerList = userSellerService.findById(Math.toIntExact(uid));
                if (userSellerList != null) {
                    TransactionTbl transaction = tranxService.sellerQueryConfirm(tid);
                    return ResponseEntity.status(HttpStatus.OK).body(tranxStatusService.findMeaningByStatusId(transaction.getStatusId()));
                } else {

                    throw new CustomApiException("UserSeller not found on ID:" + uid, HttpStatus.NOT_FOUND);
                }
            } else {
                throw new CustomApiException("Transaction not found on ID:" + tid, HttpStatus.NOT_FOUND);
            }
        }
        else
        {
            throw new CustomApiException("UId cannot be null ", HttpStatus.NOT_FOUND);

        }
    }

    @PutMapping("/user/buyer/buyerConfirmQuotation/{uid}/{tid}") //Buyer confirms the quotation .
    public ResponseEntity<?> buyerConfirmQuotation(@PathVariable(value="uid") Long uid, @PathVariable(value="tid") Long tid)
    {
        TransactionTbl transactionTbl=tranxService.findByTid(tid);

        if (transactionTbl != null) {


            UserSeller userSeller = userSellerService.findById(Math.toIntExact(uid));
            if (userSeller != null) {
                TransactionTbl transaction=tranxService.BuyerQuotationConfirm(tid);
                return ResponseEntity.status(HttpStatus.OK).body(tranxStatusService.findMeaningByStatusId(transaction.getStatusId()));
            } else {
                throw new CustomApiException("UserSeller not found on ID:" + uid, HttpStatus.NOT_FOUND);
            }
        }
        else {
            throw new CustomApiException("Transaction not found on ID:" + tid, HttpStatus.NOT_FOUND);
        }
    }

    @PutMapping("/user/sellerBuyer/updateDeliveryStatus/{uid}") //seller updates .
    public ResponseEntity<String> sellerQuerupdateDeliveryStatusyConfirm(@PathVariable(value="uid") Long uid, @RequestBody SetStatus_DTO statusDto) {
        // Find the transaction by its ID
        TransactionTbl transaction = tranxService.findByTid(statusDto.getTid());

        // Check if the transaction exists
        if (transaction == null) {
            throw new CustomApiException("Transaction not found for ID: " + statusDto.getTid(), HttpStatus.NOT_FOUND);
        }

        // Determine the user's role based on the provided uid
        boolean isSeller = Objects.equals(uid, transaction.getSeller_uid());
        boolean isBuyer = Objects.equals(uid, transaction.getBuyer_uid());

        // Check if the user is authorized and the status is valid
        if ((isSeller && statusDto.getStatusId() >= 7L && statusDto.getStatusId() < 12L) ||
                (isBuyer && statusDto.getStatusId() == 12L)) {
            // Update the transaction status
            TransactionTbl updatedTransaction = tranxService.setTranxStatus(statusDto);
            // Return the updated status with OK response
            return ResponseEntity.status(HttpStatus.OK).body(tranxStatusService.findMeaningByStatusId(updatedTransaction.getStatusId()));
        } else {
            throw new CustomApiException("Invalid status or unauthorized user", HttpStatus.FORBIDDEN);
        }
    }




    @PutMapping("/user/buyer/declinedOrder/{uid}") //declinedOrder/ quotations  .
    public ResponseEntity<String> declinedOrder(@PathVariable(value="uid") Long uid,@RequestBody SetStatus_DTO statusDto)
    {
        TransactionTbl tbl=tranxService.findByTid(statusDto.getTid());

        if (tbl != null) {

            UserSeller userSellerList = userSellerService.findById(Math.toIntExact(uid));
            if (userSellerList != null)
            {
                if(statusDto.getStatusId().equals(0L))
                {
                    TransactionTbl transaction=tranxService.setTranxStatus(statusDto);
                    return ResponseEntity.status(HttpStatus.OK).body(tranxStatusService.findMeaningByStatusId(transaction.getStatusId()));
                }
                else
                {
                    throw new CustomApiException("Please enter proper Status Id:" + statusDto.getStatusId(), HttpStatus.NOT_FOUND);
//                    return ResponseEntity.status(HttpStatus.FORBIDDEN).body("");
                }

            } else {
                throw new CustomApiException("UserSeller not found on ID:" + uid, HttpStatus.NOT_FOUND);
            }
        }
        else {
            throw new CustomApiException("Transaction not found on ID:" + statusDto.getTid(), HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/user/buyer/viewQuotation/{tid}")//Buyer view Quotation
    public  ResponseEntity<Quotation_DTO> viewQuotationByTransactionId(@PathVariable(value="tid") Long tid )
    {

        TransactionTbl tbl=tranxService.findByTid(tid);

        if (tbl != null)
        {
            return ResponseEntity.status(HttpStatus.FOUND).body(tranxService.buyerViewQuotation(tid));
        }
        else {
            throw new CustomApiException("Transaction not found on ID:" +tid, HttpStatus.NOT_FOUND);
        }

    }

    @DeleteMapping("/deleteUserById/{uid}") //UserDelete
    public ResponseEntity<String> deleteProduct(@PathVariable Long uid) {
        System.out.println(01);
        userSellerService.deleteUserById(Math.toIntExact(uid));

        return new ResponseEntity<>("Product deleted successfully", HttpStatus.OK);
    }
    @PutMapping("/user/editUserById/{uid}")
    public ResponseEntity<?> editUser(@PathVariable Long uid, @RequestBody UserSeller_DTO userSellerDto) {
        userSellerService.updateUserSeller(Math.toIntExact(uid),userSellerDto);

        return new ResponseEntity<>(userSellerService.findByUidWithProducts(Math.toIntExact(uid)), HttpStatus.OK);
    }
    @GetMapping("/user/ProductCertification")//Buyer view Quotation
    public  ResponseEntity<?> ProductCertification(@RequestBody ProductCertificate getIds )
    {
        Tranx_CropDetails_DTO tranxCropDetailsDto = tranxService.getTransactionDetailsById(getIds.getPid());
//        UserSeller_DTO userSellerDto =userSellerService.findByUidWithProducts(Math.toIntExact(getIds.getSeller_uid()));
//        List<String> productCertificates = productCertiService.findCertificateNameOfASellerProduct(getIds.getPid(),getIds.getSeller_uid());
        if (tranxCropDetailsDto != null)
        {
            return ResponseEntity.status(HttpStatus.FOUND).body(tranxCropDetailsDto);
        }
        else {
            throw new CustomApiException("Transaction not found on ID:" +getIds.getCertId(), HttpStatus.NOT_FOUND);
        }

    }



    @PutMapping("/user/buyer/paymentStatus/{uid}/{tid}")
    public ResponseEntity<?> paymentStatus(@PathVariable(value="uid") Long uid, @PathVariable(value="tid") Long tid, @RequestBody PaymentDTO paymentDTO) {
        TransactionTbl transactionTbl = tranxService.findByTid(tid);

        if (transactionTbl == null) {
            throw new CustomApiException("Transaction not found for ID: " + tid, HttpStatus.NOT_FOUND);
        }

        Long buyerUid = transactionTbl.getBuyer_uid();
        if (!buyerUid.equals(uid)) {
            throw new CustomApiException("Cannot process payment. Buyer ID does not match.", HttpStatus.FORBIDDEN);
        }

        UserSeller userSeller = userSellerService.findById(Math.toIntExact(uid));
        if (userSeller == null) {
            throw new CustomApiException("UserSeller not found for ID: " + uid, HttpStatus.NOT_FOUND);
        }

        TransactionTbl transaction = tranxService.setPaymentDetails(tid, paymentDTO);
        return ResponseEntity.status(HttpStatus.OK).body(transaction.getPaymentStatus());
    }




} //// End controller
