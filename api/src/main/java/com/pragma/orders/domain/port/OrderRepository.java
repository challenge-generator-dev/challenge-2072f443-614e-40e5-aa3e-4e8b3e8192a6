package com.pragma.orders.domain.port;

import com.pragma.orders.domain.model.Order;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface OrderRepository {
    Order save(Order order);
    Optional<Order> findById(UUID id);
    List<Order> findAll();
    List<Order> findByCustomerId(UUID customerId);
    void deleteById(UUID id);
}