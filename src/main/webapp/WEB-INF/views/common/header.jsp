<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" x-data="themeData()" :class="{ 'dark': isDark }">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ParkPulse - Parking Slot Management</title>
    
    <!-- Tailwind CSS v4 CDN -->
    <script src="https://unpkg.com/@tailwindcss/browser@4"></script>
    
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
    
    <!-- Alpine.js -->
    <script defer src="https://unpkg.com/@alpinejs/persist@3.x.x/dist/cdn.min.js"></script>
    <script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    
    <style type="text/tailwindcss">
        @theme {
            --color-background: var(--background);
            --color-foreground: var(--foreground);
            --color-card: var(--card);
            --color-card-foreground: var(--card-foreground);
            --color-popover: var(--popover);
            --color-popover-foreground: var(--popover-foreground);
            --color-primary: var(--primary);
            --color-primary-foreground: var(--primary-foreground);
            --color-secondary: var(--secondary);
            --color-secondary-foreground: var(--secondary-foreground);
            --color-muted: var(--muted);
            --color-muted-foreground: var(--muted-foreground);
            --color-accent: var(--accent);
            --color-accent-foreground: var(--accent-foreground);
            --color-destructive: var(--destructive);
            --color-destructive-foreground: var(--destructive-foreground);
            --color-border: var(--border);
            --color-input: var(--input);
            --color-input-background: var(--input-background);
            --color-switch-background: var(--switch-background);
            --color-ring: var(--ring);
            --color-sidebar: var(--sidebar);
            --color-sidebar-foreground: var(--sidebar-foreground);
            --color-sidebar-primary: var(--sidebar-primary);
            --color-sidebar-primary-foreground: var(--sidebar-primary-foreground);
            --color-sidebar-accent: var(--sidebar-accent);
            --color-sidebar-accent-foreground: var(--sidebar-accent-foreground);
            --color-sidebar-border: var(--sidebar-border);
            --color-sidebar-ring: var(--sidebar-ring);
        }
        
        @layer base {
            * {
                @apply border-border outline-ring/50;
            }
            body {
                @apply bg-background text-foreground;
            }
        }
    </style>
</head>
<body class="h-screen overflow-hidden">
    <div class="h-full flex" x-data="sidebarData()">
    <script>
        window.backendData = {
            zones: ${zonesJson != null ? zonesJson : '[]'},
            slots: ${slotsJson != null ? slotsJson : '[]'},
            stats: ${statsJson != null ? statsJson : '{}'},
            vehicle: ${vehicleJson != null ? vehicleJson : 'null'},
            slotNumber: '${slotNumber != null ? slotNumber : ""}'
        };
    </script>
