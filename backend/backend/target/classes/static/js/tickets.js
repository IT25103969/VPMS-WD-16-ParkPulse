// ─── Tickets Page Logic ──────────────────────────────────────────────────────

let activeTab = 'ongoing';
let search = '';
let filters = {
    vehicleType: '',
    paymentMethod: '',
    dateFrom: '',
    dateTo: '',
    amountMin: '',
    amountMax: '',
    slot: ''
};

// ─── Render Table ────────────────────────────────────────────────────────────

function formatDateTime(iso) {
    if (!iso) return '—';
    const d = new Date(iso);
    return d.toLocaleString("en-US", {
        month: "short",
        day: "numeric",
        hour: "2-digit",
        minute: "2-digit",
    });
}

function getLiveAmount(entry) {
    const mins = Math.floor((Date.now() - new Date(entry).getTime()) / 60000);
    const hours = Math.ceil(mins / 60) || 1;
    return hours * HOURLY_RATE;
}

async function renderTable() {
    // Merge tab status with filters
    const queryParams = { ...filters, status: activeTab };
    const tickets = await getTickets(queryParams);
    
    const tbody = document.getElementById('tickets-tbody');
    tbody.innerHTML = '';

    // Search is still client-side for immediate feedback, or we could add it to backend too
    const filtered = tickets.filter(t => {
        const q = search.toLowerCase();
        if (q && ![t.vehiclePlate, t.ownerName, t.id, t.slot].some(v => v.toLowerCase().includes(q))) return false;
        return true;
    });

    if (filtered.length === 0) {
        tbody.innerHTML = `<tr><td colspan="9" class="text-center py-12 text-gray-500 dark:text-gray-400">No tickets match your filters.</td></tr>`;
    } else {
        filtered.forEach(t => {
            const tr = document.createElement('tr');
            tr.className = `transition ${t.status === 'ongoing' ? 'cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-700/50' : 'cursor-default'}`;
            if (t.status === 'ongoing') {
                tr.onclick = () => window.location.href = `checkout?id=${t.id}`;
            }

            tr.innerHTML = `
                <td class="px-5 py-3.5 font-mono text-xs text-gray-500 dark:text-gray-400">${t.id}</td>
                <td class="px-5 py-3.5 font-medium">${t.ownerName}</td>
                <td class="px-5 py-3.5 font-mono">${t.vehiclePlate}</td>
                <td class="px-5 py-3.5">
                    <span class="bg-blue-500/20 text-blue-400 text-xs px-2 py-0.5 rounded-lg font-mono">${t.slot}</span>
                </td>
                <td class="px-5 py-3.5 text-gray-500 dark:text-gray-400">${formatDateTime(t.entryTime)}</td>
                <td class="px-5 py-3.5 text-gray-500 dark:text-gray-400">
                    ${activeTab === 'finished' 
                        ? formatDateTime(t.exitTime)
                        : `<span class="flex items-center gap-1"><i data-lucide="clock" size="12" class="text-amber-400"></i>${duration(t.entryTime, null)}</span>`}
                </td>
                <td class="px-5 py-3.5 font-semibold">
                    <span>රු ${HOURLY_RATE}/hr</span>
                </td>
                <td class="px-5 py-3.5">
                    ${t.status === 'ongoing' 
                        ? `<select onclick="event.stopPropagation()" onchange="updatePaymentMethod('${t.id}', this.value)" class="text-xs px-2 py-1 rounded-lg border border-gray-200 dark:border-gray-600 bg-gray-50 dark:bg-gray-700 text-gray-700 dark:text-gray-200 outline-none cursor-pointer transition hover:border-gray-400">
                            <option value="Cash" ${t.paymentMethod === 'Cash' ? 'selected' : ''}>Cash</option>
                            <option value="Card" ${t.paymentMethod === 'Card' ? 'selected' : ''}>Card</option>
                            <option value="Mobile" ${t.paymentMethod === 'Mobile' ? 'selected' : ''}>Mobile</option>
                           </select>`
                        : `<span class="text-xs px-2 py-0.5 rounded-lg ${t.paymentMethod === 'Cash' ? 'bg-emerald-500/20 text-emerald-400' : t.paymentMethod === 'Card' ? 'bg-purple-500/20 text-purple-400' : 'bg-amber-500/20 text-amber-400'}">${t.paymentMethod}</span>`
                    }
                </td>
                <td class="px-5 py-3.5">
                    <div class="flex items-center gap-1">
                        <button onclick="event.stopPropagation(); openEditModal('${t.id}')" class="p-2 rounded-lg transition hover:bg-gray-100 dark:hover:bg-gray-600 text-gray-400 hover:text-gray-700 dark:hover:text-white" title="Edit ticket">
                            <i data-lucide="pencil" size="14"></i>
                        </button>
                        <button onclick="event.stopPropagation(); openDeleteModal('${t.id}')" class="p-2 rounded-lg transition hover:bg-red-50 dark:hover:bg-red-500/20 text-gray-400 hover:text-red-500 dark:hover:text-red-400" title="Delete ticket">
                            <i data-lucide="trash-2" size="14"></i>
                        </button>
                    </div>
                </td>
            `;
            tbody.appendChild(tr);
        });
        lucide.createIcons();
    }

    await updateStats();
    updatePills();
}

