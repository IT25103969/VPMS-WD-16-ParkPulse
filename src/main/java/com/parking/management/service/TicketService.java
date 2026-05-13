package com.parking.management.service;

import com.parking.management.model.Ticket;
import com.parking.management.repository.TicketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class TicketService {

    @Autowired
    private TicketRepository ticketRepository;

    private static final double HOURLY_RATE = 10.0;

    public Ticket checkIn(String licensePlate) {
        Ticket ticket = new Ticket(licensePlate);
        return ticketRepository.save(ticket);
    }

    public Ticket checkOut(Long id) {
        Optional<Ticket> optionalTicket = ticketRepository.findById(id);
        if (optionalTicket.isPresent()) {
            Ticket ticket = optionalTicket.get();
            if ("ACTIVE".equals(ticket.getStatus())) {
                ticket.setExitTime(LocalDateTime.now());
                ticket.setStatus("CHECKED_OUT");
                
                long hours = Duration.between(ticket.getEntryTime(), ticket.getExitTime()).toHours();
                if (hours == 0) hours = 1; // Minimum 1 hour charge
                ticket.setAmount(hours * HOURLY_RATE);
                
                return ticketRepository.save(ticket);
            }
        }
        return null;
    }

    public List<Ticket> getActiveTickets() {
        return ticketRepository.findByStatus("ACTIVE");
    }

    public List<Ticket> getCheckedOutTickets() {
        return ticketRepository.findByStatus("CHECKED_OUT");
    }

    public Ticket updateTicket(Long id, String licensePlate, Double amount) {
        Optional<Ticket> optionalTicket = ticketRepository.findById(id);
        if (optionalTicket.isPresent()) {
            Ticket ticket = optionalTicket.get();
            ticket.setLicensePlate(licensePlate);
            ticket.setAmount(amount);
            return ticketRepository.save(ticket);
        }
        return null;
    }
}
