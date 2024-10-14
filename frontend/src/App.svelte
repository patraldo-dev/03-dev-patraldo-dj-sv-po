<script>
        let src = '/image.gif';
	export let name;
</script>
<img {src} alt="{name} dances." />

<main>
	<h1>¡Hola {name}!</h1>
	<p>Visit the <a href="https://dev.to/besil/my-django-svelte-setup-for-fullstack-development-3an8">My Django-Svelte setup for fullstack development</a> to learn how to build Django Svelte apps.</p>
</main>

<style>
	main {
		text-align: center;
		padding: 1em;
		max-width: 240px;
		margin: 0 auto;
	}

	h1 {
		color: #ff3e00;
		text-transform: uppercase;
		font-size: 4em;
		font-weight: 100;
	}

	@media (min-width: 640px) {
		main {
			max-width: none;
		}
	}
</style>
