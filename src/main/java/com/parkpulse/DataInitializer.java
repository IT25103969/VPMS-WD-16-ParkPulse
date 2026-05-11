package com.parkpulse;

import com.parkpulse.model.Staff;
import com.parkpulse.repository.StaffRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;

@Configuration
public class DataInitializer {

    @Bean
    CommandLineRunner initDatabase(StaffRepository repository) {
        return args -> {
            repository.saveAll(Arrays.asList(
                new Staff(null, "Marcus Johnson", "Manager", "Morning (6AM-2PM)", "Active", "", "+1 555 012 3456", "marcus@parkpulse.com", "2023-01-15", "45 Oak Avenue, Austin, TX 78701", "TX-MJ-4521", "Sedan"),
                new Staff(null, "Aisha Patel", "Attendant", "Afternoon (2PM-10PM)", "Active", "", "+1 555 234 5678", "aisha@parkpulse.com", "2023-03-20", "12 Elm Street, Austin, TX 78702", "TX-AP-7834", "Hatchback"),
                new Staff(null, "Daniel Torres", "Security", "Night (10PM-6AM)", "Active", "", "+1 555 345 6789", "daniel@parkpulse.com", "2023-06-01", "88 Pine Road, Austin, TX 78703", "TX-DT-1192", "SUV"),
                new Staff(null, "Sophia Lee", "Cashier", "Morning (6AM-2PM)", "Off Duty", "", "+1 555 456 7890", "sophia@parkpulse.com", "2024-01-10", "33 Birch Lane, Austin, TX 78704", "TX-SL-6630", "Sedan"),
                new Staff(null, "Kevin Brooks", "Supervisor", "Afternoon (2PM-10PM)", "Active", "", "+1 555 567 8901", "kevin@parkpulse.com", "2022-11-08", "71 Cedar Blvd, Austin, TX 78705", "TX-KB-3309", "Truck")
            ));
        };
    }
}
