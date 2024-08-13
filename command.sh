# Train the model
python -m model.py

# Run the server
fastapi dev ml_app_server.py

# Test the server
curl -X 'POST' \
  'http://127.0.0.1:8000/predict/' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "MedInc": 1.68,
  "HouseAge": 25,
  "AveRooms": 4,
  "AveBedrms": 2,
  "Population": 1400,
  "AveOccup": 3,
  "Latitude": 36.06,
  "Longitude": -119.01
}'
