// Sidebar Trigger
document.addEventListener("DOMContentLoaded", function () {
    const options = {
        "edge": "left"
    }

    var elems = document.querySelectorAll(".sidenav");
    var instances = M.Sidenav.init(elems, options);
});

function clearFilters() {
    document.getElementsByName("checkbox").forEach(element => {
        element.checked = false;
    });
}

// Materialize Select
document.addEventListener('DOMContentLoaded', function () {
    var elems = document.querySelectorAll('select');
    var instances = M.FormSelect.init(elems);
});

// Search User
function searchUser() {
    searchBy = document.getElementById('searchBy').value
    searchConstraint = document.getElementById('searchConstraint').value
    
    fetch('/users/' + searchBy + '/' + searchConstraint, {
        method: 'GET'
    })
        .then(() => window.location.href = "/users/" + searchBy + '/' + searchConstraint);
}

// Filter Batch
function applyRoleFilters() {
    inputs = document.querySelectorAll('.filterCheckbox:checked')
    let roles = { 'roles': [] }
    inputs.forEach(ip => {
        roles['roles'].push(ip.value)
    });
    if(roles['roles'] == []){
        window.location.href = "/users"
    }
    fetch('/users', {
        method: 'GET'
    })
        .then(() => window.location.href = "/users?roles=" + roles['roles'])
}

// Back to users
function userBack() {
    window.location.href = "/users"
}

// Delete Category
function deleteCategory(categoryId) {
    fetch('/categories/' + categoryId, {
        method: 'DELETE'
    })
        .then(() => window.location.href = "/categories");
}

// Search Category
function searchCategory() {
    searchBy = document.getElementById('searchBy').value
    searchConstraint = document.getElementById('searchConstraint').value
    fetch('/categories/' + searchBy + '/' + searchConstraint, {
        method: 'GET'
    })
        .then(() => window.location.href = "/categories/" + searchBy + '/' + searchConstraint);
}

// Back to categories
function categoryBack() {
    window.location.href = "/categories"
}

// Filter Batch
function applyFilters() {
    inputs = document.querySelectorAll('.filterCheckbox:checked')
    let categories = { 'categories': [] }
    inputs.forEach(ip => {
        categories['categories'].push(ip.value)
    });
    fetch('/batches', {
        method: 'GET'
    })
        .then(() => window.location.href = "/batches?categories=" + categories['categories'])
}

// Close/Open Batch
function toggleBatch() {
    toggleSwitch = document.getElementById('batchSwitch')
    if (toggleSwitch.checked) {
        alert(Boolean(toggleSwitch.value))
    }
    else {
        alert(Boolean(''))
    }
}

function editBatch(batchId) {
    strength = document.getElementById('editBatchStrength' + batchId).value
    if (strength == 0) {
        strength = document.getElementById('editBatchStrength' + batchId).placeholder
    }
    fetch('/batches/' + batchId, {
        method: 'PUT',
        body: JSON.stringify({
            batchId: batchId,
            batchName: document.getElementById('editBatchName' + batchId).value,
            batchCourseId: document.getElementById('editBatchCourseId' + batchId).value,
            batchStrength: Number(strength),
            batchStatus: Boolean(document.getElementById('editBatchStatus' + batchId).value),
            batchStartDate: document.getElementById('editBatchStartDate' + batchId).placeholder,
            batchEndDate: document.getElementById('editBatchEndDate' + batchId).placeholder
        })
    })
        .then(() => window.location.href = "/batches");
}

// Delete Batch
function deleteBatch(batchId) {
    fetch('/batches/' + batchId, {
        method: 'DELETE'
    })
        .then(() => window.location.href = "/batches");
}

// Search Batch
function searchBatch(date) {
    if (date != 'date') {
        searchBy = document.getElementById('searchBy').value
        searchConstraint = document.getElementById('searchConstraint').value
    }
    else {
        searchBy = 'date'
        searchConstraint = document.getElementById('branchStartDateSearch').value
    }
    fetch('/batches/' + searchBy + '/' + searchConstraint, {
        method: 'GET'
    })
        .then(() => window.location.href = "/batches/" + searchBy + '/' + searchConstraint);
}

// Back to batches
function batchBack() {
    window.location.href = "/batches"
}

// Get date picked
function getDate() {
    console.log(document.getElementById('batchStartDate').value)
}

// Building Chart
function BuildChart(labels, values, chartTitle) {
    var ctx = document.getElementById("myChart").getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels, // Our labels
            datasets: [{
                fill: false,
                label: chartTitle, // Name the series
                data: values, // Our values
                borderColor: [ // Add custom color borders
                    'rgba(82, 171, 152, 1)'
                ],
                borderWidth: 2 // Specify bar border width
            }]
        },
        options: {
            responsive: true, // Instruct chart js to respond nicely.
            maintainAspectRatio: false, // Add to prevent default behavior of full-width/height 
            scales: {
                xAxes: [{
                   gridLines: {
                      display: false
                   }
                }],
                yAxes: [{
                    gridLines: {
                        display: false
                        },
                    ticks: {
                        beginAtZero: true
                    }
                }]
           }
        }
    });
    return myChart;
}

var table = document.getElementById('dataTable');
var json = []; // First row needs to be headers 
var headers = [];
for (var i = 0; i < table.rows[0].cells.length; i++) {
    headers[i] = table.rows[0].cells[i].innerHTML.toLowerCase().replace(/ /gi, '');
}

// Go through cells 
for (var i = 1; i < table.rows.length; i++) {
    var tableRow = table.rows[i];
    var rowData = {};
    for (var j = 0; j < tableRow.cells.length; j++) {
        rowData[headers[j]] = tableRow.cells[j].innerHTML;
    }

    json.push(rowData);
}

console.log(json);

// Map JSON values back to label array
var labels = json.map(function (e) {
    return e.date;
});
console.log(labels);

// Map JSON values back to values array
var values = json.map(function (e) {
    return e.logincount;
});
console.log(values);

var chart = BuildChart(labels, values, "Login Count of users");