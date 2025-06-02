function initialize() {
  const inputTitle = document.getElementById("Title");
  const inputAddress = document.getElementById("Address");
  const inputLat = document.getElementById("Latitude");
  const inputLng = document.getElementById("Longitude");

  const options = {
    types: ["establishment"],
    componentRestrictions: { country: "JP" },
    fields: ["name", "formatted_address", "geometry"]
  };

  const autocompleteTitle = new google.maps.places.Autocomplete(inputTitle, options);
  const autocompleteAddress = new google.maps.places.Autocomplete(inputAddress, options);

  function fillInFields(place) {
    if (!place.geometry) {
      return;
    }

    inputTitle.value = place.name || "";
    inputAddress.value = place.formatted_address || "";
    inputLat.value = place.geometry.location.lat();
    inputLng.value = place.geometry.location.lng();
  }

  autocompleteTitle.addListener("place_changed", function () {
    const place = autocompleteTitle.getPlace();
    fillInFields(place);
  });

  autocompleteAddress.addListener("place_changed", function () {
    const place = autocompleteAddress.getPlace();
    fillInFields(place);
  });

  // エンター押下時にフォーム送信を防ぎ、候補選択を優先
  [inputTitle, inputAddress].forEach((input) => {
    input.addEventListener("keydown", function (event) {
      if (event.key === "Enter" && document.querySelector(".pac-item-selected")) {
        event.preventDefault();
      }
    });
  });

  // フォーム送信時に緯度経度がセットされていない場合は送信キャンセル
  const form = document.querySelector("form");
  form.addEventListener("submit", function (event) {
    if (!inputLat.value || !inputLng.value) {
      event.preventDefault();
      alert("住所は候補から選択してください");
    }
  });
}

window.initialize = initialize;
