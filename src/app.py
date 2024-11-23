from flask import redirect, render_template, request, flash, send_from_directory,send_file
from repositories.citation_repository import get_citations, create_citation
from config import app
from util import citation_data_to_class, citation_data_to_bibtex_file




@app.route("/")
def index():
    return render_template("index.html")


@app.route("/add_citation", methods=["POST","GET"])
def add_citation():
    # Code for displaying add_citation page
    if request.method == "GET":
        return render_template("add_citation.html")
    
    # Code for handling citation form
    if request.method == "POST":
        
        # Turn citation form into a citation class
        citation_class = citation_data_to_class(request.form)
        if not citation_class:
            flash(f"Citation type not found.")
            return redirect("/add_citation")
        
        # Attempt to create citation and then display result
        result = create_citation(citation_class)
        if result:
            flash("Successfully added citation.")
            return redirect("/add_citation")
        #flash(result.get("error", "Failed to add citation. Please try again later."), "error") Commented away for testing
        flash("Failed to add citation. Please try again later.")
        return redirect("/add_citation")


@app.route("/view_citations", methods=["GET","POST"])
def view():
    
    citations = get_citations()
    return render_template("view_citations.html", citations=citations)

        


@app.route('/download')
def download():
    citations = get_citations()
    citation_data_to_bibtex_file(citations)
    path = './bibtex_files/citations.bib'
    return send_file(path, as_attachment=True)


