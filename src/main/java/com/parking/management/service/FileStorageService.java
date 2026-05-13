package com.parking.management.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class FileStorageService {

    @Value("${storage.base-path}")
    private String basePath;

    public <T> List<T> readAll(String fileName, Function<String, T> mapper) {
        Path path = Paths.get(basePath, fileName);
        if (!Files.exists(path)) {
            return new ArrayList<>();
        }

        try (BufferedReader reader = Files.newBufferedReader(path)) {
            return reader.lines()
                    .map(mapper)
                    .collect(Collectors.toList());
        } catch (IOException e) {
            throw new RuntimeException("Could not read file: " + fileName, e);
        }
    }

    public void writeAll(String fileName, List<String> lines) {
        Path path = Paths.get(basePath, fileName);
        try {
            Files.createDirectories(path.getParent());
            try (BufferedWriter writer = Files.newBufferedWriter(path)) {
                for (String line : lines) {
                    writer.write(line);
                    writer.newLine();
                }
            }
        } catch (IOException e) {
            throw new RuntimeException("Could not write to file: " + fileName, e);
        }
    }

    public void append(String fileName, String line) {
        Path path = Paths.get(basePath, fileName);
        try {
            Files.createDirectories(path.getParent());
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(path.toFile(), true))) {
                writer.write(line);
                writer.newLine();
            }
        } catch (IOException e) {
            throw new RuntimeException("Could not append to file: " + fileName, e);
        }
    }
}
