const API_BASE_URL = 'http://localhost:8081/api/staff';

async function getStaffList(search = '', status = 'all') {
  try {
    const url = new URL(API_BASE_URL);
    if (search) url.searchParams.append('search', search);
    if (status) url.searchParams.append('status', status);
    
    const response = await fetch(url);
    if (!response.ok) throw new Error('Failed to fetch staff list');
    return await response.json();
  } catch (error) {
    console.error('Error fetching staff list:', error);
    return [];
  }
}

async function getStaffStats() {
  try {
    const response = await fetch(`${API_BASE_URL}/stats`);
    if (!response.ok) throw new Error('Failed to fetch staff stats');
    return await response.json();
  } catch (error) {
    console.error('Error fetching staff stats:', error);
    return { total: 0, active: 0, offDuty: 0 };
  }
}

async function getStaffById(id) {
  try {
    const response = await fetch(`${API_BASE_URL}/${id}`);
    if (!response.ok) throw new Error('Failed to fetch staff member');
    return await response.json();
  } catch (error) {
    console.error(`Error fetching staff member ${id}:`, error);
    return null;
  }
}

async function deleteStaff(id) {
  try {
    const response = await fetch(`${API_BASE_URL}/${id}`, {
      method: 'DELETE'
    });
    if (!response.ok) throw new Error('Failed to delete staff member');
  } catch (error) {
    console.error(`Error deleting staff member ${id}:`, error);
  }
}

async function addStaff(formData) {
  try {
    const response = await fetch(API_BASE_URL, {
      method: 'POST',
      body: formData // Sending FormData directly for multipart/form-data
    });
    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.message || 'Failed to add staff member');
    }
    return await response.json();
  } catch (error) {
    console.error('Error adding staff member:', error);
    throw error;
  }
}

async function updateStaff(id, formData) {
  try {
    const response = await fetch(`${API_BASE_URL}/${id}`, {
      method: 'PUT',
      body: formData // Sending FormData directly
    });
    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.message || 'Failed to update staff member');
    }
    return await response.json();
  } catch (error) {
    console.error(`Error updating staff member ${id}:`, error);
    throw error;
  }
}

