package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"regexp"
	"sort"
	"strings"
)

type TFExercise interface {
	Info() string
}
type DataStorageManager struct {
	TFExercise
	data string
}

type TFExerciseImpl struct{}

func (tfe TFExerciseImpl) Info() string {
	return fmt.Sprintf("%T", tfe)
}

func NewDataStorageManager(path string) DataStorageManager {
	data, err := ioutil.ReadFile(path)
	if err != nil {
		panic(err)
	}
	lower := strings.ToLower(regexp.MustCompile((`[\W_]+`)).ReplaceAllString(string(data), " "))
	return DataStorageManager{
		data:       lower,
		TFExercise: TFExerciseImpl{},
	}
}

func (dsm DataStorageManager) Info() string {
	return fmt.Sprintf("%T: My major data structure is a %T", dsm, dsm.data)
}
func (dsm DataStorageManager) Words() []string {
	return strings.Fields(dsm.data)
}

type StopWordManager struct {
	TFExercise
	stopWords []string
}

func NewStopWordManager(path string) StopWordManager {
	data, err := ioutil.ReadFile(path)
	if err != nil {
		fmt.Println("File reading error", err)
	}
	stopWords := strings.Split(string(data), ",")
	for ch := 'a'; ch <= 'z'; ch++ {
		stopWords = append(stopWords, string(ch))
	}

	swm := StopWordManager{
		stopWords:  stopWords,
		TFExercise: TFExerciseImpl{},
	}
	return swm
}
func (swm StopWordManager) Info() string {
	return fmt.Sprintf("%T: My major data structure is a %T", swm, swm.stopWords)
}

func (swm StopWordManager) IsStopWord(word string) bool {
	for _, stopWord := range swm.stopWords {
		if word == stopWord {
			return true
		}
	}
	return false
}

type WordFrequencyManager struct {
	TFExercise
	WordFreqs       map[string]int
	StopWordManager StopWordManager
}

func NewWordFrequencyManager(path string) WordFrequencyManager {
	return WordFrequencyManager{
		WordFreqs:       make(map[string]int),
		StopWordManager: NewStopWordManager(path),
		TFExercise:      TFExerciseImpl{},
	}
}

func (wfm WordFrequencyManager) IncrementCount(word string) {
	if _, ok := wfm.WordFreqs[word]; ok {
		wfm.WordFreqs[word]++
	} else {
		wfm.WordFreqs[word] = 1
	}
}

func (wfm WordFrequencyManager) Info() string {
	return fmt.Sprintf("%T: My major data structure is a %T", wfm, wfm.WordFreqs)
}

type WordFrequency struct {
	text  string
	count int
}

func (wfm WordFrequencyManager) Sorted() []WordFrequency {
	wordFreqs := []WordFrequency{}
	for word, count := range wfm.WordFreqs {
		wordFreqs = append(wordFreqs, WordFrequency{text: word, count: count})
	}
	sort.Slice(wordFreqs, func(i, j int) bool {
		return wordFreqs[i].count > wordFreqs[j].count
	})
	return wordFreqs
}

type WordFrequencyController struct {
	TFExercise
	StorageManager  DataStorageManager
	StopWordManager StopWordManager
	WordFreqManager WordFrequencyManager
}

func NewWordFrequencyController(path string) WordFrequencyController {
	return WordFrequencyController{
		StorageManager:  NewDataStorageManager(path),
		StopWordManager: NewStopWordManager("./stop_words.txt"),
		WordFreqManager: NewWordFrequencyManager(path),
		TFExercise:      TFExerciseImpl{},
	}
}

func (wfc WordFrequencyController) Run() {
	for _, word := range wfc.StorageManager.Words() {
		if !wfc.StopWordManager.IsStopWord(word) {
			wfc.WordFreqManager.IncrementCount(word)
		}
	}
	wordFreqs := wfc.WordFreqManager.Sorted()
	for _, wf := range wordFreqs[:25] {
		fmt.Println(wf.text, " - ", wf.count)
	}
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Please provide the file path as a command-line argument")
		return
	}
	path := os.Args[1]
	wfc := NewWordFrequencyController(path)
	wfc.Run()
}
