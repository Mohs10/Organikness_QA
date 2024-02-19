package com.Organics.LyncOrganic.serviceImpl;

import com.Organics.LyncOrganic.DTO.Product_DTO;
import com.Organics.LyncOrganic.entity.Product;
import com.Organics.LyncOrganic.entity.ProductImage;
import com.Organics.LyncOrganic.repository.ProductImage_Repo;
import com.Organics.LyncOrganic.service.ProductImage_Service;
import com.Organics.LyncOrganic.service.Product_Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ProductImage_ServiceImpl implements ProductImage_Service {
    @Autowired
    private ProductImage_Repo piRepo;
    @Autowired
    private Product_Service productService;

    @Override
    public void uploadImage(Long pid, MultipartFile file) throws IOException {
        try{
            // if pid is not Valid
            if(!productService.isProductExists(pid))
                throw new RuntimeException("pid: "+pid+" is INVALID !!!");
            ProductImage productImage = new ProductImage();
            productImage.setPid(pid);
            productImage.setImageContent(file.getBytes());
            piRepo.save(productImage);
    } catch (IOException e) {
            throw new IOException("Failed to upload image: " + e.getMessage());
        }
    }

    @Override
    public byte[] getImageByProductId(Long pid) {
        Optional<ProductImage> optionalProductImage = piRepo.findById(pid);
        return optionalProductImage.map(ProductImage::getImageContent).orElse(null);
    }

//    @Override
//    public List<Product_DTO> getAllProducts() {
//        List<Product> products = productService.findall();
//        List<ProductImage> productImages = piRepo.findAll();
//
//        List<Product_DTO> combinedList = combineProductsAndImages( products,  productImages);
//
//
//
//
//
//        return combinedList;
//    }
//
//    @Override
//    public Page<Product_DTO> findPaginated(int pageNo, int pageSize) {
//        Page<Product> productPage = productService.findPaginated(pageNo, pageSize);
//        List<ProductImage> productImages = piRepo.findAll();
//
//        List<Product_DTO> combinedList = combineProductsAndImages(productPage.getContent(), productImages);
//
//        return new PageImpl<>(combinedList, PageRequest.of(pageNo, pageSize), productPage.getTotalElements());
//    }
//
//
//    @Override
//    public List<Product_DTO> combineProductsAndImages(List<Product> products, List<ProductImage> productImages) {
//        List<Product_DTO> combinedList = new ArrayList<>();
//
//        for (Product product : products) {
//            Product_DTO productDTO = new Product_DTO();
//            productDTO.setPid(product.getPid());
//            productDTO.setCategory(product.getCategory());
//            productDTO.setName(product.getName());
//
//            // Find the corresponding image for the product
//            ProductImage correspondingImage = findCorrespondingImage(productImages, product.getPid());
//            if (correspondingImage != null) {
//                productDTO.setImageContent(correspondingImage.getImageContent());
//            }
//
//            combinedList.add(productDTO);
//        }
//
//        return combinedList;
//    }
//
//
//@Override
//    public List<String> findAllDistinctCategories() {
//        List<Product_DTO> productList = getAllProducts();
//
//        // Extracting distinct categories using Java streams
//        List<String> distinctCategories = productList.stream()
//                .map(Product_DTO::getCategory) // Extracting categories
//                .distinct() // Removing duplicates
//                .collect(Collectors.toList());
//
//        return distinctCategories;
//    }
//
//    private ProductImage findCorrespondingImage(List<ProductImage> productImages, Long productId) {
//        for (ProductImage image : productImages) {
//            if (image.getPid().equals(productId)) {
//                return image;
//            }
//        }
//        return null;
//    }


}
