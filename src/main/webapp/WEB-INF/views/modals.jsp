<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Modals Container -->
<div id="modal-container" class="fixed inset-0 z-50 pointer-events-none">
    <!-- Backdrop -->
    <div id="modal-backdrop" class="fixed inset-0 bg-black/60 backdrop-blur-sm opacity-0 pointer-events-none transition-opacity duration-300"></div>

    <!-- Slot Action Modal -->
    <div id="slot-modal" class="fixed top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-full max-w-md rounded-2xl shadow-2xl z-50 border border-border card-bg transform scale-90 opacity-0 pointer-events-none transition-all duration-300">
        <div class="p-6">
            <div class="flex items-center justify-between mb-6">
                <div>
                    <h2 class="text-primary text-xl font-semibold">Slot <span id="modal-slot-number"></span></h2>
                    <p class="text-sm text-muted" id="modal-slot-status"></p>
                </div>
                <button onclick="closeModal('slot-modal')" class="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-[#1a2540]">
                    <i data-lucide="x" class="size-5 text-muted"></i>
                </button>
            </div>
            
            <div id="slot-actions" class="space-y-3">
                <!-- Actions will be context-dependent (Enter, Release, etc.) -->
            </div>
        </div>
    </div>

    <!-- New Entry Modal (Full Form) -->
    <div id="entry-modal" class="fixed top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-full max-w-2xl rounded-2xl shadow-2xl z-50 border border-border card-bg transform scale-90 opacity-0 pointer-events-none transition-all duration-300">
        <div class="overflow-hidden rounded-2xl">
            <div class="bg-gradient-to-br from-blue-600 to-blue-700 p-6 flex items-center gap-4">
                <div class="size-12 bg-white/20 rounded-xl flex items-center justify-center">
                    <i data-lucide="log-in" class="size-6 text-white"></i>
                </div>
                <div>
                    <h2 class="text-white text-xl font-semibold">Vehicle Entry</h2>
                    <p class="text-blue-100 text-sm">Recording vehicle entry for Slot <span id="entry-slot-number"></span></p>
                </div>
                <button onclick="closeModal('entry-modal')" class="ml-auto p-2 rounded-lg bg-white/10 text-white hover:bg-white/20">
                    <i data-lucide="x" class="size-5"></i>
                </button>
            </div>
            <form action="/action" method="POST" class="p-6 grid grid-cols-2 gap-4">
                <input type="hidden" name="action" value="enter_vehicle">
                <input type="hidden" name="slotId" id="entry-slot-id">
                
                <div class="col-span-1">
                    <label class="block text-xs font-medium text-muted mb-1.5 uppercase tracking-wider">License Plate</label>
                    <input type="text" name="licensePlate" required placeholder="e.g. ABC-1234" class="w-full px-4 py-2.5 rounded-xl border border-border bg-gray-50 dark:bg-[#0b1220] text-primary focus:ring-2 focus:ring-blue-500 outline-none">
                </div>
                <div class="col-span-1">
                    <label class="block text-xs font-medium text-muted mb-1.5 uppercase tracking-wider">Vehicle Type</label>
                    <select name="type" class="w-full px-4 py-2.5 rounded-xl border border-border bg-gray-50 dark:bg-[#0b1220] text-primary focus:ring-2 focus:ring-blue-500 outline-none appearance-none">
                        <option>Sedan</option><option>SUV</option><option>Hatchback</option><option>Truck</option><option>Motorcycle</option><option>Motorbike</option><option>Van</option>
                    </select>
                </div>
                <div class="col-span-2">
                    <label class="block text-xs font-medium text-muted mb-1.5 uppercase tracking-wider">Owner Name</label>
                    <input type="text" name="owner" placeholder="Full name" class="w-full px-4 py-2.5 rounded-xl border border-border bg-gray-50 dark:bg-[#0b1220] text-primary focus:ring-2 focus:ring-blue-500 outline-none">
                </div>
                <div class="col-span-1">
                    <label class="block text-xs font-medium text-muted mb-1.5 uppercase tracking-wider">Phone</label>
                    <input type="text" name="phone" placeholder="+1..." class="w-full px-4 py-2.5 rounded-xl border border-border bg-gray-50 dark:bg-[#0b1220] text-primary focus:ring-2 focus:ring-blue-500 outline-none">
                </div>
                <div class="col-span-1">
                    <label class="block text-xs font-medium text-muted mb-1.5 uppercase tracking-wider">Email</label>
                    <input type="email" name="email" placeholder="email@example.com" class="w-full px-4 py-2.5 rounded-xl border border-border bg-gray-50 dark:bg-[#0b1220] text-primary focus:ring-2 focus:ring-blue-500 outline-none">
                </div>
                <div class="col-span-2 mt-4 flex gap-3">
                    <button type="button" onclick="closeModal('entry-modal')" class="flex-1 py-3 px-4 rounded-xl border border-border text-primary font-medium hover:bg-gray-100 dark:hover:bg-[#1a2540] transition-colors">Cancel</button>
                    <button type="submit" class="flex-1 py-3 px-4 rounded-xl bg-blue-600 text-white font-semibold hover:bg-blue-700 shadow-lg shadow-blue-500/25 transition-all">Record Entry</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Zone Modal -->
    <div id="zone-modal" class="fixed top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-full max-w-lg rounded-2xl shadow-2xl z-50 border border-border card-bg transform scale-90 opacity-0 pointer-events-none transition-all duration-300">
        <div class="overflow-hidden rounded-2xl">
            <div class="bg-gradient-to-br from-blue-600 to-blue-700 p-6 flex items-center gap-4">
                <div class="size-12 bg-white/20 rounded-xl flex items-center justify-center">
                    <i data-lucide="map-pin" class="size-6 text-white"></i>
                </div>
                <div>
                    <h2 class="text-white text-xl font-semibold" id="zone-modal-title">Create New Zone</h2>
                    <p class="text-blue-100 text-sm">Define a new parking section</p>
                </div>
                <button onclick="closeModal('zone-modal')" class="ml-auto p-2 rounded-lg bg-white/10 text-white hover:bg-white/20">
                    <i data-lucide="x" class="size-5"></i>
                </button>
            </div>
            <form action="/action" method="POST" class="p-6 space-y-4">
                <input type="hidden" name="action" id="zone-action" value="create_zone">
                <input type="hidden" name="zoneId" id="zone-modal-id">
                
                <div>
                    <label class="block text-xs font-medium text-muted mb-1.5 uppercase tracking-wider">Zone Name</label>
                    <input type="text" name="name" id="zone-modal-name" required placeholder="e.g. Section E" class="w-full px-4 py-2.5 rounded-xl border border-border bg-gray-50 dark:bg-[#0b1220] text-primary focus:ring-2 focus:ring-blue-500 outline-none">
                </div>
                <div class="grid grid-cols-2 gap-4">
                    <div id="slot-count-container">
                        <label class="block text-xs font-medium text-muted mb-1.5 uppercase tracking-wider">Initial Slots</label>
                        <input type="number" name="slotCount" id="zone-modal-slots" value="12" min="1" class="w-full px-4 py-2.5 rounded-xl border border-border bg-gray-50 dark:bg-[#0b1220] text-primary focus:ring-2 focus:ring-blue-500 outline-none">
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-muted mb-1.5 uppercase tracking-wider">Price per Hour</label>
                        <div class="relative">
                            <span class="absolute left-4 top-1/2 -translate-y-1/2 text-muted">$</span>
                            <input type="number" name="price" id="zone-modal-price" step="0.01" value="2.50" class="w-full pl-8 pr-4 py-2.5 rounded-xl border border-border bg-gray-50 dark:bg-[#0b1220] text-primary focus:ring-2 focus:ring-blue-500 outline-none">
                        </div>
                    </div>
                </div>
                <div>
                    <label class="block text-xs font-medium text-muted mb-1.5 uppercase tracking-wider">Allowed Vehicle Types</label>
                    <div class="grid grid-cols-3 gap-2">
                        <label class="flex items-center gap-2 px-3 py-2 rounded-lg border border-border cursor-pointer hover:bg-gray-50 dark:hover:bg-[#1a2540]">
                            <input type="checkbox" name="vTypes" value="Sedan" checked class="accent-blue-600">
                            <span class="text-xs">Sedan</span>
                        </label>
                        <label class="flex items-center gap-2 px-3 py-2 rounded-lg border border-border cursor-pointer hover:bg-gray-50 dark:hover:bg-[#1a2540]">
                            <input type="checkbox" name="vTypes" value="SUV" checked class="accent-blue-600">
                            <span class="text-xs">SUV</span>
                        </label>
                        <label class="flex items-center gap-2 px-3 py-2 rounded-lg border border-border cursor-pointer hover:bg-gray-50 dark:hover:bg-[#1a2540]">
                            <input type="checkbox" name="vTypes" value="Hatchback" checked class="accent-blue-600">
                            <span class="text-xs">Hatch</span>
                        </label>
                        <label class="flex items-center gap-2 px-3 py-2 rounded-lg border border-border cursor-pointer hover:bg-gray-50 dark:hover:bg-[#1a2540]">
                            <input type="checkbox" name="vTypes" value="Truck" class="accent-blue-600">
                            <span class="text-xs">Truck</span>
                        </label>
                        <label class="flex items-center gap-2 px-3 py-2 rounded-lg border border-border cursor-pointer hover:bg-gray-50 dark:hover:bg-[#1a2540]">
                            <input type="checkbox" name="vTypes" value="Motorcycle" class="accent-blue-600">
                            <span class="text-xs">Moto</span>
                        </label>
                    </div>
                </div>
                <div class="pt-4 flex gap-3">
                    <button type="button" onclick="closeModal('zone-modal')" class="flex-1 py-3 px-4 rounded-xl border border-border text-primary font-medium hover:bg-gray-100 dark:hover:bg-[#1a2540] transition-colors">Cancel</button>
                    <button type="submit" class="flex-1 py-3 px-4 rounded-xl bg-blue-600 text-white font-semibold hover:bg-blue-700 shadow-lg transition-all">Save Zone</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function openModal(modalId) {
        const container = document.getElementById('modal-container');
        const backdrop = document.getElementById('modal-backdrop');
        const modal = document.getElementById(modalId);
        
        container.classList.remove('pointer-events-none');
        backdrop.classList.remove('pointer-events-none', 'opacity-0');
        backdrop.classList.add('opacity-100');
        
        modal.classList.remove('pointer-events-none', 'opacity-0', 'scale-90');
        modal.classList.add('opacity-100', 'scale-100');
        lucide.createIcons();
    }

    function closeModal(modalId) {
        const container = document.getElementById('modal-container');
        const backdrop = document.getElementById('modal-backdrop');
        const modal = document.getElementById(modalId);
        
        modal.classList.add('opacity-0', 'scale-90', 'pointer-events-none');
        modal.classList.remove('opacity-100', 'scale-100');
        
        backdrop.classList.add('opacity-0', 'pointer-events-none');
        backdrop.classList.remove('opacity-100');
        
        setTimeout(() => { container.classList.add('pointer-events-none'); }, 300);
    }

    function openEntryModal(slot) {
        document.getElementById('entry-slot-number').textContent = slot.number;
        document.getElementById('entry-slot-id').value = slot.id;
        openModal('entry-modal');
    }

    function openActionModal(slot) {
        const actionsDiv = document.getElementById('slot-actions');
        document.getElementById('modal-slot-number').textContent = slot.number;
        document.getElementById('modal-slot-status').textContent = slot.status.charAt(0).toUpperCase() + slot.status.slice(1);
        
        let html = '';
        if (slot.status === 'available') {
            html = `
                <button onclick="openEntryModal({id: '\${slot.id}', number: '\${slot.number}'}); closeModal('slot-modal');" class="w-full flex items-center justify-between p-4 rounded-xl border border-blue-100 bg-blue-50 text-blue-700 hover:bg-blue-100 transition-colors dark:bg-blue-500/10 dark:border-blue-500/20 dark:text-blue-300">
                    <div class="flex items-center gap-3"><i data-lucide="log-in" class="size-5"></i><div class="text-left"><div class="font-semibold">Enter Vehicle</div><div class="text-xs opacity-80">Assign a vehicle to this spot</div></div></div>
                    <i data-lucide="chevron-right" class="size-4"></i>
                </button>
                <form action="/action" method="POST">
                    <input type="hidden" name="action" value="reserve_slot">
                    <input type="hidden" name="slotId" value="\${slot.id}">
                    <input type="hidden" name="reserveType" value="VIP">
                    <button type="submit" class="w-full flex items-center justify-between p-4 mt-2 rounded-xl border border-amber-100 bg-amber-50 text-amber-700 hover:bg-amber-100 transition-colors dark:bg-amber-500/10 dark:border-amber-500/20 dark:text-amber-300">
                        <div class="flex items-center gap-3"><i data-lucide="bookmark" class="size-5"></i><div class="text-left"><div class="font-semibold">Reserve Spot</div><div class="text-xs opacity-80">Mark as reserved (VIP/Staff)</div></div></div>
                        <i data-lucide="chevron-right" class="size-4"></i>
                    </button>
                </form>
                <form action="/action" method="POST">
                    <input type="hidden" name="action" value="maintenance_slot">
                    <input type="hidden" name="slotId" value="\${slot.id}">
                    <button type="submit" class="w-full flex items-center justify-between p-4 mt-2 rounded-xl border border-orange-100 bg-orange-50 text-orange-700 hover:bg-orange-100 transition-colors dark:bg-orange-500/10 dark:border-orange-500/20 dark:text-orange-300">
                        <div class="flex items-center gap-3"><i data-lucide="wrench" class="size-5"></i><div class="text-left"><div class="font-semibold">Maintenance</div><div class="text-xs opacity-80">Mark for repairs/cleaning</div></div></div>
                        <i data-lucide="chevron-right" class="size-4"></i>
                    </button>
                </form>
            `;
        } else {
            html = `
                <div class="p-4 rounded-xl bg-gray-50 dark:bg-[#1a2540] border border-border mb-4">
                    <div class="text-xs text-muted uppercase tracking-wider mb-2">Current Occupant</div>
                    \${slot.vehicle ? `
                        <div class="text-primary font-bold text-lg">\${slot.vehicle.licensePlate}</div>
                        <div class="text-sm text-muted">\${slot.vehicle.type} · \${slot.vehicle.owner}</div>
                        <div class="mt-2 flex items-center gap-2 text-blue-500 text-xs"><i data-lucide="clock" class="size-3"></i>Entered at \${slot.vehicle.entryTime}</div>
                    ` : `<div class="text-primary font-medium">\${slot.reservedBy || 'Maintenance'}</div>`}
                </div>
                <form action="/action" method="POST">
                    <input type="hidden" name="action" value="clear_slot">
                    <input type="hidden" name="slotId" value="\${slot.id}">
                    <button type="submit" class="w-full py-3 rounded-xl bg-red-600 text-white font-semibold hover:bg-red-700 shadow-lg">Release / Clear Slot</button>
                </form>
            `;
        }
        actionsDiv.innerHTML = html;
        openModal('slot-modal');
    }

    function openZoneModal(zone = null) {
        const title = document.getElementById('zone-modal-title');
        const actionInput = document.getElementById('zone-action');
        const idInput = document.getElementById('zone-modal-id');
        const nameInput = document.getElementById('zone-modal-name');
        const priceInput = document.getElementById('zone-modal-price');
        const slotCountContainer = document.getElementById('slot-count-container');
        
        if (zone) {
            title.textContent = 'Edit Zone';
            actionInput.value = 'update_zone';
            idInput.value = zone.id;
            nameInput.value = zone.name;
            priceInput.value = zone.pricePerHour;
            slotCountContainer.style.display = 'none';
        } else {
            title.textContent = 'Create New Zone';
            actionInput.value = 'create_zone';
            idInput.value = '';
            nameInput.value = '';
            priceInput.value = '2.50';
            slotCountContainer.style.display = 'block';
        }
        openModal('zone-modal');
    }

    document.getElementById('modal-backdrop').addEventListener('click', () => {
        document.querySelectorAll('.card-bg[id$="-modal"]').forEach(modal => {
            if (!modal.classList.contains('pointer-events-none')) closeModal(modal.id);
        });
    });
</script>
