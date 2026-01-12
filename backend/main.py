import shutil
import os
import whisper
from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from transformers import pipeline

app = FastAPI(title="Demo Audio Processing API")

print("Whisper modeli yükleniyor...")
model = whisper.load_model("small")

print("İngilizce Özetleme modeli yükleniyor...")
try:
    summarizer = pipeline("summarization", model="sshleifer/distilbart-cnn-12-6")
    print("Özetleme modeli hazır!")
except Exception as e:
    print(f"Özetleme modeli yüklenirken hata: {e}")
    summarizer = None

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/health")
async def health_check():
    return {"ok": True}

@app.post("/process")
async def process_audio(audio: UploadFile = File(...)):
    if not audio:
        raise HTTPException(status_code=400, detail="Audio file is required")

    temp_filename = f"temp_{audio.filename}"
    
    try:
        # Dosyayı kaydet
        with open(temp_filename, "wb") as buffer:
            shutil.copyfileobj(audio.file, buffer)

        result = model.transcribe(temp_filename, fp16=False, language="en")
        transcribed_text = result["text"]

        summary_text = "Summary could not be generated."
        
        if summarizer and len(transcribed_text) > 50:
            try:
                summary_output = summarizer(
                    transcribed_text, 
                    max_length=130, 
                    min_length=30, 
                    do_sample=False
                )
                summary_text = summary_output[0]['summary_text']
            except Exception as e:
                summary_text = f"Error during summarization: {str(e)}"
        elif len(transcribed_text) <= 50:
             summary_text = "Text is too short to summarize."

        return {
            "success": True,
            "transcript": transcribed_text,
            "summary_text": summary_text,
            "summary_json": {}
        }

    except Exception as exc:
        return JSONResponse(
            status_code=500,
            content={"success": False, "error": str(exc)},
        )
    finally:
        if os.path.exists(temp_filename):
            os.remove(temp_filename)