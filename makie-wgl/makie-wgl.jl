### A Pluto.jl notebook ###
# v0.14.3

using Markdown
using InteractiveUtils

# ╔═╡ 2d8ffbaa-a758-11eb-0261-db4214405223
using Pkg, PlutoUI, WGLMakie, DataFrames

# ╔═╡ 6f922bb7-62cd-40e7-848f-a5896ab83b2e
begin
    using JSServe
    JSServe.Page()
end

# ╔═╡ 78f64e3f-b16d-4ec5-880b-d5c7c9562469
Pkg.project().path

# ╔═╡ b21634ef-295a-45b0-a148-b7b9f0b7f8e8
begin
	x = LinRange(0, 10, 100)
	y1 = sin.(x)
	y2 = cos.(x)
	
	scatter(x, y1, color = :red, markersize = 5)
	scatter!(x, y2, color = :blue, markersize = 10)
	current_figure()
end

# ╔═╡ aedda336-5c4b-4cf8-bf07-65cb7c0d856c


# ╔═╡ Cell order:
# ╠═6f922bb7-62cd-40e7-848f-a5896ab83b2e
# ╠═2d8ffbaa-a758-11eb-0261-db4214405223
# ╠═78f64e3f-b16d-4ec5-880b-d5c7c9562469
# ╠═b21634ef-295a-45b0-a148-b7b9f0b7f8e8
# ╠═aedda336-5c4b-4cf8-bf07-65cb7c0d856c
