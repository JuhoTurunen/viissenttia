let citations = document.getElementsByClassName('citation');
let citation_open = false;

Array.prototype.forEach.call(citations, citation => {
    let citation_brief = citation.getElementsByClassName("citation_brief")[0];
    let popup = citation.getElementsByClassName("popup")[0];
    citation_brief.addEventListener("click", () => {
        if (!citation_open) {
            citation_open = true;
            popup.classList.add("shown");
        }
    });
    let close_btn = popup.getElementsByTagName("button")[0];

    close_btn.addEventListener("click", () => {
        citation_open = false;
        popup.classList.remove("shown");
    });
});