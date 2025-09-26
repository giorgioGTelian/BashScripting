import speech_recognition as sr

# Percorso del file audio caricato
audio_path = "/mnt/data/WhatsApp Ptt 2025-09-26 at 11.01.15.ogg"

# Inizializza il recognizer
recognizer = sr.Recognizer()

# Carica e converte l'audio
with sr.AudioFile(audio_path) as source:
    audio_data = recognizer.record(source)

# Trascrizione con Google Web Speech API (offline no, ma speech_recognition gestisce con la connessione)
try:
    text = recognizer.recognize_google(audio_data, language="it-IT")
except Exception as e:
    text = f"Errore nella trascrizione: {e}"

text
