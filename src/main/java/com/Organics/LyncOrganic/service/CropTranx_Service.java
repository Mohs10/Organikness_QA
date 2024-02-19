package com.Organics.LyncOrganic.service;

import com.Organics.LyncOrganic.entity.CropTranx;

import java.util.List;

public interface CropTranx_Service {
    List<CropTranx> saveListCT(List<CropTranx> listCT);

    CropTranx save(CropTranx addCT);

    List<CropTranx> findAllbyTid(Long tid);

    List<CropTranx> findAll();

    CropTranx findByTidAndPidAndSellerUid(Long tid,Long pid,Long seller_uid);
}
