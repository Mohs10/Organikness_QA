package com.Organics.LyncOrganic.service;

import com.Organics.LyncOrganic.entity.ProductCategory;

import java.util.List;

public interface ProdCategory_Services {

    public ProductCategory saveCategory(ProductCategory category);

    public List<String> allCategory();

    public boolean isExsits(String name);
}
