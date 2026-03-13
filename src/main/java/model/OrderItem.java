package model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderItem {
    private int id;
    private int orderId;
    private int productId;
    private String name;
    private double price;
    private String state;
    private int quantity;

}