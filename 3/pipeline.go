package main

import (
	"fmt"
	"os"
	"regexp"
	"sort"
	"strings"
)

func read_file(path string) string {
	data, err := os.ReadFile(path)
	if err != nil {
		fmt.Println("Error reading file:", err)
		os.Exit(1)
	}
	return string(data)
}

func filter_chars_and_normalize(str_data string) string {
	pattern := regexp.MustCompile(`[^\w]+`)
	return strings.ToLower(pattern.ReplaceAllString(str_data, " "))
}

func scan(str_data string) []string {
	return strings.Fields(str_data)
}

func remove_stop_words(word_list []string, path string) []string {
	stop_words_data, err := os.ReadFile(path)
	if err != nil {
		fmt.Println("Error reading stop words file:", err)
		os.Exit(1)
	}
	stop_words := strings.Split(string(stop_words_data), ",")
	stop_words = append(stop_words, strings.Split("abcdefghijklmnopqrstuvwxyz", "")...)

	filtered_words := []string{}
	for _, word := range word_list {
		if !contains(stop_words, word) {
			filtered_words = append(filtered_words, word)
		}
	}
	return filtered_words
}

func contains(slice []string, item string) bool {
	for _, s := range slice {
		if s == item {
			return true
		}
	}
	return false
}

func frequencies(word_list []string) map[string]int {
	word_freqs := make(map[string]int)
	for _, word := range word_list {
		word_freqs[word]++
	}
	return word_freqs
}

func sort_freq(word_freq map[string]int) []struct {
	Word  string
	Count int
} {
	var sorted_word_freq []struct {
		Word  string
		Count int
	}
	for word, count := range word_freq {
		sorted_word_freq = append(sorted_word_freq, struct {
			Word  string
			Count int
		}{word, count})
	}
	sort.Slice(sorted_word_freq, func(i, j int) bool {
		return sorted_word_freq[i].Count > sorted_word_freq[j].Count
	})
	return sorted_word_freq
}

func print_all(word_freqs []struct {
	Word  string
	Count int
}) {
	for _, wf := range word_freqs {
		fmt.Println(wf.Word, "-", wf.Count)
	}
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("You must provide a file path as an argument")
		os.Exit(1)
	}
	file_path := os.Args[1]
	text := read_file(file_path)
	filtered_text := filter_chars_and_normalize(text)
	words := scan(filtered_text)
	words = remove_stop_words(words, "../stop_words.txt")
	word_freqs := frequencies(words)
	sorted_word_freqs := sort_freq(word_freqs)
	print_all(sorted_word_freqs[:25])
}
