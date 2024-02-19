package com.Organics.LyncOrganic.service;

import com.Organics.LyncOrganic.entity.Certificate;

import java.util.List;

public interface Certificates_Service {

    List<Certificate> fetchAllCertificates();

    Certificate findCertificateById(Long cerId);

    List<String> listOfCertificates(String certificationList);
}
