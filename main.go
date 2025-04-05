package main

import "fmt"

type DocumentGenerator interface {
	PrepareData() string
	FormatContent(data string) string
	Save(content string) string
}
type BaseGenerator struct{ dg DocumentGenerator }

func (bg BaseGenerator) Generate() string {

	data := bg.dg.PrepareData()
	formatData := bg.dg.FormatContent(data)
	return bg.dg.Save(formatData)
}

type TextDocument struct{}

func (td TextDocument) PrepareData() string {
	return "This is the raw text data."
}
func (td TextDocument) FormatContent(data string) string {
	return fmt.Sprintf("Formatted Text: %s", data)
}
func (td TextDocument) Save(content string) string {
	return fmt.Sprintf("Saving text document: %s", content)
}

type HTMLDocument struct{}

func (td HTMLDocument) PrepareData() string {
	return "<html><body>This is raw HTML data.</body></html>"
}
func (td HTMLDocument) FormatContent(data string) string {
	return fmt.Sprintf("<div>%s</div>", data)
}
func (td HTMLDocument) Save(content string) string {
	return fmt.Sprintf("Saving HTML document: %s", content)
}
