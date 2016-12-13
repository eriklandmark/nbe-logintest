/**
 * Created by erikl on 2016-12-03.
 */

function openTab(evt, cityName) {
    // Declare all variables
    var i, tabcontent, tablinks;

    // Get all elements with class="settingsTabItems" and hide them
    tabcontent = document.getElementsByClassName("settingsContentItems");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" activeTab", "");
    }

    // Show the current tab, and add an "active" class to the link that opened the tab
    document.getElementById(cityName).style.display = "flex";
    evt.currentTarget.className += " activeTab";
}

function openPage(evt, cityName) {
    // Declare all variables
    var i, tabcontent, tablinks;

    // Get all elements with class="barcontent" and hide them
    tabcontent = document.getElementsByClassName("barcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Get all elements with class="barlinks" and remove the class "active"
    tablinks = document.getElementsByClassName("barlinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the current tab, and add an "active" class to the link that opened the tab
    document.getElementById(cityName).style.display = "flex";
    evt.currentTarget.className += " active";
}


function loadPublicFiles(fileNames, fileSize) {
    var files = fileNames;
    var fileSizes = fileSize;

    var table = document.getElementById("publicFiles");

    for (i = 0; i < files.length; i++) {
        var file = document.createElement('tr');
        var tableFileName = document.createElement("td");
        var tableFileSizes = document.createElement("td");
        var tableFileType = document.createElement("td");

        tableFileName.className = "publicFileRows";
        tableFileSizes.className = "publicFileRows";
        tableFileType.className = "publicFileRows";

        var dwnldLink = document.createElement('a');
        dwnldLink.setAttribute("href", "/download/" + files[i]);
        dwnldLink.textContent = files[i];

        var fs = document.createElement('td');
        fs.textContent = fileSizes[i];

        var fType = document.createElement('td');
        var fileName = files[i];
        fType.textContent = fileName.substring(fileName.indexOf(".") + 1).toUpperCase();

        tableFileSizes.appendChild(fs);
        tableFileName.appendChild(dwnldLink);
        tableFileType.appendChild(fType);
        file.appendChild(tableFileName);
        file.appendChild(tableFileSizes);
        file.appendChild(tableFileType);
        table.appendChild(file);
    }
}

function loadPrivateFiles(fileNames, fileSize) {
    var files = fileNames;
    var fileSizes = fileSize

    var table = document.getElementById("privateFiles")

    for (i = 0; i < files.length; i++) {
        var file = document.createElement('tr');
        var tableFileName = document.createElement("td");
        var tableFileSizes = document.createElement("td");
        var tableFileType = document.createElement("td");

        tableFileName.className = "privateFileRows"
        tableFileSizes.className = "privateFileRows"

        var dwnldLink = document.createElement('a');
        dwnldLink.setAttribute("href", "/download/" + files[i]);
        dwnldLink.textContent = files[i];

        var fs = document.createElement('td');
        tableFileSizes.appendChild(fs);
        fs.textContent = fileSizes[i];

        var fType = document.createElement('td');
        var fileName = files[i];
        fType.textContent = fileName.substring(fileName.indexOf(".") + 1).toUpperCase();

        tableFileSizes.appendChild(fs);
        tableFileName.appendChild(dwnldLink);
        tableFileType.appendChild(fType);
        file.appendChild(tableFileName);
        file.appendChild(tableFileSizes);
        file.appendChild(tableFileType);
        table.appendChild(file);
    }
}