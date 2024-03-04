package main

import (
	"log"
	"net/http"
)

func main() {
	http.Handle("/", http.FileServer(http.Dir("public/")))
	port := ":8080"
	log.Fatal(http.ListenAndServe(port, nil))
}
