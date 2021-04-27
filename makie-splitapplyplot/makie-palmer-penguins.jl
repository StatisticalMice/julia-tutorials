### A Pluto.jl notebook ###
# v0.14.3

using Markdown
using InteractiveUtils

# ╔═╡ ca5c5876-f27d-4ca0-9f0a-abae66c31929
using CSV, DataFrames, HTTP

# ╔═╡ 308026c7-b055-4478-9bbe-67bb0e3ff65a
begin
	ENV["DATADEPS_ALWAYS_ACCEPT"] = true
	using PalmerPenguins
	penguins = dropmissing(DataFrame(PalmerPenguins.load()))
end

# ╔═╡ 4c4a83eb-b5c1-402a-921a-3b2cd99eec7e
using SplitApplyPlot, CairoMakie

# ╔═╡ 467e9f67-1d7c-43f1-98b4-d26fa09c33a2
using SplitApplyPlot: density

# ╔═╡ e690586a-149d-494b-947a-71b1a336b9a4
md"""
# Tutorial
"""

# ╔═╡ da412c9e-3c78-4006-a4ca-ea822db3fea1
md"""
This is a gentle and lighthearted tutorial on how to use tools from SplitApplyPlot, using as example dataset a collection of measurements on penguins[1]. See the Palmer penguins website for more information.
"""

# ╔═╡ e4cd739b-b12c-48ec-b778-ff19ea4ac976
md"""
## Frequency plots
"""

# ╔═╡ a32252c7-e228-4c70-bbdf-f89043c8e21c
md"""
Let us start by getting a rough idea of how the data is distributed
"""

# ╔═╡ 9aaedd7b-4460-4d76-8d9d-9b67d2af3856
begin
	specs1 = data(penguins) * frequency() * mapping(:species)
	draw(specs1)
end

# ╔═╡ 4d6de4c4-7c5f-4fd1-bccb-291dce008354
md"""
Next, let us see whether the distribution is the same across islands.
"""

# ╔═╡ b67648cc-0f72-449c-80ac-715de0082eea
specs1 * mapping(color = :island) |> draw

# ╔═╡ 30145a57-9b30-4cea-81e1-a01fe17fbe1d
md"""
Ups! The bars are in the same spot and are hiding each other. We need to specify how we want to fix this. Bars can either dodge each other, or be stacked on top of each other.
"""

# ╔═╡ ddc4adba-7555-4bad-8982-64a169c110c5
specs1 * mapping(color = :island, dodge = :island) |> draw

# ╔═╡ 61aaa770-a528-4def-bc31-0653abea9f8e
md"""
This is our first finding. Adelie is the only species of penguins that can be found on all three islands. To be able to see both which species is more numerous and how different species are distributed across islands in a unique plot, we could have used stack.
"""

# ╔═╡ d52b3ccd-12af-4cc7-b7e8-e43d52a14b64
specs1 * mapping(color = :island, stack = :island) |> draw

# ╔═╡ d177a0e7-7e85-48ca-aa68-a33dc7aa9c53
md"""
## Correlating two variables
"""

# ╔═╡ 2803712e-a74c-400c-97f5-f9fa83e1afdd
md"""
Now that we have understood the distribution of these three penguin species, we can start analyzing their features.
"""

# ╔═╡ 9b7ec050-0793-4558-b1a5-4cc6ede2e0d9
begin
	specs2 = data(penguins) * mapping(:bill_length_mm, :bill_depth_mm)
	draw(specs2)
end

# ╔═╡ f8e2bf07-798a-4d2f-9e1f-5de4fa4dbfa7
md"""
We would actually prefer to visualize these measures in centimeters, and to have cleaner axes labels. As we want this setting to be preserved in all of our bill visualizations, let us save it in the variable specs.
"""

# ╔═╡ 3b2f9259-dbc3-4dc2-b64a-dd483e9bf4d0
begin
	specs3 = data(penguins) * mapping(
	    :bill_length_mm => (t -> t / 10) => "bill length (cm)",
	    :bill_depth_mm => (t -> t / 10) => "bill depth (cm)",
	)
	draw(specs3)
end

# ╔═╡ 5fb0de73-b1a9-40b8-bde7-bc4071ed5a09
md"""
Much better! Note the parentheses around the function t -> t / 10. They are necessary to specify that the function maps t to t / 10, and not to t / 10 => "bill length (cm)".

There does not seem to be a strong correlation between the two dimensions, which is odd. Maybe dividing the data by species will help.
"""

# ╔═╡ a84a5fd3-4d96-4915-ba6d-a073c3b25fcf
specs3 * mapping(color = :species) |> draw

# ╔═╡ 97bdac10-1d91-45a5-8049-b8b09a90e9bd
md"""
Ha! Within each species, penguins with a longer bill also have a deeper bill. We can confirm that with a linear regression
"""

