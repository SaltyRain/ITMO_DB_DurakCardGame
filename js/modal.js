function showModal(id) {
    var modal = document.getElementById(id);
    var overlay = document.getElementsByClassName('modal-overlay')[0];
    overlay.style['z-index'] = 1002;
    overlay.style.display = 'block';
    overlay.style.opacity = 0.5;
    modal.style['z-index'] = 1003;
    modal.style.display = 'block';
    modal.style.opacity = 1;
    modal.style.bottom = '0px';
}