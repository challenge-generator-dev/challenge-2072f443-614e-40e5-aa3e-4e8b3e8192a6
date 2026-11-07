-- Script de migración inicial para el esquema de la base de datos del servicio de órdenes
-- Versión: V1
-- Objetivo: Crear las tablas necesarias para almacenar información de órdenes y sus elementos

-- Tabla de órdenes
CREATE TABLE orders (
    id UUID PRIMARY KEY,
    customer_id UUID NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    total_amount DECIMAL(19, 2) NOT NULL DEFAULT 0.00,
    shipping_address VARCHAR(500) NOT NULL,
    payment_method VARCHAR(100) NOT NULL,
    notes TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de elementos de orden
CREATE TABLE order_items (
    id UUID PRIMARY KEY,
    order_id UUID NOT NULL,
    product_id UUID NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(19, 2) NOT NULL CHECK (unit_price >= 0),
    total_price DECIMAL(19, 2) NOT NULL CHECK (total_price >= 0),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE
);

-- Índices para optimizar consultas frecuentes
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_order_date ON orders(order_date DESC);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- Comentarios para documentación del esquema
COMMENT ON TABLE orders IS 'Almacena las órdenes realizadas por los clientes';
COMMENT ON TABLE order_items IS 'Contiene los elementos individuales de cada orden';
COMMENT ON COLUMN orders.status IS 'Estados posibles: PENDING, CONFIRMED, PREPARING, READY, DELIVERED, CANCELLED';
COMMENT ON COLUMN orders.total_amount IS 'Monto total de la orden incluyendo todos los elementos';
COMMENT ON COLUMN order_items.total_price IS 'Precio unitario multiplicado por la cantidad';

-- Función para actualizar automáticamente la columna updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger para actualizar updated_at en la tabla orders
CREATE TRIGGER update_orders_updated_at
    BEFORE UPDATE ON orders
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Restricciones adicionales a nivel de base de datos
ALTER TABLE orders ADD CONSTRAINT chk_orders_total_amount_positive
    CHECK (total_amount >= 0);

ALTER TABLE orders ADD CONSTRAINT chk_orders_status_valid
    CHECK (status IN ('PENDING', 'CONFIRMED', 'PREPARING', 'READY', 'DELIVERED', 'CANCELLED'));

ALTER TABLE order_items ADD CONSTRAINT chk_order_items_quantity_positive
    CHECK (quantity > 0);

ALTER TABLE order_items ADD CONSTRAINT chk_order_items_unit_price_positive
    CHECK (unit_price >= 0);

ALTER TABLE order_items ADD CONSTRAINT chk_order_items_total_price_positive
    CHECK (total_price >= 0);