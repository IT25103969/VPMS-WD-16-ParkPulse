<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>
<div class="flex h-screen overflow-hidden">
    <%@ include file="sidebar.jsp" %>
    
    <main class="flex-1 overflow-y-auto">
        <div class="p-8">
            <div class="flex items-center justify-between mb-6 gap-4 flex-wrap">
                <div>
                    <h1 class="text-primary text-2xl font-semibold">Dashboard</h1>
                    <p class="text-sm text-muted">Overview of slots and zones across your facility.</p>
                </div>
                <div class="flex items-center gap-3 flex-wrap">
                    <div class="relative">
                        <i data-lucide="search" class="absolute left-3 top-1/2 -translate-y-1/2 size-4 pointer-events-none text-muted"></i>
                        <input
                            type="text"
                            id="dashboard-search"
                            placeholder="Search by plate…"
                            class="pl-9 py-2 rounded-full border border-border bg-background text-sm w-48 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all dark:bg-[#0b1220] dark:border-[#1f2a44]"
                        />
                    </div>
                    <button onclick="handleNewEntry()" class="flex items-center gap-2 px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-full transition-colors shadow-lg">
                        <i data-lucide="plus" class="size-4"></i>
                        <span class="text-sm">New Entry</span>
                    </button>
                </div>
            </div>

            <!-- Stats Grid -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                <div class="rounded-2xl border border-border p-4 card-bg">
                    <div class="text-xs text-muted">Total Slots</div>
                    <div class="mt-1 text-primary text-xl font-semibold">${totalSlots}</div>
                </div>
                <div class="rounded-2xl border border-border p-4 card-bg">
                    <div class="text-xs text-muted">Available</div>
                    <div class="mt-1 text-emerald-500 text-xl font-semibold">${availableSlots}</div>
                </div>
                <div class="rounded-2xl border border-border p-4 card-bg">
                    <div class="text-xs text-muted">Occupied</div>
                    <div class="mt-1 text-red-500 text-xl font-semibold">${occupiedSlots}</div>
                </div>
                <div class="rounded-2xl border border-border p-4 card-bg">
                    <div class="text-xs text-muted">Occupancy</div>
                    <div class="mt-1 text-blue-500 text-xl font-semibold">${occupancyRate}</div>
                </div>
            </div>

            <!-- Zones Overview -->
            <div class="rounded-2xl border border-border card-bg p-6 mb-6">
                <h2 class="mb-4 text-primary text-xl font-semibold">Zones Overview</h2>
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                    <c:forEach var="zone" items="${zones}">
                        <c:set var="zSlots" value="${0}" />
                        <c:set var="zOccupied" value="${0}" />
                        <c:forEach var="slot" items="${slots}">
                            <c:if test="${slot.zoneId eq zone.id}">
                                <c:set var="zSlots" value="${zSlots + 1}" />
                                <c:if test="${slot.status eq 'occupied'}">
                                    <c:set var="zOccupied" value="${zOccupied + 1}" />
                                </c:if>
                            </c:if>
                        </c:forEach>
                        <c:set var="zPct" value="${zSlots gt 0 ? (zOccupied * 100 / zSlots) : 0}" />
                        
                        <a href="/slots?zoneId=${zone.id}" class="rounded-xl border border-border p-4 text-left transition-colors inner-bg hover:border-blue-500 dark:border-[#1f2a44] dark:hover:border-blue-500">
                            <div class="flex items-center justify-between mb-2">
                                <div class="flex items-center gap-2">
                                    <i data-lucide="map-pin" class="size-4 text-blue-500"></i>
                                    <span class="text-sm text-primary font-medium">${zone.name}</span>
                                </div>
                                <span class="text-xs text-muted">${zPct}%</span>
                            </div>
                            <div class="h-2 rounded-full overflow-hidden bg-gray-200 dark:bg-[#1a2540] mb-3">
                                <div class="h-full bg-gradient-to-r from-blue-500 to-blue-600" style="width: ${zPct}%"></div>
                            </div>
                            <div class="flex justify-between text-xs">
                                <span class="text-emerald-500">${zSlots - zOccupied} free</span>
                                <span class="text-red-500">${zOccupied} occupied</span>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>

            <!-- Slot Map -->
            <div class="rounded-2xl border border-border card-bg p-6">
                <div class="flex items-center justify-between mb-4">
                    <h2 class="text-primary text-xl font-semibold">Slot Map</h2>
                    <a href="/slots" class="text-sm text-blue-500 hover:text-blue-400">Manage →</a>
                </div>
                <div class="flex gap-4 text-xs mb-4 flex-wrap">
                    <div class="flex items-center gap-1.5">
                        <span class="size-3 rounded-sm inline-block bg-emerald-500"></span>
                        <span class="text-muted">Available</span>
                    </div>
                    <div class="flex items-center gap-1.5">
                        <span class="size-3 rounded-sm inline-block bg-red-500"></span>
                        <span class="text-muted">Occupied</span>
                    </div>
                    <div class="flex items-center gap-1.5">
                        <span class="size-3 rounded-sm inline-block bg-amber-400"></span>
                        <span class="text-muted">Reserved</span>
                    </div>
                    <div class="flex items-center gap-1.5">
                        <span class="size-3 rounded-sm inline-block bg-orange-400"></span>
                        <span class="text-muted">Maintenance</span>
                    </div>
                </div>

                <div id="slot-map-container">
                    <!-- Dynamic rendering via JS for smoother zone switching -->
                </div>
            </div>
        </div>
    </main>
