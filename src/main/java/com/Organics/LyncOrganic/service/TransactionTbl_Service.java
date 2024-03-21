package com.Organics.LyncOrganic.service;

import com.Organics.LyncOrganic.DTO.*;
import com.Organics.LyncOrganic.entity.CropTranx;
import com.Organics.LyncOrganic.entity.TransactionTbl;
import org.springframework.data.domain.Page;

import java.util.List;

public interface TransactionTbl_Service {
    TransactionTbl add(AddTranx_DTO addTranxDTO);

    List<TransactionTbl> findAll();

    TransactionTbl findByTid(Long tid);

    List<CropTranx> getAllSeller_PendingApprovals();

    List<SelPenApr_DTO> getAllSellers_PendingApproval();

    CropTranx setSeller_CropTranxApproval(SelPenApr_DTO dto);

    List<SelPenApr_DTO> getSellerID_PendingApproval(Long sid);

    TransactionTbl setTranxStatus(SetStatus_DTO statusDto);
    List<Tranx_CropDetails_DTO> getAllTranxDetails();
    Tranx_CropDetails_DTO getTransactionDetailsById(Long tId);
    TransactionTbl sendQueryToSeller(Long tid ,Long uid);
    List<TransactionTbl> getTranxForSeller(Long seller_uid);
    TransactionTbl sellerQueryConfirm(Long tid);
    TransactionTbl BuyerQuotationSend(Long tid);
    TransactionTbl BuyerQuotationConfirm(Long tid);
    List<Tranx_CropDetails_DTO> getAllTranxDetailsByStatusId( Long statusId);
    List<Tranx_CropDetails_DTO> findTranxByStatusIdGreaterThanOrEqual( Long statusId);
    List<Tranx_CropDetails_DTO> findTranxByStatusIdLessThanOrEqual( Long statusId);

    TransactionTbl sendQuotation(Tranx_CropDetails_DTO tranxCropDetailsDto);

    TransactionTbl sendOrderToSeller(Long tid);
    Quotation_DTO buyerViewQuotation(Long tid);

    List<Tranx_CropDetails_DTO> getAllTranxDetailsBy();

    List<TransactionTbl> findTranxByBuyerUid(Long buyerId);

    Page<Tranx_CropDetails_DTO> getAllTranxDetailsByStatusIdPaginated(int pageNo,int pageSize,Long statusId);
    Page<Tranx_CropDetails_DTO> findTranxByStatusIdGreaterThanOrEqualPaginated(int pageNo,int pageSize,Long statusId);
    Page<Tranx_CropDetails_DTO> findTranxByStatusIdLessThanOrEqualPaginated(int pageNo,int pageSize,Long statusId);

    TransactionTbl setPaymentDetails(Long tId, PaymentDTO paymentDTO);

}
