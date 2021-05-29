### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ a08ba54c-b0ec-4aa8-b4ba-f289a1e8a8a5
begin
    import Pkg
    Pkg.activate(mktempdir())
	
    Pkg.add([
        Pkg.PackageSpec(name="Images", version="0.24"),
        Pkg.PackageSpec(name="FileIO", version="1"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="BenchmarkTools", version="1"),
    ])
	
    using Images, FileIO, PlutoUI, Plots, BenchmarkTools
end

# ╔═╡ b389844f-72ab-47b8-bab8-f2d5c23253bc
md"""
# Basic image handling with Images.jl
"""

# ╔═╡ 69410e25-d555-45e6-adb2-eab16cf2d98f
md"""
[Woman Wearing White Floral Off Shoulder Top](https://www.pexels.com/photo/woman-wearing-white-floral-off-shoulder-top-3653167/)

Photo by @thiszun (follow me on IG, FB) from Pexels
"""

# ╔═╡ a367fff7-407c-45de-8555-9584d68e8f2c
img = load(joinpath("resources", "Woman Wearing White Floral Off Shoulder Top.jpg"))

# ╔═╡ a1296b34-b033-412c-be10-7ca88faa3fdc
head = img[700:2000, 600:1600]

# ╔═╡ 8d9c4fbf-11c7-420b-8aea-c9f50ef204aa
size(img)

# ╔═╡ 183f1ee9-7032-4ab0-b73d-d94c75a4c27b
typeof(img)

# ╔═╡ 2ce72842-b7ac-4ad7-8527-9793c45d83a7
let
	gray_image = Gray.(head)
	mosaicview(head, gray_image; nrow = 1)
end

# ╔═╡ c2e53aa1-e91f-469e-848c-67bebecaa444
mosaicview( 
	(x->RGB(x, 0, 0)).(red.(head)),
	(x->RGB(0, x, 0)).(green.(head)),
	(x->RGB(0, 0, x)).(blue.(head)) ; nrow = 1)

# ╔═╡ 79635ec3-44ec-4fdb-ab88-659cc8911877
function invert(color::AbstractRGB)
	return RGB(1.0-red(color),1.0-green(color),1.0-blue(color))
end

# ╔═╡ 9b5bccea-2f25-4c50-a69a-0e86aa061c45
invert.(img)

# ╔═╡ e5c8131d-2215-4d01-ade6-c63b50cb2c80
@bind gamma_correction Slider(-2.0:0.5:3.0, show_value=true, default = 0.0)

# ╔═╡ f9f7c010-a1f1-4569-941a-e10281d27746
function gamma_adjusted(image) 
	adjust_histogram(image, GammaCorrection(gamma = exp(gamma_correction)))
end

# ╔═╡ 86a81dca-68eb-4085-80c2-436e4e55ef6f
img_gamma_ajusted = gamma_adjusted(img)

# ╔═╡ 45889ab1-d1c4-4259-ae34-9c00fa4f5be0
function image_histogram(image)
	_, reds = build_histogram(red.(image), 64; minval=0, maxval=1)
	_, greens = build_histogram(green.(image), 64; minval=0, maxval=1)
	_, blues = build_histogram(blue.(image), 64; minval=0, maxval=1)
	plot(reds, linecolor = :red, legend = false)
	plot!(greens, linecolor = :green, legend = false)
	plot!(blues, linecolor = :blue, legend = false)
end

# ╔═╡ 012fbd20-9d25-4d56-a5a8-c2f839b7b517
image_histogram(img_gamma_ajusted)

# ╔═╡ 005041e9-9458-4c8e-bb8f-af9405b1158a
@benchmark image_histogram(img)

# ╔═╡ 1fd235d0-aee1-495b-8834-c111a7db99c0
@benchmark gamma_adjusted(img)

# ╔═╡ Cell order:
# ╟─b389844f-72ab-47b8-bab8-f2d5c23253bc
# ╠═a08ba54c-b0ec-4aa8-b4ba-f289a1e8a8a5
# ╟─69410e25-d555-45e6-adb2-eab16cf2d98f
# ╠═a367fff7-407c-45de-8555-9584d68e8f2c
# ╠═a1296b34-b033-412c-be10-7ca88faa3fdc
# ╠═8d9c4fbf-11c7-420b-8aea-c9f50ef204aa
# ╠═183f1ee9-7032-4ab0-b73d-d94c75a4c27b
# ╠═2ce72842-b7ac-4ad7-8527-9793c45d83a7
# ╠═c2e53aa1-e91f-469e-848c-67bebecaa444
# ╠═79635ec3-44ec-4fdb-ab88-659cc8911877
# ╠═9b5bccea-2f25-4c50-a69a-0e86aa061c45
# ╠═86a81dca-68eb-4085-80c2-436e4e55ef6f
# ╠═f9f7c010-a1f1-4569-941a-e10281d27746
# ╠═e5c8131d-2215-4d01-ade6-c63b50cb2c80
# ╠═012fbd20-9d25-4d56-a5a8-c2f839b7b517
# ╠═45889ab1-d1c4-4259-ae34-9c00fa4f5be0
# ╠═005041e9-9458-4c8e-bb8f-af9405b1158a
# ╠═1fd235d0-aee1-495b-8834-c111a7db99c0
