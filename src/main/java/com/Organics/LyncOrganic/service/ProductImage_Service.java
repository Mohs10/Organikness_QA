package com.Organics.LyncOrganic.service;

import com.Organics.LyncOrganic.DTO.Product_DTO;
import com.Organics.LyncOrganic.entity.Product;
import com.Organics.LyncOrganic.entity.ProductImage;
import org.springframework.data.domain.Page;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface ProductImage_Service {
    void uploadImage(Long pid, MultipartFile file) throws IOException;

    byte[] getImageByProductId(Long pid);



}
