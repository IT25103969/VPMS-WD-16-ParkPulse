<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/header.jsp" %>

<div x-data="{ page: 'dashboard' }" class="flex-1 flex flex-col items-center justify-center text-center px-8">
    <div class="w-16 h-16 rounded-2xl flex items-center justify-center mb-4 border transition-colors" :class="$store.app.isDark ? 'bg-white/5 border-white/10' : 'bg-gray-100 border-gray-200'">
        <span class="text-3xl">🚗</span>
    </div>
    <h2 class="text-xl font-medium mb-2" :class="$store.app.isDark ? 'text-white' : 'text-gray-800'">Overview Dashboard</h2>
    <p class="text-sm max-w-xs transition-colors" :class="$store.app.isDark ? 'text-gray-500' : 'text-gray-400'">
        Manage your parking facility with ease.
    </p>
</div>

<script>
    // Update breadcrumbs/header for dashboard
    document.addEventListener('alpine:init', () => {
        const app = Alpine.store('app');
        app.activePage = 'dashboard';
        document.getElementById('page-title').innerText = 'Overview Dashboard';
        document.getElementById('page-subtitle').innerText = 'Manage your parking facility with ease.';
    });
</script>

<%@ include file="/WEB-INF/includes/footer.jsp" %>
