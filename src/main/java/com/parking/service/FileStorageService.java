package com.parking.service;

import org.springframework.stereotype.Service;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

@Service
public class FileStorageService {
    private final String dataDir = "data";

    public FileStorageService() {
        File dir = new File(dataDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }

    public synchronized String readFile(String filename) throws IOException {
        File file = new File(dataDir, filename);
        if (!file.exists()) return null;

        StringBuilder content = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line).append(System.lineSeparator());
            }
        }
        return content.toString().trim();
    }

    public synchronized void writeFile(String filename, String content) throws IOException {
        File file = new File(dataDir, filename);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            writer.write(content);
        }
    }

    public synchronized void deleteFile(String filename) {
        File file = new File(dataDir, filename);
        if (file.exists()) {
            file.delete();
        }
    }

    // Legacy support for any CSV-based logic
    public synchronized List<String> readAllLines(String filename) throws IOException {
        File file = new File(dataDir, filename);
        if (!file.exists()) return new ArrayList<>();

        List<String> lines = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                lines.add(line);
            }
        }
        return lines;
    }
}