async function updateStats() {
    const all = await getTickets();
    const ongoing = all.filter(t => t.status === 'ongoing').length;
    const finished = all.filter(t => t.status === 'finished').length;
    const revenue = all.filter(t => t.status === 'finished').reduce((sum, t) => sum + Number(t.amount || 0), 0);

    document.getElementById('ongoing-count').innerText = ongoing;
    document.getElementById('finished-count').innerText = finished;
    document.getElementById('ongoing-tab-count').innerText = `(${ongoing})`;
    document.getElementById('finished-tab-count').innerText = `(${finished})`;
    document.getElementById('total-revenue').innerText = `රු ${revenue.toFixed(2)}`;
}

// ─── Tabs & Search ───────────────────────────────────────────────────────────

function switchTab(tab) {
    activeTab = tab;
    document.getElementById('tab-ongoing').className = tab === 'ongoing' ? 'px-4 py-2 rounded-xl text-sm font-medium transition capitalize bg-blue-600 text-white' : 'px-4 py-2 rounded-xl text-sm font-medium transition capitalize text-gray-500 dark:text-gray-400 hover:text-gray-800 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-700';
    document.getElementById('tab-finished').className = tab === 'finished' ? 'px-4 py-2 rounded-xl text-sm font-medium transition capitalize bg-blue-600 text-white' : 'px-4 py-2 rounded-xl text-sm font-medium transition capitalize text-gray-500 dark:text-gray-400 hover:text-gray-800 dark:hover:text-white hover:bg-gray-100 dark:hover:bg-gray-700';
    document.getElementById('table-col-dynamic').innerText = tab === 'finished' ? 'Exit' : 'Duration';
    renderTable();
}

document.getElementById('search-input').addEventListener('input', (e) => {
    search = e.target.value;
    renderTable();
});

// ─── Filters ─────────────────────────────────────────────────────────────────

function toggleFilter() {
    const popover = document.getElementById('filter-popover');
    popover.classList.toggle('hidden');
}

document.getElementById('filter-btn').onclick = (e) => {
    e.stopPropagation();
    toggleFilter();
};

document.addEventListener('click', (e) => {
    const popover = document.getElementById('filter-popover');
    if (!popover.contains(e.target) && e.target.id !== 'filter-btn') {
        popover.classList.add('hidden');
    }
});

// Vehicle Type Filter Buttons
document.querySelectorAll('#filter-vehicle-type button').forEach(btn => {
    btn.onclick = () => {
        document.querySelectorAll('#filter-vehicle-type button').forEach(b => {
            b.className = 'px-3 py-1.5 rounded-lg text-xs transition bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600';
        });
        btn.className = 'px-3 py-1.5 rounded-lg text-xs transition bg-blue-600 text-white';
        filters.vehicleType = btn.getAttribute('data-val');
    };
});

// Payment Method Filter Buttons
document.querySelectorAll('#filter-payment-method button').forEach(btn => {
    btn.onclick = () => {
        document.querySelectorAll('#filter-payment-method button').forEach(b => {
            b.className = 'px-3 py-1.5 rounded-lg text-xs transition bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600';
        });
        btn.className = 'px-3 py-1.5 rounded-lg text-xs transition bg-blue-600 text-white';
        filters.paymentMethod = btn.getAttribute('data-val');
    };
});

function applyFilters() {
    filters.dateFrom = document.getElementById('filter-date-from').value;
    filters.dateTo = document.getElementById('filter-date-to').value;
    filters.amountMin = document.getElementById('filter-amount-min').value;
    filters.amountMax = document.getElementById('filter-amount-max').value;
    filters.slot = document.getElementById('filter-slot').value;
    
    toggleFilter();
    renderTable();
}

