using HTTP, JSON3, Profile, BenchmarkTools
using Base.Threads: @spawn

# https://juliafolds.github.io/data-parallelism/tutorials/concurrency-patterns/

umap(f, xs; kwargs...) = umap(f, Any, xs; kwargs...)
function umap(f, TY::Type, xs::Channel; ntasks = Threads.nthreads(), buffersize = ntasks)
    return Channel{TY}(buffersize) do ys
        @sync for i in 1:ntasks
            @spawn for x in xs
                put!(ys, f(i, x))
            end
        end
    end
end

function calc(nworkers = 10, nreqs = 100)
    xs = Channel{Int}(Inf)
    for _ in 1:nreqs
        put!(xs, 1)
    end
    close(xs)

    res = umap(Int, xs; ntasks = nworkers, buffersize = nreqs) do name, n
        #println("worker-$name")
        response = HTTP.request("GET", "https://qrng.anu.edu.au/API/jsonI.php?length=$(n)&type=uint16"; cookies=true, pipeline_limit = 100, reuse_limit = 100)
        json = JSON3.read(String(response.body))
        sum(json["data"])
    end

    collect(res)
end

