package com.pragma.orders.infrastructure.adapter;

import com.pragma.orders.domain.model.Order;
import com.pragma.orders.domain.port.OrderRepository;
import com.pragma.orders.infrastructure.entity.OrderEntity;
import com.pragma.orders.infrastructure.jpa.SpringDataOrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class OrderJpaRepository implements OrderRepository {
    private final SpringDataOrderRepository springDataOrderRepository;
    private final OrderEntityMapper orderEntityMapper;

    @Override
    public Order save(Order order) {
        OrderEntity entity = orderEntityMapper.toEntity(order);
        OrderEntity savedEntity = springDataOrderRepository.save(entity);
        return orderEntityMapper.toDomain(savedEntity);
    }

    @Override
    public Optional<Order> findById(UUID id) {
        return springDataOrderRepository.findById(id)
                .map(orderEntityMapper::toDomain);
    }

    @Override
    public List<Order> findAll() {
        return springDataOrderRepository.findAll().stream()
                .map(orderEntityMapper::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<Order> findByCustomerId(UUID customerId) {
        return springDataOrderRepository.findByCustomerId(customerId).stream()
                .map(orderEntityMapper::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public void deleteById(UUID id) {
        springDataOrderRepository.deleteById(id);
    }
}