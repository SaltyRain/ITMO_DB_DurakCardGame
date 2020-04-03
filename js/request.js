function request(params, file, handler) {
    let request = new XMLHttpRequest();

    //формирование строки
    let body = '';
    for (let [key, value] of Object.entries(params)) {
        body += (key + '=' + value + '&'); // login=kek&password=kek&gameid=3&func=choosemove Преобразует для отправки данных на сервер
    }
    request.open("POST", file, true);
    request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    request.send(body); // отправляет на сервер

    // по результатам пришедших данных вызывается обработчик события
    request.onload = function() {
        handler(request, params);
    };
}