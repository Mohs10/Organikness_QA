package com.Organics.LyncOrganic.DTO;

import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class AddTranx_DTO {
    private Long buyer_uid;
    private List<Long> certificationList;
    private String remark;
    private String method;
    private Long pid;
    private Integer quantity;
    private Float targetPrice;
    private String deliveryAddress;

}
