package com.Organics.LyncOrganic.service;

import com.Organics.LyncOrganic.entity.TranxStatus;

import java.util.List;
import java.util.Optional;

public interface TranxStatus_Service {
     TranxStatus saveTranxStatus(TranxStatus tranxStatus);
     List<TranxStatus> findAll();
     TranxStatus findByStatusId(Integer statusId);
     String findMeaningByStatusId(Long statusId);
}
