package com.Organics.LyncOrganic.serviceImpl;

import com.Organics.LyncOrganic.entity.CropTranx;
import com.Organics.LyncOrganic.repository.CropTranx_Repo;
import com.Organics.LyncOrganic.service.CropTranx_Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CropTranx_ServiceImpl implements CropTranx_Service {
    @Autowired
    private CropTranx_Repo cropTranxRepo;

    @Override
    public List<CropTranx> saveListCT(List<CropTranx> listCT) {
        return cropTranxRepo.saveAll(listCT);
    }

    @Override
    public CropTranx save(CropTranx addCT) {
        return cropTranxRepo.save(addCT);
    }

    @Override
    public List<CropTranx> findAllbyTid(Long tid) { return cropTranxRepo.findAllByTid(tid);    }

    @Override
    public List<CropTranx> findAll() { return cropTranxRepo.findAll();   }

    @Override
    public CropTranx findByTidAndPidAndSellerUid(Long tid, Long pid, Long seller_uid) {
        return cropTranxRepo.findByTidAndPidAndSellerUid(tid,pid,seller_uid);
    }

}