# ╔═╡ b507634b-7019-40d9-8433-0befed74c3db
begin
	an = linear()
	specs3 * an * mapping(color = :species) |> draw
end

# ╔═╡ 444a8d61-9959-4975-8cac-f08246afaa96
md"""
This unfortunately no longer shows our data! We can use + to plot both things on top of each other:
"""

# ╔═╡ 9810c902-72b5-4432-a4dc-c868e9674e6d
specs3 * an * mapping(color = :species) + specs3 * mapping(color = :species) |> draw

# ╔═╡ 10205bce-c39a-48ad-9400-497dba2ae04a
md"""
Note that the above expression seems a bit redundant, as we wrote the same thing twice. We can "factor it out" as follows
"""

# ╔═╡ e0925c2b-0245-4286-87a8-a63f5a8d6932
specs3 * (an + mapping()) * mapping(color = :species) |> draw

# ╔═╡ d8a6b3df-5fe5-4e22-a4cb-654e4521726a
md"""
where mapping() is a neutral multiplicative element. Of course, the above could be refactored as
"""

# ╔═╡ 139b5573-5190-4f9a-90a9-45b115042579
begin
	ans = linear() + mapping()
	specs3 * ans * mapping(color = :species) |> draw
end

# ╔═╡ 98388dcf-40f2-4a5f-9943-1acb0d5412f6
md"""
We could actually take advantage of the spare mapping() and use it to pass some extra info to the scatter, while still using all the species members to compute the linear fit.
"""

# ╔═╡ 7cb131a2-1342-4bc6-9076-593b16cd66aa
begin
	ans2 = linear() + mapping(marker = :sex)
	specs3 * ans * mapping(color = :species) |> draw
end

# ╔═╡ e0a24b2d-dd8e-42e8-8bcb-bd371994fc1d
begin
	ans3 = linear() + mapping(col = :sex)
	specs3 * ans3 * mapping(color = :species) |> draw
end

# ╔═╡ c31359ab-a684-4ac1-abe5-bb33b12ffba7
md"""
## Smooth density plots
"""

# ╔═╡ 881d7327-18fa-4063-9315-4ffaaadb8086
md"""
An alternative approach to understanding the joint distribution is to consider the joint probability density distribution (pdf) of the two variables.
"""

# ╔═╡ e1ba832e-7fe3-4c46-95ae-7ec4c79b4a0d
begin
	an2 = density()
	specs3 * an2 * mapping(col = :species) |> draw
end

# ╔═╡ 862a11ed-6cbf-4150-9b76-6062c482d095
md"""
A Heatmap (the default visualization for a 2D density) is a bit unfortunate if we want to mark species by color. In that case, one can use visual to change the default visualization and, optionally, fine tune some arguments. In this case, a Wireframe with thin lines looks quite nice. (Note that, for the moment, we must specify explicitly that we require a 3D axis.)
"""

# ╔═╡ 8f33238b-f2ed-4001-9ae3-468c0b786e96
begin
	an3 = visual(Wireframe, linewidth=0.1) * density()
	plt = specs3 * an3 * mapping(color = :species)
	draw(plt, axis = (type = Axis3,))
end

# ╔═╡ ea338e75-b61a-4415-83f9-73ceda52c706
md"""
Of course, a more traditional approach would be to use a Contour plot instead:
"""

# ╔═╡ 1b3a2871-9ea6-4492-9ff9-fac8d24d594d
begin
	an4 = visual(Contour) * density()
	plt2 = specs3 * an4 * mapping(color = :species)
	draw(plt2)
end

# ╔═╡ d5b44453-212e-4aa8-95eb-cc6696321095
md"""
The data and the linear fit can also be added back to the plot:
"""

# ╔═╡ abf02a28-f6b2-4e19-9694-dc970e4069e8
begin
	ans4 = visual(Contour) * density() + linear() + mapping()
	plt3 = specs3 * ans4 * mapping(color = :species)
	draw(plt3)
end

# ╔═╡ ee71ccfc-ede2-42b6-8e93-bc6a4369fdc7
begin
	ans5 = visual(Contour, linewidth = 1.5) * density() + linear() + visual(strokecolor = :white)
	plt4 = specs3 * ans5 * mapping(color = :species)
	draw(plt4)
end

# ╔═╡ 34a8c87b-eb3a-4081-ba6f-fbacd83a6f6b
md"""
## Correlating three variables
"""

# ╔═╡ 0ee3963b-d843-4e69-8b04-400818e2e827
md"""
We are now mostly up-to-speed with bill size, but we could consider how it interacts with the weight of the penguins. For that, it may be better to use a continuous color on a gradient to denote weight, and a marker shape to denote species.
"""

# ╔═╡ 572ef732-1f66-4854-a1fb-0038b3a170ea
begin
	ans6 = linear() + mapping(color = :body_mass_g) # FIXME: colorranges do not match!!
	specs3 * ans6 * mapping(marker = :species) |> draw
end

