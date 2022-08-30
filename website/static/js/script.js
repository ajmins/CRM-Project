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

//editing category
function editCategory(categoryId){
    comments = document.getElementById('editCategoryComments' + categoryId).value
    if(comments == 0){
        comments = document.getElementById('editCategoryComments' + categoryId).placeholder
    }
    fetch('/categories/' + categoryId, {
        method: 'PUT',
        body: JSON.stringify({
            categoryId: categoryId,
            categoryName: document.getElementById('editCategoryName' + categoryId).placeholder,
            categoryStatus: Boolean(document.getElementById('editCategoryStatus' + categoryId).value),
            categoryComments: comments
        })
    })
    .then(() => window.location.href="/categories");
}

// Back to categories
function categoryBack(){
    window.location.href="/categories"
}

// Delete Qualification
function deleteQualification(qualificationId){
    fetch('/qualification/' + qualificationId, {
        method: 'DELETE'
    })
    .then(() => window.location.href="/qualification");
}

// Search Qualification
function searchQualification(){
    searchBy = document.getElementById('searchBy').value
    searchConstraint = document.getElementById('searchConstraint').value
    fetch('/qualification/' + searchBy + '/' + searchConstraint, {
        method: 'GET'
    })
    .then(() => window.location.href="/qualification/" + searchBy + '/' + searchConstraint);
}

//editing Qualification -- doubt
function editQualification(qualificationId){
    comments = document.getElementById('editCategoryComments' + qualificationId).value
    if(comments == 0){
        comments = document.getElementById('editCategoryComments' + qualificationId).placeholder
    }
    fetch('/qualification/' + qualificationId, {
        method: 'PUT',
        body: JSON.stringify({
            qualificationId: qualificationId,
            qualificationName: document.getElementById('editCategoryName' + qualificationId).placeholder,
            qualificationStatus: Boolean(document.getElementById('editCategoryStatus' + qualificationId).value),
        })
    })
    .then(() => window.location.href="/qualification");
}

// Back to Qualification
function categoryBack(){
    window.location.href="/qualification"
}