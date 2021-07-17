### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 202da520-9e3e-406a-8185-9002574303ed
begin
    using Colors, DataFrames
end

# ╔═╡ 2bd744aa-c92a-11eb-0b7d-4fdd302c6272
begin
	# These colors are from https://allisonhorst.github.io/palmerpenguins/
	adeliecolor = colorant"#FC7808"
	chinstrapcolor = colorant"#8C00EC"
	gentoocolor = colorant"#107A78"
	originals = DataFrame(measured=[adeliecolor, chinstrapcolor, gentoocolor])
end

# ╔═╡ 0a488b60-1699-48b9-b95d-057fc4e4ffac


# ╔═╡ c8e05624-082c-4bb3-ac57-86e63e1376b9
colorant"chocolate1"

# ╔═╡ 7d1d633a-82f8-46f6-90ce-18af1e9ecfc3
colorant"#FC7808"

# ╔═╡ 1de7161b-f80a-43f9-8a4a-a960d4bf0517
DataFrame(measured=[adeliecolor, chinstrapcolor, gentoocolor])

# ╔═╡ 77fa1d35-7679-457b-bb95-cc0dbcee97ce
parse(Colorant, "DeepSkyBlue")

# ╔═╡ af118468-db14-4616-b93e-5799ec71a731


# ╔═╡ 75211344-1f60-4b3d-a4fe-04a490d32b95


# ╔═╡ 501aa5f5-e65a-46da-b5c2-b389cd0cb97a


# ╔═╡ 2de3e22e-754d-45a3-85df-8b18648b9df3


# ╔═╡ a89c9e5f-7a99-4c54-89a9-3646678715b1


# ╔═╡ 567d7650-97d0-44b5-8e54-09a84116f1f9


# ╔═╡ 67f6a601-3351-48b2-8dba-db4199a706d9


# ╔═╡ 07b6918b-1bd3-4d25-9366-a42dbee255ce


# ╔═╡ a62bcdb4-3b13-4152-b150-68afa502d7b2
function compare_colors(color_a, color_b)
    return colordiff(color_a, color_b)
end

# ╔═╡ dc3c36c5-a9a7-4582-b354-0a89a25b73d2
function getdistances(col::Color, acols)
    dists = Float64[]
    for (n, color) in enumerate(acols)
        push!(dists, compare_colors(col, color))
    end
    return sortperm(dists)
end

# ╔═╡ aea259b0-0e30-45f1-88a7-0663a908bd66
function convertcolorvalues(c)
   if typeof(c) == Tuple{Int64, Int64, Int64}
        convertedcolor = RGB{Float64}(c[1]/256, c[2]/256, c[3]/256)
   else
        convertedcolor = convert(RGB{Float64}, c)
   end
   return convertedcolor
end

# ╔═╡ c4b83cf0-5c1f-4a05-b14a-9b5480e1c4fc
namedcolnames  = collect(keys(Colors.color_names))

# ╔═╡ efb8e262-949d-4fba-a3bd-465603f6a620
namedcolvalues = map(convertcolorvalues, collect(values(Colors.color_names)))

# ╔═╡ a193eb78-91a8-49cd-b873-08e96a19b510
@show nearest10 = namedcolnames[getdistances(colorant"#FC7808", namedcolvalues)][1:10]

# ╔═╡ 4ae33a47-f8d9-46cf-83a8-df1429a4dc03
parse.(Colorant, nearest10)

# ╔═╡ 3249c965-790c-473e-981e-44fe4285d492


# ╔═╡ 1ae6176e-f881-43a6-8b6a-fa9da44b1245


# ╔═╡ 50b32008-2902-4b63-addd-65d2899121c3


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"

[compat]
Colors = "~0.12.8"
DataFrames = "~1.2.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "dc7dedc2c2aa9faf59a55c622760a25cbefbe941"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.31.0"

[[Crayons]]
git-tree-sha1 = "3f71217b538d7aaee0b69ab47d9b7724ca8afa0d"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.0.4"

[[DataAPI]]
git-tree-sha1 = "ee400abb2298bd13bfc3df1c412ed228061a2385"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.7.0"

[[DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "1dadfca11c0e08e03ab15b63aaeda55266754bad"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.2.0"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4437b64df1e0adccc3e5d1adbc3ac741095e4677"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.9"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[InvertedIndices]]
deps = ["Test"]
git-tree-sha1 = "15732c475062348b0165684ffe28e85ea8396afc"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.0.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "4ea90bd5d3985ae1f9a908bd4500ae88921c5ce7"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.0"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "cde4ce9d6f33219465b55162811d8de8139c0414"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.2.1"

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "0d1245a357cc61c8cd61934c07447aa569ff22e6"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.1.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "5f6c21241f0f655da3952fd60aa18477cf96c220"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.1.0"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "8ed4a3ea724dac32670b062be3ef1c1de6773ae8"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.4.4"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═202da520-9e3e-406a-8185-9002574303ed
# ╠═2bd744aa-c92a-11eb-0b7d-4fdd302c6272
# ╠═0a488b60-1699-48b9-b95d-057fc4e4ffac
# ╠═a193eb78-91a8-49cd-b873-08e96a19b510
# ╠═4ae33a47-f8d9-46cf-83a8-df1429a4dc03
# ╠═c8e05624-082c-4bb3-ac57-86e63e1376b9
# ╠═7d1d633a-82f8-46f6-90ce-18af1e9ecfc3
# ╠═1de7161b-f80a-43f9-8a4a-a960d4bf0517
# ╠═77fa1d35-7679-457b-bb95-cc0dbcee97ce
# ╠═af118468-db14-4616-b93e-5799ec71a731
# ╠═75211344-1f60-4b3d-a4fe-04a490d32b95
# ╠═501aa5f5-e65a-46da-b5c2-b389cd0cb97a
# ╠═2de3e22e-754d-45a3-85df-8b18648b9df3
# ╠═a89c9e5f-7a99-4c54-89a9-3646678715b1
# ╠═567d7650-97d0-44b5-8e54-09a84116f1f9
# ╠═67f6a601-3351-48b2-8dba-db4199a706d9
# ╠═07b6918b-1bd3-4d25-9366-a42dbee255ce
# ╠═a62bcdb4-3b13-4152-b150-68afa502d7b2
# ╠═dc3c36c5-a9a7-4582-b354-0a89a25b73d2
# ╠═aea259b0-0e30-45f1-88a7-0663a908bd66
# ╠═c4b83cf0-5c1f-4a05-b14a-9b5480e1c4fc
# ╠═efb8e262-949d-4fba-a3bd-465603f6a620
# ╠═3249c965-790c-473e-981e-44fe4285d492
# ╠═1ae6176e-f881-43a6-8b6a-fa9da44b1245
# ╠═50b32008-2902-4b63-addd-65d2899121c3
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
