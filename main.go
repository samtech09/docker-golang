package main

import (
	"log"
	"net/http"
	"os"
)

func main() {
	// Configure Logging
	LOG_FILE_LOCATION := os.Getenv("LOG_FILE_LOCATION")
	if LOG_FILE_LOCATION != "" {
		f, err := os.OpenFile(LOG_FILE_LOCATION, os.O_APPEND|os.O_CREATE|os.O_RDWR, 0666)
		if err != nil {
			log.Fatal(err)
		}
		log.SetOutput(f)
		defer f.Close()
	}

	//initFileLog("app", "", true)
	port := ":8080"
	log.Println("Listening on ", port)
	http.ListenAndServe(port, loggingHandler(http.FileServer(http.Dir("./files/"))))
}

func loggingHandler(h http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Println(r.Method, r.URL.Path)
		h.ServeHTTP(w, r)
	})
}
