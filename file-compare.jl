### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 3244173c-e227-11eb-39eb-93a74dce1c9e
using PlutoUI, PDFIO, Taro, WordTokenizers, DeepDiffs

# ╔═╡ 0f5786cb-6430-4a14-bc05-bb127f8b73df
md"""
This notebook does not work!
"""

# ╔═╡ c3353ab9-0ae1-4785-b561-631945710a35
#Taro.init()

# ╔═╡ 74f3335a-db62-49ba-8a62-84b6eebed5a2
function getPDFText(src)
    doc = pdDocOpen(src)
    docinfo = pdDocGetInfo(doc)
	result = IOBuffer()
	npage = pdDocGetPageCount(doc)
	for i=1:npage
		page = pdDocGetPage(doc, i)
		pdPageExtractText(result, page)
	end
    pdDocClose(doc)
    return docinfo, result # 
end

# ╔═╡ 9b83224c-1529-4ab7-9094-ba3b7b3fe3ba
document1 = "some.pdf"

# ╔═╡ 9318c6dc-dded-403e-8e03-f994c86027c9
document2 = "other.pdf"

# ╔═╡ cf87add1-239a-4917-b721-8482fae365f2
function readpdf(name)
	docinfo, iobuffer = getPDFText(name)
	(docinfo, String(take!(iobuffer)))
end

# ╔═╡ c71c6c25-c00a-42fc-9df7-5a28984bb69f
info1, text1 = readpdf(document1)

# ╔═╡ cb3b3dca-4712-4292-8e54-0f23dc934e38
info2, text2 = readpdf(document2)

# ╔═╡ e4055352-93a6-4b3c-9485-9869800a2ea6
tokenized_text1 = tokenize.(split_sentences(text1));

# ╔═╡ 0870f966-1242-47b0-aba9-e4f6a1f67727
tokenized_text1

# ╔═╡ eb80a7b3-de56-463b-b889-844417aefba1
tokenized_text2 = tokenize.(split_sentences(text2));


# ╔═╡ f992f24e-b6ce-43bd-a4c3-bf83dba86649
tokenized_text2

# ╔═╡ a2a5d048-6440-4d50-b81b-4a98cf08989d
deepdiff(tokenized_text1, tokenized_text2)

# ╔═╡ 71165030-3fe6-4879-89f7-d3f1ce1904b7


# ╔═╡ c102e8e6-2d8f-4582-b85c-30fdd7029be6
with_terminal() do
	print(text1)
end

# ╔═╡ 50f96bd0-21c9-4f7b-8b84-4b1425648395
with_terminal() do
	print(text2)
end

# ╔═╡ 79538987-e2bc-442c-bc75-4e9576c0ef73


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DeepDiffs = "ab62b9b5-e342-54a8-a765-a90f495de1a6"
PDFIO = "4d0d745f-9d9a-592e-8d18-1ad8a0f42b92"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Taro = "61d0e4fa-4e73-5030-88a9-ae4c27b203dd"
WordTokenizers = "796a5d58-b03d-544a-977e-18100b691f6e"

[compat]
DeepDiffs = "~1.2.0"
PDFIO = "~0.1.12"
PlutoUI = "~0.7.9"
Taro = "~0.8.3"
WordTokenizers = "~0.5.6"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractTrees]]
deps = ["Markdown", "Test"]
git-tree-sha1 = "6621d9645702c1c4e6970cc6a3eae440c768000b"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.2.1"

[[AdobeGlyphList]]
deps = ["DelimitedFiles", "Pkg", "Test"]
git-tree-sha1 = "dce62e14d1eb385ef241a05094a7bc9511a276dc"
uuid = "715cd884-8f22-55db-b077-449d1f7eef73"
version = "0.1.1"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[BinDeps]]
deps = ["Compat", "Libdl", "SHA", "URIParser"]
git-tree-sha1 = "12093ca6cdd0ee547c39b1870e0c9c3f154d9ca9"
uuid = "9e28174c-4ba2-5203-b857-d8d62c4213ee"
version = "0.8.10"

[[BinaryProvider]]
deps = ["Libdl", "Logging", "SHA"]
git-tree-sha1 = "ecdec412a9abc8db54c0efc5548c64dfce072058"
uuid = "b99e7846-7c00-51b0-8f62-c81ae34c0232"
version = "0.5.10"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "b0b7e8a0d054fada22b64095b46469627a138943"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "2.2.1"

[[DataAPI]]
git-tree-sha1 = "ee400abb2298bd13bfc3df1c412ed228061a2385"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.7.0"

[[DataDeps]]
deps = ["BinaryProvider", "HTTP", "Libdl", "Reexport", "SHA", "p7zip_jll"]
git-tree-sha1 = "4f0e41ff461d42cfc62ff0de4f1cd44c6e6b3771"
uuid = "124859b0-ceae-595e-8997-d05f6a7a8dfe"
version = "0.7.7"

[[DataStructures]]
deps = ["InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "88d48e133e6d3dd68183309877eac74393daa7eb"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.17.20"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DeepDiffs]]
git-tree-sha1 = "9824894295b62a6a4ab6adf1c7bf337b3a9ca34c"
uuid = "ab62b9b5-e342-54a8-a765-a90f495de1a6"
version = "1.2.0"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[HTML_Entities]]
deps = ["StrTables"]
git-tree-sha1 = "c4144ed3bc5f67f595622ad03c0e39fa6c70ccc7"
uuid = "7693890a-d069-55fe-a829-b4a6d304f0ee"
version = "1.0.1"

