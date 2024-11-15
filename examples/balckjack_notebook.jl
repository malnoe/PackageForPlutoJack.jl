### A Pluto.jl notebook ###
# v0.20.0

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 608ff810-a0d9-11ef-2668-79a348c1b5b2
begin
	import Pkg
	Pkg.activate("..")
	using Vizagrams, PlutoUI, HypertextLiteral
	using PackageForPlutoJack
	game = initialize_game()
	nothing
end

# ╔═╡ 37dc8fd4-ec5b-40a8-a01b-87e2cac657d7
begin
	svgp = PackageForPlutoJack.interaction()
@bind etat @htl(
"""
<div>
	
	$(svgp)
	
	<script>
	const div = currentScript.parentElement;

	var svgelt = div.querySelector("#graph");

	svgelt.addEventListener("click", get_id, false);

	function get_id(evt) {
		div.value = evt.target.id;
		div.dispatchEvent(new CustomEvent("input"));
	}
	</script>
</div>
		
"""
)
end

# ╔═╡ f87bdb7a-3fd2-4c65-ba38-54cdafdc994f
begin
	if etat == "hit"
		turn!(game,"hit")
	elseif etat == "stand"
		turn!(game,"stand")
	elseif etat == "newgame"
		new!(game)
	end
	update_view=rand()
	draw(game)
end

# ╔═╡ 412f7f86-e375-4be5-856a-05ab7b16c93e


# ╔═╡ Cell order:
# ╠═608ff810-a0d9-11ef-2668-79a348c1b5b2
# ╠═f87bdb7a-3fd2-4c65-ba38-54cdafdc994f
# ╠═37dc8fd4-ec5b-40a8-a01b-87e2cac657d7
# ╠═412f7f86-e375-4be5-856a-05ab7b16c93e
