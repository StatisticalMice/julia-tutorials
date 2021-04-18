### A Pluto.jl notebook ###
# v0.14.2

using Markdown
using InteractiveUtils

# ╔═╡ df281f67-3690-40ce-b02a-6436112c6a19
begin
	using Pkg;
	with_terminal() do
		Pkg.status()
	end
end

# ╔═╡ 017e361d-0770-48b5-8b46-62af5153b913
using Images, FileIO, PlutoUI

# ╔═╡ 8371ceeb-1df8-471a-8ea9-f54d14f31145


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
size(head)

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

# ╔═╡ 96d8cf63-78dd-46f2-8cfd-188facc01197
[RGB(i, j, 0) for i in 0:0.1:1, j in 0:0.1:1]

# ╔═╡ Cell order:
# ╠═df281f67-3690-40ce-b02a-6436112c6a19
# ╠═017e361d-0770-48b5-8b46-62af5153b913
# ╠═8371ceeb-1df8-471a-8ea9-f54d14f31145
# ╠═20a59115-5237-4b97-909f-784ea48bd1ca
# ╟─69410e25-d555-45e6-adb2-eab16cf2d98f
# ╠═a367fff7-407c-45de-8555-9584d68e8f2c
# ╠═a1296b34-b033-412c-be10-7ca88faa3fdc
# ╠═8d9c4fbf-11c7-420b-8aea-c9f50ef204aa
# ╠═2ce72842-b7ac-4ad7-8527-9793c45d83a7
# ╠═c2e53aa1-e91f-469e-848c-67bebecaa444
# ╠═79635ec3-44ec-4fdb-ab88-659cc8911877
# ╠═9b5bccea-2f25-4c50-a69a-0e86aa061c45
# ╠═96d8cf63-78dd-46f2-8cfd-188facc01197
