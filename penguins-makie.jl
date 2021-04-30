### A Pluto.jl notebook ###
# v0.14.4

using Markdown
using InteractiveUtils

# ╔═╡ 1e0a6d46-a758-11eb-209f-b17c4349fa4d
begin
    import Pkg
    Pkg.activate(mktempdir())
	
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="GLMakie", version="0.2"),
        Pkg.PackageSpec(name="CairoMakie", version="0.4"),
        Pkg.PackageSpec(name="DataFrames", version="1"),
        Pkg.PackageSpec(name="Chain", version="0.4"),
        Pkg.PackageSpec(name="PalmerPenguins", version="0.1"),
    ])
	
    using PlutoUI, GLMakie, CairoMakie, DataFrames, Chain, PalmerPenguins
end

# ╔═╡ 5a547c3d-91ae-40d6-bb5b-4063663d934c
md"""
# PalmerPenguins with Makie.jl
"""

# ╔═╡ a46310e3-53d1-4bab-8b7c-b4bef16efcc9
begin
	penguins = dropmissing(DataFrame(PalmerPenguins.load()))
	first(penguins,5)
end

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


# ╔═╡ bf10c94e-5b9e-463f-9c7d-c65b237e3166
begin
	adelie_style = (
		color=(:orange,0.5),  
		strokecolor=:orange,
		label="Adelie",
		marker=:circle, 
		markersize=20
	)
	chinstrap_style = (
		color=(:slateblue1,0.5),  
		strokecolor=:slateblue1,
		label="Chinstrap", 
		marker=:utriangle, 
		markersize=20
	)
	gentoo_style = (
		color=(:turquoise3,0.5), 
		strokecolor=:turquoise3,
		label="Gentoo", 
		marker=:diamond, 
		markersize=20
	)
end

# ╔═╡ d6896864-73bd-4021-a166-d88a062a6293
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
		filter(:species => ==("Adelie"), _)
		scatter!(ax1, 
			_[!,:flipper_length_mm], _[!,:bill_length_mm];
			adelie_style...)
	end
	
	@chain penguins begin
		filter(:species => ==("Chinstrap"), _)
		scatter!(ax1, _[!,:flipper_length_mm], _[!,:bill_length_mm]; 
			chinstrap_style...)
	end
	
	@chain penguins begin
		filter(:species => ==("Gentoo"), _)
		scatter!(ax1, 
			_[!,:flipper_length_mm], _[!,:bill_length_mm]; 
			gentoo_style...)
	end

	axislegend("Species", position = :rb)
	
	fig
end

# ╔═╡ 99e9388f-147e-4c26-af83-6ee32e6a546d
let
	GLMakie.activate!()
	
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
			adelie_style...)
	end
	
	@chain penguins begin
		filter(:species => ==("Chinstrap"), _)
		scatter!(ax1, _[!,:flipper_length_mm], _[!,:bill_length_mm];
			chinstrap_style...)
	end
	
	@chain penguins begin
		filter(:species => ==("Gentoo"), _)
		scatter!(ax1, 
			_[!,:flipper_length_mm], _[!,:bill_length_mm];
			gentoo_style...)
	end

	axislegend("Species", position = :rb)
	
	fig
end

# ╔═╡ Cell order:
# ╟─5a547c3d-91ae-40d6-bb5b-4063663d934c
# ╠═1e0a6d46-a758-11eb-209f-b17c4349fa4d
# ╠═a46310e3-53d1-4bab-8b7c-b4bef16efcc9
# ╠═836fd8dd-f920-4975-a6a0-47da575b3eb7
# ╠═bf10c94e-5b9e-463f-9c7d-c65b237e3166
# ╠═d6896864-73bd-4021-a166-d88a062a6293
# ╠═99e9388f-147e-4c26-af83-6ee32e6a546d