[[HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "c6a1fff2fd4b1da29d3dccaffb1e1001244d844e"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.12"

[[IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "81690084b6198a2e1da36fcfda16eeca9f9f24e4"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.1"

[[JavaCall]]
deps = ["DataStructures", "Dates", "Libdl", "WinReg"]
git-tree-sha1 = "75ec422f88cca591b379a68f85dd24dc5c037291"
uuid = "494afd89-becb-516b-aafa-70d2670c0337"
version = "0.7.7"

[[LabelNumerals]]
deps = ["RomanNumerals", "Test"]
git-tree-sha1 = "03f5757e29f13d76a93416c0b913c19bf8f9baac"
uuid = "2e475f56-4567-5c41-94ff-3f69a29378f9"
version = "0.1.0"

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

[[MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "15003dcb7d8db3c6c857fda14891a539a8f2705a"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.10+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[PDFIO]]
deps = ["AbstractTrees", "AdobeGlyphList", "BinDeps", "Dates", "DelimitedFiles", "LabelNumerals", "Libdl", "LinearAlgebra", "OpenSSL_jll", "Pkg", "Printf", "Rectangle", "RomanNumerals", "Zlib_jll"]
git-tree-sha1 = "9e793da6e602ba4440caf087adcf890485a4706f"
uuid = "4d0d745f-9d9a-592e-8d18-1ad8a0f42b92"
version = "0.1.12"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "c8abc88faa3f7a3950832ac5d6e690881590d6dc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "1.1.0"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlutoUI]]
deps = ["Base64", "Dates", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "Suppressor"]
git-tree-sha1 = "44e225d5837e2a2345e69a1d1e01ac2443ff9fcb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.9"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[Primes]]
git-tree-sha1 = "afccf037da52fa596223e5a0e331ff752e0e845c"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Rectangle]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "2bf927306e130e4718449a8b2c72a6b71afe96e0"
uuid = "9a9db56c-8f71-5460-add5-cb450131785e"
version = "0.1.2"

[[Reexport]]
git-tree-sha1 = "5f6c21241f0f655da3952fd60aa18477cf96c220"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.1.0"

[[RomanNumerals]]
deps = ["Compat", "Primes"]
git-tree-sha1 = "06e621d4a9eda8d09eab8aade41e85cb93cadae9"
uuid = "37834d88-8936-577c-80c9-1066ecf66832"
version = "0.3.1"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StrTables]]
deps = ["Dates"]
git-tree-sha1 = "5998faae8c6308acc25c25896562a1e66a3bb038"
uuid = "9700d1a9-a7c8-5760-9816-a99fda30bb8f"
version = "1.0.1"

[[Suppressor]]
git-tree-sha1 = "a819d77f31f83e5792a76081eee1ea6342ab8787"
uuid = "fd094767-a336-5f1f-9728-57cf17d0bbfb"
version = "0.2.0"

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

[[Taro]]
deps = ["Dates", "JavaCall", "Tables"]
git-tree-sha1 = "fad39fbbe8a3eb412c87d9ff85e24392b694aabc"
uuid = "61d0e4fa-4e73-5030-88a9-ae4c27b203dd"
version = "0.8.3"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[URIParser]]
deps = ["Unicode"]
git-tree-sha1 = "53a9f49546b8d2dd2e688d216421d050c9a31d0d"
uuid = "30578b45-9adc-5946-b283-645ec420af67"
version = "0.4.1"

[[URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[WinReg]]
deps = ["Test"]
git-tree-sha1 = "808380e0a0483e134081cc54150be4177959b5f4"
uuid = "1b915085-20d7-51cf-bf83-8f477d6f5128"
version = "0.3.1"

[[WordTokenizers]]
deps = ["DataDeps", "HTML_Entities", "StrTables", "Unicode"]
git-tree-sha1 = "01dd4068c638da2431269f49a5964bf42ff6c9d2"
uuid = "796a5d58-b03d-544a-977e-18100b691f6e"
version = "0.5.6"

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
# ╟─0f5786cb-6430-4a14-bc05-bb127f8b73df
# ╠═3244173c-e227-11eb-39eb-93a74dce1c9e
# ╠═c3353ab9-0ae1-4785-b561-631945710a35
# ╠═74f3335a-db62-49ba-8a62-84b6eebed5a2
# ╠═9b83224c-1529-4ab7-9094-ba3b7b3fe3ba
# ╠═9318c6dc-dded-403e-8e03-f994c86027c9
# ╠═cf87add1-239a-4917-b721-8482fae365f2
# ╠═c71c6c25-c00a-42fc-9df7-5a28984bb69f
# ╠═cb3b3dca-4712-4292-8e54-0f23dc934e38
# ╠═e4055352-93a6-4b3c-9485-9869800a2ea6
# ╠═0870f966-1242-47b0-aba9-e4f6a1f67727
# ╠═eb80a7b3-de56-463b-b889-844417aefba1
# ╠═f992f24e-b6ce-43bd-a4c3-bf83dba86649
# ╠═a2a5d048-6440-4d50-b81b-4a98cf08989d
# ╠═71165030-3fe6-4879-89f7-d3f1ce1904b7
# ╠═c102e8e6-2d8f-4582-b85c-30fdd7029be6
# ╠═50f96bd0-21c9-4f7b-8b84-4b1425648395
# ╠═79538987-e2bc-442c-bc75-4e9576c0ef73
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
