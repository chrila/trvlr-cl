import L from 'leaflet';
import GestureHandling from "leaflet-gesture-handling";

import 'leaflet/dist/leaflet.css'
import 'leaflet-defaulticon-compatibility/dist/leaflet-defaulticon-compatibility.webpack.css'
import 'leaflet-gesture-handling/dist/leaflet-gesture-handling.css';
import 'leaflet-defaulticon-compatibility';

L.Map.addInitHook("addHandler", "gestureHandling", GestureHandling);
