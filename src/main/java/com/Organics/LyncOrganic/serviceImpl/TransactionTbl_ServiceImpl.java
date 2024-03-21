package com.Organics.LyncOrganic.serviceImpl;

import com.Organics.LyncOrganic.DTO.*;
import com.Organics.LyncOrganic.entity.*;
import com.Organics.LyncOrganic.repository.SellerProduct_Repo;
import com.Organics.LyncOrganic.repository.TransactionTbl_Repo;
import com.Organics.LyncOrganic.service.*;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class TransactionTbl_ServiceImpl implements TransactionTbl_Service {
    @Autowired
    private TransactionTbl_Repo tranxRepo;
    @Autowired
    private Certificates_Service certificatesService;
    @Autowired
    @Lazy
    private SellerProduct_Service selProService;

    @Autowired
    @Lazy
    private TranxStatus_Service tranxStatusService;
    @Autowired
    @Lazy
    private SellerProduct_Repo sellerProductRepo;
    @Autowired
    @Lazy
    private Product_Service productService;
    @Autowired
    @Lazy
    private UserSeller_Service userSellerService;
    @Autowired
    @Lazy
    private CropTranx_Service cropTranxService;


    @Override
    public TransactionTbl add(AddTranx_DTO dto) {

        String productName = productService.findNameByPid(dto.getPid());
        if(productName.isEmpty()){
            throw new RuntimeException("No such product with id :" + dto.getPid() + "exits");
        }
        System.out.println("Selected Product Name: " + productName);
        TransactionTbl trnx = new TransactionTbl();
        trnx.setBuyer_uid(dto.getBuyer_uid());
        trnx.setMethod(dto.getMethod());
        trnx.setPid(dto.getPid());
        trnx.setQuantity(dto.getQuantity());
        trnx.setProductName(productName);
        trnx.setTargetPrice(dto.getTargetPrice());
        trnx.setDeliveryAddress(dto.getDeliveryAddress());

        String certificationListInString= String.join(",", dto.getCertificationList().stream()
                .map(Object::toString)
                .collect(Collectors.toList()));

        trnx.setCertification(certificationListInString);
//        System.out.println(certificationListInString);
        // Get the list of sellers for the product
        List<SellerProduct> sellers = selProService.findAllSellerByPid(dto.getPid());

        // --- set default values ----
        trnx.setRemark(dto.getRemark()+new Date());
        trnx.setOrderDate(new Date()); //set the order date to the current date
        trnx.setLastUpdate(new Date());
        trnx.setStatusId(1L); // means Tranx Begin
        trnx.setNoOfEdits(0);
        //-------------------------------
        //Double totalAmount = calculateTotalAmount(dto.getListCropTranx());
        trnx.setTotalAmount(BigInteger.valueOf(0));
        trnx= tranxRepo.save(trnx);
        // check all seller_uid and pid are valid and  set default values
//        Add_CropTranxList(dto.getListCropTranx(),trnx);
          //trnx.setListCropTranx(cropTranxService.saveListCT(listCT));

        return trnx;
    }

    // validate seller_uid, pid, and get price add info to CropTranx table
    private void Add_CropTranxList(List<CropTranx_DTO> ctDTO, TransactionTbl trnx) {
         Float price;
         //List<CropTranx> listCT=null;
        for(CropTranx_DTO ct: ctDTO) {
//            if(Objects.equals(trnx.getBuyer_uid(), ct.getSeller_uid()))
//                throw new RuntimeException(" id:"+ct.getSeller_uid()+" BuyerId and SellerId cannot be same !!!!");

//            if(!selProService.existsByUidAndPid(ct.getSeller_uid(),ct.getPid()))
//                throw new RuntimeException("INVALID, please check seller_uid:"+ct.getSeller_uid()+"  pid:"+ct.getPid()+" !!!");

            CropTranx addCT = new CropTranx();
            // --- set default values ----
//            addCT.setSeller_uid(ct.getSeller_uid());
            addCT.setPid(ct.getPid());
            addCT.setSellerApprove(false);
            addCT.setBuyerApprove(false);
            addCT.setTaxDiscount(1F);
            addCT.setBuyer_uid(trnx.getBuyer_uid());
            addCT.setTid(trnx.getTid());
            addCT.setQuantity(ct.getQuantity());
//             price= sellerProductRepo.findRateByUidAndPid(ct.getSeller_uid(),ct.getPid());
//            addCT.setRate(price);
//            addCT.setCropAmount(price * ct.getQuantity() * addCT.getTaxDiscount());
            cropTranxService.save(addCT);
        }

    }

    @Override
    public List<TransactionTbl> findAll() {
        return tranxRepo.findAll();
    }

    @Override
    public TransactionTbl findByTid(Long tid) {
        return tranxRepo.findById(tid).orElse(null);
    }

    @Override
    public List<CropTranx> getAllSeller_PendingApprovals() {
        List<CropTranx> listCT=new ArrayList<>();
        Long statusId;
        Boolean sellerApprove;
        for(CropTranx ct: cropTranxService.findAll()) {
            statusId = tranxRepo.findStatusIdByTid(ct.getTid());
            sellerApprove = ct.getSellerApprove();
            if ((statusId == 1 || statusId == 2) && (!sellerApprove)) {
                assert false;
                listCT.add(ct);
            }
        }
        return listCT;
    }

    @Override
    public List<SelPenApr_DTO> getAllSellers_PendingApproval() {
        List<SelPenApr_DTO> listDTO=new ArrayList<>();
        Long statusId;
        Boolean sellerApprove;
        for(CropTranx ct: cropTranxService.findAll()) {
            SelPenApr_DTO dto=new SelPenApr_DTO();
            statusId = tranxRepo.findStatusIdByTid(ct.getTid());
            sellerApprove = ct.getSellerApprove();
           // means before confirmation status:3 and sellerapprove=false
            if ((statusId == 1 || statusId == 2) && (!sellerApprove)) {
                dto.setSellerApprove(sellerApprove);
                dto.setSeller_uid(ct.getSeller_uid());
                dto.setStatusId(statusId);
                dto.setTid(ct.getTid());
                dto.setBuyer_uid(ct.getBuyer_uid());
                dto.setPid(ct.getPid());
                listDTO.add(dto);
            }
        }
        return listDTO;
    }
    @Override
    public List<SelPenApr_DTO> getSellerID_PendingApproval(Long sid) {
        List<SelPenApr_DTO> listDTO=new ArrayList<>();
        Long statusId;
        Boolean sellerApprove;
        for(CropTranx ct: cropTranxService.findAll()) {
            SelPenApr_DTO dto=new SelPenApr_DTO();
            statusId = tranxRepo.findStatusIdByTid(ct.getTid());
            sellerApprove = ct.getSellerApprove();
            // means before confirmation status:3 and sellerapprove=false
            if ((statusId == 1 || statusId == 2) && (!sellerApprove) && ct.getSeller_uid().equals(sid)) {
                dto.setSellerApprove(sellerApprove);
                dto.setSeller_uid(ct.getSeller_uid());
                dto.setStatusId(statusId);
                dto.setTid(ct.getTid());
                dto.setBuyer_uid(ct.getBuyer_uid());
                dto.setPid(ct.getPid());
                listDTO.add(dto);
            }
        }
        return listDTO;
    }

    @Override
    public TransactionTbl setTranxStatus(SetStatus_DTO statusDto) {
        TransactionTbl trnx=tranxRepo.findById(statusDto.getTid()).orElseThrow(() -> new EntityNotFoundException("TransactionTbl with tid " + statusDto.getTid() + " not found"));
        trnx.setStatusId(statusDto.getStatusId());
        return tranxRepo.save(trnx);
    }

    @Override
    public CropTranx setSeller_CropTranxApproval(SelPenApr_DTO dto) {
        try {
            CropTranx cropTranx = cropTranxService.findByTidAndPidAndSellerUid(dto.getTid(), dto.getPid(), dto.getSeller_uid());
            if(cropTranx==null)
                throw new RuntimeException("Please enter valid data !!!");

            TransactionTbl trnx = tranxRepo.findById(dto.getTid())
                    .orElseThrow(() -> new EntityNotFoundException("TransactionTbl with tid " + dto.getTid() + " not found"));

            Long status = tranxRepo.findStatusIdByTid(cropTranx.getTid());

            if (status == 1 || status==2){
                if (status == 1)
                    trnx.setStatusId(2L);  // change status of Transaction_tbl
                cropTranx.setSellerApprove(true);
                cropTranx=cropTranxService.save(cropTranx); ///  saved CropTranx

                //-- Calculate Total amount for Transaction_tbl
                BigInteger totalAmt= BigInteger.valueOf(0);
                for(CropTranx ct:cropTranxService.findAllbyTid(cropTranx.getTid())){
                   if(ct.getSellerApprove())
                    totalAmt= totalAmt.add(BigInteger.valueOf((long) (ct.getCropAmount() * 1)));
                }
                trnx.setTotalAmount(totalAmt);
                tranxRepo.save(trnx);
            }else
                throw new RuntimeException(" Cannot Update status ,Please check Transaction status !!! of tid:"+cropTranx.getTid());
            return cropTranx;
        } catch (Exception e) {
            throw new RuntimeException("Error processing CropTranx approval: " + e.getMessage(), e);
        }
    }


    @Override
    public List<Tranx_CropDetails_DTO> getAllTranxDetails() {
        List<TransactionTbl>  tranxList = tranxRepo.findAll();
        List<Tranx_CropDetails_DTO> traxDetailListDTO = new ArrayList<>();
        for(TransactionTbl txn: tranxList){
           // Tranx_CropDetails_DTO tranxDetail = null;
            Tranx_CropDetails_DTO tranxDetail = new Tranx_CropDetails_DTO();
            tranxDetail.setTid(txn.getTid());
            tranxDetail.setMethod(txn.getMethod());
            tranxDetail.setTotalAmount(txn.getTotalAmount());
            tranxDetail.setOrderDate(txn.getOrderDate());
            tranxDetail.setLastUpdate(txn.getLastUpdate());
            tranxDetail.setRemark(txn.getRemark());
            tranxDetail.setNoOfEdits(txn.getNoOfEdits());
            tranxDetail.setBuyer_uid(txn.getBuyer_uid());
            tranxDetail.setProductName(txn.getProductName());
            tranxDetail.setBuyer_name(userSellerService.findUserNameByUId(txn.getBuyer_uid()));
            tranxDetail.setStatusId(txn.getStatusId());
            tranxDetail.setStatusMeaning(tranxStatusService.findMeaningByStatusId(txn.getStatusId()));
        //----------------
//            for(CropTranx ct : cropTranxService.findAllbyTid(txn.getTid())){
//                //CropTranxDetails_DTO ct_dto=null;
//                CropTranxDetails_DTO ct_dto=new CropTranxDetails_DTO();
//                ct_dto.setCtId(ct.getCtId());
//                ct_dto.setSeller_uid(ct.getSeller_uid());
//                ct_dto.setSeller_Name(userSellerService.findUserNameByUId(ct.getSeller_uid()));
//                ct_dto.setPid(ct.getPid());
//                ct_dto.setQuantity(ct.getQuantity());
//                ct_dto.setBuyer_uid(ct.getBuyer_uid());
//                ct_dto.setBuyer_Name(userSellerService.findUserNameByUId(ct.getBuyer_uid()));
//                ct_dto.setTid(ct.getTid());
//                ct_dto.setSellerApprove(ct.getSellerApprove());
//                ct_dto.setBuyerApprove(ct.getBuyerApprove());
//                ct_dto.setCropAmount(ct.getCropAmount());
//                ct_dto.setRate(ct.getRate());
//                ct_dto.setTaxDiscount(ct.getTaxDiscount());
//                ct_dto.setProductName(productService.findNameByPid(ct.getPid()));
//                //-------------
//                tranxDetail.addCropTranxDetails(ct_dto);
//                //tranxDetail.setListCropTranxDetails(ct_dto);
//            } // for inner
//        // ----------------
            assert false;
            traxDetailListDTO.add(tranxDetail);
        }//for outer

        return traxDetailListDTO;
    }

    @Override
    public Tranx_CropDetails_DTO getTransactionDetailsById(Long tId) {

        TransactionTbl txn =findByTid(tId);
        Tranx_CropDetails_DTO tranxDetail = new Tranx_CropDetails_DTO();
        tranxDetail.setTid(txn.getTid());
        tranxDetail.setPid(txn.getPid());
        tranxDetail.setMethod(txn.getMethod());
        tranxDetail.setTotalAmount(txn.getTotalAmount());
        tranxDetail.setOrderDate(txn.getOrderDate());
        tranxDetail.setLastUpdate(txn.getLastUpdate());
        tranxDetail.setRemark(txn.getRemark());
        tranxDetail.setNoOfEdits(txn.getNoOfEdits());
        tranxDetail.setBuyer_uid(txn.getBuyer_uid());
        tranxDetail.setProductName(txn.getProductName());
        tranxDetail.setBuyer_name(userSellerService.findUserNameByUId(txn.getBuyer_uid()));
        tranxDetail.setStatusId(txn.getStatusId());
        tranxDetail.setStatusMeaning(tranxStatusService.findMeaningByStatusId(txn.getStatusId()));
        tranxDetail.setFinalPrice(txn.getFinalPrice());
        tranxDetail.setDateOfDelivery(txn.getDateOfDelivery());
        tranxDetail.setSeller_uid(txn.getSeller_uid());
        tranxDetail.setSeller_Name(userSellerService.findUserNameByUId(txn.getSeller_uid()));
        tranxDetail.setQuantity(txn.getQuantity());
        tranxDetail.setTargetPrice(txn.getTargetPrice());
        tranxDetail.setDeliveryAddress(txn.getDeliveryAddress());
        tranxDetail.setCertification(certificatesService.listOfCertificates(txn.getCertification()));
        return tranxDetail;
    }

    @Override
    public TransactionTbl sendQueryToSeller(Long tid, Long uid) {
        TransactionTbl txn =findByTid(tid);
        txn.setStatusId(2L);
        txn.setSeller_uid(uid);
      return tranxRepo.save(txn);
    }

    @Override
    public List<TransactionTbl> getTranxForSeller(Long seller_uid) {
//        List<TransactionTbl> tblList = tranxRepo.findTranxBySellerUidAndStatusId(seller_uid, 2L);

        List<TransactionTbl> tblList = tranxRepo.findTranxBySellerUid(seller_uid);

        return tblList;
    }

    @Override
    public TransactionTbl sellerQueryConfirm(Long tid) {
        Optional<TransactionTbl> transactionTbl = tranxRepo.findById(tid);
        if(!transactionTbl.isEmpty()){
            TransactionTbl tbl = transactionTbl.get();
            tbl.setStatusId(3L);
           return tranxRepo.save(tbl);
        }
        else {
            // Handle the case where transactionTbl is not found
            // You can throw an exception, return null, or handle it based on your requirements
            return null; // For example, returning null if the entity is not found
        }
    }

    @Override
    public TransactionTbl BuyerQuotationSend(Long tid) {
        Optional<TransactionTbl> transactionTbl = tranxRepo.findById(tid);
        if(!transactionTbl.isEmpty()){
            TransactionTbl tbl = transactionTbl.get();
            tbl.setStatusId(4L);
            return tranxRepo.save(tbl);
        }
        else {
            // Handle the case where transactionTbl is not found
            // You can throw an exception, return null, or handle it based on your requirements
            return null; // For example, returning null if the entity is not found
        }
    }

    @Override
    public TransactionTbl BuyerQuotationConfirm(Long tid) {
        Optional<TransactionTbl> transactionTbl = tranxRepo.findById(tid);
        if(!transactionTbl.isEmpty()){
            TransactionTbl tbl = transactionTbl.get();
            tbl.setStatusId(5L);
            return tranxRepo.save(tbl);
        }
        else {
            // Handle the case where transactionTbl is not found
            // You can throw an exception, return null, or handle it based on your requirements
            return null; // For example, returning null if the entity is not found
        }
    }

    @Override
    public List<Tranx_CropDetails_DTO> getAllTranxDetailsByStatusId(Long statusId)
        {
            List<TransactionTbl>  tranxList = tranxRepo.findTranxByStatusId(statusId);
            List<Tranx_CropDetails_DTO> traxDetailListDTO = new ArrayList<>();
            for(TransactionTbl txn: tranxList){
                // Tranx_CropDetails_DTO tranxDetail = null;
                Tranx_CropDetails_DTO tranxDetail = new Tranx_CropDetails_DTO();
                tranxDetail.setTid(txn.getTid());
                tranxDetail.setMethod(txn.getMethod());
                tranxDetail.setTotalAmount(txn.getTotalAmount());
                tranxDetail.setOrderDate(txn.getOrderDate());
                tranxDetail.setLastUpdate(txn.getLastUpdate());
                tranxDetail.setRemark(txn.getRemark());
                tranxDetail.setNoOfEdits(txn.getNoOfEdits());
                tranxDetail.setBuyer_uid(txn.getBuyer_uid());
                tranxDetail.setProductName(txn.getProductName());
                tranxDetail.setBuyer_name(userSellerService.findUserNameByUId(txn.getBuyer_uid()));
                tranxDetail.setStatusId(txn.getStatusId());
                tranxDetail.setStatusMeaning(tranxStatusService.findMeaningByStatusId(txn.getStatusId()));
                //----------------
                assert false;
                traxDetailListDTO.add(tranxDetail);
            }//for outer

            return traxDetailListDTO;
        }

    @Override
    public List<Tranx_CropDetails_DTO> findTranxByStatusIdGreaterThanOrEqual(Long statusId)
    {
        List<Tranx_CropDetails_DTO> traxDetailListDTO = new ArrayList<>();

        List<TransactionTbl>  tranxList = tranxRepo.findTranxByStatusIdGreaterThanOrEqual(statusId);
        for(TransactionTbl txn: tranxList){
            // Tranx_CropDetails_DTO tranxDetail = null;
            Tranx_CropDetails_DTO tranxDetail = new Tranx_CropDetails_DTO();
            tranxDetail.setTid(txn.getTid());
            tranxDetail.setMethod(txn.getMethod());
            tranxDetail.setTotalAmount(txn.getTotalAmount());
            tranxDetail.setOrderDate(txn.getOrderDate());
            tranxDetail.setLastUpdate(txn.getLastUpdate());
            tranxDetail.setRemark(txn.getRemark());
            tranxDetail.setNoOfEdits(txn.getNoOfEdits());
            tranxDetail.setBuyer_uid(txn.getBuyer_uid());
            tranxDetail.setProductName(txn.getProductName());
            tranxDetail.setBuyer_name(userSellerService.findUserNameByUId(txn.getBuyer_uid()));
            tranxDetail.setStatusId(txn.getStatusId());
            tranxDetail.setStatusMeaning(tranxStatusService.findMeaningByStatusId(txn.getStatusId()));
            //----------------
//            for(CropTranx ct : cropTranxService.findAllbyTid(txn.getTid())){
//                //CropTranxDetails_DTO ct_dto=null;
//                CropTranxDetails_DTO ct_dto=new CropTranxDetails_DTO();
//                ct_dto.setCtId(ct.getCtId());
//                ct_dto.setSeller_uid(ct.getSeller_uid());
//                ct_dto.setSeller_Name(userSellerService.findUserNameByUId(ct.getSeller_uid()));
//                ct_dto.setPid(ct.getPid());
//                ct_dto.setQuantity(ct.getQuantity());
//                ct_dto.setBuyer_uid(ct.getBuyer_uid());
//                ct_dto.setBuyer_Name(userSellerService.findUserNameByUId(ct.getBuyer_uid()));
//                ct_dto.setTid(ct.getTid());
//                ct_dto.setSellerApprove(ct.getSellerApprove());
//                ct_dto.setBuyerApprove(ct.getBuyerApprove());
//                ct_dto.setCropAmount(ct.getCropAmount());
//                ct_dto.setRate(ct.getRate());
//                ct_dto.setTaxDiscount(ct.getTaxDiscount());
//                ct_dto.setProductName(productService.findNameByPid(ct.getPid()));
//                //-------------
//                tranxDetail.addCropTranxDetails(ct_dto);
//                //tranxDetail.setListCropTranxDetails(ct_dto);
//            } // for inner
//        // ----------------
            assert false;
            traxDetailListDTO.add(tranxDetail);
        }//for outer

        return traxDetailListDTO;
    }

    @Override
    public List<Tranx_CropDetails_DTO> findTranxByStatusIdLessThanOrEqual(Long statusId){
        List<Tranx_CropDetails_DTO> traxDetailListDTO = new ArrayList<>();

        List<TransactionTbl>  tranxList = tranxRepo.findTranxByStatusIdLessThanOrEqual(statusId);
        for(TransactionTbl txn: tranxList){
            // Tranx_CropDetails_DTO tranxDetail = null;
            Tranx_CropDetails_DTO tranxDetail = new Tranx_CropDetails_DTO();
            tranxDetail.setTid(txn.getTid());
            tranxDetail.setMethod(txn.getMethod());
            tranxDetail.setTotalAmount(txn.getTotalAmount());
            tranxDetail.setOrderDate(txn.getOrderDate());
            tranxDetail.setLastUpdate(txn.getLastUpdate());
            tranxDetail.setRemark(txn.getRemark());
            tranxDetail.setNoOfEdits(txn.getNoOfEdits());
            tranxDetail.setBuyer_uid(txn.getBuyer_uid());
            tranxDetail.setProductName(txn.getProductName());
            tranxDetail.setBuyer_name(userSellerService.findUserNameByUId(txn.getBuyer_uid()));
            tranxDetail.setStatusId(txn.getStatusId());
            tranxDetail.setStatusMeaning(tranxStatusService.findMeaningByStatusId(txn.getStatusId()));

            assert false;
            traxDetailListDTO.add(tranxDetail);
        }//for outer

        return traxDetailListDTO;
    }

    @Override
    public TransactionTbl sendQuotation(Tranx_CropDetails_DTO tranxCropDetailsDto)
    {
        if(tranxCropDetailsDto!=null)
        {
         TransactionTbl tranx=   tranxRepo.findById(tranxCropDetailsDto.getTid()).get();
         tranx.setStatusId(4L);
         tranx.setFinalPrice(tranxCropDetailsDto.getFinalPrice());
         tranx.setDateOfDelivery(tranxCropDetailsDto.getDateOfDelivery());
         return tranxRepo.save(tranx);
        }
        else
        {
            return null;
        }

    }

    @Override
    public TransactionTbl sendOrderToSeller(Long tid) {
        TransactionTbl tranx=   tranxRepo.findById(tid).get();

        if(tranx!=null)
        {
            tranx.setStatusId(6L);
            return tranxRepo.save(tranx);
        }
        else
        {
            return null;
        }
    }

    @Override
    public Quotation_DTO buyerViewQuotation(Long tid) {
        Quotation_DTO quotationDto = new Quotation_DTO();
        Tranx_CropDetails_DTO  tranxCropDetailsDto =getTransactionDetailsById(tid);
        TransactionTbl transactionTbl =tranxRepo.findById(tid).get();
        quotationDto.setProductName(tranxCropDetailsDto.getProductName());
        Product product = productService.getProductById(Math.toIntExact(transactionTbl.getPid()));
        quotationDto.setProductCategory(product.getCategory());
        UserSeller buyer= userSellerService.findById(Math.toIntExact(transactionTbl.getBuyer_uid()));
        quotationDto.setBuyerAddress(buyer.getAddress());
        quotationDto.setBuyerName(buyer.getUserName());
        quotationDto.setBuyerContact(buyer.getMobileNo());
        quotationDto.setFinalPrice(transactionTbl.getFinalPrice());
        quotationDto.setDateOfDelivery(transactionTbl.getDateOfDelivery());



        return quotationDto;
    }

    @Override
    public List<Tranx_CropDetails_DTO> getAllTranxDetailsBy() {
        return null;
    }

    @Override
    public List<TransactionTbl> findTranxByBuyerUid(Long buyerId) {

        List<TransactionTbl> tblList = tranxRepo.findTranxByBuyerUid(buyerId);
        return tblList;
    }

    @Override
    public Page<Tranx_CropDetails_DTO> getAllTranxDetailsByStatusIdPaginated(int pageNo, int pageSize, Long statusId) {
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        Page<TransactionTbl> tranxListPaginated = tranxRepo.findTranxByStatusId(statusId, pageable);

        List<Tranx_CropDetails_DTO> traxDetailListDTO = new ArrayList<>();
        for (TransactionTbl txn : tranxListPaginated.getContent()) {
            Tranx_CropDetails_DTO tranxDetail = new Tranx_CropDetails_DTO();
            tranxDetail.setTid(txn.getTid());
            tranxDetail.setMethod(txn.getMethod());
            tranxDetail.setTotalAmount(txn.getTotalAmount());
            tranxDetail.setOrderDate(txn.getOrderDate());
            tranxDetail.setLastUpdate(txn.getLastUpdate());
            tranxDetail.setRemark(txn.getRemark());
            tranxDetail.setNoOfEdits(txn.getNoOfEdits());
            tranxDetail.setBuyer_uid(txn.getBuyer_uid());
            tranxDetail.setProductName(txn.getProductName());
            tranxDetail.setBuyer_name(userSellerService.findUserNameByUId(txn.getBuyer_uid()));
            tranxDetail.setStatusId(txn.getStatusId());
            tranxDetail.setStatusMeaning(tranxStatusService.findMeaningByStatusId(txn.getStatusId()));
            assert false;
            traxDetailListDTO.add(tranxDetail);
        }
        System.out.println(traxDetailListDTO);

        return new PageImpl<>(traxDetailListDTO, pageable, tranxListPaginated.getTotalElements());
    }


    @Override
    public Page<Tranx_CropDetails_DTO> findTranxByStatusIdGreaterThanOrEqualPaginated(int pageNo, int pageSize, Long statusId) {
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        Page<TransactionTbl> tranxListPaginated = tranxRepo.findTranxByStatusIdGreaterThanOrEqual(statusId, pageable);

        List<Tranx_CropDetails_DTO> traxDetailListDTO = new ArrayList<>();
        for (TransactionTbl txn : tranxListPaginated.getContent()) {
            Tranx_CropDetails_DTO tranxDetail = new Tranx_CropDetails_DTO();
            tranxDetail.setTid(txn.getTid());
            tranxDetail.setMethod(txn.getMethod());
            tranxDetail.setTotalAmount(txn.getTotalAmount());
            tranxDetail.setOrderDate(txn.getOrderDate());
            tranxDetail.setLastUpdate(txn.getLastUpdate());
            tranxDetail.setRemark(txn.getRemark());
            tranxDetail.setNoOfEdits(txn.getNoOfEdits());
            tranxDetail.setBuyer_uid(txn.getBuyer_uid());
            tranxDetail.setProductName(txn.getProductName());
            tranxDetail.setBuyer_name(userSellerService.findUserNameByUId(txn.getBuyer_uid()));
            tranxDetail.setStatusId(txn.getStatusId());
            tranxDetail.setPaymentStatus(txn.getPaymentStatus());
            tranxDetail.setStatusMeaning(tranxStatusService.findMeaningByStatusId(txn.getStatusId()));
            assert false;
            traxDetailListDTO.add(tranxDetail);
        }
        System.out.println(traxDetailListDTO);

        return new PageImpl<>(traxDetailListDTO, pageable, tranxListPaginated.getTotalElements());
    }

    @Override
    public Page<Tranx_CropDetails_DTO> findTranxByStatusIdLessThanOrEqualPaginated(int pageNo, int pageSize, Long statusId) {
        Pageable pageable = PageRequest.of(pageNo - 1, pageSize);
        Page<TransactionTbl> tranxListPaginated = tranxRepo.findTranxByStatusIdLessThanOrEqual(statusId, pageable);

        List<Tranx_CropDetails_DTO> traxDetailListDTO = new ArrayList<>();
        for (TransactionTbl txn : tranxListPaginated.getContent()) {
            Tranx_CropDetails_DTO tranxDetail = new Tranx_CropDetails_DTO();
            tranxDetail.setTid(txn.getTid());
            tranxDetail.setMethod(txn.getMethod());
            tranxDetail.setTotalAmount(txn.getTotalAmount());
            tranxDetail.setOrderDate(txn.getOrderDate());
            tranxDetail.setLastUpdate(txn.getLastUpdate());
            tranxDetail.setRemark(txn.getRemark());
            tranxDetail.setNoOfEdits(txn.getNoOfEdits());
            tranxDetail.setBuyer_uid(txn.getBuyer_uid());
            tranxDetail.setProductName(txn.getProductName());
            tranxDetail.setBuyer_name(userSellerService.findUserNameByUId(txn.getBuyer_uid()));
            tranxDetail.setStatusId(txn.getStatusId());
            tranxDetail.setStatusMeaning(tranxStatusService.findMeaningByStatusId(txn.getStatusId()));
            assert false;
            traxDetailListDTO.add(tranxDetail);
        }
        System.out.println(traxDetailListDTO);

        return new PageImpl<>(traxDetailListDTO, pageable, tranxListPaginated.getTotalElements());
    }

    @Override
    public TransactionTbl setPaymentDetails(Long tId, PaymentDTO paymentDTO) {
        if (paymentDTO == null) {
            throw new IllegalArgumentException("PaymentDTO cannot be null");
        }
        TransactionTbl trnx = tranxRepo.findById(tId)
                .orElseThrow(() -> new EntityNotFoundException("TransactionTbl with tid " + tId + " not found"));
        trnx.setPaymentId(paymentDTO.getPaymentId());
        trnx.setPaymentDate(LocalDate.now());
        Boolean paymentStatus = paymentDTO.getPaymentStatus();
        if (paymentStatus == null) {
            throw new IllegalArgumentException("PaymentStatus cannot be null");
        }
        trnx.setPaymentStatus(paymentStatus ? "Paid" : "Failed Transaction");
        return tranxRepo.save(trnx);
    }



}
