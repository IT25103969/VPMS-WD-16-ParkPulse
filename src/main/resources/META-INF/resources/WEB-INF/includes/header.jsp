<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" x-data :class="$store.app.isDark ? 'dark' : ''">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ParkPulse - Member Management</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Alpine.js Plugins -->
    <script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/collapse@3.x.x/dist/cdn.min.js"></script>
    <!-- Alpine.js Core -->
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        border: "var(--border)",
                        input: "var(--input)",
                        ring: "var(--ring)",
                        background: "var(--background)",
                        foreground: "var(--foreground)",
                        primary: {
                            DEFAULT: "var(--primary)",
                            foreground: "var(--primary-foreground)",
                        },
                        secondary: {
                            DEFAULT: "var(--secondary)",
                            foreground: "var(--secondary-foreground)",
                        },
                        destructive: {
                            DEFAULT: "var(--destructive)",
                            foreground: "var(--destructive-foreground)",
                        },
                        muted: {
                            DEFAULT: "var(--muted)",
                            foreground: "var(--muted-foreground)",
                        },
                        accent: {
                            DEFAULT: "var(--accent)",
                            foreground: "var(--accent-foreground)",
                        },
                        <!-- App Logic -->
                        <script src="${pageContext.request.contextPath}/js/app.js"></script>
                        <script>
                            tailwind.config = {
                        // ... existing tailwind config ...
                                            card: {
                                                DEFAULT: "var(--card)",
                                                foreground: "var(--card-foreground)",
                                            },
                                        },
                                    }
                                }
                            }
                        </script>
                        </head>
                        <body class="h-screen overflow-hidden transition-colors duration-300 bg-[#f1f5f9] dark:bg-[#0f1117]">
                        <div class="flex h-full bg-white dark:bg-[#13151f]">
                            <%@ include file="/WEB-INF/includes/sidebar.jsp" %>

                            <main class="flex-1 flex flex-col min-w-0 overflow-hidden">
                                <!-- Content Header -->
                                <div class="flex items-center justify-between px-8 py-6 border-b transition-colors" :class="[$store.app.isDark ? 'bg-[#0f1117] border-white/10' : 'bg-white border-gray-200']">
                                    <div>
                                        <h1 class="text-xl font-semibold" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'" id="page-title">Member Management</h1>
                                        <p class="text-sm mt-0.5" :class="$store.app.isDark ? 'text-gray-400' : 'text-gray-500'" id="page-subtitle">Manage parking members, subscriptions and access.</p>
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <div class="flex items-center gap-2 rounded-full px-3 py-1.5 border transition-colors" :class="$store.app.isDark ? 'bg-gray-800 border-white/10' : 'bg-gray-100 border-gray-200'">
                                            <div class="w-7 h-7 rounded-full bg-blue-600 flex items-center justify-center text-white text-xs">AD</div>
                                            <span class="text-sm" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'">Admin</span>
                                        </div>
                                        <template x-if="$store.app.activePage === 'members'">
                                            <button @click="window.dispatchEvent(new CustomEvent('open-add-modal'))" class="flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white rounded-full px-4 py-2 text-sm transition-colors">
                                                <i data-lucide="plus" class="size-4"></i>
                                                New Member
                                            </button>
                                        </template>
                                    </div>
                                </div>
            <div class="flex-1 flex flex-col min-h-0 overflow-auto bg-[#f1f5f9] dark:bg-[#0f1117]">
