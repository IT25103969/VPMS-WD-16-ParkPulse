<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="flex-1 flex flex-col items-center justify-center text-center px-8 animate-fade-in">
    <div class="w-24 h-24 rounded-3xl flex items-center justify-center mb-6 bg-gradient-to-br from-green-500/10 to-green-700/10 border border-green-500/20 shadow-xl shadow-green-500/5">
        <i data-lucide="<%= request.getAttribute("placeholderIcon") != null ? request.getAttribute("placeholderIcon") : "construction" %>" class="size-10 text-green-500"></i>
    </div>
    <h2 class="text-2xl font-bold text-foreground mb-2"><%= request.getAttribute("placeholderTitle") %></h2>
    <p class="text-sm text-sidebar-foreground/60 mb-6 max-w-xs">
        This section is under construction and will be available soon.
    </p>
    <div class="px-6 py-2 rounded-full text-sm font-medium text-white bg-gradient-to-br from-green-600 to-green-500 shadow-lg shadow-green-500/30">
        Coming Soon
    </div>
</div>
