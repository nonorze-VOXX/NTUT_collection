//write your script here
function changeBackGround(newColor) {
    target = document.getElementById("lab5Table");
    target.style.backgroundColor = newColor;
}
function changeWidth(newWidth) {
    target = document.getElementById("lab5Table");
    target.style.width = newWidth + "px";
}
function changeBorder(newBorder) {
    target = document.getElementById("lab5Table");
    target.style.borderSpacing = newBorder + "px";
}


function Reset() {
    changeWidth(300);
    changeBackGround('wheat');
    changeBorder(5);
}
