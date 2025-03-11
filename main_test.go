package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"reflect"
	"strings"
	"testing"
)

// MockTFExercise for testing purposes
type MockTFExercise struct {
	info string
}

func (m MockTFExercise) Info() string {
	return m.info
}

// Helper function to create a temporary file with content
func createTempFile(t *testing.T, content string) string {
	tmpfile, err := ioutil.TempFile("", "testfile")
	if err != nil {
		t.Fatalf("Failed to create temporary file: %v", err)
	}
	defer tmpfile.Close()

	_, err = tmpfile.WriteString(content)
	if err != nil {
		t.Fatalf("Failed to write to temporary file: %v", err)
	}
	return tmpfile.Name()
}

// Helper function to create a temporary stop words file with content
func createTempStopWordsFile(t *testing.T, content string) string {
	tmpfile, err := ioutil.TempFile("", "stopwords")
	if err != nil {
		t.Fatalf("Failed to create temporary stop words file: %v", err)
	}
	defer tmpfile.Close()

	_, err = tmpfile.WriteString(content)
	if err != nil {
		t.Fatalf("Failed to write to temporary stop words file: %v", err)
	}
	return tmpfile.Name()
}

func TestDataStorageManager_NewDataStorageManager(t *testing.T) {
	content := "This is a Test. With some words!!"
	tmpFileName := createTempFile(t, content)
	defer os.Remove(tmpFileName)

	dsm := NewDataStorageManager(tmpFileName)

	expectedData := "this is a test with some words "
	if dsm.data != expectedData {
		t.Errorf("NewDataStorageManager data mismatch: got %v, want %v", dsm.data, expectedData)
	}
}

func TestDataStorageManager_Words(t *testing.T) {
	content := "This is a Test. With some words!!"
	tmpFileName := createTempFile(t, content)
	defer os.Remove(tmpFileName)

	dsm := NewDataStorageManager(tmpFileName)
	words := dsm.Words()

	expectedWords := []string{"this", "is", "a", "test", "with", "some", "words"}
	if !reflect.DeepEqual(words, expectedWords) {
		t.Errorf("Words() mismatch: got %v, want %v", words, expectedWords)
	}
}

func TestStopWordManager_NewStopWordManager(t *testing.T) {
	content := "the,a,an"
	tmpFileName := createTempStopWordsFile(t, content)
	defer os.Remove(tmpFileName)

	swm := NewStopWordManager(tmpFileName)
	//Check if stop words are loaded correctly
	if len(swm.stopWords) != 29 {
		t.Errorf("NewStopWordManager stop words count mismatch: got %v, want %v", len(swm.stopWords), 29)
	}
	//Check if alphabets are also added to stop words
	containsAllAlpha := true
	for ch := 'a'; ch <= 'z'; ch++ {
		found := false
		for _, stopWord := range swm.stopWords {
			if stopWord == string(ch) {
				found = true
				break
			}
		}
		if !found {
			containsAllAlpha = false
			break
		}
	}
	if !containsAllAlpha {
		t.Errorf("NewStopWordManager stop words missing alphabets")
	}

}

func TestStopWordManager_IsStopWord(t *testing.T) {
	content := "the,a,an"
	tmpFileName := createTempStopWordsFile(t, content)
	defer os.Remove(tmpFileName)

	swm := NewStopWordManager(tmpFileName)

	if !swm.IsStopWord("the") {
		t.Errorf("IsStopWord(\"the\") should return true")
	}
	if !swm.IsStopWord("a") {
		t.Errorf("IsStopWord(\"a\") should return true")
	}
	if swm.IsStopWord("test") {
		t.Errorf("IsStopWord(\"test\") should return false")
	}
}

func TestWordFrequencyManager_IncrementCount(t *testing.T) {
	tmpFileName := createTempStopWordsFile(t, "")
	defer os.Remove(tmpFileName)

	wfm := NewWordFrequencyManager(tmpFileName)
	wfm.IncrementCount("test")
	wfm.IncrementCount("test")
	wfm.IncrementCount("another")

	if wfm.WordFreqs["test"] != 2 {
		t.Errorf("IncrementCount(\"test\") count mismatch: got %v, want %v", wfm.WordFreqs["test"], 2)
	}
	if wfm.WordFreqs["another"] != 1 {
		t.Errorf("IncrementCount(\"another\") count mismatch: got %v, want %v", wfm.WordFreqs["another"], 1)
	}
}

