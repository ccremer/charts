package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func main() {
	level := os.Args[1]
	chart := os.Args[2]
	chartFile := chart + "/Chart.yaml"
	if !fileExists(chartFile) {
		fmt.Fprintf(os.Stdout, "File %s does not exist, skipping\n", chartFile)
		return
	}
	file, err := os.Open(chartFile)
	if err != nil {
		log.Fatal(err)
	}

	r := regexp.MustCompile("version: \"?(?P<major>\\d)\\.(?P<minor>\\d+)\\.(?P<patch>\\d+)\"?")

	// Read file
	scanner := bufio.NewScanner(file)
	var lines []string
	for scanner.Scan() {
		line := scanner.Text()
		if strings.HasPrefix(line, "version") {
			// We have found version number
			match := r.FindStringSubmatch(line)
			paramsMap := make(map[string]int)
			for i, name := range r.SubexpNames() {
				if i > 0 && i <= len(match) {
					digit, _ := strconv.Atoi(match[i])
					paramsMap[name] = digit
				}
			}
			// Lets increase it
			paramsMap[level] += 1
			switch level {
			case "minor":
				paramsMap["patch"] = 0
			case "major":
				paramsMap["patch"] = 0
				paramsMap["minor"] = 0
			}
			newVersion := fmt.Sprintf("version: %d.%d.%d", paramsMap["major"], paramsMap["minor"], paramsMap["patch"])
			fmt.Fprintf(os.Stdout, "Increasing %s to %s\n", chart, newVersion)
			lines = append(lines, newVersion)
		} else {
			lines = append(lines, line)
		}
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	file.Close()
	// Overwrite the Chart.yaml file
	file, err = os.Create(chartFile)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	for _, v := range lines {
		_, err := fmt.Fprintln(file, v)
		if err != nil {
			log.Fatal(err)
		}
	}
}

// fileExists checks if a file exists and is not a directory before we
// try using it to prevent further errors.
func fileExists(filename string) bool {
	info, err := os.Stat(filename)
	if os.IsNotExist(err) {
		return false
	} else if err != nil {
		return false
	}
	return !info.IsDir()
}
