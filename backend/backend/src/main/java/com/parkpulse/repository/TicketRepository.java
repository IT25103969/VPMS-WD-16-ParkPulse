package com.parkpulse.repository;

import com.parkpulse.model.Ticket;
import java.util.List;
import java.util.Optional;

/**
 * Abstraction for Ticket data access.
 * Demonstrates the principle of Abstraction in OOP.
 */
public interface TicketRepository {
    List<Ticket> findAll();
    Ticket save(Ticket ticket);
    void deleteById(String id);
    Optional<Ticket> findById(String id);
}
