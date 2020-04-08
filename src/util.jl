macro mustimplement(sig)
    :($(esc(sig)) = error("must implement ", $(string(sig))))
end

@inline propertytype(x, name::Symbol) = typeof(getproperty(x, name))

argerror(s::AbstractString) = throw(ArgumentError(s))

function mkgoodpath(path::String; force::Bool = false, sep = '_')
    if force
        rm(path, force = true, recursive = true)
        return path
    elseif ispath(path)
        if isfile(path)
            dir, file = splitdir(path)
            file, ext = splitext(file)
            genpath = i -> joinpath(dir, "$(file)$(sep)$(i)$(ext)")
        elseif isdir(path)
            parts = splitpath(path)
            root = parts[1:length(parts)-1]
            base = parts[end]
            genpath = i -> joinpath(root..., "$(base)$(sep)$(i)")
        end
        i = 1
        while isfile(genpath(i))
            i += 1
        end
        return genpath(i)
    else
        return path
    end
end