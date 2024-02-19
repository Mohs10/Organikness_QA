package com.Organics.LyncOrganic.DTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class CropTranx_DTO {
//    private Long seller_uid;
    private Long pid;
    private Integer quantity;
}