function resetFilters() {
    filters = {
        vehicleType: '',
        paymentMethod: '',
        dateFrom: '',
        dateTo: '',
        amountMin: '',
        amountMax: '',
        slot: ''
    };
    
    // Reset UI
    document.getElementById('filter-date-from').value = '';
    document.getElementById('filter-date-to').value = '';
    document.getElementById('filter-amount-min').value = '';
    document.getElementById('filter-amount-max').value = '';
    document.getElementById('filter-slot').value = '';
    
    document.querySelectorAll('#filter-vehicle-type button').forEach((b, i) => {
        b.className = i === 0 ? 'px-3 py-1.5 rounded-lg text-xs transition bg-blue-600 text-white' : 'px-3 py-1.5 rounded-lg text-xs transition bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600';
    });
    document.querySelectorAll('#filter-payment-method button').forEach((b, i) => {
        b.className = i === 0 ? 'px-3 py-1.5 rounded-lg text-xs transition bg-blue-600 text-white' : 'px-3 py-1.5 rounded-lg text-xs transition bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600';
    });

    renderTable();
}

function updatePills() {
    const pillsContainer = document.getElementById('filter-pills');
    pillsContainer.innerHTML = '';
    let count = 0;

    const addPill = (label, onRemove) => {
        const span = document.createElement('span');
        span.className = 'flex items-center gap-1 text-xs px-2.5 py-1 rounded-full bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300';
        span.innerHTML = `${label} <button class="ml-0.5 opacity-60 hover:opacity-100 transition"><i data-lucide="x" size="10"></i></button>`;
        span.querySelector('button').onclick = onRemove;
        pillsContainer.appendChild(span);
        count++;
    };

    if (filters.vehicleType) addPill(`Type: ${filters.vehicleType}`, () => { filters.vehicleType = ''; resetFilterUI('vehicleType'); renderTable(); });
    if (filters.paymentMethod) addPill(`Payment: ${filters.paymentMethod}`, () => { filters.paymentMethod = ''; resetFilterUI('paymentMethod'); renderTable(); });
    if (filters.dateFrom) addPill(`From: ${filters.dateFrom}`, () => { filters.dateFrom = ''; document.getElementById('filter-date-from').value = ''; renderTable(); });
    if (filters.dateTo) addPill(`To: ${filters.dateTo}`, () => { filters.dateTo = ''; document.getElementById('filter-date-to').value = ''; renderTable(); });
    if (filters.amountMin) addPill(`Min Rs ${filters.amountMin}`, () => { filters.amountMin = ''; document.getElementById('filter-amount-min').value = ''; renderTable(); });
    if (filters.amountMax) addPill(`Max Rs ${filters.amountMax}`, () => { filters.amountMax = ''; document.getElementById('filter-amount-max').value = ''; renderTable(); });
    if (filters.slot) addPill(`Slot: ${filters.slot}`, () => { filters.slot = ''; document.getElementById('filter-slot').value = ''; renderTable(); });

    if (count > 0) {
        pillsContainer.classList.remove('hidden');
        const clearBtn = document.createElement('button');
        clearBtn.className = 'text-xs px-2 py-0.5 rounded-full transition underline underline-offset-2 text-gray-400 dark:text-gray-500 hover:text-gray-600 dark:hover:text-gray-300';
        clearBtn.innerText = 'Clear all';
        clearBtn.onclick = resetFilters;
        pillsContainer.appendChild(clearBtn);
        
        document.getElementById('active-filter-count').innerText = count;
        document.getElementById('active-filter-count').classList.remove('hidden');
    } else {
        pillsContainer.classList.add('hidden');
        document.getElementById('active-filter-count').classList.add('hidden');
    }
    lucide.createIcons();
}

function resetFilterUI(type) {
    if (type === 'vehicleType') {
        document.querySelectorAll('#filter-vehicle-type button').forEach((b, i) => {
            b.className = i === 0 ? 'px-3 py-1.5 rounded-lg text-xs transition bg-blue-600 text-white' : 'px-3 py-1.5 rounded-lg text-xs transition bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600';
        });
    } else if (type === 'paymentMethod') {
        document.querySelectorAll('#filter-payment-method button').forEach((b, i) => {
            b.className = i === 0 ? 'px-3 py-1.5 rounded-lg text-xs transition bg-blue-600 text-white' : 'px-3 py-1.5 rounded-lg text-xs transition bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600';
        });
    }
}

