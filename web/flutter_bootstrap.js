{{flutter_js}}
{{flutter_build_config}}

// Manipulate the DOM to add a loading spinner which is rendered with this HTML:
// <div class="loading">
//   <div class="loader" />
// </div>
const loadingDiv = document.createElement('div');
loadingDiv.className = "loading";
document.body.appendChild(loadingDiv);
const loaderDiv = document.createElement('div');
loaderDiv.className = "loader";
loadingDiv.appendChild(loaderDiv);

_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();

    // Remove the loading spinner when the app runner is ready
    if (document.body.contains(loadingDiv)) {
      document.body.removeChild(loadingDiv);
    }
    await appRunner.runApp();
  }
});
