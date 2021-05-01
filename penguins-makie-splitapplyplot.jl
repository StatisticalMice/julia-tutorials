### A Pluto.jl notebook ###
# v0.14.4

using Markdown
using InteractiveUtils

# ╔═╡ 76b92aaa-1bff-49d0-9f8b-f5e60c55e662
begin
    import Pkg
    Pkg.activate(mktempdir())
	
    Pkg.add([
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="GLMakie", version="0.2"),
        Pkg.PackageSpec(name="CairoMakie", version="0.4"),
        Pkg.PackageSpec(name="DataFrames", version="1"),
        Pkg.PackageSpec(name="DataFramesMeta", version="0.6"),
        Pkg.PackageSpec(name="Chain", version="0.4"),
        Pkg.PackageSpec(name="PalmerPenguins", version="0.1"),
        Pkg.PackageSpec(url="https://github.com/piever/SplitApplyPlot.jl", rev="master"),
    ])
	
    using PlutoUI, GLMakie, CairoMakie, DataFrames, Chain, PalmerPenguins, DataFramesMeta, SplitApplyPlot
end

# ╔═╡ 768cb6fc-aa6b-11eb-1e79-85d2c9e13698
md"""
# PalmerPenguins with Makie.jl  
# with SplitApplyPlot.jl
"""

# ╔═╡ 172e5f36-6aab-47fe-a610-31dae1c8c7c1
md"""
This notebook illustrates how to plot PalmerPenguins with a few different combinations of SplitApplyPlot.jl, DataFrames.jl, GLMakie.jl, CairoMakie.jl, Chain.jl, DataFramesMeta.jl.
"""

# ╔═╡ 00a03fd2-735a-44f7-90e3-f22d48425ba7
begin
	penguins = dropmissing(DataFrame(PalmerPenguins.load()))
	first(penguins,5)
end

# ╔═╡ 976574de-a0c0-4af0-83b5-2ad4cad47b13
my_palettes = (
			color = [(:orange,0.6), (:slateblue1,0.6), (:turquoise3,0.6)], 
			strokecolor = [:orange, :slateblue1, :turquoise3], 
			marker = [:circle, :utriangle, :diamond]);

# ╔═╡ 9d30da6a-4f3a-4f1b-969a-cef869ad1cc2
@chain penguins begin
	data 
	_ * mapping(:flipper_length_mm, :bill_length_mm)
	_ * mapping(color = :species, marker = :species, strokecolor = :species)
	_ * visual(Scatter, markersize = 20)
	draw(palettes = my_palettes)
end

# ╔═╡ 5ea4216a-63c3-4311-ab31-8c58df7d6045
@chain penguins begin
	data 
	_ * mapping(:flipper_length_mm, :bill_length_mm)
	_ * mapping(color = :species, marker = :species, strokecolor = :species)
	@aside linear_fit = _ * linear()
	_ + linear_fit
	_ * visual(Scatter, markersize = 20)
	draw(palettes = my_palettes)
end

# ╔═╡ 1feeef45-1e1f-4aab-9ce0-0fd81f98707f
@chain penguins begin
	data 
	_ * mapping(:flipper_length_mm, :bill_length_mm)
	_ * mapping(color = :species, marker = :species, strokecolor = :species)
	_ * mapping(layout = :island)
	_ * visual(Scatter, markersize = 10)
	draw(palettes = my_palettes)
end

# ╔═╡ 5724cd67-9cef-44c9-9071-904bb87019df
@chain penguins begin
	data 
	_ * mapping(:flipper_length_mm, :bill_length_mm)
	_ * mapping(color = :species, marker = :species, strokecolor = :species)
	@aside linear_fit2 = _ * linear()
	_ + linear_fit2
	_ * visual(Scatter, markersize = 10)
	_ * mapping(layout = :island)
	draw(palettes = my_palettes)
end

# ╔═╡ Cell order:
# ╟─768cb6fc-aa6b-11eb-1e79-85d2c9e13698
# ╟─172e5f36-6aab-47fe-a610-31dae1c8c7c1
# ╠═76b92aaa-1bff-49d0-9f8b-f5e60c55e662
# ╠═00a03fd2-735a-44f7-90e3-f22d48425ba7
# ╠═976574de-a0c0-4af0-83b5-2ad4cad47b13
# ╠═9d30da6a-4f3a-4f1b-969a-cef869ad1cc2
# ╠═5ea4216a-63c3-4311-ab31-8c58df7d6045
# ╠═1feeef45-1e1f-4aab-9ce0-0fd81f98707f
# ╠═5724cd67-9cef-44c9-9071-904bb87019df
