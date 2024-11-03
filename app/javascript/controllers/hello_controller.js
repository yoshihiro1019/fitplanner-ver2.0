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
      zoom: 15,
    });

    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const pos = {
            lat: position.coords.latitude,
            lng: position.coords.longitude,
          };
          this.map.setCenter(pos);
          this.findGyms(pos); // 現在地周辺のジムを検索
        },
        () => {
          alert("位置情報を取得できませんでした。");
        }
      );
    } else {
      alert("このブラウザでは位置情報がサポートされていません。");
    }
  }

  // 検索ボタンが押されたときの処理
  searchLocation() {
    const location = this.searchInputTarget.value;
    const geocoder = new google.maps.Geocoder();

    geocoder.geocode({ address: location }, (results, status) => {
      if (status === "OK") {
        const pos = results[0].geometry.location;
        this.map.setCenter(pos);
        this.findGyms(pos); // 入力された場所周辺のジムを検索
      } else {
        alert("場所が見つかりませんでした。");
      }
    });
  }

  // ジムを検索してマーカーを表示
  findGyms(location) {
    const service = new google.maps.places.PlacesService(this.map);
    const request = {
      location: location,
      radius: '2000', // 半径2km以内
      type: ['gym'],  // ジムの検索
    };

    service.nearbySearch(request, (results, status) => {
      if (status === google.maps.places.PlacesServiceStatus.OK) {
        results.forEach((place) => {
          new google.maps.Marker({
            position: place.geometry.location,
            map: this.map,
            title: place.name,
          });
        });
      } else {
        alert('ジムの検索に失敗しました。');
      }
    });
  }
}
