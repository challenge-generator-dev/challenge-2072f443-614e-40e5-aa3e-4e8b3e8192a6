package com.pragma.orders.infrastructure.adapter;

import com.pragma.orders.application.dto.OrderItemRequestDTO;
import com.pragma.orders.application.dto.OrderItemResponseDTO;
import com.pragma.orders.application.dto.OrderRequestDTO;
import com.pragma.orders.application.dto.OrderResponseDTO;
import com.pragma.orders.domain.model.Order;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class OrderEntityMapper {

    public Order toDomain(OrderRequestDTO dto) {
        if (dto == null) {
            return null;
        }

        Order order = new Order();
        order.setCustomerId(dto.getCustomerId());
        order.setShippingAddress(dto.getShippingAddress());
        order.setPaymentMethod(dto.getPaymentMethod());
        order.setNotes(dto.getNotes());

        List<Order.OrderItem> items = dto.getItems().stream()
                .map(this::toDomainItem)
                .collect(Collectors.toList());
        order.setItems(items);

        return order;
    }

    private Order.OrderItem toDomainItem(OrderItemRequestDTO dto) {
        Order.OrderItem item = new Order.OrderItem();
        item.setId(UUID.randomUUID());
        item.setProductId(dto.getProductId());
        item.setProductName(dto.getProductName());
        item.setQuantity(dto.getQuantity());
        item.setUnitPrice(dto.getUnitPrice());
        item.setTotalPrice(dto.getTotalPrice());
        return item;
    }

    public OrderResponseDTO toResponse(Order order) {
        if (order == null) {
            return null;
        }

        OrderResponseDTO dto = new OrderResponseDTO();
        dto.setId(order.getId());
        dto.setCustomerId(order.getCustomerId());
        dto.setOrderDate(order.getOrderDate());
        dto.setStatus(order.getStatus());
        dto.setTotalAmount(order.getTotalAmount());
        dto.setShippingAddress(order.getShippingAddress());
        dto.setPaymentMethod(order.getPaymentMethod());
        dto.setNotes(order.getNotes());

        List<OrderItemResponseDTO> items = order.getItems().stream()
                .map(this::toResponseItem)
                .collect(Collectors.toList());
        dto.setItems(items);

        return dto;
    }

    private OrderItemResponseDTO toResponseItem(Order.OrderItem item) {
        return new OrderItemResponseDTO(
                item.getId(),
                item.getProductId(),
                item.getProductName(),
                item.getQuantity(),
                item.getUnitPrice(),
                item.getTotalPrice()
        );
    }
}