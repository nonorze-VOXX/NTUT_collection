package main

import (
	"fmt"
	"io/ioutil"
	"reflect"
	"regexp"
	"strings"
)

func getClassName(i interface{}) string {
	return reflect.TypeOf(i).Name()
}

type TFExercise interface {
	Info() string
}
type DataStorageManager struct {
	super TFExercise
	data  string
}

type TFExerciseImpl struct{ child interface{} }

func (tfe TFExerciseImpl) Info() string {
	return getClassName(tfe.child)
}

func NewDataStorageManager(path string) DataStorageManager {
	dsm := DataStorageManager{}
	return dsm.Init(path)
}

func (dsm DataStorageManager) Init(path string) DataStorageManager {
	data, err := ioutil.ReadFile(path)
	if err != nil {
		fmt.Println("File reading error", err)
	}
	dsm.data = strings.ToLower(regexp.MustCompile((`[\W_]+`)).ReplaceAllString(string(data), " "))
	dsm.super = TFExerciseImpl{child: dsm}
	return dsm
}

func (dsm DataStorageManager) Info() string {
	return dsm.super.Info() +
		": My major data structure is a " +
		getClassName(dsm.data)
}
func (dsm DataStorageManager) Words() []string {
	return strings.Fields(dsm.data)
}

type StopWordManager struct {
	super     TFExercise
	stopWords []string
}

func NewStopWordManager(path string) StopWordManager {
	return StopWordManager{}.Init(path)
}
func (swm StopWordManager) Init(path string) StopWordManager {
	data, err := ioutil.ReadFile(path)
	if err != nil {
		fmt.Println("File reading error", err)
	}
	swm.stopWords = strings.Split(string(data), ",")
	for ch := 'a'; ch <= 'z'; ch++ {
		swm.stopWords = append(swm.stopWords, string(ch))
	}
	swm.super = TFExerciseImpl{child: swm}
	return swm
}

func main() {

}
