import App from './App.svelte';

const app = new App({
	target: document.body,
	props: {
		name: 'mundo'
		src: '/image.gif'
	}
});

export default app;
