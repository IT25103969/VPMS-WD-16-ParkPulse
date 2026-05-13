<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>
<div class="flex h-screen overflow-hidden">
    <%@ include file="sidebar.jsp" %>
    
    <main class="flex-1 overflow-y-auto">
        <div class="p-8">
            <div class="flex items-center justify-between mb-6 gap-4 flex-wrap">
                <div>
                    <h1 class="text-primary text-2xl font-semibold">Parked Vehicles</h1>
                    <p class="text-sm text-muted">All vehicles currently occupying or reserving a slot.</p>
                </div>
                <div class="relative">
                    <i data-lucide="search" class="absolute left-3 top-1/2 -translate-y-1/2 size-4 pointer-events-none text-muted"></i>
                    <input type="text" placeholder="Plate, owner, type, zone…" class="pl-9 py-2 rounded-full border border-border bg-background text-sm w-56 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all dark:bg-[#0b1220] dark:border-[#1f2a44]">
                </div>
            </div>

            <c:set var="occCount" value="${0}" />
            <c:set var="resCount" value="${0}" />
            <c:forEach var="s" items="${slots}">
                <c:if test="${s.status eq 'occupied'}"><c:set var="occCount" value="${occCount + 1}" /></c:if>
                <c:if test="${s.status eq 'reserved'}"><c:set var="resCount" value="${resCount + 1}" /></c:if>
            </c:forEach>

            <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-6">
                <button class="rounded-2xl border border-blue-200 bg-blue-50 dark:bg-blue-500/10 dark:border-blue-500/20 p-4 text-left transition-all ring-2 ring-blue-500 ring-offset-1 dark:ring-offset-[#0b1220]">
                    <div class="text-xs text-muted mb-1">Total Parked</div>
                    <div class="text-2xl font-semibold text-blue-500">${occCount + resCount}</div>
                </button>
                <button class="rounded-2xl border border-red-200 bg-red-50 dark:bg-red-500/10 dark:border-red-500/20 p-4 text-left transition-all hover:opacity-80">
                    <div class="text-xs text-muted mb-1">Occupied</div>
                    <div class="text-2xl font-semibold text-red-500">${occCount}</div>
                </button>
                <button class="rounded-2xl border border-amber-200 bg-amber-50 dark:bg-amber-500/10 dark:border-amber-500/20 p-4 text-left transition-all hover:opacity-80">
                    <div class="text-xs text-muted mb-1">Reserved</div>
                    <div class="text-2xl font-semibold text-amber-400">${resCount}</div>
                </button>
            </div>

            <div class="rounded-2xl border border-border card-bg overflow-hidden">
                <div class="flex items-center gap-3 px-5 py-3 border-b border-gray-100 dark:border-[#1f2a44] flex-wrap">
                    <i data-lucide="filter" class="size-4 text-muted"></i>
                    <button class="px-3 py-1 rounded-lg text-xs capitalize transition-colors bg-blue-600 text-white">all (${occCount + resCount})</button>
                    <button class="px-3 py-1 rounded-lg text-xs capitalize transition-colors bg-gray-100 dark:bg-[#1a2540] text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-[#243154]">occupied (${occCount})</button>
                    <button class="px-3 py-1 rounded-lg text-xs capitalize transition-colors bg-gray-100 dark:bg-[#1a2540] text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-[#243154]">reserved (${resCount})</button>
                </div>

                <div class="divide-y divide-gray-100 dark:divide-[#1f2a44]/40">
                    <c:forEach var="slot" items="${slots}">
                        <c:if test="${slot.status eq 'occupied' or slot.status eq 'reserved'}">
                            <button onclick="handleVehicleClick('${slot.id}')" class="w-full flex items-center gap-4 px-5 py-4 text-left transition-colors hover:bg-blue-50/40 dark:hover:bg-blue-500/5">
                                <div class="size-11 shrink-0 rounded-xl flex items-center justify-center text-xs font-bold text-white shadow-md ${slot.status eq 'occupied' ? 'bg-gradient-to-b from-red-500 to-red-600' : 'bg-gradient-to-b from-amber-400 to-amber-500'}">
                                    ${slot.number}
                                </div>
                                <div class="flex-1 min-w-0">
                                    <div class="text-sm font-semibold text-primary tracking-wide">${slot.status eq 'occupied' ? slot.vehicle.licensePlate : 'RESERVED'}</div>
                                    <div class="text-xs text-muted flex items-center gap-3 mt-0.5 flex-wrap">
                                        <c:if test="${slot.status eq 'occupied'}">
                                            <span class="flex items-center gap-1"><i data-lucide="user" class="size-3"></i> ${slot.vehicle.owner}</span>
                                            <span class="flex items-center gap-1"><i data-lucide="car" class="size-3"></i> ${slot.vehicle.type}</span>
                                        </c:if>
                                        <c:if test="${slot.status eq 'reserved'}">
                                            <span class="flex items-center gap-1"><i data-lucide="bookmark" class="size-3"></i> ${slot.reservedBy}</span>
                                        </c:if>
                                    </div>
                                </div>
                                <c:if test="${slot.status eq 'occupied'}">
                                    <div class="hidden md:flex flex-col gap-1 text-xs text-muted min-w-[140px]">
                                        <span class="flex items-center gap-1.5"><i data-lucide="phone-call" class="size-3 shrink-0"></i> ${slot.vehicle.phone}</span>
                                        <span class="flex items-center gap-1.5 truncate max-w-[160px]"><i data-lucide="at-sign" class="size-3 shrink-0"></i> ${slot.vehicle.email}</span>
                                    </div>
                                    <div class="hidden lg:flex flex-col gap-1 text-xs text-muted min-w-[90px]">
                                        <span class="flex items-center gap-1.5"><i data-lucide="clock" class="size-3 shrink-0"></i> ${slot.vehicle.entryTime}</span>
                                        <span class="flex items-center gap-1.5"><i data-lucide="timer" class="size-3 shrink-0"></i> ${slot.vehicle.duration}</span>
                                    </div>
                                </c:if>
                                <div class="flex flex-col items-end gap-1.5 shrink-0">
                                    <c:forEach var="z" items="${zones}">
                                        <c:if test="${z.id eq slot.zoneId}">
                                            <span class="text-xs px-2 py-0.5 rounded-md bg-gray-100 dark:bg-[#1a2540] text-gray-600 dark:text-gray-400">${z.name}</span>
                                        </c:if>
                                    </c:forEach>
                                    <span class="text-xs px-2 py-0.5 rounded-md border capitalize font-medium ${slot.status eq 'occupied' ? 'bg-red-50 text-red-600 border-red-200 dark:bg-red-500/15 dark:text-red-400 dark:border-red-500/25' : 'bg-amber-50 text-amber-600 border-amber-200 dark:bg-amber-500/15 dark:text-amber-400 dark:border-amber-500/25'}">
                                        ${slot.status}
                                    </span>
                                </div>
                            </button>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>
</div>
<%@ include file="modals.jsp" %>
<script>
    const slots = ${slotsJson};
    window.handleVehicleClick = (id) => {
        const slot = slots.find(s => s.id === id);
        openActionModal(slot);
    };
    document.addEventListener('DOMContentLoaded', () => { lucide.createIcons(); });
</script>
</body>
</html>
