<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ParkPulse - Staff Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        :root {
            --background: #0f1117;
            --sidebar-bg: #161b27;
            --accent-blue: #2563eb;
            --border-color: rgba(255,255,255,0.06);
            --text-muted: #8b95a8;
            --text-main: #ffffff;
            --card-bg: #1a2035;
        }

        body {
            background-color: var(--background);
            color: var(--text-main);
            font-family: 'Inter', 'Segoe UI', sans-serif;
        }

        .sidebar-item-active {
            background: var(--accent-blue);
            color: #fff;
            font-weight: 600;
        }

        .sidebar-item-inactive {
            color: var(--text-muted);
        }

        .sidebar-item-inactive:hover {
            background: rgba(255,255,255,0.07);
            color: #fff;
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 6px;
        }
        ::-webkit-scrollbar-track {
            background: transparent;
        }
        ::-webkit-scrollbar-thumb {
            background: rgba(255,255,255,0.1);
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: rgba(255,255,255,0.2);
        }

        input::placeholder {
            color: #4b5563;
        }
    </style>
</head>
