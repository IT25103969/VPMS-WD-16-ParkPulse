<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ParkPulse - Member Management</title>
    
    <!-- Tailwind Play CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        background: 'var(--background)',
                        foreground: 'var(--foreground)',
                        card: 'var(--card)',
                        border: 'var(--border)',
                        sidebar: 'var(--sidebar)',
                        'sidebar-foreground': 'var(--sidebar-foreground)',
                        'sidebar-border': 'var(--sidebar-border)',
                    }
                }
            }
        }
    </script>

    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
    
    <!-- Custom Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Custom Styles -->
    <link rel="stylesheet" href="/css/styles.css">
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        body {
            font-family: 'Inter', sans-serif;
            transition: background-color 0.5s ease;
        }
    </style>
</head>
<body class="dark bg-mesh-dark min-h-screen flex text-foreground overflow-hidden">
    <script>
        // Apply theme immediately to avoid flash
        const savedTheme = localStorage.getItem('theme') || 'dark';
        if (savedTheme === 'light') {
            document.body.classList.remove('dark');
            document.body.classList.add('bg-mesh-light');
            document.body.classList.remove('bg-mesh-dark');
        } else {
            document.body.classList.add('dark');
            document.body.classList.add('bg-mesh-dark');
            document.body.classList.remove('bg-mesh-light');
        }
    </script>
