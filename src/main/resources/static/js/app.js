document.addEventListener('alpine:init', () => {
    Alpine.data('themeData', () => ({
        isDark: Alpine.$persist(false).as('isDark'),
        toggleTheme() {
            this.isDark = !this.isDark;
        }
    }));

    Alpine.data('sidebarData', () => ({
        sidebarOpen: Alpine.$persist(true).as('sidebarOpen'),
        parkingExpanded: Alpine.$persist(true).as('parkingExpanded'),
        toggleSidebar() {
            this.sidebarOpen = !this.sidebarOpen;
        },
        toggleParking() {
            if (!this.sidebarOpen) {
                this.sidebarOpen = true;
                this.parkingExpanded = true;
            } else {
                this.parkingExpanded = !this.parkingExpanded;
            }
        }
    }));

    Alpine.data('dashboardData', () => ({
        dashActiveZone: 0,
        slotsPerZone: 30,
        stats: [
            { label: 'Total Slots', value: window.backendData.stats.totalSlots || '0', color: 'text-foreground' },
            { label: 'Available', value: window.backendData.stats.availableSlots || '0', color: 'text-emerald-500' },
            { label: 'Occupied', value: window.backendData.stats.occupiedSlots || '0', color: 'text-red-500' },
            { label: 'Occupancy', value: (window.backendData.stats.occupancyRate || '0') + '%', color: 'text-blue-500' },
        ],
        zones: window.backendData.zones || [],
        zoneStats: window.backendData.stats.zoneStats || [],
        zoneSlots(zoneId) {
            return window.backendData.slots.filter(s => s.zoneId === zoneId);
        },
        scrollToZone(index) {
            const container = document.getElementById('slotMapContainer');
            if (container) {
                container.scrollTo({ left: index * container.offsetWidth, behavior: 'smooth' });
                this.dashActiveZone = index;
            }
        },
        handleScroll(e) {
            const el = e.currentTarget;
            this.dashActiveZone = Math.round(el.scrollLeft / el.offsetWidth);
        }
    }));

    Alpine.data('analyticsData', () => ({
        statCards: [
            { label: 'Total Parked', value: window.backendData.stats.occupiedSlots || '0', sub: 'of ' + (window.backendData.stats.totalSlots || '0') + ' slots', icon: 'car', iconBg: 'bg-blue-500/10', iconColor: 'text-blue-500', bar: window.backendData.stats.occupancyRate, barColor: 'bg-blue-500' },
            { label: 'Occupancy Rate', value: (window.backendData.stats.occupancyRate || '0') + '%', sub: 'live utilisation', icon: 'trending-up', iconBg: 'bg-emerald-500/10', iconColor: 'text-emerald-500', bar: window.backendData.stats.occupancyRate, barColor: 'bg-emerald-500' },
            { label: 'Active Zones', value: (window.backendData.zones || []).length, sub: (window.backendData.zones || []).length + ' zones configured', icon: 'map-pin', iconBg: 'bg-purple-500/10', iconColor: 'text-purple-500', bar: 100, barColor: 'bg-purple-500' },
            { label: 'Vehicle Types', value: (window.backendData.stats.vehicleTypeData || []).length, sub: 'of 7 possible', icon: 'activity', iconBg: 'bg-amber-500/10', iconColor: 'text-amber-400', bar: 85, barColor: 'bg-amber-400' },
        ],
        vehicleTypeData: window.backendData.stats.vehicleTypeData || [],
        colors: ['#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#06b6d4'],
        initCharts() {
            // Weekly Traffic Chart (Mocked as in original)
            const ctxWeekly = document.getElementById('weeklyTrafficChart').getContext('2d');
            new Chart(ctxWeekly, {
                type: 'line',
                data: {
                    labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    datasets: [{
                        label: 'Allocations',
                        data: [65, 59, 80, 81, 56, 55, 40],
                        borderColor: '#3b82f6',
                        backgroundColor: 'rgba(59, 130, 246, 0.1)',
                        fill: true,
                        tension: 0.4
                    }, {
                        label: 'Releases',
                        data: [45, 48, 60, 70, 45, 50, 30],
                        borderColor: '#10b981',
                        backgroundColor: 'rgba(16, 185, 129, 0.1)',
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, grid: { color: 'rgba(156, 163, 175, 0.1)' } }, x: { grid: { display: false } } } }
            });

            // Vehicle Breakdown Chart
            const ctxVehicle = document.getElementById('vehicleBreakdownChart').getContext('2d');
            new Chart(ctxVehicle, {
                type: 'doughnut',
                data: {
                    labels: this.vehicleTypeData.map(d => d.name),
                    datasets: [{
                        data: this.vehicleTypeData.map(d => d.value),
                        backgroundColor: this.colors,
                        borderWidth: 0
                    }]
                },
                options: { cutout: '75%', responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } } }
            });

            // Zone Breakdown Chart
            const ctxZone = document.getElementById('zoneBreakdownChart').getContext('2d');
            new Chart(ctxZone, {
                type: 'bar',
                data: {
                    labels: this.zoneStats.map(z => z.name),
                    datasets: [
                        { label: 'Available', data: this.zoneStats.map(z => z.available), backgroundColor: '#10b981' },
                        { label: 'Occupied', data: this.zoneStats.map(z => z.occupied), backgroundColor: '#ef4444' },
                        { label: 'Reserved', data: this.zoneStats.map(z => z.reserved), backgroundColor: '#f59e0b' },
                        { label: 'Maintenance', data: this.zoneStats.map(z => z.maintenance), backgroundColor: '#fb923c' }
                    ]
                },
                options: { responsive: true, maintainAspectRatio: false, scales: { x: { stacked: true, grid: { display: false } }, y: { stacked: true, grid: { color: 'rgba(156, 163, 175, 0.1)' } } }, plugins: { legend: { display: false } } }
            });
        }
    }));

    Alpine.data('vehiclesData', () => ({
        search: '',
        filter: 'all',
        allVehicles: window.backendData.slots.filter(s => s.status === 'occupied' || s.status === 'reserved').map(s => ({
            id: s.id,
            number: s.number,
            status: s.status,
            zoneName: (window.backendData.zones.find(z => z.id === s.zoneId) || {}).name || s.zoneId,
            vehicle: s.vehicle || { licensePlate: 'N/A', owner: 'Reserved', type: 'N/A', entryTime: 'N/A', phone: 'N/A', email: 'N/A', duration: 'N/A' }
        })),
        get filteredVehicles() {
            return this.allVehicles.filter(v => {
                const matchesFilter = this.filter === 'all' || v.status === this.filter;
                const matchesSearch = !this.search || 
                    v.vehicle.licensePlate.toLowerCase().includes(this.search.toLowerCase()) ||
                    v.vehicle.owner.toLowerCase().includes(this.search.toLowerCase()) ||
                    v.zoneName.toLowerCase().includes(this.search.toLowerCase());
                return matchesFilter && matchesSearch;
            });
        },
        get counts() {
            return {
                all: this.allVehicles.filter(v => v.status === 'occupied').length + this.allVehicles.filter(v => v.status === 'reserved').length,
                occupied: this.allVehicles.filter(v => v.status === 'occupied').length,
                reserved: this.allVehicles.filter(v => v.status === 'reserved').length
            };
        },
        editVehicle(slot) {
            window.location.href = `entry?slot=${slot.number}`;
        },
        deleteVehicle(slot) {
            if (confirm(`Are you sure you want to release/delete vehicle ${slot.vehicle.licensePlate} from slot ${slot.number}?`)) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'action?action=release_vehicle';
                
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'slotId';
                input.value = slot.id;
                form.appendChild(input);
                
                document.body.appendChild(form);
                form.submit();
            }
        }
    }));

    Alpine.data('entryData', () => ({
        slotNumber: window.backendData.slotNumber || 'A1',
        slotId: (window.backendData.slots.find(s => s.number === window.backendData.slotNumber) || {}).id,
        isEdit: (window.backendData.slots.find(s => s.number === (window.backendData.slotNumber || 'A1'))?.status === 'occupied'),
        vehicleTypes: ['Sedan', 'SUV', 'Hatchback', 'Truck', 'Motorcycle', 'Motorbike', 'Van'],
        formData: {
            licensePlate: (window.backendData.slots.find(s => s.number === (window.backendData.slotNumber || 'A1'))?.vehicle?.licensePlate) || '',
            type: (window.backendData.slots.find(s => s.number === (window.backendData.slotNumber || 'A1'))?.vehicle?.type) || 'Sedan',
            owner: (window.backendData.slots.find(s => s.number === (window.backendData.slotNumber || 'A1'))?.vehicle?.owner) || '',
            phone: (window.backendData.slots.find(s => s.number === (window.backendData.slotNumber || 'A1'))?.vehicle?.phone) || '',
            email: (window.backendData.slots.find(s => s.number === (window.backendData.slotNumber || 'A1'))?.vehicle?.email) || '',
        },
        submitEntry() {
            if (!this.slotId) {
                alert('Invalid slot selection');
                return;
            }
            
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'action?action=enter_vehicle';
            
            const fields = {
                slotId: this.slotId,
                licensePlate: this.formData.licensePlate,
                type: this.formData.type,
                owner: this.formData.owner,
                phone: this.formData.phone,
                email: this.formData.email
            };
            
            for (const key in fields) {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = key;
                input.value = fields[key];
                form.appendChild(input);
            }
            
            document.body.appendChild(form);
            form.submit();
        }
    }));

    Alpine.data('checkoutData', () => ({
        released: false,
        slotNumber: window.backendData.slotNumber || 'A1',
        slotId: (window.backendData.slots.find(s => s.number === window.backendData.slotNumber) || {}).id,
        vehicle: window.backendData.vehicle,
        entryTime: (window.backendData.vehicle || {}).entryTime || 'N/A',
        exitTime: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
        durationLabel: (window.backendData.vehicle || {}).duration || '0h 0m',
        rate: 2.50,
        totalCost: '0.00',
        get summaryRows() {
            const slot = window.backendData.slots.find(s => s.number === this.slotNumber) || {};
            const zone = window.backendData.zones.find(z => z.id === slot.zoneId) || {};
            return [
                { label: 'Slot', value: this.slotNumber },
                { label: 'Zone', value: zone.name || 'N/A' },
                { label: 'Vehicle Type', value: (this.vehicle || {}).type || 'N/A' },
                { label: 'License Plate', value: (this.vehicle || {}).licensePlate || 'N/A' },
                { label: 'Owner', value: (this.vehicle || {}).owner || 'N/A' },
                { label: 'Entry Time', value: this.entryTime },
                { label: 'Exit Time', value: this.exitTime },
                { label: 'Duration', value: this.durationLabel },
            ];
        },
        releaseVehicle() {
            if (!this.slotId) return;
            
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'action?action=release_vehicle';
            
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'slotId';
            input.value = this.slotId;
            form.appendChild(input);
            
            document.body.appendChild(form);
            form.submit();
        }
    }));
});
