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
document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('select');
    var instances = M.FormSelect.init(elems);
  });

// Delete Category
function deleteCategory(categoryId){
    fetch('/categories/' + categoryId, {
        method: 'DELETE'
    })
    .then(() => window.location.href="/categories");
}

// Search Category
function searchCategory(){
    searchBy = document.getElementById('searchBy').value
    searchConstraint = document.getElementById('searchConstraint').value
    fetch('/categories/' + searchBy + '/' + searchConstraint, {
        method: 'GET'
    })
    .then(() => window.location.href="/categories/" + searchBy + '/' + searchConstraint);
}

// Back to categories
function categoryBack(){
    window.location.href="/categories"
}

// Close/Open Batch
function toggleBatch(){
    toggleSwitch = document.getElementById('batchSwitch')
    if (toggleSwitch.checked) {
        alert(Boolean(toggleSwitch.value))
    } 
    else {
        alert(Boolean(''))
    }
}

function editBatch(batchId){
    strength = document.getElementById('editBatchStrength' + batchId).value
    if(strength == 0){
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
    .then(() => window.location.href="/batches");
}

// Delete Batch
function deleteBatch(batchId){
    fetch('/batches/' + batchId, {
        method: 'DELETE'
    })
    .then(() => window.location.href="/batches");
}

// Search Batch
function searchBatch(date){
    if (date != 'date'){
        searchBy = document.getElementById('searchBy').value
        searchConstraint = document.getElementById('searchConstraint').value
    }
    else{
        searchBy = 'date'
        searchConstraint = document.getElementById('branchStartDateSearch').value
    }
    fetch('/batches/' + searchBy + '/' + searchConstraint, {
        method: 'GET'
    })
    .then(() => window.location.href="/batches/" + searchBy + '/' + searchConstraint);
}

// Back to batches
function batchBack(){
    window.location.href="/batches"
}

// Get date picked
function getDate(){
    console.log(document.getElementById('batchStartDate').value)
}
    