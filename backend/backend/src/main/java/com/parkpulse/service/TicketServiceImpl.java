package com.parkpulse.service;

import com.parkpulse.model.Ticket;
import com.parkpulse.repository.TicketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * Concrete implementation of TicketService.
 * Handles business logic and filtering.
 */
@Service
public class TicketServiceImpl implements TicketService {

    @Autowired
    private TicketRepository repository;

    @Override
    public List<Ticket> getAllTickets(
            String status,
            String vehicleType,
            String paymentMethod,
            String slot,
            String dateFrom,
            String dateTo,
            Double amountMin,
            Double amountMax) {

        List<Ticket> tickets = repository.findAll();

        return tickets.stream().filter(t -> {
            if (status != null && !status.equalsIgnoreCase(t.getStatus())) return false;
            if (vehicleType != null && !vehicleType.equalsIgnoreCase(t.getVehicleType())) return false;
            if (paymentMethod != null && !paymentMethod.equalsIgnoreCase(t.getPaymentMethod())) return false;
            if (slot != null && !t.getSlot().toLowerCase().contains(slot.toLowerCase())) return false;

            // Simple string-based date comparison (YYYY-MM-DD...)
            if (dateFrom != null && t.getEntryTime().compareTo(dateFrom) < 0) return false;
            if (dateTo != null && t.getEntryTime().compareTo(dateTo) > 0) return false;

            if (amountMin != null && (t.getAmount() == null || t.getAmount() < amountMin)) return false;
            if (amountMax != null && (t.getAmount() == null || t.getAmount() > amountMax)) return false;

            return true;
        }).toList();
    }

    @Override
    public Optional<Ticket> getTicketById(String id) {
        return repository.findById(id);
    }

    @Override
    public Ticket createTicket(Ticket ticket) {
        return repository.save(ticket);
    }

    @Override
    public Ticket updateTicket(String id, Ticket ticket) {
        if (!repository.findById(id).isPresent()) {
            return null;
        }
        ticket.setId(id);
        return repository.save(ticket);
    }

    @Override
    public void deleteTicket(String id) {
        repository.deleteById(id);
    }

    @Override
    public Ticket checkout(String id, String paymentMethod) {
        Optional<Ticket> ticketOpt = repository.findById(id);
        if (ticketOpt.isPresent()) {
            Ticket ticket = ticketOpt.get();
            String now = java.time.LocalDateTime.now().toString();
            ticket.completePayment(now, paymentMethod);
            return repository.save(ticket);
        }
        return null;
    }
}
