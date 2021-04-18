### A Pluto.jl notebook ###
# v0.14.2

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

# ╔═╡ 017e361d-0770-48b5-8b46-62af5153b913
using Pkg, Images, FileIO, PlutoUI, Plots, BenchmarkTools

# ╔═╡ df281f67-3690-40ce-b02a-6436112c6a19
with_terminal() do
	Pkg.status()
end

# ╔═╡ 20a59115-5237-4b97-909f-784ea48bd1ca


# ╔═╡ 69410e25-d555-45e6-adb2-eab16cf2d98f
md"""
[Woman Wearing White Floral Off Shoulder Top](https://www.pexels.com/photo/woman-wearing-white-floral-off-shoulder-top-3653167/)

Photo by @thiszun (follow me on IG, FB) from Pexels
"""

# ╔═╡ a367fff7-407c-45de-8555-9584d68e8f2c
img = load("Woman Wearing White Floral Off Shoulder Top.jpg")

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

# ╔═╡ 86a81dca-68eb-4085-80c2-436e4e55ef6f
img_gamma_ajusted = adjust_histogram( img, GammaCorrection(gamma = exp(gamma_correction)))

# ╔═╡ dd794041-3651-45d9-b060-b112b89b15c8
function image_histogram(image)
	_, reds = build_histogram(channelview(image)[1,:,:], 64; minval=0, maxval=1)
	_, greens = build_histogram(channelview(image)[2,:,:], 64; minval=0, maxval=1)
	_, blues = build_histogram(channelview(image)[3,:,:], 64; minval=0, maxval=1)
	plot(reds, linecolor = :red, legend = false)
	plot!(greens, linecolor = :green, legend = false)
	plot!(blues, linecolor = :blue, legend = false)
end

# ╔═╡ 012fbd20-9d25-4d56-a5a8-c2f839b7b517
image_histogram(img_gamma_ajusted)

# ╔═╡ 005041e9-9458-4c8e-bb8f-af9405b1158a
@benchmark image_histogram(img)

# ╔═╡ 1672bfba-6413-4d55-9f03-9612a2151c3d


# ╔═╡ 45889ab1-d1c4-4259-ae34-9c00fa4f5be0


# ╔═╡ Cell order:
# ╠═017e361d-0770-48b5-8b46-62af5153b913
# ╠═df281f67-3690-40ce-b02a-6436112c6a19
# ╠═20a59115-5237-4b97-909f-784ea48bd1ca
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
# ╠═e5c8131d-2215-4d01-ade6-c63b50cb2c80
# ╠═012fbd20-9d25-4d56-a5a8-c2f839b7b517
# ╠═dd794041-3651-45d9-b060-b112b89b15c8
# ╠═005041e9-9458-4c8e-bb8f-af9405b1158a
# ╠═1672bfba-6413-4d55-9f03-9612a2151c3d
# ╠═45889ab1-d1c4-4259-ae34-9c00fa4f5be0