</div>
<%@ include file="modals.jsp" %>
<script>
    const zones = ${zonesJson};
    const slots = ${slotsJson};
    let dashActiveZoneIdx = 0;

    const renderDashboardSlotMap = () => {
        const container = document.getElementById('slot-map-container');
        const activeZone = zones[dashActiveZoneIdx];
        const zoneSlots = slots.filter(s => s.zoneId === activeZone.id);

        container.innerHTML = `
            <div class="flex items-center justify-between mb-3">
                <div class="flex items-center gap-2">
                    <i data-lucide="map-pin" class="size-3.5 text-blue-500"></i>
                    <span class="text-sm font-medium text-primary">\${activeZone.name}</span>
                    <span class="text-xs text-muted">· \${zoneSlots.length} slots</span>
                </div>
                <div class="flex items-center gap-2">
                    <div class="flex items-center gap-1 mr-1">
                        \${zones.map((_, i) => `
                            <button onclick="setDashZone(\${i})" class="rounded-full transition-all \${i === dashActiveZoneIdx ? 'size-2 bg-blue-500' : 'size-1.5 bg-gray-300 dark:bg-[#2a3a5c]'}"></button>
                        `).join('')}
                    </div>
                    <button onclick="stepDashZone(-1)" \${dashActiveZoneIdx === 0 ? 'disabled' : ''} class="p-1.5 rounded-lg transition-colors hover:bg-gray-100 dark:hover:bg-[#1a2540] disabled:opacity-30">
                        <i data-lucide="chevron-left" class="size-4 text-muted"></i>
                    </button>
                    <button onclick="stepDashZone(1)" \${dashActiveZoneIdx === zones.length - 1 ? 'disabled' : ''} class="p-1.5 rounded-lg transition-colors hover:bg-gray-100 dark:hover:bg-[#1a2540] disabled:opacity-30">
                        <i data-lucide="chevron-right" class="size-4 text-muted"></i>
                    </button>
                </div>
            </div>

            <div class="grid grid-cols-6 sm:grid-cols-8 md:grid-cols-10 gap-2">
                \${zoneSlots.map(slot => {
                    const statusClass = 
                        slot.status === 'occupied' ? 'bg-gradient-to-b from-red-500 to-red-600' :
                        slot.status === 'reserved' ? 'bg-gradient-to-b from-amber-400 to-amber-500' :
                        slot.status === 'maintenance' ? 'bg-gradient-to-b from-orange-400 to-orange-500' :
                        'bg-gradient-to-b from-emerald-500 to-emerald-600';
                    return `
                        <button onclick="handleSlotClick('\${slot.id}')" class="h-12 rounded-lg text-xs text-white font-medium transition-transform hover:scale-105 \${statusClass}">
                            \${slot.number}
                        </button>
                    `;
                }).join('')}
            </div>
        `;
        lucide.createIcons();
    };

    window.setDashZone = (idx) => { dashActiveZoneIdx = idx; renderDashboardSlotMap(); };
    window.stepDashZone = (step) => { dashActiveZoneIdx = Math.max(0, Math.min(zones.length - 1, dashActiveZoneIdx + step)); renderDashboardSlotMap(); };
    window.handleNewEntry = () => {
        const firstFree = slots.find(s => s.status === 'available');
        if (firstFree) {
            window.selectedSlotId = firstFree.id;
            openEntryModal(firstFree);
        }
    };
    window.handleSlotClick = (id) => {
        const slot = slots.find(s => s.id === id);
        window.selectedSlotId = id;
        openActionModal(slot);
    };

    document.addEventListener('DOMContentLoaded', renderDashboardSlotMap);
</script>
</body>
</html>
