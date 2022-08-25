const form = document.getElementById("form");
var username =  document.getElementById("username");
var password = document.getElementById("password");

form.addEventListener('submit', (e) => {
  e.preventDefault();
  console.log("Inside eventListener");
  Verify();
});

function setErrorFor(input, message) {
  const formControl = input.parentElement;
  const small = formControl.querySelector("small");

  small.innerText = message;

  formControl.className = "form-control err";
}

function setSuccessFor(input) {
  const formControl = input.parentElement;
  formControl.className = "form-control success";
}


function Verify() {
  var userRef = "SuperBob";
  var passRef = "12RobotoLove";
  var userValue =  username.value.trim();
  var passValue = password.value.trim();
    
  if(userValue === '') {
    setErrorFor(username,'Name cannot be blank');
    return false;
  }else if(userValue !== userRef){
    setErrorFor(username, 'Invalid Username');
    return false;
  }else {
    setSuccessFor(username);
    if(passValue === '') {
      setErrorFor(password,'Password cannot be blank');
      return false;
    }else if(passValue !== passRef) {
    setErrorFor(password,'Incorrect Password');
    return false;
    }else {
      return true
    }
  }
};