from fastapi import FastAPI
import joblib #model persistence library, running functions as pipeline jobs
import pandas as pd
from pydantic import BaseModel #data validation library
#use litserve to get parallel requests https://lightning.ai/docs/litserve/home

#https://codecut.ai/simplifying-ml-model-integration-with-fastapi/

# Create a FastAPI application instance
app = FastAPI()

# Load the pre-trained machine learning model
model = joblib.load("lr.joblib")

# Define the input data structure
class InputData(BaseModel):
    MedInc: float
    HouseAge: float
    AveRooms: float
    AveBedrms: float
    Population: float
    AveOccup: float
    Latitude: float
    Longitude: float

# Define a GET endpoint for health checks
#https://testfully.io/blog/api-health-check-monitoring/
@app.get("/")
def health_check():
    return {"status": "ok"}

# Define a POST endpoint for making predictions
@app.post("/predict/")
def predict(data: InputData):
    # Create a pandas DataFrame from the input data
    features = pd.DataFrame([data.dict()])

    # Use the model to make a prediction
    prediction = model.predict(features)[0]

    # Return the prediction as a JSON object, rounding to 2 decimal places
    return {"price": round(prediction, 2)}
