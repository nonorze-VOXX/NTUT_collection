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
	expected := "aa aa 11 "
	if result != expected {
		t.Errorf("filter_chars_and_normalize() = %v; want %v", result, expected)
	}
}

func TestScan(t *testing.T) {
	result := scan("aa aa 11")
	expected := []string{"aa", "aa", "11"}
	if len(result) != len(expected) {
		t.Fatalf("scan() length = %v; want %v", len(result), len(expected))
	}
	for i, v := range result {
		if v != expected[i] {
			t.Errorf("scan() = %v; want %v", result, expected)
			break
		}
	}
}

func TestRemoveStopWords(t *testing.T) {
	word_list := []string{"aa", "aa", "11"}
	stop_words := "aa"
	os.WriteFile("../tmp_stop_words.txt", []byte(stop_words), 0644)
	result := remove_stop_words(word_list, "../tmp_stop_words.txt")
	expected := []string{"11"}
	if len(result) != len(expected) {
		t.Fatalf("remove_stop_words() length = %v; want %v", len(result), len(expected))
	}
	for i, v := range result {
		if v != expected[i] {
			t.Errorf("remove_stop_words() = %v; want %v", result, expected)
			break
		}
	}
	os.Remove("../tmp_stop_words.txt")
}

func TestFrequencies(t *testing.T) {
	word_list := []string{"aa", "aa", "11"}
	result := frequencies(word_list)
	expected := map[string]int{"aa": 2, "11": 1}
	if len(result) != len(expected) {
		t.Fatalf("frequencies() length = %v; want %v", len(result), len(expected))
	}
	for k, v := range result {
		if v != expected[k] {
			t.Errorf("frequencies() = %v; want %v", result, expected)
			break
		}
	}
}

func TestSortFreq(t *testing.T) {
	word_freq := map[string]int{"aa": 2, "11": 1}
	result := sort_freq(word_freq)
	expected := []struct {
		Word  string
		Count int
	}{{"aa", 2}, {"11", 1}}
	if len(result) != len(expected) {
		t.Fatalf("sort_freq() length = %v; want %v", len(result), len(expected))
	}
	for i, v := range result {
		if v.Word != expected[i].Word || v.Count != expected[i].Count {
			t.Errorf("sort_freq() = %v; want %v", result, expected)
			break
		}
	}
}
