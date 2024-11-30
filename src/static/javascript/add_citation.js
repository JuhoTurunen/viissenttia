const form = document.getElementById("citation_form");;
let citation_type = document.getElementById('citation_type');

function load_dynamics() {
    let input_fields = form.getElementsByTagName("textarea");
    let multiple_containers = document.getElementsByClassName('multiple');
    let opt_btn = document.getElementById('opt_btn');
    
    Array.prototype.forEach.call(input_fields, input_field => {
        input_field.style.height = input_field.scrollHeight + 'px';
        input_field.addEventListener('input', function () {
            this.style.height = 'auto';
            this.style.height = this.scrollHeight + 'px';
        });
    });

    Array.prototype.forEach.call(multiple_containers, multiple_container => {
        const multiple_button = multiple_container.getElementsByTagName("button")[0];
        multiple_button.addEventListener("click", () => {
            const multiple_input = multiple_container.getElementsByTagName("textarea")[0];
            let input_clone = multiple_input.cloneNode();
            input_clone.value = "";
            multiple_container.insertBefore(input_clone, multiple_button);
        });
    });

    opt_btn.addEventListener("click", () => {
        let opt_contianer_classlist = opt_btn.parentElement.classList;
        if (opt_contianer_classlist.contains("hidden")) {
            opt_contianer_classlist.remove("hidden")
        } else {
            opt_contianer_classlist.add("hidden")
        }
    });
}

citation_type.addEventListener('change', function () {
    var selected_option = this.value;
    var dynamic_form = document.getElementById('dynamic_form');

    fetch("static/citation_forms/" + selected_option + '.html')
        .then(response => response.text())
        .then(data => {
            dynamic_form.innerHTML = data;
            load_dynamics()
        })
        .catch(error => {
            console.error('Error loading form:', error);
        });
    
});

window.addEventListener('load', function () {
    citation_type.dispatchEvent(new Event('change'));
});