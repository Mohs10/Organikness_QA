package com.Organics.LyncOrganic.DTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
///  Seller Pending Approval
public class SelPenApr_DTO {
    private Long tid;
    private Long seller_uid;
    private Long buyer_uid;
    private Long pid;
    private Long statusId;
    private Boolean sellerApprove;


    public SelPenApr_DTO(SelPenApr_DTO dto) {
    }
}
