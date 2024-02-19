package com.Organics.LyncOrganic.serviceImpl;

import com.Organics.LyncOrganic.entity.ProductCategory;
import com.Organics.LyncOrganic.repository.Category_Repo;
import com.Organics.LyncOrganic.service.ProdCategory_Services;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProdCategory_ServicesImpl implements ProdCategory_Services {
    @Autowired
    private Category_Repo categoryRepo;
    @Override
    public ProductCategory saveCategory(ProductCategory category) {
        return categoryRepo.save(category);
    }

    @Override
    public List<String> allCategory() {
        return categoryRepo.findAllCategoryNames();
    }

    @Override
    public boolean isExsits(String name) {
        return categoryRepo.existsByCategoryName(name);
    }
}
