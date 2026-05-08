package com.parking.service;

import com.parking.model.ParkingSlot;
import com.parking.model.Zone;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DataService {

    private final String DATA_DIR = "backend/data";
    private final String ZONES_FILE = DATA_DIR + "/zones.txt";
    private final String SLOTS_FILE = DATA_DIR + "/slots.txt";

    @PostConstruct
    public void init() {
        File dir = new File(DATA_DIR);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        initializeDefaultData();
    }

    private void initializeDefaultData() {
        File zonesFile = new File(ZONES_FILE);
        if (!zonesFile.exists() || zonesFile.length() == 0) {
            List<Zone> defaultZones = new ArrayList<>();
            defaultZones.add(new Zone("A", "Section A"));
            defaultZones.add(new Zone("B", "Section B"));
            defaultZones.add(new Zone("C", "Section C"));
            defaultZones.add(new Zone("D", "Section D"));
            saveZones(defaultZones);

            List<ParkingSlot> defaultSlots = new ArrayList<>();
            for (Zone zone : defaultZones) {
                for (int i = 1; i <= 30; i++) {
                    defaultSlots.add(new ParkingSlot(zone.getId() + "-" + i, zone.getId() + i, zone.getId(), "available", "", null));
                }
            }
            saveSlots(defaultSlots);
        }
    }

    public List<Zone> readZones() {
        List<Zone> zones = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(ZONES_FILE, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length >= 2) {
                    zones.add(new Zone(parts[0], parts[1]));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return zones;
    }

    public void saveZones(List<Zone> zones) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ZONES_FILE, StandardCharsets.UTF_8))) {
            for (Zone zone : zones) {
                writer.write(zone.getId() + "|" + zone.getName());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<ParkingSlot> readSlots() {
        List<ParkingSlot> slots = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(SLOTS_FILE, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|", -1);
                if (parts.length >= 6) {
                    ParkingSlot slot = new ParkingSlot();
                    slot.setId(parts[0]);
                    slot.setNumber(parts[1]);
                    slot.setZoneId(parts[2]);
                    slot.setStatus(parts[3]);
                    slot.setReservedBy(parts[4]);
                    
                    if (!parts[5].isEmpty()) {
                        String[] vParts = parts[5].split(";", -1);
                        if (vParts.length >= 7) {
                            ParkingSlot.Vehicle vehicle = new ParkingSlot.Vehicle();
                            vehicle.setLicensePlate(vParts[0]);
                            vehicle.setType(vParts[1]);
                            vehicle.setOwner(vParts[2]);
                            vehicle.setPhone(vParts[3]);
                            vehicle.setEmail(vParts[4]);
                            vehicle.setEntryTime(vParts[5]);
                            vehicle.setDuration(vParts[6]);
                            slot.setVehicle(vehicle);
                        }
                    }
                    slots.add(slot);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return slots;
    }

    public void saveSlots(List<ParkingSlot> slots) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(SLOTS_FILE, StandardCharsets.UTF_8))) {
            for (ParkingSlot slot : slots) {
                StringBuilder sb = new StringBuilder();
                sb.append(slot.getId()).append("|")
                  .append(slot.getNumber()).append("|")
                  .append(slot.getZoneId()).append("|")
                  .append(slot.getStatus()).append("|")
                  .append(slot.getReservedBy()).append("|");
                
                if (slot.getVehicle() != null) {
                    ParkingSlot.Vehicle v = slot.getVehicle();
                    sb.append(v.getLicensePlate()).append(";")
                      .append(v.getType()).append(";")
                      .append(v.getOwner()).append(";")
                      .append(v.getPhone()).append(";")
                      .append(v.getEmail()).append(";")
                      .append(v.getEntryTime()).append(";")
                      .append(v.getDuration());
                }
                writer.write(sb.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void updateSlot(ParkingSlot updatedSlot) {
        List<ParkingSlot> slots = readSlots();
        for (int i = 0; i < slots.size(); i++) {
            if (slots.get(i).getId().equals(updatedSlot.getId())) {
                slots.set(i, updatedSlot);
                break;
            }
        }
        saveSlots(slots);
    }
}
