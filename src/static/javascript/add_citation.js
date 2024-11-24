let opt_btn = document.getElementById('opt_btn');
opt_btn.addEventListener("click", opt_field_revealer);

function opt_field_revealer() {
    let opt_contianer_classlist = opt_btn.parentElement.classList;
    if (opt_contianer_classlist.contains("hidden")) {
        opt_contianer_classlist.remove("hidden")
    } else {
        opt_contianer_classlist.add("hidden")
    }
}