import "bootstrap";
import { loadDynamicBannerText } from '../components/banner';
import rangePlugin from 'flatpickr/dist/plugins/rangePlugin'
import flatpickr from 'flatpickr';
import 'flatpickr/dist/flatpickr.min.css'


const banner = document.getElementById('banner-typed-text')
if (banner) {
  loadDynamicBannerText();
}


flatpickr("#start_date", {
  altInput: true,
  enableTime: true,
  "plugins":[new rangePlugin({ input: "#end_date"})]
});


