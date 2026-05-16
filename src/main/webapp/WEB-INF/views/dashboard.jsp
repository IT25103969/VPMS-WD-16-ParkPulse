<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="common/header.jsp" />
<jsp:include page="common/sidebar.jsp" />

<main class="flex-1 overflow-y-auto bg-background" x-data="dashboardData()">
    <div class="p-8">
        <div class="flex items-center justify-between mb-6 gap-4 flex-wrap">
            <div>
                <h1 class="text-2xl font-semibold text-foreground">Dashboard</h1>
                <p class="text-sm text-muted-foreground">Overview of slots and zones across your facility.</p>
            </div>
            <div class="flex items-center gap-3 flex-wrap">
                <div class="relative">
                    <i data-lucide="search" class="absolute left-3 top-1/2 -translate-y-1/2 size-4 pointer-events-none text-muted-foreground"></i>
                    <input 
                        type="text" 
                        placeholder="Search by plate…" 
                        class="pl-9 pr-4 py-2 rounded-full border border-border bg-input-background text-foreground text-sm w-48 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all"
                    >
                </div>
                <a 
                    href="entry"
                    class="flex items-center gap-2 px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-full transition-colors shadow-lg"
                >
                    <i data-lucide="plus" class="size-4"></i>
                    <span class="text-sm">New Entry</span>
                </a>
            </div>
        </div>

        <!-- Stats row -->
        <div class="grid grid-cols-4 gap-4 mb-6">
            <template x-for="stat in stats" :key="stat.label">
                <div class="rounded-2xl border border-border p-4 bg-card">
                    <div class="text-xs text-muted-foreground" x-text="stat.label"></div>
                    <div class="mt-1 font-semibold" :class="stat.color" x-text="stat.value"></div>
                </div>
            </template>
        </div>

        <!-- Zones Overview -->
        <div class="rounded-2xl border border-border bg-card p-6 mb-6">
            <h2 class="mb-4 text-xl font-medium text-foreground">Zones Overview</h2>
            <div class="grid grid-cols-2 lg:grid-cols-4 gap-4">
                <template x-for="z in zoneStats" :key="z.id">
                    <div class="rounded-xl border border-border p-4 text-left bg-background">
                        <div class="flex items-center justify-between mb-2">
                            <div class="flex items-center gap-2">
                                <i data-lucide="map-pin" class="size-4 text-blue-500"></i>
                                <span class="text-sm font-medium text-foreground" x-text="z.name"></span>
                            </div>
                            <span class="text-xs text-muted-foreground" x-text="z.pct + '%'"></span>
                        </div>
                        <div class="h-2 rounded-full overflow-hidden bg-muted mb-3">
                            <div class="h-full bg-gradient-to-r from-blue-500 to-blue-600" :style="{ width: z.pct + '%' }"></div>
                        </div>
                        <div class="flex justify-between text-xs">
                            <span class="text-emerald-500" x-text="z.available + ' free'"></span>
                            <span class="text-red-500" x-text="z.occupied + ' occupied'"></span>
                        </div>
                    </div>
                </template>
            </div>
        </div>

        <!-- Slot Map -->
        <div class="rounded-2xl border border-border bg-card p-6">
            <div class="flex items-center justify-between mb-4">
                <h2 class="text-xl font-medium text-foreground">Slot Map</h2>
            </div>
            <div class="flex gap-4 text-xs mb-4 flex-wrap">
                <div class="flex items-center gap-1.5"><span class="size-3 rounded-sm inline-block bg-emerald-500"></span><span class="text-muted-foreground">Available</span></div>
                <div class="flex items-center gap-1.5"><span class="size-3 rounded-sm inline-block bg-red-500"></span><span class="text-muted-foreground">Occupied</span></div>
                <div class="flex items-center gap-1.5"><span class="size-3 rounded-sm inline-block bg-amber-400"></span><span class="text-muted-foreground">Reserved</span></div>
                <div class="flex items-center gap-1.5"><span class="size-3 rounded-sm inline-block bg-orange-400"></span><span class="text-muted-foreground">Maintenance</span></div>
            </div>

            <!-- Zone navigation bar -->
            <div class="flex items-center justify-between mb-3">
                <div class="flex items-center gap-2">
                    <i data-lucide="map-pin" class="size-3.5 text-blue-500"></i>
                    <span class="text-sm font-medium text-foreground" x-text="zones[dashActiveZone].name"></span>
                    <span class="text-xs text-muted-foreground" x-text="'· ' + slotsPerZone + ' slots'"></span>
                </div>
                <div class="flex items-center gap-2">
                    <div class="flex items-center gap-1 mr-1">
                        <template x-for="(z, i) in zones" :key="z.id">
                            <button 
                                @click="scrollToZone(i)"
                                class="rounded-full transition-all"
                                :class="i === dashActiveZone ? 'size-2 bg-blue-500' : 'size-1.5 bg-muted hover:bg-muted-foreground'"
                            ></button>
                        </template>
                    </div>
                    <button 
                        @click="scrollToZone(Math.max(0, dashActiveZone - 1))"
                        :disabled="dashActiveZone === 0"
                        class="p-1.5 rounded-lg transition-colors disabled:opacity-30 hover:bg-muted text-muted-foreground"
                    >
                        <i data-lucide="chevron-left" class="size-4"></i>
                    </button>
                    <button 
                        @click="scrollToZone(Math.min(zones.length - 1, dashActiveZone + 1))"
                        :disabled="dashActiveZone === zones.length - 1"
                        class="p-1.5 rounded-lg transition-colors disabled:opacity-30 hover:bg-muted text-muted-foreground"
                    >
                        <i data-lucide="chevron-right" class="size-4"></i>
                    </button>
                </div>
            </div>

            <!-- Horizontal snap scroll container -->
            <div 
                class="overflow-x-auto [scrollbar-width:none] [&::-webkit-scrollbar]:hidden snap-x snap-mandatory"
                @scroll="handleScroll($event)"
                id="slotMapContainer"
            >
                <div class="flex">
                    <template x-for="zone in zones" :key="zone.id">
                        <div class="min-w-full snap-start">
                            <div class="grid grid-cols-6 gap-2">
                                <template x-for="slot in zoneSlots(zone.id)" :key="slot.id">
                                    <a 
                                        :href="slot.status === 'occupied' ? 'checkout?slot=' + slot.number : 'entry?slot=' + slot.number"
                                        class="h-12 rounded-lg text-xs text-white transition-transform hover:scale-105 shadow-sm flex items-center justify-center"
                                        :class="{
                                            'bg-gradient-to-b from-red-500 to-red-600': slot.status === 'occupied',
                                            'bg-gradient-to-b from-amber-400 to-amber-500': slot.status === 'reserved',
                                            'bg-gradient-to-b from-orange-400 to-orange-500': slot.status === 'maintenance',
                                            'bg-gradient-to-b from-emerald-500 to-emerald-600': slot.status === 'available'
                                        }"
                                        x-text="slot.number"
                                    ></a>
                                </template>
                            </div>
                        </div>
                    </template>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="common/footer.jsp" />