# ╔═╡ d72609af-3486-4f7e-ac67-7761c58ab90c
md"""
Naturally, heavier penguins have bigger bills. We could also try and see the interplay of these three variables in a 3D plot.
"""

# ╔═╡ 5ba4ba3f-5472-4dc4-9ca5-9450d18e5955
begin
	specs3D = specs3 * mapping(:body_mass_g => (t -> t / 1000) => "body mass (Kg)")
	plt5 = specs3D * mapping(color = :species) * visual(Scatter) # FIXME: add default to Makie
	draw(plt5, axis = (type = Axis3,))
end

# ╔═╡ 6e517748-4556-4f9b-9663-d82c79a10c32
begin
	plt6 = specs3D * mapping(color = :species, layout = :sex) * visual(Scatter)
	draw(plt6, axis = (type = Axis3,), figure = (resolution = (1200, 400),))
end

# ╔═╡ Cell order:
# ╟─e690586a-149d-494b-947a-71b1a336b9a4
# ╟─da412c9e-3c78-4006-a4ca-ea822db3fea1
# ╠═ca5c5876-f27d-4ca0-9f0a-abae66c31929
# ╠═308026c7-b055-4478-9bbe-67bb0e3ff65a
# ╟─e4cd739b-b12c-48ec-b778-ff19ea4ac976
# ╟─a32252c7-e228-4c70-bbdf-f89043c8e21c
# ╠═4c4a83eb-b5c1-402a-921a-3b2cd99eec7e
# ╠═9aaedd7b-4460-4d76-8d9d-9b67d2af3856
# ╟─4d6de4c4-7c5f-4fd1-bccb-291dce008354
# ╠═b67648cc-0f72-449c-80ac-715de0082eea
# ╟─30145a57-9b30-4cea-81e1-a01fe17fbe1d
# ╠═ddc4adba-7555-4bad-8982-64a169c110c5
# ╟─61aaa770-a528-4def-bc31-0653abea9f8e
# ╠═d52b3ccd-12af-4cc7-b7e8-e43d52a14b64
# ╟─d177a0e7-7e85-48ca-aa68-a33dc7aa9c53
# ╟─2803712e-a74c-400c-97f5-f9fa83e1afdd
# ╠═9b7ec050-0793-4558-b1a5-4cc6ede2e0d9
# ╟─f8e2bf07-798a-4d2f-9e1f-5de4fa4dbfa7
# ╠═3b2f9259-dbc3-4dc2-b64a-dd483e9bf4d0
# ╟─5fb0de73-b1a9-40b8-bde7-bc4071ed5a09
# ╠═a84a5fd3-4d96-4915-ba6d-a073c3b25fcf
# ╟─97bdac10-1d91-45a5-8049-b8b09a90e9bd
# ╠═b507634b-7019-40d9-8433-0befed74c3db
# ╟─444a8d61-9959-4975-8cac-f08246afaa96
# ╠═9810c902-72b5-4432-a4dc-c868e9674e6d
# ╟─10205bce-c39a-48ad-9400-497dba2ae04a
# ╠═e0925c2b-0245-4286-87a8-a63f5a8d6932
# ╟─d8a6b3df-5fe5-4e22-a4cb-654e4521726a
# ╠═139b5573-5190-4f9a-90a9-45b115042579
# ╟─98388dcf-40f2-4a5f-9943-1acb0d5412f6
# ╠═7cb131a2-1342-4bc6-9076-593b16cd66aa
# ╠═e0a24b2d-dd8e-42e8-8bcb-bd371994fc1d
# ╟─c31359ab-a684-4ac1-abe5-bb33b12ffba7
# ╟─881d7327-18fa-4063-9315-4ffaaadb8086
# ╠═467e9f67-1d7c-43f1-98b4-d26fa09c33a2
# ╠═e1ba832e-7fe3-4c46-95ae-7ec4c79b4a0d
# ╟─862a11ed-6cbf-4150-9b76-6062c482d095
# ╠═8f33238b-f2ed-4001-9ae3-468c0b786e96
# ╟─ea338e75-b61a-4415-83f9-73ceda52c706
# ╠═1b3a2871-9ea6-4492-9ff9-fac8d24d594d
# ╟─d5b44453-212e-4aa8-95eb-cc6696321095
# ╠═abf02a28-f6b2-4e19-9694-dc970e4069e8
# ╠═ee71ccfc-ede2-42b6-8e93-bc6a4369fdc7
# ╟─34a8c87b-eb3a-4081-ba6f-fbacd83a6f6b
# ╟─0ee3963b-d843-4e69-8b04-400818e2e827
# ╠═572ef732-1f66-4854-a1fb-0038b3a170ea
# ╟─d72609af-3486-4f7e-ac67-7761c58ab90c
# ╠═5ba4ba3f-5472-4dc4-9ca5-9450d18e5955
# ╠═6e517748-4556-4f9b-9663-d82c79a10c32
