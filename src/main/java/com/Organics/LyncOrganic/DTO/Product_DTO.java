package com.Organics.LyncOrganic.DTO;

import lombok.Data;
import org.springframework.http.MediaType;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@Data
public class Product_DTO {

    private Long pid;
    private String category;
    private String name;
    private Float maxPrice;
    private Float minPrice;
    private Float quantity;
    private Float rate;
    private MultipartFile file; // Modify this to hold the file directly
    private List<String> certificationName = new ArrayList<>();
    public  void addCertification(String name){this.certificationName.add(name);}

//    public  void addProductDetails(Product_DTO productDto){this.listOfProducts.add(productDto);}

}

