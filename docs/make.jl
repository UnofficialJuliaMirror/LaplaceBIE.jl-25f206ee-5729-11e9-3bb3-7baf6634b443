using LaplaceBIE
using Documenter
using Literate
#using DocumenterLaTeX

function replace_includes(str)

    included = ["sphere.jl"]

    # Here the path loads the files from their proper directory,
    # which may not be the directory of the `examples.jl` file!
    path = "examples/"

    for ex in included
        content = read(path*ex, String)
        str = replace(str, "include(\"$(ex)\")" => content)
    end
    return str
end

#EXAMPLES = joinpath(@__DIR__, "..", "examples")
#OUTPUT = joinpath(@__DIR__, "src/generated")

Literate.markdown(joinpath(@__DIR__, "../examples/homogenous.jl"), joinpath(@__DIR__,"src/"); credit = false, name = "homogenous", preprocess = replace_includes)

Literate.markdown(joinpath(@__DIR__, "../examples/pointlike.jl"), joinpath(@__DIR__,"src/"); credit = false, name = "pointlike", preprocess = replace_includes)

#Literate.markdown(joinpath(@__DIR__, "../examples/droplet.jl"), joinpath(@__DIR__,"src/"); credit = false, name = "droplet")


makedocs(sitename="LaplaceBIE.jl",pages = ["index.md","homogenous.md","pointlike.md"])
#makedocs(format = DocumenterLaTeX.LaTeX(),sitename="LaplaceBIE",pages = ["index.md","homogenous.md","pointlike.md"])


#Literate.markdown("../examples/README.jl", "."; documenter=false)

deploydocs(
    repo = "github.com/akels/LaplaceBIE.jl.git",
)