package com.Organics.LyncOrganic.serviceImpl;

import com.Organics.LyncOrganic.DTO.Product_DTO;
import com.Organics.LyncOrganic.entity.Product;
import com.Organics.LyncOrganic.repository.Product_Repo;
import com.Organics.LyncOrganic.service.Product_Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class Product_ServiceImpl implements Product_Service {

    @Autowired
    private Product_Repo productRepo;

    private Map<Long, Product> productCache = new HashMap<>();


    @Override
    public List<Product> findall() {
        return productRepo.findAll();
    }

//    @Override
//    public Product getProductById(Integer pid) {
//        return productRepo.findById(Long.valueOf(pid)).orElse(null);
//    }

    @Override
    public Product addProduct(Product product) {
        return productRepo.save(product);
    }

    @Override
    public Boolean isProductExists(Long pid) {
        return productRepo.existsById(pid);
    }

    @Override
    public Boolean isProductExistsByname(String ProductName) {
//        String PName = ProductName.toLowerCase();
//
//        List<Product> products = productRepo.findAll();
//        for(Product product :products)
//        {
//            if (product.getName().toLowerCase().equals(PName))
//            {
//                return true;
//            }
//        }

        return productRepo.existsProductByName(ProductName);
    }

@Override
    public Page<Product> findPaginated(int pageNo, int pageSize) {
        Pageable pageable = PageRequest.of(pageNo-1, pageSize);

//        System.out.println(productRepo.findAll(pageable).);
        return productRepo.findAll(pageable);
    }

    @Override
    public List<String> findAllDistinctCategories() {
        List<String> productList = productRepo.findDistinctCategories();

        // Extracting distinct categories using Java streams
        List<String> distinctCategories = productList.stream()
                .distinct() // Removing duplicates
                .collect(Collectors.toList());

        return distinctCategories;
    }

    @Override
    public Page<Product> findProductsByCategoryPaginated(String category, int pageNo, int pageSize) {
        Pageable pageable = PageRequest.of(pageNo-1, pageSize);
        return productRepo.findByCategory(category, pageable);
    }

    @Override
    public String findNameByPid(Long pid) {
        return productRepo.findNameByPid(pid);
    }

    @Override
    public List<String> findAllSellersByProductId(Long pid) {


        return null;
    }

@Override
    public Product getProductById(Integer pid) {
        Long id= Long.valueOf(pid);

        if (productCache.containsKey(id)) {
            System.out.println(productCache);
            return productCache.get(id);
        }

        Product product = productRepo.findById(id).orElse(null);
        if (product != null) {
            productCache.put(id, product);
        }

        return product;
    }







//    private Map<Long, Product> productCache = new HashMap<>();
//    private ProductRepository productRepository;



    private void initializeCache() {
        List<Product> products = productRepo.findAll();
        products.forEach(product -> productCache.put(product.getPid(), product));
    }

    public List<Product> findAll2() {
        return new ArrayList<>(productCache.values());
    }

    public Product findById(Long id) {
        return productCache.get(id);
    }

    public Product save2(Product product) {
        Product savedProduct = productRepo.save(product);
        productCache.put(savedProduct.getPid(), savedProduct);
        return savedProduct;
    }

    public void deleteById(Long id) {
        productRepo.deleteById(id);
        productCache.remove(id);
    }






























}
