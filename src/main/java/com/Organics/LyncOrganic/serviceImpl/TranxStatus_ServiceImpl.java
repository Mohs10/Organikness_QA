package com.Organics.LyncOrganic.serviceImpl;

import com.Organics.LyncOrganic.entity.TranxStatus;
import com.Organics.LyncOrganic.repository.TranxStatus_Repo;
import com.Organics.LyncOrganic.service.TranxStatus_Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TranxStatus_ServiceImpl implements TranxStatus_Service {
      /*
        1	Txn Begin
        2	Txn Pending
        3	Txn Confirm
        4	Txn on Hold / Delay
        5	Txn Completed
        0	Transaction canceled
    */
    @Autowired
    private TranxStatus_Repo tranxStatusRepo;

    public TranxStatus saveTranxStatus(TranxStatus tranxStatus){
        tranxStatusRepo.save(tranxStatus);
        return  tranxStatus;
    }

    public List<TranxStatus> findAll() {
        return tranxStatusRepo.findAll();
    }

    public TranxStatus findByStatusId(Integer statusId) {
        return tranxStatusRepo.findById(Long.valueOf(statusId)).orElse(null);
    }

    @Override
    public String findMeaningByStatusId(Long statusId) {
        return tranxStatusRepo.findMeaningByStatusId(statusId);
    }
}
