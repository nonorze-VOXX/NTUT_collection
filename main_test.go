package main

import (
	"os"
	"testing"
)

func TestGetClassName(t *testing.T) {
	var i interface{}
	i = DataStorageManager{}
	if getClassName(i) != "DataStorageManager" {
		t.Error("Expected DataStorageManager")
	}
}

func setup(content string) string {
	// Create temporary test file
	tmpfile, err := os.CreateTemp("", "test.*.txt")
	if err != nil {
		panic(err)
	}
	if _, err := tmpfile.Write([]byte(content)); err != nil {
		panic(err)
	}
	tmpfile.Close()
	return tmpfile.Name()
}

func cleanup(filename string) {
	os.Remove(filename)
}

func TestDsmInit(t *testing.T) {
	filename := setup("This is a test")
	defer cleanup(filename)

	dsm := DataStorageManager{}
	dsm = dsm.Init(filename)
	expect := "this is a test"
	if dsm.data != expect {
		t.Error("Expected " + expect)
	}
}

func TestDsmInfo(t *testing.T) {
	filename := setup("This is a test")
	defer cleanup(filename)

	dsm := DataStorageManager{}.Init(filename)
	expect := "DataStorageManager: My major data structure is a string"
	if dsm.Info() != expect {
		t.Error("Expected " + expect)
	}
}

func TestDsmWords(t *testing.T) {
	filename := setup("This is a test")
	defer cleanup(filename)

	dsm := DataStorageManager{}.Init(filename)
	expect := []string{"this", "is", "a", "test"}
	if len(dsm.Words()) != len(expect) {
		t.Error("Expected", expect)
	}
	for i, word := range dsm.Words() {
		if word != expect[i] {
			t.Error("Expected", expect[i])
		}
	}
}
