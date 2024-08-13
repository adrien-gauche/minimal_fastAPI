# Train the model
python -m model.py || { echo 'Model training failed'; exit 1; }

# Run the server in the background
fastapi dev ml_app_server.py &
FASTAPI_PID=$!

# Wait for the server to start
sleep 5

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
}' || { echo 'Server test failed'; kill $FASTAPI_PID; exit 1; }

# If the test was successful, keep the server running
wait $FASTAPI_PID
