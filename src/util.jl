macro mustimplement(sig)
    :($(esc(sig)) = error("must implement ", $(string(sig))))
end

@inline propertytype(x, name::Symbol) = typeof(getproperty(x, name))

argerror(s::AbstractString) = throw(ArgumentError(s))



function genpath(path::AbstractString; force::Bool = false, sep = '_')
    if force
        rm(path, force = true, recursive = true)
        return path
    elseif ispath(path)
        parts = splitpath(path)
        root = parts[1:length(parts)-1]
        base = parts[end]
        if isfile(path)
            filename, ext = splitext(base)
            f = i -> joinpath(root..., "$(filename)$(sep)$(i)$(ext)")
        elseif isdir(path)
            f = i -> joinpath(root..., "$(base)$(sep)$(i)")
        else
            error("Not a file or directory: $path")
        end
        i = 1
        while ispath(f(i))
            i += 1
        end
        return f(i)
    else
        return path
    end
end