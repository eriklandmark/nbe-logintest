/**
 * Created by erikl on 2016-12-03.
 */

function openTab(evt, cityName) {
    // Declare all variables
    var i, tabcontent, tablinks;

    // Get all elements with class="tabcontent" and hide them
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("barlinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the current tab, and add an "active" class to the link that opened the tab
    document.getElementById(cityName).style.display = "flex";
    evt.currentTarget.className += " active";
}

function loadFiles(fileList) {
    files = fileList;

    list = document.getElementById("privateFiles");

    for (i = 0; i < files.length; i++) {
        listItem = document.createElement('li');
        list.appendChild(listItem);
        dwnldLink = document.createElement('a');
        dwnldLink.setAttribute("href", "/download/" + files[i].substring(files[i].lastIndexOf("/") + 1));
        dwnldLink.textContent = files[i].substring(files[i].lastIndexOf("/") + 1);
        listItem.appendChild(dwnldLink);
    }
}

$(function () {
    // 6 create an instance when the DOM is ready
    $('#fileTree').jstree();
    // 7 bind to events triggered on the tree
    $('#fileTree').on("changed.fileTree", function (e, data) {
        console.log(data.selected);

    });
});