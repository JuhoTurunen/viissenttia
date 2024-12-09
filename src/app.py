from collections import defaultdict
from flask import redirect, render_template, request, flash, send_file
from repositories.citation_repository import get_citations, create_citation, delete_citation
from config import app
from util import citation_data_to_class, get_citation_types, citation_class_to_bibtex_file,filter_search_results


@app.route("/")
def index():
    citations = get_citations()

    organized_citations = defaultdict(list)
    for citation in citations:
        organized_citations[citation.type].append(vars(citation))

    # Sort the citation types by the amount of citations in them
    desc_sorted = sorted(organized_citations.items(), key=lambda item: len(item[1]), reverse=True)
    asc_sorted = sorted(organized_citations.items(), key=lambda item: len(item[1]))

    # Alternate the items from descending and ascending sorted lists
    result = []
    while desc_sorted or asc_sorted:
        if desc_sorted:
            result.append(desc_sorted.pop(0))
        if asc_sorted:
            result.append(asc_sorted.pop(0))

    alternating_dict = dict(result)
    return render_template("index.html", citations=alternating_dict)


@app.route("/add_citation", methods=["POST", "GET"])
def add_citation():
    # Code for displaying add_citation page
    if request.method == "GET":
        return render_template("add_citation.html", citation_types=get_citation_types())

    # Code for handling citation form
    if request.method == "POST":

        # Turn citation form into a citation class
        citation_class = citation_data_to_class(request.form, True)

        # Error handling
        if isinstance(citation_class, str):
            flash(citation_class)
            return redirect("/add_citation")
        if not citation_class:
            flash("Citation type not found.")
            return redirect("/add_citation")
        base_key = citation_class.key

        citation_class.key = key_generator(base_key)

        # Attempt to create citation and then display result
        result = create_citation(citation_class)
        if result:
            flash("Successfully added citation.")
            return redirect("/add_citation")
        flash("Failed to add citation. Please try again later.")
        return redirect("/add_citation")
    return "Invalid request method", 405


def key_generator(base_key):
    # Finding the maximum suffix for the key
    existing_citations = get_citations()
    existing_keys = {citation.key for citation in existing_citations}

    # Suffix generation
    suffix = -1
    new_key = f"{base_key}{suffix}"
    while new_key in existing_keys:
        suffix -= 1
        new_key = f"{base_key}{suffix}"

    # Set suffix
    return new_key


@app.route("/download")
def download():
    citations = get_citations()
    citation_class_to_bibtex_file(citations)
    path = "./bibtex_files/citations.bib"
    return send_file(path, as_attachment=True)


@app.route("/search",methods=["POST"])
def search():
    citations = get_citations()
    search_parameters=request.form
    results=filter_search_results(citations,search_parameters["search_term"],search_parameters["search_field"])
    return results

@app.route("/delete_citation", methods=["POST"])
def delete_citation_route():
    citation_id = request.form.get("id")
    if citation_id:
        result = delete_citation(citation_id)
        if result:
            flash("Citation deleted successfully.")
        else:
            flash("Failed to delete citation. Please try again.")
    else:
        flash("Citation ID not provided.")
    return redirect("/")