// ─── Actions ─────────────────────────────────────────────────────────────────

async function updatePaymentMethod(id, method) {
    const tickets = await getTickets();
    const idx = tickets.findIndex(t => t.id === id);
    if (idx !== -1) {
        tickets[idx].paymentMethod = method;
        await saveTicket(tickets[idx]);
    }
}

// ─── Modals ──────────────────────────────────────────────────────────────────

let currentTicket = null;

async function openEditModal(id) {
    const tickets = await getTickets();
    currentTicket = tickets.find(t => t.id === id);
    if (!currentTicket) return;

    document.getElementById('edit-id-title').innerText = currentTicket.id;
    document.getElementById('edit-id').value = currentTicket.id;
    document.getElementById('edit-owner').value = currentTicket.ownerName;
    document.getElementById('edit-plate').value = currentTicket.vehiclePlate;
    document.getElementById('edit-slot').value = currentTicket.slot;
    document.getElementById('edit-type').value = currentTicket.vehicleType;
    document.getElementById('edit-entry').value = currentTicket.entryTime.slice(0, 16);
    document.getElementById('edit-exit').value = currentTicket.exitTime ? currentTicket.exitTime.slice(0, 16) : '';
    document.getElementById('edit-payment').value = currentTicket.paymentMethod;
    document.getElementById('edit-status').value = currentTicket.status;

    const finishedInfo = document.getElementById('edit-finished-info');
    if (currentTicket.status === 'finished') {
        finishedInfo.classList.remove('hidden');
        document.getElementById('edit-payment-label').innerText = currentTicket.paymentMethod;
        document.getElementById('edit-amount-label').innerText = Number(currentTicket.amount).toFixed(2);
    } else {
        finishedInfo.classList.add('hidden');
    }

    document.getElementById('edit-print-btn').onclick = () => {
        const updated = {
            ...currentTicket,
            ownerName: document.getElementById('edit-owner').value,
            vehiclePlate: document.getElementById('edit-plate').value,
            slot: document.getElementById('edit-slot').value,
            vehicleType: document.getElementById('edit-type').value,
            entryTime: document.getElementById('edit-entry').value,
            exitTime: document.getElementById('edit-exit').value || null,
            paymentMethod: document.getElementById('edit-payment').value,
            status: document.getElementById('edit-status').value
        };
        printTicket(updated);
    };

    document.getElementById('edit-modal').classList.remove('hidden');
}

async function saveEdit() {
    const id = document.getElementById('edit-id').value;
    const tickets = await getTickets();
    const idx = tickets.findIndex(t => t.id === id);
    if (idx === -1) return;

    const updated = {
        ...tickets[idx],
        ownerName: document.getElementById('edit-owner').value,
        vehiclePlate: document.getElementById('edit-plate').value,
        slot: document.getElementById('edit-slot').value,
        vehicleType: document.getElementById('edit-type').value,
        entryTime: document.getElementById('edit-entry').value,
        exitTime: document.getElementById('edit-exit').value || null,
        paymentMethod: document.getElementById('edit-payment').value,
        status: document.getElementById('edit-status').value
    };

    await saveTicket(updated);
    closeModal('edit');
    renderTable();
}

async function openDeleteModal(id) {
    const tickets = await getTickets();
    currentTicket = tickets.find(t => t.id === id);
    if (!currentTicket) return;

    document.getElementById('delete-id-label').innerText = currentTicket.id;
    document.getElementById('delete-owner-label').innerText = currentTicket.ownerName;
    document.getElementById('delete-plate-label').innerText = currentTicket.vehiclePlate;
    document.getElementById('delete-slot-label').innerText = currentTicket.slot;
    document.getElementById('delete-type-label').innerText = currentTicket.vehicleType;

    document.getElementById('delete-modal').classList.remove('hidden');
}

async function confirmDelete() {
    if (!currentTicket) return;
    await deleteTicket(currentTicket.id);
    closeModal('delete');
    renderTable();
}

function closeModal(type) {
    document.getElementById(`${type}-modal`).classList.add('hidden');
    currentTicket = null;
}

// ─── Initialization ──────────────────────────────────────────────────────────

window.addEventListener('DOMContentLoaded', () => {
    renderTable();
    setInterval(renderTable, 60000); // Update durations every minute
});
