const form = document.getElementById("citation_form");
let input_fields = form.getElementsByTagName("textarea")

window.addEventListener('load', function () {
    Array.prototype.forEach.call(input_fields, input_field => {
        input_field.style.height = input_field.scrollHeight + 'px';
    });
});

Array.prototype.forEach.call(input_fields, input_field => {
    input_field.addEventListener('input', function () {
        this.style.height = 'auto';
        this.style.height = this.scrollHeight + 'px';
    });
});

let author_bth = document.getElementById('add_author');
author_bth.addEventListener("click", () => {
    author_field = document. createElement("textarea");
    author_field.rows = "1";
    author_field.name = "authors";
    author_bth.parentElement.insertBefore(author_field, author_bth);
});

let opt_btn = document.getElementById('opt_btn');
opt_btn.addEventListener("click", () => {
    let opt_contianer_classlist = opt_btn.parentElement.classList;
    if (opt_contianer_classlist.contains("hidden")) {
        opt_contianer_classlist.remove("hidden")
    } else {
        opt_contianer_classlist.add("hidden")
    }
});