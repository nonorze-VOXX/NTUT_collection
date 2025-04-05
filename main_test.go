package main

import "testing"

func TestTextDocument(t *testing.T) {
	bg := BaseGenerator{TextDocument{}}
	result := bg.Generate()
	expected := "Saving text document: Formatted Text: This is the raw text data."
	if result != expected {
		t.Errorf("expect: %s, result: %s", expected, result)
	}
}

func TestHTMLDocument(t *testing.T) {
	bg := BaseGenerator{HTMLDocument{}}
	result := bg.Generate()
	expected := "Saving HTML document: <div><html><body>This is raw HTML data.</body></html></div>"
	if result != expected {
		t.Errorf("expect: %s, result: %s", expected, result)
	}
}
