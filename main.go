package main

import (
	"flag"
	"io/fs"
	"io/ioutil"
	"log"
	"os"
	"path"
	"path/filepath"
	"strings"
	"text/template"

	"gopkg.in/ini.v1"
)

func main() {
	root := flag.String("in", "./db", "Input directory")
	outputRoot := flag.String("out", "./src-db", "Output directory")
	templateExt := flag.String("template", ".go", "Template file ext")
	entryFileExt := flag.String("entry", ".ini", "Entry file ext")
	outputFileExt := flag.String("ext", "", "Output file ext. Equals to template by default")

	flag.Parse()

	if *outputFileExt == "" {
		*outputFileExt = *templateExt
	}

	process(*root, *outputRoot, *templateExt, *entryFileExt, *outputFileExt)
}

func process(
	root, outputRoot, templateExt, entryFileExt, outputFileExt string,
) {
	files, err := ioutil.ReadDir(root)
	if err != nil {
		panic(err)
	}
	templatesTotal := 0
	errorsTotal := 0
	for _, file := range files {
		if file.IsDir() {
			continue
		}
		if !strings.HasSuffix(file.Name(), templateExt) {
			continue
		}

		templateName := strings.TrimSuffix(file.Name(), templateExt)
		templateRoot := path.Join(root, templateName)
		data, err := parseDirectory(templateName, templateRoot, entryFileExt)
		if err != nil {
			errorsTotal++
			log.Printf("Error parse template directory %s: %s", templateRoot, err)
			continue
		}

		templatePath := path.Join(root, file.Name())
		bytes, err := ioutil.ReadFile(templatePath)
		if err != nil {
			errorsTotal++
			log.Printf("Error read file %s: %s", templatePath, err)
			continue
		}
		template, err := template.New("template").Parse(string(bytes[:]))
		if err != nil {
			errorsTotal++
			log.Printf("Error parse template %s: %s", templatePath, err)
			continue
		}
		var outputPath = path.Join(outputRoot, templateName+outputFileExt)
		err = writeTemplate(outputPath, data, template)
		if err != nil {
			errorsTotal++
			log.Printf("Error write %s: %s", outputPath, err)
			continue
		}

		templatesTotal++
	}
	log.Printf("Done %d Errors %d", templatesTotal, errorsTotal)
}

func parseDirectory(name, path, entryFileExt string) (*TemplateData, error) {
	data := &TemplateData{
		Name: name,
	}

	err := filepath.Walk(path, func(path string, info fs.FileInfo, err error) error {
		if !strings.HasSuffix(path, entryFileExt) {
			return nil
		}
		entry := TemplateEntry{
			Name: strings.TrimSuffix(info.Name(), entryFileExt),
		}

		iniBytes, err := ioutil.ReadFile(path)
		if err != nil {
			return err
		}
		config, err := ini.Load(iniBytes)
		if err != nil {
			return err
		}
		rootSection := config.Section("")
		for _, key := range rootSection.Keys() {
			entry.Property = append(entry.Property, EntryProperty{
				Key:   key.Name(),
				Value: key.Value(),
			})
		}

		data.Entry = append(data.Entry, entry)

		return nil
	})
	if err != nil {
		return nil, err
	}

	return data, nil
}

func writeTemplate(path string, data *TemplateData, template *template.Template) error {
	f, err := os.Create(path)
	if err != nil {
		return err
	}

	template.Execute(f, data)

	err = f.Close()
	if err != nil {
		return err
	}

	return nil
}

type TemplateData struct {
	Name  string
	Entry []TemplateEntry
}

type TemplateEntry struct {
	Name     string
	Property []EntryProperty
}

type EntryProperty struct {
	Key   string
	Value string
}
