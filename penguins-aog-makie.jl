### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ f36196a2-bd8a-11eb-35d3-77b0357b31b6
begin
    import Pkg
    Pkg.activate(mktempdir())
	
    Pkg.add([
        Pkg.PackageSpec(name="PalmerPenguins", version="0.1"),
        Pkg.PackageSpec(name="DataFrames", version="1"),
        Pkg.PackageSpec(name="AlgebraOfGraphics", version="0.4"),
        Pkg.PackageSpec(name="CairoMakie", version="0.5"),
    ])
	
    using PalmerPenguins, DataFrames, AlgebraOfGraphics, CairoMakie
	set_aog_theme!()
end

# ╔═╡ 67705496-317e-45de-91a4-979ceb7696e8
md"""
# PalmerPenguins with Makie + AoG
"""

# ╔═╡ 0ccb6f75-622d-47f4-af21-d5e6da5685ad
md"""
This notebook illustrates how to plot PalmerPenguins.jl with AlgebraOfGraphics.jl and CairoMakie.jl.
"""

# ╔═╡ a75244d9-3db4-4f0e-ac6d-e21ce3d2e742
begin
	penguins = dropmissing(DataFrame(PalmerPenguins.load()))
	first(penguins, 6)
end

# ╔═╡ 5fd16e35-ffbf-42c1-8a5e-148cc82503b0
axis = (width = 800, height = 400);

# ╔═╡ af0a3aa1-4cb2-415d-96dc-9c12eb7e25cf
frequency_per_species = data(penguins) * frequency() * mapping(:species);

# ╔═╡ 57c6cc8c-aa6a-4df8-b8d3-1a01108ef574
frequency_per_island = data(penguins) * frequency() * mapping(:island);

# ╔═╡ f901fd37-2ee0-49fc-8714-a487c35cff0e
draw(frequency_per_species * mapping(color = :species, stack = :species); axis)

# ╔═╡ 23fb08de-c685-406f-a4aa-1a368d9a816a
draw(frequency_per_island * mapping(color = :island, stack = :island); axis)

# ╔═╡ 34609920-486b-43ea-82a1-2c5c6642056d
draw(frequency_per_species * mapping(color = :island, stack = :island); axis)

# ╔═╡ 59b450e8-8a99-4a29-a6d5-d36980a5e3b2
draw(frequency_per_island * mapping(color = :species, stack = :species); axis)

# ╔═╡ 134afff2-6ee9-40ff-8d88-213d67f5938d
begin
	penguin_bill = data(penguins) * mapping(:bill_length_mm, :flipper_length_mm) * mapping(color = :species)
	draw(penguin_bill; axis)
end

# ╔═╡ Cell order:
# ╟─67705496-317e-45de-91a4-979ceb7696e8
# ╟─0ccb6f75-622d-47f4-af21-d5e6da5685ad
# ╠═f36196a2-bd8a-11eb-35d3-77b0357b31b6
# ╠═a75244d9-3db4-4f0e-ac6d-e21ce3d2e742
# ╠═5fd16e35-ffbf-42c1-8a5e-148cc82503b0
# ╠═af0a3aa1-4cb2-415d-96dc-9c12eb7e25cf
# ╠═57c6cc8c-aa6a-4df8-b8d3-1a01108ef574
# ╠═f901fd37-2ee0-49fc-8714-a487c35cff0e
# ╠═23fb08de-c685-406f-a4aa-1a368d9a816a
# ╠═34609920-486b-43ea-82a1-2c5c6642056d
# ╠═59b450e8-8a99-4a29-a6d5-d36980a5e3b2
# ╠═134afff2-6ee9-40ff-8d88-213d67f5938d
