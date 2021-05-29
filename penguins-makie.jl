### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 1e0a6d46-a758-11eb-209f-b17c4349fa4d
begin
    import Pkg
    Pkg.activate(mktempdir())
	
    Pkg.add([
        Pkg.PackageSpec(name="PalmerPenguins", version="0.1"),
        Pkg.PackageSpec(name="DataFrames", version="1"),
        Pkg.PackageSpec(name="DataFramesMeta", version="0.6"),
        Pkg.PackageSpec(name="Chain", version="0.4"),
        Pkg.PackageSpec(name="CairoMakie", version="0.5"),
    ])
	
    using PalmerPenguins, DataFrames, DataFramesMeta, Chain, CairoMakie
end

# ╔═╡ 5a547c3d-91ae-40d6-bb5b-4063663d934c
md"""
# PalmerPenguins with Makie (no AoG)
"""

# ╔═╡ 5f11a9cb-8e79-4ff5-a556-7e23ffe6a9ac
md"""
This notebook illustrates how to plot PalmerPenguins.jl with a few different combinations of DataFrames.jl, DataFramesMeta.jl, Chain.jl, CairoMakie.jl.

This notebook does not use AoG.
"""

# ╔═╡ ec127dae-d2ac-42a6-9de6-948feee8c338
md"""
Get data about [palmerpenguins](https://allisonhorst.github.io/palmerpenguins/) via [PalmerPenguins.jl](https://github.com/devmotion/PalmerPenguins.jl).
"""

# ╔═╡ a46310e3-53d1-4bab-8b7c-b4bef16efcc9
begin
	penguins = dropmissing(DataFrame(PalmerPenguins.load()))
	first(penguins,6)
end

# ╔═╡ 94f1ce39-a43e-4f25-9c4c-683509861d46
md"""
Set some generic attributes for plots via themes.
"""

# ╔═╡ 836fd8dd-f920-4975-a6a0-47da575b3eb7
set_theme!(Theme(
	Axis = (
		leftspinevisible = false,
		rightspinevisible = false,
		bottomspinevisible = false,
		topspinevisible = false,
		xticksvisible = false, 
		yticksvisible = false,
	),
))

# ╔═╡ d5463461-e423-42fc-bb79-9ca68ed04715
md"""
Set some species related attributes; these will be used by splatting them on the plotting function.
"""

# ╔═╡ d650356c-9bb7-41cf-82f4-f62d1c2d0d56
style = Dict(
	"Adelie" => (
		color=(:orange,0.5),  
		strokecolor=:orange,
		label="Adelie",
		marker=:circle, 
		markersize=20
	),
	"Chinstrap" => (
		color=(:slateblue1,0.5),  
		strokecolor=:slateblue1,
		label="Chinstrap", 
		marker=:utriangle, 
		markersize=20
	),
	"Gentoo" => (
		color=(:turquoise3,0.5), 
		strokecolor=:turquoise3,
		label="Gentoo", 
		marker=:diamond, 
		markersize=20
	)
);

# ╔═╡ 0fbb46dd-b198-489a-a648-5b0468e1e6f8
md"""
Plotting one species at a time by using filter() and @chain.
"""

# ╔═╡ d6896864-73bd-4021-a166-d88a062a6293
let
	fig = Figure(resolution = (1000, 700))
	ax1 = fig[1, 1] = Axis(fig, 
		title = "Flipper and bill length",
		xlabel="Flipper length (mm)", 
		ylabel="Bill length (mm)")
	ax1.xticks = 160:10:240
	ax1.yticks = 30:5:60
	
	@chain penguins begin
		filter(:species => ==("Adelie"), _)
		scatter!(ax1, 
			_[!,:flipper_length_mm], _[!,:bill_length_mm];
			style["Adelie"]...)
	end
	
	@chain penguins begin
		filter(:species => ==("Chinstrap"), _)
		scatter!(ax1, _[!,:flipper_length_mm], _[!,:bill_length_mm]; 
			style["Chinstrap"]...)
	end
	
	@chain penguins begin
		filter(:species => ==("Gentoo"), _)
		scatter!(ax1, 
			_[!,:flipper_length_mm], _[!,:bill_length_mm]; 
			style["Gentoo"]...)
	end

	axislegend("Gentoo", position = :rb)
	
	fig
end

# ╔═╡ 623bbe9d-c73e-4390-bd17-59e1734b2e51
md"""
Plotting one species at a time by using filter() and @chain, plus using DataFramesMeta.jl.
"""

# ╔═╡ 376e46c7-8c19-41cf-b54d-5f2f749d5c69
let
	CairoMakie.activate!()
	
	fig = Figure(resolution = (1000, 700))
	ax1 = fig[1, 1] = Axis(fig, 
		title = "Flipper and bill length",
		xlabel="Flipper length (mm)", 
		ylabel="Bill length (mm)")
	ax1.xticks = 160:10:240
	ax1.yticks = 30:5:60
	
	@chain penguins begin
		@where :species .== "Adelie"
		@with scatter!(ax1, :flipper_length_mm, :bill_length_mm; style["Adelie"]...)
	end
	
	@chain penguins begin
		@where :species .== "Chinstrap"
		@with scatter!(ax1, :flipper_length_mm, :bill_length_mm;
			style["Chinstrap"]...)
	end

	@chain penguins begin
		@where :species .== "Gentoo"
		@with scatter!(ax1, :flipper_length_mm, :bill_length_mm; style["Gentoo"]...)
	end

	axislegend("Species", position = :rb)
	
	fig
end

# ╔═╡ 9f5d001f-e02c-4157-84b5-98f54528c97c
md"""
Plotting one species at a time by using groupby() to group the DataFrame by species. The output is identical.
"""

# ╔═╡ 0e3dd7e4-aa23-4a32-a127-ea22b978f2e0
let
	fig = Figure(resolution = (1000, 700))
	ax1 = fig[1, 1] = Axis(fig, 
		title = "Flipper and bill length",
		xlabel="Flipper length (mm)", 
		ylabel="Bill length (mm)")
	ax1.xticks = 160:10:240
	ax1.yticks = 30:5:60
	
	for (i, gdf) in enumerate(groupby(penguins, :species, sort = true))
    	scatter!(
			gdf.flipper_length_mm, 
			gdf.bill_length_mm; 
			style[gdf.species[1]]...
		)
	end

	axislegend("Species", position = :rb)
	
	fig
end

# ╔═╡ Cell order:
# ╟─5a547c3d-91ae-40d6-bb5b-4063663d934c
# ╟─5f11a9cb-8e79-4ff5-a556-7e23ffe6a9ac
# ╠═1e0a6d46-a758-11eb-209f-b17c4349fa4d
# ╟─ec127dae-d2ac-42a6-9de6-948feee8c338
# ╠═a46310e3-53d1-4bab-8b7c-b4bef16efcc9
# ╟─94f1ce39-a43e-4f25-9c4c-683509861d46
# ╠═836fd8dd-f920-4975-a6a0-47da575b3eb7
# ╟─d5463461-e423-42fc-bb79-9ca68ed04715
# ╠═d650356c-9bb7-41cf-82f4-f62d1c2d0d56
# ╟─0fbb46dd-b198-489a-a648-5b0468e1e6f8
# ╠═d6896864-73bd-4021-a166-d88a062a6293
# ╟─623bbe9d-c73e-4390-bd17-59e1734b2e51
# ╠═376e46c7-8c19-41cf-b54d-5f2f749d5c69
# ╟─9f5d001f-e02c-4157-84b5-98f54528c97c
# ╠═0e3dd7e4-aa23-4a32-a127-ea22b978f2e0
