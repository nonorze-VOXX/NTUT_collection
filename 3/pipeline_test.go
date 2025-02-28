package main

import (
	"os"
	"testing"
)

func TestReadFile(t *testing.T) {
	// Create a temporary file
	tmpfile, err := os.CreateTemp("", "example.txt")
	if err != nil {
		t.Fatal(err)
	}
	defer os.Remove(tmpfile.Name())

	// Write some data to the temporary file
	content := []byte("Hello, World!")
	if _, err := tmpfile.Write(content); err != nil {
		t.Fatal(err)
	}
	if err := tmpfile.Close(); err != nil {
		t.Fatal(err)
	}

	// Test the read_file function
	result := read_file(tmpfile.Name())
	expected := "Hello, World!"
	if result != expected {
		t.Errorf("read_file() = %v; want %v", result, expected)
	}
}

func TestFilterCharsAndNormalize(t *testing.T) {
	// Test the filter_chars_and_normalize function
	result := filter_chars_and_normalize("aa AA 11 ")
	expected := "aa aa 11"
	if result != expected {
		t.Errorf("filter_chars_and_normalize() = %v; want %v", result, expected)
	}
}
