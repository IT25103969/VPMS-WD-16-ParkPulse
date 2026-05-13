package com.parking.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.parking.model.ParkingSlot;
import com.parking.model.Vehicle;
import com.parking.model.Zone;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class ParkingService {
    private final FileStorageService storage;
    private final ObjectMapper mapper = new ObjectMapper();
    
    private List<Zone> zones = new ArrayList<>();
    private List<ParkingSlot> slots = new ArrayList<>();

    public ParkingService(FileStorageService storage) {
        this.storage = storage;
    }

    @PostConstruct
    public void init() throws IOException {
        loadData();
        if (zones.isEmpty() || slots.isEmpty()) {
            if (zones.isEmpty()) initializeDefaults();
            saveData();
        }
    }

    private void loadData() throws IOException {
        String zonesTxt = storage.readFile("zones.txt");
        if (zonesTxt != null) {
            zones = new ArrayList<>(mapper.readValue(zonesTxt, new TypeReference<List<Zone>>() {}));
        }
        
        String slotsTxt = storage.readFile("slots.txt");
        if (slotsTxt != null) {
            slots = new ArrayList<>(mapper.readValue(slotsTxt, new TypeReference<List<ParkingSlot>>() {}));
        }
    }

    private void saveData() throws IOException {
        storage.writeFile("zones.txt", mapper.writeValueAsString(zones));
        storage.writeFile("slots.txt", mapper.writeValueAsString(slots));
    }

    private void initializeDefaults() {
        zones.add(new Zone("A", "Section A", 2.50, new ArrayList<>(Arrays.asList("Sedan", "SUV", "Hatchback", "Van"))));
        zones.add(new Zone("B", "Section B", 3.00, new ArrayList<>(Arrays.asList("Sedan", "SUV", "Hatchback", "Truck", "Van"))));
        zones.add(new Zone("C", "Section C", 1.50, new ArrayList<>(Arrays.asList("Motorcycle", "Motorbike"))));
        zones.add(new Zone("D", "Section D", 4.00, new ArrayList<>()));

        String[] vehicleTypes = {"Sedan", "SUV", "Hatchback", "Truck", "Motorcycle", "Motorbike", "Van"};
        String[] owners = {"John Doe", "Jane Smith", "Mike Johnson", "Sarah Williams"};
        Random rand = new Random();

        for (Zone zone : zones) {
            for (int i = 1; i <= 30; i++) {
                ParkingSlot slot = new ParkingSlot();
                slot.setId(zone.getId() + "-" + i);
                slot.setNumber(zone.getId() + i);
                slot.setZoneId(zone.getId());
                
                boolean isOccupied = rand.nextDouble() > 0.8;
                if (isOccupied) {
                    slot.setStatus("occupied");
                    Vehicle v = new Vehicle();
                    v.setLicensePlate("ABC-" + (1000 + rand.nextInt(9000)));
                    v.setType(vehicleTypes[rand.nextInt(vehicleTypes.length)]);
                    v.setOwner(owners[rand.nextInt(owners.length)]);
                    v.setPhone("+1 234-567-" + (1000 + rand.nextInt(9000)));
                    v.setEmail("user" + i + "@example.com");
                    v.setEntryTime((8 + rand.nextInt(5)) + ":" + (new String[]{"00", "15", "30", "45"})[rand.nextInt(4)] + " AM");
                    v.setDuration((1 + rand.nextInt(4)) + "h " + rand.nextInt(60) + "m");
                    slot.setVehicle(v);
                } else {
                    slot.setStatus("available");
                }
                slots.add(slot);
            }
        }
    }

    public List<Zone> getZones() { return zones; }
    public List<ParkingSlot> getSlots() { return slots; }

    public synchronized void handleAction(String action, Map<String, String[]> params) throws IOException {
        if ("enter_vehicle".equals(action)) {
            String slotId = getParam(params, "slotId");
            Vehicle v = new Vehicle();
            v.setLicensePlate(getParam(params, "licensePlate"));
            v.setType(getParam(params, "type"));
            v.setOwner(getParam(params, "owner"));
            v.setPhone(getParam(params, "phone"));
            v.setEmail(getParam(params, "email"));
            v.setEntryTime(new SimpleDateFormat("hh:mm a").format(new Date()));
            v.setDuration("0h 0m");
            
            slots.stream().filter(s -> s.getId().equals(slotId)).forEach(s -> {
                s.setStatus("occupied");
                s.setVehicle(v);
            });
        } else if ("release_vehicle".equals(action)) {
            String slotId = getParam(params, "slotId");
            slots.stream().filter(s -> s.getId().equals(slotId)).forEach(s -> {
                s.setStatus("available");
                s.setVehicle(null);
            });
        } else if ("reserve_slot".equals(action)) {
            String slotId = getParam(params, "slotId");
            String type = getParam(params, "reserveType");
            slots.stream().filter(s -> s.getId().equals(slotId)).forEach(s -> {
                s.setStatus("reserved");
                s.setReservedBy(type);
            });
        } else if ("maintenance_slot".equals(action)) {
            String slotId = getParam(params, "slotId");
            slots.stream().filter(s -> s.getId().equals(slotId)).forEach(s -> s.setStatus("maintenance"));
        } else if ("clear_slot".equals(action)) {
            String slotId = getParam(params, "slotId");
            slots.stream().filter(s -> s.getId().equals(slotId)).forEach(s -> {
                s.setStatus("available");
                s.setReservedBy(null);
                s.setVehicle(null);
            });
        } else if ("create_zone".equals(action)) {
            String name = getParam(params, "name");
            int slotCount = 12;
            try { slotCount = Integer.parseInt(getParam(params, "slotCount")); } catch(Exception e) {}
            String priceStr = getParam(params, "price");
            String[] vTypes = params.get("vTypes");
            
            String id = name.trim().toUpperCase().replaceAll("\\s+", "_") + "-" + Long.toString(System.currentTimeMillis(), 36);
            Zone z = new Zone();
            z.setId(id);
            z.setName(name);
            if (priceStr != null && !priceStr.isEmpty()) z.setPricePerHour(Double.parseDouble(priceStr));
            z.setAllowedVehicleTypes(vTypes != null ? new ArrayList<>(Arrays.asList(vTypes)) : new ArrayList<>());
            
            zones.add(z);
            for (int i = 1; i <= slotCount; i++) {
                ParkingSlot s = new ParkingSlot();
                s.setId(id + "-" + i);
                s.setNumber(id + i);
                s.setZoneId(id);
                s.setStatus("available");
                slots.add(s);
            }
        } else if ("update_zone".equals(action)) {
            String id = getParam(params, "zoneId");
            String name = getParam(params, "name");
            String priceStr = getParam(params, "price");
            String[] vTypes = params.get("vTypes");
            
            zones.stream().filter(z -> z.getId().equals(id)).forEach(z -> {
                z.setName(name);
                if (priceStr != null && !priceStr.isEmpty()) z.setPricePerHour(Double.parseDouble(priceStr));
                z.setAllowedVehicleTypes(vTypes != null ? new ArrayList<>(Arrays.asList(vTypes)) : new ArrayList<>());
            });
        } else if ("delete_zone".equals(action)) {
            String id = getParam(params, "zoneId");
            zones.removeIf(z -> z.getId().equals(id));
            slots.removeIf(s -> s.getZoneId().equals(id));
        } else if ("add_slot".equals(action)) {
            String zoneId = getParam(params, "zoneId");
            long next = slots.stream().filter(s -> s.getZoneId().equals(zoneId)).count() + 1;
            ParkingSlot s = new ParkingSlot();
            s.setId(zoneId + "-" + System.currentTimeMillis());
            s.setNumber(zoneId + next);
            s.setZoneId(zoneId);
            s.setStatus("available");
            slots.add(s);
        } else if ("delete_slot".equals(action)) {
            String slotId = getParam(params, "slotId");
            slots.removeIf(s -> s.getId().equals(slotId));
        }
        saveData();
    }

    private String getParam(Map<String, String[]> params, String key) {
        String[] values = params.get(key);
        return (values != null && values.length > 0) ? values[0] : null;
    }
}
