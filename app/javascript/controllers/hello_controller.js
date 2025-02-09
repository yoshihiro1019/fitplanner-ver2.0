import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["map"];

  connect() {
    if (!window.google || !window.google.maps) {
      this.loadGoogleMapsApi();
    } else {
      this.initMap();
    }
  }

  loadGoogleMapsApi() {
    const script = document.createElement("script");
    script.src = `https://maps.googleapis.com/maps/api/js?key=<%= Rails.application.credentials.google_maps[:api_key] %>&libraries=places&callback=initMap`;
    script.async = true;
    script.defer = true;
    window.initMap = this.initMap.bind(this);
    document.head.appendChild(script);
  }

  initMap() {
    const tokyo = { lat: 35.682839, lng: 139.759455 };
    this.map = new google.maps.Map(this.mapTarget, {
      center: tokyo,
      zoom: 13,
    });

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const pos = {
            lat: position.coords.latitude,
            lng: position.coords.longitude,
          };
          this.map.setCenter(pos);

          // ✅ **現在地マーカーのデザイン（大きめの青アイコン）**
          new google.maps.marker.AdvancedMarkerElement({
            position: pos,
            map: this.map,
            title: "現在地",
            content: `<div style="background-color: blue; color: white; padding: 10px; border-radius: 50%; font-size: 16px;">📍</div>`,
          });

          this.findGyms(pos);
        },
        () => {
          alert("位置情報を取得できませんでした。");
        }
      );
    } else {
      alert("このブラウザでは位置情報がサポートされていません。");
    }
  }

  findGyms(location) {
    console.log("ジム検索開始:", location);

    const service = new google.maps.places.PlacesService(this.map);
    const request = {
      location: location,
      radius: 5000,
      type: ["gym"],
    };

    service.nearbySearch(request, (results, status) => {
      console.log("Nearby search status:", status);
      if (status === google.maps.places.PlacesServiceStatus.OK) {
        results.forEach((place) => {
          console.log("見つかったジム:", place.name);

          // ✅ **ジムのマーカーのデザイン（緑のカスタムマーカーを適用）**
          new google.maps.marker.AdvancedMarkerElement({
            position: place.geometry.location,
            map: this.map,
            title: place.name,
            content: `<div style="background-color: green; color: white; padding: 8px; border-radius: 50%; font-size: 18px; display: flex; align-items: center; justify-content: center;">🏋️‍♂️</div>`,
          });
        });
      } else {
        console.error("ジムの検索に失敗しました:", status);
        alert("ジムの検索に失敗しました。");
      }
    });
  }
}
