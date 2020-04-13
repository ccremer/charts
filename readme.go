package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"text/template"
)

func main() {
	t, err := template.ParseFiles(os.Args[1])
	if err != nil {
		fmt.Println(err)
		return
	}
	f, err := os.Create(os.Args[2])
	defer f.Close()
	if err != nil {
		fmt.Println(err)
		return
	}
	files, _ := filepath.Glob("*/Chart.yaml")
	var charts []string
	for _, file := range files {
		charts = append(charts, strings.Split(file, "/")[0])
	}
	err = t.Execute(f, map[string]interface{}{
		"charts":       charts,
		"masterBranch": os.Args[3] == "true",
	})
	if err != nil {
		fmt.Println(err)
		return
	}
}
