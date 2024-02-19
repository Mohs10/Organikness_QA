package com.Organics.LyncOrganic.serviceImpl;

import com.Organics.LyncOrganic.entity.Certificate;
import com.Organics.LyncOrganic.repository.Certificate_Repo;
import com.Organics.LyncOrganic.repository.CropTranx_Repo;
import com.Organics.LyncOrganic.service.Certificates_Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class Certificates_ServiceImpl implements Certificates_Service {
    @Autowired
    private Certificate_Repo certificateRepo;


    @Override
    public List<Certificate> fetchAllCertificates() {
        return certificateRepo.findAll();
    }

    @Override
    public Certificate findCertificateById(Long cerId) {
        Optional<Certificate> certificate= certificateRepo.findById(cerId);

        return certificate.get();
    }

    @Override
    public List<String> listOfCertificates(String certificationList) {

        List<String> certificateNames = new ArrayList<>();
        List<Long> cIdList= Arrays.stream(certificationList.split(","))
                .map(Long::parseLong)
                .collect(Collectors.toList());
        for(Long cId:cIdList )
        {
            certificateNames.add(certificateRepo.findCertNameById(cId));
        }
        return certificateNames;
    }
}
