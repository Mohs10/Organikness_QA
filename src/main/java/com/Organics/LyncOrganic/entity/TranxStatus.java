package com.Organics.LyncOrganic.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "Transaction_Status")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class TranxStatus {
    @Id
    //@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(unique = true,name = "Status_id")
    private Long statusId;

    @Column(name = "Meaning")
    private String meaning;

}
