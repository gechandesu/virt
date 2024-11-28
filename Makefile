SRC_DIR ?= src
DOC_DIR ?= doc
TESTS_DIR ?= tests

all: test

test:
	v test $(TESTS_DIR)

doc:
	v doc -f html -m ./$(SRC_DIR) -o $(DOC_DIR)
	mv $(DOC_DIR)/virt.html $(DOC_DIR)/index.html || true

serve: clean doc
	v -e "import net.http.file; file.serve(folder: '$(DOC_DIR)')"

generate:
	v run gen/generate.v -header libvirt.h -by-prefix virConnect > $(SRC_DIR)/connect_generated.c.v
	v run gen/generate.v -header libvirt.h -by-prefix virDomain -not-prefix virDomainSnapshot -not-prefix virDomainCheckpoint > $(SRC_DIR)/domain_generated.c.v
	v run gen/generate.v -header virterror.h -by-prefix VIR_WAR_ -by-prefix VIR_ERR_ -by-prefix VIR_FROM_ > $(SRC_DIR)/error_generated.c.v
	v fmt -w $(SRC_DIR)

clean:
	rm -r $(DOC_DIR) || true
