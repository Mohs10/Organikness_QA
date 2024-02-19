package com.Organics.LyncOrganic.entity;
import java.io.Serializable;
import lombok.Data;

@Data
public class SellerProductKey implements Serializable {
    private Long pid;
    private Long uid;
}