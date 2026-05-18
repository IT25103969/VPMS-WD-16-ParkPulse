package com.staffmanagement.repository;

import com.staffmanagement.model.Staff;
import org.springframework.stereotype.Repository;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.*;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;

/**
 * Polymorphism & Abstraction: Implementation of the BaseRepository interface for File-based storage.
 */
@Repository
public class FileStaffRepository implements BaseRepository<Staff, Long> {
    private final String FILE_PATH = "data/staff_data.txt";
    private final AtomicLong idGenerator = new AtomicLong(0);

    public FileStaffRepository() {
        initFile();
        updateIdGenerator();
    }

    private void initFile() {
        Path path = Paths.get(FILE_PATH);
        try {
            // Ensure the 'data' directory exists
            if (path.getParent() != null && !Files.exists(path.getParent())) {
                Files.createDirectories(path.getParent());
            }
            // Create the file if it doesn't exist
            if (!Files.exists(path)) {
                Files.createFile(path);
            }
        } catch (IOException e) {
            throw new RuntimeException("Could not initialize data storage", e);
        }
    }

    private void updateIdGenerator() {
        List<Staff> all = findAll();
        long maxId = all.stream().mapToLong(Staff::getId).max().orElse(0L);
        idGenerator.set(maxId);
    }

    @Override
    public List<Staff> findAll() {
        try {
            return Files.lines(Paths.get(FILE_PATH), StandardCharsets.UTF_8)
                    .filter(line -> !line.trim().isEmpty())
                    .map(Staff::fromCsvRow)
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());
        } catch (IOException e) {
            return new ArrayList<>();
        }
    }

    @Override
    public Optional<Staff> findById(Long id) {
        return findAll().stream().filter(s -> s.getId().equals(id)).findFirst();
    }

    @Override
    public Staff save(Staff staff) {
        List<Staff> all = findAll();
        if (staff.getId() == null) {
            staff.setId(idGenerator.incrementAndGet());
            all.add(staff);
        } else {
            int index = -1;
            for (int i = 0; i < all.size(); i++) {
                if (all.get(i).getId().equals(staff.getId())) {
                    index = i;
                    break;
                }
            }
            if (index != -1) {
                all.set(index, staff);
            } else {
                all.add(staff);
            }
        }
        writeAll(all);
        return staff;
    }

    @Override
    public void deleteById(Long id) {
        List<Staff> all = findAll().stream()
                .filter(s -> !s.getId().equals(id))
                .collect(Collectors.toList());
        writeAll(all);
    }

    private void writeAll(List<Staff> list) {
        try (BufferedWriter writer = Files.newBufferedWriter(Paths.get(FILE_PATH), StandardCharsets.UTF_8)) {
            for (Staff s : list) {
                writer.write(s.toCsvRow());
                writer.newLine();
            }
        } catch (IOException e) {
            throw new RuntimeException("Could not write to data file", e);
        }
    }
}
