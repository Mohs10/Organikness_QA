package com.Organics.LyncOrganic.DTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class SetStatus_DTO {
    private Long tid;
    private Long statusId;
}
