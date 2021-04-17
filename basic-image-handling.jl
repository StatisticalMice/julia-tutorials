### A Pluto.jl notebook ###
# v0.14.2

using Markdown
using InteractiveUtils

# ╔═╡ 017e361d-0770-48b5-8b46-62af5153b913
using Images, FileIO

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

# ╔═╡ 2ce72842-b7ac-4ad7-8527-9793c45d83a7
let
	gray_image = Gray.(head)
	mosaicview(head, gray_image; nrow = 1)
end

# ╔═╡ ecc6aabd-a531-4248-b942-353cc015a037


# ╔═╡ 96d8cf63-78dd-46f2-8cfd-188facc01197


# ╔═╡ Cell order:
# ╠═017e361d-0770-48b5-8b46-62af5153b913
# ╠═8371ceeb-1df8-471a-8ea9-f54d14f31145
# ╠═20a59115-5237-4b97-909f-784ea48bd1ca
# ╟─69410e25-d555-45e6-adb2-eab16cf2d98f
# ╠═a367fff7-407c-45de-8555-9584d68e8f2c
# ╠═a1296b34-b033-412c-be10-7ca88faa3fdc
# ╠═2ce72842-b7ac-4ad7-8527-9793c45d83a7
# ╠═ecc6aabd-a531-4248-b942-353cc015a037
# ╠═96d8cf63-78dd-46f2-8cfd-188facc01197
