package com.shanzhu.pet.config;

import javax.annotation.PostConstruct;
import java.nio.file.*;
import java.io.IOException;
import org.springframework.stereotype.Component;

@Component
public class DatabaseInitializer {

    @PostConstruct
    public void init() {
        try {
            Path sourcePath = Paths.get("src/main/resources/db_pet.sqlite");
            Path targetPath = Paths.get("/tmp/db_pet.sqlite");

            Files.copy(sourcePath, targetPath, StandardCopyOption.REPLACE_EXISTING);
            System.out.println("Database file copied to /tmp/db_pet.sqlite");
        } catch (IOException e) {
            System.err.println("Failed to copy database file to /tmp: " + e.getMessage());
        }
    }
}
