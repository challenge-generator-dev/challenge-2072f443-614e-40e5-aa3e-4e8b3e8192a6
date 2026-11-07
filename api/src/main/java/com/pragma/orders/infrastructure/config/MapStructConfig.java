package com.pragma.orders.infrastructure.config;

import org.springframework.context.annotation.Configuration;

/**
 * Configuración centralizada para mapeos de entidades.
 * Proporciona beans de configuración para los mapeadores del proyecto.
 * Esta implementación utiliza mapeos manuales a través de la interfaz OrderEntityMapper
 * definida en el dominio, evitando dependencias externas de bibliotecas de mapeo automático.
 */
@Configuration
public class MapStructConfig {

    public MapStructConfig() {
    }
}