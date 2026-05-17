package com.parkpulse.service;

import com.parkpulse.model.Ticket;
import java.util.List;
import java.util.Optional;

/**
 * Abstraction for Ticket business logic.
 */
public interface TicketService {
    List<Ticket> getAllTickets(
            String status,
            String vehicleType,
            String paymentMethod,
            String slot,
            String dateFrom,
            String dateTo,
            Double amountMin,
            Double amountMax);

    Optional<Ticket> getTicketById(String id);
    Ticket createTicket(Ticket ticket);
    Ticket updateTicket(String id, Ticket ticket);
    void deleteTicket(String id);
    Ticket checkout(String id, String paymentMethod);
}
