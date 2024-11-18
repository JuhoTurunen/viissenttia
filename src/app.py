from flask import redirect, render_template, request, flash
from repositories.citation_repository import get_citations, create_citation
from config import app
from util import citation_data_to_class




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
    print(citations[1].__str__())
    return render_template("view_citations.html", citations=citations)
