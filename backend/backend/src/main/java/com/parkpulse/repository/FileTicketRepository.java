package com.parkpulse.repository;

import com.parkpulse.model.Ticket;
import org.springframework.stereotype.Repository;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Repository
public class FileTicketRepository implements TicketRepository {
    private static final String TICKETS_FILE = "data/tickets.txt";
    private static final String SLOT_FILE = "data/slot.txt";

    @Override
    public List<Ticket> findAll() {
        List<Ticket> tickets = new ArrayList<>();
        tickets.addAll(readFromFile(TICKETS_FILE));
        tickets.addAll(readFromFile(SLOT_FILE));
        return tickets;
    }

    private List<Ticket> readFromFile(String filePath) {
        List<Ticket> tickets = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) {
            return tickets;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                Ticket ticket = Ticket.fromCsv(line);
                if (ticket != null) {
                    tickets.add(ticket);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return tickets;
    }

    public void saveAll(List<Ticket> tickets) {
        List<Ticket> finished = tickets.stream()
                .filter(t -> "finished".equalsIgnoreCase(t.getStatus()))
                .toList();
        List<Ticket> ongoing = tickets.stream()
                .filter(t -> !"finished".equalsIgnoreCase(t.getStatus()))
                .toList();

        writeToFile(TICKETS_FILE, finished);
        writeToFile(SLOT_FILE, ongoing);
    }

    private void writeToFile(String filePath, List<Ticket> tickets) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Ticket ticket : tickets) {
                writer.write(ticket.toCsv());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Ticket save(Ticket ticket) {
        List<Ticket> tickets = findAll();
        Optional<Ticket> existing = tickets.stream()
                .filter(t -> t.getId().equals(ticket.getId()))
                .findFirst();

        if (existing.isPresent()) {
            int index = tickets.indexOf(existing.get());
            tickets.set(index, ticket);
        } else {
            tickets.add(ticket);
        }
        saveAll(tickets);
        return ticket;
    }

    @Override
    public void deleteById(String id) {
        List<Ticket> tickets = findAll();
        tickets.removeIf(t -> t.getId().equals(id));
        saveAll(tickets);
    }

    @Override
    public Optional<Ticket> findById(String id) {
        return findAll().stream()
                .filter(t -> t.getId().equals(id))
                .findFirst();
    }
}