func TestWordFrequencyManager_Sorted(t *testing.T) {
	tmpFileName := createTempStopWordsFile(t, "")
	defer os.Remove(tmpFileName)

	wfm := NewWordFrequencyManager(tmpFileName)
	wfm.IncrementCount("test")
	wfm.IncrementCount("test")
	wfm.IncrementCount("another")
	wfm.IncrementCount("another")
	wfm.IncrementCount("another")
	wfm.IncrementCount("word")

	sorted := wfm.Sorted()

	if len(sorted) != 3 {
		t.Errorf("Sorted() length mismatch: got %v, want %v", len(sorted), 3)
	}

	if sorted[0].text != "another" {
		t.Errorf("Sorted()[0] text mismatch: got %v, want %v", sorted[0].text, "another")
	}

	if sorted[1].text != "test" {
		t.Errorf("Sorted()[1] text mismatch: got %v, want %v", sorted[1].text, "test")
	}

	if sorted[2].text != "word" {
		t.Errorf("Sorted()[2] text mismatch: got %v, want %v", sorted[2].text, "word")
	}
}

// TestWordFrequencyController_Run tests the Run method of WordFrequencyController.
func TestWordFrequencyController_Run(t *testing.T) {
	// Create a temporary file with some content
	content := "This is a test. This is another test. the a an test test"
	tmpFileName := createTempFile(t, content)
	defer os.Remove(tmpFileName)

	// Create a temporary stop words file
	stopWordsContent := "the,a,an,is"
	tmpStopWordsFileName := createTempStopWordsFile(t, stopWordsContent)
	defer os.Remove(tmpStopWordsFileName)

	// Redirect stdout to capture the output of Run()
	oldStdout := os.Stdout
	r, w, _ := os.Pipe()
	os.Stdout = w

	// Create a new WordFrequencyController with the temporary files
	wfc := NewWordFrequencyController(tmpFileName)
	wfc.StopWordManager = NewStopWordManager(tmpStopWordsFileName)
	wfc.Run()

	// Close the writer and restore stdout
	err := w.Close()
	if err != nil {
		t.Fatalf("Failed to close writer: %v", err)
	}
	os.Stdout = oldStdout

	// Read the captured output
	out, err := ioutil.ReadAll(r)
	if err != nil {
		t.Fatalf("Failed to read from reader: %v", err)
	}

	output := string(out)

	// Define the expected output
	expectedOutput := `test  -  4
this  -  2
another  -  1
`

	// Check if the actual output matches the expected output
	expectedLines := strings.Split(expectedOutput, "\n")
	actualLines := strings.Split(output, "\n")

	// Only compare the lines that matter (up to the length of expectedLines)
	for i := 0; i < len(expectedLines)-1; i++ {
		if !strings.Contains(actualLines[i], strings.TrimSpace(expectedLines[i])) {
			t.Errorf("Line %d: Expected '%s', but got '%s'", i+1, strings.TrimSpace(expectedLines[i]), actualLines[i])
		}
	}

}

func TestDataStorageManager_Info(t *testing.T) {
	content := "Test content"
	tmpFileName := createTempFile(t, content)
	defer os.Remove(tmpFileName)

	dsm := NewDataStorageManager(tmpFileName)
	info := dsm.Info()

	expectedInfo := fmt.Sprintf("%T: My major data structure is a %T", dsm, dsm.data)
	if info != expectedInfo {
		t.Errorf("Info() mismatch: got %v, want %v", info, expectedInfo)
	}
}

func TestStopWordManager_Info(t *testing.T) {
	tmpFileName := createTempStopWordsFile(t, "")
	defer os.Remove(tmpFileName)
	swm := NewStopWordManager(tmpFileName)
	info := swm.Info()

	expectedInfo := fmt.Sprintf("%T: My major data structure is a %T", swm, swm.stopWords)
	if info != expectedInfo {
		t.Errorf("Info() mismatch: got %v, want %v", info, expectedInfo)
	}
}

func TestWordFrequencyManager_Info(t *testing.T) {
	tmpFileName := createTempStopWordsFile(t, "")
	defer os.Remove(tmpFileName)
	wfm := NewWordFrequencyManager(tmpFileName)
	info := wfm.Info()

	expectedInfo := fmt.Sprintf("%T: My major data structure is a %T", wfm, wfm.WordFreqs)
	if info != expectedInfo {
		t.Errorf("Info() mismatch: got %v, want %v", info, expectedInfo)
	}
}

func TestTFExerciseImpl_Info(t *testing.T) {
	tfe := TFExerciseImpl{}
	info := tfe.Info()
	expectedInfo := fmt.Sprintf("%T", tfe)

	if info != expectedInfo {
		t.Errorf("Info() mismatch: got %v, want %v", info, expectedInfo)
	}
}
