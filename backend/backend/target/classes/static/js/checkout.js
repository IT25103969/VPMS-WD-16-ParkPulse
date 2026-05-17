// ─── Checkout Page Logic ─────────────────────────────────────────────────────

let currentTicket = null;
let payMethod = 'Cash';
let discountType = 'percent';
let discountValue = 0;
let cardDetails = { name: '', number: '', expiry: '', cvv: '' };

// ─── Initialization ──────────────────────────────────────────────────────────

window.addEventListener('DOMContentLoaded', async () => {
    const params = new URLSearchParams(window.location.search);
    const id = params.get('id');
    
    if (!id) {
        window.location.href = 'tickets';
        return;
    }

    const tickets = await getTickets();
    currentTicket = tickets.find(t => t.id === id);

    if (!currentTicket || currentTicket.status === 'finished') {
        window.location.href = 'tickets';
        return;
    }

    payMethod = currentTicket.paymentMethod || 'Cash';
    renderCheckout();
});

// ─── Rendering ───────────────────────────────────────────────────────────────

function renderCheckout() {
    if (!currentTicket) return;

    const exitNow = currentTicket.exitTime || new Date().toISOString();
    const dur = getDurationInfo(currentTicket.entryTime, exitNow);
    const hours = Math.ceil(dur.totalMins / 60) || 1;
    const subtotal = hours * HOURLY_RATE;
    const tax = 0; // Defined to match original code structure without errors

    // Header
    document.getElementById('header-id').innerText = currentTicket.id;
    const statusEl = document.getElementById('header-status');
    statusEl.innerText = currentTicket.status;
    statusEl.className = `ml-auto text-xs px-2.5 py-1 rounded-full font-medium ${currentTicket.status === 'ongoing' ? 'bg-amber-500/20 text-amber-400' : 'bg-emerald-500/20 text-emerald-400'}`;

    // Vehicle Info
    document.getElementById('info-plate').innerText = currentTicket.vehiclePlate;
    document.getElementById('info-type').innerText = currentTicket.vehicleType;
    document.getElementById('info-slot').innerText = currentTicket.slot;

    const infoGrid = document.getElementById('info-grid');
    infoGrid.innerHTML = '';
    const details = [
        { icon: 'user', label: 'Owner', value: currentTicket.ownerName },
        { icon: 'tag', label: 'Ticket ID', value: currentTicket.id },
        { icon: 'calendar-days', label: 'Entry', value: formatDate(currentTicket.entryTime) },
        { icon: 'calendar-days', label: 'Exit', value: formatDate(exitNow) },
        { icon: 'clock', label: 'Duration', value: dur.label },
        { icon: 'map-pin', label: 'Slot', value: currentTicket.slot },
    ];
    details.forEach(d => {
        const div = document.createElement('div');
        div.className = 'rounded-xl p-3 bg-gray-50 dark:bg-gray-700/40';
        div.innerHTML = `
            <div class="flex items-center gap-1.5 text-xs mb-1 text-gray-500 dark:text-gray-400">
                <i data-lucide="${d.icon}" size="13"></i> ${d.label}
            </div>
            <p class="text-sm font-medium">${d.value}</p>
        `;
        infoGrid.appendChild(div);
    });

    // Billing
    const discountAmt = calculateDiscount(subtotal);
    const total = parseFloat((subtotal - discountAmt).toFixed(2));

    const billingList = document.getElementById('billing-list');
    billingList.innerHTML = `
        <div class="flex items-center justify-between">
            <span class="text-sm text-gray-500 dark:text-gray-400">Parking (${hours}h × රු ${HOURLY_RATE}/hr)</span>
            <span class="text-sm">රු ${subtotal.toFixed(2)}</span>
        </div>
    `;
    if (discountAmt > 0) {
        billingList.innerHTML += `
            <div class="flex items-center justify-between">
                <span class="text-sm text-gray-500 dark:text-gray-400">Discount (${discountType === 'percent' ? discountValue + '%' : 'flat'})</span>
                <span class="text-sm text-emerald-400">− රු ${discountAmt.toFixed(2)}</span>
            </div>
        `;
    }
    billingList.innerHTML += `
        <div class="border-t border-gray-100 dark:border-gray-700 pt-3 mt-1 flex items-center justify-between">
            <span class="text-sm font-semibold">Total</span>
            <span class="text-lg font-semibold text-emerald-400">රු ${total.toFixed(2)}</span>
        </div>
    `;

    // Right Sidebar Summary
    document.getElementById('total-amount').innerText = `රු ${total.toFixed(2)}`;
    if (discountAmt > 0) {
        document.getElementById('original-amount').innerText = `රු ${(subtotal + tax).toFixed(2)}`;
        document.getElementById('original-amount').classList.remove('hidden');
        document.getElementById('discount-info').innerText = `You save රු ${discountAmt.toFixed(2)}`;
        document.getElementById('discount-info').classList.remove('hidden');
    } else {
        document.getElementById('original-amount').classList.add('hidden');
        document.getElementById('discount-info').classList.add('hidden');
    }

    // Payment Methods UI
    updatePaymentUI();

    // Buttons
    document.getElementById('print-receipt-btn').onclick = () => printTicket(currentTicket, total);

    lucide.createIcons();
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

function formatDate(iso) {
    return new Date(iso).toLocaleString("en-US", {
        weekday: "short",
        month: "short",
        day: "numeric",
        hour: "2-digit",
        minute: "2-digit",
    });
}

function getDurationInfo(entry, exit) {
    const start = new Date(entry).getTime();
    const end = new Date(exit).getTime();
    const totalMins = Math.floor((end - start) / 60000);
    const h = Math.floor(totalMins / 60);
    const m = totalMins % 60;
    return { label: `${h}h ${m}m`, totalMins };
}

function calculateDiscount(subtotal) {
    const v = parseFloat(discountValue) || 0;
    if (discountType === 'percent') return parseFloat(((v / 100) * subtotal).toFixed(2));
    return parseFloat(Math.min(v, subtotal).toFixed(2));
}

// ─── Actions ─────────────────────────────────────────────────────────────────

function selectPayment(method) {
    payMethod = method;
    updatePaymentUI();
    if (method === 'Card' && !cardDetails.number) {
        openCardDialog();
    }
}

function updatePaymentUI() {
    document.querySelectorAll('.pay-btn').forEach(btn => {
        const id = btn.id.split('-')[1];
        if (id === payMethod) {
            btn.className = 'pay-btn flex items-center gap-3 px-4 py-3 rounded-xl border text-sm transition border-blue-500 bg-blue-500/10 text-blue-400';
            btn.querySelector('.check-icon').classList.remove('hidden');
        } else {
            btn.className = 'pay-btn flex items-center gap-3 px-4 py-3 rounded-xl border text-sm transition border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700/50';
            btn.querySelector('.check-icon').classList.add('hidden');
        }
    });

    const isCard = payMethod === 'Card';
    const cardSaved = !!cardDetails.number;

    document.getElementById('enter-card-btn').classList.toggle('hidden', !isCard || cardSaved);
    document.getElementById('card-saved-indicator').classList.toggle('hidden', !isCard || !cardSaved);
    
    if (cardSaved) {
        document.getElementById('saved-card-number').innerText = `•••• ${cardDetails.number.slice(-4)}`;
    }

    const confirmBtn = document.getElementById('confirm-pay-btn');
    const warning = document.getElementById('payment-warning');
    if (isCard && !cardSaved) {
        confirmBtn.disabled = true;
        warning.classList.remove('hidden');
    } else {
        confirmBtn.disabled = false;
        warning.classList.add('hidden');
    }
}

function setDiscountType(type) {
    discountType = type;
    document.getElementById('discount-percent-btn').className = type === 'percent' ? 'flex-1 py-1.5 rounded-lg text-xs transition border bg-blue-600 text-white border-blue-600' : 'flex-1 py-1.5 rounded-lg text-xs transition border border-gray-200 dark:border-gray-600 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700';
    document.getElementById('discount-flat-btn').className = type === 'flat' ? 'flex-1 py-1.5 rounded-lg text-xs transition border bg-blue-600 text-white border-blue-600' : 'flex-1 py-1.5 rounded-lg text-xs transition border border-gray-200 dark:border-gray-600 text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700';
    document.getElementById('discount-symbol').innerText = type === 'percent' ? '%' : 'Rs';
    renderCheckout();
}

document.getElementById('discount-value').addEventListener('input', (e) => {
    discountValue = e.target.value;
    renderCheckout();
});

// ─── Card Dialog ─────────────────────────────────────────────────────────────

function openCardDialog() {
    document.getElementById('card-modal').classList.remove('hidden');
}

function closeCardDialog() {
    document.getElementById('card-modal').classList.add('hidden');
}

function saveCard() {
    const name = document.getElementById('card-name').value;
    const number = document.getElementById('card-number').value.replace(/\s/g, '');
    const expiry = document.getElementById('card-expiry').value;
    const cvv = document.getElementById('card-cvv').value;

    let hasError = false;
    if (!name.trim()) { document.getElementById('err-name').classList.remove('hidden'); hasError = true; } else { document.getElementById('err-name').classList.add('hidden'); }
    if (number.length !== 16) { document.getElementById('err-number').classList.remove('hidden'); hasError = true; } else { document.getElementById('err-number').classList.add('hidden'); }
    if (!/^\d{2}\/\d{2}$/.test(expiry)) { document.getElementById('err-expiry').classList.remove('hidden'); hasError = true; } else { document.getElementById('err-expiry').classList.add('hidden'); }
    if (cvv.length < 3) { document.getElementById('err-cvv').classList.remove('hidden'); hasError = true; } else { document.getElementById('err-cvv').classList.add('hidden'); }

    if (hasError) return;

    cardDetails = { name, number, expiry, cvv };
    closeCardDialog();
    updatePaymentUI();
}

// Visual Card Preview Logic
document.querySelectorAll('.card-input').forEach(input => {
    input.addEventListener('input', () => {
        const name = document.getElementById('card-name').value || 'YOUR NAME';
        let number = document.getElementById('card-number').value || '•••• •••• •••• ••••';
        const expiry = document.getElementById('card-expiry').value || 'MM/YY';

        // Auto-format number and expiry
        if (input.id === 'card-number') {
            input.value = input.value.replace(/\D/g, '').slice(0, 16).replace(/(.{4})/g, '$1 ').trim();
            number = input.value;
        }
        if (input.id === 'card-expiry') {
            const digits = input.value.replace(/\D/g, '').slice(0, 4);
            if (digits.length >= 3) input.value = digits.slice(0, 2) + '/' + digits.slice(2);
            else input.value = digits;
        }

        document.getElementById('card-preview-name').innerText = name.toUpperCase();
        document.getElementById('card-preview-number').innerText = number;
        document.getElementById('card-preview-expiry').innerText = expiry;
    });
});

// ─── Payment Confirmation ────────────────────────────────────────────────────

async function confirmPayment() {
    // Calling the new backend endpoint for calculation and persistence
    const result = await checkoutTicket(currentTicket.id, payMethod);

    if (!result) {
        alert("Checkout failed. Please try again.");
        return;
    }

    // Show success screen
    document.getElementById('checkout-content').classList.add('hidden');
    document.getElementById('success-screen').classList.remove('hidden');
    document.getElementById('success-msg').innerText = `Ticket ${currentTicket.id} has been settled successfully.`;
    document.getElementById('success-total').innerText = `රු ${result.amount.toFixed(2)}`;

    document.getElementById('success-print-btn').onclick = () => printTicket(result, result.amount);

    // Redirect after delay - matching 1.8s from React version
    setTimeout(() => {
        window.location.href = 'tickets';
    }, 1800);
}
