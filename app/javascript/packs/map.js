import 'mapbox-gl/dist/mapbox-gl.css'
import mapboxgl from 'mapbox-gl/dist/mapbox-gl.js';

const mapElement = document.getElementById('map');

if (mapElement) { // only build a map if there's a div#map to inject into
  mapboxgl.accessToken = "pk.eyJ1IjoiYWJvc2NoMSIsImEiOiJjam9pdGM1NmMwY3h2M3dxc2lzcWtldmxuIn0.LrstYQkq55nFyLEORNZeOw"; // API key from `.env`


  const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/abosch1/cjok0mk8l0gd72soy4outqdf5'
  });

  const markers = JSON.parse(mapElement.dataset.markers);

  // markers.forEach((marker) => {
  //   new mapboxgl.Marker()
  //   .setLngLat([marker.lng, marker.lat])
  //   .addTo(map);
  // })

  markers.forEach((marker) => {

    const el = document.createElement('div');
    el.className = 'marker';
    el.style.backgroundImage = 'url(https://res.cloudinary.com/astridbosch/image/upload/v1542378895/Group.png)';
    el.style.width = '24px';
    el.style.height = '50px';

    new mapboxgl.Marker(el)
    .setLngLat([marker.lng, marker.lat])
    .setPopup(new mapboxgl.Popup({ offset: 25 }) // add popups
    .setHTML(marker.infoWindow.content))
    .addTo(map);


    if (markers.length === 0) {
      map.setZoom(1);
    } else if (markers.length === 1) {
      map.setZoom(14);
      map.setCenter([markers[0].lng, markers[0].lat]);
    } else {
      const bounds = new mapboxgl.LngLatBounds();
      markers.forEach((marker) => {
        bounds.extend([marker.lng, marker.lat]);
      });
      map.fitBounds(bounds, { duration: 0, padding: 75 })
    }
  })
}
