<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="common/header.jsp" />
<jsp:include page="common/sidebar.jsp" />

<main class="flex-1 overflow-y-auto bg-background" x-data="vehiclesData()">
    <div class="p-8">
        <div class="flex items-center justify-between mb-6 gap-4 flex-wrap">
            <div>
                <h1 class="text-2xl font-semibold text-foreground">Parked Vehicles</h1>
                <p class="text-sm text-muted-foreground">All vehicles currently occupying or reserving a slot.</p>
            </div>
            <div class="relative">
                <i data-lucide="search" class="absolute left-3 top-1/2 -translate-y-1/2 size-4 pointer-events-none text-muted-foreground"></i>
                <input 
                    type="text" 
                    x-model="search"
                    placeholder="Plate, owner, type, zone…" 
                    class="pl-9 pr-4 py-2 rounded-full border border-border bg-input-background text-foreground text-sm w-56 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-all"
                >
            </div>
        </div>

        <!-- Stats chips -->
        <div class="grid grid-cols-3 gap-4 mb-6">
            <button @click="filter = 'all'" class="rounded-2xl border p-4 text-left transition-all bg-blue-500/10 border-blue-500/20" :class="filter === 'all' ? 'ring-2 ring-blue-500' : ''">
                <div class="text-xs text-muted-foreground mb-1">Total Parked</div>
                <div class="text-2xl font-semibold text-blue-500" x-text="counts.all"></div>
            </button>
            <button @click="filter = 'occupied'" class="rounded-2xl border p-4 text-left transition-all bg-red-500/10 border-red-500/20" :class="filter === 'occupied' ? 'ring-2 ring-blue-500' : ''">
                <div class="text-xs text-muted-foreground mb-1">Occupied</div>
                <div class="text-2xl font-semibold text-red-500" x-text="counts.occupied"></div>
            </button>
            <button @click="filter = 'reserved'" class="rounded-2xl border p-4 text-left transition-all bg-amber-500/10 border-amber-500/20" :class="filter === 'reserved' ? 'ring-2 ring-blue-500' : ''">
                <div class="text-xs text-muted-foreground mb-1">Reserved</div>
                <div class="text-2xl font-semibold text-amber-400" x-text="counts.reserved"></div>
            </button>
        </div>

        <div class="rounded-2xl border border-border bg-card overflow-hidden">
            <div class="flex items-center gap-3 px-5 py-3 border-b border-border flex-wrap">
                <i data-lucide="filter" class="size-4 text-muted-foreground"></i>
                <template x-for="f in ['all', 'occupied', 'reserved']">
                    <button 
                        @click="filter = f"
                        class="px-3 py-1 rounded-lg text-xs capitalize transition-colors"
                        :class="filter === f ? 'bg-blue-600 text-white' : 'bg-muted text-foreground hover:bg-accent'"
                        x-text="f + ' (' + counts[f] + ')'"
                    ></button>
                </template>
            </div>

            <div class="divide-y divide-border">
                <template x-for="slot in filteredVehicles" :key="slot.id">
                    <button 
                        @click="editVehicle(slot)"
                        class="w-full flex items-center gap-4 px-5 py-4 text-left transition-colors hover:bg-blue-500/5 group"
                    >
                        <div class="size-11 shrink-0 rounded-xl flex items-center justify-center text-xs font-bold text-white shadow-md"
                            :class="slot.status === 'occupied' ? 'bg-gradient-to-b from-red-500 to-red-600' : 'bg-gradient-to-b from-amber-400 to-amber-500'"
                            x-text="slot.number"></div>
                        
                        <div class="flex-1 min-w-0">
                            <div class="text-sm font-semibold text-foreground tracking-wide" x-text="slot.vehicle.licensePlate"></div>
                            <div class="text-xs text-muted-foreground flex items-center gap-3 mt-0.5 flex-wrap">
                                <span class="flex items-center gap-1"><i data-lucide="user" class="size-3"></i> <span x-text="slot.vehicle.owner"></span></span>
                                <span class="flex items-center gap-1"><i data-lucide="car" class="size-3"></i> <span x-text="slot.vehicle.type"></span></span>
                            </div>
                        </div>

                        <div class="hidden md:flex flex-col gap-1 text-xs text-muted-foreground min-w-[140px]">
                            <span class="flex items-center gap-1.5"><i data-lucide="phone-call" class="size-3 shrink-0"></i> <span x-text="slot.vehicle.phone"></span></span>
                            <span class="flex items-center gap-1.5 truncate max-w-[160px]"><i data-lucide="at-sign" class="size-3 shrink-0"></i> <span x-text="slot.vehicle.email"></span></span>
                        </div>

                        <div class="hidden lg:flex flex-col gap-1 text-xs text-muted-foreground min-w-[90px]">
                            <span class="flex items-center gap-1.5"><i data-lucide="clock" class="size-3 shrink-0"></i> <span x-text="slot.vehicle.entryTime"></span></span>
                            <span class="flex items-center gap-1.5"><i data-lucide="timer" class="size-3 shrink-0"></i> <span x-text="slot.vehicle.duration"></span></span>
                        </div>

                        <div class="flex flex-col items-end gap-1.5 shrink-0">
                            <span class="text-xs px-2 py-0.5 rounded-md bg-muted text-muted-foreground" x-text="slot.zoneName"></span>
                            <span class="text-xs px-2 py-0.5 rounded-md border capitalize font-medium"
                                :class="slot.status === 'occupied' ? 'bg-red-500/15 text-red-400 border-red-500/25' : 'bg-amber-500/15 text-amber-400 border-amber-500/25'"
                                x-text="slot.status"></span>
                        </div>

                        <!-- Action Buttons -->
                        <div class="flex items-center gap-3 ml-4">
                            <button 
                                @click.stop="editVehicle(slot)"
                                class="flex items-center gap-2 px-3 py-2 rounded-lg bg-blue-500/10 text-blue-500 hover:bg-blue-500/20 transition-colors"
                                title="Edit Details"
                            >
                                <i data-lucide="pencil" class="size-4"></i>
                                <span class="text-xs font-medium hidden sm:inline">Edit</span>
                            </button>
                            <button 
                                @click.stop="deleteVehicle(slot)"
                                class="flex items-center gap-2 px-3 py-2 rounded-lg bg-red-500/10 text-red-500 hover:bg-red-500/20 transition-colors"
                                title="Delete Vehicle"
                            >
                                <i data-lucide="trash-2" class="size-4"></i>
                                <span class="text-xs font-medium hidden sm:inline">Delete</span>
                            </button>
                        </div>
                    </button>
                </template>
            </div>
        </div>
    </div>
</main>

<jsp:include page="common/footer.jsp" />
