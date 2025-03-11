package main

import (
	"fmt"
	"io/ioutil"
	"reflect"
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
	dsm.data = string(data)
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

func main() {

	var A TFExercise
	t := NewDataStorageManager("stop_words.txt")
	fmt.Println(t.data)
	A = t
	fmt.Println(A.Info())
	fmt.Println(t.Words())

	fmt.Println("Hello, World!")
}
