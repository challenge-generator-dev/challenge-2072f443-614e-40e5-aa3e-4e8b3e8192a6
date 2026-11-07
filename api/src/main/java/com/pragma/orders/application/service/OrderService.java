package com.pragma.orders.application.service;

import com.pragma.orders.application.dto.OrderRequestDTO;
import com.pragma.orders.application.dto.OrderResponseDTO;
import com.pragma.orders.domain.model.Order;
import com.pragma.orders.domain.port.OrderRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderEntityMapper orderEntityMapper;

    public OrderService(OrderRepository orderRepository, OrderEntityMapper orderEntityMapper) {
        this.orderRepository = orderRepository;
        this.orderEntityMapper = orderEntityMapper;
    }

    @Transactional
    public OrderResponseDTO createOrder(OrderRequestDTO request) {
        Order order = orderEntityMapper.toDomain(request);
        order.setId(UUID.randomUUID());
        order.setOrderDate(LocalDateTime.now());
        order.setStatus(Order.OrderStatus.PENDING.name());
        order.setTotalAmount(calculateTotal(order));

        Order savedOrder = orderRepository.save(order);
        return orderEntityMapper.toResponse(savedOrder);
    }

    @Transactional(readOnly = true)
    public OrderResponseDTO getOrder(UUID id) {
        return orderRepository.findById(id)
                .map(orderEntityMapper::toResponse)
                .orElseThrow(() -> new OrderNotFoundException("Orden no encontrada: " + id));
    }

    @Transactional(readOnly = true)
    public List<OrderResponseDTO> listOrders() {
        return orderRepository.findAll().stream()
                .map(orderEntityMapper::toResponse)
                .collect(Collectors.toList());
    }

    private BigDecimal calculateTotal(Order order) {
        return order.getItems().stream()
                .map(item -> item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public static class OrderNotFoundException extends RuntimeException {
        public OrderNotFoundException(String message) {
            super(message);
        }
    }
}